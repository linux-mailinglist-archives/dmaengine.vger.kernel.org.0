Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E4D72F7C2
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbjFNIZx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 04:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbjFNIZw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 04:25:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92951A1;
        Wed, 14 Jun 2023 01:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xz5/VyeWvrJxvz7Vj1Bej8cUKvcRWi1AM/YLcdj+D/Y=; b=BRDdoKzwDzkGKB+A7e3ag/q8ah
        OuIxesfxVQag4DfRTqhUekNoppHbkzvJkwCCICkhEf8dky95UyM5bzWwWxiNms2GIKgSietdNCacr
        HKrpLs/0yU3FtQlwoH2plJxAxqyXuzokNnbLBzeUE9RSI7aVLHoO8WAyzDiPUNVNg7d4jKQdfqnkK
        9h4Yy3POzOVCIIQ6n1ZFg5fvmffQFY8z1DLGdH80TK1X/ioX1bFq0p3iImYmiPCTfOGxyHwcnHVIe
        dc1+v/iDoOcVsxc8xJStSr7UlxJxe/mokgVK6nXWCJOg+fkstoS29jdcRppL3KDo7lAMYq+k7jWOq
        4GBG8M1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9Loz-00Abb2-0b;
        Wed, 14 Jun 2023 08:25:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C65B930031B;
        Wed, 14 Jun 2023 10:25:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 975E227F86A4E; Wed, 14 Jun 2023 10:25:39 +0200 (CEST)
Date:   Wed, 14 Jun 2023 10:25:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com, nathan@kernel.org,
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
Subject: Re: [PATCH v3 04/57] kbuild: Drop -Wdeclaration-after-statement
Message-ID: <20230614082539.GB1639749@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093537.693926033@infradead.org>
 <CAK7LNARwAaw_22AjsheMtNwpVgF7FtKxh08mkg3cP=bY2016hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARwAaw_22AjsheMtNwpVgF7FtKxh08mkg3cP=bY2016hw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 14, 2023 at 03:13:03PM +0900, Masahiro Yamada wrote:
> On Mon, Jun 12, 2023 at 6:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > With the advent on scope-based resource management it comes really
> > tedious to abide by the contraints of -Wdeclaration-after-statement.
> 
> Where is the context of Linus' suggested-by?
> 
> I do not know where this came from.
> I suddenly got a huge v3 in my mailbox.
> 
> 
> I see an equivalent patch submitted last year:
> https://lore.kernel.org/lkml/Y1w031iI6Ld29IVT@p183/
> 
> Linus rejected it. Did he change his mind?

https://lkml.kernel.org/r/CAHk-%3Dwi-RyoUhbChiVaJZoZXheAwnJ7OO%3DGxe85BkPAd93TwDA%40mail.gmail.com

I'll add it as a Link tag to the Changelog.

> 
> > It will still be recommeneded to place declarations at the start of a
> > scope where possible, but it will no longer be enforced.
> 
> If you remove the warning, we will not be able to
> detect code that opts out the recommendation
> for no good reason.

Yeah, so per that thread linked above I tried to play clever games with
_Pragma() to get around this, but GCC hates on it (works fine with Clang
though).

Linus said to just give up and scrap the whole
-Wdeclaration-after-statement thing.

I suppose it'll be up to reviewers and perhaps checkpatch like things to
'enforce' the rules.
