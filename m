Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F45089A7
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 15:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379144AbiDTNtP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379139AbiDTNtJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 09:49:09 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2575A21E0D;
        Wed, 20 Apr 2022 06:46:22 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-69-216-nat.elisa-mobile.fi [85.76.69.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id AD3B7205A6;
        Wed, 20 Apr 2022 16:46:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1650462379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPdeBaZ6eVr/qRTevscI2sSHgl9RZPmaXc8iV1TPOYQ=;
        b=TWxI7Ho2RtsaPS6MDuk2M+E+sq1KJYxSGS4DmJDZp6BP1taIQkAU15m6enkHBtGqJiUXvp
        lXQHG+v4JXQrypyUiMgoBHrh9vRs0uJa78N5cmw1Dkb39AobNvcLF22yj6OlonUngPVdl9
        hg/zZ4gRXP0aP/DTuM9FEXSAfDl6JAk=
Date:   Wed, 20 Apr 2022 16:46:15 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com, jmkrzyszt@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 26/41] ARM: omap1: relocate static I/O mapping
Message-ID: <20220420134615.GA1947@darkstar.musicnaut.iki.fi>
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-27-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419133723.1394715-27-arnd@kernel.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1650462379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPdeBaZ6eVr/qRTevscI2sSHgl9RZPmaXc8iV1TPOYQ=;
        b=H/ymb4ClmH02P6z9wJPj5hwDvA4ML4CAqvyTrTXpyzakXMrwIF7fhncpTt2p+tyb+n415S
        rXswuQZfImMNpPXfbjLG2A2bYft152C7y10qe9zeKLi8GlOcXPiCV9y/0Eijq+J6KgXV6K
        JExPxjG2F+njcVYYdJlNrzaNBE0jppU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1650462379; a=rsa-sha256; cv=none;
        b=CVy72ecIkI6wF0iqwa+Xy91DJU3aDMoxGNfzuIx9Vt1gzOxFw+Q04asMI9whLP3P8s501X
        P2eVWVYDpVAr6tfbV1PJEm52Z8VQMrb77N573CgDjOg+UHf97HnYPA9FH0wGgHHkmeXpu6
        wtihpIfPU1zC4kkQJy4ZZuJBXIgiXlA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Tue, Apr 19, 2022 at 03:37:08PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The address range 0xfee00000-0xfeffffff is used for PCI and
> PCMCIA I/O port mappings, but OMAP1 has its static mappings
> there as well.
> 
> Move the OMAP1 addresses a little higher to avoid crashing
> at boot.

This has the same problem I reported in 2019, with earlyprintk the
system no longer boots:

	https://marc.info/?t=156530014200005&r=1&w=2

Tested on OSK and SX1/qemu.

A.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig.debug                      | 6 +++---
>  arch/arm/mach-omap1/include/mach/hardware.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 0c9497d549e3..f57b449000f7 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1837,9 +1837,9 @@ config DEBUG_UART_VIRT
>  	default 0xfec00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
>  	default 0xfec00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
>  	default 0xfef36000 if DEBUG_HIGHBANK_UART
> -	default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
> -	default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
> -	default 0xfefb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
> +	default 0xff000000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
> +	default 0xff000800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
> +	default 0xff009800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
>  	default 0xffd01000 if DEBUG_HIP01_UART
>  	default DEBUG_UART_PHYS if !MMU
>  	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
> diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
> index 05c5cd3e95f4..e3522e601ccd 100644
> --- a/arch/arm/mach-omap1/include/mach/hardware.h
> +++ b/arch/arm/mach-omap1/include/mach/hardware.h
> @@ -63,7 +63,7 @@ static inline u32 omap_cs3_phys(void)
>  
>  #endif	/* ifndef __ASSEMBLER__ */
>  
> -#define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
> +#define OMAP1_IO_OFFSET		0x00fb0000	/* Virtual IO = 0xff000000 */
>  #define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
>  
>  #include <mach/serial.h>
> -- 
> 2.29.2
> 
