Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7A72BD4F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjFLJ4P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjFLJyt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7813C6194;
        Mon, 12 Jun 2023 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RhYZOzjhfuM83rgB0LmGBa7KCuiBOYTp/1b5fR4CJwQ=; b=pSR3Z8fO6gr0uz5UWx2Wyw0kGx
        c1o1XlzkEwbDa5cj/bws9XTOvobvWPaOGxfhF5QetTedfpp/QOmEWHq0NTU6ex0rTYovD347ZGewn
        fH4Tw61mxcPaHR+PDhLO/3iaGemM4DeeOBHNSzaohc6qdEuO0r92dZ/ENI/jQYdUQ0UrlMQsOPZmv
        WIJJ61PjIIyC4LP20xi9YYGkJNkPfRYnFsCYTW+EIw29iW6OJMrGRT6MX3Vn6PkUFIPpQNLGGzPdJ
        gt47YzrV/4mHp6S7t5DoD0bmp1j9D59G3YN/7mt7PrQ1SjRQhxKa4QFmFcncoQdj3C2n3dN3xqTMW
        znFwO2KA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0x-002NLY-Ri; Mon, 12 Jun 2023 09:39:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 761CF30614E;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 322B430A79087; Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Message-ID: <20230612093541.454144142@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:08:07 +0200
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
Subject: [PATCH v3 54/57] perf: Misc cleanups
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
 kernel/events/core.c |   64 +++++++++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1274,13 +1274,11 @@ perf_event_ctx_lock_nested(struct perf_e
 	struct perf_event_context *ctx;
 
 again:
-	rcu_read_lock();
-	ctx = READ_ONCE(event->ctx);
-	if (!refcount_inc_not_zero(&ctx->refcount)) {
-		rcu_read_unlock();
-		goto again;
+	scoped_guard (rcu) {
+		ctx = READ_ONCE(event->ctx);
+		if (!refcount_inc_not_zero(&ctx->refcount))
+			goto again;
 	}
-	rcu_read_unlock();
 
 	mutex_lock_nested(&ctx->mutex, nesting);
 	if (event->ctx != ctx) {
@@ -2254,7 +2252,7 @@ event_sched_out(struct perf_event *event
 	 */
 	list_del_init(&event->active_list);
 
-	perf_pmu_disable(event->pmu);
+	guard(perf_pmu_disable)(event->pmu);
 
 	event->pmu->del(event, 0);
 	event->oncpu = -1;
@@ -2288,8 +2286,6 @@ event_sched_out(struct perf_event *event
 		ctx->nr_freq--;
 	if (event->attr.exclusive || !cpc->active_oncpu)
 		cpc->exclusive = 0;
-
-	perf_pmu_enable(event->pmu);
 }
 
 static void
@@ -3219,7 +3215,8 @@ static void __pmu_ctx_sched_out(struct p
 	if (!event_type)
 		return;
 
-	perf_pmu_disable(pmu);
+	guard(perf_pmu_disable)(pmu);
+
 	if (event_type & EVENT_PINNED) {
 		list_for_each_entry_safe(event, tmp,
 					 &pmu_ctx->pinned_active,
@@ -3239,7 +3236,6 @@ static void __pmu_ctx_sched_out(struct p
 		 */
 		pmu_ctx->rotate_necessary = 0;
 	}
-	perf_pmu_enable(pmu);
 }
 
 static void
@@ -3586,13 +3582,10 @@ static void __perf_pmu_sched_task(struct
 	if (WARN_ON_ONCE(!pmu->sched_task))
 		return;
 
-	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-	perf_pmu_disable(pmu);
+	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
+	guard(perf_pmu_disable)(pmu);
 
 	pmu->sched_task(cpc->task_epc, sched_in);
-
-	perf_pmu_enable(pmu);
-	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
 static void perf_pmu_sched_task(struct task_struct *prev,
@@ -12655,8 +12648,6 @@ static void __perf_pmu_install_event(str
 				     struct perf_event_context *ctx,
 				     int cpu, struct perf_event *event)
 {
-	struct perf_event_pmu_context *epc;
-
 	/*
 	 * Now that the events are unused, put their old ctx and grab a
 	 * reference on the new context.
@@ -12665,8 +12656,7 @@ static void __perf_pmu_install_event(str
 	get_ctx(ctx);
 
 	event->cpu = cpu;
-	epc = find_get_pmu_context(pmu, ctx, event);
-	event->pmu_ctx = epc;
+	event->pmu_ctx = find_get_pmu_context(pmu, ctx, event);
 
 	if (event->state >= PERF_EVENT_STATE_OFF)
 		event->state = PERF_EVENT_STATE_INACTIVE;
@@ -12815,12 +12805,12 @@ perf_event_exit_event(struct perf_event
 
 static void perf_event_exit_task_context(struct task_struct *child)
 {
-	struct perf_event_context *child_ctx, *clone_ctx = NULL;
+	struct perf_event_context *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
 
 	WARN_ON_ONCE(child != current);
 
-	child_ctx = perf_pin_task_context(child);
+	CLASS(pin_task_ctx, child_ctx)(child);
 	if (!child_ctx)
 		return;
 
@@ -12834,27 +12824,27 @@ static void perf_event_exit_task_context
 	 * without ctx::mutex (it cannot because of the move_group double mutex
 	 * lock thing). See the comments in perf_install_in_context().
 	 */
-	mutex_lock(&child_ctx->mutex);
+	guard(mutex)(&child_ctx->mutex);
 
 	/*
 	 * In a single ctx::lock section, de-schedule the events and detach the
 	 * context from the task such that we cannot ever get it scheduled back
 	 * in.
 	 */
-	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(child_ctx, EVENT_ALL);
+	scoped_guard (raw_spinlock_irq, &child_ctx->lock) {
+		task_ctx_sched_out(child_ctx, EVENT_ALL);
 
-	/*
-	 * Now that the context is inactive, destroy the task <-> ctx relation
-	 * and mark the context dead.
-	 */
-	RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
-	put_ctx(child_ctx); /* cannot be last */
-	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
-	put_task_struct(current); /* cannot be last */
+		/*
+		 * Now that the context is inactive, destroy the task <-> ctx
+		 * relation and mark the context dead.
+		 */
+		RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
+		put_ctx(child_ctx); /* cannot be last */
+		WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
+		put_task_struct(current); /* cannot be last */
 
-	clone_ctx = unclone_ctx(child_ctx);
-	raw_spin_unlock_irq(&child_ctx->lock);
+		clone_ctx = unclone_ctx(child_ctx);
+	}
 
 	if (clone_ctx)
 		put_ctx(clone_ctx);
@@ -12868,10 +12858,6 @@ static void perf_event_exit_task_context
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
 		perf_event_exit_event(child_event, child_ctx);
-
-	mutex_unlock(&child_ctx->mutex);
-
-	put_ctx(child_ctx);
 }
 
 /*


