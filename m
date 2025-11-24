Return-Path: <dmaengine+bounces-7334-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA9C8184B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9693A1B66
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92A314B84;
	Mon, 24 Nov 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aJmjDIHo"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641BA313E3F;
	Mon, 24 Nov 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000989; cv=fail; b=g6nS7I6gUjHHN8PLzusEKX5HQVv0MBrXgYDxOrIarTSZ89/ZUyfoJAWww5OVO2vjBuIbj/MldIBOlT37fh98pwb9+fhdNjDkevfrUwVqlLrfUBuITjKPTDwoUWnFBjtRxgGki3BCESxK0Zs0YJFwdmO7+i/zMK9IlYFnY4cMNHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000989; c=relaxed/simple;
	bh=PJoPRa6aJAVtYiq0pSJFf3MSdu2UliUySsJ9Pi1+nzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGQ/0vd32kZsdew+vjSKodjEjzZF4nXIGW/xTcQVANkzlO5u8C4QLGm0N0zlPaazzGlFkY29SiOVPjlO0EqFIUdTeNIQ6AE+VvBCgKNzUTjrst1YAFE+iQtcbjDCp52BxP+gffAJbvejudgSs4afNAGzFPeUBQwpAjVkUo4PEoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aJmjDIHo; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpogUf9SbYU1S3Kc0HxbDTF+p+8Yw50VB7UBqcMF6Ri89/KjJSnpZ0xatnnbD90UwYQAPq25PmYsux/Qd8p7FKY2IdkZJnsvz4sURu/YTVw0vByjcEDqEo7Z6tPtzUyLfkLr8K/My7iGRp+6wInXcssvAuR0O0ZGCHnVIEasmxGb18YbrFc6AHh1ueoXblDU7GcagIcD83L8CH24ojzaj84BWStq3YMVTMM+11WpOs/9YAcCDzhmg8gnWHe0q0lk/m6gCS6EhYx4QwlMNnkqJ6DWs2JGKKiIb30EC4ewlaOJ3LAtVdhftWkMnVqOModuORAbKbOvn/tu5XYy8aSuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaAnO7GhkXinSi3YHH+jBGkxEPnFDbSy6xOv7m3kxro=;
 b=dzgq/ALo/nAelOgPQ0ObxuVPQJrrNxHg643iyzWr4Na1r57ZSgQ57x1eobtqxSJzrhIWFrFwmTX86jR7KpvaVApLOGNhrPBEeZlkvJwaxx2F1mBNbps3nZ0eozau0jhVQA08jmrQdW2LOJlNhdLSvrqHopJJ8NfnGmmrUXl+tOVRDCWCXL7qwokqqUA8AvCKruL1Fke4KHOoK9jkYjnlt19unFPR5ujW9RIlMYfhXMXrBlRgX0BuFop/Fpo9QbiWy1xwnZIFTgt1b7H4nCQy6lKqLXT9fryOVo0DXPGlHoKOELgPZa5rf2KxQAgILFf+IZrjMUTJjsztVJ5ct/1ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaAnO7GhkXinSi3YHH+jBGkxEPnFDbSy6xOv7m3kxro=;
 b=aJmjDIHo+7mvgHEDeTRn1X5sKL82ChRlM86SA7OZhhThYjTJxhgvdX9hSp0XAzLddvVJsnD727uRkTsiAEFC6lbHl1gr0LEtuNB1NQFbMuOrxzhqMoYukgPp3bx/CPX8F1tbpt9rRxkeMqV6LsreV7f6PcqQtIIAPePTbdgpQo+NPnoqx2wQY9qLCdyzd3U40bJJ1YRkj6PxRRzsQlrAtMT4mhBX/ZjGi0sZ6CSN3jaciy2Jl3yZ/IgCDGv97fQsZF/4nfLaVpYQ9id8VuAGPXEnokzjsj0z6frxU3EDDApdDzsBE7Or29voVNiS6JmBn2TF6wW+PhjTPpKZGT+v3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU7PR04MB11140.eurprd04.prod.outlook.com (2603:10a6:10:5b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:16:24 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:16:24 +0000
Date: Mon, 24 Nov 2025 11:16:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] dma: mcf-edma: Fix error handler for all 64 DMA
 channels
Message-ID: <aSSE0qdea51qPyP4@lizhi-Precision-Tower-5810>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
 <20251124-dma-coldfire-v1-6-dc8f93185464@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-dma-coldfire-v1-6-dc8f93185464@yoseli.org>
