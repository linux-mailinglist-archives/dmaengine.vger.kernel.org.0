Return-Path: <dmaengine+bounces-4257-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D8AA25FB8
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292951885278
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFC5209F55;
	Mon,  3 Feb 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ot5YHTNj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ot5YHTNj"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D72204C34;
	Mon,  3 Feb 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599523; cv=fail; b=heG0+PmLuJ81R8tPfie5i1ealaFRkGxduNOO1BOmAs+eWdbzJC55g0D9YYdHIroxivkVR9SbCb54eSdDK6USJSY6Am5t6qfdkeIHhVTonPG/zdQw/Wmoi2UtocArMd3JRXltl/VunCMj8Y/suaK9kIRwlFq/MmrEygrn9ykh6K0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599523; c=relaxed/simple;
	bh=cYNKZEBjhaZYEW2sLuAXWu6sijj5SfeJfSt2pCgmPZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GT18XkkxO/QpRF6KjTPscQrvjMIb2H2k1vo0YW432hAvFjAmp6XJhsrfXy9bENjjvZt11eUMppkTAGeX9TM6/cEc8rAZlknaDLKH6+x8IuNnliiU1NxQfHpnEexE/fuxITEZ0PzGvxRA7BDYXV4rZ2GmLErO5Rq9k77bSQexKGM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ot5YHTNj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ot5YHTNj; arc=fail smtp.client-ip=40.107.249.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nrNk7EzdAwwk/o9Lubityb5dZUaEYPDL/u1r5PI/uggFVsfn1IGp94kD/bPGWzOWsHuvQefsI4WIwfSbTS9Hzo1ceZaDs1Ljuh1kTXxEEyYgNSWkVUE4x8hTEzmV49BMyiR8dPZ2T1PfnY0PFy2EaSQv2NEx2/c0GnwuMrDtzTI9XA8rMpf1ZPu0wbyBt651i9Oemt/+Cu3FLRVzT795yH0xMhmNZ4Kl56orrsgE9EX0tAyPnXvmoSMFTjCV64svjVLWtGm2qLJhC7rjdTNmnlQXscElgbOvUHqNcYG3n3juxw6kzNwsgbuAwIDpfnPwHd0ZQ18A5l6Z0DLEU0Tjgw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zifuO2tonzJmwTlnuAPbsPW3uAohnLSw73u78DuPaO4=;
 b=dhH32rKHyIRWll0M4DjbKiCF2ZJSSw9ZVC6ujGk+cHTIOpkCUhtOKiuSdDnj+mD5L0Kel6EPVA9AWdJChY4vrwNm+L06U1RgHIhgMuPpkI0UUlV9qDv11kfG0iaTitTcjcTBDjj0VIxioViW10JFHz6f8d0/89yuVq9R/9v0UF9yZuHKS/+qj6m0F0B4jl2kQ7bGlcS99Pax+3eIXzKFyEZDsiBL+6IvCDiiCW8HFNtCiUeNG3NnzCuM1JIdUNTt6/EjHkwIi4DIR3L90tP4F+xsEzCQ30psLbiynFDuoGMPlmo3nTW1vJeyoKt32ARtJZI79qcn+pj1PuMtlmy5sw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zifuO2tonzJmwTlnuAPbsPW3uAohnLSw73u78DuPaO4=;
 b=Ot5YHTNjhoTXCRWAnQr8nQdCVsWxCQIgqG6vvkxQiB2GzWGQ75VAeR7WSEzT/z4oIM7ACMfw2vkDNTCWpQ3FkAo0kMF03nkSOS7QkIDjaFlcHIbTD7EDS0B6S2HPmKIE9HYZnyDGxjbOfqdxeNyhguXdIxNmVX+4FqGUfOfHI5k=
