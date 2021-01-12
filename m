Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F712F2B4F
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 10:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392368AbhALJcK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 04:32:10 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:37257 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392175AbhALJcK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 04:32:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610443904; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=DWSJoSoBHrzo0I5E/0FwlwBtCOm8HjJ2U/+dN2HVFFc=;
 b=nlD3xZk8mBd/g0ZWVPX1IWVSBvv3UG+0MUKyhcoSINY/jBG8DYurzN1xohN/UbjCahAiV4RU
 GzhYRBlAxEcEite2ayN3fAJJQwGHjpfYx0XvT8biwB6NFUcItqDdce57uL754/h4GgXRN6ZJ
 jw90FnPWBiaa75e2RTzdbtpowFg=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyJiZjYxOCIsICJkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ffd6c7fd84bad35475ad41f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Jan 2021 09:31:43
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8E105C433C6; Tue, 12 Jan 2021 09:31:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 035E1C43461;
        Tue, 12 Jan 2021 09:31:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jan 2021 15:01:42 +0530
From:   mdalam@codeaurora.org
To:     Vinod Koul <vkoul@kernel.org>
Cc:     corbet@lwn.net, agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org,
        mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
In-Reply-To: <efcc74bbdf36b4ddbf764eb6b4ed99f2@codeaurora.org>
References: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
 <20201221092355.GA3323@vkoul-mobl>
 <efcc74bbdf36b4ddbf764eb6b4ed99f2@codeaurora.org>
Message-ID: <f7de0117c8ff2e61c09f58acdea0e5b0@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020-12-21 23:03, mdalam@codeaurora.org wrote:
> On 2020-12-21 14:53, Vinod Koul wrote:
>> Hello,
>> 
>> On 17-12-20, 20:07, Md Sadre Alam wrote:
>>> This change will add support for LOCK & UNLOCK flag bit support
>>> on CMD descriptor.
>>> 
>>> If DMA_PREP_LOCK flag passed in prep_slave_sg then requester of this
>>> transaction wanted to lock the DMA controller for this transaction so
>>> BAM driver should set LOCK bit for the HW descriptor.
>>> 
>>> If DMA_PREP_UNLOCK flag passed in prep_slave_sg then requester of 
>>> this
>>> transaction wanted to unlock the DMA controller.so BAM driver should 
>>> set
>>> UNLOCK bit for the HW descriptor.
>> 
>> Can you explain why would we need to first lock and then unlock..? How
>> would this be used in real world.
>> 
>> I have read a bit of documentation but is unclear to me. Also should
>> this be exposed as an API to users, sounds like internal to driver..?
>> 
> 
> IPQ5018 SoC having only one Crypto Hardware Engine. This Crypto 
> Hardware Engine
> will be shared between A53 core & ubi32 core. There is two separate
> driver dedicated
> to A53 core and ubi32 core. So to use Crypto Hardware Engine
> parallelly for encryption/description
> we need bam locking mechanism. if one driver will submit the request
> for encryption/description
> to Crypto then first it has to set LOCK flag bit on command descriptor
> so that other pipes will
> get locked.
> 
> The Pipe Locking/Unlocking will be only on command-descriptor. Upon
> encountering a command descriptor
> with LOCK bit set, The BAM will lock all other pipes not related to
> the current pipe group, and keep
> handling the current pipe only until it sees the UNLOCK set then it
> will release all locked pipes.
> locked pipe will not fetch new descriptors even if it got event/events
> adding more descriptors for
> this pipe (locked pipe).
> 
> No need to expose as an API to user because its internal to driver, so
> while preparing command descriptor
> just we have to update the LOCK/UNLOCK flag.


