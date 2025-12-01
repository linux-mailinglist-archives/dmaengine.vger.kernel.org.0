Return-Path: <dmaengine+bounces-7437-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75419C98DEC
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2543A1DA0
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB012253A0;
	Mon,  1 Dec 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LKL0vPAi"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179691E1A17;
	Mon,  1 Dec 2025 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764617726; cv=fail; b=ZvHoySU2HC6Zn9gwzjHHKjy84NcToPasGdBcrWxwgmiE53DyjZOVHEXNbKgMxG19Rnjgjw+zycAN4SgFalS//dSfWvR1ur3OWWiiYtUjWRsNc0Q0Hfyu1x+qY1OjrnvuxrgTNOEm8yyXODMg9ivmi0QRmj8l1h1icuj7a0Ynyrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764617726; c=relaxed/simple;
	bh=MOTrfNTkLxeNhlotAWRx37jrU1Jc/CIJaNLPEwwmf5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m/1C9NzkPBu3ZLbloaKUQg5FEA0/zy1ueWhQ6oVdZhn7SHSmpiKM9rOL+mAjO7Y9KEM6DwPUn5w/GFGCvvid7gFsz978BNSFBj7/KQ5Xcd9z9Me8hZWu2TN3DZfGqtRbTNl5ygNPKvtY3GlEkD6/laY2B3YP+3jQLgGzXj9BIH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LKL0vPAi; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyF1c5cDQYb4jUIjj+65x6nD2gqzitvwKp9DJ3fy2/aRPsqeRvHypIo4IVL18lTncRzYi4Lpa25zH/IIt+tH+szLFGC+AO6mUXzNLMLZerbIFPeJQ3MDWMimcj1+nvxUKAGcQISp6LgCnaWqAlNTZImHORjECxlg0BWFxLzFW/Q4oZn4qKfNfsiFWVNdl76o2Jlp5sFHjbPemiE/seWLbK6mUSMqY16094cbKj5s/NQarp3GiB6JRzzQkoTfjZSelQo60Qpcpc+7u7lww4x9vvf6MsljlwQHcPUoVJObBXGhk07iqtCp/C89JTJ0CydYIccOYPhVkEsVKG6QJEw9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OGLttcd3WUJjof7Vo0W2nad7/zZ9d35MYr3sIO5LWU=;
 b=c2jEQLbtpUWD22+572teGhSqfVqtqqzKCeP0hMvp5tl8Rc+qpcvyO0Snhs4JN7hbazR+bt0NHxku9GHkAEmtwuaZZpapbXC4FiY3/kz1NxJSQ8G0RM2z0gi6b72/HgpdUPAsTvEsJqCCyfcwQQHnvomtzyavWDG1ctz8NJ5kbgQDuVlgO7fDHgF9c12vngiQ6JKLxW/ggVOajj4IdShq7uKoL7ADvzVPQkdBu2etrzf6GbhlmqlbKFxp4ibLkGfn0WXYNd4ZCCDjt8HGMuXy4NUW8aZYeqt1dtHbdgztuR1fFIwmmzylIcRzyVWEguQ/gQ0KS2SuLj761nGHt8FEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OGLttcd3WUJjof7Vo0W2nad7/zZ9d35MYr3sIO5LWU=;
 b=LKL0vPAiPr57tMvqynSIecApYEudIrMgxsxLom5vtbRE4z/cFFMsvgeASjsKInFjv4DVt8IFAItBO/w5nl+LWpge3sbeelMsW3ZopXaP751wuHI9gzbT5uFd0LZEnBAcW4izTTTWCNXdfQ8mxtW1joajpHgrBYEFNCJ+Ucqw84V1LMhWUWrSvyVr5reBKgCt1T+ERIWSglrdDsEmgWknKxHqM00Es6LfJ6zIPC4cG6PMtkslWIDzo0rx13JyBBMGXOd3QpqXiYlKZqv6tczRlJdYxwB6DtV3kd3BnKO4Q6a1zDJuMEH6EEWPklP0lF+6F9GyHbZufBEvrrk6wlrOmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI2PR04MB10713.eurprd04.prod.outlook.com (2603:10a6:800:275::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:35:21 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:35:20 +0000
Date: Mon, 1 Dec 2025 14:35:11 -0500
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
Subject: Re: [RFC PATCH v2 08/27] PCI: endpoint: pci-epf-vntb: Propagate MW
 offset from configfs when present
Message-ID: <aS3t78Voh6tdWSCu@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-9-den@valinux.co.jp>
X-ClientProxiedBy: PH7P221CA0084.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::35) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI2PR04MB10713:EE_
X-MS-Office365-Filtering-Correlation-Id: 59862967-99ad-4c73-5961-08de3110c3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IkLrg4HaIQMt/Ousa4Iaw92NqI4AiU+RyfvUVEjFmYQhnScEjvRlvjgOKmeC?=
 =?us-ascii?Q?k5N5PVc0IZ0k0GE7uXbzuTTEFRN9/4T0i64byJcsrY0bCJcbhG15c/FmVHPN?=
 =?us-ascii?Q?+FMI66FJDg5vCUfNp32jiw9Ip+vtGCJFwpnmltQYBWbSyHevnHHT34VLYLdm?=
 =?us-ascii?Q?A185ytD6xn0s4HKxqpY7F8Nu7Q3+Z8wExkzYQsAkX465Rm75WH05Oh/QmxI6?=
 =?us-ascii?Q?in8CgHUTbDJJ8F+m9inBPlF8fm/JNdEDMxtOqmHhaL2Ir/7bUrIt+n6Kbmip?=
 =?us-ascii?Q?t493g2rq/5kFlXiYW8cQrMkJ6mTiuoCsxGzrBzu3PISlSOGAFpiI4jhvHIX4?=
 =?us-ascii?Q?7yVBwCvt6zJ2oyot/50GBYC1D8jY3odSID5IGzk4p3i8vlKPOrfQce08K8ay?=
 =?us-ascii?Q?9nCK4I3u9aukT0bbpQKpu7uitYH8vSQKR6kuVzZC16HsOo5iJAf0XPCcM/i8?=
 =?us-ascii?Q?XyPEl3Bo50Zox1R6XSUqNo4TLRFy3bRaZEmVXpCnuKwdMoOQWO8f4BrJJh6g?=
 =?us-ascii?Q?t7/oW85jzNHVmPi8zuc2DooSwIsxrvFVkUlxRTrySPgxng/F75SMHHtUDTj+?=
 =?us-ascii?Q?BVsAlvdLD7WDAdNxWRXRumzGk/AadAR5XL/Qytg6DeH9yRroKIPxziQSzIcQ?=
 =?us-ascii?Q?RcmV3eG6A7IpqwA3t4jKNnq5iBWz7XtMqhW+jvJ+N2Fb5ZKf1C22MlRW/nsT?=
 =?us-ascii?Q?ZfHY2pTTWKsQ5NXorZs8y6Yatb3aL/xKmsiYxHhk5YWBSJqcUKjKs7S4Wazh?=
 =?us-ascii?Q?+ZQMHDJP3vjVTil70c1QqwaT8vya0lcHsJD+g0aB1HvEXOdT8OUsChVNdEdJ?=
 =?us-ascii?Q?jt9YAiZTlYHWQjeWgT/kd9pYsNrZKLXH0y6x/SpywEAOFPxTvwS0AxicDLyG?=
 =?us-ascii?Q?AtmxGNTJtYeaTK5wekxfxMeQzFsMCJElRlJef7XrUiFd/wGgww/yBg8ozvNJ?=
 =?us-ascii?Q?v2SsSJ4ctUahIQ+5WMLhZiGBu3LpSsylJC9xX5Fl0NNIQ7v4YHh6zp+SNlmW?=
 =?us-ascii?Q?4w6gUHTiNDcNgWCmAUyfrPYy9v7LUbLeRHg1KP+ua9PxOS7BHBwvmQk47u6v?=
 =?us-ascii?Q?Q5rkoU8njcjzcegYXFp3BiRlvjLXYuR+vf6iD1adOK9Spx6QSV4ujQvZGeRE?=
 =?us-ascii?Q?XLAvVr+95vTJN90igzU7IlzJB7tkQeqNTvYOb8oaAmX0PY3p7XzGS/yK3kZa?=
 =?us-ascii?Q?MCBfmNR6i0OBs+bEc4Asdx3LbfuwVVID2GvSha7OmPUHsM4FVWDrGERmwFcG?=
 =?us-ascii?Q?IuWpaS+XBfA27i5/55z/cG5zu8cCRMhVuBtmkryz+CoN/akQI7x5+gjEsLcX?=
 =?us-ascii?Q?8Rd8DC+ER+aymqNPjhdcZAl70SxlEEefQxiTABZ8/BxcEvipKAHHAZpyCRlo?=
 =?us-ascii?Q?xMmz8YFXyKJd/yGUqgvhlNfBI8UKgXpfFU+7tqDL3XLRxVOsi0DN+m1dsNMW?=
 =?us-ascii?Q?UpqryRZB76vhSq0OwT9hVNBuxD02yJls6OKKWwxdtOWKTfcyZsfmUd487Y6b?=
 =?us-ascii?Q?VelGK7c5h019Ja/iWAwOh1fa7J6/DQJHMvCo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRvJM25QZIbWDhcw5lx0RKnDyQoF82eezk0rT0U9z7obEuXUiE7coNoPWtIo?=
 =?us-ascii?Q?6qVsTl2ilc7Kpxvl6jhzj/IIwueEA0i8vyHnhpSirIyGVhHtdcq+yZTxJ15F?=
 =?us-ascii?Q?6B/SHv9iDITei1kSL/IcYaxrPnnsf/QAHnWcyifmoRRJkE1zCmCfNgj2QkKr?=
 =?us-ascii?Q?/GF9ryuRavmb/WUjPrhSLYu6aW6pmH+VK1LuwLEMGH/ZFh7PJVhYB+n4RMvK?=
 =?us-ascii?Q?MMrB/n4qturciqsRdjRa3/IVBd49NdSGwReV2hwS5bQvK82bcniGVG2UEuRc?=
 =?us-ascii?Q?COb3h4eywgU5t414SQXlGOS2MSviDipsQH1dERFVKwMjvqTnnc3SV3XBonP9?=
 =?us-ascii?Q?cR16D0U7Um7Id7Zy7bRttPvblbJYgcPsMFBA/uGO0lPbit/T9TPz9xFsZrkm?=
 =?us-ascii?Q?hAzJP91HoMyG7mE6H1cVO/gzSoCtIamI6HH6xPNyuyA6VbhK7aqLwmTDtEA2?=
 =?us-ascii?Q?pVyCFLJE5anIEuE9zpIf+g6vgcD6iezgTysArwcZ6vaDWT1dmQtjA5JV1V0a?=
 =?us-ascii?Q?HGT7MCp3NJhwaCv77WpuuN0niGfLByNhPw7O/vjKowrfvo1bYO/OvK/ywdLq?=
 =?us-ascii?Q?eM5hKAiV3Se4SzR768i3AN3oCVvk2q8HHyd8P8vXwMAyGChpg0GlbYJ70l7B?=
 =?us-ascii?Q?C+ycf+rV5MIOq9nT+8VgYJPNwPRk83RJpP9sfbnAAH+G52gdB9W0IbAuekNc?=
 =?us-ascii?Q?pZPNWyPEiaobZ+1zXUg6jeIcu+7Att8Y+YXIRk7Ktdx2j+LPV8r74T2m42f8?=
 =?us-ascii?Q?MAbnmH6HEitHmGIunS555VVdmp9fitO/qtAnUXsxuB45uMCBW+FM5YP5ViMs?=
 =?us-ascii?Q?Sgf2RrXCoy1pcdmJV4K4HI4+OOjU/OtA6ITQUfgD2AhDd1DaHSdqRtBsX37t?=
 =?us-ascii?Q?onQnlXR+QKUjabaCuB09cFnMEb2zymTXuE9MQobguzfGFzYeKw8ZKfVS48rJ?=
 =?us-ascii?Q?vPGFa5LG+ZzoUXi8anep2uGdszg2a6E6cnnG777OifucwpUIxy2anqXN/yq9?=
 =?us-ascii?Q?/ND2EUxGrFPQWriKlfntMotVolg00YQ/I9SPNSZuiN5ZtQm8tXdgtpsPVZqg?=
 =?us-ascii?Q?OiIUKXMna0mKJp9C9vSWWGvvNFajh/aSY8j5e5jjCCD7qL+0vukFrInO8Ger?=
 =?us-ascii?Q?4/tCCNo7dFiP/HXpKZMuulmNa1Qtd6RtN5ZPkVLQo6z2vDbrAHqH6/trfoy3?=
 =?us-ascii?Q?+HY1Jef+ZwrJzXyjPf3nwYiTaCIt+/83wAIC5C7YgJPDUyD6z83JmDz3sS6j?=
 =?us-ascii?Q?hDnz7mbkI50Tv3ylC0K+Ba3hds1oPh3j56lg+6qe8oUcLgtXdyXOkvPdoaTf?=
 =?us-ascii?Q?g6S/4PW7BihBhuvAxd+1GW6+jGt+4I8GW0ok6Z7VNPCPLyyfThP9D9SlcDuR?=
 =?us-ascii?Q?Zlx2nZhmLqbYzuMzzzzaozt472QfOmLrdIpQfnBV1TRXdU4Gm69DhlD2jtn7?=
 =?us-ascii?Q?aAbv7DWwNgxDIo9Hw5vPIJnu6Kdb9rUAf/FRG0P+DUpj//z+Qu1xUULlF7Lu?=
 =?us-ascii?Q?D4234tkRwhkZ3vZJq7g9VlIKqxB2wMJJ/HY1d6yASHVWCXGjkABTgxy3xJAQ?=
 =?us-ascii?Q?l9m1D1s8JMkA/d6+h8U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59862967-99ad-4c73-5961-08de3110c3a8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:35:20.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgfo18aWYOYLL9CTfe+Qo4mE3cJb1dk6pmqsoo8dG8in8NK8QnhVH7V9NgycSUdnZZOSE/0/SNL+C+6lks1j2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10713

On Sun, Nov 30, 2025 at 01:03:46AM +0900, Koichiro Den wrote:
> The NTB API functions ntb_mw_set_trans() and ntb_mw_get_align() now
> support non-zero MW offsets. Update pci-epf-vntb to populate
> mws_offset[idx] when the offset parameter is provided. Users can now get
> the offset value and use it on ntb_mw_set_trans().
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 8dbae9be9402..aa44dcd5c943 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1528,6 +1528,9 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
>  	if (size_max)
>  		*size_max = ntb->mws_size[idx];
>
> +	if (offset)
> +		*offset = ntb->mws_offset[idx];
> +
>  	return 0;
>  }
>
> --
> 2.48.1
>

