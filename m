Return-Path: <dmaengine+bounces-8565-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJcTIRtRemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8565-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:10:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DECA7887
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 770C030269C1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D63783D4;
	Wed, 28 Jan 2026 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R7xSZT+u"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2823783BE;
	Wed, 28 Jan 2026 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623571; cv=fail; b=iei7meMhJMZabtovy/XdoICGs7ffZVyr4fazXrpdSOr1XBD4Q7l9DHgde8vTVK84E6EzQ1r1IKXUrIuifdG5xWyOA2MTagGpRoZiMTtrTOplQ8+/JFzwtnqlKqR5uoTXtVxx9m8wOgeerJ9OYxkvw9Q9onagUlCxejRtzWxpj8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623571; c=relaxed/simple;
	bh=J24nVh/9jnhLIR8ZyOkFvOErw4twstnp62yM8dPj3jw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XJUaSpzy7pgCB5uZndGUK3GX5oKr8cY/M4hfx9PzmAneo5fFDXK9tVu8FLvsfD6U5COA+7RH+f9KoQEFD+XH7ryeYVSX362h2XQMrURty8+PWKy71FeTlhXGC7pq+NiJrwybGU4cfafBxa2SLX950Yzf7pu/JZZQ6i24wHckyEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R7xSZT+u; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz629wuvNLNG2/v6dDUwWPmG62CKD/AyO6zkjAjvDXafKnEbdQIcr5VTLy+x5vfS8HlFjGG9jAxkM46GwuZAtxlzIXF5Q845Qvpt15Fhb2jn6//bjcsHO2Lbw1d/717+3aOz/CI8C+5si5+6F5JLl6jeXNU1dUlMdI7eFXTT7jSRZDUB7cg4KQf5UNFlXEpMrTXPChIezQs/69jXTcrWdfSBYA8moqiiGy2o6peKg5snv3fbnEmig6oaMCbwypQfLFC714WS6ade8nSdSNajX23mvbrVQgcD99qd9V5IsjvOJDWj3/P0BCvXibup6ZZH/qen4UwV94LK8/QN3sJxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgM/OqIG8yST0OMj3lGMDvGrnXmfQBkx8CDLkILU9H8=;
 b=iFEUyoiAf/xhKkfnUYv1F/9pSRAsRFyWGGfM2VRRkz0wqdvxZW+lxeBicayqeftIeiLl+QbvBhMsUJJbAVfWXpKPu6cGZPKlAfP8lqgLA/rJpbMBMLXz/6pM/GFrAA+7nrystOe0Owcx7vuk2gQDusue2VSnu3rAsVoX1oHs3NGGx6MIBzgIPY//TwdldathmsbPZaroiCms7ICVzoMXH0ypV04HQnO4tVynCDfjm2o4zJ2l3oyqDDKUs4NueztBkXI58PMdb15oiSTsfPKVdgMLzOhHytEA67hZe7747xSY8Uzne+HxOMf2NLtjhL382pXzPS60v83ANc3SVVV/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgM/OqIG8yST0OMj3lGMDvGrnXmfQBkx8CDLkILU9H8=;
 b=R7xSZT+uI2RQI3n2ukeuqlX5QiY4lo8HVyodfujy4GjhANKqKzMQfgzac0hfIEjZsGZ2146nBZ3rZ40d9B77aRwEWiUrUH58KxpuVgwbbTkrJ1wZO1zVkCBkFicFkTC1fb/ldin42+5KxTIby3JASQU52eFKV7MpODWMg1tdlJYq9eytz0/nK6L9OCEPjSVcGB4gTgNxI2yaA9uPxRGab0G5m9ninAniJ82I9ci/93PtOg8r1x9G/O2M8qWcgVBIMZ8zv6RPZHMHt2Y8bMuwyhNBWqAwHsTe9IvKejNZvw3nLovtVjF30LKTCQro49AXavB8xL9NaISgj8TKQnZG0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:06:01 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:06:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:28 -0500
