Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9372BD63
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjFLJzv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFLJyb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F1F6185;
        Mon, 12 Jun 2023 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IwZQFShSV/PIl8fTfPc9l4QCHQp32ssy80H3iz5Si2g=; b=n2QBRERGYOTGa4H4UfPiQMxml4
        DlIa7Bh+E0wy752HUyfCxpdFro63TOC2IKp9jPE5GAfa1mJYpUhJg7mXGYIHTeDn9BySpGXGbyVd3
        IwJesqbM7Wb3W3h6YpQgJKi2jBSkPrZDWblalKMV6HQ84Jsy2sFXbKyI8rcW+nAOW3dJ/b920m92P
        rah0RrnGqtwQsyYb1dXy9/e8D1odgIYC+fkV2EbyFFqvSqo9mCNLgutnfVUAg637Ma+mnkR77qzmE
        PZQFREWg0jB+r3RJ1GGStrlIluYtwark33oMb5t5WyJikLV3GNXnRWJf6oZ44tLapABjEhnCdDKM9
        42/wgNSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0l-002NBI-II; Mon, 12 Jun 2023 09:38:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23BBA303196;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8C04B30A77B63; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.371360635@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:39 +0200
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
Subject: [PATCH v3 26/57] perf: Simplify event_function*()
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
 kernel/events/core.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -214,6 +214,25 @@ struct event_function_struct {
 	void *data;
 };
 
+typedef struct {
+	struct perf_cpu_context *cpuctx;
+	struct perf_event_context *ctx;
+} class_perf_ctx_lock_t;
+
+static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
+{
+	if (_T->cpuctx)
+		perf_ctx_unlock(_T->cpuctx, _T->ctx);
+}
+
+static inline class_perf_ctx_lock_t
+class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
+				struct perf_event_context *ctx)
+{
+	perf_ctx_lock(cpuctx, ctx);
+	return (class_perf_ctx_lock_t){ cpuctx, ctx };
+}
+
 static int event_function(void *info)
 {
 	struct event_function_struct *efs = info;
@@ -224,17 +243,15 @@ static int event_function(void *info)
 	int ret = 0;
 
 	lockdep_assert_irqs_disabled();
+	guard(perf_ctx_lock)(cpuctx, task_ctx);
 
-	perf_ctx_lock(cpuctx, task_ctx);
 	/*
 	 * Since we do the IPI call without holding ctx->lock things can have
 	 * changed, double check we hit the task we set out to hit.
 	 */
 	if (ctx->task) {
-		if (ctx->task != current) {
-			ret = -ESRCH;
-			goto unlock;
-		}
+		if (ctx->task != current)
+			return -ESRCH;
 
 		/*
 		 * We only use event_function_call() on established contexts,
@@ -254,8 +271,6 @@ static int event_function(void *info)
 	}
 
 	efs->func(event, cpuctx, ctx, efs->data);
-unlock:
-	perf_ctx_unlock(cpuctx, task_ctx);
 
 	return ret;
 }
@@ -329,11 +344,11 @@ static void event_function_local(struct
 		task_ctx = ctx;
 	}
 
-	perf_ctx_lock(cpuctx, task_ctx);
+	guard(perf_ctx_lock)(cpuctx, task_ctx);
 
 	task = ctx->task;
 	if (task == TASK_TOMBSTONE)
-		goto unlock;
+		return;
 
 	if (task) {
 		/*
@@ -343,18 +358,16 @@ static void event_function_local(struct
 		 */
 		if (ctx->is_active) {
 			if (WARN_ON_ONCE(task != current))
-				goto unlock;
+				return;
 
 			if (WARN_ON_ONCE(cpuctx->task_ctx != ctx))
-				goto unlock;
+				return;
 		}
 	} else {
 		WARN_ON_ONCE(&cpuctx->ctx != ctx);
 	}
 
 	func(event, cpuctx, ctx, data);
-unlock:
-	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
 #define PERF_FLAG_ALL (PERF_FLAG_FD_NO_GROUP |\


