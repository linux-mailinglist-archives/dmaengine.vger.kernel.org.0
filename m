Return-Path: <dmaengine+bounces-10600-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LAhHN2mDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10600-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:31:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58A59F6E2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 686E230234D6
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB68395AD3;
	Thu, 21 May 2026 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DkzXq0r4"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8A395AC4;
	Thu, 21 May 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345090; cv=fail; b=FBDz+dkuH6eIN8HsR6V3GbpK9FG6a+ODoabgNls9bu4i1dv3ZwqL7QkyK3mw1gZmpTqVTQIqPTu6aeVdrfH0FPUwC5Oll7syO/vBpE8BCZjFbiJ85+v6idFuvXmhhVznBE5PpvNVkKELKPCnuPm4bQ5iFnv4gjW/t2aHVR935Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345090; c=relaxed/simple;
	bh=oQKoF8pcBs6UMqe0kjGpXg2Jhh03OYYxTcPO037rH2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YaXMldp58f2LUPHw35KDAymGHDI+9N0n4GK66HG/cgoXL5TeGiuAVQKd/8sglhhXM65HWAQR20GrCGhY54w25sQGMKh/WqLRfQo/9SF5oAuCJwrp5EUpQDdtiPDQ2Dsh+awiHoVabb8+hCSLtD5EqsntnH5c5wk/a6PpcYHq+Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DkzXq0r4; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM5Xy1Oh2vUOXatLVX5kR934PBLXBPPcfUICBu7G2tNOjbNbtNmPOJw4oRbpQ3Roz72gFWPQ5+c91d3DPtkLSgQTSF2/tsF9bsuyC2ellD6IYw8AyXcEP9esLMFtR1EiDP0YqYKvRhi5njaSlxDCxHSaFydCYybkNuIEdSLvxq55+/aPVUBXw5gK++hLodyQtXAyuZknANXSf3pPgSdCXVc5+SDC3vMJA7SqWJyJWMmyMk1DgL1l0G9rspOHdbseP1oDUhLzaMNuFTHNQk3pzENWorgR5AUCfPPHtiWV8N0wWleJ0ddxxmrcle/SxqSAbB/u3c+ioLgv5J7JCf1DXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV1DF1f+79Yg7dRiMvu18CdfpT2a/bRjmDzPRNJ9hoI=;
 b=a0NJXrq6DbNKj+a5vaxsOsG3AhmjL6r9+CRB2mtlJgXC1OYQaPX//n3qyBIAk20tx1jWjNSIVFYSu4OZHgme+5BsNQ7chj+297U7VM+6dnNRchwJONtoG3kQHcKjoQMBMy0WxmOIHvxCuwcNOE83d2MvuI/6/+vQJtcrcg09ZvOoNMnNeZhKprRzEhqPrGu5RyNjHrkBC+HPm6yxiZ9QegVy8RBrowTrYYAXyLwfBIdYkQERxLOkhAhEVImdKw1uQsnZvwmaAOQsthF1oZhMaRhh48tgIpmJRdGTHsKLtXaeUfuhoqhQyUknzMbq+DV1QhdmEbxBc7kYwwqDVA5G5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV1DF1f+79Yg7dRiMvu18CdfpT2a/bRjmDzPRNJ9hoI=;
 b=DkzXq0r4ZsWkp5C2dl2dm1HUAsMh8qBi0OGuvLk6w9wNrnS5Gjfd3Xner5wa1uA+0rH5wjNFBjRmNFsOKdTLW53bKBdrfEEKS7RIAPK2Oh8Y5QHIgsjVtnWggSHbhZeOX2qVqSQlVQB+Q0TR6pT3ApoXo3Wwhb/H4d8dY1OPWM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7818.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:31:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] dmaengine: dw-edma-pcie: Add capability match data
