Return-Path: <dmaengine+bounces-2060-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD48C8C1C
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D391C21FA6
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7913E419;
	Fri, 17 May 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U+wUASof"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0E13E412;
	Fri, 17 May 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969436; cv=fail; b=ddukRz52VLQQwZxhlkrtuOUB1K27n5tW3aeVPnVCmx+1JlgvM+dW0gpkG0s09eJr9CuRSBPloUk90kEn4GUkZc8eGvf2biU5dUEHQoVvb98Zr770i+jmAgCMlfnDEKbAn+J0WTae2+UgDDm0EKUfG1HEndWQw2RxjWy/CDI9HQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969436; c=relaxed/simple;
	bh=8gM8Ady/cecQ90Pmy3nAQ77+C59Vc/wcv83Dzng1DKw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qyD1+9Nly5FUxMzZOuuFUAoG6UhZATB/xPKAiDJ4SvYH3l5AgHmD8A/ikI+Xm0eexM8YJdVJGEI56jRpaBY9iqIJXycEKEfHbkfZe1dy1goEh2YsXa7Dv0L3R9bktCTe0fG4y6tmigji7rOAF8ZFJz+z9RFgzaepieZh+gTxIbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=U+wUASof; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLgYbJV6x9ph7iqg6QUFHOf0mSlcCICBlik8+GIDIvxDO6V+qlvp5q/UJGBKEwUFwVUr1ktW+UlOP6Jz4JO5elwBeMTn9964KqD1Jw/EONWQsbpllqp/eekKVrqBN/p62+SA8DWtRl5YLghkzLzaF3S+rR19/GIp4qTUontIJ+e1Fq9YlHtVLSRPv9s0WmhsaIb9IIjRU0tadrMZJEoD768P/e5BFzVF20WaLKph6jrjGM0CB+GCIVS94xemv9dr10ocBN+ttVo7LqhFmznfNRSRzADQxtJpWjKlQOCnAIkBKtLBNcUWBIdtO3d9PuNdYbB+WETnVFfKqhlUh5tiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8UVwuUsBe9jOahUx7Z3y9k2YIrMSkcSTdZxCLYZJFY=;
 b=ZfMAS7oahQS2R26WT8pOCpZqwzHeBIAUuRY/J1mAT9epg1WrggEXN0HJrlhjplbOdpy2t8b6noVOHppXoWyLzS8NVLt+CIVuLnwen7c22UiOZH4Cbndstwf+qAh5JPNO9soCxUyTOSDgNzhD+YtuAoh2BFEs8t2DJtuxENCNGebPew7RFP3z2nP1BanG7zAx2QI+4Ihz8bs/e5a7jLVSkhDnCJvAz14a0FopLKSg4OpDwXt3IrS4O1/MkL8rCPVzw/CHjEQUz7/2+Mm/n0fU+g+DxeIOKfPI3Qv15H8A0je2BpKqKBAHgvA2EqE+W50QCW1oYI7+UU8/4erOud9BIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8UVwuUsBe9jOahUx7Z3y9k2YIrMSkcSTdZxCLYZJFY=;
 b=U+wUASoffAENQzovW82YCpOm5LrK4xKAztEU6al2JnL5QN/zskTdNIbAbYGk27yOnZcQfRVFGr38czXK9pFv603WFio5ia6j6/Rl29gleqZcpekInjy31LavLJpDuo8xnzPISNoyuCtsVrvUn9+GueSW7m/cMd4RToCNAQMTP0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 18:10:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 18:10:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 17 May 2024 14:09:49 -0400
