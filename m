Return-Path: <dmaengine+bounces-4254-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8548A25B0E
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 14:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCF73A2868
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02FB20551B;
	Mon,  3 Feb 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FhHUUcGc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FhHUUcGc"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2071.outbound.protection.outlook.com [40.107.104.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B72205514;
	Mon,  3 Feb 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.71
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589811; cv=fail; b=Dq3ly7RBh04apl6UlM1Nl2AwvZat54hkGNql2YhsKKwwt3GhWdYWQVd66he6WhBMlDoDvnWbse9LpwHtnrovSdCI2JdMXCY9ChHng/fhfg3xBykg1HQ0f91ouZe0MuYH28Ul2K486oLDpo3+MNrq3QrXeoVt2LRw7gIvlanoLV0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589811; c=relaxed/simple;
	bh=TA2TRIfhR/uC5fBw/3TVZXLO4vxiO9IZ4NomLvOECEw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3l3TFgdLQxfWpzTTF2ZmRfExjxharpJMKAeANLMOCFeEug+TP/uTAxRbDM8z5PfDuzi2h42nQSEaMr6hYf9ePiXR8XrmPbdl8tA+4YLjg3haQKzKSxW8ZPZDzxwryDfgB+rBBowwtK9kT8wsFtF6ETZgYrILwBPDOzD0WjBbbI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FhHUUcGc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FhHUUcGc; arc=fail smtp.client-ip=40.107.104.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZR2hwsZVTcw4eSHxg2w2C/Ky8i9oNEQPlTeyOUC4iCkGip4SqNFl5ZZiUhjmDejnJrwke0+Xsu8Pj8LAIHvXfoyWK2jDBphzzgQdDuXV72EP9FgOfqNfMYTSu7n0i8y+Op+nhVTxqkAv0VnSpT5sxpmCl8536U7gA3696f63AGrqpdIVh/eWJGdDvSelpAVe4nsWbR16q41YcI/7X6/DFYE4rexlTGPkVyuXQdOJX5pY0AHdueOVfrdS2LKM9nle43l2Z9TE/UaYvCTBro5tUPm83BphfPRT7OWg1hn+WPUesQwyr9aQydPFbXHq61kEc0EZyIqO1uG148xeUf2U7w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytOIF8/G+tK40t7/ZaXrVLgKW+kAlxeNdM7zLKYcMQQ=;
 b=g8sTq8IUQT5i2SgNg7gL5VOBKeCNRzX7QGuZabuFhmAQf5q6YYX/BhfeUdku9oK4JB94PpodBGWcROM5eTxYk1dxT827qAder9nimBNO2a5bdiNNH7h+3E7a34MyMgoFuR8QtqDSx724Oqeco7kdmGHUj/3iorht6IaRKMEXcR7aih1dIPJzEoCSGD+uO+X3rvAqjDrpWR+tIE6eT/OqnBHIHl7RrAvO2PlePH2cXXyIQUppkz+LlxsfCOzIF20tk3mZkJX7Tn+1hHLmsLuXH1eis2fNeDPXbxyYgbiJQT3u0/vlgFqpeAkIUAsxn8cmzj0EjkUJwzT0A+fDaIeByQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytOIF8/G+tK40t7/ZaXrVLgKW+kAlxeNdM7zLKYcMQQ=;
 b=FhHUUcGc4FJllCThRJPwdNgjbNqNW0KDLJXW0qPjiKKuFKY494O/nsV7tTLXGf2V0o6Ke7WlMbra8ktERLBQ/FKEUL315pNCEOvAdO0nWP44YEv5o9xqkznJJ0j1NtOyxgxRtvdruYmtZM/VuXrAEC4f8VjZ9juxQ96Tw5wcj2M=
