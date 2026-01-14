Return-Path: <dmaengine+bounces-8265-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4253D219DE
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5556430C664A
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C9D3B8BA2;
	Wed, 14 Jan 2026 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OpA7MExA"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57C3B530C;
	Wed, 14 Jan 2026 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430100; cv=fail; b=cHO7dpHp8vn+QFIqo3azVxSMwpclm+1ObUtewONFDKl/y+MB6Ui4Ur1kk/38y+za686w9QAlqfvQu95oOL2DcQ/Qb9Ax3K6XDSpIm6AM+TsrPp1i3dS/aCNcGdyRDfv1HidzWTRLX9ArJb/C6JLOSxAoRKoqaN4VQuV+E39pUIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430100; c=relaxed/simple;
	bh=j1Zvke9y+UupBv90BWzFcLi5vWTea+WzvafxMR8YPq0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KgAbF1XXw1SptsKJhI+UWfxsKGgiQtaMKvoN/E0BQ5q18iLHtc+BpiQ83CgEDztRJ8qcsnvBbzkw7nsSZrSe9K9B+KF7iSxQ9lzUkCHgiXSnvX5Q89BzZxUT1p4Ka7LYV3B2fAn12/Bh0BLRHZ+iStr7JndrW1Ig7oAUBTD01Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OpA7MExA; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTeAoK/xPBYFBp/iAA9erKFdqacwZez/LWMC7VEU4ZZlHsuwXeBXc1KwlOOUipMBhd54tdxkQOtUDoQQXBjsH857S4GX3INDRZE3rCQAqTBkWP5LZfDtlGn6MrWfuv3UK0Ff0VdwUahmY2PKDli6flPcyFqYx95PAfecg7XzmzTtN3ro9LyZwi0WuPO7bvLb0DCI8K+rp9RYZJQf6Yysu9u8PYnJgQi4tWSwwrRs48I0UEgun+qWV9DqIQgTN9J+1wL3xYyq8Iheq0EiVog4AD+QpH2VXtbr0G3B9xjcAHaBGK+mIAjVWauo0QIgG+T6kydl4tJRAS5p1C6LUPmhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKiWqs5tjqYiOIreL+q7Fckc9oEcq3JO75rjb7kYBds=;
 b=M/myRhDt32+DktYwUpG/miaA0PkyUXE0NC3TD+xudyXnSMVFKj8/StLPCsProPi4yB3A18alXrpRYk4/TcGAX1NT8zj+7Z0ufev4WZjk9PtELmgEFPYXa3aK87eZHNRje4dMIdO6EjAe+sVL3QpcPraXd2mPaVn7zQq/bN97pz8CqqPxNJK3LMsDabcTRLTJQAcujhIgpTTnq0618ejlo6CVBw1QRgadx+1+fSXrj6zyF7SjenIdykINQ4p3+NJukrF+/rk3vln6Cf6JprwcINVGSldnFQOyzzhL2C/MfSZ8olJUR+z1gFiba4KBD8dirLGx9rMBXyFA3AORtw734Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKiWqs5tjqYiOIreL+q7Fckc9oEcq3JO75rjb7kYBds=;
 b=OpA7MExA2LUXSX0Qi2yN/MkohuRprHUN9KA/kxjNXOo3S9Lqa80b1DBvOiGtV01/NafFON8Kp0Wd/g96SncLC5Vljjzid7DhrokGC9ncN8l8DhfxC2yyMWJvgu3UYa2g8qe7Fevhy/GaldeisCieqlY8/R7kBR5jkbltuQhjl/IimHNOJWaJYYgeziszxe2eXXqcNhr3OJcaW25w2nRhQPhgj/uGyvFEdXnGlHhj8g9Nzx0XEnFfsRvaxKDbwVvR3mif7SffvvTd3+dhwaJPBmKCaAXfiNjyFn/bThtO3lI8GNszSt+TuPPt1veX7mQXRkLJXw8y9cz2kHAkwhKkVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:34:22 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:34:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:23 -0500
