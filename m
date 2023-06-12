Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C621272BD77
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjFLJzl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjFLJy1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F1A5FF5;
        Mon, 12 Jun 2023 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zYnYxbpqthdvjZXSbX3mfTIRB+RNguvN2goMXYp9Xns=; b=C5N48YEmWa+xMIpR8Tid5fFCz1
        4ts/IhHAlVB3Y7klukQjxw44QSTOVczdIgHCgTTbeHSL7aNXDjlvrZtOElLa8bHls8SaEi11a1yjW
        m8kixqnVYt13JTML9cc4mFMTjjaeZEqje23QKPWH88Nmb5TXkjBZw9Qbm/tLMrNNaaBI01UM3PP4o
        mnSnzt8+wc/j6RBeyZpxQSflkzM8u9BQdxPW12PhV7VkCm5m4D2Z6wf2b/Pbn8epVWSKozGvq5kEJ
        r34sE5/kpDYtj9XvM/rxugO23nxtz5nDzFbm0JOBNbjS5cquGVt7sQ2Oz3swWIcXkshOgt0riH9zO
        O7emOYuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0l-002NB7-86; Mon, 12 Jun 2023 09:38:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 16399302FB8;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 75EFF30A77B5E; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.157685883@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:36 +0200
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
Subject: [PATCH v3 23/57] perf: Simplify perf_event_alloc() error path
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

The error cleanup sequence in perf_event_alloc() is a subset of the
existing _free_event() function (it must of course be).

Split this out into __free_event() and simplify the error path.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h |    1 
 kernel/events/core.c       |  129 ++++++++++++++++++++++-----------------------
 2 files changed, 66 insertions(+), 64 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -634,6 +634,7 @@ struct swevent_hlist {
 #define PERF_ATTACH_ITRACE	0x10
 #define PERF_ATTACH_SCHED_CB	0x20
 #define PERF_ATTACH_CHILD	0x40
+#define PERF_ATTACH_EXCLUSIVE	0x80
 
 struct bpf_prog;
 struct perf_cgroup;
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5094,6 +5094,8 @@ static int exclusive_event_init(struct p
 			return -EBUSY;
 	}
 
+	event->attach_state |= PERF_ATTACH_EXCLUSIVE;
+
 	return 0;
 }
 
