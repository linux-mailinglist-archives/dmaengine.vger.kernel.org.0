Return-Path: <dmaengine+bounces-2522-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C4914402
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537252836F9
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AED487B3;
	Mon, 24 Jun 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1htiDrMp"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F94482DB
	for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215811; cv=fail; b=pAJnWkgAzpN8uTYwAqkAhwgR++JFnt5hUsfnQJcbThihBJnSL90Ue6spTfANXRjkYQtygj4ElTdm4WSK0qQy9kEGtefaXMitYJ/si36T3fkYD8Cjbt8+44WkYLThF1PtZAFdXfmskGGU9VR/N1gc2D9z2qwWsynKjDi7mU9P/JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215811; c=relaxed/simple;
	bh=U+ZOHGEr/dbT6R7ZOSlgDEccaqkXdvxfjgvw/iD2I1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijSPfffCoiTdoLeRXB4DyaiPb07yshuz9PGm1/7MiSuIvjRCWglzQEYVjB6HUsJSFilldj2IxE43Q4jUhHO7KSOrQImSqoz8ID8FXaBhuq888w/qkjS1Irw4XOmYYr6wZmJdl1BfUkPgGsJMnglbL2J69DUkSZ7yk44+KeE1V1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1htiDrMp; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+vrW7TY103xghrY5i6ubpgjfJUd8TgVwby6VGjLILfzZLLy9ycVbr7xLTJbbfdSfD7x59UU0vxs+2EVWwvLbTGxaoOOcz0I0twZYtBnWK0YsAL/JHUMQn/MFJwure5T6eW96nd9DlOUTkd96t2Io3ZRv8HClxTZDuHGYUzGCTXDQgER7FOA7lDj4SC2U9kD57Zvhfs17cb04vf5cR1SWxius1FkTPCtHPFl6fybYfiNaHsflLc5vLKo6YhELxRkIc3V4xd1PkvBSBG1xcpq1DgXNELQb7y1O/HJA6l8N4w7+n7Ipj+jpcRpw6YbFbVfgCMQ61CMMQ0RajLhkgVcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a4ZmAWe0FAIZvy8V82gK3+uDeoTLA2HT40oz4xzMHg=;
 b=ESMyStpotVT+SPYaKSaUFZcbFcjnzRQAL/vzxDPxVfPCsZEZiUNeYHDIo6FJA/vYxasHQyIwUkGc9GgpnUfcuEV5nJmiKeAm7Qao8H1lLvKu0BqZAn1tGnI1Gb/EJeTw+laM9OPCIZi48rqeLAt+xrflZKkCuP3t6M5Lasrxbafph416MkZdo/o6izuA8hRwI/Yr19AcZGUnVVzEqB5v23x1JKQsyU+YaytqDFBgAF/PuPnM3lL1t5e5RqalOJZXfdMWxOG83XuG6gzmQS4ojuN+rwo3AOUqcQWFfYO7ZhJ3BddJDa3ax1WotaPlVIJlzpNs9b+TY0ORemNvoRlSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a4ZmAWe0FAIZvy8V82gK3+uDeoTLA2HT40oz4xzMHg=;
 b=1htiDrMptfExGvluIc/fjqDQpjyjqcbb5ptVR/cWkUtmadyjlut8i19bodDvS3e3hkkwBj/PNbHhpENTIuohwCYaNsFD12cTZXmmrKPgyfKU6RBfsgauWE35c+4tzzoqqQJdy+1UexziAMpkvn5twsTTm/fWUBiAOKqMuOlYqQI=
Received: from CH0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:610:119::7)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 07:56:47 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::50) by CH0PR03CA0373.outlook.office365.com
 (2603:10b6:610:119::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:56:47 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 02:56:44 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 7/7] dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup
