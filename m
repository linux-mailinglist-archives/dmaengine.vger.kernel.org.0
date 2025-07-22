Return-Path: <dmaengine+bounces-5838-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871EB0D24E
	for <lists+dmaengine@lfdr.de>; Tue, 22 Jul 2025 09:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA33A177536
	for <lists+dmaengine@lfdr.de>; Tue, 22 Jul 2025 07:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D828A1DF;
	Tue, 22 Jul 2025 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CdBWmK4s"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10C1581F8;
	Tue, 22 Jul 2025 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167967; cv=fail; b=A5x8qyWhpbExEdltsjsqlup3qUxtekueysUDbofkYAnp0I1DAO4J1tcSfXFVfyaCtcH7jswytDzuiyjsR/RKf1PFLWIxkBGUKqIC350t2x8r3yneFoX+uhjsAul+gQ+KzDoekQXBVORS/8UEzWwjUsSEK7ztHNJcyfCVQkdSD4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167967; c=relaxed/simple;
	bh=9ixKSRTp2gPgsESpSO/3dFw69kh0IMIEito20NAa7/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TRtjUAT36anjXZ92UUn5zmVe5KKrTTKqyu7tvNN48icYr5K0sagm1niR/hW/S4rSzJIc9/o9VrUPOE2oMBgAUgrVFIUOcGXLAJNNY2rXjjg6YFX2Vm6hkF/cfQYjrAF3Pz7DxQm6ubleQfE9THlXZOf+HFnI2DEDR6yu1fHyCWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CdBWmK4s; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTT/cB+wMNwQfIkrHU4y7QvzW7/5VwVZi1XcLd6hfL+ZocR/LLgIk+rj3Cmq7qkGdO+6Cj6Ia2NKM5dYQLaM/9usRKH8IoH3/Kd7K3j+4BCrLA9eXpzPLxXELKOx9KfByvhom/bExovvj7a/cOf5J77uxgWe2hPY5V5aTykvy7Di0wk5u7a1rRd/ScCjkLeiesLVF24IhTDlRjVXxTYZibCXtOLvQ38y70+WSkTOtaW18vwDqNTRdFlEaXl1TzK032Ivf3YOsNZvdCEdBj0yDLU1l2VtX30B71sTmuvlUXBQ3KomzrtVxs+Ahh758NhCEDLAfZG4/y8WCltxBfAy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wSxFYPnJad7bm+jV/SYavTLH96P2ba3VZaWS9Ifz3A=;
 b=q875rlUlfFouwf9sclzcKvU9DDyS2czWPL6gHeHZc+AryWe4tIN46HD7huayAUhdq8wKsjOzJQdpfLvm8/gN+maZMAsM8XIwPrZhnnES6osjZyfAH8M8RX5uShdQ/5jwM59A+nTdlNUK8WM5rm0dVaA/nFUcLMcsXhts9FRm+/kKFUJbiVhoB731uHphgVbEyXpYwQUn+FNjyVwny2iyDF6tz4+EOalI3i1eUNnJxX/ACj4PuVsj8oFcq7BbuyVtce3OdLl91/br0g2RXqRqOwwrwn+Xqwa0NkVu2jsiUHBjqOmzc2yGgSDAIdfE7yI8iVaa9Q4q4xDJ+MyZisx/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wSxFYPnJad7bm+jV/SYavTLH96P2ba3VZaWS9Ifz3A=;
 b=CdBWmK4sfK48p7bSwN8zk5R2F8liG6tfdw2J2+YbKSXzuC92H3QS73syyoM0KIC0onVN8v3KsphDKcvZzrJcesKomU+d5Id8t0FNwNvJaBOxo9GFxdB8PqSerJW/OLMJVCuLHzPOf2534A3X0FWK6hHrSm1S2qIrAfbOS63nZuE=
Received: from SJ0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:a03:2c2::14)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:05:57 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a8) by SJ0PR13CA0039.outlook.office365.com
 (2603:10b6:a03:2c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Tue,
 22 Jul 2025 07:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:05:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:04:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:02:58 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 02:02:55 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <yanzhen@vivo.com>,
	<radhey.shyam.pandey@amd.com>, <palmer@rivosinc.com>,
	<u.kleine-koenig@baylibre.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] dmaengine: zynqmp_dma: Add shutdown operation support
