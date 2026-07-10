Return-Path: <dmaengine+bounces-12300-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AW2LHAqtUGob3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12300-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:27:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D1D73871F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:27:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ltIUvAhL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12300-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12300-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C812307AD74
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900033EF670;
	Fri, 10 Jul 2026 08:24:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951F33262F;
	Fri, 10 Jul 2026 08:24:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671865; cv=none; b=W94phqWcL/n/e82tp7f4QgiHtNodV+jFgzXeuIDGvbsv1/54L257rxyUoaWCy4KZnr7TBkuanThrI695XVF7w2zmuS4ddlU2SKkwJXAJt43de/YXhm/Jtf6Vp2f2URRctvuv7WUa5qHrAnetaHCChYTANbjWP4LIuLpPD8SD2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671865; c=relaxed/simple;
	bh=1n2pHRvn5SQpMkOz2wjE7yjDY3UpHbq2PujQ6Cs00L0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dSqANOhIt+ZCDFvt5iCu7IYVntstik2mdkDKz9MiI6OEo3TzUmMsjRqe3ZBYQotLoUZ5aiV0mnWttj5nfCpA0PMJl6P5kaj79hpHB8IN5166MPMRFY9s051mGWkLJT1x4q6RMIhJ21vwEyhiQ5nNAlrhg97bzICI33mWe2+OWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltIUvAhL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55341F000E9;
	Fri, 10 Jul 2026 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783671863;
	bh=1n2pHRvn5SQpMkOz2wjE7yjDY3UpHbq2PujQ6Cs00L0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltIUvAhL4OI0Dt6A81DwAxFKFwiJWyLJKvJUq8jiadUb0JogyxZW7PMaCvRfz7kU0
	 uB/ldaDnBEx+KpohjpX3ts2jGpRmFBfNs5LGlK8YdRF2WHHnmNgEKZYxfGRhPZ8MP9
	 B/sIcbAdnTwXYYyxcfDllbh5rC9eMYd/Zkqoqv+L1qoTQ0PJfN+TEykmSRsA5pkclG
	 iUwidSjimLH74C0E1E1/RvGhvIGCSyjvPziWdTXaFLLCLQNJ8iCzls8BFpVKUbYKFn
	 jvHzh3qVZ9jT6dREoMd9P/2PzFr6HT79Bs4jG4irh05aysXjVML+j8V06oYf9Dov5R
	 sfJ4kRt5sX7Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] PCI: endpoint: Define endpoint DMA BAR metadata
 format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260710082156.2395844-2-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
 <20260710082156.2395844-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:24:23 +0000
Message-Id: <20260710082423.A55341F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12300-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,valinux.co.jp:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05D1D73871F

> Define the BAR-resident metadata format used by endpoint functions that
> expose an endpoint-integrated DMA controller to the host.
>=20
> A VSEC-based discovery scheme would be a natural fit, and existing
> dw-edma-pcie providers such as Synopsys EDDA and AMD (Xilinx) MDB/CPM6
> already use VSECs for DMA discovery. However, some endpoint controllers
> cannot provide enough writable configuration-space storage for a
> complete, controller-defined payload. Keep the extensible metadata in a
> BAR instead, where the endpoint function controls the layout and size.
>=20
> The format describes the DMA register window, exported channel counts,
> descriptor windows, optional auxiliary windows, endpoint-local descriptor
> and auxiliary DMA addresses, and a ready bit that tells the host when the
> described BAR windows are usable. Channel entries keep the auxiliary
> window optional so layouts that need a separate data or auxiliary aperture
> can describe it without a format bump.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082156.2395=
844-1-den@valinux.co.jp?part=3D1


