Return-Path: <dmaengine+bounces-9881-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB7PNE0s0WnaGAcAu9opvQ
	(envelope-from <dmaengine+bounces-9881-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 04 Apr 2026 17:20:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9FD39B925
	for <lists+dmaengine@lfdr.de>; Sat, 04 Apr 2026 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A62F630054E6
	for <lists+dmaengine@lfdr.de>; Sat,  4 Apr 2026 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB5629DB6C;
	Sat,  4 Apr 2026 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGjseQO0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E528CF5D
	for <dmaengine@vger.kernel.org>; Sat,  4 Apr 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316042; cv=none; b=BOjzU3DNHaxfuzxhqgWvUpNzmEIA5DFZQo1XbG9M6fINyks6OxmojPiV4WmiIUtiNZ0tjjo+dqBlaPx/XWZXzxeAU6xSFo8mXqWUsJ6vgnBk/cwNSylnt3SjpETcN5PiH7mItr7Cz08h+mHgZ5RYpXctwYRaR5wblM5BJHeDrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316042; c=relaxed/simple;
	bh=J8FzS+CSU69FSQIi9wBAZnsU0SweAmHtu7qW+siLjq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q063MtcGXiAcw7NEfnDz3aiTpRTn2fPb8zcqxpyts+k+Jex7+p1v+Rnnlqx2rZT0YHZgfIBGdnqZEZrAamN8oaZbb5Bv48jfZWZXGNVQW1HMOeahhCCImKk3Yup30ZR2ML3DcvQnH+rhtTMLDbNSU7lpOMvy4P17O4TzfGIHsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGjseQO0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b258d93ffeso15508165ad.3
        for <dmaengine@vger.kernel.org>; Sat, 04 Apr 2026 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775316040; x=1775920840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nc/bnRMeGUTxcJeiwl19RqjbnMmZOtJf4LTnxFOKNJw=;
        b=DGjseQO0obW4Gud0JyOPOEen8Jdp48CI/4gljnULyWRu8U9xRSNCTM/dmS28hK/5cx
         TpPnPo18otJ2V/ymMWOmS/angje92wGZO5eCk7C93JvvPQ9Zg6r6vyxwMgSXN8/nljT6
         xZ69GbcZf03Z5ClbSEI9x3os+ZIAwXF9nBdYBWRaiBwYgD0ZG54WgpnclHxDt16AYqrE
         iiSBW+dBT5v1VK9n56UL/h0dgWltkbMtx2PST/KmzEfC0D5TBn+/8HATGfuM+yIWEMPO
         X5oJbUob1NBmQuuyykdFN7n9+qmo2IRmswdzABITWi+OBgcVDn/xBVkvVGEQoYj/7PlL
         DQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775316040; x=1775920840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc/bnRMeGUTxcJeiwl19RqjbnMmZOtJf4LTnxFOKNJw=;
        b=VnRtC4GkMQbyUs3tT/Ao9qgmqgm/ea5SsmLovOZ9CvBAEx74RjzXF84cpJer8OvidY
         H44l99+YmLsubD6QbRAecWbJvw9T7pRECtHgi3dm614yTzFHVofaE9QURj4dR6CLIaLY
         PxYl4CedovSINx4aKiFlW6tsNO36d6GMT1FEvr2BnDX1po6xhmZz9+63OeZe0yKyZQlP
         fdFhrsXiid5HzGzjU9CLZap7CWuyh9UkyoYG/OK1xiGPyARaAHUtLhvOnK/H5EmJUxdo
         U3jSzb3x57x9cCIWK0HKGk4x0I8bGo4SzeO9HzJuReuGNQalws0vqqwuDRz9nPRMW7Mb
         6aRA==
X-Forwarded-Encrypted: i=1; AJvYcCXGHgrxmv3sXxM1k/udPkvcU+1gkM6dQbO6vhvdAnuwE8RNqzObekYE7Hjwt0ZOIxezdPBZVc0dMmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sp6lOF3ZoNkIQg34kcj1r57k9Pf+l0l2i6lJn8+4CKGi9b1S
	UuIC38ZeyFyUUV8sfJ7NPgYtsYkxTQl+lHqYlBiEnwrfRYtYndS8ou8y
X-Gm-Gg: AeBDiesQbFcF8/X0aS+EiMf0YhAPS5iAIxUUGKOhBo8+DROzUGCYH2ZN7S4e/f0nAPT
	U+1towAU4jUTah3Dm8WOT+OIO+nFqULSJ1D3GbtbvLhxn+HsBq3Yw4BL8JJhQCIFPn3pRpuFCN+
	32gy4Nz0w/yVFAeipGDm9zn4Q7hbM5at+e3vUJROJ5Abi2i18MYFXJnu3AiHHpvBz6CpeGUpLY6
	Eqd83BrMIIcjIpTpIG6mmtnVRrrXeWDOzGKss9Wv6FbjW6EryGfTcv4TCWjoAt4OOJ1J6pBp+qT
	L9Z95/TjRbJLpFCQ5sgX41KFAL/C147xR3KyN3WcEEMvLIqMsZvbDVHx6o6snU1yO9Veb2uOOi1
	LC25MAHLRR+yyQ2Vsoy89tzyg0s7uZRoVQ0z9hAZE0gD6UhUjvu2244mQMcaiGIKy+wjF+Cj44H
	CbkmrySiFjEimBxz+DpRUG6tSAVrDyVmkzItOtybdXVVjSqUQanA==
X-Received: by 2002:a17:903:32cd:b0:2b2:4697:78f5 with SMTP id d9443c01a7336-2b281798164mr63121125ad.36.1775316040052;
        Sat, 04 Apr 2026 08:20:40 -0700 (PDT)
Received: from [192.168.0.213] ([60.49.20.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d54bsm85101325ad.1.2026.04.04.08.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 08:20:39 -0700 (PDT)
Message-ID: <46be45c0-ba15-47c4-b356-60a3d6491f6a@gmail.com>
Date: Sat, 4 Apr 2026 23:20:34 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
To: Frank Li <Frank.li@nxp.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus.Elfring@web.de
References: <20260328025706.52722-1-karom.9560@gmail.com>
 <20260328025706.52722-2-karom.9560@gmail.com>
 <acqQTmr5ti8RWfnV@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <acqQTmr5ti8RWfnV@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[metafoo.de,kernel.org,vger.kernel.org,web.de];
	TAGGED_FROM(0.00)[bounces-9881-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C9FD39B925
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30/3/2026 11:01 pm, Frank Li wrote:
> On Sat, Mar 28, 2026 at 10:56:55AM +0800, Khairul Anuar Romli wrote:
>>      checkpatch.pl --strict reports a CHECK warning in dw-axi-dmac.c:
>>
>>        CHECK: Alignment should match open parenthesis
>>
>>      This warning occurs when multi-line function calls or expressions have
>>      continuation lines that don't properly align with the opening
>>      parenthesis position.
>>
>>      Fixes all instances in dw-axi-dmac.c where continuation lines were
>>      indented with an inconsistent number of spaces/tabs that neither
>>      matched the parenthesis column nor followed a standard indent pattern.
>>      Proper alignment improves code readability and maintainability by
>>      making parameter lists visually consistent across the kernel codebase.
>>
>> Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
>> Fixes: e3923592f80b ("dmaengine: axi-dmac: populate residue info for completed xfers")
>> Fixes: 3f8fd25936ee ("dmaengine: axi-dmac: Allocate hardware descriptors")
>> Fixes: 921234e0c5d7 ("dmaengine: axi-dmac: Split too large segments")
>> Fixes: a5b982af953b ("dmaengine: axi-dmac: add a check for devm_regmap_init_mmio")
> 
> This is code cleanup and not user visiual problem. I think needn't add
> fixes tags here.
> 

I can remove the fixes tags in the next revision.
Thanks for pointing this out.

Best Regards,
Khairul

> Frank
> 
>> Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
>> ---
>>   drivers/dma/dma-axi-dmac.c | 28 +++++++++++++++-------------
>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
>> index 45c2c8e4bc45..0017f4dc6dcc 100644
>> --- a/drivers/dma/dma-axi-dmac.c
>> +++ b/drivers/dma/dma-axi-dmac.c
>> @@ -193,7 +193,7 @@ static struct axi_dmac_desc *to_axi_dmac_desc(struct virt_dma_desc *vdesc)
>>   }
>>
>>   static void axi_dmac_write(struct axi_dmac *axi_dmac, unsigned int reg,
>> -	unsigned int val)
>> +			   unsigned int val)
>>   {
>>   	writel(val, axi_dmac->base + reg);
>>   }
>> @@ -382,7 +382,7 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
>>   }
>>
>>   static inline unsigned int axi_dmac_total_sg_bytes(struct axi_dmac_chan *chan,
>> -	struct axi_dmac_sg *sg)
>> +						   struct axi_dmac_sg *sg)
>>   {
>>   	if (chan->hw_2d)
>>   		return (sg->hw->x_len + 1) * (sg->hw->y_len + 1);
>> @@ -437,7 +437,7 @@ static void axi_dmac_dequeue_partial_xfers(struct axi_dmac_chan *chan)
>>   }
>>
>>   static void axi_dmac_compute_residue(struct axi_dmac_chan *chan,
>> -	struct axi_dmac_desc *active)
>> +				     struct axi_dmac_desc *active)
>>   {
>>   	struct dmaengine_result *rslt = &active->vdesc.tx_result;
>>   	unsigned int start = active->num_completed - 1;
>> @@ -517,7 +517,7 @@ static bool axi_dmac_handle_cyclic_eot(struct axi_dmac_chan *chan,
>>   }
>>
>>   static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
>> -	unsigned int completed_transfers)
>> +				   unsigned int completed_transfers)
>>   {
>>   	struct axi_dmac_desc *active;
>>   	struct axi_dmac_sg *sg;
>> @@ -667,7 +667,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>>   	desc->chan = chan;
>>
>>   	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
>> -				&hw_phys, GFP_ATOMIC);
>> +				 &hw_phys, GFP_ATOMIC);
>>   	if (!hws) {
>>   		kfree(desc);
>>   		return NULL;
>> @@ -703,9 +703,11 @@ static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
>>   }
>>
>>   static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
>> -	enum dma_transfer_direction direction, dma_addr_t addr,
>> -	unsigned int num_periods, unsigned int period_len,
>> -	struct axi_dmac_sg *sg)
>> +						   enum dma_transfer_direction direction,
>> +						   dma_addr_t addr,
>> +						   unsigned int num_periods,
>> +						   unsigned int period_len,
>> +						   struct axi_dmac_sg *sg)
>>   {
>>   	unsigned int num_segments, i;
>>   	unsigned int segment_size;
>> @@ -817,7 +819,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
>>   		}
>>
>>   		dsg = axi_dmac_fill_linear_sg(chan, direction, sg_dma_address(sg), 1,
>> -			sg_dma_len(sg), dsg);
>> +					      sg_dma_len(sg), dsg);
>>   	}
>>
>>   	desc->cyclic = false;
>> @@ -857,7 +859,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
>>   	desc->sg[num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_LAST;
>>
>>   	axi_dmac_fill_linear_sg(chan, direction, buf_addr, num_periods,
>> -		period_len, desc->sg);
>> +				period_len, desc->sg);
>>
>>   	desc->cyclic = true;
>>
>> @@ -1006,7 +1008,7 @@ static void axi_dmac_adjust_chan_params(struct axi_dmac_chan *chan)
>>    * features are implemented and how it should behave.
>>    */
>>   static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
>> -	struct axi_dmac_chan *chan)
>> +				  struct axi_dmac_chan *chan)
>>   {
>>   	u32 val;
>>   	int ret;
>> @@ -1295,7 +1297,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>>   		return ret;
>>
>>   	ret = of_dma_controller_register(pdev->dev.of_node,
>> -		of_dma_xlate_by_chan_id, dma_dev);
>> +					 of_dma_xlate_by_chan_id, dma_dev);
>>   	if (ret)
>>   		return ret;
>>
>> @@ -1310,7 +1312,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>>   		return ret;
>>
>>   	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
>> -		 &axi_dmac_regmap_config);
>> +				       &axi_dmac_regmap_config);
>>
>>   	return PTR_ERR_OR_ZERO(regmap);
>>   }
>> --
>> 2.43.0
>>


