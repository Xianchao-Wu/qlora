is_r_by_svd=True
num_tok_prompt=8
num_tok_prefix=0
pre_adapter="none"
lora_r=32
out_dir="./output/huarizo-13b-3-alpaca-clean-prompt8-src256"

dataset="alpaca-clean"

python qlazylora.py \
    --model_name_or_path huggyllama/llama-13b \
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
    --do_train \
    --do_eval \
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
    --bits 4 \
    --warmup_ratio 0.03 \
    --lr_scheduler_type constant \
    --gradient_checkpointing False \
    --dataset $dataset \
    --source_max_len 256 \
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
