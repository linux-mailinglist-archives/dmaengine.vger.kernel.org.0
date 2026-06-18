Return-Path: <dmaengine+bounces-11607-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O+pqEeR+M2pPCwYAu9opvQ
	(envelope-from <dmaengine+bounces-11607-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:15:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B553669DA7F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:15:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G5XTgIxl;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11607-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11607-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF0E530588AD
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD0737B407;
	Thu, 18 Jun 2026 05:15:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8B2FD1B3;
	Thu, 18 Jun 2026 05:15:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759714; cv=none; b=MWPbaIpZnIMAmVbgSrER7nV7mn0EJCztY+aBgRVlwadXJyxypRjiwKKspgWtyKDFA5RSlC6V79Bo+AbAt4/MoEOJ8LDnonxwnCuk/P9iAAl088Qeve6W5M57lCNceNW+TDf3IRHhHAXZIoiHibrFO4/iaDg8/pvY6Af6C41Rusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759714; c=relaxed/simple;
	bh=SFM4CPjUMqEaeHWAKLP1o4ygw69ktPqrP3naMidyZD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JreX01CWS334zVA9M6RosFAnKr4JhPCcdfA/k7jlQk029Ca6LRhDXv6H8a9QduMeKRVSmCGltqGhslpz0c3ybe7HKvZp4oxv74zovNxs7r1j5XYwPjOxgbVsz8sQ6nSEdjBxgRImTTMrRlY4okGs4ioUKkpXPmhSoWeBio5OsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5XTgIxl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C78F1F000E9;
	Thu, 18 Jun 2026 05:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781759712;
	bh=c89PiQ/mO1wb9bqJG3k4eZG9U3X0hkAsK484DLR/aMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5XTgIxlAzZYX3ZfxGXNZ+3PYlxg5JrQ3kIcMvklkPnHPc7YQ/+wn19VqBMuTTNpe
	 fD7FD2RZImkspX2Eq38YfVOzoSlkMVFPOc+Yods/046lk40lpMmJGpXN10WYTrh7WO
	 OeB9hdpaP8dOJFr0HLcSjjSqJXyISlSaUW1iXytcLozfYd77OjNI6T9p+VfVxXOSh+
	 aNujPAoj6MLcEbzmdWbTEyfLWSZNI0fa5azWmUGPgKitbqdHM+zfjorXv/rYafg4Cj
	 WvDGgzTTk8z/w6BM50BeXu3OOPNg+L4loS2JbN4GxbTNTOOkAt6aIPOqcmb0tqPaIA
	 OKJ3unfq9NcLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org, vkoul@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:15:12 +0000
Message-Id: <20260618051512.5C78F1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11607-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:vkoul@kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B553669DA7F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling pm_runtime_get_sync() and pm_runtime_put_sync_suspend() on=
 `lcla_dev` from the DMA hardirq handler causes a 'sleeping in atomic conte=
xt' bug.
--

commit faf19ae1be6f68a94634761ce6a55206f7f124da
Author: Linus Walleij <linusw@kernel.org>

regulator: db8500-prcmu: Remove EPOD regulators

Remove the obsolete DB8500 PRCMU regulator drivers.

> Drop the regulator build hooks now that EPODs are power domains.

[Severity: High]
This isn't a bug introduced by this patch, but since the EPODs are now power
domains, is it safe to use them from atomic contexts?

An earlier patch in this series transitioned the LCLA SRAM to use power
domains, but the DMA interrupt handler d40_handle_interrupt() acquires
spinlocks (base->interrupt_lock and d40c->lock) before taking this path:

d40_handle_interrupt()
  dma_tc_handle()
    d40_queue_start()
      d40_transfer_runtime_get()
        pm_runtime_get_sync(base->lcla_dev)
     =20
      d40_transfer_runtime_put()
        pm_runtime_put_sync_suspend(base->lcla_dev)

Because base->lcla_dev is tied to the ESRAM34 generic PM domain and is not
marked IRQ-safe (GENPD_FLAG_IRQ_SAFE), its callbacks are invoked, leading
to sleeping operations while holding spinlocks:

pd_power_off()
  guard(mutex)(&ux500_pd_lock)
  db8500_prcmu_set_epod()
    mutex_lock(&mb2_transfer.lock)

Could this lead to scheduling while atomic bugs and deadlocks?

> Keep the MFD cell around because a later patch reuses it for a
> small compatibility regulator driver.
>=20
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D9

