Return-Path: <dmaengine+bounces-6297-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B1B3C58C
	for <lists+dmaengine@lfdr.de>; Sat, 30 Aug 2025 01:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB23560B51
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D02737F3;
	Fri, 29 Aug 2025 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbDV5XVc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12497256C88;
	Fri, 29 Aug 2025 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756509698; cv=none; b=XF/f5efIbWLZ3JMqib6e1edcROflfXAd3CCgzPq7pla7CkqsmrwwkN5i1gPrXSWQ84si9E7qWjAbc+1Ezy9UC8Kv/Ur8tAzbpgZBsBwOizHefKnxzu0hxB/6Y/Pe9qclVB3qmclOysgvHGlR4evoHdO8uqEk7N/BMEMExqZpXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756509698; c=relaxed/simple;
	bh=Sl+/MKf/uj5ySIsifpXz8dMFd98cOdz9H2oGaKfLj9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+KPx+8hMTwQuiQkDjnHPHRxgaqzQon4uAkeBdJWr+AnEQF9d3G51LuIIRaVv1qkCMsQcRMYQ/+fhQrSt3dZQk7YBdMulgoMhLib5XWNhynmV1upgP/CxPfiT/+tggyJ23b+C1JKrLgeTAPxONot3yb2NiCpZyySUfUiBfUOsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbDV5XVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85068C4CEF0;
	Fri, 29 Aug 2025 23:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756509697;
	bh=Sl+/MKf/uj5ySIsifpXz8dMFd98cOdz9H2oGaKfLj9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbDV5XVcwt9gn0NE/NYtR50UbmKoyRt3E9nwIorx6nauJ1XC96xNmPKNxB9PP9r9/
	 6JcYZKc9KuqhyoUrxQDxfvgxBYqh6WGVYopnlZNRSInmNoKOeSbJKdd0YZSYNolIpP
	 p2bPQH1Z6ivrFxoe/w/5tfW6HAC6IBMX0hst+rRKAXe2se+S09pfVurOpKkhYpspQ+
	 dXKht5kByedl4H9ucV0keUYA+vgS82Qh3AbJFHvH2GzNHA1eDgD2f0luCYoMQb7qIs
	 jGaBso77VAkQ5bBcwUWdt1wmGZ3a7rU9hNRler66pHHxIAyJuCJdUodNA8lb4VpomS
	 49w5wLydWgdUQ==
Date: Fri, 29 Aug 2025 16:21:32 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dan.carpenter@linaro.org, arnd@arndb.de,
	benjamin.copeland@linaro.org
Subject: Re: [PATCH] dmaengine: ti: edma: Fix memory allocation size for
 queue_priority_map
Message-ID: <20250829232132.GA1983886@ax162>
References: <20250829131346.3697633-1-anders.roxell@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829131346.3697633-1-anders.roxell@linaro.org>

Hi Anders,

On Fri, Aug 29, 2025 at 03:13:46PM +0200, Anders Roxell wrote:
> Fix a critical memory allocation bug in edma_setup_from_hw() where
> queue_priority_map was allocated with insufficient memory. The code
> declared queue_priority_map as s8 (*)[2] (pointer to array of 2 s8), but
> allocated memory using sizeof(s8) instead of sizeof(s8[2]).
> 
> This caused out-of-bounds memory writes when accessing:
>   queue_priority_map[i][0] = i;
>   queue_priority_map[i][1] = i;
> 
> The bug manifested as kernel crashes with "Oops - undefined instruction"
> on ARM platforms (BeagleBoard-X15) during EDMA driver probe, as the
> memory corruption triggered kernel hardening features on Clang.
> 
> Change the allocation from:
>   devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8), GFP_KERNEL)
> to this:
>   devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8[2]), GFP_KERNEL)
> 
> This ensures proper allocation of (ecc->num_tc + 1) * 2 bytes to match
> the expected 2D array structure.
> 
> Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/dma/ti/edma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 3ed406f08c44..8f9b65e4bc87 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2064,7 +2064,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
>  	 * priority. So Q0 is the highest priority queue and the last queue has
>  	 * the lowest priority.
>  	 */
> -	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
> +	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8[2]),

Would

  sizeof(*queue_priority_map)

work instead? That tends to be preferred within the kernel so that the
type information is not open coded twice and it helps avoid bugs exactly
like this one. See other uses of devm_kcalloc() and "14) Allocating
memory" in Documentation/process/coding-style.rst.

>  					  GFP_KERNEL);
>  	if (!queue_priority_map)
>  		return -ENOMEM;
> -- 
> 2.50.1
> 

