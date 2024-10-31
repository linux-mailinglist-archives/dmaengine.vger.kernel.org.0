Return-Path: <dmaengine+bounces-3665-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B29B826E
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 19:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C136B23D7B
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D81BD515;
	Thu, 31 Oct 2024 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxPbeWLz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DF1EA90;
	Thu, 31 Oct 2024 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398671; cv=none; b=W/rAJY6Zf4CKUrmigbrHpsGKSHwOMG2iYlmnQWAv5/WZxAn2CPWWyjK6RUjHdcmVQEDJdR9vvQkUxczYjuiLLS75pCIATHfgNTNia1xyrMhABqrVdRmQgimu4Ehj8TSWLotnN2s46DMQjjX4Uejs1eKPZnSDAwURPQOu9zP7dVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398671; c=relaxed/simple;
	bh=jvJJQy15udztSTe+99Lr2COkQGC4eOLwJnRCW9vATlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU6Uqjy001w91r7HZ4c0946sv5xNkpW15I8K/+UJnIleHdggwANZn5Ql/B++cD8tX3qY07fexkwt5GdJHnktrKiqJLsuH2Px9ijGRNgMYOGmqQftnTwcwRf8nPkGwaebIaeOpLGgMWHOEmleShDwhWTUEFBq9U1O+kusT6hiO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxPbeWLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA272C4CEC3;
	Thu, 31 Oct 2024 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730398671;
	bh=jvJJQy15udztSTe+99Lr2COkQGC4eOLwJnRCW9vATlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxPbeWLzN8gyS/+5v78ZHxhq1BwhPcdXIdT4Zh5A5OZv6ls+g6zM4mR4On+uD+uu4
	 9XPOu/aAqFS1Uuk8AVpPQ9nAOhOjxWx7I0sDwciNmFELDhT7Lao/VWdDNT+DAc+L1O
	 JSxHBHu0f7Cmk4kBAsZJUnZDAge1+hi+gUIg5ikZ44p3i6DJ/OV30uwnsMZPClNlyJ
	 h+doGxdIEZ5kMZKDFMUOC16cY3J2NfYZutofNqo45IKZDL2ke9Lm3FTLqEDQBso6gs
	 z2lYxXJI4d5msee6FirCMB7hZUtQYMFcRBoz6LVps4NRym3XvqMUNMsjGyxrz0qjwO
	 m6B0zuKX4ZL3w==
Date: Thu, 31 Oct 2024 13:17:49 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 03/10] dt-bindings: dmaengine: Add Allwinner suniv
 F1C100s DMA
Message-ID: <20241031181749.GA1260045-robh@kernel.org>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
 <20241031123538.2582675-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031123538.2582675-3-csokas.bence@prolan.hu>

On Thu, Oct 31, 2024 at 01:35:29PM +0100, Csókás, Bence wrote:
> Add compatible string for Allwinner suniv F1C100s DMA.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/linux-kernel/20241024-recycler-borrowing-5d4296fd4a56@spud/

You don't need a link to Conor's ack.

> [ csokas.bence: Reimplemented Mesih Kilinc's binding in YAML ]
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
>  .../devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
> index 02d5bd035409..9b5180c0a7c4 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
> @@ -22,7 +22,9 @@ properties:
>        number.
>  
>    compatible:
> -    const: allwinner,sun4i-a10-dma
> +    enum:
> +      - allwinner,sun4i-a10-dma
> +      - allwinner,suniv-f1c100s-dma
>  
>    reg:
>      maxItems: 1
> -- 
> 2.34.1
> 
> 

