Return-Path: <dmaengine+bounces-8954-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOn4HaOMlWlVSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8954-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:55:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F8154F9C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCA803010703
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012633DEE7;
	Wed, 18 Feb 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nP5RUHyF"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10133D6E9;
	Wed, 18 Feb 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408459; cv=fail; b=q7CSFTP7ucRyJj+bnhf+ZqBLUfAWu8Wyo5MyfulXYJdo9ogQsuKzwcoQh9AjKexRe2HsmziRqcIsD2KAkE+YjRe+4zEDhY3nMhZOulHz0UksriwwKiELRD02o0WepKnVX2FnZMM8a1s3rKed1kfp5T8pKIm5tuy5pt0WdQEpX2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408459; c=relaxed/simple;
	bh=tutH5bimzO952oFxl4BE2rB6BR40waSh0VQPNo0ybss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyS9ohJ29zcxBrgRqU1dKByXVcv/F1/JIH3O7H3ljwPdN4peMVckmp5o7kpHcjdMzUIs90iuJ/uZ5h63SgLq5CUU+IpNmkOJvXbBuBDR8G6K9IY6w6jhjs6A+FwbdKrqoxT7v4szAMe1a4s7K6rNDFZbrQVsQ/xbsdqvVqk/5fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nP5RUHyF; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROVuwrQxeEouF/UbEwcK1tXj+on7VGUkfAHhA8c8yUoUghiSpz5ptZmDXaCqlvNdmyBk6VI5wNU2jVOof2zNPmezuenjF6j/yOyQLjmE1OgJiMsvyLtJo5ZLcrx7SXQZgOUhStR0Q9kvj85wVdovNjZ10nPvuthQ5bTX5Rn6ZnVieVHYjxeQ8dpTkSJLN6jKpDlpaef5EX9jpNn1c56fCLm9HSZM6hkTgM/9LmsLGgN1XabdQwVqkmpVLhJZHoNT6AwygrGkEWzsk8xGaWcHyeVLaKExGdGi0yxXOUMFzLn2uaphJm0ttpcUii9VyEBwRo4AegSdeZPkrGkXdbT7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMNejFVBn4lT9aS2/EM1OdZOZ5VegmqCjG75C+o7k/o=;
 b=cJFfL1xYf7TJfamEJ0F6FLQ+Rdks5furLGK4pKm581uLTD2txlgiHnaanpZe1J6Yp8G/IGzODDTumaYdmYNelaGvQs3c9acbocXbdcLZZwhLXjHqMfyhl2iYM+RUSFLujRDXG97bB5lTrzzJZWCbOnQr/12LOrpN/porTfBrBhuwC5jA2TfiMUAxg7yWmZtKxywM9pCxdVjtymHaHjYrqNqVFW/nI8/L934uWBkc7UEfJTGHY4L5paZqWYFVSq9G9WqTziIQcxy3U5/xgr5kZDpiACIJUTZZORPv1gEnz+95u/cOllAEhpYzDbp1gX1i0vzIgaKZ2mg/vkwMt0ichA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMNejFVBn4lT9aS2/EM1OdZOZ5VegmqCjG75C+o7k/o=;
 b=nP5RUHyFZ/XuMCV8Z+o2P3tusxCtmNPNCdHAooerPqyp5ETBoivs33qvTw+dmL1lEdFduUVmoIWHeuE6jXLvZEm9af8re0fUjYpE8fFOgybs866KoDKcAzGyVde5FNDPQbTKeqnzeIKOsh23uhK0YBnBEKMBDHL+WQIRy923Rmw=
Received: from BN0PR04CA0185.namprd04.prod.outlook.com (2603:10b6:408:e9::10)
 by CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:54:15 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::3c) by BN0PR04CA0185.outlook.office365.com
 (2603:10b6:408:e9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Wed,
 18 Feb 2026 09:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Wed, 18 Feb 2026 09:54:13 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:54:13 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:54:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:54:13 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpIN200561;
	Wed, 18 Feb 2026 03:54:08 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 16/18] dmaengine: ti: k3-udma-v2: Add support for PKTDMA V2
