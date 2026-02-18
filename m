Return-Path: <dmaengine+bounces-8944-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIKCDoKMlWlVSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8944-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:55:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8CC154F6D
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95CF8305BFD4
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7B33D6F5;
	Wed, 18 Feb 2026 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="us0tJ49d"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869033D6E4;
	Wed, 18 Feb 2026 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408412; cv=fail; b=ZHYN2Lb3Ft5y4uMUuWgFmYsFcPSQo8zuUP3liFU4HFbo/xC0AeT4FDbcPT3Ub9VemovEQOn8sB92Uz4osQje/ecer+LRiyIQBL7bLL0pS8bj1FC6jbsU8nJi0xrZ+HOt7qenKdBK/ptitHW/VPfsySlVPExo5oS2Q1V3Y2bNSEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408412; c=relaxed/simple;
	bh=DXXQ8T1Si6Oe3z/2/l2/IVOBQu3MV2Zzfv74wQLliOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQfT5tZ707NCNXz6q6RBnntErXuJ1PzJCSz+rMLWowfoxl6Y2xyid3HoHZ8LKktseewcFfskStI6BPVKaiA9mxVNmApleoggxJjVOI9aSS/wDcQkExQFU5uEjGjQaxpw6Obqdq6ApAd6hvVEePb1UnqaFXyd7n5lPLda/j6U1IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=us0tJ49d; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ircq0v/Mo38uKy3gX5WsSjGkqmCkXA0ZfdYZygkD9+RK/+QF/caTxzQvGYYyZ/b6xkGB/Md2KNAGUJekPZNgNtgJsVos7mv6zyR66u3PRyfeOCUkBTmyUbSH4DWieb6dLOtaIlznMSqEkAwbJpXTH2/OEdyJbZ7A3FjQJKLdt7+1uxdH2iRinVui1sqCFhQ65r7Y936NjFc8mkn/6Z7E5zDYPi/fsTLZju9EpLtVRG4LF4BFeZAzycAWEKX5cvj9iGiJglmKbI+9plNWW4txEzoqTnEI1NnzGUA8A0TSstfEhSbbA6g6sFtbberTjx2rvV1Vck6UzcbRO3u+I+hI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2bbI08pAGxSfjgYVObcI3iE0QJRu70cvAJxUY4k3aQ=;
 b=Gq+205S+XO502FrxDu1LAHGPI/zTzLOxzWPu2YKG1pQ5ljoHdwgJOOpdM/Dgxi9zJpAdzXqMTavmhDXAXG32qHovL/0/aYjtSIPzPF2Cwm1QBPlbMQaVEV4NcHYietHCcL/X5W2nO19qVlmW9uRDYbiDI9iIcRbu4QyqsBKNmBGtd0U9pm6HzSmw8mbq+z8Jn4gLbmF1HEnfAVwMjT2lO2SfqORp+ZGZ6TuNOLZAFouy6uFlgUx3FlEyei6nIXGjuCgHkJ1jGpLdgyuDnp6plcNkWJ/uRiC8tCMIFySea+3aVCJ0+DZimJcARalnxMh/AsyDvasxNTRJLAKuSfilFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2bbI08pAGxSfjgYVObcI3iE0QJRu70cvAJxUY4k3aQ=;
 b=us0tJ49dzOg15GIBdAEYVAWaj7SRDnqVh0OSR8YJaKIXw5/80dA+fcVSGl+u5G+/Fy0QRcnR6xxdYz+6aTjG7qP1uVBUIukGY2akO6Nd36bYjEDFy6vkl3G5/uR1jmSbb2reWoM//8ib8lsLI1FCF/1Qnk7KOR468D5TisyPKPE=
Received: from DS7PR03CA0108.namprd03.prod.outlook.com (2603:10b6:5:3b7::23)
 by BN0PR10MB5095.namprd10.prod.outlook.com (2603:10b6:408:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:53:28 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::98) by DS7PR03CA0108.outlook.office365.com
 (2603:10b6:5:3b7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 09:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 09:53:26 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:26 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:53:25 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpID200561;
	Wed, 18 Feb 2026 03:53:21 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 06/18] dmaengine: ti: k3-udma: Add variant-specific function pointers to udma_dev
