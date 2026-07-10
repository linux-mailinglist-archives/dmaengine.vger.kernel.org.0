Return-Path: <dmaengine+bounces-12286-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id spCxOtOqUGp/3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12286-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:18:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC607385B8
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:18:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=bNGU+tVJ;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12286-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12286-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D55A3025886
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2F3EEAF9;
	Fri, 10 Jul 2026 08:15:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503053EFFC7;
	Fri, 10 Jul 2026 08:15:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671338; cv=fail; b=nCpRgOe0BjpChucr0uggBhq9uStQacks42FyBBF9ZB0r2DPlNvRiDuZolmAchXt4HHYUjBZvOr+1tzQBlNT1gPdYqiqpmWFk/hgtzoPPd0IN8jEGq8q8fDf3zbUQYxgP7CZLprkhITz2/DPBmTfh0Qqwp7gtcvbrQB/HSlzE/mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671338; c=relaxed/simple;
	bh=ehdL/epgviMIfAgSOm6H8ZVAZr8fvD6dhdL6tVF9dfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q1+VL6WbcF8nRjCITul8OToWXkMixbGLg1bZh+gApYSnrIXloZtg/fyRf+QHizIpf2+UE0jJ224eLN6TEUjyA7pPZa875PBJBJgJz6MgWIOR7wUrqtsWXAiSI61n4XGrnmGbO1yjS5iVdt9J7plJ0Oe2eUq4YCMwX6h1gVXqkB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bNGU+tVJ; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKBTwpXaHhX2tgbpaqzYZswrRj4oSVhL7R5/o+YGVBIv0A2Dp2yPTdn0a/WjRKuAO9mCekvNYOjtRmZbE2xIqgegJZX+v963D7IrQj/iOfZv9btXn1NXOMeGbj3g4XfOxnFY04K1WH502LSkHxjSBHVSERPHqu3Jv/6VUlW761sb5hAEaKhfFHddX/nLJzMgwxZ3SxzylD8ZqiNv6Zxr5F45UxjngnrahWoG9ITzGXvaX8Br9aasrRh6sWLgKbucyPGKqNpJudtGPF+UQpliNg1Rjz99N+eGikT1kmCNSOl+Z8zKU8ftsOFSgwI/u01KwO0d3jHhfeRd4y3VAOuz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TB7xHegX3arrokMwyfvY579x40bqxOfIFXIj7/Uskhw=;
 b=FMpO8GMfFEA8prklXqaP9c3PXTF118+TMMgmOZDBOHRA07MYtX2O442im2xnIvwtGLY4wzIGVbLUZjcgMsRZNoT2Hm+ey9h4pRCTeOA3H3ULaAhfme/Stshd0Bn9yJRRrrGNkIK20lpY3kJi4W1Vmd/JEXKR0mBIopitf0Fw8UP6kW3O3J/Uczwo9pwgTeJ5jFBiQEZBUNNV+TlQiBn15LbKH14rZt/knryIzhRgS7YLtiOrNGVmqd+/6QHb6DDtfiKm+uhoxreJW4u6JOb7RkH7FUcunRmdH5x2dESfaeGWQeUdRr92CEjNVHoQiuMGgqZ8Bey7/JHqJuyZhOQ9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TB7xHegX3arrokMwyfvY579x40bqxOfIFXIj7/Uskhw=;
 b=bNGU+tVJKMK9aoBn32HNBt3BWG7KkNTNptzAqH8HgWW41vGPju7uychE1qv2I5BT4y9rYieB4u9nzfTVQxWeDBatgm0mZaD4E0pOuEKMGDK4SedgsXMVvPCLb64R7hclSDwBgXaK8E47vM6p4N0oZiq7EXrJp87SdDj97j+mAe8=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/14] dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
