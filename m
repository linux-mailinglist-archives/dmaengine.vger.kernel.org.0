Return-Path: <dmaengine+bounces-7331-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6BC817B1
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 17:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FF4E79EF
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3B5315776;
	Mon, 24 Nov 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OBE8RRPe"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46056314A91;
	Mon, 24 Nov 2025 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000219; cv=fail; b=YbnLKdP3re5Ld3oOM1ohfDEvG7hDE8VF+LXOJdfdaYJxSyWD6O7JcYaG9tAaWu33gRdoc+aXdP0+kBU6zhajWjfZFuDzoZexBBWo/KI+yHj6xPJjjj7KXd3SZ+2EqAyrdsaHelnFCeEvBSxVLRvyP681IAekswx2F0T8V4meIK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000219; c=relaxed/simple;
	bh=BK8GiCI6wUlVBK0PPtwZ44/rJcYHMTEMfbl4pDAc9gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=anC1BacdT2x75MUMNwT3htdP6n06QcwsyypzVuFKQxKwfKjbh7dGM4NXn9xI14/Eyo6zsHi9atT/y624e+FM3mhskTC2AF0HvUtigDGOfZ5da7CHrUBIHLYJ2p4I8zJr4T+4Ni6ffBxdCT+rQz91THsAfZ7nNPNinHSPo0jtwo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OBE8RRPe; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lc3ovBqdDbFQqjLzHc8/JiRLmgLT3rdKNtcu7xE/fJarJZr0EdLZUG4e3SU3JG9yk/kO67kRUPVwuCLCPn0H6CqA/BIANBYbHGjm0SJiz7GIyVUj7ZbCli0V92oMw9lcTtn183clJA5lYHOp+13J+PUy/Ow0Dn0lfnJHCc/wGK2ZE0vY4m1cl+xL5SK/YjGbtsNoMs7xzuiqyXR3cq6MDVjP9S4DztJzg4MOY7cpssPTvvcGzTP0naHXjYLV0/3vLNqbW64SaylvnRMBqJ9BRreFpw6J/WCDEVHRC5HcyOpNhVfdK5FO2TQpWK381zGsmA3NwmxRXsfRWm9pkKUJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+6nD9vMdvGxmXgVh9pVF74Jo+sV6ST0AM/tB232bOI=;
 b=BO7oAInR3bB6eU7go1uPUGZ2oxPzlIJjJS4nE9wDrUAtGoKX/z3xXFdrlCxBtYheQe6Mz7hcVDMWAy/spKjZwB38pxNZR/67XfptYvNoFcIdTtaXj5Ea2vAg5nzQvmIbPaaDkhVwKM0LGg2PD3rx2WdsmuKlpakNBwBHCrnO0gk0onHxoQoLlwyeRc+Fn1EzY2MpED+BVKvvDSoYs6tqpbTENncM3iAcroDNX3wZsN6UQCzWQ+yL+TSS1U9tS7zwLlq4QqW0sIYcH8Od5yhfxc/wWgCkEwoCCb7VAVxI6j5saoQj2MLujTeEVqzPOZtGSgYDiNQnWntLNOrql0y8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+6nD9vMdvGxmXgVh9pVF74Jo+sV6ST0AM/tB232bOI=;
 b=OBE8RRPe6WyoIXofU4Lh8MORh2tiC8DPCO9lTBiblTFVYFa8XFDwO0PzUGBRpfZ5E925criFMnCuThcagAG8o3e8+wr5SLIMZaFQ/p38HJRDErjcZNW/73wlAPUZXu6z7eaOppsCpTLlGbxzWwnP2Az1deFZ2tKS5+vHXJxS64FXziZIFvjLhGrDKNQNgtZ6CwsvN4AZdhp07z0LDbi9QaKqv5RwySs/dV/7HjjYHbfdVibUIKto5B4BF36yrQAS+Y46tjGMTEQLNnO5zmlVGAJaCzqj+O1oJJIb4kPLQwz02Zm07MO+UvDdd21fsjsdRrJMBBA/YYE/KRKoYRwDfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:03:34 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:03:34 +0000
Date: Mon, 24 Nov 2025 11:03:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dma: fsl-edma: Add FSL_EDMA_DRV_MCF flag for
 ColdFire eDMA
