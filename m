Return-Path: <dmaengine+bounces-7492-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B04C9FE2B
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E47E3014B5E
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67648352F81;
	Wed,  3 Dec 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OL9naIg9"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8A352946;
	Wed,  3 Dec 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778503; cv=fail; b=cLeZaeOM3EwuGHxtQ+tja9F3BDPFI4MlbdBdwU5L7j5183A51CItXTw9r5Q+khe1ZIUN/UXb8HqD/st/c5YBnf8X3dh1quQrVxkt8MiseAK4nLHCuRGJbCtzpYjyQXfJBsd5mgQa+Qi4d6x2h/+aq0jes/LYcDCcsgyFUBSxbiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778503; c=relaxed/simple;
	bh=YZFo/NStgWiU/xwLCgUafkfNuI8drUGBOXto9SGlA3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pTWgUTrMau+TVuMIaO8PKOV0bywRJMc8/1uMI4A8FzvIijLgVO3BDUfdQMClOx7qe5DGnFtdKHDpKzn3haQvxmoAj/4XBwGqUJZ6JatQsBDU9goxTgQi1HmoGQXpoTBEDWIhSckGPd+p7D4RDV+jjhx/VbxG5VY6GUAhY9sWf4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OL9naIg9; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4gzk1Q9Se7+GwYYgMJ3RomnR8TZzKXmxsjtbigL5Lux5ioDBU41hOv4XwNTp8nYpldR7xK7TIzGavO+FNvTAXLIz2fzpT7474EQTX3hEtrY9Xy6jVYYEyj/5Q++Te6WzhwWoyaqGzHofDqdAGJlz7tOn60caRThXJMPjzzpDUUHyzhC6qsEaicOJ8DbkjTn8mNFWSzlF7Z42nNQSmRqq4TaXa+j+VFD5eGukQN6ySDAYbVeP9viz+/VQ1WY8DdwaV1dg4LWR5v/v7d2sRvo+MJmfA/N7RHUTVRMuBZa/om6/rKLM7WpKkN2K/Y8KpyUUgVzVgf/5r/x78VntkETSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzVun281DdfgPei5S2QvijaukHke72gHm1VGdMzs+XQ=;
 b=I1EhRA3y9fFgPe4LDcVQIQ+NXkx2Mdj7lGteKOlIbM0UFAbiVzNCwwyGwDD4H8hWIH/p9uxMHOZ5l5zfSoDEkqr/nFudpVGVhLCpnyfFEjReo8jgzLxOmB8TaPN44O4usjtSloz8MwphsNtVP5iHjJMegdarqJ+Ua8LHIjaTcYDDo1tfeei7JO0pWM44SMkxsU5P+nDhjYqpj7YwSUJJLGzSprTHGrlX6wodba995XRlgKoFc6zfb/sCTFEdB4EC+BLCAzaQoECkNxiGR/ommmP2DFeKuQKs/t2MJuJ939RBxiHl532AhMvxFOEOLV4evu0zlMxFnci9Wft9tgZNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzVun281DdfgPei5S2QvijaukHke72gHm1VGdMzs+XQ=;
 b=OL9naIg9SNSv5rDMijYRwgReDwx54SuCejbdT71iEnyMQsde6Vmzi7hFzlX2VODf4rTSWunQ2LhC/CRwCPFgGgjVZgI/eQ0z0hCCsWQ6ryUupqBTeYNi1NITbyI1TgZY3hPerbf0a1tPMli+W8oK/cLwmUgo/MP0j8AMA5x+KS9NQdGzlK1bItmuFdv56sgxIz9zD8wmGM1zZYATAEjnHPnUhhR6uX43PP3ZGp3rAkERbn31mYd/iWsie+walePFJY1Y4et0rjZc9veeS+JGvZ9q+ERc/waHkI0RVDkbdF9Az5Jix3VeiKLnGThT66z7h8BJCqZ4WgsVEGCwP34/qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU2PR04MB8776.eurprd04.prod.outlook.com (2603:10a6:10:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 16:14:57 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 16:14:56 +0000
Date: Wed, 3 Dec 2025 11:14:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 20/27] NTB: ntb_transport: Introduce remote eDMA
 backed transport mode
