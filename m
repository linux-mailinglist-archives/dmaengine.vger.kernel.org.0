Return-Path: <dmaengine+bounces-8941-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMYnHTSMlWlhSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8941-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:53:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB6154EEE
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0F2D305F488
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837333D6DC;
	Wed, 18 Feb 2026 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KCHFEcAE"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D831C33D6CB;
	Wed, 18 Feb 2026 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408398; cv=fail; b=EyvoklhnnXIO+QE4ZS8okT4T0Y/AI62Ap7rv9/S7WjC3FMu2siXPexyDLzL5BflRneTUK8KT8VJK/nsz+v752yrfp2UYTks6hJkjuQaC860lPVX7QwzDoyh7pmB3fcXcY4Vtb5LtXPJM/Nd8yFzU31u1b385h4Et6tU6Xusm5YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408398; c=relaxed/simple;
	bh=YMik2q8tzNNlzAuZPzMo0R4lM50K15SCDsj+wqjPPgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cc5htYbtcLn69mnlpWuBZeWNrDLQS+xbPbiCQJLzb0AV+VCDuT50qTrcY9bvkmPWR9v8/cpUf5llgClqE7NGpMw4x8tFni/ujcp/ax2LlhamwR55L6cxI38qzcuPHRMi8nFd8rF0tHdCNBR7D+aZ3aFdXsmGzjI6odUMNziV5bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KCHFEcAE; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UATKoD0pwd27Pik+k6sXps+jB6neOhefHdtzdJmNdc7bFou5dDkldkM7wCXh2bcRzKEaRoV3YLM6rsJGDuS1d/7fBvZoIJ+GewgAqlKkQ5IUoFpuBnA09wKx27idN/6+2QbleRqSDxyW3a+ONGYl0rO936i/LUt9Z3eeuyKi6hpZFSsLkpdhvGFLmeiMLEkiC9ijpjCcuCpg/m1XdL4JxnWYpIZ8DfMa++qPvPH4DemhO0MUCzV9OlYzf2LBO7PPS/7eHTy1JFwbA8Bb8ZmeFedlnJFbrfwqn6SdQzoS70P4qvy8DIF7ukqqdRFX50LWQQ2+z2Fet6MpCU6+am8KZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m8DlyHCQoDSVNWPaVpyu30Is4EvIlbPpaYQDMFzug4=;
 b=BlpVuT4ZWxvufTghPad1BqN38iJ9MPJ+kIJi6f6+NyTFh4YeRUMy5LFa9roSx8qYycqClB38PpENvtCaXSixavz6j/yKe/pnMkgG/mhRuejkw8xpIS+UVdBFhW1tC7BW1mtoQQL85hZwukveAbdPmydgk8cD43n7DyJ2nlz4X56Y5MMp1Mw0q0I9eh/pTC0NJqOfCBk2r9ueN0BN9HMXYA/xsgJZTwdgpkvrIdZkU0/YXYd2mGlJJiAUy2eqtgXMxpJmdsVuvjpEEr3FV6fgR4+RSGprWqms0JWSoNzJyMCBCJ4UnKIUYI4n4TS263i+u5MT0KsFFHMvuXZlgC2dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m8DlyHCQoDSVNWPaVpyu30Is4EvIlbPpaYQDMFzug4=;
 b=KCHFEcAEJ8Hcz4VBJpqI99kMpXY+LSZGnMagg5SpLJfjaxPADDTodUOgTL+cmU6rEUncCjJ8XV9iWlPX20NBM+Ka4HL+k3TIau/wgh9OuqjvmRf3ST4yVShu9oFsXZ2aNp2TcsgPtNaNKO2wtdM6FaFy9UffJBzTbc2dBG81X6A=
Received: from DS7P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::28) by
 CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.14; Wed, 18 Feb 2026 09:53:13 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::aa) by DS7P220CA0029.outlook.office365.com
 (2603:10b6:8:223::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 09:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 09:53:12 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:11 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:11 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:53:11 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpIA200561;
	Wed, 18 Feb 2026 03:53:06 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 03/18] dmaengine: ti: k3-udma: move static inline helper functions to header file
