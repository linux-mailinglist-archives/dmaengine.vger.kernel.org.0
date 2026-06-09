Return-Path: <dmaengine+bounces-11351-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id srY1Fh9vKGohEgMAu9opvQ
	(envelope-from <dmaengine+bounces-11351-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:53:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C06C8663E9B
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:53:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s+AoRaEc;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11351-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11351-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A0B130B6F5B
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 19:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC143FBB4E;
	Tue,  9 Jun 2026 19:47:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3755411662
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 19:47:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034456; cv=none; b=JlH7BG/wxg5hcfyiokyt+gXsyyU0v41P5Ly6iv2bPK1laDmbd6L9SCgwLiEvReU1eVJQWIqLgrIL87Qen82PmcFNArLkHeLPEcAJfAaj8RQt4VMcuawS4rz6oAn8+OdHsjCp/S/ZBXveM1dKUAoffOcUliOnE/TVM9F2LZO0HWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034456; c=relaxed/simple;
	bh=EzzIUT5MAy1lGbLLNCNBDiXKEEHYTWLc2oHrRYIeMQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/loB/8Bpjj2X388RyeG1Cz951ccZ8EhREjvq9K/J6z0GwIoh0qg+tUkIRhExpGosNbmcXZJaeHPszjcbVNJ8fNBxOTeD94znH1LRhvPJWbD90Yk1y5TTZZMVrpNTnZx8euTB2yhOUilLKfK+SMqdcCn5sC4vna5rjHGTv1aOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+AoRaEc; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8629bed4e7so2048859a12.2
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034448; x=1781639248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ai+yr6kaqjO1MjNvHgFNGMTR2U+5LiRo2MrcPACWJdo=;
        b=s+AoRaEcfE7ZODurP2YnEs71bn3iYwS0v3atoyubJAf8XvTs3P+sgwxz0F/VrWFflH
         18OG61npBxFn+u0vM457TcExER3+4naYeUTrDVYeEWwHWuKy9UpgYqdnOPpIcSE+jk+L
         YrN8DPt1TCZtEc4ntgpT0oasgUKgKcHNuXBpJzI14p7ea5kOeux895T2pr4zfVE6z49X
         LCo4Viz4TA2ATc+tubT27fMWVRMyZUAT5ndCRLDHHCT/4N568DdeqIo2nWFAnDEye+7Y
         24YKP8FReBqoIBF9IQk5kssRV1CiQDD7uJR0YzE2ExpkL5sntrRw8AT6fNpfnQ2uHWBZ
         NZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034448; x=1781639248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ai+yr6kaqjO1MjNvHgFNGMTR2U+5LiRo2MrcPACWJdo=;
        b=F5Kxrp1cFtGfoA653KQaVC3yLQU84IhwdZJYzUQfQHtxSX6wQ+xAIBGAk79ckf1ol5
         71OuE6ky5FVKlX/27InwWJvGdBLsLbYXVFCbq9d0jqPouIF+EDjP2Vqf5J5DKLD4hw6t
         QIM07rIHFNmXdoAVAPAnUJwtdAlydZrliRZiZEeXJS9Vbq2bJ3KXMgzcmh4pPoDSNQyQ
         Kb+3W59MneFdfcGlE5CJEM3XHMO0OFOQTxQZ2U56vi4v4YvCJSpv+gPUs5NzVv5SuGIC
         MJ7eZ0QQhhzLBMYqMWDhIjfa0vaeDBpQw/KDyuBf/P2hGZuEesot2rv7dCKBRL2q//wb
         XnCw==
X-Forwarded-Encrypted: i=1; AFNElJ8AQatHBBL9ao9cTPf83s6g5qHdjs+KZxptQAH08IqYX6JnflL1/E+cLA9z8d+OApA7yGvQu/NLsUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUSJ4DUHyIWNGRmr426UKp6HswWIqdE255vs7UipX7ZAsUy9G
	sw6IxSNGR83tPQ/DIUBi0Jl57rBHHQUc1pc+DWUdA2CMQxVVDJb/QHv/
X-Gm-Gg: Acq92OFkYdRIuAr+5k1dRF6y5n7UXAYO1BCMiBlqxHjjKg4ZA/gPiJ7HBJFeWnCOLr/
	tFLk1UFmrdZ0A5TBl0aTTZDDOc8VNCzj63timCJyQRQeBaZ69aGcSjtrFS56CPMmhdeKrbyTP6l
	anRVn9Jq2bAn06+3EeOo90mzCLo0rbzAHH8+6NtoyVC6RUcZojE7wJHh/FpVputPDi6Mq7s7UgZ
	kfSgeyfX2HSQ26qZCCkfgS8WEDWc++uuCbATT0Y0lX7WAmmZVjo14DgJeKvaoVs7b7hpBJEdxVH
	2lQd5OzSwlPm81pmJWoxu3Qv6/i9dyWi+EY2xiPKbPCV5Dc4G//+gs/mVH92x8FXJUQ80t89TiK
	BCoc9MQFhDDW7eyMpIdT/PLRF0ocKAMxGGaCGMi7AJmik3Zswc4enGhE0bnaQo0/aBRoK8AH6r1
	dTIbx8hYp2
X-Received: by 2002:a05:6a21:1b81:b0:3b4:84de:aa79 with SMTP id adf61e73a8af0-3b4cd09b4f5mr26397065637.44.1781034447703;
        Tue, 09 Jun 2026 12:47:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::3060])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19517121a12.14.2026.06.09.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:47:27 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Tue, 09 Jun 2026 15:46:38 -0400
Subject: [PATCH v2 1/2] dt-bindings: dmaengine: Add SpacemiT K1 PDMA
 request numbers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-b4-k1-pdma-req-macros-v2-1-5d5d7b997b54@gmail.com>
References: <20260609-b4-k1-pdma-req-macros-v2-0-5d5d7b997b54@gmail.com>
In-Reply-To: <20260609-b4-k1-pdma-req-macros-v2-0-5d5d7b997b54@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <docular.xu@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2445; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=EzzIUT5MAy1lGbLLNCNBDiXKEEHYTWLc2oHrRYIeMQA=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhiyN3KO6peH6ogFrT3w3CXzGLPg+vUyi5MExqZDtnurBm
 vzsfG87SlkYxLgYZMUUWQ4fbcne+son2vc55w+YOaxMIEMYuDgFYCK/VBkZvhxyetYgV7N7tez3
 I6qzLtu/sNNOjX8qquLUcUbj4P3D3owMi9eUpqentj1kePg61cHpZbJ18vWTvPtSTles5jmtHu3
 NBgA=
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11351-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C06C8663E9B

Add a dt-bindings header that gives symbolic names to the SpacemiT K1
PDMA request lines of the non-secure peripherals. Device trees can use
these K1_PDMA_* macros instead of magic numbers.

Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
V2: Drop the #dma-cells description change in spacemit,k1-pdma.yaml; the
    request numbers are hardware-fixed and unused by the driver.
---
 include/dt-bindings/dma/spacemit,k1-pdma.h | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

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


