Return-Path: <dmaengine+bounces-7436-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6035C98DDA
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFF054E1808
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587723AB87;
	Mon,  1 Dec 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CZqOcQqf"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36A1E1A17;
	Mon,  1 Dec 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764617661; cv=fail; b=jnpdgdtHV3sQ1rplQxu6B03itK/56Jhet89OSlsq8ANgzPYRV4kL1sfktC7vFcS1IUAuoGmZsDW6bHR0Pgn2IjRIB2ONdnmIQzXEy8cm9hFIyT2yzFk0Qg2rp9R222r5xUSRQfEbyMgXCA8lFvBg6WlUu4Ac+f39618UJt6tXLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764617661; c=relaxed/simple;
	bh=0oZ9rPYza3czxqkzuy2SYnHzF2cthjHyV1OcDU9Ii1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iFHb2j7OMMDyCL/SYO+fFf4n/Fn8F5VmaVhj3p7RNRwzB4OdBLEIx5kweMjGeNIj8cfIfSb08mD3NtIVL7LOuhIlPhpLYPUp5MHQpbYA/IshNSil1pjGPE2kO4bV02WQoLYGnXouRIsdb/g6MPg1KxS64nEKWmOYHQminSqpQ4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CZqOcQqf; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViF2nMgUBTM0M9cQ2oX5Vpcy4OxtVkHFqPSfU0n5SbGRWMFgUw+vVyEtHJulI0EwcEUT25mvsjWs86Z8oFDc47YzvevSujkkNO6+/1krCGbnQ2EWLEmeu1YCgX0BwL9j/EhKfq5SdOoIzOCdWbr7STRO3oNLKt9rBxiZui9ZrYmOgHAnjZXBWl1gwCNuvKx3d1ToReaj4Pb5QbNay4BrmB+0JtbH3Wv+Afe+bawqIKJor4Xsuym9jBqmPsziVbQvPVU/lq1GPaTfb36jz4weEguoFaDiQ93FdXxLJkksm0pMTjYukFdZfj/mnD0vzLPevV8dwZeFbKt4gmtvO+2zkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5asn7Zrhd6afFCoaAfIY/QKSbctw3DHUSMVp5t8/yyI=;
 b=QabOOj6RE2Ae95OYaq+hjY73+KOW5jI/jgnGcUbFZNzOvSNpnBIbs24s2J9511mD/k6IwBJcCrALj0VbI8gbfK2c4ee4OP3iM4nCnPYJ/9+zgqge2vuZzc3rYo8zbgl0m1LxX1Z4KCqaU/vhExTOFGRTggSxO9jvtGQyHxlrX8mwuCwD785IcE8zH+GoUwph/JLeuCmiJkKhuBZQVVwU+DmsjFyClDuJLk177CTA3t6arW3cWGScde/94z8PJfh3UoAr6+4DuGSn2HaHEfmKzeiPz5fcndqKWz77yonmOcV6iZnycWiKdlRSObbOLAUL+naMOb61GDZUKNHK97xKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5asn7Zrhd6afFCoaAfIY/QKSbctw3DHUSMVp5t8/yyI=;
 b=CZqOcQqfLZ39EsJHyALkNzOMcme87yMfhDMzUvz4fa3/dm3wVK9igeRU8eVjMz1zngfw97LYbqdYUkYsyxIqlLXnMTzjf92ALV8p0O2ZSUuJVUnALNfcy+RpvCfM302ZLVZxoqnhQtBQa59rS+YoLEADt7+WwA4DyXjcawt5/5EPXe+Qy4r1b5HajvNUJ1fjP7DcTQa0mGg+hh58z5F4aKIE0SH5PxdFa4UyplHDyPG1VjC+NW1D2GnN78RYdUD8GVl6ahEUeH1oKAUS8lxZeQ6cFTSf/rs6c/VVCNlKZ0DBnF77m11xa83A56qfKoTXaYk79jlU6LtK1yJ2e2oSYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI2PR04MB10713.eurprd04.prod.outlook.com (2603:10a6:800:275::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:34:16 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:34:16 +0000
Date: Mon, 1 Dec 2025 14:34:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 06/27] PCI: endpoint: pci-epf-vntb: Use
 pci_epc_map_inbound() for MW mapping
