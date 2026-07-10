Return-Path: <dmaengine+bounces-12334-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZnRjEG8lUWry/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12334-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:01:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC973CD9D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:01:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Pj40yLpy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12334-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12334-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 586433055EBA
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19436A379;
	Fri, 10 Jul 2026 16:56:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2528153BE9;
	Fri, 10 Jul 2026 16:56:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702565; cv=none; b=FUnTyPmhcLhY8yUl3Ti2/9aYc6Zbx+oppwglA/Fi1BBAcgDpU+86oJK9tMai7GNTaoY3xBftVyj9dF1Hy1aAyMRuHXNFawG+dC/rTh997gfAnDqzDc2kQXja8HhTE0d3faTYHZZVt+XgLrGGfSFzPhhI+DFZfAYCdiN8phgxMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702565; c=relaxed/simple;
	bh=PCA7U5UyCoo9aH7jEkw03B7i/KEXkAQ2WfuHLu1WOUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XbT+86qMadBEWpXaN/o7BvuRwApqqlBZGwce8idNmEquCN79lyKnkajJzfemqXHSTfX+/9jhlIRe/J/RsouH5EQC3eDohvqwZVsyaPJWx4+T/egx6KLk9TyGCJhnQYkt3QyCyU9UbkXFP3p0Hx88FZYkwDzhM+U0L4SJrNfp3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj40yLpy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFA51F000E9;
	Fri, 10 Jul 2026 16:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702564;
	bh=PCA7U5UyCoo9aH7jEkw03B7i/KEXkAQ2WfuHLu1WOUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pj40yLpy8ioVaVWwmoa+7wp9MaIDLzYOQs7R5UBg628ZFgD40OBUC0CCkUjj9+/vW
	 TAdzvPhJXIVV6BF6IrnxBerpOFGmsb2mYlC3x61tP59jh/neNtJ0whRee0hYjJw/Og
	 TkVNp2ODW90qdlbDB4vM0n5jfmyU8yvg+GyQJANe6rLVflSe4XGQUeFE+25lghY/VI
	 esRp68aLQOP9k8d3KcXuEr3JIujGPypuwDn3eUlRhNnWHcBuVUoH3LO/ERuubY0fty
	 pthu2C0D14OPKcri16wRZZ8+w9El6omISU/uw/CxVfyVHZx4t1z0DN1pc4uU8fZQ3z
	 yZjruz0kUondQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260710-edma_ll-v6-5-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-5-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:56:03 +0000
Message-Id: <20260710165604.1AFA51F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12334-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,valinux.co.jp:email,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 0BAC973CD9D

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Move the channel-enable logic into a new helper function,
> dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
> link entry additions.
>=20
> No functional changes.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D5


