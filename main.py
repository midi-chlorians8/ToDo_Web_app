from fastapi import FastAPI
from pydantic import BaseModel


class Item(BaseModel):
    name: str
    # description: str | None = None
    price: float
    # tax: float | None = None


app = FastAPI()

# Блок кода чтобы считать с сервера
@app.get("/users/{user_id}")
async def read_user(user_id: str):
    return {"user_id": user_id}

# Блок кода чтобы отправить на сервер
@app.post("/items/")
async def create_item(item: Item):
    return item

