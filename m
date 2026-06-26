Return-Path: <dmaengine+bounces-11808-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BLN/E/ZFPmrBCQkAu9opvQ
	(envelope-from <dmaengine+bounces-11808-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 11:27:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B77EF6CBAF7
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 11:27:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=CwTEotqs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11808-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11808-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07F28303433B
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A8E3E5A01;
	Fri, 26 Jun 2026 09:27:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605713E4514;
	Fri, 26 Jun 2026 09:27:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466029; cv=fail; b=NFuJksuz9cWwo53rssxpW7+WM3ZW8DWhd1nOn9o2mQjp+y9K/kWBUoq9MGKuljiw9l1W2J2lrycNAL4yWnlHbCc3spDwVfJz6+5cowAe5bgV3KxnsR9cOTnCLKs+oE4n9by9qYBevgtbJIr6FlFxbjz1Hj79f5ik93S/Ub7y+50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466029; c=relaxed/simple;
	bh=oZLlYd1fGmdUZY6jJjEq7XrtZo9e3jm2O0mtU8Qx18M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQO4zdOqSZTN+4Esp7RpakbRN0w5uDrVsE4Jo/M80ItHCCSr8OaYYpLuDPc4Jq8MsCtMynDPacbSXxSw50RVmhscRKAxIB8mdDVS+IMmdulFErVu1d/ABi4wc7mqtTcCo/YGt+NVG1jIb5obrbouHoCuGCB1U+SdR5ZYeccn6WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CwTEotqs; arc=fail smtp.client-ip=40.107.208.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWqLJUDXRP7rCN5MHX3waXioJsLVpihWZXvfeHKNLlDO1clMjDXmgc1YY4fOrmWdktDF/sEyOn6824Wmc+fKYAHiDO563G7oVfcK/sLsfKImRDgl5++FLEERq8DCKhPimCLsM9nOBTxSJ97H7fQen4JWtYcuDfTYdNzO8m0qrCM5sEjPh+bZEWDUJvYlSGtmtw9uBdrN17Uzh+ucmxaYmJf8OzOwbROfAzlFm8RKSKUdAfmFpY+94unOnVf4BysmbK86svLMn8Jv3VPzX5H0aBOFFCIDbBFVoATcMT3A+KF5ryN5FpL+RsBu65tBzTFRE0dVD2yTnBdt5QfndnbJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qok4EtcDiokDt7vS9kapu/YhCtuezGoLX4IHSn95mU=;
 b=Nm0ite/lkLuY1QYoGrIs0UQk6Jg1Ci4UNV//sUWXOovo29+V+dy6K+GHbO6Oqhlqeynj8VyJPnTdfxaRhp80x2COhQBn/2aTBbKYz5dnR5i3dwsgBaXDk80gaJoGJ8fwh3+0pjdlHDzLo1HBUyjj1Zz5T4tH+wfvzTLnvehY9JQ4USVS+HpkNiUOIeAz9Zc7Yy9Fw3Q9snkglapA4ZLzP0RDqCpeq5jBDz/VL//wmWCrsVACEYZWylStLpBh8nDdqVODTwmsIkCtTf37mh2TGcefbArlFvbgvGts7LOCgQBZ7QoNJa/dfJI75PrtC924qP/CwmadK12H6aFWRcE0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qok4EtcDiokDt7vS9kapu/YhCtuezGoLX4IHSn95mU=;
 b=CwTEotqs7Sl57md6IXKOaWN4RSbElqW3c/CLZLowOnMbN+jqxLafx+DDIxgSTVmJ/TYHAPk0enYbaSj1QSXILru7SqQJQx7L6aoJBFgMDbJ5VMEU2vUKHjp+kghzO/Hi+oPRZ1R63WDDU3hLGGDZnMamudqu0agBVFdG+SYWeWE=
Received: from CY5PR15CA0081.namprd15.prod.outlook.com (2603:10b6:930:18::23)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 09:27:04 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::84) by CY5PR15CA0081.outlook.office365.com
 (2603:10b6:930:18::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 09:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 09:27:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 04:27:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 02:27:03 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 26 Jun 2026 04:27:01 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<dev@folker-schwesinger.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] dmaengine: xilinx_dma: Enable transfer chaining for AXIDMA and MCDMA by removing idle restriction
