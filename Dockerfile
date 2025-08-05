FROM python:3.10-slim

# Instala dependencias del sistema + torch CPU
RUN apt update && apt install -y git wget libgl1 libglib2.0-0 && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Establece el directorio de trabajo
WORKDIR /app

# Clona el repositorio oficial
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git .

# Instala resto de dependencias (excepto torch)
RUN pip install --upgrade pip && pip install -r requirements.txt

# Ejecuta el servidor en modo CPU friendly
CMD ["python", "launch.py", "--listen", "--port", "7860", "--medvram", "--skip-torch-cuda-test", "--no-half"]
