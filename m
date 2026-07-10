Return-Path: <dmaengine+bounces-12280-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tI4yE2qqUGpt3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12280-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22256738581
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=W7JQ68Mu;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12280-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12280-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50E0A30151B6
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0C3EF0AA;
	Fri, 10 Jul 2026 08:15:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021109.outbound.protection.outlook.com [52.101.125.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80A3C8194;
	Fri, 10 Jul 2026 08:15:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671333; cv=fail; b=agVk1tdgySgbVjjzgNs+57mJHWXoiDIbxzjc+6+QncBdnBAiuCMTykRMmT9xT09QJlsQv5CuSoGcRYePHXPrd2paB1Z9qZ3PSsqTRYGE70iTiotRT84+YacRVlM0XhK1b2DOJniAkCw7TVRXemkyBn61l9QdKnhtwy4eGktyjfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671333; c=relaxed/simple;
	bh=VYiznSJ5b6U8+milqKeqwb0xdXW4FHuZCGEaIcYkXxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXAoYglozMy5uzkOluDkl84VeZgqOiZQXWIE9TSvvoPO/MJbkzmlw4DFUoaRub9aXXT+bC3bbg2/oLVI66KEhxqECzlTfc3DTsqgp1A1XxlvtQ8d1AOcfowpdcZY/nbd9R8aGHzoKeU9fusn03gmaJ3IMfEO/pCuugUEqa1GNdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=W7JQ68Mu; arc=fail smtp.client-ip=52.101.125.109
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVrLExOc723CLMxmiu3N1cvpvn3VA79QwhIL2Vdb6kcTT2jTW+o/j28fIKtLVyLAxGMxaRbOWQYTa1fNMknPu24WcVnToue//rd3jVhYm45N3YdyUSSCDij/RA3BtULFd5JdKa7fmuDuP7Efq4ED8PwsZKxcLXZNqb3cgwthUyeX3YTk51ufUSLabur54ucKsfeBj+gYHwyaSxEoPPxpTrP8wwAyESKQA6Szgkdo0SeWZrS4q+5wcRFD9cpKuTcTFGua7RoTObiUOCaVhss/uaHI2chNPZ6RDsSneCNdQN3ir+fsw4pg13upP6rM9E/8biKRhkVEwyih3wxMCE3fZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYavP4i8j7E2welPB9qurLaFZNHKTCoTxlhl1TrKQ6s=;
 b=BGWCVLfB7ElJao0Q+B+e+KR19sn+XzVbOBvCy8NPP6BviPPIRhzoYhBMXy1a33/OG91gvGWy060w9d9R/t0M1i5RVUObiFniSC5JZ5J5VXdvPbwM00bDlhZLRmhLdWdVKNKhrUuXlyeB2E2wpKubxmMuxU4sMmRJfTL4uT3SBfOxWPt0da1y/h6IM6gD0vApIOFm+Oxs5Ar+yMgUcQda/pAAzRY0hui71+HfVow17xruidlZDfspNn/j2ANwwq1tHEm2cBCZ1U38zBZd8cAUo7cN4C1nukxRLkMRtUx+BxqwmftXtOpmNWedH6ImeA09jj44vcUWjfv9VREwKKqzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYavP4i8j7E2welPB9qurLaFZNHKTCoTxlhl1TrKQ6s=;
 b=W7JQ68MuY9h2B28acw+VKkFMuWvuGSdQgO5/gOgTZAwyCWZeyQK4R1YwwTMCX1SoRi9S1txAPfajWHMSfphdFvEhuvWkspkESrgFpsTzsL0FFTrbK0J9j2GCcSUQuF+0gB/vBhFMJKORReKoWfgm8/GZaxvTEwhNqpKeAlDUfIk=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4074.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:15:29 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:29 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/14] dmaengine: dw-edma-pcie: Add register offset match flag
