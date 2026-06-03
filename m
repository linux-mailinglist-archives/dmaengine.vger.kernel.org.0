Return-Path: <dmaengine+bounces-11148-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AAGNNzpFIGq/zgAAu9opvQ
	(envelope-from <dmaengine+bounces-11148-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 17:16:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513F639075
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 17:16:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=N4uQjMAF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11148-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11148-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBF4A30509B0
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0C386557;
	Wed,  3 Jun 2026 14:58:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179C330659
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 14:58:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498702; cv=none; b=hfNbu1yDrQ+1U9NZDuE6CzR920+fyS7cSfmHJDe6J9SmKkfNhfjD9zhPTLheFHpmbph1Waarxnt6Fa8Y1UZ+aPDuL3u6GASTp+hu9id8k1sPC+5GuD9BSzs0ZvrI0diJCHgtArUaxRpjYHnsW57A8YDu/k4NIxNJFKsds/OGoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498702; c=relaxed/simple;
	bh=cwEbvDg12hj44xugiC3jDZODWKM51qaDfBBwaAKbwik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cteVnebwpf7zratZpLx5TEL6NAzf9wUycgIMKZq8M+4mt/bSp8GmZsamxk02bxvOm2Ap4IppFoFurkv+aF2Xqt4NvNBG/u//+W3qh3HGJPnmJx6a7eY3YqdPvggNjTlu/FbhPjecbUFQSeTElTZcG4UehaoE7GJC95YI0gxjPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4uQjMAF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7E81F00893;
	Wed,  3 Jun 2026 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780498700;
	bh=czVROfMqdWaUE2Qy8V5tLEQKYyRdYf5csq9V/k6PGP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4uQjMAFXtq2qM36w5Tn8wj86z4vXK7GjVC2TTh3Kzq5bsNC7s7bxwSAFNn3ffAmH
	 C+QIpAsbenrK0qHSBvKytaaaQe/YwWw2FBJXs4SnTDbNr5Vtfkn4enhktWh1aibkoI
	 IOjqWDYPkMRGpUqLS9zU5wgxxrbPCBIuc9nrNipdVyz8IwJdKYHsZ3M7jBr+BOSr91
	 6ZY3kXjBvP0IDufxTHIyyOc09Dmun2DWGXnZ8iIlezykkMWO4zzFLSdRPPTsl6Y+8G
	 8woRK05VaW1JrxnEiC2xUso4pFk7tGu11UQLpe2t0T3pjbUp0IeoWv1weyOMItiV2B
	 ZMaEbTaqsk9Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260603144147.3249691-1-devendra.verma@amd.com>
References: <20260603144147.3249691-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 14:58:19 +0000
Message-Id: <20260603145820.2E7E81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[lists.linux.dev:server fail,smtp.kernel.org:server fail,sashiko.dev:server fail,vger.kernel.org:server fail,tor.lore.kernel.org:server fail,amd.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11148-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5513F639075

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The 64-channel HDMA feature is unreachable because platform glue d=
rivers still enforce legacy 8-channel hardcoded limits.

Pre-existing issues:
- [High] The eDMA subsystem is deregistered AFTER the hardware core is disa=
bled and IRQs are freed, violating tear-down symmetry.
- [High] The virt-dma descriptors are never freed when a channel is release=
d, leading to a permanent memory leak.
--

commit 20ba395bede7014c18b81804a5f6a941f3a95ebd
Author: Devendra K Verma <devendra.verma@amd.com>

dmaengine: dw-edma: Enable HDMA 64R/W Channels

As per 'Designware Cores PCI Express Controller Databook',
Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
channels. Current controller driver supports up to 8 read and
write channels only. In order to utilize all the channels the
controller driver need to have the channel related structs
and variables as per the number of channels supported by IP.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..adf1b3939f96c 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> @@ -1079,6 +1079,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	struct dw_edma *dw;
>  	u32 wr_alloc =3D 0;
>  	u32 rd_alloc =3D 0;
> +	u16 max_wr_cnt;
> +	u16 max_rd_cnt;
>  	int i, err;
> =20
>  	if (!chip)
> @@ -1094,20 +1096,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> =20
>  	dw->chip =3D chip;
> =20
> -	if (dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE)
> +	if (dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) {
>  		dw_hdma_v0_core_register(dw);
> -	else
> +		max_wr_cnt =3D HDMA_MAX_WR_CH;
> +		max_rd_cnt =3D HDMA_MAX_RD_CH;
> +	} else {
>  		dw_edma_v0_core_register(dw);
> +		max_wr_cnt =3D EDMA_MAX_WR_CH;
> +		max_rd_cnt =3D EDMA_MAX_RD_CH;
> +	}
> =20
>  	raw_spin_lock_init(&dw->lock);
> =20
>  	dw->wr_ch_cnt =3D min_t(u16, chip->ll_wr_cnt,
>  			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> -	dw->wr_ch_cnt =3D min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> +	dw->wr_ch_cnt =3D min_t(u16, dw->wr_ch_cnt, max_wr_cnt);
> =20
>  	dw->rd_ch_cnt =3D min_t(u16, chip->ll_rd_cnt,
>  			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> -	dw->rd_ch_cnt =3D min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> +	dw->rd_ch_cnt =3D min_t(u16, dw->rd_ch_cnt, max_rd_cnt);
> =20
>  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>  		return -EINVAL;

[Severity: High]
This patch expands the eDMA core structures to support up to 64 HDMA channe=
ls.
However, does it miss updating the PCIe instantiation wrappers, rendering t=
he
feature unusable?

In drivers/pci/controller/dwc/pcie-designware.c, dw_pcie_edma_find_channels=
()
performs a sanity check that explicitly rejects any configuration exceeding
EDMA_MAX_WR_CH (8), returning -EINVAL:

	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
		return -EINVAL;

Similarly, dw_pcie_edma_irq_vector() limits IRQ indices to 16
(EDMA_MAX_WR_CH + EDMA_MAX_RD_CH).

Furthermore, in drivers/dma/dw-edma/dw-edma-pcie.c, the functions
dw_edma_pcie_get_synopsys_dma_data() and dw_edma_pcie_get_xilinx_dma_data()
use min_t to bound the hardware-reported channel count against
pdata->wr_ch_cnt (which is statically initialized to 2 or 8):

	pdata->wr_ch_cnt =3D min_t(u16, pdata->wr_ch_cnt,
				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));

Will any attempt to configure an HDMA device with >8 channels be silently
truncated to 8 or fail to probe completely?


[Severity: High]
This is a pre-existing issue, but looking at dw_edma_remove(), the eDMA
subsystem is deregistered after the hardware core is disabled and IRQs are
freed. Does this violate tear-down symmetry?

In dw_edma_remove(), the driver first calls dw_edma_core_off(dw) to disable
the hardware, and then frees all IRQs using free_irq(). Only after that does
it call dma_async_device_unregister(&dw->dma) and kill the virt-dma tasklet=
s:

	/* Disable eDMA */
	dw_edma_core_off(dw);

	/* Free irqs */
	for (i =3D (dw->nr_irqs - 1); i >=3D 0; i--)
		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
	dw_edma_emul_irq_free(dw);

	/* Deregister eDMA device */
	dma_async_device_unregister(&dw->dma);

If a client still holds a reference and has an active DMA transfer or submi=
ts
a new one while the device is being removed, the transfer cannot complete
because the hardware is disabled and interrupts are freed. Can this lead to=
 a
hung task or a DMA timeout?


[Severity: High]
This is a pre-existing issue, but does the driver leak virt-dma descriptors
permanently when a channel is released?

The virt-dma framework requires drivers to call vchan_free_chan_resources()
from their .device_free_chan_resources callback to free all pending, submit=
ted,
and allocated descriptors. The dw_edma_free_chan_resources() function waits=
 for
the channel to stop but fails to call vchan_free_chan_resources(&chan->vc)
or manually free the descriptors:

static void dw_edma_free_chan_resources(struct dma_chan *dchan)
{
	unsigned long timeout =3D jiffies + msecs_to_jiffies(5000);
	int ret;

	while (time_before(jiffies, timeout)) {
		ret =3D dw_edma_device_terminate_all(dchan);
		...=20
	}
}

As a result, every time a client allocates descriptors and then releases the
channel, are all those descriptors permanently leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603144147.3249=
691-1-devendra.verma@amd.com?part=3D1

