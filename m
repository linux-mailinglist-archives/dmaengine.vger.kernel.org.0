Return-Path: <dmaengine+bounces-11658-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kZSjG7bHNmokEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11658-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E26A9478
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=EGmwya4z;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11658-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11658-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 038C83028C43
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40CC18A92F;
	Sat, 20 Jun 2026 17:01:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB94275870;
	Sat, 20 Jun 2026 17:01:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974877; cv=fail; b=qNNwI5qESWeYLwfliVbUFQ0UrrgGAeC/N+vCoGEZKdtb6g6olaBY3HDbqKc4+0sweMfGWlexM5Om54R6clLOxNR+6IGdAHCRzhW+ETVjqD4pHZYOIV6CkGHBubilyGk/9w8xkbrhwEN3XP7XAMnpa3i9mNnbW6KSY2+h2x02IQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974877; c=relaxed/simple;
	bh=NZevPZeIaWC1NRGWpybk8Sn7wofyvKcwZX9Zf8XXF5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TiEXJbvCKKE+tkB0ymCmzJB97q26inFiCHyMznPLSn66BXCG/Jhe8BgSCWKz3oy+pIBt++IHBvP99VqJ3efrJsqDhxxKx5cj+mhTuF/MLWmYjCBH9cCaFQuaFxnQikcb0LFOR8mXN9p9Booqr6okCRekgURIkMcDPKS1k5oa5Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EGmwya4z; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL86ZTONp6WzrfsrpOg4tUnQu1q+hoo2Y6Jzxr6D9zp5RC6qD6htOg6yJoDwLk4GMsfu5spjblw5rxaSR1GECaok6Od1ofoYZXPJsZ0c9psKw5ptI3SF+e5hBW0nIgGVwYgnNNNvS7y9VjemLLAYZ1qEWb1Q37ebEql/nLbdFlVbUaJxJM0Lq6YRieyZG0Lgmcq+RmljOy3Du20lxmkJVxzM5sDjPPZCkGngz2u3JCq0KwJ7Kl1VbP2Qz4Qw1pH75wg5mmiMtxGkgWFs3GFSIALfas0xciEtdTpiqr5SIaiHM+tJOxUZBAYeTzXJC8vV/kXX1P3ZiZh1FobhRc5m2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo36mrSPizBo/V5/9XhiIn5ciAg15JfKiaSYKRFRE8A=;
 b=TuwsrxqXehh1cgpiEkL5XDBvxfYIFIh9rT3G736yzlAG/6O9X6aO+vUPk+nEG9ZSq+QEbPO0bk/XbFfC166n3fU5ip3tfeZX4b0c13niM7sIhrm8iKwJvhQK7Qbnw1p5uzdi8i9TKOgQplKQ0H6LRagrzzRCUWH9K1/KnwAcumxi1y2nAF/+YErWdetJU0c2M9W7redCcz5nqGb18wnI9JncFws3Ei54FbFQk/eyuAPfxRmbedLNMf2KCvZFFpgt7mlPG1LtZOoVQKNYnxqyQ2f2ni52c8++u+anp2TOlKfQkSqeMG0vEvNtWYZwbiDmXrdZlwqpck7LsPWNKgmAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo36mrSPizBo/V5/9XhiIn5ciAg15JfKiaSYKRFRE8A=;
 b=EGmwya4zDq4JwS1gPm6hd5kgtsmo3uq/cHhe0r3GaWoOtomXQkQnBIVjJxN27mh4dVC44W5avl5t36SVhJnpxha6OExh0WmK1RaUxxSjQBhBFypn/l7rWubviqqUqdrpBjOknZ0WtDhrBRFc/7Vlew7mnBOjUypuWrZImjMYKxY=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:01:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:01:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] dmaengine: dw-edma-pcie: Add register offset match flag
