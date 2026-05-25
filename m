Return-Path: <dmaengine+bounces-10848-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOOOO5EPFGpeJQcAu9opvQ
	(envelope-from <dmaengine+bounces-10848-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:00:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF915C8425
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B37F3013A90
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF037BE75;
	Mon, 25 May 2026 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSmLuHO/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038D212566
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699192; cv=none; b=A0AQE9tN67+SfiBfxi7eCueBQnPeDe5YaAHBm+++gpJwUl2dRv6wzVGJfrAAK+iGFgDqk/aZUg0zd7/ctDHcT097v5FkgkJw+pGSz0JjLrog6Iy1ucIQzk5FAIO4RmJFWsie3RC/KoUGwyYmmQCA6BQpsWo1x+1snTC3KBai3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699192; c=relaxed/simple;
	bh=HHlA0c1CeQPHKyiyHr9t+ezXFW8bpC/gH9kp21sudHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZX8GmsiItBw6wmHr03BJCLdvJQcVmQZepzoDI2pdC05KQwxFaGkqKNciFRsR7oLnm78HDvsGrd7IpWFdme9qdeb0mtXEU3UHdb/KhKDUbmCyHTrCUo1fd4SWdakkLpcZbOd6TYd9GDhlHXsuJL8Y8uxcfu5PIBQ0f+pUoqcL28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSmLuHO/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2341F000E9;
	Mon, 25 May 2026 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779699191;
	bh=kYgKGuOnACBhItzmTXfrHtqLsVuq7n/3uk3CA3Rg1vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSmLuHO/pA97NJ3MCqOiK/ePzX+wnsHSToHlYiwVekQOmOirNqCbXvWfJi/A9QQB1
	 THUBZJnTZ9eWAHpMnteX5ap9gqrM0NtAKItVyHjPyyyxE6AiOPTI/CixstlUJNrsdf
	 wnQXIXu4bpZniVt0GcpGtVswTlJutQTMnAaKxrNrrJg8PoqRreNxRu2LlRwYASwtGr
	 LEoS2ogAjh054xSl0SKL2yLGPk7DMtC5dMwvugR8NGeYqSG0ylO9eubsOD+aGOo6UH
	 yvNcN2JxvdYpdA+T0NCeicRAvpMjzFjZDuQO2QqvXDRkjX4QVJoPMuK6kFI25iaWNw
	 NLZD4xUHxe2Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dma: altera-msgdma: Use memcpy_toio for descriptor
 FIFO writes
Reply-To: sashiko-reviews@lists.linux.dev
To: tze.yee.ng@altera.com
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <f6f3b4a2e2eb0eb1a51976de3f5d1ef5bab9bd76.1779697226.git.tze.yee.ng@altera.com>
References: <f6f3b4a2e2eb0eb1a51976de3f5d1ef5bab9bd76.1779697226.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 08:53:10 +0000
Message-Id: <20260525085311.1C2341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-10848-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 0EF915C8425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The patch inadvertently duplicates the `static_assert` block for th=
e control field offset.

Pre-existing issues:
- [High] Mixed usage of `memcpy_toio()` and `iowrite32()` when writing to t=
he descriptor MMIO FIFO results in inconsistent endianness behavior on big-=
endian architectures.
- [High] `memcpy_toio()` does not guarantee the strictly sequential 32-bit =
accesses required by the hardware descriptor FIFO.
- [High] The driver polls the descriptor buffer status indefinitely using `=
mdelay()`, which can hang the system if the hardware stalls.
--

commit 077488fe5cba0a7f0c8410d69e5cb0f688e65485
Author: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

dma: altera-msgdma: Use memcpy_toio for descriptor FIFO writes

This commit replaces the forced __iomem memcpy() with memcpy_toio() for
copying descriptor bodies to the dma engine fifo. It also introduces a
static_assert to ensure the control word is the last field in the struct,
as writing the control word flushes the fifo.

> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index b46999c81df00..e23e5b441a24e 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -496,6 +496,11 @@ static void msgdma_copy_one(struct msgdma_device *md=
ev,
>  {
>  	void __iomem *hw_desc =3D mdev->desc;
> =20
> +	/* Ensure control is the last field =E2=80=94 required for correct FIFO=
 flush ordering */
> +	static_assert(offsetof(struct msgdma_extended_desc, control) =3D=3D
> +		      sizeof(struct msgdma_extended_desc) - sizeof(u32),
> +		      "control must be the last field in msgdma_extended_desc");
> +
>  	/*
>  	 * Check if the DESC FIFO it not full. If its full, we need to wait
>  	 * for at least one entry to become free again
>  	 */
>  	while (ioread32(mdev->csr + MSGDMA_CSR_STATUS) &
>  	       MSGDMA_CSR_STAT_DESC_BUF_FULL)
>  		mdelay(1);

[Severity: High]
This is a pre-existing issue, but does this loop risk a hard kernel lockup?

Since this function executes while holding a spinlock during the irq handle=
r:

msgdma_irq_handler()->msgdma_start_transfer()->msgdma_copy_one()

polling indefinitely with mdelay() without a timeout could wedge the cpu
if the hardware fails to drain the descriptor fifo. Should this use a
proper timeout loop like readl_poll_timeout_atomic() instead?

> =20
> +	/* Ensure control is the last field =E2=80=94 required for correct FIFO=
 flush ordering */
> +	static_assert(offsetof(struct msgdma_extended_desc, control) =3D=3D
> +			sizeof(struct msgdma_extended_desc) - sizeof(u32),
> +			"control must be the last field in msgdma_extended_desc");
> +

[Severity: Low]
Is this regression a copy-paste error? The exact same static_assert and
comment were also added just before the while loop in this patch.

>  	/*
> -	 * The descriptor needs to get copied into the descriptor FIFO
> -	 * of the DMA controller. The descriptor will get flushed to the
> -	 * FIFO, once the last word (control word) is written. Since we
> -	 * are not 100% sure that memcpy() writes all word in the "correct"
> -	 * order (address from low to high) on all architectures, we make
> -	 * sure this control word is written last by single coding it and
> -	 * adding some write-barriers here.
> +	 * Copy the descriptor into the descriptor FIFO of the DMA controller,
> +	 * excluding the control word. The FIFO is flushed and the descriptor
> +	 * becomes valid once the control word is written last.
>  	 */
> -	memcpy((void __force *)hw_desc, &desc->hw_desc,
> -	       sizeof(desc->hw_desc) - sizeof(u32));
> +	memcpy_toio(hw_desc, &desc->hw_desc,
> +		    offsetof(struct msgdma_extended_desc, control));

[Severity: High]
This is a pre-existing issue, but does memcpy_toio() provide the strictly
sequential 32-bit accesses required by the hardware fifo?=20

Since memcpy_toio() is architecture-dependent and may internally use byte
writes, 64-bit writes, or copy in a non-sequential order, would an explicit
loop using a consistent 32-bit accessor like writesl() guarantee the
required access pattern instead?

[Severity: High]
This is a pre-existing issue, but does mixing memcpy_toio() and iowrite32()
cause data corruption on big-endian architectures?

Since memcpy_toio() preserves host byte order while iowrite32() (called
subsequently to write the control word) performs cpu-to-le byte-swapping on
big-endian systems, the descriptor body will be written in big-endian memory
order while the control word will be swapped to little-endian.

Does this require a consistent stream-oriented accessor family for both the
bulk copy and the remainder?

> =20
>  	/* Write control word last to flush this descriptor into the FIFO */
>  	mdev->idle =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f6f3b4a2e2eb0eb1a51=
976de3f5d1ef5bab9bd76.1779697226.git.tze.yee.ng@altera.com?part=3D1

