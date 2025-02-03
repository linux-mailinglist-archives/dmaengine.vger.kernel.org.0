Return-Path: <dmaengine+bounces-4264-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1DAA2606D
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 17:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DAA3A3AA7
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18520B207;
	Mon,  3 Feb 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="isRhWrCy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="isRhWrCy"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67624204C31;
	Mon,  3 Feb 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601028; cv=fail; b=U0pAlS/oYrqZqdOGKlPOdcw/eeyZBGeVDM+MVW+fmLQcgYwV7hCueizfUiDoUlnQOeZ5ucqEeIvOFodCR7+zqcV3Rg59Djy9W4xu5qwyhA5V6hvoe9aPXNhOkGuFnGyy/VTfHW2pvdpecj3ULmGH5yL6ytVGQU4NA4rEZ7EY/xg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601028; c=relaxed/simple;
	bh=7YKztA7fdHpaqdoCcR9sTzMYrPDsS1sKnzzD7GysFbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nKfYwWXmiJDx01/X4Lh2L2paREWGW9KK55hcSaGEqYOAkqGKybFGqLrrHzy/HJGO8ToZIdXCy8GOPOGDyTpfFKoClVSsATJ43WRUpcO1lt5BX9kzh93Lr7UsxK8v2167zcdv2sM83i7orqubMwM0lHSogwe0RsqmIVo8XQhcbcQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=isRhWrCy; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=isRhWrCy; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZjbR9/jlt7Fj89tWZmVnplDunjOvmdbsOf9E6rD05Y22rsmabeZCO+zVD9v3YVlz9c4DHv50JrBjcyRga68yADx8+xoFr9MUGyftLZzKfrtC3ULSwq1jZY0j6ntEIWwCvyS06uli1+QNie2aybkp0qtjyJkRim86Ws8rQSkCylXoBJZAeAnHQJcMj8YlMmVn8bE5mmS8WxDqvYKzLuGjsHWbbdwffVjdsBa294gUXtqyS+DgN+ViE0wKguRBLjuYCCq6jH5uCOBY8uU9+ZfgOOw+POXz4nusYwqHcEUZ+XsufL+QxKE/tKbUUsr1HVC6C7D+fixn0LL1A9FMoOJMiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YovYaV1IB0d3IG0EyOIZHJq8T0KgPvnM8HVgRV8Tk0=;
 b=I+dpzMCNNz4stlmaHzJ7jjYQ0+tOzaJXZ6g6ftyGHuhyfyYU/a9LsoWJk5l+1Ifu+SSo88PyQtDQZMxtfNdajUzQjGnMgre/GYkzammiLP2bJTUMEsgYTdGPU6+BMYYGyR5R/0+Spf/E/qkiEOFqcIQsFpsRzlr0lc+tE7D77st6rMUyW2QB87/AzNwGxXEPpSz6AKN2OpblprVtqLgktE2Ps89RA/h6iFKc1kGgILYzJMpLz+oaDcpi7So0rm1fI25LzdZNRIBgQEpax/9wm+uTU+9Tu/e39cNKzigXDTXeIwOUDkSOWZwVb6WzXQ5a/a5s4lrotjjbcNQDGNqUsA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YovYaV1IB0d3IG0EyOIZHJq8T0KgPvnM8HVgRV8Tk0=;
 b=isRhWrCyJv1Bny/KU/+kOFf9mHi8dOPf0K2nQxNz9hlvib774DY3sV+2yynUOHMnHUYyIs1087+mLOOVHj3UFGd8ZbAsV1aKwYfcfaNXztdrkA8+38w8DO2JrfT/TWh8RHJvRwQPcTqVc6UmXqyH0IeZpZ3+6paKv7uxIpgNQSg=
