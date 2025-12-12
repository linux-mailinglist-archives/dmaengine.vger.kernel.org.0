Return-Path: <dmaengine+bounces-7586-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC1CB8C8A
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 13:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9242D30115AC
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 12:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819B30FC15;
	Fri, 12 Dec 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TSDZ8s4G"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AF30DEC8;
	Fri, 12 Dec 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542073; cv=fail; b=SG4SHf6qWYxWXsQEffI2TD7+Faf6wkykmNsPFjQ4Qt2xAs1b4ZhgSxPbZIlwtV8F/MXdDqKIaV0LtFIhjDrBr3KI4xuPbpdcPWYCaxovDJS/kcnM7uuBZ9EPQpEqxFaujgbu53Qzz+aQvtOdREpnR2txi8xT82eVPPEMxbRvz6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542073; c=relaxed/simple;
	bh=2b5wyVADbQ5ccvBGaEz5RlIZZ2CWdHew/aR9vQlEkBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igVF3RLVC71NPIG1GqPN8pVij/RUNGF/Ern8hwND/Gq6wBKj0EcqROPQInQbYGXLmyfhAnyMyerRSZzH3CpCI378rYiNpKNepZOord2zLwTiPgk17lC8PpstS47m/ymcAaIfXAf2aPNQnn1jwvb1J1kPXmaflvndjDkM5aDJtE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TSDZ8s4G; arc=fail smtp.client-ip=40.107.200.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SThSOHtrBR91boJch8TMtKR7fmlQ8BRj5DnqNIEnuYABYBIneBTM096SZ5Vp1rUv/T1wQqcl0jDlR4QUfzr5Zhc+zdU7iVQELzHMfX5KGB1/z3IeF2E4zaZUQU+v7oCy9s54SXqwNW5AdEwhjGspM/6YoNc/sPBwjGOzmECwoK//Lh5odPoRhOmstKB72zV5x9tUXORUN16d3QeqBh/zmjVKzSR9FSE8eejZqeAYuzChroqJVcOmD/XCW+YK+zrW9FzDurURW7v7/aFZtU6mMXrNLm/aannvq/o2WVqJv+7A/XiGNeSb9ayfpDjki1SKe6Uymo13k8QVqLAdwtoVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjT6jaGZWGWjntE6qNGxpQVHjuwjpRdAQU1iLMmtkCA=;
 b=FhqBE503oGX50FjlPSLAoclLHRqpQHC82WL3dvW7XRU1CSEYOLXfMtFOrlIEOVivXClAdqyzbli+tr8JY8hVr9AcZDFz31sfcaNiOjMiqIKlhpoyjSHdvOit1DnNqL2mA8thNEcrZijMApeALTqKOI0/XGV7Bc1vkX+gkTgDUIxprNAyVYKRyc620waHpfEJeKj8k2WHJnvs2TBGiJdLyhddMNBS8Go9MhXspSFmZOX6t3HK1DXM+mKOvLbcMx8TqV7ekpno5fhEaJZkqeIdN1vrn3QxGLXJRB/f4Weh2dFSOKEUHCUv18W19fa0Ae1so81mXuR9IkrvYSHPSTLKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjT6jaGZWGWjntE6qNGxpQVHjuwjpRdAQU1iLMmtkCA=;
 b=TSDZ8s4GEopL/qUeHgQYFTQqXDwxIxLDrtcNvzl1p0nW7UptXxlz4cScHSz2zfA2tKMs2jVgiBZsGNvWHZGMqpBna7YIz0Sq9+UaK5qXfq2Gb1+SR2MUrAmIDuGDKQz2taUBCuaEOQBHXmW2jsNzZAd4N9C637seiMVWWxmqfX4=
