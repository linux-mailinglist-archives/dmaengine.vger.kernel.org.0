Return-Path: <dmaengine+bounces-12205-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id paBPJyatT2pSmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12205-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:16:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F5C732158
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:16:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ea30xJTp;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12205-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12205-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B327431C90FF
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD5232FA30;
	Thu,  9 Jul 2026 14:03:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5EA32694E
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:03:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605788; cv=none; b=PQvpPvkwm8LKTHNxGa6anKDZQcDOQfILLGFSuLzVevcmUn0UbsElvqQf88vGwWiNcJq+fucf1c6LUyI4fCkcQQ9dluajR8VfwLBvriSpQkA/s/Oe4a9nN/QkzMa+IK2HQ2KZjp8V5IniAo8ZfLlCp7EM9y+X7/bb3SnqzBes9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605788; c=relaxed/simple;
	bh=d62WO9UTYcPd2TL0LG/Bi6Xv4tLHh/YgpWmOEOnM00I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WX4MqMzYmWdXVT4H8JZoEO8pAuisPRCxckNnvpE3wiwn2qOqDqZpfMgm82sdihCTbVAd/bk6q4aaJ8QO0ESpd+EVieAYdnmgun/TCcCydpkAXMAhwj4YF8PnXnhImaPZDL2o16QebDgdt26WdSJhmHd8gYBAaaKZDZfgCtcpDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea30xJTp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DB61F000E9;
	Thu,  9 Jul 2026 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605786;
	bh=qa+ByBYEJSQ3kB0ojOwE9VS8JVTusSVrvSQBLBiuULw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ea30xJTpWLhbYGBHXe6vVTQ2TFlgAk6fUMYVKDwMWa+MKcwHxHwslyvHDlhM/u8dF
	 G/Q6bVOhCfCbVetc4WP48MTeu6vHKCF4qLNkFpvUwsqJiFf7aq1IAe4vvwuzt0gkXe
	 vtLVRajlck4N/yKPmNMnQ7qBeSY/IvYlkgIbILjJueXPiOYA2yq49quPkRRSEsdDW3
	 CSW6JpIeKGkFnuAC9c/imZKGKliwfMkja1JPf+AOZWeRANOKGbDDyyGBxiemqaDr5L
	 VbTxf5n+JprbrvKjZr8QQ1S2G4MNqTsrdulHeaMssgzlJ7kHvGiMYiqBufiX+sVOR/
	 INiOoMC+mm9fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] dmaengine: qcom-gpi: Keep GPI interrupt active
 during system resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh Kumar Savaliya" <mukesh.savaliya@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260709134623.1724212-3-mukesh.savaliya@oss.qualcomm.com>
References: <20260709134623.1724212-1-mukesh.savaliya@oss.qualcomm.com>
 <20260709134623.1724212-3-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:03:05 +0000
Message-Id: <20260709140306.48DB61F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12205-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mukesh.savaliya@oss.qualcomm.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6F5C732158

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Adding IRQF_NO_SUSPEND leaves the interrupt unmasked during system=
 sleep, causing fatal unclocked register accesses.
- [Low] The IRQF_EARLY_RESUME flag is functionally dead code and redundant =
when combined with IRQF_NO_SUSPEND.

Pre-existing issues:
- [High] A 3-way AB-BA deadlock occurs because gpi_ev_tasklet() acquires a =
read lock on pm_lock with local hardware interrupts enabled.
- [High] The error cleanup paths in gpi_ch_init() operate on the wrong chan=
nel pointer, causing leaks and multiple resets of the same channel.
- [High] Unregistered DMA device on the probe error path leads to a Use-Aft=
er-Free and global list corruption.
- [High] tasklet_kill is called while the interrupt is still unmasked and e=
nabled, risking a Use-After-Free on the event ring.
- [High] The interrupt handler returns IRQ_HANDLED when bailing out due to =
an invalid PM state, causing a permanent interrupt storm.
--

--- Patch [2]: [PATCH v7 2/2] dmaengine: qcom-gpi: Keep GPI interrupt activ=
e during system resume ---
commit a7024226a78be6fe1a44f0ec7dd85e67623b43ab
Author: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

dmaengine: qcom-gpi: Keep GPI interrupt active during system resume

