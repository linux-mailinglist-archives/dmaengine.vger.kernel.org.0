Return-Path: <dmaengine+bounces-2821-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7618094BA61
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9867F1C21A1B
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D9189BB6;
	Thu,  8 Aug 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k6hTuaqg"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5D14884D;
	Thu,  8 Aug 2024 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111239; cv=fail; b=HS6JUdq8ookwq1G0abWxvkKONHtCTEMT4nwYfbnPL4ksohkBQBWlidyzhc5bMv/Sv4hwjMv4ezzhZTtnXnY4StNblT26ig2uhqR3TDkGFn4i927+SACBFkhTfORalmsEPpbo9ymuufj1A9u57LXziUoRe3vBIgvoYL4T1Sxlsy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111239; c=relaxed/simple;
	bh=ieApb1SNOy9iHRoHuYeXubzcfMkwuQDQSOWGlHL5TZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SGfxOCyViAzHu9W3q//LRYOGSmaYTFPaVh+jzZo7LpqysWqPBTpL5hxkuT5ArrSrwyz1ncH9XrxDtJRq2RAzgObDzxcr3qFGzSn4LDU98pcP+e7LkAr3Nqgt44iQiDNJJEfvmXoRz7frl2pXFSfFoJQIJxEvlLxL2BE26poqJUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k6hTuaqg; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6JFn/jN3WlK4w6a16VwKAH6+ju24H/XkF8ZmABcAOsKs6P/GpaSw1V+TRRn4yl7B6RBQRI4pQQtNu3qwzB/XraKwzq2Tia4oMQOorrIJ/Y/fR/2dPgF8xxZ3NCA2DIBZwup9hOYCo5CM9MomxUzBkcrDOqBc9KzYtCHzwUE/eK+iUUg6j3uwi+PfU/t55X0eFEf2zzdrLCRxR14T4AzK+BSLx7n5J7wgHhKZsgS5fHP10JdR4nEz6ImMpuHGQ3SHWOx6DeNZgH9BNuqtXCuJhXzXe5Z1uROF3uoOrpszg48n+MehvyhWfpI1Q/1LdzW2ax1E74G5wHkMFbdjJjVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU4lR35zr8bGLH/VLKpAbs2C4uOhZzKzf219zSA7AGY=;
 b=QbHMMS5VmK6EgX0OqK0ZiZNis0XPlKs69W4gJ04GAbiTOwszIHR41z35nFDflDiizLG98XxfHp1ubMHm42RVB7qEibGxkqeAGZcv+Sd21y6o4RbBcGCHzkv5kWM9WIQkXvPNqYFLe2GiW5lxFNAzzJe0hzvQUsfiiBgedKnx+CeO5oShVvvRhDJVTcyod5bLHDCrXoq4ki1P2vRtsdlPEkvk4bdjzr5KqUOdmXMQOF/i8iEyZfDr1eUg9xrSfTuYrh5kThGt7A2CU+iSo0uYdpKsOe8SJ/8CeGTA9EgAoErxTkYQ0wHeBKVHJAInu+fqUU+2pXowa+W2r8DLZ6NEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU4lR35zr8bGLH/VLKpAbs2C4uOhZzKzf219zSA7AGY=;
 b=k6hTuaqgynYeBq4WNfObF6jVZkGRRqxpYIxmjWcnwuxzryFgK6rHLtrQ0nf55LCLSmWk22ozWsJRv1qKM/viy1gIcPZ7FK/9TwWW5Kow3zXFm2RhYGajFoCsspW1zhIiTG2fOUjW3UAZ+V0PLMC+cKZIT2ObTleNBZFtvqHkvsY=
