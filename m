Return-Path: <dmaengine+bounces-12338-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fq8CIxsmUWopAAMAu9opvQ
	(envelope-from <dmaengine+bounces-12338-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:04:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2A973CE1A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:04:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=izgmMMIE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12338-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12338-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2787D3034E21
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE42BDC05;
	Fri, 10 Jul 2026 16:59:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E07EEC0;
	Fri, 10 Jul 2026 16:59:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702749; cv=none; b=C8/ILGdkg1GFM2VPdXepK7za2GEkMBTB294YKSB3XcxV0rH/tEVS2CsT/9P5UuIu18AF5vZgYtT2RNYrE/PpInn7S0tShYrwc6yg94lummjKI3bm6zNn0ibiehrQH8hOUYxmnaMsy5gPbVgcj4KU2tDrWoS5dFbY+Z34EPJykEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702749; c=relaxed/simple;
	bh=AMHJ7Ta/BaZdZSGZsSnwvfG/A04Xotpmsl6ymNXDfv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tYfPuqQ70xUP5+vnvaeZRPb2x5luyu8RaJM5pwUcFZx2GYbYmi++JvrInBP4Kj2zLrIcknyz8tG5n6vmBdlDVbFPolx8BQ4t9Qj3s7ctjVzmU+a4yGO3tN2WJ/LMzWTbzeNOunOjnch2DUybVeq04J459xU6FZu+V7543Hhnvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izgmMMIE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE5E1F000E9;
	Fri, 10 Jul 2026 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702748;
	bh=AMHJ7Ta/BaZdZSGZsSnwvfG/A04Xotpmsl6ymNXDfv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=izgmMMIExVPBxQAsF/BVKwX+zD45+G1F3TDtREILNKFYryzmdwXqfjKvL59a2BKR/
	 IXPgrzVScNtpRo11oKdmDrFURpF6RRIePRxD0TFmxDbHDglWxTNL2eLluTxvqqmwvs
	 tpsdaOjBQ7kwSLtwhZnH/oPX4iG6cp6bRLgiwgrkhFbt0jr/hbnWG68Z3aKOR724Xu
	 msyISz3PFbmmtyKIjxJhSQeAnBEC/ekm8fsICWLMcixMbRCpZe/A3H9VaMQef7I7Zc
	 VowIqlYmcwgQJ+bprnagU88DRLkg0AZC6CPXeexl/8fvuyEMiP7gvH29tV/luOEqTS
	 Rjtdig0zeN2MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260710-edma_ll-v6-6-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-6-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:59:07 +0000
Message-Id: <20260710165907.AAE5E1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12338-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,nxp.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC2A973CE1A

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
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D6


