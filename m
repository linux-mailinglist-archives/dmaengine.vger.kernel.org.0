Return-Path: <dmaengine+bounces-2832-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBE494DB7C
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 10:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0081F21FD5
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EA014AD3A;
	Sat, 10 Aug 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lmkcFgg+"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2080.outbound.protection.outlook.com [40.92.19.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889E24B2F;
	Sat, 10 Aug 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279190; cv=fail; b=Mr3yw2P7mSm+KCHhlvTDlbZ0vRo7xqBcB9GES6EaIcyplq43krvcrMEoi+mkNFasMgeFlNzrk0GB8ec6oL/fv9MYTJ5rMG32S6/GAXcj273VYdi4SWSz3SRcuQ7XinAhS0ISSvMMugtBhpyyHprylCX6acIjuJ+KeJV4+xQ0Aqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279190; c=relaxed/simple;
	bh=PZS5cigwSxB5fhIh52/T4cSyL5plU4LFypOxWBus7h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVWV1Ak9GEeto4n0bVsqqhWmjN6sybGgMJUaKoRrNw5gRYDqbJTGv8ConIfFDV7FnCdOtwcPGA4DBiUcVBw/ubNO/6Z3EBHfrqrcz6TLPYMU65hVLRrAtLK6ZtGW1mRvJnAhM5eXRT3fNu8J1+BRq6Qn0UzCjsyufyeiPhc7FD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lmkcFgg+; arc=fail smtp.client-ip=40.92.19.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE54Ci8AwFz5Fl/ws6ijU0buoI9t8gGoNY7VYLZXmOV6fr1USzG/chFqIWc11Id+8I79aSguwjTWaX2F5lrX3/11o61L7YGp1sLxG2kRm9oQUfQ66vlNwEdpHL6CgX/IRYwId7JBX8fGzz3CO/pHcLxh4wN8BzVZs4ugKNB34R7ZIWHggSQZHOhsyCi3eK3jz7cB/QYDMZgdJHR3qxvNdHvUK4QvK9LAsISy8GEMn9OyZa8/x3/hWmMZXtrlk7rMByElxv/gx5kgzIJW8szqZbNOTnxNP50Kdcs9CfMInwmnN3dFrCzOUaj80wpC/N+7/ulk9zL24KSqQRXJ1hdnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8BiqYB/pmIIGwtoQCg80Q4LlvGH2VU5I5bg6jVgwmY=;
 b=tRsYlQ66qYZLnIDQMNHBIX3XSgMlo9tKmgHLKQz4wkl8zaakdcYohcZMHzIpgM6SpMlG36Qzs9DGbekndu1i0twI7ND/XsLfTRUMFaNSiC+JLqj3W4llt5ibSFkGs9zbq84lOE2iyS23pkPGhpmzfKqMkte4npbWRWDYEtpwmg+VtqgSL604tN1YU3HD1LfS7ORXnLZB7SqpRWsaXOd18IhX8af7uIM7A3WmZWfYQqeblUym67t6mES1ZNOPKKxRKHZjZodz73VuQ4P7NhDpsywyIxgqqxp2VkGPMz/1EvAgGemjy5lRa3fJWArZOi9yqU1oyR4M+4LKTeRDo6mnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8BiqYB/pmIIGwtoQCg80Q4LlvGH2VU5I5bg6jVgwmY=;
 b=lmkcFgg+abbs4ruRiEIcI3lta6NFS/bhPPJKvDV/LgPz35sgDAeYafDIAiby6R8GUmn93aTZ9+PHD1RHeo5MexIOBXAU6+VG2J5Yi72SSHbbOS19ivdOpbubF4VQ40l7juPCqmy6vO3gGG5jVuhLL0QMQIAAIBVAr9s7R+yP6kKKWFeMmM14V4zyHYPK3ngdBu+IsjL7PaIFLmvdoLEAQhKygGL9Zr6iUsgf2NZS+FuP0E1KJBHHpwpJeRbr2t+05ejAbwG5fBWJADzXavkKeghqM9O3A1fBU7d1NvzkCrS9ZoEg0psZQeT7sN6qw1bpem+Ez5CrOGITpWbd9WEDsA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB6115.namprd20.prod.outlook.com (2603:10b6:510:2bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sat, 10 Aug
 2024 08:39:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 08:39:46 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 2/3] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Sat, 10 Aug 2024 16:38:54 +0800
