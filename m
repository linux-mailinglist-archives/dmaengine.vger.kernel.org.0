Return-Path: <dmaengine+bounces-8558-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLubAKRQemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8558-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:08:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F4AA77DD
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9192301BE2B
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E7C36EAB6;
	Wed, 28 Jan 2026 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PdG7pYX4"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA9372B3C;
	Wed, 28 Jan 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623556; cv=fail; b=M86R+382nfIxYMWK5ibK7C0FhGVW3MicrORVdcxa5BWCm7O+DQlRYyx7cviNHDq/31tA8HJ+Pt8Fy/vqA7H3bjJFbxjFpXmJCILEjtMi6QdQoMGFFIUU+NoOPnCDJtxjb75TEHcUfznUA6O9nFDdRugVAmqigQnwjkreo8n/4A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623556; c=relaxed/simple;
	bh=ou7S4OL7ztdHxv5Lc2kHLzb62Ye9sPYPor/4kcRFXu8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h9tKLq/zVl/vcVubxnM2xyzknVdyhRMvfNIWY/hqAlav+R9nNs/4shnnO2t4pdDTsK/8Vix4HK78sDQ5tinzzLy/XH5MA2j76GI/C66wzT7F+nhIn1PCrSJtshkt/PjIHnMogLoeGaY9E4OYNgVSEtpl2+Xusox+fDCb54BBP6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PdG7pYX4; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh//trauTja/bDiJVrUbbDkP7UGQYNYb7sXZHZ9idChJTupx1SgfHhOhY86Thq913D2fpW8yT2VGChFQFqW7gldd6PKesPeABiv7cUAfGOSiCare7MdcmRIOfzCRltNx+JtbQcMPcU+e6g/Oq77C4tuts9pXPac0wFpW50VNcpVZ0dvp7b57PIhbjLi3Et2q2n18GrHkLGAGKMf2bMLAKsJWgjDG1PCFNlxRAVM6BdBeKdlXhABhoAwyDJJMQEnoIXt6sZ7DfeMLIhgu6JYc6n5ac+mc9aD4ZkgWZUaeOlJMPw3ak2r/L/q12E89wBlkToZMurGYsQp86w29+rVwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf5QLy31Mihqgbn7r9VG2fdRFs80COU0hr2k9jE/wA8=;
 b=u5z1vtEF8zSsAwou2GzIV6Uavw0RgMX8EiJl+KIXuYhODDcjgMokRcsUpgaZb4IeKsXeGVJxXuXkOel/JPkN1x5vKQIa9fQgn/dXeJimMVs243vIuu04uW2rYQGLd9D+Xc+5OyXadHS55JyRsopR4K19/7mMWcQp2uvEBwUn2EepPyynbbv3ETmJy5fRAqD5VSBLwijYMUm1pDUfDMYSZlt9medj8U1wfQ7HoAb+gdLlpDyajaiFe6+k/WJ3OheHUIBNQIli8zTVbTZJIAo1e7v9V0xN2mgBC9gStQhZtmNaK4mbgnsz7QZHCBG9R+a+bTDUDuvotYdRKzagCKA7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf5QLy31Mihqgbn7r9VG2fdRFs80COU0hr2k9jE/wA8=;
 b=PdG7pYX4udnwitWvP1R/axfa3ZjwTJpdyEXaaLupaJU+lqsBF/wl4mFtfK7g2fA+I2JY28ejCcCtcDRbxXrZrFLVDYwZwe4O5b2qSo9Ma18d+gw3tfNbLOXfajaHd2qfYO5GsYzAaeYjsz1PZHaKjHJgFYtn7FbYvEPJVI0680hAfM3h727lCjDtzRRSUD/WTdJJP83w6Rfbf1sC3Dlz/0ezoiI4aw+tupZQilsyuduf5opUJ8PZDqaNxh45jz/cgZeX0nEyj2GTxfAyv1+M5ovW1zle1U3e5iKw6msznzd4dZxgm3kinFzM/j9UzjpvF57EGrwoJuL5lF2uWm/K2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:05:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:05:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:20 -0500
