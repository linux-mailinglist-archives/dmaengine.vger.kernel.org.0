Return-Path: <dmaengine+bounces-6364-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA24B423F5
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 16:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432D87C71F9
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01EE20408A;
	Wed,  3 Sep 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jX3KITND"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B831EA7E4;
	Wed,  3 Sep 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910798; cv=fail; b=frvoo/U2RwxFWKxmBgpBF3/wVcT9/LXRf/7RBdIWByMFs3XA6iJkBelxECaMS4zdV6YK+Qv/E2pddZ4zCiuZCHsOkUotMwrZpCdduSXFUg+oYIktJwnGB+fkTMGmG5ybXFQynjiEZC5CjYE36Ysfqq09xfA71FSoniKUPoQd7pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910798; c=relaxed/simple;
	bh=Idd5s18wsJ5MHPmteoVsPW49EDjYrmt8XuKTpQog8wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aJhhDUN9sVbM4QAgvOsdHG62jq2zofGuefVniv7JvsKQEZN9gPr9MW3KLpa83BBB9YbGa25feJCg/tbousdk/7ZRuIobdprt7iAhAW9170+Tnt3gDdMRi6Ef+Yy95KvGJsnjBMPA/g3H03wVYhI88dclapdW49CZp8/q6ZConyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jX3KITND; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA2Lnc0i5TXN51i/E4mMsho+QJLX9aJzNe3bHlklZwIpnpr42lGl0zINoCap0qtVABl6IqBiOAdhg6yNs/GwVyZHjwOJH1UKsixK9/gi7t0XA6Tanb8NYIG/FGF1cMLy3UER2Hbm2R5tBq0xmd/IuzoPysNPbUG/D6B9K4NzyV4gLXCTszzULKhuD3LMpxgRjsRxOiOA3r5oB2IsNoMln0nbCvfSi5Ep/+eb9Z6nuESscPlT2DSixV0+GbBxlEoTehpL71HVdIaOXyg3A93n3yZMuWjMEBuza1903ajq6VQvGR0KSfnOl5kTlYfKGYrCOlUI1VUZsLJvgxqnUjsdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poq9ZQ05B1ue/HKKmitvqsBg+yynD+ZMPKISQz2JGzU=;
 b=BrW5bz6X4s6LKNaxyOGe/K6yAR626Zjvwvr27TxFRTficooOqGjS+uVk3sI8N9rfeGMKOIRHy0wNoZC79mbxZkxjszaEa8YYBvi+G622Wb29iw0ADGFj8Jb/2GYRwfO+Udrd+Xr1l75VaRxsdlVbOCtMpG+ALUGbzQq/RmOAhjloinqJLclhUUUTxlNNw0hxafEsNq/S/JJg86H+YBA/eXjlcnJzfMxr2DV2Odwa1+sYs+9OyAmE1rh90lZXCvGyq2Z/Nf3B+NSuUqGApyPD2O0+gZhSDZffOGh0f6P5JDmhHybQ0mCdlQ0/Z8NXi7NPXUjnc0f+ASDBlVtHhXgZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poq9ZQ05B1ue/HKKmitvqsBg+yynD+ZMPKISQz2JGzU=;
 b=jX3KITNDWQ72P3SJS5KK8gxdiBchBPTy3+cq/24wO2QU3LSFRoJs9XDL+UYs6EdtCllGtPFQs2znvcrWpJBVsyRjW1T3TO9sEyLtZpvRs70BMueoYcl673+csfBauedtOcFfVRgoAt7/W/rixIarP9l9dfwJWNgQxkUBeZ+ouIxJmBiW8UKLvNISueKl746PNhIP7QwW87sO+Jkc6PMY7ff+BT5pGOmEnabpvOYBkZU7mDrj3KX6s7rxgMMc+zgzNumEHSvdp8zgj+6dNT6vgqItwDWJ6oO4YJ/tnpPeuI0Sx1aX9Dk4GFv1HTWwSm+ZaaLxi7p3Xqrs5lzdC2aFRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.15; Wed, 3 Sep
 2025 14:46:33 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 14:46:32 +0000
