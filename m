Return-Path: <dmaengine+bounces-3993-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F559F35D9
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3B516B940
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB1613B2AF;
	Mon, 16 Dec 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a8Y7ndAa"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2063.outbound.protection.outlook.com [40.107.103.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C3200A0;
	Mon, 16 Dec 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366153; cv=fail; b=awJcYGrREwtKTy/Wetgj5SscygxYHp9f05fEulti8Y8lG7ZRPkqlT+bJw+6b+jqF+9gsuCrV7cqfIQ0s9wnEQj7Iwzyq1llmZNO/y2lNaVHO42m3G2ef0m/nw4lmUsXamxIY1j6ypSX8BIGBDTHq8Ys93FWj1rcHzQw5+ZFjWoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366153; c=relaxed/simple;
	bh=jRngMBdeCVehWc6T7WNQvSP0yvSS5/pR0gf/GAE5SqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f6hYUeWZxZ0tAFqCeTVF3MZR7sxCiRcxylrLzTP25efHyWT/ytqGKkGZWdBJcX5UzMkS0uSa2jP9H/iq9CsVgrWWOSTayQpK9Yos+sOKZ3La0p8BjbKRoDlS4thAQ2JNndGf+XwqQ0hAgKKQDepQ8BHoFOE9wnq7ZNjgOvLIcdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a8Y7ndAa; arc=fail smtp.client-ip=40.107.103.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjYVHMsiqc7QPI6P8UYfj7H56WN9YIn+KeBpHG1DcWMXQMbtqqbUTiaIlQN7pG2jIyuZsdErINLYWoPU0l3SZ4ZnVd8PtoOpU6k+OBJBL1FwKoPWu9KW1gKzoEKc53aNSZ7clLykUkjcWRRi7qUfepRDfA6WfOOh5Lt3JAZp9HCbcn4fTdGaqxjceANPTLoIRUUEpBaOle84s2NQvZbXZFzprhmQr1RtKR6zJJbqkujAlF2Ud+c85Wv/7OzwD1cgskSFvO75AnGY9iG8fSliuFZgBS6qnyN4lTCQdAoFwEdKeMkwSpQga5j+RkS+CpeEqqRtwRXnnb5oOmVmzv4w2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnMUOpxONcpxjDdAvfWxsZsPY94CzBsiFIvmlfJTKds=;
 b=vEGrQLj9VKHHluqzhrBFvAxgXyzY28Dxunlte0ZYeJzRIlpIMAaent7Pxh7YwgP27yN0+m3BMiuaj/ZqyVD7cVOgd0QcCaHWtun/Po7kpStvgXYsLw2s7Ka/lCoyf7aTmLWoq5o8zSEz40hkzLE+UbXMh8NcoMp0xVAJPMzrZtX6IlVisPyeYmOf51eVwbtfYiZFcsE9bo5ePO6HQN4hTUD53OsXHzM0CYDqYDYkcOEWUYHJnjvb/oBGKsh3l2xSCUPKBfQyAG3ZY6zx0N0MSthr8Xu2coBYUwxobkpntU8Oh3nEMow+BgR/8rm38HSadgOXqVve9S0yblFbPaE++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnMUOpxONcpxjDdAvfWxsZsPY94CzBsiFIvmlfJTKds=;
 b=a8Y7ndAaC7zap5EeAWPNcLRkP2IfKJ/Oxeo/1tQqaHAz9JEbEDvinZhZYtqBzRo6Rwf1fSVmu45ghiBoyuLvOxEEW2ivHBVthOulSoW45y2J9DMdisVV46NFo+kcIX71RgUjvnsCGHWZ098FCo80aDl1PLskuFuEGMnOrOwhWxgCWjQFZVMNcVvC+rg7ytrTir+MCzoousBpS2WGJFwBEO8PJiD2iagZx8KBgB0DvqfwRXUikYGu+ambggx1YBMC0kklzQ5lZb54e3Ky7c1Fh1QO052NipqdueILCHevao2aD5rNhayMlte8eu6hD2X7WcM1ncaxw0iCijFrwN6XAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:22:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:22:27 +0000
