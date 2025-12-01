Return-Path: <dmaengine+bounces-7433-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E087C98D0A
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03F0E4E04EF
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873C823A9A8;
	Mon,  1 Dec 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lemvL//7"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A58219E8C;
	Mon,  1 Dec 2025 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616459; cv=fail; b=UBpapy9iybFPcjkHq5B6v8AN0h+FQlfLurERcKe1G4y442C//LslaoQmu+Ry4ViPVw5aVXpUE/9pqL+eoz30whM4Vc42T6YTLGh8SD2IcPNWUPr+KTRLbx5R3VSHD7VOkDF0wYspc3nuGMME3aFlEwDgkFtesntfJLg+Mf8ep44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616459; c=relaxed/simple;
	bh=ctZHF5JkVM8oYqnSxQFwXbk3xNHcNkldLcHIbe+V9XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=llJh6AS7UoEz6UG+Ajyaw3vNSzCkJUaW4VsbVMy+4pUROVzplnWK3z6Hd8VL8/4n2MNH/YSrtGOxaC8niu1uzHscFZf47xJmHlyxBW/XMzV+NvweWVXg3rzODpHw0FEtV7l/Tws1lv2LMfSLn3y20M1raXflHfpKelPcOmLt/rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lemvL//7; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaNqf0UgHPyrD4wn/5OZ8R+8WOSiNcEYnhwK/tb7yEiPOedI/7hvqBf2B6Y3iBWQqk/Eb7xMTeumBSmVHThXyyzuQrIyh2JpXf83R/EBVSi0qoaq25t7RHLOJ8EqSiSq+6DLcZcmK2MZa7fPspV9Vt6lO3DYV9MHaX2DXw8bJgBwmWJ/f+O22FbNxgdvVAvty8n4zbB/2zRoxnjOFmmtmvMxrGS0Dk0TwHNmfKjrKpeWg9LeuoHLYjN/E5IV/g9HeZhvUU+dhzKXGISIo6pF44yJRmtbIAXFZV9ubmEz0IaKMcIoEgxPzZreWRRn/m0YR0pjJrGYYJ2JNX3TZcXU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMEzpMUwXwX5ZFzP8UIUbZJik6wg+bueItgxe7O+Reo=;
 b=Q3rmPqYvsugc26f8DlVGfikwW03/7pC6XlZvSayPcR0Ho0CHk3bFvRZjuuRC8gMxFhunzRVw9z4ZHTeRkwuH2zv10UKOapjzQvms99qAQHMydg2gOJpxWjCaf2+YA6N7B5NXUEZaxl3xjA3pnuM+9eWKYGAmWMhLqC7rIaUlIl7hKNq1MgQy/oVDIBlpXoUjxlU8fxx+FBDXucUavv+tqhYHjnQEO9XsHGCLnAKnu2dWzT14kQi7QN7oDu7vvyLE4Ap5hYWNmZdlZS3ZRkT1qOJwdpDhHDgoOK8AufC1VbSp4K/pTzWQgbjPOc2G+HnfNGGa6Ug/S2E9oeApkTPfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMEzpMUwXwX5ZFzP8UIUbZJik6wg+bueItgxe7O+Reo=;
 b=lemvL//7E+xMtgxR5eIYocM5OWfa67rEMolqmB5udpr/HI3/BSYt1uMAgVpib4UJkDLnDHSAXgffjlOBRyL4i3vI6+dYFGNJ/UR5ocoVFWaVQLYX8xUN9hl0qHQVrGEtdEv3cMnTXlVqwYLdqwu9UZlUITpnblTwxduQXOIAJ16xxTxQ1gb68Od+NhpvkPddS6yDllhqf3s+APcjU2tx7teMmAHlpObSTMdMx/epxVoPGC+rVpGyU74a+diexymcUa8hCdJ/kvPBgN1xAOGDaoByhleAab3ynEAaKfYhrFL9tDVCwSamRXEKONFukW7M5a4ii/Prren3iTlcEFs3mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU0PR04MB9321.eurprd04.prod.outlook.com (2603:10a6:10:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:14:14 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:14:14 +0000
Date: Mon, 1 Dec 2025 14:14:03 -0500
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
Subject: Re: [RFC PATCH v2 03/27] NTB: epf: Handle mwN_offset for inbound MW
 regions
