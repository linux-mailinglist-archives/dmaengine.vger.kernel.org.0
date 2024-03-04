Return-Path: <dmaengine+bounces-1251-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5368870768
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 17:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122231C20A0D
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14834CDFB;
	Mon,  4 Mar 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2QBJFWx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74411DDE9;
	Mon,  4 Mar 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570665; cv=none; b=Coyc81wjbHkFBNUfqsbY0xgTyqfVRivo20fyVpsbCJhzAb0vpQSlTGD8B5j/t+5pkV8Uk5pnQWFbebAVfz/5CnPWGOJ47J2vyAkCy408S+NQsq6MtZewDBa2wwOPRDpkZZeHvJmLBTSwzPTbjgL4zymI22xyxycMJW2ZkO0XejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570665; c=relaxed/simple;
	bh=WOnO9JPDwy/Qr4hBOGiy3niCuOWp/MDBx/XySwl/3GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVjfnyFJZ9kmzpc/rrBHbvpnhe8zBz1CZ4hdmnx2zRKz8Y2EZdEAXQSXmfojO1T+/soBjJRhXWv+95IADFirR/CtTka7J3EZglDiiRpilN7kYBCuHbtIQDOctrLRx+/pj1HLf41/PgY4C7Tqmqdxhxhj7s9JzjblyNhnR0BzNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2QBJFWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2201BC433C7;
	Mon,  4 Mar 2024 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709570665;
	bh=WOnO9JPDwy/Qr4hBOGiy3niCuOWp/MDBx/XySwl/3GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2QBJFWxCzebsWpK34GWwHgrIuHa2p0uD0mJy9OGDPrF/F2S5inbL2X1YgyV+nqBt
	 hXlNyJIqMw2h7m69oFFnh/GiRj7jpsXRRU+2QhIOhQ/zfv3ptecIdyaiUxLcYGWFL8
	 6b62WOwl3L8e9RX5Z6PsBoI9PkuUnWAu4JBmjay7ZEk6c4smNVY1UWXv16pRmD9wfc
	 zDS1+KZPtKdUJhUocFa9Id5Ol9dGS211WwXB1yHoETngI5Yr1hmKtAOUXWhQrz1SZ0
	 mE3RSGzvu/QKW5Naf54cDX3nlpUEVJFdgQIDdSqbSRH2a9fnZDDjceX/tmnuCf+8Ck
	 CBDsOPhE7htHA==
Date: Mon, 4 Mar 2024 10:44:23 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Message-ID: <20240304164423.GA626742-robh@kernel.org>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
 <20240229-8ulp_edma-v2-4-9d12f883c8f7@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-8ulp_edma-v2-4-9d12f883c8f7@nxp.com>

On Thu, Feb 29, 2024 at 03:58:10PM -0500, Frank Li wrote:
> From: Joy Zou <joy.zou@nxp.com>
> 
> Introduce the compatible string 'fsl,imx8ulp-edma' to enable support for
> the i.MX8ULP's eDMA, alongside adjusting the clock numbering. The i.MX8ULP
> eDMA architecture features one clock for each DMA channel and an additional
> clock for the core controller. Given a maximum of 32 DMA channels, the
> maximum clock number consequently increases to 33.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml          | 26 ++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index aa51d278cb67b..55cce79c759f8 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -23,6 +23,7 @@ properties:
>            - fsl,imx7ulp-edma
>            - fsl,imx8qm-adma
>            - fsl,imx8qm-edma
> +          - fsl,imx8ulp-edma
>            - fsl,imx93-edma3
>            - fsl,imx93-edma4
>            - fsl,imx95-edma5
> @@ -53,11 +54,11 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 33
>  
>    clock-names:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 33
>  
>    big-endian:
>      description: |
> @@ -108,6 +109,7 @@ allOf:
>        properties:
>          clocks:
>            minItems: 2
> +          maxItems: 2
>          clock-names:
>            items:
>              - const: dmamux0
> @@ -136,6 +138,7 @@ allOf:
>        properties:
>          clock:
>            minItems: 2
> +          maxItems: 2
>          clock-names:
>            items:
>              - const: dma
> @@ -151,6 +154,25 @@ allOf:
>          dma-channels:
>            const: 32
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8ulp-edma
> +    then:
> +      properties:
> +        clock:

clocks

> +          maxItems: 33

That is already the max. I think you want 'minItems: 33' here.

> +        clock-names:
> +          items:
> +            - const: dma
> +            - pattern: "^CH[0-31]-clk$"

'-clk' is redundant. [0-31] is not how you do a range of numbers with 
regex. 

This doesn't cover clocks 3-33. Not a great way to express in 
json-schema, but this should do it:

allOf:
  - items:
      - const: dma
  - items:
      oneOf:
        - const: dma
        - pattern: "^ch([0-9]|[1-2][0-9]|[3[01])$"

That doesn't enforce the order of 'chN' entries though. Probably good 
enough.


> +        interrupt-names: false
> +        interrupts:
> +          maxItems: 32

minItems

> +        "#dma-cells":
> +          const: 3

Is what is in each cell defined somewhere? If not, you need a 
description with those details.

Rob