Message-ID:
 <IA1PR20MB49532F52E5ED99EFEBDD08E8BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB49530ABC137B465548817077BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49530ABC137B465548817077BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vTzII9Ryr2xku6pJZ3FW+BXnw8dEftRN6aTt7PB2u9g=]
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240810083857.487764-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 428e69d7-48de-45cb-4ca1-08dcb917fd0f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|15080799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	LfMVBW9spFz83ei3/yGCd9AWswWHDbK1IfX/kAK7lltUtxaX66+pfIoaU81bfFdnWqnPyEpwySAxjhPROjVdUij+nRNgKCCBpZq6uHzZ9SEmlTzcl062s4Mteg8nk8f1TYNtL23P109DZ9HaYNwAIx+yDrkAZdoGVOrfQML48eGnMfrv/9Ip6nhZNd0mbzZsrqtPIW06sGqaOmtdZVUubgdz9facx+AJPaci3o38tUGh3MbSZY4U6vEXCLinhFtr0ywYHY2HmJbwz3WgNqDSInhbHKdqGMltaLtaaGQOeFeNGP9r2n8vb0PYWDy2ZknT0fy7oA1K0zwXfbrIciFgt5htitoQu0X2F5G2fyW8lsuu+/nor7AuBQE1deR2VOm5uASzv7nUxSNHbFd7rhoOZpdWT9t2stvTq1gSXtLPrjvuvSxURA8TpJenes6dqiR4gJXEREAsm82YxSsug3RCNbxFW9vjZ7QPIDMlQrUcpfHnPosWBgreKtbDRvwp9i2BGp4brOEM4gEs+Lg8uT6O9zphHqSSMoGrW618bvfcl8qC5I5O0Ve4ta3hyErxIIb32gI/jkX1VE1OvHAChQ4rNQ/9ZD+hHMiN+I/MF24CZL6G1OogNqk1FU71pwmNBW68yYLqTXkq4maNscExxA2xeeK3afZLaTpnrvXXZ7thfgh++/x1eGCpItwooAWFF3iLt/tDXL5rPmAjlN8iol8UOgOgSCJ3N6fykCHAtIDULjc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4pJ5ybowcuA04ZLLgzW0IV37AxS679XJggGdAiqY1z+QjtYOfn8QDtuotJNx?=
 =?us-ascii?Q?+eYAOE4kbyyjRM+ysZTqySiMeiNrJpw7I85BQJjrk4TYbCjn9XiGAUW10VkA?=
 =?us-ascii?Q?h7IwiRIsXMmNsCOtvKvPMOTnET2BgZdITqjDd8At0IrXDmFpzV9wfnz92heu?=
 =?us-ascii?Q?kEnwtzNaRVyhGhOYLe+QjU0HhueBSkBSh6ZH74IlMJ1rrph+ral9yafVFYi1?=
 =?us-ascii?Q?UoaLhOlqpwkjKiZWgLkajhtmGwkuJjCC6s0B03dN/qFdvuPg933i8LSA/M4u?=
 =?us-ascii?Q?JA25dVbEeW21AcqhJwxqX2TE+PJDKwbDiqPw+v0sX4c4DLRwwAvYu7TDB4Tu?=
 =?us-ascii?Q?K7csXlDfMqrgElMs9Jf0y6//aEIUyOoCrHRY+M4OGqp6YWwcttydgpzxQeJf?=
 =?us-ascii?Q?qYDxWsDpGBjNzvUvfRffsg8txnx+B2V4/S5R41VtCyKcaHBzSHD1fBiIr6yH?=
 =?us-ascii?Q?8RUS0j1ABrYXd91StMORNpl+sTjI2CvxYQ3R4gZHfK9mVnOGkMcHT2lBZkP7?=
 =?us-ascii?Q?M4NuwvImexyaffH0rGMhHqALwk97soIkduYI+ABcvcJWFdicPyHUcCX920bz?=
 =?us-ascii?Q?Ptgn+7Yh9zkpG6T413awGdit0P1qskQ8zUYTfUZns8RXJUqmR+eD5KHFiBRO?=
 =?us-ascii?Q?fejeTtTxZBjXn4JIbg6V6hUAzZUzGi6Q8NhzKSRyA0083Oio3JLz/AOXju0J?=
 =?us-ascii?Q?tfmReOFw+Gq1/B+VkcGd6laUJyFesC+cY7zBhPT1sxbnqAKK+kxhPP/TUBK6?=
 =?us-ascii?Q?344SZuKY03TlY52JVyBRA1zMy2LwLQb2BRTDxvYU62sps8sEded3PrMdVb7A?=
 =?us-ascii?Q?I8LnWkZhHbyHzJkzIL3b2ylKmy5GAG0Ay/J4GBlRW89HzNG3E6Cl+vJbu1uA?=
 =?us-ascii?Q?HkfpDqCIyEosv5hgnYzJMuwfA1TWmm872R0wCXIYxXBAjuGEdo0F8u5fHcC0?=
 =?us-ascii?Q?bfpsQ0kdqGYYD6ZOXj0V+VlNOuIL/+2v7RlA654GwDGXzZLOoSBFryFQOZtc?=
 =?us-ascii?Q?9Ozh0HpN5IjzSJTvyeYDMlimgAnEDJK8LElZXH8dkuvbUuL/FyCwCjLGAE3A?=
 =?us-ascii?Q?wjUWW0KFEpJCXeJWTyTogmmoNzoxUP1Pas5eySgx8twXIxYrv06VYfQ0RetK?=
 =?us-ascii?Q?Zi6YDNDccB62uPCCPyk3LEd+8glh6dR4I/Qc3P76zA0I1mVf+Sh2pAFMPb+r?=
 =?us-ascii?Q?ATDuZYI/nviTyeD+QkMN1622XEOzi4CqTdkhPvj+j6+3Sx5vHXPVm+wTSeDw?=
 =?us-ascii?Q?w5YJnCmtf7FjZRkVF0tX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428e69d7-48de-45cb-4ca1-08dcb917fd0f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 08:39:46.2019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6115

