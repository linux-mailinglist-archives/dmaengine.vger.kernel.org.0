Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A6A64FB1E
	for <lists+dmaengine@lfdr.de>; Sat, 17 Dec 2022 17:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiLQQy4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Dec 2022 11:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLQQyz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Dec 2022 11:54:55 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEFA120A9;
        Sat, 17 Dec 2022 08:54:54 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id v11so5152523ljk.12;
        Sat, 17 Dec 2022 08:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmEYNEeXTHN9jLFf1JOekZjqFW60u0oAeXrnu+MyxkM=;
        b=oYmUzwA7jCS8pg/B15UxwynMnEEs9tp8cleAQSrMviky8HwmLw/0J3swevMT4ZsJGg
         oN6WjOVXKdA6q2mAUqPP4oXxlvWA6ZjWioH4yNaGL6V+7FIoLkqGWP5JKBoEQFqePWO5
         okzWqaRairbWd4OHquq63d9mRTZ2wW1XPmYmNi37D4D4C6EYh7ett8VHhxRU0kyf1hH4
         Jn4+7AdJGhA9681mvx9cEZzq74ahhSZxqHXEiZFBPLmpMnx9jveQr2YNYrx7OJEp/atJ
         qHXWB1AGaJ7oKSCGrnHBIO8H6BRF0V5cfEE7Ei4qSrmt+CaSukxndqBoHGJRZuV25djJ
         tE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmEYNEeXTHN9jLFf1JOekZjqFW60u0oAeXrnu+MyxkM=;
        b=YtLNxqp1hqbwzR8njJLKO0wOQ/DWDDtYJ5HLpWrjo1dfHPyEc/i0NuDjm8PPzP0q6c
         xBSM7vMTPrwMYi9SCk+uMVOHdKs7nqXINwcCTe68h86S1wtbNHd4HdEo8ETEBPbBUNFv
         I+3H+MSt7S6m0iSNdcnyIm4Aqi9cPGvLWvQHMR2JstWs5TOZ3Qf1hQ9zV5mL6X4BQQXI
         HWp9hX4XC2ZB/zJ/31LErTJvCCPsB/29feKr8KplFyBNCrowsmtqbrecJqR9MsFAxX51
         K7+JUFcXrHkGseNkbkKxHRGRwmkC0aWkHsPAeUvu7/4cVpnp8NIBTQhj7QBeHWck8Skw
         9QaQ==
X-Gm-Message-State: ANoB5pkyV8qRNrsImpE8LS4H0xFh2MGz02HJ8341OBJk5UnvizVdcR+I
        SAtJ5o80P+Wcjzj1a1x/RVw=
X-Google-Smtp-Source: AA0mqf7ZnOsDxJcqwctnB8cdwtxcRn/GD9vgbD5H9+Uhcx2pMNVWDcUIBwfrn+V/TpARePmcYVkJWA==
X-Received: by 2002:a2e:bea7:0:b0:279:d51:db93 with SMTP id a39-20020a2ebea7000000b002790d51db93mr12677365ljr.11.1671296092244;
        Sat, 17 Dec 2022 08:54:52 -0800 (PST)
Received: from [10.0.0.100] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id r21-20020a2e8e35000000b0026e04cc88cfsm398636ljk.124.2022.12.17.08.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 08:54:51 -0800 (PST)
Message-ID: <bfe79fe8-9f7c-6bec-7867-e75bac89438d@gmail.com>
Date:   Sat, 17 Dec 2022 18:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/5] dmaengine: Add support for AM62A SoC DMAs
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221213164304.1126945-1-vigneshr@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20221213164304.1126945-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vignesh,

On 13/12/2022 18:42, Vignesh Raghavendra wrote:
> This series introduces support for various DMAs on TI's AM62A SoC under
> K3 family of devices.
> 
> Apart from usual BCDMA and PKTDMA thats present on K3 family, AM62A has
> a dedicated BCDMA for camera (CSI) with only RX DMA Channels.
> 
> Patch 1 adds bindings for this new DMA instance
> Patch 2 fixes a bug that gets exposed due to RX only DMA
> Patch 3 and 4 add base support for AM62A DMA
> Patch 5 does BCDMA CSI RX specific enhancements.

Looks good, thank you,

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> v3:
> Fix yaml bindings to constraint regs and reg-names per compatible
> 
> v2:
> Fix k3-bcdma.yaml as per Krzysztof 's comments
> Address's Peter's comment on 2/5
> https://lore.kernel.org/r/20221212105416.3628442-1-vigneshr@ti.com
> 
> v1:
> https://lore.kernel.org/dmaengine/20221206043554.1521522-1-vigneshr@ti.com/
> 
> Jai Luthra (1):
>    dmaengine: ti: k3-psil-am62a: Add AM62Ax PSIL and PDMA data
> 
> Vignesh Raghavendra (4):
>    dt-bindings: dma: ti: k3-bcdma: Add bindings for BCDMA CSI RX
>    dmaengine: ti: k3-udma: Fix BCDMA for case w/o BCHAN
>    dmaengine: ti: k3-udma: Add support for DMAs on AM62A SoC
>    dmaengine: ti: k3-udma: Add support for BCDMA CSI RX
> 
>   .../devicetree/bindings/dma/ti/k3-bcdma.yaml  |  77 +++++--
>   drivers/dma/ti/Makefile                       |   3 +-
>   drivers/dma/ti/k3-psil-am62a.c                | 196 ++++++++++++++++++
>   drivers/dma/ti/k3-psil-priv.h                 |   1 +
>   drivers/dma/ti/k3-psil.c                      |   1 +
>   drivers/dma/ti/k3-udma.c                      |  41 +++-
>   6 files changed, 295 insertions(+), 24 deletions(-)
>   create mode 100644 drivers/dma/ti/k3-psil-am62a.c
> 

-- 
Péter
