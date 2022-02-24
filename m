Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9DD4C3621
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 20:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiBXTtg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 14:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiBXTtg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 14:49:36 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CED254545;
        Thu, 24 Feb 2022 11:49:04 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so2084529otn.2;
        Thu, 24 Feb 2022 11:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vEMkaLmcYjI09xvx6jYK1M/q56ooly5OYLZnEhsDSRo=;
        b=CSZCjHypl16wcR9w4o54hBTW82A2Qsgt9xgP8s8VLo+WsFUpHwLuUKPjohEV5y63Ci
         AsSslVMYvQiXKf5W+qNjSYgveXkAYy6wJTC808TN7PRSiFTbRSlsIf4QPHkX8gRAnKEE
         5QDcgvj4bj+b5/TDBrWxiBa+1ov4kMgOlWYqskbPaEePO8WcdVjlJ3bZAZWTfTk6z4y+
         uctL9PDp51kdpXLL1bZIHb31eCoa+symkT068MZoUJz7nMzOFRm4/9Vh06FdmCfD0ya8
         fygn4fuHzWmULh8RqTZtqCUpYavpJjp7s8I4gSIJXGy9ouBPeopJYInM507YLbeOWmPY
         lAjw==
X-Gm-Message-State: AOAM533bqLeHVU6yvq939qmbFmoeO+e5oNn88hm+WR65rs1ZDrXQYAeZ
        Dlpul9dtfk0wb27s1v8cKA==
X-Google-Smtp-Source: ABdhPJypgynPujP0cdPUrnNUKBeJNnGl3BBCJkagr3tusQSqPPDDWnHi4y3UQXDbmLAkglzENGbn9A==
X-Received: by 2002:a4a:8507:0:b0:319:4719:27f6 with SMTP id k7-20020a4a8507000000b00319471927f6mr1532083ooh.84.1645732143607;
        Thu, 24 Feb 2022 11:49:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j25-20020a4ad199000000b003171dfeb5bfsm121557oor.15.2022.02.24.11.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:49:02 -0800 (PST)
Received: (nullmailer pid 3475137 invoked by uid 1000);
        Thu, 24 Feb 2022 19:49:01 -0000
Date:   Thu, 24 Feb 2022 13:49:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     long.cheng@mediatek.com, linux-mediatek@lists.infradead.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.wang@mediatek.com,
        krzysztof.kozlowski@canonical.com,
        linux-arm-kernel@lists.infradead.org, vkoul@kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v3] dt-bindings: dma: Convert mtk-uart-apdma to DT schema
Message-ID: <YhfhLWdVKLqHHFyv@robh.at.kernel.org>
References: <20220217095242.13761-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217095242.13761-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 17 Feb 2022 10:52:42 +0100, AngeloGioacchino Del Regno wrote:
> Convert the MediaTek UART APDMA Controller binding to DT schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v3: Removed anyOf condition
> v2: Fixed interrupt maxItems to 16, added interrupts/reg maxItems constraint
>     to 8 when the dma-requests property is not present
> 
>  .../bindings/dma/mediatek,uart-dma.yaml       | 122 ++++++++++++++++++
>  .../bindings/dma/mtk-uart-apdma.txt           |  56 --------
>  2 files changed, 122 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