Message-ID: <aSSBz0PoB82Ay3Kl@lizhi-Precision-Tower-5810>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
 <20251124-dma-coldfire-v1-2-dc8f93185464@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-dma-coldfire-v1-2-dc8f93185464@yoseli.org>
X-ClientProxiedBy: SJ0PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::13) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS8PR04MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 838552bb-220a-4b36-ecc0-08de2b7304e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wexg5Ygb2yGejumV9qTza8jlbtWOYgxB9V0jaMsgV8ORgVnWmxi8xlx7QnP7?=
 =?us-ascii?Q?/hCO44ZyZkgeK6g2LHR94Zzas84Jw2M0aFAiMhqqq0wzgvwpkug+fIG7gbc+?=
 =?us-ascii?Q?NfQNKkHZkbPhyRP2x8plkiZSazTycU4M0XsyjSK2BnEjSgDDylpokj0H4JGv?=
 =?us-ascii?Q?UM9KdLfQy5i4z2v0mRJuSoxhSUbA+rXXy4IQtlmnPmYZ/rNhXXzGr9s1KHiS?=
 =?us-ascii?Q?mM8duLJV1QsrlpAGenLiDfXQYCkFDkmqCwUoRhYxQD1lpsH7qUdBKfV3yGWx?=
 =?us-ascii?Q?oWy3Pv/UmvFWk5gNgsXpwEHYalhjVUFMt3XL+n1CA5nc8q4VWAhbLInIRAbB?=
 =?us-ascii?Q?aLnCy6Q7dQpmbSNR8/+NjYtpHKuyLCqoAW0uspBcvyrG1P50euYqmUxsUZWT?=
 =?us-ascii?Q?pW5HsHUSQpFsBDQ7MGSzHxCbW0rJjNbEdbTHijO+bf4COgJs17oQ/1/Xb9Gx?=
 =?us-ascii?Q?cuoAYQkopERhZ98KSx7Qh/Uwyh1yiZpTnskbj1tuYABzgHg6JTgS3xd/xmsL?=
 =?us-ascii?Q?JzgCUAdtJF6asALvc2gwk24TOaYbQ7g5zwjr3/k4MgxdpO8Yup9W9Y/+VyD0?=
 =?us-ascii?Q?JjqKnXH6rcOT8+W/mE7n9VNJS9COAHXItFaswr2UDx6fgjQSEj4eUd0XsfRH?=
 =?us-ascii?Q?3Xj3KqfwQKGFJxchH7CjW1PhKkUzJ6WSZzdmCCbAAC+RGjD+W7E2FRIAb8J2?=
 =?us-ascii?Q?Sw/q+T6Mzn3uZlBFpc4jB3Tj2JdWYRNDzfDA/krAlsjmxcdz3HGW3tRsC7J3?=
 =?us-ascii?Q?DOtcNFxeNx87otKovOtD6AGE+oe7KDR9OWiVLSFzLGlQ1JYprYYeKcLDdRZ3?=
 =?us-ascii?Q?lfRpO/Cc75vi1s+b4V6mjUgznJaScLbwnd3aLq4yWQkT7Jkx9w0gxOui+wTU?=
 =?us-ascii?Q?hduFcwdWui03t40b6YRlEX+mvCedabh7B2bc3RiRT+8igL4tv7ipVUeZKlN2?=
 =?us-ascii?Q?bXsd+6R3jpu+7IpIMbWYgoqwMoTLcHLhVCpy9npU6hSOt1qmkLE6OpETOa93?=
 =?us-ascii?Q?Jkh+utnRrs8GymVeD2xUztz2f2gPc5Gyd8GwBdbtyFEEqrbGbs8bX7Ywmlya?=
 =?us-ascii?Q?teVr622Bba3Om9rPfx+lXbatUr9iy6AR5mIt5M2Kiu6eBhfdbiUmZDa4/so0?=
 =?us-ascii?Q?dTixnHX3xVPe5f1jz3i3eigrlBwML3ul64lucWLueiL6deynfWV01tIYK9Lr?=
 =?us-ascii?Q?caJI05PMSaHhaKK/n9Idi4ganlfykwzlrAhVJnj9v3k5+t2LLxR6vzUWyWb1?=
 =?us-ascii?Q?Dwn4tv+4F0vZ+PLi0iKXlx1YIfo8Q/aXOaQg0w0Wgdp2PB0L6aaZgfwLdxh7?=
 =?us-ascii?Q?JJr9Xh/p7wAhyC0/vl+GN8fHXUYWj9BWwY2ptOTUq+MeotR8s/pnbJGs0O7T?=
 =?us-ascii?Q?dTSAYRSmVB/k3r5H4znWuwu8VAm6vFlrrEArPVsJQcD+kPgRSBLGjUkKVFAU?=
 =?us-ascii?Q?vcS//SS++AcdpWlKGUQ5NWxcn0pKAGaNk6TnhnZHKVjG3iXMdKU/PkcWlkpg?=
 =?us-ascii?Q?I77/Jm9o3fLocOvdLB+1zNlGtUo8zQ+ZOsZ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jYzq5KxCp580rehe0fXSfYoLd9fO3b96aywhfQyT4zwYPvlecEyhe6FbIL4S?=
 =?us-ascii?Q?+jc4krgqLkJf1e9/HT0OsxCFH7TAOwvxMWyXfAFbmAWUUpRDq17bHOisPa2G?=
 =?us-ascii?Q?R2P0VztPoMizy3JbbKEvCBI/DSGRbyudxNaj7uHPeh3ydzbsyUA6phZEYcV3?=
 =?us-ascii?Q?0i4d7mGSbZJ7ItS7pEVLSUdRIeDvHApzFDNackaQd+CVZ+bZiNEunu9U555C?=
 =?us-ascii?Q?ytqXlU4fSL8oVq34Iyq6umJGAiEEWpdsPmyh5717iCEaoowcIKrRc+78NFPq?=
 =?us-ascii?Q?7staN7stng6ULeW/7ybtt/OoXDyVfZGqNTtFXcTd8pljb+VFR+vYoWHtTu7V?=
 =?us-ascii?Q?m2m25p0fqSgIYpd4yo7f/XuttjGK68eucK/QlHi+mPREAp3qiwhxalD0XlRU?=
 =?us-ascii?Q?ZL3pVPLzGVQaCU/cFZz6fpae/MMOOgxP4vqC4iqQ7F3xzbUaywpmvZQR5K0E?=
 =?us-ascii?Q?7jZKXlajMyxghoR0GoQsVbTV0IfaO9oSTwpV0fAj6Ig7Z2WWSEOyeA/qu03e?=
 =?us-ascii?Q?nM1NJ74f1XsCi5ZIIxdPk1pN+AtP7zuhmgHFL1BbSIStE7AY2c7+4aoZkOgW?=
 =?us-ascii?Q?dVJK5Y1mQjAq45y/btVoOOunLPnlGmzJd3as8dLKVatgPKmrXaf9YFgNrZtA?=
 =?us-ascii?Q?kTuI5yFZMhpyMm9vDATv33bvglIGFH+ka58VBrA+cF6W9kxr6zrsJSqO4mK5?=
 =?us-ascii?Q?9+MOcc3itK8jhVCFe8K38Qvv+L0mBEE+UDpyfJQHwMPAp4Z9iS0R09bEPoOM?=
 =?us-ascii?Q?HDMCAYdwF5VqPcIYbLj1WKqOQWA2H5SBN7pw+xQNAgCNdAmA1lkT5cPyEW2F?=
 =?us-ascii?Q?BA9ssJEXC8RWXxzTyJxGRFL8hCCpdFQ6XZmVmRnfTMpQoymi/Z2cyR8S87mW?=
 =?us-ascii?Q?U77V9NYmtKfd3IKfWxLgLhm5CJAqSaPEsfLYTAM5P/hia8XvK7s2wQGrnOUS?=
 =?us-ascii?Q?jdHzmo+TWeoUweunif5qFjl2JLh19ytwdVBnB9ayt5ihdUA9dfUcqm3mJnf6?=
 =?us-ascii?Q?ZbjEIbAZ6jI1sz2PrbNkVoMCh7VpprIMI3Gk6uv6xgpAYP1LZlHhEda3bdwc?=
 =?us-ascii?Q?7BkB5ct8upLNuiV915J2fppr8fZnnz/TZ7FWxBLzhcecQYhZDrfQZbPsiG4R?=
 =?us-ascii?Q?PUrrO+2/wVR1qnFa9G8LTeRmnTcOmjGYog4HMg3gqxhmHU5hhLbFEzHS6Mrx?=
 =?us-ascii?Q?vswvqa1OtsT3pxfTpBZ6qpd9jNgxJnSWWzPfZXMkQVZYBr51QMT+ZvcLngxd?=
 =?us-ascii?Q?yKoKnZfl/H60joXbPJdFefOHuNT2chdNt4f9HLp+DqfpVQCdv1umTVsBRCgr?=
 =?us-ascii?Q?97Mqy/GVcrFIoPwYG7pTC4cQhTomHxjCVGVQPcRI/HTICLeiQpXqHYrG+lp2?=
 =?us-ascii?Q?mZsC32FokX0scaHWDv3OL1ycLtAMamFlIP3/D4dDDP8hVMSK57JiXJmA4zcN?=
 =?us-ascii?Q?ih0Gn24X2PaikNm6i2I2bYzFmIL6EP50+1H2QVQkPMWvne8wiqMlA3ZGvL1d?=
 =?us-ascii?Q?gezBjiwydY1ZnN03cc33DaefieJaMZX290tLvynoThjV+KW3zXNKpDt4WMgk?=
 =?us-ascii?Q?ct8xzvnlECzXusAbtuw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838552bb-220a-4b36-ecc0-08de2b7304e5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:03:34.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMok2qpQh3kRCpPIN2Ohd6NSrVq8OMntaVORzfPxf7fitDCVJDp7cxCDkoz15nudvfBFmg0ibzSG9KMEvYvxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9080

