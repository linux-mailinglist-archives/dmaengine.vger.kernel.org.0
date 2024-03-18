Return-Path: <dmaengine+bounces-1425-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49F87F164
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 21:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1CA1C216DE
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 20:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65126AC7;
	Mon, 18 Mar 2024 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nBpGvUE7"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2100.outbound.protection.outlook.com [40.107.21.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD342374C;
	Mon, 18 Mar 2024 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794713; cv=fail; b=Dr5ZDarG+h10UvY6zWcoWlVIa8Houaxy6QDgkjzECunV30tvPronkcp6w2IeXO6eLQD4K5UDHLIL13DjV6XtHshSVpssYeDjVKf+QsWUGpTuXwWmXql0WrR8RDhnkL7R2JtQeJW0uXZ+XzEXxMz0WooJrtmXwyeR+Ha1rn0uSFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794713; c=relaxed/simple;
	bh=Zky+Znjx1smgTOWwFA8llSwP/pFgUiS6R270jVMZ610=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KccEtIFXarW6JBSHiP41a3mQGKW0AGGcVX+uuEsT/DuS5Az1rv+yMjqrjd030K8ZzM4+kVfuXyx7SLWhpSPVZetVV88g3+8BYNXFW4c/iWXsDe/wjtyKjE7mNzrB1hvo156uFpI8Ia9Wmxq1bOvXiF+Btqc1/JL4LdseDyzX+cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nBpGvUE7; arc=fail smtp.client-ip=40.107.21.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx51Pnqtp+18JbCzpnW8zzrM6ZfaKqJX5DJPxC0RW0dhorqUVw9SuvIoIVz66q+Auh6vbDA2OUO2taNM/l0JR2tVR7T5TJQLTBP/28tStSEM7aBfj9V5fGiFK+dsHdo266gBSXEB07Mm/ukgvJ/aYKJyvSzFs2niIDmpy3viGyyA11jVzUJVpGZREd0uECuHfGdDHe9XnMZ/EY9qXedB0BQePtpPXgsY5H/GEG+JTL+UTKx9v0xImNcIxZT0nbpDix99fMKEOHb9hLUb63f4/hnyZMJCGln2Fp+PHyikxw8xEXV8T932saZnvycorHgh+i/fVxnhUEkFQHrN6/6uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeXTAsx5wn5AZ7vRzCw5hlcTmibnQD0jD+A6q0ihS1E=;
 b=AgmnKrwYL5Cz8Exhk7/+WtpxJrAA6es5SKe4H7Kn8Ncj+eukhbam2fFoE3s/5BvX8RIFFG/euDspY6ulLyaXbNC0Fvoy7XjJM419ms+LhZyb6f8vAABHqn2sWaTHmwuDwFGxD0XMIkyXU9Bsy+vzEizJ8IgfyQ16w+EPwwlR9pKSjnoyOD1ad2C7JqdsixBWrZ57MI+y+Eui75zh9iLOxJzuATWTLcH58hWTcf61O981XRjF8Q9fH18tS6QF5WkGCYqTRGPn3JnA+5XK4PZLt0hR5UYPdr9W4dp+gIhIPXynch6mv+tKe94EKDAbG8ZEARyvt2YPI3jgLFc0fGGrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeXTAsx5wn5AZ7vRzCw5hlcTmibnQD0jD+A6q0ihS1E=;
 b=nBpGvUE75piB0yeASkPUNU7duWvaD2U6kYllZqmC/Td81G7M01ZQQep6RR2coiLzwW2z6ejKCssoJzKu5puyRxcvM5PpPJ8PtW5zPqDchcJ+DWEu3t3noYJXIq3EaPWTdsPWkp28Fd6s4Hv4OYZ4lRukVqJy4YBr8dWTcGXurEI=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:45:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:45:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/5] dmaengine: fsl-sdma: Some improvement for fsl-sdma
