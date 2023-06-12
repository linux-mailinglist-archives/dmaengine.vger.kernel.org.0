Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A831A72BD8D
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjFLJzo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjFLJyY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7806B5FF2;
        Mon, 12 Jun 2023 02:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tN5fF7Wyh35qBJFCdjEuKMaMwIiqau8XmW0j2x/SMjk=; b=pTQEAHGpF5fz0pLIBta9z8QWvF
        V3VTKbdm5MrZ6Uq6sIyVOPIlJRamTVCnfvzmEg5CiuDQWZwIOhMu3l9PZQuNwkMb8MTxXwLb05k1F
        pXKfEwe9Z0i663rYdw9pUPCOE+2AHi/lm0RzSNXMm4U2w1iNa1ZIxBs9afcsQW/V20UMXzYer3WCT
        zF9DC46u7wLZd3iCRc+AmRVnu9fCua5kGt94sVVOX6RESLLLndvS1OIwmKToKe+pfW/q3/OlKUMUJ
        NzNjcl62XQoQkQaJg1jmU538/Cwb5EJWwMJr4XxONBZWuSlObMm3Fh7GXzLLBUAOiqFAhv2ZaNNZD
        zVv+iV3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0g-002N98-AY; Mon, 12 Jun 2023 09:38:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8E9630318E;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 416A530A70ADF; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093538.393498853@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:26 +0200
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
Subject: [PATCH v3 13/57] sched: Simplify sched_core_cpu_{starting,deactivate}()
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
 kernel/sched/core.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6331,20 +6331,24 @@ static void queue_core_balance(struct rq
 	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
 }
 
+DEFINE_LOCK_GUARD_1(core_lock, int,
+		    sched_core_lock(*_T->lock, &_T->flags),
+		    sched_core_unlock(*_T->lock, &_T->flags),
+		    unsigned long flags)
+
 static void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
-	unsigned long flags;
 	int t;
 
-	sched_core_lock(cpu, &flags);
+	guard(core_lock)(&cpu);
 
 	WARN_ON_ONCE(rq->core != rq);
 
 	/* if we're the first, we'll be our own leader */
 	if (cpumask_weight(smt_mask) == 1)
-		goto unlock;
+		return;
 
 	/* find the leader */
 	for_each_cpu(t, smt_mask) {
@@ -6358,7 +6362,7 @@ static void sched_core_cpu_starting(unsi
 	}
 
 	if (WARN_ON_ONCE(!core_rq)) /* whoopsie */
-		goto unlock;
+		return;
 
 	/* install and validate core_rq */
 	for_each_cpu(t, smt_mask) {
@@ -6369,29 +6373,25 @@ static void sched_core_cpu_starting(unsi
 
 		WARN_ON_ONCE(rq->core != core_rq);
 	}
-
-unlock:
-	sched_core_unlock(cpu, &flags);
 }
 
 static void sched_core_cpu_deactivate(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
-	unsigned long flags;
 	int t;
 
-	sched_core_lock(cpu, &flags);
+	guard(core_lock)(&cpu);
 
 	/* if we're the last man standing, nothing to do */
 	if (cpumask_weight(smt_mask) == 1) {
 		WARN_ON_ONCE(rq->core != rq);
-		goto unlock;
+		return;
 	}
 
 	/* if we're not the leader, nothing to do */
 	if (rq->core != rq)
-		goto unlock;
+		return;
 
 	/* find a new leader */
 	for_each_cpu(t, smt_mask) {
@@ -6402,7 +6402,7 @@ static void sched_core_cpu_deactivate(un
 	}
 
 	if (WARN_ON_ONCE(!core_rq)) /* impossible */
-		goto unlock;
+		return;
 
 	/* copy the shared state to the new leader */
 	core_rq->core_task_seq             = rq->core_task_seq;
@@ -6424,9 +6424,6 @@ static void sched_core_cpu_deactivate(un
 		rq = cpu_rq(t);
 		rq->core = core_rq;
 	}
-
-unlock:
-	sched_core_unlock(cpu, &flags);
 }
 
 static inline void sched_core_cpu_dying(unsigned int cpu)