Date: Wed, 3 Sep 2025 10:46:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] dmaengine: add support for device_link
Message-ID: <aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de>
X-ClientProxiedBy: PH8PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9fcdb8-4678-43a4-0937-08ddeaf8ac2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?siX3A6EKMNNTFXyMuTk+AUW+DaEQgfQFyXkSa/tw9OKhLOeoVoX7y+VjgJxg?=
 =?us-ascii?Q?kZpjA0wF9HZXmC17fVWcjftzAi9owdOGni5UEBeNHXkgTtjI5ydxlN/fSe5r?=
 =?us-ascii?Q?+ZoDJ+yZT54gEYym/sx1+/tfkMV9TYebU28fCj2tqFHZJX9eIxI9ChORcm4K?=
 =?us-ascii?Q?61P35lZpjr5cavoGPln5bBqK+vgE2jz60eDhNX3JWaz3fZ2LlxF6au2Pf8Nq?=
 =?us-ascii?Q?it30Lt0h1p9cjw5bKUXBg/KLqfze/JAU1be8Y7dB0xNZ2oHBUOc9wj5nIeXO?=
 =?us-ascii?Q?V3otyKc6fZ2OUll5cDCciPaBe/lVkdM2di/zqpdanTE1k0XLo+Tpe1FKlHD7?=
 =?us-ascii?Q?iaM1l4OAnvvdsh+4cIgG9a1XZDbe7fN0dACRG6Pkq+dNImfrO1qokRSiB/z0?=
 =?us-ascii?Q?W3Je0eNON4+VZ3VtYe60KwNrBpcZ2TNM/oJBq5f3Nca/1CExRY67ih3jyfjR?=
 =?us-ascii?Q?WLP3j8gqkNpGteQOa1eDj/KQSPr3PFY2G86PT9D8m3g150xWIDUZIqPpbTpo?=
 =?us-ascii?Q?D1tDu2RzNTM/1d+RpVGDhC4DOEvozqMfvOahcA92p1flLqZ1aR5fEQYWn8GS?=
 =?us-ascii?Q?kj0vYtuGBC/pKzZtEkFn0D78ilSzD21fvG9g+zO23gm7Mhpyy+no6g3csHtX?=
 =?us-ascii?Q?9xaGV3UcAiLXxfu9n1MejmufWviiq9RG/uy2C6YxccYThqT7p/6r3NpigoUz?=
 =?us-ascii?Q?O1Aw7iof9+B1DbLm1w643j6aqzsscaNwAn9nOMy4GSTvVDbAJhf64wtzz35m?=
 =?us-ascii?Q?+qGgQV9uaFEqbdqzg1nB56mdB9j9uNeynl4h1HlDhULsI5QABEIU5RSVyvdS?=
 =?us-ascii?Q?4jxWugNsyNJ6r7Gw7IYCZ8rX/Xu3I2tSQSpQtevPddkXFTIlB9S/i7z+3yRh?=
 =?us-ascii?Q?zWYGDvkMNxaT0L762zqsKtYf3c903trSSHfy5U0YteqE56y1pcjxtrVTLQlD?=
 =?us-ascii?Q?oEzOeaNUbbNpvvCJJ09H1uocLU/uYMOOX3lU92/q2apYDt2KKgQSMlmnQNPT?=
 =?us-ascii?Q?H1+Uy6k7SxKIKMrQrIwF56XWy8ZQwKtfudFXz+9+TGhgs4BaMUmMDzwyCsG8?=
 =?us-ascii?Q?VgVSncYni56WDF3HSL2dsY4s2BVYOaBiRQb+s8MP16o+V3hXFE3BMjNezz/w?=
 =?us-ascii?Q?pTgOMycSruQhvPoJ7f3SZYhq/Yg8pj7aEzqCrlx9EVWVlecr/5GxHB/kDdMS?=
 =?us-ascii?Q?9fRMImN7fXrygTDj3snGOCYKueFK1uMJ2ycWrLR3Nszd48EMruquIeYMIhLc?=
 =?us-ascii?Q?C3TaC1YfYyRrhJZDFwYq+ZypV5Fblic+0RqFudmVFOAzrgHwN7f2dRBeR4kT?=
 =?us-ascii?Q?PHTrpUmRZaulpBqA385DiFjBEMFKR1Ty/LzKtgy1Xq305WIdyA/7sMUhhF/d?=
 =?us-ascii?Q?p75R12l6VGGbl7pO3yLcbUbh3vPYBMydOKVgq8wkQrJPfEoqtxdwJRaoWhvn?=
 =?us-ascii?Q?euiOV0oewq0nM3B3MNRehis1JZQPH7YCwP5JB73yMf6vwyYuQkSaqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j6zf8LvyzlZmlQb/LoeRByAzIViPcA4x0Z1nTvEiiq/LwWPNsk4AS0UIWuxe?=
 =?us-ascii?Q?0TPcfSxn69ewMnkS//9J7aKFIZJDakmLarYSmOdMXtBCb4uADspaaO5Pqlsq?=
 =?us-ascii?Q?D+M0jMy4G2TYW9Pu8I7TQjPgTAs4Ce3x6OfrXGYfNR6qQ+Oot0kBBKpVeeBD?=
 =?us-ascii?Q?9BO5dmWMG0iBxbhsWYAbd3UyXhBEJ4v+8VBKKxRe2mmyAcP+r0r5w4bQPdRB?=
 =?us-ascii?Q?MZoPffAYeHgb0oLbytSakpKOlP4x+kwMwo0e2h/s5HMNG9ZPT9IyEsefNipk?=
 =?us-ascii?Q?u7u0aYjA3IM7fuXI8AkH88smTxScW1e+Qmtfw0iiZy59v5QmmNCP10xBHfZe?=
 =?us-ascii?Q?m8SK+/zV2yXHsnjcZII7sSRpdxqYy4KE/X5Z/AjmdFOObpKS14jux8FzzQ2f?=
 =?us-ascii?Q?0WluQADVNqp1I4y5t8Od9rV7qg4yi/yIkMrmeXUs6iJ2uXb3urE3MLtrq7bp?=
 =?us-ascii?Q?6BLvISpgdrmxNbihLE7MEwXUoXeeUi8nrHRZ62Wcxvu7NPLBTv2J+qKvFaKc?=
 =?us-ascii?Q?jX2ov0ZlpryAozabdDoJD2EQdFCZjR+Rwe5iLc+Kti1fFY/X8GtCP/miKoVp?=
 =?us-ascii?Q?XXM3xcMz9j4gzB+v/E0yXEC1oMICurVxClB/fLBmlfURZk5tqnBn9jkQaji9?=
 =?us-ascii?Q?+IpQwyZ8rq1OxoTaD0ifhdEz4/DXLWRhRdKTzX41lrgkS894fzTMN41edAZE?=
 =?us-ascii?Q?QfwPdj24ahQpIl2v72KbpnIxEfmssLhIthuoeST9dimGbvLdgCPsQ5uS5Fec?=
 =?us-ascii?Q?mR+RWHYLpcysyD5mfGPL8HapchwyWQjtv5Ej0A47wl3tQtKoDfHD6qGgJNar?=
 =?us-ascii?Q?AQL4GdEU0+QKWz9sTOPuFO5q2eg4r8u71DT182nNT2LYYSbKUppsD+kTLpPc?=
 =?us-ascii?Q?fJWzhIy8s/ZOXVTglzZPus49ModcXAkTPneHDkXD3zkbczO/AygYD+l67lQb?=
 =?us-ascii?Q?9o6Z2GVpo7MHgf9ByB1XH/bQ2dATtoj2ytyjif/eEjzAsfaly/ummy69lHnt?=
 =?us-ascii?Q?ZxlUwRliOAZoNhLZmEfXHHShxdKldX/RcGuDk239XhaZ2gQphdrRR4XSLULw?=
 =?us-ascii?Q?ZTx6q+ID+D4JmB2WdLGNranbdFcQjS0cLtqi4hzouhSKGP+bfPrYVLd9rHIh?=
 =?us-ascii?Q?jnIkWTMkIOQV8U6W4Sx+EMggjrQTDwbhYIGvwpWRzvQF8qHwO2R4LgCcVWjz?=
 =?us-ascii?Q?Jxj7h9aoivA+ZydVG+agcpyZLMKk6L/BiszRulNzrYuMvmYVKC0wgWrr5WvK?=
 =?us-ascii?Q?2S3qfUg/VBeVpEDqN6JGQmFi0V6wony7vVp5rKMIwBEkzBIPXMDQSh1PyiDe?=
 =?us-ascii?Q?7zgHfofAjOzt6KW+8DsdU2pmQEAG+GY9YdwJXzar6gSgwsnELzOgLK7XCcB8?=
 =?us-ascii?Q?cuCLDxnK6mGJTj6kpk1xMqeFlRL+FBMtSD4LzkK2rq27KKVLZxGCrJ2+8f5i?=
 =?us-ascii?Q?9dnhYltYGy1Ipgf3kWRuaSq95blRa8WmQLA6HKhi3YeEW6jzgS+fI0/9Un4y?=
 =?us-ascii?Q?joR9G2X37ay5s7Kdh27g3dCAeiJMkY06PRqxcXU4QZ/F0VBYOoEB/fvYpagi?=
 =?us-ascii?Q?sj6n+B7EukwHonB3UzQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9fcdb8-4678-43a4-0937-08ddeaf8ac2e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:46:32.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs9H7wbdPQrgRN4EAqfLcFf0FXgtdzOZgk4jRc/3yWIMBr9tg86Up/cT3N5c6XoRTlpocDfiSEfrsNPfBXumrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963

