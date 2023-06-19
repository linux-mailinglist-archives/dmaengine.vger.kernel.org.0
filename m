Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85628735E0D
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjFSUA1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjFSUA0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 16:00:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F9E4A
        for <dmaengine@vger.kernel.org>; Mon, 19 Jun 2023 13:00:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so2041711f8f.3
        for <dmaengine@vger.kernel.org>; Mon, 19 Jun 2023 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687204823; x=1689796823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvEnF7N3Rq3oH07tQdzeQod4R0+TvmTxdiOQqeQGOJA=;
        b=xhU+bDOzMgV6Bi9+BjZUNyeWebJXGz2o23nN5Bsna386B3ZEGEEA5Tug4F1Gt09YNg
         9xaQAehTU1a0iJRf2KpZnAOU3CaGHJR7/jOTXORoIH0hccZaReFHVrDSF3H3saFXxP3X
         nT7+ZHvuxAzx6A+S3oRYMLyGPpkNHfwz8rgqxs5yZGg0jRaJhqCWceHupQ1mkqffaITQ
         rzmLtcmLhC1/jFxPFb8Wu1+Ayn0DaeQuXOC34dY5Fq0yvajEwZ9FNn0qJUWOy8FLHxJU
         6sUTl/M7BoMw+jwozwi4ifeYmYLuvsJG15aTfeD6R9S6BtQEi+NZ0+u3KiBwZClSHlk4
         T5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204823; x=1689796823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvEnF7N3Rq3oH07tQdzeQod4R0+TvmTxdiOQqeQGOJA=;
        b=W8rkhJIDhOXkC6fi4YH5eomH8z4CFW8/4r9km8gPmv2PjWbWyYcsusXEl/d2GJN8bu
         ZiALIZSmPo8+sBa0U+1sqxnENc9cM/q6JXMP3QhbKGK06xeCy/sKp2chrNCBI7h1oETS
         W0sAyV1rNk+lyHpPfrfaTWoDsnafdKOrcJTNU1PCJZZqAbvEKXmpRaD/ysyQ5DQbjSrk
         o2+/SVdNe9hoJk9yzxEU5mW5mNv0bE0ziPtMtIk0odtI1WGv8gKNcVX0OoFEn9H/tQDq
         yQZGUtXdINI2z03d/4E7ACO+7AELV3yRDFkLv/gQqOajjaHj04I4ilGKxa+ljJXvGu37
         AgEg==
X-Gm-Message-State: AC+VfDxxyWmRTu0L1bNMCNhdaI9q28kUeZHPF8a+aKtOFe8vHpf9vt+0
        Xkmo1UnP8HQ7KMiBzMHVkaiL0w==
X-Google-Smtp-Source: ACHHUZ6R6jKhoJ5uyp4V5CmGcPmfGFuRGd6KbYqbL4TK6F7Tjqsr9xjBMW8Kr9m0FfLnKjEoJrySJg==
X-Received: by 2002:adf:e7d1:0:b0:311:9a5:2d63 with SMTP id e17-20020adfe7d1000000b0031109a52d63mr6907950wrn.42.1687204822221;
        Mon, 19 Jun 2023 13:00:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id z5-20020a5d6545000000b003113bd9ecaesm303041wrv.116.2023.06.19.13.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 13:00:21 -0700 (PDT)
Message-ID: <17a460d0-618c-b1f3-0b53-2ebab72b1311@linaro.org>
Date:   Mon, 19 Jun 2023 22:00:20 +0200
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
 <02d1d74a-1476-41c8-6d94-3eb477352309@linaro.org>
 <543ca0c5-0051-3968-63cd-7982f95c06c6@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <543ca0c5-0051-3968-63cd-7982f95c06c6@i2se.com>
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

On 19/06/2023 20:57, Stefan Wahren wrote:
> Hi Daniel,
> 
> Am 19.06.23 um 19:00 schrieb Daniel Lezcano:
>> On 17/06/2023 15:36, Stefan Wahren wrote:
>>> Convert the DT binding document for bcm2835-system-timer from .txt
>>> to YAML.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   .../timer/brcm,bcm2835-system-timer.txt       | 22 ---------
>>>   .../timer/brcm,bcm2835-system-timer.yaml      | 48 +++++++++++++++++++
>>>   2 files changed, 48 insertions(+), 22 deletions(-)
>>>   delete mode 100644 
>>> Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>>> deleted file mode 100644
>>> index 844bd5fbd04c..000000000000
>>> --- 
>>> a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>>
>> Appliedp patch #7
> 
> i'm so sorry but i accidentially added a Reviewed-by from Rob, which is 
> wrong here. I should have added to the patch 6 :-(

No worries, I'll drop the patch and wait for its Acked-by

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

