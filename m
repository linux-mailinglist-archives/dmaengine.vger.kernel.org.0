Return-Path: <dmaengine+bounces-6686-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B0BB93431
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 22:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67D919059A2
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 20:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA9F2571A5;
	Mon, 22 Sep 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTZUthHX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67624C676;
	Mon, 22 Sep 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574078; cv=none; b=aArl5t0dVdhKumwo/PrGCRSS6la4RUCyQKFpUyqHKD7p8Vgw/MvlseKlKzFM+HkI1S2BknRe9AGws4a2FPlZrF9RSSpMih7EO3cI1UkbS9foXzQq0Lm+KpUFhLh2RlMLSYBPpTaIThPnMLnu7aS/1feoJriNPwBpay5yyYJzTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574078; c=relaxed/simple;
	bh=TGffaL/a1AwXsRo2g8p0Qj75pdptlmyikx5RELula7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfcmV82K3I0Q69X20VzlCnUh3BeTaYhaTtKiiChqs+mVfpEoUwozsembCiPJ6lfpZUTPvGJurRTYEEsDmnEGHE6O6aV2Q5Sx3rB6pGdJCayT9InTVOkDcZFhq824VC9ySzViWUutzEIg5hM/TWA3hV9Hj/ZCUYYQlm0NkcmHmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTZUthHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70920C4CEF0;
	Mon, 22 Sep 2025 20:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758574077;
	bh=TGffaL/a1AwXsRo2g8p0Qj75pdptlmyikx5RELula7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTZUthHXAfXAzGtefWP7IZeJ3vJtSWfBDfpDm8wveQXWtpjc+EQ+Y3XF6vjettdKi
	 U65xc3FwwcapHYICo+BqYYSyAscU2Oqm+GAzahI5tLUO6mZCetVXi98OwOnTzFKyB5
	 hb0DvN7aWJ36yjx5L50kJYRu6dbAHsDmiu7/gG7dUHXHahtqPRV9afI3I1SBUmcUhd
	 Bc2PV7qi2p6h95Ec5iIrzuKMwA1dwYdwD77d69mQk04HKjbwcJBipxGDI8XP7sOx7/
	 F4WngtZ8UPIjioaszV5aSvlqKmSTV6pnxq6XD+RyMTpIigdCq5QzwXW54ZBaJ8pIHo
	 Ji06y3mnG+a7A==
Date: Mon, 22 Sep 2025 15:47:56 -0500
From: Rob Herring <robh@kernel.org>
To: Max Shevchenko <wctrl@proton.me>
Cc: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Long Cheng <long.cheng@mediatek.com>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dma: mediatek,uart-dma: drop
 mediatek,dma-33bits property
Message-ID: <20250922204756.GA1294776-robh@kernel.org>
References: <20250921-uart-apdma-v1-0-107543c7102c@proton.me>
 <20250921-uart-apdma-v1-1-107543c7102c@proton.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-uart-apdma-v1-1-107543c7102c@proton.me>

On Sun, Sep 21, 2025 at 02:03:40PM +0300, Max Shevchenko wrote:
> Many newer SoCs support more than 33 bits for DMA.
> Drop the property in order to switch to the platform data.
> 
> The reference SoCs were taken from the downstream kernel (6.6) for
> the MT6991 SoC.
> 
> Signed-off-by: Max Shevchenko <wctrl@proton.me>
> ---
>  Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> index dab468a88942d694525aa391f695c44d192f0c42..9dfdfe81af7edbe3540e4b757547a5d5e6ae810c 100644
> --- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> @@ -22,12 +22,14 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt2712-uart-dma
> -              - mediatek,mt6795-uart-dma
>                - mediatek,mt8365-uart-dma
>                - mediatek,mt8516-uart-dma
>            - const: mediatek,mt6577-uart-dma
>        - enum:
> -          - mediatek,mt6577-uart-dma
> +          - mediatek,mt6577-uart-dma  # 32 bits
> +          - mediatek,mt6795-uart-dma  # 33 bits

Unless all existing s/w supported mediatek,mt6795-uart-dma, you just 
broke this platform which was relying on the fallback compatible. 

> +          - mediatek,mt6779-uart-dma  # 34 bits
> +          - mediatek,mt6985-uart-dma  # 35 bits
>  
>    reg:
>      minItems: 1
> @@ -56,10 +58,6 @@ properties:
>        Number of virtual channels of the UART APDMA controller
>      maximum: 16
>  
> -  mediatek,dma-33bits:
> -    type: boolean
> -    description: Enable 33-bits UART APDMA support

If this is in use, you need to mark it 'deprecated' instead.

> -
>  required:
>    - compatible
>    - reg
> @@ -116,7 +114,6 @@ examples:
>              dma-requests = <12>;
>              clocks = <&pericfg CLK_PERI_AP_DMA>;
>              clock-names = "apdma";
> -            mediatek,dma-33bits;
>              #dma-cells = <1>;
>          };
>      };
> 
> -- 
> 2.51.0
> 

