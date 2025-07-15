# Этап сборки
FROM golang:1.24.3 AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go-модули и загружаем зависимости
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Копируем весь исходный код
COPY . ./

# Собираем бинарник
RUN go build -o passwordManager .

# Этап исполнения (минимальный образ)
FROM alpine:latest

# Устанавливаем рабочую директорию
WORKDIR /root/

# Копируем бинарник из стадии сборки
COPY --from=builder /app/passwordManager .

# Устанавливаем переменную окружения (если нужно)
# ENV ENCRYPTION_KEY=your-secret-key

# Указываем команду запуска
CMD ["./passwordManager"]