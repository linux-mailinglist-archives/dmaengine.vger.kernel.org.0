Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7595A72BD3D
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjFLJzc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjFLJyV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A47B4C0E;
        Mon, 12 Jun 2023 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=MG7QpnmCwLygWJ81Mn2iabAPA0zngwNBxpS2UJOPCco=; b=PgmXbkmwG9TYpDGdocx+LtR6tM
        l370b2N9nNxi1RmPWxCNObTJ4Voj6TnwUaEMamYzTJY6EkmNWG1KMSqPUKs7IW+4Maipk3vvMjEFR
        ZaMxjhNAcQQyGWTARi2LdpPcjAIDpMadcwYBjkd27vA7PC1Va2aKU7sfH8xVuq7SvVINulgGTJ51x
        XjR8xr7yUJ3LF2wwQJd4xe6tOSQnyO6M7lQz1xek40kDnSUJiKz9biq82Fj0QVkT0KEsORIAJNpYr
        dGHAHUGeUs4DbodpgoR1h3ajXFzvYjku3P4L5rQcre7lw9MZ79S1OiErMltwKmghwzvlIgQByVkHx
        pDKs2gjQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0g-002N99-Aw; Mon, 12 Jun 2023 09:38:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E71BC303196;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 46BE630A77B54; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093538.465891562@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:27 +0200
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
Subject: [PATCH v3 14/57] sched: Simplify set_user_nice()
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
 kernel/sched/core.c  |   13 ++++++-------
 kernel/sched/sched.h |    5 +++++
 2 files changed, 11 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7119,9 +7119,8 @@ static inline int rt_effective_prio(stru
 void set_user_nice(struct task_struct *p, long nice)
 {
 	bool queued, running;
-	int old_prio;
-	struct rq_flags rf;
 	struct rq *rq;
+	int old_prio;
 
 	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
 		return;
@@ -7129,7 +7128,9 @@ void set_user_nice(struct task_struct *p
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	rq = task_rq_lock(p, &rf);
+	CLASS(task_rq_lock, rq_guard)(p);
+	rq = rq_guard.rq;
+
 	update_rq_clock(rq);
 
 	/*
@@ -7140,8 +7141,9 @@ void set_user_nice(struct task_struct *p
 	 */
 	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
 		p->static_prio = NICE_TO_PRIO(nice);
-		goto out_unlock;
+		return;
 	}
+
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 	if (queued)
@@ -7164,9 +7166,6 @@ void set_user_nice(struct task_struct *p
 	 * lowered its priority, then reschedule its CPU:
 	 */
 	p->sched_class->prio_changed(rq, p, old_prio);
-
-out_unlock:
-	task_rq_unlock(rq, p, &rf);
 }
 EXPORT_SYMBOL(set_user_nice);
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1630,6 +1630,11 @@ task_rq_unlock(struct rq *rq, struct tas
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
+DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
+		    _T->rq = task_rq_lock(_T->lock, &_T->rf),
+		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
+		    struct rq *rq; struct rq_flags rf)
+
 static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)


