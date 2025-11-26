Return-Path: <dmaengine+bounces-7361-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B1CC8AE59
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 17:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2123A1EA0
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8CA33B6FA;
	Wed, 26 Nov 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aGBZ89US"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B383093CF;
	Wed, 26 Nov 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173584; cv=fail; b=kmmAgA3AsUXdUKyyoXHIrhN8Y5wmL2jbD32vjFWd/xqHFO5r1kMMNxfH8NLo6fA3gWSwZZrf7R+DHopgngkyuMoso681cLZhesrUs9vJxzjW556rqwmSk7Qlmj/tibGHmFizQGH49trwNPSa24UhUWNLryRc/07Bg3c9uxjY/gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173584; c=relaxed/simple;
	bh=H6luS368II2Q6/LIVK8y+F1XreXqSKM8/v2ihRKXUUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jnIisci0mHfKUvcKE1z9mVOZRB1GGsGjw8CbzdWbOu/32fsXWKjB6wZsWncrjXgUV3jQdnPADLr838VHYPuB1rD/eZ+FOz1jia3NAYiqkHDtJcakv7oAi/N8BbwlGgA4JZ4T1iRHn3+x5qL3vjHfoRZZtmXYfgic14AswF/ASVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aGBZ89US; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfGHayaXaTSN9ox8xOrW41VA00V0dRtkEoLBG2FbXYEaZlk9U/l09OTmT4VPxfBFq2svWIGm++8uCVqYuhXhVjuoTvD2nm1peZiSFQE9zPrl6JDXPsnnALWzq44oueWpHJ1s62tXfT098NjyGGQf78DO0TokfQcNlUY+6YXnaClAk5snKe69N4hDZiYIuHg9GY9bmg9Jp/LBnWzd7aAtIrjHk4h77xMrZ6DUIMZuL+UmdMlgSVpGpOjACQsL8Ufn/8nhiraL9gPGjYvm/Cv6kaGoBtVSjN5UWzvZR5BCuXQbYna9NxEk/W7qq6zlWt7nyJyBNJ4b8lvvAcrm21F53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwQYC+HSccIpFFcts+Hn86G9qpq8+AUrtoHsKI5gwpk=;
 b=t7QL5flHNytO6dhGbyyotNrDliSdDeQMhicC3CntsLWV3xqTeJrwu0lTfAh7DmkTgnkTdrc1vjleJExhg3EGJawWZgi5xhJxMPrUBl/pDBX6z+/Qfbfg5QqquLTqNrcddVvqGfagMvHZCU7X52Fh7+3R8RXEVZXyogyO277VC9eVNZcTLpMF0HPuiY+mCJmaZjllUfSNRgL8QEC8wIgmdE5dIxQqh2+6ijJ8k6zljX2ZafpkvG6b6T18FNL3ZPzVYkTuTkIqSqAjOd0b4tJfM0ChOnGu7Jkh1I8p4aW8o5X3XxqRIezbqTJ6X4xBLheAb06o15BZDvpVQ0QfeLJ7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwQYC+HSccIpFFcts+Hn86G9qpq8+AUrtoHsKI5gwpk=;
 b=aGBZ89USzS1JttEWZK8JrFqbAqfXRNwHJdYJbJaqIS3dpYFsM8fiPaZtM4fDmJSLM+hI3zfePqbXhnis0XOIGRO3YXnWMiu6WFujREKiBoWXK51FBgHWJmJfgSihT2JECdUeWxXEqzKAAAEIFZzVUsArqw7uaeh7w4c8HiyoR0rEc/cCpOoz0ZqxI515X0WaGLG+P9e1LWRVKpqDkz/WO2Gn31noezSbFULNKwB7R1HzOPBso5Ed5tXtye47F6E4W4vV0aMLzvJz6o5714y81MDXjWdG+nrPB1NmyV5WIdp1QEh3A4SRKOuUJ3QyGAtjov4tYfncsgvOrO/bToT/lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 16:12:58 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 16:12:57 +0000
Date: Wed, 26 Nov 2025 11:12:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: jeanmichel.hautbois@yoseli.org
Cc: Vinod Koul <vkoul@kernel.org>, Angelo Dureghello <angelo@sysam.it>,
	Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dma: mcf-edma: Add per-channel IRQ naming for
 debugging