Message-ID: <aTBh86H5m6PpIxMk@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-21-den@valinux.co.jp>
 <aS4Lcb+BjjCDeJRz@lizhi-Precision-Tower-5810>
 <jiigiyxb2hllpeh3znbfy4octtubvkkrbxv7qfzzivimvz7ky2@i7b7a66peapf>
 <aS8I5e2UguQ2/+uU@lizhi-Precision-Tower-5810>
 <27mhsc7pksxyv62ro2m4u4xblednmlgsvzm6e2gx4iqt2plrl2@ewtuiycdq3vj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27mhsc7pksxyv62ro2m4u4xblednmlgsvzm6e2gx4iqt2plrl2@ewtuiycdq3vj>
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU2PR04MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: b21fe060-24db-481c-9a38-08de3287197f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZVPFCQcE5zy3q7wcQUpm0SDdLCNPMpQHKjq7OBkjjn9vo2t7lhwqNKg80J7?=
 =?us-ascii?Q?x5WBTMnROD420kSruL6eZLF9weOAB6lkOhbD+P06oZj9XmFzfkfDkGLhROSk?=
 =?us-ascii?Q?MZONBv1G/ADxJzIpEuauzTAUNlWSY3C0z3xy6hUsege8b0o72uUhgTuTBzjQ?=
 =?us-ascii?Q?kgQAbjJmljDAz6+v8ad6X2fpwICltirPdSYO50wiQVJ5oHdCkluC1r/QjG2a?=
 =?us-ascii?Q?8sC4A/WH7uK4yMOlkUNJQ2m0oE3joTlxY/joYkDYyBHyZoE73gT0L2pLNRL5?=
 =?us-ascii?Q?48yj9fqpUWAacceAVau6coYO74rEIpgsW3XJr7qW1a05zvli6uwQksF80Emy?=
 =?us-ascii?Q?4aR2Ygz8h/yv+/TjEWYFeTszx1Zw6vYY0yxISakVhpW6nMFQTm6Cp4HwSuxY?=
 =?us-ascii?Q?QHmzpQYQWbWwZwujpZ/BJMGxEc4IfYMKhpWmXQ1T1gz1oh/x5VBFxTtgTtzq?=
 =?us-ascii?Q?9Cwd05opYGqOphbzDR3cBOuEUFm3bVrEf+vPlOK7DybeLYTX8NnHhlzaqnEQ?=
 =?us-ascii?Q?GCKdqF13LayRslgrRdpz+bUBpsb3/CiE/RZyL2YsS8wTDS3oDdgG+0viD5O7?=
 =?us-ascii?Q?Zh5n3/7qh5NVtXJt6Bo2W+GNjbr6a7vC0JOa5ohzXjWteAQK8JM3T7IgV9L5?=
 =?us-ascii?Q?FQCReFq03G4H515MM1cttyLwx2d91y72N2hnw3Ijzp8JwQWYCaqIsr5vbvkt?=
 =?us-ascii?Q?EqVaKv94DSvLe8qkGtIp9j/c3Qslz8HXBW2WQJ8MU46M+zscTTer4ph198L1?=
 =?us-ascii?Q?k13E/RRx5fg+ZZ9Mq/jArXsJaEBPdBV5B/JdRRypcYQgU+Fgsrf9ougmWYqb?=
 =?us-ascii?Q?uIIl+Er+aikfm9gEqSZt51QLpyqWHiIo4q7pPalLmoTbek78AgXDPqnhdCgf?=
 =?us-ascii?Q?pQgAknEugiRfmEaLBaExmr79OyExmnzzEUGPg2ZHiB08PFr0HLOn3P5bpbRw?=
 =?us-ascii?Q?m9mAAVk3cLB8iPLbXIDl1R1y2HPWUa8AViyzmwqHLl24JUnloXLNwtP7dBmo?=
 =?us-ascii?Q?TVxynFNNlSqL+GV/cVZyzkE400riSWhvuiQ+83OPYGzLy0kpZkmM1OVE6ZH5?=
 =?us-ascii?Q?BPuddfs96dr+DfMuIzWMQfy+2yfVBVNAxaTz8vhZ8Y5Vdn6zcm32Rf7ti3gi?=
 =?us-ascii?Q?AfduOIKI5nv9xIE0WPMGvsT8M94V2QlszwD1+SbfGpgK/z115r2xhRlAdINw?=
 =?us-ascii?Q?zu3y5QBAWDQe0pQ4VwJqp9JCXvIAVDbNJfkmz+0dIC+nNSXmmmNL4HnKhNPv?=
 =?us-ascii?Q?/wPArcwi+maPgmg4am0QJiemQhcwLG4v7BFWFmfkrGKjOhr61UzWi3Ieiyqt?=
 =?us-ascii?Q?ZGifqEsy/Cvk3CkX7uUa7FoanQNpMfElBj8xzHZh1ezJPHuo7Hy/zoeF7NVZ?=
 =?us-ascii?Q?gmDIHzP0Mhpo4CvcHvoBu122VwDpY6NaXRWf1l5LP/U2PxvR7w9WX3jBM+p9?=
 =?us-ascii?Q?iaqn4bpeTFmgo6S3uC5SsCwZLGBBqr9lI2tq4O0/E+c+lCCbuiwjYT0bal/7?=
 =?us-ascii?Q?IpNLPUZerdohlk0ttUzFhZQTtTpOOxg3QgNX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kLAb4MYdX0BoRQ8OU6DYXxPaoJT8LKaDgLXO8aSpts8EkaB3DQxWP6XqkjXA?=
 =?us-ascii?Q?IMWHuOSX2SiN7z+2uc2x1PBseelqfErmubxDnu5LbhvtavGoSenmp0iAqlse?=
 =?us-ascii?Q?fX+82KjnM2WW9rRDv2lmdcLTlkJBNxBk4dmi3+ez2YirCvOzNqgi2QXS0LLq?=
 =?us-ascii?Q?i1ctKazpGQkrpjuEYKE7awFCEFpkNHandNE3tjDYEnpBbZqU6EMxtm4n4spF?=
 =?us-ascii?Q?VSKaxKklakb1v0vadDtgcj8xxNWBZ8UhrvwIIBtD/vFWcewlchd/mtJHiv2P?=
 =?us-ascii?Q?mpi3/tBQ3rNATqqIDDbhT2tLle33fh6gOavg7ykquS4nSAoVT4j+aJ+HHMw9?=
 =?us-ascii?Q?xQ6ZVwMiMVbhKPqId5CZRlSKA9Aj/X6Uzgrh2QKYUt8ve7nOLSnE8NKjIhLM?=
 =?us-ascii?Q?egm05piBRDcfSiVjLHPs5Wy/XTTjMXeHlw4I4Zeo9kDx1zclMLwn2yN7D8FN?=
 =?us-ascii?Q?COkrg+5DjWaWazQJmBqgTEFv54K2dCLci14etxd/sGvLc/oDPw82U3NMT/8D?=
 =?us-ascii?Q?mvwOX54yPDbX3eMLC/YAvdpdgqNteaKLHDkvXxkLEGj407Wd5ebKb6hIdZDa?=
 =?us-ascii?Q?lcNE7rAonXygG/iKu3/ZEGMeuxIWKKSCUPdrz4rjb2+nu/594mxQHvgEtiWK?=
 =?us-ascii?Q?5P7G6IhEyeHcFr7cWTcFrrj7P2BdbLc+M7JFA3OUj+0P3fGx4dSYNxm9/PsI?=
 =?us-ascii?Q?5WRlv96U5keid89wFEW3DsOFnrI9Ul1hUgvHgcUA5Zm1RKR/PfAd3c9Ju+e6?=
 =?us-ascii?Q?xcX1YpRuOnEVu6ME2ABdow0ofs1M4ubfc3cV+61jW+ZSIFouiTiXw0v2rhuR?=
 =?us-ascii?Q?9ykoT1QCQirRtheJHJuFjwlfPCgSK3Xp73GimpDaQdE+BNRG1mPjJyUFT3A8?=
 =?us-ascii?Q?k5Sunwbr97jFRCJx/zjLO5QcNGbZbo6hpo+OSW7Sq09fm4VLbohu4RWx7KEa?=
 =?us-ascii?Q?XZlenctSg9sTEQ+z+PeWSPAj/MbhJO58YvCgAHaaHs0Ok9IEaSgKlJbW3kDo?=
 =?us-ascii?Q?8BzXw28ZrU9iud84Hn0KINPSGvy+n6HW7u1YEB8NIexas4g4Pkljk2eRpgpI?=
 =?us-ascii?Q?q+35sqqZpdzylo1FRwEHqsHtzF3UQ1v+OPdzQrvfZp/js4Lgzzq9+r18BQ23?=
 =?us-ascii?Q?rSrM2LCC0EDd5z8a0ggv5TzyZhKAdD4LMfE6gpC40J7CrqNyxLgFs0N3AbWY?=
 =?us-ascii?Q?tFp8g1V6d6V9GnDA31ktpHCjJlbb+RAr9QcPNd0kaAO6W0AgIy8hK2/5gCZH?=
 =?us-ascii?Q?025lL8wqvIOZ+WduCoAHqLRSTHtub3rWM7e2JU6EDI5aw9INGwhlW4nLRRjm?=
 =?us-ascii?Q?upsE5y69/oNu2ixortk8xGLpFFDLpn042rIcuf7EH+mVseDb6aUXJKGdnw4q?=
 =?us-ascii?Q?Y+rSNK/IU6rDBdvWFzIjpes7218+yynn0MMk6ol0byy3UtIts2MeojkjILlJ?=
 =?us-ascii?Q?UhFi/L6vzuXFK2Xb2LOhvve/ISi5CN7sV+tI0lSkCbNOtO3YUWvavZTxvm9V?=
 =?us-ascii?Q?77JMaJRaIXOO7FC04m0TuGaq26d07C4zr16NCWMAtYgE1pldDKVRAC0nrQC2?=
 =?us-ascii?Q?BOFl+gZnKQiqpniujCOomzm0KwX1248HvkydR8MD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21fe060-24db-481c-9a38-08de3287197f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 16:14:56.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aqe5gg9eZ2kba2wEjmr/2SIlRWmvblzeJXrAvS1K6PIuPIYwECcT4e35Ybetl/63DEd2vzLj4JO7hs4rv3NVQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8776