Subject: [PATCH 2/5] dt-bindings: dma: fsl-mxs-dma: Add compatible string
 "fsl,imx8qxp-dma-apbh"
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-gpmi_nand-v1-2-73bb8d2cd441@nxp.com>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
In-Reply-To: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715969417; l=1519;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8gM8Ady/cecQ90Pmy3nAQ77+C59Vc/wcv83Dzng1DKw=;
 b=ALHB7gBAlI/g0HL8wfvmuO5REVVyVs8Kn0ydIo6NPGdGQrGn8uguro6ncZqcG+yoQFPWqifxE
 2ZSMHowtqRGCkbdL36NyEWJhUmLs/DUoyhuYyOJzt57l00LGwSfwDL1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 48872996-6004-40f0-f8d1-08dc769ca353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzFRam9QczBpRW9iWlRFUGR2SWc1U3kxblF6cGRGQXd5QWZ2TTdaNjlmdVYz?=
 =?utf-8?B?OWhsaXpBVk5vemU5bXJLRzRVYWNjTFNoS1hjamhyREtSUVV6S3g2TkQ2b0U0?=
 =?utf-8?B?Q1V2WUt1UWRwelBnMFJJbjgwdTE3RzhlVENzcHZqQjRQMzhlNkI5MGlXYk9F?=
 =?utf-8?B?R2FFMUQ1dGRrN2JLQlBHQWdheUpyOVc0a3VHR2hPdWJjQ1o5WnZ1QmEyckV3?=
 =?utf-8?B?THc3WDI1YlBMYzZEN0w5azdvU2sxK1A5cmxSVyt4WTQ5YTdCbExOejcwMlU2?=
 =?utf-8?B?b01TcnpyVTdpRkR0ZkhKbXYxUW9GVEdjOElCMXlTR2xheDlkYnQyWk9NWmcv?=
 =?utf-8?B?RWdlcGxFVHVRb21TR2pYQzV2Ny83bld3STFqRHNVaVRaVkpXZmFONFpiZFVG?=
 =?utf-8?B?V3NBUXZuYUViNWVBbzV3YjZFOFRGQW9lWXZmSlQvSjhjbE51L01UTnFYQjdq?=
 =?utf-8?B?aWN3TlZUTDM2YmJqdFJGRGNxblJ5WHk5SVFNckVKdU9KQ1YwN2ZsQUtxWENO?=
 =?utf-8?B?WW9PRHp2M29HL3AwYkxqS3dJbUFpTEFUV0cyL0U5cGJjb1o3b0Y3RWJZaHBh?=
 =?utf-8?B?Y3E1TGFvTzdvclBNUkZJdGlraitPeTMwRkNWejNDbHJwOUZVLzR5SitZVS9r?=
 =?utf-8?B?djNzbDJRVG5ROU10Zk8xSXExRDY5Z1c5U2dQVmZQKzQ4SHpxMVkyREZWUU5M?=
 =?utf-8?B?VzhOM3RVb0tMZHppUEk0MGE5NFV5OWlia2hnTUxRRGRNRnN1WjBwdUc2YlNo?=
 =?utf-8?B?UitUTVFaUkRXZkNlaWFTUjJjY2JpTUlZa2dmUjJzUW5VWVBxdUtBQkIwMDBP?=
 =?utf-8?B?OFFLNmlrUE9hZ0U4eCtmUEU4Q2M5N3FYQjZucUZ1TzRzQllBbHNzU2U2WmpH?=
 =?utf-8?B?bmZDbjYzNHFITjdVdDcydWs1Z040WkgyVjMyL0RYcGp5MWpBVkdCVlh6ZzF1?=
 =?utf-8?B?ZGJRK1FYVHFFaDhmVnNHUTl2b1lTY2NIK1I3QUNXS2NBcGgvWXI2akxLVXo4?=
 =?utf-8?B?UkdVeEVHa3Fhd0kyaytKOGY1RHBPS0oxaXNPekJDbGwxWWJ1OHNDSDhuSUhS?=
 =?utf-8?B?Z0oxaExrM1JhUVg0OHhMYXlXK2tJTTcrQ2h4WmRFMWtkS0pUWWtYSnRQdDRo?=
 =?utf-8?B?VUsrTkJmZkRlanQ3SnJHSUg2ejBZU1REQU4rOGJvWFIyY3ZmOWRVNitZbmJi?=
 =?utf-8?B?L2JQU2VnRkZhRzJpNGxPTkRkeExHOG5McHhrT0FYTm1TTy9xM1B6Sld6VTlM?=
 =?utf-8?B?bG9MdUlla00wdW1mVzBEY1ZickxEK2RXUDZGenFqdHFua0lrN1I3dm5tdVpu?=
 =?utf-8?B?VDZld3Z4RnJwL3hjLzZ2Tmh3Nm5aaU82eC9zV21uQkdKeTREMjYzRXYrNGhD?=
 =?utf-8?B?dzNNUkRuc0cwSGZsSzhoYUtjL3pYcGZmYTFOUVl1N083N1JDRXo3Um5WQzYr?=
 =?utf-8?B?Ym5ZM2JVR0t6aTJFVm9INHpzbDN4Si9RRU13RnlxNElVb2s1K3VpYnFURm92?=
 =?utf-8?B?aEFFYlBEcW1NWnpWMWNLN0RiUGZWUDZlMm9ZRm5XSm9CWHF3dGk2Z3RKeVRh?=
 =?utf-8?B?MUlJNE5Hd1JFZ3VqYWNJeUt1WDM2d1dCZFk5RjVGUUdrMGNpbnZIVVZwVVF1?=
 =?utf-8?B?Uk9EaDM0VVB1QytwNC9UelNjdWx5QjNJMUpEZmtBTXFVSWhUZGovckNiZll3?=
 =?utf-8?B?OHlHcVk2VVBnOG9wNnFSdUxIaDZKTHZzR1lNSTdLMDZoOHpReS9SS3U3VVV3?=
 =?utf-8?B?MWx5UHoxR2lPd25oalcxblFxbzdleS9lTEpBM2prc284MHFZMG1KNWx4dWRW?=
 =?utf-8?Q?frjiK+1Npj6tfwkYAg4awtLPqiSNBFdsIikyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bERVK1BCZXc3WVVaVEIzSnVuU3ZTSzRHamMwNWhXTDZsN08zL1l1QVZ5QUt4?=
 =?utf-8?B?c3gvNDNiQkdpUXZJVjBlK3FXZlFTWFFQTHdvN2xIS1VkNlgxK04ydmJzSEp2?=
 =?utf-8?B?YURTbEd3eUJoU0k3YWd2RCs2NWlmUStHd3gweExOTWhER2tINlh1SzhHMU9W?=
 =?utf-8?B?Q1hPa2RFOVlSaGROQUQvd2FXM2JZVVNKR3dvdkp6ZDlVZnorOTdrOXh2dVZM?=
 =?utf-8?B?RmpUd1dGWmkwclVtNXZqaExBdTR1NFBYQXBEZkd4YittRm5WdmovYjRIM2Jw?=
 =?utf-8?B?MkJ6TnRlb0czYW8vVmpNbFU3UXFFM0N3NVBPdiszV2JzS2trd0xxcFNmbldB?=
 =?utf-8?B?cVhZV1dZZWlOR29UdU5rU0FiRmZURzhLSmVOT3JnVDVOMzEzZkhieWllbGlJ?=
 =?utf-8?B?aWErT2JXMHNtR3E0aDYrd0crYlpWRHBySmFvMGo5ZUtSZzRpMDUwcnBUSFo2?=
 =?utf-8?B?TlBQeVZYTXhobGtkcVV4Wk5UQ3VKZSs1ZVc3TkUxenNYaTN5d2IzZk5Qa3l2?=
 =?utf-8?B?TFNkZG9aSlp4a1o0VVFSeUQ2YTV4dlRlM2kwYXVRWS9WM09NT2M2S0lDd2Vs?=
 =?utf-8?B?NXJ1VlZ3NlhjdGZyTW1ZdFVEdHFsVkprNURzWDZSdlR3cFFpQ1FMZVd6aFRG?=
 =?utf-8?B?enkvQStjWG52UlRUVDFhS1cyRnhiREl2RTBGMzcwZXlHSkJzaDF6Rmw3US93?=
 =?utf-8?B?cEZDcjcwbmRITUMzZlpnT2o2eWs0WEhDaFp6L2VsdFMreHB6Um1yUlhLMGFK?=
 =?utf-8?B?ZkhjNVJ2UFhTZmFjT2tOaFZoc0NWTGdGOHhrQ3RUSU5ET254UktxdUdKVXM3?=
 =?utf-8?B?UFpZMlgzSHNuTjBDTzIzeitvRWNtMGFNMjhTQ0lEUGlFVWM1M0VUOEZkZHhV?=
 =?utf-8?B?M0tvRFZPZmcwQVprZ2pSRjdnSHFVQWhtd2ZMa2xTcll3M0pUSGpycE45WmQy?=
 =?utf-8?B?VDFic2w5T0dpdzZoQ2pEQmhkRlhnUGlTR3lGRzZ6di9qTVZIVjJ1RWpJeU5o?=
 =?utf-8?B?MzQya3Y5a1k5enBZcm1ybnVaeFkvSW1UR3lBcUswZ01FSlhhcnBPNHAzM2JO?=
 =?utf-8?B?YzBjcnZaSThReUFubkk4YUQ4R0RyQnRjQzJnODlISTZROEdpY05EVVdzMmJR?=
 =?utf-8?B?eWt3dmZNaXVMcUN2a3AwV0NETXlIcnprMjdtOUNROTI5akIyQlRDd1lSdm5N?=
 =?utf-8?B?MEp1THhDVzZhSWNxaEsybG80cGNzQ3dvYTRpM2xESExzczVOR0Q5SzBaWEkx?=
 =?utf-8?B?aG5UdmNRd2EzbGw5OGMrMzJUblhJZGhETmNZN2Y2TDJhTXhWV3VLMGhBek1U?=
 =?utf-8?B?UXBQcitWUnNJZU11aVhTWVNuQ214UUMyUjBnRWs3a0djUVZ3OUtRZ2RGOVMv?=
 =?utf-8?B?Zm04MzV1T1YyanVQdEp1c0hSMDBOVitJSklhWFNMUytMdU1jTlRkTEs4ay9u?=
 =?utf-8?B?YzJLM1lvalA2YnVDRVBjZjN1N1NGRE5SRDhlSlJWVzNUT0VoNHJoT2NYVGYr?=
 =?utf-8?B?L0VkUk9jVzBab3B5QjNQNFBnMTdJWEoyTVpiek5ibUhjMFlHK2pjdyttbHg0?=
 =?utf-8?B?ZXhqNGptcHcwOXVFeEl4NlF4UFNQdXdSOEM0eUMzK0I3c1kvVU9jcWpERWdm?=
 =?utf-8?B?YjMwZzN3OUJDanpkSUh4bzVQaTZmUkh4a28yb3Z3TytZdmQ4dnV2K2MrRWlP?=
 =?utf-8?B?dFRXQ0JST2pTR2padis4djc4MEVaeEwwc3F0SXRjV1puOEVmVjAvUjEyaFZN?=
 =?utf-8?B?Uk4wVkVXNlZqdXY5Y0tlaHJOQy9wdDgySHEzTklPWjZYSHRhVStyajJET2Ez?=
 =?utf-8?B?QWQ0UHNRanVMUDN0bUc3ZEs1NnAzM2RGZ3lZaHA2NjRodTM5SlFYdDh0aEdp?=
 =?utf-8?B?UW1iQ3FaSUREY2pZbXd5VzZrSEdYcnNPZzVCbnFseVVveVFiSFY2TXRtOWNy?=
 =?utf-8?B?NE5HbENSdFhSWEtpajBIZmVsZjZYM3lESGJYaUFIZS9XZ2FMTDd1YVdnSU1J?=
 =?utf-8?B?K085Rk1oUU9RUXE0M0ZiQUhBMy9GOTg5NjNyR0tJMjR2WjhEWTlJUFliQzJ1?=
 =?utf-8?B?WmptMExHdjBWTUlISTczYzZtZ3ExN0VFRG40SzhtSkhWcFBweUhrMkloTXpP?=
 =?utf-8?Q?nOfhU/b8vg3XJjm5x1z4n+kP4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48872996-6004-40f0-f8d1-08dc769ca353
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 18:10:30.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW/r+4omUiXTY0VFsJ0vUDwQmGKfPKWS8oCGJAfZfvhDdEyr4hZearhtmmThmoAc1JLjkBp0v314qR5aKdhP3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

Add compatible string "fsl,imx8qxp-dma-apbh". It requires power-domains
compared with "fsl,imx28-dma-apbh".

Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
it.

Keep the same restriction about 'power-domains' for other compatible
strings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
index add9c77e8b52a..a17cf2360dd4a 100644
--- a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
@@ -11,6 +11,17 @@ maintainers:
 
 allOf:
   - $ref: dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qxp-dma-apbh
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains: false
 
 properties:
   compatible:
@@ -20,6 +31,7 @@ properties:
               - fsl,imx6q-dma-apbh
               - fsl,imx6sx-dma-apbh
               - fsl,imx7d-dma-apbh
+              - fsl,imx8qxp-dma-apbh
           - const: fsl,imx28-dma-apbh
       - enum:
           - fsl,imx23-dma-apbh
@@ -42,6 +54,9 @@ properties:
   dma-channels:
     enum: [4, 8, 16]
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.34.1


