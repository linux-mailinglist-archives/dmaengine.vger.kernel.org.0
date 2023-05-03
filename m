Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAC46F582B
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 14:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjECMvQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjECMvP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 08:51:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A0DEE;
        Wed,  3 May 2023 05:51:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CCD6BC;
        Wed,  3 May 2023 14:51:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683118270;
        bh=fb1WH2nl1okN9IQEHKZRmq01W6X8milAU7kOiFOcfqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCEU58e7Nw1hyQfKYaWVDG3uKrhYe4nsinKucz7azwM316CscewySD3xWeBNSpLC0
         u4iSdGDx2MCVW3UGb3JkHpBrEVsaQtE/c9VlG+AufxhtY/xFf3q86EeVE9rf0RhzNL
         mSCFa918qVPYJuZPwhnqlgYCTo+pSvPOgs5nt5TM=
Date:   Wed, 3 May 2023 15:51:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: dma: xilinx: Add power-domains to
 xlnx,zynqmp-dpdma
Message-ID: <20230503125125.GE32586@pendragon.ideasonboard.com>
References: <30424f5886ef42419f65c2d5131ad30881c727a4.1683100816.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30424f5886ef42419f65c2d5131ad30881c727a4.1683100816.git.michal.simek@amd.com>
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

On Wed, May 03, 2023 at 10:00:20AM +0200, Michal Simek wrote:
> DP DMA has own power domain that's why describe optional power-domain
> property.

As far as I understand, the property should always be specified, the
only reason why it's not mandatory is backward-compatibility (I would
make it mandatory, as I think proper validation of new DT is more
important than avoiding breaking validation - but not operation! - of
old DT, but that's a separate story). If my understanding is correct,
could you please update the example in the bindings to add the
power-domains property ?

> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - rewrite commit message - requested by Krzysztof
> 
> The commit b06112cd5e08 ("arm64: dts: zynqmp: Add power domain for the
> DisplayPort DMA controller") added this property already in Linux that's
> why the patch is also fixing dts_check warnings.
> 
> ---
>  .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml      | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> index 825294e3f0e8..f066f6983899 100644
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

-- 
Regards,

Laurent Pinchart
