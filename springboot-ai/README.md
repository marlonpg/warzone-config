# Spring AI Proof of Concept

A simple Spring Boot application demonstrating Spring AI integration with OpenAI's ChatGPT API.

## Features

- **Chat Endpoint**: Send messages and get AI-powered responses
- **Question Answering**: Ask structured questions with prompt templates
- **Translation**: Translate text to different languages
- **Health Check**: Simple endpoint to verify the application is running

## Prerequisites

- Java 17 or higher
- Maven 3.6+
- OpenAI API key (get one at https://platform.openai.com/api-keys)

## Setup

### 1. Clone the repository
```bash
cd springboot-ai
```

### 2. Set your OpenAI API key
```bash
# On Windows (PowerShell)
$env:OPENAI_API_KEY = "your-actual-api-key"

# On macOS/Linux
export OPENAI_API_KEY="your-actual-api-key"
```

### 3. Build the project
```bash
mvn clean package
```

### 4. Run the application
```bash
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

## API Endpoints

### 1. Chat Endpoint
**POST** `/api/ai/chat`

Request:
```json
{
  "message": "Hello, how are you?"
}
```

Response:
```json
{
  "response": "I'm doing well, thank you for asking! How can I help you today?"
}
```

### 2. Question Answering Endpoint
**POST** `/api/ai/ask`

Request:
```json
{
  "question": "What is the capital of France?"
}
```

Response:
```json
{
  "answer": "The capital of France is Paris."
}
```

### 3. Translation Endpoint
**POST** `/api/ai/translate`

Request:
```json
{
  "text": "Hello, how are you?",
  "language": "Spanish"
}
```

Response:
```json
{
  "translated": "Hola, ¿cómo estás?"
}
```

### 4. Health Check
**GET** `/api/ai/health`

Response:
```json
{
  "status": "OK"
}
```

## Testing with cURL

```bash
# Chat
curl -X POST http://localhost:8080/api/ai/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"What is AI?"}'

# Ask
curl -X POST http://localhost:8080/api/ai/ask \
  -H "Content-Type: application/json" \
  -d '{"question":"Explain machine learning in one sentence"}'

# Translate
curl -X POST http://localhost:8080/api/ai/translate \
  -H "Content-Type: application/json" \
  -d '{"text":"Good morning","language":"German"}'

# Health
curl http://localhost:8080/api/ai/health
```

## Project Structure

```
springboot-ai/
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/com/example/springai/
        │   ├── SpringAiApplication.java
        │   ├── controller/
        │   │   └── AiController.java
        │   └── service/
        │       └── AiService.java
        └── resources/
            └── application.yml
```

## Dependencies

- **Spring Boot 3.2.0**: Framework for building Java applications
- **Spring AI 1.0.0-M1**: AI integration library
- **Spring AI OpenAI Starter**: OpenAI integration
- **Lombok**: Reduce boilerplate code (optional)

## Configuration

Edit `src/main/resources/application.yml` to customize:
- Model selection (default: gpt-4o-mini)
- Temperature (0.0 = deterministic, 1.0 = creative)
- API key (via environment variable or config file)

## Next Steps

To extend this POC:

1. **Add Vector Store**: Integrate with embeddings for RAG (Retrieval-Augmented Generation)
2. **Add Function Calling**: Let AI call external APIs
3. **Add Memory**: Maintain conversation history
4. **Add Streaming**: Stream responses for real-time updates
5. **Add Error Handling**: Robust exception handling
6. **Add Authentication**: Secure your endpoints

## Resources

- [Spring AI Documentation](https://spring.io/projects/spring-ai)
- [OpenAI API Documentation](https://platform.openai.com/docs)
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
