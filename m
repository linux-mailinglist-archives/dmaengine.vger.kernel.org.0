Return-Path: <dmaengine+bounces-10814-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBBCHn3rE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10814-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:26:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE325C6614
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55C583008FF1
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60F3A7F52;
	Mon, 25 May 2026 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="i11KuafK"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92E3A718D;
	Mon, 25 May 2026 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690285; cv=fail; b=XGD0x5m0rxVlKAYFwtKPm9YlpM+24/7PjRll/AB+hLeDCK2xAmN05yPQEPRkUQsyp92Bh973c/WAiWCgXmVGr3iaiNLHT77tN0DvlS9j2VgH6TwUSTFnm94gry5oaREMjHkK7eZdAzLvKrLONhPBr30typEbj5IlKHX7OA6RsfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690285; c=relaxed/simple;
	bh=dmdG/+D2uGA7SaG7RBncNPhsySvfqw5PM+PLeGI9sss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIokbNpapphGEQVE3osrPk/HYXlEIsCK9ZhkoM8rJQKKclF4GODmJfpD1CkMgF8OgBsTMu1t+FfykSK/+IJQ9/1Ru5K7NNq2T5efnwYptt7QyYHbfTgpx6Hl/qtmVsOWb/z63SW4aDiYaogVaMp/rZphcJ91nmq3RuL/Gb1FPGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=i11KuafK; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJbgFeOeA0NtLBnYpybG/JqKKpXIEujsZVzcHjYyRVUyf5oKHqahwFTz0C6Ee3T8+EUIZc/iHhzThtBZ0uECI4WV01dhLffJ16NvaSKYHhmLEFFwySZRjMYjQCqv6vKTMyF6HrnSujl5YW4eLCp/XcWSYEY2UfRqEPXTg0xcfBnC91YdxwjUd78SZTJOP7sr3rmQ7tYTPyp+RMnAFzj2/T3dHN7XT4v5hrqekhzNHyT1C2YgAwws3kG+ibYYKUIE1LC2zjl1CKl8P2aBzWBN3y8T1pPiVTgKuRWFChMUS4xxFEzNPUabaJz5NdkexHbOs2r7AisANEL/+2Ocb0Ok9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN/wg6M5BDdqgCbCpw9BvjvwjBvCqKAAf/R2PC2LiwY=;
 b=QwiDEt4bqwpxKtUBXUvB/diQAH/Vawx/hKQ1VDUvWRvzMyQpy2LRDPSO07kjFCGsfYM/uYvzdLmpVzlfAxd+nwjPvDMXquc0zdSx32q6wYgJTKPaDXTEcYvwR5QBVk5Q3/awTipTW3GlgqacZyAfmAb21YoA8nYVqd7CgDZ5jyiW3JsAdaj/D2ArILrC0fJ/ykVPCF2LyZyiA3SoKQEyk7GFUDv/FMvCE3phhZUMpjjb3O20pSEAmPalXSBaiqLVfSSRMaFxWqmav7c1PRv8b63WvXxjYfx8417kNPobu1DkFGL11q7/KXrXmly9KaJ4vXSkiBcFzn/aq5tW2arXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN/wg6M5BDdqgCbCpw9BvjvwjBvCqKAAf/R2PC2LiwY=;
 b=i11KuafKCCaHUW9hfpvLz0szoOFP4tU3CYAelXu5Leq/m1zosgweIcVh8Ng/oukdibH4JT+TKf+R03exJFr66ijH8cyrtVbUfUq0i62pvRD3CM5qiOVMuQPifvpUY1vbX71uJ2/4EQWioZgWfDoPIpLJU2u81OCnyUZGY8Rm1VU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7796.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:39 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] dmaengine: dw-edma-pcie: Add default IRQ mode to match data
