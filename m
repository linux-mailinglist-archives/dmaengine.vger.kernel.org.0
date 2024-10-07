Return-Path: <dmaengine+bounces-3292-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA89399320A
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1752813F5
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCF41D9340;
	Mon,  7 Oct 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lDEGHjbV"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6ED1D9597;
	Mon,  7 Oct 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316353; cv=fail; b=gZt6cRhTH+Qn6huPPyFPZRgKqEwyUh2h81kaOeh22rl6koZZKgjrt2ewAIkDYcQdmrpcLtWls7Qg34PRjvxIkt69uVNnlontPVUJBB/6oRKczGdqZH7axeQD60o5+LjCs0xKvYXcPxvq2dSZkDWgo6sFj8qw6rE96rML52GiQ0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316353; c=relaxed/simple;
	bh=PRaZS/Mp5+/LJ+5H3MvppKg+lA0bDQDvUU/IAXOHw4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JB6LM1ZLaRZkYlmbA5Q35vFJfNwzORgm/u6QgqnLMRXgdlNK0mBLgMHDQ4rSMXlKCYN61AfHgsSLCxbrxufYOlU/5dmGYGk8RTCmKd9mrskvb5RWVfHA7SVmf7ocF/3kKKBfS+Wc85lW4trj8mptEjNeQ/pU4X6pkavG3UQ3ikU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lDEGHjbV; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnLYlpKhGgLtaqchlZYa7G178V3dIU9wa4AptTf3nBbyVpu/9zKAznHgCBVwWSy6Q17dmU5LRY/8fPobEnzALLhv/cuYM7nPL2zQUWI1qKzl9Zkfw6rl8QKixW3NGc9EHH30OFy7QU3EJ2VnaMeMwAXPB1OhW3Guj0HSbqa9fqyp1YoUuA6bKu4D40GstvDlYUwaRJYH2aWGkmHtu+V39WckNoFrK/D0Qg1YMHBYKuPqlOBUD+fei7DcErocTMlnFFuHVKKUUqWweKZCMlCGRpkGvG5KoN5f0OwsWdQM5hVWJxlirOfBvqayhxILc0TqoRsRp/zlvG2FCt20D06j8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPdzkS8Shqtma9OH7/vKb7ahQhLSHAmtCY+xhFuHASM=;
 b=OLZCqSaCl8SOB5WnO5MMzIftlW9XfQ40ghC1NmTqUL62aUkRGBqwVL+Gl7eXcGdlZFn1caz3huFTnqf8566LceNjCWD8sFgZSzBdUPXAFopMi+lnXuXJEJL571J4KG72hIRNHMtcnRpHACPqxWWBifS3Rf4+YIkeR4/sI09j+WDIeucwq6006zi147Peq8rwXySA00AEawX+nMNRRIIjUFBlBuNI9nJsy4ULpKJqV+hbSl2503f8mC4g+lbTS0sAhkpEtU9qIZvmd7KAq1Gdsbj6cnWYSpGnKx531WT1WKGQnlSJDszb4Hn9SqT3C3T0xspX9fzTMhCT224cZXUILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPdzkS8Shqtma9OH7/vKb7ahQhLSHAmtCY+xhFuHASM=;
 b=lDEGHjbVuCX1RoE/iK5JM6XDDpoHmeR/0VbekfiJHpLk+5B9AYbHRzOfYm12rSe3VQVSJdCNLaliq36i2rYFKEaXk/Me/mlqWBkOsmFfLcnHcrLqFGWveL8+JfdMijxA1EooohD+t8JjGcuBzlhsMWi2NLF3ietHtv83BbC0Jzjnwpds2fdW2AWhknJ47AshpqJI0VbEENZ/RU2GVA3EgAB343yhF/mszJu5kmAXsLGlUCQIeYW0lZ1lsw5t56pCMC+eOnKNzROscf8tvJO++hhE0B0LipFTFcHbGuFV2HdqFoAtQ9QcGPpZoVH5qyxyluFWSbsiO2bjXLPgnMeFsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10886.eurprd04.prod.outlook.com (2603:10a6:10:580::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Mon, 7 Oct
 2024 15:52:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 15:52:29 +0000
Date: Mon, 7 Oct 2024 11:52:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 1/4] dmaengine: Replace dma_request_slave_channel() by
 dma_request_chan()
