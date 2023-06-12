Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB472BD50
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjFLJz7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjFLJyp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F334C1D;
        Mon, 12 Jun 2023 02:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=szAn79F4mqfMUFH3NFua/nTnj8aGUQ8HGVR6NlJOzM4=; b=dmt6RRN5/6iW0nXv8WCs7Zhoq7
        h66/OFpGSYq3NopaotDNajuFo8i5Abvywbk25Mkw64F7BKRPBDAMFErpkMVn5jc1JDWWixleXtBPh
        TLPcdD6pTKzi2NGzuw4ny2PmQy/30yIqkBkkgI2XhvaBJgwGgdhaI4B8DWmnMj2mqvkcRzcAY6HRy
        jk7gpJD/ftYk8Hikh4m2P22vJKm9NoD09zIFAZMUbUi4MpR8Yhp4gzJ6D7tuejbq/RRvcSqn4CrlB
        sEMwyssBIPsqrQMHjdIJ8/AZRnWyKMbTE7D2j2333TyWpvcfxe9q1zhpgbPY6ZV8UERchXfhjI06e
        QRlB8Skw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0l-008kQP-0j;
        Mon, 12 Jun 2023 09:38:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E96F302F7E;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6C74530A77B5C; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.014199820@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Subject: [PATCH v3 21/57] sched: Misc cleanups
References: <20230612090713.652690195@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Random remaining guard use...

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |  163 ++++++++++++++++++++--------------------------------
 1 file changed, 63 insertions(+), 100 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1454,16 +1454,12 @@ static void __uclamp_update_util_min_rt_
 
 static void uclamp_update_util_min_rt_default(struct task_struct *p)
 {
-	struct rq_flags rf;
-	struct rq *rq;
-
 	if (!rt_task(p))
 		return;
 
 	/* Protect updates to p->uclamp_* */
-	rq = task_rq_lock(p, &rf);
+	guard(task_rq_lock)(p);
 	__uclamp_update_util_min_rt_default(p);
-	task_rq_unlock(rq, p, &rf);
 }
 
 static inline struct uclamp_se
@@ -1759,9 +1755,8 @@ static void uclamp_update_root_tg(void)
 	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
 		      sysctl_sched_uclamp_util_max, false);
 
-	rcu_read_lock();
+	guard(rcu)();
 	cpu_util_update_eff(&root_task_group.css);
-	rcu_read_unlock();
 }
 #else
 static void uclamp_update_root_tg(void) { }
@@ -1788,10 +1783,9 @@ static void uclamp_sync_util_min_rt_defa
 	smp_mb__after_spinlock();
 	read_unlock(&tasklist_lock);
 
-	rcu_read_lock();
+	guard(rcu)();
 	for_each_process_thread(g, p)
 		uclamp_update_util_min_rt_default(p);
-	rcu_read_unlock();
 }
 
 static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
@@ -2243,10 +2237,9 @@ void migrate_disable(void)
 		return;
 	}
 
-	preempt_disable();
+	guard(preempt)();
 	this_rq()->nr_pinned++;
 	p->migration_disabled = 1;
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
 
@@ -2270,7 +2263,7 @@ void migrate_enable(void)
 	 * Ensure stop_task runs either before or after this, and that
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
 	 */
-	preempt_disable();
+	guard(preempt)();
 	if (p->cpus_ptr != &p->cpus_mask)
 		__set_cpus_allowed_ptr(p, &ac);
 	/*
@@ -2281,7 +2274,6 @@ void migrate_enable(void)
 	barrier();
 	p->migration_disabled = 0;
 	this_rq()->nr_pinned--;
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
@@ -3449,13 +3441,11 @@ unsigned long wait_task_inactive(struct
  */
 void kick_process(struct task_struct *p)
 {
-	int cpu;
+	guard(preempt)();
+	int cpu = task_cpu(p);
 
-	preempt_disable();
-	cpu = task_cpu(p);
 	if ((cpu != smp_processor_id()) && task_curr(p))
 		smp_send_reschedule(cpu);
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kick_process);
 
