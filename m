Return-Path: <dmaengine+bounces-3575-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBB9AFF5E
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503B6283B25
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0E01DD0F0;
	Fri, 25 Oct 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kvPc8TT/"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AA1A0BEE
	for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850457; cv=fail; b=IFEoz3rDzpRepZty9Nzr9WY5+Asnu7Hs0+R26u26rXPfmjT0wz5Q/SRlasSNjHja3GTt6cLbvyrtJTZd017hJmV21pfnAZEQq+0Dbe2dOH5mYmkh+WAJgnyK3dBG326jshX1HOKKSgvptxQ/wkFgSq0ESu2DQvW2KN5FDI9p0q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850457; c=relaxed/simple;
	bh=MbqUvRDsAN8gMZp1fxQAcGCKd4anMvCLPQ+cHCwGhRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCXsLyhqQRdK7FrxiKl+TLSJfWz8FicgtWLagMjhtJiFSD5idAOlQOFx66BidBNWYbRyILTzQr6T8fiXiAmlQ+cxaKhT+3yX5GxeecbyLXPJDkgjtsWshAREiYifk5MowPCH3EanK0ZQyNl01L/CrTx+Fy72YNKfVvISW5P/K3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kvPc8TT/; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4+zgev2cIoiElGVFeI9mP3KnPukte3eXAQXqt4VDOJ6CUBLdWcxISICvdWQQSKxwNjUrEa8Zm1RinAARUMwyy5qEBKJ9mrmrrBxp/mzFJ09Wm69nq/zUL7JaP2mY3NQAb7OF1saBoX1Gqwf2eh3rrS0VDkuH0YMQKxnPnojn9k+k1L9p/T4FGlXWwSgRUSpJJQtd9GW2NZ0pxTZ3/Z/uXNswFNjTyhnEFOvGhYLHNzun7k5bM7VOVrXiwocsz2aPVSElCRRLY3l3BYBhnFk8wTz+vtNwRoui2Z4X70WK4nkG8qIvYkz7iDjrD2O7Z5WcV5UeCHjrZ7BlIsnkfK0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQuWJIdEWt1mzhpwQUdAvhK2VDzE+021RmHuYuEJAWc=;
 b=uKEYZls+VdVq2AOpIOOuj+Dmi+kOzINK0umt8kZZwYcod8WxRTFelt8WUzNfKjmcBsDGV/0g1Zukk/KGLQICkKhkFgFjMJTM9XQ76+3tNBleDJyqDMNJfM/cTKdK8hrpZ7Qs3MNbeZRuGE1aLJXoD4JW66yDscNmsIQ5dzuSplVNDw7khUYI/xbdBxeg1s2hPuOzGTBmjEVxvz45+yG7Ic9dizTlwBlXnB+SxCe36qzR1/2lWTKZReehsSH6l5fCqrKI/rnWbzCBQmA0Pn3g9DT39t9CdQ/OjksxAEJIhBe8dfpZYNTQqavuAlEJbB5hVMDWIXy7eDymy8E8uIFYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQuWJIdEWt1mzhpwQUdAvhK2VDzE+021RmHuYuEJAWc=;
 b=kvPc8TT/NAZc0f22POc4/AT0zUnr5jQEFLZSFgqZSwB2tczFdGWlDsCROGxtPdVj3OhJMHhxye+p1EToGeqxL5yGgk9x0aNxGUaLum3plrC2HHT0UXzgZnXt0u32I8BTdQ9o56ui1/2Tio2A95HIXkBGgmHWTwHlVIcWB3d7x5Q=
Received: from MN2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:208:120::14)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 10:00:52 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::ae) by MN2PR10CA0001.outlook.office365.com
 (2603:10b6:208:120::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 10:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 10:00:52 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 05:00:47 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v8 6/6] dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup
