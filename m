Return-Path: <dmaengine+bounces-1463-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D58855B6
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 09:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605C9283225
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 08:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE15749F;
	Thu, 21 Mar 2024 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCNKV443"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE337C8FF
	for <dmaengine@vger.kernel.org>; Thu, 21 Mar 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009849; cv=none; b=PkkDD9r5IHSYlHF5V5MuajG34raEP8RhM9IIzwp3sK2XfCrux22OgPb/TM7o/MI1aSuqHHncgTxPTo+08c7KKMrBU15nNFnVVPU2AMU4WVF+TdbBtm34eZDt+ieTOAdmsSBXBxd1WYhFrunKhiBur3EmZe2QzvlWpgqAPkaBYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009849; c=relaxed/simple;
	bh=t1fHw1awRXRQyV+kQOhR60wgkUGvz4lCJwmSxqfqDUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qO5efIn9I5kKLyljZiN+QvI9qlpFFCM0VOonGYVrAFEMDApTA98xMjUxXcYygiR3OIOjI3BfpikLY27uKuVsrp686wewVBb725TQQB4uQmfIgVCy14HCMTvuJRc3gU2nGddy34rRS3QqlmuoO+/XRnmo5L3rlBcMA3+QM6E7oxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCNKV443; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a470c79ef7cso74760566b.0
        for <dmaengine@vger.kernel.org>; Thu, 21 Mar 2024 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711009846; x=1711614646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TrrgpFAClZqcHwsKzwgVOqViRyO3pBZpHR8vfJnAO2o=;
        b=UCNKV443yEjjwAvwV6yJTZMf9sLynmRGruaFlnNGM3jDjuvPQ88za4VOfORan034Kv
         WytDbCGxNd5sLD3nq9Yqxaxch6d6Yl/OrmhS2TtTu9NE/OECAynKGSMzlqtSsU0hp7AN
         Kh5fV/NHb0PHHlroE1S1j983AlUwFpvTHgazgTh5jBXG42+eEwSBnxBUlVnMyN9AVEGF
         cSf9xEUNR/4lhoqog/n4wA2Y8oJd9ZnjUZIypnUzOyyL0OD9A71+W2kdkbWvePlamey+
         AKVIoCuUeWrKgCm8Ilb12Yq2xMDm3yiDinsUT5mbONekQ+tdOTP/or9VnX1LCzGNBl0x
         dnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711009846; x=1711614646;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrrgpFAClZqcHwsKzwgVOqViRyO3pBZpHR8vfJnAO2o=;
        b=vSmhYIy6DxjV0yck8GGTzqQBNqW2iQUKFcA/x9nVj3EoDWVrcG/jYsnvUrUK6GVn82
         8PAp1nX+jP/eUfJhyd2IvqVKJjAzTiScmZZirN6C4pggA+mJvQzVxZk8FUbo9UNcA0XI
         QeVjEzaYWrO1gIr3BiVm2HWi3Z34YDnGCz89Dq3g9/wKfPQD+9Pte8hCGJ3XUTaPedHz
         iPu0rQJKS4urg1ihpiyvdC0N0A59csrWdW2JWcaj8LnyE3OlpCOf923LNPvrgZ2EBp7E
         lyEknggEcGVTbKi81xzl/5VllVeQVcYsxElBXV9JIfumNVrFpVExZYxhtHBvJSZZQ7xj
         D9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWrrH+kl9GXWMo5AbqDYF0CDOxvNiyupxcaQuLLjFz2TRjC6xw0i3dypOndEcqKRR4L6mQPbTKz1rQIL0Ma4+YNOo5HpWAeBVLm
X-Gm-Message-State: AOJu0Ywmr3FKsc4cQBlqYgD6r1Oru6jkmaJx3q5SbeGpph1f3x/G1szb
	lHDp8sNLthM8pMH9YdHxrytygn1dVHLjgOmLDedRO5+/Hrh3DjiNitOjYCuXuSA=
