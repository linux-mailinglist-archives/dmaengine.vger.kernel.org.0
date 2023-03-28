Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90726CC702
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjC1Pqt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjC1Pqb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:46:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E76D311;
        Tue, 28 Mar 2023 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018366; x=1711554366;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aANfklT01Q50VoPynu4eI92dQQpk9aNu69RWvGsHYk8=;
  b=H4c7xOuG90nCeD10p/p27A5IteIcRDsaZIhTC2YQKwca+3jR1KRlUraC
   Z3JCKP+Vo0R9uZ2qqGakgjjkBFDglsXESewg78V5F7ZL7EbJsygkv9STx
   +dM3Li2I3eGR7/ZSsXjZ+Mof/fseTTa38DQlM1w9rrlU2RMcpjI6akW8q
   LK1Ggh4LM5unxEZCLqRGElPNuQpEvtXDj6zoworBWbnuiEOH5zQ7gYBzC
   KAhGrmxyAeLHdegLEG5gcHfHJ6TJAJAuMm01WOa/DpfbfW+jS36vK90Lv
   rYOzCh5XejH6o/2EeTkUBlH47AwO7T8P8Gpp2fS9JbLdMfnMmaynov7UC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="368365970"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="368365970"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="753195774"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="753195774"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:44:52 -0700
Date:   Tue, 28 Mar 2023 08:48:55 -0700
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
Subject: Re: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Message-ID: <20230328084855.7b9cd981@jacob-builder>
In-Reply-To: <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
        <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Tue, 28 Mar 2023 14:04:15 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/28/23 7:21 AM, Jacob Pan wrote:
> > Devices that use ENQCMDS to submit work needs to retrieve its DMA
> > domain. It can then attach PASID to the DMA domain for shared mapping
> > (with RID) established by DMA API.
> > 
> > Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/iommu.c | 1 +
> >   include/linux/iommu.h | 5 +++++
> >   2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 10db680acaed..c51d343a75d2 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2118,6 +2118,7 @@ struct iommu_domain *iommu_get_dma_domain(struct
> > device *dev) {
> >   	return dev->iommu_group->default_domain;
> >   }
> > +EXPORT_SYMBOL_GPL(iommu_get_dma_domain);  
> 
> Directly exporting this function for external use seems unsafe. If the
> caller is the kernel driver for this device, it's fine because default
> domain remains unchanged during the life cycle of the driver. Otherwise,
> using this function may cause UAF. Keep in mind that group's default
> domain could be changed through sysfs.
don't you have to unload the driver? 

> However, iommu_get_domain_for_dev() has already done so and has been
> exported. Maybe I'm worried too much. :-)
> 
> Best regards,
> baolu


Thanks,

Jacob
