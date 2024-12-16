Return-Path: <dmaengine+bounces-3987-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6026C9F35AD
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 17:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6F01654FD
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E54205E31;
	Mon, 16 Dec 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XnWBkSSo"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3E6205ACE;
	Mon, 16 Dec 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365809; cv=fail; b=OjH4U6i5R/Wex3EX323CiMOv41vu40ZPnxasRt51QT2J5VZCOa/+s1flmf7ytvUL+ALbysBEPRlgDbbqFwpZxCpJdD0u02GhulA/MBasj3qMotStSTprHNUrKqF2R0gXEFdITMs1jupZIQwdBZR1+OlavQWNI1kOwUm/zscQdRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365809; c=relaxed/simple;
	bh=ihVgW4bP2WOnqwGpl63/x0F89+vB0otnN3QIOGsdww4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ck7pdG0oQXemEyUJ2ugVxu7KcIHf/IgfDQYuY9oM1PiltAjXh1m+oTIB0jyt0IhHCjad4WBQ1iEzc+TAjIRUDZwOlKPx5wq/kdSs6ZNPAeaWRdcEsXj002hYtD8XV3sVWWvrJzs9HYXk9PTbuvyLkO64bEmJwCfFMbWaFyAEG7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XnWBkSSo; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8cPnPXw7oZ+QeHP7e0rhOWAVDYfmDKfASV3KJc8gVLxfNkWCbn5j+Uu/nCJDCz2n24H6QSMLuJzP151X3zdhKr04FFrTL8mxxnxk8ngQi8wTIvLUGOgVk76uwgg8zj+P0FRXh4nocyIYYe+n79oLF1doE5rl6pAnyTgthKiSOyPSt8Z7MlE1E5YO9LDKyru891ZieWOYjMa5+yBKVh00Acm7g8ncOxoM3SJMczyVrpmLxozkIhQSpCSD6y2zmFYJJpccRYEdTu4uVMj/VQ+hPkRoUyFQpEdLmFbInPCxfrRgnO8q8MPGjt4HU/JL7P5gpSGpc/afHE+pYqVG4e6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w07cYxqC7+SYLJBBWHbNGc/B/lF3gsTKiYVJcICgAY=;
 b=DQFQXm5X48TUkG5aKAs9SKM9alkO8xCkVt10lkYlGsii27+BMlXZeN8E+ujrulbtIzVz2YP/BCDhkBOk3A09XZpx+o97oe/WHOk0c/ULi5lnwo5L+pQ+aF2gq8KDUSI/F5NGtnfcDnblL1dYriIewKGE6boPjbWo78LHqMYNKRqjrm3a0hXCISNBkaFDJjjsgKE4EGF6Lt3QeI+lyn63Z0Djz8/P5WsJrigB9Wef5TLiMv004RuptSMudglW+NosST9Yf5CTi8a1S0NBS7dR44QiBnTgMQKMvChZZOHV8HoFDfc17TgMHIrjNUy+zVx/KI5L5pdSMJo1Lmm/JcjP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w07cYxqC7+SYLJBBWHbNGc/B/lF3gsTKiYVJcICgAY=;
 b=XnWBkSSo/2MZkug6bQJxC8KIp3h7/fzs8MgoIe+0rpSJtw0pm9AKLop6q11EG6IDF2kDWC5c0ccPMgHG016Cc4lCRMoO83k0x0EbGFWMrmLidFRrxBv4XIaPoVJTXFVYvNtJ3Ojv9uCFztutRnfIBD32b1tkCKSrxCfeZgXjasRxaKs+5kquOUlaYT9fsfEzrphnhjNTBTyOqL91z5LAdcaFeb4bmYKJbBGFvHA/DJhgy536Kko878pqNyqsGaPr7PUvdQhr0daXFpt+xaIvCmkrAiZL0E4gfWOmbMhfsVJgK0+Kdy3ikTU32ZKSh61htls355lHK67B9DMarQULVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8529.eurprd04.prod.outlook.com (2603:10a6:20b:420::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:16:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:16:44 +0000
Date: Mon, 16 Dec 2024 11:16:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 1/8] dmaengine: fsl-edma: select of_dma_xlate based on
 the dmamuxs presence
