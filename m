Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9FA512162
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiD0SqX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 14:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiD0SqE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 14:46:04 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4AD5C874;
        Wed, 27 Apr 2022 11:27:14 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id r1so2721797oie.4;
        Wed, 27 Apr 2022 11:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DVPr9hJN7pB7OqeO85qbYNVEch6Kb+Covs4dB2TnhNY=;
        b=FkS/YbAUvUcDSkjJDiMp3nYAd8gq+xkM+tJZWnBXYXTeRDUfi1d3Tq9OT+YgaQ1gwk
         OJz5561B3WVKTuQBMQG+1B4Kaj8c6FdsUK+lxtS8oKXnQMdAn1u9FEJpQic+B57/gdwm
         avtPAEVbDTsotLOnKRElGBiU06LPDIZUGM9Jtda1aSXW6r+2xBxvZJhcn00Mq2AHv32z
         ZvL5IAANc9SwRTTOTjg7ovwm8iFDeQa7wcXvG3ZDsX63Z17BRJj0WqGxBOhaHY+yZk/Y
         vLGjiRyTm9tYfjxj3ZjaXzWHuBD+TKNN9qwMS3SsWn0PCN6U59CH90isDL8/I4I0egYY
         xQ+Q==
X-Gm-Message-State: AOAM532LvtP1eF9p2rqfnpdvoGTgZVsB1IgN24fpp+X89vL/+unR8r+4
        am7GtUsV1FxVTWm8VqASyw==
X-Google-Smtp-Source: ABdhPJyqzxZZirHT0c4zRDtdeH7rpWWaxTYlc17RdpmWu3GeMGyEEtyMpgbcoNUvUqdK7lwztEgUaw==
X-Received: by 2002:a05:6808:11c4:b0:2d9:c395:f15e with SMTP id p4-20020a05680811c400b002d9c395f15emr17938884oiv.47.1651084033895;
        Wed, 27 Apr 2022 11:27:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z1-20020a056830128100b0060542867875sm6235035otp.70.2022.04.27.11.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:27:13 -0700 (PDT)
Received: (nullmailer pid 410640 invoked by uid 1000);
        Wed, 27 Apr 2022 18:27:12 -0000
Date:   Wed, 27 Apr 2022 13:27:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        dmaengine@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: dmaengine: mmp: deprecate
 '#dma-channels' and '#dma-requests'
Message-ID: <YmmLALJ3d1ssI7sz@robh.at.kernel.org>
References: <20220427161459.647676-1-krzysztof.kozlowski@linaro.org>
 <20220427161459.647676-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161459.647676-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 27 Apr 2022 18:14:56 +0200, Krzysztof Kozlowski wrote:
> The generic properties, used in most of the drivers and defined in
> generic dma-common DT bindings, are 'dma-channels' and 'dma-requests'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/mmp-dma.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
