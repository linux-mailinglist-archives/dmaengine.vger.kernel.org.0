Return-Path: <dmaengine+bounces-3661-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB3A9B7EFE
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 16:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885D428172D
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F92112D1EA;
	Thu, 31 Oct 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQtdHwh+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B71B1D65;
	Thu, 31 Oct 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389637; cv=none; b=A4AVIyMY91O/GEHsta8yYlQmBCzh19J7WUOBSN4NaIcTScjsbnaJyRDyH6iDNxeGWBwey6uhQPoyXdkRiNFppJ+0HAZmM+RHnbuxlykdgcFFc44m50cCT6DsiGAxoNbJKm3DNhD6XQy5JhDYMQ78DxYoHTusz1Y/gu+SdwgoVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389637; c=relaxed/simple;
	bh=eLD1L3pOCvIKzVFRBDgbKqCNjetNAo1mLqnfG0Jk5to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecw+RBw2EkH/7ldiwdE4wbXH2qZSCgLgXt27HK1PFXtKVrlwRGMAGholUvpkavIi6QtU2UhUTjydT82cPAjOY/VQhjwaRB0wnVcsjyQ0mTNNALinlDYTZvuUwUzQWfbSYsPsLkaVJ6+E0G8SecAUoFz8Xf9VRYKLPIDjfHQMrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQtdHwh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32326C55DF4;
	Thu, 31 Oct 2024 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730389636;
	bh=eLD1L3pOCvIKzVFRBDgbKqCNjetNAo1mLqnfG0Jk5to=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vQtdHwh+DFZmo36yZ4iGGgNSVbh5Crhu2gI0MaJlhVrWehYcHmacU6dgRbvLhRbxo
	 t6bQfZ58mrd+uGeD8EFxgfRGDvDUO379lfkcJLakRKp7RIYmZ51E0Ep6CFQmUA9Br6
	 CSA4zgQMzZ5UFBU/UpANlfvMNqpyN2Hbx+/kMoWxW3hprrloyI8WNHOHlp0gmvj4DK
	 Bj/Aq/At+cJFNZBlcEB5N4Ui4x+uA/kq7Bm4Oe4IjGpzP0icgL9J6YsFRXYgIzmb4T
	 nqUEV4L0Cpj5c92qY5wtxiDDz5UlqbiyvyKVt8d4P9gBFRXNgdef/LyhCbARzafSv7
	 7aETUVlW66YVQ==
Message-ID: <0712919e-300f-4eef-aa3f-ad5533743296@kernel.org>
Date: Thu, 31 Oct 2024 16:47:09 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] dma-engine: sun4i: Add has_reset option to quirk
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Mesih Kilinc <mesihkilinc@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
 <20241031123538.2582675-2-csokas.bence@prolan.hu>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20241031123538.2582675-2-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/10/2024 13:35, Csókás, Bence wrote:
> From: Mesih Kilinc <mesihkilinc@gmail.com>
> 
> Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
> has this bit but in order to support suniv we need to add it. So add
> support for reset bit.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> [ csokas.bence: Rebased and addressed comments ]
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>     Changes in v2:
>     * Call reset_control_deassert() unconditionally, as it supports optional resets
>     * Use dev_err_probe()
>     * Whitespace
>     Changes in v3:
>     * More dev_err_probe() fixes
>     Changes in v3:
>     * Use return value of dev_err_probe()
> 
>  drivers/dma/sun4i-dma.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index d472f57a39ea..4626cc8ad114 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_dma.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> @@ -159,6 +160,7 @@ struct sun4i_dma_config {
>  	u8 ddma_drq_sdram;
>  
>  	u8 max_burst;
> +	bool has_reset;
>  };
>  
>  struct sun4i_dma_pchan {
> @@ -208,6 +210,7 @@ struct sun4i_dma_dev {
>  	int				irq;
>  	spinlock_t			lock;
>  	const struct sun4i_dma_config *cfg;
> +	struct reset_control *rst;
>  };
>  
>  static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
> @@ -1215,6 +1218,15 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->clk);
>  	}
>  
> +	if (priv->cfg->has_reset) {
> +		priv->rst = devm_reset_control_get_exclusive(&pdev->dev,
> +							     NULL);

Unnecessary wrapping.

> +		if (IS_ERR(priv->rst)) {

Drop {}.

> +			return dev_err_probe(&pdev->dev, PTR_ERR(priv->rst),
> +						  "Failed to get reset control\n");

And this should be aligned with opening (. Run checkpatch --strict.

> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, priv);
>  	spin_lock_init(&priv->lock);
>  
> @@ -1287,6 +1299,14 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Deassert the reset control */
> +	ret = reset_control_deassert(priv->rst);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			"Failed to deassert the reset control\n");

Missing alignment.



Best regards,
Krzysztof


