Return-Path: <dmaengine+bounces-1710-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2CE895887
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5424528AF44
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA9F134400;
	Tue,  2 Apr 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8c2190C"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF7133994;
	Tue,  2 Apr 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072631; cv=none; b=ajP3oxDpafUxYu0C/Wxuo4/AGQs+/NuOZoRLteD6XoUEmiV4fkYptf1vsvMIZCk2aEFrIZHLnPZeMYE21vY2XwDhBMKyjoyggsZ5HUM83CD+JmFlALGXgjEAr/HNYuskn4RjXS6AsSsdtI3JKwy67biiRiXlL2M9jZ+DNRqyusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072631; c=relaxed/simple;
	bh=RarfvLq+0S7Qq4OzdY0QupY4nd0iXB2pPjTkmq4uGLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suRedW8nQrPzlCHqMweZFN6MBdynbPOTB0ahH8tnD40OUeJyWS2TsEsMQjtk3Tt3H9O4Lio1l8rEzCw+YWNsQXFx2z9go6L+EFLElseSt2jFLf61JdZ8wq4gf3fNF/HHJPFx61p7vhmpXTMTFZjpP4Mrcj2xs87QhfxdGTuL0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8c2190C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12F5C433C7;
	Tue,  2 Apr 2024 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712072631;
	bh=RarfvLq+0S7Qq4OzdY0QupY4nd0iXB2pPjTkmq4uGLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8c2190Ct4RIqG7jfTaUcyNMOayYCZONs1OhBRf4HbgikqzzKoNuI60Pb1z4hUJA1
	 jnSi/Fe9r1tNKVdqkz370NtkPMfSkETpUv2VSeafh0wFjt8coy37FJsoLSAcEhDORd
	 f2dB75H+qf6G0GVKZKnoSVmfJgucMk5AT74ly0lxuyen9BEXQsvVA+1Zp3RfgR6DPF
	 B3rJvuOT1ae04dq98UUwlonx/Ti3yktYt8tupRZv0s3CQbkFqLIlnMX5vQNFOfW9hY
	 yzS8eZDSmT0lWG9wE5vQeEA6Tfc0sJZTVTZ96NybxtyN361WF4aNQit+xgcJ6eqbB9
	 wL5C0UV+//gRw==
Date: Tue, 2 Apr 2024 17:43:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: rdunlap@infradead.org, hch@infradead.org, corbet@lwn.net,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lizhijian@fujitsu.com, mst@redhat.com
Subject: Re: [PATCH v2 1/1] docs: dma: correct dma_set_mask() sample code
Message-ID: <ZgwnsEWQXluVsWm-@ryzen>
References: <20240401174159.642998-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401174159.642998-1-Frank.Li@nxp.com>

On Mon, Apr 01, 2024 at 01:41:59PM -0400, Frank Li wrote:
> There are bunch of codes in driver like
> 
>        if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
>                dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
> 
> Actually it is wrong because if dma_set_mask_and_coherent(64) fails,
> dma_set_mask_and_coherent(32) will fail for the same reason.
> 
> And dma_set_mask_and_coherent(64) never returns failure.
> 
> According to the definition of dma_set_mask(), it indicates the width of
> address that device DMA can access. If it can access 64-bit address, it
> must access 32-bit address inherently. So only need set biggest address
> width.
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
> The iommux's dma_supported() actually means iommu requires devices's
> minimized dma capability.
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
> 
> Notes:
>     Change from v1 to v2:
>     - fixed typo, review by Randy Dunlap
> 
>  Documentation/core-api/dma-api-howto.rst | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
> index e8a55f9d61dbc..5f6a7d86b6bc2 100644
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
> +
> +dma_set_mask_and_coherent() never return fail when DMA_BIT_MASK(64). Typical
> +error code like::
> +
> +	/* Wrong code */
> +	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
> +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
> +
> +dma_set_mask_and_coherent() will never return failure when bigger then 32.

Nit:
s/then/than/


> +So typical code like::
> +
> +	/* Recommended code */
> +	if (support_64bit)
> +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	else
> +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +
>  If the device only supports 32-bit addressing for descriptors in the
>  coherent allocations, but supports full 64-bits for streaming mappings
>  it would look like this::
> -- 
> 2.34.1
> 

