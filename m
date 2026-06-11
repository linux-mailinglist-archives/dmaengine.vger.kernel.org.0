Return-Path: <dmaengine+bounces-11457-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VI3/KX+1KmpwvgMAu9opvQ
	(envelope-from <dmaengine+bounces-11457-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 15:17:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175B672478
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 15:17:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="rgADs/dF";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11457-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11457-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FCFF3008C09
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9A40B6FA;
	Thu, 11 Jun 2026 13:17:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D93FA5C7
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 13:17:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183867; cv=none; b=tCcxVzETuH2l6dJvNLL0tOGXGuwohF+x062vKhvTPoVWhU1bK6VH9KNeK6HsiJwnmNNLy0Hli4XN1TJZiHMIijPGx7HOxlWnPznJtXypmsyYYEsSPfCMOkZVrizgB1b5bXHkpFy+7gQPo28uKmm/HKgxoB8kSbR5WT9uJGUEt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183867; c=relaxed/simple;
	bh=ioxeCNvToivxf1SJbAe6EIhY0aEComaoX+8RNwBtunE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fzJjmb2PK9iPaMSK4l57rfAzNnbmOhPSYozmkzGX6qn+0c6/N33TtrzYwJ6WwYwYK0bqHcFSu9NdOTicY6KKp5jMRKBS6Kii06kcZeIhCtu+ufBbLurRBtWAJdFqFIaDLZ0HOi61uQ5/oSZoHvHIMNDA83Xxlio1cfDMhwYUjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgADs/dF; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84237c55ef9so3838469b3a.0
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781183864; x=1781788664; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/xQJbFkRRowzEJ+ZDzKMiiLUlhrEmEVF/BkBQLOp88=;
        b=rgADs/dFrcS2wSQ6pF4C3j8MXVBZdH/204/249icRSwj73ux9Eohy09XT+1TRb9ZE7
         m3onpTDhBMYWhhEN2/5rhOhYb6ynpWjkrHCds0muxivzkHps6Mglqsm8R6/5GlefuG4S
         vcikiANUc4zDeJUZ0f+L7fCXkRJcIYBzgRNPGYrtN1ysFkT7B4clARonymUG6ui1pUKP
         O2EQsIlJX+emuJkBOgLMWDbZa2Oqkzb12NgAuq3k57SQxmLBMFCV/t8GdBAt2mHssBwq
         JH5UgwFoCLQ3ZdL2HOkTaah97Rc9SFveUWkjdLP3fbPseMBeZ5WF1/JLry0KVC7YgRCY
         jWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183864; x=1781788664;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/xQJbFkRRowzEJ+ZDzKMiiLUlhrEmEVF/BkBQLOp88=;
        b=UcZ2+kbtQ/GmKB40cgTTo/7BLXhLGGFsDBnLmDX4j2eL9LYv2u82xBkEiOOwnfsnWn
         MOmh9ljg8g2dw4Jl8E9nEBpuR/DmX/tMQz2lqxohsIsafSe1YIsFP3h8Q8RG5uFCbA2r
         olPzTW9Hx5Rd292Wdtqz614gKJuQDlh1gi+glTFKlYZ8i1Bwm5mgLC8GfRXZOPT48Ih+
         sdPVTlU2hCTPzuBgFCAu6kU/fwouNp/PCLZxLgV2QKaD2SzWnTkyko9urfjE8r6WgEJO
         Y00a9PDYRup2LXwG3plbCbmgfNggxpUhK/m4Si9omWIJ5llN57eTh7y6eLdpAsq7TAr8
         D2sQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LFYFlJCCK3tEGmOsmN2VQNxxuQoS5unU8WvWYd5EwvNa1LmNg861+TaBe9jv+L/+09JlLCcNaCvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofgMOU5S0pjaR8dPgbnBsLbbB+xSN/IVDJklTh3P62sQLVlJA
	xm5QAOG2qmVO8wWrSckc4Ml2FSVzEivHyHNdSnOksHa5E7vizgjqy1Qd
X-Gm-Gg: Acq92OHvnod8v7gDMPZTBTKxgG7rrgunTU1Ijaz4ANgib+1ynfk/F8Oi1x4Pr4UkHgU
	CM8oppXvrQyXG0fS9zSs2auqsmxkaBz9sfsg5eUqVhmCPpZtJax8ptm5b6QT7JqlT7LaZ65NCZu
	Opx22MtPWcaFd4ndR9MTUFHvvm2HJvnHSYkNW5jGvCmVQ62kQ+x2/bZmA/JGwszGjYGNzy5TzeH
	eGgefX4PYB4vvuY04aKCdZNyQobxzBJnw3V1HmdZsBep4IGuaj5j9aeNqm4e6wenGhxHwYvHzP5
	qkQACEAyNEg+8ejmhIe5YCNALEbZ6S2uqHxsssebv4HcISoOoKrjOeAC0E1dDiUdSo9+OSNhb5U
	vnmtrhm+GJ62ES+P65FEgUhbNlfoyDHomcqHYS/oRX6Zxm/g0Tof7L9/c8bQ2be1Z6yIX645gau
	zmLdjM6bAT
X-Received: by 2002:a05:6a00:9517:b0:842:33f3:da68 with SMTP id d2e1a72fcca58-8433679e608mr3293724b3a.8.1781183863777;
        Thu, 11 Jun 2026 06:17:43 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::302d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843382e5caesm1986491b3a.44.2026.06.11.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:17:43 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Thu, 11 Jun 2026 09:17:28 -0400
Subject: [PATCH v3] riscv: dts: spacemit: Use symbolic PDMA request numbers
 on K1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-k1-pdma-req-macros-v3-1-ae8416052571@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGe1KmoC/4WNTQ6CMBgFr0K69jNtoa248h7GRf+AqgVskWgId
 5fiho1xOcl7MxOKNjgb0TGbULCji65rF8h3GdKNbGsLziyMKKYccyxAFXAj0BsvIdgHeKlDF+F
 gqOAGE8pNhZZvH2zlXqv3fPlyfKqr1UOSpUXj4tCF9xoeSdr9a4wEMDBFZV4yhrHQp9pLd9/rz
 qPUGOnWUv6y0GQxzAhVlkKxYmuZ5/kDFDYsGBIBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4245; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=ioxeCNvToivxf1SJbAe6EIhY0aEComaoX+8RNwBtunE=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhiytrbnvZJce2757oSbnnvVLs9gtdA5sj2HeuHBP9bul/
 NbcJsdmdpSyMIhxMciKKbIcPtqSvfWVT7Tvc84fMHNYmUCGMHBxCsBE6tIY/kfE/V+SIxx451+e
 5NKwM/kq3b3dLoKG8+eunnZRuPvuP32G/3lXSuROr9onNc390cECnuzV5S68Jt0vp72MnP1EQen
 wDQ4A
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11457-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4175B672478

Add a local DTS header, k1-pdma.h, that gives symbolic names to the K1
PDMA request numbers. These request numbers are hardware-fixed; their
allocation can be found in K1 manual.

Replace the hard-coded numbers in the SPI3 "dmas" property with the
K1_PDMA_SPI3_RX/TX macros.

Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
Add a local DTS header naming the K1 PDMA request lines and convert the
current user (the K1 SPI3 node) to the new K1_PDMA_* macros. The request
numbers come from the SpacemiT K1 User Manual [1], Chapter 9.4.3 DMA
Connectivity & Assignments.

[1]: https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k1/k1_docs/k1_usermanual/9.Top_System.md

Changes in v3:
- Move the request-number macros from include/dt-bindings/dma/ to a local
  DTS header arch/riscv/boot/dts/spacemit/k1-pdma.h (Conor).
- Squash the header and its user into a single patch.
- Link to v2: https://patch.msgid.link/20260609-b4-k1-pdma-req-macros-v2-0-5d5d7b997b54@gmail.com

Changes in v2:
- Drop the #dma-cells description change in spacemit,k1-pdma.yaml; the request
  numbers are hardware-fixed and unused by the driver (Conor)
- Link to v1: https://patch.msgid.link/20260607-b4-k1-pdma-req-macros-v1-0-5b2a3955007c@gmail.com

BR,
Guodong Xu
---
 arch/riscv/boot/dts/spacemit/k1-pdma.h | 56 ++++++++++++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi   |  4 ++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-pdma.h b/arch/riscv/boot/dts/spacemit/k1-pdma.h
new file mode 100644
index 0000000000000..65112d5847add
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-pdma.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides DMA request number for non-secure peripherals of
+ * SpacemiT K1 PDMA.
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