Date: Wed, 18 Feb 2026 15:22:28 +0530
Message-ID: <20260218095243.2832115-4-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CO1PR10MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 53efd63a-01a9-4969-d630-08de6ed38762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fGgSVlEZL5oriPppoMhWP0Mvx3RuJlTfV+ZIGnYHFtUTG/IAz45LojSD68l0?=
 =?us-ascii?Q?CL/gwysKJPdDGAe6sLzToqrs7hIZpoyTMiATsZS93EghiWS+r8aYXMG3ivit?=
 =?us-ascii?Q?K/CDQ4nDo7IDxJrQ1hmLmdP5SGgvvNwUGqhyjy9GfGgXHF+3j5yK9hX5ObSF?=
 =?us-ascii?Q?8MhFQYRMv6WRCyWoL56kfo4rt/USePnZKxCLh8kF5mRjtX5huIFuxwXbWRdo?=
 =?us-ascii?Q?djCurSiepC3c58tL0rGcRuzYgwV1ziohc5bHmoN9VsxssksEvWO5pCLJDYCU?=
 =?us-ascii?Q?aI3UQLbcqmlZ9YsjWVQ/TWEZklQxhMI7oesXPhRpd+xi+NHvoJBZYAs6tt5t?=
 =?us-ascii?Q?LNHjSKgjQw4mmEypHQakes78VNpQJyOAHJxHBQoieUCVesvTQNiV2WYzPi60?=
 =?us-ascii?Q?EXGaiuKW0lxZuHl1hvgHiZcebJMHkb4sYq14QG9Uw7Wa1E+OyyxQCo5mTopX?=
 =?us-ascii?Q?yfRPsM0MZBB8w1oDlQDSjMe6lRuos3WaKNrZD4GHleeIbL4Snyf7yj25Agam?=
 =?us-ascii?Q?IW6STIyCC9OP1HKrqDLrEV8OIJDdQXgkPmcT+nxa96vNDp+UZZatIjodPgMZ?=
 =?us-ascii?Q?z3u/Tn6s+/wgjUyyyMXYyOb+Zh9Oa4AsCdbDgly0EJftCmhquW4MgtkX+iVW?=
 =?us-ascii?Q?eFmHnQXIeDsisGl3AqcVwzRs9GmDcj0/LGjQlBaiQ4ns19CEvoSdGae54Al6?=
 =?us-ascii?Q?Y4qRWVZWfKybyK2fmINYjO16+sqUhKaJte+eAo0AUlS42ao7MQkvcI/xr3IV?=
 =?us-ascii?Q?9T6jGnXWyDSPffh9LE3GQyahcV7e6FE1rYgske8g1JVkNbSzGO69v5mtVVTn?=
 =?us-ascii?Q?+RFNVkeda8URmSV7eLZukRr0GNUWCfiGb+k9L8rQo7nTZZgw91vpEmzn/Yux?=
 =?us-ascii?Q?rDGL2kXQk1NDicCREczzmZ9IJZvhct4x43EbH1+O7Gt96iXhZyQtKhtSOvwv?=
 =?us-ascii?Q?8Eoup/rhOvnldqpBl0eLqHXkHihOP89J9NLQ4hJkMrG4rhNcpiWbzxI24FfL?=
 =?us-ascii?Q?t1Eh3AC3kIb8nQz9v+xj3HeV5jxZ50Vq/XbAmKROEDjSqeOHdeS5TPqdNv6o?=
 =?us-ascii?Q?7kPnorJrFj9oyIElXN8hayYiDsEhdm6JPRZNn/8vcgit35itn9o+k6VcTVmK?=
 =?us-ascii?Q?jn3q82O4RIikUnPAk76fOrOdgQCCkvEo1ByH5gSFbYVj0SgwDeP5nupxb8HA?=
 =?us-ascii?Q?+bQBPt/i8OJGxMAEBnsONlMGLk3RyCMvyxd/hskv87gT4v/bCwpTtUafEqZG?=
 =?us-ascii?Q?Nw+4mobRUon+SBxJPzftkOaIavZat5JYdoJMAQ4LMPLjBrqBM5qclAfDw9SY?=
 =?us-ascii?Q?1sDRLNhQoxicwpEr7Bdrg6kB6oZRcX/MuDL993uDUif7NoHOZGP+7aAhjjTQ?=
 =?us-ascii?Q?NI/LCMkVfFGllCYal5kvh1oLno0pjgdLHjXXnJakBcBlEiq3PP04k3Do9k/c?=
 =?us-ascii?Q?OMMLPBKRRSifZBtH2MDmRkNBu0Vpu2XdbGSxn6eBKShQrGriyB3IBeUuRoaE?=
 =?us-ascii?Q?GEI2Mlgs2b+fPa5uHD8RvveUsL2IO4p6hUzQFCwY3rmcAVml6NF6rcGtNfck?=
 =?us-ascii?Q?qXpIUoxVMRmATDL/CnbdwNlmH9m4a7knQ5gmCiheVNw8s/Yv1UfuiqEXNonv?=
 =?us-ascii?Q?2Dy7Nx1uf/qvF7bQe+KUgK7wRBVNfMOxJVeR//vJxREvtucAM38AukK5Z5Ii?=
 =?us-ascii?Q?mLTirq5Yx7UDTSMCmTq1meILVho=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q4VXPaHyBiLTNRTE2Y6lZWN/s7faiesUtQfJ2X3ZhybgoG24I+kOTffWyBD6Wh9ZV1a1Hcr1tf9Vhiexd026aZaSGq/Au09iOtWk7+kzUt9ohHjgPy7guEnutFyEsyvf91YRh+1GnI7vmIA/06tfdAiLBuw/ecy70+dQavMlGBtuQKpgrLLMBx/qkJxX8j/sNuS5koKsd/lSL+ZHG1kWdxNi4fwhHrbUxgSWKbrwSngo+lsOvbCk9K6jXb1RvblgLokqtC8uXb1fp3HPZFRdeJuLHHz4dtU3B+HV4Vxhf5ZCsHGnge9ZiY5yT5zCuZDL6WEtkPJ57IW9JEzqzKgOmmZG+06yYBvJHIeWKnKvBFD7lIZEWwe8vu0HsOnppNba8FLjUBMilZzevF3mCGtr5c9xNqVBXBpo0zr+e2gfFVcmS6O8+vy1ZG3N793vOsYN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:53:12.0755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53efd63a-01a9-4969-d630-08de6ed38762
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8941-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,ti.com:mid,ti.com:dkim,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E6EB6154EEE
X-Rspamd-Action: no action

