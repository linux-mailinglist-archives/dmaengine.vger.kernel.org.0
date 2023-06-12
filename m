Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED872BD2C
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjFLJzZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjFLJyT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C24C00;
        Mon, 12 Jun 2023 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=q92jsVFPZSP8G7FOeDp8TiMSNcZFRY9w1smIqAIutpc=; b=ZjjVcZol4/9Mg/CL1z/yvfA0AG
        OAFbqGJmR4WaLGPuac3DsxuC/cSLfbEfZYKTwqp9zVOHAsflVFZRmumwh6cw0dmuh8tYBucZ3u0Bv
        rYCwv7X1JMsEe/Bto2w5Ft+VMSeXNZoL9d7mW5B4ILoyaUUzjXUpOLsiTzmFWQE55vsKoxPa9Ol60
        eK29omO/sJmvbBhucM9rXlm3uLaAGBN0Ne0S14xbL5cU904oFMiq6FXiZdX6eIaV+eBG+pu5krCbP
        WhCEIB+k7OA7yII2HdbfhSoriI3sHSADL+6mMPmTzKFHg7w0eK75g37vf6kFTHN40d5lPG/ZFftsp
        MVAqneTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0g-008kOz-11;
        Mon, 12 Jun 2023 09:38:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5F08303164;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3619930A70ADD; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093538.225353309@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:24 +0200
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
Subject: [PATCH v3 11/57] sched: Simplify sched_tick_remote()
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
 kernel/sched/core.c |   43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5651,9 +5651,6 @@ static void sched_tick_remote(struct wor
 	struct tick_work *twork = container_of(dwork, struct tick_work, work);
 	int cpu = twork->cpu;
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr;
-	struct rq_flags rf;
-	u64 delta;
 	int os;
 
 	/*
@@ -5663,30 +5660,26 @@ static void sched_tick_remote(struct wor
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (!tick_nohz_tick_stopped_cpu(cpu))
-		goto out_requeue;
+	if (tick_nohz_tick_stopped_cpu(cpu)) {
+		guard(rq_lock_irq)(rq);
+		struct task_struct *curr = rq->curr;
+
+		if (cpu_online(cpu)) {
+			update_rq_clock(rq);
+
+			if (!is_idle_task(curr)) {
+				/*
+				 * Make sure the next tick runs within a
+				 * reasonable amount of time.
+				 */
+				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
+				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+			}
+			curr->sched_class->task_tick(rq, curr, 0);
 
-	rq_lock_irq(rq, &rf);
-	curr = rq->curr;
-	if (cpu_is_offline(cpu))
-		goto out_unlock;
-
-	update_rq_clock(rq);
-
-	if (!is_idle_task(curr)) {
-		/*
-		 * Make sure the next tick runs within a reasonable
-		 * amount of time.
-		 */
-		delta = rq_clock_task(rq) - curr->se.exec_start;
-		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+			calc_load_nohz_remote(rq);
+		}
 	}
-	curr->sched_class->task_tick(rq, curr, 0);
-
-	calc_load_nohz_remote(rq);
-out_unlock:
-	rq_unlock_irq(rq, &rf);
-out_requeue:
 
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary


