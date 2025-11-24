Return-Path: <dmaengine+bounces-7333-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE48C817E7
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 17:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34D7E4E1D00
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554C314D0A;
	Mon, 24 Nov 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZUHVFy23"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208E313E37;
	Mon, 24 Nov 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000648; cv=fail; b=KQQpye6Z/r6m3UeU+ppuHaAfbfX1Gd6+zIUpp1GWejRW8RNg2rhB6GmzDHOYLj5v7XDmN/aR6JBZeznkCiwckBT2N5gY3JhOIxnrHcC69hB2lX7ft3CZYM6Hiube8cbAu5lp7ALLpny4Mdx1f681IAlnt52FmTQE4F7iQiQT8bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000648; c=relaxed/simple;
	bh=fFobiKcpQfnLuaGMAFZTwNGdQg1G/K0Fcx0MbGeHlZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CarFaPV12QEeq8ubZcVE0bAez1B8r/SASOVX7tUEDotPIa6qjwxGIBbUOZtcSTSv2UF5Ob161Jh2Y9vbN7EemSGn9TTp5qOBvWPtAU7eR25I7KnN/47SQh9z4mGGgkbhqyblCmo2OKFAe0qbKstH1ZfbHmSPg9XHXWER2WzwL/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZUHVFy23; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1MhtD9Bt5YJ2+jCQl/QxAaCfdaG9M1auaHONWP5cPe6UPUf9ElwvwqYBM4tm9bXCnNYKJ9GQQhabqajAXD0qQzlrTpgp6vxW+/LIgAC2wZE6ARBdZe/tI8mKBi5VBj9ifqlatVqFADpFNKNWK5TiMbiCai8gBgoDx0GD0ciIKJla7LqMlvhAoZBH0zLBZ/1yvlI5jlXfw434LfAMJuBKp1SQP5hKPSrxo2Y4hO3M7XXiTr49gb1HbhH8jDrP/Zh4NyqmP77CqH6WasCMKKMT0vvRl6PGYsOjWz+kLJABIAado2LJw6VU6r8c3txwm9UxGuPE/ygl/8ukgDv+gP5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P494OEROY8bgA8RKdH7R0EiCnrUl25xd5YScqn0JJgo=;
 b=phL5oZArtx05QiOIlSY8tugv2sWuXZlNWZL2rnqp2S4yHW4Zk708FBeWXsTrnhSxp730Oj0esrcUFPHIEeYTvgtx2jpoBcSbOGPFL+xhZbBxjrgN/udFn5Sirc6cMgcDIhR2dv5cer+b7Zb/SJp4hoC6QaIcdUdTwZwXENF3tcO+0G42n8T9HGr3uhkBjfKGlOUU8MLkjTaSSnKUPibF9IoV26fewJeliAqk1ZNa4xvs1+WCrMG22jNSw/AZr/DH09DZ08+oPEJsD+zNYo+ojqS3Z1yzLKN7+1ihUbqnIaZ94Raut2U8tS5bHt6X+MLg1BpVoOVF0iGsmSLNJVTWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P494OEROY8bgA8RKdH7R0EiCnrUl25xd5YScqn0JJgo=;
 b=ZUHVFy236pbhy5P35+PVlkQLRUoU6kYIoAos0jDSTmHX0YyTtRselxgFaLB0vv1rPcMMxoT8a23S0YHTTTnXyhXoZnxZUJt9dTNgE1oWiF9bjyIESxwHpMBVqpvDMhqc0ye4YlsKA5wrONFiGy5J2YNLwXhy9/UDHqkFir9YVPp90lLAKm0PURJvlA65umUR1E8ezdRnP1myhVwWpIk+pXD4JdDOMASTJKGIN9hh2/UT4dFiM15YnuJOWRSn66bsjZoAxq1aew9GN6bRgHVPR5aD4i1hqCq00NV02eHZrzjfbjnDxLMwRUUvpGt7vBNBVj89eOZPCNwilreRHEX9Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBAPR04MB7479.eurprd04.prod.outlook.com (2603:10a6:10:1ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:10:43 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:10:43 +0000
Date: Mon, 24 Nov 2025 11:10:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dma: fsl-edma: Move error handler out of header file
Message-ID: <aSSDfNQjWRSMBWqm@lizhi-Precision-Tower-5810>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
 <20251124-dma-coldfire-v1-5-dc8f93185464@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-dma-coldfire-v1-5-dc8f93185464@yoseli.org>
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBAPR04MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ded0c1a-4b59-487a-47f0-08de2b740502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GulbEQAP+2FkqCZlM359PK/I1boc9sbhoyr6a72fTJo5Ydmz1gqA0RfTzlhy?=
 =?us-ascii?Q?gkeNhkllHHCUUpcHct8M8YeNE35PaZ+LayrS8gYuvoJMpWXy7Xwj3HZ3ouQ1?=
 =?us-ascii?Q?LKD/UpUUdX+Iyox8gyaw+JWVEO1OlVTbXPZt0MdM4lL4fZMFAHUX1xPmV6/y?=
 =?us-ascii?Q?OWoQ//2HinnuFSaV7Z/u4jPp3wJ+H0SpSFCMnT0znyiX2VP8p1hBBJpRME3S?=
 =?us-ascii?Q?rlgajpZ+Is1Q0EGyCoSRN7rrdYHp8qKnylFKjeFssBs3bYWhJnwQGDiY/n00?=
 =?us-ascii?Q?fHCl0TzLsgSjPC9g1clJAtw8PIVxY1UcOMZ1u27cNZCiugbEVOpMb4W1zJKl?=
 =?us-ascii?Q?qv8NozKAKUyCB/eKISdsOkpHq0BJcXbwnSZhaYEEe60zDqCm/uHpr4AOoXJC?=
 =?us-ascii?Q?CXk5jUMhwMfEbkbB0Ti2nAvVGs8ZH35q1uvEh7o83a0fFHRcn7YHJrR98nx5?=
 =?us-ascii?Q?0S7en8syxX/UXL6dD3NAog7+N3NywfJAuG7d+2vRKRjkszSZf2SWj6d4nw0D?=
 =?us-ascii?Q?oXs5ffHIuJDb+bRMIzhsSQRZnUN1Og3zfLNPmleqAA6CErnLKM+M7ypAXUZX?=
 =?us-ascii?Q?yQL1BqFf71qkLonJ5v0iDU/JxUwU6QegBfjw+cPU2tmHNTg0i6qmGaO7sQve?=
 =?us-ascii?Q?o81VJ+m/nvmqmKba83WsuIB/cPiYUHlVbq8Sq3TfftDkmWGQg3XSV/ekcd5v?=
 =?us-ascii?Q?r6BPN1P4DPnZtTjV/qPILgtysNObGBwtxGyevGbcg/bBrpECGLOpkBkoHp4h?=
 =?us-ascii?Q?7dGSLhExNzd1kIQ6etbGDOcyGIb0Dio9D6Mwnl4jfGh0oHDhD1jiAW6yBUzp?=
 =?us-ascii?Q?fVleTZU4OgIhbRD5kGQwJv86BS0k459KMuoC84BbG5QSeIwEDFT/KGtfRsph?=
 =?us-ascii?Q?V73iYn39hmmqsyUxwJLAKBoh660QbOjZZtM+/DXOwcbu7FjY9dOUaAwlxf3+?=
 =?us-ascii?Q?v9hZpcF1Uv1BnpTNKCyy31dHHq0T5iE9RS7TPyop7zAJvEOjVaXqLcYC9Ix+?=
 =?us-ascii?Q?MV0b3WZPhs2QRJkPcP3wq2L8kqHq/k42cA9cwmzp7Jjt97Z1nurtTWpDmZTO?=
 =?us-ascii?Q?hSI/E9YbeG5/TW3QYWyKZvPQVo8oU5cdDweEt/E6pAwxu1i6xXXiIJWjpKO4?=
 =?us-ascii?Q?pQJdqJ+f6hqi8+iZjgz4gJngkNRSLKmgv19tm6AyOb/ZRrDhEEoEyIbgngMW?=
 =?us-ascii?Q?fcKEq0dJvukXL+YMdq4h6cRidc8bCmJS4P2anBqkvv9M+15PbyxRAxIPEsOY?=
 =?us-ascii?Q?WADuh01rGpGwuyhBOzAo4NaWSAoD7TBAXDR9jrvGJJO/PKTp6NtHit9CnitY?=
 =?us-ascii?Q?a8QRztU3I+4q/8qySUO45gAjUmS5PnU0d3hBE6w2Vo8Q97C3UlwVJt8+Ift0?=
 =?us-ascii?Q?aYvLDN7lhO24tDtvqhbLLTIknwhn3HjmGi4Z7H73y98e0GJBsHY2v0FTQjjo?=
 =?us-ascii?Q?xsp9zgr6spD+OABevhUCtKadOrg2P9JhvpDU6hQfmkiiDBXquCYJdMNwQrqP?=
 =?us-ascii?Q?XVtHsrOrQeL5FtTWYDPTH4VtPVeUGQhFL6r5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SNRE0mZpmwuzwYBR3hSePWOpthvG0oLhJcpFZJ43ovw9dIH9UziRGbCG9rDI?=
 =?us-ascii?Q?32hMfX957JhMoRe+JpvYtQhNal7oJsir4qHnJ3VmHJnuUxER/JMn5OvtgIIN?=
 =?us-ascii?Q?MFB6xa6Lth1AOTsxRKerfeq+g+NQeB11vnNLTORMIRwr67TbFzIvWlJ/Strw?=
 =?us-ascii?Q?rPTGIiKHcqQpqk7nsGkoYDHSkvqdfFWZp9C+vGD4j0i6c1q/G1HvC6SRoTYX?=
 =?us-ascii?Q?pKgYcdCOxeiVORmhstIaABXGFn5SdPm5UJoACa4ivfPOTpVC6xW0BWcoY24R?=
 =?us-ascii?Q?zdUQvyKrgWVHEjLS0zscBDTa8pMG61BmCOzanVWm66fYRBUhdi0EGK5vw9Cf?=
 =?us-ascii?Q?DPieMTj+D/gWmFx+4dNXC0wKoGlhT3y3Fp5O/qdX2TZ/13YZbXEdvBakfPzo?=
 =?us-ascii?Q?lqI09bVBp8TuTxWdsLGPO2ForbDavQozhkQeeXCBBPnSrYYsopyRibWw6EuJ?=
 =?us-ascii?Q?B3T4+0bBA5FdWj2eAvsdZB/YPNWD7kBntyuCjyTRhYGLHvq1i6jBw2HtEXP4?=
 =?us-ascii?Q?n0cBkhX8yYxDVFvp8MSJrV6HQ+gbKILcoJwlhevECxn+ERKxaH5/a+CQx6q5?=
 =?us-ascii?Q?YxF3OwgdtLRx4tHwjETwpRA+7/ixfbRYE2afGlcCsjnIxZ5YsvW35aHRZSut?=
 =?us-ascii?Q?0Zg1Ige78mlqyUqHp5ZG391UAoGWFKcaRma63qVzfefZaBKChn8AE4wT0PuS?=
 =?us-ascii?Q?u9fGK0ZLlL83V8M8/fqY7RsFIAAcaTppdDspoNzu3PXj+U6fKcbOxllobqel?=
 =?us-ascii?Q?ZbL6p4BBBAPF1FOe7W+mXp3Ar7ipd/WPKQNjTY2Gouxjr1cWIAet0GMbfzsS?=
 =?us-ascii?Q?HQwrdG4YdWSUbnQHZBo2rjZT7sBxdSXSM1RoZ+Ese1+lgkA4xu8urKmAv3lT?=
 =?us-ascii?Q?r4aX/4EA/XnCambI7tzaQxSb532ba8K7wthJ+BU7HRX0S53oncSdBheYPoTj?=
 =?us-ascii?Q?BdYmkXlhxAFQIyxwQedWobn2EBZNYo+5yPGHfe5TkSpGoII2JOoopE6cRrxs?=
 =?us-ascii?Q?oJGMqLv7mXCRIQYjJTVZwjXK/Wv5/RJ4WIm6aHafFVwIl7gZMbAv5V87zQKZ?=
 =?us-ascii?Q?ny6fM+3OAs5C/4Ua5gj83lR7RE7zDQpHp6vhPk21/bSrrBXhYB8O0aPgXwe0?=
 =?us-ascii?Q?1z1cd6pdAxy5Qhv3ffX1+oix9HMd5JwGRHL1p4RXjvnjI/iDKgSb6bKaNcX2?=
 =?us-ascii?Q?J/LUcL0mNtj5cxOE2EH88IyKfu3l5+0wU1FwnrX5uQaeZU3NlBoWi82DjLBd?=
 =?us-ascii?Q?XKW8B+A44C1c1SvQVUtsE1VXj2JDpOde9FYAllICx94M1uNEPtRmQmJhFfLV?=
 =?us-ascii?Q?3XSLD7r+u3UIuMH6OtAO7ASgJiHM1DY/GKqaKayNnQtK0Agu8fZDgifR/zBI?=
 =?us-ascii?Q?+1wFsepM5s3LQF7gyUCZ7lOVqOA+c0WQu5BtXSixvDF6Mc5shESX+gYrCh8X?=
 =?us-ascii?Q?CFcYvwuYu976YpxaawRIs/mfsbxXWmpQjuKhdyD+/TqDfA2TPketdsSveTP6?=
 =?us-ascii?Q?vkY8UR+1KEkEIopEl57cbOXggdBFXc9bGfZRxeuz0ArztzK8yyAoEMchLKMc?=
 =?us-ascii?Q?+o8o+IK4QWd/QeC4my9Agn370E798LgHPT83OEjP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ded0c1a-4b59-487a-47f0-08de2b740502
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:10:43.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTZNCUpK7n1+ziPc8NnK7Fs8GHGVPcFxjhCQvOr9a5MusGvmpJwkmX6v7dy/ZjZsBqPeGZ7gzjmqIJAMfJonxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7479

On Mon, Nov 24, 2025 at 01:50:26PM +0100, Jean-Michel Hautbois wrote:
> Move fsl_edma_err_chan_handler from an inline function in the header
> to a proper function in fsl-edma-common.c. This prepares for MCF
> ColdFire eDMA support where the error handler needs to be called from
> the MCF-specific error interrupt handler.
>
> No functional change for existing users.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.c | 5 +++++
>  drivers/dma/fsl-edma-common.h | 6 +-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index db36a6aafc910364d75ce6c5d334fd19d2120b6b..40ac6a7d8480b9ed2c6a2bdec59b4fda5fcb6271 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -44,6 +44,11 @@
>  #define EDMA64_ERRH		0x28
>  #define EDMA64_ERRL		0x2c
>
> +void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
> +{
> +	fsl_chan->status = DMA_ERROR;
> +}
> +
>  void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
>  {
>  	spin_lock(&fsl_chan->vchan.lock);
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 4c86f2f39c1db9a812245fe85755ec8d1169c44c..64b537527291795964a77a9021192a39756b6987 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -478,11 +478,7 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
>  	return container_of(vd, struct fsl_edma_desc, vdesc);
>  }
>
> -static inline void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
> -{
> -	fsl_chan->status = DMA_ERROR;
> -}
> -
> +void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan);
>  void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan);
>  void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan);
>  void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
>
> --
> 2.39.5
>

