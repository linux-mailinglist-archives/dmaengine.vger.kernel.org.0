Return-Path: <dmaengine+bounces-1146-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B0F86A978
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 09:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6093E1F21A54
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 08:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F822562A;
	Wed, 28 Feb 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzNR79k1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602225625
	for <dmaengine@vger.kernel.org>; Wed, 28 Feb 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107367; cv=none; b=NHA/dBdLxnvQ7I1UhbvAHGacd3bteGMWcsVaJSf9k4GP5pGzQpUzhAycQrP6ggirBVAod0UAZ4qhCKsP6sOEYhCUi/e0gP+YTpihYxKom0yzgnWfal+1w3ajHjzTHCBmf9HLQek2bKlgE8rP6wJLt9cOa/1cQ8VV4Qn4qf2neRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107367; c=relaxed/simple;
	bh=a/pmd6Q01WSXxZYDQYeL64y3OnNOOXe0fVMyyGWa6Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiICGj4ovF88KiPWXwWmDT/YGeOgstSlg1KmvO431isGceQXX5Q1vXaLKSBg9tO3lKXMtwt2pO4IXmi8UwzWsFJJUSwG4GPdnmaaEiN0B3SGynm3EmQmwQRhFy5yS1C32NkAGwmckZT8GmN96TD9h0Iw041Ryz9gLHRCKa2+yIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wzNR79k1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so3773747a12.3
        for <dmaengine@vger.kernel.org>; Wed, 28 Feb 2024 00:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709107363; x=1709712163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBB3ocy5KB+L4/CkWyT+O/AlDT67FyLTB4OvAIkq0+4=;
        b=wzNR79k1YOdplT81hEnC7O3rv/UjNczYwj/nYhglPNFzhcNrB1Hd6fJbmWJB/Sayuy
         4SbwfUGl4gFI4uCkKJlYpwaUpPzZMwzbtwcAf2/Xm8MXTnKmyTLfJt32nqFV3fKwGhUX
         EsoaWu9ixsYoGknVq2Rx8TsHESdM0EfbAd4fgXhWwi2E31y8ePg1fKkuZE+jkdNhbO4R
         A9KPnIZkflRnZ6LPtex5jENtqhWa7EInJtW8GBR29PRbuFi2vZWJdzx5V53Ht/eWTXv4
         qSuFN0ztk/6Nm9a3bg+HvOuDmUQwa2+Rqw+Bb20vA1ebOMBwz5t0b8UUw1cvwG0V0iMU
         tHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709107363; x=1709712163;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBB3ocy5KB+L4/CkWyT+O/AlDT67FyLTB4OvAIkq0+4=;
        b=QM7tSQKLZJtdgel34eoxIevpV0V9bSD8s4sDW9FZEl64aWJ0QJY7j/OBVkQbZiv9cQ
         t0sVlNRh5XzW2bI9f+jH5C2W9qZG4/iK52ZMXz6mkFwohJwhKJ1KciECjBhzmSN6ORft
         yWZi9Kc3q8d3V3P2oYW2ThpqCO3nNKWA7bkpPuxQRjDqmM1nOJMomDis0eUag6Mrhc6b
         UrZ/BcvnS/TWy8j273ouEJ8/M0iUPGBcywKJc9uEMwPLMlOQUxKGz+5232XjRtus4fm6
         7/ek49Yl1lTmu80Fk5nZjjhY02uGzM8bfV3TDxMZAtcpv8/Ra+hsub4zHs17AgvHca1C
         FAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSX6PbFEDXOAzaHHHw41pI7HndLIpBVt0h5QhwcJl/+cRI02wtfnbV1l1nRfiYbWtmfQSRUpG/WHlzUABM2j9MXxYzGZoSyhbG
X-Gm-Message-State: AOJu0Yx5zr1rFJST5U2MwzapdD/6+lSa9yBsl76M0PtYd49b1JCuXBsN
	qQ2B/Y3wYNJ3FkKs9o6K/EUU59tinmM3iEGCTFuGoascozVvJZeLW67UctZwGuY=
X-Google-Smtp-Source: AGHT+IGx4aaWk+a7VM458C75pSaCOzPoU9KyTuI9mSx4h9po8tehvgZTAbAx4rZQ24zaxbSSNNU9MA==
X-Received: by 2002:aa7:d0ca:0:b0:565:862d:1c58 with SMTP id u10-20020aa7d0ca000000b00565862d1c58mr8844636edo.8.1709107363431;
        Wed, 28 Feb 2024 00:02:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id dj16-20020a05640231b000b00566317ad834sm1510962edb.49.2024.02.28.00.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 00:02:42 -0800 (PST)
Message-ID: <bc828606-3a35-4031-bb62-0d81c426caa4@linaro.org>
Date: Wed, 28 Feb 2024 09:02:40 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: dma: Ingenic: DT bindings for Ingenic
 PDMA
Content-Language: en-US
To: "bin.yao" <bin.yao@ingenic.com>, vkoul@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org, quic_bjorande@quicinc.com,
 rick <rick.tyliu@ingenic.com>
