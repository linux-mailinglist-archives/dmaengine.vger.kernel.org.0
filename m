Return-Path: <dmaengine+bounces-10525-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CL5DDoQDGoZVQUAu9opvQ
	(envelope-from <dmaengine+bounces-10525-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 09:24:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415B9578FDB
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6011D305C956
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40F3D090E;
	Tue, 19 May 2026 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEVcD5r6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D93CF042
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175096; cv=none; b=cGTjOpP4xOb+Rph/pjGqn4P4J/j+Lim/ugTnN3sG6PAcgc6Dj/cj+4hQYEkYLcb4zlLfSD3C1DnRrEGhDcNJEVh9kO07uvqf2JigfCPqAUxxkaxKbUKMUKa72MDCp8Nu6fb2wkjxE3BQgQZ5b5oH/DC1h0ZB2lzkj4RNc2QavC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175096; c=relaxed/simple;
	bh=NXfQyjSa8/XG4PHYnjXFo12TwzRr3wd8DLMGw/d8n7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X6Qy8JWpfc4huwIkXVNQBoPCai5r0arnfKC3m0+wPWiFdNPTqlC8nafCEyjLj1312pKNCZPmGfXu2ohA+MdXyCllpRM1caAg/KJkYgNcLfXgIX4RIoNKmDG8olBOWXL7Rsqf5DRiWxCrrZvYwqrmb256RcC+z5zM/DV4yfIpXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEVcD5r6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC443C2BCC6;
	Tue, 19 May 2026 07:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779175096;
	bh=NXfQyjSa8/XG4PHYnjXFo12TwzRr3wd8DLMGw/d8n7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZEVcD5r6hpB21NJerWuU5GbVTPTG9SXT16k9aeWctEc8x1Pd2xLoFppf27xGRMTlG
	 SiEJ9J6Qr5LCg5tr63TMRpMURW+thobti4gs5SzEOpVsGehHMghypFoiQ7IEZMWzSj
	 yqXAWaqA6O+5bAfrJS8/LlSfBd38eVNjI5WjsL5sx3vuJbIgivyPCrLX+H35ZEzsk0
	 FBczunyQZ5maquMDgkSnRuGArgvKYHW4r4B0kegtRsHOtfp3YwBtMZXthrjS4UwL2y
	 2HLYNz8sUZ+gvSj40NU5l2vVFrVTSEcaJOFlDUrLCQRLKwWBPwDfNbuSdvWTaUwAGT
	 ac7Bv1a5jLsPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma: altera-msgdma: Replace memcpy with io32write in
 msgdma_copy_one
Reply-To: sashiko-reviews@lists.linux.dev
To: tze.yee.ng@altera.com
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <4586c39b43aa3b9480989940fe905dac40c8cefc.1779173156.git.tze.yee.ng@altera.com>
References: <4586c39b43aa3b9480989940fe905dac40c8cefc.1779173156.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 07:18:15 +0000
Message-Id: <20260519071815.EC443C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10525-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,altera.com:email,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: 415B9578FDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unbounded busy-waiting with mdelay(1) inside a hard IRQ handler ca=
uses severe latency spikes and hard lockups. (Pre-existing issue)
- [High] Clearing the interrupt status after starting a new transfer create=
s a race condition leading to lost interrupts and a hung DMA pipeline. (Pre=
-existing issue)
- [Medium] The patch introduces excessive heavy memory barriers on the DMA =
fast path by using iowrite32() in a loop.
--

commit 64f4d2469744b57d2ca64e78f8cef229de2c5eae
Author: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

dma: altera-msgdma: Replace memcpy with io32write in msgdma_copy_one

This commit replaces memcpy() with an explicit iowrite32() loop when
writing descriptors into the DMA controller's FIFO. This ensures that
MMIO writes are not reordered by the compiler or architecture, guaranteeing
that the control word is always written last.

> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index b46999c81df00..5816973d2c70a 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -495,6 +495,9 @@ static void msgdma_copy_one(struct msgdma_device *mde=
v,
>  			    struct msgdma_sw_desc *desc)
>  {
>  	void __iomem *hw_desc =3D mdev->desc;
> +	const u32 *src =3D (const u32 *)&desc->hw_desc;
> +	unsigned int i, nwords =3D offsetof(struct msgdma_extended_desc, contro=
l) /
> +				 sizeof(u32);
> =20
>  	/*
>  	 * Check if the DESC FIFO it not full. If its full, we need to wait
> @@ -505,16 +508,16 @@ static void msgdma_copy_one(struct msgdma_device *m=
dev,
>  		mdelay(1);

This isn't a regression from this patch, but can this unbounded busy-wait
inside a hard IRQ handler cause severe latency spikes and hard lockups?

If a large scatter-gather list is submitted that exceeds the hardware FIFO
size, msgdma_start_transfer() will attempt to push all of them at once.
The CPU will spin in mdelay(1) for each subsequent descriptor while the DMA
engine processes the transfers.

Waiting for hundreds of milliseconds with IRQs disabled could trigger a ker=
nel
hard lockup watchdog panic. Furthermore, if the hardware stalls due to a bus
error, the CPU will spin forever.

Would it be possible to implement a proper timeout mechanism and software
queuing here instead?

[ ... ]

> -	 * The descriptor needs to get copied into the descriptor FIFO
> -	 * of the DMA controller. The descriptor will get flushed to the
> -	 * FIFO, once the last word (control word) is written. Since we
> -	 * are not 100% sure that memcpy() writes all word in the "correct"
> -	 * order (address from low to high) on all architectures, we make
> -	 * sure this control word is written last by single coding it and
> -	 * adding some write-barriers here.
> +	 * The descriptor must be written into the descriptor FIFO of the DMA
> +	 * controller. The FIFO is flushed and the descriptor becomes valid once
> +	 * the last word (the control word) is written. To guarantee the orderi=
ng
> +	 * of MMIO writes across all architectures, we write each 32-bit word
> +	 * individually using iowrite32(), and handle the control word separate=
ly
> +	 * at the end. This ensures the control word is always written last and
> +	 * prevents memcpy() or the compiler from reordering accesses.
>  	 */
> -	memcpy((void __force *)hw_desc, &desc->hw_desc,
> -	       sizeof(desc->hw_desc) - sizeof(u32));
> +	for (i =3D 0; i < nwords; i++)
> +		iowrite32(src[i], hw_desc + i * sizeof(u32));

Does this introduce excessive heavy memory barriers on the DMA fast path?

The iowrite32() macro maps to writel(), which includes an implicit heavy
memory barrier before the write to ensure memory accesses are visible to the
device.

Executing this barrier in a tight loop for every word of the DMA descriptor
could significantly degrade performance on the submission hot path.

Since the hardware merely requires the descriptor words to be written
sequentially before writing the final control word, could writel_relaxed()
be used instead to avoid the per-word barrier overhead? An explicit wmb()
is already present before the final control word write to ensure correct
ordering.

This isn't a regression from this patch, but could clearing the interrupt
status after starting a new transfer create a race condition leading to
lost interrupts and a hung DMA pipeline?

drivers/dma/altera-msgdma.c:msgdma_irq_handler() {
	if ((status & MSGDMA_CSR_STAT_BUSY) =3D=3D 0) {
		/* Start next transfer if the DMA controller is idle */
		spin_lock(&mdev->lock);
		mdev->idle =3D true;
		msgdma_start_transfer(mdev);
		spin_unlock(&mdev->lock);
	}

	tasklet_schedule(&mdev->irq_tasklet);

	/* Clear interrupt in mSGDMA controller */
	iowrite32(MSGDMA_CSR_STAT_IRQ, mdev->csr + MSGDMA_CSR_STATUS);
}

If the newly started DMA transfer completes extremely quickly, before the
CPU reaches the iowrite32() instruction, the hardware will assert the IRQ
bit again.

The unconditional clear will then clear this new interrupt event, and becau=
se
the event is lost, the tasklet will not be scheduled for the second transfe=
r.

On systems without a response FIFO, the tasklet completes exactly one
descriptor per run, so losing the interrupt could strand the second descrip=
tor
in the active_list permanently.

Should the interrupt status be cleared before initiating the next transfer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4586c39b43aa3b94809=
89940fe905dac40c8cefc.1779173156.git.tze.yee.ng@altera.com?part=3D1

