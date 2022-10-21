Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E073B606D0E
	for <lists+dmaengine@lfdr.de>; Fri, 21 Oct 2022 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJUBfY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 21:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJUBfX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 21:35:23 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB3106A48;
        Thu, 20 Oct 2022 18:35:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSh81kA_1666316117;
Received: from 30.97.48.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSh81kA_1666316117)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 09:35:18 +0800
Message-ID: <18c6c091-6eb6-cc56-68d6-2b9811da9618@linux.alibaba.com>
Date:   Fri, 21 Oct 2022 09:35:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2] dmaengine: sprd: Support two-stage dma interrupt
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Cixi Geng <gengcixi@gmail.com>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cixi Geng <cixi.geng1@unisoc.com>
References: <20221003234929.186290-1-gengcixi@gmail.com>
 <Y1AEngC3y9+OyG5S@matsya>
 <CAF12kFsKV3dY4pTxv5TxHZ0=WWnNRtjTwJfzrrs0_9YGvBwu_w@mail.gmail.com>
 <a20f43dd-3259-5251-6c13-73664a600c42@linux.alibaba.com>
 <Y1EvX+hL/LWBnuvX@matsya>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Y1EvX+hL/LWBnuvX@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/20/2022 7:22 PM, Vinod Koul wrote:
> On 20-10-22, 16:15, Baolin Wang wrote:
> 
>>>> why is sprd_dma_int_type part of driver interface. sprd_dma_int_type is
>>>> used only by this driver and should be moved into the driver..
>>
>> Now we can not move this into dma driver, since we have some drivers in the
>> mainline will set the DMA interrupt type, such as spi-sprd.c, sprd_serial.c
>> and sprd-pcm-compress.c.
> 
> That may not sound right.. Why should peripheral set the DMA
> interrupt..?

That's because SPRD DMA controller supplies several different interrupt 
types for different scenarios of users, for example:

@SPRD_DMA_FRAG_INT: fragment done interrupt when one fragment request is 
done.
@SPRD_DMA_BLK_INT: block done interrupt when one block request is done.
@SPRD_DMA_BLK_FRAG_INT: block and fragment interrupt when one fragment 
or one block request is done.
@SPRD_DMA_TRANS_INT: tansaction done interrupt when one transaction 
request is done.
......

Some users may want use Linklist interrupt, and others may just want 
tansaction interrupt. So exposing these interrupt types for users to 
decide seems more suitable.
