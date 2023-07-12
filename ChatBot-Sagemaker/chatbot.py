import gradio as gr
import sagemaker
from sagemaker import image_uris
import boto3
import os
import time
import json

sm_client = boto3.client("sagemaker")
smr_client = boto3.client("sagemaker-runtime")
endpoint_name = "chatglm2-2023-07-08-12-54-16-247-endpoint"
# hyperparameters for llm
parameters = {
    "max_length": 2048,
    "temperature": 0.01,
    "num_beams": 1,  # >1可能会报错，"probability tensor contains either `inf`, `nan` or element < 0"； 即使remove_invalid_values=True也不能解决
    "do_sample": False,
    "top_p": 0.7,
    "logits_processor": None,
    # "remove_invalid_values": True
}

with gr.Blocks() as demo:
    gr.Markdown("## Chat with Amazon SageMaker Ghatglm2")
    with gr.Column():
        chatbot = gr.Chatbot()
        with gr.Row():
            with gr.Column():
                message = gr.Textbox(label="Chat Message Box", placeholder="Chat Message Box", show_label=False)
            with gr.Column():
                with gr.Row():
                    submit = gr.Button("Submit")
                    clear = gr.Button("Clear")

    def respond(message, chat_history):
        # convert chat history to prompt
        converted_chat_history = ""
        if len(chat_history) > 0:
            for c in chat_history:
                converted_chat_history += f"{c[0]}{c[1]}"
        prompt = f"{converted_chat_history}{message}"
        # send request to endpoint
        # llm_response = llm.predict({"inputs": prompt, "parameters": parameters})
        llm_response = smr_client.invoke_endpoint(
            EndpointName=endpoint_name,
            Body=json.dumps(
                {
                    "inputs": prompt,
                    "parameters": parameters,
                    "history": []
                }
            ),
            ContentType="application/json",
        )
        
        #print ("thisis",llm_response)

        # remove prompt from response
        parsed_data = json.loads(llm_response['Body'].read().decode('utf8'))
        parsed_response = parsed_data['outputs']
        #parsed_response = llm_response[0]["generated_text"][len(prompt):]
        chat_history.append((message, parsed_response))
        return "", chat_history

    submit.click(respond, [message, chatbot], [message, chatbot], queue=False)
    clear.click(lambda: None, None, chatbot, queue=False)

demo.launch(share=True)