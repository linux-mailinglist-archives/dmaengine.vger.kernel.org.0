Return-Path: <dmaengine+bounces-1758-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144E89B0A6
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 13:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870121C210CD
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 11:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A2200DB;
	Sun,  7 Apr 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQPlKr7E"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896AE13AF9;
	Sun,  7 Apr 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712489984; cv=none; b=DXOxNTg1qxOoh4G4hhxHcGm23AjfuK8lDI3ZlFvFzLbWuIY0+iHSuQ3DRAQFB+jdewqYTGELSzXRGmuYLi7g/FxwTPFlvVv+74/VkeaYzbWpucQwkmpQRqKi0cbomO7j+yIl11iBkkCBaDUhqVAJxDVVg6RXwVQOEpYstLBXOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712489984; c=relaxed/simple;
	bh=mJvXZdPEdNoOY55fKxIUkLDgBSNeblgMJBqWySQZXys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQkOyE/mLzSvV5AuPBe/2bLkxbe0aeDfFiwXSxWer1QQlSRNAowG1jk5lcfWWDZ8qJy4OH3V3rGOKvCbgEK2OrIV2hrCF68c/h60Uu2NXv/AP14dzSbLaDDJs1ghwOoEmxOGJunseEkS+4BqalEw9iNQ3pQDwHesjD3An1WZgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQPlKr7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E0AC433F1;
	Sun,  7 Apr 2024 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712489984;
	bh=mJvXZdPEdNoOY55fKxIUkLDgBSNeblgMJBqWySQZXys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQPlKr7EE9d3uDNk77hg5lNwDUrEPaiPxen6hvl9nSPE1O5lH8sg5NQEcScS3zVw0
	 pwR6uBmifMiqMCDMaAMamOj/8RfI4fgW9zSRaPTAIHtwWkn6U4UWCoqy1NuAaHVg7Q
	 WYbttC8d2/0hSpeT7n0fFMSwgwaC33vIESKIFMxRC67Gg8fvvSnkbTA/lEWFVcqmmN
	 WiYmyz9I22A6hOuTGCY9oONZ2JbECAefM0O6fzC6rywe45sQRcN7AfjiZs+DAU8fkw
	 RQrf6zVkXxbUMy0t5SoqyPK+Mo1pYDrxQZFwMBVljMMx+uPpKls3NauU9y3e/ZqIBw
	 r2zVUFZXB7+NQ==
Date: Sun, 7 Apr 2024 17:09:39 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: pl08x: Use kcalloc() instead of kzalloc()
Message-ID: <ZhKF-5P7O4rh_q2W@matsya>
References: <AS8PR02MB72373D9261B3B166048A8E218B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72373D9261B3B166048A8E218B392@AS8PR02MB7237.eurprd02.prod.outlook.com>

On 30-03-24, 16:23, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because the "channels"
> member can only be 8 or 2. This value is set when the "vendor_data"
> structs are initialized.
> 
> static struct vendor_data vendor_pl080 = {
> 	[...]
> 	.channels = 8,
> 	[...]
> };
> 
> static struct vendor_data vendor_nomadik = {
> 	[...]
> 	.channels = 8,
> 	[...]
> };
> 
> static struct vendor_data vendor_pl080s = {
> 	[...]
> 	.channels = 8,
> 	[...]
> };
> 
> static struct vendor_data vendor_pl081 = {
> 	[...]
> 	.channels = 2,
> 	[...]
> };
> 
> However, using kcalloc() is more appropriate [1] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Changes in v2:
> - Add the "Reviewed-by:" tag.
> - Rebase against linux-next.
> 
> Previous versions:
> v1 -> https://lore.kernel.org/linux-hardening/20240128115236.4791-1-erick.archer@gmx.com/
> 
> Hi everyone,
> 
> This patch seems to be lost. Gustavo reviewed it on January 30, 2024
> but the patch has not been applied since.
> 
> Thanks,
> Erick
> ---
>  drivers/dma/amba-pl08x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index fbf048f432bf..73a5cfb4da8a 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -2855,8 +2855,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>  	}
>  
>  	/* Initialize physical channels */
> -	pl08x->phy_chans = kzalloc((vd->channels * sizeof(*pl08x->phy_chans)),
> -			GFP_KERNEL);
> +	pl08x->phy_chans = kcalloc(vd->channels, sizeof(*pl08x->phy_chans),
> +				   GFP_KERNEL);

How is one better than the other?


>  	if (!pl08x->phy_chans) {
>  		ret = -ENOMEM;
>  		goto out_no_phychans;
> -- 
> 2.25.1

-- 
~Vinod

