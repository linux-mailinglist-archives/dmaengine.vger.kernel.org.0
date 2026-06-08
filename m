Return-Path: <dmaengine+bounces-11313-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EsIQCSKyJmo0bQIAu9opvQ
	(envelope-from <dmaengine+bounces-11313-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:14:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF4656059
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:14:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P7qzCvmI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11313-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11313-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AD2F3007A67
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60BD37AA81;
	Mon,  8 Jun 2026 12:13:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2AF37AA72;
	Mon,  8 Jun 2026 12:13:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920788; cv=none; b=t9vCQBl3fND35oKyXZPp1iRoQVJxPa51HCEy7SmQOGxm0nUtw6VRjPWl2dMTTgunegW3+nwDfoxN+bBn/fqKOar8RKe6lVxRaH9o1QZamszENTZS5WzONSLi4XCK1minY/044ZriLPtf5EOwsReF9KaERegXOdF1Of8U2gnAQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920788; c=relaxed/simple;
	bh=hsJi+KS2XVtMGlCbsVtz1AT/uQlNpSSvA7xXtDi/H30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fYkxkIvyvbAB5Q9Jd+rL1X4KnUNO/a+HxX56dtW3Fe6NiOCD76Mu3gkr8eXe4BB5JqS19i0Pygdb5QXAli9My7G8v18MeSfxgw/sNfDMrRAxJrnK4rMixULHUNkZfKuoi7Ci8St1pk7ShoXzT4gXkE+03mN3vieVX6sk9wvtZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7qzCvmI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9201F00893;
	Mon,  8 Jun 2026 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920787;
	bh=E08OqyCxAxGzBDmJwEbAhrZ40quz2CEQKMoD/2SQDmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=P7qzCvmIJ0RSU3Foa3MWj3ZyonEKFqYtRHVZNMqngQJjqDFvDSEbI1kDQRZnOtH2j
	 0VAvkgcK/TkLfgAIu+0WQ9qDPMxK38usQw4ZZr83+lOnxp1aSpPAsaoQ0cK7lKv8mW
	 vqX89Jv8LJuepG1l4aqARp99/j54k3iTnZKnCEMkgbsK2PxdY1HjC1JFFAHGHBuMlG
	 JKQu6r0anBTER8Ra9Ongwa2mMZeegK93zPGFLh+DWWVO9ABcXGkKxm6vEvm5zdvlCr
	 QgoK27NMMZKRQIYJIyp7mqCaoaxT59WXvOHWdBkiDYpPMe6900lzv2ZNDV0sZapkaB
	 LQlap7LsVkJ8A==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <c3830cb95b0bb939f9cc9543dfa3047e41532c47.1779976024.git.ukleinek@kernel.org>
References: <c3830cb95b0bb939f9cc9543dfa3047e41532c47.1779976024.git.ukleinek@kernel.org>
Subject: Re: [PATCH v1] dmaengine: cirrus: Drop left-over from platform
 probing
Message-Id: <178092078586.96550.5783440242977246353.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:43:05 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11313-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71FF4656059


On Thu, 28 May 2026 15:50:10 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Since commit 2e7f55ce4302 ("dmaengine: cirrus: Convert to DT for Cirrus
> EP93xx") the driver cannot probe devices using the traditional platform
> device way any more. Thus the driver's .id_table serves no purpose any
> more and can be dropped.
> 
> 

Applied, thanks!

[1/1] dmaengine: cirrus: Drop left-over from platform probing
      commit: 1d736d76c7d16359bae042b8c9fbb0fdac158721

Best regards,
-- 
~Vinod



