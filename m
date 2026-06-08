Return-Path: <dmaengine+bounces-11318-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KEHsFmWzJmqObQIAu9opvQ
	(envelope-from <dmaengine+bounces-11318-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:19:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8249656131
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:19:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i2vA+bbJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11318-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11318-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F9993081CE4
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A326379EE1;
	Mon,  8 Jun 2026 12:13:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286B379C45
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 12:13:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920801; cv=none; b=EEumFYrHT4WIWrwnNxx/fQi2fyxgq/uySx5GGgjK/wVK0ccPqqCJvilYiyc5iNjK2s1SlHzX0xv3SjOKFYjIK9EVEMsZe7kUeBGjCvSGe0eVpg2yUPIP6n8Hpm80WakmYP6f67V9uzvEcKyugr2Bv7zkw0Y7bzGm537JlPlW8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920801; c=relaxed/simple;
	bh=WGc3PeODadgGJTYFmb73G1wqBayTvLlCVWcffcILCS0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g9N6ip5/zHgzVp70lEbVfk40IeLt85Bs4DWufZZ7+OPsFIxwscVP0HOVUeBHGiGoK/x404zekmuDTVjOXskouBNMHgplC5/JwRYUdrYQUHMB3w16+oBHB2YvuFaLNSoBvI75+MR8gm2lXeV0kzl6FFqPEMFMdWPe9xvU3LqKAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2vA+bbJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801BC1F00898;
	Mon,  8 Jun 2026 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920800;
	bh=iWgAokzavpqmec2YiMNbooYltQWxuP9rTl2xaj0elE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=i2vA+bbJCF0M2n8NGQLYN3xg9VyQn0rdOxE2W8826R8Ng50JVr2DZLLRBgxcXMoP/
	 IrlZBQ3lypF1mMFqL03DtvmUNxej7LwMN806zsAbF0OmS9AtDH1yPCawL0VGfLa0NB
	 gA7YjFphMuLhxkFNtYvLVoBH0uh2YaRv/mZ4crojhrRq4Ghz2CaFl033RnX3T1eccf
	 FfOVRgg39/aWA60fhtHml3Xa6ATosX2b7quYAacecXX3IkP1Kle92vv0yy2QA2CaGx
	 ZjgJBOegKs3Trd2qXWqnyMGydJj4ZE/8gyZXohf3b9yvlOxgyfwAHFt1vrffyg3SUI
	 n2qZA+zpwygYg==
From: Vinod Koul <vkoul@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
In-Reply-To: <20260114051508.3908807-1-vz@mleia.com>
References: <20260114051508.3908807-1-vz@mleia.com>
Subject: Re: [PATCH] dma: iop32x-adma: Remove a leftover header file
Message-Id: <178092079913.96550.13876541717008221519.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:43:19 +0530
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11318-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:vz@mleia.com,m:linux-arm-kernel@lists.infradead.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8249656131


On Wed, 14 Jan 2026 07:14:58 +0200, Vladimir Zapolskiy wrote:
> The Intel IOPx3xx platform was completely removed in commit b91a69d162aa
> ("ARM: iop32x: remove the platform"), and it'd be safe to remove an unused
> and leftover platform data specific header file dma-iop32x.h also.
> 
> 

Applied, thanks!

[1/1] dma: iop32x-adma: Remove a leftover header file
      commit: b2d44b3ea95e10315559d8deedd8af2977c7f534

Best regards,
-- 
~Vinod