Received: from DU7P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::22)
 by DU0PR08MB9873.eurprd08.prod.outlook.com (2603:10a6:10:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 16:18:32 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::9d) by DU7P190CA0005.outlook.office365.com
 (2603:10a6:10:550::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 16:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Mon, 3 Feb 2025 16:18:32 +0000
Received: ("Tessian outbound cd7bee7c735c:v560"); Mon, 03 Feb 2025 16:18:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ffce7ae0a8ee4c9e
X-TessianGatewayMetadata: caav6sjM225plv59iPv93LOXIqRgvcp7ocs5QZSYAUrcB3444h2EljknyNTWsu9VTmxeE2YNqgNmJCfqMsjrrRlwk97BZkjpqVVv4KiLHAQi+rX3seLU9dXdHLzg54WWoB+HsfPZGJJdfrfpX0wzfbDGea4BMoPhWHdhAJKtohY=
X-CR-MTA-TID: 64aa7808
Received: from L2b18d4476b64.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D1E5D331-30CD-404A-BC9F-4703CF12BC90.1;
	Mon, 03 Feb 2025 16:18:25 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2b18d4476b64.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 03 Feb 2025 16:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RllW1FR3d9tBvriL6+4KdSdIT418Nw1sCn0SOt8D0Crbek47DdFDFajzwwWWfSJ2q98oVYrEGBMjaQmuuHCr5gT3DnUgefvaZnJX2R5ViSx5XANhIW+cCeIDPimx2R7MdfWUMsr+lbPmMrv5g10vcbSxIG4rG+ZIA0bLv6OdBLWuQ3fNxWvGfA1FbnIarg9cqRL6RLmF9RKCe37fkDkQoR3gA0pjWSEhvotFsUGcxEmXlak/SqIZPA9QebRIqy57yd6YxWu97DtJH4lc7ezi79Et/GEY79ZKjZ8Dgtd472+ebWlTNrYjkZH18beGLXxgDFynaJ3V7Rs7Tkbw6QIQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zifuO2tonzJmwTlnuAPbsPW3uAohnLSw73u78DuPaO4=;
 b=wMcEZIIWJbpXoaGE6A+R3Gw/6LuGu7Iulnfl/aw4zAJibVBaEwU3iFyM61B1jzYNVHSfaPSUoDvN5w2oMoiX2qwnukePOTyb1VvWOORR7c/OBLEe7dREyeb0QZCMQRai3nFuG9CzU3N1acbDfOSYj14t3xUEqo+qglBb+YiNaMVAi6v+T/YirVjzAUc125KCo+upj8bhSFsq7bKS8h2PzndDvs4XR09Bo2vTg9j/YV79udHx0szGiZxVAMxUnOQBb++qikPq9SiNTEAV7w9+PBht1AAaxKbR4E7W8vWzeQ9f/BxWXFF8O+d14DYuWVP95eoIZdr8Nc/zN8/+Gyzcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zifuO2tonzJmwTlnuAPbsPW3uAohnLSw73u78DuPaO4=;
 b=Ot5YHTNjhoTXCRWAnQr8nQdCVsWxCQIgqG6vvkxQiB2GzWGQ75VAeR7WSEzT/z4oIM7ACMfw2vkDNTCWpQ3FkAo0kMF03nkSOS7QkIDjaFlcHIbTD7EDS0B6S2HPmKIE9HYZnyDGxjbOfqdxeNyhguXdIxNmVX+4FqGUfOfHI5k=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com (2603:10a6:20b:574::8)
 by DU0PR08MB9108.eurprd08.prod.outlook.com (2603:10a6:10:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 16:18:22 +0000
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7]) by AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 16:18:22 +0000
Message-ID: <c5f1ac22-6535-4917-9155-5e0d8fd9a74d@arm.com>
Date: Mon, 3 Feb 2025 16:18:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
Content-Language: en-GB
To: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
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
 <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
 <20250130232004.GA1818629-robh@kernel.org>
