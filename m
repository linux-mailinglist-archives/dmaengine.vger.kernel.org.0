Return-Path: <dmaengine+bounces-3439-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150F9ACA1E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA081B207D4
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE041A76CC;
	Wed, 23 Oct 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VFU/hWsz"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3DF1AB51D
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687019; cv=fail; b=E4ahqCD9AgiL7oexVZwUS4t3yv+ikSUbCG1eanqS5XCWk4qnqPaEgkBkApNZIh3UD5zpEdXPBMsLUVd0Ik/yBvkNGmaxSPlJSHXjE2bAjcr6bUGvf3lsT/sa60XBZBA44XwZ5ohu+q4NIrIndOMMNPGvEN1ooP7StMyxMGjl+Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687019; c=relaxed/simple;
	bh=MbqUvRDsAN8gMZp1fxQAcGCKd4anMvCLPQ+cHCwGhRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvWmu4v5VRXLkri4emqblxFzsKxmpff3OQMt9RLxYmgqOT95LrDMgHxa0Gp0hvRzmDjZyuCdScr6IDWjo45v8BqXsNYFNQg9jP9VSoIXulLf192c+9ZEyDWxV8ZNMdEedLuX2S4Nx/bCuCG0x7SpVwfrQRo0KcPETydaQElH29E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VFU/hWsz; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbmuj5aBl5AS/pRCOnyi3psW5GwaMczE7FIwchMOZ1znROuFhE4wW7Kr8Gn0clyHLZXi+vAHb3ylz5QZrypysWsNVeVtExluOKw0EC7vBXZ+MiUFzp7XSMmAL+hlSdYcUOb+zYkvimgZy95Jw7JQL3sQSsQLcY9si/B3XoqRKrrhk2KrD8TK/UcU8StI/qdO1HdrssNwMcV/b0fCfBm6w1hRKLdJMPxvia2Bfdp34Fqbn8DtMvbQ8n3XcFNAVmO6aKy12cxi2hExLZ+Qhz3DN9Pto81UUf40M9zOWaPCoRYKvSI4fcwp/s9kCRc8nCoKWkEvoaUuusspr9PKUyucjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQuWJIdEWt1mzhpwQUdAvhK2VDzE+021RmHuYuEJAWc=;
 b=vllNrxJ7Hdo3NjTJLWQkJ8qWm1/uRv7nCx6MwR2Stw86yOKyb8g0mWBfT5sWGbKD1GDngaU70/xClH+LVTspvpS5ev0gqLwL9BJ3MDRYgLfuWQI23O/jtKso1cKvDAjlhHy+x03U0eIMIDgrQNdhkUb/ibLJL2GHjtm1DMJHu/riX39i06f5W49mBddWYpU6mhuyQEumWa+NtEdYe7uRfaH272b+eN25rFsVdd9hyoJK5vcol2UCNar0x2QSEeyYhv13gKMigfAyefCheNXJz9vhsbxcj2t67kQsBa4VoSHd/cqHNziqEYtIj+EAfcpEFMoamTF6ejX9+nABCHTysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQuWJIdEWt1mzhpwQUdAvhK2VDzE+021RmHuYuEJAWc=;
 b=VFU/hWszpndZ7pp7q1NJXazaIOZu/XZEIc1pdUAZgWH426xHSy1NbuH+s4N3xfsOq+5KRIKr8qiu50QqfGxA6TGMGddCNbN0LnI6Phi7ibjBrEqx6AMmFiEspzyxpVZr+5H6eHQhmz1gb7XYyLdbAlecovCNK8WXdS6B/PTOprU=
Received: from BN0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:408:142::11)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 12:36:54 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::b5) by BN0PR08CA0010.outlook.office365.com
 (2603:10b6:408:142::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 12:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 12:36:53 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 07:36:51 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v7 6/6] dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup
