Return-Path: <dmaengine+bounces-7272-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579FC77282
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 04:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7866F4E72BE
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 03:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934CA2D73A1;
	Fri, 21 Nov 2025 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vl0udcTc"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91C27FD72;
	Fri, 21 Nov 2025 03:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695414; cv=fail; b=Kq/lA8ikge18TQrucmqIMJ7Oq7bzQFBgFPzu3Cz7h28ELHrK4nhK7026aZISff4QX5In1GTIk1ntypU3fjv6RUZeyI0fGXlGSbYPNoES/wu18gHHXeLYVtZke/Mopl6EiTrNOX7FYJcBetHxWPRZyVRI0Mp+ByXJkttheHBa8Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695414; c=relaxed/simple;
	bh=DMeAFABpeu2K4MIrvl8jtD+uw73PIncgezKkAvC8pC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jbyNUD1JoAxGcb0dwDTiV/EA7YjPaS4wQ3DOvsclcjcnu/IR2ySK7E6Bxu5VM22m7ETCERj70TdgrZNixQucdhaISMjQHMekZnlZqy6knN0e3aB215ZLc7cjFvvob496oDr8MaYKmqrZyqDPQJjpXa6rYGt3uSYwPVhu44X0Z+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vl0udcTc; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XndicjBDoX7GXh1ya9wAGdLRfTZCN0dmdlaPtaikREfhJsU1uHz/qgz5atZ6fDsv0MkvG0FuY0dGYr5auTy/tbBRgRsp+qaRC2b/t6LcjoENQy9oAw5+5uUYYLRWdxMIMPiXcIQUwYLgPzagBcVRryWZYPhhjYWLOKlxrFw6UIMDsT5zV+MDIa+DRqYTAVPytUkhYhtRxt5l5qYpB9fMLl8SB4hgq0/t/0QwHKnEWKKSzvFYLWrJKDujeWK5N/qw2FZVt16GZP07gRauaFaiHzwu+ZiDhxA4ZpJ+b5r7hllHL1iggX/PWvi+qPhu8u9zEinxg6aTNQ/uNu/YQJtCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIlZInic7wO13frTTsQN8JjFdk8TcTZdtCP5hiMIFEg=;
 b=vTAL3PPHRi7AN9CHwtlGw+IDMfLoLaJY9O7wxN4ACa8o3QBHcxFhZG0tlbB3phk3hy20Vv2KWY8zmoL1Lua2vCW6hDrX1SEUFTEpY6fs0Y9QD5v6lcZGGG6PWl5db91jAAzb8zaY5a961tw5C1YA+Z9JgtYyBlPgrhwR3TcYlEGfwFXa2kPAKF2Jbo1m4U8sqjOoXa9ZofnljHYFqi1IDqn6d3RVco3MuVd35r/3EjwVp1OccSBd5R0OWdKneW8zVt0xJf8Pmo+E6xvH0FvZlosh90JtMo0GXBejTpi8kOICc4MVCtP8aNJCjb20r8166LQUGxGqhN8VKTsIjB8JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIlZInic7wO13frTTsQN8JjFdk8TcTZdtCP5hiMIFEg=;
 b=Vl0udcTceVk68/1RfYs9oAIWhlx7art+eGUQmXFdW0fRJ7TUKepX5+XUh0lzrGwIPyKjq0d9AXHMphvJw/vCggsKepjuu9pWGyItDAMwz51eK3i95/EiOGUINGLFH5hKaQTzo8TDN48h2QVu1RFpv3vbz/HV1VGBfv/u80O01H9PM9Dc7o4RviakM76M5awU8WulGahjOViG66CRVxxBvWFQYaPjR0xcyS6Oc5ODNVYfoDsGTN0AmpOBWLAjQhfVv2CRGWAQd/NPTcWSyH+p91rD9n53nFQ4VaaDiQeoKU/GOIgXJZ3iq8Ib/it8ZND8ieuPYgKwejqdfWq1SziPuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 03:23:30 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 03:23:30 +0000
Date: Thu, 20 Nov 2025 22:23:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] dmaengine: fsl-edma: drop unused module alias
Message-ID: <aR/bK9GBKDHCYvUX@lizhi-Precision-Tower-5810>
References: <20251120114524.8431-1-johan@kernel.org>
 <20251120114524.8431-4-johan@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120114524.8431-4-johan@kernel.org>
