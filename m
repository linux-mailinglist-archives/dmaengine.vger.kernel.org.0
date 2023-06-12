Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D880072BD5D
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjFLJz6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjFLJyp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F24C21;
        Mon, 12 Jun 2023 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=i6isNClAHvIMw2+OzbyxD8vRwSg4Nx0nqjzFU0CtSfM=; b=MxrQC5up24n4fUnoCZs9xhGydj
        WPiaUY1fVHgP0zt4SgHjFl9bU1FTswRc5S3GTdIwagtnGxmM8g/mVm8h6tFslA0BkAIHCS0lsmsxf
        mXYApR3w+00dThAGwRw5SSsaVtCEesX57GFzuJg1kHrKYomu8aDdoUGY1JDUE8JBHipCfa92Ifv/r
        zd+VuHJHkrbYFig5uYcq1Hizv1HY2WFQ43Hgl/mswdSuUFAi9hjrs2LMVRGruHQWcuZ+8W1Fu1Q+7
        OvClSB+9TLTaaO7D8ryJgXgnOZRmNV9glpRBLCdH+94Z9Be2B+yVwhI1KhGtwMx58ouJ9xNIuEfjs
        v+1zP2IQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0u-002NHx-FF; Mon, 12 Jun 2023 09:39:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D94C30611B;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0DD7E30A79080; Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Message-ID: <20230612093540.931189374@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:08:00 +0200
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
Subject: [PATCH v3 47/57] perf: Simplify perf_pmu_register()
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
 kernel/events/core.c |   40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11344,22 +11344,23 @@ void __perf_pmu_unregister(struct pmu *p
 	free_pmu_context(pmu);
 }
 
-int perf_pmu_register(struct pmu *pmu, const char *name, int type)
+DEFINE_FREE(pmu_unregister, struct pmu *, if (_T) __perf_pmu_unregister(_T))
+
+int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 {
 	int cpu, ret, max = PERF_TYPE_MAX;
 
-	pmu->type = -1;
+	_pmu->type = -1;
+
+	guard(mutex)(&pmus_lock);
+	struct pmu *pmu __free(pmu_unregister) = _pmu;
 
-	mutex_lock(&pmus_lock);
-	ret = -ENOMEM;
 	pmu->pmu_disable_count = alloc_percpu(int);
 	if (!pmu->pmu_disable_count)
-		goto unlock;
+		return -ENOMEM;
 
-	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
-		ret = -EINVAL;
-		goto free;
-	}
+	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n"))
+		return -EINVAL;
 
 	pmu->name = name;
 
@@ -11368,7 +11369,7 @@ int perf_pmu_register(struct pmu *pmu, c
 
 	ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
 	if (ret < 0)
-		goto free;
+		return ret;
 
 	WARN_ON(type >= 0 && ret != type);
 
@@ -11377,13 +11378,12 @@ int perf_pmu_register(struct pmu *pmu, c
 	if (pmu_bus_running && !pmu->dev) {
 		ret = pmu_dev_alloc(pmu);
 		if (ret)
-			goto free;
+			return ret;
 	}
 
-	ret = -ENOMEM;
 	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
 	if (!pmu->cpu_pmu_context)
-		goto free;
+		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
 		struct perf_cpu_pmu_context *cpc;
@@ -11423,21 +11423,14 @@ int perf_pmu_register(struct pmu *pmu, c
 
 	list_add_rcu(&pmu->entry, &pmus);
 	atomic_set(&pmu->exclusive_cnt, 0);
-	ret = 0;
-unlock:
-	mutex_unlock(&pmus_lock);
-
-	return ret;
-
-free:
-	__perf_pmu_unregister(pmu);
-	goto unlock;
+	no_free_ptr(pmu); // let it rip
+	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_register);
 
 void perf_pmu_unregister(struct pmu *pmu)
 {
-	mutex_lock(&pmus_lock);
+	guard(mutex)(&pmus_lock);
 	list_del_rcu(&pmu->entry);
 
 	/*
@@ -11448,7 +11441,6 @@ void perf_pmu_unregister(struct pmu *pmu
 	synchronize_rcu();
 
 	__perf_pmu_unregister(pmu);
-	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 