Message-ID: <aS3tr2QVElXII3vX@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-7-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::6) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI2PR04MB10713:EE_
X-MS-Office365-Filtering-Correlation-Id: 451c4d6b-a7bd-4d61-cb3b-08de31109d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8YDQktqEygguaQt0RFDSkD9Tg1ferc+AlZodRJC4jD4xr5U6lcKttAHQt9/?=
 =?us-ascii?Q?Hp32MskISmt1/P96UHxTH9DYCKzLzqZRHDz/XeRsX3CdwAMG1osFN8ODh511?=
 =?us-ascii?Q?sSutejaBvy9/uHffVyYpxL4BUTudYIyXW4+QWudqSfNx9R+yWN0eIX9aK6Uf?=
 =?us-ascii?Q?vTP+FX+Xy47+kFJlLh/fU3wuJEYLkEWTVvCiZq/XV2ZWMI73PUM2MsdwWowm?=
 =?us-ascii?Q?tujXsiD5N3PczLGBqHSGiIvgg9vH/FzcdqvPFLr3ZXCCletkMxcaVYoeBsP1?=
 =?us-ascii?Q?QEkMnFXsQmBTnnThh+AiO9/2bwqCUx9QZbr2MGVutoh6XEdQPR2tEko7IqfP?=
 =?us-ascii?Q?jbKXBPvEdqMyXh8gybZssjHgn2n9x6PC2L4mgFTRSx/4jv2MPXfSWjSsxqyz?=
 =?us-ascii?Q?yLEK9sg7/9GnZSlsJSPtCHm83EbxydzAZTDM+buh1EfnRLvxqbYZWvs3XBpG?=
 =?us-ascii?Q?yfo7ssxkChqEJdM+gpWWJUe1n0Kd0zZlugMQAbzG9xHplJ0+3nRCTsYRIQaT?=
 =?us-ascii?Q?tUDiWa408z31VAIvqxB8XafMMKTvU0XarsSijAGLmhRQOnenWH0j7qPUltcW?=
 =?us-ascii?Q?9u/NM4kt+23h/Q72axav6ZoJrJpeNMNP0+Ob8vcS5NIhcME9BjFa7yFLc4wB?=
 =?us-ascii?Q?S91vXIFl5Mlk4f2jRdqiVFoXJDglyYt1Q3TzUqhR6aRgbboMX4Z74ltFxKDA?=
 =?us-ascii?Q?b+dlIeCTaaV7hCtdHj+k7+XHhbDyJecPOSO5pyDPnLEdhfnASBRNILgoD4VG?=
 =?us-ascii?Q?igOPYB4MBFmO0vL7D2SRCgb+07yM9KC6c9dS8coVgw4KiXBBgrnSRFn3na+F?=
 =?us-ascii?Q?UMFAbAGuAtwkNF5uKfm14ZMPfGFUYACxnOO0hm2eBup20gyXOSnu7rsGJfPN?=
 =?us-ascii?Q?6R3b5mKqwLYvmpcWwQRx+j6OZoU89OzSPFb77NM00syI+A7g35N3wk40Dsz3?=
 =?us-ascii?Q?ZgE6l0BEJB/PmXx+gVgAvU3Ppuy9ej3f/ywpc+bvYPpt0+pAtT2Ch5so5k9+?=
 =?us-ascii?Q?73DTAmLv0Qg/JFxV9PmeIVLuQ8Il46Z2KgmBC5X1UKoCiM5N9OwLaG559PV9?=
 =?us-ascii?Q?DK079jf/Yv/QlXC17VDgTDM4PlSirbmfouu3EGWx+h2ovG9US8sK7bpp577u?=
 =?us-ascii?Q?pU1SEHQ7KM7hF2mhUflPo8Wxx2w1KldWuYKC6o7WfGPDfk3myfJIhNy9BhN4?=
 =?us-ascii?Q?GWvEuhSBQ15J2QFJ6qcmz0r3E3wVf73v/VgJ3Uad3hI2TZ0cnpqUMoq0NjbL?=
 =?us-ascii?Q?isUdwR7C2jbXpmeZ0u9GG5LN6U+oDOduBUYi0n9cFoHuEUghCWBNr62Rlzc4?=
 =?us-ascii?Q?Rhb5IgwzLNZNwqrvM6ZJlaDoqupa4roKT1vkZsM7u4j24XeTES4ZJvYvzEwd?=
 =?us-ascii?Q?KymvFblQmu9XQMSNk6aJNsESwYe0ScI6dUsuTUpxHoaQkdnAoct5/qv/dP7/?=
 =?us-ascii?Q?/ck4R14LdpouuTe6dlbqaqVC7YGsq/AA4lHFGGPpwq9CWLwtF1VgsCXQ0701?=
 =?us-ascii?Q?bU7SOfgl5CW/mxEYn/TKbXQMOYFxvhvVfOnC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZjqroNg6in8mLtw754ogFnWbjgyg3x0Qnn4wzdY/8zoISe+3WOkvWxD7lK5r?=
 =?us-ascii?Q?JE2aYtjSmnIjTTcw3ESwjO0AYdhOmoF8CHUOL+b8lvxvgmTvMwJcdqQyRYHr?=
 =?us-ascii?Q?TGKTW/YHnm6xiKKLyIWlgWBPnYE4DAf/CxE6XC2bMpE7TfoC6wyPMdJRGw5Q?=
 =?us-ascii?Q?NiZjJaRKXLN161x9DjrQL0/2gGhsiCpOcQrhFgBPFaSNe1P8aK33FzkM64H2?=
 =?us-ascii?Q?YYirH6GuPALh0mIzZhEMkVDyeYks0wWAgI4Ka6kgkGmK7OHD1lJ4urhFmBz7?=
 =?us-ascii?Q?VrGQXub5BeTXuWDBs0Gh6Uqm/DoP22ym/L6H6QXzjd++0Emy8pSqgQXr9m5Q?=
 =?us-ascii?Q?B8fOeiXcUESNQcFkHu2mFXPn1XoEhVahg8gaoze98x15pibBzl8OtIVM5IjK?=
 =?us-ascii?Q?MerfD9lmDQmcsZ5P5wKL0z5NhlxcGWID+0s1kJFzWLz/qDGfYfc3YW2drJF8?=
 =?us-ascii?Q?cK1pfikf7P53Ft3UAHC3OC5E1isKqsCVV4gi/QB5rO7a8vwiaWnWg1YOmQjr?=
 =?us-ascii?Q?tespSEVOQgqGlxnzOdAxjgZFl1T/pjEmI4uBrF3rt4epYbGLMNJiZE8mfaN0?=
 =?us-ascii?Q?tZOVMJ+Ys2f1WwQSY7j3Qm40wcNxk2KOpDmRCiaROTL1LakTKe3vqt5KEK1P?=
 =?us-ascii?Q?9effh0nWH/gp8i7T9LU5PRbVxSIgNwcH3quMa9qjo+VADjLfqT5BoyUiMYvR?=
 =?us-ascii?Q?trV66JzsF05Wrcexkbji+WBRRSfFGo/oEdzbkbo9j1ioeF7CR8iPcKP/SNFc?=
 =?us-ascii?Q?crmwlvk0zSBxv9fFCQAp00/jXgjQ33v/VfZ3hkWVsES7HOX8SY93vc4Py2NB?=
 =?us-ascii?Q?pbipVOzKVHTYZ8jIQnz18iQ1Jlkg1BbDANK3WbSsljj34AT6HuTJC59H2XnH?=
 =?us-ascii?Q?xGh4P3uVI2HkHw5ueQWmoz2oxJBsSdsVuBjmJ+U/XlapwNP/E4wBqG/cxKxe?=
 =?us-ascii?Q?YGsxtO0jDo2y2U9dcdPzu102X6Jt4y4RUok17ixD40GEuHMZkfyZMOp6BJM4?=
 =?us-ascii?Q?ju5UgawuTDz4T7Ymwb91QZYC+8pfyHSpMxh407FD8+7BWl5plCYepowbHg2W?=
 =?us-ascii?Q?9UDt98U5GACAPHmd6I1XRGaQhpMdpm4hugC3CQuJUqKJWiCFZjk8bnfniTvp?=
 =?us-ascii?Q?hcEG34lWSg1XwILHHFHm5gMmuZadSD2tKWMUDpkrczSH9NmdApVI5y91dX08?=
 =?us-ascii?Q?ArsJAkMHbUVAg22MxgOuiXg4i3YjYrvVi1uy8P8n/o86M1OiGWym72hl7Kg/?=
 =?us-ascii?Q?9pHgcGVJrYt7G01EqKvQBRD7+TaiNbt3+6uc1/yCSB7xajh6Ey5lXl6T6Nsj?=
 =?us-ascii?Q?f5N5+B1lFo2eWMM6SI6lgAUw0LrJcg4vQCARMgTG/UB1JlLst64bPlZLvLzf?=
 =?us-ascii?Q?JNkyk02Xeq2JlAMPLux/0l+OsbM6jNty3UNpwTcPKEb5pm/l4oZSoWFSRel7?=
 =?us-ascii?Q?O3ytYyBn4A6Y+e1cf4O2is/NYOH+vT5bMEa1rBoXCjQa1Tp8igWirRwvuoFJ?=
 =?us-ascii?Q?sP+/HMaLkN/GCCRXrC4XVrojgCscbPm48bu5BYy2bQyuzvSZZtpwX0zF3F/h?=
 =?us-ascii?Q?FDII3qS3vtI+U6yos74=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451c4d6b-a7bd-4d61-cb3b-08de31109d21
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:34:16.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sui3Bvr4moKU77dzidCdBLHHQhNKiEOfknJ66kagfrC9EIABmddYaIIpTUUmiRuOnufMK/GnZFIOs8cF/QdSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10713

