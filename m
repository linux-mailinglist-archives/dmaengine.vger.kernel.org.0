Return-Path: <dmaengine+bounces-4258-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6891AA25FD7
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 17:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A3D3A8981
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3C220A5F6;
	Mon,  3 Feb 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f1AUfaKk"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94972080E6
	for <dmaengine@vger.kernel.org>; Mon,  3 Feb 2025 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599940; cv=fail; b=ipiUVbR5vvpG11LTaksWfo38b9d90T+1CWb+mEY24T55G9k2TWSYekL+JWxL58BqEN6Yi0nfQWwHD2dqYVt7SjFS0mP3nSyiLim6VHBq4sIy674zH3/lq8Bh1hVzDsAx7UbCWI96SYt4R7KPgPTmHBf6J+QBs9RqFxioNdk/tWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599940; c=relaxed/simple;
	bh=OW+/XIGMBUP4xCng557adUBm8mA17PCPS2GPbKpLM28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHeK32ioH9xMQKjOYDsedEwRVuZd4RTlyWwNmDVeLHiY//CQ72lXpXGlXeHGT0xsWMnRTeKeWnrdhi0k8BYICkdggVgFDxFj2NkO/61NDnYVJ/pghAUMNbj+WLcm38djLJrOUiBsvESOEkz5K1kO0Wr6LXY2gkTc1UGhjVx81yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f1AUfaKk; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXCpasqzkqVYUlXecniGb+M3G9hn++8XoZvwtyE8t51BFQgQpZ0xvOc+a+XRWp1Pdlq4jASRDtHlkpjSYEOpZfl2sF2LyYHiJAfnD+fRZYvGE1dGDKB3fCYqNkFehydTuailvpmfKUbOKjjSqK2yHjBvAz+mYOOJVDyIMJz6DoaCCsYUCmewDf1NoE4L7oqGeWd1PLptRMO3xltxfWvW+bNsxXRc0IloaLdly8qhqxb004lvx2YkXMrSlOI7vzk6k/HFwRQk+eK6c5RqXYf2zA7q5Nw9D0sGcLpDusoo4UB7PJB4utFgrmjIMEz1nG4rA0QxExreUb2H1K3SsggPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxz35UvbFj0pIsR+4hYdTwvQtCDoQKdwtY2ATnyk1Fs=;
 b=hBeiRTcBOTijp8nnYHFJ3VdXcGO3V46QZiqjCjtRJIEjoztLctw955ufYq0s2cuj2VpobH349TUaBm23AjL6GTQnlBNggxLFnV2+VG9Slqg5dM/MneSPFhlD5NoIWGJB6poMGFu2SOv1zkDYHBakl8K313/ZP10fvBmEqva6scp8Tls0KcrCkmkKXASeiHr21MQveIgmNVE2tLtKcbhfOOgvow5paUakrF1tCiaxc6TD3kGzZ8y5v/PkgHNo5iATkIGxWrMIFI+hXv4ZU+b58h70Az61DP/26i9i+scAowPwWI6Rqa0Y7PrQNn4JsTOgnsx/Ptn4FzepXqopLLLRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxz35UvbFj0pIsR+4hYdTwvQtCDoQKdwtY2ATnyk1Fs=;
 b=f1AUfaKkNNApPqJz49LX609KpBZDgfk+rX4q6IPDygQuqifcurYmcINwMH2Yb5aCC3j+C+5Vooh2pVQ26KcuaOTPUOjEPhqzG23TgPqMJGV+W9fNsILkSyxVrnq04z7Ua8Lcr0JWAfBJTrQpgrg/aZ+PEQtkgjNNixICH9JqPQA=
