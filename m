Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C86606D77
	for <lists+dmaengine@lfdr.de>; Fri, 21 Oct 2022 04:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJUCQI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 22:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUCQI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 22:16:08 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E822C448;
        Thu, 20 Oct 2022 19:16:03 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-132fb4fd495so1843712fac.12;
        Thu, 20 Oct 2022 19:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZo2SoHGMB49U08FrggSD62F1dJU4x2WpR2kVlXQtTc=;
        b=er2GizeSfMKN92eiA3N1GE2f0GyImLMEB18NraTx3m8V4CoD6UO2RmkoHXumQaYrQ/
         cJOLI4QxkDHquTGIjhoT3ygey+5x23HIkpDneHH5ClyrVT1oJTMOw7TavZouqV0G0zN4
         mdwHud+NbA66JUlmBQhz93tYxL7X5/fbidGRuCvqesg+kEsMANPedis/exKYiDgYdiMf
         KBgESHC14djbHngUnGyuXhPaHMQXDx+ApGvqgRWl499fjiDh8AfUuFWLXZ+6IUfHUcu+
         ningQ5H0clSIUJ/Lkj649vP8STGrKPsmJC5PQ3BVu4/kcNzvV+W1K8DVUVwDTi2FcIq+
         bnXA==
X-Gm-Message-State: ACrzQf3JzruYiBTjwU+WgBDDrqFkcXj13MuJVJgexbGg5XAddl0ORnff
        PcVcHEUWk6lF86PQiUj4lg==
X-Google-Smtp-Source: AMsMyM5JqlxGmxU3HmlsBn+wCVxoYJuiS0p3ug0txSMNfjbiGur1wQ7LqoQZCrDcHynQBVEyZ74sBA==
X-Received: by 2002:a05:6870:8193:b0:13a:e465:ad18 with SMTP id k19-20020a056870819300b0013ae465ad18mr4895007oae.30.1666318563053;
        Thu, 20 Oct 2022 19:16:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t11-20020a9d66cb000000b0063b24357269sm612592otm.13.2022.10.20.19.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:16:02 -0700 (PDT)
Received: (nullmailer pid 2187016 invoked by uid 1000);
        Fri, 21 Oct 2022 02:16:04 -0000
Date:   Thu, 20 Oct 2022 21:16:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com, vkoul@kernel.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sfr@canb.auug.org.au
Subject: Re: [PATCH RESEND v2 3/3] dmaengine: tegra: Add support for
 dma-channel-mask
Message-ID: <20221021021604.GA2181729-robh@kernel.org>
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
 <20221020083322.36431-4-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020083322.36431-4-akhilrajeev@nvidia.com>
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

On Thu, Oct 20, 2022 at 02:03:22PM +0530, Akhil R wrote:
> Add support for dma-channel-mask so that only the specified channels
> are used. This helps to reserve some channels for the firmware.
> 
> This was initially achieved by limiting the channel number to 31 in
> the driver and adjusting the register address to skip channel0 which
> was reserved for a firmware. Now, with this change, the driver can
> align more to the actual hardware which has 32 channels.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 37 +++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index fa9bda4a2bc6..1d1180db6d4e 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -161,7 +161,10 @@
>  #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5 msec */
>  
>  /* Channel base address offset from GPCDMA base address */
> -#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
> +#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET	0x10000
> +
> +/* Default channel mask reserving channel0 */
> +#define TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK	0xfffffffe
>  
>  struct tegra_dma;
>  struct tegra_dma_channel;
> @@ -246,6 +249,7 @@ struct tegra_dma {
>  	const struct tegra_dma_chip_data *chip_data;
>  	unsigned long sid_m2d_reserved;
>  	unsigned long sid_d2m_reserved;
> +	u32 chan_mask;
>  	void __iomem *base_addr;
>  	struct device *dev;
>  	struct dma_device dma_dev;
> @@ -1288,7 +1292,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
>  }
>  
>  static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
> -	.nr_channels = 31,
> +	.nr_channels = 32,

This is an ABI break. A new kernel with an old DTB will use 32 channels 
instead of 31. You should leave this and use the dma-channel-mask to 
enable all 32 channels.

Rob
