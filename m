Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1A605973
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 10:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJTIPW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 04:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiJTIPS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 04:15:18 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33D72850;
        Thu, 20 Oct 2022 01:15:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSeIVLA_1666253704;
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSeIVLA_1666253704)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 16:15:05 +0800
Message-ID: <a20f43dd-3259-5251-6c13-73664a600c42@linux.alibaba.com>
Date:   Thu, 20 Oct 2022 16:15:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2] dmaengine: sprd: Support two-stage dma interrupt
To:     Cixi Geng <gengcixi@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cixi Geng <cixi.geng1@unisoc.com>
References: <20221003234929.186290-1-gengcixi@gmail.com>
 <Y1AEngC3y9+OyG5S@matsya>
 <CAF12kFsKV3dY4pTxv5TxHZ0=WWnNRtjTwJfzrrs0_9YGvBwu_w@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAF12kFsKV3dY4pTxv5TxHZ0=WWnNRtjTwJfzrrs0_9YGvBwu_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/20/2022 3:33 PM, Cixi Geng wrote:
> Vinod Koul <vkoul@kernel.org> 于2022年10月19日周三 22:07写道：
>>
>> On 04-10-22, 07:49, Cixi Geng wrote:
>>> From: Cixi Geng <cixi.geng1@unisoc.com>
>>>
>>> Audio need to request Audio CP global dma interrupt, so Audio CP
>>> DMA should support two-stage interrupt to adapte it.
>>> It will occur interrupt when two-stage dma channel transfer done.
>>
>> The patch looks fine to me but...
>>
>>> diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
>>> index d09c6f6f6da5..26de41d6d915 100644
>>> --- a/include/linux/dma/sprd-dma.h
>>> +++ b/include/linux/dma/sprd-dma.h
>>
>>>   enum sprd_dma_int_type {
>>>        SPRD_DMA_NO_INT,
>>> @@ -112,6 +120,10 @@ enum sprd_dma_int_type {
>>>        SPRD_DMA_TRANS_BLK_INT,
>>>        SPRD_DMA_LIST_INT,
>>>        SPRD_DMA_CFGERR_INT,
>>> +     SPRD_DMA_SRC_CHN0_INT,
>>> +     SPRD_DMA_SRC_CHN1_INT,
>>> +     SPRD_DMA_DST_CHN0_INT,
>>> +     SPRD_DMA_DST_CHN1_INT,
>>
>> why is sprd_dma_int_type part of driver interface. sprd_dma_int_type is
>> used only by this driver and should be moved into the driver..

Now we can not move this into dma driver, since we have some drivers in 
the mainline will set the DMA interrupt type, such as spi-sprd.c, 
sprd_serial.c and sprd-pcm-compress.c.

>>
>> Can you change that as well please
> the two-stage interrupts added need more discuss and test,
> anyway, I can create a new patch for the change to move init_type into driver,
>>
>> --
>> ~Vinod
