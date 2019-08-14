Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0D8C9A4
	for <lists+dmaengine@lfdr.de>; Wed, 14 Aug 2019 04:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHNCkY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 22:40:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbfHNCkX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Aug 2019 22:40:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 71FB0567C5C78BC6698F;
        Wed, 14 Aug 2019 10:40:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 14 Aug 2019
 10:40:15 +0800
Subject: Re: [PATCH linux-next] drivers: dma: Fix sparse warning for
 mux_configure32
To:     Vinod Koul <vkoul@kernel.org>
References: <20190812074205.96759-1-maowenan@huawei.com>
 <20190813044327.GR12733@vkoul-mobl.Dlink>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <0a29e584-2385-9e7c-8d13-3ba47d3bf81c@huawei.com>
Date:   Wed, 14 Aug 2019 10:40:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190813044327.GR12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019/8/13 12:43, Vinod Koul wrote:
> On 12-08-19, 15:42, Mao Wenan wrote:
> 
> Patch title is incorrect, it should mention the changes in patch, for
> example make mux_configure32 static
> 
> Do read up on Documentation/process/submitting-patches.rst again!
> 
>> There is one sparse warning in drivers/dma/fsl-edma-common.c,
> 
> It will help to explain the warning before the fix
> 
>> fix it by setting mux_configure32() as static.
>>
>> make allmodconfig ARCH=mips CROSS_COMPILE=mips-linux-gnu-
>> make C=2 drivers/dma/fsl-edma-common.o ARCH=mips CROSS_COMPILE=mips-linux-gnu-
> 
> Make cmds are not relevant for the log
> 
>> drivers/dma/fsl-edma-common.c:93:6: warning: symbol 'mux_configure32' was not declared. Should it be static?
> 
> This one is and should be retained
> 
>>
>> Fixes: 232a7f18cf8ec ("dmaengine: fsl-edma: add i.mx7ulp edma2 version support")
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  drivers/dma/fsl-edma-common.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
>> index 6d6d8a4..7dbf7df 100644
>> --- a/drivers/dma/fsl-edma-common.c
>> +++ b/drivers/dma/fsl-edma-common.c
>> @@ -90,8 +90,8 @@ static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
>>  	iowrite8(val8, addr + off);
>>  }
>>  
>> -void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
>> -		     u32 off, u32 slot, bool enable)
>> +static void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
> 
> just change this to static
> 
>> +			    u32 off, u32 slot, bool enable)
> 
> and dont change anything else.
> 
> If you feel to change this, propose a new patch for this line explaining
> why this should be changed

thanks, I will send v2.

> 
>>  {
>>  	u32 val;
>>  
>> -- 
>> 2.7.4
> 

