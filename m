Return-Path: <dmaengine+bounces-7443-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ABEC99144
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 21:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EC714E19A8
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 20:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A32080C8;
	Mon,  1 Dec 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WctjPnoe"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880421B9C9;
	Mon,  1 Dec 2025 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622071; cv=fail; b=kKUjco1wKuXvPy4IT1F0tiYYCW52jZdlSvXgIRLtvrokf7keZ5u0o5cHsDDzgTZjC2U/yplwXjbSvRIxc0Bzqdx1JeEufSe/5wfNNG9zEi2atEdbZfpoyYOaP+3IclHlkwYrLU6XlHOJH8Bf3DP5+irrAMpkWe3bG+G50dYto4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622071; c=relaxed/simple;
	bh=O94nOBdXJWIrzyRkJ6G/N+cIWkWWA/SS+55GFitQed4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qq8HZ4FayNw7k1a4f2OhL2P1Hiq6/WxxZHE6bFWp5q9EO3VT9ifC9+/E+Tu0Y6X1WEIhIG8/4JDHJjme26zEZNgAD/EiyFG4K8VkJGXGr6VIG250ip25pmON+BAn8HmEXm1z2xwTXWE9Jaxv8o/S+0QO/4vK1S7H1r0rRCs9VV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WctjPnoe; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYIEMaZVPOkEjEUJ9Vuq4AIKOMgrNbpUiOy+kK9KPvZFkj0ip4JsX2YASyhEAkprsA+qnQ7indaxZc8fWiTRmFtoMtjAMJ9GBw8XVi3+rZiCPrxXa6wgwPozgpLLMwHcUmqKimo4mZe1ZHap4OJo7w1P7dPMoCa8HE2MhFxsr7SEVT8uNQ6kuy8+lDC11lx9kq0kLq1Btm+PAm7obxaioldKCb+oZrl9+6eeQgqVSj3GNFwXxPKtFFL2LetAhK/tW3PkCDCOrAeaUHGgi+ZbJlZiEccwv1n6ev1suhkkrNxHNlTs8UtAEOQ2lDUaehYhyHrgWdcOiYLAYKVuIkh5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=booZ/rDu6moZ22icfAqWrAopUCxO9RgY8V1VyBTPiTY=;
 b=XWi96XJ51bQfppq62tl3Vnx5YdB1MK3srcRdbKKyndWRE4nMZ5ZgVJjjBW+u+crMyXx/VAoOA/jreVKiCwpxU2j3z0ea2bzXHok54Uo4dIzCeg+PIZ596Yyhq5mqLpw4n3Hsiz1cgOAWMM3meAZdUMi3TMbZsol6kkRmeVOqJ+gkeyz8u+dwr9XYLEOus0qame5I+N0lGbme7fJSVKBtW/IP5Qh1VTzQw3miX+gGAqQ9y2CApR2GvC6Kln+qjSojRbtt5LHDBld2bltu0tePrXFJOVs0Lynwm1DDWpmu0qaVM2yDrZxVc+ZZULcrvBjrxA0bP6gZojAdajtbc7xrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=booZ/rDu6moZ22icfAqWrAopUCxO9RgY8V1VyBTPiTY=;
 b=WctjPnoed3AYnTdpKv3u1qTeuqCuQ2P41FDb8rlXjxFpTsUhVfJssyn/Idh7iUVOAywSrTEsADD6sWZxFeZJHIQGDsLS4lD1fFna0mwHAOlL7/aQzOQqL1mIvsWSZnSg0w5CF2C5g3AaNiZLSy7BFtmnVT0KF/gdzRJFNzKtts2eFpDwztKrmAhd94co+e8xs92bHvo3TF9qUnUtLWC/nJsJR0byxxWgj1gRRK8+IEAHBhh1wjFNtapARmWiZcwcZnpXa4ZNfefNvkS/ZwpQ7x3Ak9lfEbAsu7x5aKp3nCcP3D/aPN3aBDl69ngQXn2YAjczJOkg+yTdUOeA/J7GqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8493.eurprd04.prod.outlook.com (2603:10a6:10:2c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:47:44 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:47:44 +0000
Date: Mon, 1 Dec 2025 15:47:34 -0500
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
Subject: Re: [RFC PATCH v2 23/27] NTB: epf: Add per-SoC quirk to cap MRRS for
 DWC eDMA (128B for R-Car)
Message-ID: <aS3+5rw16xgMCuwE@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-24-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-24-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:510:323::22) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deb8687-fb03-4907-f773-08de311ae085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b79AHSA2Bacy+uGOKUASPPlGjjPGjX3K0AGPBkGMKZAHTDL3irV1W7CKM+FU?=
 =?us-ascii?Q?oKlLzV8+6eoHq1SeD0QShXSGefdcywkv/ZPDzNXoK+ejOEHqvGbaKozeSKAO?=
 =?us-ascii?Q?RK6VuY8zLdiXmzknA2VE7gPZrv2stEI74cIHhetEa234j0BSg71TtkfnNr09?=
 =?us-ascii?Q?6ikOhRsGG9kMuBob5qDDwNiTA7xS8j8Ln/rMZTrv6HlFLJITsLLHE8z0GowK?=
 =?us-ascii?Q?VLLVcyjI7nThn6auwdEXBP/+/ImLTncWkmZhzXjnjKG/88kOlCEJLgGOeJZf?=
 =?us-ascii?Q?F/PIdiObVGebYmMGxRZSDBGE8ys0zBDnPfcnswDcsTu0D6CFxjmOxVfLwYBG?=
 =?us-ascii?Q?fGNwZmoBJpWGeFqEhhlZuuI7NqfwhQ1U8QuQIsSpBymHPXXRof/w7GAtlx9E?=
 =?us-ascii?Q?iKCh4DwB99enpoV8f2i3P/cwBenmThdK/EYu0I3h9/xAb7zj5T51VJC4Ng3f?=
 =?us-ascii?Q?WH6xIbyGZCjxuzULuMmz5rbZr3KP3hdH+EqIeQgY0YuYwVQf5S1WIsBmBM0Q?=
 =?us-ascii?Q?Wlw5jeczcwDDvFYCmSW/cQYjHwRfzu47TuvBffBApb1uryPUGLVk0/dHBTlV?=
 =?us-ascii?Q?RoZoJ+EcTwZryv2EeTqst6gc6gXWZdmLYYxJ1ks3/YbpghoHL4q2B0Utw81d?=
 =?us-ascii?Q?6r09/JlFvEdKNUYrXt8aKOhWdcb3/In1Lp63vTYEURGMBLOF21vusErADhZ2?=
 =?us-ascii?Q?fFjug+qMsWOIVR3ECIsILODtLwohZLvrE7q0CAyQqboZWliVWzoHsfYpbUxb?=
 =?us-ascii?Q?Dai97oBUU0SwBLSQnLiVGSv5zXqE30UwqY4zSo0qsGYAfWS+ktKrxKbDun+o?=
 =?us-ascii?Q?t6IHz1uWo88KtjNIgEhw3epETb8arBC9uMTG3vbzM07AZ3gLbwJFj1nIWx+/?=
 =?us-ascii?Q?e1h2/Lf0aC8Q6U3LI05W9DEuTxnRvRvZ6frjDB9eRHk585UFRT2H+3McIOnj?=
 =?us-ascii?Q?uWqthE7uAGMiEjuyLOS6t05umYQeuTwP3dDF1pvJ5N5byotY+Rc25Y2XECUd?=
 =?us-ascii?Q?IxGZiKHc14wkuAVP7bTSgY3CEnW6uKE37tfRKEf1t2kf1OX/YtgRpLBVji5s?=
 =?us-ascii?Q?EvYdkN/HGLAWriB0YC1JFySzTXc6y/BQ9MMpJSBJ7lcNGVD67CbCywcStYnm?=
 =?us-ascii?Q?jQn5M6TuT0jtk/wgNxGDVruMyjUhWzBGYw2CC1eM4huhfWMh/vRa2q+1te1J?=
 =?us-ascii?Q?YRajcd+950RhBnHZkBx0MdOH4knfyU+v3uTZhpCunu4Q4qZKOH8RMB9Sb5+W?=
 =?us-ascii?Q?QcCETKBZvX8XVN5auV+RV23irVHA5gCQwiMjtweD8aNLD5LbsfJzF4ly87Vy?=
 =?us-ascii?Q?IYBtrng3BOBe/UDVuaedHpnVBDnDozzS1kJRWVM+Ud2sEwfLhoVzsgwU1jqO?=
 =?us-ascii?Q?80OxqGVNPDWKujXI0Gf4T1QG/k/GXXxlqQyFSZFOYR2zmUKyJGFXlpZ8iXmu?=
 =?us-ascii?Q?og4XXESvQyiaaoc3FXymbiockbM/fxt4CDB81GAzutBW1k11tOVxyaF7stWR?=
 =?us-ascii?Q?p8xLDCptr2FrXO3beZYS/qGOvkpZHT6DFiYn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GyoADMNvP0qJFNmwc1fnqQLXYJgsJzn8XdY9gfQnYiIIArRk8UVgj1ODXyj2?=
 =?us-ascii?Q?BVysJxSh1vh22qQ1IY2a1N6S8CSkdaPuzCYadR0aMdLiUiQ3rm0wJ3SZFW6r?=
 =?us-ascii?Q?b94g652ybmAnrAvlGThYgRR971WKLe06RKKoumZ5XFdEPCOMpwPuihoKMjLo?=
 =?us-ascii?Q?2ffG9pHZBEOI6vx+arNcr+1kFPJQkKdZFQLSetkEGp7DQwNDvxvfZ9oSqyUw?=
 =?us-ascii?Q?kasggNft3Dicp2S0fIBg9++fSte3TFgx93u3fhwrFD9/zaDOPiyc5kx0w+hM?=
 =?us-ascii?Q?90mKy5DGBJDrqBRGJL0Vt/RSkNFB/jmSWIyOVlw4enRtl1qIMKB8bNPMoL+M?=
 =?us-ascii?Q?zRlJryqIg+4qst36YJ8hyx+SPkrc7nQ1gPRh1tGWWRWg7Ogv8kwLIZxqLlch?=
 =?us-ascii?Q?xPoBB2c+yc/TmKWDCeSVR/q+RsyEYQwz2Auz/UMluoFIad5D3IZg+IbHzWhk?=
 =?us-ascii?Q?/xC8R9QqQmOR6YddDaxm+HuTULhSqJZy7JOwAKIIElQlRXqSf9b2CCwoqOrd?=
 =?us-ascii?Q?4CL+3FI5i7WkvpFqvSllr/qJlDZc7wgVA5/7EsIEEIWB4G5mMzSQKEipbaEN?=
 =?us-ascii?Q?4EA8DgZuvfKQJ6sOyYsvfsCSwUjJvy9pKP/Nb/Hq37Jz79a0TSCsorZ5gpkd?=
 =?us-ascii?Q?dEQNYYppwHNKiVtMj7HWS0+rAwXGF/JdQ5elYBamFyRGMVcgUzVvHDJcIsy3?=
 =?us-ascii?Q?TQdUbbBP4Eq9zlqCAJcU/jU/opxE7TpiHNMKyrqRbWX98M5osqz8t/o0C65S?=
 =?us-ascii?Q?QVr5j+Zh1a9D0J9AUwHwhvAuHhby8jghOBE84re3ts3z/HvVIRcZk2pSqkzP?=
 =?us-ascii?Q?PgEK7cAp2usPs0V2gebRQww28sfoNe8N4x3tq0rib4qSUSvbrqoVogYGvmFv?=
 =?us-ascii?Q?Gm+3axiGmbmwzvH95P3RW3YRFVJui33O6a9fGAhjndsprIXdAiOcNQB9+/Sa?=
 =?us-ascii?Q?9KyRTABpkMFZAsaX7U1BSOwN1o5b1ZeNBffiwWf8saTkS8XuEkk7VutKoNLc?=
 =?us-ascii?Q?dcHHJsfWxJtqP5XE00zE3WntsbFlCk4y26o1p+o7V+/7WUy7vak7dyX+ZMJ5?=
 =?us-ascii?Q?5aVQ2yrOMjH0PCDcpsbGDWPflf6TvqARF4dubQO2Gf3iVCR/Tviqdk99qSjv?=
 =?us-ascii?Q?DwLqweMhHpdatSVgSefor1AFPALGxOvEtQyKJaMzou/FFankGA5uA8J1O8Ni?=
 =?us-ascii?Q?+H29dCT12zy4EPwTSQIjklUlJnTA7unzEFwWFgOxHBBDO9/tG+ZUSCRcP9K3?=
 =?us-ascii?Q?DE+pi5A4sOzbrdrnze17CPhj5N7wBD/0ooIoNEzBy458Q9GQYgTyiHfjetHE?=
 =?us-ascii?Q?4hiF9RG8oedqJPzgFG5wQvtDOdtNQ5Au03KqVWzR3kWUOM4Hskg6a1jopyG9?=
 =?us-ascii?Q?xw54TUPBwzd30B83Zi/yvWg/M5zryX5Xt9oug0jdH99vLH0PuKykpRhJL7Px?=
 =?us-ascii?Q?CXNTlpcKr3K+xVjZ+rbXJQDXF1jzw4XcGUq6hue4jqkPG7IsO1laissAlsm0?=
 =?us-ascii?Q?s8N8aFKapdF6U9/N+Qb4jUyY8534zOBbHDozd1LgO+oh+FuIKgK75O8sONi4?=
 =?us-ascii?Q?dYTV9k6lH112floczra2LM7jXutl5bdtGKl1j2lz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deb8687-fb03-4907-f773-08de311ae085
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 20:47:44.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fn3L0bqu5lXkrM74gHinB6nbA4MwlYRtt7LroAx4q5Q97pitHkqnWEuc8TbXdPZ0XHZQkZWs2rnkRib9201rLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8493

