Return-Path: <dmaengine+bounces-6756-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D38BB5FA7
	for <lists+dmaengine@lfdr.de>; Fri, 03 Oct 2025 08:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78F3E4E43E2
	for <lists+dmaengine@lfdr.de>; Fri,  3 Oct 2025 06:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C8207A32;
	Fri,  3 Oct 2025 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YVhfd29T"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C821773F;
	Fri,  3 Oct 2025 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759472371; cv=fail; b=NZQh+kMbR9G+cc/t9VkDZwBak7CVw9tRcDHTN58DKEQfrE220O2LrRQk5j9XBV0+Zw42LtqGC5zce1+YfH6J0GgemvqF6UTYaeB18XIUWQ80XZl+eFmqNtnFiSSMkmGcd/6T2TgtTD3rIA/iwDAIp1NtnpxfHmQ0mCkff/sdQwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759472371; c=relaxed/simple;
	bh=6gMeiSW/XsGu6tb22+elPNcdSs81Tu0TDGhDNYUMDNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux0MQpHSxofIxuuveuGTbwVbApptmrSAgSCTaYCc/zKPz/45vZJd/WT96T9Cr5c8DcFX+fUkQ22ykhc/sQuTXhatrhckNL/a0xmiKkeGJh/jJIPJQ1ofQ6T2PdptwcDkWpvpuyTMIgRyNdzeAhaDxHk/cpaSbPPPB0pv0vDZ3WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YVhfd29T; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnaHI5imiN8/SDs4AoVB1yLwtMmvoRAMSQsJMy0oMOFqWuLrQpt7R60+aVMmEm9gGk28OHW8y8unsEnxpwkGr9qHZJ/bpZMbJcHCiuCKrELEEapJOSS00lIL+PVuteRhycASuYkl0jCoC8M/5Xn6qwnObYETIvZo9M88wSahgs/w92rWK7DJfj7aLIsmCLRZ9sMlyJ8ptr55Rn8isYKdYQcX/agFQdzO0L6DTgLAuubTWr01rm48qKBLte3GzMYdc3YIMuEgO51v+fGRuCBgZqENlPc4btmzoOAAJeBlErWOpeWHE/aMabgTg6wkM4JdfuCOUxPKkuDWBsMwOe/smQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQSkpjdKkEIscqlTn4p8/o/wKrnWvAdJvvEcYxwAnH0=;
 b=Npdl73KoBAQB03lZHJoK8opxFaVsnHyI6i87h8Wg9ipMkaJ1oExuWpgQTfiMOSh+vH3xbcslUXeSEdP9EQfLsFj8JRq1SIfedtkKfGyjX+F+31cU+KD1cM+kxpnKyFLG18k4q6M1ycS1hT+Ojvse5kjDx6RyyNhZeKMkz7xeYaOnxHzm9XPDonmofozvxrijwwif9Wp2ZtQl4Elo/jPPtbfr58SYXcn+iHSvVVMj32jACDkcyXcZmeyntr5a+W0MbSULUZ4ix4+ICljzLnO6rwfaIR78mVvFjICvN5L52PdH1bYMS9bXBdQZHj/91qYLgsZpkEiimnRjR+Itz0IJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQSkpjdKkEIscqlTn4p8/o/wKrnWvAdJvvEcYxwAnH0=;
 b=YVhfd29TBEGIP6Xgv3nB8DtDIiFUdH6u+XCjUc381/pMogXFIgSPqQARu/EUkMYLkJI1r2E7kI7t9fsNOZOhRu9v1rxz0LNQJ0O4MWl1M8maMpGFKIejqLaUJemP0dPkPdvHZyH3s9Xysd1UMd6c4j+vMZ+VwVXBOkMHA3FhCaA=
Received: from BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 06:19:20 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::c2) by BL1PR13CA0127.outlook.office365.com
 (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.5 via Frontend Transport; Fri, 3
 Oct 2025 06:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 06:19:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 23:19:17 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 Oct
 2025 01:19:17 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Oct 2025 23:19:15 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/3] dmaengine: xilinx_dma: Enable transfer chaining for AXIDMA and MCDMA by removing idle restriction
