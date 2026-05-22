Return-Path: <dmaengine+bounces-10748-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QByFHn52EGoZXgYAu9opvQ
	(envelope-from <dmaengine+bounces-10748-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:30:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 855585B6E8D
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71BAD30D7364
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B463AB47E;
	Fri, 22 May 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="E2iprSP6"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020100.outbound.protection.outlook.com [52.101.228.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00041C319;
	Fri, 22 May 2026 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460723; cv=fail; b=eQ6aKt1hCXMHP9IbzZjL6VYH42YUIc1Nwbe0ERGl/EUDiV4GWSquQBwtT69F8cgLca46upTzeptTi1eNljb+wwc/H5ToySMMOBK9jBxSFmVhTjyYvrHXQjl2iEFwTyYp6FZfzwd4ublM61VfNk+vlDhOcxTzJGORcnlH5iSGWYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460723; c=relaxed/simple;
	bh=Soc/5/89GBIdLo+MDPFBXfgTc1LGKSv/0PWllbUG59E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U7QdBwTxWzNbXSrOv0NBp8OskJMp5Zr95x349Jwj67p//jj1D2p0siiY1WnVZuAhjBj+rYUYWxEvOhhy5QpQkZgvdVfWqX1NREcP139EYFlf/KV0cqrjsoPS8jyULUHy/fR0e6DEoiwmc433x6iY5WLr14dH3yV3jQ+VN33ieWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=E2iprSP6; arc=fail smtp.client-ip=52.101.228.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLPELD3yXR/3lsfBdgiF2Tyo7fbjMiv5zxgpFV6kxtWAywpVEfQRPnqiUpjSKXBJfSWIAE0LbV3ntJItwQO5eiLCXO3IByS2q9FG/GWhxJOUAq/LNXkLSQtIy/HwSwPge/jIrKMdAT7MGd1TrUbMC1e2z3EsVhKrmqqwLi+XKsbOwnYBWUsewwG6HYns1jcXzwC9x2LeDQoZuCHc0XTNbp04u9swfv6CcGERrwC0mqQXxeBNbMXkAdHrMyp1R9UkYMN8gBUepYd3sR1S8Y8BnR6gx/+gsNKM6sQ5ifs8t3H6GSLvPt2NZhVyUD7swf8nyl+oRwTT9+kf/vp6da+JmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9CPbq2VFzRHv6Uw4Caa68HIm8zBwr/+53SmEye/Dt8=;
 b=ftI16cgbhjTNk4nasEDFzZ2m7gGtf5t93GqyEyCj96Cg8lO0EH5iVaMZvQeJLOP29ABEcXA7JoGoCQFmUAKNVX1aXgFGJu4TiKeJrtZ5Gj6t2/HH1uwnD9gTx8fO2hzLeQyoDoA1rX7FI9OJwEvkEYqXNsZ2Dp4qLssfBnWq9wYvjZdiAgGLaDHU+6mc+VIu7lOLaaoTwJwB3hxHDgzlw5t01d05mR1xvR7+6h5BA8q8NWRW3bap4aD2nv4ymMOAITn2WBXUl/IAGd7rDoxUMC1ciIoiyW9Elqly41vo1o25BiADKH2UAIZ7I4xe/NQiVFPXyHCqwcW7JPkLviZ6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9CPbq2VFzRHv6Uw4Caa68HIm8zBwr/+53SmEye/Dt8=;
 b=E2iprSP6rGbKUZZ8aaWD3mWDW4OrBayt0MNjM0YCsSEAgOHJBVSeLVlMtOIdcZ9KQ66D2aPFOoh0K+vRtE9gLqp3g9B5WzcWcq2cwEuE4sSvDn5E+h9j0uNhuFMF89NM94LRUFcapgDVQGykS2f8koKDUJkGKBC1NwteCgQAsqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB1773.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:38:38 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:38:37 +0000
Date: Fri, 22 May 2026 23:38:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] dmaengine: dw-edma-pcie: Add capability match data
Message-ID: <srutyo567gkhj6dll3yshohj4widw375whojfbgk3pdtcn4g3o@ruu3um44gz3h>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-6-den@valinux.co.jp>
 <ag8tmGfsYbWVi6NC@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag8tmGfsYbWVi6NC@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:405:2::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB1773:EE_
X-MS-Office365-Filtering-Correlation-Id: afb1f760-803a-4575-8fb2-08deb80fcefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|22082099003|56012099003|18002099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	n10eaMJK5Ui+wfEAq4u2z9fL0LLTQikRI7kB8n3Ty2ltuieRywg414P2YXFzcoMqJvq8Y1yqWIclB0K7BsrCM58YXvSQDecZyqKp66GCG13c0PpoNBKfAMCK71K//+A1oSZmX1oX6kzcuRzGH1h4mYgAcKKW24tnjCJ63tDCovUUwGlFn0TrwYGgvyPd5KoNSTLjUhoELTgFG2u98pyr0ZUXB9xA8K90SEazQr3bomTpmORH29WrJRowO/e4oHhPklRdsPRiw/QjqFOKuBGXwaZc9EM+pC6DoyWBH5IIohsZ/5HaWVEE1nh6rtPQcBxthvyGNyxVPqSVjAJs3uxISZ5uNqwk0vLm1esXOjI8i1v92dqx4uCn76yn/LcwKNnYSoeHNeYw2QHkndaiMIpP1Eh9Z+A1rkQnneD4jD/L23g8cyyhDtwgQCXAtJ+z7su4uOUJBoOVb0axPICLFJwsN2Jf46/77Ortu0XNuwUOIoctr1KFZnZ/G6VFBpqXgZf1FFEWpaIvjXAOJKoz2UuXVvKfDXTbsM5YR4IXkxFZ6Lj9vhQ8zDV9c55kECK/dihe4z1g8/cjTIWWR+sWsW6G8sTLcitWmbSUsM3a9/bodEIcO0Cj/Gp2cmB/b7CZOBmKSJsZbcRMejAIfmibewpD6dbJR0KD5//JoWYUtSwcE9ArvKgoEJIFoFkMUvPhE3rPe781G6O5x4c91CpWJMoErA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(56012099003)(18002099003)(3023799007)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M5hxXzjKnqPYaoRVNQ+6Tz9i5myMGiv1a48wJH9Lcrb+ZD/rapMS9JREokmX?=
 =?us-ascii?Q?RF36tMwg2WnbqUl6p3XKLVmMlZ3uTbRo5fxo4g+8UIWY3k+nPmywqfG9x8+A?=
 =?us-ascii?Q?GcDJQFUjvhnCLcQDrSHroZOGVN8EF8JTRJyOlBk1OXewBZm+Sul9oVJmMebp?=
 =?us-ascii?Q?E9UOfmCrBrUNfl00vDU/RsM6VuMgfobsdooS5gIZu7HOcaTxbAjyi7C+ifT+?=
 =?us-ascii?Q?E5Mzen22O+eaYks3c1jZH58xVph1bVZk+N8z90C4NFCvWruOm1oUEP1QXEUt?=
 =?us-ascii?Q?p6DBtubcsnCoxzs2ZpRVFKG6wE0KRQvXJ//lvc9D9mSUO3uFGqjdoFQJf2Hb?=
 =?us-ascii?Q?Lk/71oBA8CHOZAQF0iAfGyMHWSXEvMseOSwVxoaLBCp8/GIbRdrtB0HiyMCq?=
 =?us-ascii?Q?02C/Q1vV9ozzbl5oRjBCyyKjynwIBFQiMfOhaafzbVY3xi3NAlPmPw1uowf/?=
 =?us-ascii?Q?EBx7bNXijkt94t3TFV/3EZc7Rjbgrjb4UW411kIOLd8HucpIpn9dalaBcZka?=
 =?us-ascii?Q?W9kX7gbVWPg86jdmL1Uze/7/z3NOSBqSBba2BxzYQGFDkfDgizkfr9fQKIi0?=
 =?us-ascii?Q?/gzfMSSL82hOltTju0Xitw7Gz9awzj1f8cMtSpC738CvXGDSn+f4hltiQR39?=
 =?us-ascii?Q?A9SIzscGYsL3UfnEuqB7xgYQNwhb6z1h6QOpkDbEyP09RqS7Pd5MTbK8j3if?=
 =?us-ascii?Q?2NqH9vtMn5OVJX/HbsYtx7Skgj7/hLQbrLu1LSj4dq+6cBiTPcVuCaE88WRC?=
 =?us-ascii?Q?iPsBUOLYBY50WCtkEOjHyQFLFM8EJLF+aEjZ4bLrzbtxxXquEmYf5V67I2K7?=
 =?us-ascii?Q?xMgZiQbj+Ppkj1tq9MvGAlJvA7WQIkWwuwDLXqy/a33IQHBknL4eJ5xxrftr?=
 =?us-ascii?Q?ElgEQVA9F2Swk7/w/iCn8ss5DNWwfsR0MFTgBrRL3jrBJe+4BjBIw3lNEkPx?=
 =?us-ascii?Q?4DvhlNOubKI/OeW8/aSWl1xGlIzPzC+LiqQM4CsjmOTX4EKAxobz8qD8HI2k?=
 =?us-ascii?Q?VVZWZ+zPZjWuxhDIDZA2E6A0A3HijXlegrkiL/ufvnGFr7NsCRiL6HleV33F?=
 =?us-ascii?Q?mwpiCdF23ewt9eIHY/uUbFl2DdIntHxVpHHt9944bkaJ4Ozl2+UwJU/ZeZ7F?=
 =?us-ascii?Q?PoEEhhCtOPGDFPa1OaZHry3ma/IB6RVChd1PbkKt3Q2Ynd5hj1p0OlfEfZj2?=
 =?us-ascii?Q?i8w9+X78/jKInQsqWT+ay2q3qs31sReGmIAqrQWr4RrUQyM/Ht4lEbH20a3T?=
 =?us-ascii?Q?MoeBTvTPfRFA5ToLJEDIzJKj337p94DEyBhq0809mkQpoMVJp+KrmaS4ahfl?=
 =?us-ascii?Q?S2iNW+79u5hXKN4UNLzJsINJEmMh1q88RbQMf9t7OhSWwiatuXcqmvnfF4f6?=
 =?us-ascii?Q?qzSCjt5hv2duM6J6SNNfIr07eRmPv3M8e0OVIWusUSkDViuhBEIKn5F0hgHr?=
 =?us-ascii?Q?mO2VKTsYZE/tJXO3zLSUvOF2NZB7JXBS5isOo26OiLLkEzvhHOMRNtpr0h4E?=
 =?us-ascii?Q?9eL2VivEmCxIebKvmiH8Oa3tbmcinrIvcemIWdV1HIru4EISWbr2OD1NSzmJ?=
 =?us-ascii?Q?YC8AtMQc2orrZaDJodo12W35FyrY/DgLtkf+ClCcq/0K9v/kBoLGR1RU8ki/?=
 =?us-ascii?Q?o4+GuhdFGc696lOEpUh9E9EMOdTfBjnlxG/J8M0Nq8cDVEQ/9mj0Og0ErRtM?=
 =?us-ascii?Q?Fs2/S2ovIkD/dePPZCKIN49pLhaqFujuJG+X11DnVK1pi1cm308tJTVOai5g?=
 =?us-ascii?Q?LwbUkZn+0ljXuVL0Zdrgb3tDqp30ftHCvsdACd2UGWW1trxIhUl0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: afb1f760-803a-4575-8fb2-08deb80fcefc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:38:37.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4BRHX1NTonVCdLJ1uD5ZS/oB0WsBsT1H9PJd0kWzQzLcZDErYsk3s2PazbhJMwZy7U+tWSveGeiJRFRm5uoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1773
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10748-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 855585B6E8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:06:48PM -0400, Frank Li wrote:
> On Thu, May 21, 2026 at 03:31:08PM +0900, Koichiro Den wrote:
> > Move device-specific capability parsing behind per-device match data.
> >
> > The existing probe path mixes two decisions: which static template a PCI
> > ID uses, and which device-specific capability parser adjusts that
> > template. Split those decisions so device-specific discovery can be
> > added through match data instead of adding more vendor checks to
> > dw_edma_pcie_probe().
> >
> > No functional change is intended for the existing Synopsys EDDA and
> > AMD/Xilinx MDB matches. They still copy the same static template data and
> > run the same capability parsing logic before BAR mapping. The MDB entry
> > also keeps using endpoint memory physical addresses for descriptor
> > windows through a new match-data flag.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 127 +++++++++++++++++++----------
> >  1 file changed, 85 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 0b30ce138503..043a7f73bf79 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -74,6 +74,19 @@ struct dw_edma_pcie_data {
> >  	u64				devmem_phys_off;
> >  };
> >
> > +struct dw_edma_pcie_match_data {
> > +	const struct dw_edma_pcie_data *data;
> > +	/*
> > +	 * Mandatory callback. It may leave @pdata unchanged when the static
> > +	 * template already describes the device.
> > +	 */
> > +	int (*parse_caps)(struct pci_dev *pdev,
> > +			  struct dw_edma_pcie_data *pdata, bool *non_ll);
> 
> Needn't non_ll here. This information should be already save into
> dw_edma_chip::cfg_no_ll

The non_ll argument is used only to fill dw_edma_chip::cfg_non_ll later.

Do you mean that parse_caps() should not have a separate non_ll output
parameter, and that this should instead be kept in e.g. dw_edma_pcie_data?
That would make probe do:

  chip->cfg_non_ll = dma_data->cfg_non_ll;

and drop the local non_ll variable in dw_edma_pcie_probe().
If so, yes, I agree that would make the code a bit cleaner.

> 
> > +	unsigned long flags;
> > +};
> ...
> >
> > +static const struct dw_edma_pcie_match_data snps_edda_match_data = {
> > +	.data = &snps_edda_data,
> > +	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
> > +};
> > +
> > +static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
> > +	.data = &xilinx_mdb_data,
> > +	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
> > +	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
> > +};
> > +
> >  static const struct pci_device_id dw_edma_pcie_id_table[] = {
> > -	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > +	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_match_data) },
> >  	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > -	  (kernel_ulong_t)&xilinx_mdb_data },
> > +	  (kernel_ulong_t)&xilinx_mdb_match_data },
> 
> On going thread
> https://lore.kernel.org/linux-i3c/afmEo54iWgk54M3Y@monoceros/
> 
> .driver_data = (kernel_ulong_t)&xilinx_mdb_data;

Thanks for the pointer, I wasn't aware of that work. I'll use a named
initializer here.

Best regards,
Koichiro

> 
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > --
> > 2.51.0
> >

