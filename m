Return-Path: <dmaengine+bounces-10636-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPk4IWDgDmp5CwYAu9opvQ
	(envelope-from <dmaengine+bounces-10636-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 12:37:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D14FF5A36B3
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC143094AD8
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5247D37C93E;
	Thu, 21 May 2026 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nC1ivF6G"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8FB2798F8;
	Thu, 21 May 2026 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358012; cv=fail; b=iDr/LXPOAa/An/Dc0ZBfVxWzRHBABFUxDqkWmtkxGfTzkbd5bhL8+YJIsWwm7zhFZV5BOv3cheuwEQcrLMO8RlqkwY/yQB2lsnUWU2AdoArtIUBZoYhZkBP1lbofoIKuXDDk6OmDF85+SW8cREzTrMY8mrlLRw2Mf2KMm6Z/8zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358012; c=relaxed/simple;
	bh=7c4mwHcJwSG0MHKTxxjhnPCutF98tW8D8P7TM0lrJaU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gKo7X/+vYn4pB+aG8b+6NIfv0N3+JiN4ifvKg95aWc5I8/jnNEv3XWajd5EHjme+PEOyvRsKqqHEvVuxJVRKXCGIFNEXVDhF41RztLCsIVupqwfUHj4RuvwDx46ZjcugffIjh4mNfJ2oXeU7yiKT2YgK1ZXezhA6YfDGjv5GMXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nC1ivF6G; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atEx4PXUGXEjzvm26q050UYYN1AQ532TM8D4rtqS8zVJRwRLl7sI56uB0Lrb4XIwxFjDfAbq7bxxZ70qOJem/ZAXO5Z87vWmbYdirhO8DQBwv2ssWNc8QwfFPwEoYD1pdazNZHVg1fJx2Fx/fi20pyczf8siG9CSxeejjPOHF6i6uMblMEtOOrKExgIKJM12O6RGiqX0PTFeYA6vkn0h8EpnIHKuCknA+rqDd7jaU1EkBAahJTrhvXFzBOMuk1sI2pspZHLnw6LBSw2OtxrKDnP403BEdwc25+wwrNy2aPWOhYQi6VA/CGu3jvsiYk7eMo/JaI6sljX/EdMXXeCDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9KPsRDtH5Roqcjh5rgGHD/ytNfzMFbwSvXLyFzUsiQ=;
 b=QPewtyvLJuleodVgxYifI86Wu7LtlUTOAejexnDRpC/npN2nHs1JQ6epYr+ZlCreehj1hfvnOHKsEV2o5xfYlN3/vDpaIIdqlQD0cVTfxtEe0BMg77kpFh0l7295prr4XaMEni5Z/iCLxJXAQ73Sw69fG14xmiNByDQn5Vne4TDI3zwYL5jBbo1jQs573FpyVCdnDfl+2ZWWgmubNsdE90lOX9S4oZwGm2Y6kauSRpeKHsbOO73/e7kFV367bzzqrZmA1Fz5ixOMORRpER2vFGDH4b68beQYyH9eG0MTCVh7eIQcpNmgF2H5PVvsxSqoZWRMaShgx2WBwKY5VGpreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9KPsRDtH5Roqcjh5rgGHD/ytNfzMFbwSvXLyFzUsiQ=;
 b=nC1ivF6Gq/biT/jkYwrH3YfCluZtNPegqaUBUmIVpYYyqmn+fo2m7xXlmtmaM/WjDRS91A4fUq6ruQIKievcgQAtIaS2764amzB6zeLt9AAnrPwtRtepYgH8M60pbXueQ7yG+WEUtr35wFSE3sxyVT/6H2CbSBuH9xQjQy2XegE=
Received: from BYAPR21CA0030.namprd21.prod.outlook.com (2603:10b6:a03:114::40)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 10:06:44 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::15) by BYAPR21CA0030.outlook.office365.com
 (2603:10b6:a03:114::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.6 via Frontend Transport; Thu, 21
 May 2026 10:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 10:06:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 05:06:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 05:06:43 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 21 May 2026 05:06:41 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v1] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
