Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC872BDA9
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjFLJ4l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjFLJy5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E20E619A;
        Mon, 12 Jun 2023 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TIflEc6HK/22xB9+LAc8fdYfMJHSxjY/dB735CDFq7w=; b=OzxWN5L/KzC4VUo/iTYaWameCX
        hrbwrk3ixeRH23F57jlIRFGWnlTcHuMcV7kLy7osS01tgjphDYs7mWn2JZfDkZ1+rR6EcEvrBxrNq
        zuW6xChuJcvp8qwBU8di5iOmYh8pWWaTGqRRp0lXV86E7IzjUkmvM0B0kyib/7YaiFdsFaLUU6kzN
        jRUGUTzf6TM4YMKKaPBC+AkGNgv4QE6GBnrVTUB+3uvTZYeky0QKBbK68+lbLkHSUur0WJ5xngoPZ
        gJIK2g+KtjpXKF0kOxEZS0dUHbQ0CQVAE0El1MhQ7ke9TlaJD5eefsKkFJQO3sIV0cBEXmZEPvZrb
        0kCDB3Ig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0l-008kQb-39;
        Mon, 12 Jun 2023 09:39:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2813A30325F;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9735A30A77B62; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.537454913@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:41 +0200
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
Subject: [PATCH v3 28/57] perf; Simplify event_sched_in()
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
 kernel/events/core.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1153,6 +1153,8 @@ void perf_pmu_enable(struct pmu *pmu)
 		pmu->pmu_enable(pmu);
 }
 
+DEFINE_GUARD(perf_pmu_disable, struct pmu *, perf_pmu_disable(_T), perf_pmu_enable(_T))
+
 static void perf_assert_pmu_disabled(struct pmu *pmu)
 {
 	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
@@ -2489,7 +2491,6 @@ event_sched_in(struct perf_event *event,
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
 	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
-	int ret = 0;
 
 	WARN_ON_ONCE(event->ctx != ctx);
 
@@ -2517,15 +2518,14 @@ event_sched_in(struct perf_event *event,
 		event->hw.interrupts = 0;
 	}
 
-	perf_pmu_disable(event->pmu);
+	guard(perf_pmu_disable)(event->pmu);
 
 	perf_log_itrace_start(event);
 
 	if (event->pmu->add(event, PERF_EF_START)) {
 		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 		event->oncpu = -1;
-		ret = -EAGAIN;
-		goto out;
+		return -EAGAIN;
 	}
 
 	if (!is_software_event(event))
@@ -2536,10 +2536,7 @@ event_sched_in(struct perf_event *event,
 	if (event->attr.exclusive)
 		cpc->exclusive = 1;
 
-out:
-	perf_pmu_enable(event->pmu);
-
-	return ret;
+	return 0;
 }
 
 static int


