Return-Path: <dmaengine+bounces-11763-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EZSXEkKNO2quZggAu9opvQ
	(envelope-from <dmaengine+bounces-11763-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 09:54:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A74556BC5CB
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 09:54:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lDMBBsRS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11763-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11763-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B39B6301C912
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CACC346AF1;
	Wed, 24 Jun 2026 07:54:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF252388E5A
	for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2026 07:54:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287680; cv=none; b=GH28on1EDFCtqGRlD0VeIsEui34VZgocrtLSAWHWoxV54c2L5RhIuZ/LgohC3C+0hKsuScZ0mPvRPri0pS5OJOtnKQ/D7/tVMRTG7/nqJUSg9irB9OAsm9+oppe47wDZb6d65FhiAlTFDDXkJnJcgt+xK+R37M7yCbz3p3d4tfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287680; c=relaxed/simple;
	bh=gCaw4nr9N8PpzvFM4SRjmGJYGtPXB25fPwKirubzEOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uzcDHQMV/3YvDFfLpUy5dJU+foKEDu0ia0g7ruZVQU04SFjC+apm/PR22nzhNIwDampK5OEEG4f5m2Kkt4LVstTQx0r82GCseIKx9ySu75IlZhdb/uH59cdXOd8TyNR8YsZc7iPqfbR1o2XeQlhkNxY9xWIsMlsTeO6LkvcP39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDMBBsRS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC121F000E9;
	Wed, 24 Jun 2026 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782287678;
	bh=cHc63+YhoU6e3yZ8UntU4/eGLjCKZRBAKvXJkMn590E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lDMBBsRS/3eKO581vPcYvdHrDtl9rLgfML3/8dVuG/sQu7IlFJfBafJlgXE6ezF5L
	 pxzLdQr+pGoYGemJ0LxMSnLm76kmBQpYeic1+YcGmv4PIKz3b0kPBik1hVraL/O5Mw
	 +g4JguqmleiksRmhwi6JntVinvOlbW3l23PDM43kJWR4upcFmDOjimzq1x8sxAyqF/
	 FZoB0bgBIIMN0yiyZo5AjTOUI07TTH+dAgNUkD2pChSNrUPGYpexU1WT3RGUgF0/xi
	 M8uylX4RAm0SuoquU86EOBeo35yKW/IVfX9yk1xUQ6qA/Bgmo3Jpy8Wfb9t9yK37l2
	 Tn1c0A3om8BcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Fix cfgr_clk leak in resume
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260624074307.68365-1-mhun512@gmail.com>
References: <20260624074307.68365-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 07:54:37 +0000
Message-Id: <20260624075438.0FC121F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11763-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A74556BC5CB

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `synchronize_irq()` in runtime suspend callback with share=
d IRQ.
- [High] Shared IRQ handler accesses hardware registers without checking ru=
ntime PM state.
- [High] Missing `pm_runtime_set_active()` in probe leaves the device in an=
 out-of-sync `RPM_SUSPENDED` state, causing a permanent clock leak.
- [High] Shared IRQ is requested before the device clocks are enabled, lead=
ing to potential crashes.
- [High] Hardware registers are accessed before runtime PM resume, and asyn=
chronous PM get is used during channel allocation.
--

commit cf365d7df99aa900a547c9c8fd173c3cf21aa48a
Author: Myeonghun Pak <mhun512@gmail.com>

dmaengine: dw-axi-dmac: Fix cfgr_clk leak in resume error path

This commit fixes a clock leak in axi_dma_resume(). If core_clk fails to
enable, the function now properly disables cfgr_clk before returning an
error.

> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c
> index 4d53f077e9d25..6356a52056f38 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1333,12 +1333,17 @@ static int axi_dma_resume(struct axi_dma_chip *ch=
ip)
> =20
>  	ret =3D clk_prepare_enable(chip->core_clk);
>  	if (ret < 0)
> -		return ret;
> +		goto err_disable_cfgr_clk;
> =20
>  	axi_dma_enable(chip);
>  	axi_dma_irq_enable(chip);
> =20
>  	return 0;
> +
> +err_disable_cfgr_clk:
> +	clk_disable_unprepare(chip->cfgr_clk);
> +
> +	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
with how axi_dma_resume() is called during driver probe:

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dw_probe() {
    ...
	pm_runtime_enable(chip->dev);

	pm_runtime_get_noresume(chip->dev);
	ret =3D axi_dma_resume(chip);
	if (ret < 0)
		goto err_pm_disable;

	axi_dma_hw_init(chip);

	pm_runtime_put(chip->dev);
    ...
}

Does this sequence leave the device in an out-of-sync suspended state?

Since pm_runtime_set_active() is not called before pm_runtime_enable(), the
runtime PM state remains at its default suspended state. When
pm_runtime_put() is called, it might complete without invoking the runtime
suspend callback, which could cause a permanent clock leak.

[Severity: High]
This is a pre-existing issue, but there appears to be a race condition when
requesting the shared IRQ early in probe:

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dw_probe() {
    ...
	ret =3D axi_req_irqs(pdev, chip);
	if (ret)
		return ret;

	INIT_LIST_HEAD(&dw->dma.channels);
	for (i =3D 0; i < hdata->nr_channels; i++) {
        ...
	pm_runtime_get_noresume(chip->dev);
	ret =3D axi_dma_resume(chip);
    ...
}

If another device shares the same IRQ line and has a pending interrupt, cou=
ld
dw_axi_dma_interrupt() execute immediately after axi_req_irqs() but before
axi_dma_resume() enables the hardware clocks?

If so, the IRQ handler might access unclocked hardware and cause a crash.

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential issue =
in
the IRQ handler itself:

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dw_axi_dma_interrupt() {
	struct axi_dma_chip *chip =3D dev_id;
    ...
	/* Disable DMAC interrupts. We'll enable them after processing channels */
	axi_dma_irq_disable(chip);
    ...
}

If the device is suspended and its clocks are disabled, and a shared IRQ
fires from another device, does this unconditionally access the unclocked
register in axi_dma_irq_disable() without checking the runtime PM state?

Would it be better to use pm_runtime_get_if_active() here before accessing
the hardware registers?

[Severity: High]
This is a pre-existing issue, but I see a missing synchronize_irq() in the
suspend path:

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:axi_dma_suspend() {
	axi_dma_irq_disable(chip);
	axi_dma_disable(chip);

	clk_disable_unprepare(chip->core_clk);
	clk_disable_unprepare(chip->cfgr_clk);

	return 0;
}

Since the driver uses a shared IRQ, could the hardware clocks be disabled
here while a shared IRQ handler is executing concurrently on another CPU?

The subsystem guidelines require calling synchronize_irq() for drivers
using shared IRQs before powering down hardware.

[Severity: High]
This isn't a bug introduced by this patch, but hardware registers might be
accessed before runtime PM resume during channel allocation:

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dma_chan_alloc_chan_resource=
s() {
	/* ASSERT: channel is idle */
	if (axi_chan_is_hw_enable(chan)) {
		dev_err(chan2dev(chan), "%s is non-idle!\n",
			axi_chan_name(chan));
		return -EBUSY;
	}
    ...
	pm_runtime_get(chan->chip->dev);
    ...
}

Does axi_chan_is_hw_enable() perform direct hardware reads while the device
might be suspended?

Also, since pm_runtime_get() is asynchronous, will subsequent prep functions
called by the client access hardware while the device is still suspended?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624074307.6836=
5-1-mhun512@gmail.com?part=3D1

