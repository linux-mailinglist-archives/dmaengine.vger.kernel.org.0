Return-Path: <dmaengine+bounces-6874-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C319BE633B
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 05:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5901419C79C9
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 03:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC1C21FF3F;
	Fri, 17 Oct 2025 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MID1yg9G"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B233F9;
	Fri, 17 Oct 2025 03:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760671176; cv=fail; b=b5/LMW3udCfucqPnAZoBerM/9qYnEt6i0mqDXTEGO3qN9V+lnn+Ro856X1lZcoY58lYOYu2Ol5d2gdsDTe7/6YJu70msgNUkKVRU3G5ipOGqR7W2krms4LJV5HACqCGaUT2WuQIpVj1KLJ0vNFpUq2UP0/SIU/Hh+io6Erf+f9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760671176; c=relaxed/simple;
	bh=VDrnnsKKcfn5dSig6U2efjVg0XRzDwfe8cpnoxd8B44=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=AmdwRRRB278MbdRgpCcofpPx2spzk+xzUGikI28azUp2bdZAFGAIxAVGA5rHUtCrpxrFz8n0oATD+FSx3/6Glsq1cSFfFkAWIgt5uAsm1koxE9l6MNiUZ+zLFir1vUp9pDAsKl2PYOdMxAxt076vPwI8gm+3jH5kOUIUSyigBNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MID1yg9G; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN0ApSqACg+OgZqQDsbr1Pu9MTKYBtFY8q0JRjNAUpEY80Xmca5vYxYCz7AfKNcy3uiRadUu9CSZp55Zf7FFqEs18Yjcup9hnWtD0h0M21b4lVDz5Ow3rVU/03m6a1E5t6wOaUXvzqxBr6DMeWiu1PlUy2NRZ14DpdIAd5AMNGO8KLznSvjqWD8weNHWOcpjlAg6TltkgQX662HPeae2ZVoXGDVp32vQFfZezxcB/9zWpTIKjjpqAbXKHZOTRsqfl3hHLSDRuRwWWQ2zDPd8CfJDO44CwS8ViLIeRJFx3DGgiMZ/wTerP95ODEQKzoMgQMIEq8rt4rimlsDSNjJe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0Lf7lba9u/y+JPXfrpgFiKAZNC5Yq9yQNqpUuATwKs=;
 b=LtNFdf86Bnr/Gu6hhYGpGW5xUTW+wyDcRPrxtv4/TYmKlje4bluMPBrRdElZ2ZkD0fIq/ESrRTKfKupK011dSEB6mLAaG6DrB6EMQXHYEJFG5bqRHHtFUSJFBUUVinlKhUs7uhy4zabBLYrCQIH5cILrpYPUJWOMYKwN2GgGfAuqabFAXjN3aMfr2GXodT1Cpb5ynHKeSIk1y6MGa7y/9o1rbUVUk7tqniTt+cIMc2H+KmDgMqRfLOe6oTdq5qJB7EAhQCpUoCTLatsC0pqKOQmC1cME7lYFQShf4IhqkbBhZRXDHxqhOYW53hIIR++KId2lYbBkOsBTva82pCLCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0Lf7lba9u/y+JPXfrpgFiKAZNC5Yq9yQNqpUuATwKs=;
 b=MID1yg9GQu959/j6EB7fnqcwe5kl9Ku7IzeUcvsmJPDhizhZxDNKNcMVB4yGb6MD/CHK1V1gwMsQougcGHCogaDX5JPxttMdVjhIOb7vdnJUf/xZJmKuZofofd0dFdtd2b2XMSqcKdRQwIlrMXHoUG2KP9+WVlusr30viya0LV+McnCe73WFftIKUceBP6psVbYAVRTUNXL71LQkGZD2EbZm36Pjjc8MO91GVNEQ421SxgZkDd8xF4d/xdRRWh8pPe4OuD/WOO+Nofu57DpFxgCXTgT65uq6Sun1Mr2leQyIpQsxN282B0OKtLPX/+Zk7eR6YivP0WgyxXxXzLI4Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GV1PR04MB10352.eurprd04.prod.outlook.com (2603:10a6:150:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 03:19:29 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 03:19:28 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Fri, 17 Oct 2025 11:19:07 +0800
Subject: [PATCH v4] dmaengine: fsl-edma: add runtime suspend/resume support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-b4-edma-runtime-v4-1-87c64dd30229@nxp.com>
X-B4-Tracking: v=1; b=H4sIAKq18WgC/42OzQ6DIBAGX8VwloZdQLSnvkfTAwq0HPwJWGNjf
 Peih/bU2ONsMvPtQqIN3kZyzhYS7OSj77sEIs9I89Dd3VJvEhNkKFkFSGtBrWk1Dc9u9K2lyJ0
 SQjOJqibJGoJ1ft6L11vih49jH177wATb9XdrAgq0KpVwRskSAC/dPJyaviVbaeIHNk+2YaqsD
 DagZf2x8+zAQiO0cCUvGHf/W7VFdAoKUEJ+P13X9Q2t47ITVgEAAA==
X-Change-ID: 20250912-b4-edma-runtime-23f744a0527b
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|GV1PR04MB10352:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdb8e4d-68de-4df9-5fa2-08de0d2bfb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWNPMkRCdmFwaSt3L2JKcHNSVWwyVWhGWURacXZjL1hZbFNQeEp2c0dBWjA0?=
 =?utf-8?B?VFZXci93UE9GWjJWV1RkMERWRXRGTXZMaWVtMmJKSzd4V0ppNWc3YmRGZ28w?=
 =?utf-8?B?QnMvTEdqV1RjNkllaDNmVk1kZ1Z0THUveUJzOTVoTDQzY2dQU3hpdFBXWUJ1?=
 =?utf-8?B?TGhpVElwdXpRcWJEK3J6MXBPbjFxT3pMWituZU5PN0NiMnRNNHpLbFp3OHZ1?=
 =?utf-8?B?cWVqRGxUeWNLR0diLzZEc2JUZ0R6WXgybzN2MGRSVWJsaU9lUWZoMUpYOWpl?=
 =?utf-8?B?L0JER283bWFVSm1EUXNmOWJZcmRQU3Y2R2tVZ1lRdFhYU3h3TVRpcXlUNlRB?=
 =?utf-8?B?b3dLVUxtVEthUFl4Q3JGb0lhakRtSTBEMCs5aXZWUTFJNFZYNTFQZE5QRDlK?=
 =?utf-8?B?VFJMWkRzTmJ5NkwybXNSSkwxR2FYeTg5UXMyaWsvYTBzSzIxVm82eEFVNlY1?=
 =?utf-8?B?ck1yTFZydVNQM21BdDRUN0N6d3c5NDhIR21lbUo1LzlxOWJFaWJKUEM5ZzJp?=
 =?utf-8?B?OUc4MnlIaFoxM3hzNENZZFNuUko5VnVWUkx2TGU1U0phMXdRT1VHSDgvbWFw?=
 =?utf-8?B?WjlUZDJOWkdrcGcySSt3RFA4ait2V3dCazZUUHNzUXdscUE3WjFlblQzaEs1?=
 =?utf-8?B?eFEwVlEwcllIY1gra0tDSG9VZlExdXVXZUZqQjBmdXJRSStRdGRvcW52OEND?=
 =?utf-8?B?OWtKYmRiZDVXNDc4UkJtTFhGKy9mdVJkWkxOSFNmTnZDSi9DTWNoUUROSFJp?=
 =?utf-8?B?aExERXdONXZobmdMMHZRcVdZVEhwc1JpcW9FNzNvV2VxVzlzeUJ5cjBiLzRQ?=
 =?utf-8?B?cXkzYnpLT1RKbEpIY00yaDFrSTlaSmVqU3U4Y3pvRkhNOFdKVVFnWGJ5UG1v?=
 =?utf-8?B?azVDN3dCTHVscml0ZEVoRHlXSXdFbkxOYXBpWkhJaFk3OWk1TFRHbTAxWk1q?=
 =?utf-8?B?cmdwUDRuUEJ1bzJzTFBrd042Tk5nWnhWK3VKaUFzd08xdEIzRVRyWFdxWU50?=
 =?utf-8?B?anRqQkNJREtxOTZDeGYvZE5GQlMzcGdsL2w1SmxQQ0hBQVZiQnladFpEdTEr?=
 =?utf-8?B?Rmp4QTVDMk5HSHpicDNTS2VMMlVwSkpRWXJUenRteWNjUlcwemp3RkszYmJk?=
 =?utf-8?B?Y0NsUzdZem81WHhNamE1ZExlcTZUL0FWQnpSYUQvV2hlbDdDTGhCbmVJd0Yx?=
 =?utf-8?B?NHFvaDhQRUh1UHhFdWl0Vk1xOVVmemdFMStvK1VIWDBicE96TmVrN3pZRHRK?=
 =?utf-8?B?Qzk4b1NqUlZHUVkyRjJGL3BmSU1WQ1RmaUZmZFZudDlLUjhObVl5WVlVZnNp?=
 =?utf-8?B?eGswZ1hjQTBWR0FNSm9PWnlBd0g1eUpSOVNFUS9ERUlZYUx2clRoTlpZWWQ0?=
 =?utf-8?B?aUNDa2FRaHA1MUpOY1F5TCt2SUxIYTA1K3kxOFJNZ01HbU1wR2dkRmZHbEk1?=
 =?utf-8?B?L2VsMHBCQWpnOGV6bnJUZ1ZtT2RXVzhsRHowWFJPNVh0ZFNVdVVkOHduM3Rs?=
 =?utf-8?B?cEZMZnovRGxxWWE2VnA0ekdDTG9XaWdRdkwyOUJXemFtSWxNNWpPamdnRWMy?=
 =?utf-8?B?SkxGUEhXWHp1R0hiZEpFdkRvUndHUUVITzN5bWZlRmVxcGRxcXNHcjNiOXRZ?=
 =?utf-8?B?K3VYTS9nZkdJMjVnN2lJaTd3VzRaZ1BFV0hybWVFR2N2WHkrckVPNFk1Smx6?=
 =?utf-8?B?Q21pajhNT3lFd280OTRYb3FDMmM2YmtxRTdvczg2UTREdlZUWktKU0N3NXZX?=
 =?utf-8?B?a0JWV1hPd3pDR3pwbWM3c0pPUEJxTmh5cE40QXgvdTBHek1ncDdISHhySmhR?=
 =?utf-8?B?WDNyTHZFS1hxbmdST1ZpblZic2RjUG1Ccm9OWWNEVlJtbi8xditNTm5CSXh3?=
 =?utf-8?B?UXJpckNTYVBxZ2FyY05Qa2k1dHlyZ2FxcWRnTythc2xQY1dJUlpLNWlmTGcy?=
 =?utf-8?B?UjBycUIvb2c0MHdkL2xFV3QrTVh0Y0VEQ3ExTVhFUExiTTNwZkw0U05uWjRE?=
 =?utf-8?B?WERrck1QazQ3VU0yT2w0Y2tnYmlHckM2UDhKdWxXNFJmWEhnQXBrd1NlbEcy?=
 =?utf-8?Q?8CaKA/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlpERW9TTzc1NVk2R1BEVXFOTFdsNm1oTjRNVUV3RVZVYjVkTUdpSmd1ekdC?=
 =?utf-8?B?MXF0VzlmYy9ycUFJTGxnaGtZQXZCQTZrQTFESWlaSUhZcmVFK0RBSHFlRzB6?=
 =?utf-8?B?YlcwVk9BZlhoZUZLcFlPWDg1cWttRkdNVTc0WUcvTHM4bFVxanBtbHJkMnpy?=
 =?utf-8?B?OWZkNEFWUHZqMlBqWUI1RVZ4anRYTWZiV29zQTFzVkVVc0srcEpNWWlKckNp?=
 =?utf-8?B?ZllGaml6Q3ZtS3FKOXh3WDJiRTlJQ2xCdko2c1VHLzFlSk9jeVZ6VVRuSFVh?=
 =?utf-8?B?RjBWQ1ZrVHRDdXYrMy9VSGNNdnZHcnl4bGRPaHJ1c3N6eXhlSU10enR1UDFF?=
 =?utf-8?B?OHNTTE9xQ0l5Sy9KaXdnTFhlRlZsQUo5aHRLdlg1Z0VJeTArRTUxYkNIaHJt?=
 =?utf-8?B?cHpIeGpuYmVaU21XQ0RhV3RueXZBL2pyNkUxOWZpNXBkSTRId3IwS0xUelhv?=
 =?utf-8?B?TUhzOXJveWx0NFNEVStrRzNrRFZpcXhIaWlBNFp1elpySlFLOG5IRUZjbjJV?=
 =?utf-8?B?WnNUNzhYU0pWbDc2TFpWYmQ4eHBmdFN4YTZNcTFoUEhRRXlQL05IRVlNTlBC?=
 =?utf-8?B?YkxzY2dZMkhjZlJ4RHVOaXg2KzlRL1dsckpQTi9NZ05rb05mS2ZRMlZLWlRQ?=
 =?utf-8?B?eFQ5bFZQSGNlbFF5bVl1dGkvQWZEOTJnSDRsNVQvNnl0UmQ4anY2b2J3VFBO?=
 =?utf-8?B?c0x0ZkQ1bC9FL1VMQjVGM0tzdkhxOHFIa2JGUzBOa3BKWVMwNXk1M1hPUDZM?=
 =?utf-8?B?ZU1jV21XOFlJM0d2M2x1aThRNXMzVUk5TFE4THl3QUZyTGR5YkpBeldYM3dx?=
 =?utf-8?B?VXpYVWw5a3NLN2dwMlU4ZlhGQnNJaFFXVWZSbkVYYnRFWXlybEVXOFFRT3BV?=
 =?utf-8?B?VEEra1VrTmtFdTB5Wk5mVU5PUEhnOHNyMUF3bFFxZnNneWpqM3NObjVQa0ZX?=
 =?utf-8?B?NkhubDNBTFZwelRGcUR5MEljcHFmd0poOXRrd0dsN1JQeG8yN3VPSEd3b1pv?=
 =?utf-8?B?TWdraksySEdFdjdkbkhWQ2h2OFluUURJRVJ2OFNhalY2Qjlaem04U3M0ZVNr?=
 =?utf-8?B?SUJqVlR1VXhTM1BMV1RMMEhUQ2J1UU5tSEtuTldsUUdhaUZIUmpHNUxEeVBj?=
 =?utf-8?B?SkdwSEM0blVwOXIwSDJRa2cwYVVBRlhmd2l0K1JIbDBoeWVaREZrVmZlVzlr?=
 =?utf-8?B?aUE0MWJqMnNvOVlzaEIvV05QdDBhMi9BdkVwTmI5cjZnblNjOFh2M2hWQjJB?=
 =?utf-8?B?V285Z1hRL0d5T1lmejF0SU9QRnQ3eXQwRGZGSTNmWU9sUlY1eUtKd1dXb1d2?=
 =?utf-8?B?OFZSbmhCQ3Z2aHEvd0doQ3hZSGhtelhsTlpOODBYdUpIRFBmQTJaR05oY1VS?=
 =?utf-8?B?aDhNY3NhaHZCZ0Q1NStQKy9sbG00bmZBcXFaQWdtYXd4QS9qSVp2cnVUaUhU?=
 =?utf-8?B?MFlnajd5NE1DVzlnV0tJd0J2Zk01WEp6RUZlQWhOcHVuczJnNytBTHFPdWg3?=
 =?utf-8?B?Q3hzbU8vd0hqUEhzbCtvZmprR1ZnbEpnSHY3enFVM1dXY2FzTXZsS1BKSEZk?=
 =?utf-8?B?VWlxN1BoaVpralN4WkltdFZHS1JoeElGK21xQjBwOC9GMGlza0Z4M3ZFZDZE?=
 =?utf-8?B?b0NBOGNIdzZKSEk2Z01Yb0d2UGZGZEpuci8yTVZIbjJVUkpob0w2d09lOW81?=
 =?utf-8?B?eG1SYVFucHlxS1R3TXh5MU15VmNiQ01aZWRqTHpscFVSdk56eFpIT0pFa2Jm?=
 =?utf-8?B?dEpSc1R2ZUVlalhiQlptdEIrVkNQV3F3bDBGVHZPVm5HWXdHK2RHR0F3L2xO?=
 =?utf-8?B?NW56RStkWTZoL1JEWTg0YVZSZU90T3VSR25NZ3AvOFIxSEJzQ1lzaFZCZEpp?=
 =?utf-8?B?MEtLUWJ1Y0RPZHBvdExTelU4UnFwQWpyQkU0R1A0NzIxZjRYUExTYVlDMTF0?=
 =?utf-8?B?ZGVFR1BKZXd2UWk1akh0VVBGb0gxK05xRk9jTkh5VUxacE0wSVBKdDI0VzVH?=
 =?utf-8?B?YTQ1YkI2bVpJcVF0YWhuZEZ0ZHBUZUhQL2gvc0tQTWtPdFN1dlpoTGlXekt4?=
 =?utf-8?B?YUZQSjBRYlkvR0JrTExGK0EwV2lpb1hlSW9vUUJYVy9UWDFURjlTa0dNZVRU?=
 =?utf-8?Q?Q0ZNzLKfeInzKSWw9f8IWrWiz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdb8e4d-68de-4df9-5fa2-08de0d2bfb4e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 03:19:28.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rV76FVHevbdGux3pYRmn3XhasiGmv9jJeI/REZUEuXQ9JcW2O43nh0GLQ1Ve11Gl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10352

Introduce runtime suspend and resume support for FSL eDMA. Enable
per-channel power domain management to facilitate runtime suspend and
resume operations.

Implement runtime suspend and resume functions for the eDMA engine and
individual channels.

Link per-channel power domain device to eDMA per-channel device instead of
eDMA engine device. So Power Manage framework manage power state of linked
domain device when per-channel device request runtime resume/suspend.

Trigger the eDMA engine's runtime suspend when all channels are suspended,
disabling all common clocks through the runtime PM framework.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes for V4:
- fix a typo dmaegnine/dmaengine in the subject.
- Link to v3: https://lore.kernel.org/imx/20250912-b4-edma-runtime-v3-1-be22f7161745@nxp.com/

Changes for V3:
- rebased onto commit 8f21d9da4670 ("Add linux-next specific files for 20250911")
  to align with latest changes.
- Remove pm_runtime_dont_use_autosuspend() from fsl_edma3_detach_pd().
  because the autosuspend is not used.
- Move some edma channel registers initialization after the chan_dev
  pm_runtime_enable().
- Add clk_prepare_enable() return check in fsl_edma_runtime_resume.
- Add flag FSL_EDMA_DRV_HAS_DMACLK check in fsl_edma_runtime_resume/suspend().
- Link to v2: https://lore.kernel.org/imx/20241226052643.1951886-1-joy.zou@nxp.com/

Changes for V2:
- drop ret from fsl_edma_chan_runtime_suspend().
- drop ret from fsl_edma_chan_runtime_resume() and return clk_prepare_enable().
- add review tag
- Link to v1: https://lore.kernel.org/imx/20241220021109.2102294-1-joy.zou@nxp.com/
---
 drivers/dma/fsl-edma-common.c |  15 ++---
 drivers/dma/fsl-edma-main.c   | 129 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 4976d7dde08090d16277af4b9f784b9745485320..55cb094088d569b87cde78a36734a1fc7e251b73 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -243,9 +243,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
-		pm_runtime_allow(fsl_chan->pd_dev);
-
 	return 0;
 }
 
