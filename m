Return-Path: <dmaengine+bounces-12142-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EvpzMuSbTmpfQgIAu9opvQ
	(envelope-from <dmaengine+bounces-12142-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:50:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49805729B5C
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:50:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W+blREBp;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12142-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12142-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB50C303B706
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA13C3453;
	Wed,  8 Jul 2026 18:49:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA43C1405;
	Wed,  8 Jul 2026 18:49:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536553; cv=none; b=mSoy3nZPvph6G4Xcs6NqSXq8Z6YbjDLxGpNjvxy4w7+n60xDRpX6SKukuwmnR2WdeM/Eu7dA4o1t6aca/zQQDTE6bBP9FWVfG1q0UQ/XSL0XVEpSk5utAqmf+kKTRTd9YSSgHN5ly3x4Q+wfXL/EOu+aNwCdaITL7L1s4+r1eTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536553; c=relaxed/simple;
	bh=1hBVCW0Ljj9X4HeljrRIvLOjBDTsLPlzXXsGGbxTyIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zo2zYO1FzAwOE4rjfd/kVn3YDMAJ5Dnl+dM64FouJsZp14ummeC2Ww2TDeJYhsfNFLW5fMuShUriuzzGbAvjKUGNC8hlAZLmejtC6p7gCjifvdYGRsciyf0Ptt3Ho15etE6yScoMARb9um6H+K5RwS6Mm11CgBaYVKEtRJPr5OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+blREBp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9126C1F000E9;
	Wed,  8 Jul 2026 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536551;
	bh=1hBVCW0Ljj9X4HeljrRIvLOjBDTsLPlzXXsGGbxTyIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W+blREBpTeOfGFYmzWFbpQFYK172bZJda+UtHjxHpIghWw5EmuifNSq1eb1NSO7QI
	 zt67ccd73bO6brcQH6fLlgilvSRRRpM9cYbXCb5nJYIO2t1rGx5K5uKBDdPnkgu3mk
	 3jVn6TAZaKyY5OLFeiMv+0ju4aMFArkRmgf4DENFRksvfXxnbZ2AryPj3ExmcH1QZI
	 EIWZcPOmIp7TXH/WvIaLS63n3x7YgLdGUszTDWo4wQZ7lr38lHM4BeMBX/KSXzSwTv
	 yV+hZuOacab1mbifZZbkYSy3t5oX3NhBlxQqJ3Vw6TgIlYtPd2gkGg3ZE/E3TACBNW
	 CJw9Q0ssJibnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] dmaengine: dw-edma: Add non_ll_start()
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260708-edma_ll-v4-7-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-7-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:49:11 +0000
Message-Id: <20260708184911.9126C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12142-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,nxp.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,valinux.co.jp:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 49805729B5C

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Add a non_ll_start() callback and move the common non-linked-list channel
> handling into the EDMA core so it can be shared by both the EDMA and HDMA.
> Prepare for the upcoming reorganization of the burst and chunk structures.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D7