On Sun, Nov 30, 2025 at 01:04:01AM +0900, Koichiro Den wrote:
> Some R-Car platforms using Synopsys DesignWare PCIe with the integrated
> eDMA exhibit reproducible payload corruption in RC->EP remote DMA read
> traffic whenever the endpoint issues 256-byte Memory Read (MRd) TLPs.
>
> The eDMA injects multiple MRd requests of size less than or equal to
> min(MRRS, MPS), so constraining the endpoint's MRd request size removes
> 256-byte MRd TLPs and avoids the issue. This change adds a per-SoC knob
> in the ntb_hw_epf driver and sets MRRS=128 on R-Car.
>
> We intentionally do not change the endpoint's MPS. Per PCIe Base
> Specification, MPS limits the payload size of TLPs with data transmitted
> by the Function, while Max_Read_Request_Size limits the size of read
> requests produced by the Function as a Requester. Limiting MRRS is
> sufficient to constrain MRd Byte Count, while lowering MPS would also
> throttle unrelated traffic (e.g. endpoint-originated Posted Writes and
> Completions with Data) without being necessary for this fix.
>
> This quirk is scoped to the affected endpoint only and can be removed
> once the underlying issue is resolved in the controller/IP.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/ntb/hw/epf/ntb_hw_epf.c | 66 +++++++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index d9811da90599..21eb26b2f7cc 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -51,6 +51,12 @@
>
>  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
>
> +struct ntb_epf_soc_data {
> +	const enum pci_barno *barno_map;
> +	/* non-zero to override MRRS for this SoC */
> +	int force_mrrs;
> +};
> +
>  enum epf_ntb_bar {
>  	BAR_CONFIG,
>  	BAR_PEER_SPAD,
> @@ -594,11 +600,12 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  }
>
>  static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
> -			    struct pci_dev *pdev)
> +			    struct pci_dev *pdev,
> +			    const struct ntb_epf_soc_data *soc)
>  {
>  	struct device *dev = ndev->dev;
>  	size_t spad_sz, spad_off;
> -	int ret;
> +	int ret, cur;
>
>  	pci_set_drvdata(pdev, ndev);
>
> @@ -616,6 +623,17 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>
>  	pci_set_master(pdev);
>
> +	if (soc && pci_is_pcie(pdev) && soc->force_mrrs) {
> +		cur = pcie_get_readrq(pdev);
> +		ret = pcie_set_readrq(pdev, soc->force_mrrs);
> +		if (ret)
> +			dev_warn(&pdev->dev, "failed to set MRRS=%d: %d\n",
> +				 soc->force_mrrs, ret);
> +		else
> +			dev_info(&pdev->dev, "capped MRRS: %d->%d for ntb-epf\n",
> +				 cur, soc->force_mrrs);
> +	}
> +
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>  	if (ret) {
>  		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> @@ -690,6 +708,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
>  static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  			     const struct pci_device_id *id)
>  {
> +	const struct ntb_epf_soc_data *soc = (const void *)id->driver_data;
>  	struct device *dev = &pdev->dev;
>  	struct ntb_epf_dev *ndev;
>  	int ret;
> @@ -701,16 +720,16 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  	if (!ndev)
>  		return -ENOMEM;
>
> -	ndev->barno_map = (const enum pci_barno *)id->driver_data;
> -	if (!ndev->barno_map)
> +	if (!soc || !soc->barno_map)
>  		return -EINVAL;
>
> +	ndev->barno_map = soc->barno_map;
>  	ndev->dev = dev;
>
>  	ntb_epf_init_struct(ndev, pdev);
>  	mutex_init(&ndev->cmd_lock);
>
> -	ret = ntb_epf_init_pci(ndev, pdev);
> +	ret = ntb_epf_init_pci(ndev, pdev, soc);
>  	if (ret) {
>  		dev_err(dev, "Failed to init PCI\n");
>  		return ret;
> @@ -778,21 +797,52 @@ static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
>  	[BAR_MW4]	= NO_BAR,
>  };
>
> +static const struct ntb_epf_soc_data j721e_soc = {
> +	.barno_map = j721e_map,
> +};
> +
> +static const struct ntb_epf_soc_data mx8_soc = {
> +	.barno_map = mx8_map,
> +};
> +
> +static const struct ntb_epf_soc_data rcar_soc = {
> +	.barno_map = rcar_barno,
> +	/*
> +	 * On some R-Car platforms using the Synopsys DWC PCIe + eDMA we
> +	 * observe data corruption on RC->EP Remote DMA Read paths whenever
> +	 * the EP issues large MRd requests. The corruption consistently
> +	 * hits the tail of each 256-byte segment (e.g. offsets
> +	 * 0x00E0..0x00FF within a 256B block, and again at 0x01E0..0x01FF
> +	 * for larger transfers).
> +	 *
> +	 * The DMA injects multiple MRd requests of size less than or equal
> +	 * to the min(MRRS, MPS) into the outbound request path. By
> +	 * lowering MRRS to 128 we prevent 256B MRd TLPs from being
> +	 * generated and avoid the issue on the affected hardware. We
> +	 * intentionally keep MPS unchanged and scope this quirk to this
> +	 * endpoint to avoid impacting unrelated devices.
> +	 *
> +	 * Remove this once the issue is resolved (maybe controller/IP
> +	 * level) or a more preferable workaround becomes available.
> +	 */
> +	.force_mrrs = 128,
> +};
> +
>  static const struct pci_device_id ntb_epf_pci_tbl[] = {
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> -		.driver_data = (kernel_ulong_t)j721e_map,
> +		.driver_data = (kernel_ulong_t)&j721e_soc,
>  	},
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> -		.driver_data = (kernel_ulong_t)mx8_map,
> +		.driver_data = (kernel_ulong_t)&mx8_soc,
>  	},
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0030),
>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> -		.driver_data = (kernel_ulong_t)rcar_barno,
> +		.driver_data = (kernel_ulong_t)&rcar_soc,
>  	},
>  	{ },
>  };
> --
> 2.48.1
>

