Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48F7749671
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jul 2023 09:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjGFHdf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jul 2023 03:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjGFHdd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jul 2023 03:33:33 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B061BE5;
        Thu,  6 Jul 2023 00:33:30 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3667J0Yb028384;
        Thu, 6 Jul 2023 09:33:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=yUvAJnesmf9ag3cey+nHteBAMFKvwy231eP5urmwJNo=;
 b=6toPsb5lanfKdA71tYSakCK130zY+cHYfb6cMVRPhhLiu18Myc7xj6b+4A+SYOLjzMaa
 1Hg1Y5PhLvNTYgsokT9u5OouiYXj5lXx8YS3K07o8hjsRDXE8iH3v7OTX02QKhOgeWlt
 dUoN6rg7mtHF9gnQPOSH874ft+ZcNjU17YcKgLt7O59NfSmgzMOpLPOHzJxVxxPQwj4C
 dtpHK48uy73GQa5VYLUGc+0jNVTXSmMsYU72Z4F/xGz3TIJPIrGhgTqCLrJBF3FKjlyP
 a4JdPyVn6iH8ToAuR+bvRAdTS2tmhk9MaCvQHQYlK04DVrefmiO1SRNppAf349tahr18 gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rns47r3fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 09:33:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA492100052;
        Thu,  6 Jul 2023 09:33:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C2961212FA8;
        Thu,  6 Jul 2023 09:33:15 +0200 (CEST)
Received: from [10.252.18.80] (10.252.18.80) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 6 Jul
 2023 09:33:15 +0200
Message-ID: <fa7372b4-9ccd-290f-613f-42e6d577a1f4@foss.st.com>
Date:   Thu, 6 Jul 2023 09:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Linux-stm32] [PATCH 5/5] dmaengine: stm32-dma: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230705081856.13734-1-frank.li@vivo.com>
 <20230705081856.13734-5-frank.li@vivo.com>
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20230705081856.13734-5-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.80]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_04,2023-07-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/5/23 10:18, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Tested-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
>   drivers/dma/stm32-dma.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> index 37674029cb42..5c36811aa134 100644
> --- a/drivers/dma/stm32-dma.c
> +++ b/drivers/dma/stm32-dma.c
> @@ -1581,8 +1581,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
>   
>   	dd = &dmadev->ddev;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dmadev->base = devm_ioremap_resource(&pdev->dev, res);
> +	dmadev->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   	if (IS_ERR(dmadev->base))
>   		return PTR_ERR(dmadev->base);
>   