On Wed, Dec 03, 2025 at 05:53:03PM +0900, Koichiro Den wrote:
> On Tue, Dec 02, 2025 at 10:42:29AM -0500, Frank Li wrote:
> > On Tue, Dec 02, 2025 at 03:43:10PM +0900, Koichiro Den wrote:
> > > On Mon, Dec 01, 2025 at 04:41:05PM -0500, Frank Li wrote:
> > > > On Sun, Nov 30, 2025 at 01:03:58AM +0900, Koichiro Den wrote:
> > > > > Add a new transport backend that uses a remote DesignWare eDMA engine
> > > > > located on the NTB endpoint to move data between host and endpoint.
> > > > >
> > ...
> > > > > +#include "ntb_edma.h"
> > > > > +
> > > > > +/*
> > > > > + * The interrupt register offsets below are taken from the DesignWare
> > > > > + * eDMA "unrolled" register map (EDMA_MF_EDMA_UNROLL). The remote eDMA
> > > > > + * backend currently only supports this layout.
> > > > > + */
> > > > > +#define DMA_WRITE_INT_STATUS_OFF   0x4c
> > > > > +#define DMA_WRITE_INT_MASK_OFF     0x54
> > > > > +#define DMA_WRITE_INT_CLEAR_OFF    0x58
> > > > > +#define DMA_READ_INT_STATUS_OFF    0xa0
> > > > > +#define DMA_READ_INT_MASK_OFF      0xa8
> > > > > +#define DMA_READ_INT_CLEAR_OFF     0xac
> > > >
> > > > Not sure why need access EDMA register because EMDA driver already export
> > > > as dmaengine driver.
> > >
> > > These are intended for EP use. In my current design I intentionally don't
> > > use the standard dw-edma dmaengine driver on the EP side.
> >
> > why not?
>
> Conceptually I agree that using the standard dw-edma driver on both sides
> would be attractive for future extensibility and maintainability. However,
> there are a couple of concerns for me, some of which might be alleviated by
> your suggestion below, and some which are more generic safety concerns that
> I tried to outline in my replies to your other comments.
>
> >
> > >
> > > >
> > > > > +
> > > > > +#define NTB_EDMA_NOTIFY_MAX_QP		64
> > > > > +
> > ...
> > > > > +
> > > > > +	virq = irq_create_fwspec_mapping(&fwspec);
> > > > > +	of_node_put(parent);
> > > > > +	return (virq > 0) ? virq : -EINVAL;
> > > > > +}
> > > > > +
> > > > > +static irqreturn_t ntb_edma_isr(int irq, void *data)
> > > > > +{
> > > >
> > > > Not sue why dw_edma_interrupt_write/read() does work for your case. Suppose
> > > > just register callback for dmeengine.
> > >
> > > If we ran dw_edma_probe() on both the EP and RC sides and let the dmaengine
> > > callbacks handle int_status/int_clear, I think we could hit races. One side
> > > might clear a status bit before the other side has a chance to see it and
> > > invoke its callback. Please correct me if I'm missing something here.
> >
> > You should use difference channel?
>
> Do you mean something like this:
> - on EP side, dw_edma_probe() only set up a dedicated channel for notification,
> - on RC side, do not set up that particular channel via dw_edma_channel_setup(),
>   but do other remaining channels for DMA transfers.

Yes, it may be simple overall. Of course this will waste a channel.

>
> Also, is it generically safe to have dw_edma_probe() executed from both ends on
> the same eDMA instance, as long as the channels are carefully partitioned
> between them?

Channel register MMIO space is sperated. Some channel register shared
into one 32bit register.

But the critical one, interrupt status is w1c. So only write BIT(channel)
is safe.

Need careful handle irq enable/disable.

Or you can defer all actual DMA transfer to EP side, you can append
MSI write at last item of link to notify RC side about DMA done. (actually
RIE should do the same thing)

>
> >
> > >
> > > To avoid that, in my current implementation, the RC side handles the
> > > status/int_clear registers in the usual way, and the EP side only tries to
> > > suppress needless edma_int as much as possible.
> > >
> > > That said, I'm now wondering if it would be better to set LIE=0/RIE=1 for
> > > the DMA transfer channels and LIE=1/RIE=0 for the notification channel.
> > > That would require some changes on dw-edma core.
> >
> > If dw-edma work as remote DMA, which should enable RIE. like
> > dw-edma-pcie.c, but not one actually use it recently.
> >
> > Use EDMA as doorbell should be new case and I think it is quite useful.
> >
> > > >
> > > > > +	struct ntb_edma_interrupt *v = data;
> > > > > +	u32 mask = BIT(EDMA_RD_CH_NUM);
> > > > > +	u32 i, val;
> > > > > +
> > ...
> > > > > +	ret = dw_edma_probe(chip);
> > > >
> > > > I think dw_edma_probe() should be in ntb_hw_epf.c, which provide DMA
> > > > dma engine support.
> > > >
> > > > EP side, suppose default dwc controller driver already setup edma engine,
> > > > so use correct filter function, you should get dma chan.
> > >
> > > I intentionally hid edma for EP side in .dts patch in [RFC PATCH v2 26/27]
> > > so that RC side only manages eDMA remotely and avoids the potential race
> > > condition I mentioned above.
> >
> > Improve eDMA core to suppport some dma channel work at local, some for
> > remote.
>
> Right, Firstly I experimented a bit more with different LIE/RIE settings and
> ended up with the following observations:
>
> * LIE=0/RIE=1 does not seem to work at the hardware level. When I tried this for
>   DMA transfer channels, the RC side never received any interrupt. The databook
>   (5.40a, 8.2.2 "Interrupts and Error Handling") has a hint that says
>   "If you want a remote interrupt and not a local interrupt then: Set LIE and
>   RIE [...]", so I think this behaviour is expected.

Actually, you can append MSI write at last one of DMA descriptor link. So
it will not depend on eDMA's IRQ at all.

> * LIE=1/RIE=0 does work at the hardware level, but is problematic for my current
>   design, where the RC issues the DMA transfer for the notification via
>   ntb_edma_notify_peer(). With RIE=0, the RC never calls
>   dw_edma_core_handle_int() for that channel, which means that internal state
>   such as dw_edma_chan.status is never managed correctly.

If you append on MSI write at DMA link, you needn't check status register,
just check current LL pos to know which descrptor already done.

Or you also enable LIE and disable related IRQ line(without register
irq handler), so Local IRQ will be ignore by GIC, you can safe handle at
RC side.

Frank
>
> >
> > Frank
> > >
> > > Thanks for reviewing,
> > > Koichiro
> > >
> > > >
> > > > Frank
> > > >
> > > > > +	if (ret) {
> > > > > +		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > ...
> >
> > > > > +{
> > > > > +	spin_lock_init(&qp->ep_tx_lock);
> > > > > +	spin_lock_init(&qp->ep_rx_lock);
> > > > > +	spin_lock_init(&qp->rc_lock);
> > > > > +}
> > > > > +
> > > > > +static const struct ntb_transport_backend_ops edma_backend_ops = {
> > > > > +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> > > > > +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> > > > > +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> > > > > +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> > > > > +	.rx_poll = ntb_transport_edma_rx_poll,
> > > > > +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> > > > > +};
> > > > > +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> > > > > +
> > > > >  /**
> > > > >   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
> > > > >   * @qp: NTB transport layer queue to be enabled
> > > > > --
> > > > > 2.48.1
> > > > >

