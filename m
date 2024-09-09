Return-Path: <dmaengine+bounces-3122-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27A69719AB
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 14:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C40D1C22D19
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9F1B5804;
	Mon,  9 Sep 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1FV6nDJI"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132071B78E2
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885623; cv=fail; b=kv5fyu9cH1JW1BrMkSzpLBHqHpFBo8/M+2P+7MAqZn73zuWSS5IWjVxGyKUaz9zfX8D5ttzR7ZknrKLSrH77Tu0VoqzlB5sclcwQFP/Ba9fVCIjFfwRRVwlW/ySuiEmvtB2FmectAc2V3I1TDpRFbG0J3FyzrVU/EuD3uQglKOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885623; c=relaxed/simple;
	bh=MbqUvRDsAN8gMZp1fxQAcGCKd4anMvCLPQ+cHCwGhRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN6z0KP/kFYF/ozTaSSMI4CR24Bw5dypz7mV1rhTceoomsu61NXiipdUIIgEIgUj7lWxqIcdfWLgkptzm8+XgogjdLoh6lojUeByqsSRIz5nnt5BQoDjSIEj7bDTGWfPcCuodES0AoXhlQws6Sz4eI7wKRed34NBsAxqrPpRqqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1FV6nDJI; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZNMSd4aFQXBlNdVcVMidERWhJiIO4Hr23atH1VTMxnZdWGsubGNoaCAxoxcsmWO/0rdQcQ5WGLnRCqfeTXIeasGdAhVVyQHx1fNryhPmb8zeD0gwA4IXRN7NjI0WNiS2PQbnFdYMD7HoKaqqJs8T5JyduWmMo0rI6m8VM/8cpTQcdvpMS7U2TNpSw3CQTXFKrhLHU1+kAfpnovP2YvHCVTEFN4hVoYvXLp34OZVyCdIWdGNaH/XYov1O+tfClgBiX73ZOi6uy2f7Cb3sEUV5r/XPNDkExkAgRg4cnjiJl709ysQJaufdzseIovb7qw2b390EFep9lomfWQ0+Qx6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQuWJIdEWt1mzhpwQUdAvhK2VDzE+021RmHuYuEJAWc=;
 b=fMZ1N4jYsS90lScMvqcOmRAa/NkIFnrdqUHhNr4zUwKt72K/Nf26LdoQZAeeRv6Au2QkGI1VFAGVuNDgU8YP0I+3g4QbYvXrTD0nvCHwcyDXgao+AyEsL2Uu1iAxjyqRwE77O6S+VBgeHIAQM6nm3Z/UhHPl7cPMUpR/FloaQTYs32//TPNDX8jXUQGQBGNoGWuanomrp2qK2bHB8CfZtQ4/3ot7/gS3dxMM5KOlsWVLb52YgUnqgL7ABnVlzc4vL5QhDUjHYZs9Q6jK2y/IylPk1j+//vO/e/4W70khviUpnueTs+GsocgfJ1kjfwfjY1XAtPsgvQjDcIzd2xnatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQuWJIdEWt1mzhpwQUdAvhK2VDzE+021RmHuYuEJAWc=;
 b=1FV6nDJIk0WWl/9PkrHSlvFtJxthFa3IR8drTHK+aQB2isWMUrNh9ZZVnMwH120ng8oIa0FVcn82b+Usr5ijW3vGRPRSj3Znzd8E3MVQ4dXWEnQfubUKwGTI1fB1S/0sl/9vSleGN8fDSS8v7I+B9FegAZ6nmwrAn/6FuuK5W48=
Received: from SJ0PR13CA0215.namprd13.prod.outlook.com (2603:10b6:a03:2c1::10)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 12:40:17 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::63) by SJ0PR13CA0215.outlook.office365.com
 (2603:10b6:a03:2c1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 12:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 12:40:17 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 07:40:14 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v6 6/6] dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup
