package com.example.springai.service;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.chat.prompt.PromptTemplate;
import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.stereotype.Service;

@Service
public class AiService {

    private final ChatClient chatClient;

    public AiService(OpenAiChatModel chatModel) {
        this.chatClient = ChatClient.create(chatModel);
    }

    public String chat(String userMessage) {
        return chatClient.prompt()
                .user(userMessage)
                .call()
                .content();
    }

    public String generateAnswer(String question) {
        String template = """
                You are a helpful assistant. Answer the following question concisely.

                Question: {question}
                """;

        PromptTemplate promptTemplate = new PromptTemplate(template);
        Prompt prompt = promptTemplate.create(java.util.Map.of("question", question));

        return chatClient.prompt(prompt)
                .call()
                .content();
    }

    public String translateText(String text, String targetLanguage) {
        String message = String.format(
                "Translate the following text to %s:\n\n%s",
                targetLanguage, text
        );

        return chatClient.prompt()
                .user(message)
                .call()
                .content();
    }
}
