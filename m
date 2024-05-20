Return-Path: <dmaengine+bounces-2103-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22C8CA083
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B5C28140C
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A158B137C41;
	Mon, 20 May 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p4g/Al1K"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4F13849C;
	Mon, 20 May 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221419; cv=fail; b=BxwJ60vfSVk83PIsPqKjA3NaBaJS0besz+NEm/nyO7Pxa6+1iX6IGeKfSk+LcjkQ7l9oq/yIMG7sdd5nPg7s+bxU/ALMK1J7v98pL2vKG7k1ffmwxZNfhrENMPwLcC4R8mntfqdZXnKwP3YsFmy79ghFiL6LB58E0K4VwdS52o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221419; c=relaxed/simple;
	bh=7ZsvV955QQilbaFQlIcmbK8f2wBN0bRJw8ofxtX143Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s3JgWWASaje3YaTmLOkYmsOzE5yPgdSQyY8uzYjFtyB+BRYj+Kj5reyUP6D5oy30DYRLDuc0YjapjIPaxXMoDS4rpLJR5gwIT/EWBV2/DGVzrTgEkP47sLlPcvyW1QRz3gqvVIVmN4B5RqvU69uC+arPpMykFe9NViY3znebzAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p4g/Al1K; arc=fail smtp.client-ip=40.107.13.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl9u1W6Li+Evq6iJE5LlAoEjoQ32MKnHNz74urZi/0WvlaqPseL9e55+olYHHr3YdGnpHU0LslniugQOMJyfGE5NCtPJjDuaVGbyVy6T10eHaTQiaIK2xfvf6gfQu2B91+J7F6ORPXL5If6LIDsXR/bW/sXPqdkpmH+yDnqN4uuzS+uxLCymc09ne1iVZ4NwAv+hf0LGyP8oqECGW4zC6UXMXA1SpqIXSqycmaizAove+hmKn/xJLMl/xWxa58VpYW6ObwgBAGF/t4kTdUPrZQQIl9tayeG+MnubOx3SOV7W0oob4r2tecuueQyLmJ0x9UddV7PfwESJPWKKoW1w0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80+G5rfR4UJ7cIeK7XS59usNAcPhX3aXtU2yQgCr3qc=;
 b=YtoxUFIjkfF9psKelgPwXr90SJ8Sr8s+LvgyZjNK7Q1E/VpMS8ABxo7xKG3vYj2Dm5zvz0ij5E4QDN3SzhSDo961Hvt0ytdXn5xajExK0aPYTQjOhKY7HYG7cpigbDZmCkV7QAhMjjRE1US7RMzgcVbZegMlQ1wIu1o1yg3M0vIJ0lj1YTP9QP9UhK9c4r7spPWarc5jKs5Cb7V1aGHmsQ5Kq2KSsyNa9+bGh8fKjKMx7kw7QWD7y233kagibYarsg3tT6ryyVdjAyZ/CoZwjOpVcqcVEYYA38MPdKogczqBiRNjlBVXSS4FXQLbI7Tl6YRWtfw3ZzwqrJKQO3u/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80+G5rfR4UJ7cIeK7XS59usNAcPhX3aXtU2yQgCr3qc=;
 b=p4g/Al1KwIf5MomW4gk81bxt3o0Jghe6nJIpZeYFnUT8aq4huvcqH27xR+urTJa0wP2D4SlSKQGUAtzAWZ/z2XCk+yku/Qwta23iutA//yeyzogcYAB5gz7jZlfyEsdp+D/2qB25OSLQ+d6QVfLt1xeBcp4yB+qV4Icya7KIHig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10164.eurprd04.prod.outlook.com (2603:10a6:800:243::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 16:10:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:10:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 May 2024 12:09:15 -0400
