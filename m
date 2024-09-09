Return-Path: <dmaengine+bounces-3120-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA3F9719A9
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA281C22C36
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247DB1B5804;
	Mon,  9 Sep 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u4mVffVL"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381041B78E2
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885620; cv=fail; b=Z5TwuslWynPeoasNlSUMiwMpkpRB0fzbCYeo+bjeH2DjgzIkWm13B33RC3QYCRxneV0QQ43xVk0TjGPuP42wBSCoGrNPvcsnEa6s2vpcgf33mEOoKNT5zLZkHNDva1EXiO/kkqODxZId1qLH4lZThs9Mbb1ucZkokGedtDNTD9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885620; c=relaxed/simple;
	bh=mxbcNhdUe+gB9E9zRt2YWauo7ZGihiPKto8A0ANuRIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obWU6wu8XNuAG5mCHto/uYdqft4uPE8qZwgZI9LkzNfsZ7682vwKvgmZEyZQdzDj9T4fGKoPfDMhKF43yyf3CjiN+LONf7SdhucmvpUJcr1j9I/ucCN6tq5hFY+f7M1yTeABUTz1akSX1r2jpDQggxRSBMm4hJObaWS5SfTk/oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u4mVffVL; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAXje/oSGgqEYlpAhsqc3uZJq7dsj+u2VrAOytQW2iN6EToCjJCVGZ5dWvkPn0ei16nu2m6xPDQOOl6RlrxH4F0mUEcC4or82YSzSO/L6LjyeVRbYWCf1h/kb1TiteZuMR8kyZ0D8xBta2dR9PVTGeTs4T9CWGrXqjntLtQKcSDG1Fs3gAuX8vDBU9vfAGG54qtHjpmPoF0OF+BfHpLdutKWhhGNGGsdgPx4VPuj7f/3Pz5x7OFUHmwc4u05hxfNao0UfnU0kwXYBd2pbvRiy9eg/vMNgqN0WWggowHtkMESV7Foy2zZe+8oIJH6LLpPOwiYz3Q3K9U1CV4SaMyv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR9VzTIKnB5f2NO8ceqrYobCnQb4LeGUU/eSNwHx9lg=;
 b=mKo556tOV81jq6iRo5u6CuMQmuxEbPVrM5ig6qBndhwcMburOd94JUZjpLbY2WqX79qbGmJMw5ZA1/tgpilSK7o47VMlZpnmBlyI0OsQOKdZD/rBFpfZItn+j9Ji2YsUxQMBXQEiVsWBiwMtPV2/IDRvn3/+8ndycSpcVe78Kz4vVeIr/4quOaVR27hpFDR8UffghOaNyny4pyvH80wKDybtNJ+WOcHz9HvB2BQ5KfWef/kFP8mW4H/mkAb+stkmAaDWlH+cSABq9r+Mw+6/gSCzUEsa0ouuT72FVxLLJlbGDh/+uU4tNUFaTK0PDM6MO5v/IAK1RiEhG2Nb3u3s3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR9VzTIKnB5f2NO8ceqrYobCnQb4LeGUU/eSNwHx9lg=;
 b=u4mVffVLzqT6XWJTZt1gqAjUAs+XNN/IBx6H90EUeKfVLwoxL4A72PoSEQy6wg4OcjBHGjyeywyx6oPnw7KKhg41KegYUVQsB6YapP0uoJdAQJgSxzL/+oNeBOW9Jh6odHaihmbW767Ry0UoQo2LXYmUJRx0/y61+jGVKGtOODU=
Received: from MW4PR04CA0342.namprd04.prod.outlook.com (2603:10b6:303:8a::17)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 12:40:13 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::ab) by MW4PR04CA0342.outlook.office365.com
 (2603:10b6:303:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 12:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 12:40:12 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 07:40:09 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v6 4/6] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
