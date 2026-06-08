Return-Path: <dmaengine+bounces-11297-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e9flDe+fJmo1aAIAu9opvQ
	(envelope-from <dmaengine+bounces-11297-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:56:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C1B655619
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:56:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=OQkEy7U7;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11297-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11297-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7916130C8D24
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CC2F1FDF;
	Mon,  8 Jun 2026 10:25:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6ED1E5B63;
	Mon,  8 Jun 2026 10:25:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914303; cv=fail; b=ocAHIRIULS7uHQz5prwTTuweDdz+OlMTsmSDRFAWrCXOJkWdGqpgnHnxGZMpganUgI/dHJpzh1Uhkke+B2Fk8dcp/tnWEY44EzVaVBqWEjAUGcWzNbPG0WpIuXv3lpbanodPTRUOC8lkYx/W7RZBncELK8FvSet+MdP9CHiQ5+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914303; c=relaxed/simple;
	bh=FJBH9cSKFF0c496wRoCfA5nftOTttaCM0M2XPf+8dzI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZo4bR5bqOQhcD5y6SOdaiW7YOX6BrfkkOd3oD+WIqMEiHZNKkfBzosje9mk8Kl93PS+qf3gAXEmX3k9bpBe/C1V0Qsa2HU2fWUwHIheIvZbOcBhaCCmWRY2U5WHdXASJli9ySVfHoECXicbxODLLQJhQTKNGXcCHScj6dYk4rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OQkEy7U7; arc=fail smtp.client-ip=52.101.62.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBn9O2DUfQt7rDle/otI9jAHM+vURy9dT/6FViDa3xE1BsSMpDz0Egg1AAGiVcRUPUshb43xwlMUaTowRrmehiWPnREv2EYZXT4EVwc6o21ipsKTlHhXmoqdE4FxEHOF+oPKKMi5ikE1TkbBUddkmiSlGcMGsXj03MGvs3FNn6ToznuDY8Yzc8zy1KaZbrfPJLmV8ec7eIVkB7Haf+PONzPvtWkAWAXlqUOloy5vr+wC+GBeudZaB8ZaVajeg+bX379XBBCGm/gy/Os4BLUZi5mKx/0ukVk9cQuvst5XLUlr9+JvFFYYznDvQMJmSz7XRAhxTV2wfBw1UEI4c3JQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05FQPoBjtTPJuHLWAEoOghEVrxhBkdLXlwGYl7rxwGM=;
 b=hURlC6DJcboU6HomMu6/rvQZIsbIkF3tDVcmFo5YsjXstc5CkeZk2/LNZaRI+oAoDSIL9C8TKWwsOQTVas5SvGD3niyoGbh4rhooND4/OhXmzyRMKsQV86haqXYgsJt9tZ72slh1Eyj3jIu/Zx7vJvwghIjXdQKbDGmIqAoMJAb9qqNpyWPkwM9c5TMekFMiREZxAZm6fcIfagQoJRyiXQopJDBlOtedyi3aKE6S8SZ4EYxooJU/DfHoZnZN14polHsLVeuAzqlbpYtCuzFsBaWTmmkJwLp5NbPVnpT+Q79OPGPzNzYk5cRt14AAEZSrQSq75mN/FisJJO8sFxUdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05FQPoBjtTPJuHLWAEoOghEVrxhBkdLXlwGYl7rxwGM=;
 b=OQkEy7U7vlQQ6cK0VbQy5s1paCvYTQfWTmmJKQieWsmleH8hDnifIDI6nCfJIkbxsarDsF50hzr9V2n+FrpVvmh4XAJ3keA1JSNmpbYnkRCLcQn+W7tOQxcmbgswqXQ5v6ggbnwVEV2kBZu/xTqMYLOfAJ+Ez7AUOQfMSymBYj8=
Received: from CY5PR15CA0137.namprd15.prod.outlook.com (2603:10b6:930:68::17)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 10:24:56 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::9e) by CY5PR15CA0137.outlook.office365.com
 (2603:10b6:930:68::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 10:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 10:24:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 05:24:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 03:24:55 -0700
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Mon, 8 Jun 2026 05:24:52 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <Frank.Li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devendra.verma@amd.com>
Subject: [PATCH RESEND v2] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
Date: Mon, 8 Jun 2026 15:54:52 +0530
Message-ID: <20260608102452.3255808-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb30ebd-3652-47aa-974c-08dec5482f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	VX4O11sUHhjxLkpv6nKN/eFxfQIqxGyEKniRteR6bYnurFaDGhUkoFfPO+ew/3PVMLhV71gwtnBO8S9aztL7tlQg07uwI8HTGHuaC2QFSXiApYYVLQskODk8PBdcBF2ZbzVlkA2JVX33WwWzok353y/yso1Vv802ESSl9M09vPO4az8ZEFejhAUNtsNZ8S7d6g0jCi+zNYchXgjrAF1Ma2ajhHF5s8l2dGd9ExW1NVgFHcj2UnBMatju0eaG/RmJmVcfbGKuRFDcwFC1ZofjVcjQ21FQcG8XDDQnjsbiNiBq5YVyJ0VOLyjWYShZQBRP89OsT84sDKfcJQwvMpo0XUlEAN4Oud/FfPTObzO6Tu99qrCZL8QUJQ4wR9KlLgxZztpKbTI8Oqr5WPDgFm/wdhUyrQE8hetFrzux4s1uZ+s7+gnKbAGZz12ZDtl3TusTH87bF4h2tq3XRk8y1j0rfsBRGZFjJqflC3kMG1zcwTh1ckUjcsp14zEuHCy4qCn6pVIjOUiluYQw2UTrGjtbKoinWuytfQiwPRc5k6RtSHi7gwROfIm6MjKw1gA55rXoQy5MXB/rtrqJWSBEebJEBtDIOzww1+P+PJMplL0AYaFEcdzYdfb7uYFtR6HZJbPHzNdwSRIgyCBZSYEDg389DJF9krUtBQuekuS2pQ1kcWTyWLkwpel68VTbnIqnCw8T3xbpDswNtuU7jEuY4LWs2hFbBQbBYX7fn/8Nvp1l8co=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s7sWn2LDCSiauzNAJ4g7tdeIbFbYZLgB8KskpdkYVqhvdPfDPcuL/iCXftfXSstY5DBPAxUBmcC79dI2Skr4ztnxvvX8LSZVSpqz2FlJ6n+lxC+/mk3tYMLUOW4J990ip6O3UjOCLHaKo8UnVrQBkh0Nh8S/4t53hI5FCZEYClK+u6sp/CmY9p2pMWOiLm2b30M0+Flu7vynRhKhQcpg1mnzH0mjscOzjfgvTTo+Jnv4zkQbVSzgcN5zFP0YxqsAyu2PmR9E+0lEQ15DYyyX08rjaA7sRq+ekhrSpqBwN3T/SWRhEvvDPoccGUgYcLkOx/EAUFIbNFxk86KZIgTZIYMs9o9poqFfRUsLxPjSX2j8AQFWHvHgqapjZGcxS9y7lHBb8PTsW7EchImc524uX3i338lTwCYWSIhmQGgVy0R2aU20dUTYGcAkEK2zwIaI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 10:24:55.3837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb30ebd-3652-47aa-974c-08dec5482f40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11297-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87C1B655619

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


