Return-Path: <dmaengine+bounces-2099-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC5D8CA077
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C585E281668
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27913777C;
	Mon, 20 May 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A5/Ms/sx"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F861369BE;
	Mon, 20 May 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221401; cv=fail; b=r/+cA3FRiMM2in0qbhqFeTNYqRhRrLVis4NI2gQjO94V2rvleY4uk62nDab0k5NhotqKmFDFUnvbaUEbLUQ9xfUgFMt7/RGZhOuwNijrn/3VCfF1Kiy3W+nkKSMoXaAu/1OhAx1BrpS6B7R0KInr8GRKDXUn2PYuo32XsjZqA7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221401; c=relaxed/simple;
	bh=Qvp0MzaBirxiX6mf0drVzdfxfWh8WJheu+7H8KrmPLs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=GioT9tQCedGCkZMHzLCwwcjRM7f0x06gNXsUQWHm5f5ksRDu0TCY7tLUBwOvD13RbCxfeEteev6GiSuDVCnNZV0ZzWEoNKafp6ldWPNUkc77ZzPMbpzS4RZ/3g/FyGjfFMI0qEyzS5FXMmzMKn7+H58VNg4W7gSsiQ1QBaUfYns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A5/Ms/sx; arc=fail smtp.client-ip=40.107.14.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlmIIGtGk/LPhcirXCqL/7R7zOqTDlJzct0eD9nTXkFth6qCRanjQ+Z8sV+Ot+QTynAZrHgp7L3RTkug6+NzDJZXYU1ert4L8aJ5UbXLzXe2lShhb9TpFRPG7ehWcubphJno8sxYnE/M9S+zXmIM2sLK72l1x+7JuZg67ATIR+mCgjkqkW1YGsqu9ZnzyfsZn4DmZuvFW3d+EyOc3DM8+Yxhemq55BklwOMFh8JGKAwYvT0V3da365OMzMDye0kXWKHoxx5hA1XB9DmxDKD8zLcgsXDvoNQBPAudV0YhoYYQU1MbM7cloxdB/q1A0eOciLxQlZXBwrYTlGQ9UC77Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqTTcVGDf6gMMvovHTLeyjZjXWkcX5Wj9LjXADR1+XE=;
 b=ZzKk8lcxNx4vL/FxT2MFHu3jX9xBDd0TOvZl1paqrCn9HcgruGLb2iVAMgXnRAxNGBhA8eXiGrUITtcnwCAi8NZ1LAiE0eYcNlQE8wEkgqt1RBAUOvGu235JqCrt2V2l+Z/BGrhcj34PtK4D9TkIPyZpKKKk+uDa2FWhg+Y/EMwGRQdwPgiB2dlK79G+351NWycw3/BLSGimO2hDFVl1UEpdPMLeW17zgFnBIEY5j1L/KEKik+t/UsRnvZvMIFsRiP+nSiwhHSeABwpfdNNERVho9xwcPBHqJvLma0WBNWnIPFBy68K/FDhyw5jynQpw23WGjzJBMSn3eqPSsQ5zzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqTTcVGDf6gMMvovHTLeyjZjXWkcX5Wj9LjXADR1+XE=;
 b=A5/Ms/sxlUZK+TolZkWsrabY/WM4HwYphGMJS6+EVsf3X0M5txToKfjPfcsad6qQL929owyVb7cFJsNAV8iiuQokxbMKsxKy53E0vmELwX+y44pj2t6cY/6wVNrE7F+hhc0z1LmpdQ+/tiCnfhjyYbhthxxp2hrr56x2ZV/olaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8535.eurprd04.prod.outlook.com (2603:10a6:10:2d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Mon, 20 May
 2024 16:09:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:09:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/6] mtd: nand: gpmi-nand: add imx8qxp gpmi nand support
