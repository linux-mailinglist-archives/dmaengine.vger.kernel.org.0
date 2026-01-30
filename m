Return-Path: <dmaengine+bounces-8595-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLBbF8mPfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8595-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:02:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0645B9B43
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38BC53009892
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F69378838;
	Fri, 30 Jan 2026 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="htJcVHVT"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F437883B;
	Fri, 30 Jan 2026 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770951; cv=fail; b=qm+zJ8nZdEfGVHu2ytYKcpnFvLGPVGxX75yJy7qp3X7L+QnycUice+cp8rMlRh5YDilV9XwfUp9eS49q2F3+mgRY43PDhRxDHb5EZs5GaaUCuRlYKY6kqjsuPKu4vCG9duZoHECLF3D9ab3AzhYIVchC0fU1lyCwrqvKbbbLyis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770951; c=relaxed/simple;
	bh=ftBn7SikCju7zI/wzfgqM1wneiRNZIVVAhcB8BTR908=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxWhur8FDNf0lh6BPBBjsrOvI+EyqJcWGFNxbFLswatESCUReudDxDFy1UUkKsxy6IX2K/apC5o3PWqjN5htbif2IB7882XyJo6n5z4z0/2fUUIUZttEgGcmEAvgAKcUbT1GT0PnNfANFw4O5geMdfa4xN+9qbFvS/wlbrte9xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=htJcVHVT; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYz16kCNMcA55GAd1cI/bfNxlQmsu1wZ5oQW53PJt1WqvGam4ock4Gv3cWMaXULL2AbfGzyemyN+wfaJsRJ6JqHb4cqxlaIz2jyUOKyZpg/gmkWfBbIfRGZs+xJp2O4MjZsCBU814n84dGXd2t45hihUcLLnvGaj0OG03ANxCEv+p5z27PMu12zsVQW+3IVngU9K90V1bhRnF4OnfvQSt/8LQK7WuRZoznf3Pp7RSnQzl173i3QokfNsENgiJZvyv1MTDyZtsdC8jqXUHRIhgYDdE+4gFrg2YFtPwQgvVmQRFAWg3BLvCdkuA7TMicP+87+Cdg1SMPyglsyodnawEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elLIf7fn3ROfjQByGp/TsTtfayAS/aLZr2yQStBrTrY=;
 b=i+aIwkVOxB4PCC8dP9zJViUsaMFo0SoaptXfkg/lQstzGMhSyoZRsfriQEYAC3NaW3wA1itGdPYCeLgO19hdN13TPnxK8sFf6zKrnVPLqV0e53EWMiNHsHJjAhB9zXUKRNiPBtOgIOfA5TRL0nACDFOywnJm2nbIxTHwR6bmy+stbb7iyJGW9nPNxNRL+vdFA+PC3m/xhnEsftpFZv2BUT1rs81+WI1Ws2VVc6ei1YYKrFkKowiJVR4Nya0S9bQqQkPaaHBSC8mzl5jzjQ1r3JlOzx8eZZAP1+GCEw5+EfPVMqiAu+q9/NcRJVk18OxPgcpDPl2xY+BiWiB4zmRG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elLIf7fn3ROfjQByGp/TsTtfayAS/aLZr2yQStBrTrY=;
 b=htJcVHVT4pzxGU6X+Bd0uczCIOur02JbxxpgP463M90UMWtN8BZua1o37b+obPICy2bFYPqCq2Y+26Nn5Uf4nL8CfN2HlFBK01F6TXpZNtLtH6YLooVbTnLHKK5UpbAL2+AzjN9SFbs1FbfQJ4nC4dVaE0EfD1fzPVSr7JyrerQ=
Received: from SA1P222CA0166.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::10)
 by SA1PR10MB997678.namprd10.prod.outlook.com (2603:10b6:806:4b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 11:02:28 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::d9) by SA1P222CA0166.outlook.office365.com
 (2603:10b6:806:3c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 11:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:02:27 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:27 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:02:26 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBe1204392;
	Fri, 30 Jan 2026 05:02:22 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 01/19] dmaengine: ti: k3-udma: move macros to header file
