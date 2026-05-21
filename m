Return-Path: <dmaengine+bounces-10698-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHmnEDY0D2qSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10698-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:35:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F55A961B
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B1BE3127BA6
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A4385D75;
	Thu, 21 May 2026 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e9cr3mit"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38497383C76;
	Thu, 21 May 2026 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380529; cv=fail; b=W4CTnZGOB2x0eqR9tNi3duSAxhHiq4H3fXhSNIMk9A/Xa/TNxCUNAXirimzoHy7SKWzJFfrbiOWJPkC1dbWQLbh8lT8VvmIZ48fUlVFWwsLLsjhG6T1z2YhjsnsOZTyTA3/KOdhMBhww/PUYMRtkUEq08l49olRIAA2j2sgzIbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380529; c=relaxed/simple;
	bh=mVDRPDGyWUwPkGjgQ2cKHCXcH3jlPL2b1YhMr/x9hRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YwXJLj0jKvmUWAEQc2CSHTUlN7l48aahXz3O2mfAW45z6rmMAaFH26FnYOMzpMOALRj7EJr5u5gjUOBoFrhe0n1x1pHsTdBISnwiMGi8W1INxLXj2EzzCJ46uB2/kmQxGOvL1HTkxt8Q1XNNfDTDuuxeaYExMJbIZ8iN8abySaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e9cr3mit; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3jMxnL9dVpRrVANS1lvDeCSGNb+2e1GlCimgq43FaWIRo7Hp+01An4LOsyqYsbTfeXPIBUxdvX7K/cTIT2YD7GNWbxmKNnfim6FszWCQ0+Qvqp8EdpisO5q0cA5AYFkzOS2+XcaLDHcfradgBdNLtO1yUmdQEKy0oN/CBFV8ebhhAkakNt5rxpRuLfdJ39A8A0uGWVrnjpDCHJVQqjNwnar3fjzQFFYoxpprntj5K5yacwv++a6LcJM3iF8wyzRZjESQtAw9/rPzteDlLhSoUmSGoeDQz4I42q8IrFRU9kAMJ/mwdLPl9G1Vs60SZl3dVg1GxoKeVKtRFFltz3tLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmQoGrIFzXfQIJxj23kaKY7g4O9HsRV3XyKStmCTzjg=;
 b=b3kxno6J37iROm/n/EfgX7fVgPe+Bvd3tyZX9u4BXLFcLXqaJT/2ruMUOWBCK22umvKFdZ8E3l2Pm/fFy07e0nR2Y6J0tlBfsf/p7V67YVY4BXWHiaXsfHsT10Abku51XNcNjY9RwN5fLzK/ARpWuTtHGcJWYlte9acHvINljZV7vQlbys5cP+O8gDun5sWi59plXbAJ1mtzr/VRy9R5n2qen8PLlUGe7zRLkDCMKsrD5E+RvwUpUxOWB8W+Venn5nzxNR6r51Ma86Vvdz852KwUCfZ9UIQNUzUzt7yQwvqx6jE3O8Ad5dmRdAtByqODMpPtyDqPeCwCI++Y06XBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmQoGrIFzXfQIJxj23kaKY7g4O9HsRV3XyKStmCTzjg=;
 b=e9cr3mitObFCnsHqXqQQyoWY6iJ/5sMeDOJ514zeo3V6BinHIMerQzdtQ7b/eVPquF3nOnGaR6q9pphspcPVXnngN16KLY+bUo923ndsryN7drLR45FgH0lM+nT4X0aR3gPWq+a7lJLugg8bLTmu5KmgauOg+P0wLYwqMirdgiivCdlpkvmqs0Gg38kxjrwagi7XL7lYRuSxpNqTUULYk77Pmde4GTVeD+98Dgj1sN87EJzYYJwx+mX501pSbgi/OlCu89fYZoS0yFYR0jnQhsAgZpVZVv79gh5KTHcAl78y4BuI1Rhrvoyag3PE9tPdd9EphKLPzTQTPEYJSi6O1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by OSKPR04MB11414.eurprd04.prod.outlook.com (2603:10a6:e10:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:22:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:22:04 +0000
Date: Thu, 21 May 2026 12:21:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] dmaengine: dw-edma-pcie: Factor descriptor block
 addresses
