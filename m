Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12A172BD36
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjFLJz1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjFLJyV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D994C09;
        Mon, 12 Jun 2023 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vDHS8Plr2cencdpiH/auo6E776oNoOhgYdcpKlgKc4Q=; b=XfspiS8Usbqb2dpT01GShTpXYF
        0wwyX4AcSTYBMwe4XCE0JXv0GEXukM5Z+wJrQ5ydemtoQKvufj+e0HtUrkEv50Xk/7NS5f+kXoBH9
        NRHSIXz+gP5a9fY839hRRMg3XMU8GiI1b3Pt7sMPV4OqaS+t6EGwmATXLiqnN97MCbKsORuHO2Pr8
        vz3ITtR3OFV8f2JSdzAkJYccKWoz7g4QT5P8RYF55XvZaHjj/8iBTBPAQu9E+hOhqdBtj1hgmbPlJ
        c78PyIoTct3THwyJGFh1bmBuUYmoopUkjAyRnngrF2sMB5pJoA+wZWUNb+w3pp3J3RKYPSrqc3iKz
        xqluhn6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0g-008kPA-1f;
        Mon, 12 Jun 2023 09:38:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04CC13031B9;
        Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 53B9E30A77B56; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093538.640502622@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:29 +0200
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
Subject: [PATCH v3 16/57] sched: Simplify sched_{set,get}affinity()
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
 kernel/sched/core.c |   53 +++++++++++++---------------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8258,39 +8258,24 @@ long sched_setaffinity(pid_t pid, const
 {
 	struct affinity_context ac;
 	struct cpumask *user_mask;
-	struct task_struct *p;
 	int retval;
 
-	rcu_read_lock();
-
-	p = find_process_by_pid(pid);
-	if (!p) {
-		rcu_read_unlock();
+	CLASS(find_get_task, p)(pid);
+	if (!p)
 		return -ESRCH;
-	}
 
-	/* Prevent p going away */
-	get_task_struct(p);
-	rcu_read_unlock();
-
-	if (p->flags & PF_NO_SETAFFINITY) {
-		retval = -EINVAL;
-		goto out_put_task;
-	}
+	if (p->flags & PF_NO_SETAFFINITY)
+		return -EINVAL;
 
 	if (!check_same_owner(p)) {
-		rcu_read_lock();
-		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
-			rcu_read_unlock();
-			retval = -EPERM;
-			goto out_put_task;
-		}
-		rcu_read_unlock();
+		guard(rcu)();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE))
+			return -EPERM;
 	}
 
 	retval = security_task_setscheduler(p);
 	if (retval)
-		goto out_put_task;
+		return retval;
 
 	/*
 	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
@@ -8300,8 +8285,7 @@ long sched_setaffinity(pid_t pid, const
 	if (user_mask) {
 		cpumask_copy(user_mask, in_mask);
 	} else if (IS_ENABLED(CONFIG_SMP)) {
-		retval = -ENOMEM;
-		goto out_put_task;
+		return -ENOMEM;
 	}
 
 	ac = (struct affinity_context){
@@ -8313,8 +8297,6 @@ long sched_setaffinity(pid_t pid, const
 	retval = __sched_setaffinity(p, &ac);
 	kfree(ac.user_mask);
 
-out_put_task:
-	put_task_struct(p);
 	return retval;
 }
 
@@ -8356,28 +8338,21 @@ SYSCALL_DEFINE3(sched_setaffinity, pid_t
 long sched_getaffinity(pid_t pid, struct cpumask *mask)
 {
 	struct task_struct *p;
-	unsigned long flags;
 	int retval;
 
-	rcu_read_lock();
-
-	retval = -ESRCH;
+	guard(rcu)();
 	p = find_process_by_pid(pid);
 	if (!p)
-		goto out_unlock;
+		return -ESRCH;
 
 	retval = security_task_getscheduler(p);
 	if (retval)
-		goto out_unlock;
+		return retval;
 
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	guard(raw_spinlock_irqsave)(&p->pi_lock);
 	cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
-out_unlock:
-	rcu_read_unlock();
-
-	return retval;
+	return 0;
 }
 
 /**


