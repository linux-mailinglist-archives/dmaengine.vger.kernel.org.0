Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980A42D6035
	for <lists+dmaengine@lfdr.de>; Thu, 10 Dec 2020 16:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391323AbgLJPo4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Dec 2020 10:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391342AbgLJPoq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Dec 2020 10:44:46 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A1CC0613CF;
        Thu, 10 Dec 2020 07:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
        :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bfquSlu2CVvoyye+gQbL5aUKWqWpkQNRYpSFZssfs2c=; b=O/NZfP5/dEX8MjBp9pB9Igyu4F
        7kqBaAThDTB0M58EILAI7G8fmVH+aVND9zZFR0k5wunRSKU1eMMBp2bSRnOcnhcIdA+OUSul9mQb9
        /OS7jLWn3jB+PNlbBUCitI5Vsfy1GTyL/Zq7jBde0OG3BFjQ4wSj1WJWPQ6xq7ZcLz8NDAjzpFoe/
        /ucbP+4LXe9ACVJQeJ7za4QrnmvNrPCaWjFlJGx8ouMqn6s1le/xEe7SL4nPan1BDFuaGRBK03ciX
        ugJVn5MFns8ya8CDo544zfCajFJivDrPU9U8Fk8ahc5IL+4mJpymJvR0hRK63iXobQ/XCA4e2nI9/
        OKRIBhZg==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1knO6o-0001YY-QI; Thu, 10 Dec 2020 15:43:58 +0000
Date:   Thu, 10 Dec 2020 15:43:58 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: Convert Qualcomm ADM bindings to
 yaml
Message-ID: <20201210154358.GX32650@earth.li>
References: <20201115181242.GA30004@earth.li>
 <20201207191222.GA629533@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207191222.GA629533@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 07, 2020 at 01:12:22PM -0600, Rob Herring wrote:
> On Sun, Nov 15, 2020 at 06:12:42PM +0000, Jonathan McDowell wrote:
> > Converts the device tree bindings for the Qualcomm Application Data
> > Mover (ADM) DMA controller over to YAML schemas.
> > 
> > Signed-off-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  .../devicetree/bindings/dma/qcom,adm.yaml     | 102 ++++++++++++++++++
> >  .../devicetree/bindings/dma/qcom_adm.txt      |  61 -----------
> >  2 files changed, 102 insertions(+), 61 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/qcom,adm.yaml b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
> > new file mode 100644
> > index 000000000000..353d85d3326d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
> > @@ -0,0 +1,102 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/qcom,adm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: QCOM ADM DMA Controller
> > +
> > +maintainers:
> > +  - Jonathan McDowell <noodles@earth.li>
> > +
> > +description: |
> > +  QCOM Application Data Mover (ADM) DMA controller found in the MSM8x60
> > +  and IPQ/APQ8064 platforms.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: qcom,adm
> 
> Needs SoC specific compatible(s).

