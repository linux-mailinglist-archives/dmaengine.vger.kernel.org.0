Return-Path: <dmaengine+bounces-9413-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P+0AJAjs2nMSgAAu9opvQ
	(envelope-from <dmaengine+bounces-9413-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 21:35:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8622794D3
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10352302630F
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4B737B00D;
	Thu, 12 Mar 2026 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fFcfFnyr"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C9373BE0;
	Thu, 12 Mar 2026 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347725; cv=fail; b=IF6szQI7aZpTACJMWBDBZyG3GruwVrznv2n4RVDy00LCynqggJvI4UcmkdAdJrJ/VfL97aeuzxD5oIBNpNZRkeWfEEitx7D5XkKq8f/kQUV8t4pzxfG8TO+tRNBkMIdX4exMDSvI/ALAeG1N5V077AKtyW0wFBFutWOIscVDmws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347725; c=relaxed/simple;
	bh=4bCihLvWXkN8OJLhq+uYT7lEAfuK84tXB0bnNjwtExU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RmYTG+xahEdqtrXc2OKiYmoetlp7x/wfVYo3YeAQdZx7+47Iq9LXainY75S/dczU6InetbrOSbyV7nyXkywfeSY/tVy3BgMUrcKkkY2msEddXLlLR9huhAvMGRRmkSiCFzHHycO+Kp58m1jPGbatvSjeseLPtFY0QGY95603hY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fFcfFnyr; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDhWEc0GxL1oi7sqf6P7SsqraJ9PswWfnq18I4R1nJzp/uQyZqgyUQXlYblQduWlRCctlhnpCnNDZ7VLMhz/yI2/StRnTR7XzQqVSSZdOXrN7tumGdlC85S1HGjdLGUbU6xlUK1Ww6AgOSonjt31CpXurQSG7jBafDob13lNoJuGSozCNtsHBeiF1zI7a2m4hBzCTmb1GXZRBnavL7apfnBE2atT7x3x9cscQjJbhfSsu88vBeYWB9OqJcccT2OgX5Muc3+GP5u09qiSzNbr8KOXlbyin4tvpGre9Q5siuan+Q/tGhdGX1Oab3p8yYDdNmwByn9vsF3NAudsgpY0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bCihLvWXkN8OJLhq+uYT7lEAfuK84tXB0bnNjwtExU=;
 b=UJTb44VbNhy+ymxTUWKMJFyFsSBxkl5071lbhAwCh8DYo4sWiclNYm9axQD3aicF6jv935j0Vr0MBfnEVxEH1MHpwJ+8UeGLxWVbhJ078VHHbaUMoP471Z0qIKlbvzraUZvODcLwFTo2b2zfG+pAOAO0ANvrflVvDsAt+eGrmxrjYFcdMMjoV8sBG2hpZmG5UmMWbUMuQLbX1AimG3zkbyRaGdQlqZS5p4TOfFo4tbokorhYI++1DDKDRZ5plcr8lbNCEBy09Pp+NVaFNUOO8DDQa+QO2NerGIeCKlwVta4zWsTvEPP4emWg+FB69ppYQ3VlQLyq4lAcR5UbCWEt6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bCihLvWXkN8OJLhq+uYT7lEAfuK84tXB0bnNjwtExU=;
 b=fFcfFnyrmJfGqnBfhf6IB3+SGcUeXZXSKfegTgF1lWd3Gdv94GhDzFL7dEq0nZHfw880GNdT0ulOMbGy4tlE0JsYQHsKtioyvbw0lHgdaFgqVC9Svi9oua8lCsk75SKEUddr413uC35w+mjINJYYdeHj4VaP8X2KZ08ljZm8od1mIm5dzmpUqmu3u/Qik6XQW82Xko5iI9d4NiCK7gCJ4JKW7kdcEgRht3g9dt9IdAj7fKpLicZTYaf4pV3cBlL8bnLsPtmsBSNs+iFXQZF+kBU9cDFpnoRS8KseX8+AdDqM2Khl4dBum7I5KMczpdVjzHkm08JPMisRwv9EyRFV3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8782.eurprd04.prod.outlook.com (2603:10a6:102:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 20:35:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 20:35:18 +0000
Date: Thu, 12 Mar 2026 16:35:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 06/15] PCI: endpoint: pci-epf-vntb: Fold MW runtime state
 into a struct
Message-ID: <abMjf6Y9o5kahSsm@lizhi-Precision-Tower-5810>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312165005.1148676-7-den@valinux.co.jp>
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: d04ff3a1-2f98-4d15-5981-08de8076dfbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|19092799006|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Q8anZvyAI47jfjUDCSBLMtxbxSY+ymC3wBExa8UprEWa0Pe5xe79gWqsClSTXqTbDAWuSSOUTJ9TsNfwJB9YOJdiI5Kqjd/8uyMUNgyMNvmpiuYWhrL2/z6otFg8XISoMTDyxLrl3x9IB3VO6wnyMIp7i+oIU1YpTcHSoy2a65UvRc7bUhGRj8qjyGMfXNVERDtFrFCZvXMxMJQbdU68W6jXMuL5ySi8IDLTx/PszrXFq06rzCfzmnBJsaLrweqf+l5rTgtiMpOHB37e1OE/rupY2iRYwaLxLDY5JnHvCLtQSHNA9281PO3ggZ3RHQf+dyaKw1uGuS2a4hHeBeecjIQs7Fn698TQPR4n+Ua7VhqT3bVrT7q9y41kcHkeGyWZk8vAXj+vYqUtjzuFKMtMs8svIhEKVBJUJNU4RC6wuM+moo8Pw8tbCNuCcL3ZBnsNtg1SLlKaKUyZh4bhjTOBuRG34Fp6WIAIvDhFvwHfW5WgKYwZu3mNg6ZcngrJ9mHcINT7uDMTkDM+T2ceg6QgB6c36tDE7B04w6dXx0xmgh8DqWtl3JROOVNc3KTWYqSCsoYKBDks5wdYU8xUgwaCs374QluHBWRNsTcU/7YoXgB7SLDssuacJe2Acj/fo35H1KYFfmv5fHS00FQ0AR3gxWnEBCTOLVP7huJ2F9/6Sfw+f2oUbrI9jHS52P40K24PpmVT2RULOkNfK2sOxzDw6tK99XHWyjdu3y1uiGVhE1fp/eLNWch4sJvG+eubu0Mzs1afZN2EjeBnRTMJdVnZgJ4hPTA6tbu/NQMM4E/+XiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(19092799006)(366016)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v4QD04jFtFP/rZFHoGXeH6tDz7AwDAHP/8labObPwmVJrs+Pe0AY++n72x4f?=
 =?us-ascii?Q?z4+C719a/yPC4TnBy+4bZuat2XNoQRxFWQxIB1wtrsylTLjGBPkuFqqB2nho?=
 =?us-ascii?Q?lv9i0JX6icZQyP3CtcBUPLzrlwTzdTC1X9T7TusklKNRcLPwp+Bug/+IwFtn?=
 =?us-ascii?Q?7c3i8mxbko/W8QBRYqmVr4FL+oNKK/w+OSOo1Z42Xb9j4NfJMHg4P9kAHmvL?=
 =?us-ascii?Q?k5bkGpZxJTWwTKiZIwjDQjMKWj6ORouM+jaW4hKIWcngu+d0+ZRv34Hd4z5s?=
 =?us-ascii?Q?pCXUGvFXy0m4QL7O0WkAdZhyMI9XnAPBT7H5Dysyy3kxpPVE5YAHayp8TZ4V?=
 =?us-ascii?Q?Pm0XP5E3ccAKltghQgYIpUgulbqLxTCG/PaKhOPL2PuaL0MrztrDpcmM0G8t?=
 =?us-ascii?Q?auIzsri5EizrtpaVef0Wj2MxnjM5BACabfdJdSaoz6mslc1m4HXBB1U+590Q?=
 =?us-ascii?Q?XG7fkKACGJrxNR57BvxIRSykQOVG9wO/zwyIR/sbzUD6vzGfijwZ+uUV1KX6?=
 =?us-ascii?Q?j9PtH4Q75XP8EBufgYHqCTuCW7sbuz/DFP0lHipxUNjGbc6y1TZNbuHczNLP?=
 =?us-ascii?Q?sre35+hTLdk6JzZwCh7g3vNBfxVi0r3WXX7JrzKJCKCfN5m3IPd50jBTX5nf?=
 =?us-ascii?Q?CO/JrlxlDiyUqNcfuKUY74YKqbMsKU434mAbOWHyBMbSov94H4wpXkjjGL4b?=
 =?us-ascii?Q?DuTddvIAhwUBjUTXl8YmozhwXUPFjWffEdoCow21PxPE/GUG8Fd0byIXcdn3?=
 =?us-ascii?Q?svSUnFiQXhU7uHS+I9q1M6BbglZOEmWCX7nBs8xjT+XF/lidKyGTNNmdQr1j?=
 =?us-ascii?Q?tJE55Bd1SpzdNEUGemrDKrOXDjBecm/BNsf/LcBhyPd2xpgFmeSzINRKz96c?=
 =?us-ascii?Q?qO5WcclPOzTEij3aVOWtE6FefbytgRQU5XOPnDnXTVOm/qJTRsIfns1G7+M/?=
 =?us-ascii?Q?LU6n9lsfYqOv9621kifhW9e8/P4ALYl+xqhbp7tFdUtD13j7QPLm7ODUPk0/?=
 =?us-ascii?Q?99QNs/suTsXHcsqw/TxOeQcthnxSSo7WlJvass5H5E6imExG7YmLrg4LBnF+?=
 =?us-ascii?Q?fxSfKjSG+qt7PJHe3tesuOdKKsrXaduiydrHDsA6L/czztRDBoQMqt5GJ855?=
 =?us-ascii?Q?yHlahjYvElQegBubZi8SWy4jPdi3a++kmzjXsmZr3Fn3z52ONREDos/JwVo0?=
 =?us-ascii?Q?YhUULuahK+72ECXlZuZ5mGLxVs5gGMIV1CTYHbqHvyrY8iVL3mg5wCQJ0/f7?=
 =?us-ascii?Q?YzjUcjGF3cjSlUOBW0QjLVtEOzFjz4FCaAD5dFFxuqygatDeuapg864sWonM?=
 =?us-ascii?Q?mxikR4EkQwaGoqy5hVW8Iyt9znODoShBK7OVydNAbsJYYsq2gDKS4DzzX8h4?=
 =?us-ascii?Q?7Xb63kyPWOwFH2UrYNzEG2G2oXjMwGidAcEe3/wTtZH1he7kVPgAp69VllsW?=
 =?us-ascii?Q?E96LmUukrocwOT3FkOQWwqusQgHN82uQ94YzE6uLYK3XHKryVsukKdU0LO4O?=
 =?us-ascii?Q?kZmI9rffBrJolrOmnbURtgv1XSSCns2apuEA/Q/laMbG4gOrrDmGQSnZvkmx?=
 =?us-ascii?Q?r0bvM/h8d+7VBGAb9HM/HZi2Lk8W/QyswAwRAq8I0ULAb0cZf7L6n2L+NMSG?=
 =?us-ascii?Q?v6bSpGADEnCNHB7anp/sSV3tjMPYEs7esYM/GAfJ1H0BK+N/AOGyu3FcNUj0?=
 =?us-ascii?Q?6gBfJFzwxQRZ6lQLmIBKUjhtYLiugzGeoX9o/tCy1OGTmoiR5rj8/w73/cul?=
 =?us-ascii?Q?1pjkRmiCZQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04ff3a1-2f98-4d15-5981-08de8076dfbe
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:35:18.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcjX6jbgH6Fy/3YvYvJzh+gLZ7n/Pi2vqm7rSnkld/5IimAht5KtqsVcIVLbCMXxePEjY/fjWRzM6xV8HiDSMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8782
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9413-lists,dmaengine=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 9E8622794D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:49:56AM +0900, Koichiro Den wrote:
> The next patches add per-memory-window offsets, shared BAR placement,
> and optional DMA export state. Keeping per-window state in parallel
> arrays would make that work noisy and error-prone.
>
> Group the runtime memory-window state into struct epf_ntb_mw so
> follow-up changes can extend a single object instead of touching
> multiple arrays.

Simple said

PCI: endpoint: pci-epf-vntb: collect MW information into a struct

Group the runtime memory window state into struct epf_ntb_mw to improve
readability and make the code easier to extend.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>

