Return-Path: <dmaengine+bounces-11613-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8wYeEH2aM2p3EAYAu9opvQ
	(envelope-from <dmaengine+bounces-11613-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:13:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D126569E017
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:13:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=uE93VJUZ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11613-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11613-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B93D304D769
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8263750C9;
	Thu, 18 Jun 2026 07:11:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7035DA6A;
	Thu, 18 Jun 2026 07:11:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766684; cv=fail; b=RJ2wukASlRq2iYQ4MDVYuzK6VjPK8ElwWoSHNVeX4GUbt3VoAexPZ08EQbK1P4MlxNstLU1ruCVYBeSejOX7nsXPh8RTleDu4vT8yVLvD43+ihztVOOI9VKZfDfp00maBtVEb7cuqjWRJyYvraeCmXuIvR6sH3Cd/wa9eZrSuTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766684; c=relaxed/simple;
	bh=Jyl2bO8jE4gWMk/648LGXTBnPsVgl6YaQosRcTYIZ/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SN0AnUEpSIirz7d3c9CY7q7Kmm6GIKxVbmkexjwBIlHIi+vvj2qk0nzvKz1CLuaiO4sKvSXUs9umIxbilq1wm7Wr8D8YWGzsBpByhTuZeRBcxmtSMb49RA18doXS5wDJKPdaBP8PIuitdQe3S/+G/KL2GZZzl+xxQYh1UNteWLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uE93VJUZ; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnjZhVqCZ4DWJ5sC/BO7tB/seiVjbiOBYXBNuNZ2Z8vtokdia/oA3U6b8bqhNCqYAu1ciCEmu2l8aCpADZWtfb1+VHrJN8ERY54aUhLFzB7+Y0qX7xHI0Q3yo3J48kKsf17qJM5umq8uwDmZ4adSQ/NnqvB1qh4eslyM10QuSvU97wMdz1bxf9Gsj3MUUQsRsZrySmc7LqObFlmAorduxR2wvuc//OPFYZqoXDCHOXKk3eXi0TgpfMov+Kd3f/eczQ9BurovfSvJjJfvBf8Quwv6mA1tJxo4M2Fo5/eirX6bt+T/H9LmnDUoJxTgw+ZZfI5L8CQcyAB43/tS2AgYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVfadFFCf14hF6YZ2pOeprgUV6tIRja92u+Ybl+tWB4=;
 b=TvgnlCBNIvdMFiY5DdUtc0/m7/XjiM1masIqd2xZZHx+uXGOBRYqKOky5PGSOJTzGXdKQY0BQurPxpR/lB4OcypKGjPM3rqWboBCsmzVgJcWUDPAqx2MH40gWp+yymdiCE6zj7gOBw6D31SyxFufgF8y5nZzr/TrXUEq8xrlj2yGgahA2tWJgOZBo4G20hRsTYhwh7HNQV0AMuApCe2ZpJt+ksfEriIgIL6joa1CXnPLVjX/r/4VzmrWg9stAdbKgQR0gyxeSYQUMt7oUzGNDEwXB4n0Wr7AK214Brnm7Q+uBXXNn2Kykg19/YIlKqNBF2YNvxfT1JoBydyoS9D48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVfadFFCf14hF6YZ2pOeprgUV6tIRja92u+Ybl+tWB4=;
 b=uE93VJUZO4Bqh01RSUedeFIVtgY6l2IEQIrhHAwT6drKa6Eru0j3w79yGhzs0S7GI6XxlExib1xpx6sLbkZ77P7dE+QHzJb5LkG6NHhNeiAhPJS83ZBe+65Q19jQN27HgKVsVRiJBkNE+OMRBLVxsqYvYYJFQBll9AQwyvXxSfs=
Received: from BLAPR03CA0112.namprd03.prod.outlook.com (2603:10b6:208:32a::27)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:11:16 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::43) by BLAPR03CA0112.outlook.office365.com
 (2603:10b6:208:32a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 07:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:11:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 02:11:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 00:11:11 -0700
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 18 Jun 2026 02:11:06 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nagendra.golla@amd.com>, <jay.buddhabhatti@amd.com>,
	<harini.katakam@amd.com>, <m.tretter@pengutronix.de>,
	<radhey.shyam.pandey@amd.com>, <abin.joseph@amd.com>, <kees@kernel.org>,
	<sakari.ailus@linux.intel.com>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/3] dmaengine: zynqmp_dma: Add per-channel reset support
