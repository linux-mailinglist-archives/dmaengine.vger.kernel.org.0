Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DFA72BE85
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjFLKOR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 06:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjFLKNz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 06:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C104C0D;
        Mon, 12 Jun 2023 02:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D69060FE3;
        Mon, 12 Jun 2023 09:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E97C433EF;
        Mon, 12 Jun 2023 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686563725;
        bh=uoES/gxKY7cWcXBfxNoMev6F6cyb81VBK5AgiR+dmqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agD/+CTYcvklPbL0Mz3mXe8+VTOZK358bIssnktx6csyZChgEWI2AjjuLJEtkOtn8
         LV0kIpavT31IhjDHX1/k0yQPJsTz487pd1iqKmk/nTEss5sKBBSMgeFrExnv49f+p3
         0PfciCytn3CzOQsGntyu3TyLTmxjb9ZxgsUSORg0=
Date:   Mon, 12 Jun 2023 11:55:22 +0200
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
Message-ID: <2023061255-comma-crummy-398e@gregkh>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
 <20230612094400.GG4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612094400.GG4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Yes, there should be, let me look into it later tonight, need to get
some stable kernels out for review first...

thanks,

greg k-h
