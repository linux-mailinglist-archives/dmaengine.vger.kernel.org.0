Return-Path: <dmaengine+bounces-11512-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bUq8J+GmL2ppEAUAu9opvQ
	(envelope-from <dmaengine+bounces-11512-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 09:16:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE36841AD
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 09:16:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.spacemit.com header.s=mxsw2412 header.b=tKy3gtpI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11512-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11512-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BA4030088BD
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3C27FD43;
	Mon, 15 Jun 2026 07:16:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5473054EF;
	Mon, 15 Jun 2026 07:16:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507804; cv=none; b=oecyTFgHRjGoKOucw7zlHLf6p/P3xKNEOXz8Lp503dUFbTemkAl27GPkadbAKQVqhqSz/ETRt6QuJKHP+/uS/zmzzk0f+xXt9tmrGKDKjHinArA9RtetSUcXrJixp13WlQtfRer5Dvtkgu7zdTp0MFrSxl/ulMma3CqNgVk80mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507804; c=relaxed/simple;
	bh=AO+GKKowcBgDGHCAL00C6jOZKBMVwQulRMK315fL3yU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e1/NpPmjUjmrk2mz5+ivPprGUZO2WFZS2x9hNQBxKTVUgEmxTha5mk+WGtsdwge8zCZukWPZLgT4KSk81k6gwMlnENzVeWpiWpbQxNh3zBFs2mIoBEdPELCx9XSM2RSt4BhvHjpTOysOHVk+xznKya0H3ESZ8F/TjRxptl4aegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=tKy3gtpI; arc=none smtp.client-ip=54.204.34.129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1781507751;
	bh=Rl+ZSdOniMSyh82VzHmUiRVvvJR52OxzsBllOm+XbfY=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=tKy3gtpIjx6nxWH1u+QO9D/dLbhlD1LmBOhOmFbpfEhnyPtp1kPjvYmCPEEHpMA50
	 RVFAGH1G3Fh9NzQvu+dsm1arReoOmXMO5eY/nlsspRsvjJFFUqvTMtBFrkcIWJuOPT
	 y194RquLe2Jr4udwxmdDalQ07gxZM1YxuizUBIiI=
X-QQ-mid: esmtpsz17t1781507743t9aefb8c6
X-QQ-Originating-IP: KTItmJz4aezgBawcldJnwoLV+hCx1XKUKIOMrGlx7OE=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 15:15:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12401090553256602982
EX-QQ-RecipientCnt: 9
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 15:15:40 +0800
Message-Id: <DJ9FSDGD51UL.19AY499L4RI3K@linux.spacemit.com>
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>
Subject: Re: [PATCH] dmaengine: mmp_pdma: fix wrong extended DRCMR base for
 SpacemiT K3
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Vinod Koul"
 <vkoul@kernel.org>, "Frank Li" <Frank.Li@kernel.org>, "Yixun Lan"
 <dlan@kernel.org>, "Guodong Xu" <guodong@riscstar.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-k3-pdma-fix-drcmr-base-v1-1-ee1af124199f@linux.spacemit.com>
In-Reply-To: <20260615-k3-pdma-fix-drcmr-base-v1-1-ee1af124199f@linux.spacemit.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Oa8H3HVvYs2abSlmz1mtvuX+yKs/TntbMuZUhzGM6SnOulCjS2fld6QS
	dnpMpJk0iSHPI1ZO81X2GpBHNWX9uS6aBv1bGMXhUQFiRYq8anKqRXUHNLcReG31aSlqrWb
	/IUZK28Hw+8qNQ0ZNY91Qd8t5RG15mKR8g7wkNdTacAwdvYpgGLZmRA/VKL8TfAInLCMika
	9HmDohTFAypzqsy2zYbJJl1M1ZbeNy6ME2i/hz3BX0eGrkNiQ3cgxtLj2AFBWJqjqic6FKU
	R9SwwakUjZ2lN6Wl23IruL09tpehztWa/cpWvC4Z8QVYXVQ+knpqDV8SbkW0M5Dnp4bQ4Xd
	DzLljIR6oGgZr0Ypuu1hCdhX5PkrbO3USDhj2DdduxgQLh2thbMYwKJRpuUlOh9fjCznlBk
	DuYTY+CCGUZKPy4t/T7/dUfjVQNLYG8czq0CdO+B4RmIpBA992DnNf53CEOokRoAQVdn/O1
	jku9U0z83xIkB9TtCvzIqol7exBShaBAa+O3+WUXqudOePgT1xb96cEmuJp2Mzv+sf3TMaR
	OS1u74KMEMwi1F0gsZPB20ebJJf7nx5RPgG5t8TB/2y9rPqvrg+liMJGU7wtm2b3YO4jSF0
	JDHCO57pXaMGXcZTNWIG6EU8aS3qdTJHewRWCsvz+Nz7PUlcDXOJAVaAY3/e2DPUkwuchAZ
	V4VF945uZIa4p+V7bsyG0Jmuw/v83oyTaZf/k00zBkRH9nE7ivf99WfAj7imLQeDqYcVLm2
	Tvy0QUuhIX/TuTyQFlMQkesYelbJX1bGkGb/CuSt5XBZzyoHKsQVLXD/qd08W+xcGTHgqPL
	daXlUp8nR8NPKsGdK6j3rPJastrLsGK4I/6mkMIFZrIMa0YNx/fN5kapHUyPHa63hfNsrpm
	oN7YxP/WaC5ietB+90dHQiqExEJcXUU4/q4cKZF22i9CIAhh88/cnqBhaFqAUAgJhoZP78r
	l4otON7luaLHVKQb9fCssucdi1KuCyJ1+/qGAA4nYKg7IXLY5LJ+P+BwypGrufkx+/3XJSy
	by2UhgkA7YaTIsDvlZq4iu7rXG5h/2tgG017moYN7I0XWcH6C2
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:troy.mitchell@linux.spacemit.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dlan@kernel.org,m:guodong@riscstar.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11512-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[spacemit.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[troy.mitchell@linux.spacemit.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.spacemit.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[troy.mitchell@linux.spacemit.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.spacemit.com:dkim,linux.spacemit.com:mid,linux.spacemit.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32DE36841AD

On Mon Jun 15, 2026 at 10:53 AM CST, Troy Mitchell wrote:
> K3 PDMA shares the same DRCMR layout as K1, where the extended DRCMR
> base address is 0x1100. Commit 6587b8661a0b ("dmaengine: mmp_pdma: add
> SpacemiT K3 support") incorrectly defined DRCMR_EXT_BASE_K3 as 0x1000,
> causing all DRCMR accesses for channels >=3D 64 to be off by 0x100.
>
> Drop the bogus DRCMR_EXT_BASE_K3 macro and reuse DRCMR_EXT_BASE_DEFAULT
> for the K3 ops.
>
> Fixes: 6587b8661a0b ("dmaengine: mmp_pdma: add SpacemiT K3 support")
To clarify: the previous version was not untested; it simply hadn't been
tested with SPI DMA specifically. This issue only affects DMA for SPI
devices, rather than all DMA-capable peripherals

                                          - Troy

