Return-Path: <dmaengine+bounces-6753-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03BBB5F95
	for <lists+dmaengine@lfdr.de>; Fri, 03 Oct 2025 08:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 451403441E0
	for <lists+dmaengine@lfdr.de>; Fri,  3 Oct 2025 06:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B81F8ADD;
	Fri,  3 Oct 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wbNZLTcX"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1028FD;
	Fri,  3 Oct 2025 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759472361; cv=fail; b=QDODWoJ1L2alXb2Bs+B40l9ClMVCHna1uaUXp3tslLPj0QxROcABPGRrcCNTnozKaOcFYbwQmXidfhI8EvEde2vZrIg20/TqHitCNzq0yxj5e4fd9PlD7VxIrs8kfQn9LzTjpqmP4LtB0lyw0CNSTobymk57uK+dpbmCz5rUa80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759472361; c=relaxed/simple;
	bh=W9UU4023TSCy7Y7atwUQ3cbJjM6vDBIRNpA+/+HaJFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdQrxsQJqblI5GWP9QaRtfMcNAxx6N5kyKjlKblPtLdKQ1gh57vikqb8JfiHlTItgXmCVOlr9yLvB/5tJbBy2KQn2HLm1QZyoopqCTPyCaqFVxvj/3nnjovPpfo/LBNkrcpFwGL0akrjk4U2xfAncD7WijiyX3/8rSYZWDiwlOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wbNZLTcX; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhW5nuHBE4v853vdfcQgXu90hDSXd8MfXdLBJ2dap1Sif6ZvMH9qKUqIyhlOSOl7QY1+NhnYa3zybkPcB+f8HLQOoYWN03o6TycKa6F9kEz9tWIy8GLpPjsXn/Z9C+D1/r1uva7Q5eCFdXVCdr73lkYl21MfP5mLj0dJe8VHHh/6qDLU8N07r38BQi+aksyCDQlJCOb+rn6Gs4L0OhNm3e47uHCrqzDh5Z8f6tze+Lh35fxIEorao9A65DhSZbAZsdhCRSeLpDyKk1QU1dFOR2vMHoh1aCrhdrHu5Xsxk2qb0muJzq+QdX00s32zq8ZoxcWjqw60t5FMmUaFfeFLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brZfHtY6Ut97uB3Fcm/wX6O+uvheBa8GjOyq7JkfHrQ=;
 b=abdYeobhqP1WpeJqBF5NF5VqKrsvA6OG1qrKs6QDtbVP+RwKzJHzK7x8dutkBMm8HXJLRRXTW8HhaRZHVFF1L8uyJgWXnIjM5OtYG77c1JFa/JgWuh6j3kelGsicZ2nYe/TZL0A0wHc+3Rz5KwK0lEmDBtopiKa0A0v5KTTfMfsTWc9lvXkwIDwsYO6b8YYQF9WrVW8T8Qbmua/oRSa5hCL8dJSt0j/SabBHXLcbJ2enpMtDKEqj1vWTtzLPIrSLCuANSU42F6//gBR05ta5WqWSryLTV0/mlydk2NlVW/qrRk+G1CICxoQIMOi5Ahe12st8/FQlqhriSi50Q4HnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brZfHtY6Ut97uB3Fcm/wX6O+uvheBa8GjOyq7JkfHrQ=;
 b=wbNZLTcXwZCt3qFDqejqIScApOsqBP8yqbqfHUfga3Pbz3xTWv6cATPGlirBGjZCgu1LTnzOwe7YsyNDqVFBQsrrN2jc4pcDW7ujwfyV6owbIhhAL8k3L26cyf5QsY6WmK6bmF+ZqYx7mw/r4LzA/+wmpjsOgeR5EwNO0EzTSGs=
Received: from MN2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:208:234::13)
 by DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 06:19:16 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::5e) by MN2PR16CA0044.outlook.office365.com
 (2603:10b6:208:234::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Fri,
 3 Oct 2025 06:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 06:19:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 23:19:15 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 Oct
 2025 01:19:15 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Oct 2025 23:19:13 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/3] dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers
