Return-Path: <dmaengine+bounces-12414-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KRcCHBodVWpjkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12414-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:15:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC674DEA9
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mII5MWM1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12414-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12414-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BD0930D4BE6
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4693438AB;
	Mon, 13 Jul 2026 17:10:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A630DEA6;
	Mon, 13 Jul 2026 17:10:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962654; cv=none; b=jFryqu7gWebmqB2DLVxSCqbzI6HxDd2eQYf4gWeVzS+3ZT5A/wkGPprtkI0YYa63COKu900wyDtNBlRQkjVhX7G8SfEpCv/KfKACSAsM49OWk+FM2YAuemC2ArOSW2CNDqoM6Wju/DOI8pZ9rqUaT/KhnnRPe7yCg6XnO37iN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962654; c=relaxed/simple;
	bh=IDOxhm4ksyT9IcSqX57sUadEwDaUrSU78Xa5SY6/XCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hUYLHHScMG4/mAtpNPOBMyUIWCDcQCA02vKSFnxtmIxH3YS3Fw+4dSSpHDr/LRGXvcGcCyfG/oFIQrju8eGpajIiOLXVWn0+rSsc/yc2wsDhx/iX3aB14TRdKJV2YauaWbHhjqbUVsCpKWhAEr29+GQO3oSHHGM8bCIOn6J+FtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mII5MWM1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06E11F000E9;
	Mon, 13 Jul 2026 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962653;
	bh=IDOxhm4ksyT9IcSqX57sUadEwDaUrSU78Xa5SY6/XCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mII5MWM1ga0z09a5R69EpBtB5NDpWJRkz9frbZ+aiYuzgNyV1SQn0WmX5NeYZI12q
	 /6yZY7LHOHO03GkW/RLXwYoSN/IDmFrRqgv8GlBtvYp8NuhBaRP+NCRAwLtujmFzl3
	 WK4wvR+LRp2qfFkF0HA++OXS92+rg2dOM0pvsly4Yhf0p0z41iq8qsnbI6WeknSemN
	 5IGrw4nfNegHyCkDZKdMksbsMmc2uDB20wkRIToOiWiokyD0pJKAlGYh+EZfc4UR+z
	 sIvpjMQpCM9wyBKBxJawtPofVyhYLtQora76/GRznKyi6pa0SxCPFBbooUGGTLCqhn
	 71zY4iyK1TWOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260713-edma_ll-v7-6-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-6-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:10:52 +0000
Message-Id: <20260713171052.B06E11F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12414-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,nxp.com:email,valinux.co.jp:email,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3DC674DEA9

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Introduce four new callbacks to fill link list entries in preparation for
> replacing dw_(edma|hdma)_v0_core_start().
>=20
> Filling link list entries is expected to become more complex, and without
> this abstraction both eDMA and HDMA paths would need to duplicate the same
> logic. Add fill-entry callbacks so the code can be shared cleanly between
> eDMA and HDMA implementations.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Tested-By: Devendra Verma <devendra.verma@amd.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D6