Date: Mon, 9 Sep 2024 18:09:39 +0530
Message-ID: <20240909123941.794563-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
References: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: aab9aa42-9786-4862-d779-08dcd0cc8ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DMB23HGiw2WQ3OBqJvLZScVjluVdnXKKy80P7Gc9o9BX03uPN3CMggGi4x7i?=
 =?us-ascii?Q?wZ7uAQj3bfq59dGdO2ehs3chHeGSaM5sTuqfIzhcCc1lw0s19PhQwsyvAvvz?=
 =?us-ascii?Q?rLm/s+T/XY32OGbrDrsVsPCo0GW1V7rCeGNnY2wlEGRxIo5nW+VAOrthWRcl?=
 =?us-ascii?Q?oafmc3fyOJCLEG75jvF2cHSO7WXyseb9PMc2cpMwyUx6A3tzIwYhQ4ouEh5i?=
 =?us-ascii?Q?v2EPKzlsXe7nnIidY9G1NqQRXb8EbSOOEri+8eRm8wCskuLS0FmEtrT+JNIq?=
 =?us-ascii?Q?PQj6ncq3eTBcHSncNtTKjn+qiN90/fpQNZV/xakTJtbmhAWw8YUcFJDXucis?=
 =?us-ascii?Q?YoexB8yZ0iJQiIMc8X4rr5Xp1uWK0aCq3y9EiiHLKLMG3Oylif7mm0D0nUlh?=
 =?us-ascii?Q?phX1DgPm4Qr699ZtBLX4d58JS6RZ8WSgcC5WfmZwh/g64dFrkk3NJzfJ/bgH?=
 =?us-ascii?Q?ScUUOR/EhB92hbgHkZJeqUYBGL3KX/02CiGGvcQwVuFH5vtfr4/1irK6hMx5?=
 =?us-ascii?Q?RrJGCIyLiohfuSdPiNhx4WSbZRk8gbL7w185El1JoH9UMfcshbBxK5MDMvjw?=
 =?us-ascii?Q?9P7aENXBSEWToUzj/EstVQpsTNuUHfLOhwQ/T4tzUvEyHYuNsHqZ54hPeAy2?=
 =?us-ascii?Q?vvjWRrv0iipqOQURWobZQBMMq5fIMi4jPBtNGDjXW6ig6c9r4rBTzczug58+?=
 =?us-ascii?Q?IqGSySm1G7zDvCZhNN9lnkhQvMfFvNelQg2G3rfVxjh15g61WVoN87wLSyop?=
 =?us-ascii?Q?pI51aKoX62ZrnsjdK+uDsLgECnFIeAZanCFvHYXOgOoye53tT6KCMBm66vGq?=
 =?us-ascii?Q?vOqNKogdmTRzc8kg5Sfrqi5rFFiunDEFMkdD8jMNf2jeNtl2Wvr4Ji6Z/DR6?=
 =?us-ascii?Q?as37j2ypw2lDQFwzexlnyqO/ERPg4Vi8r6/NNI7c5YmQrd3huN+eSAo9O5Im?=
 =?us-ascii?Q?Em/AHjlNoT2rWn224trsTGur2SB/GlZrmHUM093dU13eG+E+pBYmRcLR1Ffk?=
 =?us-ascii?Q?EPE3GZXemmeAu1pOIRfspfHxzV6D8/pJq7AnTmzfMxelnNPnjlwtzKXGntBu?=
 =?us-ascii?Q?RoRkJSkbuEVsNQEmSKw3HbAayFstXYOzyAQhjlrQohQSBCgfozoR8jiBY1Uc?=
 =?us-ascii?Q?McOSIftb/8gxFNGbT2to2cfzIjrok+srUgNLNPGXrTmqCsk7kWclTlkkP+rV?=
 =?us-ascii?Q?DiH3EFhVM9XJgJiDiROFROWSuf4Ig22quPM0Nj55DTHWE47IhlcYaCJ0cyPK?=
 =?us-ascii?Q?09YHXu/X/vFwvgbdTsjD/9FzEik7aBD+L4C7eXRC3u+HZYlA8ln0xrJidAVm?=
 =?us-ascii?Q?7X8070xB5WALvmC6Wn8u8Gckq9Ki0M+mLocvwPGyiUEflyPqRcxOsbxJn5bt?=
 =?us-ascii?Q?3HK9moePRPx5K5rTqie88DoDcEAw5MiSQWmAsSwCxvmNbH+rCW5KTLIbNiyH?=
 =?us-ascii?Q?pYckogtn7II=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:40:12.9774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab9aa42-9786-4862-d779-08dcd0cc8ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558

Use the pt_dmaengine_register function to register a AE4DMA DMA engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c     |  51 +----------
 drivers/dma/amd/ae4dma/ae4dma-pci.c     |   1 +
 drivers/dma/amd/ae4dma/ae4dma.h         |   3 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 114 +++++++++++++++++++++++-
 drivers/dma/amd/ptdma/ptdma.h           |   3 +
 5 files changed, 123 insertions(+), 49 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index f0b3a3763adc..cd84b502265e 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -14,53 +14,6 @@ static unsigned int max_hw_q = 1;
 module_param(max_hw_q, uint, 0444);
 MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
 
