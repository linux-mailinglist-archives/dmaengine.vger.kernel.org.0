Return-Path: <dmaengine+bounces-1832-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401768A27A7
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 09:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6372B1C20402
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2102650241;
	Fri, 12 Apr 2024 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Yo7DIa/A"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2044.outbound.protection.outlook.com [40.92.19.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598E4F615;
	Fri, 12 Apr 2024 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905647; cv=fail; b=Dq8VufemvNB0xDi2HOyOmq1uMkLt7F02Uocut42Uq+LT3NqbcauxeQ6AwtNK+sxQrwzzU5yqVQLUc9fOiNpwGIBL9bydKNKpyODiXRZzuMY3byR7h4SF79TiepKPwgbNkCjxGcyfYKV/7/G73tW5M3+qWJI+mi8CGRHhk4+FV2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905647; c=relaxed/simple;
	bh=8JgoSjCMgT+4YWgPAd3BpnSD8PgiKGpOWzslfEu2zi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OEv5Oiv7BiS+CVjf1DRO1s8SLuo8tm7h1QNzusPro5WlsLNPooxRuBI3Cdq61W7diiYEEYbDnq0FHQMdixT059yAepaVOskoZuyDGtuXeATysNpDFYT72gNDiF61R2DggEk6skdDe2gMo6xFQJXdOxFqfwP1lmPiHUFT/a9gyXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Yo7DIa/A; arc=fail smtp.client-ip=40.92.19.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv3I87dgPNyNnT7kNaMYJwKFhiUgSFD6FpP2X6wx9WNl2pbfFhxyqFH+iRoGVC/ar+9E1wfZwX9kw5AIGuQhE1hI+HEtaZ0raiInwcWZ2f0Krzamtj4pv88NlnvA+k2KhppK+KwEJgTEZLTTcveKxz4kHeofpEQtCGtv4UAbz6HzAPc3eYQw5Je/bq+4TD00wojvAKZBsfiLk++haWHN7xebYrMui3F4R0L0bqSfv0kqCUTe5+xjOLzUFESE9+cklTu9vWkRC9qOZi24vXcVpn1+UjBPIPu1RvAgXMRBBqrKfXb00hyGJvkuM+Q30Qfp05w19sHUj56wxSiPuCTYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=dGiGSdeLiySUti1JmHLYyJ3cBfC6B5mHNWuryIx6cVUB8R4I7zaX5CKWqTz40d++IKNrBJvyxYLmJg2O15W2KgXtr4wG7lY6iwjMgA/NiVtj8KZb8yy+MhTFAChgxlZvlZa28sNydEiNqceXuEueWJulY8GfoLu/YFab/ZimZIHCayv79+TB1JG9xYVkJixKjr9/pSxZ/0QPVjd3yqKpGxlo1V5f7kvaiGxeZAXiuX/XfGD1+wXTqKVkfqvRIHUlCWRB4yk0cf89UJXu7UH0+CPa8kzA/63OCybhr3ecCx4O7/yb9Y0VkQfCCPj2+P0aPzG17lXzKm/xCm/doxfWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=Yo7DIa/A8CmGtP7Dcyh/JV9ku1nKZIB0v6RWo4jmbnFydUivskUuTWMntuYulFQJHb8GEXW5hf4RNG4oNeMDhX/0xB/+4sBN875JRGQvoJCNXKtC+GpsSqCWuZJSAcc4/y4J3Mio49yaTtIykvs/CxyR6Yz7x3TRh3k0oI4956S7vqgutqJuDPMubNzslMol9oJIxp/7AnWgnUhvElYWK/sobo8ZzLXLQzLArMCH22nrDrBNaLuMN/BknVRVv1iUdmdVT9VMWKmgm8CUTUQBD0BeknU4n4CYJ3G6pI5O3t1Ne8pAIIxeStzKzVgddHQ1VPH5+wgMi0U5yrM37IPxbg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB7440.namprd20.prod.outlook.com (2603:10b6:806:3e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 07:07:23 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 07:07:23 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 2/3] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Fri, 12 Apr 2024 15:07:32 +0800
