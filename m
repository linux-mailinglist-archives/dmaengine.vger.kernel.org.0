Return-Path: <dmaengine+bounces-5889-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDEB157A3
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 04:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A435471D1
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 02:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F20C2260C;
	Wed, 30 Jul 2025 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="Y/u4mT8A"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09141A0BF3
	for <dmaengine@vger.kernel.org>; Wed, 30 Jul 2025 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753844185; cv=fail; b=NsT6tAQFVVdXczSnO8ZQ1N95tIC+jupb0QPCxOCZakrGqfJrmHB77icVSxTNx4J/eYp7vgtskmYfVLoF8NoW744PJMAeY1zdqmq5/0vTHr4540OiAIOU4LZjcTqWEn3MaI44BqZpXEOa2dk4nIc7KBTgVAy3bJoZfSpgJV07BoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753844185; c=relaxed/simple;
	bh=IrvPloSZc8q7G0T+o1s+1E4FXae0sGYls3PzdSycdKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ve3Y6bPbGKy7mowYGIVKr7nSIHDfuZYd7XsdyhH8li1QuYHJVKV+1+vYcp8T7qO6v7InL08aTs7/82s2RU+S7vyiCJEEX2RisdqLi4uUtNjzEUn32y/UNi5dXJ+O4Eeunx27l6Bnq3g2irbcCLkFkdfS6L0syVhxIVbNU2xbVmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=Y/u4mT8A; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPtEQmK57oomJXhZIor8oDZNxYvWhOuPo3CR9KDQD9oviYWnkNSseNpaDy6lmFLWIKRwfJXu7BmXJ4oU6JYDZ7JB3qFqUtpzTLUaxaI2bhyWLgaAzPIMOHOB3jZirl9aFHPZUSRLHJY2nmihBkOqs6uYbYq5eo8WYa2e3m7TtA+CFLNAh1qWxGHvhkvGbkwuEDgyTlXJyHfmwf9c1JUEfI24lMD3ZDyhXKHo2Z0rIVhKUua3YrAJRxM/z42bHslu86YBhDnhFhw1ACYwiPWEny/vM+z4Jx2AgmeJiOnMCsTTXObkdDjBgyMA0uw0Kgwknj7Vm/Ya4h6YJDzz2kr4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5u436JDaJrz/xg/XQCz47+Id5l7DIAA/s6CI9CRSkk=;
 b=EvxSc7qIMteKuR1TVEKwrRJuaM+F9Wz0oZdSPKbrDkweukwx/JMRaN/JhUZHmIRE7jFQE1H0oWjNpjuvxZu8DiNxJuX1jWVEgDbRc1KEEu/A9xSIdWQt2E64rlAumxZaiknyF9syDwCF44iciqkB0Micrnu0Ba1lrNwzPjDnP8iKU56GJS8Peam/KZRmgvYO7jUtBQ3WWHaNWyIJc/nj3jCBZ5DJbf6fcdWxCty/Wyo7Y+pjUQmf5Xx7TD9XVgHbZn3inBDo1k0JRX6g7tT/5eRRW532o+oEkPUFjgCTq8aKTGK/7u48tXsMeHp4Hg3GIj7aDcB/c/jnCktzBMA5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5u436JDaJrz/xg/XQCz47+Id5l7DIAA/s6CI9CRSkk=;
 b=Y/u4mT8AMhXFzrFVkbFcAoFWoABpWqzU7Xpv5pX9q0b2cWxwoeKZTvOKSScyVSab5GYvhV1dAcDTL/H03iAn+pyj7hIRBHNnxDyBRAA8p05DwE5T9ey3um6wY0wc3Qv3GnWMvRvgkFd1+nET8kq5BEUZKpBNzo+5aU9bq3goMWYeFVDc9KfV5Ss9ClaV/Gg+jjoga0seVj6flG2qTgA/IRCIakwuv0p4lC1PyyXyRS1T74fffcnzebyPFSkhgjgwmMSUnkjQh9rFW912Z8jf8QfczYkaz4JMLtDm0MH/M8S6iHpTuaUy5SojrLblJmeL+OASttT2936BBLJITMiYgw==
