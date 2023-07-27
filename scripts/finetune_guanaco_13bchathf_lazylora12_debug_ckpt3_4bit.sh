is_r_by_svd=True
num_tok_prompt=0
num_tok_prefix=0
pre_adapter="none"
lora_r=32
out_dir="./output/huarizo-7bchathf-12-temp"

dataset="oasst1"

#mpath="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-7b-chat-hf/snapshots/0ede8dd71e923db6258295621d817ca8714516d4"
#1. mpath="meta-llama/Llama-2-7b-hf" # 0.4667698048601774

#mpath1="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-7b-hf/snapshots/4e4d531bcab430a66c4d562b7e89e21c0fa235ea" # 0.4667698048601774
#mpath2="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-7b-hf/snapshots/7b98be05b7ae501a207aadd47370757a5fd0a3e7" # 0.4667698048601774

# 4. mpath="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-7b-chat-hf/snapshots/0ede8dd71e923db6258295621d817ca8714516d4" # 0.49379703119397245


# 5. mpath="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-7b-chat-hf/snapshots/40c5e2b32261834431f89850c8d5359631ffa764" # 0.4636139710850645

# ---- TODO 13b ----

#mpath1="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-13b-hf/snapshots/1f3a61cf48cd578461427f32fa858097296a4236" # 0.5658459957850754
#mpath2="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-13b-hf/snapshots/31820c723bc0368c339e067553021dc6a8bf4375" # 0.5656705571885842
#mpath3="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-13b-hf/snapshots/f3b475aaed299d2389525d6ce4e542cc438833a4" # 0.5656705571885843

mpath1="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-13b-chat-hf/snapshots/4021a3b5608262f386b2bee683b6348e9228325d" # 0.5474056332816782

mpath2="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-13b-chat-hf/snapshots/7389082e6bc4fcbf6202e6108a70194800e6c51e" # 0.5458454086093255

mpath3="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-13b-chat-hf/snapshots/a4ccda4a5be5ea5869b992103384ae5458b26bc3" # 0.5458454086093255 

# ---- TODO 70b ----

#mpath1="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-70b-hf/snapshots/b70e3df5fc2bf95ba5859878cafa2da37908598c" # 0.6766455649018766
#mpath2="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-70b-hf/snapshots/bc7d6a85f909e2af7678537df0c771ae7b0e8010" # 0.6766455649018766

#mpath3="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-70b-chat-hf/snapshots/bdd2793015239e5493e591a16fc13d501a8a8468" # 0.6233116203658348
#mpath4="/workspace/asr/peft/qlora/models--meta-llama--Llama-2-70b-chat-hf/snapshots/c733a855493ee517f3c51c490ea6ce6ce52cd837" # 0.6239336299352127

for mpath in $mpath1 $mpath2 $mpath3 
do
	echo "----"
	echo $mpath
	echo "----"

	#--model_name_or_path huggyllama/llama-13b \
	echo "mpath=$mpath"

	out_dir="/workspace/asr/peft/qlora/output/huarizo-llama2-13b-2-chat-hf"
	out_dir2="/workspace/asr/peft/qlora/output/huarizo-llama2-13b-2-chat-hf-2"

	for checkpoint_dir in `ls -d ${out_dir}/checkpoint-* ${out_dir2}/checkpoint-*`
	do
		echo "----"
		echo ${checkpoint_dir}
		echo "----"

		python qlazylora_debug.py \
			--model_name_or_path $mpath \
			--output_dir ${out_dir} \
			--checkpoint_dir ${checkpoint_dir} \
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
			--bits 4 \
			--bf16 \
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
		#--bf16 \
	done
done
#--rank_file /workspace/asr/peft/qlora/run2_llama2_7bchathf_lazylora2.sh.log.lazyrank.json \
