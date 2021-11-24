Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFCC45CA1B
	for <lists+dmaengine@lfdr.de>; Wed, 24 Nov 2021 17:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhKXQgD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Nov 2021 11:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbhKXQgD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Nov 2021 11:36:03 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6915C061574;
        Wed, 24 Nov 2021 08:32:52 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z8so6639219ljz.9;
        Wed, 24 Nov 2021 08:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hWdL3+sC7Y3WgMzxQgq49FXg8O3lrY2U4JGqRbZI6tg=;
        b=gujWqpLYZ0ok4buE3cVMLWfC5uFpJyuXa42ARhUlnN4O23+qlO+EmYtRvyX/8c+8Cd
         T5a1dyyYrYP3SiqkVxU+nFVwtXCc1qsYP3l3IZjhohQlobFIZT7KVzpd/uD0tmpe0CvO
         aeCfiRXxliyhrHPinovV+UTXQVe/RaMFEMYjCu0hyn3k5BUgAGEZ29zDCOQVjlqJOFhL
         TZBbWI9gTerbMrFWXfehbYHCPQb+K2zUVIW0lpbY8uZKY04odxTxEAVckbrorzsLNVGk
         sCA4pYJSO2cZ60LDY064M6AwjoFewiMlf4tsmpailAug/kWALkfi3+l95LwEP1w10SMT
         n/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hWdL3+sC7Y3WgMzxQgq49FXg8O3lrY2U4JGqRbZI6tg=;
        b=fipxd/uz398YZdkpw4O+SS+yHayRaMRrULaIWRHtxQwOSBRL1BF4m6a4Q8cbC9bYZ1
         RFQrAJzAiZR5x9GifNrlQq0whLDtnKoIG6ztNFXp3IQNGR4pX1s9vb9PkZZo3PaiWYxu
         rqD7d9IvgMWURXMEH81xcClIn04tbjpTMzLaqIKp0vP9W7gN6Y6yRQef9ropRTSW0YFP
         1/8GtVs+BiaF6AJCrRzpVUq27gxv16Kadf9JJOeZCK5QMbvwUpJhR/8bIn8OF4q79X8/
         luQbF7RBnZcKg9Za+cScUhLoqnD1HLzrZ8AZFJQO3WC6440t0QDWJvkm8c0vUWRkjAhl
         G0Zg==
X-Gm-Message-State: AOAM532bE9Gd3EdlbEqf+xZArj4r/9RRulwp1IgwY2x7pjOB3VObWBHb
        uPW2/SnM2Ptz5q/RQBr09JGsKzRdEmU=
X-Google-Smtp-Source: ABdhPJzQ2dc3wLXSWKQBFY+mHq5x3ddsPjsCSkkhRryLlNJ0eKxp2Ar8mZbKuizWCxiSq5j6WRb8tw==
X-Received: by 2002:a2e:2a43:: with SMTP id q64mr17358890ljq.102.1637771570838;
        Wed, 24 Nov 2021 08:32:50 -0800 (PST)
Received: from [192.168.2.145] (94-29-48-99.dynamic.spd-mgts.ru. [94.29.48.99])
        by smtp.googlemail.com with ESMTPSA id m14sm31645ljg.2.2021.11.24.08.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 08:32:50 -0800 (PST)
Subject: Re: [PATCH v2 01/11] ASoC: tegra20-spdif: stop setting slave_id
To:     Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org
References: <20211122222203.4103644-1-arnd@kernel.org>
 <20211122222203.4103644-2-arnd@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1dbe0c9f-e209-49e1-f05c-765d9f9b91eb@gmail.com>
Date:   Wed, 24 Nov 2021 19:32:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122222203.4103644-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

23.11.2021 01:21, Arnd Bergmann пишет:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The DMA resource is never set up anywhere, and passing this as slave_id
> has not been the proper procedure in a long time.
> 
> As a preparation for removing all slave_id references from the ALSA code,
> remove this one.
> 
> According to Dmitry Osipenko, this driver has never been used and
> the mechanism for configuring DMA would not work as it is implemented,
> so this part will get rewritten when the driver gets put into use
> again in the future.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/tegra/tegra20_spdif.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
> index 9fdc82d58db3..1c3385da6f82 100644
> --- a/sound/soc/tegra/tegra20_spdif.c
> +++ b/sound/soc/tegra/tegra20_spdif.c
> @@ -284,7 +284,6 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
>  	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
>  	spdif->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	spdif->playback_dma_data.maxburst = 4;
> -	spdif->playback_dma_data.slave_id = dmareq->start;
>  
>  	pm_runtime_enable(&pdev->dev);
>  
> 

Thanks, Arnd!

The commit message is correct, however you could remove even more code
here. But there is no need to make a v3 just because this patch because
I already prepared patchset that revives this S/PDIF driver and enables
HDMI audio on Tegra20. I'll take care of cleaning up the whole code of
this driver.

diff --git a/sound/soc/tegra/tegra20_spdif.c
b/sound/soc/tegra/tegra20_spdif.c
index 7751575cd6d6..1c3385da6f82 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -251,7 +251,7 @@ static const struct regmap_config
tegra20_spdif_regmap_config = {
 static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_spdif *spdif;
-	struct resource *mem, *dmareq;
+	struct resource *mem;
 	void __iomem *regs;
 	int ret;

@@ -273,12 +273,6 @@ static int tegra20_spdif_platform_probe(struct
platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);

-	dmareq = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmareq) {
-		dev_err(&pdev->dev, "No DMA resource\n");
-		return -ENODEV;
-	}
-
 	spdif->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
 					    &tegra20_spdif_regmap_config);
 	if (IS_ERR(spdif->regmap)) {
@@ -290,7 +284,6 @@ static int tegra20_spdif_platform_probe(struct
platform_device *pdev)
 	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
 	spdif->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	spdif->playback_dma_data.maxburst = 4;
-	spdif->playback_dma_data.slave_id = dmareq->start;

 	pm_runtime_enable(&pdev->dev);


