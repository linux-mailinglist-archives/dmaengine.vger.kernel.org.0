Return-Path: <dmaengine+bounces-11784-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iUkZDdw9PWoJ0AgAu9opvQ
	(envelope-from <dmaengine+bounces-11784-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 16:40:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B0F6C6C02
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 16:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xs+QvGEp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11784-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11784-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19881308E73F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304633E6396;
	Thu, 25 Jun 2026 14:38:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8637DE85
	for <dmaengine@vger.kernel.org>; Thu, 25 Jun 2026 14:38:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398284; cv=none; b=P/TnbPCRZyI9aYTgBXajNbwM48rrcoxK4ewEHjlFTtevVXpTd20S1qssUWBNh2Rpg+bO4T5otQahN0MM0S/j7xmZtBB1susIlzsIzK15LZopzq0yKB7ncU03y6Nn8o+fcsGyYcQNYbOrFfoB/z1IsFBegI2Vyin+9woV2pYet4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398284; c=relaxed/simple;
	bh=eJWvSbb/UtD3lQbmc7f8XQ+mTvZ9mnMTJqQV9/aviNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TgMXpkP5oZ+2EwsnbR0im2B/1poZYrMjt01eHp68FVyilp+bLCiajZpoj3jEYigD9wsya+7zKFGFS3ltqHRacxbvOWH2190bdbExv+bNdLyV+aO/+J9GjkkzqlMtl8ffkdkoYH2TtURO198AYWVlcqds9+X7Lr1XQb8YFoshx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs+QvGEp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493EC1F000E9;
	Thu, 25 Jun 2026 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782398282;
	bh=DbBqxOGiTHsm3SS1B/nAzS1QkYIS8CHl8H5OXcYZ318=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xs+QvGEpsKYCFVhXp5rC+MUHDj9td7D542v0SaX3mj4/24ljh3dNYYxw4xPCeYDec
	 mxeu1/DdK4yW9M2d5lUMIA4cyGtJDNQSTzBr9ZqASxSYCrhf9MVIIHcwd7MuPMFHvA
	 K3wkZ6oYhOdEffc/jjeQdWlln+hxY2E8MzptwtQbFDbmEQkgeydR5v8wnSJZTiNvMK
	 VSrRLdJ23rt4EgALeXsNk2pNX+2u48O+UQFCCrX1y/lzgvzVbCO+JPtD//MWoxOJe6
	 pv1WiTcyOHN5Ha/5/eg3nOGeSFwwIxB+2kXwcAME8CJrGY3RuPl1vBdjnK63tcTKe6
	 JGcwr7yh3w/ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: qcom: gpi: correct channel name in error
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Masney" <bmasney@redhat.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260625-qcom-gpi-err-fix-v1-1-5ca3f00fe2e3@redhat.com>
References: <20260625-qcom-gpi-err-fix-v1-1-5ca3f00fe2e3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 14:38:01 +0000
Message-Id: <20260625143802.493EC1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11784-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bmasney@redhat.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65B0F6C6C02

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The error path in `gpi_ch_init()` frees the event ring DMA mem=
ory without sending the required hardware deallocation command (`GPI_EV_CMD=
_DEALLOC`), resulting in DMA Use-After-Free.
- [High] The software state machine (`gchan->pm_state`) is not reverted whe=
n `gpi_ch_init()` fails, leading to a double-teardown hardware timeout when=
 the client later releases the successfully allocated sibling channel.
- [High] The event processing tasklet is not killed before freeing the even=
t ring memory in the error path of `gpi_ch_init()`, creating a Use-After-Fr=
ee vulnerability.
--

commit 40116dd1267be01863d674224210915823326daa
Author: Brian Masney <bmasney@redhat.com>

dmaengine: qcom: gpi: correct channel name in error path

This commit fixes an issue where the wrong channel was passed to
gpi_send_cmd() during the error handling path of gpi_ch_init(). Correcting
this resolves command completion timeouts when hardware cleanup occurs.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index a5055a6273af6..3f390b5821abb 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -1965,12 +1965,12 @@ static int gpi_ch_init(struct gchan *gchan)
>  error_start_chan:
>  	for (i =3D i - 1; i >=3D 0; i--) {
>  		gpi_stop_chan(&gpii->gchan[i]);
> -		gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
> +		gpi_send_cmd(gpii, &gpii->gchan[i], GPI_CH_CMD_RESET);
>  	}
>  	i =3D 2;
>  error_alloc_chan:
>  	for (i =3D i - 1; i >=3D 0; i--)
> -		gpi_reset_chan(gchan, GPI_CH_CMD_DE_ALLOC);
> +		gpi_reset_chan(&gpii->gchan[i], GPI_CH_CMD_DE_ALLOC);

[Severity: High]
This is a pre-existing issue, but could this error path leave the software
pm_state in an incorrect state?

If gpi_ch_init() fails, the hardware channels are deallocated, but their
pm_state remains as ACTIVE_STATE or CONFIG_STATE. When the client handles t=
he
failure by releasing the previously successful sibling channel via
gpi_free_chan_resources(), it reads the stale state:

drivers/dma/qcom/gpi.c:gpi_free_chan_resources() {
        ...
        if (cur_state =3D=3D ACTIVE_STATE) {
                gpi_stop_chan(gchan);
                ret =3D gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
        ...
}

Would this cause the driver to attempt a graceful shutdown on a channel that
has already been deallocated in hardware, resulting in the same completion
timeouts this patch aims to fix?

>  error_alloc_ev_ring:
>  	gpi_disable_interrupts(gpii);
>  error_config_int:

[Severity: High]
This is a pre-existing issue, but should the event processing tasklet be
canceled in this error path?

gpi_config_interrupts() registers the IRQ, which can fire and schedule
gpii->ev_task. If initialization fails here, gpi_disable_interrupts() frees
the IRQ but does not wait for or cancel scheduled tasklets.

Could this allow the asynchronous tasklet to execute against the freed ev_r=
ing
memory when gpi_process_events() runs?

[Severity: Critical]
This is a pre-existing issue, but is the event ring DMA memory freed without
sending the GPI_EV_CMD_DEALLOC command to the hardware?

Just below this in gpi_ch_init(), gpi_free_ring(&gpii->ev_ring, gpii) is
called. If the hardware retains the physical address of the event ring after
the driver has freed its backing DMA memory, could it silently write into
freed memory if an event is generated later, causing DMA memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-qcom-gpi-e=
rr-fix-v1-1-5ca3f00fe2e3@redhat.com?part=3D1

