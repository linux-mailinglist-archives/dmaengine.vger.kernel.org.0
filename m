Return-Path: <dmaengine+bounces-2889-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26429556A3
	for <lists+dmaengine@lfdr.de>; Sat, 17 Aug 2024 11:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689EE282AC6
	for <lists+dmaengine@lfdr.de>; Sat, 17 Aug 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ADF145FEE;
	Sat, 17 Aug 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3cCfnO+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE789145B10;
	Sat, 17 Aug 2024 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723885866; cv=none; b=ij6+ZMLkuJXo1fw5aZi2HnIcKRZKng9MwxQUaCrDVwCeLnIesAs08jkuU3rKPm1UpzuzuYuO6Ag8RMEtpeJDiYv4rxX07+LGoED7feOQ1ZIe3Nwpc8Zl/EJy8iGA1PyOQ3558Vb2VGXbzr4beJqCCy5pQ+AZrOFNgxWyF0qmvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723885866; c=relaxed/simple;
	bh=URvB4JCVzwXoQzNY8U7d4UZOKGZ9b6mGU5yBRP2B/iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clZdykJrKBfVoB+SiBzP7JL0NJzZ9N8ze+sh4iO+RTscl9yCRhYNIwCSq0Qlz2XwZ8g2YSXMM1Yz/yoXlkfcIrr9K/0TV+KkbvtpyARjL8n8mRNeefvr/FONdjlcqerKBgtUklwIa+GVhltzr808BAMLfhNnPlumRHmCuMycy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3cCfnO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7ADC116B1;
	Sat, 17 Aug 2024 09:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723885866;
	bh=URvB4JCVzwXoQzNY8U7d4UZOKGZ9b6mGU5yBRP2B/iw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o3cCfnO+qplvhZJPrkyXFi9rca7iF/+ZIA6Kw4qSDDCWbHNDqXGpNp8BqNklRihdH
	 YHD1PR3SiKc9BurSEAvQw9R7HhgmzoOaR4Qdv1tF/Rz1qDKG6Yz0BGKBTAPhxByMQi
	 8ZIT4BE7DfHAA8z/t5znVnG2Sk+rr0eCCJO+tQG47nCzKpeEO0zoQ9bua9eYRyhXuG
	 VGnAO5Z5g2b9Bhg2hjw+gvkE6Yk1tDC06vl7NSxELh2edJWqly+Z+CUOdiH0XXJyWG
	 FsVpyPF7ftPHxr4yl8nf6xSreqo+6iJZHOp1JwZfCYu7ishTYGOSeU8Oct0gJU2lQq
	 0UkEs3ZcsAvGw==
Message-ID: <72cef34a-acb0-4278-984c-dadd53817b5d@kernel.org>
Date: Sat, 17 Aug 2024 11:10:57 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] crypto: qce - Add support for crypto address
 read
To: Md Sadre Alam <quic_mdalam@quicinc.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, gustavoars@kernel.org,
 u.kleine-koenig@pengutronix.de, kees@kernel.org, agross@kernel.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
 quic_utiwari@quicinc.com
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-5-quic_mdalam@quicinc.com>
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
In-Reply-To: <20240815085725.2740390-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2024 10:57, Md Sadre Alam wrote:
> Get crypto base address from DT. This will use for
> command descriptor support for crypto register r/w
> via BAM/DMA

All your commit messages are oddly wrapped. This does not make reading
it easy...

> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [v2]
> 
> * Addressed all comments from v1
> 
> Change in [v1]
> 
> * Added support to read crypto base address from dt
> 
>  drivers/crypto/qce/core.c | 13 ++++++++++++-
>  drivers/crypto/qce/core.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 28b5fd823827..9b23a948078a 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -192,6 +192,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct qce_device *qce;
> +	struct resource *res;
>  	int ret;
>  
>  	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
> @@ -201,10 +202,16 @@ static int qce_crypto_probe(struct platform_device *pdev)
>  	qce->dev = dev;
>  	platform_set_drvdata(pdev, qce);
>  
> -	qce->base = devm_platform_ioremap_resource(pdev, 0);
> +	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(qce->base))
>  		return PTR_ERR(qce->base);
>  
> +	qce->base_dma = dma_map_resource(dev, res->start,
> +					 resource_size(res),
> +					 DMA_BIDIRECTIONAL, 0);
> +	if (dma_mapping_error(dev, qce->base_dma))
> +		return -ENXIO;
> +
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret < 0)
>  		return ret;

And how do you handle error paths?


> @@ -280,6 +287,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
>  static void qce_crypto_remove(struct platform_device *pdev)
>  {
>  	struct qce_device *qce = platform_get_drvdata(pdev);
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  
>  	tasklet_kill(&qce->done_tasklet);
>  	qce_unregister_algs(qce);
> @@ -287,6 +295,9 @@ static void qce_crypto_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(qce->bus);
>  	clk_disable_unprepare(qce->iface);
>  	clk_disable_unprepare(qce->core);
> +
> +	dma_unmap_resource(&pdev->dev, qce->base_dma, resource_size(res),
> +			   DMA_BIDIRECTIONAL, 0);

If you add code to the remove callback, not adding it to error paths is
suspicious by itself...

Best regards,
Krzysztof


