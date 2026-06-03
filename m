Return-Path: <dmaengine+bounces-11139-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +hhkI1WeH2o/oAAAu9opvQ
	(envelope-from <dmaengine+bounces-11139-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:24:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B909633E27
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:24:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J10I2urx;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11139-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11139-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98074303E252
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6762C3EE1E3;
	Wed,  3 Jun 2026 03:24:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26A3F164E
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:24:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457042; cv=none; b=a2jz3vagf7TP6LvujPdxiRdL9+dMxuSIEFUO/iaAcVvyZWrZRw3j/Z5ujzpJL0Xsue3CPy/kSTXqof5Soo2EU/BGkmfRPQYdtJa2sPz1Om3wa2Lu3uBz94MxZHpZUCBq3fV3jhTWxeydJPm+sezT6f+B5EurTuhJdKXRhl9sYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457042; c=relaxed/simple;
	bh=1COY9GRpTK309zdbd0UA/NxzLcfXbSHzI1tF8oakITw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGAgoKcnLxYASOcPRAf1NRF+vDh310Ja5JZfWypjwf2mf7gdw9EN6ZRaAdqXTbAHhy1BD7XUEEQrouJpNtn0T2QpgaZ6St9robcX7VKDz1jMyt64WjhpHzgOZAdKvBlMQUsrYIyVgPC3cwFkdvbdy66OP66woxk4Sf2BbX+Je78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J10I2urx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595881F00893;
	Wed,  3 Jun 2026 03:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780457040;
	bh=1COY9GRpTK309zdbd0UA/NxzLcfXbSHzI1tF8oakITw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J10I2urxtBFk52xhOpLVEkaehPWeeyhRPXrY212Qbjo9sXt+DMvlPJ5jgvjz3mEH8
	 NAj6AZL1HNe0mMXZngPyuA6mDFx4VZ55bezhbGy0e1F3gzF9qkXokiw3emQAMmINu4
	 UAwKrV4i5eHBMLyOCrSRbTg5YY+6ZuVLTDuPQAeueyBfhoKXnygj6A84kJi/Cgtgt3
	 8KLketqr8c9fXY0g5rULC4DnWrlNfANhBEvi+PeCTZMGSCF+xHCkBlWXELhdAyX2l6
	 woO1/G1ylNvBbMouvPohMEVMYQbei4xYVp74DJBE0b3wN4+4kPzmBvNU7hYt4kW0pj
	 i/O9SMjBqTbQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 8/8] dmaengine: ti: omap-dma: turn lch_map into a
 flexible array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260603030754.288757-9-rosenp@gmail.com>
References: <20260603030754.288757-9-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 03:23:59 +0000
Message-Id: <20260603032400.595881F00893@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11139-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B909633E27

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free due to dangling CPU PM notifier on probe failure or=
 device unbind
--

Note: The format of this review has been altered due to recitation restrict=
ions.
No code from the patch is directly quoted below.

commit 8df6bfe3cea1126b3e862e90d788d6cedc19c9bf
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: turn lch_map into a flexible array

This commit converts the lch_map pointer array to a C99 flexible array memb=
er=20
at the end of struct omap_dmadev. The probe function is reordered to look u=
p=20
platform data and determine the logical channel count before allocation,=20
collapsing two allocations into one and enabling bounds checking.

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing=20
issue with CPU PM notifier registration in omap_dma_probe() and cleanup=20
in omap_dma_remove().

In omap_dma_probe(), if of_dma_controller_register() fails, the code cleans
up some resources, but it doesn't return early. Instead, execution drops=20
through to the end of the function, where it registers the CPU PM notifier=
=20
by calling cpu_pm_register_notifier(&od->nb) before finally returning the=20
error code. Since the probe failed, the memory for the device structure wil=
l=20
be freed, but the notifier remains in the global chain.

Additionally, in omap_dma_remove(), cpu_pm_unregister_notifier() is only=20
called if od->cfg->may_lose_context is true. However, in omap_dma_probe(),=
=20
the notifier is registered if either needs_busy_check or may_lose_context=20
is true. If a platform has needs_busy_check set but may_lose_context false,=
=20
the notifier is never unregistered during device removal.

Could these paths leave a dangling pointer in the CPU PM notifier chain,=20
resulting in a use-after-free when a subsequent power management event=20
triggers the callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603030754.2887=
57-9-rosenp@gmail.com?part=3D1

