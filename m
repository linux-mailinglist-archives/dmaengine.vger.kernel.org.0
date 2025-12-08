Return-Path: <dmaengine+bounces-7524-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D890CABC5A
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 02:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 822FB300214B
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 01:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB816262FC1;
	Mon,  8 Dec 2025 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wpa/17XB"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F92620FC;
	Mon,  8 Dec 2025 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159082; cv=fail; b=ID621WLE9vNgltt7QDN1de28WLgWYE+Uqx4JyPzwSMSYxL5EM5ffYWC4HTFzAyFnlL3cF41tN5NBD223Z3p92kPGwn9EPG9fKyH0qPTtVgKQTJb09jXSF803MG33MbfKs79+r2S3PHNHXuypjCSYe/Mm1L/OCm5mErvcUI0qsO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159082; c=relaxed/simple;
	bh=zPPNZnv5xnrAoLB4SShVZR6OEAeWoWDcBdHE5i/g97E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtAWraH5auMWfq0i1SEqaeslsuZT2QJdGZ/jetqpMQARhJkffcyml7g8jV8VIMmGU1mI5sNP9w6bvu/fmZI8tTiKM+F1hXv+R9yI7hyF68HsHKwuTRhqXzQIxqcKurKB9ubbsO5al2V7uSlGFzxrWuf1Mi3eMlPnT6QFV0bKK1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wpa/17XB; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W46YnMDh0jaRalfXQkzNyya9Ryxk6FAQCVReg6j9JnAA5pkE08m3gnskwpt7fxwgYHqSFvWvDCljnam6M9sfTBGgXYPES/Co7s9JwjjMwYowloK+AlW3Gz5lalenLOUXoSUDcwEEEVgrQxWNZT+qDExPmqSg+hxosL3QfIt5FnIVQY0Enl//GgabisQyPIYMUe7cK/KRUppJK+pU7iNSGKSd7xlR3jIP+LPsKBZP9p4NSLq3Ku0Rz5FFvX65l0eaCH9BYl4AH9qoj9jW6ug0Xpvo5eQMopmiGkw4aRs/PPzshAwWmh2ZPwfdEMxLLlkvqZ09kNTa5xbgi28FpLfOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr4QUOUVEHoybS6Ih5y9SJ0CMxAblxZpsmN0YXwDiLQ=;
 b=FFQihz2PnONi+o8LLqXdzNTrqWoE/kWIbmsAAZx/RmTk6Wv5+UPurUG4wwW2b02xcbcuVT7GCyQwxS2LVDPVxXKKUxLGu3BLcRRwF5FhczDcZIkHvA7P6cv9kdDM1Zol3NowIQpDu2LE6TilM1lKHT4MvAOSI9YlDmlZZ0vdyWJxMbdW23UiFBDugtPrnddPB+GPJcKlHkPT3cR7ETs7QNZ44lOgulOY72u7vtj8mN7DvwzRaF/X+Yk6ZvbPPFJYrOmwc1UdjAyzKRK2+JkgFYPty99Au6z1BjyCBquIqDdPU15IrqelfgAPHOhd0MLKXA/LQE1uNUpdD6+5ujETcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr4QUOUVEHoybS6Ih5y9SJ0CMxAblxZpsmN0YXwDiLQ=;
 b=wpa/17XBNp/F+VXdQDThMRI0WAmJGWBNpk0Cr3kqyv4+bqAMrydzIUSVNTXRbzbHzE/+ZHlLH/UJplGuTWQM3GDvKZJrTRZ8jvG6DTuxXqTd3KiiJfXWX8WqWCWvD66QLX1E1J0H//TDWZ0L5xJIPvaU6XtjYPeTPRlvejS555KzMpFSCNBQHjtmk//xLM+5SMkvtOANZrg1nyeuCakKgYsHlVf+xx1MsUw7Ws3f4j7wYfVJIfHJARYV6lLTdkUYCSGLBtjrrZyp9xC8q8umOSeW56FumM629l+saWzr5XiW6n3T2eTyd07T/M1j5Nw+LoZCB/Tnp48QQ04Vbemuqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA6PR03MB8010.namprd03.prod.outlook.com (2603:10b6:806:437::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 01:57:58 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 01:57:58 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 2/4] dt-bindings: dma: snps,dw-axi-dmac: Add #address-cells and #size-cells
