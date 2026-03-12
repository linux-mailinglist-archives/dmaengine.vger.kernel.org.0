Return-Path: <dmaengine+bounces-9403-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NFoFZnwsmlaRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9403-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:58:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1691C2762AB
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 708AF311D70C
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F53FD149;
	Thu, 12 Mar 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Xzy3INh+"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020091.outbound.protection.outlook.com [52.101.229.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B33FCB04;
	Thu, 12 Mar 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334243; cv=fail; b=ecqCcyvuLG5rVZTpfeVh0x8dFNcjDQ/i4n5iApG7MJZVns+NMeijoUlBPsKv0K3TvxukXy16DLGlSl6/UgM8MdsaVSHk6/mui+53pgdQStsdp2K4XSI1PRinTIxxrKidhXj35QVzGRlasUWHYROKAmh0ZgevTDnrNAq9b4dxQBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334243; c=relaxed/simple;
	bh=c9sncc0/PUGP1cZ7+NdjGQO1NB4+eVigqDubnJm2biQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BjBMEnmOXSjsj4ukRNqKldNntx6OvlQPffqmkCJ1IxGihLYx2gJBgzR/P+yYmwN9FZ21BVPZeAfU50w/r/2jz8Qz/DS3OC3soTyCUfRo8VzSBEs+2bIvsIAOtj32nTABoTN+HaFt8XeLJ+AsQvQ0s5N1sQuPgvoFbeifeN+sekQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Xzy3INh+; arc=fail smtp.client-ip=52.101.229.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOKCPP2g5MHufj39iCJkeVVDSkkLOygdIrhJkymqrIw85bhQc2AkCFfAvAi3WQoelJjkFIar+A9JxjygTLYx+FysXOslTnewbfZHJuh1wV3tdJ60VexCFyoEToWARLZSRD7QILe1MX8+whs6AWo234eNBRdHqc4ddcUYWDdyD9aeUL1RQem29tkMV8DNr+0WyQ1nbT8JVjtN5U5LlqK1siaXsfUDu3a7+83XowgVKkkn4tcVgv0CRyfUgFGXHTBtpPm1oYfXU6Q563kpvOXeWk/Io7nhauNvHiC9XD3/EPKeaIK5lPqptB9Tyib6J99GE+Bhan4PDZIW571X1XaJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flD7q3gwhFYjVkKA/zhd9neWUX8pQfo4EsdUhtxH3t0=;
 b=KpmyLVRaacncnz5AuHYrBX6n+HGeSoKB5rdfI548jgYkSEJrAx8Qaf+0ENwgdebxBETaT+rtqFXu9QenHwozx5GjK/bF3G+7VaEls9BqfwVccW19SGOj+fpfyDd60+6/Do0saHirGUVLYM+lUGst+whic8oNfxUvQVQ7C/MKSdu2bQi57GAVIQqB0Edfa8lfHIU2VznN25zrgIQ56x0zcWHSXLaGhcASqY7twIi8tFDJ/9DfqsTbj6a5Z+TkkAsc922Pnnmdl+42ESPdy7dERH9ruPtSvwLniRxQmg7PzOg29XVkXDNHpLkmssxyQ8Bx9ztFITqzZS7vIJnji4ORsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flD7q3gwhFYjVkKA/zhd9neWUX8pQfo4EsdUhtxH3t0=;
 b=Xzy3INh+5X2GDZ22YrfdVnxsv6UBJWRvgv3oxUF4COdcctxnpvwvRYl1noIxJzptVonkQUHXLZfOJml/vLAQbCvdXD2e5VnNjOzg4mrY2rJF9cl9yIv/AxNYcIw5837ZromsL8jAfM2S4j27GxJQ0w0nHdBV/R7jktbtM+J+sFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:17 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 08/15] PCI: dwc: ep: Delegate exported eDMA channels through EPC ops
