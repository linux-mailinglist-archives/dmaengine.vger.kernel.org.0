Return-Path: <dmaengine+bounces-3041-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2B8965D36
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 11:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7C91F25CA2
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7928D17BB12;
	Fri, 30 Aug 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LRBxGlET"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5917B50A;
	Fri, 30 Aug 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010905; cv=fail; b=U6j0cZXRru9B7/ggtF4puw48JGTWP5YMsRr95wL8evjvDx+lNdbL49SrB3A385BFSvPWs9uu6wMXs6RCiYS8RiOo7Em0rp5VcHi3mEasBbrCoryddwLG59LettCn72lEiN7O3zzWG0UPfgA1m3nswd+WBDkBZ9bXTnCAFhh/oL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010905; c=relaxed/simple;
	bh=V+6NdJrRhVgFyCqui7fB3ZxMdWS3o1zcbh9akWGQNrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b/8qJn6mGfGBb/W+jl3IgdQzfOHErFJbyAiBzkuQFKcFrOQMjfNZEJo/QpxXm8Ib7bX7XeWumzfvpxylaDDPxVlTylPl4iZFU0vURW3Qfc0kV6Ll9Vr8TcuJ+O+p0W/6EXO5qOibomdArw3PuIXfLim2aXGDHulWCtRQFl5MiU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LRBxGlET; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zm8g3uisGLZZPKo4vyJ9oK5S8HhjFCvJt45hoXDA7GAFPz7C6PBSEIX8YiV2zH7OuXcvABTJSeN5rVGFtIi/JkRgTUH5ngOj8GdnTJyZvXGhiV2K6gis5IEDA+voZTwtRuf26JOJQv3PkhvKSjqb38/VGooitQesHXlHdwxteBQOH8aZNEjI5ycfB2W1GhsVuxxB26HBdidurOyr7q+M/DLlzKeKxpOd9Nsv+IhvrOFf8Tj6H3dAjr5YFTKtUnAXeQ4SbHOj4gebc8rz8e23YsUPMxEXPgW/KlHnW1F56WqM0keGmyIXVUM5RyBS+6h1FiWxgeLTxXdgvhjisHUonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rFj3XuP1UlJJULnvwfp5UgDisYMTdPSq/0iDlZKcEQ=;
 b=HRam8k3yWlOqIZKFHC6b/8NCZmkW9ur/00YIA5yVQ9ZmSev/KB3j9dUA5Tp1bRONFnREdHgK1z7H2MVsOs2PQq2qCE489VdUv8Iw3DJOKm9AVx2JCawV/T4R4JmhJn/e/w/443vypHNzhTBkR9HAHvbfHQgFSVJ8E8Ze9X0QaDJ2ywz4rAL8cCk7aRmn8+IQ0qkCEsY71g+pbgFYY84LexRpS7BhuT+onhMhJHUPDg2ocRskzm2/bADowzGHd7znA7xGadnnW3AnrHOTpdleICuw8KEdScaCqU665f2Svl51RkspWLOYXtMBfUQUPa9QPZMVTIRphr/xrg2PG9hYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rFj3XuP1UlJJULnvwfp5UgDisYMTdPSq/0iDlZKcEQ=;
 b=LRBxGlETJO9uQForKH2ybuI4OKnL6W/tCiVb5vGj10nDiG35nKugMiTZX/hNQh3U33QYGtFFvJFe9FCAq+ByR5lzXNEOnciNBmoBZrEmBaDTzI+mQJi1sXHan429O6CObr+r+5DDLE1i/TxUhG+ObXhCRWBtVVDeLHeJqaWJo2sNHbnQ5s1WfNjzNbt1Xk2Gk9wMSbpMkOABIQ3IMOLYLY8uD2Q1h3tidFVNayUeVEKHfXVzVhLMm/t6w9K8Q8ZPWo7HxD2sAjEi8FOnaZYJTIQdbaclijzYe4Qotx6awIxUteYOEX9qi6++Psd+cy+zuc54eaE0mcSY5y+dE1N9sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 09:41:41 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:41:41 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 4/7] dmaengine:imx-dma:Use devm_clk_get_enabled() helpers