Message-ID: <aScnArV/22L5VmxP@lizhi-Precision-Tower-5810>
References: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
 <20251126-dma-coldfire-v2-2-5b1e4544d609@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-dma-coldfire-v2-2-5b1e4544d609@yoseli.org>
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBAPR04MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7a66ad-a5bd-4489-ea84-08de2d06a9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JhR2RVKoaOvB46y621jOjsrdCUZk3pNyuDxbf1QOzkVqQKAqloU0W8sd44z6?=
 =?us-ascii?Q?XoHk2c45knHTfBiWQ/dyB8YkHAIPwmqM7teZP4stihO6s4cN/bOUDeb2gubq?=
 =?us-ascii?Q?yrz67fcDHcufzWJcbXPZdKF4cXNUAfjS6ZLqdYXQiLSLUbrJSbKU1LE5puVx?=
 =?us-ascii?Q?F4g+xBVhLnfkZctF9IpqexE7rmYCU5vnJEsmlECTfvyOB35THjtNLGFkbBlI?=
 =?us-ascii?Q?Gts0StVucbjlpaZwl6zMWnIviMMnaeoxeGo6Tj7wh4WIuanHguzVxBxKB4NP?=
 =?us-ascii?Q?NEsQwzDIFA+reeQ6636zylQyeGjjAs6Wk5DoFymLtsuM9P6JgQahD682UUY6?=
 =?us-ascii?Q?PgKlN5PSgurXwsK0Pn/HkIxvclUOi0ssDL3/TCDe1N3tDFiSMsogVoKD/IMq?=
 =?us-ascii?Q?CXGllAK/XcYtjWa6FCf/c4wwkd+zUFKhzOr65PTQQbz9vG1GypKw3z9SDCm8?=
 =?us-ascii?Q?b4RlbvTHeGgnaxpLjzhMs0o+0Py9UvZ4MjRXsZORDbtHVt13OJZlZJM+T6ji?=
 =?us-ascii?Q?WUHHZY6hxPFJMwMTAECcJ4YOXiPEN+p1hA5zOwr3h/iSXgQCL+Rx14CwY+A0?=
 =?us-ascii?Q?Y3SUMl01n+PxPnObpJJm+8Xxt7AAb/K8qAGVjO29C5AIlAiBjbZQm54JiDZ9?=
 =?us-ascii?Q?x4Df7j/LawLSVgyW/98xfpkketit/htI/yZPuNloygcvksA4sBIW9tDuW0ng?=
 =?us-ascii?Q?KxHhmGAJn1FR5p4XUEbGIRZv8yUgjznf6scM9zkOz9LbUOdxYzxPHxltElVs?=
 =?us-ascii?Q?YpPTcPJZqp8v34kdwtooqJwsXygCU7gM+R78P20pTklUlmW3k3vQ3Z2ViA5Q?=
 =?us-ascii?Q?rta7ng3q13xqX1JDNtdlvWPWHxbFTJ+na5jsAawEv/j+dkPoaY6eZlcuqlg0?=
 =?us-ascii?Q?3PL7NyvlboVhsQ0lzzcie3Euj5rEk8cJe18xD9MQDf3QYLWXzLJ8uX1g+q+e?=
 =?us-ascii?Q?PTqGmVrzz5nicQCAp6DR/ijF+b10dVbvfljrKGvMIpWH6BE7AzsJdkNoyaEq?=
 =?us-ascii?Q?0NCkoRxENjQ8IGakBqKIurhN+1h5fe7Fmj31fLXkLqHb5WZZI9Wn92MuLBok?=
 =?us-ascii?Q?9biGaHev/E0SD4F28DBenAv3WznckY9lk1uwcwpq6BHPA3Tg27NaxMC2ODFR?=
 =?us-ascii?Q?LZu+lNv27LCGhmnli91plSWirEN0+w+zgZUhEitg8iRZshhGEdcrTzPgZzw+?=
 =?us-ascii?Q?WT9y/7gDkHlKaUkf3CWJczz0G18wvmYwzLwFhG+1QD054ySdP6mocG9ryA3n?=
 =?us-ascii?Q?poFWnPdvBsi+dk9duGJfve3VJ2S05fYYA7ZEkMUExkVlWHOBwbwMu+HaAkNi?=
 =?us-ascii?Q?zi1Yguu2mF6LXBZngYoJSBRDrJwR7vqu87VKnFXeeY2zb3BnECgO6IUODm1N?=
 =?us-ascii?Q?k1ore7rHwT0vExRQCrbpS43Pz8eYBfxOJpf91nDaFYGTlPEWqM4+MpHKxOug?=
 =?us-ascii?Q?HrN/1qj6ThFxu5RuadMJfLqfpnzbcQjVunaMkwFzEEKWhngC6lR63o3orVp8?=
 =?us-ascii?Q?o0f5O343nIvpOQ87KW8VSTz12dD/BkFnGpxO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OEuKo56b3hxnZQ/dWamXzWzuAkVAmbTsElkQUqLGGf/7pwyq0fd7z44dQ4+x?=
 =?us-ascii?Q?TlMARYMKXcrKufEaLfWPL4FG9h6dwuPoVS+XVDlMKB4d5+Hhc4rt2mPtdk+q?=
 =?us-ascii?Q?s148Zngbg9et8h2aGTOcdM3OhUya5EsPxP9XWUx3Alak0kqpQR/DLLhxVxwW?=
 =?us-ascii?Q?DHZwJh8Mapu8f/cUZTy7LiHAefOFSG2U8zWXmd3LYXnFdZDqt4ghx6h5V4Ax?=
 =?us-ascii?Q?e7h32D2l5OmNhB2hTTJheZTP9ejiUuiopVWgr0iTAKz8xfuaEA9Bx8/OB493?=
 =?us-ascii?Q?6J430wEkIultgz6wHZF7LE4yRsi6Z/ec4s4U7RhlM5Y/JbVelUNYnsmAdfIt?=
 =?us-ascii?Q?Px49JQQNEZ0DLgXuTjIebgbj22ZHDEtu09ZOy2VP1El/igyqbZNh63V84KXK?=
 =?us-ascii?Q?4yWXCcBKXj9LnSCKWEJ4shEA3Y1MBJMeIisZbiIP01Kxxi1rutG0hk+rrAzu?=
 =?us-ascii?Q?/CxlZW2/JzCyyH9sYXehjlQsWSqYi4I+21Ckhw689YGccR168ezsgwxOe34F?=
 =?us-ascii?Q?wsNFIqep1iQ1ckCdbE4ujM81MscUQcTTve+nySQv/G/0rm07to1vZJ1QJMIS?=
 =?us-ascii?Q?7fDiIKBSmbpIxzTebsvrMh1oZWAuQWQ5SkVHEgy3aL57lgijXW9CBPzWTNx3?=
 =?us-ascii?Q?DSwF6YnNNwyQ0ZOAg2smckdnE9ZhLNBJL8rrrWZ/SkuynMeqE+YtzlHIcIOW?=
 =?us-ascii?Q?glRvCHzBGoJOhTTCq5tjTI+Kc08lMLmztcRd9Wpq5YqeAdXsGZlHzTQ9wZOg?=
 =?us-ascii?Q?btHwpBnILGODXFJhc82ONgKondtdHh39+/xSbhXGezqtJDArbCONjotpXi8i?=
 =?us-ascii?Q?L/36NfyOvHJSe6uhLGMIS75nz2f03NmDU3ROiyStquRAlgAEgMNuA8iu5FHK?=
 =?us-ascii?Q?s4le2XVuVCqtakxdhBWlaYsapXitnSr6JWRdVNtJWQs01LJMFpj5N3PT+hAT?=
 =?us-ascii?Q?lyLfgRKnk9UZeNLJYTHwAVRB6U9csMtIEjLbu0OudxGWJLUWdGtHd9KaA/lb?=
 =?us-ascii?Q?A0N3jUZQzbMVtHa9CszbACJbs+WWsodJaT4+MtuGV/ZfDKV10XOymJtNjqBq?=
 =?us-ascii?Q?VU1s6XubGCnPI5/NwHhr2yK1bg8dqrj/2d6wXr3O5I/HHIRO/NSVO50r9VZ4?=
 =?us-ascii?Q?ajvXhRHx+PVBs/FchVQuNzjaIUiQcqW099phtZ5l6HsmVFVniEBx+dD7mPBH?=
 =?us-ascii?Q?k7xoxHDfdav7bUwgi65AnQuRENPUWlF+r3y9Uyh6SoBzO+RfgW1nhWKiH0U0?=
 =?us-ascii?Q?VidWe2SPeM6rbztW++Q0QWPZh8QSS5Ci+/6fxwpTIg8uYHVOrtWhneAwNdF/?=
 =?us-ascii?Q?sXzABvsWIv1ipUievIHsAnrBUxY5KNVdLztFNHFqI85aS52F8KJYfZwYfOqf?=
 =?us-ascii?Q?NSBdsD/p8zDQscEMEetjmDPpwV1tsmYYkHk43wF607LNAZYKx+C2DpwZhMQz?=
 =?us-ascii?Q?IBSBCBYVvfwdm9BE5HeaoOCnQAvclso5JXBtjdmd8hNoCjCh1ljrFB76IQJc?=
 =?us-ascii?Q?UBntktUuk3MmX9hm/C6TIp/htzl0QDpYZpuWasJq/ESgrapmtJtU5acpSDlr?=
 =?us-ascii?Q?gi54bSpZqk/PyRE62OfEdRXOtsqZYvwNc+9Fo5Ri?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7a66ad-a5bd-4489-ea84-08de2d06a9cf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 16:12:57.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtBjfdSLjN4sNBJ8YepElnqj+t1nmIqxOiIsoMhFsOjK37SXClqVV40f0mXXz2dTK0z6cFLL2+GqEuirD0057Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7207

