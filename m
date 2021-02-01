Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38830A23B
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 07:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhBAGus (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 01:50:48 -0500
Received: from so15.mailgun.net ([198.61.254.15]:43902 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhBAGlT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 01:41:19 -0500
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 01:41:18 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612161647; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZjOKSuEmG5oI5YdY/ZLS031+4Hs/j21RMaHWa9FSN8k=;
 b=RcNz7cftj1ND5bLhir9WxlMIq2xai/vOKi2shY8JfhoqSRd/qiVrb/unVDQiKhsOcPF5FhzW
 ny35VO32f/zHJe2+kkoZfRdkJXXd4Hr3wzrfmTsaWRMBZYt+AhAeJ5ieS+ax6w+9XDHOvG2z
 Tqtv7/Mit0ti3wLHr535KslSBgc=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyJiZjYxOCIsICJkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60179e224ee30634eb23f454 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Feb 2021 06:22:26
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D4F1C433CA; Mon,  1 Feb 2021 06:22:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C66F6C433C6;
        Mon,  1 Feb 2021 06:22:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Feb 2021 11:52:24 +0530
From:   mdalam@codeaurora.org
To:     Vinod Koul <vkoul@kernel.org>
Cc:     corbet@lwn.net, agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org,
        mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
In-Reply-To: <20210201060508.GK2771@vkoul-mobl>
References: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
 <20201221092355.GA3323@vkoul-mobl>
 <efcc74bbdf36b4ddbf764eb6b4ed99f2@codeaurora.org>
 <f7de0117c8ff2e61c09f58acdea0e5b0@codeaurora.org>
 <20210112101056.GI2771@vkoul-mobl>
 <e3cf7c4fc02c54d17fd2fd213f39005b@codeaurora.org>
 <20210115055806.GE2771@vkoul-mobl>
 <97ce29b230164a5848a38f6448d1be60@codeaurora.org>
 <20210119164511.GE2771@vkoul-mobl>
 <534308caab7c18730ad0cc25248d116f@codeaurora.org>
 <20210201060508.GK2771@vkoul-mobl>
Message-ID: <9d33d73682f24d92338757e1823ccd88@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021-02-01 11:35, Vinod Koul wrote:
> On 27-01-21, 23:56, mdalam@codeaurora.org wrote:
>> On 2021-01-19 22:15, Vinod Koul wrote:
>> > On 18-01-21, 09:21, mdalam@codeaurora.org wrote:
>> > > On 2021-01-15 11:28, Vinod Koul wrote:
>> > > > On 14-01-21, 01:20, mdalam@codeaurora.org wrote:
>> > > > > On 2021-01-12 15:40, Vinod Koul wrote:
>> > > > > > On 12-01-21, 15:01, mdalam@codeaurora.org wrote:
>> > > > > > > On 2020-12-21 23:03, mdalam@codeaurora.org wrote:
>> > > > > > > > On 2020-12-21 14:53, Vinod Koul wrote:
>> > > > > > > > > Hello,
>> > > > > > > > >
>> > > > > > > > > On 17-12-20, 20:07, Md Sadre Alam wrote:
>> > > > > > > > > > This change will add support for LOCK & UNLOCK flag bit support
>> > > > > > > > > > on CMD descriptor.
>> > > > > > > > > >
>> > > > > > > > > > If DMA_PREP_LOCK flag passed in prep_slave_sg then requester of this
>> > > > > > > > > > transaction wanted to lock the DMA controller for this transaction so
>> > > > > > > > > > BAM driver should set LOCK bit for the HW descriptor.
>> > > > > > > > > >
>> > > > > > > > > > If DMA_PREP_UNLOCK flag passed in prep_slave_sg then requester
>> > > > > > > > > > of this
>> > > > > > > > > > transaction wanted to unlock the DMA controller.so BAM driver
>> > > > > > > > > > should set
>> > > > > > > > > > UNLOCK bit for the HW descriptor.
>> > > > > > > > >
>> > > > > > > > > Can you explain why would we need to first lock and then unlock..? How
>> > > > > > > > > would this be used in real world.
>> > > > > > > > >
>> > > > > > > > > I have read a bit of documentation but is unclear to me. Also should
>> > > > > > > > > this be exposed as an API to users, sounds like internal to driver..?
>> > > > > > > > >
>> > > > > > > >
>> > > > > > > > IPQ5018 SoC having only one Crypto Hardware Engine. This Crypto Hardware
>> > > > > > > > Engine
>> > > > > > > > will be shared between A53 core & ubi32 core. There is two separate
>> > > > > > > > driver dedicated
>> > > > > > > > to A53 core and ubi32 core. So to use Crypto Hardware Engine
>> > > > > > > > parallelly for encryption/description
>> > > > > > > > we need bam locking mechanism. if one driver will submit the request
>> > > > > > > > for encryption/description
>> > > > > > > > to Crypto then first it has to set LOCK flag bit on command descriptor
>> > > > > > > > so that other pipes will
>> > > > > > > > get locked.
>> > > > > > > >
>> > > > > > > > The Pipe Locking/Unlocking will be only on command-descriptor. Upon
>> > > > > > > > encountering a command descriptor
>> > > > > >
>> > > > > > Can you explain what is a cmd descriptor?
>> > > > >
>> > > > >   In BAM pipe descriptor structure there is a field called CMD
>> > > > > (Command
>> > > > > descriptor).
>> > > > >   CMD allows the SW to create descriptors of type Command which does
>> > > > > not
>> > > > > generate any data transmissions
>> > > > >   but configures registers in the Peripheral (write operations, and
>> > > > > read
>> > > > > registers operations ).
>> > > > >   Using command descriptor enables the SW to queue new configurations
>> > > > > between data transfers in advance.
>> > > >
>> > > > What and when is the CMD descriptor used for..?
>> > >
>> > >   CMD descriptor is mainly used for configuring controller register.
>> > >   We can read/write controller register via BAM using CMD descriptor
>> > > only.
>> > >   CMD descriptor use command pipe for the transaction.
>> >
>> > In which use cases would you need to issue cmd descriptors..?
>> 
>>   In IPQ5018 there is only one Crypto engine and it will get shared
>>   between UBI32 core & A53 core. So here we need to use command
>>   descriptor in-order to perform LOCKING/UNLOCKING mechanism. Since
>>   LOCK/ULOCK flag we can set only on CMD descriptor.
> 
> So when will lock/unlock be performed? Can you please explain that..

   LOCK/UNLOCK will be performed when two different driver wanted to use 
the
   same HW. eg. In IPQ5018 there is only one Crypto engine and it will be 
shared b/w
   UBI32 core driver and A53 core driver.

   When A53 core wanted to submit request to crypto engine via BAM then 
first it has to
   LOCK all other pipes (pipe dedicated to UBI32 core) and then trigger 
the transaction start.
   Once all the transaction will be completed the A53 core crypto driver 
will release the LOCK
   from all the pipes. Same sequence will be applicable for UBI32 core 
crypto driver as well.
   It depends whose request will come first to the crypto HW.


> 
>> >
>> > > >
>> > > > > >
>> > > > > > > > with LOCK bit set, The BAM will lock all other pipes not related to
>> > > > > > > > the current pipe group, and keep
>> > > > > > > > handling the current pipe only until it sees the UNLOCK set then it
>> > > > > > > > will release all locked pipes.
>> > > > > > > > locked pipe will not fetch new descriptors even if it got event/events
>> > > > > > > > adding more descriptors for
>> > > > > > > > this pipe (locked pipe).
>> > > > > > > >
>> > > > > > > > No need to expose as an API to user because its internal to driver, so
>> > > > > > > > while preparing command descriptor
>> > > > > > > > just we have to update the LOCK/UNLOCK flag.
>> > > > > >
>> > > > > > So IIUC, no api right? it would be internal to driver..?
>> > > > >
>> > > > >   Yes its totally internal to deriver.
>> > > >
>> > > > So no need for this patch then, right?
>> > >
>> > >   This patch is needed , because if some hardware will shared between
>> > >   multiple core like A53 and ubi32 for example. In IPQ5018 there is
>> > >   only one crypto engine and this will be shared between A53 core and
>> > >   ubi32 core and in A53 core & ubi32 core there are different drivers
>> > >   is getting used. So if encryption/decryption request come at same
>> > >   time from both the driver then things will get messed up. So here we
>> > >   need LOCKING mechanism.  If first request is from A53 core driver
>> > >   then this driver should lock all the pipes other than pipe dedicated
>> > >   to A53 core. So while preparing CMD descriptor driver should used
>> > >   this flag "DMA_PREP_LOCK", Since LOCK and UNLOCK flag bit we can set
>> > >   only on CMD descriptor. Once request processed then driver will set
>> > >   UNLOCK flag on CMD descriptor. Driver should use this flag
>> > >   "DMA_PREP_UNLOCK" while preparing CMD descriptor. Same logic will be
>> > >   apply for ubi32 core driver as well.
>> >
>> > Why cant this be applied at driver level, based on txn being issued it
>> > can lock issue the txn and then unlock when done. I am not convinced yet
>> > that this needs to be exported to users and can be managed by dmaengine
>> > driver.
>> 
>>   The actual LOCK/UNLOCK flag should be set on hardware command 
>> descriptor.
>>   so this flag setting should be done in DMA engine driver. The user 
>> of the
>> DMA
>>   driver like (in case of IPQ5018) Crypto can use flag "DMA_PREP_LOCK" 
>> &
>> "DMA_PREP_UNLOCK"
>>   while preparing CMD descriptor before submitting to the DMA engine. 
>> In DMA
>> engine driver
>>   we are checking these flasgs on CMD descriptor and setting actual
>> LOCK/UNLOCK flag on hardware
>>   descriptor.
> 
> 
> I am not sure I comprehend this yet.. when is that we would need to do
> this... is this for each txn submitted to dmaengine.. or something
> else..

  Its not for each transaction submitted to dmaengine. We have to set 
this only
  once on CMD descriptor. So when A53 crypto driver need to change the 
crypto configuration
  then first it will lock the all other pipes using setting the LOCK flag 
bit on CMD
  descriptor and then it can start the transaction , on data descriptor 
this flag will
  not get set once all transaction will be completed the A53 crypto 
driver release the lock on
  all other pipes using UNLOCK flag on CMD descriptor. So LOCK/UNLOCK 
will be only once and not for
  the each transaction.
> 
>> 
>>    if (flags & DMA_PREP_CMD) { <== check for descriptor type
>> 		if (flags & DMA_PREP_LOCK)
>> 			desc->flags |= cpu_to_le16(DESC_FLAG_LOCK); <== Actual LOCK flag 
>> setting
>> on HW descriptor.
>> 		if (flags & DMA_PREP_UNLOCK)
>> 			desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK); <== Actual UNLOCK 
>> flag
>> setting on HW descriptor.
>> 	}
>> >
>> > Thanks
