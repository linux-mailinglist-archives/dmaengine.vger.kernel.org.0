Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69375C932
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjGUOKQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGUOKP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 10:10:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B130C2
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:10:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso17603445e9.0
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948611; x=1690553411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5JLK7sX6TvMY9QYtE4PR7dOD/ZFiOCarXTzuRrPI5c=;
        b=t5k3pZhoG+AYBoSzaTLpzlAUsBlHUl7lB78CDzsmHwjdVVGmyTqDM89ObvufvjSo7f
         hpww35uNlXvCiXjR8Z3Kcy+N16aszSPxdmSW5dXU//lN8o77O3wzYas7eBkvmDyuTUT7
         sy82OO7WlVgpwfI60hPRR6eC7iKohOsXJIAPgLYw0aB9/CoM3vvTnVBOsIhDGWbjAxE4
         jhkNh/RncJk8+BPjG2UwVOec3N1akRHOj8/cli14A3cccbFg1vqKASTYTytAzKfrss4t
         3mJgMR1n+1HqY3oqR8HhDhElYOwuyc2qwRsyyrmAmT2CnaWXqaPG173zYgCNrCSCs7I4
         H4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948611; x=1690553411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5JLK7sX6TvMY9QYtE4PR7dOD/ZFiOCarXTzuRrPI5c=;
        b=G9aCX2pnhwr94vEbaUlcBskU+NQhQdoxD+jMsbMwo59iqcNRbjCnYBhZUqSdR7jT26
         B3J7hhfppYvrwwJQdi88hcHPpiaqDdBVNUcW/w9DQ+0mii3t++hO9xioMzevSScyN8ut
         NAAlzPMKD3BAshoV9DUMsHJ3g4lIKzQGi7wxdHciGJcQR1va0uvGvaWzIDc6LJPI5R2o
         DzPKuL02U2zaEriVHC6MQw5mSMC+X3RaFuSiiXuNXkRxlzsh+uEZNi9p6qzPILaY8ioQ
         4Wqla8eD5K8Ma70oz0atIJIkchzW/RNucKBgAt9oymvhgxYCiUlLMHIoYPaKSdunW9YJ
         dnqw==
X-Gm-Message-State: ABy/qLa9NtqzWpCu8iwnZ3E6r/a48pAgfn/1hfwjHV9sfA8VHz4IB5tN
        8hEz1b7hdkXnl+BtGlq74LivUA==
X-Google-Smtp-Source: APBJJlFb081tRb9TVYsQzjk8z6FX0fbV9IvQdPA+a6dM+X5vTsqrlNWUMOAY9EDzlSX92P91b/1I9w==
X-Received: by 2002:a5d:5145:0:b0:314:14ea:e2de with SMTP id u5-20020a5d5145000000b0031414eae2demr1529517wrt.0.1689948611406;
        Fri, 21 Jul 2023 07:10:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x10-20020adff0ca000000b00314367cf43asm4284464wro.106.2023.07.21.07.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:10:10 -0700 (PDT)
Message-ID: <d8df7f07-ea8d-d382-d3ef-c1f1fb6ccbc8@linaro.org>
Date:   Fri, 21 Jul 2023 16:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 29/42] dt-bindings: rtc: Add ST M48T86
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
        Guenter Roeck <linux@roeck-us.net>,
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
 <20230605-ep93xx-v3-29-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-29-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.
> 

This shouldn't really be part of this patchset. It's not part of your SoC.

Best regards,
Krzysztof

