Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E2072C90F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbjFLO6P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjFLO6O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 10:58:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07ABC;
        Mon, 12 Jun 2023 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rk8v+7kKodlj+QyW1PLHimqi/kwmEy+ooh8DhXxGMfo=; b=cCetaJ92daXjWoUXGnXBaLp3G6
        bfsOQ1OWAcEFEJY4ZyCfhLwYZhNtlBf2Q7eU5R0SwM+OVsv5Js6EZajuBVSOtdg3OzxRcoS0/pGsK
        rN7uHzgtVMTdhoztYnTdwDjksS6LY2Ug0o+8ErBQnX4BinayqXaLoz+MIZ1p7Jz65BjQUB0b64sQh
        978qcWTKz5Hquf/2s6rk6wXFOCc8XdIjjElQn1T2wzOthUodNWdIl8tRw3zq0t2uDPSB0mVxHdHIA
        ElLTgPNN/1E14vY/pxD9iJDXzQ39Ifc3ndqahbL/6RYEzca06s/q4F2o0fBvtbMq60B9iaqPCEw+M
        f7IMNJiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8ize-008uDO-1L;
        Mon, 12 Jun 2023 14:58:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE33330058D;
        Mon, 12 Jun 2023 16:58:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC3B821F7F9D1; Mon, 12 Jun 2023 16:58:05 +0200 (CEST)
Date:   Mon, 12 Jun 2023 16:58:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
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
Subject: Re: [PATCH v3 26/57] perf: Simplify event_function*()
Message-ID: <20230612145805.GD83892@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093539.371360635@infradead.org>
 <1cbdae4a-d6ad-4dd8-aa75-9e226c4416fe@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbdae4a-d6ad-4dd8-aa75-9e226c4416fe@kadam.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 05:46:47PM +0300, Dan Carpenter wrote:
> On Mon, Jun 12, 2023 at 11:07:39AM +0200, Peter Zijlstra wrote:
> > @@ -224,17 +243,15 @@ static int event_function(void *info)
> >  	int ret = 0;
> >  
> >  	lockdep_assert_irqs_disabled();
> > +	guard(perf_ctx_lock)(cpuctx, task_ctx);
> >  
> > -	perf_ctx_lock(cpuctx, task_ctx);
> >  	/*
> >  	 * Since we do the IPI call without holding ctx->lock things can have
> >  	 * changed, double check we hit the task we set out to hit.
> >  	 */
> >  	if (ctx->task) {
> > -		if (ctx->task != current) {
> > -			ret = -ESRCH;
> > -			goto unlock;
> > -		}
> > +		if (ctx->task != current)
> > +			return -ESRCH;
> >  
> >  		/*
> >  		 * We only use event_function_call() on established contexts,
> > @@ -254,8 +271,6 @@ static int event_function(void *info)
> >  	}
> >  
> >  	efs->func(event, cpuctx, ctx, efs->data);
> > -unlock:
> > -	perf_ctx_unlock(cpuctx, task_ctx);
> >  
> >  	return ret;
> 
> 
> We can change this to a return 0; and get rid of the "ret" variable.

This and the previous one, done!
