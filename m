Return-Path: <dmaengine+bounces-10666-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHGQCNc2D2qSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10666-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:46:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 213785A98E6
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E254B31C7305
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813483E559C;
	Thu, 21 May 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JO+IjpDZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01AF3E1D13;
	Thu, 21 May 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374698; cv=fail; b=CyGZJhFgGCy2rjh0WWqE6DiIqXT9pqighJOhiDxV+gqT2B/l3an7jikc36bum3kmOzY7z88AoILt5vzEt9+cAv+grqFjxKHHJgYoY4iKtzg4Ro6MbWBByu+zan5QWTOgGcw6loDqJKkJu4/1dFwaUCMneSjRILFGbTzHEsF6p64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374698; c=relaxed/simple;
	bh=r0kvMchVEG4Kcb/Y+BNiFrVZq9tVCSBsDAD3EDJL2Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W7Y+HZQo/66dexyOwjPPQUVJLXqDXijTdx4Bq+ganNIgXYOTQv4ZNOj9j5tpwvW5Lw2Bweh0Z9ZAIg0hqNuAF7vm7xE+rcufp3Syea8rxArjx+UhTvUgC+psDyOxtzxlYVgUb4Y9ObToXlDOwN9spyV4sovECv0HyvsGvMhc1MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JO+IjpDZ; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqJRtRZ7AuX+rlTiDSX/rjC1+a4lltUBIWGup+3vWq2CMZGpjvnIUwgkV5HJa7gScIOZXD5lqMnJikWcoZQm7DoBzyz0n7unFOKAJtAL1ZshIzFVWPaQAJcoTVzljOMJYBFv4DJCKx8qz+sxlYguL1A4Dl12yhOMzn4BChoaxphtb82V4NEXRFQKgg7YHdqSGVzHhtj409pqo9m2ooHhFCQ7K33MOytRNdsAbIkNKJsV93nrK1HyPhRNEPUF/8X6G0nl7UHFKWdOyMgaSD+nPMf4J15ruAWwKk/4gn4K85rltvgCwvyB3immaDq/sN66ypLNiMDmLUoukO1Q648vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnChnOwvdH8lKGXsd9eBAqAaHu3aNVzjLDc4s4+yHUs=;
 b=Mdqh6wO+0uXBt+4eUS3xGK2gvbTPsuIVmpEgFNhGcaiJrcpU1LSBpkFCxCNhkqjIdi2DROwW2Srr3tK/Lc1rjMKsECYgkt4tVMFgspPKCNRSgYQJcG/BJLYGBIZJuJxiZVR5LeSwWC14PQIn/0AmgY4ha5nkjg0+5YgSO42SV2/xclNeRVzGTld+J5LWU+t3F/BomUlK9r6q7CawO1bKnKokiSPC2QFQIb3aDunIX4OfDDtY30fb5ijt+AuJtHqNQ4CxPN2uwMnptw5TKlt8VH2obbK7Ri4ICc7/9ukX3OCj1SDtMdn0wzJjUIfhPbSvFMDaJ2b7LysB9PKjpoFaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnChnOwvdH8lKGXsd9eBAqAaHu3aNVzjLDc4s4+yHUs=;
 b=JO+IjpDZVx/wmdAONTYNjJJ9EkhLVCIhIy7ThZVN0V9vja20K4Y61hS9ilFDXtetMRyWTwdYAg7NWUzDJOGm/zjtcr0hKopVIJYsdMJn8EfN9GTpILiTFTDDzckkCmCGpEZ0blOig19gUOkk1n0/CyVDxCTBrUsNJ6CCpi5OHfvKCI7BFgNNENbnLDcSmKuuwIA/MWYUuBPt49GH3KiKG2A92bNb4eMP3YSsgwcEdcy85znwhmnTQhIzrWReQCwwVRNX8IVheQseZMFeWUCAE82R92MYoKXEP9BelU/tmkMPyR2IvdnV3QaPrlNMAkMtL+4zzNgjS4MP7ciwB4HkPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11082.eurprd04.prod.outlook.com (2603:10a6:102:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 14:44:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:44:53 +0000
Date: Thu, 21 May 2026 10:44:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: dw-edma: Initialize IRQ data before
 requesting IRQs
Message-ID: <ag8aX_2eOmInjpGN@lizhi-Precision-Tower-5810>
References: <20260521142153.2957432-1-den@valinux.co.jp>
 <20260521142153.2957432-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521142153.2957432-4-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11082:EE_
X-MS-Office365-Filtering-Correlation-Id: a1da3059-d2db-4740-637b-08deb7478504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|22082099003|56012099003|18002099003|38350700014|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	h6KL5vNfHuEdTkIcDDfNCuYSuHQtkenuufJHMgykpi1nxDkfTgClPN6MAufaztxvcwzwaacMSSQwKRfqOuaSBwmmiY+s1Sa3+1gg+4NAU8LuoO1gw54ge0D65FZeSlpGxHvwbjv0gP3Jrsa1d5rQhjhsNHx9mjilUBgFuPiRo0ylR7LmhdgHtRhEfzTGlKrmko7O/qo9Fihpuwo97Axu1VmAiUwIaWKK/onZdd2yWi5fMV6H44XVZUx/JGGqVUJUKvzkxdrhvtyBpl6b/rMuDUVCrYGqmr4KMeGlP9PfLYWUYuSzn7LpCR2t86KLAks5Pp5SrYJrbdvlMsT3XHogmMBhkbcCEkbyZnh1jLNQQv9TNOt2WKNcl/b1/qggkvdC9GeXYdeeNeg1BAUdOAUOVPahx1qmXym5qV2fOURbt5gpqLnbiCELac/BCgdWf4kgolorfOBvzSOeK00giex3Qx7pGh6UlcoYF5ZWHjhMX+SFMy8cU5iC2I8wwsdGAEkGTM6JJA5SMBS6PxOzysakpzsgj5vIfuMwVVU+vH2KStdAHqOTgtauBb09mFzaOmzjCS1YrQP2js3v5JkehAbkXOURSP7/Wdqa159DjViICroy5MzwuNnWQripETHcaD8NPlRjKEtd7xAzL5n9lfrr9XnRjqWjme7WavcEMlQ2S32djayZ7fN+wlnptHsaP7qLC6AtLkONxoiV4aNWdIwEKxV0dFfO3cra++Ux9Z0g6yTR0TkcjCYxwEbqffmop9qO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(22082099003)(56012099003)(18002099003)(38350700014)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qo8PA91DeVLpLZCdG8Oo+/b49hVuAEi06yzB8BYV+IxhAAXEOLdCpaAKW1s7?=
 =?us-ascii?Q?lbE+2YMiEZLx8WUMnEXoJYeg4RiTfLL83i+dnWAjAU8rDyVQOWuXLk+Wckfk?=
 =?us-ascii?Q?KrE9RLhNh62jLOuPbn5D9fbuFIAYwOC3yBu5ky/7o2W6VOt/4V1sIX7wbule?=
 =?us-ascii?Q?mq0vZYzBWlP6ZMi1U4JDF5GUiPr2ABqXmUwdruFsmW/gwigvWX6jZIRiUz56?=
 =?us-ascii?Q?Kgly5uSmw/jJ0aQYLsRVesRjy5N4vVT35hoW6JDVaXAJwZS8aovYVSJ/8XQA?=
 =?us-ascii?Q?DRNdmxxV/sdmVMsibkhNwrqSvmLhBqzfT6/JFufEu+sur40CYTXd2Aa0t1pI?=
 =?us-ascii?Q?akY93n4otoR6GL2/x8QIdN8MUTHkJ0myxf0LNNlQemaDRcmQR0xIJ5w56//o?=
 =?us-ascii?Q?8y7r8W0HdFeeg/UuwZ5yuJu4mAeP01hflABF1c6OzYbU/X1Bl6LYowHL9XRw?=
 =?us-ascii?Q?JkhXQ02qrE2haFGuf491UXMqq5q7eqjKCV95jFQY9dgD7IEQJ3l1mvOv8GhF?=
 =?us-ascii?Q?tuKNHjrU8DTaGKgs8lfDzQG11p1xxIAoWbAUuA4Ew8CsAkWuFuHN6Jni2V4n?=
 =?us-ascii?Q?RBUNYCAwOLJeX0fz56d34eEP7fk431CXhcHgGO7sL0YJ4/TB6SmIq61CI0LZ?=
 =?us-ascii?Q?8+s98pme5sR4h4oKlJL+WFNaBiBUfKL1eeOM6xZqtU1yYoHxhECx6ZnnZw/r?=
 =?us-ascii?Q?2gehWVdCSofqnIo4FzQvN+Q2TXM+4xQwa+rHGiAZUJgfASVNy5qhRCbe+qGz?=
 =?us-ascii?Q?KGC3gOc/VXa+8RkM7T5LTvwhIKH1kBX+571RVwwM3oMNWlnRISzCRjx6lice?=
 =?us-ascii?Q?HtZp0mrEabMuoreCCiAn4vD2Ub64FiB15ZgvSzqAlsSqLo9tH5k5/Q1pfA5u?=
 =?us-ascii?Q?wuvsAO2/sgAuNhetkYteMTSdTFkpHUIdfDQRDHSiqf3Arrj1PzJs5XY+Q85V?=
 =?us-ascii?Q?KBk+t2sgFNuZKraO3Ptt4yusn19NMEHFJHBp3XxjWNOnYi/Rn3V6CspMDPhV?=
 =?us-ascii?Q?aHCwZu3Ssp04YPccca4YNa/ReS0hBGkdSjAZVa0Mhn9eAOxYUp+rWiyCFN3T?=
 =?us-ascii?Q?wZmXOJGY85NC8X3N0S6vFtSmMeGbxgHWMparLTlOohimqz7tftaPnJEGtZX0?=
 =?us-ascii?Q?HdxqcClahnR4kR8uYH+X9ap/hXFRmlJhW839PhXiXqPuPewRulGuqbHPCVhC?=
 =?us-ascii?Q?Jh8pDDkjMAffgvYfvBrbXZKEgWOXFZEYS3wQsifIb831PFpdF14V3WLQMQWW?=
 =?us-ascii?Q?4RYmYZ5vjRPHY7LNHjK2faBKMcTrHRfVckdCRg4ncSGuO1Nq4S1g7OAEEeaA?=
 =?us-ascii?Q?9J3gJ53m0bILtsNFcSYBAC7qaGWzL9QDPEKC9oABbpYRzAqTVRhX5xwPARsh?=
 =?us-ascii?Q?SXC/Ait2+5gPsVcNEU++x5CmmsUZd4tvry92fG4+jZZiEm38dcFZO5z8xh1c?=
 =?us-ascii?Q?ZAv9wPN7NgFYoTNOKkhVTcEsz0CmH7L47Zl8Ruvq6NAdxG0AmuxoqdBuvxor?=
 =?us-ascii?Q?UhBF2/RNPWC40OABOGmYVvnSrV2dgKcpl1GqyNVWw6BfTA2P+CXPbSL0HP6u?=
 =?us-ascii?Q?LzFZ4Niyr32HvTfjpn5BP0IIKbP71Nho3g+XHdnbQvmiCSRXoonT1ahGYatM?=
 =?us-ascii?Q?/cOZFDfHhh57M+JEMY3uV69S5W6uToRd55wagHeltnntegDNOGrCN2K3wOj7?=
 =?us-ascii?Q?gsAcvtDWyoitR8f+/Cen2RnwVHxOZoy8nxJEZTpR+83DlALiwpDbpNPivPD2?=
 =?us-ascii?Q?Tu7+8h10aA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1da3059-d2db-4740-637b-08deb7478504
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:44:53.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EMn2nIlrKK6e8vwd5L0h7K29vOpsDPkwVJoEZn4uM6a53ts6LLpw+kBCSEBWt2dLAfPn6XjBACmxHA9JD1lgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11082
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10666-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: 213785A98E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:21:52PM +0900, Koichiro Den wrote:
> dw_edma_irq_request() passes struct dw_edma_irq to request_irq()
> before dw_edma_channel_setup() fills the back pointer. A shared
> interrupt can therefore enter the handler with dw_irq->dw still NULL,
> leading to a NULL pointer dereference.
>
> Set the back pointer before installing each handler.
>
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..d221e3efcb36 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -929,7 +929,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		else
>  			irq->rd_mask |= BIT(chan->id);
>
> -		irq->dw = dw;
>  		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
>
>  		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
> @@ -1018,6 +1017,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  	if (chip->nr_irqs == 1) {
>  		/* Common IRQ shared among all channels */
>  		irq = chip->ops->irq_vector(dev, 0);
> +		dw->irq[0].dw = dw;
>  		err = request_irq(irq, dw_edma_interrupt_common,
>  				  IRQF_SHARED, dw->name, &dw->irq[0]);
>  		if (err) {
> @@ -1043,6 +1043,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>
>  		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
>  			irq = chip->ops->irq_vector(dev, i);
> +			dw->irq[i].dw = dw;
>  			err = request_irq(irq,
>  					  i < *wr_alloc ?
>  						dw_edma_interrupt_write :
> --
> 2.51.0
>