On Wed, Sep 03, 2025 at 03:06:17PM +0200, Marco Felsch wrote:
> Add support to create device_links between dmaengine suppliers and the
> dma consumers. This shifts the device dep-chain teardown/bringup logic
> to the driver core.
>
> Moving this to the core allows the dmaengine drivers to simplify the
> .remove() hooks and also to ensure that no dmaengine driver is ever
> removed before the consumer is removed.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---

Thank you work for devlink between dmaengine and devices. I have similar
idea.

This patch should be first patch.

The below what planned commit message in my local tree.

Implementing runtime PM for DMA channels is challenging. If a channel
resumes at allocation and suspends at free, the DMA engine often remains on
because most drivers request a channel at probe.

Tracking the number of pending DMA descriptors is also problematic, as some
consumers append new descriptors in atomic contexts, such as IRQ handlers,
where runtime resume cannot be called.

Using a device link simplifies this issue. If a consumer requires data
transfer, it must be in a runtime-resumed state, ensuring that the DMA
channel is also active by device link. This allows safe operations, like
appending new descriptors. Conversely, when the consumer no longer requires
data transfer, both it and the supplier (DMA channel) can enter a suspended
state if no other consumer is using it.

Introduce the `create_link` flag to enable this feature.

also suggest add create_link flag to enable this feature in case some
side impact to other dma-engine. After some time test, we can enable it
default.

