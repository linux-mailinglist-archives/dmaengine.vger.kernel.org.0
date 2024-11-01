Return-Path: <dmaengine+bounces-3669-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A509B9776
	for <lists+dmaengine@lfdr.de>; Fri,  1 Nov 2024 19:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B2B20DE2
	for <lists+dmaengine@lfdr.de>; Fri,  1 Nov 2024 18:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A21CDFDE;
	Fri,  1 Nov 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A9iNmBh6"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013028.outbound.protection.outlook.com [52.101.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14F196D80;
	Fri,  1 Nov 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485661; cv=fail; b=rutDmN0bNHnHQI+AWBBbtuc8ELvHhh8A+wGy6M4mE5ZieRjv8GWqf6qjxAeJpItXWsCBTD2Hmyj774EF3Zi63ITCBBGYwv95AAJZKesnEpbjR0EH6z0J3PReeOLTrKDYbKg8eWOoSv7RECayp1vl9Y/jhP6yRA3owRTkDxhShBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485661; c=relaxed/simple;
	bh=8cBTTmLZwNHkXqiD05BTYOnd7A2DrgygG6ZtkeFU95Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XLWfydCwmBqzzS71EjD6JAKIaPMmUw1UcLKFGdBdugd3o+AYnQwqFH92O+0ue7bAUJ0cRh+Q+vnE2GyZtpNDVmhrHkDNMfsTM8htsA+rI0jpQRTqniaWskBG+bXiszOapEP1gyj9VSaT8w9f5YNYJZyliwXpgqUeDXoWzbFLfgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A9iNmBh6; arc=fail smtp.client-ip=52.101.67.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0sZXyIJA7iWn+Tqhobsq+y//h6iXjAtnBS/qzsYA7TZHf4Vb0CqNVzgVf4AkIpNkGsqVMlOyawF0aQRHRhg4g95w2yTC2WpoPZ8UOIt5hsALGYnOSDZYBObk+op5mHbbqqJ9co3VTmnL6sNQes3UAv+GWfkunKnXyDvowthfX1CnJ3/UDjLgbJQrdFBixtcSIvWJ3lb/KaUi5p92lor1oCbtjK1mCktND8CL8g0Gl9rt+3qov0VaYVkVq0b4wJq3/yB9V7mw4SgxcD4IVuDsxepiN/dFuuNmftdc8CLBHmH0PeB9KY3XyGEAKN6suJ1f9qXPbkYW+9eNLJTrACd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8FUDokLx9D2shlDS2yCmohbNZQpmAtm7GnIVHNAweo=;
 b=xM1oCgaRZ0y6/9kAwTZXwWkXzfa3GxnLq9pmvewrCqrJ6AADiV+fZCbnwcCOqYv57SLTNRLF61iWjvghYECMjomOSnmldNa/JvST/1hE1mnan1pmVEP8gEab45qxfPCKBobeYjIKLwDwOO8fsWhBEOsaMGScUN2UMKjS0OsbLG/4dHt2V1AE+ej9im5L54Fx9BUIFGeNYUa7B3GYf1vQA2bXwFGaJoLApmUoKDC6Vd/jIpGaWECLqi6rkbiUfgHBqPpGmjy18r2E3LHy8gnhcqHOgcRAZX0JN8p+JEkCozKN/lWeZpTzHXmWQj3EaTn09/aIjdpoeQcVRSMq5BgiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8FUDokLx9D2shlDS2yCmohbNZQpmAtm7GnIVHNAweo=;
 b=A9iNmBh6kylUNSJKvqbcErHS0y9KTuMynI38n4D0dJRnuPD6Wv8Sugr14qlFDFRuhjpkf4ohFcg8jusYQg99zcUELDWcCMoJp3vtU0Wi5zONWqAcNW+rQegh3WRfYTXMl9Pzdeohv1ss+/yODEw4ZnJ+vQHvShyVmbRBpS51gqLUEmCJjUKAIQiDy/FkuhMwu/1wAraulxL0tMeWt5Lxn0lHbmLninTOZHuONV+2Gjz7U2hIkIeYVrOMr02mOHsqOftFu9n54QG5sK9mSNQGOEsEVrpQJv/MyHnXueuRAhdxZN+OMJ0SfsJOypDxaxE9R4EgVnYZZ3mP6BBxkm59tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 18:27:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 18:27:36 +0000
Date: Fri, 1 Nov 2024 14:27:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dmaengine: fsl-edma: cleanup chan after
 dma_async_device_unregister
