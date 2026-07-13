Return-Path: <dmaengine+bounces-12411-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V7HjDB4cVWovkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12411-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:10:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E12674DE29
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="wGEPzh/X";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12411-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12411-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D5030E69AB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CDB3438BE;
	Mon, 13 Jul 2026 17:04:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119D345CC0;
	Mon, 13 Jul 2026 17:04:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962261; cv=fail; b=fJUQANBsw+iidXb+y7xW/aE/Qy4/yKxT3nhSvz44zb2Xy/wZgJIGdP5oZamhT77Qi6msaTu4FJXmjcm7zwTGboAPDJVWRnETbMHFFEl7IfBOHYkXFHcxcugmqfMQSaApVYaJjecatrbnhci/7lULENyHNsrZWfyJdeFT9P1ZJBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962261; c=relaxed/simple;
	bh=/p7Ls6GXsbzHlS5idKFDnOz/BFiaIx7ZQzoJmjUaku8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rUnRA/+AHm135CaKyZGeSYD+FhvuHOkIC9L6O6klDX8vDztYQKu2CK2m7F+nYUamDR6ZxRwQ1fTU39XSCUPJ/fSggQGYwaQDi5mG0KzFN8MDoxVZiF4F/flT/WVk+qvMp9ayo9h25G31FF2M25hXwFrrkptBr1bjsh7l0WVgQao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wGEPzh/X; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZGKOiiMWDElvx36WRgxHoltSvxsDAd0Shp3PTwZJ+DjQmS+y+ahomqRQ28MXlGAxbC/TqBh1TYVRs58MOwhfyMZn/dZ/CyE/SEsH3OQRpdnc1AyQoR80a0N4hXtU27SbaLMaZtvdkbtty9/JqoaNNLMKpN4hM+qG971GyuXjfY01EoLTVOzfPw384y+XypWjNz2+pVaJTIMZ8SH7MSOPLGr1bvgrbTRRZ/jUxDkmOIm4sU1UVWMA9ZgLZ6CAxqndKBXiXgpJ1BpvoGeMFQyDhc43NC5W6uTh+s+WRrJT312EE2VDEDS9Vpf31gS1VGEScI5g9ItZlLJetqr3ZFlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k39UjNLpTNRT++ViwFZSjHu0E8BkJ2UyIvgH3oKd2nM=;
 b=pUVMjazejaJf/p39D6ldekyU7Q3+b17XsPoHLPm7fHxbBOOlDXYxSEZiN7yZ8rT+zoL8khQJozg1eYCTTiOuNHsXkcVyaM9PKC9dFiogIJhydpWmXxElUQOij4r88qMYObNDrUSQf14vjAGmqPkDHe0+thchJjBb3HyQlGde2iA8C332AkHId4I5KUxaPzPPosni1Fbzr3FcagOy5xduHwAOYsDymuHS4JSQnr7mS/HPJknl16MJSu5g3vcWPHYq6XHbe2zG0+6sg6Ci0X42d0rQl6sO61XkggCZU5tPWUWwyStZZjkONuMsGayI9A4mhr32xddL5VDeMm2YCDSgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k39UjNLpTNRT++ViwFZSjHu0E8BkJ2UyIvgH3oKd2nM=;
 b=wGEPzh/XKzvUkyAQQbmD2s0DbkuOT+sssCtDyJEv7Y3A2xcqM7TEmqdof5g8AV895Cl35dASVmEcZgDimMbSYkBiLq9RiSGXABwlEQeV5RtYr/TlI31tNVPzVvT93ORlOifWFeBKJAXewlfwXadI/sjAXbpZ1g2Ski3kyEusGUXNDCS6Lq6Ebd/BWPfh2jHTb9rayeDTGAZTJAzEJLfWXtNsERSmBxH8y/w9HA3DsxJpqJ+NGDSz/WYUF+2a8HOnvTPb95zKnRT/FMjH8JvQaqdRcnnrWKIE6s2nyDH2ouC/PpycSV5sTenmpt5VaIE9+Vvxbi7CfYa/ZNMrMZGndA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:04:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:04:14 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:28 -0400
