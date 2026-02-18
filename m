Return-Path: <dmaengine+bounces-8938-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJRXJwCMlWlVSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8938-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:53:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 007FD154EA5
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95C1C301111A
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7333D6D7;
	Wed, 18 Feb 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JqaskT/H"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823333D6CB;
	Wed, 18 Feb 2026 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408381; cv=fail; b=tavommlrMOHCh/hQrpQ2fwhV/6V+0TIrww4f/4IQLvdOsOQn1L0vmE2i+GKKv9gzbFNZMZd+1HYj12HY9TJjBnhx89+r5BF8rAFJR5oRmzjabQXFXvs9AX6MkejhRVD+EeyJSaMKG/61Cswag52lEpuHifhQKo3jPOZNdRm3Jxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408381; c=relaxed/simple;
	bh=GWfVxR+YuWgiiCu1e4QuyPWqUjNVYqfYSY8cjgSCq8U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mNfTynAgGkIhGcZwQNk80gT/TCO8JhIHplgbvBoAgW8vBs7pNIHEhzDTDcn8RAAlkSZXQdbo/yjxJ0RI6DLeiB9z7f28ZF+w2a7afs7DPBw4AZWVcO26H4t5tiRGLJa8Ef105tkThYLU7v0fpS40VUr8CYIEElmE/9vGaKvYxgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JqaskT/H; arc=fail smtp.client-ip=52.101.193.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kin3ib/nc3BkfzdXynJMFcaE1O2eeioRJy3YYILbSzFE7RDAB4PF3rKyiQwwkbxiji6BVlpm2pcWwjylNVfJMB2aClFxbYhyKFo82aGiqyBxxES1KnTpV1Xc+eW2OBbMQAdO1Mxn1ecCZvJ8fzEvH5o6FxEpiL8uTJv6aEFejJk/qSMkCw63LxkYvgbd+nDr6KG4sj/HtIaEF1gY3SyVbsflPsweTvE/HNbgtNdp/c8gu/JwBGO26Ga6zf0DSNhQxs8NacPdjXnq9cci55qyInREw6Nb25fXRB4ib0U+iKFFRYDqUxK+eNyHGmCh8IYa8DQYgkIjhtbXBHnm3FX6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3smY0u3Vv38WBh2Nxv1gP0VERNgHlRwfDyD3g6EmN4=;
 b=sTMS6izKMHlkE5v5yKcbJ/BRgc8uU6jwhAKOKa1LTI3+LuyPPwAc17jy7XLV1LO7Be5s1eMEZZWARbTtp0A53K9Qrf7XEBEqT8qwnmCUjRP2w75N5tEMJOTaNtaCdzdrsb3fpE2NH72ahJFlte3A8mBRWT22+JQo4NngD6Mvn3LC9mpAG1w3iGJ25fSAmVL73Si2qdmxg4sJC72EBcr/Kv2nk6bSRnMN34oJJWzoh9F6jfWRqEH3wt+YUsGs70M7ZL2KVuT9Ki3FDBVBJE7okMRZhorOx/hNxJBaoJwMTlUYQckpv7zklbpE/teCE8ryEqMRcyqXYYbaPqXPq8TImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3smY0u3Vv38WBh2Nxv1gP0VERNgHlRwfDyD3g6EmN4=;
 b=JqaskT/HxnyhVk7EQNcTSCrHN9CsCYGL/pJ++OPc6CKGJs1o4g84+xI8atH4GHGWcZqZJwzDJbbHNv+jb/Gy/bo5MPbO0L8C8Icw/XKq3BBzV75V3kV7/jS3j1mPLGn3/K4ikG3ZdghpqdZeicDDci43gaEy8MGMc2I3yWbyqmA=
Received: from CH2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:610:4f::18)
 by IA3PR10MB8298.namprd10.prod.outlook.com (2603:10b6:208:570::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 18 Feb
 2026 09:52:57 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::1f) by CH2PR18CA0008.outlook.office365.com
 (2603:10b6:610:4f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 09:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Wed, 18 Feb 2026 09:52:57 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:52:56 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:52:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:52:56 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpI7200561;
	Wed, 18 Feb 2026 03:52:52 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 00/18] dmaengine: ti: Add support for BCDMA v2 and PKTDMA v2
