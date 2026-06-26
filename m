Return-Path: <dmaengine+bounces-11818-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XvUeAuyDPmqIHQkAu9opvQ
	(envelope-from <dmaengine+bounces-11818-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 15:51:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED756CDB7E
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 15:51:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cr7yJ9bM;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11818-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11818-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C1A3001875
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1C3F7897;
	Fri, 26 Jun 2026 13:46:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B83F23B7
	for <dmaengine@vger.kernel.org>; Fri, 26 Jun 2026 13:46:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481603; cv=none; b=WF9h6aKnJzv/njHLeTu/U8DHi9Xiw9gcCsBnR8j+mom51oY5QOJYQybO4DPmBFWlgb5FbvBcvyGhdXGgQFtYKRkDebUN6jktmll5k1+cAzIhhlX1BTrZP4+/wu1Fs1jW5kflzAKa/X+D7GFlojRbpIYXw2tqK2jF5IkGU0q0U0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481603; c=relaxed/simple;
	bh=aCJfaHbwgOzKDMo9UpeuselinK6tNzwgE8AzNnIQs8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UN+/HBi0Or/bTHsGNGijhjBFtUnJtlUq2slDe92fsQXJzm0TxpvqoTfl9Mqvi+Dtpm9AX8O3zg61sU9b9kPb4XeDiS3NZD8xSVisY/nlGHWsTIATJuFFlQDmjJmo+phTNASxHka9AtfxVrNaCcwrbGyUuxEoTUwqvd3nZd+ZfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr7yJ9bM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D161F000E9;
	Fri, 26 Jun 2026 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782481601;
	bh=iAYgC08zPtKL+WrmYw6T23hvtlCZ/fGqSv5i+2ZlkwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cr7yJ9bM7IzoYGvyuukX7BAgaXTw/bQxMg8IJjTGLA+5TcaTZr2eaFa5GGosNIZgi
	 goT7/7unDKyH5doejdQFE9zofnoX5K8CH0Agd2LJ/Q8fdFMLf+COPG393rauU484CQ
	 PlGdlzLyTe8Tv/dbn6tEt7JN12EYuQLWzAspZbJUgg9Mm2B5UF2Z4igSWUS38lNabx
	 z0WB5UQIBoTIlbPFumybJjgGFWSd/IY4IHUV2UlOklDENUaTkb4zCvOC1YP5gMDUwh
	 JN7To7d4h5sj/Nrt4YCalFpUe0iw8faa1++kCRrKCtWsv0udqEru5EL7ES/bi20Tvm
	 vKIgz94snIJkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260626132151.1875965-1-devendra.verma@amd.com>
References: <20260626132151.1875965-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:46:40 +0000
Message-Id: <20260626134641.87D161F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11818-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4ED756CDB7E

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The DesignWare PCIe controller integration rejects eDMA initializa=
tion for HDMA platforms with more than 8 channels because `dw_pcie_edma_fin=
d_channels` and `dw_pcie_edma_irq_vector` unconditionally enforce the old 8=
-channel limit.

Pre-existing issues:
- [High] The arguments `dir` and `ch` are swapped when calling `GET_CH_32` =
in `dw_hdma_v0_core_ch_status`, causing it to read the wrong hardware regis=
ters.
- [High] The driver requests shared IRQs before the interrupt context data =
is fully initialized, exposing a NULL pointer dereference window if an inte=
rrupt fires early.
--

commit cc43ddee72586cbf9f93d80ae20f2b0a9e539a31
Author: Devendra K Verma <devendra.verma@amd.com>

dmaengine: dw-edma: Enable HDMA 64R/W Channels

This commit updates the DesignWare eDMA driver to support up to 64 read and
write channels for HDMA. It introduces HDMA-specific macros, adjusts channe=
l=20
counts in device structures, and switches bitmasks to 64-bit to accommodate=
=20
the higher channel counts.

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
This is a pre-existing issue, but does the current probe sequence expose a
window for a NULL pointer dereference if an early interrupt fires?

In dw_edma_probe(), we call dw_edma_irq_request() which registers a shared
IRQ handler:

    err =3D request_irq(irq, dw_edma_interrupt_common,
                      IRQF_SHARED, dw->name, &dw->irq[0]);

However, the interrupt context data (irq->dw) isn't populated until the lat=
er
call to dw_edma_channel_setup():

    irq->dw =3D dw;

If another device sharing the same IRQ line triggers an interrupt before
dw_edma_channel_setup() completes, could the handler dereference a NULL
dw_irq->dw pointer?

[ ... ]
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 632abb8b481cf..61064de293b85 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
[ ... ]
> @@ -118,19 +129,20 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_i=
rq, enum dw_edma_dir dir,
>  	unsigned long total, pos, val;
>  	irqreturn_t ret =3D IRQ_NONE;
>  	struct dw_edma_chan *chan;
> -	unsigned long off, mask;
> +	DECLARE_BITMAP(mask, 64);
> +	unsigned long off;
> =20
>  	if (dir =3D=3D EDMA_DIR_WRITE) {
>  		total =3D dw->wr_ch_cnt;
>  		off =3D 0;
> -		mask =3D dw_irq->wr_mask;
> +		bitmap_from_u64(mask, dw_irq->wr_mask);
>  	} else {
>  		total =3D dw->rd_ch_cnt;
>  		off =3D dw->wr_ch_cnt;
> -		mask =3D dw_irq->rd_mask;
> +		bitmap_from_u64(mask, dw_irq->rd_mask);
>  	}
> =20
> -	for_each_set_bit(pos, &mask, total) {
> +	for_each_set_bit(pos, mask, total) {
>  		chan =3D &dw->chan[pos + off];
> =20
>  		val =3D dw_hdma_v0_core_status_int(chan);

[Severity: High]
This is a pre-existing issue, but is it possible that=20
dw_hdma_v0_core_ch_status() reads from the wrong hardware register by
swapping its arguments?

When checking the status, the GET_CH_32 macro expects the direction first,=
=20
then the channel:

    GET_CH_32(dw, dir, ch, name)

However, dw_hdma_v0_core_ch_status() passes chan->id before chan->dir:

    tmp =3D FIELD_GET(HDMA_V0_CH_STATUS_MASK,
                    GET_CH_32(dw, chan->id, chan->dir, ch_stat));

Could this lead to incorrect channel status checks?

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
> =20
>  struct dw_edma;
> =20

[Severity: High]
With the expansion to 64 channels, will the DesignWare PCIe controller
integration reject valid HDMA configurations?

In dw_pcie_edma_find_channels(), the code unconditionally enforces the old
EDMA_MAX_WR_CH (8) limits:

    if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
        !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
        return -EINVAL;

Similarly, dw_pcie_edma_irq_vector() enforces a maximum of 16 vectors:

    if (nr >=3D EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
        return -EINVAL;

Do these bounding checks in the PCIe controller driver also need to be
updated to handle the new HDMA_MAX_WR_CH and HDMA_MAX_RD_CH limits, to
prevent the device probe from completely failing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626132151.1875=
965-1-devendra.verma@amd.com?part=3D1