@@ -5101,14 +5103,13 @@ static void exclusive_event_destroy(stru
 {
 	struct pmu *pmu = event->pmu;
 
-	if (!is_exclusive_pmu(pmu))
-		return;
-
 	/* see comment in exclusive_event_init() */
 	if (event->attach_state & PERF_ATTACH_TASK)
 		atomic_dec(&pmu->exclusive_cnt);
 	else
 		atomic_inc(&pmu->exclusive_cnt);
+
+	event->attach_state &= ~PERF_ATTACH_EXCLUSIVE;
 }
 
 static bool exclusive_event_match(struct perf_event *e1, struct perf_event *e2)
@@ -5143,38 +5144,22 @@ static bool exclusive_event_installable(
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
 
-static void _free_event(struct perf_event *event)
+/* vs perf_event_alloc() error */
+static void __free_event(struct perf_event *event)
 {
-	irq_work_sync(&event->pending_irq);
-
-	unaccount_event(event);
-
-	security_perf_event_free(event);
-
-	if (event->rb) {
-		/*
-		 * Can happen when we close an event with re-directed output.
-		 *
-		 * Since we have a 0 refcount, perf_mmap_close() will skip
-		 * over us; possibly making our ring_buffer_put() the last.
-		 */
-		mutex_lock(&event->mmap_mutex);
-		ring_buffer_attach(event, NULL);
-		mutex_unlock(&event->mmap_mutex);
-	}
-
-	if (is_cgroup_event(event))
-		perf_detach_cgroup(event);
-
 	if (!event->parent) {
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
 			put_callchain_buffers();
 	}
 
-	perf_event_free_bpf_prog(event);
-	perf_addr_filters_splice(event, NULL);
 	kfree(event->addr_filter_ranges);
 
+	if (event->attach_state & PERF_ATTACH_EXCLUSIVE)
+		exclusive_event_destroy(event);
+
+	if (is_cgroup_event(event))
+		perf_detach_cgroup(event);
+
 	if (event->destroy)
 		event->destroy(event);
 
@@ -5185,22 +5170,56 @@ static void _free_event(struct perf_even
 	if (event->hw.target)
 		put_task_struct(event->hw.target);
 
-	if (event->pmu_ctx)
+	if (event->pmu_ctx) {
+		/*
+		 * put_pmu_ctx() needs an event->ctx reference, because of
+		 * epc->ctx.
+		 */
+		WARN_ON_ONCE(!event->ctx);
+		WARN_ON_ONCE(event->pmu_ctx->ctx != event->ctx);
 		put_pmu_ctx(event->pmu_ctx);
+	}
 
 	/*
-	 * perf_event_free_task() relies on put_ctx() being 'last', in particular
-	 * all task references must be cleaned up.
+	 * perf_event_free_task() relies on put_ctx() being 'last', in
+	 * particular all task references must be cleaned up.
 	 */
 	if (event->ctx)
 		put_ctx(event->ctx);
 
-	exclusive_event_destroy(event);
-	module_put(event->pmu->module);
+	if (event->pmu)
+		module_put(event->pmu->module);
 
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
 
+/* vs perf_event_alloc() success */
+static void _free_event(struct perf_event *event)
+{
+	irq_work_sync(&event->pending_irq);
+
+	unaccount_event(event);
+
+	security_perf_event_free(event);
+
+	if (event->rb) {
+		/*
+		 * Can happen when we close an event with re-directed output.
+		 *
+		 * Since we have a 0 refcount, perf_mmap_close() will skip
+		 * over us; possibly making our ring_buffer_put() the last.
+		 */
+		mutex_lock(&event->mmap_mutex);
+		ring_buffer_attach(event, NULL);
+		mutex_unlock(&event->mmap_mutex);
+	}
+
+	perf_event_free_bpf_prog(event);
+	perf_addr_filters_splice(event, NULL);
+
+	__free_event(event);
+}
+
 /*
  * Used to free events which have a known refcount of 1, such as in error paths
  * where the event isn't exposed yet and inherited events.
@@ -11591,8 +11610,10 @@ static int perf_try_init_event(struct pm
 			event->destroy(event);
 	}
 
-	if (ret)
+	if (ret) {
+		event->pmu = NULL;
 		module_put(pmu->module);
+	}
 
 	return ret;
 }
@@ -11918,7 +11939,7 @@ perf_event_alloc(struct perf_event_attr
 	 * See perf_output_read().
 	 */
 	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
-		goto err_ns;
+		goto err;
 
 	if (!has_branch_stack(event))
 		event->attr.branch_sample_type = 0;
@@ -11926,7 +11947,7 @@ perf_event_alloc(struct perf_event_attr
 	pmu = perf_init_event(event);
 	if (IS_ERR(pmu)) {
 		err = PTR_ERR(pmu);
-		goto err_ns;
+		goto err;
 	}
 
 	/*
@@ -11936,24 +11957,24 @@ perf_event_alloc(struct perf_event_attr
 	 */
 	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
 		err = -EINVAL;
-		goto err_pmu;
+		goto err;
 	}
 
 	if (event->attr.aux_output &&
 	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
 		err = -EOPNOTSUPP;
-		goto err_pmu;
+		goto err;
 	}
 
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
 		if (err)
-			goto err_pmu;
+			goto err;
 	}
 
 	err = exclusive_event_init(event);
 	if (err)
-		goto err_pmu;
+		goto err;
 
 	if (has_addr_filter(event)) {
 		event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
@@ -11961,7 +11982,7 @@ perf_event_alloc(struct perf_event_attr
 						    GFP_KERNEL);
 		if (!event->addr_filter_ranges) {
 			err = -ENOMEM;
-			goto err_per_task;
+			goto err;
 		}
 
 		/*
@@ -11986,41 +12007,21 @@ perf_event_alloc(struct perf_event_attr
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
 			err = get_callchain_buffers(attr->sample_max_stack);
 			if (err)
-				goto err_addr_filters;
+				goto err;
 		}
 	}
 
 	err = security_perf_event_alloc(event);
 	if (err)
-		goto err_callchain_buffer;
+		goto err;
 
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
 	return event;
 
-err_callchain_buffer:
-	if (!event->parent) {
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-			put_callchain_buffers();
-	}
-err_addr_filters:
-	kfree(event->addr_filter_ranges);
-
-err_per_task:
-	exclusive_event_destroy(event);
-
-err_pmu:
-	if (is_cgroup_event(event))
-		perf_detach_cgroup(event);
-	if (event->destroy)
-		event->destroy(event);
-	module_put(pmu->module);
-err_ns:
-	if (event->hw.target)
-		put_task_struct(event->hw.target);
-	call_rcu(&event->rcu_head, free_event_rcu);
-
+err:
+	__free_event(event);
 	return ERR_PTR(err);
 }
 


