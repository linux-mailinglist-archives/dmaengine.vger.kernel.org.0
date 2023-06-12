Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D672BD95
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjFLJ40 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFLJyu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C22110;
        Mon, 12 Jun 2023 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zIJhFm+v7umyR/hjF6scVII/tRkyIDOCoJmZ83M51xg=; b=bwoTU3HDHIUp9ajMy0QFcq4D+D
        EXDKbnFuPa6qUqmoVDvtErkhWO00LMiPcJzpdvPsQMJLq9wpMasMY6nUzcVeGL9ALBqrIhtyV8EfA
        XKKGvO2PN5okZcYxdhdtY3o4iZ/qDy6c+5VPyKqrPh2PgoSSFDW8jI7e1PpaMe5VUMWVCAorJndtN
        AJ5GDlw6VsgSOVpk0HVetMuky+tVFOVVxZX11VNX4IhJ4CBNVPbArKYPU5OAaWFomWTACc/ooAiYV
        zzoGivkT77zIhCwiENxw5L2hhL0o+nX8tsqRKPT4FCVJkM3V5nu3PsWwe5GueAr3wFeoRM2LesPEy
        6QSZaq5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0v-008kS7-13;
        Mon, 12 Jun 2023 09:39:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B4BC306137;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1F44130A79082; Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Message-ID: <20230612093541.169256651@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:08:03 +0200
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
Subject: [PATCH v3 50/57] perf: Simplify sys_perf_event_open()
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/file.h |    3 
 kernel/events/core.c |  483 +++++++++++++++++++++++----------------------------
 2 files changed, 222 insertions(+), 264 deletions(-)

--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -84,6 +84,7 @@ static inline void fdput_pos(struct fd f
 }
 
 DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
+DEFINE_FREE(fdput, struct fd, fdput(_T))
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
@@ -96,6 +97,8 @@ extern void put_unused_fd(unsigned int f
 DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 	     get_unused_fd_flags(flags), unsigned flags)
 
+#define no_free_fd(fd) ({ int __fd = (fd); (fd) = -1; __fd; })
+
 extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(struct file *file, int __user *ufd,
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1163,9 +1163,10 @@ static void perf_assert_pmu_disabled(str
 	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
 }
 
-static void get_ctx(struct perf_event_context *ctx)
+static struct perf_event_context *get_ctx(struct perf_event_context *ctx)
 {
 	refcount_inc(&ctx->refcount);
+	return ctx;
 }
 
 static void *alloc_task_ctx_data(struct pmu *pmu)
@@ -4672,9 +4673,6 @@ find_lively_task_by_vpid(pid_t vpid)
 		get_task_struct(task);
 	rcu_read_unlock();
 
-	if (!task)
-		return ERR_PTR(-ESRCH);
-
 	return task;
 }
 
@@ -4754,6 +4752,11 @@ find_get_context(struct task_struct *tas
 	return ERR_PTR(err);
 }
 
+DEFINE_CLASS(find_get_ctx, struct perf_event_context *,
+	     if (!IS_ERR_OR_NULL(_T)) { perf_unpin_context(_T); put_ctx(_T); },
+	     find_get_context(task, event),
+	     struct task_struct *task, struct perf_event *event)
+
 /*
  * Returns a matching perf_event_pmu_context with elevated refcount or NULL.
  */
@@ -4836,9 +4839,10 @@ find_get_pmu_context(struct pmu *pmu, st
 	return epc;
 }
 
-static void get_pmu_ctx(struct perf_event_pmu_context *epc)
+static struct perf_event_pmu_context *get_pmu_ctx(struct perf_event_pmu_context *epc)
 {
 	WARN_ON_ONCE(!atomic_inc_not_zero(&epc->refcount));
+	return epc;
 }
 
 static void free_epc_rcu(struct rcu_head *head)
@@ -4881,6 +4885,8 @@ static void put_pmu_ctx(struct perf_even
 	call_rcu(&epc->rcu_head, free_epc_rcu);
 }
 
+DEFINE_FREE(put_pmu_ctx, struct perf_event_pmu_context *, if (_T) put_pmu_ctx(_T))
+
 static void perf_event_free_filter(struct perf_event *event);
 
 static void free_event_rcu(struct rcu_head *head)
@@ -5190,6 +5196,8 @@ static void free_event(struct perf_event
 	_free_event(event);
 }
 
+DEFINE_FREE(free_event, struct perf_event *, if (!IS_ERR_OR_NULL(_T)) free_event(_T))
+
 /*
  * Remove user event from the owner task.
  */
@@ -5748,19 +5756,6 @@ EXPORT_SYMBOL_GPL(perf_event_period);
 
 static const struct file_operations perf_fops;
 
