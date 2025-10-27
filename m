Return-Path: <dmaengine+bounces-6994-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F22C0B8D3
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 01:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C65554E752A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 00:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E62FF171;
	Mon, 27 Oct 2025 00:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ie+lxR0e"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011028.outbound.protection.outlook.com [52.101.125.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52E30DD36;
	Mon, 27 Oct 2025 00:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761526031; cv=fail; b=S0q4az0wBmyx5Mb64bhaO3I9/BYdIJGiwNC143k4tBPL+EpmVc0XxwJtHCPcItgsRKPj4ZX/9WqLGJfMefJTjwYGrdnCEPCIMgsiPVkc27BgBZvVq4OxPTxS/iBkLPiLD6e9yZc6KHerrQn5krug5KZw23G+RrhpVeJcbqThsRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761526031; c=relaxed/simple;
	bh=sAvbnBhR3Q3riVPvJ4WuvcBX+cPCHh7z5qCqBFSIofQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=os7mI/WxrzpZGNamtwGNypMjOXXH9jfHXHQKfyZLPo592qEgfzlIv2awfnn1CGdDGVEqNXzRpGGQcBJBpaVmxcL5AUDGVP5sa0EZ+6iny5Z1YqhGKibH6ShcRVh/MDRQtKavQq6m0yZBR/QTcSs+5RA33Sja8VKAB8ooTWZLvuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ie+lxR0e; arc=fail smtp.client-ip=52.101.125.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh05tMYat+YxTjXG9V9Pph0FJtOhdCXkFTfjhVPwnu7cjlIOXiPPKfhdue2TgchGBILwQ/N+nVHurj5r58sqAeywSh3pirb4BAEkHkk+NfOMGnwAJeBYUxR5DeLsLvBTTtZ+iZdDuLMVsWGJdID7yyRDjSylGMmqo39qUBchHu8H21e984Ay+ymNuIy7mXnEY51NQSQ5tUcShD0b+LnRwJsobHps2jXbKXXR8Wrmbj4LTV9ne/KRN9bAL9oacTp3ORygmMYnceSKHKw/fcUCMZC8QrYcr4tumE9LHSh2CFmUf2YIGOLboo/6vgFKmzDhEdlLbGNY98UYQChwCKpVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpMTMTay6KdKAG0bCAmsZlsvTY2/Z3wv65f/01SJG1E=;
 b=QVrcIN5QFhCM6oa0qOSmR+4ojWLtMxkDd+iROyiqeFkogZpf8HgTCtADWqcwiU+BzJBFo3zyNEkkU1xI2isX/dzmRDmOZrbwT4XFHJbTVRVEwc0G0BGJtuL4+4eTyt5YNfzu0CyH3aaSgX+CJVYtQs3wBDMpmKyjovUnU9PR1Re0geN3L4uXv2Kkawkx2H8MXch+vIWWfnC+LtynbZeREz25pVW4i/V0YP8JrDCghaL/S5aim7KLgcMqhrI2ixCvGWEoLVAjdBS1slXy7wi+QEX6gCsiO6yJBnHKp97IiTUsQC/KtfQey43UMqsso36BpSh9AfeXVGTMOeRWYuwxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpMTMTay6KdKAG0bCAmsZlsvTY2/Z3wv65f/01SJG1E=;
 b=Ie+lxR0ecorcIkx7hYIcqzdanNe/CCWERlXJddBf1xXEm9O/Wrzxlwy9rtq2I8Hs87EfXKVtfiHngdJzaBFs06/8RZHAhHx+duGNxenGxihWz0eScOPvAp5usoGD4WFJ+HOAZvMHl7tCrv8e4qq9Rcio8pvkk+T6M9fpTp7PJGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB5349.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:191::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 00:47:06 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 00:47:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vkoul@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	kuninori.morimoto.gx@renesas.com
Subject: [PATCH] dmaengine: sh: rcar-dmac: Enable 1-byte transfer size for memcpy
Date: Mon, 27 Oct 2025 09:46:57 +0900
Message-ID: <20251027004657.562787-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0366.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::6) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7c92b4-9558-4163-6a70-08de14f25a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EiWeItpe89ZpYWbR+gMfs5Uq/l543xLF0eddFnAJtYy6+SPuulXWp0V9DZxc?=
 =?us-ascii?Q?PAAgSu+BcHJZNXEDTAcOV1a+8sVszh+7gRI44bGQJFa9X8gyPHWHY7Sojlay?=
 =?us-ascii?Q?wu5CMApPrZYR/x4kctoXoXMHATZdLpkk2yIPfrUNIh2HKMtCbbUBGrDZuGHp?=
 =?us-ascii?Q?uR39DSGQqlaEI4o9uBvDPszoCoili3Tg86InywStNoSNmn5kbr/UAUufShC+?=
 =?us-ascii?Q?4oOUxiQ+GmqbqZmmZ8Riaiz0d4I5KD5Hsfn3IJtJizdDIZ8MQGdWFVRkwXem?=
 =?us-ascii?Q?tiuQ1srfe8J3HAGrrSV0fg7LkYen+a6e5bsUrHjoGg9meD5TvUPV+H6bwg3G?=
 =?us-ascii?Q?FIXG+zkhtmDT3hw9QFtNVPS/pmGGaZTMLqhgruQoN7C8xxdXNtcUa27FrUzK?=
 =?us-ascii?Q?xihTghGXIKZbEMVUKIt5ddZt9wAAqAj/pZtVbpYyA14RLtZpd08Nkns5qI4B?=
 =?us-ascii?Q?xpRPWQ3haAW2XuXFaZKIbMMgP+PXRHsPRxWow69gEK5AAD7SF6JQJ/qgrnDb?=
 =?us-ascii?Q?S4QWIB9L6QtnJvE/pJwsL6ehZucO0ytUMpwP5VZCFpvKLg1YJ29qX3FZjXAJ?=
 =?us-ascii?Q?Poai+t7E+F1hpa8qAYCz0tCYwvEgd0rD+V5dlLhvRRstWoeMJA9NUm3YOnH1?=
 =?us-ascii?Q?9muL9P2d7VuBYZSHU063hA5BeShqD32fV4DfHYoRKn0IbVvx6n6od4PENOS4?=
 =?us-ascii?Q?KdHpwetY3IDRI30/KZwXEiJYMqK9jbd+47sQIzcCWZBBkInANW/xGv6Dgcrh?=
 =?us-ascii?Q?vWBUVVjOUmM65XvxELW1POt6wZQVcysQbh0bsLx7Fnq/vrxLt2q0eEoxmJUU?=
 =?us-ascii?Q?rVDUFr175ZY8G5mhw3kSNL6tNsStWhrR4xxbrLo+hWguHoMwdLH518LyzQKu?=
 =?us-ascii?Q?AjvpY2eFk1kHNAZxr/QbmzV7q2mIL+pkvzsDODuWshOILXiKqT8q8y4opuM7?=
 =?us-ascii?Q?KEAveSVIO5C7r7zHPSPcPElimtrRSO8tU8b58OuFHvWndOWGJk9+KQzqbbj+?=
 =?us-ascii?Q?Br8auYr/u05OU75xPAS9pq3hsUSPaq3FfvwhliDmmP7JIYvGsPGrREW+MmrT?=
 =?us-ascii?Q?n/sBdoxgRPZMsRSkXbCMA9OpzvUBFr3NM6C/07qceIl954E+5EOvfpxxfDo+?=
 =?us-ascii?Q?V7WpGouVSn1OKUngt2zIbjOdUZmtGqvNluPrMWFDb5ZCKCzqJB/Zo9OX+mMh?=
 =?us-ascii?Q?AtuG3tY4vR4uyQgm7JWk5mMTDps2nwMG84T158fHHurwfp9UMw4eIruMMVSK?=
 =?us-ascii?Q?HcH7+P+pKEiZ+CdP3EL2tzDOFxxXJ9n+Ecl2Ps5PlkYzvA+eFsVTcFItJG/s?=
 =?us-ascii?Q?OXW0C/WqfIHy+zYP17hWwrlYlX2N9l5vMEOAUYap8ovpeHAydu4aAO44QsQi?=
 =?us-ascii?Q?mQW7hBzaq8L6I244LHbyiBqugS95dQkCmNLxt2f4JRZWlLR7tpSBYr1EwPG3?=
 =?us-ascii?Q?fXRhERKfjXmhHXVmlJ1pDFtrb7rxie2t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xZJgl14q7kCmDt8DSavtvoohGf3dbFMg+QT1ZsAppd0uieimBYK+9NNwQPx8?=
 =?us-ascii?Q?3mwAovx9asGluSl6UtXAMaZsX6jGndi+a0sb37q8aZGmKHFEfWALSHIzyF1Y?=
 =?us-ascii?Q?ObQ3LL7gdGZ94BCo2ZunUfi8OYGMr1H29b6goH7/0ELYKCf3SmbCJUWjPjf6?=
 =?us-ascii?Q?66vUszps6pr9MxIsa4AOPEehWUVlZNKZnByzFOVWPii9xBk4K3n7kGIBMNcQ?=
 =?us-ascii?Q?tJtrsrr+gS842bwbVKVyjYBq7h5qYxVYagZIHUPVdUE2JNdW1nBumokU2Yu9?=
 =?us-ascii?Q?640K5XwXSdpMs889ya2B2l5oBFbCBjEPAz66xHqVhJP9VQxDrJcFDvUhBjtB?=
 =?us-ascii?Q?OgwAUAeJX2JdkHVeRJJ037wTiSR2+ceyr/Y9XcWIp4J38/z896QEFL/+7Q1B?=
 =?us-ascii?Q?1jO0r9wd6ncHlWkXgx4eMmhu0utpEdmzseNeyz4vB02fQO71Qotz/BJKoNGl?=
 =?us-ascii?Q?Hg9gYWnGixvzGHVqKrxPhfKxDlf0cooGj5Os6qWey2/YKavmZZJmGcl0//+f?=
 =?us-ascii?Q?En8nXcQJQD5lU+HP0jBs+aXHk7cjEqi2DHEmOgAjx8eTpaL0oz0tRQenlM7g?=
 =?us-ascii?Q?gMfYQsopxu36L34vwxG6tflDKEVKE3pFeNwkkwL9Ecbv0iEM9n3PRFl/p7mD?=
 =?us-ascii?Q?6evjalqXNA9Fcb/tBGMla2VeTjmaQ3eSRE6kZR9wbXUzQdZDi11iZjNN+05j?=
 =?us-ascii?Q?yqzvZEpBH45Do8dwlIw5ViJQ1TMlvaLXmYJXPK4nbxPkUTr/XtrC5XVoe2xO?=
 =?us-ascii?Q?KqNsICsGEBo9AiarGpLm9gwNJm1S0hFcTLJJngBnSSWA96oBehTz8xiWnHwC?=
 =?us-ascii?Q?XBno8jwDblblw+W0oNVuxiUNlJv1pSeOofPuB82r3AYkxe4A7dZE41RboAKD?=
 =?us-ascii?Q?lOv8UYX3YmAi6QRyRKOgIwIR/u6NEfYUsMAuuGoDmI2Ma3WXIJ2GIQOLNV68?=
 =?us-ascii?Q?ls1+rSLRxr4OtSAvgUkyK1JnCONgaogN3zsb+IPMjWcfAfgqeilidRRx69fu?=
 =?us-ascii?Q?WDpdNmLXVtteeJnDmU1Ap4MvtOPjE2ynrTnj6IOydhWW/2W9WIh/dDI/Y9xL?=
 =?us-ascii?Q?j+FR27Nnhvf/98ViNpzNIsZ53OvILF3ZpKOD0KoKZK9keXPk79RewJm/RDYt?=
 =?us-ascii?Q?w9FGhbwsHbzrWBqrZ9lZh7r0eGLxzfKOYltEeKtzpqYg51lLc9tw7fa+S1Xz?=
 =?us-ascii?Q?XBtznKrXCOFxfC6cMQ8fO4za33JgrK0thukrWUbPHUDuJLY0LjFP6y65+iuW?=
 =?us-ascii?Q?sJ6xzdgUZYU4HP4wJJwNju32E9DCFW6JW9n9/CIn3fzqEGYFZDcdhf789HxL?=
 =?us-ascii?Q?yXEHXVHJf9Ss792Z/KFiqyl6OcLj0IC88dYD6ojrcn5aJrIdc3OyI710dJn5?=
 =?us-ascii?Q?pjnm6k9FTj6A5fC51pXSh8e+6DGEn87beGDtbNFmu/OXxZogPZx7CHFhXmWe?=
 =?us-ascii?Q?3w6V2ykq/SCqPDhqvxirqUNn4SAfm9Ga/Qex1boNnosp2kKSnLKi4N3rOF0c?=
 =?us-ascii?Q?LPQsW4NUsjgXycleJECQvmdJen4Pr2GJ3sg40JBGqKCUnZRuo+bI5f4vYegq?=
 =?us-ascii?Q?cosnaprxfBc+9cOEKp5AhY1UZ1CtBjtPP/C57Aoe8kdmGgal9c99l7/jQu2o?=
 =?us-ascii?Q?IoI3Hvvm2bobSVM02ecYQCE=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7c92b4-9558-4163-6a70-08de14f25a9c
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 00:47:06.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6VnHZ7Zr4tmBoY0s+xmB4Kbyk3D2HqSGHprNZd5kvmlTZ6iq6cZyn69gwGVXgWSQ1B1487N6mfPZFGbXO5NVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5349

Empirical testing shows that rcar-dmac engine can handle byte-aligned
addresses without issues. Relax the driver by reducing
RCAR_DMAC_MEMCPY_XFER_SIZE from 4 to 1 byte so that memcpy can run on
unaligned buffers.

One practical user is ntb_netdev + ntb_transport. On its TX path,
skb->data often ends up 2 bytes off a 4-byte boundary due to the 16-byte
headroom alignment (HH_DATA_MOD) combined with a 14-byte Ethernet header
push, yielding a 4n+2 start address, falling back to CPU memcpy. With
this change, rcar-dmac can be used there as well.

In local testing, hacking skb->data to be 4-byte aligned while keeping
RCAR_DMAC_MEMCPY_XFER_SIZE = 4 did not produce a measurable throughput
difference compared to the unaligned case with this change, suggesting
the previous 4-byte constraint was not performance-driven on the tested
systems.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 0c45ce8c74aa..c4d6c2f9a26b 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -303,7 +303,7 @@ struct rcar_dmac_of_data {
 #define RCAR_GEN4_DMACHCLR		0x0100
 
 /* Hardcode the MEMCPY transfer size to 4 bytes. */
-#define RCAR_DMAC_MEMCPY_XFER_SIZE	4
+#define RCAR_DMAC_MEMCPY_XFER_SIZE	1
 
 /* -----------------------------------------------------------------------------
  * Device access
-- 
2.48.1


