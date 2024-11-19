{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (python312.withPackages (
      ps: with ps; [
        llama-index-core
        llama-index-program-openai
        llama-index-llms-openai
        llama-index-llms-openai-like
        llama-index-llms-ollama
        llama-index-embeddings-openai
        llama-index-embeddings-ollama
        llama-index-embeddings-huggingface
        llama-index-readers-file
        llama-index-readers-json
        llama-index-readers-database
        llama-index-vector-stores-qdrant
        llama-index-vector-stores-chroma
        pathtools
      ]
    ))
  ];
}
