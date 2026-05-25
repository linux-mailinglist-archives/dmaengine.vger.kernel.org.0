Return-Path: <dmaengine+bounces-10839-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OK0Akb6E2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10839-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:29:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A97055C7229
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BC5D30010F1
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C23D25DC;
	Mon, 25 May 2026 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHYV1lG9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36913D3007;
	Mon, 25 May 2026 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694146; cv=none; b=Cs9qyUKPyYPD+Hq/8gN1vRYgjNUCBnEaiSkgW4L7hFAQ7GVBiOgEYA7E8Xj9BP34fSRcbP95dTwYF6eW/bYMYNI6kNUz43cnFnGPF3+TkrvdKVcDydIdwsRZdcL51Y9AlKOfL6+h4adBHT1TFL5gKbe6iRMya+t9Hp5ZkIfPh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694146; c=relaxed/simple;
	bh=FtBud6StqVU0PEtORZ6r+B/Ovm9bljKtIQhEPDRhdR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjLvNSFGpGcrQoCpcklx631ElXe+eYXVYA/JYReZjirEYozj7zt1GnV+7sL9n7iRwgh2TM2ctx1Fjl1Dv5zSQb36XAoeSJ9ePth7Ma2dxA2S69m4lvznv3IXAnpCLByQDo43w6JXGwKy62p7lBlrCR9Lq3jM8C8iQgZdx01fQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHYV1lG9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A56D1F000E9;
	Mon, 25 May 2026 07:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779694143;
	bh=Px70UtyVdgOoJSvAo0JvpWSmr8DieerexvZusmbqnMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MHYV1lG9qMNGmv0kQ+kCcow2yah7RZoKW4ICXp6+vID7dY+LMv8eNR/rADWVKtc6W
	 CFIUhojoEejGnyO0MK8cgvCJnRgqiuiWAZ54xyFHvDIEG+qraB81zU8Xyi0My6Pqzp
	 QQJ/q8HWLrTpY8DF4Il1ngzqSnYQV/nJdGyMxhIVFGBKBwKij4WJnhg8aBBEfgMwuI
	 X6LgzkRZbwWseRAsxnxCTlBuoroVfQauWQ+nZCTxOzjtUD+MVV0/jMZZdzcullblMY
	 N7c3JAXX9GvjEvcQRmjhtvLSMZ1i8xyfPfx8cVVIPp0cLHLCgHOFOeLrNieHlZ9Jlv
	 EQi7KG8lj6Psg==
Message-ID: <f559ed50-6cde-415f-a9c2-a73387d67ebd@kernel.org>
Date: Mon, 25 May 2026 10:28:57 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: sashiko review (Re: [PATCH v5 12/17] dmaengine: sh: rz-dmac: Add
 cyclic DMA support)
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, fabrizio.castro.jz@renesas.com,
 kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-13-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260512121219.216159-13-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10839-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,renesas.com:email]
X-Rspamd-Queue-Id: A97055C7229
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 >commit 206116040d966fa7859b2dc81e454bdbed7acd43
 >Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 >    dmaengine: sh: rz-dmac: Add cyclic DMA support
 >This commit adds cyclic DMA support to the RZ DMAC driver. A per-channel
 >status bit is introduced to mark cyclic channels and is set during the DMA
 >prepare callback.
 >> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
 >> index 2de519b581b60..d6ad070be705c 100644
 >> --- a/drivers/dma/sh/rz-dmac.c
 >> +++ b/drivers/dma/sh/rz-dmac.c
 >[ ... ]
 >> @@ -431,6 +435,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct 
