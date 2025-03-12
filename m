Return-Path: <dmaengine+bounces-4718-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2648A5E0F2
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FEB3B1B94
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BAC2571AD;
	Wed, 12 Mar 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VweW4UL2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7C256C96;
	Wed, 12 Mar 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794482; cv=none; b=T/LEJYg2hFFaxzL4Sgbq4fnG6zkdsJb1sG04P/gk1Sab1FSQtvxCPLbjc4iBBog9/bvlPil1Kkiwv7ojwTHM00063Dc+Wxo3TrnEz2NVJxK0Sp8NPtnVgWAvfRT2uqVpxueMbIo2sFKAVFZ0OIDk78Eer1FsY8gK5nwwxJg8TGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794482; c=relaxed/simple;
	bh=hVViuP1XxrEv6EI2bLn9rnYCAsJuQvmHpI9BKOvIoGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnF5OzRbc3shReE4qJp+bUhQOSIUXajyHJjDPWLGIN3acNeAEytHkNEj6qMuVHzQ7Jp5WeeAG/WNCqKPtSVUjmKinLergPFxeR4Nx2PMBxg/Dwqtmxwzfxkga2P1t3sE05bVM5FDz9LIqzl0SVndOu14N6cUVpkDcYA8lH6KeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VweW4UL2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741794481; x=1773330481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hVViuP1XxrEv6EI2bLn9rnYCAsJuQvmHpI9BKOvIoGc=;
  b=VweW4UL2rLkBJwVN6LZDqn66VRAeab0MnHGPZs6AWYEZq/iXFY4gMjL+
   8JX9b8dYpqo2YUMXGd93A+JnKuHBIxtHLdbU7Zt342bzHvpdyItYasMmn
   NbHg6cHdxEAaRjWlFCMd1dxidYutTCbZdBx6H+jNc7lDfT6teJhGMK7O2
   RU/rBJJLZGupxs4ibXQn9XSnlFfKg+qCDla0Yu3akykev/XnhgwaLWqFB
   c8tLK3KZFSFTH9kdj21ipDCAzbq387Q/b9sopjkSzqk/9eCxyKLKjFgTf
   6CWYg8ISe9ZE/pB7lDZe2C0rY8ozybKqk9TYMAE1wRbTNhoTndjvAqNI7
   w==;
X-CSE-ConnectionGUID: IyRh3+26SpSx5cLfWrc6xw==
X-CSE-MsgGUID: cLzm3tqyQqWqvndoqVt4UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30465455"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="30465455"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:48:00 -0700
X-CSE-ConnectionGUID: GHx4XRa7SDm6QdMP+m+Glw==
X-CSE-MsgGUID: wTMr/13EQ1aIFSJp8dPHLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121578728"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.108.8]) ([10.125.108.8])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:48:00 -0700
Message-ID: <cf4c118b-b035-4eaa-ade4-8f29a37d59dc@intel.com>
Date: Wed, 12 Mar 2025 08:47:59 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: Fix dma_async_tx_descriptor->tx_submit
 documentation
To: nathan.lynch@amd.com, Vinod Koul <vkoul@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250312-dma_async_tx_desc-tx_submit-doc-v1-1-16390060264c@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250312-dma_async_tx_desc-tx_submit-doc-v1-1-16390060264c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/12/25 8:32 AM, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Commit 790fb9956eea ("linux/dmaengine.h: fix a few kernel-doc
> warnings") inserted new documentation for @desc_free in the middle of
> @tx_submit's description.
> 
> Put @tx_submit's description back together, matching the indentation
> style of the rest of the documentation for dma_async_tx_descriptor.
> 
> Fixes: 790fb9956eea ("linux/dmaengine.h: fix a few kernel-doc warnings")
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  include/linux/dmaengine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index bb146c5ac3e4ccd7bc0afbf3b28e5b3d659ad62f..51e1e357892a0325646f82d580b199321d59ced4 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -594,9 +594,9 @@ struct dma_descriptor_metadata_ops {
>   * @phys: physical address of the descriptor
>   * @chan: target channel for this operation
>   * @tx_submit: accept the descriptor, assign ordered cookie and mark the
> + *	descriptor pending. To be pushed on .issue_pending() call
>   * @desc_free: driver's callback function to free a resusable descriptor
>   *	after completion
> - * descriptor pending. To be pushed on .issue_pending() call
>   * @callback: routine to call after this operation is complete
>   * @callback_result: error result from a DMA transaction
>   * @callback_param: general parameter to pass to the callback routine
> 
> ---
> base-commit: 6565439894570a07b00dba0b739729fe6b56fba4
> change-id: 20250312-dma_async_tx_desc-tx_submit-doc-58a4cfee2e8b
> 
> Best regards,


