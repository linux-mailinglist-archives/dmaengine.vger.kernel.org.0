Return-Path: <dmaengine+bounces-7270-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED86C75C23
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 18:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC735DF15
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3B36D4F8;
	Thu, 20 Nov 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3BbXSQw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6C36D4F5;
	Thu, 20 Nov 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660171; cv=none; b=CvsXzJaJwl2q0eEASaDW4PRmY0KSh+gwlLtuCuLWirqRxE6hThAHiCjKxrpe/Bls4BRnukb+4lcbKXtdCPsMmHrAkMwqKlg2PP4xIJjCeCxM1VRSv1IYaum3SQoZ3pQsy2cDipIZJiaE982UQHQEXGIVEd43fj8QskIb4/pkZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660171; c=relaxed/simple;
	bh=IrQAo8kxBFEzbPGINwZtmpudrkpNPX48K+pwx2p+eCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU3QlfZ7tec8AwgPZooBW1wK97uHC2tDVfk6B67Di1f6vTuvZHgXpJZlAjEIs+I8gHDZGc7+KTjCe4nwWCXJiHmhfIy1OBG/XNDlXcwED4k+BgomLT7wF0NVR6c4DWGIhIxn22514QCHjlyb0P0f4aAjQOJS+0sWD3JbKt+pbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3BbXSQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CBCC4CEF1;
	Thu, 20 Nov 2025 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763660170;
	bh=IrQAo8kxBFEzbPGINwZtmpudrkpNPX48K+pwx2p+eCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3BbXSQwnSmzTnta2rvo+HsOWUGNdZzTsQEFmCTVjcdrCRoREo2/i4h5nB5X0RDq2
	 vQr4MH3OM8iVnWS9wmCZGpv24dTmGdzYFgU1mccdGO3ZkA2JTD9InimGuvfa0ac767
	 mLZ3n6OikGo+kQkBntqFbgrP8N3hVCr31xs7vGYTfP+Jl4UuyIgNLC4MipbgAniH1s
	 5hRPfxCv2v4r+OUiYSWUwY09yHTKf/SdcGvRkod/upSFPZEQTUlfPW+G321I7E5E90
	 pjR5Ax8hytT9E+2DsdrOr3Wq0UomcjAjQnV2unb2k3CM9bQsqvM8o847mUGxf9ksHT
	 n/OBNuExOdtOQ==
Date: Thu, 20 Nov 2025 11:36:08 -0600
From: Rob Herring <robh@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add compatible
 string for Agilex5
Message-ID: <20251120173608.GA1582568-robh@kernel.org>
References: <cover.1763598785.git.khairul.anuar.romli@altera.com>
 <bd19d05233cb095c097f0274a9c13159af34543b.1763598785.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd19d05233cb095c097f0274a9c13159af34543b.1763598785.git.khairul.anuar.romli@altera.com>

On Thu, Nov 20, 2025 at 07:31:10PM +0800, Khairul Anuar Romli wrote:
> The address bus on Agilex5 is limited to 40 bits. When SMMU is enable this
> will cause address truncation and translation faults. Hence introducing
> "altr,agilex5-axi-dma" to enable platform specific configuration to
> configure the dma addressable bit mask.

That's likely a bus limitation, not an IP limitation. So that should be 
handled with dma-ranges.

However, adding a specific compatible is perfectly fine.

> 
> Add a fallback capability for the compatible property to allow driver to
> probe and initialize with a newly added compatible string without requiring
> additional entry in the driver.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
>  .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index a393a33c8908..db89ebf2b006 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -17,11 +17,15 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - snps,axi-dma-1.01a
> -      - intel,kmb-axi-dma
> -      - starfive,jh7110-axi-dma
> -      - starfive,jh8100-axi-dma
> +    oneOf:
> +      - enum:
> +          - snps,axi-dma-1.01a
> +          - intel,kmb-axi-dma
> +          - starfive,jh7110-axi-dma
> +          - starfive,jh8100-axi-dma
> +      - items:
> +          - const: altr,agilex5-axi-dma
> +          - const: snps,axi-dma-1.01a
>  
>    reg:
>      minItems: 1
> -- 
> 2.43.7
> 