Received: from BY3PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:39a::9)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 16:25:35 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8b) by BY3PR03CA0004.outlook.office365.com
 (2603:10b6:a03:39a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 16:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 16:25:35 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 10:25:33 -0600
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 1/3] dmaengine: ae4dma: Remove deprecated PCI IDs
Date: Mon, 3 Feb 2025 21:55:09 +0530
Message-ID: <20250203162511.911946-2-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
References: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 435077ed-bb5c-466a-3a32-08dd446f6365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F629j+2Ew6U1fzmqohcicIgzBVXsKn7EKPLdkCYXfq6MZEsME2coQ2xVkf3F?=
 =?us-ascii?Q?fD8Tl3qCVlvGPpM2epZu/nTdx6Q5nf3et3LRN+2Cmz8+ABg5kj06+LSXjH9p?=
 =?us-ascii?Q?p3Cks95/12PcrlzTfGjvqivaJXvHYMeZDU90DUjAgp7wQ/a+55CkFqLGr6wS?=
 =?us-ascii?Q?fa7bSnbbCKM/bmMHiG+ytu506k79AxefR8yOwQRa6V12fBKmZUPovP6es+TJ?=
 =?us-ascii?Q?L9XU0702IzzupR+CWZjJ6TTtcGZCFecphIaUiGbSGg/0MGOqPw02401QEHDK?=
 =?us-ascii?Q?oamHHTP3FjfW3i3OEpLariMl2O54/SffKom4Qy6qbes1LgcBQ8YIyDgRlW5V?=
 =?us-ascii?Q?omPYdMlBZYDPJ/HK/wxkfoJkZrYeE3A0ZGf2FKd0FJpdtQ9wLTV6Voe94BAw?=
 =?us-ascii?Q?vxAJ1eFoDqX+rTBQxOgFM2CfisSFO53zwyvipKO1WrrRQpcgsx2KWj4Pte+m?=
 =?us-ascii?Q?9SGazNiVC9IUtJ/X7rnDwnlsXifXpyIqPovWeUBKz93C01o1H8+DEczgA4H2?=
 =?us-ascii?Q?QVyFGRjaIFnXadOX3MX1SNlTPOhvYHBRAVdPvHzLFauuQwJ5qlwVFiW6Derx?=
 =?us-ascii?Q?3bMXhfE7m3fg6q7hhJ4P0aso9p/50mpXv/aKa3fyktUsFW61VlRhASSAUJIg?=
 =?us-ascii?Q?voe3u2ZcNp0XEf/ZYpnkIc8UA2dZbKawHr1agkRLfzX1+2hMEbpB62auEOQi?=
 =?us-ascii?Q?sStNcWqzWzFORrcjYB/fDSG/j5J11+0Bf6+yaS/JzUPss/8iNgV9q9PCAJa+?=
 =?us-ascii?Q?0hxYPnVNkgzEZ2RUpRfr3t2ycLc/rAmI7tYop3+smamEU9xoogiSASiAyhkR?=
 =?us-ascii?Q?58nrrN2R7a+9ZX23a/xIRLZ76oK+WsMceXZtXogjVYAa9kj9oyt8U5hSBYO2?=
 =?us-ascii?Q?J8vrqn1J67v2ANbzXrIEAI9+yGLzeBtVcJK5/sTWi9J/vfw0wUCkYoXuWoUn?=
 =?us-ascii?Q?UjewaMn5eLHbzwKQh74erYlxePH7k+S6Sn/9MUiIFlZBoDsaN7YaFb7eDgnD?=
 =?us-ascii?Q?2AfSjNmKDKTwZFQFUFIiOMGWM3M4BaJemwc/jOJCVYfIvVN9SGFvToKb0bx3?=
 =?us-ascii?Q?C/cHSgUORakqGeYRVPXAB+8i9zxvro9AmhDQjDyuEIzpiURvDjS5JJkEOqT+?=
 =?us-ascii?Q?/sRJuJk28hTI4gND13hpwAm7JwSylDhsdNT6SwQNRVNR7szuAeLf2I74sY3Y?=
 =?us-ascii?Q?XW9ytHLUoqNs3iueGhKFfxTx4EOPWP5O4OcOYrNLS32wj/8wjwc7xaMXekez?=
 =?us-ascii?Q?MEHMvANz5Vx+jy0tscCGKMaJOHP7W/bA7ji4juAY/DqhQmSunh+6MmeF+k2V?=
 =?us-ascii?Q?HObaf0u5Bmj+4YE1Bj/ujpSGx82v9ETXX2pp1mkgbvR39iSPRcLRDgcWN4J7?=
 =?us-ascii?Q?h0TuZZSyIr8HcZYKHm+ta0yjKVCEYnvWRToJ40RJPn0/X4PTgRty7bkR2ShH?=
 =?us-ascii?Q?QpMvKjTNH3ItCfHIVOuPG9mi6oNqexJbJMr39pTH8RU8YJ0okJnvCtnMOu3p?=
 =?us-ascii?Q?UFn/Z7t22KNJnkg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:25:35.4240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 435077ed-bb5c-466a-3a32-08dd446f6365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502

Two previously used PCI IDs are deprecated and should not be used for
AE4DMA. Hence, remove as they are unsupported for AE4DMA.

Fixes: 90a30e268d9b ("dmaengine: ae4dma: Add AMD ae4dma controller driver")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
index aad0dc4294a3..7f96843f5215 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -137,8 +137,6 @@ static void ae4_pci_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id ae4_pci_table[] = {
-	{ PCI_VDEVICE(AMD, 0x14C8), },
-	{ PCI_VDEVICE(AMD, 0x14DC), },
 	{ PCI_VDEVICE(AMD, 0x149B), },
 	/* Last entry must be zero */
 	{ 0, }
-- 
2.25.1