Subject: [PATCH 11/13] dmaengine: imx-sdma: Use managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-11-9b2a9eaa4226@nxp.com>
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=2538;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=j1Zvke9y+UupBv90BWzFcLi5vWTea+WzvafxMR8YPq0=;
 b=h5WmHNP5wJTFicon5V8z3WcbLRUwyHfBE7jBre/rRYCxp8ns4LMk/4G38aKavSdIoTt3VmUIw
 jV2SefjXuwABBW9LdEHfbwgEA7WGN/1Z/lQ0dVtOe4qtlp6g9L/9hxs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::19) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: a176ed17-f8f9-4b14-124a-08de53bd1075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUhQMW5OZmxxUVE1dm9wY1lMeVpFdDNMcUhpT0JLYWZ6ek4vdEVjZEkrZ2Jo?=
 =?utf-8?B?M3ZmMEh1TFM1N3hJU1MrL2VxNWVpNUVCVCt4MG5kdzE1SGdzMmFRMW91NEl2?=
 =?utf-8?B?S0tRVG8rQ25lNlMvak91Ky9XZWQ3MlVTY1NaRm9vK3A2cWtPSGNDV1IxL1Uz?=
 =?utf-8?B?bFlUa0d3ekVqbnBiN2M0V0hiYWxsckhmdHppRHEwZ3luMTdENCtoSFNwRXlo?=
 =?utf-8?B?MjVvRVd1YU1KdWpxQTlWNEI5d1h2dWY5NFdmK2F0TGhaSzlXZWdNcnVDdnNl?=
 =?utf-8?B?R0tsa1d1S3JYUnh2UklxNXM5ZVVkclZOWExjMk91SUtsTk0vUVlGTWxKaHpY?=
 =?utf-8?B?Q2N2NzEwQi9Ha0J3S2ZhbXF6aDFTR3l3U2ZJckZoRUlSVFNTSmRSNVRWUUhr?=
 =?utf-8?B?NzVGcHQyTDF6NkpmOW01YjlyL3pSQ0xBbjV1MzdKM2wvdlY4cDNIMWFvZ3lN?=
 =?utf-8?B?c25KNi9sUG4yNE1VN1hqZzRhL3VvRGg4R0VBOC8wREU1Zm9zV2pJL3V4aE5I?=
 =?utf-8?B?WVZ3RVdyK0VVVnZRVzNKam5ZM3ZmMnpCQ1FidkFxaHYvSlhPZXJ5c3ZiY2Ru?=
 =?utf-8?B?Ry9sVDViS1Z1Z09iNGRZMVpBZGp1YWV1MEd3ZGI1bzRNTnlBYUlFVG1tUVpj?=
 =?utf-8?B?NjQ3cmo4dUhGYUo4UDREM014R1VzbTJyeW14Y1hJTzljV1BiOUhNeXRJSnJi?=
 =?utf-8?B?d3FXV2g0dUh2TWVHYnRWU0U1VTlmV3d3b0pEaHZJSlptMTZvWmZYRDJhUTZC?=
 =?utf-8?B?SzFRQUZIanptdFp5RzE5bVY1YmVjVXI4MHFNQnowaWJyc3A4YVVRM0h2aHdx?=
 =?utf-8?B?WnZVcUJLYTZiNTA1QkU5cm95ck9FRUlqeStoYUZLVWpnODlqQ2RBSkZTRWVS?=
 =?utf-8?B?dTF5RTVZMGc5OVNaVkxwMjhwOW50NFBTKzF0OHNRZ2JRR1Y4anlXL1BSQkI0?=
 =?utf-8?B?dTBvMklZQjczaXVYY1ZNWEtaYkhjUVMrbkR3c0dwL25QZXNOOWhpbmhKTUhN?=
 =?utf-8?B?SG5rQ1d2MmxKVzhZYnl6eGE5LzRRZiswMWJ1dEk4RWFxcXU5RExydzlxQ0p1?=
 =?utf-8?B?b1BDcnl2eWgvSUo2Z1dpekxzVHBBM25WSmV6R3JqTG5iZkdJdWdXTUlwc1No?=
 =?utf-8?B?SGZIT0h5R0h4Wmp6MHRrczJRWkluQ0g4M1dvMmRDWklBcGdZWWNLeWpXNmRm?=
 =?utf-8?B?Z2FTUUVqYXhtYVlzQUVwdUFYb3dWZjl5dGFZRWE4Vk82ZXRVQkRlRi9JSC9K?=
 =?utf-8?B?S09hdmpyN1F2YmtCUjJxd3Q0V0lNNnZnQXM4cGJveHB6RHVtZW4zR3hCUXV0?=
 =?utf-8?B?aWg2WjBJUGtRQWpyTWIyczZlMzA0UVU2TGh3aVZ5SDNQZ0ZuTWpWaTBuY0Nt?=
 =?utf-8?B?OUUrM1pPRHNaWGkyYUZGME15dGE0OHhjNVNvNVNzZVQzZ1pSQmpKSGtJa1hG?=
 =?utf-8?B?anljc3hsaUtnR0d3SzlLT1MzTkJlT2RGa01uMVVUb3hITEIrZU9IZFRTdjU3?=
 =?utf-8?B?VGxOU2ZCaEExRXRLRk1iY1ZqYllUUkd4UFJLWkRxTXJCaUt3YXJ4blJTNkJQ?=
 =?utf-8?B?ditRS2RvZjc3QVhneGV5alpoZ2NHbmxHK0N1bmsrUmhQaTB2akxZbXhIc2wv?=
 =?utf-8?B?a0tHYU5ud1ZiTyszWlkvamVndnRjelJ1R2V2bHgyZ2Rqb005SWR5T1R6VlZy?=
 =?utf-8?B?aWxFR0hhOExtSUhla0xJYTJXOTVubmk1ZmpiU0xRTlk1QkVaWXIwaEJGTStT?=
 =?utf-8?B?NzBDb09SSmx3ZnNRYm41MFIwRSt3VTBzeXhHallVTVg4WW14UWlqUFRNc2hF?=
 =?utf-8?B?MXVONHJLaTNTNUxhY3FKNFd1U0pUOHI4L3BVUmJpQUUrRUZvaVZ3V2ovRWdz?=
 =?utf-8?B?ekxHRzhuWEJJQXRGaURuQUhOellFOUZ3cnJHNUxhN2pqTkcxZ3BMcGhMN1c5?=
 =?utf-8?B?TEY3U2hqazZWQ3pxNHhBYkxod2MxbDNBYnpQcmkveGVaUHIxc0RYUTFkOUVI?=
 =?utf-8?B?MXNTd1BIU040SkxPL0tMMk04cHBUTVlLZ04xYW5JdFdOcE92eHd2S1daNFpV?=
 =?utf-8?B?OTRHMjNXSEVXalFlbElHUm1tK3hkOU9hRWVHZlZSeHJsU1F0VThxMzd4OTRp?=
 =?utf-8?B?eE9mMGJuVTNsMVNPQ1Q1V1R2QlM3QjByOWx5OVZUT3FGOC9kV3M3eUdNdFFr?=
 =?utf-8?Q?bbE0dzAfp/w5VDuYqBEdq8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0Zzb1o4enhMaHIrR1NMS1A3ZmpZSDVPaGN6UURSRVhpeEY4V0oySkpRNTJB?=
 =?utf-8?B?UlZjQTgxNkF3WGZwVytrQ3liT2hPYjBidG1YK05JbUVZa25Ccm1aY0hNSitO?=
 =?utf-8?B?Z3BvZlg0UExJNStGUDFhdWVQczRmY25sUWpOcDJZRzd6SEQ2S3l2bnl3dk5S?=
 =?utf-8?B?ZW5VamdtaWRWb0d0VVZieDBKTXR3anBmZjNCMURuQ2piRUQzT2QxN09JMGps?=
 =?utf-8?B?djYwb1dMNVUzdTgxNEhrc291djcycHFIcENaZXh6a0NNc1dDWGlpQXpIUGVN?=
 =?utf-8?B?cHRVNyt5S2Y2RzlFMXFKNHhhMVI1VTRLdHBoMlBJbERIVlBBdWJBdy9NTVZ5?=
 =?utf-8?B?THYra3hoM3l5WjBqQWlQenJ5WkRFRnNZdzQ2L00wY2RIODVDM1BqbzR5QmJT?=
 =?utf-8?B?VkNaS3hSdkZ3UGVNNFpSZU9xZU5OZEdRbTNDZ1pZeHNyWFVUU0VaUmovQVVN?=
 =?utf-8?B?d3crSGhjMWlZOXM4NWFkU3F2LzlNZnNXcUd3TS9pbmtkNC82WkxZSHJld3RJ?=
 =?utf-8?B?aHpqc3Z2ZVpaZHhEenN0OEZFSWJBZVVSL1BPVzllUkNBcHhTS1E4VDc0UDZj?=
 =?utf-8?B?RUVHTFhRSlZ4T3pWckRkRE1FbnM0VkZ0dm83Z21CMnJ4NTFwdVdZSVYzZWQz?=
 =?utf-8?B?cGRjaXkzWkZtbjdXNnVVNjFSWGpzTjdzQUZSWEs0YnhLc2tQYmM3VVd2Nlg1?=
 =?utf-8?B?SVhCUks5STFrZjRUeHlLR3ZIaHRhWEYzaDVoelhQck9NMFRzM04yKzJTS2JB?=
 =?utf-8?B?Uno4UW5sZWhHQUQ4bnBVUHErTWc5eGMzazZiUHgzZmdkY3RzRXBlMFJ0MTRM?=
 =?utf-8?B?WWtuR3U4WWhwSnFZZE9pT09JdU5OTWYzTFdPU3VJTlR1N1JSaURCazFIazhm?=
 =?utf-8?B?YXFnVytzbXdQVkxWNnBZdGdtSG4yMnJmNTFRWGg1ZmFNR3B2cGtmTXQrOW9P?=
 =?utf-8?B?NTMrVzNOT1BlUjM5TFVLODJDQUcvOGdDeldqRE1aR2VJNlpYMjlyaW9zelNy?=
 =?utf-8?B?aWpyZER0dU9ETGdJWU1Od3NQSFFHUEoxYXg4Tm1SYVdSYXliMzRKVDNPSjZO?=
 =?utf-8?B?aGhPa0F5NSs1WU8rU2twcHM2M2JPZ3dQbVBMUzRmZ0VQR1FsRHV5cHhnbXkx?=
 =?utf-8?B?cjZPUHkzdy8vODhUaVBjVjZSbnkzcXF3QWFiTzVYK0d4YkJEYnVSSmtoYW1K?=
 =?utf-8?B?M3VDWVRBUGFTT3RvVUNQZ3JRaThxWWJacEwyY3AzTDFFUkhSaXVPNTNNWjhn?=
 =?utf-8?B?WDVLVEpsS0Z0N2F3bFNEbXdOT3VnNE8rUnU4S1pxT2NYNDV5RFI3NUVtUDBo?=
 =?utf-8?B?SzRFcDQwQjV4TnJVb01aRmlFRTZRMlBScXZjME9ybjhNbTBLVko0Q0JtTHRL?=
 =?utf-8?B?QW1VdTBkbEx4THhETStEUGphZ1FzNXBaTXg1UjU3QXVpT1pka3Rqb2NlalN1?=
 =?utf-8?B?cjVZcnhiamk5RkV3dmN4NlBWbncwZ3E3dVhXTGFLdGdNUHhjQjF5RmxSdi9K?=
 =?utf-8?B?eUlFSE5Sdkl3SXVYaTNPa3VveDJwZVBXTGpFbUl1bDZ3WXBIQWlKVXczcWpa?=
 =?utf-8?B?TnpWT0pxZjU4SkdtcG1teFJJMS8vRU93OWw0akFoVnNXWStBN1NYMExwQkww?=
 =?utf-8?B?Wisyd0dzSERiZ3FVU3hSVEJSZnk2dkp4RUNuSDZKekhrei9ncjNUVzJuVWFC?=
 =?utf-8?B?UkJLbkZyak9ITVZ6OGJNVnN5aHRqd3JGYWFZWjVIczVrRVF6SnArMnAveHVj?=
 =?utf-8?B?bE82ZFQwUjFObmtQbzVXQ1VRek5PT2U5ZjVYcTA0bEFJRWdZd2VWU3g1dkl4?=
 =?utf-8?B?dG0yaTMwcWMyR1ZPeDFsZ2hrWXVTaVpYd29IN0VXeVNXTlEwcURLeFFtMDd3?=
 =?utf-8?B?aHJRVGZaSUtNci9jZUJsaHFWd1c0RVJZVzRIUjBZd2loRFF6MmFNa0tyaVBa?=
 =?utf-8?B?RHN5YytFSEt0UXdaOW9hTHFRN1B5WGhtL2dITW5CT01aTkk0bURKeHdZblFQ?=
 =?utf-8?B?RHcxK1JIY2FjNUw3Z25PNjlBaEo2WWQ4NjNONEMrOXB0TXFHaXYwZTErck5m?=
 =?utf-8?B?ZlhrTVVwNVJWM2g2ekZ4RzNQM0xrb04xMTc1YVJTU1FyZGt5TXlEZGRpSlY2?=
 =?utf-8?B?WisrY0VKWEZTb0xFWEFlTWpFV01WZW11ZW5lSEY4Vm10bHVjaE50WkJuMnFD?=
 =?utf-8?B?SDA2WDYxNVExbExiNno5cm83OFFXMUNKMkhMdDlsREVaMU5lZytRS0kxbDE1?=
 =?utf-8?B?T2R4YzNqRjJtQUw5RFgxYUJVQnVPaklodGpEY2U3amZiSGRRQko1YWZPeFBp?=
 =?utf-8?B?cFFiSXZFbXNPWU9rTW9QZWFDN0xYM3QwYTVBMTRmd1djMm5iMUZQZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a176ed17-f8f9-4b14-124a-08de53bd1075
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:34:22.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcTY6PwTG5bfWy9vhBlUUDETAq2e0/c+ydOQupNO/3hm1ehlpODwPXI4czNbcTj8kQRh9ebrfwkrbTKyLU3Z+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Use managed API devm_kzalloc(), dmaenginem_async_device_register() and
devm_of_dma_controller_register() to simple code.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f7518f567ecd707575e73803a94c2c1d4762f3f4..95458ea188e3b0fc4e4f861df567c1c7524a3029 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2280,7 +2280,9 @@ static int sdma_probe(struct platform_device *pdev)
 
 	sdma->irq = irq;
 