Message-ID: <Z2BSYwDpo/CTByfZ@lizhi-Precision-Tower-5810>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-2-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216075819.2066772-2-larisa.grigore@oss.nxp.com>
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: f253f6eb-3c12-4ff8-75b5-08dd1ded0838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TXy/RI2B+bn6QQ3OVy/KG0FmvADM8HT8tkohClhjvReJ8BROKsqDide7yVNr?=
 =?us-ascii?Q?2zZUjMkIJC5vMfc22YFHFwrUAeWTr4jK0Yswi/J439Wjb2cU7WGmef0g8rLi?=
 =?us-ascii?Q?dDzrf9GgU+AzyQk96ZnXHyAZVe2CqASi2hwX11UNfuhNsj9NCM2ESee40/F2?=
 =?us-ascii?Q?Lb3kxd9yzLnD1Nw5sKa9/jMN9eqfTy12DAjooDF24APMzRyk6BBWuy+3krpu?=
 =?us-ascii?Q?SpHjPu6CycQMti2zyPhmcvF7346zIcGDPn/94bQTvI1TNfJtP9Qys+nAuYGs?=
 =?us-ascii?Q?3fjgUJejqEf79HAgaFw2fF+6VW1FO0412yXG+tf/iLzDkRgulvtrOo2bW8Uq?=
 =?us-ascii?Q?qXpcrL4ArqPEGzBpQamHYfhIgsoC5OBlPdNHGpMy/WOvtwr6mO6hsl/jNkGM?=
 =?us-ascii?Q?63rglqzDxlEH+AXRrtQgeBThgfIVfhhFAKZk5l56R8cG6xedzkqnsIPXF+KM?=
 =?us-ascii?Q?PZzbzF5aNxr87Xb9i2HCJmTAXxwOBPqD1XI/X2s8xwQHBdB4aFJTEM4Z1Fnm?=
 =?us-ascii?Q?YEwVB+77vuRe1upQyZDHMRR6mqHT9dfT4G2zb6LWJRp2g23rTqsW4iJVDu+d?=
 =?us-ascii?Q?GhTTwX39+IP+KRX727XXElSmim/YxVglseZe9bZf+UuahBJzNzbqHtDWwgPE?=
 =?us-ascii?Q?GHjt84OUayoXWITX4hX8ujYeFuWbcfUNenxcv0ptLMI2mDymwtgCDuT5utYE?=
 =?us-ascii?Q?QK+RiUb1h2LkTPGZgelB2p17nW2y9qirkqEHzrae8vVWfPrlaAtp4RoLV94L?=
 =?us-ascii?Q?ovN9p4KWYFNvdyI53/RYTgI9eVP5FyvrTcNNniWbSwWoiuUM8IIEZU0IvcyC?=
 =?us-ascii?Q?88sleg+IDsw5nmMncl0PIoP+8NrR5HdXR7ETQJmXn4OHutk3B+O9mPmSetYj?=
 =?us-ascii?Q?06UONUkT32OALhDvgb0GLb0eGBrc4Kn6ROLqUZLJ79Ly63u8fO4ooNKirfQZ?=
 =?us-ascii?Q?Ycill43G6xNpH2UGAay6YG201vDJzRs9gb0kOew+5t9JWpf7rcU8WUmpv49a?=
 =?us-ascii?Q?fMa2nCKK2ljyDoMyAF00B/RIOQvKH1f31hf884y9HNSvixOzd6OwSkSyB+AR?=
 =?us-ascii?Q?Y/vo41Kf1wb88G/a1pLulsggmerQHuZY9v3DdMQV2kop+flk4yN/yN+cFm2k?=
 =?us-ascii?Q?/EQbui7FO4PVDZEEzcL1e4UCyvhbW5pKZmtTDbQ6htaTA6ZN/RT9ZRCO4Nr2?=
 =?us-ascii?Q?klnfsTUpowUs9lGN6LNyn0gWwzASK0+1n7tvVB9LPoXZg4E2ygegVVIp/VOm?=
 =?us-ascii?Q?ImHnG5C29/ge2bXuUcZ4ht3TOhonoQfSO9UEShEJ4O4xBLAO8lnlAFKJhfHp?=
 =?us-ascii?Q?R8y0bIqL2kj9Q16XFYKE/ToExHNy3OwYcoQAHKgGjTeV0uIWcuILERfdWoyY?=
 =?us-ascii?Q?mJa1xOLvCykH7KziUBNsMHKNNP2Bf1rzPRRY9eR0PEKG967z7jxirYRL29iY?=
 =?us-ascii?Q?qCmMNZYthPCeZ0suBxG3T5jvpaCrgGWe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CJ5o5LxP6c2XKsw4B0ZlYFbxuJ8t626O6EVziVqij9Ygh40/PiYRkEJKWg6Y?=
 =?us-ascii?Q?8pz7qtmEBqHDgl5BSvYuYohnJAD2QutIRMjL9y/YpPIBjSCABPKPwsWJwjBv?=
 =?us-ascii?Q?M9kYWdwGqPQqufRpB+74PrIRt5GecTZ1RG7Wj9So83CYsvxOKEPJ9amzwpGQ?=
 =?us-ascii?Q?EkZ6Qv+DrS+BuXJuoKNjxZwbLy9idCtNUSrgjpncPyy2hHcB/WZSBgZP6ycc?=
 =?us-ascii?Q?MddAwFlmHuWMfKTUn2zMQ+JL1FbwjSTADeXbWEDnRF1RMwDJGrsRGKFbTYPC?=
 =?us-ascii?Q?ryx/B2NZ2RAu3MNHP7C/7wV3wm0/++aREoO0rcRb/6ltD2ZpvMEc3k7C8o5Q?=
 =?us-ascii?Q?lOpinOBAJwYk/ZuDxdHZSGZ6z+ELVBTtIR9l8niC1aF/KVklu4zXmpaaexUv?=
 =?us-ascii?Q?XI6oaScw7Y4/xuZ3XO7WxxN1ds6VipsGZH2eH+2RpedWKtG0g+ZFQ/wLjqaW?=
 =?us-ascii?Q?dddwFJnKBbPS568LX96f6kIxMw4uBth4/cI/ti6WmNf8dIk0GFno2D5Y9/oJ?=
 =?us-ascii?Q?VdF+MMGEkCvxRe5icP2b2gKSnebElxjE/Uz8eR8QWmuJoZZxF/ViR4btSHte?=
 =?us-ascii?Q?PmWSbzp8JffUCRqAxEfQMnQP4FXNhQFtzjxhmT92bNxNfxAKJT7e4fyRyZy5?=
 =?us-ascii?Q?qkLPA03Ec+4M/WlQMhg8cKw1+E8WaQmWfe5ejxYEI1EE88yDbarzeYg8OkFW?=
 =?us-ascii?Q?HGqbGqvqxEfY8hLD1x0SPbZSvjWeU+4MxWyxWJjCNcFEmZPV+5rKai4tTzHt?=
 =?us-ascii?Q?AUIxdjTDzpIpYvIbk3Cbk/WqoJ7RvU42W6dp9Lc8jdwDE46G9jeYDo54TJS3?=
 =?us-ascii?Q?eyxC71GxOfOGsNLoGVDxgnAlFJnF2IkyE8NKcr8YE9xQndxdnypjzDdhAlgH?=
 =?us-ascii?Q?mP8+R2WnejrXe2+J77ltWkqPs0LhXyCyRuqVUtM8fn5hR5mer9an03h4V8Pe?=
 =?us-ascii?Q?zqW8JvpUzXZw3+ZgVqpzaOBWirVqpFjDh4AvZ+xAF5fM+QBgDIdoRP5lK4gM?=
 =?us-ascii?Q?E7Jy4lvBmiOz839B1MeL9NJTQSp0hmzfjjJ7XWmJuMN+NTj1cg4UQaYyP45S?=
 =?us-ascii?Q?Txi7q749VrSt+I6D2EeDobWaaM4CTJOhSIfyY4vSU2LDn9hPdPS6vzCADGFt?=
 =?us-ascii?Q?0sBjzVIIpkGJTnQgbtGkUdbO+lKhglmzuWsJqeXYJaNdRIK6f+6MN+h6bdOr?=
 =?us-ascii?Q?La4BPCzZDZg5mr7+bzx+nNby9qg97MfmA04zOJaad7kB0D3epl1PVPpQWxjC?=
 =?us-ascii?Q?c/Ily3o8nh4EjsIgYB+YFUMo5Cw9gSBd+exT01SSu0BVF+Zvk4Z2lJylvIjk?=
 =?us-ascii?Q?uMlWQ/OGjQ7AbDwovhkUTao+csAAHAL1JxpGaXOwz56mYl39HFz2tlV1zG9P?=
 =?us-ascii?Q?Ax4zKv+n3V6YG/J1Uhlscoi26CKLw6qo5aByzJwD5pL+RHaLQ18g7yjXW0/S?=
 =?us-ascii?Q?i+NnhVk87sYHTl/XISj/vJRG1N/OuZJ1tnWGAjYB7mWheaiKNq4zhv0ZL3ec?=
 =?us-ascii?Q?dmyGs2Q1ai9hFKTfXnycc2ylyTEfGWmfAu3Wrlav0n+DgnXK73ofHewzviON?=
 =?us-ascii?Q?RiP8Yyp1xqetsa6ZEcmSoT5HqelqIGq93UXTD+nw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f253f6eb-3c12-4ff8-75b5-08dd1ded0838
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:16:44.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKl9335mKeP5odp/u8Yqp74iIiJ6NankJYjjir4RVPsw0wLWjPMV27xDaC2k66LwnRkeVv0UAyvVm1nfnAM54Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8529

On Mon, Dec 16, 2024 at 09:58:11AM +0200, Larisa Grigore wrote:
> Select the of_dma_xlate function based on the dmamuxs definition rather
> than the FSL_EDMA_DRV_SPLIT_REG flag, which pertains to the eDMA3
> layout.

Nit: Add space line here. Need empty line between paragraphs

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> This change is a prerequisite for the S32G platforms, which integrate both
> eDMAv3 and DMAMUX.

Nit: the same here.

> Existing platforms with FSL_EDMA_DRV_SPLIT_REG will not be impacted, as
> they all have dmamuxs set to zero.
>
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> ---
>  dcrivers/dma/fsl-edma-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 60de1003193a..2a7d19f51287 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -646,7 +646,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	}
>
>  	ret = of_dma_controller_register(np,
> -			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
> +a			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
>  			fsl_edma);
>  	if (ret) {
>  		dev_err(&pdev->dev,
> --
> 2.47.0
>