References: <20240228012420.4223-1-bin.yao@ingenic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228012420.4223-1-bin.yao@ingenic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 02:24, bin.yao wrote:
> From: byao <bin.yao@ingenic.com>
> 
> Convert the textual documentation for the Ingenic SoCs PDMA
> Controller devicetree binding to YAML.
> 
> Add a dt-bindings header, and convert the device trees to it.
> 
> Signed-off-by: byao <bin.yao@ingenic.com>
> Signed-off-by: rick <rick.tyliu@ingenic.com>

Use full names.

Except that, nothing here was tested, so limited review follows.

A nit, subject: drop second/last, redundant "DT bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> ---
>  .../devicetree/bindings/dma/ingenic,pdma.yaml | 77 +++++++++++++++++++
>  include/dt-bindings/dma/ingenic-pdma.h        | 51 ++++++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
>  create mode 100644 include/dt-bindings/dma/ingenic-pdma.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml b/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
> new file mode 100644
> index 000000000000..b3f3a8f0b813
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ingenic,dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic SoCs DMA Controller DT bindings
> +
> +maintainers:
> +  - byao <bin.yao@ingenic.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop

> +      - enum:
> +          - ingenic,m200-pdma
> +          - ingenic,x1000-pdma
> +          - ingenic,t40-pdma
> +          - ingenic,t41-pdma
> +          - ingenic,t33-pdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-parent:
> +    maxItems: 1

Drop interrupts-parent

> +
> +  interrupts-names:
> +    items:
> +      - const: pdam
> +      - const: pdmam
> +
> +  interrupts:
> +    maxItems: 1

Nope, you have two items. Test your DTS.

> +
> +  dma-channels:
> +    const: 32
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: gate_pdma
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-parent
> +  - interrupt-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ingenic,t33-cgu.h>
> +    pdma:dma@13420000 {
> +      compatible = "ingenic,t33-pdma";
> +      reg = <0x13420000 0x10000>;
> +      interrupt-parent = <&plic>;
> +      interrupt-names = "pdma", "pdmam";
> +      interrupts = <10 61>;
> +      #dma-channels = <0x20>;
> +      #dma-cells = <0x1>;
> +      clocks = <&cgu T33_CLK_DMA>;
> +      clock-names = "gate_pdma";
> +    };
> +
> diff --git a/include/dt-bindings/dma/ingenic-pdma.h b/include/dt-bindings/dma/ingenic-pdma.h
> new file mode 100644
> index 000000000000..99c871bc0ea8
> --- /dev/null
> +++ b/include/dt-bindings/dma/ingenic-pdma.h

Same filename as binding.

> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +
> +#ifndef __INGENIC_PDMA_H__
> +#define __INGENIC_PDMA_H__
> +
> +#define INGENIC_DMA_REQ_AIC_LOOP_RX	0x5

Indexes start from 0. If these are not indexes, then these are neither
suitable for bindings. Hex for sure is questionable.

> +#define INGENIC_DMA_REQ_AIC_TX		0x6
> +#define INGENIC_DMA_REQ_AIC_F_RX	0x7
> +#define INGENIC_DMA_REQ_AUTO_TX		0x8
> +#define INGENIC_DMA_REQ_SADC_RX		0x9
> +#define INGENIC_DMA_REQ_UART5_TX	0xa
> +#define INGENIC_DMA_REQ_UART5_RX	0xb
> +#define INGENIC_DMA_REQ_UART4_TX	0xc
> +#define INGENIC_DMA_REQ_UART4_RX	0xd
> +#define INGENIC_DMA_REQ_UART3_TX	0xe
> +#define INGENIC_DMA_REQ_UART3_RX	0xf
> +#define INGENIC_DMA_REQ_UART2_TX	0x10
> +#define INGENIC_DMA_REQ_UART2_RX	0x11
> +#define INGENIC_DMA_REQ_UART1_TX	0x12
> +#define INGENIC_DMA_REQ_UART1_RX	0x13
> +#define INGENIC_DMA_REQ_UART0_TX	0x14
> +#define INGENIC_DMA_REQ_UART0_RX	0x15
> +#define INGENIC_DMA_REQ_SSI0_TX		0x16
> +#define INGENIC_DMA_REQ_SSI0_RX		0x17
> +#define INGENIC_DMA_REQ_SSI1_TX		0x18
> +#define INGENIC_DMA_REQ_SSI1_RX		0x19
> +#define INGENIC_DMA_REQ_SLV_TX		0x1a
> +#define INGENIC_DMA_REQ_SLV_RX		0x1b
> +#define INGENIC_DMA_REQ_I2C0_TX		0x24
> +#define INGENIC_DMA_REQ_I2C0_RX		0x25
> +#define INGENIC_DMA_REQ_I2C1_TX		0x26
> +#define INGENIC_DMA_REQ_I2C1_RX		0x27
> +#define INGENIC_DMA_REQ_I2C2_TX		0x28
> +#define INGENIC_DMA_REQ_I2C2_RX		0x29
> +#define INGENIC_DMA_REQ_DES_TX		0x2e
> +#define INGENIC_DMA_REQ_DES_RX		0x2f
> +
> +#define INGENIC_DMA_TYPE_REQ_MSK	0xff

Nope, not a binding.

> +#define INGENIC_DMA_TYPE_CH_SFT		8
> +#define INGENIC_DMA_TYPE_CH_MSK		(0xff << INGENIC_DMA_TYPE_CH_SFT)

Drop entire file.

Best regards,
Krzysztof


