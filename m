Return-Path: <dmaengine+bounces-11540-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l3/bOY5FMGqOQgUAu9opvQ
	(envelope-from <dmaengine+bounces-11540-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:33:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C7689307
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:33:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=HdAgmtfF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11540-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11540-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A8F3006956
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E964931355C;
	Mon, 15 Jun 2026 18:29:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F711474CC;
	Mon, 15 Jun 2026 18:29:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548191; cv=fail; b=jEdLkvjh+NVWx4agPkQqN8Amg2m7IsL6cTmCJ8aZX95vaTkx7pE3bfuVFzx8itSuAjEHvDwrLbYHgmFiZNCP7RDdBOIaEQQzGA2Ke0M+uhR42I3woObx9L5qIt39CwtnnzFa21Clp0VldMNhrTclNOGH57z/ybl66d0qGk3Y0Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548191; c=relaxed/simple;
	bh=TrYt46K/S3of0fA4RfDTTQZSsuN5/LE3ksOUnKTSXAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ns9iw6DI7iZ3rAW8bMnq+xDiXO63Hfto5fWEWE4LmbU2L/ds+AtwHPowAU8256qlRQwsmdfKax5RsMT2qb9ZPNBAVyH3CMWmLBxtvDCsPVXg8Hgs//H9P92xRipICJO8qZkaTe8UMuPiBUzAC7uDOaw93cJdMNEdITiboCLhNU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HdAgmtfF; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVnPq62xJCYFH2XaatjHda7i1gdDaiiKKQMtwiItPTdnv7fe0bs43Cb42lx3Z5T/jt+IdBeGSF1zQ/2FVYh6/QV82bBF9W7l92nb/dgds4Xdu9pXAD3fiqL10yfGHpUhDBGZigMjdaLXP8zA22nWdX2NuT9eTIePJ0TpPbFrV3le0/NmdmrmAN6pwnVOxajWGxOTDhzmZM9QqfeZPYNMt/H1Fdhmol2GaIxyQK/aOjr9gFZTZuWdvt2msNo0/DboW93m2Lx2+Ei6y8IWFyuXLd5KDe7ukuoZYU0Ff5bWhd4kHkmbae9J796/Hu8ZI1BkZg8zUlhSzmwnmXqjjBLQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVxkT1EQeCHnhQ8tZyY76ZDAe6HFJW4zr0+zRtqP7dY=;
 b=rMdMpI6TW3bOy8ZeVqbjyDSTCQnUm+MjMpRDpBNiCmQ8jnFKVwUO3+ZwT+YVgHMh2FA7FaXP5Kxq197QobBF+uKvuvBi5czCHXtS2xIZGZoxOIncrXA2BvTeQX680knOq2jzkhL+sIvuth4SuUxA5WS5kxhBibSKtUOvGZ6HPHC6eKpYG2egaNrp7/xhK0HNEwOMGJ6nOOQLd4OVB5yzyh5zXfcwZ/r+XC6GsZI08aNKFiWZeVxUmeyG595i1kJdX3iMF2IYhi0pXQoCse27pPIVhZvQvBLLIzqR0ramVyIWTE8vMHCTNO+A2k86wCTPZFTaiEo1AjZuB/78C6mvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVxkT1EQeCHnhQ8tZyY76ZDAe6HFJW4zr0+zRtqP7dY=;
 b=HdAgmtfFofnR8cr5HdV+FdIvaLXd2E5Xc6UTqURIKJk8ZV2uaC7C/Q4Hv9XDzTazEj+1CQSWqd9FsylmFRf4NDbBPDHhBV7Ib5+Y6FEpgY6CeeuRQGLgnec7c9yyDQ7FXGwtCyWroYCAVKBA4wzFgdWGsPdB7D3tm11+xr1kaFYNTJt3sRkQPCh6OuNI/WRgyJ1P6I4cNPbz2Waasmb7MPsScpm9zkGX7QbpWD3UTz6DI/1dJtyTs4R6+UgLM6Zs64ZQ27hYG4fpFc+dnzBl3HIK5Yr0jWwi5I/FiEyIGkunt5+bm8ACiEytyezQmUEnWhh7pOV6Ofwv540Y7SP78g==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11508.eurprd04.prod.outlook.com (2603:10a6:102:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 18:29:45 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 18:29:44 +0000
Date: Mon, 15 Jun 2026 13:29:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] dmaengine: dw-edma: Fix residue burst index in
 tx_status()
Message-ID: <ajBEjPQlUra3s8Oq@SMW015318>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <20260615154111.2174161-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615154111.2174161-2-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:510:2da::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11508:EE_
X-MS-Office365-Filtering-Correlation-Id: c8004a53-d2c0-4f03-10d5-08decb0c128e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PZlDVmXrTMoGVeOT+s85bF7h6Aihi8KrCHOy9lrdMsFJ+r584wqAhEqYpHeuAl4DPXpd8mPCMRW6FVrM0L6pzuwbH7ItIdXptfKwuQM9RWOT9X67Kg8kN2O2BLUi5YnklYMTv/wugYTNBGBwr6uybM5mwrMVhFEk0WQKeBVQ70Nmynj0WnoNcxIa+QHNiMP4bnlgleLG+LTp9/FRcQur24fKS0WJp6Xqm9OJQo6ZYTU1b86pcetB8FNEo/faBiTCVHj8hkX47eXyY86e0d5zILtMJ2E6uNAbyIQnE2HSb+b9ttC/r+wwhc05T5szio7v0g2RE5nqwofTefeX/Hgu8c1SLBwjH5X7tZhQiA6htnxTvXnwC3OzT6DGsynNvgb6hM9N7H0xzYqi+MBGU4G2be2V6284TFxpGZ0WwnItfjC+EFbvKAu6bQ5aZnuZ2BZgLj/0YHnRX/7A+74DcU0znw6S49IgnLN9l4VUGBVBEOdVibZBlGu3TCyOeFV4KRAY6rRnekTulaFOgMjGffg62mOwyw+vkZ+yPoe1Z0hWOlop5bhXFZDKAMlHRLYHCRRc4UlZI/xv308dA8K7xDGzr3M4L5PaYSHOCFHMvtCx4WXBHhVsF4OS3V2Lnaa78E8JCU3bNLi8UmasT1emHL4lYofvWu3u3+ExAUvjRTD4DihSsGSpQ3Gjx9NfBCa0ZaU+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/GvRQkL3Q0OTZOlDtrBwfakzMnFwZL1XDYvk8kD93uDte39v5cutej4kx2Y?=
 =?us-ascii?Q?XQ05grXvKAl44hTjPRDt2gL0rBVMOyzfe/xulCcWhd/jfv2qPc09DDPEsUE1?=
 =?us-ascii?Q?Eo2OmMWfYbXp4LUU1ErygXiEEoDO6V4HUqJtMoiHlWmaqxTml4/JzotvFh1O?=
 =?us-ascii?Q?g3W0p2x/A++PQ5H5ytSAeSLy6czn4xpSZWtjooUcWv8+4XAdqpjvrzpCJbGy?=
 =?us-ascii?Q?VN7GNWcV8zQyJA9UVYw7Kum3hQuean1m0IFmzMymBL4ytyIbg2DesQDgwglO?=
 =?us-ascii?Q?TfW7rIDkH8Huojx9nuGlD4sq21I9xBLXv8UXU1tWZ6TXaM7dC0NhU84B+ss4?=
 =?us-ascii?Q?zAqievKX5Et2GEzPvL1YmQ3HZmkGRhHDj7PBp9A6E/4xkWvIyq7fHxBm/r0C?=
 =?us-ascii?Q?0l7plfpEhRf289L/pZMzPsfyZJmzWZ+fUpOUKdg+4O4wah5/mzlmoJiPbtXT?=
 =?us-ascii?Q?GqjD1i/Wd/ApXwtNO3NXCDtZhKJDBAyWkUw0HIL5b/FcfoYUao0o/eKUwIqX?=
 =?us-ascii?Q?Ngg+hMQVxXtvoVT35ILYzEaX3QcKtMly3/fuYtfiKkDKmy7nTuh7E2/zx65W?=
 =?us-ascii?Q?0TTIOsCqv/0fXDyMrs4H06eCfc2KrGM1YMKWW0jo32/Qd71zbN/apw2ZXHm3?=
 =?us-ascii?Q?o/xt9i4Q5r8qH9/6nQGugTEpxhML/Hm4t2QL5MUhPZ2o+IWYOaCZZ63BLk1j?=
 =?us-ascii?Q?nayTZLQXWCL7gkMJVHXrP1hZI/TZghKw0q45wdBrJqqB0YGqIt1BBw215qZH?=
 =?us-ascii?Q?kLfqucw64ZffoXwCm4lt5G4uw5CgXT45SLDf/dst3/HLlqouHm+J5IF4rZKx?=
 =?us-ascii?Q?pH8ZXSNp/gNwUHBLMxqxCjYoGAFoZt6GkFScMxPbRALTsPy6mSVGSDdiGy4A?=
 =?us-ascii?Q?yGcWwqrAsVr6U6u8P2EuZtCzvk1B8khc14XT6kGp44IhdXZTOB2l1h5D0IdY?=
 =?us-ascii?Q?m02dahr+K4Pw2UZSYDS6BmCHC7JGeYo1Zhe6/XlHWqi4acyCiovvV+NfsX0X?=
 =?us-ascii?Q?hBjE5LbAYUPKeKam3zJYyiisykYngGTxqc38vzv8GX8n2CS1mAWp/2yv5U3E?=
 =?us-ascii?Q?AErcCzDtGjlWBWB6yFgWS5RdfcInnsiNxJpSrhqIbk2RyAp1Ng+AiQ2qvgzm?=
 =?us-ascii?Q?sk4hYbbaQKvpYP77RgQogp9pth15DOlBq24O2XlF7QrUdDBHB9o+LC3lQysD?=
 =?us-ascii?Q?iE3p1OAV4be758G24Xl762Ixt6FqAKrD+aKAl/6F5UJ/d+ZeP+x6FXX/XcJx?=
 =?us-ascii?Q?m2XjEJW8I9tFWVd3u9vUu3VdKTGKStRzw1hxwDAEIAppoF/ob4Hmfwy3IuhV?=
 =?us-ascii?Q?BzZwuolp6eHy1hmJCWa9Pahvke3guXzsnaWbLismmCq46mCU/ontdyfSMPSa?=
 =?us-ascii?Q?Kmhp7161w547o+5roRjgndIn4hZImEw3dqwTK+HXeH7/OFV7PdE7z6f3hHWO?=
 =?us-ascii?Q?epCy2TkJ+JsGTKbrtNPcQ9huWDlyHgD7AqkSl2bJqBVNtc2EUUDgwRZ8v0WH?=
 =?us-ascii?Q?9/1X66rYZgJjfdAWJud37SeiLi1jmik1CkZvZaPZRCIKGZVhfe9Q3OhCrVlZ?=
 =?us-ascii?Q?Lm6xNTJMOo8cHRZkG7lJiMHNaL45YhAUWRoSbDOxZio8jPq4jqtkXXzZbYNz?=
 =?us-ascii?Q?RByfflIqYVz434QFe8vYFKqd0j+jzlFgPfbxumBbIQKz5KtfDq60bWTAlkqn?=
 =?us-ascii?Q?3MOZf8JpGxLoLDuIPP9UxkmUgjqpsMW1ROe9akQz/RBLNwQltP9vtD0TYHAF?=
 =?us-ascii?Q?6LzXvTHyqRnGh3pluQji8t6i5H3k/+K572OZLuyJaULOxpUlBZTN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8004a53-d2c0-4f03-10d5-08decb0c128e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 18:29:44.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa8D3oEzyvsgyU6WtfxHO0eFXh2oJXesLWdHRDlpNYE0qhhF7UyLZwPt5dKcrDQUWrKWlu9ntH6dtuhOP4YgmxrJzu4RRoSWOpnlUgV7Vxrx8AjY7o28eoDY51D615nU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11508
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11540-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev,amd.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SMW015318:mid,valinux.co.jp:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 495C7689307

On Tue, Jun 16, 2026 at 12:40:55AM +0900, Koichiro Den wrote:
> dw_edma_device_tx_status() uses desc->done_burst to subtract the
> completed byte count from the descriptor size. done_burst is a count of
> completed bursts, not the zero-based index of the last completed burst.
>
> Index desc->burst[] with done_burst - 1. Otherwise tx_status() reads the
> next burst's cumulative transfer size, which under-reports the residue
> and can become a one-past-the-end access when all bursts have completed.
>
> While at it, return early when txstate is NULL and drop the redundant
> desc check after vd2dw_edma_desc(). These are minor clean-ups since
> dma_set_residue() already tolerates a NULL state, and vd2dw_edma_desc()
> is only reached for a valid vdesc.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> @Frank, if you plan to respin 20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com
> and agree with this patch, consider folding this fix into your patch
> when submitting your v3.

Okay, after config and prep pick, I will squash this into above one

Frank
>
>  drivers/dma/dw-edma/dw-edma-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 1c8aef5e03b0..d99b6256660a 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -244,7 +244,7 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
>  		ret = DMA_PAUSED;
>
>  	if (!txstate)
> -		goto ret_residue;
> +		return ret;
>
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  	vd = vchan_find_desc(&chan->vc, cookie);
> @@ -252,12 +252,11 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
>  		desc = vd2dw_edma_desc(vd);
>
>  		residue = desc->alloc_sz;
> -		if (desc && desc->done_burst)
> -			residue -= desc->burst[desc->done_burst].xfer_sz;
> +		if (desc->done_burst)
> +			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
>  	}
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
> -ret_residue:
>  	dma_set_residue(txstate, residue);
>
>  	return ret;
> --
> 2.51.0
>

