Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED672BD80
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjFLJzp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFLJy1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13BD5FF7;
        Mon, 12 Jun 2023 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=y0wgwpukS8T7O340+NKvU9chnTVlAmLcht1jdurq5Ss=; b=XJLeq7I1drWQYbixkl89Se55Lm
        ueDLMCBUmrK1ud0Ym2MEKFBBcNCFsHuofYli/d22KQa8rLnB7TqYweSgfEswFS0Rngj94PaRCGISU
        BjJqQVzROtr4nm6YuEhME1yjkhuAy4siEWBxnmmKn84Ma8GXkQN0TO78ajWRKONL+bjwVXBj1OHlc
        wd5XSXX9DMA+GZC8viUDd1En+ijoZsCoNPdUmeqGf2hUg2zXdMg7bMFdw2n7RijPcP1yaXBwIJspG
        zSqEDja4Bsa9uiVuz1JOYDJaWqEk5fEBX3CCfz04e9HuFekeyep/OIowD9BCc1AFfcfJdAMXRdKLx
        jIf4FRgA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0l-002NB4-5z; Mon, 12 Jun 2023 09:38:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03D383002A9;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6353930A77B5A; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093538.871533689@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:32 +0200
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
Subject: [PATCH v3 19/57] sched: Simplify sched_move_task()
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
 kernel/sched/core.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10361,17 +10361,18 @@ void sched_move_task(struct task_struct
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct task_group *group;
-	struct rq_flags rf;
 	struct rq *rq;
 
-	rq = task_rq_lock(tsk, &rf);
+	CLASS(task_rq_lock, rq_guard)(tsk);
+	rq = rq_guard.rq;
+
 	/*
 	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
 	 * group changes.
 	 */
 	group = sched_get_task_group(tsk);
 	if (group == tsk->sched_task_group)
-		goto unlock;
+		return;
 
 	update_rq_clock(rq);
 
@@ -10396,9 +10397,6 @@ void sched_move_task(struct task_struct
 		 */
 		resched_curr(rq);
 	}
-
-unlock:
-	task_rq_unlock(rq, tsk, &rf);
 }
 
 static inline struct task_group *css_tg(struct cgroup_subsys_state *css)