Message-ID: <aS3o+6y0WTyeuE5r@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-4-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:a03:60::25) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU0PR04MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aff2622-c7a1-4871-0a7b-08de310dd10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|7416014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X8u44V0MmUGkmOK2YuP+UbZJuRC4xstAGmao6VKDCfI4EOxhJz/s/pnJPvK2?=
 =?us-ascii?Q?8+5vgoDXVWBOBzYklXLdnx/ETy8kLa4hwX0OfPBBmVur4kcsLK8OzpzI5PCh?=
 =?us-ascii?Q?P6Vo/gr37whRt8cAHVP8Ed+kOn56AaV6AsnbU/9vgAbJx+OYw9orPhiGceTh?=
 =?us-ascii?Q?w1BqhOk+am01ufOabZlLTOm0pMbWIHjfuMLHbXEl6KSwRVnvkrssecJW/3ox?=
 =?us-ascii?Q?hRsqUpk6Nb6pPgr9wAKs+CXKwiD3iS2mVvAxoXFohGUUwvviBgdJfvjH1sku?=
 =?us-ascii?Q?vQGdMjo1LO5KC6spggvnLl4D5ep83We7jRswBBJoFb9TcN3JpaCnEZERU8hT?=
 =?us-ascii?Q?ZseI2N9Odzr2Y901EEzs5Eqg9SYpMU3pARoCH69vYKPiTMxdL/98wxzCaAWi?=
 =?us-ascii?Q?YG3qqdwY41VUgVQ+4WAnhFLMvNF5likE49XiC/+JnntBM7aRE7U1T9wHlmAX?=
 =?us-ascii?Q?qO0QorH1PLkr+XkvhJe2i0eG2ODHappb2Gc4LRAdk15woFcD4VnLOzn+kEDU?=
 =?us-ascii?Q?G5DwSOX1oanGd26NiORoIwg0a1xajBDc8PQkV2vgX87mqzj4O9OcbxpW3FMY?=
 =?us-ascii?Q?Zn82+pTONIfTuddB67xhsZ9bOIzFUB0WUoTZN6VWOsMIqnB2KAlrE1aPi2av?=
 =?us-ascii?Q?CLPr1PeGiolGkWQltkM+z/GxvcntnzpgABp2HCdBxPKFWER/Hfxr37Ow5kT6?=
 =?us-ascii?Q?1oiG6VyiVxwN7V+kN9kFouL1o1Opp/uKexpyyVXVhJSi+pT+6XplKInnPWTY?=
 =?us-ascii?Q?oUTPAYsWDi6DZUvaHtL457sNcmZ2/BxIlQhUoUme3zqK0R3r0Al9QAJX84Av?=
 =?us-ascii?Q?Fvp0Vn7ZwoUFeOMvT9SeuixrG6kMF7YR16z3/W3nj15RgiuVjksp6o7Bbmru?=
 =?us-ascii?Q?+fwlW5MhDSfdZUAQ8Pd/IS+jaJha+mchHJj9JBY/Yd+Un0R/Li40nyn2vINP?=
 =?us-ascii?Q?wkIRZvwuBFrXIOsL2BdB0q7aIngrR0nhcAzJRF8BAEJ9HnLHcKj/VDwN5udR?=
 =?us-ascii?Q?i5zMnuKFGsmyzr7pPYh8LhsptHAwfwFK3vc9exNvbNIRurl2Qvi7FIXlpa9c?=
 =?us-ascii?Q?1kPOmzZp+LDQhaYGr3MvFKDy2ihab0Jw+/XHvaizwyU3ayyEWIJWZLsdx6qG?=
 =?us-ascii?Q?5myx45y+wIvXVj0q4Oz4cDO3Kzb2KlFH9Pr+DvTl8A5tlLPTbJmSyzHfPDQt?=
 =?us-ascii?Q?X8ytEL2tbYfX1j3sKQui7QbY8vFOZ2LxMh1pXdBBC80SdCkbXEw78djZmoIF?=
 =?us-ascii?Q?Jl1lNqWYi/5u6hflTDk59s8nOhUyIMBUQ9n0GqS0inuy8AUeFBhYy/yN2f2t?=
 =?us-ascii?Q?S07heoTcxVnRiZean5KjeTJUqe06Ez4xip8xfkTbWjCXW1il55sFtFo9I182?=
 =?us-ascii?Q?nmg6VfUyk3ABnjvFepn8TvgXVex/5TWw4aPW9SnTPWJXONQYBbYc6E8NnKEh?=
 =?us-ascii?Q?Q673QKi6F2YX18SZtGadpl830rqe5tyWx2W6TF3lA0xItfLpxUx89ybW4WO2?=
 =?us-ascii?Q?aRQLYP3HHVLgGud6f5L6HN9loNHenNrBsSPg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qk3NSv2Kym2UvvgnmmuMLTwVmTCv6nENLi45/IG39GT6mw3a6JO1W7VMGzFb?=
 =?us-ascii?Q?yDqoSrPlh0/t5bSkg4SyecRvKtU/t9BbUrcT99INshyOd94VB0ZOC8Skvils?=
 =?us-ascii?Q?1prN6BLYq4beyRbmvwTPnggOtTFJgI9qk4jqHJGfbXe3OkT9xUd+jvZ3kVrR?=
 =?us-ascii?Q?u2x3k4nKiqyxR+jFbMOmfEc+Ys5LRJ0iYI+w9cvv8lsVYtqFHiKLYaXUYMKy?=
 =?us-ascii?Q?NnGjFSwojbgJCX1b8nHgtBtZ3gpcxQXVIKusYobpNernxwsrqDp9Tl5zcIgF?=
 =?us-ascii?Q?VOUT7Xk9bXdymk5zHW3ZMQsHOHnAxZWPQ0oI0Zc1cT749+221sEJwf9cTHbp?=
 =?us-ascii?Q?Nt8t0dbgRvPgtrvG0xdl52FyprfFKhE7YdrVZ/NxvfYc35EZdI+Vv1FMBqZc?=
 =?us-ascii?Q?8uynK3vpF/zaMbKrpwzfLio4Xai3KKXJQ95o/YF9ypiqA/O1GakqqYxFDe86?=
 =?us-ascii?Q?//rgjgLt1dK45Ast4n0/vkLmUiOLwpljw7h/t1P/N4ug2KGND7xWXjxdMShp?=
 =?us-ascii?Q?2LQwAlaKFZ73J9w2HyvrdyvQq+uCSeUyQWJvGQW6uK68hT6TjNazWNEhe9fO?=
 =?us-ascii?Q?QZ+wxvID2xdXvk1Ly1eXe6atEvlWUd39BbnQMqkps24rZ6jw5Gorio+ifIqL?=
 =?us-ascii?Q?W0I48k5hYGo8dIt3R0gT9FlMgyD+P8mk12U/YfPSsE14zOpW362AqCXNczZ4?=
 =?us-ascii?Q?32PmsojVkOOCV63Eibbe/YQBx7mGcqyZGKs0tQjPu3yLGXtLM7hjSx6HlQmf?=
 =?us-ascii?Q?MWGL9NpmE2mdUWmk2fE7UUJIv9IjVSASZAwvzoBqKKeSKs3a4g58D+HKBxBa?=
 =?us-ascii?Q?0i29BBXROXvlrfHdlvYllxnylHvfxirKbiQWqSsjYwp+r29KYYcCIFIHEhK3?=
 =?us-ascii?Q?M9MC2TzxNzFiBPc7WwmbdyQ1tdKCwsZLfKGn6AX4Z8fCJPSSrpi1Gkdx20hK?=
 =?us-ascii?Q?IeEj1el2A3gUjCtv+ZTlxUy02NU8ySIt+8uYBtpjgGc3JcVhUmNm0zBfv8zF?=
 =?us-ascii?Q?zD4WDwyc/Y5x8nZLqluFetmOiJn9lLyY1lwt5g6s14i1Nx/DBsoIXJtxRWD2?=
 =?us-ascii?Q?aP3QmXbnJMS7s+XU04CRhFam/9j4YS16tge3dgEg9fjBf6VjrkjMQAMJTNqJ?=
 =?us-ascii?Q?5jSqKZLY1iv2/kyxpM3hD5Ic8mpmzzL+SF1b+Ac3OVsSUzQNbybxvl5CKwgp?=
 =?us-ascii?Q?JeG1DH+iPfYrDqF2gk9oJeNCb6HjsvuYsglS3rerXJ2qx63VvLCnrwfMQ4j4?=
 =?us-ascii?Q?RNeI90lk05Zq7wnQ2RCNuMoaxq56tSecI59NKqVjdyqBRwJKorU7m9abz+JX?=
 =?us-ascii?Q?2WqabYqo8p6TMwuEwIeQNPXprX3gvJTfnJ0db4gveap7FErxOh9h4VGibfyq?=
 =?us-ascii?Q?Z2s9J3kB3kzKUMTm7rPKcfh/oFQECNfezZMte9ZpXhr3G925qOka11Z7W4VY?=
 =?us-ascii?Q?sdIbQxLOGESMasANuAs7mtxMv14kN5E2OMJNExJlgdToQ9/MJUli5Lv3gvf7?=
 =?us-ascii?Q?CBy6E6OLu6K5sV6072SUAiqW3PPIjXGSl6dvYd2gvO7y7+lw5ki+p8agVEoR?=
 =?us-ascii?Q?h4wTBTZV0X1zlt4U1jWn/whlBfDWndQcDP3dabdQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aff2622-c7a1-4871-0a7b-08de310dd10f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:14:14.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y8gw82g9AmO+EztqRw7M0ER01ZEtsBpI8ePcSnDEBc88Jj74SnopMKMf/NzxoLGue5Tjn+vVmyfvgCdNBqq9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9321

