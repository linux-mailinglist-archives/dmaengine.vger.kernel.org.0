Return-Path: <dmaengine+bounces-8259-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 681B7D219A2
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 852A4305D90B
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B53AEF49;
	Wed, 14 Jan 2026 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YwobMy7f"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B663ACA54;
	Wed, 14 Jan 2026 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430063; cv=fail; b=Z+s65iL8YqcAJuxMs9teXk8d1kFa4NXwaOYZ8KejZsVPwFZ+yAObOsmd8m/gAwwkwi0KBePY3ADQdQs6W9MQV64gmX9letK7pQFVXPw59vcRtTNpwSrb4aFdEZJJcGr0+xq6+DtGjcRsaD9S1iIHekxWpcoG+pRNsXeXBiF/RNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430063; c=relaxed/simple;
	bh=cbsn3t39yK8of+fZNme1EvQkk7pZNivd62vB+72ztjQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RpjZzWPgPt3czoy1+qyM6+W+XVjrRxYmtjJCdJYp5u6DSMV8U5Ur7lPCcAgQh8CGsQHeT67FIs90ap1XhHuvGRE76xIRqlVZNgjJAoppnan0QA/tN86vfBmKsvn2HZ9bDCkY0BELFhp9MTcoBTYTSCd3t15abS8FOUOwb78ozBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YwobMy7f; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4M1Vg/vIcUX5SbPWrOsi8RxJEbnurLLIXRZPT/P+Vmcl9Lm/td8hgwrbsDKWhiHWEo1mybW4Jz9/lVzRpG6qjmKpAdH8EIMrSdG2N8n1hWm87yzKmB1jPa39RlyxaMTmiw5FCRs74pQxGkL9nbrpE2wfMhKp3vyYTbyb8QVSu4Z7QnngZGRdrjF2MXRgoIf0FmhU6W3w+DHyy/qyo18yNRXaxrWf7ZCNi47Lf+OYzI2dve8MSXl4xSti+FC3cHw6NBgnQIPGeAln4EDR6BCeEP1ze3ldNFK2waMLq0PQcVe+Fz4laBRnheDK/Vg4J5BaGJyp5hYnJ9bkJzXXliAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMM5es72wPxjq0pX8Y8HB5Ao2DVyjs9fhZyBwtRM1vg=;
 b=JXchnZwKzMzntFVV5iArItx9NEh8ahmzEqNA41aFIkjvvqHtzOc1+NyJyjwDjkNhqBd7QX93vXRAc982Bg0Z9LVwiQePoNteNU/xpfJudMmahhZw6dwdlwmOk62ZkbIFwG6awa7ZXMurX+UiCbZr4einr3TjETTdyPhsObxZ0J8RizoFeMoOmzK7n4Jetp63RaxSeHEROBmCFTH3yxSsLHVlD2qIH+EkDtH+f/bYC+VWVsur4KX5pWhns33vyuNqZ/+tpF1UA9vPTtilNIK68oiqJrkVh0RCxguH+ha+sqSDaPjH4AOsNxgARvJL46Vd6GFHZ1DrZDZZt3AnACq5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMM5es72wPxjq0pX8Y8HB5Ao2DVyjs9fhZyBwtRM1vg=;
 b=YwobMy7fI/fH3GZGHG5ZhYHN1nvpnPafE0sStqu7ysfyfSd25FDPIOasrc++QINEdb4pM3dUBlHB8tiNUgSJsqGwc89iYRCfeyFv5e2+Z6n1Nlor0m3L0HFmCOOvzcZvb1WV/q+XtHABZqRlnvgEpCwtkiZ23tUd5PBipJ5q8KN+5PXUqhkSA0RMHxbvO4rCC0v4nXDt68tHMddX8SOgtk4T5v8jlNPVRYBT+8rNc1MHyO2JViXgYtdNFT4mC7Ku1WpvN3XHtrgq+EDLjut1Ia0xMZv/A90rkXBji83/kSaLl/DOsy43+JVUKqqWS55f9XfIlCZQWICsGgVIFhrnQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:33:59 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:33:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:17 -0500
