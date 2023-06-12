Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17E72BD7C
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjFLJzj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjFLJyX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5204C10;
        Mon, 12 Jun 2023 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=i7e4Ed2VApizqqMeLDQrTIcscOdlMDKi2d1+AvdLSfc=; b=wMzEZ40Omey0hsxhU/f3YtsHn5
        zztcNlN85LbTkIssyfkfrL48NmxnO6Xui7xALjewqMlyvd6RZfe6D4fBUEzU8ivSmkwH/rB+mgo8T
        DhIJ64bXK4MQAZHj4XNZbgTg99syxZL71a1nSxvAdXCC6Uq6WFU3Xo8Qau8qLevXW3vCcNOlO2hGd
        kLRb3QAfPguHrywS9Q4UgqR5mxOfj+Fk/M4IRihmVpaRZyf1EnKiw6p0zeUoZx/4h4dCUGPxRMpDH
        XqqMxcqWisvIc3MeLjMSkQ+D+XHT/6tgpmqY6cFvXD2CLwtL8aPDEHRB9Vg3FRPnxzDUV9pZfUiAM
        GAqscdag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0g-002N94-7B; Mon, 12 Jun 2023 09:38:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9B5B302FB8;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 22F9530A70248; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093537.977924652@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:21 +0200
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
Subject: [PATCH v3 08/57] sched: Simplify wake_up_if_idle()
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
 kernel/sched/core.c  |   20 ++++++--------------
 kernel/sched/sched.h |   15 +++++++++++++++
 2 files changed, 21 insertions(+), 14 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3872,21 +3872,13 @@ static void __ttwu_queue_wakelist(struct
 void wake_up_if_idle(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 
-	rcu_read_lock();
-
-	if (!is_idle_task(rcu_dereference(rq->curr)))
-		goto out;
-
-	rq_lock_irqsave(rq, &rf);
-	if (is_idle_task(rq->curr))
-		resched_curr(rq);
-	/* Else CPU is not idle, do nothing here: */
-	rq_unlock_irqrestore(rq, &rf);
-
-out:
-	rcu_read_unlock();
+	guard(rcu)();
+	if (is_idle_task(rcu_dereference(rq->curr))) {
+		guard(rq_lock)(rq);
+		if (is_idle_task(rq->curr))
+			resched_curr(rq);
+	}
 }
 
 bool cpus_share_cache(int this_cpu, int that_cpu)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1678,6 +1678,21 @@ rq_unlock(struct rq *rq, struct rq_flags
 	raw_spin_rq_unlock(rq);
 }
 
+DEFINE_LOCK_GUARD_1(rq_lock, struct rq,
+		    rq_lock(_T->lock, &_T->rf),
+		    rq_unlock(_T->lock, &_T->rf),
+		    struct rq_flags rf)
+
+DEFINE_LOCK_GUARD_1(rq_lock_irq, struct rq,
+		    rq_lock_irq(_T->lock, &_T->rf),
+		    rq_unlock_irq(_T->lock, &_T->rf),
+		    struct rq_flags rf)
+
+DEFINE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
+		    rq_lock_irqsave(_T->lock, &_T->rf),
+		    rq_unlock_irqrestore(_T->lock, &_T->rf),
+		    struct rq_flags rf)
+
 static inline struct rq *
 this_rq_lock_irq(struct rq_flags *rf)
 	__acquires(rq->lock)