Received: from AM0PR10CA0102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::19)
 by AS8PR08MB10072.eurprd08.prod.outlook.com (2603:10a6:20b:634::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 16:43:39 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:208:e6:cafe::5c) by AM0PR10CA0102.outlook.office365.com
 (2603:10a6:208:e6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 16:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Mon, 3 Feb 2025 16:43:39 +0000
Received: ("Tessian outbound 72f36a054dd6:v560"); Mon, 03 Feb 2025 16:43:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ea92f48b8bbde35f
X-TessianGatewayMetadata: hPoADkzqM3qy9TbyL41kFJ/lXTReNtTCql/NNtd8T/J6/Pyflxsojm+7FyQd8flwLvHQs7XbMGwl0L/1HMyjhLq1t6i1SlKMhCYASrIIznv49xJ3bHObfO8vDYaiZXSSIp+4Z/Zy8GMm+QfwqIjnATLtUYw5d0nfa1n5BYGy5Eo=
X-CR-MTA-TID: 64aa7808
Received: from Lc8418286d724.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2367C1F2-EBF9-4496-A9E3-D0C8FFDF8186.1;
	Mon, 03 Feb 2025 16:43:28 +0000
Received: from DB3PR0202CU003.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lc8418286d724.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 03 Feb 2025 16:43:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YycOy3S9XQqCpCbNx2O+Ws82iMMfd5oNGu+fqm0mBBYhOB/YHfjCaieFn0a5VlNwUzzyvp1YLHkbivwy/0YvshgQI8R9boMdu31YCLVzx0uFLg/yUzQUAMic5JYQZwCJ7rAstSezB2JEafRMawTEp2cV5lkyLJb+IWQU0vclK1xvzm7rGli3NrcSbyy+c3SLCdroIhdkPCJ1yd2hYpDmZve9TGQC4ttaWSB92tXm5DRk29m0Buu6AhPhq0r+Luz7nSY1QVnxqdAJJ7wy8M+WqEIXplKEFaeX1bB2patQrudKKVI/92UTaYmz+/v+bv2kC8SttURDQDeBCSU/x2Tfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YovYaV1IB0d3IG0EyOIZHJq8T0KgPvnM8HVgRV8Tk0=;
 b=OqRMNnKBvLGJsBV09dCD0O+1GCCYcHDj14nQXWOkaJYXeS9wBNu1/flW2+kSCLtHS8cLbHX4LUshK1EGY0DgiJ9caqDvWIPyfQLYqCQYgepbt8ASFM1P3ynpzPAh6/IXMm4ulfTsib54PZ7PNszhG/RJG2JkKlJu2fdq9FNn4FOPCnc8DaHSfB1bkp1KGde2riMbVse06JrwxauplBNrHrbEyM4/3sM4fNv78XX0Datq1aF4PYCVLaLWzsABVe+mMF1v6R4HFDm8fePmBmiRPB8kAVmRLZvcBd2A0lhJ2/Mjk+bv1x2yaItZm2N/jMZk1E2LI5fwCmJzu3DRauxTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YovYaV1IB0d3IG0EyOIZHJq8T0KgPvnM8HVgRV8Tk0=;
 b=isRhWrCyJv1Bny/KU/+kOFf9mHi8dOPf0K2nQxNz9hlvib774DY3sV+2yynUOHMnHUYyIs1087+mLOOVHj3UFGd8ZbAsV1aKwYfcfaNXztdrkA8+38w8DO2JrfT/TWh8RHJvRwQPcTqVc6UmXqyH0IeZpZ3+6paKv7uxIpgNQSg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com (2603:10a6:20b:574::8)
 by VI0PR08MB11198.eurprd08.prod.outlook.com (2603:10a6:800:252::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 16:43:25 +0000
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7]) by AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 16:43:25 +0000
Message-ID: <1f436caa-1c27-4bbd-9b43-a94dad0d89d0@arm.com>
Date: Mon, 3 Feb 2025 16:43:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali CSF
 GPUs
Content-Language: en-GB
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, nd@arm.com,
 Akash Goel <akash.goel@arm.com>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <3ykaewmjjwkp3y2f3gf5jvqketicd4p2xqyajqtfnsxci36qlm@twidtyj2kgbw>
 <1a73c3acee34a86010ecd25d76958bca4f16d164.camel@ndufresne.ca>
 <ppznh3xnfuqrozhrc7juyi3enxc4v3meu4wadkwwzecj7oxex7@moln2fiibbxo>
 <9d0e381758c0e83882b57102fb09c5d3a36fbf57.camel@ndufresne.ca>
