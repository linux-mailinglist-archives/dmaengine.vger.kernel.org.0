Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E69972DB22
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjFMHj0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjFMHjZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 03:39:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B145AA;
        Tue, 13 Jun 2023 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=taRVbZGY7eAXHJhyY2OAnvNRfmEw/YGDeNE955RAneg=; b=SSSgJkLhu3YuuINw2k2MVqvpqi
        +ztKeSYuIf74buBISQjNnX6mCLgaks/PpKfNeJxr+t//9qZokbhZKLNijcckFwnsBfmmNdKsdZjjA
        3Osvfpq7wbzyTiNuEasQllKRZCfsvGymP8Qv/U3BwZJEFkiGPpDh5tUBPv51YLHZpQAU7lUX6NhxW
        6r40yFfUk+5jjTMo48WCrYlfYS+kq0C+CndrLkDzMkT4hReWVDdcAPm051jXG1w4jf/BEOjYTZHv5
        qASwirDJhNT88jMfD5z7n77VE5AXU09xDPkjNIwfagrp107CbwSQ/8N+Q2AkSVgJEupK6JJAtUrTB
        f3oBSdsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8ycV-009Hzm-2r;
        Tue, 13 Jun 2023 07:39:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2CF0300322;
        Tue, 13 Jun 2023 09:39:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5A342C8E889C; Tue, 13 Jun 2023 09:39:14 +0200 (CEST)
Date:   Tue, 13 Jun 2023 09:39:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        dennis@kernel.org, tj@kernel.org, cl@linux.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
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
Subject: Re: [PATCH v3 26/57] perf: Simplify event_function*()
Message-ID: <20230613073914.GQ4253@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093539.371360635@infradead.org>
 <CAM9d7cjz4cnEgV_oAnTOqyCWXDeD3ECYQFc=Uksct2-HKuFmiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjz4cnEgV_oAnTOqyCWXDeD3ECYQFc=Uksct2-HKuFmiQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 10:56:06PM -0700, Namhyung Kim wrote:
> Hi Peter,
> 
> On Mon, Jun 12, 2023 at 2:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Use guards to reduce gotos and simplify control flow.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/events/core.c |   39 ++++++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 13 deletions(-)
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -214,6 +214,25 @@ struct event_function_struct {
> >         void *data;
> >  };
> >
> > +typedef struct {
> > +       struct perf_cpu_context *cpuctx;
> > +       struct perf_event_context *ctx;
> > +} class_perf_ctx_lock_t;
> > +
> > +static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
> > +{
> > +       if (_T->cpuctx)
> > +               perf_ctx_unlock(_T->cpuctx, _T->ctx);
> 
> Shouldn't it be called unconditionally?

In all surviving cases it will be, so yeah, I can remove that condition.
