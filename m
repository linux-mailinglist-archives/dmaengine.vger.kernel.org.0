Return-Path: <dmaengine+bounces-1791-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C506B89E080
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 18:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7659B27D85
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5983E152DE2;
	Tue,  9 Apr 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FKDPqPhL"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2114.outbound.protection.outlook.com [40.107.247.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B144153574;
	Tue,  9 Apr 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680409; cv=fail; b=oHouwJZO5FOQxBFCRphiaEQWvV1JZe6Qmtv41z+p9hUEg49Z0dpRA5OMP8Ag729DAYN5JKx2Xci078ruVaxISx8FmtoG1n+grAboSiVxLbgpc2Q6FsDdoI+yybzxfoCXP1a3SrHUFX3vvjA1OwEHPtzBF8TNjmQDEpo2ehCfYzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680409; c=relaxed/simple;
	bh=+DGy293eFCvHj9+4FiFLcfW/Qclin+mL14N3SoySjPA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cX9Tx5zrq6McjWZXT//N/VX3NAlBmomOipuSvZt1zRZ5qd2wIMHYvGy9e44PE4/jPwfoCR1vbFN+ox1IYUxCS9tgjJ+9tZHjtXnc91KfxNlR5zLV9Jy8BevR4LsSz+/avNhxqKTabT+tmdai4THJspM23Qr1ZCSBLmNyK60F3i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FKDPqPhL; arc=fail smtp.client-ip=40.107.247.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ8ONTNva6x5wAvxXZ0wUc37sC9MVcNV7QiesVPbfr8RvtIfYHnJ5SW7mfOrEuDg8MPk8tEPvlkFRy449satKrYwY9y7JMaI5emZo9N6laqUUsLID32GtedxHfB8OsVv045v9BdYcD78Oboz4c2J2ug/SdgnHk5saEvPqXwQqnWxpIzHC+l2tLziis79WWXGaic9amOHOPvmt0yDOLC7xB1Wt8hdmFvr+VE3rbfm9YT1iMVejNfu0z+d6PnM81/0Q2HVrgYSDp7ToQZVSsoEb2pXzR5bZB9L+fmEjFydag6Ypnk5rSGSB6L5w+vhbxdv95VMfTypQgb/RDMJ7v/XZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jvzah8GaxOjZ917H033qp4JITq78fdk1w35WsCEr3aw=;
 b=cJBeBecWdePmjUH6iY9V8K+xY6KN0sYqGp60v/annb0l78D4LZGGte8zz2KKocNC/1of2V7FD5LOh7MLCd03tMfMeHjdeFNGfJr6rgzMj+ElKU+IGXqAB+9soLo/4/w3hpbw3mrQI1KatyBN+ge/PEKSe3yMqSyR7+ReTw3lllSOvglVOdGE6LjQdCsURvxzrAAuL2OT5c3JmFDmARCknP1k4u5uZu3w3q6oVVcDXYdAv62eAqPOvKlO8embRCFf/6Sz7dds57lh6lqYaXWiwzTsu5EBZTruFvuRTslPsb79d04gEv99rf7SiRx0xR+1NmfuyAaXV7vkrNrzpkmOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvzah8GaxOjZ917H033qp4JITq78fdk1w35WsCEr3aw=;
 b=FKDPqPhLBEKVoOd4Fq4r/l71ajArPxGRUTFRqYesGMFIZuLaNIhukMyut8G0NCizMnaVZOPKOfPcvx6h0PY3V7gnbtjKXNFOsW+nbJXxq14jjg3Fg5QqcFXefN2QSfFx5fZN0prV7gHi/milyC2d4foZUzHHi2vqF0sTHJOXUsw=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7054.eurprd04.prod.outlook.com (2603:10a6:800:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 16:33:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 16:33:24 +0000
Date: Tue, 9 Apr 2024 12:33:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dmaengine: fsl-edma: use _Generic to handle
 difference type
Message-ID: <ZhVtzWXNUv9ugeE1@lizhi-Precision-Tower-5810>
References: <20240209213606.367025-1-Frank.Li@nxp.com>
 <20240209213606.367025-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209213606.367025-2-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7054:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M+JbXHGFt18VPUUtlTb24qDgqA7rDy57f1TbzH4lGZnJ/eUniOdw1Rlr+etupheV3drpC3nwlSNtfTTk4clJjc2UJxIOq6bKH+sPL/83AsxefI3p/Ru0B5PYW4qMrLzBtXV4SvUBGaiBC/q0D1/u09vXohoa2aakdtw34vb2Ahnz6vzKilk+GOXM1Bn2Zav8nzha2h+srP5bqULuVnGEIQEDKBXSTkQhButIZQuiJwOUI4ALT8nclOJ6tsHCpXk0SHLhw53eGI/46lbg6/24vpVFoRYdCBiwt/vw3I989LcjHm7zlZCXhVtx/fgcy8qRZnnrUjNpULUXFP44xrSfGR2XAvGGfXF8mPrmACNYB4GtJDPU4UAb2Al+GDQqvWkz43ZKxkEahHwS9zDtdParfp7v/oNKETeYLIIpRWukUKtCcuYP84hl4hkimzBBD+12JZ6ii/rNLW38BBFN6O7pc0qQW1bswWPyfhp7eEh+2Bz5r4T/4xQbXvFA9JvWCPqGeIAF7nhsAVWZWBYBSswWNvPTroQWU28bp7/as1kIZ3hTR2szs4VxjlRFILavuLAeT2kIT8JuI88o+1J+Q4LWomYxfI+D6qvq/Uh24ztHfnroiFgfIfhDSh+XQg0oIt+JGuC2kVeUU62AX4tWoGybr9brfcnHBuSsgXIpdUoJYnL4PHSnwcqX2wqtsQ5y6yhw4wUuDv7zIlN1PqYBsmN0yvNvE6f7E0vp3OXpq5C+Wk0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjvwwCKrwLTbno7jHNVEmC2mX7vquyq0OE4CpeOfmZrhAgBf1X50e7Oucqy8?=
 =?us-ascii?Q?iwItX4Q/ZNIKHBl7b/SONuqynFl8s3/svtbhY0MaI+13UbbDB1xDcDK+nEkQ?=
 =?us-ascii?Q?VcfRJX/+uPUpRcxHAO0O8OnP143qPGHp/MDOPi5uIskSlC+ffyf+48sVyelI?=
 =?us-ascii?Q?6mIyN/XtLQCojow6Oo1PQif8igKXVDSk5B26p059pPBoGbC/XUnT/7KSxubE?=
 =?us-ascii?Q?7mo5k/cjOmU396ywYO8h9IwZV19b2IPww+8CqQQJ0uOWLGxgG7rAaDLh7+8y?=
 =?us-ascii?Q?ZjuTDXsJj7gK4YUbfA08S57f1B0FnWF9Bsn5p/CxoiljYQD40gcYfookRiVL?=
 =?us-ascii?Q?0DttvnO3EyDtCuzlr/w7d7YYsb63NokW4EsTKQ74VK3CWO95i5cUrIhx+Lxk?=
 =?us-ascii?Q?y/ZQadtgS0saNfib8mYUOqD5ZSpgTp8QvZNiLI7kA2QPyesqKMoBRjsyjQkB?=
 =?us-ascii?Q?Ss1cT4ry3AiNIkmO+7aG4mzA5qA2+uz64NYXhhBdmZsaZfHAsPIqKYc6wcLb?=
 =?us-ascii?Q?P9WreHWqHWE7FZK4hnj+Y0j5DQRwVy6P0ncb4HjkIIQ2GLF4Jn5opiFTTEPs?=
 =?us-ascii?Q?fIbKmUrxVArrJ+z5XG39PNkROtQWTZZcdpc6HIl50AZi92vZKQGXtCF6uQbP?=
 =?us-ascii?Q?OoQ4RZdTGhMEgIJuxGb6VKs83sxgd9V6gGhgw24NWmGrFtrU/m/ke1cQn7aW?=
 =?us-ascii?Q?BxCtZiH/ygxIe4pMdIj5c27kkvJR2RvZVDvTQNgsBUYvQhHLYkYgGd4lehgE?=
 =?us-ascii?Q?yrIQM1TTwCuN9FMo3Ayr2zfSIPPHwYqOT8y7bEFhLTS/+tr1tON0suCpX/BI?=
 =?us-ascii?Q?L78xwpGYJtezaiglSroEbYeuQC19ocPyGgEUo0lsjmRNgoZrWaib+xb2c10V?=
 =?us-ascii?Q?0iK2PC07BYK7iajvU/nCg0VMl//vbG0H8UZG2tQZt7KhHncPvnUtEGj1z6Za?=
 =?us-ascii?Q?TgzEINEOxBc38BXXsxUuDlJ+O6g86mKZXoMIL1z4fliYqsPmrGoVZOi8Bq4R?=
 =?us-ascii?Q?JNgjRdfBNWqeB7KOgJza7kxS6ZzX1TaK6hJXOMOEd36NbQP3Lgya/NSU6VnM?=
 =?us-ascii?Q?BJcix1ILSnYGrbFVCYd0MKyliAu1MP8BSqQhtzPPFa7Js5WELHHdNGz17A0R?=
 =?us-ascii?Q?oDPPMRQnUPdifmfetu5JlU8yndQXdNcxTUWBjGQPM7FdY01PDJvabIFijeho?=
 =?us-ascii?Q?VGG4MawEE4iqx6VX04W24hTRIVhf/x26300srG5ybFEcm6CfKYaOlccUC46V?=
 =?us-ascii?Q?OjAGZVh/xn8Z0rB43TPEpMJbLJE5Yf4JjYaeJhPi7GpRNWgVISl28fgVeCk1?=
 =?us-ascii?Q?25bxnyU/MJRCugdwA5pZZEAsnZgOwEWWAAjd3KjZ83lIhtQxCvJZGjPIQDA8?=
 =?us-ascii?Q?wxEbeNzjOvoU5vcbu8EFQ6FgfoTKpHOsd5CzuTnFnLq/43zBoZkqP/LUCD/J?=
 =?us-ascii?Q?F8MYqWV59Uzb3+/9BvE6zC7CooKzN3iIukMB/MEXWk8HTaIgzbQkyR+0kQad?=
 =?us-ascii?Q?zmxlz49TbvEwcN0ADVXoSXLI9cmtyZlACBJlWlq526oGhw0PnGx3CMap4+YH?=
 =?us-ascii?Q?MbvF0yD1rA1ATJ1IFqIsSjZD/X54qKyAkq/AaEtj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732a87c1-04ca-4217-0663-08dc58b2c6bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 16:33:24.3207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T45plnLdWTxYirtbMRZ3WepQRxF1EUvS51DNozv0fhLMnWUakHLP0zZP0Uw6Lid6VspdxmWe74lDktR6c8MyIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7054

On Fri, Feb 09, 2024 at 04:36:04PM -0500, Frank Li wrote:
> Introduce the use of C11 standard _Generic in the fsl-edma driver for
> handling different TCD field types. Improve code clarity and help
> compiler optimization.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Vinod:
	Do you have chance to check these two patches?

Frank

> 
> Notes:
>     Change from v1 to v2
>     - Fixed sparse build warnings
> 
>  drivers/dma/fsl-edma-common.h | 61 +++++++++++++----------------------
>  1 file changed, 22 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 365affd5b0764..cb3e0f00c80eb 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -255,12 +255,11 @@ static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
>  }
>  
>  #define edma_read_tcdreg_c(chan, _tcd,  __name)				\
> -(sizeof((_tcd)->__name) == sizeof(u64) ?				\
> -	edma_readq(chan->edma, &(_tcd)->__name) :			\
> -		((sizeof((_tcd)->__name) == sizeof(u32)) ?		\
> -			edma_readl(chan->edma, &(_tcd)->__name) :	\
> -			edma_readw(chan->edma, &(_tcd)->__name)		\
> -		))
> +_Generic(((_tcd)->__name),						\
> +	__iomem __le64 : edma_readq(chan->edma, &(_tcd)->__name),		\
> +	__iomem __le32 : edma_readl(chan->edma, &(_tcd)->__name),		\
> +	__iomem __le16 : edma_readw(chan->edma, &(_tcd)->__name)		\
> +	)
>  
>  #define edma_read_tcdreg(chan, __name)								\
>  ((fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64) ?						\
> @@ -268,23 +267,13 @@ static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
>  	edma_read_tcdreg_c(chan, ((struct fsl_edma_hw_tcd __iomem *)chan->tcd), __name)		\
>  )
>  
> -#define edma_write_tcdreg_c(chan, _tcd, _val, __name)				\
> -do {										\
> -	switch (sizeof(_tcd->__name)) {						\
> -	case sizeof(u64):							\
> -		edma_writeq(chan->edma, (u64 __force)_val, &_tcd->__name);	\
> -		break;								\
> -	case sizeof(u32):							\
> -		edma_writel(chan->edma, (u32 __force)_val, &_tcd->__name);	\
> -		break;								\
> -	case sizeof(u16):							\
> -		edma_writew(chan->edma, (u16 __force)_val, &_tcd->__name);	\
> -		break;								\
> -	case sizeof(u8):							\
> -		edma_writeb(chan->edma, (u8 __force)_val, &_tcd->__name);	\
> -		break;								\
> -	}									\
> -} while (0)
> +#define edma_write_tcdreg_c(chan, _tcd, _val, __name)					\
> +_Generic((_tcd->__name),								\
> +	__iomem __le64 : edma_writeq(chan->edma, (u64 __force)(_val), &_tcd->__name),	\
> +	__iomem __le32 : edma_writel(chan->edma, (u32 __force)(_val), &_tcd->__name),	\
> +	__iomem __le16 : edma_writew(chan->edma, (u16 __force)(_val), &_tcd->__name),	\
> +	__iomem u8 : edma_writeb(chan->edma, _val, &_tcd->__name)			\
> +	)
>  
>  #define edma_write_tcdreg(chan, val, __name)							   \
>  do {												   \
> @@ -325,9 +314,11 @@ do {	\
>  						 (((struct fsl_edma_hw_tcd *)_tcd)->_field))
>  
>  #define fsl_edma_le_to_cpu(x)						\
> -(sizeof(x) == sizeof(u64) ? le64_to_cpu((__force __le64)(x)) :		\
> -	(sizeof(x) == sizeof(u32) ? le32_to_cpu((__force __le32)(x)) :	\
> -				    le16_to_cpu((__force __le16)(x))))
> +_Generic((x),								\
> +	__le64 : le64_to_cpu((x)),					\
> +	__le32 : le32_to_cpu((x)),					\
> +	__le16 : le16_to_cpu((x))					\
> +)
>  
>  #define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)				\
>  (fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64 ?				\
> @@ -335,19 +326,11 @@ do {	\
>  	fsl_edma_le_to_cpu(((struct fsl_edma_hw_tcd *)_tcd)->_field))
>  
>  #define fsl_edma_set_tcd_to_le_c(_tcd, _val, _field)					\
> -do {											\
> -	switch (sizeof((_tcd)->_field)) {						\
> -	case sizeof(u64):								\
> -		*(__force __le64 *)(&((_tcd)->_field)) = cpu_to_le64(_val);		\
> -		break;									\
> -	case sizeof(u32):								\
> -		*(__force __le32 *)(&((_tcd)->_field)) = cpu_to_le32(_val);		\
> -		break;									\
> -	case sizeof(u16):								\
> -		*(__force __le16 *)(&((_tcd)->_field)) = cpu_to_le16(_val);		\
> -		break;									\
> -	}										\
> -} while (0)
> +_Generic(((_tcd)->_field),								\
> +	__le64 : (_tcd)->_field = cpu_to_le64(_val),					\
> +	__le32 : (_tcd)->_field = cpu_to_le32(_val),					\
> +	__le16 : (_tcd)->_field = cpu_to_le16(_val)					\
> +)
>  
>  #define fsl_edma_set_tcd_to_le(_chan, _tcd, _val, _field)	\
>  do {								\
> -- 
> 2.34.1
> 

