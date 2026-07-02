Return-Path: <dmaengine+bounces-11989-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1gwJJ2qNRmrbYQsAu9opvQ
	(envelope-from <dmaengine+bounces-11989-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:10:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E46F9F9D
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 18:10:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=baIPguAv;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11989-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11989-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361F630D1AB0
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12965337105;
	Thu,  2 Jul 2026 16:04:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F483191D0;
	Thu,  2 Jul 2026 16:03:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008240; cv=none; b=KF9IQEyTGQ7VEKwCWDceTcm6BzZkBvZP34lKLoaFIacigNOIk7WKYsVASBFxJfjvS3TPm86AmjHxbBnJeHp5h5Y6QyZx9a9aR8e0KhNSLeGCwvdRMYgXccBlQiSp6svmqIPpvjoaSA6bq5i8KIam0IB6IIpRzQhCFHWiEzvzU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008240; c=relaxed/simple;
	bh=6WCsBtauGs0jbSD0RozMlJ3oNpKF0SdumFnEHYhTqis=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ar1gKmoBSuvUM+WVYtFdRsdQbSjqCYXCfx/dbYrDAtgTQljIQrINBmfKMQYRrVmQJArHldKRmD/q5c+bUroakwBZQrnddIz/FrSSM7vfiEHtnTQuDfk/C3JAu5CgY5nhFQdKio9Z3Qf/7jS03Mr/otpKXzxKkSN63a14uVakmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baIPguAv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66A51F000E9;
	Thu,  2 Jul 2026 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008239;
	bh=3fcl0RcQcAfXVTMYgP1q0Dyxg0wpJdAxTInm3RhLbe8=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=baIPguAvKETmAJPu7uefNbAGr5kxPDxwB5ztk/cp/4kt+1mPRTjcxCkyHOOYITAkk
	 nPobSMZSeaQZ2ET7EepcmF5TJsxLnOjn0HHv2gYhozA67iFQzfMqkdKLkvb6USf+JF
	 yR2PqejlxNSA2zsV/n7qbwuI4PR7MWKvQfilqjaq5BqnMBSXBRM2ea+DoHLdwbFh2r
	 jYmi6Ny1SsOtvdThs3m6ZFIzIn4dfbF77bM4ADKBKTA/UBR9D28KjLO4dRi0ibuS23
	 ysY/LHfh04iixsvZGliEkJr/9WQZQM+jhWHVfUC3bOMrizIG6M+MKbS5AlqI5pB0EE
	 clKGIIez/Z15g==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pengpeng Hou <pengpeng@iscas.ac.cn>
In-Reply-To: <20260615091645.28878-1-pengpeng@iscas.ac.cn>
References: <20260615091645.28878-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: pl330: remove debugfs file on teardown
Message-Id: <178300823744.756665.4078114802972621720.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 21:33:57 +0530
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
	TAGGED_FROM(0.00)[bounces-11989-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 179E46F9F9D


On Mon, 15 Jun 2026 17:16:45 +0800, Pengpeng Hou wrote:
> init_pl330_debugfs() creates a debugfs file with struct pl330_dmac as
> private data. pl330_remove() then unregisters the DMA device and frees
> the PL330 channel/thread state without removing that file.
> 
> Keep the debugfs dentry and remove it before tearing down the DMAC state
> used by the debugfs show callback.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: pl330: remove debugfs file on teardown
      commit: 0d3e3376b289cdaff5b3b6c1581999926ff1000f

Best regards,
-- 
~Vinod



