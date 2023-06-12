Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202DD72BD78
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjFLJ4N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjFLJys (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB14C18;
        Mon, 12 Jun 2023 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ICqqJG5l0sWCX8xrZRxbU0jefpCN2MYfe0yl/+VCRM4=; b=CKNAf/OLveGu3h4G35M1XEIV5u
        NBuElad+1Cyz7hAjxLmdiofAlNZ59WVXwN3CrP9Gfl4Ccdi/+VZXviefm9IV8ZOsEiIAALkH+ZQeM
        JSCshvWoOk2ye0l3PailK5L7O/HIe+rzqBLavcMqSUulNXyI0lqc5mlQE1RAC+EzaqyQPBUzKfid5
        LYfkCZS8vnyRr2VmNLRD6E8uxxm0Qg99fQqc78oc6Bz3sD5VsR472rJ6vx1URMn7VGFn0WBGdm0KG
        /Q43F20jOaH5vDTomYkIeci0EFi5Mfq3RUVPKf9bOojvjiudIa4EFwja6+7exCspONRew6SwRyHT0
        wI+FO4zQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0n-008kR8-1I;
        Mon, 12 Jun 2023 09:39:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F98B3033B5;
        Mon, 12 Jun 2023 11:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CA60630A77B6F; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093540.181605463@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:50 +0200
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
Subject: [PATCH v3 37/57] perf: Simplify perf_read_group()
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
 kernel/events/core.c |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5472,11 +5472,10 @@ static int perf_read_group(struct perf_e
 	struct perf_event *leader = event->group_leader, *child;
 	struct perf_event_context *ctx = leader->ctx;
 	int ret;
-	u64 *values;
 
 	lockdep_assert_held(&ctx->mutex);
 
-	values = kzalloc(event->read_size, GFP_KERNEL);
+	u64 *values __free(kfree) = kzalloc(event->read_size, GFP_KERNEL);
 	if (!values)
 		return -ENOMEM;
 
@@ -5486,29 +5485,22 @@ static int perf_read_group(struct perf_e
 	 * By locking the child_mutex of the leader we effectively
 	 * lock the child list of all siblings.. XXX explain how.
 	 */
-	mutex_lock(&leader->child_mutex);
-
-	ret = __perf_read_group_add(leader, read_format, values);
-	if (ret)
-		goto unlock;
-
-	list_for_each_entry(child, &leader->child_list, child_list) {
-		ret = __perf_read_group_add(child, read_format, values);
+	scoped_guard (mutex, &leader->child_mutex) {
+		ret = __perf_read_group_add(leader, read_format, values);
 		if (ret)
-			goto unlock;
-	}
+			return ret;
 
-	mutex_unlock(&leader->child_mutex);
+		list_for_each_entry(child, &leader->child_list, child_list) {
+			ret = __perf_read_group_add(child, read_format, values);
+			if (ret)
+				return ret;
+		}
+	}
 
 	ret = event->read_size;
 	if (copy_to_user(buf, values, event->read_size))
-		ret = -EFAULT;
-	goto out;
+		return -EFAULT;
 
-unlock:
-	mutex_unlock(&leader->child_mutex);
-out:
-	kfree(values);
 	return ret;
 }
 


