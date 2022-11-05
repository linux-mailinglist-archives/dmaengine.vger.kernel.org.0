Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B564E61DD5C
	for <lists+dmaengine@lfdr.de>; Sat,  5 Nov 2022 19:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiKESs7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 5 Nov 2022 14:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKESs6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 5 Nov 2022 14:48:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7117178B1;
        Sat,  5 Nov 2022 11:48:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u11so10708145ljk.6;
        Sat, 05 Nov 2022 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7G5Dcl8evUDZTsQ00NdOfIxS0ycTvIlgB4Poi2VDHt8=;
        b=n/NTVDKfQtfuVcMNy/aD9dp1pcIDCYNdAVvxsR6n8PoR8mcP71nZOkMy2hRwwjps8m
         aTmi2IYleMKJh8BIEY/n0U8GasHdKlO5NgBJKecc02eDqApFgjKy2ZvZyheZoWvX3M2O
         r7/eGPduOazcRrU7RFpt636k+FpEmHKn7AE7Tj2SSEoceMzn+DxlP9U6+qAgCyzH6kJi
         ofWrS2kSZ7Ko7P3Gp7C428tce9LonkwyTkKpap6JwFP8jZkKFX91EwIamQblmoIR8GGn
         QDFBGVpAH91w9R4lceTOQWJEEbSSlpZGHweM31LRyixRgF1I9oYAlHHcjMULk14fdLSz
         FA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7G5Dcl8evUDZTsQ00NdOfIxS0ycTvIlgB4Poi2VDHt8=;
        b=w0ZfNJQVBJu+qugmNIKfe5jcXri+B6owqLbwLBAg1d5DqGvtWK0PnRkNHON+IhoQFI
         N8X+3GKAdWPEW2//Jg3B1mqaIwhwq1OlseeGYLUozfCi3JKjhhm+XbNXw3rehaHiItk1
         n+HClj+Kloq0NI6f4XXarqlxkVfdkl3y5wab8z2gqa2Fhz8Se1v7ujE9NMxHUwfjfiZb
         JJ2rJRX6xNX5zTqMzStw5nyfX/8uweQmxaqfJX8Rep0V5s0f6ck0Q475tCg0bNB3E+X8
         uyJQiF0io4Q/5ZrQ0AsupjD/C2Ldz8+N7aIJaObcwHW+7Jij9HIXEJGcLcD/Vb8jrVJW
         rrog==
X-Gm-Message-State: ACrzQf0umKA27SxG0ybzc+qUBYOjngVutu/ZFyQkxOAUmkqP+L7sTyim
        dTzmHi88K/cfEqgqPL01kmk=
X-Google-Smtp-Source: AMsMyM7U4xI7nFSwWyhVQFBs4IPdbBRMBZQwwkF+QB6fMptlJkCi0GAvaZpZEMXL4Z/dYb59cnNbvA==
X-Received: by 2002:a2e:9591:0:b0:277:99b:3826 with SMTP id w17-20020a2e9591000000b00277099b3826mr3335872ljh.412.1667674134079;
        Sat, 05 Nov 2022 11:48:54 -0700 (PDT)
