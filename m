Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181B572BD3F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjFLJze (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjFLJyV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059F24C0D;
        Mon, 12 Jun 2023 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=by7PPFcazB/pK+2FaRs+OdI6JGfC9WsBX82VOJ7mM6o=; b=Y9O0dNQIJUKlbjZtt4rxwr8Rv6
        BevFAXrP1152xD7o/GddMsCg4tPJSIDp0cRHFpQZjBJvwythjmmoKl8IQGNgf1x1/9e+43fYWMJqz
        sBca6vwafwE3K9qpMLJDwrRFibEGyiTjmyFg9Q/GYkE3Zg1mWJ11eKDdJ/+LPCwS+GUqSqRrWiYkG
        0QVjxQGVtDJq1lpG2kA59EZhMgxt2zHPN6qItB5KHnuG5+qudT11EyJ6SbRHs4K8aDlVGtBnaU2GF
        XuieTeZwR3eToElJB0vqlwQ9UdcuvS6R9ZY/l/O9ZJhrDgojoRHi5Uh+8R/BJOkRPZkJa+DWzn+eL
        9gEWkzJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0g-008kP9-1f;
        Mon, 12 Jun 2023 09:38:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ECD763031B0;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4C66430A77B55; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093538.546520916@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:28 +0200
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
Subject: [PATCH v3 15/57] sched: Simplify syscalls
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

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |  154 ++++++++++++++++++++++------------------------------
 1 file changed, 68 insertions(+), 86 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7425,6 +7425,21 @@ static struct task_struct *find_process_
 	return pid ? find_task_by_vpid(pid) : current;
 }
 
+static struct task_struct *find_get_task(pid_t pid)
+{
+	struct task_struct *p;
+	guard(rcu)();
+
+	p = find_process_by_pid(pid);
+	if (likely(p))
+		get_task_struct(p);
+
+	return p;
+}
+
+DEFINE_CLASS(find_get_task, struct task_struct *, if (_T) put_task_struct(_T),
+	     find_get_task(pid), pid_t pid)
+
 /*
  * sched_setparam() passes in -1 for its policy, to let the functions
  * it calls know not to change it.
@@ -7462,14 +7477,11 @@ static void __setscheduler_params(struct
 static bool check_same_owner(struct task_struct *p)
 {
 	const struct cred *cred = current_cred(), *pcred;
-	bool match;
+	guard(rcu)();
 
-	rcu_read_lock();
 	pcred = __task_cred(p);
-	match = (uid_eq(cred->euid, pcred->euid) ||
-		 uid_eq(cred->euid, pcred->uid));
-	rcu_read_unlock();
-	return match;
+	return (uid_eq(cred->euid, pcred->euid) ||
+		uid_eq(cred->euid, pcred->uid));
 }
 
 /*
@@ -7873,27 +7885,17 @@ static int
 do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
 	struct sched_param lparam;
-	struct task_struct *p;
-	int retval;
 
 	if (!param || pid < 0)
 		return -EINVAL;
 	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
 		return -EFAULT;
 
-	rcu_read_lock();
-	retval = -ESRCH;
-	p = find_process_by_pid(pid);
-	if (likely(p))
-		get_task_struct(p);
-	rcu_read_unlock();
-
-	if (likely(p)) {
-		retval = sched_setscheduler(p, policy, &lparam);
-		put_task_struct(p);
-	}
+	CLASS(find_get_task, p)(pid);
+	if (!p)
+		return -ESRCH;
 
-	return retval;
+	return sched_setscheduler(p, policy, &lparam);
 }
 
 /*
@@ -7989,7 +7991,6 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pi
 			       unsigned int, flags)
 {
 	struct sched_attr attr;
-	struct task_struct *p;
 	int retval;
 
 	if (!uattr || pid < 0 || flags)
@@ -8004,21 +8005,14 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pi
 	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
 		attr.sched_policy = SETPARAM_POLICY;
 
-	rcu_read_lock();
-	retval = -ESRCH;
-	p = find_process_by_pid(pid);
-	if (likely(p))
-		get_task_struct(p);
-	rcu_read_unlock();
+	CLASS(find_get_task, p)(pid);
+	if (!p)
+		return -ESRCH;
 
-	if (likely(p)) {
-		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
-			get_params(p, &attr);
-		retval = sched_setattr(p, &attr);
-		put_task_struct(p);
-	}
+	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
+		get_params(p, &attr);
 
-	return retval;
+	return sched_setattr(p, &attr);
 }
 
 /**
@@ -8036,16 +8030,17 @@ SYSCALL_DEFINE1(sched_getscheduler, pid_
 	if (pid < 0)
 		return -EINVAL;
 
-	retval = -ESRCH;
-	rcu_read_lock();
+	guard(rcu)();
 	p = find_process_by_pid(pid);
-	if (p) {
-		retval = security_task_getscheduler(p);
-		if (!retval)
-			retval = p->policy
-				| (p->sched_reset_on_fork ? SCHED_RESET_ON_FORK : 0);
+	if (!p)
+		return -ESRCH;
+
+	retval = security_task_getscheduler(p);
+	if (!retval) {
+		retval = p->policy;
+		if (p->sched_reset_on_fork)
+			retval |= SCHED_RESET_ON_FORK;
 	}
-	rcu_read_unlock();
 	return retval;
 }
 
@@ -8066,30 +8061,23 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, p
 	if (!param || pid < 0)
 		return -EINVAL;
 
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	retval = -ESRCH;
-	if (!p)
-		goto out_unlock;
+	scoped_guard (rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
 
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
 
-	if (task_has_rt_policy(p))
-		lp.sched_priority = p->rt_priority;
-	rcu_read_unlock();
+		if (task_has_rt_policy(p))
+			lp.sched_priority = p->rt_priority;
+	}
 
 	/*
 	 * This one might sleep, we cannot do it with a spinlock held ...
 	 */
-	retval = copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
-
-	return retval;
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
+	return copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
 }
 
 /*
@@ -8149,39 +8137,33 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pi
 	    usize < SCHED_ATTR_SIZE_VER0 || flags)
 		return -EINVAL;
 
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	retval = -ESRCH;
-	if (!p)
-		goto out_unlock;
+	scoped_guard (rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
 
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
 
-	kattr.sched_policy = p->policy;
-	if (p->sched_reset_on_fork)
-		kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
-	get_params(p, &kattr);
-	kattr.sched_flags &= SCHED_FLAG_ALL;
+		kattr.sched_policy = p->policy;
+		if (p->sched_reset_on_fork)
+			kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
+		get_params(p, &kattr);
+		kattr.sched_flags &= SCHED_FLAG_ALL;
 
 #ifdef CONFIG_UCLAMP_TASK
-	/*
-	 * This could race with another potential updater, but this is fine
-	 * because it'll correctly read the old or the new value. We don't need
-	 * to guarantee who wins the race as long as it doesn't return garbage.
-	 */
-	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
-	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
+		/*
+		 * This could race with another potential updater, but this is fine
+		 * because it'll correctly read the old or the new value. We don't need
+		 * to guarantee who wins the race as long as it doesn't return garbage.
+		 */
+		kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
+		kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
 #endif
-
-	rcu_read_unlock();
+	}
 
 	return sched_attr_copy_to_user(uattr, &kattr, usize);
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
 }
 
 #ifdef CONFIG_SMP


