Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E789836651A
	for <lists+dmaengine@lfdr.de>; Wed, 21 Apr 2021 08:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhDUGBw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Apr 2021 02:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhDUGBw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Apr 2021 02:01:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5E916100A;
        Wed, 21 Apr 2021 06:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618984879;
        bh=6FjsOQSh7Hi/oGJ9pXqxW8e7eha1gtbPY7bBsDkVCYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbrOLZIwBEowdvqZNySt54+d/jA6eBoYMoWezzqYMJQeB7gUeGy98SzJjQxHHiOKy
         8A1BNVxll3Al3+/QHMnNhRTl6u2OVTbgsPHbfdkxR/K2MG+5kYvK2e0bERtpqApe+2
         u9YNrwBaz64LyWyh0pMI5sdA8Yyqgz9JEMvolKRVv44fCngtdjmuIRR8vTCPCggE+6
         GxUkYfd3BFEBj/6I8Ti/oz7jlZLCfz00LqwwF8NZWYuVp1I777QtnT+5BsYcLuXcni
         W2Cba//Tn0BgfzdOA3kxdSEvGEAEJL3MNGw867p9e44mGNrIDqPrFgK1tA9iDlTN/+
         x1iDRilqReDvA==
Date:   Wed, 21 Apr 2021 11:31:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dmaengine: idxd: Add IDXD performance monitor
 support
Message-ID: <YH+/qyUVtlHwWQJ/@vkoul-mobl.Dlink>
References: <cover.1617467772.git.zanussi@kernel.org>
 <d38a8b3a5d087f1df918fa98627938ef0c898208.1617467772.git.zanussi@kernel.org>
 <YH623ULPRbdi1ker@vkoul-mobl.Dlink>
 <34f61cc9-a6d6-e5a3-5f8c-6ffae8858cce@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f61cc9-a6d6-e5a3-5f8c-6ffae8858cce@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-04-21, 09:13, Zanussi, Tom wrote:
> Hi Vinod,
> 
> On 4/20/2021 6:11 AM, Vinod Koul wrote:
> > On 03-04-21, 11:45, Tom Zanussi wrote:
> > 
> > > +config INTEL_IDXD_PERFMON
> > > +	bool "Intel Data Accelerators performance monitor support"
> > > +	depends on INTEL_IDXD
> > > +	default y
> > 
> > default y..?
> 
> Will change to n.

That is the default, you may drop this line

> 
> > 
> > >   /* IDXD software descriptor */
> > > @@ -369,4 +399,19 @@ int idxd_cdev_get_major(struct idxd_device *idxd);
> > >   int idxd_wq_add_cdev(struct idxd_wq *wq);
> > >   void idxd_wq_del_cdev(struct idxd_wq *wq);
> > > +/* perfmon */
> > > +#ifdef CONFIG_INTEL_IDXD_PERFMON
> > 
> > maybe use IS_ENABLED()

?

> > 
> > > @@ -556,6 +562,8 @@ static int __init idxd_init_module(void)
> > >   	for (i = 0; i < IDXD_TYPE_MAX; i++)
> > >   		idr_init(&idxd_idrs[i]);
> > > +	perfmon_init();
> > > +
> > >   	err = idxd_register_bus_type();
> > >   	if (err < 0)
> > >   		return err;
> > > @@ -589,5 +597,6 @@ static void __exit idxd_exit_module(void)
> > >   	pci_unregister_driver(&idxd_pci_driver);
> > >   	idxd_cdev_remove();
> > >   	idxd_unregister_bus_type();
> > > +	perfmon_exit();
> > 
> > Ideally would make sense to add perfmon module first and then add use in
> > idxd..
> > 
> 
> OK, I'll separate this out into a separate patch.
> 
> > > +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> > > +			    char *buf);
> > > +
> > > +static cpumask_t		perfmon_dsa_cpu_mask;
> > > +static bool			cpuhp_set_up;
> > > +static enum cpuhp_state		cpuhp_slot;
> > > +
> > > +static DEVICE_ATTR_RO(cpumask);
> > 
> > Pls document these new attributes added

?

> > 
> > > +static int perfmon_collect_events(struct idxd_pmu *idxd_pmu,
> > > +				  struct perf_event *leader,
> > > +				  bool dogrp)
> > 
> > dogrp..?
> > 
> 
> Yeah, bad name, first thought on seeing it is always 'dog'. ;-)

Yep, that was my first read as well... i guess it would be better as
do_grp
-- 
~Vinod
