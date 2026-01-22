Return-Path: <dmaengine+bounces-8456-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDTwDvBIcmnpfAAAu9opvQ
	(envelope-from <dmaengine+bounces-8456-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 16:57:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B86952A
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DA997E0A68
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C055834FF6D;
	Thu, 22 Jan 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mc2Mn43P"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021098.outbound.protection.outlook.com [52.101.125.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1534D939;
	Thu, 22 Jan 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093677; cv=fail; b=vDD1SDMc8dloo4LrRKyiKfP9pi0gJNZOsXAuqmKmMOmq1RKKPCkS8ws5JfGUxpsR2KMTFq4uCx1KI9MfygCAVs7zkSjtbZQuLydWCQIzQ+ikazSMx2aML4T6eNNf1Jj31uxafzjxNegZjlf8Pf7+dRaUWDFe9DcX0sPqA82XS8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093677; c=relaxed/simple;
	bh=6SfbQ7u8MA5a8wGwyedihu8BGyCOBkiHOptFL9KM7s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U96va8Zjl8MuwurYlW5mHOwcYKhB4KZRN4eyHI9xyTzyiiAd4eYlBFZA/X42O9N38fOnJgf8X8SFMPhvob+9+2gmwro7Mune308PuJHyvKdtzWt7Jy2W0PVnm7ZXY/W6ZzZ360L/bU7eERa4If9uqo57WKV2Xk+VL6kGrWMlx90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mc2Mn43P; arc=fail smtp.client-ip=52.101.125.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muGNFV75NYbhYceCAnZX8NQ0oFUh6Yvb4NA73vbHRxAv70YUzl/kEgSw09H3IPJEJy/Ca8Vcb1/g4cBld1ExlUohdUBW/Ls3NarhR89Eipkz6Kbam+fKpBCqBE515KC746euMRq6V10cMwrJcNsENrGs1etUL0d7yPZqJw9sq0Jt7mfWTXENSfLycIgpGFImdTbk3ASpVRB4Xt921OWbxXc5g0PQ2YkfuToz6seNABG9oilNIuf7UpmTcdzQVzY7Heb1Y1H5mKqeZAIjZtsI6B0zOBsAJ+K2JGGXwqkBy+VRdJM7jA95yIcArLxBZ48GBfi1gfNWVBIab/Qq3xHQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge0tWYIPmTWe9jsrogR/MhwWq3WLLADbbg+7FPboK5A=;
 b=JGE6Jy5qEg9J8l66XCJB7exo8ysZ1Z+WSS1spOlqnkrjvfsYMoLzA6i0boBhCFOnKuUndODC4GeW/3XyylYdFP5VjrYUkpTPZGDtKAEZe/yuGl/KNpg/2Nr+RsJuMnXIb7/gP2xM+GZIdnExURefiZBxd3MLrENW0kvt2OQXkDmlk9KkTu6omQN1sKDc75pSZWuthtR0b6iZM9WeKq4CIJQu1/hveDiNQi7CVjwg6I2J5+i9ybMiTkf6bFjdk4CbHMnWmEIouVcaxztt3spMfV9HQGhyOmSdCuOgNsY7Am/84sa3o9x6qENlFxHQZBo0pa0Q8ZbS0dzU7Bhm8b0+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge0tWYIPmTWe9jsrogR/MhwWq3WLLADbbg+7FPboK5A=;
 b=mc2Mn43PYrhNUMJs0fLoV9dsG4wsArcjXLL62oRe2uxdlKgniuTCUnR5hQDF6+bT22urPHImnDmRV9F0McdkhlxntcVz7giIzKwXGt2c0HyzUe1W6a+esegVBEGjn7u6+eKoT02F5UHgV1ekDlkL8kVcLoPJhRWGN2G2LkK7ukk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4703.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 14:54:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:54:30 +0000
Date: Thu, 22 Jan 2026 23:54:29 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	jbrunet@baylibre.com, utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 36/38] PCI: endpoint: pci-epf-test: Add remote
 eDMA-backed mode
