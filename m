Return-Path: <dmaengine+bounces-12288-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WYckLgyrUGqa3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12288-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:19:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B687A7385EA
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:19:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=ufVKQQ+Z;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12288-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12288-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEDA43010DF9
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E13F1AC9;
	Fri, 10 Jul 2026 08:15:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FF3F0AB8;
	Fri, 10 Jul 2026 08:15:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671340; cv=fail; b=gRkH//KwMOVfp5QTlJr/AhJnj98rLvbqTLisG9gcImOCBi4FbQbQZTzYKfiHxJWjxv4s+ah2ZdwMkI2kpqhNXxojKXVbRs+rFubcEtOiHysoF/oSGZ+9zBy7vcHGqq8QKR+eL22BqT0lYepBUVzupDqBgSQAzPc+gW20TRSLk/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671340; c=relaxed/simple;
	bh=rOlcjd4e7eQ8VmI6GEBprr4bALLHQ6wLyeVAW/lGWR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u19G5cA0LIVXAFI2PJPaAD5VOstB8fbz7bzN+iDCTsBF3rElt99f+4KaQJVxrsGyO/3d9vwDdbsRhp5mD2JEyDv7kEmUSlbPK3hqT091cmY3DYfTjumHj+KvxZgi2scMYebcY43x71Ri7o1ZdzESWLClU8R3p+BoQY3IgyTzzSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ufVKQQ+Z; arc=fail smtp.client-ip=52.101.229.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMJpN11xJde1OVoj7QepFoMPdBqfNcw1SWRzgRJv1Fx4Tjsejnsyc3aHqBmYqzFSFOVhfPZC/84ebhJKKUABG5ijgdodDkgO+XB6NGnWeUTbVG87QkI1cUNAp5Xh6RgCyL2eg4wgEjyW92RpcDaRVh5Vy84Zc6mVFkxVXnNbUkWMSYuZA25nEhyy0AQG/9vg8KaaMo8Vowesw4e3UKcOO3ZP28J4Bpb0xY8lwHQz4aQ8en3NyFZnbCoINWDmmLyuXLfKlk/9NhRNl1ORDcQPEPYDGToIxNp5bmSH1mb3FGIJjD2dmya3/qEFDX5q7dLbKXoB8c1xoZs0UmlQgbmuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8rZz6JhYSvJ9wICLgDuiHg5Vtn54stL4s0WHFfg8S8=;
 b=tEfJbmbKup355yCK3Kd45oUD7IIpi+RLkof7Q6WR4mwMI54jvvEF9mN8q28JkpkU5QfpxB8boffAefI7J1DvpUCkbloPCEY66tLOhansv1Lm8UjDQBe6dQWAtr8rPoy03VfAbYI6H9qAJv/1Qm19N/Ivf5vGp6wEnY/fHtqXAACg/i40Z9nyAJLL//Stcfcp0PSshcOHrSHa9kjKcvk/c++VY0TkO5fm9s9wYtS17bJWXG0mQlBEQ6eZ6WWHbcmkGWL71PnzZR3mRr2OTtGkepOnNdYsI/4EwQ6ViV3wFwH3K3i8tFZYI4q1PTMLZ3U3DiIzAz6kxNkv5sS7Fw7kEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8rZz6JhYSvJ9wICLgDuiHg5Vtn54stL4s0WHFfg8S8=;
 b=ufVKQQ+Z4IM7Pda5/6FVG63+XHNCT2wt8yDDWSxArh9WjNKJ9EoCN6dorqhdbnz3GZ0l0Bfc59JJn3E6vCNJ3mMa6qT46m0e7wvcoZy9cswDk0Soxr9YJ4Qri4VGKPAKC6oZDrooVQWLcrh4dkvE+eIXD/9ilTZJzQvUSqfEQSE=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/14] dmaengine: dw-edma-pcie: Track non-LL mode in DMA data
