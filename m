Return-Path: <dmaengine+bounces-5728-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE17AF6527
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jul 2025 00:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EFF3B1C91
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EE8246798;
	Wed,  2 Jul 2025 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1seghUA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B670805;
	Wed,  2 Jul 2025 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495182; cv=none; b=Z80yotSjq5PRq+tyIRSPfvxiWPmmoir5gAAia5KREtScxsoALqLqivLMFYXWxb3bAArAdI21D9HGS7aPusJ+vlkP1MMWmaSP7IwAsET4zjTMaM5GZq1y7xynpRjDnHEagwUhmY4JiBvDmyKgfSUJMscGgjLjDnHfDqPfToRHlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495182; c=relaxed/simple;
	bh=fSCI8CmVMhipQyZ9gUu71NyTMXRDajaGD5rwkmpXu/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/Xc6RMp/PpJK6RKEbm1bquMwaW/fOlEHj3gAHN7w8twwdJ0OLCSY5b2AxMp/6s+Sq2uXqCVCTH1SRPNKxUYp/RsyEu26CEs0mb0YWa17Km1K0yISy3w/Pka8vVbxK2f+vSFYFYmyr4+Pv2OhY1vlNZZg47F2mp4yRDw2cL+1b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1seghUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68341C4CEE7;
	Wed,  2 Jul 2025 22:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751495181;
	bh=fSCI8CmVMhipQyZ9gUu71NyTMXRDajaGD5rwkmpXu/U=;
	h=From:To:Cc:Subject:Date:From;
	b=Q1seghUAxo2zOZJF500mviQmK5ujL+a/MGf7UlBHv06cmBli3SlCPebUNtCmI3w21
	 N2bvzma3pd2TUfJUUhh5lzzPjYY+drfbbGuHawwYpLDZrfPUdas7RW0xWrEzwPI22s
	 5k9jfw056blo1UIMtfM5fi08W2jsh6njR9oqdd34OCiYBcYFQAFWYZ5qpiJN71uFi9
	 wyyvt2sM0Kq3cIPVc86udx9yzbwqugFyyvVbDyBTyzwN5XopO6l3lq9qRn6gHu8G1C
	 nveEFzdoRy2chG80b9To3CTPdwv1TIGlpTNpp/DWV059vIahfHB4lOAimu9mRRcB3R
	 GcuLRbE2W0tew==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: Convert brcm,iproc-sba to DT schema
Date: Wed,  2 Jul 2025 17:26:15 -0500
Message-ID: <20250702222616.2760974-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom SBA RAID engine binding to schema. It is a straight
forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/dma/brcm,iproc-sba.txt           | 29 -------------
 .../bindings/dma/brcm,iproc-sba.yaml          | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/brcm,iproc-sba.txt
 create mode 100644 Documentation/devicetree/bindings/dma/brcm,iproc-sba.yaml

diff --git a/Documentation/devicetree/bindings/dma/brcm,iproc-sba.txt b/Documentation/devicetree/bindings/dma/brcm,iproc-sba.txt
deleted file mode 100644
index 092913a28457..000000000000
--- a/Documentation/devicetree/bindings/dma/brcm,iproc-sba.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Broadcom SBA RAID engine
-
-Required properties:
-- compatible: Should be one of the following
-	      "brcm,iproc-sba"
-	      "brcm,iproc-sba-v2"
-  The "brcm,iproc-sba" has support for only 6 PQ coefficients
-  The "brcm,iproc-sba-v2" has support for only 30 PQ coefficients
-- mboxes: List of phandle and mailbox channel specifiers
-
-Example:
-
-raid_mbox: mbox@67400000 {
-	...
-	#mbox-cells = <3>;
-	...
-};
-
-raid0 {
-	compatible = "brcm,iproc-sba-v2";
-	mboxes = <&raid_mbox 0 0x1 0xffff>,
-		 <&raid_mbox 1 0x1 0xffff>,
-		 <&raid_mbox 2 0x1 0xffff>,
-		 <&raid_mbox 3 0x1 0xffff>,
-		 <&raid_mbox 4 0x1 0xffff>,
-		 <&raid_mbox 5 0x1 0xffff>,
-		 <&raid_mbox 6 0x1 0xffff>,
-		 <&raid_mbox 7 0x1 0xffff>;
-};
diff --git a/Documentation/devicetree/bindings/dma/brcm,iproc-sba.yaml b/Documentation/devicetree/bindings/dma/brcm,iproc-sba.yaml
new file mode 100644
index 000000000000..f3fed576cacf
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/brcm,iproc-sba.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/brcm,iproc-sba.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom SBA RAID engine
+
+maintainers:
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+properties:
+  compatible:
+    enum:
+      - brcm,iproc-sba
+      - brcm,iproc-sba-v2
+
+  mboxes:
+    minItems: 1
+    maxItems: 8
+
+required:
+  - compatible
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    raid0 {
+      compatible = "brcm,iproc-sba-v2";
+      mboxes = <&raid_mbox 0 0x1 0xffff>,
+               <&raid_mbox 1 0x1 0xffff>,
+               <&raid_mbox 2 0x1 0xffff>,
+               <&raid_mbox 3 0x1 0xffff>,
+               <&raid_mbox 4 0x1 0xffff>,
+               <&raid_mbox 5 0x1 0xffff>,
+               <&raid_mbox 6 0x1 0xffff>,
+               <&raid_mbox 7 0x1 0xffff>;
+    };
-- 
2.47.2


