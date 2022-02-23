Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F024C10A8
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 11:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiBWKrm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 05:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiBWKrl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 05:47:41 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A465A082;
        Wed, 23 Feb 2022 02:47:13 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21N7j1I6022524;
        Wed, 23 Feb 2022 11:46:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=g5cIGSQtNpUVPRLqm3DZCyx3XoXCarlJubY2NLyvtxs=;
 b=sTg4NpGyMlza/KSk5m5jlpN01FvxR8SbwEpwfyIKwCpx7bQxEaWvrtADvvmq54sE7Cim
 FtKtaNFOcuWfdp8pAhFbi6djXudPsMfDKboxc6YyzjtwtH1E9GF1QEiQ8ApqV/H1SSRq
 gZTvI9W/DszKa4zKQm0ZHnGsCVFwt8w+zgmoqSEVMasx/JIuZucFKVvgOne6Dp5fF/O5
 9fVbwAQ+nelcWOh7TbbdgR87/Mf4on2bycba9/3p2IcxK5dEgN7qvV+hpfm7TYyIOaYm
 cHJw+h4g1MXHw6vkYnat9N5IhchK03DYfz1REdmwPi8LtqM/e2KkLdKbQ47oLjVK/R2I uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3edgte16a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 11:46:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8FDF100034;
        Wed, 23 Feb 2022 11:46:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B147321E660;
        Wed, 23 Feb 2022 11:46:49 +0100 (CET)
Received: from [10.211.4.186] (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 23 Feb
 2022 11:46:48 +0100
Message-ID: <903027b2-46b7-4dd4-0baa-5d66c424fe9c@foss.st.com>
Date:   Wed, 23 Feb 2022 11:46:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dmaengine: stm32-mdma: check the channel availability
 (secure or not)
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220117100300.14150-1-amelie.delaunay@foss.st.com>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
In-Reply-To: <20220117100300.14150-1-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_03,2022-02-23_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Kind reminder.

Regards,
Amelie

On 1/17/22 11:03, Amelie Delaunay wrote:
> STM32_MDMA_CCR bit[8] is used to enable Secure Mode (SM). If this bit is
> set, it means that all the channel registers are write-protected. So the
> channel is not available for Linux use.
> 
> Add stm32_mdma_filter_fn() callback filter and give it to
> __dma_request_chan (instead of dma_get_any_slave_channel()), to exclude the
> channel if it is marked Secure.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>   drivers/dma/stm32-mdma.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index 6f57ff0e7b37..95e5831e490a 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -73,6 +73,7 @@
>   #define STM32_MDMA_CCR_WEX		BIT(14)
>   #define STM32_MDMA_CCR_HEX		BIT(13)
>   #define STM32_MDMA_CCR_BEX		BIT(12)
> +#define STM32_MDMA_CCR_SM		BIT(8)
>   #define STM32_MDMA_CCR_PL_MASK		GENMASK(7, 6)
>   #define STM32_MDMA_CCR_PL(n)		FIELD_PREP(STM32_MDMA_CCR_PL_MASK, (n))
>   #define STM32_MDMA_CCR_TCIE		BIT(5)
> @@ -248,6 +249,7 @@ struct stm32_mdma_device {
>   	u32 nr_channels;
>   	u32 nr_requests;
>   	u32 nr_ahb_addr_masks;
> +	u32 chan_reserved;
>   	struct stm32_mdma_chan chan[STM32_MDMA_MAX_CHANNELS];
>   	u32 ahb_addr_masks[];
>   };
> @@ -1456,10 +1458,23 @@ static void stm32_mdma_free_chan_resources(struct dma_chan *c)
>   	chan->desc_pool = NULL;
>   }
>   
> +static bool stm32_mdma_filter_fn(struct dma_chan *c, void *fn_param)
> +{
> +	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
> +	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
> +
> +	/* Check if chan is marked Secure */
> +	if (dmadev->chan_reserved & BIT(chan->id))
> +		return false;
> +
> +	return true;
> +}
> +
>   static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
>   					    struct of_dma *ofdma)
>   {
>   	struct stm32_mdma_device *dmadev = ofdma->of_dma_data;
> +	dma_cap_mask_t mask = dmadev->ddev.cap_mask;
>   	struct stm32_mdma_chan *chan;
>   	struct dma_chan *c;
>   	struct stm32_mdma_chan_config config;
> @@ -1485,7 +1500,7 @@ static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
>   		return NULL;
>   	}
>   
> -	c = dma_get_any_slave_channel(&dmadev->ddev);
> +	c = __dma_request_channel(&mask, stm32_mdma_filter_fn, &config, ofdma->of_node);
>   	if (!c) {
>   		dev_err(mdma2dev(dmadev), "No more channels available\n");
>   		return NULL;
> @@ -1615,6 +1630,10 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>   	for (i = 0; i < dmadev->nr_channels; i++) {
>   		chan = &dmadev->chan[i];
>   		chan->id = i;
> +
> +		if (stm32_mdma_read(dmadev, STM32_MDMA_CCR(i)) & STM32_MDMA_CCR_SM)
> +			dmadev->chan_reserved |= BIT(i);
> +
>   		chan->vchan.desc_free = stm32_mdma_desc_free;
>   		vchan_init(&chan->vchan, dd);
>   	}
