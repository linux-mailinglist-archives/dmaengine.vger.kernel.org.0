Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880887B80E2
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbjJDNa2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 09:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjJDNa1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 09:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D97AD;
        Wed,  4 Oct 2023 06:30:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA32BC433C8;
        Wed,  4 Oct 2023 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696426224;
        bh=aJVniq+g35ZseQJZAGkIBzb7ufaQ4aP0ZCjtBHrm/hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHyi7tX99vVdzsJMQXpWs9xJM8JqAe8UVCFgCr1+jn8VyY9G7ZUiy2OMV99FyYbI/
         9D/91JmtqIi3B5u2Bgfl++OVCgNrrB1kL1PCnn0xfEQg3Iw9Ycy+B8XQrfPhDPsval
         fWbtbwurTKuZLbkDHw5iCoy1DfuhBafozyS8z9IYqIOG5J/jAJFo+PbtcnN/whIVjP
         hQb/YK/DAOI1qHF7czLo+bo5IedvtDwQXidg4sMhVQx/R/XTUCcw6I0B9dZvTyPDSc
         kNiDk/2ZGTHfCupwaaKbZ0KouUMZuGwGksHBjpByPDO9f0392I495pyCfgqJtxuq/r
         jGLtT3L8mNT9w==
Received: (nullmailer pid 2755166 invoked by uid 1000);
        Wed, 04 Oct 2023 13:30:21 -0000
Date:   Wed, 4 Oct 2023 08:30:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     shravan chippa <shravan.chippa@microchip.com>
Cc:     green.wan@sifive.com, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: dma: sf-pdma: add new compatible name
Message-ID: <20231004133021.GB2743005-robh@kernel.org>
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
 <20231003042215.142678-3-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003042215.142678-3-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 03, 2023 at 09:52:13AM +0530, shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Add new compatible name microchip,mpfs-pdma to support
> out of order dma transfers
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml         | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> index a1af0b906365..974467c4bacb 100644
> --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> @@ -27,10 +27,14 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - sifive,fu540-c000-pdma
> -      - const: sifive,pdma0
> +    oneOf:
> +      - items:
> +          - const: microchip,mpfs-pdma # Microchip out of order DMA transfer
> +          - const: sifive,fu540-c000-pdma # Sifive in-order DMA transfer

This doesn't really make sense. microchip,mpfs-pdma is compatible with 
sifive,fu540-c000-pdma and sifive,fu540-c000-pdma is compatible with 
sifive,pdma0, but microchip,mpfs-pdma is not compatible with 
sifive,pdma0? (Or replace "compatible with" with "a superset of")

Any fallback is only useful if an OS only understanding the fallback 
will work with the h/w. Does this h/w work without the driver changes?

Rob
