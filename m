Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA3248BE8
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgHRQrV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 12:47:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34604 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgHRQrV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 12:47:21 -0400
Received: by mail-io1-f67.google.com with SMTP id q75so21913968iod.1;
        Tue, 18 Aug 2020 09:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NSMYlwO+VfOjU0V+XqYxs1ZxBo2QTZMze+8ZyPk+OD4=;
        b=V+NtyK3eAudF8wYQU1uFw42+UdWnOK/oEsu0sEi7anYD2Q+18EQ7B506ZvlZdqEfCJ
         o4Sg2Sp+UP7nBL1ogjtOhdiSHuxKUp+EB+jzaonIVkv2uuGcxcvu6vF34n+GTu9z7ZNh
         k+izg2TtCrtMjvfko2agkPbCl+yRvEhhaIp+8C/xCiIgvqRwYO1HMFxf0dbx/AbIfEMt
         tF/zlN5Yf8FNaePRt+s8F5Pj/KJupbdefR3I+rH+hRRLouEfleAPFyKeFySiPqkq/jC/
         UMtnvtdsfGmqoGk8mtmcmG6kn2a9yJ5p92LpH34nXCbHuShDObVXITD6io3zlRWiIEuQ
         GcRw==
X-Gm-Message-State: AOAM5336/2eY93iJDAj5RrBB0DPFjdHeUdj07zqOvQJyrbOGHeCgBhIN
        w4w6rXd2gDfZK+iN9fq7BsdkMsr64Q==
X-Google-Smtp-Source: ABdhPJzvleVEKri4tZ4vGfAE9bIC48yFrtP5qyVVc1nA+KSvxzO5glyEmDkdprx9yso4/nfmuslBNQ==
X-Received: by 2002:a05:6638:2604:: with SMTP id m4mr20047427jat.76.1597769239771;
        Tue, 18 Aug 2020 09:47:19 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id s143sm9945032ilc.14.2020.08.18.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:47:19 -0700 (PDT)
Received: (nullmailer pid 3601369 invoked by uid 1000);
        Tue, 18 Aug 2020 16:47:18 -0000
Date:   Tue, 18 Aug 2020 10:47:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     EastL Lee <EastL.Lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, vkoul@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, cc.hwang@mediatek.com
Subject: Re: [PATCH v7 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
Message-ID: <20200818164718.GB3596085@bogus>
References: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
 <1597719834-6675-2-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597719834-6675-2-git-send-email-EastL.Lee@mediatek.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 18, 2020 at 11:03:51AM +0800, EastL Lee wrote:
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6779 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-cqdma.yaml         | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> new file mode 100644
> index 0000000..fe03081
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/mtk-cqdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Command-Queue DMA controller Device Tree Binding
> +
> +maintainers:
> +  - EastL Lee <EastL.Lee@mediatek.com>
> +
> +description:
> +  MediaTek Command-Queue DMA controller (CQDMA) on Mediatek SoC
> +  is dedicated to memory-to-memory transfer through queue based
> +  descriptor management.
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt6765-cqdma
> +      - const: mediatek,mt6779-cqdma

Use enum instead of oneOf+const.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 5
> +    description:
> +        A base address of MediaTek Command-Queue DMA controller,
> +        a channel will have a set of base address.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 5
> +    description:
> +        A interrupt number of MediaTek Command-Queue DMA controller,
> +        one interrupt number per dma-channels.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: cqdma
> +
> +  dma-channels:
> +    $ref: /schemas/types.yaml#definitions/uint32

Common properties already have a type definition.

> +    description:
> +      Number of DMA channels supported by MediaTek Command-Queue DMA
> +      controller, support up to five.
> +    items:

Not an array, so drop 'items'.

> +      minimum: 1
> +      maximum: 5
> +
> +  dma-requests:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Number of DMA request (virtual channel) supported by MediaTek
> +      Command-Queue DMA controller, support up to 32.
> +    items:
> +      minimum: 1
> +      maximum: 32

Same issues here.

> +
> +required:
> +  - "#dma-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dma-channel-mask

Need to list in properties to fix the check error:

dma-channel-mask: true

> +  - dma-channels
> +  - dma-requests
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt6779-clk.h>
> +    cqdma: dma-controller@10212000 {
> +        compatible = "mediatek,mt6779-cqdma";
> +        reg = <0x10212000 0x80>,
> +            <0x10212080 0x80>,
> +            <0x10212100 0x80>;
> +        interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>,
> +            <GIC_SPI 140 IRQ_TYPE_LEVEL_LOW>,
> +            <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&infracfg_ao CLK_INFRA_CQ_DMA>;
> +        clock-names = "cqdma";
> +        dma-channel-mask = <0x3f>;
> +        dma-channels = <3>;
> +        dma-requests = <32>;
> +        #dma-cells = <1>;
> +    };
> +
> +...
> -- 
> 1.9.1
