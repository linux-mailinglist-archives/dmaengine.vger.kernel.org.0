Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF46C1AE7
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 17:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjCTQHG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjCTQGo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 12:06:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6FA12F08;
        Mon, 20 Mar 2023 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679327781; x=1710863781;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xZaJIJHTvzHqtYGzg9k2Q15U6VQTHZPoOgCjztFaFyA=;
  b=bKjO2gJ9YtfGzOd+g3p/OLj9C3eEAV5dFsgTqq9Ikx7/q2qpE0bIpCUE
   Mbu0+Gf/uD6gmCCPK9Y1xfZuQg0DLhLJBATSHh7b0750s+NzQCHjnCiyD
   chg5K8Hd170K2l6eMOignQ1j9ptqTHhbuYKqekPFJExFuMfMPngRu5grI
   ucvaWofyCJzruicNh4Uwsh3p4y0r3KWGikYHQToFrh3dSTJjh5sagAcID
   4TLiYFs03cLetjQ9ggexGIzrKThHkjM8qrK7mkMFlPelkZZxEu6BzFWWv
   dtTHZcUSWxQuS/3JYX1GT6HHwxZSy1iaqoX7fuTqDSvZGalc1hGzgfPNp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="424974366"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="424974366"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 08:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="824531530"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="824531530"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 08:56:08 -0700
Date:   Mon, 20 Mar 2023 09:00:06 -0700
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
Subject: Re: [PATCH v2 2/5] iommu/vt-d: Allow SVA with device-specific IOPF
Message-ID: <20230320090006.180efbed@jacob-builder>
In-Reply-To: <20230309025639.26109-3-baolu.lu@linux.intel.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
        <20230309025639.26109-3-baolu.lu@linux.intel.com>
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

On Thu,  9 Mar 2023 10:56:36 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> Currently enabling SVA requires IOPF support from the IOMMU and device
> PCI PRI. However, some devices can handle IOPF by itself without ever
> sending PCI page requests nor advertising PRI capability.
> 
> Allow SVA support with IOPF handled either by IOMMU (PCI PRI) or device
> driver (device-specific IOPF). As long as IOPF could be handled, SVA
> should continue to work.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7c2f4bd33582..d2fcab9d8f61 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4650,7 +4650,18 @@ static int intel_iommu_enable_sva(struct device
> *dev) if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
>  		return -ENODEV;
>  
> -	if (!info->pasid_enabled || !info->pri_enabled ||
> !info->ats_enabled)
> +	if (!info->pasid_enabled)
> +		return -EINVAL;
> +
> +	/*
> +	 * Devices having device-specific I/O fault handling should not
> +	 * support PCI/PRI.
> +	 */
> +	if (!info->pri_supported)
> +		return 0;
If you put this check at the very beginning, everything else should it be
the same, right?

Still feel a little weird that, SVA is tied to PRI for PCI PRI but not for
device specific IOPF.

> +	/* Devices supporting ATS/PRI should have it enabled. */
> +	if (!info->pri_enabled || !info->ats_enabled)
>  		return -EINVAL;
>  
>  	ret = iopf_queue_add_device(iommu->iopf_queue, dev);


Thanks,

Jacob