Received: from SA0PR11CA0129.namprd11.prod.outlook.com (2603:10b6:806:131::14)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Fri, 12 Dec
 2025 12:21:06 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::d1) by SA0PR11CA0129.outlook.office365.com
 (2603:10b6:806:131::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Fri,
 12 Dec 2025 12:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 12:21:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Dec
 2025 06:21:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Dec
 2025 04:21:05 -0800
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Dec 2025 04:21:03 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Fri, 12 Dec 2025 17:50:56 +0530
Message-ID: <20251212122056.8153-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212122056.8153-1-devendra.verma@amd.com>
References: <20251212122056.8153-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 54728906-0ab2-47cd-305d-08de3978ec98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MQCDivITXnKe5rvI0nMhETRAXYwxjqrG3Rwfqz2btGcrXAWuyMtzO6OyvkKV?=
 =?us-ascii?Q?yGWInpK8QSXep6K8455gA9ZTx0/ClHiSfXPKflZLOB+CLOaObhKi+mXMAHsf?=
 =?us-ascii?Q?hXTp8IutxrC/+JRa9ZjfJBFNyUhLOJGijQQokXeOii2A3xh85uIn0XJnWBoA?=
 =?us-ascii?Q?WAN054TmtM+pZxbYXPuFG+hWXLqIkDazpOTNxqgzrRDr8urro4+qlVUK8TOz?=
 =?us-ascii?Q?hIr7Eldn9W7xvk8frNjnm54Zd/JaX67oELe5LKkmwKDj4/ahScH0+Kkwr5Hs?=
 =?us-ascii?Q?UvdEMCejKyAP8tQurA9p6NtBw3CI5bvSSHcy/tDFAfSkQE0zoWPBJOzVfyUP?=
 =?us-ascii?Q?o/aljPwMUJJ3Rk75GKW/AJL4VnewTiR5nWJl5TPyCmURrSut8hvhbHP+IU06?=
 =?us-ascii?Q?2w5/fhkwK7KIT2EgZyikMW8IYpqU9N3agnE6DqSrLIk/MaVYdHPjUS8UMlNt?=
 =?us-ascii?Q?Uww2sbhtLmmPV9s9VfZhXTg/GxxuBEghxugstJ2utxL+Eh2Nf1/uWMaS3xF0?=
 =?us-ascii?Q?ojld9XBqPr6ePmZngP7Z23wRa867Sc0ixelOMDjcI79PMCq6/ZfOXczsWLlA?=
 =?us-ascii?Q?+6XhBxbRCxuRRMVCIFeHl/xWGbFSlkYm4TTMNsQ6eBQPXzndG3wMlsmcqfQu?=
 =?us-ascii?Q?4JADN2GDJqi3WiOthVdNoTlt3XsZps0T3xjFcIHoFYlDsAcsNVobHk88kR6f?=
 =?us-ascii?Q?gT8TQoEx6beooQ2jMFM6vac/ejD3EWQPOnuv3Hjv06OR0917iYkGivh7n3B6?=
 =?us-ascii?Q?6/ETKXffFLtvl19Isy+fQv6XWetK5hdsw2OnG/3v/YTHXxWbXQLm6CWfrYqe?=
 =?us-ascii?Q?ZfT/IkWpPQbHftRe02t0T0rZYDoSIIUSx2c3PTloP/SdFWbzTmoHb5iHuYbU?=
 =?us-ascii?Q?6CGtI8ZEFk6EWtWdZlnPHX8+Jv62Z4t65LwhI1EPznJ0BPoSTzl0aWdwl+s3?=
 =?us-ascii?Q?uKFZ2cpybNCqX4W+n8r0fklPYmNtiolD0uWmVXS6VMIQFNV/aWyW7cNClWCX?=
 =?us-ascii?Q?83WOHwioO83XpPk1s5VJfLhJRc12bmaYoStLGrpzuUbtDAPK9A9PN+tVZvV1?=
 =?us-ascii?Q?WqROITwXtZNdLWgCQRLRf7M82Rau2NcVmz3eA/EV4Mlg3IlRGUHSi7+083f2?=
 =?us-ascii?Q?UwLalujfwFzDm1cHnitupRtLeBRSiJU8iHZEezEaf96sY8UQVQpTX2djrJXM?=
 =?us-ascii?Q?pLe7/ufZtcuBwRgTmgwBIEsw0mDKz02me8xrVw13QiCKXuAU6OoZV4aSLEou?=
 =?us-ascii?Q?XKWHTxTMeIqpvTxbuAfVGrNS9trM9t3oX7DgSSQCebZ/Z5cwyK5jtjUwcxuL?=
 =?us-ascii?Q?8wS87jWnbBmfBs0l416s+U3Gh8SxIQ7vHPNMniJQ4qv2sSHftoTEkqIxqT3i?=
 =?us-ascii?Q?L41q4/0gz8jZcGOYsN6MI0KjIEZJeiSxKOxRsI/KayzqxKE0A1XzyCexcwAF?=
 =?us-ascii?Q?3r9IjyAF5aoT/WIAGcJ9v6HODMC3V5a+YBNos15kfsxmynIo6D0jGTKEKRPW?=
 =?us-ascii?Q?s2kDs/sS9xWLCMEIdho2Ay/Da65OzuZveh1ySqU/sHPpwQrsLiESk3vHACOg?=
 =?us-ascii?Q?dyB47Yba7ZEmxcDW6GE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 12:21:06.0804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54728906-0ab2-47cd-305d-08de3978ec98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
The current code does not have the mechanisms to enable the
DMA transactions using the non-LL mode. The following two cases
are added with this patch:
- For the AMD (Xilinx) only, when a valid physical base address of
  the device side DDR is not configured, then the IP can still be
  used in non-LL mode. For all the channels DMA transactions will
  be using the non-LL mode only. This, the default non-LL mode,
  is not applicable for Synopsys IP with the current code addition.

- If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
  and if user wants to use non-LL mode then user can do so via
  configuring the peripheral_config param of dma_slave_config.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v7
  No change

Changes in v6
  Gave definition to bits used for channel configuration.
  Removed the comment related to doorbell.

Changes in v5
  Variable name 'nollp' changed to 'non_ll'.
  In the dw_edma_device_config() WARN_ON replaced with dev_err().
  Comments follow the 80-column guideline.

Changes in v4
  No change

Changes in v3
  No change

Changes in v2
  Reverted the function return type to u64 for
  dw_edma_get_phys_addr().

Changes in v1
  Changed the function return type for dw_edma_get_phys_addr().
  Corrected the typo raised in review.
---
 drivers/dma/dw-edma/dw-edma-core.c    | 41 ++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 61 ++++++++++++++++++++++++++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 include/linux/dma/edma.h              |  1 +
 6 files changed, 130 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f..60a3279 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -223,8 +223,31 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	int non_ll = 0;
+
+	if (config->peripheral_config &&
+	    config->peripheral_size != sizeof(int)) {
+		dev_err(dchan->device->dev,
+			"config param peripheral size mismatch\n");
+		return -EINVAL;
+	}
 
 	memcpy(&chan->config, config, sizeof(*config));
+
+	/*
+	 * When there is no valid LLP base address available then the default
+	 * DMA ops will use the non-LL mode.
+	 * Cases where LL mode is enabled and client wants to use the non-LL
+	 * mode then also client can do so via providing the peripheral_config
+	 * param.
+	 */
+	if (config->peripheral_config)
+		non_ll = *(int *)config->peripheral_config;
+
+	chan->non_ll = false;
+	if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
+		chan->non_ll = true;
+
 	chan->configured = true;
 
 	return 0;
@@ -353,7 +376,7 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
@@ -419,9 +442,11 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
+	if (!chan->non_ll) {
+		chunk = dw_edma_alloc_chunk(desc);
+		if (unlikely(!chunk))
+			goto err_alloc;
+	}
 
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
@@ -450,7 +475,13 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == chan->ll_max) {
+		/*
+		 * For non-LL mode, only a single burst can be handled
+		 * in a single chunk unlike LL mode where multiple bursts
+		 * can be configured in a single chunk.
+		 */
+		if ((chunk && chunk->bursts_alloc == chan->ll_max) ||
+		    chan->non_ll) {
 			chunk = dw_edma_alloc_chunk(desc);
 			if (unlikely(!chunk))
 				goto err_alloc;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9..c8e3d19 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -86,6 +86,7 @@ struct dw_edma_chan {
 	u8				configured;
 
 	struct dma_slave_config		config;
+	bool				non_ll;
 };
 
 struct dw_edma_irq {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 9c1314b..6c550a5 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -296,6 +296,15 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
+				 struct dw_edma_pcie_data *pdata,
+				 enum pci_barno bar)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
+		return pdata->devmem_phys_off;
+	return pci_bus_address(pdev, bar);
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -305,6 +314,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
+	bool non_ll = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -330,21 +340,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
 		/*
 		 * There is no valid address found for the LL memory
-		 * space on the device side.
+		 * space on the device side. In the absence of LL base
+		 * address use the non-LL mode or simple mode supported by
+		 * the HDMA IP.
 		 */
 		if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
-			return -ENOMEM;
+			non_ll = true;
 
 		/*
 		 * Configure the channel LL and data blocks if number of
 		 * channels enabled in VSEC capability are more than the
 		 * channels configured in amd_mdb_data.
 		 */
-		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-					       DW_PCIE_XILINX_LL_OFF_GAP,
-					       DW_PCIE_XILINX_LL_SIZE,
-					       DW_PCIE_XILINX_DT_OFF_GAP,
-					       DW_PCIE_XILINX_DT_SIZE);
+		if (!non_ll)
+			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+						       DW_PCIE_XILINX_LL_OFF_GAP,
+						       DW_PCIE_XILINX_LL_SIZE,
+						       DW_PCIE_XILINX_DT_OFF_GAP,
+						       DW_PCIE_XILINX_DT_SIZE);
 	}
 
 	/* Mapping PCI BAR regions */
