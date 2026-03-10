Return-Path: <dmaengine+bounces-9376-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE6lNVx1sGnJjQIAu9opvQ
	(envelope-from <dmaengine+bounces-9376-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 20:47:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C822571E8
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 20:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0962030237A0
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 19:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339B359A6C;
	Tue, 10 Mar 2026 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AARFYHQp"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE57359A6D;
	Tue, 10 Mar 2026 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172043; cv=fail; b=rAMltZY0fypWebCpNt7tIf7aKCO1vUXRdRud5TGUfqN5wfhkDNuP1755aD0Ff8y2B3z5dnMB4DqkXH8tPLz2NoEAGFnAE0yemZeaWDe7kWbb1jCG0K9auLkCyVg2InfrU3pHNKwgelKGoarX+XRPeMXDInKtTedtr95u+wCLHRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172043; c=relaxed/simple;
	bh=Tj3SLzqX/adXDb/W7i4Z1v+apSyexBSajzcg7DWKoCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XqD0hq0tjXssgLmq7Vjk6vku3HM9ezsEGQ+FprExSj9kJYagd1OPGsJuHeDMOzHP5gWY3Noiy8YKuqFhZPDEtt35ji4q9SPgl8h2COK1Tnx+xDhBwk7Fjqym1ze89P/Q/pqYy9MesNVOqGIWZYXLZKhiQWSEixtIwX7+SAr7JPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AARFYHQp; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avSKmHcdcuvuyP2sdz3bJdO8GUtu5aT1EavJNPMbSkaWi8a7N8w1CTAT9vamw4JYfBsSkH17sNFEeEEQzMDGXcJpnaxIMucBOK8FSVXmDxruABYhQ4bt+Gf3OES+9b7L1rSSffqTN2xnmsrW2aiu3tltB0pKiWbZtEt2hVoha8wQf7C2wJDo3I1Tf60mXNsjC7xSIGskgt9ziFNEzQQtVa0drXaQqwQ7L0LBCovJaXBiIJddUP+9gOqURPt52ZU5Maerjef6+BqNOkyLK60db5WE+zgI6KP15HHOpgsJf9cfsOP+y/0DP0HSxGayL295XEtqA7FPQ8HGgB60bapxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT+PgSNasUHw5uk1wYCv2wk/82mPapk0IZ9tZdiGcLU=;
 b=F4Jv5IKjUjAK8PVplnyBnn++/Hf/+6kjlBdSgTMvkBIpya1OXnIAMRdhw8rouaa/pJbN+M4K5eNXLxFnqWynJYLvFAllLbO3cV/4H5jpmOlLWZMEs3fIB5YcR8igssOV9tXMHDj8YzlKUXd9XjpwdgDiilMlr3XgGn0okUPJCAUGVfY4WvEdU9nVTKDV2hNwy2l1b4M7RJKN+ap/A29rtsEy/UHUYY7bNEnlordTDuSaCNUafhn5ifgrO/C7u898bzvCmEJM6W0klXK8AWMtr4dxTEFTmQV7GSohwMuPif/MxTMKtqVylLMTcRlX8dt5iTRdgmnCZdWAdmbZyYJGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT+PgSNasUHw5uk1wYCv2wk/82mPapk0IZ9tZdiGcLU=;
 b=AARFYHQpbuV3xTv1wDvuZqW8frDjqBXEN/DkO8hr2DBRYLPLiGgzweb/zonUiYI3vcUnhm9TcrVD0oR0j0t/9QiQ4yZR+PH9xqJSGea4uXvXC7iw8YsBgI/sMdyccbw+10ANZR6Odln7wpZUp0NPzUPm6al57FL5u6FVd+tvVjYaQp661tY1Aeg3yxMgb2O4ZMKXYGdhyNTU8ZXOy3fimacu54ZY6WiqY1ZTp+ihA35jMMd6/bL8XEu3C6GJj9U4SCMTMDxFoXFnevCAKGIYtxu3nfxAuj3F429DQxyspI2ffooRsRUJpzcZzwZFLRSorExw9CliT01KQ5iXbFKGJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9847.eurprd04.prod.outlook.com (2603:10a6:10:4d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 19:47:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 19:47:18 +0000
Date: Tue, 10 Mar 2026 15:47:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v12 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <abBrex-33Ot5Kdqh@lizhi-Precision-Tower-5810>
References: <20260310123055.2863727-1-devendra.verma@amd.com>
 <20260310123055.2863727-3-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310123055.2863727-3-devendra.verma@amd.com>
X-ClientProxiedBy: BYAPR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:a03:100::39) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9847:EE_
X-MS-Office365-Filtering-Correlation-Id: a79bbe6f-e381-4e01-4616-08de7eddd675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|1800799024|366016|18002099003|56012099003|22082099003|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	knfcKZEEx8NEZmBWwi/+DWp4XvS1RDvYxlU31Ny57ISl1XxD2aRXDbauMEUDcxeOdS1VUCOd4hF/3ghyNMgZS/iox548WY+RizlC0Y+GJkPQ5p59rAiCmPpFErl0vgk5sn8ocluXxJlMPu1M53Ov00K2g967qgKMSrtztw0UyPmJ2RvdiJ0wRJvP7Uj6Ih3KTZCaCPxNkzkgh3tU7aWj0AD/ScK1EKKGiFsWU+dCmaR1GXNmr6FGnatdx49dZvt5bF7Zh24b3TP6/zkruKsg3P0IYN6U/3dtoJf4xXmuYbY8/LhZnIxCNaXDTG+Wa28mG/YdLCK1j4qas2kzETIMFpDC/0g/TMKwwxnlRimmtk8DEmUwF7WBOt6EBTr1TWl5GhRxd4ZEa5Ospa+frz96Gn2AEZi40t5yDTtCu/iMc5HqV2jFVRWg7z7m0itidQ8xo+xgmWDup1wSYzpYGKzdfd2FU4vM6vdV7IzIC8D5SLLpCH1lf3fsoQYkXkRzxVO8LkU0Y9IDqdhhbhzxAyxYLEH6AjVLSLQd7XXHb2tlXEvPogV5qAwMCGI2ePrIMNL0AJgGR9P+dT+8HIpGRcI+nddKT9sqpWYaID+oHq4BzA9GFhYeAjriyJpNlR7ULNddIQjlOS1xYJLYbmT7wJ1uiq8F3c4MLR7rWhjHEwO+azj08DEmzYpPyZiymTqYE6tA/K252Hk3qituFvCVm2CJHiLZoWczGULLhhM6GxFvnWLXJd2MorQ2EGrpV/+ONNolFKdka3l2pmTKwgzmlqQY3H7QQC7HHisPUg67ycAFL9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+g5cmRSYUTodqe3S+c+TLTfHMrg6y7G/156/IOZn1faKdVfxn/43pYCAO3jW?=
 =?us-ascii?Q?Bqf+60rjDFh/nO1vRhyxZ6xc/qJIwlQN5TPDMMnHj6W6a23Rvsi3c8yYlys0?=
 =?us-ascii?Q?GRZVKuC9FFvveKEpocOMQYhjzmjClh6PjfdRzzeMFU5pVICS1Na+pg5fu4Ae?=
 =?us-ascii?Q?qnqpQAS9PrGjA5lYeqyPGnmLgwfOqaq6qg/0eCk9njbaxyHUFNk1WR+s+niT?=
 =?us-ascii?Q?yHGiiRy7gxhlkasgJIoFDM37zNR8ucTii9KTPPzevmfSm09Hr5MzC/564Pzn?=
 =?us-ascii?Q?NNCKngVLSDihNUClzQF03Up3prrp70T8N4a2yukQ4Mw5lGkjMPqdT9u56zLM?=
 =?us-ascii?Q?CVRlpiLcDnhIwvU/24vQQzubcWcLUwNnAJWXqMtTq0tKwjniSRrjVFQYe2q+?=
 =?us-ascii?Q?TstIB47lhYHXcltelDoBlF7Na3MfflyKyaKoZZt1mIuTds2BUXZAXDtEsLsk?=
 =?us-ascii?Q?XOS+kAF71/SbYSx0oeNFmqrDrprq18HqBv5anPupkS1GG7ppYbZpHRZNjdyc?=
 =?us-ascii?Q?2uyX1GwUxpQa4S0X9jnfR3GREW7OP08Gdx2pFJCCVzJOgr1nnBbmI9cG+614?=
 =?us-ascii?Q?dw1hgcDWOIfXu9iSNQ1BuodvqZS13iMgH6yvBHiofrjSW62n5B+vnMdkiG48?=
 =?us-ascii?Q?3v6Rhqh0+HIDpXHEns3Un9xkyjxU86N+c3AbTJQcRu7r9qRqEKHj1yqeffrM?=
 =?us-ascii?Q?4TyocHs7wz39eKEXzmZu3IqaYbMXhqasDVxS3nhta+a6/JvKfHUCRr9QXJfl?=
 =?us-ascii?Q?11HrV6/U0si7xVyLCgHMN21coVkc9uDc9kLmaMKE8uLF6RR39LgL7xcpfQv5?=
 =?us-ascii?Q?EUw/MrLyfHyDQlTQIRrQIKmz2ZlaSz5Wsm9Bj1Cqbd6lwLTq0Ph9+Rx/PdzM?=
 =?us-ascii?Q?kRPGBar77HcK9RYaZHognYbE7P/f6UemtMfxyreNUXoZFo9Tt0ed2s7Ly44b?=
 =?us-ascii?Q?uUZA+WQiFZ7SRSJd7tJ4YBuKnSZl4fZN5X9vKhZRK1L/1IKD8aSiNPsSVimM?=
 =?us-ascii?Q?P0qsS0UNin7UJA6qgEPB0rzNP/o8A5gcKO3m5SriUT+zqo8rgAjgTFD0q2b2?=
 =?us-ascii?Q?89fTqNMW3yx1nMSvABQmk5gOg3RbWZo+b/i7xgxTwpu3HhnJBhWmhQPWrw8V?=
 =?us-ascii?Q?ks/8/nLHAtvGlPlILENTlEKbirfw4tx7nVlBgMHsxck2PY9Jb0UDL1jf9vDK?=
 =?us-ascii?Q?U0tLo62i8npI/5VXLtDm4kq0oYj3TVtM7uzIEtl1CJF7qI19bbaUmLktENDZ?=
 =?us-ascii?Q?fWI8Y8l2dSruHZjs5TD2gXQSfY/CTuKF42t+fr0mRc6ZHIJgNoq17DnHYXVN?=
 =?us-ascii?Q?9O+jld2Amk8nhQur5YOhgPrK7fvmoqFUrmrU/eRh9jVZNkbxwFy+CEDN9/j5?=
 =?us-ascii?Q?TGEgMUNznpPAKM3sZTK3Q31BtlaJ71BC0oHtDi4x0lXa3y9os4HkuuK0jNNH?=
 =?us-ascii?Q?gz1yZrXSb5PcKDRc81YPJ0ub28aub3IoLf72D/kptUf+IJgBCFAx+ufXZUmn?=
 =?us-ascii?Q?C9W9ATEPPjlz4mVUYv/Q0eeZKiiElpwb5NvcXp0ODHGY57gSnQvAi0elittT?=
 =?us-ascii?Q?Ls43lPn82cw7WDt38kq7AT6ioOAG+s0UV02e2XE9WNu2+f/RBR1PFwBRRfDM?=
 =?us-ascii?Q?MY7jUmypmbwWStZVakGT9E1LRSO2IkxyHjn4+SH0FiBriiz0+64rG+6fiiWM?=
 =?us-ascii?Q?ipdqoLsBmSqdHaVY7fzTB3qSUIRgw+9mp85moG7I/FUDNBQt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79bbe6f-e381-4e01-4616-08de7eddd675
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 19:47:18.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axmlXXNnfUuuITShyQMi685fXxxU0nPA9N+JbvRZ2QJEA0R9iFgTOq6UFwkrmpnKzrwMUoxMx1Qbyv5GHcqutg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9847
X-Rspamd-Queue-Id: E5C822571E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9376-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 06:00:55PM +0530, Devendra K Verma wrote:
> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> The current code does not have the mechanisms to enable the
> DMA transactions using the non-LL mode. The following two cases
> are added with this patch:
> - For the AMD (Xilinx) only, when a valid physical base address of
>   the device side DDR is not configured, then the IP can still be
>   used in non-LL mode. For all the channels DMA transactions will
>   be using the non-LL mode only. This, the default non-LL mode,
>   is not applicable for Synopsys IP with the current code addition.
>
> - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
>   and if user wants to use non-LL mode then user can do so via
>   configuring the peripheral_config param of dma_slave_config.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
...
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index b8208186a250..f538d728609f 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -295,6 +295,15 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>  	pdata->devmem_phys_off = off;
>  }
>
> +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> +				 struct dw_edma_pcie_data *pdata,
> +				 enum pci_barno bar)
> +{
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> +		return pdata->devmem_phys_off;
> +	return pci_bus_address(pdev, bar);
> +}
> +

You missed my previous review feedback about create new patch for code
restructure. But change related small.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> -	for (i = 0; i < chip->ll_wr_cnt; i++) {
> +	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
>  		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> @@ -410,7 +424,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> +		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 ll_block->bar);
>

