Return-Path: <dmaengine+bounces-10700-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEryJkQ8D2rQIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10700-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:09:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D97FE5A9E8C
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993CE310C07C
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D136CDE0;
	Thu, 21 May 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M2SqD8Re"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D04379C3F;
	Thu, 21 May 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380751; cv=fail; b=CEzuqQkmHC4rCOLVvI2vjlZ8Pd7BrFC+NP/kaNDJ6E+u8jbiuWQqwve+OVPOZIu4V1KErd6goPwCKf9GeyHFuexT8DVYNYAh5B6ZDHNsps+6HF8T6j6DGq27CuIq4jZ6St9bptyfRw8K+Z+670Hp1CTUariwnUxY+Xjk/36d8II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380751; c=relaxed/simple;
	bh=YlCrnef9Y31Jnrni/SDBvmL6dNdclKORU7yCF4diKyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pBYkcd4jwP3T/K1t3Hn6XCLvbURqbA/iidCis8u8Z9gWJAoPXxBUI6KygqhFCNgsOtlvKYGs+r/5HyTG/4Y7S2Ka1NzV2RHEx7b9OyxUG59qaGMNT1G3p8NaRsjUfe2FZNjwQ3uXBD+fEjpclHZd5njTdtSulwWLBwCascZL3e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M2SqD8Re; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsmyAvhaC2r3TRHRpgKkyb3KiDPjrjO4NZUEQqXK5GCivkkccNHpD+dIhIbhuznU1CaB3zSekt2wR1zv+jBnOAXhfqoaO982miFkkmPMSs9b5BZgrZZsrGU4tK6KMXLfwzl92CQk51j8dEZxzJ0WBDa3dUaRZyYD5pK/ONTcKylSf3Kbs5Z/18zcy58q2PEiFxqAvQP/Cz+XKsMDRKse0YRPhDwckHJHRv+cF5cJ01Cu7yfyauusO/ROBk4WHa478w8vcKSMBsB2+sG1BYqOOEYlOasSxsAmTFPMpWf6fHYXbuy+Eplr9qWQdFeObyOkGkFVlL0ISdooSfTmVLFLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkP9xfeGjCiCWdpI/1onL7393byRNobLRbQiHL1Rhbo=;
 b=gO3DDraKBegi4Rcubj6R57xn0KIyBSukQgTByMzyOTj8FSOfv/lARoQhQmzvQk5LjcBTocSZ7V+mi43BWC4Y+G0sD0tQ4V9ZoisXtOjpoe4NPLqj1p4aQlpAttBDQ3VYecLBgenwE2RV3Jix4JCeFkGT/Bio+AR5j696X7uUiiQFrB2nOaNjo4M+afQmediek/2f79Rix6EJubJWCcKuC36Ngpoz8Jpwd2moPDjNP24oOrOzypss4Hp6Z3yunPIjgsDQtVJ9QbB2dkJj2WiQZJbwXN7ZikQ0qPP3qFl53PSaXVlqOkJs8fDhnJfXm/wGg+qF2OtOI/Nd8ZkrODpJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkP9xfeGjCiCWdpI/1onL7393byRNobLRbQiHL1Rhbo=;
 b=M2SqD8Repdb1J3OkzOzmWDM9zymLQ0e6KnAG+/SygSqkVcF7aS42LO4Ij/tr+e0ZLUPRy6J/SMykCtlWtho/6VA+vsaWYlEWM6RMtCM35ZD2Z4FPaydiwli2x2xgWApbahR9sQrLNNHk2z70Bp7XAvLhvolG0pe3euvLo/bPDJdG45PuT4cf+stiB+OghgYPA9ixUgk0T9Zg19CVcozy1klCS+SL/Rp71qRjvOOvIxwmxuVmQSX0nhEzUMprvy3xHTLOMGz6TanXZs0tZ5EQal4YqNu74ug4n2HYkWIrCbdOy1Z4SoYAujM6xrVK82bo1e13uLIfOn32pJdU6wiDXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by OSKPR04MB11414.eurprd04.prod.outlook.com (2603:10a6:e10:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:25:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:25:45 +0000
Date: Thu, 21 May 2026 12:25:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] dmaengine: dw-edma-pcie: Handle optional data
 blocks
