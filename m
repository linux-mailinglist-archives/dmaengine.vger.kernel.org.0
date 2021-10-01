Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8341E822
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 09:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352057AbhJAHRD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 03:17:03 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44126 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238668AbhJAHRC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Oct 2021 03:17:02 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19129KNc001404;
        Fri, 1 Oct 2021 09:15:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=l2iRc9kE2dEezV+1JNj+2fgTrN2R77mcxJ4PyU00rHI=;
 b=s3sfagtqbEzHHRR7KHJtK29t/qWlc7KaqSCMMZd6wXby6gYi6QoM/G9FSInnHCltCajY
 aSgiufAe2PZYntmsee+ajhZSnC4b2+RowNEMUwXUakl3KB9vY0IiILKB5dGhbFEAWQOV
 0X8biN7PWN2Zz3ySA5+SSls98/9/oMGJqs+F/CkozqQL59p9QnFzzzKTWK8s3fktSOQM
 C41qyf0Z41jx2x3leRdAK+wWZHeoD3/K9MrgHcwhVnftQaaS+9okQLqcMOlWoowJkZqF
 0ZY3yXDdJl7msgkcWptNrEKxYMn8VhiGxfh+oFRi/CQGoDA8wkWfie2dqShmq9anoy2q 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bds9nh9pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 09:15:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B950A10002A;
        Fri,  1 Oct 2021 09:14:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AE47A211F3F;
        Fri,  1 Oct 2021 09:14:59 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 1 Oct
 2021 09:14:59 +0200
Subject: Re: [PATCH][next] dmaengine: stm32-mdma: Use struct_size() helper in
 devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20210929222922.GA357509@embeddedor>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <2e2fdc65-da02-90f3-e870-d63b43593c10@foss.st.com>
Date:   Fri, 1 Oct 2021 09:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929222922.GA357509@embeddedor>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_07,2021-09-30_01,2020-04-07_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/30/21 12:29 AM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worse scenario, could lead to heap overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
>   drivers/dma/stm32-mdma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index 18cbd1e43c2e..d30a4a28d3bf 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -1566,7 +1566,8 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>   	if (count < 0)
>   		count = 0;
>   
> -	dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev) + sizeof(u32) * count,
> +	dmadev = devm_kzalloc(&pdev->dev,
> +			      struct_size(dmadev, ahb_addr_masks, count),
>   			      GFP_KERNEL);
>   	if (!dmadev)
>   		return -ENOMEM;
> 
