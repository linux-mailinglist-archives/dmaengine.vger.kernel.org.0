Return-Path: <dmaengine+bounces-6605-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1FCB7F798
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 15:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9614A0432
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988332BC06;
	Wed, 17 Sep 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NyHFAqOt"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0432899F;
	Wed, 17 Sep 2025 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116187; cv=fail; b=mvs81seWDaDom3tbj+rERhM6VJMPWxSvkGGuRVARrNr4iTozFFcvwtYjExfWWXYuTEZgxm0VEyGWKn0ZQgQ9XCex4tai/R/rbndZb8BHSLyw2kvvPLHQgE80sgYv8T1qsHWoumK3pyvISwURH7V04+GJopPSEOcacecxicGRw0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116187; c=relaxed/simple;
	bh=P9oDTuCdD1o3iuOHfKtFUL0qnTV9orHwi27cZRar6Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1fxcziHts34TfDvztwrrDNDrLNGUs5D/31V1ly94rTGCjdTWceQmlJlVqOYO+bl/3MHVCMyup5t0HRoseX5X5sT732eQ92Zv27f7ms/CuM5ZLCzi8UqR/UxmdUAwky4fRUKP6ctts7db4cuvbywFquNR/uj5i4W970T03impEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NyHFAqOt; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR1o50wxdtDAUgwKwPFCiKcveA58KlSQvWbW0rCt5c/aFHuyIkeJLr+BS9KYPz0qLCY7rQiuFrevVnd+Q3pXG2azl7Pj44n3KSa1GKRrZKFCL6TrO2k3mjn8OYFPeOqwKPl0t8lmeVACQhXy8jXRiWcs8BaTerK49YtcgmL0P73EdkJ38pGdzAHDf50NUch11yK+p/dR4FujEWVrCThEDGOV9iftLN4086Zpfh/6oMHfYpPWmxBckSvhIPY3H0MBxVGi6+z2wDgU7a5llqCWJvM6esMErF/7Wn0aCsndmdUVKfgDjX79faf7M2geq0KITfj4yYo9Hgx3C5uLeumYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTLHzJ4iODut4l38k52LLQc0+Xw73JtLgp7yW1kSnHs=;
 b=Cn5msgfO1I2vwkY7S7b4t8SKYdexYP2lPChIcyuj7J3/pcOR1tqjOaFY7n3XP/1ILzc5d1KHguELiD5yEJsw9Nj8FwdWhf6Wh6VaH9eWlYgacXsRCjKD7d+n8dnHHi8aF9/vQLSCBdd+/AHSZo612mDWIIUz0aA4LXLGK/vGrUjMm4WHbjT6UA2uWK2IL0aQJB3ksqoNhmXsXVsMBOVifOomQ9ooKzqsDlFYgPCU+Zu/yz1RvkIe7AA0JjH355WqQEN/p3Bp9PI4/EIJFaauztlESJRzl6f9aniXHge3QYTeSU6QkAxwia5JJjOcyowUvOC5f1f17GBQkTW853HHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTLHzJ4iODut4l38k52LLQc0+Xw73JtLgp7yW1kSnHs=;
 b=NyHFAqOtn61ecBWzuxGm7+MGw/Ilaix6surZGrKBzGi5GWYH8w4FymbbB639nrDC86fM6iT5uG39dTJVKo97/8GQW8ISkmFlcD9OrvT65lcxM4bcEP508cH5Mz1/y+NHwQXlS7lhaJySN2IeZpeaoD5RdgSaYiEbW4mqihugqxU=
Received: from SJ0PR05CA0185.namprd05.prod.outlook.com (2603:10b6:a03:330::10)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 13:36:22 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::ca) by SJ0PR05CA0185.outlook.office365.com
 (2603:10b6:a03:330::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 13:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 13:36:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 17 Sep
 2025 06:36:21 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Sep
 2025 08:36:21 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Sep 2025 06:36:18 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] dmaengine: xilinx_dma: Optimize control register write and channel start logic in xilinx_dma_start_transfer
