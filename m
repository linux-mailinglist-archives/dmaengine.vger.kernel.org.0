Return-Path: <dmaengine+bounces-6495-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76678B554C9
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 18:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA0EAA4A14
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520331C582;
	Fri, 12 Sep 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NDgAqYh7"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361EF31AF31;
	Fri, 12 Sep 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695078; cv=fail; b=LaBkN8J901hdXWeMlEl/JNNytd5NvjRYcJSFkp9Disbd9hbIxRljutBFyueIGxMM8gtapFcSWDLVQPvyXtyITvboAHP30HQmVgFXkCeriR4gh2EmH+zRwTp48T/KqB53FYYaUiCqQ9dJqltCK0LkFNgMpDToTRaIcMsC+lo4mV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695078; c=relaxed/simple;
	bh=tG0Od6Wp5ChkjTztJMonI+hIsenNyt6EQO3iHKLZsYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=myFjJ50pnFhjIG4p57QqRY+doRUrqkn/N7UiroxMMSJQ8GsFr9s0AuF4TwqrB19umMLuhMkepVrtEdk5JX5wfMBXxH3JiZ7ht8KqfGOWPL5LYxhr2aVtxavgQ7HnCfndCcDsWCA1bBIVv0DNXYz97Igw/j5bfNCPK5GEjK8idY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NDgAqYh7; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wo8bMu1ummLz5+C7EswlrbwW5Q2+DWEo1c2YqBV6ux2IEO9WFz08CpUPVAtpF/cJzo+NLSfEWuxTmc1yutBYKtluP6zNda8cMzvXtuacJU9HEx/RaRO9BXk8m4+aFLX75w0zMuxujPeDweoeT1GKxyWFCW+ie+mXO/olLlgHUDU6HKdfAWtdicTKbo54xuYRfrl2pe933Yg0m+OvDNe+F6JOlbz159yNl8IIn0QnqfaiBe6OL5Kpl3EbBZ2Kw7KDXVwEPP7pIIYu8H1A2ZNQSiFd7kqQHrmMrE17PNNl/kLB3SfQuwj9GSVpE4cBGigIKNhaxEAV0Vq6ILkRSYfRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKGwEb3qcWZjv5sulW0tP/Tn46f40r71ADg26QD2Q7c=;
 b=sokArGE9WvYxe5rMionwAgQ3BXWjpWsYOGBgRM4Am+/sS0hu10sMzAkrbtLrITtYKVSlI3hcNnB8OrviQW4LFNuzECAlT8E7cmhKCZK7lqUYjJXii5BxlbZdaIseuIGF3aJS/5q1qeSxPJKqvXCups33cfE7LdpMoplBpy3PoQZHboJkKJ2Qsh7b+eaNODj/8niT4wfNIhmwOYnpJbtOnOIJuaOQ72kjLn1Yi9Y07cd6jaVU3KqWMSEzfQOwYZS2+JA+afI7s0PSrAhRNHLEP9hoJE0OLAy0tgI2WWOAtqWfiVi+tu+cxh0P98BU2N5vU9h/YPOtr+3fAeScexZoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKGwEb3qcWZjv5sulW0tP/Tn46f40r71ADg26QD2Q7c=;
 b=NDgAqYh7kqRJClLRGnnvKQCePv18r4ogPlsYOs/VxMbf7KF/7Z4wVqrHJcIGONvFvvjsSAv2sjqUAC3KFOTA4tP0gqcauYK7JMX62RzL8k2JzRKfNCJXG/WWv7wGN9VolniJXUPJPKsJVKCTnoOgcJ71XkVb9h2C9pBAneZqj185j7eimWVoonY8ZpwBmZhsfsRqlDC8CYVl2A9tHJdkkj++LRt2TtS1XD9rTZiu6jcO1ZOXDChkKQ69UouXZm/lVtEGUU2FCI9uqX8sAczQ8sstcTWVoAsohTUkPYv/cL/e6HpV2VDpppPaIvntMd2Y/IlTbRe5HPpaqk4dA8jHBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10589.eurprd04.prod.outlook.com (2603:10a6:800:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 12 Sep
 2025 16:37:52 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 16:37:52 +0000
Date: Fri, 12 Sep 2025 12:37:45 -0400
From: Frank Li <Frank.li@nxp.com>
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
Message-ID: <aMRMWfwcAnkF7wwn@lizhi-Precision-Tower-5810>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-8-d315f56343b5@pengutronix.de>
 <aMQy+Ocs+UWq7WoR@lizhi-Precision-Tower-5810>
 <20250912152508.ccxk2qpcmhxjjsns@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912152508.ccxk2qpcmhxjjsns@pengutronix.de>
X-ClientProxiedBy: PH7PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:510:323::14) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10589:EE_
X-MS-Office365-Filtering-Correlation-Id: e7878595-5506-46f4-a7cc-08ddf21ab7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QhgSquh/iLzj5+GA74EtcOzJUJ+lssS+NLwm2DcGMjWtnCnAnqSbPgBWubTA?=
 =?us-ascii?Q?uJgg24rFxx5l6IaD7KjrDoCDkcWcBRisH96u5AcAChnFONik0hIqDhPhJ4wZ?=
 =?us-ascii?Q?7sjac8fK1DI+8++yr/TwRkqwIjcE7hAkiEgISia3o9+nqfd0OlQ15XD1y+qw?=
 =?us-ascii?Q?jl6eK6sk0n4RIDyOwfYHYy8fu2+B9EqfJDujTrYjqvNovJIKWrUJUXUxW7iW?=
 =?us-ascii?Q?jJ1vZH5zt5Sq5FaMcEdEgQd/GGvUz/LO4hZ3Y3RVAJFgJmQjxwYXTynPlqM1?=
 =?us-ascii?Q?4RhOr7P7p6/zg0mihkykWDSmvlVimWY1RGEdV6sxN64jw16xfzK0ZBXlqtFA?=
 =?us-ascii?Q?pU9wvD1ogHIoSzh2sZnRycDqjLVXLSgR+bT7Uv4GCbdg6mzgNWo1OUqGMpfC?=
 =?us-ascii?Q?4FmC1arcNZc6WhVhTCO8hviSncHDc58UiLDkwX0Y47QU3z5I2UozffFn+X7P?=
 =?us-ascii?Q?8spbMxYn6jccxAWWEx3Dp8DbUIihZNe/1pkcX2ffM+n2PAsej90iPgMXdy2h?=
 =?us-ascii?Q?3LNgCC8cHriVEpUsJekgQiyVt830liKE69+3Dple1NrwVD/ejdEuRQNdPccb?=
 =?us-ascii?Q?dOEAAxh77+0sKVPvf/I0vmMnlvQ/ufZJkL9dDPU/10x4HNTz9zlmXcwD3sXk?=
 =?us-ascii?Q?A6BihgnAtscTB72z39QniYS+IZtWbY+n+wO+05C7VecWl1Fnnu2SZLLjUxxB?=
 =?us-ascii?Q?Hx1E2KnTUM3YrklHmRRsOtKuW1r1yBb9iQVRaoQOHZHJoiLXT+vh54AUQhYc?=
 =?us-ascii?Q?rMgZ45KOTCZY0e7EgT3eYiUVHjfUHQaJQUBHyv/Q+Vgi4KCLXdkS0qAMp71z?=
 =?us-ascii?Q?Xogs2iDVKpHwMZsqJlrKKD0VMyw8OrEf+hAprWV3gpaxMDCPMO+wrCLgDLrj?=
 =?us-ascii?Q?L2yRxuzif1dj+B7XDYFFYn1zARtCZ+RgaV4iIGZX4lui2+sJiRZz4oz+YprM?=
 =?us-ascii?Q?JLyPwGhIlBOy1yJ2BezwnbZwgb5skEFNzRHrAUAVGYB3t/h09u/QWOwgJ3C/?=
 =?us-ascii?Q?5Usiz8yr1Cc9Votp7+FiNLw0WmWTOlAAndNEPrgKgGLQ4fokd3mXc5Ve2C+i?=
 =?us-ascii?Q?MbzOZBWOidrGLkBH/75we5wAbUJTbCCnt5HUFuU0EWzGYj8h5aIAM7s5b02j?=
 =?us-ascii?Q?fLDDk9Holh3f4K6vI7u8TyT667dZaxyLAcMjbHlIzR5WTZE+/I2WuQvJ+dYq?=
 =?us-ascii?Q?JEgl8Kb9wjipeP0L+7WKXKJ3nGhehGknr8GF35A4Dgj3fU+HAf+bpm7xPzKq?=
 =?us-ascii?Q?FWQ7A2ou5kt0k7axGaaat6YIs4N/DOIei62fNum9+wxD/yUIqxUNIk9J9kiz?=
 =?us-ascii?Q?KQYRL1rkj4Zt90JVhyCmGij2+3N3E6cQLwIb6JZI6607hXI4CJCZkRcYHTD2?=
 =?us-ascii?Q?bOfmFSlIjCV4S/rEE54DMzGQfpOj0LG8PfblbNuiLNwusObFcHdLY62SYf9H?=
 =?us-ascii?Q?YfDlrPSPfBs0N6VmumsPv12ACZSHwMdoFcIY5EerkGvBJ8wJ3shEXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TlkO1cH1jcQtoSwUOR93HQA2rux2LqAvz5yPN1Imn+eaYCBcqLC83TekfHEJ?=
 =?us-ascii?Q?xiR1+FyoUZ+RmUf9t4F5x97Kd4Z/pvinVQFCNlneTkSSB2Ybgq8H2zmFNrxF?=
 =?us-ascii?Q?c0kj9VIRWXiCQBqfOUmOYOlOIEXLc5QjOUgOB0lgUTDBoQqt9kmuTWg7yerT?=
 =?us-ascii?Q?giNzU2JME5pCZJjN1qufZBOOSzT2FX+QsA6XmCQ2jd++DdOnOFEXWjR2e7Zt?=
 =?us-ascii?Q?kpVzsxMoJWEImlEDikaSGhvS8KvOPAyp9l7qap4YlGTEj8QFGSM4pkx4N08C?=
 =?us-ascii?Q?/tTxkMXvM+9vo3YoqvKdkwguySrZSQY1KRLnq9y97ok+SEV5n6ZNEtX8scGS?=
 =?us-ascii?Q?LW/Nvh1GOi6cyJuwbd8w9KA7FFHjaTggNTkowcAMmE7oMqexWc2YjOXsll/4?=
 =?us-ascii?Q?F8g3S27ZbjfGErkVFj+sz5az7fmgONVqBF492Fa5psmoTTsUWs3nS3UrwHAT?=
 =?us-ascii?Q?PfHlvabqIjtCTYcr/vzL4R2BSQYXqKpsmu0AlnEuM320FNhvYNrsBnZsoe/I?=
 =?us-ascii?Q?/EpzVsPg1vnZoAHKeslqb1uENweL/x58KqHnoYMdHba/+TclcDjIuSk5p6n2?=
 =?us-ascii?Q?6pRiXks7ODlJ8/JRfbOhkD9bAUWWES4+yv7/OLsbzE2rMlgonxWmLX5vKtlZ?=
 =?us-ascii?Q?QQJWVk/Xp7c1M8HuQY5vFtYwezInvEncvoMezKsr/ANj/EsMTLTn3PpcrvKZ?=
 =?us-ascii?Q?TkYTsKhm656mU3yzFmks5dLxEQL1TvFiukcktw0It4r1pso62PGmgOaPKNY4?=
 =?us-ascii?Q?Xp/zHL/lcnGXd/S/u5RjsVUbNS9ca7HXTcCEnLh7nl+LCc8pZwENecF7dEE2?=
 =?us-ascii?Q?5Apu4O/HrdcXvOvbPQ2QbGABs/zp+R9C2kZ9rtO6xErZU/I2Wj2B4Qlp+uhN?=
 =?us-ascii?Q?RPZpqIVLcsRcha8zAHrzjBmNpNuFiGPWTYOesC86vCk3ogM3iM2tB2NPuX2g?=
 =?us-ascii?Q?NeAvSTHLZY6yDqjefl9ud+1dq7GFBiOuvN9j00ErLmq5mCl+4jrpNwVsp8ht?=
 =?us-ascii?Q?r2ibTakJ13Qi2j2QM/VG7nKEvnwX/abjrgKlZAcG5NjFtP06BSwHX8gAMV2C?=
 =?us-ascii?Q?zezLpjERJlIuMZdQ3Bqvt6uRsqDrSf5qbG92mC7oA9k5VwOoMmcTvEV4QyxX?=
 =?us-ascii?Q?bg+liTdDqFLSnlSd8Ows5ahIdMJTXPxAD0Gb5gqoxoqaiokPsWDiajYLminE?=
 =?us-ascii?Q?QOJVhGxfOBTbLzpJzUTD4tiOm0RGtgkn6tbTIs+zPzCdFxOYQ+zM1BxT4rnJ?=
 =?us-ascii?Q?niltioMlJvOMODFv/MLzfdBiAUu8UI9pPcPetSc1ODO6P8LeEFk1hnFG4H/H?=
 =?us-ascii?Q?0+WxihVMy6zqJJGsiA2aJ5ubiueNZKz3J3prbSAtwpSdM10ZPMo4yvZRhA+k?=
 =?us-ascii?Q?hN8Zt4LDI3Skh1dxiS+C/FUHPSMXDFTttbhJN2fgw/d8y3aFwcGrHQfc8PNe?=
 =?us-ascii?Q?xVvbJ5xLkgargUWrhiS+IE2wfwZewGeJnaiJTwKH03Xv/4vqYRHpGJRoztet?=
 =?us-ascii?Q?BrduX+YaEUEPJxWku28BDjxh9ltJ/8eQYgL9X/wTRwddslufrvwS0eIqLlBd?=
 =?us-ascii?Q?lgqAL0ynarr3RU5Bq40=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7878595-5506-46f4-a7cc-08ddf21ab7a6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 16:37:52.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bf4igb7tUqVepVlnkXwMHJ040arsa43yf6d1ZIng5iB8R8UXO7wNlcCJ2AdzbUteQRXG37ZlJ9elci3VNwvMYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10589