From: Florent Tomasin <florent.tomasin@arm.com>
In-Reply-To: <9d0e381758c0e83882b57102fb09c5d3a36fbf57.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::17) To AS4PR08MB7925.eurprd08.prod.outlook.com
 (2603:10a6:20b:574::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS4PR08MB7925:EE_|VI0PR08MB11198:EE_|AM1PEPF000252E0:EE_|AS8PR08MB10072:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0abae5-88d6-4719-8461-08dd4471e99c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?V282VDFqdkdxV05TODVPeElBUStiZHFkeldaWDlhcGJJOWh4U3U1L0Z2dktK?=
 =?utf-8?B?VVJHakxXczlENXBHM0dOZUdMSWtxYU5aajJvQlJrNTJGeE8wMEIzMjhPc1oz?=
 =?utf-8?B?a3RBS1Q4REpiL0lpRTBOY1N2U2VQdmV3dlhiVG1US3o1UWt3Z3BKbzRXcUZN?=
 =?utf-8?B?blVUOW5mSHRqRFdYaU1FTDYvNmx2Y01LL3BJSmhFV2orOTZCZHhRM0U1QkJu?=
 =?utf-8?B?QUhKakJuQk5VUUtYSVpsL2NMb0p6YzMxTVJyczJpVmpuT2FKWlo2Ti9ld25u?=
 =?utf-8?B?RFVPQ3p6T3VhYmpOWWdqdVpsMkVlbkd3VVBoMTZxVVNGWFIwWkY0SWkrRGFI?=
 =?utf-8?B?Q3pxVkQ4SGhVSTN0dWJPT3NEQi81UEdZam9Bd2ZnMmFHZkcrNDlPK1ZESitI?=
 =?utf-8?B?MnhXSGtQdnc4SHdSS00waU9DNWY4MW5oRFFFaE5rOGpDbHJ5RGI1TEhrcElv?=
 =?utf-8?B?em4weWlDSEFvLzRhUkFVc2ZiRlp5a0pOM29xY09idk1tUDFxZmYxVTJlam51?=
 =?utf-8?B?RDU5aE1vbFVENXFSZlhpM1RTcTBUQ0xQdHg0QVB0a1pDMmYwVXJ4Wlh6U3ho?=
 =?utf-8?B?eHZ2YzRSYXoxOC9iQWhhVjNhanB0U2Q1KzAyZVpCb0d2SXFNTUVMNHlOM0hF?=
 =?utf-8?B?Q3l0aFRNeDJ3WGtNK001cmJGbm52TjlDVTZlaFBjUGp1TGU0OHVjbGpXUUNy?=
 =?utf-8?B?aFFYVzQ5c1U1aVJudEJJT0RYOVJ1cjFnc1FleUc3SUp6dEpVRVM3MEJjLzA3?=
 =?utf-8?B?RThrUExKSjhoejdRVXZsWGxaLy93Wm1TUkxlZnhDRExVUFVoejBqN3pNT0lU?=
 =?utf-8?B?ZzRkMmNlVVp3R0V2VU5odmg4UisyNUZFOGs5RzdGMmFCOTJhVm53dkJVeis1?=
 =?utf-8?B?NmRLa2lKMXpwL1NYdDJvWHF6eTVSUkxjclFjNDEwQzRKUnE2bmltVnUrL0FQ?=
 =?utf-8?B?Z2NFWUVwSjVZcUd0eDYxNDFGSFljZDhMLzVnRjVycUVKR3kxNkFIMmsxRi9U?=
 =?utf-8?B?K2pGN0hlV0N4aFAwQUVxSzluVGJGQW1selVReXdmTTF6akNDMUQxRDQ1Y1h0?=
 =?utf-8?B?RExCZXFkZWZDcENKYmdLUDZIY0RrREVVVjcxcDQ0WWRZNnRjamxLK0dVcXFw?=
 =?utf-8?B?YmVFZkJzSVJTR0t3STJKNUFTblNreE9jekNwQkkrbGxtZXNPeDF6MFp2dFMr?=
 =?utf-8?B?eVN1ekU1QTFqVGpJNVFuV3dwN2ZobGJHcjBNdlJsVGQrM0xYQjlYS1F1ZCtp?=
 =?utf-8?B?OGZ3SVpuZUhQdWlTdzFpc1hTWndyRzJMckw4U0g5ZG9jajR2TUorQmE4dEc0?=
 =?utf-8?B?NTdBTmRKdGFFTEZ3eFVuWmU1ckhUMUp4RmlhL2RXUURtQUY2WkZMZk5JNzd5?=
 =?utf-8?B?VEFjNEVNV3lxNG1lekRoWFc1cVZJMmh0eHc1dGxNT3B0OFlNaUI2bFZzMUxj?=
 =?utf-8?B?QlNobVZWVWhEU05Ha2RpV1Vja01LbUc5bnhScWZPY2tkMVBoTHpXbzk2MzhQ?=
 =?utf-8?B?Q1E2dFBJZW5CallaUlVBM3cxT1JwcDg0bDVyMnc3M0xwK1N5R3pjWWF0TUtr?=
 =?utf-8?B?aVB5WHQ1OG5NQ01OSGxFLzBwbmlpa1IrcnhZZkZ2UkwvSk1VMHJZWG1BRitr?=
 =?utf-8?B?Wkw3Y0pKK3dqcHNmZEIrbzNBUzUvek9xd3RJTlZYU1A1bVJiZGdTMlBjclc1?=
 =?utf-8?B?cEhqaUl1ZWhETlJEbk9kS2phVjdxbEVsdGJqazMxZWFQRGxpNEs3Ny9JZjN3?=
 =?utf-8?B?NFNyN2pIZnFrSkpTNURDZFUzK2dCYkcrLzdjUWFaT0pXM2hhZlgxL3ljQnNM?=
 =?utf-8?B?RHR5RUtqdWtxeTFDd3pTZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7925.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11198
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:574::8];domain=AS4PR08MB7925.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9117feac-9979-4695-df87-08dd4471e0d1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|36860700013|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTU0SDBKbjUrOFdNeEFBbXhzM0dIbGZ3Smk4SmNmOVVpWjFMaC9jcmxwZG9R?=
 =?utf-8?B?eFl1R2FMNGFiaDFwbkx1MHMveU1OZnJhcFlEbUhwbmdBOGxZNzhQNTlrcVRX?=
 =?utf-8?B?NEtjMThDWDNuV3F3WHVMUHU0Nk9IbFJlUndvV3ljT0txUTlmM1RiamlyOWQr?=
 =?utf-8?B?UmsyY2tXVzhDc2RTbXhvdlVGTnh6QlFwLzI0OFpydGtnUVBDcXBFWUlVd2I2?=
 =?utf-8?B?c1hWOWQ5cUQzVVhpOENUOXA5Rkx6WCtLZ25wbFBjNkxNMmF3dGI0TGZvSENO?=
 =?utf-8?B?QU1IWGx4R1RqdzRBRXE5Vy9uZytxdHlIZlQwRXZ6ZlJVTm5DekRoRXN3ZUw3?=
 =?utf-8?B?SlRrOG1XSkpTcTRIbjUyVGYvMzNLdzhLVXdmbFFaV3dOdHNsUlRMZnovVTBk?=
 =?utf-8?B?K1VOQ0EvSHUwdm1lb01yVHRWREVJcDhoVFNOT1B3MGxBTTFTVVVqVkRCMzgr?=
 =?utf-8?B?RG05VHRQL2MyU0doMU5ISVg1SGY5RE56eXpOTGllQnJCcm02MUU3OWZwMFNq?=
 =?utf-8?B?TldVRC9QbFBWU21RU2RoeWlXYzFzaWNIOFg3dXV1dERYcjBEd1piM25iSFRu?=
 =?utf-8?B?ME1hblFYZWQ3WDFsbTZDRkRjY3dLa2lSYVY3blRRZ0wrNjQzbFAxbTNMcGxp?=
 =?utf-8?B?TWJzNWtiMmQyK1h5Zi9NZzE1a1M4aXZZN2RCTlNUNWgwY2xnQktGcmxpWk1B?=
 =?utf-8?B?bFhIY3ZzM2JEZ1NRZ1pzUlJZRVJjY2FRWlR2VFAzbGx1R1Jsa2I2dUlwbE16?=
 =?utf-8?B?R1hRdHdyUGg3Rnd6bHExL0QyNEM5bXZpc05YVFVxdE9GTTViOUpheXVvd0tS?=
 =?utf-8?B?WERMcVZpL2hQZ25QRmJMQ0NNcWdGVHpSMXNTMmkzU0ZpNFJVU1I1dU14Uk5W?=
 =?utf-8?B?U0ZQNnJXTVdTMEUxbjIzVk9pTW1HSXVvNjFCMTdnZGRYaEtaNXIrdDN1ak1i?=
 =?utf-8?B?OFFFWGxTNVpjSjdmMWI0UGZ3aWFnSXE3clgwNXdvc0d4WERKY000MHpESitw?=
 =?utf-8?B?bkpyT2k2d0Y0TU00YmdJc3pzYmdsd01UTzIzWjNITTR5cUNuMTZOVXN3MGts?=
 =?utf-8?B?bjlodHFWaG56aXR1V0hTR2JYWUdVMUN3T0hBNTRKMFFMVzJwOEo2TWFyQkNx?=
 =?utf-8?B?MFNYWVVIeGNHTU9PQTJrMUJTOGV2dzNvd3JCV2JYMDFJZzNhYndFcklmWFN5?=
 =?utf-8?B?c2tzT1lrbVpneG55WnVkblgweGIvcUlwUUFOL2pSK0syUmlDQlR2RHZacHZJ?=
 =?utf-8?B?MCt1U0ZaWTlNOEZxSHJpak9WdjZZVWZDMnllRjA0Wm9DT2N6Q2ljME9pdG1o?=
 =?utf-8?B?NURkVWtweHFMRFFwTDNEU1BQenBNaFpPRzFKMjhKbTBBK1NldFRvM0V3QkN4?=
 =?utf-8?B?NU5OMVI1ckFLd1RPYlJsY3hMRThnN3FFazNGODAyUk9ZV0RnSGdEeTZLTm5t?=
 =?utf-8?B?SkE4a2ZGeDUzK0htRUo5NExSN2lPLysyVzdkUmVjSzYyNGUreGZtaXVadFNl?=
 =?utf-8?B?WDFvbmNzUFZYUEcwT2xPbkFEWEZvdmk0QzJMS25ZSTB1YnBSWUlkdHJmZFZG?=
 =?utf-8?B?VFZQMW92SEdidmdJNVZwckFkcVdFUm9yUVMrdVpMbnJwMzlpRmd4VGhaZEZZ?=
 =?utf-8?B?YXk2K09Od0xpdmg0N2FOWTExT2o0MlNtck1zUkhzNjI2RzB6Nk1teW1YZUxR?=
 =?utf-8?B?YWtFOE9BeERkdTMxRXRwZm93VExYaWxNM0hVZStKMkpBbXIzenJaUjdNUXVk?=
 =?utf-8?B?THB5MTRvWmtCVTRNWm8yN2kwZ2M4d2VGbEtyNnBxbkNGUm1LZGNjcG91cWsr?=
 =?utf-8?B?WHFuckN1d1N0V3BabmJsVWRpZktrTlBQYy8zQ2tYWWpJb3J2RWZ6dVZOKzdM?=
 =?utf-8?B?bDU4c2JTdGY5ckF3WWt4YjBMaFhFdkVCUzBKaDIwUTh1Nm41R0lCRWJpY0pL?=
 =?utf-8?Q?AmfhaPuLgTAgyn6oBp9TPVNWExLiFbjL?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(36860700013)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:43:39.5633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0abae5-88d6-4719-8461-08dd4471e99c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10072

