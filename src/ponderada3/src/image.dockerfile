# Usar uma imagem base oficial do Python
FROM python:3.9-slim

# Definir o diretório de trabalho no container
WORKDIR /app

# Copiar os arquivos necessários
COPY requirements.txt ./
COPY image.py ./

# Instalar as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Informar a porta que será exposta pelo container
EXPOSE 8000

# Comando para executar a aplicação
CMD ["uvicorn", "image:app", "--host", "0.0.0.0", "--port", "8000"]
