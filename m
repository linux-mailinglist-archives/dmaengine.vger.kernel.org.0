Return-Path: <dmaengine+bounces-12304-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0RnjBNytUGpi3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12304-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:31:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803E7387FD
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:31:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y8nIWIZG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12304-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12304-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 269303091072
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648823EFFB2;
	Fri, 10 Jul 2026 08:27:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC383EFFC7;
	Fri, 10 Jul 2026 08:27:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672025; cv=none; b=hqb+Lxn03y53SZSp0WM/KbpltooF4rAflY8DQMnfCWeWOHsB6BcbZs73avGPs/7yqwNqyx3RYDWg21LDiRqrLiSqf8pm75IktTKGqYjRyj+vo9+8LuWwJRZxfBDOg0R6k3JM/NNQpAjXao7pSkphk/fa1JNG7lDKypcOQ495we0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672025; c=relaxed/simple;
	bh=0VYkM3uBUArqVEXCrFBstg1rybYH2SysBxCXUfrGiXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovhc//jk1lP8A9t0m0cHDgJDbWyZ4fQKk7j0KMxi57zY81UozZafLNVTxDJ4w9iSNA4ghulnldXvXba/0Uzl8vMCWxRmbvVTK4XHRLuw4QRWPTL8P4UCHEAeq1U87mC14cp9C3wEDJojpKfbVeQQd8VinzCd8I/Pxf10MG11gxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8nIWIZG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC001F00A3A;
	Fri, 10 Jul 2026 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672023;
	bh=0VYkM3uBUArqVEXCrFBstg1rybYH2SysBxCXUfrGiXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8nIWIZGYqucZMT4p9BmEz0a0kQ4S8X+RLckmdhwOQ+URQcUKKaTxlTEHzAUQtNT9
	 0d74POH+yTiCUkN4I8q+JRUmBv0ZS+Z4cktMao0xJZqc0+meBVu9v1zi0JaMeRlJjj
	 mB4YWJfjF/VsQRELn+lHEU/EddkJbucxIamijMFtagFnrlcxbiH/K2B6olBxGn/JnF
	 y/jAaoUaWBhbkX+xxAXQzYM0FGM3x5V/LRm+hRcxP0sCHk0ADH+ia8kMWbAYomPzyl
	 Idmyy/gzwysB8lCo2I7M9EuRexZlY1T89nET0dKW/FJoxNx+KrogXlk8aP+u1ytcp0
	 +ZEFyz7W+Bw+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260710082156.2395844-3-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
 <20260710082156.2395844-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:27:03 +0000
Message-Id: <20260710082703.8BC001F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12304-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,valinux.co.jp:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 5803E7387FD

> Extend EPC auxiliary resource metadata so endpoint functions can
> discover controller-owned DMA registers, logical DMA channels, and
> descriptor memory.
>=20
> The DMA metadata is intentionally generic at the EPC layer. A backend
> reports the register layout, channel counts, logical channel resources,
> and descriptor memory resources. Logical channels carry hardware channel
> numbers and refer to descriptor memory by ID; reserving or delegating
> those channels is handled by separate EPC operations so resource metadata
> stays independent of any backend-specific DMA provider. Descriptor memory
> is identified separately so one memory resource can be shared by multiple
> channels.
>=20
> For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
> format so a consumer can distinguish legacy, unroll, HDMA compatible,
> and HDMA native register layouts without making the EPC API itself
> DesignWare-specific.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082156.2395=
844-1-den@valinux.co.jp?part=3D2