Date: Thu, 18 Jun 2026 12:40:55 +0530
Message-ID: <20260618071056.2024286-3-nagendra.golla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618071056.2024286-1-nagendra.golla@amd.com>
References: <20260618071056.2024286-1-nagendra.golla@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 6919e0ec-b8da-4746-f0f4-08decd08ca0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|7416014|36860700016|376014|921020|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gAm5fSAc6hTWCewHXnl3RSw7s6sl1IMxsFAHnsd9EDVuoNgUQxV+NzwsR39Ob0Kbwo0i/gHnYD/UE7TZCrhv6ncs7Lc7LpjSc/1WQtwsZb9p0BJap4JYVFNh9a6FivHgWoszfTcEFp6m3RhW16zR8Xbhf08wAskX9EvLL5ZIfVvVDKIxq3WJEqJdfgl61tm2FLjylVcd65b/eRj69GJnabwzywE0jw9m4NX6Itox2m3meoIxa+2QPU0Xn1kXRUPgCAilOMU0HtnXCCigmEAKuGJ/B9enJJ9lRrClp/kanP0H0HtjAVGvkUR3bRNNHPo6raNWgN7BL/ZqMKfsybGGsV6p5nHH79DajDNvQefVq/gGOYIutcRC0M0ixDUjBRe1lpFcBrJVZZb4u/F17u35AlP6dqHnOkGOBCCs0DrXAEZeP88szWdCTpsmDYYedbqpr9pA0tR/OtO60i/ziG0Oj2SADXNXfVIjL3peW4ufE/+DYNmDd4417I5wHMrR7pBy9naJ0zacFhjF+MHRM8vojZM8D2NOKB6MN/gCWURaLOcpb18GFwpNrDasACpo1ED4t3fV36vJpy8NZw9l0aJiK9nCYS1EXMwBMOQHtp75+M6aGm3h8UtRdgtCtBzagC7PdRGv5Egcn0W5tbAKgk+hefPS3xt6fWvr13CiK/g+VJp2fFOfjoh4sgtYvo/tjnkCzzCYuU66ta7NnmeeXxlT0kCRfw56E8MVoY7Q3uQF8M461RiSm2ZjsL7ZvjviOfG06AVmq5gk6UuiqsuXn8VpeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(36860700016)(376014)(921020)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IzhWm+1gY8p4uUQegb1r5USeSfFAOjY3iSKqAy5WSglXgE3fJOoHh7E0+uj19XhuIEBTWtw+e26GFfcdOlZKljtQqWtDI31wku5eZR3sJTGLpkz8hvIaNvSmTjL1XtM0thuANtp1xUsPfjVP2MvHpFiZi488W1q6AN1Dld0EEDDqYygbfhgGE976CDnZilud6IgEisuL2dOgnks+jDBKlEmMGUVeYM4GlaVz2WRdAVmcoMjD0XsVsMtmUHf+TT7Qr7NfOWZD1EbEt5An4mkoxGFIvXsEEeQNMjs3jduKNDkUgAPslqLSGpuiJ/xh3BGvZx5whFwK5FFNqz6pnEfDEr8NGOr85GPzBJ5pTvDZQxOTeYwGySYiRprH72TX0qU/++SzbkXGLakq6whKlaZuGxNDUOOvhP9whFypLmtfVeuLJkSNxYQZ+HzZcYHnhJeh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:11:16.5961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6919e0ec-b8da-4746-f0f4-08decd08ca0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11613-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:nagendra.golla@amd.com,m:jay.buddhabhatti@amd.com,m:harini.katakam@amd.com,m:m.tretter@pengutronix.de,m:radhey.shyam.pandey@amd.com,m:abin.joseph@amd.com,m:kees@kernel.org,m:sakari.ailus@linux.intel.com,m:git@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D126569E017

Versal Gen 2 and Versal Net SoCs expose a dedicated reset line per
ZDMA channel, replacing the earlier approach where a single reset
was shared across all channels. Add reset handling in the channel
probe path using device_reset_optional() to trigger a reset pulse
on the channel during initialization.

Platforms without per-channel reset continue to work unaffected
since device_reset_optional() returns 0 when no reset is specified.

add pm_runtime_put_noidle() in the probe error path before
pm_runtime_disable() to balance the usage counter incremented by
pm_runtime_resume_and_get(). This is particularly important since
device_reset_optional() can return -EPROBE_DEFER, causing the
kernel to retry probe() and leak one PM usage count per retry
without the put.

Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f6a812e49ddc..a9dfec3c0ca3 100644
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
@@ -1152,6 +1158,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 err_disable_pm:
 	if (!pm_runtime_enabled(zdev->dev))
 		zynqmp_dma_runtime_suspend(zdev->dev);
+	pm_runtime_put_noidle(zdev->dev);
 	pm_runtime_disable(zdev->dev);
 	return ret;
 }
-- 
2.34.1


