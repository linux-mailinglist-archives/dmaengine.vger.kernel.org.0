Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1255F48F9
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJDRzj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 13:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJDRzi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 13:55:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9652627FFB;
        Tue,  4 Oct 2022 10:55:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a10so16221379ljq.0;
        Tue, 04 Oct 2022 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QgxCTgKtdvmNPdjkMmoM5ghrfxtt0usDYHhdkKKlo+A=;
        b=Wt4WMLyZojZ8tIIStbBRyyF1UQUyrL4Shkojh6ysp/OMiuLxu+WcxMQ4Rk9g4xX3VX
         OfnevgIJ4NOBEDi/p0g40h9nMseLV/2XDs0ey7YuRiStKJ2+EDbXFsue1N+wGwmwIthU
         Ab3rO8sFRNOAKBtuWYgYmN0JsSBointi1FjwyEW7nzc/2wHLHhG0sdLea7tpMBqM0atW
         JiUQD3lEh3milMFrLX2YO7nJ9pUPD8eW3vErU/IeKWIS+4DzF/fX/3town3xRTxGF+T/
         n3AAXUXj1d4r6u9U/aPkFZhi23YfkKHFnSHMhlHHiDxntUNQuxT/atD61BP3RM/g1bCC
         hRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QgxCTgKtdvmNPdjkMmoM5ghrfxtt0usDYHhdkKKlo+A=;
        b=vnWT/4I//YIYvfMmAwCUHIy74z+yOydrJpOFkPAGXLIJEeTZB6+pROp2pVIl5r5P5P
         7lqXjVCfVQqv4e1lj3epWUW/aj8ut/jCtgkSqZ1sNpk3mbFlN/JzrZG7/hp5Q9ELayyr
         ZQT9a3WCgPQHLUaz7JLieXNXDydl72BOn4ZXQXvGlIXJgd9OadcYk72CAzoruNAVKOzT
         7sa6XanknPreGJz3SDUK8fbEqgUNVurdyEuKg2Jpa9W0JesnY4K8XPiLS2PkSmkmJSe/
         XIFNgL18/Z7ipVCI2QQrpTewUmoCHC3EEzDnd2J1OlwwsHyXjG3OBYuZd2NJHWB4VS6d
         P7Ng==
X-Gm-Message-State: ACrzQf3wd5jTtHZtQfydend2F5dfWPXeYF56X5AHE6WPK5P6terOo1B/
        N2RleQpjnSnAPOb58amNbdg=
X-Google-Smtp-Source: AMsMyM67m/p+B2iHeDWVa4IzXzN0UNOn9ODz6/pOGFynbscR/dhyWkTcGGZq8jGKwrHiJy//qApwnA==
X-Received: by 2002:a2e:5d6:0:b0:26d:d28b:4858 with SMTP id 205-20020a2e05d6000000b0026dd28b4858mr4011645ljf.445.1664906129874;
        Tue, 04 Oct 2022 10:55:29 -0700 (PDT)
Received: from [10.0.0.100] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id x7-20020a2e9c87000000b0026dcfe9c7dasm929090lji.14.2022.10.04.10.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 10:55:29 -0700 (PDT)
Message-ID: <9bdee3dd-3bfa-3965-ad4a-11c6a3308928@gmail.com>
Date:   Tue, 4 Oct 2022 20:55:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 0/3] dma/ti: enable udma and psil to be built as
 modules
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>, dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
References: <20220929234820.940048-1-khilman@baylibre.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220929234820.940048-1-khilman@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On 30/09/2022 02:48, Kevin Hilman wrote:
> Enable the UDMA driver & glue and PSIL lib to be built & loaded as modules.
>                                                                                                                                                                                 
> The defauilt Kconfig settings are not changed, so default upstream is
> still to be built in.  This series just enables the option to build as
> modules.

Thanks for the updates, I can re-affirm my ack:

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> v2-v3:
> - change dma/ prefix to dmaengine:
> - rework Makefile order for PSIL lib
> 
> v1->v2:
> - rework PSIL lib into a single .ko
> 
> Kevin Hilman (3):
>    of/irq: export of_msi_get_domain
>    dma/ti: convert k3-udma to module
>    dma/ti: convert PSIL to be buildable as module
> 
>   drivers/dma/ti/Kconfig        |  7 +++---
>   drivers/dma/ti/Makefile       | 15 +++++++------
>   drivers/dma/ti/k3-psil.c      |  2 ++
>   drivers/dma/ti/k3-udma-glue.c |  5 ++++-
>   drivers/dma/ti/k3-udma.c      | 40 +++++------------------------------
>   drivers/of/irq.c              |  1 +
>   6 files changed, 24 insertions(+), 46 deletions(-)
> 
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868

-- 
Péter
