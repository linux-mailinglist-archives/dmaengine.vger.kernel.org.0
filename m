Return-Path: <dmaengine+bounces-6949-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D7BFF960
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EDF3AFD6B
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CABB2F998D;
	Thu, 23 Oct 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="X/x9ai8F"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4622F6571;
	Thu, 23 Oct 2025 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203990; cv=fail; b=KEc9iJK1yBo38ZDO0eZqG4HfeztjAf6JuN6jlas2LHw4Ib6J7DD6KJ3IyKUkUlRCCYa0oOonIgETjjQ/Bjo5LeWyfhh4OOsPWUT/9fE7UMhgWtgX4MUyuVr+Wv/qZCDG/Rdqf/jeSmmpArdqwQByNoX5dqWAd8eR7e6Ik3HVnqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203990; c=relaxed/simple;
	bh=RTbd2ThMU5F3W4cpvNfO7NC9/knCxTlqGLekcR7B8mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VcTf8SnFZ3I39hd6bGzp2hetiqKhLzDxeBP5lg4+JbCbIHLw/3FhuuAxnQgsNat3L0CB5n5AJMXvOduHRMX5XPystLdbYOtISRMIVEfMLvX0g9n28tBDIosEnLS9yUfmp7GfEpGAJ3Q46ykAPuPhiWwquT6I7ZdAH7JYSfc14NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=X/x9ai8F; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhIbxQTTBM3TWxS48MlfLw3enrArDyp8+59QnA4JyWiTxzRObvt57B+q2VYTGM4qfFf9tNy4KRoPj2qiJ4NPCctiA8rreE/CiwMm30PcvwiSNc1sVFeeAvdOruXKkL9ohl1/aKJ5p5/eAZBpLX8+pINqsZEgl+4M3qKJDpmNmc377ucgYneskhNdy7s1a8et3WTeeFP2LAMNcLFX2N6fAb81PEMmBbXG5Vh2TKMxe5FB1/UOD51U+KmY2oFKrT5vmiqhoptRYwQnMxyh7ZSRAwo3+nT8gZ0UQ6LtvHy9nOSDjihY7AmnRkUVKuGlbZ3ihzYfHfJ+Q1YEffbwk5fbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e53g0sax6rPcsY9TKsqa3HvCyMk6oHTw7aLoXQva1zc=;
 b=RECNB8t2DCLpeFhDT6XId7K9MHwd2Z5vyufmaPCXCLePjH2Kvy7S/6gdNWm2w895C5pNsbfKMWKRdJs6pRwhc3wUW1EdF98IF90y9xWDewvSmvJqdumZUM+tfB96zFBYzBNIR4QuaP+PBVyv2RFDWG1SsDXmohDyHjgblfqMSekLxwn8xexyHDlzV7pljW2Gj1LsmRkTO/P66hL5ZSFbbQwsy+r6dyFHd2VuzGLeHY5jhAqq2wETZeNhghRMSXPT9ijmp0Llwp2rx5gpqu6CMIoEAEjnfvt9fjCewjf1GUp3nwgRpkUQMmJypbSVqEWxB4J2ydsDRymdS0MsRNYj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e53g0sax6rPcsY9TKsqa3HvCyMk6oHTw7aLoXQva1zc=;
 b=X/x9ai8F+XOBPIWIhT6dU6CVPjkr3zPH3i/4ggkzK20xZYqcgwPrXS3Gx5NHA+OA/SdY1RND/0Rk4reeq96CJE6HBtIiQDu4kfwk0eg1SiaahEmQhyigGCe9psmG5JmCicbyfBVjWvPl78vc2pBI/QIC2IKJ+LiAY1LyGD1zt4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:41 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 15/25] dmaengine: dw-edma: Add self-interrupt registration API