On Fri, Sep 12, 2025 at 05:25:08PM +0200, Marco Felsch wrote:
> On 25-09-12, Frank Li wrote:
> > On Thu, Sep 11, 2025 at 11:56:49PM +0200, Marco Felsch wrote:
> > > Make use of the devm_add_action_or_reset() to register a custom devm_
> > > release hook. This is required to turn off the IRQs before calling
> > > dma_async_device_unregister().
> > >
> > > Furthermore it removes the last goto error handling within probe() and
> > > trims the remove().
> > >
> > > Make use of disable_irq() and let the devm-irq do the job to free the
> > > IRQ, because the only purpose of using devm_free_irq() was to disable
> > > the IRQ before calling dma_async_device_unregister().
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  drivers/dma/imx-sdma.c | 23 +++++++++++++++--------
> > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > > index d39589c20c4b2a26d0239feb86cce8d5a0f5acdd..d6d0d4300f540268a3ab4a6b14af685f7b93275a 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -2264,6 +2264,14 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> > >  				     ofdma->of_node);
> > >  }
> > >
> > > +static void sdma_dma_device_unregister_action(void *data)
> > > +{
> > > +	struct sdma_engine *sdma = data;
> > > +
> > > +	disable_irq(sdma->irq);
> >
> > May not related this cleanup patch, I am just curious why not mask sdma irq
> > request.
>
> You mean by setting irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)
> infront? Not sure if this is required since this is just the cleanup
> path.