Date: Wed, 23 Oct 2024 18:06:13 +0530
Message-ID: <20241023123613.710671-7-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
References: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ecd652-88bf-4fc0-39cd-08dcf35f6011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+GErJBE7LYFAQx6zqSLze6UCS+PIzdQZL1PyKYB6dU+ZMkC7dkHlp0snGxwp?=
 =?us-ascii?Q?u2by6T64eAyFD2/XBTBa+aa0JdPjw6yhxrCSeAspM5apQekJqUFcFnDk/vQj?=
 =?us-ascii?Q?QKctAOyg0P5BhmQeUlMA7qKQiJj9nsKEtfIalFFLQ693fruEU6QmRWH0wuOW?=
 =?us-ascii?Q?Y7nFNoDQbAhyTp/7F4z2EWL49lQpPSmLanmZZCqn3CzVDr86uxrbhBgla916?=
 =?us-ascii?Q?bT/jLt2hRQCNaL2GQtpaBjCDJJqJ/OpSS9zJQl/20SfykhCmn88CsJV6eFVQ?=
 =?us-ascii?Q?I5z9+OTuXxRvyrzo8X+xcn8tS/xfIK5DoGYMdSmeq9dJnKWawG+8plKKjg6N?=
 =?us-ascii?Q?2xzlcZ/gyzX9lOe96bO+lu8QkiXxqfrH42X39Gl8Sg4+9+VCEl7WQUFilLZK?=
 =?us-ascii?Q?gLroasbqximXPrcR6CZV5A5X/LVYaP/JpSIxLz88irAnGTPHOzQ3F/SdnUTN?=
 =?us-ascii?Q?RnBCKoSs1u1BYk1uhwfdCHK1gB413LogMca8AW4S/2IcTQY8oDBxM4uWs9bO?=
 =?us-ascii?Q?LIF6qOD71YEZ68fD2JhikvSdtGpZtdGR0enyaObkr+65mYrL2PD5xA0jIhfw?=
 =?us-ascii?Q?H0dRjzTzC8mbpzEvfAMbGg1S+vHFePltLTy7WK28wD5UVWZ8DjSQvMz7DYUU?=
 =?us-ascii?Q?5oXmQz98JdfYIVjxnQzGS4n9fMZVTvc5iNPWls8rlfG66T6O0mc2ZjeVKDAP?=
 =?us-ascii?Q?BaZaaHMT/p8WFegktv9QxSka7clad5DFyQ7nZzRzIVFH1nNxtBL6hGg3cvnO?=
 =?us-ascii?Q?RCpMcb1ZjO/AOb+oiJ7dNifGZr/Uk2JSUaydrKd+O+G2LKHnlUTLC36OeGFw?=
 =?us-ascii?Q?jJky9XRwGVaaL7GnoEyWpzT+4+iCWczFqgLid+L466mE7qAvuvsfdYyV427Y?=
 =?us-ascii?Q?nTwuiLtxVPebgzRYHhqqikZqbeSXWVYEee3zR3MOi5Xn6H5e1gegim7Y8BIP?=
 =?us-ascii?Q?yvaT1VybCwgTxnr/+oMYL1Hk/wkcBY1BLIxaAH6n9fAS3B+HPOW2UmreFB5N?=
 =?us-ascii?Q?fh9+SxgzaP0jvBWegkmX00fNT79k+d3nnojeo72XYg9nUonOwbZHqvKNL2TT?=
 =?us-ascii?Q?FwlcfWzFOk2yyzW0c1XzZVjDaHihNUN9fWKSL8BDAOF9hkUXW6sOfzgZqS6g?=
 =?us-ascii?Q?Zj9O2Dxa7mM//4zYJoYvE1fdbKQDYBYrWjObBWdI8NPcj7/mQEP3B2dUb+Jz?=
 =?us-ascii?Q?Sy5iY76jF9g4TmtKNL3GPPyW5OSn+r7BUmyCXx3sRFlMw5+XLUnkbNwuExBW?=
 =?us-ascii?Q?IOLmcmGT/05R/0PdsOz55jLp97feWlhucmRPWXcf1Zcpopxo9TbQgtRu2B26?=
 =?us-ascii?Q?G/44lC+Nop49V2S3e3h0nmU41ffQXUQ8uTTSd0f+nInHDZ+5bC7CTFvYW+hZ?=
 =?us-ascii?Q?5xikFnoqVX6hogmnsUhnEbRntOKUDeuAi0RCe44ZjA6rtfrArw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:36:53.8170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ecd652-88bf-4fc0-39cd-08dcf35f6011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

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


