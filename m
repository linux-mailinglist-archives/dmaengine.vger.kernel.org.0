Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE8489D30
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 17:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiAJQLU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 11:11:20 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54722 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236654AbiAJQLU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jan 2022 11:11:20 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20ADo8Tj021602;
        Mon, 10 Jan 2022 17:11:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=G0yUSQsLfDcfZw5v2vGpXxdzo++cGRi64INcl+rPjA4=;
 b=QFtqsp6QQ3IVh9a/ajeAsDwe9Txg/0e1+JRjSF3obXv8sHCiF4QLXgL0ho5Geh7VDfhS
 72YslM6blIQaSSKJKJEgbFzunW8EFfmSu9bRsqHwirUXXDXclZN4yC+kD1/LfgqGYAin
 x8/fj8btxe1g8ffS6X0jYx5KC6WGs3vAXOLT4qPTvVgkZHzPttbNQRvJ81kJ4SQp7FtY
 NKvgSJddKG+kRv+uduspI/9KzWtPf01gQONc8vpFSkNuMyaUvADJjFx7xNssE2lgpr3C
 CmMT+SlSwsBB/KmCJkQzTRGUKrXavfGOY+HxIlFVQxfO28u2kSuAWbbg/pXmP0+iY5ZJ dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dgh6uj1x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 17:11:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9971110002A;
        Mon, 10 Jan 2022 17:11:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8EA9A20757D;
        Mon, 10 Jan 2022 17:11:02 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 10 Jan
 2022 17:11:01 +0100
Subject: Re: [Linux-stm32] [PATCH] dmaengine: stm32-dmamux: Fix PM disable
 depth imbalance in stm32_dmamux_probe
To:     Miaoqian Lin <linmq006@gmail.com>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220108085336.11992-1-linmq006@gmail.com>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <37a66156-a616-058d-b3c0-6d2ca22a12ed@foss.st.com>
Date:   Mon, 10 Jan 2022 17:11:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220108085336.11992-1-linmq006@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_07,2022-01-10_02,2021-12-02_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 1/8/22 9:53 AM, Miaoqian Lin wrote:
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> 
> Fixes: 4f3ceca254e0 ("dmaengine: stm32-dmamux: Add PM Runtime support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks for your patch,

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
>   drivers/dma/stm32-dmamux.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
> index a42164389ebc..d5d55732adba 100644
> --- a/drivers/dma/stm32-dmamux.c
> +++ b/drivers/dma/stm32-dmamux.c
> @@ -292,10 +292,12 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
>   	ret = of_dma_router_register(node, stm32_dmamux_route_allocate,
>   				     &stm32_dmamux->dmarouter);
>   	if (ret)
> -		goto err_clk;
> +		goto pm_disable;
>   
>   	return 0;
>   
> +pm_disable:
> +	pm_runtime_disable(&pdev->dev);
>   err_clk:
>   	clk_disable_unprepare(stm32_dmamux->clk);
>   
> 