Date: Fri, 10 Jul 2026 17:15:10 +0900
Message-ID: <20260710081518.2394357-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0112.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: bae9e22a-bccb-430d-a267-08dede5b6536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	b1F02ABg2Z+8+A9jHR8YrVfGeQG1RPK+8Odz5oJYUofy0DJh0e6FPiguwxBqqsTFrQiwtr+y4kFbij0NwO44JR4WmZDiCOzi3hRbnkZSnsdhPUMIzeaFXZuhmegZ73oFuhJCurX/P5Hz1hNfhd8XwQgd6YwGfn3AbdTArFEiiTzz8jEMBhRcLXKZo+jQfsqXofI+ZrQzjyXB0gEJUooLwf4rX0mXSmc0SnSDh55lT5kaG9okwX6xzpFoGXiVyMP/ajbD55SZ7ouX1MB6u/bbEG4SXCP7Pi29C31t2lywWZeaGNSQZGFl86tzvdC9NL0U4RnS1QiUPSMsxYGmxakCmkG1S/isWIXiA+7ncSZIKj1NapD0sQwqYSnfancSaZm6zrkcHsHPRbvE2kMYozzcQKH9KxsSt76RhWlB2TZ9P4/ZZO1CaFZYTKz6KwKYXCv0SN8oQ4NIeUfCQGxFO0l5ZsNYXLgUWxPlzCFI0Ka46+rjnBpJm8ShdStahSJdSVqzIDZCMSS41rRhGjPZ9j3KIIRSi5uiDtB2RChs6jGHHhdexWNFh7L5zj71EfY9PldekYkiHjg9A2l2sWSzuCtn/oTNK58z8bipeXED/rbAjLc3sU0hByo4KwefRxzJmVaT2DQ5sRsYIaU8p1Wb4VZPp0aH90MzQaeFvFv1OB9VOws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TymQIbuA0B+z+zTl2pcis52KAeHZziUxY23PzddCj/PLbl8CSbPo81NEV66k?=
 =?us-ascii?Q?16nYDTrRHNwyyKgAPKrRAsMey1C/NZvlHshCgw9Cov1bNv3YoiSoXyh952k1?=
 =?us-ascii?Q?1ts3k/tpyosLh1RtQMeF6lg9B+TV9TufQEzwjmftMgqQCnlyl5tr6xDBZflu?=
 =?us-ascii?Q?woG9aMNlFRXwJrk/6f6+dmQIR98UR5ZpQhoHPz7z25BGvKRhqEOa2x3z3uV/?=
 =?us-ascii?Q?kSNRo3nEP8VX5izqGsv4cyeAV4Vwyd9aUQ3Me0fCh+NV56N3VYKwoDrHuzAG?=
 =?us-ascii?Q?Ou8SI9jYBvJQPhguJNrz/Jwj0zTU3x48M8b1pIoIBJT7OySKuxZ7iEvOd76s?=
 =?us-ascii?Q?4d8/85GO8YaduAsQRoEfFfi6CUfJ9Z3rkPbHwbLIUcmVYwmVjo81SFJOf/bt?=
 =?us-ascii?Q?xz8krj2LNrqY0/fMN2jwkRdU8lyC3bhoYohjxzM7YASHIvJbKniBCWTn+oTw?=
 =?us-ascii?Q?SVVXiHEbdaANhSMjXPETlI6ncuA4qfDIsUASl4C9G2oDXLzsIZuqNDArLUjf?=
 =?us-ascii?Q?AhAhhQwjq/QBOMRE1CX1DcbfQugPetG14OIecjWOQTWpK439+RIiz+GLd2L5?=
 =?us-ascii?Q?axB1ispT5mCkXIWh6bYoDZVTD8Le421US+zzDKwc9OyhDnQKTxqJB6PjRJst?=
 =?us-ascii?Q?G8prdooYccK3T8ppk5LkMDRtOfLDpb2WasWt8yGEpH/5onqZx8nvMJ7U8Tb7?=
 =?us-ascii?Q?ar0Gjr6nSSLZqDcSH93l8dQnLFCYpSfeUdpSoxXMIzqNUNQnTqEVhjyVeOPB?=
 =?us-ascii?Q?HheXGHnDp9zn0FogaDrmZu+r0M/cpvr/6j9ej7rUGcJTaYcjHs2JowRBj6nh?=
 =?us-ascii?Q?M3TA3KufxcEiztALilTkyw0SiDAlmXd7F55eczcZiNf1MZdFAxibuzC758Xn?=
 =?us-ascii?Q?+TgPDVCd0T1cVYGfSNGVu+MhOBIhNKypLcxFFOwrNt59SpQ0KzBIW2/189bQ?=
 =?us-ascii?Q?FxXEZqqRzYidS65Cs7j/umZ1eqsYr5YN+x8fYb+pHeLHXN7SNCKrWADZW6BZ?=
 =?us-ascii?Q?XbveU2euQx+Zg1mrKSSz3sjvZhEJmalM5UByQ6nLqHb1g1pUQ2W5VPt5cOBp?=
 =?us-ascii?Q?NeHVe6GZYm/VPXKi01G296B+eGVh+fVq5ti5hv84uDRoxTuHJnBKC9LeFF7F?=
 =?us-ascii?Q?3NZ+MRAF6VHARGdpxZ4gM1icpB42GTAAjETJQtKaZj3tc0dVAC7ENALqSRiS?=
 =?us-ascii?Q?JUaktJGThVR9v/W8gWnlyq4KH799P/vcElM8zlFiLIbvjwTq/WFGtew4hrQJ?=
 =?us-ascii?Q?XmdyP2lUQ+zcvjTF8/EABmuDQcRan6Dcgt04eum+0EoWMqQHWMx98O2X7FkZ?=
 =?us-ascii?Q?ClYOQqTyBZD7r4wjorwDG0yUSAV8RGkrShWvX6R0iMGa1wfXgKe/NDwDN6Sl?=
 =?us-ascii?Q?0atty41OrUX5X64V8o5iY2oOaPJEQleDjlVuasPKkGiCOTQTJUyxXCCavy1a?=
 =?us-ascii?Q?PTu+Kkag6Qi4O7bzmHudJ51gEyMfu9vSwVbloTCgvLTvpjUnaiav5ezdxYn7?=
 =?us-ascii?Q?fUDoUcfNQrQPWN8dIHrGTmBejwyEMHFf2W1T4puLAxKs5a5oiArRwtwBxWEi?=
 =?us-ascii?Q?nU+AfRFUT4VQNGO0ud6k28mjD497t9ejiJlIgyV2nYAEVzr7stiFmtJ/zykP?=
 =?us-ascii?Q?0MgSHrBdSddxXVLXrvUOhXMVLB6o50kSMp/pxu586fkklHy9prDBGfkPEJF1?=
 =?us-ascii?Q?2bXoihHOGOiii8qnZwn3ISoTQgCa0mwourfyVO+GPxW9Eta0R0aW2JOn/JqU?=
 =?us-ascii?Q?4z4uM8DfmfqrNV+7V9Neook/IgcvHgqUkcAulgD2Hi6LXU9LbbSv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bae9e22a-bccb-430d-a267-08dede5b6536
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:25.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WToPfkmDOBjEGbkE9UssYv3bpTkzZfbrdeEvensXzXOU+wyeqKdCyiHEBYYx+S5d3p2B0bdj0pyYwc2unkxTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6307
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
	TAGGED_FROM(0.00)[bounces-12288-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B687A7385EA

The dw-edma-pcie driver copies static template data into a mutable
dw_edma_pcie_data instance before applying capability-derived updates.
Keep the derived non-LL mode in that copy as well, instead of only
tracking it in a local variable in dw_edma_pcie_probe().

This prepares for keeping capability parsing behind match data without a
separate non-LL output parameter.

No functional change intended.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 5e81a433a957..8ecf67828a52 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -73,6 +73,7 @@ struct dw_edma_pcie_data {
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
 	u64				devmem_phys_off;
+	bool				cfg_non_ll;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -326,7 +327,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
-	bool non_ll = false;
 
 	if (!pdata)
 		return -ENODEV;
@@ -361,14 +361,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		 * the HDMA IP.
 		 */
 		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
-			non_ll = true;
+			vsec_data->cfg_non_ll = true;
 
 		/*
 		 * Configure the channel LL and data blocks if number of
 		 * channels enabled in VSEC capability are more than the
 		 * channels configured in xilinx_mdb_data.
 		 */
-		if (!non_ll)
+		if (!vsec_data->cfg_non_ll)
 			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
 						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
 						       DW_PCIE_XILINX_MDB_LL_SIZE,
@@ -421,7 +421,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
-	chip->cfg_non_ll = non_ll;
+	chip->cfg_non_ll = vsec_data->cfg_non_ll;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -430,7 +430,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !vsec_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -457,7 +457,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !vsec_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
-- 
2.51.0