Subject: [PATCH RFC 01/12] dmaengine: Extend virt_chan for link list based
 DMA engines
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-dma_ll_comlib-v1-1-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623545; l=7274;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ou7S4OL7ztdHxv5Lc2kHLzb62Ye9sPYPor/4kcRFXu8=;
 b=ljkF4UBAreVH/tbP48Annnx1iFWHNglrf34pJPGsLuP6fOUdI4rjkuj2MxTu0gIzduRzjVwXJ
 9mPGn4JE0NkAySaqUTSM5O7AEPiF6VO/ViQorTzgsPNjNAF9mu+c89/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a977883-6967-4b20-ab55-08de5e97de05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU9Dc2FUdHJkaEpyQlhsUHIrbXFlY1ZicGZERnozQ3hkbTVKWUVlUElPVVE5?=
 =?utf-8?B?dCtuMmRHVnZNN0pPNWVYMzN3MUtrenlINm5uQVAzYlRYbm9qNlNac2hjVVZS?=
 =?utf-8?B?dTFTcWpxWllrbjVXRTlqRlhuUkltaTFyWWR2OFRlQ1doRTMyRjdlMVNTcVla?=
 =?utf-8?B?TVZCWmV4Z3NJSmZzNDhNUys3ckFwcWNGU2FvaXlVR0FITjZLdDNQdklJVTM2?=
 =?utf-8?B?YXB3ZHplOFFtZUlRL0JacWh1TEtnamwyc0VtdzU2a1hiTjc1dmdRTGFrMWJK?=
 =?utf-8?B?blhDeFlPWmtVQWRIU3A4TTZTbzlycTY0ZEtiTmxWNndpVGNFVkdLeExtOGZ6?=
 =?utf-8?B?eldyZ2E3ZXJORmR6QWlUbHh1cnZPU3VCcVh5YUhqUDM5ZWhvZVNkTWV5WXUw?=
 =?utf-8?B?UjQzY0dBWUVNcGtucGtnZ1FqSUJBdU5JV1FxbXZ3N0pOMXNKR2wxTXpxYkJr?=
 =?utf-8?B?b3FLb3k4WDM1WFpsM1lLdG5nT0dQSHEvVDVlVW9iRXRDUGJTcVRBbDNSZ1ZY?=
 =?utf-8?B?QmJPbE1kYVhDaEUwZ0JwVHFGWTZlb3hkRm5NZTJsZVVQRzNLMmluYitZV1BS?=
 =?utf-8?B?UjZOVGp3Zy9xNmtOc2ZsZVY2TXJRZHlraFBZL3NsV0ZqMDhEVVc5RVRUNzhq?=
 =?utf-8?B?SGtDMmVHMUs5NWhOa2lUK1FsMjB1WFRjT2tMVzVLTFJ1bXNIR2k4Tnd5Q2NI?=
 =?utf-8?B?aFFjeFBQU0szdHU3Y2tPbTlyRk5GbWgvRUtlNU5DYXBRNVJ4bVZBQjI1Nm5H?=
 =?utf-8?B?SnIvWDJSZGI4S2ljTk1BZE40L05zTUtjQTZ3LzIzM2F2MWpIWlFmM0NEb0FJ?=
 =?utf-8?B?bGxCMC9oMlUzRCtaaVgrV0NUTDc1Wmxlb0pUQTBJSEZrOWJaUW0zWWlWMDl0?=
 =?utf-8?B?SUJNbU5WWENpT1RhbFR4Z3YxNWZNZ0d5TmgrSElUSUFMT3ZhS3A5OHM5aHRL?=
 =?utf-8?B?UHpNSUpuS3dWZjFSZlpYdEVydVdqRlNwUWhnRWhFb2NXTVQwNFNLdzN6RTI4?=
 =?utf-8?B?ZlhmTC9aN2dxSWkrZU91YWtrdFZ3bzl5Zm1zV25zTHAzUktvUVBUUFZ4WWVa?=
 =?utf-8?B?RGFjdU9RWnpwR2ljR2RGWC9ScVdXQzk4bDdLTHlkcVhDQkZFbDBIWDlqMzIv?=
 =?utf-8?B?SkRqWmtkMVlqVTQzeGFuR2VzTXowaFFmaU9BSGZTMlBJa3dDN3JTcnlyTWxa?=
 =?utf-8?B?QXl1bGwyTjZHV3dPRGZBeE9GVzlvUk5pcDJLWFhCQXQ3WHlEU3Zka05ZQWNG?=
 =?utf-8?B?NFQzLzgzVHh0dWNxVlJhY25iR3FTRTRpKzYyZHh6azQ2VzREKzd0S3hhS29S?=
 =?utf-8?B?Zm02QWhKVzVoaGEwNUgvMUFIMnpMR0V4dFphSkU2elRZTk9RVXc3S1lYUzVL?=
 =?utf-8?B?bGw3TWs2cURENHdiWlNZeGlHaDlENUROUDZhWTNWV0paay93NzdGRDJMV0U3?=
 =?utf-8?B?cFQ1Y01SVG9PYTNYcDRTZWJuVnpFZUJjT0VtZTdwajl3K3l0WGQ4MGlIV1lv?=
 =?utf-8?B?MVJCaTZRb3lENi9KdlRUWjArSHlmdGI4ZG15WmxwOUVrdWdLeW8vZjk3bjhZ?=
 =?utf-8?B?VEFTS0FMcHFRV2Z5eWcwd1g0YnEwQ2Y3MHArQ1EwckxvZDVKakltSHFNYUY2?=
 =?utf-8?B?VEkxNmhtTFRSUGZQRk5NeEV6aEl5NitjMThvOGdCWmplZTVvUVNVY0hMbGlJ?=
 =?utf-8?B?eFJTWTlwbzF6V3N2VE90T2hWcDd5QmJZUTg5TllDN1p5TUFwaVdMZW5BZDhZ?=
 =?utf-8?B?ZHNjcy9IRE5VV2pNOWErZXczUFIwVFJvYTZ6ZDF1clNlN1kyeXV0VDJYd2R1?=
 =?utf-8?B?WjV6VWtLQ1F5TWpheHFid3hnL0pQZEtHYkFKdDh5ZCtsdTJqZmFVRGFkY1RF?=
 =?utf-8?B?a3c3d0hBaTZUbVBBY2o0SVRjNHkyQlhnOEltSnMyMDdZdFIzdjhoZFFFLy8x?=
 =?utf-8?B?bFV1OGQ1VTNCaUQvODRuQ0F0dTdpSTM5NktFSE9wTW1Gbndqa0doamVQa1dx?=
 =?utf-8?B?QzUvelFINGp1Z3pWZlhlTVpTVy9PcnoyVUVBQnh4dTFWM1R1cHdnYnNycnlR?=
 =?utf-8?B?d3ZSejBRQ2VhK0wrU2xBNjRsOUoyYlN4T09DbEtrTUliSWZOc21ZcXZFVWJV?=
 =?utf-8?B?K3FrWERzakxiNzdVMjdIUWtyZDU5M1FsSnpmd0hEbkJwbWpJZHRFQktTOFZi?=
 =?utf-8?Q?21vDrf7UgXQ3O5iB7icXyF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDFHZTdNeWtnNUhBUzdPM1MzUVdyeTVIMVFxbUNnRm1WTlhmc3hyQ1J3eXVy?=
 =?utf-8?B?b0xjbW42elk4RytiTVg2ZDVhZi94b1pUaTAzRk5PT244b1JraWVBNTdzMG5P?=
 =?utf-8?B?dDdaWFFhTEtoZmc1eVRGejVlVWE0QmhZRTh1VGxjdy82Nk1rOVlyMytvQmQv?=
 =?utf-8?B?dFFuSXN0bmRRcjlQME56Lzl0aVlkZGpZVVRCSFlrb3B4KzJLeXlqNGg5bGYr?=
 =?utf-8?B?OUI2MjlXdGJUR0VMaFlrRDFHNXdiMzkwRHB1ZzB0ZE12V0lYVU5ZbUdraXdo?=
 =?utf-8?B?MmF3ZWZCMDRNQXlFMWQzQWQzQ21tTkc0bE1oZWJrSWduQzBjVWlub0kxTDBC?=
 =?utf-8?B?VVlhODFXYnptL1RqZ2dZdmhYZnZiZmoyTHJjaFJodFU0SVRpdTBJamNsSGZk?=
 =?utf-8?B?RTREZmlHVHN6N25MOW9LU0wwaHJqWmoyOThraUMvM0VURXVvNmlHdXgycTdM?=
 =?utf-8?B?RU9nOUpWb2JZT0ZkWEZsS2sveFZVMkhCcFc0TTNxRnZJbkVLMlVDNXlRRnZj?=
 =?utf-8?B?NVVzSGpaV3l6QVlva2FYVmhoaHhtbSswVStnK3NyS1VVVEFmQllVODJmWlpP?=
 =?utf-8?B?TnI1cWdwaWRmMkgvU2dWMnd3VmRRTXVwM2ViNGdqQTdXYVl2bzQ1TmR0bUpz?=
 =?utf-8?B?SHc5TUNlTmp3UzgxZjhTMzl6SGwrZUFjNlI0a2hzdlZpK0JhajAxRnNZT3ZR?=
 =?utf-8?B?UXJZTUh4Y3VQT1JuNk11ZzVWNjdKN0pTN1Uvc0pXS25lOU1ud1dPMkcrUUZl?=
 =?utf-8?B?QzJYbGpMSU83ZVhlYXh1dlljdFJKcmdnaWtCV0c4cWovTmViNlh2Skx2NGtp?=
 =?utf-8?B?N2kxY0hCdFFyNjgvYTI4NHJFT3RmY09aNzl6UzVBcVREWVhsYjNHcjUva3A5?=
 =?utf-8?B?SzROTktobmRvYUFnYUFFUVNOZGt4eUxneGpGaGdXdWJ2TWZNM2hLbk9FbnhS?=
 =?utf-8?B?SCtvQ0U2YUw3dVFROXM3SzVYbzk2RGFtUFVPaXJkbzVKMzczcVJkVFhPSm5J?=
 =?utf-8?B?SHF2dTZwdTNoTXdWc3RmUWhDSURZZUxBOWFIM1VZTGFycm1RUXFsam95YzJj?=
 =?utf-8?B?OVhHK2xKWm5hSEJLZk5iNFZEeG1mMmhEYmtucysxQWFnclpVSDlBWkJ5UUFO?=
 =?utf-8?B?dUp1ZlBtR2QraHRXdk1MVHlXbTVXUWhTWHlNMDJtUloySkhYblBvalVuT1h5?=
 =?utf-8?B?UjY5RzhjdFpiL1dqT3NZcUpad0ZscjZPcE9jUm1aVFluWWd0ODFRdERvSExk?=
 =?utf-8?B?KzFvaEpPMStZTG5CZnlqYTkwTnhVREF4cWFUZHVjM2ppMm90NVY4NTgvMG5r?=
 =?utf-8?B?WkJDbXoxRVFuRHNrYWp2QUZlQ0h6TzBaTlpXeHFodDA2cVFjT0hVNVBrTlhT?=
 =?utf-8?B?YXZjOVNyOVdyeUd3SGdDSzhuZHE2eFBsSGhRUlFYeldYSEhJTHNEZ09UbzlN?=
 =?utf-8?B?SDNLY2Y4RFl5dkRoaVhIaWVNN2hDT0MybVJ3Rk5GeHhVRGVqeEJyazFDeHJJ?=
 =?utf-8?B?Uk9ENkY0NmNKQ2s1dHV5dU9GUnd4Z1lLSVlUUTkyMVdKQXFCK05RZmhGU0Vy?=
 =?utf-8?B?V2hQMkovNmxSVDRhTk1wSUx1ZEF2QkpOSzc0YmdiOXVFaTYyVVg3eWZLelBa?=
 =?utf-8?B?WUE5dlBaQkFyeEc0L2VZa29EWk4rNGVTU3gyN2FBVjZHQ1p0dGJkN0I0cFY5?=
 =?utf-8?B?b29KQ2pPQnl4UzdlWkVOd2hyOVJZRXo3cWFqRS9kS2o2YzRGNEZYNDlLdjlI?=
 =?utf-8?B?SjNjNTlKTEQzU0xLSDN4Q3MrenZJKzBQV0pidFV0MThJZ2kwQTRWUWZaYmFH?=
 =?utf-8?B?VkptUmhvbm9vQnJmR0JmVmJOaHRic1lhYmMyNDlEK1V5Z1QzL3ZITkp5bUp5?=
 =?utf-8?B?L0dBM0JSYlM4b2pzNXpBNmkvRkNMZllsUGFyc1U5SGlRS21hU2IzTnJsWWU5?=
 =?utf-8?B?S0RCRHZmWG9YMkowS2lmbzN2NCtWYzZQdGJHT0luWXR3dmRYMHc0eDZqekth?=
 =?utf-8?B?S1NPcElxcVovSlBEK3Fja0FXR2hQU1dmalJjRGpKelpaS3BPYjVjTmpDMU9o?=
 =?utf-8?B?Zm5NWnkzV0h5QU56b09zSGxEaUdyMEFpV0pSZEVIT1Y3cFp3Y25ZOWFmSUMw?=
 =?utf-8?B?d1YvYlVlMU5XNXhiVDhCS3U4Nk5PaStVdGEweU83TjZhKzBVQ0E3QXV2U3p2?=
 =?utf-8?B?VXdvNnJwdFBJWWlZZS94eVUvMEJnL1dFK2ExZnNwcndxZ3A5a1ZPVjF1bjdQ?=
 =?utf-8?B?Y1ZZenRMZGRiNGwxVy95ZkZtczRkRUFOMEd0SXg0Sm9XdDZOQUdtbG5qRHhY?=
 =?utf-8?B?VTdvNDd2ZFZzaFhWZ0lxRGJkSjVIUnBtMXZXNWZQd3VWSFgyNGpoUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a977883-6967-4b20-ab55-08de5e97de05
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:05:49.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7HHPaRm6AMR7kWM1H4JzAyoacKcmHItwSA2avOSFu/qKGHA4yaYmY0Cntj+yu0Ua9rq858vUzLH1VrFy2VTRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8558-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24F4AA77DD
X-Rspamd-Action: no action

