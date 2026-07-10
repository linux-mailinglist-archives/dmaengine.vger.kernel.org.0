Return-Path: <dmaengine+bounces-12339-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S9GFJgQnUWprAAMAu9opvQ
	(envelope-from <dmaengine+bounces-12339-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:08:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC7373CE96
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TZdHrdWu;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12339-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12339-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A7E83024E8A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8132143801A;
	Fri, 10 Jul 2026 17:03:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D02434408;
	Fri, 10 Jul 2026 17:03:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703009; cv=none; b=lksEF6QI6hVxPZfMk/dovhOcK1SRYD0o8GIQblSvEXfS+TlSHBgh57icOD2tDsI+wdnW1bXFFiPahIXWJeM/2I6pMmPSkJPN/2Me050pOTFURf9eDTjajz3Z3N23sJ95Li2VUpH3Huqywb+4537QT12l0VGMkH4Gb8XtkwUWgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703009; c=relaxed/simple;
	bh=UaFbx8Jz4ZpIlmAR6RfSV5G1BEKBSHmiR3nvZi7Gk3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mg5fH9gn7NUZSzZfFUOWKWSrAqVmz8PzQAcIy8r5hkFLTnjtNLxpHNqTY2Y3bHS/C6xBG/gu0Gs4z9ikL41sixf6KO3kvbx8IeXp9knhrJfPOJwgAruHAGGu8eZZOq/ZMv8Gied6P9g/3eLXHwKXD53R4tEkNln90QGisNnAJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZdHrdWu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70961F000E9;
	Fri, 10 Jul 2026 17:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783703008;
	bh=UaFbx8Jz4ZpIlmAR6RfSV5G1BEKBSHmiR3nvZi7Gk3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZdHrdWu06MggDX8DCxtFxcn1IWtGjrsQcSEQnnxPWb1kJ8awa8xy9VM8loZulXCB
	 uAd77NsUY1eJsLQeqEkpe6gskT2xaGne32dUYlNUcEYHo64hjAQCiMXC2544TUJYZC
	 hID2vjyxSwm1K/TOpRK5XIJv5MFC0l1D4VUCw9DS8ntXGbnC0mhGZ7RmqAraJDI018
	 DKaunK479C7+Glg6iqo3e9hN0oLn1z/UVhZTQX1jsay7wWrKe2Kpig/PqsvAI0qIMh
	 u8KYPgz8kbYs9j3bTBB3mDlK7lzYXZvdwSEKculqjTAbtj+5q9xxK8YgaB8Hpbunue
	 /o3Fi44IjlJoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260710-edma_ll-v6-8-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-8-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:03:27 +0000
Message-Id: <20260710170327.A70961F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12339-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,valinux.co.jp:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,lists.linux.dev:replyto];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CC7373CE96

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Use common dw_edma_core_start() for both eDMA and HDMA. Remove .start()
> callback functions at eDMA and HDMA.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D8


