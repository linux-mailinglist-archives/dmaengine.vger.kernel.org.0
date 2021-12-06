Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00246917F
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 09:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbhLFIdY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 03:33:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43618 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239430AbhLFIdU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 03:33:20 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B641GlM010420;
        Mon, 6 Dec 2021 09:29:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=7dw5R5/FK9LuNdO5hgpabaKMusyc01qO1lYQBujU+TM=;
 b=FnMw9A7tSgCl3z59RZaPD3wp5cQcGGcg+WromuhUTmwRcomG+0M7vrXNO+2aFPOmFTh+
 HbcNYxd617kUOFO3At+3+6qPG55LHxAyzUq7cvf5M09dC+gV1sed0DPMsbY5eoWrKabd
 rgOn2B54dxH0Ldf820aVlAMEyAjfKSTmLJo7RrBgJwKskzbJnYmM21UWH1iQUpX+xd9V
 /S50NrAhY9SZ5JC+cAUfyBiWWqy7akQ186qSkIdjz1+WWetaGuIl3Ap6yeOJxUVcHPtN
 tSc1Yk1YfuLsYLWCTZg5BTQ8eEoIQttJKZSLvnffEiv5i1bfxhbuk+ev9MHfqSXuL3Tp zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csb4j12uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 09:29:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F80910002A;
        Mon,  6 Dec 2021 09:29:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 776942239B2;
        Mon,  6 Dec 2021 09:29:30 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 6 Dec
 2021 09:29:29 +0100
Subject: Re: [Linux-stm32] [PATCH] dmaengine: stm32-mdma: Remove redundant
 initialization of pointer hwdesc
To:     Colin Ian King <colin.i.king@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211204140032.548066-1-colin.i.king@gmail.com>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <6ddc679f-c6d4-c0b7-5e1c-ef156a392488@foss.st.com>
Date:   Mon, 6 Dec 2021 09:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211204140032.548066-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_03,2021-12-06_01,2021-12-02_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 12/4/21 3:00 PM, Colin Ian King wrote:
> The pointer hwdesc is being initialized with a value that is never
> read, it is being updated later in a for-loop. The assignment is
> redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
>   drivers/dma/stm32-mdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index d30a4a28d3bf..805a449ff301 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -1279,7 +1279,7 @@ static size_t stm32_mdma_desc_residue(struct stm32_mdma_chan *chan,
>   				      u32 curr_hwdesc)
>   {
>   	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
> -	struct stm32_mdma_hwdesc *hwdesc = desc->node[0].hwdesc;
> +	struct stm32_mdma_hwdesc *hwdesc;
>   	u32 cbndtr, residue, modulo, burst_size;
>   	int i;
>   
> 
