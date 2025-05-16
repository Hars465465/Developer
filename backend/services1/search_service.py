from config import Settings
from tavily import TavilyClient
import trafilatura

settings = Settings()
tavily_client = TavilyClient(api_key=settings.TAVILY_API_KEY)

class SearchService:
    def web_search(self, query: str):
        try:
            results = []
            response = tavily_client.search(query, max_results=10)

            search_results = response.get("results", [])
            if not search_results:
                print(f"No search results found for query: {query}")
                return []  # Return empty list if no results

            for result in search_results:
                downloaded = trafilatura.fetch_url(result.get("url"))
                if downloaded:
                    content = trafilatura.extract(downloaded, include_comments=False)
                else:
                    content = ""

                results.append(
                    {
                        "title": result.get("title", ""),
                        "url": result.get("url", ""),
                        "content": content or "",
                    }
                )

            return results

        except Exception as e:
            print(f"[SearchService ERROR] {e}")
            return []  # Return empty list on error to avoid server crash