The "top" system controller of CV18XX/SG200X exposes control
register access for various devices. Add soc header file to
describe it.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

diff --git a/include/soc/sophgo/cv1800-sysctl.h b/include/soc/sophgo/cv1800-sysctl.h
new file mode 100644
index 000000000000..b9396d33e240
--- /dev/null
+++ b/include/soc/sophgo/cv1800-sysctl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef CV1800_SYSCTL_H
+#define CV1800_SYSCTL_H
+
+/*
+ * SOPHGO CV1800/SG2000 SoC top system controller registers offsets.
+ */
+
+#define CV1800_CONF_INFO		0x004
+#define CV1800_SYS_CTRL_REG		0x008
+#define CV1800_USB_PHY_CTRL_REG		0x048
+#define CV1800_SDMA_DMA_CHANNEL_REMAP0	0x154
+#define CV1800_SDMA_DMA_CHANNEL_REMAP1	0x158
+#define CV1800_TOP_TIMER_CLK_SEL	0x1a0
+#define CV1800_TOP_WDT_CTRL		0x1a8
+#define CV1800_DDR_AXI_URGENT_OW	0x1b8
+#define CV1800_DDR_AXI_URGENT		0x1bc
+#define CV1800_DDR_AXI_QOS_0		0x1d8
+#define CV1800_DDR_AXI_QOS_1		0x1dc
+#define CV1800_SD_PWRSW_CTRL		0x1f4
+#define CV1800_SD_PWRSW_TIME		0x1f8
+#define CV1800_DDR_AXI_QOS_OW		0x23c
+#define CV1800_SD_CTRL_OPT		0x294
+#define CV1800_SDMA_DMA_INT_MUX		0x298
+
+#endif // CV1800_SYSCTL_H
-- 
2.46.0


