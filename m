Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CEF72BD8E
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjFLJ4L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjFLJys (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B96193;
        Mon, 12 Jun 2023 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=u1PqToTv4tGu/wNo5qNbJmeSKvydQLpyPDESq1sFIz4=; b=mHcg7bsEVSqy84in9mzk14TWOQ
        pUvBhruN8Ps4QU7UuXumepKGGKVTz/FqQ93C9z0RN9W8/VKYjDbgUgbBY3/hYg1MVwS8NQtUh+Xww
        CynHYhgrEVuJvTSlRsgcVCBrRmckY/PSGTJojKVJLzgMoiN08hB1rnPRAI2jI27rXNxb+MIytDB8L
        DnKzYQDZWDNXEVW7juyczQTLAGwCYM4mK+1HoLnrpThSbhUJZex38ZlRC9grt10V6FjhXAKdXPMZm
        veFavMchJctFhw66K958zPJTPkM0N+TjTu3S9OTJzMVp9r9RRaE5dQ/R2ohI3MV52F1JIkwJGTg5z
        XosuHW2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0p-008kRQ-2g;
        Mon, 12 Jun 2023 09:39:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51E713033FA;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E65E130A77B74; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093540.564584285@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:55 +0200
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
Subject: [PATCH v3 42/57] perf: Simplify perf_iterate_sb()
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
 kernel/events/core.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7871,8 +7871,8 @@ perf_iterate_sb(perf_iterate_f output, v
 {
 	struct perf_event_context *ctx;
 
-	rcu_read_lock();
-	preempt_disable();
+	guard(rcu)();
+	guard(preempt)();
 
 	/*
 	 * If we have task_ctx != NULL we only notify the task context itself.
@@ -7881,7 +7881,7 @@ perf_iterate_sb(perf_iterate_f output, v
 	 */
 	if (task_ctx) {
 		perf_iterate_ctx(task_ctx, output, data, false);
-		goto done;
+		return;
 	}
 
 	perf_iterate_sb_cpu(output, data);
@@ -7889,9 +7889,6 @@ perf_iterate_sb(perf_iterate_f output, v
 	ctx = rcu_dereference(current->perf_event_ctxp);
 	if (ctx)
 		perf_iterate_ctx(ctx, output, data, false);
-done:
-	preempt_enable();
-	rcu_read_unlock();
 }
 
 /*


