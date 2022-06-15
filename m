Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9483A54CB9A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jun 2022 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344676AbiFOOnU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbiFOOnT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 10:43:19 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F1033A09;
        Wed, 15 Jun 2022 07:43:17 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FEZlfH027682;
        Wed, 15 Jun 2022 16:42:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=vmIbzfHV8QCPsylH3acjPZckKaAd10y9kHOAHMRBN/8=;
 b=4YZX6vcGkbt5oKxM3eDdiEOpqgR4bfflwlSbNgAhOUezMeq4j9I6I6l2jrPS+7F31BY3
 GsyDMTLTfLySB4h+/6qMfUo+Bdg4nsDEzJZcM+BRKgkhT6M6on9apaiSRd+JD3330L8O
 oLtOiUV/AKL4Ib9vDctwTq5sI3IzCWqV1NYQIFgqnhbfKp6zZusCWGOI0/R2S3YOO5fg
 PdowHfVZMEiWp2ykKT/jIs+OqxonoyhPlVz77WwTRW4iFJqzs5Q3lEO8H/r7+QzUbDQz
 YfpF+1cwZHMuBKoYw98qF8Ap1KUSG2K400Pa+cPxbsasMvQkz3yW2W1TKe9Vz5FVEGDB GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gqd17sua1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 16:42:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 54F9510002A;
        Wed, 15 Jun 2022 16:42:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 123652278B2;
        Wed, 15 Jun 2022 16:42:36 +0200 (CEST)
Received: from [10.211.13.69] (10.211.13.69) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Jun
 2022 16:42:35 +0200
Message-ID: <6e1f0081-5f1c-4865-cb66-dd2cf9a5c868@foss.st.com>
Date:   Wed, 15 Jun 2022 16:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: stm32-mdma: Remove dead code in
 stm32_mdma_irq_handler()
Content-Language: en-US
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Vinod Koul <vkoul@kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <ldv-project@linuxtesting.org>
References: <1655072638-9103-1-git-send-email-khoroshilov@ispras.ru>
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <1655072638-9103-1-git-send-email-khoroshilov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.211.13.69]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_13,2022-06-15_01,2022-02-23_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Alexey,

On 6/13/22 00:23, Alexey Khoroshilov wrote:
> Local variable chan is initialized by an address of element of chan array
> that is part of stm32_mdma_device struct, so it does not make sense to
> compare chan with NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
> ---
>   drivers/dma/stm32-mdma.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index caf0cce8f528..b11927ed4367 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -1328,12 +1328,7 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
>   		return IRQ_NONE;
>   	}
>   	id = __ffs(status);
> -
>   	chan = &dmadev->chan[id];
> -	if (!chan) {
> -		dev_warn(mdma2dev(dmadev), "MDMA channel not initialized\n");
> -		return IRQ_NONE;
> -	}
>   
>   	/* Handle interrupt for the channel */
>   	spin_lock(&chan->vchan.lock);

Thanks for your patch,

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