Message-ID: <tco3mlfhwpa3xjrstad5qqnx5pqv4jgvgqrbjxzkslu5rxxtzy@s4wfm7zt45f4>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-37-den@valinux.co.jp>
 <aW6YX0A0Ogc6KLF5@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW6YX0A0Ogc6KLF5@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0058.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 4710d82d-bdc3-4f5b-1119-08de59c625c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TupIVrkc2jP5pXhPofkua7E2/71PndupRoou2Cz+3SYy8nbuMp23xvdFa7KF?=
 =?us-ascii?Q?5OWfViaFokQucwiasG7ll9sm+460egCApSRVY1qe0S6bTrhoRXD/WtgEynsR?=
 =?us-ascii?Q?g+XW+s0eAWc9CuaivJISwGseXA6PNcCQVCp9FN+4kO/OhFGUJgyT87la99rY?=
 =?us-ascii?Q?/6cIyVd/ymTs8tLjizKonydwxcN56P4X7fOY98/6RCq195BFpxIKCcraSjBM?=
 =?us-ascii?Q?BcZfYzM3oROBBGJ6fAP+NLLD3qxpY2Alvw/SwSORRu4LhsupROykSCxfpcl3?=
 =?us-ascii?Q?wP2y7hFJY3ajoYemvldMiV1e89+3a2pz57liMcmukGF7zK7JfE3QwxUZRCUP?=
 =?us-ascii?Q?I/+dh1cSqGnDD3arZ1w/jrEjFwitodJWg9pg0KQUVjwiIlbK/yheuLt5D1le?=
 =?us-ascii?Q?TYVaH1N58dXMAUdhYqJppPxnS625HUhpjnem+iHed+79ulHbFpSOb/mM305n?=
 =?us-ascii?Q?2ZIpGljVGLIsnsaxqPX3s+hTsssP0R5vbSY/QoGLD3YAmAOz87HYtInL6pUH?=
 =?us-ascii?Q?9He1wlGfcIB720DfosthmXzSMVFoN/qYUxpki9XJpzFa6+G4KviXvX+r2Hc6?=
 =?us-ascii?Q?5vhaqvDUXzbRR1Sh6JhcaQo6ztsyfADu+6cbXwvv2NdRJjVjL6O+cLVhWls3?=
 =?us-ascii?Q?u8SAT2AQj8b5MyoIUrlAAqMH++lPvpZNfGlaPWb14nAzNpy1/dWHBVFVgKGh?=
 =?us-ascii?Q?DFesrFSswZ3bzSeMZU+CVRCRH4hh5CDDHw4wnvJcK0n7CQCHy0prwr4arj0v?=
 =?us-ascii?Q?34MZ2Ij5Yr7zXR6uVamowU3PU1h/H5bHEqtdxWagunsuuwJc2YHEkEdcTkPK?=
 =?us-ascii?Q?9WmOPFD+7EV67qUm6TJil4hmGCiWMPXjC9ee1Jfkt39XWb4Fppf/jediqXcm?=
 =?us-ascii?Q?6mqgXZ5RrdKkBrV7l9tuOv5tfg9BjfNVpa8CHMrz4NakDbb0D3n/dbfLgVga?=
 =?us-ascii?Q?F3oLh05cDvHPSfjS6K4hr4YhU91d8aQ8+UiaQEBdXWaQoKHRts/x6X3r1ols?=
 =?us-ascii?Q?QmYdW/cArCN0RD5YNXxg5NbOJtG5tNk4iQ7pVouW7nImsYM2fOV3X0AIfrk8?=
 =?us-ascii?Q?hNnYXl7jSccZWQ1ED8BOvtW6Bb04oDjk8KCoQHD4qJzpmh2Af3l7vWDOJijd?=
 =?us-ascii?Q?vmMsZj46npQx1l5ts+EYFXs28BRsLgud1SRd6wBtk75ubvKx6R8QJnzK2eIj?=
 =?us-ascii?Q?CCrOnXLPYIqxjHPQks1jIlIGwRYBMWnpm/1DPo/v3/0TyhG0sBLByHotJeXj?=
 =?us-ascii?Q?cuoj5aVisGkIuHIH4av7etmjbj8itapTuI23gNvvlKFzNnqlfBmq0jPQbXGv?=
 =?us-ascii?Q?Oda7KBsHVCnMYVyw9RxIulsnsEMRlqoFQBEx7E8WCt8vwOeGnQzErsr9dkfe?=
 =?us-ascii?Q?TuHYIMEcNPdz8FP9wPYv0OWimqRf66M6UWFnUvmw5OZtbkd7bCuUBgUcpWEL?=
 =?us-ascii?Q?V+4kruz4CYBRnm5CXJJXpZ30cBoGpIFihKe7ewNztDvReaAqmVr1w3n8WCo8?=
 =?us-ascii?Q?MbVAW/hFIl4hmoDwtSHW6gqbP0hL3quIfnCfh9Bx4WhPaWNYmTgDfWOYomE6?=
 =?us-ascii?Q?H19fqCIS4DHzQTqzmZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(18082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hscvOo7GPsx+bAdXkPPbkJDuF4N4I7kIm0JosmIjm4dIuiL8OPxXycjXHNp1?=
 =?us-ascii?Q?B34Ldi5GrRZ6Y5nJyqj2CRfqmkkz6JTA3pyovx3ZnASwDBDMJdZ0rKkp0Son?=
 =?us-ascii?Q?rCYZUCPfSSUa8WPvo3D8zhGhuUkZy7NPkFawnzwDDagZ9QmpKw2g9ujnyoOX?=
 =?us-ascii?Q?vzuq+eRYr02nZUv0YL2vzkStWEYiTd5AdsrvpTS1DTkxpK3gDMCFU7QOR673?=
 =?us-ascii?Q?I1HxoEFtCzjtgKtc/g+1lUbLcLZ+c87ZMiRq7hbJNjv92f6qzLoiU95kRBpO?=
 =?us-ascii?Q?84rnh05nbgqN09pkapl5AWTbwY9Sc6z+wP5rL0b3duvIanxRIOeC6FmEcTBw?=
 =?us-ascii?Q?V+oWvejQXDWETcE5ghaGqVxzudBeZwMOIMLA27zD3ni/aHZ0YkW49Rsy9Yar?=
 =?us-ascii?Q?S0vBaVIgNtQxDD330aE3BkOeSTvLDHwvD+yiUxbtJXy4vYsc6cTDFj39DKew?=
 =?us-ascii?Q?EQvRmi32OVEj8EXpMdME+1kMKm8LLXC5SgMqdrikNmiZvTmLKCTwnxBlnnLE?=
 =?us-ascii?Q?siWwAh3ch5jSsWHgKW9BsHxHnK/YJXrmLbef7NeTGGPX6AUbbAwpJEkpMeQO?=
 =?us-ascii?Q?Yj0+fWc6yQ2oUDEHV+BfGySsI4DMbtu9LFSpHvoOiyPtWYfvOzT7eGN4Hdnj?=
 =?us-ascii?Q?MIQaMSgKnsZICo3lpO9SHUm3WdLWk83n8NvOh5fgly4qO1rxk47fa3b2yT4c?=
 =?us-ascii?Q?i2qVMi40E/Uq1/1P9E922oCglXPlx1XFRptqpWB5KeR/E9uq9KKuBW+u5lHi?=
 =?us-ascii?Q?g3YYDxD/rQbgzs1zlAagh96RbMZcD2Qq9qGCHSt3CHtT/n4NEI9KqSSrVWYS?=
 =?us-ascii?Q?5ROUwJb4vPvYTXZUAi8NBMnGdSoW9VnOeSTtcb3zrAz4pzwd4M4XQFqB7cej?=
 =?us-ascii?Q?naApgtdAZjEtfN0hrv8cEzvb48s9fnBLl95EBZs1cauKl9HSqHewxdVlCCJ1?=
 =?us-ascii?Q?QOAXc6mc4LpsKY07HYZKpdty3iVPP2mywnXZKIGA937yiAE85FDzhIHlYWok?=
 =?us-ascii?Q?pSBzy9rRaIsvtpDX1uC5OaqCKAClHyZS7i1nLwxxzIPjveInuDVzThBW7Pxs?=
 =?us-ascii?Q?TFIFoVFvAlyCgwyoti2Lex+MM1xphytbNHCGaDqfYXCIJ3EmwAZn54Wr79/8?=
 =?us-ascii?Q?41Ja3s3yOjKIiLgiCHmyxwjL0umM0/DO4QsLG3t3vtL015cWY8BQ7StKaHK9?=
 =?us-ascii?Q?cYUyRSZH6o0/8U716G3IOaUba0Pi28t0Rr6KVyFj0jTHeNrnihuhvMG+B5+Z?=
 =?us-ascii?Q?ebFT2AvCev6dltRAGidoKN1rplGCmqN65UrpiQ+wEpgNsX5AQXrUerM753h8?=
 =?us-ascii?Q?qaZufg9d9XgdCL9uM3Ugwks8nkLQtQaA67N3PkYYUcv5sYrJL7lpxLFlK6tr?=
 =?us-ascii?Q?DiGsS0wXy9xzalAN6+Ob60Do0H3wq0hnBZ+qlx2S+I8xKe7BxX4y3dgfpWDQ?=
 =?us-ascii?Q?vQ15KpswjICOq3eN5lm2YMBul4dPzDU4U9yjs90umi7hfVOiz5Z+zasobISW?=
 =?us-ascii?Q?7iBIAT1wWDOShqbL7XkgSNDmcT39bykO/5SZfxYhUKwOQJcItkIjwwSg2pzp?=
 =?us-ascii?Q?rWxNYzMyv3PoG4G0e9wjaJspjVPaLRXNXsV0sH7XTe9s1DQIep6ipjiDQf5D?=
 =?us-ascii?Q?VOLd60Jaas4ANNKuXEAMQfc3AlcHnAjJuHErpq6HPnO754HAvfmq9DoB7CV8?=
 =?us-ascii?Q?xpoAkDCfi9eAwHtNbcecHtRir/1wYBDpuGimeDDXg3LYZHzPi2lGJfY2NYGP?=
 =?us-ascii?Q?JpNE0D5xXq0a9SpnJd/uZgm2tgMjXGejw5uiEgQ9P0dAc51PBZa5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4710d82d-bdc3-4f5b-1119-08de59c625c2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:54:30.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koPdVDLjdIZMMeuisnK/URf/C2d92RHD+B11E6PO90YlPCYHz4hqdE5tXRcDYi+wHselqG/Urdcr3BvStg8KtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4703
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8456-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[valinux.co.jp,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: AA6B86952A
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 03:47:27PM -0500, Frank Li wrote:
> On Sun, Jan 18, 2026 at 10:54:38PM +0900, Koichiro Den wrote:
> > Some DesignWare-based endpoints integrate an eDMA engine that can be
> > programmed by the host via MMIO. The upcoming NTB transport remote-eDMA
> > backend relies on this capability, but there is currently no upstream
> > test coverage for the end-to-end control and data path.
> >
> > Extend pci-epf-test with an optional remote eDMA test backend (built when
> > CONFIG_DW_EDMA is enabled).
> >
> > - Reserve a spare BAR and expose a small 'pcitest_edma_info' header at
> >   BAR offset 0. The header carries a magic/version and describes the
> >   endpoint eDMA register window, per-direction linked-list (LL)
> >   locations and an endpoint test buffer.
> > - Map the eDMA registers and LL locations into that BAR using BAR
> >   subrange mappings (address-match inbound iATU).
> >
> > To run this extra testing, two new endpoint commands are added:
> >   * COMMAND_REMOTE_EDMA_SETUP
> >   * COMMAND_REMOTE_EDMA_CHECKSUM
> >
> > When the former command is received, the endpoint prepares for the
> > remote eDMA transfer. The CHECKSUM command is useful for Host-to-EP
> > transfer testing, as the endpoint side is not expected to receive the
> > DMA completion interrupt directly. Instead, the host asks the endpoint
> > to compute a CRC32 over the transferred data.
> >
> > This backend is exercised by the host-side pci_endpoint_test driver via a
> > new UAPI flag.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 477 ++++++++++++++++++
> 
> This patch should be combined into your submap patches, which is one user
> of submap.

Thanks for the comment, and my apologies for the delayed response to this.

The pci endpoint test case addition depends on both of the following prerequisites:

1) [PATCH v9 0/5] PCI: endpoint: BAR subrange mapping support
   https://lore.kernel.org/all/20260122084909.2390865-1-den@valinux.co.jp/

2) A not-yet-submitted series for Patch 01-05, as described in the "Patch
   layout" section of the cover letter:
   https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/

   [...]
   1. dw-edma / DesignWare EP helpers needed for remote embedded-DMA (export
      register/LL windows, IRQ routing control, etc.)

      Patch 01 : dmaengine: dw-edma: Export helper to get integrated register window
      Patch 02 : dmaengine: dw-edma: Add per-channel interrupt routing control
      Patch 03 : dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
      Patch 04 : dmaengine: dw-edma: Add notify-only channels support
      Patch 05 : dmaengine: dw-edma: Add a helper to query linked-list region
   [...]

   I plan to submit these patches shortly, perhaps as a single series, once the
   design discussion in the following thread is resolved:
   https://lore.kernel.org/all/2bcksnyuxj33bjctjombrstfvjrcdtap6i3v6xhfxtqjmbdkwm@jcaoy2iuh5pr/
   Thank you for reviewing that discussion as well.

