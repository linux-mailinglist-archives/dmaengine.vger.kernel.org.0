Return-Path: <dmaengine+bounces-3004-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3DA963642
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 01:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522441F20592
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 23:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD411AE020;
	Wed, 28 Aug 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDbHEDNN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8C1AE024;
	Wed, 28 Aug 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888254; cv=none; b=XNnvr2ObvBkvBI0vRyod84S7gnff33jRqeLwAXXldno00bXuNC0ktJOjvuppDDP5nICI72ZKSQ9aLYlF8ZJsAQ3uQT7/uvgBEpzu4Plrlda2f5Q4eBCc/fOWPjvgEc7FYf45OyKlO6m31hUW63yVNwbILDeaGi9OOLbmZht8XXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888254; c=relaxed/simple;
	bh=TBUUEgAxl2gdWJmU9KnpU2Ca2Mkau6Okcj2ojJsXNfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/f1SicUrjmND0KGCvH6HEQssWjKJxf6ODJF8Wf6Xj4dTO5nLUvWjyBNqf7VOt3+MOKJMtnsPG8L+uF92xFWKhzQRF8fPkhG8KD65RhpAw2cSaeVHYcaoKCv5sma7rck1Qknmp1ba+JKYLZC79A6IitHV6I8FKtDc/1ftgEze+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDbHEDNN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724888253; x=1756424253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TBUUEgAxl2gdWJmU9KnpU2Ca2Mkau6Okcj2ojJsXNfc=;
  b=HDbHEDNNf97hknIPRmPOEA6U0tBbjHmrG/CjIyE71auyItonzIy0KnOn
   7Wk/1zOqrMIgXbRvG3CXx2zK/Lumjg2zx4vXQZ9jy7NWO6MpIzIl1Cs+Y
   11I03juoLYjYw60esEHEVFrT3glViIFAR1xR2AM3CCW9jsMGoYyXHp6PR
   bfyLEVIR++NxaAPo1tQdnekvyGbEIRIfTkpt/fhJoaLck4hnwJZf+kwM2
   HVl+R+i8HuzrmstKcxy0HWYYAflcCAo17qhYsEEI1a/MsUs9Q7dil7oWP
   9YqIR2Bi1kVS1ZJ7kVSy1q39DQ4qsUjq8irlx+FRBX2r3vGwiEi4Hx3sB
   w==;
X-CSE-ConnectionGUID: XbxN1yD9ROy5XZklmionxw==
X-CSE-MsgGUID: kU5d8Y4fSUK9+B/o9jdrNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23412077"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23412077"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:37:32 -0700
X-CSE-ConnectionGUID: Zeil5yAGS72JMaJ5zU2AwA==
X-CSE-MsgGUID: Y04QKCWVROept/fdiJCjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68286949"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.111.94]) ([10.125.111.94])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:37:33 -0700
Message-ID: <bc0f3e64-300e-4879-822c-3e86103720c5@intel.com>
Date: Wed, 28 Aug 2024 16:37:31 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: Add new DSA and IAA device IDs
 for Diamond Rapids platform
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20240828233401.186007-1-fenghua.yu@intel.com>
 <20240828233401.186007-3-fenghua.yu@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240828233401.186007-3-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/28/24 4:34 PM, Fenghua Yu wrote:
> A new DSA device ID, 0x1212, and a new IAA device ID, 0x1216, are
> introduced for Diamond Rapids platform. Add the device IDs to the IDXD
> driver.
> 
> The name "IAA" is used in new code instead of the old name "IAX".
> However, the "IAX" naming (e.g., IDXD_TYPE_IAX) is retained for legacy
> code compatibility.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v2:
> - Replace "IAX" with "IAA" (Dave Jiang)
> 
>  drivers/dma/idxd/init.c | 4 ++++
>  include/linux/pci_ids.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 415b17b0acd0..0f693b27879c 100644
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
> +	/* IAA on DMR platforms */
> +	{ PCI_DEVICE_DATA(INTEL, IAA_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index ff99047dac44..8139231d0e86 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2707,6 +2707,8 @@
>  #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
>  #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
>  #define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
> +#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
> +#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
>  #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>  #define PCI_DEVICE_ID_INTEL_82437	0x122d
>  #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e