Date: Mon, 9 Sep 2024 18:09:41 +0530
Message-ID: <20240909123941.794563-7-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
References: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: a268594d-55b1-4e86-84b3-08dcd0cc8f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NHzUKHzesyqX3VtlZMUEdYNwDuzSOnBFfyFfKcNwcAOS70Pa+ihSHeBCjUMB?=
 =?us-ascii?Q?k0TBOQjkUDySiRc2rrl6Ck0LMeuEZ5R3OQ1bXYW9Ld7D7WzV4pUDFEEzk5Cm?=
 =?us-ascii?Q?BlFsxV36yAWjDKn37+ITxVC2wpM8HJ1yIwc3+Sf/WTFaODV6J0UjGIO1CuMy?=
 =?us-ascii?Q?tl8sHEDNbiVB1NULuQvfCQeSfOaWgqOF/MtXpkXLtQIZVymdlmI+qGmY8p9Y?=
 =?us-ascii?Q?wjkILBf+oRw7kfKQNs3IWcG+AjFHomNsRAQC40D5UAt4jgCVq7oWUlB6O8NA?=
 =?us-ascii?Q?Elt477bk77ic5DSppDjcVH2GzLGMTJ4Ud8B0B0OTXOBaITMVs5nSx0ZiMBW5?=
 =?us-ascii?Q?MReHQmLn02lT54IEW/AySBP+mA4NAvPechtAQMpaQAVWb/rcA1UfgnnG7SLv?=
 =?us-ascii?Q?Nksf1VbbpcDbvEwzBXs1Mhw6Q1eWzLIEPqbrSt2XGqTATLHiEi1jd0xsgW8g?=
 =?us-ascii?Q?DgdsXfIP3BZPWlwVThP01W4CKM06RQ6iNW0VUd/wOMrcQulH+/23lCVuXOkx?=
 =?us-ascii?Q?B0Usb4fNbKQd7FK5b8q43TWH/WSs/1gA0r3giQAulLvOpPnYwkD5Hnl2asfI?=
 =?us-ascii?Q?hnhM4rQvAWtx+XMlgREYzPVUhNTmD41gy8Zw/Kn8of8KlZp1iezx/Y2cLslg?=
 =?us-ascii?Q?6QkwIvEEt1VlCJSR76ZceZiII76Eyk9O1X4HPiasmtzTqjaGU7IvS0z/VjAZ?=
 =?us-ascii?Q?eqrboImB6YZlcsg9vOUbzMQF+2A8ZT54fpUocYeUIxlQyT3rQLArfCDSELr6?=
 =?us-ascii?Q?s+UA6Ds31DD5SVQA/Iu34p4JmNuS+jcXHi1UQw28lZBo2yFE+fAinbeIYKIu?=
 =?us-ascii?Q?eyA1i/cQexteuHsO3VvirEZc8DifxKFOW8gMqCtuYmGwYZff3md0poJDI7Lm?=
 =?us-ascii?Q?Fg7Pbqu94MjMEtJ7LwzXk4UUUdvNXygfKYS3RXxT7MFGqC0lg2Wwj7IvzmWs?=
 =?us-ascii?Q?ceJL6xZOr6yBVQ8bKd8qALdQZEgIoubT3ALPf/keGoU5EIyOUt8g9sLS7fDw?=
 =?us-ascii?Q?h7n+CsmEjdFBFbzuG3rlUJSiGZ/wN/1tFwmVu3NpZxZKGZxqGbqq9MGDC9Jv?=
 =?us-ascii?Q?oQM8x1nWHjN4ZKkG2ScBjTBkXe29SMPciRyl2s5GjzZgWwS1kUKdymgzwA+h?=
 =?us-ascii?Q?rOjDFJR4m0qf9DWFuJIr/Llx+MAKMs4JZ3dgmES2uDIIj07Cf0mqn5qYcv6R?=
 =?us-ascii?Q?erJsokm0rXqqkSOD2l1300sRCqwtGjClsrRS2X4AXGZsFPiyg1G+GpxcsrAJ?=
 =?us-ascii?Q?vTug5L45OAgGfVKrrg/nMNc5YlLBVd0TCRqsxko5FcorDkZH5wpMXzyAtXTx?=
 =?us-ascii?Q?d7pwFIGig4lgFawSQxdIEFCgf4sTPXnuHNYDn1Q8hFYGCQA985bnUr+OMrIJ?=
 =?us-ascii?Q?2wxfkIUJNMF8uSjIXf6br0NdGazXr3iq0SwXOY2qhYlYGEk4l4YnI41sisFS?=
 =?us-ascii?Q?G7q+8r5IgAc4bwQ3wpaCh9+xzwt7gTs7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:40:17.6168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a268594d-55b1-4e86-84b3-08dcd0cc8f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

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


