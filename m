Return-Path: <dmaengine+bounces-11275-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AUrOEfCtJWqUKQIAu9opvQ
	(envelope-from <dmaengine+bounces-11275-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 07 Jun 2026 19:44:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B648C651197
	for <lists+dmaengine@lfdr.de>; Sun, 07 Jun 2026 19:44:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dMbze47z;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11275-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11275-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8474300F5D4
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jun 2026 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F8B310777;
	Sun,  7 Jun 2026 17:43:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BED30D404
	for <dmaengine@vger.kernel.org>; Sun,  7 Jun 2026 17:43:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780854233; cv=none; b=J+WLUtokEDdNCtMKbqeaQ+qpxf9Tvr4I0WvIjBBzV4JyYPJ8UkHhua9/PETS7eR1vMp5yw/uZGNGtCBFg1Gmh2gibnYJVXObw0UYgKscQ2YzcRS69wILTuEdWJaPOMrUXd796QmFVovawki6fJd6jZwbxj074lRPXNvwB2WgB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780854233; c=relaxed/simple;
	bh=8mqihYrCWS2UpbQrM26fudrazKOvNiE04KKmAJLxu3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilRTAVBN8pTnrc5qCVZ59nXpm9QpspWnIT7pLf9dRoIDql4p5HgSBhui45K3nSy4xhXWCyv+lwcgSH4hu3KUjPc0UD1BXyZKea7Qnce5Z3z6nfvTMZJKcYrH0IZT5fDlrqC/iXUBEaoyuyo5EM/Gai0yteN/aA1TNuMU+FqoZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMbze47z; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso2021473a91.0
        for <dmaengine@vger.kernel.org>; Sun, 07 Jun 2026 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780854231; x=1781459031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzT+dLha/Dk9hG0MT19SMdgwaEdfoohDSe4reE53O0w=;
        b=dMbze47zz7AltvUBpHozP050bvE6Nrt+AXL5kSFMBrGCZSuvvxkBydCP9CITyA+buA
         40GpAEs+8RejpDm6nk+5M/es+BtdLkrpuqH5TL8a1ajaRkO22QnmRoFHp6HwOMUAfyQs
         tGuXVkHTynGr1QwDa2lYBiAOKb74KLfp7gQoVccQwIUgjn6mXlk8fSgu364E46NzWJqQ
         J1XIJfRn4cbBNz5UuM4t89CXo/dHkmyrPEj/XuZFCYh+EnzlX0M9E18vpSI/ME0KRAAe
         N2SXcrPS3f6h8yLtXNevpemisg/1VDqTfJeIBmzalvOb9RFVb8jdeiuTywazU9DmvEBV
         PXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780854231; x=1781459031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GzT+dLha/Dk9hG0MT19SMdgwaEdfoohDSe4reE53O0w=;
        b=KevhZI4a619/x0H6gDRtTtPJv02ZpZuhElpAtt6DX059o7TwZlnhSs6jN+HrhK6f+x
         V+86C0G2dgkgwDiV4684Ja5CUHfZjA8zaG2mSgyoDlHQk5h9/kzLOgik4gTMJmgDBcf5
         zuETkDPqvAglcUK9SfGGGfHDGsGaQYLJPnNUawR1WUaaW/OxJJfY+kWtvm768EQxMIQB
         i9fPnSzapsxaMEuzuGNQ2ex18J85Vh1taVv4zUJc6Sbl1mJGjIaA2E2tBpHEQAVW/ByA
         Vvz1O4ojSs1hRjc1MjJp9vAZI1tYNAt+jKICNFxWWShqHTM28skOPjuz+IT6CDDnCHcY
         WS9g==
X-Forwarded-Encrypted: i=1; AFNElJ/w04rXa+Tgx5iTRCIDpH/Msj4r+ruIUyUPNVRhhr5rHwWcsAi9XTr55RhC1lwHsiLiT57tBu09+XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpaf2gEdXLkYT68nwKgudmL8Zg3ZInXV2q8VdrYVp9O3G7M4AA
	X5N9DQPkSpzNEBpEpYj/t+9TVOKxSQ/flLh5LKPxJoRia6pPW4PqnBJs
X-Gm-Gg: Acq92OHSVI9lYsMkNu/+ZFoB+SBc/DYAucanpoJMndKKGkak+xaOc/SYnqSz4w57eUR
	VPf3CBS6EJqg27pIo6qclXz7LS8HBTAJO5JObAMeFSF0fKTTxJ5DTlLL3Pq/vvUYNBgd5Jve4Hx
	I68eoI4xEuoCNiwS7lQ3gOownIKXAH6f6HereZQs3Gq0+qNoe+HNZoqKHT86H/5HBY0E1jQKX2v
	I5oO/0SZIO/SNeLXJE3rgGFspGH7RITE6GkXO1m2up4j1JR7+wOIcMAf+gj41YMyclcN6Jgi/94
	QQA4TdoPPov35gCGfUXb+qb2EjIlhBNtZp8htouJHkSa9le0smJU7gLwAVHvmm+BDx6dSh1MXXz
	+rbMQ/j9F7tGexiz8pAPr2rHsQVxECAdh5j5EYw9qll3bdrTO/4NwI1HzIEm28qvhKSYAWiCpIu
	7Uf4o8XKNu
X-Received: by 2002:a17:902:ccc3:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2c1e80ec2abmr129153755ad.25.1780854231461;
        Sun, 07 Jun 2026 10:43:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::305d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ab01sm149171185ad.71.2026.06.07.10.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:43:51 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Sun, 07 Jun 2026 13:41:30 -0400
Subject: [PATCH 1/2] dt-bindings: dmaengine: Add SpacemiT K1 PDMA request
 numbers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-b4-k1-pdma-req-macros-v1-1-5b2a3955007c@gmail.com>
References: <20260607-b4-k1-pdma-req-macros-v1-0-5b2a3955007c@gmail.com>
In-Reply-To: <20260607-b4-k1-pdma-req-macros-v1-0-5b2a3955007c@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <docular.xu@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3119; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=8mqihYrCWS2UpbQrM26fudrazKOvNiE04KKmAJLxu3k=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhizVtWdTW1yfxFrzbTj8v+HD9/re5c4dm+YL1VWyM394v
 235/rN7O0pZGMS4GGTFFFkOH23J3vrKJ9r3OecPmDmsTCBDGLg4BWAiyVcZ/gr9LH/KsD5SIzhR
 VSN76qnbE0/9m/dQ/f025eVb/X+LzPrI8L/ycJbu80Rdq+M7bh+ub7z7zSd+91yToFnvJ+3or/H
 3s+IAAA==
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
	TAGGED_FROM(0.00)[bounces-11275-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B648C651197

Add a dt-bindings header that gives symbolic names to the SpacemiT K1
PDMA request lines of the non-secure peripherals. Device trees can use
these K1_PDMA_* macros instead of magic numbers.

Point the spacemit,k1-pdma binding's #dma-cells description at the new
header.

Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
 .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  |  4 +-
 include/dt-bindings/dma/spacemit,k1-pdma.h         | 56 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
index ec06235baf5ca..0d4ac9849e27b 100644
--- a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
@@ -35,7 +35,9 @@ properties:
   '#dma-cells':
     const: 1
     description:
-      The DMA request number for the peripheral device.
+      The single cell is the DMA request number for the peripheral device.
+      See <dt-bindings/dma/spacemit,k1-pdma.h> for the list of valid request
+      numbers.
 
 required:
   - compatible
diff --git a/include/dt-bindings/dma/spacemit,k1-pdma.h b/include/dt-bindings/dma/spacemit,k1-pdma.h
new file mode 100644
index 0000000000000..491976516550a
--- /dev/null
+++ b/include/dt-bindings/dma/spacemit,k1-pdma.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides DMA request number for non-secure peripherals of
+ * SpacemiT K1 PDMA.
+ *
+ * Copyright (c) 2026 Guodong Xu <docular.xu@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_DMA_SPACEMIT_K1_PDMA_H_
+#define _DT_BINDINGS_DMA_SPACEMIT_K1_PDMA_H_
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
+#endif /* _DT_BINDINGS_DMA_SPACEMIT_K1_PDMA_H_ */

-- 
2.43.0