Message-ID: <ZwQDtYYCyPyY9yPO@lizhi-Precision-Tower-5810>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
 <20241007150852.2183722-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007150852.2183722-2-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10886:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e25f446-394e-4987-d5a0-08dce6e80c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ndYhzTtuu0FEfzdCCkkJafxdXQdX90sJeiuM4u3I9OWEfdMRe13SiwDhfwx3?=
 =?us-ascii?Q?HUhlRrahhr1EY6/CSgPW3kS0I58+ShiqD11JYIhkm55r9IiSUpOsIZLyY9/y?=
 =?us-ascii?Q?A9PznoLwvp1w08XbRnr127YHak4rjo26+P7VCBp42IuijO+daPHKYUv0L0mY?=
 =?us-ascii?Q?h//wtTrLC7f4Y/eHFypCza6WeEFysoOrzcUBRZ14r7cqog62VNLFy2ATEIRc?=
 =?us-ascii?Q?BR/U6C778gvLjlR076FxZzCymTTO5iPdsSeSzVdlcjvOacz0Te8Be0PWXgeE?=
 =?us-ascii?Q?vkhwPufl/jTvSzq2ChqQm/jWK6QN2DZ5sWLd5lkhGb0SOjlEk2iQNT66KFzl?=
 =?us-ascii?Q?7UpKv2rm+nL8okvM9C4nbZScK9B+B9vwG55j5zR6JJsKx6kpA+pwPM5zyls0?=
 =?us-ascii?Q?rcGX5IKv+XHHi9fwlTbdzHeU749t5KjVeC9m9s+kki/6akdyssEnUiKPcoA2?=
 =?us-ascii?Q?HWIV44tMGdZXbzXHwcb/SuWHcprqo+IlWj67/VnLVPxjoPkxgzeM7wjN/neN?=
 =?us-ascii?Q?7lYKGUAoIVklRvkiYsC4q+DTUDOibxcLTKVKhumNZeJHR7XzbmyZ3faeu2CF?=
 =?us-ascii?Q?xFNehhbYDXXVUIMjfWiM8yIswbwv1JS/nTBHzZe0lZ/l8/KgY5RVSXoLYey+?=
 =?us-ascii?Q?DDnQCASRiGYaiB4c3KCSUxqoTO+o5D1IJmVcxit6Mx0KUVW/s5L4q8fZkTIh?=
 =?us-ascii?Q?7NNXDACLDq8wVbGPEalNILShSIWNWZhef0U21JEiN7s54uPI8X8AED09EzeT?=
 =?us-ascii?Q?YzlQuq4ZnLZraASzn7OMMooAOhAtS99X7syVCsiTlxPpRvEGpugE8z6TwZoQ?=
 =?us-ascii?Q?+4MD8cWkLIhFQTjRU6sszk0gzVojFPyboP0Flx30MhU+qgqRP+Rf+d4dQzbt?=
 =?us-ascii?Q?adJXQn+rgwSXFLF1EiUzP2KSN8CQyW+DojITHBKRCwPs2aBOIAPpOm25aeAz?=
 =?us-ascii?Q?g5GyAFwfVii3A/eWLiwO5+QaOVZj1XlZ814GABkUwF3WAckZX1ZzJcI13ejy?=
 =?us-ascii?Q?3V+6/ebWPIrCV3xKB9b1u2BCEp9XrESX02qbFMkLO2FJQDsJQ9x6hFBWLYiS?=
 =?us-ascii?Q?YmraOA09SImUcjHhn7Mh82Ei8SCk6q66m9kICrtlviKIc5hYbLF0Xl/XWnye?=
 =?us-ascii?Q?/WpWKIShmsk3clb5scBpZX9v7tcy1rP1tYyI75AouPRaCZ6b1Az0GkI9oua3?=
 =?us-ascii?Q?s9l8BG/TWp3okFnbOEBkiNwjnw3QjzIlGEufOM2ZXBC6FCK+K5uu4i2atTRk?=
 =?us-ascii?Q?NOnEDwHR/XvUJjN77Jd1R7ViPo/4OhBT3AdAa3iWrYpyaKNlz4o8vUDO5XYA?=
 =?us-ascii?Q?XqEf0mklXxfV5rxVDSo9nkyvIqjEWxjzwSuuF9dIgoscaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qz2v4V17g3d6RRhplZnyOUlX93tIew40YdAJAdMQblwEZ4GeT+7FZRve6W+z?=
 =?us-ascii?Q?DtIKALIEq9QbUI4yi915Ge+q28GsH0Ps/bdUV3Lw4C3FuV2stKK/bC/EgEPr?=
 =?us-ascii?Q?FmLq/0Gt6vBD6ZVf6QgsNF+pB+lZpURX4ivpZ4wcwOXj5GJrBgzpdL51wdv6?=
 =?us-ascii?Q?Kz8fzE5XWqRs56THwyNwrhFXk7zMxY/FkBaY6QZcW2pcM9iQsKa0jqt0Ko9I?=
 =?us-ascii?Q?4HMYu/iWJ9Ot+YJze63YNFvKniZiSFhIUq4pU6o23VViemQMVj+xUIclhloY?=
 =?us-ascii?Q?J7H3FIp5tOlMSzXDHRVze3OUnzAl7bhg4yJtVAb7nCNZWd6kaz1z9CaJXDTv?=
 =?us-ascii?Q?q+py7O7KK4SEZw1hj4Zdj7WECVlO74qml3mQqITVluUXiZK2lt6W07GZBGJh?=
 =?us-ascii?Q?4v3/aWHrt/kIpQHhWw7850KPVbm1syBIsrkzwhGtB0CgWeCnkZ0c3SmgvWvZ?=
 =?us-ascii?Q?KGpLVWtboPGb9haUY9H+xPo1wNYt3URcFabcY4tRC5QrSy/XZ6TIhQTGfmvs?=
 =?us-ascii?Q?hhr1j/XaepbSVKyWlsSpte1Ju0y7ERhqxp0t/7kvMZc41LfJIft6N4JDvJvn?=
 =?us-ascii?Q?8odIv3RfvsnPMkUnk1/D5tgbGffx9mcVonBezECOiJ0xGiZnqIdzaos09pQA?=
 =?us-ascii?Q?/wU8gDn6hWk36m3Q0BlqCwjTQkqUFuAk4cBkX5TpBBj8CQ5Y7fRUD2JQX+qN?=
 =?us-ascii?Q?NHj4BMe61VzVP+5SPVQjf/tGLHqWnKLGSkOwGYZh5SEFT37eufB9VfHdlpXz?=
 =?us-ascii?Q?8s/hdAghCFeV+5m0Jp3W5SjgqehKAwb5g0Ot8otaM0VHucQ0mtFd6NFcDcjf?=
 =?us-ascii?Q?pcfOpX3FoKRx/Q3+a+UTTlIc06xeZnKsLEG0R+m/EdHcQYvs5KaO9C1MTgcH?=
 =?us-ascii?Q?ifUHp+Wnxs17mT1xL2Aw/pLFkjfA6NVNA1h3m7oWQXzBXJoR4j9sIPdwPitE?=
 =?us-ascii?Q?fK5+s0rISSVJsCiqyKi6bjPtbEzcvo+qQiSB5locRcyGcLe7WP+zAJ4eUK6j?=
 =?us-ascii?Q?I0QvjiC0hilFpBmdiu/4yqWmioTeE3aF5zwOsQ4eafpUWUjBBGjcOsDflWTH?=
 =?us-ascii?Q?9zJeGdjSMpW8SRcmeOg9lTblXre+44gy2BudBF2c7vf0qbdi0F/DZ5btXhXY?=
 =?us-ascii?Q?dKwuT7/B3c8dXEnhbW+vQn74JmzqwVU2p+7/4lGPeOTGy7jHrxtSByne0mWY?=
 =?us-ascii?Q?Jz9x3L0s93xYQNKJYk9WocOww/vOHgpaswTdRhoFQQKBM1BL3Q6fcZ++wG3v?=
 =?us-ascii?Q?SG+xWf6E9/yDAAhOwwGvxFu1g9fKEVnrRYcjGaj6kP5U76nhQg5iiBXpTFI+?=
 =?us-ascii?Q?Wgoq9xWhjgfXrZ8kiVwTkVH97NPPQuLZCvvIppPZnAaDbkaWMpAYv0KFgyFI?=
 =?us-ascii?Q?lYzVV5Kh6Gtr27mRZrrA4iPFggltV0qNd/4ZcNDOLMmPMGsoRqZ7l/m9beL7?=
 =?us-ascii?Q?ylU9/Nr8ovDbYYBHTTQdADuCeTg3GGNZOuHBE65wCTyVidttujc2x52B/G19?=
 =?us-ascii?Q?K2OQWEWVDVs3ZK809aD/gAAkJ6i78Z4wbKApv5OUhclDAvyAxc7jsWPHdwmR?=
 =?us-ascii?Q?NZIpkLKtEZdg3gpeSlM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e25f446-394e-4987-d5a0-08dce6e80c4c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:52:29.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcGB1O9Wh26L3SsNPGskyi9y0cMVUpNcqrJlf4L06oRNyvpgjAXff8DKrHYDmc3EaLwAZDoF+NX0ychmGKOwrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10886

