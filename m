Return-Path: <dmaengine+bounces-1277-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B831873A94
	for <lists+dmaengine@lfdr.de>; Wed,  6 Mar 2024 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F881283746
	for <lists+dmaengine@lfdr.de>; Wed,  6 Mar 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203C6133402;
	Wed,  6 Mar 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PNKR/nVq"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DBB13475A;
	Wed,  6 Mar 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738623; cv=fail; b=gBJLuGEkjybDaOA50muldMbkcfDb84YYFLKisbCKVE5LREYz6sVRoYvaHLLnp2qI1dvM7HTOHXLdP9BBSflMJlCLW16vsD3sl+WhKcPkaVWfD5ZAz28fieUXaFHKoQVJJiHpxg2OPYIPu1z4sMir51hMbLqFjHO/rAq+7UI0KG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738623; c=relaxed/simple;
	bh=xjQzwWtGB2X1/mIXptK+sZXgJbcigaRYToZkZtJ2M1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=higY0ZEg/alArTeCLeqjcPXq0lRAsXjOlKjVWyQiERsX/GwjbIaaOnP274bSdU4ekizX8Ex1MdXbogOXXVcyQTvDqOwKHO1JuOnx1xQtdHdycCHCQ4OBd4jLCjUa0JTmOm5RPAhx2gQ6KP13Rs9SzT0ibHKtvpDx7caHJc+YIYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PNKR/nVq reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/lv7d7RZMiNLzfYbu8BQJaURVED+Why8r0QN6jxXiOGBI3XaO0wHa1hy8xNiJr4437tUtlXLRv9n6yBF2wlYjfQEn6OO3ydICXZhX0Umk0HhE9vMldDB41H2kMgkjrd7zznt83lFWGPmmkQh6P4r6dI3xN8xgNvTNyHF7BH7dZZ3psFxbGkimH3zvFKr4Zw7FpBsdZrsV9NOCzEYxBdfOIXl8kE8utvzSSulOpuMCXfdRazGnapsDdeLx/dqi3EgnDnLLnwbx1dM0BYGuO88ABdR83Q/r9ctp7HXWaRvSo4+KySMi9cTspOMi/l1THvZeCzDC4cmLycfhPXAcB2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHjN5hcDlUcOvSi3VrAaIId+NJHVzLm4lBBiLAZbTPs=;
 b=Q6glCG3Fc/yptEGr2XeWgNRUlhCWcTCfHsCzF9jZwhcQvyl/pcAZKSfG3cKptEDVI0nGJ4DYqrkjXKaapP4twPQTHwUuJHoJqURBuFlWQ5tGbhYGj0sYQ7ZIhk8n181JZANbumJLQKq8ZL3xeAtzdGxCBZJvrT3t7IkGQNhBcDGMLVjSw5RYsWZKDZbMah71btR7MHUkR/eHXUPmeNhp1mkwAIKNBpUIE00xAVqrjp/K+aslyUSqwmPIseis0fcCCSveV1Gka1jkJ5dyu4DqcE9U3B8F7jcuo0IU+o6M96sOmH89Kbr9doGIPbf6uPZxvkIi6zEhKtMmZfvSLMbnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHjN5hcDlUcOvSi3VrAaIId+NJHVzLm4lBBiLAZbTPs=;
 b=PNKR/nVqmFqygE06EnrqGH+U6IzkUy4Q+XD8rTAGdDA0KcIvduWSi4BLay8BspwmpFhPA3T3Jf0rLyM5YY83hwQpvvSqLUOHgxcOHvy6qkp4Co/5WI1NPYrsWGsICWYRkvEs4nzo++AX2PdikRlxPdHRYyERDTbslJYT8c6uTKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 15:23:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 15:23:37 +0000
Date: Wed, 6 Mar 2024 10:23:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Nicolin Chen <b42378@freescale.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH 1/4] dmaengine: imx-sdma: Support allocate memory from
 internal SRAM (iram)