-static char *ae4_error_codes[] = {
-	"",
-	"ERR 01: INVALID HEADER DW0",
-	"ERR 02: INVALID STATUS",
-	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
-	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
-	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
-	"ERR 06: INVALID ALIGNMENT",
-	"ERR 07: INVALID DESCRIPTOR",
-};
-
-static void ae4_log_error(struct pt_device *d, int e)
-{
-	/* ERR 01 - 07 represents Invalid AE4 errors */
-	if (e <= 7)
-		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
-	/* ERR 08 - 15 represents Invalid Descriptor errors */
-	else if (e > 7 && e <= 15)
-		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
-	/* ERR 16 - 31 represents Firmware errors */
-	else if (e > 15 && e <= 31)
-		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
-	/* ERR 32 - 63 represents Fatal errors */
-	else if (e > 31 && e <= 63)
-		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
-	/* ERR 64 - 255 represents PTE errors */
-	else if (e > 63 && e <= 255)
-		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
-	else
-		dev_info(d->dev, "Unknown AE4DMA error");
-}
-
-static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
-{
-	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
-	struct ae4dma_desc desc;
-	u8 status;
-
-	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
-	status = desc.dw1.status;
-	if (status && status != AE4_DESC_COMPLETED) {
-		cmd_q->cmd_error = desc.dw1.err_code;
-		if (cmd_q->cmd_error)
-			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
-	}
-}
-
 static void ae4_pending_work(struct work_struct *work)
 {
 	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
@@ -194,5 +147,9 @@ int ae4_core_init(struct ae4_device *ae4)
 		init_completion(&ae4cmd_q->cmp);
 	}
 
+	ret = pt_dmaengine_register(pt);
+	if (ret)
+		ae4_destroy_work(ae4);
+
 	return ret;
 }
diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
index 43d36e9d1efb..aad0dc4294a3 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -98,6 +98,7 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pt = &ae4->pt;
 	pt->dev = dev;
+	pt->ver = AE4_DMA_VERSION;
 
 	pt->io_regs = pcim_iomap_table(pdev)[0];
 	if (!pt->io_regs) {
diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 666bc76735cf..265c5d436008 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -35,6 +35,7 @@
 #define AE4_Q_SZ			0x20
 
 #define AE4_DMA_VERSION			4
+#define CMD_AE4_DESC_DW0_VAL		2
 
 struct ae4_msix {
 	int msix_count;
@@ -55,6 +56,7 @@ struct ae4_cmd_queue {
 	atomic64_t done_cnt;
 	u64 q_cmd_count;
 	u32 dridx;
+	u32 tail_wi;
 	u32 id;
 };
 
@@ -94,4 +96,5 @@ struct ae4_device {
 
 int ae4_core_init(struct ae4_device *ae4);
 void ae4_destroy_work(struct ae4_device *ae4);
+void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx);
 #endif
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 3f1dc858a914..cfc60cf571c2 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -13,6 +13,17 @@
 #include "../ae4dma/ae4dma.h"
 #include "../../dmaengine.h"
 
+static char *ae4_error_codes[] = {
+	"",
+	"ERR 01: INVALID HEADER DW0",
+	"ERR 02: INVALID STATUS",
+	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
+	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
+	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
+	"ERR 06: INVALID ALIGNMENT",
+	"ERR 07: INVALID DESCRIPTOR",
+};
+
 static inline struct pt_dma_chan *to_pt_chan(struct dma_chan *dma_chan)
 {
 	return container_of(dma_chan, struct pt_dma_chan, vc.chan);
@@ -62,6 +73,52 @@ static struct pt_cmd_queue *pt_get_cmd_queue(struct pt_device *pt, struct pt_dma
 	return cmd_q;
 }
 
+static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *ae4cmd_q)
+{
+	bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
+	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
+
+	if (soc) {
+		desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc->dwouv.dw0);
+		desc->dwouv.dw0 &= ~DWORD0_SOC;
+	}
+
+	mutex_lock(&ae4cmd_q->cmd_lock);
+	memcpy(&cmd_q->qbase[ae4cmd_q->tail_wi], desc, sizeof(struct ae4dma_desc));
+	ae4cmd_q->q_cmd_count++;
+	ae4cmd_q->tail_wi = (ae4cmd_q->tail_wi + 1) % CMD_Q_LEN;
+	writel(ae4cmd_q->tail_wi, cmd_q->reg_control + AE4_WR_IDX_OFF);
+	mutex_unlock(&ae4cmd_q->cmd_lock);
+
+	wake_up(&ae4cmd_q->q_w);
+
+	return 0;
+}
+
+int pt_core_perform_passthru_ae4(struct pt_cmd_queue *cmd_q, struct pt_passthru_engine *pt_engine)
+{
+	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
+	struct ae4dma_desc desc;
+
+	cmd_q->cmd_error = 0;
+	cmd_q->total_pt_ops++;
+	memset(&desc, 0, sizeof(desc));
+	desc.dwouv.dws.byte0 = CMD_AE4_DESC_DW0_VAL;
+
+	desc.dw1.status = 0;
+	desc.dw1.err_code = 0;
+	desc.dw1.desc_id = 0;
+
+	desc.length = pt_engine->src_len;
+
+	desc.src_lo = upper_32_bits(pt_engine->src_dma);
+	desc.src_hi = lower_32_bits(pt_engine->src_dma);
+	desc.dst_lo = upper_32_bits(pt_engine->dst_dma);
+	desc.dst_hi = lower_32_bits(pt_engine->dst_dma);
+
+	return ae4_core_execute_cmd(&desc, ae4cmd_q);
+}
+
 static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
 {
 	struct pt_passthru_engine *pt_engine;
@@ -81,7 +138,10 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
 	pt->tdata.cmd = pt_cmd;
 
 	/* Execute the command */
-	pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_cmd->ret = pt_core_perform_passthru_ae4(cmd_q, pt_engine);
+	else
+		pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
 
 	return 0;
 }
@@ -288,6 +348,52 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 		pt_cmd_callback(desc, 0);
 }
 
