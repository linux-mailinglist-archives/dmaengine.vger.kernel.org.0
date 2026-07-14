Return-Path: <dmaengine+bounces-12530-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id irRLORTLVmoBBQEAu9opvQ
	(envelope-from <dmaengine+bounces-12530-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:49:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF575982E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:49:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nv8tPZj2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12530-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12530-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03185302FB66
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC18370ADA;
	Tue, 14 Jul 2026 23:49:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28864367F59
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 23:49:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072978; cv=none; b=DBI72Yl1EigAtiu6/G2Ve2E44XOE0n7IbvbGEH43elx5G/qcribqNAEzng8EuxbWJR/iIZstDtgilI/VR1vA5TDaGjhKDY3IMA9Fjo4vnUVNaiArMQAKowT0OLr8YXxRPUzpTlX+T2JCHJSHWA8yVi0NEDep902wa2+h4jAhnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072978; c=relaxed/simple;
	bh=TygWU3hyhR6KCtxrJUPU4XJAsZT2rEb3BCPFvCciYSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Li8q14es6xkVShM3JdAOt3Dxz05kZO0YrNBb/IXCuNElF6VkvxX5jULV19q/5Nu2Ha6vZkGqsPI/qq3hwGWAtwwLMTpBuCaNH9l4o7hOJl+my49ASHQaH8QSe/rrT6kgkx5RumIJgor+oojJL7aw/eGNQwAmomNliS1RnRchChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv8tPZj2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E74D1F000E9;
	Tue, 14 Jul 2026 23:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072976;
	bh=60JKL6NtVicb2QvY+GPcb6/SWsR0xNmE2sUZGhQTEG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nv8tPZj2FOD7XnJvSs6ntjen2G1vYsbQ1puIqsPFyiGQ1inI1RfYj4+/m9A8uQ11x
	 Op+h6TD1f0FdE1jY5Nb9KYkuOvZX/FKHqPrlUUYP47BrbCDLaA8rPerpmSDC80KSb0
	 ujmrAEsoqAj+8J/EaSGmnpi6sEGKQgt+G4O2smivcjqbLog/jJ2QcgrirEeWgwt8YZ
	 TOXWloItiOTS5VL3j87lGMxCq6EP5TrPUyuEOxucAG3B60Y6/iGqVMd20WSaUNfIuL
	 m/tbriX/IROl6gIg/TUEnZph4b2ycTsG+v8+b5p/5V/LKUzfOf3TOY09IyKagBgaZj
	 yyrWdopLJ+rOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] dma: fsl_raid: keep MMIO bases as void __iomem and
 cast at access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260714233855.870797-3-rosenp@gmail.com>
References: <20260714233855.870797-1-rosenp@gmail.com>
 <20260714233855.870797-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:49:36 +0000
Message-Id: <20260714234936.8E74D1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12530-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CAF575982E

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing return value check for `fsl_re_chan_probe()` causes NULL p=
ointer dereference.
- [High] Race condition during probe causes NULL pointer dereference in the=
 ISR.
- [High] Missing `free_irq()` causes Use-After-Free of the interrupt handle=
r.
- [High] DMA channels are never added to the DMA device's channel list.
- [High] The driver invokes the client callback while holding the channel's=
 spinlock, risking an ABBA deadlock.
--

--- Patch [2]: [PATCH 2/3] dma: fsl_raid: keep MMIO bases as void __iomem a=
nd cast at access ---
commit efbae01ecec4b10e7d40ae8af0275362e4f9669a
Author: Rosen Penev <rosenp@gmail.com>

dma: fsl_raid: keep MMIO bases as void __iomem and cast at access

This patch updates the driver to store MMIO bases as void __iomem pointers
and uses typed local pointers to access fields. This resolves sparse warnin=
gs
about different address spaces when using ioread32be() and iowrite32be().

Link: https://lore.kernel.org/oe-kbuild-all/202008111749.yy85rFMD%25lkp@int=
el.com/

> diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
> index 888f55b672a58..47ebdf2743310 100644
> --- a/drivers/dma/fsl_raid.c
> +++ b/drivers/dma/fsl_raid.c
[ ... ]
> @@ -167,7 +170,7 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
>  	fsl_re_cleanup_descs(re_chan);
> =20
>  	spin_lock_irqsave(&re_chan->desc_lock, flags);
> -	count =3D	FSL_RE_SLOT_FULL(in_be32(&re_chan->jrregs->oubring_slot_full)=
);
> +	count =3D	FSL_RE_SLOT_FULL(in_be32(&jr->oubring_slot_full));

[Severity: High]
This is a pre-existing issue, but can this lock handling cause a recursive
deadlock?

In fsl_re_dequeue(), desc_lock is acquired via spin_lock_irqsave(). While
iterating through completed descriptors, fsl_re_desc_done() is called:

    while (count--) {
        ...
        if (found) {
            fsl_re_desc_done(desc);
            list_move_tail(&desc->node, &re_chan->ack_q);
        }
    ...
    }

fsl_re_desc_done() invokes the client callback inline. If the client attemp=
ts
to submit new work from its callback, fsl_re_tx_submit() will attempt to
acquire the exact same desc_lock, resulting in a deadlock.

