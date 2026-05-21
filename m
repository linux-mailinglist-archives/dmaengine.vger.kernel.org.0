Return-Path: <dmaengine+bounces-10601-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B6HOxWnDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10601-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:32:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2359F71D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F5F43078DD2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B544395ADE;
	Thu, 21 May 2026 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oke+aX27"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020087.outbound.protection.outlook.com [52.101.228.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7F332EA7;
	Thu, 21 May 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345090; cv=fail; b=jWZJ8beGgy7YCdOzO79BWcnPAv53HyuaV+myF+lEewKFI06d5sAw5ZGtwjn4m9zQP8DUYr3XLWww+RbE0FSQHb9uYWCVhg62pJfLRWCEs5K2CxLfriuOfWW9ZbhyxAcLUtXdf06bHHwb9+YvxW491S7MghlmY7G7g2SRLvS2BoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345090; c=relaxed/simple;
	bh=ZT8U1mrwhfyM5rfGPkXLEWJyc9UtFiIyr0pa+SrYbHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvetFR7JYkTa/m4EcjLMDU+LJ6owVDmAJs9XenctrZY4PNh6F+fenI9ipd4C1SWdEVIn/quopr/tNbuxn16/EhTLvLILkq9cDne5yNoRqe8ktK0WndsvyzeG9ei4a5SmqD21N7+9McgYmixI0KYHRSrPsWvXqVzBoq+AqokrsiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oke+aX27; arc=fail smtp.client-ip=52.101.228.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7cGQX2562YGEmg0tXPMTxanbuohDC/BOUJfwgFiwKprCinei1xFi0QqdBoXzxs9GAHRkDxtU8EA07JuCWWuOJIBrv/KVt4doux+nK9NUYFMWp6//wHEV+lSH61WNOkURTNvres/E22QdSB2C9/MVwB1WWhEGZjYnBt0Upd8vu6n3iGYz762HGPss1/dLpsjkyi7dv07vRAYDSOCF8HAaEPgU8OmHTmf/9P34xCD7rvn8xA9EdAguPMTE+E6Oqksufh0+CNkfUGylGJZhx20NgXNMCAmBHYRRLqSFnCNlwj4JCE3SkjBy2nL3/KkfuSAFuFOQZIo6WygyrfeWCZrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAq5cOedkbWdw9dwOnPjSI33gkfhqskqNabVOqHSMs0=;
 b=RqDnT2k8Zcb5oMnHvgySmX6zbmjNemzkKb/l2u25KUU1INBPgjYmKcJloWH4/OkDKAUmbuUboJU7i3DEsXKlSKbZiDkx6GNRsHsdydNX1SOJ+3qqd25FRfrOcMtZyvAajtaSEltu3o35lvSN8krstvDiq9k+4g9/H5S6PhR0Hyr6CXZdMmNCn4sOKQydU4fsfsa6Ml/GgwLwfzcPt9pIh8Gw/uxyLZ0JSEhsSaaeN7Uk0WGi4bLj3qQX6P9yVZg7HJSv2nthV2yMeJnGwBS9myVTtw9sE3bZbW8xLYJrLvJ5I6RtrjELV1RPpVYbbH0oiNBW829xBZxvNbW3BDpW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAq5cOedkbWdw9dwOnPjSI33gkfhqskqNabVOqHSMs0=;
 b=oke+aX27IsvZq2jSZpcTPT3mEQQPVMMmuC54vGDrrOXAx+cRNqy+e+gYpmfyAkiB4VAgieiU44kqxDRWJxAeKlWIYB70HfLqX886EOv0UNeiCqClqPX8eu/X08XokV0Do5l+DXPf4MsoHvOgibg8bz+JUkpUYKPXnPq9Qxcbyog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7818.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:31:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] dmaengine: dw-edma: Add partial channel ownership mode
