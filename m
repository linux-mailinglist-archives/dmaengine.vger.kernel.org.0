Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA64ED338
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 07:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiCaFZP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 01:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCaFZO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 01:25:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2F9FA20A;
        Wed, 30 Mar 2022 22:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0884961580;
        Thu, 31 Mar 2022 05:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B94DC340EE;
        Thu, 31 Mar 2022 05:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648704206;
        bh=eBy7+Ih0SkRIqoSoJt0V6SXGw5DK/vQX/BZHc0wYr8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mm/n9Jum+7wft5UX7zfI6APvwfOgo2tXy6SSzi8Uxk9pXWWxsELdnowKdRQd/TMh3
         f+4RBVl+y29sVXfrd8HUN1KRH3T3wBQmUfmVT0pCm4CLF+PN2TiQNgFuTjg89WwOa3
         5yzIvZjJ6ogpVE3Kp4AFTB9oP4lPeJRqlm/4JA5tNXiHZH6Ed/Idy5wYZ1sx0PcPja
         HBNQuls/byuxIqW23JCIpCrul84Lqk7idjq3nukNelghfHTCbNOp15Cqw5TL68z7RL
         IvKySAlilij5Dd7Wid7OIeY2kF/7Skz5S7vXX0ij+oJhZ6ncbsjpzyRogLmz4P+BSa
         1mUhPhUjmgyjg==
Date:   Thu, 31 Mar 2022 10:53:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add Apple ADMAC
Message-ID: <YkU6yvUQ6v4VdXiJ@matsya>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
 <20220330164458.93055-2-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220330164458.93055-2-povik+lin@cutebit.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-03-22, 18:44, Martin Povišer wrote:
> Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
> samples on Apple SoCs from the "Apple Silicon" family.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
>  .../devicetree/bindings/dma/apple,admac.yaml  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> new file mode 100644
> index 000000000000..34f76a9a2983
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/apple,admac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Audio DMA Controller (ADMAC)
> +
> +description: |
> +  Apple's Audio DMA Controller (ADMAC) is used to fetch and store
> +  audio samples on Apple SoCs from the "Apple Silicon" family.
> +
> +maintainers:
> +  - Martin Povišer <povik+lin@cutebit.org>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t6000-admac
> +          - apple,t8103-admac
> +      - const: apple,admac
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 1
> +
> +  apple,internal-irq-destination:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Index influencing internal routing of the IRQs
> +      within the peripheral.

do you have more details for this, is this for peripheral and if so
suited to be in dam-cells?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#dma-cells'
> +  - dma-channels
> +  - apple,internal-irq-destination
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    dart_sio: iommu@235004000 {
> +      compatible = "apple,t8103-dart", "apple,dart";
> +      reg = <0x2 0x35004000 0x0 0x4000>;
> +      interrupt-parent = <&aic>;
> +      interrupts = <AIC_IRQ 635 IRQ_TYPE_LEVEL_HIGH>;
> +      #iommu-cells = <1>;
> +    };
> +
> +    admac: dma-controller@238200000 {
> +      compatible = "apple,t8103-admac", "apple,admac";
> +      reg = <0x2 0x38200000 0x0 0x34000>;
> +      dma-channels = <12>;
> +      interrupt-parent = <&aic>;
> +      interrupts = <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
> +      #dma-cells = <1>;
> +      iommus = <&dart_sio 2>;
> +      apple,internal-irq-destination = <1>;
> +    };
> -- 
> 2.33.0

-- 
~Vinod
