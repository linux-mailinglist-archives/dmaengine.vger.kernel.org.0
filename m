Return-Path: <dmaengine+bounces-9460-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNwzFC/IuGnTjAEAu9opvQ
	(envelope-from <dmaengine+bounces-9460-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 04:19:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF44C2A31BD
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 04:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F543073F78
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 03:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102BC2D060C;
	Tue, 17 Mar 2026 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jFyO902j"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020135.outbound.protection.outlook.com [52.101.229.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02F2C21C0;
	Tue, 17 Mar 2026 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717208; cv=fail; b=uVM+7W6oGQZubEBJ4lsd9OPiaOdTEB+6Py5KgvGDH3cUu6Ue3ugw42W9+jbUxai3XfLjRDtIDCR+ONf2f4YKiddZpbm6Esae1GzzhIPth6UYihTgcyZzNQApf4CT2dx+n+zOprA1+A6W/IXlyKQmEsg64EhSoy3j1BSmfEI5FFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717208; c=relaxed/simple;
	bh=w4pBFE40dQ4ul/OIe0Gq3oHeqt4dyisIUOTwlQj9k3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y3UpZphckQesdJ+e9LgheIlhKZs63NwTvMaOrBHobbx7gei31wSASmzQ/0D/jy6GTY8HMEN/gZ24QRIS9YH5tI8BaKQ6RZyoI/MPvQJZ0oTmIOC8yec/9vlJQSX2UwkFXLrKYDYlskPkjhF8i3u3v9Hc3A+Wbic7W+fkf9DQFHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jFyO902j; arc=fail smtp.client-ip=52.101.229.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cg0oViRgO6faJiUSeSIA656lhrCaPAXClqfeGmGLhYynbK3TEZYSJ9MB8Fv1nGTsPxOYWy3dxTltiBBrpX4psdBLNCWc729mDofgVgurkbn7pYBe3i+GSx90O/meJz+M/HQT1SpOAMz4ztsU2Cx9mSyXAHFOPnNXWNktKxH6qhhXp/JWXEamkzp7vmKvCkZu1Q7yVa2OK7VrX9Awab198rJPb6h8gYQ5C2u56B/ldiUL+nlPsJAUYiB1Sb9WadtwVjmnW5+sH46VnuEtWE/Ben1usOVQBhOYMVsKeALjwHyzhjwKyZB8NvV2lgDOqoY1fgIGrQ1B37OrrvB/HrlkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtLVW1N4Eq5yMN6W3RSmtDU2GCEiI/jUl2+1Gl2jIRU=;
 b=kLHax1zgnJfrywGPJvhY9xzOH0Hvf3nn6H+5Y57oAXTjWKfqWrntJKuCU8vtbhV6ZGAC+QvsatV0x5R349gHbepnoj6r7FBcwkQAMoJx/b9XeNCeq89xLnnMx13n0dpWkF4oHSjXEdrDc1hPl+ml25gPA9PTr1rKhEsTi+PV001toff8EtNtcVAT9JlvVItFClOLK7+313SOvQNnaZwUZh+oUhsh8NiCOzj0spWDXpyrcAjutJe4KVrkGwXUyvo/1y13Cl9gafz/lK3/sq4CEqdTVvL4TWzG/0t7/WhlN5TqEshpGoFIXj4onZkKi7vpc76paok7MegB9UnHfRia/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtLVW1N4Eq5yMN6W3RSmtDU2GCEiI/jUl2+1Gl2jIRU=;
 b=jFyO902jXnbROFgjeVqwaxY6MRq2UduaKv+ARFApPagj/Qh0YabVE21qYoUIA9HfNNbRyEu2joLcTXqdKHZ3yj75nsD2B71MJk9OH3PC9LfzVOb1EI5jWe7oggrQmTmkee91Qc5biWibfeSmVJELRmg0Q0qgra6kVZzHIZY12Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYVP286MB3133.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:299::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 03:13:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 03:13:25 +0000
Date: Tue, 17 Mar 2026 12:13:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
	Jerome Brunet <jbrunet@baylibre.com>, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 06/15] PCI: endpoint: pci-epf-vntb: Fold MW runtime state
 into a struct
Message-ID: <735od76ic3rkz6imi2fguvjhi3nd5spjxpdesgt75nqnor6h4a@jahba3ai3iba>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-7-den@valinux.co.jp>
 <abMjf6Y9o5kahSsm@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abMjf6Y9o5kahSsm@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYVP286MB3133:EE_
