Return-Path: <dmaengine+bounces-11978-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wWwaOMaERmr0XgsAu9opvQ
	(envelope-from <dmaengine+bounces-11978-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:33:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D726F9750
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:33:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jzm3JnZH;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11978-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11978-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AF5D308BE63
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3161E3148D0;
	Thu,  2 Jul 2026 15:32:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EAC37A842
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 15:32:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006329; cv=none; b=NC+L7n0vUFvLk86Tml1jsRgCsccgodQkaZTP6gU8UUdgHYdBcgaEoqJF89l13kIl5RyJPl0eo+oT32ieK83BMNmzqXVrkwi6fcxGoj2ar27RRaU6MpkDS9SZ7eDTM21DtPyCRCF/ySohNy5r6/Cd2Zpm3wl7RnVhs9ddHYAW/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006329; c=relaxed/simple;
	bh=FzApVQfiQMe+KFDDKOPepOMUsI0skLMOonK6G5v6IyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tcFiY0Mf6/lDDpaPrBA2AwbAoWiEToQAR35psPGTGPxxrlAZXyq2JZS+yvZDaJq6+7Xe49yGfY7/T4a5Eny2UzKniALI+CAkwCMmWQfGV97p9vC3QBtGxbrg0UmEu4k9vXlPvkAODwCHfClDGHUJSa80jhN7nKxFeAA3XdkVjO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzm3JnZH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CAC1F000E9;
	Thu,  2 Jul 2026 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006327;
	bh=/mTDxEEXhf1dHuXuCAdsHsLXruAQZQS4VLT12t4ez0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jzm3JnZHFwt/mqn9jWUA02Owh5bjidWASS5DJ/T1BuIak6b45txHrmHFY2OD7kTFZ
	 hawKT/j3+DeENwu/Y4qX5BKoOhyukLWxpmaylheHpl2c7Z5XG4aMRgNC50WGmMJSaw
	 0XjMKWpCykkafVObJ/OJiT1jPiMefA25l0lSEszULIo4FK3HUvCjWO/vqYVZ7+QVMM
	 51/xXH/BTzmWnRbmA7xrnv6qTjzSrkx609UIL3LD/aZo8Q1+7Pki2XsJDQVO7oBdEb
	 F/nQ2vVaX8qeNOZ5f/EF1yYQjpGrC9AIxl9I/FbIZfBZNySVAIRGDLMZVUOJN+UMbn
	 6P0VdgzeHdWGA==
From: Vinod Koul <vkoul@kernel.org>
To: Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Frank Li <Frank.Li@kernel.org>, Vladimir Zapolskiy <vz@kernel.org>
Cc: Long Cheng <long.cheng@mediatek.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20260701200703.117929-1-vz@kernel.org>
References: <20260701200703.117929-1-vz@kernel.org>
Subject: Re: [PATCH] dmaengine: mediatek: mtk-uart-apdma: Return -ENOMEM on
 memory allocation failure
Message-Id: <178300632440.735405.9920364004468870936.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 21:02:04 +0530
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11978-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:Frank.Li@kernel.org,m:vz@kernel.org,m:long.cheng@mediatek.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[mediatek.com,gmail.com,collabora.com,kernel.org];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69D726F9750


On Wed, 01 Jul 2026 23:07:03 +0300, Vladimir Zapolskiy wrote:
> If dynamic memory allocation in driver's probe function execution fails, it
> should be reported to the driver's framework with -ENOMEM error code.
> 
> 

Applied, thanks!

[1/1] dmaengine: mediatek: mtk-uart-apdma: Return -ENOMEM on memory allocation failure
      commit: 467265c750edd7ab43803deeafe7d3120a791d32

Best regards,
-- 
~Vinod



