Return-Path: <dmaengine+bounces-2057-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902EE8C88E0
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 17:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A593D1C21B97
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C13B6E5E8;
	Fri, 17 May 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYNVlOrp"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792A634EA;
	Fri, 17 May 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957874; cv=fail; b=bLA6NR3OdVjUiScwoE54jTqhDxgtNgK3RR/+wHsXVE/jGkZDk5JmOyASoWzqFH3KDSd/MKbZoZZS6R7xqhPJRFzYvKt4g6VkeB9D72kO22MpDIoPmdPlRjlaVrK/3mbPsxHP2OTAzsOQ/tGYZdJ8OydvaR/TomZA3m8Ww+g92Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957874; c=relaxed/simple;
	bh=HxZ9M7XzNIeHDRqyQ+QfdNGyX38CyaVNThT1eNe93Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tql6/TtvjocVd/Xun7m30vKGM4YCiD2mqf4FoY8b5VLCr635hzG5jHOA94xgNSPwLyDKCboUsW+jVXpol5x8MAm0MWOlIws7+sgEz0N40qwfLtexC/hCwVqt2AEav4GPTYUV5zCn/qfXn4AmuV2UOgCb7sg2XrG+mU8iWlkE33k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UYNVlOrp; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZkYgr1lmGhCmHIlVWCfHWrEI302+mfY1+5dSNmYVa46N/bQyG0v3SK87Fgve6XM9ygxWata8PyrQmqDuBe4tcjtJrxhEtt+W1CFtsbF42DRtSKkKDy5uE84bgpkoGqSkWvRga25+OqoKBtSiW/brVQkuOS4tF+4/R4fOJLHEn48HhpRzdbuGKudflRdbEWWELqtS73ALsTpIcTQWTtrXJZ89a0sLIy7FCchN7e2l6gKvtDRQINCbbLkbVj9D9VXBo+tM1h+TFOnC5CX7rXytKQM8McRGnLF04ezIVq9tHKAOxFCny8ssgKKWcYLWlYMj/inz/tfkV8869bbfIPXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htsCBXT2T5sM5heiD0zXTfT85ujutFRpa0e+45PveVo=;
 b=EXrbxkyl1+quhiBwngsQS8JBPjsycU6pwoIArygfCrO/8En7o3SVRVziTF0QLKNAG8LA4FSBHlbMMx3TadtmnGNLEDKa67+KBOuK94Bv9pssYa7Uovn/kQpGxoeV5qHuPsPhHkwNcGeryb0f/KBzFy5AOI8pDAvInc+Xr68TLPTq7LyeDphQ3EtglyaQs1OSg534xPFBdzjtsLWf76JdNmzC6QzDPNNbVcutyuFOYYo7pUYN/6snl90NBWpDUa7aaogM1+zJUsPpbDbYY2MVhv0maGEt87NTJTWVR6l4RAWKgcS5VmAiT02b/R1eI6TcZwP4R/1WNLTCptLv/BYNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htsCBXT2T5sM5heiD0zXTfT85ujutFRpa0e+45PveVo=;
 b=UYNVlOrpEiV8cecIiMO8/OsuLdn0NRZYg/j+Mmm6+B0MYNrIUBEagRUI+NM1Q7G54EuKkO0AqCurGZwiNrrT3uH70bLYBtA+sHsdxi04NlPMLPJY7uTUD6uBOkXUXqYUJJ6fc3acvDsjFLhDcJntlvIbPNej0c+0BX1tAL/+dg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9519.eurprd04.prod.outlook.com (2603:10a6:102:22e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 14:57:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 14:57:47 +0000
Date: Fri, 17 May 2024 10:57:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 05/12] dmaengine: Add STM32 DMA3 support
Message-ID: <ZkdwYeLyHJ3PkcQP@lizhi-Precision-Tower-5810>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
 <20240423123302.1550592-6-amelie.delaunay@foss.st.com>
 <ZkUFYoRCOOpAoIus@lizhi-Precision-Tower-5810>
 <408b4a20-680e-4bad-8971-ff98323ce04e@foss.st.com>
 <ZkY9zIfvaiA8h7Oq@lizhi-Precision-Tower-5810>
 <2da93910-01dc-4cfe-994e-3a0d70d2bd19@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da93910-01dc-4cfe-994e-3a0d70d2bd19@foss.st.com>
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: c17c1a64-259d-4f14-7c20-08dc7681b6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|376005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PLMDmUkQSSZM7CAac2+ULiPz1bYvwEX9vhn5uYq8a+702xHJxuiMKy2b5wxo?=
 =?us-ascii?Q?h97gFopnop49Eg4K/UapzReAnpJOi6hLph84CVTsQB1FHUpRvQU4KRHmElFI?=
 =?us-ascii?Q?r1d0y4ewpEJhfal5uk9uKIhZW0oUESaygHAwAy8UpnHpaOrUJCmWOpFRkiYA?=
 =?us-ascii?Q?8bc9kufvMfggQQgIPnpjwqAhVoB+myWXs/3UlzraKqflqECMw57jWEInabW5?=
 =?us-ascii?Q?mNiyEIqGfQOD/W1q/EtrwtkP8E92v7JbJX1prfJpq6dbxStX+KViNCnHMo82?=
 =?us-ascii?Q?XS6oORXAVnUrhCHLayFY1K012ibGBa40WJMS2xhpCajZkaYolu2o8EEHxBFV?=
 =?us-ascii?Q?AtZm/7xk1ib9zDb8Gu8guHHeuzcPcQjRvgF1onyybjFlmKAMG1tVLSGG/nTZ?=
 =?us-ascii?Q?b4hXEtS1xa6CRTl5YDh/cyzRrfVQY803g2P+riV10OwuMQYefbGlb8Kfw2EJ?=
 =?us-ascii?Q?AhHC1DtOdSP5P3MuwVnUImhsX3f69FFtfx51l3W+HKx9SHtMXSE4KIvowdoH?=
 =?us-ascii?Q?USLoM3SrANEDavjat9rV8yFnPLxGIVvnNsoHe1suxOZbvnXM7RPrziP8FHiv?=
 =?us-ascii?Q?+qosgULa8akleL4ilaV4exsnIWb+0p1shQQOj7AqLDG/RZmpfzzn4ZcXFp0P?=
 =?us-ascii?Q?j/kCWn/ODdCX1KaBWYBZ3+m4Tkpy1CGWHfgqFVRQa4/1ow+vy9aukBVgytZU?=
 =?us-ascii?Q?ojg573pAGql3sIzY+FctPJUIa8UT6oS5Yu80dRht5QFvsBH+BtUPzQkTYFTf?=
 =?us-ascii?Q?Hr0Ce/9wCh8xL4LFvHdTSJP9vEs6dV2dPPcJtIxi92GleYPxq31y8WaC0shW?=
 =?us-ascii?Q?WPUWP2K1hEYFh89fyastzrqugFgSSCwf23zHsFJvL4Ur6a+HhvGeT53Q7hYW?=
 =?us-ascii?Q?5F2yjqOEgDZxAih8hrTyjvDC+RPfPNakRQPehBXqQWIIwgA0qJ/sNCsoQDmi?=
 =?us-ascii?Q?s5hPjEfcoAIqG7ht+Dui1A5f6A3gX8pQFkTKcHiMqIbUl/2L0rCl2OwITZ1/?=
 =?us-ascii?Q?+ZFyhk6PDJcTF6vaOZHAzGEh35+fqjRFeJKQMrBYtwH8H9hYeC79W1NDl6Vo?=
 =?us-ascii?Q?brcbQV2NiiTCOn5e2pYwizTTxQy0BXfXK42ST+2iF+JDOZP2bsQuC2uj5Y7V?=
 =?us-ascii?Q?faV+XzISKntqMADOll/OQyRYcR4XH1o51Mo+qPVcX2vijw0p0YieyEVYt42y?=
 =?us-ascii?Q?fgvMRqG17DBf9B22TrPF6kihwAmUW9zOigMVH9AWC19TddFZLP0IxFv5KOAL?=
 =?us-ascii?Q?QLNerVkr8w6/iglSui8eeMOTn2bTpEQLid2PGxenTkH2KQotWepWacLF03bm?=
 =?us-ascii?Q?1SAYkOwO8XAs0TrmTJ7EoLLoEGOoeitm9UtTp7FaG7D/bA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kIAas6UNE7Or01XcXIMGEukksDLUsJrsEfgHzUu/N8xSB4kmtBJGK4WIB8Ra?=
 =?us-ascii?Q?fl8Kt0dlw9ic7k0g4iPPe5WgFavVOJCk2UiTewdo0atfD4813JgoIMogfaXP?=
 =?us-ascii?Q?DbICEcWw1OVIzMs/aqJOQ0r3r4R847CvCMJEmdzFMDeK4ztvmsThBWvvYlmD?=
 =?us-ascii?Q?scWX3LJ/X8LiJqjZbWPPMzN2Y6gPguOqtjSLFwA29Op6zrfjPoq2zki2QAwY?=
 =?us-ascii?Q?kJsEaNVkEgD0V7oOUL5+D8ag3JWlmlbJ/t3HMH3/Fiqb06jYJtDsid0cf+KH?=
 =?us-ascii?Q?CXJa4NMCniwMRJANauoiZdH8JyHXDk801UMldAEIQvMdPAnsKYulkAE+K44G?=
 =?us-ascii?Q?rf5YX9aP2TehXWnCQkDh6Fr5QF8G+DQ6dqu7EmZuXZz8ycgTd54x7N5GTkMb?=
 =?us-ascii?Q?Tf4Uo9QrlQiOherV8HUhFI5tWaktRwWn1ZYQU169Iz0WW4or2nwWDnjACQ2Z?=
 =?us-ascii?Q?VbVdVJd2+tA1U4jQKuL0YZA/UNvUW1jiVpSBFicnese6k0enqsC8nDmWDceq?=
 =?us-ascii?Q?HY+iHb6m3vxRiVBesQDkEenlu+v0AR48WvStejBzm1ss0kGdRWbCen6SyIxT?=
 =?us-ascii?Q?xieMcBRzP8NEaVH4hpwIUtO6oIjbwbgDP3MsC/mf1TzABDMeRfEhzQfAfQLD?=
 =?us-ascii?Q?eC/ojLatTs7Smnfypl4sYcn5BhlOAfsuspwmW2mY75r8BipkJFlcRLuO3BFa?=
 =?us-ascii?Q?A2OPkVAeQehYZP//K5HDPiWbEngNf52RUQgr5YD4m4TE0DpEontEu/myV7hk?=
 =?us-ascii?Q?M/Ad+IZPQK1SMfpeatunsublbwj7EbRCpCTgOZnuccBngMXO90Q9Ul4+R6R+?=
 =?us-ascii?Q?QV0tCUrtMooyu/65dsWJh0jSZXddWPabLFRnTgzk3VUGy/HNAnPxdIo5VmCz?=
 =?us-ascii?Q?IX7V3WDJ1pdVtorf3kJjb0oi7jLAumP05qw0ybVm9SP0sHGImrTrO4iC7Wi9?=
 =?us-ascii?Q?3+G4IptgctQVhy4Bo6f4eV61H+qhjDzfLf7JhhTnJ6U33BVlaZ8KnQHbTsRK?=
 =?us-ascii?Q?wF26m24NHAHlluN6WEJHK0lGm2TcUivePz55Np6jd6Q3mSHnCTQOhDJZ15dY?=
 =?us-ascii?Q?Q/yN6TIXIL6vzoZpzTiR2efQLWuPT39iZzzY/SesrXI093qdpjWUeVC6ANqy?=
 =?us-ascii?Q?1PmicI9ePjG2elmgZIhgA2pHpxMA5scZIfnYbmXMKMbqou3qG+3COpISXh5C?=
 =?us-ascii?Q?DJGDgdROKxWouaTA8sXbXVywz5nAq6lChoc8heZsoYLDj3nHgI8Gw9mybFJW?=
 =?us-ascii?Q?hjcgVNZ+W5o0EMp/wB+DooCYzZ1YWEF9qOBAyzjF81UB3uBDistx32EeNJ2v?=
 =?us-ascii?Q?5egGFeLCpS2AEOtcM14Pzp3n2Pshn1zeraAyXu+fzHazgjO/jDU1guKl9svd?=
 =?us-ascii?Q?cXmC2xs8xP4QFZNhRwsmP8r4Of2LcxmAxtLpT2aub1KotRMqJy3/W0oSOrSH?=
 =?us-ascii?Q?hasnNA0O+n+uHxTV4TX2VLqE4bjQ31OV+wKNaG/otevMphYLVogHLBJv6qqw?=
 =?us-ascii?Q?I875jc+67Rxrdae1TF9ZvsWxH+N6VbSRdleMzxbP9H1o8Aad0zJVre93ochI?=
 =?us-ascii?Q?3/Yxa9LcpdQJ49PeJyNMtH3cxTv9QVlBFE+6Xw1z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17c1a64-259d-4f14-7c20-08dc7681b6b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 14:57:47.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fC/eiCEj5pCdxzzErt2juGXS4fzAS/a0J5FZwFX6JPi6orTThlNOQyVrGAZwa95FGhy0ycWoZJuj2bRf56PZyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9519

