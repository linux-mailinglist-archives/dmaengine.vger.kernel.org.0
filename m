Return-Path: <dmaengine+bounces-11970-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XFOTC1aGRmphXwsAu9opvQ
	(envelope-from <dmaengine+bounces-11970-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:40:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD106F9877
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:40:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lWN8sBUL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11970-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11970-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E125030745F6
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E2353A9B;
	Thu,  2 Jul 2026 15:25:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48C381E96
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 15:25:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005928; cv=none; b=DRE1FCzlfQFSNCjkAQb33M6/pchHb2EAT/B3iTrF/IDBwK0TnuRKgikcG3L71Ev8oaqASrf1EvrUFzvrAEec42xbAXrIX/ILsGYjVfL2AVpLgcAbdaiYw5LYNOGBGjypk+G4uE4TNJoPO4vUtQzde2YlylrJeLb4iNOFPsYGwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005928; c=relaxed/simple;
	bh=nPp7tCW21B1G2xtjOJ5l7kC4vVGd5+2qxvhgHTsuyd8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UQnjZYBKqcoIpCrfFc9fjvuPdW1EcakPGvtYHf+KEDw8z5fVOeHQk7t6eSRqYz3nBD4d3wnaURXilM8NbQh6cskjGf6GltlVrR59trA1XU7na+IUvcG5VgqmiptmUIwKU/uKhCPrdQAFoZqOp7MCq6tYsdXEJ+Ha6649+FF7Gyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWN8sBUL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66B51F00A3A;
	Thu,  2 Jul 2026 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005926;
	bh=NcsNrksdrPM4tBhpuukCzWqBRyNUb4wrgMSeL9A/Y4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lWN8sBULB3uBdvaYkofB4WrMUl3+YNCAws+HMnKWbvqgu6/WibDdxgpMjVXSsQJaQ
	 mFLsjNt/yPI+/lMoJhq6TfIoRNQ0DjP/6W9YDdsvty5fkZQw96H74eJdy0FxNofHgy
	 ZWM9zgNFqMQ16BYMOUQVGzNu/S3oirCSQEULss1oXJyG4TDohpSC5BNWHvDlvqVQi1
	 y05bhEjhD1UvM2K2kfEtB+mf0OFfXTFy1cU+Kojq1efaDpl7xE+nQgBDvNN9gm3nSn
	 4JxwYxlTos1Tb2sah79xRilpMCmm8oIgVKYyKGCLSiSBIjXoztPhKzIM23JUkvZfZl
	 eGtEOufd7dDyQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kelvin Cao <kelvin.cao@microchip.com>, 
 Logan Gunthorpe <logang@deltatee.com>, David Carlier <devnexen@gmail.com>
Cc: dmaengine@vger.kernel.org
In-Reply-To: <20260317083252.13224-1-devnexen@gmail.com>
References: <20260317083252.13224-1-devnexen@gmail.com>
Subject: Re: [PATCH] dmaengine: switchtec-dma: fix FIELD_GET misuse when
 programming SE threshold
Message-Id: <178300592530.726714.16124040528136338861.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 20:55:25 +0530
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11970-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,deltatee.com,gmail.com];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kelvin.cao@microchip.com,m:logang@deltatee.com,m:devnexen@gmail.com,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BD106F9877


On Tue, 17 Mar 2026 08:32:52 +0000, David Carlier wrote:
> FIELD_GET(SE_THRESH_MASK, thresh) extracts bits [31:23] from thresh and
> right-shifts them, which is the inverse of the intended operation. Since
> thresh is derived from se_buf_len / 2 (at most 255), bits [31:23] are
> always zero, so the SE threshold is never actually programmed into the
> register.
> 
> Use FIELD_PREP() instead to correctly left-shift thresh into bits [31:23]
> of the valid_en_se register, consistent with the FIELD_PREP usage for
> the perf tuner config just above.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: switchtec-dma: fix FIELD_GET misuse when programming SE threshold
      commit: 9d12eb98582fec2578d17e025b13740dcfb57d8e

Best regards,
-- 
~Vinod



