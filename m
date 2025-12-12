Return-Path: <dmaengine+bounces-7593-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 488ADCB9EDF
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F406309F812
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1F2F8BC8;
	Fri, 12 Dec 2025 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NVWqSsH4"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED958236451;
	Fri, 12 Dec 2025 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578382; cv=fail; b=nnLa4sn9A1pmSw4XnlpTKTcQYzHDJxwBjXs+HQDKumBGJxQ2iG4zVkf6PadOuWg/kIIfMeE2UzyxvhB/LU8a60wzIw/3vqeXuxyc40/XJLU6aHGH3AH+9Zup6v2q5W+JI1lpw59PFYOTiwYKiSWyRCNjEzBu9epcOYh0qR2glpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578382; c=relaxed/simple;
	bh=9E3KWGDTkSLLiUWQEfm4y6XKUz67mcmaXh08lvfVQPY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=CHjsct9ebXt59sq5dPMfiPkEdrIUaHKc21AT7JfcToazdlLkaatMRVtsfCJp6zD8kftfLJBis445aBrQoygvi595Nrt2k/Oydto0ncVmoClIHaEnYqsAeDKhLuFhZSm4UtZ2qVoYW871BC56rcrj7r5A0/dqd1TbSm68yDIboBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NVWqSsH4; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKo+XQ6NLuj9gF9fYTgxCxwv+ij6RXNQjioR0hzvbZ4B49cOXk1S58KVZzZZM3XqN3WzQ0jak92JJdkLgedWk9RyXpjbwpWWPD7MRwsnp2Oa013PaxTbBciaQCXo9Uwx3EJP755nhtuKWk0AGM01uSSw+MHXTcmciQDMofe3t6vVFScnIEb/AvHQyhZvCbpChBKDAAZp6rFkXz9Nr0ntgsJpguLHmo0W/3ZuEUOnbXkRpBEKNF2uxZ9ExPwsnVvskqOBasOG95rTzYoj0O1kYaK0rtKREtuXeSfo2DCHL9sSZNN4GsUD+RTQ3HHHCpY28TCABeN367dtiCeRYM7JzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcFw29JtJQ1zMcZuk7Q7nwm7aighaoIFRCCb0zblw+I=;
 b=alvhneDNSx/PQZqPXwbZuTYZwCNb117HRf7Y7aphcXUS+es6JBIMv161rSZkHn/L+IzHGifHYRWFJkg0eeBHkD/cjYay2eV0G4il8EULUBzC6Sn21QJtEpQTv6nfQLBi0fACmb0+l6tXuTs1cetrzrIru/xkGA6s1ozt5vxf1pYafEMr575HQuP5bcUBE1h5Xa7iYdYLHaksl3vwSPOxjmVM60+vFJug33HlMbj/ybyATZIpW9IdkvNu9J+T9dX2zWxN2p3eMLUNiqPHM247cShOaZ6h6Gy3KoG63QmKoXOnAFANP9YIAxulvQ/mfKMQBBlThrc6eyg3XvXpm+ABWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcFw29JtJQ1zMcZuk7Q7nwm7aighaoIFRCCb0zblw+I=;
 b=NVWqSsH40vFnC8KNqKr0Ut2S4wYwv7AF8RGrC9bXrxelBxGCwE30rlCUORouVDqaYCSLgSpjHHCYcZcrgGjk7ZnrnWl1tsZ32mZOeK2U35DClAgbhTlobOP/o/B7Nwg8xqUJl0SVuWCaUxIifVJ5iRKMdtsfpramJzo26j/EISVpAs1NQAowaXGJ74LA+HZpJrdgP5B6UgFN4ELN3dHppch4PrsEE9iQSpgqiQKPZZhkOmBLH8thQQ/h2YR/9l3Y2r8FSC3uuGfbYvmaRjA+S0kwKn4ePyJ+DCCDZrIh62uDarhRX5/mPWbbGWq8qgADewWRFAQKU1k9tXd6IGZ3iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:03 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 00/11] dmaengine: dw-edma: flatten desc structions and
 simple code
