Return-Path: <dmaengine+bounces-2505-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD16912863
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24561F2976C
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DA2231F;
	Fri, 21 Jun 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CHUy3uW3"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D204C90;
	Fri, 21 Jun 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981316; cv=fail; b=YVO7uCnkq7k7ekTFZhyv67yOmPmsnof2fzH7yW46Yx0dwsgH4ONIvs+kQQT305KJ3HTqxOq7sH52paIILAfeGYVO+RGsmUsqws3m+7YzxSN4wRUSw9OsOcPwp62m9popNctnIQ4Zk8MfaelqALa8IiUbOQDcw6i9t2U57Z1NOH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981316; c=relaxed/simple;
	bh=syfEHjM/ZfGW6CTcjLiozLt/0heKxycZIsTbwcM42PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uaZJC8NReX+AVDnquKRPiILL/KZOF8QpTJ4Bx/+Zur3x/R+KJkJDYLGcrw2NZ5O2fB0phgF0ieGURAQ6JCRjzabLLtbzjNi9xlsN4i/CPbj5+ZsV/2NAwa6P/UZ67SJtBrBsULWKoGfCIM5EaueqPulHBw4fR/nvU+omZs4C54g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CHUy3uW3; arc=fail smtp.client-ip=40.107.14.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ/NsqJDLakQrY3ljI5wdLGQoAI0JXffpXLOVEnfOLfZ5fKkUGoBhuJGzit8GHR28/CYo1XO60mmiCWTCuHS56bVeCP8vB9SUUsAtiKdtC7gdZtAjVh4/Fxn5Wiw19bCyqX5LSq2ulCPQqiPtdTO8Uvc+LpUC3ny6hBwXa2ufsg6k0AT1drLvk4QXBm4Gg2RqKGbefnQuCIgnOKseeUduK4FBud0MfWGtUP3K/ekb/btRSdEH5V1l+NhmCOuqqrFbU3Gqs27aPBg3dKrHG0IXUadc60rzmMRTMo0fivLeXi8J8VLq3Po2TStbhvo4xCN69Kbi0XIzfCr6U7VrRqCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er2IedP7IeQCKZvt0PyYvWrrSs6DUXpX+poZAO6G4VI=;
 b=EYVfT5LRtASJ/En3mgD+l3tS7njp8sehBxi5WWFhZamByatzpDrrQSdmh0BgUcMqjDhLwpYlP9j54b/2ReEu/66ceOHde8lwX++/fbRGBGDEPuBBaESWAD9Z2IWUMvhmNeE8b2aUF7BuWstWmoT7oNZrMNRG9kX5nsO+EwaFqVOd4GnMEOjvAsMgb3Rh+0vPtfjNIPq1MxqDtHx93xxSJojniH3C9lSpS4RpsU+wS6kQm2RP83olJZfidEieXftOcgTLRcVnXUe7cFLAUU8eV/3YJxo+q2nsfxf1CCHat08s+SQi/T48JauMzLbMtQ7lCk4ismNT/kWnoX56RkwBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er2IedP7IeQCKZvt0PyYvWrrSs6DUXpX+poZAO6G4VI=;
 b=CHUy3uW3nBQCeEFShRgCcpgCAzC1HWXdp5QTVZvzvq4yTgO6J9xkZL6uzC0fe90ZK7kpnSKG2wmRz1E3vl7GnpxwXqLjWiLL0Xcpd0Gd6s3z8XkptVyGzdyJV7OQwNUHVhbo6EvJ6uRGwvk48wo0kFlgzMV462Ou2/p8/peCnTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10134.eurprd04.prod.outlook.com (2603:10a6:150:1b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Fri, 21 Jun
 2024 14:48:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:48:31 +0000
Date: Fri, 21 Jun 2024 10:48:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dmaengine: fsl-edma: change to guard(mutex)
 within fsl_edma3_xlate()
Message-ID: <ZnWStxXpe4dyWn+p@lizhi-Precision-Tower-5810>
References: <20240621104932.4116137-1-joy.zou@nxp.com>
 <20240621104932.4116137-2-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621104932.4116137-2-joy.zou@nxp.com>
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10134:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef6e6e3-c914-40ad-d243-08dc92013828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|52116011|376011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nCnQdBKkrP0ZhFhueDe92uqiTcz5ULuKMQjJdvbFhGA3Q/34WvsFnayC9BUC?=
 =?us-ascii?Q?S/aTEIp2PvqUBTZW5EbOicecI1GbpOBdZ5xpvPPmfF2PSqYtQuSIbb8abfcp?=
 =?us-ascii?Q?sbyTqRI+RWr/GNfHSYFBJ+4QyUNRx9udPLKfRtFDb9Eebv/dt84VJmQ5i57H?=
 =?us-ascii?Q?34jSDDz8Jcpc6ifIuog2B9UEQTnG8ot70cXautwbxziyjlroEqvUN0EbeEPA?=
 =?us-ascii?Q?dwpm68SCt90uzPU6xEz9UgUVrL5a9laTtmob+XBz3V9pLl7KlxiB6FGKPGTy?=
 =?us-ascii?Q?XElE8/qenZaxQsfcFB4QjRvVq9dwEo3Q8/+cnJXbOfuExYuhebtBmYXXXsN2?=
 =?us-ascii?Q?AHfviLzqPnN42HOJmbnfwEbAB8+1SHXcX93EUTxOHzP6JErhxeDkis7FIjlA?=
 =?us-ascii?Q?IPoEZ8VxURsA/8YrEyDd+3N4XLgakozyN/m4fX4I1cvpYmNa8/7WJtJax7mp?=
 =?us-ascii?Q?sY4DM8T5lQ6w9/gj5+BGX6i21piRH4H4yUUIUhe4wYrf+ZvyPZ0ARDHnK4EA?=
 =?us-ascii?Q?uVFyzvO4H1fdlE1iv85NrPisSUV+PGpgFxIARWF0P57PRd69CvWCDHE4/Kqe?=
 =?us-ascii?Q?DzpwVY+j5yEqGuK8v67JXAG+N51Uww5x9nfZXX9cGfnF9jnPh7WDzdnVg6qm?=
 =?us-ascii?Q?aJfNwCbZuxrhux0FBkwzhROKiGbmDRfLpR/b3fY3mTDQmTu+yRRN5U3RTyHY?=
 =?us-ascii?Q?iHTKogiCnwKjdg7Em1Yhx7akGaPF/YahL9wDA0bN90Iz2DMsfytwBQbfVZRE?=
 =?us-ascii?Q?gou85OLbwfP2Z2DfHFLoWbArL+q2TRK44F0WKeAuvKgJ+TUpJB83SZGdptIj?=
 =?us-ascii?Q?aCOuJ8CnlKxyWthg70SfkKCdnAPQIGspVwn5/ZJeUuyL/auLF/8xnlBAwU5n?=
 =?us-ascii?Q?tYIXNx7dDBc7R9HkRg3MH4xmOuAHNhuhOlJAyOXygSwRz994Gm/MsGDZ/AbK?=
 =?us-ascii?Q?+1hYA/35wR13dMaaaHQatTiuSnGlOu/UTr7fE/yQrqGAra/w1iCokqNw/9bK?=
 =?us-ascii?Q?AgSXh7R7WFn9I4kimvE6BSLbfBwdoRw9Vg6Ej1a3OS60zhov8ft9hf6cxt7G?=
 =?us-ascii?Q?BAewlSefF+4DN4rpRTDdkcUNA/L4xFxpGZgI6GQKcpAmoG+/xfTB8eEBtBSv?=
 =?us-ascii?Q?4AxJcVOfYu8bmmkqEgA8Ielx7bFx9MHzndBq5Y7i1f9nInDL/Fkqjn3oEYwO?=
 =?us-ascii?Q?jfJDKL6sB0o+5fjpeIM6VCRAWO5mHiNmZ14blqgk8NvHRYvq4qFASFyFKm3G?=
 =?us-ascii?Q?siDks0bWNgbwxpxayLSmC35b0Q11eMxd6CFfATOelWGQhMXP61ZAVruZWAu7?=
 =?us-ascii?Q?sZdxaMDSGuR/ddW2o3b86CSnqWKwX6VY11qjyD99s+LT/F5L0DUbmOlnKXS7?=
 =?us-ascii?Q?iw1iT4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(52116011)(376011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kDPwZi8PTjcTDCZvPqsm8Qcn5ur0zuFyf426a0kDzjqbZTuya4/ZrL2Y4A0W?=
 =?us-ascii?Q?Fy0r/WUvgbQS/T6boLalTm8yDrmcILDaKFIi3ux+bDuIHOTCdnZ/dGJNTAqU?=
 =?us-ascii?Q?zdrzX14Rkp+ac2houIWMiggTGEMcaIY+v42/NTMwhDNcMvTsAPkhRoApDsKQ?=
 =?us-ascii?Q?sfUlOnOOV9DyTVYNWiGj7lkLhz8um84QQ4bNT0NE9x+t5/3wJBqI7nJxj7H9?=
 =?us-ascii?Q?gtbMmtfogJvLvFAa9AmoAsjDG7bA8luiBfxLcqKLlU+m91hg2haRNtBUoHtd?=
 =?us-ascii?Q?9fToAtXQKbiIrH21MDC5EsiNbKLbP8oyk6wTiI8ISkL6Nl60+hHXHUg92obE?=
 =?us-ascii?Q?nwCg10HITmokhEs0o7u4hHY2kd7f79wZh7sLbSuIM4sisxFkTUxwDIumlDjq?=
 =?us-ascii?Q?q1EQJcDlsoE9BLHxHkNJpnnLzPQu9RgLjEiuaSA+eZrmSbJWmnm1pZlniTLU?=
 =?us-ascii?Q?ncER6IeQ23vVki5IBb+FDrojWTzx21b7wBuyH0Au7WWjuTVWFKc0pSHg9Rh5?=
 =?us-ascii?Q?3t4B0yTtfs4CjsIHTn7oFR7tS1WUGVrpw7RehPt6ZMbJk1BTZDZIOUbaZK2W?=
 =?us-ascii?Q?rxsATiA5iiGlx+QLO12aay/eaHSInCkXwMv3PYBaklgZ3GolbVRRa0Tuvvyy?=
 =?us-ascii?Q?o1gsLTARNQKe/PCNy5Q2kaRrq6RLV63y2sztFDteA46eDJfbmtEzd9KoYPqW?=
 =?us-ascii?Q?JafISr4h7A75G6irq51rTFpk+vN3bsL0vJpFML6GR/+QHxWyQA5hj0fkd4ss?=
 =?us-ascii?Q?3+VizDt8q+6lo8kbBLt5ucUnChhKFr7TLEZ8JDBRHLzp2Ev/FGprygf4vSbn?=
 =?us-ascii?Q?1QIe+dEPdJ7s9m76kuvjScvlpKNSRdnvDaNZmmyziPDby0B5vhJoP5jBREJh?=
 =?us-ascii?Q?ajDM2AoYTJdC8anDU/PABLJWVZ716kzZ/5Z6P2/Vrf4L6X+aQFuTuyfFegTB?=
 =?us-ascii?Q?zfRFgE8aH3bOiUffOM1ncpmja9Y4zCP2LkS+WwojhknM9f92hhCnhldmdhzj?=
 =?us-ascii?Q?8dQq0ui7CY1NZeYL5XJYNNySBx/aEhUwyzYThqpuU0IDyIl5THsq7WvbthH5?=
 =?us-ascii?Q?wAKvj5IB33+glywlO0/8/xlfrYUoZtRZxZYYJ1Hr89emj7dQqLhvMZyuaKBN?=
 =?us-ascii?Q?qdO7QvQBqpSVjnDor/ZkhdRfrwH4glwm0VSxGwWKLT4IsdkmKGht2pnwI+jk?=
 =?us-ascii?Q?W2sI4PqCPv3FjsLjQfI+tY87Z8hBghl+9MTrXSqyJ0cDSFPK5pwM4ShfnsKM?=
 =?us-ascii?Q?vH6OTkvhvSwFTQx8k+uc/hw3taGxmcR0q/39KWZMVWF4jFK4JWw+j+xPQSqX?=
 =?us-ascii?Q?Bhw+5eek/tMJe+EEIH7CusoJnxXNAwDr/mAOqbyPGbUg7Ey5pl7ck1CkeD2n?=
 =?us-ascii?Q?BpUEjYOuZ4nEOBYMYZpbu6ZxFjTAftJ6RRc85DM1wzSmYZcO6z4I46+gEcIE?=
 =?us-ascii?Q?F8SH4gh9DhrJ4KdkgrbHKPTcjLKXvENyV2vbwnOJzkvPjx5Nwy24tI+sXPYi?=
 =?us-ascii?Q?iwCL4FpQeUdyw9h+tjmpMRg2vMs4F5nmHd14EW0EzwCdKH23tIDQZl8e1sGu?=
 =?us-ascii?Q?DbI35jLDXUnXelbn+an3LZZRLBqwnL4F1EYnsW2d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef6e6e3-c914-40ad-d243-08dc92013828
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:48:31.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZVuFUsjJgPdhdRY0xIXzXRSkCj1MDMWs+Wb1Pe7j/rm5+x70sNb+Sh9y+nTeoRHrD1jB/d9vp21/WiZcq266g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10134

On Fri, Jun 21, 2024 at 06:49:31PM +0800, Joy Zou wrote:
> Introduce a scope guard to automatically unlock the mutex within
> fsl_edma3_xlate() to simplify the code.
> 
> Prepare to add source ID checks in the future.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/fsl-edma-main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index c66185c5a199..d4f29ece69f5 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -153,7 +153,7 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
>  
>  	b_chmux = !!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHMUX);
>  
> -	mutex_lock(&fsl_edma->fsl_edma_mutex);
> +	guard(mutex)(&fsl_edma->fsl_edma_mutex);
>  	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels,
>  					device_node) {
>  
> @@ -177,18 +177,15 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
>  		if (!b_chmux && i == dma_spec->args[0]) {
>  			chan = dma_get_slave_channel(chan);
>  			chan->device->privatecnt++;
> -			mutex_unlock(&fsl_edma->fsl_edma_mutex);
>  			return chan;
>  		} else if (b_chmux && !fsl_chan->srcid) {
>  			/* if controller support channel mux, choose a free channel */
>  			chan = dma_get_slave_channel(chan);
>  			chan->device->privatecnt++;
>  			fsl_chan->srcid = dma_spec->args[0];
> -			mutex_unlock(&fsl_edma->fsl_edma_mutex);
>  			return chan;
>  		}
>  	}
> -	mutex_unlock(&fsl_edma->fsl_edma_mutex);
>  	return NULL;
>  }
>  
> -- 
> 2.37.1
> 

