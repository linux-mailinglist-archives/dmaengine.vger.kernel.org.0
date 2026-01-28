Return-Path: <dmaengine+bounces-8566-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOPpBBFSemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8566-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:14:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 603ABA7990
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E705301779E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2FE3783B4;
	Wed, 28 Jan 2026 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I0EVMuQj"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929C371068;
	Wed, 28 Jan 2026 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623572; cv=fail; b=ZtUbKIi9ge2/d+XHn+S1nxjzIF24Zp8GNiOGXBt/YGNrQf3XL1CZ56Y/Vqap3G73D+IiSezSvsahXpkjG6uffn7+kq7/9vCwlzLp9GqvSqGqw6he/orAs6YMxLSS5hir7lFk32bNVLKIO5fF2D6V4WVkico9pf9qTDTTPF3Irck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623572; c=relaxed/simple;
	bh=aBObFsqmh0Sjy8mMQzBNAmk5iWcB6vXMt417dN83Tjc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VUgi50FGKXCI5S41VEH7XiiAlTi4xr4p7BQpHPf7AYvX2Uf47+l1SB/L6OrtbvkkmTs1chcjjOuNunbDk9IIem2/Ccapg8YNWGEROIovtyRmF2Z59BAWOXfUwJNPWeJRld27xAxglQMR9hLPoXap/v6DBqvHQLpDu2rUZ55pRGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I0EVMuQj; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwlZ5iXm1BcD1Kx1Nl+qmldgAO7bi48CZzGgw15MB1ahOTou+ta1fPzyeF1rMe5uyJoACO6skmODncqAhTH8RRycjP7XPj5TiZsSyJ2V7bsB9NluphLPFCOrlE7YMi3meTdzoLO7OANTjVPW3Oelxc96XgDmtPlQKBObtSET2X1rt8dKWJzcldqH9Ja9Lta1e7XZwZ7ijFWQ4oxCdByKy3m6UB4mzVieyAT85h2EoOQqeGxiUnnGvGjq1bkyF2eyInxMejgyc+TJyp71LqKO2GoVebw8INyFnOYo29MHUEAsjjRfFTHm8UhQGf+fcZbEEt0L0Xnt6HQiaAvejIy4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4de+dKq3kT3Kpbd6uyaBWOrLUJzAsd2Jw3E8m7RY60k=;
 b=rkANHCmrp7u0vtzgBCx8swxmihgMlAD/5i0U7XqD+ziWb4CF2FgTlDF8yYK3DX3PzbNCo0WWXCKGXEz5YvM2N8VLIFriOstg29x+X+jg1DKl7y4trWZaygNJl5sd57woMEtf9sMR286Edn7K1PkJS8/Eiz7WTysqBleWIJyTS/BfpogANQkD4zGyrfdCapnGOIzeAWhtJsny2SolI0magLMwyx0O5NvrzzvGV3pLqhdg9NNH6AfUl7FGkyUkUnF+6kwncc0xW8GPX8mOinqTFfJpRAJVBfYrfzvN6Q8oqQVXmjWSu8zKncAB3D0oiOYQdQ7fOMh9eo9tCfhoW1pP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4de+dKq3kT3Kpbd6uyaBWOrLUJzAsd2Jw3E8m7RY60k=;
 b=I0EVMuQjlvrO2oPkwtLLHfVDU34oINJa5RfmPC+3EWmJknSsABYePdQrG37VXs1F3KV18bsrZsrlR9jpTRP+vyofMi2I5d23o754W+XJx1B0+El/OEF2BQWyejLfenpV+1Yoh5kiISpgAnTIvwmr4ohwS9h5b5ust0wJFqSm3D1eVlk/nYbYnp6EcqLQj7qAmhrWrNOSC/HBK2V7v4n0N+ekDwrcH1fa1kDnFcfDlge++Jc6cFNn9QO+nM3z0F/GfYYjU+F6ArEtXWXTBgLzr8nn/0n+kl3ZEA2B/02s3vV0dmzSDuY72us/mfY28vdut/KAr1tozaHcs6GVp06X+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:06:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:05:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:27 -0500