Date: Fri, 30 Jan 2026 16:31:41 +0530
Message-ID: <20260130110159.359501-2-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130110159.359501-1-s-adivi@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SA1PR10MB997678:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9b18be-f776-4c8f-6a75-08de5fef0e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AgxQdzywsYpJp850XjavQALqNi52mFS4UEYn0q91pQs2wGLd8zFZdxTbREo?=
 =?us-ascii?Q?SnYLnDAp9q4VyKx37vfAB23UY18qIfqnTKBcgpU9XyS2uYM7kB4X4r2IdX8p?=
 =?us-ascii?Q?PR/ii4WTC3o1wpRa7Ji/c7bYNIfW5h7uZDo8bZDQqGV4Ps+QKdyq3YXUNtNK?=
 =?us-ascii?Q?xxIzE5IVD3XlaH0gzerjnwC/wKwjdo7LKcaa+z9tSGRPM2WcmEZYf/INwtIP?=
 =?us-ascii?Q?oNVpcxr0ogBv1zt06VB8ax4vximrZydE4G6kwzi1Y3m1tVnRaMF4J3EvyWkP?=
 =?us-ascii?Q?/2/hPpRrhIq4irauIFlEc2FizIuS4PUEDmJP/9yJJFCHhk2YdMRkhc6gemby?=
 =?us-ascii?Q?5sv6d2jIh+XJAu6V5wxno9tAmE58PclU+q6e5SseRQP7LIKii/ESkvmL82kI?=
 =?us-ascii?Q?BHE9M+e5Isux1DC9/RAWzaeuYyzP6XbxrXcClbS7kb/w9MJ24qJBPBDFCyyH?=
 =?us-ascii?Q?RDuLxv7r6zQScCcSlphndENghPUeQOPSEwfp6vClhTsOZDnnqKXfAN4jVjh7?=
 =?us-ascii?Q?b1Ozv6VduoWqULAVOMod8GbU0s6lMdbCuqMCw7l6nsFe6CiL3XwHMfsCc/s/?=
 =?us-ascii?Q?BPwwmVp2tVQrJDl2yTeiodSS0GTKHJlQylI4rGbPFS5VA3C+k0AzsTF/OmL6?=
 =?us-ascii?Q?L8UoYv96k21wU9FKUxiKMB4w6IdHUgjyyQwW2OS8af1o3gwQp7N06vaEWcmP?=
 =?us-ascii?Q?otN4ZtDXscBRz+Z8stPmpDpJVvOE4yIRXL2FxSBo6F49hqNEiEcwXOTekVd2?=
 =?us-ascii?Q?YuCYWvl69HwczP2dWGtafHMVSt288TV1YgjIfmzqm+a80XhjTVXHrqfDmrfw?=
 =?us-ascii?Q?eUbixzVA4bsJnzypx/Pxg6TGG5LWn5dKw/si8A4nvPGBD7eg6kongqXW0HkB?=
 =?us-ascii?Q?JL78tOLXPq4Li7fgraOAZKcir7I+60wbII7fNO+SA4BmhtE2V+qJPeWheZH6?=
 =?us-ascii?Q?cZ2XolUhN3bHnpLU5NTmBbhSIoHkuEwyh+dAslcS3qw9QcQw9KoYDpa8YXN8?=
 =?us-ascii?Q?pz3NCVoLLFuWpvfpDu+kqJZ5Bt45ayeMiYhZsnF2wBbOzPvrcZZ6w4KmuV99?=
 =?us-ascii?Q?qHgB2pdIhSMTaXURpihQD5Qri4vC4sF98aO557zNZQzY3ngk1g/zyz5z00rr?=
 =?us-ascii?Q?w0J71eC59qIJmWB3HvzwOqkkrdKnqRVDqjHjyEcjDe1anSQLwRrC73BWVxZR?=
 =?us-ascii?Q?zgmqQl8vaXaEDROSnLbvsLFP5cpMpZP7vBBwicMrNd9V9b64bX9dqhbVPszY?=
 =?us-ascii?Q?fCVn/ntG1HPQMmkt7ShEvKyBmUESWHEvBnlG2O3AckJh8Ze7HgqrEJIVSUci?=
 =?us-ascii?Q?cIjt00zPMm+GUZBVCUCmfdbdTHglBCcvW1n2CPU5f2KO1QHOulBSzRkMxTYf?=
 =?us-ascii?Q?Src+AoilUn2RhCV+W82y2P4hxtF2iWopUzETLWSvFGJBR5CrbIhfO7TivUa9?=
 =?us-ascii?Q?J5CndhNAdUDz5FmkZpOy/1gzogTldj+3fnWxvNoUJ5VY4ljk3ZPJRSaPuZDG?=
 =?us-ascii?Q?Yf5RuApIZR2AkhSAXwQ+xMOutMrJPU+4BmztX9lZ085awgdSYFrA0A7UaKYJ?=
 =?us-ascii?Q?/vgc4oUxC7WaAUeOM3VR6X4rB2XrQvYf5N0Xixo9eSIUC6FDw2Vg6wWN5tqn?=
 =?us-ascii?Q?ubkYMQOiEB20Odn5IU0yrkC1HJNrMNeywetred9fTQvm08r97Sb6V5Zrf4ag?=
 =?us-ascii?Q?06cVT8BhDQQyE0W7FziELM8KPx4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4t5efJ3W9Yd2iotjn6o38jI929J0x/rsbC8CP5tki0hKOCEEFZTJg4LxfPJ+KzjB1TGAI8WiMYsCIqbMT0HT2dW/rHAFAwzaZqrvvNGHPnua01br/920WoV+/EONYZ3+tPDIaDahexXxtfOynGkdAf2wl9yi3dSswt8I1U4OQA8Cw2HsK9Ry8K59A9/mm2gbrEUNS4S6u55otyD0SuuGTy+O9RpQm6h95xa9GIdSNXk7Z0+lf3gy2QaUN4xTIsDpm/QdiaFumyGyw1+HMK6mYmva6C8Eh8SlF8yyIyzIOz2L7YgSlsX3ZFnIJ47efCgz8xx7wZDoZUCDaaBqtQXgH0xr8mQk6oShLrCfP8d6Dt0W9F6/Ev2xZi+PVcs90NCO7E5oX9skUDWHzms5KAZFGaXPTJ/IU/jDJY+MyCEoCkJmc4WMM/nFSYlfYv3AwKFP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:02:27.9301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9b18be-f776-4c8f-6a75-08de5fef0e94
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997678
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8595-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E0645B9B43
X-Rspamd-Action: no action

