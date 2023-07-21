Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C442375C9E6
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGUOZV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 10:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGUOZT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 10:25:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835763586
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:25:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso17740365e9.1
        for <dmaengine@vger.kernel.org>; Fri, 21 Jul 2023 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689949510; x=1690554310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsB9IpIa7yRoJhopQrOjvBc0s3b3yy++co3a2B1PcYw=;
        b=qIJ3m7pumTVMjEg+kn7UzsmtHcvDLZMe1tywd8h4kIEFsV1IUMrLWSP7L1Gefi6ja3
         JBnA+rcRqypgsH7goHOUSHZMKZ550EJ6VKVD5dUqYgKEkPNc0iL/P3ucMWjqHbEFD/T0
         wpz6/3MqeieB5gRPCUiu4XZk3Zcu+o+NiGcka0anh/l9hHDrOL+VgYR/KE3ZF2zZOnUD
         MAb1XtMCn/3lpC4gapmNe+wJJXmYQVNJ5+2pOFPrvODAU/4zuO7v13RiM6wLSxsILcjv
         9HuP4O5p+Mpx4YbyqytkaZCphFp9jaYoEi2g4JOc8CmYsngHzwdRUEDe9eA+ql9xnfQE
         Ybww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689949510; x=1690554310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsB9IpIa7yRoJhopQrOjvBc0s3b3yy++co3a2B1PcYw=;
        b=V1m/XFAx+FT6UQp789o6wd6GXSpzMpfjc28nGra4GN17VUxbgCiY7UGAAFCiqGARto
         7iWTkudG1N5bOao4ddSJjTUNPL4xFMAw0gPQgbmoG914zZLqXZRSjQj+G5Gs2szsZjRU
         gk/21MqXTMaogdPNiDSnnJi091TMD+M55bWRKCrd5IzFgxQzYaQrTbmmOI3RdBUzrJo2
         JCQ6Ci2IDEBPz9Ah8F/3PfBYRmPWvGOsxO0eyj861A4uQ+/TgWH7Z/MQE+IlzrzWo+SH
         dlEUpKvbfoR7OdvhWaaQbn3ntz+9gpKSCetEpmnVtl2HcZIoOVBTOYcbNkEr7hcJFvKw
         Tz1A==
X-Gm-Message-State: ABy/qLZlceAYqkL9WBz45vsKKxZkiIKLqXo7j5Hv4tszW7e+2a2nxVEG
        khvcImad6Uz/EabwyQfHf45qHQ==
X-Google-Smtp-Source: APBJJlHgaQ/Hte4XJbr1gx4ukptPaEvJZwQtCDry0efXozCJTjG5+/5hX3FKNFwXVDpSO/L62wwYsQ==
X-Received: by 2002:a1c:4b0e:0:b0:3fb:a576:3212 with SMTP id y14-20020a1c4b0e000000b003fba5763212mr1443887wma.39.1689949509998;
        Fri, 21 Jul 2023 07:25:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q9-20020adff789000000b003142439c7bcsm4349281wrp.80.2023.07.21.07.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:25:09 -0700 (PDT)
Message-ID: <4313820e-9ddf-0a34-0cca-e356a4314c61@linaro.org>
Date:   Fri, 21 Jul 2023 16:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/42] ep93xx device tree conversion
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
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
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
> This series aims to convert ep93xx from platform to full device tree support.
> 
> The main goal is to receive ACK's to take it via Arnd's arm-soc branch.
> 

This approach makes patchset trickier to review with absolutely huge
Cc-list and inter-dependencies. I don't think this is correct approach.
This should be split per subsystem whenever possible.

Expect more grunts and complains from 50-other people you Cc-ed.

Best regards,
Krzysztof

