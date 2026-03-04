Return-Path: <dmaengine+bounces-9227-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIbbCsnNp2m6jwAAu9opvQ
	(envelope-from <dmaengine+bounces-9227-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 07:14:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3191FB0C4
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 07:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7667304C7DD
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973B37F8CE;
	Wed,  4 Mar 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKHlI7vo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5350351C18;
	Wed,  4 Mar 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772604856; cv=none; b=CVnMffxrh1TlZCFBiENlbYEUSDIB9DEDtPwJKDT2NaOB29/eaKtTMnSbfoopV9FaUs9+G9DsKerKn/CyWRy122j+jt05AhTPSoGLYFnlvAuNqPgZgRaF+D//bD1kPRLY6tbMtWA3cBMMKyErq6wVdDrlwf0jhdu0iXEjcFF54Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772604856; c=relaxed/simple;
	bh=ITg/ig7wrS1ZXLm9pbAOjF/U8W9JlHhbHX5MT6WlX0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NSJeM4OImg8p2Qhk3wBz/VJl1P23DeHyRBXAMF5PsDkNUIpNlQ+5pZfG2QR/T9XAp7/i1WQiURk88UnmZ5xOn6RQiDczu64LBg1jd0PsWYrkChkvM32CfUONqxdjKOLowOHc+qAkBGnDlofgIO8sy24OkZlqJNxPGYFgwmX5xyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKHlI7vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 622BAC19423;
	Wed,  4 Mar 2026 06:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772604856;
	bh=ITg/ig7wrS1ZXLm9pbAOjF/U8W9JlHhbHX5MT6WlX0o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fKHlI7vo1WRqwM3r6iUYfH2eCl3o6uuf8ooLroJYoSX5D8+i16HONe+LOlWSmDEA/
	 mqk7hrCz5mEVO5rfIH63sQjS2lkg63L5KAjDPORjOO5wdUJdMspfosnG1ui75SQ8vl
	 IJijRTXhwc/mz5xrV50MyQbdKz3yLCnG4fINIlHnTOyZiFGRZxljIbT3neRuNOdhds
	 GXuw6BntbiLRWCRaNtFcKeNsM7fDUZv1SwonUwPnDz03y8Zg32UyVlSOtwICKVsGMT
	 gn6rtZPwy1W3oEcQhYgwG41WULqySM9/c7m4g7NUBecE2P7yyroZxNaxmMX/vHpoXV
	 VT6rk6l3zxvTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B5EDEBF7;
	Wed,  4 Mar 2026 06:14:16 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v5 0/3] Add Amlogic general DMA
Date: Wed, 04 Mar 2026 06:14:11 +0000
Message-Id: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPNp2kC/2XOwQ6CMAwG4FchOzvDyro5T76H8QCswBJhBgzRE
 N7dQSQKHP82398OrKPWUcfO0cBa6l3nfBMCHiKWV2lTEnc2ZAYxoACBPK3vvnQ5t3XKtZFaW8w
 tKMmCeLRUuNfcdr2FXLnu6dv3XN6Labr0qFVPL3jMCU6GUJNRqb58t8fc12xq6mHRKhag1xqCl
 ghoE9BWS7vXyU9DvLmdBI2qyEyBhizAXss/vb0tgy4ASSohyWSbz8dx/ACL32ScYgEAAA==
X-Change-ID: 20251215-amlogic-dma-79477d5cd264
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772604853; l=2054;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=ITg/ig7wrS1ZXLm9pbAOjF/U8W9JlHhbHX5MT6WlX0o=;
 b=fjpfIMWfqpeL8CRxzINA9C5cxUZwVJX06v1o7F7JQow0xOWuh2fpVIvPAHYGlMbwtr3l+1uCn
 aoKAGr7CJO1BirRlQeYQnLP4NaWu+m1AD99kRobQCjxde8i/uaFBgtH
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Queue-Id: 8E3191FB0C4
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-9227-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amlogic.com:replyto,amlogic.com:email,amlogic.com:mid]
X-Rspamd-Action: no action

Add DMA driver and bindigns for the Amlogic SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
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

 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    |  65 +++
 MAINTAINERS                                        |   7 +
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amlogic-dma.c                          | 585 +++++++++++++++++++++
 include/dt-bindings/dma/amlogic,a9-dma.h           |   8 +
 6 files changed, 675 insertions(+)
---
base-commit: 3d2d1059cae3abab771576a7ee7f59d9627cfb8e
change-id: 20251215-amlogic-dma-79477d5cd264

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