On Sun, Nov 30, 2025 at 01:03:41AM +0900, Koichiro Den wrote:
> Add and use new fields in the common control register to convey both
> offset and size for each memory window (MW), so that it can correctly
> handle flexible MW layouts and support partial BAR mappings.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index d3ecf25a5162..91d3f8e05807 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -36,12 +36,13 @@
>  #define NTB_EPF_LOWER_SIZE	0x18
>  #define NTB_EPF_UPPER_SIZE	0x1C
>  #define NTB_EPF_MW_COUNT	0x20
> -#define NTB_EPF_MW1_OFFSET	0x24
> -#define NTB_EPF_SPAD_OFFSET	0x28
> -#define NTB_EPF_SPAD_COUNT	0x2C
> -#define NTB_EPF_DB_ENTRY_SIZE	0x30
> -#define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
> -#define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
> +#define NTB_EPF_MW_OFFSET(n)	(0x24 + (n) * 4)
> +#define NTB_EPF_MW_SIZE(n)	(0x34 + (n) * 4)
> +#define NTB_EPF_SPAD_OFFSET	0x44
> +#define NTB_EPF_SPAD_COUNT	0x48
> +#define NTB_EPF_DB_ENTRY_SIZE	0x4C
> +#define NTB_EPF_DB_DATA(n)	(0x50 + (n) * 4)
> +#define NTB_EPF_DB_OFFSET(n)	(0xD0 + (n) * 4)

