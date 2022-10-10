Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3D65F9F17
	for <lists+dmaengine@lfdr.de>; Mon, 10 Oct 2022 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJJNFg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Oct 2022 09:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJJNF3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Oct 2022 09:05:29 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD015A179;
        Mon, 10 Oct 2022 06:05:20 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1322d768ba7so12387753fac.5;
        Mon, 10 Oct 2022 06:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VruSYQjKdMW+9AMlTXLz+TveQk1ca9C/k1+WiztK+/I=;
        b=EbZipuHk8TAvoakJ/gV8l9R/eIftQb6NyPPl/eaPKgzSAGDOXhkey0qiv/iBJnRhQX
         QfeesXB2iffBHZwPbsGxzgiHkJC7C4LZ9TNbTh7Mnxx9ChBGZhOyFmf/RpmdHQYAOdDV
         vayQoOdljZaoFuXocw3npU/rhs4PeNsk1r2utOOjReEpKCXzUoKLAKt1zzndjXZnuaol
         Pqzr3NrlC2GnRsYnQp1UHYaR+0MX0HUsjw3aF1GsiGp6IdJ61ybLPBCsuilcv+HNeyuL
         ELtXpi/H+iaZOHxmieqvtRczjLi82RWLya2aH6bhSusPfY/wENaRMJ/I7BlIlnbES+MW
         k6rw==
X-Gm-Message-State: ACrzQf1VF7ikArZbrduNcg5RmHI3ZeL6k1CN/uTfDA3TG94lZj2uLRIm
        3tkhuJEjyIVNm6HTaYQ9nA==
X-Google-Smtp-Source: AMsMyM75zf+8TClOT4cW/V7W8q/hu0USA4JeuORJpzDvRkM7YoHsWw73tnh6JVor2AZBpVPgMznlJA==
X-Received: by 2002:a05:6870:5808:b0:128:afd5:491f with SMTP id r8-20020a056870580800b00128afd5491fmr10232253oap.136.1665407119374;
        Mon, 10 Oct 2022 06:05:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bo7-20020a056808228700b0035465a615e1sm2282821oib.30.2022.10.10.06.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 06:05:18 -0700 (PDT)
Received: (nullmailer pid 493117 invoked by uid 1000);
        Mon, 10 Oct 2022 13:05:19 -0000
Date:   Mon, 10 Oct 2022 08:05:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: clock: Add Ingenic JZ4755 CGU header
Message-ID: <20221010130519.GA488861-robh@kernel.org>
References: <20221009181338.2896660-1-lis8215@gmail.com>
 <20221009181338.2896660-4-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009181338.2896660-4-lis8215@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Oct 09, 2022 at 09:13:32PM +0300, Siarhei Volkau wrote:
> This will be used from the devicetree bindings to specify the clocks
> that should be obtained from the jz4755-cgu driver.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  .../dt-bindings/clock/ingenic,jz4755-cgu.h    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 include/dt-bindings/clock/ingenic,jz4755-cgu.h
> 
> diff --git a/include/dt-bindings/clock/ingenic,jz4755-cgu.h b/include/dt-bindings/clock/ingenic,jz4755-cgu.h
> new file mode 100644
> index 000000000..32307f68c
> --- /dev/null
> +++ b/include/dt-bindings/clock/ingenic,jz4755-cgu.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license please.

> +/*
> + * This header provides clock numbers for the ingenic,jz4755-cgu DT binding.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_JZ4755_CGU_H__
> +#define __DT_BINDINGS_CLOCK_JZ4755_CGU_H__
> +
> +#define JZ4755_CLK_EXT		0
> +#define JZ4755_CLK_OSC32K	1
> +#define JZ4755_CLK_PLL		2
> +#define JZ4755_CLK_PLL_HALF	3
> +#define JZ4755_CLK_EXT_HALF	4
> +#define JZ4755_CLK_CCLK		5
> +#define JZ4755_CLK_H0CLK	6
> +#define JZ4755_CLK_PCLK		7
> +#define JZ4755_CLK_MCLK		8
> +#define JZ4755_CLK_H1CLK	9
> +#define JZ4755_CLK_UDC		10
> +#define JZ4755_CLK_LCD		11
> +#define JZ4755_CLK_UART0	12
> +#define JZ4755_CLK_UART1	13
> +#define JZ4755_CLK_UART2	14
> +#define JZ4755_CLK_DMA		15
> +#define JZ4755_CLK_MMC		16
> +#define JZ4755_CLK_MMC0		17
> +#define JZ4755_CLK_MMC1		18
> +#define JZ4755_CLK_EXT512	19
> +#define JZ4755_CLK_RTC		20
> +#define JZ4755_CLK_UDC_PHY	21
> +#define JZ4755_CLK_I2S		22
> +#define JZ4755_CLK_SPI		23
> +#define JZ4755_CLK_AIC		24
> +#define JZ4755_CLK_ADC		25
> +#define JZ4755_CLK_TCU		26
> +#define JZ4755_CLK_BCH		27
> +#define JZ4755_CLK_I2C		28
> +#define JZ4755_CLK_TVE		29
> +#define JZ4755_CLK_CIM		30
> +#define JZ4755_CLK_AUX_CPU	31
> +#define JZ4755_CLK_AHB1		32
> +#define JZ4755_CLK_IDCT		33
> +#define JZ4755_CLK_DB		34
> +#define JZ4755_CLK_ME		35
> +#define JZ4755_CLK_MC		36
> +#define JZ4755_CLK_TSSI		37
> +#define JZ4755_CLK_IPU		38
> +
> +#endif /* __DT_BINDINGS_CLOCK_JZ4755_CGU_H__ */
> -- 
> 2.36.1
> 
> 
