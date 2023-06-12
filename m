Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAAA72BD66
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjFLJ4S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjFLJyt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4BC4C24;
        Mon, 12 Jun 2023 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3znloSDHViiBmrAdv7OWZVEw7vUxAyx0B3A3/+Qs8bI=; b=IUO9OLx1TrVgcptK2MZb4c+Sn4
        EVzHTvVu+xtHeRn8FXs+4TG6lnj2b3k/me7UG7IIb1KpO4T5GPw2+qWG9oATedUzq+NM70mcT4bti
        HLzEMtejImfTANsC8sPs1gswHo/77zVVk6+JE8KGZDN2idZrQ91P2npzPnTaxcVqhdp7GM9v7xzqO
        83Un7eDMkpuqONSKTCyszSRzP/K6jTfTnP438X5enxh5e8KELYoQkGq5KDulr1XMZqUpPzpwdVlsN
        B70mhv8SwI8fCgJro8rqHKdeL6YR9k4RzfmXBv/eguvp03Eee6R4yJax4MoBvm6+4AfTeHzlm/+Ou
        b0LlqYtg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0z-002NO7-BS; Mon, 12 Jun 2023 09:39:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 822BF306161;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4309930A7A2A1; Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Message-ID: <20230612093541.669724890@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:08:10 +0200
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
Subject: [PATCH v3 57/57] perf: Simplify perf_install_in_context()
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
 kernel/events/core.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2876,7 +2876,7 @@ perf_install_in_context(struct perf_even
 	if (!task_function_call(task, __perf_install_in_context, event))
 		return;
 
-	raw_spin_lock_irq(&ctx->lock);
+	guard(raw_spinlock_irq)(&ctx->lock);
 	task = ctx->task;
 	if (WARN_ON_ONCE(task == TASK_TOMBSTONE)) {
 		/*
@@ -2884,19 +2884,15 @@ perf_install_in_context(struct perf_even
 		 * cannot happen), and we hold ctx->mutex, which serializes us
 		 * against perf_event_exit_task_context().
 		 */
-		raw_spin_unlock_irq(&ctx->lock);
 		return;
 	}
 	/*
 	 * If the task is not running, ctx->lock will avoid it becoming so,
 	 * thus we can safely install the event.
 	 */
-	if (task_curr(task)) {
-		raw_spin_unlock_irq(&ctx->lock);
+	if (task_curr(task))
 		goto again;
-	}
 	add_event_to_ctx(event, ctx);
-	raw_spin_unlock_irq(&ctx->lock);
 }
 
 /*


