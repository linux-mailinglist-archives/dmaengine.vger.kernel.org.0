Return-Path: <dmaengine+bounces-9132-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK85DNFpoGm+jQQAu9opvQ
	(envelope-from <dmaengine+bounces-9132-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 16:42:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F851A8F92
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 16:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A55A3144E3D
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DAC36212F;
	Thu, 26 Feb 2026 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OcQ0B2di"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73042475D0;
	Thu, 26 Feb 2026 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119303; cv=fail; b=QAK7xrZI/Hje5+htFLJ3EDBTyNalPwomehBEinZfb7HkFIiPwsK4MVdIfbAmRsybAlnyPcv0et67gazIvLr0VSas792zwW2aQoaK7oQFEf0P+5HoRSR2B2kmPm/LgAoQs0g8FwyEkWeZzIY2tDh9oAnJkf1X/cjqNnxMXOQ1o5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119303; c=relaxed/simple;
	bh=5HSvVyw5azhNm5RiN6xqiJ1dOJiYLsVPfXSCFoceHGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cu9ETP6JBNwzExptEhz0WpBl+i4Wf/xmRWQrHGyqSDLtPaaHHXjeUXSwylM8kUMQN4WX1LYUIdnsjEGEzz5cD0ixNVj72Q2nomKceLaoZqZ232Oz8ria7yGhsF5eROJkXohAOVxqpFTDGieep+Seqf87HZ7rulueuYG7hKYa/QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OcQ0B2di; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZIa0BnN6g5/1rZcXsN8C2KAMtiHsyueiirBG5mFsQlRg+Y0/vGkHroBplzhUEwzUxbQvTWo/p4ybIl8pkY8Sqzw+AEmocPE2ufZaVQOy54mzLFXys6l+rT4o/nnGtNSzpcFiQTogjbK/yzPJyudKb+DMBd0FQXruAPQGk8nygaEST1vQTiwUEuoXgjPzX/0vfGj+IR5dXOjJbJQJrSbXz6CgHEefPsAd/u23zb4soD9qiFZCJ/vZbAQOcIP4hg4gP45sGBaDUw+4zxVQAFx7ZzjGUKlboC/Ql4brj/9g5V0MPalvoBXtATNNTmx49cA9POZ94QIxu2TUAnPArCdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D/A7SW4Mwvx2UoSWSexKB4jtT0jW106esJ4ejlO7ms=;
 b=tv+Vk1RPuDYicVdcwLJpscqjj9zWy4cXe1FJ2wtU6yVhv7+ALMTgjRhPKS6Ap5jXJl3gt4q0hLlIw7r2xnbksLaFztOLeyUNixEUeYNh0e2BK3tWcxEjlg2rYXOuL3AItwn1mj07wMCdtHkyopXbzu5Aep86FP1yWgrf+skXsIZTZjEQfFQwx0ie9OBU+YqV+NL1IFeISNJL2Skf3KK8gVZHf9AqHsXQQUliUZTbOc2Ek+MwBQojHePeZnnsOxwxV2cKD27uzJHe1+mUdCUC1T7N8c9YqvW20ax6pjEBIMKsA3Y15dES2kDKVU6Dd+IB8Uvi0CUOd6rheXLfx+YN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D/A7SW4Mwvx2UoSWSexKB4jtT0jW106esJ4ejlO7ms=;
 b=OcQ0B2diIhLLpFpIrob/vHKrdWojLOE6yEVZkZvZMrHON5I16vyUobdBH4qDd5sdw+ToqvHaun/UFHKwc1vXyK3qJuz68QWqtBqpBrS8gfuf182WxiS6chEYuKGXeXfWSwVAh86Z/dVtRPETkOUQz9M6mUT2ev1ezVEkv78F/PZpE9cIA5QVKCZxKZNJ+wsD9Wy4uz70ePbjR4T9ow7xVJL1RA29XBLZ82WbJGpQyVaUQ6RmeyxfrSCXh5zwt/TQzeCRylGm5IYMm0wJBtiGb8AnAsuVgPYRaf7HXB6sz2l0K1eT0cGsTlM0bAZ6igO7tbrXUDcdyltjxuzHlYUxQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11263.eurprd04.prod.outlook.com (2603:10a6:102:4eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 15:21:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 15:21:36 +0000
Date: Thu, 26 Feb 2026 10:21:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 04/11] dmaengine: dw-edma: Remove ll_max = -1 in
 dw_edma_channel_setup()
Message-ID: <aaBk-I5jrut5wpT7@lizhi-Precision-Tower-5810>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-4-5c0b27b2c664@nxp.com>
 <6d6c222faypvbo6fvs7tad2gtzxqqzlsjkrbefwmgxodt5thbc@lylpaqxozrg7>
 <aZ8YpKPqSjzDtomb@lizhi-Precision-Tower-5810>
 <esdpmy46hffpg577hd67rxmpkfm3agrzrginegi2rczbwvdnlb@urqmwhh3kuff>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <esdpmy46hffpg577hd67rxmpkfm3agrzrginegi2rczbwvdnlb@urqmwhh3kuff>
X-ClientProxiedBy: PH8P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11263:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7c4e8d-50a5-4e8c-c5b2-08de754abb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	deP5GJtsG6nvgAFFHO4mvui2q7Z8rR31I7q82K4xf3SSYRVSrHRlDWS2aQfxHMz+Prv1xwQg1u7OIwIl/67h2waiyowvF7z1rSjx1gDHCbPYMHZzr0edOfMKqUv6IrB/8v0bKbE+GT0wGVdAY8IB5G+TR++yk7BEUiQC2du0EjqatoGW603AuYyzbx3811l9+/E1Xggk/Xtx6fF8DThqRaWbdmV/9OBlLHcYE0kZybuYk1ue8IcNCwwCPFxRSOFOK7th1CmLoI0KPWbxejRctuREfGQpT/+VovdYQuOsG44QFcJ3YZk/mcTMTEFTt5wb528JauxeRDzPjt9EYpaHz7tksIYOwUUFIkZ+XQmVs2v+OOIlnjr6ZR6ZXaAQBs4SvcBZmPvOb1samypWZrC0Gn6/LWQDa/VVPvFqY+5DlKrchTztMP+7eoOPVwS6o6zQTysu0SEFSfGm+PQJI5K0yHH7G9Z7OM6vtiOskfj+gCj+96BRkvAUUDl9/iPH3szahOpsmONq7TJ8AUxJ/K0gj9rJYDJtMZ2mmi8R1zDidPTIpsx3CcugRBIhMoGqqnyGpPARMZd35sMpq4wipgZ9tGtqtp0iCIBXyN9ojcj9iTDJ5L9DWB77vDmgz1OAlihlDwV/dhNntHRZx7aiIuOKl7k8wW0aKA6id14IApTro24qk4O9U4qf721i01aoPQPKpmapm+RUdIjXRAEXv4tmbI9VMCPXuw2NbPD96BXIFeFwXV0cqgDexnlEh/1pYaJEBo5+kxB8xCiqtoMOu1p5YD278pdw08CIRmM605XYbSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XkS7+JD4DOKY22lyF2q5maJGR7IU4j2YnUfXw+FKc+XWx05b2VX074VZ+TRx?=
 =?us-ascii?Q?H5IyaYC+8PaCNb+Q9/L1cvLNAq6jdjmmHa8awLWmC9qoXPK/n6xmOFPHznUR?=
 =?us-ascii?Q?UqgvAmOaH9kgWoJFTr5mvtZFM1/gxrvcJu+emCuShYWwUpzEEfd1kZatCaWy?=
 =?us-ascii?Q?rg0W1KOQRNrneVLGphorT0T/fuSZi9LAycsmgPzoz1NVsueghfO0zxeG6CMe?=
 =?us-ascii?Q?YG1LkhSZt/NjScEicRZB1bjYX3ShQkgIh1mhi8FrqARCzdBNYqO/B/M/egOS?=
 =?us-ascii?Q?fGD57q1C+VCiYlsc3nv/En8WZxS898pOGQc5ABeymd6zuv/E+WY3yWsyc3IJ?=
 =?us-ascii?Q?pMvmF/D2HaJJmewVV3zd9Z4wu3gHrQWGBt+3Vn3zycvTifMtFTDIi0qg7h89?=
 =?us-ascii?Q?eZ4em//6as/e44rkdHe1o9UnV3G8F/I5zA+VhmDo6D/rFeU/4vpkxyUolBfp?=
 =?us-ascii?Q?tbdfynjP+r6Dw7l/cpWVr0NzH9ZIMmJ+OYrL2SFBAWd4dqNfdChGi/f4Hgtu?=
 =?us-ascii?Q?gQl9qMvfP7UcXllrrZam94zC3BGmzKWI67HVum9NaBJLcJRbOTcDpNdnFrLw?=
 =?us-ascii?Q?83mP2cp/AMoAHw/DbJXl0yJTjd2P99rdvVcYIEf5bxmTMYZIqJFz8W2B74g2?=
 =?us-ascii?Q?1iLgw5ioq4z4E8UMOp9NBXnRM4XnyieL9d/0xVk1n0Lw6R9qQNmlnZGxAc3A?=
 =?us-ascii?Q?wFp36FmwuWixrj6jF0Ik+iybDlQFG11uKikCRXgwm+XK2By/rBTDffk0ej1I?=
 =?us-ascii?Q?X1f60ole5S1uE79nWmeNb+G4qO7H7RlPb0pack31rKS7worNh26ePxUHJZHK?=
 =?us-ascii?Q?c4sYmfQDr1hpB+xK/SueYEVgHMphafn32knsGGUWtUjQvAuY7SQdZUwshMPC?=
 =?us-ascii?Q?D6j46/aCIX8aCLA1xdVIZGSMv6xYbQyqJ6Y964IgZMBFuP5oWyhRiVz7rLaN?=
 =?us-ascii?Q?iYg+DEK82wmU5MplLUBdIP9/yzeyGolVembeumX3QaoIAK7grNrBUlMT1yNY?=
 =?us-ascii?Q?3DtBeUEBT2OlTx3qjVH0Hs8Yo9CUkDi3kxBElDnLLvsC8W9R4aby0lrQCsSA?=
 =?us-ascii?Q?5yzbhIaC8ao5xGf3EdJqGP1Sw3SUYEFDgeF0octbSxPqGiBY4aC4lR9c/X0z?=
 =?us-ascii?Q?oj8HW1TFmc2bdlLYzngC/UdPRdB24WKt9bSYgJGL8382kkjUsywVyBGjsRRx?=
 =?us-ascii?Q?ntxU4dyPL9u84+D28HTh3ofhIpiJi0HhEmItN5mkJOI7JZwCxMJppY4gNIdU?=
 =?us-ascii?Q?wvCusBEzH6MkY8BZ8H44BEvhmSgh3TKEDvZU7nXz2SEjheVF8QH1vvnAS0RV?=
 =?us-ascii?Q?+euVFXlQF05NFoO01otw9jNscOQcAV9vIG6yXCUsxnqSLrPya6CXHkMr1qTc?=
 =?us-ascii?Q?pafWqgqRtexVWN+GjGDFWMpwJUGtYN/ziYE79F37PjAf0huXo9QRQPSfek4B?=
 =?us-ascii?Q?a3XWnZrYeSaPPCTZK3xvtPU0aEwIVQb+9ub1vFJG9NzSgyOy0MJ+E42im5Cj?=
 =?us-ascii?Q?X620Enace73tluhkJjNGx5V0K4hgXEAog2Gu4G85P1ycBn9tT65QXg5ZcM/L?=
 =?us-ascii?Q?ZvLTaYtMYhDalYccW2WMvIX1FpGRwZ5jHweouGow95Pz70tOi27nd0WFM74P?=
 =?us-ascii?Q?yrbCVB2CB44knV0DOIPObV5ZRzSBlHsK6H40oYOylbRTLUwVxd9tb+yC6sxc?=
 =?us-ascii?Q?IvsE86/jQERpTjmDz/TyofX+ktHNl5vAwV18ZP4DK9hQVcOs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7c4e8d-50a5-4e8c-c5b2-08de754abb58
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:21:36.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dB6QmJekq7ZyiuXpXIGh+k0Kqytzk66AoKzUbyZfhVLmF5+LuHBRhszPV21UnrSEfdNCa6LEg3q39diNLYe1pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11263
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9132-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 60F851A8F92
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:16:26AM +0900, Koichiro Den wrote:
> On Wed, Feb 25, 2026 at 10:43:32AM -0500, Frank Li wrote:
> > On Wed, Feb 25, 2026 at 05:30:33PM +0900, Koichiro Den wrote:
> > > On Fri, Jan 09, 2026 at 10:28:24AM -0500, Frank Li wrote:
> > > > dw_edma_channel_setup() calculates ll_max based on the size of the
> > > > ll_region, but the value is later overwritten with -1, preventing the
> > > > code from ever reaching the calculated ll_max.
> > > >
> > > > Typically ll_max is around 170 for a 4 KB page and four DMA R/W channels.
> > > > It is uncommon for a single DMA request to reach this limit, so the issue
> > > > has not been observed in practice. However, if it occurs, the driver may
> > > > overwrite adjacent memory before reporting an error.
> > > >
> > > > Remove the incorrect assignment so the calculated ll_max is honored
> > > >
> > > > Fixes: 31fb8c1ff962d ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-core.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index c6b014949afe82f10362711fc8a956fe60a72835..b154bdd7f2897d9a28df698a425afc1b1c93698b 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -770,7 +770,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > > >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > > >  		else
> > > >  			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
> > > > -		chan->ll_max -= 1;
> > >
> > > Just curious: wasn't this to reserve one slot for the final link element?
> >
> > when calculate avaible entry, always use chan-ll_max -1.  ll_max indicate
> > memory size, final link element actually occupted a space.
>
> After the entire series is applied (esp. [PATCH v2 10/11] + [PATCH v2 11/11]),
> yes, that makes sense to me. My concern was that before the semantics of
> "ll_max" changes, this "-1" was required. In other words, this seemed to me not
> a fix but a preparatory patch. Please correct me if I'm misunderstainding.

Thanks, I found I make mistake, wrong think it as "chan->ll_max = -1".
I will squash this change to patch 10.

Frank

>
> Thanks,
> Koichiro
>
> >
> > Frank
> > >
> > > Best regards,
> > > Koichiro
> > >
> > > >
> > > >  		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
> > > >  			 str_write_read(chan->dir == EDMA_DIR_WRITE),
> > > >
> > > > --
> > > > 2.34.1
> > > >

