Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0459E154D72
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2020 21:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgBFUpn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Feb 2020 15:45:43 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55562 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgBFUpm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Feb 2020 15:45:42 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so488746pjz.5;
        Thu, 06 Feb 2020 12:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQfj0uzbhk9PL5wqDoKeIBKd41MQ1h8voivIlPs9HKc=;
        b=eq+XzsaqERQOwcCshZzAYec2ud6qQJ6e80VLFLiKooJkqgaLPIvHd2CwrQcSzU4ya8
         9P2T0H34tt+P9kw5O4vjBs7Lo1K2SPq1TXBMBIcjF3UruXRG/xMwfFOALscUbSxv8MZE
         pIYw2YaxLQpiCneGOtTDSnJLyGlm9Jt+28sEMqQAirgINql2yNsMRTQZZj8Rmeyka7B7
         RWzR+2HTMan/4IS/m3bDbnWjh3QYFU5H2Ip86eqxUQiN9pSBNzCmlmomkegROKXl43AV
         8D02ezfuXmPiZr5BNL4S2hc/dJ1vuMSVXEwIm5E4Csl489//k5vNSyDGTSBNp/zjG9OP
         5cyw==
X-Gm-Message-State: APjAAAVMLATDNr9+Vd096SBJB4MwMM0WkxWrrGw+G3RDP24wPhp2wxN8
        1NfelBmg2zXxFQ/nqyMK2w==
X-Google-Smtp-Source: APXvYqzSMACQuqwX22lBn2rt4IX37CGDwizLP6s5gsYe5polHbDhnFefNbnnYKXjV0FMspaifpEDqg==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr6788847pjb.44.1581021940411;
        Thu, 06 Feb 2020 12:45:40 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id 4sm284539pfn.90.2020.02.06.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:45:39 -0800 (PST)
Received: (nullmailer pid 24630 invoked by uid 1000);
        Thu, 06 Feb 2020 17:54:58 -0000
Date:   Thu, 6 Feb 2020 17:54:58 +0000
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: dmaengine: Add UniPhier external DMA
 controller bindings
Message-ID: <20200206175458.GA12845@bogus>
References: <1580362048-28455-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1580362048-28455-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580362048-28455-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 30, 2020 at 02:27:27PM +0900, Kunihiko Hayashi wrote:
> Add devicetree binding documentation for external DMA controller
> implemented on Socionext UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/dma/socionext,uniphier-xdmac.yaml     | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> new file mode 100644
> index 00000000..32abf18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/socionext,uniphier-xdmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier external DMA controller
> +
> +description: |
> +  This describes the devicetree bindings for an external DMA engine to perform
> +  memory-to-memory or peripheral-to-memory data transfer capable of supporting
> +  16 channels, implemented in Socionext UniPhier SoCs.
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: socionext,uniphier-xdmac

You can drop 'items' for a single item.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2

You need to say what each entry is:

items:
  - description: ...
  - description: ...

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 2
> +    description: |
> +      DMA request from clients consists of 2 cells:
> +        1. Channel index
> +        2. Transfer request factor number, If no transfer factor, use 0.
> +           The number is SoC-specific, and this should be specified with
> +           relation to the device to use the DMA controller.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    xdmac: dma-controller@5fc10000 {
> +        compatible = "socionext,uniphier-xdmac";
> +        reg = <0x5fc10000 0x1000>, <0x5fc20000 0x800>;
> +        interrupts = <0 188 4>;
> +        #dma-cells = <2>;
> +        dma-channels = <16>;

Not documented. You need at least 'dma-channels: true' to indicate 
you're using this. But you should be able to have some constraints such 
as 'maximum: 16'.

Rob
