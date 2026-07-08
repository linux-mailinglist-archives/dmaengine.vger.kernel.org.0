Return-Path: <dmaengine+bounces-12152-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OpvrOJXYTmpKVQIAu9opvQ
	(envelope-from <dmaengine+bounces-12152-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 01:09:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B93A72B0B6
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 01:09:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mhl9qbyv;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12152-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12152-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230FD3026172
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81972E03E4;
	Wed,  8 Jul 2026 23:08:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263938B7C3
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 23:08:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552124; cv=none; b=dOGJWRwq3r7t8rLdeWB4x3zlLd1R6Qof6eA+AulS51IqizyPd4qFmH1vkOquqQexywOo/kUd934TT3RohoGYW91yfX0xCjrJJvz/CbLnEbowWtVki2RFDtypTwX7vVBbjotLkkRhnrYumv3xWl7X2atihpg/yw0Ib7ckZIu/tn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552124; c=relaxed/simple;
	bh=HNmY2bCmmOZGxzZFE0JXtAdVFKeQtu5oxOTkPlq+kiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQWQ6+TTV+uC0C4/bkoP8IMQXf4zgJtVOxqooQj5b0lFdcGyVmy0nseLZ439a9pO5ZRe5a9N4o5ThHbHdtCH/tqOUEI9uNI8lJEW6X4tNdfQjEchc5QdJujzh98uCSFFIcjtiwXhShy4CsBvQLxfrHWgoixTWQBdyzGQ33BfWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mhl9qbyv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD931F000E9;
	Wed,  8 Jul 2026 23:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783552123;
	bh=Lrbn8s0fVwhbJMmC0UEa0woJJi0Hk3tnw/q4GiPJDbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mhl9qbyvwNsblp4iMNoYZH+YWk2imDpcYhefeoERMkcY8oCtYm9NHsJ+Q8YCZFD/g
	 qg8iKKQhn/YIDd+8iay+Z3Va/xho25FQ1GfbeNQAHuJv4qrVv9YyWP9zAWUdyE5Gft
	 w4OJm8wTLo7qleCafyCSA2bDpdFrMO0bQQRht9gdpJ0qU89KFewvze5FeWR2/FpgWR
	 hkOFxlmY1yVN1L0lgi84RagdKZ5rRCcIo3WCfsxoiAmYQbNzA7gnVybz78KgYJlqpc
	 +rjkXAsjRhvYkfzZwUHsA+Xxm3ehzSL1KHp9on3oQaU+MihvjLqQDb+BUqtBsDXgC9
	 nItFykusr3E2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: qcom: gpi: correct gchan in error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Masney" <bmasney@redhat.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260708-qcom-gpi-err-fix-v2-1-49c9be055501@redhat.com>
References: <20260708-qcom-gpi-err-fix-v2-1-49c9be055501@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 23:08:42 +0000
Message-Id: <20260708230843.1CD931F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12152-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bmasney@redhat.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B93A72B0B6

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `GPI_EV_CMD_DEALLOC` command in the `gpi_ch_init()` error =
path allows the hardware to write to freed event ring memory.
- [High] The transfer ring memory (`gchan->ch_ring`) is permanently leaked =
on the error path of `gpi_alloc_chan_resources()`.
- [High] The `gpi_ch_init` error path fails to kill the pending `ev_task` t=
asklet and reset `gpii->pm_state`, enabling a Use-After-Free of `ev_ring`.
- [High] Failure to reset `gchan->pm_state` on the error path corrupts the =
channel synchronization state machine, leading to unintended behavior.
--

--- Patch [1]: [PATCH v2] dmaengine: qcom: gpi: correct gchan in error path=
s ---
commit a95016733426dc2a9c83a8d6ed2c5dccd118b6bb
Author: Brian Masney <bmasney@redhat.com>

dmaengine: qcom: gpi: correct gchan in error paths

This commit corrects the gchan pointer passed in the error paths of
gpi_ch_init(). It ensures that the correct channel from the gpii array
is reset and deallocated, rather than reusing the initial gchan argument.

Link: https://lore.kernel.org/r/20260625-qcom-gpi-err-fix-v1-1-5ca3f00fe2e3=
@redhat.com

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index a5055a6273af6..3f390b5821abb 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -1965,12 +1965,12 @@ static int gpi_ch_init(struct gchan *gchan)

[Severity: High]
This is a pre-existing issue, but since we are fixing the error path here,
should gchan->pm_state be reset on failure?

At the beginning of gpi_ch_init(), we set:
    gchan->pm_state =3D CONFIG_STATE;

If initialization fails and we take these error paths, gchan->pm_state is n=
ever
reverted back to DISABLE_STATE. If a client later requests this channel, co=
uld
gpi_ch_init() incorrectly assume the channel is already configured and brea=
k the
synchronization logic?

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
>  error_alloc_ev_ring:
>  	gpi_disable_interrupts(gpii);
>  error_config_int:

[Severity: High]
This is a pre-existing issue, but does this error path leave the event ring
memory accessible to the hardware?

gpi_alloc_ev_chan() configures the hardware with the event ring's physical
address via GPI_EV_CMD_ALLOCATE. Since a GPI_EV_CMD_DEALLOC command is not =
sent
here before freeing the ring, can the device continue performing DMA writes=
 to
the now-freed memory?

[Severity: High]
This is another pre-existing issue, but does this error path also leave a
tasklet potentially running after freeing the event ring?

If an error occurs after interrupts are enabled, an interrupt could fire and
schedule gpii->ev_task. The call to gpi_disable_interrupts() uses
devm_free_irq() which waits for IRQ handlers, but it does not cancel pending
tasklets.

Since tasklet_kill() is not called and gpii->pm_state is not reverted, coul=
d a
scheduled tasklet access the freed gpii->ev_ring?

[Severity: High]
This is a pre-existing issue in the caller of gpi_ch_init(), but does a fai=
lure
here cause a memory leak of the transfer ring?

Looking at gpi_alloc_chan_resources():

drivers/dma/qcom/gpi.c:gpi_alloc_chan_resources() {
    ...
    ret =3D gpi_alloc_ring(&gchan->ch_ring, elements,
                         sizeof(struct gpi_tre), gpii);
    if (ret)
            return ret;

    ret =3D gpi_ch_init(gchan);

    mutex_unlock(&gpii->ctrl_lock);

    return ret;
}

If gpi_ch_init() fails, it returns the error code without freeing gchan->ch=
_ring.

Since the DMA engine core does not automatically invoke the
device_free_chan_resources callback when device_alloc_chan_resources fails,
is this DMA-coherent transfer ring memory permanently leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-qcom-gpi-e=
rr-fix-v2-1-49c9be055501@redhat.com?part=3D1