Date: Wed, 18 Feb 2026 15:22:41 +0530
Message-ID: <20260218095243.2832115-17-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218095243.2832115-1-s-adivi@ti.com>
References: <20260218095243.2832115-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|CO1PR10MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb7ae29-d2fa-4819-ab18-08de6ed3ac1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nitG6l0Moja/PrYUuYQGX4jjMFaErzT7o5m0qjB5XfMdcEzF4/ur5FK6XCgR?=
 =?us-ascii?Q?ITqC9xz+qoiuV3XFPzbMIH5J8+sbhRMBuB76P6oDVYBNbdogzRvcGb7rlV87?=
 =?us-ascii?Q?5lDn0vtKqtUzFaKUHmEMw3AlA7208UcHcWMGLn+V1DMC++M4PiR0AdySlGNa?=
 =?us-ascii?Q?Giz3LmcK3ZTafkxMA7y0W0VgnXn+o6czA8eqtkmG3fH5efLmDi4mSsAa82tQ?=
 =?us-ascii?Q?KW51KF2osmjElXSjbNn0nmIMH2+K5LV3EN2KRQCoB5JDUfBB6coIqFNXBcj4?=
 =?us-ascii?Q?nz984MjTH5nfVBA33etiOSevChzGQdirX1s2oxrDcW1pF+rWmBsLBqh1S1nn?=
 =?us-ascii?Q?l5WDSot4zIvgfz5hrj9ctWQWx6NX3o6EdBpIIytPOZ/lCcyCtMct79/fiLSL?=
 =?us-ascii?Q?aDl89Gg+Z4O1Gsglatj3O0gUQIeZ+CUMS5NBwkqYffS7o+XDGIzuMio/qSeZ?=
 =?us-ascii?Q?Xz45K3SCiSQbxM2xYi6qgyZNB1ybwev+BqRRj0TzDIb1eHacw+DSEadtw1K9?=
 =?us-ascii?Q?qB9L/cpirsNjysqJGYjegclJ+zSMRbZUlKw08OuUmNobfL0z1ddDQF2xFBk4?=
 =?us-ascii?Q?Ll+BL9myIHic+0uvhKwI0rWKihrRbhfXc9HBnin53/0G492o1pT0JjVfIiri?=
 =?us-ascii?Q?mBjn5eHRdLwGoeBhx9UO1KNbTymz3prG0jlCQNwfNYIKg4nInQIPgX4rOU2K?=
 =?us-ascii?Q?Nf3M3ePWslhapnt679Re7Fw3luAxFWoE6OkxVnrKDnlWUcSuUaevNv0BRYYJ?=
 =?us-ascii?Q?LPYBSSWt+NivC7mTyfeqbnflGTRSofLqcxzRlA667rLr2fnvwrUESeMd5OYp?=
 =?us-ascii?Q?esQgZXZpzC6kG//aha6UT+i1YJCs5c78i9iDujmsqzpVpHzTZFYl0GObQBpE?=
 =?us-ascii?Q?b2AaGnHcBc2MUWCRvtK+DRw3F9pzAM3l0F4gred8fjkTXrZlJ2cYOSkERpIr?=
 =?us-ascii?Q?NQQDIX+mSmcFm2q5fvOW3mysrr0ctfRx4NWju3XTuPiL1Gltm39OY54jQtX/?=
 =?us-ascii?Q?JSrZAC506JgXLz5usnShNtWyYa8wPA8fI7RI2ZF21NcFg0whvuNAlFxKFukY?=
 =?us-ascii?Q?hm2Vaz1b5ITf6S8kfdX/E1ODP6l5xAX1GPnE15RID3EqKSedxN1/J1MGwLLJ?=
 =?us-ascii?Q?nGXJHbDiAmE9GwHgXeA/PLwSeAgaIZIB6RWdGTK4epoI9RH5JXHhIh0vlWH4?=
 =?us-ascii?Q?E3Hr4vrDOqnk0TZ4pmPnyF5d8uibyqqTypAz3n7rxsK+3R0Rjn1W0wqKpGwp?=
 =?us-ascii?Q?AW54FEQqwDrJpj+6bMMRA99tZ3Hq3zBAHzbgkZvR0pNNQXYoMBKVa6sNZGza?=
 =?us-ascii?Q?YgFCV8XI8IdCQsR2RU6eWhPwP7eoom0fntk8wLJaxE5CCNjEuey+FCC1sDmF?=
 =?us-ascii?Q?UJ4yHTnE2mspBMj/9jvfvr2Rc5qFJ3tBMsixDPMQjYRt/eqG2RQqKhoMale2?=
 =?us-ascii?Q?lEU3ixH6SEjzkGIjijuVbWCiOmx9cX1BQHNnvywW/6AMtMQzTzR40geY1wX7?=
 =?us-ascii?Q?yTm/UXr7VgF4b8gCNVySED89JUGc4hssR78urFpD6kEdpB6vE9tXbFYNcRzF?=
 =?us-ascii?Q?xBOlRg3oq+l+Oe8bJWZagytXElW+firYUaTvh/DMbtS6doGQ2ebBOvgd7EJ2?=
 =?us-ascii?Q?RhqDReunecT5bxTh116N+GHLoGLcRSSDOq6yi90fE+Zvd8WvI01MEIBrz2z0?=
 =?us-ascii?Q?WshBsIV99Hv9WRDvMYb2GFIw1CY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xx2bx8nWJ6yWMgmC5DobcUmjk0tBNYeUKo7Xp3x8gpEsrBwgmNguLvaBKnXNx9CevYfs4dO/UB9k2XNO6g8LQUHlQ9mRsvk5h+9v1MFwLYa/Y0+hIwtlf2+/zx2IxQQjqTWYKYCc8QsUF22EkPrk1u9bFYp2IfyapGEqU3x+iwmUrylT5ZbuQ8CfmRbKIThG/9b4bvbkhr/v046PVNv8xJ878xfJlU2Vw2TLZqdmV4m1ItRJorpXgL5C+mBaV+K198jo56y6BlEIqwPi3Pqko1EHDkta+ekQB3OR15Bd6+Zs5kI09NVRemoQMkTP7HY2km0BgRsoLtPBflsSNvMngTp/ytq1XoMJk63nrjhuVHV/6ag8wmNdb2kzpkV3wznxIdSG1Qom4qYTve4PSNtWLJEiXPRUaW27YBTg+JtoMrnrFTAAMxnII2N1KQPzTrQj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:54:13.6635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb7ae29-d2fa-4819-ab18-08de6ed3ac1a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8954-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,out_irq.np:url,ti.com:mid,ti.com:dkim,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9C8F8154F9C