Date: Fri, 3 Oct 2025 11:49:08 +0530
Message-ID: <20251003061910.471575-2-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DS0PR12MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 05928459-12d8-4b1a-a3eb-08de0244c77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?42GM2cXHfTwEK4OllzayLJipq+HPA8OXFOaL/eox7FLV+REuZhP1g+A8YbtU?=
 =?us-ascii?Q?JE0+QgBO+4gng9QNouIbbBLW5BlEGML+Qab3Foc1Cm3Sw30wPCt30pVgQhU2?=
 =?us-ascii?Q?oO8eLwFmHywJVs6D6S6DkkRPBttYTLHBCdm/r1aiqV9atdxLDezkFcMHmvbh?=
 =?us-ascii?Q?v2c1BxesbImLmOcUuU0DES3Bw5zEkcM2mvXJCN5vSFSHBYZ4NxPnZHxxXLhp?=
 =?us-ascii?Q?FW3S6/t83T07LN+xwziBMEJKDFJ1R1Mndd2AMtnuB033J2t9zeUkyZbq5OOe?=
 =?us-ascii?Q?Yr0qDOW+2cRVjerTDDtqCZinuLrLNCcTLscIXQVDp/jlM91j4groOeJLZ67F?=
 =?us-ascii?Q?DyKCXzmoT/gTXFzFWUnW2FvAyYDCKOJ2wJ40WOtKGOy2V+5xFk9cUk7cXCXv?=
 =?us-ascii?Q?R8sKXj/0lW17Zztod37AOkWLvaxwDABLfAPptzA+XKDzho1U/I8m6stZWqJP?=
 =?us-ascii?Q?pOvmJL2E1LUfxqOVkbKXeGHNcQN38H04J/91n6mq5HgsLkBDtLjEGJ4yosCv?=
 =?us-ascii?Q?tL5Pkr4AZE3BqZDy5ckHdvFO6eoTCHcDtZdNBP7+MHYyCqwfVfHiSBWvq2HV?=
 =?us-ascii?Q?CJNYAJX3HdFo3GQg7w5Clpu5D5IH8nijLAGFqxN2r098pr/DS1DWlLVJX+bK?=
 =?us-ascii?Q?j4YxRkYevrTKwgOJtP9sGqlwnVHMJNeWyb26pOpClYLmdTVehgyBsbQcSBRj?=
 =?us-ascii?Q?oZwL0BAc4tTkoizzIzAgV6vns0Yya6E8G6rqsht4rJ8om4ncu//XebUwAdWE?=
 =?us-ascii?Q?hnERYgxVG6xny9oFqd4PMvCFh+dqbeG9l5rEn8pEnT1epR47+tYuN1iQVHoJ?=
 =?us-ascii?Q?k37CPFSpNE38l+HYSMXwRBy4788Arbsx3PIHJ/zF7m7LcZQmPaiqI9ZkKlBG?=
 =?us-ascii?Q?5+zocVrJw+0GpZd4cty30PY8/vp5R+BUNW4k9ToRI2h2iOxd/ryMQbz+mMI8?=
 =?us-ascii?Q?iT74JyEST/asAkkcf83q9qeL3EpjyhxXkQryWze51EhQlP+U1NqkRKe5Ikdp?=
 =?us-ascii?Q?UhJJKXncsHnb2dcjTLBg95LKPfkT5AKF1jYTG+WMvhxQqDSpqVRv7HQ9LBDM?=
 =?us-ascii?Q?LZjcJSWFSaWxQYIZxweYg1e6CwUuMUgYKKxfjimUL++eurzzmllNZo7povf2?=
 =?us-ascii?Q?QSS393kihPsS/HHbVtbh7N23tVfZrx3Rir5n3b+xWhqUb5Of5zoqe1ecud/L?=
 =?us-ascii?Q?dCYH2GXUcG9HrJOVrOEqlvJwSu1n1nZITh7520YeDh/kHN9BkNfy+ds37sQx?=
 =?us-ascii?Q?srbeX4jKUc9E2j/wDByyUqsU0g5kRrX6DfSeqFRHXy4QMFzQiFMLYUCp9ayA?=
 =?us-ascii?Q?7kH40pKx8/Ufrnj3ClslM7Y3roURQYLVnqz/k6dtEQyf8NeeiwDw93bzIelH?=
 =?us-ascii?Q?fcSw17RYAZ8Prr1njgX9LFRdTy77Yf8LP2ZoFv60HaJMZm4IVy9nwyVgfWgi?=
 =?us-ascii?Q?DUzh/+hwkmp+fmRh8ysyOzAOmm+YW0OWHr9ETmtcA9dH7ofFr53fs6Vr7Grp?=
 =?us-ascii?Q?79JF5ewXR7KaULhx+Wk4d+v2R86GBwfXhkEF5jx1PJgJzaO6yO61yI/gyQX0?=
 =?us-ascii?Q?lQVgN93zeB1m7SsWSbA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 06:19:16.0686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05928459-12d8-4b1a-a3eb-08de0244c77d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728

Fix a race condition in AXIDMA and MCDMA irq handlers where the channel
could be incorrectly marked as idle and attempt spurious transfers when
descriptors are still being processed.

The issue occurs when:
1. Multiple descriptors are queued and active.
2. An interrupt fires after completing some descriptors.
3. xilinx_dma_complete_descriptor() moves completed descriptors to
done_list.
4. Channel is marked idle and start_transfer() is called even though
   active_list still contains unprocessed descriptors.
5. This leads to premature transfer attempts and potential descriptor
   corruption or missed completions.

Only mark the channel as idle and start new transfers when the active list
is actually empty, ensuring proper channel state management and avoiding
spurious transfer attempts.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index fabff602065f..53b82ddad007 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1857,8 +1857,10 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
 	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
-		chan->idle = true;
-		chan->start_transfer(chan);
+		if (list_empty(&chan->active_list)) {
+			chan->idle = true;
+			chan->start_transfer(chan);
+		}
 		spin_unlock(&chan->lock);
 	}
 
@@ -1914,8 +1916,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
-		chan->idle = true;
-		chan->start_transfer(chan);
+		if (list_empty(&chan->active_list)) {
+			chan->idle = true;
+			chan->start_transfer(chan);
+		}
 		spin_unlock(&chan->lock);
 	}
 
-- 
2.25.1