>  	while (count--) {
>  		found =3D 0;
>  		hwdesc =3D &re_chan->oub_ring_virt_addr[re_chan->oub_count];
[ ... ]
> @@ -201,12 +203,12 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
>  /* Per Job Ring interrupt handler */
>  static irqreturn_t fsl_re_isr(int irq, void *data)
>  {
> -	struct fsl_re_chan *re_chan;
> +	struct device *dev =3D data;
> +	struct fsl_re_chan *re_chan =3D dev_get_drvdata(dev);
> +	struct fsl_re_chan_cfg __iomem *jr =3D re_chan->jrregs;

[Severity: High]
This isn't a bug introduced by this patch, but does this assume drvdata is
already set when the interrupt fires?

In fsl_re_chan_probe(), request_irq() is called to register this handler
before dev_set_drvdata(chandev, chan) sets the driver data.

If an interrupt fires immediately after registration, dev_get_drvdata(dev)
will return NULL, leading to a crash when dereferencing re_chan->jrregs.

>  	u32 irqstate, status;
> =20
> -	re_chan =3D dev_get_drvdata((struct device *)data);
> -
> -	irqstate =3D in_be32(&re_chan->jrregs->jr_interrupt_status);
> +	irqstate =3D in_be32(&jr->jr_interrupt_status);
>  	if (!irqstate)
>  		return IRQ_NONE;
> =20
[ ... ]
> @@ -709,30 +712,23 @@ static int fsl_re_chan_probe(struct platform_device=
 *ofdev,
>  	}
> =20
>  	/* Program the Inbound/Outbound ring base addresses and size */
> -	out_be32(&chan->jrregs->inbring_base_h,
> -		 chan->inb_phys_addr & FSL_RE_ADDR_BIT_MASK);
> -	out_be32(&chan->jrregs->oubring_base_h,
> -		 chan->oub_phys_addr & FSL_RE_ADDR_BIT_MASK);
> -	out_be32(&chan->jrregs->inbring_base_l,
> -		 chan->inb_phys_addr >> FSL_RE_ADDR_BIT_SHIFT);
> -	out_be32(&chan->jrregs->oubring_base_l,
> -		 chan->oub_phys_addr >> FSL_RE_ADDR_BIT_SHIFT);
> -	out_be32(&chan->jrregs->inbring_size,
> -		 FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
> -	out_be32(&chan->jrregs->oubring_size,
> -		 FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
> +	out_be32(&jr->inbring_base_h, chan->inb_phys_addr & FSL_RE_ADDR_BIT_MAS=
K);
> +	out_be32(&jr->oubring_base_h, chan->oub_phys_addr & FSL_RE_ADDR_BIT_MAS=
K);
> +	out_be32(&jr->inbring_base_l, chan->inb_phys_addr >> FSL_RE_ADDR_BIT_SH=
IFT);
> +	out_be32(&jr->oubring_base_l, chan->oub_phys_addr >> FSL_RE_ADDR_BIT_SH=
IFT);
> +	out_be32(&jr->inbring_size, FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
> +	out_be32(&jr->oubring_size, FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
> =20
>  	/* Read LIODN value from u-boot */
> -	status =3D in_be32(&chan->jrregs->jr_config_1) & FSL_RE_REG_LIODN_MASK;
> +	status =3D in_be32(&jr->jr_config_1) & FSL_RE_REG_LIODN_MASK;
> =20
>  	/* Program the CFG reg */
> -	out_be32(&chan->jrregs->jr_config_1,
> -		 FSL_RE_CFG1_CBSI | FSL_RE_CFG1_CBS0 | status);
> +	out_be32(&jr->jr_config_1, FSL_RE_CFG1_CBSI | FSL_RE_CFG1_CBS0 | status=
);
> =20
>  	dev_set_drvdata(chandev, chan);

[Severity: High]
This is a pre-existing issue, but are we leaking the registered IRQ?

Neither the error path of fsl_re_chan_probe() nor the teardown function
fsl_re_remove_chan() appears to call free_irq().

If fsl_re_chan_probe() fails after request_irq(), or if the module is
unloaded, the ISR remains registered. This could lead to a use-after-free
if an interrupt fires and attempts to execute unmapped memory.

[Severity: High]
This is another pre-existing issue, but is it intentional that the
initialized DMA channel is not added to the DMA device's channel list?

Earlier in fsl_re_chan_probe(), the channel is initialized:

    re_priv->re_jrs[q] =3D chan;
    chan->chan.device =3D dma_dev;
    ...

However, list_add_tail(&chan->chan.device_node, &dma_dev->channels) is never
called. When dma_async_device_register() is executed, it might find the list
empty and register 0 channels, making them unavailable to clients.

> =20
>  	/* Enable RE/CHAN */
> -	out_be32(&chan->jrregs->jr_command, FSL_RE_ENABLE);
> +	out_be32(&jr->jr_command, FSL_RE_ENABLE);
> =20
>  	return 0;
> =20
[ ... ]
> @@ -752,6 +748,7 @@ static int fsl_re_probe(struct platform_device *ofdev)
>  	u8 ridx =3D 0;
>  	struct dma_device *dma_dev;
>  	struct resource *res;
> +	struct fsl_re_ctrl __iomem *re_regs;
>  	int rc;
>  	struct device *dev =3D &ofdev->dev;

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the return value of
fsl_re_chan_probe() later in this function?

If the probe fails (e.g. out of memory), total_chans is still incremented:

    for_each_child_of_node(np, child) {
        rc =3D of_device_is_compatible(child, "fsl,raideng-v1.0-job-ring");
        if (rc) {
            fsl_re_chan_probe(ofdev, child, ridx++, off);
            re_priv->total_chans++;
        }
    }

This leaves an uninitialized pointer in the re_jrs array, which might be
dereferenced as a NULL pointer during driver unbind in fsl_re_remove_chan()
when it calls tasklet_kill(&chan->irqtask).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714233855.8707=
97-1-rosenp@gmail.com?part=3D2

