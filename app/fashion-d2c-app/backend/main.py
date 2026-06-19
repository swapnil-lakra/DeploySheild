from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import products   # because routers folder is in same directory as main.py
from database import engine, Base
import asyncio

from datetime import datetime

async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

app = FastAPI(title="D2C Fashion API")
#"http://localhost:3000" 
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(products.router)

@app.on_event("startup")
async def startup():
    await init_db()

@app.get("/")
async def root():
    return {"message": "Welcome to D2C Fashion API"}

@app.get("/health")
def health_check():
    return {
        "status" : "healthy",
        "timestamp" : datetime.now().isoformat()
    }