From: Florent Tomasin <florent.tomasin@arm.com>
In-Reply-To: <20250130232004.GA1818629-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To AS4PR08MB7925.eurprd08.prod.outlook.com
 (2603:10a6:20b:574::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS4PR08MB7925:EE_|DU0PR08MB9108:EE_|DU6PEPF0000B621:EE_|DU0PR08MB9873:EE_
X-MS-Office365-Filtering-Correlation-Id: fd95407f-b0c5-4718-8f2a-08dd446e674c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aVVkc2RhZ3NwTDJySlNkMU9icmY0bmp2aHdYL2c4TzhVV1FpeFRLbUtSQ0tN?=
 =?utf-8?B?VDZkUllzWTNxa0pmbUdEcDExQm5YTUkwSHR0bXRDZlV4ME9aaEQwc3BVN0sz?=
 =?utf-8?B?RERPbTJ4a2habGtNRGRnbms0ems3VUYyZW1zNzNHN05GaTI4cGp6ejh5QkFL?=
 =?utf-8?B?b29oUFpOUDA2bDIyR08zMFFQQ3BCSS9HL3RGQXVaUEx0WDRUNm1hbUZydTNR?=
 =?utf-8?B?anBzSFRwQXBVaGJwVk5tRDRLU3NnQW1XUnVSSFU4ZVVIbzdwZVpxcjZTejhL?=
 =?utf-8?B?K0pDTHM4SW5zeDdWOXRnWE5rNlIyN0NkRDF0V0ZuRXpIQUhnRkhhdFc2VVVn?=
 =?utf-8?B?cEhoYWVJV1VNSWFwSXVPOHJJVitZSzk4TVNMd3FjVWxqOVVrNm1UNUN5STlr?=
 =?utf-8?B?SVY4dUhTSU5OeUJUeW9Yd2kvV1ZLbVF4SFlKRzhVODB5RHNFQTFsOE5QNTZh?=
 =?utf-8?B?VnBSSUk5S3VhdVdnWG1uY2dzT3hhOXhTMk1idDB0VkVJbUpWeU5GM2laRnZK?=
 =?utf-8?B?N1psUDJCVGhwOEFXWW5WdktpN0IyOCs4L1JYQm5yRnFxL1V5enE4T0xFZ3Ir?=
 =?utf-8?B?QVZDSlY3VHNmUDNTdlA4RElnQkFzenFDMFZ3ZGowa0p3L2RRRTU3Njlxc0pi?=
 =?utf-8?B?U3RsRWNpakhQem1XNlBNRWV3NXpSR0wwbm8xb0xxR0I1cXkrT1RoVTJHSnZ2?=
 =?utf-8?B?SSs4SE9tNitWOEh4WTlJcUdwRVZ6V0NzUExPQytHMzA3UE9BVSt6N2d4djhM?=
 =?utf-8?B?UWJMamtTZnRscmdWT3M3cGdCc2FXWjNxT0hqYlJZSXd6dnVuWWM3U0xGNmFK?=
 =?utf-8?B?Ty8xcUcyaEl2R3cxc2VKS1JIcGpPWFZYRUZTQ3pTbjhkWGg5d2JVQUlCcVRt?=
 =?utf-8?B?aFhkTkJsbDcxaEZhZldXQUp0Z1dWMmpmK08rZno5SUtnd1V3V1JKY21QSElt?=
 =?utf-8?B?TW5lMHJ2RWtFdWZ2KzZtR0JZMU8wN0d1QlB5cUJXejBwdG1HZTFFOVYyTUxH?=
 =?utf-8?B?bkI2WjN2MHdTRU81RVJ3K3lIa29uOTJIdmg5YWFCSGt3UjdmZ0ZoYkk4ZkFE?=
 =?utf-8?B?WVF1TkttTnZJejRpNFUzb0hnbXplUzlML2gyVDdGY3BaOUk1VGYwWHdTY2V5?=
 =?utf-8?B?YnBXem5UNFhDTFZEVDlvSXEwcUF4VVhYVlprZWUwUXoxaitpcGx0VGcxZHky?=
 =?utf-8?B?MGhGVFpNcU1DNnpsaUpuZXBXTGpUSFI5WG1FcXBOQmhaVVpIWFM0Tktlejht?=
 =?utf-8?B?SEVQT2o3RmdTRGF0Zi9LZmZGeFBmSVZPWnpYWkpUd2M2MC8xVHk0M0Zqc1lC?=
 =?utf-8?B?TUt2NmpJYkxNM1g0RzZHbUxuaVFhN00vb0lTeDJENkRTMXV5cC80dGZ4U1hj?=
 =?utf-8?B?TmpOcG9JcUVLVEhnUFQybHdNcWhFSTYzUzJmeHBmbk91SDVSQ3JOQkI5L3ZZ?=
 =?utf-8?B?R0hDWHI1RkxjK01UZDE0VjF2QkFiMTQyYmQxcVJGNklkWFRIMVNvZFdPbjd5?=
 =?utf-8?B?ejFhRUJRZjgzSGZUdk5TUDBOSVhUelN2dk9ZNWJUM3F4RW11RzJPRzJJQ2xV?=
 =?utf-8?B?ZzJiZnk2Y2RPVmlXTDVEVVRaWjJCZE9UZ1p2SGNWT3B1eWR6b21yNCtLb2l3?=
 =?utf-8?B?QTRJUnF6VHVpRVB1SVZzbjAvaisvcFY3VUFaWjZpOXNzRFV4UWd0ZURENE0v?=
 =?utf-8?B?bXFoT1RMcUU4ekpxQUl1VW5KcnFLNm9paytrTTZJa216WmMrRmR0dkZKOFZD?=
 =?utf-8?B?Uk1adkpaVnFyZlFtQW5XMnhSTUI1L29PT2cwZGlnbmppQ0RHdDVyTU1YUUI3?=
 =?utf-8?B?UzVOa0lvMHVJNG1RQ0dzQT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7925.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9108
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:574::8];domain=AS4PR08MB7925.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	70284272-a168-4ef5-78be-08dd446e6128
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|36860700013|35042699022|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFpmS3NPWngrVFNYYlpRKzYxRVZ4dXJ5NWRXN21lZ2FDV2YzbWNDdmFEaThi?=
 =?utf-8?B?eGVHMWhWWkNLa2N0bW1xRFNJNE0xV3QvWDNkZ1pUV29FTHRNMytQaG00bmdu?=
 =?utf-8?B?ak41OEoyY2V5VTFxeHFuRnRWMERWZHJTaFVKZ2ZyS3NvVlhMYndpL2dDUE5w?=
 =?utf-8?B?VkFvRVFCbzVJOXpPb2I4WE5KNi84dEJaSU0veDAybVB2NHh4TEM1Zkg1VndN?=
 =?utf-8?B?WTdhOXIxejEwYWZ2RndkR2hidHp2VWVPa0FNa1FzejlVVnllV2FBemZJcCtO?=
 =?utf-8?B?ekJwaDVnM1RSNUlTdjBXRURSUU9ZdXplMmhwWWR1RkpFR0h1anhMTFNVclZI?=
 =?utf-8?B?SXFOdHB6MXBCc0xyWW4yRnlDdGRqV3RBTDJOY0o4bHdZcDNwZmVwWDM2ZkRj?=
 =?utf-8?B?czloTVZCakU5NDJSTExYT003YStYa0pEdHg4VW41S29OTUZ0RmsxemhVbkRX?=
 =?utf-8?B?TCt2aEVuQnpvWTRneWM1RURqbUV6c3BsbXpzUCtXQmJvalJQeGdhaGJEemlR?=
 =?utf-8?B?QXFJdG1IZHRlTStpNlBoRGhKQmlGTWZHUHd3OEtGRVN4ZUZ4WWZxMU01UVZW?=
 =?utf-8?B?L0FzMjIwdDhMYlNPNlF1Q2I1RzB0SmpyVW82Q2s2aWI3WGd6Z0xpODJ4eWlZ?=
 =?utf-8?B?ejVEcmZ2ZnBLZ1k3cTRIZTlxem5URDc1RXVLb0JSVVdhRmlIdFV3bUVwanBP?=
 =?utf-8?B?QmRTcGc5WlVJUStsOGwzTmx2YXJqZ1dBSC9LNEFBSUF1dDZnMHF1aExnbGRV?=
 =?utf-8?B?WnFPL3J0YjVUS2Z3Ylk4T2xTcnZjNWF0eHRqVG9aTTFLWU5zYkhQZEU4VGNN?=
 =?utf-8?B?L1dtY1lwTzRuMHJjOG9GUVlNd2Q1REVYaVpKY1k5cHMzMEFJTGtyZFhVcmIy?=
 =?utf-8?B?SmxPVlFvazZXcy9RVFJZNmtxNytGZ2k3N2NJZ0ZBYm85Wk9SSVZNSENhNFJT?=
 =?utf-8?B?bWRSWm9XTCt3LzJydUE2MWNSMnFTVXRZUUhLb1hzL042enB0Zk9QVHhjWFly?=
 =?utf-8?B?MldVcnRIemowTDUxRWx3MGFGQ2ZRZ3JkYUhKUm5zUWp5SnpNWGRtOTlhWnNB?=
 =?utf-8?B?bEFVcE43WlRrRUdkYTZiTjVvb3NTb2hUK1ZqdlppNnhjTnNKcjhXUEZBa2Jk?=
 =?utf-8?B?eE9CWXcvaXR6V3J2R1pSV0hYZDRRY0tzNmpVWmZMRFM2aVp1bktCbk9HWmlw?=
 =?utf-8?B?NE5kazFBaG1WakIwMmhJOXUrK2xNT3FwdGVCb0ZhU3ZmVGRMWXRrVU9hUE1C?=
 =?utf-8?B?c0Fid256WEJMOFJiTlNneitPOXhJT2hzWTF4K01LM2MwWVVvSG1xcnJzVEVs?=
 =?utf-8?B?NkVYVUkzSzg5T01FbHRFMDRwSWJzSGFKbmZqQ0hNdEtTblkzZ2hpeHltNGtX?=
 =?utf-8?B?M2U5K01IOCtHWE83azEwUXY2TzhMbWxYaTRxZTVFTEZ1K2xEdURtT2pxamk5?=
 =?utf-8?B?bGV2SXUrbytMdTVBUytVV1NmbzFpeVdBU2lpZXpFNVRabXQzcmVLaVJsNGsv?=
 =?utf-8?B?NUNXZFBneWpCMDZVcXBXNUNkOVA0V3BCRTFUK295UkduSk4yM09xdGN3TnBT?=
 =?utf-8?B?THpmQkJqcGFGWk5nY2d1eldZeVVpVXYyb1pqOE42aUQreExPU1ptbnNvUS8w?=
 =?utf-8?B?cDRHemhpaWZUVjZQSzRsek5JRFF6YnlMSnZ2TTdJeHRJam53Z0pydEM5amkr?=
 =?utf-8?B?K2x5THovTVBaR094WGVBOFB4eS83ZEZuQk1xMXdzQW9pM29aaXlMMmhOSmR2?=
 =?utf-8?B?SU5oU3NUS3g4Q085R2pkNkZXMS83NjFlZFo0N2dZZkQwZTFFZ1Bic0VTY2JY?=
 =?utf-8?B?cDZCcExnamlzMjE5SUZ1REtPdy91WCtqV1FrYWJSQ2xsRzVEVXVTQmNnRlBE?=
 =?utf-8?B?Z0RGaVEweTFnU2hFUnhFU3VNbkxhUFVoTysvMlhtSXQ2b01VUzI5cmZhV0Zp?=
 =?utf-8?Q?MNsqRmOZ2eI=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(36860700013)(35042699022)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:18:32.4765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd95407f-b0c5-4718-8f2a-08dd446e674c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9873