X-Rspamd-Action: no action

The PKTDMA V2 is different than the existing PKTDMA supported by the
k3-udma driver.

The changes in PKTDMA V2 are:
- Autopair: There is no longer a need for PSIL pair and AUTOPAIR bit
  needs to set in the RT_CTL register.
- Static channel mapping: Each channel is mapped to a single
  peripheral.
- Direct IRQs: There is no INT-A and interrupt lines from DMA are
  directly connected to GIC.
- Remote side configuration handled by DMA. So no need to write to
  PEER registers to START / STOP / PAUSE / TEARDOWN.
- Unified Channel Space: Tx and Rx channels share a single register
  space. Each channel index is specifically fixed in hardware as either
  Tx or Rx in an interleaved manner.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c |  41 ++++--
 drivers/dma/ti/k3-udma-v2.c     | 218 ++++++++++++++++++++++++++++++--
 drivers/dma/ti/k3-udma.h        |   3 +
 3 files changed, 238 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index ff2b0353515ee..711a35b278762 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -2460,12 +2460,21 @@ int pktdma_setup_resources(struct udma_dev *ud)
 
 	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
+	bitmap_zero(ud->tchan_map, ud->tchan_cnt);
 	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
 				  GFP_KERNEL);
-	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
-	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
-				  GFP_KERNEL);
+	if (ud->match_data->version == K3_UDMA_V2) {
+		ud->rchan_map = ud->tchan_map;
+		ud->rchans = ud->tchans;
+		ud->chan_map = ud->tchan_map;
+		ud->chans = ud->tchans;
+	} else {
+		ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
+						   sizeof(unsigned long), GFP_KERNEL);
+		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
+		ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
+					  GFP_KERNEL);
+	}
 	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rflow_cnt),
 					sizeof(unsigned long),
 					GFP_KERNEL);
@@ -2473,6 +2482,8 @@ int pktdma_setup_resources(struct udma_dev *ud)
 				  GFP_KERNEL);
 	ud->tflow_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tflow_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
+	bitmap_zero(ud->tflow_map, ud->tflow_cnt);
+
 
 	if (!ud->tchan_map || !ud->rchan_map || !ud->tflow_map || !ud->tchans ||
 	    !ud->rchans || !ud->rflows || !ud->rflow_in_use)
@@ -2563,13 +2574,21 @@ int setup_resources(struct udma_dev *ud)
 		}
 		break;
 	case DMA_TYPE_PKTDMA:
