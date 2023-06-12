Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6FE72BD47
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjFLJzi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjFLJyX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6DF4C11;
        Mon, 12 Jun 2023 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4+/Q1nIn7pjeaoOkqiN8ZoN9dOzRXj0Qx8pmucBG9KU=; b=JTIbW/gvOSQ58b4TCHUoHGEDh4
        Y1YJaLE27tmAx/JmH64kRErvzD0KUqyqfrX71MGF7wv0MltPgLgnjyg/kORWC199iFcMaqxABBB85
        2ngIl0UzK18xlGkdJHKfnwYwA/Wl2lR2NRNxaCAnNGGdy6tjZchz97RFC/huuNDIRiljM+iyvvmex
        VegKabbNI/sdQ6KSFyu7uT5aaMn9NnyH70zAM87Em+UPxNfTHrP0e+GNEWh2sXqUMKqamS/UzmCip
        zhr1rYAeBzRzlh1FU7evBmwXBmRVHZ/P3LFM8ztGfR2bODV96a59vURa3b146za2hED5IY+f1Izzy
        M5i/AT6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0g-002N97-A5; Mon, 12 Jun 2023 09:38:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D205C303189;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3C3B930A70ADE; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093538.307089780@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:25 +0200
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
Subject: [PATCH v3 12/57] sched: Simplify try_steal_cookie()
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
 kernel/sched/core.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6229,19 +6229,19 @@ static bool try_steal_cookie(int this, i
 	unsigned long cookie;
 	bool success = false;
 
-	local_irq_disable();
-	double_rq_lock(dst, src);
+	guard(irq)();
+	guard(double_rq_lock)(dst, src);
 
 	cookie = dst->core->core_cookie;
 	if (!cookie)
-		goto unlock;
+		return false;
 
 	if (dst->curr != dst->idle)
-		goto unlock;
+		return false;
 
 	p = sched_core_find(src, cookie);
 	if (!p)
-		goto unlock;
+		return false;
 
 	do {
 		if (p == src->core_pick || p == src->curr)
@@ -6253,9 +6253,10 @@ static bool try_steal_cookie(int this, i
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 		/*
-		 * sched_core_find() and sched_core_next() will ensure that task @p
-		 * is not throttled now, we also need to check whether the runqueue
-		 * of the destination CPU is being throttled.
+		 * sched_core_find() and sched_core_next() will ensure
+		 * that task @p is not throttled now, we also need to
+		 * check whether the runqueue of the destination CPU is
+		 * being throttled.
 		 */
 		if (sched_task_is_throttled(p, this))
 			goto next;
@@ -6273,10 +6274,6 @@ static bool try_steal_cookie(int this, i
 		p = sched_core_next(p, cookie);
 	} while (p);
 
-unlock:
-	double_rq_unlock(dst, src);
-	local_irq_enable();
-
 	return success;
 }
 


