Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7845FA612
	for <lists+dmaengine@lfdr.de>; Mon, 10 Oct 2022 22:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJJUZA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Oct 2022 16:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJJUXn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Oct 2022 16:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC924B0DD;
        Mon, 10 Oct 2022 13:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 661D6B810B5;
        Mon, 10 Oct 2022 20:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF38C433D7;
        Mon, 10 Oct 2022 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665433216;
        bh=DMGjMyu5C0L96dKcCyOonQyj8xCaUAQ7WEcc6TEXH5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qiu6R90bakIk/iJ69oJSphwso4hq3oylnE8JPy4FzBMLuPLVxDjMzbolb73W4P0Th
         75g30LacqQg7PWYK6RqRqrTxFWW5Vz953YRzSlxZAv0pmWhUldY8xX79qCLpWJg1gg
         pzGMGMbuR0de/qwxZ3kGhC8SZrDFIy75K6/L1rtw=
Date:   Mon, 10 Oct 2022 22:20:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 7/8] serial: 8250/ingenic: Add support for the
 JZ4750/JZ4755 SoCs
Message-ID: <Y0R+q7BdxtFqeiT1@kroah.com>
References: <20221009181338.2896660-1-lis8215@gmail.com>
 <20221009181338.2896660-8-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009181338.2896660-8-lis8215@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Oct 09, 2022 at 09:13:36PM +0300, Siarhei Volkau wrote:
> These SoCs are close to others but they have a clock divisor /2 for low
> clock peripherals, thus to set up a proper baud rate we need to take
> this into account.
> 
> The divisor bit is located in CGU area, unfortunately the clk framework
> can't be used at early boot steps, so it's checked by direct readl()
> call.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_ingenic.c | 39 ++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
> index 2b2f5d8d2..f2662720d 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -70,7 +70,8 @@ static void ingenic_early_console_write(struct console *console,
>  			   ingenic_early_console_putc);
>  }
>  
> -static void __init ingenic_early_console_setup_clock(struct earlycon_device *dev)
> +static void __init ingenic_early_console_setup_clock(struct earlycon_device *dev,
> +						     int clkdiv)

What does "clkdiv" mean here?

And this function is rough, adding a random integer to a function
requires you to look it up every time you see this call.

If you only have 1 or 2 as an option, just have 2 functions instead
please.

thanks,

greg k-h