Date: Thu, 21 May 2026 15:31:08 +0900
Message-ID: <20260521063115.2842238-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 07052e59-23e5-44ae-2693-08deb7029422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	54xxfudDeza31eFTtTw7ByU4mIQ6tG+zNncOsS5m0ZLguVLuDdZE5TnHRPzeK/0am5B7v7Ujqki6irgHdWtO1eoUXOeGL7yV3P23dgQnx0bxrsxnAfQb+qAX150Cs39rKuFabJUUXsUVP/p3pe1pF1PGomfFBdL35ZAkfsVpKheUyI8f1rsUkQHY/rjWHNVT11UxKwqJYKaDI6gKXJQxSaZusdWFIovPunMbYEHcIvKQX5nx0G/eE/1WmSjQC6S6W+ADH00dCdz21ir2BDmiSTCalc4Es0T9pQEXzPTsRk+D0Phyz7JtvAwyX0QfolhzmxoMd3F4UAV1MCfA+YJcS0EniKV+xhjN1GVwPuVdZ1H7rLbL7n/MrIx3yWqXNww9INooN87pUK8DRVtBvzEunT+fYlc56F1WiRkap8sBrBVR4S+paYHMcCC5PEySZwPbg0CCyxSMnnaT2x6vE8apz1xZFHgOvOSRF5N2Cn6zAuk45ZBjZC1NFKLeRP1kFhw9BeU27KC761XNDSJCBvm0zBMVMnyD4Z6xnrxbWU9LF7asjGumqDZlaqinWIHe74TJeZt3u6TUL3GuIK7DY0oG1AkG/h2ua3PTUIB3tGEfWvNGjRP65LLW1Za1WvB/I1V/y1bzksE2mnP5mebDlJZQOgVnVs1Cyu6XQGmkzx+L17c0ICD6C1sW1sYPo7iTvv1L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UH3V2p9m1EIGDLFPYL8y0nMeO3okQi/HYMkUqZWvKJWrI1Aa3MJJivY43nTJ?=
 =?us-ascii?Q?9xs6pBKfnYoxbk75DW+okvXi7Cl+whHkgHyXKU/TqNl7MqVtL1zbGzNwxqaN?=
 =?us-ascii?Q?/nH0YzXXQcbVgzzntGNOoCflxqcIFqcouyGKNXq11ycNOEingHBGk3ASiasY?=
 =?us-ascii?Q?mSRoBBcfgv2K4gicRsDhpsZyb08ITtRQGdcziWhzmC6veFOwXGu9kAj50NUB?=
 =?us-ascii?Q?r6x9keo3S9r82NI1pyBwilW139tekAu02FiRuidZCp3AWhBGKC4oSAoWsjPZ?=
 =?us-ascii?Q?L9WB70iwmPRCd2zxvc+w+8rppS9jgqq18pqaRIILNthjYus95gJY4h7JQ/nR?=
 =?us-ascii?Q?DFqVdey7Ec7IFezjLEzeEwAfIRLZWwsas3tGTT1rnSdSX5IEffnd+Bbi5slu?=
 =?us-ascii?Q?kCIAc0/MGYHkDxdd+9qH+Orf3Q/3fjCs//7N3T+fJ0J2u8q3UJiVVraDiUQ0?=
 =?us-ascii?Q?3Rd8s7yAXwW45/cqA7Q7ZWY3ivCVQSQYCo9DHtCGGm3VDL6sGENZ+3SRJ8Dl?=
 =?us-ascii?Q?Al+QCBSmnpuYLqq4NxWIck3JmJGP71jOrhnsn0AZRZnxrUwnQusax4dazznD?=
 =?us-ascii?Q?zLM3fS8n9TI9SrGu95xy5Y7ouxTibq2MZKizbBhyeRfyjNjt/fWBzUzqi3xj?=
 =?us-ascii?Q?gVBS7iqV5ZBYDoiC5xDJ/EuqyEfECXKuofYVAYg5Yo5uoDoILsbbgMGhBYvD?=
 =?us-ascii?Q?GNHS2arJwNFnL64PoaifZdtWeY4S8eM35YVzBw2aVBu206aiRij0b4pmGqUA?=
 =?us-ascii?Q?Az9ZHwbgWxfw3ZyYLGUR1l/p1AWcSNQjU29mynhFyKqvFGDpG1ffDNG41D+P?=
 =?us-ascii?Q?n8wYiYBg8cPuElqlzR4Tgu6I3ie7G/6SnfXLked0nDixE8z+wFHBGVOAsPUO?=
 =?us-ascii?Q?mo7AWPrw1nybCWhDW6eA0G3fLQ14csMKJ7SkcMl2gugSZs/Wl961ixRpSMC4?=
 =?us-ascii?Q?s40Ak4Wi9qJ9liXc7q3VQdd+VbWDsw9tVyHOQnO5N6yqM0XHVbNrPAZT5qCh?=
 =?us-ascii?Q?71ftoGBbANM/Wx4GqV9guRoIVO29MlqhWX7Nd80FYrSYKPLkmiJtygprPLMO?=
 =?us-ascii?Q?dDeZmok//bdPg8/sdhbZBxWPXL6sTnoEr7Rre2VQBWyVJdDvuJ3p807Upohz?=
 =?us-ascii?Q?+dRteiPO7heIzNLQ8dT1dju05yexLFG1mSwzZVoPZfLNmzXfRLJ+BCs9+wOx?=
 =?us-ascii?Q?RpI8bt4qvQ0yeOeYMRB/nHC4zScWfohZhqHMm/g3bL2GBMBBOV4MD+vtPOMP?=
 =?us-ascii?Q?VwWNBLmDzcjv5foplA6KwPZBdg17ncVGvvAN2EuvRlxGYjJbSRhDP+Eu4cE2?=
 =?us-ascii?Q?ZuF+4B7ESi/wrBcbjP+jDKtmes/crdjK+cbtkUThO8INZnFVCUt5wvb91Sn5?=
 =?us-ascii?Q?hktul8UgZ/GaBOD/FyvLXeYJYABvOFARfjAEaeCpMyavBtRV5hejRSAO55j/?=
 =?us-ascii?Q?v5OL8w673MIz74Uy+80sBrfgQEbrSrGFI73bu4s+EWFwey2p3YiHkcuNZYK/?=
 =?us-ascii?Q?yLNp1gNddafSGUE3E2UAc4xwhQsy5WKNPt5pn6QluOmRPWSONZShPnSnli56?=
 =?us-ascii?Q?fLQ5YXAndAsZ+Rl7dMXKwjLVbtAdIce0G4nZT5cEomsZ8lAC/WletFzZ49gB?=
 =?us-ascii?Q?RQjnslAzCPBfkHQ3CZDO/+YiqrHTzw01KgJMT6b2X6I1C7t6cwnqBAz2m9wL?=
 =?us-ascii?Q?ZrY+5N2Wk5n6ycRv3F153VJjbH3Macq6OWrayIDVInG9b7rWJM9JTg0Pz/rc?=
 =?us-ascii?Q?yzNZ7KknPauGRo3HXZgLNEA13Tg81inEkvcKEDvGqFrTYrFa2T4H?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 07052e59-23e5-44ae-2693-08deb7029422
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:23.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cd8ebliPC51ymyNYuRgUH0QGiGH5GzBk1kU3mxTvoiF66DKogxmL0+w6nStJDOw+vj7OQWmwRVp3M8KYOvVNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10600-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 5C58A59F6E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move device-specific capability parsing behind per-device match data.

