Return-Path: <dmaengine+bounces-2058-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB92F8C8C16
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646E22839DA
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC6813DDCA;
	Fri, 17 May 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O4J6KS8S"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EFFEEC5;
	Fri, 17 May 2024 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969427; cv=fail; b=OwJfUJNEKz/G9TaDvWF1/S+uyhhUSiXnLTbjnhOSn/NvBvsR1JnI/cK9roJOAjbMAp826Avkk3TOVXHtIy49U2gJYMBc2gUdiqgjUs+ZR7pc6gQWvjfxipUPZ+NMGBcTFEmuiZMekjFaVU3XbF3Iql3fCBqUs1iLvccWKPcEqm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969427; c=relaxed/simple;
	bh=pqXIC7WuTd9QbL6qS2aYOEz/tYGaAAcuvreq5hwo9mk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=B3nCVd62/jFDDHnf92Eo/8eL71pS6X7yu99MVqEj4BwEd0/zBs2A1DDVAmFWjZDWc5ddiyYs/KKDi/J9rXdDiqYBcWq8YDKUbqrNnppCe7rzZIhep37Zk/w497SqfSERMveukZEM/BlcNrX6AAvTb2auW4TBOxRFlKbN0emuP9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=O4J6KS8S; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFJN9noXEUPS1gzUeDlfBafInYTYS9AqmXDExmq5+ZTp2QFwBELQSdp1JcwlXczQ9JkubLDxQ3IS9pyU8z9MXk+rc6/7PKBM+b5Cx65RG7DHp1aBcnKmMgB5dBaX/40PsB8t25fIUqI5wxxrNlwmdzeW07uHFny/hPuHm4eWDea8B0KXliakK6HlqvdAfp8bpCie5JKvcxj8OcxhTrUsDP7+A42ZqCo6wvixjHrh7ZI7Lx1ET0y65lrVc/469UZYqD1ICDB6b4FP4hMuOLLqvOuyvXpkyfg1NjTZZhAYbRdwdQ5XqC87Mo9JTGpQLyB45NMOTX/W0E2ajDazp8fBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pFpJoOmviIvR8Ff1VbG4ofTFueWJ4ICEeSQnE2rOlw=;
 b=TH0VRLqaAxhhY+iodfe84Yq5bZoHpwnJ/gnFKj+oktBT22u0/GfHFU409xpzmSeokisxleg8VWoWD2VuYoeIQEw+1me63n4+7n+S/q3XKg/3V13luzucxl1qoztVIvV1tNXvHC71NB6l/nw728Vk9bbSCFIJ33TBsTvYBnsah0QIHMG+WUTuobDzi4nH9brFf8+1CxFZfhdObfi82qYQvojNPmWZ9wxyqQjzLwIlrQ7aeEgiTH5SukCyYQGDc+6pfC9tg1ryiEdT2XwIB+Ho+VGvPCHt8d6R+UrGD6HXR8WFJphjjiHZdvc+UOJJt0hSpImhIAhQv8zjovyxpoXdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pFpJoOmviIvR8Ff1VbG4ofTFueWJ4ICEeSQnE2rOlw=;
 b=O4J6KS8Svis/qtM1+HvskvUpwtTPlnqrq62qlBfn27JN6if3hrcay84zM6sBeJgqf9K3Wxw4gZbz+jiRBrT4IbM4aAPMSId1c1G4cIIuqe2GQJhNV2lGiJPHn7an9Wrk3OBWieGooCHIgpZwfAGQ8ICWZVuhmgnqAopSLBCgElU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 18:10:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 18:10:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/5] mtd: nand: gpmi-nand: add imx8qxp gpmi nand support
