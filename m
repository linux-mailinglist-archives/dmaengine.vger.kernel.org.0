Return-Path: <dmaengine+bounces-3149-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71415975C1B
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 22:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D2EB2287E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 20:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A514B97E;
	Wed, 11 Sep 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HO0dSFfS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F6A3D3B8;
	Wed, 11 Sep 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088297; cv=none; b=P4G+oHjfXsKgVC6mCgYh/ynNOio3/b+5mzsMUjdOPNV1Sn/D6CDda9NFqpnjzIkLGBQOMpjdDFsiSK9ROiHD0k4LHgDx7df0QLyB8Pqjma6ZyksYtxat7YmvDpA/f69LNseEU5wX7vdAp0CrrMkOrv93jG/bjZ5PbV/oNQDjMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088297; c=relaxed/simple;
	bh=ifYxx9yM5OozO+q5D68dkhpbrsx2JgswURgb4jr2F6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IamlpphyMJVD28/fBnTHKnz+vjzJgSO3XjXRjGKYETObc2QpflDMMPjHWUM+srk6VJBf357a02lldkon039AbxSer3TJjsQv6zzMndLgV71oIvF/l0Bun38MGokCyqTdooImJ4U98P5PpH1WBGQwowYZQtlx3LQJZNtdNYgr7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HO0dSFfS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726088296; x=1757624296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ifYxx9yM5OozO+q5D68dkhpbrsx2JgswURgb4jr2F6s=;
  b=HO0dSFfS0s1q6GhikUODwxk7E3DAOyI5vgkWGKEFG6Te6QfmVfoVdGFt
   t37GpfcRBuPYWA6l0r47YDVqFmDxk54KryptMKZj6dgxsr1a80ZSyoRpc
   xVCCsciW8wIZvVkXXTejyhEgNIgh9nMtS0lIZdwx/fQL9Y+zvESi5Libc
   m7n/GnbKH/zT8tzIIYiXmmU8Gz4RdOdM77jDMQoADv0Is824JaHQFbIDl
   yK4/0XR7zIABKPOgEmXpYUiMf+0ENBhnlahPGFSPIAcKRiscsDYQQhrTO
   WKb8aqTiyWqLt3gwO3ylASkrKylZcOirT8AsQwoR9TJhls7FShGFM7nrO
   g==;
X-CSE-ConnectionGUID: Z2xaJy5JR8O25hhHdhYTMA==
X-CSE-MsgGUID: pophI8uUQY2kGXuBLNcF1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24783392"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="24783392"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 13:58:15 -0700
X-CSE-ConnectionGUID: O5zZLpXERzucJJw2Wc0+BQ==
X-CSE-MsgGUID: 6vHkGi8kTOG8LoXdoQAtag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="98325363"
Received: from rchernet-mobl4.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 13:58:15 -0700
Message-ID: <2878ef8c-6ceb-4530-956e-92cc3504f9f3@intel.com>
Date: Wed, 11 Sep 2024 13:58:13 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Add a new IAA device ID on Panther Lake
 family platforms
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20240911204512.1521789-1-fenghua.yu@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240911204512.1521789-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/11/24 1:45 PM, Fenghua Yu wrote:
> A new IAA device ID, 0xb02d, is introduced across all Panther Lake family
> platforms. Add the device ID to the IDXD driver.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> Hi, Vinod,
> 
> This patch is applied cleanly on the next branch in the dmaengine repo.
> 
> The next branch already includes a few new DSA/IAA device IDs in IDXD
> driver.
> 
> Please check the patches and the reasons why the new IDs should be added:
> https://lore.kernel.org/lkml/20240828233401.186007-1-fenghua.yu@intel.com/
> 
>  drivers/dma/idxd/init.c | 2 ++
>  include/linux/pci_ids.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 0f693b27879c..3ae494a7a706 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -78,6 +78,8 @@ static struct pci_device_id idxd_pci_tbl[] = {
>  	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
>  	/* IAA on DMR platforms */
>  	{ PCI_DEVICE_DATA(INTEL, IAA_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
> +	/* IAX PTL platforms */
> +	{ PCI_DEVICE_DATA(INTEL, IAX_PTL, &idxd_driver_data[IDXD_TYPE_IAX]) },

Use IAA going forward?

>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 8139231d0e86..e598d6ff58bf 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3117,6 +3117,7 @@
>  #define PCI_DEVICE_ID_INTEL_HDA_CNL_H	0xa348
>  #define PCI_DEVICE_ID_INTEL_HDA_CML_S	0xa3f0
>  #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
> +#define PCI_DEVICE_ID_INTEL_IAX_PTL	0xb02d

What is using this devid beyond the driver that needs pci_ids.h addition?

>  #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
>  #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
>  #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428

