Return-Path: <dmaengine+bounces-6478-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F28B540AE
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 04:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C771C27B43
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 02:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BB2153D4;
	Fri, 12 Sep 2025 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oKFTl58w"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30F155A4E;
	Fri, 12 Sep 2025 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645491; cv=fail; b=lHmjJ74yGHpBPzNKG9QKibTafICReMsFotXG4K3C9oeWmQY81Ru2ItSdHePsx+gxUOYn05TJAk77XUrIqtLgUXWtIE23pSNI6T9CHKVxrv6KxwcMguh/PMrR5kvvlvz/q6S1C5p5pMTCVWdWaYKt07c6mByW9UNHeRBewHmG3As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645491; c=relaxed/simple;
	bh=ty/0O7RUE+q0SIE7LOy1W7XBFBdxDeGCn/cLYyRb8bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bg2VKv0fm5uPLF5EHWf7UWVJPHapeHV32VRK26txE4MUt5/aawLFjJoEI5/BD9QtJBzS7npQ0jGuNi+AK3xTadKkauZjoYNBL7924wBU2GiuImcNl5elA6yc7QlzNFZMps5R51j88w/4CLYkvr+AcTtRGPI/DorI1xxemfM3jVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oKFTl58w; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+4CY2XKlFWYqdDDNFXx946H+DcwZeg9WjhZuAkM1NiSXsBMbJWGmPUmxK7n0hiS0PGUHkrzSZVXd5CSpQM2D367pxrMa2yG68DW6i8Bxy4BDqdnYUzPXG0B9HUPCYsPQYp4KjFsJXvtLuJt8u1bj5NLSBqKRshvN/zxPVsQ0RT2dNmD0VcP5Gg2v7sgtWJ71RVZ4uU5Yjohs1wTFmtlZsIzpSpWGRwasB3ZHgsD5Ku4kTEIJT1of+1YJJub+DekrhgCQd8RL1rOqmMU76xEv6WthI8DQJ79YhQVaB9OpkZCnv9YvUa7WzJarpY7nN6FZ4kVckQZyFWhF/x7z7LZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty/0O7RUE+q0SIE7LOy1W7XBFBdxDeGCn/cLYyRb8bE=;
 b=Bo+vdiXEtTnPCJkw03Rx3E0ZvYng5bMbijEWOYSIiDioPrdqUw4RlsU4K/Za62JulHUquQT4zk+PcIMUmwJo+ccRzjYbEl19I+bRU/Dk946wKrYHOmWuhoXNW0BXe+XOy/4oCDj8jtvkllJKw2NrwptOSnFux+5AHgcCVZ4Jv3VRW8uYmuqS69aOpC391yIHHQTDUXNXw/bJ5omOzGw8KTa0UzNNDYb8PvFKGLT9Um4P+sHeVuEg7t7SPhZJ4JpX5cTZi2bMXQpHkkOSTIsd6u0VsBX0LYGDLm9jLT5v5WutpPCi3UKl776gbwnrKqQ1Z0Qpp4fA6DTr7rkL84jdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty/0O7RUE+q0SIE7LOy1W7XBFBdxDeGCn/cLYyRb8bE=;
 b=oKFTl58widSaFItLP8eLnWc94ZvYUr7J6szvemLKKVsDJLRRf6pBpwKHIy+3XHcwu039gz5A1s7Yd7Tn1jATXMGjgP7SMw8D6ujAgJIg557VbXc9+LmiWmatB7ZnE2GevLDA1ovB37uF6o+3sbJ8TNXjopQ6dyhLJpdJ3HKp8/nGDS10uU21m+oyQlU6PrPBywPMyGH62q3fa6KjaJQusA3zjcKA4TiVhzgJzPWYrjfVmH9iNExlmfH1pixjGHQzHapIylbzMipp6yi9IgDcUCjMxpPZ3O4I6ZuHmsv4jehPINthZqxCvaN0WDciyQn8fU37tjlhR4RJgx5tc1280w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 02:51:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 02:51:23 +0000
