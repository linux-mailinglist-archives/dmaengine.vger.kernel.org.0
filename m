Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AC96CC91F
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjC1RVs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjC1RVr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 13:21:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F21DBD7;
        Tue, 28 Mar 2023 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680024098; x=1711560098;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0TfcPjksoLAS4Lgr8pbWYVIORpk7kQ3431tuOunQDOM=;
  b=c1LlDWWVA7LveZDO81c2JJSKTHfs0ULzF3DqcItXafz0qlXUc3sMZ6OK
   NDsIusPtHlgemaW4UTVRNE/7mxM48BQ2wbZNuqPKoptum1Ji9V1ldSfxF
   5oVkfdIDKFu11CE94H/Ts8f1n7oHhM8jysPDdHNi1/3oCSlQq6iOS7w/l
   /xfhcHBA1EdLzgl2AHLY4Q0Ussfmu+xaOOH5mzraFTZuSrhO66Syj+BRI
   +LjnEDkoCG+GASpvAj3L3nBDp3Kicm8uQ+8FH/99Gz2ZnLk3haVTweoom
   JQKjQlGqwYIZ1HdC/lNWmI4frLZzGv+fxGKMCeWmxWk54CXHR8rfjwm2C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320289000"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="320289000"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 10:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="714333438"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="714333438"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 10:21:36 -0700
Date:   Tue, 28 Mar 2023 10:25:40 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Message-ID: <20230328102540.6158e642@jacob-builder>
In-Reply-To: <ZCMTf5RwebmELsoT@nvidia.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
        <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
        <BN9PR11MB527623AC2CE25EDA10FF81548C889@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230328084822.4b46e649@jacob-builder>
        <ZCMTf5RwebmELsoT@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Tue, 28 Mar 2023 13:19:11 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 28, 2023 at 08:48:22AM -0700, Jacob Pan wrote:
> 
> > > Agree. The kernel driver managing the device wants to get the current 
> > > domain of the device then iommu_get_domain_for_dev() is the right
> > > interface. It knows the domain is the dma domain.  
> > This goes back to v1 then :)
> > 
> > I thought the comments from v1 is that we don't want to check the domain
> > type is DMA domain returned by iommu_get_domain_for_dev()
> > 
> > If the driver "knows" the domain is dma domain, why can't it use
> > iommu_get_dma_domain()? seems paradoxical.  
> 
> Huh?
> 
> The DMA API operates on the current domain of the device, be it
> IDENTITY or UNMANAGED.
> 
> You have to copy whatever the current domain is to the PASID and you
> should definately not check if it is DMA or something.
> 
right, the PASID works for IOVA, passthrough. I misunderstood the v1
review comments. I will go back to use iommu_get_domain_for_dev() but w/o
checking domain types.

Thanks all,

Jacob