Given that (1) precedes (2), it should be reasonable to include the PCI
endpoint test case additions (Patchs 35-38) as part of the series in (2).

Kind regards,
Koichiro

> 
> Frank
> 
> >  1 file changed, 477 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index e560c3becebb..eea10bddcd2a 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/dmaengine.h>
> >  #include <linux/io.h>
> > +#include <linux/iommu.h>
> >  #include <linux/module.h>
> >  #include <linux/msi.h>
> >  #include <linux/slab.h>
> > @@ -33,6 +34,8 @@
> >  #define COMMAND_COPY			BIT(5)
> >  #define COMMAND_ENABLE_DOORBELL		BIT(6)
> >  #define COMMAND_DISABLE_DOORBELL	BIT(7)
> > +#define COMMAND_REMOTE_EDMA_SETUP	BIT(8)
> > +#define COMMAND_REMOTE_EDMA_CHECKSUM	BIT(9)
> >
> >  #define STATUS_READ_SUCCESS		BIT(0)
> >  #define STATUS_READ_FAIL		BIT(1)
> > @@ -48,6 +51,10 @@
> >  #define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
> >  #define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
> >  #define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
> > +#define STATUS_REMOTE_EDMA_SETUP_SUCCESS	BIT(14)
> > +#define STATUS_REMOTE_EDMA_SETUP_FAIL		BIT(15)
> > +#define STATUS_REMOTE_EDMA_CHECKSUM_SUCCESS	BIT(16)
> > +#define STATUS_REMOTE_EDMA_CHECKSUM_FAIL	BIT(17)
> >
> >  #define FLAG_USE_DMA			BIT(0)
> >
> > @@ -77,6 +84,9 @@ struct pci_epf_test {
> >  	bool			dma_private;
> >  	const struct pci_epc_features *epc_features;
> >  	struct pci_epf_bar	db_bar;
> > +
> > +	/* For extended tests that rely on vendor-specific features */
> > +	void *data;
> >  };
> >
> >  struct pci_epf_test_reg {
> > @@ -117,6 +127,454 @@ static enum pci_barno pci_epf_test_next_free_bar(struct pci_epf_test *epf_test)
> >  	return bar;
> >  }
> >
> > +#if IS_REACHABLE(CONFIG_DW_EDMA)
> > +#include <linux/dma/edma.h>
> > +
> > +#define PCITEST_EDMA_INFO_MAGIC		0x414d4445U /* 'EDMA' */
> > +#define PCITEST_EDMA_INFO_VERSION	0x00010000U
> > +#define PCITEST_EDMA_TEST_BUF_SIZE	(1024 * 1024)
> > +
> > +struct pci_epf_test_edma {
> > +	/* Remote eDMA test resources */
> > +	bool			enabled;
> > +	enum pci_barno		bar;
> > +	void			*info;
> > +	size_t			total_size;
> > +	void			*test_buf;
> > +	dma_addr_t		test_buf_phys;
> > +	size_t			test_buf_size;
> > +
> > +	/* DW eDMA specifics */
> > +	phys_addr_t		reg_phys;
> > +	size_t			reg_submap_sz;
> > +	unsigned long		reg_iova;
> > +	size_t			reg_iova_sz;
> > +	phys_addr_t		ll_rd_phys;
> > +	size_t			ll_rd_sz_aligned;
> > +	phys_addr_t		ll_wr_phys;
> > +	size_t			ll_wr_sz_aligned;
> > +};
> > +
> > +struct pcitest_edma_info {
> > +	__le32 magic;
> > +	__le32 version;
> > +
> > +	__le32 reg_off;
> > +	__le32 reg_size;
> > +
> > +	__le64 ll_rd_phys;
> > +	__le32 ll_rd_off;
> > +	__le32 ll_rd_size;
> > +
> > +	__le64 ll_wr_phys;
> > +	__le32 ll_wr_off;
> > +	__le32 ll_wr_size;
> > +
> > +	__le64 test_buf_phys;
> > +	__le32 test_buf_size;
> > +};
> > +
> > +static bool pci_epf_test_bar_is_reserved(struct pci_epf_test *test,
> > +					 enum pci_barno barno)
> > +{
> > +	struct pci_epf_test_edma *edma = test->data;
> > +
> > +	if (!edma)
> > +		return false;
> > +
> > +	return barno == edma->bar;
> > +}
> > +
> > +static void pci_epf_test_clear_submaps(struct pci_epf_bar *bar)
> > +{
> > +	kfree(bar->submap);
> > +	bar->submap = NULL;
> > +	bar->num_submap = 0;
> > +}
> > +
> > +static int pci_epf_test_add_submap(struct pci_epf_bar *bar, phys_addr_t phys,
> > +				   size_t size)
> > +{
> > +	struct pci_epf_bar_submap *submap, *new;
> > +
> > +	new = krealloc_array(bar->submap, bar->num_submap + 1, sizeof(*new),
> > +			     GFP_KERNEL);
> > +	if (!new)
> > +		return -ENOMEM;
> > +
> > +	bar->submap = new;
> > +	submap = &bar->submap[bar->num_submap];
> > +	submap->phys_addr = phys;
> > +	submap->size = size;
> > +	bar->num_submap++;
> > +
> > +	return 0;
> > +}
> > +
> > +static void pci_epf_test_clean_remote_edma(struct pci_epf_test *test)
> > +{
> > +	struct pci_epf_test_edma *edma = test->data;
> > +	struct pci_epf *epf = test->epf;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct device *dev = epc->dev.parent;
> > +	struct iommu_domain *dom;
> > +	struct pci_epf_bar *bar;
> > +	enum pci_barno barno;
> > +
> > +	if (!edma)
> > +		return;
> > +
> > +	barno = edma->bar;
> > +	if (barno == NO_BAR)
> > +		return;
> > +
> > +	bar = &epf->bar[barno];
> > +
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (dom && edma->reg_iova_sz) {
> > +		iommu_unmap(dom, edma->reg_iova, edma->reg_iova_sz);
> > +		edma->reg_iova = 0;
> > +		edma->reg_iova_sz = 0;
> > +	}
> > +
> > +	if (edma->test_buf) {
> > +		dma_free_coherent(dev, edma->test_buf_size,
> > +				  edma->test_buf,
> > +				  edma->test_buf_phys);
> > +		edma->test_buf = NULL;
> > +		edma->test_buf_phys = 0;
> > +		edma->test_buf_size = 0;
> > +	}
> > +
> > +	if (edma->info) {
> > +		pci_epf_free_space(epf, edma->info, barno, PRIMARY_INTERFACE);
> > +		edma->info = NULL;
> > +	}
> > +
> > +	pci_epf_test_clear_submaps(bar);
> > +	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > +
> > +	edma->bar = NO_BAR;
> > +	edma->enabled = false;
> > +}
> > +
> > +static int pci_epf_test_init_remote_edma(struct pci_epf_test *test)
> > +{
> > +	const struct pci_epc_features *epc_features = test->epc_features;
> > +	struct pci_epf_test_edma *edma;
> > +	struct pci_epf *epf = test->epf;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct pcitest_edma_info *info;
> > +	struct device *dev = epc->dev.parent;
> > +	struct dw_edma_region region;
> > +	struct iommu_domain *dom;
> > +	size_t reg_sz_aligned, ll_rd_sz_aligned, ll_wr_sz_aligned;
> > +	phys_addr_t phys, ll_rd_phys, ll_wr_phys;
> > +	size_t ll_rd_size, ll_wr_size;
> > +	resource_size_t reg_size;
> > +	unsigned long iova;
> > +	size_t off, size;
> > +	int ret;
> > +
> > +	if (!test->dma_chan_tx || !test->dma_chan_rx)
> > +		return -ENODEV;
> > +
> > +	edma = devm_kzalloc(&epf->dev, sizeof(*edma), GFP_KERNEL);
> > +	if (!edma)
> > +		return -ENOMEM;
> > +	test->data = edma;
> > +
> > +	edma->bar = pci_epf_test_next_free_bar(test);
> > +	if (edma->bar == NO_BAR) {
> > +		dev_err(&epf->dev, "No spare BAR for remote eDMA (remote eDMA disabled)\n");
> > +		ret = -ENOSPC;
> > +		goto err;
> > +	}
> > +
> > +	ret = dw_edma_get_reg_window(epc, &edma->reg_phys, &reg_size);
> > +	if (ret) {
> > +		dev_err(dev, "failed to get edma reg window: %d\n", ret);
> > +		goto err;
> > +	}
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (dom) {
> > +		phys = edma->reg_phys & PAGE_MASK;
> > +		size = PAGE_ALIGN(reg_size + edma->reg_phys - phys);
> > +		iova = phys;
> > +
> > +		ret = iommu_map(dom, iova, phys, size,
> > +				IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO,
> > +				GFP_KERNEL);
> > +		if (ret) {
> > +			dev_err(dev, "failed to direct map eDMA reg: %d\n", ret);
> > +			goto err;
> > +		}
> > +		edma->reg_iova = iova;
> > +		edma->reg_iova_sz = size;
> > +	}
> > +
> > +	/* Get LL location addresses and sizes */
> > +	ret = dw_edma_chan_get_ll_region(test->dma_chan_rx, &region);
> > +	if (ret) {
> > +		dev_err(dev, "failed to get edma ll region for rx: %d\n", ret);
> > +		goto err;
> > +	}
> > +	ll_rd_phys = region.paddr;
> > +	ll_rd_size = region.sz;
> > +
> > +	ret = dw_edma_chan_get_ll_region(test->dma_chan_tx, &region);
> > +	if (ret) {
> > +		dev_err(dev, "failed to get edma ll region for tx: %d\n", ret);
> > +		goto err;
> > +	}
> > +	ll_wr_phys = region.paddr;
> > +	ll_wr_size = region.sz;
> > +
> > +	edma->test_buf_size = PCITEST_EDMA_TEST_BUF_SIZE;
> > +	edma->test_buf = dma_alloc_coherent(dev, edma->test_buf_size,
> > +					    &edma->test_buf_phys, GFP_KERNEL);
> > +	if (!edma->test_buf) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	reg_sz_aligned = PAGE_ALIGN(reg_size);
> > +	ll_rd_sz_aligned = PAGE_ALIGN(ll_rd_size);
> > +	ll_wr_sz_aligned = PAGE_ALIGN(ll_wr_size);
> > +	edma->total_size = PAGE_SIZE + reg_sz_aligned + ll_rd_sz_aligned +
> > +			   ll_wr_sz_aligned;
> > +	size = roundup_pow_of_two(edma->total_size);
> > +
> > +	info = pci_epf_alloc_space(epf, size, edma->bar,
> > +				   epc_features, PRIMARY_INTERFACE);
> > +	if (!info) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +	memset(info, 0, size);
> > +
> > +	off = PAGE_SIZE;
> > +	info->magic = cpu_to_le32(PCITEST_EDMA_INFO_MAGIC);
> > +	info->version = cpu_to_le32(PCITEST_EDMA_INFO_VERSION);
> > +
> > +	info->reg_off = cpu_to_le32(off);
> > +	info->reg_size = cpu_to_le32(reg_size);
> > +	off += reg_sz_aligned;
> > +
> > +	info->ll_rd_phys = cpu_to_le64(ll_rd_phys);
> > +	info->ll_rd_off = cpu_to_le32(off);
> > +	info->ll_rd_size = cpu_to_le32(ll_rd_size);
> > +	off += ll_rd_sz_aligned;
> > +
> > +	info->ll_wr_phys = cpu_to_le64(ll_wr_phys);
> > +	info->ll_wr_off = cpu_to_le32(off);
> > +	info->ll_wr_size = cpu_to_le32(ll_wr_size);
> > +	off += ll_wr_sz_aligned;
> > +
> > +	info->test_buf_phys = cpu_to_le64(edma->test_buf_phys);
> > +	info->test_buf_size = cpu_to_le32(edma->test_buf_size);
> > +
> > +	edma->info = info;
> > +	edma->reg_submap_sz = reg_sz_aligned;
> > +	edma->ll_rd_phys = ll_rd_phys;
> > +	edma->ll_wr_phys = ll_wr_phys;
> > +	edma->ll_rd_sz_aligned = ll_rd_sz_aligned;
> > +	edma->ll_wr_sz_aligned = ll_wr_sz_aligned;
> > +
> > +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
> > +			      &epf->bar[edma->bar]);
> > +	if (ret) {
> > +		dev_err(dev,
> > +			"failed to init BAR%d for remote eDMA: %d\n",
> > +			edma->bar, ret);
> > +		goto err;
> > +	}
> > +	dev_info(dev, "BAR%d initialized for remote eDMA\n", edma->bar);
> > +
> > +	return 0;
> > +
> > +err:
> > +	pci_epf_test_clean_remote_edma(test);
> > +	devm_kfree(&epf->dev, edma);
> > +	test->data = NULL;
> > +	return ret;
> > +}
> > +
> > +static int pci_epf_test_map_remote_edma(struct pci_epf_test *test)
> > +{
> > +	struct pci_epf_test_edma *edma = test->data;
> > +	struct pcitest_edma_info *info;
> > +	struct pci_epf *epf = test->epf;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct pci_epf_bar *bar;
> > +	enum pci_barno barno;
> > +	struct device *dev = epc->dev.parent;
> > +	int ret;
> > +
> > +	if (!edma)
> > +		return -ENODEV;
> > +
> > +	info = edma->info;
> > +	barno = edma->bar;
> > +
> > +	if (barno == NO_BAR)
> > +		return -ENOSPC;
> > +	if (!info || !edma->test_buf)
> > +		return -ENODEV;
> > +
> > +	bar = &epf->bar[barno];
> > +	pci_epf_test_clear_submaps(bar);
> > +
> > +	ret = pci_epf_test_add_submap(bar, bar->phys_addr, PAGE_SIZE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pci_epf_test_add_submap(bar, edma->reg_phys, edma->reg_submap_sz);
> > +	if (ret)
> > +		goto err_submap;
> > +
> > +	ret = pci_epf_test_add_submap(bar, edma->ll_rd_phys,
> > +				      edma->ll_rd_sz_aligned);
> > +	if (ret)
> > +		goto err_submap;
> > +
> > +	ret = pci_epf_test_add_submap(bar, edma->ll_wr_phys,
> > +				      edma->ll_wr_sz_aligned);
> > +	if (ret)
> > +		goto err_submap;
> > +
> > +	if (bar->size > edma->total_size) {
> > +		ret = pci_epf_test_add_submap(bar, 0,
> > +					      bar->size - edma->total_size);
> > +		if (ret)
> > +			goto err_submap;
> > +	}
> > +
> > +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > +	if (ret) {
> > +		dev_err(dev, "failed to map BAR%d: %d\n", barno, ret);
> > +		goto err_submap;
> > +	}
> > +
> > +	/*
> > +	 * Endpoint-local interrupts must be ignored even if the host fails to
> > +	 * mask them.
> > +	 */
> > +	ret = dw_edma_chan_irq_config(test->dma_chan_tx, DW_EDMA_CH_IRQ_REMOTE);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set irq mode for tx channel: %d\n",
> > +			ret);
> > +		goto err_bar;
> > +	}
> > +	ret = dw_edma_chan_irq_config(test->dma_chan_rx, DW_EDMA_CH_IRQ_REMOTE);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set irq mode for rx channel: %d\n",
> > +			ret);
> > +		goto err_bar;
> > +	}
> > +
> > +	return 0;
> > +err_bar:
> > +	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[barno]);
> > +err_submap:
> > +	pci_epf_test_clear_submaps(bar);
> > +	return ret;
> > +}
> > +
> > +static void pci_epf_test_remote_edma_setup(struct pci_epf_test *epf_test,
> > +					   struct pci_epf_test_reg *reg)
> > +{
> > +	struct pci_epf_test_edma *edma = epf_test->data;
> > +	size_t size = le32_to_cpu(reg->size);
> > +	void *buf;
> > +	int ret;
> > +
> > +	if (!edma || !edma->test_buf || size > edma->test_buf_size) {
> > +		reg->status = cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_FAIL);
> > +		return;
> > +	}
> > +
> > +	buf = edma->test_buf;
> > +
> > +	if (!edma->enabled) {
> > +		/* NB. Currently DW eDMA is the only supported backend */
> > +		ret = pci_epf_test_map_remote_edma(epf_test);
> > +		if (ret) {
> > +			WRITE_ONCE(reg->status,
> > +				   cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_FAIL));
> > +			return;
> > +		}
> > +		edma->enabled = true;
> > +	}
> > +
> > +	/* Populate the test buffer with random data */
> > +	get_random_bytes(buf, size);
> > +	reg->checksum = cpu_to_le32(crc32_le(~0, buf, size));
> > +
> > +	WRITE_ONCE(reg->status, cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_SUCCESS));
> > +}
> > +
> > +static void pci_epf_test_remote_edma_checksum(struct pci_epf_test *epf_test,
> > +					      struct pci_epf_test_reg *reg)
> > +{
> > +	struct pci_epf_test_edma *edma = epf_test->data;
> > +	u32 status = le32_to_cpu(reg->status);
> > +	size_t size;
> > +	void *addr;
> > +	u32 crc32;
> > +
> > +	size = le32_to_cpu(reg->size);
> > +	if (!edma || !edma->test_buf || size > edma->test_buf_size) {
> > +		status |= STATUS_REMOTE_EDMA_CHECKSUM_FAIL;
> > +		reg->status = cpu_to_le32(status);
> > +		return;
> > +	}
> > +
> > +	addr = edma->test_buf;
> > +	crc32 = crc32_le(~0, addr, size);
> > +	status |= STATUS_REMOTE_EDMA_CHECKSUM_SUCCESS;
> > +
> > +	reg->checksum = cpu_to_le32(crc32);
> > +	reg->status = cpu_to_le32(status);
> > +}
> > +
> > +static void pci_epf_test_reset_dma_chan(struct dma_chan *chan)
> > +{
> > +	dw_edma_chan_irq_config(chan, DW_EDMA_CH_IRQ_DEFAULT);
> > +}
> > +#else
> > +static bool pci_epf_test_bar_is_reserved(struct pci_epf_test *test,
> > +					 enum pci_barno barno)
> > +{
> > +	return false;
> > +}
> > +
> > +static void pci_epf_test_clean_remote_edma(struct pci_epf_test *test)
> > +{
> > +}
> > +
> > +static int pci_epf_test_init_remote_edma(struct pci_epf_test *test)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static void pci_epf_test_remote_edma_setup(struct pci_epf_test *epf_test,
> > +					   struct pci_epf_test_reg *reg)
> > +{
> > +	reg->status = cpu_to_le32(STATUS_REMOTE_EDMA_SETUP_FAIL);
> > +}
> > +
> > +static void pci_epf_test_remote_edma_checksum(struct pci_epf_test *epf_test,
> > +					      struct pci_epf_test_reg *reg)
> > +{
> > +	reg->status = cpu_to_le32(STATUS_REMOTE_EDMA_CHECKSUM_FAIL);
> > +}
> > +
> > +static void pci_epf_test_reset_dma_chan(struct dma_chan *chan)
> > +{
> > +}
> > +#endif
> > +
> >  static void pci_epf_test_dma_callback(void *param)
> >  {
> >  	struct pci_epf_test *epf_test = param;
> > @@ -168,6 +626,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >  		return -EINVAL;
> >  	}
> >
> > +	pci_epf_test_reset_dma_chan(chan);
> > +
> >  	if (epf_test->dma_private) {
> >  		sconf.direction = dir;
> >  		if (dir == DMA_MEM_TO_DEV)
> > @@ -870,6 +1330,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
> >  		pci_epf_test_disable_doorbell(epf_test, reg);
> >  		pci_epf_test_raise_irq(epf_test, reg);
> >  		break;
> > +	case COMMAND_REMOTE_EDMA_SETUP:
> > +		pci_epf_test_remote_edma_setup(epf_test, reg);
> > +		pci_epf_test_raise_irq(epf_test, reg);
> > +		break;
> > +	case COMMAND_REMOTE_EDMA_CHECKSUM:
> > +		pci_epf_test_remote_edma_checksum(epf_test, reg);
> > +		pci_epf_test_raise_irq(epf_test, reg);
> > +		break;
> >  	default:
> >  		dev_err(dev, "Invalid command 0x%x\n", command);
> >  		break;
> > @@ -961,6 +1429,10 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
> >  	if (ret)
> >  		epf_test->dma_supported = false;
> >
> > +	ret = pci_epf_test_init_remote_edma(epf_test);
> > +	if (ret && ret != -EOPNOTSUPP)
> > +		dev_warn(dev, "Remote eDMA setup failed\n");
> > +
> >  	if (epf->vfunc_no <= 1) {
> >  		ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
> >  		if (ret) {
> > @@ -1007,6 +1479,7 @@ static void pci_epf_test_epc_deinit(struct pci_epf *epf)
> >  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >
> >  	cancel_delayed_work_sync(&epf_test->cmd_handler);
> > +	pci_epf_test_clean_remote_edma(epf_test);
> >  	pci_epf_test_clean_dma_chan(epf_test);
> >  	pci_epf_test_clear_bar(epf);
> >  }
> > @@ -1076,6 +1549,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >  		if (bar == test_reg_bar)
> >  			continue;
> >
> > +		if (pci_epf_test_bar_is_reserved(epf_test, bar))
> > +			continue;
> > +
> >  		if (epc_features->bar[bar].type == BAR_FIXED)
> >  			test_reg_size = epc_features->bar[bar].fixed_size;
> >  		else
> > @@ -1146,6 +1622,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> >
> >  	cancel_delayed_work_sync(&epf_test->cmd_handler);
> >  	if (epc->init_complete) {
> > +		pci_epf_test_clean_remote_edma(epf_test);
> >  		pci_epf_test_clean_dma_chan(epf_test);
> >  		pci_epf_test_clear_bar(epf);
> >  	}
> > --
> > 2.51.0
> >

