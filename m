Return-Path: <dmaengine+bounces-1054-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED28985B912
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E751F27288
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6D629EA;
	Tue, 20 Feb 2024 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Msg/YHe7"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2084.outbound.protection.outlook.com [40.92.18.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43CF64AB0;
	Tue, 20 Feb 2024 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424950; cv=fail; b=mdvyJb5kABrfhacXrNqAlM0uf5zo/URZoaqrjH+iCai1A++1f4wt7BTHYGU2W+mZsnh8x+vFf0Hfh8Ds8L50L5rGCBOxiJ/trJ7mNnKR+3qi3e3nURuLGO/IpZSXyDODNw1P8sIGdv51NjCMCnVrT3VSNGtCUgrcQJmMeDSZiME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424950; c=relaxed/simple;
	bh=KFjDzG+7y8lC9tvfGHbYkI88rh4Bwc6aVu5oAP3VAmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqXIIWUQ69Ksw34i/cO3LA/lF3WPxi+3yuZoS8tqBLXtptnSOGUXluUdL0hBwKlXztC7Msx5gh9ZHgcldhGyhZAVcBmgr4ATd6Lpe7l5ksbgMrQ00Nt43BIoGUilRkVQE/9cpkdI8frvPKNgij+bcqQfCWnGbssWBsXbk0j3AHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Msg/YHe7; arc=fail smtp.client-ip=40.92.18.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Srx8JGVmbcU/xi48hLj5EPiJgA8diVR93qqCfHRBevnPYJuUcTf+PB8PpBFLCeDfKaZUs8n0ZPlbsxhRvfVa6D++Bkn2bZW1CrUOrsJAeCbeOsIvIx3/zpWRSotTHRxI/tH86w4+5n1f5vjLZk7sD1/TplWjN235THRF4sw+NiczqF5fUBdVYguyKJej9+9C79lsGWXduxTWJHr0r4Ugffvcx80IbcA8YdaSXUt2E7+4HNzZ3eC0bCQzchmroFlRWPC1tOCKbzilsJMzRNHyGn329AYiMT6uCW5M4SQAjLtIHxUNHJG+HiiVnmTvdq3OxgiZ5YnDk7NL1HWHnJuX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I4Jl06eg62S7kOQvj3HvGIzNzzrrdbNmYBf6ba374M=;
 b=WnFqon0xL8YX+Y54SJqDHTh+Ct282C8ZeCR40nrHal5s4rO4OcFmIO0F5pC5gGzVN727DPB+O/KOGK0co7iAKdo8FXxSDmeSfgDnzIrOm9hTNDDWvf9LiVvuoy/xTEiGJxsL3HhxS4vHmNVSpX/XqopVC7VpU348YRW4yb9IEKQuOtwJ3Pz3A11PAh8kQO/sK+HQD1Ttm5qtqFgpwCezEHQz/Klrn7OGgilYNZZbZpzZlThMAsXBPQ2aBlVPSyNO/TbMTXK40qgvgUYsXkxAapMeSMhDNuhA/lTvTqTbofL1zeQOX+B/q/Ph+TFXy9afeLfHx3ZBEwPVe26ij3TxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I4Jl06eg62S7kOQvj3HvGIzNzzrrdbNmYBf6ba374M=;
 b=Msg/YHe7BcqkdJPVtEYehQabg2xyyIg2Nd9uv96IUoRK8q35Wt9EQ5kdpIjlY69xweKQnSAx1BtLlcYz6OE7rU2At28vJ7b9S1Gsx+3e5Uf5zdU46KC1QJ252X85XQ7Of4tSnHdkba5O92/CL5+u+qrKl3s4Uw34lCEJHnOOa3HVsp1PQ7d+Y47TcQ+szqbvMN/YfxAzBU7ChZTHQZESfjZT0hyVLeudJD1RCpULQkhiSeLHsIvYxvJHWw2W4MKtRgpQL0wy1IMlxBtfJD1VghVgVL+O1DJE9QT2U6+Rnv3FDA7shRgas/9wu+jbbVKm7fUC0ZCJmI3is59nj2gL1Q==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by IA0PR20MB6813.namprd20.prod.outlook.com (2603:10b6:208:405::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 10:29:06 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:29:06 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Tue, 20 Feb 2024 18:29:00 +0800
Message-ID:
 <PH7PR20MB49620ADF49949612BC974C00BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7lfz9GNWhSgmepKfThLNLsD6w2f0v2/Gow84f7sZHLg=]
