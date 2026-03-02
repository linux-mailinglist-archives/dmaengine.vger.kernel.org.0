Return-Path: <dmaengine+bounces-9173-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCoLBo6VpWmPEQYAu9opvQ
	(envelope-from <dmaengine+bounces-9173-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 14:50:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E0D1DA1DE
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 14:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA981301DF67
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85292379EE1;
	Mon,  2 Mar 2026 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="W89NMauy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5D33ADBF
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459401; cv=none; b=Zi2h/FQnn86U0+kNqzls0xgFlIZuN/WXDfRFnHHa51SRcChexV43yLgaDToYDSuT/iHLR4iR0NEfxzqeYhfQjYEJ8PUB4XXwabNtn9M8I0OI5n7wXGpDesil7U8DQNDwzeb5FrHzna1BQ797kI1e6J9cxeBcBVOMM4RpmiTKDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459401; c=relaxed/simple;
	bh=6rxitJML5el8SD7x2bLQQ2FRCVMs9yxv6zhxa8ylm0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqScvkGnDzceGqX5MSWa/Q+rySNL4RrrJ5B5NQkBMEWicWGXyR+cpti/8Iy0AKrFtGdL4cD/W67AD6+n911iaBTQkSQ0bHvttValb4SLweG9DbeeNoQtexyEfq3Tu1Pfd20LrvWL7le3ApiFaL1bsG7TjrELD3FVcuMLQq484e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=W89NMauy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4837634de51so18375485e9.1
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 05:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772459398; x=1773064198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOGfBSF1Yzv+515EEkVwpjnn8h91APdHFmvLcZC+dMw=;
        b=W89NMauy/1z7mF+rIJ9SjSnsgrMYuU+3C6Pt8Zy1sGw9B1UmJnGOOgR1GjiBZU1YYM
         XFQWaVTG5lgRg4xgkzWKEF3HKbmkjfuq5hM3ZspgGErQUI3232yoDG0LhP4E/zvz7IsS
         Pq4qT0b1nybdtvAK5gCy/JdJKqn/KrvIoKwTK+/MWJRNOPU7DMH3Hn8ndDPha+DZ2CH8
         84qSOmbhR0++KBTpvqR+eQf4XTPBgO0bQtQfbWCITLEz4tG6eQ3/pbYTVkTcDqaifYHp
         rupRSQP9Jqi0j8KG4xHtZsF0ySYs7zY2IjYgaNXgVOBsFHQqrL/QBUDJgLaP9IG+LJXY
         DEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772459398; x=1773064198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOGfBSF1Yzv+515EEkVwpjnn8h91APdHFmvLcZC+dMw=;
        b=Ln8IaF2eb14gXdoF9jpA/lkCFyRjVisVZJJRlh4S+WBZdFI+CVn7kfHaayTDIgCv+8
         X91FJPMB1BBtafPqo6Xp5bZnINc5ken3bkG/k5vJoVN0LM07AWooVqBNjFX7aSL2mx/X
         KV1Gd+Fv5igzEnFwE6MqZcSz5/1Jku7pmQ9QaO2IwuVP4qHSFpdQyTfk7Pdb0xDuVYWr
         Nlq8UK5KloMhqOKFm66b9AIkdlW0z+q65FlgnZ/KC2sEKib9H9BsBGM4xruMkDIKrZXn
         v2JtlNQjQyv2JlN//h/Fwy33VettnVN9D+aSm9jGQIq/LaSFVym7+GVeuX/lMzSnHj5N
         Gn/g==
X-Forwarded-Encrypted: i=1; AJvYcCXlI3X93GSm4p46h/8vQrrtULZ6KuZORipdbT7a3iRKn4Pwk67MX3p1dJqzRr7Z/t59tNySbxPswrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywabe4m9v6iUznsJ2pXShfGbzyh97xXBpgCWx3z2j3CP0phwObF
	TWYsb/4NnqH5P8L0oED+bFtfxBEq8ZUURr23OeAtwYplEGf1plZ+yKBkGeWXiXrIg5c=
X-Gm-Gg: ATEYQzyAMip8436Z7rhJ903+jJ85p78QcnsZ/nAkE5Y+yrDuCer82Z2TK1xxz0YpPXC
	sh7mGsvOzmu27Lpx7Qs/e3Kcovo+mH6x6Jf/ZilSnIlgaV+mcUKpcDXchVdknHUHNb37YvxTkah
	p7NxK/P0O6uPvlLdL5KmetQ2M76EuICr5VhddO80rbcWW2ZcOsRIYHRMoK7UaOdbz24H9CbrNmh
	6t6RVbr7l8C989EI+epN3oEwPsxTT5f0gBXuFYs6EalqJHh0aVOJawmzk6zIoInyWu/8eI6nOkv
	iyNaj927pVfo+XjTeFfaOJW0oCz4pPwnM9pVL+9b2Pi73+w8Bc3U/vsODmlrwV+Os4MP6J75zuD
	CU1xfoX4nJ34qwzJlUSFy3huulHafBd+/nmHubv7jz+dwwDx0MDPwJIM69PPrC146aUIx71u0XY
	wu1qRGNtUpxvceFxQNtcmKMptkq1rZmjkW19OF
X-Received: by 2002:a05:600c:1c28:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-483c9bc5643mr221946815e9.3.1772459397277;
        Mon, 02 Mar 2026 05:49:57 -0800 (PST)
Received: from [172.19.170.194] ([213.233.104.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f3124sm414496905e9.1.2026.03.02.05.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 05:49:56 -0800 (PST)
Message-ID: <f33622bd-ac12-41d0-adea-6946e88815a8@tuxon.dev>
Date: Mon, 2 Mar 2026 15:49:54 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] dmaengine: sh: rz-dmac: Add device_tx_status()
 callback
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
 fabrizio.castro.jz@renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-8-claudiu.beznea.uj@bp.renesas.com>
 <aZ8mpBwOJ-opyKWi@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aZ8mpBwOJ-opyKWi@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_FROM(0.00)[bounces-9173-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tuxon.dev:mid,tuxon.dev:dkim]
X-Rspamd-Queue-Id: A3E0D1DA1DE
X-Rspamd-Action: no action

Hi, Frank,

On 2/25/26 18:43, Frank Li wrote:
> On Tue, Jan 20, 2026 at 03:33:29PM +0200, Claudiu wrote:
>> From: Biju Das <biju.das.jz@bp.renesas.com>
>>
>> Add support for device_tx_status() callback as it is needed for
>> RZ/G2L SCIFA driver.
>>
>> Based on a patch in the BSP similar to rcar-dmac by
>> Long Luu <long.luu.ur@renesas.com>.
> 
> If you want to give credit to Long Luu, any public link?

No public link as far as I'm aware. Anyway, I'll add his SoB + Co-developed-by.

> 
>>
>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>> [claudiu.beznea:
>>   - post-increment lmdesc in rz_dmac_get_next_lmdesc() to allow the next
>>     pointer to advance
>>   - use 'lmdesc->nxla != crla' comparison instead of
>>     '!(lmdesc->nxla == crla)' in rz_dmac_calculate_residue_bytes_in_vd()
>>   - in rz_dmac_calculate_residue_bytes_in_vd() use '++i >= DMAC_NR_LMDESC'
>>     to verify if the full lmdesc list was checked
>>   - drop rz_dmac_calculate_total_bytes_in_vd() and use desc->len instead
>>   - re-arranged comments so they span fewer lines and are wrapped to ~80
>>     characters
>>   - use u32 for the residue value and the functions returning it
>>   - use u32 for the variables storing register values
>>   - fixed typos]
> 
> Suppose needn't this section

Just followed the process. I can drop it.

> 
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v8:
>> - populated engine->residue_granularity
>>
>> Changes in v7:
>> - none
>>
>> Changes in v6:
>> - s/byte/bytes in comment from rz_dmac_chan_get_residue()
>>
>> Changes in v5:
>> - post-increment lmdesc in rz_dmac_get_next_lmdesc() to allow the next
>>    pointer to advance
>> - use 'lmdesc->nxla != crla' comparison instead of
>>    '!(lmdesc->nxla == crla)' in rz_dmac_calculate_residue_bytes_in_vd()
>> - in rz_dmac_calculate_residue_bytes_in_vd() use '++i >= DMAC_NR_LMDESC'
>>    to verify if the full lmdesc list was checked
>> - drop rz_dmac_calculate_total_bytes_in_vd() and use desc->len instead
>> - re-arranged comments so they span fewer lines and are wrapped to ~80
>>    characters
>> - use u32 for the residue value and the functions returning it
>> - use u32 for the variables storing register values
>> - fixed typos
>>
>>   drivers/dma/sh/rz-dmac.c | 145 ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 144 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
>> index 4602f8b7408a..27c963083e29 100644
>> --- a/drivers/dma/sh/rz-dmac.c
>> +++ b/drivers/dma/sh/rz-dmac.c
>> @@ -125,10 +125,12 @@ struct rz_dmac {
>>    * Registers
>>    */
>>
>> +#define CRTB				0x0020
>>   #define CHSTAT				0x0024
>>   #define CHCTRL				0x0028
>>   #define CHCFG				0x002c
>>   #define NXLA				0x0038
>> +#define CRLA				0x003c
>>
>>   #define DCTRL				0x0000
>>
>> @@ -684,6 +686,146 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
>>   	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
>>   }
>>
>> +static struct rz_lmdesc *
>> +rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
>> +{
>> +	struct rz_lmdesc *next = ++lmdesc;
>> +
>> +	if (next >= base + DMAC_NR_LMDESC)
>> +		next = base;
>> +
>> +	return next;
>> +}
>> +
>> +static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel)
>> +{
>> +	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
>> +	struct dma_chan *chan = &channel->vc.chan;
>> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
>> +	u32 residue = 0, crla, i = 0;
>> +
>> +	crla = rz_dmac_ch_readl(channel, CRLA, 1);
>> +	while (lmdesc->nxla != crla) {
>> +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
>> +		if (++i >= DMAC_NR_LMDESC)
>> +			return 0;
>> +	}
>> +
>> +	/* Calculate residue from next lmdesc to end of virtual desc */
>> +	while (lmdesc->chcfg & CHCFG_DEM) {
>> +		residue += lmdesc->tb;
>> +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
>> +	}
> 
> can use one loop
> 
> for (int i=0; i<DMAC_NR_LMDESC; i++) {
> 	if (lmdesc->nxla == crla)
> 		residue = 0; 	//reset to 0;
> 
> 	if (lmdesc->chcfg & CHCFG_DEM)
> 		residue += lmdesc->tb;
> 
> 	lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);

I'm not sure this will work as the descriptors list is cyclic and resetting the 
residue to zero when lmdesc->nxla == crla and then start acumulating from there 
will not work if there are descriptors enqueued for the current transfers at the 
end and the beginning of the list, e.g:

descriptors list:

| d3 | d5 | d6 | ... | d0 | d1 | d2 |

^				    ^
start			 	   end
(index 0)			(index DMAC_NR_LMDESC-1)

> }
> 
> return residue;
> 
>> +
>> +	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
>> +
>> +	return residue;
>> +}
>> +
>> +static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>> +				    dma_cookie_t cookie)
>> +{
>> +	struct rz_dmac_desc *current_desc, *desc;
>> +	enum dma_status status;
>> +	u32 crla, crtb, i;
>> +
>> +	/* Get current processing virtual descriptor */
>> +	current_desc = list_first_entry(&channel->ld_active,
>> +					struct rz_dmac_desc, node);
>> +	if (!current_desc)
>> +		return 0;
>> +
>> +	/*
>> +	 * If the cookie corresponds to a descriptor that has been completed
>> +	 * there is no residue. The same check has already been performed by the
>> +	 * caller but without holding the channel lock, so the descriptor could
>> +	 * now be complete.
>> +	 */
>> +	status = dma_cookie_status(&channel->vc.chan, cookie, NULL);
>> +	if (status == DMA_COMPLETE)
>> +		return 0;
>> +
>> +	/*
>> +	 * If the cookie doesn't correspond to the currently processing virtual
>> +	 * descriptor then the descriptor hasn't been processed yet, and the
>> +	 * residue is equal to the full descriptor size. Also, a client driver
>> +	 * is possible to call this function before rz_dmac_irq_handler_thread()
>> +	 * runs. In this case, the running descriptor will be the next
>> +	 * descriptor, and will appear in the done list. So, if the argument
>> +	 * cookie matches the done list's cookie, we can assume the residue is
>> +	 * zero.
>> +	 */
>> +	if (cookie != current_desc->vd.tx.cookie) {
>> +		list_for_each_entry(desc, &channel->ld_free, node) {
>> +			if (cookie == desc->vd.tx.cookie)
>> +				return 0;
>> +		}
>> +
>> +		list_for_each_entry(desc, &channel->ld_queue, node) {
>> +			if (cookie == desc->vd.tx.cookie)
>> +				return desc->len;
>> +		}
>> +
>> +		list_for_each_entry(desc, &channel->ld_active, node) {
>> +			if (cookie == desc->vd.tx.cookie)
>> +				return desc->len;
>> +		}
>> +
>> +		/*
>> +		 * No descriptor found for the cookie, there's thus no residue.
>> +		 * This shouldn't happen if the calling driver passes a correct
>> +		 * cookie value.
>> +		 */
>> +		WARN(1, "No descriptor for cookie!");
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * We need to read two registers. Make sure the hardware does not move
>> +	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
>> +	 * should be enough: initial read, retry, retry for the paranoid.
>> +	 */
>> +	for (i = 0; i < 3; i++) {
>> +		crla = rz_dmac_ch_readl(channel, CRLA, 1);
>> +		crtb = rz_dmac_ch_readl(channel, CRTB, 1);
>> +		/* Still the same? */
>> +		if (crla == rz_dmac_ch_readl(channel, CRLA, 1))
>> +			break;
>> +	}
>> +
>> +	WARN_ONCE(i >= 3, "residue might not be continuous!");
>> +
>> +	/*
>> +	 * Calculate number of bytes transferred in processing virtual descriptor.
>> +	 * One virtual descriptor can have many lmdesc.
>> +	 */
>> +	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel);
> 
> you don't use varible 'ctra' here, so retry 3 become useless. suppose
> rz_dmac_calculate_residue_bytes_in_vd(channel, ctra)
> 
> and avoid rz_dmac_ch_readl(channel, CRLA, 1) in
> rz_dmac_calculate_residue_bytes_in_vd() to keep ctra and ctrb reflect the
> correct hardware state.

Good point, I'll update it.

Thank you for your review,
Claudiu

