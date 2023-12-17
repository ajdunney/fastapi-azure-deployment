import os
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"message": "This is the root path"}


@app.get("/hello")
def root():
    service_version = os.environ.get("SERVICE_VERSION", "NULL")
    return {
        "message": f"Hello World!!! from Service Version: {service_version}"
        }
