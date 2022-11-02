Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6320D6165C2
	for <lists+dmaengine@lfdr.de>; Wed,  2 Nov 2022 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKBPJy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Nov 2022 11:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKBPJx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Nov 2022 11:09:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875595FF2;
        Wed,  2 Nov 2022 08:09:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d25so28282892lfb.7;
        Wed, 02 Nov 2022 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Rb+gS6sc/sVlJkmj3WBiozyBdRB/YTWIlme/dmkY6o=;
        b=TclcMaWrGxwpMev2sYl5oZ/NGD87QkhFVLmMXOL6GIOeJfYuS3UyW5bNiJr7znNT5X
         7ri5j87ZHs24AQZ1Jw2dBi4kEmBNgeO7Rjlq/dyTpjvZmUN6qrMeLS87ri68rWT58T0O
         DY16sstmoC48RkkHPlyU7Zd4ixCIwova1CIGb6v6eIOXnR+n3Xh2TfzHhTV9kkLj6AaR
         J1Sixtb3qi2W1pIL/9AessOWBUpNtDd9giOQbnhgO48vX4yXVDETo55lhrrSQesEIF8p
         WM676gFZ6FbcmzNDnw/STGWrbeOHNw88t8AylKc0ADZpDs4OkwQAOr6DEt7HT9B83CgM
         FRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rb+gS6sc/sVlJkmj3WBiozyBdRB/YTWIlme/dmkY6o=;
        b=JtvBwnIYkk8W47DTI85mWsbs6bTFNcirIsr7U2qEsT8bdVl3dNf3lusHjym6lUKFDl
         jain6zNp3MEfmevjVchnss7RKeWKwEH/NsAJp9R2zdKDc0osagp/XAW7TGGMi7q4aJ74
         dh15yCZn8f2QxMYrxCnV2vIo16tI7YntnUggRwjW8t/Zz8McbAe9YDVM8N8AMgs3Ij9D
         4sc6gWtMuN4gvkBqYlaQUnqQ8lVjCMnqAey4mYOVd1d6cYd329X9jtTNAuHB3W22OP13
         oHPYoQlXc3bFn21CZdkdTeI1cSFM8coT/jI52k5EQTorNDzmwot7Sghea3tYOa4zjN18
         NhLQ==
X-Gm-Message-State: ACrzQf2dj90/DUDDpoGJ7+w7sA0+k1pPigYQ2C1Jc11oPH/OzrxqYMeE
        oB8Xf/7H5uRFblC3WUXeYEM=
X-Google-Smtp-Source: AMsMyM5MOn862HJjiJjQ/v9DQ8K8/mu/9X0u/0IWN9aYD1g/+RNRSTnU8+00OV+8y0aMGvwfuWfxlw==
X-Received: by 2002:a05:6512:2284:b0:4a2:fac:1766 with SMTP id f4-20020a056512228400b004a20fac1766mr10563006lfu.359.1667401788991;
        Wed, 02 Nov 2022 08:09:48 -0700 (PDT)
Received: from ?IPV6:2001:999:700:516c:9927:6de5:9daa:7a7d? ([2001:999:700:516c:9927:6de5:9daa:7a7d])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b0049ebc44994fsm2047006lfr.128.2022.11.02.08.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 08:09:48 -0700 (PDT)
Message-ID: <21fb260b-df57-f48d-90bb-aa126fc564a5@gmail.com>
Date:   Wed, 2 Nov 2022 17:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Georgi Vlaev <g-vlaev@ti.com>, Vinod Koul <vkoul@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
References: <20221028163050.248074-1-g-vlaev@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dmaengine: k3-udma: Add system suspend/resume support
In-Reply-To: <20221028163050.248074-1-g-vlaev@ti.com>
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

Hi Georgi,

On 28/10/2022 19:30, Georgi Vlaev wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> The K3 platforms configure the DMA resources with the
> help of the TI's System Firmware's Device Manager(DM)
> over TISCI. The group of DMA related Resource Manager[1]
> TISCI messages includes: INTA, RINGACC, UDMAP, and PSI-L.
> This configuration however, does not persist in the DM
> after leaving from Suspend-to-RAM state. We have to restore
> the DMA channel configuration over TISCI for all configured
> channels when entering suspend.

We have to restore the DMA channel configuration over TISCI for all 
configured channels when returning from suspend.

> The TISCI resource management calls for each DMA type (UDMA,
> PKTDMA, BCDMA) happen in device_free_chan_resources() and
> device_alloc_chan_resources(). In pm_suspend() we store
> the current udma_chan_config for channels that still have
> attached clients and call device_free_chan_resources().
> In pm_resume() restore the udma_channel_config from backup
> and call device_alloc_chan_resources() for those channels.
> Drivers like CPSW can do their own DMA resource management,
> so use the late system suspend/resume hooks.
> 
> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/index.html#resource-management-rm
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> [g-vlaev@ti.com: Add patch description and config backup]
> [g-vlaev@ti.com: Supend only channels with clients]
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> ---
>   drivers/dma/ti/k3-udma.c | 55 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index ce8b80bb34d7..efcc1c5ddb2d 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -194,6 +194,7 @@ struct udma_dev {
>   	int rchan_cnt;
>   	int rflow_cnt;
>   	int tflow_cnt;
> +	int ch_count;

I think udev->ddev.chancnt already contains this information and there 
is a helper to iterate through the list:

list_for_each_entry(chan, &udev->ddev.channels, device_node) { }

Used in udma_dbg_summary_show() for example.

>   	unsigned long *bchan_map;
>   	unsigned long *tchan_map;
>   	unsigned long *rchan_map;
> @@ -304,6 +305,8 @@ struct udma_chan {
>   
>   	/* Channel configuration parameters */
>   	struct udma_chan_config config;
> +	/* Channel configuration parameters (backup) */
> +	struct udma_chan_config backup_config;
>   
>   	/* dmapool for packet mode descriptors */
>   	bool use_dma_pool;
> @@ -4999,6 +5002,7 @@ static int setup_resources(struct udma_dev *ud)
>   	if (!ch_count)
>   		return -ENODEV;
>   
> +	ud->ch_count = ch_count;
>   	ud->channels = devm_kcalloc(dev, ch_count, sizeof(*ud->channels),
>   				    GFP_KERNEL);
>   	if (!ud->channels)
> @@ -5491,11 +5495,62 @@ static int udma_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> +static int udma_pm_suspend(struct device *dev)
> +{
> +	struct udma_dev *ud = dev_get_drvdata(dev);
> +	struct dma_chan *chan;
> +	int i;
> +
> +	for (i = 0; i < ud->ch_count; i++) {
> +		chan = &ud->channels[i].vc.chan;
> +		if (chan->client_count) {
> +			/* backup the channel configuration */
> +			memcpy(&ud->channels[i].backup_config,
> +			       &ud->channels[i].config,
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
> +	struct dma_chan *chan;
> +	int ret, i;
> +
> +	for (i = 0; i < ud->ch_count; i++) {
> +		chan = &ud->channels[i].vc.chan;
> +		if (chan->client_count) {
> +			/* restore the channel configuration */
> +			memcpy(&ud->channels[i].config,
> +			       &ud->channels[i].backup_config,
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

-- 
Péter
