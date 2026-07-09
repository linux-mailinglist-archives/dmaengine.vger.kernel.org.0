Return-Path: <dmaengine+bounces-12217-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CISrMxeyT2qfmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12217-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:37:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 426E9732546
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:37:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="V4/U4H7W";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12217-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12217-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A78D13032659
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FDD199D8;
	Thu,  9 Jul 2026 14:19:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5E21E098
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:19:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606786; cv=none; b=nG8cCMDpH8ZEt51fW4rz84OfKjcAo+u0v1saGwkh8Mx1EMEnuBsvgA1how/oq956VkWxsnFOE+xv+u9U5y2S/9gyiRxuR/7a2P+UBlo7V91OxwDCQf3TSahKc4y8QU0K5ivQaCkSRK0a+EL7LObBIje2de5vUOR/AyHBWwgWwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606786; c=relaxed/simple;
	bh=Wp9jV9gvx1idzpfCNiZNVc6RIJtL+XbmUApxR95uEvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kd3bNDZV6SJ85Cf3G8iZhShiwL2I/dShCt+vy8gksPCsSBG8C9Db9k+Omk8zsXbCQ6O/k5EZrmohfAbbHxlJHhxMrb1WNbPyFJImghUmTxGljXaVv/d2wMk0fo7Zaju/q7z7PZQn0Mdtci/msiuwnUdQdBx0cYOcTy5iGU6wtN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4/U4H7W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F41F000E9;
	Thu,  9 Jul 2026 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606784;
	bh=nanL/nVowzUNdH9bunu5nCKCypMlZv6/HRQ68QTnSr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4/U4H7Wyafe53Gq6LjarqMsI7hpdzU/SPr3ty2aghmdyD9DuR2HTtkeeMBM2LARD
	 TJhumke/0EIIXqPsjT44h901kd59GafgQ6q1wSHggC9n8a+EXH37a1GCgtj5IDe87h
	 h2WN3ifkmo4igcM/C4XxPNMwjy15x83pndBLtHvNxUagNWS0ASoiXvs2ty6EPU9rTV
	 1a7I+WOWtR2o6G0+2GJejEVo7fsoGXArOsHxhvaIUm0ITFp/BMOSyCHNy8xpINiEf6
	 b1XJ++CfB1o3BiB2pPLAS10oaCyXyeLAO4DYsAL4bZ0yFOdniS0IRqLYinB2Epq61u
	 wHhWZ6RnTgm1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/26] dmaengine: qcom-gpi: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260709135846.97972-11-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-11-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:19:44 +0000
Message-Id: <20260709141944.804F41F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12217-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 426E9732546

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error cleanup paths in `gpi_ch_init()` use the wrong channel p=
ointer when stopping and deallocating channels, leading to a leaked hardwar=
e state and redundant commands sent to the wrong channel.
- [High] The transfer ring memory (`gchan->ch_ring`) is permanently leaked =
if `gpi_ch_init()` fails during channel allocation in `gpi_alloc_chan_resou=
rces()`.
--

--- Patch [10]: [PATCH 10/26] dmaengine: qcom-gpi: Remove redundant dev_err=
()/dev_err_probe() ---
commit 2195d06ab56c88788ead88f1489a78636aee6d8b
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: qcom-gpi: Remove redundant dev_err()/dev_err_probe()

This patch removes driver-specific error logging when devm_request_irq()
fails. The core already logs detailed error messages automatically, making
these manual prints redundant.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index a5055a6273af6..af824682e64c8 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in the error
cleanup path of gpi_ch_init() while reviewing this file:

drivers/dma/qcom/gpi.c:gpi_ch_init() {
    ...
error_start_chan:
	for (i =3D i - 1; i >=3D 0; i--) {
		gpi_stop_chan(&gpii->gchan[i]);
		gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
	}
	i =3D 2;
error_alloc_chan:
	for (i =3D i - 1; i >=3D 0; i--)
		gpi_reset_chan(gchan, GPI_CH_CMD_DE_ALLOC);
    ...
}

In both loops, the code calls gpi_send_cmd() and gpi_reset_chan() using the
fixed function argument gchan instead of the loop variable &gpii->gchan[i].

Does this leave the successfully initialized channels in an incorrect hardw=
are
state and send duplicate reset and deallocate commands to the same channel?

[Severity: High]
This is also a pre-existing issue, but there appears to be a missing cleanup
step in the channel allocation path:

drivers/dma/qcom/gpi.c:gpi_alloc_chan_resources() {
    ...
	/* allocate memory for transfer ring */
	ret =3D gpi_alloc_ring(&gchan->ch_ring, CHAN_TRES,
			     sizeof(struct gpi_tre), gpii);
	if (ret)
		goto xfer_alloc_err;

	ret =3D gpi_ch_init(gchan);

	mutex_unlock(&gpii->ctrl_lock);

	return ret;
    ...
}

If gpi_ch_init() returns an error, the function returns directly without ca=
lling
gpi_free_ring() to free the newly allocated gchan->ch_ring.

Since the dmaengine core aborts the allocation on failure and will not invo=
ke
device_free_chan_resources(), does this permanently leak the DMA coherent
memory allocated for the transfer ring?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D10

