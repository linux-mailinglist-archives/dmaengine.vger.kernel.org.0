Return-Path: <dmaengine+bounces-11248-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gunSCYFmI2oLswEAu9opvQ
	(envelope-from <dmaengine+bounces-11248-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:14:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D5964BF91
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:14:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PM6c6jqC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11248-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11248-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CF71301816B
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5183413DBA0;
	Sat,  6 Jun 2026 00:14:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5F15B0EC;
	Sat,  6 Jun 2026 00:14:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704890; cv=none; b=qfz5TwiwF3wxkCQVclducI3PmSqnKUi94BiAFKUmShkTQHHNPaQCcltyHLFNr0wXMvYfSE5D4kJnztoP6aVRU/gHP9IapS8D8ipXdCqd76ZgyBXatBbXKb226ekDoh/U7PZLoOzxjTPLBNEE2AYJiISTxfGSM4TFMFYmWSWNjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704890; c=relaxed/simple;
	bh=t0IauUg8kB2iDPSnoBPIZqOu+qXxl9jycsJ3HuizefQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pUFsH1QyLkUyaT6V3XID4O2UL51jiPJrR0pxNPkJOGiyaGT/v3PykxHQAOrZR2LXWq8ltVK0rzK7CbQsCY8kDA1c7EbMLgtJBEGfApNGxRBXuBhu+Twj3p6T4MypN3QMbaOfRZ4f8t8UtoOG0HGAARZ95EnWORB9/zO1fOOONEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM6c6jqC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4DA1F00893;
	Sat,  6 Jun 2026 00:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704889;
	bh=L43s+VNnk66ZaNytrUxMq2EQbL6RGz3Zh0Z3IAK1a2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PM6c6jqCm9AJHBUEbpRdIV8Ap6m5eV6dQnWRSTrZVunA5hLfvpoG4MIyVzjgNQACU
	 plks/7EW8t5KqRP1ngriDL5Qj6mJJz4+4VOi1j2ye+dnXH+Cme7jT8xz744K4NyFXe
	 bNvfGPtnNjRgAk4QxN4HbmUrhQ4WQzPgmgaki8MBKRPKKkdIpL6V+hzpLEFKcfIhZ8
	 MsopXvn3IQCC1ptR1KsBPQiQH724bcr7l30UwM+Wr7rCBfIxLIosuGwLf7m5TPGMHe
	 5DUZ/mqEx0NCShZIEK56n1LC20+GDGmbAIXd6EnyyyjXsdY05xQy/uZ9+7IJq1Lvt5
	 3666w5b1Pp0xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/23] dmaengine: sdxi: Start functions on probe,
 stop on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-9-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-9-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:14:48 +0000
Message-Id: <20260606001448.CC4DA1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-11248-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24D5964BF91

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Device continues DMA into freed memory if activation fails during =
probe or if soft-stop times out during driver removal.
- [High] Missing `pci_free_irq_vectors()` in the device remove callback and=
 error paths leaks IRQ resources.

Pre-existing issues:
- [High] Missing switch case in `sdxi_dev_stop()` for `SDXI_GSV_STOP` cause=
s a race condition and spurious reset.
--

commit fce324da74dfb9a79bfe266368af63dc843a0386
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Start functions on probe, stop on remove

This commit drives each SDXI function to the active state during probe by
writing to the GSR register and polling for the GSV_ACTIVE state. It also
introduces an unregister function to stop the device during driver removal.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 4d595e79b8ce5..e8f087f758fde 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c

[ ... ]

> +static int sdxi_dev_start(struct sdxi_dev *sdxi)
> +{
> +	enum sdxi_fn_gsv status =3D sdxi_dev_gsv(sdxi);
> +	int ret;

[ ... ]

> +	sdxi_write_fn_gsr(sdxi, SDXI_GSRV_ACTIVE);
> +
> +	ret =3D sdxi_dev_gsv_poll(sdxi, status,
> +				status =3D=3D SDXI_GSV_ACTIVE ||
> +				status =3D=3D SDXI_GSV_ERROR);
> +	if (ret) {
> +		dev_err(sdxi->dev, "activation timed out, current state: %s\n",
> +			gsv_str(status));
> +		return ret;
> +	}

[Severity: High]
Is there a risk of DMA use-after-free here?

If the device fails to reach the ACTIVE state within the timeout, this retu=
rns
-ETIMEDOUT without forcing the device to a hard stop or reset.

Since the error propagates up and causes the probe to fail, devres will
subsequently free DMA-mapped memory such as the L1 and L2 tables. If the
hardware state machine is still running and eventually activates, could it
continue to perform DMA into the freed memory?

[ ... ]

> @@ -290,6 +330,14 @@ int sdxi_register(struct device *dev, const struct s=
dxi_bus_ops *ops)
>  }
>  EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
> =20
> +void sdxi_unregister(struct device *dev)
> +{
> +	struct sdxi_dev *sdxi =3D dev_get_drvdata(dev);
> +
> +	sdxi_dev_stop(sdxi);
> +}

[Severity: High]
Does this safely handle a timeout during stop?

Since the return value of sdxi_dev_stop() is ignored, the unbind process
will continue and free memory even if the hardware refused to stop. This
seems like it could also allow the device to continue DMA into freed memory.

[Severity: High]
This is a pre-existing issue, but looking at sdxi_dev_stop() itself, could
the missing SDXI_GSV_STOP case cause a spurious reset?

If sdxi_dev_stop() is called when the device is already in the STOP state:

drivers/dma/sdxi/device.c:sdxi_dev_stop() {
    ...
    switch (status) {
    case SDXI_GSV_INIT:
    case SDXI_GSV_ACTIVE:
        sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_SF);
        break;
    default:
        /* Unrecognized state; try a reset. */
        sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
        break;
    }

    /* Wait for transition to either stop or error state. */
    ret =3D sdxi_dev_gsv_poll(sdxi, status,
                            status =3D=3D SDXI_GSV_STOP ||
                            status =3D=3D SDXI_GSV_ERROR);
    ...
}

The status falls through to the default case, writing SDXI_GSRV_RESET to the
hardware. The read_poll_timeout() then immediately reads the STOP state
(before the asynchronous reset takes effect) and returns success.

Could the subsequent initialization steps then execute concurrently with the
hardware reset, causing undefined device behavior?

> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> index 42e8af008b100..4d7d6812da6d8 100644
> --- a/drivers/dma/sdxi/pci.c
> +++ b/drivers/dma/sdxi/pci.c

[ ... ]

> +static void sdxi_pci_remove(struct pci_dev *pdev)
> +{
> +	pci_disable_sriov(pdev);
> +	sdxi_unregister(&pdev->dev);
> +}

[Severity: High]
Does this leak the IRQ vectors allocated during probe?

The driver allocates IRQ vectors using pci_alloc_irq_vectors() in
sdxi_pci_init(), but this remove callback completes without calling
pci_free_irq_vectors().

Similarly, if sdxi_device_init() fails in sdxi_register(), the error is
returned directly without freeing the IRQ vectors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D9

