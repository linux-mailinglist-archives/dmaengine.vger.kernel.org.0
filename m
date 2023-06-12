Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB04272BD5F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbjFLJz4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjFLJyo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB964C1B;
        Mon, 12 Jun 2023 02:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kTQMzLiQOiysp6z8Xt3S6oOFWuHsLtjxBsNekM1iUPM=; b=FnsYw1rgaWsOiA0J8R1O2i1uX3
        e/F70Qz8dzTuEl3kifFu3bO7NPhClNyjvgCn8IyOXFExymb1mJLxjsIE1VNsGjM+ZK5UdyD9Uvpmx
        8MMlCDrtOaWNKsB/UhUOB/ZOYncIt9ndU2q2e+wO9d2EOd9MKV6zm5aJXolVKFVPXj7clRX/cVNos
        UIEMW7CktYOkUgJCjntPeUklJKZwTRaqyQxMkh9aZMJURF4j5ZOLong2c9l7tRmNOL8u2yfvD2bky
        pOzCMpkX6wckfonGJZWPeiND+Om9Xf6BVzQSrlpTGvnF4Bd5KmsJ+mb8KpkZEAGen/+v1YgVnR9df
        hpzryTVw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0n-008kR9-1O;
        Mon, 12 Jun 2023 09:39:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 446133033BD;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D6BA430A77B71; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093540.324593804@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:52 +0200
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
Subject: [PATCH v3 39/57] perf: Simplify perf_event_*_userpage()
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
 kernel/events/core.c |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5971,10 +5971,10 @@ static void perf_event_init_userpage(str
 	struct perf_event_mmap_page *userpg;
 	struct perf_buffer *rb;
 
-	rcu_read_lock();
+	guard(rcu)();
 	rb = rcu_dereference(event->rb);
 	if (!rb)
-		goto unlock;
+		return;
 
 	userpg = rb->user_page;
 
@@ -5983,9 +5983,6 @@ static void perf_event_init_userpage(str
 	userpg->size = offsetof(struct perf_event_mmap_page, __reserved);
 	userpg->data_offset = PAGE_SIZE;
 	userpg->data_size = perf_data_size(rb);
-
-unlock:
-	rcu_read_unlock();
 }
 
 void __weak arch_perf_update_userpage(
@@ -6004,10 +6001,10 @@ void perf_event_update_userpage(struct p
 	struct perf_buffer *rb;
 	u64 enabled, running, now;
 
-	rcu_read_lock();
+	guard(rcu)();
 	rb = rcu_dereference(event->rb);
 	if (!rb)
-		goto unlock;
+		return;
 
 	/*
 	 * compute total_time_enabled, total_time_running
@@ -6025,7 +6022,7 @@ void perf_event_update_userpage(struct p
 	 * Disable preemption to guarantee consistent time stamps are stored to
 	 * the user page.
 	 */
-	preempt_disable();
+	guard(preempt)();
 	++userpg->lock;
 	barrier();
 	userpg->index = perf_event_index(event);
@@ -6043,9 +6040,6 @@ void perf_event_update_userpage(struct p
 
 	barrier();
 	++userpg->lock;
-	preempt_enable();
-unlock:
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(perf_event_update_userpage);
 
@@ -6061,27 +6055,23 @@ static vm_fault_t perf_mmap_fault(struct
 		return ret;
 	}
 
-	rcu_read_lock();
+	guard(rcu)();
 	rb = rcu_dereference(event->rb);
 	if (!rb)
-		goto unlock;
+		return ret;
 
 	if (vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))
-		goto unlock;
+		return ret;
 
 	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
 	if (!vmf->page)
-		goto unlock;
+		return ret;
 
 	get_page(vmf->page);
 	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
 	vmf->page->index   = vmf->pgoff;
 
-	ret = 0;
-unlock:
-	rcu_read_unlock();
-
-	return ret;
+	return 0;
 }
 
 static void ring_buffer_attach(struct perf_event *event,


