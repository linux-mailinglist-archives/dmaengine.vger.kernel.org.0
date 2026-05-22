Return-Path: <dmaengine+bounces-10770-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNJnDonHEGoudgYAu9opvQ
	(envelope-from <dmaengine+bounces-10770-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 23:15:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D065BA492
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 23:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7880300868D
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 21:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CD51A683D;
	Fri, 22 May 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxAzgjUY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1583438AA;
	Fri, 22 May 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484546; cv=none; b=L3QUx9cgKzrU7BYlPpiGBMRiQwPMunAuqMG/kQ6VlrKM8PDBamJyh9niEL8dddfwSFpMQ4oyCNvawq37bRnuX3Zwyto0Gppf0VNwk1xKvnggOdNDsuVlNka9MF2bNLCtg8vPFwCH0luVZURF5kTl2l2vKkc6IAF3+YHog6SgC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484546; c=relaxed/simple;
	bh=X+gL7KPKv0P/JUhnSZQWsqu4blH1zFFHId/MZ3M33NM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IdEtQuY770gjBgWRPLcTsqGOMAKFF/AtsEn6x3Y2cmd9TFCb5HylQPmA3rx6WMzzeJ037pSQ7rbnHMEbhcXB3VzaRgQxWw7ERrTEl70PtVKu3dGMleKPkRnWq95mi8bChUY9vwxQ2su7EdhslM9WfQ7t3gpYtAE6hnEe0/Ka6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxAzgjUY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BA01F000E9;
	Fri, 22 May 2026 21:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779484545;
	bh=aIVmAckaSAoOeKSIutRlnIIswMal50UXMa4lqth91WI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxAzgjUYanK0+IJNgHrJh9Xj6tciUxOQaV2TIit0REKRIH7aTUdJOGDwxETS7KptK
	 h9cyXxNPPf8Tr4pq5PXWPfI0PM7t7DeOrs0dhF4XLx3gOY0CIjhdUuPnVGkXDrHdaw
	 UMUOl9ogYrrSS8MScEkzzIid2YCL4uMgu+ovjDF7Am8dbqu1abQ/lnRQaE241WVpDv
	 1b9qFWixxefrNTmygb0EfuwMOCP3kR0OfwJUkaAs4+N8SFCP0uZq0M1VOyhj98EdP3
	 ZHj4znlXuhVGgQE7HyrVoGZ7SJ8tnirJiiBAyoQR1eztWtWYs/iz2Zq+iS4pqOJMSc
	 O/vjFwdHO03bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] i2c: imx-lpi2c: use dmaengine_prep_submit() to
 simple code
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260522-dma_prep_submit-v2-2-7a87a5a29525@nxp.com>
References: <20260522-dma_prep_submit-v2-2-7a87a5a29525@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 21:15:44 +0000
Message-Id: <20260522211545.02BA01F000E9@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10770-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,nxp.com:email,lists.linux.dev:replyto,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 35D065BA492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete implementation of the refactoring pattern intended by=
 the commit.
- [Low] The fallback declaration for `dmaengine_prep_submit_slave_single` c=
ontains semicolons instead of commas, breaking the build when CONFIG_DMA_EN=
GINE is disabled.

Pre-existing issues:
- [Critical] A critical double free vulnerability can occur on `dma->rx_cmd=
_buf` in the error handling path of `lpi2c_imx_dma_xfer()`.
- [High] DMA channels requested during probe are never released on device r=
emoval or on a subsequent probe failure.
--

commit c9c1ee53a58bc638a612c603e4f9002874839ea5
Author: Frank Li <Frank.Li@nxp.com>

i2c: imx-lpi2c: use dmaengine_prep_submit() to simple code
   =20
Use dmaengine_prep_submit() to simple code. No functional change.

> Use dmaengine_prep_submit() to simple code. No functional change.

[Severity: Medium]
Is the refactoring incomplete here? The commit message states it simplifies=
 the
code by using dmaengine_prep_submit(), but it only updates
lpi2c_dma_rx_cmd_submit().

An identical DMA preparation sequence exists just below it in lpi2c_dma_sub=
mit(),
which continues to manually call dmaengine_prep_slave_single() and
dmaengine_submit(). Should lpi2c_dma_submit() be updated as well for
consistency?

> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-=
imx-lpi2c.c
> index 2a0962a0b4417..c90f72eec8498 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -733,15 +732,11 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx=
_struct *lpi2c_imx)
>  		return -EINVAL;
>  	}
> =20
> -	rx_cmd_desc =3D dmaengine_prep_slave_single(txchan, dma->dma_tx_addr,
> -						  dma->rx_cmd_buf_len, DMA_MEM_TO_DEV,
> -						  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> -	if (!rx_cmd_desc) {
> -		dev_err(&lpi2c_imx->adapter.dev, "DMA prep slave sg failed, use pio\n"=
);
> -		goto desc_prepare_err_exit;
> -	}
> -
> -	cookie =3D dmaengine_submit(rx_cmd_desc);
> +	cookie =3D dmaengine_prep_submit_slave_single(txchan, NULL, NULL,
> +						    dma->dma_tx_addr,
> +						    dma->rx_cmd_buf_len,
> +						    DMA_MEM_TO_DEV,
> +						    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);

[Severity: Low]
Will this break the build when CONFIG_DMA_ENGINE is disabled?

In include/linux/dmaengine.h, the !CONFIG_DMA_ENGINE stub for
dmaengine_prep_submit_slave_single() contains semicolons instead of commas:

static inline dma_cookie_t
dmaengine_prep_submit_slave_single(struct dma_chan *chan,
				   dma_async_tx_callback cb, void *cb_param;
				   dma_addr_t buf, size_t len,
				   enum dma_transfer_direction dir,
				   unsigned long flags);
{
	return -ENODEV;
}

This syntax error will cause a compilation failure for any driver calling it
when CONFIG_DMA_ENGINE is not set.

>  	if (dma_submit_error(cookie)) {
>  		dev_err(&lpi2c_imx->adapter.dev, "submitting DMA failed, use pio\n");
>  		goto submit_err_exit;

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but could this result in a double
free on dma->rx_cmd_buf in the error handling path of lpi2c_imx_dma_xfer()?

When a read transfer (I2C_M_RD) finishes, dma->rx_cmd_buf is freed at the
disable_dma label:

	if (dma->dma_msg_flag & I2C_M_RD)
		kfree(dma->rx_cmd_buf);

However, the pointer is not set to NULL. If a subsequent read transfer fails
early (e.g., if lpi2c_dma_config() or lpi2c_dma_submit() fails), the code j=
umps
to disable_dma before lpi2c_imx_alloc_rx_cmd_buf() can allocate a new buffe=
r.

Since dma->dma_msg_flag & I2C_M_RD is true, wouldn't kfree() be called a se=
cond
time on the dangling pointer from the previous transfer?

[Severity: High]
This is a pre-existing issue, but are the DMA channels requested during pro=
be
leaking on device removal or probe failure?

In lpi2c_dma_init(), the "tx" and "rx" DMA channels are acquired using the
non-managed dma_request_chan() API. However, the driver's remove function
lpi2c_imx_remove() does not call dma_release_channel() to free them.

Furthermore, if i2c_add_adapter() fails during lpi2c_imx_probe(), the error=
 path
(rpm_disable) fails to release the DMA channels that were successfully acqu=
ired
moments earlier. Should these paths be updated to release the channels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-dma_prep_s=
ubmit-v2-0-7a87a5a29525@nxp.com?part=3D2

