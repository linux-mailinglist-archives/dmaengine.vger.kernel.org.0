Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D88585716
	for <lists+dmaengine@lfdr.de>; Sat, 30 Jul 2022 01:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiG2XFx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jul 2022 19:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbiG2XFw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jul 2022 19:05:52 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44588683C2;
        Fri, 29 Jul 2022 16:05:52 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id c185so4655703iof.7;
        Fri, 29 Jul 2022 16:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hjKDBui3XbMvdfBvZRSNvz4Y50HGiS8SdRV7n9Sisvk=;
        b=fpGqANHZE3Dxk/jahYXXp5haq9MtXc2HiXKGHYMtCUp7mxyElW+0uEyn8OPDgUk25s
         q9xcpTFHrtZkbP7r57M8imf+ls89+futBiN+U08nmTEPTagmDMxpbfHUs+0C5Ot7GlnM
         8uWjY89B31VYLhk/ejq5R/EG4ykrLvKnwait/gnUjpndEYGyWYepPjACmvbyy6mnSpF4
         4wxWVjYYyf72cdNkAV6Y+MmMMIv2Pf7C0NDviMCmakHavS/DOncWN9MJCX9uuXxF/c8e
         yF1xdODC1dQnlyoIf+VhIColtqsv5FdVOkhe5P3WUSSnINuriDnI80nfvCRIfMx6yzkx
         rzCw==
X-Gm-Message-State: AJIora+/pbuG5tpHPJHWHLePMDU+BMRhHE1nshs8htHRb8m6X6UG2pSV
        RD2WcbpjU41VaVEQWoQo0Q==
X-Google-Smtp-Source: AGRyM1t9O8iQe6oGeaMvWKzV15vZwYX2sfVSpSzsAO1ojnDOjg2jhLPWpDG1bIaXNx1V4sYolB/0Gg==
X-Received: by 2002:a6b:4019:0:b0:669:3314:ebcb with SMTP id k25-20020a6b4019000000b006693314ebcbmr1870454ioa.197.1659135951515;
        Fri, 29 Jul 2022 16:05:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bs19-20020a056638451300b0033ec45fb044sm2227216jab.47.2022.07.29.16.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:05:50 -0700 (PDT)
Received: (nullmailer pid 105414 invoked by uid 1000);
        Fri, 29 Jul 2022 23:05:46 -0000
Date:   Fri, 29 Jul 2022 17:05:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     long.cheng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        nfraprado@collabora.com, ~postmarketos/upstreaming@lists.sr.ht,
        hsinyi@chromium.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        fparent@baylibre.com, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-mmc@vger.kernel.org,
        vkoul@kernel.org, sam.shih@mediatek.com,
        allen-kh.cheng@mediatek.com, dmaengine@vger.kernel.org,
        ulf.hansson@linaro.org, wenbin.mei@mediatek.com,
        sean.wang@mediatek.com, krzysztof.kozlowski+dt@linaro.org,
        chaotian.jing@mediatek.com
Subject: Re: [PATCH 7/8] dt-bindings: arm: mediatek: Add compatible for
 MT6795 Sony Xperia M5
Message-ID: <20220729230546.GA105364-robh@kernel.org>
References: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
 <20220729104441.39177-9-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729104441.39177-9-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 29 Jul 2022 12:44:40 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible for the Sony Xperia M5 smartphone.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