Date: Fri, 13 Mar 2026 01:49:58 +0900
Message-ID: <20260312165005.1148676-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ea1d1f-512f-4e3f-832b-08de805770f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fcNO4keHFnH4YF6d2/BfWR8uYMteIVzpc6/z4/yipN1I6aXidAqIbGruaGK+ReC9s3KiJbAXc8Hmt5cDSnShP/jjoB8QcZ8Qztc6/lBgoGulrB17p7CUZsiDAscOTnM0HRqKMLnMACmSW0QrdIcgVEBdx1zMBfXezXzooqGVnupftq5Cavgj014/KU9LTovEYEu24V9/zm336QFgUrv1voXfecwguX4HXhwgHX34LXIbftq4WpkZTg9jzeZmMqEazgXEutYf6wzdR7u6HFcOOOy0TzWJqLbMH58vNX4/m/5oGSOLR4Fyw/xwrLUde6znat1WB73XBQdJD3eIfjeMUrR5c+np0PIPG/vP5Spni9JgeCFupNUNLDBQaHOrvwnAIkyldxXvF6bFaVnGTe7Sls7uF2mtqXmPnYLnHSTwXsetTf8d5N4cGkj6xdb23QARGHrED0goXparAR92scGM99KCLGkojk60bwa8FBMV+b8uwt5JbeFbrH6M8lZ7UDJbiOMmUG+GRH0QbQzne7AkE/m7c1E7TtXkIAQbf9FuHEOHDMwKoWmeMjQjjUBO2TTZK6kNh4qXMZCmT27SBLQewbPebURWW6vCbp1d3Ee9LrQuJUgGVwMb3YFBo4256rsk/QAgjNzlfNs3BnXA8AcdpwLahuWgDSN8n6vsaVjeY3zeCZ2jPuzR5uI3+5gsSrWiEW/m5f8DySfxj4N7lSqj8+JWMu5SmpYkqHo805l4437yZR/4qlrDIR0jiIzAKVoNPJonQ9WngIbxhDEUPaIA8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cZfVXDpU/CslcTqet4bZm3iR0d095aMIBUJjJ+HRiEwSKQuKZ851bkfc3rTc?=
 =?us-ascii?Q?lQE9InTYmVKKYx6zmZ9f0STTteYul2Te6hNouC4pUuSxlG4Dc7+rsGxonAAx?=
 =?us-ascii?Q?Bkch1DEeCSdaKF+9/aCxkzIaGbaWU6DsyPyzAKL89RYZhGR9RPs+DauxtBDX?=
 =?us-ascii?Q?nEJO4MPIFP3aDMKe4PDbumWNzDNbSJ7UwnTVwMBCWEN8KdZwp4qy5911EiPe?=
 =?us-ascii?Q?qF/WRgI5DY++GAUHtLL6xKeR65ViGmWW4TveJHgMv+UcmzHebutlrZmxy5in?=
 =?us-ascii?Q?iCl+Z3naYANSc8W2ADq2iHScEfR4mOaZ9lr4dV7GPxunMKl+zEMMPxrPYSoU?=
 =?us-ascii?Q?4shJKfKJVSxWRRUnMK+rLrJ86OfSl3HJYO8uvMwaKU+BescSqDKpQUypT/0f?=
 =?us-ascii?Q?N1t/bJI7ufbEzVhPVjekYwuwCgh1Vr4vivg9mh9uRyPhIoQRYSc+JVOb50SI?=
 =?us-ascii?Q?nwyGblRFoEh+mYFC5dJIETqGLG58EyTKOetzvDDuMJ7P1QWJGaWXOlGmsikq?=
 =?us-ascii?Q?lW4x11kqusDTUrhBKj4cqJPJ4zXzHca5HogiCTuQfni+jm0qH0oXiYOpfuE3?=
 =?us-ascii?Q?xyvIeuT3r1hCiN+UhqvTCprZXzKDcsXtptwvF7PRxNTSbbQx4sNfHZbmKyEL?=
 =?us-ascii?Q?xi/SzurnfjWmCVFpwrY4N4J6pWS0/lzbNOxoHxzuh5Up5UnYP5aqKxLtoIxW?=
 =?us-ascii?Q?4EhX32FlEHiDhO79AOUUq4uniYxb99Cb4HQd0ptbv8pTg5jqTc1w59EvlRuT?=
 =?us-ascii?Q?sMjcFnusJo0WTZJuvKgn47vC2L4J+IMmBABp3OUoSV9ATXmh1mfjP2YXx9JZ?=
 =?us-ascii?Q?oS4YxRC+Zzne4HHUBcK0esfDHxYJ23EAtwa+X7r7C6i0BkCfPAZejgzWhbBl?=
 =?us-ascii?Q?w/lt+zJQOVoB0WYzf71FDAsUuRs6m/5tKGWHo9Bkxl0IsKoI/FUHg4tuzhrA?=
 =?us-ascii?Q?FxJKESQQy55+c/xSL/3j6+JoWutRueYvItxNzLIo8GoByKNJdRo2hM+eV1U2?=
 =?us-ascii?Q?pCkZv0vzPxgKt2UzmWJXhaIZ9BYuGXhB8i0wrYC8F0UOYr6fk4ML62JokNRi?=
 =?us-ascii?Q?+59u7jhx8nLbbizv1pyXwtjWA4W4xWRARGHQQ4MxKqYOK1YFcZ2qghXOmz0/?=
 =?us-ascii?Q?prV7X75cQepNkwsVhFApJZXiHNH8Re6eIBEKDRVA9qfrPAdRuILOYnzL3jnD?=
 =?us-ascii?Q?HjDWZ0CSlgfY+KftFjDoGn49SxQtfEaWX0YOCGmAedsvpGNu+n0LXwSAz9BG?=
 =?us-ascii?Q?DkEZ3rdeMgyncik3oqki+smqxtLleLEer8sbBGRunZ9beYNKJnyolw9dWcZy?=
 =?us-ascii?Q?iAuYOsa0WqUByAsG2sYvulSyXxiWKNZ09wzL/gt6ESESCIMm6ILNpKAHodAG?=
 =?us-ascii?Q?lJ5tyhUn299Yi0JgUDEUIYJQsmxcLvW0FaMAO37Fc8MfvqX0v0dUbW8iSJx0?=
 =?us-ascii?Q?eebi7LsplrBh5uYhiYZFYOXHNFzloVGC2cBF+t9Yxb5BATtjqsOuNCbyn9Lm?=
 =?us-ascii?Q?XdKS9b3piQTbMe+x4atCtc3gguuUUEsKA/7/PmqjmmJsc7Mo5oWYzq+ooRxD?=
 =?us-ascii?Q?TtbuvIDkXYZTAq4IY/84OE+yVIwiWtkBwvkD/vXdh4dlgYGDnuiOi2eFq+vT?=
 =?us-ascii?Q?ozLteuxbP1Lwxsdsb9v/U8J/Y4MdGnHRXpzkx52iLjF0wpl6QCVJVcKXiiTT?=
 =?us-ascii?Q?Uma7RyZv4zBpPtr/+8MmpFIkgosq/itzi2Abellr9O7STHggMpV4c7/in/ja?=
 =?us-ascii?Q?3l/dkpy9pBbbDo0h09YA6RnEmMf5LTw8EY5XvlY+U5d2Dh8lZGlV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ea1d1f-512f-4e3f-832b-08de805770f6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:17.9310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AreoUpzsIB2QT1cwARAVA1ttjxtdns5CCnXZcYY2tI82TUJeTq3HzczK/eAFqVbaEyp8qVTSjCuj8hDbZSXkqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9403-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1691C2762AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the new EPC DMA delegation hooks for DesignWare endpoint
