Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B78766BB7
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jul 2023 13:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjG1LcV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jul 2023 07:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjG1LcU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jul 2023 07:32:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4782D7E
        for <dmaengine@vger.kernel.org>; Fri, 28 Jul 2023 04:32:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so20663965e9.1
        for <dmaengine@vger.kernel.org>; Fri, 28 Jul 2023 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690543937; x=1691148737;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+F++azjWGXR/zzwHylDS5zKIIkHfazjhU13uoVBCItI=;
        b=AMnkE9WuW7Szt2FbkP+Jy7gImGXicajY9/8nwcsWkrUwhvEUvP7ntHlB4esXk3K8U4
         0i6OvKn+5MRV/VvX72hQyI3+TxZnb6cRN+AlFwW7eoAEroux8iHcBnUojCtWchKA78jl
         SY5zsDpCGe7jFTiAVJefedCk62+1uRl1DCOGCwjHw3AcI7lBvwuS6yZmpan72Z124GkA
         HzuwDVmYWrxvejLrwD5DxuP7Te8Jagm+rkOkbxUiWNpEVTWGGoMyhL+3cuwlWbXGDr0B
         nKgA+tN0Fx8WjnGsZEpQTGxaPoJXDju/pS2BVUhj93heIIMcoWmwxaaXx1t90HNC7HAh
         LaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690543937; x=1691148737;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+F++azjWGXR/zzwHylDS5zKIIkHfazjhU13uoVBCItI=;
        b=Bsz/sWOL/5Mlnx+rC2VHHiHM3gHrAkMTeXk5Od1N3NZlCBnxGCtZlXzkoGHmYP26FW
         E1zFhuIxoI3p8XbYQ21id5GpH/Fk+h8upe18VOi82AUIDgyrjvuXU36wh8hWf7Z4UY/L
         /sNhkgnmInFJMEbFb00LJpuP/t80oTfOAhZ7uCxDjnUE+HZ2Lvul0YET689njtlHCNT+
         U1oV59LdECpTN7p+kyxicqGQgGJzntTpF6LGsUndbepvVOE61TpfyReEXSQra8knN2to
         fhoc22rbLbouozF1OCTmTxyCvGPWuEAQrGDTWgfy/v4SP/Xw9MZQAo+SjIx/UpoEyXFz
         YE3A==
X-Gm-Message-State: ABy/qLbBjDJTRuraF23tnFf0vnOHzttZstdmGyLWq+3tYeUnoXgY36oR
        S5mWMYmocV8KZoyadT20Z6OO8A==
X-Google-Smtp-Source: APBJJlGEkskLn7KheQI/2hh6B8RIJum6fk3h7Nk91C/s4cct7x2FxIqw26uj1lGmelJK6ucVYjt8Ng==
X-Received: by 2002:adf:e94f:0:b0:314:3611:3e54 with SMTP id m15-20020adfe94f000000b0031436113e54mr1907446wrn.9.1690543937250;
        Fri, 28 Jul 2023 04:32:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id m14-20020adffa0e000000b003177e9b2e64sm4508524wrr.90.2023.07.28.04.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:32:16 -0700 (PDT)
Message-ID: <c0792cfd-db4f-7153-0775-824912277908@linaro.org>
Date:   Fri, 28 Jul 2023 13:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/50] Add support for sam9x7 SoC family
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        andi.shyti@kernel.org, tglx@linutronix.de, maz@kernel.org,
        lee@kernel.org, ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, sre@kernel.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        linux@armlinux.org.uk, durai.manickamkr@microchip.com,
        andrew@lunn.ch, jerry.ray@microchip.com, andre.przywara@arm.com,
        mani@kernel.org, alexandre.torgue@st.com,
        gregory.clement@bootlin.com, arnd@arndb.de, rientjes@google.com,
        deller@gmx.de, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        mripard@kernel.org, mihai.sain@microchip.com,
        codrin.ciubotariu@microchip.com, eugen.hristev@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20230728102223.265216-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102223.265216-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28/07/2023 12:22, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added
> 

Your threading is absolutely broken making it difficult to review and apply.

Best regards,
Krzysztof

