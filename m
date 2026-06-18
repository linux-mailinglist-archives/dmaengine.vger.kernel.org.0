Return-Path: <dmaengine+bounces-11614-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IEyuNoSaM2p9EAYAu9opvQ
	(envelope-from <dmaengine+bounces-11614-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:13:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE769E022
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:13:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=i7YMSOCn;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11614-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11614-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A723050A69
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1D38D40D;
	Thu, 18 Jun 2026 07:11:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEF2877C3;
	Thu, 18 Jun 2026 07:11:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766685; cv=fail; b=q9QSuJz6B9vaygZFqKZ1lTPDBysTzLl4H0YfoW74BM2IiDU1hhU5zJQATgoQJK/N3WzfKlGOggucyarvjJGCVWxfcvBNNPNfFhWLdq0S7Agf77AJHSiEqrEbSytAmwRuxYPRk9V1icWNELM5vCXunc3tXFtRbHeB5d51l0rOGKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766685; c=relaxed/simple;
	bh=kWvARxBXGK4c5SyrGGgtVwjhCeLC3DM0ZTRhwdXzzVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3yJjMz84Au6mBilfe7w3D7gArFdn64cOPIIcP8geT/XxoT174s7MecoDkURM2TtUb8cL5i/ieai9aD3lwhIdTg9MevfvKejFoWThNYbJvP0hRN6kWZqwDjpqRGYdwPUtEAuIH8EEx4yRljGB5rR82ms3lPkhPwNlF2olyXji94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i7YMSOCn; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP6Eb1F+24F0Krfvi8gYi10avk/FEHdYX+hQoXzg2xWvyf3xX27W1KFJtL0Qj3OXRslze3bLIR9hYJSh1JQJZznAEJNNiEUGeMU3or21qzGIOf22stMk67DiNLm4w/7gqFOOk4fsy04+GA4aN/hKQ3xvbGH23aVJ2pDhqwoGx7VW8yL5vX/Oyyc3rEiP/x4PVy1Y3oKJTUYC9l/00nnuAGylOlHxqfYXqaOIlRfehYSUtrCtCTUwIEL+T6scHrq6nfN1QHFG0IVWmSImpEVWOyiy/Ji80g6/WxU6M7r6mLnFDF80wzwJHAROM78NgFkaYn86L6SelFX2QsrLEg2AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNdb9DXpcCoc1nA+Psqz7oGwRQ8AhMwKGeUPrchz6Pg=;
 b=iAVKD6sR/Ufp38S54VNythIR5xrAvP/GMM4AXpY93vzWOxJ3PE/DHQA0csw/P2t+ez9y8iQRDu0L5CUAJwvLAJNm4yDFZnwXVznfxNUOPMswzkGB1/bLW0hcCvg+ecNwWm6rnKRJyip30TQJIoQkusOQYlfxzYwaa3afC0QXgIkq61Pj8E5Dj227xQPnHpu7eihF4e+r4PIyHKnuw38rZJ5HgiBMQc0OrYdT8xxnjFvdVvz5Ys5uaTlCjwP2jDQmeUjlGcbwpUUp8FjpdLdbwTQ6adGSEHXLYmNvx2FlifYEMzwF6amJdRH0zmPUOqmOr4yq2bpvxTD9ETrJVtXJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNdb9DXpcCoc1nA+Psqz7oGwRQ8AhMwKGeUPrchz6Pg=;
 b=i7YMSOCnUXU9KwLr9aSmCAEa/LmAm8PWowI3R7Xx3YjIYiadFi4OCdwAisNVDG4mcDmsK8/crs9tKd7RjeBXkXfWhbEWL9czkAgjV52Yq4Penl/3bPejkOshJRAma+xGEURIDpKuN/+HJudTijGNlzP4LaDOccCEJ9KoR6MYyAg=
Received: from MN2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:208:234::25)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:11:19 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::8) by MN2PR16CA0056.outlook.office365.com
 (2603:10b6:208:234::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 07:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:11:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 02:11:15 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 18 Jun 2026 02:11:11 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nagendra.golla@amd.com>, <jay.buddhabhatti@amd.com>,
	<harini.katakam@amd.com>, <m.tretter@pengutronix.de>,
	<radhey.shyam.pandey@amd.com>, <abin.joseph@amd.com>, <kees@kernel.org>,
	<sakari.ailus@linux.intel.com>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 3/3] dmaengine: zynqmp_dma: Guard IRQ handler against spurious interrupts
