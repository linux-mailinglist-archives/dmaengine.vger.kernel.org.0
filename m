Return-Path: <dmaengine+bounces-10844-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBJRDdUHFGq6JAcAu9opvQ
	(envelope-from <dmaengine+bounces-10844-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:27:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975255C7BBF
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70757301650A
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B23E16AC;
	Mon, 25 May 2026 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS1cyDKS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0C3D5C1E
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697293; cv=none; b=kPKUvi4BTQULC2NP+4WzUgYcoAJtApe3pbGjuyYPoSVaBVSGjIuNqBspOOBS20WbCWJTBBM/U9XAiz/10+7pvEScDAgska83SR69Bvt6L8XxAYN24MLI6WcLL9k4yJvP8v7ujUmU+CIcRtFdhcRACirdGJopTxjbLq3kucby9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697293; c=relaxed/simple;
	bh=Rf1y8S8qiHYgKFrQO8IXEwXY+k7j4oNn25UqG2ROCCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jfbdYO6C6+fE89jQ/G8OdgzX82vqH+pbiLtk8zAibwMGYQgE4kQL8YVWHwQxOaNOiBxR8B03FZzWGdBGF2u0Ku18ai3Bot+MCkLPm/kFYLjL8F9BYbBYxFtUKvPRLi/5Qvy9GgHsZT2PMy4WSStgX9uo6r6igiG9PLIX5ZsZt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS1cyDKS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5225D1F00A3E;
	Mon, 25 May 2026 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779697292;
	bh=xhnu233xTX+La//xO3qPT5M8ENAMwY8eJtgOVTWhRao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lS1cyDKSXbnKtWdYytid3IFm5vzAHGwvEAVyTRfItRKIzx/SwPPoU/dVGPpf6MvEN
	 wdKnlrxTMWSLwXiMLc+vl0AwVcA/Ob0qrzW+xX0poIJDn1hhQBuyZgEj40txzw4/uv
	 1OHB5O/zOZMEzw+swYBVvhEf1Dqo1UmwAbpECtu+LcWxu+ce09iThPKshTe2S/u2Gn
	 6JbO/TZKOldnJwtQESVEFm9nIvnkaG1j8PjRmMlAUfVZkSE+4YZJ2uFKmy4nNHCsvI
	 wfar6Uu5GQrA3v3DrI8Vc7WiHndzuGMfbbPxwvCZN549b1XTT6Qa2KMygdxJklyqvG
	 LpaBpzEroBYAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: dw-axi-dmac: fix PM for system sleep
 and channel alloc
Reply-To: sashiko-reviews@lists.linux.dev
To: tze.yee.ng@altera.com
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <18bf778a3a1cc2f377ef8eb0d1508d8ac6371896.1779688569.git.tze.yee.ng@altera.com>
References: <18bf778a3a1cc2f377ef8eb0d1508d8ac6371896.1779688569.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 08:21:32 +0000
Message-Id: <20260525082132.5225D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10844-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url,altera.com:email]
X-Rspamd-Queue-Id: 975255C7BBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware is forcefully powered down in `dw_remove()` while the dev=
m-managed DMA engine is still registered and actively exposing channels to =
clients.
- [High] `dw_remove()` leaks clock references if the device is in an active=
 Runtime PM state.
- [High] `axi_dma_resume()` leaks the `cfgr_clk` reference if `core_clk` fa=
ils to enable.
- [High] The runtime suspend callback `axi_dma_suspend()` does not call `sy=
nchronize_irq()` before disabling hardware clocks.
- [High] The shared interrupt handler `dw_axi_dma_interrupt()` accesses har=
dware registers without ensuring the device is runtime active.
- [High] An asynchronous `pm_runtime_put()` is used before jumping to an er=
ror handling path that immediately calls `pm_runtime_disable()`, causing a =
race condition in `dw_probe()`.
- [High] The function `axi_req_irqs()` writes to the fixed-size `chip->irq`=
 array without validating that `irq_count` does not exceed the array bounds.
- [Low] The `dw_axi_dma_pm_ops` structure is assigned unconditionally to th=
e driver's `.pm` pointer without using the `pm_ptr()` wrapper macro.
--

commit 80df1f731d96db5786b01419f199171e1d6714a5
Author: Tze Yee Ng <tze.yee.ng@altera.com>

dmaengine: dw-axi-dmac: fix PM for system sleep and channel alloc

The driver only had runtime PM callbacks. If a channel stayed allocated
across system suspend/resume, the runtime usage count could remain
non-zero while hardware state (DMAC_CFG, clocks) was lost, and
axi_dma_runtime_resume() would not run to restore it. This commit adds
system-sleep PM ops to reuse suspend/resume paths and replaces
pm_runtime_get() with pm_runtime_resume_and_get().

> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c
> index f7a50f470461c..bcefaff03b5c6 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c

[ ... ]

> @@ -1663,6 +1668,8 @@ static void dw_remove(struct platform_device *pdev)
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does dw_remove() forcefully
power down hardware while the devm-managed DMA engine is still registered a=
nd
actively exposing channels to clients?

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dw_remove() {
	...
	axi_dma_disable(chip);
	pm_runtime_disable(chip->dev);
	axi_dma_suspend(chip);
	...
}

