Return-Path: <dmaengine+bounces-2504-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5113912862
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 16:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D44BB2B5D9
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68214AED1;
	Fri, 21 Jun 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UMV12UaU"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2047.outbound.protection.outlook.com [40.107.15.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9353433BE;
	Fri, 21 Jun 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981266; cv=fail; b=TUeG/0e7m/YSicU/vAfCZXZMVmCSg4s+ONDgA3+aW4vB9x2Nz41QBdUXGy0JC1qV8F0wMbR2nmFK6IPDnltmCC+8zyI5cMfc6WdD3M7KDHpPed4duZiBqsoj7Eqa0lzRxVQ+RdJYR1FLrLIZt9diCahGbJXbSLk+6YZ81mkSQEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981266; c=relaxed/simple;
	bh=cr6N4oL3lrEiUr6nqVtW/oRu5uKF/fyiS5D3ySq5cCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SgCmbzeUGfdfwAxL4F+/TI/ZuI6y2P+atcJvddthWtQ6Wdevp5vc0f4e/AWZih8xZZTNuWQxcZPXI21zwjDIEELYr5+VMswOQdFA6LyAcisaKFrd2iySlcQtA1cFOl+zo4M822NH2hkXAsCWQ7e/PiPbqr6tdWPqCey/TQPDmBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UMV12UaU; arc=fail smtp.client-ip=40.107.15.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aULrNpC/5KGtbyi2FsmK3hiYok9dul1ioMjh4kuVXOtR1+hUbYNHGS3mkAhXtqUDTOPr+FoUzNbcovcZ+2nxt8XhaXLcJNhCvJRP7Ek1y2//lrkovjAjnmgyVPaKvZbH73za3XfyIs7FOf5Yz1Hg/2FDZo+jo++fZBBAzUWCX390rKfFBTzU2mY3FGRBgl7L6dp9UtBJp9uD4mq374jYAGql85uhqjvG3OE0Avx5tSvpVpGqkSbQyybmvPJ13GShZRbRnnh/rgMWl//4PWhi01MY1osTNL5tN1oOKurENExeABC9sAGiJe+QYIcZ45etEtMJB0/1iyEmpppwyJs+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keYz67EklgGOmwWxZDs+bp+ZyOboFUNDO1ZeneaFJAs=;
 b=JynHyyyTj8/hkkGlb83xCwfFhKHYOUsQ48RGK4RbTfkNVwCUzJ9BxEanEAwBAKdaZcBb13mjLt0wota3ETVsykPaR8of+QMRwgw9pvGgnRxcwwOqSl8WCHbtANj8D2DFf5Gttl0gtwnUpkA0JMVxz3DPyb9E2YKhOyahR3jJyO5G7vwrsOEjK+cG7AQeXUFoh0DUKT4leANFQE/P+KbaPGgdT0HnCKo2bI7MUk8b0dDcDJbOgv2DEi/Mq87mXwQxEpWeDkMLKrkw1r7Id+oUV0k4tCcoSvAPOTN7SNPV0XQataK7p283KH4D06NEEdUcPrHVNxc1WhVAd/H+2aYdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keYz67EklgGOmwWxZDs+bp+ZyOboFUNDO1ZeneaFJAs=;
 b=UMV12UaUrRxkNJk5GcAa/FZIIh9qWcR8hdz/ReVB8pIH7OEMmOClrx0ma1zLCqPizDyX8FqSVraO3gvobjvpVgEx6VTfG0jlpOfqzDBFhBGsG/Ed75bqqkO8mgVcYOKb2G5xjNCJRGfa2fSfqe/ISVOmz/cdqO9yptoTxmK3s14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 14:47:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:47:41 +0000
Date: Fri, 21 Jun 2024 10:47:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dmaengine: fsl-edma: add edma src ID check at
 request channel
