Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE872C619
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 15:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjFLNgX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 09:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjFLNgQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 09:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0E107;
        Mon, 12 Jun 2023 06:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 780246219F;
        Mon, 12 Jun 2023 13:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F29C433EF;
        Mon, 12 Jun 2023 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686576952;
        bh=dbjfLeRVVirIIBHlnay6kcWtyYVF/I6R+13hE9mByOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOMIAVxt+cyHIvr19eAJhFqIonbIYoOBgtK0PmpiwwErwzHNjg53T2EvRBWUWnN7Y
         nw4LRWpOsOib5ObTNG02xKUCB4SJjBlz9gROxWbPJnHEBkHtn3pWdU4rVzf8RkD/BJ
         a2zbuugsDFWGViql8PldWWeDryGp/ZpEBo9/RFC0=
Date:   Mon, 12 Jun 2023 15:35:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <2023061226-grumpily-entire-f06a@gregkh>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
 <20230612094400.GG4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612094400.GG4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 11:44:00AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 12, 2023 at 11:07:59AM +0200, Peter Zijlstra wrote:
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/events/core.c |   65 ++++++++++++++++++++++++---------------------------
> >  1 file changed, 31 insertions(+), 34 deletions(-)
> > 
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11285,49 +11285,46 @@ static void pmu_dev_release(struct devic
> >  
> >  static int pmu_dev_alloc(struct pmu *pmu)
> >  {
> > +	int ret;
> >  
> > +	struct device *dev __free(put_device) =
> > +		kzalloc(sizeof(struct device), GFP_KERNEL);
> > +	if (!dev)
> > +		return -ENOMEM;
> >  
> > +	dev->groups = pmu->attr_groups;
> > +	device_initialize(dev);
> >  
> > +	dev_set_drvdata(dev, pmu);
> > +	dev->bus = &pmu_bus;
> > +	dev->release = pmu_dev_release;
> >  
> > +	ret = dev_set_name(dev, "%s", pmu->name);
> >  	if (ret)
> > +		return ret;
> >  
> > +	ret = device_add(dev);
> >  	if (ret)
> > +		return ret;
> >  
> > +	struct device *del __free(device_del) = dev;
> 
> Greg, I'm not much familiar with the whole device model, but it seems
> unfortunate to me that one has to call device_del() explicitly if we
> already have a put_device() queued.
> 
> Is there a saner way to write this?

Ok, to answer my other question, yes, you are changing the free call
here in the "middle" of the function, sorry, I missed "del" vs. "dev"
and was wondering how this would work...

This should work, it's tricky, especially:

> > +	no_free_ptr(del);
> > +	pmu->dev = no_free_ptr(dev);

this.

I had to stare at it for a while to realize that yes, you are calling
the two different "cleanup" functions prior to thes lines, on the same
pointer, and that the order is correct.

Ick, this is going to be a rough audit for bus code that gets converted
to this, BUT bonus is that once it's done, any changes to the middle of
the function should "just work", and it's a good task for an intern to
do :)


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Mind if I try this series to convert a more "normal" driver to see how
it works with that?  That's going to be the true test, see if the
changes make sense to someone who doesn't really know the internals of
the driver core like this...

thanks,

greg k-h