Date: Fri, 25 Oct 2024 15:29:31 +0530
Message-ID: <20241025095931.726018-7-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
References: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: c281732f-a218-45c7-c3c2-08dcf4dbe8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cOIR6DftEggOa+S4+fC5Fib1JwUexx/1TKlPD90vC2xNL3brPr1vkW2ozFWI?=
 =?us-ascii?Q?lI1f2p5GjdoEUVtYOjKDNa1gktN9b+SoaYZecj0/w4fzvk3lEWKVQwtCJb8S?=
 =?us-ascii?Q?K1UMV/OjPLsNZSfgyBiXecsQYEp51uq68xnlrtWeMyB9bBUw0fflnEgq15mn?=
 =?us-ascii?Q?7rQhLVGIdLHdLmX2bVBaks9CRF44Xsmt6F1gJXTt49L3A2Zyo6+Z9HzPpRMv?=
 =?us-ascii?Q?Nc5pUoQvEOVtWCVzUKGJTjzzcojcAbQobXpsANcQSdxaTZM7sqMVFFRUOX3G?=
 =?us-ascii?Q?vt9eOx2eEfGfCqSnJo2rTTpCaYsOOc1MoXQS60eTCV4X3Ghc+GsWGo917n1N?=
 =?us-ascii?Q?h3eZhnQXMYPdEz/V0MdkZGlcCIMPPXfKoFRATlLuLl4bK3BRvKMolsPrSpGJ?=
 =?us-ascii?Q?4NLqFJOO3Uo2wLOcL+qUtWAfYwS0SMeGd1BIOXTQCm+MCrjLxtheqOJWdYQc?=
 =?us-ascii?Q?M/mHVYmiDMeOY9NNOFTjWqXwMFO3aEGzeSYa1NhyOeH/IFJQqJ7DpABZ2yw+?=
 =?us-ascii?Q?0KCqPcby0+chQkXkHWL+cFrgQ7wvU09+P0E6H7F/gmDOZ6nmUEbZjYL0KnEy?=
 =?us-ascii?Q?iiwPzqibNhobZju6kx58oh0oNlu+FPfnbqYp1trjacHZPcAMm2JS+MlDQ92x?=
 =?us-ascii?Q?iL1S3NGW2ZCrxQOOSiSeGmLChOs4z9s0KWOb9/vHuhc+5hti8wRmlJ3xadyV?=
 =?us-ascii?Q?vcdyTdQwd7YQSiN4IeO5qZQrhEGcWOQq01FEpVlO4qfLcD8wzJoIX38AkVKu?=
 =?us-ascii?Q?W8eNR/abkklbsXWzBqD0f12G2K+MtUTIfQ5Rk1EXYr05Q3YaD0EBEvryVCzb?=
 =?us-ascii?Q?QfchmyurcLpOIwfcVnKa0QvL/rWjet+8R5MnemPOMPp8mzSsjk820u/Afj9W?=
 =?us-ascii?Q?aatwWYFVqwHfQ/9yrVEmSgZDSMjZauv6q4EdkZ8nYDVyIf4vMWNTeZtNNn1O?=
 =?us-ascii?Q?4pBnko7aqpOVcvXwGjPrT2QJGvIupuqSrvzkdcymdD+xjLavsdkO0OzmXRsx?=
 =?us-ascii?Q?95vl8oDXCwDykM13wXrxUyxWEyYVrWDtrmMY/BIacjWvpypV8oDWnM8KVvuP?=
 =?us-ascii?Q?aXTlDbJ+FaZyKZhm+wVoIcabU/TJaNsB28U3xorp5krZYOyd7kOHtIiwt9I+?=
 =?us-ascii?Q?x2qQ52ON31a8XQ1wWmMhisgEAO8DyKwISavchwDfrCypi1tlKt7+POhCsG8h?=
 =?us-ascii?Q?+T7yeFMNO9CJcJVwsMIRKpA8kd/xzH4WaZGWqwrwV7NMcSsSnGGiqKGwTGdK?=
 =?us-ascii?Q?JuXyRgXvgG/WwYddmm0o1gjxWE+4qbD23M55y1Uoh+R1nHFkiDZPz8T/MLZq?=
 =?us-ascii?Q?1AGA7mdF+6q6+KQTIdvqsOmYQLA5Qwu4ukgJFyrASWGn3mR5rUi8klgMGd9k?=
 =?us-ascii?Q?qqqzWzxypyo4L+1UB6sVEc3sBl/tR85YoStK/tME5rzBIKQ4ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:00:52.1373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c281732f-a218-45c7-c3c2-08dcf4dbe8e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

Use the ptdma_debugfs_setup function to register debugfs for AE4DMA DMA
engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c   | 2 ++
 drivers/dma/amd/ptdma/ptdma-debugfs.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index cd84b502265e..8de3bef41b58 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -150,6 +150,8 @@ int ae4_core_init(struct ae4_device *ae4)
 	ret = pt_dmaengine_register(pt);
 	if (ret)
 		ae4_destroy_work(ae4);
+	else
+		ptdma_debugfs_setup(pt);
 
 	return ret;
 }
diff --git a/drivers/dma/amd/ptdma/ptdma-debugfs.c b/drivers/dma/amd/ptdma/ptdma-debugfs.c
index 0e54060d6c34..c7c90bbf6fd8 100644
--- a/drivers/dma/amd/ptdma/ptdma-debugfs.c
+++ b/drivers/dma/amd/ptdma/ptdma-debugfs.c
@@ -140,3 +140,4 @@ void ptdma_debugfs_setup(struct pt_device *pt)
 				    &pt_debugfs_queue_fops);
 	}
 }
+EXPORT_SYMBOL_GPL(ptdma_debugfs_setup);
-- 
2.25.1


