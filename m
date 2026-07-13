Return-Path: <dmaengine+bounces-12415-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ae6rMSAdVWplkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12415-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:15:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9501D74DEAF
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:15:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CGq2F+SR;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12415-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12415-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9F37302F383
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F1B343893;
	Mon, 13 Jul 2026 17:11:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C1224F3;
	Mon, 13 Jul 2026 17:11:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962665; cv=none; b=oB8b9fcHq3suNkuHoz31ZECAk6LOp9hTZIy+geSL9jgHS7J4PWD7AL/+CqaHfl6SFJWzJK6L3Ohzru83PSUinmPUtxjmMCh4SAv6fkR9Ydow2wTHVV9HCBNtc36Jt7MlfFMFl7WE+ZNv0vj2Qf7Mhxz9JRv8f5s+6kcEvK8n9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962665; c=relaxed/simple;
	bh=R4JlLDqzxgeAj3Wxwl80y9vNfNFTHctZRC548npiXLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ThLpx/ZTmYR9HmctsnZZPqpUqKur06Dn2jSTMNa3P5pE+pRVa1KswAmOTOhKnjcwpKgVWOt90i9a8ZKXPz7k3tjAXU2ly0CiGCTxt/q6Mk3AQfVplHbIhQOGlRR/PaHDwdaknutsaZ6lU4WY9m5DGvDtr8lfB099+Jqjik9Ati8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGq2F+SR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67DE1F000E9;
	Mon, 13 Jul 2026 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962664;
	bh=R4JlLDqzxgeAj3Wxwl80y9vNfNFTHctZRC548npiXLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CGq2F+SRihrRb1iGY3wp/vm6k3hhKXizz7nBpQs/ECVLkAGonWqmzNq5B7GX9GjOS
	 J0VaAd/44x60+6j2Yn+FrjyzAJKbdokfnneTfcZpiy9X1YEeIhC9AcBtn+yPDnyRvH
	 pRUCusuVo7um/O2041T9RVWxELbdYv4bVpPmPNUpmVLZeLkKubBrTqpZqspZ7e+hhQ
	 q4qbLnPS0NPlxOkfKn4gpY3zh3sXFAS6YEx6It4qXPsXt+UOgVFrB/+eoN2b6uvXR8
	 c81DrPu80fzsWdaldzvxo2WLoX+YyNM8pj+c+gN7j0s6T1tteysMx6QSiA5qp2mR1M
	 lnROTocEtx+1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260713-edma_ll-v7-3-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-3-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:11:03 +0000
Message-Id: <20260713171103.C67DE1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12415-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,nxp.com:email,valinux.co.jp:email,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 9501D74DEAF

> From: Frank Li <Frank.Li@nxp.com>
>=20
> ll_region is identical for all chunks belonging to the same DMA channel,
> so there is no need to copy it into each chunk. Move ll_region to
> struct dw_edma_chan to avoid redundant copies.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Tested-By: Devendra Verma <devendra.verma@amd.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D3


