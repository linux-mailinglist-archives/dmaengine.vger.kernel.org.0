Return-Path: <dmaengine+bounces-195-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5AC7F5A97
	for <lists+dmaengine@lfdr.de>; Thu, 23 Nov 2023 09:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B06C1C20D7D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Nov 2023 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187CD1C2BE;
	Thu, 23 Nov 2023 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dok34HXL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDE1C29E;
	Thu, 23 Nov 2023 08:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C12C433C7;
	Thu, 23 Nov 2023 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700729557;
	bh=47dwYDVaeiPguKuVsuNUFtUg+itamYNE9PpBeSw6eZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Dok34HXLZ+G+3ejVRbwl/XzmczoO7tNhMDKk7chx07AehavwPSdHdoze4XWl4IYeO
	 zTaYxQCuPDx29HCAUO7Pi7VF326bsjuFGukoh2/SVYaaWkK3iiD8xB+ow/5Blai+dh
	 bQCnDX03T2to0gao8jfzmh3ptH7/DPsHH+geT73QX8M+A7fAD4tO9jrRVisleuU/6l
	 KOi3KF0IpJJyybrFHQA/DK6pJqiBQpZ7hxSD/9+9npV9SK2t/d2GTl1lnaKQUo7WIl
	 +BnSWu2ojn9Km+fhaLnEV7WbWQZBmaP6zqKZYj6/MGSW9hxYKq/1k9jCT/m+zjPeZO
	 qoHFu5qF55BzA==
Date: Thu, 23 Nov 2023 14:22:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jai Luthra <j-luthra@ti.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: Drop undocumented examples
Message-ID: <ZV8S0WAz+NbYUc84@matsya>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122235050.2966280-1-robh@kernel.org>

On 22-11-23, 16:50, Rob Herring wrote:
> The compatibles "ti,omap-sdma" and "ti,dra7-dma-crossbar" aren't documented
> by a schema which causes warnings:
> 
> Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
> Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']

So instead now we will have undocumented ti-omap-sdma?

Adding Peter and TI folks as well

> As no one has cared to fix them, just drop them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/dma/dma-controller.yaml   | 15 ---------------
>  .../devicetree/bindings/dma/dma-router.yaml       | 11 -----------
>  2 files changed, 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma-controller.yaml b/Documentation/devicetree/bindings/dma/dma-controller.yaml
> index 04d150d4d15d..e6afca558c2d 100644
> --- a/Documentation/devicetree/bindings/dma/dma-controller.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-controller.yaml
> @@ -19,19 +19,4 @@ properties:
>  
>  additionalProperties: true
>  
> -examples:
> -  - |
> -    dma: dma-controller@48000000 {
> -        compatible = "ti,omap-sdma";
> -        reg = <0x48000000 0x1000>;
> -        interrupts = <0 12 0x4>,
> -                     <0 13 0x4>,
> -                     <0 14 0x4>,
> -                     <0 15 0x4>;
> -        #dma-cells = <1>;
> -        dma-channels = <32>;
> -        dma-requests = <127>;
> -        dma-channel-mask = <0xfffe>;
> -    };
> -
>  ...
> diff --git a/Documentation/devicetree/bindings/dma/dma-router.yaml b/Documentation/devicetree/bindings/dma/dma-router.yaml
> index 346fe0fa4460..5ad2febc581e 100644
> --- a/Documentation/devicetree/bindings/dma/dma-router.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-router.yaml
> @@ -40,15 +40,4 @@ required:
>  
>  additionalProperties: true
>  
> -examples:
> -  - |
> -    sdma_xbar: dma-router@4a002b78 {
> -        compatible = "ti,dra7-dma-crossbar";
> -        reg = <0x4a002b78 0xfc>;
> -        #dma-cells = <1>;
> -        dma-requests = <205>;
> -        ti,dma-safe-map = <0>;
> -        dma-masters = <&sdma>;
> -    };
> -
>  ...
> -- 
> 2.42.0

-- 
~Vinod

