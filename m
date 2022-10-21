Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806D5606D84
	for <lists+dmaengine@lfdr.de>; Fri, 21 Oct 2022 04:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJUCS3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 22:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUCS2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 22:18:28 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3945232E4B;
        Thu, 20 Oct 2022 19:18:26 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id v40-20020a056830092800b00661e37421c2so1011988ott.3;
        Thu, 20 Oct 2022 19:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmYPJ/7wJsxmApIlLpTd6X/vTi/8H9pkgr7hxwMxZ+4=;
        b=SjL7zQTXPKYBm6nLGaZ5JBik8hImuGyXnxjzFV/J/tcLQAkSOoddbar+kvzJMnk3qZ
         maDAEjxnj8e2Ps8QTea6FeGRzv1rHzUgSK9uZObiAsTIM93z1AZb9naD/zHeyK1QaUZs
         j0K2v18IgrY9VF3pP6mJRztKvFti5gFXCqT+LYMdf4ywgL2gSUe1BvVi0+SflT+2awJR
         HqQh4sqgll5IntSkHEeunaEVMIUrLxQFfesEhbwn9BpOYz4E6CFeoUPKPY3TXEM4U/cc
         TYoN5rRMktEYC13oktQkbU3W8PocNpQdYWuwSFDQ7ygy6OY727axuUq3MAARE/ltJoxy
         OPag==
X-Gm-Message-State: ACrzQf3ejnnkFyP1SRZgw1MwimLqg64piGSwqCdqkqURT5R1+aWT9uOk
        OiXjL5OyjZ7415zz0mZ0iw==
X-Google-Smtp-Source: AMsMyM6AAtXEtrNEbF8O/YJHsAHyYPvt7kFYUS0tw5D6Zyse7ySN3oQkDlgUB5X8jlqFJFTwDFNL4A==
X-Received: by 2002:a9d:6a98:0:b0:662:1427:f55b with SMTP id l24-20020a9d6a98000000b006621427f55bmr2634021otq.381.1666318704819;
        Thu, 20 Oct 2022 19:18:24 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d13-20020a9d5e0d000000b00661a30ea0d4sm595460oti.2.2022.10.20.19.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:18:24 -0700 (PDT)
Received: (nullmailer pid 2189482 invoked by uid 1000);
        Fri, 21 Oct 2022 02:18:25 -0000
Date:   Thu, 20 Oct 2022 21:18:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com, vkoul@kernel.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sfr@canb.auug.org.au
Subject: Re: [PATCH RESEND v2 2/3] arm64: tegra: Add dma-channel-mask in
 GPCDMA node
Message-ID: <20221021021825.GB2181729-robh@kernel.org>
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
 <20221020083322.36431-3-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020083322.36431-3-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 20, 2022 at 02:03:21PM +0530, Akhil R wrote:
> Add dma-channel-mask property in Tegra GPCDMA device tree node.
> 
> The property would help to specify the channels to be used in
> kernel and reserve few for the firmware. This was previously
> achieved by limiting the channel number to 31 in the driver.
> Now since we can list all 32 channels, update the interrupts
> property as well to list all 32 interrupts.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 +++-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 +++-
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 6602fe421ee8..db479064ff72 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -78,7 +78,8 @@
>  		reg = <0x0 0x2600000 0x0 0x210000>;
>  		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
>  		reset-names = "gpcdma";
> -		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,

Adding an interrupt onto the beginning? Also an ABI issue.

If you want to break the ABI, you have to explain that you are and why 
it is okay on that platform.

Rob
