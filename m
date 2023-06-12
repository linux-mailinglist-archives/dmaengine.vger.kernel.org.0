Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F3672BD75
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjFLJzm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjFLJy0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE925FF6;
        Mon, 12 Jun 2023 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=quWvb6uoZHCgYMmf8H+8cRm/zhKpzM+NkhuuDLi/jU0=; b=JgwzlZkLk5FJYWO7LoFzK1cisC
        aBQ5LhcXjSO7nFEY2UqQ25IYFqShzwF1MEvo2tYaU3xImhwE97+SRgARWwFOM90DmkkOcTM9vvRiN
        K0D/nxB7wgTutGs/BJUirFozMwU4pHGGZoMJI6+adCj6IubDSLGtZCjbBSTXj036wzszfXPaQClUq
        oDqcKFVTI1+O0Qci768RPoGOOBWrHX6+9VlTGBbGcmYgpqiU9DPthnR9bD67ex3yjQ70UNt/X6uBI
        49tCO/xKdnsDsuMyH017UA+KPvphoPEfQ2aAhY1SshrRO7CJ3qDBk6tC9l/vfG5WFBXRBMcA2cQPG
        Y3EYDKXw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0l-002NBZ-TV; Mon, 12 Jun 2023 09:38:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2823C30326D;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 93BC430A77B64; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.452507393@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:40 +0200
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
Subject: [PATCH v3 27/57] perf: Simplify perf_cgroup_connect()
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
 include/linux/file.h |    2 +-
 kernel/events/core.c |   19 ++++++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -936,22 +936,20 @@ static inline int perf_cgroup_connect(in
 {
 	struct perf_cgroup *cgrp;
 	struct cgroup_subsys_state *css;
-	struct fd f = fdget(fd);
-	int ret = 0;
+	int ret;
 
+	CLASS(fd, f)(fd);
 	if (!f.file)
 		return -EBADF;
 
 	css = css_tryget_online_from_dir(f.file->f_path.dentry,
 					 &perf_event_cgrp_subsys);
-	if (IS_ERR(css)) {
-		ret = PTR_ERR(css);
-		goto out;
-	}
+	if (IS_ERR(css))
+		return PTR_ERR(css);
 
 	ret = perf_cgroup_ensure_storage(event, css);
 	if (ret)
-		goto out;
+		return ret;
 
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
@@ -963,11 +961,10 @@ static inline int perf_cgroup_connect(in
 	 */
 	if (group_leader && group_leader->cgrp != cgrp) {
 		perf_detach_cgroup(event);
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-out:
-	fdput(f);
-	return ret;
+
+	return 0;
 }
 
 static inline void


