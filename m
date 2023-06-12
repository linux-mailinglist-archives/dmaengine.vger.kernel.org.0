Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CD172BD89
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjFLJz6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjFLJyp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34D0618F;
        Mon, 12 Jun 2023 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VxLoQWqPLfFOizpz6LclwAvcc6NhnspZtOnksJEP8nY=; b=p6PhqIfSxM8DiwUuU4pSepp9+t
        sQDAs+RLgzLsKfJ0Kcen7QCEGUEiIeSA/rwAsAR7b6MfNGO9pcntCkHSiswQZFuF2xM2R+zf8J3ow
        wX35cUTV1JxcFVTwq7nPW7+2yeRbGO9zPkqabUzEI167PNV6S41nRrSC4/lAzjfi/vOJ3w15MxDOX
        ZX/q+B8JUmaFcJIBrT88ZNo/cz0VSFtkEr9L9mebjyXbMWd2ohnjBecsQJ/J3K5VJxidYIQPFKy+9
        4HVU7cOA9JH1oDaOoJo11k/QJT8iAkLcVqjNx5HmWfEws0lEKwGfEU1AD+SSkaq9GPZUqJdegwQDg
        EEzgg1Jw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0u-002NIB-Nl; Mon, 12 Jun 2023 09:39:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6627730612F;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1B34930A79083; Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Message-ID: <20230612093541.097332151@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:08:02 +0200
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
Subject: [PATCH v3 49/57] perf: Simplify perf_event_alloc()
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
 kernel/events/core.c |   47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5148,6 +5148,8 @@ static void __free_event(struct perf_eve
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
 
+DEFINE_FREE(__free_event, struct perf_event *, if (_T) __free_event(_T))
+
 /* vs perf_event_alloc() success */
 static void _free_event(struct perf_event *event)
 {
@@ -11694,7 +11696,6 @@ perf_event_alloc(struct perf_event_attr
 		 void *context, int cgroup_fd)
 {
 	struct pmu *pmu;
-	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	long err = -EINVAL;
 	int node;
@@ -11709,8 +11710,8 @@ perf_event_alloc(struct perf_event_attr
 	}
 
 	node = (cpu >= 0) ? cpu_to_node(cpu) : -1;
-	event = kmem_cache_alloc_node(perf_event_cache, GFP_KERNEL | __GFP_ZERO,
-				      node);
+	struct perf_event *event __free(__free_event) =
+		kmem_cache_alloc_node(perf_event_cache, GFP_KERNEL | __GFP_ZERO, node);
 	if (!event)
 		return ERR_PTR(-ENOMEM);
 
@@ -11815,51 +11816,43 @@ perf_event_alloc(struct perf_event_attr
 	 * See perf_output_read().
 	 */
 	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
-		goto err;
+		return ERR_PTR(-EINVAL);
 
 	if (!has_branch_stack(event))
 		event->attr.branch_sample_type = 0;
 
 	pmu = perf_init_event(event);
-	if (IS_ERR(pmu)) {
-		err = PTR_ERR(pmu);
-		goto err;
-	}
+	if (IS_ERR(pmu))
+		return (void*)pmu;
 
 	/*
 	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
 	 * events (they don't make sense as the cgroup will be different
 	 * on other CPUs in the uncore mask).
 	 */
-	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1))
+		return ERR_PTR(-EINVAL);
 
 	if (event->attr.aux_output &&
-	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
-		err = -EOPNOTSUPP;
-		goto err;
-	}
+	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT))
+		return ERR_PTR(-EOPNOTSUPP);
 
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
 		if (err)
-			goto err;
+			return ERR_PTR(err);
 	}
 
 	err = exclusive_event_init(event);
 	if (err)
-		goto err;
+		return ERR_PTR(err);
 
 	if (has_addr_filter(event)) {
 		event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
 						    sizeof(struct perf_addr_filter_range),
 						    GFP_KERNEL);
-		if (!event->addr_filter_ranges) {
-			err = -ENOMEM;
-			goto err;
-		}
+		if (!event->addr_filter_ranges)
+			return ERR_PTR(-ENOMEM);
 
 		/*
 		 * Clone the parent's vma offsets: they are valid until exec()
@@ -11883,22 +11876,18 @@ perf_event_alloc(struct perf_event_attr
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
 			err = get_callchain_buffers(attr->sample_max_stack);
 			if (err)
-				goto err;
+				return ERR_PTR(err);
 		}
 	}
 
 	err = security_perf_event_alloc(event);
 	if (err)
-		goto err;
+		return ERR_PTR(err);
 
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
-	return event;
-
-err:
-	__free_event(event);
-	return ERR_PTR(err);
+	return_ptr(event);
 }
 
 static int perf_copy_attr(struct perf_event_attr __user *uattr,