Subject: [PATCH v7 10/10] dmaengine: dw-edma: Remove struct dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260713-edma_ll-v7-10-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=10731;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NfjrY/HC6ctiP8+xxiriX9kp/RmMZzab/DIIn/ObVZM=;
 b=t5kBy3zNJfZnd0b6kxy83MtbFZunYOYgS0rz3cVtuZfMzoKa6MqfbCMEPzfBIcwmxOaDZOA98
 XJLLPpS2+U5D7mBPw3kGXslsY3I9aZyPNU848z+97H8rwXmkZ2jhuy8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0223.namprd04.prod.outlook.com
 (2603:10b6:806:127::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1e07a5-e460-4e47-19e3-08dee100c422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	BFYTWsPc2atPcsz/Mb3T/ha7crbOYD3lBjF7daRomJCjJLvPjSaXY45W9BcFGLwb5y3E4DRTgfSMzg471tDa/Fnd5qkX38/rm6biLzSu1X0dVEgS6NMO3XP9kbmo3CO0uL21eS7ctckPpLzzaRbxvx6E2vFDjxbq3x1dBjK78jQBlLFwmb3t+d9U5fw0A5Bde3PPrhSbj28pHDpVNiJu93aEExhS0BRj3VvNf+7/oW4uM2kGOCyygYfeC11GYv4nyhu8VCEywmsLJGfDJJK5fcuDA5O6B+N9yhbqoYOE61JITBJd+CXUSh5FWa/boq0CxBSOOajC/+QUpm69RMOQKYSzcv+/dt+014wBWeQ4YcxkKBinjP1zdzY7hBCTeEqS2ITQgS4reZh46LV/yTZVW8sroPMw1mRcApxtVe5WKVokOrBuQ39FlTzPq5LZEQ2whuoCD/c3ClZFXtPNLRYd05JdwzQ6Q5Qa6vvi8PXcIc+9rmIW1q4dRZLhbZV72o+M0zJWV4vJPWGqxRvlNhBLQAh5zqs1sFQwRICoLdpuuFqFsndLTv+/IPfblD2IiUYKIqrh6opSFqJ6hQhBd9FVGLlVecCmAGGwGKy8rYYRG2YFYzpYYrADze95DGvBbIIS5xQB+9yYGx1V5lK3XfQ6GeTbLCs3HZ8m5rmKnYjmyPjI1UGzJNj8IA/I5GElofWuYN1fJ8Kz7o0rTApcGoUL0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXc2UFdvWkhVRGorZThYN2ZXQ0RYUkk1ampkKzNEL2ZZUUo1QXpuYWpqYWxI?=
 =?utf-8?B?Z0NHNHhJWTlXVXRPMFIrbTRHVENwSy9CMmpZT0RzTGtVOXlTUG94NkJ4dlAy?=
 =?utf-8?B?blkyVElSV3dDZTIrZGhMUzh6cm1tRDJobjZrenBwRWFqdHRVMWNNeStGZjY0?=
 =?utf-8?B?WlZ0T0dxTm03RG9XcnBDZHJ1b0ZGQUg0L3FKZUd5K3RNU1M0aFJZa0pra24r?=
 =?utf-8?B?QjNjd0EyWjdodmNLQkhpQytBRVptOFJZZkVxbXBvSXhuNC9SaVBlNUc4YVpt?=
 =?utf-8?B?WWx5VlhUL0t1VUNHaXVOVmc0eklKUndvOE9uT3RjQUVKTjZ3bitkNzBvak93?=
 =?utf-8?B?SzlScUpwc2J2Z1dPQmxhM1hGRE90aThkL0plNFZqOXI1TGNpeUxVZVdRNTNI?=
 =?utf-8?B?NW8zVjczOFhKMXdsdjh0YmFvS1hGL0lnbW9SZlJDb2FMbHU5LzFvaGpJZTdF?=
 =?utf-8?B?YURrN1o4TEdhL1R4dHg2K1ZrTXA3VkRuSFdyMkMraHd2dzQwWGdwS3hHV0lP?=
 =?utf-8?B?amFla3FRcHFmZG9lbU44Y0loUHlCbGNsaEFNVzBzYlk4Qm9TRjlxd09jOFF0?=
 =?utf-8?B?YTlUckN0M1B0ZkszZlN0WEdFSXAwS3cvNE9yR0pwK29VR2R6RWwvN3RUL2dS?=
 =?utf-8?B?TDF6aituZ0hodEFod093UWVsRU5NOC9GRmc2dTVPaVBwRVVhcnAvUjVsMTRJ?=
 =?utf-8?B?aXRSWmVTTGtYTXhZMDlsMC94bXNCanBQbnNxNXdzSEhaamVpbzdUWXRpMHBp?=
 =?utf-8?B?UWdvUzVMN2V2dndPL2VRbDB3Mkg1Y2FndGxObThLcHFIbmthaUdyWmsxa2Fo?=
 =?utf-8?B?SlYwcnI1TnAvTFJWYXdYQVdlbUlVMzkzMmlWbVRoMkYwWVRSK1VvYTJDcDRL?=
 =?utf-8?B?UVFCbzFCbzhmOGVEOXhGYm55Sm5oUU93eHNOZkIrSnZmemJMcnNQaGlmRU04?=
 =?utf-8?B?bDlqb015c1UwejVOUlFyUFhjcTdpS2JmQmZkRVQ3NGRGQ1RMYS9zbHh5OUgr?=
 =?utf-8?B?SnF1U2xiNE1PQ0pNdTgwR2s3YTNQUndja0lRQnBuamZOZVpmSzk2eUdjNk81?=
 =?utf-8?B?Z1F6cW95MEhac3E4TlNUWWd3Q3RSc3ZvSmRBbmlsWmR1UzdFVDRjb1NKSmdz?=
 =?utf-8?B?WVg3eHVmT2F1S2cwNGc0MFVoc2kyRG5jdGx0OFZOeFMvQS9KUDgxalZvSGdr?=
 =?utf-8?B?UytrNzRYKzJaS2pPYXFialZFbENaMlZGMm00R1RzYjRBaWRURXNIbmNrSVlq?=
 =?utf-8?B?RW1DR1N1YWNCVWI4ZFlBV3ZONWdjUUhHZXdCNnlUbjhRZytrcjFKOSsvMHBW?=
 =?utf-8?B?V1FKekRMUUNMVVFrU2JsTDRwS3JGbHB1cTFIS2NjSVN6SlVkRXhGbjB5RUQ0?=
 =?utf-8?B?d2tQM3dXOW1DK0g2WnBDWXZMYVFISThRMFpKeEpVNTMyYnkwdmhYTWlMc0VM?=
 =?utf-8?B?RDVacm5ETFBxNkI0R0NzSDNOblhVQ2JDR0s1OEVpajlUUHlSWXF1UXMwVHRN?=
 =?utf-8?B?WkpvbjdIM1lOYkNCelN1Zkx6NEZhbGhBNW9FcWZEbURiUk9Ja2NXc0t3R2hH?=
 =?utf-8?B?dHVQQXBQZGVQZmlvNWwvWWZvZkVJSm13bFFHOUdpaExwWXErTjFCLzZ2Rkhh?=
 =?utf-8?B?dWF4bDBGVk5CQnF1TkFSM0NycUVvdFRaeFEyQlFSaEh3Z3pVVnJScFMzQ2dP?=
 =?utf-8?B?dlY1SWF4MzM1R0c1QmNxRGgyVy9vc1FOdUZTRXg1QzhscW5nNHR2ZU9nMnJH?=
 =?utf-8?B?SE1sZDJ3Wlh2NHNGbjk0YXorL3duNUpZZ2RwSkxzMU5lLytMSXlvZTFkVFph?=
 =?utf-8?B?c0g2M1pwREJyNi9jK0VzQjN1VFEzdE1OL3hYN3hzUXAxeXUrczRCYk5aamVR?=
 =?utf-8?B?em9GcVZGRjlwd0Q2K0lRZTY2cDR4WDdiK3orTUxpMzFXUDdiMm9zV2Q4d2pY?=
 =?utf-8?B?ZDZLRzhDQ0lUNk5lSjg2S2JTaTd3N3pFMlVzMFQ2MnZUaTZTQWsrZXhmeVhS?=
 =?utf-8?B?bW1xT0JiL2RzcXhLaVNBbWMyT1EyYVZQWFVBWDlGeWVRREFDZTEwV3QwSGtJ?=
 =?utf-8?B?QzZRSncvVnI5VHlzenFHR0tqOFhscTI0cVViSC9EdVlMUk1FYVcvdmlRU01o?=
 =?utf-8?B?L2VCR1QyMndaODBvMk1xUVdJeGJrcG9FcVJVYmxodHRVNkFyWTQ4ZjBHU0Ny?=
 =?utf-8?B?NGZ5TXdwdy9ialpyUVJndk9VMFIwREd6cENqUFNONUxDbnRINy95cGpFMk5M?=
 =?utf-8?B?SlhsSE9BMDh3NjlCQUlPMXRZay96S291YTZkT2FHY1B0WGo2ZGtpckZUOEwx?=
 =?utf-8?B?K251eUNlS1dqellUVVl4bUdUZTZXWjQxUmxQV1NMQzRSbWFsWjdqRUNJK0Uv?=
 =?utf-8?Q?4sexhQRsu8yGmQzY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1e07a5-e460-4e47-19e3-08dee100c422
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:04:14.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOAp7aCN4By5f3kEOAIj7VytDZJOwEgOfEhandYQp4ilNVDzquK6lskJfsEj7XpjIIQWXO5MjS5f4/R+BFXduec/AcLol1EcGxnTmye8eL1O2H1GiAha5eq0iw2VqKuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12411-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,valinux.co.jp:email,nxp.com:email,nxp.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E12674DE29

From: Frank Li <Frank.Li@nxp.com>

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst[]

Creating a DMA descriptor requires at least two kzalloc() calls because
each chunk is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, this linked-list layer is
unnecessary.

Move the burst array directly into struct dw_edma_desc and remove the
struct dw_edma_chunk layer entirely.

Use start_burst and done_burst to track the current bursts, which current
are in the DMA link list.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- use size_t for nburst, start_burst, done_burst, to fix sashiko report
integer overflow problem.

change in v5
- fix double substract and done_burst -1, found by sashiko AI
- remove unused field chuck_list, xfer_sz and chucks_alloc, found by sashiko

change in v4
- fix loop condition check in dw_edma_core_start(), found by sashiko AI.
- collect Koichiro tag

change in v2
- remove debug code
- move "residue = desc->alloc_sz;"  in if(desc) check
- keep inline to avoid build warning
---
 drivers/dma/dw-edma/dw-edma-core.c | 147 ++++++++++++-------------------------
 drivers/dma/dw-edma/dw-edma-core.h |  28 +++----
 2 files changed, 63 insertions(+), 112 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c028011cc61ca..30eeb7bffad80 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,82 +40,54 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
-{
-	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma_chunk *chunk;
-
-	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
-	if (unlikely(!chunk))
-		return NULL;
-
-	chunk->chan = chan;
-	/* Toggling change bit (CB) in each chunk, this is a mechanism to
-	 * inform the eDMA HW block that this is a new linked list ready
-	 * to be consumed.
-	 *  - Odd chunks originate CB equal to 0
-	 *  - Even chunks originate CB equal to 1
-	 */
-	chunk->cb = !(desc->chunks_alloc % 2);
-
-	chunk->nburst = nburst;
-
-	list_add_tail(&chunk->list, &desc->chunk_list);
-	desc->chunks_alloc++;
-
-	return chunk;
-}
-
-static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
+static struct dw_edma_desc *
+dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
 {
 	struct dw_edma_desc *desc;
 
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
+	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!desc))
 		return NULL;
 
 	desc->chan = chan;
