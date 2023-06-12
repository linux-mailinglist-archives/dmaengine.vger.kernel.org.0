Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9272BD3B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjFLJza (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjFLJyW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F34E4C15;
        Mon, 12 Jun 2023 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2Fw/6pc13hFz4431UNCf/XS3M9fAIWcYfqPnXE09Ku4=; b=b6HhHqyRgVNIvJxJg3qz34xg3z
        MclAequn3uyYDgQ5Z5i8iDgOLuz/qXGgm1oMBVoGifA2g41/aPpi+zdp37cuqoJp+mxC5cFvegIAx
        PrGLhpLp6tRFNJ+xGJdm2Vl8NMuY2mfkHRUQqumE0N6uhf8Hwi+0jsjngOlSw1NjDNooe7ANlbed6
        InipGNmagWluFfr2AZow7mI1sOKeySpJUvHBQ/S5Qm+hiYjBJavBgxNx9Q3pT2HaDMGuK1RCXjfIv
        izn1MU80zDpXeVWyzMuTE3zNEGhTt+PqqObFqGdyck+4419X8FjSEtsb3NkqK5BrIhAd8Futl2USY
        ItEsQUOQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0g-002N91-0z; Mon, 12 Jun 2023 09:38:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86856302EA7;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0FD3C30A6FEEC; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093537.762718530@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:18 +0200
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
Subject: [PATCH v3 05/57] sched: Simplify get_nohz_timer_target()
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
 kernel/sched/core.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1097,25 +1097,22 @@ int get_nohz_timer_target(void)
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
 
-	rcu_read_lock();
+	guard(rcu)();
+
 	for_each_domain(cpu, sd) {
 		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
 			if (cpu == i)
 				continue;
 
-			if (!idle_cpu(i)) {
-				cpu = i;
-				goto unlock;
-			}
+			if (!idle_cpu(i))
+				return i;
 		}
 	}
 
 	if (default_cpu == -1)
 		default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
-	cpu = default_cpu;
-unlock:
-	rcu_read_unlock();
-	return cpu;
+
+	return default_cpu;
 }
 
 /*


