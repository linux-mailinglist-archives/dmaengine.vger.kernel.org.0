Return-Path: <dmaengine+bounces-10769-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGhXJ6DCEGp+dQYAu9opvQ
	(envelope-from <dmaengine+bounces-10769-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:54:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F675BA3AB
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 923E4300D1FA
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0104A37CD35;
	Fri, 22 May 2026 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C1HksAbn"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD893655EC;
	Fri, 22 May 2026 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779483292; cv=fail; b=P1RzA/KE065qmWlDCE6q4WB7MCLqXqEx9c84GDfp/ZoCNH+K8U7zJVNX0sNyLY/ZkX7/ip6JRgzeEabPMAnsQ2phDTins0pW0VFn/BjvgO5/yST4TwghtusoVS+7qy+d+spnzIHvEPYsXy/YI2BTKF8F3sM3qFXUd6njCw1xWVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779483292; c=relaxed/simple;
	bh=uusFTFYLRTZZEO53IY5aRPRtVYm/Xkf/CEgRkfZUxMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z8IsJHpvbk4QjVrrc8Uisb5UNGZ42ZAwhAr3PzisH+ofEF40Vq6pRGQENzBp2anFyb9Ut4dGzX0KnORDhScjXFfNNo9s5WG4n7tOqYBBjZHEQlHwJQ9UNCZyy23j0ElgSTyn0oJ1/Q/N34FeDGqvODjYNV+xqXgCUHXGoPpGCHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C1HksAbn; arc=fail smtp.client-ip=52.101.72.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2F58xl1t7FFxmE46IthUm+MNCygZch3kWhOAyASW5g5SEu83dMDUfbpptD5f8odhMU+S6QNhDHC3snN9MBU8+N4+ZsIGCjUFfioKK9198KI966YXl2jwFFXudq9EbKAbXUYfYaMWm/pLKzjmyeHhSA25HzB+aCzFaVyK5mo0YssuBI9wheb7qGamM6hkfGwLhzV3whDiemvtDQCkpWXx9pKOe64uX23+OKRzCtTdJg/f70swrzWmf6ex1AHPYE43pUdways4+xBglDW8jsAROOHhs6bF2wFHeY8M3GNYopfHHxEs2ReFeBXUHxbDLc+oLlLurPIVkVMqcDfZA3+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiZJ3u4fCmpZcw7Os6W0vr9Ub7Nt0WZgrPmo6OiIGKE=;
 b=DJ1OQPybvxjq+cEMfJ/HdnZWE57oaSnD6OK4lGn6IiIYZg6h6ZwS+jVBTplrPM2YI/CAqmHoFenNe/UyDZZqi7PgWXqyUZNnUTDd1Iea6wq3H8vNRXBbqf5t3HaDadkoUZJzOAeMpxrABFNDT5809AjML12dWebi+XqkUI7YZKIHwBO+Fvh70gmhhe8jlJvXKHh3EB4BoX4fPkUciexZQoxyA+PGzXWI2h37Vel8VCgqZ1MI8UOwTYyYDLTSwVkxgwrOg+sS9WhhN7mpFC3+WFlAHzJ6RnhLoyyzZQdswaFgd78Hg837Bg4wDFoy2SeFV18W4jrB/E9epbAtP+plCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiZJ3u4fCmpZcw7Os6W0vr9Ub7Nt0WZgrPmo6OiIGKE=;
 b=C1HksAbnmyckDYqTBABfdV/IdehbNOnn6SM2doYKQ5E9El3/FKNw8PpJJy4wePunkn7l7J5E9PgkTWv9oiqrEn2YgADrN3K9pzodcBvitAIKewWlH0jfWGPtVQQaNXZN/VfzWExECnRM4OMM1/xevguDJLTIns8KigZvObt5A0n3W6VM5+o6kQIRLZebImUfTK/Fnzv+l8bQyU6XIVANdBqIUjBEdFzfYmQ2wwkL1tjq6/OH4ArRiwn6MQjPuzFWfhp5TssN2qJ/egIKMOIpw3oo/y6bosklTN6MaNeVE7Sl34cCXHa8FLeaI+ltM9YyICrz16MvYurHTPIbxx4yAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB11867.eurprd04.prod.outlook.com (2603:10a6:800:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 20:54:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 20:54:47 +0000
Date: Fri, 22 May 2026 16:54:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] dmaengine: dw-edma-pcie: Add capability match data
Message-ID: <ahDCkO7UOZw1v0va@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-6-den@valinux.co.jp>
 <ag8tmGfsYbWVi6NC@lizhi-Precision-Tower-5810>
 <srutyo567gkhj6dll3yshohj4widw375whojfbgk3pdtcn4g3o@ruu3um44gz3h>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <srutyo567gkhj6dll3yshohj4widw375whojfbgk3pdtcn4g3o@ruu3um44gz3h>
X-ClientProxiedBy: PH7P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::34) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB11867:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc5b44a-7805-4f71-356f-08deb8445bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|19092799006|38350700014|18002099003|22082099003|56012099003|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Isvv1Ca8SySnyEIzX5pDg4MSJJsFMe2ZMojIte1oMPqQu6aY5MfsFg9XelLPVBjpJHWDD0Niti8M10EZ9X9dN2WQKBDsFR38V+rTNXPOG2YLE2vu8obcHiie2O4DKBUAqoGhSS1ZyKx4NXbRb+IhVh0/gyMVbM47V63lNfyj8u4Mk/nqFIoRKEae6wtcKUzZEYpeF0WzjIC6XwNGSjrVaymmzxoZUizZaGSwL0W9YzJWZFzhwC1hH5dfoYG51xtWGkfXyhiTKAf3v04SSK7Twcdo5eyJDihOKIKsvNH/u3aNALDgJlQTYODIVi/NiGOyUyZOPSmd29+0QULaVPg/vgm/WmKjFb1TtpaGxgmNc4HjZYjr6gD5Ul9iGMPU+svc9JQVs+hc+sBbE/ywS/cJPzbULWejGc6CpRz574C7sDu2kcZHcCdATTq1X6HXMu/DsQheq6oNm7R43BGx1tGvICEaHOI0lIFCKh2mkWnHzJs7sBosf7yVgi0LjAsHXx6Qk1jZhDXdz7yuwvfsLnDeSwQzaTMXxYhBT/V2QkZrBGH3nj67EUN3F2sGwWoeNYgBu3mNo6MHautOz7ftLasDndVHp/0pplEnMix185g1Gq6zWS4Ye2yjoxj14YmU1MibxW0iWhlxXwmrtepiIpzSPkEAP24YSltdmhQ52mSPRgUK91C7NG+so7DuT+0dfjL+dGWT977BnKSl/6x33fE3tG2WiIFENgLzQRE2oyuh94EEuUEG7OSeWmOixVohR/8r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014)(18002099003)(22082099003)(56012099003)(3023799007)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H4itY6u6lGrRB+ScD1y3rGqai5pKCRxKlx3A+yy5T1As2CXRpzzoFnamG4YO?=
 =?us-ascii?Q?mPahY5PAXbDgpvWsXerT1FVSC5ACvtyKbxMkareRkIU2df2Y4vSqJVrbj2Vh?=
 =?us-ascii?Q?8j902HzmQFMm0tQpKSmzUmxwafVTze13LgBtihB1BETIJ2r909KfJFWkvyJ0?=
 =?us-ascii?Q?zmURvzYAgSEGYzeYncuL0Uk83StF/9IPjLlBP1Ffey65IwtSdHkuaOybZdIc?=
 =?us-ascii?Q?h6HfBk+0MAZqJIWZehPkUMI2WPEcB6oOLUwVBlbWn0Ef5ffI7NWmh3hzbM8d?=
 =?us-ascii?Q?7pJsuxdGsn/tQVwp88guRuCTK9Z2BFVYWtz49IU/w+lVwG+COWSQ8UQVUmkn?=
 =?us-ascii?Q?zysUC8MVdsfDU6HB7So4vjuppWqFSyXWCP/d5FZ18yZOFvxV2n7jvjDDwSLs?=
 =?us-ascii?Q?SXjRtdeKxsNk/A2tYtvCSZjxnVpY+D+88tIaFWRAgrnsh3blqan9joUADfni?=
 =?us-ascii?Q?F6hoODio2A4eIrLznubz+K8rREAvqN0nvj6WiN0LDvxppNJQb+kvhwtII9oC?=
 =?us-ascii?Q?eqVcvDA7H+2qweWnAYsA0qlzipDU0sX1h1XmiPgot7T+hPNB90AYr+sZPFIy?=
 =?us-ascii?Q?EtpCNSUzZ4GOc14TGwYHwYcF7x8Y7yMwgxMkc5NM4gqhWOKMGz9EdaRKtfLV?=
 =?us-ascii?Q?3T0IcQdmu4tc4RuGwYR1uFPBZ//k9tga41O52WIBiCeA2zmyFtD2G2GlUXoy?=
 =?us-ascii?Q?Yu18ZNkZe9Kmc/q+6QFyZngvwh1QLzFxJbClTakeEYaB1FqFsArR1JFwOLMN?=
 =?us-ascii?Q?KbhGJjEJgWBriRKAH6oJ3Abtp+bqmkXaEGGGfDfT7dHqTg1qTgnv2vYJSAPz?=
 =?us-ascii?Q?F8+6ujISP6wNpkajfKbyzP7KEqz3T8YEptyDJwsn4FRYJW40L8UDv9DSjcq7?=
 =?us-ascii?Q?dsKhh450JaiEd1/ilGdAozxErHlifhbKt9cdz87+peeGR+wM0Me+9boq1Ua1?=
 =?us-ascii?Q?d051ihDav/qo8PDSyxbUNCuh0TXVF2QcxDoIZB6TMMSszpXOV0Y5WBtqnV27?=
 =?us-ascii?Q?mKo0QN3TP0qm13+6EW6oFHmvFX4sh3a/L2cSCOtXKo/2bZBn9s7n4x5ah5CG?=
 =?us-ascii?Q?Tx7mdI89vcjJDYieUwn7ml5zQoDBKp/6CVd5/s91juLA0APaZ6Y2T/y2L2Vo?=
 =?us-ascii?Q?796YIMARyD3uGqx362xjzMdLhSE6ncxjyzwvC0meryUkYp9mxhlyOVSWX3FN?=
 =?us-ascii?Q?OsZp6X6u+vQ4vwVVYuFLuq0jGm9tsUNpxwNR3Tvxq+pTVtiFCz/bkFIWc8vr?=
 =?us-ascii?Q?PyyR1qGzfthphmLnVA5vKnS48l4nT1cNUJ0EqDGkUCMj1nCLfBtdW76H/RmC?=
 =?us-ascii?Q?VOlr2NQK7CEdPj4YLRDNIfjM0ssSlxq8UMh9Bu6+uRPr1FMKzYaUtmnuFgmp?=
 =?us-ascii?Q?BzPw7k3zOILCfaMBka/ohUTixKoMhdYKeXb1vlkvzfuEiKgbmomdNj9VX5Jl?=
 =?us-ascii?Q?3dP7LnJN7jejlgx9Cv6D4mXvnGd6lBAuqLvF5KxVu9D04m//FE5xBm1bQEYQ?=
 =?us-ascii?Q?wco8j0sSOb2S+SohlBO5xMBQ6GpD3cxNjoTy+93ujVrHnA3b+7qEHhSSPKTg?=
 =?us-ascii?Q?FlgCkaAjnAP9OT8xJKluXKL50YWnNqPdnK/B2OQXw1WEZAfWodaySFTgJu75?=
 =?us-ascii?Q?FhuJFCVwXvxMGaaqs3CSWl0vSCKGV7CY8IymawaFw0Cwy6T71CNO+OFcckoD?=
 =?us-ascii?Q?hyaJeZ+y/FoT3L91fPOuX9llpzh7b/kHCdtvGbRq9y3oxZk6Hcy0qBNviEDL?=
 =?us-ascii?Q?tSyQolFj3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc5b44a-7805-4f71-356f-08deb8445bed
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 20:54:47.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHT1li8ZesDPglLPwKOkvuUWbjnoOCw87s6tdKYHVvmzBY5nHrXMC3uQR4qpEBDPQvaVJiRnjllxci/zf2UvkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11867
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10769-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,valinux.co.jp:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35F675BA3AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:38:35PM +0900, Koichiro Den wrote:
> On Thu, May 21, 2026 at 12:06:48PM -0400, Frank Li wrote:
> > On Thu, May 21, 2026 at 03:31:08PM +0900, Koichiro Den wrote:
> > > Move device-specific capability parsing behind per-device match data.
> > >
> > > The existing probe path mixes two decisions: which static template a PCI
> > > ID uses, and which device-specific capability parser adjusts that
> > > template. Split those decisions so device-specific discovery can be
> > > added through match data instead of adding more vendor checks to
> > > dw_edma_pcie_probe().
> > >
> > > No functional change is intended for the existing Synopsys EDDA and
> > > AMD/Xilinx MDB matches. They still copy the same static template data and
> > > run the same capability parsing logic before BAR mapping. The MDB entry
> > > also keeps using endpoint memory physical addresses for descriptor
> > > windows through a new match-data flag.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-pcie.c | 127 +++++++++++++++++++----------
> > >  1 file changed, 85 insertions(+), 42 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 0b30ce138503..043a7f73bf79 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -74,6 +74,19 @@ struct dw_edma_pcie_data {
> > >  	u64				devmem_phys_off;
> > >  };
> > >
> > > +struct dw_edma_pcie_match_data {
> > > +	const struct dw_edma_pcie_data *data;
> > > +	/*
> > > +	 * Mandatory callback. It may leave @pdata unchanged when the static
> > > +	 * template already describes the device.
> > > +	 */
> > > +	int (*parse_caps)(struct pci_dev *pdev,
> > > +			  struct dw_edma_pcie_data *pdata, bool *non_ll);
> >
> > Needn't non_ll here. This information should be already save into
> > dw_edma_chip::cfg_no_ll
>
> The non_ll argument is used only to fill dw_edma_chip::cfg_non_ll later.
>
> Do you mean that parse_caps() should not have a separate non_ll output
> parameter, and that this should instead be kept in e.g. dw_edma_pcie_data?
> That would make probe do:
>
>   chip->cfg_non_ll = dma_data->cfg_non_ll;
>
> and drop the local non_ll variable in dw_edma_pcie_probe().
> If so, yes, I agree that would make the code a bit cleaner.

Yes, or direct set chip->cfg_non_ll at parse_caps().

Frank

>
> >
> > > +	unsigned long flags;
> > > +};
> > ...
> > >
> > > +static const struct dw_edma_pcie_match_data snps_edda_match_data = {
> > > +	.data = &snps_edda_data,
> > > +	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
> > > +};
> > > +
> > > +static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
> > > +	.data = &xilinx_mdb_data,
> > > +	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
> > > +	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
> > > +};
> > > +
> > >  static const struct pci_device_id dw_edma_pcie_id_table[] = {
> > > -	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > > +	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_match_data) },
> > >  	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > > -	  (kernel_ulong_t)&xilinx_mdb_data },
> > > +	  (kernel_ulong_t)&xilinx_mdb_match_data },
> >
> > On going thread
> > https://lore.kernel.org/linux-i3c/afmEo54iWgk54M3Y@monoceros/
> >
> > .driver_data = (kernel_ulong_t)&xilinx_mdb_data;
>
> Thanks for the pointer, I wasn't aware of that work. I'll use a named
> initializer here.
>
> Best regards,
> Koichiro
>
> >
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > > --
> > > 2.51.0
> > >

