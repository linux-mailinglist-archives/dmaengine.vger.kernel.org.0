Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4417075B560
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jul 2023 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGTRRS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jul 2023 13:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjGTRRR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jul 2023 13:17:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82CB3;
        Thu, 20 Jul 2023 10:17:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666edfc50deso756139b3a.0;
        Thu, 20 Jul 2023 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689873435; x=1690478235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0uAt1FpVvgdk69DWGVo/B/WilumnjHo3ckls2wQj2c=;
        b=MK+qmNNORXwB0I5M1ECJrML+kKdViRer5kBwEH13jqFqWPrvH9qpVwD+NCq/1d018c
         dmHLfc1tu6kO/ikoIBoIR1krTQBsGZ3+q9u5v3XSZyYbOkyC67YXvHVlcxgsQWsqZgtm
         4SH2TD93EzA0VP1rFamx/Cxpixhc1xvinZAjcekhOe3ngbMxphygvDdsOviDfTtnsbmZ
         umZ7UPenNo+uzSz1TkMIjeWQt9QLKY1ACnKSlpgNnzP7MRX/LNX+PoEOdVdbQQ+Lidiy
         cOGFq119CJN/FS7RftR/9pmwUsBDbw0jIdcDb2SJf2KjVezldwj7jUFTSW8pAI6VW6KZ
         ONLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873435; x=1690478235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0uAt1FpVvgdk69DWGVo/B/WilumnjHo3ckls2wQj2c=;
        b=SLm+b5tlr6idsm/Yh1OQVSEsFtlc4bsB3oIrbg7a6piuUQm/ZuPan8n2n9DoPkTLMu
         wOouxBPgOKjtdycelh+Owyg+FDTD0XDr5FkceD9DjC2JO9ZGhEkYrn2RgXAIzMDXsPGf
         1LYkpSfQ4zZ4qa5xSLiLDYP0dRKJZfvektyxQHUzLoAw9Qbkcx88gONRfKUEjNfWOov5
         zF/IbP/LYpNHxyPMk3dvhisJ13icMpMyjE1vecx4ABbVH0H+VJGPWgs4YzcvcofaYH4U
         OQMa9/VHWCtt1o/JRYPVylphSmNgbiBQ3tnl3FjdrUeiu+1sF1cbQbhq+/T36KjnLrHn
         jaYg==
X-Gm-Message-State: ABy/qLar+Z0aibssi6q/TIvf/KkwNyztO8QdBYkuDZzdKZQurFJJ8eFs
        6fxfpq4tfyo3GsfUyGmvies=
X-Google-Smtp-Source: APBJJlEkTI4A4ZrOCc+WXlC2nBipWy2JSRmd1c5HMwU8MruA6yjpC2qz2tfZemAEl4HUzSYjKYO5qQ==
X-Received: by 2002:a05:6a00:24d1:b0:668:8ad5:778f with SMTP id d17-20020a056a0024d100b006688ad5778fmr10559001pfv.17.1689873434754;
        Thu, 20 Jul 2023 10:17:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e754:74d1:c368:67a2])
        by smtp.gmail.com with ESMTPSA id h18-20020a62b412000000b00682a75a50e3sm1502944pfn.17.2023.07.20.10.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 10:17:14 -0700 (PDT)
Date:   Thu, 20 Jul 2023 10:17:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
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
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 28/42] input: keypad: ep93xx: add DT support for
 Cirrus EP93xx
Message-ID: <ZLlsFTe2nvFw698l@google.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-28-3d63a5f1103e@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605-ep93xx-v3-28-3d63a5f1103e@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 20, 2023 at 02:29:28PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> - drop flags, they were not used anyway
> - add OF ID match table
> - process "autorepeat", "debounce-delay-ms", prescale from device tree
> - drop platform data usage and it's header
> - keymap goes from device tree now on
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

This is awesome, thank you!

>  
>  #include <linux/bits.h>
>  #include <linux/module.h>
> +#include <linux/of.h>

Are you sure you need this? I think the only OF-specific structure that
is being used is of_device_id, which comes from mod_devicetable.h that
you include below.

Otherwise:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry
