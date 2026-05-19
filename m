Return-Path: <dmaengine+bounces-10522-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF8nLdAIDGoRUQUAu9opvQ
	(envelope-from <dmaengine+bounces-10522-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 08:53:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 151BC57869C
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 08:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 492033003EBF
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE939D6EC;
	Tue, 19 May 2026 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="w2SdHxI7"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87839DBD6;
	Tue, 19 May 2026 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173247; cv=fail; b=fZqEgOKrIxDuYt25CsE02Qpz4v1HjSAZlrReyvZ9jw4rAUbnSavk/7KRhdq6oYqoURlDPzS27i1Vb2fjaRgOL8qGHgjN7J/6efOKfPYWX0RgjQuKYkflCOT5Wa9PIjLPLicquK679NLNxwz7tBdVYDG3fAY5nI2nW97pWX+RyyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173247; c=relaxed/simple;
	bh=uHYdfSVoyT77xUvXKg+pSONZTlQwGcLiI77ltVZw0k8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kqeSnjmpm9BTLURRqL+DpMKOpLW72lvTKUYZ+oOPH38xIT9lf0OjAMLNcGPl6A0yz6SjzZhZzIEISlkB5Cavw5PlVPyIrHnb3hVDTHuoEORIGqbjzymyB/rZVU+qeYH1I9oX9oYQBovB+bOFMVlYOc8ze9xpyZXDo0TSKvF/E2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=w2SdHxI7; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZF9dvzhTKJ36J8uwfxvCKebqvdQVmMAp3W1UgwnPR0UPMPo/g35L+cDDSIH3sFJuOHotMy9DKKzLGAnHMD7ZB4Wb2EFIPjTVsM+ijeLDJGTPZC96mcMA+6toGQMFlk49SgV//6s8FudbOi16d6tTZOdgBI/sqb/O8/0JEuVWWBTG/1TaIJBLx7LPLRxiiC8QY6Sq8ErrCY3mmO4OgARZVFgdE8DbqTKug+kx3PspXatyJGFZSDdZK60BsZZGdL1HsziCm/z9qgf/MlAt5yaUbXo3UZfp28l4hjm0EJd3e2uTxa21JkKoqG705BlSgFyplG77hGPKi6CYsOKJrD9G4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RBRGWHvewf1jT5SPm2lwAfmWvvcX08udlWED2baOrU=;
 b=aiDMfMHRc9teel4Vsb7g8RjbSni8wPXqKZIop8BaWopoD3GXLvQbf9a569sEn8QAKivETA4DMU/CZ39j6Z/jsVzfrjzOL5vKKc5mI+1uSXlEJCo+75ODnZz9aexzB5M10JDXn1FIRSDeHIO5RUOMSiB3TViBlvICMckiOz6jSwShzlGndglI+4w1ap9VbMXBIcleyeKnvpVjF8v80RkLGtNMWKmfdyiA6pvsG8GU+p5aYa6XNQ9mFaASZo+TL0xuaXYAGD/hLXfWHFnI+lWF63GcF++WQb+554C50XHUTsNEBYIbFiJH64NlRkm5glR+ya9Ah5z4wyMfWIHg1DY0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RBRGWHvewf1jT5SPm2lwAfmWvvcX08udlWED2baOrU=;
 b=w2SdHxI722vrWgnZRaU9CIzW9eNfiEsr3TVAIPOEaYxhxSK7+nWIeTUFRhVTVSLgdWALtooal1TU27z17sRiAz6PujhLIWmminXZK3V19FtORaABiDdxn3lKXqjDSR5G48i86UJnUvtPzUwoQ4+y1dgKumH5bN64CETSoe6qMuu74ulWA0VPJAOdnVag+4GQqVuqN/aZlwkgfR9GgARhCnLfyj62pHbb1eLWeoYy3YhEPqJzX190Ids6GIIH1W1t3vaTADqvEvJaUfA94nOHYerXwR39OSPdmCPd3NRnx0JbRa8LU9he9Iuqjh8mjj4eYoM+/nGRz+KzrkX9SDw+Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB5678.namprd03.prod.outlook.com (2603:10b6:a03:2d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:47:22 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:47:22 +0000
From: tze.yee.ng@altera.com
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tze Yee Ng <tze.yee.ng@altera.com>,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Subject: [PATCH] dma: altera-msgdma: Replace memcpy with io32write in msgdma_copy_one
Date: Mon, 18 May 2026 23:47:20 -0700
Message-ID: <4586c39b43aa3b9480989940fe905dac40c8cefc.1779173156.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: af188e24-1e11-4d5a-8b57-08deb5727a6e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	q9JNobA4p0FkSd35PgVyTchgGK+SrAXWcKuEb87CO/xZbe5tpku+YrW9WP0C4A1hOeFdhfDdAMknb1sglu7Qc7XifuVUL4YkftB4/1A1TyChmqbCifLLVf2HrFGOvIMzA3KLrFvLB+nT+XEL6UlQTK+Ojg47cIOnwi5ZklJRDCdszumVULqJSxU2mi8NCxHCW46Ro9CZqJCSr7lD0zDFYmm55vTDw94TTrGqNqxBzQ29EoYDVDMvxu4ElZTae2uEGQ6LcvnoLvLO9D9gbU9Pf+b1xUPqil9pUMBZ8mjkfpsx8YM+ErPbXeZR2kdpTNTxccYPylXodcFYBgNsH95shw4wCP3LvTEKbYvVrv/54lsckbUUwYbaLDiOBJPnbZd9UtTXFUBzM2BZ88RUunfGF9MMiteGYWA7eVFz3GdBuuNJqVpVyvESPD0i5aSb2BxW/oXHo8FjMuHvnEypK8JJMI6bFulWBbExy35Nq/YMkkn0UE8EhyQ4HQoxPsE+loNLrEvRBqnExqr1oifFaVLnGokUibgiX0aPEi/QqabucTaDHZwHRlDZEy0xHmM8HkWSmrqrJLnscFnNdqlfvezqIRNrOghdz2pVWL8irBZmH5Xkp9wDeOjgjBGnMut33yJXFlTQmDVW36mGXUe8BAjdDjAy0LB9XgbQyF3qV1SDUiDUWnwRYOXMkIzXTs76EGkT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qutHN5wuJ5XaQJl+T41gTsrCxvH7sk/2K63k2AENBhOg49qQrBSgBj1+6g0u?=
 =?us-ascii?Q?eOkmFUUN9/j4tq1znrLdrgTPXBOUqOgjzXXktuHwkRYdahzypYRyZjm4o12m?=
 =?us-ascii?Q?Ryv9adtNT0Duoqu2e/3tTQU8SxxZSLwS1Qq4XjXg4kTW0QerP8kPTasjjxGI?=
 =?us-ascii?Q?qM3gNVFdGhiMehu7WkBRTWwS2BItASRytCKS3aQhkBUwe7aUhO+bUzZhwrk4?=
 =?us-ascii?Q?rDh1KRs59h17DI7klmm1KDXE80pHaSDal1LC0NJis0PjBLVIsO1e3kTHS4nL?=
 =?us-ascii?Q?MW149httxvyA1dll9X4PBzh/7hKuHDaa7lHEGBOyQunQd1/Yn13slCWg/Ru3?=
 =?us-ascii?Q?CIgfpELcdubiAslkMxfvNQsK1ymkxPGJ6kG3Rf7a0tRVmrTi61RXJ4OPosYE?=
 =?us-ascii?Q?DvUVJfg44zARr7BzabpIFgxvuH1zp9ibYkVMuPLAQMV6WBuUwhRAsqSxsVUu?=
 =?us-ascii?Q?ittKhF5SO5+ifj3B6DD12WXpHKbpy2dKWrw4EXMf17BonEE4/r8Hu2nYcSji?=
 =?us-ascii?Q?BM2tSFj8VD0NMmT0nY/ARAr6pzEpUX4HlWhYz2UedCXr7DdPpElCtES/qZIK?=
 =?us-ascii?Q?n0+SIlWNSHhUUFaWUdrFV100iSNuuvSU8aZ5a+flmJZck3rU9aM2qaRiObUE?=
 =?us-ascii?Q?co/z3rfGWowxVTxRw88r7yUGS12Lo6q8nfydA5CjdTJjMzG7w19zfFJZjyf6?=
 =?us-ascii?Q?opAs2kJEfp9YKVt2gkJIPDKjXhtReFLjDTB4MHppcQu9DssaObPwPSoJ6nmn?=
 =?us-ascii?Q?gklFPoCHSJmQH3d+/9w/Gkr3j8xaOolAv03tXe3GXDsoKjpFl5EoRfPZmyXv?=
 =?us-ascii?Q?zGLJxttfqwR8GYoEK8P0aC1Xx4M6Hz4PdpJa9NIKC71kEJ3p11eZpOV5lqtp?=
 =?us-ascii?Q?Vba/thfPF7Y+EacvICg0tMNBVDWizpuk1ZEHjKbXKnBMObaD/dY11eN00GME?=
 =?us-ascii?Q?HjX7rmX5yWFpE4sFqZrwdOJbGGCTl051wpfhG8YWqyhj7ebl2u0jK2J2LNB9?=
 =?us-ascii?Q?Dm684rqmCPSy4EvegpnhF3eq+h6hZi4DD1q/4xagONnYdWvWKysUHW1HZs5+?=
 =?us-ascii?Q?D0A1HkM6OynIT2krEKcq8raApF6HLRh6XWUWgALmxi+taKHsRmCF/m3NkSgH?=
 =?us-ascii?Q?s7SivP8WK7x/KS0bqhGZ5pxbYya1VFfde1W2Qt2QAL9zU31hcZT5DZatd9cY?=
 =?us-ascii?Q?z37w9Jc09zAhvWdDaQc2VTQad+Okv6LJbk86FAn9tT7RxVCKAFxV7T5gCCv9?=
 =?us-ascii?Q?WSuqoB7lpmjjhSXFFSOU39xYxkS0mNEQ3OsfeSL4rdpctn7mOQBz9eXxhjVY?=
 =?us-ascii?Q?SyW0l7QmsV597RcOQ5lQOBLeLlT2aLiMjVYFCC9gdojEstbjBsVsG0CQ4zxt?=
 =?us-ascii?Q?QeJrnbOsTFqArjloHVuguH7daLGQbrw1ECa19Pm8YAWsk9lL6VgnnXclJ4Bv?=
 =?us-ascii?Q?JsTkYvwEArDBI4qiIW9vKT+JP/qC3vvM3Cjei78xiuR179LBN8uYMs02Pa+Y?=
 =?us-ascii?Q?NsapA5ceyvkULOq4BFB5lwHTyxrHYgE8Wk6iimKZTkWjKJOyCxSwMLeRH2oI?=
 =?us-ascii?Q?VBeAUkCrVh5oyO14GtLP3NmTB2f9CbMTzS6SFGqo6dSeb2SmSkuKm3e2zJSq?=
 =?us-ascii?Q?CbCiGA9gvbG4yqFNzBTd6lV+9BA67+G71O3lANM/MQW3l9arzUWBrP28Zcwr?=
 =?us-ascii?Q?JzrLRGWo6KKzfNANdzeaATxcIDoZr0O1jWpOKs/pezf4abbxxsCjih+R6e8L?=
 =?us-ascii?Q?8ONKW04Ifg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af188e24-1e11-4d5a-8b57-08deb5727a6e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:47:22.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /c4dy82Dxs4HnSB7jl/+Ha5IKRo6BuEyUBh9G37Dpu7RvuxAMCP8JGs428kLnfyTgWhJK/dgREaEG43E3fpgow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5678
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10522-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 151BC57869C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

The descriptor FIFO requires that all words of a descriptor are written
in order, with the control word written last to flush it into the DMA
engine. Using memcpy() is unsafe since it does not guarantee ordering of
MMIO writes across all architectures.

Replace memcpy() with an explicit iowrite32() loop for each 32-bit word
(except the control word). The control word is still written separately,
with write barriers, to ensure it is always the final word pushed into
the FIFO.

This makes the programming of descriptors fully deterministic and
portable across different architectures.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/dma/altera-msgdma.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index b46999c81df0..5816973d2c70 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -495,6 +495,9 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
 			    struct msgdma_sw_desc *desc)
 {
 	void __iomem *hw_desc = mdev->desc;
+	const u32 *src = (const u32 *)&desc->hw_desc;
+	unsigned int i, nwords = offsetof(struct msgdma_extended_desc, control) /
+				 sizeof(u32);
 
 	/*
 	 * Check if the DESC FIFO it not full. If its full, we need to wait
@@ -505,16 +508,16 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
 		mdelay(1);
 
 	/*
-	 * The descriptor needs to get copied into the descriptor FIFO
-	 * of the DMA controller. The descriptor will get flushed to the
-	 * FIFO, once the last word (control word) is written. Since we
-	 * are not 100% sure that memcpy() writes all word in the "correct"
-	 * order (address from low to high) on all architectures, we make
-	 * sure this control word is written last by single coding it and
-	 * adding some write-barriers here.
+	 * The descriptor must be written into the descriptor FIFO of the DMA
+	 * controller. The FIFO is flushed and the descriptor becomes valid once
+	 * the last word (the control word) is written. To guarantee the ordering
+	 * of MMIO writes across all architectures, we write each 32-bit word
+	 * individually using iowrite32(), and handle the control word separately
+	 * at the end. This ensures the control word is always written last and
+	 * prevents memcpy() or the compiler from reordering accesses.
 	 */
-	memcpy((void __force *)hw_desc, &desc->hw_desc,
-	       sizeof(desc->hw_desc) - sizeof(u32));
+	for (i = 0; i < nwords; i++)
+		iowrite32(src[i], hw_desc + i * sizeof(u32));
 
 	/* Write control word last to flush this descriptor into the FIFO */
 	mdev->idle = false;
-- 
2.43.7