Subject: [PATCH v2 4/6] mtd: rawnand: gpmi: add iMX8QXP support.
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-gpmi_nand-v2-4-e3017e4c9da5@nxp.com>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
In-Reply-To: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716221390; l=2622;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=S99Zfd/uI7Z6lx85WydpCjMAFDAr+eaO6X5OcqTx/po=;
 b=a4d9H0EVSwd1S0UFegRDrmsC8rpx2XJEZSeJ+8Igr98vGKrQZdhATNT55o2IukuGz74i6FdQ5
 ZjkK1VE6jY8BKOSZf+/vpm1BrI+ZXOIQ01Ux5TgJd/YJfYfif0khtZ1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10164:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e608ea4-862b-49c4-b30b-08dc78e754de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|366007|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1JTc3VZUE5lT0Zab2VBZ2pEcVNqaTVMejRUQ0JUUG9oeGFBN2MyaElPZncw?=
 =?utf-8?B?amE0cjlYdFNpZ05tUTQzQm1abXJOZWZZMVA1cDVuakllOGFnVktTaE15bGgv?=
 =?utf-8?B?dDlZQ0c5N3VQb3Z6OUprY1JwT2pEcVJsTG5PcHNMeTFoR0kzb0hyMmprNEZV?=
 =?utf-8?B?bGdrWllCWi9YTm9PWi81VE9PVUVnWll6Q0tKMy9ja1BqRXpCOGtwV2lzd2RB?=
 =?utf-8?B?K0pvekovUnV5dEszdkJlK2U3K3ZkR0VOUko5ejdBd0dYbmQ1S25Ka3l4QkVC?=
 =?utf-8?B?c3N3b2dQdnowYTFyVUJqWmJYWDZIR3JoZU0yZ1JSYzlRRHJMR3VHVnZTMnIy?=
 =?utf-8?B?RzBXZjlmSENpeS92ajFPV05FR200YkNsbWRZOGFsYkVBMlJOWEhYYnNVVkRF?=
 =?utf-8?B?ajkzSEhNNFYxejBJL1c0by9uSkJxMFA1NUJ1eW5OUVQwZ09UYkZ5NEFOWkQ3?=
 =?utf-8?B?aHJyMkNlbkZtMko1NlEzWS9rdEVRTUMrRUZuK1JlOTUvck1lcUdpUFQ5Qkxk?=
 =?utf-8?B?dFlCL0M1MzNMdGV3d0hlKzZobmQ4bEUrS1pxSTZCSWF2ajhselFaVExLYW9Q?=
 =?utf-8?B?M0ErVUIwTjl5UjdrS3d0ZnJTWGRoK1NqUC82NUp2MlVZTzFPY0F5emQrS3Q2?=
 =?utf-8?B?RjMyVlZRUCt5RWhabXFSRXU2eGs5c0YwOWp3djlzQStCVDhCTVVTdDVzSmp1?=
 =?utf-8?B?eGMvbEppbWJraVRPa2tDTkVhRnRHZmVGL2hUa3YxZTFzdHFHV3ZxcUNFNjcr?=
 =?utf-8?B?ZnRick56Z0t0b0RCOEtzZy9WYW9xVHVzTFgyTktlanhFSzRaS3lMaU1HS2Fm?=
 =?utf-8?B?MnhRSnN3d2NkR0VPenRsTkRRcG5ybmNFVUxOUWgwWGYxZ3pjWWZHRmxGZUFT?=
 =?utf-8?B?N1R5SGdOOG5YUTdCYlBlZ1dLWDlaZWhwS1A3YzJGQnhpeEMyeVEyazRyczJM?=
 =?utf-8?B?bVNEZENzMmoxRS92d3BQQ3lObmhhQU5zSytEQ0YvZTFyc2tVNzdzRERER1hn?=
 =?utf-8?B?OXFIaGJ4MDZoMHZXR3A3OUlmbzc1eE5Bd0lCUmpEZHlPR25tc0xaeWxEbTJp?=
 =?utf-8?B?SGtSZkswVU53c0t2Z1VBa0FEMnBTT1JyUlFjQURoelA5QVJXR1NTNmtoVDEy?=
 =?utf-8?B?TW9VbzJ2TVkzV3U1L0ZuMW5kalhPb2dlM3diSTdzNkljcW01aGVvSUVhSkFy?=
 =?utf-8?B?QVg0YUVOaU0xditpeGdyK3lEbUpwYnpreStjMldWZ21sTHIyTXFlZ0NKYzg0?=
 =?utf-8?B?bGhabDk2anZLTXd4ZURRRzdKUlIvZmNtU1dWZjJWd0dmVlJXb1NJN051dWds?=
 =?utf-8?B?RmN0OE0zODFXVW1NMmY2dVY2MzJlbGpWMXZIRWxnNkFBeFR5U1A3REZkbFpR?=
 =?utf-8?B?a0pTUUltM3dvUk82cVBveUF0YmZWZkpBZm9tQmdVYUM4U0lzTFAyMWUvdGM0?=
 =?utf-8?B?UkhGQlBxbjlkWUF2THl5NDZacVBOMndOY2ZqYjQvSlExeUpDY0dJaTRiWDNn?=
 =?utf-8?B?MkRxNkVYaDQxNWpURlpoWGZKa0hvb1kvZEQ1L0x5ay90SFlxVFpTeUFVNy83?=
 =?utf-8?B?SUlnL2NiSkhuekoxTkMvYTFyTC80ajFEOVpqcUh5aTBoelV0YUtnRWMzWUpx?=
 =?utf-8?B?dG9jR0JYTWw4VnRrRThCbW01M3U1T2JCL1I1Zk4vOU8xSXZWQ1R0K0Fxanc5?=
 =?utf-8?B?a2V4eGpNckNnSzI5Zm9tYVdOVS9KNnl3SVhqK1dKWE5vTmRjRGxWWkZnQWRM?=
 =?utf-8?B?Nk9lbWd1NldMK05QYWpNelFrcUVxbWtxbUJIMklaMVR6R1BheDBYWHlYdFJw?=
 =?utf-8?Q?oFySJkDlMpRh/dWVpNVIHLhxAPF5LnTSJya1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(366007)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlJGNlM0amdYSEdGOWpKdHRnVHVhNkl6UUsvb0VKWFhuUWVtVXU1ZzNlOEFT?=
 =?utf-8?B?Zm9TSExvVW5Zc3g3a1FLWnlnYTZjOERaL2FMSGhzWHZnTi9rb1BPdytyTDAy?=
 =?utf-8?B?Vk9xNk1DTml3bWZPRmRkWmlaNksrK1JJSjU0cVFObXdCeUphUlZDL2I5dVYy?=
 =?utf-8?B?Wi9kN3VrTjV4YVBKZDkyaGt1Tmc0YjBlR2VUajM5aWVXL214NW40a0UwWjJu?=
 =?utf-8?B?bzE0SFJlZVhHZXlROXlqYnUvcWJ5UXBXWE1TZVRHdDRCNGZXK05sSU9BM1Ax?=
 =?utf-8?B?WElFd2d4RHEvbjNyc1VhZkVlYkxMWUpSaEkzaS9ZeGpZaWhabUFXeHFlejV5?=
 =?utf-8?B?N0oxbTRuSkJmOGQ1dWF2UkVPMm5HOFJJeW5YRFlDMUd4QkhtUEZmQ1lPVmw3?=
 =?utf-8?B?MWdQZE1NallkTGp3V1UxQ1M4NTZLU2xmOUFiZnlKZlBONytxWDg0eDB4VDVz?=
 =?utf-8?B?UlU3cGlxWE14clkzQkszYXhiT0J3aHhqbmoyc3lCK1UxRHc5MTYxaDVhZE4r?=
 =?utf-8?B?ZVB3K2o2aHFkeGJWMTNHWHAremYvWkswUlV5K0w1VnJabnNCZlFYK3l4bzJG?=
 =?utf-8?B?VmVrbGNuaGtjbTArQnFNZ1JkcEZmT2JMbTRWV2NubVQ0Rkd3ZmZOM2RGeFha?=
 =?utf-8?B?WEs3VjVKUmpiT0wzV1ovbVdRZVUzK2t3TkNjTXNST3h5SkFSM25RUUE4WDg0?=
 =?utf-8?B?WXhVTVRLcDMrbHBla2FVUXhrT29xYzcrNjJSQmNSb0VhNWJFTGZRNGI3WGZ3?=
 =?utf-8?B?U1BKYm1ZTjVNVlpmT3d1bnBxcVZVK1YzNjV5MFlpekZ0d3J2Wlp3QytKUm51?=
 =?utf-8?B?SklMMTdSZ0R5NFRXYTVNWU9Fbm9ZSHFObXdab2JzZElZYjA1UVc2c2prVUdE?=
 =?utf-8?B?TXRna2ZHNmZyUEM2Szd4R09iV2lyUjhXY21tZXgwbXhkd0hROHg5WmRHbHBK?=
 =?utf-8?B?RUkwN2tUSy9HNEpuSDNiekhadUZnVys5M2NnaVRySEFiRnFOMTJtbmJFWVJN?=
 =?utf-8?B?ZGJrSGhrTithYTZCdmo2ZTJLMjB5SjI2RFdPc1JiZEdveG9ad2pHQ3JyYWFv?=
 =?utf-8?B?WDdWVDRmRGl6MmdwUWlIL0NHNkgwRHdzeGQ4dDZRMUVPL3I3ajd6bzJCNzB5?=
 =?utf-8?B?YlAzYjlGcnlYbGc3UXJubWtCL2dNcHkyU0hJNlJkQndpd1ppNVJQYWJJTWdl?=
 =?utf-8?B?bEYxTHc2OTJvQVd5dmY5VFM4UjRBUU05SlB4RmhEOWthdkdCWVJmQTlvQnFP?=
 =?utf-8?B?cE1SclBwclBObS9pQ1h4akhNd1N6aVNHZi9COURpd3NHWTROOERVaGFuNHFr?=
 =?utf-8?B?ZUxkQkFQcEhzTGhsM3h2TENkNUc3L3czSVRLN0NCeGZEQzdsWmVsSnZSM2RZ?=
 =?utf-8?B?QzJ4THF1MlVhTUFrNktOODNzY01Ga01LWmtZMy8yRk1vVDZzRk9JQnBuRVpN?=
 =?utf-8?B?RFN2VTBVbzZqZ1d5aTh5dzJ1eUE1MVZGUThvNlZNdmYzd1VWd2JTNUE3dTBB?=
 =?utf-8?B?QnN0V21kaUloU09UdUxQdVhld1N1MjM0N0Z0K3lKNVBnV2p6VDZELzBhcWxB?=
 =?utf-8?B?YmR4cnRZeGxmc3R6SXJFUDdCZnFpczRIWTVXTXFTQWpFTURISnhyempOMXpk?=
 =?utf-8?B?MGx6SEZna29wVUp1dGNCeG1ZdG9VanhkdlRBNGI2OVQ1RjFnWklYQjZLRUlz?=
 =?utf-8?B?OCtuVUY1QVFpeG82RTJEU2lhYUUwclFkVmdJVHQvQk5JbmxreFBGeHVGUDN3?=
 =?utf-8?B?YWVQWU1jOVl6NXdnYytFSVF1SkZ1bEZFTG0xTVhlaVg3T0YzUzkxL094U25Z?=
 =?utf-8?B?SUVuaE5ReEZ1dE1UYVExNjBKVTIvSmxGUGZqSTRaNkJIeGwwSkJUR1grN3lO?=
 =?utf-8?B?NnJBOHdSc0x1ZlJOcUI5Q1h1TUZuMjMrbUZoZDBmNThoZW1oV1dyQ1RVYmk5?=
 =?utf-8?B?OFNLYUNvV1ZjcUY4REVPWXhITXpYWUY4bXFJWkNrbitRQnkzKy9FSHhsY0NQ?=
 =?utf-8?B?MGJOaloxS0tkbWh5V040bnJzb0ZIVU83RjFGMUozdUFCY2V6ZnlSOWFOanY5?=
 =?utf-8?B?RkpRNWVrNnVmQ2w5cDdCV2RLcVdtdFJyamhFWEpOMlVXOWdqbDFyeVhNajhW?=
 =?utf-8?Q?FtRs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e608ea4-862b-49c4-b30b-08dc78e754de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:10:13.7130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iANiWmnoLOMMdmQ5q+wMjH83guSkxsnuayP8Q3HiJzm0ADGMxrvHNkoi5FhHt1FMPsr61TzhVU4yHWxPM03xdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10164