ping! Is there any update on this ? Do you need any further info ?
> 
> 
>> 
>>> 
>>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>>> ---
>>>  Documentation/driver-api/dmaengine/provider.rst | 9 +++++++++
>>>  drivers/dma/qcom/bam_dma.c                      | 9 +++++++++
>>>  include/linux/dmaengine.h                       | 5 +++++
>>>  3 files changed, 23 insertions(+)
>>> 
>>> diff --git a/Documentation/driver-api/dmaengine/provider.rst 
>>> b/Documentation/driver-api/dmaengine/provider.rst
>>> index ddb0a81..d7516e2 100644
>>> --- a/Documentation/driver-api/dmaengine/provider.rst
>>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>>> @@ -599,6 +599,15 @@ DMA_CTRL_REUSE
>>>    - This flag is only supported if the channel reports the 
>>> DMA_LOAD_EOT
>>>      capability.
>>> 
>>> +- DMA_PREP_LOCK
>>> +
>>> +  - If set , the client driver tells DMA controller I am locking you 
>>> for
>>> +    this transcation.
>>> +
>>> +- DMA_PREP_UNLOCK
>>> +
>>> +  - If set, the client driver will tells DMA controller I am 
>>> releasing the lock
>>> +
>>>  General Design Notes
>>>  ====================
>>> 
>>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>>> index 4eeb8bb..cdbe395 100644
>>> --- a/drivers/dma/qcom/bam_dma.c
>>> +++ b/drivers/dma/qcom/bam_dma.c
>>> @@ -58,6 +58,8 @@ struct bam_desc_hw {
>>>  #define DESC_FLAG_EOB BIT(13)
>>>  #define DESC_FLAG_NWD BIT(12)
>>>  #define DESC_FLAG_CMD BIT(11)
>>> +#define DESC_FLAG_LOCK BIT(10)
>>> +#define DESC_FLAG_UNLOCK BIT(9)
>>> 
>>>  struct bam_async_desc {
>>>  	struct virt_dma_desc vd;
>>> @@ -644,6 +646,13 @@ static struct dma_async_tx_descriptor 
>>> *bam_prep_slave_sg(struct dma_chan *chan,
>>> 
>>>  	/* fill in temporary descriptors */
>>>  	desc = async_desc->desc;
>>> +	if (flags & DMA_PREP_CMD) {
>>> +		if (flags & DMA_PREP_LOCK)
>>> +			desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
>>> +		if (flags & DMA_PREP_UNLOCK)
>>> +			desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
>>> +	}
>>> +
>>>  	for_each_sg(sgl, sg, sg_len, i) {
>>>  		unsigned int remainder = sg_dma_len(sg);
>>>  		unsigned int curr_offset = 0;
>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>>> index dd357a7..79ccadb4 100644
>>> --- a/include/linux/dmaengine.h
>>> +++ b/include/linux/dmaengine.h
>>> @@ -190,6 +190,9 @@ struct dma_interleaved_template {
>>>   *  transaction is marked with DMA_PREP_REPEAT will cause the new 
>>> transaction
>>>   *  to never be processed and stay in the issued queue forever. The 
>>> flag is
>>>   *  ignored if the previous transaction is not a repeated 
>>> transaction.
>>> + * @DMA_PREP_LOCK: tell the driver that DMA HW engine going to be 
>>> locked for this
>>> + *  transaction , until not seen DMA_PREP_UNLOCK flag set.
>>> + * @DMA_PREP_UNLOCK: tell the driver to unlock the DMA HW engine.
>>>   */
>>>  enum dma_ctrl_flags {
>>>  	DMA_PREP_INTERRUPT = (1 << 0),
>>> @@ -202,6 +205,8 @@ enum dma_ctrl_flags {
>>>  	DMA_PREP_CMD = (1 << 7),
>>>  	DMA_PREP_REPEAT = (1 << 8),
>>>  	DMA_PREP_LOAD_EOT = (1 << 9),
>>> +	DMA_PREP_LOCK = (1 << 10),
>>> +	DMA_PREP_UNLOCK = (1 << 11),
>>>  };
>>> 
>>>  /**
>>> --
>>> 2.7.4
