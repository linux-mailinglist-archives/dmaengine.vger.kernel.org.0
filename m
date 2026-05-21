Return-Path: <dmaengine+bounces-10604-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDbsNvSmDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10604-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:32:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBAD59F6FF
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E263302CE61
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD23976B8;
	Thu, 21 May 2026 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="I33xQxM1"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020111.outbound.protection.outlook.com [52.101.228.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7DA392C46;
	Thu, 21 May 2026 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345093; cv=fail; b=k2dqjzFtnxl1z6S3dlMI/63Cgn8TBYkNB10VL1mgyftj/qKWcr150WBC58504T5jnPzJ+Jlxq3Yf/ZbZPYk29zj8XuW2qdkGuC5UIxmQu8QroI7sh/eTZASmHYza1xcwARLEmOvAGW/ruSjtyt5PZXA7SGTTzgnHA+NH3jX5Y4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345093; c=relaxed/simple;
	bh=tBa2qyMdCfj6ub+DhO3XEZxih0CIz2hOuB3NK8hq+Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jl5Vs5LBW+nXlVVjMm3azXxy6vodDz/DH3jV2u8SVuiKJcPAUVIt71frAALby0cFD05/V0fgWqcaeAnKTJueCc3SkHtb3WpwVe92z5O1LJI9Wim2bS2IQWrMllU+1pBtpkEmf4Oxf6yI9Bt2Qa0XqyZD+d9wV6LGOVQeHh2sFMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=I33xQxM1; arc=fail smtp.client-ip=52.101.228.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fskVSyWTSVhyQDLMltdZlthAlkr7gfpIsZ7iDGPCbOvBrxCDKg6Xbh2Hcdcjzuw616AY2/tMl4+IR9gkQd1Jt6bzC7Dnan1Q6Tk4E/J/WKEj9mbgQABIO6cPyyAgGtBQkvOVCLqK6svlZZOi2x7e40vdaVVSAI5AjufZHxauU1FBRejMgLQ+F9T5v4twcu9Cu9vNLxLr1fEsWFnRElsIEdhzqfkRThhZnlRL7s7Cfanl93P2QQfCxbjxnWMd6/jJQoSuCn2CHnonKEY4yAojfHWVEBxYWBZrqqHSZdZ+kWMJv3nYrQfTjoY+lLJph5b+wFbKFjb0QcUjlsqgEg+Wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpFxaALFxMRB5HZtwVXMU3m7p/pmra8X3mIHpVS6KAk=;
 b=e9+6bW4S55s2+uVQUYxmUqBC4aJAebl4T/YbUTR71iu0dlfsMzw4kLdDQq5yKufNuQspB0qZ+KUWwjGOrK5gT5hTmbeDMsrahdIPNzSDwqyBy9B+gaXIufQkK14xTasdS84FOMh8183GGdLzFSg9CaFkfE1Kpr7FN3HCuLuuP35kJfuh3d2d4kzw2xxZE0ILN8DeDk65amFDiZNRaBXRMiyoG67xpDpvY9U4UuIL53A6hfdhbCpngB1sPZlhkyZQZXC54ySoxmk1xe4B5AO7oLFTXUXhMJW/UOQ5X20rJWkGX+F5419YaGXhVxfK78/U6DlAUUi9YtlvzWRq1xgj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpFxaALFxMRB5HZtwVXMU3m7p/pmra8X3mIHpVS6KAk=;
 b=I33xQxM1rXEbhl9ergXhTt1qmN2eLHh22r3bJxkq2HTHRw1A7csp04HVKWZ+N9KKz4P8NYdAwLqCALK4WeLFsws2rL1hPBWVtKwaOd7wISHgSdoU+vxIXXPnCjgcqP+YSJiXBeej+elEfUG0xZnq5qH73+ZnzrjAGrOC5OPOXF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6817.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:322::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:31:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:28 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] dmaengine: dw-edma-pcie: Handle optional data blocks
