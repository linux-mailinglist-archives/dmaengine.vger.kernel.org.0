Return-Path: <dmaengine+bounces-10922-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCxgJtxnFWqtUwcAu9opvQ
	(envelope-from <dmaengine+bounces-10922-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:29:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A45D3541
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1481C300E029
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779F3D6CAB;
	Tue, 26 May 2026 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy0XG4bL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E743AA1A1
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787733; cv=none; b=GW/K56toOFkHf1dnd0oB3KH4FghoVssFBGzMa0E7OmdDlTUdTlGF5e2wYO+5ydRmMhOyrNiYjZeONcWOKsgyh+0pEsLkLIoeO7nSOR0Vy2pH2X7hME01EglkNlKv34kuLd9HfqhlqliTOBnxMB7otUh5c7q86IjzUS2/0DhI/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787733; c=relaxed/simple;
	bh=DfXlOyqPeNN+b2k2O/nBUNTwpwM7uI1tQFfpNA0fAlI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lI38aIeKyCs3z8QvVunUoxel/gaMxntDF5HUZjaT2G7fupfjqzD8Z5rZkwVCCqFT4cvjbc2VoHTZXnIBbbqLD8vCGE7+iUWpEi70fybeETEeYqs+goqC/vcBJEiv+nneuDsm+0DpibCaUr0I4A+qfnoB/KqaKWgiSgn0MxLZGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy0XG4bL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49EE1F000E9;
	Tue, 26 May 2026 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779787732;
	bh=VgCNaq20wKQr/TVe4jWVcdRVh5f2DYcZUyaeAHSnhm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hy0XG4bL7BYcp1PIBB0NQn8WW5iu2nnrhMlxicIrhUr0c33144hZiCoASoeDe5Sop
	 QfaNKxEg6Z9gMGoSKTrvknDIBqChsQeRXnwBhssRFI0o90AcPEJrM/UWZDimH+JF7D
	 FR5Er1CpWVgXad5zu8VJ0fhgYUzix1J+To5iAKwVTQ+k743qHyfQhBWtd9vJ+feNVt
	 tcSVmCDFFzotHo9yto3XinnXoAbYIHKiX3qWe5qp4moxzRjRaWPHVJaAKTO6jf5oyV
	 mb+R8lpgA1pg85othV1lF4/HB1BYw+a6K83h6f8jjGmUeY11rf80SdSt6hTHCmkSPx
	 tlOkd++g7TS9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/18] dmaengine: sh: rz-dmac: Use virt-dma APIs for
 channel descriptor processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, vkoul@kernel.org
In-Reply-To: <20260526084710.3491480-10-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-10-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:28:51 +0000
Message-Id: <20260526092851.A49EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid,renesas.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10922-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 371A45D3541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing cleanup of the active descriptor (`channel->desc`) in `rz_=
dmac_free_chan_resources` causes permanent memory leaks and channel breakag=
e.
- [High] Premature tasklet synchronization in `rz_dmac_device_synchronize` =
violates DMA synchronization guarantees by allowing callbacks to execute af=
ter the function returns.
--

commit d09437d0a9b5a01f2fe83f477e60abbcf577d287
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor processing

This commit updates the driver to fully rely on the virt-dma APIs for
descriptor management. It replaces custom active and queue lists with a
single channel->desc pointer to track the current descriptor and relies
on virt-dma to handle the rest.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 217657513fa76..1f884ec101f80 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c

[ ... ]

> @@ -494,8 +485,6 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
an *chan)
>  	rz_lmdesc_setup(channel, channel->lmdesc.base);
> =20
>  	rz_dmac_disable_hw(channel);
> -	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> -	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
> =20
>  	if (channel->mid_rid >=3D 0) {
>  		clear_bit(channel->mid_rid, dmac->modules);
> @@ -504,13 +493,19 @@ static void rz_dmac_free_chan_resources(struct dma_=
chan *chan)
> =20
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);
> =20
> +	vchan_free_chan_resources(&channel->vc);
> +
> +	spin_lock_irqsave(&channel->vc.lock, flags);
> +
>  	list_for_each_entry_safe(desc, _desc, &channel->ld_free, node) {
> +		list_del(&desc->node);
>  		kfree(desc);
>  		channel->descs_allocated--;
>  	}
> =20
>  	INIT_LIST_HEAD(&channel->ld_free);
> -	vchan_free_chan_resources(&channel->vc);
> +
> +	spin_unlock_irqrestore(&channel->vc.lock, flags);
>  }

[Severity: High]
Does this code leak the active descriptor? If channel->desc is currently se=
t,
vchan_free_chan_resources only clears virt-dma's internal lists, leaving
the memory allocated for channel->desc dangling.

Could this also cause the channel to be permanently broken for future clien=
ts?

If channel->desc remains non-NULL, a subsequent request for the channel
might cause rz_dmac_issue_pending to see channel->desc !=3D NULL and
silently refuse to start new transfers. Unlike rz_dmac_terminate_all,
this function does not appear to terminate and clear channel->desc.

[ ... ]

> @@ -692,6 +681,8 @@ static void rz_dmac_device_synchronize(struct dma_cha=
n *chan)
>  	u32 chstat;
>  	int ret;
> =20
> +	vchan_synchronize(&channel->vc);
> +
>  	ret =3D read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_E=
N),
>  				100, 100000, false, channel, CHSTAT, 1);
>  	if (ret < 0)

[Severity: High]
Does calling vchan_synchronize here allow client completion callbacks to
run after this function returns?

If the hardware is still actively transferring, vchan_synchronize will
return immediately. Then, the polling loop waits for the hardware to stop.
Once the hardware finishes, it raises an interrupt, and the IRQ handler
calls vchan_cookie_complete, which schedules the virt-dma tasklet again.

This seems like it could expose clients to use-after-free bugs if they rely
on the DMA synchronization guarantee to safely free DMA buffers after
calling dmaengine_synchronize.=20

Should vchan_synchronize be called after the hardware polling loop finishes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D9

