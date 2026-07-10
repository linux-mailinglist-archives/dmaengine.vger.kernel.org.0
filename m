Return-Path: <dmaengine+bounces-12284-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LQyfAruqUGp63AIAu9opvQ
	(envelope-from <dmaengine+bounces-12284-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:18:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD347385AF
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:18:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=spqnVR3G;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12284-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12284-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3D2B3021868
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD63F076E;
	Fri, 10 Jul 2026 08:15:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021109.outbound.protection.outlook.com [52.101.125.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8F3EFFB3;
	Fri, 10 Jul 2026 08:15:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671337; cv=fail; b=LOsyFXx+nZ9Z1YwUJKMOQUQlcAjoI3SjDbyrCKwaembAdSSWIyFKKdsr40CnpJhlqlL93rkEQssxjPgfRC8rkJiaIIC1A+F/1K9DYeafu4rdXTYiwzl3dNb1qJLDhEbIGZ7CxaSz3l33/wnwZvTMaNnpaelSe5Ius+V7+e0U/Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671337; c=relaxed/simple;
	bh=FmfbJ8ukZuMn54MPbGIX2QYrmT06ebMhCquxyIN7i1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nh7b7k/YaHEX0EPxfA773QwFEnGoP9hWOCY/QGr/ac8kTIWuYGErBAEDi8ezldQLRv7Oz1Ss92QaCEKxCBmG8U7DnbpVr82Txgoeg7NfC+ZYsInrWs7qDQLkaSRkVMd3ZA1sqjqQCNnxPpgneN495qz1b0FFFEABIwzC4rv3vMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=spqnVR3G; arc=fail smtp.client-ip=52.101.125.109
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn1I5FOiaPB86XgGb31bh22erd0o2UheQz+adS9D5iwqi6jBEyoMmoVnPDvselFaMTH07OTiQsTFq0srBnmDHOlvwbYuo47S3MA2dpx2ejl8ggcJXim+CFicuhYHm+HdoTAAaQPwxttGwyCx+qWwUiBofAaUpYavGcyF8JXA0OUGuqK/jqCsS6kT8FGflFBH/0l9Fk5mu0JzQs5CxEV3tjR0x9h9a4DiQexSj2hZ9tog4QETVyaO2FoRdz1WCS1GI7/KOJ6RinY7cum2EZvWggaPJT2XKFpqNNfN0SvrCI2ys2N4opsmP6KKIdqRrodDf0SmfoeOqepBoiqjJpfF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmDkLmoAK/q12AWqUCZybTTQE29negPan0EGZ981gCs=;
 b=ThDmxOTMSHTypDANfInlOmd/CLyaDrzbsB9ad3NebxQ2mHc4E4JR764MG4sGu68IsZKu5K4S0WsPnShsirOm2Aj+yLiX6wBDsTUWObdl68BF9dOvT9teLo2LOzs7lxpx0djebwUu28hYU/D3JabM4HoaDJ7qs924oBfVjFUpCDO6yWSEbEMQ5zMNhiH7L9qHJFLJJ2a1u/Rf+Tn5msO80eSNTC/7kOQEBbr2hHmamrc7eIJbUTSttTFeQbXzsX09ToLiFZ+W21U4Fk4hKcVKPh9qhyYs6KYfXXHfeiz9yOLBVIPTZji19neA3nlS8IzdB78TUfqFJ42ypcfqOg7SMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmDkLmoAK/q12AWqUCZybTTQE29negPan0EGZ981gCs=;
 b=spqnVR3G2wmX8vVVu8q/liK7Zuk5ezjE/ffeghlevxz6BK1DwNFlNh78eGSVaaVXKsLVGjeYtOK4KRBu73siQlaaLpjjQwS0XJMXQoPv7r4NcyPOpmLaubfZNVswAB+lQqRDH3JXfsV+cbR+zY7vOcekUglclCfm9S+wOny+oec=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4074.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:15:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:31 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/14] dmaengine: dw-edma-pcie: Add chip flags to match data
Date: Fri, 10 Jul 2026 17:15:17 +0900
Message-ID: <20260710081518.2394357-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bac8f4a-c1ac-40a3-59a0-08dede5b68fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|23010399003|366016|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rpn8UW1ttvaGIcO00GRfhMQRNalFr7Iltcu9IwCj/fYWz8kO9+E/4BUnjoLUm8C7HajaJzgkoLuaTjPw5DHek6PogK5buxLuYpPwpNBDCAXA+QOTOgQJWusSX/isrHehhgRT2pt2Sr3QvlIrD0r1cCyrlOmAjDr8pCUSfqmY+pPPPCZqWj3eU+afqkqB8X4KEdVWVoWhxiyZlIMrfIX5dnggEb6mTEq6Qs75DXucjqbO1FksdvYR4Q/bCQM6IH9sNWZu0tswtFsLtriubNpr1907iMsgC0ncANU6mVHI8JEGKP4Z06OmYk1Ypkey4jvhrgEbrHKTkzsR/6HHJE59S4zIX92swjjq7gWDgmbr/3NRlmXI1P9SXJhWV08KoI8wtRZSrw36ltKxFS09a3kxidvDJy0uMEZw1Yl3k0N3Sq84sDdgclvDnJc9CexrAHSlisUYScXHUIoGflLvS3jU52mL1yg4ue/Gu/FxVQ7J2rk0KhjMnMN+yaVD6OFAbZrusoELFci7i9A7o6GeMz+tar5BNvuYBLniWXgYiDnG8SB/sO+T6vSA4J5/BNfxqS9Am33JeoKyOm7OSQb8nyqHXvfFT8GQOsun5OS5AJ0nluGjO92p2PPpBfO/EQstZgpmoSHBNRYyKUGjJ6rGk+5J4HSjX8ITThO7Q/7bqeBEnJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(366016)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LVJ8U/yHd9RN8VHAXyrPq9uiS6ARm9YgTkfREZvfabKYF6uUB5RgowNCzh0X?=
 =?us-ascii?Q?AiG5U81076zWRgIS/K6j1nNRlfh5S2a3xPyKBYEXtDHOx0S8BFHvGlIE0uIA?=
 =?us-ascii?Q?XOaryX7/L6w3ZR8eCB0g/dTOOkkFLR2aUHi6ZGyxXGe9n++HvwPZMNrPRQZy?=
 =?us-ascii?Q?2kViyuS2Vk9TGs4TaIO8uB8JGQszpOUxBWszuB0df5Iiq4GWJNXqUTApWe3s?=
 =?us-ascii?Q?vmCejKuli1FPhiOexr/BJzIz2xEyEn1h3aCFdRKJa9+zApoRgcANuiYNaUiI?=
 =?us-ascii?Q?2rYIq0azT4/GtLhfj/FxEyIayCJvn+V+83FtmH6yl4WzTu38gpuLBOPTOe0v?=
 =?us-ascii?Q?4R5c185TZlo1sgdsxvsV8mvnQ90tKMN2A/nYhfNnBNWq4Zd7fFAHdPOitXBH?=
 =?us-ascii?Q?IEm17ylKsAJowjELlsQnGsMwqTezVvaXxTebxmrR/ksEpMBH4XzOeIKHF9Ho?=
 =?us-ascii?Q?dTyyJFNQ1+9q5Wc8dpPpl/anQyZrF7rFhXg0W08au8LwN+xVuu+6Cphz3oAr?=
 =?us-ascii?Q?bD+uPJ94mw/QVSown4yBEdGUQvaMjUSSZhFS4Y1s0AQJunVrve/G+pMEeDfs?=
 =?us-ascii?Q?Y8c4pVKM3vwZ8TB4n5C8Bm5kxp1jmj+EljMqWr0cfHNr00jB7+a40m8T2D3L?=
 =?us-ascii?Q?poKrUR/dE2p9aar4sjhsWof8d4zl87meiP2gjUGXolmJelXZ51fh0V3zEpM7?=
 =?us-ascii?Q?cMsWpe8q0864dDhmva68R39YjpB51NTJklZGBf0cPSAukf7KE77c4T1XcuFa?=
 =?us-ascii?Q?+CrCeLQ93ALgAMciUZCtYlMeYutISeMWjQfjiTdVdy0HVXahxlqhmBnoo0B8?=
 =?us-ascii?Q?xPF4PwiESpVqsnJpt0F6N/gCs9ZabVxoV6QBJ2n8MrQzkHviOxZO6gK6CO0d?=
 =?us-ascii?Q?x9hwA62250gSr3QMGRJSp1etr+rwviDmq6LcI/d1gUFW8zaZCp2CNreTGuLA?=
 =?us-ascii?Q?1CNlkSPOmIRpI+4Vxhg5jUhBaINef9TXsozryNlMvzuL40EjUfZpcGkTSfuT?=
 =?us-ascii?Q?9EME3LARNi/Wx4IU608M2c7DzU28AWQ7aJUDPKXhwL9sgeHRxf3H4vxUQYWq?=
 =?us-ascii?Q?GPHWZYL46IgaJbr6QgNxeYYgu6jcq7ZuHDaug6uVEjcLLCfVln+2eQ3d4wZO?=
 =?us-ascii?Q?CUIvSZ4C2xinpJB5tfEhEQ7nbiPheCMqYCVY+pF3DWtjPpIAVi2VDEBKUEaW?=
 =?us-ascii?Q?nJRZ4OxNYBGVjywVd8ZaKH4W18d9WuntuDhYatFOmo0GeN+avaQekxELcT7I?=
 =?us-ascii?Q?Kwfb+iqAH6JPysIsvif+MoFd8tC8I1hiGFOfWDPEYQH7mpJ68oEWIWQs9wgq?=
 =?us-ascii?Q?rvX2YgWwBZYFzxtcOEm/OK2mTp1hK8JZCZBQ0+2S/5NfGlOubk06x7Y1tzR6?=
 =?us-ascii?Q?ugZrVdNAYsp1RwMWHV5BGgFH2V9t4ROg0UQCDIlkfDJ4tOOogQ0JcUu7HsOp?=
 =?us-ascii?Q?mmndARAu9oSImdidRq8HCY1xoaL8gDt5O4DO67iCPyJqvzm3rYpQKfvxqGzQ?=
 =?us-ascii?Q?Dh47PndhrbiXBvjo8K8sHyPl+SnPMqT2CBCt8nuAvZ6rQ67mv9Pp1gA4ABoq?=
 =?us-ascii?Q?Rcv2PpsTP2IZfzPpUZa81nA8TAz/npa+vNeQJu0bKUy19VMTLvDny1hZrTA2?=
 =?us-ascii?Q?/NzqueKozvUBKMQ+4pEEpQh2OLNEEExMoXjGZW6SebwZ6X5uywC5fUIdbxB3?=
 =?us-ascii?Q?mK1RQBF71xB3AodGCLOTUvyd4GRaev6/fGAk4z6KOx3pbR+87S+ps/VHOFqN?=
 =?us-ascii?Q?+RRoPc9akHCBqJhA2HR3ab32GNM/uzLryrSG1d/hEIhcEryGB+nB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bac8f4a-c1ac-40a3-59a0-08dede5b68fc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:31.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuLwHU2yjxfxYZkAtRAmtetUNzC8HqPbzB0dJZqcHd1bOCavK6VKhnOopQEwFBn04meo+bRxYyT58QPKYvM/4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12284-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 0AD347385AF

Allow PCI ID match data to pass dw_edma_chip flags into dw_edma_probe().
This keeps per-device policy in the match data instead of open-coding it
in probe().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index d72c0a19c604..c1585c8ce11f 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -88,6 +88,7 @@ struct dw_edma_pcie_match_data {
 	int (*parse_caps)(struct pci_dev *pdev,
 			  struct dw_edma_pcie_data *pdata);
 	unsigned long flags;
+	u32 chip_flags;
 };
 
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
@@ -471,6 +472,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dev = dev;
 
 	chip->mf = dma_data->mf;
+	chip->flags = match->chip_flags;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = match->plat_ops;
 	chip->cfg_non_ll = dma_data->cfg_non_ll;
-- 
2.51.0