On Wed, Nov 26, 2025 at 09:36:03AM +0100, Jean-Michel Hautbois via B4 Relay wrote:
> From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>
> Add dynamic per-channel IRQ naming to make DMA interrupt identification
> easier in /proc/interrupts and debugging tools.
>
> Instead of all channels showing "eDMA", they now show:
> - "eDMA-0" through "eDMA-15" for channels 0-15
> - "eDMA-16" through "eDMA-55" for channels 16-55
> - "eDMA-tx-56" for the shared channel 56-63 interrupt
> - "eDMA-err" for the error interrupt
>
> This aids debugging DMA issues by making it clear which channel's
> interrupt is being serviced.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  drivers/dma/mcf-edma-main.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index f95114829d80..6a7d88895501 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -81,8 +81,14 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
>  	if (!res)
>  		return -1;
>
> -	for (ret = 0, i = res->start; i <= res->end; ++i)
> -		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
> +	for (ret = 0, i = res->start; i <= res->end; ++i) {
> +		char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +						"eDMA-%d", (int)(i - res->start));
> +		if (!irq_name)
> +			return -ENOMEM;
> +
> +		ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
> +	}
>  	if (ret)
>  		return ret;

The existing code have problem, it should use devm_request_irq(). if one
irq request failure, return here,  requested irq will not free.

