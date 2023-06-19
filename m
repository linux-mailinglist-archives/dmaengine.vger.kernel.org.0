Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6F735C97
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 19:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjFSRAt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjFSRAe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 13:00:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47183
        for <dmaengine@vger.kernel.org>; Mon, 19 Jun 2023 10:00:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3113dabc549so1928351f8f.1
        for <dmaengine@vger.kernel.org>; Mon, 19 Jun 2023 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687194030; x=1689786030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9cC6PmdgFB3dmV/UgdM6HFPYJf6kvpGv+r5GF+eElo=;
        b=pyYJ0ecrVQtXpGNU+ZRJZg3+hbL28pf71ya83iW44CI4j0NNoqmbIrbRrlow45S9lA
         vSPJrD2X5CLDvKHSEKLFvN5yR/vVcwXyitzWLhz8tBvhD+yWTdQK6VvH9bp5vpEezzxx
         sCQM4+SCWwbgAV/ZKNdZDhzC78vKAC12Slsi3TkSOJ65PYzE43P1z2q4/b225YCrktze
         vlpBiCKmaS+4Ibssg9zV3Ap9UlzhIpzbXqriPN4hXJi//cKpvXd7PRgfRP/HEwm1Nn1F
         uY8zKHIhkBEPZmxqi3A8zr2DBF8dN89gm5ObqNvmxJ3SsB3jMNeQ8GbvOnaYDrjIakNT
         GAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194030; x=1689786030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9cC6PmdgFB3dmV/UgdM6HFPYJf6kvpGv+r5GF+eElo=;
        b=UpJ0x9QYKoIeFCDLlbhKS4Ip8cXZSEyLsNTmwEurP1eK09pMjMtTl+daZn76qfjFG8
         Q/leJFNUn0EU2S3cxdNvQxYri0k+CTgdZ7qgTuskaEIwR0F7t9BIFd+L6h1/RiNR8oFy
         EvNaMRocRNedunzz3mSsS71bZ/RhK+QIa6khKtaQ3/YV7I3pIoIhbU57eBrzZoTxoH+H
         g94BtVL01WonxU8QzvvNdSKtOaktXpuCaPeWEdHCW19JM1DXdYIlakgb2aUVjtr2jIR7
         uU2MkkgNnVNlmSSgXVXJrRdeNlmJv43GpmEskLec/oZIJEGV8EheERk2KTfV0hP/Fwf+
         wGaQ==
X-Gm-Message-State: AC+VfDxMgnRIYsFBfi2Cw7oeaDnFyrsRxO3zY3MLtMC4sb50PLHT0+yG
        jgk4dqNdvtjekcf5RuZAzMYAaQ==
X-Google-Smtp-Source: ACHHUZ57ZuumhzoQNKjArX+8R9YWVwcao74uXIcV2RWHv3gkjItsMeBZphaKz+rx/tzNZrXtw46azw==
X-Received: by 2002:a5d:444b:0:b0:30a:e619:3a71 with SMTP id x11-20020a5d444b000000b0030ae6193a71mr8985866wrr.23.1687194030283;
        Mon, 19 Jun 2023 10:00:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id v4-20020a5d6b04000000b003047dc162f7sm6308wrw.67.2023.06.19.10.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 10:00:29 -0700 (PDT)
Message-ID: <02d1d74a-1476-41c8-6d94-3eb477352309@linaro.org>
Date:   Mon, 19 Jun 2023 19:00:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 7/7] dt-bindings: timer: convert bcm2835-system-timer
 bindings to YAML
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh@kernel.org>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
 <20230617133620.53129-8-stefan.wahren@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230617133620.53129-8-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17/06/2023 15:36, Stefan Wahren wrote:
> Convert the DT binding document for bcm2835-system-timer from .txt
> to YAML.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../timer/brcm,bcm2835-system-timer.txt       | 22 ---------
>   .../timer/brcm,bcm2835-system-timer.yaml      | 48 +++++++++++++++++++
>   2 files changed, 48 insertions(+), 22 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>   create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
> deleted file mode 100644
> index 844bd5fbd04c..000000000000
> --- a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt

Appliedp patch #7

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