Date: Mon, 20 May 2024 12:09:11 -0400
Message-Id: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKd1S2YC/03MSwrCMBSF4a2UOzaSxGjEkfuQInnctnfQNCQSK
 iV7NxYEh//h8G2QMRFmuHUbJCyUaQkt5KEDN5kwIiPfGiSXip/FhY1xpmcwwTMUQmrprB8MQvv
 HhAOtu/XoW0+UX0t673QR3/Wn6D+lCMaZPll79dJ5pcQ9rPHolhn6WusHMkiYcaAAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716221390; l=2196;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Qvp0MzaBirxiX6mf0drVzdfxfWh8WJheu+7H8KrmPLs=;
 b=HlCf76l0hPVrNWuXoGoT9taC/LhaXGuQe0bdjL7oW8vq9RZp0Lg1Q+jxJvBGl1nNEhbvJOk89
 l2lFvL8JzbNDaqV/fpN8IPd7jILSG3RGtAPu6Lo78ofJHWrHO7faQKZ
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 510f05d4-0e96-4a54-e55c-08dc78e749de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|376005|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlI0U1RlYzVOTTZMUGZ0YzNzZXdkWXJEUXRtR0J0Q1pYcHRDcS9uVGNwTlNx?=
 =?utf-8?B?VE5NM0RIRnZPc09DMGFSU1MrOG9kWDRqNWJYeG1uOHZCWUNFM2kyaXlMNkdu?=
 =?utf-8?B?aGszZ3pDSXUzaXZBVDY5L3BTbmFDMmJVbDBvdC9kN1NXNmgvUlJ5UEp5Smhl?=
 =?utf-8?B?WWJiOWZ6QzFuMmZnbW9EaTdYWGpDK0R1NmlDTTYyN1pkYTdTdFNlU3gyK1dV?=
 =?utf-8?B?QlRhWGNiOEhXUDYwRmJHUmtsWFJtcHg3ZFprMjhiUU1kRU1uamdCNUN0SkNa?=
 =?utf-8?B?cXA0Vm1vZTFZOXVVQkRwOExnNk9vcVpRdUdXYy9iTFFxUTVDaWRCNTNUUjRo?=
 =?utf-8?B?b3V4bFhJcjdtbWlkeGQyU0h4M25UeXhQSEhnWHVWRmJJMU5GOGN2Y093dGFy?=
 =?utf-8?B?Ukt2YTRhdVJBQ1hsc3h5MU9TaTR4ajlZalNHTDM1dGJLY0d1ZndYQm50ZmlW?=
 =?utf-8?B?QWs5ZW9Fb3A5SVNvR0VlM1ZRQXFCTlNEZ1FVaDZ2T3Y2Ri9XL0M4SnlMemlw?=
 =?utf-8?B?MUoycVhzM0FPdDRnZXArM1BYM09kVmo2aVcxZXQzSUFab0dINmphcHB2TWsw?=
 =?utf-8?B?ekpWcDJpcVhDUTZxa0tqditobGRiMXFRd2JxZEs5L0huODJ3WjFuWUhWVDJF?=
 =?utf-8?B?OTJEVWF3aC9yZEFoSVdxd0tjWVJ1dFAvZVJuMjJ0NGl5YmI3L01USjBFNS9X?=
 =?utf-8?B?d2lSRHo1bS9adCtzeVMvS0JHUFBxS0tuSHFkMDhpUUx1QUpvdkNnYWJmZWtw?=
 =?utf-8?B?SExPbVhxUmo3SmJhdkpublhRWHpzTTJIMUtPc0N5RWM3eXlzRVZOUG4zRFVJ?=
 =?utf-8?B?TzRjaSttQm4vWUkraTNBaUpZNnArZ1gvTTBSb0VvYXhwOXdENjBNTmM5YWJE?=
 =?utf-8?B?WnVTMUJzWnNtZGdCVDZXNmV3Vnc0cXRrT1VURU1hMXM5MWxKZTNONzdMSWxX?=
 =?utf-8?B?N3pzZ2lkY05TMHpFOXBGalVkc1VqUHl1ZkU3d1BXNkpnTlVEOHVmVTQyQ012?=
 =?utf-8?B?RlFsUjJFMVFURWdvdmI2VTFaNkhXVlJ2T041Zm5sNE1rb3ZFUklZZ0djbkhw?=
 =?utf-8?B?NHp5dTdhQjRyOTdpL3gxY29zNXBDREJuUWJDeHVPNWtXWEtkdWppN1hqVXB1?=
 =?utf-8?B?QXV3eHJDb0JZYkRlRFVqdE1HaVVRcDNQZjlsQWVnaTVYUGZCTC9YSTlISy9u?=
 =?utf-8?B?RTZMRkJEbm1YM3A3SnlhM0wxTjg5TWNVVTZrWEcvSzZ1Q00reSthVTVpa2tu?=
 =?utf-8?B?OHJES0U2TVB3Y0pNejBRNjRmcnRHMTZTa0hFZkNjblF2aEhCT1hBcVVqQXJ2?=
 =?utf-8?B?VUg1eHpUVUJVMm1RcDlxYTlQWHhrcE8vSDdGWC80aHhjaTBCZEZ5ek00eXBL?=
 =?utf-8?B?eWNXYW5HQ1RLQXFtVURwN2VnaW9UalhHZXhYQTBOUmxKL2VQeGpRdkRVZ1ll?=
 =?utf-8?B?YXZmSVJONm5tbGYzMURrUzl2WXZtTFY1YTFLUlFBTDZwYkVvZ3RQVlRXOWpI?=
 =?utf-8?B?SXllK2pFbkw4L0FaYzQ3dE5JU2ZyZ2lMaGh0NUI4cG03YTZMWEYzSG00Q3Zn?=
 =?utf-8?B?bDFHUzQ0YUlTUTNFQ2FDUE9TM1RLZW5qZVZTaEJqZjY0Z3RhN2w5TmdyNXMv?=
 =?utf-8?B?eHhLM1hJeUJhMi9jVkR2ZEkxSXRKQkx1YVFodkdwKytjQXF1UFkwcjF1cjho?=
 =?utf-8?B?V2JpelA3UHl6SmdBdFhjWTVlejhmRVhad0NDb3prUWhOZjF6UGZIN0p5TGZK?=
 =?utf-8?Q?0VOgMfsmR7ZIiuLRlk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmgyVUJEbWtzK25tdWtUWHAzajYxQzhjMVdlYTBwekRsRmo3ei81K0xMbHVp?=
 =?utf-8?B?U1pxOEdWZmtaRkRPT3p3NDIzeHovRlk1dWZaaTY5SW5ZM3VPc0QwZ1lLWXda?=
 =?utf-8?B?Q0FGTTVNV29hODdEUmxkQ1FhbnB4VC9QcW9hRHFDM05wNFlNQ0ticW1uRWdO?=
 =?utf-8?B?MGJpaWt2VjNhem5teVo5U0ZUeFFkS3I2ZjY2N0RHZWpSS1JIRmVQd3lncEM4?=
 =?utf-8?B?cGlwYk1Sc3JWYkMzdXJMT20wMFVWMUJJcmdUWFg0ejJZcVE5ZTJZVGJLYWZI?=
 =?utf-8?B?azc1bm1DMUZHZ2FJdTVYN2UwTUJPOHlibEIrb0M3NGVrdm5JajByUWZ2R2hP?=
 =?utf-8?B?RjlrMEhvYXArdndUNFRyTUdBSkJNN0pVeDQyNWNwMDExaEZlMFN0aHRRMWU1?=
 =?utf-8?B?WWlrazVpNHgwUytnd0NXOVN6amt4a0lFajFHV0ROelBRL29GSENqWjZlZ2hS?=
 =?utf-8?B?T1c5ZlZMaWlWMG42dTdXUXBCVngranlsN1FucmlicDdQWjVjTnkzSkFYZG52?=
 =?utf-8?B?RUZpMUpMaU4wNW4rbUFqakgxU1A0aXZKcHZUVThRL1kzalkrdStmOXgxb1Jm?=
 =?utf-8?B?T2xIRGdaTWtJcy9WUkZLUGU2NmdIZGdidFcrcXIxd2pVN3NwelVJSk1QRGlS?=
 =?utf-8?B?Tnp1V2Vxd1c5TVNTRHAvcFF5VHoxYUZ5cElZU3hSeGJlZG5MbUhGbHF6dlVp?=
 =?utf-8?B?bmQ3T1YyNU5lb0FFYkFwWWw1TWxQMzFwekJzZFE2S3NaWFBlNTQyNXZsOUVQ?=
 =?utf-8?B?WHcyRWllenhTTFFsRGo5VWdBTTBwdmRyNjZwYW90OE9ITFNCTmhuZTFwRnI0?=
 =?utf-8?B?THNYNzZFbXYrZWdDVkpQTUlHT25aQ3Z5L0p2aHZ2cVVDK25PekFhVElKMHZO?=
 =?utf-8?B?Q2R4eGRxSThoMkdzMjA4aFdzOVhsMURET1R0OWF0Rk9DMFN4Y0FlSUZNcDBP?=
 =?utf-8?B?SFdmU2hBTXBpcEtxdGEzaHJSVnFiSE9sSm8zU1g0d3dTOEg2QXg3M3pRWDdD?=
 =?utf-8?B?TXN1WTduR1BsOXlTd3lWcDl6d1dwc296eXA0MGJMSG1GUHRZK3dyS0JkTStu?=
 =?utf-8?B?R1NRSk93NDhjcm1PMmJnMzA1RmVUNTNMZm1KYnEvb3dNVkdkZS9QL2N3TERD?=
 =?utf-8?B?NVRJb0djTkV5YkM3VHRPM0FOOFhRdnQyQ2xWdXIrcHRhWW5NZ3JDR2FDUWlo?=
 =?utf-8?B?UDJEQ2x3L294dzhwYmZjTzFYR3BEaTZ6V0psb2pyVjFvNFBJVTlyRlkrVzV0?=
 =?utf-8?B?c3FmcGV6VkVocUc0d3ZRN1lDVUF0Wlo3SVJVVzlOQy93VmlPQWVrbFR3NXA3?=
 =?utf-8?B?RlIxQ2E3ODA0SXcxMjRYdW1vUFNOSEo4TlZBaDFhSmZSWXdnMGVjUEw5ZmtL?=
 =?utf-8?B?QUExU1JlclVEV2hYbWtGVG5YajB5YnJQdFlyeU85ODBhS3JOOGRYSUN4U09M?=
 =?utf-8?B?QUl1aDY5dDEzejY4YmxETEw3Mk9FbXpFNjhIVE0xdytEWlFXT1pjWTlkNDlw?=
 =?utf-8?B?aTRjaHRwQ09sakN1aHVHTW85STFqZklkMEd1OWpyT2NlS0hIZXZYR0l1dmlU?=
 =?utf-8?B?L1o0czNUeTNLV1hCQzZzMXp1MG8vM2pRd1lFOHdrbUsvVXdpZHBDcC9kV0VH?=
 =?utf-8?B?eTRuYkZxYXg4dDRSTTU5L2xxbWc0QlBsN0ErRGhFOGFWMGRaeDVUUWd1Uzg1?=
 =?utf-8?B?dGRmTFBIdk56ZFlQOEFTY3dLSWNVSW1sd1orUHd0QWl0ZU1KdmRwTHNiVkc0?=
 =?utf-8?B?YVBvU2YvNG5OTGc5VC96dnJFT200b2VpNndId1FETll4QUxGQkhXaitBbGps?=
 =?utf-8?B?VVJ3aGhTZFB5SERNRCtTSnRnL1p1ZE5PZEFSQklOWldUZ1pncXRtaldIanhv?=
 =?utf-8?B?RHRqQUxGTTFDL09kVFdOL2NNSWxiNGdmZDlXZkVUTUtiZDhtcTE5T2N1Zy9B?=
 =?utf-8?B?YTNDTGFTK0lUOFNpNE9kSkI3NkltdUEycUFHeHhjMWZEVHU2aTFiaHFGNjRi?=
 =?utf-8?B?RzlkNlZROTNtNFR2d3M1ZGZvNnFnWnJCcE0wNHFwSE5iSXRLeUNxbk9XTTg3?=
 =?utf-8?B?OU1ycEtiSnA5ZWJmdDc1RkhEY3g2V3VldWxSUEdPQ3hORzJqNEgzREhoVDUw?=
 =?utf-8?Q?POBE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510f05d4-0e96-4a54-e55c-08dc78e749de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:09:55.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AWKqqeqidWaXHOj1LMcpDgt7REDgpdFC3ytHfSQ2gJxFIwNJTnY6nNb3855yqtPFgp7vsoZ1L3JwaZ8Ep7BHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8535

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
Changes in v2:
- Add bool support_edo_timing to simple check logic.
- fix typo at commit message of mtd: rawnand: gpmi: add iMX8QXP support.
- Link to v1: https://lore.kernel.org/r/20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com

---
Frank Li (5):
      dt-bindings: mtd: gpmi-nand: Add 'fsl,imx8qxp-gpmi-nand' compatible string
      dt-bindings: dma: fsl-mxs-dma: Add compatible string "fsl,imx8qxp-dma-apbh"
      mtd: rawnand: gpmi: add 'support_edo_timing' in gpmi_devdata
      arm64: dts: imx8-ss-conn: add gpmi nand node
      arm64: dts: imx8dxl-ss-conn: add gpmi nand

Han Xu (1):
      mtd: rawnand: gpmi: add iMX8QXP support.

 .../devicetree/bindings/dma/fsl,mxs-dma.yaml       | 15 +++++
 .../devicetree/bindings/mtd/gpmi-nand.yaml         | 22 +++++++
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    | 69 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 11 ++++
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         | 20 ++++++-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h         |  6 +-
 6 files changed, 141 insertions(+), 2 deletions(-)
---
base-commit: dbd9e2e056d8577375ae4b31ada94f8aa3769e8a
change-id: 20240516-gpmi_nand-e11272cbdfae

Best regards,
---
Frank Li <Frank.Li@nxp.com>


