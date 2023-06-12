Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494FC72BD64
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjFLJz5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjFLJyp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D56190;
        Mon, 12 Jun 2023 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5KSqPesmPX08w8dWPEEw5Ll2e7FMQinOnTr3XW9NIYo=; b=otUSsXrkwDi6rVuLl90MM+76vL
        cE6gp9EEa8Zpqqg9MG4CPJ7+wgAaw1DsHIj5puea/XbvsOxRyOFpyECLs24dRzQ6Sjol89f/EXqvQ
        LChObBEVQXRBsTW4GZSlyTIrge2V5AXUII3ByKeNmerebPgKH0p6l5UMuFfc+5XpT1yAnuRwxbHT8
        2TJtKzkAkK7oEDchq+KMZKfYnIVzQSIQ18PSNfOGRXZs26r2yqrAQzcGI/y/cuIBGiWJXVqpmFdO/
        vnWMq8UVC4ZBmx1AVgqzGkpD1hMSd/tM7MGG2el0Wb3T3Cib/eS7vjoZ84B8P3FcOaWoCXC0PdTIv
        Ssmk1qgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0o-008kRF-02;
        Mon, 12 Jun 2023 09:39:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52D533033FC;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EBB5330A77B75; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093540.638818161@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:56 +0200
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
Subject: [PATCH v3 43/57] perf: Simplify perf_sw_event()
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
 kernel/events/core.c |   37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9701,17 +9701,15 @@ static void do_perf_sw_event(enum perf_t
 	struct perf_event *event;
 	struct hlist_head *head;
 
-	rcu_read_lock();
+	guard(rcu)();
 	head = find_swevent_head_rcu(swhash, type, event_id);
 	if (!head)
-		goto end;
+		return;
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
 		if (perf_swevent_match(event, type, event_id, data, regs))
 			perf_swevent_event(event, nr, data, regs);
 	}
-end:
-	rcu_read_unlock();
 }
 
 DEFINE_PER_CPU(struct pt_regs, __perf_regs[4]);
@@ -9746,16 +9744,13 @@ void __perf_sw_event(u32 event_id, u64 n
 {
 	int rctx;
 
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 	rctx = perf_swevent_get_recursion_context();
 	if (unlikely(rctx < 0))
-		goto fail;
+		return;
 
 	___perf_sw_event(event_id, nr, regs, addr);
-
 	perf_swevent_put_recursion_context(rctx);
-fail:
-	preempt_enable_notrace();
 }
 
 static void perf_swevent_read(struct perf_event *event)
@@ -9844,21 +9839,17 @@ static int swevent_hlist_get_cpu(int cpu
 	struct swevent_htable *swhash = &per_cpu(swevent_htable, cpu);
 	int err = 0;
 
-	mutex_lock(&swhash->hlist_mutex);
+	guard(mutex)(&swhash->hlist_mutex);
 	if (!swevent_hlist_deref(swhash) &&
 	    cpumask_test_cpu(cpu, perf_online_mask)) {
 		struct swevent_hlist *hlist;
 
 		hlist = kzalloc(sizeof(*hlist), GFP_KERNEL);
-		if (!hlist) {
-			err = -ENOMEM;
-			goto exit;
-		}
+		if (!hlist)
+			return -ENOMEM;
 		rcu_assign_pointer(swhash->swevent_hlist, hlist);
 	}
 	swhash->hlist_refcount++;
-exit:
-	mutex_unlock(&swhash->hlist_mutex);
 
 	return err;
 }
@@ -10115,16 +10106,12 @@ void perf_tp_event(u16 event_type, u64 c
 	if (task && task != current) {
 		struct perf_event_context *ctx;
 
-		rcu_read_lock();
+		guard(rcu)();
 		ctx = rcu_dereference(task->perf_event_ctxp);
-		if (!ctx)
-			goto unlock;
-
-		raw_spin_lock(&ctx->lock);
-		perf_tp_event_target_task(count, record, regs, &data, ctx);
-		raw_spin_unlock(&ctx->lock);
-unlock:
-		rcu_read_unlock();
+		if (ctx) {
+			guard(raw_spinlock)(&ctx->lock);
+			perf_tp_event_target_task(count, record, regs, &data, ctx);
+		}
 	}
 
 	perf_swevent_put_recursion_context(rctx);


