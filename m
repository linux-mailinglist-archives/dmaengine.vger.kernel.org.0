Return-Path: <dmaengine+bounces-4255-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA1A25B7B
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 14:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4083AABAD
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B248205E0C;
	Mon,  3 Feb 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eAXfW5xJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eAXfW5xJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013062.outbound.protection.outlook.com [52.101.67.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232B2A1A4;
	Mon,  3 Feb 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.62
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590790; cv=fail; b=VfBwhfU4jouUauoM/2zBwV2n6ElxthSTeDIkIszuw7ctJO7soSFobaoc8VmyCGx4inMlZd1qKb/5IO7cKuhYZNX89TJ3TA+8b7j3TRA8/qo100fRkCUmYFx8XWCQ0CVuXB69J2jPKU568NyBPv6REiXWJsCn3iXfUcyymnQp5b4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590790; c=relaxed/simple;
	bh=S2aPKaXCFosYTfNtd0lzN2jzrsqDcVVHDwkUoaCsEcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IYY9RxG4u6PeU03JB1rebsmn0enIWwpx8Nfwu4/l13vvfZCwjkR4QSyNooouCH3R1s4nJ97XdPrv4YgDa6M4kCzQVMi6Utc8cMFXjzQK9UpSit/sADvFPbr6PpmXQfaLKMEOjEWOBIVmS+RBkdtaLjsX60m/bWCDG9pvF88ExUQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eAXfW5xJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eAXfW5xJ; arc=fail smtp.client-ip=52.101.67.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=os/NOY59Zj03runZ4JhQ1PXWcRnVv7bDvCWv5tePDc2DuqKJqIUwNcHlscVhR7fl/XB66J4fBEQef2UiYScvnrDXABg5by8y7Q1GZwuTq71DVPxrVHGArlX4azixcCOkp5cIbE7DkNRkVbYhvHccWXY/ZC9azYiZg7U7hCPYGWu5Hu/laac6GMaG0oDVEnxn/mLNRTZOx4jYJnVroIdUoVmGqQnpvccYnvb7ekPFct2RtJX6YDR6rJMP+Bo9aowzrG6xZnBKKVenFENtnMzB4scfU+jk1FLqm7yEhtM4/6wJZJKlzZzWjXaLPN6Wg8W6DLijioVD3NCj74WKLaAHag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP0lVic2e3EE3KF8kqlGQOsyRt2qVrpeRbqFwGCjl6o=;
 b=JBPgRIBHJPBFGCZkENLHMs0ELlnmneO8xCpUBneUJNGN1o785ck0mL97lj3AYoBZJObqXcIotSb1oEn5HRRpxQwpC4+gbThxNi8Vh0VOYDu5gYy7J76ysyQUIWuG9x4VTFzL7TDolQ5yTOUmLHzeMRX/DcpEqo4b+RVDQR7/mamil5lg2HVWk7GWvRvGND159YZ8GFNLUQq9cDsOtR7waIA5m9JcQWSNj+5WOboKh6mfQIQ+eb/p7FUg2wPupAgp73Q07UomboELm/3zvyrPZbCUQclcwLNg9wt+3zE+5jdoQ4fpWsLtpzeWsWh2KX59iFzgCr7pR2AS3jjBLPP+KA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP0lVic2e3EE3KF8kqlGQOsyRt2qVrpeRbqFwGCjl6o=;
 b=eAXfW5xJPqL7qn20j4u4/4kNLfMJIyL1g1VqGCD1iHKEkK+8/AKKmGDDy5u/xs0/AKS5HqWvpJoonlufsJSZ192EtSlykDWVrESoiH6h5I5D0pqzlUcJ2tAfy2rjA94/qyVSbXlyeYN+6p1nJ+9hbgHRhGtF2SshLXe56PSMTK8=
Received: from DB9PR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::12) by GV2PR08MB8295.eurprd08.prod.outlook.com
 (2603:10a6:150:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 13:52:55 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::d9) by DB9PR01CA0007.outlook.office365.com
 (2603:10a6:10:1d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 13:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Mon, 3 Feb 2025 13:52:55 +0000
Received: ("Tessian outbound ca1ab514ff10:v560"); Mon, 03 Feb 2025 13:52:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a155a5262f928fa8
X-TessianGatewayMetadata: isaR7VsRjQaz22AlM+auSyWsiUHvKVv5KEZpqQBcqtSWMUbxSCXBJmMkNrMZ/M42l5ES6qXsmTAAei1uJqvVsMPoush0qMH+JYUv0ctREELmrAt4hp/z8qxtnLyLaVMykIbEf523WMWX+cNEPq1CsGuAXjDnTasD4+iDCDDShb8=
X-CR-MTA-TID: 64aa7808
Received: from Lf232805ead71.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D07E2FD0-3EB2-4A12-8ACB-938E0CFDB4C2.1;
	Mon, 03 Feb 2025 13:52:42 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf232805ead71.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 03 Feb 2025 13:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxXapb4Om8vwU5PapHTRiWCZSU+Jyg+67g8Px6LZBKmBM0l8HLsaZ6BqcH2wYFgMze+7C0OjjHRgGAZjclOTc0vBwKHEMmJvLLE7EzyZmPyOnlOTNTYU6EPC1HFRXLfAJtKH/tMjEXk/nzSMI4izsIeB3hlZ4ipK20HTcb1kyD8bbRYw5ggLEEX2+5DQ96tk3nbpyFkqoYHRoLh/5X1ubH3BbaGup58o0PV3Zc3JJPOd78d1WfjZKA2iGfJholtABoZH97zSVF/4rLsvbYiwvuIlgfSDnK/iZOLB7wKGo4vM7cee9n6U3LNCaV+OZZbjC/1AhHZenZ5biV+ULbikGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP0lVic2e3EE3KF8kqlGQOsyRt2qVrpeRbqFwGCjl6o=;
 b=Yky+s81vHt8Ck8SOMfHdSXiLDXsFgYcpPl46OMXdY/2SGYgfqScQ41ZwcIBRdB882baKYqux1LnbGkXg3VmRSy4+Y0Eq5XR4MbtIqANNvNIHrBSOWJT39If1e4P+ROTMBX0NdxhNcGNNlztLWvU9dRdbqFJlnE76anyGDk1xorQpQaq90uyAdE6CClp1tQxVe8NMiEQYQCC2yJk8c1ebdU+g7VqA5+TuypiMwQdLPDOUsATAPcWn4wlhrhNmEMUTqmUQZ8CvWJgRbeoodpPUTr17yiK64HtQmpaKfCYrGR4FREbn7CCiXiQaEmzR34nDbA82+D3dh3MciANsapsg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP0lVic2e3EE3KF8kqlGQOsyRt2qVrpeRbqFwGCjl6o=;
 b=eAXfW5xJPqL7qn20j4u4/4kNLfMJIyL1g1VqGCD1iHKEkK+8/AKKmGDDy5u/xs0/AKS5HqWvpJoonlufsJSZ192EtSlykDWVrESoiH6h5I5D0pqzlUcJ2tAfy2rjA94/qyVSbXlyeYN+6p1nJ+9hbgHRhGtF2SshLXe56PSMTK8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com (2603:10a6:20b:574::8)
 by AM8PR08MB6386.eurprd08.prod.outlook.com (2603:10a6:20b:362::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 13:52:40 +0000
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7]) by AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 13:52:39 +0000
Message-ID: <0fc22f56-1386-4b4a-bddc-0745ec8a3f9c@arm.com>
Date: Mon, 3 Feb 2025 13:52:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] cma-heap: Allow registration of custom cma heaps
Content-Language: en-GB
To: Maxime Ripard <mripard@kernel.org>
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
 <2255866ee9e81136a7099376b34b8305758ec9f0.1738228114.git.florent.tomasin@arm.com>
 <kyesso3gaajbdze3ie4imrmrk2lzqf6s7eoonlljeitfs3utwh@dycnl7cnzep5>