Date: Thu, 21 May 2026 15:31:07 +0900
Message-ID: <20260521063115.2842238-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 025afcfe-eec1-4096-3f4d-08deb7029397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nes0+lf2yANx20DjCuAwwOIcl9zcmmpkxdvIJFNPuYl3DLge87aBMgWo7kK/ZR5qKaAVkaiCm2FFJJKnCGRTbuvjlEGOUI6JPdl4SLsfd142zBpxywSsLLZaDIgC8ch+puqodSd/CcW/RnE6nbi75p7TvhXIuccNaIGntoTqq6f67FBWnbldK95JvzMnIlp9sAUR4NVdb0DeouhPxmz+SRvUKM2ICkXFIMDihsFppmiBujkDxTlzMGs+9vhKQ6i68wJhTxpWY8oh0J5ir06cLWmr+Vwn12onkMyz1n/gnL7yJAcT6N4Vv2NTLpB8Le2cOUou7M8yo7QhMxFPn10Z4Y7PqRg+a7eJ24jyyavrocz+X4fXOy9S+ulYWHf4URlKwugAiMcFuZVtUZGKjkMedlZps6BaGnKhgvf4WjlFl1WeTgmyhNifNVvXm2YAWxgEDWxHhc8Didrvh0mv+7dwCAdgIn2uPpRnnbfNQcNf8KMb+PoSuioJl6gBOyxidpUcVvMCoCzchxhCVpVBuopJfBRhHMSxVb0QaY9A19Fi9wOyLORVQQIvya8Te31ybDbtlSEVHgIkfQYLuHDpDFrwvPy/nga8UhDWgoG9FqvcDnSLVMF7V6b9sJUKZ20t1R/wpPOLtjt1bnk6r3nWvn/E8FEIki/Slws/zBtujfKBs5kHJTUiPtB3wCG3698Ayy4s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GuE4EKtz9mOm2xQg0BloT33x9YcTZR3kptK/ReaP7OCJXYsGaaCoAMO0NTxe?=
 =?us-ascii?Q?T2QpxCVqh6FRW8JRRf+cgwpUQUOsj31wf66sSKkT4fmlrb+vTcpxltXLlNt3?=
 =?us-ascii?Q?wj8y/afl5oItsGhyex6h06SOv7LDIuBzpPm3M0AbuIRA1gTeq1QEq9Qmluec?=
 =?us-ascii?Q?m8qs84G5OgNi9rAZsTqYjLyZcxLzIlF2pY6DjRx6euI5G86pniI3VoOUhqqS?=
 =?us-ascii?Q?OymDFVLlTOUN9JA3EJwaSSvM+nmcB/KXBrfbKLQ8Hz6SFj77aB8B1/M/cuAC?=
 =?us-ascii?Q?3H1+XPm9BVdUUwqw6w+9RppKoS1Pmm8VYpd+t9VEljzTiw7ci/wbjG/5i/6C?=
 =?us-ascii?Q?7sz0QdnhfPywl/vym0UCXcUf7ZSwXXDup3Z5cs3TM2gbPxrESXGdnrsnVRKa?=
 =?us-ascii?Q?/ivMugLFdUT/NHBaK5sKIXA08BpvxL5MVno0RD0siUIR2sr2ma2/+/yb+eSr?=
 =?us-ascii?Q?dnvjUbCxW+H5NkrmIbz9SzsVQiQp/YJvJ6eTV2mvboMaSO57kAunxRaAc4nQ?=
 =?us-ascii?Q?nSu+Jl6RJQpSFF72dDGKS3001cEQNbuD/i1J4JL8rPXortogyDvh5jLnDOPQ?=
 =?us-ascii?Q?dVhxyADTVnb2M08fX7rKR3r3MsZiulpbPLmJRAlHUaVLhgQYfs7eB4DmiZ2s?=
 =?us-ascii?Q?yxlz7kWABw2rJWA/tuhokStodMMmBwC9dGHcWeO+P80lk8NZmCLB836BQ5bi?=
 =?us-ascii?Q?7NtBky0hcYUK3gajylmAHAw2OKbgNRvvXpGIjG1OI9ldjnJsAntNVT6jRFJA?=
 =?us-ascii?Q?WXtve37+FxqpsB+wzp1SdrtV831a1em5pQNChASMC6s3COHDk7Ejqy6tSDac?=
 =?us-ascii?Q?F5YzZfhc0A5fG3M1ZuWc2grzoPcf8NWiHnj+EemmevKrZIDFchyPsBZjhMzr?=
 =?us-ascii?Q?nEMMHyfMHyQoCCSbHhoyNwNgc3pjGw1aTRVMEo8kxq97yt8pSadjdy4xZhvy?=
 =?us-ascii?Q?EdGbv3IelCFY8O2k1Icy3LsrCB4I2P91xk5km5virWOPjxTeV1X84iJXDR3N?=
 =?us-ascii?Q?FNTEhPhNDo7hYFiJC8pq0fbBG74SKKdzgnmMVrDNFvgA5aUlFD4vOtvXA6Oj?=
 =?us-ascii?Q?AM/nwWZkZOfyOqvZl37mzrKTvbrF7n2qaoVULVDA7ua1V6DL03J4asY757vo?=
 =?us-ascii?Q?Txii/j4jHTKtgcKyI0WJjP98xK6z/eyONfql3v7YqcIdcu5pDfcwmr5G6NYr?=
 =?us-ascii?Q?sWIfRmlu8hr8Bcpfa02shIsEBsIJS4rktBatbFFVRcY6K5rt49kOanC7YhGY?=
 =?us-ascii?Q?nI6K5qe63nPAocwQN5Fp83yNOABIzH5vn71NhHeLrBv8T2fWAkmdlk5hFs+X?=
 =?us-ascii?Q?lVWBvXEkTNmo2VQi85OiGm0ACkpBRxY5zt/sC+fm9aLK3EZmIiEjOx0FvqLc?=
 =?us-ascii?Q?6gayDKkcjyIBJTfyinh51ardG1KR8G0MQqqOCmmR00dkTd1uesMr0RG91HZk?=
 =?us-ascii?Q?ifEuRQDOgA8YIGx3dYw3SuQ6MioqTeSo1Y7nikXbOXtcbu+Y/W8p6anVT2U6?=
 =?us-ascii?Q?EjcUiAgQurSjf7HUdz7tGVyop897L2lt37VldCRzctEuW7UrvnwRJLMtNrwg?=
 =?us-ascii?Q?V9cEasN4gLu8/DEDOdyXy+25yp53kE3Pz91XvEUHfqq3Gplb9kA8r3ckoxKf?=
 =?us-ascii?Q?L1VyLtbt05F72M4geoWjq9KosFiXefoalP+Sz7krpeIrWTLtOFiCCpRqVN47?=
 =?us-ascii?Q?NIIAu0ImBbUF6rK+fb+rzDGe27Kdfxiq07PcWizXj7g1Ar0WHhaYgLYBIzH7?=
 =?us-ascii?Q?IDDOLb3Uc/OkajOS5wr0bCBKZDBvqD7y1/1Dxw5VMhtjhTQ0p+K5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 025afcfe-eec1-4096-3f4d-08deb7029397
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:22.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcCBp8pisbYE4rDmilUJJuSHjC9b82cN4+hUIvyGh8FkAxYIIsmDylyn10jGFGlc3WRJmUqs5gphxDEPaNpczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10601-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68A2359F71D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some endpoint DMA frontends expose only a subset of a controller that is
also initialized by the endpoint-side OS. Add a partial ownership flag
so dw-edma does not reset controller-wide state in probe() or remove().

