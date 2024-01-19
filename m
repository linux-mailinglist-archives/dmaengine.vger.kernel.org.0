Return-Path: <dmaengine+bounces-750-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D541C832534
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 08:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C43EB24917
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12996D52B;
	Fri, 19 Jan 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MVptqaE+"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5BD51E;
	Fri, 19 Jan 2024 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650325; cv=fail; b=DWpNVOQcz2yVXfoUS8JTll1dZuZG9xy5940WAzj+8V4cxonN+9NC3/2fW240WWyhO4kJZWytWJUhkcG5gU/KKktc6zPxcw09/DPfSWLra5dboCuVMinoyQzLSV2xj54wdY/WCXqWVNnAZBxm8OX2IlGwWUriwFDUL3VFNX5Lvnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650325; c=relaxed/simple;
	bh=gYBgZ/cpMoKrRAHOde9UxyTR8fislYrrHpH0m+FiBwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iMfr/2thw/YCgFdBWsZX+4xBFskLmtnMzBW+YFo3cQ8jerG06WzwGtPdAxdZ9NbQJZifgoRAcdmBl3+/hvUKIq9aec36d1x8xbRapSmp7HY5s9M0PnjNpM63Uk4g2wXjs8AUA8DnS7/4O5DapQV85+CecQDzxJaBA3VL0tmAO3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MVptqaE+; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEuAxHRtVmQPU5ePVPpItZ8SiWwrDmmuvJ1GX1kls6euv07IFUCWfjjxN0dqxm2OTWpa764tpMDvRWNo6ZUIotm9QUB+TQ+bPXufCgr/dUs0gTiPqC2h3hWqdLZhOmlygyNSl1u1WbJHD7x1ws5Sfna3C4w1NVGx+wo3ssQu/Kk9aUMVVYRv9Ylq/LnQO2VQ2o4Kc4SCigh7T6kCu4pXdzz7wBAW5eZO8+h+LaefIG2rz1tb7SnSfWgwG98ARK8nAZsfoSmDBoi20NLEyrHjBRwIymonZS0gKagDF4WoF3ZsacmkCdh7AAAMU37oOzmBxRYobSYFfonURhLjuCB34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r8YrP1yEO7N2MteRrR0X9A1NcJ2Y+O8PiLJqA4XH9E=;
 b=P9ovhrQCE/4W3BCkrwVrI93wl8a/8WdXxG227jDIn+BALMcV2o6YuRe8/Ijg1oBCQGFoR0ZpGse6BXmvhv+qxNIH0/MXSbUHbG1O+kpuW7xLjoomaYvoODbZ/43IXvDZiXsQf1H4MnZxCMpsPoxbDxaMiNKSmkM67bkm9KW9DWsFshPc09+CUiL0EzLkZdwJC5CxGTvJdmKLmKFzfeHEMKAWaly02NyPdZao9y3vTEtw6mxzwqyEDcqGe8wMHQnI+vYuhkyKdgXE0Ce/SuwTtD27iP8QEQp25LPPOIjb0GGhc+f8VbOZz9AFtWDvYAU2cobUwdVgKIyixl9MKy8HVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r8YrP1yEO7N2MteRrR0X9A1NcJ2Y+O8PiLJqA4XH9E=;
 b=MVptqaE+cmfnNBYB/uAcfzqkL3KkWCxoIgKTF6Voa7yxKSwRC2B3jWo53LdGyeI6EHvm82LE7c2dGmSniisnb5owz6a4HcJcwgbzIXiI0FZBGsgIlTvcm/CRmNHG5qxau/JEgY0rjwTa9Uv4uHEadp6Ylqkl6+S68KErpeE+pnA=
Received: from CY8PR19CA0009.namprd19.prod.outlook.com (2603:10b6:930:44::14)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 07:45:17 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:44:cafe::af) by CY8PR19CA0009.outlook.office365.com
 (2603:10b6:930:44::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 07:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 19 Jan 2024 07:45:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 01:45:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 01:44:35 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 19 Jan 2024 01:44:32 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <vkoul@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Abin Joseph <abin.joseph@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH] dt-bindings: dmaengine: xilinx_dma: Remove DMA client binding
