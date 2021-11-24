Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0BD45CB3E
	for <lists+dmaengine@lfdr.de>; Wed, 24 Nov 2021 18:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242768AbhKXRmw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Nov 2021 12:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhKXRmv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Nov 2021 12:42:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7935C061574;
        Wed, 24 Nov 2021 09:39:41 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c32so9302002lfv.4;
        Wed, 24 Nov 2021 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6KwYnqzzoTeuVNxhHsajzRe6liKfZ7vCZOdko2MKcYY=;
        b=lvNbpNKcqOAj74UHrS6XpdHcUjOf2sCIzeJURasqmwDotEWhqg+OtI1hIqfxXw53rO
         z4tIfWJ15SJPCQPQEYpaz/zmC2AtWtLFdcPfiSvbidZ8Exl9V8VhaqU9R2npHpy4tYc0
         yoAFhsyR/tm1sxMO7gFsD63QuHkm+jfTl/BAb0mYaTiKTxDGqN4kFZjH9jZeyYnQTnDY
         +iO2QczJQHUVcBKOsIBMpcFVHI8R1BvISIqundwfmbO8Omwr++T3KiO2VqAHQJyXOIWo
         3aZgsvReXTiUAJF/ECnq/pwPQIvxcyAQtmtfpSjrZuVeY4POAqNgnpvX5T/RJZH9Gntm
         5JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6KwYnqzzoTeuVNxhHsajzRe6liKfZ7vCZOdko2MKcYY=;
        b=2XJD9GYe9hHnmKvNFuhTMENH7Fskzbl+0c0Q9mpX7FHCCkqpD9/lsrJl6Z3tbnD2D6
         tNuAp3Cz2ctAkXxSbwVyfEVLuA+aczy97bAPagyqHl+oPN85ZZduqFSIy+KKT6NBNBVf
         vKlOc+SXUjvRo6Dt37YRfS/vqEb/oNMAcRWU8o3wOaAcgodfhWAAn8jtQlmgyoVRYH2O
         XqMRhBXbXgUCWX5+865lg1rmmhMlVlpxo3e9SeKxFuto0JauS6AHHob/TvP2JEt3PDFc
         BCywUAXrY6C4Ek1nLvP7lFx8cC70M/z3kY7jj+WaKEGje0Ei2Elnx/AmMH0gQSzzcjCn
         UDIg==
X-Gm-Message-State: AOAM533AsgWYcLN+Uio0Mp23dqbIHj2eUzXTM9eYwK6UZryMihhq2jeP
        rkWWq3U3jTHFtpIiYzV0gjfq5yFK63s=
X-Google-Smtp-Source: ABdhPJzMAN6+EU9Pjecu2Hl3ZC50CFEhc3UzlNKlYPHJ5/rwKJi/3grC00PRL2kx8I9BrVZVbuLcvw==
X-Received: by 2002:a19:c350:: with SMTP id t77mr16616753lff.152.1637775579976;
        Wed, 24 Nov 2021 09:39:39 -0800 (PST)
Received: from [192.168.2.145] (94-29-48-99.dynamic.spd-mgts.ru. [94.29.48.99])
        by smtp.googlemail.com with ESMTPSA id q5sm44228lfu.18.2021.11.24.09.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 09:39:39 -0800 (PST)
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
Message-ID: <b5c9ece3-c702-26b8-347a-f6d9bed2c5db@gmail.com>
Date:   Wed, 24 Nov 2021 20:39:38 +0300
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

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
