Return-Path: <dmaengine+bounces-10862-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D1qFCYqFGrfKAcAu9opvQ
	(envelope-from <dmaengine+bounces-10862-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 12:53:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1AD5C97B7
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 12:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACB443038B88
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99403E7169;
	Mon, 25 May 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nI5eRu/3"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8D371065;
	Mon, 25 May 2026 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706265; cv=fail; b=IDZCl7eIfC2w1YcToWQf4eXGDE+8kaOESeq0DOuhAf0NhF8TGsyNZGOhf2Qzv1IyB7OZMyc+PQwzrcrljrB+fD6005YCL33yUErhAaBe63q5SaAYqiMI8NSphoz2B6T9i5LiLc2ziyEeQtE/j7dqM0gOFx8eJ0tRDX1lV4nRva8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706265; c=relaxed/simple;
	bh=7grviyMSb1sLoHZJQYNrhAwOQi8Bt9M76P6QyrrqHUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/8LHiDtxdKjydOZEEHAGJf8FneahJ+vkljvy/IfLg9vwF5EaS8xjICkabaSYUbTz5fSA+YhE+btGIwuLFK8vVRGkX0ZOIE4d8/noJvsw9DYB42VfT8CiG+ltUZLx9MOgfSwdb0B94Vp3iTnoLL26oZq4exsL2OmCPG0kV98bdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nI5eRu/3; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E78j6yoNKiEq+ifrQyJAHzbS8O35THI7cqRNr2iaD1jFCz7Cmqt31Y6WFkTVqUB4XJzxhwIgbABRN5MF4QOgZqXpOrqWfgKY+vKP+o9uK+Mi91TdrczVLJt38AdsEIs40uexmUEJAUSpoRZEfGEOiLu3SdyHAqrxWbJTUpBDTosb4GlhLmd5QO+Ev4zVQQj1NAF6Qk/gEwaPJv2xLzolEkGWTMT3b6Vy/L0u7rR1A6UTCpZlHsUcDNnig11VJjWjvEX9s8Sdv+MerYIekEVM901Esp+GiPhK2/r0Hu29mqMN8G//lw4hep41ySFnf68LJQEAxwOy480pQa8SNlodbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWSLyJybt2OyyRaX8KnGrCyG9V7lLiQLV2SzojMMMTw=;
 b=WOOG6HzMNk3SZIw37Y6fcM0UywtPWIKbGDfGPBXh6eitgOwQvGUrAw1pf/vY8qXMZkaNT6A5UFns69PRlC5kssLHcz9nR+2a8c99IYKW9r18qzCZpmeGf4pjMRJneJH9QX/17fm4JHQrPsDrYC3C7MXbGest8XafjpTC/avqO4mWaImFkH8Sod4JTv9am0wAh/hhMqv+PFBbQeeDKGL4BBpxzuhzUoHJCQ7fxwurmKwsAnc8x9AIsUXZGB7xOcdowT2NxChQCrv8NlMWOvZby6MmRMm5rDhB0BiikhTlYMG0esNw2NWa0mRt1QMs8tLGAjtj01Pc0H4NY0/uMnX1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWSLyJybt2OyyRaX8KnGrCyG9V7lLiQLV2SzojMMMTw=;
 b=nI5eRu/3NsM5e5f5RcZqsp3F50cHSNQCS3nRXXtELXy5KJN6Y7WSDJ63XnLR9DwYAO3Uy8TwIOkogxajG3FbMahKp0rDstN5hsjTSppgYf1um8Yb2Lc11liN3srhEf+oxMwD3845CISHH/trb54EFdOS8FGW4JD5+6+D9xWRhEM=
Received: from SA9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::7) by
 MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Mon, 25 May
 2026 10:51:00 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::38) by SA9P221CA0002.outlook.office365.com
 (2603:10b6:806:25::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 10:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 10:51:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 25 May
 2026 05:50:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 May
 2026 05:50:57 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 05:50:53 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nagendra.golla@amd.com>, <jay.buddhabhatti@amd.com>,
	<harini.katakam@amd.com>, <m.tretter@pengutronix.de>,
	<radhey.shyam.pandey@amd.com>, <abin.joseph@amd.com>, <kees@kernel.org>,
	<sakari.ailus@linux.intel.com>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dmaengine: zynqmp_dma: Add per-channel reset support
Date: Mon, 25 May 2026 16:20:42 +0530
Message-ID: <20260525105042.2249542-3-nagendra.golla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525105042.2249542-1-nagendra.golla@amd.com>
References: <20260525105042.2249542-1-nagendra.golla@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: nagendra.golla@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c77e8fb-7578-4e59-e570-08deba4b8232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|22082099003|56012099003|921020|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	IVbRnHuL4tdMRghznap3LUkAMAJHHZC0fJB4akt7iOlxquA3W3X6XTEh6xeG6f0Ndk7PWbnICqbTKfd25TyudI9lkfxX15TS5BB8rAXT0tATP7U0e5dr7YQLQIzIr8FxlghF0YzlAtyhNjK6dx19EiTiXGPzHfMDQIHizTrYf7PjzySq1xZNYfvNghMetqA84gTBumafl1n9WCi45ik5E9QXUZRHiHSlixITvFBUVMzQsUR28/AoEA7ZTKHz9Iv66XETIAjJR1wjovd6gPs26EXUhL+Q3vNZZOpqUD+6leT9KqIpkCaW/Kht4QaaTY/bJAIUyvmr2KlpE1u2EgLfmVOx9CF/c56oiKeGcOfvaTcOSt+g83scbneqDf6Lyr5kihcBOEnPK9z6oDvpCKC5C1snja1orKK47tUyqELP1tPkF4wMZQMpvuV+JLsYPj1luu1c1XbZxC1+o2KZPMamMed4WWItr9gZ9pvuykFKuZRPGx6KcwefHEBL0Hl31qlUI9NSx5DdBec6wo0y8y9lcTbxYPKYwfTY9rB7oScP11OYX5F79ITrUxWHSc05cRTT1sKjY7viaVNE83E/MMnFerZ0rk4JRb0XvFybEzGMIX6tysboDJZrtGr73Yvvsc7oSOM8uQfIyJ+BslJZN7cV/Aw3VdQcw9gtvrTV4ukzauYbDy2qKuyDOAQFhg9d7mLBy/pmOKgAZEH2g9Jv5VFDScflvtCTz/g03JxMODu34aNhkmGayOBNtCzrhGPEiCkFvhZVgHMjhJ1rKw+EVLMx4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003)(921020)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u/DfibYFJDdHNJErb8isBy57/P+1sEVjNf3X+WApRetl1WjL6q9bGkFnB6S0dx9ucA6PSfmKyOOaNSbAm3TJq4VUEpOVTNuTmGEvTuPRdDaWAGPj+2R9imbX1/lQMtBYw00Ljtdt0hgw59ZX/tuuuf+pTaTTG/N0i4u3vu+NTbvZPk046X4kw7kxaoFEjFy58XzV4IhdwiM2FMijSd+qkamyENeV8cQ89AupjoZCJ0J7QcmNVVFw2sdmWVltDy+9/VXGzmeSckPBijCUK3/dcMQwxjNNKjtU3sSMJ1m0JtVHUtNmGrCswvcKNAwfVsg+ae12QWd89a+NyarmN+1GXlYEJpfPB+moQXQrRqnL85MDgcc4sDNvj8zAb3LCYJiLIUa+MbkaSjqHCOEd2K9F1/BLAu+ZY1yGgQM/W6vmMOQM2Bn8E235urYJyXyd2TyQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 10:51:00.2233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c77e8fb-7578-4e59-e570-08deba4b8232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10862-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DD1AD5C97B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Versal Gen 2 and Versal Net SoCs expose a dedicated reset line per
ZDMA channel, replacing the earlier approach where a single reset
was shared across all channels. Add reset handling in the channel
probe path using device_reset_optional() to trigger a reset pulse
on the channel during initialization.

Platforms without per-channel reset continue to work unaffected
since device_reset_optional() returns 0 when no reset is specified.

Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f6a812e49ddc..51c831760372 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "../dmaengine.h"
 
@@ -916,6 +917,11 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 	if (IS_ERR(chan->regs))
 		return PTR_ERR(chan->regs);
 
+	err = device_reset_optional(&pdev->dev);
+	if (err)
+		return dev_err_probe(&pdev->dev, err,
+				     "failed to reset channel\n");
+
 	chan->bus_width = ZYNQMP_DMA_BUS_WIDTH_64;
 	chan->dst_burst_len = ZYNQMP_DMA_MAX_DST_BURST_LEN;
 	chan->src_burst_len = ZYNQMP_DMA_MAX_SRC_BURST_LEN;
-- 
2.43.0