Date: Fri, 17 May 2024 14:09:47 -0400
Message-Id: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGudR2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0Mz3fSC3Mz4vMS8FN1UQ0Mjc6PkpJS0xFQloPqCotS0zAqwWdGxtbU
 AZYdK/1sAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715969417; l=1891;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pqXIC7WuTd9QbL6qS2aYOEz/tYGaAAcuvreq5hwo9mk=;
 b=JOnCvYouR8h2OGgkFxEwLpS6Y76bIXye/hfInC5LEQgXUULFdxEOvf6haUzATsqfFQ/I/CsDH
 D2+QcZd7FZtCIO51C71l194DY8vRsg6uOjcI8LKzTlx3Xkr1q0oEzMf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: f967b972-5b34-4264-42f8-08dc769c9e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|376005|7416005|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlhFMEZRK2FTazZ2ajhTNXVPVnZMMkFZaHBna01DSWNEYkdHVXhzd0NHYTNB?=
 =?utf-8?B?bmlOc2JRWjl5QVB1eXhQRDhwdUJrc05nQzJwWnRpWmJITnZaMFV1UDhRSjE0?=
 =?utf-8?B?a0tCQTczT253TDkzN1ZuQlVJZkZIQkxxeS9BeVdLenY1RnYzRS9vallWNDJl?=
 =?utf-8?B?SXV2MXk0VTlUWHBzT1ZESVRSYTN2cE81WDR0ZkdVR3pSN2lwZi9yYnNWdmxE?=
 =?utf-8?B?dFkyN0czTDZlNUUvM2hBcEJrcUZMcy9DQWQvb3VXbHhML0wrT0xNSWMzVnJk?=
 =?utf-8?B?V0kwa2hiV1luYTNHazN1Q3Ztd3BRZmVrd29pVDR3OG94ZWFSMUJMZExmMmtE?=
 =?utf-8?B?WmpweWo3QW9WVGNpK253TXAwNmdsM0ZoWjljeEdhc1FlSzYzWnY4WGxVK2xJ?=
 =?utf-8?B?Qkd3OFBKdEpvbU5CZEM5SnQzREYwTXlDaitnU250K09jclVWdkJtNUVNZlFE?=
 =?utf-8?B?QVkwL0xXK2NwWkZOOVlaUVpDdUszU3c2RUZINW12M2JXQVhPdmFFSDNzd1E5?=
 =?utf-8?B?dW5uUmxJNlVSWUNxR0duVFVrNWxPYmtSSmNFOVp2czYrNWxjdHR2by9Qb0dl?=
 =?utf-8?B?OGI2UHFudDd6UnpNOXFEQjFzcHI4U3VHTlRGUUpFRkdzamM3THJUMjQrNkZ0?=
 =?utf-8?B?YTlNVDRVUzB6ZEhGL3dsY2NybHBvNG5YZVhWQmNTL1gwakYwRnRYYUNYMDc0?=
 =?utf-8?B?UDZVR2Rya2wvRHZFaGorRmFKcmptdWd1ZXhLQ2JqUnlGNmcvbDFGVHpsZVZN?=
 =?utf-8?B?cUhkR2s5dTdkQlgrcmhiMVZ2YmxZbVNET1BaK2lnaXhHeTIreWpvUDdOdjY1?=
 =?utf-8?B?RXVYZitBcE5QRXUvK2NVSFdidmJNa2NVRDZsaU1CQTNjUHFsc0o2RVQ4dGht?=
 =?utf-8?B?MXVBT3Exd3FCcTBxQWNGbFA0eFBMd0h3TkdVVy9MN3VHOWlaWStwU3hOaWlW?=
 =?utf-8?B?U0t0TG5TY2RMMDRUS25aMUhaZnY0dnpoR0EycU5FbDNBdit2VUhvWlJtcGxF?=
 =?utf-8?B?bVlCUFBtSDVZbytUVWxiSStZc0twblZRcExOY2l6Wm1YREhHWG9pa0V2QWdV?=
 =?utf-8?B?VXRLVFlEbzNiL1RjRDZTSmdnd0N4K2h0bm85aGx2TVJuWkhnNlV3MVVIUnpv?=
 =?utf-8?B?QXZRdHhCQ0VwUFpiNXk2NG5WMURUVlhZcGJBUFVKeXJlamxxaldvMXcvRmZx?=
 =?utf-8?B?YThVSnF6dllkKzhTS2V5bVZ2cHpCNmEvQXhUNGVVY29RY0NOODhMYVExQ2JT?=
 =?utf-8?B?cEJpNkk4NWc1QzlmNEZaQ1d3YWVLbUpSL0NoQmk5RmYxZm11VWdIOXRkWnMx?=
 =?utf-8?B?bUppMkJDVTIvUXBlanhUWmppUWNNeUhXWjAycVEyWG5ENFZxSXdUQ09rZlFa?=
 =?utf-8?B?TXJ3cytTMlE1dG5ZRkQxcHdNS2Ywd0RaRVhPUjZ5ZUpGN24zVkw4bnFJaWlJ?=
 =?utf-8?B?NVBjbGdDTXBCNHdaZXNidVVEYzEyS3F3bElpRGpnM3lIWllCWER2RG10Sy9B?=
 =?utf-8?B?ei9PUWRwa3ZXRnAwemdvSmxzMHNVQU1KajRIc09XRnNrRXNTb3F6T1lGa1hF?=
 =?utf-8?B?Y1QwVFc3Ni9lWXZmSHBSd3ptck1vUnlTK2RTT3h0N2ordCsyYU4veHhBNVZt?=
 =?utf-8?B?eXJqa2RIZWlFSVMzTEdvZEhiSkxaK3MxYm9GZGNTU3E2KzY5L0J1KzlyeDl6?=
 =?utf-8?B?bFpxRGJIYk5zRFVXOTl4MHk3NjkxbWtjWUY4RWp6KzV0L0pOZWlOVjFlNDk5?=
 =?utf-8?B?MWRvVDRIb3dRU1hjNXQ0dnFsOEVRYlV5bnhSN3M2Q3ozcFJGZFp3KzhGQ3g2?=
 =?utf-8?Q?o6x+/emnLk/Vix4eFGfW9IQlPrMIKqKHiWFu4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(7416005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmU5YmIyVEI4QlBnWUthVkc4NllPdi80U0VuWWk2SVJWSTZRZzVWa2FyNXAv?=
 =?utf-8?B?ZXdrSTgzdXArUFdMVVh3M0htK09KYWRFRTE0MGFrYnpUQktScDU5YjAvWmg5?=
 =?utf-8?B?UEpUc09NakNuWjUvUmE1Qm5HZDZMRTdwZXpSYzh0MTMwSzFaWmdKNS8xL3dy?=
 =?utf-8?B?bHJ6MDNKNVAzRVZqTWNPMDIxa0ZKeERJc0Foa0wrQnhQS0lCQm9BNkpudGJ1?=
 =?utf-8?B?S0hvODhUdk04Z0E5ZXZIc2t2VDE3VVFyUnMwUVVjdTZqT0JnUlJuYTduc1E3?=
 =?utf-8?B?bjZvZ1NndHl0Yk1oUkdlWFlxOUhBVXczYVUreUlNc3poT3RFaDZmamlMQjVR?=
 =?utf-8?B?cDNiTHNIRzBDWDMwdklZRUM0enBmR2JHZWhBeDlxalpsbmxwcXc5MzZ6R2Zm?=
 =?utf-8?B?dkVyZkxwYmUvS1JoMWV6YmI0QkwyejVscjcvMEZmdVg0RkxuWnJFMXdkRW5G?=
 =?utf-8?B?OUNZb09kTHZwcTdzUUs2ME56WEtXVEpOTWRiM1ZNeUljeGI5MklHN3gxNFB6?=
 =?utf-8?B?S2tyR0lpTGNJNkFra01UWGd4UXkrb1hVMFhIWmxnMENmcU9QOEc1SmxMQ096?=
 =?utf-8?B?Rk00dlJaVTFWQUQ3b1d2dDNkRnAzYmFtcXVrQ0k3U2RMT2FJUTBxQ2hUVGpR?=
 =?utf-8?B?YjZmamxSUTJ5Ukd1cGxDK1RvZkZmVXZUQ3JxQjFXaTdUeFlUOGtPQ1A3SHhi?=
 =?utf-8?B?NUNxV1gvcXRNQUxrT3JXSkg0ZkRRN2RkU3JUYitZa1pZWWdvQWdqdTBvRVZJ?=
 =?utf-8?B?OWRqRXFWN2pwN3FobkxhVlBpaGg2VlRTTTdSRUpZdXVhaFUyU0I4VWtlc0xr?=
 =?utf-8?B?RlI0c2FtWnlrQ3hlcnd3ZFZ6ZFAzbXhvSkZtbmE3aXY2ekhWeFYrRzgvcE5q?=
 =?utf-8?B?dDg2VWQzZjI3YmxKVndhaTJBclNXYU12dTM0b2lzek9mODhBOWJZUy9zRzNP?=
 =?utf-8?B?QTlyK29MRHRMN05GRkFyMkNZWlhHWGh2QkpVdW9GNjBRdFVnWDI4dld1VTN4?=
 =?utf-8?B?N2pmNWlIdzFZQ0haNU9yZlUrWTZsenhEbkdzTkFldWNsemdieVRxcjExUTMr?=
 =?utf-8?B?K2o0MEZtVlgwbi9sSWFSWHRFUjVNekUvRHpSZHFmc2JkZlRjQnpKVE1BVU1z?=
 =?utf-8?B?OXNKZWJ4NmlteCtTVmsyYXFHdDlGU2tBQm9jazNRNjJJdzUzd2R4WngrVTFx?=
 =?utf-8?B?VzhzaHh5QkZvZXVKOXlzbFA1NzV4bmxXRWdLdWZpTVFWZ1FubTFBdG5BU3Bl?=
 =?utf-8?B?eWlGYTJJMW9ZYkxBZmhxbnVMaUJLZXMxa2toWjlIQmR6YVljcjFHZmdraGl3?=
 =?utf-8?B?anFtUkRTbGtoajg1RmNVcVJHVXFEY1NZWlNBNTN3NFpweUFiZFNBczh6Q21O?=
 =?utf-8?B?VWFNTVh3NFV6WHltZmFHQ2ZnSFdqbXZXRXhuTW5IaG1LRFBnMllsYlBUNUtj?=
 =?utf-8?B?T1RDdGR0S283empLVGlwR3FtVWgrdllONUtwbVJJQXNVZE5rdE93M04yQkdo?=
 =?utf-8?B?SjJscm1KQ1F4QnJFQnJWUk1aQkFEbnFMNEwyR1lLcE8xMHBQRlR6K3RpdUNK?=
 =?utf-8?B?YWszU0Nxbm5QZEY1UTNhUURWbS9KQlk0eCtUUkJqTFVCWTBreGdnUFVSSW8w?=
 =?utf-8?B?YnpEWHNYT3BERFkvakNaSUhXRmVVQXhrRm90ZjBYd1AyMlQwL3R5dWY1OXJy?=
 =?utf-8?B?NDlWNDdhbnBIVUVUN1B6ZGUySityVFlJdW9iOGZkSEtSTnZxOWhkTUJ1aG55?=
 =?utf-8?B?VXllbktHaVMzeTRPNStzQUMyTEJRTUhKOWpoRkxGTWVqZWlhV0pKc0ROMU40?=
 =?utf-8?B?ZGpLOEFZV09DQ0t3SHdjWlU2SkszWVdOZDdDVUpJci9pS0dxdVg1djZOenFU?=
 =?utf-8?B?MENwNFhMS25UbXhrT0FXaW8zVWF2dVpSQlc3TTVZWFppa0hmczNBVTlTMFVZ?=
 =?utf-8?B?cjAzMGN6L29pUVIreDc3aVZ3cXhEdTdOY013VGNkVGh4akhMZ3NMUlEzaXJ2?=
 =?utf-8?B?S3pFdDJGQW9paCtkV3hvRWRBTnp4WmdPN1lVdnRkaU5QekRDcWhJODFGdWNZ?=
 =?utf-8?B?NlJEQUw3djNtSHdKT3JFTlRGRmpiWFc5SllDbUNhWndPSGhCN3Fpek1FeFhD?=
 =?utf-8?Q?mLbiV+/QPtkfpMd8AOW+unD3y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f967b972-5b34-4264-42f8-08dc769c9e05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 18:10:21.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MosWaewTKbo4cl7tBhjIi6tGpn+EFuQ8Q1V3HpmpbXddiQdQzrGHk+LQrxuniMe/FmhpiWdpcRizrQxDb+eSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422

Update binding doc to support imx8qxp NAND.
Add new compatible string "fsl,imx8qxp-gpmi-nand".
Update dts for imx8qxp and imx8dxl

Run dt_binding_check: fsl,mxs-dma.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTEX    Documentation/devicetree/bindings/dma/fsl,mxs-dma.example.dts
  DTC_CHK Documentation/devicetree/bindings/dma/fsl,mxs-dma.example.dtb
Run dt_binding_check: gpmi-nand.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTEX    Documentation/devicetree/bindings/mtd/gpmi-nand.example.dts
  DTC_CHK Documentation/devicetree/bindings/mtd/gpmi-nand.example.dtb

No warning:

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  -j8 CHECK_DTBS=y freescale/imx8dxl-evk.dtb
  SYNC    include/config/auto.conf.cmd
  UPD     include/config/kernel.release
  DTC_CHK arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      dt-bindings: mtd: gpmi-nand: Add 'fsl,imx8qxp-gpmi-nand' compatible string
      dt-bindings: dma: fsl-mxs-dma: Add compatible string "fsl,imx8qxp-dma-apbh"
      arm64: dts: imx8-ss-conn: add gpmi nand node
      arm64: dts: imx8dxl-ss-conn: add gpmi nand

Han Xu (1):
      mtd: rawnand: gpmi: add iMX8QXP support.

 .../devicetree/bindings/dma/fsl,mxs-dma.yaml       | 15 +++++
 .../devicetree/bindings/mtd/gpmi-nand.yaml         | 22 +++++++
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    | 69 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 11 ++++
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         | 20 ++++++-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h         |  4 ++
 6 files changed, 138 insertions(+), 3 deletions(-)
---
base-commit: dbd9e2e056d8577375ae4b31ada94f8aa3769e8a
change-id: 20240516-gpmi_nand-e11272cbdfae

Best regards,
---
Frank Li <Frank.Li@nxp.com>