Date: Wed, 18 Feb 2026 15:22:31 +0530
Message-ID: <20260218095243.2832115-7-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|BN0PR10MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 508839de-dca2-4a85-c402-08de6ed38fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?scTRHo+94xv5WtRvtSvhLJJTyRBV50TmYEoBazmjNW9UHeCMtC5u6UHe4nr4?=
 =?us-ascii?Q?G+1WnolhOhK+0Ht0Z50hcIU4z8797rlZPhixcwb/5IARhreV7xp7igqcdn/x?=
 =?us-ascii?Q?YYgqHYLA0RYt8c9WcgpArzO+gomkggOkVyEsx7YTKHBrSeNw14VSet+DCg6S?=
 =?us-ascii?Q?KtkY/WksYMGZSI3ybsv8T0cncTdkxL1xGYw32zKskxs08wJLlHnZ6uP9vUsb?=
 =?us-ascii?Q?C5viNtFUHyvSusAOtXPXz3Xdes3Sf2IJFxD0yKzG1Jso9qHbNtPaVfk52d9l?=
 =?us-ascii?Q?MCb7DkRfHh7F093JvyYfJgmQE2NW7EzPythqP4/AFNiZkP95OnmaowaQ+bSn?=
 =?us-ascii?Q?x4CIGCjrb0CZDkusVwj0IxEOieOokizGO2pge7822hwKGHkkrtOfoX3r0Ns/?=
 =?us-ascii?Q?xqwLOUnBcAUKBko7QaftSpImN7jDjwBxoNreLDzC9kdvdcAhyOyhD/WHfj5j?=
 =?us-ascii?Q?NmVVMlvYG8pw2ESphDZxRfXORpoU93b/EXx9jgQ9FXWQIA17Of/A6myo2eXw?=
 =?us-ascii?Q?trkDso58zUX16flLGYgx5BBHJ/Fh/R5Bv4AJPfwpIFX0A6shOvxSdHSmafzc?=
 =?us-ascii?Q?IoPMwo0A6tzOaVmA9qSMbH9FDqHjC8lv8uRpPGp+2uhLmz/sjTiKM9PJzSEI?=
 =?us-ascii?Q?QKLTe8F+/t5ZtcdCFfHif9DD+iD/XmtXafQg83rfuCauA7TFkGU0Diyy2VaV?=
 =?us-ascii?Q?HwO+AeDpg8C6NIPiCn+ly5uCeMgF25wGKcdJc/rh2VDW0IJJSYrc+MoGB+mV?=
 =?us-ascii?Q?1Gq/dxVq4L/FrQtPFJDMzsUDLQqVic4fRWxEtmg9BRsNemIFUYQlHd4kXEJ5?=
 =?us-ascii?Q?8L7QwtmRq2eW7ZbveNwhu9usojBnfiY7KG/Nurv0gF19Tveeu/zVlzpMLmYB?=
 =?us-ascii?Q?5nT4Bm5ktZlLWwCAlTGuadZ6ih6KAcapbZsNxdfX9s5cdIHoS+4A50FMsmTa?=
 =?us-ascii?Q?P1YL4ZcS4S42qnlgXMaTnu3TWiX3R8BYo9UB3TmIuGHvC5KPXf6272d+bBIt?=
 =?us-ascii?Q?jOx4XkiI6sMx0s57xAI/309POXIWXZ1lQepMLAmtVb4W/dS8QCBFXmHM3fQA?=
 =?us-ascii?Q?fteQrzBhzMnzykhsRTYaNFOI9H/Z1vtYxTPGMkZIWLT5M0r1OFy2yeXsLKAU?=
 =?us-ascii?Q?vdqyIPCyT2k2cGTYVA1lIQy9bb/BNO7PkmXLOXOpaf1y5/2LCwdgs3UmM8Ks?=
 =?us-ascii?Q?KtX4tYPlhbpmNYrXKoXwfyaYiYutDiCQQAeKrqHriZgkEUwMzCXoHfU/a1nG?=
 =?us-ascii?Q?NXl0eDfHUYedGxesYNG68w/PdnVvvir+pXCQJIoppWc13R60BhzMuzwCYRQD?=
 =?us-ascii?Q?lRNIp7YxIo8GoefY5ahYzR6pFeKKBb7LD+600y9JVmDndVOE0uzc0XNeCi3z?=
 =?us-ascii?Q?inmt488KjZSKiv98qNHoCMh/epqyR8vfw0jPmzmqEzVUGWHsAtUSFf5cYuUW?=
 =?us-ascii?Q?V/bzNLDZIqLHXORyTfb3pudgKurJ3TU5D53CFpnHNzQbIx8Hb1b2yWbGddll?=
 =?us-ascii?Q?xvla00U/gFJTiXSNNMN4qBFIjBlTWMn+cPOiTuqX3gGgL9vMiiS22+lg8jqz?=
 =?us-ascii?Q?0Yeu7s13npW0RelY/cge36ph6rLUYpzCPNneAlbneOcVFWJWpUgZTahBoSa1?=
 =?us-ascii?Q?PW7IZrNJCT5HgET9OAvbcTgFsMCmiSA4WdwcozXRtwVOMOr4QFMK85+H7ZMW?=
 =?us-ascii?Q?IUEqfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/k77AiDaRvx0Mj08i+xNCvDZohYeLxP/NWOx9TsvN89up74DQCzdwwUSg/gHW20YKOb3qaPExB98/NOqXTP7ccC0ePNwxqKjzHEK6LroG/do/6R/Gh5NyOPvNcTaoL/k/UfQehXFG5oyBqwnIhHAGkl6CYHzV+Y0dXlckTkItzrCC38HkzE44NcJcdurbVvpPtHYfOshcUGBuFVL5xhxK2WEyXn2qW9WyFDdQYqFonQMR3J+3qNKA5gdpB3qHwr7j2naoI/SkNmEhFHRO335F8gOcN6JSWATmpZ64TN4d6OHmyDyMcmYz0n2e9U0plmeN3aP1QgtSWFTjIMRX97CV4k58ycO1cbypXD2ilHMM1Q9w8R/iGBhmVpeZ4lIcAfUsF+TY7qlRvhfFDRU0kwKvz6RUQ4gccdsJZG2ZrTWkzaRvJL5pIpd+qSmHjrGPNSK
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:53:26.3991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 508839de-dca2-4a85-c402-08de6ed38fec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5095
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8944-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BB8CC154F6D
X-Rspamd-Action: no action