Date: Wed, 18 Feb 2026 15:22:25 +0530
Message-ID: <20260218095243.2832115-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|IA3PR10MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd8209c-19db-4a0d-7195-08de6ed37eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?My99P8/PIf4z6L+3Zwr01FJtoSb8Y1Y9caOE3VQKO3lkHBuO4r8kkwgf5Adx?=
 =?us-ascii?Q?7QAPU2agjbcPK8qF50FnFgXEdf+WrBqZvZNLDJ4yjNqc7TQCHwFNmqq26fF6?=
 =?us-ascii?Q?LLEYo+UcNTkFk7jXh66n4zRbH6gjHgm42jwYJQNxNPd7w6EW3YescPLSjSpX?=
 =?us-ascii?Q?DIdhN9lTNFtDfsD9TKj7RMK37U5HCi+t6gDGWddn+bp5m6r/mqc7Ww4EDwTD?=
 =?us-ascii?Q?sBGkD0wat1WpleT6yN1A3v7fxZvvFyYyLxki45dUvUFWUN+6FkngWCxkygPK?=
 =?us-ascii?Q?QhjJp6uCmFdRFQQzY1TO3NTUTEmr/a6v1v7hM1IZaXRWm59Eh0AX++nZ7NoU?=
 =?us-ascii?Q?dsPjXAem+Ovwk3bPp20AkbEjMgcIokcENVHxirQBeK3Z+EpuycYjIVJQWulr?=
 =?us-ascii?Q?bRvmYcgKwEuCYowmLQipunswB9IaioK+U6KE81RwrRp1gFrYd6jxcdTLvJxO?=
 =?us-ascii?Q?lKravpK48d01sbzTQahYr6bPaLz1iaawrgZj07j0yLjNjmXv5wC3WaNbuGo3?=
 =?us-ascii?Q?7HoMdIurksZAv/lTMzGfqPyUrXaOUODLGPxMpcB/f3A6i7qjgG8unEF0/e6s?=
 =?us-ascii?Q?OY+qtj54XcWIMx7m3bhgLNGJdSwjq6JAGGxjdZy7aoQevvGlHNFmA+ZL9W23?=
 =?us-ascii?Q?5wO1zMKMrUC2kcBbBuATVeUmLATMcnMhJypmsXOphM6/q+MChUeHjUokwfne?=
 =?us-ascii?Q?lr9XQy75fVII8q/H/M2y2lsGt0cFvCq1KF5IqdN/U+u1eVBHt5XXCXwTxjSn?=
 =?us-ascii?Q?nK5tCOR/LXERD0swrEPH6B3RARXu7C22FmzNcGLIkdzt19BuSBrm0GJ69yoQ?=
 =?us-ascii?Q?FoSI9Nw2yx+nUuTjkYxIqRk6qSKNayjesTJSMWOVSASZuGSBTf1tcN1o5T04?=
 =?us-ascii?Q?+qWSR+GZiIrmWRH4O5CSmowyOC39PbBN9B06BZnwEg3QA1kvxFSo4W8MDQol?=
 =?us-ascii?Q?Wn0/JoMVJzHvNllWDvnZyISrfM37HZnbBlaz3guoGcS6mkf8VKMN62QzCxMZ?=
 =?us-ascii?Q?H4CWbv6A4a/k6jWIJWA18Z/FqEijKCWA4iGK4LWc/JHkhhxe56bUPqHP22kg?=
 =?us-ascii?Q?a/zZ/oVQDoqsU7rINLtqaIa3jPhsiGbrkVvsbUsfk+JIrutpYMTjLglJPUPU?=
 =?us-ascii?Q?BpszhxXQES7Ypp4tiA/FOVFpnFCdEuHOh8b5i9YX1PG3e+Ay02Naw1bECFvO?=
 =?us-ascii?Q?G2StHlRZup+KNbKPZdzzIsrXUAEI/H0/CUVRGCT3Nzq8KSeSAurKCcgYjdYR?=
 =?us-ascii?Q?KvN+iarJ8a80/PqnHFX1Scc5KsIP8cuDuSjIupnQQrhgCzTKUocUuCjXvBSL?=
 =?us-ascii?Q?MtDz0bcIdvMRRGqiPeZOpGGGq2OiTNwjCyhIqEQHbdQrvUf4m15JvJkbwckw?=
 =?us-ascii?Q?TqObgIFtnsihkKb6s95EdzltwSbUmg6HAjbxI+RXYAR9otKxQ0S0YKSkoCtH?=
 =?us-ascii?Q?s+qjWBwzeUAmEQM98YiG8enP9Z2PISzQfP6PNWN4gOiSWHh5keAufjr54nmG?=
 =?us-ascii?Q?TMZmYw1o3W2pa6bo8UWaf0RS3cOno72oSGlrueOBPoYWWRZpGmN9mjTT6cgc?=
 =?us-ascii?Q?yTnJi8B0LhAZWCP8IrtcACMZIcNjpQRE0MZM+h1CgVKDXDMBEWeun5KNGMaJ?=
 =?us-ascii?Q?qHNWAHnj9k+j2ySrpmWSK615XPM/5L5BugpIpQLmz2w2jH7WKuSsxGIi/bwR?=
 =?us-ascii?Q?YSmVfL0080Ux5ivrt6iMJeH57lQ=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u1CVooduFyHbfQwPkIh4nuEW94lmo9W/8Kj9bem4N5vAOHQvl7qpVJqd4zyv0p+n4LEke9h39kHxzUt2O954LQmSZvO+Nhj7puwfr4FKI3XcpANJnvTdvnsgnYbK2zA1Z6CUVjwSAE8CSjp/7HF1gSnrTTamEtU5z8vqMnPO6WMjaS3PPwlWyPGJ+uGEPZ+DYoqBwYDcVHhxYVvckTe7LKxdWIdYpIMOBKAeOQGmmGtu8bEWJanFx12Ot5KwP0x7X3PHQWMoU70U14nMLy4UBt79vGNTHeiritz1W/MOgOyNWbH1yvTeb+rKqnvqJVAU5GuhR7xyRQzh4WT9wmiIzvFirMVZsgaaxJjIptFHG9yxk/ue5tOKDNA/wNDt6vsZSYFEpmegq3Ao9+2vO3ZCSZddE6WSNzqn+3DYhuOks6T/2YF9w+CxkCLbzSJQGy1c
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:52:57.4654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd8209c-19db-4a0d-7195-08de6ed37eae
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8298
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8938-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 007FD154EA5
X-Rspamd-Action: no action