Subject: [PATCH RFC 08/12] dmaengine: Factor out fsl-edma prep_memcpy into
 common vchan helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-8-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623546; l=13067;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=aBObFsqmh0Sjy8mMQzBNAmk5iWcB6vXMt417dN83Tjc=;
 b=8tGfBwGkTcyWalm7KqF6H3fDj397ja1ii4EsMKoKC2BaNWGzs9c66LxOd//98Jz6g9TB3NPBJ
 na6AoncYKCaAY129KvWniQya1BSAs54O20SUbbEeDh2uBUpmUcl4PLF
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
X-MS-Office365-Filtering-Correlation-Id: 2d28206b-d1a9-429c-e8f3-08de5e97e442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEtjZU85ck9VRDRrZ1dFL29LY1N3ZW9LeVVpY0RYTG4ybjdtcXAwSHEvaWsv?=
 =?utf-8?B?SFVWb1FDSG5ySllFczVpU01xb2kwT1JjTnhtZTNxRjYwalZVZEdNdXM3TTU1?=
 =?utf-8?B?ckh2SzZXZGJ5aTRaOW5pdDF5aHVjMFVMY04xMTFPNkpGUTdLaW1XR0dzVzkr?=
 =?utf-8?B?WU0wUVk5Y0NwYVNzenhnMFFTYTI4bFg4QjV3U3FKM3FOYnFrdUNYQm4wMnJo?=
 =?utf-8?B?WlBGdmRzcGdQSGM5aW03Zm9sZGdldDRYTkN5dy93QkU3bTEvVTd6TWQ2cVJa?=
 =?utf-8?B?UEtPYUppMVlUVVUrVTNPTlRtVFg5b0pKZFlOcFBrOXJOTlQybHdacFRvUGFo?=
 =?utf-8?B?VXpvbkNKRHh4eGU3MldOU1U4aE9NWERlWnNZcjY3TDJtbitPVnhyYVZlcVNN?=
 =?utf-8?B?SkVZc3N5UFlBWDdFK1RWb3ZGMlZ1WFdJVE0zcjFNbU9hOTJDdkxnQnlwSk9G?=
 =?utf-8?B?cEpZbjlFQWZEZ212SlM2QW0xbkVlLzhNeUZMSTl3ZUJoUlJ4Yy92bVhPN0kv?=
 =?utf-8?B?MU9aeHBQdnZaN3pmckdPbEliK1lWMHdFOHFydndjQzBmMEFxYUFuNWJLQ2dz?=
 =?utf-8?B?NmNFdE1vb01ta3cwb2dBbEhZMG80NUVyQmkzMjU1R0drQkoyM01sZjRFd2xi?=
 =?utf-8?B?bWtMNDNlT1pnM21aWlU3WDJJOEtvZlBHM1Boa0ZUenN1ZlYzTmVpaHJ2Z1pC?=
 =?utf-8?B?SzNLb2hYZXUrcFhsems5R1pYREd1UjRieWRRVy9rVG4zK2ZCOTdaVXQ2aElX?=
 =?utf-8?B?NDE5T0JRTCtFYUtKWDAzVENuVHNvOG84TTF5d1A0QTc2SzhIUDdwM0NLTjhw?=
 =?utf-8?B?T2VnZnJBdzJhMThvRWtNTFNnZk15d3ZrSlpQT2FieFJxZ2MrUi84ekhyUHla?=
 =?utf-8?B?VzFqWXllSVNTeDl3SDdtOFZSQ3ZBMDQvTFpMUUVubGhNNEFtTnhnVDVsdnMz?=
 =?utf-8?B?V1ZSL0pMamtDdHdzV0M4MWRaQWFmSXBsTjcwdnF4SzdQdU53YWJDUXh0N0FT?=
 =?utf-8?B?enlHMXdzUUdleGhIRU4zeTJMRXdjSGM2dUxVeWJaVHJ2N1puNU9jWERtMUZu?=
 =?utf-8?B?NGc0REQxREF3eFMzYkVPL2ZoUmR3RlQ1d2pjQ1kwSzJVdC9tNXROYjhlVzhy?=
 =?utf-8?B?bDA3c2IxeUExd0luNG1MYTExd2k4SUdrRWZ4QW9HSlJoZStvbXBZdVBUdDFq?=
 =?utf-8?B?b052SHFQU3RCTnpGbzl5WnNHdjhvejJGOFJnSDVnM1dFemxhSUxleXFMKzR3?=
 =?utf-8?B?d0NUQllOdXRPbjVhSFUreFpXeUt2TERMdlA2Q1RLbmF3VUNIeE1abjN5Rk1W?=
 =?utf-8?B?MlhjVENyQVp4YjZBeWlQVWpmMjRydzZnTVNRaFI1UXViNlVPbG8zWEZJQlZa?=
 =?utf-8?B?TXdKSFgzNXo3ZlFtOS9xelVNZUZLSUtBTHh0SEtLU3hGeWRrdm44dzQ2RWZB?=
 =?utf-8?B?MFQxNU9sYmU4UWZxZHJlS3ZxbG9qMnRYYzgxMmIzRHM1UkNWQVAzeGVsUzZ3?=
 =?utf-8?B?dnhRV1lRaHAyN3BmVE1sVzhiS3NURkVPcjc3UnI4Q3FWMC9UbXZBU3lBZEJ2?=
 =?utf-8?B?TGVwVG5MamN4WnlOazh2bnJnS2hsbWxVd0k3aWNiS3c4NlJSMUlvRGFRRExQ?=
 =?utf-8?B?dVhPTDlscEQyZG5rUnAzbnRhSHMzMGtuNVJzRkMwQU02MlYxK0RjbnhqYm1y?=
 =?utf-8?B?MGZDc2NaUmxCZDBqZ0JGWnRGRktQOWxVeVR1bjNhRnBjQkovTGh2SldJSVhv?=
 =?utf-8?B?ZGpNUUxmRzl2cVo4aG5qTytsdnV1Z0RwMktIa1Bqd2RPNTdEQXIwcjRaV3BL?=
 =?utf-8?B?OXNmanZydU5PTkN6QjhkWTk4ckVWKzdyUXkzbnYrcGhJUm83REFOa0txVlJR?=
 =?utf-8?B?YmZPQnNrY2w1MDI2TVQvcU84TVRiWUNERUVYN3ZsVVlOOEFsL2lPTDlYUmcv?=
 =?utf-8?B?UVVBQ082MFRtYk9sa0dvR2pqQS9Dd0R1QzdxN3crT2xJVjdkckZORU1PVlN1?=
 =?utf-8?B?UEhpUWxoMGxkMnR0d04vNXRadDU2c2sxenVHTkJ6Q2VMK3lJQlNYdGI3Wnd3?=
 =?utf-8?B?by9ycmx5eDF6bW5wazQwMWdEMWN3bE9nQW1RemhqQTdMMnlMVUdjVytVNjZJ?=
 =?utf-8?B?ZTlHQmlFcXN2aTJIRlhuYm93WEhIa1pPNGU1MXpueWN4RTBBQ3JxK0FqVmk1?=
 =?utf-8?Q?D7mXSSbRpNW1Erqjx6e3Cak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3JKRDluMWFUNzF0Rjc3WE1jWTJCWDlzZnRPWGlGRFpNVlp2MFZtM0VwYU80?=
 =?utf-8?B?RXdRZmNsdWFGaldNdHVnOXdvdEpDUXlkUm1rcFIvcjRwTzJMQVZFL0ZXeGd3?=
 =?utf-8?B?bUlmdDR0dm5FRllrSkEwcGNMdTE1NlZBVEVOUVBnZEtaSEpiSnJNUFFjNUFR?=
 =?utf-8?B?ZE9IbXkzZmlEVnJOL1lETjRnY2gvRHI3ZGVIWUxQaFlVajN1M1pPWERwNklp?=
 =?utf-8?B?ODhwMUlhYjZrUzdsVHdkeGtXZXliQ3VBK25YS3dmbE1BQ1EvRGpMV05zOW1E?=
 =?utf-8?B?VmJySW91enhHdWJsK3B2Y3lXRGVnb0pRNjBqRkQvME85RWlteHBvQjJJdFAz?=
 =?utf-8?B?cmhUdUVKbXBsdVZ5KytJbVY2elVOL0VORzlyT3pNQWFxSkQ1QzlDMDE2TlNH?=
 =?utf-8?B?VXZldFRKQnorNURqTU14eUZRZy83WWVVVCtmQUhzSUlWNVRCdldPV1pwcUdG?=
 =?utf-8?B?aFRTdmVpcnBudXRHTHJ4WFg0Z04wRkFqeVNIUmhXQ2lkR0pFUys5SWt3d3FM?=
 =?utf-8?B?UEZpRVFwdGNXWkF2enJIcllmNUFWTnd4MkhHSE1kdERWVjdrSlZaN0srUW5w?=
 =?utf-8?B?c0RObnlZZnhMcmhpVVJma29KbzBLelpxWHkwYWx5MGtEaU11TTV0Yzd6VWd5?=
 =?utf-8?B?SzlEWG9RcmlBUndnOVgyeUxYNzRKQ1Y3NzdiWVFYUlFsODB0cUVJVlVYb0Q0?=
 =?utf-8?B?TUdhK0lpRzNuMzdtbk5KUlozcGVOTDNHS0FMV1M3cmNodE1sZkdRRXJxQ2FY?=
 =?utf-8?B?R01VN3ZwaFVia1ZTTWNEODNlVkIzdVJQclNJbXM1MVRiLzhQU1psYXUzZzJF?=
 =?utf-8?B?aVNPalpzQjFCT24xS2FLMzUyc2U5d3lKRG5iRGs4c3c2NWNVenMrYldjbWZt?=
 =?utf-8?B?UWV4NUc4aWZjRkVySWpiWXppMkpzMmtBZk53YUpibk02K3B0WFdQTGtJd04w?=
 =?utf-8?B?OGhpMkl4SXJieVdGUTIrWDNxRk9yb2tCek1pYit3eXVnZllpRENGekNZQkIz?=
 =?utf-8?B?S3JsL0hocHZvL2pOenhNbThWMlhQVXl4ZUhHTjhqVzZmMDY3ZC8xWE9ncnRj?=
 =?utf-8?B?czM3c2tJN0xCVGo5aGMrMlcrTFNpcDhVaFFScldqYWYxenh6c0xxdWlPSnBN?=
 =?utf-8?B?aGgzYnZRUFpPeGlDR3F0N0ZETkd6cEZBcnFQKzFFcUtOSTIxeFN2MXBBK0hX?=
 =?utf-8?B?ditkUzUvWFVEYlJJdng5MExPeTlqVC9zMDQwSS9RTVJXQUpiMjhtRmlob3FN?=
 =?utf-8?B?VmdIRk01TitReFJnN1FPSUFJRjVNUlptZXZzeGU0SzV1ME1LeXdhUFhyUXc3?=
 =?utf-8?B?UkdlSklQS3BKZzdiTTl0dW8ycWlPS0x5b0lBKzlIT081d2tJa1Q4bEd6aFNP?=
 =?utf-8?B?NTFQWjlEZXJybnp6VGhwQUtUMXB0WWNZRE5sbXRqYTFBTjZFT01RME92WTBU?=
 =?utf-8?B?dWJHeFFwT21NanRvc3pZeFpzeGI0WitLbmJHYXBudWdQRzQySGhLcytDQ1dU?=
 =?utf-8?B?cGJocU82RVh1RFY3Y1k4aWNYQ0lHL2J2WEFpVjZnNWlGa3RBZUhLTnJCUTJN?=
 =?utf-8?B?Q2h0dHQxWEpYSHAvMlhVRUFQZ3lGbEw1bm5KdWpWWWhZQmlMMXdPL2NSdDdB?=
 =?utf-8?B?anlLUVBPcXN3b3huMk1CcmVRcjJWM3htMnVQYmVkRkpvNlNsaldQdy85eHYz?=
 =?utf-8?B?dGxmYUhSQndqRlU5dnlFeGw3U0ovdUxNUUlVY0JQdERoZ09lcnN6L1I4ZDd6?=
 =?utf-8?B?d0RTYlhDMFBiYjdLVFp5dUt0enAxK1lvKzNCa2FwNG5MbzY5U0tONEd0b2x1?=
 =?utf-8?B?cW4yb3BuZWM0U1RVcWpLSmVndjJpS1UrTUVqbjBjNWxBMUF4eXdtck55SW1y?=
 =?utf-8?B?THF5ditDZS9pZTZiai9BQS9oK3VBVVRXVVV0UVp3bHd4aTZ0K3o5TzhGNFZ0?=
 =?utf-8?B?Mk9WYlF5R1Z3bmNKTlRvelFjOU5CNXhHTHNyUitRZVQwck9ZYitDZjY5ZnI2?=
 =?utf-8?B?c2h1UUVpcTAzRUQ0Nk52UXp3UDJCVVB6V0ZwdGVhVHNyL0dCZ1ZZZEdrTFc5?=
 =?utf-8?B?SDBHcFFqbzAzYTUxTnUxOWNzU1BWWDJkSVRmS1VUTG4yRzVVK1cwRE13WjZh?=
 =?utf-8?B?ZnphV2pzK2NqdFpLL0R2R3lEZkppODlEdkkxM3ZIY24xQ3pKRnhWWWdtaVh6?=
 =?utf-8?B?aFZOdTZwQUlJMjFMaVV1L3hFNGs4Q1JxL2F5VWdxSjR5bnZjM3QreHN0cjJs?=
 =?utf-8?B?YzNrcVhqY3lhSWhWdU5GUEd0SkZ2WHZhbGlzQmpveWJRM1BCeFhaZ3dhUEli?=
 =?utf-8?B?MjkzS254L0pMUnFEenhsUlpxRks2NUdBM24zS2xiZDZFZUZnQnFudz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d28206b-d1a9-429c-e8f3-08de5e97e442
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:05:59.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5xunEz01yGIaSk0lQndXc3rdlEDjwfoLUiTxXkd7S3XY14KAr6OrW+zVbU/DXd8ghhlGn1MDmVyn6IQggicAw==
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8566-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: 603ABA7990
X-Rspamd-Action: no action

