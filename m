Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AF372BDB7
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjFLJ47 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjFLJy6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94603619E;
        Mon, 12 Jun 2023 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Hyp83c4zEQiDnre/2FuPX5V+t4FAU+QqZYq6E3vAduE=; b=Gtb5Ev6740h/Uu//z0ccX1hScc
        Ck98D6/rxacYaUVGPfXtg073SExo3RFg4HAVAwuEx1OEQLLt9RbdVLZs4jgS8VYz19wXPm8F7X/I+
        7WeQiyTsi1jlEeyPs1F0ihul+YLu1RJS1s+FeAP9xTHYjDaUYE3upOVxx5r6t3B62YsJAqx9lyVbj
        UC381d09c/rXGi/P9xexX5myrbqbF5MzgVQvqLhDW1yv4cmbx/NmkwAE761i6+nygyHErTIh+dwz4
        BeyuYoQfUEGmVnwjGaWuO5jR6RO3Wq+ZoiGVXZUL1/3FmffvSgadr0ZATXm7zlY8LN0s087WDHlEu
        u2+sLK9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0m-008kQo-13;
        Mon, 12 Jun 2023 09:39:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E4A03032AF;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AE93C30A77B6A; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.823493926@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:45 +0200
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
Subject: [PATCH v3 32/57] perf: Simplify perf_event_context_sched_in()
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
 kernel/events/core.c |   38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -713,6 +713,9 @@ static void perf_ctx_enable(struct perf_
 		perf_pmu_enable(pmu_ctx->pmu);
 }
 
+DEFINE_GUARD(perf_ctx_disable, struct perf_event_context *,
+	     perf_ctx_disable(_T), perf_ctx_enable(_T))
+
 static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
 static void ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
 
@@ -3906,31 +3909,27 @@ static void perf_event_context_sched_in(
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_context *ctx;
 
-	rcu_read_lock();
+	guard(rcu)();
+
 	ctx = rcu_dereference(task->perf_event_ctxp);
 	if (!ctx)
-		goto rcu_unlock;
-
-	if (cpuctx->task_ctx == ctx) {
-		perf_ctx_lock(cpuctx, ctx);
-		perf_ctx_disable(ctx);
-
-		perf_ctx_sched_task_cb(ctx, true);
-
-		perf_ctx_enable(ctx);
-		perf_ctx_unlock(cpuctx, ctx);
-		goto rcu_unlock;
-	}
+		return;
 
-	perf_ctx_lock(cpuctx, ctx);
+	guard(perf_ctx_lock)(cpuctx, ctx);
 	/*
 	 * We must check ctx->nr_events while holding ctx->lock, such
 	 * that we serialize against perf_install_in_context().
 	 */
 	if (!ctx->nr_events)
-		goto unlock;
+		return;
+
+	guard(perf_ctx_disable)(ctx);
+
+	if (cpuctx->task_ctx == ctx) {
+		perf_ctx_sched_task_cb(ctx, true);
+		return;
+	}
 
-	perf_ctx_disable(ctx);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -3950,13 +3949,6 @@ static void perf_event_context_sched_in(
 
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
 		perf_ctx_enable(&cpuctx->ctx);
-
-	perf_ctx_enable(ctx);
-
-unlock:
-	perf_ctx_unlock(cpuctx, ctx);
-rcu_unlock:
-	rcu_read_unlock();
 }
 
 /*


