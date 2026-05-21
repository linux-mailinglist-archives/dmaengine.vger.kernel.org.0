Return-Path: <dmaengine+bounces-10631-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLEGK6y/DmrXBwYAu9opvQ
	(envelope-from <dmaengine+bounces-10631-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 10:17:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD05A0E5D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 10:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0C23037E6C
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7EC3A3826;
	Thu, 21 May 2026 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDvWzpJ0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4C38423B;
	Thu, 21 May 2026 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351174; cv=none; b=evAZP6v9ozQiPXtXnR1pPECKpVi4hrHprkCX8uZL4CLJ4odCqmzAZBSriA2UnSeG97F0HHcOjteOKMXy22hFhiopHOrYZNUlLtCZwDB+8Y2E1uIppoxPaGkq4mb/exJx7Fwo1LiZKkVq9W+o7AfhRvtvynNwe9Su2K+qkIqF8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351174; c=relaxed/simple;
	bh=hzuY+yyFO4sjo8dhrrxQOewW27XSqB9N4XeCHFH8Bqw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GEUMArAknJq5J/S/+RgzSCqf2SygEoeS2KL75AtfOiy2keQfRLZKTgFMLOnznegH55djgVfZDcsNMYgffODr38abvBTBep9mgZEPIZSuOARK/DOb6K2LWbuq0Smfqez2QmWmnfEyMFmE1MzQnec9/Dp+Vpbg5bjc4mtMmTcbEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDvWzpJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36642C2BCB4;
	Thu, 21 May 2026 08:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779351174;
	bh=hzuY+yyFO4sjo8dhrrxQOewW27XSqB9N4XeCHFH8Bqw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jDvWzpJ0Tg46huG0qtCO6n9siW+ORI289/aRALbc6QT+6699spl/L80hID+tYJgSC
	 fqg6qzuBkhG+mOGIlHmbBW40Mq2ZGpqBcMgvvvW76D0XPh9EmdsaML9LjIQXYE/SXT
	 09piLu0PzZ675f7rCW663JQGlHut9sabtncz1TdeYQcJXahfHZvRoDETSixVLY48hX
	 /UJvZZeczBdCUWwnN1Q4aFe7uyhhFyT09o4Ug9tbPHIVX7pCIrwVQE2NCU7/24VDVN
	 DiUH0PuSvtyQaKoJZJO7uqVD38DAiomIoq553pOl7xnWHpk2P8dDPF8+PNlvkLWJEc
	 Xp3o5MAI1cldQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6BBCD5BAC;
	Thu, 21 May 2026 08:12:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v8 0/3] Add Amlogic general DMA
Date: Thu, 21 May 2026 08:12:42 +0000
Message-Id: <20260521-amlogic-dma-v8-0-86cc2ce94142@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHq+DmoC/23OTWrDMBAF4KsEratijWYkq6veI3Qhe8aJoI6LX
 UxK8N0rh4b4p8sn8b03NzVIn2RQb4eb6mVMQ+ouOZQvB1Wf4+UkOnHOCgogA4Z0bD+7U6o1t1H
 7gN4z1QwOVRZfvTTpem87fuR8TsN31//cy0czvz563KpnNLrQAmUQ8hJc9O9/v69116q5aYSHd
 oUBv9aQNRIQW/DskffaPjUUm22bNbmmCg0FYYC9xoXebmPWDZCgMyih+udyempb4FpT1jEiWTb
 YMNq9dksd1tpl7azFwGArxmqv/ULDZtvPl5dVMCImQG3WepqmX6z2Ue0cAgAA
X-Change-ID: 20251215-amlogic-dma-79477d5cd264
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779351171; l=2587;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=hzuY+yyFO4sjo8dhrrxQOewW27XSqB9N4XeCHFH8Bqw=;
 b=oEdhIYPsTCEUZteX9hT0ke1NATls0bgvNDdiBomI7mCB0YBdDQOlt1AsoeipLBqwO+ctQwEiH
 xWcwlvsf3dwCcQOUnc1657XU3u1U/SGz75RMgtXZv+XGdmpUQGFEQLb
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10631-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amlogic.com:replyto,amlogic.com:mid,amlogic.com:email]
X-Rspamd-Queue-Id: 18AD05A0E5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add DMA driver and bindigns for the Amlogic SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v8:
- Use kzalloc instead of kmalloc.
- Initialize the temporary variable and fix a spelling mistake.
- Link to v7: https://lore.kernel.org/r/20260324-amlogic-dma-v7-0-f8b91ee192c1@amlogic.com

Changes in v7:
- Take use vchan to support mltiple txns.
- Link to v6: https://lore.kernel.org/r/20260309-amlogic-dma-v6-0-63349d23bd4b@amlogic.com

Changes in v6:
- Some minor modifications according to Frank's suggestion.
- Link to v5: https://lore.kernel.org/r/20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com

Changes in v5:
- Rename head file and rename macro definition.
- Rename the subject in [2/3] from "dma" to "dmaengine".
- Link to v4: https://lore.kernel.org/r/20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com

Changes in v4:
- Support split transfer when data len > MAX_LEN.
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
      dmaengine: amlogic: Add general DMA driver for A9
      MAINTAINERS: Add an entry for Amlogic DMA driver

 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    |  65 ++
 MAINTAINERS                                        |   7 +
 drivers/dma/Kconfig                                |  10 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amlogic-dma.c                          | 682 +++++++++++++++++++++
 include/dt-bindings/dma/amlogic,a9-dma.h           |   8 +
 6 files changed, 773 insertions(+)
---
base-commit: 0b1f98df9cf024e9f1a43e0ef9c16d3466d17746
change-id: 20251215-amlogic-dma-79477d5cd264

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