Hi Maxime, Nicolas

On 30/01/2025 17:47, Nicolas Dufresne wrote:
> Le jeudi 30 janvier 2025 à 17:38 +0100, Maxime Ripard a écrit :
>> Hi Nicolas,
>>
>> On Thu, Jan 30, 2025 at 10:59:56AM -0500, Nicolas Dufresne wrote:
>>> Le jeudi 30 janvier 2025 à 14:46 +0100, Maxime Ripard a écrit :
>>>> Hi,
>>>>
>>>> I started to review it, but it's probably best to discuss it here.
>>>>
>>>> On Thu, Jan 30, 2025 at 01:08:56PM +0000, Florent Tomasin wrote:
>>>>> Hi,
>>>>>
>>>>> This is a patch series covering the support for protected mode execution in
>>>>> Mali Panthor CSF kernel driver.
>>>>>
>>>>> The Mali CSF GPUs come with the support for protected mode execution at the
>>>>> HW level. This feature requires two main changes in the kernel driver:
>>>>>
>>>>> 1) Configure the GPU with a protected buffer. The system must provide a DMA
>>>>>    heap from which the driver can allocate a protected buffer.
>>>>>    It can be a carved-out memory or dynamically allocated protected memory region.
>>>>>    Some system includes a trusted FW which is in charge of the protected memory.
>>>>>    Since this problem is integration specific, the Mali Panthor CSF kernel
>>>>>    driver must import the protected memory from a device specific exporter.
>>>>
>>>> Why do you need a heap for it in the first place? My understanding of
>>>> your series is that you have a carved out memory region somewhere, and
>>>> you want to allocate from that carved out memory region your buffers.
>>>>
>>>> How is that any different from using a reserved-memory region, adding
>>>> the reserved-memory property to the GPU device and doing all your
>>>> allocation through the usual dma_alloc_* API?
>>>
>>> How do you then multiplex this region so it can be shared between
>>> GPU/Camera/Display/Codec drivers and also userspace ?
>>
>> You could point all the devices to the same reserved memory region, and
>> they would all allocate from there, including for their userspace-facing
>> allocations.
> 
> I get that using memory region is somewhat more of an HW description, and
> aligned with what a DT is supposed to describe. One of the challenge is that
> Mediatek heap proposal endup calling into their TEE, meaning knowing the region
> is not that useful. You actually need the TEE APP guid and its IPC protocol. If
> we can dell drivers to use a head instead, we can abstract that SoC specific
> complexity. I believe each allocated addressed has to be mapped to a zone, and
> that can only be done in the secure application. I can imagine similar needs
> when the protection is done using some sort of a VM / hypervisor.
> 
> Nicolas
> 

