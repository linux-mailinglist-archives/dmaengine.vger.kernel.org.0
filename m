Return-Path: <dmaengine+bounces-1636-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD9890879
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F3CB21D33
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91D137749;
	Thu, 28 Mar 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dNj/cwYG"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A481132809;
	Thu, 28 Mar 2024 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651465; cv=none; b=E1aPwSEldYuNd3/vVEi+8SLKyy0in9kaiXIcpLZ6jSnqtWYTP9IMeWU8hIC63qQIVUTmTEEmeM+cbdh3JIvAKB3+cVOgqFzWHif0qdJ/iLOHOBvA6e0+cF3qcqiwM2+gU7ZYZrAD8wbbHvAFXWqLPXpxID8TlYC/h+fOQq9khkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651465; c=relaxed/simple;
	bh=4jJArD811RJcc+gAYwImLmK4dy10KhWADxTR/PrA1zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R8rPdthdh6+2z5v83g4mjecPNqCLENad0IBzFz+9MGkrJ7Wm3qUregmWTKd6+aXfHV7HCTHGBn0OK8AkcLwwthghwMRzuCsVCF1cTBSi1OVhF3hJ+i+84Jz9QWWu9daRkgxhJjXrL5NpSJiAmK19uZVAifsc86ar2+a3HB8ddVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dNj/cwYG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=pNOqZu7GfLqkG1YD8n5bDGZjW6EBZpWpPfAiqoLn+l8=; b=dNj/cwYGeF+fb2AjBYQ/MksH0I
	un/I9R3xvMEzCrV8z3J8u4V77TQiei3wek5rXFQqwOJ/h+cQm2tjNgihrWyh5c679hFtlcsv4cwvG
	KvVzJ7rZNryfrhF1OS+03U1K8BMV7vmMzK7DtoSQIsqShYMw+cCNC7ehKdWCNvfW/XkGX4eptK1fr
	RhYXbH/S8thnw+Te3nWY0CUP7o7Ii5Ks0tHns11+ldcLAeeMV8SnOgxFMJH7DnK7/GjcuQcykruck
	atgUk75340wpH91FGuDsnxdnc73c0i3v8pdeRWbh59DRMJD5p+bCz5WwXAVmlVA8oHACsiRMcIUv6
	rlT8y3pw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpujb-0000000FECU-2AdZ;
	Thu, 28 Mar 2024 18:44:19 +0000
Message-ID: <b52825eb-ba5e-4caf-b68e-9a632180876f@infradead.org>
Date: Thu, 28 Mar 2024 11:44:16 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] docs: dma: correct dma_set_mask() sample code
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
 linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240328154827.809286-1-Frank.Li@nxp.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240328154827.809286-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I have some text corrections. No idea if the updates
are correct or not.


On 3/28/24 08:48, Frank Li wrote:
> There are bunch of codes in driver like
> 
>        if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
>                dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
> 
> Actaully it is wrong because if dma_set_mask_and_coherent(64) failure,

  Actually                                                      fails,

> dma_set_mask_and_coherent(32) will be failure by the same reason.

                                will fail for the same reason.

> 
> And dma_set_mask_and_coherent(64) never return failure.

                                          returns failure.

> 
> According to defination of dma_set_mask(), it indicate the width of address

            to the definition                   indicates

> that device DMA can access. If it can access 64bit address, it must access

                                               64-bit

> 32bit address inherently. So only need set biggest address width.

  32-bit

> 
> See below code fragment:
> 
> dma_set_mask(mask)
> {
> 	mask = (dma_addr_t)mask;
> 
> 	if (!dev->dma_mask || !dma_supported(dev, mask))
> 		return -EIO;
> 
> 	arch_dma_set_mask(dev, mask);
> 	*dev->dma_mask = mask;
> 	return 0;
> }
> 
> dma_supported() will call dma_direct_supported or iommux's dma_supported
> call back function.
> 
> int dma_direct_supported(struct device *dev, u64 mask)
> {
> 	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
> 
> 	/*
> 	 * Because 32-bit DMA masks are so common we expect every architecture
> 	 * to be able to satisfy them - either by not supporting more physical
> 	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> 	 * architecture needs to use an IOMMU instead of the direct mapping.
> 	 */
> 	if (mask >= DMA_BIT_MASK(32))
> 		return 1;
> 
> 	...
> }
> 
> The iommux's dma_supported() actual means iommu require devices's minimized

                               actually           requires
or just drop "actual"

> dma capatiblity.

      capability.

> 
> An example:
> 
> static int sba_dma_supported( struct device *dev, u64 mask)()
> {
> 	...
> 	 * check if mask is >= than the current max IO Virt Address
>          * The max IO Virt address will *always* < 30 bits.
>          */
>         return((int)(mask >= (ioc->ibase - 1 +
>                         (ioc->pdir_size / sizeof(u64) * IOVP_SIZE) )));
> 	...
> }
> 
> 1 means supported. 0 means unsupported.
> 
> Correct document to make it more clear and provide correct sample code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/core-api/dma-api-howto.rst | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
> index e8a55f9d61dbc..7871d3b906104 100644
> --- a/Documentation/core-api/dma-api-howto.rst
> +++ b/Documentation/core-api/dma-api-howto.rst
> @@ -203,13 +203,33 @@ setting the DMA mask fails.  In this manner, if a user of your driver reports
>  that performance is bad or that the device is not even detected, you can ask
>  them for the kernel messages to find out exactly why.
>  
> -The standard 64-bit addressing device would do something like this::
> +The 24-bit addressing device would do something like this::
>  
> -	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))) {
> +	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(24))) {
>  		dev_warn(dev, "mydev: No suitable DMA available\n");
>  		goto ignore_this_device;
>  	}
>  
> +The standard 64-bit addressing device would do something like this::
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))

                                                        ;

> +
> +dma_set_mask_and_coherence never return fail when DMA_BIT_MASK(64). Typical

   dma_set_mask_and_coherent        returns failure when DMA_BIT_MASK(64) <does what?>. Typical
?

> +error code like::
> +
> +	/* Wrong code */
> +	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
> +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))

                                                                ;

> +
> +dma_set_mask_and_coherence() will never return failure when bigger then 32.

   dma_set_mask_and_coherent()

> +So typical code like::
> +
> +	/* Recommented code */

           Recommended

> +	if (support_64bit)
> +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	else
> +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +
>  If the device only supports 32-bit addressing for descriptors in the
>  coherent allocations, but supports full 64-bits for streaming mappings
>  it would look like this::

-- 
#Randy

