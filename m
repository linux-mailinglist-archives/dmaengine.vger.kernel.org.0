Return-Path: <dmaengine+bounces-1944-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18538B005F
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 06:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5B22871D0
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 04:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3602413CFAD;
	Wed, 24 Apr 2024 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MZSn7ZqL"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC651E898;
	Wed, 24 Apr 2024 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931633; cv=fail; b=mfTe/9cPHhbDywJavlcDXTiaY4a6OrEjxF3EAHl0Lx8SuxdY1jvg+Dhakf4a1wIPlB7kUnwz6ZN+X29Rb1NmRm1JHJmYEVQlEx+2qXq/ZGNgjeHQyHfsE8PRBrC6YOMW3z/4b2eWHUsT/qlfvztq31Do8LRe5FF18SQrsTQg+yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931633; c=relaxed/simple;
	bh=tDZPv1tFn420Y9J46DV60cONjh0VpbqSl/RPwtX5Ums=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fxTc0TNnp/7hfyOWTvJAQC1cE5GQjm6aGk6vdixC2MYy3DaenVk55Xv6ZfmL59kziQrkNiuo6k9cFB1+4L2CE4Nk1pnHvKbsoxo3gBE6fkNo43sqGNvWcQn/qSQcMdgTBEnzcKw4jeaGF3Ls2S15eXhOEsmJhkrINL/Stx3fwHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MZSn7ZqL; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs9rNgQFAX5mIvyeD9kLwr5PesTmG5KjB6fUPgAA2PiCEFqgV3qeqzj5gWyHjHRHnHi/leVZwcH8MNjwhPw3KGqs3GsupjTmVmCdDW9MtIIG4mOh3XWeBvLDgPyHHqV8dSzOuO8tyLDBk5vpfM/XPzelS2dzs+h6LdZSdZc0U21OLKR9h+R8YShloDhXVxZl3SVhhAhUNasPJ0BaUvlRYq5biuSafytpCkQKNJoN4VvVFyTZGmm4aH2CGpt0k4eccxLfnWFmn0A2K166ZG2VH6KVHGP8yw5pEtn3ydle6tVgZvka5l/txzFpkC8pXGxJa/DVLWXRvHlJG95RU+i26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWRvZIRuwS9lfn+HEk4AV+ebKNR5ZYrITbn/wuVYqC0=;
 b=II+mcgQLe4yl2kqTGfx8AT7HD/C/G3aYwS+Q0pKrdvHnGa8cfhv+zYLftm0AW7tgBsD5o+OtPlwLSJ+F6wyNX60n3WAgGDHQOEkcIBKHKRwjOYpPk7dT7WJhcmo+Hhxez400h8lGLCixxmy3lcP5SvYq5sQmQ7y42cN1JHMYuHJN48hMfAHJ3Mr2BCh6wpWejKG0iFtimFLMyXgxSRMFUN3ac69uXK/xwSHnhXvORZNZltrPrrKeR8L3kbEbOO0cGPh63N3Da55N1mJlvRlP2i9syNWJvnQJQXpecCM4W/YPr5tfD6dfSKTzcAWDPpN0bGu5gu6XwqU+8YTB3jVanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWRvZIRuwS9lfn+HEk4AV+ebKNR5ZYrITbn/wuVYqC0=;
 b=MZSn7ZqLMqSEztTtPn0lgl8W2dBxqbzLdBCx4L5qIbTX2BQiYJw5MtxilJxTRvXDDe0jFeSJ7i0sMljbl+CKIEmBWYOab1LKi6FbdqyGa6lQmakiBkOreIngKh+6h0XpRdXyiAjwGdYIRKjsBU+Ck4/KnyrXWljZfza+qy4mZiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 04:07:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 04:07:08 +0000
