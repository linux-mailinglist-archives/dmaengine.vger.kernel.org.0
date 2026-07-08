Return-Path: <dmaengine+bounces-12128-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W7dKB4+YTmrOQAIAu9opvQ
	(envelope-from <dmaengine+bounces-12128-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:35:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5747298B6
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:35:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=hxd7RyM8;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12128-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12128-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F8F53008C8B
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A254C9011;
	Wed,  8 Jul 2026 18:35:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E44C9001;
	Wed,  8 Jul 2026 18:35:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535726; cv=fail; b=Fuf2zCekUQsTSn6Kb4gCvGTqKck4IfkguAx5q+1toXB5Wwn9hMBSKl98mZObS3M8TUGxDqVgnuT6PMQ9+2OTx1QAsWF1dMCsZLpiT5RMgoipqpVILOXgdHpDpP1tQs54BVKQui+IYbhGbwim7RQkcLklOC76ZmrVbK5Vl8ATKRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535726; c=relaxed/simple;
	bh=dUA/HZPMs5/Ql7dQJedTKkC1RTUFlgxfsWKnsGCaDmQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jC7X+LuEpmeo4Pc3xbABOUFZVZT9JAFsBAIO18rBK6PQ/z5A/RkjN+TufXubzD4I6zoG9+tV+BSBzLVQsKpCJjx1hWEbNy75+ojVyyPnrPfgZotHLtx2wxBz2GXP1NxyhnmwxDgQ3hMarFLqriIybVpXeo754rmeAggSfECGD10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hxd7RyM8; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoVmptLRH5tgRoiVvZofYIAY4/MkbRHcEd5Dud24NhuPnmdyu+3po/KXrA3d8Rs/iKb9M4fCvLxkNunpr7ID4NfroNZ3FK4lxDFSjV/PcTnS3rDCUaalQgymKtLYYeREuecrZ5F1Lop8cUBqhiPmiL2qvEC/RoXhJh9RzE/U1NUBjlj1Gk7IMoPxj9B+5/8X0Dk/tMqI8M9+XFsX7tXQ7fgpeiw3skOkMI8g/8dpY20JJmSskbQNiSU9iL4lDlQQY5kkIn1njVKeAn80CLqrIXzeiADMD0o8VjXhIqz1ldjTNXvjS1kFobpZxRLTIoJZq2WKeUmK2tYmWxmF/AsVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=;
 b=XDTBeulobou/RYNwgYtm2XJeuxufrKzUsDKQPYanI+HU/Q/UQHKafxHAANu8St86a60GqOeGga6jk74y9UJO/MGWbQ75dx4EexoCG7JAr++aP7wXANJdtR/bZbk+QJoOmD2W2nRrr9Az4KM/dY4vEUD/efaxZFPWYo7PVD2zFHYGaVwUkOb8eJHuOwqZUxIcgVFgWKAkaw8xIjBpOK6MJwKJT8zPdtkMYeVaxRlfsQVyiKzyjPsaeKYqk9L+m5y7KAfyL1KtQJYq4cxhHkeg91QiQzUzydwl8MBSkDN5Oiom/mZlD+L8LB8tyWsGc9tnc8zWY93Be9tmxGiAiWHnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=;
 b=hxd7RyM8KwK8un5tIOxmzf2P0AXLyjA8UtvHZiGe/NWrzbtp5yTNkMYtnjJdYqhGLmaW7s5hLHC6ngM2Pz1NwEFkM96PM2FAAg+GJzJJ8bp+ReQWzD4pML+4WPz/0aNOhGTfFUozRznHnQGHCLfKTRVHzW5lJJCTVjbnskeh9kFXRCaMi3QNDimoR5E3MEKyCCe6beyJkscHHiCb/d4aL568wChAfbkTSC1MwdHF6gtZLW4vZ9JcVHcULp1oE+d9dTx8zays28xxK3K50lNIyOFHYfPGI2l2+tW2HoKoT6CVxFQIz6vyH7qdnoPHlWo4SG7KV4NFmYnwtlSu/v6z+g==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:35:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:21 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:02 -0400
Subject: [PATCH v4 02/10] dmaengine: dw-edma: Add xfer_sz field to struct
 dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-edma_ll-v4-2-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=1765;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AWFd01V2qiIGFrrfkjJThL7/BfhkdZY8qigjsjdbG8M=;
 b=JvK5VPPJSj9Pvp9xZ41a75u9rEzRmXUZ5k0ZcbWBxIB62qNy3tNdN2KbGvwinLUxLsZ75uAbI
 gd/0PiTQCWLDlci3amJc28mDtwU0AZE9BtIRBwkrOOsDws8niJqCqYI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:806:f2::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb94a4d-75c5-49f1-f720-08dedd1faaa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	3+n4lMHJNVvrVe383XrFL77GXWMIecmNJynN/CIwhcZ9I5KIo54rjtvRn05+dwg/ettYo9EwfZYhJ/yvPYEAv/sXYs1L8cC/6EZ62gzk7c1vyPQ7lQ1wFWH1ygGt0GsL3j7ZlxkExzdNpLgv+OMLZrCxPGzc2JTH9ciRIJj7i687+fJKsQVjLsYLMaFlYcvDIrgBl4nBIs28/fGKVTSCO2VSS7v67soc4pZXJpcIQskQ4YOYeXTqURH8vjTcGfNjnkWSecY8xwiVsHlsI2fvCOAM3TGBE0vA7U1woq+D5tqRF5KlFhx8/ody8h8V3XzlKPIA8+HpOWZE8mWTI6CTMn3653/dlNxp5yOzdD005EtyDw36OwvbaYI2RHiLv9RuaDJ88Medu/5tPlif6rbyMOWrz+TG0nZXtAIbwwWxlQIP+29YVipzG9wrXmsIIzzxOH91KAUjkrGe7znoP98PDS73oH/l0kYKPKIabCcJ7MvnyRil9lZCB5eLSeC29tgLzOUSJLL8rUu+M6EMwJxshi0ScAgDfVPJNuvIahmGDXmRcqxHf0VQW/XBj50/F6AMdwcYy3HQCUqnPyoLlpZmJrE6mVn5TCv+72aqbkBjNUALF5f9uASM4z9cl/WOmdUy24T9f2iFUXxciK0GeVefV2K7cN0sjSBsv4fDRG0tohdcmmedrxnWjxB2/F25YDY9L6rOXIY+wOPQvGOotfK8Ig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1NnTkxwTXdxc0h1b1dSQ002MDdKZHhMQlgxZGgralZuUXNyN2g5cCtCdUJG?=
 =?utf-8?B?Q0NwWENpSjExcWlmdTZHNUZCcGNnRkxHUDJOWTFTdEdSTzZXMEhFc2J6OXFz?=
 =?utf-8?B?elRUbHhnU0FGc2VhcW9aT1o1VzRKWXRUcjdBeUFUb2F1c2IrTDc5SUtnL3hB?=
 =?utf-8?B?QkZ3NERaMXI5Rk02Sk81ZXNuNGdicWlEQU1EcXdIRW5WZzdKeHp1cjF5Tk45?=
 =?utf-8?B?ZFNXeEpRREhwcHRpTEw4dVlyMVNqckV3M2oreFg5MGprS3o4ZjM3OWVyTDVV?=
 =?utf-8?B?cWpINGJnSHYvd3ZqZWJ4c3grM2ZoaGc2cjFhOEVTZkNmTUhVN3ZXYmJweDg0?=
 =?utf-8?B?bjY3Z2dMcG1NVmUyeWhGd1NSMHhzQ0cxUWZvN2lFNUFzdi9YNmpJTFpXTE5u?=
 =?utf-8?B?VlFZME1pVHFvSEtvTVZOemZ2ZWc3Nk1zVlFmKzdzTWdoajV4VllXSzBKVzlM?=
 =?utf-8?B?U2trMVhRVjJyOVdsbkQ4clc4VTlYRHdzbW8zcFBGa3VMQnhUV2hUNVVmcjVn?=
 =?utf-8?B?SDM2LzFpYWRZZjZRUG1FTldGd0l3RVdDb0lFdjM3b25qbW9uMklEN0dxRkQx?=
 =?utf-8?B?WlRqWHg2R212OEJIQUFJOUE0L3Fsd2R3OGt1MnNReitmZGdqbHdNNTZiMDNx?=
 =?utf-8?B?SmxudXdVdTNMZmxOV0RsRlBNZWFTQURWdk11eVpUR3dZeGFNMzhIa1ZOU2JC?=
 =?utf-8?B?ZElkTVlyVkdNTHIzbFh4UzcrMWFyU3QwRW8vNHh6Q2RvcDNzOU1pYXRYTnVP?=
 =?utf-8?B?WWsxaXhVWUtCNTNiVFREeno4SW5kY05yNFhrZTNEeUgxMFdLUGdqbUYvYWp0?=
 =?utf-8?B?Szc0TWt5dzl1V1JOc25GSkdZNWhlTGxwNFJWQU02aVM2N3hxU1paVHFxWWVY?=
 =?utf-8?B?ZXBlM0VuTExhVHQ5NHYvSDdJVDNIcXNLNXd5Z0lRZHJwTmQzQWJsS0ZaVEhy?=
 =?utf-8?B?ZWlUVFZnK3lGdkFRRjUzN3pXSGVhdXpPdTB5Y1g5cVQ2clVHY2Z1aWhrUnVU?=
 =?utf-8?B?YW9jS2R4Z1lkczJVRXRIUE1xa2xVSTBmeE1vS2ZHVjh4aFZYMllPUHBnWVRo?=
 =?utf-8?B?QXI2eHp0bGZSWDdQY0lzSjMwRjdOZ1JaVmRMNWdVUEZ2TFAzN2VPdzVTZ2hS?=
 =?utf-8?B?TU9aUmhuS0VGbDZLU1g3REl6bzlpd2JZMEQvcGRReUUwcER1amlKM00wTmVM?=
 =?utf-8?B?VUg0WEI2RDB4QVEwS0h4Zk5SdUg3bFloWFc0YTZyc0hCa1RuWGJBeHBGN0xl?=
 =?utf-8?B?RFNIaUs1VEFZc2tlWmcybDJyYVJIUHpOYklKc0swWHRpckF4OWozNFY5Wmc1?=
 =?utf-8?B?cjY3cWk5TDl2eW1valZwZG9WUUZ3K1hBZGRrNzVBL1liMHJHNEUzcDRtMC9z?=
 =?utf-8?B?SVIxc3dib1RjZkI0OUhrTmxGdlE2WmxvQUZNbEUwNDZIU1RQM1hxMUZoRk5N?=
 =?utf-8?B?cUQ5RlYxTUVUS3IvY2tyUUJtcWVQdlg4bW55Z1Z2d21aTnlZWUU2ZDJ2NkZB?=
 =?utf-8?B?ZnlCTDlWdFJLdndkVURKTFhVZnJNS01jLzBIWGMyb1h1em1OSG1WK2ZTL1Bz?=
 =?utf-8?B?S20ycTNmTzh4cTMzU3Vna0szWU8zc0ZPWWY4UFBoa1p3N1NvdC9tald2ek9L?=
 =?utf-8?B?UG43bUduQTZtMWJMNThGTjBJMUFMOGU3U0lwNHQ2ZHJuZVFneUExRG5vSUdE?=
 =?utf-8?B?S1dLSmlGdm1GaWNjaTVZamhGRlp0V0txM3FGY2NHTENScVI1QkdlOWdtVXdV?=
 =?utf-8?B?blVmd2lFbFVEWVovQUZEKy8veWI1dG8yazZFUzArR0k2WGVPbVFFbFBpZUht?=
 =?utf-8?B?d2FhbE5yQ09uSWVDQ3JqTFNoeWQwMXdPZjZCNkpUOVdnLzdncGhxODQrNGFP?=
 =?utf-8?B?QkY4OUlRZjZhK1ZVdWU5aGFlRnJqODZRSzJsRW1QVkJBT1N4dkVIVGZNU0Ra?=
 =?utf-8?B?NU4rZ0FuMUQwdzNjTDN5SEJ4cXBMenRwTHB3NTJ0NVdrRi8yZnRYamlVN0xR?=
 =?utf-8?B?MjkrdnJ4REVIQTNyR2YrYmhGMXB0YnFtNTFrWVJWWTBqUkFqZWFScWpPeXAv?=
 =?utf-8?B?QSs4QVR2NVdGbUplUDNuWTQyT0tXWS9ZdmNZS2JVMndnMjZQQWdlR25BWU1H?=
 =?utf-8?B?NGpXUm12UGpkRlVpZXJHNlRpQXRrRnFWOHJnSVV2WE9VcDNFK0ZYOUcxdTJX?=
 =?utf-8?B?ajJYeDlhdFd6Wm15RFcraHdsRy9wTzRKOGNBV0V4M29VSVBrbDhqLzlRdi8z?=
 =?utf-8?B?OGZRK0d4SXJpUnp6RFYwRmdmcTJTVUpMZHNDYUxUVDBOMXlXT2ZmQ25aRFdw?=
 =?utf-8?B?Zk9aN3MxKzNBZWZRTmdoV2tvOGtVUUtXNHdWY0MzUFU3dldkUVJ0NTZnbjhk?=
 =?utf-8?Q?iI6A25pjl1MEIUnn6JfAwLPO6aDFCkiuZYarp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb94a4d-75c5-49f1-f720-08dedd1faaa9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:21.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTUuwb/z7JCopY4F2k4ry/eHB4shxjmcAfzh2FOcEdXrsIbtffP5PiyEV3d1TdyGch/84a3rWM3jxm6utzKCO1HhF22zn7SFpi4zPQ1xjGcHIbUxmkJL7mX/K3djXdGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12128-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD5747298B6

From: Frank Li <Frank.Li@nxp.com>

Reusing ll_region.sz as the transfer size is misleading because
ll_region.sz represents the memory size of the EDMA link list, not the
amount of data to be transferred.

Add a new xfer_sz field to explicitly indicate the total transfer size
of a chunk.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
 drivers/dma/dw-edma/dw-edma-core.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1fec1b52e3d47..53469c8c8b82e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		return 0;
 
 	dw_edma_core_start(dw, child, !desc->xfer_sz);
-	desc->xfer_sz += child->ll_region.sz;
+	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
@@ -527,7 +527,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->ll_region.sz += burst->sz;
+		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 6474cacf71953..db5f45bf048c3 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -57,6 +57,7 @@ struct dw_edma_chunk {
 	u32				bursts_alloc;
 
 	u8				cb;
+	u32				xfer_sz;
 	struct dw_edma_region		ll_region;	/* Linked list */
 };
 

-- 
2.43.0