Message-ID:
 <IA1PR20MB49531D33AF0FC2240E2C7F14BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB495359880A3A8C4947702BB5BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495359880A3A8C4947702BB5BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cEy7nyF9q4T5AI1+J2yR/KTY4rlD8pS7CsqHK/an6GU=]
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240412070734.62133-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcf65bf-e0e5-42a5-e4a1-08dc5abf3377
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zlUfvH2iISSGcrVdomd/BbgINQFZbbraRWDAOeRWZUeCvmg/o3+1DzUTXmzuiXzOi+MAELfNLr1M1Kvd0kNeUhqwWd8pO1OLZo4FXM1jXGPgXgkl58LnU/WfJheTl8JYFMg2hu+LF3TGgf9e1DvNJWO4ADfHrzhDYM3CD+GS3VxTT7eHlnn+6FxE9qDhxNPQIVRQfCppSwon7B9cGKbuRomXhbyHInsoVLu5HoIMcoVp2RBrnQw28BPRJnRnF+oBeJ3cZJOo9xLme65rO/pDwzuWFkbneREdtZjuiHloM5H+YBj3MI6vlwXS2kMySuX21W5sHcKqVToqSAxUGEzUhEnqSGJv2kFEcX5HRzoZ9rGeP57DJR+FDj+3M/NfuSjhvEK3EDO7zcQ13A+nNYQ2lZGV/0Pyp+E1ZrjHVwcOGL2M214/ACpcg4/AQMzcsZtzGlr0LRuHnnocg2XJPkyZTImu1eT4HyuGTw2WFmdUb+Qh26zM+oeu5nKOJicCQh4K/VUUJpPiZwAdFcVX5QfuxKZ3wVNCAOATmqSuF0Wrl1KXypSdebRxFWMJRGCtmfakkeSaGJ0NrcFMHn+UYsErTzvFXugZ2R3aCI7EU6HZy1E1W1JQoZQGmHgrGrGVsQI4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0js8etuJrqDho9ANOiVPnLK4f1d5o/JrNciesPvL3zqUbjUvKr4NfujgaYU/?=
 =?us-ascii?Q?l4BE5J6wDP8UDscDD6pZHkDbAiPgxXgz71B2FAgyC/SVkMM5xdvO0ZJfB40R?=
 =?us-ascii?Q?RWqBK0VN5u1j2ZgdtLb6DN2NkcQ23FI8rHUvIJTgoaTx0OzqSPNOf0cSriOQ?=
 =?us-ascii?Q?YAkOuZoQljGmti8sRrpXU1lrKrDj99fnBdd+b7+DGVELBcHfM4ZSw8dm9tzV?=
 =?us-ascii?Q?W4BuPIi+OBz9EMd/apymtuG5AYVoHd3+hh7PV6ddGg+2sD0+JwVLzb3bCK8T?=
 =?us-ascii?Q?cUtsF/0VvLYj1O6kaNpflwEdZJ1v4w0zq7SxFp1p1xCi2kCBdGxMcEv6OXLa?=
 =?us-ascii?Q?bgbKD8DMkLdVvVaDDhvKPMA/K7kwaXWTf4cUsAYy1QM8JJz3Njz1uxE+m7tn?=
 =?us-ascii?Q?LXwwQE466HLZDPkpJcn6EPPyW6Jhsmh7Oqj50baTKqFS3xXl0B/XQoZqYqcB?=
 =?us-ascii?Q?Zt7J+FL9iWAg0TqHrz6BhagWnvVdyKvF8WtFnDXSe1OQxa4VUD2C2X9yTrDm?=
 =?us-ascii?Q?eyZZ3X9Ev8H0PGLShvEmuIQGdXZnKbCXt3uV2Cc5N3vBFdlp0m4IhRFkhWR6?=
 =?us-ascii?Q?PavJ6xhNoZphBlOVxdIzo5QsXbHJKW3Xto5OlG1AJquI3fXfhwylghtwyXEV?=
 =?us-ascii?Q?7/oFa2wMvQ6N+/lPNepP22I5EidgDRQkfqh1aGNImSCPxeJ7GH84BoLjXB5N?=
 =?us-ascii?Q?o3G0pHHTMvSidsxOOrQpHAiMcMkbpX0bWWS91QztZj0+C7sqBJZuwGpzJ2JT?=
 =?us-ascii?Q?xaypA0Y1tpTtA10/m34uteynI8O/f3DWOcasUb6V4RkGf0AGdzioT0Yx67Ro?=
 =?us-ascii?Q?oTwzAMwSXqpT7ZxWB6XuDO32YFCEjbmGt1jDafslshR1oKlFDaKEswXwV5l9?=
 =?us-ascii?Q?7l8X8d+wVdxSgHBHskLaBAYecF+i8FKpsd07hlIt5S+aYSmYuENZJdj2Ha/L?=
 =?us-ascii?Q?7msHNIevv5j4wQW1Fei/Zt6pzl2TYiG7H9uIHqMZMKmq9yjTeM933UWLYYdF?=
 =?us-ascii?Q?S74yYWOD2kK/HbP1QhsGbdFN8IHitF3WWyisEY+F+DWSUppjvBa4fY7ojOEq?=
 =?us-ascii?Q?xv0V1/6FKQXTPkHV8tLNAToBBE3N8Fy0BC7NJUeStS0iAb15yhoh2vk6jTCN?=
 =?us-ascii?Q?j2dXBUDf4AsNdh4AM5eIJsKOdChKBAiX4cdw4tRNNwG3iQmRxrr/0FI/675D?=
 =?us-ascii?Q?zCLVOBnfVVa1SkCFrc5QjKJkzlyDVbMrxhEiJdHjJCojr+OWPSosdgoXarMr?=
 =?us-ascii?Q?9jeTWfPBF+AXJYX6hjRu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcf65bf-e0e5-42a5-e4a1-08dc5abf3377
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 07:07:22.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7440

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
2.44.0