@@ -823,8 +820,12 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	int ret = 0;
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_prepare_enable(fsl_chan->clk);
+	ret = pm_runtime_get_sync(&fsl_chan->vchan.chan.dev->device);
+	if (ret < 0) {
+		dev_err(&fsl_chan->vchan.chan.dev->device, "pm_runtime_get_sync() failed\n");
+		pm_runtime_disable(&fsl_chan->vchan.chan.dev->device);
+		return ret;
+	}
 
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
@@ -852,6 +853,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 		free_irq(fsl_chan->txirq, fsl_chan);
 err_txirq:
 	dma_pool_destroy(fsl_chan->tcd_pool);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 
 	return ret;
 }
@@ -883,8 +885,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
 	fsl_chan->is_remote = false;
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_disable_unprepare(fsl_chan->clk);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 97583c7d51a2e8e7a50c7eb4f5ff0582ac95798d..e06f4240fdeb8839493f00c63b640eb3aa795b91 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -642,7 +642,6 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
 			device_link_del(fsl_chan->pd_dev_link);
 		if (fsl_chan->pd_dev) {
 			dev_pm_domain_detach(fsl_chan->pd_dev, false);
-			pm_runtime_dont_use_autosuspend(fsl_chan->pd_dev);
 			pm_runtime_set_suspended(fsl_chan->pd_dev);
 		}
 	}
