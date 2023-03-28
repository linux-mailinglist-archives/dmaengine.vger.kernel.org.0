Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839326CC63E
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjC1P2e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjC1P2Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:28:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1110401;
        Tue, 28 Mar 2023 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680017231; x=1711553231;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9pUw4qfwnuIM9w2+fwl4/XvGsd+TBbX0140QHxhWmfQ=;
  b=Gjil830HTLb4r61sOEWD6eeXX+aU+oQFwgLKNRuuwc6PZEh56tkx/fDJ
   6FXyRpLSmhwBBvlN8rep5UEk9XmzmxO+EB2nLo8oo9oYzQV5CAbAW4Cmt
   ZPNqPm32F0cdCUMeRd1SpnPwgVG/DBgdQGXXs09+JdXEDUqm2//tkEwEU
   1Kwk/KhfSWOW4tTBL7EM96pLn2z8FgZ4dxieIMxVK4f0SqKpn9iCBg0Zl
   lktS2DtDPgk8POK2Pqc1ZRvicc8GUHcKj/eep3uVfqImQvCxXwvjMUVu9
   g4WgnRL87PFBB0/mD79wFUqVZV1DUUQ8P4f93w6Ldmj50U9ZOQ6ehbcWm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="426869774"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="426869774"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683944706"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683944706"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:27:07 -0700
Date:   Tue, 28 Mar 2023 08:31:10 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA
 PASIDs
Message-ID: <20230328083110.294a327c@jacob-builder>
In-Reply-To: <BN9PR11MB527652D88D15437F52FCE8268C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB527652D88D15437F52FCE8268C889@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On Tue, 28 Mar 2023 07:35:43 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 28, 2023 7:22 AM
> > 
> > +/**
> > + * @brief
> > + *	Reserve a PASID from the SVA global number space.
> > + *
> > + * @param min starting range, inclusive
> > + * @param max ending range, inclusive
> > + * @return The reserved PASID on success or IOMMU_PASID_INVALID on
> > failure.
> > + */
> > +ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
> > +{
> > +	int ret;
> > +
> > +	if (!pasid_valid(min) || !pasid_valid(max) ||
> > +	    min == 0 || max < min)
> > +		return IOMMU_PASID_INVALID;
> > +
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_KERNEL);
> > +	if (ret < 0)
> > +		return IOMMU_PASID_INVALID;
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_reserve_pasid);
> > +  
> 
> Look at this function. There is no single word about sva except
> in the function name.
> 
> sva is just one user of global pasids.
> 
> when a driver supports sva it has to always use global pasids even
> for non-sva usages like dma pasid.
> 
> but this doesn't mean that we should build the API around sva.
> 
> it's really about global pasids.
> 
> let's just call it clearly as iommu_alloc_global_pasid(min, max).
> 
> Then we can define a wrapper iommu_reserve_global_pasid(pasid)
> as iommu_alloc_global_pasid(pasid, pasid).
> 
> for PASID#0 driver calls iommu_reserve_global_pasid(0).
> 
> for dma pasid driver calls iommu_alloc_global_pasid() to get a random
> one instead of reserving pasid#1.
> 
> this would be future proof when the same driver starts to allocate
> more pasids for other usages e..g siov.
I don't have strong preference here. Jason and others?

For the DMA vs. SVA use cases, these APIs are used to carve out PASIDs from
the SVA space. Let it be the entire global space or a subset, we don't care.
We just don't want conflicts with SVA. e.g. if the SVA space shrank in the
future, this still works.

Thanks,

Jacob