From: Florent Tomasin <florent.tomasin@arm.com>
In-Reply-To: <kyesso3gaajbdze3ie4imrmrk2lzqf6s7eoonlljeitfs3utwh@dycnl7cnzep5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0179.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::22) To AS4PR08MB7925.eurprd08.prod.outlook.com
 (2603:10a6:20b:574::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS4PR08MB7925:EE_|AM8PR08MB6386:EE_|DB1PEPF000509F8:EE_|GV2PR08MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 477a4d08-22d5-44e9-7bcd-08dd445a0fbc
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UGtXVVBPZWppRXpjZ3RFQlIvSE1sbjB2by9LeFdhcENpVW9Wd2cyc3JLYkho?=
 =?utf-8?B?WnpaNUZQWGFtbStHM1dnZVNaS3lhY0FJa1ZsbUQ5SHNwQW1jVTJ0RktiZ2V3?=
 =?utf-8?B?eGlla09taDV4K1NwbFVueUhHdWxDdVp6bUhZb09NN0dEOUhvZHJ1YzlMOHlS?=
 =?utf-8?B?VjFGMGtLakRZUnFFamFkNDhrcHJrTEI1NXphWFJVUU93MFlCcmdXNDJQUWhV?=
 =?utf-8?B?SEpMZ0U2TVIzME1kRmoyQjFlOVJvUDR6MFpUL2FjeUdrWGFKVk5mSmM3aHBh?=
 =?utf-8?B?c1lDQzJjUENIVjdWOFpheXBPRkVCck1uU2FIZWpVNkRHZVNjUFJ4b215Lzhv?=
 =?utf-8?B?N3Y5MTRxYlF5d2xPWVlqekZ6ZVdueXlVMDF1RnNnYTVMbkkwRTA0dVFqNFJU?=
 =?utf-8?B?eC9rdHhRcHpYL1JIL2lVL3lHSFhhKzU4cUpQdVNaam81emVKTjlsVFhzU2RU?=
 =?utf-8?B?bXBOU0RWSWhBMkExZmRvWDRpWERYc25pajErWlIvUFpCSUJ1NTcyQm9iUjUr?=
 =?utf-8?B?NGk4Zm9GNDhLbi9tNS94TE9OVEI4RjlmWGhIeGNWN3N4R0JIR3F2Nkp0djlQ?=
 =?utf-8?B?UkZxY1g0UnFBbS96Y0FVNk92NzBSYlBjc3hsYzlDeHV3L0RKeDdZc3lTTnU2?=
 =?utf-8?B?NGpyd1BQTXRVNXBjTVhXeXJQTS90WkVIYzhvWnNNaEcvRDRLMkh1ZkF6VE13?=
 =?utf-8?B?anhWS2lRUGZiaDJ3VTdhZTBQMlpDYXVEYUdWT3hSQVFiT3dTWTMrUnlSb09j?=
 =?utf-8?B?clgzZExwbitBWXhaQW5wUkxkcHJFU1hvRVlIU1piejJHY1BwS0F6WEFIWTJ6?=
 =?utf-8?B?K2pQQnBOZUgzN3BpNGdLU2JrcGVwdmM2MXhDcmxyMkY1QjVjSkdqak9NZlp2?=
 =?utf-8?B?WS8rN2N5Q0txU1NhK3ZhbTFJZytZR3ZZWXRGZHBWcnpwQ2NhQVVsUjNTRzR5?=
 =?utf-8?B?ZlU1OTNVbHBxSmRsOVF0MDBIWHplZ2o2TEJFaUpKVVZHb2k1RHlXS0NDTFNo?=
 =?utf-8?B?WHd0NExOY3NCUlZyQW4rU1FMM2pWU2w3bGdzakFHczNoVGFDeGxJWThuMXNq?=
 =?utf-8?B?cVYwZitoZlBwRDJpNEFINVZLSlVmTEdqdnhXU1h6TDhGdEdjMlhMUHpXU1pp?=
 =?utf-8?B?czM5QVlFZWJBVXlLQlNqWDZ3MEtybnhSYmdNWlczZktVVlpvL1puNUJZbzdm?=
 =?utf-8?B?Z0k3T0FuQjJwTUp2M1B6QXBmNjNvUmFEdGpMay9FNTl2UnZLVTFzM2ZORHln?=
 =?utf-8?B?cG1BbTk2ZldNa0I0VlkweFFNVjVyR2pZZTFHZEpOdW5iUkdsY1lCT2t6cEFM?=
 =?utf-8?B?dEtwUFdPb05KWmphMnFwckZlOGplYjFmZXdiLzk1RGRJYW1SZndRbmdRdDRv?=
 =?utf-8?B?cmFUQXZiZHZhYlFoQWRzd2FqdUdUSDRJVWlVK0wxWmpIaVNHN2VMTEMxdHFv?=
 =?utf-8?B?WjlESVRpai9Ga3o2U0l5UUVHL0U2a3dlaUExa0lPMk0wc05HdzI2OEJ4WW1M?=
 =?utf-8?B?UUJ0bENmWXlZYlJuNmlsb0YxUHovaTJWdDJaUmtrZGdRRy9ZbVdUeXlGTjA3?=
 =?utf-8?B?U3c4NHF5YmdidE1WQ3ZHTzYxRVpZNWs0Zm9WYm92dDcxbGo1ZEdTQXMrd1gv?=
 =?utf-8?B?T3lTeHA1QTdDZ1diQkhEOGN1dHpEWU5RdzVMZTVWTktPVFFDMG1tQitQUk1P?=
 =?utf-8?B?eGM2SitkNWpjeU9QamVmRHkzL3paei9TOGszY0VPY2pmaXNUZWswRmxKaDJL?=
 =?utf-8?B?dklBS0xNNVYydDE1d2ZELzNZSVpaK0NaSWxubU9BbGpXbk0rY3dYREhpZjlt?=
 =?utf-8?B?bGE4bnVTeU9ITGJqRmttZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7925.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6386
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:574::8];domain=AS4PR08MB7925.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	997e9b26-a0eb-4b3a-d3b5-08dd445a061e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|376014|82310400026|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnM2emF2TWF2OElFcldLZTF1UEZDQXZFcHBIWDNTNWxUaEcyd2pWK2JaSVNz?=
 =?utf-8?B?S1hXV1NPZlhkVVNSWVdaNDRndFVFc2Q0QUF2UHNxdTBLWmZxOGFPa09UbGNw?=
 =?utf-8?B?bVZ2cUlMcndtSThydkJzeWN0SVV5QVpqZzE1cmRTK3h4ZFFQUG5MU1A0SU53?=
 =?utf-8?B?SEFDYlhVdVU1OXdabGZGYzRORXFQYTFZQ3BSNm5oaWRjYkpiN0laWEZkc2Rr?=
 =?utf-8?B?a1pDZU1NZUcxWk03ajNTMkdaV3o3eWFnNXRhbm1FZ1VVUjZDTzNiWG4wRVdM?=
 =?utf-8?B?UnVSOVlRamIxNlk2ek9hclNrbXRkZTJvSmJ1YVFkNXJ6eWk1NnMzVGNoSmhM?=
 =?utf-8?B?b3Y0dTZMYXpCRGlUZWJXL2paUXYxTkVvdmMrelRFeXUxNmh1V3YyOGdhUm56?=
 =?utf-8?B?dFlaRXg2SFVzNTk4WFR1RWtZVGJUQTRUV3YwSmU5QnF5cU54V2Fjd0Fybi9L?=
 =?utf-8?B?dUFnMlRaT21peVgzaWk3Sk9YQjNoZ2o0UlhHend0L2NhVXFyclRpWDhuL2J4?=
 =?utf-8?B?OXQ0OXJJTFlxaGFmSExxNmtnZSt6TEw5RkZyZEJWTEFSZWNoT21NYStWdDJq?=
 =?utf-8?B?NzJIVEdsTkdhVkNJUE9kdlUrT01KeWhzWUpTWThsSTArcm9sSmt0b1liSXRs?=
 =?utf-8?B?aytHYXRDcW5SQ0lLOWpRRDR0RVhJOTJsV0xCUU13TEZKUHpOTG14SmxMQlpi?=
 =?utf-8?B?N3RMTVN1U1hqUWRwN0UwZE83SkpudUd0ejkyb2hMSVRLM2szTU91bERJckxS?=
 =?utf-8?B?SE5Ba2xFWGRxYzBuNnhZdWhDZ1o1ZzFrV1NDRTM3d1N4RVJkM1lsZjBkUitV?=
 =?utf-8?B?Yndqdno4MGd1R0xoNTlaQzh3VWN1MTBLSnkxMGpMeDgrNXhRWmovbmptZjAw?=
 =?utf-8?B?VmtGSnU3ZldzM1B4aFFLejVtTTl0cGFnVXYyREpRV2VtUndDbnpYYXdsejhu?=
 =?utf-8?B?N1d5MEtaamthNkhjTWhUcjN3RTBPdnlBRUZ2Mks5dlBYQ3JsMGorYVluSXZn?=
 =?utf-8?B?YTc1eDdlTUMrYUg3end1QzVjUUpVTU5XNWhaaXNCT1pRWFl1NU0yUFFldm5U?=
 =?utf-8?B?YmMwejFEZWdndlFtSCs1bkVYYjBhSmxIQmJhSC91ZG80Q1BoVHVaR3JmNFVz?=
 =?utf-8?B?Vkk3SUhhMC9kbnAzNCtldnpDZ3krQ1dzVytnRGtscnJBYXRpWUs5TG0yM2FT?=
 =?utf-8?B?YU9rUm1hSi9XZ2RpcncwOStPeWtxamt1bFg4REkrYUYwWlVsUDRXRUhlajJP?=
 =?utf-8?B?YXdMV3dmejZTQVEwTXZvOVZXUHhFQnlxL0k2WDZiakIwSTgrblo0WjVvckVi?=
 =?utf-8?B?RHpVS05Ua2RXRG0zUjZiM0hwanpIa043WWh3ZjdiYVJpTExrZGNaaklwcHp1?=
 =?utf-8?B?dWJ0dUZhWkxRWHVTd0RqMDFyWG8wZWZrblJRREcrWDhNVURDNWxERnlOamZi?=
 =?utf-8?B?eFJtYmU3bjhMY2pwcjFNNzhhNndJK2tWQ2s5OGwzVnZJUGZkQnBBNm52SW9D?=
 =?utf-8?B?SkF0UjRzRjM4c2Z1NWI1Vm9kdnNaN2lveDhHb21KTWJ5bWQ5N3dzWXdWRDNG?=
 =?utf-8?B?UVpQM1FqelFlVTdQK3VjdnBEOFJEK0M2YmhsU2EwTFNNWnRlZkZLSFp0aWVX?=
 =?utf-8?B?MlVYTUNoZWk1a0NQZ0NRQUpEcDJxWEdmVlZRbStxeWFjU2hRMXAyWVJSc2lR?=
 =?utf-8?B?NjBzNkI0ZkhGME54K3pudm1kTGhiUnl4N3NjdUFBd2l0QWx4eG9IZ216bVdE?=
 =?utf-8?B?YnpqVGlITkpnTGtaZUFkNk5YQytFQUR2K1NxOG1ZRjRvZ0M2dlZtTnRaNXg2?=
 =?utf-8?B?Q3ZtOS92VlZjam1XZXI3RzJyaFp0bXE2Mm5uK25VZXpEckdGVlYwYjMreDU1?=
 =?utf-8?B?OWVqVEZpRDB6NDRjZDBOeUlzZThjbXUyVGVvVmN5SXF6NTZld3Rva3QyN3BL?=
 =?utf-8?Q?+7XQDAxf/vs=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(376014)(82310400026)(14060799003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 13:52:55.5890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 477a4d08-22d5-44e9-7bcd-08dd445a0fbc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8295

Hi,

On 30/01/2025 13:34, Maxime Ripard wrote:
>> This patch introduces a cma-heap probe function, allowing
>> users to register custom cma heaps in the device tree.
>>
>> A "memory-region" is bound to the cma heap at probe time
>> allowing allocation of DMA buffers from that heap.
>>
>> Use cases:
>> - registration of carved out secure heaps. Some devices
>>   are implementing secure memory by reserving a specific
>>   memory regions for that purpose. For example, this is the
>>   case of platforms making use of early version of
>>   ARM TrustZone.
> 
> In such a case, the CMA heap would de-facto become un-mappable for
> userspace, right?
> 

It could be that the CMA heap or alternative carved-out types of heaps
are made mappable to user space. An example would be an integrator
decided to implement a single carved-out secure heap and have both user
and kernel space programs allocate from it (using the DMA heap
framework).

In the case of Mali CSF GPUs, this same integrator could have decided to
share the secure heap with the whole system and protect its usage with a
secure FW.

>> - registration of multiple memory regions at different
>>   locations for efficiency or HW integration reasons.
>>   For example, a peripheral may expect to share data at a
>>   specific location in RAM. This information could have been
>>   programmed by a FW prior to the kernel boot.
> 
> How would you differentiate between them?

For that situation, I relied on the API exposed by this proposal:

-
https://lore.kernel.org/lkml/20230911023038.30649-1-yong.wu@mediatek.com/#t

The heaps would be distinguished by the name they are given. Therefore,
in the CMA patch, I retrieved the name of the heap using the label of
DTB node. We could do it differently and have a specific field in the
DTB node to assign the name.

I assumed it would be possible to call `dma_heap_find()` from the kernel
driver. The name of the heap would be known by the integrator. This
person may decide to hard code the name of the heap in the importer
kernel driver, or pass it as a property of some sort: insmod module
parameter, DTB, etc to make it generic.

Florent


