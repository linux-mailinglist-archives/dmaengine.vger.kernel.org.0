Return-Path: <dmaengine+bounces-776-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C98361DB
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9162951D3
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F83DBB5;
	Mon, 22 Jan 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imsnVuc7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105403DBB0;
	Mon, 22 Jan 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922725; cv=none; b=bfbU634Scj1vUAwL//7LHssM4Q0HMU3jtXbh0QS6eTBevBjkOdbdRcFIpsIqXcukEr7NEBzvuTA5crpwnEzx4pzLbqJPc/q7q2Yo/pnX5FPTnnay6D61Durg7r2k0gGDMMX7vgfkxf6rNgWnIcpZsuucrqokeDyCvSD/NojbL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922725; c=relaxed/simple;
	bh=naLbjV/nZJ/rNLJukcUgemet47PrR8ph+3UFQiJOLpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRSiQFAPp1AWEpU+PvpnEEc8egriBKBesB+2l357zySeOTP2mB+sop4loHcY6K9HAw1AD/gwSwELZFwYq5gUjCYTxhVEQvK6/CuZ0D4HP934DEDu5ucpazMdFB7DXiu0RzF/4DgJGJ4zPRwVo7zljSZAsNbb/bWz0UtdAar+P/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imsnVuc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D234C43390;
	Mon, 22 Jan 2024 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705922724;
	bh=naLbjV/nZJ/rNLJukcUgemet47PrR8ph+3UFQiJOLpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imsnVuc7ttDbq2JJ30rmecyU4XFNk/M4GbiiDUTA6a310sPAGfk/KfYiTZMm6pkU1
	 XlEraDm5UVpHRBqHQUPfUNg09lpRayvZwqLuGa1fRQSTfzZJsLMyvqtK3aQJP08Ffy
	 I26PeemCCRhdmqZjtlhbYD6g9+1SxQcFI9GxxSusVhtTAQ2sdsNpU50/gBF4YxppZD
	 9RE5PnKIq+Sv2BLJZQ6GXftLSqWyy85oXMXmnEGaw9SvSUysSqpgZCGwbyd87++VTw
	 7lUkpiO5UbX5iCGttGAxGMv5TsGxe03gaSmPwKm/X8GNVDO47waGQD3DkSRXejKAin
	 m6odbpsAPIJKg==
Date: Mon, 22 Jan 2024 16:55:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Add a null pointer check to the
 dma_request_chan
Message-ID: <Za5QoCO_o0duPJ4J@matsya>
References: <20240118033052.193282-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118033052.193282-1-chentao@kylinos.cn>

On 18-01-24, 11:30, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/dma/dmaengine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 491b22240221..a6f808d13aa4 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -856,6 +856,8 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  #ifdef CONFIG_DEBUG_FS
>  	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev),
>  					  name);
> +	if (!chan->dbg_client_name)
> +		return chan;

That is wrong, you cant return a half done channel here
Pls see rest of the code for reference

>  #endif
>  
>  	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
> -- 
> 2.39.2

-- 
~Vinod

