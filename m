Return-Path: <dmaengine+bounces-11497-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hjcwFKJ/LGq1RgQAu9opvQ
	(envelope-from <dmaengine+bounces-11497-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 23:52:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B598367C966
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 23:52:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VXorvUJa;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11497-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11497-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA30A30E9371
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 21:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9E38D018;
	Fri, 12 Jun 2026 21:52:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D152382296;
	Fri, 12 Jun 2026 21:52:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301151; cv=none; b=TaBvtWzOWa+0J/IqH7JzJY8ikzxuPzTqaAiOrLzuN++NqRuxSNfHdhoU/5QNjZ2F9XC576W1DB9Ae9Kw9yRgxB3xgQUPxXfP5/cK0/V493KEomVBBUCjLVbKF5qX2CN453dlPDY/eJ31ap19WUGKA8WgbjQsWR5ndDNs9odr5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301151; c=relaxed/simple;
	bh=IRz3Du1qtVxZ5gFmKKgbR4SWg6QoR0EnSMAJagWBtq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COtL70YJs4AkvWblL5wOJoccjEYyOfmMktReo3uYO0AlzEKYeeB9ezmszbr6+Rs67T8vcJlzh6jy2KcMrSHGReePSF8DqnMgMFIQDW1QtqiV0nTfubzMz/5zc2c1GO14th2MA02gvYvD7rOHzWBe+iFVtqFlDltDxTRkPQjqw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXorvUJa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168A71F000E9;
	Fri, 12 Jun 2026 21:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301150;
	bh=f9Wh7NvXO66sNsL9eRF3jkvVQcyg+DTDNvWmFLOKnjM=;
	h=From:To:Cc:Subject:Date;
	b=VXorvUJaie1JEFvJ3mt1q5HQtkUfWzFpUxsFjIgebkb+WjeShUqFMT3RglFn/bJpO
	 9Raf9cYpB/359pXknr48+/MK3vWUEmUiv88eRRmM9ScMwGf3KbI1Y7nKR7V02/nAyX
	 NdKguo4HR8azK3h+wAi/dyEmkVDnNWleaj/dFvjHIYfDeP/nGaeAa3BBTjfuOnZ3Sh
	 r/NGCJNiTmqTUvhGnrEVZFksFxwF9l8VkvWEMdQJGDahcxVoCWZ1Mbssx283Tcy1jE
	 SazzDhqwkCeYf0G1NzbU2xGZGpXvRK+ID8FPQZY5cU6v5nyqEq+oawVGx4jLqn8wMC
	 6yyQMmekjb8Dw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Abin Joseph <abin.joseph@amd.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: xilinx: Fix "xlnx,irq-delay" type
Date: Fri, 12 Jun 2026 16:52:25 -0500
Message-ID: <20260612215226.1887726-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11497-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:michal.simek@amd.com,m:radhey.shyam.pandey@amd.com,m:abin.joseph@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B598367C966

"xlnx,irq-delay" programs an 8-bit delay field in the DMA control
register, and the driver stores and reads it as a byte. The binding
described the property as a uint32 cell, which made the helper type
check report the driver as wrong.

Document "xlnx,irq-delay" as uint8 so the generated schema reflects
the hardware field width and the existing driver access.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
index 340ae9e91cb0..ba0fc515d825 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
@@ -93,7 +93,7 @@ properties:
       Width in bits of the length register as configured in hardware.
 
   xlnx,irq-delay:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint8
     minimum: 0
     maximum: 255
     description:
-- 
2.53.0