Message-ID: <ZyUdktvfqAK5IIG9@lizhi-Precision-Tower-5810>
References: <20241101101410.1449891-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101101410.1449891-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dbc30f-d42e-4ff3-625e-08dcfaa2dc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dfE1qnH4J4OnaMdkk+5V5vic8/mpxmlrd6PyFsai7a/0dD13tIOB72jr5GD7?=
 =?us-ascii?Q?xIPPwr/Ka+VakYDiQaM46PeYc4b6VDiK9CFYxMAQgSnAD/W2UB2sdNOumPqT?=
 =?us-ascii?Q?nnRzIgsaPyFOtHTPSvtnLUM5Uy06vAxaSd9MCmkFTqKxNcf3MlqNjhx/yZjN?=
 =?us-ascii?Q?PYXnis2qoIxOGkhC6gVsmmrLsXL8TlBm0DjRuyRNv8rWjq/4v3heI7stQnNn?=
 =?us-ascii?Q?xG19+Nb5ZMZQCPeqe462X80JZN9BzI5/g9CTBLmp7AM3zwV8lysvG+P1dILw?=
 =?us-ascii?Q?jvvctUlqNAZlAhf7wKziH4LA1j1s4YG9qutBH8yF1mstEas2O+L8qEsERXdT?=
 =?us-ascii?Q?vJYuAvQwgwBjK6j71Zm41440DuEmC1vokdO+PS1RbZBJ61Oc8q+jiCSujgI0?=
 =?us-ascii?Q?yadF9+x2QO305cKjr+qRZmFpPoLVf6LSyGdoLNQbuH9/4BPNxsV44XjdCuu2?=
 =?us-ascii?Q?FQCLcFv1co2dphhfAOfgEkLwQPWb+nbszKJwKcSf1kosDaE4tQA3QjJZCPzE?=
 =?us-ascii?Q?lpSESzKJrW3o7Chf6Kcu0Kbn1MW6rQIrf8tAElvo/9Q9tPyzVJZvhQObwvjZ?=
 =?us-ascii?Q?dTAfvpxdHacQdF4P+nIRnN6Nrau9QzXjKnfbnVEja0uDsSw3JmdUnvQ8Y+l/?=
 =?us-ascii?Q?wuFRTFj/6GJz06FALu2Cj5U3GKIAWvrmpZ/7uTh+0LbBvoF/djQFD9G7MXni?=
 =?us-ascii?Q?r4P6D3ag7ImKLhztNqKLupcXZdJ5j50yXQ8foJ9kkkBhGEviFq0JzRVix5Cp?=
 =?us-ascii?Q?NqwFkHB/x0MObdRYe9hbQ20PDAl16yzcD1MBY59G4lYiOA/dBQuuEcoD8zKW?=
 =?us-ascii?Q?X0E5kbyX/qiGOFurU6WIQF0Qmm7gSOsPzuy4Qa/67z7n61HL76/LUdva93m/?=
 =?us-ascii?Q?G5DNSP1XIjf7AhwwFh6w30ZQB44N3AKXCVkQU1DqDCTXitK3SuKJPqJUOVwj?=
 =?us-ascii?Q?S8Wdg1GBsVDSx0SXwbqwmuGPhYmEEq0trfI4HCOufeFPEofcpSH73Jtmldbk?=
 =?us-ascii?Q?Kn3JNtv+wqeT71m7TOYv31JRHE33CQtPxEw3TLxEzdKC97EPCBzh7hVUCqfB?=
 =?us-ascii?Q?rOOrNgGFxGm8GMjYZyiz0GRw8yYvbK9YXfw+RwRyR7kN1ezo48jDeKmPn58U?=
 =?us-ascii?Q?tQy5ZfA0GfZncM7ZIvj7zBd7pWo/nDm0lMXTCyVxoLcDLeVttCtitvE5TvC3?=
 =?us-ascii?Q?4En+Y/zJd/z5yISxkJd4AbOtzSztGE1GZvmyBIz13ru39AxzL1KxXWShme0x?=
 =?us-ascii?Q?qfjjzeJ8NeWkNeg9rredT3zTIt/0159kVaugq5LThWyGQyPfW+rJbivzc2Ms?=
 =?us-ascii?Q?gc09JW6b+sIgUx2XkqycaUmxLVQf3kuTBUGZXN9v0YsyTfFI9zhjiihzQdZw?=
 =?us-ascii?Q?yduqIkg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IArxvZdt3N72uLl4f+8geH+wFmjApkkdZeYkntTeEgN8OOXJLNfPs4UyMiyl?=
 =?us-ascii?Q?4sNMAdm6f01amgHGhdlWwzl1FaHQH1eYifuc62i/4EMhcrEQzWya2bkfQyLf?=
 =?us-ascii?Q?ohRHDFHyyn/4aTh/qxdEADfM67ysU7KyREjqq743nV3BjAow++fFSQAR3a1y?=
 =?us-ascii?Q?d6lCicypkKHXh5OG7J3bhugFArh7rlSyiRoA/JHv3qpGSaexVoPywySQ6xCZ?=
 =?us-ascii?Q?O6c7BB9byau5gpcvxWGwX1n186DXBw+w5L19SO8balVGkyfwpuX52njjr0e+?=
 =?us-ascii?Q?fzWzyo7+jOaPUJ+zcnAgA40kbX+SBTnWc/0mAeCMvvjmseG+Ije/Rga6cAu3?=
 =?us-ascii?Q?L5qR5aslp6+AYY4An7HhwJDbsmtrAq9XyvDBYCPxvYOOVzoUfTHcXvBu51Fh?=
 =?us-ascii?Q?Lc1Hflax1z2NtowAVKvV7PzuU19u8KivIkglrbgvP1iUlXPpK1HUiRuyL7Nm?=
 =?us-ascii?Q?i2tBwE5uXj5XfZ438oVv0T4YHoz7aGLfs3D4VdJbzaNbYdIAug8F+Q76ahcu?=
 =?us-ascii?Q?JeV4EiDTiRyrqgvo052paup3ySdhWRNVs6gpgfrD8DyFAc2O2CJB0aGjsvFd?=
 =?us-ascii?Q?totY9DSaYtFp94y09CcaJUMxjwkTgArs1coK5+TolB4SIy26cz6sPRBLISWT?=
 =?us-ascii?Q?WHOAWuCk5ZXoAjORJXKNXeNAFVkE2v3n6BzRVe25cxMv7im7igpF3HZoO7gT?=
 =?us-ascii?Q?NYvTyQXtOPmq7x35q/oyAOoZ3VmTwUKQCW4j6m0msK0NxmQv6y8Fz8cbEH87?=
 =?us-ascii?Q?H3gdBkrgX3wScjYNfS72yjn1zyUgBwP0lGM/V5o9pCmph//mbFSsQdQFv94H?=
 =?us-ascii?Q?A51CXsXrPyMKvT4Zg9agXlrcG6VSYFRgXm+DlX//sBgG9MIekfw+2gMkm/SX?=
 =?us-ascii?Q?M1Ea1rrOac2zS+5OSjPY3rtB3TGfDF3aylLNH9jqNuHSeS7mo/8xeiYbERWu?=
 =?us-ascii?Q?55tH8p4Dn+ra2e+7xJS1Ci0SULnO6Iv530rY88rUqEZKuyUUcCjJ/mb6w7vM?=
 =?us-ascii?Q?+FQvu56l3SiRTBCG0++tQAY/v7PW8fAH9JzqN2h+/vC8RgA7ccO4PpDIX/9f?=
 =?us-ascii?Q?T2LUQye4mMDFp08iYkh9hIY8ZVJWKGl7s3zljHz9F2IZBan4RbJQcm9k11ld?=
 =?us-ascii?Q?xlEe0+uBu9rQ+uPwvfOzEIXNHMlQwo95lIKfdLKuzqdyQpWBmi/ttQUHy3nV?=
 =?us-ascii?Q?XzAgUyRYCLVyOgvlZKOHPqEqEUxe2+mek/PFMR6U+MLAKtLuOcM1qqBLhvWN?=
 =?us-ascii?Q?O8V4pGAjdNlUdO6gx2JsMyUsMHJp7Fw+XodwqtZYXfNXo/PDY8LeACx6Palg?=
 =?us-ascii?Q?5PiLnqcZ4WTTK1eCO6U5DmHXQrtntnXJPQypWEICfW5blbBPIUzbvscqijSw?=
 =?us-ascii?Q?Q3To6fLco/SG48aKawzwo8SrS984/ZJOrYN0PRqBCVpLjE52sXZQ5t2Ft29T?=
 =?us-ascii?Q?GV+IbsunCq/h6pK8+TJUxG7K5nX63DGlfLt8uhLZWu3lUiBrCx7xnG8edV39?=
 =?us-ascii?Q?uFo2pa2OJtQiBclG85J9th8tuhPabafDTjCci8jXYTJIi6fJZQ8VL4DUZf73?=
 =?us-ascii?Q?8TjpCjgBkkPdEwOY2zxIcGrpasQBmGFhsqludg0r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dbc30f-d42e-4ff3-625e-08dcfaa2dc1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 18:27:36.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfbbBXdqI+1Kt0qegkVsadsdbK2DiD/7V+rTqC/36SCTamesDCrGubOYaRjRgLHA0z6/yVx8wsV0cJqLhFZ7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821

On Fri, Nov 01, 2024 at 06:14:09PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> There is kernel dump when do module test:
> sysfs: cannot create duplicate filename '/devices/platform/soc@0/44000000.bus/44000000.dma-controller/dma/dma0chan0'
>  __dma_async_device_channel_register+0x128/0x19c
>  dma_async_device_register+0x150/0x454
>  fsl_edma_probe+0x6cc/0x8a0
>  platform_probe+0x68/0xc8
>
> Clean up chan after dma_async_device_unregister to address this.

Can you explan why move it after dma_async_device_unregiste() can fix this
problem?

Frank
>
> Fixes: 6f93b93b2a1b ("dmaengine: fsl-edma: kill the tasklets upon exit")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/dma/fsl-edma-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index f9f1eda79254..01bd5cb24a49 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -668,9 +668,9 @@ static void fsl_edma_remove(struct platform_device *pdev)
>  	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
>
>  	fsl_edma_irq_exit(pdev, fsl_edma);
> -	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
>  	of_dma_controller_free(np);
>  	dma_async_device_unregister(&fsl_edma->dma_dev);
> +	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
>  	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
>  }
>
> --
> 2.37.1
>