This series adds support for the BCDMA_V2 and PKTDMA_V2 which is
introduced in AM62L.

The key differences between the existing DMA and DMA V2 are:
- Absence of TISCI: Instead of configuring via TISCI calls, direct
  register writes are required.
- Autopair: There is no longer a need for PSIL pair and instead AUTOPAIR
  bit needs to set in the RT_CTL register.
- Static channel mapping: Each channel is mapped to a single peripheral.
- Direct IRQs: There is no INT-A and interrupt lines from DMA are
  directly connected to GIC.
- Remote side configuration handled by DMA. So no need to write to PEER
  registers to START / STOP / PAUSE / TEARDOWN.
- Unified Channel Space: Tx and Rx channels share a single register
  space. Each channel index is specifically fixed in hardware as either
  Tx or Rx in an interleaved manner.

Changes from v4 to v5:
- Introduce a new version variable in udma_match_data to differentiate
  between K3 UDMA V1 and K3 UDMA V2. This simplifies the approach for
  adding any future possible variants avoiding complex if conditions.
- Fix both K3 BCDMA V2 and PKTDMA V2 dt bindings as per the comments
  from previous versions.
- Fix minor nitpicks like following the reverse christmas tree order for
  variable declarations.
- Remove the patch [v4 19/19] that switches to synchronous descriptor
  freeing. With this patch, dma_free_coherent gets called in irq
  context and hence a WARN().
link to v4:
https://lore.kernel.org/all/20260130110159.359501-1-s-adivi@ti.com/

Changes from v3 to v4:
- Rename the dt-binding files to add "ti," prefix.
- Update cell description in dt-bindings and add client examples.
- Update k3_ring_intr_regs reg names
- Rename soc specific data to bcdma_v2_data and pktdma_v2_data to
  bcdma_v2_am62l_data and pktdma_v2_am62l_data.
- Add a new patch [18/19] to fix a null pointer dereference issue when
  trying to reserve a channel id that is out of bounds in
  udma_reserve_##res macro. Also fix logging issues in this macro.
