Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C4511D07
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244751AbiD0SYc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244770AbiD0SY3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 14:24:29 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A65DA6A;
        Wed, 27 Apr 2022 11:21:16 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e656032735so2893463fac.0;
        Wed, 27 Apr 2022 11:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WsYDuXPegcs6f9tp8fheu6FbPuk3QsMls6zqmXPbmEE=;
        b=YdV8G9XyiFTBlhudb8qfohnIpo5tpln9sHb1c0Mpm/z7LTkkqn0dNIUL+xBel4k5Z1
         DTgzfx49gQQHkjdwWCRCq2FDrUhW7ms8oFPx2aP1nqieA34hQgaYRdw10zrXZ0mF+Uzp
         kX5IbH5xBNOeumnHEOt8ScSIEvGK1aV0adZam0+MPM20rBC8xE26O7J3ungitcIr4DmT
         ZWD0FlKs1KRbTMxond5fnWinyynRmjlljj/0Vwz2bsa8SgxybittggYsxca8X9FpaABt
         +7Nw6QMmJIE6HVYbl0bw6EV/7wKjA2b4n/gG7rq0saF9jZXJI6KBl58yynCjrfxuGb8q
         HEJw==
X-Gm-Message-State: AOAM533v7xLHj7KnV8qt3fUThWL7wU/oMJK7fNYOXSZ7CSar37yzRMzK
        RCOSSlzWfZwaSSyWdEfMoA==
X-Google-Smtp-Source: ABdhPJzgU0HHsm95TLwFYuXoFQX+M/segP96UyaML8aS6DQ8ywf0LtF6M67ewOlEgjqzkHt5YHSkmg==
X-Received: by 2002:a05:6870:581b:b0:e5:9baf:cd2a with SMTP id r27-20020a056870581b00b000e59bafcd2amr15855139oap.233.1651083675890;
        Wed, 27 Apr 2022 11:21:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g17-20020a544f91000000b003255010d173sm2631103oiy.54.2022.04.27.11.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:21:15 -0700 (PDT)
Received: (nullmailer pid 401474 invoked by uid 1000);
        Wed, 27 Apr 2022 18:21:14 -0000
Date:   Wed, 27 Apr 2022 13:21:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: usb: da8xx-usb: deprecate
 '#dma-channels'
Message-ID: <YmmJmjDzN9LYrcpW@robh.at.kernel.org>
References: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
 <20220427161126.647073-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161126.647073-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 27 Apr 2022 18:11:22 +0200, Krzysztof Kozlowski wrote:
> The generic property, used in most of the drivers and defined in generic
> dma-common DT bindings, is 'dma-channels'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/da8xx-usb.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
