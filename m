Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1850EDA9
	for <lists+dmaengine@lfdr.de>; Tue, 26 Apr 2022 02:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiDZAl3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 20:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiDZAl0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 20:41:26 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5EB55239;
        Mon, 25 Apr 2022 17:38:20 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id t15so19076238oie.1;
        Mon, 25 Apr 2022 17:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+xkyjsKP46u0xLnw7ipZrQeJLg04xf15X4qMeda/Yao=;
        b=Qo1w9S7ALgHEps/KGP/MflMQY6iC59yp5F8Ik7Hz9JQDDendO6Ugvs+rYUaljMOi+d
         C/DER3cTkkfFfhaO8/CoTZkdnU+VN0MuEkbDETLjSsa57pvNDNTVyL3itTCFhQdvszPF
         GgMEXXRMAZExlCO+M2Yg47NPCr4TMfCSYpcpzJHOuLquqCfeZztJbRWtufxiXZCVEoow
         9qa8I4twGpZQhv7yh8GZ6lHU7bmsUfa/OZk5oeeA4FTva21ZFxYC7CkaIgRVaBuinR3F
         itUUZjonH7r8/xWHOuptorVxEHJBkqFqaKvNdNEwPzu20RWv8tyRGbRq0ujlE6PxWROI
         OAIg==
X-Gm-Message-State: AOAM5327ICyyRftvgzmk9M7Mlfmxq2P/Ri76fSx3bbHMDxJ6eV3bAQ9C
        xpAolatllj4u5cllUwK17A==
X-Google-Smtp-Source: ABdhPJyjvFb4sWaMpyKmprPCgdO7wWECV0nwEN47W+DPk0bfGOLlLAIzWoeh5kRIrfzXu0ISGw+bEA==
X-Received: by 2002:a54:480d:0:b0:322:78cc:9781 with SMTP id j13-20020a54480d000000b0032278cc9781mr9275484oij.278.1650933499768;
        Mon, 25 Apr 2022 17:38:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u7-20020a056870440700b000e686d1387asm280907oah.20.2022.04.25.17.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:38:19 -0700 (PDT)
Received: (nullmailer pid 629930 invoked by uid 1000);
        Tue, 26 Apr 2022 00:38:18 -0000
Date:   Mon, 25 Apr 2022 19:38:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: Add Apple ADMAC
Message-ID: <Ymc++iksTkSXDI7M@robh.at.kernel.org>
References: <20220420190755.76617-1-povik+lin@cutebit.org>
 <20220420190755.76617-2-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220420190755.76617-2-povik+lin@cutebit.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 20 Apr 2022 21:07:54 +0200, Martin Povišer wrote:
> Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
> samples on SoCs from the "Apple Silicon" family.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
>  .../devicetree/bindings/dma/apple,admac.yaml  | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
