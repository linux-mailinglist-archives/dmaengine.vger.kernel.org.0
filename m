Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBC5511F66
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiD0SYQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244789AbiD0SYN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 14:24:13 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6E5674C;
        Wed, 27 Apr 2022 11:21:00 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e9027efe6aso2816101fac.10;
        Wed, 27 Apr 2022 11:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+BHUxYTTDXYb9OdRF4eEEFDPiomx/yfHMZ5ecBQ9Ajo=;
        b=h/MuxgrLxIv4VmgeQQkOVWcS8g0kvgtJzA8oJx6TzF5+pQl9q2GaTnRBbUUBtlTGDw
         5wfkQXVTtqBva+6Fa2hByaJuFWv1U2FSSfpnumoHqzQUHE6RVMB2B6wiywF6XGDIQpxv
         IiEzvsXr77a6+xzX3I7+ZUljJEzdZbxnSEV2kNeXoiOjPd2QJgGNBRu0BMnK0zohNzLo
         XVs5r+bA1LIoibSnWoMEiM2XIopMYlu0CRcbHCMWOcAmtKDOvRAu8dh7djgsE67/nvny
         We92OAkdIohuqW7heya4j6HkkKO7ShPRn2qAy9vtLC8DYFWq/fOih5T1T8xhQ7f78e88
         hvqA==
X-Gm-Message-State: AOAM5313ChRYUE4BldsV/eT8UjeVowz7ug2dEWSQQnRgUtp4ytDgE3q0
        006wrfEoByZYq4t+J83SEw==
X-Google-Smtp-Source: ABdhPJwIhqiGXySbX37U6to8+OJfwMtRsj/HEBb1Gw1N28SEagZgN2P/sg6TK42K0Ovwu9+60jZxSQ==
X-Received: by 2002:a05:6870:a10b:b0:e9:6898:ee1f with SMTP id m11-20020a056870a10b00b000e96898ee1fmr4364895oae.274.1651083659845;
        Wed, 27 Apr 2022 11:20:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j17-20020a4a92d1000000b0035ea6671d8esm203128ooh.35.2022.04.27.11.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:20:59 -0700 (PDT)
Received: (nullmailer pid 400981 invoked by uid 1000);
        Wed, 27 Apr 2022 18:20:58 -0000
Date:   Wed, 27 Apr 2022 13:20:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: usb: am33xx-usb: deprecate
 '#dma-channels'
Message-ID: <YmmJirlaaCha3+vY@robh.at.kernel.org>
References: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
 <20220427161126.647073-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161126.647073-2-krzysztof.kozlowski@linaro.org>
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

On Wed, 27 Apr 2022 18:11:21 +0200, Krzysztof Kozlowski wrote:
> The generic property, used in most of the drivers and defined in generic
> dma-common DT bindings, is 'dma-channels'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/am33xx-usb.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