Date: Thu, 21 May 2026 15:36:40 +0530
Message-ID: <20260521100640.3333076-1-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: f578d7ce-b8ac-4edd-5a79-08deb720a98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	AciCeHwlpizjXcdAAiIuYt7IXKXkZ6nzoHRkR7qVzPOCWgWd9FTY2OHE6jptT6Fz+5hyfKIotodKO8FID0INYfCLDj8Ni7DmP3cYC1H+Jfy/jbb738nydpN0LrUeVF0B4xcOj8zSuTv68URHUmksLFLP/on2yb7xNk+gKs/7GIhoc3uam21QeScer/qdfTf/4EG7YupLqomg/XTbiBLLqqGWKX1u2YcVPdGKtaJm/XYxumzEi5EWnNgdm3k6zLehIdzKMGq4NuF/8ko/qnsoL7cs+aZI/NDp/CvZ1m1ywHml6FM5/L/iXvTKJsMoTSBLbV3Xcc6f81gCq+OC5EXBmk/pgenTnKxlV0fuwwQkPiyZRd4VpI4B4EFGpkGIjcBaZ3dd96A5gQ9TzEicbj3lzc3XEPaU/cPisNXhZ78nHi25zhVxVc9Ko9msp+qk4OPo7DByA7pSRgUG8Pc7S/Wlo4q2lgoQUVjQJQWxhuPHOcnHPuKLptc2uemwRdBXbDKsU9JQVZcxvlG/8dCy4zLzkqjPtNR2JGcGQeZPA4qqU98p7VMNlnXMIGqHC1iQIXEq40bbThodS/6ZVf1cSyuQ1cVxgoInO8+kCAwey0XH7YbWIx5ZWSwlvzTlgvYryRgKw+mBgE1YpCWO2anzpzPUuHJkVoaPRDXvYKepYElcWewhyo82xT3kreFmjqlshFN0EF3r49JFg0w4oX7JXdpY86qD5/hcuGCvdRMkN2k/1rI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1wfHiGGaQEca+AWVpj/KtaAmUOxGQYxhU8ifhCQ+A8olui07i077P0Zia8mdF/ZuD4eWaTLq2X7y3oThYPb/R6YObqf/VX/ssMHn7aLO8tNbrm1my7DeDP0CwvQsgdXZMuOWBq4XtReomnFzr2VRL8IfUJs7tB6G7gYtdGVw2+StDOkFrNpJl8m8Jy9JUn3FuRE7JEau9X11xX2LhotyrRkxBCTN+Y54fknPfgYF4fcMlb0XEOQSEvrRBCO0+tuisSqSeVxnxgtSPYDp14tUZeyh4kAqeximDtFHTOOE6S7D+3d+sHMWw+u2lVPNm64N+sKo54RVdhVjoqnwVhl6gplg4/XD4qhqAwRMAqwYYlM+/UzmSsexcXwj5Vr0Uz7MEmYzf2eFWc3EI36EH7VDVx3hsVB1Rc0+jcHhi5hCKFh8eQn+9HjkFMmYOARzAIRU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 10:06:44.3432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f578d7ce-b8ac-4edd-5a79-08deb720a98f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-10636-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D14FF5A36B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Function dw_edma_add_irq_mask() is not used anywhere. The
output of the function is not used hence it is redundant and
can be removed safely.
---
 drivers/dma/dw-edma/dw-edma-core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79f..89a4c498a17b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -988,20 +988,12 @@ static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
 	}
 }
 
-static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
-{
-	while (*mask * alloc < cnt)
-		(*mask)++;
-}
-
 static int dw_edma_irq_request(struct dw_edma *dw,
 			       u32 *wr_alloc, u32 *rd_alloc)
 {
 	struct dw_edma_chip *chip = dw->chip;
 	struct device *dev = dw->chip->dev;
 	struct msi_desc *msi_desc;
-	u32 wr_mask = 1;
-	u32 rd_mask = 1;
 	int i, err = 0;
 	u32 ch_cnt;
 	int irq;
@@ -1038,9 +1030,6 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			dw_edma_dec_irq_alloc(&tmp, rd_alloc, dw->rd_ch_cnt);
 		}
 
-		dw_edma_add_irq_mask(&wr_mask, *wr_alloc, dw->wr_ch_cnt);
-		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
-
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
 			irq = chip->ops->irq_vector(dev, i);
 			err = request_irq(irq,
-- 
2.43.0