Date: Fri, 30 Aug 2024 17:41:15 +0800
Message-Id: <20240830094118.15458-5-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830094118.15458-1-liaoyuanhong@vivo.com>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 181fbf1d-ff19-46ed-3390-08dcc8d7f3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NUjjj1UzqkNEE+IN49FDVoEDHHUcvTLagXBLSbdVGjOOE3kNk0WmzxAOWn/I?=
 =?us-ascii?Q?gqwW+EZ/RqKN4IOjoHN3ftFMG3M4OHFB0G3Xcs8iRDScOE1wGWCspZLWPoOP?=
 =?us-ascii?Q?SMxHsTFJGbqBbvzzlfCf0a75vmZq2a+vJdp0XK9ER6Cd/4LTTBiBLY/fmN/4?=
 =?us-ascii?Q?g00wNLSIEuBtq1oDONslBfIXK7Izett07OzJ4metXXzMz4MynqrxkFAPYJfZ?=
 =?us-ascii?Q?v8AnQJijSk8UOKtlFzSRadZLRKB4+/gWpo8O8TlNKCgXQrvfIIbKpAmyTFJa?=
 =?us-ascii?Q?g9GukSO7dS3Z0XrfbZnSnuMets8ud9BWuO5DVXZIlnucGyEZXHkL1KCYL5dC?=
 =?us-ascii?Q?Ek3wsD1wfuHJ9YRz/9vhqszxsyzMIaOl1C7Dwx/CKzwx0UWODw2kWrqCHGSR?=
 =?us-ascii?Q?2vTu4SmMwHS+Qz80qH0nsS+GUS3BQPSmA25fiJ5bBvsOA3SD5BTgvs0P8Si4?=
 =?us-ascii?Q?LMquFep8orbXrsSC53pF92Rh6G9dQmOthiEunNxpNoIwvKdwH1XW/M0M02Ud?=
 =?us-ascii?Q?JEgYseQxUf82p+RKDe/dRL2XLdcV5huXV/0EK0C5T9DVjjT/ZEDWlAQIHEMY?=
 =?us-ascii?Q?bP3vbQ2YXovGl/rm/H29mLeHzmNon3fEhB2I+4jCZ6dGAGQzeFpbKLMFoNtg?=
 =?us-ascii?Q?GSeV4T2cBWpf+qZN4oEjMyISgWiS6oP/M/HA5hI0oWel9Rou2UkTd46wCj7e?=
 =?us-ascii?Q?qnbKoZsUoUK5rRcmx1X9ZkJk+ERyCbteE8YzbI3RpAeVYVUeE2sGiEKVpdRn?=
 =?us-ascii?Q?kjLhVQhSpnR9T65qDs/wG3pWmDKMNPOThYwnLYNbhycJ1YdD482RV9T9dExw?=
 =?us-ascii?Q?nCI7lJpPBFiCPm0O5mQILGW7z8SaagD+2HYkySH7zxzHx7SFDMe5JKAHrn7G?=
 =?us-ascii?Q?z2B7bJWxfNkwVOdW91g/rCXFQw+SBbKy73c7r5jrauzXyNENtTuuVuVQye8r?=
 =?us-ascii?Q?8AOcI2y/zDkv2vH47yW/M60DuBKfSJiSkwe30n2WmhBSp5q1RlpN5pNDSmjX?=
 =?us-ascii?Q?M/K+xnbfb7NTC7KEkQpR1AWYzTQjkAVmbe/DkrYMOYOSmDRDmeS+g4LeL6yr?=
 =?us-ascii?Q?IBB0eh/RYdu4M4kYzVNIf5/ioYnt7J1lTeR0h2mZHPAHxz5nxQY/m32Fcz1L?=
 =?us-ascii?Q?H07Cg7dN0K/jc8s+97NfWMzyK+X1RV1nNvfNnKv0UdrVv4o/WlTyvTUPcYwn?=
 =?us-ascii?Q?ig7CdyN00i0QDckKOGkpgFiluhGFKYiNtNLECh3v3pXxcPqFcdQ8CsU/J4go?=
 =?us-ascii?Q?piV36uM24A1Xjb6vD2QVt5AjxPj3m8UWeTTdwyKX8r8wQ5qFZw3zDfEXB7Pq?=
 =?us-ascii?Q?FwcN5JLfcgD2KCHQLFN1OTTQOVI/cybctvkkqCkt7AXa0hhOCREPqgMO83nX?=
 =?us-ascii?Q?QK90jmZOcJLygH9xrHPFfsh4jJTEctrneMP8I5FXJQLXV3fnFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jo1qaIik9JtHEfyOl0Synr36zN5hb4pcvcm/xRKssyT+diBEvz52NXb/DuNN?=
 =?us-ascii?Q?L1ZeS0tFUzFDI0tNvzr4PrnhVpgPbziXhJj0TxfP/byvNAKWVSbA+VZL66+i?=
 =?us-ascii?Q?xWnpP6HpVJFzLJzUwimdYYIDUGatlRtxewI3l84JFE4NpJdIiNy2+4MGtopf?=
 =?us-ascii?Q?+uMK5pXtrTH2odkHVb69FUOFESGdje5m8nHPfY7PMtU7YexLBoviAT/v7Dn8?=
 =?us-ascii?Q?mjSJm04IAVs1UFFN95xfqeKRE3kmE24Mus+WE9oX0yVKndGCWqZlfa7RXO6a?=
 =?us-ascii?Q?/4pie7MhxIyD134HcxFL3znbMalM67SYVMFHdVSdbmyAvHpDM1TmpD5QH+48?=
 =?us-ascii?Q?97c1RrPLKRe7Uv21sxh3bBIGSNpMiRt94F5v97oJoTMi5wKeSPRcJd4CiO6C?=
 =?us-ascii?Q?MNQ3IbCXdHZIpy2rW+kHJ8XE8MBzGXwy2UIQ0bbCyu2ysMqOSG9UbaH3ImeW?=
 =?us-ascii?Q?MbrA0oonL6uxk5EATxOC+toY+xAwBU2xO/4TQB6NdYON6xI+zApDe3/vl4X6?=
 =?us-ascii?Q?d0LYhUc0FU06cxs+xjtMHj058tOGMU5OJRop+u8MISVgO1mDEsWK4ULrvNnk?=
 =?us-ascii?Q?XoG5qivarr0xTh71XlX3PC4kjIfUz6CrdEUA7inklz8h6ds85HNF7uJQxV4f?=
 =?us-ascii?Q?d49QUioSuQ4btAc7EDiPeAbFen60DI0n/kIJ8r0XeMIyzcaaprtRpbXTrUik?=
 =?us-ascii?Q?wdmTYrNIQhkC8LRIY6dy/UupZPWEsjVyEDnCVY0O32MjlITJlpCR12XUDKHB?=
 =?us-ascii?Q?cM9ppsFfTo4BxEzUDK/ruMvkXKy3y5XVeO8SeunAytyVJQE1fXgU4kuUS2KE?=
 =?us-ascii?Q?3BiFKBoPUL/yN7kymF4qOli1NRt0jBFiVSW8JKSc6g3/nHkq3p8UA2hBAU46?=
 =?us-ascii?Q?pS/gzCb7bfxW/GP9RC5xPSPsWD6c9WtOkwy5IQwGiY3qDEaO/HxZYGO/PBCX?=
 =?us-ascii?Q?zK93fG3cO/DtY1xVDNRqK2GTSoTECZDGl998ufls4G2zsxMRokQa6uLLrJnR?=
 =?us-ascii?Q?rhS613k5iDFBKlXCDaMIk4dgSVv4H64vFMOO7r0yjiqGSdlMQb2+QoI2Lgmd?=
 =?us-ascii?Q?J1rdFRARhBfssovBPsdIE2Z7PYOqhI4MURnX9SUow/XRurmrY3OVSp/ksmoT?=
 =?us-ascii?Q?DpizcFMG5wfWT7lqPmWKk/xEA98+5xZxMClB8he5V6Rokjet3ysuRAvoEju6?=
 =?us-ascii?Q?LDxCao9sJvgXzhoDAta1vkUlDPMQ5XLfPl94E7cyodstW60LoDnQBkhES7g2?=
 =?us-ascii?Q?JB2tWtCwuW2SE6j853UZU1Iizke9n889DQVDUrPiWLLsWgL4efGANgWKVHgI?=
 =?us-ascii?Q?XowuMIhzsV0gf4vncSopDvQfKHpXJyouzk2prZhVOy5stqUWZLls/65GbQTb?=
 =?us-ascii?Q?pL7PTtzuaRS05+/7CWTO7siJ8WrltNPStmc3zI+c47v0kYKnaFzEZKr9IJu8?=
 =?us-ascii?Q?QLt59H2GbMXcjueGUS/9ksT0GbAKJ4QWhn3sm8+32ll6FMhg4MLYCDIgZWSS?=
 =?us-ascii?Q?qdDUTQSWutfTWYCqq+hwA0yXIK8ehas8YcOMF+nSCMcM/BNCbd1lCXcgBYlq?=
 =?us-ascii?Q?POrr0bppXkUZtA+7M1tbqlYY+w3kAN9ATuEbBcVn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181fbf1d-ff19-46ed-3390-08dcc8d7f3c7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:41:41.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HteSRIuwQVH7qF1DvglmrgRt/3sLw8l5RQBmy5KEXdDkRaIHhaDy+O3GGdN/IfU9FAgrBB3CBUZOjXeVDads8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5203

