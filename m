Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D26572BD3A
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjFLJz3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjFLJyW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB644C12;
        Mon, 12 Jun 2023 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Z/QyOBDSEB+zoR9GPvKsSeTCgad9VvZXAWajjLt+jzo=; b=YbdZ7d0Wkk7V4xEA2JeTFjo7y9
        Js3k1bAq/AvskMJrYL88GyKWi4bdT9g7xpk2tbcZi3VNr/dAEWOx9CHcGNSfQ6f74cyKb81/LczUz
        0uwzpsUGL2jwlCDcudwo4mohnyMk7Ya5OLuZ63mjaIPHz5sza9/KwfqaEzgTpSP7uHZ/0S9G8MxCg
        W0NoHXpfe1FwA0SonnMbv2vJpnZqDBl6dUVcTBPu6b5/vrwFfvY5LCkIXSN1b6WwSJWTwsIq0TbSN
        2EmHnrFbXaeXExBxGGLXhk/uU/VAP0weaXan6woQ24npm1rDwnPNgthAwCgWJr34wxBs5xdz3ymN8
        ZU+JNpWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0g-002N93-6k; Mon, 12 Jun 2023 09:38:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F184302F7E;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A5FD30A70240; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093537.905243325@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:20 +0200
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
Subject: [PATCH v3 07/57] sched: Simplify: migrate_swap_stop()
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
 kernel/sched/core.c  |   23 +++++++----------------
 kernel/sched/sched.h |   20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 16 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3258,7 +3258,6 @@ static int migrate_swap_stop(void *data)
 {
 	struct migration_swap_arg *arg = data;
 	struct rq *src_rq, *dst_rq;
-	int ret = -EAGAIN;
 
 	if (!cpu_active(arg->src_cpu) || !cpu_active(arg->dst_cpu))
 		return -EAGAIN;
@@ -3266,33 +3265,25 @@ static int migrate_swap_stop(void *data)
 	src_rq = cpu_rq(arg->src_cpu);
 	dst_rq = cpu_rq(arg->dst_cpu);
 
-	double_raw_lock(&arg->src_task->pi_lock,
-			&arg->dst_task->pi_lock);
-	double_rq_lock(src_rq, dst_rq);
+	guard(double_raw_spinlock)(&arg->src_task->pi_lock, &arg->dst_task->pi_lock);
+	guard(double_rq_lock)(src_rq, dst_rq);
 
 	if (task_cpu(arg->dst_task) != arg->dst_cpu)
-		goto unlock;
+		return -EAGAIN;
 
 	if (task_cpu(arg->src_task) != arg->src_cpu)
-		goto unlock;
+		return -EAGAIN;
 
 	if (!cpumask_test_cpu(arg->dst_cpu, arg->src_task->cpus_ptr))
-		goto unlock;
+		return -EAGAIN;
 
 	if (!cpumask_test_cpu(arg->src_cpu, arg->dst_task->cpus_ptr))
-		goto unlock;
+		return -EAGAIN;
 
 	__migrate_swap_task(arg->src_task, arg->dst_cpu);
 	__migrate_swap_task(arg->dst_task, arg->src_cpu);
 
-	ret = 0;
-
-unlock:
-	double_rq_unlock(src_rq, dst_rq);
-	raw_spin_unlock(&arg->dst_task->pi_lock);
-	raw_spin_unlock(&arg->src_task->pi_lock);
-
-	return ret;
+	return 0;
 }
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2572,6 +2572,12 @@ static inline void double_rq_clock_clear
 static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
 #endif
 
+#define DEFINE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)		\
+__DEFINE_UNLOCK_GUARD(name, type, _unlock, type *lock2; __VA_ARGS__) \
+static inline class_##name##_t class_##name##_constructor(type *lock, type *lock2) \
+{ class_##name##_t _t = { .lock = lock, .lock2 = lock2 }, *_T = &_t;	\
+  _lock; return _t; }
+
 #ifdef CONFIG_SMP
 
 static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
@@ -2701,6 +2707,16 @@ static inline void double_raw_lock(raw_s
 	raw_spin_lock_nested(l2, SINGLE_DEPTH_NESTING);
 }
 
+static inline void double_raw_unlock(raw_spinlock_t *l1, raw_spinlock_t *l2)
+{
+	raw_spin_unlock(l1);
+	raw_spin_unlock(l2);
+}
+
+DEFINE_LOCK_GUARD_2(double_raw_spinlock, raw_spinlock_t,
+		    double_raw_lock(_T->lock, _T->lock2),
+		    double_raw_unlock(_T->lock, _T->lock2))
+
 /*
  * double_rq_unlock - safely unlock two runqueues
  *
@@ -2758,6 +2774,10 @@ static inline void double_rq_unlock(stru
 
 #endif
 
+DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
+		    double_rq_lock(_T->lock, _T->lock2),
+		    double_rq_unlock(_T->lock, _T->lock2))
+
 extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
 