Move macros defined in k3-udma.c to k3-udma.h for better separation and
re-use.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 62 ---------------------------------------
 drivers/dma/ti/k3-udma.h | 63 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index aa2dc762140f6..4cc64763de1f6 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -39,21 +39,6 @@ struct udma_static_tr {
 	u16 bstcnt; /* RPSTR1 */
 };
 
-#define K3_UDMA_MAX_RFLOWS		1024
-#define K3_UDMA_DEFAULT_RING_SIZE	16
-
-/* How SRC/DST tag should be updated by UDMA in the descriptor's Word 3 */
-#define UDMA_RFLOW_SRCTAG_NONE		0
-#define UDMA_RFLOW_SRCTAG_CFG_TAG	1
-#define UDMA_RFLOW_SRCTAG_FLOW_ID	2
-#define UDMA_RFLOW_SRCTAG_SRC_TAG	4
-
-#define UDMA_RFLOW_DSTTAG_NONE		0
-#define UDMA_RFLOW_DSTTAG_CFG_TAG	1
-#define UDMA_RFLOW_DSTTAG_FLOW_ID	2
-#define UDMA_RFLOW_DSTTAG_DST_TAG_LO	4
-#define UDMA_RFLOW_DSTTAG_DST_TAG_HI	5
-
 struct udma_chan;
 
 enum k3_dma_type {
@@ -118,15 +103,6 @@ struct udma_oes_offsets {
 	u32 pktdma_rchan_flow;
 };
 
-#define UDMA_FLAG_PDMA_ACC32		BIT(0)
-#define UDMA_FLAG_PDMA_BURST		BIT(1)
-#define UDMA_FLAG_TDTYPE		BIT(2)
-#define UDMA_FLAG_BURST_SIZE		BIT(3)
-#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
-					 UDMA_FLAG_PDMA_BURST | \
-					 UDMA_FLAG_TDTYPE | \
-					 UDMA_FLAG_BURST_SIZE)
-
 struct udma_match_data {
 	enum k3_dma_type type;
 	u32 psil_base;
@@ -1837,38 +1813,6 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 	return ret;
 }
 