Date: Thu, 21 May 2026 15:31:14 +0900
Message-ID: <20260521063115.2842238-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0151.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: aa94f204-975d-4837-21eb-08deb702971b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|18002099003|56012099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	+K5m2K+NosZpwFVqbFtfFDTaxcGmvAK9Ek0jTipibdrImD/DsUSFzN8Wzsfw4azkKx+yavV5I5KvmhQrvWqrB0PK1V19l6cURQwwmKW+yup2u0S47rD8Id9sZgoI00SsF12L4kkTs0iOT1dkcM0QvFSKiLQFwM7qrF0pSXoGFddZg4IENenX8ZhhA/wUaBzOenumIOlVYRevISVbpVLXGAw3RN0/1NWJfyrz3TlJB3C2yDB5AAUNTbei4sfERzFUtgZyFWhGOeRi4B/gXnWfS8Jj43YsJRxVza8uXDTLX1G3myzZmCKREKHCp2+agLKOFOQ+H6QdWvE/xVJd3RZCFn27Ou3b0jwhilCG1bBEvFWw7a7Xg2EPy+rT3mKcliSYZDN0fyAYSRg60Cg0gtu4bVH7wqFZU+zQ+HGuqN0dvhozqY30yf0bIIou6qYAIwOpk4XvgDyX2O/0C+vnyxMwHAKULVIVtEhzixk4wNDMebLnqa38Bw11kCcTOj3WJYU28lHJ9aYpqyvZp/aF0r7SOjuupQF248VSJwOkFiEoiWU7pj1EaPgNPAFDnZqZKx0G9gBuAeXy8ogA0WAf+5D7LLRFJBQOny/nGSldhZuAOHXTAZD1fBKD6fW1Qu9L+y72Sj1HHIy2jxsWFCvXWW98BXrvYmTAdeH6TNOaczPgltSp+5MpvwMKe+B/tNkp8knd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vqN1g1ypmoXTyoO2aXUely5DyGV9Ie2VoUGtb5cd4FV+yparI9XYrGODZ8el?=
 =?us-ascii?Q?AlhVoKXYNmf1Dofu5G1aNb2OlWxn9KxgaqMR5b4JuYw16P0mkc736kdfp9Ot?=
 =?us-ascii?Q?nfdzCjM76IoN/jquJaJYuiaKyFduG9O/07DLhVLnuQIJMkYmLIJicVxT8Mgv?=
 =?us-ascii?Q?kE1KEGiS9u/NfaDkouIrG4P8r4lfjulGhSNS+1JvGa/JhE7jdTPbPPk/Hn+C?=
 =?us-ascii?Q?mLUO2l5Ap8nIKAFnvyUssr3OhCcay6RRo/G3KRRplaaxH2nLwpUZSSB3WUCo?=
 =?us-ascii?Q?8vq78iNNf2/zqGudwJgvbodfkN2wMq6hd1bC8QFZbxUN3JKKPFEe7iIQSpFK?=
 =?us-ascii?Q?bXrp8cSZGZfg8UnhBGEzh2xBR3mOy61tPNiFhUhNZuiP2XGO9z+mSHCvpJDB?=
 =?us-ascii?Q?nN5keYsl515XydWBoOPv9yFGXyaR05xv4yM9WxnyJxvwb17Q3/glN/K4RO2W?=
 =?us-ascii?Q?kFklFF7IMzIRihYXtF4aJcbxPobfK49qsOxhC9sFKXJM+5aAwzpEyIDSzyGk?=
 =?us-ascii?Q?TL9AU1M+jAxOEhy1PoFPPP0syNPyqQIcc1tcYQDPAwJl0xXnZjDc+lDTltew?=
 =?us-ascii?Q?Jb396Jt01GC2R6nW/Ypdz/dhGj/SAZks4/cY1YVNeowofwSOHc50hqkz7RBA?=
 =?us-ascii?Q?s8qNiwMqA+rSExOxAlMbpd73kuIUNLYuygFIUoyTPEojhexPnlglDTKccGVN?=
 =?us-ascii?Q?HynKgfYbG3xUSz/fBxFQLs09BkJNjlq09YAbqs0/QIFb8SvvAMPOmHhD8PtW?=
 =?us-ascii?Q?rPNRlS+7ck/dGzRukXf16Hsd7H/tGJDZSTFjLMLraNNEaPMCSu8MYF1jH/UU?=
 =?us-ascii?Q?d5eRWUY+HOBxlnO8JSNsJOy2L7GtQ5W+euWIXR+gm0XqndT2VaO1kWeDUnkd?=
 =?us-ascii?Q?CXA2spWwXWlhw/NBR9TOeW+j85NhBhbGCL9x/Eq0xr32L6Yr/ntKDrFhqKQX?=
 =?us-ascii?Q?LNZ4yAonhOVYU01qiq45IbX60R3vOJEFPNSlaCBdE6Ym9Ja1NvifzVK8S3pj?=
 =?us-ascii?Q?fwaJH3PEXNcQbP7eoNP/EuRw/ZthNPR8iN86h4HYZfI3UMUGagY+fW7E/ikS?=
 =?us-ascii?Q?Gf8HCcV5BrGF2KMy0JG9uxNhXTzV7IRNnpIeKrPG6fBnqfSmnuv1K2HJswu9?=
 =?us-ascii?Q?1ROIzV5tKbw3FoHA5xz56NEKC7ZUJzS4C+JtbQIXJkAQyNfdtkmBdKIJAOM3?=
 =?us-ascii?Q?B+FIq4/CO7Z1ql8vuo0FdIgwMo7XCbCbBAp56LQYMxB7+zGpY5gdUlTmBSZl?=
 =?us-ascii?Q?0aDxnK0l/uzXzRBrB8O3ggu1Ee65smElKXvrlNKPkWtbbsmpjlG0JvC+q7Rz?=
 =?us-ascii?Q?OLJ73SyH9X6DDm7zJu6VRHqLKvXRWbW7kzdiw2ALc+FK4Ovf3KqBifOFTCjB?=
 =?us-ascii?Q?9r0gypcgHVQkUbSHCxzliKpuDZ48BgQ6EhOKe0EQCr7IhEe4cdAEwg8/nXXF?=
 =?us-ascii?Q?6duDQxy8yvRdzuh0Fx/Zq7vLdJy5VoOyh5yOdN7ngwJN2/lXz53aEDDyyi4A?=
 =?us-ascii?Q?kPDJpk4mkNA6TiKUByxuYo0KFj1YUN/Wxt/BOSYhXHeZiHTEeHcCW2sKWz6K?=
 =?us-ascii?Q?PdkNrePukhqH3ooQ4okz4OeH6v06f3CN/RdB6sdikJwyWUB7eD6jo2jL1F56?=
 =?us-ascii?Q?koCto/ncqd34Fvr5CQEzF8jiO6SREQ6BLtb5RPPPjgjf2lc1tvwpxUdkNG84?=
 =?us-ascii?Q?d/o6b5FqiaO1l8g8Ff6NsTHcRdeflhTMwIpj8+EcPsujx8BucQWljKE0fyWb?=
 =?us-ascii?Q?thuubKWHr+Llk2Fh10yH3YKkVqclgVejTJR3ciCdSlygokgKX1pi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aa94f204-975d-4837-21eb-08deb702971b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:28.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVv+bjAGIrf+VlzVPPSXZdFg+iO8mISP9uTr1f3w2DZT5J+Q22/Dkq2maNT3xB2v6sjewq/ncJioGtlDhTH5yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6817
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
	TAGGED_FROM(0.00)[bounces-10604-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7FBAD59F6FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Skip data block BAR mapping and debug output when a channel has no data
block size. This lets future providers describe channels that only need
descriptor memory exposed.

No functional change intended for existing EDDA and MDB devices. Their
static channel descriptions still provide data block sizes where data
block windows are used. A zero-sized data block now means "not present"
for future metadata providers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2a95fb9d5fc3..df02b244e748 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -414,11 +414,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	mask = BIT(dma_data->rg.bar);
 	for (i = 0; i < dma_data->wr_ch_cnt; i++) {
 		mask |= BIT(dma_data->ll_wr[i].bar);
-		mask |= BIT(dma_data->dt_wr[i].bar);
+		if (dma_data->dt_wr[i].sz)
+			mask |= BIT(dma_data->dt_wr[i].bar);
 	}
 	for (i = 0; i < dma_data->rd_ch_cnt; i++) {
 		mask |= BIT(dma_data->ll_rd[i].bar);
-		mask |= BIT(dma_data->dt_rd[i].bar);
+		if (dma_data->dt_rd[i].sz)
+			mask |= BIT(dma_data->dt_rd[i].bar);
 	}
 	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
 	if (err) {
@@ -483,6 +485,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 							  ll_block);
 		ll_region->sz = ll_block->sz;
 
+		if (!dt_block->sz)
+			continue;
+
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
 		if (!dt_region->vaddr.io)
 			return -ENOMEM;
@@ -508,6 +513,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 							  ll_block);
 		ll_region->sz = ll_block->sz;
 
+		if (!dt_block->sz)
+			continue;
+
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
 		if (!dt_region->vaddr.io)
 			return -ENOMEM;
@@ -541,10 +549,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			dma_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
 			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
 
+		if (!dma_data->dt_wr[i].sz)
+			continue;
+
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, dma_data->dt_wr[i].bar,
 			dma_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
-			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
+			chip->dt_region_wr[i].vaddr.io,
+			&chip->dt_region_wr[i].paddr);
 	}
 
 	for (i = 0; i < chip->ll_rd_cnt; i++) {
@@ -553,10 +565,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			dma_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
 			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
 
+		if (!dma_data->dt_rd[i].sz)
+			continue;
+
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, dma_data->dt_rd[i].bar,
 			dma_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
-			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
+			chip->dt_region_rd[i].vaddr.io,
+			&chip->dt_region_rd[i].paddr);
 	}
 
 	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
-- 
2.51.0


