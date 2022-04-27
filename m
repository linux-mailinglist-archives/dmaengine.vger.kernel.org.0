Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96951216E
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiD0Srq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 14:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiD0Srd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 14:47:33 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80478BE0F;
        Wed, 27 Apr 2022 11:28:41 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id bg34-20020a056820082200b0035e7cd94e46so506042oob.1;
        Wed, 27 Apr 2022 11:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P5kdAy6l5fQgy5oRjZpIpF/FBNl0f3sT9FqFWBZTT70=;
        b=QRPBKAOdcQFreZwR3mBDFaVTArGsMtriziQqx0cPPnD53W8r5P418haluc2Vhqnf79
         zUYE3TvaOg0p60AVBfiejjMqVkde0m87f6X2ShSF413259E4Kganq/XDqH8aqYNuGez7
         vflmDQ0lk8LRB2HVh8IOsrBEjg6DTPj/myJr13lhuyLP4V5vooKK7wmTFBdvw5v6QKNc
         4BS4LbRmflCV7kZ6SKf7IU9tD/sgDN0zJmF7F+r7nzq+RKI7upHqZpWmkX7TuAhY0xoi
         yqnfjZTvZ+W2KSa5IWaPCblwaMeP1PKwdj3opAqzzct6LTwBOYI1YVXjmvyzz2lscXeM
         MBng==
X-Gm-Message-State: AOAM532Ia/WFv+EUk1h0y4sx6c83OeCHrXDj2fgl9UDY8a0GApH3ne7c
        DnCsgSgj7ZtOnT/TbzN4WQ==
X-Google-Smtp-Source: ABdhPJzAu2igpKowQ3WRX/sIT1h69LNzRLVN4nvHjTR1CBbJ7cV91jmkBT0aRa5mB2Ln4/8ITDHZFg==
X-Received: by 2002:a4a:d74a:0:b0:33a:2e4d:1b85 with SMTP id h10-20020a4ad74a000000b0033a2e4d1b85mr10657047oot.7.1651084121029;
        Wed, 27 Apr 2022 11:28:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870160e00b000e915a9121csm986012oae.52.2022.04.27.11.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:28:40 -0700 (PDT)
Received: (nullmailer pid 412647 invoked by uid 1000);
        Wed, 27 Apr 2022 18:28:39 -0000
Date:   Wed, 27 Apr 2022 13:28:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: fsl-imx: deprecate
 '#dma-channels' and '#dma-requests'
Message-ID: <YmmLV3l+5nz8z+qT@robh.at.kernel.org>
References: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org>
 <20220427161533.647837-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161533.647837-2-krzysztof.kozlowski@linaro.org>
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

On Wed, 27 Apr 2022 18:15:32 +0200, Krzysztof Kozlowski wrote:
> The generic properties, used in most of the drivers and defined in
> generic dma-common DT bindings, are 'dma-channels' and 'dma-requests'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-dma.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
