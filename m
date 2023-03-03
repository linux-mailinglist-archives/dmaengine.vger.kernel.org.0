Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78C96A8E95
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 02:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCCBUr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 20:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCBUq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 20:20:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCC34028;
        Thu,  2 Mar 2023 17:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677806445; x=1709342445;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j7AIYuX5Qe9oeFbiQyOPvZ4yDa2qH0qd90k8dXQlpAg=;
  b=GAbJR1fSGvdKEAEQQoMYyBfkcvKVX1zvLcpPr2fBTN6fJc3VnAkssyAp
   MvfeoS+QVVnvxjOMq6wixq5XdMSEUGcUM6LuCuAOlrUtW4f70/Lbk/NeT
   mx/6vYAQ/tzJk7oB73gLlyzSkxmP/ic+J/MYHDgTrK1Y26YtpZECrYdPe
   Kt7J3mlPUpodiszdP7mU8AMsYaq+vH6eELIq/WoFgqoYrSoPpvrHp8Iad
   hb9GamMJOYim2s5aPFQUPC2hqn4HUEmXraADmBU9tdR0lXCDhKGDj8cSO
   tMOC4vSHyM41Y0t7UbRg0Z8306D7UcWOgQny2gztviJnvSL9sUMcbxxXO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="333638990"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="333638990"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 17:20:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="920939118"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="920939118"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2023 17:20:41 -0800
Message-ID: <063ed735-b8d1-1b44-67d7-78c3adb34074@linux.intel.com>
Date:   Fri, 3 Mar 2023 09:19:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under DMA
 API
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/2/23 8:59 AM, Jacob Pan wrote:
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

The idxd driver has claimed the DMA ownership of this device. Unless the
idxd driver itself attached another domain, iommu_get_domain_for_dev()
should never return a blocking domain.

"domain == NULL" happens when CONFIG_IOMMU_API is not set.

Furthermore, iommu_get_domain_for_dev() doesn't hold any refcount from
the domain, so in theory it's not safe here because it possibly causes
use-after-release case.

I would say iommu_get_dma_domain() or something similar is more suitable
for use here. It directly returns the device's default domain and the
iommu core guarantees that default domain will always valid during the
life cycle of any device driver.

Best regards,
baolu
