Return-Path: <dmaengine+bounces-9613-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM2HDl1NwmnvbAQAu9opvQ
	(envelope-from <dmaengine+bounces-9613-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 09:37:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B12304C2A
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 09:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 624EA3073C7C
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF233D16F6;
	Tue, 24 Mar 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQlt1Xvc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985A3B6BF1;
	Tue, 24 Mar 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340913; cv=none; b=cixjXVc9wjyMAIQJQygvAz1Zc0P+gM7f4IykxlCHfMJApSpTURA9yfxsiSfGssU7ltQGJRwXxUtJZtBAWJ5ID9l5hqQUkExrEiUrkc1JD3EJzk9wx8In3fNMxELwzWyyTJO3iuFF9aYHROkL/z6hXoLUa0DSv0SyUq+HhLRbHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340913; c=relaxed/simple;
	bh=GUHvuweWwDEanr6pMLHDaloqrj5OS4LjWFK/HLlQMOc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nT0U0gZ3Ki+Qsudu3u7kUZrMblAEowDdXWOLhIisBTMI/lMTXeNTmDlbO69DKRXF2J4dkOr6TJNVACUMXvtfVSm2XJUpTbbmcoVt1i9dCJQxRErxolGc+GRiVGV4jCbf6WuNN0x4emZqc7R9Hfm81FfMyEE2LXbdZV7xGoHFoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQlt1Xvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68B44C19424;
	Tue, 24 Mar 2026 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340912;
	bh=GUHvuweWwDEanr6pMLHDaloqrj5OS4LjWFK/HLlQMOc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jQlt1XvcUUbFdhQ0mEw+Ns7DDoHzzkJXO41dHvq6NsFRx0bAEh9OoqFU9wruNzEgA
	 rLqsKybK0Cgqy5RpTo54w5gRGXTfyjEc643yMHx1Bsz5FqUHGtwJBc8zbeaQohb/ay
	 FcwkeSNb6rZSuheSklloaUcY54v+Mb5ZlkuSsqtqhoi5DpyeC1eVmZ10/TDkM03uZ5
	 qchAOoH6IZ17aPRZiUdZhY3lVjI5Ez9ewhY9AdhZCrtV8M0LenzzrLWu8YZBUt5OhO
	 EvjlatUSq/F8T3SkkaaBZdx3Lrn+SgxbLci0nR26+xLtr/IbqiI5XtayhH6Xhu/W67
	 ch0cudFjMTKsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E8F532F2;
	Tue, 24 Mar 2026 08:28:32 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v7 0/3] Add Amlogic general DMA
Date: Tue, 24 Mar 2026 08:28:26 +0000
Message-Id: <20260324-amlogic-dma-v7-0-f8b91ee192c1@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACpLwmkC/23OwW7CMAwG4FdBOS9T49jJstPeY9ohrR2ItFLUT
 hUI9d0X0BCE7vjb+n77rCYZs0zqfXNWo8x5ysO+BP+yUd0u7reiM5esoAEyYEjH/nvY5k5zH7U
 P6D1Tx+BQFXEYJeXjte3zq+Rdnn6G8XQtn81leutxVc9sdKMF3oKQl+Ci//jbvnZDry5NM9y0a
 wz4WkPRSEBswbNHXmt719A83bZFk0ttSBSEAdYaH/TzbSw6AQk6gxLafz6nu7YN1pqKjhHJssH
 EaNfaPepQa1e0sxYDg20Z21ovy/ILUrO8B94BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774340908; l=2377;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=GUHvuweWwDEanr6pMLHDaloqrj5OS4LjWFK/HLlQMOc=;
 b=9EbQS3w9WGhhASrwGp6av1fS9ubYNcbdzl6H7tFdfQXVqNoQRyy//Fwsl9BXqmVal+z5WwGax
 BNpu30ZxB6VCfB5sbyGNRZMveLyCnkCGQZzumBokWkK4RZ0fqlCEfCo
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9613-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:email,amlogic.com:replyto,amlogic.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16B12304C2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add DMA driver and bindigns for the Amlogic SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
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
base-commit: 18171b875aa51c7b1770005f048528c95bd95e40
change-id: 20251215-amlogic-dma-79477d5cd264

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