Create a common vchan_dma_ll_prep_memcpy() based on
fsl_edma_prep_memcpy().

Add .set_ll_next() and .set_lli() callbacks to abstract DMA descriptor
format differences between controllers, allowing DMA engine drivers to
focus solely on hardware-specific descriptor programming.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 123 ++++++++++++++++++++++++++----------------
 drivers/dma/fsl-edma-common.h |   3 --
 drivers/dma/fsl-edma-main.c   |   2 +-
 drivers/dma/ll-dma.c          |  39 +++++++++++++-
 drivers/dma/virt-dma.h        |  12 ++++-
 5 files changed, 127 insertions(+), 52 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 20b954221c2e9b3b3a6849c1f0d4ca68efecb32e..a8f29830e0172b7e818d209f20145121631743c3 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -461,17 +461,17 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan, void *tcd)
 	edma_cp_tcd_to_reg(fsl_chan, tcd, csr);
 }
 
-static inline
-void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
-		       struct fsl_edma_hw_tcd *tcd, dma_addr_t src, dma_addr_t dst,
-		       u16 attr, u16 soff, u32 nbytes, dma_addr_t slast, u16 citer,
-		       u16 biter, u16 doff, dma_addr_t dlast_sga, bool major_int,
-		       bool disable_req, bool enable_sg)
+static inline void
+__fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
+		    struct fsl_edma_hw_tcd *tcd, dma_addr_t src, dma_addr_t dst,
+		    u16 attr, u16 soff, u32 nbytes, dma_addr_t slast, u16 citer,
+		    u16 biter, u16 doff, bool major_int,
+		    bool disable_req)
 {
 	struct dma_slave_config *cfg = &fsl_chan->vchan.chan.config;
 	struct dma_slave_cfg *c = dma_slave_get_cfg(cfg, cfg->direction);
+	u16 csr = fsl_edma_get_tcd_to_cpu(fsl_chan, tcd, csr);
 	u32 burst = 0;
-	u16 csr = 0;
 
 	/*
 	 * eDMA hardware SGs require the TCDs to be stored in little
@@ -509,8 +509,6 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, EDMA_TCD_CITER_CITER(citer), citer);
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, doff, doff);
 
-	fsl_edma_set_tcd_to_le(fsl_chan, tcd, dlast_sga, dlast_sga);
-
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, EDMA_TCD_BITER_BITER(biter), biter);
 
 	if (major_int)
@@ -519,9 +517,6 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	if (disable_req)
 		csr |= EDMA_TCD_CSR_D_REQ;
 
-	if (enable_sg)
-		csr |= EDMA_TCD_CSR_E_SG;
-
 	if (fsl_chan->is_rxchan)
 		csr |= EDMA_TCD_CSR_ACTIVE;
 
@@ -533,6 +528,71 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	trace_edma_fill_tcd(fsl_chan, tcd);
 }
 
+static void
+__fsl_edma_set_ll_next(struct fsl_edma_chan *fsl_chan, void *tcd, dma_addr_t next)
+{
+	u32 csr = fsl_edma_get_tcd_to_cpu(fsl_chan, tcd, csr);
+
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, next, dlast_sga);
+
+	csr |= EDMA_TCD_CSR_E_SG;
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
+}
+
+static int
+fsl_edma_set_ll_next(struct dma_ll_desc *desc, u32 idx, dma_addr_t next)
+{
+	struct dma_chan *chan = desc->vdesc.tx.chan;
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	void *tcd = desc->its[idx].vaddr;
+
+	__fsl_edma_set_ll_next(fsl_chan, tcd, next);
+
+	return 0;
+}
+
+static inline
+void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
+		       struct fsl_edma_hw_tcd *tcd, dma_addr_t src, dma_addr_t dst,
+		       u16 attr, u16 soff, u32 nbytes, dma_addr_t slast, u16 citer,
+		       u16 biter, u16 doff, dma_addr_t dlast_sga, bool major_int,
+		       bool disable_req, bool enable_sg)
+{
+	__fsl_edma_fill_tcd(fsl_chan, tcd, src, dst, attr, soff, nbytes, slast,
+			    citer, biter, doff, major_int, disable_req);
+
+	if (enable_sg)
+		__fsl_edma_set_ll_next(fsl_chan, tcd, dlast_sga);
+}
+
+static int fsl_edma_set_lli(struct dma_ll_desc *desc, u32 idx,
+			    dma_addr_t src, dma_addr_t dst, size_t len, bool irq,
+			    struct dma_slave_config *config)
+{
+	struct dma_chan *chan = desc->vdesc.tx.chan;
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	void *tcd = desc->its[idx].vaddr;
+	u32 src_bus_width, dst_bus_width;
+
+	/* Memory to memory */
+	if (!config) {
+		src_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(src) - 1));
+		dst_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dst) - 1));
+
+		fsl_chan->is_sw = true;
+	}
+
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_MEM_REMOTE)
+		fsl_chan->is_remote = true;
+
+	/* To match with copy_align and max_seg_size so 1 tcd is enough */
+	__fsl_edma_fill_tcd(fsl_chan, tcd, src, dst,
+			    fsl_edma_get_tcd_attr(src_bus_width, dst_bus_width),
+			    src_bus_width, len, 0, 1, 1, dst_bus_width, irq, true);
+
+	return 0;
+}
+
 struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
@@ -555,7 +615,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		return NULL;
 
 	sg_len = buf_len / period_len;
-	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len);
+	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len, flags);
 	if (!fsl_desc)
 		return NULL;
 	fsl_desc->iscyclic = true;
@@ -615,7 +675,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		dma_buf_next += period_len;
 	}
 
-	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	return __vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc);
 }
 
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
@@ -638,7 +698,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
 		return NULL;
 
-	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len);
+	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len, flags);
 	if (!fsl_desc)
 		return NULL;
 	fsl_desc->iscyclic = false;
@@ -719,36 +779,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		}
 	}
 
-	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
-}
-
-struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
-						     dma_addr_t dma_dst, dma_addr_t dma_src,
-						     size_t len, unsigned long flags)
-{
-	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
-	struct dma_ll_desc *fsl_desc;
-	u32 src_bus_width, dst_bus_width;
-
-	src_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dma_src) - 1));
-	dst_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dma_dst) - 1));
-
-	fsl_desc = vchan_dma_ll_alloc_desc(chan, 1);
-	if (!fsl_desc)
-		return NULL;
-	fsl_desc->iscyclic = false;
-
-	fsl_chan->is_sw = true;
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_MEM_REMOTE)
-		fsl_chan->is_remote = true;
-
-	/* To match with copy_align and max_seg_size so 1 tcd is enough */
-	fsl_edma_fill_tcd(fsl_chan, fsl_desc->its[0].vaddr, dma_src, dma_dst,
-			  fsl_edma_get_tcd_attr(src_bus_width, dst_bus_width),
-			  src_bus_width, len, 0, 1, 1, dst_bus_width, 0, true,
-			  true, false);
-
-	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	return __vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc);
 }
 
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
@@ -797,6 +828,8 @@ static int fsl_edma_ll_stop(struct dma_chan *chan)
 }
 
 static const struct dma_linklist_ops fsl_edma_ll_ops = {
+	.set_ll_next = fsl_edma_set_ll_next,
+	.set_lli = fsl_edma_set_lli,
 	.stop = fsl_edma_ll_stop,
 };
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 654d05f06b2c1817e68e7afaf9de3439285d2978..f2c346cb84f5f15d333cf8547963ea7a717f4d5f 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -479,9 +479,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
-struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
-		struct dma_chan *chan, dma_addr_t dma_dst, dma_addr_t dma_src,
-		size_t len, unsigned long flags);
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_issue_pending(struct dma_chan *chan);
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 354e4ac5e46c920dd66ec1479a64c75a609c186d..1724a2d1449fe1850d460cefae5899a5ab828afd 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -850,7 +850,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
 	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
 	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
-	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;
+	fsl_edma->dma_dev.device_prep_dma_memcpy = vchan_dma_ll_prep_memcpy;
 	fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
 	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
 	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
diff --git a/drivers/dma/ll-dma.c b/drivers/dma/ll-dma.c
index ff9eac43886255c18550c978184c0801456fefe9..da13ba4dcdfe403af0ad3678bf4c0ff60f715a63 100644
--- a/drivers/dma/ll-dma.c
+++ b/drivers/dma/ll-dma.c
@@ -28,10 +28,11 @@ int vchan_dma_ll_init(struct virt_dma_chan *vc,
 		      const struct dma_linklist_ops *ops, size_t size,
 		      size_t align, size_t boundary)
 {
-	if (!ops || !ops->stop)
+	if (!ops || !ops->stop || !ops->set_ll_next || !ops->set_lli)
 		return -EINVAL;
 
 	vc->ll.ops = ops;
+	vc->ll.size = size;
 
 	vc->ll.pool = dma_pool_create(dev_name(vc->chan.device->dev),
 				      vc->chan.device->dev, size, align,
@@ -53,7 +54,8 @@ void vchan_dma_ll_free(struct virt_dma_chan *vc)
 }
 EXPORT_SYMBOL_GPL(vchan_dma_ll_free);
 
-struct dma_ll_desc *vchan_dma_ll_alloc_desc(struct dma_chan *chan, u32 n)
+struct dma_ll_desc *vchan_dma_ll_alloc_desc(struct dma_chan *chan, u32 n,
+					    unsigned long flags)
 {
 	struct virt_dma_chan *vchan = to_virt_chan(chan);
 	struct dma_ll_desc *desc;
@@ -65,11 +67,15 @@ struct dma_ll_desc *vchan_dma_ll_alloc_desc(struct dma_chan *chan, u32 n)
 
 	desc->n_its = n;
 
+	vchan_init_dma_async_tx(vchan, &desc->vdesc, flags);
+
 	for (i = 0; i < n; i++) {
 		desc->its[i].vaddr = dma_pool_alloc(vchan->ll.pool, GFP_NOWAIT,
 						    &desc->its[i].paddr);
 		if (!desc->its[i].vaddr)
 			goto err;
+
+		memset(desc->its[i].vaddr, 0, vchan->ll.size);
 	}
 
 	return desc;
@@ -96,6 +102,35 @@ void vchan_dma_ll_free_desc(struct virt_dma_desc *vdesc)
 }
 EXPORT_SYMBOL_GPL(vchan_dma_ll_free_desc);
 
+struct dma_async_tx_descriptor *
+vchan_dma_ll_prep_memcpy(struct dma_chan *chan,
+			 dma_addr_t dma_dst, dma_addr_t dma_src, size_t len,
+			 unsigned long flags)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(chan);
+	struct dma_ll_desc *desc;
+	int ret;
+
+	desc = vchan_dma_ll_alloc_desc(chan, 1, flags);
+	if (!desc)
+		return NULL;
+
+	desc->iscyclic = false;
+
+	ret = vchan->ll.ops->set_lli(desc, 0, dma_src, dma_dst,
+				     len, true, NULL);
+
+	if (ret)
+		goto err;
+
+	return __vchan_tx_prep(vchan, &desc->vdesc);
+
+err:
+	vchan_dma_ll_free_desc(&desc->vdesc);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(vchan_dma_ll_prep_memcpy);
+
 int vchan_dma_ll_terminate_all(struct dma_chan *chan)
 {
 	struct virt_dma_chan *vchan = to_virt_chan(chan);
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index ad5ce489cf8e52aa02a0129bc5657fadd6070da2..f4aec6eb3c3900a5473c8feedc16b06e29751deb 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -40,11 +40,16 @@ struct dma_ll_desc {
 };
 
 struct dma_linklist_ops {
+	int (*set_ll_next)(struct dma_ll_desc *desc, u32 idx, dma_addr_t next);
+	int (*set_lli)(struct dma_ll_desc *desc, u32 idx,
+		       dma_addr_t src, dma_addr_t dst, size_t size,
+		       bool irq, struct dma_slave_config *config);
 	int (*stop)(struct dma_chan *chan);
 };
 
 struct dma_linklist {
 	struct dma_pool *pool;
+	size_t	size;
 	const struct dma_linklist_ops *ops;
 };
 
@@ -291,7 +296,12 @@ int vchan_dma_ll_init(struct virt_dma_chan *vc,
 		      const struct dma_linklist_ops *ops, size_t size,
 		      size_t align, size_t boundary);
 void vchan_dma_ll_free(struct virt_dma_chan *vc);
-struct dma_ll_desc *vchan_dma_ll_alloc_desc(struct dma_chan *chan, u32 n);
+struct dma_ll_desc *vchan_dma_ll_alloc_desc(struct dma_chan *chan, u32 n,
+					    unsigned long flags);
+struct dma_async_tx_descriptor *
+vchan_dma_ll_prep_memcpy(struct dma_chan *chan,
+			 dma_addr_t dma_dst, dma_addr_t dma_src, size_t len,
+			 unsigned long flags);
 void vchan_dma_ll_free_desc(struct virt_dma_desc *vdesc);
 int vchan_dma_ll_terminate_all(struct dma_chan *chan);
 #endif

-- 
2.34.1


