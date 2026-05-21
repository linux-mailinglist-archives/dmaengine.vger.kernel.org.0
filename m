Return-Path: <dmaengine+bounces-10599-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eELkJNOmDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10599-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:31:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 599DE59F6CB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A63A302A7DF
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE70395AC2;
	Thu, 21 May 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FEh68puk"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8437F8A3;
	Thu, 21 May 2026 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345088; cv=fail; b=hkPJXkOKvHCoSxOxgPQvB9ec7PXW7ABN+ez8fRZvdMAO4H3I3NZ8FzN+9o1dp+vQM/qezJVFRRpr+J7GCpg8JVfH3/HUG/ZKuMwcLNwl8AZH5KMSK7XMBSLnCmDMQ/H9Xyqg7GO53//wOJ1VUDSuceNddsxhW0DEzYXonqoxLK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345088; c=relaxed/simple;
	bh=mPd46DDpsvkorglPA79c/sO2KJ7ogqfEF70we5y36wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aXdcr4K4fSpMOEDNFdiDLL3hoOaqpXqavVKRXu/V7NDWECIcdmNMmDEzmukFCpYQGFWyzyyWYO2WVra0h6qMR9iyO0X51D3bZ0rwR4AdisC4aCMA8zHTogtqrHuZOEmd1hyCwmnu6c5Fo0j1xrj6QfHvUdeWmP4F6cZsFRqCDU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FEh68puk; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPiGmUikMzJRPYdgMFYKQFd6NZq0GqDG+PIFyEyxFu1xhwLPd22sEFL4DUWyDA1zobr9k+Ng9ycL3gNGr+P3jmloz+fOvWLHzUtVH2IxkAIOYbCQswHyspcENtOnQqDzshfZ1i1vtKvqWPv0Vch/sSx4ohooT7ct34fw3dH11Iac88pbjKkn+rT42YlEh+fNAW/xPJmwPD4pvEcmztfuIqSoZeJDIvfPuuGxKRGs5dUqrNPjn9C/OfSH5MxZxmABx+3j4gKWogUxptmFgeumYizRSqbCbk2NIuAM7rKfuEVVJFlJeAoNFoC71lyCJU8XnmHqVzWNtzj1RsUtC9ee4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bcd0jKDpDjtL9g70WPe0z0abZ4rlpfM1dxIaQbltvvI=;
 b=czKmf14fi7BN4Wq/bW5j0A8I26hgVlO8/+hZAINdXI5WZKBtnN89rWUMTqUsrhJ4yTBvKLDNG3c4pAzXmJJ31uSI9dWPtpp3+05KfgbqSmV+28tvEh/X5+edJ3XVt8z/QfWQRKZA7CMh72VNnfeF4CDFD3/mp++iU+iD4GclD4fdqT3svBeJYc5a0eY4ORqWH0kYmhutRxwbNTqGHrahQCT8/IU0iAJEtdaiD76NU3hsqaGZzMTvQJzGeGVaM8+C+OWi1H3oPdpXbYHXgPrrJ7wfaJ6BK1ULTMLSwLmqOG+yfid2mGKuMvy7NPN8PHrupWZP3TwybCzscUbPY8PExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bcd0jKDpDjtL9g70WPe0z0abZ4rlpfM1dxIaQbltvvI=;
 b=FEh68pukvO3ew84JQKugcDByhb4ovVdc03voWn64ZIUJg6rGsKdjFAq5UaCAYvmZcw3UOETklrxyV/XqIiLOfyTEmdRccuhNLL8kq7OfBGAkqNi2M5JugFNIlPPg6dyyd5afvwHLiLH0OYLz0hbZ7ejj4bIUcz+YETslOrcnmNY=
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
Subject: [PATCH 03/12] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Thu, 21 May 2026 15:31:06 +0900
Message-ID: <20260521063115.2842238-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ee133e-d3ef-42e6-21c0-08deb7029321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003|6133799003|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	9WEoFkG1/HINLdUh5K0cibtenhEU+vdzdlc8hC+FEhlpDy+2MaXbEMpmolkU/ibhAtCrjQuneIiRdTY27zkEwQv9KRvaP+B0lmhESAxyzVXLpTjKOjWgQDfjrfE7HowrRt7degH88cECvZRea/MiAGQyID6siOv3aKN4/GpjjYMC53NLaiDmG9azEVAqL4z0iM0cAC95G01eEJB+73A50vrY4l7uHKY9nJQmLI5BYhy1jdz5ozht6YoUSzf8n8lw+NytKltEhfL28xSTeuAIMz6DVGerDa2Jy2ksPmMwrRylzEzMt+GwXHDtFyOlVigHgOhELR2h+CHdMBU5oI582+lRLsFNermfF5srQMpQPfa59zztYRBxI+0BikN7uh2sFLTbpO4NB14xdztNuMhNhZzhiDwxopHe7fQYQRrhBE5Ni5WGFFlvjhZ8nfJ56dfmq2ABo3uQdYcH1ubvD8zAZTunYDGRxGspG+TOeJ32sP1s/00bh7sJQ3qOIP+JCaERzFzQoD88tH4UWrLt4ntiD/gK/sIFAY3hP677mH5qBX/pTHIMo0o14Zch35NuXTATrfqINd0tkJOdFlGRPEZeTzuTk2V/c/rCb4qM3Bmgt7zepowgHPRg+DoUUsjLLCjwlJxPiLQFt289e5CKkRx/AxvyqrwzZ4J2rdebXucBk/Yz6P/WxLKNF9LeGdUktKRt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(5023799004)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QEKFl+0KaRoZWz82ngQnMhQgIXm0FjH7Os9fgrNE7gCkra9ztZMell+C2Buq?=
 =?us-ascii?Q?RH+KTGmlOSltu3z+HNWEMVUXY1QauKc3aXnzSXspFQwYAl10dkUGTnAdppDA?=
 =?us-ascii?Q?jQTX7PhEq8bZEMwT9eIMUTC9F2Ts3fJfKFgt5zbRlotNelEUdRl0w7oMEz23?=
 =?us-ascii?Q?RvMCZ9WL3U6p/7h0fYWbIfTtyl6XbgrTAubv2Vij0nA+jP+IsL5MA3rQ6/Qb?=
 =?us-ascii?Q?jtDyTX+7YLR2/d03UG1urfyA47cXOaLhurBlk8l3/D+WyeDLJJ+TNFQd+58q?=
 =?us-ascii?Q?kyqqrZDXq0UHOcxJzWea/6ERC2L59BNLsyTyW+U0zXM4xW+pWxiTNEX8JEBZ?=
 =?us-ascii?Q?N84mPymmVd8fuXD7OKgjb14qRFySZuJZAeNitdlNkZUbCNkQAlhuXLWg3OKP?=
 =?us-ascii?Q?zWRiP11yaKiaX20ljYm00M5FrAKzoeV38x/1+Z5qL+up6Ef46AWW+cW4DA7V?=
 =?us-ascii?Q?+k09+IwBn2dVOeXv/FbEDt4PRkiMn4Rnm702BSe1jHyJCGhTNidz2pNYRNnY?=
 =?us-ascii?Q?UyAqgqiEL+1cNpJPawRanbvHHLKsImFlO0RvORLWpQ6unxOWD1o18tNh2TpO?=
 =?us-ascii?Q?zF1A7OJChMiEKznRlQaQLdcE9+72D0GUHnww1keVGNuzZqm55GUrWp8wCDKe?=
 =?us-ascii?Q?cAyznvyVu2J9wuVsregjCYp4avv1kRZ8t9N09iwWjucV1jkbLZrayiyzabeH?=
 =?us-ascii?Q?UHjoBUFOD/SF/aInId1ebe4Iy2IDoODpnoYBaSUFIcT/UIIxA3fARIxrbwdd?=
 =?us-ascii?Q?E94/EBQIAcldd9yq9+VICYETISLBkt3M7+1QfodNY8ic6QihT25hGolpFY/k?=
 =?us-ascii?Q?qpi55iVWbUTNL9YHAFRUrGpf2tSZd8hM31lW6g0D7lY2SoLVfG/BL4dzHzfT?=
 =?us-ascii?Q?pI3O/tLAg259qnEfuLR+DRqe7UOT0pHSwms+l4ou1+8uT+eCFZtI9tEHGE2l?=
 =?us-ascii?Q?D5jfvB1zvExVxDBkGaKzrPEnXXd4RCHHjHqTTc3jEr/0WKJNniArXsiTRqPr?=
 =?us-ascii?Q?3fQWZi+eD3naKem1Om3vULetFBUbiRYjmsJMZhlkkpLjzb/yqC0ybCvW9cEh?=
 =?us-ascii?Q?p5ns/fBbTyMirSo9Df6tlJhGHSeIkrhFedPqYPIr6QfEucn6FB9TLOzb8HP4?=
 =?us-ascii?Q?JThkWq1MsrmOVeaN/gAzEJt+1ArofWkVA5l/dpIeylUMMfAUsFjWDNXKNclz?=
 =?us-ascii?Q?5vUck0k89lTtOetjJMO0qTozojyiVhxpOXmlqqq8AW9ZqEqjUs8scGJPV886?=
 =?us-ascii?Q?trNCy8sSmB++Oc/bsFPto7HfsjVYXQrB4uXBOLtD7LuVJeJcYHqLptbQHP0X?=
 =?us-ascii?Q?haD3lylDxyjTIy2+6yX6ti4kWvrE9VVVcbYaNrD3UBmIqxESnb3Z4ImN6V2Q?=
 =?us-ascii?Q?CNMtHEvakq02GzlhgoNaz66VxI/WJb6qPbkKpAV8Ecv2X9vCNKRQkE56VtOS?=
 =?us-ascii?Q?Tqvp/6DmWfphhEcVqTBpYbgBlSJQHWZEDGAiRs0A1UFWK4nZr0eiyis+AdtV?=
 =?us-ascii?Q?U3rwH36SMcDefbZ1f+eSkjJLs37Yqw1QT3DXq5aA0HPldr1rzTe0G0z5aA0V?=
 =?us-ascii?Q?WlsE4xktPWTHQhympvsvgDhEpx4d4dGUuEt33j+fVDOIvhiXtYh+5lb44lw0?=
 =?us-ascii?Q?tSzkVp/8Jm0atJNz8n5x9aiiaWosQnH0E/RyBMGls8CFuX4lTYiBJG3JtNBR?=
 =?us-ascii?Q?LIcNw34XstaY5feOpswGIsQKSNm/wiVm7NdmXFNChpTCR1erZxqQZxcyHsk1?=
 =?us-ascii?Q?UaBCaniR8WH1soOmzOkHqYvPtJD6ld2m6nzeUL1nWSMVysWc70Rf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ee133e-d3ef-42e6-21c0-08deb7029321
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:22.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CIZBvkZNfa4Wh6TLOb7jiTycxAGsFBv2qb6gVKCQUfdRtDyMY24ZWHhRodsKE+ydfdDukCjY/o+mGlRp31ZyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10599-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 599DE59F6CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DesignWare endpoint eDMA can signal completion both locally and remotely
through LIE/RIE. A remotely controlled channel needs a per-channel
policy for whether completions are handled locally, remotely, or both.
Otherwise, the endpoint and host can race to acknowledge the interrupt.

