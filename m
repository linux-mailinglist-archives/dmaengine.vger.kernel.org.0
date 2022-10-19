Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743C8604826
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiJSNtn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiJSNtG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 09:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420012277C;
        Wed, 19 Oct 2022 06:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F246C618C8;
        Wed, 19 Oct 2022 13:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6053C433B5;
        Wed, 19 Oct 2022 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666186384;
        bh=jihN27LWxHz/KYbIprPHBbgILCESSPj6Y+IsdOz+MXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qk3GUPcGbD3CBpedVsV2w5kJ5kUjFIjKOqVSQrDtSJjBHr7jR/7s88ueSUSdf+E57
         QWWBn1NP61O20JV9CmKRBbhey7kWf59Yqh1atTMTkAeIs5rLZ0X00IvMhA11uD+2f5
         KoZ/he2a1m9qg/McaeWBgdGGvqBZdhQtH+ZTuT5dW+2Qk+8b+VwDckwzKDmiVxCCE0
         vkQy0Tj3QOig3BfFUv9DcZi5sZdOyM8MS/bbAKTXwtoidwkxsfr7NLOuUtVhTWh3QS
         7OQd88cFz0O0slKW7lHd/UxQTyNkz+8u/+2ICFhdiVcuL01k6o7VCpw15m7n9lrK6K
         36rbwqgkhMMzA==
Date:   Wed, 19 Oct 2022 19:03:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/3] dt-bindings: dmaengine: Add
 dma-channel-mask to Tegra GPCDMA
Message-ID: <Y0/8jF++NeUGtPGM@matsya>
References: <20221018162812.69673-1-akhilrajeev@nvidia.com>
 <20221018162812.69673-2-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018162812.69673-2-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-10-22, 21:58, Akhil R wrote:
> Add dma-channel-mask property in Tegra GPCDMA document.
> 
> The property would help to specify the channels to be used in
> kernel and reserve few for the firmware. This was previously
> achieved by limiting the channel number to 31 in the driver.
> Now since we can list all 32 channels, update the interrupts
> property as well to list all 32 interrupts.

Pls cc dt folks and ML on DT patches!

> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml   | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> index c8894476b6ab..851bd50ee67f 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -39,7 +39,7 @@ properties:
>        Should contain all of the per-channel DMA interrupts in
>        ascending order with respect to the DMA channel index.
>      minItems: 1
> -    maxItems: 31
> +    maxItems: 32
>  
>    resets:
>      maxItems: 1
> @@ -52,6 +52,9 @@ properties:
>  
>    dma-coherent: true
>  
> +  dma-channel-mask:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -60,6 +63,7 @@ required:
>    - reset-names
>    - "#dma-cells"
>    - iommus
> +  - dma-channel-mask
>  
>  additionalProperties: false
>  
> @@ -108,5 +112,6 @@ examples:
>          #dma-cells = <1>;
>          iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
>          dma-coherent;
> +        dma-channel-mask = <0xfffffffe>;
>      };
>  ...
> -- 
> 2.17.1

-- 
~Vinod