Date: Fri, 19 Jan 2024 13:14:30 +0530
Message-ID: <1705650270-503536-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: a361d57f-46a2-4128-9c33-08dc18c2943d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CdjQ1uxhlx+q17EM6Pj9MVD4r8U6Vn9mUozCSBWZiZymKnhT3XsqPrOWCUR375yfqI7ajFMUIRCms0zrRkT4hT9ywNlhx1MpTsfLq4lw59E1I7ZPSyAsNt1bDejYk1H1uYCXC26CpF2WlXjpqMAj2uXhh7e0K72N66TCbMQ4RqrXoDN1Gh7+jDYoDnD3MxDVkCbQcJXwtPm84RjUAjlD3LUBDpSGQ24URKh+osp/2ruPnAk9sjgVw2QbI8wZM+nkR5BWi0XYzBjelOQI6LJjxrbXl4K64RonCdWnB7URrHElm1KhZPjUaVvEQXtlhcgySJxn+XXSeslUcZkwMiXJ3COYYbqTJWvASVketx9+s41SeI2xcHtw/ApYoYtgH8IthuavTqtSnrKDcLsaHZtoVTrhhXU/W0vn7FMNkosHH6mS3mFiUb+K7aFjaLZ2MV1Z6dxLuv7dV5JZFxD2nTo6ZEE0Wg4MyqcCBVpxeFi41imlXad0KDUB16YYDIR+ynIvA7sllQbGo7/vbXJZSyirjJJllGxmhSm7tiIMjUROzk1e8A3OMsSJhJqChplNJ61b1QYpOTk2Z1ikHwkZ9Er4PkRIPP3FVY2+N1d8gbPe2OtCaUu3LrDwLSX3rZPmMiYts79Ojh8Mvmoo3QUaCdCFdhKqgNw3zYusZ5THcqt8aUnOrgpe5rSsB+OL4zckQqHDS/H8Cc66mm19xrDEywbIZ6+0cwopqAVdstSTrLZwnwsTBSldNwDdreE/Vcubyt/xOqUtpN9qmZfJTQPXb9HGYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(40470700004)(46966006)(36840700001)(336012)(426003)(26005)(2616005)(36756003)(4326008)(8676002)(8936002)(86362001)(316002)(6636002)(54906003)(2906002)(5660300002)(70206006)(70586007)(110136005)(41300700001)(478600001)(83380400001)(36860700001)(47076005)(40460700003)(40480700001)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 07:45:16.8461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a361d57f-46a2-4128-9c33-08dc18c2943d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306

From: Abin Joseph <abin.joseph@amd.com>

It is not required to document dma consumer binding and its
example inside dma producer binding, so remove it.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
I am working on txt to yaml binding conversion and will send out
as followup patch.
---
 .../bindings/dma/xilinx/xilinx_dma.txt        | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 590d1948f202..b567107270cb 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -109,26 +109,3 @@ axi_vdma_0: axivdma@40030000 {
 		xlnx,datawidth = <0x40>;
 	} ;
 } ;
-
-
-* DMA client
-
-Required properties:
-- dmas: a list of <[Video DMA device phandle] [Channel ID]> pairs,
-	where Channel ID is '0' for write/tx and '1' for read/rx
-	channel. For MCMDA, MM2S channel(write/tx) ID start from
-	'0' and is in [0-15] range. S2MM channel(read/rx) ID start
-	from '16' and is in [16-31] range. These channels ID are
-	fixed irrespective of IP configuration.
-
-- dma-names: a list of DMA channel names, one per "dmas" entry
-
-Example:
-++++++++
-
-vdmatest_0: vdmatest@0 {
-	compatible ="xlnx,axi-vdma-test-1.00.a";
-	dmas = <&axi_vdma_0 0
-		&axi_vdma_0 1>;
-	dma-names = "vdma0", "vdma1";
-} ;
-- 
2.34.1


