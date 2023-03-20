Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A486C1BB4
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjCTQcO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCTQbn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 12:31:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893027ABD;
        Mon, 20 Mar 2023 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679329484; x=1710865484;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YkPKy6HrZ89gUO3WdmC9FV2zbtAO4V6xBqAXDdNHMg4=;
  b=aSURlZ8ssUI/oMIV/oQjjYUX2A8u5/25sDkAJsx7Z4BoNtWs5gAm5Hdg
   f2Bm3uR9cd/lC8eSDO6kCabeGVhNUpdFBIelsxhWX3lPb9I5ErlEumOpp
   bR1rNKh72L/qRkPP3dHY6B82iczpT9vA3bR/El1EuHY5RlWCZ8ot7jiZ5
   5rsh3On8pJDvVe6UyGaQe+Y6L9RsQBGzd2EclvtVsqsUsHIrsTXRmD0Ls
   wPUvkH+BkAHm99dxfo1SlPbgdEtIDCIx8WWAa0Zr4uepjzLgXlpsILeS6
   76gvl9HgKyPih++7H5JPU20P8QMSxgVpdHccT4A4Edi/q6dIhd9w+ksy7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="337426871"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="337426871"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="855322397"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="855322397"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:24:43 -0700
Date:   Mon, 20 Mar 2023 09:28:42 -0700
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
Subject: Re: [PATCH v2 5/5] iommu/vt-d: Move PRI handling to IOPF feature
 path
Message-ID: <20230320092842.05287fb1@jacob-builder>
In-Reply-To: <20230309025639.26109-6-baolu.lu@linux.intel.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
        <20230309025639.26109-6-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi BaoLu,

On Thu,  9 Mar 2023 10:56:39 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> PRI is only used for IOPF. With this move, the PCI/PRI feature could be
> controlled by the device driver through iommu_dev_enable/disable_feature()
> interfaces.
This move is good for DMA API PASID as well, it will not turn on PRI when
enabling PASID, ATS cap.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com> 

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 59 ++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index fb64ab8358a9..4ed32bde4287 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1415,11 +1415,6 @@ static void iommu_enable_pci_caps(struct
> device_domain_info *info) if (info->pasid_supported &&
> !pci_enable_pasid(pdev, info->pasid_supported & ~1)) info->pasid_enabled
> = 1; 
> -	if (info->pri_supported &&
> -	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) :
> 1)  &&
> -	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
> -		info->pri_enabled = 1;
> -
>  	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>  	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>  		info->ats_enabled = 1;
> @@ -1442,11 +1437,6 @@ static void iommu_disable_pci_caps(struct
> device_domain_info *info) domain_update_iotlb(info->domain);
>  	}
>  
> -	if (info->pri_enabled) {
> -		pci_disable_pri(pdev);
> -		info->pri_enabled = 0;
> -	}
> -
>  	if (info->pasid_enabled) {
>  		pci_disable_pasid(pdev);
>  		info->pasid_enabled = 0;
> @@ -4664,23 +4654,48 @@ static int intel_iommu_enable_sva(struct device
> *dev) 
>  static int intel_iommu_enable_iopf(struct device *dev)
>  {
> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu;
>  	int ret;
>  
> -	if (!info || !info->ats_enabled || !info->pri_enabled)
> +	if (!pdev || !info || !info->ats_enabled || !info->pri_supported)
>  		return -ENODEV;
> +
> +	if (info->pri_enabled)
> +		return -EBUSY;
> +
>  	iommu = info->iommu;
>  	if (!iommu)
>  		return -EINVAL;
>  
> +	/* PASID is required in PRG Response Message. */
> +	if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev))
> +		return -EINVAL;
> +
> +	ret = pci_reset_pri(pdev);
> +	if (ret)
> +		return ret;
> +
>  	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
>  	if (ret)
>  		return ret;
>  
>  	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf,
> dev); if (ret)
> -		iopf_queue_remove_device(iommu->iopf_queue, dev);
> +		goto iopf_remove_device;
> +
> +	ret = pci_enable_pri(pdev, PRQ_DEPTH);
> +	if (ret)
> +		goto iopf_unregister_handler;
> +	info->pri_enabled = 1;
> +
> +	return 0;
> +
> +iopf_unregister_handler:
> +	iommu_unregister_device_fault_handler(dev);
> +iopf_remove_device:
> +	iopf_queue_remove_device(iommu->iopf_queue, dev);
>  
>  	return ret;
>  }
> @@ -4689,17 +4704,21 @@ static int intel_iommu_disable_iopf(struct device
> *dev) {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu = info->iommu;
> -	int ret;
>  
> -	ret = iommu_unregister_device_fault_handler(dev);
> -	if (ret)
> -		return ret;
> +	if (!info->pri_enabled)
> +		return -EINVAL;
>  
> -	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
> -	if (ret)
> -		iommu_register_device_fault_handler(dev,
> iommu_queue_iopf, dev);
> +	pci_disable_pri(to_pci_dev(dev));
> +	info->pri_enabled = 0;
>  
> -	return ret;
> +	/*
> +	 * With pri_enabled checked, unregistering fault handler and
> +	 * removing device from iopf queue should never fail.
> +	 */
> +	iommu_unregister_device_fault_handler(dev);
> +	iopf_queue_remove_device(iommu->iopf_queue, dev);
> +
> +	return 0;
>  }
>  
>  static int


Thanks,

Jacob
