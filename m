Return-Path: <dmaengine+bounces-11345-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H1BaFwozKGrw/wIAu9opvQ
	(envelope-from <dmaengine+bounces-11345-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 17:36:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0205F661D24
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 17:36:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bMfZJQuT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11345-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11345-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0418130997BB
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8844921AA;
	Tue,  9 Jun 2026 15:13:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26348B380;
	Tue,  9 Jun 2026 15:13:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018003; cv=fail; b=PMG5VSFdn5ylbf+0vljZjSq23hQR9O21a92Gavmxp8UBAUs6wE3uQAXmKwIWsiQPPaBPJIRSmUYt9jOYbv3vA6XutxWUa/428z3UWFR1N5KRR1djCILZ0SxYnqrZe7LvbZApNlOWlmWXCNhZy+y5IQIROP7v+96h4aWg8KUxm6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018003; c=relaxed/simple;
	bh=q6qRGrKlFrXKmYzJRk/NDb6SJ50GypkuqHo1nqlfUZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BvRqm7ZNY4LmNu5qhIFMh7B8G9dsJAMfW9gkyCMCsETfGytx6Q6cX99Ab547v9BEoyJCRM+QhI0tteF1keLiOF3xU948uBSCgG0T4afWuZexN30xB8t42n60ALg0tNpAG0SD3atYLGEGNLH/7z05R5jvDKwP4n3b3kgdRhaU7p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bMfZJQuT; arc=fail smtp.client-ip=52.101.84.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JF7KdiV4Yx9NqIzOlwm+2pU7VMwmkFT1RWEVppVQDRIH6/ozOLkUucPvlxCkrr+L4gFWsLuigPOalqaBOGBic6jLJCdLAYgExktIreNB3BZW/kCa6G0ZfsSiZum6CuPmeSdNYBowpfhAkCUenvDY9MLYFucfa07VLlng/AVPTScrMi229tYq9vn87aoo0/ZdtXrI7l2233uGTgEvk/+uPVQ4o6KAhoz2DATYMcLNt5GIYKxAK7+O7GAhSI6eBcxNA1gD7RZoV+eHQst8flImkZOhNCbceaiGLq7MBvFKjxRaUm31srgnSve/1P4Be1E4xiyZRhUk0EKDoTJ+mFfDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWStS1XKfjvjbZiLxdzUC5+zvOVvEd3XyPu5XlZgRVU=;
 b=WVCwGGMzGmXWGhvvAi4Lv/P8FoVOqD6wg/n1eyR9n+Ak2X/ctuMuE9BlrRLRfntelZvZEIf4yxXa/b+6kRXrIiOGEH8gP3fBvQRC/SbZSKH9eo4VktXT52WQg/7NPgzSruRUlE4IygdXktn64zpem5B13HTZc8J5NLhh08KOtbL8MDOZ55CvTZbpbR/53hyQG+U2K05KtUhjG5dLiM/b41HcJ4b8lyuepGZHC5vPaFNdFJ/SZhwY6K4uoOCqOLnqmh4OcfHd6IoySXxAAxSMx4SChmNUUeq9U5STFp2cUVSHrKqJDvQBgEhBNnpDEWUDUboxqH9zV8AVmCDIz0piJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWStS1XKfjvjbZiLxdzUC5+zvOVvEd3XyPu5XlZgRVU=;
 b=bMfZJQuTFneN5KhhGi+8TdqzHYsfzWWZgHFRdHB+xchx+viK0M4AtjmqsJn0D0gbdBhbrjbYvzJggaHzh1ph2EjpA314JhNKvUJmdHStQHD6aZ6oww/KXZ0k04YIYlD0zSoAIoySQLrFTzLZ0OMXi+kZX+6cxVCEUyc0KxqVz1AHpYMZ3Ybdd7qXDGiAR8F7Wxo6YLAz/p2yVMgX1cU3wSejiT663py2cFHNnHxwI9yl5nkdvSTQFpkv13W+BIKP+4+xM3Gc01Oyiz2Y83rmckc6pGJdG7txt2nmfu0zib8V2PvqVes4AaQKqf+B8KNOQZoTbr4U8KG0Aa0u83i9Kg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUZPR04MB9898.eurprd04.prod.outlook.com (2603:10a6:10:4d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 15:13:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:13:05 +0000
Date: Tue, 9 Jun 2026 10:12:54 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.li@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link
 entry during dma engine running
Message-ID: <aigtdhkKv4y5D0eu@SMW015318>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
 <24a5wo2ncgf7d43mxbv6pacvqkzmiuo4bvuyygfeyoq4lbdt25@kqw4cx7xzrfu>
 <aiMWmI8QMddHUzL5@lizhi-Precision-Tower-5810>
 <w7fwh4ztgg5svpfqrfvw43kvfznrzn6gystacaq6sbf6zuqwge@ccj4rau7p3hy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w7fwh4ztgg5svpfqrfvw43kvfznrzn6gystacaq6sbf6zuqwge@ccj4rau7p3hy>
X-ClientProxiedBy: PH7P221CA0054.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUZPR04MB9898:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1c0747-9a7f-4431-19c1-08dec6399b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|19092799006|6133799003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	VU25g+2sXFg9OGYpI++k2k/RdAp5cstoimhThqBZLpd6VIoLFEZw9AhKZEB0dz/+Zv6EeC7XXE2DJYnFJFcKcBgiS6I6iuMGTAUqpx2iBQkTCdvKoJtrY60E3PLZylBranaHEm/XJbr4PaHIEYfIdMhGwocvCd3EQFFbIeaRHSSpVzGTC9iLEupq5IUaU1Dou5WLlLRowVEvnzrQKqRzdw5p2/bJJfLAzg5nFLqFnmIGM2LqK5ttHtNi41nRMkw7DzjpGiJ1NWniQEG2+eDEa8/P9oAlOXtvUxGjG9evF/mglra4pddQYm+4zyam7hPLAwvHiQRKEpmOOSKeJU5RQgoyD6lnYJ0uTUqvLaCkJWeu0U35XdEi5GgDv2Q6C+ZgSDJW80GsQwEoe/tdoifvZ2ddlJJvTWc0egv7om4MK2YgTXyDHDRKIvuXm0hpLtAhMe0CsoAD9vXE+iWDYFSuwQ4Km34GeowgSPwr6Gr8T3+73QN4RaH7yRdfq0AL7xSY1LXF5aA1LDCmgdzwUIYTMk17Eooio80ljM/BAIB0Mg/a2VZnAJKOPPRIUOHMrHz/q9UUO6VjQDSOH5PwJRUBjksN3kxVvGPhJwKa1sfhJTQI9qqk4qdti6m3zzKbWbB6Vyr2OHPRJOXcgSylC67piQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(19092799006)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?am8okOewYhJ9XCyS+3k0WLAqukij11LUD351sKAuubuWziGXHt41vD+pf6PH?=
 =?us-ascii?Q?lLJ7eE73DdUOCXqXOpsjRmLoi19jb8VMjrqdDw5lTJK9mw8EKZ0Zoa1D53A5?=
 =?us-ascii?Q?vAvc7yTG1l+FJV9J6SIO/maL97aUbIoBGX/3TZB8iUAl/U6qWIvXMarwQt4s?=
 =?us-ascii?Q?hnre0ehY1+aPXKNn82WArvrlPrUm2PDaurN7fy7W5i2UFdg1YDwU4kq2/mHL?=
 =?us-ascii?Q?oW7FK4T1UbrDfm1IseITjTFlcMVjVgWSTEE0cl9ziMDYQleaxFXRdJC2kwgX?=
 =?us-ascii?Q?0XHgugpsDyfW6w9OthKFQPlTP7a4CPfDLQXUchtXCaNuy9hMbPKnG0rwkCnu?=
 =?us-ascii?Q?4Q4H+6afpR/qzv4ipAIMbzD1s/Z7Vb3uM7N4wVf/d4WOsyh76PSwqfCZ/T+o?=
 =?us-ascii?Q?xbi24P4amUmjQAMZO2R4ECK5jWijwxWGJNbAWrkr/a4vbQTAEBKe6/DfDnIF?=
 =?us-ascii?Q?xoZyVu5uCSCyuarguxqSAnXHZu8pj/xdAaItArCw4vgjt36rlx4gSH5Tq6Hk?=
 =?us-ascii?Q?iOYdKHzd1uit3bZf52mIS07+XWYphCYnFiDK0W89CSBnXfrzEdWH6740gHQO?=
 =?us-ascii?Q?8s1b1Qxq5vWjmc/NJiAEbvZsHEIhGx41Pbjq4NWJUbw2OHnCxNd7pLzkPZLU?=
 =?us-ascii?Q?oNtAmfzyaSvxMiH18WZn6mM7TWFq8eaZR+WUHqrQq9/L5obX3sMCpZTQBSrq?=
 =?us-ascii?Q?ZIQsluazAqXR63XTckg9kGqFFF5vJlX25/hm3Qw4FBFDqVROn3PXtQNOXywW?=
 =?us-ascii?Q?9gJe7rp5OZEZ0WZeLhZ3+mFAfK+qQ4xaZ26zlSBpLxBpAtRUltOXYFwUO4Nc?=
 =?us-ascii?Q?SBjB10Jc6Bjj39BQFggthlPYBW9qmrJJYy1y7V0HC6uA320ZTvA9qUs5489y?=
 =?us-ascii?Q?JOtIymvOxCyh8ymnsK27fLLaOvrtn2oVAV9A9SzPwsRGdKY+oTRYQElnrFEp?=
 =?us-ascii?Q?0E3iY9mAz45dqeII6xT+vJqRxQGddHh+erF6BXAYCftdBC7sZA+Cg9Bqvbd4?=
 =?us-ascii?Q?TNzbuSN4AAgavEVcz61lUG+eAK0RmKhNyHhPEDItGeUWgWAj59xbJb+T4h8P?=
 =?us-ascii?Q?kyEtt6MxPb3wo60+oN3yc6zaZDoPZjTsVCb2hT89B6nxe2u54qI48dsIFoDK?=
 =?us-ascii?Q?JgOfulBupzylyQfOBbTj0UxEmV0M1b/j2k9x6Ift9hxXDbRQBilmPQ1Omnu1?=
 =?us-ascii?Q?0eeLqtP16Fm/xpP5dRMOzQd/j8gT7JkSMl2TkveEHIbVzdMzK7TmXot+Kucd?=
 =?us-ascii?Q?l6URiBi4bUxvGr7+KsDXX7VQkdoPUR5CfQ6CSv0tZBKM+Ekqa2fQFoCjA94h?=
 =?us-ascii?Q?/M0HSeFwv0eFpiMnCBDTKLGZOUiBQjB6f4coMdfPJwEFxvkfg8RrObqysYxY?=
 =?us-ascii?Q?tpRUZTSpzqCexfpj07G8qe3mTHvf74wvKvld9e8Zbi2iORD1xogcy/noxQs3?=
 =?us-ascii?Q?GGt912eGVR3fKNRwydppGuSA53blsY1Wepy/SXirds0sTiFDQ0iDK2JfiYMD?=
 =?us-ascii?Q?+pFSPjLK0b2uXs1eV1NKUNTHBjusmXLOa46pzs+n4vS3TKBprmIN72+rXXvu?=
 =?us-ascii?Q?Uw/msc5tNvO4kbkcTrz+u0aGeivEaLpHDPTbAb1xP20SngjQGJ2TsR6m5UK4?=
 =?us-ascii?Q?hRHN994fZEfumKj+Q3E1oPX8cuQ/twa3OxpFMFFmEj9iLsHngGXVcIBinuq9?=
 =?us-ascii?Q?FLXxekdfjZV2WUE1DMulLDmhDcC08EVcQs6cR1ZlPgZStV7X6S0wSguKFfXS?=
 =?us-ascii?Q?zZ077xTAMvtDQFrHKrnbTtylqQXWAKOGNs2TuC1iJgqT0WuMlC/7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1c0747-9a7f-4431-19c1-08dec6399b53
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:13:05.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QasI9B2ukVwGPLJ+/56bob98vzDcutjdIbqmOkM5xlK3GHbUqiVXiOtyhpbrPyF9mOLubli5+ckJrSR3VQ3SHFCzosWsaeNG5eReHlaFwdlWNJBTo+7TMIuei8iFMA5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9898
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:Frank.li@nxp.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dlemoal@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11345-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0205F661D24

On Tue, Jun 09, 2026 at 03:23:03PM +0900, Koichiro Den wrote:
> On Fri, Jun 05, 2026 at 02:34:00PM -0400, Frank Li wrote:
> > On Thu, Jun 04, 2026 at 04:08:06PM +0900, Koichiro Den wrote:
> > > On Fri, Jan 09, 2026 at 03:13:24PM -0500, Frank Li wrote:
> > > > Patch depend on
> > > > https://lore.kernel.org/imx/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/T/#t
> > > >
> > > > Only test eDMA, have not tested HDMA.
> > >
> > > Hi Frank,
> > >
> > > I expect this series may be revisited in the near future, since the first
> > > dependency series reached v7 and looks close to landing.
> > >
> > > With the latest versions of the two dependencies:
> > >   - [PATCH v7 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
> > >     https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/
> > >   - [PATCH v2 00/11] dmaengine: dw-edma: flatten desc structions and simple code
> > >     https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/
> > >
> > > I tested this RFT series with the HDMA engine on a SpacemiT K3.
> > > The test results are below, using the same format as your results:
> > >
> > >   Baseline, before applying the three series (v7 + v2 + this RFT)
> > >
> > >     Rnd read ,     4KB, QD=1 , 1 job :  IOPS=8567, BW=33.5MiB/s (35.1MB/s)
> > >     Rnd read ,     4KB, QD=32, 1 job :  IOPS=55.5k, BW=217MiB/s (227MB/s)
> > >     Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=83.0k, BW=324MiB/s (340MB/s)
> > >     Rnd read ,   128KB, QD=1 , 1 job :  IOPS=3817, BW=477MiB/s (500MB/s)
> > >     Rnd read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1346MiB/s (1411MB/s)
> > >     Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=11.2k, BW=1403MiB/s (1471MB/s)
> > >     Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1515, BW=758MiB/s (794MB/s)
> > >     Rnd read ,   512KB, QD=32, 1 job :  IOPS=2795, BW=1399MiB/s (1467MB/s)
> > >     Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=2795, BW=1404MiB/s (1472MB/s)
> > >     Rnd write,     4KB, QD=1 , 1 job :  IOPS=9035, BW=35.3MiB/s (37.0MB/s)
> > >     Rnd write,     4KB, QD=32, 1 job :  IOPS=38.3k, BW=149MiB/s (157MB/s)
> > >     Rnd write,     4KB, QD=32, 4 jobs:  IOPS=41.8k, BW=163MiB/s (171MB/s)
> > >     Rnd write,   128KB, QD=1 , 1 job :  IOPS=3969, BW=496MiB/s (520MB/s)
> > >     Rnd write,   128KB, QD=32, 1 job :  IOPS=8260, BW=1033MiB/s (1083MB/s)
> > >     Rnd write,   128KB, QD=32, 4 jobs:  IOPS=8295, BW=1038MiB/s (1089MB/s)
> > >     Seq read ,   128KB, QD=1 , 1 job :  IOPS=4609, BW=576MiB/s (604MB/s)
> > >     Seq read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1345MiB/s (1410MB/s)
> > >     Seq read ,   512KB, QD=1 , 1 job :  IOPS=1524, BW=762MiB/s (799MB/s)
> > >     Seq read ,   512KB, QD=32, 1 job :  IOPS=2799, BW=1401MiB/s (1469MB/s)
> > >     Seq read ,     1MB, QD=32, 1 job :  IOPS=1401, BW=1404MiB/s (1472MB/s)
> > >     Seq write,   128KB, QD=1 , 1 job :  IOPS=3722, BW=465MiB/s (488MB/s)
> > >     Seq write,   128KB, QD=32, 1 job :  IOPS=8246, BW=1031MiB/s (1081MB/s)
> > >     Seq write,   512KB, QD=1 , 1 job :  IOPS=1283, BW=642MiB/s (673MB/s)
> > >     Seq write,   512KB, QD=32, 1 job :  IOPS=2072, BW=1038MiB/s (1088MB/s)
> > >     Seq write,     1MB, QD=32, 1 job :  IOPS=1037, BW=1040MiB/s (1091MB/s)
> > >     Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1540, BW=768MiB/s (805MB/s)
> > >      IOPS=1549, BW=768MiB/s (805MB/s)
> > >
> > >   After your three series (v7 + v2 + this)
> > >
> > >     Rnd read ,     4KB, QD=1 , 1 job :  IOPS=7216, BW=28.2MiB/s (29.6MB/s)
> > >     Rnd read ,     4KB, QD=32, 1 job :  IOPS=61.1k, BW=239MiB/s (250MB/s)
> > >     Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=75.3k, BW=294MiB/s (309MB/s)
> > >     Rnd read ,   128KB, QD=1 , 1 job :  IOPS=4711, BW=589MiB/s (618MB/s)
> > >     Rnd read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1354MiB/s (1420MB/s)
> > >     Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=11.2k, BW=1403MiB/s (1471MB/s)
> > >     Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1497, BW=749MiB/s (785MB/s)
> > >     Rnd read ,   512KB, QD=32, 1 job :  IOPS=2802, BW=1403MiB/s (1471MB/s)
> > >     Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=2798, BW=1405MiB/s (1474MB/s)
> > >     Rnd write,     4KB, QD=1 , 1 job :  IOPS=7411, BW=29.0MiB/s (30.4MB/s)
> > >     Rnd write,     4KB, QD=32, 1 job :  IOPS=39.3k, BW=153MiB/s (161MB/s)
> > >     Rnd write,     4KB, QD=32, 4 jobs:  IOPS=42.9k, BW=167MiB/s (176MB/s)
> > >     Rnd write,   128KB, QD=1 , 1 job :  IOPS=3736, BW=467MiB/s (490MB/s)
> > >     Rnd write,   128KB, QD=32, 1 job :  IOPS=8302, BW=1038MiB/s (1089MB/s)
> > >     Rnd write,   128KB, QD=32, 4 jobs:  IOPS=8314, BW=1041MiB/s (1091MB/s)
> > >     Seq read ,   128KB, QD=1 , 1 job :  IOPS=4092, BW=512MiB/s (536MB/s)
> > >     Seq read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1354MiB/s (1420MB/s)
> > >     Seq read ,   512KB, QD=1 , 1 job :  IOPS=1474, BW=737MiB/s (773MB/s)
> > >     Seq read ,   512KB, QD=32, 1 job :  IOPS=2794, BW=1399MiB/s (1467MB/s)
> > >     Seq read ,     1MB, QD=32, 1 job :  IOPS=1401, BW=1404MiB/s (1472MB/s)
> > >     Seq write,   128KB, QD=1 , 1 job :  IOPS=4135, BW=517MiB/s (542MB/s)
> > >     Seq write,   128KB, QD=32, 1 job :  IOPS=8307, BW=1039MiB/s (1089MB/s)
> > >     Seq write,   512KB, QD=1 , 1 job :  IOPS=1259, BW=630MiB/s (660MB/s)
> > >     Seq write,   512KB, QD=32, 1 job :  IOPS=2073, BW=1038MiB/s (1089MB/s)
> > >     Seq write,     1MB, QD=32, 1 job :  IOPS=1034, BW=1038MiB/s (1088MB/s)
> > >     Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1531, BW=763MiB/s (801MB/s)
> > >      IOPS=1540, BW=765MiB/s (802MB/s)
>
> This was false. I cleaned up my test environment and retested your three series
> again. It seems that the test cannot even run properly. Sorry for the confusion.
> (Note that the other results, i.e. "Baseline" and "use of HDMA watermark
> interrupts", were re-verified.)
>
> So I looked into why this RFT series does not work well with HDMA. My current
> understanding is that HDMA dynamic append needs watermark interrupts from the
> beginnning.
>
> The PCI Express DMA Controller Databook (6.10a-lca06), Table 7-3 Channel Context
> Register Considerations, says that while the channel is RUNNING, HDMA updates
> HDMA_LLP_* only when a watermark interrupt event occurs. It also says that
> software can use watermark interrupts to obtain the current transfer location
> and recycle descriptors up to the LLP value.
>
> So, without watermark interrupts, I do not think HDMA_LLP_* polling from
> software gives us a reliable/valid running progress point for cookie completion.
> The only conservative completion point left is the STOP interrupt (i.e. the
> current base model).
>
> However, with "dynamic append", software keeps recycling/refilling the ring, so
> the channel may continue running and the STOP interrupt can be delayed
> indefinitely. In that case, DMA cookies are not completed in time, which leads
> to dma_sync_wait() timeouts on my HDMA setup.
>
> Therefore, now I do not think the current STOP-interrupt-only model is suitable
> for HDMA dynamic append. If no objections, I will submit a reworked version of
> this RFT series that keeps many of your original changes, but enables and uses
> HDMA watermark interrupts for the HDMA dynamic-append path.

Okay, thanks! I have not hardware to test HDMA. EDMA actually have some
risk condition when dynamic-append. I report the problem synosis, but not
get feedback.

Frank

>
> Best regards,
> Koichiro
>
> > >
> > > On this HDMA setup, I did not observe a clear performance difference from
> > > applying the three series alone. Still, I like the overall direction.
> > >
> > >
> > > P.S.
> > > Separately, as a follow-up experiment, I also prototyped an extra series on top
> > > of your three series that allows us to make use of HDMA watermark interrupts.
> > > With that series, in particular for the high queue-depth cases, the results
> > > improved noticeably on this platform. I haven't posted that series yet though.
> >
> > Thanks for test it. I am monitor above recondition patch set.
> >
> > Frank
> > >
> > >   After your three series (v7 + v2 + this) + use of HDMA watermark interrupts
> > >
> > >     Rnd read ,     4KB, QD=1 , 1 job :  IOPS=8016, BW=31.3MiB/s (32.8MB/s)
> > >     Rnd read ,     4KB, QD=32, 1 job :  IOPS=63.4k, BW=248MiB/s (260MB/s)
> > >     Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=92.7k, BW=362MiB/s (380MB/s)
> > >     Rnd read ,   128KB, QD=1 , 1 job :  IOPS=3530, BW=441MiB/s (463MB/s)
> > >     Rnd read ,   128KB, QD=32, 1 job :  IOPS=12.0k, BW=1500MiB/s (1573MB/s)
> > >     Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=12.4k, BW=1555MiB/s (1631MB/s)
> > >     Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1541, BW=771MiB/s (808MB/s)
> > >     Rnd read ,   512KB, QD=32, 1 job :  IOPS=3116, BW=1560MiB/s (1636MB/s)
> > >     Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=3099, BW=1556MiB/s (1632MB/s)
> > >     Rnd write,     4KB, QD=1 , 1 job :  IOPS=8748, BW=34.2MiB/s (35.8MB/s)
> > >     Rnd write,     4KB, QD=32, 1 job :  IOPS=57.6k, BW=225MiB/s (236MB/s)
> > >     Rnd write,     4KB, QD=32, 4 jobs:  IOPS=80.3k, BW=314MiB/s (329MB/s)
> > >     Rnd write,   128KB, QD=1 , 1 job :  IOPS=3878, BW=485MiB/s (508MB/s)
> > >     Rnd write,   128KB, QD=32, 1 job :  IOPS=9798, BW=1225MiB/s (1285MB/s)
> > >     Rnd write,   128KB, QD=32, 4 jobs:  IOPS=9970, BW=1248MiB/s (1308MB/s)
> > >     Seq read ,   128KB, QD=1 , 1 job :  IOPS=4516, BW=565MiB/s (592MB/s)
> > >     Seq read ,   128KB, QD=32, 1 job :  IOPS=12.0k, BW=1497MiB/s (1570MB/s)
> > >     Seq read ,   512KB, QD=1 , 1 job :  IOPS=1571, BW=786MiB/s (824MB/s)
> > >     Seq read ,   512KB, QD=32, 1 job :  IOPS=3073, BW=1538MiB/s (1613MB/s)
> > >     Seq read ,     1MB, QD=32, 1 job :  IOPS=1573, BW=1576MiB/s (1653MB/s)
> > >     Seq write,   128KB, QD=1 , 1 job :  IOPS=3977, BW=497MiB/s (521MB/s)
> > >     Seq write,   128KB, QD=32, 1 job :  IOPS=9806, BW=1226MiB/s (1286MB/s)
> > >     Seq write,   512KB, QD=1 , 1 job :  IOPS=1404, BW=702MiB/s (736MB/s)
> > >     Seq write,   512KB, QD=32, 1 job :  IOPS=2496, BW=1250MiB/s (1310MB/s)
> > >     Seq write,     1MB, QD=32, 1 job :  IOPS=1252, BW=1256MiB/s (1317MB/s)
> > >     Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1682, BW=836MiB/s (877MB/s)
> > >      IOPS=1688, BW=838MiB/s (879MB/s)
> > >
> > > Best regards,
> > > Koichiro
> > >
> > > > Corn case have not tested, such as pause/resume transfer.
> > > >
> > > > Before
> > > >
> > > >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
> > > >   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> > > >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> > > >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
> > > >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
> > > >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
> > > >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
> > > >   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
> > > >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> > > >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
> > > >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
> > > >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
> > > >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
> > > >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
> > > >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
> > > >   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
> > > >   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
> > > >   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
> > > >   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
> > > >   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
> > > >   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
> > > >   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
> > > >   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
> > > >   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
> > > >   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
> > > >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
> > > >    IOPS=266, BW=135MiB/s (141MB/s)
> > > >
> > > > After
> > > >
> > > >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6148, BW=24.0MiB/s (25.2MB/s)
> > > >   Rnd read,    4KB, QD=32, 1 job :  IOPS=29.4k, BW=115MiB/s (121MB/s)
> > > >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
> > > >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=859, BW=107MiB/s (113MB/s)
> > > >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1504, BW=188MiB/s (197MB/s)
> > > >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1531, BW=191MiB/s (201MB/s)
> > > >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=238, BW=119MiB/s (125MB/s)
> > > >   Rnd read,  512KB, QD=32, 1 job :  IOPS=390, BW=195MiB/s (205MB/s)
> > > >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=404, BW=202MiB/s (212MB/s)
> > > >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=5801, BW=22.7MiB/s (23.8MB/s)
> > > >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.6MiB/s (101MB/s)
> > > >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=32.7k, BW=128MiB/s (134MB/s)
> > > >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=744, BW=93.1MiB/s (97.6MB/s)
> > > >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1278, BW=160MiB/s (168MB/s)
> > > >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1278, BW=160MiB/s (168MB/s)
> > > >   Seq read,  128KB,  QD=1, 1 job :  IOPS=853, BW=107MiB/s (112MB/s)
> > > >   Seq read,  128KB, QD=32, 1 job :  IOPS=1511, BW=189MiB/s (198MB/s)
> > > >   Seq read,  512KB,  QD=1, 1 job :  IOPS=240, BW=120MiB/s (126MB/s)
> > > >   Seq read,  512KB, QD=32, 1 job :  IOPS=386, BW=193MiB/s (203MB/s)
> > > >   Seq read,    1MB, QD=32, 1 job :  IOPS=200, BW=201MiB/s (211MB/s)
> > > >   Seq write, 128KB,  QD=1, 1 job :  IOPS=749, BW=93.7MiB/s (98.3MB/s)
> > > >   Seq write, 128KB, QD=32, 1 job :  IOPS=1266, BW=158MiB/s (166MB/s)
> > > >   Seq write, 512KB,  QD=1, 1 job :  IOPS=198, BW=99.0MiB/s (104MB/s)
> > > >   Seq write, 512KB, QD=32, 1 job :  IOPS=352, BW=176MiB/s (185MB/s)
> > > >   Seq write,   1MB, QD=32, 1 job :  IOPS=184, BW=184MiB/s (193MB/s)
> > > >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=287, BW=145MiB/s (152MB/s)
> > > >  IOPS=299, BW=149MiB/s (156MB/s)
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > Frank Li (5):
> > > >       dmaengine: dw-edma: Add dw_edma_core_ll_cur_idx() to get completed link entry pos
> > > >       dmaengine: dw-edma: Move dw_hdma_set_callback_result() up
> > > >       dmaengine: dw-edma: Make DMA link list work as a circular buffer
> > > >       dmaengine: dw-edma: Dynamitc append new request during dmaengine running
> > > >       dmaengine: dw-edma: Add trace support
> > > >
> > > >  drivers/dma/dw-edma/Makefile          |   3 +
> > > >  drivers/dma/dw-edma/dw-edma-core.c    | 215 ++++++++++++++++++++++++----------
> > > >  drivers/dma/dw-edma/dw-edma-core.h    |  42 ++++++-
> > > >  drivers/dma/dw-edma/dw-edma-trace.c   |   4 +
> > > >  drivers/dma/dw-edma/dw-edma-trace.h   | 150 ++++++++++++++++++++++++
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c |  39 +++++-
> > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c |  17 +++
> > > >  7 files changed, 409 insertions(+), 61 deletions(-)
> > > > ---
> > > > base-commit: 020f6d8442f35105660a29d0d236d3f8650c8142
> > > > change-id: 20251212-edma_dymatic-a57843ff0dfe
> > > >
> > > > Best regards,
> > > > --
> > > > Frank Li <Frank.Li@nxp.com>
> > > >
>