Use devm_clk_get_enabled() instead of clk functions in imx-dma.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
v2:use dev_err_probe() instead of warn msg and return value.
---
 drivers/dma/imx-dma.c | 59 +++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index ebf7c115d553..7178e9643102 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1039,6 +1039,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	struct imxdma_engine *imxdma;
 	int ret, i;
 	int irq, irq_err;
+	struct clk *dma_ahb, *dma_ipg;
 
 	imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
 	if (!imxdma)
@@ -1055,20 +1056,13 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	imxdma->dma_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(imxdma->dma_ipg))
-		return PTR_ERR(imxdma->dma_ipg);
+	dma_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
+	if (IS_ERR(dma_ipg))
+		return PTR_ERR(dma_ipg);
 
-	imxdma->dma_ahb = devm_clk_get(&pdev->dev, "ahb");
-	if (IS_ERR(imxdma->dma_ahb))
-		return PTR_ERR(imxdma->dma_ahb);
-
-	ret = clk_prepare_enable(imxdma->dma_ipg);
-	if (ret)
-		return ret;
-	ret = clk_prepare_enable(imxdma->dma_ahb);
-	if (ret)
-		goto disable_dma_ipg_clk;
+	dma_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
+	if (IS_ERR(dma_ahb))
+		return PTR_ERR(dma_ahb);
 
 	/* reset DMA module */
 	imx_dmav1_writel(imxdma, DCR_DRST, DMA_DCR);
