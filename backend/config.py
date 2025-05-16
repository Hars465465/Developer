from pydantic_settings import BaseSettings, SettingsConfigDict
from dotenv import load_dotenv

load_dotenv()  # optional if you also have a .env file


class Settings(BaseSettings):
    TAVILY_API_KEY: str
    GEMINI_API_KEY: str

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")