Date: Tue, 22 Jul 2025 12:32:55 +0530
Message-ID: <20250722070255.28944-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 17cdf52f-7709-40f8-86e9-08ddc8ee34f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dfhZ1gqjoFUZaHdJ/Lzik0z/3g3paRKXnzAcArmcjDA7Tz2wpSvYLD5ZpJWP?=
 =?us-ascii?Q?av8qtE/DLj6R9aCdArHYanjUxvNEMJm3jsgm028ViGszUhHD1fzRnVPruzkD?=
 =?us-ascii?Q?TSoRQ+8aG2klsj0mrnmg58ka4C0nvrxe7gNWLu203KMzh0oApV8SCBQ286ea?=
 =?us-ascii?Q?TepD6r0Xd5+7t+L4bjWgQpTEISq9dI2QVQI/QJTzS5cLQSqi81mlNMc25jsI?=
 =?us-ascii?Q?Dk7cuUHX20DBxZN72BHVE/Q/c42uH8YWHCLZJEh+Wg8hNjIi6aF5BRPjyroq?=
 =?us-ascii?Q?U1Uc7fhRJ2mUIXACCEp/mXON2r5D7XUfWNWmuc8dTF908t+h1+NESMazV84Q?=
 =?us-ascii?Q?FYBcNKyRzX9kX1dREm/028KJJSTcro4CX8ptBhF5EV02eyytSoBF8MdctrwW?=
 =?us-ascii?Q?G0i40nF+6ivE0i0gbksBcThGCQi3Ni4QG9PJjyIAUzuZeferP9LqutbDTF8A?=
 =?us-ascii?Q?hpJEnJrB7W5G9rJbRgjc25HbVKduQ4DEscsdihETLMEZEVqk9ejAiid8Rz2p?=
 =?us-ascii?Q?MGzUmJr0wwpFoy27s9Brp9t7Ofe0+BCcQZFBbohG9ZYfT53LlbuyqoHOrEaN?=
 =?us-ascii?Q?vhac/dhgLRzlSXvFHUzUBOPmxnDIp+OsgCfkyR1XaXXSrTmabYf4TB8Tf9Mt?=
 =?us-ascii?Q?+vvqr/CAuIlDf809f91CDwdWIE1bfED9aoZpxXlRdUCwOhMtwtUc4FswxtmS?=
 =?us-ascii?Q?KxNdpD0BIi8R06l/Z9IhVhH6XV3JaGxXVd2Zb6Yk4NLJWCCp9NREDgFt9sh0?=
 =?us-ascii?Q?0TUr7Y3DWkr+BstwSMOXiv582vnBDBQ3JXCNz7hPZU3v4gsBwt6MaMIgCxFV?=
 =?us-ascii?Q?jYmeUz5chWEZ7i4D3YGAuV4Ls8dYkKbm848NEsVfZrWUjK2VsUh1RtTouebE?=
 =?us-ascii?Q?w4y4eSb5kWEo6fbcfYGawNGqAAyVjZqEf/9mmxqnK56qf3k1S2yeQR3kq6WE?=
 =?us-ascii?Q?v4njFk4WyZsKOPv/AG7DE6SY/8f99mv/GO3Fvdfa+ZnYu7WipyrtZPiCJkJ1?=
 =?us-ascii?Q?vN5VQItdr7Xg1765mIIqYPqbSlF+OAPPqXML5fXz8N5HWC0pMOecBq/qkVWj?=
 =?us-ascii?Q?35yUxtx40tO0Bia0yvdBkdHnAzikuUqWB3FIVOMr/HufLk9boorCW2Hiqy9L?=
 =?us-ascii?Q?epp8IujK0y6kWC1o78+2SpeHmjT8vGzNvxoNw8jJe2gkZqz57l/M0Ke1jV9c?=
 =?us-ascii?Q?bNgbMB1zknqVjWLMgOL+BXPiPw0INFmEd9/BffQBaG5Aks09pCiJRxUbx9pu?=
 =?us-ascii?Q?xzh3SxqyKrz106M7NAqbLw0HLRqGgNnYeZ+qnLXsfxTubM3Vg05MeXRwKjz/?=
 =?us-ascii?Q?yzHzBD0+AK7VOvPu3guZSZFFcFTC1ypPTaGNkKKGXD7iUdgsvsJv3S/MYmVR?=
 =?us-ascii?Q?ftX3HC9wz3HxIXISwKW6BYkza+kQLsAKibZTG7CYzRgiJM1c3RV0uA8DQ0jl?=
 =?us-ascii?Q?frYuRgwEmUU11ouianjmm/GcCVlLb5jxEzohIXf7GtL8BkiPka4c1k0utLKO?=
 =?us-ascii?Q?rJy4w3Ll8ZdfXzwlPp/gQ5xlsCjwOO/0X+QW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:05:57.1399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cdf52f-7709-40f8-86e9-08ddc8ee34f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294

Add shutdown callback to ensure that DMA operations are properly stopped
and resources are released during system shutdown or kexec operations.
Fix incorrect PM state handling in the remove function that was causing
clock disable warnings during the shutdown operations, which was not
implemented earlier. The original logic used pm_runtime_enabled() check
after calling the pm_runtime_disable(), would always evaluate to true
after the disable call, which leads to unconditionally calling the
runtime_suspend regardless of the device's actual power state.

During shutdown, the device may already be suspended with clock disabled
from the autosuspend timer, causing the clock framework to warn about
the double-disable attempt. The pm_runtime_active() function checks the
actual device power state rather than the PM subsystem's enabled/disabled
status. ensuring the runtime_suspend is only called when the device is in
active power state. This prevents clock warnings during shutdown while
maintaining proper cleanup during normal remove operations.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

Changes in v3:
Update the commit description
Update to call remove directly from shutdown hook.

Changes in v2:
Update the shutdown to perform same operations as remove.

---
 drivers/dma/xilinx/zynqmp_dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index d05fc5fcc77d..f7e584de4335 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1173,9 +1173,9 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&zdev->common);
 
 	zynqmp_dma_chan_remove(zdev->chan);
-	pm_runtime_disable(zdev->dev);
-	if (!pm_runtime_enabled(zdev->dev))
+	if (pm_runtime_active(zdev->dev))
 		zynqmp_dma_runtime_suspend(zdev->dev);
+	pm_runtime_disable(zdev->dev);
 }
 
 static const struct of_device_id zynqmp_dma_of_match[] = {
@@ -1193,6 +1193,7 @@ static struct platform_driver zynqmp_dma_driver = {
 	},
 	.probe = zynqmp_dma_probe,
 	.remove = zynqmp_dma_remove,
+	.shutdown = zynqmp_dma_remove,
 };
 
 module_platform_driver(zynqmp_dma_driver);
-- 
2.43.0


