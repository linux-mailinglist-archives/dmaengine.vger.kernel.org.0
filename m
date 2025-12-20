Return-Path: <dmaengine+bounces-7853-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A342ACD3260
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 16:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 644A23010FF9
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699C7272E63;
	Sat, 20 Dec 2025 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wna5nAf1"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011028.outbound.protection.outlook.com [52.101.125.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31267FBA2;
	Sat, 20 Dec 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766245446; cv=fail; b=DZXeIhMbWhfe56ywUxW2S03zuM2wa+OozrgCWhraLIBcXi1FtS4YFGGJs80jEU/cG0c3Ob20FqVlCu+VygkCFmdWe997Z3vjYfLe5D+EeuWK2UBUfHEofRQDwliVZYLmuQi0mhSgRukQyqQCVSdoK+cRXRz8MSY5if4dbbr/Djk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766245446; c=relaxed/simple;
	bh=EY1GHvJj5GrT/lt9z5Tlz5mQYAJy1IwY6KCHbBxO9gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hGiR+qnQgzwlUTMPnPRl78827/UeQXEkV5zBI8ATFdoXVzOmM5MZ9hHUtjdWoFjT8fKZDFbYDg+GBcAy+r2j9mQRoHZamLQ7i2Q2MICtUxh3FDbX3Y9r4PafStTaDO9isfQ58TmCz8Afh4TXQ9W6WAdiyffQ/LfH97qq/+obQVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wna5nAf1; arc=fail smtp.client-ip=52.101.125.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBh8SP8kwAXHffzZTjUloI5HdAZ/Z3DCth+sGdKWPQAeqW+tU1FzlqWiu1nTNuxiMY4MKUBBy7BDTXH0jLI/4xPIuV84iDhT5RpDGz5QxksZvYc/oXdMtgDy1j3ydOq901AImp0CGtNSU25K3pCWTzevmQZQE63muTLkFeueuKGnenZ/Dz5TKlb5qpC5qEfJCo7r2WAGtjRiihAOUCJIDO4FuewwkaQny1wARgD1qYzKEoqnVGR0mb55alA1fKRq0Iv3IezQNP8T3FoygxANoUCi3PBtlWZ+v5jv6PjWf2+vzy79JW/oW6XS+RKY268uwvsoF+ZuuN6JXw6kQM6VrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCoPMmK+6nGrbk5fdth9Gqy8wbXF/sTCrO79kL2ZHh8=;
 b=q7K1+Rr+NlcvRXcV1XRrgitzDW2nHLFr7b1RUWyxEwbJxl/72nAFVhgjG/IQVxWwjgFg1KAk/B6uq58UkI8y/L/2ENk4IENQc20srhulYW1CRmXDoliUbZK252qAFzox5nLz7WWdqD21sC7Z4qupl9S0s7Sl1RcBmP+BxmWKkYnGhQ07bDVL4z24KN6GQFTpHmC5Wo8tGCrI91TLvbmanPye3cMVhuWgAkLhcQNakllD9vmxY3g81eLPcCGffiZ2wlMj6QfN0QLxOQaq2CilCjNu6+H4xTIv78UuKWM1PX87JfgmR300A0fsAUpO0CQ9FmcrJ4f2vKZ1yru6UcWUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCoPMmK+6nGrbk5fdth9Gqy8wbXF/sTCrO79kL2ZHh8=;
 b=wna5nAf1HWS0H2EbtVrBnf0N4AOsujnDR0zleatGYOpVf0kiWu537TyVY+b0r51JHjXGi6C7gsr8SHET/2lVMNjCMKxg8FplHTitwX+kdvYeQG5SuVsho8nvlzLIf88wpa517Ml+m/iZnDas1kDFCABfbtMVjhD7EM6zD/7Vzk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 15:44:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c%7]) with mapi id 15.20.9434.001; Sat, 20 Dec 2025
 15:44:01 +0000
Date: Sun, 21 Dec 2025 00:44:00 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be, magnus.damm@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us, 
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com, 
	jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 00/35] NTB transport backed by endpoint DW eDMA