@@ -6300,8 +6290,9 @@ static void sched_core_balance(struct rq
 	struct sched_domain *sd;
 	int cpu = cpu_of(rq);
 
-	preempt_disable();
-	rcu_read_lock();
+	guard(preempt)();
+	guard(rcu)();
+
 	raw_spin_rq_unlock_irq(rq);
 	for_each_domain(cpu, sd) {
 		if (need_resched())
@@ -6311,8 +6302,6 @@ static void sched_core_balance(struct rq
 			break;
 	}
 	raw_spin_rq_lock_irq(rq);
-	rcu_read_unlock();
-	preempt_enable();
 }
 
 static DEFINE_PER_CPU(struct balance_callback, core_balance_head);
@@ -8169,8 +8158,6 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pi
 #ifdef CONFIG_SMP
 int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 {
-	int ret = 0;
-
 	/*
 	 * If the task isn't a deadline task or admission control is
 	 * disabled then we don't care about affinity changes.
@@ -8184,11 +8171,11 @@ int dl_task_check_affinity(struct task_s
 	 * tasks allowed to run on all the CPUs in the task's
 	 * root_domain.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	if (!cpumask_subset(task_rq(p)->rd->span, mask))
-		ret = -EBUSY;
-	rcu_read_unlock();
-	return ret;
+		return -EBUSY;
+
+	return 0;
 }
 #endif
 
@@ -9197,10 +9184,8 @@ int task_can_attach(struct task_struct *
 	 * success of set_cpus_allowed_ptr() on all attached tasks
 	 * before cpus_mask may be changed.
 	 */
-	if (p->flags & PF_NO_SETAFFINITY) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (p->flags & PF_NO_SETAFFINITY)
+		return -EINVAL;
 
 	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
 					      cs_effective_cpus)) {
@@ -9211,7 +9196,6 @@ int task_can_attach(struct task_struct *
 		ret = dl_cpu_busy(cpu, p);
 	}
 
-out:
 	return ret;
 }
 
