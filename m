Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92A72BD52
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFLJ4H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjFLJyr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F854C20;
        Mon, 12 Jun 2023 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=R8zokz8HpLYR/tS6Df4K9QtMMliKooDPknNNGx1Aq0A=; b=gDtWsQkYmCDnkEwKNGgB3R3yg5
        AQY1YY9Pt79S6dVL6CWepHSUTi7Jk2ap0PirgoxJz1fjs1z3NKbdLaY23YcYonOyGm9p5ZcrqukWc
        yahOpmdpqbTYWS9bKccGyNolDypM6QDGY9gdEy70lbk3rS4+jMW+Sv98MjpmckatRRRmbimMkq23O
        vXAs7ycWwEeJNAkE/ixzJXGvLIQcTSvvlAur3TsCI9Ilrhz2nzXNDbdx1TsVCzn07sqZDE31KbMn4
        EtMMfJoiXbcTAoBrqdc9gvRSE1k4X7as2PcuNqT2QlErwrhHL5omOT8gwrGh0frufhfqd9bor9oz2
        0FAle/iA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0m-008kQd-03;
        Mon, 12 Jun 2023 09:38:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29CF5303287;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A6ED730A77B69; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.753013700@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:44 +0200
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
Subject: [PATCH v3 31/57] perf: Simplify perf_event_modify_attr()
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
 kernel/events/core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3172,7 +3172,7 @@ static int perf_event_modify_attr(struct
 
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 
-	mutex_lock(&event->child_mutex);
+	guard(mutex)(&event->child_mutex);
 	/*
 	 * Event-type-independent attributes must be copied before event-type
 	 * modification, which will validate that final attributes match the
@@ -3181,16 +3181,16 @@ static int perf_event_modify_attr(struct
 	perf_event_modify_copy_attr(&event->attr, attr);
 	err = func(event, attr);
 	if (err)
-		goto out;
+		return err;
+
 	list_for_each_entry(child, &event->child_list, child_list) {
 		perf_event_modify_copy_attr(&child->attr, attr);
 		err = func(child, attr);
 		if (err)
-			goto out;
+			return err;
 	}
-out:
-	mutex_unlock(&event->child_mutex);
-	return err;
+
+	return 0;
 }
 
 static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,


