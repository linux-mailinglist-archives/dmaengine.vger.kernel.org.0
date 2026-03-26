Return-Path: <dmaengine+bounces-9657-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFN6D4PsxGm+5AQAu9opvQ
	(envelope-from <dmaengine+bounces-9657-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:21:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB2331334
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3A093068E98
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 08:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A33B7B75;
	Thu, 26 Mar 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="vDl0Dtx9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658103B774D;
	Thu, 26 Mar 2026 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513151; cv=none; b=THjGh549brBpNun79Dxp4zwsKc6q+RB22x2hMJi5uJP65BrwtNI5Nx2gefGQ1BrLbbwZMaTXnrr4GhorRC4WfosMUv/VUcSmA7sMY8tdLN6CX0B/rs4pZhzUr3gBKRIKDR7YPkCkLJaBB6VjJoX1j6mqIcia375zgA65JpmfIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513151; c=relaxed/simple;
	bh=oAQ1CPCjK6eoWK1aqV0q/JBJz7zlqifINFRiwbzN/m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOYPUu7cpj48k35PGX9p3mU89MFfruFZQkihebIjXd46HfRwLhqkg7bI5ozpipmQ5ekbZnFNPKsNxgvilHxwtLKYJocqRBSobwfnFjlFqHYU45gW6Tb/z+9wjjcb35xCGnno9fNg1WyZLbX61EGxG64Gs4KfOfIVaXNFuS9MKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=vDl0Dtx9; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774513093;
	bh=4HDoQydiOZHCDTR+FRvJn/63D5PYUaAMeBviZAtewek=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=vDl0Dtx9xTiWnpX4RhZGHKks2bd2V2szN5czj//99mhG4FIUo/ogA3xpEs9bJgFf0
	 1+5tEft0lxk/QFjj1+Q4vZffXhgTH1NDt24wEtkeENyqz+ZA6HfPwIwnq+ij4BmNlw
	 xbqtmQLl6nhrVYeWHCIJcbxsDelFRoRbFGgyN2Fw=
X-QQ-mid: esmtpgz15t1774513091t83fea2d2
X-QQ-Originating-IP: isfwicqU9QpqGG3DKUWwcuIz0qdEDCv8uB5gNdNV1V4=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 16:18:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4668696482951093507
EX-QQ-RecipientCnt: 21
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 26 Mar 2026 16:17:18 +0800
Subject: [PATCH v2 3/7] dt-bindings: dmaengine: Add SpacemiT K3 DMA request
 definitions
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-k3-pdma-v2-3-ca94ca7bb595@linux.spacemit.com>
References: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
In-Reply-To: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Guodong Xu <guodong@riscstar.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, 
 liyeshan <yeshan.li@spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774513072; l=3027;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=adZDW2pZlag8F0MozvpqFlsQylZC9Q3Cmhte/nPUn3s=;
 b=/qPUi8PzPiuQUchYFmaLuzqm8fGmM4pb/88oHx66rI1c9AsqI0xCDub1zeUwaD6Or7KJz4F6O
 d7WMkhjTa4LAC48zCTggJLC/IVXtvVlNjyCvmuVkgVP8QkuAThgd+Ml
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mlhj+zxRobshU1X5r8weBBEZ6VOpOc+66MAe2w+zX6q6hFRHwRp9IWbh
	l/95KazVCZz0nasdfO47TLRbM1ax4lwp2vNdt5EPeyCYyeBncYzgJAuIiIC9aqqciSPDDAn
	ruF+2Y/zVUDSuo0XXZrggNXrqTMTC3g9niq5R+AcTGCRBsrpIIAkzrnaruxVqShX7KXezoH
	pTqMPvaJhUt3y2LjkPC5Ui2PE03yU37egyrpeSyZvazqisvvuEUiUgoilNqhb/1sVUPCpXM
	ddp0/piiTPAp2+283D8/JAnUP4mgfmvQj2XXySmAKswEnKdp8JfK9BymrJ0d/Vqmf+YqBLn
	GqpGnrSxWDwRJUOnFDPAgm2xoxq1WtUv2wNl1KtUUkdqs7Ec5mbpAXaonzUK8rBWh5U5jwa
	3D4zUTTGaxqhADRPKf1JTNIt/VA7M9bjkpMuv3G56WklYt0PG5414eBITYrQGyWNvpu02kQ
	o0PuEJRXQMcc8Asz+MYZzNiEDkd3dsaUNACw/uykpmu9V7Q1A1eCp5FQ6ssUTOC7c4H50e9
	El3dZBgSuvUe51zMMTa5gbTAbrRzv7cg4pjk8KAgWWDPgHlQ/AlmlGJlmBr+aWfZoE37KcF
	j5p4ACN1bhOpcueONIKbLkuc6YOKOVcfB4rMRm2B/h8D46R6pQA5uJnc0EjcJYhVRJj/+Y9
	rOq6OO80X/s6IuWc0uOu0g9RL+q8W/XMqmDYrKBqpcywldC+w7hZ5eUCJMrY3noYdQrDB0T
	QSIg0EgY3d4LmK7xEu5/YdmkXveoB1tra76UAo2DIBlE7+tfsZjwRUSYzHG0Yq1qHPsOzsI
	SDbR+tScI+5Ek1u29a0RYulsVdjPtnJttWsJ57CTnUKhR5LKw9u4WbIa/tsU35sr0roIErt
	vIIq8esNxrbelsZ6z+AEaxGMVwB70QPBAdhvColzaRIlubPhvcftnvcK65Qz5ynW8UYdhl5
	KFmhZnSGIWGtu/K/PwnKa7RjCYwHafxsdMFXvox8WDR5bOU7sLT602tYZCz//gOy2hlOLp9
	YibBKxp52Wq5XqDGBM7F6s7zAL8vurm2aEeSUju7GQXAhwsIgd8pq/w7aObCivGzz7GBNX1
	3ewmS0Zx+tQiloTcgesHtKtuJHssRgBADPPIkTVcv5P4KfE03MeQfA=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9657-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[troy.mitchell@linux.spacemit.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.spacemit.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,riscstar.com:email,spacemit.com:email,linux.spacemit.com:dkim,linux.spacemit.com:mid]
X-Rspamd-Queue-Id: E0EB2331334
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: liyeshan <yeshan.li@spacemit.com>

Add device tree binding header for SpacemiT k3 DMA request numbers. This
defines the DMA request mapping for non-secure peripherals including UART,
I2C, SSP/SPI, CAN, and QSPI.

Signed-off-by: liyeshan <yeshan.li@spacemit.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 include/dt-bindings/dma/k3-pdma.h | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/dt-bindings/dma/k3-pdma.h b/include/dt-bindings/dma/k3-pdma.h
new file mode 100644
index 000000000000..05541a9a9973
--- /dev/null
+++ b/include/dt-bindings/dma/k3-pdma.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides DMA request number for non-secure peripherals of
+ * SpacemiT K3 PDMA.
+ *
+ * Copyright (c) 2025 SpacemiT
+ * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
+ */
+
+#ifndef __DT_BINDINGS_DMA_K3_PDMA_H__
+#define __DT_BINDINGS_DMA_K3_PDMA_H__
+
+/* UART DMA request numbers */
+#define K3_PDMA_UART0_TX	3
+#define K3_PDMA_UART0_RX	4
+#define K3_PDMA_UART2_TX	5
+#define K3_PDMA_UART2_RX	6
+#define K3_PDMA_UART3_TX	7
+#define K3_PDMA_UART3_RX	8
+#define K3_PDMA_UART4_TX	9
+#define K3_PDMA_UART4_RX	10
+#define K3_PDMA_UART5_TX	25
+#define K3_PDMA_UART5_RX	26
+#define K3_PDMA_UART6_TX	27
+#define K3_PDMA_UART6_RX	28
+#define K3_PDMA_UART7_TX	29
+#define K3_PDMA_UART7_RX	30
+#define K3_PDMA_UART8_TX	31
+#define K3_PDMA_UART8_RX	32
+#define K3_PDMA_UART9_TX	33
+#define K3_PDMA_UART9_RX	34
+#define K3_PDMA_UART10_TX	53
+#define K3_PDMA_UART10_RX	54
+
+/* I2C DMA request numbers */
+#define K3_PDMA_I2C0_TX	11
+#define K3_PDMA_I2C0_RX	12
+#define K3_PDMA_I2C1_TX	13
+#define K3_PDMA_I2C1_RX	14
+#define K3_PDMA_I2C2_TX	15
+#define K3_PDMA_I2C2_RX	16
+#define K3_PDMA_I2C4_TX	17
+#define K3_PDMA_I2C4_RX	18
+#define K3_PDMA_I2C5_TX	35
+#define K3_PDMA_I2C5_RX	36
+#define K3_PDMA_I2C6_TX	37
+#define K3_PDMA_I2C6_RX	38
+#define K3_PDMA_I2C8_TX	41
+#define K3_PDMA_I2C8_RX	42
+
+/* SSP/SPI DMA request numbers */
+#define K3_PDMA_SSP3_TX	19
+#define K3_PDMA_SSP3_RX	20
+#define K3_PDMA_SSPA0_TX	21
+#define K3_PDMA_SSPA0_RX	22
+#define K3_PDMA_SSPA1_TX	23
+#define K3_PDMA_SSPA1_RX	24
+#define K3_PDMA_SSPA2_TX	56
+#define K3_PDMA_SSPA2_RX	57
+#define K3_PDMA_SSPA3_TX	58
+#define K3_PDMA_SSPA3_RX	59
+#define K3_PDMA_SSPA4_TX	60
+#define K3_PDMA_SSPA4_RX	61
+#define K3_PDMA_SSPA5_TX	62
+#define K3_PDMA_SSPA5_RX	63
+
+/* CAN DMA request numbers */
+#define K3_PDMA_CAN0_RX	43
+#define K3_PDMA_CAN1_RX	44
+#define K3_PDMA_CAN2_RX	51
+#define K3_PDMA_CAN3_RX	52
+
+/* SSP0/1 DMA request numbers */
+#define K3_PDMA_SSP0_TX	64
+#define K3_PDMA_SSP0_RX	65
+#define K3_PDMA_SSP1_TX	66
+#define K3_PDMA_SSP1_RX	67
+
+/* QSPI DMA request numbers */
+#define K3_PDMA_QSPI_RX	84
+#define K3_PDMA_QSPI_TX	85
+
+#endif /* __DT_BINDINGS_DMA_K3_PDMA_H__ */

-- 
2.53.0