Date: Fri, 10 Jul 2026 17:15:08 +0900
Message-ID: <20260710081518.2394357-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0089.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 171e8bdf-1aba-4ad1-9bbf-08dede5b6443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YaWPfztWjlOh2HwmnftRMuD9Lp3MiWT+q73vCg/eCeasiECUGnzMttQMyK25mKAKpfX2Z5eFJJo11TupWaXS6uoDQ9RrCey9RDNR/7H3g1YOtvUZT1VAB+/HZ7sReQEip8nT8wqHKDFZPo/FbiqHWHK2xshGKuLo81UTDDQXxaBc/O+xmTifZ34Gly7Puw4gQym9PEaXm8N07gaZdNOlGTS5m4CRlp2qWuMxDfKhWOXqpCtAnXwnFSnmt6JK81/qzllOZqV/87dI0ZDTk2SXSbdBnCj2ShWF+I4mI4ygXrVuH7Z51tRKd6nskDjKicF1UZP2aUDBdZICTZyXsJ7QJJXQ0J9cQKtVlklUO35ogmtFdsNErkZiCJiPNbWhTzH8cLw8tjt720PACVQ7oLsx43Ng8uerXekRDJhTCktHtKd3qRogmlhlqPg/CMCnaJ+53trun6q2sxs8qo1DFgDBUw6Pw/MzjaVubGTrQnfT7DOBRpY4/sh1HJRW3CNNFD0s9n45mRVL23140fvTHn6XhRycnTlz58f6Ltfmuap6q2/PaKfLUHXTv5ibNLA0xsyF1eg+pphhou+/r1Dq6+8M9DeD/QnnkB+OuCrzbbS0kS30p4t8yuQ+JMNjSm1o09wWiqYsGci2WUfMTd3+imN694B3j5e6X23NyauhO7wuvjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3VHxNYkVSmbDZQSb/eS0DSZPsDdDQzjmtzNJb6Go0TZ12eZ2fkCkIfuWM+rK?=
 =?us-ascii?Q?z2AOqb2jHJoJKlCuR3Hl3mEFEt7TU8Ay0RxooxODqRGdYFHtjP3C0bqfHP67?=
 =?us-ascii?Q?YpF7B9q0PrTcxLZpJFHb7eFXk8PvI6+dTNV9HNiKGQYe6Z+e4w0tMgOCs6sX?=
 =?us-ascii?Q?EIhrUOl7oeLdhR91S2W0Cycp6K70sofNaSx97engTYshHWkavYnIdIq7q4dh?=
 =?us-ascii?Q?z+4KSuCZVMznlDZAq3cL0UdD0+Jnm701PmjrTg6F3zX4reAsdoQ1nHkBML0N?=
 =?us-ascii?Q?As1DC9IDmG8le21gl9IVgC/7OEUTSZmnYL2rMVwhDLs2ICYCLpIqjSETUYjV?=
 =?us-ascii?Q?TEE04ga7lp8frWuSKR38HOQ1+DZlTJeknQ2lltXb9f15vqG0TkxfWVWm0Ojj?=
 =?us-ascii?Q?/W5mzM+cF70rDcwpvhEMxnh3NiOh5gCUOy0hzpPZ6PpDe9L54vlR5IC9a1bJ?=
 =?us-ascii?Q?lXoZ2yvKYd5Q9Sig6211cb18L0uslE/v89Pv53I+E/Aq2V4tf+VMjwpvsDio?=
 =?us-ascii?Q?u9UIwdSasgLk+WhuTm9uCqrbtlGIXFAyN4eTUKq5QdHvxSAYOBDOKS0KrhzL?=
 =?us-ascii?Q?IAMuTbZdXPnRjjpe/N3Ua0Bmxz1Ng96FECcoMnd5UCYS5fuW4uY3NP/YwPnK?=
 =?us-ascii?Q?+ZCNlOX6HMZaxaBWkX1YXInb2b3pnouYjeoghcocuvx8jXF+iuuuW59pp6Zc?=
 =?us-ascii?Q?3hd/a/T7+lEd/HFL7MPDc3BhgZj88ql5Gk+uIcAcWu0YID5nDurANSKarYBg?=
 =?us-ascii?Q?mqzvkEUjjfzyNN/ZBf0pezSKuQGsfy8xVMBJ4ZeMZhIKlhyV87SoHGoJ47jg?=
 =?us-ascii?Q?xE45z5cjEWXhuPxOPm2lMnTxpnYekH2EuDHU6ZLtR6T3rb4qqwSZVP15KCKx?=
 =?us-ascii?Q?IwflR3Bi6HzquS/9sv75e2Kv5We2UsZQ/IG+eCvCv1+xRszL4bage1O7GCxG?=
 =?us-ascii?Q?eqngUD0+VrjQbGOHuHentapy4YajZ+llfm0E39rydLZMXKqqYPE7J0fKtt0f?=
 =?us-ascii?Q?/CtmLRJhK4gAMkEv6HY+6lixhucf218Kn5PRvJMr73sj9za2Iqt3gDUXT+zH?=
 =?us-ascii?Q?5wJz7X4WkaeWeFmN9ja5zqP5fWWsuDdt7gC3fFrx735cODyhXDCTMRAuNM39?=
 =?us-ascii?Q?lEJw5EZN3PlMjB0NM2Ibw82tFue5/OzZhBHhsWvrbVrbgfKVrnhW66AAfDP+?=
 =?us-ascii?Q?0Oj7QUfnMPCPbJ/DgtbjM/xmbMFZ+btp5Wilyn/yx+CuYkHFT8YVngx/sPX8?=
 =?us-ascii?Q?zNtC5JSZl7WA8fKG2lGHs+2HTnHjpb/xPqfDEdDNEuKKW7ex7+2gzDghZKcf?=
 =?us-ascii?Q?R0ZHFCr8d2g11PHSTTJJlWB1/Ny1wZs2ipTZNjwGE5El+gGYdOiBlGZfJ9aY?=
 =?us-ascii?Q?IyT02e7K4VayL+Fjpi3mVi1IKE9KfD+tUq2XKCt7yQRrcmTNXxxp/XofPB+N?=
 =?us-ascii?Q?B4mz/418CkKuPoXRKU4zutEXQAchcLSBplcK9MhWz1e3zL89QMhbt5dGInuC?=
 =?us-ascii?Q?jR155t/NuaHC5yP8zsRy/EPrXxn+5F+xZr1eaNoH4zYkPnmRWDgL8vS/dc+9?=
 =?us-ascii?Q?Y8T6WNmcOQtas2mNb/kFUnObc22rH59nsFAeaAsDj0uDhjZzYsTKaY1+qNHF?=
 =?us-ascii?Q?vuBHAUnMiTu3+Oxlihlk+XErZxd1pyNB0JwGH8aYBlpdZ5+1Co44tP1+oAMs?=
 =?us-ascii?Q?FYEDCWzjo6YmLnjqoEFPb1Vtxg5Qg+kx8bGg41M1R9K737ktTCkTaRQ7jF60?=
 =?us-ascii?Q?X1IQMOfgmb1GopkpFeKnsUnRN2t1r19BxwBMZ7hIeonlIxjAPoo5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 171e8bdf-1aba-4ad1-9bbf-08dede5b6443
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:23.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRaqFaOkQwr51ZSG/B0KZQTaUJQwyy1Wai4lY6O82w75/E/uTSBG7gd5p8bYg3bWEjTHEH3BSjlfQBlC1x/ulg==
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
	TAGGED_FROM(0.00)[bounces-12286-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDC607385B8

dw_edma_irq_request() passes struct dw_edma_irq to request_irq() before
dw_edma_channel_setup() fills the back pointer. A shared interrupt can
therefore enter the handler with dw_irq->dw still NULL, leading to a
NULL pointer dereference.

Set the back pointer before installing each handler.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1c6db2c381e2..fb17074917df 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1053,7 +1053,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		else
 			irq->rd_mask |= BIT(chan->id);
 
-		irq->dw = dw;
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
 
 		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
@@ -1135,6 +1134,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
 		irq = chip->ops->irq_vector(dev, 0);
+		dw->irq[0].dw = dw;
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -1157,6 +1157,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
 			irq = chip->ops->irq_vector(dev, i);
+			dw->irq[i].dw = dw;
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
-- 
2.51.0