On Fri, May 17, 2024 at 11:42:17AM +0200, Amelie Delaunay wrote:
> On 5/16/24 19:09, Frank Li wrote:
> > On Thu, May 16, 2024 at 05:25:58PM +0200, Amelie Delaunay wrote:
> > > On 5/15/24 20:56, Frank Li wrote:
> > > > On Tue, Apr 23, 2024 at 02:32:55PM +0200, Amelie Delaunay wrote:
> > > > > STM32 DMA3 driver supports the 3 hardware configurations of the STM32 DMA3
> > > > > controller:
> > ...
> > > > > +	writel_relaxed(hwdesc->cdar, ddata->base + STM32_DMA3_CDAR(id));
> > > > > +	writel_relaxed(hwdesc->cllr, ddata->base + STM32_DMA3_CLLR(id));
> > > > > +
> > > > > +	/* Clear any pending interrupts */
> > > > > +	csr = readl_relaxed(ddata->base + STM32_DMA3_CSR(id));
> > > > > +	if (csr & CSR_ALL_F)
> > > > > +		writel_relaxed(csr, ddata->base + STM32_DMA3_CFCR(id));
> > > > > +
> > > > > +	stm32_dma3_chan_dump_reg(chan);
> > > > > +
> > > > > +	ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(id));
> > > > > +	writel_relaxed(ccr | CCR_EN, ddata->base + STM32_DMA3_CCR(id));
> > > > 
> > > > This one should use writel instead of writel_relaxed because it need
> > > > dma_wmb() as barrier for preious write complete.
> > > > 
> > > > Frank
> > > > 
> > > 
> > > ddata->base is Device memory type thanks to ioremap() use, so it is strongly
> > > ordered and non-cacheable.
> > > DMA3 is outside CPU cluster, its registers are accessible through AHB bus.
> > > dma_wmb() (in case of writel instead of writel_relaxed) is useless in that
> > > case: it won't ensure the propagation on the bus is complete, and it will
> > > have impacts on the system.
> > > That's why CCR register is written once,  then it is read before CCR_EN is
> > > set and being written again, with _relaxed(), because registers are behind a
> > > bus, and ioremapped with Device memory type which ensures it is strongly
> > > ordered and non-cacheable.
> > 
> > regardless memory map, writel_relaxed() just make sure io write and read is
> > orderred, not necessary order with other memory access. only readl and
> > writel make sure order with other memory read/write.
> > 
> > 1. Write src_addr to descriptor
> > 2. dma_wmb()
> > 3. Write "ready" to descriptor
> > 4. enable channel or doorbell by write a register.
> > 
> > if 4 use writel_relaxe(). because 3 write to DDR, which difference place of
> > mmio, 4 may happen before 3.  Your can refer axi order model.
> > 
> > 4 have to use ONE writel(), to make sure 3 already write to DDR.
> > 
> > You need use at least one writel() to make sure all nornmal memory finish.
> > 
> 
> +    writel_relaxed(chan->swdesc->ccr, ddata->base + STM32_DMA3_CCR(id));
> +    writel_relaxed(hwdesc->ctr1, ddata->base + STM32_DMA3_CTR1(id));
> +    writel_relaxed(hwdesc->ctr2, ddata->base + STM32_DMA3_CTR2(id));
> +    writel_relaxed(hwdesc->cbr1, ddata->base + STM32_DMA3_CBR1(id));
> +    writel_relaxed(hwdesc->csar, ddata->base + STM32_DMA3_CSAR(id));
> +    writel_relaxed(hwdesc->cdar, ddata->base + STM32_DMA3_CDAR(id));
> +    writel_relaxed(hwdesc->cllr, ddata->base + STM32_DMA3_CLLR(id));
> 
> These writel_relaxed() are from descriptors to DMA3 registers (descriptors
> being prepared "a long time ago" during _prep_).