@@ -392,6 +405,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->non_ll = non_ll;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -400,7 +414,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -411,7 +425,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -420,12 +435,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
@@ -436,7 +452,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -445,7 +462,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4..ee31c9a 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 		readl(chunk->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
@@ -263,6 +263,65 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->dw;
+	struct dw_edma_burst *child;
+	u32 val;
+
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
+
+		/* Source address */
+		SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
+			  lower_32_bits(child->sar));
+		SET_CH_32(dw, chan->dir, chan->id, sar.msb,
+			  upper_32_bits(child->sar));
+
+		/* Destination address */
+		SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
+			  lower_32_bits(child->dar));
+		SET_CH_32(dw, chan->dir, chan->id, dar.msb,
+			  upper_32_bits(child->dar));
+
+		/* Transfer size */
+		SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
+
+		/* Interrupt setup */
+		val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
+				HDMA_V0_STOP_INT_MASK |
+				HDMA_V0_ABORT_INT_MASK |
+				HDMA_V0_LOCAL_STOP_INT_EN |
+				HDMA_V0_LOCAL_ABORT_INT_EN;
+
+		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
+			val |= HDMA_V0_REMOTE_STOP_INT_EN |
+			       HDMA_V0_REMOTE_ABORT_INT_EN;
+		}
+
+		SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
+
+		/* Channel control setup */
+		val = GET_CH_32(dw, chan->dir, chan->id, control1);
+		val &= ~HDMA_V0_LINKLIST_EN;
+		SET_CH_32(dw, chan->dir, chan->id, control1, val);
+
+		SET_CH_32(dw, chan->dir, chan->id, doorbell,
+			  HDMA_V0_DOORBELL_START);
+	}
+}
+
+static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+
+	if (!chan->non_ll)
+		dw_hdma_v0_core_ll_start(chunk, first);
+	else
+		dw_hdma_v0_core_non_ll_start(chunk);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index eab5fd7..7759ba9 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 
 #define HDMA_V0_MAX_NR_CH			8
+#define HDMA_V0_CH_EN				BIT(0)
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747..78ce31b 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -99,6 +99,7 @@ struct dw_edma_chip {
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
+	bool			non_ll;
 };
 
 /* Export to the platform drivers */
-- 
1.8.3.1