controllers with integrated eDMA.

The DWC implementation requests channels through DMAEngine, programs
DW_EDMA_CH_IRQ_REMOTE while the channels are delegated, and keeps the
struct dma_chan references in endpoint-private state so the reservation is
maintained until undelegation.

When the channels are returned, restore the default IRQ mode before
releasing them back to DMAEngine.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 188 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  11 +
 2 files changed, 199 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1e584f6a6565..4c997cf1989c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -818,6 +818,192 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+struct dw_pcie_ep_dma_filter {
+	struct device *dma_dev;
+	u32 direction;
+};
+
+static int
+dw_pcie_ep_dma_dir_to_direction(enum pci_epc_aux_dma_dir dir, u32 *direction)
+{
+	switch (dir) {
+	case PCI_EPC_AUX_DMA_DIR_READ:
+		*direction = BIT(DMA_DEV_TO_MEM);
+		return 0;
+	case PCI_EPC_AUX_DMA_DIR_WRITE:
+		*direction = BIT(DMA_MEM_TO_DEV);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool dw_pcie_ep_dma_filter_fn(struct dma_chan *chan, void *arg)
+{
+	struct dma_slave_caps caps;
+	struct dw_pcie_ep_dma_filter *filter = arg;
+	int ret;
+
+	if (chan->device->dev != filter->dma_dev)
+		return false;
+
+	ret = dma_get_slave_caps(chan, &caps);
+	if (ret < 0)
+		return false;
+
+	return !!(caps.directions & filter->direction);
+}
+
+static int dw_pcie_ep_dma_set_irq_mode(struct dma_chan *chan,
+				       enum dw_edma_ch_irq_mode mode)
+{
+	struct dw_edma_peripheral_config pcfg = {
+		.irq_mode = mode,
+	};
+	struct dma_slave_config cfg = {
+		.peripheral_config = &pcfg,
+		.peripheral_size = sizeof(pcfg),
+	};
+
+	return dmaengine_slave_config(chan, &cfg);
+}
+
+static struct dw_pcie_ep_dma_delegated_chan *
+dw_pcie_ep_find_delegated_dma_chan(struct dw_pcie_ep *ep,
+				   enum pci_epc_aux_dma_dir dir, int chan_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < ep->num_delegated_dma_chans; i++) {
+		if (ep->delegated_dma_chans[i].dir != dir)
+			continue;
+		if (ep->delegated_dma_chans[i].chan_id != chan_id)
+			continue;
+		return &ep->delegated_dma_chans[i];
+	}
+
+	return NULL;
+}
+
+static void
+dw_pcie_ep_remove_delegated_dma_chan(struct dw_pcie_ep *ep,
+				     struct dw_pcie_ep_dma_delegated_chan *dchan)
+{
+	unsigned int idx = dchan - ep->delegated_dma_chans;
+
+	if (idx >= ep->num_delegated_dma_chans)
+		return;
+
+	ep->num_delegated_dma_chans--;
+	if (idx != ep->num_delegated_dma_chans)
+		ep->delegated_dma_chans[idx] =
+			ep->delegated_dma_chans[ep->num_delegated_dma_chans];
+
+	memset(&ep->delegated_dma_chans[ep->num_delegated_dma_chans], 0,
+	       sizeof(ep->delegated_dma_chans[0]));
+}
+
+static int
+dw_pcie_ep_undelegate_dma_channels(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				   enum pci_epc_aux_dma_dir dir,
+				   const int *chan_ids, u32 num_chans)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie_ep_dma_delegated_chan *dchan;
+	int ret, rc = 0;
+	u32 i;
+
+	for (i = 0; i < num_chans; i++) {
+		dchan = dw_pcie_ep_find_delegated_dma_chan(ep, dir, chan_ids[i]);
+		if (!dchan) {
+			if (!rc)
+				rc = -ENOENT;
+			continue;
+		}
+
+		ret = dw_pcie_ep_dma_set_irq_mode(dchan->chan,
+						  DW_EDMA_CH_IRQ_DEFAULT);
+		if (ret && !rc)
+			rc = ret;
+
+		dma_release_channel(dchan->chan);
+		dw_pcie_ep_remove_delegated_dma_chan(ep, dchan);
+	}
+
+	return rc;
+}
+
+static int
+dw_pcie_ep_delegate_dma_channels(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				 enum pci_epc_aux_dma_dir dir,
+				 u32 req_chans, int *chan_ids, u32 max_chans)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_dma_filter filter;
+	dma_cap_mask_t dma_mask;
+	struct dma_chan *chan;
+	u32 delegated = 0;
+	u32 direction;
+	int ret;
+
+	ret = dw_pcie_ep_dma_dir_to_direction(dir, &direction);
+	if (ret)
+		return ret;
+
+	if (!pci->edma.dev)
+		return -ENODEV;
+
+	/* Limit to integrated DMA engine */
+	filter.dma_dev = pci->edma.dev;
+	filter.direction = direction;
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_SLAVE, dma_mask);
+
+	ret = -ENODEV;
+	while (delegated < req_chans && delegated < max_chans) {
+		if (ep->num_delegated_dma_chans >=
+		    ARRAY_SIZE(ep->delegated_dma_chans)) {
+			ret = -ENOSPC;
+			break;
+		}
+
+		chan = dma_request_channel(dma_mask, dw_pcie_ep_dma_filter_fn,
+					   &filter);
+		if (!chan)
+			break;
+
+		ret = dw_pcie_ep_dma_set_irq_mode(chan, DW_EDMA_CH_IRQ_REMOTE);
+		if (ret) {
+			dma_release_channel(chan);
+			goto err_release;
+		}
+
+		if (chan->chan_id < 0) {
+			dma_release_channel(chan);
+			ret = -ERANGE;
+			goto err_release;
+		}
+
+		ep->delegated_dma_chans[ep->num_delegated_dma_chans++] =
+			(struct dw_pcie_ep_dma_delegated_chan) {
+				.chan = chan,
+				.chan_id = chan->chan_id,
+				.dir = dir,
+			};
+		chan_ids[delegated++] = chan->chan_id;
+	}
+
+	return delegated ? : ret;
+
+err_release:
+	dw_pcie_ep_undelegate_dma_channels(epc, func_no, vfunc_no, dir,
+					   chan_ids, delegated);
+
+	return ret;
+}
+
 static const struct pci_epc_bar_rsvd_region *
 dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 				enum pci_epc_bar_rsvd_region_type type,
