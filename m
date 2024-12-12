Return-Path: <dmaengine+bounces-3962-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD869EE6F9
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 13:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6206C188697B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215C32135B7;
	Thu, 12 Dec 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MO4rPOmF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348B2135AC;
	Thu, 12 Dec 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007474; cv=fail; b=RhQFZgF8Z3hUpqpQECS8cjBrBXQoN0391bYK73pvgafDwklE/d5oDLBSrmlx1jhvFmzb4UR3XfdvaNGP+G9c1loLtY1hi9Z+6+Ov7rq5w+olNCl4QOpiSGkX/AIAVc1jLF/CJe9M9VQpwT5goJuygQu8p5LW0UH+a9PfCZWEoCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007474; c=relaxed/simple;
	bh=050jm9qI6BzLjVUSEqD/bLFmR8a3rvrzM609B/ToyGI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mvv31TpeENxzPVr8vsSLWNrfsaEEb3kxs5bxOtjqGHhjxpVLNIuq1vkJM8Vs3IaU8AQL09b4byWbZtMWK3SxCratrPvKGkoZfD3FRAsdsR5u2EjwYPYbuB5TdO8g953op2MhQrtAVAU8u23/zq4y62svO2QApRmt3LuAj6RGzP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MO4rPOmF; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLqYf/FfY0CUEyQpwiTFSj0UA9SYEmv428D55uHjC9+ny7xL6r/wXU6/LzKhpFoSYplrk9FCfZ97b8Q8c8eEoy/NHEcdjBTY2/kzTiXyyDbNA2e5+0P+X88J/iFoYZ/hDbobw2LEv24rpHH0QLWOCpcZ7xec169sBvmSGDQGW5cWdo3xAwbnmTjQ7AHMJrzbhbWx7FsO68Sc8ghrBB6GVP+eIHMr/n0bArhrKmuiHYN9vEBOEdp5PRufveKLyp/c0uUEU62GLK69uDMvwrsNjQjRrYrKmQrF7wouSyjJpEY08nshAD/LuDf7Drs7+aUFiI9M5Mpp7RPK5Ny8sH59bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feOki6WXa8Dc2urtOMhGEJGkbjKgK/FQe20bWjCg1Yc=;
 b=jYKBVPi0VtO43LURbbE6el1b62ZqbZ/g89JTtXeqwZSc1vecA40Mr6NE+Z5HzzHVjWb8Jg4ksvWQ26aHt68P2ZF1R+mno4Mfe76TvtVeXgX1NMdWw8KtjCwNgtM7Zd6Dg4QKHeKbMtZj420p/PVhxEogBh6TbB2nkXDSI+zcqI2yBliW5WGbXBYANkxWD4mIG1dv4aI4vKG1EpflOZvkacMdPw8G+t9yFFVBUZWO/U8HeyenzPMWnnLgQbrGcWPi4TsV47gfBozoZ/7AkM0leeuvtpV/1IJBFENbfaCMOLjh0Cx/8Qbz3GIdd1OcQp4uOU+76ukUyLqp+FtZx21ZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feOki6WXa8Dc2urtOMhGEJGkbjKgK/FQe20bWjCg1Yc=;
 b=MO4rPOmFVXn7nAiUG55qLe00k9I5urWWeesxD5SGKB1MST/gLPugrwumdP4ijpBDnz0YRm8tQsu35RxqwD9gL4tE4r2XefgLXh4WZCeW66yLVvHWEKrn6tscV8fZVSU1PkVru0R9457kXw+0JCIM2jOcov53CLj3JygE7vZ+YaYoA8bHY4kszDxV3zPVZ3la7g3atk/5vKoHj9vK9Bl6d+jd+xyZXhtuQN/iz2JmUlH35sGasnkNKSLrB3o45bbAOEMRJ5YCCjB1fqUWufJoh4zXkA8qrpp4K6pkQMFf2OsJ2sBE+tyM/uuLlIfcTnN7rKtbBvhY4qcOu11Mo1h63g==
