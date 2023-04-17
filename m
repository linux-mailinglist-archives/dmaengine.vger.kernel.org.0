Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA46E4E57
	for <lists+dmaengine@lfdr.de>; Mon, 17 Apr 2023 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjDQQc5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQQc5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 12:32:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C3E8A59;
        Mon, 17 Apr 2023 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681749166; x=1713285166;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84P+ue7q6gbeMc23HNjLrNIJ593kLc/rbC2QengU/0w=;
  b=I8BTeAfuoa1UWOKrlAiWUdnve0Kx2dDoejx955Z450R6Y40g9VoHTamU
   ndAL+afjMXnnnEOO9Ly+54aLqhL69po1WsXhQlegwgtIrd18PJ+BYXQuv
   TkviWwj2za4jLS6MXUIOWoK2/RmDMnatKtcc/h22mp1IOztO1Wx8vfzDx
   R0MGjZ/pN8fxE0G9LjwBxUaqGH06hidtcCqmkdDk3SRzmf3PBpK8HQ2d0
   LEaxloOtoPBH6GOdhkAmXGcNsCboTNlF8zbGmyey3FWG6EXmuGqSaw09j
   6QFQdTVmkEJBcgJigF9naFt2A+j2MmC8PTGI3P/hLzAwOrIpu52mys5LG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="347680876"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="347680876"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="640987912"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="640987912"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:32:46 -0700
Date:   Mon, 17 Apr 2023 09:36:59 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Reserve RID_PASID from global PASID
 space
Message-ID: <20230417093659.653d81e9@jacob-builder>
In-Reply-To: <c8373d68-9f15-e9a5-d19f-c050f23ac85d@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
        <20230407180554.2784285-5-jacob.jun.pan@linux.intel.com>
        <c8373d68-9f15-e9a5-d19f-c050f23ac85d@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Mon, 10 Apr 2023 09:59:45 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/8/23 2:05 AM, Jacob Pan wrote:
> > On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> > should not treat RID_PASID special instead let it be allocated from the
> > global PASID number space. Non-zero value can be used in RID_PASID on
> > Intel VT-d.
> > 
> > For ARM, AMD and others that_always_  use 0 as RID_PASID, there is no
> > impact in that SVA PASID allocation base is 1.
> > 
> > With this change, devices do both DMA with PASID and SVA will not worry
> > about conflicts when it comes to allocating PASIDs for in-kernel DMA.
> > 
> > Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 9f737ef55463..cbb2670f88ca 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
> >   
> >   	intel_iommu_enabled = 1;
> >   
> > +	/* Reserved RID_PASID from the global namespace for legacy DMA
> > */
> > +	WARN_ON(iommu_alloc_global_pasid(PASID_RID2PASID,
> > PASID_RID2PASID) !=
> > +		PASID_RID2PASID);  
> 
> How about moving above line up a bit? For example, at least before
> iommu_device_register(). This is the starting point where device drivers
> may want global PASIDs.
> 
makes sense will do.

Thanks,

Jacob