X-ClientProxiedBy: PH7PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:510:174::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB10592:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a8d135-1105-4984-cdc3-08de28ad57aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SHM+r8iMGFUBbRzOONGmTVWqsOn2i1TnPG1OLuJYtiW1fXbB8U3jB1+Jrswj?=
 =?us-ascii?Q?hXfkcWHx4k0sWVT9F1wi7+WjiGwMZLTMbNWX1Qca9kPj5bv/kzvDdsK8A0og?=
 =?us-ascii?Q?30yUQjOWGd4Uu1E4HC39AIjYk3RZuHzslRQ8rhp+HfXxAKKjYFv3l7HQ+q/8?=
 =?us-ascii?Q?KKc5K7gKjK3PArZg0g3QUnLvqO5O8sBxxovjXZWaSCPQ8Yg8QvG8wJhU98Zp?=
 =?us-ascii?Q?NoApM4Y2uTqcGqJRd6oB26RyiYDlumpBpAgm/BMwT7TQILCDmkZACWAYTYZ7?=
 =?us-ascii?Q?WbQgAUIvPPlO1/NqFsawlDigho2sJ/PdrMmcy3HDeig/isf7s7fy/IprUfj+?=
 =?us-ascii?Q?0Pi/JGoR9bk3AkdSnYVCh9riyP+fiJg/3shinl7JvEVn5tKhNWOga7HjGch5?=
 =?us-ascii?Q?4hR77pBTE5PbaGw3Hy3Y1UvnGtHDDYog9QMPUucXsRJhk+1He9Mf2P+KDPzP?=
 =?us-ascii?Q?F7Kq90QHDFNMc1OFgHbeJyBe1iaRpLy3qcouTcQBTZXwGg7+oU8vhpKUeAFh?=
 =?us-ascii?Q?pEZL9FQwef1wByH4tOtqwaVXg4HB4vmc343RKkz7tkvJENZOSIN2zBfH3TFz?=
 =?us-ascii?Q?NhR/wmiFss0cD4fF2f3Wwv2xNLTm8Cv6K0p4kUC18QO3JyEqgBs1HF8ciwQy?=
 =?us-ascii?Q?fsYQHvMD0gysG9GVLy84xn7HRyeTXgI+F3goqiCgSmt+3oLxAMioTpNpSRi5?=
 =?us-ascii?Q?KUQLicOuP7YujGAxqUwna5ASKin/Tz3YhaAkSkPvxK0BLLAx3OlA3VkJauHN?=
 =?us-ascii?Q?LDkikgWY/bpnn+26M/tH7vv54bTNBotyMAvhRzdb5WhdJ9RKBNYVbnJqk6ug?=
 =?us-ascii?Q?LYeiJS8AvS9N2zChn0dLJPkxVSObe7N76xQShzo4IocbA+5MdRzRJBk+beCd?=
 =?us-ascii?Q?8wyIvkIhFyr472rQArMYhABQrT/s12/M/9YZGsDfLxhL97J/hiEE5NTjwQZC?=
 =?us-ascii?Q?TYwBGYmSV6M1/oX3WY/pXSWVXkZUz7A0qoKUiV5jAuZzNGYeQhD+SpXFD8kU?=
 =?us-ascii?Q?0ttGSpjy7ACogm+BHKReAH13WBS4IirsFPp/CovdWeg3VB3EzM0RkdZ0gTDg?=
 =?us-ascii?Q?KUaUqVDDlvk86REf232tANnyiZFY+eoK27ZIX5qXyWZieDXhexSShnR7ZPfY?=
 =?us-ascii?Q?09Y4QLz2nLb1RUqEDgWTNUpo9Wctrr+f7wikZW1HZPz9rOttu7nteSXGHCd8?=
 =?us-ascii?Q?666Dx/EAFar24RJYAkpHv4igwDqyPlBPz7qtppKJwDiQO20g9uqtSAQ0dama?=
 =?us-ascii?Q?aH3TG2PrNwl4Fpn+6xBOkbwzBcEGmbcb7ILf2SPCXbu6w9LiqvBBzux7iBYL?=
 =?us-ascii?Q?0IVlt3d2re51R0rATyIaCouveYGXdpVCpcwOd925n0REAp2PXnsrBtQdHTMP?=
 =?us-ascii?Q?rneWPg3X7HZM0eP2JQR9C4+H7EgpEHhwNJ+eXKkAnPyIrichTkCJZ2Ykz348?=
 =?us-ascii?Q?fypZdMr27EyBqlpSn9gBbM6ZmcsuEGsv8Brj58XAUhsu+Tc4/3ZtDd96+CWp?=
 =?us-ascii?Q?96MW9pCAQeYYHREzlwXJlLkVNKB2IjeEITXK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?63uVMwwKm2WNuQ5Gn72ftb5h7KpfKFftgOUVr+Ahy7xFKBjjZw6Ml+xjMsOH?=
 =?us-ascii?Q?3KQQIANnfwFw5T03LwoFYRRRwRlSwaL3qoK105yHeQBswE9PHAgQ4LxZKFCx?=
 =?us-ascii?Q?btwx+gnmx/+PLBiazSFv61Z5/8eIqh/7OY33nsLT/G3uF+4hjOwdAdCQEB0k?=
 =?us-ascii?Q?kJAC6seUixcXm5vhe/5QnF+DB0cpf5w1L9ZQXO8VOYcvqKZZnWszAPdOfWEW?=
 =?us-ascii?Q?qvU8JZz1CLW99RiGHhN3hRgZjBktNCUgtVq3nlvilOlzQWSzM6p/Gn3S7DOL?=
 =?us-ascii?Q?IhLmJHAfhWu/+Grbw9S12qsapXPzQy3+dCZMWwkfBzROMibC+0xdyG5vYUDP?=
 =?us-ascii?Q?ov9d69OKavzhhu31ZShctjiUx9rz9+9/bgDzfUtxBE/n6FUS9Ws4GDSiOBg7?=
 =?us-ascii?Q?zBisozP7o1dO4LAiQqGTzkLm3SC1HLnMG8VSxPgBz4mYKaxy63RV+0aLEMK5?=
 =?us-ascii?Q?pew05OEpzxvNY/wc4Q1h3gesJMHVnBm+vHcLyivp15QjAhOPGsCFCVDS8baj?=
 =?us-ascii?Q?trTwvtW2vtEE4NwPCbJFb61e6CiLmFRHn4Aj5mH1v5ZTwT4eKr+ey7kfIqa7?=
 =?us-ascii?Q?+y909ouel/RVJbUMePFOGSj+TecqtcfgsgRpE2GL9fOVV0YcVgg3ubrmcuVn?=
 =?us-ascii?Q?EKE8VFRRYOsNLo3So137iLKyhAKvtwlnaj3rC5AymcFFYefgkbdbF/p6pj4Q?=
 =?us-ascii?Q?hj6hFff9eLdBYBcEY/Z3uzsNpmWNtT7+JakTVMyMd5tMCVTrE/xUqXEDgUf7?=
 =?us-ascii?Q?3cNjlZAbvIEFSe1ykuuNT0b2AMZFUh4a0c8AUtBakLUSf3CJAjKkQisk/I+y?=
 =?us-ascii?Q?RNCRNxspg2hN9oYUFJg1UifN/Ek4pGO/2aUmStR9YUN1TCd2DleTFOZWP3oy?=
 =?us-ascii?Q?00DN4+N5Mt6vCsA7eMtUJMgog/jJtsD3OKL3ec0W9y7F6vP3ia/HHc8Ibdit?=
 =?us-ascii?Q?wjQ7/AdWjB3V/mNQdo0QjDJbEACWh5/T7Qqe9u9OGWf3GeeJ18pOUBDBtHOS?=
 =?us-ascii?Q?+o7/8q0y1FJsu3wDW6qsdW52AknIPyE/9EwySJ+aZhfDsxlhqlKo9W52OqCN?=
 =?us-ascii?Q?ZsIBoXwPy4UxHDWthBcQi3N0+2SIQQWaHQxoGD2RdUQdJWOhLCALvARIK8Mm?=
 =?us-ascii?Q?xDbD5bDgaR/9mQ4xAqLrFqxwA0fuRaq7ArH453un3p3bDDlZqov3VlACgCaj?=
 =?us-ascii?Q?r2HSfzVGmb0KtCKBli27gyoeNILl6p+7t2BdyXbmLOGEYcGpiqEjHjOglFK4?=
 =?us-ascii?Q?Wy8c+P/DaWbghAWOtbagXSe4Myeq/dMlgZUmldKaAomKUojIUrdiDb+k8UTH?=
 =?us-ascii?Q?PoxvJqi1C3sXV+Sjatz0bxIwT0Q84pFagLXPybYMz5hKFvuk8gq+JjJAknRk?=
 =?us-ascii?Q?0qn6kvuXQRqRNyuH+XPPEud6OGIt1uhLJmLDlenwrcB6v13N0Ta7sekfarfR?=
 =?us-ascii?Q?vZ9a/2jNheiMvyVN/Zjqelob95VVuY87Sc9YbqzUM5KygBRJfmdh3C279RB5?=
 =?us-ascii?Q?ZUdrO4KphkFxOZrtl2TJRuqCjAI0eSe4MMgbj3/Xk9lX5wg/zjtzHUZJ16Of?=
 =?us-ascii?Q?RtTvrBNMf2Kd4xtERtYAkRGYg5E+0t325JRLkAKm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a8d135-1105-4984-cdc3-08de28ad57aa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 03:23:30.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTTEN5cBtgH43+AVsoV/+mVTHgoU38G1BbptJkuOF8xf4G3uXWXhd3gSNosgvLyjA3eU/yzCsh98QibFAjtLsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

On Thu, Nov 20, 2025 at 12:45:18PM +0100, Johan Hovold wrote:
> The driver has never supported anything but OF probe so drop the unused
> platform module alias.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/fsl-edma-main.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 97583c7d51a2..a753b7cbfa7a 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -999,6 +999,5 @@ static void __exit fsl_edma_exit(void)
>  }
>  module_exit(fsl_edma_exit);
>
> -MODULE_ALIAS("platform:fsl-edma");
>  MODULE_DESCRIPTION("Freescale eDMA engine driver");
>  MODULE_LICENSE("GPL v2");
> --
> 2.51.2
>

