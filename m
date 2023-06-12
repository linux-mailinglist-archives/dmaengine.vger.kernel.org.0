Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051F272C58B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 15:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjFLNJP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 09:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjFLNJO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 09:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D632B1;
        Mon, 12 Jun 2023 06:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D1F6177E;
        Mon, 12 Jun 2023 13:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C71CC433D2;
        Mon, 12 Jun 2023 13:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686575352;
        bh=kldEhr7D9gJHwst5fMBjWYAaKUy32U9RV5cywHwgxlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdjhOYZMZJPCGheaijLgPAgt3eC9enaqsE7t65R1YDtP6Ms2znOV/5aJ02XMt0RLk
         KnhRTNlo/+vuYbd13rDF/4B522ytFAqedbWr4nmMnk8kIrci17kB987+kIxNeZ00AI
         +6OVXQ3oNt1iNrvJoTGsTlKs3p9FPWXIKV3TIZdA=
Date:   Mon, 12 Jun 2023 15:09:09 +0200
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
Message-ID: <2023061204-decal-flyable-6090@gregkh>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
 <20230612094400.GG4253@hirez.programming.kicks-ass.net>
 <2023061213-knapsack-moonlike-e595@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061213-knapsack-moonlike-e595@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 02:18:03PM +0200, Greg KH wrote:
> On Mon, Jun 12, 2023 at 11:44:00AM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 12, 2023 at 11:07:59AM +0200, Peter Zijlstra wrote:
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/events/core.c |   65 ++++++++++++++++++++++++---------------------------
> > >  1 file changed, 31 insertions(+), 34 deletions(-)
> > > 
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -11285,49 +11285,46 @@ static void pmu_dev_release(struct devic
> > >  
> > >  static int pmu_dev_alloc(struct pmu *pmu)
> > >  {
> > > +	int ret;
> > >  
> > > +	struct device *dev __free(put_device) =
> > > +		kzalloc(sizeof(struct device), GFP_KERNEL);
> > > +	if (!dev)
> > > +		return -ENOMEM;
> > >  
> > > +	dev->groups = pmu->attr_groups;
> > > +	device_initialize(dev);
> > >  
> > > +	dev_set_drvdata(dev, pmu);
> > > +	dev->bus = &pmu_bus;
> > > +	dev->release = pmu_dev_release;
> > >  
> > > +	ret = dev_set_name(dev, "%s", pmu->name);
> > >  	if (ret)
> > > +		return ret;
> > >  
> > > +	ret = device_add(dev);
> > >  	if (ret)
> > > +		return ret;
> > >  
> > > +	struct device *del __free(device_del) = dev;
> > 
> > Greg, I'm not much familiar with the whole device model, but it seems
> > unfortunate to me that one has to call device_del() explicitly if we
> > already have a put_device() queued.
> > 
> > Is there a saner way to write this?
> 
> Ok, the "problem" here is that you have decided to do the "complex" way
> to initialize a struct device.  And as such, you have to do more
> housekeeping than if you were to just use the simple interface.
> 
> The rule is, after you call device_initialize() you HAVE to call
> put_device() on the pointer if something goes wrong and you want to
> clean up properly.  Unless you have called device_add(), and at that
> point in time, then you HAVE to call device_del() if the device_add()
> call succeeded.  If the device_add() call failed, then you HAVE to call
> put_device().
> 
> Yeah, it's a pain, but you are trying to hand-roll code that is not a
> "normal" path for a struct device, sorry.
> 
> I don't know if you really can encode all of that crazy logic in the
> cleanup api, UNLESS you can "switch" the cleanup function at a point in
> time (i.e. after device_add() is successful).  Is that possible?
> 
> Anyway, let me see about just cleaning up this code in general, I don't
> think you need the complex interface here for a tiny struct device at
> all, which would make this specific instance moot :)
> 
> Also, nit, you are racing with userspace by attempting to add new device
> files _AFTER_ the device is registered with the driver core, this whole
> thing can be made more simpler I hope, give me a bit...

Nope, I was wrong, I can fix the race condition, but the logic here for
how to init and clean up on errors is right, and you want this because
you are a bus and so, you need the two-step init/teardown process,
sorry.

Here's the patch I came up with to get rid of the race, but doesn't
really help you out here at all :(

------------------------
From foo@baz Mon Jun 12 03:07:54 PM CEST 2023
Date: Mon, 12 Jun 2023 15:07:54 +0200
To: Greg KH <gregkh@linuxfoundation.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] perf/core: fix narrow startup race when creating the perf nr_addr_filters sysfs file


Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


diff --git a/kernel/events/core.c b/kernel/events/core.c
index db016e418931..d2a6182ad090 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11351,9 +11351,32 @@ static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
 static struct attribute *pmu_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_perf_event_mux_interval_ms.attr,
+	&dev_attr_nr_addr_filters.attr,
+	NULL,
+};
+
+static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	if (!pmu->nr_addr_filters)
+		return 0;
+
+	return a->mode;
+
+	return 0;
+}
+
+static struct attribute_group pmu_dev_attr_group = {
+	.is_visible = pmu_dev_is_visible,
+	.attrs = pmu_dev_attrs,
+};
+
+const static struct attribute_group *pmu_dev_groups[] = {
+	&pmu_dev_attr_group,
 	NULL,
 };
-ATTRIBUTE_GROUPS(pmu_dev);
 
 static int pmu_bus_running;
 static struct bus_type pmu_bus = {
@@ -11389,18 +11412,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto free_dev;
 
-	/* For PMUs with address filters, throw in an extra attribute: */
-	if (pmu->nr_addr_filters)
-		ret = device_create_file(pmu->dev, &dev_attr_nr_addr_filters);
-
-	if (ret)
-		goto del_dev;
-
-	if (pmu->attr_update)
+	if (pmu->attr_update) {
 		ret = sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
-
-	if (ret)
-		goto del_dev;
+		if (ret)
+			goto del_dev;
+	}
 
 out:
 	return ret;
