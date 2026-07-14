Return-Path: <dmaengine+bounces-12514-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y8+IF8moVmpX/wAAu9opvQ
	(envelope-from <dmaengine+bounces-12514-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:23:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E0758F4B
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:23:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Orh54189;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12514-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12514-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 853973017BA6
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC2F412BF1;
	Tue, 14 Jul 2026 21:23:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600437E5D7;
	Tue, 14 Jul 2026 21:23:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064197; cv=none; b=IakkZXQkPkEJpvHgIv2KcbZx02dodXMEnjn3IudMdySRw+Xed/l+ZDHIY2IdbRr0PdtsauKpBTVSNBSXNqAePxQSRuoW3QRVfN1wMAXZ7uH7dxm12mReQokm0DeN8Be/QJ0L0pF4W8FpZ2V+1z4kWAcbhvCwQCqy1xko39gKx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064197; c=relaxed/simple;
	bh=WrhjaPuLe0j+3sEaX1xciIONL4OiJl5kfhnLmC/Ws38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XhzKwvqzg4yRMJp7VaVxm3XKt0Q52C0/7Ss+sXzp266QNIa1MKg8BMRzxzaKUPatOFXyPXNJr7il0hAevUmvOl2RilG/e9hlbGjqsiA2ibpdOzK21MStP7I6VGFXS2Osnm1RD57xPD6AV+VzXBnSK18k3I4Ixv1CMWKb5LOWBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Orh54189; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEA31F000E9;
	Tue, 14 Jul 2026 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064196;
	bh=WrhjaPuLe0j+3sEaX1xciIONL4OiJl5kfhnLmC/Ws38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Orh541896cNHPSVK7rdcM9JkwunXwvH+JDAaq0zxifAupm0vLsC/CM+f+z1NP54g0
	 09bqtmLteoCBRf40nr+R5qRTJ7aNo94722WumaWAfAOKF6OJgj8lRBBupGeSIBVDop
	 dYX7GZJyzqEnVLc25hV769AahcCG8D2dXjsixmkHGbSCkzAaPBMsG90RD60GswSVuy
	 7madnh5RHlGZlvTRqFhwVFkCm8Gwzo2k0oqYvmCI8FbGuW+TEdGP7gTFnjLDyjXXYn
	 s9+pgfvAhzgbViGljda2Q8vJMQvIfqOkXUQqf6MkvsD6xkMSIpOtrgu8PrcEi+0Uk8
	 Yfn/CSTm2tv+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] PCI/switch: switchtec: Add PCI1008 device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260714212010.230606-3-logang@deltatee.com>
References: <20260714212010.230606-1-logang@deltatee.com>
 <20260714212010.230606-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:23:15 +0000
Message-Id: <20260714212316.3DEA31F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12514-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,deltatee.com:email,lists.linux.dev:replyto,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:logang@deltatee.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F37E0758F4B

> Add the PCI1008 device ID to the core switchtec management
> driver's PCI ID table. Without it, the management endpoint on a
> PCI1008 switch is not bound by this driver, preventing userspace
> tools from configuring or monitoring the switch and leaving NTB
> functionality unavailable.
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714212010.2306=
06-1-logang@deltatee.com?part=3D2


