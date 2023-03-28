Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B7A6CC7DE
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjC1QZ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjC1QZ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 12:25:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A7DEB53;
        Tue, 28 Mar 2023 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680020718; x=1711556718;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SaaqVoGJRHXzDcbDSy0ZzDlNvUMy2t3he0H/VelSyig=;
  b=m9L0G9MENhIhqWuh2df/RxByIdiHKS7pqU1e5/K2LuhjuUdmAArP1iHh
   uBeCNynZwznsw5CIFGND5mXuSrnh7bBMCLFEWtdx4vTK74kXct5jyLjF3
   FQN5VS4E6JN0a5XMqK+9uk/OtWW0vLjF0RedR0zR8Ky7DhaZw9gfC6QKM
   I+ywoHs53vE2gOCHb0fCgo/SKfwOHRUNtmu6om5IiZ/MRXz5oGbZTwSZ3
   keWXG+zE3qLFaCQdWRKr+8NuEtoU+MlZ/NAFrQQE8Xcx8g+otSKvPzCrs
   HHNC50v6CbrYLBekfx3kbjo0VdNxHaeEbusHp2Mw8xhcFAIzIIIS0BLRD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321018544"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="321018544"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773198759"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="773198759"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:25:16 -0700
Date:   Tue, 28 Mar 2023 09:29:19 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 4/8] iommu/vt-d: Reserve RID_PASID from global SVA
 PASID space
Message-ID: <20230328092919.372f0545@jacob-builder>
In-Reply-To: <41d31adf-577e-431c-c400-2708885400c1@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
        <41d31adf-577e-431c-c400-2708885400c1@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Tue, 28 Mar 2023 13:20:19 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/28/23 7:21 AM, Jacob Pan wrote:
> > On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> > should not treat RID_PASID special instead let it be allocated from the
> > global SVA PASID number space.  
> 
> It's same to AMD and ARM SMMUv3, right? They also need an explicit
> reservation of PASID 0.
> 
yes, all IOMMU drivers need to do that. I will give it a try but might need
help to place the call.

> > 
> > Consequently, for devices also do DMA with PASID, drivers will not worry
> > about conflicts when it comes to allocating PASIDs for in-kernel DMA.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 9f737ef55463..61c06f7ad8f7 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
> >   
> >   	intel_iommu_enabled = 1;
> >   
> > +#ifdef CONFIG_INTEL_IOMMU_SVM  
> 
> Do we really need this #ifdef? IOMMU_SVA is selected by INTEL_IOMMU_SVM,
> right? So if CONFIG_INTEL_IOMMU_SVM is not set,
> iommu_sva_reserve_pasid() is just a dumb.
> 
good catch! will remove

> > +	/* Reserved RID_PASID from the global namespace for legacy DMA
> > */
> > +	iommu_sva_reserve_pasid(PASID_RID2PASID, PASID_RID2PASID);
> > +#endif
> >   	return 0;
> >   
> >   out_free_dmar:  
> 
> Best regards,
> baolu


Thanks,

Jacob