Date: Mon, 25 May 2026 15:24:15 +0900
Message-ID: <20260525062420.3315904-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0149.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bec342-a88b-4dca-78f2-08deba264cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8TRy6T3AtCCXv/PfUt0hvNKcetS255M9879WlCUvy0xfml2Cj7kfZ5CBc1tzZaj0rd+dTtGg0pu0V8OQ2Skvu29HFIratILCM/Gdp3l3cpia6nORNRaDSdEV9h1OXG1NMMo/uBKv7YG7OW2JGk05jtbKzj0CrIxcX6Gn/w/RdqefunY9bz6YcglhdtGuN85b/SJfCYYdBBZ3dkNj4Bc1OTKdrBQ5mCmiM4ICGx3oVOuqL13ogmmQcQaMjgUvfaqfqa8aSOwHjrLIW0nTXPN5gQ56xtOMJ6w/ZQ80WxmLDtfc2kQ/uXVLSXSFqQ19ld/YK/cZsXzPsknUbpqjkTLySj8xRApt7tjdkOqc+DTMxxaXl+g4mBjr/HNbPd7JA/RZ/1kWSIQ9IDYOsqsuxYUSNJhTfvd4V6mIrV0fPHq5xioF0czwpgeGD9VcsmFv98cRtc7vZyTPeOMSuMKN+nxvOZvGktdiXMqPTw+DjJIA7IHj2H/a0Xz6mKDODPy/LrJvgL959HvPQpHEktiBmSO7y39Lz96Mh3B3j0Q7PYs3auV8BPGNAzZ8McPRGWbypLp0lv5vC4W7lx28WCX2oj0geDBiDNvD7N/zb4Z2shWUFtojHlAye5q51cR1hNxnp8IEysqsZ0aYnsBQUn/yiYqZNPIUuO47LzJbfLghVoQK3rOWTW+ipmO7+A0BGHrQk1yR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfNiJecu1oF8ZkEBenQDBFM6VuK8roSNwYOOWnEktGMa2fchAz2MWH2PTJY6?=
 =?us-ascii?Q?1W1vJhCNs3ffbbwGQBqKDXYEsQXduWY2RIhtV+6BLSUeTNmmAKQr1Wh9ZCIR?=
 =?us-ascii?Q?QEl/Ddcvh75ia9sDvx42j0l7GCnzDp7KwuXyhrxCW/cYuSuKmIenixriM6h2?=
 =?us-ascii?Q?4Xg95QidoQNqoIj1+MbNsQvSHRDg/m9TY6bITDxc46QtgD4GwD3wzAbWXZDu?=
 =?us-ascii?Q?MEoloO4u54X///iYrvWdGHd6C0uvMeAqTnFN/qqv9JsObI+9zP0eVLHM5k1H?=
 =?us-ascii?Q?AoA0wQX4cLXpCNjtOJUg0z9atMSBbyZAKmqE/w5Dm9ZHfogFrsxExG90rFVU?=
 =?us-ascii?Q?idN0o+iD8d59p0JbcA9qSzf3pJucdberfcTl9w5e01yOj8tYfmOQVpo9N7Po?=
 =?us-ascii?Q?sTYririK96MHqX/AJA0fXtwnmffi5z3Yq6/CFFwOe3+Rxn2LXEX7w4EFbdH2?=
 =?us-ascii?Q?DzL4H4PjaFF8CF70iitG4mw9qnSkj0nrqWYUt4z+PY9CjzLIrv+qCDQinR9W?=
 =?us-ascii?Q?h8VkD/4pZGNMsJYH0m0njKYg+dFCoVjtxx/T/PyHOfvTWTq6pRFD5HxMzMmK?=
 =?us-ascii?Q?wXde7fjzqn2SwdXPo9CWmtlqM0CMzU5f142Q6+jJVP4kflzkWZhLVo9o1/hu?=
 =?us-ascii?Q?I3GNlz662wiNMi5/I8AyetEe+IvXVrQzd+CXuyMxB4PCCgDb4oINC24APtbw?=
 =?us-ascii?Q?CJAn1BBE4+52rkDUDBmvVDU+/F35M1S750hpfW/YIMsSxcSAClM1s+3SlNr4?=
 =?us-ascii?Q?YLVVcg94xrIaA0yKInt+S5u8RWij3aJ+fa7WtLcfyHgqXidg/5Vm5raQiWNv?=
 =?us-ascii?Q?8GUdGwX5tBj97Amq0d/Omu6kAm4wPI7FNbUtpuIs4Wxu6wENC06DuYyNX3O4?=
 =?us-ascii?Q?/lurthANrwFl6QxlH2V79zx6csjalOMWfVmHRk++1kQrrhLckvCv8pYYs0Cz?=
 =?us-ascii?Q?6nsE2knR0FBYZVMbw1xS0E5qApp1d+8GT6DpJUTT4FQ96g0fBbJg7jv+aQZ1?=
 =?us-ascii?Q?SU3STlBlsgx0GE39rwwRaI1Q0kef5BVbJqyVnVqdbVyLRb7eqpWDtSicjKpD?=
 =?us-ascii?Q?5oHUxKTEPi+xIhyefwMdKNZ5roEy7SZtLivMMQD39SygeucHdvnHyP8D+35B?=
 =?us-ascii?Q?8oVhr4heKzdx2zCj9usUaWIUYw6Pkbwu60vK4fls5cAc1Pk/307aHk3kK1XB?=
 =?us-ascii?Q?uN/5Qz4e60cPqz8jylUjTyYdGFTW45I48hoqF4eelHdCtYNswDQxTAHxnX17?=
 =?us-ascii?Q?rBYtKVeiRopvB3NZj8KU66oIpPGSwkaNq8jjxaslX1O9EXnf4qYeAgHHMEqA?=
 =?us-ascii?Q?oH5vr/RBGGlNsYf97glPpWLyoz85iWJh/g+vbLXvcU9LpXCqv+kZx3JPeDJy?=
 =?us-ascii?Q?M2dqPLf9+L7ZESm3Y/9tb+quvts8vT8R2TGS3dvjmlEiJ68ghU+XIbn4TU7A?=
 =?us-ascii?Q?QvNCiqllIReLHPauRkdcIoBnhOtMWo7Yj+l89PH94ymW/uuLZXV+8v4Hv6+D?=
 =?us-ascii?Q?Gt/eRL4tpqCjwfTSy4XtRa/lNdnJbiJpNd44byESxTXuAUQIMU9RC4hrwwFj?=
 =?us-ascii?Q?S8hUD46I4JoLQy9ZMmix5L6ppLlERblDh7oz5xE76jt6Lue815lCGVYPp/4i?=
 =?us-ascii?Q?5470/PSQjYSsYZVX2kydN3eU+x5Jdp1eT1SXcJ94xOe0k3+SeE5DqoCkLr/w?=
 =?us-ascii?Q?cnqBZcOnTNs/I7nVeE/LFYNIpu/tVALOvbDdpUyyeEWJpnBhlQD0Q1mkMirf?=
 =?us-ascii?Q?FNYlcQe0FzT/41ew3hEV5TK1X6c+FBb3cgUPEXH21Wsz4Lff/WPW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bec342-a88b-4dca-78f2-08deba264cd9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:39.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp1fqURhkrVs0/g2NutqHuNYgOeDycEvoJBHqvmzY1IYVUDA7D0/1h/iubXXOsaUFhOsj2qJUMOsGiTKQWEwDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7796
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10814-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7CE325C6614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store the default per-channel interrupt routing mode in dw-edma-pcie
match data and copy it into dw_edma_chip during probe.

No functional change intended. Existing Synopsys EDDA and AMD/Xilinx MDB
matches leave the field zero, which is DW_EDMA_CH_IRQ_DEFAULT.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Refine the commit title.

 drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index c7362f1bf80c..9aed1005854d 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -84,6 +84,7 @@ struct dw_edma_pcie_match_data {
 	int (*parse_caps)(struct pci_dev *pdev,
 			  struct dw_edma_pcie_data *pdata);
 	unsigned long flags;
+	enum dw_edma_ch_irq_mode default_irq_mode;
 };
 
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
@@ -432,6 +433,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dev = dev;
 
 	chip->mf = dma_data->mf;
+	chip->default_irq_mode = match->default_irq_mode;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
 	chip->cfg_non_ll = dma_data->cfg_non_ll;
-- 
2.51.0