On Mon, Nov 24, 2025 at 01:50:23PM +0100, Jean-Michel Hautbois wrote:
> Add FSL_EDMA_DRV_MCF driver flag to identify MCF ColdFire eDMA
> controllers which have a native M68K register layout.
>
> The edma_writeb() function applies an XOR ^ 0x3 byte-lane adjustment for
> big-endian eDMA controllers where byte registers within a 32-bit word
> need address correction.
>
> However, the MCF54418 eDMA 8-bit registers (SERQ, CERQ, SEEI, CEEI,
> CINT, CERR, SSRT, CDNE) are located at sequential byte addresses
> (0x4018-0x401F) as documented in the MCF54418 Reference Manual Table
> 19-2. No byte-lane adjustment is needed, as applying the XOR causes
> writes to target incorrect registers (writing to CERR at 0x401D would
> actually access SSRT at 0x401E).
>
> Set this flag in the MCF eDMA driver to bypass the XOR adjustment and
> access registers at their documented addresses.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.h | 5 ++++-
>  drivers/dma/mcf-edma-main.c   | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 205a96489094805aa728b72a51ae101cd88fa003..4c86f2f39c1db9a812245fe85755ec8d1169c44c 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -225,6 +225,8 @@ struct fsl_edma_desc {
>  #define FSL_EDMA_DRV_TCD64		BIT(15)
>  /* All channel ERR IRQ share one IRQ line */
>  #define FSL_EDMA_DRV_ERRIRQ_SHARE       BIT(16)
> +/* MCF eDMA: Different register layout, no XOR for byte access */
> +#define FSL_EDMA_DRV_MCF                BIT(17)
>
>
>  #define FSL_EDMA_DRV_EDMA3	(FSL_EDMA_DRV_SPLIT_REG |	\
> @@ -419,7 +421,8 @@ static inline void edma_writeb(struct fsl_edma_engine *edma,
>  			       u8 val, void __iomem *addr)
>  {
>  	/* swap the reg offset for these in big-endian mode */
> -	if (edma->big_endian)
> +	/* MCF eDMA has different register layout, no XOR needed */
> +	if (edma->big_endian && !(edma->drvdata->flags & FSL_EDMA_DRV_MCF))
>  		iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
>  	else
>  		iowrite8(val, addr);
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 9e1c6400c77be237684855759382d7b7bd2e6ea0..f95114829d8006fe4558169888ff38037d7610de 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -145,7 +145,7 @@ static void mcf_edma_irq_free(struct platform_device *pdev,
>  }
>
>  static struct fsl_edma_drvdata mcf_data = {
> -	.flags = FSL_EDMA_DRV_EDMA64,
> +	.flags = FSL_EDMA_DRV_EDMA64 | FSL_EDMA_DRV_MCF,
>  	.setup_irq = mcf_edma_irq_init,
>  };
>
>
> --
> 2.39.5
>

