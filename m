Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C9172BE70
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjFLKMr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjFLKM1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 06:12:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10DF44A0;
        Mon, 12 Jun 2023 02:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HSJpGOrjCtJnZnFroylDCf7Rjcbog3OzeJBiNYZJX7o=; b=o+pkq7ygLjhrbdBlWofvqd8xnx
        vWl+lMxecy+qVMaEDoNSt+ATt7ETwAhhR5OUYDWlVf2miE7SL46ItJcSZGLApmQnVBPcrS0PKOiHr
        tSE4D7Rb2Eixoh0+PGG61PoONPZ8KdIi4JGrEw91Ebrlc6guacC2Pifl5wYD+aRnj1beiVs7DJ0Q+
        hCbOB1F1Y6PLp8fYU7DvjOjLYEdz6qr0vqFc+alciEj6+zLggoFd3luXnDaYLQsaioq+ogCTorb3k
        ymVcbYVg66hz8tmyaY90x+TGbG+i202Rsb3uG120iV91GmHLjVXkzxobA5cSjS4157KKdT/Yt59gz
        VM/hIidw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8eDP-002QJR-Ni; Mon, 12 Jun 2023 09:51:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55C3830058D;
        Mon, 12 Jun 2023 11:51:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F59F2C17E189; Mon, 12 Jun 2023 11:51:59 +0200 (CEST)
Date:   Mon, 12 Jun 2023 11:51:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        dennis@kernel.org, tj@kernel.org, cl@linux.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
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
Subject: Re: [PATCH v3 00/57] Scope-based Resource Management
Message-ID: <20230612095159.GH4253@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612090713.652690195@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 11:07:13AM +0200, Peter Zijlstra wrote:
> Hi,
> 
> After a wee bit of bike-shedding on the syntax/API of the thing I think we're
> in a reasonable shape.
> 
> There's still the no_free_ptr() vs take_ptr() thing, but that can be easily
> sorted with a little script over the patches if we reach consensus.
> 
> I've taken to converting kernel/sched/core.c and kernel/events/core.c to see
> how well this stuff actually works. Unlike last time, I've split them up into a
> gazillion little patches. Both for my sanity -- bisect is genius when you're
> trying to debug stuff in the middle of the night as well as reviewer sanity.
> 
> These are by no means 'complete' convertions, I've mostly focussed on functions
> that had 'goto' in them. Since that's a large part of why I started on all this.
> 
> x86_x64-defconfig boots and passes perf test. I'll go figure out how to point
> syzcaller at it.
> 
> The patches have gone through a few cycles of 0day over the weekend, and mostly
> builds fine now.
> 
> Dan Carpenter poked me about how sparse doesn't yet understand the __cleanup__
> attribute and seems to suffer from decl-after-stmt issues, so that might be
> something that needs attention.
> 
> Anyway, does this look like something we can live with?

Forgot to mention; also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git core/guards2

(core/guards also exists, but that is a previous version that I kept
because I wanted to discuss some 'interesting' clang build fails)

> 
> ---
>  Makefile                            |    6 +-
>  arch/arm64/kernel/vdso32/Makefile   |    2 -
>  drivers/dma/ioat/dma.c              |   12 +-
>  include/linux/cleanup.h             |  167 ++++
>  include/linux/compiler-clang.h      |    9 +
>  include/linux/compiler_attributes.h |    6 +
>  include/linux/cpu.h                 |    2 +
>  include/linux/device.h              |    7 +
>  include/linux/file.h                |   11 +
>  include/linux/irqflags.h            |    7 +
>  include/linux/mutex.h               |    4 +
>  include/linux/percpu.h              |    4 +
>  include/linux/perf_event.h          |   14 +-
>  include/linux/preempt.h             |    5 +
>  include/linux/rcupdate.h            |    3 +
>  include/linux/rwsem.h               |    8 +
>  include/linux/sched/task.h          |    2 +
>  include/linux/slab.h                |    3 +
>  include/linux/spinlock.h            |   31 +
>  include/linux/srcu.h                |    5 +
>  kernel/events/core.c                | 1642 +++++++++++++++--------------------
>  kernel/sched/core.c                 |  931 +++++++++-----------
>  kernel/sched/sched.h                |   40 +
>  scripts/checkpatch.pl               |    2 +-
>  security/apparmor/include/lib.h     |    6 +-
>  25 files changed, 1433 insertions(+), 1496 deletions(-)
> 