The driver uses dmaenginem_async_device_register() to register the DMA engi=
ne,
relying on devres for unregistration, which executes strictly after the
remove() function returns.

During the window between this hardware shutdown and the delayed devres
unregistration, the DMA engine is still fully registered.  Could a client
that allocates a channel or submits a transfer during this time access
powered-off hardware, causing faults or synchronous aborts?


[Severity: High]
This is a pre-existing issue, but does dw_remove() leak clock references if
the device is in an active Runtime PM state?

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dw_remove() {
	...
	clk_prepare_enable(chip->cfgr_clk);
	clk_prepare_enable(chip->core_clk);
	...
	pm_runtime_disable(chip->dev);
	axi_dma_suspend(chip);
	...
}

If the device is runtime-active when dw_remove() is invoked, its clocks are
already enabled.  dw_remove() unconditionally calls clk_prepare_enable() for
both clocks, then disables Runtime PM via pm_runtime_disable(), and finally
calls axi_dma_suspend() to disable the clocks.

Because pm_runtime_disable() prevents any further PM transitions, could the
runtime suspend callback be prevented from running and dropping the remaini=
ng
usage count, resulting in a permanent clock leak on unbind?

> =20
>  static const struct dev_pm_ops dw_axi_dma_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  	SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NUL=
L)
>  };

[Severity: Low]
This is a pre-existing issue, but is the dw_axi_dma_pm_ops structure assign=
ed
unconditionally to the driver's .pm pointer without using the pm_ptr()
wrapper macro?

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:
static struct platform_driver dw_driver =3D {
	...
	.driver =3D {
		...
		.pm =3D &dw_axi_dma_pm_ops,
	},
};

Could this produce dead code or compiler warnings when PM support is disabl=
ed?


[Severity: High]
This isn't a bug introduced by this patch, but does axi_dma_resume() leak
the cfgr_clk reference if core_clk fails to enable?

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:axi_dma_resume() {
	ret =3D clk_prepare_enable(chip->cfgr_clk);
	if (ret < 0)
		return ret;

	ret =3D clk_prepare_enable(chip->core_clk);
	if (ret < 0)
		return ret;
	...
}

If clk_prepare_enable(chip->core_clk) fails, the function immediately retur=
ns
the error code.  Should it call clk_disable_unprepare(chip->cfgr_clk) to
clean up the successfully enabled clock?


[Severity: High]
This is a pre-existing issue, but does the runtime suspend callback
axi_dma_suspend() fail to call synchronize_irq() before disabling hardware
clocks?

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:axi_dma_suspend() {
	axi_dma_irq_disable(chip);
	axi_dma_disable(chip);

	clk_disable_unprepare(chip->core_clk);
	clk_disable_unprepare(chip->cfgr_clk);
	...
}

The driver requests its interrupt with the IRQF_SHARED flag.  Could failing=
 to
call synchronize_irq() prior to powering down hardware introduce a race
condition where the interrupt handler might execute mid-flight on another C=
PU,
leading to invalid register accesses and bus faults?


[Severity: High]
This isn't a bug introduced by this patch, but does the shared interrupt
handler dw_axi_dma_interrupt() access hardware registers without ensuring
the device is runtime active?

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dw_axi_dma_interrupt() {
	...
	axi_dma_irq_disable(chip);
	...
}

Because the driver uses IRQF_SHARED, its interrupt handler can be triggered
when another device on the same shared line asserts an interrupt.

Should the handler check pm_runtime_get_if_active() before accessing MMIO
registers to avoid a precise external abort or system crash if the DMA
controller is runtime-suspended and its clocks are disabled?


[Severity: High]
This is a pre-existing issue, but is an asynchronous pm_runtime_put() used
before jumping to an error handling path that immediately calls
pm_runtime_disable(), causing a race condition in dw_probe()?

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dw_probe() {
	...
	pm_runtime_put(chip->dev);

	ret =3D dmaenginem_async_device_register(&dw->dma);
	if (ret)
		goto err_pm_disable;
	...
err_pm_disable:
	pm_runtime_disable(chip->dev);
	return ret;
}

If dmaenginem_async_device_register() fails, pm_runtime_disable() cancels
the pending async idle/suspend work.  Does this permanently leave the hardw=
are
in an incorrect active power state and leak the clock resources?

Should a synchronous pm_runtime_put_sync() be used instead?


[Severity: High]
This isn't a bug introduced by this patch, but does the function
axi_req_irqs() write to the fixed-size chip->irq array without validating
that irq_count does not exceed the array bounds?

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:axi_req_irqs() {
	int irq_count =3D platform_irq_count(pdev);
	int ret;

	for (int i =3D 0; i < irq_count; i++) {
		chip->irq[i] =3D platform_get_irq(pdev, i);
		...
	}
	...
}

The chip->irq array is statically allocated with a size of DMAC_MAX_CHANNELS
(32).  If a misconfigured device tree specifies more than 32 interrupts, co=
uld
this loop write beyond the array boundaries, corrupting adjacent members in
struct axi_dma_chip and leading to arbitrary memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779688569.gi=
t.tze.yee.ng@altera.com?part=3D2

