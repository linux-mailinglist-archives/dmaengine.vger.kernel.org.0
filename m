Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1868F15264C
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 07:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgBEG3L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Feb 2020 01:29:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbgBEG3L (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 5 Feb 2020 01:29:11 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F292495C73F429EEABCA;
        Wed,  5 Feb 2020 14:29:07 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 5 Feb 2020
 14:29:05 +0800
Subject: Re: [PATCH -next] dmaengine: sun4i: remove set but unused variable
 'linear_mode'
To:     Chen-Yu Tsai <wens@csie.org>, Stefan Mavrodiev <stefan@olimex.com>
References: <20200205044247.32496-1-yuehaibing@huawei.com>
 <CAGb2v67gzb+8vR=6jQKX07pcARUqBHeburNWM9tqzqhfTnodGg@mail.gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <e125193f-b7b2-c3a8-2e09-925ba2116db0@huawei.com>
Date:   Wed, 5 Feb 2020 14:29:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v67gzb+8vR=6jQKX07pcARUqBHeburNWM9tqzqhfTnodGg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/2/5 12:56, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, Feb 5, 2020 at 12:43 PM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> drivers/dma/sun4i-dma.c: In function sun4i_dma_prep_dma_cyclic:
>> drivers/dma/sun4i-dma.c:672:24: warning:
>>  variable linear_mode set but not used [-Wunused-but-set-variable]
>>
>> commit ffc079a4accc ("dmaengine: sun4i: Add support for cyclic requests with dedicated DMA")
>> involved this unused variable.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/dma/sun4i-dma.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
>> index bbc2bda..501cd44 100644
>> --- a/drivers/dma/sun4i-dma.c
>> +++ b/drivers/dma/sun4i-dma.c
>> @@ -669,7 +669,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
>>         dma_addr_t src, dest;
>>         u32 endpoints;
>>         int nr_periods, offset, plength, i;
>> -       u8 ram_type, io_mode, linear_mode;
>> +       u8 ram_type, io_mode;
>>
>>         if (!is_slave_direction(dir)) {
>>                 dev_err(chan2dev(chan), "Invalid DMA direction\n");
>> @@ -684,11 +684,9 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
>>
>>         if (vchan->is_dedicated) {
>>                 io_mode = SUN4I_DDMA_ADDR_MODE_IO;
>> -               linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
>>                 ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
>>         } else {
>>                 io_mode = SUN4I_NDMA_ADDR_MODE_IO;
>> -               linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
>>                 ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
>>         }
> 
> I think it's better to actually use these values later when composing
> the value for `endpoints`, as we do in sun4i_dma_prep_slave_sg().
> 
> The code currently works because SUN4I_DDMA_ADDR_MODE_LINEAR == 0.
> However explicitly using the value makes the code more readable,
> and doesn't require the reader to have implicit knowledge of default
> values for parameters not specified in the composition of `endpoints`.

Thanks, will send v2.

> 
> ChenYu
> 
> .
> 

