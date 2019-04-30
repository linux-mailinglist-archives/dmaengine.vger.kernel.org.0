Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8CFBFF
	for <lists+dmaengine@lfdr.de>; Tue, 30 Apr 2019 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfD3O7M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Apr 2019 10:59:12 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1255 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbfD3O7L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Apr 2019 10:59:11 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3UEvMOH014946;
        Tue, 30 Apr 2019 16:59:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=WX2v4E4G7wsTl5MbSMxrQ1lv4WzmGNBX6flXO96hsOs=;
 b=G4fCm8cpR0XApBAIsoOVXe6wGMr//zsQ2ZSdPXAY2C10I0D6FjWAVFRcEEpAdKY2wvaA
 E5spUiqo5w2/wryy2OYQITnb+qKJPQ9d8/2b5nvixxFamYGktnKlxfzS/ZzyvzTPMS/A
 dyncxQtGNgt1pPl13FwjeVkUAMb+S0qLpjxiwxJgl8/EdPmI6Sthpc5VmVIokt6oZADK
 hGWM5OpQb9nCVYKEHlzDs/uZoDMh29viTMPPu9NOcdtaYkPHBK+auq/j5aBmPbBpIj+9
 q9qRwAGrDLjrnO35ahvIvGxeBZ0wwrYMu0vdNjQGeBB2wpE5YcEdeVW5BLWYbGHO6TD1 ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2s61r46nsf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Apr 2019 16:59:01 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7844731;
        Tue, 30 Apr 2019 14:59:00 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 46582283B;
        Tue, 30 Apr 2019 14:59:00 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 30 Apr
 2019 16:58:59 +0200
Subject: Re: [PATCH] dmaengine: stm32-dma: fix residue calculation in
 stm32-dma
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <1553689316-6231-1-git-send-email-arnaud.pouliquen@st.com>
 <20190426121751.GC28103@vkoul-mobl>
 <6894b54e-651f-1caf-d363-79d1ef0eee14@st.com>
 <20190429051310.GC3845@vkoul-mobl.Dlink>
 <26fa7710-76cb-e202-a367-c2e2408b6808@st.com>
 <20190430082255.GP3845@vkoul-mobl.Dlink>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <f7f28d56-a3e4-38a3-8580-b241fe0dcb49@st.com>
Date:   Tue, 30 Apr 2019 16:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430082255.GP3845@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_07:,,
 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/30/19 10:22 AM, Vinod Koul wrote:
