Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0585072BD8B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjFLJzw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjFLJyc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9C6189;
        Mon, 12 Jun 2023 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0Nln3H/TQf9zjJAhRuDD5Vdsf6AHs8EETAgdoNVjkyE=; b=aLyzlCpjSY84iDgpsEBBBGJX3P
        lK9yNsqeaoP3u7ZT5H3JL27+RTLru0GApQ5l1v5uV8i/wJIkHH27c0wmrJ/GCkYQ/G7TqE972r+Z4
        olS6TpdyK9sVlqg98ePCC+diSOfoU1XnPSfTCvcxnVGIIzofX5B72ITAND3PEzyTDUpjkk1zcu8Ub
        PdMjf6R10+giGpo+mqNbqKy4UQa4reNeKvcpiwdZPnE+1yKAYR8IhUcKfW8HYKgRVSbmBWw9pmlCJ
        zqWAeUSmHhgSXgznUhoQ3Aaf3QwuEHOuaRjzBPrKSygfGuGbdsxJRVlJjK0e4SLbm0NNjGwLzFteH
        qxfDrnkg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0m-008kQi-0Q;
        Mon, 12 Jun 2023 09:39:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EF723032BD;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B8BAA30A77B6C; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.966607037@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:47 +0200
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
Subject: [PATCH v3 34/57] perf: Simplify perf_event_*_on_exec()
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
 kernel/events/core.c |   88 +++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 48 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4318,39 +4318,36 @@ static void perf_event_enable_on_exec(st
 	enum event_type_t event_type = 0;
 	struct perf_cpu_context *cpuctx;
 	struct perf_event *event;
-	unsigned long flags;
 	int enabled = 0;
 
-	local_irq_save(flags);
-	if (WARN_ON_ONCE(current->perf_event_ctxp != ctx))
-		goto out;
-
-	if (!ctx->nr_events)
-		goto out;
-
-	cpuctx = this_cpu_ptr(&perf_cpu_context);
-	perf_ctx_lock(cpuctx, ctx);
-	ctx_sched_out(ctx, EVENT_TIME);
-
-	list_for_each_entry(event, &ctx->event_list, event_entry) {
-		enabled |= event_enable_on_exec(event, ctx);
-		event_type |= get_event_type(event);
+	scoped_guard (irqsave) {
+		if (WARN_ON_ONCE(current->perf_event_ctxp != ctx))
+			return;
+
+		if (!ctx->nr_events)
+			return;
+
+		cpuctx = this_cpu_ptr(&perf_cpu_context);
+		guard(perf_ctx_lock)(cpuctx, ctx);
+
+		ctx_sched_out(ctx, EVENT_TIME);
+
+		list_for_each_entry(event, &ctx->event_list, event_entry) {
+			enabled |= event_enable_on_exec(event, ctx);
+			event_type |= get_event_type(event);
+		}
+
+		/*
+		 * Unclone and reschedule this context if we enabled any event.
+		 */
+		if (enabled) {
+			clone_ctx = unclone_ctx(ctx);
+			ctx_resched(cpuctx, ctx, event_type);
+		} else {
+			ctx_sched_in(ctx, EVENT_TIME);
+		}
 	}
 
-	/*
-	 * Unclone and reschedule this context if we enabled any event.
-	 */
-	if (enabled) {
-		clone_ctx = unclone_ctx(ctx);
-		ctx_resched(cpuctx, ctx, event_type);
-	} else {
-		ctx_sched_in(ctx, EVENT_TIME);
-	}
-	perf_ctx_unlock(cpuctx, ctx);
-
-out:
-	local_irq_restore(flags);
-
 	if (clone_ctx)
 		put_ctx(clone_ctx);
 }
@@ -4367,34 +4364,29 @@ static void perf_event_remove_on_exec(st
 {
 	struct perf_event_context *clone_ctx = NULL;
 	struct perf_event *event, *next;
-	unsigned long flags;
 	bool modified = false;
 
-	mutex_lock(&ctx->mutex);
+	scoped_guard (mutex, &ctx->mutex) {
+		if (WARN_ON_ONCE(ctx->task != current))
+			return;
 
-	if (WARN_ON_ONCE(ctx->task != current))
-		goto unlock;
+		list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+			if (!event->attr.remove_on_exec)
+				continue;
 
-	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
-		if (!event->attr.remove_on_exec)
-			continue;
+			if (!is_kernel_event(event))
+				perf_remove_from_owner(event);
 
-		if (!is_kernel_event(event))
-			perf_remove_from_owner(event);
+			modified = true;
 
-		modified = true;
+			perf_event_exit_event(event, ctx);
+		}
 
-		perf_event_exit_event(event, ctx);
+		guard(raw_spinlock_irqsave)(&ctx->lock);
+		if (modified)
+			clone_ctx = unclone_ctx(ctx);
 	}
 
-	raw_spin_lock_irqsave(&ctx->lock, flags);
-	if (modified)
-		clone_ctx = unclone_ctx(ctx);
-	raw_spin_unlock_irqrestore(&ctx->lock, flags);
-
-unlock:
-	mutex_unlock(&ctx->mutex);
-
 	if (clone_ctx)
 		put_ctx(clone_ctx);
 }


