Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4784BD13C
	for <lists+dmaengine@lfdr.de>; Sun, 20 Feb 2022 21:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbiBTUPi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 15:15:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbiBTUPh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 15:15:37 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3651E4C42E;
        Sun, 20 Feb 2022 12:15:15 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e17so11806497ljk.5;
        Sun, 20 Feb 2022 12:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dXOCiPEEwmti8ibCuzkAcx2DIodwzBlROl4n6OrpWLA=;
        b=IIfYoPI0PkCdIrxYAoTKVdxPxjqqtZnRFD3KW4M2hzPNVrrkOkledY7EUk+AgpSeET
         Y3XF9jYzYVUfCUDZsJA/Dkg5g3AgnELSo+CtGyOFABRc4sJByu6Lnj867gC5OMWfL1ib
         fhHE8SPIztfjWVnEapo+APWjKAL47C52/hDy2OKHAmX32PrVnSSVGo0S2FE6r//riTCb
         TR09bmLRJhslXaJ+o1y5Hvn60x8Mduhj71wMOiGMTAGV6fEezAFUZJ6gjgkuZm0a80yt
         Mi+ZyV9SOtC5A2VOCa1dxybQviIUbehx84kuDmw5DpWaGmy6jgYTID5onH4O4OvwFBWJ
         a/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dXOCiPEEwmti8ibCuzkAcx2DIodwzBlROl4n6OrpWLA=;
        b=7BCSeLTrGmbdo1ZX70g384zFPdoPvBBx5cwRqTIk9CjISHyKu+Pk8MXINLUjwkyxLm
         k2n4JErtCDeWXebl3pu0yF3/yf0yH20YWZn+OdD4e0YaIN1TWIpRxlTNio4GKRpdwslL
         kzsS27OyPYZmCwWp9Rowsrl/B+VnBHeaiMpRhSHp/aZZqDXf38R2yKLnqA1+vmeNZRbe
         3f/SOhTEBOcsjPghjCLaWYTxQ8nZOUynt12Wj3HgDi0wbBRo7JwUcjNMpKvAZcdU6CQP
         r9fE94grUqZMYzFwAUQRXNLX7SrJetpilgOrVFAyrNJbZkf7a574nbp+VByeNaPnUhtJ
         U+Jg==
X-Gm-Message-State: AOAM532Gluij43LKl3vbWTFsTkG5K8Ez+hnG4xDTBq96q3ZV4gGLzcKT
        5YNJGAz4qsgctc8L2SbPInU=
X-Google-Smtp-Source: ABdhPJxXKceyNpOErYJDtGbFb4g2BM3td7Ivga45OGPy7O0fu/ejgZCYMzvN/GoS6Jvhp/C+t+TZHA==
X-Received: by 2002:a2e:b533:0:b0:246:30e1:d6c9 with SMTP id z19-20020a2eb533000000b0024630e1d6c9mr5311007ljm.515.1645388113498;
        Sun, 20 Feb 2022 12:15:13 -0800 (PST)
Received: from [10.0.0.127] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id c11sm904857lfm.32.2022.02.20.12.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:15:13 -0800 (PST)
Message-ID: <5c4253a7-3e11-72cf-24e4-eb75512eaaa3@gmail.com>
Date:   Sun, 20 Feb 2022 22:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] dmaengine: ti: k3-udma: Add support for AM62x SoC
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20220219083220.489420-1-vigneshr@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220219083220.489420-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vignesh,

On 19/02/2022 10:32, Vignesh Raghavendra wrote:
> Add AM62x SoC specific data for k3-udma driver
> 
> TRM: https://www.ti.com/lit/pdf/spruiv7

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Vignesh Raghavendra (2):
>   dmaengine: ti: k3-udma: Add AM62x DMSS support
>   dmaengine: ti: k3-psil: Add AM62x PSIL and PDMA data
> 
>  drivers/dma/ti/Makefile       |   3 +-
>  drivers/dma/ti/k3-psil-am62.c | 186 ++++++++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-psil-priv.h |   1 +
>  drivers/dma/ti/k3-psil.c      |   1 +
>  drivers/dma/ti/k3-udma.c      |   1 +
>  5 files changed, 191 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/ti/k3-psil-am62.c
> 

-- 
Péter
