Return-Path: <dmaengine+bounces-5765-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBE6B02BA8
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A051AA0A9E
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 15:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F7287245;
	Sat, 12 Jul 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yq032jIY"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C81607A4;
	Sat, 12 Jul 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752333486; cv=fail; b=hLZUH6sfN++xvnGy7jqfgvqxvi1C0j7/SdtTVk9Hq2OR9YAhfTHoJeGjmHWhz++URu7p06OJVe6YSKTuwps5vf8jMalR7e0X2VNwwApFPvKqFyf72VuAhitPR0JMXcVIB7c9pNBJyy7FRyVpCs/I5JgEBjOPklhlv1IcOht18P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752333486; c=relaxed/simple;
	bh=Jdc3TA8ZF5X0xot7Tq76EBeJ/6Nkwab+59DqslSpDuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TNrcK02iAnnKwgW/AIbm3pQ9mJsxnITNBxzdYrHcB5gTx68PFUPwxD1GKY25Pm0mq/wI9Ik3w1fAwMpgmH75mq4k4EitJ3E2EUF+tqMzMv2WnxmpZ80+B9YwVc34x2wlMToMP3qGxzPVoUg/NVdS8/fjE2pe1f5/WqRQMrDE+/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yq032jIY; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjQw45royZ2eoy+mxMqTe2KBxPy7mlnrXBBY3GmAmLJOCJhcoPwD7NA1csJjlkxgIhLczAnCO3NFUi2gZfWQx/u648LfZAmQ+pem89OQ0gQnG+lSPnE/Js9+Fymo+/gE6udCQWtrWgHjQ+Lp2jvc5Y9Yk/mau/6bwRd/rvTI1rrn6meWp0YUtg0UuQ7hBJcd44rjj5JuCogkNq0AssHpLxizA2sSMVweZw6Z6DLuRTg2npzppl6JQK6A+Xk2XyWZc9eKdml6y6mp5wvUYghURWJ2nZtkfmImWn+REjKAO3rYrlapwew2xNsCRQXE8bQzWlxVD4hmuUlpSlBjKSb2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWLPaAZn+QUg125pnEiSG25P1z7RqC+IDOnIWBSp88c=;
 b=miOdA8J4zQuuAO81DUDwcXn2w7PM5bmkAqGzEtGm+AbCyaBH2laAA8Ef8LEMnV17NloHwiLJGeYzBnDMv2ppBS5VJfjRaodsy8II9tLIH0EaQpdxjFsEAJKFWZFnSlijHR/FMlA8j1+jrUwdT+4fXxHiUSmJ2uB/1/haaz2w1DpfXjoHn0gvxkXn/y11Xm50PqwGBKJC7xxLpz5+Mn7lvwriKyLDCQUlTwvPy87DHaZYGrRTLy80tL5mttu1Fkwy4cELScVnN3QwlJGBTlU0xf7YERyKDISPmEEagc+oonxgWupQm65ppTg6K67Pmr+jmiOfCcli0SwqewYHlUXsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWLPaAZn+QUg125pnEiSG25P1z7RqC+IDOnIWBSp88c=;
 b=Yq032jIYSlPwSRyD3q2ZgWSJNVgbMJeaKHelewnjbYJyyETLtw2NbdKhvu3yVa/HJ7MWKiolylL+4+CuBYCWXGaM8jThVN+1kjAF1++cbDCJIoF38daE4SoRzoA6b1dtjrUWO0KzuGaI+eN03GL3NoZAZhRMk7N46EbZHC/fJc8=