The existing probe path mixes two decisions: which static template a PCI
ID uses, and which device-specific capability parser adjusts that
template. Split those decisions so device-specific discovery can be
added through match data instead of adding more vendor checks to
dw_edma_pcie_probe().

No functional change is intended for the existing Synopsys EDDA and
AMD/Xilinx MDB matches. They still copy the same static template data and
run the same capability parsing logic before BAR mapping. The MDB entry
also keeps using endpoint memory physical addresses for descriptor
windows through a new match-data flag.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 127 +++++++++++++++++++----------
 1 file changed, 85 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 0b30ce138503..043a7f73bf79 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -74,6 +74,19 @@ struct dw_edma_pcie_data {
 	u64				devmem_phys_off;
 };
 
+struct dw_edma_pcie_match_data {
+	const struct dw_edma_pcie_data *data;
+	/*
+	 * Mandatory callback. It may leave @pdata unchanged when the static
+	 * template already describes the device.
+	 */
+	int (*parse_caps)(struct pci_dev *pdev,
+			  struct dw_edma_pcie_data *pdata, bool *non_ll);
+	unsigned long flags;
+};
+
+#define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
+
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
 	.rg.bar				= BAR_0,
@@ -295,19 +308,61 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static int
+dw_edma_pcie_parse_synopsys_caps(struct pci_dev *pdev,
+				 struct dw_edma_pcie_data *pdata, bool *non_ll)
+{
+	dw_edma_pcie_get_synopsys_dma_data(pdev, pdata);
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
+			       struct dw_edma_pcie_data *pdata, bool *non_ll)
+{
+	dw_edma_pcie_get_xilinx_dma_data(pdev, pdata);
+
+	/*
+	 * There is no valid address found for the LL memory space on the
+	 * device side. In the absence of LL base address use the non-LL mode or
+	 * simple mode supported by the HDMA IP.
+	 */
+	if (pdata->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR) {
+		*non_ll = true;
+		return 0;
+	}
+
+	/*
+	 * Configure the channel LL and data blocks if number of channels
+	 * enabled in VSEC capability are more than the channels configured in
+	 * xilinx_mdb_data.
+	 */
+	dw_edma_set_chan_region_offset(pdata, BAR_2, 0,
+				       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
+				       DW_PCIE_XILINX_MDB_LL_SIZE,
+				       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
+				       DW_PCIE_XILINX_MDB_DT_SIZE);
+
+	return 0;
+}
+
 static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