Message-ID: <ZnWShvUtMkDz24a2@lizhi-Precision-Tower-5810>
References: <20240621104932.4116137-1-joy.zou@nxp.com>
 <20240621104932.4116137-3-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621104932.4116137-3-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b99a4a7-b3ef-4deb-7692-08dc92011a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|52116011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5QvdcUTC0S8ybSTH2aktlgewTzzJUEfknGPtySi2ar7pQdXYbfSRqf14MXBg?=
 =?us-ascii?Q?NRugqJb257p2UPb5IQy/pN4qdSWTzHAwUm7rb/pqbRGv++Kiys9LQ7YSq2QW?=
 =?us-ascii?Q?M95QTAAKWyGi8Rx8Mw+m/ZqkYAXEyQ8E1IVUrMwWolRaGuxmruNmxHt2JniN?=
 =?us-ascii?Q?MZiYmM6ncYLSCR5LBNQTEa2Eriz7Og6/wduC8fE8PDCfTyRQIXZqeWqWJdw+?=
 =?us-ascii?Q?YXjxVKMyVBXdMOnNfxZbcWJW9APxAXR0bOUuqTa8viY15K9m1Bx8Tshywamo?=
 =?us-ascii?Q?UP++MPQzvKfhhuFLCJ+HoGIkEy8wKuwIyliaqB7nVs2zAjIF+7wqEha0WySd?=
 =?us-ascii?Q?YsJNObE9sUcHVETNp9MrcrkWPsjCEBLDtHoH1w7Nl2VdA1WuWna3RMOp/viy?=
 =?us-ascii?Q?ZMDFcKnXsblT8rdAJ/Kly+Ll5xNEup4kyZzVpLrzBI+rvHORUGuidFuoHs81?=
 =?us-ascii?Q?sRNMyiVWWV0wJX7fHDQ8ftlie7c+6OHVD3DCl3QIRQBM6Mku3Pw9fUrJCD8U?=
 =?us-ascii?Q?zFwoB8yo+O2FW9t9CHNSJFjWEKBQonNEfmJnKTjjivy9g6AUhfAWRozNJImC?=
 =?us-ascii?Q?WY7ZNFjR/0e3ROh774hfWK+FZeJ6SQwKGiYJCN56KdIKOphKjlUCp68Pl2/T?=
 =?us-ascii?Q?0zGK68pixAqOgZaqkGvRE9JBp0F3gRpbbx3XF1yyJPBgybVJmeiiMdZfqm9i?=
 =?us-ascii?Q?FPGij5q06DqH5EsV+qsTtU4BIUcx7ig7XsKuF4nSRE42cxda7K/Mii69UQ9O?=
 =?us-ascii?Q?wNdnIUFEDSPp1nBfHubfrc75HM4y2f52gYye347t+hxtfpVKeixnRh5AFoq0?=
 =?us-ascii?Q?NsQr2aZ9GdBKlugYfDhVx7wgETgitJBQ0kfbUZg4cGQRH65N5l9VJJhR+bjB?=
 =?us-ascii?Q?C300iyy41kDY24Q3kLYQqziwr7nrrYFe1YwsdX5w9SHc4rnkyUCrGhF9c6UF?=
 =?us-ascii?Q?Oy/TktyafIcgAFG8a00Hy6eC3EK9uvAXulfVEIwHeYlNoK0l2119eefTo8XL?=
 =?us-ascii?Q?cpMmAVhsX36Dv9RHp39tn5PXB2bwqpOHW4DW2768NIsEMlPecnJGaoC1eUlU?=
 =?us-ascii?Q?9aWMjVm3/emIw9DZdkUwXGRlwBeh07/f4RSLxwCokRCgVnPKuGAyiBFnv4iJ?=
 =?us-ascii?Q?0QlIv3NlNToEu/PAu4dOhV57bHFCcAkHDwgtWt9GL2lVhzH0ht1koIgVNVbm?=
 =?us-ascii?Q?0sw+iulPi6CTMvQGn8d9q3jY/LFSPQPJ7HmnO3e5bkJ/hus6E+hpXyA2DA0z?=
 =?us-ascii?Q?gZ60dIQOgH05W57nmIJ15hTC117uF9EckIg81n4ko8u7woBGmJuq6l4hqYGS?=
 =?us-ascii?Q?k8rDll1tVZgAVjSUojAUN3NEn0uk///iT3/D/oTS18cI+apkZGFVbIlGdmhZ?=
 =?us-ascii?Q?03sYqIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(52116011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hR/uv+pEdekbsBp92Gl2RUXsRJd+d7Za8BkmXlw38WaOdCIaagUA6Vsfr9SK?=
 =?us-ascii?Q?aE7fXWI47krFGdTBB4N9WuTUHd1Xz4iGrYlOHdLUieXfR1QW7CeuWuC81JVA?=
 =?us-ascii?Q?wUnVr9R/j750wd77vj5Msgh+19FmFsQQIUufw4O0c8j2H+avKIzhP6I2ppTE?=
 =?us-ascii?Q?0rDGsUt9+jDPdP0Rxtip1QqkDIOe4vShXSqwynUnLUbg4ixBZNXhs0ntIxuN?=
 =?us-ascii?Q?ZRZRYiqyCeJuB0By63kOk2pyRU8nBCa23w6ZiUvHVAj6P2RizhKgoCrQGzhd?=
 =?us-ascii?Q?yzToDB6lFAtDnPqbfoZRLG9CXjAHLzVNECVeImgo/eqnjU2T4//d/nG11CRi?=
 =?us-ascii?Q?hhsZnXb4K5RZqwPcfIa+aOOYCCuPzn8fJQ9GBQ0p+5O855HepXPVLBzAfk3n?=
 =?us-ascii?Q?F3i9rIBaeDVZD4AqWGM2rbNntsFJS/J4p8k5i0vxO13A2drc5F8zOnsf9niP?=
 =?us-ascii?Q?umbbHCf2F+W5eQF4Ue6hXnuHx1pOPajo7dmNhNDGJ6faPhiwwqBfXgMaxPxd?=
 =?us-ascii?Q?gJqA9fE8WVQcjaF3Ib8SmuRxyNPiX8guJcKsf2caAGqE/DqkEBxtD5yY76rT?=
 =?us-ascii?Q?4gLiXDDP19LQE5G44p0snnP40HTe5YLGOHwQDKOQllAcoSho+1juZpse6mo/?=
 =?us-ascii?Q?G6hc3ULzW7+/CsfP3yecHihEb8rGTW7JaciqcFSPeS+yCEpfxEed3NahjVg4?=
 =?us-ascii?Q?eHPwJ/0GMIAJyO48HGf86OTFA098f4HzF45JEGrx8qxyZQwAITjfDMIX44qV?=
 =?us-ascii?Q?tWrdVR0a3/MLCjwv4al/syPPBoJ9teVm33gE6965TLQBQE81iF+XVB+lmxY5?=
 =?us-ascii?Q?fRwQ59D61GOaz6kvyUG/+fw01zGw38TIvgmYAotjQ0wJ0OHgkTKnJAt9BY7a?=
 =?us-ascii?Q?HrBz7T6ExqaMYOvADXyhBFUYJnuMoPi+zWpr+2k/cu3S4ObvGx+4lInb19xM?=
 =?us-ascii?Q?2AnQBPcgqW2/ygL9vUdiB8Woeu18Ym43d6F4E7kayQztIHdEQrX321CB0mE0?=
 =?us-ascii?Q?T8+dPcWh8Zlk4kNeyRz4CQcDOBcv1sp+NRTzYy2xrwzegEfpNxnn9I/ETnyS?=
 =?us-ascii?Q?vGRrc8+9qL/0K66euIJb5Xif9KRwmlxi3B5EHuc+ZZL6m7YBI3PfsstS3pWL?=
 =?us-ascii?Q?pfLPoN6CuQO9qcbkJ0MS5gzWR0p4V9DlJBZjxzpKSnHxoANu0m0idy8EJnAO?=
 =?us-ascii?Q?GqDSF5HrxdJY3yIMmPk9pjHPUnyrfXGUUC9CynCNO6PM+SsEkP7HIbG3U4ob?=
 =?us-ascii?Q?U64BWwhBBhQm1oLnJyjKXUA9YWeHRpeWgoKujl6GftErDer9xr/diJPwcsVg?=
 =?us-ascii?Q?AOkolyIWi7cZCcz8KdRGONHwMSSE22JQkaPWNE9uUWThYmQ/ejRjjTtXvWXT?=
 =?us-ascii?Q?GY29mAtRSWKfSbrXPkb0G5eKfcAdbInxNMelveUV22JxClPjGnTfmFUGi1Lg?=
 =?us-ascii?Q?woYjeu2mAEjdMa0V34gnISIV2DAzCSni30F4sBNGDkAVQjsxd4VcJFMBmVlG?=
 =?us-ascii?Q?DQjlpsJZ3QxUJEvC8dlphwhPDeEWZ3B4MG5d4HUia13ROCH5xwYaxjnSTDjT?=
 =?us-ascii?Q?VrB9RiOrQn9L8DfQLHku97489l47+efNX0nEZdZK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b99a4a7-b3ef-4deb-7692-08dc92011a48
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:47:41.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Priqxu+Cn7LeSX0fXwpPkiou1dkEyW0gloCeFDF/qfmcYrF5iB/czKYNuOFq8xIlZplLntWQvAjYuXyzPejxgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8418

On Fri, Jun 21, 2024 at 06:49:32PM +0800, Joy Zou wrote:
> Check src ID to detect misuse of same src ID for multiple DMA channels.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/fsl-edma-main.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index d4f29ece69f5..47939d010e59 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -100,6 +100,22 @@ static irqreturn_t fsl_edma_irq_handler(int irq, void *dev_id)
>  	return fsl_edma_err_handler(irq, dev_id);
>  }
>  
> +static bool fsl_edma_srcid_in_use(struct fsl_edma_engine *fsl_edma, u32 srcid)
> +{
> +	struct fsl_edma_chan *fsl_chan;
> +	int i;
> +
> +	for (i = 0; i < fsl_edma->n_chans; i++) {
> +		fsl_chan = &fsl_edma->chans[i];
> +
> +		if (fsl_chan->srcid && srcid == fsl_chan->srcid) {
> +			dev_err(&fsl_chan->pdev->dev, "The srcid is using! Can't use repeatly.");
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
>  static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  		struct of_dma *ofdma)
>  {
> @@ -117,6 +133,10 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels, device_node) {
>  		if (chan->client_count)
>  			continue;
> +
> +		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[1]))
> +			return NULL;
> +
>  		if ((chan->chan_id / chans_per_mux) == dma_spec->args[0]) {
>  			chan = dma_get_slave_channel(chan);
>  			if (chan) {
> @@ -161,6 +181,8 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
>  			continue;
>  
>  		fsl_chan = to_fsl_edma_chan(chan);
> +		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[0]))
> +			return NULL;
>  		i = fsl_chan - fsl_edma->chans;
>  
>  		fsl_chan->priority = dma_spec->args[1];
> -- 
> 2.37.1
> 

