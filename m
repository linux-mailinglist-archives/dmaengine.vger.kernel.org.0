Return-Path: <dmaengine+bounces-10815-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC8hCsPrE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10815-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:27:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911845C666D
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 271BD3020872
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3B23A9013;
	Mon, 25 May 2026 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AuWcwp1x"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232AB3A7F5E;
	Mon, 25 May 2026 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690287; cv=fail; b=YuD57oBzdzvMdH2v6MpnuyZdpNld2Jm4EibF0FaalctoyT+YbQIRECS1pypZ4zHZIE7ees0OEbuJx8MKmZIpaiq2Bqd835hM6N6Tr7jiNaGhKntgjnX1llhNcFMTGzh2ogX2rojcXbkizmWPhrlHtY6IxKy/lXLbzfQQS/ikYbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690287; c=relaxed/simple;
	bh=PI3h4AyF1fB08hphQXho/raeD1WC2JATYDg/RGYRnEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFsyIqn8e0UUS0QNA47BPIPJHlVxP+iSD56T6Wq5wTMjScowFhn2uppHrd5SReuD3eIxRjsqloD7Xm7ReWyj6Wu8/ROhx3ijqnph14p8ecuEU46UaKPdtsNU7VJUVf84K0XzR3Oz6g11/vB9Yr7B5OuLtK6YaVk11p+jz1/5+xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AuWcwp1x; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx9TY3IuaIVO1P8cPomIs7qDWezys8AquCuMbgFYYAEI5lyhg9zcMJMZgjwMJpYOvF0V+oFzlqSvjgNU47BQCLQB6t1Y5expjuZHPIO+iHiyL6/rRUPNaB5AIZ1yrhe0bKHb37xnzHud0aZD0nfJU7z6Q6TfYFICtYVC6IDPeBb3Pq9RF3G7bpKLX6PQPzCyFntpucgHI8BZc+hl2pGDsHHgo6pJw70zxBWxYnwVY8thoU/Ml/ER0LZjxjyJfefiHz7+UKsSTaYfgxvzvO1G4EtDW8ecT+MPWhptZ2b9I+hPp353+wdbzsAUcDr6Z3pA2QAiTgezXXqHI6dGtuL82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK39eZP/INF6UxePMW3fwhmSXSAjyIErRnDAfK+FBM0=;
 b=SdPhGSorQzmn2Nk9B1Rug8k0osrJxLnSqTO+zXWiUqLTA5nO8er+0g7IqF1J9PtV4eu0EnRw1J2ejInKE9GMA+m31qtWW1vtXEkxW1fWvjbUJ2EG+gpFdUnO45xzkXBjGsySqUV4x0kIuvdtHi2sc7jmnBv0OJZQA/WKvl/zsF9E6PXYjjujq3EV4Pv2UUIVNnBZgG9Zfh11NPQPwkMC/Chrj5J1O0a6xTAQIqRkx9BaTo9DXYOEo7zvNZJyME8HmmmTMmYyKABqGJsZPsVAFcZBgzNEGjxqvXNg41qhhLdRGSIveiY346diKG8yUgq3kt8iT4C1KSZacWqnwt2Tbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK39eZP/INF6UxePMW3fwhmSXSAjyIErRnDAfK+FBM0=;
 b=AuWcwp1xuFrjKnozof7gmonDBRk1Q7OODNcxgSvq/eAJ9QJRJXlgC3vuPjoiwehHiuU78xQ35yYHZ0/50R2hX2blL0ltzrT3x9uIi+0Ce7h10cLjTbmwBxY5ej07IZNPiNV4GrfZfB2qt7DfugRW1R/dOp7RI6X7J1Y99xv8gdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7796.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:40 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] dmaengine: dw-edma-pcie: Add platform ops to match data
