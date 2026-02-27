Return-Path: <dmaengine+bounces-9144-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOgzBaBGoWkirwQAu9opvQ
	(envelope-from <dmaengine+bounces-9144-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 08:24:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B31921B3D01
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 08:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A143030FF3E2
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED1F346FC8;
	Fri, 27 Feb 2026 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILCwzRZn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CB29B8C7;
	Fri, 27 Feb 2026 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176857; cv=none; b=KSCOuksPUm4BThsRIs/sUxF2bl6ydr7eYiniLkf75Fp9kfLLmNRtQnnBiTLiCLsQXlfdgFUEMH5wANaIrsAewgwQPRswNlGDFoey1c5y8gJKg30/rrW3Pvqu/im4zb8Dc7iVFpaQatyRx/5aWQPtw2v3Sh8B1XvxiZbfK3cYhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176857; c=relaxed/simple;
	bh=RFltPrKJIjfvmzT/bfePEMqFZoeR7AwOXUkIc6eFgUs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PJpbXf0r36fYuhs4Y5GoNTFyhwZ7j9fKUFNBbPRLfpe5sdbQ6DzdV6V+JUZYCLQK2NM40FV2vQeDrrl1Huo/vg+clJljoepyGWZxNHdk+3FIRB8rv/fl387dhVcQVD0dKMfEIsxa/V0TyMIyAx/kJNp3vw7mK6n/kRzzF0POa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILCwzRZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B86C116C6;
	Fri, 27 Feb 2026 07:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772176857;
	bh=RFltPrKJIjfvmzT/bfePEMqFZoeR7AwOXUkIc6eFgUs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ILCwzRZnWd3wavGv2sibYSPGXn0zdHv2BsKMCybeXKuq81xy9XnldHU6G0RkP4uSe
	 8u1DRtcUIoWl3ymHi7QrJqWMCWf9xQH6Aark+5moAtrijHhAjbBjAWCAOFwXMtaDCI
	 FbSZsa8oGffdk6Vbn1EQ3Y8TZM0uNedLHgvq/U6VIrjzDYGMVYIXHkj+3frnoEgmHg
	 RI9U8ABboiwkTMR2djrnccIoN+cSJkBG9piE0RLd/09deAJM3To/4cOd3O7Ejfgk/1
	 Dky2LpjO9GznG9fuYpijMKcz6XEPU34nRXSNKzAeemsu+hYzat8N7OWww/Npuh5bPR
	 ZPvOyJsiL0WKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A7BFD5307;
	Fri, 27 Feb 2026 07:20:56 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v4 0/3] Add Amlogic general DMA
Date: Fri, 27 Feb 2026 07:20:52 +0000
Message-Id: <20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRFoWkC/2XN0Q6CIBTG8VdxXEeTIweiq96jdWFwVLbUBs3Vn
 O8eulyzLr/Dfn9GFil4iuyYjSzQ4KPvuzTkLmO2KbuauHdpM8gBBQjkZXvra2+5a0uujdTaoXW
 gJEviHqjyz6V2vqTd+Pjow2uJD2K+rh216QyC55zgYAg1GVXq0+d1b/uWzaUBVq1yAXqrIWmJg
 K4A7bR0/7r4ash//i6SRlVdTYWGHMBWT9P0BkgoQtgkAQAA
X-Change-ID: 20251215-amlogic-dma-79477d5cd264
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772176854; l=1831;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=RFltPrKJIjfvmzT/bfePEMqFZoeR7AwOXUkIc6eFgUs=;
 b=bzjyPILUaw6m5l2hdPlILufPYyMLYzUKnLv4OxWZRw9Q3EZa23UIUr07Fng/0ZVBH7vHbja7D
 BfE0iN5Pk/ADimCHoTtopGiCwwmdzu5FPwSbWXRTer9L2P3+XJ8Siui
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-9144-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:mid,amlogic.com:email,amlogic.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B31921B3D01
X-Rspamd-Action: no action

Add DMA driver and bindigns for the Amlogic SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v4:
- Support Split transfer when data len > MAX_LEN.
- When a module fails or exits, perform de-initialization.
- Some other minor modifications.
- Link to v3: https://lore.kernel.org/r/20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com

Changes in v3:
- Adjust the format of binding according to Frank's suggestion.
- Some code format modified according to Frank's suggestion.
- Support one prep_sg and one submit, drop multi prep_sg and one submit.
- Keep pre state when resume from pause status.
- Link to v2: https://lore.kernel.org/r/20260127-amlogic-dma-v2-0-4525d327d74d@amlogic.com

Changes in v2:
- Introduce what the DMA is used for in the A9 SoC.
- Some minor modifications were made according to Krzysztof's suggestions.
- Some modifications were made according to Neil's suggestions.
- Fix a build error.
- Link to v1: https://lore.kernel.org/r/20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com

---
Xianwei Zhao (3):
      dt-bindings: dma: Add Amlogic A9 SoC DMA
      dma: amlogic: Add general DMA driver for A9
      MAINTAINERS: Add an entry for Amlogic DMA driver

 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    |  65 +++
 MAINTAINERS                                        |   7 +
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amlogic-dma.c                          | 585 +++++++++++++++++++++
 include/dt-bindings/dma/amlogic-dma.h              |   8 +
 6 files changed, 675 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251215-amlogic-dma-79477d5cd264

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