Date: Mon,  8 Dec 2025 09:57:43 +0800
Message-ID: <d2aae30e01537a737c3a47c0210e6deb79d160d6.1764927089.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764927089.git.khairul.anuar.romli@altera.com>
References: <cover.1764927089.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA6PR03MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b46b020-a563-4fb6-c0f0-08de35fd3600
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?haPvQfHP/kPjEnWDAF6qpnmbL6cqoA3xHVDb8Z2XKdjo6RyYWEStdVuyW7jz?=
 =?us-ascii?Q?fMs5D+NXX6zRsrK0nNJIgX82Dh1b6mj0pbvd7u74uamrSAOn4FlFsD3w5g8l?=
 =?us-ascii?Q?aDr5j3okWkyElz8JMNe0M9WzEXT6LgqUTYLWVi5kyytD5mknC1nglFTeBdwD?=
 =?us-ascii?Q?WSvQP0ypUiwVORws3cQb32iP6e5LmTW4HIEztCugWxbupcg8bVAG8CBCGNN2?=
 =?us-ascii?Q?K613djN4EDWHSqkJSEwkUflwoGa1f92l1rYEpu13J93235jgd4rXhXaOcacV?=
 =?us-ascii?Q?JjcKG98J9kUVChyKJ66iWuclCHzd99p/va0KOzhGYSMURhvU4Hu0XnYyzkrv?=
 =?us-ascii?Q?+wDkBIaLYpm+FQsTUzykHcfjwDTOgXuIGtJ5M5XU5Z15xmhPyQ4fCaRDAlGq?=
 =?us-ascii?Q?QRhaNvXSk2TnynQFflUkhrIHu1dWEaS3dxRpLANGld7W6nySIE1ss7VNGgaq?=
 =?us-ascii?Q?EZiRfR+bL5HztKb8iPc+OPWsGHzIz5C5jOdaO1/A5TATNPobocKd3Sy6bvAx?=
 =?us-ascii?Q?ZFAQe6nAEYEM1Kgum9yhIFfw6lHh98hDOUB0i4bVqXWxNUan41tiFvP4I2Lc?=
 =?us-ascii?Q?fAzOkJ4Y9xHpfsTVWuayJZyL5SwZD+X9QDjH0yahcfXiB+opdGv7nzsSNmwZ?=
 =?us-ascii?Q?dl6ZLJTSU9lwk13Ekf1LRPk4VsXL5MXI8MwxH2ruuloCpDRi4UVup49pbHya?=
 =?us-ascii?Q?oxN7Liod4E6feCKV0FXtrsTBl5p7Ew2OQz5tn4EzT+5VeXfiIRpC4BXf1T0U?=
 =?us-ascii?Q?b1qDcNjHXHqW+OkxndWXDRvFhlp2LOkH0lcqP9B0JIsJiXiVR7a/gjVfgWO2?=
 =?us-ascii?Q?D0CwLi4Nm9tZw68Y6kTahdhV9NuyPkGi/ndjlGUFQyPuudT+ESAs+WuD+LiU?=
 =?us-ascii?Q?tuBwDhr6GNvg1iJpAaOw89xvyG6bushkVhDpYvB1FdcfSoHMZoSOSiC9gIEk?=
 =?us-ascii?Q?hitUwxv1uWipMIiPC6NQVRW3W+sj5n8g/B07uRhhlvayYK8odTQzUGV8WqHi?=
 =?us-ascii?Q?m+mlYF/dg+OEdw+NY4Hh/yyNcwCuzWgBvctrr1EeJTyhCatTDMkI8Uis4HD7?=
 =?us-ascii?Q?OkhJWDHJBoHsdCyDJFH1qQ1xtjbbo4E05iiXAJYOL5HMlKk7o1/12H2T0lVS?=
 =?us-ascii?Q?Ikuwohfvbs7KmP+wm1cCpN2E7HbGzEKGozYCK1h6D4v5PxrBc4q6wmlyEcYm?=
 =?us-ascii?Q?3MQ1cRBWxk+2YjJNYugyUMqK8BcdEkJ39NIAhNSiOJK8VOnX9hRVa9RBv+zW?=
 =?us-ascii?Q?ABrxaAvnH9D/z3VousJI+wyNt/dXSYy2S5/U2gConqAe0vs0Uko+WDYOckw8?=
 =?us-ascii?Q?VkjdrNEiuW2eMJrzW05af0WlXaHAsDUXMkdY0m8QvL/iBIdJPopeNH6+u3Q5?=
 =?us-ascii?Q?Yf18Aw70GarXxxgl3spzkWOeMe7vXbMjAyiQuaIk9B4KajSoAqE7RQRKCODu?=
 =?us-ascii?Q?4exT9dLqAtdj3PK0DAwXtWrf0KORoEeLSO4ZNPzbCXg+uDqwP3ll9kXIeOje?=
 =?us-ascii?Q?aXunLDuQPT4PA1o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XL5rplXk3eTgHmW/yXlU4MvqO1NQJyCheXayRtlimz4AiW6KDloZ4VulTavr?=
 =?us-ascii?Q?IeUNCd1j5wmWHSlSpGLr1N+laG9RR7GAoHnNY4otqBg7oC+nwSofLIRPFtQt?=
 =?us-ascii?Q?k3dgzd2jdhNwJzrecRh4CxTautmCjvOvvHkJ+bBa3naPk0iEGUrXZMpy8c62?=
 =?us-ascii?Q?ULHP6eqPNbVYkBlaXLXC7Df5sa9NmdNBgG8bnmOhPVy5EFKruiMdXfrNwoCP?=
 =?us-ascii?Q?BVr9SUBFBBuC1D54ADmlAVXx92zN4FztaHaSTkjkdcxLFRVhFi0ChflC+2wY?=
 =?us-ascii?Q?Xj/ZgTHznt4jitSqJczGQNlDz3o44+b5ZjXPNtVXRqbZQU42HOHhY+2SSAJh?=
 =?us-ascii?Q?FEfHyohMLl2KikVh8Jj5BoZDREzPXMEVJND/lPDZmf5YPVhY0z9zjJSsqbTr?=
 =?us-ascii?Q?eGLm2xxWSNKFlRzk+TNrtgcNbcZarDWlHKSVOgXSnaB4s525zpcj/2vL5AsE?=
 =?us-ascii?Q?VzJydy3IpQMIbKo/F+XttH2SNI1TmIaC5Il3i2TO3YJe1CzvROVIHEJFujFA?=
 =?us-ascii?Q?ECFrc/iyBXyavDqgeIOR/WgKiIDvIh8QqgXmGt+5RCsrk6o3/eJWYXVS/dL0?=
 =?us-ascii?Q?pSAHM2Y83CWeQ963Vlntj5dPvlWLysqN/bSqmTnRxsR9RE9dHcEirJtJU69r?=
 =?us-ascii?Q?T2xcLQdRld+sh+UYs5HcKCTxmg2yTMd14StRcAr8a8ZkYL8YsFss5OSlF8y8?=
 =?us-ascii?Q?Y0er7raXf+rwaYl9m/tqrOWM/poO2seAV01vBzVHFw2wZZvBroo050qiP2VU?=
 =?us-ascii?Q?ka9G9usiae/4YwjoFa4l6j9zAMVcLUmBp0G+q0YUh9A0feNce4Bexdg9t3HT?=
 =?us-ascii?Q?6fJsUTKEMVP8VOkUgnYEsPIzeGif71HiHksdJN7SHscYpgeKkoqE6wscVCQ1?=
 =?us-ascii?Q?gkM0OUkfzl7g7Pjp+OTTw7KMo/GM0RP2tJMcnALhUcUCFpXh/xNWEkQ3P0NV?=
 =?us-ascii?Q?C4x6plqAce+500fHUq7NguIfJelVP4KtJkmLiai3/TAjMjaajvfqcLb7gRoD?=
 =?us-ascii?Q?c7XhB17SEnGpb06Fqc2nAkJxl0l8ZeJseq5wFkWB/RprolIxwaFue1Lxj/4v?=
 =?us-ascii?Q?Ec/rExhpdxSrSD7fe0ltYan6KhWzgPdg+bkhU1muUVRhJTA4uKQBK7EZ6430?=
 =?us-ascii?Q?eWXtj2RxRR3xEI/BucGvkZtmBn973Mmj+am/TGpEiZP050prY7A0W0jg7iIw?=
 =?us-ascii?Q?uJwaOgwKgklm0PQfb9UssWhI0ZcK8ebEMv0gFVAeyvK3BDzWAOc6sfgvz19y?=
 =?us-ascii?Q?I7sShNP6IZOLJ4XJ8jjNflUeoZXu+vwFxqX3fdguKe9OkCYaM1tMrqsb9umQ?=
 =?us-ascii?Q?Ac2hLLNZtGJZDyUz8LgDw0CQ42b4pe1P1aUUd3IRL9Ma8EGPIZ/noMbEgTY+?=
 =?us-ascii?Q?puPQKdUL1fcIbEaKiXNtL+nEpY6lXPRGxGNScisw0NXN2cwMCp3UHEGiDvjT?=
 =?us-ascii?Q?KrrFcOsEINpqaxc852CTJ0KtE+Q8wwT9qFDeNv/fV3BOdCarYQqdhnknDrmC?=
 =?us-ascii?Q?07m8iJm8NMpicgl6wdWx6daj0+I+IusBzR0iniiX4pl5m4I+LPkfEAHhrx5a?=
 =?us-ascii?Q?LI4HUXdEotSyHkDfc+b67OM7KDvAp2VYk8PQXf0MzacOwYMr7fJPW3jtzpYU?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b46b020-a563-4fb6-c0f0-08de35fd3600
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 01:57:58.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GbohVSbwZbj4QFcuVxmCvOjmy2+tyNXrToFmQRHwPdDvdn03z4eXoNDz/db7QUzqC2hRBCgfRqNq1gNyhDQoMvel9qVZjQViImDCTAUf8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8010

Add '#address-cells' and '#size-cells' to resolved the dt-schema build
build issue when dma-ranges is presence. Without address-cells and
size-cells presence in DT, kernel panic is observed due to of_base driver
treats address-cells as two and size-cells as one.

Defining these cells explicitly ensures the binding correctly documents the
necessary structure for nodes that describe the DMA-accessible memory
space.

The supported enumeration for both properties is [1, 2], accommodating both
32-bit and 64-bit address/size representations.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Add address-cells and size-cells patch into the series
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 1a1800d9b544..2b542ff9a6cd 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -33,6 +33,16 @@ properties:
       - description: Address range of the DMAC registers
       - description: Address range of the DMAC APB registers
 
+  '#address-cells':
+    description: The number of cells used to represent physical base address
+      in the host address space.
+    enum: [1, 2]
+
+  '#size-cells':
+    description: The number of cells used to represent the size of an address
+      range in the host address space.
+    enum: [1, 2]
+
   reg-names:
     items:
       - const: axidma_ctrl_regs
-- 
2.43.7


