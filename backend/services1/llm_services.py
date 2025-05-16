import google.generativeai as genai
from config import Settings

settings = Settings()

class LLMService:
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model = genai.GenerativeModel("gemini-2.0-flash-exp")

    def generate_response(self, query: str, search_results: list[dict]):
        try:
            context_text = "\n\n".join(
                [
                    f"Source {i+1} ({result['url']}):\n{result['content']}"
                    for i, result in enumerate(search_results)
                ]
            )

            full_prompt = f"""
The following is a list of resources from web search related to a software project:

{context_text}

The student's query is:
{query}

You are an AI mentor. Use the above sources as technical documentation and learning materials to:
- Explain the project step-by-step.
- Guide the student on how to implement it.
- Cite relevant resources (from the sources above) as official docs, tutorials, or setup guides.

Avoid using external knowledge unless necessary. Always refer to the context provided.
"""

            response = self.model.generate_content(full_prompt, stream=True)

            for chunk in response:
                yield chunk.text

        except Exception as e:
            print(f"[LLM ERROR] {e}")
            yield f"**Error:** Failed to generate answer. ({str(e)})"

    def mentor_response(self, project_info: dict):
        full_prompt = f"""
You are an expert AI project mentor.

A student is building the following project:

Title: {project_info['title']}
Description: {project_info['description']}
Domain: {project_info['domain']}
Difficulty: {project_info['difficulty']}
Technologies: {project_info['tech_stack']}

Start mentoring the student step-by-step on how to build this project.
Begin with Step 1, and explain what they should do clearly. Include helpful code snippets where needed.
"""

        try:
            response = self.model.generate_content(full_prompt, stream=True)

            for chunk in response:
                yield chunk.text

        except Exception as e:
            print(f"[LLM ERROR] {e}")
            yield f"**Error:** Failed to generate answer. ({str(e)})"