Received: from DS7PR05CA0030.namprd05.prod.outlook.com (2603:10b6:5:3b9::35)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Sat, 12 Jul
 2025 15:17:58 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c4) by DS7PR05CA0030.outlook.office365.com
 (2603:10b6:5:3b9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.11 via Frontend Transport; Sat,
 12 Jul 2025 15:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sat, 12 Jul 2025 15:17:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 12 Jul
 2025 10:17:55 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 12 Jul 2025 10:17:52 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <yanzhen@vivo.com>,
	<radhey.shyam.pandey@amd.com>, <palmer@rivosinc.com>,
	<u.kleine-koenig@baylibre.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dmaengine: zynqmp_dma: Add shutdown operation support
Date: Sat, 12 Jul 2025 20:47:52 +0530
Message-ID: <20250712151752.3669944-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abin.joseph@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a132ff-2ebf-4c1e-fbbf-08ddc1574888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QP1kiTFxe4EfXuhsFtqSUUDWIMmGF+aWuJ8ldRv32q7ULrfUPSHwDFpY9Lqr?=
 =?us-ascii?Q?L9ymC4g3pYMZyytNf6TZm13wxTEkIyyxNFKdgN44MmxjFHAZnMxgDLRBHsPt?=
 =?us-ascii?Q?prTwO443fcXt4LLGythebn55qkFGMYmDgTKTWJN/Lv/KDBzli3WlsI4YuyIV?=
 =?us-ascii?Q?/Bub3gIcXE9dlQEbGhat+dBw1wkIJx96RqYFsA44xdsq9NPbqD2gkTQopL0C?=
 =?us-ascii?Q?UK988WHtTRRjl/yuMP8BGeaisnNmvGdxtzc3tiXiFC2zHFCLfqNKbweDF0Jp?=
 =?us-ascii?Q?aCBjV9voI1O8Xusi+HvktZI6CXzIAKkDuIa8oabbsf6yLSn3mV9ZXuGFza06?=
 =?us-ascii?Q?0ejkdNasEfYUrRBs6z04/z8SoSEaAuDjEtg/W7gBe4vJZfI/XLMeSLvbrHnk?=
 =?us-ascii?Q?efVEtylRk3cqKVPykAjyb2+9WOqyekAeajD1kw5IIEBIzLgdyVnIcwXH/5dS?=
 =?us-ascii?Q?yprkKdWXy7beGV4mN+rEULGVB/rvmahx1ZmTMS9qRCA3FU6fV3kd1UqTEcMB?=
 =?us-ascii?Q?1P+6NSekZTEZPTFquv8mny0KM5s1Vllpb3p8SGSKHTviflpUih7OutICb7dM?=
 =?us-ascii?Q?RvNSjpl5tangLpJrYFpOj7b/KCi1WA0beye8JS+Apd/h8YIeB6+XlZ4KXRH4?=
 =?us-ascii?Q?eP/7ZRJZDo9d8ASlysfbxQ9fzMj3ve8z1LgRzux+7YSF0B91QUl0uMVWxNLf?=
 =?us-ascii?Q?nC0y84Qf8rR8dbNCM12awpI2XbWvRs2ctmD7EI4iPh0wwl/yvK//xiSmDHAG?=
 =?us-ascii?Q?Y4FcdjgAkDBxI8MykUsR9kCMlboz/UxNV8+aQsJli/VYLltWC7rB23jmOGYU?=
 =?us-ascii?Q?8MF0c68+p4ukxDLitjw20AfpPUN3zJ8FJL7/6uc8cs6fQs2oHNA8B/AaFvZU?=
 =?us-ascii?Q?S+aHIwuTNoin55YBdWrNKxBlLU3PS/NsYQ2iZjSeILQEpe8isRBqxbCUtiFF?=
 =?us-ascii?Q?DiVCVG5H06VFEiH9NGDKIVxDeaL4ahMUxaAsE/rXVggmPjoXLkAy/R9vmcoZ?=
 =?us-ascii?Q?UbsGO5IZ2+25YQ4QwTzTW7UG9ab+9NbEHjtnQWHdXdeur1WtzScY8zkkPzKS?=
 =?us-ascii?Q?cQ/vbcdFJgnvcjMXeffKhn+l5pNSYYFNsLS0+lwWX9vSGVpqyYPGutWkVhNw?=
 =?us-ascii?Q?t5wtSUBCEcnV3CH9KQA18OCNF2Y4ahSIevcGKLx+tlAHdFeol78ICcLGgxJn?=
 =?us-ascii?Q?QsUri+QUxdq8v/1bRXjkm/0dmCBkR8YRQvDLB5wTYsRPKd5E0gTrISCBOivf?=
 =?us-ascii?Q?RcUTKpzT9au55DaL7lEwn67BLRmrqZTnNw76FbcMk6nECPU8m/fiy1SyNymY?=
 =?us-ascii?Q?B7BqVNTWrUnl+UIs0Kpk7dZ/Ezklvb2CLj/SatUx8jkaubWyO8J+ByHG0oFF?=
 =?us-ascii?Q?X087jWDVOuHJTJTz/3ciqiVr4r5ZOhn3dsC4UjfDPJ8VQ0GnNLd9dOgowvnz?=
 =?us-ascii?Q?98wnk+GYN52ZCgjKlJ41cqBHPsqEMiDbgSl9IABCL2AkoK6FHgheUWxv0qhb?=
 =?us-ascii?Q?9/cqDBie2f/BLUcj3p5o8EIX1eSGqXlIxEru?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 15:17:57.8984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a132ff-2ebf-4c1e-fbbf-08ddc1574888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

Add shutdown callback to ensure that DMA operations are properly stopped
and resources are released during system shutdown or kexec.
Fix incorrect PM state handling in the remove function that was causing
clock disabled warning during the shutdown operation since the device
may already be suspended with clock disabled, causing the clock
framework to warn about the double-disable attempt. The current check
ensures runtime_suspend is only called when the device is in active
power state, preventing clock warnings during shutdown while maintaining
proper clean up during normal remove operations.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

Changes in v2:
Update the shutdown to perform same operations 
as remove.

---
 drivers/dma/xilinx/zynqmp_dma.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index d05fc5fcc77d..0b03c2092c28 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1173,9 +1173,18 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&zdev->common);
 
 	zynqmp_dma_chan_remove(zdev->chan);
-	pm_runtime_disable(zdev->dev);
-	if (!pm_runtime_enabled(zdev->dev))
+	if (pm_runtime_active(zdev->dev))
 		zynqmp_dma_runtime_suspend(zdev->dev);
+	pm_runtime_disable(zdev->dev);
+}
+
+/**
+ * zynqmp_dma_shutdown - Driver shutdown function
+ * @pdev: Pointer to the platform_device structure
+ */
+static void zynqmp_dma_shutdown(struct platform_device *pdev)
+{
+	zynqmp_dma_remove(pdev);
 }
 
 static const struct of_device_id zynqmp_dma_of_match[] = {
@@ -1193,6 +1202,7 @@ static struct platform_driver zynqmp_dma_driver = {
 	},
 	.probe = zynqmp_dma_probe,
 	.remove = zynqmp_dma_remove,
+	.shutdown = zynqmp_dma_shutdown,
 };
 
 module_platform_driver(zynqmp_dma_driver);
-- 
2.34.1


