Return-Path: <dmaengine+bounces-8248-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E8D20765
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 18:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 380623008CA4
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D522E2679;
	Wed, 14 Jan 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="faY1y24B"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E32D8773;
	Wed, 14 Jan 2026 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410796; cv=fail; b=qsesvMjpO0OwJ4LcdRPEEVH06M8Rj1fR/EYi2m1jNmyADj4Jrc7Oq4Zfdf52XJ1mX61lwXy/LDSxeAKcWmqZTzPKbtQ5X4XU5i0hqkIpqxCZlwehWHKVw1mHwurh2SITYHa29/d38AmgKFRxdzhv6WJZdiudBNtx83D/c7JXANY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410796; c=relaxed/simple;
	bh=iNxT+5RizzaH31eSOaTYX8/xOFmhLp7S6gFVdUUgZ0k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DRAI6OpVWG6UYjE+qR/cTUUY4dt4d+7P9iSbrYiJ9D6i6agJ/pvDRtmK7C5TWwlFVUyxFtzzDiKOTgj3VV0NYKgU2MVVETUnkzVVRV4GA45c9/a/01ayf3U3rCwZFbDVlkNZMuGC7mF83PXf333mtp/KnDIv/OEvaHMXBtbxxN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=faY1y24B; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDfdekPVsGGTZ3OUB3/BB03rBncLYHs5NxW+tvwHnw0z3DbNtFODb/4LgWKZZbIDPQCWJkzb3S7fseZJMnGAh72sW74McqhODTPOJIMSSOQOpyVARYO9cWzPyp8Y1iCZpC07qUMfClRv/Vdd2U1S8nLBJEOK23iEDYcQFCj2zQlztmSbNk4wbilC15yfESkAuqMC317CMQ5EfI50n+iJT571KTrOUrJupznMcI0/sSbcpmlecWghysj/ZyFL3svj9nmyIHhvRfP4iIbxGu/YCMS74sVpfPggi7aFD4jbgOarhlaH1BBAAHbch1J2VNrEmqBUC2Tn6lmXjfgPPUvTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOPS2QJzpixToSht34ury4qvWgh98yIagWwYZShZAXU=;
 b=wbCrjTi7bEdrLjP72pFQv2HEPkordfRZGglXgqRWFh/91zZoGVrQujCX4U0SD1O6UPANp4L8sDwqYf81hpVFiIAqpQcnm63tNwGg630fgwEjHERgPxNdPKLJH6ng4qeQ6cNwFIayFMvBbQ6vawkuBYAuM14AE7EVHf84uBr7KmUWxdiutLzMR7XpSMfkDjVycA9DXUkcYy5p7B0wWQf/oZP5yBasfVvmGNudBJUA1vebSmO03aIdOznN43L2cJ4gmPEG8xg/4n96edg3pJh2HTLDWlGjtGtGSLJlf6xCCxEGgS6JtRAnFo8/IEJxJfUaQwHSzZ8wvCbOPGJjvacBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOPS2QJzpixToSht34ury4qvWgh98yIagWwYZShZAXU=;
 b=faY1y24BgybZNCqtfkjjZyvv8cfW/dVo9b71snh2oLcmGoalSCt3E5BV0fXfeWzzDyTBHEjOocGXYJUAa4F3yg6rn4ofVlYSdfL8Y+z9Ni7HKsXfaXq1RkZofZ4WzJftCiq3Jz0ap9IoqXuW8BmxKMpV9aR40UHKLxa9qs+96kELRwKPrDJ+1tNwvDucZWwHVuUQPgMnqTAVzmt3qs50xEXDQ8OQF+1nHNMKTpiR/XQqkBNAFjamcE/khJLo95JBasLoV1MJvq4wZcbMM1J4SyOpKeLahXu35/rAPyKw2yds/B9/a5HK/oTfOgPDBk1mMVL7AJSqR7bJlHPIXG4YDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12155.eurprd04.prod.outlook.com (2603:10a6:800:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:13:09 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 17:13:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 12:12:42 -0500
Subject: [PATCH 1/6] dmaengine: Move struct dma_chan after struct
 dma_slave_config
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-dma_common_config-v1-1-64feb836ff04@nxp.com>
References: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
In-Reply-To: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768410779; l=4851;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iNxT+5RizzaH31eSOaTYX8/xOFmhLp7S6gFVdUUgZ0k=;
 b=yrOiclvHwGWAzf290OT9kR0//+7pyuZ7Cy7VLYiYz+0NCtllmL4AdmQgQm6WAjw0bEilEvwWZ
 NBlw8Af2xaVAhflGBgny65B8O6SnyT04Qe6a7cGynBxPDzg4bP0I9HG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbf22fc-6e37-48de-5e58-08de539030bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M09GVUtrb1pINWdKOVgxbUdGb1VWaXo1dlRFMC9BcE15RzR6VlhwdW9KMUMy?=
 =?utf-8?B?RDdsMGRuOEJKZ0JKZDk2aVgxUkN6MVpaclpWU2tMMHNvVmpWTCtjdHRCOFFR?=
 =?utf-8?B?SFZudjBpeXJSdmVNVThiL1RrbHVDTnR1by8rcElQT2t5TTdPaldHS0l1dDZQ?=
 =?utf-8?B?LzlIRDJ6ZDFyZVRHZFRoeG9zYnlhSmc3NG5tTWZ4VmhueFVkZ0FkWTF3VU93?=
 =?utf-8?B?RlVLOFZRK2I0ckRyQytZcS94MER2L0tIR3JzOHpDMGp6clpndVBzOG8zN3pM?=
 =?utf-8?B?VmwrUTQ5MUhnc0UwMDc4ckFFSURCREwrUTNYRHNWWnlsRzJIRW1vamJlajNj?=
 =?utf-8?B?U0xIaThTb1F3R1ZFMkFVdjNJcksvMDQvRWx0SmZJREZrN2tQdTZlK200ZnB1?=
 =?utf-8?B?UEd2d0FCRkVvNVF5TDV2SSs2NEpFQitVeFFRYU5GdjRSZzhLMHN4MHpubjVZ?=
 =?utf-8?B?RjdLL05vZXVIY3NjQlltZTk2Z3Jkb3ZtYll6bDVISFJOdnhWQmNJZlhWQWtS?=
 =?utf-8?B?Uml3SlZ2bS9sVEVpZ1dhT0kxT0dlRVVDd2JBVVFKVWRkQWdsSlVubU9td2xq?=
 =?utf-8?B?Ky8yd0htcEk5RHRiYVBBbzB0ODBNT1puNWc3YW9STU8vTW5lQ2xRRWlYbC9C?=
 =?utf-8?B?Tmg4ZDNhTDlBa1c3ZHRoTUVja0Flek5QT2FicURsdmtjZGRza2dUYmFVeElX?=
 =?utf-8?B?emsrQVdIbmRqd2cySzMyV3BhT0lIaERCUlNacFp1U082Z21nQnkwOUw2M3Yz?=
 =?utf-8?B?b3VNM3VNYUFIc2RBaWFWTWhhUmNISkRtNmplbjd6SUhJRi95UVFlem43VU9h?=
 =?utf-8?B?SWJ2MzdlRkljdjIyZXZKQllrU3g4TWV0MWZBN1JBOGU1RlhQRGhiNmtnanVJ?=
 =?utf-8?B?bFpiYU9zYTMwRGgzaXlGS096MnM0U2lNWllhWUlCdUlobUJ3MU1zeUExRit6?=
 =?utf-8?B?N3hGeUVlRVhUY254OGo4U0Ezc2Z3d3dnS0RVZnlLL2RFdVNNOWlsYWRSTURL?=
 =?utf-8?B?bjZnYnZNSmdTVUFtdTMzWTVhSWhQVmNzaGdWd2RseHd0bTE3WmY0RlM4aFBm?=
 =?utf-8?B?MEEzWm9oczdScUM5Q0ZvWjJ4MmQzWUVRUllHYXRkQmNWVlNwZjlXOUl2Tndn?=
 =?utf-8?B?YWUxSzBYQ0thYlJLekwzYmlLZnBGd3lGVEJRbUlqSFlrZUliMDVNclkzZnpm?=
 =?utf-8?B?akQrZ0R4T0NjTWZtYkhjemFJWlFsWE1nUGJtaXJQOC8rV3htK29qVlMrWTZr?=
 =?utf-8?B?Szd3a1BjV3NDRzN3S2tlejJtbldDWlM4THcwdWFPdEhFYVViWnlBamhNMnlK?=
 =?utf-8?B?OTdmZ0JDU3lwSE01NkxrUkdTdTYzNXlZQ1BEVXZwRWlGTVJxMnBtcFU1d2Nw?=
 =?utf-8?B?WkovcDdtSXRncHdkQ1k5c1lKQ3RzNG9kUzV0Ukd4cHhKOE84L2lCSjRCdlI1?=
 =?utf-8?B?NU8yQm9rVlFGVmd1OEtWMjF1QUhVM3RLWkdLUGcxUEVDc1JvcE5jSENjSk85?=
 =?utf-8?B?MmtNR3hmNk9lY3ZTMW4xMXk1OER3SUVNKzB1NlBXTmp2cGFlZXJ3VE1JbCt3?=
 =?utf-8?B?NTdjTnBLVUQ0djNhdTFjQVFudEZGdEI0c1RiUFBnNEYxN3BZcmJIVnNobE90?=
 =?utf-8?B?ZDB2eUlaOHhYSnpZUTFsOGRBSldIenZ4OHBYRk9sck1WOG5JQVFQcmw3KzZx?=
 =?utf-8?B?M3VuSUNmb1VNMFVUS3FJZFNyWjg0UG5kQU92aXlLckFzYURXUGd6NVN1SDN5?=
 =?utf-8?B?V29xZ0lNQ3pMNnRFejVEMUdiZ1lFWlZxOEhaRjA4RFNjSFZUUzVFV0s2Y25x?=
 =?utf-8?B?MHNROEtEUFhqNk1TSjVDcHE1UGlwQ3JST2I4L0VDbkpYaGtZMUlvK2dOZ3lB?=
 =?utf-8?B?T2VuMjJnR0NSYWZjdHczbUp2UERNUU0vUzJOdlFqeU5Qb0JjRzltdTQ1ZGlz?=
 =?utf-8?B?WVJTbEV3QVdyazJYajBkYWJjSC9QQWl6VUZoTW9DT283Mlcvams5ODc0ZGNx?=
 =?utf-8?B?OEdoQzZrb3lPQUgwNVFCVUpVOEVpeGFlcFRlV0llTml3Ti9UTGhGcG9pRmtj?=
 =?utf-8?B?M0w3aU5JK3h3dkEyaDRnNEkrb3M2bjlSNkM3UkF5a3FuRmhhRlBIMHBkQ01u?=
 =?utf-8?B?VndLNnJKdXlzdW5KRUtmdnptUm5YaW5oVnU1UnlCL1hoY0FDMjVla1RkemRj?=
 =?utf-8?Q?gEmnXqyUqpmzTIlwqOIMAWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzB2RVczUzEzNFBsaUpMOHh0UTJYaFJCU1ZudFdXTWZKTTM3QWhwMWxNZG1E?=
 =?utf-8?B?bmxOVnFKc2gxakdtdmpjZkhza2Z3RmU0UzJNOWkwZUhyWURmM1BuNHFheHB3?=
 =?utf-8?B?U0VkckRYWFo4MUQ2WUNkRGk5VE1wRldhWjdnWjJFVElrSEY1RGVtQ0RjNW52?=
 =?utf-8?B?dHJxSlg1MUF4aHVmL1BqdVluSFFaMDd0T0FVRGVpdU9yUG5CKzR3WC9odXdN?=
 =?utf-8?B?bkRwTWdGSE8zdDZuOGk2S05EOXg1SnAwcFk2VVVoalBWZjB0dFc0VlVyd1dE?=
 =?utf-8?B?UCtkbjVMUUpXaXoraVpLc3d5eEdCM2FPdjcwYm1yZFdRTUZwbU1EZWs0SVR0?=
 =?utf-8?B?cGtXTzA5QzA4ZG5CdDFXNmp4Vkw4T2ZIVW1LWllBZlkrS3JCN2VLQjFXWW1E?=
 =?utf-8?B?MG5jRUFTZGpNTTUvYmtHQ1BUTFlUK3FibjFPSTJrNG1sQzNpQjJ4VFhmbEFU?=
 =?utf-8?B?bU1rWXhPOUpQUlh3TGliaC92d2d6M3cxbnhRZVB2emkyeWd1czZaU1lreVZp?=
 =?utf-8?B?ZVhxMHQwK0dSNDAzWXQxb1YxOTFPZkpzM2x2QWJtU1Y4K1ErVmJ4UVZmdy9K?=
 =?utf-8?B?c2xpSUlTd1E0WWtHSVJCa2dXcEE2NW9MWVpUOXN0R3NOTVhkVk9ycFYzajNQ?=
 =?utf-8?B?MXJISjIwR3RrZWVaOVlFV0hKMWJubHRYcEpDU3VtNlkxNU9XNDk3MmtyV2Vw?=
 =?utf-8?B?Ym83Q0RNL2NtamUzejJsM2IweElPSmkrTHdmcXI1d0dzN0dQaE9LOTBFRHBv?=
 =?utf-8?B?UXpXcExuNUx3d0VnVy9Ib0g0TXVUNm9zcFVYRGNxK0x1QndaTWdRaTdrajBM?=
 =?utf-8?B?ZjhxaTlIQkk0TFpxQlVITGZ0OXBzTXJnMVI2SUZUYVJtRDhGa250bDRWSWV4?=
 =?utf-8?B?QlpyVWxQb015WjZPblZJRHNpOUViQmRKMTduNWV5dW9tV3AwY3BNaGl4RWwy?=
 =?utf-8?B?N2l2TFBxbVpRL1dobXQ5Sk9MWFNtS3BubVJZRG5JaVJLVTgrL3VtSGMzRXlp?=
 =?utf-8?B?S1JnZitIalNpSHkwTmZtZ0EyaFZaYjZYOFNrTjA2bXBGZi9iME1jZGRKdS9Q?=
 =?utf-8?B?cUs2cE9hVUU3QnQycEprL1NwZHVNTEI4WTBzUDhQdE9HZUFqYVJlY2J5T2k4?=
 =?utf-8?B?ZDNtOC9hYjJEcmR1MlpyNjB0dDNHQU93dFc1OUZpb000QmNxMGQxUmovZlpL?=
 =?utf-8?B?NU02aXRFSG0xQ1hBOU5iVWVsbEdqYTZIUm55K2I3enREVUU4Qk8rTHJFR3NZ?=
 =?utf-8?B?ZmxkNFlJY1ROczVFb1lobHJoLyt5WDVaeWFZdU1hN29wTEFaYXpaZjhpN2Jl?=
 =?utf-8?B?UjIvOThyQ3BqWWt4Q3kxRnIxcFVldFA0RHljMVFFU3NkQnVmQWRqR2sxTEg1?=
 =?utf-8?B?NnZ1TDdRcnozZnNoWStMSW1DK3JUV0JkK0w5bGt3SGFUbTV6UnNSVWpRZy9p?=
 =?utf-8?B?dEF0ai96VGlMVW50RHlpOVQxNTBlM29NVFgyQVNyUm9TNXRJTVpxbkEyL0NE?=
 =?utf-8?B?cmtyRzI1ejVhbGg2aVhQRXNDVysyNUZpS21kT3FOZGV1N21wTGFYWDlBSGMw?=
 =?utf-8?B?cDBzZFVoNEpidE9JTVlVR3ZPS2t0K0pVUTI4K1pqc0JHNkd2WXI4UlpiVUVF?=
 =?utf-8?B?TGFGQkIwek5PdjJQNFZWdEtEbFN0UlVDRjRvcUlGR25FV2NkWnVIV2dWZUpl?=
 =?utf-8?B?RlBpd3BTMG53TGorbU90TXZLL0FWbDZHNkN1RHh2aU11SGhhdStlVDNKa1lH?=
 =?utf-8?B?ZXJiK2FGdlBLV0RVazNnLzNYUEFLN1ZORkZTUWtEdUtmekQ2L09LL0hFSklh?=
 =?utf-8?B?WkloNC9MYWZDaS9yTWtEWDhXMUNVK1pHcDFHd1FVcUtWdzZITG1jWFREOVdq?=
 =?utf-8?B?WTNDMjFVNk9TUi9WL1JXVkpoWWxxcEIwOS9vYnJrR3Q3b2htRU1aN2ZJa3ht?=
 =?utf-8?B?c2h1ZG1JNk1jOFRkNDRCYlpIY3hwWjZhaldnWWZTZWtaSDZERjJ5K2FWZWMx?=
 =?utf-8?B?S3V1alVON0NScVE0MDU0OVhDRVd4Vmp2MGpBSjFjdmIyWmtldzhYa3YxK2Ix?=
 =?utf-8?B?a1BPaHFXaW84ZEdPbERVS0hlaGFPK1Yzd05uUTRlbWN1RngrcDhKeFFDOWg0?=
 =?utf-8?B?RElvNkZBbXRZV3o4VlluNC92dHhjVEEvUFpwKzA3azMxZDR5L2V3RTZwUU1K?=
 =?utf-8?B?V2JpUkNEZFRpOU9pYUprdnVITDVXK2pHaDllemdRdFF1V3hKZjZONk5mREdn?=
 =?utf-8?B?Qlk2MHdFOWtxWWpOME9rWGpxVFk4ZlBtUkJ3UDdnVDllZXdzTWVIZXh6dXpL?=
 =?utf-8?B?RG1WSXB2aDBhclVrTnA3dUNFdjc5V20rb2V1a1k3aUlXMk0zSFA5Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbf22fc-6e37-48de-5e58-08de539030bb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:13:09.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATX0/mMWeApJNED9BfUJ/Fs08/wOy2HojMbZScM34c3tK5Dg407AlzonccJpHcBoWLNfRKZqrcREjAsCAntxAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12155

Move struct dma_chan below struct dma_slave_config to prepare for adding
common dma_slave_config field.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/dmaengine.h | 120 +++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea9844ca6161208362ef18ef111d96..01d3e44e3cb426d9ad085eda1bc562ca7d266cb0 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -316,66 +316,6 @@ struct dma_router {
 	void (*route_free)(struct device *dev, void *route_data);
 };
 
-/**
- * struct dma_chan - devices supply DMA channels, clients use them
- * @device: ptr to the dma device who supplies this channel, always !%NULL
- * @slave: ptr to the device using this channel
- * @cookie: last cookie value returned to client
- * @completed_cookie: last completed cookie for this channel
- * @chan_id: channel ID for sysfs
- * @dev: class device for sysfs
- * @name: backlink name for sysfs
- * @dbg_client_name: slave name for debugfs in format:
- *	dev_name(requester's dev):channel name, for example: "2b00000.mcasp:tx"
- * @device_node: used to add this to the device chan list
- * @local: per-cpu pointer to a struct dma_chan_percpu
- * @client_count: how many clients are using this channel
- * @table_count: number of appearances in the mem-to-mem allocation table
- * @router: pointer to the DMA router structure
- * @route_data: channel specific data for the router
- * @private: private data for certain client-channel associations
- */
-struct dma_chan {
-	struct dma_device *device;
-	struct device *slave;
-	dma_cookie_t cookie;
-	dma_cookie_t completed_cookie;
-
-	/* sysfs */
-	int chan_id;
-	struct dma_chan_dev *dev;
-	const char *name;
-#ifdef CONFIG_DEBUG_FS
-	char *dbg_client_name;
-#endif
-
-	struct list_head device_node;
-	struct dma_chan_percpu __percpu *local;
-	int client_count;
-	int table_count;
-
-	/* DMA router */
-	struct dma_router *router;
-	void *route_data;
-
-	void *private;
-};
-
-/**
- * struct dma_chan_dev - relate sysfs device node to backing channel device
- * @chan: driver channel device
- * @device: sysfs device
- * @dev_id: parent dma_device dev_id
- * @chan_dma_dev: The channel is using custom/different dma-mapping
- * compared to the parent dma_device
- */
-struct dma_chan_dev {
-	struct dma_chan *chan;
-	struct device device;
-	int dev_id;
-	bool chan_dma_dev;
-};
-
 /**
  * enum dma_slave_buswidth - defines bus width of the DMA slave
  * device, source or target buses
@@ -459,6 +399,66 @@ struct dma_slave_config {
 	size_t peripheral_size;
 };
 
+/**
+ * struct dma_chan - devices supply DMA channels, clients use them
+ * @device: ptr to the dma device who supplies this channel, always !%NULL
+ * @slave: ptr to the device using this channel
+ * @cookie: last cookie value returned to client
+ * @completed_cookie: last completed cookie for this channel
+ * @chan_id: channel ID for sysfs
+ * @dev: class device for sysfs
+ * @name: backlink name for sysfs
+ * @dbg_client_name: slave name for debugfs in format:
+ *      dev_name(requester's dev):channel name, for example: "2b00000.mcasp:tx"
+ * @device_node: used to add this to the device chan list
+ * @local: per-cpu pointer to a struct dma_chan_percpu
+ * @client_count: how many clients are using this channel
+ * @table_count: number of appearances in the mem-to-mem allocation table
+ * @router: pointer to the DMA router structure
+ * @route_data: channel specific data for the router
+ * @private: private data for certain client-channel associations
+ */
+struct dma_chan {
+	struct dma_device *device;
+	struct device *slave;
+	dma_cookie_t cookie;
+	dma_cookie_t completed_cookie;
+
+	/* sysfs */
+	int chan_id;
+	struct dma_chan_dev *dev;
+	const char *name;
+#ifdef CONFIG_DEBUG_FS
+	char *dbg_client_name;
+#endif
+
+	struct list_head device_node;
+	struct dma_chan_percpu __percpu *local;
+	int client_count;
+	int table_count;
+
+	/* DMA router */
+	struct dma_router *router;
+	void *route_data;
+
+	void *private;
+};
+
+/**
+ * struct dma_chan_dev - relate sysfs device node to backing channel device
+ * @chan: driver channel device
+ * @device: sysfs device
+ * @dev_id: parent dma_device dev_id
+ * @chan_dma_dev: The channel is using custom/different dma-mapping
+ * compared to the parent dma_device
+ */
+struct dma_chan_dev {
+	struct dma_chan *chan;
+	struct device device;
+	int dev_id;
+	bool chan_dma_dev;
+};
+
 /**
  * enum dma_residue_granularity - Granularity of the reported transfer residue
  * @DMA_RESIDUE_GRANULARITY_DESCRIPTOR: Residue reporting is not support. The

-- 
2.34.1