Subject: [PATCH RFC 09/12] dmaengine: ll-dma: support multi-descriptor
 memcpy for large transfers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-9-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623546; l=2158;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=J24nVh/9jnhLIR8ZyOkFvOErw4twstnp62yM8dPj3jw=;
 b=y44w3PSDPRnwYTR1zng0Hmpa2h6Vh9LeRgD0uPgLr3kAUoyonouftxmovuZBOzx9IQ7KU2hTQ
 LadiuB/WhnBANKC3cbxs1P5LXPJEb+FK3z2FUL345N3oUNwz4x0vp0K
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d0688d-5d45-460f-277c-08de5e97e53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHM1aUlsSi9CUVJHSjNUemlVU1J6ZE11K1I0ZXY5bXVvR1RtZmtsd3VPbUlM?=
 =?utf-8?B?UlIyRGxGZXVyYS82dFRCQmJEbTdLMWVLUGpMWEtFaDQyZk5CRGpzWlZQeDEx?=
 =?utf-8?B?VlcrS0VTKytILzM3RkhSdk1UY1JnbVhqcmV5VGpkYjZPaTBGSlRPSGZDWGdn?=
 =?utf-8?B?eGViNlRNYTN5R04zYlhvS1RNeUhYZ3IzdjdSMlphUU1pRStESGRKTnJlNDlS?=
 =?utf-8?B?RUNFSTZiRldrbm1EVHNwZjNhamUrZ25LVGJXdE51MkRiOFpuWEFibFZCaGpV?=
 =?utf-8?B?UXhkd1Vja3g3VU90eU41UkRUUFhWbitBbkFGWEdsbVF5RWJFN2h1ZVAyU3g4?=
 =?utf-8?B?a1pvWXBHM3N2Q1M2aG8rbGFNdUhQazcyMjhxd0QxeEY2Z3B2NDBObG1ZQXZl?=
 =?utf-8?B?cGlJVEozMGJzUkVweXVLRkJ6UUVFeDJwMDVkR2h2REo2UjlIdFZDZnhrTHA3?=
 =?utf-8?B?QUlEOFBqQ2RZUDJrTnprVXcxWkJMb05HRXpBenU0TXlwTGR2WDBvUHYwN0NX?=
 =?utf-8?B?aGtXVnZ2R3EzWC9YOFVUWjdjUndzQlk4RWFDZkR6NmVDd3lzZndtbUpwa1lG?=
 =?utf-8?B?NFViMjBMTEFLSW5iZ1IwbWxtdkc4OXRPUTRqVVdsd3FVZ3B3SHorc2xCMzNz?=
 =?utf-8?B?Tk82MXkyZVdzbXg1RUl2NGdXTVRCZzNLQVhGd1JFMEcwaDhyUHV3a1JJaktP?=
 =?utf-8?B?S2hYdXdkbmpvTWdrZmx6VVdReWxZZXZoWittWmsyc2NSWERPNHlSdGx2clZD?=
 =?utf-8?B?QlRJdVU2R1JTd1Y0NkNQQ1BqR3pDbGxVM0hZNEc2T2FOWXNTaUwwbTdtZHQ5?=
 =?utf-8?B?MVpxOXA4ZnpneHQzWVlEZExUaXM3SkdyRGtobS9xTUZXMDkzQ1lmblRHaEZv?=
 =?utf-8?B?Sk5oQks1TkxIS25SSU5oR0paZDNoK0dXNG9wUHNsK0podWZjYkxXVzRidDZZ?=
 =?utf-8?B?dDg4aFVHSVppTnAxblROMHl1YXJROE5uOFhESmN0QzMrVlVucGJnaXVuQWdh?=
 =?utf-8?B?aGYreHJ4OHZaQ2REcENOMUcxTm4rYVUxYmZVb0pKTXNvM3JYV2tOVXA0SnFl?=
 =?utf-8?B?NFdzOVNOdE5ZMlBSamhzRXZPL0dvdXpNRm9nTnMzVUQ1NUhyTEUvekVaUUNs?=
 =?utf-8?B?RmV6Kzc1ZlVtZmU5NjhFUWttRFcxTU9SMGNMQVEwZXJlWjl3ejltT0NKSFJX?=
 =?utf-8?B?Y0NuV3BkU3dRQ1NCcWhGY1FMODBnRDdKSll3MWpLcHJqMFZHY0hkTnVTd2k3?=
 =?utf-8?B?YnNiR2VXSFhUb0Z0bThsZEk4QW5uRnVnMFNIcFV6ZnVrWThZSkNzRllFRklw?=
 =?utf-8?B?S0hTRHE4SlV1bWU3QXR0SjVyZ2hqeTJoSEJPeDBEVGg2UG1XU1NkR2NjZnU3?=
 =?utf-8?B?Yis0WXBWQVc1ZC8rYTNFMFBJSjU1U1hocmNBQWNwWkdJcUt0MERBRkY1Y0lV?=
 =?utf-8?B?VkliS2RNZUVmMmJ5K0IrTThaTDcxa2ttMWtqN2RRaGJhb2kyZjMzQmdtWFZD?=
 =?utf-8?B?dFN0OHhsN1hFbXhIL05lajZNWHU4YTBnOWtTbnA2NDJZVy81WVl6OEhxam9t?=
 =?utf-8?B?MHVSZ1M0UkxSTjAzK3Y4WVhvUHU1c3BvZ1hveGZjclVxZkx0V2Z5amU0N2gw?=
 =?utf-8?B?OXRQSlhmNWwrTHpnN292SmRBT1g0NWo2RVJmRmRzZS9tYkZybjZURkxiTmU3?=
 =?utf-8?B?ZytxQXRZZ2FoRlF6M05xeVI5QlJIRzYydWZicHhFMSt0dVE5T0VuQUdveW1V?=
 =?utf-8?B?cUMvZnkvY2FPeGlJaVpUZXc4Q0ZhM0hhN3JLeU9NZDVtbmtMRVh2UC9JV3BO?=
 =?utf-8?B?SnFtTmxrdERRSk9YSVpJVFFMTm1zaVpiSDQrRGl0ZHlBRDByVWwxQUJSQjFI?=
 =?utf-8?B?SndMeXM2dldCN3EzUFpESDRCbGh3WksyY1BkQzRIQU9JQmE3OWRHRHZxZW1B?=
 =?utf-8?B?SzJQeGhwRXNLTU5vS3h4THBESlJOVFF4cFFDQXk5K3dmT01wYVdGbXZXZk1U?=
 =?utf-8?B?TWE1OGdCVVdKaE9JTnR0UFF2QTh1cHlWTWlWVE1mV1FKa0hRaHFIOXlxTDFP?=
 =?utf-8?B?c3BNWXRRYXRUamZMQnJGbWZ1ekNpcXp1QTFlUWlJQnM0M2ZTeGVwYUNiZE84?=
 =?utf-8?B?a050dVBTSTZweHVxeGxPR0FRZ3NlSEVvVlBvRUNIdEx0NWwxMG1KRmdzQU0y?=
 =?utf-8?Q?H7yTwQJzhfikqXpLN4ivWpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlZWOExvblgyQVNkc1lqQmsvaDNSb0xXWHNRWkI1Y3kxZEhYMlp0Tk9HZ2dG?=
 =?utf-8?B?WGNKYmVETUV2b205UHUzRVRuK2NGME9jSzlTZU1DbXM5Z3NwY0toSld1R2d4?=
 =?utf-8?B?ZHlrM09WK2xBbVFYSGxya1FzbjBaTXpHYWl4NWJVbmkwUU56Z3NjZjMvTGFx?=
 =?utf-8?B?ditZS2F5OURTcGdGUGtFSkliZll6bS9wNHBEOUx3bmR5TnRSUWUveXFkMWRU?=
 =?utf-8?B?ZnE0K2M1TTZid0JKTWNWWitWd1JqUFJVd3pIZ0VzRkxkdHhMQUN2VFhWdlBY?=
 =?utf-8?B?MXlCclVHMU5QTFdyeWt2TGQ4ZUNLRzVjRkFzSGNLcDdZSXpQQWV4ZnZXcERu?=
 =?utf-8?B?cHJ5aUR5ZFFXVWttVnN0ZnRheHc5a0RHUThJQzRIdnR5N0RMYXA3NmdVdVMv?=
 =?utf-8?B?ZWFkMjBNQ2Z6OGJJQ0FzWUxYL3c5ZlErdE4vRXRtdmR5dnEyZkFNODBSdnVP?=
 =?utf-8?B?b0xPeE95UGMySXFCVGNFK05CWVk5Z3hVbk5OSVFlMlNjMjQyeTNxQXV1OGtw?=
 =?utf-8?B?c2lLU0hXb1crMFRYUk1Ja3BMa0VKYjdNT1JTak4zdjkxUldZbS9iNEhxNlM0?=
 =?utf-8?B?TS9CRzNRMGNBZXkydzJwTFVsYTFtSFkzR3pONzZuSk15OFdKQUJpQjZyc3Bn?=
 =?utf-8?B?amtueVFxeXA5TVJVc2MvU0JVSk95cE9PbUZrZkovUTYwQkNjb3VCNmxMbmdh?=
 =?utf-8?B?NmRLTmhjQTlLbjlKTlBicG5aRGlYMldibUhBeitHU3NyN2d1bFZMQkl0S241?=
 =?utf-8?B?dHpuOW9heUhTcnYzbHduVEdESFcrOVpOcmcrMm96QUpINkJFV3U2TUVkc0JD?=
 =?utf-8?B?NjBlMk1LNllZRWlvMDhoUmZaT0U5aXZEMVpNcXhQS1BWNTVtYkhQdXNHaGFH?=
 =?utf-8?B?bEhHY0N2QTNTU3lGSzRIK2U0bnZYckZuZ1JuU3o2amowVmkzNmVFWlpWSlY2?=
 =?utf-8?B?d3N4Ny9ITlNFbVNibVlUcW1ZU1JXaVVNTW4rWTBPRXJmNm1iYlVJbXQzSDBn?=
 =?utf-8?B?UUZMSTFJNE52eGl4WXNxNGZXRFpOMmhwV2JzcUxzL29VQ2RUajkrdVRsUWxY?=
 =?utf-8?B?ZXpLOEpENmVXRjZWU3pENk1HY0owY1ovRy80SW1XbDE1bXRYNmFnQlpNVnF0?=
 =?utf-8?B?UG4yM3BGdUlSNkJaWWN4OC9sT3hEZm4vUDdldUhLREU1T1Ewa0tLd2R6bXQy?=
 =?utf-8?B?YXlZVDVha1hYcFkzeTlRTnVxeW9KS0xJd0lTaFQ1WStVeUYzQkJYd2Y1TFA0?=
 =?utf-8?B?ZzdrbE1POXRybEo5aVI0TmhYOGQ0YXdpcWIyY3RsTlNKVEl4RUliUDU5NnJI?=
 =?utf-8?B?TTRQVHY4c3hRQ29Ta05SZnhLMTlUdkJPL3VxSUYyZUJJTWNDN2daYjQ3NnVp?=
 =?utf-8?B?cDdjdjM1M1NpY0xMdXZZQ0NiTTdqd1NwZHNCeVovdHdUNElXOWpYckF1c3Y3?=
 =?utf-8?B?dUFVcHFwOC9BUXNsSk1IQXhKNkZ5S2ZPUDl6UFBxanR0dXpYZWc2TlpPT08z?=
 =?utf-8?B?RlkvcUFBV3o2aFBHSjk5NDdYSVpwTGo1d1ptNjYyQ1V3TmlEaENjc0N4WW5h?=
 =?utf-8?B?Qk5ONWhPUXl4Wis2UmdBd3picm9DQ1oxWG1UT3Q2Y1lPbnpOaCtoZVZCbnN4?=
 =?utf-8?B?UGZHRlNGT25DeUViU3ZNTFBWck41K2k3bThzb0ZxVHhUZlAvV0paZUZyZTdT?=
 =?utf-8?B?cGJkOG8rck91RUxDMnRoR1VYSjB1SmV3SlBIODZtTmZlbEIxMzM0YTRCclZR?=
 =?utf-8?B?ZTVwRC96ZWtZSU14SERYbTBhMTUyNDlRcEVjUnRoZkkwUk1ISVkrdzlHYXBn?=
 =?utf-8?B?UVV1cmsyZWlpeUxmSmREWU5CTlp2RlRrNnZEeG5ISVlidDFPNmdMYkxUekQx?=
 =?utf-8?B?Qjdvd3lFRkt1bSs4R1ZkelFJU1VObnZBaGhBYVAveldFTmY0R1pBd1VzV29Y?=
 =?utf-8?B?TXpJNFR4S3JOYldOT3hFNVVlYUZGR3VBcHVsaEFsdTF6L2NFSk03OU9tdTNT?=
 =?utf-8?B?RVlzK1pZejdCWGJQL0pwZEMwQUU2MEN0VnpyUU9xWjBhZFF2M3RibnMvayt4?=
 =?utf-8?B?dXpNRDZwdHdnL29mRUMxZWIyNG1mY1J0UWpobk04anNra0lUdXI4YUtBZmpv?=
 =?utf-8?B?WGZBRXhLeldxUDZ1Z0Rob1FkNTVZbjRuTGtGSXJmVXRWRWIzSkNNbW80eVZ0?=
 =?utf-8?B?QkkwYzJKbjhacWlaSEpQZkRJcHZXSERtV0ZHRjM2clNxc0Q4cnVibDV3K2VE?=
 =?utf-8?B?Z1lnMHpONHRhR0hIQmhXdVlFUU1aMSthUCtpZHRmRitSNzg5cHZTUTVQUWlq?=
 =?utf-8?B?OWtMcm1vMGJySytKSEgrODRJTldlUzd2VGtFaXNkczdOMVlQYSt3QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d0688d-5d45-460f-277c-08de5e97e53f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:06:01.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPYEF+GL14zzm9KCdm+ipCCnzaXmoVbX1ls3FF9H/9sHwgJNa1LtSjkcMlxXps7NUxlLcJ1kXmzs/qjLehqsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8565-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: 63DECA7887
