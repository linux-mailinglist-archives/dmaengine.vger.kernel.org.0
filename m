Return-Path: <dmaengine+bounces-10458-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMqmK+soBWo4TAIAu9opvQ
	(envelope-from <dmaengine+bounces-10458-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 03:44:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F7F53CD29
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 03:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32232301CCD4
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 01:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4563274FD1;
	Thu, 14 May 2026 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUqxqXB8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915EF199FAB
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723026; cv=none; b=W+pOWuE2EeLbT0ELFHBmaEeCb64hu3X3j5/udM7VDTNyb7FohoWihkGN+iK35KEZ8QNocFf49A5oLwRM+XQ1jqwzqQi0a5TbZegO7h6W1edUefIQ1I6A/MZsfpInkCZ6k5NUVD/DQfXaKdDkVMzS1Cul3+yBmq+7Oh+3YcVj+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723026; c=relaxed/simple;
	bh=hRU6foWseyCJYmwU7KmjNQ+zE47i0+5iWWJweKmSkJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=udFbuzgsSmoadtIuYkHMWmHgiRirr1QXvNdNRr36RWztqiJHup+h7fL4ZkFWZiAXSzYdwy2OhCoSyM078V9w5BmPFl+bHhGHgbsKju8zhBpBGjfLQgFPiBYo9iOnfsgwzctbA/Gz2vHzTbk35x+LEaqJBxxdnn68b1J1By1fH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUqxqXB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE101C19425;
	Thu, 14 May 2026 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723026;
	bh=hRU6foWseyCJYmwU7KmjNQ+zE47i0+5iWWJweKmSkJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AUqxqXB81p0qVv5h+bJXx42ReYgpAn3cU0T8enZQ1cTl8uvGuJwSoHLH7xLQurL9D
	 LWMLpVePEvesb/Sp+QJ+tXIgEjBl/1DL8jUYIjzpmNsh9eGwPXI7uhALxivArmnAr3
	 eW32HWIaau7A7vY6vU6O2fYVI/qKIy1+3OVX+cE6gWRZ9YSUME7zzgaES3ic+MIMPM
	 hn8KLHB8uovlxbTGt2l9k41MH16gw6Yz1imk10iXGMSFgTPDp0x4JlWgkDkq+iqA9v
	 Fif+DT+O5R9FaaNJegel6Ftu4LPdh33xVY/VlfZQaFROrVR8/r3XV3HqGbvnMeLTnf
	 7cTqUonCA8OGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/17] dmaengine: sh: rz-dmac: Add cyclic DMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, vkoul@kernel.org
In-Reply-To: <20260512121219.216159-13-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-13-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:43:45 +0000
Message-Id: <20260514014345.DE101C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 12F7F53CD29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10458-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Modifying global channel state during cyclic descriptor preparatio=
n causes race conditions and state corruption.
- [High] Cyclic residue calculation omits the last descriptor, resulting in=
 under-reported residue.
- [High] Stale hardware configuration fields leak from previous transfers i=
nto cyclic transfers.
--

commit 206116040d966fa7859b2dc81e454bdbed7acd43
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

    dmaengine: sh: rz-dmac: Add cyclic DMA support

This commit adds cyclic DMA support to the RZ DMAC driver. A per-channel
status bit is introduced to mark cyclic channels and is set during the DMA
prepare callback.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 2de519b581b60..d6ad070be705c 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c

[ ... ]

> @@ -431,6 +435,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struc=
t rz_dmac_chan *channel)
>  	channel->chctrl =3D 0;
>  }
> =20
> +static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channe=
l)
> +{
> +	struct dma_chan *chan =3D &channel->vc.chan;
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	struct rz_dmac_desc *d =3D channel->desc;
> +	size_t period_len =3D d->sgcount;
> +	struct rz_lmdesc *lmdesc;
> +	size_t buf_len =3D d->len;
> +	size_t periods =3D buf_len / period_len;
> +
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	channel->chcfg |=3D CHCFG_SEL(channel->index) | CHCFG_DMS;

Are stale hardware configuration fields leaking from previous transfers her=
e?

If a channel was previously used for a memory-to-memory transfer,
channel->chctrl might retain the CHCTRL_STG (Software Trigger Generation) b=
it.
If it was used for slave_sg, channel->chcfg might retain the CHCFG_DEM
(Descriptor End Mask) bit.

Because channel->chcfg is modified via OR-assignment and channel->chctrl
is not initialized to 0, could the stale CHCTRL_STG bit cause the peripheral
transfer to continuously trigger via software rather than synchronizing with
the hardware DREQ signal? Additionally, could a stale CHCFG_DEM bit mask
every period interrupt and prevent vchan_cyclic_callback() from being invok=
ed?

[ ... ]

> @@ -586,6 +645,55 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct =
scatterlist *sgl,
>  	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
>  }
> =20
> +static struct dma_async_tx_descriptor *
> +rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> +			size_t buf_len, size_t period_len,
> +			enum dma_transfer_direction direction,
> +			unsigned long flags)
> +{
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_dmac_desc *desc;
> +	size_t periods;
> +
> +	if (!is_slave_direction(direction))
> +		return NULL;
> +
> +	if (!period_len || !buf_len)
> +		return NULL;
> +
> +	periods =3D buf_len / period_len;
> +	if (!periods || periods > DMAC_NR_LMDESC)
> +		return NULL;
> +
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
> +			return NULL;
> +
> +		desc =3D list_first_entry_or_null(&channel->ld_free, struct rz_dmac_de=
sc, node);
> +		if (!desc)
> +			return NULL;
> +
> +		list_del(&desc->node);
> +
> +		channel->status |=3D BIT(RZ_DMAC_CHAN_STATUS_CYCLIC);

Can this global channel state modification during descriptor preparation ca=
use
race conditions?

The DMA engine API permits descriptors to be prepared concurrently with act=
ive
transfers, or to be freed without being issued. If a slave_sg transfer is
running when prep_dma_cyclic() is called, the global channel status immedia=
tely
becomes CYCLIC.

When the active slave_sg transfer triggers an interrupt, wouldn't
rz_dmac_irq_handler_thread() see this flag and incorrectly execute the cycl=
ic
path (vchan_cyclic_callback) instead of vchan_cookie_complete()?

Would it be safer to determine the execution mode by checking the currently
active descriptor's type (e.g., desc->type =3D=3D RZ_DMAC_DESC_CYCLIC) inst=
ead of
updating a global channel flag during preparation?

[ ... ]

> @@ -733,9 +841,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(str=
uct rz_dmac_chan *channel,
>  	}
> =20
>  	/* Calculate residue from next lmdesc to end of virtual desc */
> -	while (lmdesc->chcfg & CHCFG_DEM) {
> -		residue +=3D lmdesc->tb;
> -		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
> +		u32 start_lmdesc_addr =3D rz_dmac_lmdesc_addr(channel, desc->start_lmd=
esc);
> +
> +		while (lmdesc->nxla !=3D start_lmdesc_addr) {

Does this omit the residue from the last descriptor in the cyclic ring?

The last descriptor is configured such that its nxla field points to
start_lmdesc_addr in order to loop back. Because the loop condition evaluat=
es
to false exactly when lmdesc reaches this last descriptor, it terminates
before adding lmdesc->tb (the transfer byte count) to the residue.

Could this cause the residue to be permanently under-reported by one full
period length, affecting subsystems like ALSA that rely on strict monotonic
residue reporting?

> +			residue +=3D lmdesc->tb;
> +			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		}
> +	} else {
> +		while (lmdesc->chcfg & CHCFG_DEM) {
> +			residue +=3D lmdesc->tb;
> +			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D12

