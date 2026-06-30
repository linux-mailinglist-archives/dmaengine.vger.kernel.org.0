Return-Path: <dmaengine+bounces-11892-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 425PBAvbQ2pFkQoAu9opvQ
	(envelope-from <dmaengine+bounces-11892-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 17:04:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B076E5B3E
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 17:04:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OBsG8k+4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11892-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11892-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71343305C10F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2D034AB1D;
	Tue, 30 Jun 2026 14:57:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFA2609FD
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 14:57:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831429; cv=none; b=P7bnKrONoHoRbCAiXInQuqZunbCPD2NQdmO8v/USJ3YU7jkPoY2H8lNAzN2UfWEopA05/WTFeFS5MmH4a1WYp7C6ZcOU6TteRnRoWgInVkcVU2gdqMsEfsIfHLLw8KEkc4FL0QTdnT+furXMm4k0bmnbySRPHL2PFr4KZaQZir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831429; c=relaxed/simple;
	bh=3Oca45YPS4+Dpl/LQCylF1xrDdORac3cXwtghZEYqcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HvCsZ1uyN9iPJlAeg9gAnd4+xQ7yK6NmU3TpEXIJj683Cxj7uaepk1EqjsuNJ3FRMl2ck9D3Vv/sHZLGZHbZxVAKNoeFWc7/xjDaFesRDKXC/7ZeRJqss+e6BVxRIEqbrmt1zlvRjEJgVNUC8sdi1K5EAALG+L9jhPjpzSztL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBsG8k+4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736EE1F00A3A;
	Tue, 30 Jun 2026 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782831427;
	bh=o8VcCznFyjsNZEK8aq8KOEp9oZ10of/dMAVhAbdNafA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OBsG8k+4yj9nEP2WgFjJ4ajQDKEb78/YjW6p/RFmBebsgVChm+1px1xwZvZE/ufAI
	 er3Syh+mt8atqLS21elS0k6218tnVs2/sWEOeg/deSBpdc7JggTNBGRvM9jIp0IiVv
	 tlBmkOAvodJIm5AFw31d5HNygJZpZB2TIxCi5Kmu6WrtFoI6zDoic+HrnUi35zVuQJ
	 KXc5imMi8fFGYjAlFnk83J1iLyv0X9ar4vWf7pJaPxb0UR0R+GyRtijQtUaypVAhrE
	 L/8TEHFItU2xQXy+D6Y9nddRS9m6hpKp7svG/UbTcXW+Wic3PNz6CNRT7xBSgddBiP
	 boUwx5Mj3vlfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: hisilicon: Return -ENOMEM on dynamic memory
 allocation in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Zapolskiy" <vz@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260630144214.4080302-1-vz@kernel.org>
References: <20260630144214.4080302-1-vz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:57:06 +0000
Message-Id: <20260630145707.736EE1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11892-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vz@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76B076E5B3E

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] IRQ handler is registered before channel state and locks are initi=
alized.
- [High] terminate_all fails to abort ongoing DMA transfer in hardware, cau=
sing memory corruption.
- [High] hisi_dma_irq blindly assumes interrupts indicate completion withou=
t validating the VALID_BIT.
- [High] Tasklet can be scheduled after being killed during device unbind o=
r probe failure due to incorrect devres teardown ordering.
- [Medium] Missing explicit pci_free_irq_vectors() in probe error paths.
--

commit 9e9e45695edfd75e6c95dac5980f5bcc1c7e1a68
Author: Vladimir Zapolskiy <vz@kernel.org>

dmaengine: hisilicon: Return -ENOMEM on dynamic memory allocation in probe

Out of memory situation on driver's probe is expected to be reported to
the driver's framework with a proper -ENOMEM error code.

> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index 28bf818f9aa63..c751a2e49e6dc 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -983,7 +983,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>  	hdma_dev =3D devm_kzalloc(dev, struct_size(hdma_dev, chan, chan_num),
>  				GFP_KERNEL);
>  	if (!hdma_dev)
> -		return -EINVAL;
> +		return -ENOMEM;
> =20
>  	hdma_dev->base =3D pcim_iomap_table(pdev)[PCI_BAR_2];
>  	hdma_dev->pdev =3D pdev;

[Severity: Medium]
This is a pre-existing issue, but I noticed that later in hisi_dma_probe(),
if an error occurs after successfully allocating IRQ vectors, the vectors
might be leaked.