> On 29-04-19, 16:52, Arnaud Pouliquen wrote:
>>
>>
>> On 4/29/19 7:13 AM, Vinod Koul wrote:
>>> On 26-04-19, 15:41, Arnaud Pouliquen wrote:
>>>>>> During residue calculation. the DMA can switch to the next sg. When
>>>>>> this race condition occurs, the residue returned value is not valid.
>>>>>> Indeed the position in the sg returned by the hardware is the position
>>>>>> of the next sg, not the current sg.
>>>>>> Solution is to check the sg after the calculation to verify it.
>>>>>> If a transition is detected we consider that the DMA has switched to
>>>>>> the beginning of next sg.
>>>>>
>>>>> Now, that sounds like duct tape. Why should we bother doing that.
>>>>>
>>>>> Also looking back at the stm32_dma_desc_residue() and calls to it from
>>>>> stm32_dma_tx_status() am not sure we are doing the right thing
>>>> Please, could you explain what you have in mind here?
>>>
>>> So when we call vchan_find_desc() that tells us if the descriptor is in
>>> the issued queue or not..  Ideally it should not matter if we have one
>>> or N descriptors issued to hardware.
>>>
>>> So why should you bother checking for next_sg.
>>>
>>>>> why are we looking at next_sg here, can you explain me that please
>>>>
>>>> This solution is similar to one implemented in the at_hdmac.c driver
>>>> (atc_get_bytes_left function).
>>>>
>>>> Yes could be consider as a workaround for a hardware issue...
>>>>
>>>> In stm32 DMA Peripheral, we can register up to 2 sg descriptors (sg1 &
>>>> sg2)in DMA registers, and use it in a cyclic mode (auto reload). This
>>>> mode is mainly use for audio transfer initiated by an ALSA driver.
>>>>
>>>> >From hardware point of view the DMA transfers first block based on sg1,
>>>> then it updates registers to prepare sg2 transfer, and then generates an
>>>> IRQ to inform that it issues the next transfer (sg2).
>>>>
>>>> Then driver can update sg1 to prepare the third transfer...
>>>>
>>>> In parallel the client driver can requests status to get the residue to
>>>> update internal pointer.
>>>> The issue is in the race condition between the call of the
>>>> device_tx_status ops and the update of the DMA register on sg switch.
>>>
>>> Sorry I do not agree! You are in stm32_dma_tx_status() hold the lock and
>>> IRQs are disabled, so even if sg2 was loaded, you will not get an
>>> interrupt and wont know. By looking at sg1 register you will see that
>>> sg1 is telling you that it has finished and residue can be zero. That is
>>> fine and correct to report.
>>>
>>> Most important thing here is that reside is for _requested_ descriptor
>>> and not _current_ descriptor, so looking into sg2 doesnt not fit.
>>>
>>>> During a short time the hardware updated the registers containing the
>>>> sg ID but not the transfer counter(SxNDTR). In this case there is a
>>>> mismatch between the Sg ID and the associated transfer counter.
>>>> So residue calculation is wrong.
>>>> Idea of this patch is to perform the calculation and then to crosscheck
>>>> that the hardware has not switched to the next sg during the
>>>> calculation. The way to crosscheck is to compare the the sg ID before
>>>> and after the calculation.
>>>>
>>>> I tested the solution to force a new recalculation but no real solution
>>>> to trust the registers during this phase. In this case an approximation
>>>> is to consider that the DMA is transferring the first bytes of the next sg.
>>>> So we return the residue corresponding to the beginning of the next buffer.
>>>
>>> And that is wrong!. The argument is 'cookie' and you return residue for
>>> that cookie.
>>>
>>> For example, if you have dma txn with cookie 1, 2, 3, 4 submitted, then currently HW
>>> is processing cookie 2, then for tx_status on:
>>> cookie 1: return DMA_COMPLETE, residue 0
>>> cookie 2: return DMA_IN_PROGRESS, residue (read from HW)
>>> cookie 3: return DMA_IN_PROGRESS, residue txn length
>>> cookie 4: return DMA_IN_PROGRESS, residue txn length
>>>
>>> Thanks
>>>
>> I think i miss something in my explanation, as from my humble POV (not
>> enough expert in DMA framework...) we only one cookie here as only one
>> cyclic transfer...
> 
>> Regarding your answers it looks like my sg explanation are not clear and
>> introduce confusions... Sorry for this, i was used sg for internal STM32
>> DMA driver, not for the framework API itself.
>>
>> Let try retry to re-explain you the stm32 DMA cyclic mode management.
>>
>> STM32 STM32 hardware:
>> -------------------
>> (ref manual:
>> https://www.st.com/content/ccc/resource/technical/document/reference_manual/group0/51/ba/9e/5e/78/5b/4b/dd/DM00327659/files/DM00327659.pdf/jcr:content/translations/en.DM00327659.pdf)
>>
>> The stm32 DMA supports cyclic mode using a hardware double
>> buffer mode.
>> In this double buffer, we can program up to 2 transfers. When one is
>> completed, the DMA automatically switch on the other. This could be see
>> as a hardware LLI with only 2 transfer descriptors.
>> A hardware bit CT (current target) is used to determine the
>> current transfer (CT = 0 or 1).
>> A hardware NDT (num of data to transfer) counter can be read to
>> determine DMA position in current transfer.
>> An IRQ is generated when this CT bit is updated to allows driver to
>> update the double buffer for the next transfer.
>>
>> On client side (a.e audio):
>> -------------------------
>> The client requests a cyclic transfer by calling
>> stm32_dma_prep_dma_cyclic. For instance it can request the transfer of a
>> buffer divided in 10 periods. In this case only one cookie submitted
>> (right?).
>>
>> At stm32dma driver level these 10 periods are registered in an internal
>> software table (desc->sg_req[]).As cyclic, the last sg_req point to the
>> first one.
>>
>> So to be able to transfer the whole software table, we have to update
>> the STM32 DMA double buffer at each end of transfer period.
>> The filed chan->next_sg points to the next sg_req in the software table.
>> that should be write in the STM32 DMA double buffer.
>>
>> Residue calculation:
>> -------------------
>> During a transfer we can get the position in a period thanks to the
>> NDT(num of data to transfer) bit-field.
>>
>> So the calculation is :
>> 1) Get the NDT field value
>> 3) add the periods remaining in the desc->sg_req[] table.
>>
>> In parallel the STM32 DMA hardware updates the transfer buffer in 3 steps:
>> 1) update CT register field.
>> 2) Update NDT register field.
>> 3) generate the IRQ (As you mention the IRQ is not treated during the
>> device_tx_status as protected from interrupts).
>>
>> We are facing issue when computing the residue during the update of the
>> CT and the NDT. The CT and NDT can as been updated ( both or only CT...)
>> without driver context update (IRQ disabled).
>> In this case we can point to the beginning of the current transfer(
>> completed) instead of the next_transfer. This generates a residue error
>> and for audio a time-stamp regression (so video freeze or audio plop).
>>
>> So the patch proposed consists in:
>> 1) getting the current NDT value
>> 2) reading CT and check that the hardware does not point to the next_sg.
>> 	if yes:
>> 	- CT has been updated by hardware but IRQ still not treated.
>> 	- By default we consider the current_sg as completed, so we
>> 	  point to the beginning of the next_sg buffer.
>>
>> Hope that will help to clarify.
> 
> Yes that helps, maybe we should add these bits in code and changelog..
> :)I will update the comments and commit message in a V2 in this way
> 
> And how does this impact non cyclic case where N descriptors maybe
> issued. The driver seems to support non cyclic too...

Correct it supports SG as well, but double buffer mode is not used in
such case. Hw is programmed under IT for every descriptors : no
automatic register reloaded as in cyclic mode. We won't end up in the
situation depicted below.

Thanks
-- 
~Arnaud
