Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F7D318428
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 05:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBKECX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Feb 2021 23:02:23 -0500
Received: from so15.mailgun.net ([198.61.254.15]:55165 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhBKECW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 10 Feb 2021 23:02:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613016120; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Lq8DdjXqqA8/XH5/DT58A0SitVBIZI3XjzGmex+9Mk8=;
 b=Op6UAo16afVepH2UGiblBk3ETAgM2OgJN9aIRMFmQCiuInAsxVCy6OFsxc2dmlwzoIQoecr+
 6U072TfDesyvcSxzOTvq7O25Hhc4VPPQAxPck6jWhGfSb89t6XghgLFHq2E9Un6do4RmvKcI
 smwA+TlqukL9t0aidJDHsVxNN+0=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyJiZjYxOCIsICJkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6024ac1834db06ef794a3616 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 04:01:28
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1BF92C43461; Thu, 11 Feb 2021 04:01:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4379C433C6;
        Thu, 11 Feb 2021 04:01:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 11 Feb 2021 09:31:26 +0530
From:   mdalam@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, corbet@lwn.net, agross@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org,
        mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
In-Reply-To: <YCLH4ZOMjLbywl4u@builder.lan>
References: <20210112101056.GI2771@vkoul-mobl>
 <e3cf7c4fc02c54d17fd2fd213f39005b@codeaurora.org>
 <20210115055806.GE2771@vkoul-mobl>
 <97ce29b230164a5848a38f6448d1be60@codeaurora.org>
 <20210119164511.GE2771@vkoul-mobl>
 <534308caab7c18730ad0cc25248d116f@codeaurora.org>
 <20210201060508.GK2771@vkoul-mobl>
 <9d33d73682f24d92338757e1823ccd88@codeaurora.org>
 <20210201064314.GM2771@vkoul-mobl>
 <73c871d3d674607fafc7b79e602ec587@codeaurora.org>
 <YCLH4ZOMjLbywl4u@builder.lan>
Message-ID: <75b305066801fbfefa162326c63d1241@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021-02-09 23:05, Bjorn Andersson wrote:
> On Mon 01 Feb 09:50 CST 2021, mdalam@codeaurora.org wrote:
> 
>> On 2021-02-01 12:13, Vinod Koul wrote:
>> > On 01-02-21, 11:52, mdalam@codeaurora.org wrote:
>> > > On 2021-02-01 11:35, Vinod Koul wrote:
>> > > > On 27-01-21, 23:56, mdalam@codeaurora.org wrote:
>> >
>> > > > >   The actual LOCK/UNLOCK flag should be set on hardware command
>> > > > > descriptor.
>> > > > >   so this flag setting should be done in DMA engine driver. The user
>> > > > > of the
>> > > > > DMA
>> > > > >   driver like (in case of IPQ5018) Crypto can use flag
>> > > > > "DMA_PREP_LOCK" &
>> > > > > "DMA_PREP_UNLOCK"
>> > > > >   while preparing CMD descriptor before submitting to the DMA
>> > > > > engine. In DMA
>> > > > > engine driver
>> > > > >   we are checking these flasgs on CMD descriptor and setting actual
>> > > > > LOCK/UNLOCK flag on hardware
>> > > > >   descriptor.
>> > > >
>> > > >
>> > > > I am not sure I comprehend this yet.. when is that we would need to do
>> > > > this... is this for each txn submitted to dmaengine.. or something
>> > > > else..
>> > >
>> > >  Its not for each transaction submitted to dmaengine. We have to set
>> > > this
>> > > only
>> > >  once on CMD descriptor. So when A53 crypto driver need to change
>> > > the crypto
>> > > configuration
>> > >  then first it will lock the all other pipes using setting the LOCK
>> > > flag bit
>> > > on CMD
>> > >  descriptor and then it can start the transaction , on data
>> > > descriptor this
>> > > flag will
>> > >  not get set once all transaction will be completed the A53 crypto
>> > > driver
>> > > release the lock on
>> > >  all other pipes using UNLOCK flag on CMD descriptor. So LOCK/UNLOCK
>> > > will be
>> > > only once and not for
>> > >  the each transaction.
>> >
>> > Okay so why cant the bam driver check cmd descriptor and do lock/unlock
>> > as below, why do we need users to do this.
>> >
>> >         if (flags & DMA_PREP_CMD) {
>> >                 do_lock_bam();
>> 
>>  User will not decide to do this LOCK/UNLOCK mechanism. It depends on
>>  use case.  This LOCK/UNLOCK mechanism not required always. It needs
>>  only when hardware will be shared between different core with
>>  different driver.
> 
> So you have a single piece of crypto hardware and you're using the 
> BAM's
> LOCK/UNLOCK feature to implement a "mutex" on a particular BAM channel?

   Yes, In IPQ5018 SoC we are having only one Crypto and it will be 
shared between
   UBI32 core & A53 core, and these two cores are running different 
driver to use Crypto.
   The LOCK/UNLOCK flag can be set only on CMD descriptor.
> 
>>  The LOCK/UNLOCK flags provides SW to enter ordering between pipes
>> execution.
>>  (Generally, the BAM pipes are total independent from each other and 
>> work in
>> parallel manner).
>>  This LOCK/UNLOCK flags are part of actual pipe hardware descriptor.
>> 
>>  Pipe descriptor having the following flags:
>>  INT : Interrupt
>>  EOT: End of transfer
>>  EOB: End of block
>>  NWD: Notify when done
>>  CMD: Command
>>  LOCK: Lock
>>  UNLOCK: Unlock
>>  etc.
>> 
>>  Here the BAM driver is common driver for (QPIC, Crypto, QUP etc. in
>> IPQ5018)
>>  So here only Crypto will be shared b/w multiple cores so For crypto 
>> request
>> only the LOCK/UNLOCK
>>  mechanism required.
>>  For other request like for QPIC driver, QUPT driver etc. its not 
>> required.
>> So Crypto driver has to raise the flag for
>>  LOCK/UNLOCK while preparing CMD descriptor. The actual locking will 
>> happen
>> in BAM driver only using condition
>>  if (flags & DMA_PREP_CMD) {
>>      if (flags & DMA_PREP_LOCK)
>>         desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
>>  }
>> 
>>  So Crypto driver should set this flag DMA_PREP_LOCK while preparing 
>> CMD
>> descriptor.
>>  So LOCK should be set on actual hardware pipe descriptor with 
>> descriptor
>> type CMD.
>> 
> 
> It sounds fairly clear that the actual descriptor modification must
> happen in the BAM driver, but the question in my mind is how this is
> exposed to the DMAengine clients (e.g. crypto, QPIC etc).

   I have added these two flags "DMA_PREP_LOCK" & "DMA_PREP_UNLOCK" In 
enum dma_ctrl_flags.

   enum dma_ctrl_flags {
         DMA_PREP_INTERRUPT = (1 << 0),
@@ -202,6 +205,8 @@ enum dma_ctrl_flags {
         DMA_PREP_CMD = (1 << 7),
         DMA_PREP_REPEAT = (1 << 8),
         DMA_PREP_LOAD_EOT = (1 << 9),
+       DMA_PREP_LOCK = (1 << 10),
+       DMA_PREP_UNLOCK = (1 << 11),
  };

  So these flags we get passed while preparing CMD descriptor in Crypto 
driver. Based on these
  flags only i am setting LOCK/UNLOCK flags on actual hardware descriptor 
in BAM driver.

   if (flags & DMA_PREP_CMD) {
      if (flags & DMA_PREP_LOCK)
          desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);

> 
> What is the life span of the locked state? Do you always provide a
> series of descriptors that starts with a LOCK and ends with an UNLOCK?
> Or do you envision that the crypto driver provides a LOCK descriptor 
> and
> at some later point provides a UNLOCK descriptor?
> 

   While preparing CMD descriptor we will use this LOCK/UNLOCK flags. So 
if i wanted to write
   some 20 registers of Crypto HW via BAM then i will prepare multiple 
command descriptor
   let's say 20 CMD descriptor so in the very first CMD descriptor I will 
set the LOCK (DMA_PREP_LOCK ) flag and
   in the the last CMD descriptor I will set the UNLOCK (DMA_PREP_UNLOCK 
) flag.

> 
> Finally, this patch just adds the BAM part of things, where is the 
> patch
> that actually makes use of this feature?
> 
   Yes , this patch will add BAM part of things. For Crypto i will push 
another patch
   which will use this feature.

> Regards,
> Bjorn
> 
>> >
>> > The point here is that this seems to be internal to dma and should be
>> > handled by dma driver.
>> >
>>   This LOCK/UNLOK flags are part of actual hardware descriptor so this
>> should be handled by BAM driver only.
>>   If we set condition like this
>>   if (flags & DMA_PREP_CMD) {
>>                 do_lock_bam();
>>   Then LOCK/UNLOCK will be applied for all the CMD descriptor 
>> including
>> (QPIC driver, QUP driver , Crypto driver etc.).
>>   So this is not our intension. So we need to set this LOCK/UNLOCK 
>> only for
>> the drivers it needs. So Crypto driver needs
>>   locking mechanism so we will set LOCK/UNLOCK flag on Crypto driver 
>> request
>> only for other driver request like QPIC driver,
>>   QUP driver will not set this.
>> 
>> > Also if we do this, it needs to be done for specific platforms..
>> >
>> 
>> 
>> 
>> 
>> 
>> 
>> 
>> > Thanks