Date: Mon, 18 Mar 2024 16:44:33 -0400
Message-Id: <20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALGn+GUC/3XM0Q6CIBiG4VtxHEf7BZHoqPtorSH+JAeKA2M25
 72HntTaOvy+7XkXEjE4jORcLCRgctH5IQ9+KIjp9PBA6tq8CQNWAQdOY9vr+3OMU0DdU22wsVo
 0SlpJshkDWjfvvest787FyYfXnk/l9v4rpZICPdXKtFDWogF1GebxaHxPtk5i31b+WpYtKslB6
 IobKz52Xdc3py775OQAAAA=
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Nicolin Chen <b42378@freescale.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Vipul Kumar <vipul_kumar@mentor.com>, 
 Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, 
 Robin Gong <yibin.gong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710794703; l=2326;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Zky+Znjx1smgTOWwFA8llSwP/pFgUiS6R270jVMZ610=;
 b=OIwW3uPI9YIz9lBG2BJd0/OQCSWBuoJIJAu1buyvZSxJ7CI0TZwywso3jC/iozCD/QlE1BBxl
 O9xIQi5BVe3DXTI6v1Pf10JghB2FwjrCNhxxiX2P12L2GqOSQN3q4iS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8489:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vf6kH+RC0vWecGKtfBNfJ40eF6ZZYWOcaff7IqpBsnCXoa8Gm0xs7Rzf6Ps9bAaxy/WYt8k5pn5VvWK6QB/qW26J8d5pY4o1ZVYnKFxnXtxqGIVQER9yiFMs3OmR1g9EzxKOXRgtB3ZQcKM/DmzRCRUZSVty1SWB4ew6sRER2ITAhb6/ZVQ+7Nh7dBQOz5C2KtJw0EJ+EPwxVAmBcoJr4U9SePjuiBiWEJH8ZvMAPt/2lggjPYQMMlcQDgA1vcC+mCeKhFDx4IZk0tpnW1uBBubs0BZRPwHhThAfXyoTv+ksIMttJ6h4Vz/xKardf4e/+lTXUmpbzE04h7PkXfzPplaYl4jF7EVTUm8FaxfrhH0WOBgRGtq6SFnOewoRYn/4CZXu3hk++D7e/CwnVrM+pru+zG3qLYNjBXtx7YKyUxUkIzpJfm/IRIGDOsJP9Vlv22gxzADfYtka8TACf0vulSoCP9CgV+R/rCjA8DWegnoef36MWrCDn771fzuXdkjqcjhQ4s/xUKSAdH48jsRnTq2Q9BnES1yv+39K3F6JzpiSnpb6y/LI1eldiDDKxsKlZ3QbIk0V3FXNdXYoQmezApmKUXQilzUQaOLRPts5QUgjpIOYM5R3HL3D80Ir05lZjy8jkFJBA9hjynbsH9KpKgRsbwEPhAJNLIo8FzekigrFNrtIClB45ZyVZ14QilX6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z08waldqckhteHlIc1U2dXdSVTRXdFFzc1lMTVhRSjhwR2prcS8yenZIaFlJ?=
 =?utf-8?B?Zng0bEk3LzVvUUd2aFVvOUE2d1pFVDJvNnB0Umd3OWFYR2VLakFnWk83Ylh6?=
 =?utf-8?B?dk5xKytLWlNMT1VKUFN4cXN0RE0zcXN0eFVENWVweEdKVnNNR0tuUDlRTURm?=
 =?utf-8?B?dkVxWE9MOWhLelAyWXhyOU1zdnoxVmxmbGg0QVRsZG9hSnZ2MkZkSnRKbVov?=
 =?utf-8?B?Vk8vZVpWZmQ0aEdmVmtjTkoyZGkxRDdRMUxqY3F3akdDa3F0QmpybHYzNUJp?=
 =?utf-8?B?eGhuMjVPU1l0azA0K0ZUN05OeUpEQWdMYnRtejZsVHJuSHBvUmgxK0Fxdkpo?=
 =?utf-8?B?RG5HbUViTW5BTGhuZGp2L2dhTGRlcWkwN3RDWG9GQ0UxZElORkwvWkdya1VK?=
 =?utf-8?B?K3VWVjJEUVhpRWR6QUJHcHZXekF0SGdNMjlyMVlOblFsbWJvSkpqamZ0cHZ6?=
 =?utf-8?B?c0dwRmgyM0lSUWlJQmoyU1NWb09RTFdvODV5Z2w3VGhhSk1vQzBTWkFQUjEr?=
 =?utf-8?B?V3EybGh6Q0NJVFNxUElMVkJkYS84bWU4SU5abjc4NlozQm5WUkFuOGd2czZH?=
 =?utf-8?B?ekNOMUtRZXk0ZE05OEp1TnIyQzhHcEtteGd6U1dZNEh6RVVnci9JT2ppUW5s?=
 =?utf-8?B?dHMzMktPWEl4ZTU0eDJabWVJOVJDNVA1RFBBMk82MWhUUGtWcTVEUHRnNk9I?=
 =?utf-8?B?dDlaQ3F0bTdZb3N1Wi9wL2prSFQxZ3NpaE4zMUNpSEIyTEdCZWFXczU2V3VP?=
 =?utf-8?B?R1NKbzFzbTlxaHRoTVkwMnd0RW9DakhmUk5UZlljcktpZndKYlFETnF3RE13?=
 =?utf-8?B?ejNsRHViVytzZ1BsMTdtNnRoNitFaC9tVU00L1ZSQ2hIRXV0bU1Eemw5OHVR?=
 =?utf-8?B?SWtVTG8xUmhVenRzZndHNVNWWmR3TXk3ZVJxMlFOcS9Db1k2b2hlNFZEdnpa?=
 =?utf-8?B?NU1yNW5oLzFhbUVqY29oLzNDKzhHbXZzdHdneEhZdmpVK1A1b1lHcUV5d2l5?=
 =?utf-8?B?eHcxREgzTjk5Sm1jSjVMbXhZVGlnRjZNTnZwWWJ0QnY0SklhNXhsZWs2RzJn?=
 =?utf-8?B?ZCtrMDJOQnhyMFpXWFkrQlc0UDdXcTVNTFdWd3p4bWpsa3A0NjZyQTlGaGY0?=
 =?utf-8?B?RXFSMWdvMDNoSk5KOU53QW5MandzQ2srSzAzakdpUWI3MmVpRDZWSzFQV1pJ?=
 =?utf-8?B?bGNNTmFCdUppS0Y5ZUNEaHVWV1p5TXhLMGJyQXhyUGNkZlNVTUYwYXNCbWxR?=
 =?utf-8?B?aHRCakIxckVHSnNnUWloZFhSY2VJUmlRVG1ORlRXTWtqL1BHVTJsSEZaeWNo?=
 =?utf-8?B?R1F3aXhrVlR4ZVlRNHdPeFJETG0xdFNhV1ZyNGhYZ2E1VnpMOU9aQTR6NDZY?=
 =?utf-8?B?TllGUFhwRWRkenZlNmFQTktrcysrTXB1RS96dTFySi90aFV0Q0VmN1l1VUU3?=
 =?utf-8?B?QThwUE1SdzVUK0FMb1NXbE5hRFVjUEN3V2NadTJhZFkwQldFOHhaRTd6Z3Va?=
 =?utf-8?B?czNXU080bjl3d2NrM05zTGs2aFZQazN5cFQ2ditKT2VyeUZ2TVk4dHh0L1ZF?=
 =?utf-8?B?V1hYOGxDVlA2b2hXUVlwb3FFN0ptWkZCY1Z6MkRwQXllWDhaTklMbyt4clB4?=
 =?utf-8?B?dzZqUzdHSjg1c2lhUFdCVTNXQjhUN25NdFh3S002bFFRSDNhdnlBYUQvejN2?=
 =?utf-8?B?MmIxRU11QkRtM3UxM1F5bStqZ2lJQUtoa1g2WkxNSFE5RjJIQ3V3Yk94SVBa?=
 =?utf-8?B?WWEvbFFvTXJLTjZzNDR3UkJ2RGZ3a3laVGFnVHRaZDFoaG9PVG43L3BuNW1N?=
 =?utf-8?B?VEltY0MzWGV1aFFvNGZFajJFdjROOWI2SHJWVGJHSUtxQTdNNUd0UDVHbkk2?=
 =?utf-8?B?OUVTc0pxQ3BnWE1xSWlTWlk4c3ZBUHdIb2E5TXFLK1lXdk9RQWZiV2FKREVo?=
 =?utf-8?B?RlBXVTdJdE9sUjZyUU9wSDJYOVBMdForeTcrWVR2SXVxZkMzMWRiN25NeTNN?=
 =?utf-8?B?ZTdGR0JMTjRURkxtb21NZTY3SnViNWdMcEJjeG5JZXpwVWFNdXFiK0Z2K3gy?=
 =?utf-8?B?dmpZbm5vSlp2OUhwZWNiclVDTEVFYzRpU3VMMmxsbjU0K2NxREExU0pSZlZ5?=
 =?utf-8?Q?Nk1WhWHPJUf2UYlygG4Ii2oT9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c7f088-4705-4693-66bb-08dc478c4c8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:45:08.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBUYXWcYeEnwD65pD2uozimGnCHLr3c2iy6F1KldxVsvWYZXlA2yK0K4I3wmb9b8v3dUJZQPAJNbM4tGaf/o2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