Date: Thu, 23 Oct 2025 16:19:06 +0900
Message-ID: <20251023071916.901355-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::18) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b434e5-b937-4563-1424-08de12048843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p44jE2zy1SU7hsDm1+l9qffmiNXkzEhDLaxl8bY2TYKuH1EJOhGXQVs6Bk9F?=
 =?us-ascii?Q?EyGOEUYhQdKhSuJBWZlmZTWp/BIpnQUEF73wCRpOzD1VkyshnRm6Qx5INzRb?=
 =?us-ascii?Q?O/1sCdyDKd7pi3YJ1/vPqOHP20J892FukXPDH0/kIU38euh/I5gXCM7NkG3M?=
 =?us-ascii?Q?bdWyDefyvHof3wjCuN30lmazmv0wPKqiLor2aPSEg5NWTPXmCDAmYc5QZpZ1?=
 =?us-ascii?Q?AfRMmMLnrlJ8f/67XtK99ivo6+7oKDyimvRDFmRVenVM8R3Kp4xgIXTbXmNg?=
 =?us-ascii?Q?lZu99uJCnR2KBJg54EXVSAqc1LbuvfcSwKS+FwtowpaYnlS5dR+iAdRVFlKr?=
 =?us-ascii?Q?9cpj+JetFj3C0aS/sYe/t6Zd3lyXer6Rdw/2LR+pjWcTHymqfe0j9sUaaB0p?=
 =?us-ascii?Q?A0r1cO5rBu+AA2pZYvfB2H8lcn14EyFLOwoUGUqNs8bQzhD5BsKjcXDohbac?=
 =?us-ascii?Q?rxzIg4RF7D9XQxFvXZcRYdkE+Unx9CrCz8UhzC9DVYzq3OIIbtjcwz639fFm?=
 =?us-ascii?Q?LBgPi00U6lkQvwaV7c8q3w1YXMIYGWUCwJ7vQjOvzdeZwQDcu4/QQ3IDF4xN?=
 =?us-ascii?Q?HkUdNHUMjMkIKzgTCKlQa1dKin7pWGpXYGm6IJ00ftC5LXT1ugMxKms87Lyi?=
 =?us-ascii?Q?1n0dTK1bLWmkB6TdMQyKgDQgz8ojHzWu2+pFVUF6RCWSfTCywky9VPkSAc/z?=
 =?us-ascii?Q?j2atTgyUpJRgoUvagrn80T7jhqav9C70hcp9aTkKWdl+bIYrmJnhXFlzwgwp?=
 =?us-ascii?Q?KbsK8/1emGlZlTw/GlnbATGstP7bJAIUN2YbI3BtBBIcBBX5bdZegkXT6xXu?=
 =?us-ascii?Q?GGBPDQhg5qBg4Anj1jDCcQLPViJQiJiR1NtJoJOWsoJit/0xzo+h+GrO3soO?=
 =?us-ascii?Q?oihGAvClwBgaESns3zM46D/4C3U8pCB+SZfdXIJJCs1Q3s0j1BErOP+U/nRB?=
 =?us-ascii?Q?H5hTEPzr+hJj6rxZoXcFa3eMwYUelS84tnR0bG89B9BauJixKto0OUpYQAtg?=
 =?us-ascii?Q?ZKD0k0ZXziaKiCXTgQXIUN/7uILD5RktlxJEAHPMjtj98LjM2r58JW3P9Fy3?=
 =?us-ascii?Q?NuNYTyX7qTJsZcVGJmvS++XeAdt68n/ScoC+aCRaH9jEFS5Ilb3MsyVdww0n?=
 =?us-ascii?Q?bGcLaZ7vPjfrzBVT1D4CO6+jZOUy0/+z+DPjXj9myKklxqH2A0g43FM7IUrt?=
 =?us-ascii?Q?2BR2dL9R83eLTXRzcgDyG7161KRsBUQPb7I7qyPtZ19ancnO/t6RK9dWqwij?=
 =?us-ascii?Q?vEk1VQwBKDmxGAcI4RUEJGqzOAvM0m6hoSozeW7rQdGBWtUDPM/r7sM1CRmc?=
 =?us-ascii?Q?y6TFnVgiFzuoBS0b+zjH7xoPVkdsWg9kvY6GMjWuCME/N+E3Gxuy78KssJam?=
 =?us-ascii?Q?GxwKBMVvSxZAmU0T+snl6j/Veo31ZkJ5P4MD56AdM/GZpVn5zF354yXWJtbd?=
 =?us-ascii?Q?qCkupI3tz/GC702qOg207E+dUZdec8iT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yBjryJSscsNyzvX6qzBWOPXDy5h3jz8rKo8zoKDg6y7x0vBrvByswahquaeU?=
 =?us-ascii?Q?txAxe93eW94uvwn6c1UuP6ru+FCgMknXS6JrL8St9W3sLx6HD2ywZ6NOHVgf?=
 =?us-ascii?Q?uTUAynyYy4PQmCGZm//Q/KKRGQa9y8U7gqKb15T9WQ3WmaHCG1J4nAZtKrR7?=
 =?us-ascii?Q?P3Z3opt/mBvcp9qKK2KrWtSwsBxOJsFsi8tG2Bp3xchM5L0GVYbWYFExwAtI?=
 =?us-ascii?Q?hBY9QfxUbzgwK0uOlBGcBhUYSRsv/iyJ64y1ntr7zU0GTPpWENxpDDVtndUQ?=
 =?us-ascii?Q?pSNK2IXYRg88mx7KBYzay7d0zwJrQDDAxr2EKhRFrYOvX1XzkHrXWVs2scYA?=
 =?us-ascii?Q?T/FpLoYMzCPi6INr9RjpSvrOFpo8QKX2A6VUEQKlRxMyGlcojg3ZFRVUO/E4?=
 =?us-ascii?Q?ng6BegvsSjQ9BIXAURjD3gxK0L1MEwsn3aW6UyRpDIYdqSIA90wR+DMzaK+7?=
 =?us-ascii?Q?hsHJ5HFz+Ds0IqI/F0boDEWvxnTAf8CYHllyLWGkBqhf+uSWXsectco6NXOP?=
 =?us-ascii?Q?WMAfivdJOEL9mGjmqec8c7Kmo28YRAkm4Sz04FIzqEWHEw8ekMDgRafexdel?=
 =?us-ascii?Q?SvCdnSoxCsIwMhDr0Mc31o0Mf/RmyisQg4JxQ8tYZzYsYbUutkxkH84kRUba?=
 =?us-ascii?Q?VGwpbU9Jij23X+Mw22qfP1koYnyMTIJH15MNIgdSw3Ofa+tNnh0uySHIGGL+?=
 =?us-ascii?Q?nl/1WBLCTO/MPNRAcYd9bCDEz7MLyEVRliMzyqdfUe4+5+KJ053G7wsFGA+i?=
 =?us-ascii?Q?Y/V8H5CigoKFodz3wQcvRhNqNC5WKyEPoCHF5/0shibcdjtpxc+5MrDrLXwm?=
 =?us-ascii?Q?XuyojVnx7p++4XPBKDo2QrbPfpMHymkBZywrUryC7CrXK5kw7mh7US5sygCx?=
 =?us-ascii?Q?VS+P1JzsIK1NyOJdkGL3wfyGdYxqWLWWxWatt3EyuTZY7zXq3LmzhH+OYmex?=
 =?us-ascii?Q?sAMIAHw72Zh+gvY/V7nZuNnsTyZLuJiVyWSB+6Vk6Mw/4KOSpgPDaAy5ku27?=
 =?us-ascii?Q?WKxaUUj4Wy/6air2TUY26nP8ynTJhIwuMTXlUS7ltVi3iNr/2gzPzm3VEhxT?=
 =?us-ascii?Q?pu7KO5J0MeP95VdlN9oBUoTfKedz0icZbR2CTW7eWuXot2ekVSvekl4q1Djg?=
 =?us-ascii?Q?r/lAJu86msUL4geLyUlO1CRiLqtsuVL8FtHCulUTFL0iRy5tLhcbascctWkK?=
 =?us-ascii?Q?D81xpsnSkphJ/mhTqT/m5wkh1py//8teaGGT5HYgMw+nAbU0n5sgRmV1wAae?=
 =?us-ascii?Q?WUq+WDcmB5ARwzQBIfVfeC7jG93lKhaQlgqvcIZ7fwyuALttrdGcOBQvlsR1?=
 =?us-ascii?Q?Aw7gSBO9kMMmyK0fB5Ak01i1DyzvtxMru5qwGLuLlRwrRUssHMJKCgsjjRQA?=
 =?us-ascii?Q?0jLh+Gsg5kVtw5iXmWpqE7EgYXDth/huSpwk2iR75kSuprRyyxPBCYOmL44G?=
 =?us-ascii?Q?Ep6zzPzo2/fTS2/QPHKpUFuvrLJXioQF4IInBue3PWNj6qzM5Fxr5jQ2KR46?=
 =?us-ascii?Q?8ZlZkLXy5EvEtfKsS85aXOn/zec5Vpu+p/UmiaZN/2YI3L73afMuVvmrbGQL?=
 =?us-ascii?Q?xVYBbCYq09D9sQLCCYnzyB3rIeteEucp2aKXBkU7r5cyEmZVI7B0268f7bLv?=
 =?us-ascii?Q?h1up/5HS6wPZNIBQ2Bkbqpo=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b434e5-b937-4563-1424-08de12048843
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:41.0016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2joNDQmDa8aduJMXc8/SaH8WDCYjIhqRTQMuCVxsqc6m68odBzWVjgc3sosbTSyECTLFO+F/B7pcc6fqUAbNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

Introduce dw_edma_register_selfirq() and dw_edma_unregister_selfirq() to
register IRQ callbacks for emulated interrupts. These can be used for
testing purposes, or even as interrupt callbacks triggered by inbound
address translations where the IB iATU target is set to e.g.
DMA_READ_INT_STATUS_OFF. The latter case provides a practical workaround
for endpoint controllers that cannot directly access GIC ITS registers
due to security restrictions, e.g. on R-Car S4 Spider.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 60 +++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    | 16 +++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 15 +++++++
 include/linux/dma/edma.h              | 16 +++++++
 4 files changed, 107 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f914f3..7cf9e5e74a89 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -661,11 +661,22 @@ static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
 
 static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
 {
+	struct dw_edma_irq *dw_irq = data;
+	struct dw_edma *dw = dw_irq->dw;
 	irqreturn_t ret = IRQ_NONE;
+	struct dw_edma_selfirq *h;
 
 	ret |= dw_edma_interrupt_write(irq, data);
 	ret |= dw_edma_interrupt_read(irq, data);
 
+	if (ret == IRQ_NONE) {
+		dw_edma_core_ack_test(dw);
+		scoped_guard(spinlock_irqsave, &dw->selfirq_lock) {
+			list_for_each_entry(h, &dw->selfirq_handlers, node)
+				h->fn(dw, h->data);
+		}
+		ret = IRQ_HANDLED;
+	}
 	return ret;
 }
 
