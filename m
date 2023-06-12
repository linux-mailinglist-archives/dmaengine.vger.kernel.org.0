Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F4A72C71D
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbjFLONc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjFLONb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 10:13:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA6619C;
        Mon, 12 Jun 2023 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YuoSYIwzlBxsdlS3Y9eVTjnDcsmeIQ/DnljZgcOBaZw=; b=UNNP3dhdds+BYyVoIihlLYDIuP
        i78JDjPyJ+sF2YTyRdyxBNLZMvXGy6ZopXlqg7B4xmGDSR+RUb06Puhjbs2jQBfQiclvJRQWg61Jh
        yRFenIN3Uumo2fDaSL7nOqYsX1YBe514S1e802EzV1jngbVnWthj5PbR6UeZc7KvsR2HK8/ETWqgy
        P+ElA9T4urPvZJvFRVp13ytWhZKRoHrk2/Tt2kv62NmutmV3veM9oyWllo6NvJ9bA8DtDiBTUTvF+
        Cyf8hCKoVSBeEfMbk5Ra0DDfVuP2CT8k/Dwbi7ggyw8n17BtGxYJszaA852cXqBGHBX6YeqQ4bwQp
        VkuHCqZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8iIN-002hro-Mc; Mon, 12 Jun 2023 14:13:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B81D030058D;
        Mon, 12 Jun 2023 16:13:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F4B12BFD8191; Mon, 12 Jun 2023 16:13:22 +0200 (CEST)
Date:   Mon, 12 Jun 2023 16:13:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
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
Subject: Re: [PATCH v3 46/57] perf: Simplify pmu_dev_alloc()
Message-ID: <20230612141322.GA83892@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
 <20230612094400.GG4253@hirez.programming.kicks-ass.net>
 <2023061226-grumpily-entire-f06a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061226-grumpily-entire-f06a@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 03:35:49PM +0200, Greg KH wrote:

> Ick, this is going to be a rough audit for bus code that gets converted
> to this, BUT bonus is that once it's done, any changes to the middle of
> the function should "just work", and it's a good task for an intern to
> do :)

Hehe. The 'bonus' in all this is that if you get it wrong, it's the very
likely success case that goes sideways and it should instantly explode.

While all the unlikely error cases should all just work -- famous last
words etc..

> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

> Mind if I try this series to convert a more "normal" driver to see how
> it works with that?  That's going to be the true test, see if the
> changes make sense to someone who doesn't really know the internals of
> the driver core like this...

Not at all, feel tree to have a go at that. I picked code I was familiar
with, but it would ofc. be good to have others give it a spin too.