Introduce function pointers in the udma_dev structure to allow
variant-specific implementations for certain operations.
This prepares the driver for supporting multiple K3 UDMA variants,
such as UDMA v2, with minimal code duplication.

No functional changes intended in this commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-private.c | 10 +++++--
 drivers/dma/ti/k3-udma.c         | 46 +++++++++++++++++++-------------
 drivers/dma/ti/k3-udma.h         | 12 +++++++++
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 624360423ef17..44c097fff5ee6 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -8,13 +8,19 @@
 
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
-	return navss_psil_pair(ud, src_thread, dst_thread);
+	if (ud->psil_pair)
+		return ud->psil_pair(ud, src_thread, dst_thread);
+
+	return 0;
 }
 EXPORT_SYMBOL(xudma_navss_psil_pair);
 
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
-	return navss_psil_unpair(ud, src_thread, dst_thread);
+	if (ud->psil_unpair)
+		return ud->psil_unpair(ud, src_thread, dst_thread);
+
+	return 0;
 }
 EXPORT_SYMBOL(xudma_navss_psil_unpair);
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 214a1ca1e1776..397e890283eaa 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -40,7 +40,7 @@ static const char * const mmr_names[] = {
 	[MMR_TCHANRT] = "tchanrt",
 };
 
-static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
+int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 
@@ -50,8 +50,8 @@ static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 					      src_thread, dst_thread);
 }
 
-static int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-			     u32 dst_thread)
+int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
+		      u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 
@@ -329,7 +329,7 @@ static int udma_start(struct udma_chan *uc)
 	}
 
 	/* Make sure that we clear the teardown bit, if it is set */
-	udma_reset_chan(uc, false);
+	uc->ud->reset_chan(uc, false);
 
 	/* Push descriptors before we start the channel */
 	udma_start_desc(uc);
