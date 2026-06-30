Return-Path: <dmaengine+bounces-11880-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RPRCCf5mQ2qxXwoAu9opvQ
	(envelope-from <dmaengine+bounces-11880-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 08:49:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4C26E0E05
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 08:49:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Rp7LXmO5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11880-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11880-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55CBC3005151
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 06:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416E93019A9;
	Tue, 30 Jun 2026 06:49:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004952222AA;
	Tue, 30 Jun 2026 06:49:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802155; cv=fail; b=UQMX3071eRy8qYAaAulYgjIM5nzznh5xCslvQNeLSJI5F2GEHcI2sy6z7suyalN+tLH99n5fBlpsxIafSbYp6cxOKi2wNk2U8DIChDv5Dlw51z71AyEmiM+WaIsQpHbN6y+vkGokEJFHZJ8NG/V8AB823LQP/QE7fxIOGzhFe3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802155; c=relaxed/simple;
	bh=k17ea2KFgJUh4Q2oP9vT39WdD8ZH3yt/a7xiVk6tjjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts313Q09Wddl1jhqBOMo2G0v1sU+b0QTrXH1GCgvdSdczuam3wglr8yvOam9AHFAU4FfxkDvmPAna+tmClgg36OXgCXMiNW9YuEyBp7ScYVTkN56tcKNRHn3woygA8Kvo3yVa2wgEI9EBWwwoknynH8Z7pcrnK7DseLHxW0mTl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rp7LXmO5; arc=fail smtp.client-ip=40.107.201.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg4Di5LPFgVfI+kwb75EJH74lGZvbF6yPMMFEELWQoeZ4ZEL/92aP2ih9rbNbNLvcYHv2x2LyI9cplNSx6V/Qe3Yv2oQMonq+xIiypLJeQhoMXCF3pZDVWpI1hXQPCDwgV2ly9VptaR5QFWK6Z0AkW9ADC7+0Sh78oF121iEiAmTDeh8rXXd360Ecb2NLEu2cEtiE92n3tsQycwMlb7QEaxIr5bjLKc0PhgPT3yfbzNqIlIwnZJVToVXSmCk8UKvu16J87d8cDHOSZggAkUNapnMIu1t0cxKismodJbZ0fkx7mzqH15tEgDvfr3tqQ1frlYQaWeCLSHac6rxisoxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZu6q5o+4eFullPeNUeCYaYl8kXGYXZqZ3U+7gYldos=;
 b=sMNF5k6Y66zFXia008WG2rg2lNZ4R5dzS6fhBppOEWkWQJ1mTlEAWCKK3K8pHlBKv2gL1n10ZXueEwXyFH7L+/djTWAYJpQ3c9JeO08UKHSxjui5o6SdQM09xafkVeZW/VQTs6/FYJeylotV6jOwrZkQCXv/e8HoMZ3L9NzYav6efOtoouSuW6xPtA4Ai64Nw8zR5SxV+SR6yzv7mPrg9kYQAR3IcrIJOWc0FMbwyO4kvZphTv7BaZMdTc6DkuyGG0VqTyGdZ6flUNpJR6l/w2H7oqXb+jAjjTHW7PK+vp6gA4oHwtjaBx4rtfUradkXaJjMVf/0d9oRTL9kB+ozkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZu6q5o+4eFullPeNUeCYaYl8kXGYXZqZ3U+7gYldos=;
 b=Rp7LXmO5o+p1L3G6Q/vo6rfn8C/5sU3vgZGuBFkiSEFpabArJRxG6SwMDF9lSnTjFKjYV3ejGzrMCCmUK7lZPNKDZcBHxTVfuQty3xV5L69/+lDjxQb8osLNWLj+89g+q3KpjM4Bsxe3qB2uQKY5d4DEzE6OISvzK8JLTki8f5c=
Received: from MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 30 Jun
 2026 06:49:07 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::7c) by MW4PR04CA0189.outlook.office365.com
 (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 06:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 06:49:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 01:49:00 -0500
Received: from xhdlc220353.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 30 Jun 2026 01:48:57 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<nagendra.golla@amd.com>, <abin.joseph@amd.com>, <kees@kernel.org>,
	<ptsm@linux.microsoft.com>, <sakari.ailus@linux.intel.com>,
	<radhey.shyam.pandey@amd.com>, <u.kleine-koenig@pengutronix.de>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dmaengine: zynqmp_dma: fix kernel doc for zynqmp_dma_remove()
Date: Tue, 30 Jun 2026 12:18:44 +0530
Message-ID: <20260630064844.705173-3-nagendra.golla@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260630064844.705173-1-nagendra.golla@amd.com>
References: <20260630064844.705173-1-nagendra.golla@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 7035f58a-4a62-43a6-132d-08ded673ae51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BEGwQUAE8N506oo9WeDNXFZxRznOiur5WNLzuSnhiuMti5/6E1zmRhhhq7plKhNxhrMMCRVhbjR94v4VvaZ2dyyTh9qjjZ7+HuTc7Js+BgiN4romc3cCDVPL/YTYfS19jwAWLnZ7yK6v+XEszf404Uq8HDoQEa6CK5hg0tUOjxCTM8cGiC6pxW5NlUTPQLm05tMePSpdKBPgCgvw6n0KnGyd1m1kSK8i8YRufciS5sviIFYCl0qUKRnz7bmy11wxJRJIH2VBRvQZ+RGN5bmrnTrc8Eh32B0kEV0Vnu3doRAJdMXpu4kNRsmGS/CWemGK9f7d4LcVzz6olNnc3hCCCo3jsbFa9vxkheg+KiNfLQuybfRCNlOYcBvQw/BmtQDF/cH5rh7nDFfQE/GaF38mMhKQSEno8dG4B87N2rMjZBrPNCEtiy0zC4mJbg6eP1WE/3bDAbHsXgsXJmHNMeuG/jygyfrWAl97VynNKc0BUe2nf9r/MW1EJMyASe5eRCAzNGk4XX4GvZh+oo7NC7c7rsri6M2XI+fcOSgxy4+bM1pES5v5eQYaP196NHcsBZ09tGYJ2xJQ4y1dzvkQS8jgJY9IVrpJHajgr1bxZ6xuQWQ01AmiY9HeVe+/sTgvIiNzzd6ySLrkHiGAUFUxPV3gT5GBKROWiN29vVZ/FGGADu6XK/NyXs3RiRntSxUMoUU1yIVKpD5MFbyF5nOn1OwoFlXlBSqSCuw8y7JRBOq6jWzjbesPLFY1sVtctZi07nlA
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ISg3crNEGZnEogW4zOy5UsTOd7ff85RCDhgVouCFvPweBiaZhHp8EQACs/LA25gLLyKNzGtDPMovsKrgHUzL4npxiX7iA4KML3KiFshxFiyr+A6fUn9UtfpOLhniZa6leXfB4s6IcMZEbnCGTAfET+9t4rIpKIyKGDHwml8IuHl7l7p0XeyQY2DdREBLWyrGTgy6mERBo33ezpLoou8GxfOYrLMuQRFbxloUTR3NgOCgBvi5GItW5y5fXK2OHmtWh8A/ywKXgDZK4EgUev1LSFFwZzezLh9KLuIpMIdmoIudWodsLiC6HhN+dW6tUtrO/0M0mk2iwHG8jOmERpWF35eg3K3zz1Tn8CCS8ByS/5CSqUJ6UwwrqX+LA1w2JkKB4Pw0VuplK+kZ7+L+eFC0XJfrNxDiwCNcPglM+R8t1JoW1DV8ISAedUaGV/vdDdu3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:49:06.6232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7035f58a-4a62-43a6-132d-08ded673ae51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:nagendra.golla@amd.com,m:abin.joseph@amd.com,m:kees@kernel.org,m:ptsm@linux.microsoft.com,m:sakari.ailus@linux.intel.com,m:radhey.shyam.pandey@amd.com,m:u.kleine-koenig@pengutronix.de,m:git@amd.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11880-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B4C26E0E05

The zynqmp_dma_remove() function was converted from returning int to
void, but the kernel doc comment was not updated to reflect this change.
Remove the stale "Return: Always '0'" documentation that no longer
applies to the void function.

Fixes: b1c50ac25425 ("dmaengine: xilinx: zynqmp_dma: Convert to platform remove callback returning void")
Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 26f097db593d..ba6604dd7153 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1177,8 +1177,6 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 /**
  * zynqmp_dma_remove - Driver remove function
  * @pdev: Pointer to the platform_device structure
- *
- * Return: Always '0'
  */
 static void zynqmp_dma_remove(struct platform_device *pdev)
 {
-- 
2.49.1


