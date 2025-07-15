# Имя бинарного файла
APP_NAME = passwordManager

# Путь к исходному коду (если нужен)
SRC = .

# Цель по умолчанию — сборка для Windows
default: build-windows

# Проверка форматирования и статического анализа
check:
	go fmt ./...
	go vet ./...

# Сборка под Windows
build-windows: check
	GOOS=windows GOARCH=amd64 go build -o $(APP_NAME).exe $(SRC)

# Сборка под Linux
build-linux: check
	GOOS=linux GOARCH=amd64 go build -o $(APP_NAME) $(SRC)

# Очистка скомпилированных файлов
clean:
	rm -f $(APP_NAME) $(APP_NAME).exe
