Return-Path: <dmaengine+bounces-4485-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697AA36926
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 00:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDE57A2A11
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 23:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584011FC0E3;
	Fri, 14 Feb 2025 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixAsLzqG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D61C84D9;
	Fri, 14 Feb 2025 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576504; cv=none; b=roeOj/BEVrW3CnZb/ofexOat5N2pTZ6kv8QllvAhcQ+JV1rgwrt6EtfAaJV/u9RTTUYadtYuXe0BeM6HegecE8AZnGUepjvZe9GBNN8rRJDkYS2ivCs5NrHUW3xM4SzIYQMrhXH31rMJ9jaMIC9g1zGV9k5arq6iTkgKgSxaRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576504; c=relaxed/simple;
	bh=HIs6xCw66JolvHO2xTHyUUIT/URbvBtY9CkGEyZn7gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ogqe5LtB2gvn2zDk3nD7jSvFcHSvkTJUdUdJYLGq+i3XuGXGhoVRFus4J6g7u5AoX31wvi8N2StvKyqGUetITaiM/f9eonkwqXQPeuuQ8qqXK5FeIbRsgeYvv7kcf6ujXQv7aOS1nMCFDpS+SEFzf833NnM8ArxcpAEO/6jJk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixAsLzqG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739576503; x=1771112503;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HIs6xCw66JolvHO2xTHyUUIT/URbvBtY9CkGEyZn7gg=;
  b=ixAsLzqG0xVHkJgEmwu0GvvniwMQzyDvp7yiYH7/XNW647QN9CgePgvb
   nJp48zrwtmoIkorTrhvhrOPprrisv9SYT/xJpQrqGKWTBKZIWuGDuntiD
   aHBKgWr5YRkwLt21CC5K6wiuOpSiJrL6WeqzNfkJBvnTMyNZSrEBcIS9l
   E8qNcsBlBlvsNZeD/NooUuXCm72IDCDM6crfv2n+69nWEbBoufD8ay+2s
   4/LSG6kohF3IYm+qzf8XWD9mKHEtRQztDr6RqkHIvrZ2ca7riTlY2m8t2
   KD+q4bFHOcSC6tauzZPbhlMaxsjewiugsfwXApks3iRhXpfpT8E9Mgv89
   g==;
X-CSE-ConnectionGUID: kAvLfyg0RcKAHgTTxz13nA==
X-CSE-MsgGUID: R7Zemf/hSpO6Zkfv17g8Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40260625"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40260625"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 15:41:41 -0800
X-CSE-ConnectionGUID: J9aQUVGeQ/qx80umdoV4iQ==
X-CSE-MsgGUID: HNFHww64R3OnIEpPPbrxGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113451466"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.223.234])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 15:41:41 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, fenghua.yu@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] dmaengine: idxd: fix memory leak in error
 handling path of idxd_pci_probe
In-Reply-To: <20250110082237.21135-6-xueshuai@linux.alibaba.com>
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <20250110082237.21135-6-xueshuai@linux.alibaba.com>
Date: Fri, 14 Feb 2025 15:41:39 -0800
Message-ID: <87jz9s5c24.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shuai Xue <xueshuai@linux.alibaba.com> writes:

> Memory allocated for idxd is not freed if an error occurs during
> idxd_pci_probe(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/dma/idxd/init.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f0e3244d630d..9b44f5d38d3a 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -548,6 +548,14 @@ static void idxd_read_caps(struct idxd_device *idxd)
>  		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
>  }
>  
> +static void idxd_free(struct idxd_device *idxd)
> +{
> +	put_device(idxd_confdev(idxd));
> +	bitmap_free(idxd->opcap_bmap);
> +	ida_free(&idxd_ida, idxd->id);
> +	kfree(idxd);
> +}
> +

I was expecting this function to be called from idxd_remove() as well.
Perhaps on a separate patch?

>  static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -820,7 +828,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   err:
>  	pci_iounmap(pdev, idxd->reg_base);
>   err_iomap:
> -	put_device(idxd_confdev(idxd));
> +	idxd_free(idxd);
>   err_idxd_alloc:
>  	pci_disable_device(pdev);
>  	return rc;
> -- 
> 2.39.3
>

Cheers,
-- 
Vinicius

