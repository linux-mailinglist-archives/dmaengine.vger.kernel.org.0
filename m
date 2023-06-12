Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D834472BD92
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbjFLJ4Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjFLJyt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B766F10B;
        Mon, 12 Jun 2023 02:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZQvmg1eOC4ujP8jeHKMUa0GcDNPOQum0WTJAKmNFtGA=; b=as17JFHf5X4sS4LnfYcat1PiC9
        Ygl21SzRcEI+y+2s58m4VR+c7k+AqAwe8jlPtnzWmYl16IPdeW/wTda3t/Mn+GoaB6Ioy1Fvsxcy2
        Yc7m5IWDLwQXyvHo1rqnA6Jd0Y/RCI4mTEKdvBgQKhW2SUqz6/ofm3f2FtyVL6QmqCFhXv+NfXBW9
        jwT1Z54p5Lij0CfiCqCeWuIXPASZuIXQbi9qaYtAB9PxGVZuCAPJ0xBo+WgJ0/KwZTrb1lbhfQH4p
        1LKUHGwtrRUZDPpZ0MI3ymQ1XUCHq292Bw25ogsKjYnaaZ9XHIUSkaTDUL7Zx23RRYEU3HshnTJui
        hSQE7vqg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0n-008kRD-37;
        Mon, 12 Jun 2023 09:39:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 487FF3033CB;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DC80030A77B72; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093540.407316252@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:53 +0200
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
Subject: [PATCH v3 40/57] perf: Simplify perf_mmap_close()/perf_aux_sample_output()
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
 kernel/events/core.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6179,6 +6179,9 @@ void ring_buffer_put(struct perf_buffer
 	call_rcu(&rb->rcu_head, rb_free_rcu);
 }
 
+DEFINE_CLASS(ring_buffer_get, struct perf_buffer *, ring_buffer_put(_T),
+	     ring_buffer_get(event), struct perf_event *event)
+
 static void perf_mmap_open(struct vm_area_struct *vma)
 {
 	struct perf_event *event = vma->vm_file->private_data;
@@ -6206,7 +6209,7 @@ static void perf_pmu_output_stop(struct
 static void perf_mmap_close(struct vm_area_struct *vma)
 {
 	struct perf_event *event = vma->vm_file->private_data;
-	struct perf_buffer *rb = ring_buffer_get(event);
+	CLASS(ring_buffer_get, rb)(event);
 	struct user_struct *mmap_user = rb->mmap_user;
 	int mmap_locked = rb->mmap_locked;
 	unsigned long size = perf_data_size(rb);
@@ -6245,14 +6248,14 @@ static void perf_mmap_close(struct vm_ar
 		detach_rest = true;
 
 	if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
-		goto out_put;
+		return;
 
 	ring_buffer_attach(event, NULL);
 	mutex_unlock(&event->mmap_mutex);
 
 	/* If there's still other mmap()s of this buffer, we're done. */
 	if (!detach_rest)
-		goto out_put;
+		return;
 
 	/*
 	 * No other mmap()s, detach from all other events that might redirect
@@ -6309,9 +6312,6 @@ static void perf_mmap_close(struct vm_ar
 			&mmap_user->locked_vm);
 	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
 	free_uid(mmap_user);
-
-out_put:
-	ring_buffer_put(rb); /* could be last */
 }
 
 static const struct vm_operations_struct perf_mmap_vmops = {
@@ -6962,14 +6962,13 @@ static void perf_aux_sample_output(struc
 				   struct perf_sample_data *data)
 {
 	struct perf_event *sampler = event->aux_event;
-	struct perf_buffer *rb;
 	unsigned long pad;
 	long size;
 
 	if (WARN_ON_ONCE(!sampler || !data->aux_size))
 		return;
 
-	rb = ring_buffer_get(sampler);
+	CLASS(ring_buffer_get, rb)(sampler);
 	if (!rb)
 		return;
 
@@ -6982,7 +6981,7 @@ static void perf_aux_sample_output(struc
 	 * like to know.
 	 */
 	if (WARN_ON_ONCE(size < 0))
-		goto out_put;
+		return;
 
 	/*
 	 * The pad comes from ALIGN()ing data->aux_size up to u64 in
@@ -6996,9 +6995,6 @@ static void perf_aux_sample_output(struc
 		u64 zero = 0;
 		perf_output_copy(handle, &zero, pad);
 	}
-
-out_put:
-	ring_buffer_put(rb);
 }
 
 /*