Date: Fri, 12 Dec 2025 17:24:39 -0500
Message-Id: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACiWPGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0ND3dSU3MT4nBxdA0sDk6REAwvLNANDJaDqgqLUtMwKsEnRsbW1AEm
 Fh9tZAAAA
X-Change-ID: 20251211-edma_ll-0904ba089f01
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=2755;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9E3KWGDTkSLLiUWQEfm4y6XKUz67mcmaXh08lvfVQPY=;
 b=6bIZXPh53+OdL1xMnZnnGb1UOZ/a+ti2+59xj5hU9Pbr4W4Rp52CNV2xde/hJTsGo7+2HwFzz
 vdwysGJ9deDAl7RCyJWZ19PWkqH5Hv7zbWta/8SoCxkZuAA0hB6Jvmu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b2a1eb-ded2-4539-5fd5-08de39cd4b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUw3ZnZDVUVqMWYvSzJwQXkvNldLMUM1NzZvVTJ5WGNqMnBqbCtra1luQXho?=
 =?utf-8?B?ayt2WlVIbWI1dHlzdkJRL2h5dUE3amZvdm9KYXBXSkp4SjdvVEZUZTR3VDgz?=
 =?utf-8?B?aSs2dkFaUGFROTZPNm8vNjhtbSs5R0J2Sm1mQWtxMGxUd1h2cklHZUpNdWU0?=
 =?utf-8?B?eDdpNjBUSUYrVng3M3FSL2xsMmRSQkM1SDNOQVJIZU94UWZ2cDhxbEI5ZTZE?=
 =?utf-8?B?NUJmWW84eXVrbGJPWmh2eWF0QXFkeHA1NnJDRndWaTFJYmFXd3hvcU51blRk?=
 =?utf-8?B?WXp2Syt2c0pROVJDUXJuZlpoTE1lVDRyR3U0Snd5bFlSc2ZtQ0FGMm0rTjJ1?=
 =?utf-8?B?c3haR0ZRNlJJKzV6dC9nVmtIZ210ZzUyUEM1Nk5xOStGMmU5SFBqRzkxYm05?=
 =?utf-8?B?d3g2SFFoRFUvUHJ6WmhLK3U0Q1FZbE41Z1hTd0V5UG1DMEFKSklOSzI2UExX?=
 =?utf-8?B?ZkZtYzlYbnpUR2gzN3NrNEkrLzdOUk9MNEFDUGJadFFsMWhPMHBBMnI1em9m?=
 =?utf-8?B?VmJhcTFqbXlTL0cxZS9FWXVkdG1HenNsYXp4dWY2WjY1M0VRRE93TU81cDBS?=
 =?utf-8?B?SlNnaThEUVBZZjBRMVlLQWZLTm1wUjZrREZVdTFPVXJoVE5qSnhsRy9GTVhQ?=
 =?utf-8?B?Qi96SWdyU0Jzbm5xUUtvUlZwYjlLRWdEK1VRRWR3RkhuYnJ2b1dlS3drQzkv?=
 =?utf-8?B?a0JXb2o1UWZ6OUh4OVdCN3V2OU5aeHRRcERpMWdUTmhrcDl1d2hTOVpjVGVx?=
 =?utf-8?B?WnEyb2ppNnV2bExOVjBYaUJSY1JlUWcrWnRVb2lnem83L3NHaUIvNWxNTFRR?=
 =?utf-8?B?elZ1YkNlcTI0blVXZ3ZuaVpsRUlaYTFtWks1VUhFK21HeG1rM0U3OXNSelpk?=
 =?utf-8?B?UzFjcWtrSkFqRzlQSS9SMHZZVXdWUGFYUUlXaUJpNW9OUmQ2Zmd1OWhvT0Vv?=
 =?utf-8?B?eXYyM0lSVjNZRWt0UENJaGNIWWlrblVyeWt5bTFHK1JSa2llN3ZVTUFVQldl?=
 =?utf-8?B?ZFovcWo5d3pqSE1qOFhLM2hhc2o1VW50RGdvUGY0Z2pEZ1lWMU5naHVQK1F0?=
 =?utf-8?B?elc0dlFydExJMmhhTkx4cnhpaG9vQzRSb2NhNllmVVBENnpJOTl1SlRGdkZl?=
 =?utf-8?B?UlZPQUY4cGtNTFhwUWU0NE1jN2NCTWZRWkJlMkQ1WFpTQWczbUJHVGxsM0xa?=
 =?utf-8?B?aWNYZTZUaHV3QmQyVzhuRE13UGQ2ZExIQjlFLzl3NjBiZWErdDdQcXRSYzh2?=
 =?utf-8?B?d0p2b1hVano2VkxzNEZwSUpsYm5HaU5SeUQ1b3ZiMitvejFCRVROc0gwTVVG?=
 =?utf-8?B?c2VJUmxYaThsV09FVGRRLyt1TUNWZVVTOVE2am9mUEdwbHhOT2NqNkNMeUxU?=
 =?utf-8?B?eXlwbzBvcXdlbXhiaVg5L0JZNlJiaHAvSjhZTGhEZzJSbVBqdG82eUJrcW5p?=
 =?utf-8?B?Qy81ZFJDZVozd25aM3A5cGwvbWN0WjVkSWdQNmczQlJTdjhMcGY4UUo2cUFY?=
 =?utf-8?B?Um4ybGoyMFlHWkNvOUYzUm5qb1B6V2Vrc0ZNSDA4YlZyZWRFYWJ2ejROYVpw?=
 =?utf-8?B?Z1ZiUFRlKytqS3VhdStDWWNPQU9jWE9uTjUzZnV6Z1BoTUsvRFJKaDk0UUpy?=
 =?utf-8?B?LythZFdBYTcvUWZ2d00xamx1VW4rYm1WUVRDZUh6K1ZSc3UxRVFqVTNHYjNq?=
 =?utf-8?B?ODdLYXZFalV3Z2JtWU5JSjBFQ0FOa3ZHK1pPWFF5MnB1U3ZBMWNSWXdseXpG?=
 =?utf-8?B?aktkRkJPUGFmTDM3RlpHeUFhRnluOXJ4dnVBMnpZUzJoNTdRaTJDdjdhSFRi?=
 =?utf-8?B?RHczNThUVmR2K2ZsaEpIZTBuZzkzM1oxZTVIZ3dkb1p0TWVId2JHeS9qQ3hz?=
 =?utf-8?B?RjlKUU5wL1BBaWtuWFZJNjZTTnB4N2c1VC9WTTRDU1FmRysxTXk5c2NjMVAz?=
 =?utf-8?B?QURtSWk3T0ZkYVBuZ1Mvd0k5NDdlMzNOVTg3Nnh1NzlzT3Q2T0NYKzAvUk5l?=
 =?utf-8?B?QjVnRlE0WTZrUHIyMVhwMWliQmRwdnRkbHVqYWR5Ni9FbTVCLzI5bnBpOGJ6?=
 =?utf-8?B?TnREQkRpM2wwcDRERjhHaFZXTWxIZlpKaU1CUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlgvbEprWUgwdmhNWTJ3YWlIZmpYVTRJZXZYbEx0QisrK2tVSXRXUXBnbEVQ?=
 =?utf-8?B?VXdFQ0o0WHFHODY5eE9tenFDTEJTZ3lTTUI1cHYvQUhxaUVwSkRHeFZ4bmhv?=
 =?utf-8?B?NDJpRUFKMkV3RFpDUTk5RXM2RisvR0M1eFd2dk95aFpaWHR2MXM3V3BzYmxl?=
 =?utf-8?B?K293ZHhVMHNPM2ZYQTdYaXBzcTVQKy9YOTlOR1MwWERqUFhDQ3VMb3lKemUy?=
 =?utf-8?B?YkRySTM3UXkrR0k5dHd0QXZOK0ljaXAvSDJKYXJxb25HU1pVRVFIQkpOWXp0?=
 =?utf-8?B?M3FqYmhXWVpFYXJJOEI3TUFGcmM4N0pFVUI0TWM0cVBtbU1Nc1U2bVVieWt0?=
 =?utf-8?B?SGxucXBOV1BtSGFYN1d3aWg3U2hQMXlEMCtKU2xPTlFxVkZTVElzNGpKNHZj?=
 =?utf-8?B?ajBUUEpnbzNIRVJzUm01Wk13bFB1RnROTzZwL01IR29QZHFRMU5vMWhtbzJz?=
 =?utf-8?B?MFJhaFBVQlZFV1ZYRU5ydkQza21Obll1enNkdkZYTTMwOWxSL04zcjFyeC9Z?=
 =?utf-8?B?MW9xR2pyNVljcXd5YmVWSmFZeWdJY3JSYU1DT1N1ckwyUUExbXBYYythY0VS?=
 =?utf-8?B?Y2svcHkxejFvZ2NnRjJYVTR5ZVZFKytPUGNyNG1mVjVhbWd1TnFpWGlNWWVz?=
 =?utf-8?B?SjZYODR6dytKMXBlbmJ4dzl1c2VRTEVJREZuTUJkUFdSSFhaaFZGTDZieVBk?=
 =?utf-8?B?ZU5CMUt1TzVERVhkOFhoSWFTdDIrcUNPK0VEZGdFR0tUWVNYUU5HQitnZWt0?=
 =?utf-8?B?NGxjeXp1eW1QVVpqUit3UlNCRVU2OGgrbkt6dmRNNC91V0N1RjFPdnM5M3hP?=
 =?utf-8?B?UWl1Y05xS3d5SEZrYjg5Z1Q1RnBFMisxOFdiVTcvYVJHTmxjOWt2V2lwZHM4?=
 =?utf-8?B?UmNzZnQrSjFYOHhTRVh5SWs4d3R0NnYwcVpVVHJrMmxtL0xab3VvNVh1bGpH?=
 =?utf-8?B?T1BDSkMzMWszajZOaFUwcExNcnVYdnE0czRBM2VESFdaWVRqNTJmL1hUTFVD?=
 =?utf-8?B?OTBINUJkcTBjeXM4ZzZTMkVtcjM0Mkhnd3dMUGhXVmFSdG9BWitrN2N0VGRP?=
 =?utf-8?B?OHFZMXJ5WEpiTmtwZ2hNeG5pR1dGNDcwRTU4R3IzRDhzUVZEbi9OOGFxMTFK?=
 =?utf-8?B?NGJkM1E3dm8yUTc1elNCd1Bua3lrWVFhc2xyVmVyaTVvMThaOW9MSWkyZi9R?=
 =?utf-8?B?YjRUdUI4ZVE2Q3kzRkJ3cExrcHlwSXlIZDdaYmtPS3c0ZExqbTNjM01TWFVW?=
 =?utf-8?B?WXpUV25RSnlPZjFqZDVLNDRvN3U4N2JUN1pnYlZBQTdJRlFUd0dhL20zZDdK?=
 =?utf-8?B?cW9xMmIyZmljUSsyUGlUeGsrK1ovR2FsV25BTUFSSldpaUJMMGFXeXJpZlRW?=
 =?utf-8?B?dVBRK1NWUUFWZkxnTU93TEFtVjhlZkI5eU9uNGgvOUxzcmlaeTNtZ1dKSk45?=
 =?utf-8?B?ZlZwYWpsbGNjYlFSQnZDUEwrR1hoYWZVK0F2OWFKaVBnNWdJTWhZSWhkUXpS?=
 =?utf-8?B?UjYycWFhL3YzSEhvWENmZTJuRnpUNkI3amFyMjV3MkdmbjZqT1Y4R2VrWkp4?=
 =?utf-8?B?V2dLSkNGNDBRQWxPNERldXlOTXU1anhWRkNjdDd1cUlDQ1R2UDZRN3dnZXIz?=
 =?utf-8?B?NE9pS3F2UmJMSFE1aHpRT25oUG1wOUt6Zklxd0I3Ym11aU1TanhKRVZ4aHZY?=
 =?utf-8?B?WDg5NkZUVFJBNFBqRmhQcEdUQ1k1MTFNaTRmd2R1TXFTa0tTemNEYmFzb3Np?=
 =?utf-8?B?V25nYkM5WG1EZE5GSDduRkl1bnFYVno4TXU0YlVYekdzTElveE5nQ0ZtaFZZ?=
 =?utf-8?B?NFNqbTRJeEVhS2FjdjE3VzZzL2RoMS9tdVRPRkR0NGpmd2lHQ1ZMYTFyZWhI?=
 =?utf-8?B?VlY3bWhpOTI3YUI0NjRwSk1nSWUxaTZKQUVuYlZMTFNrNGxyMkZoeGxyUjNu?=
 =?utf-8?B?VGJSbkpHdGk5aVgwMzExbjVzcWFWQ3NrTDFVTThPMWtIVENNWm9KeTkvY1o4?=
 =?utf-8?B?SzB1S0c0NjJ6SjI0ZEgxQjV5UmtEaTNzRmZxMjJBRUgxWXBodE11UDBMZW9B?=
 =?utf-8?B?UnQwNzN1ZzU4dk9JRE1pVkJUUkhCRERLR2l2eUdUT25QQkg0d3loblB0QitZ?=
 =?utf-8?Q?Ce6M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b2a1eb-ded2-4539-5fd5-08de39cd4b28
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:02.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXNW5ol5bud85FnDw/DA0gOkpqhq+ANOCnsNrTCJI8Mth4h1OmeyaY5wxtp7JTf1oIpbQW74Oo9G3lXSklvU9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