Date: Fri, 26 Jun 2026 14:56:55 +0530
Message-ID: <20260626092656.1563871-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260626092656.1563871-1-suraj.gupta2@amd.com>
References: <20260626092656.1563871-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: d9592edb-ae7c-4684-34ac-08ded36515d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aEVmHLWcroTItzTAUvUEwAEpOZ+eHBsp3Hl5diUpDRj6pijtp7J/rsGCVdPa8Hqc7DXlYghas6UFsqhHrKOWh2ESPWR3n1Xo2E9Jx8l9z/KTnuWopYFr36ZvzTYPc+CujBKjFLRd8qHDrt0nSFoEpzgyMMlgj+UpBIp8+aaMr8NjXvYOj4uUOH2OlD1+ZHAidhvnpi5C2K51zeEqH/uQU2XdxM1zYrH0uKT6Dty7CWJ0OG6ayJ+twO4SL3bTSegE2i1/Y+vwuGCeZ8TKB2DWiHz9BnnyzNw7RLxVufqW6sljChKht4EiozkuB0JKTtJvax6DcOK0TbMLE7KKR+NpErXLAjraoY+UF0EmDIQZBnLEfBLNzRJtwRPQ3bASBqXmPi4T+AUwaVlrc20kHNeMiwAKoLf5gHwJu9RcaujQnhX/F6ruSgyK8WRv5TDkeTY9GU1PqOVVeYkG8XF4iaAG+Nd0CfIpodSp0byPFXBa8CFh1Qt1u3/PRZO6WoOZyiPoxOqJm7R7DFbmxb/6h7qXsQ/CD4GwP3TXZDYXvdHwqwfMi3puMvSSnNGof2G3xD/7T0dJjrp4b9qntU68Xj1x63MPbQE9I7GkeM7vO2HkqiTH+iQ3T5a44gRHfFFmvMPSKsSV2+n9YhJC/cQD9K4P3wZrib3DBDge0ZJTWFCcVc4dSI9jH+KeQdL4S0AIseQ+UFOrnMIoK7VGr0RYvw2mIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EFLTaDbWyARCibMH+YknT8G2tiFkIPKkuVSENNVCmUwZ+YlghVMa6Eg9kq2o2eU8+S/k/DTqzcDsiJ1vrZuraRqmQxRmR/ykHcIQ7wRKTYTh/IxAlrUtGdmOPGLkV+xvwGf5b5rlago4DYnzm99RGZM5BunSPiIdW2omVztQi35D5AJE2lGu/8txWygoa84hQwIS5PWCTGkVG+KO0x8gkrsYkL9xaxQ4obPmCpeUqvhBiMjlxG+KZECPYz5GeI2Z7TxjdH+GvUFCzwva7yEnjkCOvqo7bSGYExBrdNiyQmd2PqvXj88Dm0YvJlrsy/2/eVeQph13SlwqxEQHT5BWvXZQlfaUacphPnRMzcE5foZz8pW4kJoDPFaD4ZZjbqf/Wp8cGaCawTA5SY5FNE2nvzPOSY2VBhqbpZwgGy6CAWPZf1NVc3M2oZfmFqxXByAh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:27:04.3899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9592edb-ae7c-4684-34ac-08ded36515d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11808-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:dev@folker-schwesinger.de,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B77EF6CBAF7

Relax the idle check in xilinx_dma_start_transfer() and
xilinx_mcdma_start_transfer() that prevented new transfers from being
queued when the channel was busy, so scatter-gather transfers can be
chained onto an in-flight transfer.

In scatter-gather mode, only update the CURDESC register when the active
list is empty to avoid interfering with transfers already in progress.
When the active list contains transfers, the hardware tail pointer
extension mechanism handles chaining automatically via the descriptor
next pointer chain, which is set up at channel allocation and preserved
across descriptor recycling.

Direct (non-SG) mode has no descriptor queue: writing the BTT register
launches a transfer immediately, so a new transfer must not be programmed
while one is in flight. Keep those transfers serialized by retaining the
idle check on the non-SG path. MCDMA always operates in scatter-gather
mode, so it is unaffected.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ca396b709742..6e7b183cb499 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1580,7 +1580,14 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		return;
 	}
 
-	if (!chan->idle)
+	/*
+	 * Direct (non-SG) mode has no descriptor queue: writing the BTT
+	 * register launches a transfer immediately, so a new transfer must
+	 * not be programmed while one is in flight. Keep such transfers
+	 * serialized. SG mode supports chaining onto a running transfer via
+	 * tail-pointer extension, so it is allowed to proceed when busy.
+	 */
+	if (!chan->has_sg && !chan->idle)
 		return;
 
 	head_desc = list_first_entry(&chan->pending_list,
@@ -1599,7 +1606,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
-	if (chan->has_sg)
+	if (chan->has_sg && list_empty(&chan->active_list))
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
 	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
@@ -1660,9 +1667,6 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
-	if (!chan->idle)
-		return;
-
 	if (list_empty(&chan->pending_list))
 		return;
 
@@ -1685,8 +1689,9 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
 	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
 
 	/* Program current descriptor */
-	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
-		     head_desc->async_tx.phys);
+	if (chan->has_sg && list_empty(&chan->active_list))
+		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
+			     head_desc->async_tx.phys);
 
 	/* Program channel enable register */
 	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);
-- 
2.25.1


