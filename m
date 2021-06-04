Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3539B0E3
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jun 2021 05:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFDDaY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 23:30:24 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41812 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDDaX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 23:30:23 -0400
Received: by mail-oi1-f175.google.com with SMTP id c3so8439953oic.8
        for <dmaengine@vger.kernel.org>; Thu, 03 Jun 2021 20:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofLA5Yth7cNuIGM6YFGLuq5e5gElaG+msVA631CxO2I=;
        b=uM528HoRNzisbbP1Ciydmknx8eMheK6X+d6E3rFSymcflD7mvtYlMX8p+3OZLkxMS+
         aQg4bL5+kY4XKLbALNfehxg67eEFzpu/twKRRtQxlMbHHr1d8iLxJgtbZqXzIZn9wsKA
         jf3J5tPcWgNnTKTOOiB+0QnWDhxeJ+u73zsFnu7dsxibWXvKcdUtnaNKt9atMtxfXEWK
         8fmtPLQ4rr1iYa/JLWs7dWaxw52R/dOpfDtBvlwnc7ut65sMphdq7gntNT6VYsfxuket
         ZeVgNhVGOIjPZ63VSskpHKw3zIabYe8fddOPme9cXw8nlIBLDuZEhlF9WC7PfQ18Q0xI
         fPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofLA5Yth7cNuIGM6YFGLuq5e5gElaG+msVA631CxO2I=;
        b=SKe00h4wLAlN2yiMl6CxcKUC2K0UBITjDme2E//+T0z9vWijWbJfvPiHPlKvFdOXsf
         U0a8MQ5sdWhJaa/feGPd5arN7pdd7dV9jYMV9dWvYE8zxV50WrIE/FSu9aRvzbIaZVw4
         Ob3TY44q5A2fnuHxVcmriBjTNZhxH7rg8snxaUG+tQ/4ei6XyxzTcpgv4lKskgO9fH7S
         nhx8cp3ARbjhDet5LbDYXi+ZJpLjB0h3mkoAodnxQvu+7fe6S95fj+QT79Y0M9Mw3ZSj
         HZuICDg8eP+nfpwQ6xp9nqTfpqdXlqZCS1epd5Ba/Klxlz4hqoNSlb+e0sQ1pTCPWzPS
         IQzA==
X-Gm-Message-State: AOAM530peIvlJlbhk4H63dpkHFPyoXFK+wouL8Kc19HxPLtlJ7zZfYgO
        HzyIFpAHGOJ2NdBMD1Z8VJ+RjCGiQgMhQugOsulV+w==
X-Google-Smtp-Source: ABdhPJxD8+rFjLez4xtP2gnQcSqIZih5Kb5zZR7kQs9ajpSPJ77foKTuFLdY4J+edKcnDerJJr4PzhoV8pQ+xB7PRrg=
X-Received: by 2002:a05:6808:b15:: with SMTP id s21mr592285oij.40.1622777258224;
 Thu, 03 Jun 2021 20:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-2-bhupesh.sharma@linaro.org> <20210521014316.GA2462277@robh.at.kernel.org>
In-Reply-To: <20210521014316.GA2462277@robh.at.kernel.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 4 Jun 2021 08:57:27 +0530
Message-ID: <CAH=2NtwzFMre_+6LRM_JL+itbG09UuKLtH+Awbv_zK++qns49w@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] dt-bindings: qcom-bam: Convert binding to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Rob,

Thanks for the review and sorry for the late reply.