Received: from SA9PR10CA0002.namprd10.prod.outlook.com (2603:10b6:806:a7::7)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 12:44:26 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::b) by SA9PR10CA0002.outlook.office365.com
 (2603:10b6:806:a7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 12:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 12:44:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 04:44:18 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 04:44:17 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 04:44:14 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
	<thierry.reding@gmail.com>, <rgumasta@nvidia.com>, <akhilrajeev@nvidia.com>,
	<dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: tegra: Return correct DMA status when paused
Date: Thu, 12 Dec 2024 18:14:12 +0530
Message-ID: <20241212124412.5650-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0fb5b5-1379-4aad-5471-08dd1aaab67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JxTA86gh7SU0PYFfJLXagK89zcob7vWUvJkCR3TzdHDHZrVNyHjR1N6fsqPV?=
 =?us-ascii?Q?q/IIuZ3NWWbnAnqZ6VRqnblNWnxWIJaNaq2VPTfTp1h2Qpzdc6zTgXSJNt78?=
 =?us-ascii?Q?VJmiwZC02+h9gv0Dqqdwk84hIyZ3NpYru67rq+0VF2D8T5GQugMkjRTKUAB1?=
 =?us-ascii?Q?3FGbFe/5Ufac6pufK/6YV2WBt5zihZd3FYJGh1plRWme/Kl+bj0s3QdXMezh?=
 =?us-ascii?Q?nvVF/53Qcwxys0qamkC7R9I8JiQ5wcEg+ZwVDo2c1tGprNDczF04jrwWpV/P?=
 =?us-ascii?Q?zqsrB9g8l+NwVuTt0e4OIRCGqxDeqnM+jS/dSyhozNX+wQ36szeffaKGXOro?=
 =?us-ascii?Q?gNwI/qyCGRbws6H+Gl0I4v/bcVX3fOo07h3enJYYnx9OmeITCX2Ejxqf4usR?=
 =?us-ascii?Q?Gv2sdsjchuq4Loy/OxGbsGIaXBvXPoVNGj8yghEx27dPMjbensXi0TII2bdR?=
 =?us-ascii?Q?ygluxp/1Cu9wKr3KV8Ht44LX3eNhBDRFkK/rtu1iGwLa7fEDS3cGDvsQEhGd?=
 =?us-ascii?Q?ZEvWHQX4CvKEmK3UAMXb3/7IONiVfnrASFo/mHMK3L9WhSpDAxVEJhewKuWC?=
 =?us-ascii?Q?YnCX2/fHDYCdfkg/xXSBxB+BzeOz3HXzQn4BAfj8gYmSYK8wZ95QJwhVrC/m?=
 =?us-ascii?Q?DEvm3v8uGWNz8q0KrNpSk1U0l/8cbss0snPSPG1NmeNenOVhdiIRU5QiUMp+?=
 =?us-ascii?Q?4gv2xI8M9RW5rMZBuVdmpryFIQk/lmP0cocZ2t2ku/rduIg6FdA5Ov2VihLQ?=
 =?us-ascii?Q?4okmy8QO8qastdBVnXNvUnBnyMMYX7RuI9IC0oQzl39T7sEaa4Ytp0yfKRpg?=
 =?us-ascii?Q?PcKhzq2xyTbhuzhEUUmCLKxO4EFTt0Dqec2w0l2FoLG8e9qFI35U47t5jTdV?=
 =?us-ascii?Q?UnZgtWv7U3LNEuiGhggD5Uv0SguS1w4wX7Qyb+lxKNIjWhdEC+1HZrDlBMaF?=
 =?us-ascii?Q?Vd1Jn3su4G0EgruRXXBUbcwqCPntb3OKj61XO2YVSUM+V6msSXayyPRoVurt?=
 =?us-ascii?Q?B2eUyXaasSHM9f+qPlR5gmxHa8mJzmYbHQgdoQVsJ8GjceYIM7vUhdVovg6i?=
 =?us-ascii?Q?ziaAXvMzFNWxGncsDpQfd0Anxiz7C8LvjBXwa2kfW5Sb975LpF9q5i+K5SJz?=
 =?us-ascii?Q?5t3xDUnaCENy/U1WPQmyiOd1NqJAzOG/qTZODu3fb0EoRWYSD5O+LOKriESl?=
 =?us-ascii?Q?K4eGTlEMtePT9KOTVjLnbgqiSmmw5210rZN2YRZN155gqMkspKQdQW0Wzz08?=
 =?us-ascii?Q?mXWQmkRMrYCob8op7RznAu/hPtqOjF466dkuf3pAnGf7BTJOi2MwygEJdnW/?=
 =?us-ascii?Q?J2t5amjuNT6kICw3AITxL2ufp2dPER5OrgHpxQm2VTYZSzIohdxep/WAVfGT?=
 =?us-ascii?Q?jkd3W9ip1GzHEnoe5Ps1reXVWM97SckseK8lT7MDbKP8w8uL2qYV9e3IW2Jz?=
 =?us-ascii?Q?G5LSokPIxlz1fmKpis/9r6g0dsOir16L?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 12:44:26.3567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0fb5b5-1379-4aad-5471-08dd1aaab67e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412

From: Akhil R <akhilrajeev@nvidia.com>

Currently, the driver does not return the correct DMA status when a DMA
pause is issued by the client drivers. This causes GPCDMA users to
assume that DMA is still running, while in reality, the DMA is paused.

Return DMA_PAUSED for tx_status() if the channel is paused in the middle
of a transfer.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Cc: stable@vger.kernel.org
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index cacf3757adc2..4d6fe0efa76e 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -231,6 +231,7 @@ struct tegra_dma_channel {
 	bool config_init;
 	char name[30];
 	enum dma_transfer_direction sid_dir;
+	enum dma_status status;
 	int id;
 	int irq;
 	int slave_id;
@@ -393,6 +394,8 @@ static int tegra_dma_pause(struct tegra_dma_channel *tdc)
 		tegra_dma_dump_chan_regs(tdc);
 	}
 
+	tdc->status = DMA_PAUSED;
+
 	return ret;
 }
 
@@ -419,6 +422,8 @@ static void tegra_dma_resume(struct tegra_dma_channel *tdc)
 	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
 	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
+
+	tdc->status = DMA_IN_PROGRESS;
 }
 
 static int tegra_dma_device_resume(struct dma_chan *dc)
@@ -544,6 +549,7 @@ static void tegra_dma_xfer_complete(struct tegra_dma_channel *tdc)
 
 	tegra_dma_sid_free(tdc);
 	tdc->dma_desc = NULL;
+	tdc->status = DMA_COMPLETE;
 }
 
 static void tegra_dma_chan_decode_error(struct tegra_dma_channel *tdc,
@@ -716,6 +722,7 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 		tdc->dma_desc = NULL;
 	}
 
+	tdc->status = DMA_COMPLETE;
 	tegra_dma_sid_free(tdc);
 	vchan_get_all_descriptors(&tdc->vc, &head);
 	spin_unlock_irqrestore(&tdc->vc.lock, flags);
@@ -769,6 +776,9 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	if (ret == DMA_COMPLETE)
 		return ret;
 
+	if (tdc->status == DMA_PAUSED)
+		ret = DMA_PAUSED;
+
 	spin_lock_irqsave(&tdc->vc.lock, flags);
 	vd = vchan_find_desc(&tdc->vc, cookie);
 	if (vd) {
-- 
2.47.0