-		dev_info(dev,
-			 "Channels: %d (tchan: %u, rchan: %u)\n",
-			 ch_count,
-			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
-						       ud->tchan_cnt),
-			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
-						       ud->rchan_cnt));
+		if (ud->match_data->version == K3_UDMA_V1) {
+			dev_info(dev,
+				 "Channels: %d (tchan: %u, rchan: %u)\n",
+				 ch_count,
+				 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
+							       ud->tchan_cnt),
+				 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
+							       ud->rchan_cnt));
+		} else if (ud->match_data->version == K3_UDMA_V2) {
+			dev_info(dev,
+				 "Channels: %d (tchan + rchan: %u)\n",
+				 ch_count,
+				 ud->chan_cnt - bitmap_weight(ud->chan_map,
+							      ud->chan_cnt));
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/dma/ti/k3-udma-v2.c b/drivers/dma/ti/k3-udma-v2.c
index e91c4ef944c51..5c02843ca9f94 100644
--- a/drivers/dma/ti/k3-udma-v2.c
+++ b/drivers/dma/ti/k3-udma-v2.c
@@ -744,6 +744,146 @@ static int bcdma_v2_alloc_chan_resources(struct dma_chan *chan)
 	return ret;
 }
 
+static int pktdma_v2_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_dev *ud = to_udma_dev(chan->device);
+	struct of_phandle_args out_irq;
+	__be32 addr[2] = {0, 0};
+	u32 irq_ring_idx;
+	int ret;
+
+	/*
+	 * Make sure that the completion is in a known state:
+	 * No teardown, the channel is idle
+	 */
+	reinit_completion(&uc->teardown_completed);
+	complete_all(&uc->teardown_completed);
+	uc->state = UDMA_CHAN_IS_IDLE;
+
+	switch (uc->config.dir) {
+	case DMA_MEM_TO_DEV:
+		/* Slave transfer synchronized - mem to dev (TX) transfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-DEV\n", __func__,
+			uc->id);
+
+		ret = udma_v2_alloc_tx_resources(uc);
+		if (ret) {
+			uc->config.remote_thread_id = -1;
+			return ret;
+		}
+
+		uc->config.src_thread = ud->psil_base + uc->tchan->id;
+		uc->config.dst_thread = uc->config.remote_thread_id;
+		uc->config.dst_thread |= K3_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring_idx = uc->config.mapped_channel_id;
+		break;
+	case DMA_DEV_TO_MEM:
+		/* Slave transfer synchronized - dev to mem (RX) transfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as DEV-to-MEM\n", __func__,
+			uc->id);
+
+		ret = udma_v2_alloc_rx_resources(uc);
+		if (ret) {
+			uc->config.remote_thread_id = -1;
+			return ret;
+		}
+
+		uc->config.src_thread = uc->config.remote_thread_id;
+		uc->config.dst_thread = (ud->psil_base + uc->rchan->id) |
+					K3_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring_idx = uc->config.mapped_channel_id;
+		udma_write(uc->rflow->reg_rt, UDMA_RX_FLOWRT_RFA, BIT(28));
+		break;
+	default:
+		/* Can not happen */
+		dev_err(uc->ud->dev, "%s: chan%d invalid direction (%u)\n",
+			__func__, uc->id, uc->config.dir);
+		return -EINVAL;
+	}
+
+	/* check if the channel configuration was successful */
+	if (ret)
+		goto err_res_free;
+
+	if (udma_is_chan_running(uc)) {
+		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
+		ud->reset_chan(uc, false);
+		if (udma_is_chan_running(uc)) {
+			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
+			ret = -EBUSY;
+			goto err_res_free;
+		}
+	}
+
+	uc->dma_dev = dmaengine_get_dma_device(chan);
+	uc->hdesc_pool = dma_pool_create(uc->name, uc->dma_dev,
+					 uc->config.hdesc_size, ud->desc_align,
+					 0);
+	if (!uc->hdesc_pool) {
+		dev_err(ud->ddev.dev,
+			"Descriptor pool allocation failed\n");
+		uc->use_dma_pool = false;
+		ret = -ENOMEM;
+		goto err_res_free;
+	}
+
+	uc->use_dma_pool = true;
+
+	uc->psil_paired = true;
+
+	out_irq.np = dev_of_node(ud->dev);
+	out_irq.args_count = 1;
+	out_irq.args[0] = irq_ring_idx;
+	ret = of_irq_parse_raw(addr, &out_irq);
+	if (ret)
+		return ret;
+
+	uc->irq_num_ring = irq_create_of_mapping(&out_irq);
+
+	ret = devm_request_irq(ud->dev, uc->irq_num_ring, udma_v2_ring_irq_handler,
+			       IRQF_TRIGGER_HIGH, uc->name, uc);
+
+	if (ret) {
+		dev_err(ud->dev, "chan%d: ring irq request failed\n", uc->id);
+		goto err_irq_free;
+	}
+
+	uc->irq_num_udma = 0;
+
+	udma_reset_rings(uc);
+
+	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
+				  udma_check_tx_completion);
+
+	if (uc->tchan)
+		dev_dbg(ud->dev,
+			"chan%d: tchan%d, tflow%d, Remote thread: 0x%04x\n",
+			uc->id, uc->tchan->id, uc->tchan->tflow_id,
+			uc->config.remote_thread_id);
+	else if (uc->rchan)
+		dev_dbg(ud->dev,
+			"chan%d: rchan%d, rflow%d, Remote thread: 0x%04x\n",
+			uc->id, uc->rchan->id, uc->rflow->id,
+			uc->config.remote_thread_id);
+	return 0;
+
+err_irq_free:
+	uc->irq_num_ring = 0;
+err_res_free:
+	udma_free_tx_resources(uc);
+	udma_free_rx_resources(uc);
+
+	udma_reset_uchan(uc);
+
+	dma_pool_destroy(uc->hdesc_pool);
+	uc->use_dma_pool = false;
+
+	return ret;
+}
+
 static enum dma_status udma_v2_tx_status(struct dma_chan *chan,
 					 dma_cookie_t cookie,
 					 struct dma_tx_state *txstate)
