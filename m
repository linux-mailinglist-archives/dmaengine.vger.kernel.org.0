Return-Path: <dmaengine+bounces-2021-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65F78C28E3
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFB41C21861
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD6F10957;
	Fri, 10 May 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p0GS1mge"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498E17548;
	Fri, 10 May 2024 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359440; cv=fail; b=CfScFHyBfD0mfcN42VOfyXWXtl5usIr/P7TFeS78xRlxT+GABVJ9yzGsmfCGo6F28btYp9EACUk1rWymkleOJ8/3Y/H6Qtx1eAWYnvD0LBI49Hn4KFhw8z+Hd3NakoSnBxTJf6I+7OSDGQDpuVomiYH5t4meCX/e7j21l8vcmVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359440; c=relaxed/simple;
	bh=z+IEFUF2aKiVswt2ANGzFRyvm+tgEzsqW7Xy0uqm8GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fkZjF95oslEbUPtLHf2CJHqa0Gwu2QCKJO2PNGiIgaaCliGcSpn1hqTrNty8BzW+gKUMeFVz9oePzMK0vEFWWA5kjv+TGFtunwQOqhm2XVjLM056QMxhhahy1hWhLZtWAh4ceWpS32I7j+6XXCdNgDQX1zWt1z5WVoDq/oqSO+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p0GS1mge; arc=fail smtp.client-ip=40.107.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0p9033HqthXy2WAXtI3GNv9yOaZijcFAG9Azr5hUbG8pKeunDPSSMP3AnlQsu1iw8htcmMI/oBl/s+ECnstY7gr0uMLqYkl6uRq6Wl3H3mGlwqOawN9dmwWD4THv+r/Fd8VQt16CQy5xYlwRflG1Fq2nYcUvV3tWbcOcZ0RtBAm7pqc/Ko1YX7KrI/T3sXjTcBwP04DCd3dtgJvQcaj7NqgCZtLLqvABZoItJmyraGgYflMZFs01cPklS5n0d1YDDfryoQz7OYNUkAvYkRIDYpdjfvcFEQlcB6owmjuYkexRpVXf+eu5RH3ZpwVw+fA5EUs+ZM/XjGHv2O08UeXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79z3qksK+Bhac0FXPDlElPI0BPuWCPhTaDhlcdu8UVI=;
 b=KYYKz1nyO4rzX0MgwaCfqFcyShN9aHm+NRyYzKBf4DVETUAruqKWo1HcD+NBBg5HjEf9duXsUYhjlgfPbP88jdTrUu7wv2M+vfCtcXwbr6W52QSrQpmfO3IPCCCx62dPmJSQV79PwrYUDtSW4irHLTb/LIjDcoj9EdHbdxHWx0/dz8mxAh0QA9ujDjMdC4gbthPv+cxykFB40cOHGwjFdBUfqFv+TU/vTayEy2F3heWcnoY9BbYwNNv1e3dVfI++85G5kZnRIkUeXXhsUtm81VJxwLLked5wl3J+T+j4o24uFw4unqMEQWrcLXgkflSxQO8VtpzQznNNKK48QzbqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79z3qksK+Bhac0FXPDlElPI0BPuWCPhTaDhlcdu8UVI=;
 b=p0GS1mge5v44buAx+t7Y2f13PrSx3qP+yzzbroG94IyaNvKLa6oY8Mun5MaNYryCfPDRPhNEL9i656X6eALYIBzVqwR3Tn9SEt8PmQGAL6qnsaYsR/jX31Yn2rv0hvXxGAN4G7+osh6frCyjTu/KRgurnVboOpcRNc3NhMF9IQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 16:43:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 16:43:55 +0000
Date: Fri, 10 May 2024 12:43:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: change the memory access from local
 into remote mode in i.MX 8QM