Keep the mode conservative. Do not enable interrupt-emulation doorbells,
and reject eDMA legacy mode because it uses a shared viewport selector.
For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, require ownership of
all channels in each exposed direction. The driver updates registers
shared by all channels in a direction, such as interrupt masks and
linked-list error enables, so two independent OS instances cannot safely
split one direction without a shared locking protocol, which is
unrealistic.

The frontend must still quiesce delegated channels before removing a
partial instance. The flag only keeps probe() and remove() from
resetting controller-wide state that may belong to a peer OS instance.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 43 +++++++++++++++++++++++-------
 include/linux/dma/edma.h           |  6 +++++
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 72dc8a60798a..ec32a2ab1651 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -784,6 +784,9 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
 	chip->db_irq = 0;
 	chip->db_offset = ~0;
 
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
+		return 0;
+
 	/*
 	 * Only meaningful when the core provides the deassert sequence
 	 * for interrupt emulation.
@@ -1128,6 +1131,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 {
 	struct device *dev;
 	struct dw_edma *dw;
+	u16 hw_wr_ch_cnt;
+	u16 hw_rd_ch_cnt;
 	u32 wr_alloc = 0;
 	u32 rd_alloc = 0;
 	int i, err;
@@ -1139,6 +1144,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (!dev || !chip->ops)
 		return -EINVAL;
 
+	if ((chip->flags & DW_EDMA_CHIP_PARTIAL) &&
+	    chip->mf == EDMA_MF_EDMA_LEGACY)
+		return -EOPNOTSUPP;
+
 	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
 	if (!dw)
 		return -ENOMEM;
@@ -1152,13 +1161,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
-			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
+	hw_wr_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
+			     EDMA_MAX_WR_CH);
+	hw_rd_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
+			     EDMA_MAX_RD_CH);
 
-	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
-			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
+		/*
+		 * Direction-wide registers are shared by all channels in that
+		 * direction, so a direction must have a single owner.
+		 */
+		if ((chip->mf == EDMA_MF_EDMA_UNROLL ||
+		     chip->mf == EDMA_MF_HDMA_COMPAT) &&
+		    ((chip->ll_wr_cnt && chip->ll_wr_cnt != hw_wr_ch_cnt) ||
+		     (chip->ll_rd_cnt && chip->ll_rd_cnt != hw_rd_ch_cnt)))
+			return -EOPNOTSUPP;
+	}
+
+	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
+	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
 
 	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
 		return -EINVAL;
@@ -1175,8 +1196,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
 		 dev_name(chip->dev));
 
-	/* Disable eDMA, only to establish the ideal initial conditions */
-	dw_edma_core_off(dw);
+	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
+		/* Disable eDMA only when this instance owns the controller. */
+		dw_edma_core_off(dw);
+	}
 
 	/* Request IRQs */
 	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
@@ -1220,8 +1243,8 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	if (!dw)
 		return -ENODEV;
 
-	/* Disable eDMA */
-	dw_edma_core_off(dw);
+	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL))
+		dw_edma_core_off(dw);
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 9ea7b24b5015..33aa6c8981b3 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -55,9 +55,15 @@ enum dw_edma_map_format {
 /**
  * enum dw_edma_chip_flags - Flags specific to an eDMA chip
  * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
+ * @DW_EDMA_CHIP_PARTIAL:	Only channels described by this instance are
+ *				owned by this driver. Controller-wide state
+ *				must be preserved, and layouts with shared
+ *				direction-wide registers must only be shared at
+ *				direction granularity.
  */
 enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
+	DW_EDMA_CHIP_PARTIAL	= BIT(1),
 };
 
 /**
-- 
2.51.0