Received: from DU2PR04CA0308.eurprd04.prod.outlook.com (2603:10a6:10:2b5::13)
 by VI0PR08MB10656.eurprd08.prod.outlook.com (2603:10a6:800:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 13:36:43 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::8a) by DU2PR04CA0308.outlook.office365.com
 (2603:10a6:10:2b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 13:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Mon, 3 Feb 2025 13:36:42 +0000
Received: ("Tessian outbound ca1ab514ff10:v560"); Mon, 03 Feb 2025 13:36:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c516da758971352c
X-TessianGatewayMetadata: mi7oNd4h6a9Jom0jyV9mXnwvUBnxLKa6VOm4o0P88K0/IhBsDfsE+kOaKfd8en0KkXWDWkpXP3vOUqbGNTILWyCHr49HElYGcUFG1ZVsDIHrFoxp1d/SuYMOayfSDQjEL+KkKq2d2BDkvBI8PX9vi+iZuMPpdmrbs0g6jnsiGBI=
X-CR-MTA-TID: 64aa7808
Received: from Le8426c48ec50.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C4B78B34-881A-4890-BA3E-FE2180A0F18A.1;
	Mon, 03 Feb 2025 13:36:30 +0000
Received: from PA4PR04CU001.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le8426c48ec50.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 03 Feb 2025 13:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGrlnR7PLYTcI5XoL66WdjBm86oxFRKi1wnludWCLb/PfYvdPiJV9aFV1PgtsImJoUSCu6D4j89Mf/itpUQKfIsA0Lr2uJ1t83VqWVdoS9stLU9P6H1mgfMV0vhkEZqSE3HQSmQ2TvHJmrG/WuOETuFEy21pJC+5fSUwLzBSFwX+VgobNpbMgMxoU4lM0Bq84UY4/XkZlB9vCG/rVfGVOMTSSc8w6KAu4LxSh9q3dykujvsdtDXZMru1BIckbvKZ5dwr4EstIPC74DXEV99GH1P3QObQdJXv/EvIfo/BYEEs7zcemD88h043dTBOM8a8bvylbop71ZSVWW7mxzLMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytOIF8/G+tK40t7/ZaXrVLgKW+kAlxeNdM7zLKYcMQQ=;
 b=IPkzqLp6YWpvNkShImiy6QVPXHFsVFD+/wjPp9LDdY/vhZX1eMw45JvHRP1A0Azn8ssbtEO9kVIuZFvppAkkugnXQ1K2NAb03BNW5zfGqO79/u2T5p/Kbv0KEiSyh2HBMC4GTp0HvKdb7mE+zcFzCSOCvd3f3wb7A2Dpm3FkbHz0NxRMVw/WrkjngtSIEXHf9Dwl2ALZp2C3EM379dzCvwlOrfFHC8+9Bivok8ITwbRHgyfCZYG7nwAA6/2h2KBwZ2JErJ8KujUFnxnTqETzxMmcrEe7/lATvSUFs+GV0TdHxznrsYvdP+XFh4dq1RxdAzRpzGSmT4jxL4nvmPjmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytOIF8/G+tK40t7/ZaXrVLgKW+kAlxeNdM7zLKYcMQQ=;
 b=FhHUUcGc4FJllCThRJPwdNgjbNqNW0KDLJXW0qPjiKKuFKY494O/nsV7tTLXGf2V0o6Ke7WlMbra8ktERLBQ/FKEUL315pNCEOvAdO0nWP44YEv5o9xqkznJJ0j1NtOyxgxRtvdruYmtZM/VuXrAEC4f8VjZ9juxQ96Tw5wcj2M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com (2603:10a6:20b:574::8)
 by VI1PR08MB5360.eurprd08.prod.outlook.com (2603:10a6:803:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 13:36:27 +0000
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7]) by AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 13:36:27 +0000
Message-ID: <be8e6b9f-c3c6-41d1-af9c-3dcd102f0fe3@arm.com>
Date: Mon, 3 Feb 2025 13:36:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
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
 <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
 <ats2unrml5a7vbpdrqrzowodrsfj44bnubpbujg2igk3imeklx@nrpmg5oeq3gz>
