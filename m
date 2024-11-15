Return-Path: <dmaengine+bounces-3741-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D939CF04D
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46677B26E84
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2321D45E0;
	Fri, 15 Nov 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZGlw9pCe"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2045.outbound.protection.outlook.com [40.107.103.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48E1CEEB8;
	Fri, 15 Nov 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683572; cv=fail; b=Y0aVs2oI2fN3IZHeAknNSYq8sugkm1f7UBreoru6WExcyix5+VnEpTqSdOxPRfZWqsqBBHCKB7RrZFfDF1kdzCkJgbNCcggoO0Phz9/gw3Uf+a4rT0/Xzm3nJExqMNFjLzhP63D+uQHdxxe9dKHLqUxMZ95i2TDxUjgCaJ0r/gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683572; c=relaxed/simple;
	bh=9UOkL6vKsAmDnZpn+Z4EcLygGyMPI3xRyEp7SkgpWHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CoQqSc51ZA6MN5z7TQUbiEZrxGRLbn3ReXGCVLVWREANlVZtpedgqZ9eRYazQBtLjpg5I2+KwQXPf0nLGeIlgLlEkyZbWk6Nsp0Q0dN5zvPRxV5eVRw6k4fwiwYgLM3GZG5hMYqmAUzfwA3AQTxRqrs3SoXntzwM0OHbwHkdAVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZGlw9pCe; arc=fail smtp.client-ip=40.107.103.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGjUz4x1J2F8IaTN9VSOnWY9AlqNdyhxgrPvQ6J9oOSOpsUAKjMCnucuPjCOm0vPwPt+5yICbaddPUzHg54FzdQoDgRrj1AMzucJhk+DMDE68+CLPUGMFUi80CqW5tXjKvDsfxvxxDWAKw4W89/xgOjgATmsJ33a4GpEF5eTDxsiAYe/WZGNxt8PxDoarTtxVvDNCFfdR56RDa4RsKkwm8tYPbmEeVXSWMgmUTNT5fm/hMVP350U/4MA0cpUpLzxvXMzkGdNc65K35Wh6/jo5Pgapn6hxRkQ20GgFhd9bhIZtu7za/UkvpcCPJdpS0h9B4yJZAvk2Dj9oRLVA+MENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTWV1A7HOV2NTDYqpdqN2KdLj6gBtxzu5MKNvaJpTH8=;
 b=U9q0Is0gi5Sso9/P24MA0ME/YL9BizKxTdMJ6g0bCi6OajyUMuczQ6/noi2/j0IepREE8N8A0G9648/nLXiR9Tq6REKkaIgwSAaATBTXgbEYAQQ18Nx44y75lcVGiMjHp8nRezlVDB3d+5BP+uUneycVTCA8gyeycG0JbX3UkMmON9snSvPObzyBfOhU/SUXCxb+KLVgKrsFbDK2stimaUAv5RGH5Xs3/9oGZBoTUQdBIqKFxVq3ecQV2lzP65rt+5YnnimzFjQJRUmf59NvSJI6FoDr5a8Q3KmHY/4Xrtu91WwZzzIcuNL7DF9tpdoOxgfKZs2qG1IwyIR8Nesk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTWV1A7HOV2NTDYqpdqN2KdLj6gBtxzu5MKNvaJpTH8=;
 b=ZGlw9pCeK5zxa3viEsfY4dQZRhQWsIvzMqMmo0Te2Pul6FINBBE4ld5MgzLyE5XzszCkisdgP+Tm22xztnZsutALoe0fCEQhuB1stoen0lC9ELkZtGC6M8CjmUPZ3BxGDwFoq3Hczj4srgrqN0xcOt2rjDwEDnzTs9+pL5vyjWYjoAAxgO0NwCBV/lyLtB5ptEpnExbz+vefWMm7nwnZ0H1iFeNyZqKCj2Aq6IoQJnqLhGxI4I517LpWuYkbjoAeqFL50EdHceqrFHLFze0UjCVQpRHavU+GqMPsTv0PJGz0P7LxNYNwKGbZg954d1p2CesdAgE8VHg95z3/JfYb5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8530.eurprd04.prod.outlook.com (2603:10a6:20b:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 15:12:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 15:12:46 +0000
Date: Fri, 15 Nov 2024 10:12:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 2/2] dmaengine: fsl-edma: free irq correctly in remove
 path