-#define TISCI_BCDMA_BCHAN_VALID_PARAMS (			\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_EXTENDED_CH_TYPE_VALID)
-
-#define TISCI_BCDMA_TCHAN_VALID_PARAMS (			\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID)
-
-#define TISCI_BCDMA_RCHAN_VALID_PARAMS (			\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID)
-
-#define TISCI_UDMA_TCHAN_VALID_PARAMS (				\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
-
-#define TISCI_UDMA_RCHAN_VALID_PARAMS (				\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
-
 static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -5398,12 +5342,6 @@ static enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
 	}
 }
 
-#define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
-
 static int udma_probe(struct platform_device *pdev)
 {
 	struct device_node *navss_node = pdev->dev.parent->of_node;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 9062a237cd167..750720cd06911 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -97,6 +97,69 @@
 /* Address Space Select */
 #define K3_ADDRESS_ASEL_SHIFT		48
 
+#define K3_UDMA_MAX_RFLOWS		1024
+#define K3_UDMA_DEFAULT_RING_SIZE	16
+
+/* How SRC/DST tag should be updated by UDMA in the descriptor's Word 3 */
+#define UDMA_RFLOW_SRCTAG_NONE		0
+#define UDMA_RFLOW_SRCTAG_CFG_TAG	1
+#define UDMA_RFLOW_SRCTAG_FLOW_ID	2
+#define UDMA_RFLOW_SRCTAG_SRC_TAG	4
+
+#define UDMA_RFLOW_DSTTAG_NONE		0
+#define UDMA_RFLOW_DSTTAG_CFG_TAG	1
+#define UDMA_RFLOW_DSTTAG_FLOW_ID	2
+#define UDMA_RFLOW_DSTTAG_DST_TAG_LO	4
+#define UDMA_RFLOW_DSTTAG_DST_TAG_HI	5
+
+#define UDMA_FLAG_PDMA_ACC32		BIT(0)
+#define UDMA_FLAG_PDMA_BURST		BIT(1)
+#define UDMA_FLAG_TDTYPE		BIT(2)
+#define UDMA_FLAG_BURST_SIZE		BIT(3)
+#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
+					 UDMA_FLAG_PDMA_BURST | \
+					 UDMA_FLAG_TDTYPE | \
+					 UDMA_FLAG_BURST_SIZE)
+
+#define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
+
+/* TI_SCI Params */
+#define TISCI_BCDMA_BCHAN_VALID_PARAMS (			\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_EXTENDED_CH_TYPE_VALID)
+
+#define TISCI_BCDMA_TCHAN_VALID_PARAMS (			\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID)
+
+#define TISCI_BCDMA_RCHAN_VALID_PARAMS (			\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID)
+
+#define TISCI_UDMA_TCHAN_VALID_PARAMS (				\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
+
+#define TISCI_UDMA_RCHAN_VALID_PARAMS (				\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
+
 struct udma_dev;
 struct udma_tchan;
 struct udma_rchan;
-- 
2.34.1