Subject: [PATCH 05/13] dmaengine: mxs-dma: Use managed API
 devm_of_dma_controller_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-5-9b2a9eaa4226@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=833;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cbsn3t39yK8of+fZNme1EvQkk7pZNivd62vB+72ztjQ=;
 b=9Hundqj1jffDOp84XUCpk3wHVSDT+EacOg+a3GSDqxqWWX3oNVkC0GVktxR+mH/3b6sYcp7xB
 1Lr3FMLl+ZuBsPhve5sCqW+TZdafwEe3KCfp+ljvVb+WNcnW8c7lGD+
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
X-MS-Office365-Filtering-Correlation-Id: 5ef05e68-36f3-45f3-04f6-08de53bd02d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG0yQ2NLTFVqY296SHZ3SkMzbTQ0QkpEQzhuK29BbSs5UTl1S1A3SmxNZ3BE?=
 =?utf-8?B?SWszcFgyREsrcDFVbjJxY09JMmZOazBsWWZpUzRMYXAyeHZtK2JpK2pFOE13?=
 =?utf-8?B?aGFxZXVjemR4bXhwK2N6TzVYOXM4NGlTY2NjcitnUklFdXdTSU52WEpzS0pD?=
 =?utf-8?B?Y2N0VFNqVHhZNnV6UXY4NjlrWHpDb2g0YVl5bVdEQ0Y0anZPeW5GOGVralF5?=
 =?utf-8?B?VTFDbUhMaWw5amZKclQrMWx6emQwQy9PQ3lTR3BlUStML0ZkenUrdTRrM2VL?=
 =?utf-8?B?WkNFZUlsdExta0h1RVp6WnR5RUtIT3dZeTV1VktITkpTTEhVbWJMWmZaWDJq?=
 =?utf-8?B?YzVYMUp4ZDZTZmNNS1Rzdmd6QWdoWDJkelVXSFo3dkFneTdRRklVSDZGaTlJ?=
 =?utf-8?B?WC9FMlhmYk9yejZOR1RRTjZsZjU0OWErTXUxUHZaYjl5Yk9TL2U1dzRwb0d5?=
 =?utf-8?B?MS9UamFPQk5SdW5ubWc0a3J4SHVoMS92a0NPajlWZ0RWOWY3NTVSamhNN0pL?=
 =?utf-8?B?bW8zSGJCWTRVcHNoZDNzYS93UHNhRC8vVGFZR1lSMy9uQmRUNXcrRk9aZnRi?=
 =?utf-8?B?MTR3ZFp0b3B1azhzTE5CRHNNcndZdnpUU2VRVEY1VkJYeTZmcVVwQTc2Nndu?=
 =?utf-8?B?cGQyUXVtYy84aTF1ZEJNQTRsUUtRVDJWclhKKzIzdGUwZ1dRRW5VTUFWVXd6?=
 =?utf-8?B?cFA4RGQwMnVEMlAyQnlCdklhVkc5M0dkQmh1cWxKUjVTMGFBbDBia2Flb2cw?=
 =?utf-8?B?QTZnOHJmODJXVlAxTHg2eGhVblNBQnlRZk5xZVpkNm1WMzFYZllZbVpOWS9J?=
 =?utf-8?B?eVVoTFZxT1Vob25aWmhEbnE0TUdRanVqWDFUSjBwQjhFYXFYcGc1UVVaR0t4?=
 =?utf-8?B?TTZOM3U4Rkh2TTJpZDQxV3l5MFZ3VlZJdzNKMHl5Um54UHZtK3BMWFM0VFE4?=
 =?utf-8?B?K0hzYTh3TjRwRmV0UGdjRlRIWERLY2dsUmQ5RFVJRU1aaUNraGxiYkhCSmU3?=
 =?utf-8?B?RUF4enYxNEZSVmN4cUoxSG1zUHpkZlRsbHdTM3dCSlNMMVBDZnBqZGU5aHp4?=
 =?utf-8?B?dUVhdVVmSW8yNnplYkFFSFhYVDFhR3VRTCtUVmZ6Skp2MVZNL2FtdHJXaXVR?=
 =?utf-8?B?K2RqKytNN1NzNmpDL0NxNU5FUFZlV0ZJMUtOOVRPK0Y2dDNFbDByRXRibGhI?=
 =?utf-8?B?T1dDTGFuOW9BWGwyOE1uWHNSeXNCQVczaGxoaEF0WUJxa2JCZmJUbm10eVk2?=
 =?utf-8?B?QnVJS3ZwSFpFMlJxRUhpdTh1SkNxaFlxZklhVUhqbFMrelBGVXBEUmVQck52?=
 =?utf-8?B?ODQwcndNT0hjc0hDWTlVcExhZ0Q0MTJpQ0ZFYW1lUEVjNmt2UnZacnFDb0Iy?=
 =?utf-8?B?T0crUk96Mklib1ZZWmxtdTh5UHBTSVQ5aUFSaVNITlZ4RDJieGtQb0p4M29M?=
 =?utf-8?B?UjlQV0gxeE1OKzFwY3dyZ256ZkdibTFrdVp5MU1EUm1JUnpYN0pTb2VqSS9w?=
 =?utf-8?B?VzVBMEJ4YVhKQUpQdXRnVHJGWDhkVEVoT2o2VFdUSndpekxHTUdjYVNud2J4?=
 =?utf-8?B?UTBHVXpSelFZV0h6bEJLNXQxbHBRRm1qQ21OczZOK1BGQmt4VzRXcDQyaVBO?=
 =?utf-8?B?VjkxcmxuenVhbk80QTJGVEdyZnF3M1FJSUFzelJMREdPQ016Q1lmZEs1eW9F?=
 =?utf-8?B?cFlKb3lNZTl6TTdIL2dYaHYxTk5uOHBiNDExWTRIeFYwbk9vbWd4Q0g1blpX?=
 =?utf-8?B?VFhEY3BzMlhwbEhmK0ZIZ3BqRUU3T21KclFPRVhXcExSQ0xFcVgvTnRjbmYy?=
 =?utf-8?B?Q1hHZldscGx5SEFvWE8wdklPVjJhT0FoRVB2eWRHN0t1SUF1SUtyRC9pNktE?=
 =?utf-8?B?VnNTYi9BVk5NNXJ1TXk5M2IraDdxcEpQSXRXUUkydFFqeVlPN0k2eHFtcE1E?=
 =?utf-8?B?Mldac2pzaGJZTFRCd3JXSTdKaTkwNS9sZ2QybDZXMmtzcFBNK3R6elI4RThU?=
 =?utf-8?B?VlZWVDdwRlhOTWcyUlBBc0VjU0V1Rld4c0hQbUR1WXBmSWdyL3MxdlFCbGhj?=
 =?utf-8?B?cUw3SlVpTmxBbkNmaDBpVnhwUzZMdFFsQlV4L2dsSHFSWHdSV09ZMFZzSzZK?=
 =?utf-8?B?dDdUdzdiWWtGQytDbE02NkRtSENZdWFYemtCVVo3RktDeTJUMnU0RGxrckZW?=
 =?utf-8?Q?Ue5sJIoQF6ghGGGXlTg9S9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGF4NW9YcWJGRlAxN2Rqc1BCRzF2cVdudzd5MEdhaDczS21pMGczejVvRnR5?=
 =?utf-8?B?MUlia0QvNzl1YzluUEEyVTMyOVpTTmQ2NHkwaGczT0xnK2hoMFpZUHFEeEh5?=
 =?utf-8?B?RHZoR1VSb1k3aEpnTmh4Smt5Ykg5ejFuaUo4bVEzeDZYc0F0c1dCaGQzbDMx?=
 =?utf-8?B?My91cHdxcFBwVSs4VnYveGc1VXplRjA0R1ZPV0RHWTV3YXJKYVdqVGhkTGFo?=
 =?utf-8?B?cGYyT0FlTHB5TVBJMnZiWFB5eExKNm41OUJxbG9DdDIyY0RLbGhWam42bnlU?=
 =?utf-8?B?cmZXeFc0SXhTOHkyYXZRTU5QbTZ5R003dTgzcElHTnFJNlpUbG5hR2szc2Jl?=
 =?utf-8?B?d2pmaUZEQzJSbHhsSTlMWDhoRG9pTDJ5MVNaMldEcGZjeHRoeVdDWjlsQlBn?=
 =?utf-8?B?ZXZkdU5peno3a0ZVTmdlQnpoSGhLeWxtR2VrSnhlUWFkSGtSVVpvOXRKZGlK?=
 =?utf-8?B?WEx0dG9pTFdKdEQ3Tnd0WXJRcHg3Yll0azVFUERvTHRWVjQrVzgybnRnZFhQ?=
 =?utf-8?B?eUlMSzN4dTdHb2F4Si90cjVGNzc2YmF6ZGd2VzlzRjZwcjk2THBENDFjVTlK?=
 =?utf-8?B?NUVrRDE3NWJuVFRDdm80L2l6V0k1eUREUzA2STZLUHRrL09pVitzcmFlSHNZ?=
 =?utf-8?B?TVVPdVJQZUFWT0FSbVZGd0gxU0ovaEwyS21WZmxZWGhMYVdhS2U4NklPMXNj?=
 =?utf-8?B?Wi9oNkpML3BHNXF0TWkrZDZkYVNiajRhU1BxZE1ob20wbjdOMnlWZnBhUktD?=
 =?utf-8?B?bE5CazhWSEJjekVqQm5YRmMvMjJoUjY3bWx1OFBKdmtKeWlWa1ZLR2FNcWZs?=
 =?utf-8?B?YXFWZ0tZQXFOQTNPallySkVLRHJNcDlIUnljYW16dGpGcTBBNSsxRHdzYmpQ?=
 =?utf-8?B?azJSd2doc2FtbTJrai8rWVR6N1ByNit3OVVvWlBZM1ptOVB1VGNCWXMxalBB?=
 =?utf-8?B?VWJNQjQ1eWJuanQ0ODlsOHR4N2Q2YWRFS05lMHlXNXlSVDNJeE11VDMvai9R?=
 =?utf-8?B?UlcwU2JFZTRvaWV6M013VWNqQVRFNUh2OGxhZHV3emw5RFJ5ek5nTklJVWIr?=
 =?utf-8?B?QW42cHpldVNjQVFHdVBrb1NTVkRHajhYVFViYndYRmhFcGlTUUR1Y1ZqUFdC?=
 =?utf-8?B?TWhOWldPUkprTWliYXh4OFdyRFZMQm9xTUo3ZEhXZHZ0WXVxeDlNV0xwOUlI?=
 =?utf-8?B?UDhBWmRyUUI4cURSd3pKMkpXcktVT0pFRjkvdUdqMkxycVV4c2FUU082OGhw?=
 =?utf-8?B?ZVU4eTc5cmt3RmkyWmpnK0dYWTNmbjJ6aGNwSW5NcDRLTXNIREVEWlZtTC9x?=
 =?utf-8?B?OWplMHhPTG1RRTJxczB4MHVnUDJqOTc4dml2cHRQc2diRXNxWUMzRExCQlRi?=
 =?utf-8?B?TTNuT1Z4WE5GVFJlcUtvdkJTZFVrcmZ0VnBlNzBoVjU0ZjdxM0tmZUlzVndT?=
 =?utf-8?B?SVRjdVRIamZpVlZPSnF0Q2x2dGJZUHhoaDBjWExIQm5hREF1bk1GMUs4eTA1?=
 =?utf-8?B?dElSbnc1TC9hWWdFRGJaR25jOTVEUFFMa1JVZU02aE9EQys4Q3lLZ1JQUzBT?=
 =?utf-8?B?Vnk0WTN2ME1WTjdYV3JkTXFyQ2dhR0VRVVMwVnRtY254WTZnNnZmcVFVUUk1?=
 =?utf-8?B?eTEyT0w4UUhQSjdINUhrazlnNHpXeFNqVE9OOHVMY0FMYk94NGlBWGNLV2gx?=
 =?utf-8?B?VmZKVWozZ1dBeVNlUGRwZlFIVnFzLzdKYTBHTGpib2dyZERBeWZnOHlQbGhM?=
 =?utf-8?B?UktGaU4rM3FPR2xwZUV5MW1vdmVVODVCQ3N2QVBmSWRVU1VvTlRTdVFOaXVD?=
 =?utf-8?B?dFk5L3VONFBnMkwwZWEyZHRkdDNrTTM0b29JWUVJVTVXZTZzd2wrMi9NQndK?=
 =?utf-8?B?aEpYVnAxanl3MnZ3cGNwL1lpSGRIbDNpeTZnZGtSMFRaSE5KSHorUmh6NlpY?=
 =?utf-8?B?WEhIMm5aTVRFUm1GS0NFaU1YNWVpMytneTNJNUdFL3FwaUZxak1KbVNvNXlx?=
 =?utf-8?B?R0VtSUEzb0dyMEFrQnpGcmNzV3NuMVg2c3lqeGVDcFFTZzBRSUhxNnIrVEFD?=
 =?utf-8?B?bHFWSWJqc3BDU0R5T0dnUTQ2S1NRU1h1WThuQWFBMlBIUDM3R21ZbTJ1SEVx?=
 =?utf-8?B?K3hQNGMzK2lxOGRzZmtGakNKMzhqKzFiSFB5SVYvNTRnbFU4UmlTQzdhbjVo?=
 =?utf-8?B?MGE2TU5SQ3M2WEJwTHNpT0ZCTVZuNDR6cTNCTmpIYXBFbkUwdEZ0Nk1ZZWFV?=
 =?utf-8?B?YXFFbXMyR3NFTWx6RmhnS043ZjM3dDFzcUxJYmpmNk9VbTZxSXNqRktFWHVh?=
 =?utf-8?B?Mjdubk9KZVQzekp3UGp3aVVYQ0NWU3RYLzhWdzYrWWgzaXZKajBHdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef05e68-36f3-45f3-04f6-08de53bd02d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:33:59.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaBCsmDIOzvNwOqttiuyRZaY3Zj+QsDzEIEKWmVwKSmgVm+A0yWm8Qm41/MxDD7hw5CZKcctM7BYaKXeTS82/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Use managed API devm_of_dma_controller_register() to prepare support module
remove.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index c1d4c6690df1af476aeafe77ff7f78bff1e413f1..e047a41a8df2e84e0c68b112f59cc79c0ab84491 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -817,7 +817,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "unable to register\n");
 
-	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
+	ret = devm_of_dma_controller_register(dev, np, mxs_dma_xlate, mxs_dma);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "failed to register controller\n");

-- 
2.34.1


