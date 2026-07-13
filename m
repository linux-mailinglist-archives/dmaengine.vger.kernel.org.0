Return-Path: <dmaengine+bounces-12412-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dpKABfYcVWpbkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12412-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:14:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDE274DE90
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:14:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lW5FgOOZ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12412-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12412-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A81553036386
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F41342539;
	Mon, 13 Jul 2026 17:09:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC9340281;
	Mon, 13 Jul 2026 17:09:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962581; cv=none; b=Tum+8XIaitvD8BNVG2x6qjbkLqhfv/qlirtA8rxfn0nEWb6VNuywVkycTUr4TY8AT8XpfYU++52DQduQPdtyX/WVI2u/8CvJc0DyAJG2GqDtCqielHgY/gKbyrGvw4YwDM+dumzMmOFkEfer6uuYBPR+Ye4Bq/yp/84sczb5Te0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962581; c=relaxed/simple;
	bh=hcOlYgicv5iaaTCZdSXw4LLy6DafP7i3HBBJ+Bul9bo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iK4i4xArE2ted7v0b0CwihRjpkNxUHLlLlv24d+7ImpmW93sqgt5T5UBw7cg36H2H/fZOiyq/o3W/KiXjTl4nMelO9P69JQ2cQWEXB+l1sjsuhP3PSZ5UnpO2JqKfLPXu3TZk3XtiiJ26y6I3uL63KS0f3+ZFSSXlEd4tF5SO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW5FgOOZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A44A1F000E9;
	Mon, 13 Jul 2026 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962579;
	bh=hcOlYgicv5iaaTCZdSXw4LLy6DafP7i3HBBJ+Bul9bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lW5FgOOZSFpvOgGBXTZBO0JHQQWAlFI3fqhXWPAGDD5VcofBa/mGWeG5DOzv32DFX
	 wHgyV5VG+867mDBEoFmUtt+3B8xgKN3JwyZzalYB07rjsKhF3Xz3yRQRMfOvJG/27P
	 NRaBwo01bRJqhijKwQ7LzpPYDZzhw9KAyPUExtmEDD/BYfrE2QVVUqmTpjnIP8Sxsi
	 4jKk6ObFWtGaXujyQKtVkB8Jf/KRszuznvguephBOky83f07+slOVR8MMLFQnTW9UQ
	 9+FaNT35SXyoVseGjPRUL22kYTGwCtp80q3nbobPBbQGGuJxwHThEVNJmWAAu+6oh3
	 a5nJU7zWOU9kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260713-edma_ll-v7-5-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-5-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:09:39 +0000
Message-Id: <20260713170939.8A44A1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12412-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,amd.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: AEDE274DE90

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Move the channel-enable logic into a new helper function,
> dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
> link entry additions.
>=20
> No functional changes.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Tested-By: Devendra Verma <devendra.verma@amd.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D5


