chapter \<open>Generated by Lem from \<open>../../src/gen_lib/sail2_state_lifting.lem\<close>.\<close>

theory "Sail2_state_lifting" 

imports
  Main
  "LEM.Lem_pervasives_extra"
  "Sail2_values"
  "Sail2_prompt_monad"
  "Sail2_prompt"
  "Sail2_state_monad"
  "Sail2_state_monad_lemmas"

begin 

\<comment> \<open>\<open>open import Pervasives_extra\<close>\<close>
\<comment> \<open>\<open>open import Sail2_values\<close>\<close>
\<comment> \<open>\<open>open import Sail2_prompt_monad\<close>\<close>
\<comment> \<open>\<open>open import Sail2_prompt\<close>\<close>
\<comment> \<open>\<open>open import Sail2_state_monad\<close>\<close>
\<comment> \<open>\<open>open import {isabelle} `Sail2_state_monad_lemmas`\<close>\<close>

\<comment> \<open>\<open> Lifting from prompt monad to state monad \<close>\<close>
\<comment> \<open>\<open>val liftState : forall 'regval 'regs 'a 'e. register_accessors 'regs 'regval -> monad 'regval 'a 'e -> monadS 'regs 'a 'e\<close>\<close>
function (sequential,domintros)  liftState  :: \<open>(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)\<Rightarrow>('regval,'a,'e)monad \<Rightarrow> 'regs sequential_state \<Rightarrow>(('a,'e)result*'regs sequential_state)set \<close>  where 
     \<open> liftState ra (Done a) = ( returnS a )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  a  :: " 'a "
|\<open> liftState ra (Read_mem rk a sz k) = ( bindS (read_mem_bytesS rk a sz)       ((\<lambda> v .  liftState ra (k v))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  rk  :: " Sail2_instr_kinds.read_kind " 
  and  sz  :: " nat " 
  and  k  :: "(memory_byte)list \<Rightarrow>('regval,'a,'e)monad " 
  and  a  :: " nat "
|\<open> liftState ra (Read_memt rk a sz k) = ( bindS (read_memt_bytesS rk a sz)      ((\<lambda> v .  liftState ra (k v))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  rk  :: " Sail2_instr_kinds.read_kind " 
  and  sz  :: " nat " 
  and  k  :: "(memory_byte)list*bitU \<Rightarrow>('regval,'a,'e)monad " 
  and  a  :: " nat "
|\<open> liftState ra (Write_mem wk a sz v k) = ( bindS (write_mem_bytesS wk a sz v)    ((\<lambda> v .  liftState ra (k v))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  wk  :: " Sail2_instr_kinds.write_kind " 
  and  sz  :: " nat " 
  and  k  :: " bool \<Rightarrow>('regval,'a,'e)monad " 
  and  v  :: "(memory_byte)list " 
  and  a  :: " nat "
|\<open> liftState ra (Write_memt wk a sz v t k) = ( bindS (write_memt_bytesS wk a sz v t) ((\<lambda> v .  liftState ra (k v))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  wk  :: " Sail2_instr_kinds.write_kind " 
  and  sz  :: " nat " 
  and  k  :: " bool \<Rightarrow>('regval,'a,'e)monad " 
  and  t  :: " bitU " 
  and  v  :: "(memory_byte)list " 
  and  a  :: " nat "
|\<open> liftState ra (Read_reg r k) = ( bindS (read_regvalS ra r)             ((\<lambda> v .  liftState ra (k v))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  k  :: " 'regval \<Rightarrow>('regval,'a,'e)monad " 
  and  r  :: " string "
|\<open> liftState ra (Excl_res k) = ( bindS (excl_resultS () )               ((\<lambda> v .  liftState ra (k v))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  k  :: " bool \<Rightarrow>('regval,'a,'e)monad "
|\<open> liftState ra (Choose _ k) = ( bindS (choose_boolS () )               ((\<lambda> v .  liftState ra (k v))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  k  :: " bool \<Rightarrow>('regval,'a,'e)monad "
|\<open> liftState ra (Write_reg r v k) = ( seqS (write_regvalS ra r v)           (liftState ra k))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  k  :: "('regval,'a,'e)monad " 
  and  v  :: " 'regval " 
  and  r  :: " string "
|\<open> liftState ra (Write_ea _ _ _ k) = ( liftState ra k )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  k  :: "('regval,'a,'e)monad "
|\<open> liftState ra (Footprint k) = ( liftState ra k )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  k  :: "('regval,'a,'e)monad "
|\<open> liftState ra (Barrier _ k) = ( liftState ra k )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  k  :: "('regval,'a,'e)monad "
|\<open> liftState ra (Print _ k) = ( liftState ra k )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  k  :: "('regval,'a,'e)monad "
|\<open> liftState ra (Fail descr) = ( failS descr )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  descr  :: " string "
|\<open> liftState ra (Exception e) = ( throwS e )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  e  :: " 'e " 
by pat_completeness auto


\<comment> \<open>\<open>val emitEventS : forall 'regval 'regs 'a 'e. Eq 'regval => register_accessors 'regs 'regval -> event 'regval -> sequential_state 'regs -> maybe (sequential_state 'regs)\<close>\<close>
fun emitEventS  :: \<open>(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)\<Rightarrow> 'regval event \<Rightarrow> 'regs sequential_state \<Rightarrow>('regs sequential_state)option \<close>  where 
     \<open> emitEventS ra (E_read_mem _ addr sz v) s = (
     Option.bind (get_mem_bytes addr sz s) ( (\<lambda>x .  
  (case  x of (v', _) => if v' = v then Some s else None ))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  addr  :: " nat " 
  and  sz  :: " nat " 
  and  v  :: "(memory_byte)list " 
  and  s  :: " 'regs sequential_state "
|\<open> emitEventS ra (E_read_memt _ addr sz (v, tag)) s = (
     Option.bind (get_mem_bytes addr sz s) ( (\<lambda>x .  
  (case  x of
      (v', tag') =>
  if (v' = v) \<and> (tag' = tag) then Some s else None
  ))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  tag  :: " bitU " 
  and  addr  :: " nat " 
  and  sz  :: " nat " 
  and  v  :: "(memory_byte)list " 
  and  s  :: " 'regs sequential_state "
|\<open> emitEventS ra (E_write_mem _ addr sz v success) s = (
     if success then Some (put_mem_bytes addr sz v B0 s) else None )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  success  :: " bool " 
  and  addr  :: " nat " 
  and  sz  :: " nat " 
  and  v  :: "(memory_byte)list " 
  and  s  :: " 'regs sequential_state "
|\<open> emitEventS ra (E_write_memt _ addr sz v tag success) s = (
     if success then Some (put_mem_bytes addr sz v tag s) else None )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  success  :: " bool " 
  and  tag  :: " bitU " 
  and  addr  :: " nat " 
  and  sz  :: " nat " 
  and  v  :: "(memory_byte)list " 
  and  s  :: " 'regs sequential_state "
|\<open> emitEventS ra (E_read_reg r v) s = (
     (let (read_reg1, _) = ra in
     Option.bind (read_reg1 r(regstate   s)) ((\<lambda> v' . 
     if v' = v then Some s else None))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  v  :: " 'regval " 
  and  r  :: " string " 
  and  s  :: " 'regs sequential_state "
|\<open> emitEventS ra (E_write_reg r v) s = (
     (let (_, write_reg1) = ra in
     Option.bind (write_reg1 r v(regstate   s)) ((\<lambda> rs' . 
     Some ( s (| regstate := rs' |))))))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  v  :: " 'regval " 
  and  r  :: " string " 
  and  s  :: " 'regs sequential_state "
|\<open> emitEventS ra _ s = ( Some s )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  s  :: " 'regs sequential_state "


\<comment> \<open>\<open>val runTraceS : forall 'regval 'regs 'a 'e. Eq 'regval => register_accessors 'regs 'regval -> trace 'regval -> sequential_state 'regs -> maybe (sequential_state 'regs)\<close>\<close>
fun  runTraceS  :: \<open>(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)\<Rightarrow>('regval event)list \<Rightarrow> 'regs sequential_state \<Rightarrow>('regs sequential_state)option \<close>  where 
     \<open> runTraceS ra ([]) s = ( Some s )\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  s  :: " 'regs sequential_state "
|\<open> runTraceS ra (e # t') s = ( Option.bind (emitEventS ra e s) (runTraceS ra t'))\<close> 
  for  ra  :: "(string \<Rightarrow> 'regs \<Rightarrow> 'regval option)*(string \<Rightarrow> 'regval \<Rightarrow> 'regs \<Rightarrow> 'regs option)" 
  and  t'  :: "('regval event)list " 
  and  e  :: " 'regval event " 
  and  s  :: " 'regs sequential_state "

end