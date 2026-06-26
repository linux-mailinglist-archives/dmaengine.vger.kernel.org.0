Return-Path: <dmaengine+bounces-11809-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zfgOHwpGPmrSCQkAu9opvQ
	(envelope-from <dmaengine+bounces-11809-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 11:27:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA2F6CBB09
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 11:27:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=tUprCJGR;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11809-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11809-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16C393069CBA
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF53E51F7;
	Fri, 26 Jun 2026 09:27:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6673E5570;
	Fri, 26 Jun 2026 09:27:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466035; cv=fail; b=mRmy92KJPgeOCEsn8pIH0oSxjDN/RZJufr0o49MgG20/Ka+SHhKVwRRBuWwrVjZARN/wKCb9EaFHojg4CRhybs6akcfPqb7fRxFSLvqzMPG5TU2RGC4BrfUDJoGOQBOectvvj4TxVffFEJxZg+fHfGcyUq/HDU2SqH4Gb4Jov4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466035; c=relaxed/simple;
	bh=U3UX/CncW4s7KT+BkTqaaPjbLFytKGi2zb33zIEHtSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJFRnaf5zApjbEUTAYjQ6+2F+fbuKxHdenWBdiEZxR47SIzjlrxD3Nn38oIKOvHb/JrQFT+8MkZz9YWpe64/fWkkBNzw51a6IkL9h7gApbfAgzH1h7BLGHtc4VQePjtUtTtjG29T+0YbaYLuUUm7wrJBdDfx7earKxYt9SwaiOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tUprCJGR; arc=fail smtp.client-ip=52.101.46.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4ygFtWcTMq9I7N5cOhQ5a+J/Gjy8etnaYnN+rNVobygT4yAw0ZJLzC5dxZ3LXhcCf4R2In6zhWsX3JnwIpCFwiMtoOyefo5gDZY1gw+TW/qgzWK3tbThpcIqcJsUUsqHozcCAOdKnTCyS791dTDZ7dB6T/wZVbAC+XY83gvyxEiq8xFtCbMamRe2d4jAFo0QP8CakrlvOH1rlTMQJmKwL+wfWrkap0/97QWygPDxdNQqm3+sr6QWfplztxHbk1/s2Q8oj2CyO+Qu+TAXlyqYws1HT4Ztg/zNFDsf2Bjs6A4X6n1nqvRvJn4MHFosULpuB0Nzv0lQnzHHONvzg5QfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuWXUg+L5G4q1vuW0NzZ7ISjcHJRItNY/483fn+wDKs=;
 b=lGWN0RW3Yc8K1DCe+CjTO5Ce33qGP7uG8BGJzUwlzbV1SuCttUBhx+7umkEPwVjNXJH7m+u5VX/rR47nYgNnBlO3lQeqNGCZ3u/8wOeiFS82CX2yLoMZTXNFLNTq7BtMG1w8Ik0HDVynZEfLJxnLM3flG3Qe9PQlUdVFSPXIg9mL/d6b5r5HbxTRYWTEj9CRGTbk5RiySlArp9bN2/n8TCTfp3Jctuha6eXImep8iQpAGqzXbVoaEK6wbyJmKz1WZ8tkrIQwZm2RbzVehUikCSEwbhUXj9clGCCkp/pZQZDdpq4g09mmXm4gOu10tppP5sl3Op0r52xTeYoEdBPFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuWXUg+L5G4q1vuW0NzZ7ISjcHJRItNY/483fn+wDKs=;
 b=tUprCJGRaf1NPp5CmtBR79YG0Pij95sdD2vq+3YRTyHEHkhUeffWe/mslLSJm8RGfMBAcdSubR0Vb1hXbGMuos3TWa7Rsb6CXISIciX7GfIxu/JGzK++O/X05RRQJAGXHtcbZyJBe4EX9V2ALFsCTrrVcJZqv8uAyD191Xumsfc=
Received: from CYZPR05CA0002.namprd05.prod.outlook.com (2603:10b6:930:89::20)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 09:27:10 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::7d) by CYZPR05CA0002.outlook.office365.com
 (2603:10b6:930:89::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 26
 Jun 2026 09:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 09:27:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 04:27:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 04:27:05 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 26 Jun 2026 04:27:04 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<dev@folker-schwesinger.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] dmaengine: xilinx_dma: Optimize control register write and channel start logic for AXIDMA and MCDMA in corresponding start_transfer()