Add dw_edma_peripheral_config, carried through dma_slave_config, to let
a frontend select the interrupt routing mode for each channel. Update
the v0 programming path so linked-list interrupt generation and
DONE/ABORT masking follow the selected mode. If a frontend does nothing,
the default keeps the existing behavior.

HDMA native already uses dma_slave_config.peripheral_config for non-LL
mode selection. Keep that ABI unchanged and do not interpret the new IRQ
routing config on HDMA native until that routing model has been
implemented and validated.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 59 +++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    | 13 ++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 26 ++++++++----
 include/linux/dma/edma.h              | 38 +++++++++++++++++
 4 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 6660380a1bbc..72dc8a60798a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -219,12 +219,56 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
 	}
 }
 
+static enum dw_edma_ch_irq_mode
+dw_edma_get_default_irq_mode(struct dw_edma_chan *chan)
+{
+	switch (chan->dw->chip->default_irq_mode) {
+	case DW_EDMA_CH_IRQ_DEFAULT:
+	case DW_EDMA_CH_IRQ_LOCAL:
+	case DW_EDMA_CH_IRQ_REMOTE:
+		return chan->dw->chip->default_irq_mode;
+	default:
+		return DW_EDMA_CH_IRQ_DEFAULT;
+	}
+}
+
+static int dw_edma_parse_irq_mode(struct dw_edma_chan *chan,
+				  const struct dma_slave_config *config,
+				  enum dw_edma_ch_irq_mode *mode)
+{
+	const struct dw_edma_peripheral_config *pcfg;
+
+	/* peripheral_config is optional, fall back to the frontend default. */
+	*mode = dw_edma_get_default_irq_mode(chan);
+	if (!config || !config->peripheral_config)
+		return 0;
+
+	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
+		return -EOPNOTSUPP;
+
+	if (config->peripheral_size < sizeof(*pcfg))
+		return -EINVAL;
+
+	pcfg = config->peripheral_config;
+	switch (pcfg->irq_mode) {
+	case DW_EDMA_CH_IRQ_DEFAULT:
+	case DW_EDMA_CH_IRQ_LOCAL:
+	case DW_EDMA_CH_IRQ_REMOTE:
+		*mode = pcfg->irq_mode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	enum dw_edma_ch_irq_mode mode;
 	bool cfg_non_ll;
 	int non_ll = 0;
+	int ret;
 
 	chan->non_ll = false;
 	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
@@ -255,10 +299,11 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 
 		if (cfg_non_ll || non_ll)
 			chan->non_ll = true;
-	} else if (config->peripheral_config) {
-		dev_err(dchan->device->dev,
-			"peripheral config param applicable only for HDMA\n");
-		return -EINVAL;
+	} else {
+		ret = dw_edma_parse_irq_mode(chan, config, &mode);
+		if (ret)
+			return ret;
+		chan->irq_mode = mode;
 	}
 
 	memcpy(&chan->config, config, sizeof(*config));
@@ -853,11 +898,14 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
+	chan->irq_mode = dw_edma_get_default_irq_mode(chan);
+
 	return 0;
 }
 
 static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 {
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
 	int ret;
 
@@ -871,6 +919,8 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 
 		cpu_relax();
 	}