Many DMA engines (such as fsl-edma, at-hdmac, and ste-dma40) use
linked-list descriptors for data transfers and share a large amount of
common logic. Add a basic framework to support these link list based DMA
engines and prepare for a common library.

Introduce vchan_dma_ll_terminate_all() as the first shared helper.
Additional common functionality will be added in follow-up patches.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Kconfig           |  4 +++
 drivers/dma/Makefile          |  1 +
 drivers/dma/fsl-edma-common.c | 35 ++++++++++++++++++-------
 drivers/dma/ll-dma.c          | 61 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/virt-dma.h        | 19 ++++++++++++++
 5 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8bb0a119ecd48a6695404d43fce225987c9c69ff..5a61907d4d9631e61cf0c44d4104983e9113f28f 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -47,6 +47,9 @@ config DMA_ENGINE
 config DMA_VIRTUAL_CHANNELS
 	tristate
 
+config DMA_LINKLIST
+	tristate
+
 config DMA_ACPI
 	def_bool y
 	depends on ACPI
@@ -221,6 +224,7 @@ config FSL_EDMA
 	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
+	select DMA_LINKLIST
 	help
 	  Support the Freescale eDMA engine with programmable channel
 	  multiplexing capability for DMA request sources(slot).
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a54d7688392b1a0e956fa5d23633507f52f017d9..f1db081a8d2487968f0ca110b80706901f9903ae 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -6,6 +6,7 @@ subdir-ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
 #core
 obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
 obj-$(CONFIG_DMA_VIRTUAL_CHANNELS) += virt-dma.o
