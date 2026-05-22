Return-Path: <dmaengine+bounces-10763-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEsJFwO5EGqzcwYAu9opvQ
	(envelope-from <dmaengine+bounces-10763-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:13:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C91AF5B9EE4
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CE0E300E5FA
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DE2379EF0;
	Fri, 22 May 2026 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bvHOx1Hg"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F46366560;
	Fri, 22 May 2026 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480829; cv=fail; b=qd4km0yA8w4YgfDuKazPlsPqCtXRBG4A3PwvXI5bXIO6+/Rx9F00C83fk/TytEtPuvxCYPHQw1FaPMXpDfFS1sD0Tkj0+Nv9mzq1IQoiB+bmQOov+wTaKw7N7RSYiiQicwzINvp2T0ZLAX07qhJKtiaIPBGyEXb92PPbmwhEjws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480829; c=relaxed/simple;
	bh=b284fxjLHO9apiVnGNdGfgxpi8hMmLxomEeg+y0CqyI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rqz7XJLCtc2icT93r1eR7f5kEnm7DGSsYLc/IjAk3MSrsfqSj5pHDwd1uBQlZL/cE6MqpgDK7kXvkMcNjMQnwPa+v1bUTsy1d691LalYg6k+lY9oDz3mhzV3Ie6VBrtlUNEGh894fWDQkCrwOw0d0YP/lM4frYHrsqrqvJM3X98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bvHOx1Hg; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THbt8sPcxGOO/c8BUKtEMc18T9k5FEwL1M8tdvo7ovgvD5lqLcmGD41FhLjBiz+Ygk6dAubWcegcGc0WjKDYgCOLGfLgLbS4XMr3KQQqXKGcEdrp2JwmyBbq+u6aAQK4fBSzMQixxw/k38icxyUe2Zmiip/XXtgxxIWyoz74szLCbvEaWms7EvViv73j/S9hbUMEXQMosw1KByGDJ3NDEV1bhvZmt/+c4VKhvDl2R8OXlrIZ8brtDMjh4sUqOGjUxudhsy6DdVI1VMJG8pr0NJarAC1UOrnC01Ra5pleid0DYabOssdUL9NTcWHxZmcmnUGFwU8+Vg+PXGLnGK7bbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGDKKzwL3N9th4rZVfiFUXsWiNU0+aGFvs+I/mTGmsY=;
 b=YG7O4VKEr9IquBCEctY/IcyRJLWYhv2c/5w8skt7MU+UWQGMpbOKCUgmxK2+FjTHKpW1aBnnzmpsDtz9UWSHpQl/dPOxNw1OLWwnfNNxJhMfzhm4c746kaHgh6GuSE02BMQ1DKKhbVEg+R2fuOrfe7fXYwvPkdW8i4Gj+vEEXrfugyv37Gr2QMvYwsjPCLE5uQWrHOAdxMv/YK+2sijWxF4djFG+iZ6L09FsuSu/AIbc3EN4mktcdaLjT7cf5xt5YPNaNhhKAXyPMi283x7bPNmK2QJLDlzt+kMBOq4L9HJ1UfhOP12IXJeY7YtLvIydHbHhQ3HgTmfBZONZhS6dlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGDKKzwL3N9th4rZVfiFUXsWiNU0+aGFvs+I/mTGmsY=;
 b=bvHOx1HgUu9beEm0s+dNCuFsNV3joKBBTPASAaiTVPmfh+StikKGfKFcvevGKGU20IOUbJhBqjkGIR65Dure2MXOA0V9ED/AHt4br2QTRj/b2ufDFIIZ3KO41diJ9cyv58NHaMPbij41uf3vLuGHjayvU5MWzx3DnBp7e5zERAliQhtjmXVjGcIJq0smj8jVIvTKUuo1UF1ouo8pGaIpTfnPQ1ECn1aBBFG3ZzxHU63rqD5zODYkhCaR5omqGk8OmErj1wuzNdZeXiIXejTZl+Fe03BldaQJr0WA0nfiP3+wZWxxBSwqAA+mhJvNRvEJeQH9nC935tqRlvpHegU8AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 20:13:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 20:13:44 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 22 May 2026 16:13:31 -0400
Subject: [PATCH v2 1/2] dmaengine: Add helper
 dmaengine_prep_submit_slave_single()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dma_prep_submit-v2-1-7a87a5a29525@nxp.com>
References: <20260522-dma_prep_submit-v2-0-7a87a5a29525@nxp.com>
In-Reply-To: <20260522-dma_prep_submit-v2-0-7a87a5a29525@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, carlos.song@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779480813; l=3083;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rm3QPWBTpqbPhTrBscep+Zgo51X4ZX5aRMTs0SY4ZGY=;
 b=Dg4K4jocC4b6vmLUmlguEn6TeChINPKpdg1he1eH9BFfwKAhdEdRiVOgw80Y68ISZ9WRceHbl
 nV5amsLitIFC0+pDWAkBLyTW8wquCARhnZFJ2CHabZ9DdPPSK+e9TNc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11503:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0a9bb3-717b-4e4f-190e-08deb83e9f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8Up0sdLsGFamUXUEu9wQui34T0LeytNCGkQidv1w4Sg2zDGL80dD630SBKPBI2/1Kbntf2JBkWTI9qn7EDMYGvR+tdCdniuRN4XCJKKiJnOnc7VU6/luPPnkarZXzehgyuEBRHBLv+GZBaJnnEH6Y2E03IFOejr0ap5phY/ToFqMeMKavQ+RYPa6aYpIMXaJk3BihXVg9lv2MTnEvF++NIxCI0pdiYTvVB8ddC+18Jwq513XqJXALif1HxbDBH19UtmQMWDLtg6C5Tj/PxRmT4aYpsjLZoh262FYE+MQuvlyy55GbGftASl5VfCHi3e52IECAORUJLFHKdhhaN4MvquzVkqLOr58+nR9sNO4INw6ZQiagJkteFQh/IzRRYWnBD0rcsh2SuwXZc2ylwrphuw2kavdYTnxPMofMY0X9G3zeh5zZsRiHc4HMQfXo0tXhjAbmh+LFQuHYDMkpc+KO/30ruZUGBo0Mjg82OS8NeJSS3uJ39L0uVySsIRuQwZaiDVP1dMFyyoNqf+OmMS5hbDb4UKfdBRjQ1y9oU47bYflxl2E8dCBg3J4VCbt319ftGtN+2qiPXNe2/xYv3JrmaLaHj9sHYlDeFiFghYgggir7axBNC5p+ASczbCvmd+5xjABONo62MEcWtbcNXdEWjqEHUS9bdT28Yqq7wd5vonlL8FHi2bJYVHlhUyfXxBd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0c1UHlyNmxJZ0RvZ1ZTKzhzSExFcnE1VU5mdjg1VTFoVWxnQ0dvcTc4MUdu?=
 =?utf-8?B?eTBicCtyUjViZmE2R2ZOR3k5cW0vRHRuOStVaTFST2VXeUt6VGNFcUpXSW1O?=
 =?utf-8?B?c2VnM1NEVE1BWWdHZ3d6czZXeHhLSHRha29heFg5Qm9SWjFZRWNrdnYxZUxX?=
 =?utf-8?B?aTNCVGJYY3htUG82djZCMXluMFBZWjExQ2VEaWsrSUtVSHpJdVhucjdPTjgw?=
 =?utf-8?B?VE9mcVRkWlVDejRDditvWGF1TTJIT0RxaXJCK3ZXQ2lab0szci9kR0lPa0t4?=
 =?utf-8?B?VDcvdGJLakIzMFJhOXV3UFVQdHp6NXd2T2lhNFpjNXkvMzJBMy9XK3B4cmhy?=
 =?utf-8?B?NjUwVjNpMkFtS0ZDMGI5WWtWNkozUFlmZUt2dmNQUUV3b1hKZnp1RW4wYkMw?=
 =?utf-8?B?Z0UyVVlHU2tzZUJDY1Z4a1o2bkdzOGhwL2FiV2ZYOCsxNDkxSnFiVFVuc2tQ?=
 =?utf-8?B?WlJOeDc5QS9kTDkxNCtsMjRQek9GS0dEUzl4VW9qNDlsMUdmQk1ob1dUQlYw?=
 =?utf-8?B?ellTYmlkcTNkdERKTWJDakx3dFJBTXZad0RSeGRNa3pLcmhiTVhCcjI4UFFw?=
 =?utf-8?B?M3hiS2hqL3BLaGxoc0Q3NHlNUUFjME9GcEtwNTVmTk5PQjBqZ2VYclBCSlZW?=
 =?utf-8?B?Q3FFVnhXSnJIU2ZlWFFJVGhoOFVxQU9lV1BVRmJSSVZzNTFLYmxXMEdRdE55?=
 =?utf-8?B?TlZqRXhnWElZTmdtSkhUOTRxSktuR3B6WmdMU0Z5d0tyMzZwYml0VlFzMkFE?=
 =?utf-8?B?K1RtRWloazBwckJJZ1loc2RQdHpFaGk1TU5aZWt3OFFPd3pKMVdIT2xHUzVK?=
 =?utf-8?B?WkxEVWFpTG1seExWczNBZDBLTVRWWkNTYkJOSmtoU3FtOHplVVpxK1VRaHBy?=
 =?utf-8?B?QXdkS0RqbjJwdW53Mm5RRXNxSnRqNlFUL2NvRVR2NXlTMXZSSC9FeHQzV1h2?=
 =?utf-8?B?Yk1FU0lCRVlVdTVrRm5idzNGM2xKSHJOdnFwK2RBR1RrTXJLMEhXbjZNd1pt?=
 =?utf-8?B?ZlQ2S2tEVVI2eGo1alE3OUhlWnBlT2Fxc3J5QlQ3SnJjcWgrVkNZVkoxamZr?=
 =?utf-8?B?RmNrdXJyRjhNQlZJUUZpU3cvWkNZRG5TSVlGVlJhYUF4R0ppcUJQY2l4ZjVw?=
 =?utf-8?B?cWhEZGFFNnlhc2hnVzN6V0l5KzNQTlZEZ2dkb3FiaWRiNUk4RWlXbUtGVHpM?=
 =?utf-8?B?SUx5a3J3eThSRTJwOStuMzdDaWMrUk9OTVZwVU92TjQyNmdUay93RDJYQm5E?=
 =?utf-8?B?cDIyM1djS0hzVjZLMWRwbVB2RGFHV2dDemZIZ0NDVTVjbTBTWnJZYmlDcDUz?=
 =?utf-8?B?c2xKdlRWK3phWXM5a0x4U3lsczJGc05nK25ZSGJ4T3ZBTmFTVXgvb3p3SGRn?=
 =?utf-8?B?K3VoTlN6TEdxdzhkOG9vNkxpWGUrWk1NU3VzV0g5T1B0ZFZuOGJieTlOeWd5?=
 =?utf-8?B?STVlalV4MVlXNGRVZDlJNjVLb2lXamZyVTFmK0t1RjZsOUhQaU1wV2o4V2M2?=
 =?utf-8?B?RDFVTTVRNU9zcndWMzE5bW1uZnVQekdPMWhkSVN5ZHNCQzJiWk1LNUdwMGZE?=
 =?utf-8?B?bkYrZnJvU3psNmNQVWJRZVkwN004NDNWRGVTVmpSU0NuTm1XcFZ4bUYwMjhl?=
 =?utf-8?B?QytMdWZSTTdaZ1kvVWdmLzNvaTNQMjduVGlHUEtiRk0zWnVpWkpNakhUMjZC?=
 =?utf-8?B?dHB6ckVUNFhxWElnWHNXaGZXWmprSEE1elhpYjhTSVFyUDgwais3YkJIcitC?=
 =?utf-8?B?TGpPUzZJNmF6WDFyNDAzbWVpSmdHbXk5dnl3Q3JaVjNPOG5sV3VlZWFuaDd6?=
 =?utf-8?B?UFBwUnlzR05KNUNyQVBmQjJqR1hUeWlRRmJsbmpCa0Fobk03OXYrWUJHTmYx?=
 =?utf-8?B?Qks2TDZzUmpNMjNZakE3QkxlTkVoYTc1RzJSNHE2OTRTR1hxTzYrQVEraXRh?=
 =?utf-8?B?RmtYcDRDdWFlanRRQnFncTBRR3dHMndzYWM2REluYzlLcXRlaHh0OE1LZUlL?=
 =?utf-8?B?K1VtMklDSlV0OS9uZ3BsTEVaQUsyMWtUdkRzdFlTWlZ4bWUvektINWFIc0s5?=
 =?utf-8?B?L0U2M2FOSGM4RjM5WittaWYxSzJLTUg4NWJkRmcvRDh2dzF6eVU3Y0lkVUdJ?=
 =?utf-8?B?U2hTMitzak8zQlRwaC9DSkdJbGpUM3FpQXdtTy9RblVMcFU2NHNCSkw0NUlE?=
 =?utf-8?B?ZWdETHRWOWlUcFJudUV4SUtRekowb2hiSHNBbDlQVDh6Rkc0dTZ0ZGp3N2xl?=
 =?utf-8?B?a1hzVnNzSG9CTjNzcWFPZUM1ckZnUW80cWZFNXBzd3ROc2NXNHN4K3phMzRx?=
 =?utf-8?B?d3hMcU93T0s1VEdWbG5vdzQzK3FKancyc1JsM1VldmxaY0x3QUdydGY3ejVw?=
 =?utf-8?Q?jOMTTukPw/GSSxdnBZWNCA6cxiOMziF+xDjmF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0a9bb3-717b-4e4f-190e-08deb83e9f95
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 20:13:43.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zB1RpI9ushg5p6jmnwLJZJzpNMU6L5JFQbvR45agi1FIHRKxGf5cC4A03b2DVbk3+IqyU/oD6BlaWDIyEXPcQfxWNCNGPCdx8jG/lRcN7ZiARE9KKDPapoRkWHkeHrez
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10763-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C91AF5B9EE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Previously, DMA users had to call dmaengine_prep_slave_single() followed by
dmaengine_submit(). Many DMA consumers missed call dmaengine_desc_free()
when dmaengine_submit() returned an error.

Introduce dmaengine_prep_submit_slave_single() to combine preparation and
submission into a single step and ensure the descriptor is freed on
submission failure.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- use api function dmaengine_prep_submit_slave_single()
---
 drivers/dma/dmaengine.c   | 28 ++++++++++++++++++++++++++++
 include/linux/dmaengine.h | 17 +++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330ba..1e25be78a22a5 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1619,6 +1619,34 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx)
 }
 EXPORT_SYMBOL_GPL(dma_run_dependencies);
 
