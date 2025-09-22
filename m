Return-Path: <dmaengine+bounces-6682-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5FB928C4
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 20:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFB9189976A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 18:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359C317702;
	Mon, 22 Sep 2025 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkkCzNfQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619F2848AC;
	Mon, 22 Sep 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564447; cv=none; b=oTaEfDhRxybahYk/Mzl1qoYOlPiM33zGyuAvU59VITSmkW3iyFpas44wPGPAdwOFNGLHDDttQl7vFEngDtJI7HRCszB8BzRBt0Q587c9CMnxcIxviejDAqE4IaaYN/1ky6Jd0Vvxal6LmhnMmLgju9yjj1SfDH73qJwRWftP5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564447; c=relaxed/simple;
	bh=uvFzp2Q14YjjdsHkQgT7CFuazmFvDLyKCqHiCKbWrcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3eWK953FwzgB48BnTMMcoF+2fMk7+zDdZdcc/RJolnZ9/rVwCSegmc1ujcz+v7Hh5qcGJzWCvmI5Y6g4GHCrDhaVYqeQQ7lAw3H40m8LhcrYRwL6QFKPax5Eq4pnsSv/fTCTzoAHikCa66I0N2kOtZybOlD4JZ+3zkP9+GANDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkkCzNfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD3BC4CEF0;
	Mon, 22 Sep 2025 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758564444;
	bh=uvFzp2Q14YjjdsHkQgT7CFuazmFvDLyKCqHiCKbWrcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkkCzNfQlFnNHoT0PW4A22QavOcXGiyeLD9hFyfqgJ8lFo6UfGrKnHUJylulMERvX
	 UodvRMGEnuH64H6MsefEB+0TkuJtBBkEr10LNkA9OlO5PQSlJkkKnryRJcKY6LLI8O
	 8xz3KqsD7DGUuOuI5WzfpLn6ZcLlVuHQA5D/dLYV5e09f2scM3b6Ba4YEjzfckzJBK
	 /Zn5l3LqyWkTUEV2YnZxSMpf7NOJPhfD/DQ0DAaFxYYWJLA+i0F6fKw/ZGF5AMrvjA
	 0s0HF+1CYjXZsHOHE2J6PyCg10ax0ZWXIlfoWmVlkFf95TMD/IByeWE6jWwn/TINMi
	 g0wad6B7rqGCQ==
Date: Mon, 22 Sep 2025 13:07:23 -0500
From: Rob Herring <robh@kernel.org>
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: dma: Add RDA IFC DMA
Message-ID: <20250922180723.GA547468-robh@kernel.org>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
 <20250919-rda8810pl-mmc-v1-3-d4f08a05ba4d@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-rda8810pl-mmc-v1-3-d4f08a05ba4d@mainlining.org>

On Fri, Sep 19, 2025 at 01:48:43AM +0700, Dang Huynh wrote:
> The Intelligent Flow Controller (IFC) is a scatter/gather DMA
> controller.
> 
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  Documentation/devicetree/bindings/dma/rda,ifc.yaml | 45 ++++++++++++++++++++++
>  include/dt-bindings/dma/rda-ifc.h                  | 28 ++++++++++++++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/rda,ifc.yaml b/Documentation/devicetree/bindings/dma/rda,ifc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..323e1e87cee09cfc7b64bf44bef61e4d1e91afa5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/rda,ifc.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/rda,ifc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RDA Intelligent Flow Controller (IFC)
> +
> +maintainers:
> +  - Dang Huynh <dang.huynh@mainlining.org>
> +
> +description: |

Don't need '|'.

> +  RDA IFC is a DMA controller, it only supports scatter/gather lists.
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rda,8810pl-ifc
> +      - const: rda,ifc
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 1
> +    description:
> +      The cell corresponding to DMA request ID
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma-controller@f0000 {
> +      compatible = "rda,8810pl-ifc", "rda,ifc";
> +      reg = <0xf0000 0x1000>;
> +      #dma-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/dma/rda-ifc.h b/include/dt-bindings/dma/rda-ifc.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..af4bae0542aa71690351e2406d0945a61eff72c1
> --- /dev/null
> +++ b/include/dt-bindings/dma/rda-ifc.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +
> +#ifndef __DT_BINDINGS_DMA_RDA_IFC_H__
> +#define __DT_BINDINGS_DMA_RDA_IFC_H__
> +
> +#define IFC_UART1_TX		0
> +#define IFC_UART1_RX		1
> +#define IFC_UART2_TX		2
> +#define IFC_UART2_RX		3
> +#define IFC_SPI1_TX		4
> +#define IFC_SPI1_RX		5
> +#define IFC_SPI2_TX		6
> +#define IFC_SPI2_RX		7
> +#define IFC_SPI3_TX		8
> +#define IFC_SPI3_RX		9
> +#define IFC_SDMMC1_TX		10
> +#define IFC_SDMMC1_RX		11
> +#define IFC_SDMMC2_TX		12
> +#define IFC_SDMMC2_RX		13
> +#define IFC_SDMMC3_TX		14
> +#define IFC_SDMMC3_RX		15
> +#define IFC_NFSC_TX		16
> +#define IFC_NFSC_RX		17
> +#define IFC_UART3_TX		18
> +#define IFC_UART3_RX		19
> +#define IFC_NO_REQUEST		20

These numbers are defined by the h/w (like IRQ numbers)? If so, drop the 
header. We don't do headers for h/w numbers.

Rob

