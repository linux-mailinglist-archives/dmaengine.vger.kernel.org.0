Return-Path: <dmaengine+bounces-7236-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53143C65F77
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77A644E6080
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A736B284889;
	Mon, 17 Nov 2025 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Qj3qwuVW";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Qj3qwuVW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC3258ED9;
	Mon, 17 Nov 2025 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407639; cv=none; b=dNysspwB9G5TShgLwZFOFuHgPuTrEdnuC8lJ+8FTVP2ehVhqipp9O1iyDnwb08tkBBTREV84i2akfpGUeJSCz2Mdj/AtD/NwE1c/ZAgeXGYS5wapzsqDnVcelWlShzMpPfSri0oGWMNeD9C3eWajmj2cWV/aGTnIsCNHiJf0B0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407639; c=relaxed/simple;
	bh=QdptkI6CD1wduERsBjbzm2g9l0EkiyUcGjUKbXmkSJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMVVunXXKSrRy80s2FI8Yty5w6b1oI/3cgHZgdx5xjlhfsgz5BUiLjkfp03lS132KrJwdvL8UNiVrBRd7aWBzoNGlP0LLevM/6qBrw3wOV4na9nVFalDbElpjBZ/ZGaiVAvrZQQY/EdTSCntulXEME3BFutkRkJhuuR3X5Sz3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Qj3qwuVW; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Qj3qwuVW; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1763407636; bh=QdptkI6CD1wduERsBjbzm2g9l0EkiyUcGjUKbXmkSJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qj3qwuVWbTPNLfevEoB8ICELS3fesQbiPTvQv9cVQAZmwn/SvGJKQOlKWiG3KeHf6
	 /oYZo+qH/+e1JDsShK+dpvS0wEBDtS+S3+eY3ABH6p4XrNXyGdz23Zz2MdDKnXE0If
	 mBpwrwXZ2GpC50NuQ3+81iOYgzScGCk+sdWeYOxWhDlnHvL8MTlZlpimPHrt3OgNcq
	 MKGvb9oEv/J+yBv4HyBF3KXvGdxpKcWcPEhDVjTejonEHvRR2qD++LnDsJxqq2pZ+h
	 VDfGyycyMAExndpZx5rUqu1vauWUnMUqkC7by+5PN7XxQ1CBnyqVaCU2VQyA+0ei/1
	 7JLHxXmI+Ytlw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 764B63E1D1D;
	Mon, 17 Nov 2025 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1763407636; bh=QdptkI6CD1wduERsBjbzm2g9l0EkiyUcGjUKbXmkSJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qj3qwuVWbTPNLfevEoB8ICELS3fesQbiPTvQv9cVQAZmwn/SvGJKQOlKWiG3KeHf6
	 /oYZo+qH/+e1JDsShK+dpvS0wEBDtS+S3+eY3ABH6p4XrNXyGdz23Zz2MdDKnXE0If
	 mBpwrwXZ2GpC50NuQ3+81iOYgzScGCk+sdWeYOxWhDlnHvL8MTlZlpimPHrt3OgNcq
	 MKGvb9oEv/J+yBv4HyBF3KXvGdxpKcWcPEhDVjTejonEHvRR2qD++LnDsJxqq2pZ+h
	 VDfGyycyMAExndpZx5rUqu1vauWUnMUqkC7by+5PN7XxQ1CBnyqVaCU2VQyA+0ei/1
	 7JLHxXmI+Ytlw==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id A3D1D3E1D02;
	Mon, 17 Nov 2025 19:27:15 +0000 (UTC)
Message-ID: <5fd6185d-ac56-4540-b280-ffe7321315bd@mleia.com>
Date: Mon, 17 Nov 2025 21:27:15 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] dmaengine: lpc32xx-dmamux: fix device leak on route
 allocation
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
 Viresh Kumar <vireshk@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 =?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-9-johan@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251117161258.10679-9-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251117_192716_499975_44D94CBD 
X-CRM114-Status: GOOD (  20.55  )

On 11/17/25 18:12, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the DMA mux
> platform device during route allocation.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Fixes: 5d318b595982 ("dmaengine: Add dma router for pl08x in LPC32XX SoC")
> Cc: stable@vger.kernel.org	# 6.12
> Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/dma/lpc32xx-dmamux.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/lpc32xx-dmamux.c b/drivers/dma/lpc32xx-dmamux.c
> index 351d7e23e615..33be714740dd 100644
> --- a/drivers/dma/lpc32xx-dmamux.c
> +++ b/drivers/dma/lpc32xx-dmamux.c
> @@ -95,11 +95,12 @@ static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>   	struct lpc32xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
>   	unsigned long flags;
>   	struct lpc32xx_dmamux *mux = NULL;
> +	int ret = -EINVAL;
>   	int i;
>   
>   	if (dma_spec->args_count != 3) {
>   		dev_err(&pdev->dev, "invalid number of dma mux args\n");
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	for (i = 0; i < ARRAY_SIZE(lpc32xx_muxes); i++) {
> @@ -111,20 +112,20 @@ static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>   	if (!mux) {
>   		dev_err(&pdev->dev, "invalid mux request number: %d\n",
>   			dma_spec->args[0]);
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	if (dma_spec->args[2] > 1) {
>   		dev_err(&pdev->dev, "invalid dma mux value: %d\n",
>   			dma_spec->args[1]);
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	/* The of_node_put() will be done in the core for the node */
>   	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
>   	if (!dma_spec->np) {
>   		dev_err(&pdev->dev, "can't get dma master\n");
> -		return ERR_PTR(-EINVAL);
> +		goto err_put_pdev;
>   	}
>   
>   	spin_lock_irqsave(&dmamux->lock, flags);
> @@ -133,7 +134,8 @@ static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>   		dev_err(dev, "dma request signal %d busy, routed to %s\n",
>   			mux->signal, mux->muxval ? mux->name_sel1 : mux->name_sel1);
>   		of_node_put(dma_spec->np);
> -		return ERR_PTR(-EBUSY);
> +		ret = -EBUSY;
> +		goto err_put_pdev;
>   	}
>   
>   	mux->busy = true;
> @@ -148,7 +150,14 @@ static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>   	dev_dbg(dev, "dma request signal %d routed to %s\n",
>   		mux->signal, mux->muxval ? mux->name_sel1 : mux->name_sel1);
>   
> +	put_device(&pdev->dev);
> +
>   	return mux;
> +
> +err_put_pdev:
> +	put_device(&pdev->dev);
> +
> +	return ERR_PTR(ret);
>   }
>   
>   static int lpc32xx_dmamux_probe(struct platform_device *pdev)

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir

