Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5F6BF37A
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 22:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCQVFy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 17:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCQVFx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 17:05:53 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C955D31BE0;
        Fri, 17 Mar 2023 14:05:45 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id b5so2901949iow.0;
        Fri, 17 Mar 2023 14:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679087145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NecYJUuy8uaK/tVQe/yH+/ckF6yra+2Pis8jiBooqI=;
        b=EEkQpikadJ0do2Eio39rYWjS4wGEOJsBkyfNqhbrnXf13h433OUy4Ra+EjG4ROY5zn
         f8Sj7SFcDUUJukOFDcLd9ldhETd8W3Z9rBS9LmAsNrg5zRCFvqkVNY+il/Bv5TcDqwxR
         scU/SNz9A56QmjveB+cFDmzg3AyXIPhzECRReSS/5N+CfC89PcguczLSBUT7DWjWwH0Z
         PCxT7bt/aJKFGzqu3PId/QI3vma+/RIExQwWQ0Uovi4Mn1mELH2efiIqIhrPK59gJp6G
         a0ReyBwmvwfT2DMhFHXHEWz/G5FuGLQPQFAH+099Dx+KhbGhsz61637LprUjcvTyUFXB
         BtlQ==
X-Gm-Message-State: AO0yUKWP6KKS1+aTz35hEuyPoP1AQY7STYyxOJ4WwFTZV27gXKw14q8j
        TQEP3NhHpT/VOna51n4Iqw==
X-Google-Smtp-Source: AK7set8xIMQuQwJ6PDoZs6XtPl1fgkJczzCoyKvb4BiewQRvHyAeYv7nOvtmHPPFiuOhaMQjb5HJ4w==
X-Received: by 2002:a6b:e216:0:b0:753:121f:72a7 with SMTP id z22-20020a6be216000000b00753121f72a7mr23373ioc.8.1679087145050;
        Fri, 17 Mar 2023 14:05:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id cs6-20020a056638470600b003e9e5e1aacasm1005332jab.143.2023.03.17.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:05:44 -0700 (PDT)
Received: (nullmailer pid 2804141 invoked by uid 1000);
        Fri, 17 Mar 2023 21:05:42 -0000
Date:   Fri, 17 Mar 2023 16:05:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pmenzel@molgen.mpg.de,
        ilpo.jarvinen@linux.intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] dt-bindings: dmaengine: Add AST2600 UDMA bindings
Message-ID: <20230317210542.GB2790192-robh@kernel.org>
References: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
 <20230314021817.30446-3-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314021817.30446-3-chiawei_wang@aspeedtech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 14, 2023 at 10:18:14AM +0800, Chia-Wei Wang wrote:
> Add the dmaengine bindings for the UART DMA engine of Aspeed AST2600 SoC.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../bindings/dma/aspeed,ast2600-udma.yaml     | 56 +++++++++++++++++++
>  include/dt-bindings/dma/ast2600-udma.h        | 40 +++++++++++++
>  2 files changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
>  create mode 100644 include/dt-bindings/dma/ast2600-udma.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml b/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
> new file mode 100644
> index 000000000000..f92e06ac9f39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/aspeed,ast2600-udma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed AST2600 UART DMA controller
> +
> +maintainers:
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +
> +description: |

Don't need '|'

> +  The Aspeed AST2600 UDMA controller provides direct memory access capabilities
> +  for the NS16550A-compatible UART devices inside AST2600 SoCs. UDMA supports 28
> +  DMA channels and each UART device has its dedicated pair of TX and RX channels.
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"

Drop quotes

> +
> +properties:
> +  compatible:
> +    const: aspeed,ast2600-udma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  dma-channels:
> +    maximum: 28
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +  - dma-channels
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    udma: dma-controller@1e79e000 {

Drop unused label.

> +        compatible = "aspeed,ast2600-udma";
> +        reg = <0x1e79e000 0x1000>;
> +        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +        dma-channels = <28>;
> +        #dma-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/dma/ast2600-udma.h b/include/dt-bindings/dma/ast2600-udma.h
> new file mode 100644
> index 000000000000..0b92035b94f1
> --- /dev/null
> +++ b/include/dt-bindings/dma/ast2600-udma.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Headers should be dual licensed.

However, similar to interrupts, we don't normally do defines for DMA 
request numbers. It's only when we make up the numbering (e.g. clock 
ids).

Rob
