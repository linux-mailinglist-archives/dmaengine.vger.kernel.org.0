Return-Path: <dmaengine+bounces-5187-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3450AB9529
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 06:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F174E7ECE
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 04:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74722F775;
	Fri, 16 May 2025 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DVfh8Xj7"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70522DA06;
	Fri, 16 May 2025 04:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368403; cv=fail; b=h06lCu2nvBPnvHw4Y63CG9gRuVjrMDYngWWO0r5JV1XpdY/MwsQ7ThmvAceIy/IrPe3PaTO+WQg7bqWHXN/DrYsPd99UKYpbUBmuYo+ou84qIDzBtz6H5nFsxSpBFFyqLfImFy9/1OVFuEY968iwWohjFicVG8Z6lP2+66sZ6R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368403; c=relaxed/simple;
	bh=RmYiDEFxaL86BjqgedUPHgPK13934LCtF9SThhV+myI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvjMMdiqQ+hAKFLxIWH6bZAoFMu0/nNu2cjXFi5IbhU0t8XdYLA/pwRAo6aJl5zyBJIsaqE0D4MbIGhqr0xZ4aw4gtUl0DV2e5/mFlgpx7eUsFEi3XxIPaCbgP2cc9Fm1w1jbcqWxHS1fAkjLl9eevAPvgmjs7QpHT2ib3lW1ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DVfh8Xj7; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxgtBonvTXqkUZrWq28vW4Y9t3icEX0+wqArrNHyPHYNORIjDPhCOnoUS9hbsUQ6zFyIrjGey+T/v0TJA6+lDxA+aNr0lsB6K+uNRzpc7FG45X9/Jf3vQVq9h4PFKG0+E1neKSa1EnoMReh22eqYSfHPIc7ek4/csorX6WTYvGAXjdi6MuaMgId3hgoKpcUVd6iEzmNkSXVSlBzVnDa7U4uIANsvr0wz9dr/r10C3aFsn7LrXiHfOo9dZM/OgacwR5SwbYnizV8foAO9aWn1QMjDsqlvbnz5iX2L4acgk+WsdJwtuJZhP0i8DB0DLmdcTjWZF6uUGupvc/Dim0grdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svsmrJu6eavsxnvvNtdLDWYF8/h+TcRoSMfYsGq1aJE=;
 b=AT7MGnnT2mZVNiEMvi/v2XnA+dStFYSO0z4GK/RfjSpObQr1Z8RSdGRdtmH8D3VaoBjs5G67Ywh49EaIB22XO29PZyz1ZNukHf6YY/TzVudtI93lkLwKy7srchqEdbjocukXPP/yAwxVd1hk40bTHDTLHmPhsytJ1SDvdH89bvmAovyMPfbk/bT2oWWQrV1ujlM7m1YZuV/DMJK+hs78Jh5yMubYIqAb5IFecNWCy6VaXFgDkzKNR/1eT2BkzkJO9upq2H43T52w/83iUV08sHwF3++4ISK46oZAIg06oPg1TRDG02W36k6z1JPRIMkqIYdln2J82isMxJLQjE/KEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svsmrJu6eavsxnvvNtdLDWYF8/h+TcRoSMfYsGq1aJE=;
 b=DVfh8Xj7vYI7qulXMyZHnCunr4vg2GF6g3Hg1MAUT+ie7BfuCSLcJk3g6/VJnhZ744s76FzS7oEp+KCIrVnIDyztNyLsaWOjNfgHEGosE3U3OrwwHbrmOI7JMyeWhsQ81j9tImwjQOk045eJlgP99KEl1ZzEQIUuCxGO/XtCEpxLWW9svb1bUYkN4THx1eOI6wUzWG0hElze6PFLh/mX0ON+UNoBcQVUsu5POq5RbyFoPhQ7d7RlmoxkE8wFYJoFrWijfDTmxErg6FkSqfpLkNem/4E/64YfW/So5JYAuH6/5H/PLpvaCgwfqx7t/HOL/hrz7t5s8osBw/ss2hYobA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 SJ2PR03MB7093.namprd03.prod.outlook.com (2603:10b6:a03:4fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 04:06:39 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 04:06:39 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: [PATCH 4/4] dma: dw-axi-dmac: Add support for dma-bit-mask property
Date: Fri, 16 May 2025 12:05:48 +0800
Message-ID: <a10c000b7c8301018eb2b0a20fbf2d2d10e74a02.1747367749.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1747367749.git.adrianhoyin.ng@altera.com>
References: <cover.1747367749.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|SJ2PR03MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f118de4-078d-47bc-b92f-08dd942f0ef1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KClMlN3SvPbO6+3pYuOk4KgppjOu4xjT/VcGHq1dF3x+SaxEzcw6xj5P3Yrn?=
 =?us-ascii?Q?Op6bwnYwiUqajRZLeLEPkzEW3uDSoOONnezH+Vs4QoOUjAaBTChVoN4wfpmP?=
 =?us-ascii?Q?yLhIT7wuUjqfxMboXSZ5FsLZCTwHC8rjFePOVUCyD17rgJ+/GlgVY2r5ks9O?=
 =?us-ascii?Q?bmtbH6EagHGOwXD4HBNBZHgZsx1+l80Md1v78hYUKlYH/QWZcLCTV25eZBkt?=
 =?us-ascii?Q?S+I4POhGjbz5F+1mguaOx07+JlB6uZFHOcFGxHPoVOetamvklRvOhT0SE81z?=
 =?us-ascii?Q?yLfm3j6zLTQyR0LDlI9sXngZYrtdlnVVrzoRzoRE3JaBWJUxyTEVhKOVYlxs?=
 =?us-ascii?Q?houataMdRj2GJievAFcXTTBdhvuspGiAcOruBwJbybKdKhEUxazlZr0b441H?=
 =?us-ascii?Q?Q8uN+aDQ8fLAQRQTPpBcBl4gUGD6f9euVvjh0Rgvx/Y6xe8iwScQ9c7MfTha?=
 =?us-ascii?Q?/svKC92ZZbYbJdlxXzRPsNpuFGkzA9hBkF8QOHu5FCeCJT6D0aRjgqLEypDD?=
 =?us-ascii?Q?c50f5NIAo8JPA6QNWLw1aGs9MZtj9aGXA2xBaGwI7rnujdQYRAcBb9wBDrcN?=
 =?us-ascii?Q?f7YAIoLrWTMqQ06KNEs7/5itZ9AsNUp7dvhuuikMbmf12939vnCptMoB/QV4?=
 =?us-ascii?Q?SvnPbT53iEjmlZzuEhEQdV/X9Wi74euJGLE7Ls1n8yCadEkP8ntUufUITOAZ?=
 =?us-ascii?Q?sbEmFukQ7wOcPOSolZqof/wWMVLJezu8k4mTkOMJF+NAguHGK+07VT4tSh23?=
 =?us-ascii?Q?rZ4KA2H9PzrRSTfMNMEyl1XlDB6VGIHJFXDFCJSlHzMo000XQpyg/ti03pJX?=
 =?us-ascii?Q?ods5PKawt1tEd/t5MQq1Gc7hfHdOQ3GjmbboHonYUqyWeFP6KvZRd2j2zSHV?=
 =?us-ascii?Q?wilSD4xgMNjRUqI42WFnJy+6Vt835pLmeKOJj2N+pZ42sfubakOD7xN1iSOh?=
 =?us-ascii?Q?LvuVD6vPYF+PdMsd9WLrmUy3WkBL1tVdKCxAwpfn9dgGTQ+yl5bWh1M/R0Bl?=
 =?us-ascii?Q?duo+c/nXBwX9e2/mX+qnHUIABJJ1NG13BrAjjWewyDRj+R9pRcS9/Qk6g7kL?=
 =?us-ascii?Q?kOvBp5U6e6q+CFFMU5VyEKv97kH4zdgxNTTFdqDZt31vRjK4u0SF0dm3o1rL?=
 =?us-ascii?Q?oL62VVYJb8fnm3fUo5BBJ5HHuR23ndtMJ0XyQGby2WUgkIDdI28ImGldVhgm?=
 =?us-ascii?Q?PJCQaQB8Vo5i7I0rUJtP7wqpNym0+asKecn3g9qxr5J2P1gI7CT5zdI5kKWY?=
 =?us-ascii?Q?y4b9UVFWFQQHoeh9lcv33+XMUtpzLpwudexxJxuLskLvzjOc+2J8Qna0Srnj?=
 =?us-ascii?Q?3cVt68uUYYFABJbYhikcDJr+UVeVf9l34+J/ZllvPeK/nn5dYNdVwdzqsl+f?=
 =?us-ascii?Q?fncMCOhsq8eoTrvfMJyyTtQgi5IiAL9Cldn3SM+tkqAzHzolCOCLb9w5pm4w?=
 =?us-ascii?Q?5h09VZECmfY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XTJaDIdjROFmks5wEmrA6BALm4sRwgoyg/OgtmmkeMVYZ0tJ6SS0wfMkFvgZ?=
 =?us-ascii?Q?o0uv4T+HAN9EdtgYovWxZrQfXJty2RQU0unYL0UIXQ8iQ2nk1YljFP7b9US/?=
 =?us-ascii?Q?nijezIIm6chew+RxzZJseu/s0mz7ZLdDE/mkO+WkEXFrlsbERISNSUq+e2+u?=
 =?us-ascii?Q?QJ5hTFOrVqVhj06aL1DwwhkB29HyXE7u9stKuIo3cMTyTZg1UDKcGnDcjV+A?=
 =?us-ascii?Q?9Lgc4a14ia3U/zzSe7mqHK1RVL4agliD/+VkGAcQKN97Z5FJ4I9lCegz0SxZ?=
 =?us-ascii?Q?SCILNSe9uXpn0L5gXAVHZDiUL1gyH9S47jH332dPfYdr+7kJ6TIoXvDPoVJ+?=
 =?us-ascii?Q?jg2D9QCwl5YQIhWkRanuYbpSSt7iiNT5I54cY8sUZ0KCg6mqo58L0Iob8H6C?=
 =?us-ascii?Q?lwa7FNFBavwcQKNJNQT7biEzfPhLTQONXZvKBiBEwNUgP4BmgpYgLq2iVooN?=
 =?us-ascii?Q?Uu1vs9WkcTorjsFEGRC/BdvKlMjqJeeEraXOWh0qfdpauk2tqIYPzWEOncmT?=
 =?us-ascii?Q?k/T+gArgbIe07Jr2+S6bRk8vne1KyuYojXGx63tgrNTEH9GNvXaWEdTWKIM9?=
 =?us-ascii?Q?D+FwmQisgOT6kvP43BUoFtPmpJ9cENy6YjhSz+IvOdXUklUatfAp0dPF9cpb?=
 =?us-ascii?Q?geyqbXSuZ0yRloSU2WRzjkNO4AF1jRgr/RtihgYuEYwRvwncKTQGhQ8yg4rR?=
 =?us-ascii?Q?pQslvpncNI4j4VMLoX9NAkhXZMKCEGJuXh0VC7JdgC/bl6G/t+Kxq7DQxkIp?=
 =?us-ascii?Q?W8hvkOyXwiVs/ETcHN3rTvJJxiGaDCvZs4sSjGTARsom9DXfVqIwbl1xhToi?=
 =?us-ascii?Q?dbFXvN8Y22EYennotG5T2u4hdieuCzQJoSiZiJC+34KOP/2cbbt7abrE11ce?=
 =?us-ascii?Q?DjUMBmiB40qrrkdzOk1WNskzl6QlcyYJYK2QiBkWLvRp7Mbn+jEu1L7W9tut?=
 =?us-ascii?Q?Cf0LGultEvIZ/GPvbBcjDtnO/0/WpADO4MfQOPmboTN/yztvugELvHxC9Bhc?=
 =?us-ascii?Q?U6zwNkZSax7xQL0gQnC3jpDr55tFX17awjENeJVc4HdkvvlR27hra8pZ4h80?=
 =?us-ascii?Q?h03R8iwoEFlhSilDtBGgDxUK7TEGeOqSufz0w6mLEwV3Fp6837mV4DvfQdcZ?=
 =?us-ascii?Q?Pv0mxCIXa0MpNpWpbJNB9F1GAiI/NmPIWwYWqoK9Z0LL6HIr22ok1hrwLs7f?=
 =?us-ascii?Q?ci8r5Dk5RNK+RSLGJLCDc8CYm3T3Gbgc4L7oUP4v5+18Z933AvQP7Idub5+C?=
 =?us-ascii?Q?qXEf3twN2iVskZLpEda0sNOQ4YTph6VFEBJzJ5vDUi1U9gXJra1RHPyQWmd7?=
 =?us-ascii?Q?M3YVp+D9UAHUN9uvm2k2YRymuYUaKSHhaLafbTLqcza4L1EIogmCj+WqCQOv?=
 =?us-ascii?Q?+TdHgvLFcr6CI0X6WLVjjCHwmuJ3p+zwl0poUEYoQvEyuIT/rjsaR53tQKlm?=
 =?us-ascii?Q?DUYxeNj7l618dDjaueETFApTPSjIHHwT71e5+zKJR0r5k4DVZGWo5TSNtow9?=
 =?us-ascii?Q?Mx9bko8O2OztlfgovWM9s8BLal0/XvoG5HX/ka50foTqiJOHUmpp2KE73Fh/?=
 =?us-ascii?Q?2x1WoFZKnSlha8yQ64fXhp2C8AsLWbP3Xed4gw9hgDh87OcL/cGvyGQTiAUU?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f118de4-078d-47bc-b92f-08dd942f0ef1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 04:06:39.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40jg7LUYBy6DK4N3T8fHPTR2Q/jVaGJPj0cPzVw01iEPrY0C3vxPbjjaty4St4TXit4/0d2FpqY+ECKnurSvGcpVrLYo8RbBzb28LK7s/m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7093

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Intel Agilex5 address bus only supports up to 40 bits. Add dma-bit-mask
property support where configure dma-bit-mask based on dma-bit-mask
property or fallback to default value if property is not present.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..c345fd4a374c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -265,13 +265,23 @@ static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
 static void axi_dma_hw_init(struct axi_dma_chip *chip)
 {
 	int ret;
-	u32 i;
+	u32 i, tmp;
 
 	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 		axi_chan_disable(&chip->dw->chan[i]);
 	}
-	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+
+	ret = device_property_read_u32(dev, "snps,dma-bit-mask", &tmp);
+	if (ret)
+		ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+	else {
+		if (tmp == 0 || tmp << 32 || tmp > 64)
+			dev_err(chip->dev, "Invalid dma bit mask\n");
+
+		ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(tmp));
+	}
+
 	if (ret)
 		dev_warn(chip->dev, "Unable to set coherent mask\n");
 }
-- 
2.49.GIT


