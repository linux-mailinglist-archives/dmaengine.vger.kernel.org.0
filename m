Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C02512157
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiD0SqM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 14:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiD0SqD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 14:46:03 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A013B7B57E;
        Wed, 27 Apr 2022 11:26:59 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-e67799d278so2828222fac.11;
        Wed, 27 Apr 2022 11:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pC1H3gQSVhE1zYfEMXMiP8EV077iw37StdCg5LtTNPQ=;
        b=asjecNBysgBbyXrvRuZuN0eh6bLxpfNP8k4qOZTdAmYCK1zIVPx77Qur7arRXvNpvr
         5Cy1P48QzfSpLw1/Yq3yZtGpAmJd4gxYx77lLJx7hn+37k8y8JwKEKHWOi0JxTkB6Bhp
         Bb4TRkjEvo1Xc4Hk/hndK3tKXuk87lGSnf/vbj/Vjbgi0lnU/B1LT4Zuu7ODYboZPuqH
         HnRxNcRzK4LbkhrXXEzrGGh+XKZpQcZSNbJnkbaURMBik1339QoAiTLGmp3dhNaHy2c8
         vL75BtWUuOLCGRzpedXA1wCphkpv4u+h8JmalaMImBttAaR4deI1AOhYcME5GLqZUa3C
         ZQTA==
X-Gm-Message-State: AOAM530wJF5MFDyA00A7ubY1yhABeO6upnHeCNO5/8qkKWHqj0jHAARs
        u4r5u0mzr8RIBf+ROAV3rQ==
X-Google-Smtp-Source: ABdhPJwe9vcxst1opjE36JoQI7jrSaQ3NCspkzUQRETmCJRLZa/X7qNkafHyk3LSObIvXrACyBOKNw==
X-Received: by 2002:a05:6870:478f:b0:e9:8c5c:3c37 with SMTP id c15-20020a056870478f00b000e98c5c3c37mr1395124oaq.217.1651084018882;
        Wed, 27 Apr 2022 11:26:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a056830290300b005b2316db9c9sm6051090otu.30.2022.04.27.11.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:26:58 -0700 (PDT)
Received: (nullmailer pid 410278 invoked by uid 1000);
        Wed, 27 Apr 2022 18:26:57 -0000
Date:   Wed, 27 Apr 2022 13:26:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: sprd: deprecate
 '#dma-channels'
Message-ID: <YmmK8WMGI6J1IRQ/@robh.at.kernel.org>
References: <20220427161423.647534-1-krzysztof.kozlowski@linaro.org>
 <20220427161423.647534-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161423.647534-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 27 Apr 2022 18:14:21 +0200, Krzysztof Kozlowski wrote:
> The generic property, used in most of the drivers and defined in generic
> dma-common DT bindings, is 'dma-channels'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/sprd-dma.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