+				 const struct dw_edma_pcie_match_data *match,
 				 struct dw_edma_pcie_data *pdata,
 				 enum pci_barno bar)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
+	if (match->flags & DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF)
 		return pdata->devmem_phys_off;
+
 	return pci_bus_address(pdev, bar);
 }
 
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
-	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
+	const struct dw_edma_pcie_match_data *match = (void *)pid->driver_data;
+	const struct dw_edma_pcie_data *pdata = match->data;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
@@ -328,36 +383,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
 
-	/*
-	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
-	 * for the DMA, if one exists, then reconfigures it.
-	 */
-	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
-
-	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
-		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
-
-		/*
-		 * There is no valid address found for the LL memory
-		 * space on the device side. In the absence of LL base
-		 * address use the non-LL mode or simple mode supported by
-		 * the HDMA IP.
-		 */
-		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
-			non_ll = true;
-
-		/*
-		 * Configure the channel LL and data blocks if number of
-		 * channels enabled in VSEC capability are more than the
-		 * channels configured in xilinx_mdb_data.
-		 */
-		if (!non_ll)
-			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_LL_SIZE,
-						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_DT_SIZE);
-	}
+	/* Let device-specific discovery override the static template data. */
+	if (!match->parse_caps)
+		return -EINVAL;
+
+	err = match->parse_caps(pdev, vsec_data, &non_ll);
+	if (err)
+		return err;
 
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
@@ -424,8 +456,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -434,8 +466,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -451,8 +483,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -461,8 +493,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -543,10 +575,21 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+static const struct dw_edma_pcie_match_data snps_edda_match_data = {
+	.data = &snps_edda_data,
+	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
+};
+
+static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
+	.data = &xilinx_mdb_data,
+	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
+	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
+};
+
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
-	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_match_data) },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
-	  (kernel_ulong_t)&xilinx_mdb_data },
+	  (kernel_ulong_t)&xilinx_mdb_match_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.51.0


