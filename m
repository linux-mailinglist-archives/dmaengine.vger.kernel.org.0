Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5C72BD58
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjFLJzq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjFLJy2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E735FFA;
        Mon, 12 Jun 2023 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RF7AlZRmRPruwiE6WSJ8fgsVWKVvpbmYdppCd/KBEkQ=; b=gufB5guI2wjztq+YIlaWdjMhyv
        3LYfsbSy4unkOyd2ugwudXuVbPkgYZFtkZVII3Xqay+tH7nkG1yTdrFKTcjUHvpAa8Cf37YLpt3E8
        pDLxbYYLfAa1grWsAGwn5LQLL4FRD+9IBx4VEM4Gmq/oyW3fFf8dLVvIRA7oBGmGxTO7R049FIU1t
        r4XaxNuX7StfRoeJQ7EQPUjJFlffCIlkZhBv+EjHy6R48CogNzg2OSLrwlw3rCqTLDkgHr+w7wF/Q
        ZOTFC2+xYVUW9aU01AvEkNjTt06XQEZg/5knH9qw46D4tqiWNFnLETrbsKjwwTivhd6RHKFM2hAvf
        JA52UjPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0l-002NBd-VJ; Mon, 12 Jun 2023 09:38:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27CCF3031BE;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A1B8930A77B67; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.682563843@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:43 +0200
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
Subject: [PATCH v3 30/57] perf: Simplify: *perf_event_{dis,en}able*()
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
 kernel/events/core.c |   51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2415,7 +2415,7 @@ static void __perf_event_disable(struct
 		update_cgrp_time_from_event(event);
 	}
 
-	perf_pmu_disable(event->pmu_ctx->pmu);
+	guard(perf_pmu_disable)(event->pmu_ctx->pmu);
 
 	if (event == event->group_leader)
 		group_sched_out(event, ctx);
@@ -2424,8 +2424,6 @@ static void __perf_event_disable(struct
 
 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
 	perf_cgroup_event_disable(event, ctx);
-
-	perf_pmu_enable(event->pmu_ctx->pmu);
 }
 
 /*
@@ -2446,12 +2444,10 @@ static void _perf_event_disable(struct p
 {
 	struct perf_event_context *ctx = event->ctx;
 
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state <= PERF_EVENT_STATE_OFF) {
-		raw_spin_unlock_irq(&ctx->lock);
-		return;
+	scoped_guard (raw_spinlock_irq, &ctx->lock) {
+		if (event->state <= PERF_EVENT_STATE_OFF)
+			return;
 	}
-	raw_spin_unlock_irq(&ctx->lock);
 
 	event_function_call(event, __perf_event_disable, NULL);
 }
@@ -2955,32 +2951,29 @@ static void _perf_event_enable(struct pe
 {
 	struct perf_event_context *ctx = event->ctx;
 
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
-	    event->state <  PERF_EVENT_STATE_ERROR) {
-out:
-		raw_spin_unlock_irq(&ctx->lock);
-		return;
-	}
+	scoped_guard (raw_spinlock_irq, &ctx->lock) {
+		if (event->state >= PERF_EVENT_STATE_INACTIVE ||
+		    event->state <  PERF_EVENT_STATE_ERROR)
+			return;
 
-	/*
-	 * If the event is in error state, clear that first.
-	 *
-	 * That way, if we see the event in error state below, we know that it
-	 * has gone back into error state, as distinct from the task having
-	 * been scheduled away before the cross-call arrived.
-	 */
-	if (event->state == PERF_EVENT_STATE_ERROR) {
 		/*
-		 * Detached SIBLING events cannot leave ERROR state.
+		 * If the event is in error state, clear that first.
+		 *
+		 * That way, if we see the event in error state below, we know that it
+		 * has gone back into error state, as distinct from the task having
+		 * been scheduled away before the cross-call arrived.
 		 */
-		if (event->event_caps & PERF_EV_CAP_SIBLING &&
-		    event->group_leader == event)
-			goto out;
+		if (event->state == PERF_EVENT_STATE_ERROR) {
+			/*
+			 * Detached SIBLING events cannot leave ERROR state.
+			 */
+			if (event->event_caps & PERF_EV_CAP_SIBLING &&
+			    event->group_leader == event)
+				return;
 
-		event->state = PERF_EVENT_STATE_OFF;
+			event->state = PERF_EVENT_STATE_OFF;
+		}
 	}
-	raw_spin_unlock_irq(&ctx->lock);
 
 	event_function_call(event, __perf_event_enable, NULL);
 }


