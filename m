Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62272E26C
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 14:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjFMMFL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 08:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjFMMFK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 08:05:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EEC6;
        Tue, 13 Jun 2023 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=We450CvfOCP5c59KwNDZJAffsENowhZJ2YopwZtAM4U=; b=Jxuk4kbSPlYysuEXYwfqgZpIKY
        2esqqWM2vPb/NR4S3/3h3PHrQNP1yhoWzfZQiQ5k4mzI+0L2rrX8QJXjeU07kXZofj0Bs2tcF7nOf
        u9oVVlB0zcYqxpFYnALo2jah9gsThJH3osCk8TKX8CCm+NgukCW5X32WzTyt+CiZEU9wZ6h4xZWXE
        3+6GILn6Up9tmfFZ65BUr/YifpIB8+Ic1e+8b1VKV1GaFV2eBvySCEsvi8vRwjhe0sujXdjYSEzat
        eJxHoTMCuryayK5b7Sw18BWPtZifEGOFNAQbvy0WK0r2z6w/KLIn0kin1I3zzfj+tJQn8MN04QTRq
        zMiiBHFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q92lk-009M6P-1o;
        Tue, 13 Jun 2023 12:05:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 573C3300322;
        Tue, 13 Jun 2023 14:05:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30EB0245C29F5; Tue, 13 Jun 2023 14:05:03 +0200 (CEST)
Date:   Tue, 13 Jun 2023 14:05:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
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
Subject: Re: [PATCH v3 33/57] perf: Simplify perf_adjust_freq_unthr_context()
Message-ID: <20230613120503.GV4253@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093539.895253662@infradead.org>
 <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
 <20230612184403.GE83892@hirez.programming.kicks-ass.net>
 <CAHk-=wgaSkM4fjdP9dcdXQpLLjxW43ykgLA=FgzyHpyHayz8ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaSkM4fjdP9dcdXQpLLjxW43ykgLA=FgzyHpyHayz8ww@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 11:55:57AM -0700, Linus Torvalds wrote:

> But thinking about it, it's not just that the value doesn't survive,
> it's also that the "continue" will exit the scope in order to go back
> to the "for()" loop.

So if you still feel the continue is a step too far; the alternative
isn't horrible either..

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4090,7 +4090,7 @@ perf_adjust_freq_unthr_context(struct pe
 	if (!(ctx->nr_freq || unthrottle))
 		return;
 
-	raw_spin_lock(&ctx->lock);
+	guard(raw_spinlock)(&ctx->lock);
 
 	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
@@ -4100,7 +4100,7 @@ perf_adjust_freq_unthr_context(struct pe
 		if (!event_filter_match(event))
 			continue;
 
-		perf_pmu_disable(event->pmu);
+		guard(perf_pmu_disable)(event->pmu);
 
 		hwc = &event->hw;
 
@@ -4110,34 +4110,29 @@ perf_adjust_freq_unthr_context(struct pe
 			event->pmu->start(event, 0);
 		}
 
-		if (!event->attr.freq || !event->attr.sample_freq)
-			goto next;
+		if (event->attr.freq && event->attr.sample_freq) {
+			/*
+			 * stop the event and update event->count
+			 */
+			event->pmu->stop(event, PERF_EF_UPDATE);
+
+			now = local64_read(&event->count);
+			delta = now - hwc->freq_count_stamp;
+			hwc->freq_count_stamp = now;
+
+			/*
+			 * restart the event
+			 * reload only if value has changed
+			 * we have stopped the event so tell that
+			 * to perf_adjust_period() to avoid stopping it
+			 * twice.
+			 */
+			if (delta > 0)
+				perf_adjust_period(event, period, delta, false);
 
-		/*
-		 * stop the event and update event->count
-		 */
-		event->pmu->stop(event, PERF_EF_UPDATE);
-
-		now = local64_read(&event->count);
-		delta = now - hwc->freq_count_stamp;
-		hwc->freq_count_stamp = now;
-
-		/*
-		 * restart the event
-		 * reload only if value has changed
-		 * we have stopped the event so tell that
-		 * to perf_adjust_period() to avoid stopping it
-		 * twice.
-		 */
-		if (delta > 0)
-			perf_adjust_period(event, period, delta, false);
-
-		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
-	next:
-		perf_pmu_enable(event->pmu);
+			event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
+		}
 	}
-
-	raw_spin_unlock(&ctx->lock);
 }
 
 /*
