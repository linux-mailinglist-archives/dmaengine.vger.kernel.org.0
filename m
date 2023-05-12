Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA27700938
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 15:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbjELNaf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 09:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjELNae (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 09:30:34 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05AE2D78;
        Fri, 12 May 2023 06:30:32 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A897B2D8;
        Fri, 12 May 2023 15:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683898220;
        bh=Oe/8CoACA/cIoFFCLXHRn7jsUiNj0D1Hkkbdah2X6ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQ+LL2bCr0/0aoYp6So+lclr0hzAtCqoDj1z3rygUrVyKenvjUIHDgS9R4saaQDCq
         WFZufjKdvaPDbFaFJpwpYLIxj/78gqNgptkak7Y/sypdwsJC4FN160SOtH23E4IOJs
         IH4l+EedpNP1X4RvmdIVFg70Vt9GISGdyEG8r2gs=
Date:   Fri, 12 May 2023 16:30:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: dma: xilinx: Add power-domains to
 xlnx,zynqmp-dpdma
Message-ID: <20230512133025.GA11112@pendragon.ideasonboard.com>
References: <8f5651634df338743f95a7253a741f9ddc92487d.1683891609.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f5651634df338743f95a7253a741f9ddc92487d.1683891609.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Fri, May 12, 2023 at 01:40:33PM +0200, Michal Simek wrote:
> DP DMA has own power domain that's why describe required power-domain
> property.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v3:
> - make power-domains as required property
> - also update commit message
> 
> Changes in v2:
> - rewrite commit message - requested by Krzysztof
> 
> The commit b06112cd5e08 ("arm64: dts: zynqmp: Add power domain for the
> DisplayPort DMA controller") added this property already in Linux that's
> why the patch is also fixing dts_check warnings.
> 
> In v2 I got ack from Krzysztof but not adding it because of additional
> discussion about required property in v3.
> https://lore.kernel.org/r/029ba923-d13e-ea7c-018d-95e179dda2e5@linaro.org
> 
> ---
>  .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> index d6cbd95ec26d..2128f4645c98 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> @@ -41,6 +41,9 @@ properties:
>    clock-names:
>      const: axi_clk
>  
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - "#dma-cells"
>    - compatible
> @@ -48,12 +51,14 @@ required:
>    - interrupts
>    - clocks
>    - clock-names
> +  - power-domains
>  
>  additionalProperties: false
>  
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/xlnx-zynqmp-power.h>
>  
>      dma: dma-controller@fd4c0000 {
>        compatible = "xlnx,zynqmp-dpdma";
> @@ -63,6 +68,7 @@ examples:
>        clocks = <&dpdma_clk>;
>        clock-names = "axi_clk";
>        #dma-cells = <1>;
> +      power-domains = <&zynqmp_firmware PD_DP>;
>      };
>  
>  ...

-- 
Regards,

Laurent Pinchart