>  drivers/dma/dmaengine.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 758fcd0546d8bde8e8dddc6039848feeb1e24475..a50652bc70b8ce9d4edabfaa781b3432ee47d31e 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -817,6 +817,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	struct dma_device *d, *_d;
>  	struct dma_chan *chan = NULL;
> +	struct device_link *dl;
>
>  	if (is_of_node(fwnode))
>  		chan = of_dma_request_slave_channel(to_of_node(fwnode), name);
> @@ -858,6 +859,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  	/* No functional issue if it fails, users are supposed to test before use */
>  #endif
>
> +	dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);

chan->device->dev is dmaengine devices. But some dmaengine's each channel
have device, consumer should link to chan's device, not dmaengine device
because some dmaengine support per channel clock\power management.

chan's device's parent devices is dmaengine devices. it should also work
for sdma case


        if (chan->device->create_devlink) {
                u32 flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;

                if (pm_runtime_active(dev))
                        flags |= DL_FLAG_RPM_ACTIVE;

When create device link (apply channel), consume may active.


                dl = device_link_add(chan->slave, &chan->dev->device, flags);
        }

Need update kernel doc

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index bb146c5ac3e4c..ffb3a8f0070ba 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -323,7 +323,8 @@ struct dma_router {
  * @cookie: last cookie value returned to client
  * @completed_cookie: last completed cookie for this channel
  * @chan_id: channel ID for sysfs
- * @dev: class device for sysfs
+ * @dev: class device for sysfs, also use for pre channel runtime pm and
+ *       use custom/different dma-mapping

Frank


> +	if (!dl) {
> +		dev_err(dev, "failed to create device link to %s\n",
> +			dev_name(chan->device->dev));
> +		return ERR_PTR(-EINVAL);
> +	}
>  	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
>  	if (!chan->name)
>  		return chan;
>
> --
> 2.47.2
>