X-ClientProxiedBy: KL1PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::23) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220102901.874602-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|IA0PR20MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbe15e6-9f95-40aa-fc66-08dc31fec418
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lybyhqvjgY0zS00wJ7jJ0KMSoxgDO+5hFud4WrkfHm4xEgW6n1lT6QjF4DHDsDfijy3sLWh/dz6Y73cbNUBcRomsATNNFFQncLs2MVc0Y7z2uDk5UELxNGazeWEnY3KvFXVcKL3Ny8JLlJCR9J59SL2DNLzyrIji2A69eX1gVP1c7D2NyyVrzk+UGnZcqcaY/6XWmwbyEBHmOzBnfQ3UHXtwX6EFJwkt06V8OlGK5JvBqJzMndGXhKWhKGwtRs4uACxQIobqm8yMMXgYxJBXO9H7vNquPmtYxqXHh6fcTJzPNX7xjboLY2oACq7iIyt3zpxiFbJMUN/12blxfVEuCW9M+bWFpFoSaBxni3z9sIuLIBF85xYubHwyM0JpJYDURLz11ybGEV4cfYX+EeZS8HSxzTrxXLohBG6LjKbd3bXiULu5yoDRpJxDgskJYEiReA3HoKOEfDT2rb9L0eLEnqpr0IX7FVRs+m0TmOc+cLt+CqdeTctPr0HQJ8bn8PpxzAYAJgBfjIbgcMeASgzPPw0d51i487b+YgtkTfu1OV1EK+FO0OUpQM2aq0oEuFQl/tg2Qg2+/UT8cUmZx9+FkIXFdrl3pMfAZgSZ0JEYWe2Iq5RAUspuuVdy6JQpIxK0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgs1fSMqh+xEE4U4sTr8KsC/wAxh354dKsKGSMLhBAACBmNWGYDwV8d/C5Nt?=
 =?us-ascii?Q?QmHIw6UjAN8DxKqDgIYyf1/zEV8qGBEGPDIyCwR2Pp/Jk9Axpxv4vDAR1hyE?=
 =?us-ascii?Q?LWvYfoPMuJ0uROJTd1K0hzUfsZdweL9wfS1QOvsmRDEREdhRWcjEK6YbeA7+?=
 =?us-ascii?Q?cwt00pYIHQjuxcMv8xX88zC8N9jh1/6yOp25Gq/R+mpgObM/sJHh+0CCGTpP?=
 =?us-ascii?Q?rJxQiAWW8cnL6s1ud7mB1OAPeO3NlOnl7rM+IZAjlr2ZHQxsC3TXWklhCi+H?=
 =?us-ascii?Q?4YDcEHwoYIeoUFXVemiVpLTFsadXJjaXWY6Gi+DQAqFOy9pnDnMm6vOcPZq+?=
 =?us-ascii?Q?qMd3Y87j3A+l0JsuQMN8KFtXBOxcZ6XzNyOxRAMlqgcCdz8TegeNdGM1oGH4?=
 =?us-ascii?Q?chjq1LyHAk+F+auDxWBzrxl8qPx1YYR9NfzkUbu7W0tK3ssBeQXiRhJPVZ1w?=
 =?us-ascii?Q?+oBm0OMw7nqDUmoupZTo8laYYs0nKy7bruS0M/5D9ynXaa4o3h6in4PEOLYs?=
 =?us-ascii?Q?ux6VfnP95rso5s2y3nqvfVgttQrqsvfz9OmH7QIgL7f/yot36236ndGlRtY6?=
 =?us-ascii?Q?lJfvAowAPgJ/MN69AcCdrSTIM0/9NlszvcBat8r4CgQTQ7qEK7C8v//iDPYW?=
 =?us-ascii?Q?qRTvD4USThrQR6QTxCsZ5XcYsntCfarCd4sZmDLqWj1rofKZcSqLWI5OPc6h?=
 =?us-ascii?Q?eJRFSQeSn6Ham46TzY9En9H+22mvQ16AE5oHRRpDi8qgiPr7DKqiCW4Wisq8?=
 =?us-ascii?Q?BmxKWsIWb9xBoGpWDo5feJ0TQgZ1EjjKVyOBXbgouw+wYEKkwcaXNFJJO97z?=
 =?us-ascii?Q?fXBL5l8bWPK2Xku/xnFWWpTDu0yoOCMFJ2aMJT91dYw632t6eGpYGsyem/9P?=
 =?us-ascii?Q?MxW8MQQ0oy5DDAS4HzuJZg8WvsvgZcuhMs7zY/WwAcXwc6zjsUsyEwoZe+2t?=
 =?us-ascii?Q?ZI3mOgRGpv+ocR178ExJLuvIrlyD5x4L1kvqOkhNDw1FZcUhhrhkK++cLaXz?=
 =?us-ascii?Q?3TZaOkjQZDNNSsGG9aGfm7EGW3aBYdGd7La+KNXEAErbW+67JUKVLkA6H/7m?=
 =?us-ascii?Q?vl/51imMdjD3bEPQhKamVQRnq47H+cF5gbHl5vyASVvR9TkId7YOrd7JsM3P?=
 =?us-ascii?Q?Pu1LaRVD7x4tO4Am9NG7OuB2YRhp0c9zHJMUluzbh3rwEVfxh9PkdXhtPsTk?=
 =?us-ascii?Q?aTuBERyiH8tEzX1O8uKDAupzI9WPr6/yryi+fEm8/la/JnQJUvoKprAsBC1E?=
 =?us-ascii?Q?x/6rBnksWlyWmhXl1Zt7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbe15e6-9f95-40aa-fc66-08dc31fec418
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:29:06.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6813

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
2.43.2


