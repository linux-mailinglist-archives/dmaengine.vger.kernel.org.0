Return-Path: <dmaengine+bounces-1657-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2947891FE3
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 16:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014681C25EA3
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E944D131;
	Fri, 29 Mar 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L+W9STm0"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2110.outbound.protection.outlook.com [40.107.8.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51E4C63F;
	Fri, 29 Mar 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722915; cv=fail; b=HQtxVpUtjgIWO32DjPwAhKQyS//+1mScTRN9ctxFaYAM5GLC6ZCutaqHN+qqMYMD6KpL1y/3GK3D73JacRrWLNVQYw5v1UIdUnsx7GpeVBUDlKD8BRLrg7IDQ/EBF6HH7yztB+NJW6BCkc9nfDhMWOD+wpu4k4jSAO11ar167jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722915; c=relaxed/simple;
	bh=rTF/ueJwkfK5eKU9xU0B+wAeJhkRlyXR0sutzsAX11Y=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=VmCveQcQFdmmYowgpO2O7ZDIm9ut5hiefkaKnqz1MVVryVNKsjxVYhkJm2AgL92gHluk2hoB8GdSiUbHkSlWzKw5gO3li4wkL3jbRoOSw+bH8YDT4T8/+SpsyWq9lYaG/MBVVxkMsLmKMDLyScmQgIe8QSbX0ro94tFdxmnUcHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=L+W9STm0; arc=fail smtp.client-ip=40.107.8.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8Kz2v09S/l5DdmK8S6HyY2v6g3/ZOSOXyz8KC+JQOE86xh+BfKvG9jTPCi+BpdiRc+TRAxgzvy+WRVnWEtKtGsCDOG+kiA2CCSWvkKsT24ZC0HsPurBOThI+mD7x7NOU1b04/OGQzJufbDdkogcsfyOgfN5izlm5m/pLFBI2PQ4gZlj6a0LDYb9gxahyiUkBgYxofI0kexIb5yEqnuMbF2EL8GNFqECb8EqhO0j3ou+ZhAqcO7MOcbQB38gnXKr9T0J472WI5WZhi5Z13Ym7Ud3koLSDEKECSNv0+imAXQSf1ODrlBCPcUOaYGfsLsh9ijhkU0QHsZQCoa0oEJxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEpycwDr2hVMwHRV1ANJZ3dTItXuFvQQefStg25p2jI=;
 b=nM49lxGKhvym4YGETp5/Wc25HzWhXRZfD6YC/ax4dH3TLoguCovQX/46QpS/C/x+98yFYNS45lPwi9DUKWVKqg0uZ2U9cB/10F6ha+BYBjlZEHQYy0wzKwnbtHyenyg5RcikArfUlZFmY1VCPqbgs9jvi9KC4V5YnjA7VS5ilsMP7ULPzbS8nkypBOiSLbBffMIWulxu3GOhmGLZoEnMvazGSgFlLY7yuF4s03KUGa3oRz69pva/mcUJaPJlHzgKF6Hf2T84jWF+EbsOQEkqPsravY2TJbzWCpwpq1tDicogecxIHtweraLgL8pYsDVY9RI5h/9NjqDhqvKQ/vE1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEpycwDr2hVMwHRV1ANJZ3dTItXuFvQQefStg25p2jI=;
 b=L+W9STm0kukd+KSObbJjgWoYgPRxNUHariTyErbCZj7mVxj/og8JRwsb/Z/48cy0/LJiTdJyhRCTFg97GltlQ13rifvWQged57ZEOcwgf7T8QEYcN5iDAV8dqJ02Bo7zn8+CNCLI+krrpThjtIZsqCcwRJdpC1ujDBXy0pHsDAE=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 14:35:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:35:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/5] dmaengine: fsl-sdma: Some improvement for fsl-sdma
