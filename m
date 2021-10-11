Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30E4290EA
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbhJKOOG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 11 Oct 2021 10:14:06 -0400
Received: from aposti.net ([89.234.176.197]:41516 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239076AbhJKOLi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Oct 2021 10:11:38 -0400
Date:   Mon, 11 Oct 2021 16:09:29 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dmaengine: jz4780: Set max number of SGs per burst
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-mips@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <TNGT0R.X6IU8OUDO4HW2@crapouillou.net>
In-Reply-To: <GLCNYQ.LL8K0PVSTZ1W1@crapouillou.net>
References: <20210829195805.148964-1-contact@artur-rojek.eu>
        <GLCNYQ.LL8K0PVSTZ1W1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Le lun., août 30 2021 at 10:48:52 +0100, Paul Cercueil 
<paul@crapouillou.net> a écrit :
> Hi,
> 
> Le dim., août 29 2021 at 21:58:05 +0200, Artur Rojek 
> <contact@artur-rojek.eu> a écrit :
>> Total amount of SG list entries executed in a single burst is 
>> limited by
>> the number of available DMA descriptors.
>> This information is useful for device drivers utilizing this DMA 
>> engine.
>> 
>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> 
> Acked-by: Paul Cercueil <paul@crapouillou.net>

Feedback on this?

Cheers,
-Paul

>> ---
>>  drivers/dma/dma-jz4780.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
>> index ebee94dbd630..96701dedcac8 100644
>> --- a/drivers/dma/dma-jz4780.c
>> +++ b/drivers/dma/dma-jz4780.c
>> @@ -915,6 +915,7 @@ static int jz4780_dma_probe(struct 
>> platform_device *pdev)
>>  	dd->dst_addr_widths = JZ_DMA_BUSWIDTHS;
>>  	dd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>>  	dd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>> +	dd->max_sg_burst = JZ_DMA_MAX_DESC;
>> 
>>  	/*
>>  	 * Enable DMA controller, mark all channels as not programmable.
>> --
>> 2.33.0
>> 
> 