+#define dmaengine_prep_submit(chan, cb, cb_param, func, ...)	\
+({	struct dma_async_tx_descriptor *tx =			\
+		dmaengine_prep_##func(chan, __VA_ARGS__);	\
+		dma_cookie_t cookie = -ENOMEM;			\
+								\
+	if (tx) {						\
+		tx->callback = cb;				\
+		tx->callback_param = cb_param;			\
+		cookie = dmaengine_submit(tx);			\
+								\
+		if (dma_submit_error(cookie))			\
+			dmaengine_desc_free(tx);		\
+	}							\
+	cookie;							\
+})
+
+dma_cookie_t
+dmaengine_prep_submit_slave_single(struct dma_chan *chan,
+				   dma_async_tx_callback cb, void *cb_param,
+				   dma_addr_t buf, size_t len,
+				   enum dma_transfer_direction dir,
+				   unsigned long flags)
+{
+	return dmaengine_prep_submit(chan, cb, cb_param, slave_single,
+				     buf, len, dir, flags);
+}
+EXPORT_SYMBOL_GPL(dmaengine_prep_submit_slave_single);
+
 static int __init dma_bus_init(void)
 {
 	int err = dmaengine_init_unmap_pool();
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea9..0f789fac7e91a 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -990,6 +990,13 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
 						  dir, flags, NULL);
 }
 
+dma_cookie_t
+dmaengine_prep_submit_slave_single(struct dma_chan *chan,
+				   dma_async_tx_callback cb, void *cb_param,
+				   dma_addr_t buf, size_t len,
+				   enum dma_transfer_direction dir,
+				   unsigned long flags);
+
 /**
  * dmaengine_prep_peripheral_dma_vec() - Prepare a DMA scatter-gather descriptor
  * @chan: The channel to be used for this descriptor
@@ -1575,6 +1582,16 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
 {
 	return -ENXIO;
 }
+
+static inline dma_cookie_t
+dmaengine_prep_submit_slave_single(struct dma_chan *chan,
+				   dma_async_tx_callback cb, void *cb_param;
+				   dma_addr_t buf, size_t len,
+				   enum dma_transfer_direction dir,
+				   unsigned long flags);
+{
+	return -ENODEV;
+}
 #endif
 
 static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)

-- 
2.43.0


