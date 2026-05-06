Return-Path: <dmaengine+bounces-10253-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMpFBvyo+2myewMAu9opvQ
	(envelope-from <dmaengine+bounces-10253-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:47:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A94E05A8
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A590A309435D
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD23B2FFF;
	Wed,  6 May 2026 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GEXP5XO8"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013044.outbound.protection.outlook.com [52.101.83.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD13B388A;
	Wed,  6 May 2026 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100316; cv=fail; b=OV2krdy3dL2tsmJ+Zwu4b8cPHJfchs+XNd7jO6dffcosuGOmr5DGzmivpXnqKUEekeBPcGmgWDrCBSNPDm+sVAwrCyuVu1mEPGnF1Eae5NgZiPp7v87xTHxxdqsCSnWcapdAWpB7RLBgNrDo7GSmRi8pvxfg+rq/gXNGTIKGigw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100316; c=relaxed/simple;
	bh=ewqGbq/a6Fri69k6AcMWiHQJDkdRRZkdZmXyxU701QQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MlYUtU4aB2LiVQQReooCm2/ifWfjvnv/XMZnAETnnJcLsgY/Wm3crZSwO2njuYJ865bxfzIEmkyScmfk34Y8qCcJP5DWFoln4ijFGd7GNY4qDQ2t6mAYkCEczk+LAaRpGH9Mv8AeFBD3Fb2OMoHEnYNE3+HZa6mD8rUe9DL43h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GEXP5XO8; arc=fail smtp.client-ip=52.101.83.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJTNPtJjdzwPQsvkBNCIIzEkvuKDp8zHBY3wfT5wrX3kGe7Om6/AjZYFAVjXbJOeZ5mYbUnLZxRhdfwjSGs44akDZpJkhyJGPFXXYbAB+77lqB3Zn/z/KqjHfx4rg4vHNJJeGYkuEi1qeg5soE14wRD8VwW0z1MKBjNryMQ1Zl5wKdJmwAV1Nmap65lyqEhSej+yEH/Aqclo9eyKPh9D9Q4IGKF+uPG+pD9SkSm+QYw1gXnmMEBOmggXCW+DEWl6+kJdcSNO/yEa25mcNGDg2LTPAOk3lEpmqK/e4UWKLet7o0O1vK3z1S2wvlHH94w48FNSa+p5lKCohO+sL3OK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqPY0p8jDgE74yvJfwdQ5/+zHgEN+pCu6Yjn/v91/tQ=;
 b=JsOaA5mkl4fZfJ5aDEef5rRlvogiPYC19JOiCizawmqm73mDOUhAfNrXC6dlBDagTvcoNXAso2pqvnApZ2ZGAhF1JuescMFGOrA4aZbjDE6xPwOHa3vNvEh3TTjAqDipSxx7LzfMjsQf2SChKCAXZooSml9YzwjQixk0FkykflD8eKrNnAF2x7SsOKdZaemgiIwL+wyFfI2ROBlynEQDKUbMykPj0/WuJtdV1R3g6jcQq9qGiZbYVHxxTECJt0z5jUkWJK3wYJJKOfJ3gsnylbqn+j5tl62sz3GDKLefUI0pESra1DqV/l7HG9r+4VimBmZDfCXpRNFyQXT6QE27Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqPY0p8jDgE74yvJfwdQ5/+zHgEN+pCu6Yjn/v91/tQ=;
 b=GEXP5XO83slt3HfbMdvF3UDbSxPSTIcr2bPupW67H7kpOM8q/K7fltiZJ+hu2rzluy2UHkLcG6waFN+bYv7EvBxq8i9srKbyKz4p6OtntQpirCCn26uz0nDIQvK7m9PQEDZypH7LR7f11SduKcHL/3dEBl5J+YjwXdONkS+2zL28DrWQmLacNb0o23sJOtYraQhgqsQAvn48mcAoi1rWgVvAZjb/PNvjc6DIfFWXKF4bulNcyDOnPq65KPTDky/zBTVXeUkN+riaheNAox8+MfTE6WgnjsAsMej4dmcIfjFFLkfEFeHxq21KM1fEeKcHisl/qeSQQyUyVvvFMRwr5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by DBAPR04MB7319.eurprd04.prod.outlook.com (2603:10a6:10:1ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 20:45:07 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:45:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:21 -0400
Subject: [PATCH v4 9/9] crypto: atmel: Use dmaengine_prep_config_single()
 API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-9-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
In-Reply-To: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=1356;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ewqGbq/a6Fri69k6AcMWiHQJDkdRRZkdZmXyxU701QQ=;
 b=M3IH1CmJSO6VFOT+XqauC8zPPZJ0y8dBB0JtIAGFpBJ30dT3m2TQljwidfBWOzJtPebEm0xbt
 A4wZS1YV+O6D40lVb1ycWe1xSKtnhBP1yFkfeBUIJUYW3S4bOz7seFu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|DBAPR04MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d11b016-6ab0-45ce-a8e8-08deabb05b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|1800799024|7416014|376014|366016|56012099003|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	8FfxIC8FizgzpznZAz7rryFF5vhhKxMeg1iAUNDcJ2HYaOJy02upVGKcVPifXwcwKD5gmfep1maDtohooyaoUwFa5PSllpCr/n1oPDbEH3RT3g0Gg06lgSlieV2uXIZoIPt7eIBIdvKXFYzh5WtXPMgSb1JMkn6c0R994ikfMhCybdEgc6B0UePjv5DSAM80fYfy+ZOv/XsnvpTC68+w09k3C2dQLBcw2JhjPjc4WsoGJ85IPhsVNv6JJ650RYn0YG8kN2AYlVyucCIU7tqqqK7KsUpnEc3tQRA0OpjVtyAiS5pZFQbdpinSyy3e+91FNr9tMwcLxOv9KfuDbzSqFpN6mpr8vom5D441LUCGb2yzr2RKE3qt5k9gVcUXOlklRY95lUcyM+4OsDt6R6IsPJAh1PTozDBqwWDiGebAsr79AF5PtRgVQG355KOUH5BbDV/NosOMz93YydlZLBCYgYwrbMCCaIMevqol49QL4/Pku5eWM3YQtLXCWt0LKaFioyUijqX86pR2463Npn8e0C15k8+4B94SsUYWWXGaUEzD0BcR7S5V3imEHqSgUKm/T5vaSRScKDmrUuTP9vuVAJUXzQkXu2IgPayCt+FuKvlTLJ4NRRwVK1T70kYO4gTtL+6e14tHLXSYP21uq08KZniym3S+fjgSB2kyOE3/P7eNNnlrM/HT95jCuJDETOyDyEsR+fkgLgfL0AES2XjgDb59g4rVWk2W3u+VpAU8+cBDOTdm2elSasN4HoHbzHeORDvEeVBTrq/QFk1/p2y5Lw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(1800799024)(7416014)(376014)(366016)(56012099003)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2xwT0ZBa2V0TTRrTTV1MU1UcGVhOHFHcTkxMmdweDZ0eHk4UnNWd2RyRWFV?=
 =?utf-8?B?czVMZDFIYlRKN3hBdXdMNlJxWWIyNklpSzdyRHp6UGxTbklzbldQZlpWNk5S?=
 =?utf-8?B?UkZBVHI3d3dveG04YWV6UGFuZlBaMWlkUVhuSEpUTXZjTGZGY1hxR1k3R0Zk?=
 =?utf-8?B?a0FpMGlJT3JXTWpQdU9RMmJ4RS9Sc013U0lkQXB0dnZJdnVnZUF5TzdTQlRB?=
 =?utf-8?B?cU14WjVtZnA2bjRZME9rN0c3UHZRUkRDdXk5OG4wQkFaRjhXNVIrWWJialE3?=
 =?utf-8?B?dDFjdGszQW81WVJrakJlWHZ1SUpFTStQYlcvSGlQS2ttcnFzN2x2cWdzSUZw?=
 =?utf-8?B?bGlUVWROSkg2Zm9Hb0dBOVFPWDloOE4vTUpYQklKbDlKc2VtVlpuVDZVUHRQ?=
 =?utf-8?B?OGtaYUI4UE14UDdFZ3krRndST282VnFNT0NlT1lZcCs0WWFZeU5zRmxTN3Jx?=
 =?utf-8?B?VXQwTFpTVytYZWxCUGJpTFZlMFdLSzJsOHp0ZlRvMUt2Ti9OZzhkaDBQL1o0?=
 =?utf-8?B?RWNDUEVYbkdIV3huQXdKRVowdzR5aTNGT3I1SXpKelNIdHEwQ1JjN0hJOENi?=
 =?utf-8?B?Nlc2bnZGd0U4emx6WGJIWVJPSkZqNURMSkEyUlhXL3JhaTRUbkhES2RFaTRE?=
 =?utf-8?B?YkVPbkxDZnNRY3JuaHp6ekU4L3lrT0lwVng4TGpaR3lmMDFmK2NVSzZKWmJ2?=
 =?utf-8?B?SkpyREY1V1dCcVJoZ0RIU2xoRlowa25mM1UybnhrUThiZGYwY1ljZktNL25M?=
 =?utf-8?B?RzVOWlNtemQ3WUVjcWc2WjVGZHpsL1JvNTQxSndmZlVjSFlvR0NPaWtWbjIz?=
 =?utf-8?B?ZmpCQ290YTJYV3NRM1dmRzI1RkJZSjU5QWg3eFc1elNrVy9SaGZwdytmeGc2?=
 =?utf-8?B?QS96QWQzMjBvaHlRWGkxYnpsSys5TVV2S0ZpeW9ObzF5RjJqU01VUjdHRUY5?=
 =?utf-8?B?a2tVWXRBRmNNZHR6cExpSjZvQkxaQ0NQS2RSLysvVDlWVEFoSlRyWXQ4RVNT?=
 =?utf-8?B?VklaRVBWWUtWc0lRRWNIRllIS0hISXdQSnFHOUJaVWFWTWJwK01UVEw4Ky9R?=
 =?utf-8?B?VXI1bUkyVm95VVV5ZkkyWnFHSUIySlQ3eEFMdjFkSzdmbmJMalZuOVF6aHBo?=
 =?utf-8?B?L09zMDZicGxNMFgyV2FnckZXeElrYXNyR0s5ZlZRNGlEVXlkMHRwVGtDTjdn?=
 =?utf-8?B?UDlWYWtPeE9mVlY0QVZEYUcvMC9IK2tKVDBoaGVvRUVwTXU0dmFYV0xqUnhQ?=
 =?utf-8?B?NVpPc29mWWQwRlBRUVdrZU4yblRzMGJTNVdjaDZ4MUlkYUp2d3FBWlg5MjF0?=
 =?utf-8?B?NHdMK2NiZ1F0bzlJZ1VDWTNLKzQvNW9LKzhEMGQzSHRCTWtIaVBMUFBSWTJh?=
 =?utf-8?B?eUE2VVR2LzFxWUZqdUErNmh0dUxjSjkyUGVZZ0hpUTNHMnM4azdENEo5UTFz?=
 =?utf-8?B?Y1hOV1JiZUtGZDUrNzlCL0NkWEkxYkNMck1kdVcyWFc4ZHVZZUpMdTJzQjV6?=
 =?utf-8?B?ZEg1cmh3SUJxbEVFTHRjOVQyVGFVSmNycWVZVEQ1QUwreG9wK3M1WTdvQ0tV?=
 =?utf-8?B?R09oNEovRzdpNkl5QnJ2OTFvdEpnODJyclRPYVJxOC9CcHo4S01mdWV4ZzVm?=
 =?utf-8?B?QW93NjEza1pGbW9oYWxyd3R3VXk3bkQ4NGFDYjBaM3pDM2kvTWNyQ0I0c1R4?=
 =?utf-8?B?a3dmWnJzRFBvUEZrWVcxSE1LVXZqLzVNZG4zTUlRY1I1akUwR2lDNmc0cndV?=
 =?utf-8?B?V3lUNnpuSnVxNXh2Q0dWc1lJVVkyb251elJ6b2pGZ3FuY2dxZW1CNXlBakF1?=
 =?utf-8?B?b29yQ0tIdWRYWFhzZ3ZGWDR6NHZSbzVnZkJiWFlTNHZVY0VvWE5EU2RwUHNS?=
 =?utf-8?B?UVB2U1NoRW52Ym5VR2gwWE82TEU0QXhlcTNEeXZUaWsxdG5GOGpvd2oyM0pM?=
 =?utf-8?B?YWRTYjloMEZBc3V0STN4bmorUEVvK2hhdlkvWm42TUYrNFkzd1hHMUdSTnQv?=
 =?utf-8?B?ZkZ5NzdJYTAwTjR4UC9iQjlIeXdwb1JCbHkyNzVROG5sRXVTUzFjM2YwbG9P?=
 =?utf-8?B?amF4K0grNTNrekwwZXUyN0JBOS9mVUErQktmdjB6YVpmbjJrUEVrWGtEb0ZK?=
 =?utf-8?B?OWpoUnZYRkhzRnRoSm9CWGJDd1pWZm1BblcrQ2F0b3IxTEZxeEVLR0FNTTlv?=
 =?utf-8?B?Y3VCTUJRWkJaN0Qva0dzN1d3cFRsYm1SN0RnWHZOQVppR1ZnSXVUNjJzOWdB?=
 =?utf-8?B?akI5T2YzVEFRejNsK3o4bjd6Z2lIL2Nkcm5rSE1MK0VUY3BMclYzVEVjaDhx?=
 =?utf-8?B?Nk9KTWFqbzNZV1FTWmVxVDVGclVaMENlMWJyd0R5R3NBTEpwalg5Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d11b016-6ab0-45ce-a8e8-08deabb05b63
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:45:07.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y08ICFJenWp66Gcn0sR6dTQddvIL6nIBPCijmQmoomGQ0HWcxtflQtRmZgoeWvdL6X1QzijbUPpOPwVZYB02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7319
X-Rspamd-Queue-Id: A47A94E05A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10253-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

Using new API dmaengine_prep_config_single() to simple code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/crypto/atmel-aes.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index b393689400b4c17294cba73fcd16567fdd6687f4..d890b5a277b9c1394d2c7912bd663ff86321099f 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -795,7 +795,6 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 	struct dma_slave_config config;
 	dma_async_tx_callback callback;
 	struct atmel_aes_dma *dma;
-	int err;
 
 	memset(&config, 0, sizeof(config));
 	config.src_addr_width = addr_width;
@@ -820,12 +819,9 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 		return -EINVAL;
 	}
 
-	err = dmaengine_slave_config(dma->chan, &config);
-	if (err)
-		return err;
-
-	desc = dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
-				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					&config);
 	if (!desc)
 		return -ENOMEM;
 

-- 
2.43.0


