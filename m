Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A447F511E3D
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244723AbiD0SX7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244725AbiD0SX6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 14:23:58 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5B35843;
        Wed, 27 Apr 2022 11:20:46 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e5ca5c580fso2845814fac.3;
        Wed, 27 Apr 2022 11:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erT8GaO5VJG+GW9l/VolBcF/EAyslpb9BP1kfnKesbQ=;
        b=HwbO4/mftBDDaZsyCpd7QWBYOiG2tw0p83olRh2g3ZNkOdEt5BvZXLh5ndYhDAdgHW
         KQVqVAz9NIBd2o0cENZCYZTbLbpuXgvXBMtqzIRJkEikoZoLty2PrCgfTckQOgU/CnKr
         9tSZHWA5Dv7fnKX12lK/YxbenmaszV/JL8ivhXJlibRSa6r8dyW7QvHzBUgxX39LfQXc
         0dU6bridxsRji9rGbLUPvCro4C83nGp7QxKRg+c9FO1bIv45Sz2GI7D624dsUoqTvuEA
         dmIleks7qtHudNXFSWCFZEfrRiAUbJvN9Af3YsL31KbZDTu9C4UPYzZb5/JwvsI9z/45
         MbrA==
X-Gm-Message-State: AOAM530izG8CG2H/JfNa/WYzvJYzsXyE5wSQMoWxgkiFfWIsgldTKkPH
        rCajitqeqF5xIUS0efWOuQ==
X-Google-Smtp-Source: ABdhPJwD3AlwDSbDDJxgnqmixNW2BPvjNJ83aCGRkV3w9EnlDDeJMSilHkwvvkRGfHszHyhiPM7+Vg==
X-Received: by 2002:a05:6870:b402:b0:d3:3712:efa7 with SMTP id x2-20020a056870b40200b000d33712efa7mr11833514oap.88.1651083645769;
        Wed, 27 Apr 2022 11:20:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t3-20020a05687044c300b000e686d13892sm952200oai.44.2022.04.27.11.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:20:45 -0700 (PDT)
Received: (nullmailer pid 400627 invoked by uid 1000);
        Wed, 27 Apr 2022 18:20:44 -0000
Date:   Wed, 27 Apr 2022 13:20:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 4/6] ARM: dts: am33xx: use new 'dma-channels/requests'
 properties
Message-ID: <YmmJfInA0hNQOhDN@robh.at.kernel.org>
References: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
 <20220427161126.647073-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161126.647073-5-krzysztof.kozlowski@linaro.org>
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

On Wed, Apr 27, 2022 at 06:11:24PM +0200, Krzysztof Kozlowski wrote:
> The '#dma-channels' and '#dma-requests' properties were deprecated in
> favor of these defined by generic dma-common DT bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f6ec85d58dd1..55ffb0813ded 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -461,8 +461,8 @@ cppi41dma: dma-controller@2000 {
>  				interrupts = <17>;
>  				interrupt-names = "glue";
>  				#dma-cells = <2>;
> -				#dma-channels = <30>;
> -				#dma-requests = <256>;
> +				dma-channels = <30>;
> +				dma-requests = <256>;

You could keep the old properties for compatibility and to apply 
immediately.

>  			};
>  		};
>  
> -- 
> 2.32.0
> 
> 
