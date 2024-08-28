Return-Path: <dmaengine+bounces-2998-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA49634FB
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 00:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A622848FA
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475A1AB515;
	Wed, 28 Aug 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DV8QqTM1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294715A858;
	Wed, 28 Aug 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885189; cv=none; b=Phgvn3e4ZZuRaWgPixPQw6OpKnI5JiVP7nOX19wchqL57KQUJil/kPrUqT7sIfQpZa9YRDaLOmg+Jp4YOMGegH9aZ8EyBXcIoS0T2ogBhq7VQ9754NpFxM4Z7nQjPpnm+txoRAkdPTW7turyr4oAQcsqZLJeiY5ARuxa+GkWsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885189; c=relaxed/simple;
	bh=jr/ZaJazAELYY2y3twofy2d7vsfPS7J90CPcaVYvpCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+Lqik7lgcW/QTfgqjosfEBxJ3OEQ++5tpf56tIr4S9oPyVTlhzG4hlJ1s8uZ+CMdumO4cxLVNJzLrC7N3YQLzoRW0ZjNv6JU++/XKJoSbShSbsVDAbsusvi6NKlQsGP+DDDyypxqAMotI57TnYnxRyRQ3hJqCkqnt4BXsdtdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DV8QqTM1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724885188; x=1756421188;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jr/ZaJazAELYY2y3twofy2d7vsfPS7J90CPcaVYvpCo=;
  b=DV8QqTM1YfnFNDSPnTsFM9pixTv2UoYdH2Q5BCAwHicmj2w7EMtR7Kie
   Etcg+PPLr22G4ZwEMnZwTinu6tsQU30jUkLxvsmS97vvfwePQJBfBHVch
   BOJhnzSmknYXutVtUrdCVtlJBxUvaxZNtK9HFeJMJR6EA4VNNq0OX0sju
   QArqQxU52B+IUVBvQYX644eEcWfRB39OydLg1+VoRXITOqWHUoHI8HJtQ
   Hn0Zrn9IbkIMgCv744PpKtymJCOjzQZ3/GTrtFT0d12S+CxePmJPZFQFL
   Mfa34c/6YrCF0YXIn+Nx5VnKQEOC/KsaRnh4/n7UFY9FPoq76sAymgpmO
   w==;
X-CSE-ConnectionGUID: 1547tKrvRbuwN80rBd1tnA==
X-CSE-MsgGUID: oxvMYnD3T6mqkUII3RaNRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="40952110"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="40952110"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:46:27 -0700
X-CSE-ConnectionGUID: bXZu/P+iRXiBurQ8wB/thw==
X-CSE-MsgGUID: AvthqleKQ0mKoPe67RNRGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63371738"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.111.94]) ([10.125.111.94])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:46:23 -0700
Message-ID: <35c02436-fbb2-4f3d-a6bc-f6ef96638fb4@intel.com>
Date: Wed, 28 Aug 2024 15:46:22 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: idxd: Add a new DSA device ID on Granite
 Rapids-D platform
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20240828224204.151761-1-fenghua.yu@intel.com>
 <20240828224204.151761-2-fenghua.yu@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240828224204.151761-2-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/28/24 3:42 PM, Fenghua Yu wrote:
> A new DSA device ID, 0x11fb, is introduced on the Granite Rapids-D
> platform. Add the device ID to the IDXD driver.
> 
> Since a potential security issue has been fixed on the new device, it's
> secure to assign the device to virtual machines, and therefore, the new
> device ID will not be added to the VFIO denylist. Additionally, the new
> device ID may be useful in identifying and addressing any other potential
> issues with this specific device in the future. The same is also applied
> to any other new DSA/IAA devices with new device IDs.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 2 ++
>  include/linux/pci_ids.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 21f6905b554d..415b17b0acd0 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -69,6 +69,8 @@ static struct idxd_driver_data idxd_driver_data[] = {
>  static struct pci_device_id idxd_pci_tbl[] = {
>  	/* DSA ver 1.0 platforms */
>  	{ PCI_DEVICE_DATA(INTEL, DSA_SPR0, &idxd_driver_data[IDXD_TYPE_DSA]) },
> +	/* DSA on GNR-D platforms */
> +	{ PCI_DEVICE_DATA(INTEL, DSA_GNRD, &idxd_driver_data[IDXD_TYPE_DSA]) },
>  
>  	/* IAX ver 1.0 platforms */
>  	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e388c8b1cbc2..ff99047dac44 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2706,6 +2706,7 @@
>  #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
>  #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
>  #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
> +#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
>  #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>  #define PCI_DEVICE_ID_INTEL_82437	0x122d
>  #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e