+static void ae4_log_error(struct pt_device *d, int e)
+{
+	/* ERR 01 - 07 represents Invalid AE4 errors */
+	if (e <= 7)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
+	/* ERR 08 - 15 represents Invalid Descriptor errors */
+	else if (e > 7 && e <= 15)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
+	/* ERR 16 - 31 represents Firmware errors */
+	else if (e > 15 && e <= 31)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
+	/* ERR 32 - 63 represents Fatal errors */
+	else if (e > 31 && e <= 63)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
+	/* ERR 64 - 255 represents PTE errors */
+	else if (e > 63 && e <= 255)
+		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
+	else
+		dev_info(d->dev, "Unknown AE4DMA error");
+}
+
+void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
+{
+	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
+	struct ae4dma_desc desc;
+	u8 status;
+
+	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
+	status = desc.dw1.status;
+	if (status && status != AE4_DESC_COMPLETED) {
+		cmd_q->cmd_error = desc.dw1.err_code;
+		if (cmd_q->cmd_error)
+			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
+	}
+}
+EXPORT_SYMBOL_GPL(ae4_check_status_error);
+
+void pt_check_status_trans_ae4(struct pt_device *pt, struct pt_cmd_queue *cmd_q)
+{
+	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
+	int i;
+
+	for (i = 0; i < CMD_Q_LEN; i++)
+		ae4_check_status_error(ae4cmd_q, i);
+}
+
 static enum dma_status
 pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate)
@@ -298,7 +404,10 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 
 	cmd_q = pt_get_cmd_queue(pt, chan);
 
-	pt_check_status_trans(pt, cmd_q);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_check_status_trans_ae4(pt, cmd_q);
+	else
+		pt_check_status_trans(pt, cmd_q);
 	return dma_cookie_status(c, cookie, txstate);
 }
 
@@ -464,6 +573,7 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pt_dmaengine_register);
 
 void pt_dmaengine_unregister(struct pt_device *pt)
 {
diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
index a6990021fe2b..9d311eef50c2 100644
--- a/drivers/dma/amd/ptdma/ptdma.h
+++ b/drivers/dma/amd/ptdma/ptdma.h
@@ -336,4 +336,7 @@ static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
 {
 	iowrite32(SUPPORTED_INTERRUPTS, pt->cmd_q.reg_control + 0x000C);
 }
+
+int pt_core_perform_passthru_ae4(struct pt_cmd_queue *cmd_q, struct pt_passthru_engine *pt_engine);
+void pt_check_status_trans_ae4(struct pt_device *pt, struct pt_cmd_queue *cmd_q);
 #endif
-- 
2.25.1