-
-	INIT_LIST_HEAD(&desc->chunk_list);
+	desc->nburst = nburst;
+	desc->cb = true;
 
 	return desc;
 }
 
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	struct dw_edma_chunk *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
-		list_del(&child->list);
-		kfree(child);
-		desc->chunks_alloc--;
-	}
-
-	kfree(desc);
-}
-
 static void vchan_free_desc(struct virt_dma_desc *vdesc)
 {
-	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+	kfree(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 {
-	struct dw_edma_chan *chan = chunk->chan;
-	u32 i = 0;
+	struct dw_edma_chan *chan = desc->chan;
+	size_t i = 0;
 
 	if (chan->non_ll) {
-		if (chunk->nburst == 1)
-			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
+		chan->dw->core->non_ll_start(chan, &desc->burst[desc->start_burst]);
+		desc->done_burst = desc->start_burst;
+		desc->start_burst += 1;
 		return;
 	}
 
-	for (i = 0; i < chunk->nburst; i++)
-		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
-				     i == chunk->nburst - 1);
+	for (i = 0; i + desc->start_burst < desc->nburst; i++) {
+		u32 idx = i + desc->start_burst;
 
-	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+		if (i == chan->ll_max)
+			break;
+
+		dw_edma_core_ll_data(chan, &desc->burst[idx],
+				     i, desc->cb,
+				     idx == desc->nburst - 1 || i == chan->ll_max - 1);
+	}
+
+	desc->done_burst = desc->start_burst;
+	desc->start_burst += i;
+
+	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
 
 	if (first)
 		dw_edma_core_ch_enable(chan);
@@ -125,7 +97,6 @@ static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 
@@ -137,16 +108,9 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk_list,
-					 struct dw_edma_chunk, list);
-	if (!child)
-		return 0;
+	dw_edma_core_start(desc, !desc->start_burst);
 
-	dw_edma_core_start(child, !desc->xfer_sz);
-	desc->xfer_sz += child->xfer_sz;
-	list_del(&child->list);
-	kfree(child);
-	desc->chunks_alloc--;
+	desc->cb = !desc->cb;
 
 	return 1;
 }
