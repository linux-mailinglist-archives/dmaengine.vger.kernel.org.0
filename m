Return-Path: <dmaengine+bounces-6603-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A211BB7F77E
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 15:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB3B4A76F7
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF99316193;
	Wed, 17 Sep 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iZfSN1af"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C52222B6;
	Wed, 17 Sep 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116183; cv=fail; b=bZ5C0YCTdDixAZm1r4jAhufFJZvXKX2uggd63/2ZhCdib5LVINFbavGosgTqCyC0Xab+7fAfaIEl/eFhELBAM8cCz7B7iTlOgqbYsqyKGIAToqZLejuak09o5x24XU65eaizref+cpkJF2JCQdKy1cmOfaRlCufBvQxSBn6Tm/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116183; c=relaxed/simple;
	bh=kC603L80Tb+GXnPR4qlJSbMMqCGGaUYhdAIM2IAhZlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0SOwHhiXJSavCwOoZyzMXzfDbqULh61IPRjMQJxyvM7Rvik1l3g0nZXxHsgkSIYEn8ttFIYh0dNvfjycQqu2eWpDzOL4QB3PMNzYg4WvNfht2fNrcRNQWqb6xM2h06iqfqAX1mS1nhzkR8PG2SmjJbdM3en8DXxEYCXENAxt/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iZfSN1af; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vj4qxsSC+9gPK3rv+z1DqdDFe1bk6hXW9IYiZ86NFf2OJN54c1le29NDAsCwkOsnWQQctK1ugWVy25r9+xLkvvwkiC6ebsoLkCNPv8q2Gi/FbL8FZJ6rY8fm+nlK+NMlqluL8ZY1MVtoNKLevoinMJVlIpONt9xjYsUiOZrKS6zceoAo5QmUaqmDEU19lBOrDzTYmbrrC1tONPmJhxU1PCJf+siWMO0+xMnDk1FBtcnuZRdEUwzekIHQj2pUbFXCb/Ke+goRD2+nbj52MDpyLoR8roMpkPECuVyPDnWmV3jDrDRFJ8Smqd/gKl6oUZNRRVOjeFhUY8t3mWJ0HszObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07fjk4okce04G2lK1vLBZK4H5aSeTLpYRU17MwIojbM=;
 b=MNt2ho+f3xWdwaDSam/K5EZkyFpxKGj4IqlVcOe2hHRGqK7VWVhczwcxo8QIhVexY8eEXb38b4TtnFnw0LorkV7Nz5jXgfuSyDZGpzNfpWxBzIcignSOUCh8DLEY2J8vMVC6nK3wAtniNfpyTQp/n1JI1hK7Ok18dW0nYFvng9sQRjLQwvtiNeEyNqMkUYK6YVYpBypj2IS8aOv+whzSgvEz5to4qim6CVagAY6TEhnCMM290p6k0ewbbdLsSaS6C4f6O7A3GKwxm8Tl0fRg9JRG79/qiTD5uNNaSTfWkiRDC/XxPK49v4CEI3UOq+IhnXCMFSw19ZrhU/xawzXTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07fjk4okce04G2lK1vLBZK4H5aSeTLpYRU17MwIojbM=;
 b=iZfSN1afahXVyNgIsAZGwpwszjtmNWyEzFKWulw0lLSLCz7lBX7mGeR8+TBDu77g+gn4W0cZPDoVLYU3AVkaNhuZHv22j1JxsV7k/HRiYw+krv7TIW3DazkYt7fI/EQLp/nsgrygrkkr2mfRlU/V81oNy0zOWtL9j+nnhSfQKxw=
