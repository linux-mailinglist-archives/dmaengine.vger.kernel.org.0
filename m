Return-Path: <dmaengine+bounces-10662-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI/gISQjD2rPGAYAu9opvQ
	(envelope-from <dmaengine+bounces-10662-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:22:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 907C25A8340
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A3E33214074
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6136B3DB640;
	Thu, 21 May 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="sG8QPxwQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86803D7D86;
	Thu, 21 May 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373330; cv=fail; b=UjsoFGjVkm4OexcwhUCJVC2W4ZVIp15yyDLf7F7AIIgCQgkZ3yBotl6nqnHDF0RAp2nHO5VSU9gNKMiP22RnoH6av36GhF1RsbtP2f+LRU5NBTv0QklN+yNJ0/LUlv363Ypsim6Ql8MsoUBka86/GYpdmE/MTZWcg0tZg5M+hz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373330; c=relaxed/simple;
	bh=IfV77kaTHYhEOXohwqmCqCzmLh15+b02Y1oUYHlfndw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=joV5N7lFic5MKOsMtK3Li6eZ8UkI4jM15Hg9Pi2Lt4DbXfJkP4fDti8Yt9Ni6bGlCIyVH7IlhZQ8qKwLVzW+aNsDhYRHeC4utCeUreF8j0B634dmM/ef509h+WZPCRI5/W5LlHL4XlNknCs8JwaSDbti9pnTRJFg3HDJu3wclB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=sG8QPxwQ; arc=fail smtp.client-ip=52.101.228.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYsQBPn97dDiFkBirqwVVZkMB08abEzRGCEhrTvtc/+KlOMCmD1dKuXQASGxO7yajnjzzWQOgT7LMGMdGiQ5dj4YwfMOd3uwOqgVmvSymYjk8rarnaL2U9EWjcXFp7JGREk0WTCb71o6JA4OMJ4U2FiaP5OMVnwCThKxkkvcBoF8yylo1qCJpkZrBVRoYSi85UbgKMxLuXhMhWBzXMa5sCQNShtQeDWLEjyYnC7CZ67GYQXNgdZUvetyaXHo1ppt1Weu68VAUPCVtSsc5Lr+Z69qgwIp3uxPEhA1YlDEMlfqqhEywYeNCePk2gy1cVrH/S9cJoi8xN+j730kNFqsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Duk7u+HzWbeJV8dfD6UEQUP4J1+kwn8fFOc66vBlmhY=;
 b=e4Xjlqwj3Olm7tpfCpFprc7qNcvAoGwuYcVTj9E8GVlCX7apSFjSYTPaYFIe7V9+I23g8YfEDiJ46k++Hsfi0lzKzejU5qlrUp9i0nL0AiZLHFHUkRWk4TquHKw2Ulia6oiG56VlwoMwvu67Q7rEXSd4/2xd/Bq6EpQC5XnRoXOvj+H7MBPNPdJB8gyeENcTCHVrGejb6RKuvnCPW2NvpkYI1S3wP9Lc2oqnkFp6agOsFuIj4K7TO+Hh9aLNwT00V1BDOIs9onRTcOBmvosNrH9lBZDe+nHXo/N5pGDL6qhK54ogZ15toZmTTK1CQKPv6tdq7pdxES+FP3ADUalj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Duk7u+HzWbeJV8dfD6UEQUP4J1+kwn8fFOc66vBlmhY=;
 b=sG8QPxwQqcrUZAH1R3j0TrGj8kNzQUF0yROqMnKyLWyAkHaAmSD4gTZqE/gi+qUO/ClYXdmUsUrTvSAq4rvZV/spS2TN1inGSqDJXYMn4Y4VqCPXSD90USoqYExdzrLVP8hNjZEyneb0SkqPvMCu77CMDNN3F/iBMBejxdY0olU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6259.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:22:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 14:22:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
Date: Thu, 21 May 2026 23:21:52 +0900
Message-ID: <20260521142153.2957432-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521142153.2957432-1-den@valinux.co.jp>
References: <20260521142153.2957432-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 634aee4d-9a49-4cec-9e68-08deb7445355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hYUoyf7Ek2TPmhn9CAjS/q3noW2J9Kqk8desx6nHwhjBGxE1bK5WZsQX1V0G8ac4Q1dprgZp7NDOBXMdEEwlx05wS33/c9Kzc7VP04dNSVBadJNADLJU+2+aEd4sBGiW9c9u058O8dbz3miKDB3byWpw92Z9QKPvIUXKdqD1KkTpT1fLiDzI0kN4WC2GaofyPAyRuhUkRfsW+w8k+N8ZBqklLi1KBJ35poasmv7V6nk8xj616Zmt+dfSSgLFqg+4vSXyC+npxdly94mNvWdhahoibu3i48CB5gFEYZ8Dj6BAg0B6tssKIRnA9ZhP61Ud0Rk/6RzcT1y7+f3dfIoS+j1EACkikHDPVkAaJ6Oqsx0T+Em+IfwPPIbZCyNnMruZBjrJPUviOGndcJIUAMj+5EDv3qOt/rqPSTPnJStXkFqDh4JfbrDnQTYors7W5aTlYr0s0ffIfbCuBl0P02SINS49BbNh+SeQVCXrgkcq8QTuyviCSUM6JErJGntSKuWamhBBpfrUImW9c32b4FKO63KDxSgakKn777UsZpGDWaOMGtLX6DPDjiqwOAN3IZ8YUlFNmDDaaHNmQnN11hji1cET8bZePm1+eCX5jh5DD+uLFk7T9IE2UY6HzRKxoRwnSNMH0OyvdbwSvJNDARKmUOB93lPxWDw1v7CsJG0FILPnxrtwx73UUKPar3TwQeEV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T4YQV+w784saE/c4x1b34N0oGEkotg5whzS2E7ECoXAsfbVcv+JFbfoivOCl?=
 =?us-ascii?Q?By+Y+nj/GDPDK6yJuHu7aRATxKuNESAeIztICvx1rH+7uIqY0SbMObiD2+SY?=
 =?us-ascii?Q?TYWNIr34pvCjaUfa52vQ9xvQK3yGBnqOprs+NO7bJ1k7TVtpRpLQf0LF3J3D?=
 =?us-ascii?Q?8Un6NRAUCKbNpT75whDlj2W6fs4+80VEheXPhAf0ZngrDm3bCZ9AmQMzDBbg?=
 =?us-ascii?Q?/x8CS6e8wDfRVtqueuLm9yHw6K4lLWtEvGLGyxHhRyAhVHUuqonODx0D6K6E?=
 =?us-ascii?Q?XYX1YvvYY966KoQtm3zb6nw2Ou4YapATII8l13G7F+kgI63+qogoKL8gtkEA?=
 =?us-ascii?Q?RHpZcnenQmT1ZYapZWRl9TgxZmQELsy1NuXIsNX+gf6DqRW9VfCt59vDosCM?=
 =?us-ascii?Q?4vEebmDmJuYDgNZSqfBMDTRbBQwki4uMemPpd/biWUSB2FbL3p+LeZ5n5+bA?=
 =?us-ascii?Q?XPV/s0cZevemetBueJ6dJp44qdvFvzysV+yRgduikFygYmpCY/AWx4Sk5Cip?=
 =?us-ascii?Q?ufO7MKjM9sPDMSV/hiAcnjoUv7LEUcuRP/Dy5zq7K/JsZJC2NnNjT6QnK0Fc?=
 =?us-ascii?Q?cBpvOF/Vf20HvbwV33T1+6kiZ+JSewR/e3Ji5K0f17a1+XOEAi0A/wA4Yy2+?=
 =?us-ascii?Q?MrJsAtsabTKLgSqNGMjydc2AL23DfPxJPPq3M7yoS+XzPy2SP7DXUFBCdhq6?=
 =?us-ascii?Q?ZzeaL3daUofuvvHUDbm8+w4wa4pKE41Jfc63arxOVDn56EEWmVBAUWkFA6+2?=
 =?us-ascii?Q?nK6PScgWOn5fCGe10+1fZ041bBNgCeN3CDxAjYN15zG6QpTf+TvtOxbEM/Nv?=
 =?us-ascii?Q?ohcqbFRUSsJQaUM3pIYTsmNOVp+vwZ1zDO9fn95rAGME0/f5rJ3w55Q2RkN2?=
 =?us-ascii?Q?ZVrisTv8Blr13Tcj215n8xut+TlN3Ayp6qwVjvZDidARX2aNvUHHZe7j9Qt3?=
 =?us-ascii?Q?g9uaAzVmVi/yOPfPUAcd9S/bj8648W+l1EFenSxlSds9SgmcwNyx+anPMhu7?=
 =?us-ascii?Q?toz3XqFTdeZKGzPjTQ61Dqvx4E3qWMDNdEUJdD+Bq0na704l0mDTbKggL+4A?=
 =?us-ascii?Q?tCT+qCFNheWvuxlis3hg3iUeaZF1BM97o40PP/Qy/UUSeDkwbLk5+qSu+EoN?=
 =?us-ascii?Q?nprDOrPY2GtgWUA1vWYBL4BfxjxFI+mBNqwoaZ9xV5IyPjJs0uYqzVqWa3wu?=
 =?us-ascii?Q?4sBViDSz+MOg96SMuULttzp96gU3TGkh5Pk1xOJPWVstqTMJmY/tRCJ/hBuF?=
 =?us-ascii?Q?bfQJLQrimHW5XzhIk0hfmubhuYNq4835cV6YRi+Ymn8n0IzDUCFRF4NpMOeF?=
 =?us-ascii?Q?AjAcaLyIkaTFWs7e1gr+PgoRdnJMojvgTAkLoCbqgmn1q7GdckLWAcNPakJ8?=
 =?us-ascii?Q?rJKpoGrVete8UDsOxaUi39uqtJOExvnR4+I97cQMzEH8ih1db9nVVB1jobf6?=
 =?us-ascii?Q?UjmTXrsk+ZmZNJH1Y//uP9w1y99Qxe2BP75T3aLOSyMO42kZE7geneAI2CKN?=
 =?us-ascii?Q?h2J535kkQw85Z00j3qCP27YuImJJHaN9++rNzj23PHN4HC7e0FYov5oPSjgR?=
 =?us-ascii?Q?DXtoOwwyMVP9h96EhQiZuTbfP5IBIexbhLYOjpGHrmd8qIxdYuI+5NeQY+aX?=
 =?us-ascii?Q?bAqtO6BFWJ2zykkLJ2vrTuzc2vU5EtxRYuBDWSDmuA37AYuXLKT6OJNRp1rs?=
 =?us-ascii?Q?Gs6ift1trVfW1aJjKQP+6GJmM1kL1ofQmqr+sy2WOy1AqJCe3LMaR4l7c+SG?=
 =?us-ascii?Q?l7XyJXnyudcdli4AHCXr07XWp6iIg97N4agdAd7GERGOHE9MlIDE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 634aee4d-9a49-4cec-9e68-08deb7445355
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:22:01.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUHDwM1nIyqWh/EVL68qnZBmTYvYTk5mxtrA8P5n3qK+QRF0PSk8HaDoBON4h1pTEqBHk39of/6kW8GZ/XabGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6259
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10662-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 907C25A8340
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dw_edma_irq_request() passes struct dw_edma_irq to request_irq()
before dw_edma_channel_setup() fills the back pointer. A shared
interrupt can therefore enter the handler with dw_irq->dw still NULL,
leading to a NULL pointer dereference.

Set the back pointer before installing each handler.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79f..d221e3efcb36 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -929,7 +929,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		else
 			irq->rd_mask |= BIT(chan->id);
 
-		irq->dw = dw;
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
 
 		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
@@ -1018,6 +1017,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
 		irq = chip->ops->irq_vector(dev, 0);
+		dw->irq[0].dw = dw;
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -1043,6 +1043,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
 			irq = chip->ops->irq_vector(dev, i);
+			dw->irq[i].dw = dw;
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
-- 
2.51.0


