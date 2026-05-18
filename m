Return-Path: <dmaengine+bounces-10516-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG0zLXgPC2pN/gQAu9opvQ
	(envelope-from <dmaengine+bounces-10516-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 15:09:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1902256D517
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 15:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F1343062C05
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82BA47ECFE;
	Mon, 18 May 2026 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpl5pj7G"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451143CEF8;
	Mon, 18 May 2026 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109462; cv=none; b=L4muQEkkAaT0A1O38KLyUo++OIy1npaGTVccqLFLS0AjUkHlUg32XK9RzvkGuludqo6BuwGt1MciXQP9D0UliplSrj6EQSDLmf/S4aaUXP+lO9TpVty9lY98mY3LOE/D22RQeGSXJKceNQMd+eAc6xXXcOa8GoSkWkStx8I87ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109462; c=relaxed/simple;
	bh=fG+rMofuUIICNDHejS1SDH4JtmE6INN0P/Wta8HO1ok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdQ9msxbynUDGGA3Qws8Jav6RVn5ZfC7R3JaJjkGL3Zm1ufTdjwBcVxaY+4vY7muCQ+Z2raYQ7yHdonXSNUUxeBWL8g52JY9NTkUCpJyrC03jSCwSP92bJ36nQx8i2xxPSl6RKbPNPNlE8r8TPKjgU5Jf9XbAF3IZKNMWtf94qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpl5pj7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06664C2BCB7;
	Mon, 18 May 2026 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109462;
	bh=fG+rMofuUIICNDHejS1SDH4JtmE6INN0P/Wta8HO1ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fpl5pj7Gc5Oj09mXYrZGeR4Nj3r5VRe7P2F+Qx/Vyc6TK9yKcsOZGeUGX4sEtOhQI
	 MOctYssWswowGQoATdG5uX1M20aRAkFDSuPmmtcItJCGWZPKxh/2j5liB3JF+s2IUk
	 xD4feAJVy3Hl+UI7pmWyOBrOOAe258Dwxz015lpgJT/qSlhZzuQnRnVpRO5rmaSASn
	 KRGUKuNXoW2hMKQ39ZFZhOx4+QmJvACBTwui53kG0yjy3VkOLYiI9ewVNxvASG9l1D
	 KhboBy2fjmzZlUkZnM6xCCHl0/EhRiGfP7vRx4TFFwkCv06LUnLE95QTBXLXxGQy97
	 iLhdz8O03Rwpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org
In-Reply-To: <20260518-fsl-edma-dyn-sg-v4-1-8ce7d95b1ce9@bootlin.com>
References: <20260518-fsl-edma-dyn-sg-v4-1-8ce7d95b1ce9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 13:04:21 +0000
Message-Id: <20260518130422.06664C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 1902256D517
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,bootlin.com:email,smtp.kernel.org:mid];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10516-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Multiple deterministic division by zero kernel panics in burst=
 length and offset calculations.
- [High] Transfer lengths smaller than the bus width result in a 0 iteratio=
n count, causing a massive hardware memory overflow.
- [High] Incorrect memory address offsets (`soff` and `doff`) are used when=
 source and destination bus widths differ, causing overlapping memory acces=
s.
--

commit f9b345d16d721fb5194b3218cae1f0adbbad0340
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

dmaengine: fsl-edma: Implement device_prep_peripheral_dma_vec

Add implementation of .device_prep_peripheral_dma_vec() callback to setup
a scatter/gather DMA transfer from an array of dma_vec structures. Setup
a cyclic transfer if the DMA_PREP_REPEAT flag is set.

> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -673,6 +673,115 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_c=
yclic(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> =20
> +struct dma_async_tx_descriptor *
> +fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma=
_vec *vecs,
> +				 size_t nb, enum dma_transfer_direction direction,
> +				 unsigned long flags)
> +{
[ ... ]
> +	if (direction =3D=3D DMA_MEM_TO_DEV) {
> +		if (!fsl_chan->cfg.src_addr_width)
> +			fsl_chan->cfg.src_addr_width =3D fsl_chan->cfg.dst_addr_width;
> +		fsl_chan->attr =3D
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
> +		nbytes =3D fsl_chan->cfg.dst_addr_width * fsl_chan->cfg.dst_maxburst;

This regression appears to be duplicated from the existing fsl_edma_prep_sl=
ave_sg
logic.

If a client leaves dst_addr_width or src_addr_width as 0 (undefined), does
this evaluate to nbytes =3D 0?

The driver relies on fsl_edma_get_tcd_attr() to handle undefined values:

static unsigned int fsl_edma_get_tcd_attr(...)
{
    if (src_addr_width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
        src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
    ...
}

However, that function takes arguments by value and does not update the
fsl_chan->cfg structures. If nbytes evaluates to 0 here, it will lead to a
divide-by-zero panic shortly after in the modulo operation:

    if (vecs[i].len % nbytes)

> +	} else {
[ ... ]
> +	}
> +
> +	for (i =3D 0; i < nb; i++) {
> +		if (direction =3D=3D DMA_MEM_TO_DEV) {
> +			src_addr =3D vecs[i].addr;
> +			dst_addr =3D fsl_chan->dma_dev_addr;
> +			soff =3D fsl_chan->cfg.dst_addr_width;
> +			doff =3D 0;
> +		} else if (direction =3D=3D DMA_DEV_TO_MEM) {

Is it intentional that the source address offset (soff) is set to
dst_addr_width here?

For a DMA_MEM_TO_DEV transfer, memory is the source. The hardware will perf=
orm
reads sized according to src_addr_width (configured in the SSIZE attribute).
If a client configures the memory side with a 4-byte width but the peripher=
al
with a 1-byte width, the DMA engine will read 4 bytes per minor loop, but
increment the source address by only 1 byte.

Could this regression result in overlapping memory reads and corrupted data
being sent to the peripheral? (And conversely for DMA_DEV_TO_MEM where doff
is tied to src_addr_width).

> +			src_addr =3D fsl_chan->dma_dev_addr;
> +			dst_addr =3D vecs[i].addr;
> +			soff =3D 0;
> +			doff =3D fsl_chan->cfg.src_addr_width;
> +		} else {
> +			/* DMA_DEV_TO_DEV */
> +			src_addr =3D fsl_chan->cfg.src_addr;
> +			dst_addr =3D fsl_chan->cfg.dst_addr;
> +			soff =3D 0;
> +			doff =3D 0;
> +		}
> +
> +		/*
> +		 * Choose the suitable burst length if dma_vec length is not
> +		 * multiple of burst length so that the whole transfer length is
> +		 * multiple of minor loop(burst length).
> +		 */
> +		if (vecs[i].len % nbytes) {
> +			u32 width =3D (direction =3D=3D DMA_DEV_TO_MEM) ? doff : soff;

If the direction is DMA_DEV_TO_DEV, both soff and doff are explicitly set to
0 above. This means width will evaluate to 0.

If vecs[i].len is not a multiple of nbytes, the fallback loop will then
evaluate:

    if (!(vecs[i].len % (j * width)))

Will this trigger a divide-by-zero panic?

Furthermore, if the loop finishes with j =3D=3D 1, nbytes is set to width (=
0),
which leads to another divide-by-zero panic at iter =3D vecs[i].len / nbyte=
s.

> +			u32 burst =3D (direction =3D=3D DMA_DEV_TO_MEM) ?
> +						fsl_chan->cfg.src_maxburst :
> +						fsl_chan->cfg.dst_maxburst;
> +			int j;
> +
> +			for (j =3D burst; j > 1; j--) {
> +				if (!(vecs[i].len % (j * width))) {
> +					nbytes =3D j * width;
> +					break;
> +				}
> +			}
> +			/* Set burst size as 1 if there's no suitable one */
> +			if (j =3D=3D 1)
> +				nbytes =3D width;
> +		}
> +
> +		iter =3D vecs[i].len / nbytes;

If a transfer length (vecs[i].len) is smaller than the bus width, the fallb=
ack
block above sets nbytes =3D width. The integer division iter =3D vecs[i].le=
n /
nbytes will then truncate to 0.

Does writing 0 to the iteration count registers on Freescale eDMA hardware
cause the counter to decrement before checking for zero?

If so, programming the hardware's CITER and BITER registers with 0 could be
interpreted as the maximum possible iterations (e.g. 32768 or 65536). Inste=
ad
of safely rejecting the invalid sub-word transfer, could this regression
initiate a massive DMA transfer that silently accesses thousands of bytes p=
ast
the client's buffer boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-fsl-edma-d=
yn-sg-v4-0-8ce7d95b1ce9@bootlin.com?part=3D1

