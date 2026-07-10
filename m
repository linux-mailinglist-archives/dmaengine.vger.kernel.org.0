Return-Path: <dmaengine+bounces-12264-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fOzPI7mHUGpE0wIAu9opvQ
	(envelope-from <dmaengine+bounces-12264-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 07:48:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E72AB73767C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 07:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=fLoaF4LQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12264-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12264-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1943023A67
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 05:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E90C394EAD;
	Fri, 10 Jul 2026 05:48:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F83314BF;
	Fri, 10 Jul 2026 05:48:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662491; cv=none; b=M/vi1FCR05TY3KzDrGsEzbP6gMl7nn8GvDuhUNDMKo/FV3Rw5GBYSxkXBisvMKYKpb9GntKCZFhdQEIH9VYdACKe9ZyqCPiiJPnh7WAj7cxKrp+BAdvST/Vm/3M4UXcrIZ62xVjj7s1JW/uwZ0kYXTvuf6MB8skezrLQeWEjn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662491; c=relaxed/simple;
	bh=NcdLhXrPcWFclpxrmSESajR2JcjuoXQBKnYxQjejsnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bg64b6CVd9oxLfDw7/tfjzic7OIwWoMc5KimNYhtJpw8nMzJufboZysw0fdUrrtKz9AsVTjqd/69qVfoumBP1/VcyIPJKzwh3hBoC1CZ8jjdLCUgtSr09Kw5mCSmyJt+YujTXti54MLPq7pTEeL73r8A6LhSLGgbTCTgi5qnZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLoaF4LQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0541BC2BCFB;
	Fri, 10 Jul 2026 05:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783662491;
	bh=NcdLhXrPcWFclpxrmSESajR2JcjuoXQBKnYxQjejsnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fLoaF4LQeWpnwE4OhMmtZ9yUCvJu+MG4TpB5ziYnVWIRSmfWcoGnzEWPG/iT8OPe1
	 HgV0X4CdVkNPwxsWitV/4NzimfefC00PFcZadaiKsFrJydeP3rAaknasAE824dklNC
	 7jBgUMN8WI5eTaOKQTJQKADTeRVwnr1fGG/JSylz3AKVBQRVRewZG3MhnKg4a556jF
	 05XE6XSeASsmzdv1Sdjy+npcJToNejoUAso8yXfYewkBWiX/FT/QYzHi79mUobfN7m
	 VdPbTmaTi3fhmcuLa0SrJ4mL0DRHJkqzdw54MfE3ZAB1o2ZU4aMNJSM5zTbxwS1pht
	 qFVPJAA/R8Y8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03FBC44506;
	Fri, 10 Jul 2026 05:48:10 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 10 Jul 2026 05:48:08 +0000
Subject: [PATCH v10 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-amlogic-dma-v10-3-ff4deae837e7@amlogic.com>
References: <20260710-amlogic-dma-v10-0-ff4deae837e7@amlogic.com>
In-Reply-To: <20260710-amlogic-dma-v10-0-ff4deae837e7@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783662489; l=791;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=9xq7fFe8x3ZtUEb/et7K+dc4J+CzRRN9hABeSR7Mhcs=;
 b=sfIqATjqLFmWCEHr6Wu5cpoP9tttYIHVG+mLvgrmQ1xFyTtYG76XrR7sSl/GBkDXl+FUmxqt/
 jp2BtODFwsACJupNTUus6OhCarg3IwLeqUwIxmScbD9SFS2Xq2m2h0K
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12264-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:Frank.Li@kernel.org,m:linux-amlogic@lists.infradead.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:xianwei.zhao@amlogic.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amlogic.com:replyto,amlogic.com:mid,amlogic.com:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E72AB73767C

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add Amlogic DMA controller entry to MAINTAINERS to clarify
the maintainers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e7b2d9e9c24..b4ef8d3f52cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1307,6 +1307,13 @@ F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
 F:	drivers/perf/amlogic/
 F:	include/soc/amlogic/
 
+AMLOGIC DMA DRIVER
+M:	Xianwei Zhao <xianwei.zhao@amlogic.com>
+L:	linux-amlogic@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
+F:	drivers/dma/amlogic-dma.c
+
 AMLOGIC ISP DRIVER
 M:	Keke Li <keke.li@amlogic.com>
 L:	linux-media@vger.kernel.org

-- 
2.52.0



