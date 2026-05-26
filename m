Return-Path: <dmaengine+bounces-10890-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBfBHiswFWr9TQcAu9opvQ
	(envelope-from <dmaengine+bounces-10890-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 07:31:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5CF5D0DC4
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 07:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E14C63003413
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 05:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406903AA518;
	Tue, 26 May 2026 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0wwdSuO8"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA931288C2D;
	Tue, 26 May 2026 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779773480; cv=fail; b=fDn0iJJOgE3KvTAWhcxTnvONiYOWOzsXK3FsiIseX+wzobMoEOfy50LAsYLyMaqaa35Y0riW4P3IKB0zGoHzcl7IRS0uqD1lNwLK3/r9eD2OS6mMMdwDfM9Z5xPm6VEdlCwNpOfL9yBemtsVkQJjtFh5JEkzZ8dWdcS2+oUesmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779773480; c=relaxed/simple;
	bh=PSNZzZTmC4aIklbwj3vQztMmpCaBZBYQVCoc8QUB7v0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fSATft6mA8Hb2h2740nPg4/gIVDyEJwpVKi4SsCNML9ts3McMg1f+8UaZE76aA1bXH2IbqJCbr6jEUjVdkS7Yq6dywwgZlrNNJxQQSWUZMExuRJWiSwFLN4okPHN/aetAk3czoivStZiMHDhnTzBN5aO472O2Bd3JLHY+yJqaeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0wwdSuO8; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY2+ZV16YHOpcmrLV+yaAt5yYTEUDrvZWyTMKCGjcpi2sw9N8N+6Fv5ksgC7dlE7sBg9PY/l9awncNqGfELSG1hlZjhWJTxlDqqIZbBTSbbeMkANzvnZtH69EBqWEfT9jdS5eCHW4DBGQeiGvZOCPzbniamLvszE9+ZzxiPKbnBv5RFDU9R9K48d4PcOTjG/IlR7kQJgOzcXVmVXJAJKrOgxeWv1GgH58C5pw6XmXFCu+GrS8JekdWWX5JsxaVY25uy/X3xJ4TujBwmZi0fAEjCeOAyHzWBbXdHpwMxZw6vVSbMyvFMRvjBqyMQ/L6fzvsUo/Rkc8xXxlpv388aP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxqhasvgijlJbOVp/y7CjOrhpeJBgbRS2hVG/yIHl1g=;
 b=jZVFqvTEUM5wqM8mS/fmQ+EbpUdpI3EOsEVbPkGeBHb9FeHkeBc3OBr8wmWjRi5E3UoWWiGVxtq7sn9stdiGWf+ItCPGuN4UTJFUaoQ97q1k6RGIEhkLsKh88EEa4RqGcYiQV4KGGFYYR/vflCZUWyyYj6dKry1OT474B7Q6aLml+jnW9P3MFZodeqBwEiXP0vyB81IfNdjFujE1Of5nzjnPjKNQW1YjPeivFeBjk0Sp5d5C9WLv2I+d5W2P3cclgI5AOXQ3xy26EIKt3S+zIeyAUCT0+vWlKxOBvrQ7nDIrgmf5eUW82A4dRDPkk7ihFAXHxtK+o65CD3h02qqfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxqhasvgijlJbOVp/y7CjOrhpeJBgbRS2hVG/yIHl1g=;
 b=0wwdSuO89H3lqnBbxiD3o/lA8r4ZIEzs7HEyIc2nI5OcKC0yJ2m8GqB/K7GsJank1BiNEY9Dy7lR7GOqO+0kTRQnB7x2zXXv3elZ23ATrKSiq6vPg4m5Fuq5jW6TkmZdoVaYgm3b2YA9cil05Gn0+gp6aUPqu0nJRAgKnjHq2Io=
Received: from CH0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:b0::35)
 by SA5PPF5EA4322E1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 05:31:14 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::3a) by CH0PR03CA0030.outlook.office365.com
 (2603:10b6:610:b0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 05:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 05:31:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 00:31:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 00:31:13 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 26 May 2026 00:31:11 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <Frank.Li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devendra.verma@amd.com>
Subject: [PATCH v2] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
Date: Tue, 26 May 2026 11:01:10 +0530
Message-ID: <20260526053111.3244488-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SA5PPF5EA4322E1:EE_
X-MS-Office365-Filtering-Correlation-Id: 2326b2c5-43d1-4329-bf9a-08debae800e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	vncRlaXGzx0+6O9snDYz88DMCpWla77pWP+RKAeHhy7UTzKoWUVMVfIcCjWPSlAhg9OGIquhlOOx65CvGTYi5DFGhM3EluOCM/3IDW4Y2xk2W0fr2/LI4pdoc/sWxTSWfexf+uLx0Odyh4g7X2PH2RviPZTieIQyzn1zJ37nyMX2Cjp2Bp/9DtpafdOYr6KSgHF2fs/elcdkLrSAx65l9rYK2iJ3PTsTGw4Xd4+NYCzs5tl1MN72+SQt0ycnNCZliqiSjedjKw8KbkRNHo0sKrpk8Rf4YrG/iD8S7Xo+dBnPvf5A+U+J3iNosM6Gkg0l/9FTgyVAyHiono9OxKrZUjS/h6h1A1q6Re6A3WyBmsQxT3P45VuCMe6NgC4qZ1KGfi+FiPKdQZTrH7BMiVk6eh6oQvLPIc5x4vC1zssqeHn9X4ij2qElvh7ZNaVYW2cuG3rt+w4NSmHWm+NvNDuFrD2p60NTlf2AfBFWzJm+AWNBMIqeNlXtdeORTm7QV8WJ+2FLpJnEsqRrQ8bkU0GHkIz/UhabQUMBLW4VcIOdtnXKeHXYOEmWF0l/+Hs10sYny2GCzhGQSGvXwq8EcoCawcSfcWFvrpfmfWP1NvYCfXfcAtIyV9h9PdK/XhBbo05b8fhH+uCFhUK+uTPcCmQsLSjjn7vPs9cUxrV9KV10DsB4TnckUjV1mWYzBjzT0fxr2Nkq0aZs/Zj4qfKk71aTZeBcB7fe4F6c8eqyEqYP9aE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	civukLCEWy404fdoeJh0CY0v4sj2pV7MylOUnk+T2muzE27CC8IOAUpvSGcwY6TqFqQoQ0bcLG7lFL1EFHFQlS5Ge81aQ/ct/2Ins8G0YHkoVT9DvfYV4Pm2tf4+6wQhQVg/Zsoz+uzcaJCfrrfDNvER4h4s9tWPhgS7AtEx454sqRIUL16cJVabIEPQj5C+ni1JAe9SSgjwKNOgRqHSox+/ocsyROhtEKnRNKmHZsx05pSd0q5+XYLSG8AeMA+umqxxxSjaGBtLNrqpSiJ39BleLMep6B7wdkp5otpgRUhrzvI85zNc6EVQmdx7yGlhvoMwdLDZ5XOUBYKx9xK6/Y8C1grWCVicvhH0XFcy0tvIOeASjQWKD8PRfwtORKfCMc8SghccSTxAZAsPa/thjC1AL0VM8Ps7TnbEtADJ8AZXt2B5ABtHwb+QOQB9Ab6T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:31:14.2827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2326b2c5-43d1-4329-bf9a-08debae800e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5EA4322E1
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-10890-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,amd.com:mid,amd.com:dkim,nxp.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EE5CF5D0DC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Devendra K Verma <devendra.verma@amd.com>

Function dw_edma_add_irq_mask() sets the mask of the
interrupts alloted to read / write channels in a variable.
The mask set for read / write channels is niether used nor
this function is called else where, making it redundant.
The redundant function can be removed safely as it is
not affecting anything.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v1:
  - corrected the missing tags pointed by reviewers.
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


