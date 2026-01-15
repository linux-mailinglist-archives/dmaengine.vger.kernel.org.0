Return-Path: <dmaengine+bounces-8280-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7029ED25A42
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7293D30A1EB0
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0C3A9DA3;
	Thu, 15 Jan 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="keFj2+bj"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145C3A9624;
	Thu, 15 Jan 2026 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493253; cv=fail; b=hgM3WA5Qr6EgwEyBY0IXAX6aiXshDKON7Qf+JNinnGMJXgusQ1aK/JuJMqP3anJnL84ytnWZohSiIFn0hrFUQVV3wnZNAZatleGlLlwtrnTIh+By28x9772FbYksaavPfRyq11JqJotdwsf84IMd/BNMZ9cuG/2Z74apS6Rwylg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493253; c=relaxed/simple;
	bh=Tbf7OnXpUHIFI8anYeeb7AjFgn4x+JUTTHZWEP9jc7c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SlyLK7nvFL084IpZx7kAaY9h6tKuRzX8ynaC8nu0w8IyI8rpPZs9UlGWHQXSBEITpZjBjjLwnAIk+oKsXHogB3reHhsdOCN1eERnsyoEDLHlNlowRMP0vfffvfuJEOgBOqyJMuwYTjxKJdmO2qm8sdPeFMsipoeUEAL/HzPCp7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=keFj2+bj; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmI3wDasz5dfE8BhUkyW4DDlcMdMbn/rR4hBayIF6VRV+RhTJq3zG1r/nE8p9SNlry0VS7UXOTb5ySHSiI7JsPYXfU2HAA5SdFPiCH6q07qZ6QZ2jSdD7fsgJ+hAe48/Eqy57lbio6SWsBzvRXuIOEgz/TQMaS3x0ftOisgZ2K/12E1lY7tCK6Xh63mCOBK2IojXMJ2EOcE+VUmu7A9tOs6dIO14SxXTd86ihf/K0Y3v942yMSUGgaeS/zXQjCAStlNmyPfuG7jgkA+kSVXTWqlobx4TbPqQLbsFkTouZO65umMn0mKwxK2mrYWEqM6to9oCX1869mtBJ7d/nuNdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQwRs+JpP/trgnV17CyKWgBwVfAMdVaNSL+Y3HCu7t0=;
 b=RNN+X/zvAcoKszZqBBL3VDMitP45mtSNjC16VUqAXlJFCu5Qe5H4+Bgz/H4DxcK5vbxZ3U2/qcQ9V/GS+w479qAI1Yht8i9oy6SXMXPp6+HgTltGpwJkIrOw1Vw8agofhyJ4yYWBRjGD4PHN0jCFWktccXtsV+9scQXQbzCY4tg9TZl8eSkV30lMvQDkqk3m/hFe3Z0NfLpYmrtr9xOWic19QO36QCghoHc9BV4/WcMoMCQMQGr+7rq2n1WZFf7syq9W9fq7saU7l+ej2AougiPilbtIOFoLcL2DWKhUciH6GqIc1+gCeyK7JAlxqFTpGZHmogf667JfQCEPVvp1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQwRs+JpP/trgnV17CyKWgBwVfAMdVaNSL+Y3HCu7t0=;
 b=keFj2+bj/zWGV0RHMCqyt2NUooLaKW+pAd4o2U8fkd/3s1NTXstruky30/OnpDw4I2gRNBTb0wjpaNFaHpKt57BeFqYoNZyoO58BjGie7gEVkhyJ2ZQ99D6qMRiuQltcknubWAfKiy04f+Bb/qWkiT67tCoD9aA/qrM6BA1rrlRW8VATfNUwJiQ6R6xtWKE7bh+PUa5nTGTnZmAa/U8RW5cHwJzc8eq8aPcLZ/7MEXabTn1MDtngye2VXwEMCEhp9ENnOnCE2LeBoR1IXxug/HQLDZz+scv9iz9BlMDbIf2jpgzQq5fj8Ohe0gAPyx5Rv3hxkO33VdgLE8xFF2k1rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12235.eurprd04.prod.outlook.com (2603:10a6:800:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:24 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:45 -0500
Subject: [PATCH v2 06/13] dmaengine: mxs-dma: Add module license and
 description
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-6-0e1638939d03@nxp.com>
References: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
In-Reply-To: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=651;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=o15bPOST+VPjJ/nT5MOg5zQEiNO3sOuP04M2ygO8Mtw=;
 b=j057wh/PRtxRfbWEj+w5P1Uzp87fiSIzB6dJ4OmfuZd1vaqstu1xxlX+o/d3L/3Wo5wbXmb2D
 c+mymXy9PisCozq3Jsvhx1/noAn8LC9FxMblVtDEynaZmDBMSvGULNP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12235:EE_
X-MS-Office365-Filtering-Correlation-Id: aff43d7e-332a-4bae-568b-08de54502c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWFFdytpVXUyM2lTbExNK0pMWk5WVDhmdnV2WHg5dlNPN1lpYnF1S09WMEVZ?=
 =?utf-8?B?MVpaZ0lpdTFScnF0Sk45YnU1Y1gvK1hKOWdOcThlTUU3b0hXM0VCdmkyRDl5?=
 =?utf-8?B?RWtVcmxBWUVtb3BZODRwQ3dOenE4cWJpcmV1b1FFMi9pV3NhOXF2dkVRTGhz?=
 =?utf-8?B?aDJ5MU1SZ3hSL3l4MWpJN3l4K2IxREU1dVFHQWJDREpIQ2NZSENYY0hxN3px?=
 =?utf-8?B?LzBWd0lNN3VTOGkyVGpOR05UOTNVMmpSY1Z5TTVlM0tTRjdUZDNkU0ZOSnZX?=
 =?utf-8?B?ck8wNm9Va2J0V2NoUnBvbE5DK01WMGdhTVZjRCtrTFpjc2Q4N2dRY3cyZGJB?=
 =?utf-8?B?QlVJWkg0ME14bUd3NC9FdHIwYTF0WW9ZN1dzbXlWRUpBTnRmaDhWMDBjVUh1?=
 =?utf-8?B?bmZRc0ZnQ0o5OHJGV0prN1FoQ2FZalIybW1UVzVyNTd0ZmNGN3pLcmhiVHdi?=
 =?utf-8?B?NllJT0xzQk1XS053QXFzVVZIY3dBZ21vVHE4U21nYWRqbGhHQnIzUnYxK2U5?=
 =?utf-8?B?WnhNV1gvYklEVi9jbjA0UEVoWTNuRmpjdjBmZitXejc1T2JEaXc0MEQ3R2VQ?=
 =?utf-8?B?Z1R5aXBhOG1lUUJDS3VJeE05WFNsV0FFTjA0bXFjQnQ1RnY0ZS83UXFpbjVi?=
 =?utf-8?B?QjlBMW1SeGxIK25objdBa1hLWUZGNWVXeFNuM1BSdmtXbzU0ZzN2anVDRGk2?=
 =?utf-8?B?MTY4bmtEWEdKRDMwdVdpQUppOTByKy9JYi9jK0tYa1p2T2o2TEQrWkt1QXh2?=
 =?utf-8?B?UUlaT1V6Sm1NLzdabU1nWGNwSWVsZ2xzUU9BcFphSFd4UTFkY1NnMWRsTzZw?=
 =?utf-8?B?Y0t2a01leWlJRU1rd1V0b01GNkRtTjBycXlmZ0VtQmNWV2NXazhyQTFKNEJX?=
 =?utf-8?B?cStsN216dHQ4eUVVdXNLVlVoTjFMUzdlRXk4SVJTbmpUMmNBNVlyMGZxK3Vr?=
 =?utf-8?B?SCtuaGcrNG5idmVQbzIwRk0vMFc1dXFnRFBMT3ErclQ5c1hFbExaSExqeDgr?=
 =?utf-8?B?TUZsbWt3VlV3NXNkaW02eGFWSEExWFZoeUVockIyWG1EeG9MWlpYWEdIS3lW?=
 =?utf-8?B?SzloaHFQZDQxeEhVL0h1ejlUMHlXaisvb0YxMzZQN3VOM1FrcXUwdVI3WUw1?=
 =?utf-8?B?YnIycXlJSlcwRmNxM0VuZll1a2hJMWZwNHlVR0tZWWhKREowYkxzSDV4THNW?=
 =?utf-8?B?citwRXVrZS9lTmxWOUVqS1lvd21TMWs3MlhDcXppR0x3OE9aTVlZZ1E3QVJ6?=
 =?utf-8?B?QXUwdW5nUTBCUUQxQTBMVVBobjR1ZE9NdnN1UFdHeTQwNHJUYU5qbi9Ud3Q2?=
 =?utf-8?B?eWF0OWdVV2Q5RUxBekhMSTRwcDQwVVFYMEE3MXhmbkJnZXZyK2E5K3J2UkNI?=
 =?utf-8?B?R0hPWHNGYnBBTkxTZDF1V0xkRm5YWVN5T1E5ejE5Z1liaDkzYkhPZWJDbWJr?=
 =?utf-8?B?SUlaM3dTeE1qcGJsa0R6MUdycURuL0JwMnNsV0JhbmtLTVZJRnMzcVBPb2Zk?=
 =?utf-8?B?LzY2cTlabWd6RGhHRFJJbE5GYzNsbGhvak51aTlUdXcvbjNZSkNkWE8xMlBJ?=
 =?utf-8?B?blA2UThZUEtkRHo5QWl2TC9Tb0U2cHNkVVM4c0ZKZnhqc1lvYlVUTktDRklK?=
 =?utf-8?B?Yndzd0czcTZGSyt6SjFQTHNFckFvRVBHZ29QYmRZZWw4V1dYbjhRN0hndEYy?=
 =?utf-8?B?bHE2QWpXUk1FWXBNb0RtN3kyU1FrQkx4UW5MVWJoYXl4V3FxRVlTTzloZ3lp?=
 =?utf-8?B?TTM3RFVzemFtTFpyWVVTOWNoeTZKTUVkRWc4Vzc3U1BkNUh4eTN4dFlmdTc2?=
 =?utf-8?B?Vld6bXkrNWIydjZZM016WlB5UGl2OXB1SUZTMURQcmdPOGU2M3BXdWtseElo?=
 =?utf-8?B?RmhDUmlVSWgxMkNZTU16UDhBR0dLSGIxLytzczBOMDg0MWxOQUR2ZlBxVkMr?=
 =?utf-8?B?Y3B4UDZmVHEyZ3cwVXlQendqSnY5VlJab3gzOXRVWUorYjc1VkhPeERYbWEv?=
 =?utf-8?B?WVBidUJkVzh5a0NDWnVoYnNHdE52Q2d5Vit0a0VjT09vK0t2eXAzL1l0cUZ4?=
 =?utf-8?B?aktmcDlzY2lUUjFSTFdLTThpUElvNHlwQk9HL2I1UEF2bG9hdkdPQ2VPc2dE?=
 =?utf-8?B?M0lEdUE4YmVUbys3R3J0RHFkU3JRUzd5UFVNRVRTWkVLamtmNi96aStHYStq?=
 =?utf-8?Q?e5N/yrAyuxZlTbdPPGj8QPk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW1BN1RFOHZTOFJzem1aUGxRcWxBbGN3aW15MTZwL0dsR1NWRlhYUlBCZXJy?=
 =?utf-8?B?eTV4Q1ZFZFA5cFpVQVEvd2E3ZnFFc3lXYlBMMWNTSHAyd2wrZE1TM05ZdW5J?=
 =?utf-8?B?RnpNekZpSHBHTElHTzVMNzJCbGZ3YVVIQjlaV2lxVXhjMFYvNzg1WjF0cUN3?=
 =?utf-8?B?VmxYbjBkVksxTVZjU3lSUWZQWFFxb2duZjB1L1BzRTRTRmlZOGlNdHV1ajdF?=
 =?utf-8?B?ZCtWWVRiZTFXYWZLblBPem85bk1hRVR1UjlpV2tGTW8xbFRraER4UG9SNXha?=
 =?utf-8?B?SWxTZkJvc1NiMnh6L0t1Ti9WSDI5dGc4emprZW5xSVhaZDcxVElFdnlPc2Rq?=
 =?utf-8?B?Yi9SQ2drZUhZV1Y0K2EzUHJsV1laL2NXVlBVQ3VNdURCTU05d1hUU2VPdFFp?=
 =?utf-8?B?T3FFS2p1eCt3a3lnVGltMXd5K2hYVGhLaFdGYVF6MmtLaUZQb2lZQ3RHN2xL?=
 =?utf-8?B?cGNFWUlLclNlUXlxVU9BU1VkWXVuNDVVa20vMnNaaDI4U1JqMnRsNjMvV3pV?=
 =?utf-8?B?d1c4ZkV2S2FpZDZMZGx4QW51c2VQVSt5OUV4V1NYb1B5THUvSEVIUlN0eE5i?=
 =?utf-8?B?OTArQTlvZlRuNWdvbEtYOUV0eWkrRWtLYXNIZlM0SFdkMnJEaFQvdWZxQlFS?=
 =?utf-8?B?Y2NCTnRVQXNSeVZMNUZtYjhGWVdEZGNwN0RKdkVmbS83eTg1UmFlVzM5S1Bn?=
 =?utf-8?B?UXpKS09YRENtZ0NBbG9tckFhS2NEb2doVWtmeUNjOUZ6Uld1L0Mva3N4UHJ0?=
 =?utf-8?B?Qm9qWlZMUjdBM3pnd0ZaT2d5OEZoUllzTHhOVGF6UjF3K0dKdm42QWtrR2Rx?=
 =?utf-8?B?VTlmbzBlSEF3WHJaT3FnNURkRjVQcklMM2VIVXFKdUo4MWc5dDZnTFVjZWR0?=
 =?utf-8?B?cElJMUVETXhRY3NIUDd2SWFqMk1kTS9YMjJUTFNFbXJ3QmdhWUZmYnpkRzhW?=
 =?utf-8?B?cStEUVBEbkczczFDVWhEU3FFNVZyZlRieVRaTXhIREdIV0graTdlVFAyL20v?=
 =?utf-8?B?SVNZZ1dtY3NBeEtYZmRlTmRRKzh2N0JlZCtZd2dxbTZmRGdFYnl1WFBHQzlH?=
 =?utf-8?B?Q1Z6UnBCU1pmeFltdmFBYzJndmN3Y1FGTi80NncyZi9QdFI5ZkM3dG9MK3VR?=
 =?utf-8?B?cjJhQitFZGtGR1I5WmlHYS9zYnZvVEszWUVaYkFsTWhiTjN4SjRFR3owb2Rt?=
 =?utf-8?B?TVR2ZytXSEtucm13Z3dUWG9yd25kbUNheVFyZGU4ejM5RlU2ZjE3MFJFQnlz?=
 =?utf-8?B?eFVNOTZ2bjFqSUFYdHcrUGtYOGdMTHJ3VVptQnJlVTZxN0R4TDFiek5PZWlk?=
 =?utf-8?B?LzRCdHBneU82emtva2pJUmlmNDNWVTVQVS9Ob053aGZxQ1B6eFJTS2QyWWtL?=
 =?utf-8?B?cXA5dEFhUzVaNWNJL0JZRGRuUHNzMkFRUE10VlU3dTVqRk5XNjBEcXhZYWFh?=
 =?utf-8?B?YVJQc055SVRlZ29hcE5PZUpzZWQvdCs4WVZGQ3hoYjlCRXFoR1E3Tm9NMisz?=
 =?utf-8?B?ajNWN0xRSERWWUpKeUZXQmZZUmw4M0JXVStNbUlyOHZ0czhCSXcrc2FVbUx6?=
 =?utf-8?B?NEtScHpMdmh0enNZanlKWXdnTk1Qa2lhNTc3L2MvY2RIb1NCTm5TdmJ2dnVX?=
 =?utf-8?B?dVlWTFVZV0h5Z0MveGlnZ0l6NDI3ZlBVTVJXdVoyNnNJRUw3MTNkaE5tVFVY?=
 =?utf-8?B?dTd5U3pEYnN6dGlYNG9QRGNOQThIOHE5WGhTQlhqbW5NTUdaVmhyb0NKSkI5?=
 =?utf-8?B?YUVBYk9ZVU1CUm1ET1RFZTZxUkQ4RnhpWnlMalNzd0NHUlgrWkpXN1oyRUZo?=
 =?utf-8?B?alhzUWUwaWZOZ1IzSDQxT3UyT1lMWmtHdk0vYVk3dnNiREZDWEdGQkZYRDJK?=
 =?utf-8?B?dVhjQTRRWDN4Uis4YmVuS0JkeXc3OWgxcE5BUGN3MjVXVG8reTdMaEhHYWls?=
 =?utf-8?B?ODNIZzhRUmlmb0UyeVY2RzJwaXNteVFPQU5lQnFWZng1cUFaZ0lKbXZ2Z3NN?=
 =?utf-8?B?Tk1SU3dRVGcrbThrRnVFa1BaaDYwODBqL0NlZnlLbGRvY09kRjhLR2ZZdHdz?=
 =?utf-8?B?V0tNZU0wam13YXRNcVJDTm1vazhBWmttT3d0WjFnVFVUcVo5QU13bUtnbWhH?=
 =?utf-8?B?RzNuR2VZcVZNOUEwSkdJK1dqY25WNDZxbldQeE9oOXQrL0t3cUdmNXN6NU5V?=
 =?utf-8?B?UThhaWY3ZHU0aGJQbTYyU2k5dlFZV3A0cWZ3RVdtQUs2dnc5V0Q1MEdEZ1hI?=
 =?utf-8?B?TXJzL1hpUVVvdWx0VVU3VHQ2RUVnSzIwaUNVU3pMRmU3SW5EWTZNZ1pUeDNq?=
 =?utf-8?B?MDN3RWp1MnFzbVRGZERPVU9VcmN4KzFyNVVxQ1ovcHRCbzBIN2hNQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff43d7e-332a-4bae-568b-08de54502c08
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:24.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TMlwkaE5XInfTxJigltcPi1FhOGtmVtfbPJUSWUxKS3gjRQz1gok1a4EUEY6ZrAi/8FnOjKv+1VkPpFA4s7Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12235

From: Jindong Yue <jindong.yue@nxp.com>

Module license string is required for loading it as a module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index e047a41a8df2e84e0c68b112f59cc79c0ab84491..083a396a8d0d6f92bdde41e90c09f316da0dcad5 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -836,3 +836,6 @@ static struct platform_driver mxs_dma_driver = {
 };
 
 builtin_platform_driver(mxs_dma_driver);
+
+MODULE_DESCRIPTION("MXS DMA driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


