Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216844A497
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfFRO4b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 10:56:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55252 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRO4b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 10:56:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B55B460CEC; Tue, 18 Jun 2019 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560869790;
        bh=xbKJPmMAYjgq8I6UR0jotR8HtE1F+opco6JMkB9KGLk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ceWnmm4iYJZas3B4RBtGze+kX2MJXmtsn6uCBIFBWa48QiTM0qKHuN2nvzUVLukbZ
         hzOY57OkYlv4v2h9F5DFshr/cfa/8jw8siYZR9NdNlTOPWWrQoW7sIKVsksqXbi6Nm
         t7U+hfLMkFnQO4hI+qE/9LpBJLxdSfeIRrxAxJ4c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.5] (unknown [122.164.143.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 193B3611FD;
        Tue, 18 Jun 2019 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560869787;
        bh=xbKJPmMAYjgq8I6UR0jotR8HtE1F+opco6JMkB9KGLk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Flc9D2TibgCxpq5qLlq9Y8V6B2V/nJxUSu2q9iG3k5+cai/1mtWdG16wkzWOOGxQ2
         ILJuqfsmsfJXOwPb/7QqPyuAcJHdXvZubKpyHRL/um78CCZpaukUl2MpyqCO3U1hEh
         vZRcjX9jD1eKDQ/4xPw77Gg2MFnbV0vyLhiU4v7M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 193B3611FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom-bam: fix circular buffer handling
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
 <f4522b78-b406-954c-57b7-923e6ab31f96@codeaurora.org>
 <d84af3ad-5ba4-0f24-fd30-2fa20cf85658@linaro.org>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <2d370a33-fa16-45ca-cf82-9d775349f806@codeaurora.org>
Date:   Tue, 18 Jun 2019 20:26:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d84af3ad-5ba4-0f24-fd30-2fa20cf85658@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Srini,

On 6/18/2019 8:20 PM, Srinivas Kandagatla wrote:
> Hi Sricharan,
> 
> On 18/06/2019 08:13, Sricharan R wrote:
>> Hi Srini,
>>
>> On 6/14/2019 7:50 PM, Srinivas Kandagatla wrote:
>>> For some reason arguments to most of the circular buffers
>>> macros are used in reverse, tail is used for head and vice versa.
>>>
>>> This leads to bam thinking that there is an extra descriptor at the
>>> end and leading to retransmitting descriptor which was not scheduled
>>> by any driver. This happens after MAX_DESCRIPTORS (4096) are scheduled
>>> and done, so most of the drivers would not notice this, unless they are
>>> heavily using bam dma. Originally found this issue while testing
>>> SoundWire over SlimBus on DB845c which uses DMA very heavily for
>>> read/writes.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>   drivers/dma/qcom/bam_dma.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>>> index cb860cb53c27..43d7b0a9713a 100644
>>> --- a/drivers/dma/qcom/bam_dma.c
>>> +++ b/drivers/dma/qcom/bam_dma.c
>>> @@ -350,8 +350,8 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
>>>   #define BAM_DESC_FIFO_SIZE    SZ_32K
>>>   #define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)
>>>   #define BAM_FIFO_SIZE    (SZ_32K - 8)
>>> -#define IS_BUSY(chan)    (CIRC_SPACE(bchan->tail, bchan->head,\
>>> -             MAX_DESCRIPTORS + 1) == 0)
>>> +#define IS_BUSY(chan)    (CIRC_SPACE(bchan->head, bchan->tail,\
>>> +             MAX_DESCRIPTORS) == 0)
>>>     struct bam_chan {
>>>       struct virt_dma_chan vc;
>>> @@ -806,7 +806,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
>>>           offset /= sizeof(struct bam_desc_hw);
>>>             /* Number of bytes available to read */
>>> -        avail = CIRC_CNT(offset, bchan->head, MAX_DESCRIPTORS + 1);
>>> +        avail = CIRC_CNT(bchan->head, offset, MAX_DESCRIPTORS);
>>>
>>   one question, so MAX_DESCRIPTORS is already a mask,
>>      #define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)
>>
>>   CIRC_CNT/SPACE macros also does a size - 1, so would it not be a problem if we
>>   just pass MAX_DESCRIPTORS ?
> 
> Thanks for looking at this,
> TBH, usage of CIRC_* macros is only valid for power-of-2 buffers,
> In bam case MAX_DESCRIPTORS is 4095.
> Am really not sure why 8 bytes have been removed from fifo data buffer size.
> So basically usage of these macros is incorrect in bam case, this need to be fixed properly.
> 
> Do you agree?
> 
  So MAX_DESCRIPTORS is used in driver for masking head/tail pointers.
  That's why we have to pass MAX_DESCRIPTORS + 1 so that it works
  when the Macros does a size - 1

Regards,
 Sricharan

> Vinod, can you hold off with this patch, I will try to find some time this week to cook up a better patch removing the usage of these macros.
> 
> 
> 
> thanks,
> srini
> 
>>
>> Regards,
>>   Sricharan
>>   
>>>           list_for_each_entry_safe(async_desc, tmp,
>>>                        &bchan->desc_list, desc_node) {
>>> @@ -997,8 +997,7 @@ static void bam_start_dma(struct bam_chan *bchan)
>>>               bam_apply_new_config(bchan, async_desc->dir);
>>>             desc = async_desc->curr_desc;
>>> -        avail = CIRC_SPACE(bchan->tail, bchan->head,
>>> -                   MAX_DESCRIPTORS + 1);
>>> +        avail = CIRC_SPACE(bchan->head, bchan->tail, MAX_DESCRIPTORS);
>>>             if (async_desc->num_desc > avail)
>>>               async_desc->xfer_len = avail;
>>>
>>

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