rz_dmac_chan *channel)
 >>      channel->chctrl = 0;
 >>  }
 >>
 >> +static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
 >> +{
 >> +    struct dma_chan *chan = &channel->vc.chan;
 >> +    struct rz_dmac *dmac = to_rz_dmac(chan->device);
 >> +    struct rz_dmac_desc *d = channel->desc;
 >> +    size_t period_len = d->sgcount;
 >> +    struct rz_lmdesc *lmdesc;
 >> +    size_t buf_len = d->len;
 >> +    size_t periods = buf_len / period_len;
 >> +
 >> +    lockdep_assert_held(&channel->vc.lock);
 >> +
 >> +    channel->chcfg |= CHCFG_SEL(channel->index) | CHCFG_DMS;
 >Are stale hardware configuration fields leaking from previous transfers here?
 >If a channel was previously used for a memory-to-memory transfer,
 >channel->chctrl might retain the CHCTRL_STG (Software Trigger Generation) bit.
 >If it was used for slave_sg, channel->chcfg might retain the CHCFG_DEM
 >(Descriptor End Mask) bit.
 >Because channel->chcfg is modified via OR-assignment and channel->chctrl
 >is not initialized to 0, could the stale CHCTRL_STG bit cause the peripheral
 >transfer to continuously trigger via software rather than synchronizing with
 >the hardware DREQ signal? Additionally, could a stale CHCFG_DEM bit mask
 >every period interrupt and prevent vchan_cyclic_callback() from being invoked?

It is expected the channel to be released before changing its mode (cyclic, sg, 
mem-to-mem) and requested again. When the channel is requested the 
channel->chcfg is properly reinitialized in rz_dmac_chan_filter() with the 
device tree data.

 >[ ... ]
 >> @@ -586,6 +645,55 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct 
scatterlist *sgl,
 >>      return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 >>  }
 >>
 >> +static struct dma_async_tx_descriptor *
 >> +rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 >> +                    size_t buf_len, size_t period_len,
 >> +                    enum dma_transfer_direction direction,
 >> +                    unsigned long flags)
 >> +{
 >> +    struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 >> +    struct rz_dmac_desc *desc;
 >> +    size_t periods;
 >> +
 >> +    if (!is_slave_direction(direction))
 >> +            return NULL;
 >> +
 >> +    if (!period_len || !buf_len)
 >> +            return NULL;
 >> +
 >> +    periods = buf_len / period_len;
 >> +    if (!periods || periods > DMAC_NR_LMDESC)
 >> +            return NULL;
 >> +
 >> +    scoped_guard(spinlock_irqsave, &channel->vc.lock) {
 >> +            if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
 >> +                    return NULL;
 >> +
 >> +            desc = list_first_entry_or_null(&channel->ld_free, struct 
rz_dmac_desc, node);
 >> +            if (!desc)
 >> +                    return NULL;
 >> +
 >> +            list_del(&desc->node);
 >> +
 >> +            channel->status |= BIT(RZ_DMAC_CHAN_STATUS_CYCLIC);
 >Can this global channel state modification during descriptor preparation cause
 >race conditions?
 >The DMA engine API permits descriptors to be prepared concurrently with active
 >transfers, or to be freed without being issued. If a slave_sg transfer is
 >running when prep_dma_cyclic() is called, the global channel status immediately
 >becomes CYCLIC.
 >When the active slave_sg transfer triggers an interrupt, wouldn't
 >rz_dmac_irq_handler_thread() see this flag and incorrectly execute the cyclic
 >path (vchan_cyclic_callback) instead of vchan_cookie_complete()?
 >Would it be safer to determine the execution mode by checking the currently
 >active descriptor's type (e.g., desc->type == RZ_DMAC_DESC_CYCLIC) instead of
 >updating a global channel flag during preparation?

Once a channel has been configured as cyclic channel it can be used only as 
cyclic channel. HW don't allow changing its usage like mentioned above.

 >[ ... ]
 >> @@ -733,9 +841,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct 
rz_dmac_chan *channel,
 >>      }
 >>
 >>      /* Calculate residue from next lmdesc to end of virtual desc */
 >> -    while (lmdesc->chcfg & CHCFG_DEM) {
 >> -            residue += lmdesc->tb;
 >> -            lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
 >> +    if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
 >> +            u32 start_lmdesc_addr = rz_dmac_lmdesc_addr(channel, 
desc->start_lmdesc);
 >> +
 >> +            while (lmdesc->nxla != start_lmdesc_addr) {
 >Does this omit the residue from the last descriptor in the cyclic ring?
 >The last descriptor is configured such that its nxla field points to
 >start_lmdesc_addr in order to loop back. Because the loop condition evaluates
 >to false exactly when lmdesc reaches this last descriptor, it terminates
 >before adding lmdesc->tb (the transfer byte count) to the residue.
 >Could this cause the residue to be permanently under-reported by one full
 >period length, affecting subsystems like ALSA that rely on strict monotonic
 >residue reporting?

I did a lot of audio testing with this code and never encountered issues with 
the current form of this code.

 >> +                    residue += lmdesc->tb;
 >> +                    lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, 
lmdesc);
 >> +            }
 >> +    } else {
 >> +            while (lmdesc->chcfg & CHCFG_DEM) {
 >> +                    residue += lmdesc->tb;
 >> +                    lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, 
lmdesc);
 >> +            }
 >>      }