Message-ID: <ag8x-04Z13-gy71i@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-12-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521063115.2842238-12-den@valinux.co.jp>
X-ClientProxiedBy: SA9PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:21::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|OSKPR04MB11414:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0f585e-bd8c-4337-55e3-08deb7559c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|56012099003|22082099003|18002099003|38350700014|4143699003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	rUCLKODTVUOO2OUqHNsBN8TxqLIll6JT7pE5v0r0xJSOM8GXdTsSMB0McLT2Ufsq8bo/CLIM96VEyLEpn9kNN/GCNshD59/DlVeMUfaDNm4OhC3KLhZ3u8g1fyBhTBn+atpSY3nKGWghIRM7Uv7vZh6xwJYIGjfm4zq1Gc6ow5FUmtBdwLgjoszU/7NZkVgCfvmzHngExK3wNK4ifjqijr9Gw+wGuC6CcWNu64OKF+jeApitaHnFHjmDOyOxnKlREtPeaJTBhT+lKZSlqjvah+szbBemEo2zlbHFoTIIBmrxpkQxMT+vl9LDEG4wNM+CeiDmiR/9QD0e72WVJZ4XdUqpCExCiGo6Sadee8azk17xGOGIzi5V0EtpfdI9dFNI1hzhCv0i8vofV0KtRORvWLEFlVT+3b4G3Z3ORWAiV7EvxCs7t3hdJAUCM9zPwzC8FHXcEY6Xu2wWqWHfPlpLGfvSp66EBWZzad9Ln295t0EXQfKGPrWym/RYHL4/+gKxEdLm4iMIrTO6MKmca0x1DU5YA8OfYDxLAvEqTQ1zP5V0+qOTGIluVys2G66LKA4+msrXdm4KqfUpqAn+blsSNT8WaDAIP/1/QoEnlEn+Rrg32rKM2Jj/KSrsn6/fXRxXEFswliHaHHatPJpdiOH3wHiaZ3lZLNdYAi/GW9cKHrg6eUtVuL82D2zmNrM/eO3MwN2ASdOhMmmw/k0x/gqJuJ38MNJNVsnqde16vk/cEKxecUSmzAzvuy4FwoVYwc+g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(56012099003)(22082099003)(18002099003)(38350700014)(4143699003)(6133799003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?luZBatHdmXNajwYktlF3PbYv1W7Y8h4ndy4nz9HuUXfeZ+b5DJmdlOW0ef+a?=
 =?us-ascii?Q?qxzJKiaGV7H/lpNdkq96BDLy7nEOqVgMj33li+m9VNdXxYkZxAyibRkpOehQ?=
 =?us-ascii?Q?7Z19sElJXF/mfZ5HIk39LKti0/orOkG7aogqkvvGeE7bX8jkJP5cvE3xg0kI?=
 =?us-ascii?Q?2nCpWg96cEdAkFCuQT9iBp9SQ1AtVAbqBW9Jn1lhXiMYnC19j1xRPmNPZ1CP?=
 =?us-ascii?Q?1GyOqWJ1jlUaSLp3y3AsgCsiBuUy7C6k+QfATJWalMURgGiCPZvLuec+TZPW?=
 =?us-ascii?Q?CVpDmnGdMMAz/YKPd4MIcTN7dZ4JTJB62fOQRX30WcD0isH+Q0A2DvRBsFiS?=
 =?us-ascii?Q?+BYcwNAcBu1r5EtlZ96JOD4k+7cD3+OwuaK5pF9s6jvjHGrGyWZSSOmKstSH?=
 =?us-ascii?Q?B4/rfXEUt6jXPJYTnrxDmSvkLY8avAo/gxx6LnymRqURTg32nRQ5iX/eWGoa?=
 =?us-ascii?Q?1+Rk6y5phvnhqJHP+uV8AceCE+2qc8uVz7pwxIuhYQmEN/Qk+II2RldFSUWl?=
 =?us-ascii?Q?4PFimg0tHMmVdNuECS7X1EkwYt/sMlvtqGgP9w6ve/zO374pIoWgFA1QyPaa?=
 =?us-ascii?Q?F17Q0usuZWsLfD97VtyVOYFrE39sbCho6VdwN0TIjFnKFbZ2u8yah2gbmc/z?=
 =?us-ascii?Q?19D6LXOg80OE9Tx7a0S7KMiWB9V1wLTMqGCjspbTbgKWNeVrMcPJDHY9WsRf?=
 =?us-ascii?Q?xNmHq9nsFAB/yTl83uRFeDpLua/i+XGboiGnBkefW9iZTIuSv9Hq7BpwVmIs?=
 =?us-ascii?Q?qKOJBh6kueCWq2E24FtAXqJoZ1bZoR5PkNg02inB8CFIde4rX32RwK5VWAgH?=
 =?us-ascii?Q?1CEthTG+fbbNJ4etPDLh5ST5HKAQXK8QL8URZ9YdDyFG2UZgP/3v/JyC48GC?=
 =?us-ascii?Q?uK1NSgU/zlpbuSAsd0dkfv+ZVbJjVNqHXWb74xSFm/Iuf+FItZmli2rncMGY?=
 =?us-ascii?Q?lur3cbvRgkVvXKi34qZEIAeavZdXNUsrq3qKpaySlrYklCUCT51EyKSq4x9T?=
 =?us-ascii?Q?sTpVjyXtRlXMsNpebYMr9bE2yN8bxxlAqXEbsgN6wN5SNW6SV7a8agAHdsMt?=
 =?us-ascii?Q?Ntm3PZgLP+RyfjrNeGStDz0qhpSwEmUB53yK/f1vtx28UQrZKUJUYxiLnc/u?=
 =?us-ascii?Q?Enha5ml/ZH8TsLqlj5wQk/nMhm17R1srJOcA/ybKPzH4zddgyG5S646/qo3r?=
 =?us-ascii?Q?z7jt24ROWACmjWQTKE8q46AM3rPCwzED/UglmgGTce/A0H21erynwmGi7aRn?=
 =?us-ascii?Q?Nztl96991WMgK85abKWo29svY9ZcA+cNaHVPYbEgl5MiYJTT0hf+AxzcrVjO?=
 =?us-ascii?Q?FrE6uoj4F/HodPRqVG6RQx4cQgp2kRXO/rChyexdosBkbrve+PHqlifcPSNU?=
 =?us-ascii?Q?1/V53aWhKd00YmaRlZIafnDRSMKuvXrYVRhX/HY/fSncJLw5l/+lbZW4o1Vh?=
 =?us-ascii?Q?5OcvlEqXGQNVMOzgiLvI9s5Mr3ZLUzlWglqKn1w0wGYfCzQ7PFEXt1eu5GVW?=
 =?us-ascii?Q?AMRV+QZ+jp8ds8tgDaj66jpbM3TRXeUiJ1oTgQ4exmb5LSXHrdW2arQ4D572?=
 =?us-ascii?Q?YOHstZE6c2F1Uu0pAh8kmusfBfQlRmJzUQ9zsU0oFxb9Ryg7Y9xYtG2QP5dk?=
 =?us-ascii?Q?fO39MzQ+ftJ5ZdBN9EPsJbin7SF8wL1kwZZSEv5X+HMUsXYWpBgQ1COb+Mz4?=
 =?us-ascii?Q?rR1HRrCPBEBhUXY1U6IqWxiBd/AKDvQiTFUygQg2jixfHt5h4pwjHr0am+aq?=
 =?us-ascii?Q?j0Pk9CVYoQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0f585e-bd8c-4337-55e3-08deb7559c26
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:25:45.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgrK7VOzvaVgqqf/MVhVC52QNuD6OFQcubTVoue75ckRHvv7/fv+x0YDdASIsQcHCeyIjVRRb7pSXIM10tE2SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11414
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10700-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email]
X-Rspamd-Queue-Id: D97FE5A9E8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:31:14PM +0900, Koichiro Den wrote:
> Skip data block BAR mapping and debug output when a channel has no data
> block size. This lets future providers describe channels that only need
> descriptor memory exposed.
>
> No functional change intended for existing EDDA and MDB devices. Their
> static channel descriptions still provide data block sizes where data
> block windows are used. A zero-sized data block now means "not present"
> for future metadata providers.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Actually when ll_block->sz is 0, it is similar with no_ll mode. We can
config consolidate it later.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-pcie.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 2a95fb9d5fc3..df02b244e748 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -414,11 +414,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	mask = BIT(dma_data->rg.bar);
>  	for (i = 0; i < dma_data->wr_ch_cnt; i++) {
>  		mask |= BIT(dma_data->ll_wr[i].bar);
> -		mask |= BIT(dma_data->dt_wr[i].bar);
> +		if (dma_data->dt_wr[i].sz)
> +			mask |= BIT(dma_data->dt_wr[i].bar);
>  	}
>  	for (i = 0; i < dma_data->rd_ch_cnt; i++) {
>  		mask |= BIT(dma_data->ll_rd[i].bar);
> -		mask |= BIT(dma_data->dt_rd[i].bar);
> +		if (dma_data->dt_rd[i].sz)
> +			mask |= BIT(dma_data->dt_rd[i].bar);
>  	}
>  	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
>  	if (err) {
> @@ -483,6 +485,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  							  ll_block);
>  		ll_region->sz = ll_block->sz;
>
> +		if (!dt_block->sz)
> +			continue;
> +
>  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
>  		if (!dt_region->vaddr.io)
>  			return -ENOMEM;
> @@ -508,6 +513,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  							  ll_block);
>  		ll_region->sz = ll_block->sz;
>
> +		if (!dt_block->sz)
> +			continue;
> +
>  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
>  		if (!dt_region->vaddr.io)
>  			return -ENOMEM;
> @@ -541,10 +549,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			dma_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
>  			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
>
> +		if (!dma_data->dt_wr[i].sz)
> +			continue;
> +
>  		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, dma_data->dt_wr[i].bar,
>  			dma_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
> -			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
> +			chip->dt_region_wr[i].vaddr.io,
> +			&chip->dt_region_wr[i].paddr);
>  	}
>
>  	for (i = 0; i < chip->ll_rd_cnt; i++) {
> @@ -553,10 +565,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			dma_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
>  			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
>
> +		if (!dma_data->dt_rd[i].sz)
> +			continue;
> +
>  		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, dma_data->dt_rd[i].bar,
>  			dma_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
> -			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
> +			chip->dt_region_rd[i].vaddr.io,
> +			&chip->dt_region_rd[i].paddr);
>  	}
>
>  	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
> --
> 2.51.0
>