Message-ID: <vnbx7mbz5v6cdcfacj45pfqlqckqrpe7nwl63u63udvqnfkcxy@sfgjk75gdmlw>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <aUVrS/R+DM30UEhC@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUVrS/R+DM30UEhC@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4PR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:405:378::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2742:EE_
X-MS-Office365-Filtering-Correlation-Id: 772e6717-29c6-4c6c-8f78-08de3fde98f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MrriMCYT0Iokt/nPmQvVvUDaJbfWmW8ALncuPQrDXzwgrBkDHfUjyQi0yd3W?=
 =?us-ascii?Q?+ZdKkZbqz9JGPhyZuz+IR7+K7vxqaU4v8NshmWYapW4H/OvY74xaz3UvvV/8?=
 =?us-ascii?Q?9cfFhdJnhZfr28l/fFDNR9YTqMQTgxCUdPhF09+2uUW4Aca5j4GZG4/IVI0j?=
 =?us-ascii?Q?H+Bi7rIl2mloBFCWslbrGvuLnFH8LuV90Og+6vWZM6pXqcQ8bUOYNDcXyjxe?=
 =?us-ascii?Q?KfeQfNkGoMDyhA5ZLuB0XoHupwicjQ44ACVSIbpmitN+JwMHtQsj0up7aWOj?=
 =?us-ascii?Q?AcqmbQUziDsfLkNkWrulTNPuYSJFuptSnkJBNAn7mb53JnjIPJytEafXnkMo?=
 =?us-ascii?Q?+tUweeFh2Xu5pPC8y27ujZLdJ3nNitXO3Ry1zo+krmXs8xAkWB3bpeSsfnxv?=
 =?us-ascii?Q?y/X1Dr8qG/2iBlBYvR2FNHLHYuLmM91BXvIKjCd2QmLz97hfGKZ3zezdu6Ys?=
 =?us-ascii?Q?Y2eInQl4WiTqBNAjbnbAp2xlgzCe5jxya7AL8gjakyULqG9FFYLFiK87kaE0?=
 =?us-ascii?Q?wZOS+Da+vcWoz7sseVgqLOAZIW667gLR+5e9K+iht9Xk1UJknEwujBYYW6bo?=
 =?us-ascii?Q?eIHeddw5gIyJwfIFBj7Oqq9GYVoKtJga8H6i1kZHGLXebUyeATf9dY5LEKME?=
 =?us-ascii?Q?mu+B5dP2YObiKdqEv/J1PJc1CUZtF8SAKViBB9QWd/6ZWuv6keoIc1xSEsYz?=
 =?us-ascii?Q?+Lngmc6gHetxsRGnllX5crhLq/kpqy5UVo7HAXGwZp9/D64QdSwMg0tZdFF2?=
 =?us-ascii?Q?R6TSrQUnc77vZEmXE/NDP2zDz4HkwCCWRzX+0MPVxKqn26XK348DRqsiphhK?=
 =?us-ascii?Q?AQzOojQj67j6GqgSITz9WxV0CW5Fu7JLUoGGtoipzqO60qt8lLML0HSVGhzw?=
 =?us-ascii?Q?Kd9KbPnbnVdPkcGYqpsHeQzp/RE/vsq5OHSljtELCfnuLdl3GfBjRdb13oOT?=
 =?us-ascii?Q?Vl8jfMwNt+VFsQcWQfrCBGtl7fBrlp1fmC6onJ9jrg1udgRJXErlsO1ym+6Q?=
 =?us-ascii?Q?RSSnEr61iWLeIlIOKSwP6ptmhh4Smjrmw+8BcpcQ38gexkyKuAKQaiCMNJLd?=
 =?us-ascii?Q?fkF4NGVeWySgYqkdzu7uwP8UavkIwrHt7bBDoKSH//vTyysPqGEF9JgxL+j1?=
 =?us-ascii?Q?UyImmC+tRDrYk2NaYF/tl2rA6C8yINBC8RpCw9c8YetGJZy7BCLpp/Aq0bfr?=
 =?us-ascii?Q?YPO5NoQLE+vhf4IRZPRgzgAsLt5J3nFpkpK5qVMM5pJf0TXDkjxKBnFt6AaE?=
 =?us-ascii?Q?tEhYwOeIdgPPxJ5NB1Y+GL4aJV1i8OSz5bIakANBHZdo5LOHc/36fb+5OvC3?=
 =?us-ascii?Q?s/wX8tfWnNEgDmiTncTfXDk2wzKsHSSO8IjaIcjoSrbShWzRdNadR0Up/gsy?=
 =?us-ascii?Q?0rGZVAm0Xl+dm/WoP2OPKJs2lWruQ9zLh02j8cnPXsyoHILL6UP+MQgNwOBI?=
 =?us-ascii?Q?0ExjaLXpcZ4giatRxiF+3RZy+WZtOkVx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19L4/eaxAnnqm4aOzOHTG4ZCqOwtAe7KzxmFeutdIQzNc41F68PRkciG24sk?=
 =?us-ascii?Q?nwXBvVHR4wJfQn2nX5+tK7e3jlUn8e2Az02rZMiO3rk9KKP5YSBNVSolEQv7?=
 =?us-ascii?Q?kKJ7mxGFglfuRBtGWoTO2ILk/ERehO7keKn9+78LD+429pl81LExntWWIUHK?=
 =?us-ascii?Q?aOktXDp+60/LE2/gq+Q825BvE2H1fMx/wWkAAEVp3kdYsKS18m9U8kSm5OjO?=
 =?us-ascii?Q?9IP3v+MOvKw0vlZl3asGgf1rFLqlkHJzeLKCPCWLsSdGBMQJRdhSovqheAP/?=
 =?us-ascii?Q?/V7isaPlUah0BiaQswaa0eixh8wxLl0yaba8kNo7UOFjHqwSJc4rDki7LTk5?=
 =?us-ascii?Q?tSVMSXkkwZa0yzTCUee+Z52keo3pGnN4LbHKE+rBrUnrwKo1jjPJyEUWUw3N?=
 =?us-ascii?Q?qyOAcpB6jky5aqCTS9U8Un2lxzfxs7mA29VqW+Ery12U8yeQpxhuuA1OC9w2?=
 =?us-ascii?Q?6h9RSdAFzWaGobHbCNeRDo2BNqDe8NzHELhtkPV4NLTkfN+CEOmS6njtyC+r?=
 =?us-ascii?Q?xVmRRs7mzbJnXbCqo6pUVRE0VySoSx7ddcwXI7coJ4nQkhlOqdTFqPoVlnWZ?=
 =?us-ascii?Q?iqOr6DqCsqMDphp80lhEgKMncRtIzKTMdQkTp+6G8PRTzNn0lCAZuW3L4B6p?=
 =?us-ascii?Q?PDinxidh2GOSySBvCg2nlCFF6Ixm0e6QXRBobisvP1Hhp2zcKrxKTE5dFRRg?=
 =?us-ascii?Q?3ec3Z5IEnrxgDwrtuoewH0wFUYvVIO9JVw0Vcp9Zq2eCyabaZfVnLLXVt21C?=
 =?us-ascii?Q?1+3NgtT0lfT+NDy4iRD+hhFBa6sMz5rB9pi8oDEnYMaKGTnUHHw5X+gT5pCt?=
 =?us-ascii?Q?XpA9cWxTga4BpqsJRwkzmkB4D37+LqjxwRuR4jhNAt50Pi0ByRat8qd9nCOw?=
 =?us-ascii?Q?IEaQO9uvOfeac5yQpPEXoZBy7slnx2LUrwV5VcEgFaGjzGkKoNfj4BDyIVzB?=
 =?us-ascii?Q?FPA64hffuAC6UrDE5u10+2he4yxrt0yyQRMV7C42m4wKnu1fP+/YQDRkXC3U?=
 =?us-ascii?Q?KvulfiFDeK31h4dFRLKHXmBEchWpJ7k591HCTC7JVUGA5gyHrFclE2Xsk0Rd?=
 =?us-ascii?Q?ZcYQR3/uafHoZqtM3diaJy3cgscLxlUwkQsUPkZBKi6peL6LSeyb4Glmr9x+?=
 =?us-ascii?Q?pzxRUWeCue/yIXefPkOyCWIM3ViL3byZehYQ5pkZOntF/iISuHMDMmln0WLD?=
 =?us-ascii?Q?uojZHwa6v45x76fMoVHvBB9hTqn7TzUp5svEYIeznruS7eP7jDa7HQZmVuQh?=
 =?us-ascii?Q?Lcl6ax1X0oO8Z+YVNbWF/ExYn+qduv3iWpso86/4E0MP1TlH+xM4GVvXEixw?=
 =?us-ascii?Q?+CX0Gm30iEuh+wY+aTeeBmu5it+zq649ZnghloCj5OLWZBLrv0R9EZ22iDnu?=
 =?us-ascii?Q?cpoIEKsTUdKn+Uh9BWP/fWtmfMb57kuWuJPsyfiMWg/4ioFpBht//aLBYtsR?=
 =?us-ascii?Q?VwMxWhDR0U3msqqRerWsG84z47RZs1Kor2Gb8XfTfLm9ELijfHFm0eyh7Mvo?=
 =?us-ascii?Q?obNCTdiskR15ejevLDsw2qkDEWYYZXl7X/IMKVWNMM53U64ku/I65r0/Y35q?=
 =?us-ascii?Q?+VqR8InqmUPAlRSm0N6cfX8IeEkZ98a5ACx3ix6Qci/mniIaPP/ps4iJLDHX?=
 =?us-ascii?Q?m6h/c+EADzN7leL15XycEtgSiUHDNLtiKg3LNeYy4RHR0u9Qesx89zLdWQgD?=
 =?us-ascii?Q?pY2dsTh7KxsfbD3VZ35Kt/E91B1+z5iKhr8WfzcmqA8guNEQJKVpkW3o0ggv?=
 =?us-ascii?Q?v/SfEpKlVEnd+Xg/2DBSTEZlo83yp8TpsBe4w/BHLJqjfLsxHa7B?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 772e6717-29c6-4c6c-8f78-08de3fde98f8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 15:44:01.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnSPSo1MIGTje6NyBAyJRVfw763PyMmX27GRJbs/mPNgQVPh1ZQbZWdiMTqxfPgZpZQEZl+MidPHiY0mRBC8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2742