@@ -521,8 +521,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 		if (uc->desc) {
 			struct udma_desc *d = uc->desc;
 
-			udma_decrement_byte_counters(uc, d->residue);
-			udma_start(uc);
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
 			vchan_cookie_complete(&d->vd);
 			break;
 		}
@@ -554,7 +554,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 		}
 
 		if (!uc->desc)
-			udma_start(uc);
+			uc->ud->start(uc);
 
 		goto out;
 	}
@@ -576,8 +576,8 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 				vchan_cyclic_callback(&d->vd);
 			} else {
 				if (udma_is_desc_really_done(uc, d)) {
-					udma_decrement_byte_counters(uc, d->residue);
-					udma_start(uc);
+					uc->ud->decrement_byte_counters(uc, d->residue);
+					uc->ud->start(uc);
 					vchan_cookie_complete(&d->vd);
 				} else {
 					schedule_delayed_work(&uc->tx_drain.work,
@@ -612,8 +612,8 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 			vchan_cyclic_callback(&d->vd);
 		} else {
 			/* TODO: figure out the real amount of data */
-			udma_decrement_byte_counters(uc, d->residue);
-			udma_start(uc);
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
 			vchan_cookie_complete(&d->vd);
 		}
 	}
@@ -1654,7 +1654,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -1821,7 +1821,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -2014,7 +2014,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -2123,7 +2123,7 @@ static void udma_issue_pending(struct dma_chan *chan)
 		 */
 		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
 		      udma_is_chan_running(uc)))
-			udma_start(uc);
+			uc->ud->start(uc);
 	}
 
 	spin_unlock_irqrestore(&uc->vc.lock, flags);
@@ -2265,7 +2265,7 @@ static int udma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&uc->vc.lock, flags);
 
 	if (udma_is_chan_running(uc))
-		udma_stop(uc);
+		uc->ud->stop(uc);
 
 	if (uc->desc) {
 		uc->terminated_desc = uc->desc;
@@ -2297,11 +2297,11 @@ static void udma_synchronize(struct dma_chan *chan)
 			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
 				 uc->id);
 			udma_dump_chan_stdata(uc);
-			udma_reset_chan(uc, true);
+			uc->ud->reset_chan(uc, true);
 		}
 	}
 
-	udma_reset_chan(uc, false);
+	uc->ud->reset_chan(uc, false);
 	if (udma_is_chan_running(uc))
 		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
 
@@ -2355,7 +2355,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 
 	udma_terminate_all(chan);
 	if (uc->terminated_desc) {
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		udma_reset_rings(uc);
 	}
 
@@ -3694,6 +3694,14 @@ static int udma_probe(struct platform_device *pdev)
 		ud->soc_data = soc->data;
 	}
 
+	// Setup function pointers
+	ud->start = udma_start;
+	ud->stop = udma_stop;
+	ud->reset_chan = udma_reset_chan;
+	ud->decrement_byte_counters = udma_decrement_byte_counters;
+	ud->psil_pair = navss_psil_pair;
+	ud->psil_unpair = navss_psil_unpair;
+
 	ret = udma_get_mmrs(pdev, ud);
 	if (ret)
 		return ret;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 4c6e5b946d5cf..2f5fbea446fed 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -344,6 +344,15 @@ struct udma_dev {
 	u32 psil_base;
 	u32 atype;
 	u32 asel;
+
+	int (*start)(struct udma_chan *uc);
+	int (*stop)(struct udma_chan *uc);
+	int (*reset_chan)(struct udma_chan *uc, bool hard);
+	void (*decrement_byte_counters)(struct udma_chan *uc, u32 val);
+	int (*psil_pair)(struct udma_dev *ud, u32 src_thread,
+			 u32 dst_thread);
+	int (*psil_unpair)(struct udma_dev *ud, u32 src_thread,
+			   u32 dst_thread);
 };
 
 struct udma_desc {
@@ -614,6 +623,9 @@ int udma_push_to_ring(struct udma_chan *uc, int idx);
 int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr);
 void udma_reset_rings(struct udma_chan *uc);
 
+int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+int navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.34.1