- Add a new patch [19/19] to switch to synchronous descriptor freeing to
  avoid running out of memory during stress tests.
- Fix checkpatch warnings.
link to v3:
https://lore.kernel.org/linux-arm-kernel/20250623053716.1493974-1-s-adivi@ti.com

Changes from v2 to v3:
- Fix checkpatch errors & spellings.
link to v2:
https://lore.kernel.org/linux-arm-kernel/20250612071521.3116831-1-s-adivi@ti.com

Changes from v1 to v2:
- Split refactoring of k3-udma driver into multiple commits
- Fix bcdma v2 and pktdma v2 dt-binding examples
- Fix compatibles in k3-udma-v2.c
- move udma_is_desc_really_done to k3-udma-common.c as the difference
  between k3-udma and k3-udma-v2 implementation is minor.
- remove udma_ prefix to function pointers in udma_dev
- reorder the commits to first refactor the existing code completely and
  then introduce k3-udma-v2 related commits.
- remove redundant includes in k3-udma-common.c
- remove ti_sci_ dependency for k3_ringacc in Kconfig
- refactor setup_resources functions to remove ti_sci_ code from common
  logic.
link to v1:
https://lore.kernel.org/linux-arm-kernel/20250428072032.946008-1-s-adivi@ti.com

Sai Sree Kartheek Adivi (18):
  dmaengine: ti: k3-udma: move macros to header file
  dmaengine: ti: k3-udma: move structs and enums to header file
  dmaengine: ti: k3-udma: move static inline helper functions to header
    file
  dmaengine: ti: k3-udma: move descriptor management to k3-udma-common.c
  dmaengine: ti: k3-udma: move ring management functions to
    k3-udma-common.c
  dmaengine: ti: k3-udma: Add variant-specific function pointers to
    udma_dev
  dmaengine: ti: k3-udma: move udma utility functions to
    k3-udma-common.c
  dmaengine: ti: k3-udma: move resource management functions to
    k3-udma-common.c
  dmaengine: ti: k3-udma: refactor resource setup functions
  dmaengine: ti: k3-udma: move inclusion of k3-udma-private.c to
    k3-udma-common.c
  drivers: soc: ti: k3-ringacc: handle absence of tisci
  dt-bindings: dma: ti: Add K3 BCDMA V2
  dt-bindings: dma: ti: Add K3 PKTDMA V2
  dmaengine: ti: k3-psil-am62l: Add AM62Lx PSIL and PDMA data
  dmaengine: ti: k3-udma-v2: New driver for K3 BCDMA_V2
  dmaengine: ti: k3-udma-v2: Add support for PKTDMA V2
  dmaengine: ti: k3-udma-v2: Update glue layer to support PKTDMA V2
  dmaengine: ti: k3-udma: Validate resource ID and fix logging in
    reservation

 .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  |  120 +
 .../bindings/dma/ti/ti,am62l-dmss-pktdma.yaml |  100 +
 drivers/dma/ti/Kconfig                        |   21 +-
 drivers/dma/ti/Makefile                       |    5 +-
 drivers/dma/ti/k3-psil-am62l.c                |  132 +
 drivers/dma/ti/k3-psil-priv.h                 |    1 +
 drivers/dma/ti/k3-psil.c                      |    1 +
 drivers/dma/ti/k3-udma-common.c               | 2610 ++++++++++++++
 drivers/dma/ti/k3-udma-glue.c                 |   91 +-
 drivers/dma/ti/k3-udma-private.c              |   45 +-
 drivers/dma/ti/k3-udma-v2.c                   | 1475 ++++++++
 drivers/dma/ti/k3-udma.c                      | 3102 +----------------
 drivers/dma/ti/k3-udma.h                      |  590 ++++
 drivers/soc/ti/k3-ringacc.c                   |  188 +-
 include/linux/soc/ti/k3-ringacc.h             |   20 +
 15 files changed, 5466 insertions(+), 3035 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-pktdma.yaml
 create mode 100644 drivers/dma/ti/k3-psil-am62l.c
 create mode 100644 drivers/dma/ti/k3-udma-common.c
 create mode 100644 drivers/dma/ti/k3-udma-v2.c


base-commit: 635c467cc14ebdffab3f77610217c1dacaf88e8c
-- 
2.34.1


