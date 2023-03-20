Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101BF6C1B2A
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCTQUF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjCTQTg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 12:19:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2230C4;
        Mon, 20 Mar 2023 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679328658; x=1710864658;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KIjFZ6/taO8KY+JO3vybOuikqks1nhOIhIEiBvcrbJg=;
  b=lp4khKL+X+JNHgh3QuXKBMIop15flP3Zc00Ydku8RhY8j9VJIgevd9sS
   U7v8S7iZrV704S2wyG2WhvR5/XdE7oJ6B3vHGs4P3iEkCirshoLwSmaMB
   lEte61JUFt4erizbScnEHrCEMZoipb0reiA+G1Vxxx6t9u98OANg+WOhG
   hrAH/CELTkjqYDHz/9/aeZ1SUcNQWGBvcBY6ENVnonU2WtPb/X9lPWoLf
   YMPwd+r5N8BW5/4OwLsko7tBmhAMG4d/SJWTjiaY6AxoYpocirIh6udQc
   NfjLvgFFb53N9/ZkLBqjy8wGgNGLEyy5DsWbt4TMclVKXbjgUANQ14Xtk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366423396"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="366423396"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713630339"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="713630339"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:07:29 -0700
Date:   Mon, 20 Mar 2023 09:11:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 4/5] iommu/vt-d: Move pfsid and ats_qdep calculation
 to device probe path
Message-ID: <20230320091127.63dec1fa@jacob-builder>
In-Reply-To: <20230309025639.26109-5-baolu.lu@linux.intel.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
        <20230309025639.26109-5-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi BaoLu,

On Thu,  9 Mar 2023 10:56:38 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> They should be part of the per-device iommu private data initialization.
> 
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9ada12bf38dd..fb64ab8358a9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1406,20 +1406,6 @@ static void iommu_enable_pci_caps(struct
> device_domain_info *info) return;
>  
>  	pdev = to_pci_dev(info->dev);
> -	/* For IOMMU that supports device IOTLB throttling (DIT), we
> assign
> -	 * PFSID to the invalidation desc of a VF such that IOMMU HW can
> gauge
> -	 * queue depth at PF level. If DIT is not set, PFSID will be
> treated as
> -	 * reserved, which should be set to 0.
> -	 */
> -	if (!ecap_dit(info->iommu->ecap))
> -		info->pfsid = 0;
> -	else {
> -		struct pci_dev *pf_pdev;
> -
> -		/* pdev will be returned if device is not a vf */
> -		pf_pdev = pci_physfn(pdev);
> -		info->pfsid = pci_dev_id(pf_pdev);
> -	}
>  
>  	/* The PCIe spec, in its wisdom, declares that the behaviour of
>  	   the device if you enable PASID support after ATS support is
> @@ -1438,7 +1424,6 @@ static void iommu_enable_pci_caps(struct
> device_domain_info *info) !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>  		info->ats_enabled = 1;
>  		domain_update_iotlb(info->domain);
> -		info->ats_qdep = pci_ats_queue_depth(pdev);
>  	}
>  }
>  
> @@ -4521,6 +4506,17 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev) dmar_ats_supported(pdev,
> iommu)) { info->ats_supported = 1;
>  			info->dtlb_extra_inval =
> dev_needs_extra_dtlb_flush(pdev); +
> +			/*
> +			 * For IOMMU that supports device IOTLB
> throttling
> +			 * (DIT), we assign PFSID to the invalidation
> desc
> +			 * of a VF such that IOMMU HW can gauge queue
> depth
> +			 * at PF level. If DIT is not set, PFSID will be
> +			 * treated as reserved, which should be set to 0.
> +			 */
> +			if (ecap_dit(iommu->ecap))
> +				info->pfsid =
> pci_dev_id(pci_physfn(pdev));
> +			info->ats_qdep = pci_ats_queue_depth(pdev);
>  		}
>  		if (sm_supported(iommu)) {
>  			if (pasid_supported(iommu)) {


Thanks,

Jacob
