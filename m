Return-Path: <dmaengine+bounces-11986-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C3kgJQqPRmpAYgsAu9opvQ
	(envelope-from <dmaengine+bounces-11986-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:17:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF806FA0CA
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:17:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gEBmqItC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11986-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11986-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1FF6302FCA6
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602B3326D4A;
	Thu,  2 Jul 2026 16:03:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8B3242BC
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 16:03:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008232; cv=none; b=AV524fy/xT/1Cqjb1gYM0a/YrY3gJXs8jH1H7MmYVQ5pzmrbKbcOy9NlLzDuMEPH+UFQwpEqM5rYqu9DUBYL3odAYReqxN9xNBAW1h+ZURECXGWVRdO70PT76qSR0+0Xn8Fmf2y72SH4A0NuyahFAMoF5+ydPrI+4tIavZUBS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008232; c=relaxed/simple;
	bh=nEul18I5MldvqlFcrP9QWyte6ZI6AuOd18zhVdIXJA8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e0Wcm9CvuAFNIm/zgJs1XkSHLjX7jRtZHrmQcWS+rdYv1JcnEscsfoWV0BH16Ji5hVBNZF/q5+qN9IORZMZVJmJWzfjj+19KDCHJMrPUhxpri9NBID6zwu6NsiLKmvsye8OV5wMhde5e/R1T4z0pHQVMYFlujqBEgp638iUvyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEBmqItC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC281F000E9;
	Thu,  2 Jul 2026 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008231;
	bh=fN/+c184JJBkP+Kubh0STnQ/01/ooGVRgaPIa+dzx0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gEBmqItC1jZkuXhcXRaHtN8N/KCDkphgPbRAAcyOHepxM06TcgtpcL4g8s4nWRmqn
	 Xl5q1reZ17YqG6YlcbdSyEEGJVsKLeYEEqmFf68++8wPW23b0QZMRiC6OMZuhsxQEh
	 BvSztJ6we/duL1JVuYzPriWH4t4g9Eyvkw55BHLZQYw43+MAx5DWFlFfmLFir7vG7n
	 fP4U3uRs2fEDeobPw82aesJ2FKMYBYP7A7pp6QTeV3ibS2iwtQDYvM4zko5lxgsjSj
	 5dUHNy1yXeK9l3XFHKWjMWTDEO8vE7++Fx1D+yhHUB4RK0Tf9zloM5Yk5JCNIE1KYR
	 z5neKGznOTdqQ==
From: Vinod Koul <vkoul@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>, 
 Longfang Liu <liulongfang@huawei.com>, Vladimir Zapolskiy <vz@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, Zhenfa Qiu <qiuzhenfa@hisilicon.com>, 
 dmaengine@vger.kernel.org
In-Reply-To: <20260630144214.4080302-1-vz@kernel.org>
References: <20260630144214.4080302-1-vz@kernel.org>
Subject: Re: [PATCH] dmaengine: hisilicon: Return -ENOMEM on dynamic memory
 allocation in probe
Message-Id: <178300822927.756665.7017607086496061232.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 21:33:49 +0530
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:wangzhou1@hisilicon.com,m:liulongfang@huawei.com,m:vz@kernel.org,m:Frank.Li@kernel.org,m:qiuzhenfa@hisilicon.com,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11986-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDF806FA0CA


On Tue, 30 Jun 2026 17:42:14 +0300, Vladimir Zapolskiy wrote:
> Out of memory situation on driver's probe is expected to be reported to
> the driver's framework with a proper -ENOMEM error code.
> 
> 

Applied, thanks!

[1/1] dmaengine: hisilicon: Return -ENOMEM on dynamic memory allocation in probe
      commit: cbabdd6ce1b313b5877c7fbb2f5e2f7936564d2f

Best regards,
-- 
~Vinod



