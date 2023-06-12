Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947C472BDA4
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjFLJ4f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjFLJyu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1DF9;
        Mon, 12 Jun 2023 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/A/ePFAjeMC2GglceFED5TIbtUbkLmsSQSkhfQHRtFw=; b=kFbg2Jf4qYcn0XtHtKqR2yCbMd
        H8amaE7vnYEWxcLgDO4zyoMl9/c1f9cvqTyiAU7MH8KX+IvKKJAqW9Sf8EIweVxdv6ScrGmGJyi0P
        u8+kOhhR6xdwShh7mjg3MQDWp6nr/4UiMAukJyxwqHSwNzQ+PASFrxXd7QOcVveGNYd0JZPrR4N+g
        EYGrvk4J11hBkeUPkxIvX/hhxL1jhGJmW4HO/81uJGpYfivRaZmHYneQuLRhD2D530TvYDj3B4wW5
        K+uiqOt+PVGGlvAY8RwSAa0jFsZPi8DoURNPx2MXWp0DIkZGwYBfg4WMqhJzNkupmdNH+rBSU3Yul
        4CLnKaUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0u-008kS3-2y;
        Mon, 12 Jun 2023 09:39:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B9DF30613A;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 234A130A79084; Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Message-ID: <20230612093541.240573885@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:08:04 +0200
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
Subject: [PATCH v3 51/57] perf: Simplify perf_event_create_kernel_counter()
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
 kernel/events/core.c |   79 ++++++++++++++++-----------------------------------
 1 file changed, 26 insertions(+), 53 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12569,12 +12569,6 @@ perf_event_create_kernel_counter(struct
 				 perf_overflow_handler_t overflow_handler,
 				 void *context)
 {
-	struct perf_event_pmu_context *pmu_ctx;
-	struct perf_event_context *ctx;
-	struct perf_event *event;
-	struct pmu *pmu;
-	int err;
-
 	/*
 	 * Grouping is not supported for kernel events, neither is 'AUX',
 	 * make sure the caller's intentions are adjusted.
@@ -12582,16 +12576,16 @@ perf_event_create_kernel_counter(struct
 	if (attr->aux_output)
 		return ERR_PTR(-EINVAL);
 
-	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
+
+	struct perf_event *event __free(free_event) =
+		perf_event_alloc(attr, cpu, task, NULL, NULL,
 				 overflow_handler, context, -1);
-	if (IS_ERR(event)) {
-		err = PTR_ERR(event);
-		goto err;
-	}
+	if (IS_ERR(event))
+		return event;
 
 	/* Mark owner so we could distinguish it from user events. */
 	event->owner = TASK_TOMBSTONE;
-	pmu = event->pmu;
+	struct pmu *pmu = event->pmu;
 
 	if (pmu->task_ctx_nr == perf_sw_context)
 		event->event_caps |= PERF_EV_CAP_SOFTWARE;
@@ -12599,25 +12593,21 @@ perf_event_create_kernel_counter(struct
 	/*
 	 * Get the target context (task or percpu):
 	 */
-	ctx = find_get_context(task, event);
-	if (IS_ERR(ctx)) {
-		err = PTR_ERR(ctx);
-		goto err_alloc;
-	}
+	CLASS(find_get_ctx, ctx)(task, event);
+	if (IS_ERR(ctx))
+		return (void *)ctx;
 
 	WARN_ON_ONCE(ctx->parent_ctx);
-	mutex_lock(&ctx->mutex);
-	if (ctx->task == TASK_TOMBSTONE) {
-		err = -ESRCH;
-		goto err_unlock;
-	}
+	guard(mutex)(&ctx->mutex);
 
-	pmu_ctx = find_get_pmu_context(pmu, ctx, event);
-	if (IS_ERR(pmu_ctx)) {
-		err = PTR_ERR(pmu_ctx);
-		goto err_unlock;
-	}
-	event->pmu_ctx = pmu_ctx;
+	if (ctx->task == TASK_TOMBSTONE)
+		return ERR_PTR(-ESRCH);
+
+
+	struct perf_event_pmu_context *pmu_ctx __free(put_pmu_ctx) =
+		find_get_pmu_context(pmu, ctx, event);
+	if (!pmu_ctx)
+		return ERR_PTR(-ENOMEM);
 
 	if (!task) {
 		/*
@@ -12628,34 +12618,17 @@ perf_event_create_kernel_counter(struct
 		 */
 		struct perf_cpu_context *cpuctx =
 			container_of(ctx, struct perf_cpu_context, ctx);
-		if (!cpuctx->online) {
-			err = -ENODEV;
-			goto err_pmu_ctx;
-		}
+		if (!cpuctx->online)
+			return ERR_PTR(-ENODEV);
 	}
 
-	if (!exclusive_event_installable(event, ctx)) {
-		err = -EBUSY;
-		goto err_pmu_ctx;
-	}
+	if (!exclusive_event_installable(event, ctx))
+		return ERR_PTR(-EBUSY);
+
+	event->pmu_ctx = no_free_ptr(pmu_ctx);
+	perf_install_in_context(get_ctx(ctx), event, event->cpu);
 
-	perf_install_in_context(ctx, event, event->cpu);
-	perf_unpin_context(ctx);
-	mutex_unlock(&ctx->mutex);
-
-	return event;
-
-err_pmu_ctx:
-	put_pmu_ctx(pmu_ctx);
-	event->pmu_ctx = NULL; /* _free_event() */
-err_unlock:
-	mutex_unlock(&ctx->mutex);
-	perf_unpin_context(ctx);
-	put_ctx(ctx);
-err_alloc:
-	free_event(event);
-err:
-	return ERR_PTR(err);
+	return_ptr(event);
 }
 EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
 