Date: Wed, 17 Sep 2025 19:06:09 +0530
Message-ID: <20250917133609.231316-4-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250917133609.231316-1-suraj.gupta2@amd.com>
References: <20250917133609.231316-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ffa83a-f35e-4f32-1981-08ddf5ef30ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AsK1FxRKVNYvlhXxXEymWy/E+rwawu/rzb4d2e/fIFM6i+e6fxSoi/NUBHEC?=
 =?us-ascii?Q?ZcuPbNvYGFz/tlvWzyWNau7J3OX3Y8/CMctByIeJXFOJQtQ+shWursgL/msK?=
 =?us-ascii?Q?S3pFYtuZLy47bRVGFOkeP2L9Zo6qsjJ2CA9AqrR9XnZH6CaTsaFtK6w0bdfT?=
 =?us-ascii?Q?og3rpSLAE3sC8inswaTabJT7OTSWs2YEiTnWWCVR+YOP7e0AksHRtoWQeAHg?=
 =?us-ascii?Q?f9a4p1MjDF8O8FsFF+LdPe4Jj9KlAse77Q5hK9zPulF2r2IDaX/GStmiM5wW?=
 =?us-ascii?Q?ZTVctA2dfoCUlW3dc5nXYpfiwmI0AyS7rwg5VLkHMk0bWx+PPQ25lgyGXteR?=
 =?us-ascii?Q?xfW+ukZ8+SeRGkohAMNImetL/jPs3gMsiurLUZJjvo3ONaOE3DUM5tDA62e3?=
 =?us-ascii?Q?2tISKuzKH4HQs2WHWYw53+z2Lx80OjZDDCQ8HYTHclKUeLi+pQVrktXFPlK/?=
 =?us-ascii?Q?H0mhoovIYW3hz7XF6NhU6h9sU42YY2DkC95rrNc5WNUy/BThr1pJVlbRx5Sw?=
 =?us-ascii?Q?ST9DsztUz6coV1BsRCaYj9XyMIcEONpZaR/CehaRj6gCxwLu80KhVS/ZrdVI?=
 =?us-ascii?Q?yvnpOQbA+3mD0mcDu55QXya3b5xeR/Orsjkmy6sEv4pyrO2/cL23FBEujPZC?=
 =?us-ascii?Q?oyBR5xwWoc/C2HcQ1+qtQMaQzq+baGsA3a5ISG+YqN+GitzUuzKSMybn8wfD?=
 =?us-ascii?Q?nEFHk0BTCdAjAH7Y8zcxU4cBwJWl0jgzqVUAs3otvhs6IKyRZkQ6Y+hMR2Wj?=
 =?us-ascii?Q?iW99gnqtf8VtkzvhN/tdOXC05ADwPF9hZV9zICFl5svM0EQv6xqcUCgWce2n?=
 =?us-ascii?Q?O9hoL8guGoZ2Kd6CF1QnAMhJH3pqOA428cLWyCuIvFqoglpQSAWa6NHh5PS9?=
 =?us-ascii?Q?NZ3DoP391qBdZt/5CSDYbM4zNpU07i8May9LGMCOQfc4wggk5pVOrEogpGik?=
 =?us-ascii?Q?eYgvscWUq6nw9NHwVYWtc7fDPkvATrXcL8feMGfIRyJUnDRAym5+K6q1Xi9q?=
 =?us-ascii?Q?WwxXlQJ3gkRk3FotL4Ux4jSn0/8M0XlxX66/gjT1M49lKQSpEGWECuFPE8Zt?=
 =?us-ascii?Q?PKLpFMBbqNgAmStz05CqS3gYdFL+kGadWGCiLFsswgeQvx08Ia6/1/4+CeyF?=
 =?us-ascii?Q?pxpiuSEuApJ60oywO3dTvWH8oE7uA3HBabX0H2HGYMT0hpmrggRkcLuXHUeY?=
 =?us-ascii?Q?68A/Tk/mfcSirAW/Z2o7qKGD7oT0Jkz3M7DXN/3Iled8pczX4+PxxSTpJQVu?=
 =?us-ascii?Q?6P1mYq2d9uRi8mvMfPpj3hX3EnGWJYh/hDLthYDGpuMh+PlFXKuM9W2r2FJj?=
 =?us-ascii?Q?bCSsNq9wgo56z/g1i3xLoOKm8tBysu35jUHtRGilrHvs1bnUP90dlu4gAxFG?=
 =?us-ascii?Q?bRtxX36A4FTr6eRqNJB7SR5FRE5uea2kzynAH3YxLUKwC0FPX/y0xxffA8pp?=
 =?us-ascii?Q?2tN7RqvwHiBGWZWpo3V8rvosAVft8iAqXv+bM4SGd3bsSPT0d6txIIWOtrW4?=
 =?us-ascii?Q?FDmQ49BI5xZSMX0vwQvATvWRnXgr16nOaf6E?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:36:22.1779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ffa83a-f35e-4f32-1981-08ddf5ef30ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

Optimize AXI DMA control register programming by consolidating
coalesce count and delay configuration into a single register write.
Previously, the coalesce count was written separately from the delay
configuration, resulting in two register writes. Combine these into
one write operation to reduce bus overhead.
Additionally, avoid redundant channel starts by only calling
xilinx_dma_start() when the channel is actually idle.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 7211c394cdca..6e9bf4732ded 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1561,7 +1561,6 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
 		reg |= chan->desc_pendingcount <<
 				  XILINX_DMA_CR_COALESCE_SHIFT;
-		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
 	if (chan->has_sg && list_empty(&chan->active_list))
@@ -1571,7 +1570,8 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
-	xilinx_dma_start(chan);
+	if (chan->idle)
+		xilinx_dma_start(chan);
 
 	if (chan->err)
 		return;
-- 
2.25.1