+obj-$(CONFIG_DMA_LINKLIST) += ll-dma.o
 obj-$(CONFIG_DMA_ACPI) += acpi-dma.o
 obj-$(CONFIG_DMA_OF) += of-dma.o
 
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index c4ac63d9612ce9f1f5826a2186938a785ed529d1..396ff6dfa99a150f9ce34effd64534e3d8e8576b 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -236,16 +236,11 @@ void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
 int fsl_edma_terminate_all(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
-	unsigned long flags;
-	LIST_HEAD(head);
+	int ret;
 
-	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
-	fsl_edma_disable_request(fsl_chan);
-	fsl_chan->edesc = NULL;
-	fsl_chan->status = DMA_COMPLETE;
-	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
-	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
-	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
+	ret = vchan_dma_ll_terminate_all(chan);
+	if (ret)
+		return ret;
 
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
 		pm_runtime_allow(fsl_chan->pd_dev);
@@ -830,6 +825,21 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 }
 
+static int fsl_edma_ll_stop(struct dma_chan *chan)
+{
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+
+	fsl_edma_disable_request(fsl_chan);
+	fsl_chan->edesc = NULL;
+	fsl_chan->status = DMA_COMPLETE;
+
+	return 0;
+}
+
+static const struct dma_linklist_ops fsl_edma_ll_ops = {
+	.stop = fsl_edma_ll_stop,
+};
+
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
@@ -838,6 +848,13 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
 		clk_prepare_enable(fsl_chan->clk);
 
