Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64A72BD97
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjFLJ42 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjFLJyw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8864C19;
        Mon, 12 Jun 2023 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9OWN91/cXOLRfmVSj/c39yenMABydmgJP4BxXsEr7m4=; b=ODMSw25KlwnbIZwtM8Ooplwz3S
        avsg1C00hw0ZNaZy9SLLjMZe48szqJxUiobcK4beCgvel6ihAYx2CB/a5nHYQfhh+vAHV4C8Cmzs9
        sHrFLrQ8JgaSA/kQmUkLW4qOpTYgvv7KZlHNVaG4mFStN9gg4I9vNmU5SCLRgi1KP1mNG2IqtUsMx
        Bn2lgUNR5mJw4d6qus/8zp5DlFSOnjyVpqcuU6rRQsEHrG6c+y/Y3B/BEKX+tLP83TTc2c2wVlwgW
        ZQhT0qliAPMSaNLZeLP4zzJpsXK4sXqa3/eS25o+5DQB5pDBPNuzZ9bbmC1N5UaAjMUFBVYOytSF3
        R2+1UEzw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0x-008kTl-30;
        Mon, 12 Jun 2023 09:39:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 783DC30615A;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3757230A79088; Mon, 12 Jun 2023 11:38:49 +0200 (CEST)
Message-ID: <20230612093541.524967360@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:08:08 +0200
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
Subject: [PATCH v3 55/57] perf: Simplify find_get_context()
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
 kernel/events/core.c |   46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1202,6 +1202,8 @@ static void put_ctx(struct perf_event_co
 	}
 }
 
+DEFINE_FREE(put_ctx, struct perf_event_context *, if (_T) put_ctx(_T))
+
 /*
  * Because of perf_event::ctx migration in sys_perf_event_open::move_group and
  * perf_pmu_migrate_context() we need some magic.
@@ -4718,41 +4720,29 @@ find_get_context(struct task_struct *tas
 		if (clone_ctx)
 			put_ctx(clone_ctx);
 	} else {
-		ctx = alloc_perf_context(task);
-		err = -ENOMEM;
-		if (!ctx)
-			goto errout;
-
-		err = 0;
-		mutex_lock(&task->perf_event_mutex);
-		/*
-		 * If it has already passed perf_event_exit_task().
-		 * we must see PF_EXITING, it takes this mutex too.
-		 */
-		if (task->flags & PF_EXITING)
-			err = -ESRCH;
-		else if (task->perf_event_ctxp)
-			err = -EAGAIN;
-		else {
-			get_ctx(ctx);
-			++ctx->pin_count;
-			rcu_assign_pointer(task->perf_event_ctxp, ctx);
-		}
-		mutex_unlock(&task->perf_event_mutex);
+		struct perf_event_context *new __free(put_ctx) =
+			alloc_perf_context(task);
+		if (!new)
+			return ERR_PTR(-ENOMEM);
 
-		if (unlikely(err)) {
-			put_ctx(ctx);
+		scoped_guard (mutex, &task->perf_event_mutex) {
+			/*
+			 * If it has already passed perf_event_exit_task().
+			 * we must see PF_EXITING, it takes this mutex too.
+			 */
+			if (task->flags & PF_EXITING)
+				return ERR_PTR(-ESRCH);
 
-			if (err == -EAGAIN)
+			if (task->perf_event_ctxp)
 				goto retry;
-			goto errout;
+
+			ctx = get_ctx(no_free_ptr(new));
+			++ctx->pin_count;
+			rcu_assign_pointer(task->perf_event_ctxp, ctx);
 		}
 	}
 
 	return ctx;
-
-errout:
-	return ERR_PTR(err);
 }
 
 DEFINE_CLASS(find_get_ctx, struct perf_event_context *,


