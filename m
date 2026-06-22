Return-Path: <dmaengine+bounces-11734-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vw5DKVOAOWotugcAu9opvQ
	(envelope-from <dmaengine+bounces-11734-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 20:34:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8616B1CE7
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 20:34:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="W7/czsOG";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11734-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11734-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B3CE30166D4
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F58316197;
	Mon, 22 Jun 2026 18:34:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0CA175A6E;
	Mon, 22 Jun 2026 18:34:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153296; cv=fail; b=GC0Gm2VpouDYApYZQ/oSFHls1MuI173mLWr7xdK2JHdhyXlZ3/3CzreT6lQVMoHod15o7fzsAhWwBMTvzjC3mNVrKC0GGdK1Dp8KZQ8VvEm2j5WJijXeao8Ny1bxhOGf0TxGSpF1PHx10zTVNduPCkRSk64gyWadWljpjSSe1No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153296; c=relaxed/simple;
	bh=Q/rGOYIAu8uKmoVEsMU38cA8fQYusmM74vVb/+sgY2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PpLoiykbukIwJ8GmwbwWA1uAdkAcrUn3hYFuHwQFtsDw77JyxeRQGpyP82dojuCK8AjccPyb2r/XJ9tQRPK4FLQLwshMvg+g6f4Pa2YBFcSsbFLv+OytLSSUmF9x/O35tQhBbam9H0glsL/ctHB1VJQGN3MiU8CKVteo3MyM7l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W7/czsOG reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seXmIm3/oVusRiI9Di3Uy/s0Ma00QiH7anEc5daou5mTWdenpLqLnMrZyeymfjA8rhnsVZ3y6SLcGihGr9XjgD52HL8a9p9vfM1xL+ILmfEP7shDEvk7r5+SP7zksvDX7WsKbTgj6cQkjyKZj8h3zJCpoz/n7Z+xXgz7d7K8SedqqU4rxQNvMmfvM8kfJqTrpEBEQd7nFgPpcgO6N1x8sxUz/4gldX7S8onVKLjsQeN17HRzYlO8vDY+mrWm2+wwrxCYIo/PCHBgd7sKs9i1YG1nRIDPCP1rq/QkVFLreWkC2loYmhb6nhKV54Dnd9pwQMyey2lb7vO+k+KAP5N8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv53/7cEqgMb8+WnniIIXb07pxHxp32gloXOX5mDQGk=;
 b=fnXBnfeN0pcdeQKX0IuDulQoB3ngbuOCJ4qCd2cLbXqCeSGGt9Fyyzf4OOlaL93/SrYHiADv859b7eF1KbMfXvgNo/IR628wWYlYmSvjRmTxLh0HF70INt452a1BDDlHUqSU0tkD69Y8mpb+BBHt2DmPKHEGAtykJ75TZ7ZcppgX9pUezLsEWn5nxJRixFQFBqJA0iCmtRNG2rtsaOd7bOOm7cUKvQYayDM0G7EcgiFNw16wWjV0uIs5NEwuMrTNVnRL22bQqIc7nvg32uWmOZhRiTeE3VXMs22GvBdJRAB1jbIBLJiMcoAO7cbomJdSMotSzLtldBg55JPFxlVdvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv53/7cEqgMb8+WnniIIXb07pxHxp32gloXOX5mDQGk=;
 b=W7/czsOG0i35s7Ko5BsPpGnFFubYTC7joYNmxT8XUafFEqpGVwvgxB0OWDLNuRdUIF9ObW8AbtmaL+u+mEaI77Ug2QZTEKw9SYiwuPMAE9VThnucfMFPZspuZ0Z9NE2eLG0cz70r5hsbtlEdAYBvPA4Yz37O6wKhEbAkhbs6OfNDrkyF7LzNsEgDmjKac/QdxsMx+vhWPO+OL0QU5GVOCLFPmp7On8dC/xOaB5V0Sx4+t1ia1w75VtoKXSFx6w82GwdqNEptJCxdDvkQyJSI09+LC08z4H/4t8hQoHNrdeBftazxXDzzsSSodBqCq11WbmLIH4cMjBITh9rsZQJlpA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10094.eurprd04.prod.outlook.com (2603:10a6:800:247::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 18:34:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 18:34:50 +0000
Date: Mon, 22 Jun 2026 13:34:39 -0500
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
Message-ID: <ajmAP2nKzi2dPEVx@SMW015318>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajlR9QiXiBAH4mWH@nsa>
X-ClientProxiedBy: PH0PR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:510:f::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10094:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1536db-fba0-4e4d-c39b-08ded08cf189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|19092799006|366016|13003099007|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9o9h1h08p8VTVF6L59HoIilhbfJ3qLhN0LXPVv9T6UvQTC6HRghYqHfqQdyibN21zSQrckNNLoGFByThFYyQzs+GI77CjQnoixlJjALUpW/+S9vMc+hQ9z7/ps22KVUrf0+k13x4PG5crBYMKVEeT4jvuMsY6WqUh6EubMJlb47rYyqlR2p3Pbqi5nAlGtkgMOUf75HBYlDsP4xKiQ+UjsxPlw1+sHuzt0v1dWuFxO+mE3YP0yczAzFDrW8CSFyLt3un0PnMhGbiK3scOl4Q1vpidx8rmheoMl0AC7i3XHDy60HzCawpc0ef+RNLTIuuq9Em+o2ZdIAzmo3eSvpHeri+w9iqa36nnjqX6jsQtMsxSI1RjFFK69RDbXwmJHQH0UFNaJVXBQ714AtJTFmAd7Osd32XjGqYkeBRWx+psQv37wIkRHR2QeMkP8IwBGVuGOVZwd7LHJCjU9zuJgKa4UfzLnr+2O4hZku4EQg6ru9L7p/DVBh6Db5vwdx3a8HctDwmu+vrNolYaQ6S9ruhs6IZ8CU8Ty7zIUk+ps+q2zn1hfCmbqx5BoxeuYsBeFpgs8ZFl13Cx0jnKgFZMCWcU4iRAlAxp1phMx0Q5uDX08R081BPg7NLGRodv5eRSK7W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(19092799006)(366016)(13003099007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?TdTYPT+VbN6AqTRpB1QKqDaysG0753PBLkZWGZGz6R4xS6smLGjBVag1IB?=
 =?iso-8859-1?Q?WPTgQA5bgonlBnbcyF5XhMDBLDFB0Y+53Jh0Jebh4aaXq74PHTlHrscgKW?=
 =?iso-8859-1?Q?erAwUMV0VD1g/8x1r6h2xlDZpX05yBG6P8X4KHuiyXElvZ5CCMztSIVjFg?=
 =?iso-8859-1?Q?GRFOucposJsK7vEYJYQwNpQSNLefWJt1oWXdxIlp9hR33Rf5lAGM6B6rJ1?=
 =?iso-8859-1?Q?lf0q5aZWQZv3V4+S+evT28Ph2k/zzDASRbi1/Kr6Oc2TJ+KNBBKR+uhYSe?=
 =?iso-8859-1?Q?sGDpL9AUIobhG4WvUD1Vcbe5OL+R4XgXAJaFShOu5Eo84/klBAZK98XUOo?=
 =?iso-8859-1?Q?Gr5YuEKSail9u3IiuqRt/HgszdL9PTXK/2KClfeja2jZcTuGs4fTvzVpO8?=
 =?iso-8859-1?Q?oXmzIMW2DoydnOtqZLar6lcbSQRCn5kyLHACSzFvJue0hU37qzM1VHn8ye?=
 =?iso-8859-1?Q?Ti7wRbhKNtydcbnAO/zkhVIKNcd5OF3Awulu/bFd+bTQYy6edmaTVfakRK?=
 =?iso-8859-1?Q?a8wCv6Rv0oFQpdcUPx6AX39pit7JNwA94IdOSAhEmysOT1dgC/eMAxqFYm?=
 =?iso-8859-1?Q?8lfQ229PKHt86C4FetwmF8eadiKNjOuxVMgPxNjKbo19GTuDt8ZxUOIP6d?=
 =?iso-8859-1?Q?XGRAR9VmMYtWggkFfqnemotrSN+Yo/kvVEgXjBliiXlm7+nCo8BpMmqLCJ?=
 =?iso-8859-1?Q?wjqBc9zRdUbmYeyqw+hHy7R8Gv+WMLJ+/tstVANgvPVrRK12pAQOS6V4bp?=
 =?iso-8859-1?Q?iMdVKeQRFxDwlGF2yUr/JZVEdzYSkg8fZojHjrIHXQUeu49HgmGUG1lsEq?=
 =?iso-8859-1?Q?i+hd09dAUKIJaTBD/jzzPGsl4ua9eh5R44nQf2yo/yBjTB2x8bLRxxUesu?=
 =?iso-8859-1?Q?VApOVHF1rfSgpYXjPnj0EwKdgic9uxHshf3tkPXdbfAlZvWUD2p7hvhrA5?=
 =?iso-8859-1?Q?q/W7G01dqkMSI3W4s5k4pKLlKHDZInG/wYeqS55KJare/ymwSPTKpdbYy/?=
 =?iso-8859-1?Q?ezHjgblw7dfrCGaG5DYcfny4CIn0A0jb1ip25tGlwH92kuZBYbudGRkdlK?=
 =?iso-8859-1?Q?mFmBMuneTIjMCa5fXNnx9aD3/WARTBtU71p/nqQye3fQmauVJ9YOYx6lRK?=
 =?iso-8859-1?Q?4bOYH7F2DBwGB6yP9G54SPnuHV8C5yJlgGRBKlCrYFnvsjM9ZDcuRuBeln?=
 =?iso-8859-1?Q?/D8RvtuRpQMD/uDZgdQxzWUyYZyX1BShYbkBEZOuTi5Be9RKhMIQTucddO?=
 =?iso-8859-1?Q?5HCGLd8SKBxHJ5sEcs8Bpx6eiqRc0mUHh6pVTudonU3UyLJyWlyjgKdXGL?=
 =?iso-8859-1?Q?Bp7OYMkRUofuE2WNZFdipHh50j/x1kcotFu/xoUg1XY2EWujrfnVZYREhb?=
 =?iso-8859-1?Q?K6KJMZxJbH+V3++1Xx2uav4gJ60jyBgNjmIrA7evDoH0/vhY4X47/jt6+J?=
 =?iso-8859-1?Q?Kw1V2d7zumsOEorNyWn7STDT+rudVd16ICdLem6jJTjZgYAOGCC+pPTEDE?=
 =?iso-8859-1?Q?evOPmvsBxmshwLKXTqWDg0QWifN7dr4+aPy7HwUMJcJ8+DpLyvHMSX4wao?=
 =?iso-8859-1?Q?83EzW5Xi1Hveh872+3lPyOl4zE4Dr8N+st4Huc6ZqvDX9wfj21Dgc1qTEl?=
 =?iso-8859-1?Q?iy0xVkq6dBFidIf+gSC+fnjk3gGzKUazC77tCvGtwVdYcugEUo9Kc0lUHt?=
 =?iso-8859-1?Q?RhYxNoWdagMUVr0EnNg+drDsrKDd318Adqw5PAtnexolJ5PgfXOwE8Lp8E?=
 =?iso-8859-1?Q?0v9jB2kBYMgGAnMyA+AyXHcSjg/hWKvDZ8FaeZDkmcgNB+38fNS4tna4uF?=
 =?iso-8859-1?Q?U0+Fj8umHMfKsLG2Xn6kcHWEYUUBtNrvUiaSRPl1jpZFwDmRZX3w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1536db-fba0-4e4d-c39b-08ded08cf189
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 18:34:50.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jg3epyRoloZFbQ9eC9Arp0z8K2csc4v1Vsf9Y4QavrWskzDN0b02zwdwMvnLm6hAQYW4NA/U12Uz1iC2A6TjEFH88B4WviSeyLkDJvBg42QX7inTuTc/DDyDA1gJ/OZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10094
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11734-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:noname.nuno@gmail.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,m:nonamenuno@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,aka.ms:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SMW015318:mid,analog.com:email,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA8616B1CE7

On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> > > On Fri, Jun 19, 2026 at 03:02:53PM -0400, Frank Li wrote:
> > > > On Fri, Jun 19, 2026 at 11:22:54AM -0500, Frank Li wrote:
> > > > > On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> > > > > > [You don't often get email from noname.nuno@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > > >
> > > > > > On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > > > > > > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > > > > > > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > > > > >
> > > > > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > > > > >
> > > > > > > > Advertise the source and destination bus widths through the new
> > > > > > > > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > > > > > > > BIT() mask. This moves the driver onto the representation that can
> > > > > > > > express widths of 32 bytes and above and allows the legacy u32 field to
> > > > > > > > be removed once all users are converted.
> > > > > > > >
> > > > > > > > While at it, give the channel width members their proper
> > > > > > > > enum dma_slave_buswidth type.
> > > > > > > >
> > > > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > > > ---
> > > > > > > >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> > > > > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > > > > index d47ff27e1408..19c258d511ca 100644
> > > > > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > > > > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> > > > > > > >         struct list_head active_descs;
> > > > > > > >         enum dma_transfer_direction direction;
> > > > > > > >
> > > > > > > > -       unsigned int src_width;
> > > > > > > > -       unsigned int dest_width;
> > > > > > > > +       enum dma_slave_buswidth src_width;
> > > > > > > > +       enum dma_slave_buswidth dest_width;
> > > > > > > >         unsigned int src_type;
> > > > > > > >         unsigned int dest_type;
> > > > > > > >
> > > > > > > > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > > > > > > >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> > > > > > > >         dma_dev->device_synchronize = axi_dmac_synchronize;
> > > > > > > >         dma_dev->dev = &pdev->dev;
> > > > > > > > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > > > > > > > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > > > > > > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > > > > > > > +       if (ret)
> > > > > > > > +               return ret;
> > > > > > > > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > > > > > > > +       if (ret)
> > > > > > > > +               return ret;
> > > > > > >
> > > > > > >
> > > > > > > This patch is okay.  I think most system only set one width once, do we
> > > > > > > really need pass down arrary.
> > > > > >
> > > > > > I think so. See:
> > > > > >
> > > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
> > > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
> > > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475
> > > > > >
> > > > > > And likely there are more. To fully support all widths I'm not seeing
> > > > > > any other obvious way.
> > > > >
> > > > > I need more time to understand why need src_addr_width, which looks like
> > > > > address alignmenet requirment.
> > > > >
> > > > > If it is address alginment requirement, only need lowest one, like suport
> > > > > byte, must be support other alignments.
> > > > >
> > > > > if it is total address space, which should be controller by dma-ranges.
> > > >
> > > > I grep kernel code, only sound/core/pcm_dmaegine.c check src/dst_addr_width.
> > > > (I think src/dsk_bus_width is more reasonable). because the name is the
> > > > same as dma_slave_cfg, it is easy to cause confuse.
> > >
> > > No complains for the new naming. If everyone agrees on that, I'm fine.
> > >
> > > >
> > > > So far, still have not seen user case, which more than 8byte for cap.
> > >
> > > On the consumer side the IIO dmaengine will use more than that (we have
> > > designs for that - that's how I found the issue). But yeah, it just uses the
> > > min value (it is just that dma-axi-dmac only sets one).
> > >
> > > >
> > > > Add it should only set min value should be enougth, if update only user
> > > > sound/core/pcm_dmaegine.c
> > > >
> > >
> > > Not sure how that works on the pcm_dmaegine.c. It sets more 'hw->formats' than the minimum.
> > > And IIRC, this ends up being configurable from userspace so we might
> > > really want all the available options.
> > >
> > > Hence, given that we do need more than 32bytes and some users (seems
> > > like 1 only) do look for more than the minimum width,
> >
> > If FIFO space require 32bytes data bus width,  4Bytes DMA engine should be
> > match requirmment, cap just help filter dma channel.
>
> I'm not sure I'm getting your point but on dma caps, the src/dst addr
> widths is a mask. So for 32bytes widths, we need to set bit 32 (which
> currently is an open path for undefined behavior)

Bitmask does make sense, I don't think DMAEngine only support 32byte bus
width for slave FIFO.

If support 4Byte, it native supportted any N*4Byte.

So needn't bit mask to indicate all support bytes.

> >
> > each transfer, dma_slave_cfg should set specific bus width requirement.
> >
> > If memory have requirement for 32bytes, typical cache line length for
> > hardwaer coherence transfer, it should use dmaengine_alignment.
> >
> > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> >
>
> What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> there... The code seems to use the dma bus width to match against PCM
> formats supported and filter only the ones we can support (per dma cap).

if cap is one byte, it should support 8, 16, 24, 32, 64
if cap is two byte, it should support 16, 32, 64
if cap is 4 byte,  it only support 32 and 64.

Needn't mask each bit.

Frank

> If we only set the min, that means the PCM code all of the sudden only
> supports one format and I'm not sure that should be always the case or
> that we won't break any user.
>
> I mean the dmaengine src/dst_addr_widths must be a mask for a reason,
> no?
>
> - Nuno Sá
>
> > Frank
> >
> > > I would say the
> > > array is fine. IMHO, it's also safer (from a "support all" point of view  and really not
> > > complicated at all so I would just not risk it.
> >
> >
> >
> > >
> > > (we can also have one liner helpers for the case where only width is
> > > set).
> > >
> > > - Nuno Sá
> > >
> > > >
> > > > >
> > > > > Frank
> > > > >
> > > > > >
> > > > > > - Nuno Sá
> > > > > > >
> > > > > > > Frank
> > > > > > >
> > > > > > > >         dma_dev->directions = BIT(dmac->chan.direction);
> > > > > > > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > > > > > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.54.0
> > > > > > > >
> > > > > > > >

