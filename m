Return-Path: <dmaengine+bounces-11441-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id clseOpZNKmp9mgMAu9opvQ
	(envelope-from <dmaengine+bounces-11441-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:54:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08866ED15
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:54:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ltendcq+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11441-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11441-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A3A4315A235
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A93351C04;
	Thu, 11 Jun 2026 05:51:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABB352010;
	Thu, 11 Jun 2026 05:51:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157088; cv=none; b=m9o5a7TE0CRyLsdOLB3zPphKiY3MRDn50DBKP1dGmSN7mreSSZdAePtiwtKdXnA93ICfCcnzCzNj3urdb1TykDtIjC+U4iBnV4GyN1p1zd5xgbJRRrs3RfwzJ7fV6OlkirJrd9ZulmskAQC5heXYN8h27jVsVZQWOHO1X4X2jyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157088; c=relaxed/simple;
	bh=QKG48vrRFo7Txxgz/yVhR27NhGkUONPhGEj9VJF+7j0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lIbYOigWPw6tLdqJ20o1mRvjzE6JKiTWm0SHmsA5xGBQTRcmzJg3QzHGx/uaUwSwL5XzXJLJjpCG5gfl8pELjiApvN/q/9qfCZCKLtrGENcCw4/I61HaYEknYufFFC2kJoqJ1aBOgEYolCUaJA7ZFU70Cz7Ja4QqmMRHRfzIvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltendcq+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AE61F0089A;
	Thu, 11 Jun 2026 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781157086;
	bh=wU9QahE17CHcvOem5UsKxBBxUuQVPCMM9FqgoNv0fUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ltendcq+AAz8Kp/fDbsuB6K+OqKdl/kL2fMiTeZchbhNIhi8K6spbNhLwcnfHj+Gd
	 kxtiVtmL3YdkKr3dwsVJqJgoWQez95r6u8PymmfpHYkxniT/nmwlwf+feqDFXeDsqB
	 aCoW4wrYb+WmUfRIQcw3GeIYHLKw0eRXH2Lp68T++tsDOZSk1ho22cr62N+lYgBySL
	 l44GV9AlHGrn7+T1xASigUXew50l8EX9/F0Jj8cPUnIrSu6Zk4s/d+eeRsBPAY5Jrz
	 g1Zlv2lCGQOypJkhiLSb7kPCkAfkepx0GYqIvyHuGEWX5MesX0mc18xLJlgTDzZ2Hk
	 V5Ef0FcvGOpjg==
From: Vinod Koul <vkoul@kernel.org>
To: okaya@kernel.org, Hungyu Lin <dennylin0707@gmail.com>
Cc: Frank.Li@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260607163119.78717-1-dennylin0707@gmail.com>
References: <20260607163119.78717-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] dmaengine: qcom: hidma: use sysfs_emit() in sysfs show
 callbacks
Message-Id: <178115708382.468137.8784208588482548501.b4-ty@kernel.org>
Date: Thu, 11 Jun 2026 11:21:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:okaya@kernel.org,m:dennylin0707@gmail.com,m:Frank.Li@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11441-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E08866ED15


On Sun, 07 Jun 2026 16:31:19 +0000, Hungyu Lin wrote:
> Replace sprintf() and strlen() patterns in sysfs show callbacks
> with sysfs_emit().
> 
> sysfs_emit() is the preferred helper for formatting sysfs output
> and simplifies the implementation.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: qcom: hidma: use sysfs_emit() in sysfs show callbacks
      commit: 26f926b44dbfc035d5ba0ccfc4387a40aa9947c1

Best regards,
-- 
~Vinod