Date: Fri, 12 Sep 2025 12:02:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma_device
Message-ID: <20250912040252.GH5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-8-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-8-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: cd55a694-172f-4eb4-1e4a-08ddf1a7424b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GAFDpjTGFDJnMKrNS06GFbKsCXjQLO4IoQdR35uBlPLQer3xmlIgn1wpX2jC?=
 =?us-ascii?Q?5QV0KCbYCgWclEl/P0+crI2hKyzXgKrqC+UTXC5wO9VNybgIJ8IdwaHZQzFo?=
 =?us-ascii?Q?cZBgnWRmkHPIEogIS5M8Z5hqPzljqwjc4I9XZVleV/cNgJSuffQ23EoCEH8k?=
 =?us-ascii?Q?KMPVWTiT2DMjy2VBDJKrO+eDK3nLBaY/O+XVM5QBkmXiXJvK2hHkLFjXlJTP?=
 =?us-ascii?Q?g1YXWwEnN7cNmsk0HIZ/NRp8ZqT6n478xKp/KcxOdudd940slFW/kO+mPGFC?=
 =?us-ascii?Q?3p2Ggdh0y1H94u+wmPydYfeRdWx2TDkBlFUN2I61DLVruRC7gP/M2jBIofWB?=
 =?us-ascii?Q?cEWSVenb8P3eQ/xAwkj8jR+CPjsoocKNNKdpbGH+t28irtZ1QXCFduSrbJmP?=
 =?us-ascii?Q?Ei1e/nw14i6lHXOM6leKg7TkMZcbTbZB8UbH6CecF+qeffw+8/+5T9ldvPFV?=
 =?us-ascii?Q?K9xa2gDlYkd2zTG9D8dblREsj/oYc5/2dR1ylo5fobN/G3k/igxh7+FXh11O?=
 =?us-ascii?Q?vK+jz9fh2MMpFVeo7Z1VKeWrfQvo6oq3xzj4A/cQkz5+yjR/8sD4fh+kaAAj?=
 =?us-ascii?Q?7NW4cCRqmPQnG4fQLVDX5B/QUvNHaONXHS1E3QnF5rsRMiLTVl+KiiLcHlh+?=
 =?us-ascii?Q?Jcx9Qfe1UdwAYTyx4URb4IoQ46pSSGJU8xLMLYODXjYO85G+5urA+QYBzrDf?=
 =?us-ascii?Q?wuYF4fI56aBe7GzXbo52S8chAKfte+UgD/KsGiotFb+f/dcwcpRuSEbSsrJ8?=
 =?us-ascii?Q?8TFTU8tY1Rpwgyrz9VRlCrsKPLxg2eX8OANCiw5KPORETRazOzDBtvg/WkG3?=
 =?us-ascii?Q?zeQZWUUYEToKlXCw6SWsMT3nUh3sXyFI5IOB41hgOetW/XKmRUCWtddIIteG?=
 =?us-ascii?Q?nl1NWLMAAxgXbX4V9Rk9blH0poDG9r/t/VLJM+DgeLvR9HUKRLRO+6CGoJSN?=
 =?us-ascii?Q?FSWecEbWvlX9Kqjk/qXzg4ygMOYZAMkpL+BQCyyb6QS7zSylaVUcnROw+DN2?=
 =?us-ascii?Q?3jlWv1vMsNMYJ9NHld4iemK6SLqz4qHsRXv6vUMzAd71FhQnbdyeER/9e3Jr?=
 =?us-ascii?Q?WzYP5B8c6BDhJCKxP8TEkX4FUJVbcD54d9PUdTMa3b9aQ7ug1z722yGF1Wkt?=
 =?us-ascii?Q?iua0wKArb4jJ9T9GiUCNSfA0d6do/xapcIpIw3McGb3hiL0dAVYa4omzSlXG?=
 =?us-ascii?Q?wtd7ZQxPjP9FssLLcGKOY1bv+lxAzwG9Oi+RBybf0DkaxJmg8AOcaO9z3UeZ?=
 =?us-ascii?Q?OxHYGrW9rU8uS5dYj5BR1YPs5j5f4Irg/rUTfn+xHNONLOIdnk/4uenL6S9K?=
 =?us-ascii?Q?MbjDYSFPyvJWwIm03z30mD4fWe/jNtNeuDGzLtzp/9JYeX1xngntS9fTJZDF?=
 =?us-ascii?Q?VSJE2DR20QrAIfgqMIek1kIe9//ZHh6kn6EsbuvxRuGE9Ia7yFMA9G8h/8Ji?=
 =?us-ascii?Q?9mZ4EEk4GuzRbZ5dgDpPrxAL9ANPk3SzYN0PwgHvCY+U4N29X/hHcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WxigBWHSmuNjZAKYF6KTnZOKeMnvVYjjD5XYDYTkQ7AZ6e6N2Deb/kSYArEU?=
 =?us-ascii?Q?Il6x4Rz7C4af8tqJa1SD9tGIZ8+Luq+T+F1jaohLdh7DJ8/2FpoPGqrCsmvo?=
 =?us-ascii?Q?9E9xwr+PNuk9DvRt4vlnKMGTb/Le6nIyG4j1D4HroBL9hnw9UWyMyOM8qoTi?=
 =?us-ascii?Q?Yna0/dz0VhPCdbQSajvupn62NBapP4vqidupjHYtFvc6fS9nckPZopzSA28i?=
 =?us-ascii?Q?1L+bUgvNqa81dzQrENbuqV673dnCxfQ4ona0xgeLE5AWOveoFgupZoO1de+7?=
 =?us-ascii?Q?2HrSrZdspRR/PQj73AZU3Y7Kum3/ONb0soM0VzUOkQjmi/vHnTdwgj6cFeaj?=
 =?us-ascii?Q?urY4dZXRh4DIJ4tl86wQD/JV6OV2jb4e68L31B9JfDfKxexYRRWo+qL5ciCY?=
 =?us-ascii?Q?npYr+61qb6XbVmX78lFoTpDiEiIj1PqvtquL5qKAp7GGrGIboIuWimiBl2Q7?=
 =?us-ascii?Q?U1/Dhrg+RUWBbKKgelM+DkGT1bXWm8ZOlzooXuku6/vMLJwmgIPanCtywfqi?=
 =?us-ascii?Q?KQvwWlNimQ5TxmAppVJLFlG56TfmtJXxwjZrUf6ff+ofVb+NYwUAHxT4LQO6?=
 =?us-ascii?Q?PahbHkUm3LyUVzg5o5abAQ4Z/cRcVNjlYYNghVwttk3D3tW36WkFXj+YFUT6?=
 =?us-ascii?Q?g4x1lOVBnzZQJMCsZzSLC8dpEejr7Z65sEfXPKek6P3QcsrxmnCavs0WBj0f?=
 =?us-ascii?Q?NGRaPk7SVFSELEG+NkltcUIfhcLUJ7aURBbS6edECfig5E02FQX5PmYCgInK?=
 =?us-ascii?Q?0HT/9TzVlNwjNtDxCtocMA2FIJoKTQzTgNynkGpNeRNLJAy5MXKytsTuAa0O?=
 =?us-ascii?Q?k4wE08BbVcCjzZl5EPkSMb8KQlRDPXY1M3jSj9imT2qb9X6BmZWQ9Pl1NFzy?=
 =?us-ascii?Q?Z8saZyjb5/SqharTtdHLMVXztUDPHszFHJkgLHs2yRTHy6jbf7JGD6eOhjGX?=
 =?us-ascii?Q?eblyieefI2euc9y42PopWnTT7OnpWXto+ovLFY+VuEEJHI0waefQunkCHNlY?=
 =?us-ascii?Q?m80jh3m4HFmntuf+INNGc1JpnvYaWooS7E+skD+3ow3hVr2evFmcBwfxBJlr?=
 =?us-ascii?Q?lYz2osSVGboCLqKjJTIh38PuQxhwv0o1XdogkqtdC3PyUTcKdUC/kZQYu7e/?=
 =?us-ascii?Q?HgG/qjycN610ppM/P19VKXUMv7MzAh/gTlFcTW2BwFVNceUM9HxToPYgZwsp?=
 =?us-ascii?Q?s0xPbHwzddBdbnraq2Ti571hWARn/oayrpOxpiOttCKoJGdGaQRCMhi9PBYf?=
 =?us-ascii?Q?LMRO0NX8dDcbmq7nY5npDKBU2cf8bPUj+99XbTDGpM7+IRtz5RuLX4rJToL4?=
 =?us-ascii?Q?RErh/R2WrNxS1IRKKbRDZdZQzmp5ajXAAlnabZcfM6BAqj0V/JLoL0po8Ohi?=
 =?us-ascii?Q?XMp64QzqNRs+kbQPtvfBzKPTijA6IwpqrtXExC4fOARY1XXIFFVB5uQZyMLv?=
 =?us-ascii?Q?RrHGjZuRFMCFV44cLN8ZMnxM0iHAg8IP/WkYWLob3e87CkT7Fu11AjT2Pe8r?=
 =?us-ascii?Q?wzYgnSr2qwbtwgHikiGbgjDFk4DWSBeqWTflyK7IzrAh79X/0uPQO290/0q2?=
 =?us-ascii?Q?vssAFrZhwFP6UthWkvKzc4hEQ1zPY9HpJ0SZrlsS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd55a694-172f-4eb4-1e4a-08ddf1a7424b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 02:51:23.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3MvjrgHEU8aJ0ygOV80URlSctTtO69e+IjLplvfPRzCxeVc1EuHQysQHl0dLIQ2zsrQJvE571NHagXm3HgRCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689

On Thu, Sep 11, 2025 at 11:56:49PM +0200, Marco Felsch wrote:
>Make use of the devm_add_action_or_reset() to register a custom devm_
>release hook. This is required to turn off the IRQs before calling
>dma_async_device_unregister().
>
>Furthermore it removes the last goto error handling within probe() and
>trims the remove().
>
>Make use of disable_irq() and let the devm-irq do the job to free the
>IRQ, because the only purpose of using devm_free_irq() was to disable
>the IRQ before calling dma_async_device_unregister().
>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

