Return-Path: <dmaengine+bounces-9458-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB99ABLAuGnSiwEAu9opvQ
	(envelope-from <dmaengine+bounces-9458-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 03:44:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF282A2E4B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 03:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3A4C3013DFE
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F991F1513;
	Tue, 17 Mar 2026 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="osN6HRha"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021100.outbound.protection.outlook.com [52.101.125.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA21DF73A;
	Tue, 17 Mar 2026 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715471; cv=fail; b=lefCnUvqcPWk5JV/5AIx60M9z7UeL9k8Rw3XoxPrFpCj93C+gOodC0Lyq6xrdYsJgEdREg81nFcG9/GmS+bX8MtQDsMptrdct2zVeuxjXlWEitWbpZ1ed2VB+6LhAdxw2jzSSmoxMtjqmgcZ5zyQ98fq6imr0Uh4u198xosLYCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715471; c=relaxed/simple;
	bh=pfRJqi/v+T3puGh9OOkdjlmMikq1HDdb0e0UZIeaJRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b0858eTa7g/ebY2Ew0jCCQZQ5mDF1aX5FZmfFr6pQFQfYxZ1diPM6zhpn7iVD4waG0ECvC0FdwS1E/TVfsw0mAIyaGwm6b/FIdm4i0ksah/V/NUC18GDpgAV8i8bbr7dy4gQnuOSceOffed1jEKRG780wUYAxVgXqscoRx562Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=osN6HRha; arc=fail smtp.client-ip=52.101.125.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4V1qkNi/UpTJqC/trLT3ALwLEg8n2hUIppTmBHnNYdvh20Z+4m4im2ResQOKhxXKeHI/hKMa4qrd1L0jEjnEZjGLN1TmLEX1QUZoxSg4zPJqAq7fJV3wQBJY+z5dEeaOx9E1RNHPE2yw+vKr6bR1I8CfT58KijhM/QIjIyzFWGXRurF1GSY8LyOSfSabKKvI54DBrQCeXLW4Am0475CRkIr+EBLsz1iDmKi5na6orntk3YlKUWPYxtkCveEInP1waPZv7fMvE3wUU3PCSvJfZJzPcFw/B+NobJiqyyThMzlH0cFYDht+SFjEE+lBp0vexHvfHSE+C5R7PQ9UPh6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvXjqmAkpR1WyF2JBgxCPBb/hiFVvdNRA79gN1v9bXk=;
 b=zWAxfKHywT9hAHkGInt/+dxlrLYyCxDd4lzgtuSERPFmzH6Z1i5qWJU4jRPnbdtsvB07Zkgw8k84LDIBoKOZS4cRApg+Uu2po2y+hK99PVyzrhnUkAB2LHKh1osAspLEAEQi4DZUc27st09/W5XZiNGYJlG9EGv7AF9xVA6iF1W/k8dAeiEBvGpkV2fI0Fh5iqmV7pzXrAXwLVEg6Z4vEm9VWCM3B0ihki8qI5qe+w0yzsKNURD+YQQpZFszUO5259R8O3Chsq/BFaHwFNAjNIFtT4gA0AShKgjG/Qs0EyQo3CpKh8MV+4vXtXMS4m7CaYed1GWNuIo29PeUmcNaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvXjqmAkpR1WyF2JBgxCPBb/hiFVvdNRA79gN1v9bXk=;
 b=osN6HRhapHbGqRKpN1MkoMmoVXI0LXh4d10NCszF4Q2ssOpDxRJZfz0hQcOVza6VzTJZ71113H4RDCG5TIJnFH8a4QisD3gRO1Vk3PUy1E0UmHCi1ez/Q/cDK453epoGScZj9G8ql351d1+PNQWSx2kP36oD/JTCn1RZGWmNh68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3547.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 02:44:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 02:44:21 +0000
Date: Tue, 17 Mar 2026 11:44:20 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
	Jerome Brunet <jbrunet@baylibre.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
Message-ID: <sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0316.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3547:EE_
X-MS-Office365-Filtering-Correlation-Id: c2711ce5-27d9-4538-36ea-08de83cf17d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|13003099007|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gvRsI7gsGI92d6uyRgusVp+a6h4S5c8+u22EvNpf+4Av3YIf0S7YRVyKOjyKcpZGJEzxYmkxnt+30Umdjwn1HNNrX1nM2+8DnOhQH6SohdBftZYtXPZ1W6e3S7FdKcvVFgNnbeIBmafWIsxQUll3opQv56FnJp3cC1sIw21+OMOHshsdaJoPPHmG3O+WRq9/8PO5A9/L54HtjoIgl9Spa2xSnENd6IIZ+yCLVOjSeeCB1LQtBkZz3Ww48a6VTUjwRSN7GNl8lXBHei39B3Z62MxjbDIBo+sgb5vbE1dB0YVDC5cnTHeJXL0F3sxb7jGlC6gJcjXzF3bklX7Uo9abEMvzby+ZtzWVxLUOXoMephAV8MH7D8yGR3lGxax6w+S55bKg14lrnm/33tZFqXIz+YJnRh1SBqVe4Lu60nlFz8dy/4H6iZqOhwDDoMOAH4TcnmgAiQ/cNgR9OBR9L5ZZ24TnkYRqAFAzRxkMVf35CURRcBx4JeGOPrmKVOYJFuopyHVUtEyUbCKD8+7baY0A1+WxE108+QwhXKIcCEoVdfCDI9at+m64hRqVBt27DG7U5m2/kmUeXHJMgdIDceS+q1It+dhfavewvPpGhQig6+lxpy9tP9BvuUxKUEtr1KOANsf3FDgE63qnuHtVtnqcZfDEevcPwsdewaL1lCV6jFQ8vWJentNDQLx27zN4ih2D5deQQaXZZ2/zTM5zNVZr/xOWKqkmqjDL/AOEAh5wbsdce16oXTRw4fo9NL6yXKRoZJ7JSG/bvXJd634VW86ochqIUTTV5AXbkjoAzi3RhgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(13003099007)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1lAuaI0J8hqLD6eK47DrN40rrxEubGo6CHGbqLjgZpKK86e4+blkBOI2d6dp?=
 =?us-ascii?Q?wBsaSbxqDXGsLP6kLdAcy8lq8iKdDFINUA57/nOSfSJxAjPGIwNzCufvzBlA?=
 =?us-ascii?Q?0L8MsOvIboP3ZRSIo9YVRy1CxVma+SGQPXPDUTnIu16Fsqw/i+yTMnzCqR0i?=
 =?us-ascii?Q?AsxMZkJEc/rSCeEA07uki0/HVwmhg3S22OOoGZupJUentXUAPmAnlji7jz45?=
 =?us-ascii?Q?W8Go6eYO9xtV403+d39EBwdHjFbzLXtsLM6ebbW04k5Ut9IAzecNLyPgI5i7?=
 =?us-ascii?Q?I9yJd8hDz9ZUUXKOSlLV0kyPm1rrBIhylfcRXgWHBd2HLIuDF8i0S+84FayI?=
 =?us-ascii?Q?QanDRkbi8MGq4A137u8ZFt1XzjZL4xfG7T/uDoFyWJKogglInO4cRQL4BqSJ?=
 =?us-ascii?Q?kzKkYFjXwNSmjxBORVHFM2cx65iiFE8yfjxXohmc9bvn1D0TbBQ8Lukv/Jnf?=
 =?us-ascii?Q?sc3+Q2Lii3WrCI6WnwQqPiR00FVCJR8rwGxhVyUyH6xdH9riBk7lle2ul40H?=
 =?us-ascii?Q?3IsbFStKKZDhl9afJHiLkyEkmENKpUI9HiedFppOXutvVqEj3mZx4MO2jnke?=
 =?us-ascii?Q?BOThRinkGQ1K1+RckcNg2Q7BGNa0XVq8mJ85Nn7vQxHn90ZLXB48rpHf6qrx?=
 =?us-ascii?Q?E1293wPX8WDcslytocEd3X9fCw4dd9OvjlJAXO+umnu/vxvWfG5Z29NbXr1F?=
 =?us-ascii?Q?4HyGkem4EzbIV/gQusjcJnHY9YgYKdQvawm71GBkcogb4c9F7waXeuR6gj7P?=
 =?us-ascii?Q?YXTNm3fcbuCIpqkSH6JaiMyZ8Q5RqzjICry8Zvox5+9HP9F5A600z66Q+ThK?=
 =?us-ascii?Q?axb6UKVfGrnIunh30Lr1BJhLjpEAFop7tnwWnVwePdHasgyrsly3zb2rtYmm?=
 =?us-ascii?Q?SX1zWGnjKvfBNAEK5A0D4eKbQeo5c0lAey9e29rA5uuSy2A0FJ5PkXjsjcJf?=
 =?us-ascii?Q?ZlAYObaJ20Lz8+OfI9t02xR7ZPFzhJ5REijo99tljtnOizz/MkgFxhDE7PBt?=
 =?us-ascii?Q?i8YZ7yGbNYeVPqYfK4EZZYLtdFjpycpZ5j2bVtT8QUCMp7B1I+rXzV5jumSP?=
 =?us-ascii?Q?iOZnM0G6km1lXrYvmfVIt9WTOV3FwaaS0qDRHT3GyqRMiwnHTDqmK4VWjOZj?=
 =?us-ascii?Q?WLKJB9I/pHQnl0N0jRBIMe89gMqKGKbEVjUd07cHSKfdBEcML54szvKX1au4?=
 =?us-ascii?Q?ZoLsa6Iq30mdDMiBcwxexKmjPE6CILglYU+BJNPQgX/6EhjkFHm8+msQcrW8?=
 =?us-ascii?Q?RPEcHtrxF1OjUjfEqDkREoOKhEJTjpBOEGY5OQgnMBuBTWa97PLVkNIvg7jb?=
 =?us-ascii?Q?6OrhA3nySyL2B5oy3bOQhQU/Mb8uZjpUcoj+eFaL9NZ9iZ3p39StXJ0s6XAX?=
 =?us-ascii?Q?McvsizIegkchExCmkrkKnPFu9qCn83Tl4/EEO/WYMaWprLHU1p6EzlYA0ubh?=
 =?us-ascii?Q?aT9PzvqODjYagDxBzAvb0Y3/KGIPErRqMqPbvilp9sLT8/nKoYY53KhxxKnx?=
 =?us-ascii?Q?2p03lwkYwX06Z6ZzbCYlXdXrCUN2zny1Z0lOQ2aGSWNS6DwKOYgonFj6wdra?=
 =?us-ascii?Q?+SBIGcYdP4LISPIfQ9CkpvU0qtdY16Ekx+VLcQFKeCaZjG7i8124iSfBEHaZ?=
 =?us-ascii?Q?nkFtnilPgxL6JrbUCAbVL4Z8yDnYg0cWZOeVMT2h3i5B1DwoFPRHUgVvR4VH?=
 =?us-ascii?Q?BsFokLtItJiCRDNWj8dbvt5lAXZk9ShGheuikg1GZIQXDXhfD2LeOP+BN6ag?=
 =?us-ascii?Q?NvAE1l0WvdHP0+CnCNZ5Dyx7KXFfs03ZQ8PFpFk953DWodZMdZyg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c2711ce5-27d9-4538-36ea-08de83cf17d1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 02:44:21.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJDjrC8Duhg4Djc2OAS2eBvFE0P/380jlJQahjhGvE4bkCi7Y4DW3vdRuVNggEwigty2b+4QwZKfp0LzDHa2rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3547
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9458-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 7BF282A2E4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:49:50AM +0900, Koichiro Den wrote:
> Hi,
> 
> This series lets an endpoint-integrated DMA engine be consumed on the RC
> side through vNTB.
> 
> The initial target is DesignWare endpoint eDMA. pci-epf-vntb exports a
> versioned DMA locator plus the minimum peer-visible resources,
> ntb_hw_epf parses that locator and instantiates an auxiliary device after
> LINK_UP, and dw-edma-aux binds to that child to expose a DMA engine
> provider on the RC side. ntb_ep_dma is included both as the first
> consumer and as a simple bring-up test.
> 
> 
> Background
> ==========
> 
> I previously posted a broader RFC series:
> 
>   https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/
> 
> This series is not a direct continuation of that RFC. Its scope is
> narrower, and the approach has changed substantially.
> 
> That RFC had two architectural issues:
> 
>   1. dw-edma-specific logic lived under drivers/ntb/hw/, even though
>      the exported DMA engine is not related to any NTB hardware.
>   2. Remote-use channel delegation relied on vendor-specific peripheral
>      configuration.
> 
> This series builds on the recently discussed pci_epc_aux_resource work
> (see "Dependency" 3 below) and addresses both issues by:
>   - introducing vendor-neutral DMA-channel delegation in the PCI EPC
>     layer via pci_epc_delegate_dma_channels() and
>   - making vNTB and ntb_hw_epf aware of the remote DMA resource.
> 
> On the EP side, pci-epf-vntb describes the exported DMA resources as
> part of the vNTB BAR layout. On the RC side, ntb_hw_epf detects that
> export and registers an auxiliary child device. A vendor-specific
> frontend can then bind to that child device and reconstruct the remote
> DMA provider. This series includes such a frontend for DesignWare eDMA
> in dw-edma-aux.
> 
> 
> Architecture
> ============
> 
>   EP kernel
>     pci-epf-vntb
>       - exports the usual vNTB control/db/MW resources
>       - optionally exports a versioned DMA slice
> 
>   RC kernel
>     ntb_hw_epf
>       - parses the control layout
>       - instantiates an auxiliary child for the exported DMA ABI
>     dw-edma-aux
>       - binds to that child and registers a DMAEngine provider
> 
> 
> Series layout
> =============
> 
>   01-05 prepare dw-edma and auxiliary-resource metadata
>   06-10 export delegated controller-owned DMA resources through vNTB
>   11-13 discover the exported DMA instance on the host and bind
>         dw-edma-aux
>   14 adds ntb_ep_dma as the first consumer / smoke test
>   15 documents the model and the configfs layout
> 
> I did not split the infrastructure patches (01-13) away from its
> consumer (14). The series is meant to be reviewed as one feature:
> producer, discovery, consumer, and test coverage.

Please let me add a small clarification to (1) help position this series
relative to the existing pci-epf-test / pci_endpoint_test framework, and (2)
clarify how this differs from the earlier RFCv4 series, as I may not have
explained it clearly enough before, so I added a small ASCII diagram below.


First, regarding the relation to pci-epf-test / pci_endpoint_test

  The existing pci-epf-test READ/WRITE tests already demonstrate DMA-assisted
  transfers between EP and RC buffers, and when private EPC-local DMA channels
  are used, this also exercises Endpoint-integrated DMA.

  What this series tries to demonstrate is a slightly different layer. In
  pci-epf-test, the DMA capability is hidden behind a test-specific command path
  where the RC asks pci-epf-test to trigger a predefined operation. In this
  series, the idea is instead to export EP-integrated DMA resources through
  pci-epf-vntb, let ntb_hw_epf discover them, and reconstruct a normal DMAEngine
  provider on the RC side.

  From the RC side, a consumer can obtain a local dma_chan (via the standard
  DMAEngine API, e.g. dma_request_channel()) and drive the transfer directly,
  while the actual data movement is performed by the remote EP-integrated DMA
  engine.

  This is why the test introduced here is ntb_ep_dma. The goal is not primarily
  to prove that the EP can move data, but to exercise the full NTB path:
  resource export in pci-epf-vntb, discovery in ntb_hw_epf, DMA provider
  instantiation on the RC side, and the first consumer use through a normal
  DMAEngine client.

  In that sense, this can be seen as a natural extension of what the READ test
  already demonstrated. The plumbing introduced here makes it possible for the
  RC side to:

  - use the standard dma_chan abstraction for remote DMA usage
  - keep the user-side implementation simple and clean
  - avoid wake-ups on the EP side to trigger transfers (better latency/overhead)


Second, regarding the difference from the earlier RFCv4 series:
https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/

  Compared to that RFCv4 (which had a much broader scope), this series treats
  EPC-integrated DMA as a first-class resource in the vNTB <-> ntb_hw_epf path,
  similar to how doorbells are handled today, and makes the number of delegated
  channels configurable via vNTB configfs.

  The main challenge is how to define a vendor-neutral "DMA ABI v1" (see the
  ASCII diagram below) that can carry the necessary information for remote DMA
  operation over BAR mappings.
  See struct pci_ep_dma_hdr_v1 defined in Patch 9/15:
  https://lore.kernel.org/linux-pci/20260312165005.1148676-10-den@valinux.co.jp/

  The advantage of this approach is that it avoids pulling EPC-specific DMA
  details into the upper layer (e.g. NTB subsystem), unlike the earlier RFCv4
  which pulled EPC-/vendor-specific DMA handling into the NTB layer
  (ref. the proposed drivers/ntb/hw/edma/ directory in:
  https://lore.kernel.org/all/20260118135440.1958279-26-den@valinux.co.jp/)

  Below is a rough high-level sketch of this series design:

		       EP with
		 EPC-integrated DMA               Any Host

                  +-------------+              +--------------+
                  |    vNTB     |              |  ntb_hw_epf  |
                  |             |              |              |
                  |     +-----+ |              | +--------+   |
                  |     | DMA |----(DMA ABI)---->| decode |   |
                  |     +-----+ |      v1      | +--------+   |
                  +--------^----+              +------:-------+
                           :                          :
             Delegated via :                          : Instantiated by
                   EPC API :                          : vendor-specific
            (vNTB configfs :                          : aux driver
              knobs added) :                          : e.g. dw-edma-aux.
                           :                          v
 +------------+     +-----------+              +-----------+     +-------------+
 | dma_device |     |    Real   |              |    Aux    |     | dma_device  |
 | (EPC plat) |-----| DMA chans |              | DMA chans |-----| (ntb_hw_epf)|
 +------------+     +-----------+              +-----------+     +-------------+


                delegated ----.                        ,---- delegated
               (unusable)   \  \                      /  /   (usable)
                      ++ ++ ++ ++              ++ ++ ++ ++
                      || || :: ::              :: :: || ||
                      || || :: ::              :: :: || ||
                      || || :: ::              :: :: || ||
                      || || :: ::              :: :: || ||
                      || || :: ::              :: :: || ||
                      || || :: ::              :: :: || ||
                      ++ ++ ++ ++              ++ ++ ++ ++
                      WR WR RD RD              WR WR RD RD

                      '---'                          '---'
                        :                              :
                        v                              v

               Upper layer NTB consumers can use these channels for
              efficient EP<->RC transfer via standard DMAEngine API
           (assuming each side uses a local dma_chan for TX submission)


Any feedback would be greatly appreciated.

Best regards,
Koichiro

> 
> 
> Test
> ====
> 
> Tested on R-Car S4 Spider with the dependency below.
> 
>   1. Configure and start pci_epf_vntb with DMA export enabled.
> 
>      The actual commands I used for testing:
> 
>      # modprobe pci_epf_vntb
>      # cd /sys/kernel/config/pci_ep/
>      # mkdir functions/pci_epf_vntb/func1
>      # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
>      # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
>      # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
>      # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
>      # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
>      # echo 1 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
>      # echo 0xF9000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
>      # echo 0xF9000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_offset
>      # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_num_chans
>      # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
>      # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
>      # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
>      # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
>      # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
>      # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_bar
>      # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
>      # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
>      # echo 1 > controllers/e65d0000.pcie-ep/start
> 
>   2. Boot or rescan the RC side and let ntb_hw_epf probe.
> 
>   3. Load ntb_ep_dma on both EP and RC.
> 
>   4. On the RC side, run the test as follows:
> 
>      # cat /sys/kernel/debug/ntb_ep_dma/0000:01:00.0/ready
>      # echo 1 > /sys/kernel/debug/ntb_ep_dma/0000:01:00.0/run
>      # cat /sys/kernel/debug/ntb_ep_dma/0000:01:00.0/result
> 
>        last_status: 0
>        last_len: 4096
>        local_buf_dma: 0xfffff000
>        local_buf_size: 4096
>        peer_ready: 1
>        peer_state: pass # <----(*)
>        peer_dma: 0x4e11e000
>        peer_size: 4096
>        peer_seq: 1
>        peer_xfer_len: 4096
>        link_up: 1
> 
>        (*) The peer reports "pass" after the transfer completes successfully,
> 
> 
> Kernel base
> ===========
> 
> pci.git endpoint:
> Commit 0b74f7d72399 ("PCI: endpoint: Propagate error from pci_epf_create()")
> 
> 
> Dependency
> ==========
> 
> 1. [PATCH v4 00/10] PCI: endpoint: Differentiate between disabled and reserved BARs
>    https://lore.kernel.org/linux-pci/20260312130229.2282001-12-cassel@kernel.org/
>    https://patchwork.kernel.org/project/linux-pci/list/?series=1065666
> 
> 2. [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
>    https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/
>    https://patchwork.kernel.org/project/linux-dmaengine/list/?series=1054298
>    Note: already landed in dmaengine/next.
> 
> 3. [PATCH v10 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
>    https://lore.kernel.org/all/20260302071427.534158-1-den@valinux.co.jp/
>    https://patchwork.kernel.org/project/linux-pci/list/?series=1059820
> 
> 4. [PATCH v2 0/3] NTB: Allow drivers to provide DMA mapping device
>    https://lore.kernel.org/linux-pci/20260306031443.1911860-1-den@valinux.co.jp/
>    https://patchwork.kernel.org/project/linux-pci/list/?series=1062308
>    Note: this series uses ntb_get_dma_dev() API.
> 
> 5. [PATCH v2 00/10] PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
>    https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp
>    https://patchwork.kernel.org/project/linux-pci/list/?series=1058871
>    Note: v2 title was incorrect. See my reply to the cover letter.
> 
> Additionally, for ntb_ep_dma test to pass on R-Car S4 Spider:
> 
> 6. [PATCH v2] PCI: dwc: rcar-gen4-ep: Mark BAR0 and BAR2 as Resizable BARs
>    https://lore.kernel.org/linux-pci/20260210160315.2272930-1-den@valinux.co.jp/
>    https://patchwork.kernel.org/project/linux-pci/list/?series=1052780
>    Note: already landed in pci/next.
> 
> 7. [PATCH v2] PCI: dwc: rcar-gen4: Use 4K EPC BAR alignment
>    https://lore.kernel.org/linux-pci/20260305151050.1834007-1-den@valinux.co.jp/
>    https://patchwork.kernel.org/project/linux-pci/list/?series=1062031
> 
> 
> Merge plan
> ==========
> 
> This series touches three areas:
> 
>   - PCI endpoint core and pci-epf-vntb
>   - DesignWare eDMA (dw-edma)
>   - an NTB test client
> 
> The series intentionally keeps the infrastructure changes together with
> their first consumer, the ntb_ep_dma test client. Splitting them further
> would leave the infrastructure patches without a consumer, so the
> patches are kept together as a single series.
> 
> Mani is a maintainer for both the PCI EP and dw-edma. My initial thought
> was therefore to collect acks from the relevant subsystems (PCI EP,
> dw-edma, and NTB) and have the series applied through the PCI EP tree.
> 
> However, I am of course open to any suggestions regarding the preferred
> merge path or series split if maintainers think another approach would
> be more appropriate.
> 
> 
> Best regards,
> Koichiro
> 
> 
> Koichiro Den (15):
>   dmaengine: dw-edma: Cache DMA channel IDs in dw_edma_chip
>   PCI: endpoint: Add DMA channel metadata to pci_epc_aux_resource
>   PCI: dwc: ep: Report DMA channel metadata for aux resources
>   dmaengine: dw-edma: Add per-channel interrupt routing control
>   dmaengine: dw-edma: Compose MSI messages from allocated IRQs
>   PCI: endpoint: pci-epf-vntb: Fold MW runtime state into a struct
>   PCI: endpoint: Add EPC DMA channel delegation hooks
>   PCI: dwc: ep: Delegate exported eDMA channels through EPC ops
>   PCI: endpoint: Add pci-ep-dma helper for exported DMA ABI v1
>   PCI: endpoint: pci-epf-vntb: Support DMA export and shared BAR layouts
>   NTB: hw: epf: Parse control-layout version and DMA locator
>   NTB: hw: epf: Enumerate auxiliary child for DMA ABI v1
>   dmaengine: dw-edma: Add auxiliary-bus frontend for exported eDMA
>   NTB: Add ntb_ep_dma test client
>   Documentation: PCI: endpoint: Add vNTB DMA export HOWTO
> 
>  Documentation/PCI/endpoint/index.rst          |   1 +
>  .../PCI/endpoint/pci-vntb-dma-howto.rst       |  83 ++
>  drivers/dma/dw-edma/Kconfig                   |  11 +
>  drivers/dma/dw-edma/Makefile                  |   1 +
>  drivers/dma/dw-edma/dw-edma-aux.c             | 297 +++++++
>  drivers/dma/dw-edma/dw-edma-core.c            | 101 ++-
>  drivers/dma/dw-edma/dw-edma-core.h            |  13 +
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  26 +-
>  drivers/ntb/hw/epf/Kconfig                    |   1 +
>  drivers/ntb/hw/epf/ntb_hw_epf.c               | 199 ++++-
>  drivers/ntb/test/Kconfig                      |  10 +
>  drivers/ntb/test/Makefile                     |   1 +
>  drivers/ntb/test/ntb_ep_dma.c                 | 695 +++++++++++++++
>  .../pci/controller/dwc/pcie-designware-ep.c   | 196 +++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  11 +
>  drivers/pci/endpoint/Makefile                 |   2 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 794 ++++++++++++++++--
>  drivers/pci/endpoint/pci-ep-dma.c             | 342 ++++++++
>  drivers/pci/endpoint/pci-epc-core.c           |  84 ++
>  include/linux/dma/edma.h                      |  42 +
>  include/linux/pci-ep-dma.h                    | 130 +++
>  include/linux/pci-epc.h                       |  31 +
>  22 files changed, 2981 insertions(+), 90 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/pci-vntb-dma-howto.rst
>  create mode 100644 drivers/dma/dw-edma/dw-edma-aux.c
>  create mode 100644 drivers/ntb/test/ntb_ep_dma.c
>  create mode 100644 drivers/pci/endpoint/pci-ep-dma.c
>  create mode 100644 include/linux/pci-ep-dma.h
> 
> -- 
> 2.51.0
> 
> 