@@ -838,6 +978,7 @@ static int udma_v2_resume(struct dma_chan *chan)
 }
 
 static struct platform_driver bcdma_v2_driver;
+static struct platform_driver pktdma_v2_driver;
 
 static bool udma_v2_dma_filter_fn(struct dma_chan *chan, void *param)
 {
@@ -847,7 +988,8 @@ static bool udma_v2_dma_filter_fn(struct dma_chan *chan, void *param)
 	struct udma_chan *uc;
 	struct udma_dev *ud;
 
-	if (chan->device->dev->driver != &bcdma_v2_driver.driver)
+	if (chan->device->dev->driver != &bcdma_v2_driver.driver &&
+	    chan->device->dev->driver != &pktdma_v2_driver.driver)
 		return false;
 
 	uc = to_udma_chan(chan);
@@ -990,11 +1132,34 @@ static struct udma_match_data bcdma_v2_am62l_data = {
 	.rchan_cnt = 128,
 };
 
+static struct udma_match_data pktdma_v2_am62l_data = {
+	.type = DMA_TYPE_PKTDMA,
+	.version = K3_UDMA_V2,
+	.psil_base = 0x1000,
+	.enable_memcpy_support = false, /* PKTDMA does not support MEM_TO_MEM */
+	.flags = UDMA_FLAGS_J7_CLASS,
+	.statictr_z_mask = GENMASK(23, 0),
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		0, /* No H Channels */
+		0, /* No UH Channels */
+	},
+	.tchan_cnt = 97,
+	.rchan_cnt = 97,
+	.chan_cnt = 97,
+	.tflow_cnt = 112,
+	.rflow_cnt = 112,
+};
+
 static const struct of_device_id udma_of_match[] = {
 	{
 		.compatible = "ti,am62l-dmss-bcdma",
 		.data = &bcdma_v2_am62l_data,
 	},
+	{
+		.compatible = "ti,am62l-dmss-pktdma",
+		.data = &pktdma_v2_am62l_data,
+	},
 	{ /* Sentinel */ },
 };
 
@@ -1013,15 +1178,22 @@ static int udma_v2_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 	if (IS_ERR(ud->mmrs[V2_MMR_GCFG]))
 		return PTR_ERR(ud->mmrs[V2_MMR_GCFG]);
 
-	ud->bchan_cnt = ud->match_data->bchan_cnt;
-	/* There are no tchan and rchan in BCDMA_V2.
+	/* There are no tchan and rchan in BCDMA_V2 and PKTDMA_V2.
 	 * Duplicate chan as tchan and rchan to keep the common code
-	 * in k3-udma-common.c functional for BCDMA_V2.
+	 * in k3-udma-common.c functional.
 	 */
