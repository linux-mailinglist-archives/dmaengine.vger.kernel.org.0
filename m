Return-Path: <dmaengine+bounces-9655-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAWDAl3sxGm+5AQAu9opvQ
	(envelope-from <dmaengine+bounces-9655-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:20:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FC33312D2
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBE663052F77
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34C3B6C0B;
	Thu, 26 Mar 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="SCqzprsW"
X-Original-To: dmaengine@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558113B19D8;
	Thu, 26 Mar 2026 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513137; cv=none; b=AQne6ZKKHE/YLdH2uQ3cD4RwXagakeH2uLDQ0NjpaKAANR5F51BdXRaxHRSjgLzrllqmbQMa7eF2MUHBaFbFgBZGGla6hBTxjDbr38PuFkm0a204eGa0+STaUeRqCdCoUCmt4z8dS5Nr40lPgS+RkHxYIACJ3gACq39ZPlRK1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513137; c=relaxed/simple;
	bh=tDoTDcInAmdPmBjs7qGG3sXgXEovZL3e1lG0V1KfV6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D56vWOSt1DzE5nNtJ/segx7wkhA8X9fwZD0r8xlnjxrj2NFLTt4JYzvVj8InwP8GPeyqiHEpmpxpHcjH3OQBDbfexqSjwD1Ya8i6f8M/qdHaNvcnfVKPyi4yNJqnKra0179icA18+pqeQmIY+mJ+XEsMBDcAUvRvX7OVD/4eYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=SCqzprsW; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774513083;
	bh=JctvVoUnaYZEcUpcCeUAH/O01I6H69FJWZpg30drLls=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=SCqzprsW8Xeh8RuuxM+BBSZctjqtCAOZHj6KhkC1gJ2BqTC5AVhvsJIEU7P1+zb/E
	 9a7q2LikAHMHpZyxM228ZL5eIZPhtAync7wD9wicGxgMDnPCReVTSAp4R3UldEbxY4
	 UqDqOWfvPkB/3qv39HnTyZ3qBr1O4sfn8/SWgSYE=
X-QQ-mid: esmtpgz16t1774513081tbccfb4c0
X-QQ-Originating-IP: Mh9AT6pm+aCJmez532928YdCKW9DJR0TT1tPXVr952g=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 16:17:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4318848773222408251
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 26 Mar 2026 16:17:16 +0800
Subject: [PATCH v2 1/7] dt-bindings: dmaengine: Add SpacemiT K1 DMA request
 definitions
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-k3-pdma-v2-1-ca94ca7bb595@linux.spacemit.com>
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
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774513072; l=2208;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=jftuX0/6T93a2q6FaJ6IWX9yiqjzUUWE9C2UFzElo1s=;
 b=N1QynMvDYNMINgIJKUQsh18gXAceco8FcEfk9gVepp3DBY2+KntTHQeg2WysOeMF5RgFN1RNX
 KA3itSUVCXYAL0tSsOjI1Gb+NL+PEw4FLfVW6zPpW3PUAx5l6Ye25sT
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N3dgTRomRxpb14BO1baZuIkZSQL9W2Oq8QmO4L79STC+HifFH2ddI8M3
	yHlcRkFhIaxtuSy2alPco+wMQV0v3EtXtDjahmB+alsa8qslnVc91plwNQOGJkZaw0HlDpu
	ObvMgP++UyhdWG394IInDNegV0psAnrJNgEw/T/Nxszyug6jq0zfy4B0Ac0+dIwNQnb5z9I
	UEC9dmOzMueklyHwHuBmoqbRCSNAU5GH3JKYd/ZZe36VhrEa9gfNt5lIp6JGZTFSu9BgUot
	4RMwUVVt184MPpRtegItGSWR+WAnXt8DiKdsGfdJGxZKimvj1FZx588lcFYKsTp7Hg+/J3M
	FN3w27eMjPR/Au9KeY9G2yQhh5PaRDdxGw19jpTxu+iKcuSk1qBRWRwH5FmtTMtADTZrwIn
	Sua8OYE+BvJU7Js6uYbrdxXVWq6GGsWUGow5AJyiaL+GbNV7N21noQ83de/TMRTzA3M4S+Z
	Lx1JPMmirG03KHDdfh+L0YOY980IYQZ5KxY7+YjnSYq/jLop8it6TVDOmUMdobnhGR59sv8
	Y5k0qY03S6k+g9byaima24LxYwy0f9eM2QuZxTqVk8NqxnbBv6SlVlq5tRKtsPI1yMDbW4z
	sjq7kSzgjbKVdWpYqtMvFiylbsspcoGYI1LTa4+sM3kqEgd9vKWtc+axXiHZUaQpzxJSWH0
	c10eNgUNtwP6UPta/Oh2DpVmkSTOQWLx7FoE4JiqMucvS2b5xOqk1fuypUqZWUasHQIbh//
	hPeAnHC7kd6G7oolLGwlDb23avNbO51jx5xnMRC56Pk80I2riAj7XvVcWj7j9OtjUzYVbHd
	dIF9XZywLVMCTZlcsqe+KWC8diW0nsNoAtEAVUDAxMYbtWrlE1Z4DhlU5yIcTZAld0CfGB+
	1DkM/6iXswe7obeYk+yNg9IgrsysJFM3e5xRuKzc5XbKCC1TJqefi3zIlyV+xkduNpZTA0r
	psfVdwjk1DGOGvDF/Ucy5yYJRqZoHqQlUlAVEiFusmrU1EJP5s850a+PbX9nPWDXZmfs2mO
	5kwyE0+nPTxfLkzIQ/PIksNI98aMbXigOulPwI/ZY+N9wH1WD7ZpVnum7rsLlthKRMOMhqK
	Nb/gTFdWF6rCXAZpid8M+aedn9fawe+86Qu7Z7WmrosE87vI6C+XBQTxyKRg0bdvA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
	TAGGED_FROM(0.00)[bounces-9655-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98FC33312D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guodong Xu <guodong@riscstar.com>

Add the DMA request numbers for non-secure peripherals of the K1 SoC
from SpacemiT.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 include/dt-bindings/dma/k1-pdma.h | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/dt-bindings/dma/k1-pdma.h b/include/dt-bindings/dma/k1-pdma.h
new file mode 100644
index 000000000000..061748c177dc
--- /dev/null
+++ b/include/dt-bindings/dma/k1-pdma.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides DMA request number for non-secure peripherals of
+ * SpacemiT K1 PDMA.
+ *
+ * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
+ */
+
+#ifndef __DT_BINDINGS_DMA_K1_PDMA_H__
+#define __DT_BINDINGS_DMA_K1_PDMA_H__
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
+#endif /* __DT_BINDINGS_DMA_K1_PDMA_H__ */

-- 
2.53.0