Date: Wed, 24 Apr 2024 00:07:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Ma Ke <make_ruc2021@163.com>
Cc: vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mxs-dma: Add check for dma_set_max_seg_size()
Message-ID: <ZiiFZZ8kwDeRWhjR@lizhi-Precision-Tower-5810>
References: <20240423143205.1420976-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423143205.1420976-1-make_ruc2021@163.com>
X-ClientProxiedBy: SJ0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 20dcf9f7-9e59-4b2d-1e36-08dc64140288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EwXMyCY/TnfKFUuDSeK5jWFfjRupDaQ83i5U3rjyh2YSf2S/PCrA7//GC4FP?=
 =?us-ascii?Q?xH4d7Nktzy16ocLQkGMLXjocs+mICnDLL8Ei9+a0rnhJiu4mlSrRAsOX2EK0?=
 =?us-ascii?Q?+++582tDXgKl9XDEPsXTiuLsBVk2jm1F0ODKSo6MeI1xk8lo4nwP5O4Hg9AI?=
 =?us-ascii?Q?bviOeebk/mQn+iUE+7fY7R+r4SkpdhmdvA8XEfCliELItehHtai/jAqTKlPR?=
 =?us-ascii?Q?FiDZx+kM3mn7kjEBGcsmp6JUs56NJmVGaiFDi54MUA5DbVaXzH9cw6gf/h5t?=
 =?us-ascii?Q?RjCoFIDwEQ5M9qguoXJIeVXzWNV+PyL6cAREfAZcY50faBgw3W5+RPDW1BV9?=
 =?us-ascii?Q?kNp8zQmWHIblZZpE5Qyq4x/ZS+Jku75VOoSCJUI8/A782S38ss8oti6PNwTO?=
 =?us-ascii?Q?cj4FZvbWNGQupCF/+HZrscDGrIDmFQkEDmZ134g0/pT7Ej+S0LpXPiwPqrMd?=
 =?us-ascii?Q?YN+GWmP2IBLl6U8S/WY7NJEaiCtFK7sAOdTmZMnFD+LxEQnOyJHrDjcJPILT?=
 =?us-ascii?Q?wyPI9hL3eUC04UAE87e9wjKNACP2bV3x5hs6gIKnR6Q6qXS3eMCaZG6/M/Qt?=
 =?us-ascii?Q?j0bBpkolfNFnfHOuiMj/pvxuVE3enbZIV5wVqpwJgAXEJ00ZIAFu6GxQamBJ?=
 =?us-ascii?Q?hVkRLL5YFKFBiTT+KvqO9nuwrTq8flif8sXyFqkF3Wp1v1HuezJRp33Xu6cU?=
 =?us-ascii?Q?eF0Om1rds7H5BC8AwTBewkc4PwB5P+U1v1APe2Bu8vKdOR65vhDhBjj/57cQ?=
 =?us-ascii?Q?S5EgMfdSKYw1Z/MnmRZRKjJPgwDmsX1/qaq9cGq+XVrW+0dsS0NRZo/VExE7?=
 =?us-ascii?Q?pDVsuHgSINbPri7wU4f44kqOAdIb2xUiJfT4tMYbqn25l0uoQTNbBuHfe6Tq?=
 =?us-ascii?Q?WyVWPYxMe5Bg4MiqwmWh3zG3SlHiLdel3FnVdSQwwDRQk6SySS5Zkm5B/Rgt?=
 =?us-ascii?Q?CRqrA+RHxZoudxdeHPDlYKh4LjtyXRONmyzNwRia1Ru9dIop6vte9sIzNnd/?=
 =?us-ascii?Q?2XYYuWf+4STmMuuvyKie7kv5RaND+xsueE8rNE1OPWe53nk7ra/dCdGpE//6?=
 =?us-ascii?Q?dosLaBfKo/GNFesUrROSe4SIe5snhOF6eZ0CeekkHhdbdQwM9NeKheZZ7fVV?=
 =?us-ascii?Q?Gusb3ubcQEGfpZxVy7pdFRep3fhZF6bl3D+0ecHk4nYiBtF+jbdpCyKOHvrw?=
 =?us-ascii?Q?UIBAW6SZxDEx8sPHLeIBQMd0cPv5kHQc1CTyGm0qqgDoxrAtbvO3NCeWxCzr?=
 =?us-ascii?Q?2IYUN3dkX1iyNvIz0ZEe7AvW22RkPiB5dB3V4IMyTRs2973dq5lFXiX6G0nh?=
 =?us-ascii?Q?Mg7kB4dWaaMoqpAZuR+v2tw8Ac2rKLK/56m8DKmnRNy7eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQHTuBBHQ+ubABK0njNImAzUDTITfHdW98e2gxwwM93qXFRC6SPoJ3tw8JQe?=
 =?us-ascii?Q?Ci+0y7mQhuOUiUa3akuKHzaLGyuOF8FFmnGFhzUr8zhoreEpU+HH5tjLi1AW?=
 =?us-ascii?Q?th38sFiFY9eD9hiCKqIoSbnTUs8pg/q/j43jzjhmZItZleA0QX0GFp+3h8rx?=
 =?us-ascii?Q?28WWRE+0E9HTIHbjKQdMdccNfX2V0otaBEh4to9BGtLR+cozN/Tx9Q/mv+IZ?=
 =?us-ascii?Q?RzJubhH3usHhFHOCZsS1l3l+PRiKN2K2zF24zATVhZ1Kz5PkgU9SPxUYcJft?=
 =?us-ascii?Q?LbCDo9Dcj/lieZEa7WpQ9nyVtX5z1qc14rxQcPLvYmpYoMIcLikMuXnj0nJz?=
 =?us-ascii?Q?O1kuTbqKqk6+w3EZ/jVnlPZ/hgW9qnBA4IbG6aEtv0CWFYYBAOaASbF4ks5f?=
 =?us-ascii?Q?U77gNjWGnxzN6F5xbg8/XSwjdcC9UlQh6JCzKCy+eM+JomReVLWObOTBanZ3?=
 =?us-ascii?Q?p6X419dMOWJDCydYI07+3vDX/OMte06IsJLV0FewhmOZtbZ9dslQoO7mPch9?=
 =?us-ascii?Q?/Bskmq4yLzsVXBm8ximn8NWX9ukw+MbN6a4KUNvhQ02RMwZJwi9BUmx6jMXN?=
 =?us-ascii?Q?OmojUX4QQ/lzb+1ZOwNReKOCBOTAGAYUTtXe4ovOkwQq4mafOKTqNuh84qzz?=
 =?us-ascii?Q?KrUdGAa1gPUMYDJh/53YyV2cupQYdni8hHy7CWow/joAOdwzhhe3gNkSepH9?=
 =?us-ascii?Q?4tpmnllbrZrbaERuelIhw36pnaYkvMZQLmukAVT/LiwC837YD4qXruYqUbx9?=
 =?us-ascii?Q?2blY20EPZTEJbFAsTMrd4bs0Br4pc5CLiFfTMaecqIkCGp1p+L0sRLlvSmJR?=
 =?us-ascii?Q?UVuVj/Wdo+NivoW96s9XIUYCckYMRWM26WgiBVdRJ8M8SbNoBfYrdGbW5NKH?=
 =?us-ascii?Q?y3X5QtFIirh42MRtFerA4wE0wVlkaGrexJU1yq//d+QhUfSrDuxbBZtFCP4l?=
 =?us-ascii?Q?cOMBgDUJOKlyyr7NpUB/ooTebpcU9tvu2lxaAGFmHW1+LVtGBIukvLlCryOo?=
 =?us-ascii?Q?irHq956+cPNMLOECeoA7KAZuV6/cNOmh9712HE5CmNAN2Ozo3RX6Box6jUqc?=
 =?us-ascii?Q?QyzHHGEMvupj8L3paNSJbaH5w+YXxzWf0uayFu6tAkNX3ONjiG3qM/+gmznE?=
 =?us-ascii?Q?GMYV5TduDVpZ7gpJcQDtNBCAEq18ZPAhcgXnUox4sE0eOXbYfAdSG/O+NtqN?=
 =?us-ascii?Q?qMAG/vhZ67WJ7U4xkKqLaoTIotD56CunhfNjaQEK4+16Y6JFjzJ53hqW1vO+?=
 =?us-ascii?Q?HYA8MPcRfpSJFtIsDXGZL88yx86P25kjMMlRIri4g7xliKjWjwlFUSvJLIsM?=
 =?us-ascii?Q?42OHJ1gL+Oq74GJEBPwni8kRFyO8b/m3ilSdwVOa5mLjmf19blvarh3//KM6?=
 =?us-ascii?Q?UEmNYY0AgCoa6TMV35dz3XrYd05UdgI0imuMK575WfFGB3v3GKcJfB+6m11k?=
 =?us-ascii?Q?WDJXrBUjEkicFJbWPjdRCf5upMJToL2DgOSeyXmKyB3S1IdQv49AJRQRP7Gp?=
 =?us-ascii?Q?6KVwZiahdmwGlODf/hOlopxrk2c0aKAv8YCOBHdXOXRMIZCZUtUc4R/4EvCo?=
 =?us-ascii?Q?uvJ/h3Exq0X3nBaQdh0at1cO0MI6zXRN+P0IhXYs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dcf9f7-9e59-4b2d-1e36-08dc64140288
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 04:07:08.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jug7XBCeiS/IyhLp4Zcce9wjzd7hatBOXm2tf6nbmWatt2byQ+7cFT6IqSlhjnC+V3lRieWfP20hYpSsGi6FvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515

