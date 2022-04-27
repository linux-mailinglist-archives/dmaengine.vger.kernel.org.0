Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8751216F
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiD0Srr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiD0Src (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 14:47:32 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9E88AE4A;
        Wed, 27 Apr 2022 11:28:23 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id e4so2917355oif.2;
        Wed, 27 Apr 2022 11:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nl+4r7hiXinijqHQbxCIv5w5OgUeWWhWtFjG6SmqZno=;
        b=k/o2iX4UaQJ8AMdrIpGfLxCAs4TIP/s0elIEti2tiVTqvDu8OnzV6hOL/oOxFU08bf
         jG5MAaFsuwXWrDV6Brd1Arsc9IyrWyS2DufneCfD1D06E/Af3/bjcB3x41c9y4bffzC0
         s+fSeTSPO3aHEDJnxwQlPYWybRQKnh6I/+ibm8Pp4T7CPeGcAySiyzMBDCfv9rszN0Se
         WJS8EGEHRtbmnKm7LA52XxEYVcZjX+LDGAcIg+ty9Yh2+AYKf223L26Iau712iptfRkN
         uunC+fewqtiTmj386YAYppjf4UdhqQDNSgDy6s8D9Ox9qnIaKg+PWZrATkowiVOeP9Ch
         K/pQ==
X-Gm-Message-State: AOAM533JEIGLAfT/J8FgkhKww0ZRRbro8VeoN5e/KhO5GijxfqH/8KPD
        fWBpLTtuf9veekFEdpb6Tg==
X-Google-Smtp-Source: ABdhPJytJw8XpSXa3CzKbz2LXr5Gx8Ykk2mRSu9BrBYw3JDDQh2mXpUxr9H+oq7te9FKBQjSHTxgsw==
X-Received: by 2002:a54:448e:0:b0:322:5f13:d8ce with SMTP id v14-20020a54448e000000b003225f13d8cemr18079567oiv.296.1651084102483;
        Wed, 27 Apr 2022 11:28:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b21-20020a05687051d500b000e686d1386bsm971552oaj.5.2022.04.27.11.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:28:22 -0700 (PDT)
Received: (nullmailer pid 412202 invoked by uid 1000);
        Wed, 27 Apr 2022 18:28:21 -0000
Date:   Wed, 27 Apr 2022 13:28:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine/ARM: use proper 'dma-channels/requests'
 properties
Message-ID: <YmmLRbb4XNmpEn1b@robh.at.kernel.org>
References: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 27, 2022 at 06:15:31PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> The core DT schema defines generic 'dma-channels' and 'dma-requests'
> properties, so in preparation to moving bindings to DT schema, convert
> existing users of '#dma-channels' and '#dma-requests' to the generic
> variant.
> 
> Not tested on hardware.
> 
> IMPORTANT
> =========
> The patchset is not bisectable! The DTS patches should be applied a
> release *after* driver change is accepted.

There's no driver change though...
