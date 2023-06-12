Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A3372BD65
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjFLJzk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFLJyZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A495FF4;
        Mon, 12 Jun 2023 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=A6Nf2exxWEURXKIPC4PisBIYNsQ8WOBsy7I8/r8MB2I=; b=nlawFV4XolW6/iduWLySiShjYw
        cln2JRO/L02dwlVuY9LVrR5dx3MlqGFfL3bXKejT47tvNXSnylMRfCYpkyOmvJTJzxX3Dkuu3+U9V
        GON9orGticGtLHDO7XjCtQWBLjBGPxQx9TE4ZfwC71+0DHPT+U64tMKz4/QcVn7XKWdGmg/vEjHlw
        a6B5ZSoGuDL/jumilYTnXf3s+pZg++UlLBOa2U4Jw+Tlp8Uwlu4DsCd/18pgblJOjSG6PcbHyR8eK
        n4RIv+2T9+h3z8iLYj3qab8IwhKRiOAXKJ0t/9uLH9RGFqp6GhdoTGkppi9FY/jUA+IXOCEJtextC
        T/wQMAMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0l-002NB5-60; Mon, 12 Jun 2023 09:38:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E881302F75;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 725F830A77B5F; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.085862001@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:35 +0200
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
Subject: [PATCH v3 22/57] perf: Fix cpuctx refcounting
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



Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h |   13 ++++++++-----
 kernel/events/core.c       |   16 ++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -841,11 +841,11 @@ struct perf_event {
 };
 
 /*
- *           ,-----------------------[1:n]----------------------.
- *           V                                                  V
- * perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
- *           ^                      ^     |                     |
- *           `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
+ *           ,-----------------------[1:n]------------------------.
+ *           V                                                    V
+ * perf_event_context <-[1:n]-> perf_event_pmu_context <-[1:n]- perf_event
+ *                                        |                       |
+ *                                        `--[n:1]-> pmu <-[1:n]--'
  *
  *
  * struct perf_event_pmu_context  lifetime is refcount based and RCU freed
@@ -863,6 +863,9 @@ struct perf_event {
  * ctx->mutex pinning the configuration. Since we hold a reference on
  * group_leader (through the filedesc) it can't go away, therefore it's
  * associated pmu_ctx must exist and cannot change due to ctx->mutex.
+ *
+ * perf_event holds a refcount on perf_event_context
+ * perf_event holds a refcount on perf_event_pmu_context
  */
 struct perf_event_pmu_context {
 	struct pmu			*pmu;
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4809,6 +4809,11 @@ find_get_pmu_context(struct pmu *pmu, st
 	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
+		/*
+		 * perf_pmu_migrate_context() / __perf_pmu_install_event()
+		 * relies on the fact that find_get_pmu_context() cannot fail
+		 * for CPU contexts.
+		 */
 		struct perf_cpu_pmu_context *cpc;
 
 		cpc = per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
@@ -12832,6 +12837,13 @@ static void __perf_pmu_install_event(str
 {
 	struct perf_event_pmu_context *epc;
 
+	/*
+	 * Now that the events are unused, put their old ctx and grab a
+	 * reference on the new context.
+	 */
+	put_ctx(event->ctx);
+	get_ctx(ctx);
+
 	event->cpu = cpu;
 	epc = find_get_pmu_context(pmu, ctx, event);
 	event->pmu_ctx = epc;
@@ -12877,6 +12889,10 @@ void perf_pmu_migrate_context(struct pmu
 	struct perf_event_context *src_ctx, *dst_ctx;
 	LIST_HEAD(events);
 
+	/*
+	 * Since per-cpu context is persistent, no need to grab an extra
+	 * reference.
+	 */
 	src_ctx = &per_cpu_ptr(&perf_cpu_context, src_cpu)->ctx;
 	dst_ctx = &per_cpu_ptr(&perf_cpu_context, dst_cpu)->ctx;
 