On Tue, Apr 23, 2024 at 10:32:05PM +0800, Ma Ke wrote:
> To avoid the failure of dma_set_max_seg_size(), we should check the
> return value of the dma_set_max_seg_size().

Check return value of dma_set_max_seg_size() in case it return error.

> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/dma/mxs-dma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index cfb9962417ef..90cbb9b04b02 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -798,7 +798,9 @@ static int mxs_dma_probe(struct platform_device *pdev)
>  	mxs_dma->dma_device.dev = &pdev->dev;
>  
>  	/* mxs_dma gets 65535 bytes maximum sg size */
> -	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
> +	ret = dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
> +	if (ret)
> +		return ret;

How error happen? 

static inline int dma_set_max_seg_size(struct device *dev, unsigned int size)
{
	if (dev->dma_parms) {
		dev->dma_parms->max_segment_size = size;
		return 0;
	}
	return -EIO;
}

Only possible dev->dma_parms is null. but mxs-dma is platform device, it
point to platform's dma_parms field. Look like impossible it is null.

Frank 



>  
>  	mxs_dma->dma_device.device_alloc_chan_resources = mxs_dma_alloc_chan_resources;
>  	mxs_dma->dma_device.device_free_chan_resources = mxs_dma_free_chan_resources;
> -- 
> 2.37.2
> 