Date: Fri, 26 Jun 2026 14:56:56 +0530
Message-ID: <20260626092656.1563871-4-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8387dd-433a-4c0e-7d63-08ded3651927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	MHsCr+CngTY52aHH/gWYTOFC/af+o3GJozJQ4DdhLEtPcicQENrFsT3DlRxzpEUiImif9NBwQgRrShMK/kKzOy3Vyae6l4ClgtU+X7KGyR7cs6PZREfOXNlfbKVPMgQdBpMWRS1iFmp32mRBLmWHrgeEtSwD7I+jFvKrq6U8+EbB0iyyi86bnFSofkDPzMO6oH6uItiOxhcSr3zXwZjL+oPaIK9F0SpMgz1DUATBWjaEEL7tVKUiP62kfnMdB+nFcgDQWt5C9K4Ya2kMdORt1RMeVAPtv4kDTlIjQYwcfX5H9TGKuRA/aSl7W8kycQqEr2JAPD4Dpg+OQVv2uevWh2D1fTYjewEHZSPbZyrVvGDzyCS5/6h+0pgXhZXYeDwnMVXrtch+5FX9NZEOIlVI/SXVmnSl5ivMWkHX45w9UxIlH4lCk35+odRnujV4+INCreNrBOoMy06niy5cGamBArEqU8p4yJAg0TgMCtuhSMi2Novvm0/LC6Qr5xK8Pfe602MfrmeHwQ8WYuGtP+NYMEb7IBa7qCgH/dE3WYGkUSizki4yZlIXmStppBfS1kZfM5nui+50Qg0R4YlUYTgaLbK+GY1jXyNHaY3vw2qnCDgNy328dHrta3ayddCwdohtv6DimTryys1zFS0Ns59cBd4bvVjdBin7/TedV8tfK+npn9yfi9ULRNasUm3JeZ2SRDjnMeRLiR3j9yqkfrnygA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HhwofPRdDdYwJCUwXM/JxnzuLKdVgptI1XHVf2vIURmodGbLU6oCwkCxzPI2fss+LMmTMLXSDnK4N8kY29rcfFB5VOwnqwOvFBzSxnDWk1zxb/s5K1nJL94S0wexf9S9JZj4/uupg1tnW6AoUXZX1Ko9xpCZa8v5lQ3tnQwKOaFRDVUPXqtGIUynq2FMhUdBA73LG9C6urMMWgCTUX2t58U7B7ledlUm4FISivNCosZPoYDaUxvTnUFjpUPqx/0Lh3+pi4i+pmD5UZIDJRUyWaRqP8LhuJoSH9yZaleNOvpQ5XO793dt+xBazlUnmQRpFX4KiUmLK5rS2TOd/lHz+ro74IwpJWg7qfJN8ry9/QwdOjVORW9eZoq90JQnEXk7rcLnZhJX9+7Ez9FVFzebpUezU1pJQ/Zxf1uEcz8CWt6J+aIyW+6tDInmF9+sfA2R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:27:09.9484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8387dd-433a-4c0e-7d63-08ded3651927
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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
	TAGGED_FROM(0.00)[bounces-11809-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,folker-schwesinger.de:email];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DA2F6CBB09

Optimize AXI DMA control register programming by consolidating
coalesce count and delay configuration into a single register write.
Previously, the coalesce count was written separately from the delay
configuration, resulting in two register writes. Combine these into
one write operation to reduce bus overhead.
Additionally, avoid redundant channel starts in xilinx_dma_start_transfer()
and xilinx_mcdma_start_transfer() by only calling xilinx_dma_start() when
the channel is actually idle.

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 6e7b183cb499..829601d8a16f 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1603,7 +1603,6 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
 		reg |= chan->desc_pendingcount <<
 				  XILINX_DMA_CR_COALESCE_SHIFT;
-		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
 	if (chan->has_sg && list_empty(&chan->active_list))
@@ -1614,7 +1613,8 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	reg |= XILINX_DMA_DMAXR_ALL_IRQ_MASK;
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
-	xilinx_dma_start(chan);
+	if (chan->idle)
+		xilinx_dma_start(chan);
 
 	if (chan->err)
 		return;
@@ -1703,7 +1703,8 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
 	reg |= XILINX_MCDMA_CR_RUNSTOP_MASK;
 	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
 
-	xilinx_dma_start(chan);
+	if (chan->idle)
+		xilinx_dma_start(chan);
 
 	if (chan->err)
 		return;
-- 
2.25.1


