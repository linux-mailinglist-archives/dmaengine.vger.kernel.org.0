Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA377BD618
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbjJIJCv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbjJIJCv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 05:02:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9EFDE;
        Mon,  9 Oct 2023 02:02:42 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3997kBj8016515;
        Mon, 9 Oct 2023 11:02:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=
        selector1; bh=G45xnPIUX9Ez29Qgnji13Rx5Rf0f5sWrQjcrxGxi2dI=; b=z3
        Bvtq2jdON1aVCMbQCY3h/qaVoQmvOeYcE46qodM8z0atcV2aqWKIOtEre8sEFx42
        2tsVZvqLIgZh86AzjZBZytYNTCwQGtG+PqYrWflFBWrJGBpLv7Ltvlbof+N1xoub
        bYreB6WtLnSuLDda9OysxNMUwqAsQarrf97cEpWBk8Tdp1bIrqfK3po3Kf+8iu2s
        Od/HYR8ColJa0HYl/jUeEe07lCt6eIEY5wV/B6mW+Ow7bdwsFHKafHgMTvr8pw3u
        G5NFg7GKQWB5Fn7ly55XrRTvgf0q3X0ZsR4DBFwtvx1DNCTKCCwH0dD99mUiaWzY
        kLFWvaxZa1roOwcw55gw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhfdv8d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 11:02:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5425E100063;
        Mon,  9 Oct 2023 11:02:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C01621ADB2;
        Mon,  9 Oct 2023 11:02:20 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 11:02:19 +0200
Date:   Mon, 9 Oct 2023 11:02:13 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        M'boumba Cedric Madianga <cedric.madianga@gmail.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: stm32-mdma: correct desc prep when channel
 running
Message-ID: <20231009090213.GA1547647@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        M'boumba Cedric Madianga <cedric.madianga@gmail.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        stable@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231009082450.452877-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009082450.452877-1-amelie.delaunay@foss.st.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_07,2023-10-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Amélie,

thanks a lot.

Tested-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain

On Mon, Oct 09, 2023 at 10:24:50AM +0200, Amelie Delaunay wrote:
> From: Alain Volmat <alain.volmat@foss.st.com>
> 
> In case of the prep descriptor while the channel is already running, the
> CCR register value stored into the channel could already have its EN bit
> set.  This would lead to a bad transfer since, at start transfer time,
> enabling the channel while other registers aren't yet properly set.
> To avoid this, ensure to mask the CCR_EN bit when storing the ccr value
> into the mdma channel structure.
> 
> Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/dma/stm32-mdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index bae08b3f55c7..f414efdbd809 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -489,7 +489,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>  	src_maxburst = chan->dma_config.src_maxburst;
>  	dst_maxburst = chan->dma_config.dst_maxburst;
>  
> -	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
> +	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
>  	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
>  	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
>  
> @@ -965,7 +965,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
>  	if (!desc)
>  		return NULL;
>  
> -	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
> +	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
>  	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
>  	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
>  	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
> -- 
> 2.25.1
> 