The idea in this design is to abstract the heap management from the
Panthor kernel driver (which consumes a DMA buffer from it).

In a system, an integrator would have implemented a secure heap driver,
and could be based on TEE or a carved-out memory with restricted access,
or else. This heap driver would be responsible of implementing the
logic to: allocate, free, refcount, etc.

The heap would be retrieved by the Panthor kernel driver in order to
allocate protected memory to load the FW and allow the GPU to enter/exit
protected mode. This memory would not belong to a user space process.
The driver allocates it at the time of loading the FW and initialization
of the GPU HW. This is a device globally owned protected memory.

When I came across this patch series:
-
https://lore.kernel.org/lkml/20230911023038.30649-1-yong.wu@mediatek.com/#t
I found it could help abstract the interface between the secure heap and
the integration of protected memory in Panthor.

A kernel driver would have to find the heap: `dma_heap_find()`, then
request allocation of a DMA buffer from it. The heap driver would deal
with the specifities of the protected memory on the system.

>>
>>> Also, how the secure memory is allocted / obtained is a process that
>>> can vary a lot between SoC, so implementation details assumption
>>> should not be coded in the driver.
>>
>> But yeah, we agree there, it's also the point I was trying to make :)
>>
>> Maxime
> 

Agree with your point, the Panthor kernel driver may not be aware of the
heap management logic. As an alternative to the DMA heap API used here,
I also tried to expose the heap by passing the phandle of a "heap"
device to Panthor. The reference to the DMA heap was stored as a private
data of the heap device as a new type: `struct dma_heap_import_info`,
similar to the existing type: `struct dma_heap_export_info`.
This made me think it could be problematic, as the private data type
would have to be cast before accessing it from the importer driver. I
worried about a mis-use of the types with this approach.

Regards,
Florent

