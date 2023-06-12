Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2A72BD9E
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjFLJ4d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjFLJyv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D262127;
        Mon, 12 Jun 2023 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=15bpyN9dSHomHwXMCYT6MSRj+ih+/8LUKVobKyJuC4s=; b=WpdHcwE/Bn7t5/ICIYZ5akHT1T
        AGnD4HMO1wGigj+LruzShUv7NXjelPX5LpFyujoZtH2Z1iHiUobvXlccWasHUjJRSMKUN6pJuLa7W
        98n2w9oxMkYOcx1J8YVwkxgQGUICtraIL8UFVycOONamctZs/wRIQ1zZ6mvGc7in/JNVKCV8BmPaW
        Mp3T/auA+btE20jDoL8+8957zF8v5BL3My7WeeP51fRCJQ1lYjUk0+2L2CSuy3SJjhyoEh3qy72ef
        deBz9GXTdmcbd5jIugv2bSCZ+E1YG5lJOeOqkG5rApXiQCRpQ7k7XQTrt/MbairLj7a37ML4ZUZtX
        JHMNouzg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0x-008kTk-2m;
        Mon, 12 Jun 2023 09:39:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7705F306158;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2E28C30A79086; Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Message-ID: <20230612093541.382527855@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:08:06 +0200
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
Subject: [PATCH v3 53/57] perf: Simplify perf_event_sysfs_init()
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
 kernel/events/core.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13503,11 +13503,11 @@ static int __init perf_event_sysfs_init(
 	struct pmu *pmu;
 	int ret;
 
-	mutex_lock(&pmus_lock);
+	guard(mutex)(&pmus_lock);
 
 	ret = bus_register(&pmu_bus);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	list_for_each_entry(pmu, &pmus, entry) {
 		if (pmu->dev)
@@ -13517,12 +13517,8 @@ static int __init perf_event_sysfs_init(
 		WARN(ret, "Failed to register pmu: %s, reason %d\n", pmu->name, ret);
 	}
 	pmu_bus_running = 1;
-	ret = 0;
 
-unlock:
-	mutex_unlock(&pmus_lock);
-
-	return ret;
+	return 0;
 }
 device_initcall(perf_event_sysfs_init);
 