GPI DMA clients may initiate transfers during the early stages of
system resume before the normal IRQ resume phase has completed.
Request the GPI interrupt with IRQF_NO_SUSPEND and IRQF_EARLY_RESUME
to keep it available across suspend/resume transitions.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index a5055a6273af6..29872b6cb2c75 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -615,7 +615,8 @@ static int gpi_config_interrupts(struct gpii *gpii, e=
num gpii_irq_settings setti
> =20
>  	if (!gpii->configured_irq) {
>  		ret =3D devm_request_irq(gpii->gpi_dev->dev, gpii->irq,
> -				       gpi_handle_irq, IRQF_TRIGGER_HIGH,
> +				       gpi_handle_irq,
> +				       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND | IRQF_EARLY_RESUME,

[Severity: High]
Adding IRQF_NO_SUSPEND prevents the DMA interrupt from being masked by the
core IRQ subsystem during system suspend. Does this allow spurious or
delayed hardware interrupts to trigger while consumer driver hardware clocks
are disabled via runtime PM?

Looking at gpi_handle_irq(), the pm_state check may remain in ACTIVE_STATE
or PAUSE_STATE during suspend:

drivers/dma/qcom/gpi.c:gpi_handle_irq() {
    if (!REG_ACCESS_VALID(gpii->pm_state)) {
    ...
}

If this check passes while clocks are off, will the subsequent register
reads cause a synchronous external abort and crash the kernel?

[Severity: Low]
Is IRQF_EARLY_RESUME redundant here? When combined with IRQF_NO_SUSPEND,
IRQS_SUSPENDED is never set on the interrupt descriptor during
suspend_device_irqs(). This means resume_irq() won't do anything for this
interrupt during the early resume phase, making the flag functionally dead
code.

>  				       "gpi-dma", gpii);
>  		if (ret < 0) {

[ ... ]

[Severity: High]
This is a pre-existing issue, but can a 3-way AB-BA deadlock occur with
pm_lock?

gpi_ev_tasklet() running in softirq acquires a read lock on pm_lock without
disabling local hardware interrupts:

drivers/dma/qcom/gpi.c:gpi_ev_tasklet() {
    ...
    read_lock(&gpii->pm_lock);
    ...
}

A concurrent thread calls write_lock_irq():

drivers/dma/qcom/gpi.c:gpi_resume() {
    ...
    write_lock_irq(&gpii->pm_lock);
    ...
}

Due to fair rwlock semantics, the writer blocks new readers. If a hard
interrupt then fires on the tasklet's CPU, gpi_handle_irq() preempts the
tasklet and acquires the read lock:

drivers/dma/qcom/gpi.c:gpi_handle_irq() {
    ...
    read_lock_irqsave(&gpii->pm_lock, flags);
    ...
}

Will the hardirq reader spin waiting for the writer, while the writer spins
waiting for the preempted tasklet, creating a fatal deadlock?

[Severity: High]
This is a pre-existing issue, but do the error cleanup paths in
gpi_ch_init() operate on the wrong channel pointer?

If channel allocation fails, the error handlers iterate backwards but pass
the function argument gchan instead of the iterated element &gpii->gchan[i]:

drivers/dma/qcom/gpi.c:gpi_ch_init() {
    ...
error_start_chan:
    gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
    ...
error_alloc_chan:
    gpi_reset_chan(gchan, GPI_CH_CMD_DE_ALLOC);
    ...
}

Does this repeatedly reset the same channel while failing to clean up the
newly allocated channels, leaking hardware resources and memory?

[Severity: High]
This is a pre-existing issue, but does gpi_probe() leak the DMA device on
failure?

If of_dma_controller_register() fails, the function returns directly:

drivers/dma/qcom/gpi.c:gpi_probe() {
    ...
    ret =3D of_dma_controller_register(...);
    if (ret)
        return ret;
    ...
}

Since dma_async_device_register() was already called earlier in the probe,
does this leave a dangling pointer in the global dma_device_list when
devres frees the gpi_dev structure?

[Severity: High]
This is a pre-existing issue, but is there a race condition in
gpi_free_chan_resources() that could cause a use-after-free?

The function kills the tasklet before disabling interrupts:

drivers/dma/qcom/gpi.c:gpi_free_chan_resources() {
    ...
    tasklet_kill(&gpii->ev_task);
    ...
    gpi_disable_interrupts(gpii);
    ...
}

If a pending or spurious IEOB interrupt arrives immediately after
tasklet_kill returns, could gpi_handle_irq() reschedule the tasklet,
allowing it to execute concurrently with or after
gpi_free_ring(&gpii->ev_ring, gpii), and access the freed event ring memory?

[Severity: High]
This is a pre-existing issue, but does returning IRQ_HANDLED when bailing
out cause a permanent interrupt storm?

If the pm_state check fails, gpi_handle_irq() jumps to exit_irq:

drivers/dma/qcom/gpi.c:gpi_handle_irq() {
    if (!REG_ACCESS_VALID(gpii->pm_state)) {
        ...
        goto exit_irq;
    }
    ...
exit_irq:
    return IRQ_HANDLED;
}

Since the interrupt is level-triggered, does falsely reporting IRQ_HANDLED
without servicing and clearing the device hardware condition cause the
interrupt controller to immediately re-assert the interrupt to the CPU,
creating an infinite loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709134623.1724=
212-1-mukesh.savaliya@oss.qualcomm.com?part=3D2