You can't depend on "a long time ago" during _prep_. If later your driver
run at fast CPU. The execute time will be short.

All dma_map_sg and dma_alloc_coherence ... need at least one writel() to
make sure previous write actually reach to DDR. 

Some data may not really reach DDR, when DMA already start transfer

Please ref linux kernel document: 
	Documentation/memory-barriers.txt, line 1948.

In your issue_pending(), call this function to enable channel. So need
at least one writel().

> As I said previously, DMA3 registers are outside CPU cluster, accessible
> through AHB bus, and ddata->base to address registers is ioremapped as
> Device memory type, non-cacheable and strongly ordered.
> 
> arch/arm/include/asm/io.h:
> /*
> * ioremap() and friends.
> *
> * ioremap() takes a resource address, and size.  Due to the ARM memory
> * types, it is important to use the correct ioremap() function as each
> * mapping has specific properties.
> *
> * Function		Memory type	Cacheability	Cache hint
> * *ioremap()*		*Device*		*n/a*		*n/a*
> * ioremap_cache()	Normal		Writeback	Read allocate
> * ioremap_wc()		Normal		Non-cacheable	n/a
> * ioremap_wt()		Normal		Non-cacheable	n/a
> *
> * All device mappings have the following properties:
> * - no access speculation
> * - no repetition (eg, on return from an exception)
> * - number, order and size of accesses are maintained
> * - unaligned accesses are "unpredictable"
> * - writes may be delayed before they hit the endpoint device
> 
> On our platforms, we know that to ensure the writes have hit the endpoint
> device (aka DMA3 registers), a read have to be done before.
> And that's what is done before enabling the channel:
> 
> +    ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(id));
> +    writel_relaxed(ccr | CCR_EN, ddata->base + STM32_DMA3_CCR(id));
> 
> If there was an issue in this part of the code, it means channel would be
> started while it is wrongly programmed. In that case, DMA3 would raise a
> User Setting Error interrupt and disable the channel. User Setting Error is
> managed in this driver (USEF/stm32_dma3_check_user_setting()). And we never
> had reached a situation.


I am not talking about registers IO read/write order. read_releax() and
write_relax() can guarantee IO read and write ordered. But not guarantee
order with normal memory's read and write.

You have not met problem doesn't means your code is correct. Please check
document: 
	Documentation/memory-barriers.txt

> 
> > > 
> > > > > +
> > > > > +	chan->dma_status = DMA_IN_PROGRESS;
> > > > > +
> > > > > +	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
> > > > > +}
> > > > > +
> > > > > +static int stm32_dma3_chan_suspend(struct stm32_dma3_chan *chan, bool susp)
> > > > > +{
> > > > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > > > +	u32 csr, ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id)) & ~CCR_EN;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	if (susp)
> > > > > +		ccr |= CCR_SUSP;
> > > > > +	else
> > > > > +		ccr &= ~CCR_SUSP;
> > > > > +
> > > > > +	writel_relaxed(ccr, ddata->base + STM32_DMA3_CCR(chan->id));
> > > > > +
> > > > > +	if (susp) {
> > > > > +		ret = readl_relaxed_poll_timeout_atomic(ddata->base + STM32_DMA3_CSR(chan->id), csr,
> > > > > +							csr & CSR_SUSPF, 1, 10);
> > > > > +		if (!ret)
> > > > > +			writel_relaxed(CFCR_SUSPF, ddata->base + STM32_DMA3_CFCR(chan->id));
> > > > > +
> > > > > +		stm32_dma3_chan_dump_reg(chan);
> > > > > +	}
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static void stm32_dma3_chan_reset(struct stm32_dma3_chan *chan)
> > > > > +{
> > > > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > > > +	u32 ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id)) & ~CCR_EN;
> > > > > +
> > > > > +	writel_relaxed(ccr |= CCR_RESET, ddata->base + STM32_DMA3_CCR(chan->id));
> > > > > +}
> > > > > +
> > > > > +static int stm32_dma3_chan_stop(struct stm32_dma3_chan *chan)
> > > > > +{
> > > > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > > > +	u32 ccr;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	chan->dma_status = DMA_COMPLETE;
> > > > > +
> > > > > +	/* Disable interrupts */
> > > > > +	ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id));
> > > > > +	writel_relaxed(ccr & ~(CCR_ALLIE | CCR_EN), ddata->base + STM32_DMA3_CCR(chan->id));
> > > > > +
> > > > > +	if (!(ccr & CCR_SUSP) && (ccr & CCR_EN)) {
> > > > > +		/* Suspend the channel */
> > > > > +		ret = stm32_dma3_chan_suspend(chan, true);
> > > > > +		if (ret)
> > > > > +			dev_warn(chan2dev(chan), "%s: timeout, data might be lost\n", __func__);
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Reset the channel: this causes the reset of the FIFO and the reset of the channel
> > > > > +	 * internal state, the reset of CCR_EN and CCR_SUSP bits.
> > > > > +	 */
> > > > > +	stm32_dma3_chan_reset(chan);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static void stm32_dma3_chan_complete(struct stm32_dma3_chan *chan)
> > > > > +{
> > > > > +	if (!chan->swdesc)
> > > > > +		return;
> > > > > +
> > > > > +	vchan_cookie_complete(&chan->swdesc->vdesc);
> > > > > +	chan->swdesc = NULL;
> > > > > +	stm32_dma3_chan_start(chan);
> > > > > +}
> > > > > +
> > > > > +static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = devid;
> > > > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > > > +	u32 misr, csr, ccr;
> > > > > +
> > > > > +	spin_lock(&chan->vchan.lock);
> > > > > +
> > > > > +	misr = readl_relaxed(ddata->base + STM32_DMA3_MISR);
> > > > > +	if (!(misr & MISR_MIS(chan->id))) {
> > > > > +		spin_unlock(&chan->vchan.lock);
> > > > > +		return IRQ_NONE;
> > > > > +	}
> > > > > +
> > > > > +	csr = readl_relaxed(ddata->base + STM32_DMA3_CSR(chan->id));
> > > > > +	ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id)) & CCR_ALLIE;
> > > > > +
> > > > > +	if (csr & CSR_TCF && ccr & CCR_TCIE) {
> > > > > +		if (chan->swdesc->cyclic)
> > > > > +			vchan_cyclic_callback(&chan->swdesc->vdesc);
> > > > > +		else
> > > > > +			stm32_dma3_chan_complete(chan);
> > > > > +	}
> > > > > +
> > > > > +	if (csr & CSR_USEF && ccr & CCR_USEIE) {
> > > > > +		dev_err(chan2dev(chan), "User setting error\n");
> > > > > +		chan->dma_status = DMA_ERROR;
> > > > > +		/* CCR.EN automatically cleared by HW */
> > > > > +		stm32_dma3_check_user_setting(chan);
> > > > > +		stm32_dma3_chan_reset(chan);
> > > > > +	}
> > > > > +
> > > > > +	if (csr & CSR_ULEF && ccr & CCR_ULEIE) {
> > > > > +		dev_err(chan2dev(chan), "Update link transfer error\n");
> > > > > +		chan->dma_status = DMA_ERROR;
> > > > > +		/* CCR.EN automatically cleared by HW */
> > > > > +		stm32_dma3_chan_reset(chan);
> > > > > +	}
> > > > > +
> > > > > +	if (csr & CSR_DTEF && ccr & CCR_DTEIE) {
> > > > > +		dev_err(chan2dev(chan), "Data transfer error\n");
> > > > > +		chan->dma_status = DMA_ERROR;
> > > > > +		/* CCR.EN automatically cleared by HW */
> > > > > +		stm32_dma3_chan_reset(chan);
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Half Transfer Interrupt may be disabled but Half Transfer Flag can be set,
> > > > > +	 * ensure HTF flag to be cleared, with other flags.
> > > > > +	 */
> > > > > +	csr &= (ccr | CCR_HTIE);
> > > > > +
> > > > > +	if (csr)
> > > > > +		writel_relaxed(csr, ddata->base + STM32_DMA3_CFCR(chan->id));
> > > > > +
> > > > > +	spin_unlock(&chan->vchan.lock);
> > > > > +
> > > > > +	return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > > > +	u32 id = chan->id, csemcr, ccid;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > 
> > > > It doesn't prefer runtime pm get at alloc dma chan, many client driver
> > > > doesn't actual user dma when allocate dma chan.
> > > > 
> > > > Ideally, resume get when issue_pending. Please refer pl330.c.
> > > > 
> > > > You may add runtime pm later after enablement patch.
> > > > 
> > > > Frank
> > > > 
> > > 
> > > To well balance clock enable/disable, if pm_runtime_resume_and_get() (rather
> > > than pm_runtime_get_sync() which doesn't decrement the counter in case of
> > > error) is used when issue_pending, it means pm_runtime_put_sync() should be
> > > done when transfer ends.
> > > 
> > > terminate_all is not always called, so put_sync can't be used only there, it
> > > should be conditionnally used in terminate_all, but also in interrupt
> > > handler, on error events and on transfer completion event, provided that it
> > > is the last transfer complete event (last item of the linked-list).
> > > 
> > > For clients with high transfer rate, it means a lot of clock enable/disable.
> > > Moreover, DMA3 clock is managed by Secure OS. So it means a lot of
> > > non-secure/secure world transitions.
> > > 
> > > I prefer to keep the implementation as it is for now, and possibly propose
> > > runtime pm improvement later, with autosuspend.
> > 
> > 
> > Autosuspend is perfered. we try to use pm_runtime_get/put at channel alloc
> > /free before, but this solution are rejected by community.
> > 
> > you can leave clock on for this enablement patch and add runtime pm later
> > time.
> > 
> > Frank
> > 
> 
> Current implementation leaves the clock off if no channel is requested. It
> also disables the clock if platform is suspended.
> I just took example from what is done in stm32 drivers.
> 
> I have further patches, not proposed in this series which adds a basic
> support of DMA3. There will be improvements, including runtime pm, in next
> series.
> 
> Amelie
> 
> > > 
> > > Amelie
> > > 
> > > > > +
> > > > > +	/* Ensure the channel is free */
> > > > > +	if (chan->semaphore_mode &&
> > > > > +	    readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(chan->id)) & CSEMCR_SEM_MUTEX) {
> > > > > +		ret = -EBUSY;
> > > > > +		goto err_put_sync;
> > > > > +	}
> > > > > +
> > > > > +	chan->lli_pool = dmam_pool_create(dev_name(&c->dev->device), c->device->dev,
> > > > > +					  sizeof(struct stm32_dma3_hwdesc),
> > > > > +					  __alignof__(struct stm32_dma3_hwdesc), 0);
> > > > > +	if (!chan->lli_pool) {
> > > > > +		dev_err(chan2dev(chan), "Failed to create LLI pool\n");
> > > > > +		ret = -ENOMEM;
> > > > > +		goto err_put_sync;
> > > > > +	}
> > > > > +
> > > > > +	/* Take the channel semaphore */
> > > > > +	if (chan->semaphore_mode) {
> > > > > +		writel_relaxed(CSEMCR_SEM_MUTEX, ddata->base + STM32_DMA3_CSEMCR(id));
> > > > > +		csemcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(id));
> > > > > +		ccid = FIELD_GET(CSEMCR_SEM_CCID, csemcr);
> > > > > +		/* Check that the channel is well taken */
> > > > > +		if (ccid != CCIDCFGR_CID1) {
> > > > > +			dev_err(chan2dev(chan), "Not under CID1 control (in-use by CID%d)\n", ccid);
> > > > > +			ret = -EPERM;
> > > > > +			goto err_pool_destroy;
> > > > > +		}
> > > > > +		dev_dbg(chan2dev(chan), "Under CID1 control (semcr=0x%08x)\n", csemcr);
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +err_pool_destroy:
> > > > > +	dmam_pool_destroy(chan->lli_pool);
> > > > > +	chan->lli_pool = NULL;
> > > > > +
> > > > > +err_put_sync:
> > > > > +	pm_runtime_put_sync(ddata->dma_dev.dev);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static void stm32_dma3_free_chan_resources(struct dma_chan *c)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	/* Ensure channel is in idle state */
> > > > > +	spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > +	stm32_dma3_chan_stop(chan);
> > > > > +	chan->swdesc = NULL;
> > > > > +	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > +
> > > > > +	vchan_free_chan_resources(to_virt_chan(c));
> > > > > +
> > > > > +	dmam_pool_destroy(chan->lli_pool);
> > > > > +	chan->lli_pool = NULL;
> > > > > +
> > > > > +	/* Release the channel semaphore */
> > > > > +	if (chan->semaphore_mode)
> > > > > +		writel_relaxed(0, ddata->base + STM32_DMA3_CSEMCR(chan->id));
> > > > > +
> > > > > +	pm_runtime_put_sync(ddata->dma_dev.dev);
> > > > > +
> > > > > +	/* Reset configuration */
> > > > > +	memset(&chan->dt_config, 0, sizeof(chan->dt_config));
> > > > > +	memset(&chan->dma_config, 0, sizeof(chan->dma_config));
> > > > > +}
> > > > > +
> > > > > +static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan *c,
> > > > > +								struct scatterlist *sgl,
> > > > > +								unsigned int sg_len,
> > > > > +								enum dma_transfer_direction dir,
> > > > > +								unsigned long flags, void *context)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > > > +	struct stm32_dma3_swdesc *swdesc;
> > > > > +	struct scatterlist *sg;
> > > > > +	size_t len;
> > > > > +	dma_addr_t sg_addr, dev_addr, src, dst;
> > > > > +	u32 i, j, count, ctr1, ctr2;
> > > > > +	int ret;
> > > > > +
> > > > > +	count = sg_len;
> > > > > +	for_each_sg(sgl, sg, sg_len, i) {
> > > > > +		len = sg_dma_len(sg);
> > > > > +		if (len > STM32_DMA3_MAX_BLOCK_SIZE)
> > > > > +			count += DIV_ROUND_UP(len, STM32_DMA3_MAX_BLOCK_SIZE) - 1;
> > > > > +	}
> > > > > +
> > > > > +	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
> > > > > +	if (!swdesc)
> > > > > +		return NULL;
> > > > > +
> > > > > +	/* sg_len and i correspond to the initial sgl; count and j correspond to the hwdesc LL */
> > > > > +	j = 0;
> > > > > +	for_each_sg(sgl, sg, sg_len, i) {
> > > > > +		sg_addr = sg_dma_address(sg);
> > > > > +		dev_addr = (dir == DMA_MEM_TO_DEV) ? chan->dma_config.dst_addr :
> > > > > +						     chan->dma_config.src_addr;
> > > > > +		len = sg_dma_len(sg);
> > > > > +
> > > > > +		do {
> > > > > +			size_t chunk = min_t(size_t, len, STM32_DMA3_MAX_BLOCK_SIZE);
> > > > > +
> > > > > +			if (dir == DMA_MEM_TO_DEV) {
> > > > > +				src = sg_addr;
> > > > > +				dst = dev_addr;
> > > > > +
> > > > > +				ret = stm32_dma3_chan_prep_hw(chan, dir, &swdesc->ccr, &ctr1, &ctr2,
> > > > > +							      src, dst, chunk);
> > > > > +
> > > > > +				if (FIELD_GET(CTR1_DINC, ctr1))
> > > > > +					dev_addr += chunk;
> > > > > +			} else { /* (dir == DMA_DEV_TO_MEM || dir == DMA_MEM_TO_MEM) */
> > > > > +				src = dev_addr;
> > > > > +				dst = sg_addr;
> > > > > +
> > > > > +				ret = stm32_dma3_chan_prep_hw(chan, dir, &swdesc->ccr, &ctr1, &ctr2,
> > > > > +							      src, dst, chunk);
> > > > > +
> > > > > +				if (FIELD_GET(CTR1_SINC, ctr1))
> > > > > +					dev_addr += chunk;
> > > > > +			}
> > > > > +
> > > > > +			if (ret)
> > > > > +				goto err_desc_free;
> > > > > +
> > > > > +			stm32_dma3_chan_prep_hwdesc(chan, swdesc, j, src, dst, chunk,
> > > > > +						    ctr1, ctr2, j == (count - 1), false);
> > > > > +
> > > > > +			sg_addr += chunk;
> > > > > +			len -= chunk;
> > > > > +			j++;
> > > > > +		} while (len);
> > > > > +	}
> > > > > +
> > > > > +	/* Enable Error interrupts */
> > > > > +	swdesc->ccr |= CCR_USEIE | CCR_ULEIE | CCR_DTEIE;
> > > > > +	/* Enable Transfer state interrupts */
> > > > > +	swdesc->ccr |= CCR_TCIE;
> > > > > +
> > > > > +	swdesc->cyclic = false;
> > > > > +
> > > > > +	return vchan_tx_prep(&chan->vchan, &swdesc->vdesc, flags);
> > > > > +
> > > > > +err_desc_free:
> > > > > +	stm32_dma3_chan_desc_free(chan, swdesc);
> > > > > +
> > > > > +	return NULL;
> > > > > +}
> > > > > +
> > > > > +static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > > > +
> > > > > +	if (!chan->fifo_size) {
> > > > > +		caps->max_burst = 0;
> > > > > +		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > > > +		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > > > +	} else {
> > > > > +		/* Burst transfer should not exceed half of the fifo size */
> > > > > +		caps->max_burst = chan->max_burst;
> > > > > +		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
> > > > > +			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > > > +			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > > > +		}
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static int stm32_dma3_config(struct dma_chan *c, struct dma_slave_config *config)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > > > +
> > > > > +	memcpy(&chan->dma_config, config, sizeof(*config));
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int stm32_dma3_terminate_all(struct dma_chan *c)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > > > +	unsigned long flags;
> > > > > +	LIST_HEAD(head);
> > > > > +
> > > > > +	spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > +
> > > > > +	if (chan->swdesc) {
> > > > > +		vchan_terminate_vdesc(&chan->swdesc->vdesc);
> > > > > +		chan->swdesc = NULL;
> > > > > +	}
> > > > > +
> > > > > +	stm32_dma3_chan_stop(chan);
> > > > > +
> > > > > +	vchan_get_all_descriptors(&chan->vchan, &head);
> > > > > +
> > > > > +	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > +	vchan_dma_desc_free_list(&chan->vchan, &head);
> > > > > +
> > > > > +	dev_dbg(chan2dev(chan), "vchan %pK: terminated\n", &chan->vchan);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static void stm32_dma3_synchronize(struct dma_chan *c)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > > > +
> > > > > +	vchan_synchronize(&chan->vchan);
> > > > > +}
> > > > > +
> > > > > +static void stm32_dma3_issue_pending(struct dma_chan *c)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	spin_lock_irqsave(&chan->vchan.lock, flags);
> > > > > +
> > > > > +	if (vchan_issue_pending(&chan->vchan) && !chan->swdesc) {
> > > > > +		dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
> > > > > +		stm32_dma3_chan_start(chan);
> > > > > +	}
> > > > > +
> > > > > +	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > > > +}
> > > > > +
> > > > > +static bool stm32_dma3_filter_fn(struct dma_chan *c, void *fn_param)
> > > > > +{
> > > > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > > > +	struct stm32_dma3_dt_conf *conf = fn_param;
> > > > > +	u32 mask, semcr;
> > > > > +	int ret;
> > > > > +
> > > > > +	dev_dbg(c->device->dev, "%s(%s): req_line=%d ch_conf=%08x tr_conf=%08x\n",
> > > > > +		__func__, dma_chan_name(c), conf->req_line, conf->ch_conf, conf->tr_conf);
> > > > > +
> > > > > +	if (!of_property_read_u32(c->device->dev->of_node, "dma-channel-mask", &mask))
> > > > > +		if (!(mask & BIT(chan->id)))
> > > > > +			return false;
> > > > > +
> > > > > +	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
> > > > > +	if (ret < 0)
> > > > > +		return false;
> > > > > +	semcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(chan->id));
> > > > > +	pm_runtime_put_sync(ddata->dma_dev.dev);
> > > > > +
> > > > > +	/* Check if chan is free */
> > > > > +	if (semcr & CSEMCR_SEM_MUTEX)
> > > > > +		return false;
> > > > > +
> > > > > +	/* Check if chan fifo fits well */
> > > > > +	if (FIELD_GET(STM32_DMA3_DT_FIFO, conf->ch_conf) != chan->fifo_size)
> > > > > +		return false;
> > > > > +
> > > > > +	return true;
> > > > > +}
> > > > > +
> > > > > +static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, struct of_dma *ofdma)
> > > > > +{
> > > > > +	struct stm32_dma3_ddata *ddata = ofdma->of_dma_data;
> > > > > +	dma_cap_mask_t mask = ddata->dma_dev.cap_mask;
> > > > > +	struct stm32_dma3_dt_conf conf;
> > > > > +	struct stm32_dma3_chan *chan;
> > > > > +	struct dma_chan *c;
> > > > > +
> > > > > +	if (dma_spec->args_count < 3) {
> > > > > +		dev_err(ddata->dma_dev.dev, "Invalid args count\n");
> > > > > +		return NULL;
> > > > > +	}
> > > > > +
> > > > > +	conf.req_line = dma_spec->args[0];
> > > > > +	conf.ch_conf = dma_spec->args[1];
> > > > > +	conf.tr_conf = dma_spec->args[2];
> > > > > +
> > > > > +	if (conf.req_line >= ddata->dma_requests) {
> > > > > +		dev_err(ddata->dma_dev.dev, "Invalid request line\n");
> > > > > +		return NULL;
> > > > > +	}
> > > > > +
> > > > > +	/* Request dma channel among the generic dma controller list */
> > > > > +	c = dma_request_channel(mask, stm32_dma3_filter_fn, &conf);
> > > > > +	if (!c) {
> > > > > +		dev_err(ddata->dma_dev.dev, "No suitable channel found\n");
> > > > > +		return NULL;
> > > > > +	}
> > > > > +
> > > > > +	chan = to_stm32_dma3_chan(c);
> > > > > +	chan->dt_config = conf;
> > > > > +
> > > > > +	return c;
> > > > > +}
> > > > > +
> > > > > +static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
> > > > > +{
> > > > > +	u32 chan_reserved, mask = 0, i, ccidcfgr, invalid_cid = 0;
> > > > > +
> > > > > +	/* Reserve Secure channels */
> > > > > +	chan_reserved = readl_relaxed(ddata->base + STM32_DMA3_SECCFGR);
> > > > > +
> > > > > +	/*
> > > > > +	 * CID filtering must be configured to ensure that the DMA3 channel will inherit the CID of
> > > > > +	 * the processor which is configuring and using the given channel.
> > > > > +	 * In case CID filtering is not configured, dma-channel-mask property can be used to
> > > > > +	 * specify available DMA channels to the kernel.
> > > > > +	 */
> > > > > +	of_property_read_u32(ddata->dma_dev.dev->of_node, "dma-channel-mask", &mask);
> > > > > +
> > > > > +	/* Reserve !CID-filtered not in dma-channel-mask, static CID != CID1, CID1 not allowed */
> > > > > +	for (i = 0; i < ddata->dma_channels; i++) {
> > > > > +		ccidcfgr = readl_relaxed(ddata->base + STM32_DMA3_CCIDCFGR(i));
> > > > > +
> > > > > +		if (!(ccidcfgr & CCIDCFGR_CFEN)) { /* !CID-filtered */
> > > > > +			invalid_cid |= BIT(i);
> > > > > +			if (!(mask & BIT(i))) /* Not in dma-channel-mask */
> > > > > +				chan_reserved |= BIT(i);
> > > > > +		} else { /* CID-filtered */
> > > > > +			if (!(ccidcfgr & CCIDCFGR_SEM_EN)) { /* Static CID mode */
> > > > > +				if (FIELD_GET(CCIDCFGR_SCID, ccidcfgr) != CCIDCFGR_CID1)
> > > > > +					chan_reserved |= BIT(i);
> > > > > +			} else { /* Semaphore mode */
> > > > > +				if (!FIELD_GET(CCIDCFGR_SEM_WLIST_CID1, ccidcfgr))
> > > > > +					chan_reserved |= BIT(i);
> > > > > +				ddata->chans[i].semaphore_mode = true;
> > > > > +			}
> > > > > +		}
> > > > > +		dev_dbg(ddata->dma_dev.dev, "chan%d: %s mode, %s\n", i,
> > > > > +			!(ccidcfgr & CCIDCFGR_CFEN) ? "!CID-filtered" :
> > > > > +			ddata->chans[i].semaphore_mode ? "Semaphore" : "Static CID",
> > > > > +			(chan_reserved & BIT(i)) ? "denied" :
> > > > > +			mask & BIT(i) ? "force allowed" : "allowed");
> > > > > +	}
> > > > > +
> > > > > +	if (invalid_cid)
> > > > > +		dev_warn(ddata->dma_dev.dev, "chan%*pbl have invalid CID configuration\n",
> > > > > +			 ddata->dma_channels, &invalid_cid);
> > > > > +
> > > > > +	return chan_reserved;
> > > > > +}
> > > > > +
> > > > > +static const struct of_device_id stm32_dma3_of_match[] = {
> > > > > +	{ .compatible = "st,stm32-dma3", },
> > > > > +	{ /* sentinel */},
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, stm32_dma3_of_match);
> > > > > +
> > > > > +static int stm32_dma3_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +	struct device_node *np = pdev->dev.of_node;
> > > > > +	struct stm32_dma3_ddata *ddata;
> > > > > +	struct reset_control *reset;
> > > > > +	struct stm32_dma3_chan *chan;
> > > > > +	struct dma_device *dma_dev;
> > > > > +	u32 master_ports, chan_reserved, i, verr;
> > > > > +	u64 hwcfgr;
> > > > > +	int ret;
> > > > > +
> > > > > +	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> > > > > +	if (!ddata)
> > > > > +		return -ENOMEM;
> > > > > +	platform_set_drvdata(pdev, ddata);
> > > > > +
> > > > > +	dma_dev = &ddata->dma_dev;
> > > > > +
> > > > > +	ddata->base = devm_platform_ioremap_resource(pdev, 0);
> > > > > +	if (IS_ERR(ddata->base))
> > > > > +		return PTR_ERR(ddata->base);
> > > > > +
> > > > > +	ddata->clk = devm_clk_get(&pdev->dev, NULL);
> > > > > +	if (IS_ERR(ddata->clk))
> > > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(ddata->clk), "Failed to get clk\n");
> > > > > +
> > > > > +	reset = devm_reset_control_get_optional(&pdev->dev, NULL);
> > > > > +	if (IS_ERR(reset))
> > > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(reset), "Failed to get reset\n");
> > > > > +
> > > > > +	ret = clk_prepare_enable(ddata->clk);
> > > > > +	if (ret)
> > > > > +		return dev_err_probe(&pdev->dev, ret, "Failed to enable clk\n");
> > > > > +
> > > > > +	reset_control_reset(reset);
> > > > > +
> > > > > +	INIT_LIST_HEAD(&dma_dev->channels);
> > > > > +
> > > > > +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> > > > > +	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
> > > > > +	dma_dev->dev = &pdev->dev;
> > > > > +	/*
> > > > > +	 * This controller supports up to 8-byte buswidth depending on the port used and the
> > > > > +	 * channel, and can only access address at even boundaries, multiple of the buswidth.
> > > > > +	 */
> > > > > +	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
> > > > > +	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > > > > +				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > > > > +				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > > > > +				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > > > +	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > > > > +				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > > > > +				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > > > > +				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > > > +	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
> > > > > +
> > > > > +	dma_dev->descriptor_reuse = true;
> > > > > +	dma_dev->max_sg_burst = STM32_DMA3_MAX_SEG_SIZE;
> > > > > +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > > > +	dma_dev->device_alloc_chan_resources = stm32_dma3_alloc_chan_resources;
> > > > > +	dma_dev->device_free_chan_resources = stm32_dma3_free_chan_resources;
> > > > > +	dma_dev->device_prep_slave_sg = stm32_dma3_prep_slave_sg;
> > > > > +	dma_dev->device_caps = stm32_dma3_caps;
> > > > > +	dma_dev->device_config = stm32_dma3_config;
> > > > > +	dma_dev->device_terminate_all = stm32_dma3_terminate_all;
> > > > > +	dma_dev->device_synchronize = stm32_dma3_synchronize;
> > > > > +	dma_dev->device_tx_status = dma_cookie_status;
> > > > > +	dma_dev->device_issue_pending = stm32_dma3_issue_pending;
> > > > > +
> > > > > +	/* if dma_channels is not modified, get it from hwcfgr1 */
> > > > > +	if (of_property_read_u32(np, "dma-channels", &ddata->dma_channels)) {
> > > > > +		hwcfgr = readl_relaxed(ddata->base + STM32_DMA3_HWCFGR1);
> > > > > +		ddata->dma_channels = FIELD_GET(G_NUM_CHANNELS, hwcfgr);
> > > > > +	}
> > > > > +
> > > > > +	/* if dma_requests is not modified, get it from hwcfgr2 */
> > > > > +	if (of_property_read_u32(np, "dma-requests", &ddata->dma_requests)) {
> > > > > +		hwcfgr = readl_relaxed(ddata->base + STM32_DMA3_HWCFGR2);
> > > > > +		ddata->dma_requests = FIELD_GET(G_MAX_REQ_ID, hwcfgr) + 1;
> > > > > +	}
> > > > > +
> > > > > +	/* G_MASTER_PORTS, G_M0_DATA_WIDTH_ENC, G_M1_DATA_WIDTH_ENC in HWCFGR1 */
> > > > > +	hwcfgr = readl_relaxed(ddata->base + STM32_DMA3_HWCFGR1);
> > > > > +	master_ports = FIELD_GET(G_MASTER_PORTS, hwcfgr);
> > > > > +
> > > > > +	ddata->ports_max_dw[0] = FIELD_GET(G_M0_DATA_WIDTH_ENC, hwcfgr);
> > > > > +	if (master_ports == AXI64 || master_ports == AHB32) /* Single master port */
> > > > > +		ddata->ports_max_dw[1] = DW_INVALID;
> > > > > +	else /* Dual master ports */
> > > > > +		ddata->ports_max_dw[1] = FIELD_GET(G_M1_DATA_WIDTH_ENC, hwcfgr);
> > > > > +
> > > > > +	ddata->chans = devm_kcalloc(&pdev->dev, ddata->dma_channels, sizeof(*ddata->chans),
> > > > > +				    GFP_KERNEL);
> > > > > +	if (!ddata->chans) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto err_clk_disable;
> > > > > +	}
> > > > > +
> > > > > +	chan_reserved = stm32_dma3_check_rif(ddata);
> > > > > +
> > > > > +	if (chan_reserved == GENMASK(ddata->dma_channels - 1, 0)) {
> > > > > +		ret = -ENODEV;
> > > > > +		dev_err_probe(&pdev->dev, ret, "No channel available, abort registration\n");
> > > > > +		goto err_clk_disable;
> > > > > +	}
> > > > > +
> > > > > +	/* G_FIFO_SIZE x=0..7 in HWCFGR3 and G_FIFO_SIZE x=8..15 in HWCFGR4 */
> > > > > +	hwcfgr = readl_relaxed(ddata->base + STM32_DMA3_HWCFGR3);
> > > > > +	hwcfgr |= ((u64)readl_relaxed(ddata->base + STM32_DMA3_HWCFGR4)) << 32;
> > > > > +
> > > > > +	for (i = 0; i < ddata->dma_channels; i++) {
> > > > > +		if (chan_reserved & BIT(i))
> > > > > +			continue;
> > > > > +
> > > > > +		chan = &ddata->chans[i];
> > > > > +		chan->id = i;
> > > > > +		chan->fifo_size = get_chan_hwcfg(i, G_FIFO_SIZE(i), hwcfgr);
> > > > > +		/* If chan->fifo_size > 0 then half of the fifo size, else no burst when no FIFO */
> > > > > +		chan->max_burst = (chan->fifo_size) ? (1 << (chan->fifo_size + 1)) / 2 : 0;
> > > > > +		chan->vchan.desc_free = stm32_dma3_chan_vdesc_free;
> > > > > +
> > > > > +		vchan_init(&chan->vchan, dma_dev);
> > > > > +	}
> > > > > +
> > > > > +	ret = dmaenginem_async_device_register(dma_dev);
> > > > > +	if (ret)
> > > > > +		goto err_clk_disable;
> > > > > +
> > > > > +	for (i = 0; i < ddata->dma_channels; i++) {
> > > > > +		if (chan_reserved & BIT(i))
> > > > > +			continue;
> > > > > +
> > > > > +		ret = platform_get_irq(pdev, i);
> > > > > +		if (ret < 0)
> > > > > +			goto err_clk_disable;
> > > > > +
> > > > > +		chan = &ddata->chans[i];
> > > > > +		chan->irq = ret;
> > > > > +
> > > > > +		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
> > > > > +				       dev_name(chan2dev(chan)), chan);
> > > > > +		if (ret) {
> > > > > +			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
> > > > > +				      dev_name(chan2dev(chan)));
> > > > > +			goto err_clk_disable;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	ret = of_dma_controller_register(np, stm32_dma3_of_xlate, ddata);
> > > > > +	if (ret) {
> > > > > +		dev_err_probe(&pdev->dev, ret, "Failed to register controller\n");
> > > > > +		goto err_clk_disable;
> > > > > +	}
> > > > > +
> > > > > +	verr = readl_relaxed(ddata->base + STM32_DMA3_VERR);
> > > > > +
> > > > > +	pm_runtime_set_active(&pdev->dev);
> > > > > +	pm_runtime_enable(&pdev->dev);
> > > > > +	pm_runtime_get_noresume(&pdev->dev);
> > > > > +	pm_runtime_put(&pdev->dev);
> > > > > +
> > > > > +	dev_info(&pdev->dev, "STM32 DMA3 registered rev:%lu.%lu\n",
> > > > > +		 FIELD_GET(VERR_MAJREV, verr), FIELD_GET(VERR_MINREV, verr));
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +err_clk_disable:
> > > > > +	clk_disable_unprepare(ddata->clk);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static void stm32_dma3_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +	pm_runtime_disable(&pdev->dev);
> > > > > +}
> > > > > +
> > > > > +static int stm32_dma3_runtime_suspend(struct device *dev)
> > > > > +{
> > > > > +	struct stm32_dma3_ddata *ddata = dev_get_drvdata(dev);
> > > > > +
> > > > > +	clk_disable_unprepare(ddata->clk);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int stm32_dma3_runtime_resume(struct device *dev)
> > > > > +{
> > > > > +	struct stm32_dma3_ddata *ddata = dev_get_drvdata(dev);
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = clk_prepare_enable(ddata->clk);
> > > > > +	if (ret)
> > > > > +		dev_err(dev, "Failed to enable clk: %d\n", ret);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static const struct dev_pm_ops stm32_dma3_pm_ops = {
> > > > > +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> > > > > +	RUNTIME_PM_OPS(stm32_dma3_runtime_suspend, stm32_dma3_runtime_resume, NULL)
> > > > > +};
> > > > > +
> > > > > +static struct platform_driver stm32_dma3_driver = {
> > > > > +	.probe = stm32_dma3_probe,
> > > > > +	.remove_new = stm32_dma3_remove,
> > > > > +	.driver = {
> > > > > +		.name = "stm32-dma3",
> > > > > +		.of_match_table = stm32_dma3_of_match,
> > > > > +		.pm = pm_ptr(&stm32_dma3_pm_ops),
> > > > > +	},
> > > > > +};
> > > > > +
> > > > > +static int __init stm32_dma3_init(void)
> > > > > +{
> > > > > +	return platform_driver_register(&stm32_dma3_driver);
> > > > > +}
> > > > > +
> > > > > +subsys_initcall(stm32_dma3_init);
> > > > > +
> > > > > +MODULE_DESCRIPTION("STM32 DMA3 controller driver");
> > > > > +MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@foss.st.com>");
> > > > > +MODULE_LICENSE("GPL");
> > > > > -- 
> > > > > 2.25.1
> > > > > 