Message-ID: <ZeiKcYdlQ4S1oWCW@lizhi-Precision-Tower-5810>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
 <20240303-sdma_upstream-v1-1-869cd0165b09@nxp.com>
 <3280558.aeNJFYEL58@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3280558.aeNJFYEL58@steina-w>
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d51758-b0d6-4a96-efc4-08dc3df1652b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GuuA80G5+oiNWIaiULdAAQXfunuDuhRkNRoCSf4TRTh8hvSQO/5lcU7OG8L2pJr3urHYmTS6i1WQ33VyLqvdK5a5I2Ar6L1SrUiiANvNDA85lczuhxCBNUgy9swIRw+Cg0q0H67zKJU9VU3JX4OAicgAOowlCmN0xWzFLBX5UVpbs+xZQN5RBv569B+gF5fqD0ENO9dcIkWXmXaPJ26m0Jh4p2qOcjpj6WsKMnfTp1EjAT6R5Mq500RP3X3zqE56N9vmRy3Htastj8DV2Bws3mUddkvZ+TdiBSgAlWY3a+N/PX9T+FtBPUVZh7U7FoP3QN3DVZLkeYZx97ieUdxGX2t00L2j2dnSbvyQfYjK8IAeSjHx1RK2anXItVnwQoheDmOjcqMBHK1J4hYR8Jj1JlS5a19JlaQS28RMZbZEfW9/jaZqkQ8VAlgxBBMbTjnnivWEiYUua+9Bdk2enMDfYeoG6H/kYhhpfrTFG82TQiH0bxWck2Tm6byuwrv3QymlocoSA4vcmsziWmvqQVShldxuzZ3hkHxef7RItzc+SZWXe08kNxj8cSLt7VC0ASSwyTM+kEIYyx9TieraDkyhCSZRyxx9+632Z/uY8PhJJavXBNR9At+trL2N68kT512zm4f9ME8aXkxi8ASRKI+LhyZrEd5BjzkAcYIMf2vc4ZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?iWN1bIYBLF/sAHGHs1uwxxJobrPm5NzRj8sZ6lg82DZIYOKlqEs/WDn6uF?=
 =?iso-8859-1?Q?AB4Upw5nlsZ3LsXG0lvH56SB8pP4NcvMxeN/mPcV7Bd3hPQai+6QV0EuGL?=
 =?iso-8859-1?Q?uPKwalCepP1HMsVPCtBwHA+VOIacZtsycP63K9Unx/ethOZIWUbrzTUUHo?=
 =?iso-8859-1?Q?gyJ56G0dvquswQvDTI4clQykZudYODDXX5Fcv9tlvYK6WIGD84AaWPQcTg?=
 =?iso-8859-1?Q?4QjxVGiVtIDZVjxyYwPVvFI7TuMYQUb9egofkfYuZcvFPUELSwMWTMMwbu?=
 =?iso-8859-1?Q?AygrbCUQKOTSKjlt7vLhVZolloF81XXSvU5YcuR6Guwyuz34w/LzV4oyjs?=
 =?iso-8859-1?Q?MZbB2ISJUosNTBDf1wPE8HnXMAqKcLLTTsIWlSUl38raD7mayzRmd/5vlo?=
 =?iso-8859-1?Q?ZXiF9iwlMGd7lndIQ5SuWmoeaNGtXU8rhEnTQfP4ystwXXcyp5VEGGYLdM?=
 =?iso-8859-1?Q?41+3aScJnhfUwQmw2POzpiM/mF06Nllwfgseu48muadI8/0MUNbnpzYD3A?=
 =?iso-8859-1?Q?yMQkhLqW8qzslrCrF3xw+7zBTLPXt4pXA2NSD3+EGk5625/yFsygREbUnS?=
 =?iso-8859-1?Q?K05BouvSVMq5iFb1yAStLnYeLewc0STeCi5KR1DSRG3JmASzKVOl+rsHJz?=
 =?iso-8859-1?Q?u0kCSRg7TOVeToJLYl4fuAj8w0xW40NHe1TYmDMebCUYGipGeJ6qdynd3i?=
 =?iso-8859-1?Q?mkaz5u5NIi0/7rM1H+4Rx3Pt1eP/Tsxzm6Vs0D2HRTGpWVZdxGK6g8ouen?=
 =?iso-8859-1?Q?Q7lzpiwKomnMyYhkOAf2OWKHOH3fLAqoU0oI/veTKUiSYKVtMgPx34X9t/?=
 =?iso-8859-1?Q?ERlL6N4JsIVEzGVA6aKopnTsQ5X6EckMiV14lJDjc/5YlxsKAFN76Zsrzv?=
 =?iso-8859-1?Q?b7B1GNX+ayOnMVHW3NAjF2q0IEf5xCXuRbV8ixAYMWQJWGieMi+r1cEs+E?=
 =?iso-8859-1?Q?YEg2/ivzQdurM2YyW/dNsxmyyq1syPo6lQxvETipiAH5FmMz7nG1Wei722?=
 =?iso-8859-1?Q?IdOWfMBZAUMcyWGwShH/wIw9RIohCm3lD8Bk4Igbf8l5Z8l06SGh5ArdIn?=
 =?iso-8859-1?Q?mJiJyd1XjS1EQq3wW5Ug4ypN8ZgrP9YI8IIPcDCKX6pddABWRjw+sei28M?=
 =?iso-8859-1?Q?qQ6BhM9mQ6knmtizDIEkS8SzN+1bmzGGz6Gq5gCV/7d5yvHiuFGS2wCx/T?=
 =?iso-8859-1?Q?sT4qyYOAzKn603rBbY2WoyHMZO4Z75sWVw6dzxem+GlXfNsJIB8C6CJJnT?=
 =?iso-8859-1?Q?OUpaESnLNVaYcGE77Akyoo7bBqk9Q042Wqsc5Eqde3mdMwEKaBdlEY0UAE?=
 =?iso-8859-1?Q?K5RZLTlZ3FTF3r64bwVayFQGOK4mtVVGnwcJQnpgHcq82eN62s8YW9D2K9?=
 =?iso-8859-1?Q?rfHXikba2BZO560clEvaBRJwCC0zNFLtdNaec8rWFocdnplXATdD/pUMiT?=
 =?iso-8859-1?Q?k6/9S+JyZyBLAbVWjf+Nmb0Ln70ZUtSkcLz64dnTLAy0aOMbuztUsuUSRI?=
 =?iso-8859-1?Q?YUGs6sQH2iv7JAsq4s4+H90fiZm5GEgmDIx9DN39DJzPmBYkcW8JQLSSIk?=
 =?iso-8859-1?Q?Rx6R2HjkUZVHscmoVyh1dsZnE/EHcaglvfTkSZ2jd5S5RlrkXNhH4icY/f?=
 =?iso-8859-1?Q?wP5m4TKasL8bvEgA2LrQmUq27n9Zl7Rs9r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d51758-b0d6-4a96-efc4-08dc3df1652b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 15:23:37.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Cpx4jSdo/8mCrWsnfQasRUDHYyzFEehRUdLhefFkZ+3jcfpW+XGD0ZC1ACstsdpjDeDQjrc8aLgD5nbQUn8zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238

