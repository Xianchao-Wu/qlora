is_r_by_svd=True
num_tok_prompt=0
num_tok_prefix=0
pre_adapter="none"
lora_r=32
out_dir="./output/huarizo-13b-12-temp"

dataset="oasst1"

mpath="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-7b-chat-hf/snapshots/0ede8dd71e923db6258295621d817ca8714516d4"


#--model_name_or_path huggyllama/llama-13b \

python -m ipdb qlazylora_debug.py \
    --model_name_or_path $mpath \
    --output_dir ${out_dir} \
	--cache_dir "/workspace/asr/peft/qlora" \
    --logging_steps 10 \
    --save_strategy steps \
    --data_seed 42 \
    --save_steps 100 \
    --save_total_limit 40 \
    --evaluation_strategy steps \
    --eval_dataset_size 1024 \
    --max_eval_samples 1000 \
    --per_device_eval_batch_size 1 \
    --max_new_tokens 32 \
    --dataloader_num_workers 4 \
    --group_by_length \
    --logging_strategy steps \
    --remove_unused_columns False \
    --do_train False \
	--full_finetune True \
    --do_eval False \
    --do_mmlu_eval \
	--num_virtual_tokens_prompt ${num_tok_prompt} \
	--num_virtual_tokens_prefix ${num_tok_prefix} \
    --lora_r ${lora_r} \
	--is_r_by_svd ${is_r_by_svd} \
    --lazy_lora_alpha 16 \
	--lazy_pre_lora_alpha 0.1 \
	--lazy_pre_adapter_type ${pre_adapter} \
    --lora_modules "all" \
    --double_quant \
    --quant_type nf4 \
    --bf16 \
    --bits 16 \
    --warmup_ratio 0.03 \
    --lr_scheduler_type constant \
    --gradient_checkpointing False \
    --dataset $dataset \
    --source_max_len 16 \
    --target_max_len 512 \
    --per_device_train_batch_size 1 \
    --gradient_accumulation_steps 16 \
    --max_steps 1875 \
    --eval_steps 187 \
    --learning_rate 0.0002 \
    --adam_beta2 0.999 \
    --max_grad_norm 0.3 \
    --lazy_lora_dropout 0.05 \
    --weight_decay 0.0 \
    --seed 42
    
#--lora_modules all \
#--lora_modules 'q_proj' \