This patch week depend on the below serise.
https://lore.kernel.org/imx/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com/

Basic change

struct dw_edma_desc *desc
       └─ chunk list
            └─ burst list

To

struct dw_edma_desc *desc
            └─ burst[n]

And reduce at least 2 times kzalloc() for each dma descriptor create.

I only test eDMA part, not hardware test hdma part.

The finial goal is dymatic add DMA request when DMA running. So needn't
wait for irq for fetch next round DMA request.

This work is neccesary to for dymatic DMA request appending.

The post this part first to review and test firstly during working dymatic
DMA part.

To: Manivannan Sadhasivam <mani@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
To: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To: Kees Cook <kees@kernel.org>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
To: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (11):
      dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
      dmaengine: dw-edma: Move control field update of DMA link to the last step
      dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
      dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
      dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
      dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
      dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
      dmaengine: dw-edma: Add new callback to fill link list entry
      dmaengine: dw-edma: Use common dw_edma_core_start() for both edma and hdmi
      dmaengine: dw-edma: Use burst array instead of linked list
      dmaengine: dw-edma: Remove struct dw_edma_chunk

 drivers/dma/dw-edma/dw-edma-core.c    | 205 ++++++++---------------------
 drivers/dma/dw-edma/dw-edma-core.h    |  64 +++++++---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 234 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 147 +++++++++++----------
 4 files changed, 294 insertions(+), 356 deletions(-)
---
base-commit: 0f24bd936ac069ca15657b11b6c326ffb0926f3c
change-id: 20251211-edma_ll-0904ba089f01

Best regards,
--
Frank Li <Frank.Li@nxp.com>