@@ -337,8 +301,10 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	vd = vchan_find_desc(&chan->vc, cookie);
 	if (vd) {
 		desc = vd2dw_edma_desc(vd);
-		if (desc)
-			residue = desc->alloc_sz - desc->xfer_sz;
+
+		residue = desc->alloc_sz;
+		if (desc && desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -355,13 +321,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
-	u32 bursts_max;
-	u32 cnt = 0;
+	size_t cnt = 0;
 	u32 i;
 
 	if (!chan->configured)
@@ -418,17 +382,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		return NULL;
 	}
 
-	/*
-	 * For non-LL mode, only a single burst can be handled
-	 * in a single chunk unlike LL mode where multiple bursts
-	 * can be configured in a single chunk.
-	 */
-	bursts_max = chan->non_ll ? 1 : chan->ll_max;
-
-	desc = dw_edma_alloc_desc(chan);
-	if (unlikely(!desc))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -452,19 +405,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		fsz = xfer->xfer.il->frame_size;
 	}
 
+	desc = dw_edma_alloc_desc(chan, cnt);
+	if (unlikely(!desc))
+		return NULL;
+
 	for (i = 0; i < cnt; i++) {
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (!(i % bursts_max)) {
-			u32 n = min(cnt - i, bursts_max);
-
-			chunk = dw_edma_alloc_chunk(desc, n);
-			if (unlikely(!chunk))
-				goto err_alloc;
-		}
-
-		burst = chunk->burst + (i % bursts_max);
+		burst = desc->burst + i;
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
@@ -473,8 +422,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
+		burst->xfer_sz = desc->alloc_sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
 			burst->sar = src_addr;
@@ -529,12 +478,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	}
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
-
-err_alloc:
-	if (desc)
-		dw_edma_free_desc(desc);
-
-	return NULL;
 }
 
 static struct dma_async_tx_descriptor *
