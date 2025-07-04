# Define a imagem base. `alpine` é uma versão leve, ótima para produção.
FROM python:3.13.5-alpine3.22

# Define variáveis de ambiente para otimizar a execução do Python em contêineres.
# PYTHONDONTWRITEBYTECODE: Impede o Python de criar arquivos .pyc.
# PYTHONUNBUFFERED: Garante que os logs da aplicação sejam enviados diretamente para o terminal.
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências e instala os pacotes.
# Fazer isso em um passo separado aproveita o cache do Docker.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner.
EXPOSE 8000

# Define o comando para iniciar a aplicação com Uvicorn.
# O host `0.0.0.0` é necessário para que a aplicação seja acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
