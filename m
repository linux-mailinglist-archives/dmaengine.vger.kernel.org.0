Return-Path: <dmaengine+bounces-2997-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE409634F9
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 00:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333651C24559
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 22:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DA816B735;
	Wed, 28 Aug 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8VqVM1+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124CE156230;
	Wed, 28 Aug 2024 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885127; cv=none; b=hc+NOc8GCO2gNln6jGM4nCsLPiI/jv7r2A4couBDNxBUjWMHy8LYbCQXKwjYUcx4Hxy51fl9qtjs5He5tjnlju0l5/upwXbR/qiWeW7zLfSfsF9GvZz63bIDvMRvvpTwMvnLFss3b+qBBqbFZ6cXBRfal+voZGal/l72/5KzTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885127; c=relaxed/simple;
	bh=GHbpkKtHwxtPXVPWVCLGhJrowNHntWbd4IX8jJn4C3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYcQcFbrSlm8fI6MQDxHZ1yeWZEVYSaf9VfqRhqW+14iUWy+qcQos3Sw0EAxeLdOnIB2Bl93erlhvHoRFZM0TuAXN+5btml4sJ50oYfMxy2P7lya6DtmQagJ1OKI0zDhGS9RPS6CKpco9JCVK5HAO0uNbNF2CEQeUc2hxxpgWlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8VqVM1+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724885126; x=1756421126;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GHbpkKtHwxtPXVPWVCLGhJrowNHntWbd4IX8jJn4C3w=;
  b=l8VqVM1+TH3qM9HIHZHYsa0OPa9i/JwaylOp1Vp14MQIryeiTXMD15Fp
   tub26A92n4S5TSIXgqOWrYjvoza1dvCp4JIkPDxmV+pMbSNTrnAM79UJO
   tk/hl3CpIoe1C/nQm5iAS3bT1+vRCF0sDJxhtPobhl7eeOURjUCBRsVys
   Yf2JQH0nN2MSbKhWhuGb8zcJX3DZ17oehuhkxALXO/GqTKGDWEPpLLwxQ
   s1ZwdOnyClzrSLM06NNFLknQu7/z/1PvbpMs5CJjE/XOpsqTpcPlAeUzH
   M0A9w31PpmDwnvD7OnMAzKp98FsmuQ9BiXibEAG9GaTBz8BNjC5TzbNdM
   g==;
X-CSE-ConnectionGUID: HQOTlIktQhavbeQGAptcVA==
X-CSE-MsgGUID: oOWxNUDVQK2WZmTNgyuznQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="40952042"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="40952042"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:45:25 -0700
X-CSE-ConnectionGUID: GFPLsq/lQiuf1I0lFKWpWQ==
X-CSE-MsgGUID: fY9iwSdLQoGErFovexZ0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63371644"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.111.94]) ([10.125.111.94])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:45:24 -0700
Message-ID: <d8505c21-dec0-45ce-8757-e1aea7ca7432@intel.com>
Date: Wed, 28 Aug 2024 15:45:23 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: idxd: Add new DSA and IAA device IDs on
 Diamond Rapids platform
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20240828224204.151761-1-fenghua.yu@intel.com>
 <20240828224204.151761-3-fenghua.yu@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240828224204.151761-3-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/28/24 3:42 PM, Fenghua Yu wrote:
> A new DSA device ID, 0x1212, and a new IAA device ID, 0x1216, are
> introduced on Diamond Rapids platform. Add the device IDs to the IDXD
> driver.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/dma/idxd/init.c | 4 ++++
>  include/linux/pci_ids.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 415b17b0acd0..21e3cff66f77 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -71,9 +71,13 @@ static struct pci_device_id idxd_pci_tbl[] = {
>  	{ PCI_DEVICE_DATA(INTEL, DSA_SPR0, &idxd_driver_data[IDXD_TYPE_DSA]) },
>  	/* DSA on GNR-D platforms */
>  	{ PCI_DEVICE_DATA(INTEL, DSA_GNRD, &idxd_driver_data[IDXD_TYPE_DSA]) },
> +	/* DSA on DMR platforms */
> +	{ PCI_DEVICE_DATA(INTEL, DSA_DMR, &idxd_driver_data[IDXD_TYPE_DSA]) },
>  
>  	/* IAX ver 1.0 platforms */
>  	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
> +	/* IAX on DMR platforms */
> +	{ PCI_DEVICE_DATA(INTEL, IAX_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },

IAA_DMR?

>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index ff99047dac44..e15ebb3942ae 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2707,6 +2707,8 @@
>  #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
>  #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
>  #define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
> +#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
> +#define PCI_DEVICE_ID_INTEL_IAX_DMR	0x1216

s/IAX/IAA/ ?

>  #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>  #define PCI_DEVICE_ID_INTEL_82437	0x122d
>  #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e