@@ -605,8 +548,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 		return;
 
 	desc = vd2dw_edma_desc(vd);
-	if (desc)
-		residue = desc->alloc_sz - desc->xfer_sz;
+	if (desc) {
+		residue = desc->alloc_sz;
+
+		if (result == DMA_TRANS_NOERROR)
+			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
+		else if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
+	}
 
 	res = &vd->tx_result;
 	res->result = result;
@@ -625,7 +574,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (!desc->chunks_alloc) {
+			if (desc->start_burst >= desc->nburst) {
 				dw_hdma_set_callback_result(vd,
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 4950c57fca34f..3c958ca05144a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -46,26 +46,21 @@ struct dw_edma_burst {
 	u64				sar;
 	u64				dar;
 	u32				sz;
-};
-
-struct dw_edma_chunk {
-	struct list_head		list;
-	struct dw_edma_chan		*chan;
-	u8				cb;
+	/* precalulate summary of previous burst total size */
 	u32				xfer_sz;
-	u32                             nburst;
-	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
 	struct virt_dma_desc		vd;
 	struct dw_edma_chan		*chan;
-	struct list_head		chunk_list;
-
-	u32				chunks_alloc;
 
 	u32				alloc_sz;
-	u32				xfer_sz;
+
+	size_t				done_burst;
+	size_t				start_burst;
+	u8				cb;
+	size_t				nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_chan {
@@ -128,7 +123,6 @@ struct dw_edma_core_ops {
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
-
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
@@ -170,6 +164,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
+{
+	if (chan->dir == EDMA_DIR_WRITE)
+		return chan->dw->chip->ll_region_wr[chan->id].paddr;
+
+	return chan->dw->chip->ll_region_rd[chan->id].paddr;
+}
+
 static inline
 void dw_edma_core_off(struct dw_edma *dw)
 {

-- 
2.43.0