@@ -10433,11 +10417,9 @@ static int cpu_cgroup_css_online(struct
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	/* Propagate the effective uclamp value for the new group */
-	mutex_lock(&uclamp_mutex);
-	rcu_read_lock();
+	guard(mutex)(&uclamp_mutex);
+	guard(rcu)();
 	cpu_util_update_eff(css);
-	rcu_read_unlock();
-	mutex_unlock(&uclamp_mutex);
 #endif
 
 	return 0;
@@ -10588,8 +10570,8 @@ static ssize_t cpu_uclamp_write(struct k
 
 	static_branch_enable(&sched_uclamp_used);
 
-	mutex_lock(&uclamp_mutex);
-	rcu_read_lock();
+	guard(mutex)(&uclamp_mutex);
+	guard(rcu)();
 
 	tg = css_tg(of_css(of));
 	if (tg->uclamp_req[clamp_id].value != req.util)
@@ -10604,9 +10586,6 @@ static ssize_t cpu_uclamp_write(struct k
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_eff(of_css(of));
 
-	rcu_read_unlock();
-	mutex_unlock(&uclamp_mutex);
-
 	return nbytes;
 }
 
@@ -10632,10 +10611,10 @@ static inline void cpu_uclamp_print(stru
 	u64 percent;
 	u32 rem;
 
-	rcu_read_lock();
-	tg = css_tg(seq_css(sf));
-	util_clamp = tg->uclamp_req[clamp_id].value;
-	rcu_read_unlock();
+	scoped_guard (rcu) {
+		tg = css_tg(seq_css(sf));
+		util_clamp = tg->uclamp_req[clamp_id].value;
+	}
 
 	if (util_clamp == SCHED_CAPACITY_SCALE) {
 		seq_puts(sf, "max\n");
@@ -10952,7 +10931,6 @@ static int tg_cfs_schedulable_down(struc
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 quota)
 {
-	int ret;
 	struct cfs_schedulable_data data = {
 		.tg = tg,
 		.period = period,
@@ -10964,11 +10942,8 @@ static int __cfs_schedulable(struct task
 		do_div(data.quota, NSEC_PER_USEC);
 	}
 
-	rcu_read_lock();
-	ret = walk_tg_tree(tg_cfs_schedulable_down, tg_nop, &data);
-	rcu_read_unlock();
-
-	return ret;
+	guard(rcu)();
+	return walk_tg_tree(tg_cfs_schedulable_down, tg_nop, &data);
 }
 
 static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
@@ -11529,14 +11504,12 @@ int __sched_mm_cid_migrate_from_fetch_ci
 	 * are not the last task to be migrated from this cpu for this mm, so
 	 * there is no need to move src_cid to the destination cpu.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	src_task = rcu_dereference(src_rq->curr);
 	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-		rcu_read_unlock();
 		t->last_mm_cid = -1;
 		return -1;
 	}
-	rcu_read_unlock();
 
 	return src_cid;
 }
@@ -11580,18 +11553,17 @@ int __sched_mm_cid_migrate_from_try_stea
 	 * the lazy-put flag, this task will be responsible for transitioning
 	 * from lazy-put flag set to MM_CID_UNSET.
 	 */
-	rcu_read_lock();
-	src_task = rcu_dereference(src_rq->curr);
-	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-		rcu_read_unlock();
-		/*
-		 * We observed an active task for this mm, there is therefore
-		 * no point in moving this cid to the destination cpu.
-		 */
-		t->last_mm_cid = -1;
-		return -1;
+	scoped_guard (rcu) {
+		src_task = rcu_dereference(src_rq->curr);
+		if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
+			/*
+			 * We observed an active task for this mm, there is therefore
+			 * no point in moving this cid to the destination cpu.
+			 */
+			t->last_mm_cid = -1;
+			return -1;
+		}
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The src_cid is unused, so it can be unset.
@@ -11664,7 +11636,6 @@ static void sched_mm_cid_remote_clear(st
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *t;
-	unsigned long flags;
 	int cid, lazy_cid;
 
 	cid = READ_ONCE(pcpu_cid->cid);
@@ -11699,23 +11670,21 @@ static void sched_mm_cid_remote_clear(st
 	 * the lazy-put flag, that task will be responsible for transitioning
 	 * from lazy-put flag set to MM_CID_UNSET.
 	 */
-	rcu_read_lock();
-	t = rcu_dereference(rq->curr);
-	if (READ_ONCE(t->mm_cid_active) && t->mm == mm) {
-		rcu_read_unlock();
-		return;
+	scoped_guard (rcu) {
+		t = rcu_dereference(rq->curr);
+		if (READ_ONCE(t->mm_cid_active) && t->mm == mm)
+			return;
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The cid is unused, so it can be unset.
 	 * Disable interrupts to keep the window of cid ownership without rq
 	 * lock small.
 	 */
-	local_irq_save(flags);
-	if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
-		__mm_cid_put(mm, cid);
-	local_irq_restore(flags);
+	scoped_guard (irqsave) {
+		if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
+			__mm_cid_put(mm, cid);
+	}
 }
 
 static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
@@ -11737,14 +11706,13 @@ static void sched_mm_cid_remote_clear_ol
 	 * snapshot associated with this cid if an active task using the mm is
 	 * observed on this rq.
 	 */
-	rcu_read_lock();
-	curr = rcu_dereference(rq->curr);
-	if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
-		WRITE_ONCE(pcpu_cid->time, rq_clock);
-		rcu_read_unlock();
-		return;
+	scoped_guard (rcu) {
+		curr = rcu_dereference(rq->curr);
+		if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
+			WRITE_ONCE(pcpu_cid->time, rq_clock);
+			return;
+		}
 	}
-	rcu_read_unlock();
 
 	if (rq_clock < pcpu_cid->time + SCHED_MM_CID_PERIOD_NS)
 		return;
@@ -11838,7 +11806,6 @@ void task_tick_mm_cid(struct rq *rq, str
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11846,7 +11813,7 @@ void sched_mm_cid_exit_signals(struct ta
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
+	guard(rq_lock_irqsave)(rq);
 	preempt_enable_no_resched();	/* holding spinlock */
 	WRITE_ONCE(t->mm_cid_active, 0);
 	/*
@@ -11856,13 +11823,11 @@ void sched_mm_cid_exit_signals(struct ta
 	smp_mb();
 	mm_cid_put(mm);
 	t->last_mm_cid = t->mm_cid = -1;
-	rq_unlock_irqrestore(rq, &rf);
 }
 
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11870,7 +11835,7 @@ void sched_mm_cid_before_execve(struct t
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
+	guard(rq_lock_irqsave)(rq);
 	preempt_enable_no_resched();	/* holding spinlock */
 	WRITE_ONCE(t->mm_cid_active, 0);
 	/*
@@ -11880,13 +11845,11 @@ void sched_mm_cid_before_execve(struct t
 	smp_mb();
 	mm_cid_put(mm);
 	t->last_mm_cid = t->mm_cid = -1;
-	rq_unlock_irqrestore(rq, &rf);
 }
 
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11894,16 +11857,16 @@ void sched_mm_cid_after_execve(struct ta
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 1);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
-	rq_unlock_irqrestore(rq, &rf);
+	scoped_guard (rq_lock_irqsave, rq) {
+		preempt_enable_no_resched();	/* holding spinlock */
+		WRITE_ONCE(t->mm_cid_active, 1);
+		/*
+		 * Store t->mm_cid_active before loading per-mm/cpu cid.
+		 * Matches barrier in sched_mm_cid_remote_clear_old().
+		 */
+		smp_mb();
+		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
+	}
 	rseq_set_notify_resume(t);
 }
 


