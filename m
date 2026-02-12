Return-Path: <dmaengine+bounces-8892-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAoVHDvbjWle8AAAu9opvQ
	(envelope-from <dmaengine+bounces-8892-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:52:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3DB12DFB6
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 278FE3091971
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D090356A11;
	Thu, 12 Feb 2026 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r+KvgyBN"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17703451CE;
	Thu, 12 Feb 2026 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904333; cv=fail; b=APJMkgedoSpnV9ztFM3K6BRLPnCe4eLDGEErmV2rDNn9bnpLdbBi9CzMoQnCoAb1tiSnPaswvvQpmP5G7dhI+Ik8kxe7uPHf2x+fOXNaZgqiU+GAkbHxtedmMSrXkB3vRKZzSexrS5uKo+VXm5xA8RY8LGNkRprjCs8vJutWYlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904333; c=relaxed/simple;
	bh=72Nv886I/rDdIiFD1Dmcm6DN6K3mpLh23zZxGqHvR38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5wu69HgRBeS4//IXHUWcMlSwktNEpTP4S8Jf1m1/nLCa6XzwmayfOi/oku4dZ/4t4xkIun6tJQIqmzVACzrYPWYw/p1GaT/PC25CIBaIfxKF7oDnZWI51DLY+MubmakYbTAkB3MJCL6biBK5+Q/2FYJr/SvOgnO2qEZ+RzlbTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r+KvgyBN; arc=fail smtp.client-ip=40.93.195.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOuIpXGnSCG9O2XAUB6QSNzFA31aAxrwHXWva+oE5jFbScEKG64KdoiSYF91tTtxrv2sYR0K7ZWOFGUueRG9Fb6DAnpDxmRxD7Ks80FqWQbOJAQq877rdfIHtH/JWLPg4b+NJ5Jg6rUrbcyMxghVjHfjK+FHxrxNXObya3kyEXWLxsfcsbYwIOSwt2thWvgD4beNKWTM5/L4oSbFZNefxaTbXYWi8fd3lsQLsB8ll3Mc6MnhBlIzBEVxNKA5N2HNhZ/WCyiTMa/3hW0ovQVwPNOPo1Ot4LxYGYI++Kz0ddVJCwi5bQvITfptZRDoKLEgbAnXZAn9ulHZY5OA1HuWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xBxaiD8hJ/1hgdLn8LyzUQv/fOzRdW2DasyIws9C4c=;
 b=VHlaP7napzUenRpV2NIn+pGEjCc6bIvOVQbll7Z+5ok+oEGuEvtr+jzrzJtCc7dZ+Uwok57LU5We7aKawnZOtBIlOmuW6cys7nsEdonHPeOzQERTWi2k24jRfDAAACwAmN1ylMJQA287h4pCv4otyHBfCtSqGW+qoY3CgP2EfZ2ykHOCDhseugUy499fYRKaqskScAy4nVlk+yXsE8okF8xLXEcn4cXdUaPKpwNvV3IVFlOtlc2/Onf7ZhfTkrWlczJEWCpLY+YSpXSIF8AieIcjYUHLYooO/Sb+8hFl+QlvasE2sP34hTHyy9/tDf6O1zIqaEKmTwkrlrrWJIbuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xBxaiD8hJ/1hgdLn8LyzUQv/fOzRdW2DasyIws9C4c=;
 b=r+KvgyBN9J1iHhBtZXdMo6Uv4v3d5lxgOuqGPPwUhqcN0yorjjm8hsuMCHGuNa5zy6GUchEKhrZDsbfIbrtEHrhFbiPtpZZMklEnvoNZPriNQJt3wMrtTs14Bjff3DROVonWwvrkr+lVGqlmh7lOrmtGvy8+lCAq74Uu6feG+BM=
Received: from DM6PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:333::21)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 13:52:06 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:333:cafe::16) by DM6PR03CA0088.outlook.office365.com
 (2603:10b6:5:333::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 13:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 13:52:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 12 Feb
 2026 07:52:06 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Feb
 2026 07:52:04 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Feb 2026 07:52:00 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <vkoul@kernel.org>
CC: <michal.simek@amd.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <suraj.gupta2@amd.com>, <abin.joseph@amd.com>,
	<radhey.shyam.pandey@amd.com>, <dev@folker-schwesinger.de>,
	<thomas.gessler@brueckmann-gmbh.de>, <tomi.valkeinen@ideasonboard.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [PATCH 3/7] dmaengine: xilinx_dma: Move descriptors to done list based on completion bit
Date: Thu, 12 Feb 2026 19:21:42 +0530
Message-ID: <20260212135146.1185416-4-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260212135146.1185416-1-srinivas.neeli@amd.com>
References: <20260212135146.1185416-1-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: srinivas.neeli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 1030d271-94cc-4ef3-a8e5-08de6a3de8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ajWkGUd8mdDm0iyCBDqgAf+MVnxawqWkLucb7cqsoLvVH4S585tDVaMZI4go?=
 =?us-ascii?Q?tDBPr2earn00qxAAQHX1hpYbpW81VhMQVqXdU8zKlJbPqn601n6hzXSI3QDj?=
 =?us-ascii?Q?EQHWfj0L6KD+g577iPfwiW/0LHQ3yE1mBdeRPXB169XKWesLGl5bRQDezRwT?=
 =?us-ascii?Q?htNtsG/Hv+l+z6QSL2f85PxUIMI7XlkLtYTrBf+A+l/i1bzdBBEixOv9N+9x?=
 =?us-ascii?Q?iibxr7tFr6pjEvptn16h/s3KyMA9N5VAmUBiU31IzNKqQ4aGM7cn1C6i6ZVy?=
 =?us-ascii?Q?RbC1TcujQ80rStu/8gXGQLusQzqPhVdwPIIKwDtxcWZTgCKHiQOEXnAfCnoR?=
 =?us-ascii?Q?SaOQCDH3cQGFh7NmE+5u4sXXqjKInozK4ymm1yHeua0Dh9lgTwPSwJd2wvFX?=
 =?us-ascii?Q?ZIRiNKuBIF/+l1Mt41QyL5/QEqornQ4/w3b+EJS/6fntJYrH0aNVLSYlI7Ho?=
 =?us-ascii?Q?aDhiiZ6zin0X00434NFrRbBFaOTEkzRE0wIsP9TKzv8aq/8R6UOAEfjXcTkl?=
 =?us-ascii?Q?5TSFblIgzzuR8F3XRqnnfll3qOADdORXeY+b7fZgjdE2RZTjEsJRnEPXmQKg?=
 =?us-ascii?Q?EvgngD/3622R6XSce8+sSQJtjXr4qNkA9Op90wfQWr27yTOV5/EcyP+INIDP?=
 =?us-ascii?Q?X+UfXZAFnmdzEWuM71KlfBkllCJ+uOnKjC0AbMJugRQFppZDZETUoCNxIkRQ?=
 =?us-ascii?Q?g192ce9HS/QEDIFn8VQySFGTZ3sCHZ9sENHOTgT6lbKmFK/IdzWRDJlXQItG?=
 =?us-ascii?Q?l4bSywq6exaRTRYtDlBvbd2Xx57HNXUoWICGEUgDSMF9Gl3SvV5JTAeqfdBN?=
 =?us-ascii?Q?iiKSz6PvcTjUxtTp+yW3pHJSV5q+TOFo4+XSKXWNkvF9JMBBJqTU1j5Wz6c4?=
 =?us-ascii?Q?Q0HFBfZZ3Uk1fCCwM33+XEU+aIfm2zw7qHbVqbXCZXr4LYGoy9gZglO4A9La?=
 =?us-ascii?Q?X4GDTMSZyJoHRfIv9Rp6LDdyNlyAjsZfDxW4xIQX7OJJwB8naWho75FaADM3?=
 =?us-ascii?Q?NUQFiRi47UM0sh2gbK3y4DDwJJY8t6BF+LfoAD5Gnibbeu6axgYH84VtLfP2?=
 =?us-ascii?Q?R4Fd0RXnpurXaeS13QugrxM+h+zUtER+aH80NBF9/Q5O71189Lo8shym0hd4?=
 =?us-ascii?Q?bDgUDUnirxZ3GifM9kbRPKE5jrJCS/55nZH9tbMQCJ4lQoNm3jI8TiwejA+K?=
 =?us-ascii?Q?DF/62X7BmcG3Nx+h+EbQh5KOjOSsPlT26tpvQQziKXk9AufB8sLWQnPw66AL?=
 =?us-ascii?Q?aI8Bh6isFpJfghGL2SUlTYKQKVRs2kni83+5gbGRHrGVLSDY/YzPaGXhu5ew?=
 =?us-ascii?Q?SzgtE94wwnN6Je+B6FzyOmdvADyiD/HZJxGCkZr8vz8wj7+my9p/iDmYuFvd?=
 =?us-ascii?Q?JYxEnMsJ2KIWdHDL9k+5vWOXrFKM367wc4czJHpZOseKVJQyCkzMeK9RzHgF?=
 =?us-ascii?Q?myuXzVajqcqDo6NptlC9TGd8RyBeqm+phXGoDD8lLG47xjM0bv9KVa53QSmH?=
 =?us-ascii?Q?dt9I6Z6GpFF07ASODmjfHuYDeqtKUBNINTwosr98OWD4VSzFdHDDYwtZo0WK?=
 =?us-ascii?Q?Ef4ozG25TSZG23WB8DvsVa8Gy3BXtDNKY42EBqvwokkcuppQRG+4Ko7Q5vsO?=
 =?us-ascii?Q?m3bD0YwBTDOU/lXTlIul0WRsVB+LLSQQ7rsz+Ysun3C3CRpj4M0P2vZ45jqF?=
 =?us-ascii?Q?D0/OuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VqhlSeALWm4t4VUrmajaqoqpSIkuUzNwTyekvLKwI5ad/VtmVIFkIPzbByK3kMDn/iiBIiNoWL51zTMpSAuQYT/mU3tIxVkcDgciLXMsJa45qlvzAqGkCd4RALcCPm7PsL6WPNYINOa4vqE1AgAk8MwgAywK1+D7uSpcIHdP+GOwbumn9z1H9M7nD6QL65JC8S7uWzpNQkeOj5Aga3Qgch6HXBOgiV2qGYgYvvkjxqbUn7SZH4BZm4EQqreYCQdbPvl/pjAjNLUBAzoSb9pWoiCdeIRIcVrtzYtNGB1mKzWNC8OsH1PfDeZre+gbYKdCd9IKsMSFvr7r2KEc6E3s5uBcQ4K78FI6C8BnRuEy0IBZdU90a166dvgQFHe4ehAejGLq1oD8tCOmwNRtkpTWW9QjFhYJkJ2MWDwAUw4cmudTGWhRfagLE3L0EBCSyCqB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:52:06.6109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1030d271-94cc-4ef3-a8e5-08de6a3de8ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8892-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0C3DB12DFB6
X-Rspamd-Action: no action

In AXIMCDMA scatter-gather mode, the hardware sets the completion bit when
a transfer finishes. The driver now checks this bit to free descriptors
from the active list and move them to the done list.
This is required when interrupt delay timeout Dly_IrqEn is enabled,
as interrupts may be triggered before the configured threshold is reached,
even if not all descriptors have completed.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index e09a22721c01..e3f8c0f09a17 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1762,6 +1762,18 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 					      struct xilinx_axidma_tx_segment, node);
 			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
 				break;
+		} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+			struct xilinx_aximcdma_tx_segment *seg;
+			bool completed;
+
+			seg = list_last_entry(&desc->segments,
+					      struct xilinx_aximcdma_tx_segment,
+					      node);
+			completed = (chan->direction == DMA_DEV_TO_MEM) ?
+				(seg->hw.s2mm_status & XILINX_DMA_BD_COMP_MASK) :
+				(seg->hw.mm2s_status & XILINX_DMA_BD_COMP_MASK);
+			if (!completed)
+				break;
 		}
 		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
 		    XDMA_TYPE_VDMA)
-- 
2.25.1


