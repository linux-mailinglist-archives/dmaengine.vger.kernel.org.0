Return-Path: <dmaengine+bounces-11683-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2WfMLW/8NmqFHQcAu9opvQ
	(envelope-from <dmaengine+bounces-11683-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:47:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F01C6A9B88
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:47:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iniOQ94a;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11683-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11683-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E1E301348D
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 20:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD84346E7E;
	Sat, 20 Jun 2026 20:47:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630111FBEBC
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 20:47:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781988460; cv=none; b=eO8AmJkqEUJUWefaiAGgJjTsEPBvPsnTBR5800pFujehf8HLY62Co/n/0S/FkQBRgXdJgpMeX6Bv/q/GG3KGECl5wZFBJLJ75enTBa/l+G0ew7DLreV9QHFgarXIlVlMKXCDKDCW5j1dOosktSOMGQsBiVSXpARK6rRXGVJYUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781988460; c=relaxed/simple;
	bh=4Fcqs4wVBBnLiGIla7alIA5DOoIIyslnZOS/afNPCK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LvrcVzWxmkDj+j1qZE7aq2HZXHFhDryMc6xgTf9nX/KSeNfGnSiFiXMAYx6I5T4X1W76aK5XjRlxB13HYKD2K0HftXViwl9byCT2sianhWonB53NYNyeMyASN0dlw+UX9Qvt5qI8SJ1M322tt3G/ufsYQ4MYrJsZ0Z9fIBVaWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iniOQ94a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BBA1F00A3A;
	Sat, 20 Jun 2026 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781988459;
	bh=w9tGeLqUPX1nri8TSjyc7zuv3YTDzgn9x/ECymKvNCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iniOQ94ai2K0NyKDnj5rm7++0RQqMi9amI9AWctx2ehtoIN2uUq91SZE0L0mdnpR8
	 4Pc2889Prg8xzGcmTKIx4LNuT6yKahwLxzvE0xpwZ26jSg5PlIrrGTSOydv3PPgpjZ
	 lu6whnd8pLbXIuKgCST7wB9B99URrw+aCF1XHdxMMYoQy0UW+CruxMqa0epRhaoP/U
	 YLI75mn9ts3b1X/myRTxO2EBYR2bnLOK3u67GmCIGz2BocRa+92qIN045Msh1W5iUE
	 075JnGHYgLPSuXaBdSXwF/jxasqbFV8IMtfv20pKZhhJJp1FQILveb9/fzyMk8ZlMe
	 czyiLxrmAzdGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 1/3] dmaengine: xilinx_dma: Fix channel idle
 state management in AXIDMA and MCDMA interrupt handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suraj Gupta" <suraj.gupta2@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260620203417.4000360-2-suraj.gupta2@amd.com>
References: <20260620203417.4000360-1-suraj.gupta2@amd.com>
 <20260620203417.4000360-2-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 20:47:38 +0000
Message-Id: <20260620204738.F1BBA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11683-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F01C6A9B88

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch's intended fix is completely ineffective for MCDMA a=
nd CDMA channels due to a pre-existing bug where descriptors are unconditio=
nally completed without checking hardware status.
- [High] Cyclic DMA completion callbacks are permanently starved and will n=
ever be executed because the cyclic descriptor is moved out of `done_list` =
before the cleanup tasklet runs.
- [High] The MCDMA IRQ handler fails to process descriptor completions when=
 a delay interrupt occurs, leading to indefinite stalls.
--


commit bb06990d374374bf16e72c807c81d0d1449ff514
Author: Suraj Gupta <suraj.gupta2@amd.com>

dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDM=
A interrupt handlers

Fix a race condition in AXIDMA and MCDMA irq handlers where the channel
could be incorrectly marked as idle and attempt spurious transfers when
descriptors are still being processed.

> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 404235c173538..ca396b7097427 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1893,8 +1893,10 @@ static irqreturn_t xilinx_mcdma_irq_handler(int ir=
q, void *data)
>  	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
>  		spin_lock(&chan->lock);
>  		xilinx_dma_complete_descriptor(chan);
> -		chan->idle =3D true;
> -		chan->start_transfer(chan);
> +		if (list_empty(&chan->active_list)) {
> +			chan->idle =3D true;
> +			chan->start_transfer(chan);
> +		}

[Severity: Critical]
This is a pre-existing issue, but does this list_empty() check actually
prevent the race condition for MCDMA channels?

Looking at drivers/dma/xilinx/xilinx_dma.c in xilinx_dma_complete_descripto=
r(),
hardware completion status is only validated for AXIDMA:

xilinx_dma_complete_descriptor() {
	...
	if (chan->xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
		struct xilinx_axidma_tx_segment *seg;

		seg =3D list_last_entry(&desc->segments,
				      struct xilinx_axidma_tx_segment, node);
		if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
			break;
	}
	...
}

For MCDMA and CDMA channels, descriptors are unconditionally unlinked and
moved to done_list. This means active_list is always emptied by
xilinx_dma_complete_descriptor(), causing list_empty(&chan->active_list)
to always evaluate to true.

Doesn't this make the patch's fix ineffective for MCDMA, while also risking
data corruption since clients might reuse memory before the hardware actual=
ly
completes the transfer?


[Severity: High]
This is a pre-existing issue, but does the MCDMA IRQ handler properly proce=
ss
descriptor completions when a delay interrupt occurs?

Unlike the AXIDMA handler which checks both FRM_CNT_IRQ and DLY_CNT_IRQ,
if a delay interrupt fires for MCDMA in drivers/dma/xilinx/xilinx_dma.c,
the handler only logs a message:

xilinx_mcdma_irq_handler() {
	...
	if (status & XILINX_MCDMA_IRQ_DELAY_MASK) {
		/*
		 * Device takes too long to do the transfer when user requires
		 * responsiveness.
		 */
		dev_dbg(chan->dev, "Inter-packet latency too long\n");
	}
	...
}

If a delay interrupt occurs without an accompanying IOC interrupt, which
happens when the transferred count hasn't reached the coalesce threshold but
the timer expires, descriptor completions are never processed.

Could this lead to indefinite stalls for the DMA client since the channel
becomes unresponsive?

>  		spin_unlock(&chan->lock);
>  	}
> =20
> @@ -1950,8 +1952,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq,=
 void *data)
>  		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
>  		spin_lock(&chan->lock);
>  		xilinx_dma_complete_descriptor(chan);
> -		chan->idle =3D true;
> -		chan->start_transfer(chan);
> +		if (list_empty(&chan->active_list)) {
> +			chan->idle =3D true;
> +			chan->start_transfer(chan);
> +		}

[Severity: High]
This is a pre-existing issue, but will cyclic DMA completion callbacks ever
be executed since start_transfer() is called here?

When a cyclic transfer completes, xilinx_dma_complete_descriptor() moves
the cyclic descriptor from active_list to done_list. When start_transfer()
is invoked immediately after, it preemptively moves the descriptor back into
active_list because pending_list is empty in cyclic mode:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_start_transfer() {
	...
	list_splice_tail_init(&chan->done_list, &chan->active_list);
	...
}

After the IRQ handler returns, the cleanup tasklet executes to iterate over
done_list and trigger the callback:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_chan_desc_cleanup() {
	...
	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
		struct dmaengine_result result;

		if (desc->cyclic) {
			xilinx_dma_chan_handle_cyclic(chan, desc, &flags);
	...
}

Because done_list was already completely emptied by start_transfer(), won't
this loop be bypassed entirely, causing the cyclic notification mechanism
to fail and clients to stall?

>  		spin_unlock(&chan->lock);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620203417.4000=
360-1-suraj.gupta2@amd.com?part=3D1

