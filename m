Return-Path: <dmaengine+bounces-11647-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9bFULkUgNmqS7wYAu9opvQ
	(envelope-from <dmaengine+bounces-11647-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 07:08:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A226A85A5
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 07:08:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KlkcFr2X;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11647-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11647-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87BA63037495
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 05:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308F71B4F0A;
	Sat, 20 Jun 2026 05:08:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49611A5B9D
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 05:08:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781932092; cv=none; b=f8kSIc0u6qMdbYrueRz4S+1EkLBESm6tzUE5HjbGhfZ/NVT7W+hBevEU5GiFiTuqD6XIi3j9U6NxUBdON4qr9Duqs7TS0kMbayRsdHkSVhCPdP38opS6zJtHWwPOXrmljReHwQdSkmfw5bJDwzURLPzWoBg2CwnJxcomAtlixnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781932092; c=relaxed/simple;
	bh=LepUJJTxmkYMO860gHHna5A2hsGG1CLcmny62OJUIqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vBQoWIBaoG8J8dNX/hpHDe4lpDWshzJzoQCx0J6IRDRzjpkIuaVQVSqvCwl4rgrPVZ+AKg9PbMGJ8i91R7Fb6qZ1dArkRx5CqzgsLDgZ6SPhqP4cwmdpIi171ZOa+Gp9RVPp0JNEhg9qGzmovKgn5RFND4b/WeuWACcovLofZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlkcFr2X; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf22d29dabso16855135ad.2
        for <dmaengine@vger.kernel.org>; Fri, 19 Jun 2026 22:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781932089; x=1782536889; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTkwWAeY0fntOQ2aGm5ZI6wJA7Nh3ySr51xxoVIYuRM=;
        b=KlkcFr2Xq3yAbqHt45IAng6gvO+ZkhrJiJgyUrEEmfDaZoyh+tqlyt+ZqnWfEXtXJ1
         pmsVbLmkXz1Es52ateSE/Sv5UOM9CmDyn3pb1KCLuQcVLoW5lDAatzRj0+Y89TpYt6dR
         IAuw3pAxzPF+AiGjeVix1CbEsZknHDak3ON1OpIPIxfZ8AR8jtXuw61dCndvfxYN3ZWb
         7ulXLqAfq5vwAayi0aFkVsRYXzxJJ11hd78h7mFGI7e7Mz+fSY2ki/kkR7bPBPY0Yevp
         jQ/bAGFQ1vw2YAB4vp7HmvY+hWkk+zKsraN3zXyJN6jBX2AR1QaWKw+bKR4aMk7gkhTn
         KgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781932089; x=1782536889;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTkwWAeY0fntOQ2aGm5ZI6wJA7Nh3ySr51xxoVIYuRM=;
        b=KODsPauHzj/Rs/C2xoRLkHWxd7mwkb08Fl52vcAjnummbAMeRXTGsFA/v25X+oigRe
         S+TxqLyco3wGlld06yz90GyNRhB2OpY+qbjLxCwtU7h4y4X3f0Ny7Zh7kPAKTqSShIE2
         LUDBhWwWV/20ogDSgDG4fkUJDAbcIAUwyrAWAiBMMDCQBGiJjyUh4L6HQ7Qv3x4blEmM
         lFhoVj5ehc362N7VxpGFjMYmZ/OBJiYFKHob7WSRzeeR5pQ5GJ78Uyafku8r0bbdgYR5
         PTd1K5U60JI7PEj3hZHGi2kculINax0FyDshlAbaLmSqqCT8pTi4Ecb2SUgsl9vXONUF
         33mA==
X-Forwarded-Encrypted: i=1; AFNElJ+rXPJKh+6wwQ9vqYUH/1rUHJMTLdkAt6f7DSaqVD6pUglvQI5SneI3UIkivcPBQKdiaCFoELMha1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fbdi/UbpvBdGHfRem45qYJP2zjnI5qBzqVEyxGPRpqQQTf31
	3LwXqa+wzWEYs/ASQ9rOVPc9x7yTpYIlabIjYaJcwypmAd49uMq3ODZhfd684sLd
X-Gm-Gg: AfdE7cnP6Y5gme9y8hKfARpB6Vd7J7hDzrCT8s+DNvZBLbW7Y1uzI3ICaGnrDYpki1a
	kP1ngQ2FlIUJbWGj08U2H37S9bRoXNls43E+KFp00pX1+vli3kvoBshTqQPPgG4PElCsfZAdkxq
	WVKz4iKuNXuZNJ2OveVNMbhGJkOkbPgpU3TxxjV+Umoi3ZZcLLJJ1z59ZYXG/RSY5mg6ziG5+q+
	IYQb0FGY7kUwvKT26PAEFyVKydxi5IH3lXwydG5eMma2C4Mi2vnWuM2e5ZvEpkxFvT43heQ1TKA
	6LFTwG1OCsv3h9N2JtWVrM8DMNGS30CtZ0/ChnqYzpxNbrFSy4e8zFUgmhTn9de20DlN5DV1yIB
	4z27bKUB2sXpvr43rn8uNg0NC8XLIttWroWK3tBNtcBSz3hrkFjy+dNjb6xgCNIk=
X-Received: by 2002:a17:902:fc46:b0:2c6:b768:a7de with SMTP id d9443c01a7336-2c7422c36f0mr20594985ad.8.1781932089122;
        Fri, 19 Jun 2026 22:08:09 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::302d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aad99sm12129435ad.80.2026.06.19.22.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 22:08:08 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Sat, 20 Jun 2026 01:07:48 -0400
Subject: [PATCH v4] riscv: dts: spacemit: Use symbolic PDMA request numbers
 on K1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-b4-k1-pdma-req-macros-v4-1-3cf77d0bd0d6@gmail.com>
X-B4-Tracking: v=1; b=H4sIACMgNmoC/4XNTQ6CMBQE4KuYrn2mr9AWXHkP46J/YFVEWyQaw
 t2luCEmxuUkM98MJLrgXSTb1UCC63307XUK+XpFzFFdawfeTpkwygQVVILO4Yxws42C4O7QKBP
 aCIVlUliKTNiKTNtbcJV/zu7+8MnxoU/OdAlLjaOPXRte83GPqffvo0egwDVTWck5pdLs6kb5y
 8a0DUkfPVsq5S+FJcVyK3VZSs3zbyVbKIi/lAwQlCtyFJQzLnGpjOP4BkmQwFxYAQAA
X-Change-ID: 20260607-b4-k1-pdma-req-macros-8d276d0126df
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <docular.xu@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4256; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=LepUJJTxmkYMO860gHHna5A2hsGG1CLcmny62OJUIqQ=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhiwzBe3D6clH19TUS7QZ6617bLAq/x530h2p6/JKE++55
 rhsFRDqKGVhEONikBVTZDl8tCV76yufaN/nnD9g5rAygQxh4OIUgIkIVDAy9Lz32CdTsoZBov/u
 2vvRyzcefjqV4V+CrIuhU+ezTNfrxxgZfpznzjtwQGH7tPeMLGG69y0rP3rPiPzfb3YzY4p2pec
 lLgA=
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11647-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dlan@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:docular.xu@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:docularxu@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17A226A85A5

The PDMA request numbers (DRQ) are fixed values specific to the SoC from
a hardware perspective. The detailed definition can be found in K1 User
Manual [1], Chapter 9.4.3 DMA Connectivity & Assignments. Add a DTS
header file to define the symbolic names for the DRQs of non-secure DMA
peripherals.

Convert the K1 SPI3 node to these macros.

Link: https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k1/k1_docs/k1_usermanual/9.Top_System.md [1]
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
Changes in v4:
- Rework the commit message (Yixun Lan).
- Trim the k1-pdma.h file comment (Yixun Lan).
- Link to v3: https://patch.msgid.link/20260611-b4-k1-pdma-req-macros-v3-1-ae8416052571@gmail.com

Changes in v3:
- Move the request-number macros from include/dt-bindings/dma/ to a local
  DTS header arch/riscv/boot/dts/spacemit/k1-pdma.h (Conor).
- Squash the header and its user into a single patch.
- Link to v2: https://patch.msgid.link/20260609-b4-k1-pdma-req-macros-v2-0-5d5d7b997b54@gmail.com

Changes in v2:
- Drop the #dma-cells description change in spacemit,k1-pdma.yaml; the request
  numbers are hardware-fixed and unused by the driver (Conor)
- Link to v1: https://patch.msgid.link/20260607-b4-k1-pdma-req-macros-v1-0-5b2a3955007c@gmail.com
---
 arch/riscv/boot/dts/spacemit/k1-pdma.h | 56 ++++++++++++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi   |  4 ++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-pdma.h b/arch/riscv/boot/dts/spacemit/k1-pdma.h
new file mode 100644
index 0000000000000..7e5ad3d7111d4
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-pdma.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * DMA request number (DRQ) definitions for non-secure peripherals of
+ * the SpacemiT K1 PDMA.
+ *
+ * Copyright (c) 2026 Guodong Xu <docular.xu@gmail.com>
+ */
+
+#ifndef _DTS_SPACEMIT_K1_PDMA_H
+#define _DTS_SPACEMIT_K1_PDMA_H
+
+#define K1_PDMA_UART0_TX	3
+#define K1_PDMA_UART0_RX	4
+#define K1_PDMA_UART2_TX	5
+#define K1_PDMA_UART2_RX	6
+#define K1_PDMA_UART3_TX	7
+#define K1_PDMA_UART3_RX	8
+#define K1_PDMA_UART4_TX	9
+#define K1_PDMA_UART4_RX	10
+#define K1_PDMA_I2C0_TX		11
+#define K1_PDMA_I2C0_RX		12
+#define K1_PDMA_I2C1_TX		13
+#define K1_PDMA_I2C1_RX		14
+#define K1_PDMA_I2C2_TX		15
+#define K1_PDMA_I2C2_RX		16
+#define K1_PDMA_I2C4_TX		17
+#define K1_PDMA_I2C4_RX		18
+#define K1_PDMA_SPI3_TX		19
+#define K1_PDMA_SPI3_RX		20
+#define K1_PDMA_I2S0_TX		21
+#define K1_PDMA_I2S0_RX		22
+#define K1_PDMA_I2S1_TX		23
+#define K1_PDMA_I2S1_RX		24
+#define K1_PDMA_UART5_TX	25
+#define K1_PDMA_UART5_RX	26
+#define K1_PDMA_UART6_TX	27
+#define K1_PDMA_UART6_RX	28
+#define K1_PDMA_UART7_TX	29
+#define K1_PDMA_UART7_RX	30
+#define K1_PDMA_UART8_TX	31
+#define K1_PDMA_UART8_RX	32
+#define K1_PDMA_UART9_TX	33
+#define K1_PDMA_UART9_RX	34
+#define K1_PDMA_I2C5_TX		35
+#define K1_PDMA_I2C5_RX		36
+#define K1_PDMA_I2C6_TX		37
+#define K1_PDMA_I2C6_RX		38
+#define K1_PDMA_I2C7_TX		39
+#define K1_PDMA_I2C7_RX		40
+#define K1_PDMA_I2C8_TX		41
+#define K1_PDMA_I2C8_RX		42
+#define K1_PDMA_CAN0_RX		43
+#define K1_PDMA_QSPI_RX		44
+#define K1_PDMA_QSPI_TX		45
+
+#endif /* _DTS_SPACEMIT_K1_PDMA_H */
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 08a0f28d011fe..7d414e15d2cc2 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -6,6 +6,8 @@
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
 #include <dt-bindings/phy/phy.h>
 
+#include "k1-pdma.h"
+
 /dts-v1/;
 / {
 	#address-cells = <2>;
@@ -1094,7 +1096,7 @@ spi3: spi@d401c000 {
 				clock-names = "core", "bus";
 				resets = <&syscon_apbc RESET_SSP3>;
 				interrupts = <55>;
-				dmas = <&pdma 20>, <&pdma 19>;
+				dmas = <&pdma K1_PDMA_SPI3_RX>, <&pdma K1_PDMA_SPI3_TX>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};

---
base-commit: 793cc54475b49b5b558902b5c13e4bfe66530a50
change-id: 20260607-b4-k1-pdma-req-macros-8d276d0126df

Best regards,
--  
Guodong Xu <docular.xu@gmail.com>


