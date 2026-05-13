Return-Path: <dmaengine+bounces-10403-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IfGOGfzA2prBAIAu9opvQ
	(envelope-from <dmaengine+bounces-10403-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 05:43:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC2C52CE8F
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 05:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21DA330ECA66
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 03:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D838F247;
	Wed, 13 May 2026 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML/UGvmE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE43364032;
	Wed, 13 May 2026 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643343; cv=none; b=DChKyVRZWAy839gWINI2Xl4d5C6af86qxcCpA+zVaKuso9DLxBqaG5AXvkIZ+8c30n0wOWJqTMt+JqkPglDKaRyKNBoI1qrKNVEGIQ3SjH6Y0fUKEkZ2V3lSDS0Z6CSprUYtW+o1sc4Kd9FqyIbHQ0O9ISVwvUbsCsdCGEQqNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643343; c=relaxed/simple;
	bh=2OlKZqLKPXUqQjcg8lr2tkBNWTsEMroIAyO2KJRQ6eU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ivDoz09P0ORMhpzOfiINIzGc/TcgYRaENER6Mt2sFy7CjPVYNAxpTCy7Fo6eJP3cQl27JYjOcxxTUWiN+60k12NAl/AsXi87deOATVcsH0FBiNkyTLHKJKwxrCETPd0+f8ZzRodLPn3V1IDyIwP0WVjwxc+bhojXYWLH6PEEylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML/UGvmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD8BC2BCC9;
	Wed, 13 May 2026 03:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643343;
	bh=2OlKZqLKPXUqQjcg8lr2tkBNWTsEMroIAyO2KJRQ6eU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ML/UGvmEjQvtQzBU2j3cA4u6xnTCsO/3leSTrJupsaGptRsWW/JH4tWWXJjNo/KRs
	 mZNHK3DLHxyHwXDA79GSAe/myvtbYsGaGmhZbKeW/3Xww+P5Mu0ktoLWEYmvM8uhTr
	 8LxiI9bnmSaIJRuoczU1sh5lNc9sXJiPmF+4jNipbiGt1NpSb388V1iTWUr4dDKceb
	 uIvu8StVFfXmE3kWi3NjtNBdq7x2sTRhUz+xftT+be+Yv8Hz1EDvHF5uAY9vslAbb0
	 PNdqLQw24Ke/lE9D5MKd/lCtI2Ec1tuChOIK1Dg+x/GCoP20bMvjCYJGur2qGJn4xB
	 KWUj1xLrzDrRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/23] dmaengine: sdxi: Start functions on probe,
 stop on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-9-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-9-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:35:42 +0000
Message-Id: <20260513033542.DAD8BC2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3DC2C52CE8F
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10403-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing device stop on activation timeout leads to a DMA Use-A=
fter-Free.
- [Critical] `sdxi_unregister()` ignores `sdxi_dev_stop()` timeout errors, =
leading to a DMA Use-After-Free.
- [High] `sdxi_dev_stop()` inadvertently resets the device if it is already=
 in the `SDXI_GSV_STOP` state, leading to a silent initialization race cond=
ition.
--

commit a7e5a52eac2766c976c5e81c97c4837046aa44e9
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Start functions on probe, stop on remove

Following admin context setup in the previous patch, drive each SDXI
function to active state during probe. Introduce sdxi_unregister() to
stop the function during remove and wire it up via the pci_driver
.remove callback.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 9d8729b626858..204841afa5b77 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -89,6 +89,42 @@ static void sdxi_write_fn_gsr(struct sdxi_dev *sdxi, e=
num sdxi_fn_gsr cmd)
>  	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
>  }
> =20
> +/*
> + * Transition the function from stopped state to active.
> + * See SDXI 1.0 4.1 SDXI Function State.
> + */
> +static int sdxi_dev_start(struct sdxi_dev *sdxi)
> +{
> +	enum sdxi_fn_gsv status =3D sdxi_dev_gsv(sdxi);
> +	int ret;
> +
> +	if (status !=3D SDXI_GSV_STOP) {
> +		dev_err(sdxi->dev,
> +			"can't activate busy device (unexpected gsv: %s)\n",
> +			gsv_str(status));
> +		return -EBUSY;
> +	}
> +
> +	sdxi_write_fn_gsr(sdxi, SDXI_GSRV_ACTIVE);
> +
> +	ret =3D sdxi_dev_gsv_poll(sdxi, status,
> +				status =3D=3D SDXI_GSV_ACTIVE ||
> +				status =3D=3D SDXI_GSV_ERROR);
> +	if (ret) {
> +		dev_err(sdxi->dev, "activation timed out, current state: %s\n",
> +			gsv_str(status));
> +		return ret;

If this activation times out, could the hardware still complete its
activation asynchronously?

Returning an error here causes the probe to fail, and the devres framework
will unwind allocations in LIFO order, freeing the DMA-mapped L1_table
and L2_table before the PCI device is disabled and its Bus Master bit
is cleared.

If the hardware eventually completes activation and is not explicitly halted
in this error path, could it perform DMA operations to the freed physical
pages?

> +	}
> +
> +	if (status =3D=3D SDXI_GSV_ERROR) {
> +		dev_err(sdxi->dev, "went to error state during activation\n");
> +		return -EIO;
> +	}
> +
> +	dev_dbg(sdxi->dev, "activated\n");
> +	return 0;
> +}

[ ... ]

> @@ -281,3 +321,10 @@ int sdxi_register(struct device *dev, const struct s=
dxi_bus_ops *ops)
> =20
>  	return sdxi_device_init(sdxi);
>  }
> +
> +void sdxi_unregister(struct device *dev)
> +{
> +	struct sdxi_dev *sdxi =3D dev_get_drvdata(dev);
> +
> +	sdxi_dev_stop(sdxi);

If the soft stop (SDXI_GSRV_STOP_SF) in sdxi_dev_stop() times out, it retur=
ns
an error without escalating to a hard stop or reset.

Since sdxi_unregister() ignores this return value, the removal process will
proceed and devres will free all DMA allocations while the device might rem=
ain
active with its Bus Master bit enabled.

Could this cause background DMA transfers into freed memory if the device
gets stuck in a state like SDXI_GSV_STOPG_SF?


Also looking at sdxi_dev_stop(), if the device is already in the
SDXI_GSV_STOP state, the switch statement lacks a case for it:

	switch (status) {
	case SDXI_GSV_INIT:
	case SDXI_GSV_ACTIVE:
		...
	default:
		/* Unrecognized state; try a reset. */
		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
		break;
	}

This causes execution to fall through to the default case and issue a
hardware reset. The subsequent polling loop immediately reads the
SDXI_GSV_STOP state and returns success before the hardware actually
begins processing the reset.

Because sdxi_fn_activate() calls sdxi_dev_stop() just before configuring
registers like SDXI_MMIO_CTL2, could the hardware reset asynchronously in
the background and wipe these configurations?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D9