Message-ID: <Zj5OxCXiSt5Np3sm@lizhi-Precision-Tower-5810>
References: <20240510030959.703663-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510030959.703663-1-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ca4663-4565-4a61-70e5-08dc711061d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dSFjU8Z9noCkG5m/EPbS8FEN7ce2bgi6jc5Rl+JqWluqMQ+g/219vfT9eNsY?=
 =?us-ascii?Q?MLk9aGWSHVBjuxikZpqtJB/U0AmnOonm87CdxoVtRs/VfyBTrxkhLxg/8n55?=
 =?us-ascii?Q?S4E8tMOBRqbksmbf9zg2k+VPCI9+x30sxw8kYSWvVOmCgDoSK0qaQ52hGdqa?=
 =?us-ascii?Q?5k51ork29xOWZJDyDe81rXV4DA/GlsT9U6f5dJRO4YJkDRmKt/BkcZ2dogNI?=
 =?us-ascii?Q?LoWXodA4ya+1BvEmGqoG7nTL8PlJ49QHr4EIdATBAbV7Gcm/9p1SF9ZwsVQu?=
 =?us-ascii?Q?S7ae49lYOdYAANK1RMFVQFtkc5l5snPgM9nSuI7O7WmQVZOiM7Crfv8KUjlz?=
 =?us-ascii?Q?O7oHKTSgC9NDd84X9E535hmpEnRwroDze84mdYi/NBAztWXzJCGe+3SeG2DN?=
 =?us-ascii?Q?fOBe+UJO/9gGb3WOTx52KV6xpIXv87q6dyd9Q2sQth1jiv01rKTZyREaQZQF?=
 =?us-ascii?Q?tVHygcbLmbwVWs4W0Rn2cm+AgOs6IOokjbzLn8+Y4oHTJroFy5N6al9Ose/C?=
 =?us-ascii?Q?8bD+B+cvQy+3xikd/Hpw25wqcQxJh5T7CVUdRMAaZBGf6zjd5y5EZob9iOrU?=
 =?us-ascii?Q?qRE7nie/Ycedh7naLQ0K6JEYIwCr6rD7HYBpmbJ7wDzzQuixhY99OqorXzvC?=
 =?us-ascii?Q?lPtu9KE7Sug4L8LYjxm8tGH083GyAq+CMwPASoLNTLmJxSmyoYNkd/fLpAIu?=
 =?us-ascii?Q?Bt9oomM5FG7rSecYoAoLsNh3eIh6pwHL/gi+6W+shpx965iWpQZBGP1VtNHe?=
 =?us-ascii?Q?MOm6lWD7L3EpDfQ3Sm1XSWUhwkEYnjIUdlvONljmULFPQgMkREEwBK9H7vNQ?=
 =?us-ascii?Q?2KYV7UyvxByZ04xSnDzT4ks8Jrsda0WTF3dKhEkxmHsQJGYfjvItVkkWrHl5?=
 =?us-ascii?Q?peHw+0+9YyaNLf2tx1uVKe0UdtY3FfjJ0F+ChFybPo1ThpLFoG7ILwbFfeQN?=
 =?us-ascii?Q?DxX5RICA1TWYjJqB4bBkRwpRFjbIqbuDDhuG41b4+20dVFe2bnuFBBlSZ4to?=
 =?us-ascii?Q?5haAvanVpAMfdf/1co9LUuRgklJJiKtK4rfh7vOj9105c72/3ElkxUwZ+MwU?=
 =?us-ascii?Q?eB7ykNf8iJS64hytwFL+kMQc/2tTC6b00OvQ5G8ovrvwGmy3yZdSUP4Q6Tfl?=
 =?us-ascii?Q?hFOdznIhDQJ34WsFaXc9jEx42df1qMNHgka4kcyU+M0pE0fOQFQ0thmNfrYC?=
 =?us-ascii?Q?4hJzTzaA/kyJ9jnf8J5bxAH8/XQIOS+Sntpt8MmLRR3LXWFqhAUjxgIVte9f?=
 =?us-ascii?Q?WzCXuECXHn6hiK2JfD+pvE0zqOa/rdRCKbe/CRFtJ5wz8OyiWz6WLety2sBB?=
 =?us-ascii?Q?WutHaq1Wdi0kVs/62JtewKgn/Yvulu1qPOpZG0vq8ExSqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yC8ACWoftx+q+DFQOuxCSCRVqCB85/N7KStKl7hvDaUrZzzFy/jqCisOcjaS?=
 =?us-ascii?Q?1ADxVwroJeaqOb3ojzrmRwwMKCGwdB/UgETBlNjly0JxcJO+n0Gxl/typBoI?=
 =?us-ascii?Q?CK1+0IZCf7AehkuaPeyRJ3EzGB9XL9isT5PvERDCHAZZCBYQDP/9Uc1wOyr2?=
 =?us-ascii?Q?lVcs4hL+JTngT9s03mLAIWFoB+VBWxrO09ZcdE3pd/TWWYOhkD5FBZjNBAn/?=
 =?us-ascii?Q?ee7Lia5Lny4CXeRERGeETUCnSYSCvzOwI2HQ+KqZvUIp+nA0Z99Hj+ow+BDf?=
 =?us-ascii?Q?2xOC4Rc4vT3PiDqguj9uPjYDHItU7+muroVwnt59c8Gim/uIHUwslZFBaOGz?=
 =?us-ascii?Q?wiP8MmRXkTslEIUOo3b7sIrYYt0XG9kJDQC70irnG31jk2kdUTcv4f9o9kQA?=
 =?us-ascii?Q?qZJ1L2udaIK1QdYw5YJgzigd2XW5PPGXjr4kPLcEA3WNeJMxb2wqXFaCEUWp?=
 =?us-ascii?Q?hdBLWQpmSehACiaC+sEYS6pVAiF+DMQJsBrKrGg/bfYLCNXuJMjDzKxUjpIh?=
 =?us-ascii?Q?0g6kHFePpAQ1TJCy01Adh8RCb9Ar9dPIISURcJOzeFhwG+Rw/fBuiIrEnz7F?=
 =?us-ascii?Q?rtWrascS9U6wtom6j6HFAgAEmNi0gQvA4zg+OUwik0VIswMU+NvigQPEobnq?=
 =?us-ascii?Q?XD4mvzyhmpAV5QThDrGH7chCUFjU4Y/qZ4ZFo5sbYFIGrENtIYR7aEZjsIBX?=
 =?us-ascii?Q?e3BUQ0Zt/p6wHp65r9aN+oGXxEVBqcA9WpXf7T3AURJbXofdvvo5AKIchYA1?=
 =?us-ascii?Q?t8TIAcRuMFnkgterYlI5CDWxXHhhEFAJnpkQIEVgkC1oNC8CiolwC6WGp0DS?=
 =?us-ascii?Q?UllQ7QJ7p6MSHlR9iK2Wr7okgUqaXQ6CxC6nTBRi1rFS9WbU3usQlQVVF6EF?=
 =?us-ascii?Q?saFAg86fkJmziPqQIh3Dwns8XIR3l7CedTv/tMMRfAokA8buC87g/orJno0L?=
 =?us-ascii?Q?ThG3S3Nhx90+RcSZxzM5hpLG6WaXg8/8zw2QqKpqplqM5tJrdS+Foug8XVd7?=
 =?us-ascii?Q?TCiQsJTKQkXjEZeL9FWKQZhpPJvIWJgmYDt//uYp5DVry+ogX+mnww9fIPAO?=
 =?us-ascii?Q?XjVPXQWAja5PEbQla8MN/Suyy+l/xmM/jnbyfPslATjwjAcp2N+4WCJBF8TT?=
 =?us-ascii?Q?PNXybd4FQQX0bvz+KNYpMbVH1QG7Zj2T4AAo4h2YYWjdCGRwQ6qz3EyWBPkw?=
 =?us-ascii?Q?e2g/4a1savOUJTBaUIYzFhON99NS1NFv0qUocBYwjJVBZ29YptXOFWf4zHAG?=
 =?us-ascii?Q?ZG4Szs0pFRpDbnIgO7I6LvMVn98a/t/SxAUYozsgDKx98q+karr9GyB4FMfA?=
 =?us-ascii?Q?MYCDJw/Qj9hBzGhE480OG2YycaQVNTkRKdwlnJd7AY6nf4XmRaUQRwJ3XPVa?=
 =?us-ascii?Q?oPRpA09mLPjGgUZA7y6v7/DlteklxPif1I4GRSV+3IJeh8tQnfGreqx4TOw3?=
 =?us-ascii?Q?puViUMhzbHPxo34NNSxsWg0SaXL80JSFLWVeg3dEbnTn4Uvqn9i/pr4JSoGX?=
 =?us-ascii?Q?niihWws8FuP4W2P5BCNAf3nRLiqh6j3Ho9i2ePMsV6V7PCaw/6csVZV/scds?=
 =?us-ascii?Q?ReiKmNZ3cPZbuiSJsyQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ca4663-4565-4a61-70e5-08dc711061d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 16:43:55.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npCP4z6l5PPiv3pseXqZowF8AFnDP1b//gQqtk8M1Pc2rOSxbSASjdCSw6PWoDYYJyFmWGkYXfboK0UvVk5Gbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806