To: Vinod Koul <vkoul@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>

Changes in v3:
- Fixed sdma firware version number (v3.6/v4.6).
- Update sdma binding doc and pass dt_binding_check
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-sdma.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/dma/fsl,imx-sdma.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/dma/fsl,imx-sdma.example.dtb

- Link to v2: https://lore.kernel.org/r/20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com

Changes in v2:
- remove ccb_phy from struct sdma_engine
- add i2c test platform and sdma script version informaiton at commit
  message.
- Link to v1: https://lore.kernel.org/r/20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com

---
Frank Li (1):
      dt-bindings: fsl-imx-sdma: Add I2C peripheral types ID

Joy Zou (1):
      dmaengine: imx-sdma: Add multi fifo for DEV_TO_DEV

Nicolin Chen (1):
      dmaengine: imx-sdma: Support allocate memory from internal SRAM (iram)

Robin Gong (1):
      dmaengine: imx-sdma: Add i2c dma support

Shengjiu Wang (1):
      dmaengine: imx-sdma: Support 24bit/3bytes for sg mode

 .../devicetree/bindings/dma/fsl,imx-sdma.yaml      |  1 +
 drivers/dma/imx-sdma.c                             | 64 ++++++++++++++++++----
 include/linux/dma/imx-dma.h                        |  1 +
 3 files changed, 56 insertions(+), 10 deletions(-)
---
base-commit: af20f396b91f335f907422249285cc499fb4e0d8
change-id: 20240303-sdma_upstream-acebfa5b97f7

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


