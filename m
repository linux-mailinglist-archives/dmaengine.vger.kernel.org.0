Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8D6D3115
	for <lists+dmaengine@lfdr.de>; Sat,  1 Apr 2023 15:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDANjl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Apr 2023 09:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDANjk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Apr 2023 09:39:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA7191E8;
        Sat,  1 Apr 2023 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680356379; x=1711892379;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uUCZhoSNiRXoLoz4XiiHkdrKLRqbdL1JjvL+YhsnEOQ=;
  b=lmSZOabwME5cYIopbi/5u/8RwpoLyo7F6h0dRmJsi1Lstv/ap3XvE0TL
   vBylJbY+AS6XZqaQiAfh/FaPI8h0UWJCFIOLtUPcNLyUxKzEJ8Tk0snCp
   CM93/obcsSwvWHCX6qj7ZD8BNvYFUt/Ol0I74FX8BobpxPitaf9GTsAHy
   s/05qgOfD+Tx/FRMMpsbTo2OoA5Omns7Vu5yc3Yj9s/EqhHzdbiQ+WRHO
   BlNIgW7uUUoqOGHmtXWgosGGXE5A6GwZaHFOSRfn4chIE+OUlzdjeSOna
   R6kw0/DlBYP9Y1JoY9tj2t1EeS7SUvn2O2dyvxtzdUH2g1f8Mmhhe8uSN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="344198906"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="344198906"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="796459152"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="796459152"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.241]) ([10.254.211.241])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:39:34 -0700
Message-ID: <07b7a01f-8a0d-6eca-e436-df5135d679cb@linux.intel.com>
Date:   Sat, 1 Apr 2023 21:39:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 7/7] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-8-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-8-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/4/1 7:11, Jacob Pan wrote:
>   static void idxd_disable_system_pasid(struct idxd_device *idxd)
>   {
> +	struct pci_dev *pdev = idxd->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct iommu_domain *domain;
> +	union gencfg_reg gencfg;
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> +		return;

Out of curiosity, why do you need to check the domain type? And, in
which case could the domain for the device be changed to a blocking one?

Once a driver is bound to the device, the driver "owns" the DMA of the
device. No one else could change the domain except the driver itself.

> +
> +	iommu_detach_device_pasid(domain, dev, idxd->pasid);
> +	iommu_free_global_pasid(idxd->pasid);
>   
> -	iommu_sva_unbind_device(idxd->sva);
> +	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> +	gencfg.user_int_en = 0;
> +	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
>   	idxd->sva = NULL;
> +	idxd->pasid = IOMMU_PASID_INVALID;
>   }

Best regards,
baolu
