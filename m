Return-Path: <dmaengine+bounces-12054-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fpTpD7KwS2pRYgEAu9opvQ
	(envelope-from <dmaengine+bounces-12054-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:42:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F27711650
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:42:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RnPIVl2a;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12054-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12054-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36FCD319FDC7
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893C42086B;
	Mon,  6 Jul 2026 12:58:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78342086A
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 12:58:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342721; cv=none; b=tBnXRUxxXOQWUdYKYfta/5YkSnuhE+MANBe7BXBjDpr0XwuI4bfes75IDXxroWJy8eLb67rBkMvFPPg+/2HU5FHatoyJ8J2rTfj8Ie37CJMqckCituZidgZA2FW6YVWU72+WtUYlqhu2Fj66Qr02ECmzIydy6JzGLqAnkCjrh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342721; c=relaxed/simple;
	bh=lqa7tDeYrs+zW6whzPmvxWUGCSqNUuo0LWgieM8u7kU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aE4rjkPCXual3Oqf+azEKYvHR01POEJTeafJxk8JMc2EjR9lB6WqcTyz8+Xr0nVti63diCb3nCr1nnDu7KNrgK3qHl/4x8+1Hj1LWQ3fQe5qjhiKj/SkEI8qoFWKwd31JTATWLoIwgzym/ojSr7+5qy/OAw48kssuYv6HNXeHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnPIVl2a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E8A1F000E9;
	Mon,  6 Jul 2026 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342720;
	bh=SNNV8XjetsQROVi84Ai/3y3n2jmur8vjYiC899saLcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RnPIVl2aBAGTgA9nPELMOBUWF/sAjpGvR8NgsIE+Gzy4EIHlvAluuFg1exdd7xrcH
	 I/F3PBli5mEH5QfowZyvAqMNEfbFIWz8U3Kc8McAzAXM0cs9cGpn4tNWGtGBf1J/dB
	 uRJ/CokN2BX1UIBDz+xOKZtBwgfIGn9DEJMR8YLsx27kg1rjbMXoevG1RgXlM41Tjw
	 HmlnIc3Vdr0gxR6EXW8WL96L/OCPoaBJxiBI/SSYOzKU63jGMYZVPqIMAS50pRHfA2
	 LBj1W3Nqy2UgJi2Rs/Q0IXalcJkJ9ab1VC/6c4trXQdg4CwFj2WIFYojUiEF0qqKYg
	 336ZWJh1AtwwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260706123326.2023088-1-devendra.verma@amd.com>
References: <20260706123326.2023088-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:58:39 +0000
Message-Id: <20260706125839.D2E8A1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12054-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19F27711650

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch claims to enable 64 channels but fails to update hardcod=
ed limits in glue drivers, causing probe failures.

Pre-existing issues:
- [High] Shared IRQs are requested before the data pointer is initialized, =
leading to a NULL pointer dereference.
- [High] The DMA device is unregistered after shutting down the hardware an=
d freeing IRQs, causing deadlocks or state corruption.
- [High] The GET_CH_32 macro is invoked with swapped channel and direction =
arguments, reading wrong hardware registers.
--

commit 0903d2de2eb73c2f00c6193e8c6af79a10004b92
Author: Devendra K Verma <devendra.verma@amd.com>

dmaengine: dw-edma: Enable HDMA 64R/W Channels

This commit updates the dw-edma core driver to support up to 64 read and wr=
ite
channels for the HDMA controller. It defines new macros for the increased
channel count, updates the probe function to use them, and changes masks
to 64-bit bitmaps to accommodate the higher limits.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 89a4c498a17b8..7847b6e1322ac 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, =
u32 wr_alloc, u32 rd_alloc)
>  		irq =3D &dw->irq[pos];
> =20
>  		if (chan->dir =3D=3D EDMA_DIR_WRITE)
> -			irq->wr_mask |=3D BIT(chan->id);
> +			bitmap_set(irq->wr_mask, chan->id, 1);
>  		else
> -			irq->rd_mask |=3D BIT(chan->id);
> +			bitmap_set(irq->rd_mask, chan->id, 1);
> =20
>  		irq->dw =3D dw;

[Severity: High]
This is a pre-existing issue, but since we are modifying channel setup here,
can this lead to a NULL pointer dereference?

In dw_edma_probe(), we call dw_edma_irq_request() which requests the shared
IRQ before dw_edma_channel_setup() is called to initialize irq->dw here.
If a shared interrupt fires immediately after request_irq() succeeds:

dw_edma_probe()
  dw_edma_irq_request()
    request_irq(irq, dw_edma_interrupt_common, IRQF_SHARED, ...)
  ...
  dw_edma_channel_setup()
    irq->dw =3D dw;

Would dw_edma_interrupt_common() dereference a zero-initialized dw_irq->dw
before it gets assigned?

[ ... ]
> @@ -1083,20 +1085,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
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

[Severity: High]
This is a pre-existing issue, but is dw_edma_remove() unregistering the
DMA device too late?

Currently dw_edma_remove() disables the hardware via dw_edma_core_off()
and frees the IRQs before calling dma_async_device_unregister().

During this window, is it possible for client drivers to still submit
new DMA requests to a disabled controller with no interrupt handler,
leading to deadlocks or state corruption?

[ ... ]
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 632abb8b481cf..0181bd276e226 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir=
, u16 ch)
>  static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  {
>  	int id;
> +	enum dw_edma_dir dir;
> +
> +	dir =3D EDMA_DIR_WRITE;
> +	for (id =3D 0; id < dw->wr_ch_cnt; id++) {
> +		SET_CH_32(dw, dir, id, int_setup,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);

[Severity: High]
This is a pre-existing issue, but since this patch expands HDMA channel
support and relies on these macros, I noticed a potential problem in
dw_hdma_v0_core_ch_status().

It currently calls the macro with swapped arguments:

	GET_CH_32(dw, chan->id, chan->dir, ch_stat);

The macro expects (dw, dir, ch, ...). Since chan->id (0..63) is passed
as the direction, and chan->dir (0 or 1) is passed as the channel, could
this read the wrong hardware register and corrupt transfer status tracking?

[ ... ]
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e3153..da7a5cc93ad43 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -14,6 +14,8 @@
> =20
>  #define EDMA_MAX_WR_CH                                  8
>  #define EDMA_MAX_RD_CH                                  8
> +#define HDMA_MAX_WR_CH                                  64
> +#define HDMA_MAX_RD_CH                                  64

[Severity: High]
Does the PCIe designware glue driver also need to be updated to support
these higher channel limits?

If a platform provides more than 8 channels, dw_pcie_edma_find_channels()
in drivers/pci/controller/dwc/pcie-designware.c still strictly rejects it:

	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
		return -EINVAL;

Additionally, dw_pcie_edma_irq_vector() restricts IRQ vectors to 16 total:

	if (nr >=3D EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
		return -EINVAL;

Will this cause the probe to fail deterministically on systems attempting
to use the new 64-channel support?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706123326.2023=
088-1-devendra.verma@amd.com?part=3D1