On Fri, 21 May 2021 at 07:13, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 08:06:44PM +0530, Bhupesh Sharma wrote:
> > Convert Qualcomm BAM DMA devicetree binding to YAML.
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-crypto@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bhupesh.linux@gmail.com
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  .../devicetree/bindings/dma/qcom_bam_dma.txt  | 50 ----------
> >  .../devicetree/bindings/dma/qcom_bam_dma.yaml | 91 +++++++++++++++++++
> >  2 files changed, 91 insertions(+), 50 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> >  create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > deleted file mode 100644
> > index cf5b9e44432c..000000000000
> > --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > +++ /dev/null
> > @@ -1,50 +0,0 @@
> > -QCOM BAM DMA controller
> > -
> > -Required properties:
> > -- compatible: must be one of the following:
> > - * "qcom,bam-v1.4.0" for MSM8974, APQ8074 and APQ8084
> > - * "qcom,bam-v1.3.0" for APQ8064, IPQ8064 and MSM8960
> > - * "qcom,bam-v1.7.0" for MSM8916
> > -- reg: Address range for DMA registers
> > -- interrupts: Should contain the one interrupt shared by all channels
> > -- #dma-cells: must be <1>, the cell in the dmas property of the client device
> > -  represents the channel number
> > -- clocks: required clock
> > -- clock-names: must contain "bam_clk" entry
> > -- qcom,ee : indicates the active Execution Environment identifier (0-7) used in
> > -  the secure world.
> > -- qcom,controlled-remotely : optional, indicates that the bam is controlled by
> > -  remote proccessor i.e. execution environment.
> > -- num-channels : optional, indicates supported number of DMA channels in a
> > -  remotely controlled bam.
> > -- qcom,num-ees : optional, indicates supported number of Execution Environments
> > -  in a remotely controlled bam.
> > -
> > -Example:
> > -
> > -     uart-bam: dma@f9984000 = {
> > -             compatible = "qcom,bam-v1.4.0";
> > -             reg = <0xf9984000 0x15000>;
> > -             interrupts = <0 94 0>;
> > -             clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> > -             clock-names = "bam_clk";
> > -             #dma-cells = <1>;
> > -             qcom,ee = <0>;
> > -     };
> > -
> > -DMA clients must use the format described in the dma.txt file, using a two cell
> > -specifier for each channel.
> > -
> > -Example:
> > -     serial@f991e000 {
> > -             compatible = "qcom,msm-uart";
> > -             reg = <0xf991e000 0x1000>
> > -                     <0xf9944000 0x19000>;
> > -             interrupts = <0 108 0>;
> > -             clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
> > -                     <&gcc GCC_BLSP1_AHB_CLK>;
> > -             clock-names = "core", "iface";
> > -
> > -             dmas = <&uart-bam 0>, <&uart-bam 1>;
> > -             dma-names = "rx", "tx";
> > -     };
> > diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> > new file mode 100644
> > index 000000000000..173e4d7508a6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/qcom_bam_dma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: QCOM BAM DMA controller binding
> > +
> > +maintainers:
> > +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > +
> > +description: |
> > +  This document defines the binding for the BAM DMA controller
> > +  found on Qualcomm parts.
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,bam-v1.4.0
> > +      - qcom,bam-v1.3.0
> > +      - qcom,bam-v1.7.0
>
> Can we keep the SoC association please.

The original bam dma bindings are as per the underlying bam IP
version, so I would prefer that we keep it this way for this series.

Later on I can send a patchset to convert the bam DMA dt-bindings, dts
and driver to work with 'SoC association' instead.

> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Address range of the DMA registers.
>
> Drop description.

Sure.

> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 8
> > +
> > +  clock-names:
> > +    const: bam_clk
>
> This is going to fail if you try more than 1 clock.

Right, currently we have one clock, but I can recheck and make fixes in v4.

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Single interrupt line shared by all channels.
>
> Drop description

Ok.

> > +
> > +  num-channels:
> > +    maxItems: 31
> > +    description: |
> > +      Indicates supported number of DMA channels in a remotely controlled bam.
> > +
> > +  "#dma-cells":
> > +    const: 1
> > +    description: The single cell represents the channel index.
> > +
> > +  qcom,ee:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Indicates the active Execution Environment identifier (0-7)
> > +      used in the secure world.
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +
> > +  qcom,controlled-remotely:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Indicates that the bam is controlled by remote proccessor i.e.
> > +      execution environment.
> > +
> > +  qcom,num-ees:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Indicates supported number of Execution Environments in a
> > +      remotely controlled bam.
>
> 0-2^32 is valid?

Oh, got it. Will fix it in v4.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - "#dma-cells"
> > +  - qcom,ee
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
> > +    dma-controller@f9984000 {
> > +        compatible = "qcom,bam-v1.4.0";
> > +        reg = <0xf9984000 0x15000>;
> > +        interrupts = <0 94 0>;
> > +        clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> > +        clock-names = "bam_clk";
> > +        #dma-cells = <1>;
> > +        qcom,ee = /bits/ 8 <0>;
> > +    };
> > --
> > 2.31.1

Thanks,
Bhupesh