Received: from BN9PR03CA0508.namprd03.prod.outlook.com (2603:10b6:408:130::33)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 13:36:19 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::c6) by BN9PR03CA0508.outlook.office365.com
 (2603:10b6:408:130::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Wed,
 17 Sep 2025 13:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 13:36:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 17 Sep
 2025 06:36:18 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Sep
 2025 08:36:18 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Sep 2025 06:36:15 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dmaengine: xilinx_dma: Enable transfer chaining by removing idle restriction
Date: Wed, 17 Sep 2025 19:06:08 +0530
Message-ID: <20250917133609.231316-3-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: f547864f-0dc7-43d2-4461-08ddf5ef2f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hM9Q9rmCysEprjZqXlFPRu0r4QpztWnvlriy3XYLGVjBk3a7PzinL1P9ZtVY?=
 =?us-ascii?Q?lBW0zizySKShqagN3Y1RIbYvbjg3WfMRvGnARKV8WCLteigN8DS1DevyFz3/?=
 =?us-ascii?Q?f8T7QlLQxlYvgakHtPddFSkEHVwCHcURTZmItP0HiuNw3nzmtJHdKVkMiuDA?=
 =?us-ascii?Q?lv4rCLu+M/XgdxzXbk+5KWR0UvUDbzY++5jrbJf0B3dT0Fh5iP8yVaDN2OFh?=
 =?us-ascii?Q?0Sor9ajASUzY8+RESvDZpEH3O+Uo5Q9p/9dk43zZQZXhoz5gzAufWZjBjthM?=
 =?us-ascii?Q?FyPMuwi8aIH5vxwKAfb0JTTCUNdxZvnKnIzaB0DHAFaz3bsTCqE421ROUNkN?=
 =?us-ascii?Q?1eNiQJKm99XY5g8jIpoma0SomD2rYJ6e1H6H85HzforQxOjWnfOCYoc90PCy?=
 =?us-ascii?Q?9NLTJOjYD9lTUhQvrRHLCQAoIl8LjNaL4JDYlfuJhaEIwUo72J8OI4yhXwNe?=
 =?us-ascii?Q?W0LlNuoJ+tGg08U560Gl03SgVjECTMmI/DS6/BPLTpmA9g4ZuF/igTDah0Sc?=
 =?us-ascii?Q?0OoM9bHRgOkjG/i8p+i8sw54Qc2v9d1+BTJ7cIrebb7m1/Y+6ZmqqamkuEEW?=
 =?us-ascii?Q?NFVP41wrI/NzhBqQqdyqeFqzOxJ3ceNPzngwmP0zNIaJNSsLH/Vgqa1ufGIW?=
 =?us-ascii?Q?dqw4eewxLpQRFn3qAv2bGRbbCWdCKMPyOe1iy1wrRat+8dJGPnOHDvxrk76q?=
 =?us-ascii?Q?+tQ3MoHm6cii0j3Kt6JGeRVoJAMBIwhNmLWqqKQgV2dGAmSsAQslgOszMK+g?=
 =?us-ascii?Q?ECs+CApT4NUUjGoqtYL+LUIYlIo0KPHTHI8ZlTbJKRLUqwzi6noSxcv56g/h?=
 =?us-ascii?Q?vvWjiZtKZbi76XgJtIbLqebyKO/sv09XGhYr8KMVyMiLHwwG4zK/7n7KTm8E?=
 =?us-ascii?Q?k8Mz2YYF2b45pdzztK9bED1oFhwhj1/SX5r6rpvn5lkoSnu5mTR21iuALImD?=
 =?us-ascii?Q?JVh6x30Xwf5OBwqgf/fmt/Pe0CizpbK9edpOMYLi4Iiffhu86bIb/k1fmgRr?=
 =?us-ascii?Q?7K427t1T92lnupTu9/AVp2uYRnhJ29IBerAhCN5naT+3t1VOFQMBE3Zv/tq6?=
 =?us-ascii?Q?2A/2E/iUxksoarBSt1ybcKOdWP5p0MEYv/VPXYe+9Ulodbt0r1Xt48P/S+WS?=
 =?us-ascii?Q?i1S4NyrhQ6GAalq4HFculVSSKvRTCGGu22dqYXXWtgy1nELDqcAImICOC36B?=
 =?us-ascii?Q?ut6M0RtYP504N6RlmM7mhhaDTSKfOIp7H/CrtaToNShqHflxVIlObsiCP87p?=
 =?us-ascii?Q?m/oVcGT8TQQbMJYqIP6q3ULMK8P+RXeJzCTOewS6UcqjCx/hdPfKNWoleKxJ?=
 =?us-ascii?Q?+jENYH4vG003l1bJVFVQXLQIBhZRBu32+pPtR2vK3km/otT3xJY1OwwFXTgJ?=
 =?us-ascii?Q?mFg0Ii1acc7SZhcoWUSPrf5HgTEuwo+SKyAceiOU6AGGF4/0HC+PetutDqyL?=
 =?us-ascii?Q?B6Y5h0X5Gcwbu6XX0Z5X+isg9ri7LFsiOHUQVL4JBpll0ACvmrEinZYWZOHw?=
 =?us-ascii?Q?pRGxVTZnR8YPKnAN58+tYz5zUIhQc5ctvHvh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:36:19.3324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f547864f-0dc7-43d2-4461-08ddf5ef2f2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669

Remove the restrictive idle check in xilinx_dma_start_transfer() that
prevented new transfers from being queued when the channel was busy.
Additionally, only update the CURDESC register when the active list
is empty to avoid interfering with transfers already in progress.
When the active list contains transfers, the hardware tail pointer
extension mechanism handles chaining automatically.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 9f416eae33d0..7211c394cdca 100644
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
-- 
2.25.1