-	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
+	sdma->script_addrs = devm_kzalloc(&pdev->dev,
+					  sizeof(*sdma->script_addrs),
+					  GFP_KERNEL);
 	if (!sdma->script_addrs)
 		return -ENOMEM;
 
@@ -2323,11 +2325,11 @@ static int sdma_probe(struct platform_device *pdev)
 
 	ret = sdma_init(sdma);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	ret = sdma_event_remap(sdma);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	if (sdma->drvdata->script_addrs)
 		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
@@ -2353,17 +2355,18 @@ static int sdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sdma);
 
-	ret = dma_async_device_register(&sdma->dma_device);
+	ret = dmaenginem_async_device_register(&sdma->dma_device);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register\n");
-		goto err_init;
+		return ret;
 	}
 
 	if (np) {
-		ret = of_dma_controller_register(np, sdma_xlate, sdma);
+		ret = devm_of_dma_controller_register(&pdev->dev, np,
+						      sdma_xlate, sdma);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register controller\n");
-			goto err_register;
+			return ret;
 		}
 
 		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
@@ -2391,12 +2394,6 @@ static int sdma_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_register:
-	dma_async_device_unregister(&sdma->dma_device);
-err_init:
-	kfree(sdma->script_addrs);
-	return ret;
 }
 
 static void sdma_remove(struct platform_device *pdev)
@@ -2405,8 +2402,6 @@ static void sdma_remove(struct platform_device *pdev)
 	int i;
 
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
-	dma_async_device_unregister(&sdma->dma_device);
-	kfree(sdma->script_addrs);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];

-- 
2.34.1