Content-Language: en-GB
From: Florent Tomasin <florent.tomasin@arm.com>
In-Reply-To: <ats2unrml5a7vbpdrqrzowodrsfj44bnubpbujg2igk3imeklx@nrpmg5oeq3gz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To AS4PR08MB7925.eurprd08.prod.outlook.com
 (2603:10a6:20b:574::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS4PR08MB7925:EE_|VI1PR08MB5360:EE_|DB3PEPF0000885D:EE_|VI0PR08MB10656:EE_
X-MS-Office365-Filtering-Correlation-Id: 590784c3-c7db-4cd5-0178-08dd4457cb88
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OGVkYndjcElRUGF3V0trZ3diNjZrdk9zZUo4QWdHNmg5aVAxc0lINFd2WG01?=
 =?utf-8?B?N1hNRFk2RHFvV0VLV1hFZExlSWRlWldSaHZMTzZtRlZ2NzduUVpFUXh4NkdH?=
 =?utf-8?B?ZlJCM2plN0FhUFNRZEM3Q2ZwbVlIRnV0TU84WVhWOHYxSlBnZWlLR3hrWGNo?=
 =?utf-8?B?UlRhQXIrNnJMUjVJL0hhem5aRDEzcE5EaXV3dmJXWE4yWmE0L3NaYjA5Zlp6?=
 =?utf-8?B?S204Y0k5ajdtYzJsVjRSV1RzWUQ2UTFOODlhSldpUWZ1dGlyTVFGY0hFRnZP?=
 =?utf-8?B?ZGFCcUFJQ2R1MEhYQjNuOEtQZ3hZZjZ0K3BJRVhrRlFVMjRuYk52bG4yY0hM?=
 =?utf-8?B?VFFHRXQyNlJ3K2VuQTZiY2dQNGZvQUpkVXRpVHVBT0Rib3M3Smg0OHpGVk1a?=
 =?utf-8?B?TjRpVzJmSHZ6Q2NpMDNqanZtYUUrZThLcmlCd05zWTF4VjBwazdNU3VHc3ps?=
 =?utf-8?B?UjBzQXQ2YlN0R0pDVGs4T09YTG5CM0ZYOU9ZOVNWZ1ZQbVRzeUJPSWNmd3NN?=
 =?utf-8?B?UnJPd1VCVXUrWCtia2NseUI4bVpYVnVtU2N2QnQ0RjFYVEtDcDZnSUtzdVgy?=
 =?utf-8?B?VWNPVVRjTGZZU1ltVXNOa3pNd2FreU1XRTlPUzZxM1l1NHdzQTcrNGZkc3Nm?=
 =?utf-8?B?elhNWEF5Qzd2a2wzald3S3oyeUZOYTI0aGRUazZ3ZlhyeklTek4rbzdpNmxl?=
 =?utf-8?B?cWhac2RJTkhyYUtXKysvank4UlRkYzE0SXl3M0lwRUJwYnoxMlFsaVNkTVRF?=
 =?utf-8?B?MHFtU2M5ZXFER0NRbFEzRVJDTnk2SUtoRkY5TURvYmxpMGFqQzBUcmNHYWJP?=
 =?utf-8?B?UlMzZ0tkZERlM0ZKU3RRUVdDK1RMZ0RoQ0lvNWZmd2J2ZDNMRTlnaTNnT1hW?=
 =?utf-8?B?Y3ZvdzNzNGlxY0pSRlpIZE5SVjBoY1p3bWt0dDhkZnRmd3FlUDFNbDc0cEJs?=
 =?utf-8?B?ZlMyMlZRTDJQMDR6dTFGczZ2K0QzTVFnOE03NGhNWXE5ZWNINTFtZ0VzVXVZ?=
 =?utf-8?B?dCs0Y1BKM1crK3ZJZjU1YlQ3Q3pQcmZ4ZHAzR2RNZnRRZ2NUMTZKcjZEUEFi?=
 =?utf-8?B?TndVekRTY05GY3c4VDIweTBtdkJGUWVWZjVHUTdjclA1V1NEYldJc3JWdkli?=
 =?utf-8?B?dXFwMHdWOGN3VEwwQ1R2TksrSVJmZ3BFaHRCbVBQeVVhZDR6UXdValVKNHFG?=
 =?utf-8?B?NFhzV01UYmhxRjVSbGpVYm4xZ0UwQVJqSDBiNncrY3NSOVh6QUZXeHp4WEUw?=
 =?utf-8?B?TWJzT1ZsQS96b3FnNE9hOW1rMkM1dkI2SHdHUXJzcVo0NlJYKytsWEMyK05P?=
 =?utf-8?B?bDhReWlpME8rRGd0RkpCeHRRNHZmcUpIVk8wM0YzT2NqWHdCTWhaSFhlMXRJ?=
 =?utf-8?B?ZUhYSkhxM291STdZZ2lsTkdWWVdENFdGOUdsNnM3Wi9OYUdoWHJWWHZMVita?=
 =?utf-8?B?VVRPL2E2djNrMlpDYjhXOG51OVlQQTRrMkhlS0lmOUJieStZLzlCRlc2TjlX?=
 =?utf-8?B?VEV1RkUxQ1hvNWFIUm9XT3JaemRCeFJuc21IOWRCT1UxR09mekE4eVVCblo1?=
 =?utf-8?B?NFoyRVdQS3pSM0RaQ09RMjA1S3FWUUNhY2MwZXZ4RHI0NUxId0lrNTNscEha?=
 =?utf-8?B?bUFuQWZIWUwwR3JBMExoUWtyd25CUzQxYnZTTkJVeXdzS3RKcTNCK0dIZVZo?=
 =?utf-8?B?eUdtUEs3eHRQNmxtL0hKRStiV3JDVWRHd1ZoczhET1BYZS8wU2hyMnZGS1B5?=
 =?utf-8?B?VGVUYU5CWlMrQWtOckovcm5NTVZSdkFjdVRSdUdjbGpIUkdHOVdML3A1UC9D?=
 =?utf-8?B?VjBMM1Vuam1SUWZjcnF0UT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7925.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5360
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:574::8];domain=AS4PR08MB7925.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5ab6a181-4a5f-4395-949a-08dd4457c236
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|35042699022|36860700013|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTJRb1g0eXEyRjJNTC9XOE1CT2QybDhFWGZXUHNTYnp6ZjFDMjNpRkNWV1Qx?=
 =?utf-8?B?ZTFaTVhqaGFua2IrRzhTTXl4Y0ZvYmxyL1BvWlR0STZOcTFOK25NUmRWdDFR?=
 =?utf-8?B?Z0h3Y1JXWlNsaUc5dXlNS09BVHZjN0RFUTgwNkYyT1I3bDJVbXRJUHFxOXM2?=
 =?utf-8?B?cVFKVG4wUytuVkZZSEVKYzBadnA2aWZEZmc3MFRZTmVTbGFMcXRqQjZxMDU2?=
 =?utf-8?B?MVhtdmxHdWErS2I5ZXFQZno5THpiTUF5aUFiS2ZrbGJkTVZJMTlHV3RLUzd3?=
 =?utf-8?B?S0d6WitaYUExT1RsUHB0cXhwcHpObDk0aWlmUXB2bjdVd0UwOVZiRGE2bnMy?=
 =?utf-8?B?WUJxb1ZlM1ZzUXQ0UmxQRi9STWo2a0hCb2pLQ3R5QmRTVmZoT0dzSExnTzha?=
 =?utf-8?B?OWExUUlSSnFVRXl0VjdISXM4eEtLL3dNb092aDZrNkxiTTYwRkVtREZVWm1L?=
 =?utf-8?B?b2prYThBNWV2cytNRXcwRXF3c1F0NVBzdVlHSlJ3WW1sMGw4OCtJQkRxcGQ4?=
 =?utf-8?B?NUE3RDhGKy9rbTVSVmxUTGRZWDdNU2tSRm56bHpScVFHdUJaNFdQbVhYZmF1?=
 =?utf-8?B?aE5NV2Q2dU9VZFA5dUpNT3hodHJQeHdhdTd0NTdSaXBHOGRxUHFjN3pkVnVB?=
 =?utf-8?B?UWJyQkVxMVhJVTRTNnJCcDBxb0ptNS9ybzdkUldWMWhmdU5pZGoySHZkSkVw?=
 =?utf-8?B?QTBmOHR1cHN4Z0d1eUw2VVI5K0U0SnEyOUt1M0s4eERkdGJXVVJTeGRDNzAz?=
 =?utf-8?B?blRaeExFMnc1UlMrd0kyUTA5cU91ZDVJWFMvTzYvL2pvQ29NTTRNMlB6SUEz?=
 =?utf-8?B?eEZmVW9CbGg3ZFRzUVpxbTBsamhmdUpIdHVUOFpRcFVXNmlBT3RPV0hFd29m?=
 =?utf-8?B?QkpxL2R4NDJubmJWYVhDeUJuK2E2K3BmS0NFcW9PMGFtcDFud3hXeHRQWkhJ?=
 =?utf-8?B?YTdiZ0NQOXh5ckY0dnVDVmxIUmJZczB1QVVyaTRpV01abUVZUWNoaTlzQ29t?=
 =?utf-8?B?bnJJVXFLVUsrSE1MbEpSbVZqZThZcnplMnJWMHBKWkxMb0E3ZSt2T0lKUXdx?=
 =?utf-8?B?TVRlN0hvSUhEWTlVazVpWWVDUkFTSjVxVFVXRlBZc3YzS0tnU2MzSHdWUXZS?=
 =?utf-8?B?QTNnbE51RGNsZE9sQVBqelhFMTVkUHgzbER0MXJVUlJqTkliMVFhUGRSeXVr?=
 =?utf-8?B?Y2F3cklBbjl1aWRhQ0VFMjcrdjF0TjJ3MmViNXN0SzZodW1GM1h6UWlXMTZU?=
 =?utf-8?B?Z3ExSTdFcGdaRjk2RWYzclZVeVdQQjI2cHdybWJEVDAyMDlVUkJrTUUvak5E?=
 =?utf-8?B?bmkyYVZUZWJRWVVHZGxtOGF5NCtReDY5Z09jYklWaFRoZy9SUWRicWwzZTQw?=
 =?utf-8?B?Uy9odTF1RTJkTDUyaGZMckJGZXdaYUZXSHUrYWwwMHZUU25sVCt3VVJaYnEw?=
 =?utf-8?B?MXpXaVNUUnMrQzRiRFhOSjV2NWhSV0oyc2MyOXdhWWp5R05wdkZNbHU3VFpu?=
 =?utf-8?B?Mndta0xldVErVUd3VVFXRmllaVNoTER1bnkySmhZdml4TnFibmJDZUYrY1NC?=
 =?utf-8?B?NEhITW9XcC8rWjFGSVJWSjVKbS9DMDg5NzNMcE1rczE3S3NtRE1yUmdsYm1R?=
 =?utf-8?B?c2trRWFrU0k1NktLZThUY2VNUkhzM2E5ZWtnN2x1ekl2Z0sxWHV5eFZMUHVJ?=
 =?utf-8?B?QkdXUTJ3em04YjhmZUNhYk5FdllRS1h0VXVlWmtxUlR2bFpnSXlpbTVyb1dC?=
 =?utf-8?B?aGxqUldORTZYaWN6dDRvNGZuMkZRcE1BNkozd0xCcWtPUzFUUEhjVUhrWnFi?=
 =?utf-8?B?VktmcmY2RForOTE2YVl6eWlwM2NjYkhzcjBxcS9JdFdia2VYVkVTRmp4Rjl6?=
 =?utf-8?B?dlRWZEhRQ0JtS1JHNWxGT05LOVhHRTcyazdYTGJjcDJnU24yQ3Y1RjR5RzRt?=
 =?utf-8?Q?EGtfXH4NxEs=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(35042699022)(36860700013)(1800799024)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 13:36:42.3228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590784c3-c7db-4cd5-0178-08dd4457cb88
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10656



