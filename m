Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ACB566F22
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 15:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiGENXZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 09:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiGENWt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 09:22:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975EB1F2DB;
        Tue,  5 Jul 2022 05:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3241560BC0;
        Tue,  5 Jul 2022 12:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A7BC341CB;
        Tue,  5 Jul 2022 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657025167;
        bh=wAEDIpJKEpqow07OA5pbiA0C6VtRvMKO1qtrFbDdCFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1zWy3llLirCMHGf9oUncrDC/YFjZyTLRq8g3aGTJpZatIfnJET0NC0gnzAOEdr2n
         LBKUBdh5gaukjcT6H01UyFyR1g3lElraTjEWOXwlu3L+XH1FqHxwkoz84MEHbDLZZS
         eZ7WTHq7q/c3I0uPyb7wS7aieCwKK84nmRl7LaVwFRCiR7/fpeSy+ezZvVLR5oazeo
         +8rDVpEmi2KIs/N5QTg7RoE7sDKNODVpStI+T1WWd9jlCgJ2LwPqsLi629VFCOdZNa
         34Q7G2rXUbrzbjGnEGGG6k9533cawbC447VyAxsPMu9Lq8RQf5jfsUjcD80ZuDWNNB
         mQCzFe7dd4CQQ==
Date:   Tue, 5 Jul 2022 18:16:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 04/14] dt-bindings: dma: dw-axi-dmac: extend the
 number of interrupts
Message-ID: <YsQyi3Mx99m8fnGu@matsya>
References: <20220701192300.2293643-1-conor@kernel.org>
 <20220701192300.2293643-5-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701192300.2293643-5-conor@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-07-22, 20:22, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
> controller, but according to the documentation & devicetree it has 6
> interrupts rather than the standard one. Support the 6 interrupt
> configuration by unconditionally extending the binding to a maximum of
> 8 per-channel interrupts thereby matching the number of possible
> channels.
> 
> Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 51
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 4324a94b26b2..98c2ab18d04f 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -34,7 +34,12 @@ properties:
>        - const: axidma_apb_regs
>  
>    interrupts:
> -    maxItems: 1
> +    description: |

rob asked you to drop this in last patch, pls fix that and send with his
ack

> +      If the IP-core synthesis parameter DMAX_INTR_IO_TYPE is set to 1, this
> +      will be per-channel interrupts. Otherwise, this is a single combined IRQ
> +      for all channels.
> +    minItems: 1
> +    maxItems: 8
>  
>    clocks:
>      items:
> -- 
> 2.37.0

-- 
~Vinod