Message-ID: <ag8xJwyL5kuY7LKy@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-11-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521063115.2842238-11-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR11CA0157.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|OSKPR04MB11414:EE_
X-MS-Office365-Filtering-Correlation-Id: e60fc267-6d58-49f9-ab1d-08deb75518ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|56012099003|22082099003|18002099003|38350700014|4143699003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	hFDm6r6PuWl6mvtvPv81zsLMwFYTLC/PHTHc0rOXE/J9/pbwzulDF51F72hbUG1e/Gwlj8OyVPNquouYDlxKCxpEmmWr6/B7R8OIaEO9tvrZ+y2hCGkmc8diFBcW5zcAUxiDCURY5qqmftbHwIFIB1mjUGj8n+DmdRi+qODh8uuZY97IxE9VebRCQo43FXBkiI95qQuQXR4uWz1Dgzq6spX3yWnsF6wAxRmN9t5EP2VTwwP1cYjy7i03q3yw19qyLQsoaMRX9Chy7COAX08TcZZunLtJF9+SQZcT+41SruKtJXn97NTwSwlKhaJ43zM3oGqIhsXTqnxCRtbvg1DQWdftVyZzwp2bJ3k5sTU0ysf+wXgVSQVD7T8u0BRDfq1ldiKvhPWF+FXjNsX6JzdvOam9PN/FY2gJMDfMUArRC7gGEeeXUUMz0WCA9VrPsL9/wqsGgX3ScMNq/yQWBdC3ng/tcLGbwLCi94PAvQ+AisJABcoyPu32HhFQLvaTbl71IZXXTXLuUk1tNGXckEPJxEIZFQaX7chC+OZtMyS/xl6ZQTgmpXRLAyYrQMQM8/qSjra5cnxuuR6XmHtkVZ6Olzo1xJorVsqx1EDsgvzNojD2AM28e4o48L+X687jyqsHad6VoKZ1Wk1Fcr8+KSLCiYhmC+ftpBnGW0IKmlqXb7QWuPPEqkYedlYRWby1RoamJt3/dDKfzjBaoWDeleLWR+zZEpAoJkzg5KEh75Uz87AdGCG9+BDPl0AhNcIfvFzI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(56012099003)(22082099003)(18002099003)(38350700014)(4143699003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdexO75yHqOGGbIVpExvaH7F2pmb2tb0wn1YKBfPiItw+E18YB8u98QGBOma?=
 =?us-ascii?Q?mwC9ReofArFHotFV12LhtL9NQ5xzVU4SQQT72dg+8uXgxIGWtTjXwYf1yK2Q?=
 =?us-ascii?Q?3TfxTubpoQU8ZyTlpPV69lyQlBO23L1YQt+K19RXl/leJywchzJVV3k0YVLC?=
 =?us-ascii?Q?TgoZWE4kBbIrQDyhZAPmd+m7vqoUxX3tbuyHOdvJpJ6dldCYTAjQbUc9TJ5y?=
 =?us-ascii?Q?Y0GZDGHeXFkGdHAJt5trzSQHk2MvfUaggoDdg3Djl4zrGGUCn+/HUk5Mk+t/?=
 =?us-ascii?Q?YSuR7EVZ0qYGPyY4zQ9V3ymQVDWsNWXZsn2fFL40kf2+tGUN+thtY5wgLyKG?=
 =?us-ascii?Q?P5AcLvZX/TNhFgfI7GaEsqCaqXbt15JFPiah0mzjPP4bVaPsdz6c8e0/E3US?=
 =?us-ascii?Q?EhqMm6AFA8ynQ6sHoFUJYDdAbv2wmXW8903QBw79ryJIUAL8m43Mw7F+p1+G?=
 =?us-ascii?Q?W6jGJP56N/kAT1A5o4zTlzIBtFXAL2+ppwf6pjZ5yaGtsnoHHvFqSUU/uCyD?=
 =?us-ascii?Q?+Zkwku93yaWAbh72zKQAxcSUZKA3tGh7FY0OZ+wR12QD72LJf04Lt8umTSWg?=
 =?us-ascii?Q?W+8UUGfB+22fwIN8fV6N6YGGtnjbbCVdjzfl+E5U6V1DfM/l416IZPRm8A5b?=
 =?us-ascii?Q?tlg+yIx1hZI9pLWm0nkSBvYKQjhH83BlqhF5bFnWSoWzkaAls4Ksv6nhdzJi?=
 =?us-ascii?Q?mIY0tFBBvhFHTaqnpEhMu4/f3hw9zFuKvvpzgwcFmmUH5tL425VKM1gzQ9zX?=
 =?us-ascii?Q?v2MXt37VkyoGUA1CQbk+qvdst2cYTF4pw1Ww5WzvgW8WX6+hv2H4mwvInqBk?=
 =?us-ascii?Q?vdfkVyWdRfMYj6hp2xZZnzssiF6YfjBlCjZk/sZcIQBDTBjE+C5VoJ/i3WVE?=
 =?us-ascii?Q?hJ+Sj06Gu7VUnBXqSxvqI/Z0V1CXpTQIwrKHaVNldq5c7m8PWkhpcSk88B68?=
 =?us-ascii?Q?59MD0FdsSdsEbWGQ8O7iZauJGr8ftvbZbAhYs4FmdnMbhkAM44t18fIw1PLd?=
 =?us-ascii?Q?iXkv24WXTC5PxSqv2SIQIeiPigI6UVoskxevHtgdfkI1TL+Q9uhaq13uHxny?=
 =?us-ascii?Q?h1owAWDfZYxNOjHL/DkZJbXLgBp/q6XRhFVIlkpP6vY2zoWNYLevYzkbEYFq?=
 =?us-ascii?Q?SaSZlYEDvdDSTOmWFRah/sIFEVVh+yJsj8zFs8z928ELnj71HCUcR1EaleEB?=
 =?us-ascii?Q?KDTdBn/VoPkiq9Md+xntGXL5kyI1/hWaKFV6F82FhGyGwN0LKlLU3s3VygpI?=
 =?us-ascii?Q?xbHlP06oFUXVj45fBWKWVGdmh2QIKmoAYpV7N8aoNfjJvTMJdgIjKHa5RQD8?=
 =?us-ascii?Q?x9lPW9zoIDF3GshCMWLRo4Oc1Koq9Le7/G/NeCNm8ztNvZzp7//9/c/l5Egn?=
 =?us-ascii?Q?zzW+awuWoxFdHJOROkOTVEyMc8P0snqhl/0DrLkA7Ux0inHXlhqr61in1E1x?=
 =?us-ascii?Q?LT5diaLlOjytJCfcE8zM/EhFY2FCNQ0hNQY/Bp2SGMHLIwnFAM82UnKVmBHX?=
 =?us-ascii?Q?cagGx27vQ4rNzXvgnme1+Yxrmw3jYCTSvnyRRukqxq8Kqe085YsRN8ywS9hX?=
 =?us-ascii?Q?WMgNAoQPtK/VK1/6Wr3+7HRthxP47y8jUfoL0dxXENqFtLeewv9nBpyCXRZT?=
 =?us-ascii?Q?kLUpIgqE32KiKj+r6hNn+/CQvJSV36cTi8yxkMyx2rSQ38LNrR+Cxv12ljMI?=
 =?us-ascii?Q?MrikeI8klP3kdZdkX0uM3fcNJ7Ab8UK24yEo5stopv5tRC/NYjVF5+DgMpgf?=
 =?us-ascii?Q?bbGPK6e9Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60fc267-6d58-49f9-ab1d-08deb75518ac
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:22:04.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wI4zFU29eZsp1vnJaMwH5KH9BBiQZhGdoOw0EYo+FWlufCrXiNtF+wgztIuGX1bllDH/XvPCd4Nhg+JSBCef2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11414
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10698-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email]
X-Rspamd-Queue-Id: CA8F55A961B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:31:13PM +0900, Koichiro Den wrote:
> Add an optional physical address override to struct dw_edma_block and
> use a helper to compute descriptor block addresses.
>
> No functional change intended. Existing EDDA and MDB block descriptors
> leave the override unset, so the helper still returns the same
> pci_bus_address() plus block offset value.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-pcie.c | 34 +++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 6b375a58c550..2a95fb9d5fc3 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -54,6 +54,8 @@
>  struct dw_edma_block {
>  	enum pci_barno			bar;
>  	off_t				off;
> +	u64				paddr;
> +	bool				paddr_valid;
>  	size_t				sz;
>  };
>
> @@ -365,6 +367,18 @@ static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
>  	return pci_bus_address(pdev, bar);
>  }
>
> +static u64 dw_edma_get_block_addr(struct pci_dev *pdev,
> +				  const struct dw_edma_pcie_match_data *match,
> +				  struct dw_edma_pcie_data *pdata,
> +				  const struct dw_edma_block *block)
> +{
> +	if (block->paddr_valid)
> +		return block->paddr;
> +
> +	return dw_edma_get_phys_addr(pdev, match, pdata, block->bar) +
> +	       block->off;
> +}
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -465,9 +479,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
> -							 dma_data, ll_block->bar);
> -		ll_region->paddr += ll_block->off;
> +		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
> +							  ll_block);
>  		ll_region->sz = ll_block->sz;
>
>  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
> @@ -475,9 +488,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
> -							 dma_data, dt_block->bar);
> -		dt_region->paddr += dt_block->off;
> +		dt_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
> +							  dt_block);
>  		dt_region->sz = dt_block->sz;
>  	}
>
> @@ -492,9 +504,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
> -							 dma_data, ll_block->bar);
> -		ll_region->paddr += ll_block->off;
> +		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
> +							  ll_block);
>  		ll_region->sz = ll_block->sz;
>
>  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
> @@ -502,9 +513,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
> -							 dma_data, dt_block->bar);
> -		dt_region->paddr += dt_block->off;
> +		dt_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
> +							  dt_block);
>  		dt_region->sz = dt_block->sz;
>  	}
>
> --
> 2.51.0
>