From: Han Xu <han.xu@nxp.com>

Add "fsl,imx8qxp-gpmi-nand" compatible string. iMX8QXP gpmi nand is similar
to iMX7D. But it is using 4 clocks: "gpmi_io", "gpmi_apb", "gpmi_bch" and
"gpmi_bch_apb".

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 14 ++++++++++++++
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h |  5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index fbb1f243ef129..e1b515304e3cd 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1182,6 +1182,19 @@ static const struct gpmi_devdata gpmi_devdata_imx7d = {
 	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx7d),
 };
 
+static const char *gpmi_clks_for_mx8qxp[GPMI_CLK_MAX] = {
+	"gpmi_io", "gpmi_apb", "gpmi_bch", "gpmi_bch_apb",
+};
+
+static const struct gpmi_devdata gpmi_devdata_imx8qxp = {
+	.type = IS_MX8QXP,
+	.bch_max_ecc_strength = 62,
+	.max_chain_delay = 12000,
+	.support_edo_timing = true,
+	.clks = gpmi_clks_for_mx8qxp,
+	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx8qxp),
+};
+
 static int acquire_register_block(struct gpmi_nand_data *this,
 				  const char *res_name)
 {
@@ -2725,6 +2738,7 @@ static const struct of_device_id gpmi_nand_id_table[] = {
 	{ .compatible = "fsl,imx6q-gpmi-nand", .data = &gpmi_devdata_imx6q, },
 	{ .compatible = "fsl,imx6sx-gpmi-nand", .data = &gpmi_devdata_imx6sx, },
 	{ .compatible = "fsl,imx7d-gpmi-nand", .data = &gpmi_devdata_imx7d,},
+	{ .compatible = "fsl,imx8qxp-gpmi-nand", .data = &gpmi_devdata_imx8qxp, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, gpmi_nand_id_table);
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
index c8a662a497b60..3e9bc985e44a3 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
@@ -78,6 +78,7 @@ enum gpmi_type {
 	IS_MX6Q,
 	IS_MX6SX,
 	IS_MX7D,
+	IS_MX8QXP,
 };
 
 struct gpmi_devdata {
@@ -173,8 +174,10 @@ struct gpmi_nand_data {
 #define GPMI_IS_MX6Q(x)		((x)->devdata->type == IS_MX6Q)
 #define GPMI_IS_MX6SX(x)	((x)->devdata->type == IS_MX6SX)
 #define GPMI_IS_MX7D(x)		((x)->devdata->type == IS_MX7D)
+#define GPMI_IS_MX8QXP(x)	((x)->devdata->type == IS_MX8QXP)
 
 #define GPMI_IS_MX6(x)		(GPMI_IS_MX6Q(x) || GPMI_IS_MX6SX(x) || \
-				 GPMI_IS_MX7D(x))
+				 GPMI_IS_MX7D(x) || GPMI_IS_MX8QXP(x))
+
 #define GPMI_IS_MXS(x)		(GPMI_IS_MX23(x) || GPMI_IS_MX28(x))
 #endif

-- 
2.34.1


