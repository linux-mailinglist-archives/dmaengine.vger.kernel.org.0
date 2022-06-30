Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9359A5625A4
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jun 2022 23:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbiF3VwI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jun 2022 17:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiF3VwB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jun 2022 17:52:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F953EE7;
        Thu, 30 Jun 2022 14:52:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t25so606392lfg.7;
        Thu, 30 Jun 2022 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NrGas5lulMJdCQFvtdHCPkDfHPqr2UrmNuzK4irkMDQ=;
        b=qNhf+eF3ou+OVuBeZcYuSohm7adWxuKi6Yti0wH8bSh+rn6DndIf7DuGYB1f4KK8qt
         DQh7A3jNA52nPGbBERaiWj+hhdug4lHLUcYgbylBVnN1M1rmnL4bHVXl9so2OAk70Kol
         ppPogOM7Yfz5iZIO7ZCRIJrAxmaPYXsarHk0xmmqdn0cMqNbblQh3pyw2vY/FtMgJd5y
         hCQtcbwDeYyKxHz0lXeQPvCW4k5sS7l2OGN6ra/IfS/OBFcMG7EvKJhz4Qi0RLZVnkms
         eTpsxPnvbqwvQr/Y+dzniw6/aIav/3pP1gfyXYwGI+HaXsv6x2RppynNq4a0m+ieGc0n
         IN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NrGas5lulMJdCQFvtdHCPkDfHPqr2UrmNuzK4irkMDQ=;
        b=K0b/mEQGgl/zT9OVv6ujfS6tT8RF6nA1izBk8Bf4N3PiyAktPiAEUgHROCcqhGxuYv
         i8oB0BlLVSZhB75UJksN69d9BJY9SE76k/rzJ2RpjzIfj8IaVYjchUxYXhK9DrPsHIvW
         y4JXlCeAww0Ph0MJXbvoTJc5THufkxDtY/B9xfwKre0fFT0LpxMcgXx/gkFbs8NBiKMF
         +Z807dzB07d/kwYFz9YHb5fGzbu+qf19Ls7xpkyJyxJeUusQDveteIHC3pF/QOZ2Yh6I
         z10c17/pL0NHqMbXf9deyIET3kNxH8/wLiiC2/SvNGOr6P/1MECZl6lLuft6LD1Mf42W
         YgBg==
X-Gm-Message-State: AJIora8lKW0SpEwDE9Hf5hGAzipEfQpNc29D76/CraYHLmVLgYxXnDBz
        3aI3Nid44q9m4FH1dmYpzmw=
X-Google-Smtp-Source: AGRyM1smx3NRBQNbNVKAperCZ6SfrYZXWBWZAqtLbA5mlnisA9vFR0m9cfl7wPwPzhY7YfaqPG1NNw==
X-Received: by 2002:a05:6512:2292:b0:47f:68b3:3c21 with SMTP id f18-20020a056512229200b0047f68b33c21mr7126215lfu.316.1656625918646;
        Thu, 30 Jun 2022 14:51:58 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id c16-20020a056512325000b0047f963bf815sm3293106lfr.93.2022.06.30.14.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:51:58 -0700 (PDT)
Date:   Fri, 1 Jul 2022 00:51:55 +0300
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
Subject: Re: [PATCH v3 08/15] riscv: dts: canaan: fix the k210's timer nodes
Message-ID: <20220630215155.xzhtfkolgy2iubqe@mobilestation>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <20220629184343.3438856-9-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629184343.3438856-9-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 29, 2022 at 07:43:37PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The timers on the k210 have non standard interrupt configurations,
> which leads to dtbs_check warnings:
> 
> k210_generic.dtb: timer@502d0000: interrupts: [[14], [15]] is too long
> From schema: Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
> 
> Split the timer nodes in two, so that the second timer in the IP block
> can actually be accessed & in the process solve the dtbs_check warning.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Just to note. IMO the DW APB Timer driver has been incorrectly
designed in the first place. The dts-node is supposed to describe the
whole IP-core timers set as the original Canaan k210 DT-file expected,
since there are common CSRs in the registers range, which currently
get to be unreachable. But since the DT-bindings has already been
defined that way in the framework of DW APB Timer driver alas there
is nothing we can do to fix it.

-Sergey

> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/canaan/k210.dtsi | 46 +++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
> index cd4eae82d8b2..72f70128d751 100644
> --- a/arch/riscv/boot/dts/canaan/k210.dtsi
> +++ b/arch/riscv/boot/dts/canaan/k210.dtsi
> @@ -319,28 +319,58 @@ fpioa: pinmux@502b0000 {
>  
>  			timer0: timer@502d0000 {
>  				compatible = "snps,dw-apb-timer";
> -				reg = <0x502D0000 0x100>;
> -				interrupts = <14>, <15>;
> +				reg = <0x502D0000 0x14>;
> +				interrupts = <14>;
>  				clocks = <&sysclk K210_CLK_TIMER0>,
>  					 <&sysclk K210_CLK_APB0>;
>  				clock-names = "timer", "pclk";
>  				resets = <&sysrst K210_RST_TIMER0>;
>  			};
>  
> -			timer1: timer@502e0000 {
> +			timer1: timer@502d0014 {
>  				compatible = "snps,dw-apb-timer";
> -				reg = <0x502E0000 0x100>;
> -				interrupts = <16>, <17>;
> +				reg = <0x502D0014 0x14>;
> +				interrupts = <15>;
> +				clocks = <&sysclk K210_CLK_TIMER0>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "timer", "pclk";
> +				resets = <&sysrst K210_RST_TIMER0>;
> +			};
> +
> +			timer2: timer@502e0000 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x502E0000 0x14>;
> +				interrupts = <16>;
>  				clocks = <&sysclk K210_CLK_TIMER1>,
>  					 <&sysclk K210_CLK_APB0>;
>  				clock-names = "timer", "pclk";
>  				resets = <&sysrst K210_RST_TIMER1>;
>  			};
>  
> -			timer2: timer@502f0000 {
> +			timer3: timer@502e0014 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x502E0014 0x114>;
> +				interrupts = <17>;
> +				clocks = <&sysclk K210_CLK_TIMER1>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "timer", "pclk";
> +				resets = <&sysrst K210_RST_TIMER1>;
> +			};
> +
> +			timer4: timer@502f0000 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x502F0000 0x14>;
> +				interrupts = <18>;
> +				clocks = <&sysclk K210_CLK_TIMER2>,
> +					 <&sysclk K210_CLK_APB0>;
> +				clock-names = "timer", "pclk";
> +				resets = <&sysrst K210_RST_TIMER2>;
> +			};
> +
> +			timer5: timer@502f0014 {
>  				compatible = "snps,dw-apb-timer";
> -				reg = <0x502F0000 0x100>;
> -				interrupts = <18>, <19>;
> +				reg = <0x502F0014 0x14>;
> +				interrupts = <19>;
>  				clocks = <&sysclk K210_CLK_TIMER2>,
>  					 <&sysclk K210_CLK_APB0>;
>  				clock-names = "timer", "pclk";
> -- 
> 2.36.1
> 