Date: Sun, 21 Jun 2026 02:00:37 +0900
Message-ID: <20260620170040.3756043-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0152.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a0a671-116f-4da6-3942-08deceed81b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mFtLFiB70+9/Vs/Dx/8g9lGGag0C7WMWV3xRSSLJKlayiFBH+lqgx6QgQ6JITjjeTopo04SPYe40/lZYCB30oiSns0iME3g9rJ/D8jBvouybymqs5vfUJMaCuBaf+V7Gy5UV6qjVLPn+VCGexBEyKQ8CL0PoBZ+EXnRCsPA8ftOI/TMTFUPQoidO3+Z5FaDuH5gTOFGmORnlLd7RIuXkQRxhbd5OL8FhRla+DweuHJFl/wMTdmB4Mz+oa4a1w54OG445QqDYyQcU9oKtUZT9dcRkm3KIw3YeXeVFuRp18RqvllGznPlVlTeHehiUeVq5FiJpa8WisI1vtxVJFc+U5gH8ns2HZSGpXKD1cTYTU5MzY5gfCSoxbk28YuECbxhaiXXEHFzYWZjxCFIbLkXPq262Q3meViM5PLjk8Kq1Xegj4SUzRs1YTfamaPx+pnpHDZeh/dvq2Z4zj9gvdT6ziQ0s7rri8XRHjLG2EY0n28lz7ZeUWXHatKyg2vYYDO2mr0EcP0DKuOVofyC45HmPNE0TZnOGvWlfCLhE9yuCOkmpYKzP5JXdWWWS1XSGd7wgt/gbsu8pz8NFVd/v7WvHAzYAgh33mhyyLfTvPW5ec3HBlWEgYA0pLHC93OespsVlxyt1zKzmBVH/KQzLNwOKcxTP5GscyWnTNAOybqY4iCw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5Qesx+3NAoAXnYGLJxyG99OJYTO691CjXWFoYGJ9a/yEv0YzAPMBXV2IjRj?=
 =?us-ascii?Q?YEqYfovSqVhLNw15+XwBRY6aZk7fDIcq0uP56YF1OZVKc2SUEkiSTqDCOsgP?=
 =?us-ascii?Q?RCZcobd+D4c3ZMR3l8fnQblmsITwCpfkZMtqfWjgmxNJaOAZhAJ0LAO3PoSV?=
 =?us-ascii?Q?+k7Z5d/Wm8HLzObpNdW8f4rSKnPjTmdO98E9nzVwWJmN8m6DeRb4B8aaOocj?=
 =?us-ascii?Q?dDpFIWi4ItUcQJG05gRXPnyZ3w7IOrn7XHU3bp47esHBKdUQ/9m3pmZBWoP0?=
 =?us-ascii?Q?LotXcB5BPvRNHtKXZPrU6mS/la1fxOA0jPOdnQuYI+N/iiFidsWcgtVU+Cus?=
 =?us-ascii?Q?usrOOpiyrBgm8Q8Q+FZGzQsKOOlG8DYf0+ZVr+2OnhecuStJI3BTkQ6fNVTx?=
 =?us-ascii?Q?7Pe3NhPRSIpgpf5bAQeAUHL7DIH1QMIWhqI7e7gihX0CGE5ofiXaLBKN/bE3?=
 =?us-ascii?Q?zye9qfJLcAi+iP2hLdGBk9ivOiVPupTWwON4MkDosUVHz+it/j/TxLLFZq8w?=
 =?us-ascii?Q?R8kgBQETHyEs7++T12XjvgsF9h2Kv0XkDcE8rt1Soag5CiMl3PuyMLu9CLAf?=
 =?us-ascii?Q?zJ6IX+VMwWZOlUChzsVd8Aa/KIWMTb6kKLYKKKm0K5+gqsdaiT/TX1APu9KO?=
 =?us-ascii?Q?/lwyUIqWi4mSZoOnmB3r+IPDqdPy6q1dZv0aAA7eW9LhYxsEruLDyZg4lX+s?=
 =?us-ascii?Q?hbYxLYa8Q3m9UhkoP7cWRy9887xIzAWwwjMjHkOTTje8NGiNFzvRxY9ZvEMD?=
 =?us-ascii?Q?BiKusluSrzOsF70qAS2zrVNVA9outBhEIbKnDOClWnm4OuPG77LsP1BNvVbH?=
 =?us-ascii?Q?0v7cgDYjFHaQDstSYx0tOjcX896ZBIehAP/TJHIlw7dHFbDJpVvmrowj8Wyw?=
 =?us-ascii?Q?MQCFAaPz5OKUJI4T20m8dcJivc4dfvE09Kghc0IUqCkGLmEi4AOAHSx3Axzl?=
 =?us-ascii?Q?ZlR/IJo5OWmQq0C1/GN2A+fVstMdyo9iitQa2rEWEYBbfqrV3RV8yKl4yByk?=
 =?us-ascii?Q?QQAahGybCFAV0NNzOkOuRt1pZk841Y7RVUrIvHOZg34vY+Bzsz+mr62gZ9CS?=
 =?us-ascii?Q?mOaW48VQ8vPc21BwVYXIKxhPrA6p0NvPQCQ6ShGDu1z3rFgy8Bur4FA28heX?=
 =?us-ascii?Q?Ao12YCOLT1lNfBrdSpyxlKb7qa79qJi8K+QmtxVw+OSYMc5PIJSrNGbJOTkc?=
 =?us-ascii?Q?bBT8X7Neck83HqDz11XAt+jux+lLHioVzA4pTloTYDMKlV1+Zy9miyLjAjWO?=
 =?us-ascii?Q?WB6mMDO70lxJ0KyenkIfWzNYtJu9xFpbeWye3G/83k8hRLzM3B3HEo9SPyyu?=
 =?us-ascii?Q?3f6I7nUt1cQDuMRONXbQaYzDlmDoJj8oA8QIvYwHK5Yluc+5w0+57qFyoR+o?=
 =?us-ascii?Q?r3yWF1/sYqluEmIikx3/ymFAqkHw8H9fNLUXF5l76w5njtb16k2LvJ9WDCUd?=
 =?us-ascii?Q?Osr8gBN99D6eeMEiPZj/vkNTE2vKwyzHCPG4h8ddmdzXGOi9ax0uUR4Rs+W5?=
 =?us-ascii?Q?rkFMdmS2lKK2k5B2JNeVBw9cMUrn+UXEAludoDXjQyjGTYCz+jSzfL4RKZ5S?=
 =?us-ascii?Q?aGJ2XxulhBCptKB82mtl2khkjJjqjDaDEpkXrhcQecqI8ToS7iqcaiBvg7tH?=
 =?us-ascii?Q?kujG3Bt6F/NKqa+GzDkKArYwsyUTgu0bL5J/pkBLqhLw2hi4CYjA65qwU/1l?=
 =?us-ascii?Q?mQE5mSXJ19AIiJgZAo2ZVwCItxq8ED/b2QJob+hs5Peb7oy69+/C1YXOVCAX?=
 =?us-ascii?Q?O3zhZIrVnwnZWiFgUJW5P1JbcN4cDxoSOhfCRPTy1YQJvY1gyhlk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a0a671-116f-4da6-3942-08deceed81b8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:01:01.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfyHwMLGujK+vtEq4C+pCf35sQidZV5Sh1SanRbtenlND403223h9y5dSYSeM6bdPclrfzPqX7XQNWI3TqO5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11658-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 169E26A9478

Add a match-data flag for devices whose DMA register block starts at an
offset inside the mapped BAR. Existing Synopsys EDDA and AMD (Xilinx)
MDB/CPM6 matches keep using the BAR mapping base directly.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Update commit message to describe the AMD (Xilinx) CPM6 match
    present in the new base.

 drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 96038aaca079..caf7c05b0631 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -89,6 +89,7 @@ struct dw_edma_pcie_match_data {
 };
 
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
+#define DW_EDMA_PCIE_F_REG_OFFSET	BIT(1)
 
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
@@ -465,6 +466,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
 	if (!chip->reg_base)
 		return -ENOMEM;
+	if (match->flags & DW_EDMA_PCIE_F_REG_OFFSET)
+		chip->reg_base += dma_data->rg.off;
 
 	for (i = 0; i < chip->ll_wr_cnt && !dma_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
-- 
2.51.0


