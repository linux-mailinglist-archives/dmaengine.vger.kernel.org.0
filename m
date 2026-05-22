Return-Path: <dmaengine+bounces-10750-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJmLJhVuEGpsXQYAu9opvQ
	(envelope-from <dmaengine+bounces-10750-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:54:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 127515B686C
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0992730AA43C
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD113D886;
	Fri, 22 May 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="vafg6PV+"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020126.outbound.protection.outlook.com [52.101.228.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0FD2264D9;
	Fri, 22 May 2026 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461139; cv=fail; b=ajisRb2sZTsZvMKRRNntM+KWlxCJey6pmNrcfDZWyr+luX7MMWe/Y+V6Qq6cCX4MJ3gKP67q39XZfrMJlS7syJ4VRmjG4sUps4DbJDFwy/xBrJo3jYTokJBsCtWSdOmeqWpkFxez8h4CyjPRVEfhJvmHqRyHrv/EYVdcY2YByAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461139; c=relaxed/simple;
	bh=OTUrnSC0bEL+wpMZdhH2baKV7qjxC2s2Navc1355rzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ahpGo0flCPZm7DO76jHju+1NRbZ+EGFmfYP8k4W7ri07u1qTmQ5A4CZ8wmZhYvaM/x7p6MLvlgegdxSbrOGxGgew7SwGdZ04TUpGeIPAwtm3WWWtywywLXF9jDPW3l3VPc/Y6D5HqW6RswX+828hedvxFPl4z2SfJN9FyYvRd/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=vafg6PV+; arc=fail smtp.client-ip=52.101.228.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKQle4PfKoND5O9hL2WeMKbWDq3yPME8cOnqrEVf4gYpHJnkAQKjXzHfWxvrQpHf4c6b4jH0GtVg46X4oT4CHfNYDB264u/nVAuxgx7Jb0d4+xf3p4VV0Q3tSNHNTPqHKQvLz9pylAOKWZf3jHGxZyAQT8baB70SoigZa0A6jY0VG3hFh3eygFt3eT2yrz3LIlWLUNTfttWXjzKt39h4NkRbW/UIEaFrbv9ONcdd4qEVNOXpi81WLHbhQl6tKidKtkBbgVfDxgHA8KmBF3FYY4/zttaA0l+WT2AOSUT2YeHwMcOVdQZEApJ92JyLkjHTw9kgMA2t6VaqeLjTTT4R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muGIoG7LkIlsS1fdsuI7xrHoyiWF4TYoIV9LPNN1T6U=;
 b=Ho0PQjBP+rYqhEynheROdbFLv28f00wus04s7b/S2tF8FTfCyz/8DJaaCdsuabSqg2KxukglYg2b+vV3oCdVLFdlMGiLXCv9mtSop3gGlMTnbAx2vBP1RtR1OwYDVbO9NbiCJqow/xFXvRFB2JO8VxCFVGvpTzn8O8rLQbIr9pWYBIgPhnc5A3YP+nZgjQLY5bhXaF70sAnRL2E9LFiU8B1DSm4HNDbgJcNCNFbGAWvMKaYRmY3AoCzkBSkEwpdWAbb0O6shxyfnVH7870v4K4IjFkoH60XJ2Duu1xe419QTKM/S6dpX6MlQ5k7FOjMjtioJRT7hh6zeOaQuwZUqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muGIoG7LkIlsS1fdsuI7xrHoyiWF4TYoIV9LPNN1T6U=;
 b=vafg6PV+CDeIRnKpH1Mfpzr8xDv9LjHUvawkHWqqO69VcD6gk1nQpKSDSx7BgUjsucL5gaFkRfEDb0k9j7SRrGo0PmLT5FPk2+fkijYvlfRF6q1mU/Haa2Y+D51IWzw/gXvWvGt1hP6bwYMS0D4IDB6bIElkLBxUQT9XvZVbHJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB1773.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:45:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:45:35 +0000
Date: Fri, 22 May 2026 23:45:29 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] dmaengine: dw-edma-pcie: Add raw slave address
 match flag
Message-ID: <vat3hbnrc4x4lajmkuzwgza6jojxbynocjw4lpmyxixhgtmfp3@xgpwhp2lhpi6>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-9-den@valinux.co.jp>
 <ag8vvdZEO7pxvj5u@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag8vvdZEO7pxvj5u@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4PR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB1773:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f252f2-dece-4fde-2b2f-08deb810c864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	vjA9d6fsf+x+69xpNcoF3fAbLtBIeCi5V6kPFBa0sM0382FBaV17ZuM47KiaguW37y2VGtQtOpKdarRuZNJ47VAgn3kVR1EnDrTDAJlkzvhnVXCvcP+pDYNNj3xT0qe3LhoLJOlRDIvHPY8AJlZhO+tcUr865rJbzuFFs/LtfQBrdf07dJwU2oSqBGNIDwIDZAJNXwLeYMqJ2hNL/ViOqTHH4hN9aWbYZXtqTTU4xlplJ6os8xvl7WK1orWD8slCDf9rlvzKoVte/9auzWb+jUaaJYJEONhjEX9HQi0mZ3b6fYxToz/eQy/lFPckuuNJtdy2juvI9igVR1ymzv3PI4tBNcKedGYmzgEivPOJ1OYsljfyNmeVzhGSWsmk+/28Znqpdb1LUYNulEHYm7dtI3zyYTZ0FtVaFLKGjBa2WZ3S4IoUuydFsNO/PkJrmaZbsGAx7XI/2a3rRstNOaONIRJ8vO18pO6zbgxC1Lobizo99pNS2GyirsqP6vq3eOIbXysFFnWeDRFHwp4eDK44+nB1Kmh7dVQFlw2pR4Xcd7h4f9QGISFxhaUCwBlJdH7H/304AaweAkDHgHE5h4cOjIPzG5FQkha5sye8Ua7hEcWzQwUdhrhHvJT9PNHpaFkXG8ij8yolmCHymHrYxNBMCHjM5zNU17Vavz8cQvmPKRJzaXzMPanlxmLQWsT3j5zU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uVXshoo3XCCzboU6v43YfONdv5SWr5r8NatzC06DCwjKYhunBYaneFu9HZtI?=
 =?us-ascii?Q?LsNF5Kkmb0Uyphou3JGx2CrYdCmHPHgdgtIiXAeJM9Kc+LCeYin2rR+6aW+Z?=
 =?us-ascii?Q?V+EFsDMksB4vgVCGxBoR99gdAdLoYWxJnQGJBdPedP+/hXSrL+NQcXtJCRlk?=
 =?us-ascii?Q?usGCLmgLx4rpjM+Pdrock43X7jR+cu7XwV0ApiUQ4NHRakhMBoyPkqrjsApe?=
 =?us-ascii?Q?Py+07Mwl511Boxy7yThZ9Wsm501PsPBDa3zjuPTE8JY3h6EtH/7DbzY8hn60?=
 =?us-ascii?Q?EI5jd0+d7gu8QI/Fc0b3yDZHPI5oq9lzRnpRR0pPpIrgatgyBEeIbbsY4gBQ?=
 =?us-ascii?Q?bc0v0xO4FpjwyF8Mcp15qQYmsIZTY7LHL4RwJJ+aaPd+QS3J2e/azmIYpw95?=
 =?us-ascii?Q?App/0SbukaxtGnlUKzBC7+15HnEUl1V4qsvuIJyDfaZ4zbnh/z2p6Yfa3Uf4?=
 =?us-ascii?Q?8h9kcu5ex2U+YvNuOL1Wp9rbup+NOdmuh7jCbjjpeb/nfehuwkW+O1z+iNMt?=
 =?us-ascii?Q?olhV4GhrZ2UTN4dc8xdBikVMyNAtlujAWC2KgsSDDScXeHaYyWRCbHcy9HVH?=
 =?us-ascii?Q?8sr2Xyorer/6iHRmrB6d3zvfMV7xKGACVtf/8RhlxogBqKh2Fvn+N7q8H8cp?=
 =?us-ascii?Q?4bTVOBsFXV6PzIUvI1xU2SNBnv9aT6ufz+z82TK8qlwxyxUyeYq5rznLLIYe?=
 =?us-ascii?Q?3mkGt7m83F6SXB8ENBauhNbeT/bax+08YW9rDrmhVa76pmzl7aauM6DkQ1U2?=
 =?us-ascii?Q?B0WhQAa8XfB0P8J0MvbbFn3G+5axKicUnn5pRxhKR1ldTdDY1VnrCSTuOy5w?=
 =?us-ascii?Q?wZtMDhiAdcVOhLd7x2DZx1GpcOn61KK26qiTlVULwIZcxLAg8PH3N5au7a7B?=
 =?us-ascii?Q?pmUH1cu7QgWiE+tBOw2dZrtBxs0DzM7PdLpyr1A/A1mAdaB66hsBjAydZu0Z?=
 =?us-ascii?Q?IXRQNp5EJcWtlzVmxRuzpfiVRgKI8/2/PuP5yEWvYlWFibokAXlkLDHhNGoY?=
 =?us-ascii?Q?5dJSMi01VzLIEcI+h9/RAUPI3pX/m8ncWXMj5ZmG5+br7WOeTQtBT9CFNsD7?=
 =?us-ascii?Q?aG9FJSqBkMVfOLog1brgC/hDm05eIUxJlqJTiidk1bonfZhwaiYV49pYnfZb?=
 =?us-ascii?Q?qiIeT36/wayxcfRRCYcl/B0lO3tV0r47zkMs8OuN+t3ter+HFqnFT0IqoU7e?=
 =?us-ascii?Q?LpXtlP0Rz1KDt3Nj+e105YDtrZmdmj9KBvekGp6JiG9iELFSEZlTPJmF3pIj?=
 =?us-ascii?Q?Q0hru6ImJVKnSm6r3yUn3yUJ33Z3a4Ksw6vFpMksBiLCaHscjxlEJNDsIN4x?=
 =?us-ascii?Q?vF/0crKiUycMTNzw+4NP9Yh9Iy6OSCfBMy/m6HFRh8tOebkLS/CgPSp7xy2J?=
 =?us-ascii?Q?c+iKKHMMpidMzXVRiGQ7j7n8jwLGuqTVXIbTzuVGp7Uo5Vnp7oaDyAy7VrmB?=
 =?us-ascii?Q?7+PjpLNpMiKEqVDxDBzk5wo/66hO4EV8FU2wEwJ4M+K0YPvGhjJVx+RbJK+v?=
 =?us-ascii?Q?8O7CghUo6AUy6c7etaYWTG6TQT49D3uUiktjLmjwMtcexpRnD4q5lD3oSG17?=
 =?us-ascii?Q?/xgLhovRrFFBV3U0mUQqtFoOurW8UB9exa8fA1Ip4i9MFIUSALEWVVxTmiZI?=
 =?us-ascii?Q?tDdklQaIFlpw4vU2CYNZsv5SISriSfDxOrCarv3ISjg7yb3MhnxCZ8K6N3Xu?=
 =?us-ascii?Q?piUEX/R78r2rdjtL22QjjJAp9trEeyfYySHsl+o2kXkA2/prP77TG/oNDXWL?=
 =?us-ascii?Q?6baZN/TocQGVmApjyWQzs7z3QzQn9ft6uau8va5xxPs5594Wf2bF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f252f2-dece-4fde-2b2f-08deb810c864
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:45:35.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2MteYyXNzfYXAyZzmKCTkCXIMqGR3LdzUTTgZgLp6YYwkcz44JjH8UjeX/GwMaMk3HphAo2L+O/WwLHX1v/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1773
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10750-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 127515B686C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:15:57PM -0400, Frank Li wrote:
> On Thu, May 21, 2026 at 03:31:11PM +0900, Koichiro Den wrote:
> > Add a match-data flag for devices whose DMA slave address is already in
> > the DMA controller address domain. Such devices do not need the
> > dw-edma-pcie pci_address callback, which translates a CPU MMIO address
> > back to a PCI bus address.
> >
> > When the flag is set, select platform ops without a pci_address callback
> > so dw-edma core passes the slave address through unchanged.
> >
> > No functional change intended. Existing matches do not set the new flag
> > and continue to use dw_edma_pcie_address().
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index cf2f09f1891c..651269708cc5 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -87,6 +87,7 @@ struct dw_edma_pcie_match_data {
> >  };
> >
> >  #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
> > +#define DW_EDMA_PCIE_F_RAW_SLAVE_ADDR	BIT(1)
> >
> >  static const struct dw_edma_pcie_data snps_edda_data = {
> >  	/* eDMA registers location */
> > @@ -208,6 +209,10 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
> >  	.pci_address = dw_edma_pcie_address,
> >  };
> >
> > +static const struct dw_edma_plat_ops dw_edma_pcie_raw_addr_plat_ops = {
> > +	.irq_vector = dw_edma_pcie_irq_vector,
> > +};
> > +
> >  static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
> >  					       struct dw_edma_pcie_data *pdata)
> >  {
> > @@ -435,7 +440,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	chip->mf = dma_data->mf;
> >  	chip->default_irq_mode = match->default_irq_mode;
> >  	chip->nr_irqs = nr_irqs;
> > -	chip->ops = &dw_edma_pcie_plat_ops;
> > +	chip->ops = match->flags & DW_EDMA_PCIE_F_RAW_SLAVE_ADDR ?
> > +		    &dw_edma_pcie_raw_addr_plat_ops : &dw_edma_pcie_plat_ops;
> 
> Can we direct put &dw_edma_pcie_raw_addr_plat_ops and &dw_edma_pcie_plat_ops
> into match data, so needn't flags DW_EDMA_PCIE_F_RAW_SLAVE_ADDR

Yes, I agree that makes the code cleaner. I'll do so in v2.
Thanks for the suggestion.

Best regards,
Koichiro

> 
> Frank
> >  	chip->cfg_non_ll = non_ll;
> >
> >  	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
> > --
> > 2.51.0
> >