Received: from DM5PR08CA0029.namprd08.prod.outlook.com (2603:10b6:4:60::18) by
 DS1PR19MB8606.namprd19.prod.outlook.com (2603:10b6:8:1e5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 02:56:18 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::22) by DM5PR08CA0029.outlook.office365.com
 (2603:10b6:4:60::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 02:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 02:56:17 +0000
Received: from sgb015.sgsw.maxlinear.com (10.23.238.15) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.39; Tue, 29 Jul 2025
 19:56:15 -0700
From: Zhu Yixin <yzhu@maxlinear.com>
To: <dmaengine@vger.kernel.org>, <vkoul@kernel.org>
CC: <jchng@maxlinear.com>, <sureshnagaraj@maxlinear.com>, Zhu Yixin
	<yzhu@maxlinear.com>
Subject: [PATCH 2/5] dmaengine: lgm-dma: Correct ORRC MAX counter value.
Date: Wed, 30 Jul 2025 10:45:44 +0800
Message-ID: <20250730024547.3160871-2-yzhu@maxlinear.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250730024547.3160871-1-yzhu@maxlinear.com>
References: <20250730024547.3160871-1-yzhu@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DS1PR19MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e460446-1b27-443b-79e0-08ddcf14a79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PKjAW9gFvd72DYgqVkK5LbLazmSroXGc6Csa7K3J6BYLvkppHWR0Pf4tRplH?=
 =?us-ascii?Q?taLK9+y9ayYUSVocdj9OY6xt/lv+BIzw7nbCTUh9II4H1XRdmGdOVVfD946f?=
 =?us-ascii?Q?40LSlVb36S36EaN5/GE6qEdfJ45DBR92Tci8PMQZS7NtRhY6e/JN5NQCg7MB?=
 =?us-ascii?Q?f0kjyRf4n018ctIjSWRNQnLsstV84hUYxpokdVNxN2+U+p47UTFq9vuQPD9x?=
 =?us-ascii?Q?Z98QI4YPjuA2C31xnsxIuZfDPxD/1mfIVM+si9ZGB4VxQJPkgp98w7Yy+JLU?=
 =?us-ascii?Q?uJmp/HFXHJF4gjLCLxb6uCmlM4EnBbsGMMUW8AwkfBF8QN94vaaCpPmjTc/o?=
 =?us-ascii?Q?4GTg16bSzwYKIp8+9zvLS0bd5VqVXmPbzLoJSSm9JOyXRG4eJna9dkeOcY6i?=
 =?us-ascii?Q?ybE6AgmbjKvyBYFUvdLE2c9eOXbU/Fr3XGjw4yHBsAZHuMQrW3xIV2D2MsEP?=
 =?us-ascii?Q?ASrYt+rNlyFU6kVt0ibBkAcV0rUnOpHN9eQyIeG8z3bdxkpPDdfHik2TvOzC?=
 =?us-ascii?Q?V3ElwAaYIu8HnMO6vOm63hHqIlrZvxndmVTfm91ZFQyDfv/NdZDqBV2sSSI0?=
 =?us-ascii?Q?CQUKEczky15LV77cZG0jFrmUhCwYJLnqTAGNoTnUHXGCMa2RfZYmoSIadi+k?=
 =?us-ascii?Q?2pS3NuHo1K+YDgSIyHihinIEDJGk9TC8d16ce5tVcWV3ewT5o05iZjRRZOG4?=
 =?us-ascii?Q?6Ehrqjcl46TNbGqj+WNC5vu5i4abTKKlecRroK6sUVNv6IHDH2hc2VVRhcnY?=
 =?us-ascii?Q?gtvQvb7okdtqDZB2w/4Qw6mAWIPyWNCiWrpKZ5WPALpVlbPZ/dReYGPXadAR?=
 =?us-ascii?Q?jR+r6rZVFnUWaehFGpKXyyktRE93Bw1xokOz1T5c9lZ/8WkKr1W4WOfZD+mh?=
 =?us-ascii?Q?M1G25muodsJ4QWJsfsDvkIhmxtpYkeLA67uCDaDWM9+sftglLJJkvo+QdsBp?=
 =?us-ascii?Q?25x9WgkqK/a+Fv0stn3MHpENrCckW7mAUXZn5B+qbMqdLBrFc/OJFPnAdb5c?=
 =?us-ascii?Q?9qqMva8SHKKXX2SexSlgDiQ8xoOUakatZVNJ+P/9pZxj92LMtbrl5wX55xWn?=
 =?us-ascii?Q?rWkeDLd3Jx0KBtDzVEcPLr1+5Mzj6iEMZ413N9UuipLrzLOdsg7XShRn4Zf7?=
 =?us-ascii?Q?Eo/LOKOrJ0OKf9lGU4okIiImSWNUXZrliMfcDPeZJQTYFjEOEKXqtKsv31j2?=
 =?us-ascii?Q?AI2td3xTcHo1OWajV49BhWKgPWIdypqV/SdKGAe4FYNxSnSpeZo7EXCZGqwS?=
 =?us-ascii?Q?8DelFsghtj393746igCl4ZX+mqadqTmq0xte3KXDYUheTkNUnvl7Yr20IAKS?=
 =?us-ascii?Q?B0pKM4zxJEvB47NzcyqsOHgA/wKeL2Wwq9JoWioEJZ5VuYEww6EDaOmdU+4O?=
 =?us-ascii?Q?3YZMDf3CUigCd/bUhGQ3OS+rELfB2v/mlS7ZPKCwy8fRzRNXqS6hAZAzwJYP?=
 =?us-ascii?Q?dWsSNeWLw3Hvhh1c16DLY0syd5DkzGoc1a4XPTdfmgVvb32E2yKckhRPscQb?=
 =?us-ascii?Q?U1+E8KJgjq785A4Qc4E+/BZO+/SO71yA9BU5?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 02:56:17.3923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e460446-1b27-443b-79e0-08ddcf14a79b
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR19MB8606

The maximum ORRC counter is 16.
Sanity check and recify the value when get from device tree.

Signed-off-by: Zhu Yixin <yzhu@maxlinear.com>
---
 drivers/dma/lgm/lgm-dma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index 93438cc9f020..ea185c5de1b2 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -140,8 +140,7 @@
 #define DMA_VALID_DESC_FETCH_ACK	BIT(7)
 #define DMA_DFT_DRB			BIT(8)
 
-#define DMA_DFT_ORRC_CNT		16
-#define DMA_ORRC_MAX_CNT		(SZ_32 - 1)
+#define DMA_ORRC_MAX_CNT		16
 #define DMA_DFT_POLL_CNT		SZ_4
 #define DMA_DFT_BURST_V22		SZ_2
 #define DMA_BURSTL_8DW			SZ_8
@@ -406,12 +405,11 @@ static void ldma_dev_orrc_cfg(struct ldma_dev *d)
 	u32 val = 0;
 	u32 mask;
 
-	if (d->type == DMA_TYPE_RX)
+	if (d->type == DMA_TYPE_RX || !d->orrc)
 		return;
 
 	mask = DMA_ORRC_EN | DMA_ORRC_ORRCNT;
-	if (d->orrc > 0 && d->orrc <= DMA_ORRC_MAX_CNT)
-		val = DMA_ORRC_EN | FIELD_PREP(DMA_ORRC_ORRCNT, d->orrc);
+	val = DMA_ORRC_EN | FIELD_PREP(DMA_ORRC_ORRCNT, d->orrc);
 
 	spin_lock_irqsave(&d->dev_lock, flags);
 	ldma_update_bits(d, mask, val, DMA_ORRC);
@@ -946,8 +944,11 @@ static int ldma_parse_dt(struct ldma_dev *d)
 		d->pollcnt = DMA_DFT_POLL_CNT;
 
 	if (fwnode_property_read_u32(fwnode, "intel,dma-orrc",
-				     &d->orrc))
-		d->orrc = DMA_DFT_ORRC_CNT;
+				     &d->orrc)) {
+		d->orrc = 0;
+	} else if (d->orrc > DMA_ORRC_MAX_CNT) {
+		d->orrc = DMA_ORRC_MAX_CNT;
+	}
 
 	if (fwnode_property_read_u32(fwnode, "intel,dma-type",
 				     &d->type))
-- 
2.43.5