X-ClientProxiedBy: PH8PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::18) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU7PR04MB11140:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d676759-f566-4ccf-ee9b-08de2b74d06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tctrPzZmt515TxvZ7//xQtGCDiyvyfJg9HNFFczYtBSpN2Wzg52ZWbcw07rX?=
 =?us-ascii?Q?lw91rFfk3Hqa4vi2QhHG/lzg8ao2zIJYePMkgU3FmZP3L19sjyEgMTCYhFIB?=
 =?us-ascii?Q?uXQyTYnt2EqTLCZWJk8dL0OtkA+N+v453qAQuDgEwhoctRq4jHu/7nVRhsKZ?=
 =?us-ascii?Q?twMntrNFWucfX8/gJcG3CJBV0OXOmN4OXXFX+ipTaeqimi5yCN619rkooj+t?=
 =?us-ascii?Q?XwV7FPoaTvjw2Kcyf5/RVfyFNqiOO/hfrlB0xJBLqKs1HTcYoZQuq8gV2wnQ?=
 =?us-ascii?Q?E2H2qMG/ngVrZekhgoVgFnetuZjkbBBMuIB+rcX7sc0zvc5r2bzXAnC/7cQP?=
 =?us-ascii?Q?/N2Inexo79QkUmitzXb/DtII6cgNYpJBr4AhRXrIfATiontdRlD3o+3khZwS?=
 =?us-ascii?Q?1L9xw8xb744N5LecDuwbx94rXZPO/inrKngERSuTEVxyDszhpSTl5XMVGH+j?=
 =?us-ascii?Q?dBpJbAAUDNWNwYzA/RIi4CxZHqj5rUZaXBNuTPHLgQTpxOZ1R6Lw2qaB5xCl?=
 =?us-ascii?Q?gBnSOIg5Fdd1TpyODNP6k4uklRWPfyVaUn0lDKQPdbruPrZD48VF58aJ1TEf?=
 =?us-ascii?Q?jfDaMqcWstnocC6ezoPjphBxrkyuCT9tt72SPPwMLvm0mq85A5ApqATlvSed?=
 =?us-ascii?Q?L+OvCiRZzfa/jVhQKzd/aBon4uAJ+T7+bu9kwfPFOEbHgGiKhXBHspflue4V?=
 =?us-ascii?Q?ne/6x4zx69ptj0+WIlEPfbAJ55NLAU3dNc9gHu6O/BKpnjwywAOynAv3E27h?=
 =?us-ascii?Q?PQCkRcKjlh5MyXZKb6SGK1FrISFvKc6Rp48SWIMX9ZkwCkcPgvk/YsKKja/H?=
 =?us-ascii?Q?fVBgo3Y2q6HtJNZ9r3mlpKoeIvcPuZaxqXie2oSFXdd8KGlSnzZTqwHRvIs1?=
 =?us-ascii?Q?LmgY4L1w4xcKODNI65+pqO4xf0nH+2fN8IB830gPl0fnTxPClXNaZnNJ9A1H?=
 =?us-ascii?Q?eHPJ5HqkRj+siwcPx7mI7HrJjTmYdfKyEUsMN+1XvNvGrzGyuvtIuIsG5jgH?=
 =?us-ascii?Q?tmrDJV4eOpnGe5og7LKZibG2bV3LNDGcWJ5Cj7Qv3EEu9PvXP/P2HNkCyV0Q?=
 =?us-ascii?Q?OwrEMogOGxiStTCWwDmKDwuenYTgQBzTnRvqIQh5ip6lzDaLLFj6acbFwm9g?=
 =?us-ascii?Q?uAXzKjZv1aGn8DcbecMZmsjG3b3wiKqrog+DVfWcghXYUUglcTO0Gqg153y9?=
 =?us-ascii?Q?88U4tncF16S9nakfvMIllZVVFHBvS8CEr5oq4x09r2gs5pmHT0H11sZ/XxF2?=
 =?us-ascii?Q?p0NFZBz/1J0DQgHrMMwHidxxaLvexpDb3ZaTSfAreVok7Pq0DNYRL0/QxKIT?=
 =?us-ascii?Q?LwaWpYxNb18G5sP4jwwtna2JzlrFAjZZFjHSVf04zvoXAcNjmEILZ3Vszwqv?=
 =?us-ascii?Q?U94veLoB85cDHcMQy1Je2waSJkt4Z76XKaaAgSyfVGHvSeBHrN5jMdUnZgeq?=
 =?us-ascii?Q?B5SxhaDDbEf6pCD5lMbWNyNlbTytuSr4BqdhDpX7Rp/RYk1v7VCnbCEfciOC?=
 =?us-ascii?Q?O/FeshlVs9uP7kjS+TRjMDI9u6KuKKfCO4Ii?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VtdccCc34h7Rh/8NElUYc4BjGHEcHU8Fqu4RUU6fEgSFa98Tu0rWBFK8Gkv5?=
 =?us-ascii?Q?uASzIQV+0qOmO7gdiJf1jSjceHxwsv42ITd9x/0lRWLKJd5T+zF650I7MPTl?=
 =?us-ascii?Q?3RcKg+FCbH0QlFbK3x/UGyCuBfhvoqgKwLqf1gVXyk2aLFr3tD43qXiUWNh3?=
 =?us-ascii?Q?BGgSKKmflNVRZwYs0QaHUMBgeQ0hYYjXJsmmpzFGARpofCl/Ou/qIMGxtUp2?=
 =?us-ascii?Q?7CJzDISGiFPqkw2L0IYlneZKWxwneo2fj1bYNyW05mD5CZCWxHxk6xhFWryD?=
 =?us-ascii?Q?Tm7MNvQmfQpTHYC2yWlZfP/ltjsCMyFZ+3qGWO6BLqgaTGL7WMKbT1RVl07G?=
 =?us-ascii?Q?qkwEHtbMranyJSE5/pdfVyMFLmGTcH42AC6AS7kuWp24V4/i+wvuw05jmWBX?=
 =?us-ascii?Q?lRaNeb7dxUT6Y5BHO9neFc+kJsBgeEpDzBhsfYTH1FPLR8ow0wS8xiR/QBDQ?=
 =?us-ascii?Q?OHjL/O7ucsHXKaiftpNmGaBEiEYPFuprTxd5MDkfUqOXZELY2huMK1LI6R9z?=
 =?us-ascii?Q?NbasUjj/OgjH6u9rB2MsnqBZVcoANBVz3eTyKj0MGYmYWsS7MarI/d5Hvt/J?=
 =?us-ascii?Q?N6gUGbNdpj6ZYJhdXUCBBWYqtL0NcqRvV/mqggfNg8+gkBsRF0/1twq68JnG?=
 =?us-ascii?Q?bb33KsdR0DfyDEonyFFwyBVjh0iMTdvn96ll/gwBIOwM7x+ziQSwpaJehxWU?=
 =?us-ascii?Q?/UQcW+Foq1Weg0EySO95dAIWASkCuEChC+3scplWIPJThezInDWrziTPOSw+?=
 =?us-ascii?Q?BVheZH5kfjXkTjbnjuwV+Csz6QiyZKuK9bHjzGNuzeu9rxlk+bEt4I9APkaq?=
 =?us-ascii?Q?sh+qxqttiqm5KOBhfqJTWbtYsLMdbSx38DIIZ30wwxfNaRZGUP22voVq5ALN?=
 =?us-ascii?Q?sCNnDZY+gZYiHg74bwB5MJ9KOOe2NakJwZUi2TgzDYj0KV+CX5z8/uvUl9cA?=
 =?us-ascii?Q?cKGpQ8NCYImzM0L22fbXuLdZCGqEVFJtpB5hwBhGil1yWahMe6r2OpvtKP4Q?=
 =?us-ascii?Q?v350canIK0c8lx5e7xGkw4cFA7BBKjLZ1iwJglEv7nr+7QmYaSjXyErhbht5?=
 =?us-ascii?Q?/wBhX3dWrprrY7xQth7qAWjrD5bumjx5ZkosSK44Qqwo2NDsDaFwsY/W9q3x?=
 =?us-ascii?Q?SXGpUxR2AV2mq4nsuvxgfnu0XHQT1EjU3IoEYrse6gsi0YzRwgobhXaSH1E9?=
 =?us-ascii?Q?mupWOYxQDT9mj3DtQmP2N+FNwDg/KMX2X9+dR1+sk55nW7Nf/RKOljrxcdlB?=
 =?us-ascii?Q?qQR/iyLMzsmHQ9KkS8Af4LDKZDOpVBUFO61grJYMgWFRf5Nx5bz4ZvzLnhnq?=
 =?us-ascii?Q?ekibC5NANEIxT0mEl6jzSYaDgrXMj+LBRldTfurDvcOkHbZV6o24HNnkgO/I?=
 =?us-ascii?Q?hw9aw8/i8JGFjY8LmCRo+yNYDNR4gDDJU9MBBARJmda6oyMetinSIlS3j6MS?=
 =?us-ascii?Q?mmqLiPc1Qo40iTIKrLioDZHTsPhSurDhrrfjCtWvqG+vRim2QakjSskG7Czh?=
 =?us-ascii?Q?kYYJ8onnGEs5GibfL2aRTxg4iJATR+eEmgD6EmtqQbghD+hQGnI2EUnkiWJc?=
 =?us-ascii?Q?ALsxOg2DslG2ynKByrY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d676759-f566-4ccf-ee9b-08de2b74d06d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:16:24.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jInun5p0WVDkSxAL32Gg1ijD0OkECQN/rWNWv27SxoR3A+2+eU6dDrCtA8MXATgN2EgNp0KASBn7ogDT2UPqdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11140

