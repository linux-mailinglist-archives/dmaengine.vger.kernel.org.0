Return-Path: <dmaengine+bounces-11723-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IG9CBBVMOWqpqAcAu9opvQ
	(envelope-from <dmaengine+bounces-11723-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 16:52:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C546B07AC
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 16:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=SR7Y62XT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11723-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11723-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D63D3012B29
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B65330F534;
	Mon, 22 Jun 2026 14:52:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968430F526;
	Mon, 22 Jun 2026 14:51:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139921; cv=fail; b=cKTiM0jo9zHR331ynvCIAwC7nIvtvvIGcogxmmvvvk4dcs7yuBgk4GseHUFwte6PT2mkUyZ8puCFWxXPJAPE8fbHgcgWS9GLRq5xWwYTLH79+pQfXLnj/4UXDpehfuPA32fm1Tkcvtp2keBnYORk7+9M0AOuBdUWnwBYXkEiHks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139921; c=relaxed/simple;
	bh=5FpQemXy/FJ96MhPlaOoGRsUSg+iRJtN9v+pHOiz9qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p200XkCemMuuClcE8/90KDHUj2HPtkMma/h/vymAfHI30CkbaKzBveJKbcr21fnxl2ppiHIbCMKVet8+lHlo7LJ8wuw0HRRCXxemNul+Q7u5Wx4sUuXLK7ngnhNcW69nSCEvRj9bZYv7GLKSAeyXISZwYwfww+Ck7vQA8vA1LZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SR7Y62XT reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sg6oL7I9qsKyTaEmW0lSbPuGzzzi4GmDlL2DakgVkvteMlG/3MPx/0n3kaSF8LLLcxk7EZfoVS7s203m/BSwKDprQZF6jvaGilgoCIT5aJ29GHQTIct1fAGDp41zab/YbcoCSgyvercRjEWiPmZfsiFq1AGu37BBbGq7w3dZlLfTkqVQfPoS7/9fGr9cS+TzFmtL4m+IM8ciKjlN34tMagPlZcZ2xBFHmUCZVhQmFEbAPcbtKd3Om17F3Ia/ia+IAtlNhM54Hp5ZsxaqmQC0nHER57XBqTkcSXzyFhdqVWXLbX8s1PkUNFDQiIXjENzEDEfaqmG4EDTfvZghfBd8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbY0ZJec+Eps735eaMY6PCLL/hzgDtABymxIJKcBL1Q=;
 b=B8Zdp90D+0Hn8RGVA/AsD1BMm/cDfjzHXaroRHoToQ2VVfz+NVsbCfbjGdZKGpf+h9gYsxMVG43g4K1yjiK2mGxp06opBVn1G3vIGydCJ6bG0CVYc3WN6Tokn0pEDpVihnMR7MueI4Tw7HWLZ7XWznn7VN3wmRM+WpuhkVD6YV8UmmJDQeMakEn6ih1isB/vyZIspMvW0bUIyZv4IYVLzQP78lmZ0vJEda71Sbj9DH924AkFaWQt4LT7oIFY/CtwQrFXAHAEAxq6jqcDHHc3j2C4Yu2hLxRZ/eWLBCtrxYtiHLOi5OIWjd0h0BikLvEp5EuW+om1c2WJurWm9z8bzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbY0ZJec+Eps735eaMY6PCLL/hzgDtABymxIJKcBL1Q=;
 b=SR7Y62XTcyOcZAWxwrqx3fDNKcPxjuH4u+c4USvoruGJn0DCVempf5k/zbLYxpszpGqkKYUUcw3kRjIu9pmWpkO8+uwVOyq8sVfkgHGk0NveTf1pQIP4ev6mlbMxlBvJ0xNF54wRPMSlQ5s2sq3PMAQY+8zJCh28X3SHuOahaspUih/tk4h31CS6MzF4tDnIqI/dbPm5kfp9FCb6uQTj0K7CgzFeiKoe/JFPD3Jn/spAeyiYX3O+yn9fthrcA7ci4fTIHl190mF2sS3KkVWJFDSjB1SB41OHmb6gXbd5sSkzedYKU0rBgx+zSgUHDpd/v9QisS9LRZBaXqmq2BSNsw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11445.eurprd04.prod.outlook.com (2603:10a6:150:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 14:51:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 14:51:55 +0000
Date: Mon, 22 Jun 2026 09:51:46 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajlMAijTUHsnOhEQ@SMW015318>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajj8AhN1YC3uvuLb@nsa>
X-ClientProxiedBy: SA0PR11CA0165.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11445:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f470092-7374-4eb4-3cda-08ded06dcda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|19092799006|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	h2azPfgFdATdAAkvTEcHIYA9WC1axzxObu1/sxLB8M7zppL9/AHzrdmfcqEUwdoBA8Yo8e8FOYAq7BUW7wCq5t9Xur9xd1ENK9R5I9nw2tkSFPeVXtGiEpTXpl8Az1Ri5HQQ3kx4GTNEtVGqxEy4X2Expp56jbdgJgNIwy9MeUyy/oicBqh6DvQwBQYKrT4PO/DyEWtek3OS+cvYhVXwet7azpfa5m5/bFfF2WpP1AuKCZZvYH9uyq9NaCO7z6NJvdpB9JLmyiuKfb4JhSmxo3tVAOeHZExyLyKNP835p6Z4GxB6dXB3YTdqdrawXdxKPdmMhy7HluO3jzz3RvF83vaL2eB/8uNQfpPYOIDgcxryN9+SO4WQ1PDFEqObeJbJIQNhVe2tUJjZ4NU8tNHQuFXOveInjPrqwIV++PHRIOrDGwlZl84Z3ci+SqkKzSh495hPkOPiLcq7rTawEIgyo80QHbplBPzjJAl/fFMWdHW+KJeLdIqohCCHDXGz4XNjr1IviG22Bm7y5oxkHW6rTJupP7Eywu6kNes/6j4iDYQDiGXvY319t5uFtCL+QIJhZOZNW6kkGXgpAfcHejV3YZ//ZKz0j3KK+cXicUNiDQV6KAyIsSRcm0qnGjNOLw+2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(19092799006)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?OqLgw82JhRK4lJo9Bg2bqfVZUPP0FJ+eIhOEMYhwutWhKQAvZ1SNHbLBAS?=
 =?iso-8859-1?Q?oKwhr0UyTJSZ0ifJbqixAjLSEDis+OkDC4RL2k0kRbf66f77KPu8AP4cn6?=
 =?iso-8859-1?Q?W1YXMmfeq30aWXZeH+2Do3oLJBtkcrGw4AFlaiorNEOfv1k2zybjWSHRc4?=
 =?iso-8859-1?Q?9Qdz0G73YzWJf9CnTJhrjQrfwhDHAOz9Q1AJy7s76VFapMgi0fZaON1GdV?=
 =?iso-8859-1?Q?f23ywn0Bj4d0clfqc0cEwQAUgTdsY0blQl8R1grSKO7N2hSbcIhMWFFU4v?=
 =?iso-8859-1?Q?nU48QCRD2JXfOvaEklsSMcl4YHvitv68TA+8GH4a8EC45T64iqonj/Ib5e?=
 =?iso-8859-1?Q?SkUgaFE8tdK71v1ldW9oO9Tiz4LYBWSX8r5zEgnWw6+W/BkVeiB+54LoBF?=
 =?iso-8859-1?Q?oAX4kLy6vTaLQpcL9QvUuYWjKAeQv/RnrfXCg6IiAW2dL+ho3D+JJiNFvd?=
 =?iso-8859-1?Q?ijbIw7FNpjTWki01Xs8p5bR6OV8BXCoH2Fak78ervcqml0ruF5t5lAA6wK?=
 =?iso-8859-1?Q?dWZYlzgLMhx1+G0v3fLrSWxYXgsCwg9u3S4gGpMpIoPFTD4ZjhKF4KqA8/?=
 =?iso-8859-1?Q?bsbgXkAcZO3QUGp37FyRe25USg831+XF1GMNUa9WAP8BdPLwSYAH7AKoGn?=
 =?iso-8859-1?Q?cBOyKwDbMTu3vaYisIzXjfOiwDx67X2NBxWFNiCVQeABxb79wQAWuHS6uX?=
 =?iso-8859-1?Q?r8wmrdwba5vo00z2UG7ILS6lT7kBe1AGZi2JEsp9DmVnE/5rwG+gj4NheK?=
 =?iso-8859-1?Q?GO3tGbKm4TV4JAwMXf/haOKsoGkCvLgOLrzS8skw9KYJXrMWp7Z7KEd/Of?=
 =?iso-8859-1?Q?Q4yuscAtT98IhFqpb2Q9g4VIJaYRPpESlDCDt5gimAXW9kGsOKhSNmyddA?=
 =?iso-8859-1?Q?HeoJAJ66sOcVETLsyQ2uv502gfZ7oqJJnX7vawiWz9uNrHHmsxTLRRhhlc?=
 =?iso-8859-1?Q?0zhRQ5WgPuxtJZwee5IE5v73JMzC0fEsYjdp/O4MRkxGgQ2ChElGgT2Inb?=
 =?iso-8859-1?Q?P7rbQhBsOz/xW3VL+8F2J7D4gQh/UqEc2DMWZF1P5agU4Tp03UemjC0FHx?=
 =?iso-8859-1?Q?Ztk+gsKEYkwp30Hj5UNnTYllj1tdGBy7nOihwI+MoqKK+MycJXsN576YoW?=
 =?iso-8859-1?Q?RXKksp03MRhtRuaNPcLMBntg3J/Rdlykm0XWoI8Cl+VameZC8yXYAJzsve?=
 =?iso-8859-1?Q?c59IBHZK86lCYIetvGQ9JESqV5avss+aGJNWHfJxN2Sq7Qz4ZBXie3pIm3?=
 =?iso-8859-1?Q?UyGrpqfgFzC9iywvNQdUbGP8XLY50u65quE5I/qtopGXHp9IrjlgSANLgh?=
 =?iso-8859-1?Q?ayImL29uqtg5a49B83AEDkOnATNbwYEm/IRgLEi6vociETMHoGqccldv1E?=
 =?iso-8859-1?Q?q2SVllzDxBrJSebx9uygkRjOH3ZANI9TqtXfapyE3kPAag9k2skFVd+RKj?=
 =?iso-8859-1?Q?B3LOQawFVAPhFox8uYLQdDSteDG4q/Q+yNT54k3kJ1LsdpHPVk90nZm+Bh?=
 =?iso-8859-1?Q?l1THDfmFri/+25xyhQWg0R41Qv+7j9fEkPjb58WKV+cA9dcD6X2GIKEFUS?=
 =?iso-8859-1?Q?JwPlNXhzEnE3JM8DZOV2Cl6MvztXJadoQFPSTscLraFhKHRAf6f/q8ARLe?=
 =?iso-8859-1?Q?MEs1TVBNN0U3RtJ6RslbS60RVODOWtDWFQgSEs9YkCw0tDFP/o/Q26dLrq?=
 =?iso-8859-1?Q?1zZqTtQgkFNNteky1Km9O3uz6vPDbrXJESM4BlbV1WAvGCNnuBhX2YZAbj?=
 =?iso-8859-1?Q?5V6GHjNCmGgOYKzn4NNvgI7/jbtf2+B34TDFZivBgDuR3H0F7TAVeGtNoS?=
 =?iso-8859-1?Q?/yfHqmNfisfy3VF/yKZ198efYzTS4VzQ9IP95qbFYJFRDszFw/Yn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f470092-7374-4eb4-3cda-08ded06dcda8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 14:51:55.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFfv4SLCmU5zOpnh1Fn6mMwO3G3B2JB2maiHNX4u+7WGO1GBmMW+fPw0QFrTNj+QZ/OVyLrzUjNIGmU/HRkJEVygMJhPgSwNon20SA+yPQ0WxHoPg4XSyYrKUiAQn7q4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11445
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11723-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:noname.nuno@gmail.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,m:nonamenuno@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,aka.ms:url,oss.nxp.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95C546B07AC

On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> On Fri, Jun 19, 2026 at 03:02:53PM -0400, Frank Li wrote:
> > On Fri, Jun 19, 2026 at 11:22:54AM -0500, Frank Li wrote:
> > > On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> > > > [You don't often get email from noname.nuno@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > > > > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > > > > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > > >
> > > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > > >
> > > > > > Advertise the source and destination bus widths through the new
> > > > > > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > > > > > BIT() mask. This moves the driver onto the representation that can
> > > > > > express widths of 32 bytes and above and allows the legacy u32 field to
> > > > > > be removed once all users are converted.
> > > > > >
> > > > > > While at it, give the channel width members their proper
> > > > > > enum dma_slave_buswidth type.
> > > > > >
> > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > ---
> > > > > >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> > > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > > index d47ff27e1408..19c258d511ca 100644
> > > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> > > > > >         struct list_head active_descs;
> > > > > >         enum dma_transfer_direction direction;
> > > > > >
> > > > > > -       unsigned int src_width;
> > > > > > -       unsigned int dest_width;
> > > > > > +       enum dma_slave_buswidth src_width;
> > > > > > +       enum dma_slave_buswidth dest_width;
> > > > > >         unsigned int src_type;
> > > > > >         unsigned int dest_type;
> > > > > >
> > > > > > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > > > > >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> > > > > >         dma_dev->device_synchronize = axi_dmac_synchronize;
> > > > > >         dma_dev->dev = &pdev->dev;
> > > > > > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > > > > > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > > > > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > > > > > +       if (ret)
> > > > > > +               return ret;
> > > > > > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > > > > > +       if (ret)
> > > > > > +               return ret;
> > > > >
> > > > >
> > > > > This patch is okay.  I think most system only set one width once, do we
> > > > > really need pass down arrary.
> > > >
> > > > I think so. See:
> > > >
> > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
> > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
> > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475
> > > >
> > > > And likely there are more. To fully support all widths I'm not seeing
> > > > any other obvious way.
> > >
> > > I need more time to understand why need src_addr_width, which looks like
> > > address alignmenet requirment.
> > >
> > > If it is address alginment requirement, only need lowest one, like suport
> > > byte, must be support other alignments.
> > >
> > > if it is total address space, which should be controller by dma-ranges.
> >
> > I grep kernel code, only sound/core/pcm_dmaegine.c check src/dst_addr_width.
> > (I think src/dsk_bus_width is more reasonable). because the name is the
> > same as dma_slave_cfg, it is easy to cause confuse.
>
> No complains for the new naming. If everyone agrees on that, I'm fine.
>
> >
> > So far, still have not seen user case, which more than 8byte for cap.
>
> On the consumer side the IIO dmaengine will use more than that (we have
> designs for that - that's how I found the issue). But yeah, it just uses the
> min value (it is just that dma-axi-dmac only sets one).
>
> >
> > Add it should only set min value should be enougth, if update only user
> > sound/core/pcm_dmaegine.c
> >
>
> Not sure how that works on the pcm_dmaegine.c. It sets more 'hw->formats' than the minimum.
> And IIRC, this ends up being configurable from userspace so we might
> really want all the available options.
>
> Hence, given that we do need more than 32bytes and some users (seems
> like 1 only) do look for more than the minimum width,

If FIFO space require 32bytes data bus width,  4Bytes DMA engine should be
match requirmment, cap just help filter dma channel.

each transfer, dma_slave_cfg should set specific bus width requirement.

If memory have requirement for 32bytes, typical cache line length for
hardwaer coherence transfer, it should use dmaengine_alignment.

So I think only need set min value should be enough if fix pcm_dmaegine.c.

Frank

> I would say the
> array is fine. IMHO, it's also safer (from a "support all" point of view  and really not
> complicated at all so I would just not risk it.



>
> (we can also have one liner helpers for the case where only width is
> set).
>
> - Nuno Sá
>
> >
> > >
> > > Frank
> > >
> > > >
> > > > - Nuno Sá
> > > > >
> > > > > Frank
> > > > >
> > > > > >         dma_dev->directions = BIT(dmac->chan.direction);
> > > > > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > > > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > > > > >
> > > > > > --
> > > > > > 2.54.0
> > > > > >
> > > > > >

