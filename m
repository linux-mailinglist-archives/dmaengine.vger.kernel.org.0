Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636D05625B9
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jun 2022 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbiF3Vzr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jun 2022 17:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiF3Vzq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jun 2022 17:55:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE22564EB;
        Thu, 30 Jun 2022 14:55:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t25so619341lfg.7;
        Thu, 30 Jun 2022 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=80eW9Jq1ijIJLJtHfGhI83NTX/9vTLnN/UmyaBuaW4E=;
        b=AkPzOgMfGFfZSjZD7jfIt2VIntAlLoUSr3SbzTZY0tvDU2JAbZAB5jwCcqhRCkAM2f
         SZMaXzambC5XvJqoJSqZhCYJjt3IvVCp+6BwaWT4/O99SY2jx12hO35bgEKhKuKxejcQ
         dE2URnyS5yf1nh9ijeSAcPycHs2KVfpVtk/PdoQ7jD6COfYLF+mrcrO6e33CUzwQZPGY
         APDYTngSt7Y+GPy5o8I+w1G0pNyoFvpS1MDQY6Dnc7Ax6wnu+jMdv5Clu6vCV+9thnMt
         x6/8Y8TfDG/rsDa4DJ2sM0E7/R76fWr9+E3VerI/dstVRhBOWwsbw1sjWfdYFwEvwyeZ
         Vx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=80eW9Jq1ijIJLJtHfGhI83NTX/9vTLnN/UmyaBuaW4E=;
        b=oXSdrSGZJbKw6Ow5oEpuqUp5Y/d/aa3Mj6YiFaZ6kqB+O9wxxt+vD4pJszguE80fys
         hrzS9B9mb5Ce5IEQKpsG0q7AjmxHxKg3Vpm/Unllvgo9TWyVThUDpoeaWUTlMndWcZW6
         ez5xQuKN0FZJVwUQ1MN6vXw/3EsnKJaRuJU6Sv59rqP0QHiExVvl3+PV6iVeYDvefO2u
         um344+qYVgcgqJu4+EuPpUusfPdup397+UlmF86QJKmrXi/j5SsNIvJ6Mv5Tq904tLmE
         5kFK5xBp7H4RIs5Y+ofP4KtlcRI9GEuohrpg/Q/KDUaWouzJZkEIA3nEpYdKlRVI2vpt
         bu8w==
X-Gm-Message-State: AJIora+8DccChig9kfR7Gp16FCw7BNVapMeo/fugNSDUKwRBb8pIHPmn
        1hiiOkmkDrPbDvwSgfQrUH4=
X-Google-Smtp-Source: AGRyM1uQwi4ck8oI9eCwLDrSO3GQoKmA3R5saWkWWfnF2szv6WIcphr08hrqWMNbe4QePSuxVMEb9g==
X-Received: by 2002:a05:6512:118f:b0:47f:6a1a:20d4 with SMTP id g15-20020a056512118f00b0047f6a1a20d4mr6526103lfr.428.1656626143761;
        Thu, 30 Jun 2022 14:55:43 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id e12-20020ac24e0c000000b00478a311d399sm3304595lfr.0.2022.06.30.14.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:55:43 -0700 (PDT)
Date:   Fri, 1 Jul 2022 00:55:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 05/15] dt-bindings: dma: dw-axi-dmac: extend the
 number of interrupts
Message-ID: <20220630215540.cifnzovya57bgbsw@mobilestation>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <20220629184343.3438856-6-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629184343.3438856-6-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 29, 2022 at 07:43:34PM +0100, Conor Dooley wrote:
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
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 4324a94b26b2..e33ef22aec9c 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -34,7 +34,9 @@ properties:
>        - const: axidma_apb_regs
>  
>    interrupts:

> -    maxItems: 1
> +    description: per channel interrupts

Description is inaccurate. It's either combined or per-channel IRQs.

Other than that:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> +    minItems: 1
> +    maxItems: 8
>  
>    clocks:
>      items:
> -- 
> 2.36.1
> 