Move static inline helper functions in k3-udma.c to k3-udma.h header
file for better separation and reuse.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 108 --------------------------------------
 drivers/dma/ti/k3-udma.h | 109 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 108 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index e0684d83f9791..4adcd679c6997 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -40,91 +40,6 @@ static const char * const mmr_names[] = {
 	[MMR_TCHANRT] = "tchanrt",
 };
 
-static inline struct udma_dev *to_udma_dev(struct dma_device *d)
-{
-	return container_of(d, struct udma_dev, ddev);
-}
-
-static inline struct udma_chan *to_udma_chan(struct dma_chan *c)
-{
-	return container_of(c, struct udma_chan, vc.chan);
-}
-
-static inline struct udma_desc *to_udma_desc(struct dma_async_tx_descriptor *t)
-{
-	return container_of(t, struct udma_desc, vd.tx);
-}
-
-/* Generic register access functions */
-static inline u32 udma_read(void __iomem *base, int reg)
-{
-	return readl(base + reg);
-}
-
-static inline void udma_write(void __iomem *base, int reg, u32 val)
-{
-	writel(val, base + reg);
-}
-
-static inline void udma_update_bits(void __iomem *base, int reg,
-				    u32 mask, u32 val)
-{
-	u32 tmp, orig;
-
-	orig = readl(base + reg);
-	tmp = orig & ~mask;
-	tmp |= (val & mask);
-
-	if (tmp != orig)
-		writel(tmp, base + reg);
-}
-
-/* TCHANRT */
-static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
-{
-	if (!uc->tchan)
-		return 0;
-	return udma_read(uc->tchan->reg_rt, reg);
-}
-
-static inline void udma_tchanrt_write(struct udma_chan *uc, int reg, u32 val)
-{
-	if (!uc->tchan)
-		return;
-	udma_write(uc->tchan->reg_rt, reg, val);
-}
-
-static inline void udma_tchanrt_update_bits(struct udma_chan *uc, int reg,
-					    u32 mask, u32 val)
-{
-	if (!uc->tchan)
-		return;
-	udma_update_bits(uc->tchan->reg_rt, reg, mask, val);
-}
-
-/* RCHANRT */
-static inline u32 udma_rchanrt_read(struct udma_chan *uc, int reg)
-{
-	if (!uc->rchan)
-		return 0;
-	return udma_read(uc->rchan->reg_rt, reg);
-}
-
-static inline void udma_rchanrt_write(struct udma_chan *uc, int reg, u32 val)
-{
-	if (!uc->rchan)
-		return;
-	udma_write(uc->rchan->reg_rt, reg, val);
-}
-
-static inline void udma_rchanrt_update_bits(struct udma_chan *uc, int reg,
-					    u32 mask, u32 val)
-{
-	if (!uc->rchan)
-		return;
-	udma_update_bits(uc->rchan->reg_rt, reg, mask, val);
-}
-
 static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
@@ -216,17 +131,6 @@ static void udma_dump_chan_stdata(struct udma_chan *uc)
 	}
 }
 
