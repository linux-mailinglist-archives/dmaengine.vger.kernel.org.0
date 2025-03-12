Return-Path: <dmaengine+bounces-4715-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25332A5DC5F
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF293A9444
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F423C367;
	Wed, 12 Mar 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A2854r3O"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E323F399
	for <dmaengine@vger.kernel.org>; Wed, 12 Mar 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781475; cv=fail; b=J6kD5r7ypsxe340iTaIPAbHAKA8nyNKPW6hUl7VKKpPukZiPhTAmxQFwxHcCW+p/jv26MZoLTxFLTL7o/b5ugCHAsSDTMthTG+v51TfTE8r5SuyUvN9dqg36K39fdRFodQ2SeSeZZJurDPsb38aujNWCFuFGwhh/v9Hk34pdjI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781475; c=relaxed/simple;
	bh=l7GuHnCAAHnZni8unNZzSneVmLrXWNUegZDH4L0a1Y0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PYDQhQL+xnZep35nS6vcg5TQeis4oS6KFiuCgYQntTaPt/vBT/68xNbzdiGP8N8BJfhNgM1JpnzQJJJg0qtCh3xIzqowAkOZptHBjmzrx2IL36uyAf3Kextku6X/8Ys8nITvhRgdOYoSIQwjBnzUHRmiBIq79dgz/J1yinPg6Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A2854r3O; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW2GI+4JlEFIl61oQMHmdk45hHCtam2JY1faI1ppYvRcvel10HLCra8DUH4yMu5cwVtCrhyEoNWyXUOGeo4fdaobNc58YQiB9LkanJystRBXfh5U9vCwPkE2mGa7Y0dHXIJTfQ6c7biPOy56xx7da8G7J24m0cNc5bx+wEWbJLdWty5m0MSveCGnrnowvvY1Zf5imDs+iqLmKQgda1Ms4ErOx5V3swfZez4KRnWcg9lleyfZvDcfrwTFwnzgkGPUz/TYk5LeqdrpjpdP2jT1QgYbRv4gxBznAK7JanY5hAL7vGrPnOjZTjfIJRKJsq6kAP3xXQdH519YexUTiYxrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGguv1vdQdACnRjrwK3s4ul9qaN8XCB2RTQlHjxhV08=;
 b=ZF53J+RfhJQhguyoLgjHIr9PotOgR1aJN9KRcN4ECk8GEeRa7zyRnB6mTxGWuCuTlhVO3ofUr6ptwyaHejmsU7gOQjxgIOLtlaMSsxeq39KOa8hslW0QY8Cuiqqi9tJYZR2cAvU1K8G+qx6+vdCle6sv8d1EM88SbntYhqYB5yyVtHWTh5xZCtJxmYnWr8RZsRH5HG68TU/ha/Gh8YgEBJb/IOl7Ln/odD9sLlBtuJ7mFyibO0HUVul+gDkkFvO8qciUbrLXOvkiNTwDqau2UNUW83AQuXRkK+d3LnBR0z6DSQTKUDQVT8HW3UuRwRODTR4Hk9CH7eFJyj6KVTV1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGguv1vdQdACnRjrwK3s4ul9qaN8XCB2RTQlHjxhV08=;
 b=A2854r3OhD0G3PklwiunJo2F86yDKdgW/Q3yiAcxlA9Oe2Z9lQ32m/mP+StS+hkm3hEovL9GEuI9HM2k9gnKZs6wts7BV6eLF3J6zGPACDDOJgvXaAPRHJiFXsDGZJ/QkvRcORguQRQJlwquPs/+HmLbvLe+PPFAvWZP7ukH1sM=
Received: from MN0P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::9)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 12:11:08 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:52a:cafe::e2) by MN0P221CA0023.outlook.office365.com
 (2603:10b6:208:52a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 12:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 12:11:08 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 07:11:04 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH -next] dmaengine: ptdma: Fix static checker warnings
