Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA61435E5
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 04:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgAUD2t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jan 2020 22:28:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbgAUD2s (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Jan 2020 22:28:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 265DDF03C5BA81701639;
        Tue, 21 Jan 2020 11:28:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 Jan 2020
 11:28:43 +0800
Subject: Re: [PATCH -next] dmaengine: fsl-qdma: fix duplicated argument to &&
To:     Peng Ma <peng.ma@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
References: <20200120125843.34398-1-chenzhou10@huawei.com>
 <VI1PR04MB44314C51FA4C397F352C14C8ED0D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <96b96dda-0fdc-bbc1-cdb8-b7d0f20940e7@huawei.com>
Date:   Tue, 21 Jan 2020 11:28:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB44314C51FA4C397F352C14C8ED0D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peng,

On 2020/1/21 10:54, Peng Ma wrote:
> 
> 
>> -----Original Message-----
>> From: Chen Zhou <chenzhou10@huawei.com>
>> Sent: 2020Äê1ÔÂ20ÈÕ 20:59
>> To: dan.j.williams@intel.com; vkoul@kernel.org
>> Cc: Peng Ma <peng.ma@nxp.com>; Wen He <wen.he_1@nxp.com>;
>> jiaheng.fan@nxp.com; dmaengine@vger.kernel.org;
>> linux-kernel@vger.kernel.org; chenzhou10@huawei.com
>> Subject: [PATCH -next] dmaengine: fsl-qdma: fix duplicated argument to &&
>>
>> There is duplicated argument to && in function fsl_qdma_free_chan_resources,
>> which looks like a typo, pointer fsl_queue->desc_pool also needs NULL check,
>> fix it.
>> Detected with coccinelle.
>>
> What does the " coccinelle " mean here?

The scripts in kernel dir, that is coccicheck.

Thanks,
Chen Zhou

> 
>> Fixes: b092529e0aa0 ("dmaengine: fsl-qdma: Add qDMA controller driver for
>> Layerscape SoCs")
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>> drivers/dma/fsl-qdma.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c index
>> 8979208..95cc025 100644
>> --- a/drivers/dma/fsl-qdma.c
>> +++ b/drivers/dma/fsl-qdma.c
>> @@ -304,7 +304,7 @@ static void fsl_qdma_free_chan_resources(struct
>> dma_chan *chan)
>>
>> 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>>
>> -	if (!fsl_queue->comp_pool && !fsl_queue->comp_pool)
>> +	if (!fsl_queue->comp_pool && !fsl_queue->desc_pool)
>> 		return;
>>
> Hi Chen,
> 
> Thanks very much for your patch, It is really need to check comp_pool and desc_pool here.
> Reviewed-by: Peng Ma <peng.ma@nxp.com>
> Tested-by: Peng Ma <peng.ma@nxp.com>
> 
> BR,
> Peng
>> 	list_for_each_entry_safe(comp_temp, _comp_temp,
>> --
>> 2.7.4
> 

