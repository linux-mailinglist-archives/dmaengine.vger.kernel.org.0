Return-Path: <dmaengine+bounces-10701-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBiLFCFBD2qcIQYAu9opvQ
	(envelope-from <dmaengine+bounces-10701-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:30:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C00565AA450
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38C6C3173ACE
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3C374E67;
	Thu, 21 May 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gyYx1sEC"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E53655C4;
	Thu, 21 May 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380806; cv=fail; b=SHMS6ovgc3aIbETBtMfjWA72duIjnTX6C4meWDWXN/84sWjhg/tHmZ+zNt/oNtVZ9soIn89KsNBxSXgng87CZmhkpueRgkRp0sciErHA5rL+LPQlG8RWlcQ1jyn/lvbeAJNrZ6W4/uJQYGepiD/LI5IXELymQ3T5XwG5aWaG6EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380806; c=relaxed/simple;
	bh=HuC8kSBZQ4dUccMfpFY/Tw3TDczHTNdfJpzpaR1ahJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O8lkDb/0f4Reysd2GXjs9z1bo7fcOujHE8PvOxWow45NQYcAmmOs9zV3ifR/tFlb8ICNQU8L7yNrT/AL3LlGvnIhYk2nUxq+RXakQxdG4ozvDdoG09cHADAomQx+8CLZOdhkIW4by0Og/aP8THMDdcYhHpvjZwpPqpYWKWbuD4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gyYx1sEC; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy2azwyztZLHRq1FGg5M6m9G9yEgJbquXn43BLMzut3+4TC4ig38bcokb7UVFhd1YssIB/dwy1JMu5KMHCuOpQy14JrbPUZI8LUlegUE6C0qMv3E0cQ3e/i3qCxXM6dlgc3Uq5Z4EczZc2IR6vRDzVuGw6Wd+sSyYr3CSXuiDqIfKMx9uHpyva6L/cwqTUv3TZgSPeXaoHXCWM2muhANjdu5UlIImz9MyWxNL23PJLwUPVhVZlMJWYsjP/Z3RxFULTmJfsfPQCPI/PX4oFLe9FKgiZqQCZdNtUl3pwCKM5f3U0oqSUdwHRN4esTzUQYN5CordfMvjb/yLqHjM/sqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qovybNXSCoIfJmvq3fKewX2wpbtFNLiPIaI5QlYBf/g=;
 b=VnxLstWxVmv32lnD1cnh6PhPIM9UIpGNx/TF+Ln5DlLJhYjO9jhfahF2C+3xs8PvSHwkTxyI5D865LYvbrci71mwRXoU4E+oLPImSWLCbRu6bP0bR8s2MrO5WUgEWKzaIDJYcbSenmoMgeIZF4YKQmf2WbKILVEOItdqv8MFiYLHQW+DxDUV827VdUH7Uekjt+rqG656mcEmLi1bRPGh9bv9c4E5BtOEULLqILrVX3Xj2xTBX+Bez/iQwgLPyi+VfsW8Jp4GQPHo8E6hp4ZN8lZeHZ3gHvG9vb+ynbWA5R1E9lIQ4RpZdSIhQ+v/tDJPMmpFKNxdIsru3ZyScjxc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qovybNXSCoIfJmvq3fKewX2wpbtFNLiPIaI5QlYBf/g=;
 b=gyYx1sECykrtv/5Q2W93U6Bl76KPmLXEsrTO64OWxAJs2nkdQUJVINoMdBt5OleXGSr16td27ezhNCKyF/Hxa8ivCdS/bVKGly1P9jJLAqgNIMTDiZuGzJUCg97BeIbixVrGQ6oDt26Zji1CTQjaRcqgVUNNisib661yedKnwPHCysxmdyU/osC9daNhzpUGqEIRgXkDotZalReztFalQ3tWWjp8V91Wt4FDrV32Nn3d/k4WwSnA8+qFc+W8Xje7YoSQGqBVo9Qf+jpIWUtDltOwtsYv/ur+KcB9C9utccIkEO31XhmZSr7T26wN7RUi1vrg1f2Nt3SbxcNv9zZopA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by MRWPR04MB12306.eurprd04.prod.outlook.com (2603:10a6:501:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:26:41 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:26:41 +0000
Date: Thu, 21 May 2026 12:26:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] dmaengine: dw-edma-pcie: Add chip flags match data
Message-ID: <ag8yOkTdiZVh-8A-@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-13-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521063115.2842238-13-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|MRWPR04MB12306:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfbedbe-9eae-4799-2b02-08deb755bda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|22082099003|18002099003|56012099003|11063799006|4143699003|38350700014;
X-Microsoft-Antispam-Message-Info:
	XGu7QVOyoGoAQjxjQVEDGLh8Z9qgBBmIMosG6MGYGEYpzbVKDQJqCsTiyc4z755YGtLKvyFkkJSqKRvsJrzUlBbSkUt4nlBsp9nTrZxeb76MuPP+6CqLCFM17OvwSREF6UijQYZQmTLXVqIt6dmrVNicLivu58mogysw2Evg5jvlZ1Pqy6vj/SYh2fmeP0AD1FKFYHEvjbUi57B8ZD23xToSvj0gVBKlWT8bEgoNWjKIklJf8X68QkiEc3kVyPt6ItmeAUrNsV2KlK4jIFTZJ0VSp4bQDeHAobP4RPk16gK/BP3x1/yDFgHfk5XRAv2UbpnLMW8hacJcVyneJ+Ikd0gpZKmJUQuN+xFjc9Vw6VQAGq5O2S2ejBcdXh/vYj8MxVl/pRLYM0vCbiakwR6J6H+ynHyjcH6esvojRt0IRYxFqlRyZz41KGbdqVdHAHxS+IiThfocPUYNGIjee2gyhBSNFFdzpk1KpTMaxzxbSK3UcGlpG0kMtZE4DbtH3OV2t+GYrT3vb0EtBihbTJhRk3s2S/B7mZ3K0qsPSNgLhM2+1mn+LnuVrWpbvxMTANZYq6vsyShxmij2L6cY9xSXoCWpGydAOjvzo0HrsBS0WVu53pLoOuSsnItkpfT5z3Tm1g6+KXkMuS43gMyd8yVV/XC2UAqmd8rWHIHNex10kG00uk0Yv6gobMPlQ3mT72hcZI3wnnlvMSvZQiq9ojLhzXMYSI4iGi0p/sPDrKTWRuXqTxGx3sNVqsfY+Di3xh/m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7pM4sDe3YvSOcAQT0oPYzwWlJ7GetAcIeeIy5hoSVU0s5XrW41Hn58HmuomB?=
 =?us-ascii?Q?R7aCQrFPpUrWsZKvRFrxPYR9dp5KEXwmz4N//Zr3MMKccZ+b4xuKR5C8sjoe?=
 =?us-ascii?Q?I731XOYOqogAC3yfbiEj2bfNv4Azxh/z5kmmI/277pfxAYsz6wFzNbqkueiz?=
 =?us-ascii?Q?jB0bAH+6uxIJ1tE+DVzCyIg8j+dsNBLCvSVQaS9jjCA3FRIskcK2eXqSURcQ?=
 =?us-ascii?Q?QHQsGYVCJycmkdbvWTIXdj9vVkAvr73B0vgIGA0Fg5LOsOsX2worCMgIKrhr?=
 =?us-ascii?Q?usEvwkjTPNW0E0LYBoLTL+ctth+eUwicwAxKFtqdeDPpwml5i3vfv2x85whN?=
 =?us-ascii?Q?dpWaGFvurA1XswSjLrHPf1vIMU2tunsxzT2URUZgwdeR1z3oOgEtoci8+Bbn?=
 =?us-ascii?Q?88ly8+MU/WfnMqHrWrsyxfLYEy73VuNzmrBFPBV90tGZH/gqSJm8xsmvUYF3?=
 =?us-ascii?Q?2+/Fi3ADluHqIBaOm3zupUO5VGdDKoAke/OakJSxYp/OX7kh2iaONLQY4dWN?=
 =?us-ascii?Q?P5PYVXvOXXgokhpIKquy+YTw/hsRITrRbzULD4s0fy71UMdg/8UJIW0jQ1zq?=
 =?us-ascii?Q?jK/FBJG24HF6giqY20/ZC26d+qQnjJr4nOwYwM20i3qiBfevfn9Ay8kual7H?=
 =?us-ascii?Q?D3ETrQn5gPs6RG7WqrAEO457jcgKGPmEA/IuaNs591RpD1tT722mrafgPLY+?=
 =?us-ascii?Q?xE8y4iGr9PiRBlPk/nKh4D7Q56sjzqHu72GllcVEJQ7Z7HSFiMr49iEGhk22?=
 =?us-ascii?Q?ARD7BCmTc/phPALiXUqguVwD8YvXhGOOrcBCRiRVFKT7M/jq3tP13OZdmujO?=
 =?us-ascii?Q?jmIGfS6H/c6PrFfRlsiMpfj+Dol81QihTbxBXT+mL4Qifln4BLqtOb4XhZoz?=
 =?us-ascii?Q?SBgQfY1H2eWtGc2cVkgrra4O93BKma3gWYPJeqt2+WYv+rEDt6hh/3rfG4/T?=
 =?us-ascii?Q?MaHy5ceYNLBi78uW+SPWda6Yi3fUQPa+/AXN6t+VB0yBs3hlG6TEklvxxb9x?=
 =?us-ascii?Q?CUG5XAqMLwcKXTSx5RCbmGFFPlKyruNhlfMjs7MPwh8FfuIX4GRTr16Zn6o/?=
 =?us-ascii?Q?M7yXCzyzyev7kE2gqk/nFyVKnkZ3rhz64jc0gIJw016MdxwihO0EzDMm8eXv?=
 =?us-ascii?Q?+zdQhgp70HkmuMTiY166l1p+iykeV1zA1IPClYjK85BP+4sQ0kFBra+VNcIG?=
 =?us-ascii?Q?VmKH1oyyLkR8N9UOAQEEzDxEsrQiX7UtrECWC/SnROO1zQBA3iA6TVvmkhjD?=
 =?us-ascii?Q?ENOaghmV9n8lZUaAE5pCrp4xYr+ViFRe/QVC2Xk/EUs3LEjSSpEQECp/q/9n?=
 =?us-ascii?Q?f/mhnjJEV1yFPfvfLaq1hEuyPMRrfoHaTUHLWamxXJ6G6dYpAKl9l01VGYsc?=
 =?us-ascii?Q?hHhtG5FZomXSAXizso9uZw1+gLerDTLq/ck+MsRM9OU0q84WSf9lOa2NBoJu?=
 =?us-ascii?Q?bTS6I7inZOpdTPxzTHMdeRkkzJuIBl7PnhzIu1yR43OpZhNYPz7PrCoz5fvx?=
 =?us-ascii?Q?EXwXDZZscdka5/EJTuNxvE55G6UbTiCxV0UupkiFYiTEbNHp++eGSitpyMF3?=
 =?us-ascii?Q?1bpNLpRj3ItpSp03htTojds0U9R/00t3RZB6+Y0njwWIP+eSAeE0A2MLcMoS?=
 =?us-ascii?Q?NActUP3PPGebcZfzwqedIMiagdZa6TEDM7gKbyP07DqedAgP5056XYrXBXg3?=
 =?us-ascii?Q?gSP6Oo4ZGRPrPf3+hWhARibfu6D61Dt31GiNnDd9diBW3dlL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfbedbe-9eae-4799-2b02-08deb755bda6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:26:41.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQ4AKnJmuYGye6sK8OqQq+d2eKSugHBAZdXre+BXSfNPM4wyJQ30qxrnZKOpdR7Jiu62Gk3ksJLbkcTHHcKCsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12306
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10701-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,valinux.co.jp:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C00565AA450
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:31:15PM +0900, Koichiro Den wrote:
> Allow PCI ID match data to pass dw_edma_chip flags into dw_edma_probe().
> This keeps per-device policy in the match data instead of open-coding it
> in probe().
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index df02b244e748..2f752e8fb999 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -85,6 +85,7 @@ struct dw_edma_pcie_match_data {
>  	int (*parse_caps)(struct pci_dev *pdev,
>  			  struct dw_edma_pcie_data *pdata, bool *non_ll);
>  	unsigned long flags;
> +	u32 chip_flags;
>  	enum dw_edma_ch_irq_mode default_irq_mode;
>  };
>
> @@ -455,6 +456,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->dev = dev;
>
>  	chip->mf = dma_data->mf;
> +	chip->flags = match->chip_flags;
>  	chip->default_irq_mode = match->default_irq_mode;
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = match->flags & DW_EDMA_PCIE_F_RAW_SLAVE_ADDR ?
> --
> 2.51.0
>