You'd better add patch before this one to change to use devm_request_irq()

Frank

>
> @@ -91,23 +97,27 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
>  	if (!res)
>  		return -1;
>
> -	for (ret = 0, i = res->start; i <= res->end; ++i)
> -		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
> +	for (ret = 0, i = res->start; i <= res->end; ++i) {
> +		char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +						"eDMA-%d", (int)(16 + i - res->start));
> +		if (!irq_name)
> +			return -ENOMEM;
> +
> +		ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
> +	}
>  	if (ret)
>  		return ret;
>
>  	ret = platform_get_irq_byname(pdev, "edma-tx-56-63");
>  	if (ret != -ENXIO) {
> -		ret = request_irq(ret, mcf_edma_tx_handler,
> -				  0, "eDMA", mcf_edma);
> +		ret = request_irq(ret, mcf_edma_tx_handler, 0, "eDMA-tx-56", mcf_edma);
>  		if (ret)
>  			return ret;
>  	}
>
>  	ret = platform_get_irq_byname(pdev, "edma-err");
>  	if (ret != -ENXIO) {
> -		ret = request_irq(ret, mcf_edma_err_handler,
> -				  0, "eDMA", mcf_edma);
> +		ret = request_irq(ret, mcf_edma_err_handler, 0, "eDMA-err", mcf_edma);
>  		if (ret)
>  			return ret;
>  	}
>
> --
> 2.39.5
>
>