Date: Mon, 25 May 2026 15:24:16 +0900
Message-ID: <20260525062420.3315904-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e616ea-97ce-4c89-02ee-08deba264d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	khvKpkHB/wpEqeq+So9jzcRgSQl7/w5Cpqc1NTNuqTSl6V5TUhhq345YVRuUoqZaP6rawu1i8DS5WADKL3ZcmokIw/t3NFjwn9d1GJccNUePrNqb4VVKLb255SKuuvVqNNkWPUKp3DaUYy+21mlDxQtB3WS9lj55XVKE8LtNW3EuXblao8wkxY1q1RjXbvbFv7emDxeqmcdbz8ZLNgqM8BVp12VdICtU7pUfdYXlk0QVt7nh91IIj4Wixv9QkaW6X+UYHJPxtOYupNswb8jgrgvpigppv9JGLoH5AZMDyYV7hZZFZLlODi77lL2mN794fJuD+ph2p5LUNm+pnAy7prAch9wVPNipRLNVwiwwdWPGLGqVRwJTuJGcxZ72YZ0+EXSl7tGwSw+p9DTxiA0/uw7KrEOiEKAQQ82S8huZgXGDFTgUJQyPcMFEhkMWj1WJI7c46onm7RzAPN1mvRmd/YjKNZci2dNCTEnlWlfCe0RkdT5bEO3YBRVwfpT76yc94FThyS3ypM+kHHdbBw7IL9p3+qVucqiuFOfKsU10sJ6HALeT2lOp5EBjgebHdseFZzcU/jn3GY95fDWvhfsA/v+oDecce2+O8xWq6jri66HjZv4PrYIyzkci9bl0h6bkhWB9yNV9WdHVIK94ps0SD04jIDa+xoJ6aJe5SL98MDtcvyOOzfvtbuPD4T3cM6gK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SVDinhGNHifOak1Z6UcZAYfAaVmE52lpmUo6PPHGoHBWV1rHSyOCn1BHXmwA?=
 =?us-ascii?Q?G3ZPARqFSWgBijjUpijBd2PSj2bTEWGCovAxRJZQ2ugh6tNGqFHwGChF0WG0?=
 =?us-ascii?Q?mbNobNb5M6gSkFsiXttrXzpl+O4sjpUzJSaWa4BtlC7FS+hYCbGJ6ujF7SA5?=
 =?us-ascii?Q?H/MF5zSvX2bjS4Ju/xc5Dt/GuYHur/CFiJGiCtcVQpGZhV5uPy3I7eueBMw0?=
 =?us-ascii?Q?9OcSfv5wBa4MPE7O/zalFgT2EiUZ3z2ZBJ0WRQlBMHAvQmSCmSmPQd/QIdYU?=
 =?us-ascii?Q?okILHFXPhrfUjOZNpBnDxrXXqoPjfP7ABZ4ZOGAGviRFLRrfb0HX8g/LTa5g?=
 =?us-ascii?Q?qPjPZNgBOSPQ4pNRRk7OCQJMSazsXpziBx3i2+dHEiu80S43yGpoUpVDA6dN?=
 =?us-ascii?Q?iUDCWPpsPQSSHgKhgumeY7rXKPwc5ytFB7PG+OvIyxMO/BvnV3lV5ss8OPQn?=
 =?us-ascii?Q?fZZ0LLwPMhsFQIzriZu6Vh7U83FU2Nx7boe44bUCAt0XsgoefyzFYvxFZhAG?=
 =?us-ascii?Q?3yrVzpPTZc2nb9Erh43upbuffS1hvvrfvyUd0ESLnyTV5BBp95TAxh3G6sk/?=
 =?us-ascii?Q?yVnRFXJi9GJefCG4u3Aty+Tx+BRoI5aMop0yJbJBLAfR4utC8LCwPsvptWJg?=
 =?us-ascii?Q?AshYlup2Wi43hvTslDv1rvfyO8LzrRzSn5O1OUqSL4O2oia25zggV4x+FRS0?=
 =?us-ascii?Q?7SvJJamqQDcAARtwl15P7xhTC4OLAHAppx5fUMy3dqGhXqGShjVBK8n6crYn?=
 =?us-ascii?Q?T0SmphrIb24Kz3QFKp0Jg1YN5TlhwwJRlaTrgxJcStPPGaFBQBffzbr4JbJE?=
 =?us-ascii?Q?WXTufJIV4nq/Adr1uLHuxzdDFeFD1T8XhClU/AtI4Up17NmHRri9CfUxKvri?=
 =?us-ascii?Q?xgOuPcDln6ezPb7SLh5ejqwQaAtZ8Nd9tOjU3U92J3Q5hkaHDu/OTSWhFjOo?=
 =?us-ascii?Q?CGuf/uyQomX5Ml7jhgORekQOwLYGX0uKzzYYvBgs4+2stl077n24N7UvdYJU?=
 =?us-ascii?Q?TiHmZOoyDU3PP+7CEmO5lDfelgw4XSlZSpj9/eW2jij2vaTGFa/khV1KMdRb?=
 =?us-ascii?Q?JJxonmwrQ1Z7Bqq3PEVm0GEGBOo3SR9m6CpYMK9oZPrqQmbLO8+m0qW+LTzs?=
 =?us-ascii?Q?BjYPBHnIi59EpgMxc9qH2KgxB6Yra1aj//uEeL+CD69Cs3mES3MO+Dhi8FqA?=
 =?us-ascii?Q?jgIGPmpCj3+7BDk+ZCjobZyuZD06/wbJGBMtp6DE26EyaX9xmUi2OO+0pfTu?=
 =?us-ascii?Q?nblMq4kd4S1foN79C/mCwdsTTlcIQXQqPBzAfy9sjPNcGQm3kj6bEHEhSnOo?=
 =?us-ascii?Q?vVyMrBxxNMPX9ymQsgYo7Aw9nLFousS1QddX9BVMhsAR7qav6GY12U4i20D8?=
 =?us-ascii?Q?B047dc0loTohQcD5nFyIVM3AsyEod5XeHQiXdzsfdWyCXTyn/g3MXvCfRXlW?=
 =?us-ascii?Q?r/2dzUCX2GI3hzVYFNXKkAcoHgcPriC0YSjj95ULXgJiV+LWl2kMyr+2fzBF?=
 =?us-ascii?Q?tGyiv8eqAUbMYgQmK2ohiqv/E8Muc0AS9bR7jEH3EwEjQkKJr/YYBwFMhxhY?=
 =?us-ascii?Q?SrrO4UsgHuKoo+KM40cIwvXvea1Wl3wmRjAEriuYLWlYG/Gt62tRy5ep/StF?=
 =?us-ascii?Q?XpbsfJZftI4/l10sTskES7MTVFA9sB7TLnmxwxXWf/l2WQI0+/ol7mh+Cvei?=
 =?us-ascii?Q?q9O3uqoqBqPpd/4haTN0v6vHmClQ+Q4yJdnS1TYI+yNoSdivCgwYuDCDKbhA?=
 =?us-ascii?Q?mwIXo/4E8rmN21GmiwF0yKyrKPfbVSV6WJDZhp8gwQdvnqNS8CjM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e616ea-97ce-4c89-02ee-08deba264d65
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:40.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O8srzTANOtyaZpP6EAFzwObTo5sIjrnXXHMnJ/PEHwU+hGAvLBdIk841sxFRbSCtB/0YLZMN6CwTbcZo/bhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7796
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
	TAGGED_FROM(0.00)[bounces-10815-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 911845C666D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the platform ops pointer into match data. Existing EDDA/MDB matches
keep using dw_edma_pcie_plat_ops.

No functional changes intended.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch. The original commit
    "dmaengine: dw-edma-pcie: Add raw slave address ops" is dropped
    per Frank's suggestion. DW_EDMA_PCIE_F_RAW_SLAVE_ADDR is no
    longer needed.

 drivers/dma/dw-edma/dw-edma-pcie.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 9aed1005854d..1d63b07723f9 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -77,6 +77,7 @@ struct dw_edma_pcie_data {
 
 struct dw_edma_pcie_match_data {
 	const struct dw_edma_pcie_data *data;
+	const struct dw_edma_plat_ops *plat_ops;
 	/*
 	 * Mandatory callback. It may leave @pdata unchanged when the static
 	 * template already describes the device.
@@ -383,7 +384,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	/* Let device-specific discovery override the static template data. */
-	if (!match->parse_caps)
+	if (!match->parse_caps || !match->plat_ops)
 		return -EINVAL;
 
 	err = match->parse_caps(pdev, dma_data);
@@ -435,7 +436,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = dma_data->mf;
 	chip->default_irq_mode = match->default_irq_mode;
 	chip->nr_irqs = nr_irqs;
-	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->ops = match->plat_ops;
 	chip->cfg_non_ll = dma_data->cfg_non_ll;
 
 	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
@@ -577,11 +578,13 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct dw_edma_pcie_match_data snps_edda_match_data = {
 	.data = &snps_edda_data,
+	.plat_ops = &dw_edma_pcie_plat_ops,
 	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
 };
 
 static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
 	.data = &xilinx_mdb_data,
+	.plat_ops = &dw_edma_pcie_plat_ops,
 	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
 	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
 };
-- 
2.51.0