@@ -673,23 +672,8 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 			dev_err(dev, "Failed attach pd %d\n", i);
 			goto detach;
 		}
-
-		fsl_chan->pd_dev_link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
-					     DL_FLAG_PM_RUNTIME |
-					     DL_FLAG_RPM_ACTIVE);
-		if (!fsl_chan->pd_dev_link) {
-			dev_err(dev, "Failed to add device_link to %d\n", i);
-			dev_pm_domain_detach(pd_chan, false);
-			goto detach;
-		}
-
 		fsl_chan->pd_dev = pd_chan;
-
-		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
-		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
-		pm_runtime_set_active(fsl_chan->pd_dev);
 	}
-
 	return 0;
 
 detach:
@@ -697,6 +681,29 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	return -EINVAL;
 }
 
+/* Per channel dma power domain */
+static int fsl_edma_chan_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(fsl_chan->clk);
+
+	return 0;
+}
+
+static int fsl_edma_chan_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(fsl_chan->clk);
+}
+
+static struct dev_pm_domain fsl_edma_chan_pm_domain = {
+	.ops = {
+	       RUNTIME_PM_OPS(fsl_edma_chan_runtime_suspend, fsl_edma_chan_runtime_resume, NULL)
+	}
+};
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -826,11 +833,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		}
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
-
-		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
-		fsl_edma_chan_mux(fsl_chan, 0, false);
-		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
-			clk_disable_unprepare(fsl_chan->clk);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
@@ -889,6 +891,45 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+		struct device *chan_dev;
+
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
+
+		chan_dev = &fsl_chan->vchan.chan.dev->device;
+		dev_set_drvdata(chan_dev, fsl_chan);
+		dev_pm_domain_set(chan_dev, &fsl_edma_chan_pm_domain);
+
+		if (fsl_chan->pd_dev) {
+			fsl_chan->pd_dev_link = device_link_add(chan_dev, fsl_chan->pd_dev,
+								DL_FLAG_STATELESS |
+								DL_FLAG_PM_RUNTIME |
+								DL_FLAG_RPM_ACTIVE);
+			if (!fsl_chan->pd_dev_link) {
+				dev_pm_domain_detach(fsl_chan->pd_dev, false);
+				fsl_edma3_detach_pd(fsl_edma);
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "Failed to add device_link to %d\n", i);
+			}
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
+		}
+		pm_runtime_enable(chan_dev);
+
+		if (fsl_chan->pd_dev)
+			pm_runtime_get_sync(fsl_chan->pd_dev);
+
+		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
+		fsl_edma_chan_mux(fsl_chan, 0, false);
+		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
+			clk_disable_unprepare(fsl_chan->clk);
+		if (fsl_chan->pd_dev)
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
+	}
+
 	ret = of_dma_controller_register(np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
@@ -929,6 +970,13 @@ static int fsl_edma_suspend_late(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(fsl_chan->status == DMA_IN_PROGRESS)) {
@@ -955,6 +1003,13 @@ static int fsl_edma_resume_early(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->srcid != 0)
@@ -967,6 +1022,37 @@ static int fsl_edma_resume_early(struct device *dev)
 	return 0;
 }
 
+/* edma engine runtime system/resume */
+static int fsl_edma_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++)
+		clk_disable_unprepare(fsl_edma->muxclk[i]);
+
+	if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK)
+		clk_disable_unprepare(fsl_edma->dmaclk);
+
+	return 0;
+}
+
+static int fsl_edma_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	int i, ret;
+
+	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
+		ret = clk_prepare_enable(fsl_edma->muxclk[i]);
+		if (ret)
+			return ret;
+	}
+
+	if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK)
+		return clk_prepare_enable(fsl_edma->dmaclk);
+	return 0;
+}
+
 /*
  * eDMA provides the service to others, so it should be suspend late
  * and resume early. When eDMA suspend, all of the clients should stop
@@ -975,6 +1061,7 @@ static int fsl_edma_resume_early(struct device *dev)
 static const struct dev_pm_ops fsl_edma_pm_ops = {
 	.suspend_late   = fsl_edma_suspend_late,
 	.resume_early   = fsl_edma_resume_early,
+	 RUNTIME_PM_OPS(fsl_edma_runtime_suspend, fsl_edma_runtime_resume, NULL)
 };
 
 static struct platform_driver fsl_edma_driver = {

---
base-commit: 1fdbb3ff1233e204e26f9f6821ae9c125a055229
change-id: 20250912-b4-edma-runtime-23f744a0527b

Best regards,
-- 
Joy Zou <joy.zou@nxp.com>