Date: Fri, 3 Oct 2025 11:49:09 +0530
Message-ID: <20251003061910.471575-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251003061910.471575-1-suraj.gupta2@amd.com>
References: <20251003061910.471575-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 81568ea5-4b90-491c-37c1-08de0244ca24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pn5ebV7LNizyOSw6om0qnBOdC5n0KpTJmWiVAm9H/JSG+9JThnmiQJ/QEgfN?=
 =?us-ascii?Q?BBUgWJvUHirDwc1t3ZfGPI8EMX778ZoYiX6n8DGJdP7qKuKBvAE7UOm/yaSs?=
 =?us-ascii?Q?X0Wx/qd7MODvy14upZZQTPukSoQZ0zSAQOc96uQb1VxFujECUz3SV5qEClAn?=
 =?us-ascii?Q?iYMkJvIdYh94PudrEiUfZfsy24HguRHE4mJY3yWWuCc8bgXarVUAEZUUR5pS?=
 =?us-ascii?Q?MSnKFVmhx5UwbK3jBQ1bRzCCLSkxetCC6599U9usLUaYg+CZwlf2hKPZAV53?=
 =?us-ascii?Q?yR724By44+7P142amlDKKUknFF+V0Ek7H0LP/x5T0cxt3mrtOY3CNBkCpgPF?=
 =?us-ascii?Q?bDT2J755/pBfLaw2uNl7EQGwoJrtJUIEpN3w3g8FqKP/7Oc3NVY2X1dHph5r?=
 =?us-ascii?Q?C+JDDy303Yy49x5yH3lPmi2MHPIa7AXf9G5ztAgpps6a5XHWo18kN+wmPOyq?=
 =?us-ascii?Q?p8x0JranMP4ecCIoMyNHqZdCNeUK6ACU7hkg5FPA/oWpvJb7a6rpptxWByIT?=
 =?us-ascii?Q?aH+RyRuS01kKsQqp2/DXZ3wx4IG1aiZVFOUPPiGUvsM4vzY6Tsdc88jl+u/s?=
 =?us-ascii?Q?H7DUhtrhYV5GQWVVyBlsfJtV1ETqwkEfH+8eZU5Z37FjtN6niDjRZGhCY7uZ?=
 =?us-ascii?Q?UDoVDAOOOQkQZ+qkCJRZBkNrDyvfdWRzQtDpseonNyjmZqDjpALgseMFLf5Y?=
 =?us-ascii?Q?gKQVxXirhd1Z5av2PMeAs0+ZCQ2TKB6HP9eR5ZcGKAOaSCzKvlgv0ThGUHBG?=
 =?us-ascii?Q?8eMqluZtQTJFfCejOM5bFgBRf+DgPurqUgl+ZCI3W8fnmQoeLCniyiEmRZCV?=
 =?us-ascii?Q?vEVvULqAdBQOd5uafGGTudtb9wAqvgq/txptOnXbmFKMbzMwHZ4/aTvKeU89?=
 =?us-ascii?Q?+ivRdxixvdcdN3x13cWuiwj7O6xY62Sq71ieUbfVdBL9UZOVbJiMj6CCNPFc?=
 =?us-ascii?Q?LsAIdAAPRmEyAAPHg8ly41C4Nd7rjSFe+vWcnDSwV3CPbwNTRJTZ4FQ+Gwr2?=
 =?us-ascii?Q?KFz6fZTpUCrcOLHLFpCN+xsI0riNhAXhh+Iqb81sFf+MlXl8i2kttQRpy6WK?=
 =?us-ascii?Q?VB22/3dWKaEOSg22gfkN5EFQ/SwpbuLvlR44FBUC/ydFHG/YBG8POwg8SaCe?=
 =?us-ascii?Q?FLSq77ic8I3xEnE+x6hRQJvpPCFZDVSSu3zcfMZVG8RzT/eeSoJj4nuOpBeT?=
 =?us-ascii?Q?QsTWm0UWq9MVP9kYSX+R1Eh5/BooRgFk6wYAf03d5y7M2oR454JoG997+svA?=
 =?us-ascii?Q?3LmMEEPDx4t1MBy7QRLPyCAXYIDNkr2cDkKeB+FCsQfnjUOcvUchNxOTDTFb?=
 =?us-ascii?Q?SYQXl6U4a3FrWPv21QakXjNoazPf1hNC/8oROL0Z/1Z/Kf0cIHkkRwbfTdvY?=
 =?us-ascii?Q?s7hylnX51IhdNamRv1pImn+t92IpXQRBn3g/ZOuu+Y3lREIi+bxsBwT8vv4q?=
 =?us-ascii?Q?KRS2ZTDw0bP0IHxf0ogr7y+c6pMVWZMWUuC88q3DEaGjkmia893Q/5t7OTKx?=
 =?us-ascii?Q?lLGKCOlWjTA6vdNNWIgNa+QhthbcUIOYH3i00x+JPhSCkVy/hT6eVSMAjkM7?=
 =?us-ascii?Q?f4qhwE0gP1R4G/xGN9M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 06:19:20.5160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81568ea5-4b90-491c-37c1-08de0244ca24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

Remove the restrictive idle check in xilinx_dma_start_transfer() and
xilinx_mcdma_start_transfer() that prevented new transfers from being
queued when the channel was busy.
Additionally, only update the CURDESC register when the channel is
running in scatter-gather mode and active list is empty to avoid
interfering with transfers already in progress. When the active list
contains transfers, the hardware tail pointer extension mechanism
handles chaining automatically.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 53b82ddad007..aa6589e88c5c 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1548,9 +1548,6 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (list_empty(&chan->pending_list))
 		return;
 
-	if (!chan->idle)
-		return;
-
 	head_desc = list_first_entry(&chan->pending_list,
 				     struct xilinx_dma_tx_descriptor, node);
 	tail_desc = list_last_entry(&chan->pending_list,
@@ -1567,7 +1564,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
-	if (chan->has_sg)
+	if (chan->has_sg && list_empty(&chan->active_list))
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
 	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
@@ -1627,9 +1624,6 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
-	if (!chan->idle)
-		return;
-
 	if (list_empty(&chan->pending_list))
 		return;
 
@@ -1652,8 +1646,9 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
 	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
 
 	/* Program current descriptor */
-	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
-		     head_desc->async_tx.phys);
+	if (chan->has_sg && list_empty(&chan->active_list))
+		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
+			     head_desc->async_tx.phys);
 
 	/* Program channel enable register */
 	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);
-- 
2.25.1