On 30/01/2025 13:28, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Jan 30, 2025 at 01:08:57PM +0000, Florent Tomasin wrote:
>> Introduce a CMA Heap dt-binding allowing custom
>> CMA heap registrations.
>>
>> * Note to the reviewers:
>> The patch was used for the development of the protected mode
>> feature in Panthor CSF kernel driver and is not initially thought
>> to land in the Linux kernel. It is mostly relevant if someone
>> wants to reproduce the environment of testing. Please, raise
>> interest if you think the patch has value in the Linux kernel.
>>
>> Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
>> ---
>>  .../devicetree/bindings/dma/linux,cma.yml     | 43 +++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/linux,cma.yml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/linux,cma.yml b/Documentation/devicetree/bindings/dma/linux,cma.yml
>> new file mode 100644
>> index 000000000000..c532e016bbe5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/linux,cma.yml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/linux-cma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Custom Linux CMA heap
>> +
>> +description:
>> +  The custom Linux CMA heap device tree node allows registering
>> +  of multiple CMA heaps.
>> +
>> +  The CMA heap name will match the node name of the "memory-region".
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - linux,cma
>> +
>> +  memory-region:
>> +    maxItems: 1
>> +    description: |
>> +      Phandle to the reserved memory node associated with the CMA Heap.
>> +      The reserved memory node must follow this binding convention:
>> +       - Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>> +
>> +examples:
>> +  - |
>> +    reserved-memory {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      custom_cma_heap: custom-cma-heap {
>> +        compatible = "shared-dma-pool";
>> +        reg = <0x0 0x90600000 0x0 0x1000000>;
>> +        reusable;
>> +      };
>> +    };
>> +
>> +    device_cma_heap: device-cma-heap {
>> +      compatible = "linux,cma";
>> +      memory-region = <&custom_cma_heap>;
>> +    };
> 
> Isn't it redundant with the linux,cma-default shared-dma-pool property
> already?
> 
> Maxime

Hi Maxime,

Please correct me if my understanding is wrong,

The existing properties: linux,cma-default and shared-dma-pool, do not
allow the creations of multiple standalone CMA heaps, those will create
a single CMA heap: `dma_contiguous_default_area`? Other CMA heaps will
be bound to a driver.

I introduced the "linux,cma" to allow creating multiple standalone CMA
heaps, with the intention of validating the protected mode support on
Mali CSG GPUs. It was included in the RFC in there are interests in
this approach.

Since the Panthor CSF kernel driver does not own or manage a heap,
I needed a way to create a standalone heap. The idea here is for the
kernel driver to be an importer. I relied on a patch series to retrieve
the heap and allocate a DMA buffer from it:
- dma_heap_find()
- dma_heap_buffer_alloc()
- dma_heap_put()

Ref:
https://lore.kernel.org/lkml/20230911023038.30649-1-yong.wu@mediatek.com/#t


Since the protected/secure memory management is integration specific,
I needed a generic way for Panthor to allocate from such heap.

In some scenarios it might be a carved-out memory, in others a FW will
reside in the system (TEE) and require a secure heap driver to allocate
memory (e.g: a similar approach is followd by MTK). Such driver would
implement the allocation and free logic.

Florent