On Sun, Nov 30, 2025 at 01:03:44AM +0900, Koichiro Den wrote:
> Switch MW setup to use pci_epc_map_inbound() when supported. This allows
> mapping portions of a BAR rather than the entire region, supporting
> partial BAR usage on capable controllers.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 21 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 1ff414703566..42e57721dcb4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -728,10 +728,15 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  				PCI_BASE_ADDRESS_MEM_TYPE_64 :
>  				PCI_BASE_ADDRESS_MEM_TYPE_32;
>
> -		ret = pci_epc_set_bar(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      &ntb->epf->bar[barno]);
> +		ret = pci_epc_map_inbound(ntb->epf->epc,
> +					  ntb->epf->func_no,
> +					  ntb->epf->vfunc_no,
> +					  &ntb->epf->bar[barno], 0);
> +		if (ret == -EOPNOTSUPP)
> +			ret = pci_epc_set_bar(ntb->epf->epc,
> +					      ntb->epf->func_no,
> +					      ntb->epf->vfunc_no,
> +					      &ntb->epf->bar[barno]);
>  		if (ret) {
>  			dev_err(dev, "MW set failed\n");
>  			goto err_set_bar;
> @@ -1385,17 +1390,23 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	struct pci_epf_bar *epf_bar;
>  	enum pci_barno barno;
> +	struct pci_epc *epc;
>  	int ret;
>  	struct device *dev;
>
> +	epc = ntb->epf->epc;
>  	dev = &ntb->ntb.dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> +

Nit: unnecesary change here

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
>  	epf_bar->barno = barno;
>  	epf_bar->size = size;
>
> -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> +	ret = pci_epc_map_inbound(epc, 0, 0, epf_bar, 0);
> +	if (ret == -EOPNOTSUPP)
> +		ret = pci_epc_set_bar(epc, 0, 0, epf_bar);
> +
>  	if (ret) {
>  		dev_err(dev, "failure set mw trans\n");
>  		return ret;
> --
> 2.48.1
>

