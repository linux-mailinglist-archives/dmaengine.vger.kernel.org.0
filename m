Return-Path: <dmaengine+bounces-6488-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A41B5524D
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C4188972C
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F29304BB5;
	Fri, 12 Sep 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LTjKOSth"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9B191493;
	Fri, 12 Sep 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688644; cv=fail; b=JJmySSUV/t/rctLHwqbqcW982GkkdjVtijrR+MR5UM6ooRLqlZItbWSjPsaS+EG6Rq7ehEU1HB/hhSoT6vWcU+XdsrWPSZL5vgG/YhX40QVvPw2XyVKGNBlTUQNrsNg7z2vy2tOkx06EL/T9+jMaucMEwNXfxiRSRXKnCy3GaeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688644; c=relaxed/simple;
	bh=+O7qbTv8Hp69jT6mf9DoFaT420LlHauvgEKZlfSouEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RMq6XQFO1TAjW8kQyWEvCoglqDCnWsMwXkD4fkJVLsfhnN22z7ZRrvLJSIWby0gQcGiKqYb2YsOiyvgYE6Eex8QHmG16Y44Pg/HOCDHkSJmkh6ZLeG3qqm4junrVfkTzX4AauISdbqBrxy1PtiUpxRmvEbeL5Fbev5ORY72vIqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LTjKOSth; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bD/UaC8CrnrHhnXPcTqgiNDW6Mf7Mxp7P7fplA02QIV9VL3qvbagJwpod57it3UZdw3QE+B199EU8VLufN5zkq783rC1qUX5ExV5oBGjnZzB6kD9kLZI6PxomC9Xdmc+XkexrS3wxCqOtVVRt99GrYic7cmP0KJ9D/c5+93/q1zQ0NITq8b2fLqr0yFD0EVoEXZ65ZHm3/+3bF70BZxIWu6rl+qtFh4LWito8Agl4jK3ARBA9eQEbkoHlrtbfKEw6Ghrj031aCsgi9FfQH7bRL/lUQi1r2xamey/eDk5w5jvaUxHeOZZ34O/v060T8XAnmO3I5DX8JZ0ppzgiSVplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVIxc1Jx9LxlFtXP66f2bqbQveejaiG6g9y7Zt+iMKY=;
 b=L/8HLrC3zndSSWRBr1iB6Qmwf8lT7CJbOHz23muea/SYZP9gJ9w1OAxhcZ1mEgt/YPD8071tT4FInyIbqIUmZD+fh6FINSZDxbL6ACcEEYgQuXJ5M5gFDzm/WcC84qeg9Xi5Ot49MiXQz+l785Ud97HwQiWCyHI9J5t5WZqI+ee4+1f5ZoCLUv5vqWP1c0sWLvwFsTG+mve4XmJ+YRF2H3NgOmjf8wggsMYMjGlCqB3c9aO/CY3X4BGWEMWmiktO7gyLxus2d1t77GdQvJl2WYlVAKyK5tg+CVPsEzXWXJIeOapAo08XthNpIn/S27WgVJ+HNlmlxvFdefe4dqcBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVIxc1Jx9LxlFtXP66f2bqbQveejaiG6g9y7Zt+iMKY=;
 b=LTjKOSthYw3cninWtBvVErte+Sdh3wS4JDba5qPjIgHKBGXcEpCgN+x44ofslwwpOSwk0crWfUJ51561hHA4lcyPbH5GIKzwvCAfCQV/eMzXx68vdzoMILavCUVKVLZH3dcAuN5Pcx5Md18fgMzfFWHsYv7fe1yhseB3TjoRwVaO33351UtjyqGqPC0GEAKKooQ4kC47rbsc7ASB4keHi3J2OI43lVL4r5X4BzybR354nP4RWw7Oh6f2ej2xTcfuL9XnQNG+kc3XLzT7OfYot4+FrhBThQ4ead5QRyun++qcLVHrqwyAX4oGgQwrmysLCwTG4MItmV/VlCbNpoM/OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8834.eurprd04.prod.outlook.com (2603:10a6:20b:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 14:50:36 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 14:50:36 +0000
Date: Fri, 12 Sep 2025 10:50:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma-controller
Message-ID: <aMQzNDE8QuUZwGkt@lizhi-Precision-Tower-5810>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-9-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-9-d315f56343b5@pengutronix.de>
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a186fab-7d00-4655-5f95-08ddf20bbb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|52116014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m0S8G9e9MCGOMoNYSjIaBOEfltSPYaTXS1gMQzIxpePDRe2WTi08QTeS/oPv?=
 =?us-ascii?Q?0RSYK2SHzC08UfzPBlDAyQesjgxfcHlsG3Qhss+51mZmseLlzUH321FdM/1T?=
 =?us-ascii?Q?otZB67GMDh3O4WM2VZZ/ttfpSvs/kRenKcMhxgdO6x2gnOOD3M58Eb3nW0Wg?=
 =?us-ascii?Q?czTdoEq2m50UP7Yg0N7WYVnwiy6v4JzAQDUQzf8QQxnkNejiq4CgWOxjZxCS?=
 =?us-ascii?Q?pL1fuAUaYoQc4bdLhYkm2pHo+J7863KnZz9OGJ9wRPAsHhbbOu9FBxIwdUBh?=
 =?us-ascii?Q?cq3sIGlorsGBtDsCRU4nGRMfin8WpH38ExpO8MzDddiW0X7YQxxnc1PQQESO?=
 =?us-ascii?Q?vCzWWvXT/fjhSjtPmEQVzLkWfOg8geXeLY/1TuVB2A8N87pFDKd/36vA032k?=
 =?us-ascii?Q?7HmeWCgyco3xJhX4jZ+A0bhnjx1r03g5iT2de5oOpJYDDD5G8sC2o2CKm74x?=
 =?us-ascii?Q?WOFyw7wiQdSBnDKN16GtuFpPJGGQ1oJiz0m1b1LZ8oyrGfIYaN5fK/gfJbwS?=
 =?us-ascii?Q?bizviua8MwmZ+VSSFzQiJYmD+43V3/i5w6i7n4WhSue6YWk6F7Hh+voLFHqI?=
 =?us-ascii?Q?Xw21lT+u6yOaoV6fSAvrdQf/WCh5QzSTV13fA/cfcsE4AzlrdMGLh4i5Du6g?=
 =?us-ascii?Q?QhSGXkc4MM3Abaqi0OBvEQ1f8jVcfPuPXojuC8bokFkC0TKARHr+/o+PLaQv?=
 =?us-ascii?Q?YT5+FRD15Mc1Njdm8QHOS6DqgeMfnlCoPXhNTVH762tdy6BC+zttxy51uxGw?=
 =?us-ascii?Q?P5Oul8qe0hhJPD1P4jSzSq417hGHmJWeYFdbqDfps3O73bQs8qIf4cnzcURE?=
 =?us-ascii?Q?YCEhq2WDGWeuV5wRNwxjcLX+fgBjZwwAJEMwOkXpwlPj8wCWdtZuhUyJtOvP?=
 =?us-ascii?Q?4nOrTzP80qz3Ysp84ZtGfgQ+rJMuhT3y3Ac23UGnGMNLpp7RzvirXX/dJuFI?=
 =?us-ascii?Q?Vkk7XWS1IeMjAMlpt/NsYLsMeuwNc2Gx7Gjw0UNGZAlklC/Ett41OKQcd5Q0?=
 =?us-ascii?Q?d/80bfq133vOekTZb8aS7HwptgMJbq2qk3aNZrXcm/vh6YYX91VD6UEqyfQ9?=
 =?us-ascii?Q?7s00uq/ziihW9BHRbMX/aonea5SU3Zm9B3G3Rq2N+oLtVvrDQu0jzl/lNBCy?=
 =?us-ascii?Q?CsBFi+Dvl3SbwOSWPQauIhkN1BydSvNlr37a1YJosPgmn8T92qpR3exZbibx?=
 =?us-ascii?Q?3+C8qbswnXXZCn8XadurfVfCoG9gonvbr4C95Fbwappo1ou4I4W06DRRcMd3?=
 =?us-ascii?Q?eH24NUDudKG9O2l7G7iDpebvQ9Dg4rEma/vqbp1LMDq36kxeXmgl3xrUoJ9n?=
 =?us-ascii?Q?VGApu9fLeLvHJr5SZZWzZmJBEn7A1ce6PhY2oKIrhEcdW/fK7cSXQMllFFYN?=
 =?us-ascii?Q?fushVgj9GrO0A9PR3++pw9A2kvbn99qefwnc8qOviUtb1ZFUhHziTZQxwZXm?=
 =?us-ascii?Q?+vKzVdfEUGwCMYA+3IGe8qiNZy/qt5bY0iMJ3xYfYOLjnUZsrB0vNQ+5iLLB?=
 =?us-ascii?Q?PUZM182/CoT6M3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(52116014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KviOxFuEE+YyFGbJonAOb3STjG2Pid4T0pf0RygnEvwQyiG3YzRyuWhd9gYn?=
 =?us-ascii?Q?JukPmfJ7r7jxfrw9lZ4TFKj+45x3IEMf7yHCvHZfD9x4Yfwmkgt02jQUc4aG?=
 =?us-ascii?Q?ZOsCLqR2JNFZvDf4asPoW6Bz6Sd4QiOKSLkQ7uMT8r3G0aiyhJM9OheCsyUX?=
 =?us-ascii?Q?H3PTqErMIfzny53khpYmM2vCDrp3Hpb1ppYrlr9E7tdszI0MBnl0bW5uSMHE?=
 =?us-ascii?Q?1ecThF6WIkdTtpLDHBjMKpC9IvW5UEwqQRSVK6gqUXj6XMPwOn7BIF/4cmL/?=
 =?us-ascii?Q?9p9gTYx0WCT9hYZqs8YQCBkB+vXS2ZP+KxmRBzdwTINM2WeB0Ls/1W5g7BdI?=
 =?us-ascii?Q?3bJQ5VnkTSMFSROcw57fGxEo9I7hFzKK6v6qKlLmN55zj9PpVMXMmt5Yf9TE?=
 =?us-ascii?Q?idq1KEBzOGIhNoNhAv5xy3CMXcts912UH9K4SUxwxnqYzYIbPPdG07njddDS?=
 =?us-ascii?Q?2RN1MoOcMY7PxlNijDXJ5yquApjBuoaCYv8POo1hu/14CtZyBTyDlC4VXLnC?=
 =?us-ascii?Q?CHDocjOb2qR6PtJEgSihfL1iKvrxrB9VYPWfOoQeMmxCn/deyf8kRcScVRQF?=
 =?us-ascii?Q?ZPxGO4DEBndLh64O1F5D39S5sS72oiLqwVdRu//CIKBVyOcheU8IFiJF14/M?=
 =?us-ascii?Q?bFPtTUt102epmSrRBs+blfm5TfsXaXmiR1fCAboVE5s/gC5vsnmiC/2fSIaS?=
 =?us-ascii?Q?LZeYgZzQFyPHyDDHVeQvRFOtElbITfK+H09xfrIRx0zZtMweuUqc4R8p0J3y?=
 =?us-ascii?Q?mucmYBeTNyAyvh3BAUfcLruavUJA8x/7aimyDPYtgeEBlklYupn0SSDMA5RA?=
 =?us-ascii?Q?8fKrQkN2r7HG41X262b3y4gCW5Bx3UfPhSNzwsv3H4eQSgb22guQmci1YcsA?=
 =?us-ascii?Q?c6OXxshCRik6avaBUwQ5aRHuNzcZN/kXc/qtOm+VUZp0BVLiazVmb7zxfj2v?=
 =?us-ascii?Q?RW2bcQ1ANg9+paWhzNEh6HlBzKGFXlEFnT7jrs3WZv9eujFyxmMz6/fEZevo?=
 =?us-ascii?Q?X14iQwMfU3zJpGW2/hgw5nxhtYI9Wzh3tTW30UYMbx10qhDI4hRXQR7JEc89?=
 =?us-ascii?Q?Qb45nqFgDX2RMLyNVDjy/A14jyZgZvOqoe7Z5JNz30oENF1aIQqq1oAbjtbV?=
 =?us-ascii?Q?QhrO+vV9iQo5ECgjd3Zfq/qMq82R380mQYs+5RdluZA/ac8yv8r7NhL9Z4fO?=
 =?us-ascii?Q?DnCdLk3r+LuDD/ShELI1dztFpAFVQjfJ+UhJBrBp7lvgwiz9j38s35qllwOV?=
 =?us-ascii?Q?nTcTO21eGmBhvjgFSWJrX/QPCQaGrcBC602NXeMbHyfYUhoxNSvT9GSqiw9O?=
 =?us-ascii?Q?kVXMvrAdmRPYKeWp+bKTbEeT5KvZgHToRxUE48JybyCUz3L1gL/0lfXvBGRf?=
 =?us-ascii?Q?eAAO+A+BY3xPJPikNyrJ7F6yZeQ3XkGdOnuP88oPTaUbgmVck5ondiDeDuGc?=
 =?us-ascii?Q?7owvPkBopR5JoF0ShxjSxhnrI23Iicuh+BN630E4K7JQaumG02l7XH7976bk?=
 =?us-ascii?Q?d960ntJ0jvihP7apzQfAjdt/Qlk2RcU1WfzyfigNjp8RXotWx0UFFv1EfVoD?=
 =?us-ascii?Q?M+PxvIBQ0ZtsHkaqJkCBaHSRuoTgoRX0U1iwfV2a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a186fab-7d00-4655-5f95-08ddf20bbb8e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:50:36.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRSHJbGjPeWAxQ3AF6uUExyBOXv4867pau2Rzad3hesT4554sS/G8RE5V5oeOb0bauvgye2zfF5Um1N30uYp5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8834

On Thu, Sep 11, 2025 at 11:56:50PM +0200, Marco Felsch wrote:
> Use the devres capabilities to cleanup the driver remove() callback.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/dma/imx-sdma.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index d6d0d4300f540268a3ab4a6b14af685f7b93275a..a7e6554ca223e2e980caf2e2dea832db9ad60ed6 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2264,6 +2264,13 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>  				     ofdma->of_node);
>  }
>
> +static void sdma_dma_of_dma_controller_unregister_action(void *data)
> +{
> +	struct sdma_engine *sdma = data;
> +
> +	of_dma_controller_free(sdma->dev->of_node);
> +}
> +
>  static void sdma_dma_device_unregister_action(void *data)
>  {
>  	struct sdma_engine *sdma = data;
> @@ -2408,6 +2415,12 @@ static int sdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	ret = devm_add_action_or_reset(dev, sdma_dma_of_dma_controller_unregister_action, sdma);
> +	if (ret) {
> +		dev_err(dev, "failed to register of-dma-controller unregister hook\n");
> +		return ret;
> +	}
> +

return dev_err_probe()

Frank
>  	/*
>  	 * Because that device tree does not encode ROM script address,
>  	 * the RAM script in firmware is mandatory for device tree
> @@ -2431,7 +2444,6 @@ static void sdma_remove(struct platform_device *pdev)
>  	struct sdma_engine *sdma = platform_get_drvdata(pdev);
>  	int i;
>
> -	of_dma_controller_free(sdma->dev->of_node);
>  	/* Kill the tasklet */
>  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
>  		struct sdma_channel *sdmac = &sdma->channel[i];
>
> --
> 2.47.3
>