-static inline struct fd perf_fdget(int fd)
-{
-	struct fd f = fdget(fd);
-	if (!f.file)
-		return fdnull;
-
-	if (f.file->f_op != &perf_fops) {
-		fdput(f);
-		return fdnull;
-	}
-	return f;
-}
-
 static inline bool is_perf_fd(struct fd fd)
 {
 	return fd.file && fd.file->f_op == &perf_fops;
@@ -12189,19 +12184,16 @@ SYSCALL_DEFINE5(perf_event_open,
 		pid_t, pid, int, cpu, int, group_fd, unsigned long, flags)
 {
 	struct perf_event *group_leader = NULL, *output_event = NULL;
-	struct perf_event_pmu_context *pmu_ctx;
-	struct perf_event *event, *sibling;
+	struct perf_event *sibling;
 	struct perf_event_attr attr;
-	struct perf_event_context *ctx;
 	struct file *event_file = NULL;
-	struct fd group = {NULL, 0};
-	struct task_struct *task = NULL;
+	struct task_struct *task __free(put_task) = NULL;
+	struct fd group __free(fdput) = fdnull;
 	struct pmu *pmu;
-	int event_fd;
 	int move_group = 0;
-	int err;
 	int f_flags = O_RDWR;
 	int cgroup_fd = -1;
+	int err;
 
 	/* for future expandability... */
 	if (flags & ~PERF_FLAG_ALL)
@@ -12261,16 +12253,14 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (flags & PERF_FLAG_FD_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 
-	event_fd = get_unused_fd_flags(f_flags);
-	if (event_fd < 0)
-		return event_fd;
+	CLASS(get_unused_fd, fd)(f_flags);
+	if (fd < 0)
+		return fd;
 
 	if (group_fd != -1) {
-		group = perf_fdget(group_fd);
-		if (!group.file) {
-			err = -EBADF;
-			goto err_fd;
-		}
+		group = fdget(group_fd);
+		if (!is_perf_fd(group))
+			return -EBADF;
 		group_leader = group.file->private_data;
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;
@@ -12280,33 +12270,26 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	if (pid != -1 && !(flags & PERF_FLAG_PID_CGROUP)) {
 		task = find_lively_task_by_vpid(pid);
-		if (IS_ERR(task)) {
-			err = PTR_ERR(task);
-			goto err_group_fd;
-		}
+		if (!task)
+			return -ESRCH;
 	}
 
 	if (task && group_leader &&
-	    group_leader->attr.inherit != attr.inherit) {
-		err = -EINVAL;
-		goto err_task;
-	}
+	    group_leader->attr.inherit != attr.inherit)
+		return -EINVAL;
 
 	if (flags & PERF_FLAG_PID_CGROUP)
 		cgroup_fd = pid;
 
-	event = perf_event_alloc(&attr, cpu, task, group_leader, NULL,
+	struct perf_event *event __free(free_event) =
+		perf_event_alloc(&attr, cpu, task, group_leader, NULL,
 				 NULL, NULL, cgroup_fd);
-	if (IS_ERR(event)) {
-		err = PTR_ERR(event);
-		goto err_task;
-	}
+	if (IS_ERR(event))
+		return PTR_ERR(event);
 
 	if (is_sampling_event(event)) {
-		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
-			err = -EOPNOTSUPP;
-			goto err_alloc;
-		}
+		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
+			return -EOPNOTSUPP;
 	}
 
 	/*
@@ -12318,266 +12301,238 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (attr.use_clockid) {
 		err = perf_event_set_clock(event, attr.clockid);
 		if (err)
-			goto err_alloc;
+			return err;
 	}
 
 	if (pmu->task_ctx_nr == perf_sw_context)
 		event->event_caps |= PERF_EV_CAP_SOFTWARE;
 
-	if (task) {
-		err = down_read_interruptible(&task->signal->exec_update_lock);
-		if (err)
-			goto err_alloc;
+	do {
+		struct rw_semaphore *exec_update_lock __free(up_read) = NULL;
+		if (task) {
+			err = down_read_interruptible(&task->signal->exec_update_lock);
+			if (err)
+				return err;
+
+			exec_update_lock = &task->signal->exec_update_lock;
+
+			/*
+			 * We must hold exec_update_lock across this and any potential
+			 * perf_install_in_context() call for this new event to
+			 * serialize against exec() altering our credentials (and the
+			 * perf_event_exit_task() that could imply).
+			 */
+			if (!perf_check_permission(&attr, task))
+				return -EACCES;
+		}
 
 		/*
-		 * We must hold exec_update_lock across this and any potential
-		 * perf_install_in_context() call for this new event to
-		 * serialize against exec() altering our credentials (and the
-		 * perf_event_exit_task() that could imply).
+		 * Get the target context (task or percpu):
 		 */
-		err = -EACCES;
-		if (!perf_check_permission(&attr, task))
-			goto err_cred;
-	}
+		CLASS(find_get_ctx, ctx)(task, event);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
 
-	/*
-	 * Get the target context (task or percpu):
-	 */
-	ctx = find_get_context(task, event);
-	if (IS_ERR(ctx)) {
-		err = PTR_ERR(ctx);
-		goto err_cred;
-	}
-
-	mutex_lock(&ctx->mutex);
+		guard(mutex)(&ctx->mutex);
 
-	if (ctx->task == TASK_TOMBSTONE) {
-		err = -ESRCH;
-		goto err_locked;
-	}
+		if (ctx->task == TASK_TOMBSTONE)
+			return -ESRCH;
 
-	if (!task) {
-		/*
-		 * Check if the @cpu we're creating an event for is online.
-		 *
-		 * We use the perf_cpu_context::ctx::mutex to serialize against
-		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
-		 */
-		struct perf_cpu_context *cpuctx = per_cpu_ptr(&perf_cpu_context, event->cpu);
+		if (!task) {
+			/*
+			 * Check if the @cpu we're creating an event for is
+			 * online.
+			 *
+			 * We use the perf_cpu_context::ctx::mutex to serialize
+			 * against the hotplug notifiers. See
+			 * perf_event_{init,exit}_cpu().
+			 */
+			struct perf_cpu_context *cpuctx =
+				per_cpu_ptr(&perf_cpu_context, event->cpu);
 
-		if (!cpuctx->online) {
-			err = -ENODEV;
-			goto err_locked;
+			if (!cpuctx->online)
+				return -ENODEV;
 		}
-	}
 
-	if (group_leader) {
-		err = -EINVAL;
+		if (group_leader) {
+			err = -EINVAL;
 
-		/*
-		 * Do not allow a recursive hierarchy (this new sibling
-		 * becoming part of another group-sibling):
-		 */
-		if (group_leader->group_leader != group_leader)
-			goto err_locked;
-
-		/* All events in a group should have the same clock */
-		if (group_leader->clock != event->clock)
-			goto err_locked;
+			/*
+			 * Do not allow a recursive hierarchy (this new sibling
+			 * becoming part of another group-sibling)
+			 */
+			if (group_leader->group_leader != group_leader)
+				return -EINVAL;
 
-		/*
-		 * Make sure we're both events for the same CPU;
-		 * grouping events for different CPUs is broken; since
-		 * you can never concurrently schedule them anyhow.
-		 */
-		if (group_leader->cpu != event->cpu)
-			goto err_locked;
+			/* All events in a group should have the same clock */
+			if (group_leader->clock != event->clock)
+				return -EINVAL;
 
-		/*
-		 * Make sure we're both on the same context; either task or cpu.
-		 */
-		if (group_leader->ctx != ctx)
-			goto err_locked;
+			/*
+			 * Make sure we're both events for the same CPU;
+			 * grouping events for different CPUs is broken; since
+			 * you can never concurrently schedule them anyhow.
+			 */
+			if (group_leader->cpu != event->cpu)
+				return -EINVAL;
 
-		/*
-		 * Only a group leader can be exclusive or pinned
-		 */
-		if (attr.exclusive || attr.pinned)
-			goto err_locked;
+			/*
+			 * Make sure we're both on the same context; either
+			 * task or cpu.
+			 */
+			if (group_leader->ctx != ctx)
+				return -EINVAL;
 
-		if (is_software_event(event) &&
-		    !in_software_context(group_leader)) {
 			/*
-			 * If the event is a sw event, but the group_leader
-			 * is on hw context.
-			 *
-			 * Allow the addition of software events to hw
-			 * groups, this is safe because software events
-			 * never fail to schedule.
-			 *
-			 * Note the comment that goes with struct
-			 * perf_event_pmu_context.
+			 * Only a group leader can be exclusive or pinned
 			 */
-			pmu = group_leader->pmu_ctx->pmu;
-		} else if (!is_software_event(event)) {
-			if (is_software_event(group_leader) &&
-			    (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
+			if (attr.exclusive || attr.pinned)
+				return -EINVAL;
+
+			if (is_software_event(event) &&
+			    !in_software_context(group_leader)) {
+				/*
+				 * If the event is a sw event, but the
+				 * group_leader is on hw context.
+				 *
+				 * Allow the addition of software events to hw
+				 * groups, this is safe because software events
+				 * never fail to schedule.
+				 *
+				 * Note the comment that goes with struct
+				 * perf_event_pmu_context.
+				 */
+				pmu = group_leader->pmu_ctx->pmu;
+			} else if (!is_software_event(event)) {
+				if (is_software_event(group_leader) &&
+				    (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
+					/*
+					 * In case the group is a pure software
+					 * group, and we try to add a hardware
+					 * event, move the whole group to the
+					 * hardware context.
+					 */
+					move_group = 1;
+				}
+
 				/*
-				 * In case the group is a pure software group, and we
-				 * try to add a hardware event, move the whole group to
-				 * the hardware context.
+				 * Don't allow group of multiple hw events from
+				 * different pmus
 				 */
-				move_group = 1;
+				if (!in_software_context(group_leader) &&
+				    group_leader->pmu_ctx->pmu != pmu)
+					return -EINVAL;
 			}
+		}
+
+		/*
+		 * Now that we're certain of the pmu; find the pmu_ctx.
+		 */
+		struct perf_event_pmu_context *pmu_ctx __free(put_pmu_ctx) =
+			find_get_pmu_context(pmu, ctx, event);
+		if (!pmu_ctx)
+			return -ENOMEM;
 
-			/* Don't allow group of multiple hw events from different pmus */
-			if (!in_software_context(group_leader) &&
-			    group_leader->pmu_ctx->pmu != pmu)
-				goto err_locked;
+		if (output_event) {
+			err = perf_event_set_output(event, output_event);
+			if (err)
+				return err;
 		}
-	}
 
-	/*
-	 * Now that we're certain of the pmu; find the pmu_ctx.
-	 */
-	pmu_ctx = find_get_pmu_context(pmu, ctx, event);
-	if (IS_ERR(pmu_ctx)) {
-		err = PTR_ERR(pmu_ctx);
-		goto err_locked;
-	}
-	event->pmu_ctx = pmu_ctx;
+		if (!perf_event_validate_size(event))
+			return -E2BIG;
 
-	if (output_event) {
-		err = perf_event_set_output(event, output_event);
-		if (err)
-			goto err_context;
-	}
+		if (perf_need_aux_event(event) &&
+		    !perf_get_aux_event(event, group_leader))
+			return -EINVAL;
 
-	if (!perf_event_validate_size(event)) {
-		err = -E2BIG;
-		goto err_context;
-	}
+		/*
+		 * Must be under the same ctx::mutex as perf_install_in_context(),
+		 * because we need to serialize with concurrent event creation.
+		 */
+		if (!exclusive_event_installable(event, ctx))
+			return -EBUSY;
 
-	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader)) {
-		err = -EINVAL;
-		goto err_context;
-	}
+		WARN_ON_ONCE(ctx->parent_ctx);
 
-	/*
-	 * Must be under the same ctx::mutex as perf_install_in_context(),
-	 * because we need to serialize with concurrent event creation.
-	 */
-	if (!exclusive_event_installable(event, ctx)) {
-		err = -EBUSY;
-		goto err_context;
-	}
+		event_file = anon_inode_getfile("[perf_event]", &perf_fops,
+						event, f_flags);
+		if (IS_ERR(event_file))
+			return PTR_ERR(event_file);
 
-	WARN_ON_ONCE(ctx->parent_ctx);
+		/*
+		 * The event is now owned by event_file and will be cleaned up
+		 * through perf_fops::release(). Similarly the fd will be linked
+		 * to event_file and should not be put_unused_fd().
+		 */
 
-	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event, f_flags);
-	if (IS_ERR(event_file)) {
-		err = PTR_ERR(event_file);
-		event_file = NULL;
-		goto err_context;
-	}
+		/*
+		 * This is the point on no return; we cannot fail hereafter. This is
+		 * where we start modifying current state.
+		 */
 
-	/*
-	 * This is the point on no return; we cannot fail hereafter. This is
-	 * where we start modifying current state.
-	 */
+		if (move_group) {
+			/*
+			 * Moves the events from one pmu to another, hence we need
+			 * to update the pmu_ctx, but through all this the ctx
+			 * stays the same.
+			 */
+			perf_remove_from_context(group_leader, 0);
+			put_pmu_ctx(group_leader->pmu_ctx);
 
-	if (move_group) {
-		perf_remove_from_context(group_leader, 0);
-		put_pmu_ctx(group_leader->pmu_ctx);
+			for_each_sibling_event(sibling, group_leader) {
+				perf_remove_from_context(sibling, 0);
+				put_pmu_ctx(sibling->pmu_ctx);
+			}
 
-		for_each_sibling_event(sibling, group_leader) {
-			perf_remove_from_context(sibling, 0);
-			put_pmu_ctx(sibling->pmu_ctx);
-		}
+			/*
+			 * Install the group siblings before the group leader.
+			 *
+			 * Because a group leader will try and install the entire group
+			 * (through the sibling list, which is still in-tact), we can
+			 * end up with siblings installed in the wrong context.
+			 *
+			 * By installing siblings first we NO-OP because they're not
+			 * reachable through the group lists.
+			 */
+			for_each_sibling_event(sibling, group_leader) {
+				sibling->pmu_ctx = get_pmu_ctx(pmu_ctx);
+				perf_event__state_init(sibling);
+				perf_install_in_context(ctx, sibling, sibling->cpu);
+			}
 
-		/*
-		 * Install the group siblings before the group leader.
-		 *
-		 * Because a group leader will try and install the entire group
-		 * (through the sibling list, which is still in-tact), we can
-		 * end up with siblings installed in the wrong context.
-		 *
-		 * By installing siblings first we NO-OP because they're not
-		 * reachable through the group lists.
-		 */
-		for_each_sibling_event(sibling, group_leader) {
-			sibling->pmu_ctx = pmu_ctx;
-			get_pmu_ctx(pmu_ctx);
-			perf_event__state_init(sibling);
-			perf_install_in_context(ctx, sibling, sibling->cpu);
+			/*
+			 * Removing from the context ends up with disabled
+			 * event. What we want here is event in the initial
+			 * startup state, ready to be add into new context.
+			 */
+			group_leader->pmu_ctx = get_pmu_ctx(pmu_ctx);
+			perf_event__state_init(group_leader);
+			perf_install_in_context(ctx, group_leader, group_leader->cpu);
 		}
 
 		/*
-		 * Removing from the context ends up with disabled
-		 * event. What we want here is event in the initial
-		 * startup state, ready to be add into new context.
+		 * Precalculate sample_data sizes; do while holding ctx::mutex such
+		 * that we're serialized against further additions and before
+		 * perf_install_in_context() which is the point the event is active and
+		 * can use these values.
 		 */
-		group_leader->pmu_ctx = pmu_ctx;
-		get_pmu_ctx(pmu_ctx);
-		perf_event__state_init(group_leader);
-		perf_install_in_context(ctx, group_leader, group_leader->cpu);
-	}
+		perf_event__header_size(event);
+		perf_event__id_header_size(event);
 
-	/*
-	 * Precalculate sample_data sizes; do while holding ctx::mutex such
-	 * that we're serialized against further additions and before
-	 * perf_install_in_context() which is the point the event is active and
-	 * can use these values.
-	 */
-	perf_event__header_size(event);
-	perf_event__id_header_size(event);
+		event->owner = current;
 
-	event->owner = current;
+		event->pmu_ctx = no_free_ptr(pmu_ctx);
+		perf_install_in_context(get_ctx(ctx), event, event->cpu);
+	} while (0);
 
-	perf_install_in_context(ctx, event, event->cpu);
-	perf_unpin_context(ctx);
+	scoped_guard (mutex, &current->perf_event_mutex)
+		list_add_tail(&event->owner_entry, &current->perf_event_list);
 
-	mutex_unlock(&ctx->mutex);
+	fd_install(fd, event_file);
 
-	if (task) {
-		up_read(&task->signal->exec_update_lock);
-		put_task_struct(task);
-	}
-
-	mutex_lock(&current->perf_event_mutex);
-	list_add_tail(&event->owner_entry, &current->perf_event_list);
-	mutex_unlock(&current->perf_event_mutex);
-
-	/*
-	 * Drop the reference on the group_event after placing the
-	 * new event on the sibling_list. This ensures destruction
-	 * of the group leader will find the pointer to itself in
-	 * perf_group_detach().
-	 */
-	fdput(group);
-	fd_install(event_fd, event_file);
-	return event_fd;
-
-err_context:
-	put_pmu_ctx(event->pmu_ctx);
-	event->pmu_ctx = NULL; /* _free_event() */
-err_locked:
-	mutex_unlock(&ctx->mutex);
-	perf_unpin_context(ctx);
-	put_ctx(ctx);
-err_cred:
-	if (task)
-		up_read(&task->signal->exec_update_lock);
-err_alloc:
-	free_event(event);
-err_task:
-	if (task)
-		put_task_struct(task);
-err_group_fd:
-	fdput(group);
-err_fd:
-	put_unused_fd(event_fd);
-	return err;
+	no_free_ptr(event);
+	return no_free_fd(fd);
 }
 
 /**


