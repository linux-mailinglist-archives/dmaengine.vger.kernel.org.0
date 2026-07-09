Return-Path: <dmaengine+bounces-12163-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id odw3OFBDT2pxdAIAu9opvQ
	(envelope-from <dmaengine+bounces-12163-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 08:44:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28972D4D2
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 08:44:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ZPDDDza/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12163-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12163-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01E38301863E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 06:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401073D331A;
	Thu,  9 Jul 2026 06:37:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D03D5647
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 06:37:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579053; cv=none; b=RPgy5NkMbBO7CUqeCvc+fDlYNFnn4j3sjCEGl+llKicf2FWFAX9j0sFnUAhRCCNQxmRl0RuMTi01Cl49tX05vcnizX2zZcLGnCeMGpbuBoazd0s7O8Gbeq/BLY2Yqcfdv7owolbHOmsoZCJiiTFb4GYeNV2UZGxGdMcbeeXK9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579053; c=relaxed/simple;
	bh=DuAfwTWBZdt0MNaVN/DJ5SgFXNzwB2qxa6IMwkFx0S4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nnyCKngA1bDoNxGZoYUBILcZp0UBG66XYve38SvdmuwP34fmlMfxv2RiRoWGrjz0Mjp5/XCYBdgwvrMfcAoQH6UtdKsdKswqhDQvnGPr5JSEBJ75h0LPmc8sqmdFymWfnj+43bPJi8NPp0LxVCOHQDgHMW9OT8ZfWNQILDvPK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPDDDza/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE0A1F000E9;
	Thu,  9 Jul 2026 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579048;
	bh=Y2LCVHewSJw9M3C0dmB5VeGqU1QNaoApllvBYVOjO2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPDDDza/kpNsspb49JZ32l6hdTP+X2Rz/7k+pVBqX/UWsst2gBIa7sMp6TZSz3GNP
	 9aLnV6f4L5B7FIG6JUbM/na5J482EDZ6T/u+s0/r3pL7lxqaVBlmHgWQ9QwAWTouSF
	 CAWAypDFtzb8wt3+kZ7ZmlTcKyWb1Qcyoebd8Pimm+9qW6j9D61xe/eaw64WGDe6Jw
	 BXdYNeN5bCQNMQ8/xM+BlCSg75NIiAWJLXlLkF09o3u57JTRdYGUkpKUzmVa7VSsdm
	 twAyQqtJaCorMxzJxc7OBmY8P17KoqWn24l7RGWkMb3LPdxpHz4NpekkJGdAB76l0x
	 KHhRnOeAOoLZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Remove channel from list on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260709062303.4167624-1-ruoyuw560@gmail.com>
References: <20260709062303.4167624-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:37:27 +0000
Message-Id: <20260709063728.3BE0A1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12163-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC28972D4D2

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe lockless modification of `dma->channels` and missing `dma_l=
ist_mutex` lock leading to global list corruption.
--

--- Patch [1]: [PATCH] dmaengine: idxd: Remove channel from list on registr=
ation failure ---
commit 4fb2c9798431d41ef3638a29b584b02b54cf00cf
Author: Ruoyu Wang <ruoyuw560@gmail.com>

dmaengine: idxd: Remove channel from list on registration failure

This commit fixes a stale list entry bug by removing the channel from the
dma channels list before freeing it on the registration failure path.

> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -289,6 +289,7 @@ static int idxd_register_dma_channel(struct idxd_wq *=
wq)
> =20
>  	rc =3D dma_async_device_channel_register(dma, chan, NULL);
>  	if (rc < 0) {
> +		list_del(&chan->device_node);

[Severity: High]
This is a pre-existing issue, but does this list_del() and the surrounding
code need additional locking to safely modify the channel list?

Currently, idxd_register_dma_channel() modifies the shared dma->channels
list while only holding a per-workqueue lock, rather than a lock that
serializes access to the parent dma device.

Furthermore, this path calls dma_async_device_channel_register() which
leads to a lockless global list traversal:

idxd_register_dma_channel()
  dma_async_device_channel_register()
    dma_channel_rebalance()

The dma_channel_rebalance() function requires the caller to hold the global
dma_list_mutex, but dma_async_device_channel_register() does not acquire it.

If a privileged user triggers concurrent sysfs bind operations on multiple
idxd workqueue devices, could they race here and corrupt both the global
dma_device_list and the shared dma->channels list?

>  		kfree(idxd_chan);
>  		return rc;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709062303.4167=
624-1-ruoyuw560@gmail.com?part=3D1

