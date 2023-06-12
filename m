Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1585B72BD6C
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjFLJ4J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjFLJyr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7EB618E;
        Mon, 12 Jun 2023 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DAYbQ04kMNbr7rbW92MpBohW/rYLgWGXJr8J1HFf6A8=; b=Eql5NktjOLj2JVeZy3dcrxBiKN
        oWALo/DK/LD+f6T9ZB3Dgywb7GPNlY8H/tRWl4kVmO9CaHN201KZm8mVNoWCxScenFixVED6f65dd
        iJvjjgm/3/g6SDb8g+O4H0vFDof5sX8qGgqc87R3eMRZAzpydHhdZbVck82t+acSqNl7nYRXGl5Ya
        9Ur/TUPNUv4D5nUorGgGshJzNa7cbJ7ZIN5oDo8G7gx8X+tLK1erIaYpMHuGy/OZS4keZgugjEIeH
        bI+dznInCYdmNjALn5gUQRRF1Z4aRfWMRQS531g9eeeBR+lMwpK4uCY/gCSh3DlrxbhtjarAQFF9J
        /w8uXayg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0v-002NJJ-NW; Mon, 12 Jun 2023 09:39:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D67130613D;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2806930A79085; Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Message-ID: <20230612093541.311174114@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:08:05 +0200
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
Subject: [PATCH v3 52/57] perf: Simplify perf_event_init_context()
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
 kernel/events/core.c |   29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1450,6 +1450,10 @@ static void perf_unpin_context(struct pe
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
 }
 
+DEFINE_CLASS(pin_task_ctx, struct perf_event_context *,
+	     if (_T) { perf_unpin_context(_T); put_ctx(_T); },
+	     perf_pin_task_context(task), struct task_struct *task)
+
 /*
  * Update the record of the current time in a context.
  */
@@ -7939,18 +7943,13 @@ static void perf_event_addr_filters_exec
 
 void perf_event_exec(void)
 {
-	struct perf_event_context *ctx;
-
-	ctx = perf_pin_task_context(current);
+	CLASS(pin_task_ctx, ctx)(current);
 	if (!ctx)
 		return;
 
 	perf_event_enable_on_exec(ctx);
 	perf_event_remove_on_exec(ctx);
 	perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
-
-	perf_unpin_context(ctx);
-	put_ctx(ctx);
 }
 
 struct remote_output {
@@ -13226,8 +13225,7 @@ inherit_task_group(struct perf_event *ev
  */
 static int perf_event_init_context(struct task_struct *child, u64 clone_flags)
 {
-	struct perf_event_context *child_ctx, *parent_ctx;
-	struct perf_event_context *cloned_ctx;
+	struct perf_event_context *child_ctx, *cloned_ctx;
 	struct perf_event *event;
 	struct task_struct *parent = current;
 	int inherited_all = 1;
@@ -13241,7 +13239,7 @@ static int perf_event_init_context(struc
 	 * If the parent's context is a clone, pin it so it won't get
 	 * swapped under us.
 	 */
-	parent_ctx = perf_pin_task_context(parent);
+	CLASS(pin_task_ctx, parent_ctx)(parent);
 	if (!parent_ctx)
 		return 0;
 
@@ -13256,7 +13254,7 @@ static int perf_event_init_context(struc
 	 * Lock the parent list. No need to lock the child - not PID
 	 * hashed yet and not running, so nobody can access it.
 	 */
-	mutex_lock(&parent_ctx->mutex);
+	guard(mutex)(&parent_ctx->mutex);
 
 	/*
 	 * We dont have to disable NMIs - we are only looking at
@@ -13266,7 +13264,7 @@ static int perf_event_init_context(struc
 		ret = inherit_task_group(event, parent, parent_ctx,
 					 child, clone_flags, &inherited_all);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
 
 	/*
@@ -13282,7 +13280,7 @@ static int perf_event_init_context(struc
 		ret = inherit_task_group(event, parent, parent_ctx,
 					 child, clone_flags, &inherited_all);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
 
 	raw_spin_lock_irqsave(&parent_ctx->lock, flags);
@@ -13310,13 +13308,8 @@ static int perf_event_init_context(struc
 	}
 
 	raw_spin_unlock_irqrestore(&parent_ctx->lock, flags);
-out_unlock:
-	mutex_unlock(&parent_ctx->mutex);
-
-	perf_unpin_context(parent_ctx);
-	put_ctx(parent_ctx);
 
-	return ret;
+	return 0;
 }
 
 /*


