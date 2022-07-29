Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6417585712
	for <lists+dmaengine@lfdr.de>; Sat, 30 Jul 2022 01:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiG2XFk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jul 2022 19:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiG2XFj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jul 2022 19:05:39 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB2445057;
        Fri, 29 Jul 2022 16:05:38 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id q14so4679086iod.3;
        Fri, 29 Jul 2022 16:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=TRZasCiIk8CsLlgIAb+6ZyNOeA1LajNukWxssJQnQMI=;
        b=XRyiTexzZbf7roN9ckzT6q09LAtekfePT0finA2eEqh8hbkAUqAbDe/nlKAg2BxjhI
         l9OdLqlRPANkR4rpDGeJsq9f+QwWFflIPuHE+8SUF5fDYblXJ5k9KUWFuzyRWSwFxmeo
         BEJIhyl6lmDiJVbsTuZ3ifd+YZ49zm1j4G1By6UnY334D/klwZThzI7PG14l0w3gfp8X
         p/Dzis++59ZyW+WoTTC+XsvtyTXNgJ+ih6rBoGt68Y717wx5gY1dH/y55yXD5EQ04659
         xMKYQCUJal9yCRgjR5Omt36oZyFzyAm+kTPDCvufZqh/ZPtDlAEU98yy+ncB5kH81ssh
         s54A==
X-Gm-Message-State: AJIora+3vgw1XgwVKu7tNYnG640up8rF0HsF9SG+LWzrh44Gck9ghQ5V
        +GCd1LkvBV3wlntBx2ut4g==
X-Google-Smtp-Source: AGRyM1vQFs5en9Ysf3xLEGudHJlBxh1XHCFXGxAEMJODRUCM/yVeWxBD9YoCHNjlzJBuoWTti9oKCg==
X-Received: by 2002:a05:6638:2714:b0:33f:6fe4:b76c with SMTP id m20-20020a056638271400b0033f6fe4b76cmr2160692jav.211.1659135937729;
        Fri, 29 Jul 2022 16:05:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f12-20020a056602088c00b0067b85bb05besm2199851ioz.17.2022.07.29.16.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:05:37 -0700 (PDT)
Received: (nullmailer pid 105024 invoked by uid 1000);
        Fri, 29 Jul 2022 23:05:34 -0000
Date:   Fri, 29 Jul 2022 17:05:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     vkoul@kernel.org, wenbin.mei@mediatek.com, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, sam.shih@mediatek.com,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        long.cheng@mediatek.com, fparent@baylibre.com,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chaotian.jing@mediatek.com,
        nfraprado@collabora.com, sean.wang@mediatek.com,
        allen-kh.cheng@mediatek.com, matthias.bgg@gmail.com
Subject: Re: [PATCH 2/8] dt-bindings: mmc: Add compatible for MT6795 Helio
 X10 SoC
Message-ID: <20220729230534.GA104966-robh@kernel.org>
References: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
 <20220729104441.39177-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729104441.39177-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 29 Jul 2022 12:44:34 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the MT6795 SoC's mtk-sd mmc controllers.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
