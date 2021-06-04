Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D8C39B106
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jun 2021 05:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFDDm2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 23:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhFDDm2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 23:42:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F1C061761
        for <dmaengine@vger.kernel.org>; Thu,  3 Jun 2021 20:40:42 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id f30so7187679oij.7
        for <dmaengine@vger.kernel.org>; Thu, 03 Jun 2021 20:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXrwn8O7Z9ra0HSXrktp1Pf6RqZk04u/zgrpbaACAm8=;
        b=nu4CkeZLjtParnluQs2D85/oiP8BC4dC3lLEdgDCmuPqmOoDjtnbi5bZ2kX+cTNrdP
         5vJhubTFFMdk3K3XsKuYpd5XKB9OQ4UOqliuEXAqHBZyenB3qS1qpC19sZUDpCtDyemt
         k2Fzh60Ct3oOhXi1kPsoomYf1tzWiVESNrgSWAAWggyNKEhGOXvUFp8l8U4OvALmiXR9
         l3OpdE5s7u9lg9XVAx/D29OLWmfhnOd7zF8mRJ5BXubvtk+Ryd3xuy5hkvyoXVO5qt/9
         9W/lNpgI5zyjsmhiNS3uor2pqoAQrqYq3qsR0T8lZLk5/FqabuEMTxnl0G+DE5lUflPD
         xfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXrwn8O7Z9ra0HSXrktp1Pf6RqZk04u/zgrpbaACAm8=;
        b=dOr2fcTCmrBblYNQBD/Bn61AKvg0y/3KZrDHISl/+Ss7WyS+zZsnm8H5mHGIacOB78
         +dCXHPkOGlxGXIr10I/1Q5KkOeT+2VA1LleNdQGG5ahIcZgzemSR0o9ejxAkPJvB8Sir
         8+QRy/5n+eY3U9UyyAt7ir02oOyMqoFTcplC9JjSpHj6hAtWegGWhFjnFTQyPeUK7t9k
         vOMk4CM08OYtSJpb9QWvu5LYV5pVA9ZIxixo2K2jfhKebTT7MxKWha7b74jsh0EidiAF
         6ykmhXRZHINm0SeJTpGzHY5nATxWxYmWsgVqnRNIt839e46dBHLn/oOrqQc2oMBZOokp
         8Ojg==
X-Gm-Message-State: AOAM531Qn9zJazojKwvav+vYl3Kb9jnmq8zGfBg2qOrmE1m/pSx4uYb7
        zIdzRsrich3/UWhXmSO8A7bfb0h6YCZAPLBo6NMc+Q==
X-Google-Smtp-Source: ABdhPJwCHeBEjD6JOd6thCiBXSp5CBpsWnXuTWBq89AVfaa1FU5pUZuP18t0YuywoLXf90lWSCMJTdIGpysTNi5zd+Y=
X-Received: by 2002:a05:6808:f0b:: with SMTP id m11mr9216942oiw.12.1622778038637;
 Thu, 03 Jun 2021 20:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-2-bhupesh.sharma@linaro.org> <YKdqd6nreHwCV3te@gerhold.net>
In-Reply-To: <YKdqd6nreHwCV3te@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 4 Jun 2021 09:10:27 +0530
Message-ID: <CAH=2NtxxWx4BWhQ5YEkxKaCnD6qBgfbJm2TBdXH0AAzr+_O2EA@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] dt-bindings: qcom-bam: Convert binding to YAML
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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

Hi Stephan,

Thanks for the review.

On Fri, 21 May 2021 at 13:41, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Hi,
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
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Address range of the DMA registers.
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 8
> > +
> > +  clock-names:
> > +    const: bam_clk
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Single interrupt line shared by all channels.
> > +
> > +  num-channels:
> > +    maxItems: 31
>
> maxItems doesn't seem right here, since num-channels isn't an array.
> Perhaps you meant maximum: 31?
>
> Can you check your bindings on the existing device trees with
> "make dtbs_check" and make sure that only reasonable errors remain?
>
> This fails on pretty much every device tree:
>
> arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: num-channels: [[31]] is too short
>         From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml

I did run "make dtbs_check" and I don't remember seeing the issues you reported.
Hmm.. maybe I missed something. Let me recheck and fix issues in v4.

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
>
> bam_dma.c reads this as uint32 and all existing device tree specify it
> as uint32. I don't think adding the /bits/ 8 to all existing device
> trees is really worth it.
>
> arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: qcom,ee: missing size tag in [[1]]
>         From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml

Ok.

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
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
>
> clocks is often missing if qcom,controlled-remotely is set, e.g.
>
>                 slimbam: dma-controller@9184000 {
>                         compatible = "qcom,bam-v1.7.0";
>                         qcom,controlled-remotely;
>                         reg = <0x09184000 0x32000>;
>                         num-channels  = <31>;
>                         interrupts = <0 164 IRQ_TYPE_LEVEL_HIGH>;
>                         #dma-cells = <1>;
>                         qcom,ee = <1>;
>                         qcom,num-ees = <2>;
>                 };
>
> arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: 'clocks' is a required property
>         From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: 'clock-names' is a required property
>         From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
>
> You might be able to encode this with an if: statement (clocks required
> if qcom,controlled-remotely not specified), not sure.

Ok.

Thanks,
Bhupesh
