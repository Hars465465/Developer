from typing import List
from sentence_transformers import SentenceTransformer
import numpy as np


class SortSourceService:
    def __init__(self):
        self.embedding_model = SentenceTransformer("all-miniLM-L6-v2")

    def sort_sources(self, query: str, search_results: List[dict]):
        try:
            relevant_docs = []
            query_embedding = self.embedding_model.encode(query)

            for res in search_results:
                res_embedding = self.embedding_model.encode(res["content"])

                similarity = float(
                    np.dot(query_embedding, res_embedding)
                    / (np.linalg.norm(query_embedding) * np.linalg.norm(res_embedding))
                )

                res["relevance_score"] = similarity

                # Ensure the document has a title and URL (this was missing)
                if "url" not in res:
                    res["url"] = "No URL available"  # Set a default if missing
                if "title" not in res:
                    res["title"] = "No title available"  # Set a default if missing

                # Append relevant docs based on similarity threshold
                if similarity > 0.3:
                    relevant_docs.append(res)

            # Sort based on relevance score
            sorted_docs = sorted(
                relevant_docs, key=lambda x: x["relevance_score"], reverse=True
            )

            return sorted_docs  # Now includes title, url, and relevance_score
        except Exception as e:
            print("Error while sorting sources:", e)
            return []