On Mon, Nov 24, 2025 at 01:50:27PM +0100, Jean-Michel Hautbois wrote:
> Fix the DMA error interrupt handler to properly handle errors on all
> 64 channels. The previous implementation had several issues:
>
> 1. Returned IRQ_NONE if low channels had no errors, even if high
>    channels did
> 2. Used direct status assignment instead of fsl_edma_err_chan_handler()
>    for high channels
>
> Split the error handling into two separate loops for the low (0-31)
> and high (32-63) channel groups, using for_each_set_bit() for cleaner
> iteration. Both groups now consistently use fsl_edma_err_chan_handler()
> for proper error status reporting.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

It is bug fix for high 32 channel. Need fix tags.

> ---
>  drivers/dma/mcf-edma-main.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index dd64f50f2b0a70a4664b03c7d6a23e74c9bcd7ae..adae2914c23db3ce9244c0cb8d4208fd71874f76 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -12,6 +12,7 @@
>  #include "fsl-edma-common.h"
>
>  #define EDMA_CHANNELS		64
> +#define EDMA_CHANS_PER_REG	(EDMA_CHANNELS / 2)
                                ^ align to previous line

Frank

>  #define EDMA_MASK_CH(x)		((x) & GENMASK(5, 0))
>
>  static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
> @@ -42,33 +43,33 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
>  {
>  	struct fsl_edma_engine *mcf_edma = dev_id;
>  	struct edma_regs *regs = &mcf_edma->regs;
> -	unsigned int err, ch;
> +	unsigned int ch;
> +	unsigned long err;
> +	bool handled = false;
>
> +	/* Check low 32 channels (0-31) */
>  	err = ioread32(regs->errl);
> -	if (!err)
> -		return IRQ_NONE;
> -
> -	for (ch = 0; ch < (EDMA_CHANNELS / 2); ch++) {
> -		if (err & BIT(ch)) {
> +	if (err) {
> +		handled = true;
> +		for_each_set_bit(ch, &err, EDMA_CHANS_PER_REG) {
>  			fsl_edma_disable_request(&mcf_edma->chans[ch]);
>  			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
>  			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
>  		}
>  	}
>
> +	/* Check high 32 channels (32-63) */
>  	err = ioread32(regs->errh);
> -	if (!err)
> -		return IRQ_NONE;
> -
> -	for (ch = (EDMA_CHANNELS / 2); ch < EDMA_CHANNELS; ch++) {
> -		if (err & (BIT(ch - (EDMA_CHANNELS / 2)))) {
> -			fsl_edma_disable_request(&mcf_edma->chans[ch]);
> -			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
> -			mcf_edma->chans[ch].status = DMA_ERROR;
> +	if (err) {
> +		handled = true;
> +		for_each_set_bit(ch, &err, EDMA_CHANS_PER_REG) {
> +			fsl_edma_disable_request(&mcf_edma->chans[ch + EDMA_CHANS_PER_REG]);
> +			iowrite8(EDMA_CERR_CERR(ch + EDMA_CHANS_PER_REG), regs->cerr);
> +			fsl_edma_err_chan_handler(&mcf_edma->chans[ch + EDMA_CHANS_PER_REG]);
>  		}
>  	}
>
> -	return IRQ_HANDLED;
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>
>  static int mcf_edma_irq_init(struct platform_device *pdev,
>
> --
> 2.39.5
>

