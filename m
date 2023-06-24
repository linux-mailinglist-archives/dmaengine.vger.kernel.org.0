Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1A73C928
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jun 2023 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFXIZx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 24 Jun 2023 04:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjFXIZF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 24 Jun 2023 04:25:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713BC30D8
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 01:24:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1012874a12.0
        for <dmaengine@vger.kernel.org>; Sat, 24 Jun 2023 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687595042; x=1690187042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rmdMg6KqyfM4vHKUpwecy9214du+qFl2Fy/UDsrrm4=;
        b=TvwuTD1hCQ3nAnAEpHE885dBBw4DHnfj7ey5fw+Ut93n/UtCNrwY7zyxy+yJ2oyrMH
         sxHwRJzUJSZ/bSL6g42Wlt6bH+FNB8GXTMRXJHp2yIWUR3vuJAEuFs0XV22u+npYhezV
         jM6N9NOBgpVT757Eu0gl5uSwDlFQwyf3Imb1S4hpCRDhP7KHj8DryeuHFasi+M2hQwlP
         5tELy8f7cVXULLPBAh3GxkbkHFgiBasCTU9Sp/mcHqEe+UyaSC/SKiyqCadgZmZ40bFK
         +/vlZw/erX6ARWTIiHOAF0g1NYYIdeZ3hT6m6rnlSB70vaJkO/1E/y4zDlLiBzNmi4nw
         heww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687595042; x=1690187042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rmdMg6KqyfM4vHKUpwecy9214du+qFl2Fy/UDsrrm4=;
        b=dpBDbnGTCLYH+mKZAvUkJibC665BlHllEmP8pR+QutxjfyrUovYu93JZlKzmMGtGvo
         mz9+KzdG9k8u0qtPfGks8K7vMaRyhVVdNIx+E3yTYXcYkQZeOFwun/e9QiW8NiW5T14M
         TI8WPM52+NqKXTQyfiHzz535DYLxzdvnO28FGcV7zuiJRNrzsGQPFx6mxXiD4R+iTwuq
         PFmykHVy6TXeIWCMuaoXv+z/IlHb6oS6lOZmW6P9Cx1N8Vc1VvIfvFx03/Yakl5qWPVd
         t7kPqmkZKMPwjHESWuz2aPezKTC3I0EDAl3e5KN65ojdc9jHVStyjaZnRH+i8kS0W7Q4
         kF+w==
X-Gm-Message-State: AC+VfDz3f6vs3IUsFIGX4OPiLMmQ+1vqxi39476Por91nPuSfjQ1+Meh
        ztiuy8RFcUyIdKHzQSn3Y6c5Ig==
X-Google-Smtp-Source: ACHHUZ5uBeAmtj/QzF2pyScKZoEXKfoalX1DGZidPH3H+lFnKKTjF/iE5DlV5Gq3MvXs8SEHiYbmvg==
X-Received: by 2002:a05:6402:1d49:b0:51b:d59f:8518 with SMTP id dz9-20020a0564021d4900b0051bd59f8518mr12391317edb.16.1687595042718;
        Sat, 24 Jun 2023 01:24:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y11-20020a50e60b000000b0051bdd068492sm423197edm.52.2023.06.24.01.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:24:02 -0700 (PDT)
Message-ID: <c2dfaa33-3d37-75b6-3035-cd6b70d87b07@linaro.org>
Date:   Sat, 24 Jun 2023 10:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 20/45] dt-bindings: atmel-gpbr: add
 microchip,sam9x7-gpbr
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
 <20230623203056.689705-21-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-21-varshini.rajendran@microchip.com>
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
> Add microchip,sam9x7-gpbr to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-gpbr.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt b/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
> index e8c525569f10..2cc39524af8c 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
> @@ -6,6 +6,7 @@ Required properties:
>  - compatible:		Should be one of the following:
>  			"atmel,at91sam9260-gpbr", "syscon"
>  			"microchip,sam9x60-gpbr", "syscon"
> +			"microchip,sam9x7-gpbr", "syscon"

That's not what your DTS is saying. Srsly, just open the DTS and compare
the list.

Best regards,
Krzysztof

