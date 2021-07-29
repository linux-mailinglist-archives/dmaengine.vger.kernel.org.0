Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9809B3DABE0
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 21:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhG2Tee (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 15:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhG2Tee (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Jul 2021 15:34:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2E9B60E76;
        Thu, 29 Jul 2021 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627587270;
        bh=4AE8gySMnmw4ukw7WiP/vi7kSExtOyQED99CxMrW4aY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F0dn6pqLLxt8U3AFzExMEoXrzzdy5UoPXiAhyFTWi3fWLq8/tSDXl/JEssxNcK8+p
         jiLObenKDCuUo8ok6W1UGS1F5Wtt63p2NY57+JcWM5PcoFs+e1PRVKb+7tqTRkgepS
         pi1d58N5SJB0YDqXyEHcPuWd1B/RR0k0snIOnikcQ8veB2o0NsCOPNmZqQKHYYXETK
         5GT7zRfg2GWYgsNPSzQzaQdqrd5VgG7q46smVp9ce7FjpX6gq7xX0CYtqNaS+o+bzM
         6n33c9gB1zdB9RY4GF1nPaGh9UVcxupSnvQpJBW9Td3nEaxF5rhAzB9X/3MtC1ZQxW
         QdpJmadgH5fUQ==
Received: by mail-ed1-f43.google.com with SMTP id p21so9664216edi.9;
        Thu, 29 Jul 2021 12:34:30 -0700 (PDT)
X-Gm-Message-State: AOAM531Af1tGMfvkESSlgmUPsg2Qk4GHYVP2LUXT0sWjY4iybqJ0UdTw
        0wfwzs52CYkCbUqJNO1GupyxU0OtflS3vsE5Zg==
X-Google-Smtp-Source: ABdhPJzW42FQ84WoTXyLSP20bPgulZO3lChpHA4mx21rS0OBJSN1BS+qHjGAUCwD7/f1CJJMLq3vUg8n/UH8xvh19vw=
X-Received: by 2002:aa7:c603:: with SMTP id h3mr7723900edq.165.1627587269262;
 Thu, 29 Jul 2021 12:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-2-bhupesh.sharma@linaro.org> <20210521014316.GA2462277@robh.at.kernel.org>
 <CAH=2NtwzFMre_+6LRM_JL+itbG09UuKLtH+Awbv_zK++qns49w@mail.gmail.com>
In-Reply-To: <CAH=2NtwzFMre_+6LRM_JL+itbG09UuKLtH+Awbv_zK++qns49w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Jul 2021 13:34:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+AoAs_4-LBVoP_vzNF0Unn3jU2KRXMoJv8A7TJC_v+xg@mail.gmail.com>
Message-ID: <CAL_Jsq+AoAs_4-LBVoP_vzNF0Unn3jU2KRXMoJv8A7TJC_v+xg@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] dt-bindings: qcom-bam: Convert binding to YAML
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 3, 2021 at 9:27 PM Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Hello Rob,
>
> Thanks for the review and sorry for the late reply.
>
> On Fri, 21 May 2021 at 07:13, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, May 19, 2021 at 08:06:44PM +0530, Bhupesh Sharma wrote:
> > > Convert Qualcomm BAM DMA devicetree binding to YAML.
> > >
> > > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Andy Gross <agross@kernel.org>
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: David S. Miller <davem@davemloft.net>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: dmaengine@vger.kernel.org
> > > Cc: linux-clk@vger.kernel.org
> > > Cc: linux-crypto@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: bhupesh.linux@gmail.com
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >  .../devicetree/bindings/dma/qcom_bam_dma.txt  | 50 ----------
> > >  .../devicetree/bindings/dma/qcom_bam_dma.yaml | 91 +++++++++++++++++++
> > >  2 files changed, 91 insertions(+), 50 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > >  create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > > deleted file mode 100644
> > > index cf5b9e44432c..000000000000
> > > --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > > +++ /dev/null
> > > @@ -1,50 +0,0 @@
> > > -QCOM BAM DMA controller
> > > -
> > > -Required properties:
> > > -- compatible: must be one of the following:
> > > - * "qcom,bam-v1.4.0" for MSM8974, APQ8074 and APQ8084
> > > - * "qcom,bam-v1.3.0" for APQ8064, IPQ8064 and MSM8960
> > > - * "qcom,bam-v1.7.0" for MSM8916
> > > -- reg: Address range for DMA registers
> > > -- interrupts: Should contain the one interrupt shared by all channels
> > > -- #dma-cells: must be <1>, the cell in the dmas property of the client device
> > > -  represents the channel number
> > > -- clocks: required clock
> > > -- clock-names: must contain "bam_clk" entry
> > > -- qcom,ee : indicates the active Execution Environment identifier (0-7) used in
> > > -  the secure world.
> > > -- qcom,controlled-remotely : optional, indicates that the bam is controlled by
> > > -  remote proccessor i.e. execution environment.
> > > -- num-channels : optional, indicates supported number of DMA channels in a
> > > -  remotely controlled bam.
> > > -- qcom,num-ees : optional, indicates supported number of Execution Environments
> > > -  in a remotely controlled bam.
> > > -
> > > -Example:
> > > -
> > > -     uart-bam: dma@f9984000 = {
> > > -             compatible = "qcom,bam-v1.4.0";
> > > -             reg = <0xf9984000 0x15000>;
> > > -             interrupts = <0 94 0>;
> > > -             clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> > > -             clock-names = "bam_clk";
> > > -             #dma-cells = <1>;
> > > -             qcom,ee = <0>;
> > > -     };
> > > -
> > > -DMA clients must use the format described in the dma.txt file, using a two cell
> > > -specifier for each channel.
> > > -
> > > -Example:
> > > -     serial@f991e000 {
> > > -             compatible = "qcom,msm-uart";
> > > -             reg = <0xf991e000 0x1000>
> > > -                     <0xf9944000 0x19000>;
> > > -             interrupts = <0 108 0>;
> > > -             clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
> > > -                     <&gcc GCC_BLSP1_AHB_CLK>;
> > > -             clock-names = "core", "iface";
> > > -
> > > -             dmas = <&uart-bam 0>, <&uart-bam 1>;
> > > -             dma-names = "rx", "tx";
> > > -     };
> > > diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> > > new file mode 100644
> > > index 000000000000..173e4d7508a6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> > > @@ -0,0 +1,91 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/qcom_bam_dma.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: QCOM BAM DMA controller binding
> > > +
> > > +maintainers:
> > > +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > +
> > > +description: |
> > > +  This document defines the binding for the BAM DMA controller
> > > +  found on Qualcomm parts.
> > > +
> > > +allOf:
> > > +  - $ref: "dma-controller.yaml#"
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - qcom,bam-v1.4.0
> > > +      - qcom,bam-v1.3.0
> > > +      - qcom,bam-v1.7.0
> >
> > Can we keep the SoC association please.
>
> The original bam dma bindings are as per the underlying bam IP
> version, so I would prefer that we keep it this way for this series.
>
> Later on I can send a patchset to convert the bam DMA dt-bindings, dts
> and driver to work with 'SoC association' instead.

I just mean keep a comment with the mapping of versions to SoC:

> > > - * "qcom,bam-v1.4.0" for MSM8974, APQ8074 and APQ8084
> > > - * "qcom,bam-v1.3.0" for APQ8064, IPQ8064 and MSM8960
> > > - * "qcom,bam-v1.7.0" for MSM8916

Otherwise, we are losing that information.

Rob
