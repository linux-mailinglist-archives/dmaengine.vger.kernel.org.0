Return-Path: <dmaengine+bounces-11782-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zfDnGXMTPWq5wggAu9opvQ
	(envelope-from <dmaengine+bounces-11782-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 13:39:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D00236C530D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 13:39:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NKDQY4ii;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11782-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11782-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E1EF3043C30
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9643DBD79;
	Thu, 25 Jun 2026 11:36:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F53DBD7E
	for <dmaengine@vger.kernel.org>; Thu, 25 Jun 2026 11:36:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387370; cv=pass; b=Ci1D9JbbYrLItE8pMzCJvWw0vWnRXUxeJlIKm/fdzVIqYnfZLnMFTnPJmhOPYzZOYtLnL+/hfqqllPB6wioBwqIt9msrg/EGFHE98PK2H8qIyf3TIpK+JVFvgg6xJlKMYEOCLCMGT1Qy+vyTHB8ssKIL7zY5l3mFHDqZ/uY1e8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387370; c=relaxed/simple;
	bh=mqnxSrM0lxR4wBFtxZ2B9ZfKeGhkUzfpM42QYzDdZ1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVoEtK56oUa13nXwQ6+RNeL4jpUCnkyjsbpeM1MiyPYzACuaAskoNYKeMIqgceVdnSnfHPj5i+2b0rIXmzztdAEceymxZmr0eoC2TISC8Sz1g04vzapP+QU0lIwqgX6uVE5WGrAxyGmo98L41562yT60BHPrR99VYwG9QXyZl4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKDQY4ii; arc=pass smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso7554895e9.0
        for <dmaengine@vger.kernel.org>; Thu, 25 Jun 2026 04:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782387367; cv=none;
        d=google.com; s=arc-20260327;
        b=RNUIh19oe85ry9Pev1svjcAEO+AGe0x4zrSXfFAj9LjJkkpdRU6VhlE38Zu3neSIYK
         6qw6yLJW0PNivybZRHcwVc6995cd0YLJUydbR1EBAvMtxhvbqKMkZVssWD6U8R22fiGt
         YhEgke2BDI5eOF8CsUCwAPFkgGwFKk96SxLV2oPt72Ls8Jih1T6UF1BK01NNfkbzQl7H
         lnpEvAlHuLebZKeH5dGE4YCjp+aUN9hxLLMr9i6GtA0kktNZMIFhQUscb3hl3zVoi9fy
         JJheu6pmf4hpzNvJETvLX9vqetMkmgaOtwxZYZbXT/mBBL3EPD4nt0gX4mRhi+1ms14s
         SqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mqnxSrM0lxR4wBFtxZ2B9ZfKeGhkUzfpM42QYzDdZ1w=;
        fh=kq1tV+fMRfEsGrofSbBk5DyS0PKZLY+7X1v3YWSh0nA=;
        b=QRqYbZloJHPZS7N2weez/aL3+d1Y3N2voONuhSqH+ZUYV3RuKMd4UkA3H/Fp68v4S4
         jYUeUiLfcETAMSrG5LBvfx49P3UyzjT8SNrPr5fXrh4V8ySWDCRsoxhayY/Q3waNW6n0
         qt1pqv6DHnQB0r/D/lg0B2N1V3PYhInOA9V1GwX8MrFDZFcVFOIw2d6wgMXmJa2UyN5G
         TaZjdJ57g4Nd3/SgMDtAtGo5+70w/zb0QGJcstHuP74RdN9PMrGbGbYiWkkdCleQEYDv
         oKcQfGpqYcqjkvFIJRIHbE3S98/v2xJILdkr1HOyIiRTgcFNaWmTYXcKL0Ksb9+NRx1g
         x5BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782387367; x=1782992167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mqnxSrM0lxR4wBFtxZ2B9ZfKeGhkUzfpM42QYzDdZ1w=;
        b=NKDQY4iiC1pzT+nEBcG85Fe6ahBlvFuVcBJrO1hHh2hShcva1T2soKT7gJVRKAqyZi
         QdNEAf64eoycjHyh8CrG0xnu1IsuKKVQETLCLHLbb8TcJyPd9ywZzJIG5qE49FOE8Z5Z
         +nGmaE6cMKmh6pmcZH7MtUkvC6mZYwyvDJO4C7+gk0xmEEL+WCM/obxobNVZbkMkWsRn
         szx2WCIPqZ8mJzAgBw/KC2dKpWgiExI13icoguZ0ZkXlHBG0/iELxJlq3SGjCf1S1WTy
         qBJRzdTXk88qi488PdItExni99Cgo59Hn3OqDRHqO6lin8CDmxy6kTQclgmn1+5UET4o
         m2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782387367; x=1782992167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqnxSrM0lxR4wBFtxZ2B9ZfKeGhkUzfpM42QYzDdZ1w=;
        b=qJt4s8UGIwDSwZQT/0OrstVFAMCjgtD6W7IfuM0021/QVy3ifFs/4SxZ9Q7/BO4KEB
         LTuI97Gko4Pfb1SjsbXSHA+OXJk8Ssze/h4aP1HHADxlgEneuGOOCYkKNSfjNbzEZVm/
         q+woY9Zle5/76hSF5Cmv0Jt3/EqLFcPIXEZuFbxYZvVUzAcCvNWnDwRbqmwaFAnlENvk
         gZhnl7u0atsB8NEgur+UoE1Oti5FMGDyBjy1HU1i0BeacGEbucwaN7V5s9lysFHpEhLW
         bUknu45ihKD4KD+exx8UENE7l5kR17gv0gys7vvs/ZxD6lStQUab6rdJUH26zbZG//LY
         z3Ng==
X-Forwarded-Encrypted: i=1; AFNElJ/5Vz0UMv31qPLK7VKx4GyHy0GUTKm3HEVHrHrIDo4eByfzy9p28HVtMn/vr3NGRbq0N3cec5R/xkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvpNh1acsRwQJ8uInvAD0Oo1CXCYeC0HZeH3W+RjkypNh8vL1X
	UoRXRhKnlnAqv2UIDf5ewe2SMKPSnP2GhHPCh+vRpVBXxymdNVgutG3RqnIikymFAzSFk8Nv2cv
	mTwEw9cgvxeZ1Q7wqwU3JgoOc1nB+a9A=
X-Gm-Gg: AfdE7cnKcCj96q6OJ8LPQDr0FtlY5wBDPlVKJ1IMcmYsfOzbeaqAV6D7f8OlN8Xq3iE
	x8EYg99P0xEnpUA0KnCJU+LKX5luMITfqIFECiSKHS5liMleoTF+Zo2vY2N3PONTbPwHpGZDrii
	xRE6C7QXciu5cMudXaZYijxQeZwE8UpcWUgLYdoUjU2ALhsO9o89lQpY9qh/4n8KANIkR+TptyZ
	82Kd7NNXHafV/tkVkJv/DQy9Qc+Q4NX+5Q29aq/hHHkXzx/P7DsML6gK/IJqDDqDGeifUSI
X-Received: by 2002:a05:600c:3b89:b0:492:37a3:acda with SMTP id
 5b1f17b1804b1-4925a0444c4mr179542695e9.0.1782387367114; Thu, 25 Jun 2026
 04:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521144755.3476353-2-maoyixie.tju@gmail.com> <20260522150214.95651-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260522150214.95651-1-maoyixie.tju@gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Thu, 25 Jun 2026 19:35:55 +0800
X-Gm-Features: AVVi8CfJMLI2Sng1aI6l6C-FWjmdEBjifoGjzPJg9jDE7xicikpiLptFGKbuLY8
Message-ID: <CAHPEe=FfcGHh1MaNW4e2K2P7x+C1KG+xzpD8r=c8q8_CGesgmw@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: mpc512x: fix dead empty check in mpc_dma_prep_slave_sg()
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Geert Uytterhoeven <geert+renesas@glider.be>, dmaengine@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@nxp.com,m:geert+renesas@glider.be,m:dmaengine@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:geert@glider.be,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11782-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D00236C530D

Thanks all. I'm dropping this one. Using list_first_entry_or_null activates
the recovery path, and calling mpc_dma_process_completed() from prep context
isn't safe. It runs client callbacks inline and can roll completed_cookie
backwards. The empty free list is real but rare (all 64 descriptors in
flight). The safe fix is to return NULL there without that call and let the
tasklet reclaim, but I can't test it on hardware, so I'll leave it to you.

Best,
Maoyi

