Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD845022F
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 11:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhKOKRc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 05:17:32 -0500
Received: from www381.your-server.de ([78.46.137.84]:57208 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhKOKR3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Nov 2021 05:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=zKle5O4Hm0rsP20JwKxCewz8QF7Q9nSdwfLsov0N4vA=; b=hwsQlcKAS/JXya4kJAPUiPtqXb
        9UMOU27cfaU5N7Tp8fyitDY1674HxtfXStnOTcAeHYihKpPwkh4BzHNyU3L8ni0MlEqLJvF3Tru5q
        B2eTXmMb/S3sAqTnVmA3k/cGfwJUJMXtyrqmrWCjYFQvJczCRjGLBk4fscjkPc04xA/T/XuzDoZfc
        XILRH6/Bd05bjkDrhLZT2E2VeKzK0ieAQRQtDzTV4WK2WZN7kHtarwsy+N/oRQtAZ3G4YUkB/BJh8
        efgVXyOr3W5pPKLt/HNdG7cIpevglHN4SkSIlzyhRsuDMLifVtTNbhdmELMY5HB4kAhXJnGP0TpjZ
        VMZfg1mg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mmZ0A-000A8L-4d; Mon, 15 Nov 2021 11:14:14 +0100
Received: from [82.135.83.112] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mmZ09-0008BB-1V; Mon, 15 Nov 2021 11:14:13 +0100
Subject: Re: [PATCH 01/11] ASoC: dai_dma: remove slave_id field
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
References: <20211115085403.360194-1-arnd@kernel.org>
 <20211115085403.360194-2-arnd@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <647b842d-76a1-7a96-3ea7-8a37b62bc18e@metafoo.de>
Date:   Mon, 15 Nov 2021 11:14:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211115085403.360194-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26354/Mon Nov 15 10:21:07 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11/15/21 9:53 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This field is never set, and serves no purpose, so remove it.

I agree that we should remove it. Its been legacy support code for a 
while, but the description that there is no user is not right.

The tegra20_spdif driver obviously uses it and that user is removed in 
this patch. I think it makes sense to split that out into a separate 
patch with a description why the driver will still work even with 
slave_id removed. Maybe the best is to remove the whole tegra20_spdif 
driver.

> diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
> index 9fdc82d58db3..1c3385da6f82 100644
> --- a/sound/soc/tegra/tegra20_spdif.c
> +++ b/sound/soc/tegra/tegra20_spdif.c
> @@ -284,7 +284,6 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
>   	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
>   	spdif->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>   	spdif->playback_dma_data.maxburst = 4;
> -	spdif->playback_dma_data.slave_id = dmareq->start;
>   
dmareq is now unused and should be removed as well.
>   	pm_runtime_enable(&pdev->dev);
>   


