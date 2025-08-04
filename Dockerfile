FROM python:3.10-slim

# Instala dependencias básicas del sistema
RUN apt update && apt install -y git wget libgl1 libglib2.0-0 && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Establece el directorio de trabajo
WORKDIR /app

# Clona el repositorio de AUTOMATIC1111
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git .

# Instala las dependencias de Python
RUN pip install --upgrade pip && pip install -r requirements.txt

# Comando para arrancar el servidor
CMD ["python", "launch.py", "--listen", "--port", "7860", "--medvram"]