On Fri, Dec 19, 2025 at 10:12:11AM -0500, Frank Li wrote:
> On Thu, Dec 18, 2025 at 12:15:34AM +0900, Koichiro Den wrote:
> > Hi,
> >
> > This is RFC v3 of the NTB/PCI series that introduces NTB transport backed
> > by DesignWare PCIe integrated eDMA.
> >
> >   RFC v2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
> >   RFC v1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/
> >
> > The goal is to improve performance between a host and an endpoint over
> > ntb_transport (typically with ntb_netdev on top). On R-Car S4, preliminary
> > iperf3 results show 10~20x throughput improvement. Latency improvements are
> > also observed.
> 
> Great!
> 
> >
> > In this approach, payload is transferred by DMA directly between host and
> > endpoint address spaces, and the NTB Memory Window is primarily used as a
> > control/metadata window (and to expose the eDMA register/LL regions).
> > Compared to the memcpy-based transport, this avoids extra copies and
> > enables deeper rings and scales out to multiple queue pairs.
> >
> > Compared to RFC v2, data plane works in a symmetric manner in both
> > directions (host-to-endpoint and endpoint-to-host). The host side drives
> > remote read channels for its TX transfer while the endpoint drives local
> > write channels.
> >
> > Again, I recognize that this is quite a large series. Sorry for the volume,
> > but for the RFC stage I believe presenting the full picture in a single set
> > helps with reviewing the overall architecture (Of course detail feedback
> > would be appreciated as well). Once the direction is agreed, I will respin
> > it split by subsystem and topic.
> >
> > Many thanks for all the reviews and feedback from multiple perspectives.
> 
> In next two weeks, it is holiday, I have not much time to review this long
> thread. I glace for over all.
> 
> You can do some prepare work to speed up this great work's upstream.
> 
> Split prepare work for ntb change to new thread.
> Split fix/code cleanup to new thread.
> 
> Beside some simple clean up,
> - you start iatu for address mode match support first.
> - eDMA some change, such as export reg base and LL region to support
> remote DMA mode.  (you can add it to pci-epf-test.c to do base test).

