Return-Path: <dmaengine+bounces-859-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 289A6840CAB
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE991F280A0
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C32157041;
	Mon, 29 Jan 2024 17:00:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC8157055;
	Mon, 29 Jan 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547601; cv=none; b=WsV3s1q9uaKTBlWg+9HmEwTk/AAY8sFkF4nC1RkpOCYyu3315RJRp8azDDpEYG32ETvKXnrSb0C73R6yleqD2olDxL6U+ZsRl/CrUcRa3Ncb7V5dDPPuDoJQfRSJmGHnXTR25tARJ+3IDCfCDWuvm+gu1MNpUFWfSvwFOVZRe/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547601; c=relaxed/simple;
	bh=6AlW8GfU0yXdn2MsLvTWS4FUIIv27Mo017RHrFWdyIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Er4EX8YHr8VHw+phdM576syWetaOizxeb3k8i53g5C2qYG2O4B9WagxIfLjV2Gy5Rk0ws6cJlmG9BPdg0YCEe+APUxGSszYhlRACQwx6qBwdlYub7Cp7+pPnOjf47ZRnChc5wsG4CeMs3keqNEWPTzImCtvhoetclY7BmvoWjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFF1CDA7;
	Mon, 29 Jan 2024 09:00:41 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A3213F738;
	Mon, 29 Jan 2024 08:59:55 -0800 (PST)
Date: Mon, 29 Jan 2024 16:59:52 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] dt-bindings: dma: allwinner,sun50i-a64-dma: Add
 compatible for H616
Message-ID: <20240129165952.0dec633e@donnerap.manchester.arm.com>
In-Reply-To: <20240127163247.384439-5-wens@kernel.org>
References: <20240127163247.384439-1-wens@kernel.org>
	<20240127163247.384439-5-wens@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 00:32:44 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi,

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The DMA controllers found on the H616 and H618 are the same as the one
> found on the A100. The only difference is the DMA endpoint (DRQ) layout.
> 
> Since the number of channels and endpoints are described with additional
> generic properties, just add a new H616-specific compatible string and
> fallback to the A100 one.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Looks good, A100 is the right fallback string. dt-binding_check passed for
me.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> Changes since v1:
> - Switch to "contains" for if-properties statement
> - Fall back to A100 instead of H6
> 
>  .../bindings/dma/allwinner,sun50i-a64-dma.yaml       | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> index ec2d7a789ffe..0f2501f72cca 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> @@ -28,6 +28,9 @@ properties:
>        - items:
>            - const: allwinner,sun8i-r40-dma
>            - const: allwinner,sun50i-a64-dma
> +      - items:
> +          - const: allwinner,sun50i-h616-dma
> +          - const: allwinner,sun50i-a100-dma
>  
>    reg:
>      maxItems: 1
> @@ -59,10 +62,11 @@ required:
>  if:
>    properties:
>      compatible:
> -      enum:
> -        - allwinner,sun20i-d1-dma
> -        - allwinner,sun50i-a100-dma
> -        - allwinner,sun50i-h6-dma
> +      contains:
> +        enum:
> +          - allwinner,sun20i-d1-dma
> +          - allwinner,sun50i-a100-dma
> +          - allwinner,sun50i-h6-dma
>  
>  then:
>    properties:


