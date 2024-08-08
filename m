Return-Path: <dmaengine+bounces-2822-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D58094BA65
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE0CB2226F
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7249718A6BD;
	Thu,  8 Aug 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3pXWljTK"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA918A6AF;
	Thu,  8 Aug 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111244; cv=fail; b=SVJNnfGK/kFdb7uwg9UPl9uucb1hpxcF3vRTpPtj97dRA8FGVt81EhmjUg2cnshJynR0wiBJMkLjFFwSzIMVTeJMk3HTX1XeqnuWK8KhX2Afjui8/Bi8hdiSNDk2FJ57GXHrZR6Yl1LadikDjEM6q3xoJ8FtnUJB4t2fN6zN64A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111244; c=relaxed/simple;
	bh=nb2bmblazuCTcawRHoDTucyubNdYuH3jyUv36xxUVQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIgzBloten0o98j8efG33foGpYULXIHnvVTWwEXsFXKZNKE6DnW3NtLhuCaI+kfE66hvn/a2cFWOA1UiPB8Rls8gUvtNMcRx3eak407FZSXUeVnlWQh954ypvPU0rRe8v4CjbjyTAn05Gj76pDAPuFOqKwWwwjb4nSHVi6SKm8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3pXWljTK; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIu75r4G6t46IN44580inXpu5kHhlgGv2/hl9ByC4ZitLGNvU3JcuSEeaSyraLr/4Pk+QH+FLfZQvdj7CQiLL3T+IjdWqKlLQZSIdvGNX9uhfgn1/aNco2Yuj+6Z4gKFEYqRDHP2WVmy6gcmWo0kPZzqlvDjhHfjy/873tc3Nh+Q7bqWS2T28oA2mPKwxMy6B7ZObjuoiNbs9HTbxobDuObf1wi+YjM8c4p+vpPW1DMEKiR6RfSLEprzWI6AcNVBAprPzjNyGwWXSAb0Xp0cU8CZUFCZAo0hIcdwn7PYbtdRE0S5bS3QP35CPMAUkQxCrFWNLPY7i03DJ0BYKUxw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpkcGxhpw6JR+7r33OG6nGJyCv9tJM/gLhiSR2lAO4M=;
 b=vBY80PEu3XBnMKntxAy1EiLuqMzNgrEYIm3Zf5eIPHvbXKaemPxzjGsDnbyoqbIvl7JIKts8o787qZWo0/EihxJd9jkWxAjscsiNjt17N1sbiLbkJIwwk2+RcXB4MZCM6zsMsA7BeHgLnz/b+LMtujw0GYc8s7PcZ0JoI2bVK0hO0jXTtkeea+kOuYsdyTemPYDIKRjX0Ai7uM84OCi09xCt9GWssZYE4bZQhBzsMSh7I6ZrsBU9ZUzF0VTrXHtaNONxq3jJKsRBuL19tj7VSABvvxMwX3bNCarwuQlaFywvEAAv0smEfbyGqjh20SxemfZycNE4tE94oNWtdaGXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpkcGxhpw6JR+7r33OG6nGJyCv9tJM/gLhiSR2lAO4M=;
 b=3pXWljTKOvdOC9R1nR0X92KjH4Q5a1Cb0nWSf54bfWtLb+FzHv0yhLJ9Lie/JfXVFYjUG6E0HfL1ohMXBNmuDLaf9xfO474zFKliDJ1FZswSPs1og1nbQ8JmEEdRfNyNVgpT5z6c5F2O9K2q9ikEl2C/451CR9atoF8o3dB/Syk=