+	ret = vchan_dma_ll_init(to_virt_chan(chan), &fsl_edma_ll_ops,
+				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
+				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
+				32, 0);
+	if (ret)
+		return ret;
+
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
diff --git a/drivers/dma/ll-dma.c b/drivers/dma/ll-dma.c
new file mode 100644
index 0000000000000000000000000000000000000000..3845cca7926eb71f008cb98d8c622cb28a2369a5
--- /dev/null
+++ b/drivers/dma/ll-dma.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Common library for DMA Controller, which use Link List DMA descriptor.
+ *
+ * For the DMA controller, which DMA descriptor work as Link List, there are
+ * field, which point to next DMA descriptor.
+ *
+ * Each DMA descriptor's size is the same.
+ *
+ *	┌──────┐    ┌──────┐    ┌──────┐
+ *	│      │ ┌─►│      │ ┌─►│      │
+ *	│      │ │  │      │ │  │      │
+ *	├──────┤ │  ├──────┤ │  ├──────┤
+ *	│ Next ├─┘  │ Next ├─┘  │ Next │
+ *	└──────┘    └──────┘    └──────┘
+ *
+ */
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+
+#include "virt-dma.h"
+
+int vchan_dma_ll_init(struct virt_dma_chan *vc,
+		      const struct dma_linklist_ops *ops, size_t size,
+		      size_t align, size_t boundary)
+{
+	if (!ops || !ops->stop)
+		return -EINVAL;
+
+	vc->ll.ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vchan_dma_ll_init);
+
+int vchan_dma_ll_terminate_all(struct dma_chan *chan)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(chan);
+	LIST_HEAD(head);
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &vchan->lock) {
+		ret = vchan->ll.ops->stop(chan);
+		if (ret)
+			return ret;
+
+		vchan_get_all_descriptors(vchan, &head);
+	}
+
+	vchan_dma_desc_free_list(vchan, &head);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vchan_dma_ll_terminate_all);
+
+MODULE_AUTHOR("Frank Li");
+MODULE_DESCRIPTION("Common library for Link List DMA Descriptor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 59d9eabc8b6744a439aeed3114164c5203341a6c..081eb910d0b0cd2b60232736587c698fff787cb9 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -19,11 +19,23 @@ struct virt_dma_desc {
 	struct list_head node;
 };
 
+struct dma_linklist_ops {
+	int (*stop)(struct dma_chan *chan);
+};
+
+struct dma_linklist {
+	const struct dma_linklist_ops *ops;
+};
+
 struct virt_dma_chan {
 	struct dma_chan	chan;
 	struct tasklet_struct task;
 	void (*desc_free)(struct virt_dma_desc *);
 
+#if IS_ENABLED(CONFIG_DMA_LINKLIST)
+	struct dma_linklist ll;
+#endif
+
 	spinlock_t lock;
 
 	/* protected by vc.lock */
@@ -234,4 +246,11 @@ static inline void vchan_synchronize(struct virt_dma_chan *vc)
 	vchan_dma_desc_free_list(vc, &head);
 }
 
+#if IS_ENABLED(CONFIG_DMA_LINKLIST)
+int vchan_dma_ll_init(struct virt_dma_chan *vc,
+		      const struct dma_linklist_ops *ops, size_t size,
+		      size_t align, size_t boundary);
+int vchan_dma_ll_terminate_all(struct dma_chan *chan);
+#endif
+
 #endif

-- 
2.34.1