+
+	chan->irq_mode = dw_edma_get_default_irq_mode(chan);
 }
 
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
@@ -904,6 +954,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 902574b1ba86..e2aadf0109b6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
@@ -224,4 +226,15 @@ dw_edma_core_db_offset(struct dw_edma *dw)
 	return dw->core->db_offset(dw);
 }
 
+static inline bool
+dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 69e8279adec8..2e95da0d6fc2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_done_int(chan);
-		done(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_done_int(chan);
+			done(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_abort_int(chan);
-		abort(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_abort_int(chan);
+			abort(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index b4b42b2278f3..9ea7b24b5015 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,41 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/**
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_DEFAULT:   keep legacy behavior
+ * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
+ * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI),
+ *                            while masking local DONE/ABORT output.
+ *
+ * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
+ * bus, and remotely using posted memory writes (IMWr) that may be
+ * interpreted as MSI/MSI-X by the RC.
+ *
+ * For the v0 eDMA programming path, DMA_*_INT_MASK gates the local edma_int[]
+ * assertion, while there is no dedicated per-channel mask for IMWr generation.
+ * To request a remote-only interrupt, Synopsys recommends setting both LIE and
+ * RIE, and masking the local interrupt in DMA_*_INT_MASK (rather than relying
+ * on LIE=0/RIE=1). See the DesignWare endpoint databook 5.40a, Non Linked
+ * List Mode interrupt handling ("Hint").
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_DEFAULT	= 0,
+	DW_EDMA_CH_IRQ_LOCAL,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
+/**
+ * struct dw_edma_peripheral_config - dw-edma specific slave configuration
+ * @irq_mode: per-channel interrupt routing control.
+ *
+ * Pass this structure via dma_slave_config.peripheral_config and
+ * dma_slave_config.peripheral_size.
+ */
+struct dw_edma_peripheral_config {
+	enum dw_edma_ch_irq_mode irq_mode;
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -76,6 +111,8 @@ enum dw_edma_chip_flags {
  * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
  * @db_offset:		 Offset from DMA register base
  * @mf:			 DMA register map format
+ * @default_irq_mode:	 default per-channel interrupt routing when client
+ *			 does not supply dw_edma_peripheral_config
  * @dw:			 struct dw_edma that is filled by dw_edma_probe()
  */
 struct dw_edma_chip {
@@ -101,6 +138,7 @@ struct dw_edma_chip {
 	resource_size_t		db_offset;
 
 	enum dw_edma_map_format	mf;
+	enum dw_edma_ch_irq_mode	default_irq_mode;
 
 	struct dw_edma		*dw;
 	bool			cfg_non_ll;
-- 
2.51.0