Date: Fri, 29 Mar 2024 10:34:40 -0400
Message-Id: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDRBmYC/3XNSw6CMBSF4a2Qjq3pk4oj92GMKe2tdMAjLTYYw
 t4tjJDE4bnJ998ZRQgeIroWMwqQfPR9l4c4Fcg0unsB9jZvxAgThBOOo2318z3EMYBusTZQOy3
 rSjmFshkCOD9tvfsj78bHsQ+fLZ/oev1XShQTfCkrYwktZU2qWzcNZ9O3aO0ktrfqaFm2UClOp
 BbcOPlr+c7Sy9HybK3mylorhBW7v8uyfAHn8O5XIAEAAA==
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
 Robin Gong <yibin.gong@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711722904; l=2573;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rTF/ueJwkfK5eKU9xU0B+wAeJhkRlyXR0sutzsAX11Y=;
 b=YKpUHrsGM/6oSSvURlCVQoCZDjeOWm2rvfdsCsHPEgOlGwKwGGYq1wR/iw1ujzoxRbCJ1sDv/
 Z0T/Obke6tcCthhyozlNn65rvBZB8iByKe9sqOOptEUIJScwUSjRoga
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6897:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApQtPF+9DkZRiXJJ0bxHTngLS6t4oyJH/T2JQ87Sd/8R6wL5tI1qM/bc26VuHnYuyXEFFyBCYK91S+akI9ewJXBqrWD7YyHVd8HGnzTGdJoNB34QsZGICUhZs24WZgkrumsgRbpwV/SlwNHLGKfUtkDe82IEhi5P2DA67UUTZgKsWyoXMOOQDfCSv5olLq+4ihqbvaPe9KyxOzySa763kJNbLk52bffTzJxAXb5jO5S5ixJzmK1MQ/cwQbyMMzAcutIuj11/Guh5mgYGsZ11J93pWxvVboYpUqv2znqOJAqGa2TZD0ek7+04myNm10TlcmIItVBcapXvrPLmAcoduqYT4DR5f3Mn1U7MHp4fu4yQUz35ak5+o3lF8KY5J2X/YbfLgeX5az0iTbsnbn9MTe+UjYlfzvSUK1+doClBNqjeG3B+XNteiMoXosqtUPcU8xm0QaQAQ+XKnjBxsf/Nwh0sB3ba8ZpOaf9jWH7tTq9h9RRa+dWvV5dEGuzBaaSHAf05gPmZGayNZ/RD0YDl30IUXmn+SQyJy7HWdNYoHeLy/kA2969O1ecEGtVgud2ITuvMu4VCaA4CG9RUm5ngwy0dMYDIf81xCZneIVQnORnF2ZVq5SCe4mFCxIeYVuzZhif4feB6FGI9oPrHJyoSLbWAwnMc/JeougvVHbBnn9QZ360fjOllV1yJ6LNcwQVt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dENvSGdmdXVJUnNZYUtGM0FoL2ZHMjhMMzNBQ1lrRFlldzdmcVZrZ3NQMW5p?=
 =?utf-8?B?VXpDSGp3N2JvUjNYck1DS2o3b3FEbWVFZVhIeFFnc2VLOTJ2dkp4VVdMck9p?=
 =?utf-8?B?Qm93WUl4cTZlWWpiTVF4cXNxRDVPdUlPQmo0Vk5wVC9mUkMwb0crN29JQ3Nz?=
 =?utf-8?B?c1dOR3RFNitWZFFiQ1hIdzcrM3lnVFhWMFRwaFFCdU8wVFo1MFRRMysxNWlP?=
 =?utf-8?B?WW56Sy9ZTGNvcU1JYkhPTFN3NG5oMVRZK0FiajlhL3Q1S2dhSmFHOWNqNnZO?=
 =?utf-8?B?UDJlS1BJZ2N5amlZNlJzY204NDYvb0hLYnVkODUvRzM3T2NiWENYVXdwU0xP?=
 =?utf-8?B?ZmlRN1FuL0h1SjNRQ1pCUktXRmozRTJpU09ORlpVdnMvVzlybnlDMitPeGFt?=
 =?utf-8?B?S2J3eTNqREx0ZmZCNXpkbXNod1VwL3JrVDZXNGtGUFdSOEVUR3lHQTRBUzNU?=
 =?utf-8?B?eXkyR1BDUTBIVTdEZXhuaC93RGdwSEFTMnAyUDJkSU9KbGVWSHdOZzNWRFNz?=
 =?utf-8?B?UjR5eGgzdEM0VUpoMEFxN2JiUDJFN3A3alUyTlhuL2JMWHVMSE1VVHFFRWdn?=
 =?utf-8?B?Uzl0S0NzNExzV1BLY1l6TWVUTHMwRWhvSkQ4RkJEdUFGUW50VXNrT1ZrY1pP?=
 =?utf-8?B?L053bGg4cGxaM3h1M1RrR1lpUndXUW02L09WS3Fka3JLZFh3RDBLZHpONHU0?=
 =?utf-8?B?RkxybDcxZVc1SG1heUpUZE1jMEFVbHdXVi8wY001Z1cyL0hxaDdQbnRaQjBE?=
 =?utf-8?B?bjdWQlg3S215dlFFZjd4cGQ5elYzVkVjU2kyTTFxclo0K1ZWWW42dkNtMGZI?=
 =?utf-8?B?c05NWHdkWVVnL3ZVNDQwSHdrWkhWUWR4eTZCNTR3TFNBMXpQWTFTd1V4TDRy?=
 =?utf-8?B?N2FTRms1UXhEQVF2VTlSdUVpWjRLVWVxQWVBVFBYblBtVVc5cmdqSzNMcTFQ?=
 =?utf-8?B?L0dsbGJLeWtoSkEzRU9ua0dOM1Fqbm5zbDJSL3lKakdSdldWWTFXUmRRZHBV?=
 =?utf-8?B?SXJoY01uSi9ETWw5VFVrSkJ2eHlBd1ZwajZnWWJzdGlTVHVBZERtU21nRWJ3?=
 =?utf-8?B?T1JsajZ6TC81ZitJcFhMNVJtVHZxcFArV2grbGVVM2RWM21oQTFsQ1lVcHRR?=
 =?utf-8?B?cU14SWcxenFkU3g5THpJVUJTODRXcElnOVVPODlMR1ZFcUZIcWNsZWhRMDVE?=
 =?utf-8?B?c2JMZCsvMmI4RTlHb3Y5RjNncWdXeVJ6M3FKU29nU0hyR0JtYm5yUEJBNE5N?=
 =?utf-8?B?SlJCaWc3SUx6Zm5PSVQrSmhwcTYrb3dzSHJ4RzJBNWNYQjhKZytNaDNyUksy?=
 =?utf-8?B?MnVJYTA4MDJFQzcxb2kweithNTF2dE5rYytXYnBWWnF4TEwrOFVzK2VYVzhJ?=
 =?utf-8?B?UHVNMXRvOHdyNXc4WU44K2RwRlo4TWNxTFZNQlM0Z3d6VEIwSGJsWU9vd3dX?=
 =?utf-8?B?aVVjZ2JqaUR5bUxmWnJIMjR1OEE3VXY1TDJCVnovTFQvYVBUcnNaWDAzSVc4?=
 =?utf-8?B?SGJqUmZvVE81TGx4M0dubGZ1Rk5OMlZ1eExDQWp2ZGoyZHVnZWo5V2luZThn?=
 =?utf-8?B?NDB6QndoMkJ2akJUbHJlcHZjWFFYN3BXNFE5c2ZDeE9FcTlvWk1tczZuUGRy?=
 =?utf-8?B?ZXlWNXNhM2tPQ29xMnZ0VmtmUmZmZnZIdCtUK0lYRGYxVHVMVzRQbStSeENT?=
 =?utf-8?B?ODJtK0ZvR0NEbDJ4SWdNbnJvbjc4YlYzUFF2SmF0cmt0VzE1ckdKamh3aE16?=
 =?utf-8?B?bzU5V3VyMm1QQ1JDTTluU2NUa0tmUlJxbVcyb1p2SW94ZUxTbUp3b3VRVUt1?=
 =?utf-8?B?eS9Kd2xWL1E2NFdRUGNFVTgxRkNWeDNTcGVTSkNPVCtiVHpWREN0Q3dqUjls?=
 =?utf-8?B?QSs1bXM3NjBteDR6ZDNCZmU0ZkFveGJCcEV2MUs2cHBqRDQwOHhSbjdaMytK?=
 =?utf-8?B?RTZsNVhOTzZuN3Q2RS95bWlERlN6R1VYYVRGdkUvdjIrTnpjcnBqTjdpN3Vm?=
 =?utf-8?B?Y1ZrK3JtKzVNVmVNc2tZd0lBS1pLQm14RHpqNGlMbkZyczYxSkRTL0dWM2lV?=
 =?utf-8?B?MkhPSnRDQ2dwZ3ZKdVdGZUNtUXBHc1JLbW1BU3gwbUJmaWdRS3p2UitiN0N0?=
 =?utf-8?Q?I/RqkT6OTXauC2ZH2WyV06Nyg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784ecb27-ec19-410e-047b-08dc4ffd6f83
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:35:09.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s0hYxp+rN9QykbEnluHSD0t7KHBJP+xWPc62CxMh7QxdexAtwkQ1FRSzCoXFndRUDFv2SwZBgNCwnauoe5f+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897

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

Changes in v4:                                                             
- using shenjing MULT FIFO support patches, because more clear commit
message .         
- Link to v3: https://lore.kernel.org/r/20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com

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

Nicolin Chen (1):
      dmaengine: imx-sdma: Support allocate memory from internal SRAM (iram)

Robin Gong (1):
      dmaengine: imx-sdma: Add i2c dma support

Shengjiu Wang (2):
      dmaengine: imx-sdma: Support 24bit/3bytes for sg mode
      dmaengine: imx-sdma: support dual fifo for DEV_TO_DEV

 .../devicetree/bindings/dma/fsl,imx-sdma.yaml      |  1 +
 drivers/dma/imx-sdma.c                             | 75 ++++++++++++++++++----
 include/linux/dma/imx-dma.h                        |  1 +
 3 files changed, 66 insertions(+), 11 deletions(-)
---
base-commit: af20f396b91f335f907422249285cc499fb4e0d8
change-id: 20240303-sdma_upstream-acebfa5b97f7

Best regards,
---
Frank Li <Frank.Li@nxp.com>


