Return-Path: <dmaengine+bounces-9904-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJpQH1zu1GkjywcAu9opvQ
	(envelope-from <dmaengine+bounces-9904-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 13:45:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8688F3ADE67
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 13:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCB43301574A
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1733AEF26;
	Tue,  7 Apr 2026 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/cGEA0u"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A272617
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562242; cv=none; b=TetWSSLOBbV2RruLM3Ch+WX4YrQWey/FmlRwebjBKazKxvnObVEIq0nSftYk/e80/0TCW4Pr1Bd2byXvNQVz1Ndr1C49SH87dvmyLdkkQq6ksN3hax12FFZa5bWiMyQVwk+m5aVoju0xzGb5HvPAf2t8O2pRAcoqHW/CAeGQLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562242; c=relaxed/simple;
	bh=CBmfa0iIUFOOOOYDQdTs6rtB6ov1tin2SugzhDhE43A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HU7UdrLGy2Xo4lJ4LiZIXmcYkBA9pT8tb+zNW5q337p+s9/DLLfqgD26U81LNPXVH0o6gL3qDSOTLiphY21PPEDqsQ6u1eoH3MidKHCKXivNZRN4QW8tKGUL0UMZa0DgkWRo6SmGZjOrFW1pLNwf4621YOTDe5P8hb9dwaEKG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/cGEA0u; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so2081946a12.3
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562240; x=1776167040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVVWpGwW/5QOw+XHnWGWqUAqKP41+UFg8ENTY5HZopY=;
        b=p/cGEA0uLMImbtdPAfz1zDDXYTLtF/Gg9ZH6SGFy47LD7rFgHwZbnQk/0db+QKKP2S
         ilvUi0IoFc+IfsyZxWewxjJygmkUoLCbGEsaIkc0EUkAQ0z9xre+/oyjD7WYUVMuARn0
         r/nmlcrLcWGovvbk7mp0nVihoXTqOzx20AM3RG+JvgfwS1IFuQyviz9sVSp4EudZq7pD
         yzE1g0/BM+Z+3i7uMbnuau2UqlCFdvcmJDBHEdKwCc/QNMPIxBtF8wPzLIyEFXQ+itVl
         2yhGSRgtka4Ar5FF6En5N3HpOdelIp+5hul98AVRFeDDAt6pN1ATr1zTFGLKzyPVgVgL
         D9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562240; x=1776167040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVVWpGwW/5QOw+XHnWGWqUAqKP41+UFg8ENTY5HZopY=;
        b=rH3uxz7wWbq6z/Eq0e/AzTfvx1KKhQ6YOqgrONy0M14QGC3tyUcbMlOzVtZwO5OM4c
         B6RSkTprryI+0K7Oa7j/aw/aAW6FEzNJotjm7a/fNcPZQ9yzZp+hyWViAKyCWBG0hqaC
         tQFT7mIs5Krlufw4lBFZqqJXaGoMvEr129s9fR6NFQo2UF1jh3Lr3+/S93NeNUT6GS+0
         KKnIqgCckql05wcTSyLHCV1VArSzAr1UKZd4sKOcmK/qfjRHaghn9V9Vs+baHENiP6so
         O1M2zBVpbruyh7KsxUivR4T8umZVB75hpAc89+8qOxqcosSs9G7KXQ/LEeMms9RjypL4
         6rhg==
X-Forwarded-Encrypted: i=1; AJvYcCUBvIhgxX+ro6YFMJ/MN/JIpMegOW2SF4IMlFGd9RXFqqM+unIKPCdxn1GXZ3xsDJLShoz1GapoDTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqWR8QBokJg+nppKynLfrcRdnGgibmyRdVUo4mCvSfGTGX+6c
	uKsez444NGk0f9VrvAYLHPnPwcAjdAidlEPvfiGYwywfo9IrGETLF7Wz
X-Gm-Gg: AeBDiet/3jqHfglFCXxpkePNN0jDRrS1UvXrEnO30LWvreRxmJyfepDEEpqCZlhmWMP
	nGDcqpk5f+eLo4zh/enXxiDiVOYa+cQwcBs1J1blDO6aEy795HLkMAqSDV78iTaqy2KM8A937/O
	ybcJY0HDoBUqMSnLWQ9KpZWBYs8Qir99Aye0RweMTlLuJ9r3UjZSA4Tn0DNjB+9Lcgu1Qe6LllK
	lRTrkJv3tMRxDrpRnuoYGavnebQzLQ6ohkGWZb6JavWfeLwAnSw75iOwgmFCR6djEWH7mKNMuWE
	3wbaeLJmbNi4HO/KkPEO5CeaXTYfDZM/WT/AFIzivb4X3k5FSctzNxEwCkOkX0Trw3+3u231SRX
	cIWDUNsqp3188XWkMDhPMGsxJ8OrDCnZ5ZbjtJ/F8apN7OCv3IsgS0iTD+BXRzsIOYTpPfFe8v5
	l/CW+XKXz65IGH9gEmMpwJYu4VIvtgUnYn5ziiKAkyxwMMdHaMhuEUkMpfHdSV6DqmQXp+V90VD
	A==
X-Received: by 2002:a17:903:94e:b0:2b0:7026:24bf with SMTP id d9443c01a7336-2b28180530fmr169885225ad.14.1775562240186;
        Tue, 07 Apr 2026 04:44:00 -0700 (PDT)
Received: from ?IPV6:2402:1980:8a7:b6e:7dd1:8ac6:4f63:fbb5? ([2402:1980:8a7:b6e:7dd1:8ac6:4f63:fbb5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd4dsm167900365ad.76.2026.04.07.04.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:43:59 -0700 (PDT)
Message-ID: <19338db6-2f40-4441-98f4-c862feac2cb6@gmail.com>
Date: Tue, 7 Apr 2026 19:43:53 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus.Elfring@web.de
References: <20260328025706.52722-1-karom.9560@gmail.com>
 <20260328025706.52722-2-karom.9560@gmail.com>
 <acqQTmr5ti8RWfnV@lizhi-Precision-Tower-5810>
 <46be45c0-ba15-47c4-b356-60a3d6491f6a@gmail.com> <adNK9Aoa_gKGMfTG@vaman>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <adNK9Aoa_gKGMfTG@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[nxp.com,metafoo.de,kernel.org,vger.kernel.org,web.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9904-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 8688F3ADE67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/4/2026 1:56 pm, Vinod Koul wrote:
> On 04-04-26, 23:20, Khairul Anuar Romli wrote:
>> On 30/3/2026 11:01 pm, Frank Li wrote:
>>> On Sat, Mar 28, 2026 at 10:56:55AM +0800, Khairul Anuar Romli wrote:
>>>>       checkpatch.pl --strict reports a CHECK warning in dw-axi-dmac.c:
>>>>
>>>>         CHECK: Alignment should match open parenthesis
>>>>
>>>>       This warning occurs when multi-line function calls or expressions have
>>>>       continuation lines that don't properly align with the opening
>>>>       parenthesis position.
>>>>
>>>>       Fixes all instances in dw-axi-dmac.c where continuation lines were
>>>>       indented with an inconsistent number of spaces/tabs that neither
>>>>       matched the parenthesis column nor followed a standard indent pattern.
>>>>       Proper alignment improves code readability and maintainability by
>>>>       making parameter lists visually consistent across the kernel codebase.
>>>>
>>>> Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
>>>> Fixes: e3923592f80b ("dmaengine: axi-dmac: populate residue info for completed xfers")
>>>> Fixes: 3f8fd25936ee ("dmaengine: axi-dmac: Allocate hardware descriptors")
>>>> Fixes: 921234e0c5d7 ("dmaengine: axi-dmac: Split too large segments")
>>>> Fixes: a5b982af953b ("dmaengine: axi-dmac: add a check for devm_regmap_init_mmio")
>>>
>>> This is code cleanup and not user visiual problem. I think needn't add
>>> fixes tags here.
>>>
>>
>> I can remove the fixes tags in the next revision.
>> Thanks for pointing this out.
> 
> These kind of code formatting dont help much. These cause problems
> porting fixes to stable. So I am not very inclined to take these
> 

I will drop this then. Thanks.

>>
>> Best Regards,
>> Khairul
>>
>>> Frank
>>>
>>>> Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
>>>> ---
>>>>    drivers/dma/dma-axi-dmac.c | 28 +++++++++++++++-------------
>>>>    1 file changed, 15 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
>>>> index 45c2c8e4bc45..0017f4dc6dcc 100644
>>>> --- a/drivers/dma/dma-axi-dmac.c
>>>> +++ b/drivers/dma/dma-axi-dmac.c
>>>> @@ -193,7 +193,7 @@ static struct axi_dmac_desc *to_axi_dmac_desc(struct virt_dma_desc *vdesc)
>>>>    }
>>>>
>>>>    static void axi_dmac_write(struct axi_dmac *axi_dmac, unsigned int reg,
>>>> -	unsigned int val)
>>>> +			   unsigned int val)
>>>>    {
>>>>    	writel(val, axi_dmac->base + reg);
>>>>    }
>>>> @@ -382,7 +382,7 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
>>>>    }
>>>>
>>>>    static inline unsigned int axi_dmac_total_sg_bytes(struct axi_dmac_chan *chan,
>>>> -	struct axi_dmac_sg *sg)
>>>> +						   struct axi_dmac_sg *sg)
>>>>    {
>>>>    	if (chan->hw_2d)
>>>>    		return (sg->hw->x_len + 1) * (sg->hw->y_len + 1);
>>>> @@ -437,7 +437,7 @@ static void axi_dmac_dequeue_partial_xfers(struct axi_dmac_chan *chan)
>>>>    }
>>>>
>>>>    static void axi_dmac_compute_residue(struct axi_dmac_chan *chan,
>>>> -	struct axi_dmac_desc *active)
>>>> +				     struct axi_dmac_desc *active)
>>>>    {
>>>>    	struct dmaengine_result *rslt = &active->vdesc.tx_result;
>>>>    	unsigned int start = active->num_completed - 1;
>>>> @@ -517,7 +517,7 @@ static bool axi_dmac_handle_cyclic_eot(struct axi_dmac_chan *chan,
>>>>    }
>>>>
>>>>    static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
>>>> -	unsigned int completed_transfers)
>>>> +				   unsigned int completed_transfers)
>>>>    {
>>>>    	struct axi_dmac_desc *active;
>>>>    	struct axi_dmac_sg *sg;
>>>> @@ -667,7 +667,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>>>>    	desc->chan = chan;
>>>>
>>>>    	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
>>>> -				&hw_phys, GFP_ATOMIC);
>>>> +				 &hw_phys, GFP_ATOMIC);
>>>>    	if (!hws) {
>>>>    		kfree(desc);
>>>>    		return NULL;
>>>> @@ -703,9 +703,11 @@ static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
>>>>    }
>>>>
>>>>    static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
>>>> -	enum dma_transfer_direction direction, dma_addr_t addr,
>>>> -	unsigned int num_periods, unsigned int period_len,
>>>> -	struct axi_dmac_sg *sg)
>>>> +						   enum dma_transfer_direction direction,
>>>> +						   dma_addr_t addr,
>>>> +						   unsigned int num_periods,
>>>> +						   unsigned int period_len,
>>>> +						   struct axi_dmac_sg *sg)
>>>>    {
>>>>    	unsigned int num_segments, i;
>>>>    	unsigned int segment_size;
>>>> @@ -817,7 +819,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
>>>>    		}
>>>>
>>>>    		dsg = axi_dmac_fill_linear_sg(chan, direction, sg_dma_address(sg), 1,
>>>> -			sg_dma_len(sg), dsg);
>>>> +					      sg_dma_len(sg), dsg);
>>>>    	}
>>>>
>>>>    	desc->cyclic = false;
>>>> @@ -857,7 +859,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
>>>>    	desc->sg[num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_LAST;
>>>>
>>>>    	axi_dmac_fill_linear_sg(chan, direction, buf_addr, num_periods,
>>>> -		period_len, desc->sg);
>>>> +				period_len, desc->sg);
>>>>
>>>>    	desc->cyclic = true;
>>>>
>>>> @@ -1006,7 +1008,7 @@ static void axi_dmac_adjust_chan_params(struct axi_dmac_chan *chan)
>>>>     * features are implemented and how it should behave.
>>>>     */
>>>>    static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
>>>> -	struct axi_dmac_chan *chan)
>>>> +				  struct axi_dmac_chan *chan)
>>>>    {
>>>>    	u32 val;
>>>>    	int ret;
>>>> @@ -1295,7 +1297,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>>>>    		return ret;
>>>>
>>>>    	ret = of_dma_controller_register(pdev->dev.of_node,
>>>> -		of_dma_xlate_by_chan_id, dma_dev);
>>>> +					 of_dma_xlate_by_chan_id, dma_dev);
>>>>    	if (ret)
>>>>    		return ret;
>>>>
>>>> @@ -1310,7 +1312,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>>>>    		return ret;
>>>>
>>>>    	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
>>>> -		 &axi_dmac_regmap_config);
>>>> +				       &axi_dmac_regmap_config);
>>>>
>>>>    	return PTR_ERR_OR_ZERO(regmap);
>>>>    }
>>>> --
>>>> 2.43.0
>>>>
> 


