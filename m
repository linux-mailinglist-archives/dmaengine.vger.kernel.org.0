Return-Path: <dmaengine+bounces-2971-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64D960251
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 08:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BC31C222BB
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4F715534E;
	Tue, 27 Aug 2024 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m6IizeQi"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2089.outbound.protection.outlook.com [40.92.40.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA315535A;
	Tue, 27 Aug 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741454; cv=fail; b=WCmbsy9MKrdvVFNOwBoiCJMqzz7629Bxcaczoiz1B4KPnr4DqEo5zZVk00kWzW9zj9hIiN88MfmACIpfvYr0MiC2CUWafFDIjMC6wZwB94kNM53MNkqKJJrq9zBxsiheQpcEbKhsFTCVhziVcQA8x3ph2pycPfT69NuRyuKDoNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741454; c=relaxed/simple;
	bh=PZS5cigwSxB5fhIh52/T4cSyL5plU4LFypOxWBus7h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHL+1/TE/IqumygZ3ZPhA1zQgL/Y0Wo/ajjthDr+JcfGTl8qzyYdnvxgQRkrqQP7Mwvuveeg5qJb0ulkf7NEwTHZacaSnoha19ydNnTpmNxKCcB96oZiPiFXSSkpQs0EaVndwS5tRBvLxSnqVNE9o45cDZdLmBFbTpMb20H19fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=m6IizeQi; arc=fail smtp.client-ip=40.92.40.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNzpyHIboeTYkE1v3UfZWZhofGrmAdOwmBIKYuZ3/nfrOefvEnFu8EnK6qW2wtlLjnlOZ0lSIpFK3xl2eTQsQ03xQCKEhXr6CJglO3PddLwdY1zEwvWq8ipjrrti274pTzERnw2DChSNE9Ndn9JhGxNxLIhzAghtMZRlw47RdtjFhy8KzZ6e/zw+POq1ZNc5xIG7251v5JITuIp5Y6xiPBeM6atCECmzLv05bJKtOnnPoHTLRLh4p+sWulvTzIJPlKH5fqJSRP1EdBd66jGJvnGZwCyQA137aKP9BhnHJBp3f2kNRXnSyEwYmJ7jaSfIP6jMttjKGVN2z563CIBmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8BiqYB/pmIIGwtoQCg80Q4LlvGH2VU5I5bg6jVgwmY=;
 b=eSyGw6TkiOoOadCkh3Z3yjzv+o/yXcadNtEQNYBcT2vkriuajqMeqjlE5IPunkW/hEjHakvBRWVMvB8dfC0959b9DiSw+eSrGmQ+kDQecHwoQDRgRvbbxX+LZLJeksGTwnZgN5rstxIm3WpPRfUa3YYBmzSD6/7gax8WT2RZyTvLmxa+dIPA0A6Sd659+aqBefrEutz/ysb2z6HKMZruQwXtYWNWhYgRB+QpAeAyrLkEp3PciuAG0YRjdMerDHdVIU+2qO3wiPb9EefqvrkPYFW6z0RUMuI3pR2ycID7rKj7urC5Dt2MM/U1E6Lk4r8OWb2+KaHO9M2CNM7nK11Pag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8BiqYB/pmIIGwtoQCg80Q4LlvGH2VU5I5bg6jVgwmY=;
 b=m6IizeQiFg99WGGd1B+FZrAzwTn1KdjhuBlf960eQB3FyfcjLNd22ko5PlykntabaneuJ8j7iW4gED6oI7+fMHaUyf1iJ0JSzaWhf889P1ZRZj3+LRaBjcfeq6H86K12dPs/rXCXIVYaiaZIxapA1ybZDZcsfvw9H7+f1/W9AUQ64gewYRHzJvE/xzCjM4CpHv/kzyzdc6FJjJbT8VvwabZsjmcMAfbAiscA3bnwV3GTRN0/dknNUV0lePwNMfarXufj+ExUlpY2odlBTtehF/JySHGY9KO58hujxr5bYqfXiYR9yUe4PTowMxc/QeF+TM/oSnWVvG2/jBiRwtlk3g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM3PR20MB6939.namprd20.prod.outlook.com (2603:10b6:0:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:50:51 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:50:49 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v12 2/3] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Tue, 27 Aug 2024 14:49:42 +0800
