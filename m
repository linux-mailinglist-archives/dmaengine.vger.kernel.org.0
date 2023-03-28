Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F536CB64C
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 07:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjC1FtS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 01:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1FtQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 01:49:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D811BFD;
        Mon, 27 Mar 2023 22:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679982556; x=1711518556;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3umUbM9oJ7s5zHn3EjA5OyrI/C10PnQfI+nvrcZjrQI=;
  b=Lx4f9PP2UGTscM40Jk/86a9VW92Wc/LpMSlihXuYvO0tJps1hdCaLUkM
   Il9A7wWUHN2KP1KpnDioK5VGcABPSNPE3sxkPx768DpigXJqOvUD4xCnx
   csvLnGNmnTDZoAoZZDpRxtbIoxvlsbyjAx5QburGghjavhHmxn6BCc0ja
   2GRJm33/XXhd1zP/CMx8hhVDDJkTgaAjTE2ZUso5KOWq5FonVL/pSTSHB
   chikQI/z/N99yLVS+lWHIxmqUXlSVxvvj+zJi2JNrXecbzAXdjfmVH6M3
   wAQT1Jb7QI1/yMLBGOgQpFFwAmTbu/My7J6uokuFiZO9LUoii1XzGoJKJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="324371759"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="324371759"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="714128861"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="714128861"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2023 22:49:05 -0700
Message-ID: <71b60cc2-4ab0-3777-6bc9-3a6a4174f743@linux.intel.com>
Date:   Tue, 28 Mar 2023 13:49:24 +0800
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
Subject: Re: [PATCH v2 5/8] iommu/vt-d: Make device pasid attachment explicit
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-6-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230327232138.1490712-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/28/23 7:21 AM, Jacob Pan wrote:
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 65b15be72878..b6c26f25d1ba 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -595,6 +595,7 @@ struct dmar_domain {
>   
>   	spinlock_t lock;		/* Protect device tracking lists */
>   	struct list_head devices;	/* all devices' list */
> +	struct list_head dev_pasids;	/* all attached pasids */
>   
>   	struct dma_pte	*pgd;		/* virtual address */
>   	int		gaw;		/* max guest address width */
> @@ -708,6 +709,7 @@ struct device_domain_info {
>   	u8 ats_supported:1;
>   	u8 ats_enabled:1;
>   	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
> +	u8 dev_attached:1;	/* Device context activated */
>   	u8 ats_qdep;
>   	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
>   	struct intel_iommu *iommu; /* IOMMU used by this device */
> @@ -715,6 +717,12 @@ struct device_domain_info {
>   	struct pasid_table *pasid_table; /* pasid table */
>   };
>   
> +struct device_pasid_info {
> +	struct list_head link_domain;	/* link to domain siblings */
> +	struct device *dev;		/* physical device derived from */
> +	ioasid_t pasid;			/* PASID on physical device */
> +};

The dev_pasids list seems to be duplicate with iommu_group::pasid_array.

The pasid_array is de facto per-device as the PCI subsystem requires ACS
to be enabled on the upstream path to the root port.

pci_enable_pasid():
385         if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
386                 return -EINVAL;

For such PCI topology, pci_device_group() always assigns an exclusive
iommu group (a.k.a. singleton group).

So, how about moving the pasid_array from struct iommu_group to struct
dev_iommu? With this refactoring, the individual iommu driver has no
need to create their own pasid array or list.

Instead of using iommu_group::mutex, perhaps the pasid_array needs its
own lock in struct dev_iommu after moving.

Best regards,
baolu