@@ -892,6 +903,44 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 	return err;
 }
 
+int dw_edma_register_selfirq(struct dw_edma *dw,
+			     dw_edma_selfirq_fn fn, void *data)
+{
+	struct dw_edma_selfirq *h;
+
+	if (!dw || !fn)
+		return -EINVAL;
+
+	h = kzalloc(sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+	h->fn = fn;
+	h->data = data;
+	guard(spinlock_irqsave)(&dw->selfirq_lock);
+	list_add_tail(&h->node, &dw->selfirq_handlers);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_register_selfirq);
+
+void dw_edma_unregister_selfirq(struct dw_edma *dw,
+				dw_edma_selfirq_fn fn, void *data)
+{
+	struct dw_edma_selfirq *h, *tmp;
+
+	if (!dw || !fn)
+		return;
+
+	guard(spinlock_irqsave)(&dw->selfirq_lock);
+	list_for_each_entry_safe(h, tmp, &dw->selfirq_handlers, node) {
+		if (h->fn == fn && h->data == data) {
+			list_del(&h->node);
+			kfree(h);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(dw_edma_unregister_selfirq);
+
 int dw_edma_probe(struct dw_edma_chip *chip)
 {
 	struct device *dev;
@@ -912,6 +961,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 		return -ENOMEM;
 
 	dw->chip = chip;
+	INIT_LIST_HEAD(&dw->selfirq_handlers);
+	spin_lock_init(&dw->selfirq_lock);
 
 	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
 		dw_hdma_v0_core_register(dw);
@@ -974,6 +1025,7 @@ EXPORT_SYMBOL_GPL(dw_edma_probe);
 int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	struct dw_edma_chan *chan, *_chan;
+	struct dw_edma_selfirq *h, *tmp;
 	struct device *dev = chip->dev;
 	struct dw_edma *dw = chip->dw;
 	int i;
@@ -985,6 +1037,14 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	/* Disable eDMA */
 	dw_edma_core_off(dw);
 
+	/* Free self-irq handlers */
+	scoped_guard(spinlock_irqsave, &dw->selfirq_lock) {
+		list_for_each_entry_safe(h, tmp, &dw->selfirq_handlers, node) {
+			list_del(&h->node);
+			kfree(h);
+		}
+	}
+
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
 		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..7d7dd9f13863 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -95,6 +95,12 @@ struct dw_edma_irq {
 	struct dw_edma			*dw;
 };
 
+struct dw_edma_selfirq {
+	struct list_head		node;
+	dw_edma_selfirq_fn		fn;
+	void				*data;
+};
+
 struct dw_edma {
 	char				name[32];
 
@@ -113,6 +119,9 @@ struct dw_edma {
 	struct dw_edma_chip             *chip;
 
 	const struct dw_edma_core_ops	*core;
+
+	struct list_head selfirq_handlers;
+	spinlock_t selfirq_lock;
 };
 
 typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
@@ -126,6 +135,7 @@ struct dw_edma_core_ops {
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
+	void (*ack_test)(struct dw_edma *dw);
 };
 
 struct dw_edma_sg {
@@ -206,4 +216,10 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline void dw_edma_core_ack_test(struct dw_edma *dw)
+{
+	if (dw->core->ack_test)
+		dw->core->ack_test(dw);
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a..67b0541f38c3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,20 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 	dw_edma_v0_debugfs_on(dw);
 }
 
+static void dw_edma_v0_core_ack_test(struct dw_edma *dw)
+{
+	u32 wr_mask_all = (dw->wr_ch_cnt >= 32) ? ~0U : (BIT(dw->wr_ch_cnt) - 1);
+	u32 rd_mask_all = (dw->rd_ch_cnt >= 32) ? ~0U : (BIT(dw->rd_ch_cnt) - 1);
+
+	u32 wr_val = FIELD_PREP(EDMA_V0_DONE_INT_MASK, wr_mask_all) |
+		     FIELD_PREP(EDMA_V0_ABORT_INT_MASK, wr_mask_all);
+	u32 rd_val = FIELD_PREP(EDMA_V0_DONE_INT_MASK, rd_mask_all) |
+		     FIELD_PREP(EDMA_V0_ABORT_INT_MASK, rd_mask_all);
+
+	SET_32(dw, wr_int_clear, wr_val);
+	SET_32(dw, rd_int_clear, rd_val);
+}
+
 static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.off = dw_edma_v0_core_off,
 	.ch_count = dw_edma_v0_core_ch_count,
@@ -517,6 +531,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.start = dw_edma_v0_core_start,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
+	.ack_test = dw_edma_v0_core_ack_test,
 };
 
 void dw_edma_v0_core_register(struct dw_edma *dw)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..42daf9a76b56 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -101,10 +101,16 @@ struct dw_edma_chip {
 	struct dw_edma		*dw;
 };
 
+typedef void (*dw_edma_selfirq_fn)(struct dw_edma *dw, void *data);
+
 /* Export to the platform drivers */
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+int dw_edma_register_selfirq(struct dw_edma *dw,
+			     dw_edma_selfirq_fn fn, void *data);
+void dw_edma_unregister_selfirq(struct dw_edma *dw,
+				dw_edma_selfirq_fn fn, void *data);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -115,6 +121,16 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+static inline int dw_edma_register_selfirq(struct dw_edma *dw,
+					   dw_edma_selfirq_fn fn, void *data)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dw_edma_unregister_selfirq(struct dw_edma *dw,
+					      dw_edma_selfirq_fn fn, void *data)
+{
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.48.1


