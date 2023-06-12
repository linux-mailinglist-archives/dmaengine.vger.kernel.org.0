Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370A972BD51
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjFLJzn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjFLJyZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25155FF3;
        Mon, 12 Jun 2023 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9sqy4wj1SuZG+E1ZOkNDiw8zR5F8T4bHRpYkByM8S6o=; b=HNjtc1kou6jUKrPa93YlSTKipB
        VhOpXUPSBCgjriMwtuZYiFbSO92NjXbfCsFmRFtzO7yfFSXIVuY/yN+Yj7pGBcnBI5S0hv8fNdtcN
        //wmbKzY575t4i5oKfCiWpecYl0rAG6BFfdMSjKIXuCRhpuWcyhO2gVcrMTipwAY6sjO79StTEAIQ
        VC8/ybwDlXuWf1vL/cHd1fVTSgl2eqKrBrD54rFBuftQGd/gu653fosXknQhYF8Op6cNrlThojVpp
        8VS39gvDd4GbsgBVynRhv46UkSxPgULiSAQIabpdcmA7w8/j+yhjfaJwXT+KXZjarghiosRq198gW
        o3zyz1kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0g-008kPB-1k;
        Mon, 12 Jun 2023 09:38:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0BFFE3031BE;
        Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5832930A77B57; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093538.712217968@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:30 +0200
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
Subject: [PATCH v3 17/57] sched: Simplify yield_to()
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
 kernel/sched/core.c |   73 ++++++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8799,55 +8799,46 @@ int __sched yield_to(struct task_struct
 {
 	struct task_struct *curr = current;
 	struct rq *rq, *p_rq;
-	unsigned long flags;
 	int yielded = 0;
 
-	local_irq_save(flags);
-	rq = this_rq();
+	scoped_guard (irqsave) {
+		rq = this_rq();
 
 again:
-	p_rq = task_rq(p);
-	/*
-	 * If we're the only runnable task on the rq and target rq also
-	 * has only one task, there's absolutely no point in yielding.
-	 */
-	if (rq->nr_running == 1 && p_rq->nr_running == 1) {
-		yielded = -ESRCH;
-		goto out_irq;
-	}
-
-	double_rq_lock(rq, p_rq);
-	if (task_rq(p) != p_rq) {
-		double_rq_unlock(rq, p_rq);
-		goto again;
-	}
-
-	if (!curr->sched_class->yield_to_task)
-		goto out_unlock;
-
-	if (curr->sched_class != p->sched_class)
-		goto out_unlock;
-
-	if (task_on_cpu(p_rq, p) || !task_is_running(p))
-		goto out_unlock;
-
-	yielded = curr->sched_class->yield_to_task(rq, p);
-	if (yielded) {
-		schedstat_inc(rq->yld_count);
+		p_rq = task_rq(p);
 		/*
-		 * Make p's CPU reschedule; pick_next_entity takes care of
-		 * fairness.
+		 * If we're the only runnable task on the rq and target rq also
+		 * has only one task, there's absolutely no point in yielding.
 		 */
-		if (preempt && rq != p_rq)
-			resched_curr(p_rq);
-	}
+		if (rq->nr_running == 1 && p_rq->nr_running == 1)
+			return -ESRCH;
 
-out_unlock:
-	double_rq_unlock(rq, p_rq);
-out_irq:
-	local_irq_restore(flags);
+		guard(double_rq_lock)(rq, p_rq);
+		if (task_rq(p) != p_rq)
+			goto again;
+
+		if (!curr->sched_class->yield_to_task)
+			return 0;
+
+		if (curr->sched_class != p->sched_class)
+			return 0;
+
+		if (task_on_cpu(p_rq, p) || !task_is_running(p))
+			return 0;
+
+		yielded = curr->sched_class->yield_to_task(rq, p);
+		if (yielded) {
+			schedstat_inc(rq->yld_count);
+			/*
+			 * Make p's CPU reschedule; pick_next_entity
+			 * takes care of fairness.
+			 */
+			if (preempt && rq != p_rq)
+				resched_curr(p_rq);
+		}
+	}
 
-	if (yielded > 0)
+	if (yielded)
 		schedule();
 
 	return yielded;