Date: Mon, 24 Jun 2024 13:26:10 +0530
Message-ID: <20240624075610.1659502-8-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
References: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: a125aa63-9f4d-4f47-8058-08dc942332c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LKXPtblgtrs3IWuleJ5mqZrz09d5lxI1caEurgK45GjZkLVmYWFeHQzYzl27?=
 =?us-ascii?Q?dYNIopdrCZlYjkscbJyjcDOZ1frjw3gBcRbmfhLCIJD48s5O0VEiYKFpJXin?=
 =?us-ascii?Q?bz0C6/FNQArWzjd2osuevlbF62zNi9HWLhZ2+5X5FGykdsevaW/LCiRRvadV?=
 =?us-ascii?Q?mwX6BqY5Wv5NWqmpD4Z5JQmQHOCp+Wv6I3sbS24fNhTw78mzv2YOIy+GJCCi?=
 =?us-ascii?Q?4KW8LUYKedR799pQ99RFR933n3HZQwNhNmfEsZdeAmFrbiwz55zvZlQBSXNE?=
 =?us-ascii?Q?P1cQmxQNTdQ2ao2rHM0jcK4Eq6x57Pzat9F+LUh3uOoWISbNU0r8UziVteAx?=
 =?us-ascii?Q?lP60X+ZSgri656PBWycNbh8Qy1H0r1h9pOzA0h52ZEvBRHRT5ciYDwP1Lq9D?=
 =?us-ascii?Q?KBmNlOxoSWxwQJGp2NqdCYiIvS7qR2DncO/FRAxf5Ru8SuUHfrm8FUiJ41YQ?=
 =?us-ascii?Q?5l8l9KeCItbn2NqaXbrWHkmpLRbUU87dFTmZ9VCplgKVM5WfsfiSFFgwEPvu?=
 =?us-ascii?Q?vyj15INUQYLeFmIfvXy2TH5ptMxraYDrawmUqoYMz/C3+j4dGa3xXXW38CFc?=
 =?us-ascii?Q?dVeZW4OTbvGkRD/b5GX0nyQo3Lyo2K3nUEmj4N8SP89hJQj+U7IDp/cAlcvr?=
 =?us-ascii?Q?u6pSV5JoN1NRehEQ0C+VZXenoQiqyb4+7oUoeEJQCPNPN5CIjZEwk9GiYVG9?=
 =?us-ascii?Q?sHc4yOyOiYnhAcNsVBvPv97g9FXQbl3vJzw7dyTAcKLl9iNpc4ELie85+xbe?=
 =?us-ascii?Q?OaNczA5U3nB3Ame0hYlQsN50yOlKpzB+hXr/BP5EkSfmC62dPGl1EezIGXB6?=
 =?us-ascii?Q?+fIw2E+537OUNUWq5TAN3emY0wP3FW2Ex1sbYiWOJujGmQx5Yd5hWBxwKoP+?=
 =?us-ascii?Q?FGe8t97NlkGaLXdwV+Zk67SDEtqSlRb9lRZr3g29i4J5UqrNe9naEsiK3/i4?=
 =?us-ascii?Q?Qr64cR9MQfnvIkZTZGBuFtj9MkRK84hM04gV/q807K5jUmvj/n9r6Qh0p/Hn?=
 =?us-ascii?Q?dAq1Ykmx3bJyUvzPk2zg9fLzNG38LOIFJFomzCJnxBwLkQN8t0NUNA0fCCIF?=
 =?us-ascii?Q?9hBs69UI9K4SqoqQIp61gdebnyItKd2pgfAgtQrYz+mvZW8hkEITHTOK6XKV?=
 =?us-ascii?Q?HAg8oqIDBLgf5vlw8TrL8M5m05njjc7gmg2RCOAPv02Cm44jGJas4VU1y51B?=
 =?us-ascii?Q?X12ifR6p16j69lOy8kjg1vpLeHPsxaZ4ta3H1I31i5RbQYsosMeCmSh81PuP?=
 =?us-ascii?Q?4W3Rkh724gjkTl10MC28IuSitcPvC6nb9jy9BNJgftqCeHgGXWczqON+KuIm?=
 =?us-ascii?Q?Yjk8sUzcvyLkHCRoN6MOMHUaFjqBBTmMOOUTB50mO0Ex5FaKBy4WvJpP6Gm0?=
 =?us-ascii?Q?5zLpqsSayWC08YRJXyPgZvcbwSSn+gPwfH5jjPZiDx97qZTvSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:56:47.5622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a125aa63-9f4d-4f47-8058-08dc942332c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

Use the ptdma_debugfs_setup function to register debugfs for AE4DMA DMA
engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c   | 2 ++
 drivers/dma/amd/ptdma/ptdma-debugfs.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index 9ab74fc227cb..e472bd99e970 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -260,6 +260,8 @@ int ae4_core_init(struct ae4_device *ae4)
 	ret = pt_dmaengine_register(pt);
 	if (ret)
 		ae4_destroy_work(ae4);
+	else
+		ptdma_debugfs_setup(pt);
 
 	return ret;
 }
diff --git a/drivers/dma/amd/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma/ptdma-debugfs.c
index 9aa7a49ae5be..f2973761cca4 100644
--- a/drivers/dma/amd/ptdma/ptdma-debugfs.c
+++ b/drivers/dma/amd/ptdma/ptdma-debugfs.c
@@ -138,3 +138,4 @@ void ptdma_debugfs_setup(struct pt_device *pt)
 				    &pt_debugfs_queue_fops);
 	}
 }
+EXPORT_SYMBOL_GPL(ptdma_debugfs_setup);
-- 
2.25.1