Message-ID:
 <IA1PR20MB4953E0D56CE4010C470E4A71BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wIfSYb+ThmSKJJNOoTEPRYYwzSxIihBFDd9afcB5b94=]
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240827064944.740024-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM3PR20MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 219deba5-6367-4799-d48f-08dcc6649602
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|19110799003|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	KRYKtmo8UWbmf/McumOA4ptllQsipcITj6ZjcBSeofCAFGyjFBs28aIg1GA/JA3kJRmkbNwHL9WSdxCTCDhf/9tW5b6DSzLp7MRwM3fSeL6Y+Jfn1qnr/Vr/1iImrCUCD/iQ67oV2W5Moyf0FmkG3EAz1IPvvHTFxD8/VAA93QiquMLPMLeAXkRg1C1aZfAwqisEdm6UKIc1R2db5tctvScHniQGQCDH7nnPq/LHv/nmaGdeRPh+jp160Hmv9kzhZC5aFznnsz1PNz+ZskOQ87fYShWyV/pgFVaNg34zWiTLogmaWQXG8S/bvrfcGBNCJmu8xRJmuZ44i2gROwnogn116vSUB7PsZNXGcm1XEaq//hTulaqpPxIlQBjbzFtPXzLe0g5o0jspQq59uCFvbbPU21omp7WyXcgPnqqHk+I0WfappFC8odBbXozVdP0vjhIIWoeb3Of7/eKGtjNmoVdCd4V9ElDl8RGDCSujYCRdb5Z/oazijrDnhVqhHuw5F5eCeirbYaF6JJCLGtz+WRk/mqw5L/1RToyQYOTnmBzB0cyMWB4C1BRa5ji/CQxeRWEOR717WY8zZvPBDn+O2lkqm/B8WuH19mEHreds86J+9NZ9JlaPJbxf6BTWObqTnwfpII3sNN6diU3U8Qz0ASzMusGIvIIOBnQ7/aIv3mtD0jW3V6yh4MTiHnobOmoGAbK9nD2fkem0WMoIpEBrX3CULPrrCIi+fgt6C4dnLug=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VX6gTTj/+x4avoamLNXJvFslVFTeR56u2SMS7ArzHDojaB6BuvrNdZx8PJj1?=
 =?us-ascii?Q?WrSoZrGzUN8RaQlTJmhBXgX2pBeFy5mXScIyQq/MJRkCM1k7c/9Xoi6/YgsZ?=
 =?us-ascii?Q?DBv3cIZxwXHBkp6Vh8WDqW8n/DNvxLPiE1YxD4Zz63ipr2nk4Z5ktpIIr1N4?=
 =?us-ascii?Q?+cJsreGMkl6AeoiuADfQ8J0L3Rk4GvBh3kYsQLO0ZlWLjFu2zAEjfMXnQ3yv?=
 =?us-ascii?Q?e0SJNUxm+heaFGtLz/7pLMTVWVERu+z7x7eniYAEKef5VbQiqQAUzzoh2K75?=
 =?us-ascii?Q?A/bdrMMREvq0Uyfzga03wSJNXSIsK314haM3K2f7qJK37Wt79yA9qFFfCC1A?=
 =?us-ascii?Q?Wv42t6cWNDqYW1FHxGFFwwIjd2dIswGUCziBY1lWxn3lTVn9XiJoebfmuUn9?=
 =?us-ascii?Q?7gfXc74qWnZg1s9iN3YkoOfbdu/AJ0ZyqaqEKUeBJ6qXP5RHP8yBiUhNQ7ju?=
 =?us-ascii?Q?6lIzZLzmXwVBli+3ReORV9c/f5fvd2fNNfeT3FpvScHoegBrtpW8hdt/lqpY?=
 =?us-ascii?Q?IwcOBF0fjPqSldafEXpBF33iOeE94pUpoSZM5WYHFKIszzGv/8UKunEX05Sv?=
 =?us-ascii?Q?I8kkC1I85zeP4eorznyFVR49+oFVRQRPzmZDHyy6u71lC6afI5NYWAjFE/ex?=
 =?us-ascii?Q?3hx9yDQCHApc/LbVKLtcgdLPh1D4LeUsQ64otM1yun9E7rBOGF3UqTbBwJOi?=
 =?us-ascii?Q?+GSul+tGyUUMbzLi9DhlELNon71VYWTW5BJO3+yyw28yCLxxwKlKHHxbX5g0?=
 =?us-ascii?Q?ISU8AV1DafWyTW0MafcKmTkHH0B8LSDhe8BH7mbe4HMlRdT7G/8vaf4lCe0K?=
 =?us-ascii?Q?WlLsCVg3fUBjC8Jhq7Ik9Pbj1BrqyTJeEcVwY9+H9bLHwG6A12iZrN7vLe10?=
 =?us-ascii?Q?JGl3YVduvtb0cL+bKP7cQFAPfsw27WIu6lMkyPRxf3G5N14+rwlHEPf47l1i?=
 =?us-ascii?Q?S7LlVRpyXAQWmxswB67jlBZ7uCBBzMOFjSGoNYI4Kg8pVgp5DRpcege6QNKn?=
 =?us-ascii?Q?4he9T9+4kHn3FXemJwuuJjh0tJrDPDxky9w13Ol0wpPC8Z2x3D7DgFctJygh?=
 =?us-ascii?Q?0xjzIJ7fs14H44nTH5pWj67bQOOX+LbiH1I/7fcatdBv7lb6Tl7sczFeO5RD?=
 =?us-ascii?Q?yDWn1xBy4mRQq6qXXKKszOl66RFJiMaabpaaCaajP3qRhyf5M/N5CgiQKUk/?=
 =?us-ascii?Q?ZwoHAz+g1+vHCyycQwXEslwZ5gp48HV6gWR4lgjBJrUHkFSmYJC63ZMxwXWk?=
 =?us-ascii?Q?U92oUHIMREzI8V0A1DXm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219deba5-6367-4799-d48f-08dcc6649602
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:50:49.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR20MB6939

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