Date: Wed, 12 Mar 2025 17:40:44 +0530
Message-ID: <20250312121044.3638028-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: c732686b-50fb-4a48-8a0e-08dd615ef8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BABDfxMDoVifhglPIRgpKNl3JRzy2pjHrOAnaXSmAU80llWTEiZ9NUOG2xXk?=
 =?us-ascii?Q?HsH2qYd5uUnx6LpvpEgHz+DbDyH4QfQn4O5S9sBFaRxGqa59UesGpq17Bmfn?=
 =?us-ascii?Q?25HylU2XSFSZ89SEu1ShMjjq8lk21dz4dwTDvv3OExlkvqlKh5Hoif+QJZ/8?=
 =?us-ascii?Q?Pn7X0onBslpRNZCl1kyfJ7+ViqaiwpcC23NcH5CDDfFjCVnK9XryXbB0V2yK?=
 =?us-ascii?Q?Ra6ozRAOkaEOjrsq2tqsklTtUUE1ePeFP5DbkDLxF/Tsbb5x7PLj+Zj1H4wh?=
 =?us-ascii?Q?EAYNMIHsPGHy0Gazs97GGZ1sv8wNUtk8Pj8MAx3Qv8y7AxhfS/E6hnuBxGgt?=
 =?us-ascii?Q?gJq8kVlqIjru80C3u5bzJbPk8XkSli6LO9sGvM7C+hcyxRrMD+w5ByMpCUb7?=
 =?us-ascii?Q?I47i+4+yEEunv1SwauquadiqDG8TMAJvOSdye+mWlpAJOScZR/p8BMVRFG6o?=
 =?us-ascii?Q?xaY8cFeU+rH92hSOG0U3/WMGN1yLtB20YED439bCcGyQ4pZBEzyuebHf6k4A?=
 =?us-ascii?Q?Q797sp4ZiWXrvpqeZ11CwzuM7wPgCnCMQzkyB1UrKNSgr9cEZfxRgmNpN4EK?=
 =?us-ascii?Q?tgdbZ6bnLvPobMY7v75wZqXd992648i33agjXPhmS04m0WfplxiFVwwrUnoI?=
 =?us-ascii?Q?KUwmBO0G/NmMQRTQ96fo0cabkccssTcSvq2fgbXXYmeVV2pg860zLIasvfPn?=
 =?us-ascii?Q?byfHURJ8/fFM+8Pn2S8MbF2Vrp7cj3m5CPAGCWpvg4/cx46W0cuD7+b+Aqkk?=
 =?us-ascii?Q?as65XmpG6FW6HLfYwM1fWDdQplDy41tmGUWYszMG86wGiP9w/4T2zQLLPM01?=
 =?us-ascii?Q?l4cwlW3a5yht2yPm9doF5P1OO2qMnBEotInci5ika79jUoKvnqKaLBQzs1Zl?=
 =?us-ascii?Q?AwZbVJWsKN3C3YYK0GGivo/4hdI5Svhfpkz18jYr0r6zKEkhv8dRgw2kTnmU?=
 =?us-ascii?Q?d50tn6GjIj+Fw2gEISnvf3B6R9gVA9Y9o1Sqk8GvJ9PpWWJZWWuvXXfHoBza?=
 =?us-ascii?Q?iAn+MNt6GkDb4kLAbEUlCy9bqZq1So+mCqZVgk70AbMOcSlEYOJU1UXugNNt?=
 =?us-ascii?Q?2dBsmO7vnKdqh02QxECa/4ybszVjBjpBJQM7Xsp7JNJXWV9TsRmva3L5J6I/?=
 =?us-ascii?Q?DucCsCG3ma2AJ0M/pNAwIiBS7pduPrXER0GrVcC1MEWTaKy6yS6XafCh2WDL?=
 =?us-ascii?Q?KHNOj0Q77hlagTxeHP5UO7Sa65xOS0EaUpGdSYjgqkeRzNUudF5k3o7qLAEl?=
 =?us-ascii?Q?a+xiMcR7gplasslyKuGR3ukD1fPfnR/VGkxLECs2eiSwqRbQzy+bg/u12PBO?=
 =?us-ascii?Q?H/2T0wk/pKWjbKvd+xDIoaLIFqHvJNwZ/zTgy12MItY0yh6NrFOxjLx/cpvt?=
 =?us-ascii?Q?b3mgZGW2XYu+7qQiqYRKaz64t7uq2yeCXRhrEKCPZ5CZvmju9ymdVOupVW+i?=
 =?us-ascii?Q?ELEdH8ODLbEucymB9VuazAfToZtcYi7g+B5m5eA1R0ROA+a1Bv5PfIxfBm8e?=
 =?us-ascii?Q?1pct8rW5cY/ffBw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 12:11:08.8260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c732686b-50fb-4a48-8a0e-08dd615ef8fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458

An unnecessary extra check leads to the following static code checker
warning:

    drivers/dma/amd/ptdma/ptdma-dmaengine.c: pt_cmd_callback_work()
    warn: variable dereferenced before check 'desc'

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/bfa0a979-ce9f-422d-92c3-34921155d048@stanley.mountain/
Fixes: 656543989457 ("dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 715ac3ae067b..d1d38ed811c2 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -355,16 +355,14 @@ static void pt_cmd_callback_work(void *data, int err)
 		desc->status = DMA_ERROR;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (desc) {
-		if (desc->status != DMA_COMPLETE) {
-			if (desc->status != DMA_ERROR)
-				desc->status = DMA_COMPLETE;
+	if (desc->status != DMA_COMPLETE) {
+		if (desc->status != DMA_ERROR)
+			desc->status = DMA_COMPLETE;
 
-			dma_cookie_complete(tx_desc);
-			dma_descriptor_unmap(tx_desc);
-		} else {
-			tx_desc = NULL;
-		}
+		dma_cookie_complete(tx_desc);
+		dma_descriptor_unmap(tx_desc);
+	} else {
+		tx_desc = NULL;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-- 
2.34.1


