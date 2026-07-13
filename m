Return-Path: <dmaengine+bounces-12413-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZSmKEv4cVWpdkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12413-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:14:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5C74DE96
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:14:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IwtdO9Bs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12413-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12413-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46BEA30CC197
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1BE343893;
	Mon, 13 Jul 2026 17:10:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6E340281;
	Mon, 13 Jul 2026 17:10:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962617; cv=none; b=oMc6LYm7PM4VGIxQt7mcuZi9w5J8922wbUYSrQmOGp2LgEQ0aKTGgUBuesIxD6lXf/p7u/dDx27HrFxWAOP183NVEkY1t/N425UGs12gOrJQFmkrpVBGxxKax4K53cA66tULknr9h3XlB9GCIhZAmdZkZx6nsrIE/bwOY3D0AJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962617; c=relaxed/simple;
	bh=TVbMNwW7iJfNjR9gOJQk5nDFVvJswloSv+iZEN9uFtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ju/uhlUYgpm2rlS0/ltpAMHUdlwOATn4BDsqXH3z3SfLZcKiEQhmgWJu8eOmprFFFUdODRLgDNxI15wBXLzORQ4fdetm7mi2AhCpMXWQGoDuMFzEzKuG9qk5u/oQ0Zq/tHb3BlsjuTLoqbjxa7Rf525VGEtjUZ3SNo4YPyqknN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwtdO9Bs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FB31F000E9;
	Mon, 13 Jul 2026 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962616;
	bh=TVbMNwW7iJfNjR9gOJQk5nDFVvJswloSv+iZEN9uFtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwtdO9Bs2PsJ+JUf9nvmqcigP90Qk68oQUsacn2i3Lp4UpJB6/yd+P0TeIl4/ocA3
	 dE1p381UKkiKbin+t4AjzSKhbtv/rDV2qgPsl3SAgztZykL1ZNVv3JLOclZNqNr2p5
	 J9YAlwDoLywkYDuoRZUvrtLEoyCCtQmojXvTiamFEEv9Z+vPBoLDIEq6EtWqkrvUt/
	 usUpx0oiIgYiGOEXS9P7ST20K7l/bkfYNus5cIhy2Rc7S8UILWc5g4CGvzssHGQHhs
	 4Bcevg0sTRLZo4d+uKEptRwhzAB9X4fFoQiKkNuIFJDDFWoUGICfJspPiMzek4purj
	 dLhBOuN4NdNwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-edma_ll-v7-4-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-4-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:10:15 +0000
Message-Id: <20260713171015.C7FB31F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12413-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,vger.kernel.org:from_smtp,valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,smtp.kernel.org:mid];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: E9C5C74DE96

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Some helper functions do not use any information from dw_edma_chunk, so
> passing a dw_edma_chan pointer directly avoids an unnecessary level of
> pointer dereferencing and simplifies data access.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Tested-By: Devendra Verma <devendra.verma@amd.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D4