Date: Mon, 16 Dec 2024 11:22:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Larisa Ileana Grigore (OSS)" <larisa.grigore@oss.nxp.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dl-S32 <S32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 0/8] Add eDMAv3 support for S32G2/S32G3 SoCs
Message-ID: <Z2BTvc7cao8LfHLE@lizhi-Precision-Tower-5810>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <PAXPR04MB9642E90B1C19B7889E17A6A8883B2@PAXPR04MB9642.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB9642E90B1C19B7889E17A6A8883B2@PAXPR04MB9642.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: d33d8e07-3d51-433a-f936-08dd1dedd52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGYwZ2hOeGR1aW9jMm55Z2pOdm1Ga2NmWHVKWVErRk5rZlJybHVZZ01wUjha?=
 =?utf-8?B?L0YxZHR2bFd0N1JVTEh3cDYwSFg1cUMycnFtZ3lXMjVabk9idGZpV0psb1N0?=
 =?utf-8?B?Rmo5UTI1QTNodWc1MGZHWnZaTEJPTDI5OGROTXVzMTBnWDdsTDR5QWFSUGpa?=
 =?utf-8?B?d1NSb21LQ1p3KzlNOHNNQ21UcHZPRVpnWElOM1IzNjN2VFlibFBra250ZVNq?=
 =?utf-8?B?QTBpT0J3YUdzUkFBWGxpd0huZ1BsLzJsMnlGWkJFVGVxK1JoM3hPTFB2SWIw?=
 =?utf-8?B?SHJHZlJVREVVWGlBUkw1RVpUUTBJbUtVUVN3aEdSL3VJVERxZFpqYTZCZWJj?=
 =?utf-8?B?Y2NtMDBLdEZua0haMmpkNXpONjRUNHh6TFA3OVpCSWh2Qnp4UXNJeEpRRk1L?=
 =?utf-8?B?Y3ZDVFZPMzJHcUtxWHdIaTFtbU9JQVZTdkZEQ1FZK0x3a0dyVVkzQ2VIUHlJ?=
 =?utf-8?B?b3dUcUdQRysrRXh6Qm1XR2hCS1NoeStEZXlpVG1JOEZVTFJCZWZNUDBuL1pM?=
 =?utf-8?B?aVFyQlczNTdxL0x6N2Q0Q05rMmFDcDJEeUtNVDRueDBaQ1lnZjNLSEZJby9Q?=
 =?utf-8?B?d1VJdVlhaUZJT2ZheG5tZWtiNi9XUXBMWlc2TGtaR3pRZFhETWsrREg1Zm13?=
 =?utf-8?B?RlJIWkNHc09ZQmQvOVZOa2V5dHZHYXgxTmlEUkpxbXVHTkNTeVBzUlVoT3V5?=
 =?utf-8?B?ZnZlSUJRZXA0Vk1ESmNsa1EvdXFHSHdSR2ZxdVQwMk1TbE1Fcm1xZlBmTnNX?=
 =?utf-8?B?VnJ0eXE5aFBSa2R0S3pmOFhKSXU4NTVBa3RnOXRHbW82L29qOGpiekhpaHVJ?=
 =?utf-8?B?SDBnc09FNk5QOVR4dzZnb1llYnlvNklYUWNyOVp6d0lEMStuOUgxeW1pZk1t?=
 =?utf-8?B?djhXSFdGK2k1MnppMklNMTcvR3dzODRaSGpOeS8xU01aald1Vkl5VEdXVitV?=
 =?utf-8?B?L1g5Z1BHWEJPcHl0cUhWUUN3UFBhUUR3U1VINmJaQ2dZYzJXRzhUVER1eTdj?=
 =?utf-8?B?S3hKcGVlbWdITlN1TWtRL0ZPbVhMNW1DaDhvRzVSRVU4dlB0QnNzak1YN0FR?=
 =?utf-8?B?ajFBMEZRMlZSclJZWTdQVlFUSm1hdmNoam16SFJQUk5Pbzhqd0VYWHZPU1No?=
 =?utf-8?B?VHRCcU92NzZySlBNa0hvMVQzSEluUFRXaEFCb2V0L3NQWmtFSjd2MWI5TEtt?=
 =?utf-8?B?QTlSc1A2T2hVYnM5M1Rwd0crSVdUamZ3RTBMZTJIbTVIazAwK0o1TGR6aVJQ?=
 =?utf-8?B?R1M2TkFVZGNIbEgwUnlCazE4Vnl3RjcramY2RmNncnNMQnlGdXZWOVNFbFg1?=
 =?utf-8?B?Qk9lRG84eDV0anQ1MkRBVHNqOVA3K0FvcFhmSjJtRDB1c3F0aUJ1RkhVWVlB?=
 =?utf-8?B?Z1RYZ213emYxU2d3UEJEdy9Xa1Z5bWdtNmJKWWpvRGltODJRZjQ5d2pQU2h5?=
 =?utf-8?B?UGE0eUR4WFpOczE3VURQRWdtSEYybkUxd21OTVBUTnBkU2NtSVpHY1FoOE1R?=
 =?utf-8?B?NzFhbVBVRFhqQ00vY3JhQzh1UlpTS3NWcHZ2MEtRKzd5aUFrNnZocFZRYkJN?=
 =?utf-8?B?NVVWMk1Ed0J1OXZFZHMxU2xMaFBSaHRtZGhwcUcwemlMYnkzZThWS0hiY29m?=
 =?utf-8?B?NkVMbXNrU2V3KzhVZDB1N01JMkExc2hjSm1pNGtqODRIQ0p3dVJtMXFiNGR2?=
 =?utf-8?B?QllnSE80eGovdUxXNVlSREhlZE5WakpQdThuaW9qRXllay9KQkN0ajVKdERH?=
 =?utf-8?B?dHpiQitob3cxempsRjhBYXMxZWluM1NTaXgyZW9vMnRyZUJJTG5xM3M3dS9h?=
 =?utf-8?B?ekpYZ3NVMFdLSUVlOFJzUDNWMjZBVnRVYWM5c2t6a1k3UWliUUtwb0ZmTEx6?=
 =?utf-8?B?c2lLWEtlUVhNb3ZpcHJTZ0FHUzBCTUV5b0NsNGxqMXMycUhNOXpMN29UZzN6?=
 =?utf-8?Q?0KD81+VwHVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ykp5MjJWall2MzRZTnc1MFp0cVJoclZiYStTOHpRVGJGK0Vkd2N2dEJaVWVZ?=
 =?utf-8?B?YW9PQ0dhSkE1Rjl2M2xhU1g5amVNdkpwZUFvREJvTXpsZUliNTM2WEF0Z05Q?=
 =?utf-8?B?YmZXQjMrTS8xZ2ZWM2x6aS9LSzFUQ25wUkNJdVpzaEFYRUFEazdoQTVqSWZT?=
 =?utf-8?B?bzhNUmh0SlZaaXN3TEdSSnprVVRYOTZIQjl2WVNvM3pkV3haRGtQYUIwclBa?=
 =?utf-8?B?cFJvd3NvdTNEc1V2U2JhVU8zUUcyelR6d3BTK3dBdGM2bTZ5SGxtTlUrT3FK?=
 =?utf-8?B?Qjg4TUJpQXIzVEVkZDJxVUc1V3gvaWNnVi9TTTVqeHRHOW9jdlNQa0h6eklY?=
 =?utf-8?B?bnRDR2ZHalIrbjFMVXpCZUQ5cXNDdWY4MksrQmI1REVrUmpYWTZnSU15cjlo?=
 =?utf-8?B?OGtvc1BmZkhydlNZU09Fdi9XcVpsc1kxaGVESnVUYnUyV1FWblFqM2hQeTI0?=
 =?utf-8?B?clN1bGNwS0NlWW9oazArcTRIaEJFMVJ5MTZrYmd5MW14OWszdmVOWGV0ajAx?=
 =?utf-8?B?T2p5TjNPSkRBd3FGTEhzMzc4dDBBcllmZGZpVGU0WFF4dWVTRklUUUk1dkhm?=
 =?utf-8?B?S051dlR0UVFNWHE4UGxwVkd2T05Ebm1SQ09zS0lXdWRrem5oWEhGTGEzNkJl?=
 =?utf-8?B?WGtVczBpcEp3T1dHYzU5c2dKOG5OeGVuS2JPb3pXS1NwNXhIZXFqZG5RUEZG?=
 =?utf-8?B?dzR3ZGhiOVJKcDBaZHJKQWtoVXRDZTFzZjBNT1l1SkwxWW01TVJEQm5RRzFl?=
 =?utf-8?B?ZDVLN0lYT05GSlVkejlzb0tzcW1Tdzg0MkwveUEyenFZVEhPYnltTXZ2b3RO?=
 =?utf-8?B?YlVXZi82L3JPZlgxcGxMeGFjYk1KQVYwTWt4alg5Z3hqSlNvM2M4VUh0MVpZ?=
 =?utf-8?B?Z2VzYk9Jek5SNHhQdEJpVkNFM1BCWVpmN1dnS3JwdWkvUEtXZTVzVGZXZm8x?=
 =?utf-8?B?dFVUdUxRdDZGdGVrVyszQ3NnM1pDeDhqTjB5VWltdWFZR1AreGhOYk9OY2Fr?=
 =?utf-8?B?UU50V1Zsa25aSVh3MmthVVd3VTVRK0lXeW42V09CTHNEbjRqOEZFV0lUY0Ns?=
 =?utf-8?B?Y0pMYzJFZ1JGTWZZNFp5aVd0V0VsK3cwQ3U3Y1N4TFNLNFYxemltS2FZWWY3?=
 =?utf-8?B?RWc2VXlEbG45VGpiL0V5SGFUTHlZQTZvMG11MncvRVVMNUlqT2dqL1dDZG03?=
 =?utf-8?B?b3orM3VOeEtLenptMzNlbVNKNFBIODc5K2tHMW5BU2NnQXIrYTF2ZE5jdlVX?=
 =?utf-8?B?b1hBQ2ttVUNNazdlaDJsUWV0N1JqbVUvVWZMWTFuOEF2NG5jdU5lSFVyUkNn?=
 =?utf-8?B?OVViS29qVHRSRHMwMnlVMlY2TzR5TDRzOFVnUmVjamI0OFUxbHljUWxkaDJl?=
 =?utf-8?B?d00zR1pCemh5Z2tkc3VyM3JLdzB4SmsvQWtXenpzT21pNTJ6bzkzY0JEQ2J3?=
 =?utf-8?B?WVBPUkhrSmJPZ3d1cVlFQ0tvMVBnVnRvUDRsV3R5dHpMZWpFZG5aNWFLRHph?=
 =?utf-8?B?cUFyN1F5UDRUZXlUVlhiMkZ3Y3JuTnB2VFNFU29ibEFpODIrY3laMnhqRVVL?=
 =?utf-8?B?QkM5QVBqTmxQVllNdnh1QnQxYzNIS0tFZXpKYWZ2b1o2OUt0Wk1KaVJWcVR5?=
 =?utf-8?B?WjBRV2dPNGptMkdOaS82RDlJQVIwa1ZtMXdrM0VyUHlVamtaaG90ajFTSjZC?=
 =?utf-8?B?OTBkaGRHQ3VLWTczbmpDL0ZlRm9hNklmZCs1Wi9OcnkvQnJzUmFRcGdYbUhI?=
 =?utf-8?B?Y0hxeXV1eUFoQzgvc3M0Ti8vSk1wSXpZUnZ5eGlSay9YTHFwTlM0UTdpWTVl?=
 =?utf-8?B?blFDUmtWa1ZPaG1rNmx2WXNmdVpYWlNXWXpxR1RxK29MTlNTZy9qcWxlTW0r?=
 =?utf-8?B?alNSK0Y5eGhKbnFkbVMyUlRxSFdOSTdLck9tTWZ3N2tPSGxaZDY0RVBpYXgv?=
 =?utf-8?B?bFlRNnNHMlYvbHQvWjhoWHZjWEF3MlQ3YTFnNnRGWEJqckd2K2ZlbUJqaVgv?=
 =?utf-8?B?MDRiZGdSQUk3YWg3U0pYVTJjL0lBY1V3QW81SUIzKzNuQkRBODhBbmVlSVJF?=
 =?utf-8?B?R3lJdTduZFNiVGFpS3E4clVRQ2ZWWk4yNGl0Q2E2c0NpUTFsSHpaclJxZUNI?=
 =?utf-8?Q?2qFs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33d8e07-3d51-433a-f936-08dd1dedd52c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:22:27.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0EcD+gQ9Hv+HUKZGdfNZzZon0eF/Mi80Dv9ZhlO8rC2fG/aBpYWik3JXAGzxQW8l1uttJz9TbPsVweMRD4vJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375

