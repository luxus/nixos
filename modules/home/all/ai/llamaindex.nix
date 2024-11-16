{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (python312.withPackages (
      ps: with ps; [
        llama-index-core
        llama-index-llms-openai
        llama-index-program-openai
        llama-index-readers-file
        llama-index-embeddings-openai
      ]
    ))
  ];
}
