Return-Path: <dmaengine+bounces-7332-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2140C817E1
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 17:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3885F4E182F
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D224314D0D;
	Mon, 24 Nov 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UW02l0H5"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABC314B76;
	Mon, 24 Nov 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000559; cv=fail; b=r6hDMggbN8b6vpuFyI5os0ych3ezKx/Quzf3aMxFr+UVALJdp9wtce7eVBzIsssVMDdih9uoMCXeVbPaFythhCVmSkV4o4NdR4WAD0+nDiZONkaQelfYllGgv/3f66hm0pm8jScajOrkCKH0BDCutXR9JJnE9XoN4M5NauRuEfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000559; c=relaxed/simple;
	bh=eC5FagiADPVhQaCP+8K1nnOH0jczDLU7UoNAigWPBTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UiuxjYzGKX2Ty/z5GzRw6w01f0FPjGwTEh8+gHRZXKwnNYcX00kvYzWFXMSrFEBZJyCwJlnALdzT2lnzDkm3K1HnnPmhzfoRwDtvhNs5Mc9YDzcavAvdLHMJcct21rJs7XX2Y1puO0c4QK+aMdkFESAA0MKZzMotxsY3BHC1jNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UW02l0H5; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1F9e9Ua8WSYXE5KbRnKo6MFy77lCCQfmHPJ4Ee6KyASNmtGUCBHx0PsqgXm178y9v+je34BbCFYu1SVPeQq0utN9VR5fVnaKj5ePc6KJ4k3d9G8aZcUwFrAevZauuTB7l02lxGmZlaqRBbNNn19+pZXfTJzYSIIMDcbYjujKi5NOjTyUEGLgNDcjyKIH71sFQO/LNDW0Ek+E5f/toz5ah3wMcIIf1SsEocasFbzJOgsiJrTme15oCRoVGoVRMQJlp0MGRIUXF45t08RYaECrMydB+Qr3sCclRw1LjVpR/AlGH+1/QI+V1eoXGY6bH8tlAOZBqf/VYR9E0G9ygYq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZTRnkb6qv1ygMaZG2Q1OuYmNY9OLhP+QlTCBHEN1Do=;
 b=uT951grWDRoFZaikEMxrsGXu4+9pPETQWI2Sq5l6jtvAWYZTbgJzo+qzFXMEn0Zhi7sCcTD9XXdqUbRl55/1a98Na+5bpA34LtIZZGnh4eSd6v+che8pBfwkXEw8FYGSfJtbzSynhnT/1+DRaRtQKvEa5jZyo4rAqSz6BMzbxjtGdIBuQT8zmB0FUcpudedBXvxjHBxQltG13xoqah2TsUnj+EN+FNNCLOm6kzJbxq2OjLNhCL3HmM80EHVk4hzyfwO+Mmi9pKRP/3EFd8llCjhXMdrleZJ7cg78h5a3DKFF2Zc2bNqeqRM1G+19wk/sgdNpUfEw6KC2igqsjyP5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZTRnkb6qv1ygMaZG2Q1OuYmNY9OLhP+QlTCBHEN1Do=;
 b=UW02l0H5pPLwy9WOj9TSquqChGt62zqG0U06SFKpKZti8cBGTd4OR6zQ+Hzepehxemnal+Fcvde/KzHhKqVKOSwVcCnLqG9ZQSY7yrAT8Zy9Ex+/PVuCFa6/nixdStXICiaATZ0IPdYvDxbiBNi09+iqHNz7rYAZf46Ykm78u5O5KMM1caVbOURi+PpU0pH+z76VDHLu+P8ixZqeipDCaRlg9c+0dbIzrfjMMRci5FMYjV6Iy/R9qnjTNsBoqzkBFCVaLUf818b81wp0LKH/3X1dAmLU7XGHcoh9q5OZi92AN68ICItE3cOJ7JiKGlArp/PAV+iFOXERSTSnFbBOQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBAPR04MB7479.eurprd04.prod.outlook.com (2603:10a6:10:1ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:09:14 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:09:11 +0000
Date: Mon, 24 Nov 2025 11:09:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dma: mcf-edma: Fix interrupt handler for 64 DMA
 channels
Message-ID: <aSSDItseEjQ0VMh6@lizhi-Precision-Tower-5810>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
 <20251124-dma-coldfire-v1-4-dc8f93185464@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-dma-coldfire-v1-4-dc8f93185464@yoseli.org>
X-ClientProxiedBy: PH8PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::6) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBAPR04MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b426c11-665f-4002-d995-08de2b73ce70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MxhsWXxHMbleI92Kpw3+/XEX7zrb7jeCymES6l2l9tIdHWaiPYmkfF1hOCu5?=
 =?us-ascii?Q?CqvBzWNCNOqjmM7H/xoFDa5S8Fpa15rK4yM3d3u7JEX/yqJeC4CpsaDd35jE?=
 =?us-ascii?Q?TAoxUI3DU/FzL5mZxlDJtajSwGKmz6qNuV04OMpINbEgK7rECDSgW6tU3q56?=
 =?us-ascii?Q?CEed1fCcjhOq1lmvKhDXGTR0U9AcL/fLASXTN755NmrcUo73gzVO6gUoyde3?=
 =?us-ascii?Q?IpSflUlDc1lJeyMGKY3/IoIL19KwYhqjbYbupEPGbW39r9HXCb72LBYTzctF?=
 =?us-ascii?Q?eliD/ZaxjYKwvPmXNIh6fqQZtuBK/ahEeCfsFwCu4SLWPEORUDmaE3/Xhx5D?=
 =?us-ascii?Q?j0tL7p0sWNHA7NHyqj4IP/eIxQqWFkr01jkjCJYwrzHAjQPpTccRU5fw4SiA?=
 =?us-ascii?Q?vaxuQ02xF4C3SNAKN2kWp2L8t9Ww295PtNaUKUlTT1Jdqcgp7wMNxS3rQslf?=
 =?us-ascii?Q?FauCQWuXsFvCEZsq+u8IUEtkSjn6HsgSrieiWehnxtQRyRGb+qLA34wQBKZi?=
 =?us-ascii?Q?eTG3GiHrBKj6veLWpiGI89uTqlMVd9Hq26Oq0Mt/C9BnVbrl5M0RZAjAyO7H?=
 =?us-ascii?Q?Pa25P1EhLcs+0X9L5+T56eFUZMGbFUJWC9A08rZPieeGQGG2veXAXZGhplT1?=
 =?us-ascii?Q?cmSnBAbiJHlLiVobi51Yf18M+8Hl+sd/Bq9+rjzTqZyfAiz6QUIZE/cDXG4N?=
 =?us-ascii?Q?WEEIUbdfhDTL8elW+PIaIh/ZXzLxzWHSxvzpCMxSfo7s5z66z6EdFfBha/kL?=
 =?us-ascii?Q?3sgvivrEO0XpOjgzTd08KTampG+286slfh2l3H8Q/CzTbRWnLHEPiFwS2gg4?=
 =?us-ascii?Q?7AF0ltUntUXhObf+3Kvtq5iJw2Aay9XeP60P/EyPpfDDgtodyyjBm3wJEJZg?=
 =?us-ascii?Q?2cwo1eCto2zB2UiK+piSK3HKzwybMm6cbLCyO15osYqaR/e+7J/1ZHsTFC0Z?=
 =?us-ascii?Q?WWhvsQ4sponCsB/YsPaYlpfAva8L+79BfMTwmR8CMjuG7HF2Zv+ShoRaJcLE?=
 =?us-ascii?Q?/cNYkddnhndoxc0JgDcwsdlMbdpZ3Sl0ApD2ZvuIzAdAw1hQ2dRV8xUsLg5W?=
 =?us-ascii?Q?gNl0OXG3p87kLU6euxhOjD6T8MoEKiahqMeBTl/mtFIbwJrJ0PO0WOeKh3kV?=
 =?us-ascii?Q?NgTESw6mVY4eut6BWdd0hvNSf4MqKmSj3nhf4gL0pAuevCCPuroW6rCZbaWM?=
 =?us-ascii?Q?s04rz+drAKHeFMbAIn/kK6/j/Jwync6tq+xzlzqozCmkOB56ScaKI8caAHQE?=
 =?us-ascii?Q?ZnakfIg4tNBcBLELi4q088ZAbHv+dhp1cdFD2HpwHFLODuPaeBTsa+rK8szw?=
 =?us-ascii?Q?bMV8ibC4/sFUzvqRdV3VaPaNzf4ba+FkqtZGJ/ml3D6jxPjtYcW/wwgCUn0G?=
 =?us-ascii?Q?x9k/p7UDRZS5PVogoaROzug4IBqozE9yBBeuTqLwXQazqIK62QlxUTSfQ69o?=
 =?us-ascii?Q?SeuIOm9uGsmkMHfyu+SSx+GdjDWuDsrBU7GT4Hd1sD/F7bgpZWVg2pMQ82Of?=
 =?us-ascii?Q?C5mkmdvDaPzvlKgxoY31sfzSm0jkAisVvo10?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wIszEf7sMH5Yr1JlvxEbCDHuRnCb+yOLzTkP8aAXPI0rVgZ26+OYnKuj/dtz?=
 =?us-ascii?Q?LLzmxFoWwYwrn8rv4IQ4YGtYRQkm0jBwuSO7NjFCSf3nMoQg2Di7/2bNvoob?=
 =?us-ascii?Q?SR9cUlRfS5fzCwAYUrMKpRO1td7bP8ZMBCWupvBBGg5esQUB7QpTIaDozbC+?=
 =?us-ascii?Q?X3xtDbwUZfzQghN0tpYW8x5frEHtBS9ko5+EUkwNrydv3ZMOxy5toCX6HyWo?=
 =?us-ascii?Q?g+hdLr/Z87hUgfETp/IC1HCWmVu35uhV44pJvPE0VwUFmJMrprbY2ky1dgMp?=
 =?us-ascii?Q?7Vc6JdYqQd85HT2mntyVOckIRiPDs92pJirW12WeOkxWyw7Nt+g9JHPLa3G2?=
 =?us-ascii?Q?LeYgw+b9svLRAVwiLetuDfOAtptDAc9Ca7iPUEFDcW+Iu115iamyj/hxtAWp?=
 =?us-ascii?Q?OUR0ZqhzaRxXZFB1buNq93Q8l6YyHaFQXp+8DlUJRJkDFpiB6IGhXviYD+Re?=
 =?us-ascii?Q?jpVkgHL1SjnuwF+4lLE0WM87/Vzt0O1/22E97p3j2j5W1yoSwU9QSQtEIyno?=
 =?us-ascii?Q?bOwv+tafPitobpWAczCrcNAf9OkYFGTXAPUpW45iY+sK2yQKjvzGnFyxiI/K?=
 =?us-ascii?Q?rM0dut98C69ovQMt+PLJz2idL6dZoCWLVvpg0pHTtGouv2IuXfBFahQjAqIr?=
 =?us-ascii?Q?Muo3C9enQ13tz0++3DGInIrfLMANxEeNKGUi8aulpWNzZhc52Jwp8L8Nny05?=
 =?us-ascii?Q?N1jOPxUeVDJniwedX3vnb2iW9Y3QWvKP7wZ0E4lF0fLpXQdUEQDjgHyAZjhI?=
 =?us-ascii?Q?j09rN6N+47EHJAgBg+F7XvW3kMUB3SIRJMc///R+7+KAxGkAhAW2hdN3SBO0?=
 =?us-ascii?Q?so5Dnm7vamg40Xde64jrtfhwSLJhFXsJnObfa7If7Z0rQceYIgwsKr/yq9pu?=
 =?us-ascii?Q?F+KqpT4/SGn2DFQCMJOmBbifOFZ0oU0auHZwkY2JO+M9fbb92mg8tpzxPZ0U?=
 =?us-ascii?Q?LiAGYCOnxI5+iArr2Bfz3xrtLO2USAcDbRVee6hRQkX+VaeuVGIiTYRZoY5e?=
 =?us-ascii?Q?2AfWmZ/W785YfnPiHebRIgs12IPi7OaaUV51lce+09L9kbr1+4852RDHzITJ?=
 =?us-ascii?Q?0TRFccd69KWeeMcPg8qlJAPyAu8+8hXVq3TDuvCre5Nm+fqBEHFFp1roDDqU?=
 =?us-ascii?Q?/oByPRSjLeowac/FC6qNkoLJ27KbzkTSUtIUy4pFPzR5TDl0sAGm2MkTMAeP?=
 =?us-ascii?Q?VUm3dM4m0wbwYgLOxcP0UmeXR5k6PyeeKkhBma3ep75d5+97KF72D7DHovdx?=
 =?us-ascii?Q?33q12rWgnAE5irjFXmumxEQfozXOO2xw6/OOFEOH+zcHpSQ1rfrkRcoO6WhW?=
 =?us-ascii?Q?TFDhslmbz+6ODqS4JWCLijbuvS2imWwu+8Xrub8SS7/QMyw7yNIYfeLxD7QW?=
 =?us-ascii?Q?QYpwT/P3Jv7scEEt0v/Jp0HUgO+3jc9Rmqm7bjvuDurTVIKV5RfkSPPqLmn6?=
 =?us-ascii?Q?b0/nqBvBJ40bNvUxzu3VsO9c690Zwb478J+iND5QwAyX8l+UFWgp7+Nfbolo?=
 =?us-ascii?Q?gVNuWGzX8yogCso5fU60AG4dzSFo6XV1dIb2XK9o2YAqo2HXoCjyAFZ/hBd2?=
 =?us-ascii?Q?PvCkApTrB2eGhJ/UOEzdctSGeiXzC7KC1YdL4Kf2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b426c11-665f-4002-d995-08de2b73ce70
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:09:11.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UF6rCCOFZ8y3hlqQ4y6CM2ClkgePr8+qG8RDPMz1Xfidv97UsxvQUV8bliFAwVuKyqoJV5qZ8ofyXj4XurpgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7479

