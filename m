Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE7C2DF983
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 08:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgLUHgj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 02:36:39 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:48806 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgLUHgj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Dec 2020 02:36:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608536174; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=cIizDPRICPgg/bSArezwSPToM2+vbpPt0D05PpcHIg4=;
 b=QQ9PR2yny1v2TWOhaTA5VOO1w+QZ+773+gfuM5gFatHmYnjo5el/Vgg3K7MjI15ePgiyjnNg
 0drFYKk4l9TSosxrHYqYsnfHxRIFLqCUlJ8WwHv2orb15iZh+wO3TbnRhNpfIsaCGmMamr4R
 2BICIUMamYu5RihhaIy9rp+Q9mk=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyJiZjYxOCIsICJkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fe050520564dfefcd460bbf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Dec 2020 07:35:46
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A31CC43464; Mon, 21 Dec 2020 07:35:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 721FCC433CA;
        Mon, 21 Dec 2020 07:35:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Dec 2020 13:05:44 +0530
From:   mdalam@codeaurora.org
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     vkoul@kernel.org, corbet@lwn.net, agross@kernel.org,
        bjorn.andersson@linaro.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
In-Reply-To: <6c85436d-e064-367e-736b-951af82256c8@linaro.org>
References: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
 <6c85436d-e064-367e-736b-951af82256c8@linaro.org>
Message-ID: <9769c54acf54617a17346fea60ee38b6@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020-12-19 09:05, Thara Gopinath wrote:
> On 12/17/20 9:37 AM, Md Sadre Alam wrote:
>> This change will add support for LOCK & UNLOCK flag bit support
>> on CMD descriptor.
>> 
>> If DMA_PREP_LOCK flag passed in prep_slave_sg then requester of this
>> transaction wanted to lock the DMA controller for this transaction so
>> BAM driver should set LOCK bit for the HW descriptor.
>> 
>> If DMA_PREP_UNLOCK flag passed in prep_slave_sg then requester of this
>> transaction wanted to unlock the DMA controller.so BAM driver should 
>> set
>> UNLOCK bit for the HW descriptor.
> Hi,
> 
> This is a generic question. What is the point of LOCK/UNLOCK with
> allocating LOCK groups to the individual dma channels? By default
> doesn't all channels fall in the same group. This would mean that
> a lock does not prevent the dma controller from not executing a
> transaction on the other channels.
> 

The Pipe Locking/Unlocking will be only on command-descriptor.
Upon encountering a command descriptor with LOCK bit set, the BAM
will lock all other pipes not related to the current pipe group, and 
keep
handling the current pipe only until it sees the UNLOCK set then it will
release all locked pipes.

The actual locking is done on the new descriptor fetching for 
publishing,
i.e. locked pipe will not fetch new descriptors even if it got 
event/events
adding more descriptors for this pipe (locked pipe).

The bam LOCKING mechanism is needed where different cores needs to share
same hardware block which use bam for their transaction. So if both 
cores
wanted to access the hardware block in parallel via bam, then locking 
mechanism
is needed for bam pipes.

> --
> Warm Regards
> Thara
> 
>> 
>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>> ---
>>   Documentation/driver-api/dmaengine/provider.rst | 9 +++++++++
>>   drivers/dma/qcom/bam_dma.c                      | 9 +++++++++
>>   include/linux/dmaengine.h                       | 5 +++++
>>   3 files changed, 23 insertions(+)
>> 
>> diff --git a/Documentation/driver-api/dmaengine/provider.rst 
>> b/Documentation/driver-api/dmaengine/provider.rst
>> index ddb0a81..d7516e2 100644
>> --- a/Documentation/driver-api/dmaengine/provider.rst
>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>> @@ -599,6 +599,15 @@ DMA_CTRL_REUSE
>>     - This flag is only supported if the channel reports the 
>> DMA_LOAD_EOT
>>       capability.
>>   +- DMA_PREP_LOCK
>> +
>> +  - If set , the client driver tells DMA controller I am locking you 
>> for
>> +    this transcation.
>> +
>> +- DMA_PREP_UNLOCK
>> +
>> +  - If set, the client driver will tells DMA controller I am 
>> releasing the lock
>> +
>>   General Design Notes
>>   ====================
>>   diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index 4eeb8bb..cdbe395 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -58,6 +58,8 @@ struct bam_desc_hw {
>>   #define DESC_FLAG_EOB BIT(13)
>>   #define DESC_FLAG_NWD BIT(12)
>>   #define DESC_FLAG_CMD BIT(11)
>> +#define DESC_FLAG_LOCK BIT(10)
>> +#define DESC_FLAG_UNLOCK BIT(9)
>>     struct bam_async_desc {
>>   	struct virt_dma_desc vd;
>> @@ -644,6 +646,13 @@ static struct dma_async_tx_descriptor 
>> *bam_prep_slave_sg(struct dma_chan *chan,
>>     	/* fill in temporary descriptors */
>>   	desc = async_desc->desc;
>> +	if (flags & DMA_PREP_CMD) {
>> +		if (flags & DMA_PREP_LOCK)
>> +			desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
>> +		if (flags & DMA_PREP_UNLOCK)
>> +			desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
>> +	}
>> +
>>   	for_each_sg(sgl, sg, sg_len, i) {
>>   		unsigned int remainder = sg_dma_len(sg);
>>   		unsigned int curr_offset = 0;
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index dd357a7..79ccadb4 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -190,6 +190,9 @@ struct dma_interleaved_template {
>>    *  transaction is marked with DMA_PREP_REPEAT will cause the new 
>> transaction
>>    *  to never be processed and stay in the issued queue forever. The 
>> flag is
>>    *  ignored if the previous transaction is not a repeated 
>> transaction.
>> + * @DMA_PREP_LOCK: tell the driver that DMA HW engine going to be 
>> locked for this
>> + *  transaction , until not seen DMA_PREP_UNLOCK flag set.
>> + * @DMA_PREP_UNLOCK: tell the driver to unlock the DMA HW engine.
>>    */
>>   enum dma_ctrl_flags {
>>   	DMA_PREP_INTERRUPT = (1 << 0),
>> @@ -202,6 +205,8 @@ enum dma_ctrl_flags {
>>   	DMA_PREP_CMD = (1 << 7),
>>   	DMA_PREP_REPEAT = (1 << 8),
>>   	DMA_PREP_LOAD_EOT = (1 << 9),
>> +	DMA_PREP_LOCK = (1 << 10),
>> +	DMA_PREP_UNLOCK = (1 << 11),
>>   };
>>     /**
>> 
