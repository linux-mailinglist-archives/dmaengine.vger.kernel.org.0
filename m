Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96C73C7A2
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jun 2023 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjFXHy0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 24 Jun 2023 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjFXHyT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 24 Jun 2023 03:54:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FAC2D74
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 00:54:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9891c73e0fbso265356966b.1
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 00:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593246; x=1690185246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ItoFIh/55aB/e70WP466UAh+90Zeto+YBld1GOUDlc=;
        b=DjI6EnIt0I30aO4+HTDU2Bee7J4vBxnKRd9UupAVeWwpXVR+/r44DC0Asz08Bbuogp
         A3Aatz82DO8yHVMwWhn1gZCqEe6a2rWXkuiA6GfBUfoZTs2e6cwPHLJ+YuaeHPEUIAQJ
         DJhwVAmDzSax0DlG6oJFsEy6UVQ/dIS8cQ+3QCTL9/CI0CL0ZoRWS02I2uBuEAJJk09M
         Og5/SFPOzVmyQO9aVPrw3zuNNqm8+pzstsdw5EMvXLcY8o+3wfyYcS7e8fj+IvyDLk8l
         BV2H6dDfJXmnGhqVtns8T1Mm5OFcAqbapX7uBCu2Qe31+yaUBaZBymo/wMUBAVDBKbPz
         XF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593246; x=1690185246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ItoFIh/55aB/e70WP466UAh+90Zeto+YBld1GOUDlc=;
        b=aJuo883zfON6i276oMJ2asAE6GqLbwP4XcadKBrHn4sg3TxzqCvNNuUg+BBCP4Xz3C
         NUvUMX2UT23VkVbyAsauh1tBB1g5Ha0Kkk1b9NhzfWRFvYhf3t7xXVEJYlTUBdY3Irmu
         uIlCZE3oTIhuxxAEBQgwWGC8clgty8/gQ2P3lY71JFlMr5l6U77VoJ6yMpJ1JHMzmvlV
         VVqXXoo1GIBN27jw+p5+uQAHkIO5+ZBaGldYihTuAO8o+a+Dj/pRo9aGOyb7YPl1lKDv
         f1trUYm/NlF4z1yEi0odpIHbsHGNyxN7xcm2ks6aGazxAne08yrtMfqNmAnrJA6OVrx/
         O6SA==
X-Gm-Message-State: AC+VfDyyfVnRkk9pkI9UeH34pRDJxbOXKPpMDaeqsaUW3C+fhgIq+xN7
        AGYHd1HFwTpBmEUsddvVsAzTcw==
X-Google-Smtp-Source: ACHHUZ49jFwiXxqnSCSn4kNoVnnSW/YdtiArnK3FxalPv2kaFMQNSvBgECWFO9OcGbSuOPMw0UOLPA==
X-Received: by 2002:a17:906:58d2:b0:988:77f0:b671 with SMTP id e18-20020a17090658d200b0098877f0b671mr14792178ejs.38.1687593246753;
        Sat, 24 Jun 2023 00:54:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u12-20020a170906068c00b0098856d1470csm592132ejb.75.2023.06.24.00.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:54:06 -0700 (PDT)
Message-ID: <4f1015bb-50d3-84c9-ca32-564a0fe204e1@linaro.org>
Date:   Sat, 24 Jun 2023 09:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/45] dt-bindings: usb: generic-ehci: Document
 clock-names property
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, sre@kernel.org, jerry.ray@microchip.com,
        horatiu.vultur@microchip.com, durai.manickamkr@microchip.com,
        andrew@lunn.ch, alain.volmat@foss.st.com,
        neil.armstrong@linaro.org, mihai.sain@microchip.com,
        eugen.hristev@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-4-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-4-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Document the property clock-names in the schema.
> 
> It fixes the dtbs_check warning,
> 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 4 ++++

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