On Wed, Mar 06, 2024 at 10:55:00AM +0100, Alexander Stein wrote:
> Hi Frank,
> 
> thanks for the patch.
> 
> Am Montag, 4. März 2024, 05:32:53 CET schrieb Frank Li:
> > From: Nicolin Chen <b42378@freescale.com>
> > 
> > Allocate memory from SoC internal SRAM to reduce DDR access and keep DDR in
> > lower power state (such as self-referesh) longer.
> > 
> > Check iram_pool before sdma_init() so that ccb/context could be allocated
> > from iram because DDR maybe in self-referesh in lower power audio case
> > while sdma still running.
> > 
> > Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Nicolin Chen <b42378@freescale.com>
> > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/dma/imx-sdma.c | 53 +++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 40 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 9b42f5e96b1e0..9a6d8f1e9ff63 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/semaphore.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/device.h>
> > +#include <linux/genalloc.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/firmware.h>
> >  #include <linux/slab.h>
> > @@ -516,6 +517,7 @@ struct sdma_engine {
> >  	void __iomem			*regs;
> >  	struct sdma_context_data	*context;
> >  	dma_addr_t			context_phys;
> > +	dma_addr_t			ccb_phys;
> >  	struct dma_device		dma_device;
> >  	struct clk			*clk_ipg;
> >  	struct clk			*clk_ahb;
> > @@ -531,6 +533,7 @@ struct sdma_engine {
> >  	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
> >  	bool				clk_ratio;
> >  	bool                            fw_loaded;
> > +	struct gen_pool			*iram_pool;
> >  };
> >  
> >  static int sdma_config_write(struct dma_chan *chan,
> > @@ -1358,8 +1361,14 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
> >  {
> >  	int ret = -EBUSY;
> >  
> > -	sdma->bd0 = dma_alloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
> > -				       GFP_NOWAIT);
> > +	if (sdma->iram_pool)
> > +		sdma->bd0 = gen_pool_dma_alloc(sdma->iram_pool,
> > +					sizeof(struct sdma_buffer_descriptor),
> > +					&sdma->bd0_phys);
> > +	else
> > +		sdma->bd0 = dma_alloc_coherent(sdma->dev,
> > +					sizeof(struct sdma_buffer_descriptor),
> > +					&sdma->bd0_phys, GFP_NOWAIT);
> >  	if (!sdma->bd0) {
> >  		ret = -ENOMEM;
> >  		goto out;
> > @@ -1379,10 +1388,14 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
> >  static int sdma_alloc_bd(struct sdma_desc *desc)
> >  {
> >  	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
> > +	struct sdma_engine *sdma = desc->sdmac->sdma;
> >  	int ret = 0;
> >  
> > -	desc->bd = dma_alloc_coherent(desc->sdmac->sdma->dev, bd_size,
> > -				      &desc->bd_phys, GFP_NOWAIT);
> > +	if (sdma->iram_pool)
> > +		desc->bd = gen_pool_dma_alloc(sdma->iram_pool, bd_size, &desc->bd_phys);
> > +	else
> > +		desc->bd = dma_alloc_coherent(sdma->dev, bd_size, &desc->bd_phys, GFP_NOWAIT);
> > +
> >  	if (!desc->bd) {
> >  		ret = -ENOMEM;
> >  		goto out;
> > @@ -1394,9 +1407,12 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
> >  static void sdma_free_bd(struct sdma_desc *desc)
> >  {
> >  	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
> > +	struct sdma_engine *sdma = desc->sdmac->sdma;
> >  
> > -	dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd,
> > -			  desc->bd_phys);
> > +	if (sdma->iram_pool)
> > +		gen_pool_free(sdma->iram_pool, (unsigned long)desc->bd, bd_size);
> > +	else
> > +		dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd, desc->bd_phys);
> >  }
> >  
> >  static void sdma_desc_free(struct virt_dma_desc *vd)
> > @@ -2066,8 +2082,8 @@ static int sdma_get_firmware(struct sdma_engine *sdma,
> >  
> >  static int sdma_init(struct sdma_engine *sdma)
> >  {
> > +	int ccbsize;
> >  	int i, ret;
> > -	dma_addr_t ccb_phys;
> 
> What is the motivation to put ccb_phys to struct sdma_engine? AFAICS
> this is only used in sdma_init. Also the following patches of this series
> are not using the struct member.

You are right. let me check other donwstream patches. If no one use it, it
should be local variable.

> 
> Best regards,
> Alexander
> 
> >  
> >  	ret = clk_enable(sdma->clk_ipg);
> >  	if (ret)
> > @@ -2083,10 +2099,15 @@ static int sdma_init(struct sdma_engine *sdma)
> >  	/* Be sure SDMA has not started yet */
> >  	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
> >  
> > -	sdma->channel_control = dma_alloc_coherent(sdma->dev,
> > -			MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control) +
> > -			sizeof(struct sdma_context_data),
> > -			&ccb_phys, GFP_KERNEL);
> > +	ccbsize = MAX_DMA_CHANNELS * (sizeof(struct sdma_channel_control)
> > +		  + sizeof(struct sdma_context_data));
> > +
> > +	if (sdma->iram_pool)
> > +		sdma->channel_control = gen_pool_dma_alloc(sdma->iram_pool,
> > +							   ccbsize, &sdma->ccb_phys);
> > +	else
> > +		sdma->channel_control = dma_alloc_coherent(sdma->dev, ccbsize, &sdma->ccb_phys,
> > +							   GFP_KERNEL);
> >  
> >  	if (!sdma->channel_control) {
> >  		ret = -ENOMEM;
> > @@ -2095,7 +2116,7 @@ static int sdma_init(struct sdma_engine *sdma)
> >  
> >  	sdma->context = (void *)sdma->channel_control +
> >  		MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control);
> > -	sdma->context_phys = ccb_phys +
> > +	sdma->context_phys = sdma->ccb_phys +
> >  		MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control);
> >  
> >  	/* disable all channels */
> > @@ -2121,7 +2142,7 @@ static int sdma_init(struct sdma_engine *sdma)
> >  	else
> >  		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
> >  
> > -	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
> > +	writel_relaxed(sdma->ccb_phys, sdma->regs + SDMA_H_C0PTR);
> >  
> >  	/* Initializes channel's priorities */
> >  	sdma_set_channel_priority(&sdma->channel[0], 7);
> > @@ -2272,6 +2293,12 @@ static int sdma_probe(struct platform_device *pdev)
> >  			vchan_init(&sdmac->vc, &sdma->dma_device);
> >  	}
> >  
> > +	if (np) {
> > +		sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
> > +		if (sdma->iram_pool)
> > +			dev_info(&pdev->dev, "alloc bd from iram.\n");
> > +	}
> > +
> >  	ret = sdma_init(sdma);
> >  	if (ret)
> >  		goto err_init;
> > 
> > 
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 

