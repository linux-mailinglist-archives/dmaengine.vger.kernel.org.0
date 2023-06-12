Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F40572BD4E
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjFLJzs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjFLJy2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E505FF9;
        Mon, 12 Jun 2023 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TyEqnNyUrGcTyQQqxTQ7FjrgTS2UCJUv6R0g2vbKlfY=; b=rHHDliBQ2Qfw4zPxTfBy8QXX52
        G14E6gPiy22JcNYH/Q5ary0q0YX91rEsCLNUeF2er4snB00oi8Lc4f2MMJZUwwWFKvHVk7GQuK7Zl
        3ahxPQrajWWxBclXKLGynYx8r2sGJlK3yDh9HWCO7kIqSmTRqHGJsywLA/mKXJqegwQvkdaMSNva2
        uJVrXhoSZLISp+eyXn3YfK2inTs+lOPkrCnxRe7XnCJ3h8JknStPhu9xVH8GzIG76/K6R5JUG74zu
        XsZmZNsMpz5Ycxrzfr+Z6QJ1Wis1vJw2il0uWR+vhha6EcQ+HD/j4wtxTmR7enXrzcACCcjOxcx3G
        mOVdO+3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0m-002NBu-ET; Mon, 12 Jun 2023 09:38:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B8233032D0;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C402E30A77B6D; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093540.108251860@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:49 +0200
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
Subject: [PATCH v3 36/57] perf: Simplify find_get_pmu_context()
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
 kernel/events/core.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4757,11 +4757,14 @@ find_get_context(struct task_struct *tas
 	return ERR_PTR(err);
 }
 
+/*
+ * Returns a matching perf_event_pmu_context with elevated refcount or NULL.
+ */
 static struct perf_event_pmu_context *
 find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		     struct perf_event *event)
 {
-	struct perf_event_pmu_context *new = NULL, *epc;
+	struct perf_event_pmu_context *epc;
 	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
@@ -4788,16 +4791,14 @@ find_get_pmu_context(struct pmu *pmu, st
 		return epc;
 	}
 
-	new = kzalloc(sizeof(*epc), GFP_KERNEL);
+	void *new __free(kfree) = kzalloc(sizeof(*epc), GFP_KERNEL);
 	if (!new)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
 		task_ctx_data = alloc_task_ctx_data(pmu);
-		if (!task_ctx_data) {
-			kfree(new);
-			return ERR_PTR(-ENOMEM);
-		}
+		if (!task_ctx_data)
+			return NULL;
 	}
 
 	__perf_init_event_pmu_context(new, pmu);
@@ -4820,8 +4821,7 @@ find_get_pmu_context(struct pmu *pmu, st
 		}
 	}
 
-	epc = new;
-	new = NULL;
+	epc = no_free_ptr(new);
 
 	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
 	epc->ctx = ctx;
@@ -4835,7 +4835,6 @@ find_get_pmu_context(struct pmu *pmu, st
 	raw_spin_unlock_irq(&ctx->lock);
 
 	free_task_ctx_data(pmu, task_ctx_data);
-	kfree(new);
 
 	return epc;
 }