-static inline dma_addr_t udma_curr_cppi5_desc_paddr(struct udma_desc *d,
-						    int idx)
-{
-	return d->hwdesc[idx].cppi5_desc_paddr;
-}
-
-static inline void *udma_curr_cppi5_desc_vaddr(struct udma_desc *d, int idx)
-{
-	return d->hwdesc[idx].cppi5_desc_vaddr;
-}
-
 static struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
 						   dma_addr_t paddr)
 {
@@ -369,11 +273,6 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
 	return false;
 }
 
-static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
-{
-	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
-}
-
 static int udma_push_to_ring(struct udma_chan *uc, int idx)
 {
 	struct udma_desc *d = uc->desc;
@@ -775,13 +674,6 @@ static void udma_cyclic_packet_elapsed(struct udma_chan *uc)
 	d->desc_idx = (d->desc_idx + 1) % d->sglen;
 }
 
-static inline void udma_fetch_epib(struct udma_chan *uc, struct udma_desc *d)
-{
-	struct cppi5_host_desc_t *h_desc = d->hwdesc[0].cppi5_desc_vaddr;
-
-	memcpy(d->metadata, h_desc->epib, d->metadata_size);
-}
-
 static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
 {
 	u32 peer_bcnt, bcnt;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 37aa9ba5b4d18..3a786b3eddc67 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -447,6 +447,115 @@ struct udma_chan {
 	u32 id;
 };
 
+/* K3 UDMA helper functions */
+static inline struct udma_dev *to_udma_dev(struct dma_device *d)
+{
+	return container_of(d, struct udma_dev, ddev);
+}
+
+static inline struct udma_chan *to_udma_chan(struct dma_chan *c)
+{
+	return container_of(c, struct udma_chan, vc.chan);
+}
+
+static inline struct udma_desc *to_udma_desc(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct udma_desc, vd.tx);
+}
+
+/* Generic register access functions */
+static inline u32 udma_read(void __iomem *base, int reg)
+{
+	return readl(base + reg);
+}
+
+static inline void udma_write(void __iomem *base, int reg, u32 val)
+{
+	writel(val, base + reg);
+}
+
+static inline void udma_update_bits(void __iomem *base, int reg,
+				    u32 mask, u32 val)
+{
+	u32 tmp, orig;
+
+	orig = readl(base + reg);
+	tmp = orig & ~mask;
+	tmp |= (val & mask);
+
+	if (tmp != orig)
+		writel(tmp, base + reg);
+}
+
+/* TCHANRT */
+static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
+{
+	if (!uc->tchan)
+		return 0;
+	return udma_read(uc->tchan->reg_rt, reg);
+}
+
+static inline void udma_tchanrt_write(struct udma_chan *uc, int reg, u32 val)
+{
+	if (!uc->tchan)
+		return;
+	udma_write(uc->tchan->reg_rt, reg, val);
+}
+
+static inline void udma_tchanrt_update_bits(struct udma_chan *uc, int reg,
+					    u32 mask, u32 val)
+{
+	if (!uc->tchan)
+		return;
+	udma_update_bits(uc->tchan->reg_rt, reg, mask, val);
+}
+
+/* RCHANRT */
+static inline u32 udma_rchanrt_read(struct udma_chan *uc, int reg)
+{
+	if (!uc->rchan)
+		return 0;
+	return udma_read(uc->rchan->reg_rt, reg);
+}
+
+static inline void udma_rchanrt_write(struct udma_chan *uc, int reg, u32 val)
+{
+	if (!uc->rchan)
+		return;
+	udma_write(uc->rchan->reg_rt, reg, val);
+}
+
+static inline void udma_rchanrt_update_bits(struct udma_chan *uc, int reg,
+					    u32 mask, u32 val)
+{
+	if (!uc->rchan)
+		return;
+	udma_update_bits(uc->rchan->reg_rt, reg, mask, val);
+}
+
+static inline dma_addr_t udma_curr_cppi5_desc_paddr(struct udma_desc *d,
+						    int idx)
+{
+	return d->hwdesc[idx].cppi5_desc_paddr;
+}
+
+static inline void *udma_curr_cppi5_desc_vaddr(struct udma_desc *d, int idx)
+{
+	return d->hwdesc[idx].cppi5_desc_vaddr;
+}
+
+static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
+{
+	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
+}
+
+static inline void udma_fetch_epib(struct udma_chan *uc, struct udma_desc *d)
+{
+	struct cppi5_host_desc_t *h_desc = d->hwdesc[0].cppi5_desc_vaddr;
+
+	memcpy(d->metadata, h_desc->epib, d->metadata_size);
+}
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.34.1


