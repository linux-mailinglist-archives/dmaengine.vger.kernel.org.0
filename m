Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98B55AC33
	for <lists+dmaengine@lfdr.de>; Sat, 25 Jun 2022 21:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiFYTwL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Jun 2022 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiFYTwK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Jun 2022 15:52:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80FC12D2F
        for <dmaengine@vger.kernel.org>; Sat, 25 Jun 2022 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656186727; x=1687722727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=47Jqfx1NohYaYKLginO4ikhq1M0z7eg6k0Svy4OXQro=;
  b=JSWz8dcyBNHN9Ar6WuoeCIy1bsSLT5gj0AeYDhE2RWY9cXNs4/iD/Ucs
   7vtV3cqZYkFlk1ka6in8XsCmTCstLDQt3cEO6AoaGLBHGpPSM+zahqMHa
   SXjZ4ki8rn5lZji9amEmWZMqIZrKPHIz35D9DzvhteOwnWAYlJpw8XdY6
   TH/5luwrW2a/jWuK/xK8Z23riwjX8as+/34nEjj6ChzKwYW2hosFOa6uJ
   ieLT383d63rAvOCS33CstrFrtfAfJw1NMif/14V2Ow02pfLHGdRhicvB0
   2s6gf7S02YTvQkJsbYBg/Ebd+segxdDz6ZE2gT6zGV3I2TiMEOz4q/Eu4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="306685400"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="306685400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 12:52:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="678991598"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 12:52:07 -0700
Date:   Sat, 25 Jun 2022 12:52:27 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
Subject: Re: iommu_sva_bind_device question
Message-ID: <Yrdne20Eq+5KwF5h@fyu1.sc.intel.com>
References: <20220623170232.6whonfjuh3m5vcoy@cantor>
 <6639b21c-1544-a025-4da5-219a1608f06e@linux.intel.com>
 <20220624011446.2bexm4sjo2vabay5@cantor>
 <552074ff-fd32-8cdb-cc10-1d71319c71db@linux.intel.com>
 <20220624134102.qxid72gqghjhyozn@cantor>
 <20220624144730.a6ork4dbjixnfhbf@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624144730.a6ork4dbjixnfhbf@cantor>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Jerry and Baolu,

On Fri, Jun 24, 2022 at 07:47:30AM -0700, Jerry Snitselaar wrote:
> > > > > > Hi Baolu & Dave,
> > > > fails.
> > > > 
> > > > You also will get the following warning if you don't have scalable
> > > > mode enabled (either not enabled by default, or if enabled by default
> > > > and passed intel_iommu=on,sm_off):
> > > 
> > > If scalable mode is disabled, iommu_dev_enable_feature(IOMMU_SVA) will
> > > return failure, hence driver should not call iommu_sva_bind_device().
> > > I guess below will disappear if above is fixed in the idxd driver.

Yes, Jerry's patch fixes the WARNING as well.

> > > 
> > > Best regards,
> > > baolu
> > >
> > 
> > It looks like there was a recent maintainer change, and Fenghua is now
> > the maintainer. Fenghua thoughts on this? With 42a1b73852c4
> > ("dmaengine: idxd: Separate user and kernel pasid enabling") the code
> > no longer depends on iommu_dev_feature_enable succeeding. Testing with
> > something like this works (ran dmatest without sm_on, and
> > dsa_user_test_runner.sh with sm_on, plus booting with various
> > intel_iommu= combinations):
> > 
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index 355fb3ef4cbf..5b49fd5c1e25 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -514,13 +514,14 @@ static int idxd_probe(struct idxd_device *idxd)
> >         if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> >                 if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
> >                         dev_warn(dev, "Unable to turn on user SVA feature.\n");
> > -               else
> > +               else {
> >                         set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> > 
> > -               if (idxd_enable_system_pasid(idxd))

Please add "{" after this if.

> > -                       dev_warn(dev, "No in-kernel DMA with PASID.\n");
> > -               else
then "}" before this else.

> > -                       set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > +                       if (idxd_enable_system_pasid(idxd))
> > +                               dev_warn(dev, "No in-kernel DMA with PASID.\n");
> > +                       else
> > +                               set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > +               }
> >         } else if (!sva) {
> >                 dev_warn(dev, "User forced SVA off via module param.\n");
> >         }

The patch was copied/pasted here. So the tabs are lost at beginning of each
line. So it cannot be applied. Please change the tabs back.

Could you please send this patch in a separate email so that it has a
right patch format and description and ready to be picked up?

> > 
> > The commit description is a bit confusing, because it talks about there
> > being no dependency, but ties user pasid to enabling/disabling the SVA
> > feature, which system pasid would depend on as well.
> > 
> > Regards,
> > Jerry
> 
> Things like that warning message "Unable to turn on user SVA feature" when
> iommu_dev_enable_feature fails though seems to be misleading with user
> inserted in there. I'll leave it to the idxd folks to figure out.

How about removing "user" from the warning message? So the message will
be "Unable to turn on SVA feature"?

Thanks.

-Fenghua