X-Google-Smtp-Source: AGHT+IFPBVTwgh43hcOfmhRh+pY+VSXaZHFqVPGwGydBW4lDZMezjp4+Y0kkgD8hHMpcbEY+kxxmyQ==
X-Received: by 2002:a17:906:81ce:b0:a46:2512:aa4f with SMTP id e14-20020a17090681ce00b00a462512aa4fmr1775361ejx.33.1711009846210;
        Thu, 21 Mar 2024 01:30:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id i26-20020a1709061cda00b00a46baa4723asm4744125ejh.119.2024.03.21.01.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:30:45 -0700 (PDT)
Message-ID: <9074d48f-9bb2-4047-b293-815ab953be98@linaro.org>
Date: Thu, 21 Mar 2024 09:30:43 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: dma: Convert ingenic-pdma doc to YAML
To: bin.yao@ingenic.com, vkoul@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 1587636487@qq.com
References: <20240321080228.24147-1-bin.yao@ingenic.com>
 <20240321080228.24147-2-bin.yao@ingenic.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321080228.24147-2-bin.yao@ingenic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 09:02, bin.yao@ingenic.com wrote:
> From: "bin.yao" <bin.yao@ingenic.com>
> 
> Convert the textual documentation for the Ingenic SoCs PDMA Controller

I don't see any conversion here.

> devicetree binding to YAML.
> 
> Signed-off-by: bin.yao <bin.yao@ingenic.com>

Are you sure this is Latin transliteration of your name? With a dot in
between? Looks like email login...

> ---
>  .../devicetree/bindings/dma/ingenic,pdma.yaml | 67 +++++++++++++++++++
>  include/dt-bindings/dma/ingenic-pdma.h        | 45 +++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
>  create mode 100644 include/dt-bindings/dma/ingenic-pdma.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml b/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
> new file mode 100644
> index 000000000000..290dbf182a01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml


> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ingenic,pdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic SoCs PDMA Controller
> +
> +maintainers:
> +  - bin.yao <bin.yao@ingenic.com>
> +

What is PDMA? Why this is not DMA? Provide description explaining this.

> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ingenic,t33-pdma

There is no such soc like t33 so far. Please point me to SoC/board/other
bindings.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupts-names:
> +    const: pdma

Drop names, not needed.

> +
> +  "#dma-cells":
> +    const: 1
> +
> +  dma-channels:
> +    const: 32

Drop property, not needed.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: gate_pdma

Drop names, not needed.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupts-names
> +  - "#dma-cells"
> +  - dma-channels
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
> +    pdma:dma@13420000 {

Drop label.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> +      compatible = "ingenic,t33-pdma";
> +      reg = <0x13420000 0x10000>;
> +      interrupt-parent = <&intc>;
> +      interrupt-names = "pdma";
> +      interrupts = <10>;
> +      #dma-cells = <0x1>;

That's not hex!

> +      dma-channels = <0x20>;
> +      clocks = <&cgu JZ4780_CLK_PDMA>;
> +      clock-names = "gate_pdma";
> +    };
> +
> diff --git a/include/dt-bindings/dma/ingenic-pdma.h b/include/dt-bindings/dma/ingenic-pdma.h
> new file mode 100644
> index 000000000000..66188d588232
> --- /dev/null
> +++ b/include/dt-bindings/dma/ingenic-pdma.h

Same filename as binding.

> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/*
> + * Copyright (C) 2024 Ingenic Semiconductor Co., Ltd.
> + * Author: bin.yao <bin.yao@ingenic.com>
> + */
> +
> +#ifndef __DT_BINDINGS_INGENIC_PDMA_H__
> +#define __DT_BINDINGS_INGENIC_PDMA_H__
> +
> +/*
> + * Request type numbers for the INGENIC DMA controller.
> + */
> +#define INGENIC_DMA_REQ_AIC_LOOP_RX	0x5

IDs start from 0, not 5. IDs are decimal, not hex.

Best regards,
Krzysztof