Hi Rob

On 30/01/2025 23:20, Rob Herring wrote:
> 
> Why would panthor need CMA, it has an MMU.
> 
> In any case, I agree with Maxime that this is redundant.
> 

This is correct, the GPU has an MMU. The reason I introduced this custom
CMA DTB entry is to allow creation of a standalone DMA heap which can be
retrieved by Panthor using the API exposed by:
-
https://lore.kernel.org/lkml/20230911023038.30649-1-yong.wu@mediatek.com/#t

My understanding might be wrong, I am under the impression that current
CMA driver only has `dma_contiguous_default_area` as standalone
carved-out heap and we cannot have more than one. Please correct me if
this is invalid.

With the DMA Heap API I based the RFC on, Panthor kernel driver does not
manage the protected heap itself, it relies on an exporter to do it. On
some system the secure heap will communicate with a secure FW, on others
it will be a carved-out memory with restricted access. This is
integration specific. Panthor kernel driver will expect to import a DMA
buffer obtained from a heap.

For the development of the protected mode feature, I decided to modify
the CMA driver to create a standalone DMA heap and allocate a DMA buffer
from it. It helped me abstract the importing of a heap in Panthor kernel
driver. Someone may use a different heap driver to reproduce the setup.

* Additional information to help with the context:
Mali CSF GPU requires protected memory at the device level which does
not belong to a user space process in order to allow the FW to enter
protected mode. There is a single FW per GPU instance and the FW is
loaded a probe time.

Regards,
Florent