Thank you for the review and for the guidance.

As suggested, I'll start preparing smaller, focused patchsets per
subsystem, dropping RFC tag. Honestly I still haven't prepared anything for
pci-epf-test.c addition yet, I'll start working on that first.

Have a nice holiday,
Koichiro

> 
> Frank
> >
> >
> > Data flow overview
> > ==================
> >
> >     Figure 1. RC->EP traffic via ntb_netdev+ntb_transport
> >                      backed by Remote eDMA
> >
> >           EP                                   RC
> >        phys addr                            phys addr
> >          space                                space
> >           +-+                                  +-+
> >           | |                                  | |
> >           | |                ||                | |
> >           +-+-----.          ||                | |
> >  EDMA REG | |      \    [A]  ||                | |
> >           +-+----.  '---+-+  ||                | |
> >           | |     \     | |<---------[0-a]----------
> >           +-+-----------| |<----------[2]----------.
> >   EDMA LL | |           | |  ||                | | :
> >           | |           | |  ||                | | :
> >           +-+-----------+-+  ||  [B]           | | :
> >           | |                ||  ++            | | :
> >        ---------[0-b]----------->||----------------'
> >           | |            ++  ||  ||            | |
> >           | |            ||  ||  ++            | |
> >           | |            ||<----------[4]-----------
> >           | |            ++  ||                | |
> >           | |           [C]  ||                | |
> >        .--|#|<------------------------[3]------|#|<-.
> >        :  |#|                ||                |#|  :
> >       [5] | |                ||                | | [1]
> >        :  | |                ||                | |  :
> >        '->|#|                                  |#|--'
> >           |#|                                  |#|
> >           | |                                  | |
> >
> >
> >     Figure 2. EP->RC traffic via ntb_netdev+ntb_transport
> >                      backed by EP-Local eDMA
> >
> >           EP                                   RC
> >        phys addr                            phys addr
> >          space                                space
> >           +-+                                  +-+
> >           | |                                  | |
> >           | |                ||                | |
> >           +-+                ||                | |
> >  EDMA REG | |                ||                | |
> >           +-+                ||                | |
> > ^         | |                ||                | |
> > :         +-+                ||                | |
> > : EDMA LL | |                ||                | |
> > :         | |                ||                | |
> > :         +-+                ||  [C]           | |
> > :         | |                ||  ++            | |
> > :      -----------[4]----------->||            | |
> > :         | |            ++  ||  ||            | |
> > :         | |            ||  ||  ++            | |
> > '----------------[2]-----||<--------[0-b]-----------
> >           | |            ++  ||                | |
> >           | |           [B]  ||                | |
> >        .->|#|--------[3]---------------------->|#|--.
> >        :  |#|                ||                |#|  :
> >       [1] | |                ||                | | [5]
> >        :  | |                ||                | |  :
> >        '--|#|                                  |#|<-'
> >           |#|                                  |#|
> >           | |                                  | |
> >
> >
> >       0-a. configure Remote eDMA
> >       0-b. DMA-map and produce DAR
> >       1.   memcpy while building skb in ntb_netdev case
> >       2.   consume DAR, DMA-map SAR and kick DMA read transfer
> >       3.   DMA transfer
> >       4.   consume (commit)
> >       5.   memcpy to application side
> >
> >       [A]: MemoryWindow that aggregates eDMA regs and LL.
> >            IB iATU translations (Address Match Mode).
> >       [B]: Control plane ring buffer (for "produce")
> >       [C]: Control plane ring buffer (for "consume")
> >
> >   Note:
> >     - Figure 1 is unchanged from RFC v2.
> >     - Figure 2 differs from the one depicted in RFC v2 cover letter.
> >
> >
> > Changes since RFC v2
> > ====================
> >
> > RFCv2->RFCv3 changes:
> >   - Architecture
> >     - Have EP side use its local write channels, while leaving RC side to
> >       use remote read channels.
> >     - Abstraction/HW-specific stuff encapsulation improved.
> >   - Added control/config region versioning for the vNTB/EPF control region
> >     so that mismatched RC/EP kernels fail early instead of silently using an
> >     incompatible layout.
> >   - Reworked BAR subrange / multi-region mapping support:
> >     - Dropped the v2 approach that added new inbound mapping ops in the EPC
> >       core.
> >     - Introduced `struct pci_epf_bar.submap` and extended DesignWare EP to
> >       support BAR subrange inbound mapping via Address Match Mode IB iATU.
> >     - pci-epf-vntb now provides a subrange mapping hint to the EPC driver
> >       when offsets are used.
> >   - Changed .get_pci_epc() to .get_private_data()
> >   - Dropped two commits from RFC v2 that should be submitted separately:
> >     (1) ntb_transport debugfs seq_file conversion
> >     (2) DWC EP outbound iATU MSI mapping/cache fix (will be re-posted separately)
> >   - Added documentation updates.
> >   - Addressed assorted review nits from the RFC v2 thread (naming/structure).
> >
> > RFCv1->RFCv2 changes:
> >   - Architecture
> >     - Drop the generic interrupt backend + DW eDMA test-interrupt backend
> >       approach and instead adopt the remote eDMA-backed ntb_transport mode
> >       proposed by Frank Li. The BAR-sharing / mwN_offset / inbound
> >       mapping (Address Match Mode) infrastructure from RFC v1 is largely
> >       kept, with only minor refinements and code motion where necessary
> >       to fit the new transport-mode design.
> >   - For Patch 01
> >     - Rework the array_index_nospec() conversion to address review
> >       comments on "[RFC PATCH 01/25]".
> >
> > RFCv2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
> > RFCv1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/
> >
> >
> > Patch layout
> > ============
> >
> >   Patch 01-25 : preparation for Patch 26
> >                 - 01-07: support multiple MWs in a BAR
> > 		- 08-25: other misc preparations
> >   Patch 26    : main and most important patch, adds eDMA-backed transport
> >   Patch 27-28 : multi-queue use, thanks to the remote eDMA, performance
> >                 scales
> >   Patch 29-33 : handle several SoC-specific issues so that remote eDMA
> >                 mode ntb_transport works on R-Car S4
> >   Patch 34-35 : kernel doc updates
> >
> >
> > Tested on
> > =========
> >
> > * 2x Renesas R-Car S4 Spider (RC<->EP connected with OcuLink cable)
> > * Kernel base: next-20251216 + [1] + [2] + [3]
> >
> >   [1]: https://lore.kernel.org/all/20251210071358.2267494-2-cassel@kernel.org/
> >        (this is a spin-out patch from
> >         https://lore.kernel.org/linux-pci/20251129160405.2568284-20-den@valinux.co.jp/)
> >   [2]: https://lore.kernel.org/all/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com/
> >        (while it appears to still be under active discussion)
> >   [3]: https://lore.kernel.org/all/20251217081955.3137163-1-den@valinux.co.jp/
> >        (this is a spin-out patch from
> >         https://lore.kernel.org/all/20251129160405.2568284-14-den@valinux.co.jp/)
> >
> >
> > Performance measurement
> > =======================
> >
> > No serious measurements yet, because:
> >   * For "before the change", even use_dma/use_msi does not work on the
> >     upstream kernel unless we apply some patches for R-Car S4. With some
> >     unmerged patch series I had posted earlier (but superseded by this RFC
> >     attempt), it was observed that we can achieve about 7 Gbps for the
> >     RC->EP direction. Pure upstream kernel can achieve around 500 Mbps
> >     though.
> >   * For "after the change", measurements are not mature because this
> >     RFC v3 patch series is not yet performance-optimized at this stage.
> >
> > Here are the rough measurements showing the achievable performance on
> > the R-Car S4:
> >
> > - Before this change:
> >
> >   * ping
> >     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.3 ms
> >     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.58 ms
> >     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.26 ms
> >     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=7.43 ms
> >     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.39 ms
> >     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=7.38 ms
> >     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=1.42 ms
> >     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=7.41 ms
> >
> >   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 2`)
> >     [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
> >     [  5]   0.00-10.01  sec   344 MBytes   288 Mbits/sec  3.483 ms  51/5555 (0.92%)  receiver
> >     [  6]   0.00-10.01  sec   342 MBytes   287 Mbits/sec  3.814 ms  38/5517 (0.69%)  receiver
> >     [SUM]   0.00-10.01  sec   686 MBytes   575 Mbits/sec  3.648 ms  89/11072 (0.8%)  receiver
> >
> >   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 2`)
> >     [  5]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  3.164 ms  390/5731 (6.8%)  receiver
> >     [  6]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  2.416 ms  396/5741 (6.9%)  receiver
> >     [SUM]   0.00-10.03  sec   667 MBytes   558 Mbits/sec  2.790 ms  786/11472 (6.9%)  receiver
> >
> >     Note: with `-P 2`, the best total bitrate (receiver side) was achieved.
> >
> > - After this change (use_remote_edma=1):
> >
> >   * ping
> >     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.42 ms
> >     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=1.38 ms
> >     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.21 ms
> >     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=1.02 ms
> >     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.06 ms
> >     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.995 ms
> >     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.964 ms
> >     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=1.49 ms
> >
> >   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 4`)
> >     [  5]   0.00-10.02  sec  3.00 GBytes  2.58 Gbits/sec  0.437 ms  33053/82329 (40%)  receiver
> >     [  6]   0.00-10.02  sec  3.00 GBytes  2.58 Gbits/sec  0.174 ms  46379/95655 (48%)  receiver
> >     [  9]   0.00-10.02  sec  2.88 GBytes  2.47 Gbits/sec  0.106 ms  47672/94924 (50%)  receiver
> >     [ 11]   0.00-10.02  sec  2.87 GBytes  2.46 Gbits/sec  0.364 ms  23694/70817 (33%)  receiver
> >     [SUM]   0.00-10.02  sec  11.8 GBytes  10.1 Gbits/sec  0.270 ms  150798/343725 (44%)  receiver
> >
> >   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 4`)
> >     [  5]   0.00-10.01  sec  3.28 GBytes  2.82 Gbits/sec  0.380 ms  38578/92355 (42%)  receiver
> >     [  6]   0.00-10.01  sec  3.24 GBytes  2.78 Gbits/sec  0.430 ms  14268/67340 (21%)  receiver
> >     [  9]   0.00-10.01  sec  2.92 GBytes  2.51 Gbits/sec  0.074 ms  0/47890 (0%)  receiver
> >     [ 11]   0.00-10.01  sec  4.76 GBytes  4.09 Gbits/sec  0.037 ms  0/78073 (0%)  receiver
> >     [SUM]   0.00-10.01  sec  14.2 GBytes  12.2 Gbits/sec  0.230 ms  52846/285658 (18%)  receiver
> >
> >   * configfs settings:
> >       # modprobe pci_epf_vntb
> >       # cd /sys/kernel/config/pci_ep/
> >       # mkdir functions/pci_epf_vntb/func1
> >       # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
> >       # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
> >       # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
> >       # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
> >       # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
> >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
> >       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
> >       # echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
> >       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
> >       # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
> >       # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
> >       # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
> >       # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
> >       # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
> >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
> >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
> >       # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
> >       # echo 1 > controllers/e65d0000.pcie-ep/start
> >
> >
> >
> > Thank you for reviewing,
> >
> >
> > Koichiro Den (35):
> >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> >     access
> >   NTB: epf: Add mwN_offset support and config region versioning
> >   PCI: dwc: ep: Support BAR subrange inbound mapping via address match
> >     iATU
> >   NTB: Add offset parameter to MW translation APIs
> >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> >     present
> >   NTB: ntb_transport: Support partial memory windows with offsets
> >   PCI: endpoint: pci-epf-vntb: Hint subrange mapping preference to EPC
> >     driver
> >   NTB: core: Add .get_private_data() to ntb_dev_ops
> >   NTB: epf: vntb: Implement .get_private_data() callback
> >   dmaengine: dw-edma: Fix MSI data values for multi-vector IMWr
> >     interrupts
> >   NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
> >   NTB: ntb_transport: Dynamically determine qp count
> >   NTB: ntb_transport: Introduce get_dma_dev() helper
> >   NTB: epf: Reserve a subset of MSI vectors for non-NTB users
> >   NTB: ntb_transport: Move internal types to ntb_transport_internal.h
> >   NTB: ntb_transport: Introduce ntb_transport_backend_ops
> >   dmaengine: dw-edma: Add helper func to retrieve register base and size
> >   dmaengine: dw-edma: Add per-channel interrupt routing mode
> >   dmaengine: dw-edma: Poll completion when local IRQ handling is
> >     disabled
> >   dmaengine: dw-edma: Add notify-only channels support
> >   dmaengine: dw-edma: Add a helper to retrieve LL (Linked List) region
> >   dmaengine: dw-edma: Serialize RMW on shared interrupt registers
> >   NTB: ntb_transport: Split core into ntb_transport_core.c
> >   NTB: ntb_transport: Add additional hooks for DW eDMA backend
> >   NTB: hw: Introduce DesignWare eDMA helper
> >   NTB: ntb_transport: Introduce DW eDMA backed transport mode
> >   NTB: epf: Provide db_vector_count/db_vector_mask callbacks
> >   ntb_netdev: Multi-queue support
> >   NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
> >   iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
> >   iommu: ipmmu-vmsa: Add support for reserved regions
> >   arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
> >     eDMA
> >   NTB: epf: Add an additional memory window (MW2) barno mapping on
> >     Renesas R-Car
> >   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
> >     usage
> >   Documentation: driver-api: ntb: Document remote eDMA transport backend
> >
> >  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
> >  Documentation/driver-api/ntb.rst              |  58 +
> >  arch/arm64/boot/dts/renesas/Makefile          |   2 +
> >  .../boot/dts/renesas/r8a779f0-spider-ep.dts   |  37 +
> >  .../boot/dts/renesas/r8a779f0-spider-rc.dts   |  52 +
> >  drivers/dma/dw-edma/dw-edma-core.c            | 233 ++++-
> >  drivers/dma/dw-edma/dw-edma-core.h            |  13 +-
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  39 +-
> >  drivers/iommu/ipmmu-vmsa.c                    |   7 +-
> >  drivers/net/ntb_netdev.c                      | 341 ++++--
> >  drivers/ntb/Kconfig                           |  12 +
> >  drivers/ntb/Makefile                          |   4 +
> >  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
> >  drivers/ntb/hw/edma/ntb_hw_edma.c             | 754 +++++++++++++
> >  drivers/ntb/hw/edma/ntb_hw_edma.h             |  76 ++
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               | 187 +++-
> >  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
> >  drivers/ntb/msi.c                             |   6 +-
> >  .../{ntb_transport.c => ntb_transport_core.c} | 482 ++++-----
> >  drivers/ntb/ntb_transport_edma.c              | 987 ++++++++++++++++++
> >  drivers/ntb/ntb_transport_internal.h          | 220 ++++
> >  drivers/ntb/test/ntb_perf.c                   |   4 +-
> >  drivers/ntb/test/ntb_tool.c                   |   6 +-
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 198 +++-
> >  drivers/pci/controller/dwc/pcie-designware.c  |  25 +
> >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 246 ++++-
> >  drivers/pci/endpoint/pci-epc-core.c           |   2 +-
> >  include/linux/dma/edma.h                      | 106 ++
> >  include/linux/ntb.h                           |  38 +-
> >  include/linux/ntb_transport.h                 |   5 +
> >  include/linux/pci-epf.h                       |  27 +
> >  37 files changed, 3716 insertions(+), 501 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
> >  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
> >  create mode 100644 drivers/ntb/hw/edma/ntb_hw_edma.c
> >  create mode 100644 drivers/ntb/hw/edma/ntb_hw_edma.h
> >  rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (91%)
> >  create mode 100644 drivers/ntb/ntb_transport_edma.c
> >  create mode 100644 drivers/ntb/ntb_transport_internal.h
> >
> > --
> > 2.51.0
> >