It's not clear would actually make sense that's more specific than this;
adding a version was discussed but it does not appear more recent chips
use the adm block and so qcom,adm was seen to be sufficient (as well as
matching what's already in tree).

> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      Address range for DMA registers
> 
> Drop description. Doesn't really add anything specific to this binding.

Ok.

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description:
> > +      Should contain one interrupt shared by all channels
> 
> Drop.

Ok.

> > +
> > +  "#dma-cells":
> > +    const: 2
> > +    description:
> > +      First cell denotes the channel number.  Second cell denotes CRCI
> > +      (client rate control interface) flow control assignment. If no
> > +      flow control is required, use 0.
> > +
> > +  clocks:
> > +    maxItems: 2
> > +    description:
> > +      Should contain the core clock and interface clock.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: core
> > +      - const: iface
> > +
> > +  resets:
> > +    maxItems: 4
> > +    description:
> > +      Must contain an entry for each entry in reset names.
> > +
> > +  reset-names:
> > +    items:
> > +      - const: clk
> > +      - const: c0
> > +      - const: c1
> > +      - const: c2
> > +
> > +  qcom,ee:
> > +    maxItems: 1
> 
> maxItems is for arrays and this is a scalar.

So it should be:

  $ref: /schemas/types.yaml#/definitions/uint32

?

> > +    description:
> > +      Indicates the security domain identifier used in the secure world.
> 
> How do I get 'ee' from this? Is this something other QCom blocks need?

Apparently it stands for "Execution Environment". It's used for other
QCom blocks as well (I see at least qcom,bam and qcom,spmi-pmic-arb
already in tree). I'll expand the comment to include the Execution
Environment string.

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +required:
> > +  - "#dma-cells"
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - qcom,ee
> > +  - resets
> > +  - reset-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/reset/qcom,gcc-ipq806x.h>
> > +
> > +    adm_dma: dma@18300000 {
> 
> Drop unused labels.

Ok.

> 
> > +             compatible = "qcom,adm";
> > +             reg = <0x18300000 0x100000>;
> > +             interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> > +             #dma-cells = <2>;
> > +
> > +             clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
> > +             clock-names = "core", "iface";
> > +
> > +             resets = <&gcc ADM0_RESET>,
> > +                      <&gcc ADM0_C0_RESET>,
> > +                      <&gcc ADM0_C1_RESET>,
> > +                      <&gcc ADM0_C2_RESET>;
> > +             reset-names = "clk", "c0", "c1", "c2";
> > +             qcom,ee = <0>;
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/dma/qcom_adm.txt b/Documentation/devicetree/bindings/dma/qcom_adm.txt
> > deleted file mode 100644
> > index 9d3b2f917b7b..000000000000
> > --- a/Documentation/devicetree/bindings/dma/qcom_adm.txt
> > +++ /dev/null
> > @@ -1,61 +0,0 @@
> > -QCOM ADM DMA Controller
> > -
> > -Required properties:
> > -- compatible: must contain "qcom,adm" for IPQ/APQ8064 and MSM8960
> > -- reg: Address range for DMA registers
> > -- interrupts: Should contain one interrupt shared by all channels
> > -- #dma-cells: must be <2>.  First cell denotes the channel number.  Second cell
> > -  denotes CRCI (client rate control interface) flow control assignment.
> > -- clocks: Should contain the core clock and interface clock.
> > -- clock-names: Must contain "core" for the core clock and "iface" for the
> > -  interface clock.
> > -- resets: Must contain an entry for each entry in reset names.
> > -- reset-names: Must include the following entries:
> > -  - clk
> > -  - c0
> > -  - c1
> > -  - c2
> > -- qcom,ee: indicates the security domain identifier used in the secure world.
> > -
> > -Example:
> > -		adm_dma: dma@18300000 {
> > -			compatible = "qcom,adm";
> > -			reg = <0x18300000 0x100000>;
> > -			interrupts = <0 170 0>;
> > -			#dma-cells = <2>;
> > -
> > -			clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
> > -			clock-names = "core", "iface";
> > -
> > -			resets = <&gcc ADM0_RESET>,
> > -				<&gcc ADM0_C0_RESET>,
> > -				<&gcc ADM0_C1_RESET>,
> > -				<&gcc ADM0_C2_RESET>;
> > -			reset-names = "clk", "c0", "c1", "c2";
> > -			qcom,ee = <0>;
> > -		};
> > -
> > -DMA clients must use the format descripted in the dma.txt file, using a three
> > -cell specifier for each channel.
> > -
> > -Each dmas request consists of 3 cells:
> > - 1. phandle pointing to the DMA controller
> > - 2. channel number
> > - 3. CRCI assignment, if applicable.  If no CRCI flow control is required, use 0.
> > -    The CRCI is used for flow control.  It identifies the peripheral device that
> > -    is the source/destination for the transferred data.
> > -
> > -Example:
> > -
> > -	spi4: spi@1a280000 {
> > -		spi-max-frequency = <50000000>;
> > -
> > -		pinctrl-0 = <&spi_pins>;
> > -		pinctrl-names = "default";
> > -
> > -		cs-gpios = <&qcom_pinmux 20 0>;
> > -
> > -		dmas = <&adm_dma 6 9>,
> > -			<&adm_dma 5 10>;
> > -		dma-names = "rx", "tx";
> > -	};
> > -- 
> > 2.29.2
> > 

J.

-- 
Revd Jonathan McDowell, ULC | Don't just stand there, kill something.
