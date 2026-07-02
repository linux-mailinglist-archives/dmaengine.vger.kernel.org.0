Return-Path: <dmaengine+bounces-11971-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6IsWB7mDRmqqXgsAu9opvQ
	(envelope-from <dmaengine+bounces-11971-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:28:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24EB6F9684
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:28:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mld9zIRz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11971-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11971-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7974C304B66D
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D74381E95;
	Thu,  2 Jul 2026 15:25:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D3381E89;
	Thu,  2 Jul 2026 15:25:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005932; cv=none; b=FtDCvBOECzOAr7lZai1dtvhDUjVYFAJGBbaZTQ6TsXC+/X3Ky1Al5Eih26OTlvNmfgNJGRJyQTGG2/euMgQwje5Iqy/pdJ3/Ze+stEPXdWswoFib+kAWAsgqyXsbvV6rOzWfEhjRaR6ByGJrVIKbDCAIXeoiBalYNPt8Sqsgx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005932; c=relaxed/simple;
	bh=/XEr68Ab70OWUPgB/b4jZQF+7hBnpfA+l5X1ad/e+QI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=th4NhC48spC77Le2cg6aYwquqpv9LUD2Mn8QTHK8oS1C2PCXLhsfQXwNLvfne72l0cNviE6+9Z1+3bs0g9Rx8usAuqAPi3gmusdJQSU6tshVqG4EpmJprxsIwy4v5I8Ce8jffbZQqCXYypIITCwt/qQwcmRg4mLYGooy8gOQ8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mld9zIRz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756AF1F000E9;
	Thu,  2 Jul 2026 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005931;
	bh=hh1GKcBgtMqoFUkB0LHwE/UJFOYQ6UKfpRoxk/RQ+SM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Mld9zIRzBnjiFW5lin9TsanOqPeEQE/KwS0c4zVNixDNe9FKNlqenqFcbXoKAC5n/
	 YFeVMaEY/nH0xqToUjpnejqS0Ru87jW9UkZmpHJJF4cW6FT5jiQ96MBEJnrSj4grbC
	 d5DJmELYFnr9KcZdzQjBYq4Sz0LhEiqqTafLrAC6l8kfXgZIdRCt8GY4+YyIfK+n2G
	 OKYxbHteRSxxXJSRqfOWB9FySj5aKkHuxsqGL2XOefEybA7XRYaGfKYFJcLOIbxqcZ
	 HZDJoGt3I508Fb4WEkMcFdgm1AU8VBbyZR3Co99O3EQ1V13+qcYW2HKaSnT3WYFQ9A
	 Urn/jSXMqhrHQ==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, 
 samuel@sholland.org, mripard@kernel.org, arnd@arndb.de, 
 Hongling Zeng <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 zhongling0719@126.com, Frank Li <Frank.li@oss.nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260701045733.33654-1-zenghongling@kylinos.cn>
References: <20260701045733.33654-1-zenghongling@kylinos.cn>
Subject: Re: [PATCH v5] dmaengine: sun6i-dma: Fix reclaim descriptors while
 terminating DMA
Message-Id: <178300592710.726714.11534436321396496964.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 20:55:27 +0530
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
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:mripard@kernel.org,m:arnd@arndb.de,m:zenghongling@kylinos.cn,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:Frank.li@oss.nxp.com,m:Frank.Li@nxp.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,arndb.de,kylinos.cn];
	TAGGED_FROM(0.00)[bounces-11971-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,126.com,oss.nxp.com,nxp.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A24EB6F9684


On Wed, 01 Jul 2026 12:57:33 +0800, Hongling Zeng wrote:
> When terminating DMA transfers, active descriptors are not properly
> reclaimed. Only cyclic descriptors were handled, leaving non-cyclic
> descriptors and their LLI chains to be permanently leaked.
> 
> Fix by using vchan_terminate_vdesc() which handles both cyclic and
> non-cyclic descriptors by adding them to desc_terminated queue for
> proper cleanup.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: sun6i-dma: Fix reclaim descriptors while terminating DMA
      commit: ab1150115e68a46b687eb38c1ab92782018c9f2c

Best regards,
-- 
~Vinod



