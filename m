Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FAA72A5A5
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 23:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjFIVyy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 17:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjFIVyt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 17:54:49 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4D42685;
        Fri,  9 Jun 2023 14:54:47 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-33e585a0ca6so9522175ab.3;
        Fri, 09 Jun 2023 14:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347686; x=1688939686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ4s8DLGxIQMZgO3h4yWSzjSw0o4+j3wjFGsywkwuyQ=;
        b=VIysn5K8i0nR7ZHk73uFKcwchrDXZongx0alHB/Z8fycZV0Tt+5Xc7mjNp3GaXm12N
         5E8HWVOisX5OFylP7IyUMtjBH1q5v6lZgX7un1cS808BuyHJDL5lDYQuS8dHwVz5SW+/
         X3o3nu+SzltCWDPhQoGzAWl8gibuS2Zuj/tBAr7rS1CkTOAX+Za4BnsBbZuGU4bBKthg
         HObtfKqRFxlJx4Rbcb+18GPGVWPtQV6XoZiDf1zXE5cs4ERtxyqt+vpy+0chHBOGkE+J
         uYbxYbkrpHu13uV8aya1BoMO4b1U3bDIpiUtHTMSoWaxQmInFlmF3sUNxPZ8XAeJewUc
         pL/Q==
X-Gm-Message-State: AC+VfDzwP7/w5w90PdbyPvxI2g7gXBRo+aimLbDWIrU+I83UzV3rSZY3
        Bg0JuSX/2TTwoLNX6ofkcg==
X-Google-Smtp-Source: ACHHUZ7asW6KLLFEuMl3Gpj9wEteHcFkfQtU+mBgAGx4LCseYTLClP89Gsdg7cl4uLoZoq/oLRK0Kw==
X-Received: by 2002:a92:d690:0:b0:32b:50d1:3403 with SMTP id p16-20020a92d690000000b0032b50d13403mr2464164iln.7.1686347686371;
        Fri, 09 Jun 2023 14:54:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k27-20020a02ccdb000000b0041aaebd2017sm1167046jaq.82.2023.06.09.14.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:54:45 -0700 (PDT)
Received: (nullmailer pid 2528752 invoked by uid 1000);
        Fri, 09 Jun 2023 21:54:43 -0000
Date:   Fri, 9 Jun 2023 15:54:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 04/10] ARM: dts: bcm2835: adjust DMA nodes
Message-ID: <20230609215443.GA2522299-robh@kernel.org>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-5-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604121223.9625-5-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jun 04, 2023 at 02:12:17PM +0200, Stefan Wahren wrote:
> After converting the bcm2835-dma DT binding to YAML, the DT schema
> checks gave warnings like:
> 
> $nodename:0: 'dma@7e007000' does not match '^dma-controller(@.*)?$'
> 'dma-channel-mask' is a required property
> Unevaluated properties are not allowed ('brcm,dma-channel-mask' was unexpected)
> 
> So fix them accordingly.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/bcm2711.dtsi        | 4 ++--
>  arch/arm/boot/dts/bcm2835-common.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> index 097e9f252235..83745672a120 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -76,7 +76,7 @@ thermal: thermal {
>  			};
>  		};
>  
> -		dma: dma@7e007000 {
> +		dma: dma-controller@7e007000 {
>  			compatible = "brcm,bcm2835-dma";
>  			reg = <0x7e007000 0xb00>;
>  			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
> @@ -103,7 +103,7 @@ dma: dma@7e007000 {
>  					  "dma9",
>  					  "dma10";
>  			#dma-cells = <1>;
> -			brcm,dma-channel-mask = <0x07f5>;
> +			dma-channel-mask = <0x07f5>;

You're breaking the ABI here. I'd think RPi users would care.

You should either list both properties or just leave this as-is. You 
could also mark the driver "dma-channel-mask" support for stable and 
somewhat avoid the ABI issue.

>  		};
>  
>  		pm: watchdog@7e100000 {
> diff --git a/arch/arm/boot/dts/bcm2835-common.dtsi b/arch/arm/boot/dts/bcm2835-common.dtsi
> index bb7e8f7facaf..3ba8db8eed0f 100644
> --- a/arch/arm/boot/dts/bcm2835-common.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-common.dtsi
> @@ -8,7 +8,7 @@ / {
>  	interrupt-parent = <&intc>;
>  
>  	soc {
> -		dma: dma@7e007000 {
> +		dma: dma-controller@7e007000 {
>  			compatible = "brcm,bcm2835-dma";
>  			reg = <0x7e007000 0xf00>;
>  			interrupts = <1 16>,
> @@ -46,7 +46,7 @@ dma: dma@7e007000 {
>  					  "dma14",
>  					  "dma-shared-all";
>  			#dma-cells = <1>;
> -			brcm,dma-channel-mask = <0x7f35>;
> +			dma-channel-mask = <0x7f35>;
>  		};
>  
>  		intc: interrupt-controller@7e00b200 {
> -- 
> 2.34.1
> 