On Mon, Dec 16, 2024 at 04:09:41PM +0000, Frank Li wrote:
> Look good! Thanks
>

Sorry for top post, I have not realized these sent to public mail list.
I sent indivial reviewed by tag for each patch and some nit.

Frank

> > -----Original Message-----
> > From: Larisa Ileana Grigore (OSS) <larisa.grigore@oss.nxp.com>
> > Sent: Monday, December 16, 2024 1:58 AM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: dmaengine@vger.kernel.org; imx@lists.linux.dev; linux-
> > kernel@vger.kernel.org; dl-S32 <S32@nxp.com>; Christophe Lizzi
> > <clizzi@redhat.com>; Alberto Ruiz <aruizrui@redhat.com>; Enric Balletbo
> > <eballetb@redhat.com>; Larisa Ileana Grigore (OSS)
> > <larisa.grigore@oss.nxp.com>
> > Subject: [PATCH 0/8] Add eDMAv3 support for S32G2/S32G3 SoCs
> >
> > S32G2 and S32G3 SoCs share the eDMAv3 module with i.MX SoCs, with some
> > hardware
> > integration particularities.
> >
> > S32G2/S32G3 includes two system eDMA instances based on v3 version, each
> > of
> > them integrated with 2 DMAMUX blocks.
> > Another particularity of these SoCs is that the interrupts are shared
> > between
> > channels as follows:
> > - DMA Channels 0-15 share the 'tx-0-15' interrupt
> > - DMA Channels 16-31 share the 'tx-16-31' interrupt
> > - all channels share the 'err' interrupt
> >
> > Larisa Grigore (8):
> >   dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
> >   dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing
> >     muxbase
> >   dmaengine: fsl-edma: move eDMAv2 related registers to a new structure
> >     ’edma2_regs’
> >   dmaengine: fsl-edma: add eDMAv3 registers to edma_regs
> >   dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
> >   dmaengine: fsl-edma: add support for S32G based platforms
> >   dmaengine: fsl-edma: wait until no hardware request is in progress
> >   dmaengine: fsl-edma: read/write multiple registers in cyclic
> >     transactions
> >
> >  .../devicetree/bindings/dma/fsl,edma.yaml     |  34 +++++
> >  drivers/dma/fsl-edma-common.c                 | 112 +++++++++-----
> >  drivers/dma/fsl-edma-common.h                 |  26 +++-
> >  drivers/dma/fsl-edma-main.c                   | 137 ++++++++++++++++--
> >  4 files changed, 257 insertions(+), 52 deletions(-)
> >
> > --
> > 2.47.0
>

