Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2375AFE8
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jul 2023 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjGTNaC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jul 2023 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGTN3h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jul 2023 09:29:37 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8A2D71;
        Thu, 20 Jul 2023 06:29:23 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7835ae70e46so32916939f.3;
        Thu, 20 Jul 2023 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689859762; x=1690464562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x7oP+tgkV5g5gPIWjsy0lzcqUnb7CSAq9qZKlzt2F6c=;
        b=rIQoiENQDVB93EfK7Iwx+E2mxs3LQ0YPdhj/iK7ys8ALeunIn8wezadJpkQTW+Sjif
         UlzB5oAiRo65QeGsQurJ0qXGhqKvssdTu16jb/Fhkf9SqC8Bc+Rk/BsoxsRJLBYJLXie
         qSkDkv93lfgJS9eeZoTTuLFqvnVba5pEa9rxlsf2P4+u/2Q9YgNlA8/OlETqH0QdCUIx
         f+omEBPKkwxj2rkDHti14N9qCY7Jh/R98b9DjfJKJo0LqwlJxUz0B1WIH6XLq/3Tsr/q
         4DXjtnqzPe7gvYhNRU0XZVUqawMJUtcZ5iUFQMGml0Di+4pHyvV3iE4sXw0M7Z/OaTcz
         y40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859762; x=1690464562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7oP+tgkV5g5gPIWjsy0lzcqUnb7CSAq9qZKlzt2F6c=;
        b=CguvsPosbFs4nDDU8G5fxr9K3wbHcPVB7ZfHBvKgcnpFC0v4mpj78dEBfvgVkHiM5j
         SRdlpbK09w1fbMrDfcccAjn/1Swdt9w3qzWufrHOmsz+QChPxgWRogXGCcp25GHCB/Wg
         vlkVhA3JfR5u3sjH5/U1rCHdoNWBf9AlJbBfeYueWVxPD0MuIDwAE3NCy6hrpIzNvnT5
         cOFHz99phLXsZPItUdMOcRxmZ8SZM9lPI8UfRYc2PbJv5R6rm/u0CRgxcvXRHj1xZEr6
         gUCOn8TEd7W91KbjmJXjprMfoTjoS81uJochbQ+BLYt2aTgaeAYqfu7AvLSN6yqiOlpX
         ADGA==
X-Gm-Message-State: ABy/qLbgsj54N3GlQDPUccApQwNphPKTLFNefKdrzvIV5BKMS9hA1HYN
        flOu5TV1Th+waisks4006Qk=
X-Google-Smtp-Source: APBJJlE+ImiGpXR+XhiWfpQ8DqRAptYIM/vmmrqcxub/OhO7f7vQvGYjfcGO6fmJR6FGooFnlcTVMw==
X-Received: by 2002:a05:6e02:1d83:b0:348:936e:d01c with SMTP id h3-20020a056e021d8300b00348936ed01cmr9173098ila.1.1689859762259;
        Thu, 20 Jul 2023 06:29:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 66-20020a17090a09c800b0025be7b69d73sm1065543pjo.12.2023.07.20.06.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 06:29:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f7d7ed7b-5a12-b393-54cf-eafd51bf72e7@roeck-us.net>
Date:   Thu, 20 Jul 2023 06:29:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 13/42] watchdog: ep93xx: add DT support for Cirrus
 EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-13-3d63a5f1103e@maquefel.me>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230605-ep93xx-v3-13-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/20/23 04:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add OF ID match table.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/ep93xx_wdt.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
> index 59dfd7f6bf0b..af89b7bb8f66 100644
> --- a/drivers/watchdog/ep93xx_wdt.c
> +++ b/drivers/watchdog/ep93xx_wdt.c
> @@ -19,6 +19,7 @@
>    */
>   
>   #include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/module.h>
>   #include <linux/watchdog.h>
>   #include <linux/io.h>
> @@ -127,9 +128,16 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static const struct of_device_id ep93xx_wdt_of_ids[] = {
> +	{ .compatible = "cirrus,ep9301-wdt" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ep93xx_wdt_of_ids);
> +
>   static struct platform_driver ep93xx_wdt_driver = {
>   	.driver		= {
>   		.name	= "ep93xx-wdt",
> +		.of_match_table = ep93xx_wdt_of_ids,
>   	},
>   	.probe		= ep93xx_wdt_probe,
>   };
> 