Date: Fri, 10 Jul 2026 17:15:14 +0900
Message-ID: <20260710081518.2394357-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0293.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ba278d-47bb-448e-685c-08dede5b6762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|23010399003|366016|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RYdiVEhrTv7+W/+xu+72hW331kXxnosKPfTgf0ZPO3xCM0bK31/evEGmNJezNecM3F+AXa/Uf/PDQQCii+Hj97CbmXGWPOZNmUOXdAI2wypJAeH6YOCwDH0GrRmpZIlas46S3tFGJSgKe1gcca1W/U3ywrCExmtBOAT3X6a33Hozxm02sUDyj8jWeEDon48UO/e5Mf2avoDCtf5EAK0ko4er8+uN6OVNt+9cu35QGF783+OJEbGCcvP4/WN7c5CFcxOWcTm6B78nzFayiRZSwWiZ2M0JFEnU6h1iU1zwknhPr1AAm8mRIJVl3UxdTzPoFGq7RUwDqqhm5cThecVlR6VCBXKzWKpEFFkA3SP7o7omh4HL8xks3Ly+Dy4eV2QpzaZGumq47pgVxLpKf3zaxDX0pAfu5KZXCojzNBZMOW6er0pRfMDSzuIYYKJ//9oTry4evWyvtPk3OxRuVERVdi8DvkuEMcX/l2qp6SVVZTYZepT4n2+I83nfJjY1yUYNCGDDPKdMg93ZxjciHVjMFQby4liMmZNOBE7dv/PyYiYo9Ul31xN255iv0RZs1IQ/9corPpMi61hrJuivReY2Hb/5BlE61rC9dnASvTk2OR9jP9rxWP/5YnIATZ2JP9uEvEat4mZyo9CwLvoOMxT68tLX/Nu9XevyUbPG4u2E6vo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(366016)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JgvX+6MtIPtSwC8KXeHVD5t6zUc1x55QYPbcabv7t4cm3Rm6GumzKd/X81CS?=
 =?us-ascii?Q?nXTHQ98a118+cmbUhlaIICZrQEi6Omq2y7yrOTvkXbZ1+I6KQe+muZ2/Y6NC?=
 =?us-ascii?Q?jwamt4XZBsXjNlfP5oGRQnlgyNNb59qdQOMF7PSeSVrqZl0OSHYOarJBkxI+?=
 =?us-ascii?Q?6mvu7I8ncRYKBeqBvw4HVtKwOQK1aNzKTXyGw2p36+dtRzPr7lp1pt07Zuf9?=
 =?us-ascii?Q?3GnJEn8e/JICpfo/TIt1ZOySLxAAmxLxbs5L8bJdX684VmhAQ+g7SvvFB/TC?=
 =?us-ascii?Q?QRE773/0KGo8IcvQfaogbAWKTGpcZBr6NoP0BYXgRHpaF7UX7u+DlOKT6o/t?=
 =?us-ascii?Q?KmQmd2sSKXy3Ga3eLkRfxxfSwf0BMMQhZ6DJeQLxK0G4WI8oA73RN9BgUs48?=
 =?us-ascii?Q?85FqWUPp6VWUxC+Rm1x1NVSpq5lTVeCOEuGP9BNovwvFCr2Lfpu81fKNyJP0?=
 =?us-ascii?Q?pkXGl8iFmeomCe1Y4iRzYtP9rzQ9Jt5gC3rxdIwRhQeQZbhWYSlnYsrLykNa?=
 =?us-ascii?Q?vzUQ8Ye4gV4kw7ISu2yyDhgzCoq5OXWNnmdeB3OgvPKL8eWVDRtgg+ey3d80?=
 =?us-ascii?Q?jWjCer21fdC1P39Abh/qqXIV1WmrGJMiIdJLDG1rJyLdvTNCrqIPRe/MZFqE?=
 =?us-ascii?Q?39o9Pd93vfrQN4SO9FVfgqjFdW7K0T//RZmlAM4iO4cRPO/XZiWH4wjZg28/?=
 =?us-ascii?Q?U0N8b28gGA4aqIVqnJc1K2W/Nd35NC9SbOfE0k04O2ZAs7wxTj7O9gLi84sV?=
 =?us-ascii?Q?lZv8NrXGcTd9/sBNWN1LLedSIfTu2AKlKaDwB/6AtwlXAGOqugUc2nrYY4va?=
 =?us-ascii?Q?ZSWHD6yLKICybTmzkFk4s1BgsrWEUCDk2GnBB8WpZRbwGW/VB8MGPWIuLZJq?=
 =?us-ascii?Q?rrBwNVAaLVwWmXjeBOCdBz+PEpa0kiWnK67zRI7LGWGixMnSN44s+tLjPDPR?=
 =?us-ascii?Q?3RBLaiFTmn/sV35gtmqAB5l/nmMYV5zb3jE3+Jwn85OQ9iAO6+B6aYFCkzb5?=
 =?us-ascii?Q?LqhNCxh1NJMPOIXMgRKPr8wT4xg5a1xzmaQxRFr9vQyb7f42BByF2TqOTXh4?=
 =?us-ascii?Q?uP93+LFIcznKUisKZT5BG+4ZseLTqVkqmy7TINTZW9AhHOW/uRMolL9m0SI+?=
 =?us-ascii?Q?YYOY67YTnMYEI8Yj//OJ6VEPiorASbEwobDiJVNsUrGGhSKo8ID38ntksWkR?=
 =?us-ascii?Q?/8rngnba+OM/wwX3sGsyjDY7Qgg+fPwerm06Qs3a/gT8qQ9AYjOleissFHPD?=
 =?us-ascii?Q?u+APIkFKPj2CnHRX4FK6xeOiO1lK/u1E7/QgLItA5KTVgqNotj9zUyU8kyAQ?=
 =?us-ascii?Q?MSzYYZIjsUHw99VJGEPvBWCL+nQ5eaqcJOc6X3723Jl6u9vntN25GQpDFPmJ?=
 =?us-ascii?Q?mJbPXXUjeXLwBYpjk11M8wuq7qvtitzB+HWz+f8mpf7EAS121GKdIj8YpOo9?=
 =?us-ascii?Q?WtuvqlYgbJhCkxd2BShgK4TS2bt5i8Itmgd/ERPC5DMlSdwvVebz1iXkSa5Z?=
 =?us-ascii?Q?bgVKOBN3EqzPZU/aVqCKq6NFBjDV7PWNsHE8+ETV9i8KccLL8VXxYt55skUk?=
 =?us-ascii?Q?81GxTppNIUq9syHBeMZ3oZQ6s4OwaTOg5yvhIaAy6C0GWGLq9W77AR7wp0bS?=
 =?us-ascii?Q?vRF9PSyHpI7El0mBt4oSnvNTzbKDur6ozORowXUKyTgERkFo9WwJsmZCtuuh?=
 =?us-ascii?Q?1WeY46jbOgBqBM3XHQgWDRrPzqo0xDyhcS3G88nKCrXT2LaHjyhXuUOE0syX?=
 =?us-ascii?Q?hLNA+/Hf1vXwe1HT/u8Uhm8gSGWuRK0i3erzcd7fntQZQY2215Pw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ba278d-47bb-448e-685c-08dede5b6762
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:29.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUpmPwFBEoe2OwCKWU7NcXoaS3cNPxv4raW+kMjUlbwNaEzdDK/iDQ5tKETjwscv4rxyJnO8Uzu7DYxSF5YmSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12280-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22256738581

Add a match-data flag for devices whose DMA register block starts at an
offset inside the mapped BAR. Existing Synopsys EDDA and AMD (Xilinx)
MDB/CPM6 matches keep using the BAR mapping base directly.

The offsets handled here come from static, trusted match data. Later
metadata-derived offsets are validated when the endpoint DMA metadata
path parses them at that trust boundary.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
The offsets come from static match data and need no bounds check
here; metadata-derived offsets arriving with the part 3 discovery
patch are validated against the mapped BAR size at that trust
boundary.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 36b18032c835..a19282c15644 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -89,6 +89,7 @@ struct dw_edma_pcie_match_data {
 };
 
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
+#define DW_EDMA_PCIE_F_REG_OFFSET	BIT(1)
 
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
@@ -464,6 +465,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
 	if (!chip->reg_base)
 		return -ENOMEM;
+	if (match->flags & DW_EDMA_PCIE_F_REG_OFFSET)
+		chip->reg_base += dma_data->rg.off;
 
 	for (i = 0; i < chip->ll_wr_cnt && !dma_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
-- 
2.51.0