-	ud->chan_cnt = ud->match_data->chan_cnt;
-	ud->tchan_cnt = ud->match_data->chan_cnt;
-	ud->rchan_cnt = ud->match_data->chan_cnt;
-	ud->rflow_cnt = ud->chan_cnt;
+	if (ud->match_data->type == DMA_TYPE_BCDMA) {
+		ud->bchan_cnt = ud->match_data->bchan_cnt;
+		ud->chan_cnt = ud->match_data->chan_cnt;
+		ud->tchan_cnt = ud->match_data->chan_cnt;
+		ud->rchan_cnt = ud->match_data->chan_cnt;
+		ud->rflow_cnt = ud->chan_cnt;
+	} else if (ud->match_data->type == DMA_TYPE_PKTDMA) {
+		ud->chan_cnt = ud->match_data->chan_cnt;
+		ud->tchan_cnt = ud->match_data->tchan_cnt;
+		ud->rchan_cnt = ud->match_data->rchan_cnt;
+		ud->rflow_cnt = ud->match_data->rflow_cnt;
+	}
 
 	for (i = 1; i < V2_MMR_LAST; i++) {
 		if (i == V2_MMR_BCHANRT && ud->bchan_cnt == 0)
@@ -1075,6 +1247,7 @@ static int udma_v2_probe(struct platform_device *pdev)
 	ud->reset_chan = udma_v2_reset_chan;
 	ud->decrement_byte_counters = udma_v2_decrement_byte_counters;
 	ud->bcdma_setup_sci_resources = NULL;
+	ud->pktdma_setup_sci_resources = NULL;
 
 	ret = udma_v2_get_mmrs(pdev, ud);
 	if (ret)
@@ -1082,7 +1255,14 @@ static int udma_v2_probe(struct platform_device *pdev)
 
 	struct k3_ringacc_init_data ring_init_data = {0};
 
-	ring_init_data.num_rings = ud->bchan_cnt + ud->chan_cnt;
+	if (ud->match_data->type == DMA_TYPE_BCDMA) {
+		ring_init_data.num_rings = ud->bchan_cnt + ud->chan_cnt;
+	} else if (ud->match_data->type == DMA_TYPE_PKTDMA) {
+		ring_init_data.num_rings = ud->rflow_cnt;
+
+		ud->rflow_rt = devm_platform_ioremap_resource_byname(pdev, "ringrt");
+		ring_init_data.base_rt = ud->rflow_rt;
+	}
 
 	ud->ringacc = k3_ringacc_dmarings_init(pdev, &ring_init_data);
 
@@ -1091,8 +1271,10 @@ static int udma_v2_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, ud->ddev.cap_mask);
 
-	dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
-	ud->ddev.device_prep_dma_cyclic = udma_prep_dma_cyclic;
+	if (ud->match_data->type != DMA_TYPE_PKTDMA) {
+		dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
+		ud->ddev.device_prep_dma_cyclic = udma_prep_dma_cyclic;
+	}
 
 	ud->ddev.device_config = udma_slave_config;
 	ud->ddev.device_prep_slave_sg = udma_prep_slave_sg;
@@ -1106,8 +1288,18 @@ static int udma_v2_probe(struct platform_device *pdev)
 	ud->ddev.dbg_summary_show = udma_dbg_summary_show;
 #endif
 
-	ud->ddev.device_alloc_chan_resources =
-		bcdma_v2_alloc_chan_resources;
+	switch (ud->match_data->type) {
+	case DMA_TYPE_BCDMA:
+		ud->ddev.device_alloc_chan_resources =
+			bcdma_v2_alloc_chan_resources;
+		break;
+	case DMA_TYPE_PKTDMA:
+		ud->ddev.device_alloc_chan_resources =
+			pktdma_v2_alloc_chan_resources;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	ud->ddev.device_free_chan_resources = udma_free_chan_resources;
 
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 771088462f80d..642d8fc8f3175 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -23,8 +23,11 @@
 #define UDMA_RX_FLOW_ID_FW_OES_REG	0x80
 #define UDMA_RX_FLOW_ID_FW_STATUS_REG	0x88
 
+#define UDMA_RX_FLOWRT_RFA             0x8
+
 /* BCHANRT/TCHANRT/RCHANRT registers */
 #define UDMA_CHAN_RT_CTL_REG		0x0
+#define UDMA_CHAN_RT_CFG_REG		0x4
 #define UDMA_CHAN_RT_SWTRIG_REG		0x8
 #define UDMA_CHAN_RT_STDATA_REG		0x80
 
-- 
2.34.1


