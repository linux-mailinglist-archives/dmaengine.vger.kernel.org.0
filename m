Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF677C9BD1
	for <lists+dmaengine@lfdr.de>; Sun, 15 Oct 2023 23:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJOVSQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Oct 2023 17:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOVSP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Oct 2023 17:18:15 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C0A1;
        Sun, 15 Oct 2023 14:18:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80B0EC0004;
        Sun, 15 Oct 2023 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697404689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QyLwk8RWeHwb+iTYV4j14/CAsO9UnmgTLhIoR7pcM84=;
        b=G5I8ztJvdFI8tTwSCy0AWY+6MRhNlKLte1yNV4fIGQl6O23J6Xdoh0CefROrNByOpZhwE7
        P/dmdthsO5WAs8rqcbBfrDUN9cugU7l4OxjWmfddhyL0LuZ/a6CfmZiXNmu06TC7W2khE9
        NDZu0i9NIxBjr696iBip4sRRM3d0VMBYV0oc5glex8E5b5g9pnVjfW5fIkCPQERxPzL1Jd
        mjqglreUfQeV1UDlGgRG/+b2MG2/c1Vo/UDOnu2p9/qVGfq8Q3Iz2g50VMtUD0J76grZyh
        DkuCxT22BotwyKZelbq33dd3q4OFLHJ92smEnKVwc5a4qUfDVLMQmLsddUpmAw==
Date:   Sun, 15 Oct 2023 23:17:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: (subset) [PATCH v4 00/42] ep93xx device tree conversion
Message-ID: <169740466288.180093.13375010968334465004.b4-ty@bootlin.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 15 Sep 2023 11:10:42 +0300, Nikita Shubin wrote:
> This series aims to convert ep93xx from platform to full device tree support.
> 
> The main goal is to receive ACK's to take it via Arnd's arm-soc branch.
> 
> Major changes:
> - drop newline at the end from each YAML files
> - rename dma and clk bindings headers to match first compatible
> - shrink SoC exported functions number to only 2
> - dropped some ep93xx_pata fixes from these series
> - dropped m48t86 stuff from these series
> 
> [...]

Applied, thanks!

[13/42] dt-bindings: rtc: Add Cirrus EP93xx
        commit: 207bddd97881913bcb8bef84737c0971e712fbee
[14/42] rtc: ep93xx: add DT support for Cirrus EP93xx
        commit: 1d70f9fe5f1c8fbd5d838223b8aec27c69a7e609

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
