Return-Path: <dmaengine+bounces-10398-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMNyCfTGA2ob+gEAu9opvQ
	(envelope-from <dmaengine+bounces-10398-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 02:33:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A9252B8FE
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 02:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36953304B2D9
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 00:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC518FDBE;
	Wed, 13 May 2026 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQUyi0SD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B416A956;
	Wed, 13 May 2026 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632433; cv=none; b=GuppEm9LLOTuvJydUyjMplFWF8aveGcvw5jYjIA30r6V2bBSD2+aA3nz9bw2fFDiDB1wHfomhawqMerQfCS1K+ji8E7ZPQ+ZUiIq/IIBn9Y2XqjanOgisrowWJ5EX699hvjQ6k7/D2T+cLKmp4dFQm/5Lgv60dINUHGhi98XQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632433; c=relaxed/simple;
	bh=rzqdocAEdSWJhzFLVINqGo1xbNeff/zHALmKudjklVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NGdHAQSCeouPxkm01pSYWz9BtEhqqGgZRk3U/Gn7qgPR0t15ojraCCvjBNgSnFU33FKuQ3bOopqgzfrzajgiF54ywMVM53kKVUZKPHrjHR1I6/tp4IynmEnpPJ2P1HlKE4gPw5sGA6QBkqa7f1H6etIuV1Gxnum80yKCP7XJJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQUyi0SD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDB2C2BCB0;
	Wed, 13 May 2026 00:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778632432;
	bh=rzqdocAEdSWJhzFLVINqGo1xbNeff/zHALmKudjklVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hQUyi0SDHsGlDjsOhG0iLZS97DigC7rF6v9r3PhICs1G5mKokEqXeTxK95qVxQYBZ
	 2hAL2cYC8BcANBsrXvA9t+x1mb0YP3QXYBiG1vFMiN3Hh4pm+4ZTczVJSXgzhunEhu
	 kUMR3mSKWjRERP0G7xnW+AcrpOciHUOXDerBYcbpF92CKqcfmVH8jzPsq3+tVsfPca
	 Vg1RrQjY7+YePbrgHM+EXEdxatQRNR/sRJbJUmWM5NkcBs98W4DwiivP6nY3gPgRk3
	 faaDZpxORy5C+jEU60jarw8hn4ikavQ0xqCOjAyszOUX3TueOiNGz40jj/t7BaJKJD
	 zP0+YpfbZwIEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/23] dmaengine: sdxi: Feature discovery and initial
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-4-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-4-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:33:52 +0000
Message-Id: <20260513003352.8EDB2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 90A9252B8FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10398-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware state machine mismanagement and TOCTOU race during device=
 initialization.
- [Low] Use of 64-bit MMIO accessors without proper fallback causes build f=
ailures on 32-bit architectures.
--

commit 20635a3fda61c4d58fcd763198caf0840128ff21
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Feature discovery and initial configuration

Discover via the capability registers the doorbell region stride, the
maximum supported context ID, the operation groups implemented, and
limits on buffer and control structure sizes. The driver has the
option of writing more conservative limits to the ctl2 register, but
it uses those supplied by the implementation for now.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index b718ce04afa07..f9a9944ad8929 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
[ ... ]
> @@ -5,14 +5,180 @@
> +/* Get the device to the GSV_STOP state. */
> +static int sdxi_dev_stop(struct sdxi_dev *sdxi)
> +{
> +	enum sdxi_fn_gsv status =3D sdxi_dev_gsv(sdxi);
> +	int ret;
> +
> +	dev_dbg(sdxi->dev, "attempting stop, current state: %s\n",
> +		gsv_str(status));
> +
> +	switch (status) {
> +	case SDXI_GSV_INIT:
> +	case SDXI_GSV_ACTIVE:
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_SF);
> +		break;
> +	case SDXI_GSV_STOPG_SF:
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_HD);
> +		break;
> +	case SDXI_GSV_STOPG_HD:
> +	case SDXI_GSV_ERROR:
> +		/*
> +		 * If hard-stopping, there's nothing to do but wait.
> +		 * If in error state, the reset is issued below.
> +		 */
> +		break;
> +	default:
> +		/* Unrecognized state; try a reset. */
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
> +		break;
> +	}

If the device is already in the SDXI_GSV_STOP state, does the switch fall
through to the default case and unintentionally issue a reset?

The subsequent read_poll_timeout() check would then immediately return succ=
ess
because the state evaluates as STOP before the background reset actually be=
gins.
Could this allow the reset to proceed in the background while the driver
continues with initialization, potentially wiping the configuration?

[ ... ]
> +/*
> + * See SDXI 1.0 4.1.8 Activation of the SDXI Function by Software.
> + */
> +static int sdxi_fn_activate(struct sdxi_dev *sdxi)
> +{
> +	u64 version, cap0, cap1, ctl2;
> +	int err;
> +
> +	/*
> +	 * Clear any existing configuration from MMIO_CTL0 and ensure
> +	 * the function is in GSV_STOP state.
> +	 */
> +	sdxi_write64(sdxi, SDXI_MMIO_CTL0, 0);
> +	err =3D sdxi_dev_stop(sdxi);

Does writing 0 to SDXI_MMIO_CTL0 implicitly write SDXI_GSRV_RESET (value 0)
to the FN_GSR command field?

If so, sdxi_dev_stop() might read a stale device state while the hardware is
processing the reset, and overwrite the command field with a conflicting co=
mmand
like SDXI_GSRV_STOP_SF. Can this lead to a hardware state machine conflict?

[ ... ]
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index d4c61ca2f875f..84b87066f438d 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
[ ... ]
> @@ -30,9 +34,24 @@ struct sdxi_dev {
> +static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg=
 reg)
> +{
> +	return ioread64(sdxi->ctrl_regs + reg);
> +}
> +
> +static inline void sdxi_write64(struct sdxi_dev *sdxi, enum sdxi_reg reg=
, u64 val)
> +{
> +	iowrite64(val, sdxi->ctrl_regs + reg);
> +}

Can this cause build failures on 32-bit architectures?

The functions use ioread64() and iowrite64(), which typically rely on readq=
()
and writeq() that are not defined on 32-bit platforms.

Although linux/io-64-nonatomic-lo-hi.h is included at the top of the file,
the code does not use the macros actually provided by that header
(e.g., ioread64_lo_hi()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D4