For example, if hisi_dma_enable_hw_channels() fails:

    drivers/dma/hisi_dma.c:hisi_dma_probe() {
        ...
        ret =3D pci_alloc_irq_vectors(pdev, msi_num, msi_num, PCI_IRQ_MSI);
        if (ret < 0) {
            ...
        }
        ...
        ret =3D hisi_dma_enable_hw_channels(hdma_dev);
        if (ret < 0) {
            dev_err(dev, "failed to enable hw channel!\n");
            return ret;
        }
        ...
    }

The function returns without explicitly calling pci_free_irq_vectors().
Since the PCI subsystem rules require every error path after a successful
allocation to explicitly clean up before returning, does this leak IRQ
resources?

[Severity: High]
This isn't a bug introduced by this patch, but does the sequence in
hisi_dma_enable_hw_channels() create a window for a NULL pointer
dereference?

The function requests the IRQ before enabling and initializing the queue
structures:

    drivers/dma/hisi_dma.c:hisi_dma_enable_hw_channels() {
        ...
        ret =3D hisi_dma_request_qps_irq(hdma_dev);
        if (ret) {
            dev_err(&hdma_dev->pdev->dev, "fail to request qp irq!\n");
            return ret;
        }

        hisi_dma_enable_qps(hdma_dev);
        ...
    }

If a shared or spurious interrupt fires immediately after the IRQ is
registered, hisi_dma_irq() will run and attempt to access chan->vc.lock
and chan->hdma_dev before hisi_dma_enable_qps() initializes them:

    drivers/dma/hisi_dma.c:hisi_dma_irq() {
        ...
        struct hisi_dma_dev *hdma_dev =3D chan->hdma_dev;
        ...
        spin_lock(&chan->vc.lock);
        ...
        q_base =3D hdma_dev->queue_base;
        ...
    }

Could this crash the kernel?

[Severity: High]
This is a pre-existing issue, but I see a potential use-after-free risk
during device unbind or probe failure.

In hisi_dma_disable_qps(), tasklets are killed without first synchronizing
against active IRQs:

    drivers/dma/hisi_dma.c:hisi_dma_disable_qps() {
        for (i =3D 0; i < hdma_dev->chan_num; i++) {
            hisi_dma_disable_qp(hdma_dev, i);
            tasklet_kill(&hdma_dev->chan[i].vc.task);
        }
    }

If hisi_dma_irq() is executing concurrently on another CPU, it can call
vchan_cookie_complete() and schedule the tasklet again after tasklet_kill()
returns.

Because devres teardown runs before the IRQs are actually freed, could the
tasklet execute later and access the freed hdma_dev memory?

[Severity: High]
This isn't a bug introduced by this patch, but does
hisi_dma_terminate_all() fail to abort ongoing DMA transfers in the
hardware?

The function pauses the hardware, clears software state, and then
immediately unpauses the hardware:

    drivers/dma/hisi_dma.c:hisi_dma_terminate_all() {
        ...
        hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, true);
        if (chan->desc) {
            vchan_terminate_vdesc(&chan->desc->vd);
            chan->desc =3D NULL;
        }
        ...
        hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, false);
        ...
    }

Since the hardware queue doesn't appear to be reset, unpausing the engine
could resume the active transfer. If the DMA client assumes the transfer is
terminated and frees the destination buffer, could this overwrite freed
memory?

[Severity: High]
This is a pre-existing issue, but does hisi_dma_irq() assume that
interrupts indicate completion without checking the VALID_BIT?

The driver defines VALID_BIT (BIT(0)), but the interrupt handler only
checks if the status mask is STATUS_SUCC:

    drivers/dma/hisi_dma.c:hisi_dma_irq() {
        ...
        chan->cq_head =3D (chan->cq_head + 1) % hdma_dev->chan_depth;
        ...
        if (FIELD_GET(STATUS_MASK, cqe->w0) =3D=3D STATUS_SUCC) {
            vchan_cookie_complete(&desc->vd);
            hisi_dma_start_transfer(chan);
        ...
    }

Since STATUS_SUCC is 0x0, if the hardware hasn't actually written to the
completion queue entry yet, the memory might be zero. A zeroed memory
block would pass the STATUS_SUCC check.

Could this lead to premature descriptor completion and queue
desynchronization if a spurious or error interrupt fires?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630144214.4080=
302-1-vz@kernel.org?part=3D1