X-MS-Office365-Filtering-Correlation-Id: 4682365a-da54-4722-53f4-08de83d3275f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	IAYrwGSrOMPBmO8Ded5N6bZZjAXhon48G2DFoJng4PcPGkcA5X5eZ2yVjf6u84Fcx9kTYa9G+N6qowLKW9QdMMXGgTIBgX4hLvxxsLGGnKIwxQFsihOAa88J31NQNE54mtPOwjLTB614P8626z7zVr7V9jz9R/iO2m9VZoGWsNtatvtiRAQbyJo6vVZkEIgygn101B7eEd55iwPRilswJWuOm/5tf3nrVSzSW0Vh9wp4V50/UYUYADtu6W5NwUlGB9UXyzrVZUB0pTbGd0SmzGSn6R1kpBSzQUt9fMnF0nD2oe1J30X9m1vcn5Q7pUh46icgTUS7WxmzjDRk0l8wDXfVIvoWYm9xqYvxI9eahOpdxMpD2FtYzwIyvgT2lnDZEniJF6uYNfWV0ChVkNyK6r4+BcLiOsMPSTVNkxVw6xAdeQEcN1kSXtXaQy9+kwukxXkPN2tapcQd98SPKxuRGZQ4eqQxS4KJGtcMbpkRUjQBvKNp6Ff+DQARrNFWSRMyeYkTxC/J4Zbk7AmpbTahaNRxrwPffHnLlF5qdNBUgAYpM4J+QzewmhvK3N76EmBwWzS0XozfZXA6cgyx6ckhjQMIwXb5ZWfvwxyFFxY9nO99cRYKFuJIzzdwL38v2FnRhVm9KrtUm/9i9TKz/3SYXNtVH4MUSMMBRxiul103LscfY0y9x5tL85SVQbTmJ9hxiPCZU4oKnNR8LVIrH38Mpzo0cH6Y1jf2xor2Ve2QKsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J9Kd9Pbn/WoAZu0yVJtxoJzBJdf8zJuwCq/CQrilte5xVNEptV5/iygC2DBu?=
 =?us-ascii?Q?5J10qWidsH6qabBEUc+6+Mj1GpcRCA/sf8MWQoUY8dm+ucHOSwHer7gclFu6?=
 =?us-ascii?Q?L1SlH4vefhUk9+eDbdRzNKwAgQ6lbbYMj7dqNCjiBOTwLv4bwJWhRUz9xt9X?=
 =?us-ascii?Q?XLoBesgD5CURfBbqxeRaQWEtD5uor0G8mTkzX0HgDStAoI3pZ3zAjoPJuwFN?=
 =?us-ascii?Q?iRr2UzQNukcPFoXyzpPleP5E35cWFVjnDKTpE/zM11AnjKt63Yfq/davLaXP?=
 =?us-ascii?Q?cyyarh5IC8+fROc5Fne2YPClsMC8CsS2lo8z4+WNhv/YUgSbOn4Q4kdxwYbC?=
 =?us-ascii?Q?y2e7NRS/Dzg95BlDR26FBwy72WpzPwn6n4YO6k7BqJtP+4ej2PEOD4pGjIrr?=
 =?us-ascii?Q?8lBXuTeEkEXroVzb+djrUxHGbJaF5cBxjWruOvkyi1FzkMVhy7+xr/WHT5EZ?=
 =?us-ascii?Q?6EI7oNbgWBfPLAP4aI9BQINF6uM9Ncv0touyco53o0KGNw7zZRfZBXUHanOF?=
 =?us-ascii?Q?sr5RYDsMLP/2PxKreBU4r1y2HDB/+3dYDaDAZ5jVYCqr/hjPaTAt200AJzep?=
 =?us-ascii?Q?i2n9yXcDv6lOdFwtDOZ0DW+0aVtwaPKg5+pCJrmcP0AWt0Y0KYraA0/mxkE5?=
 =?us-ascii?Q?XyMmRK6nX3pt/ccpe9WreaUwVCKxgcUxhsKKSDPcUYKnVvV3knjqRWjv/6UE?=
 =?us-ascii?Q?ZBGLXLcqo8XUK1sahR9QbVLPA4D4kKAANuVKLNO8uQ8TPWw16qM2TMR/iTg7?=
 =?us-ascii?Q?reCMklhjdnrqWj3rhyjFsMrzeJUysRcK3rCayqvOblaaPnl8VqfavMKVnbKX?=
 =?us-ascii?Q?d4EXqvO7MNGSgBeAmO+lsvhKbSICPXITOLjlQsxvbL16yhlMxHn58YwhysLt?=
 =?us-ascii?Q?apCf10G5sRNQsogGdm+EQK1zUqgUt17U4GRLjasAfIPfVJOX/OKU5aSISpB4?=
 =?us-ascii?Q?eIOxnGeVGZjqnDH6opRdYNTJ+qN1N4Rtdj+oMMw/+IeCQ3Ced1wrsW960Zwr?=
 =?us-ascii?Q?s8KwN4P2w8Yt3vkGCpN/9wgVaOPrcqFFVCBGMZIphV4wujFQkMiW4FBjg6hG?=
 =?us-ascii?Q?/870cFNN1Wtc/YYkSQL3mZitCTfWJUvBmpxoz02btqD9+bIQbWSWm312dTar?=
 =?us-ascii?Q?5cjsmBxbH/6yVCspYuvDwWBG8wdbb7m7Qlyg9eM9Mn0wIFKZdkcZtUAxJouj?=
 =?us-ascii?Q?GcHv4MwjJWTH+yq06eTh85QqIMTigO0kxQrovu6U8yqpjBF66XCRIDd+8oRL?=
 =?us-ascii?Q?FX9nqvCR6NIVo3cBUDy7h/P1CfewJOThXIDaKoJ8Sz9HbmBH7l255rwj0K/z?=
 =?us-ascii?Q?l4qO50NCFGAymAwyUIhjae3GfHc7bFcGIN9skClMzYTwnCzJ3/nQ7HgrnavD?=
 =?us-ascii?Q?313HK36yTJQzXPNP41i61O9HDOs36jAw5rGLE3+XNaZj4D24yUiMblSGI7m+?=
 =?us-ascii?Q?9tW9NNANM7lSUiPhMc9jVgrxRufa4PQC/+YNaQlhxGZ01C1ZLMrlIeP1Iz9J?=
 =?us-ascii?Q?0XbBvSmPPyxdkdAhHXVpnR2ca72g2hGw8CNuas7ss1S14AU3QS7D9w32Urju?=
 =?us-ascii?Q?H2n8C1Fh05k1sv1CcjxLahJ1Qm25itu8A0gdCueoPOCDsePnkq5lfKQFPSpd?=
 =?us-ascii?Q?Gi9jQKZNrS3mQDNb8MbSzpOcVEtfBQOrJ7xQgUz/MNOG2iswOHT0j2uxCRDZ?=
 =?us-ascii?Q?u+ZxJv2SboDDSq3zLEXkkGlqgZRojCFzfqRBjcwPu+Em52xnPPigpO/wkmhe?=
 =?us-ascii?Q?7XQxWxMFKXOKZPW+YaMkJ6F2ENTPk5f1JUnFz6YjdRK9jsZdTw9t?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4682365a-da54-4722-53f4-08de83d3275f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 03:13:25.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ht4FdIoE3fM8ehYHY1K/9IMnBpzvz4uJ0KoxZYcde4NVyYzBtdGuAyu3q3DXB40xHv9GulXLqK8D9LsXrcJ4Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3133
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9460-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,nxp.com:email]
X-Rspamd-Queue-Id: EF44C2A31BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 04:35:11PM -0400, Frank Li wrote:
> On Fri, Mar 13, 2026 at 01:49:56AM +0900, Koichiro Den wrote:
> > The next patches add per-memory-window offsets, shared BAR placement,
> > and optional DMA export state. Keeping per-window state in parallel
> > arrays would make that work noisy and error-prone.
> >
> > Group the runtime memory-window state into struct epf_ntb_mw so
> > follow-up changes can extend a single object instead of touching
> > multiple arrays.
> 
> Simple said
> 
> PCI: endpoint: pci-epf-vntb: collect MW information into a struct
> 
> Group the runtime memory window state into struct epf_ntb_mw to improve
> readability and make the code easier to extend.
> 
> No functional change intended.

Right, I'll update it when respinning.

Thanks for the review,
Koichiro

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> >

