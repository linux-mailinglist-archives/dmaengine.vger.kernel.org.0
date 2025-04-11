Return-Path: <dmaengine+bounces-4879-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EDFA86748
	for <lists+dmaengine@lfdr.de>; Fri, 11 Apr 2025 22:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5623D9C0FEA
	for <lists+dmaengine@lfdr.de>; Fri, 11 Apr 2025 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671F2258CE3;
	Fri, 11 Apr 2025 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBMGp2ko"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934C78F45;
	Fri, 11 Apr 2025 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403674; cv=none; b=s86vlFStHcUz29cBeGJ9JLF8pVgdrhULaYKJN2p6wHYRoyE1QtRfXZZOQcA3uT0ALFBniIi5nLvduT7mBM7TVFauoJoCOjgDqOkjp7X2x8rcsdpnpreL3hZ3auTWXKYHypJeZYFsTET3AqUf00jnYeDWeHV0Z6mWS7qmxY3aEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403674; c=relaxed/simple;
	bh=FAry2WrndROaE8YSKLu6gPsfRytuhZq+Odlo6QRirAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtXt3FECmw16UbY2tmLVShVweO9fqazY56kPSqGIJNMBi9FoFy4viEko8fZNfDsfKuu5gRlq4cH2gPPXtUwg7GdjggU7mAUrXrGIq5dw2zQRFETWXmuZ7aHvAngqxgpLG3NeuK6U/pHrh+NGEd1Pq4rLH/VaVbUdpq5v1sBqH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBMGp2ko; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744403672; x=1775939672;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FAry2WrndROaE8YSKLu6gPsfRytuhZq+Odlo6QRirAk=;
  b=BBMGp2koqBhrUCoggIfMhnYnTDTyx/aicwyAx0NnAQekHR99VjUwlj/W
   0d+fqCSiMp/cEs2y7d/ALf33ejJF7Xl+XDLS8S0/S/ugPg6KUHuqF/58n
   cdIsfB0SzOPS8eZpexhZEEp5E5NscZvQLOFdaQtxa4x+iH7RWRUZFngMN
   3j97rcdERMqLouehEIyop9QTnURY9RXVHXOYYXL11292veWpzIpEp7im7
   oIOcuwxOBSegzcVMZ7sHhicAGfDlsq9bqfPqEseo7OZOJDRLTXqx7ER16
   /12a7hhxxRK5zC30/8dq+h9sv7cFAlZf//MKxoV+lolshdr2y0cSZAkYY
   Q==;
X-CSE-ConnectionGUID: 3FN2MryXSiyeUN88ik/8NQ==
X-CSE-MsgGUID: /SdN1XJeRGeqdi2JSENSEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="46054730"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="46054730"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:34:32 -0700
X-CSE-ConnectionGUID: dsCZvxaDQi265B+cIetFSQ==
X-CSE-MsgGUID: 3Vhb6SZXQX2RaqR0qgNTIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="134039993"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.170]) ([10.125.108.170])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:34:31 -0700
Message-ID: <41a120c8-e5ad-4a0f-96cf-1159d5d1b4e1@intel.com>
Date: Fri, 11 Apr 2025 13:34:28 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] dmaengine: ptdma: use SLAB_TYPESAFE_BY_RCU for
 the DMA descriptor slab
To: Eder Zulian <ezulian@redhat.com>, Basavaraj.Natikar@amd.com,
 vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jsnitsel@redhat.com, ddutile@redhat.com
References: <20250411194148.247361-1-ezulian@redhat.com>
 <20250411194148.247361-2-ezulian@redhat.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250411194148.247361-2-ezulian@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/25 12:41 PM, Eder Zulian wrote:
> The SLAB_TYPESAFE_BY_RCU flag prevents a change of type for objects
> allocated from the slab cache (although the memory may be reallocated to
> a completetly different object of the same type.) Moreover, when the
> last reference to an object is dropped the finalization code must not
> run until all __rcu pointers referencing the object have been updated,
> and then a grace period has passed.

I would pull some of the explanation on why and how from your cover. Also, a fixes tag may be needed?

DJ
 
> 
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 715ac3ae067b..b70dd1b0b9fb 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -597,7 +597,8 @@ int pt_dmaengine_register(struct pt_device *pt)
>  
>  	pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
>  					       sizeof(struct pt_dma_desc), 0,
> -					       SLAB_HWCACHE_ALIGN, NULL);
> +					       SLAB_HWCACHE_ALIGN |
> +					       SLAB_TYPESAFE_BY_RCU, NULL);
>  	if (!pt->dma_desc_cache) {
>  		ret = -ENOMEM;
>  		goto err_cache;


