Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF972BD5B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjFLJzx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjFLJyd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8882618B;
        Mon, 12 Jun 2023 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=U4i7z1jGLLioJYi9TDEcLiRvRYzXl6AqAACZeSAVHVg=; b=SBLpIgKh9BvTgin8OgClkKlYXg
        X5ams+FHzFQ6G1lMnSouT1mDdb4OLsixaSq0XGTpb8qMCrU112HpuhNQoPMpu5LuKgc0l67v7cO1h
        u5ptXidisQWMYnTu9VRqL7lCU0qSFMrhITDD9gjBmwe8Ob3g4CMGsAIsrtG8NhdHIlElo7XiHuBGk
        i6CUfsyeQ89E6j6aUDbi6UnyyLpJP5feQWE/A/0f7bznVuaG82q1C6WO47OsY3j0TTRUJpg1Of5WA
        IRcAI8pTAmFoYuUbcG3n6PWRD/wAaLyzUwLu2dB3lMCN4lr3Q2ZxqN2zU2caRGifvgztAd6QumekK
        vRuQDjXw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0m-008kQu-39;
        Mon, 12 Jun 2023 09:39:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F7FB303383;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D03BE30A77B70; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093540.253514702@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:51 +0200
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
Subject: [PATCH v3 38/57] perf: Simplify IOC_SET_OUTPUT
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
 kernel/events/core.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5762,6 +5762,11 @@ static inline struct fd perf_fdget(int f
 	return f;
 }
 
+static inline bool is_perf_fd(struct fd fd)
+{
+	return fd.file && fd.file->f_op == &perf_fops;
+}
+
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
@@ -5807,19 +5812,15 @@ static long _perf_ioctl(struct perf_even
 
 	case PERF_EVENT_IOC_SET_OUTPUT:
 	{
-		int ret;
 		if (arg != -1) {
 			struct perf_event *output_event;
-			struct fd output = perf_fdget(arg);
-			if (!output.file)
+			CLASS(fd, output)(arg);
+			if (!is_perf_fd(output))
 				return -EBADF;
 			output_event = output.file->private_data;
-			ret = perf_event_set_output(event, output_event);
-			fdput(output);
-		} else {
-			ret = perf_event_set_output(event, NULL);
+			return perf_event_set_output(event, output_event);
 		}
-		return ret;
+		return perf_event_set_output(event, NULL);
 	}
 
 	case PERF_EVENT_IOC_SET_FILTER:


