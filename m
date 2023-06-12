Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78C72CEC8
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbjFLSzb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbjFLSza (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 14:55:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27279191;
        Mon, 12 Jun 2023 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XU9axK6uJmgJQSoRJwESZ2YBCmhPiMFjehu8M/bt6Oc=; b=XJrtEAlNGUViNk2I8uromZnxAN
        y67PsTqpBRBXoyek6Zz+je9F85sK+DswAds9df4ulomauw0qUo+BsEdXNj5stYUCugnce0iEHDboX
        XYfUx29MyP72Mg96SlLMA28rwjdgB2EDa/srjIuXi6agrwXAgjfZG/fPscsbWB+CIR+BcV67a5bVL
        pmVZcSplUuasjwopkvRPzYde3vRNJViddCZHE4OFfkOGux1/XKUA0eKympr6E3gHHsGmoyuGbjyQe
        s1wVbgQr9lgk13pCQo8ulF8w7zoaPDplj641d09YAElMJDpws75ZDeP3UZppfZOXDKbfG/lXH4sql
        3o2qF37A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8mhH-002x4C-A8; Mon, 12 Jun 2023 18:55:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71D6E30058D;
        Mon, 12 Jun 2023 20:55:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D4B320D70605; Mon, 12 Jun 2023 20:55:22 +0200 (CEST)
Date:   Mon, 12 Jun 2023 20:55:22 +0200
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
Subject: Re: [PATCH v3 56/57] perf: Simplify perf_pmu_output_stop()
Message-ID: <20230612185522.GF83892@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093541.598260416@infradead.org>
 <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 09:19:19AM -0700, Linus Torvalds wrote:
> This patch looks completely broken to me.
> 
> You now do
> 
>                 if (err == -EAGAIN)
>                         goto restart;
> 
> *within* the RCU-guarded section, and the "goto restart" will guard it again.

restart:
	guard(rcu)();
	list_for_each_entry_rcu(iter, &head, rb_entry) {
		...
		if (err == -EAGAIN)
			goto restart;
	}

So the restart is *before* the variable exists, eg. it's out-of-scope.

per the last email's guard.c, if changed like so:

void main(void)
{
	int done = 0;
restart:
	lock_guard(spin, moo, &lock);
	for (;!done;) {
		done = 1;
		goto restart;
	}
}

$ gcc -O2 -o guard guard.c && ./guard
spin_lock
spin_unlock
spin_lock
spin_unlock

Which is exactly the expected result.