It is not important for this patch.

>
> > > +	dma_async_device_unregister(&sdma->dma_device);
> > > +}
> > > +
> > >  static int sdma_probe(struct platform_device *pdev)
> > >  {
> > >  	struct device *dev = &pdev->dev;
> > > @@ -2388,10 +2396,16 @@ static int sdma_probe(struct platform_device *pdev)
> > >  		return ret;
> > >  	}
> > >
> > > +	ret = devm_add_action_or_reset(dev, sdma_dma_device_unregister_action, sdma);
> > > +	if (ret) {
> > > +		dev_err(dev, "Unable to register release hook\n");
> > > +		return ret;
> > > +	}
> >
> > why not use dev_err_probe() her?
>
> Please see my last patch.

You can direct use dev_err_probe() here, instead replace all in last one.

Frank

>
> Regards,
>   Marco
>
> >
> > > +
> > >  	ret = of_dma_controller_register(np, sdma_xlate, sdma);
> > >  	if (ret) {
> > >  		dev_err(dev, "failed to register controller\n");
> > > -		goto err_register;
> > > +		return ret;
> >
> > the same here.
> >
> > Frank
> > >  	}
> > >
> > >  	/*
> > > @@ -2410,11 +2424,6 @@ static int sdma_probe(struct platform_device *pdev)
> > >  	}
> > >
> > >  	return 0;
> > > -
> > > -err_register:
> > > -	dma_async_device_unregister(&sdma->dma_device);
> > > -
> > > -	return ret;
> > >  }
> > >
> > >  static void sdma_remove(struct platform_device *pdev)
> > > @@ -2423,8 +2432,6 @@ static void sdma_remove(struct platform_device *pdev)
> > >  	int i;
> > >
> > >  	of_dma_controller_free(sdma->dev->of_node);
> > > -	devm_free_irq(&pdev->dev, sdma->irq, sdma);
> > > -	dma_async_device_unregister(&sdma->dma_device);
> > >  	/* Kill the tasklet */
> > >  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
> > >  		struct sdma_channel *sdmac = &sdma->channel[i];
> > >
> > > --
> > > 2.47.3
> > >
> >