Message-ID: <Zzdk5qcUyhNhRZSR@lizhi-Precision-Tower-5810>
References: <20241115105629.748390-1-peng.fan@oss.nxp.com>
 <20241115105629.748390-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115105629.748390-2-peng.fan@oss.nxp.com>
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd70595-fc48-4037-6537-08dd0587f642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmyMmP40K6Spb02BfibzZCaXHMi/SjixmW2bRcFmhnff+f73viXN9KaWIY+M?=
 =?us-ascii?Q?jCNTG/gX55BxxOT7rVTG1/ny400HARN0FOyiVNci3EkZBR0RsiiRdIqbYd0U?=
 =?us-ascii?Q?jbDHNgWZsLfhe55lpeDs50MaaOs7rJ5xBP/tLzg75kKjjbAB1YSQv8u2is/a?=
 =?us-ascii?Q?VuzSs7vkqgyEErWGF5e1uZEDOaGSYFiWffwPVUvCt7V2RHejMY/JZtFSuo5F?=
 =?us-ascii?Q?FhLxw2cfIM16Tfz+frHse4N0nDbYNPTyQT6JUAewwWNgAz0Xa9MNVMGzHzfi?=
 =?us-ascii?Q?+ZBwS2Js6sYInLeHLu2dzHCB4m2+M0OTHT4TifbUDLmWmtxF9Ios6vR5s53s?=
 =?us-ascii?Q?M5jNCg1Rz31kcPsvfKg9iA+UGJxEo1CA76fTs834E4OgmNTqRsgImNJNMk+Z?=
 =?us-ascii?Q?aVjtPyqj/Le9/g/q09MBdhcDNKe6JTHasa52mMaLerSS3xoLQ09As/4Gw9uC?=
 =?us-ascii?Q?hiUGbisEEjcKgqKMzfZDV5SJze6Vj4gJkdsiGG2nKT6VJlp9fy0KIOuJG9pk?=
 =?us-ascii?Q?XvnIQaSKv8XeG87/kAfcwliOeiY6Wpdp9gVUmKzGrLZqN/e+UZg5A2WQ4Uni?=
 =?us-ascii?Q?SCuQjy9f1P3TqGmqVC4MMlalVlMvEUb1mamusKOw2QhWZBPNvpeZ5u32j0Tg?=
 =?us-ascii?Q?BxHoHXQIUXUIuD1v8UHEu7TbATtcEOmDXCnp8XpQxhWsSzbSI0AUlvE1oB1z?=
 =?us-ascii?Q?zLU+Uk6cSGlhBLEXwvb2bYZVMsZMh1RkQJnTAV2M9a4ay4mWj7F6HfF9pPAE?=
 =?us-ascii?Q?npk2Tf0ehS6DC/Oym/9BSXynTCMj22fXNouJzyNTye8zINYOygGH9J47U1f2?=
 =?us-ascii?Q?L6mkO4eqWVKmmGXDKavH2wjI9YmzoLxo7S00iWYh0/CqWlXeXEXXEZD127Ui?=
 =?us-ascii?Q?TdPQlkRH9y61Ut5mWXk0p+/EyOZOlQItprF6dy5aFucjH1galqd/bzjq7JYx?=
 =?us-ascii?Q?Y3zxiwa2DLgBKd2IA5E5mEYX95kw7chuW+lT3AXZRm8mjm1tL/9uohDMcvRl?=
 =?us-ascii?Q?o2Uy3fXoU4sJJDdpd1u9w5WLBZ+/nAhWqLidUSzLw9nZQGhtR4sMZ53NjePl?=
 =?us-ascii?Q?EyRb4piR1yrflg2w/TrI2k0WBflDulSY/wBOzM6XDO7jx6p63powW09ewhmT?=
 =?us-ascii?Q?eixVHp/LQaNHLrxGoVAH1hNztZCAeYZOK2GoSpXWuOaE8CDOJcrjxSokqU+k?=
 =?us-ascii?Q?dUTVyrwnbH4xFqFYCPPs1J2fXAqnIioTU+3HLFYdU+RK5VwPZBtp3qUocIdV?=
 =?us-ascii?Q?X3H7lmEGMvgx3B1qIUHoADe5o296wolfeostB5YAZ3GMcb/vkH4qjnsMFqVq?=
 =?us-ascii?Q?jF4JcbzJh194RrHkMrL6m2Xb8xORRV0E8ly4TNrjuC1MrBhnZBS5Ut2R358H?=
 =?us-ascii?Q?qhfl9Lc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZucmCZe1HNHR9FQcvp208N8Wg8wOqLKFtH42m5KQzuakQ8zK5Qel2oH6b8ms?=
 =?us-ascii?Q?0L4oN0hUZvg8iOftTLspu7u1VJQECdyaLyMgjnljhWIITEENg8uCJbxWFtqG?=
 =?us-ascii?Q?+Zx1YbdynqppY7PA+5EGAMqY8yuHHybjNYrWge6d2GRwlUhFECXySVKgjf7T?=
 =?us-ascii?Q?RjwGDpdPSV4W/Z9XtghWiN0U1dFwyeFZhqb3GaMa5OvfbkJ0r4iybL03wft8?=
 =?us-ascii?Q?931053ovpbOTJUBVZJDFKjCxPtRIW9PUPGpdFNh/q649SzE7EXGedXKyr03t?=
 =?us-ascii?Q?NZ4T4TsPm1c6Qya1xV5HNMrjiB5RNoUttn33W16TaFKBUQUTQY5hpdsabzrY?=
 =?us-ascii?Q?gI0itdOZ1RnSgz7lD/S3pmtwA1J1Yl7pbLXAvzupHvSly4rclozh8U8GM7tf?=
 =?us-ascii?Q?Mu+WU++ZabEAV+JTBZAu5MndETKrgxB2j8tRx40FCDPrTR2bVFv489/mIn7v?=
 =?us-ascii?Q?cNIPpgeKLhc/tQZ4bOcR/gJ15ZNEutgnF6CJEotyBQ0Tm0V9pjGGKVNT5+/K?=
 =?us-ascii?Q?wOSWw+Q7jxHXwrCkjMiP75TlehwiGMfSquyo8ez57/re3BMudRyU6w2UMb5F?=
 =?us-ascii?Q?qgohszpSNd4ZExDnNqdNaNqjkjts2rgmgLYSk13TgE+6MnUeMjjE8TJd8AJz?=
 =?us-ascii?Q?x+6cZEcmix9hjxKXaRruNHk56VDmbATxvhjtQzg2NSCYAR5fNcRuGfKVjg7l?=
 =?us-ascii?Q?wBzxIKGzPxwXYWyhU+72XonJKjLbGz91TZ/xY7Oo6edmGxyEVT07BBzfEmth?=
 =?us-ascii?Q?Dq27YwIlRZuwcLmILJjFu/rGDKvAb2i9YkbCjN2tGFH4X3PhSaSk3wtfGI3p?=
 =?us-ascii?Q?6ekcicuNj3qbvd7pa71F9IJ1FHDBCh7rqFgSA88mdvOaZwsMIMgmWFCj/5bE?=
 =?us-ascii?Q?BgRfzd3ei2IVrJuMEhkJzr2PP/+8RyRjznOg68lStNWY2wsgUfkvYiMOBOo4?=
 =?us-ascii?Q?57sjfQdOC/ym62EQbretsRUS5iCrphouWwYn3xdQLVaZ5vBC6MCxxvWJjPNU?=
 =?us-ascii?Q?C/1ZJQWdElRxUw26UON8CsCG7mZpyUtL/DX9IKO+bUCPTVb777oMQhfTszQc?=
 =?us-ascii?Q?rXTVgTkE05gsBC7y0wabFQQukseTecU2yNG0Vfy/uU/Z3CMDRQvmlZM64NIn?=
 =?us-ascii?Q?hrZ7MU5cM8FtILWlFkDG5TbpjnoGyp099VxSrT/D6+q1fXlGb/bYXxgPfbvC?=
 =?us-ascii?Q?G3SNTbgWXf8AdzccyR73F0Kx+9IgMvzamvRcjY6ccs0T38sHdv7uXVNRRvcM?=
 =?us-ascii?Q?UnBmXkwe1tbLbX0Z5QtI+5qqFTCPqSz5OjPS2BOO2qcKrLopQ5stfD6f32Cr?=
 =?us-ascii?Q?hHso5z6BktS1MJAst0hz/v/dTNie9TQmk3ZYuhcbEhFDmHMCS0rjPXwoCwXZ?=
 =?us-ascii?Q?82Q3Sz4OIur3z3DwUvjt3451OUsLrAN+eM/W/4we6eyXFE9YC/BZwPRr1JBo?=
 =?us-ascii?Q?rj+bM992IjoqeD64Hbth2T4tu8NS4UhN09B/ehlrwQgT5LGS9DxxhFhLugBU?=
 =?us-ascii?Q?K2YfHfsCbg5+VHHli1ANdoEZJIeQB5dNthYxUn3guHLN+LGwiCfscXKkyX5n?=
 =?us-ascii?Q?5HB/6jsebss0VTMidJs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd70595-fc48-4037-6537-08dd0587f642
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 15:12:46.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvxwag430WgQCAFfPrPslFBlgKhvjOuyCdIkPTzFV5bNCmIeIHZ96fXJGrsb6h9vjxU06p105/1wrdmTZk5CEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8530

