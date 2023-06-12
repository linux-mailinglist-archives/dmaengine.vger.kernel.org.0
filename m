Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3372BD4B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjFLJzu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjFLJya (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300A5FFF;
        Mon, 12 Jun 2023 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ldnPYKUyHMdijInwVZoC1NuQUIqnzmW6aookZYRZh1U=; b=bJBHJIBXVRdeQP4T7XcXUY8iMH
        di/jzbHG8QdRKgt7X5fFBZSQuExIhm4OtWcsQgbp82u82KzPGnsNgHCPG1r7wDa+Zf3Yybo+MMKKD
        6kzpW7tb12oZwh2LWxC5mYsLBh3EeFF5Mx+gfLH4YWuoPB20Wmu38WpRv0/JFEDPN3I3WnPAdrUZG
        N9RCoJPL7qvE55pcs319+8ceIKd9bh09dAM074UmAS+nhI32VGb65JKPNV7DU57u9vWRkuYFwBSRv
        PUJltPdiKo1thqnI10zGjkLcJXnNDVTEEIJgdNDcoNHm4ClkGvI5OiDwY24bhEmzI8eSOZmwAqbCa
        RgBj18Gg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0l-002NB9-De; Mon, 12 Jun 2023 09:38:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18413303164;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7F8B230A77B61; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093539.300603001@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:38 +0200
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
Subject: [PATCH v3 25/57] perf: Simplify perf_fget_light()
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

Introduce fdnull and use it to simplify perf_fget_light() to either
return a valid struct fd or not -- much like fdget() itself.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/file.h |    7 ++++++-
 kernel/events/core.c |   22 +++++++++++-----------
 2 files changed, 17 insertions(+), 12 deletions(-)

--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -59,6 +59,8 @@ static inline struct fd __to_fd(unsigned
 	return (struct fd){(struct file *)(v & ~3),v & 3};
 }
 
+#define fdnull __to_fd(0)
+
 static inline struct fd fdget(unsigned int fd)
 {
 	return __to_fd(__fdget(fd));
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5802,18 +5802,17 @@ EXPORT_SYMBOL_GPL(perf_event_period);
 
 static const struct file_operations perf_fops;
 
-static inline int perf_fget_light(int fd, struct fd *p)
+static inline struct fd perf_fdget(int fd)
 {
 	struct fd f = fdget(fd);
 	if (!f.file)
-		return -EBADF;
+		return fdnull;
 
 	if (f.file->f_op != &perf_fops) {
 		fdput(f);
-		return -EBADF;
+		return fdnull;
 	}
-	*p = f;
-	return 0;
+	return f;
 }
 
 static int perf_event_set_output(struct perf_event *event,
@@ -5864,10 +5863,9 @@ static long _perf_ioctl(struct perf_even
 		int ret;
 		if (arg != -1) {
 			struct perf_event *output_event;
-			struct fd output;
-			ret = perf_fget_light(arg, &output);
-			if (ret)
-				return ret;
+			struct fd output = perf_fdget(arg);
+			if (!output.file)
+				return -EBADF;
 			output_event = output.file->private_data;
 			ret = perf_event_set_output(event, output_event);
 			fdput(output);
@@ -12401,9 +12399,11 @@ SYSCALL_DEFINE5(perf_event_open,
 		return event_fd;
 
 	if (group_fd != -1) {
-		err = perf_fget_light(group_fd, &group);
-		if (err)
+		group = perf_fdget(group_fd);
+		if (!group.file) {
+			err = -EBADF;
 			goto err_fd;
+		}
 		group_leader = group.file->private_data;
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;