X-Rspamd-Action: no action

Each DMA descriptor has a maximum transfer length limitation.
When a memcpy request exceeds this limit, split it into multiple
linked DMA descriptors to complete the transfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/ll-dma.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ll-dma.c b/drivers/dma/ll-dma.c
index da13ba4dcdfe403af0ad3678bf4c0ff60f715a63..313ca274df945081fc569ddb6a172298c25bc11c 100644
--- a/drivers/dma/ll-dma.c
+++ b/drivers/dma/ll-dma.c
@@ -17,6 +17,7 @@
  */
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
@@ -76,6 +77,15 @@ struct dma_ll_desc *vchan_dma_ll_alloc_desc(struct dma_chan *chan, u32 n,
 			goto err;
 
 		memset(desc->its[i].vaddr, 0, vchan->ll.size);
+
+		if (!i)
+			continue;
+
+		if (vchan->ll.ops->set_ll_next(desc, i - 1,
+					       desc->its[i].paddr)) {
+			i++; /* Need free current one */
+			goto err;
+		}
 	}
 
 	return desc;
@@ -107,21 +117,32 @@ vchan_dma_ll_prep_memcpy(struct dma_chan *chan,
 			 dma_addr_t dma_dst, dma_addr_t dma_src, size_t len,
 			 unsigned long flags)
 {
+	unsigned int max_seg = dma_get_max_seg_size(chan->device->dev);
 	struct virt_dma_chan *vchan = to_virt_chan(chan);
 	struct dma_ll_desc *desc;
-	int ret;
+	unsigned int ndesc;
+	int i, ret;
 
-	desc = vchan_dma_ll_alloc_desc(chan, 1, flags);
+	ndesc = (len + max_seg - 1) / max_seg;
+
+	desc = vchan_dma_ll_alloc_desc(chan, ndesc, flags);
 	if (!desc)
 		return NULL;
 
 	desc->iscyclic = false;
 
-	ret = vchan->ll.ops->set_lli(desc, 0, dma_src, dma_dst,
-				     len, true, NULL);
+	for (i = 0; i < ndesc; i++) {
+		ret = vchan->ll.ops->set_lli(desc, i,
+					     dma_src, dma_dst,
+					     min(len, max_seg),
+					     i == ndesc - 1, NULL);
+		if (ret)
+			goto err;
 
-	if (ret)
-		goto err;
+		dma_src += max_seg;
+		dma_dst += max_seg;
+		len -= max_seg;
+	}
 
 	return __vchan_tx_prep(vchan, &desc->vdesc);
 

-- 
2.34.1