On Fri, Nov 15, 2024 at 06:56:29PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
> fsl_edma_irq_exit to avoid issues. Otherwise there will be kernel dump:

Nik:

Add fsl_edma->txirq/errirq check to avoid below warning because no errirq
at i.MX9 platform.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> WARNING: CPU: 0 PID: 11 at kernel/irq/devres.c:144 devm_free_irq+0x74/0x80
> Modules linked in:
> CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.12.0-rc7#18
> Hardware name: NXP i.MX93 11X11 EVK board (DT)
> Workqueue: events_unbound deferred_probe_work_func
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : devm_free_irq+0x74/0x80
> lr : devm_free_irq+0x48/0x80
> Call trace:
>  devm_free_irq+0x74/0x80 (P)
>  devm_free_irq+0x48/0x80 (L)
>  fsl_edma_remove+0xc4/0xc8
>  platform_remove+0x28/0x44
>  device_remove+0x4c/0x80
>
> Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> V3:
>  Update commit log
> V2:
>  None
>
>  drivers/dma/fsl-edma-main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 3966320c3d73..03b684d7358c 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
>
>  		/* The last IRQ is for eDMA err */
>  		if (i == count - 1) {
> +			fsl_edma->errirq = irq;
>  			ret = devm_request_irq(&pdev->dev, irq,
>  						fsl_edma_err_handler,
>  						0, "eDMA2-ERR", fsl_edma);
> @@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
>  		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
>  {
>  	if (fsl_edma->txirq == fsl_edma->errirq) {
> -		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> +		if (fsl_edma->txirq >= 0)
> +			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
>  	} else {
> -		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> -		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
> +		if (fsl_edma->txirq >= 0)
> +			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> +		if (fsl_edma->errirq >= 0)
> +			devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
>  	}
>  }
>
> @@ -485,6 +489,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	if (!fsl_edma)
>  		return -ENOMEM;
>
> +	fsl_edma->errirq = -EINVAL;
> +	fsl_edma->txirq = -EINVAL;
>  	fsl_edma->drvdata = drvdata;
>  	fsl_edma->n_chans = chans;
>  	mutex_init(&fsl_edma->fsl_edma_mutex);
> --
> 2.37.1
>