On Mon, Oct 07, 2024 at 06:06:45PM +0300, Andy Shevchenko wrote:
> Replace dma_request_slave_channel() by dma_request_chan() as suggested
> since the former is deprecated.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/imx-sdma.c    | 5 ++---
>  include/linux/dmaengine.h | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 72299a08af44..3a769934c984 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1459,9 +1459,8 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
>  	 * dmatest, thus create 'struct imx_dma_data mem_data' for this case.
>  	 * Please note in any other slave case, you have to setup chan->private
>  	 * with 'struct imx_dma_data' in your own filter function if you want to
> -	 * request dma channel by dma_request_channel() rather than
> -	 * dma_request_slave_channel(). Othwise, 'MEMCPY in case?' will appear
> -	 * to warn you to correct your filter function.
> +	 * request DMA channel by dma_request_channel(), otherwise, 'MEMCPY in
> +	 * case?' will appear to warn you to correct your filter function.

It just change comments, why combined with dmaengine.h change.

Frank

>  	 */
>  	if (!data) {
>  		dev_dbg(sdmac->sdma->dev, "MEMCPY in case?\n");
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b137fdb56093..b4e6de892d34 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1632,8 +1632,8 @@ static inline struct dma_chan
>  {
>  	struct dma_chan *chan;
>
> -	chan = dma_request_slave_channel(dev, name);
> -	if (chan)
> +	chan = dma_request_chan(dev, name);
> +	if (!IS_ERR(chan))
>  		return chan;
>
>  	if (!fn || !fn_param)
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

