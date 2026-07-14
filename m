Return-Path: <dmaengine+bounces-12457-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TOTjBC3HVWpJswAAu9opvQ
	(envelope-from <dmaengine+bounces-12457-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:20:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC5751150
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:20:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KKyPkaf+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12457-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12457-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A6EF30BEB20
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 05:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F27309EF4;
	Tue, 14 Jul 2026 05:16:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7072FDC57;
	Tue, 14 Jul 2026 05:16:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006206; cv=none; b=j2ZGZXyGqXK25FA8qTmnqDWwyICX/k7ZAD5vqiY0fXm++bTCkOuGiQTzisWYtSurqUVPelixsEf5m/OFsZ3KI1ivWsdtIWW2iCuJVmwgWkFQGVbfP9PHkDbaGQVEHXKZt7PirpCdM2kd16P5GGs1q0z7PaTmHENyRl3VitACNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006206; c=relaxed/simple;
	bh=fffcwaDccwB9eQFVpdZGxcpRpiC1foAISxuTR+mFvl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hbDoxAzhzEzJd983anz7lqMzavruJs/Tqig7bx1XRRp5lCHN8Tr9JlFSwZMz8Q9jlnhfHKH5ScjnLW0R1gVaqobFkz1wTo+T6+1s6Slz8/O8OX84snO2VRVd6fEM16h7yf+AxWKGPDBzs7kS5x6S8VLwhv7FvmBu/hXZx77aOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKyPkaf+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA82A1F000E9;
	Tue, 14 Jul 2026 05:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784006205;
	bh=t/ymbryqXA0PVYLOIPdx5k/lhyNw4Y1C42sqqleX2gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKyPkaf+RT9HGrBw0WtfieWB0he5VWyF+C/1A0G3LHC+Wdy9Z8O/hrkwfJsJmAoDK
	 jw70bXG2kogDz8NT0yfDo7huvYGgQxFQz7QKOxnoIx40Rqzr06FcoGTU1tlaRyy0eY
	 a/HqCw/abbw8XaIDVI08mKwP/7prvjsjRpvJ/9qPjTuE17UhNUSfCDzNGzdFgujCWe
	 U8UTR7ElP4BEG77gxA3EhVLdBOok/KD/BqXlskLqHk0pwXDJz12mvgcavm2+UaW/lq
	 1XuvGcOy2ljhuVSP4VtASnLx1RgZWdv9ul4+xTr+L3l1ON/HnYrZkKP0OcW13r0hs/
	 i4CBTGctubRsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dmaengine: qcom: bam_dma: SCM-assign descriptor
 FIFOs to a remote VMID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vishnu Santhosh" <vishnu.santhosh@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260714-qcom-bam-dma-vmid-ext-v1-2-cef87c57b7dc@oss.qualcomm.com>
References: <20260714-qcom-bam-dma-vmid-ext-v1-0-cef87c57b7dc@oss.qualcomm.com>
 <20260714-qcom-bam-dma-vmid-ext-v1-2-cef87c57b7dc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:16:44 +0000
Message-Id: <20260714051644.CA82A1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12457-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vishnu.santhosh@oss.qualcomm.com,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EAC5751150

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Passing an IOVA to the TrustZone SCM call instead of a strictl=
y required physical address.
- [High] Skipping hardware reset during channel termination causes DMA Use-=
After-Free and persistent state corruption.
- [High] Skipping interrupt disable during channel free leaves hardware int=
errupts unmasked for a destroyed channel.

Pre-existing issues:
- [High] Unconditional MMIO register access in driver removal causes a sync=
hronous external abort on remote-powered BAMs.
--

--- Patch [2]: [PATCH 2/2] dmaengine: qcom: bam_dma: SCM-assign descriptor =
FIFOs to a remote VMID ---
commit 91f2fbb1c7215cade81c38c8732865591d19254f
Author: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

dmaengine: qcom: bam_dma: SCM-assign descriptor FIFOs to a remote VMID

On Qualcomm SoCs where the BAM is powered by a remote processor that
enforces XPU access control, the BAM reads the descriptor FIFO as an
AXI master under the remote execution environment. This patch handles
such BAMs by keeping the descriptor FIFO as a persistent resource,=20
SCM-assigning it once and reclaiming it during remove.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 1bb26af0405f3..389ca1a9d70e8 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
[ ... ]
> @@ -559,6 +567,126 @@ static void bam_chan_init_hw(struct bam_chan *bchan,
[ ... ]
> +static int bam_assign_fifo(struct bam_device *bdev, struct bam_chan *bch=
an)
> +{
> +	struct qcom_scm_vmperm *dst __free(kfree) =3D NULL;
> +	u64 src =3D BIT_ULL(QCOM_SCM_VMID_HLOS);
> +	int i, ret;
[ ... ]
> +	ret =3D qcom_scm_assign_mem(bchan->fifo_phys, BAM_DESC_FIFO_SIZE,
> +				  &src, dst, bdev->num_vmids + 1);

[Severity: Critical]
Is it safe to pass the IOVA returned by the DMA allocation API to TrustZone
here?

When the device is behind an IOMMU, bchan->fifo_phys contains a dma_addr_t
IOVA. However, TrustZone operates on raw physical memory and expects a phys=
ical
address to program hardware XPUs, completely bypassing the local IOMMU
translation.

Could this cause TrustZone to configure XPU memory permissions for the wrong
physical address?

> +	if (ret) {
> +		dev_err(bdev->dev, "SCM assign fifo chan %u failed: %d\n",
> +			bchan->id, ret);
> +		return ret;
> +	}
> +
> +	bchan->fifo_src_perms =3D src;
> +
> +	return 0;
> +}
> +
> +/**
> + * bam_fifo_can_free - Reclaim a channel's descriptor FIFO to HLOS
[ ... ]
> +static bool bam_fifo_can_free(struct bam_device *bdev, struct bam_chan *=
bchan)
> +{
> +	struct qcom_scm_vmperm hlos =3D {
> +		.vmid =3D QCOM_SCM_VMID_HLOS,
> +		.perm =3D QCOM_SCM_PERM_RW,
> +	};
> +	int ret;
> +
> +	if (!bchan->fifo_src_perms)
> +		return true;
> +
> +	ret =3D qcom_scm_assign_mem(bchan->fifo_phys, BAM_DESC_FIFO_SIZE,
> +				  &bchan->fifo_src_perms, &hlos, 1);

[Severity: Critical]
Since bchan->fifo_phys is an IOVA when an IOMMU is present, will passing it
back during the reclaim operation compound the memory permission corruption
noted above?

> +	if (ret) {
> +		dev_err(bdev->dev, "SCM reclaim fifo chan %u failed: %d; leaking\n",
> +			bchan->id, ret);
> +		return false;
> +	}
[ ... ]
> @@ -613,12 +754,29 @@ static void bam_free_chan(struct dma_chan *chan)
>  		goto err;
>  	}
> =20
> +	/*
> +	 * Remote-owned BAMs (qcom,vmid) keep the descriptor FIFO allocated and
> +	 * SCM-assigned across power cycles: the remote may already have cut
> +	 * power, so pipe-register access would fault, and TZ still holds the
> +	 * grant for the next restart (the FIFO is reclaimed and freed once in
> +	 * bam_dma_remove). Only drop local channel state here so the block and
> +	 * pipe are re-initialised on the next power-on; skip all MMIO.
> +	 */
> +	if (bdev->num_vmids) {
> +		scoped_guard(spinlock_irqsave, &bchan->vc.lock)
> +			bchan->initialized =3D 0;
> +		bdev->active_channels--;
> +		goto err;
> +	}

[Severity: High]
Does this early exit skip masking and disabling the channel's interrupts in=
 the
BAM controller?

If the hardware reset was also skipped during termination, the BAM might st=
ill
be actively running. Could this assert an unmasked interrupt when a pending
transaction completes after the channel is freed, resulting in an interrupt
storm or use-after-free in the interrupt handler?

> +
>  	scoped_guard(spinlock_irqsave, &bchan->vc.lock)
>  		bam_reset_channel(bchan);
[ ... ]
> @@ -767,7 +925,9 @@ static int bam_dma_terminate_all(struct dma_chan *cha=
n)
>  		if (!list_empty(&bchan->desc_list)) {
>  			async_desc =3D list_first_entry(&bchan->desc_list,
>  						      struct bam_async_desc, desc_node);
> -			bam_chan_init_hw(bchan, async_desc->dir);
> +			/* Remote-owned BAM: pipe reset may fault, skip it. */
> +			if (!bchan->bdev->num_vmids)
> +				bam_chan_init_hw(bchan, async_desc->dir);

[Severity: High]
By skipping the hardware reset for remote-owned BAMs without providing an
alternative mechanism to halt the active hardware pipe, won't the BAM conti=
nue
performing DMA?

When the client subsequently frees its data buffers, the still-running DMA
hardware could overwrite the freed memory. Furthermore, since the internal
software state flag for initialization isn't cleared, might future transfers
start with desynchronized FIFO pointers?

>  		}
[ ... ]
> @@ -1418,9 +1582,10 @@ static void bam_dma_remove(struct platform_device =
*pdev)
>  		if (!bdev->channels[i].fifo_virt)
>  			continue;
> =20
> -		dma_free_wc(bdev->dev, BAM_DESC_FIFO_SIZE,
> -			    bdev->channels[i].fifo_virt,
> -			    bdev->channels[i].fifo_phys);
> +		if (bam_fifo_can_free(bdev, &bdev->channels[i]))
> +			dma_free_wc(bdev->dev, BAM_DESC_FIFO_SIZE,
> +				    bdev->channels[i].fifo_virt,
> +				    bdev->channels[i].fifo_phys);
>  	}

[Severity: High]
This is a pre-existing issue, but I noticed an unconditional MMIO register
access in bam_dma_remove() happens right before this loop:

	/* mask all interrupts for this execution environment */
	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

If the BAM driver is unbound while the remote firmware has cut power to the
hardware, wouldn't this unconditional MMIO write in the removal function fa=
ult?

The patch intentionally skipped MMIO operations in other teardown paths (li=
ke
channel free and terminate) to prevent this exact crash on remote-powered B=
AMs.
Could we also fix this in the removal path?

> =20
>  	tasklet_kill(&bdev->task);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-qcom-bam-d=
ma-vmid-ext-v1-0-cef87c57b7dc@oss.qualcomm.com?part=3D2