@@ -1076,24 +1070,22 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	if (is_imx1_dma(imxdma)) {
 		ret = devm_request_irq(&pdev->dev, irq,
 				       dma_irq_handler, 0, "DMA", imxdma);
-		if (ret) {
-			dev_warn(imxdma->dev, "Can't register IRQ for DMA\n");
-			goto disable_dma_ahb_clk;
-		}
+		if (ret)
+			return dev_err_probe(imxdma->dev, ret, "Can't register IRQ for DMA\n");
+
 		imxdma->irq = irq;
 
 		irq_err = platform_get_irq(pdev, 1);
 		if (irq_err < 0) {
 			ret = irq_err;
-			goto disable_dma_ahb_clk;
+			return ret;
 		}
 
 		ret = devm_request_irq(&pdev->dev, irq_err,
 				       imxdma_err_handler, 0, "DMA", imxdma);
-		if (ret) {
-			dev_warn(imxdma->dev, "Can't register ERRIRQ for DMA\n");
-			goto disable_dma_ahb_clk;
-		}
+		if (ret)
+			return dev_err_probe(imxdma->dev, ret, "Can't register ERRIRQ for DMA\n");
+
 		imxdma->irq_err = irq_err;
 	}
 
@@ -1126,12 +1118,10 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		if (!is_imx1_dma(imxdma)) {
 			ret = devm_request_irq(&pdev->dev, irq + i,
 					dma_irq_handler, 0, "DMA", imxdma);
-			if (ret) {
-				dev_warn(imxdma->dev, "Can't register IRQ %d "
-					 "for DMA channel %d\n",
-					 irq + i, i);
-				goto disable_dma_ahb_clk;
-			}
+			if (ret)
+				return dev_err_probe(imxdma->dev, ret,
+					"Can't register IRQ %d for DMA channel %d\n",
+					irq + i, i);
 
 			imxdmac->irq = irq + i;
 			timer_setup(&imxdmac->watchdog, imxdma_watchdog, 0);
@@ -1172,10 +1162,8 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	dma_set_max_seg_size(imxdma->dma_device.dev, 0xffffff);
 
 	ret = dma_async_device_register(&imxdma->dma_device);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register\n");
-		goto disable_dma_ahb_clk;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "unable to register\n");
 
 	if (pdev->dev.of_node) {
 		ret = of_dma_controller_register(pdev->dev.of_node,
@@ -1190,10 +1178,6 @@ static int __init imxdma_probe(struct platform_device *pdev)
 
 err_of_dma_controller:
 	dma_async_device_unregister(&imxdma->dma_device);
-disable_dma_ahb_clk:
-	clk_disable_unprepare(imxdma->dma_ahb);
-disable_dma_ipg_clk:
-	clk_disable_unprepare(imxdma->dma_ipg);
 	return ret;
 }
 
@@ -1226,9 +1210,6 @@ static void imxdma_remove(struct platform_device *pdev)
 
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
-
-	clk_disable_unprepare(imxdma->dma_ipg);
-	clk_disable_unprepare(imxdma->dma_ahb);
 }
 
 static struct platform_driver imxdma_driver = {
-- 
2.25.1