Date: Thu, 18 Jun 2026 12:40:56 +0530
Message-ID: <20260618071056.2024286-4-nagendra.golla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618071056.2024286-1-nagendra.golla@amd.com>
References: <20260618071056.2024286-1-nagendra.golla@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d4c295-f2c7-427c-f7d2-08decd08cb83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|23010399003|36860700016|18002099003|22082099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	UIdBq2VtI2DtE1v++eC82AhmSxsUYTtNIo/RcV89KsqrDG4vnx1uJQh39I3m9659wFUjfydkmuzGy8+v3Ri3GyKl1NQjfvz+IRve8EMuEBNMTU5eHgwVf1CLcWqg4u9d5IGA1sFDP1mPU5ZUTpg+HD5qDGPpRmXEmL1SEDbDKzrU2EJtfnpExDXX7uKVLy3ZqH89wCtPe+uPFXB76+cHpBA3LhfaXe+zLgVkXX31x2w2bDBqGNwND+yDZYIFVCdxzI7/q1UsNtElIRa4BKhbBsUfyeHWpPCTn3pFB19zNH6MxSmdzMa3Rniv95EcZJu4svLqgdVx2Gz9Nj9a2i3as4WVwZ7xtmTVxeAaRYI0asaWI0s+YcdDrQX3a5kzwLBsR+lsvWiW33JQviXWhUoFWWtFceE5fl+h+c6dE/5mX3SLsm/QPdDHSOnTV19HWyVvygoiB/NE75Mm92VYIUPzHq+P4Gse486oMjJn0y+acu5cx/t7xjWG3l2CfSd+NvzAyOdOwe0UCUNeqfntOgIFJcLvnINEb6xRC1mK5vGnWHM0o7MWSslC/P4J9zrEIA21v1VUd3JDboJS5uZNbk8Gjufj9Fz2ypAJxbAavhrtQYG4uSe3c13Ey4dpvoi0UcpCE8bS0Y+CPb790zw57dOToWvItovI8hiCQLX7jvWzvpIG/Wvz8+eRLx7WkxiTFvaFLK05etSgcacArUEnrEiQkkJQuZ87wfhWRTMZhcTNjmnjz5dFhqB5aLPtkF+hHCmRwsixgio2IVAbSydFdYAsYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(23010399003)(36860700016)(18002099003)(22082099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fegu17DNfmSbbpIdOWLCt+Px0OCmuSa8Cc+ZKw+kh94J5kyl+NJYmb4qfwoh3ILsXpyYEHryFIv8NyQl+kLyCKK9FOAaOOAY3/dHuu28jTvHDT3fzjRIXihVvHynYV0fpU+O8GRwBvu7264G/yOTLF8isKeMqw2QaBfSqs0cP1P0/a6oWXB7HVCCTeJhq2uE7dJyZsnxLF5Jc4IM7haCGA4/ZHgG7G/Biqy7tZg4PX5RA/jWjRB8BaNdPoRkrPgsdd1t6qlzYQur0TsqLfUiFzJb4aFbyEioSPA5F/bThq/D54BQnjDTGgbY27sXV0SvogamkBmde9MOu9cRJdnatB6TvadO7uItdOv9LUHV2mXfr0fcrhGMapm3pBIj+aX6Myb9MaAm7yKXysjYanu4It+9QAVjCGBRfUG1RjnBBYtwcnIwn5OmBBQ6PHQT8aoz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:11:19.0615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d4c295-f2c7-427c-f7d2-08decd08cb83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11614-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:nagendra.golla@amd.com,m:jay.buddhabhatti@amd.com,m:harini.katakam@amd.com,m:m.tretter@pengutronix.de,m:radhey.shyam.pandey@amd.com,m:abin.joseph@amd.com,m:kees@kernel.org,m:sakari.ailus@linux.intel.com,m:git@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84AE769E022

Add pm_runtime_get_if_active() check in zynqmp_dma_irq_handler() to
safely handle spurious interrupts that may arrive while the device is
runtime-suspended. Without this guard, a spurious interrupt could cause
the handler to access hardware registers (ISR, IMR) with clocks gated,
potentially leading to a synchronous external abort and kernel crash.

When the device is not runtime-active, pm_runtime_get_if_active()
returns false without incrementing the usage counter, and the handler
returns IRQ_NONE immediately. When the device is active, it increments
the usage counter to prevent a concurrent runtime suspend during
register access, and pm_runtime_put() releases the reference afterward.

Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index a9dfec3c0ca3..ce9163138be7 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -730,6 +730,9 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 	u32 isr, imr, status;
 	irqreturn_t ret = IRQ_NONE;
 
+	if (pm_runtime_get_if_active(chan->dev) <= 0)
+		return IRQ_NONE;
+
 	isr = readl(chan->regs + ZYNQMP_DMA_ISR);
 	imr = readl(chan->regs + ZYNQMP_DMA_IMR);
 	status = isr & ~imr;
@@ -756,6 +759,8 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 		ret = IRQ_HANDLED;
 	}
 
+	pm_runtime_put(chan->dev);
+
 	return ret;
 }
 
-- 
2.34.1