On Fri, May 10, 2024 at 11:09:34AM +0800, Joy Zou wrote:
> Fix the issue where MEM_TO_MEM fail on i.MX8QM due to the requirement
> that both source and destination addresses need pass through the IOMMU.
> Typically, peripheral FIFO addresses bypass the IOMMU, necessitating
> only one of the source or destination to go through it.
> 
> Set "is_remote" to true to ensure both source and destination
> addresses pass through the IOMMU.
> 
> iMX8 Spec define "Local" and "Remote" bus as below.
> Local bus: bypass IOMMU to directly access other peripheral register,
> such as FIFO.
> Remote bus: go through IOMMU to access system memory.
> 
> The test fail log as follow:
> [ 66.268506] dmatest: dma0chan0-copy0: result #1: 'test timed out' with src_off=0x100 dst_off=0x80 len=0x3ec0 (0)
> [ 66.278785] dmatest: dma0chan0-copy0: summary 1 tests, 1 failures 0.32 iops 4 KB/s (0)
> 
> Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Cc: stable@vger.kernel.org
> ---
>  drivers/dma/fsl-edma-common.c | 3 +++
>  drivers/dma/fsl-edma-common.h | 1 +
>  drivers/dma/fsl-edma-main.c   | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index d62f5f452a43..7accee488856 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -756,6 +756,8 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
>  	fsl_desc->iscyclic = false;
>  
>  	fsl_chan->is_sw = true;
> +	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_MEM_REMOTE)
> +		fsl_chan->is_remote = true;
>  
>  	/* To match with copy_align and max_seg_size so 1 tcd is enough */
>  	fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
> @@ -835,6 +837,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	fsl_chan->tcd_pool = NULL;
>  	fsl_chan->is_sw = false;
>  	fsl_chan->srcid = 0;
> +	fsl_chan->is_remote = false;
>  	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
>  		clk_disable_unprepare(fsl_chan->clk);
>  }
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 3f93ebb890b3..cc15c1a145eb 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -194,6 +194,7 @@ struct fsl_edma_desc {
>  #define FSL_EDMA_DRV_HAS_PD		BIT(5)
>  #define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
>  #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
> +#define FSL_EDMA_DRV_MEM_REMOTE		BIT(8)
>  /* control and status register is in tcd address space, edma3 reg layout */
>  #define FSL_EDMA_DRV_SPLIT_REG		BIT(9)
>  #define FSL_EDMA_DRV_BUS_8BYTE		BIT(10)
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 391e4f13dfeb..43d84cfefbe2 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -342,7 +342,7 @@ static struct fsl_edma_drvdata imx7ulp_data = {
>  };
>  
>  static struct fsl_edma_drvdata imx8qm_data = {
> -	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3,
> +	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MEM_REMOTE,
>  	.chreg_space_sz = 0x10000,
>  	.chreg_off = 0x10000,
>  	.setup_irq = fsl_edma3_irq_init,
> -- 
> 2.37.1
> 