Received: from MN2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:208:1b4::26)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 8 Aug
 2024 10:00:38 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::b4) by MN2PR15CA0013.outlook.office365.com
 (2603:10b6:208:1b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 10:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 10:00:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 05:00:36 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 Aug 2024 05:00:32 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <radhey.shyam.pandey@amd.com>,
	<harini.katakam@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: dmaengine: zynqmp_dma: Add a new compatible string
Date: Thu, 8 Aug 2024 15:30:23 +0530
Message-ID: <20240808100024.317497-2-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240808100024.317497-1-abin.joseph@amd.com>
References: <20240808100024.317497-1-abin.joseph@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 696b234d-c63f-4777-6f3d-08dcb790f453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ohev6pNXjnxekJfJbfTINCjo3q6hevSwXg6M3DuM/wZQlVXUNMJ0/GHgiBWt?=
 =?us-ascii?Q?S7+p7TPy38XcZRnfDasl17ndAhUy7+FGPPUmCZP/nxqjsc5IVM6S6YpS1om5?=
 =?us-ascii?Q?OPJiq4Ls55Msgq7BpzGieCEAj8rEl/8qwbBLi1L950xxSdFY6untMqTeiUxG?=
 =?us-ascii?Q?6Qnx3GcqZWfb2RXdXwLJwKqPGloa3ejAWAvHODzTBMHMehFDCM2wT5a7/tTd?=
 =?us-ascii?Q?K7erv2rnMWRAF/DW8ahu4RhdWTS6X4yxlozxITgULAxaGuJRQFgoMa6QJ4N0?=
 =?us-ascii?Q?AWr7ZIq4gv9qto0CIKzN84XCXF+76LIIxDnDDAntNKVLW3/Z0v1G6arPshGi?=
 =?us-ascii?Q?Udk8cOieQAwNSlPP+mwTeeGEq7h9zCUYORp+c2OG0Bk825pEyi9veZ9JuDPV?=
 =?us-ascii?Q?4nbIAh02whuztcnnlcGzbZX+wC69tmpa0bLpTOtxj7NzO/G+1GJ3aHM9qAh8?=
 =?us-ascii?Q?osmGW5efotXprVM1LiYBZgr4LVmihAKvoOC6U6yN782dbkDW4OUYwn+afA7p?=
 =?us-ascii?Q?qwIp7Uazp0XIARiYs3sTI7x95ZVif1ph9egmF7hlKbiAK0k6YQxeOzj6Yr0O?=
 =?us-ascii?Q?82gxGsk356yrFOXeSzA2wsKa0aqnTNYHGuYaF8jyG8EtW8nFle/lk6V2Pl23?=
 =?us-ascii?Q?Tj/uvZcXjdJNsJ7l2AxmwMb2TWphrQj95dzyD84QS0QsvcVV2WVY9uyevdsn?=
 =?us-ascii?Q?cft9HWP9TKUE4bZur+csgbT4468W8VKUpiVd4UuyZEWUTcaNCc2AN57DA6Rd?=
 =?us-ascii?Q?bcqUjMLDBaHZEmVDck0u5oHk0HzNTLlJCIRwKRYaKiFvOn8ioVQFnl2J1ifg?=
 =?us-ascii?Q?t3SXybbLi/zOltepPg4+PQIZHnrPwi9ZQoHWnda/HXNtn/vloA76ynqRSrFa?=
 =?us-ascii?Q?04byp/5xkaoWq2pdL2MYZmz9p9Lp2AlCsrLQ9bm+Vh5xlUeua7KXC1XU35zQ?=
 =?us-ascii?Q?eujvZHebtcQkY1iCFNNQuYq/wybCHbss+zSULyk+fW1RYav5/INsetZSrFmd?=
 =?us-ascii?Q?513BuadfvfSltuV/XRc4VbmgU8xseY/x3GsP5Mvu7dPFI9EHLm0KlTEapYha?=
 =?us-ascii?Q?Lk3rgW6VPazkevNg4NWwKWH2ZeaIkW5D19QAGYq2zpVBOt+IuEMNcTgqAkhr?=
 =?us-ascii?Q?8qDVRgoYkIcQ9jjUBNfPmoEiyOTZQ/tnmsx0KKjgvguVY0ydhneu6wUjmqfA?=
 =?us-ascii?Q?5D2sOR+DJPr0qfaqGx6IcDNYa/xP/39jGbkffGLDDOdcH4NGLFCCGDHxneCQ?=
 =?us-ascii?Q?oND2TWarDtuPJKPX08jnV0TE/pr8nVXtiFEim0+tyVc+iu57kku338rK0Ym+?=
 =?us-ascii?Q?J9DrE2iwNU/4a3RwXX2cafLWYN8gCRxMFJqKQP5Ly9iGCVg7xORMFW4bHUo1?=
 =?us-ascii?Q?rb6K3b/P5Rr/zIqEhtXMM/buvZjb5Mva1sh2CdJ5sC6qWpIV1G66q66JYK8N?=
 =?us-ascii?Q?Oa1BEBnx8rQk3TPan45gmS0VpiqzdJwe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 10:00:38.1425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696b234d-c63f-4777-6f3d-08dcb790f453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749

Add compatible string "amd,versal2-dma-1.0" to support AMD Versal Gen 2
platform.

AMD Versal Gen 2 has 8 LPD DMA IPs in PS that can be used as general
purpose DMAs which is designed to support memory to memory and memory to
IO buffer transfer. Versal Gen 2 DMA IP has different interrupt register
offset.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

Changes in v2:
- Rearrange the order of compatible.
- Remove example binding documentation.

---
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
index 769ce23aaac2..ac3198953b8e 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -24,7 +24,9 @@ properties:
     const: 1
 
   compatible:
-    const: xlnx,zynqmp-dma-1.0
+    enum:
+      - amd,versal2-dma-1.0
+      - xlnx,zynqmp-dma-1.0
 
   reg:
     description: memory map for gdma/adma module access
-- 
2.34.1


