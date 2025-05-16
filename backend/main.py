import asyncio
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from services1.search_service import SearchService
from services1.sort_source_services import SortSourceService
from services1.llm_services import LLMService
from pydantic_model1.chat_body import ChatBody
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Or specific domains
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

search_service = SearchService()
sort_source_service = SortSourceService()
llm_service = LLMService()


@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        # Receive the initial query from the client
        data = await websocket.receive_json()
        query = data.get("query")

        if not query:
            await websocket.send_json({"type": "error", "data": "Query not found"})
            return

        print(f"Received query: {query}")

        # Perform search and sort in background threads
        search_results = await asyncio.to_thread(search_service.web_search, query)
        print(f"Search results: {search_results}")

        sorted_results = await asyncio.to_thread(
            sort_source_service.sort_sources, query, search_results
        )
        print(f"Sorted results: {sorted_results}")

        # Send sorted results to frontend
        await websocket.send_json({"type": "search_result", "data": sorted_results})

        # Stream LLM response chunks
        async def send_chunks():
            for chunk in llm_service.generate_response(query, sorted_results):
                print(f"Sending chunk: {chunk}")
                await websocket.send_json({"type": "content", "data": chunk})

        await send_chunks()

    except WebSocketDisconnect:
        print("WebSocket disconnected")
    except Exception as e:
        print(f"Unexpected error occurred: {e}")
        try:
            await websocket.send_json({"type": "error", "data": str(e)})
        except:
            pass  # Socket might already be closed


@app.post("/chat")
def chat_endpoint(body: ChatBody):
    search_results = search_service.web_search(body.query)
    sorted_results = sort_source_service.sort_sources(body.query, search_results)

    # Return as a single string (not streamed) for POST requests
    return {
        "response": "".join([chunk for chunk in llm_service.generate_response(body.query, sorted_results)])
    }
