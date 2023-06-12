Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7585E72BD35
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjFLJz0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjFLJyV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B634D4C05;
        Mon, 12 Jun 2023 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8IwM37e642EshGkaM591nsICKeU24b96IU4dYucK72I=; b=dXBEmpz80b7hoderM45846w/8O
        pNO8hpipMKRJ27niZQqDP/oZ7/BF1rbJvgcP4PNZOjA0/uy51im9efmFnxUQeqkaz8ERUeIMTVgbA
        4VU+/qmkIVh9mruK1Kemd08wt+2YvNqj7iMBDIb55yjZBxdNbyYHd4vmkglhIRzn3VhbsO1g6kMNX
        DPownbe5F7lKMEY9oMSiQbAsQ6Sq/LDRo6BH7dsjs/eLhKCTZkfWMRYDFaavzf9aNxmS0+JA4YiOd
        d6r7PI/eGL4W69GpFhaxW3FPhqLQIpOokWmypJbsZsB0KhQzPHHjPZBSmrvaJDXXl2NqdZOvB1M89
        9hb3DItQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0g-008kPD-1r;
        Mon, 12 Jun 2023 09:38:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 226E43031CC;
        Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5D3FD30A77B5B; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093538.792690687@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:31 +0200
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
Subject: [PATCH v3 18/57] sched: Simplify sched_rr_get_interval()
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
 kernel/sched/core.c |   40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8941,38 +8941,30 @@ SYSCALL_DEFINE1(sched_get_priority_min,
 
 static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
 {
-	struct task_struct *p;
-	unsigned int time_slice;
-	struct rq_flags rf;
-	struct rq *rq;
+	unsigned int time_slice = 0;
 	int retval;
 
 	if (pid < 0)
 		return -EINVAL;
 
-	retval = -ESRCH;
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	if (!p)
-		goto out_unlock;
-
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
-
-	rq = task_rq_lock(p, &rf);
-	time_slice = 0;
-	if (p->sched_class->get_rr_interval)
-		time_slice = p->sched_class->get_rr_interval(rq, p);
-	task_rq_unlock(rq, p, &rf);
+	scoped_guard (rcu) {
+		struct task_struct *p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
+
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
+
+		scoped_guard (task_rq_lock, p) {
+			struct rq *rq = scope.rq;
+			if (p->sched_class->get_rr_interval)
+				time_slice = p->sched_class->get_rr_interval(rq, p);
+		}
+	}
 
-	rcu_read_unlock();
 	jiffies_to_timespec64(time_slice, t);
 	return 0;
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
 }
 
 /**