Received: from MN2PR15CA0047.namprd15.prod.outlook.com (2603:10b6:208:237::16)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 10:00:33 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::b) by MN2PR15CA0047.outlook.office365.com
 (2603:10b6:208:237::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 10:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 10:00:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 05:00:32 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 Aug 2024 05:00:28 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <radhey.shyam.pandey@amd.com>,
	<harini.katakam@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add support for ADMA
Date: Thu, 8 Aug 2024 15:30:22 +0530
Message-ID: <20240808100024.317497-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: abin.joseph@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 96874aed-d7c8-4883-4ee4-08dcb790f12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9jEu1IFfNa73vx9K//ujLYwkgOKkuwvYawSrkBwyg++6ImFV35lCtYygrKte?=
 =?us-ascii?Q?nLOE8Kb3dDy1Q6hioWeWSAt9vxAKq3ibL5WHoBFbN9U2sOFqpXC4Z14Gq2Hm?=
 =?us-ascii?Q?4sBJtcr2V24+GZ2D86ALNAcfFPw/BmnmKfiyLWn8SxILI7ZUw+x0Mi1SCQ7W?=
 =?us-ascii?Q?j7VPeBUGbF1nOGdKvxCnscwC808Ev5av0yxDYANjJ2CeLYNZqvyQD48AiRXM?=
 =?us-ascii?Q?+kRvlVpFfsU4JTAs0wgNDAqQ57zWDZlDDwl+82s0wM/vwFuGb0m6cBkM7xzR?=
 =?us-ascii?Q?MN7OfUfTtDoANFVOAzA9Q/66WUvzVtoS43I3CsjP44w1kl8Ju/Iz0Nx9BNQR?=
 =?us-ascii?Q?tmuvfiN98KgvGn1XiqJsPrfE2W3FzR0n+WchCnqMmGLWfxpFr7ZUEJlkNAcR?=
 =?us-ascii?Q?yPKbznimuLxQmKccCL+nZN00TPNrv1Eyc1++GqGB+1a4uq5d9SN2WJVl5KyR?=
 =?us-ascii?Q?MffXtZc8q3uyY53YBrvUB3gCdoACkFkixQipO2O15rgqk0OagqmqzHbzmf08?=
 =?us-ascii?Q?7IzRZrkWRUn+hf31gRwPxBJzo6TCq1qv+q/aEYWPgBYcGQZ2T5n+ENLHkBRU?=
 =?us-ascii?Q?40XB1tzdzvrASo8CNGILumxRJVWeE6vAjjPckITdS/MYpmKqxexUze0ynkCk?=
 =?us-ascii?Q?Qmn/Q/f9s7GSDRZziOjpCZd2XjFlkA9B8rUbV56gFjex12OKJnpnjNiyTsBa?=
 =?us-ascii?Q?AR3S43oXyN+Y9T77za1rPt1UGmmsbuH5mhDqt6nifsq3ULXiIS57EVowX5CD?=
 =?us-ascii?Q?j0zhJ+DKvTGmt0s3m9AEwsEqxln2KoVDvdv1HDWZMS9jgLFJ39n5jjna5h6T?=
 =?us-ascii?Q?6hkY6bDBvfKpoCi+ONWaazx8MMlVJurnDU/hQXxKusLtjqBe4VNr7mrPrUhB?=
 =?us-ascii?Q?BL/6DYIGZE/nO3TcgwvFy/+UtUvQmtULt/NtQ1+c8Qw/zkfsxOcjg/BVW5IX?=
 =?us-ascii?Q?kKtjfjlNjVNi0GElygEVJOEtP4WMO2dd1E76uK6dFcvEVY9Fv4MjQzbPx4Wz?=
 =?us-ascii?Q?8N8GRbCyzLW2VUg0jTYaqPRlQSzoul875ZoDnbvNQ7+5xyqdkjOq4mxq6O3F?=
 =?us-ascii?Q?FlabQTGyt4JtFWalfHytLwSvZCSF5m/wpPtWHIy1E9LXApU3kzrvaO+Of81P?=
 =?us-ascii?Q?STcLQQch/w5m60UQWXFs7AhMtzgF6otDl9a7LDbyJpod0qCVF5EXinkHrDhy?=
 =?us-ascii?Q?UGL6Vqliwkfvg2zqPGDk9v5AqDLR3A4orpJ2ppdL5necr6cf7Sa949+qCeqR?=
 =?us-ascii?Q?QbApopeOJXtkcNbOzpOyoBKoEMsmyXql58iWWJJJjgSfRFsbTI7wgpvVjL3S?=
 =?us-ascii?Q?XFe+EHCAABRM9NH7Ki8f6hjA8iawRlj4gVKzSZqcv2+WqGpnZnt3PZnY210I?=
 =?us-ascii?Q?XpSdVP/UxLhwW3EfyPKnBIsuR6WNUxrn70B+Jr+d4NfwGudE+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 10:00:32.8725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96874aed-d7c8-4883-4ee4-08dcb790f12f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

Add support for Versal Gen 2 DMA IP by adding a compatible string and
separate Versal Gen 2 DMA IP register offset.

---

Changes in v2:

1/2:
- Remove example binding documentation.
- Rearrange the order of compatible.

2/2:
- Use lower case for hexa decimal values.
- Update the logic to use of_device_get_match_data
instead of of_device_is_compatible.


Changes in v1:
https://lore.kernel.org/linux-arm-kernel/20240726062639.2609974-1-abin.joseph@amd.com/

---

Abin Joseph (2):
  dt-bindings: dmaengine: zynqmp_dma: Add a new compatible string
  dmaengine: zynqmp_dma: Add support for AMD Versal Gen 2 DMA IP

 .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       |  4 ++-
 drivers/dma/xilinx/zynqmp_dma.c               | 27 ++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.34.1


