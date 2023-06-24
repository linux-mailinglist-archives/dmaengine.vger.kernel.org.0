Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B150F73C813
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jun 2023 10:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjFXIAk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 24 Jun 2023 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjFXIAf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 24 Jun 2023 04:00:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24682D74
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 01:00:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so4551180a12.0
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593616; x=1690185616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plRq9uRX7lb7dTEBq+/7uDl8MLqphJlYEezgY+W1p9o=;
        b=a43pJHJ0/i79GK0sVllmNDFxmLRvG6mdn29k3MDLUJpDO/vAzPg3YyQ818IBbmxC/u
         1gtZ48SyfAQ5B6l0nPXN+iauyWfgfXlbH0dfibAQKneNTKdjh2/VHLoEKzIxurh9DBP5
         ygKyuWkrfxIEeg0x0Ulo13gCWxCoWUMToLkqHYl6h6s3s4qa1bsqQQrA6iOgzlG7pLl+
         dIYVYidPvnGoTN3V2N4aRfUTueCnlqRpbuIYXLGn2MIJJvK807soiNVOfavxJ/gbhjQH
         difhgo70gZBHNBdb4AvayK2zERp3uN7fHKNQxbBPF+9B6cl2sxkR8NHUfutycTaQtmog
         Ussw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593616; x=1690185616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plRq9uRX7lb7dTEBq+/7uDl8MLqphJlYEezgY+W1p9o=;
        b=MMtMOTQ/bzarHTXCruL7oc9CAKaIN/J9ilKYyNZN/o4lfPy0ZZ0VGc93qrG2M6Alhd
         xaIx2tEYYOlEGp/4PQPynVV80czpQZAtNwhEpxrNYPlyqHNDkqVTYMldQQI9t8ciFl91
         L6fIz7V12Hhh37WvtU9FG/jMHehPtEsoZ6dtmOa2PhpQBPsEwgybJrca3W8e9ZCKEUZO
         WMSz/79BqwgDVLiPRMygxd0SU2eqJPbogYLXWY81rBCxyIkDvh4VoK69rr9ZEVI/aYwJ
         +bf9Asu3ERKEreeDMEYsV1f706Dlq7OUgmPXmztOLu0nb/RnSvU0jhj56z5MszFTxSKn
         dDjw==
X-Gm-Message-State: AC+VfDzXGxmne/VNsMy8ZcKC8MZpG81CIkAixD4hBdkB9pRkFrA35VHb
        PCGAlcmSgnOiEV9mrCfmOG1ZWg==
X-Google-Smtp-Source: ACHHUZ6M3mY16cNIWWFFSaJhLerF0OTUcHm2JKoX1SNGPbnrXFGF7T+AVx68dGzEKp0F0dxMjJC17w==
X-Received: by 2002:aa7:da90:0:b0:51b:de6f:2182 with SMTP id q16-20020aa7da90000000b0051bde6f2182mr9641369eds.8.1687593615898;
        Sat, 24 Jun 2023 01:00:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p18-20020aa7d312000000b0051a2d2f82fdsm422074edq.6.2023.06.24.01.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:00:15 -0700 (PDT)
Message-ID: <b837784a-50f0-7cab-a535-e699688640e5@linaro.org>
Date:   Sat, 24 Jun 2023 10:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 13/45] dt-bindings: atmel-sysreg: add bindings for
 sam9x7
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
 <20230623203056.689705-14-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-14-varshini.rajendran@microchip.com>
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
> Add RAM controller, shutdown controller & SFR DT bindings.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.

Applies to every patch, since there will be a v3.


Best regards,
Krzysztof