On Mon, Nov 24, 2025 at 01:50:25PM +0100, Jean-Michel Hautbois wrote:
> Fix the DMA completion interrupt handler to properly handle all 64
> channels on MCF54418 ColdFire processors.
>
> The previous code used BIT(ch) to test interrupt status bits, which
> causes undefined behavior on 32-bit architectures when ch >= 32 because
> unsigned long is 32 bits and the shift would exceed the type width.
>
> Replace with bitmap_from_u64() and for_each_set_bit() which correctly
> handle 64-bit values on 32-bit systems by using a proper bitmap
> representation.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  drivers/dma/mcf-edma-main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 8a7c1787adb1f66f3b6729903635b072218afad1..dd64f50f2b0a70a4664b03c7d6a23e74c9bcd7ae 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -18,7 +18,8 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
>  {
>  	struct fsl_edma_engine *mcf_edma = dev_id;
>  	struct edma_regs *regs = &mcf_edma->regs;
> -	unsigned int ch;
> +	unsigned long ch;

channel number max value is 63. unsigned int should be enough.

Frank
> +	DECLARE_BITMAP(status_mask, 64);
>  	u64 intmap;
>
>  	intmap = ioread32(regs->inth);
> @@ -27,11 +28,11 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
>  	if (!intmap)
>  		return IRQ_NONE;
>
> -	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
> -		if (intmap & BIT(ch)) {
> -			iowrite8(EDMA_MASK_CH(ch), regs->cint);
> -			fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
> -		}
> +	bitmap_from_u64(status_mask, intmap);
> +
> +	for_each_set_bit(ch, status_mask, mcf_edma->n_chans) {
> +		iowrite8(EDMA_MASK_CH(ch), regs->cint);
> +		fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
>  	}
>
>  	return IRQ_HANDLED;
>
> --
> 2.39.5
>