@@ -991,6 +1177,8 @@ static const struct pci_epc_ops epc_ops = {
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
 	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
+	.delegate_dma_channels = dw_pcie_ep_delegate_dma_channels,
+	.undelegate_dma_channels = dw_pcie_ep_undelegate_dma_channels,
 };
 
 /**
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 52f26663e8b1..d7d60278fbba 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -479,6 +479,12 @@ struct dw_pcie_ep_func {
 	unsigned int		num_ib_atu_indexes[PCI_STD_NUM_BARS];
 };
 
+struct dw_pcie_ep_dma_delegated_chan {
+	struct dma_chan		*chan;
+	int			chan_id;
+	u8			dir;
+};
+
 struct dw_pcie_ep {
 	struct pci_epc		*epc;
 	struct list_head	func_list;
@@ -496,6 +502,11 @@ struct dw_pcie_ep {
 	bool			msi_iatu_mapped;
 	u64			msi_msg_addr;
 	size_t			msi_map_size;
+
+	/* DMA channels reserved for peer export */
+	u8			num_delegated_dma_chans;
+	struct dw_pcie_ep_dma_delegated_chan
+				delegated_dma_chans[EDMA_MAX_WR_CH + EDMA_MAX_RD_CH];
 };
 
 struct dw_pcie_ops {
-- 
2.51.0


