#--model_name_or_path meta-llama/Llama-2-13b-hf \
mpath="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-13b-hf/snapshots/1f3a61cf48cd578461427f32fa858097296a4236"

python qlazylora.py \
    --model_name_or_path $mpath \
    --output_dir ./output/huarizo-llama2-13b-2-hf \
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
	--num_virtual_tokens_prompt 0 \
	--num_virtual_tokens_prefix 0 \
    --lora_r 64 \
	--is_r_by_svd True \
    --lazy_lora_alpha 16 \
	--lazy_pre_lora_alpha 0.1 \
	--lazy_pre_adapter_type "none" \
    --lora_modules "all" \
    --double_quant \
    --quant_type nf4 \
    --bf16 \
    --bits 4 \
    --warmup_ratio 0.03 \
    --lr_scheduler_type constant \
    --gradient_checkpointing False \
    --dataset oasst1 \
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

# is_r_by_svd: True/False TODO
# num_virtual_tokens_prompt: 0 or not 0 -> prompt tuning TODO
# num_virtual_tokens_prefix: 0 or not 0 -> prefix tuning TODO
# lazy_pre_adapter_type: 'none', 'linear', or 'conv1d' TODO