Received: from [10.0.0.100] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id f4-20020a056512228400b00498f570aef2sm378864lfu.209.2022.11.05.11.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 11:48:53 -0700 (PDT)
Message-ID: <be967357-6ecb-5ecf-c860-5265e1527b2a@gmail.com>
Date:   Sat, 5 Nov 2022 20:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Georgi Vlaev <g-vlaev@ti.com>, Vinod Koul <vkoul@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
References: <20221103203021.83929-1-g-vlaev@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v2] dmaengine: k3-udma: Add system suspend/resume support
In-Reply-To: <20221103203021.83929-1-g-vlaev@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 03/11/2022 22:30, Georgi Vlaev wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> The K3 platforms configure the DMA resources with the
> help of the TI's System Firmware's Device Manager(DM)
> over TISCI. The group of DMA related Resource Manager[1]
> TISCI messages includes: INTA, RINGACC, UDMAP, and PSI-L.
> This configuration however, does not persist in the DM
> after leaving from Suspend-to-RAM state. We have to restore
> the DMA channel configuration over TISCI for all configured
> channels when returning from suspend.
> 
> The TISCI resource management calls for each DMA type (UDMA,
> PKTDMA, BCDMA) happen in device_free_chan_resources() and
> device_alloc_chan_resources(). In pm_suspend() we store
> the current udma_chan_config for channels that still have
> attached clients and call device_free_chan_resources().
> In pm_resume() restore the udma_channel_config from backup
> and call device_alloc_chan_resources() for those channels.
> Drivers like CPSW can do their own DMA resource management,
> so use the late system suspend/resume hooks.

It is wrong to push the DMA context store/restore task to a client 
driver (cpsw or icss), it has to be done by the glue layer.

With this patch the DMAengine side of the UDMA/BCDMA/PKTDMA will support 
suspend/resume while the networking will remain broken, right?

I can not test this atm since my setup relies solely on NFS rootfs via 
cpsw, I might be able to check with a USB-ethernet dongle..

Please do a followup for the glue layer support.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/index.html#resource-management-rm
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> [g-vlaev@ti.com: Add patch description and config backup]
> [g-vlaev@ti.com: Supend only channels with clients]
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> ---
> Changes:
> 
> v2:
> * Update the commit message
> * Use list_for_each_entry() to iterate over the channel list.
> 
>   drivers/dma/ti/k3-udma.c | 54 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index ce8b80bb34d7..29844044132c 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -304,6 +304,8 @@ struct udma_chan {
>   
>   	/* Channel configuration parameters */
>   	struct udma_chan_config config;
> +	/* Channel configuration parameters (backup) */
> +	struct udma_chan_config backup_config;
>   
>   	/* dmapool for packet mode descriptors */
>   	bool use_dma_pool;
> @@ -5491,11 +5493,63 @@ static int udma_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> +static int udma_pm_suspend(struct device *dev)
> +{
> +	struct udma_dev *ud = dev_get_drvdata(dev);
> +	struct dma_device *dma_dev = &ud->ddev;
> +	struct dma_chan *chan;
> +	struct udma_chan *uc;
> +
> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +		if (chan->client_count) {
> +			uc = to_udma_chan(chan);
> +			/* backup the channel configuration */
> +			memcpy(&uc->backup_config, &uc->config,
> +			       sizeof(struct udma_chan_config));
> +			dev_dbg(dev, "Suspending channel %s\n",
> +				dma_chan_name(chan));
> +			ud->ddev.device_free_chan_resources(chan);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int udma_pm_resume(struct device *dev)
> +{
> +	struct udma_dev *ud = dev_get_drvdata(dev);
> +	struct dma_device *dma_dev = &ud->ddev;
> +	struct dma_chan *chan;
> +	struct udma_chan *uc;
> +	int ret;
> +
> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +		if (chan->client_count) {
> +			uc = to_udma_chan(chan);
> +			/* restore the channel configuration */
> +			memcpy(&uc->config, &uc->backup_config,
> +			       sizeof(struct udma_chan_config));
> +			dev_dbg(dev, "Resuming channel %s\n",
> +				dma_chan_name(chan));
> +			ret = ud->ddev.device_alloc_chan_resources(chan);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops udma_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(udma_pm_suspend, udma_pm_resume)
> +};
> +
>   static struct platform_driver udma_driver = {
>   	.driver = {
>   		.name	= "ti-udma",
>   		.of_match_table = udma_of_match,
>   		.suppress_bind_attrs = true,
> +		.pm = &udma_pm_ops,
>   	},
>   	.probe		= udma_probe,
>   };
> 
> base-commit: 81214a573d19ae2fa5b528286ba23cd1cb17feec

-- 
Péter
