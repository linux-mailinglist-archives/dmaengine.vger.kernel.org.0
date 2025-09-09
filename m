Return-Path: <dmaengine+bounces-6431-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF328B4FFC4
	for <lists+dmaengine@lfdr.de>; Tue,  9 Sep 2025 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E8A4E1137
	for <lists+dmaengine@lfdr.de>; Tue,  9 Sep 2025 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA135085E;
	Tue,  9 Sep 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HUyasn3+"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3AA350830;
	Tue,  9 Sep 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428998; cv=fail; b=UgePa97wE9/miiYbsfdBQsmCZ7Xmvou/lFepPkAnITfUru0VzkSrAIqkNGffpTxs/LL1AOprbMOGmEi39NArPzKrjgja753mRDhHKvQlNr25vyPFEFd3uyS0uwpHHafvTym6Cxz9f2LZnCN6At93+JD895ydYNGyswpp1s4n9wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428998; c=relaxed/simple;
	bh=Sj7KmO/pHjWjZLbKPB/NohZ8g9x+Dl/FEy9JjKVDSgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tAT/EU/+MbVW/AqIcE1F1txX656lh2EOrqoeEGxlUs7xzCw81mpeTsHJDURJOjTZl6gDoKJ51uTApYVZsI6K+8J2zQ8XCGzZqpmpgGFok2P2xabKOXjxknn/njA2dAvA37ozfPo9+dww2zhgs2N6jFsrEOjoOGFZN91X5RauKz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HUyasn3+; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bj7T7ipRZ+y1K+rMrHo1RkcJ+oMO44n3f27Xii6UTPwliImsiZV7CCGHNMU8kEK0rwNkaNnR5TxHfa6+uF7cxU1WfCLURNnuwBghW/wH0uRusE0eNlm/+0xN67HRit1m32PI+GdTZcXOMjYzFUoGztS56MXsx+Oq10ahmWAL0JYJXFZpgU7hyMlSw2e5qCoBLsyNT8eXg2R4ia3QcIVjxq1OBhnMQAgP/yeat/5/g9vt1veE8dMGpxuORA/5wSdwHJYwNSQEpabY37rkSdUW/zkLgbvgE5kaHtHDST5LVKSQ+eGthHsoooMf1GlnwJ97xHsAFGNKuDhdn6+m37Y2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3g12yxo6AUZ+3qDGXeBtpVoN4DkyT2WQsJMEPjbQiQ=;
 b=hQ71V+abVQxbLj9UiZ9K3e7toRcNA47LtTXb8FbNRvmMJIg3zJAfzJ9jAuQiwVtIkfTgxAt9XyRodKcvFvXUd2NDx5v491ikQsBZj/htQ3llDj3d25vt0DE9DGgWciLx+0ircv1BODWbPYGa1tnFNkYBWwr32y8rn1wmY0sJMclwkBAr/lhRCAItFC8b1/DI9SOLCqsieNCSye+tbNfuS6ZZQaQzjfNoo+IB1SlCQ2o2UXBxvyrU3oox8hRF+NSRBHMK2gWX3O6DGpVboVLvf98HOj0dc3n7CwcaENG23fxwSXHecW62ZgA8aKO9brj847B4lFw5GRXgebTr4bJ3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3g12yxo6AUZ+3qDGXeBtpVoN4DkyT2WQsJMEPjbQiQ=;
 b=HUyasn3+gbM2SDhIrIwlxasdEmZQMjjkmC9pPMMYHr2Z8TzrDgugNwKQCdK9zJmo6rdgaX3TBalCWUc/QawrVuUwzX83q6iXso698Ewsqbur2kJx0TMsPpDAkBwQNUivNoKfiqEZaMho0QL8aC1MKcJWwhSdmb+zieRKE8artIHLOSqzugxjTbB+SPe00iEDBySe6u+QdJdDXrAYKVLkYAwhaLAAZ+6OGfu5GekHs+mFI6eWDcLoNtaXyomO8W2swHaVko6VNiu2Dr5FabGI2EMe0s0AEzBpluRIYLd+Piv1qKzm1oBaqOaoN+xOcr8OKVkgnJYpNMdU33hL+qIwbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8452.eurprd04.prod.outlook.com (2603:10a6:20b:348::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Tue, 9 Sep
 2025 14:43:09 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 14:43:08 +0000
Date: Tue, 9 Sep 2025 10:42:57 -0400
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
Message-ID: <aMA88W/rDxFesEx+@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de>
 <aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810>
 <20250909120309.5zgez5exbvxn5z3y@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909120309.5zgez5exbvxn5z3y@pengutronix.de>
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbfb70e-2bf6-4be9-4285-08ddefaf3141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9oU1hK2eUekQkI2Fx4eZWkNJ3kjcVuXr9bC2YL4T8rJQZDTJEiEBCWC9GWca?=
 =?us-ascii?Q?NboU7X2UgY484BNAfujegDIBc5WD37hpeYY3/ynyuHb6ONYyiaN5U/UBwnJ1?=
 =?us-ascii?Q?pRNdRKUDuZN+OxY/zPFDozcomYxilxitLwfjuEQ5OPyYOKtteGo9D08angZB?=
 =?us-ascii?Q?D53Q6yutUSnHzBxvvYlXmqypOziTDbvwJ3ox+cpOoZu5ghVQ3EnLSVgoubzm?=
 =?us-ascii?Q?lkUrU/UNnFDazaHtjUc5bleW2XBrj8h8aIuoJuxWwJcxsjgOTjf6sFDNuk1F?=
 =?us-ascii?Q?s5oo6tAW0iP+VWctzHX6sa3jKOGv5SzhrNPu7rAjddMR9xgZXX1w06BiErhk?=
 =?us-ascii?Q?3uM4H0S8nw6Me0j9MBj3K2zsoLtduIRe5pazepzf5aHE2yL5SJ7YmvZRsWJq?=
 =?us-ascii?Q?15b69cNj1gfb6Asfoqx7dzIal95zbxT0aP6Nvy/sWFeJrnrH1bIDRJbSQ+ku?=
 =?us-ascii?Q?kOsf7cqL52O3wRa/ItIvIziZWcHCeihb/9e9jBcFD4eF/H3b2JmgoFZeirlH?=
 =?us-ascii?Q?vggFvQyF91g/kn4eQdSvPBiN3ZRErXLCNmjerDVpEoe8TBEdDS/mtAbVl4/c?=
 =?us-ascii?Q?fzExWiXXiZNr1YgtJRPRe8VIWOvdeAIt+3mwTO47CLxs8KG2vQC5JQBCzpFg?=
 =?us-ascii?Q?X1FSBGbc24vgPfP6UKSh5x3GtWaOas9vk8RdwSdvbIUA4MrYabp/JabNFT+z?=
 =?us-ascii?Q?pqTpXOdmg61vrzcFqIaBTtuvMOjL0lPc04KSiHnewFmx8xXZEwCV2dKW/kPh?=
 =?us-ascii?Q?TK69hTXrVe6jt1grHmhy1TQo8ikNpOTTlR4ZEOAvsbAYOy7xYMP0wGAhonKz?=
 =?us-ascii?Q?PHjDSkBlukyO6QLlU9W/0Zi80y9felHtICdcuzs9RxgNJUWsqfAI8sW18/nS?=
 =?us-ascii?Q?3kcBUEoNw1Tp2HtBNMXu5z4jpkIfyJu+9p3W8d8+XmK4X30SlJPezHp+GNYy?=
 =?us-ascii?Q?gSA8mabprSK6VJQlMJaSkv0++mLLg6jC0Lp88x1KORvT6iYQKdk2Bqcn4S/n?=
 =?us-ascii?Q?cGnt42l/AbOVEXftvVoW6LhJkLd5nARBK8JR+OiDca9Eu6vKnh1QJz6lndA8?=
 =?us-ascii?Q?4xCyA4tg4Zm/36CfQR1MAsqh7DPl+f6ZMLyJuxOfMTFch9NxWYkAU2Mue2SF?=
 =?us-ascii?Q?dYR0nwtDkxAplYTrgbAp06OWqtO6MQuF2karFRLzUSQZyoL9R7VKfHDu0bPV?=
 =?us-ascii?Q?/TgC5ExKaSvnJILPqN9pDcO8OqV0H1ZgO+eE4WMFGt5+aOKazKKP4i75h8NK?=
 =?us-ascii?Q?22unt2FU7taQFbc+8xdllDRFgSq/fIvFmNtl23CBDxSOZu8r0Stx5/P8VR5M?=
 =?us-ascii?Q?6tgH6SH5t8lp6QHm9H1oFyGG3u6eHNe8f/0nsEiRVAJrOnj9rR+/EO/9wHu9?=
 =?us-ascii?Q?LwnrNXazuC/+3Qzyhqq1pKsgcEgANN/eSK7dQJPg62OpjeiNRUYVnRAQf2F0?=
 =?us-ascii?Q?k6PVN+d5ilNaLG8gie/lQeCvdXf1HZpjjYZvYObSRL9LCmgd+uhDpK1h8av/?=
 =?us-ascii?Q?/n2KGsNHrkF1AMg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3dRIj6tseGvDwduO3JlbwwrbChtjM1min7czpM7eslNXiZpoz+pQiDiZcCpe?=
 =?us-ascii?Q?hO92ovuRt+YyB6VEAaVuhXpvMLJU6OjYJV77rDax+TqbVJ15thE92uk+KbZ5?=
 =?us-ascii?Q?7rZg7CEJMY1sf3P4uZ0q4xtCZWjK77SNfIh7AheI3Qrd5vX0DtedrMV+v4i9?=
 =?us-ascii?Q?n2xvQuPsy+eQKUwDpiOS/WjiyBZob9zX3H5Zi5Sg38hsunmloo74aIITwt/b?=
 =?us-ascii?Q?E1pL/svgRTFmkEhIacLDcMicaUDywyENQXQV9/a/AYkux3IkZiSvBTr3bV+v?=
 =?us-ascii?Q?qMm/pEN9dV79g2wA7bRpImJ/dz8Gf/219elb6iNRG8P9YKMUScSYKSqwmPVf?=
 =?us-ascii?Q?4ZXx0LL8pmqtoa1l7U/tl8bDEmYT/J5I0FDOgSKAYntc6exaLb4G2vaZPZDZ?=
 =?us-ascii?Q?nXhIE4nhxifLBVa0Ym9+LuZa+yUrXzltL6TR9VM9x9Y9J9B1MJhTwVLuMike?=
 =?us-ascii?Q?JZ6ejQs2q6fUuH9YGIbqcHW4DmWY6ueCWIBLqPfEHwxhovwj1xbpodiwpVUz?=
 =?us-ascii?Q?KasFxNNM4TQClD4klWxODgcA0eG641p38f+/7cBbeH1i0+v7c18nxoA7jz8S?=
 =?us-ascii?Q?nCU9+lCPbWePo2zl7n/jPuQxbJ6PQo+w86sUyFR2eNDiJmSPoFzGhIdrGNWW?=
 =?us-ascii?Q?EOqnHXWLRauCV4oSDVQrpJA4YsNkJhuK0Tb6Kb5Zp0wpFmTI0LQSN6yFLuLc?=
 =?us-ascii?Q?Vlf1lUJc3CyniH8rypQckMG8poaqe9BQLjVD4S+e+wREveK4BErvjUWoWCUL?=
 =?us-ascii?Q?cmGA62z4Y8Z9iVgWSAeC+HlZrI7I2BMMBWh+2vkA7pCXPlqSCWVvfeV5zPsF?=
 =?us-ascii?Q?E/1CKvdnWINaklZi/NzMmVLBLRCg4Pp71+Cr65A8WwSV85kz6L41jjSlYTUR?=
 =?us-ascii?Q?3rYpskPMgn9Asbt4Pr3O4l0PaETzR60tSrjfO3gTFKWd/ug2tsKgXI5vX4k6?=
 =?us-ascii?Q?FVNKFO8PFMd9vpSlYzDBdR81ocOgPZ5TkFmj8LQZlXwhmJScPVrhPv0N1xJx?=
 =?us-ascii?Q?KfwC+KejI4wDS5gHGLSO+LuD4hx5qW2X+zwCzTQkF8sC+GzjN5AOGw/7sOhM?=
 =?us-ascii?Q?PbDTx91w6ym6LF+ceYBrG57XwMB8S3xBblMU65M4xfbICndy/zafCxRBRVPP?=
 =?us-ascii?Q?SNzxVeil5pYawWCnCCd3QMFk1pHOxcva7aw6OPJqr93GRd7KGWybBt+lIAgJ?=
 =?us-ascii?Q?rCb6PUIxOt3TYCjLF5SMlSM8UKcZD7J6wQwIhw0/G+zP+cZ95PKcuPjBw69C?=
 =?us-ascii?Q?0BsYxrHjHCqqJAd3zdTH7yvmSVdSSQwKaJkyENxBHULKH0y9rR9hDna39/U3?=
 =?us-ascii?Q?xOIrEYG4mMp5Wpv83fQdZoPuggP/r2NixmXfvnkrzatKPn8PqIpQY7oSOzvL?=
 =?us-ascii?Q?n9Tpb0mKfbo8Niyniz/ChmO4ZP+SQHETY7Rvb0y9QaqgvrufdfeyY+HD/M1b?=
 =?us-ascii?Q?4kr09rUet2wkSE29aZerLmd6eovomcV0K4ei74BXvrvhkPqzv39w6tsq3E8m?=
 =?us-ascii?Q?PHDyfX4qBagLSUg3Z4cZ83ZEbPMCIlAKBKETAyk82WTjuLDHnmvsII1G++CT?=
 =?us-ascii?Q?P9S+E4tZ84RfORXvKC12vdWTqz7xeJ2eBHrsoJNs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbfb70e-2bf6-4be9-4285-08ddefaf3141
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:43:08.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUzRgzEXZe9lAM9Ewo0IY/adC66Xa7AnfDZqwI5WkPtFloBDq2eaAajrgrMciaFCi4UdxrROE/GwDR8yapHinQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8452

On Tue, Sep 09, 2025 at 02:03:09PM +0200, Marco Felsch wrote:
> Hi Frank,
>
> On 25-09-03, Frank Li wrote:
> > On Wed, Sep 03, 2025 at 03:06:17PM +0200, Marco Felsch wrote:
> > > Add support to create device_links between dmaengine suppliers and the
> > > dma consumers. This shifts the device dep-chain teardown/bringup logic
> > > to the driver core.
> > >
> > > Moving this to the core allows the dmaengine drivers to simplify the
> > > .remove() hooks and also to ensure that no dmaengine driver is ever
> > > removed before the consumer is removed.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> >
> > Thank you work for devlink between dmaengine and devices. I have similar
> > idea.
> >
> > This patch should be first patch.
>
> I can shuffle it of course!
>
> > The below what planned commit message in my local tree.
>
> Okay, so you focused on runtime PM handling. Not quite sure if I can
> test this feature with the SDMA engine. I also have limited time for
> this feature.
>
> Is it okay for you and the DMA maintainers to add the runtime PM feature
> as separate patch (provided by NXP/Frank)?

we can support runtime pm later.

>
> > Implementing runtime PM for DMA channels is challenging. If a channel
> > resumes at allocation and suspends at free, the DMA engine often remains on
> > because most drivers request a channel at probe.
> >
> > Tracking the number of pending DMA descriptors is also problematic, as some
> > consumers append new descriptors in atomic contexts, such as IRQ handlers,
> > where runtime resume cannot be called.
> >
> > Using a device link simplifies this issue. If a consumer requires data
> > transfer, it must be in a runtime-resumed state, ensuring that the DMA
> > channel is also active by device link. This allows safe operations, like
> > appending new descriptors. Conversely, when the consumer no longer requires
> > data transfer, both it and the supplier (DMA channel) can enter a suspended
> > state if no other consumer is using it.
> >
> > Introduce the `create_link` flag to enable this feature.
> >
> > also suggest add create_link flag to enable this feature in case some
> > side impact to other dma-engine. After some time test, we can enable it
> > default.
>
> What regressions do you have in mind? I wouldn't hide the feature behind
> a flag because this may slow done the convert process, because no one is
> interessted in, or has no time for testing, ...

Unlike other devices, like phys, regulator, mailbox..., which auto create
devlink at probe. I am not clear why dma skip this one. So I think there
should be some reason behind. Maybe other people, rob or Vinod Koul know
the reason.

static const struct supplier_bindings of_supplier_bindings[] = {
        ...
	{ .parse_prop = parse_dmas, .optional = true, },

If remove "optional = true", devlink will auto create. I am not sure why
set true here.

>
> > >  drivers/dma/dmaengine.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > index 758fcd0546d8bde8e8dddc6039848feeb1e24475..a50652bc70b8ce9d4edabfaa781b3432ee47d31e 100644
> > > --- a/drivers/dma/dmaengine.c
> > > +++ b/drivers/dma/dmaengine.c
> > > @@ -817,6 +817,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > >  	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > >  	struct dma_device *d, *_d;
> > >  	struct dma_chan *chan = NULL;
> > > +	struct device_link *dl;
> > >
> > >  	if (is_of_node(fwnode))
> > >  		chan = of_dma_request_slave_channel(to_of_node(fwnode), name);
> > > @@ -858,6 +859,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > >  	/* No functional issue if it fails, users are supposed to test before use */
> > >  #endif
> > >
> > > +	dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> >
> > chan->device->dev is dmaengine devices. But some dmaengine's each channel
> > have device, consumer should link to chan's device, not dmaengine device
> > because some dmaengine support per channel clock\power management.
>
> I get your point. Can you give me some pointers please? To me it seems
> like the dma_chan_dev is only used for sysfs purpose according the
> dmaengine.h.

Not really, there are other dma engineer already reuse it for other purpose.
So It needs update kernel doc for dma_chan_dev.

>
> > chan's device's parent devices is dmaengine devices. it should also work
> > for sdma case
>
> I see, this must be tested of course.
> > >         if (chan->device->create_devlink) {
> >                 u32 flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
>
> According device_link.rst: using DL_FLAG_STATELESS and
> DL_FLAG_AUTOREMOVE_CONSUMER is invalid.
>
> >                 if (pm_runtime_active(dev))
> >                         flags |= DL_FLAG_RPM_ACTIVE;
>
> This is of course interessting, thanks for the hint.
>
> > When create device link (apply channel), consume may active.
>
> I have read it as: "resue the supplier and ensure that the supplier
> follows the consumer runtime state".
>
> >                 dl = device_link_add(chan->slave, &chan->dev->device, flags);
>
> Huh.. you used the dmaengine device too?

/**
 * struct dma_chan_dev - relate sysfs device node to backing channel device
 * @chan: driver channel device
 * @device: sysfs device
 * @dev_id: parent dma_device dev_id
 * @chan_dma_dev: The channel is using custom/different dma-mapping
 * compared to the parent dma_device
 */
struct dma_chan_dev {
	struct dma_chan *chan;
	struct device device;
	int dev_id;
	bool chan_dma_dev;
};

struct dma_chan {
	struct dma_device *device; /// this one should be dmaengine
	struct dma_chan_dev *dev; /// this one is pre-chan device.
}

Frank
>
> Regards,
>   Marco
>
>
> >         }
> >
> > Need update kernel doc
> >
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index bb146c5ac3e4c..ffb3a8f0070ba 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -323,7 +323,8 @@ struct dma_router {
> >   * @cookie: last cookie value returned to client
> >   * @completed_cookie: last completed cookie for this channel
> >   * @chan_id: channel ID for sysfs
> > - * @dev: class device for sysfs
> > + * @dev: class device for sysfs, also use for pre channel runtime pm and
> > + *       use custom/different dma-mapping
> >
> > Frank
> >
> >
> > > +	if (!dl) {
> > > +		dev_err(dev, "failed to create device link to %s\n",
> > > +			dev_name(chan->device->dev));
> > > +		return ERR_PTR(-EINVAL);
> > > +	}
> > >  	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
> > >  	if (!chan->name)
> > >  		return chan;
> > >
> > > --
> > > 2.47.2
> > >
> >

