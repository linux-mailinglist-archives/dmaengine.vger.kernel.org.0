Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3BF6A78AA
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 02:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCBBDV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 20:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBBDU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 20:03:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F731ABCC;
        Wed,  1 Mar 2023 17:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677718999; x=1709254999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5aVheeXtArZZ8SQ999CaahsuaDd0wIm4EpgBZLrjGFY=;
  b=VV+CMmmvjWRCJ2zFAdg2nxIPGUaoP+VO4tjMBhUueFeH+xp7dH2/ozgc
   +6plILZ+MDN6k81un5tRQMabFeDLRJouTXAmlbmFoa7pfwKRDLbuv31j+
   xnnmi3YQ7RFk+8KxksTjUpTNQCqYzl0A2F2rpfzgPZy4k12CozoAlhXyy
   tHkxua3m1QTrYjG3FZaIK9B/DfxzeXAmeFjpm+T9xvlKLQ9FFYSuj9kmM
   i5uIz+H1c2iSwkMJ7w2zxb827L1nWqOV3S1pgMDRnG5bZxOSmb1i6R/Dq
   85AtgvLNPSBsjBDHteIekwcw/Idn5E5+YBXffUCcjVqRbkDJEOE2wzA19
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336871725"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="336871725"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:03:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738853622"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="738853622"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.27]) ([10.212.71.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:03:17 -0800
Message-ID: <de2e6d69-a637-18be-8ccc-9fa51dc7689d@intel.com>
Date:   Wed, 1 Mar 2023 18:03:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under DMA
 API
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
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



On 3/1/23 5:59 PM, Jacob Pan wrote:
> Kernel workqueues were disabled due to flawed use of kernel VA and SVA
> API. Now That we have the support for attaching PASID to the device's
> default domain and the ability to reserve global PASIDs from SVA APIs,
> we can re-enable the kernel work queues and use them under DMA API.
> 
> We also use non-privileged access for in-kernel DMA to be consistent
> with the IOMMU settings. Consequently, interrupt for user privilege is
> enabled for work completion IRQs.
> 
> Link:https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/device.c | 30 +++++--------------------
>   drivers/dma/idxd/init.c   | 47 +++++++++++++++++++++++++++++++++++----
>   drivers/dma/idxd/sysfs.c  |  7 ------
>   3 files changed, 48 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 125652a8bb29..96faf4d3445e 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -299,21 +299,6 @@ void idxd_wqs_unmap_portal(struct idxd_device *idxd)
>   	}
>   }
>   
> -static void __idxd_wq_set_priv_locked(struct idxd_wq *wq, int priv)
> -{
> -	struct idxd_device *idxd = wq->idxd;
> -	union wqcfg wqcfg;
> -	unsigned int offset;
> -
> -	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PRIVL_IDX);
> -	spin_lock(&idxd->dev_lock);
> -	wqcfg.bits[WQCFG_PRIVL_IDX] = ioread32(idxd->reg_base + offset);
> -	wqcfg.priv = priv;
> -	wq->wqcfg->bits[WQCFG_PRIVL_IDX] = wqcfg.bits[WQCFG_PRIVL_IDX];
> -	iowrite32(wqcfg.bits[WQCFG_PRIVL_IDX], idxd->reg_base + offset);
> -	spin_unlock(&idxd->dev_lock);
> -}
> -
>   static void __idxd_wq_set_pasid_locked(struct idxd_wq *wq, int pasid)
>   {
>   	struct idxd_device *idxd = wq->idxd;
> @@ -1324,15 +1309,14 @@ int drv_enable_wq(struct idxd_wq *wq)
>   	}
>   
>   	/*
> -	 * In the event that the WQ is configurable for pasid and priv bits.
> -	 * For kernel wq, the driver should setup the pasid, pasid_en, and priv bit.
> -	 * However, for non-kernel wq, the driver should only set the pasid_en bit for
> -	 * shared wq. A dedicated wq that is not 'kernel' type will configure pasid and
> +	 * In the event that the WQ is configurable for pasid, the driver
> +	 * should setup the pasid, pasid_en bit. This is true for both kernel
> +	 * and user shared workqueues. There is no need to setup priv bit in
> +	 * that in-kernel DMA will also do user privileged requests.
> +	 * A dedicated wq that is not 'kernel' type will configure pasid and
>   	 * pasid_en later on so there is no need to setup.
>   	 */
>   	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
> -		int priv = 0;
> -
>   		if (wq_pasid_enabled(wq)) {
>   			if (is_idxd_wq_kernel(wq) || wq_shared(wq)) {
>   				u32 pasid = wq_dedicated(wq) ? idxd->pasid : 0;
> @@ -1340,10 +1324,6 @@ int drv_enable_wq(struct idxd_wq *wq)
>   				__idxd_wq_set_pasid_locked(wq, pasid);
>   			}
>   		}
> -
> -		if (is_idxd_wq_kernel(wq))
> -			priv = 1;
> -		__idxd_wq_set_priv_locked(wq, priv);
>   	}
>   
>   	rc = 0;
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f30eef701970..dadc908318aa 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -501,14 +501,52 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>   
>   static int idxd_enable_system_pasid(struct idxd_device *idxd)
>   {
> -	return -EOPNOTSUPP;
> +	struct pci_dev *pdev = idxd->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct iommu_domain *domain;
> +	union gencfg_reg gencfg;
> +	ioasid_t pasid;
> +	int ret;
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> +		return -EPERM;
> +
> +	pasid = iommu_sva_reserve_pasid(1, dev->iommu->max_pasids);
> +	if (pasid == IOMMU_PASID_INVALID)
> +		return -ENOSPC;
> +
> +	ret = iommu_attach_device_pasid(domain, dev, pasid);
> +	if (ret) {
> +		dev_err(dev, "failed to attach device pasid %d, domain type %d",
> +			pasid, domain->type);
> +		iommu_sva_unreserve_pasid(pasid);
> +		return ret;
> +	}
> +
> +	/* Since we set user privilege for kernel DMA, enable completion IRQ */
> +	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> +	gencfg.user_int_en = 1;
> +	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
> +	idxd->pasid = pasid;
> +
> +	return ret;
>   }
>   
>   static void idxd_disable_system_pasid(struct idxd_device *idxd)
>   {
> +	struct pci_dev *pdev = idxd->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct iommu_domain *domain;
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> +		return;
>   
> -	iommu_sva_unbind_device(idxd->sva);
> +	iommu_detach_device_pasid(domain, dev, idxd->pasid);
> +	iommu_sva_unreserve_pasid(idxd->pasid);
>   	idxd->sva = NULL;
> +	idxd->pasid = IOMMU_PASID_INVALID;
>   }
>   
>   static int idxd_probe(struct idxd_device *idxd)
> @@ -530,8 +568,9 @@ static int idxd_probe(struct idxd_device *idxd)
>   		} else {
>   			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
>   
> -			if (idxd_enable_system_pasid(idxd))
> -				dev_warn(dev, "No in-kernel DMA with PASID.\n");
> +			rc = idxd_enable_system_pasid(idxd);
> +			if (rc)
> +				dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
>   			else
>   				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
>   		}
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 3229dfc78650..09f5c3f2a992 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -944,13 +944,6 @@ static ssize_t wq_name_store(struct device *dev,
>   	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
>   		return -EINVAL;
>   
> -	/*
> -	 * This is temporarily placed here until we have SVM support for
> -	 * dmaengine.
> -	 */
> -	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq->idxd))
> -		return -EOPNOTSUPP;
> -
>   	input = kstrndup(buf, count, GFP_KERNEL);
>   	if (!input)
>   		return -ENOMEM;
