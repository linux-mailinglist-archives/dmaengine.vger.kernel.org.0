Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C777528C01F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgJLS5k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 14:57:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35964 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgJLS5k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Oct 2020 14:57:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id 32so3598551otm.3;
        Mon, 12 Oct 2020 11:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ddIV4HQN24CafNYgtjScHKXn58YYBc4ENbBdZztl7Po=;
        b=hW7NKjPA9XmDVlbiDZ1SzZSr2fz9arPeXwoM6C4WyojbDOlmGpgEnA9bH+EOF2CZl6
         1rOP+iwS24Wz6dH22xVMUXMi+06Qzwzg3LL1YXv6hf5nLc9nuXTSO2QhO/A3tG/Wl+kK
         qVOjp2W03a1DJTWfRv58rYuj6iDXMICFyEPZigqFCVVoZpYmmQB7eb8/DB0P/eLAhBrx
         OSDMbGqMAkoIXaTu+LEBCzkY4aq5gOSG9mGeEvG4VaNzaAHwPDTghPTHp1NpO5DLivl2
         KKGZ7rflgmGEay4FjBYZ+6v8nafGaLbqlw8itWDqQCKj3mEwmIVIr3+gzwGp8j6N6v6F
         FxHQ==
X-Gm-Message-State: AOAM532LzNDepTE0LNhwz8YUoHqXm50RSD6bb5hbLOr2O8d5EwkgcMKE
        H9RxgiFMKF48/kztPruufe/aPS5RBbFO
X-Google-Smtp-Source: ABdhPJw4IVll4ULsuJ5LXi+mVD/6wjOwgXKHePUC517QdcqQleAXdmNv1FWoCkkbRyTDphEGrvoV1g==
X-Received: by 2002:a05:6830:1e19:: with SMTP id s25mr18618580otr.294.1602529058807;
        Mon, 12 Oct 2020 11:57:38 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 81sm9006727oti.79.2020.10.12.11.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:57:38 -0700 (PDT)
Received: (nullmailer pid 1908487 invoked by uid 1000);
        Mon, 12 Oct 2020 18:57:37 -0000
Date:   Mon, 12 Oct 2020 13:57:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: dmaengine: Document qcom,gpi dma
 binding
Message-ID: <20201012185737.GA1905980@bogus>
References: <20201008123151.764238-1-vkoul@kernel.org>
 <20201008123151.764238-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008123151.764238-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 08, 2020 at 06:01:49PM +0530, Vinod Koul wrote:
> Add devicetree binding documentation for GPI DMA controller
> implemented on Qualcomm SoCs
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/dma/qcom,gpi.yaml     | 86 +++++++++++++++++++
>  include/dt-bindings/dma/qcom-gpi.h            | 11 +++
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>  create mode 100644 include/dt-bindings/dma/qcom-gpi.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> new file mode 100644
> index 000000000000..4470c1b2fd6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/qcom,gpi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc GPI DMA controller
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description: |
> +  QCOM GPI DMA controller provides DMA capabilities for
> +  peripheral buses such as I2C, UART, and SPI.
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sdm845-gpi-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt lines for each GPI instance
> +    maxItems: 13
> +
> +  "#dma-cells":
> +    const: 3
> +    description: >
> +      DMA clients must use the format described in dma.txt, giving a phandle
> +      to the DMA controller plus the following 3 integer cells:
> +      - channel: if set to 0xffffffff, any available channel will be allocated
> +        for the client. Otherwise, the exact channel specified will be used.
> +      - seid: serial id of the client as defined in the SoC documentation.
> +      - client: type of the client as defined in dt-bindings/dma/qcom-gpi.h
> +
> +  iommus:
> +    maxItems: 1
> +
> +  dma-channels:
> +    maximum: 31
> +
> +  dma-channel-mask:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +  - iommus
> +  - dma-channels
> +  - dma-channel-mask

additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/dma/qcom-gpi.h>
> +    gpi_dma0: dma-controller@800000 {
> +        compatible = "qcom,gpi-dma";
> +        #dma-cells = <3>;
> +        reg = <0x00800000 0x60000>;
> +        iommus = <&apps_smmu 0x0016 0x0>;
> +        dma-channels = <13>;
> +        dma-channel-mask = <0xfa>;
> +        interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/dma/qcom-gpi.h b/include/dt-bindings/dma/qcom-gpi.h
> new file mode 100644
> index 000000000000..71f79eb7614c
> --- /dev/null
> +++ b/include/dt-bindings/dma/qcom-gpi.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2020, Linaro Ltd.  */
> +
> +#ifndef __DT_BINDINGS_DMA_QCOM_GPI_H__
> +#define __DT_BINDINGS_DMA_QCOM_GPI_H__
> +
> +#define QCOM_GPI_SPI		1
> +#define QCOM_GPI_UART		2
> +#define QCOM_GPI_I2C		3
> +
> +#endif /* __DT_BINDINGS_DMA_QCOM_GPI_H__ */
> -- 
> 2.26.2
> 
