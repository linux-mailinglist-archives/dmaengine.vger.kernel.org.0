Return-Path: <dmaengine+bounces-10632-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Dc8Fbq/DmrXBwYAu9opvQ
	(envelope-from <dmaengine+bounces-10632-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 10:18:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6215A0E6D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FCC03045038
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49223A4243;
	Thu, 21 May 2026 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUe1K9It"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19A39FCC6;
	Thu, 21 May 2026 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351174; cv=none; b=RY8103ERlruhqpencC9K1A1gTHjeiUI0mrFUyj7ucBwIfjMnM5PDzc/qT0iMyk5KaOTaatv70h1nJSliYbut2BiyEFLuj+cPrr8KmCNaHZmZO8dQYWNFSBmpoCGtTwWEH3YaaVawQSDocScNkTbpvJikc3+GlmIWaRojQThVvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351174; c=relaxed/simple;
	bh=dVB8HV59AKDkbplOU4oG6hOnwwfesLEdFNSBUC+kk5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZPL0DLhExX77y+j3K/7XizgoFr5lfZI+bnBmC35vFkwwYE+0zWVUAARO3B2u3fsKTIJJ6s+qOnkHpDrBT8l+FPqMi87OOGEr4pBdi6nI6ef75KaEkgnRARSkDHoW2frx9ttP3HwfmP8XC6UKqoeN0KzhHqQBL56TAYan2QDMzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUe1K9It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FB10C4AF11;
	Thu, 21 May 2026 08:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779351174;
	bh=dVB8HV59AKDkbplOU4oG6hOnwwfesLEdFNSBUC+kk5w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JUe1K9ItL9utIDCjWchfDEhhKbcAiSOP8gego+oGKfJXemHuc+xMefZCGPBx9AxfV
	 9kJBQYYlnz7edUL9YU1ATCN7w9orR72viP3YaGHv4UivzcoiQg2EHX+lMQsftGj229
	 bb94NKb1nYevbQvD+P8KQYkMh+0hJdOGEazZ1JBgp7CBGx5uWjkucn+FSQA8LWmTtI
	 ucdcZVD6bf5iQdZ0T9/r9TcFfggdQBumz68SJd5p86bn5Wb5NKF3XKfkZYarx4mt2R
	 OMt2WUDYzU4tkO8BdEXLZObV542/J3Vxs28TB0/FmlxP9kF4CXKs03UyQtJfas3+KF
	 cubzarQCXJ+yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA8CCD5BA4;
	Thu, 21 May 2026 08:12:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 21 May 2026 08:12:45 +0000
Subject: [PATCH v8 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-amlogic-dma-v8-3-86cc2ce94142@amlogic.com>
References: <20260521-amlogic-dma-v8-0-86cc2ce94142@amlogic.com>
In-Reply-To: <20260521-amlogic-dma-v8-0-86cc2ce94142@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779351171; l=791;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=ea/JI9Hvv+vNA+wMdcjhON7BZ5DBq9Qj6Fijtk3no2I=;
 b=VpqzypwBr2y9x03dnOyMlDKg41NxGl/t7n+gGtYbqaf6oAUkGiYlKLKck8RlIagVU/PkcMbNG
 41UH4rtA0NzDdL+2vwxO71uFPNwtQmnTcj3ZHqRFekiADQCKwplBirx
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10632-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amlogic.com:replyto,amlogic.com:mid,amlogic.com:email,infradead.org:email]
X-Rspamd-Queue-Id: 0D6215A0E6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add Amlogic DMA controller entry to MAINTAINERS to clarify
the maintainers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b38452804a2d..e7530b1e7152 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1316,6 +1316,13 @@ F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
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



