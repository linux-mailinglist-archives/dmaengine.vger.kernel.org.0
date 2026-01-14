Return-Path: <dmaengine+bounces-8249-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB6D207A4
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 18:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD3543064372
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2C2EA482;
	Wed, 14 Jan 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QqA0swzD"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD82E92BC;
	Wed, 14 Jan 2026 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410798; cv=fail; b=T5OXnpeaO5VM+S+cZdF85mZREmnnEDkbF9gME5//F+MGWuzwH3VyF6d3/OYRtXwMSsaTZG1tEr437hnk8hXH3C9hCRNnenw55bhPR5DGWhJKols4MX0kCi1MT3tic7KB6w+yQQVjkno2MyYWYdTalJ8+UHefakZ93eOnhIjyFG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410798; c=relaxed/simple;
	bh=hMAlaRVk8vnmgiGbmSehyWTthIwT6qg1YJ4toITBOQs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=f4nLdcPBwrk69LjlfAeIGz0qsubK6qtYDeLyXJ5DNyCQF1j6pc/i5k8gegqq1SuYSQbLRf7wjs8OWW5f/Wg81n0yf5dqsp+fPtFEfRwzHVJdcz8hFNOyqjKYKpU5UAOCDHSgBfQl1N+tHo3umFAl8vL5Ld1Gkmm9pMBjWEYVm4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QqA0swzD; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk28dyftuijOxyHXtCulFsp6mrNE6KcjCa6KumTkVyA/YymBJnvagK78eVA+2yS+jtQ+5GKDlm2idqjXnqg1KpHOxZlT2BuIxrO+qivDUSdr3Mi/G+ROZx3arqhZ+Vx/HtG5kImTeeITWYGlXsUUT1qAREtgFIfvZ+vvSko/RRRaQTaTnZ2g8UQxa3vgxXlram0Bpcwv7epnwJ93kfe6W11HtNCnvkGq3K3tY0+sqs0t3I6pJkfDB8SqRLDmCG1mkq46U2ViQJ23VkMjgTA9ixLT6n9JWO8qe5gr2XfvgSjSDwOmIFR8onI/ASdUIda9Rk8FT7aR/Q6y6PWsIALv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYNXI9Y37DMeYOKEPtwUglKZuwgSOMz2ZW7aYqqc4z8=;
 b=r8RYDsEm4XWFgOjmlYo5/1ytzvmMoLSGCineDShOtTjhyPjIpdCEk5NbXAUgxrfmBnkZi38xDmpUsmpS70zsVxC0OYELrFz9O2j84KY+3h3sIUVd9hvIfMLidv+hmArqts+70j3QSIWYgGtEiSb8Up1W7NTnsUcHejggj6B8CBMTCpgFkuuXmnOXc2ohHfb7qTTgiQK+phIeZmTf5QbM8PPyucYsRU3oMQbkNcZ1c4mVuKCdLlkof0OyX5oxI9JuICngKIlv1hRhAnZIazmAo2Wjwfh9rENFJsZQ1RuXbHnhAza0NVOzQFmZ/YQkrL49pmHBUpm0mnwGgRxGgA+ZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYNXI9Y37DMeYOKEPtwUglKZuwgSOMz2ZW7aYqqc4z8=;
 b=QqA0swzDSFUuS4M64RgyKKs1mUzPDc2CeiXRzcyBGHV4GekCfDEqm+PifZJkJFs8ULR644tnYromYSA/+6t3JW0Y324bXfByKCgmGfiQnZu7Uz1+ZWTL6ezXFz53Xskqhd809XufkCaBlR04doJgOtq949SndHiAzvMo1VMwtYSsSoe+bPHcE2HWMMd+xOiQUmPl+iXVO1alnOvHr0NyvQ/gaVSboRXAwgLUtJOMv/pMaAGmZ3rPU/PKcycQCNYrzKsxRKmUetCj2DETN+qYJWYnmXn3epy5i7EKBQVLlKEveovk8QKtWBmiT0gNG/RpAYjqIPtrrrAwX17fY5saPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12155.eurprd04.prod.outlook.com (2603:10a6:800:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:13:14 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 17:13:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 12:12:43 -0500
Subject: [PATCH 2/6] dmaengine: Add common slave configuration to dma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-dma_common_config-v1-2-64feb836ff04@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768410779; l=1043;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hMAlaRVk8vnmgiGbmSehyWTthIwT6qg1YJ4toITBOQs=;
 b=JpQWuVu72hEzv9a/8ZYAFhDyb3Hvn1fHQGSFjRkJmqKr2MnO3p7AXk+NoBYumCZlU0cjE8WwS
 rzOy/fbL6UPAzyoR4o6FLUbp236uh0ZHgXdjiaenPLiRv04QGrUjKpy
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
X-MS-Office365-Filtering-Correlation-Id: 6044dec8-0319-4352-1f44-08de53903365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHBCWCtDOXo1TnNVUHVsMUlQZ21hNjRnVHkvNER3K3BjekI0R01TblZxczU0?=
 =?utf-8?B?N1JjVTRWekRBVEV1SXdtRityQVc3ZlJvWTgwNi9JdDhkMGJsRGNldWN2eFRJ?=
 =?utf-8?B?MEtyZHZnWXByNktKSjhBWHBHdStKUWdtak5BMEIwQ2p1YXJkSWVleFlZM0Jy?=
 =?utf-8?B?a2VpSUY3NHhnZlY0bmFpMWZRNW1UM2VkOTl5eG00dm1TbnJ3Yk1NbWVHRzVQ?=
 =?utf-8?B?cWd2K29uZWY3MFFwWjl6REtNaSttcVprWE1aS3B3Sm83UEMxYXVJS3o4VjVP?=
 =?utf-8?B?TVhDcVQ2bU5Kd0QwenhHbFQwVjNOVFdHWldZZlNHWC95eWpMTm83akxvWFdJ?=
 =?utf-8?B?ZjJHeGNUckJZZ2tGb0pSdU5JbnFoVmlzTktmYTRnZ3dLdlZQNGhPVHVOT2xi?=
 =?utf-8?B?VjRpcHc0T2YxdS9HS3pzNDdDeGlYK2R3RVRrZzhMNzA4czRzSW9OUThoRGkw?=
 =?utf-8?B?Y3h2aHB4UU1wcmh6ajUwbEF2SkRFRVcwbUdOVTRZMHFpbFp2MW00eGNRZ1N6?=
 =?utf-8?B?RGRDd3VaL1I5NzhCTzMxRnIwNDhXdVVWVFVtY05zbklGQnR1V2ZQWEMzYTkw?=
 =?utf-8?B?dXFEUm5yZWdkd0YwVmJvN25BYjRjK2ZObDhoTEhJRDJINDVFam1RYUVZTnlJ?=
 =?utf-8?B?Nm5LWjdMNGJNUXpQWG4wRmVQYzVFOHBOSmZIdXExQ29CS0JJZ0hFaWUxZGNJ?=
 =?utf-8?B?Q0JVbGp3TnFHT2g4VlJhQ0o2Qy9BYlNMWFhzaDBCK2trTFBvcWFmVGpROWla?=
 =?utf-8?B?cWhpYUlMZjZIR1U2REVRdUhycDRGUVZTNS9EaTJWQlVraU9MQnBVMWpzTWFp?=
 =?utf-8?B?V0crWWR0TXNNR1M0d2RMWHArdXR6QjVNdXJFTVl0bFBmWHcwUVFCOEhNYWlk?=
 =?utf-8?B?YXYvSkQyaUMwU3hoQjhUOWRISE5rM2JPcDRzYkpYZVRKRk1JQUdOVGRhd2xa?=
 =?utf-8?B?NkNQUzBIb3BaaVBqTHRQbHV5a3Y0eEVOUVU2S25HbU5nK0NHRzhKMVdtdXcz?=
 =?utf-8?B?TmlOQUdJd1ByUlBRRUdyZWxaVUFjR3I0MXdkV2ZiUXVsSzZicm9NTUhNQ3Ar?=
 =?utf-8?B?MlBzSjhZOUF1MFFrTXFOMVd5M1EzRzdVTFZHUkkwcjV1dmQ3TXJTZCtPRFNG?=
 =?utf-8?B?MCtyUUp4L3BwT282YlhqSVdXRzNUalY1dDFiK1U5d055S3g5ZGRST0FOZDhl?=
 =?utf-8?B?WGdxNE1RWWFVN2VxV2g3dGNlQm5QbFJKZHpBSlM0YTV1bzh1WU5ZUUFiakhi?=
 =?utf-8?B?dmRYNHRHa1NMRkc0Wk1BVXo4OTRnckl4Q2hJejRUMzBvSmJhL2ZyM1pnZE1S?=
 =?utf-8?B?QzNsdVk3U1loMEFvVCtwL29rVy9rSjA0em04VmE4NFZnTS9QR3k3NW96TDhv?=
 =?utf-8?B?MGR4alQ2QXpBUmdCWGRxNlEyTzJzTDdzbnVadDNHWlg3L2R3ZGdZVXl4Y0hr?=
 =?utf-8?B?L3FUc0RsbmNHNXpUQms2NWxDWXI0UHhnZHlGY2tUb0xMcjdCQWFISys2RGMy?=
 =?utf-8?B?RnRZU2xyQ3pFWjJRUzEzWFpLZE03Z213SDRueEd2Q29DMGNJdFYvRXdWd09H?=
 =?utf-8?B?ZGdGUkVpWHdYSkg3SmdUTjZ6YmxZSnlEaHVEZVlLL3FoNXc3MW5TbWlLelBy?=
 =?utf-8?B?aXpYWFRDcFJ5Z3NEdHNBNWVqdzNYVWNtR1BQdnVIWU1jSnFtOTdCOEwxZkox?=
 =?utf-8?B?RHM3Z2k5MFFBT1JoVml0VGFWZ1lWWlZTa2ROSVoyTTVURGJoWkJIVGU0ckx0?=
 =?utf-8?B?US9OYkxvSWFoUnlYY1FtVjBSUGluUjk3ZFQvVU1OczR3QWxuMmtHT1dmQ2R1?=
 =?utf-8?B?a3RaZWNac2RyMzhXdGpBN3JiM0ZHVWkveVhiSk1HckRuUzE5bTdLWk1hZHlF?=
 =?utf-8?B?SXp3WUdFNTFSYmNZU0xudThHdXAzM0gwcWdDcTlCTm1MZEZMaGIwTitPUDR6?=
 =?utf-8?B?cVV5eWo5V0dQeTNFbEFaRExlK3FpaFJneG9adldwTDJ5QmdrRndqRXRQTHA0?=
 =?utf-8?B?NWs0N3VMNG1CUmFFS25qK0lONkpOc2xTVDZwSDhLRWg5RGdOdWpFNDBvSGZo?=
 =?utf-8?B?TnlwR2UzVTdITzRSRDgxZm85MytGdWRVY2c4RWpiaUYwQVlBWG1vWWJXZjJ2?=
 =?utf-8?B?b3RKWFFzcWIvTkdkREMvdUc3L1l4c3JuNnQ4OFQ0WUp5SnpZWkV3blMzYTFX?=
 =?utf-8?Q?PWvvYW2XU7qfE3nL9Vxy2kY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eld5YTdNZy80aTJ3MEFhcEFaTEQyNzFCV2toMk1iWWhkZVp5UXV6TFdOU3Ns?=
 =?utf-8?B?QW0zYVJmaFpuNjluUCtMeWVKTEtrQlRLZ2R4VlZIcXR0ZHhNV1k3Sy80aXBE?=
 =?utf-8?B?bXplUWR0WDFpZWVsbmJWbjNVNHpFOWhOTVhGYzNtT3VGalFISlptNUpsa0pw?=
 =?utf-8?B?R2twakt0dWJhZ1ZFelR2cTUxSTlQSElsQjhhMTBqREpvNDRpaGc2MUxKNllL?=
 =?utf-8?B?MVREeWtqNHpvY1k2ZUFESE9FR0t6WGFDY2VlQW95TDNxWTR0c0F0V2YxSFJU?=
 =?utf-8?B?OFVnVXk0T0U2U0tncGFSM3BIODc2UzlIejNveVpGMERhTGlwTlF4SFk4elE0?=
 =?utf-8?B?SnB0K09zVHN6WkpLTWFoV3BTL1JNbWtqVEdqUml5QzhNTEdaV1hIaGRuMmYx?=
 =?utf-8?B?ajZTaFJWN01UM1d0dUtDRnM3S2o1aSt2Nnp6cXhHTjVnZ2hoT3cxQWFweEo4?=
 =?utf-8?B?WDZjNU03NmJzNlBWdlE0RnZCeGNLVUtxcnVERHA0U2FPblNVNFFKWU9PdmdT?=
 =?utf-8?B?YnZwQUtRWHprSmJjaEpKN0QwZlBSaHpJWkJPSEpDMkZJRDMvZFJLeC9Jdk9v?=
 =?utf-8?B?NGMxV0FLbHg5TjFkYmJjNS9qRFlkcC9IR2w5b3BsU3E1RVZNZjh5VUFBTnEx?=
 =?utf-8?B?UCtRWU5WN0dpeks1Ukh2VGZCU2tqdU1PNVJ1N0xXQzFJRTh1QkxQL3U2VnRt?=
 =?utf-8?B?WmhoeDlhUXpsaUtQK2JlZTd5VWZpSFlFcUxBZXpLT3N6RHljVWNWeHJVdlNG?=
 =?utf-8?B?dnhQY05jYnVCN2lrTStwanFRWitiV1MrUGYyK3hDamVkWmt1aWV0N2lMYkZO?=
 =?utf-8?B?SEFmVVdGdkVkYmE1TkM3dlhXVmdUdTEzNnRqTkJ4YjJyU3BlRHhsVDRudnQx?=
 =?utf-8?B?cTJzeHB5SkJPcFBSdEh4V2NocHV5S2ZzWWYvTFJFNDJ1ZmFiZlVnRVpBMHNK?=
 =?utf-8?B?S0syVXgxZWVjU0NGOEJuMlpjazhDVEpBd0ZjV0VxanloV3pOU05vT2szYjhw?=
 =?utf-8?B?RFRqc0Rnamw4ZXV4blpiRVo3SEVJclczNld4RkNqeWtGWlpid1UyaG1zOWVi?=
 =?utf-8?B?dEY3aldVSkcvaCt4N1gybU91alpINzRjVUt1dXBtK0JvODhjT21VVnJZMFU4?=
 =?utf-8?B?Tys4ZXpGYlF3ZmlrRk5NV242dTllcW9ZZDBBYmtpUmdxSEtTN09ReFo3TFA2?=
 =?utf-8?B?OXh4VENuNDc2djQreVp5eWkzMDNJZzhHMHFFVWh5d1hrV25wMGRneDE0di82?=
 =?utf-8?B?NVFTV1I2VUY3Zk4wVksyNkUybmltRlNUdXFDNE5LaDZTaC9oandxYkRSTnZz?=
 =?utf-8?B?L1ZxQmZ4enZKQzR3YW5iRmZ3ZFl3bWlzQkRkMHRNQThMU2xNR3FrUzloeEZw?=
 =?utf-8?B?VUZTSlNsRCtGT21VeWdVd3ZSNzdvZzVFUGJFWHNod2Y1R28zZFQxNlE1aDBT?=
 =?utf-8?B?ZmhlWjdLVG9BYU1LM2lRSldYUHhZZzQzYXZ1TUhxV1pmV3pGczV0QlJRRDFO?=
 =?utf-8?B?anZPTHFSeFZpOVYySjQ2ZmYwQnhVK20ramxZamIzZTdnZWRkWnM1b1VZRnZP?=
 =?utf-8?B?bm9weVVTNFJVdEFyVnBjUmpGbDRJM2s2a2ZDZVR1dEdXanpVQjVEZGViUE1H?=
 =?utf-8?B?VHBDNnZ4OVdycU92SzUxa1BPZ3lDckw1dmx3T2Q0eDYwTDJlQzlXMU5MZHJG?=
 =?utf-8?B?MXc4end0THlLV01WQVRXdzJ6UGgrWmtOdDF3b0dGQUtiYkgzWEFQRzFpQlJL?=
 =?utf-8?B?bTZ5ekpNTGxuU1ZlUmsyb25nRnUzUWY2T2hCU2wvRzNWdjY2RlhJOVZFWE5q?=
 =?utf-8?B?TnpQWVBMS0d2SmtGVzlWSDlGRWowd3JRODlHK3pCaUxzMXp2N28ydVBYOXFI?=
 =?utf-8?B?UVN6T0tlaTNGVFNCVTEySTIzUUQ4Qmt3SUxNZ1dCa2FQV0F1RHZvLzNKanNa?=
 =?utf-8?B?aFF1RjN4NFEvUExOS1Q4U1kvNlk0TjdqcWMvZlVVdWh6TzZDUStDM0NWQjZH?=
 =?utf-8?B?NEI5Q0hBa1dQS0lScUVJSmJLMWdyaEhEaVJrWVlUcmN4VmVUc1lVbStOTjIy?=
 =?utf-8?B?UEdkcWRtdllQK081eWxyYVgzNFpmZUJQVElKUEFvRzkzQjNiRFZsNE9WZlVo?=
 =?utf-8?B?cG1WODYvdTgxZVBZSjAzZ3ljSW5YK1hodDdhd3FYUVRSU1AxUVIzYldjaDBD?=
 =?utf-8?B?WnZ1eEdOZjI3dlVxWHdld0tyMmJGcGY5OGxDcUt1Vk4rYy9NNURzenppWGJv?=
 =?utf-8?B?d3ZCS2pyd05EUGw3Tnh2cGVySldEM0lkOXBINWJNbjFQWk5Gc3NVOEhYVGM5?=
 =?utf-8?B?dTA2Z0VaRTFBN04yRis1K1EyU3ZramdHSFNCdHE4a0h1ZHNyMXI4Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6044dec8-0319-4352-1f44-08de53903365
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:13:14.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v44tH59OkM+EcQEh0EJCAui7aQV8r/7anyCATvLNojUbrmL4zJJMU4tq/5mKFPnBe2RYEp6KH5BtHo/WS1vww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12155

Add a common slave configuration 'config' to struct dma_chan to avoid
duplicating configuration data in each driver. Store the configuration when
dmaengine_slave_config() is called.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/dmaengine.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 01d3e44e3cb426d9ad085eda1bc562ca7d266cb0..362a43c3e36e232b5a65ff78ba0b692c0401e50c 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -432,6 +432,8 @@ struct dma_chan {
 	char *dbg_client_name;
 #endif
 
+	struct dma_slave_config config;
+
 	struct list_head device_node;
 	struct dma_chan_percpu __percpu *local;
 	int client_count;
@@ -962,6 +964,8 @@ struct dma_device {
 static inline int dmaengine_slave_config(struct dma_chan *chan,
 					  struct dma_slave_config *config)
 {
+	chan->config = *config;
+
 	if (chan->device->device_config)
 		return chan->device->device_config(chan, config);
 

-- 
2.34.1


