Return-Path: <dmaengine+bounces-10420-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOopOJ+FBGrVKwIAu9opvQ
	(envelope-from <dmaengine+bounces-10420-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:07:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCFC534B25
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D733431DE0C6
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04D2DA76C;
	Wed, 13 May 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6e0uV5x"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB46C3F412F;
	Wed, 13 May 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679518; cv=none; b=h7mDMbzUcq4CrNDs7EaoWgasXWNqTwKT5042wv2suM2/TQJqLKUOqbOnLDX1o0ECzm6GY5xCMPwed3IWrulmQ4QVq5EM3UwIMOm/grP1EUPiTcEGSWbUUH5Bq+/HyqD8a4n0zYwFGZeqEGrEiLYgOscM5nABp74i8lTNmqcWMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679518; c=relaxed/simple;
	bh=1M+4vZXzttYsxL7HGO/EHkPPPZ2u++n1e1G0Q7GF6Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t31WMjaAHki61JkrIjKRQYNOhP8GiaU7lPC6kAM6uADf8V8Zq4HYCIFOxDqC+vrKjXqR4eZg32OXNasd0chvcjadmGX3quIthpRbDZWERyW1nEPC46iEUlQ7GTUwIgPB3FyPDRXi7TXOPK3L+SdfnTqzIpEw3+K+EQ8vwHmd+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6e0uV5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2DEC2BCB7;
	Wed, 13 May 2026 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778679518;
	bh=1M+4vZXzttYsxL7HGO/EHkPPPZ2u++n1e1G0Q7GF6Bk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F6e0uV5xAKUr9VQGnQvfYF6H1IRewtHxjZfM/1YYFQBqtqWw7cbNDlEVj1+t4usWA
	 MbWFneTlbmkuD87JttmjfjzJ0RC+spD0hqDipeGuExWYng2MGkGgt0RHkXOC+7OXJB
	 nB9K5efQYZ/H+t9T7eUSOMvHoR8tsHOTImCugWDQp/B1XElCT/zTIBz+msHmN0DweP
	 jW8URCC48Rsc4sE11dJA6MsDskawL518HPEoLhcEbzM1+Jgu4s4vtHh5m2gp+exei0
	 11iLBkij75hSR7yJ8lFPK7v9ovLFihUQs1hfBGTC0ZAgJFB5+owTtxHpc0EkV7hUWk
	 LPMxBeEz24vlg==
Message-ID: <a01a77bd-d027-410d-9f4d-0d8b51a69c82@kernel.org>
Date: Wed, 13 May 2026 16:38:32 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/17] dmaengine: sh: rz-dmac: Add cyclic DMA support
To: Frank Li <Frank.li@nxp.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 p.zabel@pengutronix.de, geert+renesas@glider.be,
 fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
 long.luu.ur@renesas.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-13-claudiu.beznea.uj@bp.renesas.com>
 <agOjABHHVacS6ow4@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <agOjABHHVacS6ow4@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7FCFC534B25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10420-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Action: no action

Hi, Frank,

On 5/13/26 01:00, Frank Li wrote:
> On Tue, May 12, 2026 at 03:12:13PM +0300, Claudiu Beznea wrote:
>> Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
>> introduced to mark cyclic channels and is set during the DMA prepare
>> callback. The IRQ handler checks this status bit and calls
>> vchan_cyclic_callback() accordingly.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v5:
>> - none
>>
>> Changes in v4:
>> - drop the nxla update logic in rz_dmac_lmdesc_recycle() as this is
>>    not needed for any kind of transfers
>> - drop the update of channel->status = 0 from rz_dmac_free_chan_resources()
>>    and rz_dmac_terminate_all() as this was moved in patch 09/17
>>
>> Changes in v3:
>> - updated rz_dmac_lmdesc_recycle() to restore the lmdesc->nxla
>> - in rz_dmac_prepare_descs_for_cyclic() update directly the
>>    desc->start_lmdesc with the descriptor pointer insted of the
>>    descriptor address
>> - used rz_dmac_lmdesc_addr() to compute the descritor address
>> - set channel->status = 0 in rz_dmac_free_chan_resources()
>> - in rz_dmac_prep_dma_cyclic() check for invalid periods or buffer len
>>    and limit the critical area protected by spinlock
>> - set channel->status = 0 in rz_dmac_terminate_all()
>> - updated rz_dmac_calculate_residue_bytes_in_vd() to use
>>    rz_dmac_lmdesc_addr()
>> - dropped goto in rz_dmac_irq_handler_thread() as it is not needed
>>    anymore; dropped also the local variable desc
>>
>> Changes in v2:
>> - none
>>
>>   drivers/dma/sh/rz-dmac.c | 136 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 130 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
>> index 2de519b581b6..d6ad070be705 100644
>> --- a/drivers/dma/sh/rz-dmac.c
>> +++ b/drivers/dma/sh/rz-dmac.c
>> @@ -35,6 +35,7 @@
>>   enum  rz_dmac_prep_type {
>>   	RZ_DMAC_DESC_MEMCPY,
>>   	RZ_DMAC_DESC_SLAVE_SG,
>> +	RZ_DMAC_DESC_CYCLIC,
>>   };
>>
>>   struct rz_lmdesc {
>> @@ -67,9 +68,11 @@ struct rz_dmac_desc {
>>   /**
>>    * enum rz_dmac_chan_status: RZ DMAC channel status
>>    * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
>> + * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
>>    */
>>   enum rz_dmac_chan_status {
>>   	RZ_DMAC_CHAN_STATUS_PAUSED,
>> +	RZ_DMAC_CHAN_STATUS_CYCLIC,
> 
> suggest add new field bool iscycle in rz_dmac_chan.

I would prefer as it was proposed in this patch, if all good with everybody. In 
this way everything status related is packed in a single variable, struct 
rz_dmac_chan::status, and only a single cleanup operation is needed when the 
transactions are terminated.

> 
>>   };
>>
>>   struct rz_dmac_chan {
>> @@ -191,6 +194,7 @@ struct rz_dmac {
>>
>>   /* LINK MODE DESCRIPTOR */
>>   #define HEADER_LV			BIT(0)
>> +#define HEADER_WBD			BIT(2)
>>
>>   #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
>>   #define RZ_DMAC_MAX_CHANNELS		16
>> @@ -431,6 +435,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>>   	channel->chctrl = 0;
>>   }
>>
> ...
>>
>> +static struct dma_async_tx_descriptor *
>> +rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
>> +			size_t buf_len, size_t period_len,
>> +			enum dma_transfer_direction direction,
>> +			unsigned long flags)
>> +{
>> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
>> +	struct rz_dmac_desc *desc;
>> +	size_t periods;
>> +
>> +	if (!is_slave_direction(direction))
>> +		return NULL;
>> +
>> +	if (!period_len || !buf_len)
>> +		return NULL;
>> +
>> +	periods = buf_len / period_len;
>> +	if (!periods || periods > DMAC_NR_LMDESC)
>> +		return NULL;
>> +
>> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
>> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
>> +			return NULL;
>> +
>> +		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);
> 
> sugest use dma_pool manage desc, so ld_free can be removed.

Sure, but I would like to keep it aside from this set as it already big enough 
and I haven't noticed any potential issues with it.

-- 
Thank you,
Claudiu


