Return-Path: <dmaengine+bounces-3986-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE19F3563
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 17:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD281188A285
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51825148FF0;
	Mon, 16 Dec 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GoQfp5Jw"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2069.outbound.protection.outlook.com [40.107.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20513B2AF;
	Mon, 16 Dec 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365387; cv=fail; b=RBELGwigwuB6r8f+hOLFA4N2/y2FxU3hMKJ6t5SQeXRxv75UO7nSFCBnJ73i6hqs43U0Ci6BCBOXvV9umDrDAs928yLnYnF279r146nERycn4vr4NbnRkDbB+xi4i5m3yVsK6/4YPYXQRE9LD/d1QzH8LZSpHwLfgZvXmZ3gcgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365387; c=relaxed/simple;
	bh=YbALVYf15BDcXq7+1lxvEbJYjvbtVvo+XRYYLO6Zl0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bNZc47Glva4UK0+4uBEYeIz0qzShYhY+q35xMlv3Bh3lA8gZLxsndB4bypFd/wSlX02MNNRr1a2f3miA/Prp+SgdeiieQ9xe6NRlABYimWdFyMW4F0JcMGDj5ArlmTktSL/0N5ts2mZRcV3JXtGX0aiA8yGL4ru2x59CVJZPDVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GoQfp5Jw; arc=fail smtp.client-ip=40.107.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOjY9AyM8cMu+0DBRzqLiRfDH3lBulojKL7XxJSwcZTO0OB6o9MlPPhznd5n+d1hBETgnPfLSwEB3/QPQ8bUkRF/718PUSixb5tU/PSnlnA3HNZPUVtjVcUyLtWGVjtiqpe/cy0C8rlg6l+OVlWrQHn7x+97qmWabHoWL7/EhG/tSNN5wP3DTR43Orqhovm9VJQmDjKKPTqDytSHn8q/dnC8pS+PECSRYN+lsRwm3NpBdF1C4cu9mWk3HwP0fjxa0MuBAXcGGqxZu+bphGyKVNCx7qi/03IwRGaRQNwyqKAuwDvPzg0J0fq1YTNKFvMCyDL20eXBqLJeh3SHMDuRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbALVYf15BDcXq7+1lxvEbJYjvbtVvo+XRYYLO6Zl0E=;
 b=OTGOj27RwR22isbn+Rbgx3vPcKspidHL47RgcvchMq+OtD/Ilo4Yt0CGS43N6BQXyRvlqZruykAGO68cmIvueUu0fvwlrejQZYH2yutby2yJ9ryUUlqieUyOLSwSvIULCP7jPwDEF+KHQvxj+wTiKgqHiXbGbSkl+Kuj1x84wb2GWPuqO7RP/wP1CdmG3HlQ5x8+sixxGo52YD4NPOhZ3VlqFCkJc7mS1z3T8YWZxHRXP924pptEDZT+KzbxzyIEzHi6o0gQEwKf3UIRwwsbQ7BBdDwynp9jw12hAY3OGCsrfaB7zqeeHzym5+bdowX+Xyy2IM2dJhQTWaUMCrgz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbALVYf15BDcXq7+1lxvEbJYjvbtVvo+XRYYLO6Zl0E=;
 b=GoQfp5JwYoM8maflz+K+L2fXXg5bxswmP9E12/BGJhM29xTLn29ohYCTPfVHfBTRgV1snjAkUNmR68/Mg50rNqGLBSNrED3Tqowpt2R979ZjpdmKTz/LAp/1rqxsPb7tUjidBFzdhOEmtw7JiZYDj3igsdPEMVPc3uYhyd4mWUZ4Yj04oGoyxce/riILhW/oqyXLy8++xEIJXmMso1ADntx7900ndKhezbYObE0QBY68RKNylvkfYZzCm0Br108hJS2KgrKiKnieavmH8fjHzz4k38Edq+BAX3xmrBk4PFdHB6VZsSZNJ1Zxy40YcF+GGjWNMKMPL6TLw3Yod/YkBA==
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9502.eurprd04.prod.outlook.com (2603:10a6:20b:4d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:09:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:09:41 +0000
From: Frank Li <frank.li@nxp.com>
To: "Larisa Ileana Grigore (OSS)" <larisa.grigore@oss.nxp.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-S32 <S32@nxp.com>, Christophe Lizzi
	<clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo
	<eballetb@redhat.com>
Subject: RE: [PATCH 0/8] Add eDMAv3 support for S32G2/S32G3 SoCs
Thread-Topic: [PATCH 0/8] Add eDMAv3 support for S32G2/S32G3 SoCs
Thread-Index: AQHbT5BJFOZ9M0xDw0uyDZlnR0EPmrLpCpNA
Date: Mon, 16 Dec 2024 16:09:41 +0000
Message-ID:
 <PAXPR04MB9642E90B1C19B7889E17A6A8883B2@PAXPR04MB9642.eurprd04.prod.outlook.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
In-Reply-To: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9642:EE_|AS1PR04MB9502:EE_
x-ms-office365-filtering-correlation-id: 19971f19-6a5b-49f5-f40d-08dd1dec0c46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3IwRzNYNmN4SHZiMGlYUkRBZENpSE1DYVlKVzNUSUtjUktkcVhKNERIUlgv?=
 =?utf-8?B?SDlQTkJZMElvNExMWE81OGhUbGFsQzMrdkxNL1lvSTQ5SDl6eDY4OUxyZHZE?=
 =?utf-8?B?cXJlTEU0WWNUTjcwcG1CQWtCSFhDVklHb2s1dVBRb1hMeUNTTVN1akc2OUo5?=
 =?utf-8?B?TUpMUVVMM2dqcFlXejJUWllWbEtTR1VRT2hYQjdIOXRhRmR0NmpGNFB5ZTlM?=
 =?utf-8?B?aWxydU50T0h5TTk0RU9PYitEc0R5WU9mMmNwOUlYMHhucG53UVllY21ZMGpE?=
 =?utf-8?B?NTl6ZmdnNHpZaVBNUXo2elhzUkxjbFZUTU1ITG1aWFVRdHlEUTlhZkRrTWFY?=
 =?utf-8?B?cm1TSkN3QmtuVXZQV1Z2NEFIUlVZS3NwdGtCZy9ySC9CVzUyR2g4UURlTTZH?=
 =?utf-8?B?QTNPbndJRjNBQjFZSHRXN2wwbjVBcXI3WGlCcldpWTJoRHhDN0hQaHRNRnJ3?=
 =?utf-8?B?Q05CM2E0YU5MYU85b2UrM3VVZlFTMnR4b1FWVGdDOHZpRFl4cWZQZU1UdkpC?=
 =?utf-8?B?SnZFaHczTkFBdW8vNE1LMkM0N1pQOVhGN1N1WFV5dU9zMGswU25NRlhHYVpv?=
 =?utf-8?B?YmpDUXVTQXVyNGk3V3hhMUlHaVZGSkhmNXdxbTFMTWpqanZkb0dFNENQYVRj?=
 =?utf-8?B?M3VMSVlRWlQ3WURPVlUwdk50dnlRNzQ3QW9Dd1RaaEhPOEtIMzB2c2VyYk5t?=
 =?utf-8?B?OXR2b2lQek1vRFByVGdBeWVuSnh0MDR4VUpTbTBBeDhPTXZqa1JUSENHNis2?=
 =?utf-8?B?Y1B0UzMwWmQzSnBjU2dpZzZOcFNISlJ6KzRGdWFNZkZXMEJFOHowZFV0Qzh6?=
 =?utf-8?B?KzJxSjVBRFY4cVdCdzg5eG5RVjRXM2YrUWF5Ymk5ajlkUlZueVNJcGpDOHpQ?=
 =?utf-8?B?aG5ZWS9keG9kUDliL1JVbFFMRmJPMUd0UHJ2ZmY1dk1HWXJOd0ZnWXBIaVd0?=
 =?utf-8?B?T1JpajVYL1NSWFcwSHpKcFE2b3Z0NWt0VktEdXJFWW52REFCRFhKTXY5QjM0?=
 =?utf-8?B?S0o1V0ZlU2pGWk1FcVJTa2tLZk9Eb3NydGw2M3FFb1BOSjlaVTU3cU04bEt6?=
 =?utf-8?B?eWY5OVJNM2dmM1RYT2ZjQzQzMGM0ZllFVldlQzE0aHVVU3VWaFFmTURycUlD?=
 =?utf-8?B?S3NINjhQTTR3RS9IRnRxQkJIMGk5OXY2OHFZUUF6ZGk3RExhZHVoSm5IaDRj?=
 =?utf-8?B?dVhtUHc5aC9JOXk1Ym9wT1pHeHdWU2sxZU9OM01ab09BNzN5UlRKaE9QTllR?=
 =?utf-8?B?Wlc5TUttUjlncC9qbWltUkhPanBiU0lOUFdERTVqWStFMzg2YUw3THNjdDY3?=
 =?utf-8?B?dkVFUURPM1BCdWxoUWlhT3NFWHNxK1VCaUtMb0VhMFFNN3dwek5qWnhPNlNk?=
 =?utf-8?B?SUhPREJZeWNSVGJFUTdMRXQ3WEFvZ1p0Q2g0YjJqczdhcThnR2Jsb1VRamcv?=
 =?utf-8?B?WGVRNjI4bnUwYjZFTUo1OW9OWFRra2J2b1lCMDFDRGRYUDV4eEJSS2xPZVUy?=
 =?utf-8?B?UHl6QU96U0FxN0hYMTlXUHliVTJWS0JWbnZJdG5SREJvRmwySzNIWVR3bkhW?=
 =?utf-8?B?dFJTNlU1aFpjTkl3RFVuQW84OVBKU3ZOVnd2Y2lsa3d6TTk0WlplUDg1VUlN?=
 =?utf-8?B?QVBjUDRsOVlZaGFNM1JXZE0rQ2Z3QTZPaGlHNnRHTmdNYTdPUFlaU25wR0dL?=
 =?utf-8?B?aDlDQTl1TkdyK3FGVnJicVJrQTBJK1VVcnp6ckZKV3VGTHd3M2JlOTNSNFdL?=
 =?utf-8?B?QVNzQ0g1SmtGcVRuZW03N3YzWW1MZHIrUkgyZml2U2RWYXdjL1RMeTlDZ3h4?=
 =?utf-8?B?ODg1VnJtb2RxUy9Ya2F6d2QxcjRGK3NmMHFMUlhDUXZoT0xZWG9UOG95U21z?=
 =?utf-8?B?N0ZuNk9RSzJGaFo4ZmNyOXVvRlN5K3lwUDkxdVNwSGVjOENqVFp1V25XM1FU?=
 =?utf-8?Q?5p1CDbuf1F8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qk94MWJTSjVxd2FHVCs1bXVPZFZNdk5ZK2p5djlCMUJLSkw1VTd4a0JJMm9Z?=
 =?utf-8?B?ZllpejlBcVNYZG9seU1WbTJ6RFlpR2NlOWJGN1lpeUlOOVBtM0FyM0RHVmRn?=
 =?utf-8?B?U1Q3U3RNa3hMU3Qxem5qR3VtRFhmQ2VpRW1lcmEvL24xWTFhV0s1NnliSU9r?=
 =?utf-8?B?eFlGSzNOOGxuVEdTY0hDU1gwdkZEYkVBaVJKZnZLbnE1MkE4N2N0OCtHSVBQ?=
 =?utf-8?B?V0o3VjlDR1FqcWo4TXdlZXNzZHhtWWs1S3gyOEp2TGw2WU51aHB0OGFwUVA3?=
 =?utf-8?B?cmZYYWhhREtKM0h2OWNNQk5iWTUvL1Q5dGpYekhDeUx1eXIrUjY3SDZQOGZI?=
 =?utf-8?B?eTRmaEJuKzlxb1pUWm9YRTk5OHZaQ3NQUDNvamxqZ2RCL05LTzczNmcxZjA2?=
 =?utf-8?B?Q2Y2YzdEV3dqdGR2Q0dRc0tWRlVUWEZBOFNZZUhpWUhkTlBlRmE2YlZiQVRv?=
 =?utf-8?B?NHhuY29BVkc0UTJCQnk4MkMwZHN3RDRYUE1ybGtBeVd2eEtBcit6RzBvYkxW?=
 =?utf-8?B?NzhwSllzLzhRbFNtTk13Uk9Eb1F4dnJXaVlwYnlDYTFjYk5OaENrZE1GSHhq?=
 =?utf-8?B?dGpJc1pTcTFUU2VjbUg1Z2lvWEpSK3IzczlZQXo4ZytkNExObm84L3lSSERw?=
 =?utf-8?B?VVlQTWp0dVJGVG5TbFU0by9oa3ZCOUFOUWc1cXRyR3J2U0p2NVVjbmgrcjBq?=
 =?utf-8?B?NmtOSTFUN0NDdkJUd2VLZGwzeDc3ckpieVd1OVlWaEFhRVlGelREaUpQS0l6?=
 =?utf-8?B?UHlXOWV2cTZKcXl2SitzbG9mOVVWZFRUdzBEcTI1eWxvYjl5SmRiMWtscFRG?=
 =?utf-8?B?U3ltYVdDNTVNMHkzdHJVWkFUc095SmF1U2QvdW5MekpJU0FPUmR5WnRpbXZo?=
 =?utf-8?B?L3k2YzJkZDVjanJBOHpoaHhybFhhZWtIUkpsTDNIRFpuVkFPV0xhdmNsYlBJ?=
 =?utf-8?B?eXh5MTFxRWxtTzYrU1R2Z01rYzlsZkF1OUY3RkNUMTVtK1VXNml3WWFTeUlz?=
 =?utf-8?B?MTJpbWtsb2NFRElZSnlCQm9ON05EZWxLZUNEa0RNeVRjK0pqa1loL1JKQXJX?=
 =?utf-8?B?alJvTGpuNGtJZnJYeVFXK1BtU3BINlV6ZzY4am02Z1VZZDJUajJmSU9TL3cw?=
 =?utf-8?B?R29UZWdZYjg0aksyQ2xyang4T2hSYndMaUsvNUJGTUxYNXhEaisrSW5iaDFH?=
 =?utf-8?B?VVJhUHp4cWYvSXRHdHhxYjBwd09VQ3FTTzIvcERIcy9Tamh2VTFRR1MxZGpz?=
 =?utf-8?B?SUY4d2JheG9ud2VYYXA4WllScUJCVktCMHJSeTU3RWNQK3pGOVJlSDJNZmFT?=
 =?utf-8?B?d2x6YkhlbFRONkwrOFZDOWxqUFVwWDd2OHdxOTBkMG5LMEszTUYxQjF2MkFR?=
 =?utf-8?B?eTRBQ1U1WkVrY05YVDdvNlFDVjFoNHZZYzR0MGo2UCt5aWZhaHhGNCtXa0E0?=
 =?utf-8?B?aGpneDIxcTdGcFByK3pIVUc4cWhqdW5WejdCL3g4Ri9TT0lhaktWRGp5aEFR?=
 =?utf-8?B?UWE4TEF6cFM4a2tTQmlFTlpGWWNzSWx6VXhNd244TlBoenErNGtnSWk4dVZx?=
 =?utf-8?B?Y1BQQWJnSHIzYjQ5QmRYUWdFOEkxaW1YblRQbEV3YWhhWEpLSTBFWmV5RGQ3?=
 =?utf-8?B?VGJoclZOSng4bkpTeFljME1YTlNiTHBUVzdWbE9qOE9JN1ZYdEttL21RY0J3?=
 =?utf-8?B?L1ltYlNpWDFuTjdFUW1DNzY1OVR2SHpjcWcxaWR1a0hjSmI3azYrdm5SeTNv?=
 =?utf-8?B?QlVqUGRINTc3UE16cUhLTi82YmhnbjhMcEFpWkUyVStHOFdLU3N2MHRkcVJZ?=
 =?utf-8?B?dzAzaVlJQjRUTTI2b2RVb3lkVVgvSFlPY0tUOVJRTEoxdndFY1hnTGJjWTB2?=
 =?utf-8?B?czRLeDlxd2VjWkdQNGpncGVpa0NMT2xML3dITEJLa0RKTGgrRlJleGhuV3F1?=
 =?utf-8?B?a1BFTXA4b0srem9iM1AzanZkWEVmQUpWM2hYditybmZMdVU1bVl6TWhGNU0y?=
 =?utf-8?B?ZFc0QnJnL0lRN2E4UHBJYkhiSDl5MUY4N3RsaTdDNXVJR1dIQ0pSeDlkV1BO?=
 =?utf-8?B?RnJJUnNXSUFhSTgyZlFaNmJhdDJhNHNhWmhTTFBScWFJRnFNM24rNHlZTHNo?=
 =?utf-8?Q?K4j4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19971f19-6a5b-49f5-f40d-08dd1dec0c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 16:09:41.1793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8e27m309tva/YepZuoHtTK5rq0yePESiHB+S58KPn0Kfvt+NMj5JXDnU691HO42LnrYNuHjy52macNUQogFGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9502

TG9vayBnb29kISBUaGFua3MNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBMYXJpc2EgSWxlYW5hIEdyaWdvcmUgKE9TUykgPGxhcmlzYS5ncmlnb3JlQG9zcy5ueHAuY29t
Pg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDE2LCAyMDI0IDE6NTggQU0NCj4gVG86IEZyYW5r
IExpIDxmcmFuay5saUBueHAuY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsg
aW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRs
LVMzMiA8UzMyQG54cC5jb20+OyBDaHJpc3RvcGhlIExpenppDQo+IDxjbGl6emlAcmVkaGF0LmNv
bT47IEFsYmVydG8gUnVpeiA8YXJ1aXpydWlAcmVkaGF0LmNvbT47IEVucmljIEJhbGxldGJvDQo+
IDxlYmFsbGV0YkByZWRoYXQuY29tPjsgTGFyaXNhIElsZWFuYSBHcmlnb3JlIChPU1MpDQo+IDxs
YXJpc2EuZ3JpZ29yZUBvc3MubnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDAvOF0gQWRkIGVE
TUF2MyBzdXBwb3J0IGZvciBTMzJHMi9TMzJHMyBTb0NzDQo+IA0KPiBTMzJHMiBhbmQgUzMyRzMg
U29DcyBzaGFyZSB0aGUgZURNQXYzIG1vZHVsZSB3aXRoIGkuTVggU29Dcywgd2l0aCBzb21lDQo+
IGhhcmR3YXJlDQo+IGludGVncmF0aW9uIHBhcnRpY3VsYXJpdGllcy4NCj4gDQo+IFMzMkcyL1Mz
MkczIGluY2x1ZGVzIHR3byBzeXN0ZW0gZURNQSBpbnN0YW5jZXMgYmFzZWQgb24gdjMgdmVyc2lv
biwgZWFjaA0KPiBvZg0KPiB0aGVtIGludGVncmF0ZWQgd2l0aCAyIERNQU1VWCBibG9ja3MuDQo+
IEFub3RoZXIgcGFydGljdWxhcml0eSBvZiB0aGVzZSBTb0NzIGlzIHRoYXQgdGhlIGludGVycnVw
dHMgYXJlIHNoYXJlZA0KPiBiZXR3ZWVuDQo+IGNoYW5uZWxzIGFzIGZvbGxvd3M6DQo+IC0gRE1B
IENoYW5uZWxzIDAtMTUgc2hhcmUgdGhlICd0eC0wLTE1JyBpbnRlcnJ1cHQNCj4gLSBETUEgQ2hh
bm5lbHMgMTYtMzEgc2hhcmUgdGhlICd0eC0xNi0zMScgaW50ZXJydXB0DQo+IC0gYWxsIGNoYW5u
ZWxzIHNoYXJlIHRoZSAnZXJyJyBpbnRlcnJ1cHQNCj4gDQo+IExhcmlzYSBHcmlnb3JlICg4KToN
Cj4gICBkbWFlbmdpbmU6IGZzbC1lZG1hOiBzZWxlY3Qgb2ZfZG1hX3hsYXRlIGJhc2VkIG9uIHRo
ZSBkbWFtdXhzIHByZXNlbmNlDQo+ICAgZG1hZW5naW5lOiBmc2wtZWRtYTogcmVtb3ZlIEZTTF9F
RE1BX0RSVl9TUExJVF9SRUcgY2hlY2sgd2hlbiBwYXJzaW5nDQo+ICAgICBtdXhiYXNlDQo+ICAg
ZG1hZW5naW5lOiBmc2wtZWRtYTogbW92ZSBlRE1BdjIgcmVsYXRlZCByZWdpc3RlcnMgdG8gYSBu
ZXcgc3RydWN0dXJlDQo+ICAgICDigJllZG1hMl9yZWdz4oCZDQo+ICAgZG1hZW5naW5lOiBmc2wt
ZWRtYTogYWRkIGVETUF2MyByZWdpc3RlcnMgdG8gZWRtYV9yZWdzDQo+ICAgZHQtYmluZGluZ3M6
IGRtYTogZnNsLWVkbWE6IGFkZCBueHAsczMyZzItZWRtYSBjb21wYXRpYmxlIHN0cmluZw0KPiAg
IGRtYWVuZ2luZTogZnNsLWVkbWE6IGFkZCBzdXBwb3J0IGZvciBTMzJHIGJhc2VkIHBsYXRmb3Jt
cw0KPiAgIGRtYWVuZ2luZTogZnNsLWVkbWE6IHdhaXQgdW50aWwgbm8gaGFyZHdhcmUgcmVxdWVz
dCBpcyBpbiBwcm9ncmVzcw0KPiAgIGRtYWVuZ2luZTogZnNsLWVkbWE6IHJlYWQvd3JpdGUgbXVs
dGlwbGUgcmVnaXN0ZXJzIGluIGN5Y2xpYw0KPiAgICAgdHJhbnNhY3Rpb25zDQo+IA0KPiAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxlZG1hLnlhbWwgICAgIHwgIDM0ICsrKysrDQo+
ICBkcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYyAgICAgICAgICAgICAgICAgfCAxMTIgKysr
KysrKysrLS0tLS0NCj4gIGRyaXZlcnMvZG1hL2ZzbC1lZG1hLWNvbW1vbi5oICAgICAgICAgICAg
ICAgICB8ICAyNiArKystDQo+ICBkcml2ZXJzL2RtYS9mc2wtZWRtYS1tYWluLmMgICAgICAgICAg
ICAgICAgICAgfCAxMzcgKysrKysrKysrKysrKysrKy0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDI1
NyBpbnNlcnRpb25zKCspLCA1MiBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuNDcuMA0KDQo=