You need check difference version for register layout change. EP and RC
side's software are not necessary to run the same kernel. Maybe EP side
running at old version, RC side run at new version.

Frank

>
>  #define NTB_EPF_MIN_DB_COUNT	3
>  #define NTB_EPF_MAX_DB_COUNT	31
> @@ -451,11 +452,12 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  				    phys_addr_t *base, resource_size_t *size)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> -	u32 offset = 0;
> +	resource_size_t bar_sz;
> +	u32 offset, sz;
>  	int bar;
>
> -	if (idx == 0)
> -		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> +	offset = readl(ndev->ctrl_reg + NTB_EPF_MW_OFFSET(idx));
> +	sz = readl(ndev->ctrl_reg + NTB_EPF_MW_SIZE(idx));
>
>  	bar = ntb_epf_mw_to_bar(ndev, idx);
>  	if (bar < 0)
> @@ -464,8 +466,11 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  	if (base)
>  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
>
> -	if (size)
> -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> +	if (size) {
> +		bar_sz = pci_resource_len(ndev->ntb.pdev, bar);
> +		*size = sz ? min_t(resource_size_t, sz, bar_sz - offset)
> +			   : (bar_sz > offset ? bar_sz - offset : 0);
> +	}
>
>  	return 0;
>  }
> --
> 2.48.1
>

