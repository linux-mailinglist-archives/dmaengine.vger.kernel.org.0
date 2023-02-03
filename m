Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2D0689EEA
	for <lists+dmaengine@lfdr.de>; Fri,  3 Feb 2023 17:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjBCQI1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Feb 2023 11:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjBCQIP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Feb 2023 11:08:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2491ABD8;
        Fri,  3 Feb 2023 08:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675440485; x=1706976485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a5pY8S97NNM5t+sjx8sWM1oQ0kSMBPYUOseHtuULdbs=;
  b=HamwTHuO6/3Xhtz6qeGlAorOJV2wNLBeMOX6Vq7lzhgDX14qgIFHxnie
   XE378vTbcaR+O1DqoflTm4tWUq4pgm60zxkvIOlw3K7LzbOOF4cQxizsd
   KKoCIzy6wbzCLsPw9X40K9UdrhUa6NXNjEypRe3TS24UiliVwITC1Lb9A
   lmsjRa8V3CB9VXmFXVyfXSkZDoyO+DsZ9J7MzHpr13XugERRyCfaLzN2h
   f9tlp5l6K3qom/mQuhw4XUhRZQQJn4bmfoA1Re3brcKFf01tZFG4E2LcO
   er3cDbjqjensmgTMy006wuZMKFm2X5FNXMpPuQiyZtSkpr+ABWNql/K3V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="327419198"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="327419198"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 08:08:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="698124991"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="698124991"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.119.40]) ([10.212.119.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 08:08:03 -0800
Message-ID: <f4f377dc-143d-ea93-436f-334390e4c120@intel.com>
Date:   Fri, 3 Feb 2023 09:08:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dmaengine: idxd: Add enable/disable device IOPF
 feature
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        dmaengine@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
References: <20230203084456.469641-1-baolu.lu@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230203084456.469641-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/3/23 1:44 AM, Lu Baolu wrote:
> The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
> and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
> on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
> driver.
> 
> At present, missing IOPF enabling/disabling doesn't cause any real issue,
> because the IOMMU driver places the IOPF enabling/disabling in the path
> of SVA feature handling. But this may change.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/init.c | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 529ea09c9094..d5a709a842a8 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -511,6 +511,27 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
>   	idxd->sva = NULL;
>   }
>   
> +static int idxd_enable_sva(struct pci_dev *pdev)
> +{
> +	int ret;
> +
> +	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> +	if (ret)
> +		return ret;
> +
> +	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
> +	if (ret)
> +		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> +
> +	return ret;
> +}
> +
> +static void idxd_disable_sva(struct pci_dev *pdev)
> +{
> +	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
> +	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> +}
> +
>   static int idxd_probe(struct idxd_device *idxd)
>   {
>   	struct pci_dev *pdev = idxd->pdev;
> @@ -525,7 +546,7 @@ static int idxd_probe(struct idxd_device *idxd)
>   	dev_dbg(dev, "IDXD reset complete\n");
>   
>   	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> -		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA)) {
> +		if (idxd_enable_sva(pdev)) {
>   			dev_warn(dev, "Unable to turn on user SVA feature.\n");
>   		} else {
>   			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> @@ -573,21 +594,19 @@ static int idxd_probe(struct idxd_device *idxd)
>   	if (device_pasid_enabled(idxd))
>   		idxd_disable_system_pasid(idxd);
>   	if (device_user_pasid_enabled(idxd))
> -		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
> +		idxd_disable_sva(pdev);
>   	return rc;
>   }
>   
>   static void idxd_cleanup(struct idxd_device *idxd)
>   {
> -	struct device *dev = &idxd->pdev->dev;
> -
>   	perfmon_pmu_remove(idxd);
>   	idxd_cleanup_interrupts(idxd);
>   	idxd_cleanup_internals(idxd);
>   	if (device_pasid_enabled(idxd))
>   		idxd_disable_system_pasid(idxd);
>   	if (device_user_pasid_enabled(idxd))
> -		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
> +		idxd_disable_sva(idxd->pdev);
>   }
>   
>   static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> @@ -705,7 +724,7 @@ static void idxd_remove(struct pci_dev *pdev)
>   	pci_free_irq_vectors(pdev);
>   	pci_iounmap(pdev, idxd->reg_base);
>   	if (device_user_pasid_enabled(idxd))
> -		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
> +		idxd_disable_sva(pdev);
>   	pci_disable_device(pdev);
>   	destroy_workqueue(idxd->wq);
>   	perfmon_pmu_remove(idxd);
