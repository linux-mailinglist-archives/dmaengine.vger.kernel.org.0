Return-Path: <dmaengine+bounces-4807-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01BCA798DA
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 01:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194AC18842FE
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 23:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5F11F2377;
	Wed,  2 Apr 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IPueY4Vq"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4261E4A4;
	Wed,  2 Apr 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636719; cv=fail; b=Ijoguvu/kulkv/w3lqsM6cvscxEodQC1oU9vSB9JxxFqA3dtIK7QyDaF52+ZuVzUqSUAFUiFBuBbdl1Ym4Yt7OKfCt/QCNmDmeMulfr8FPzuM1Dq4M8s5lGgz1mVuIEAHfgBWfbPKLkwjJt8ZqQwW7hdlg4X0ey399X/zQX3BCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636719; c=relaxed/simple;
	bh=EX9HJ/dYlPsvrNKmGW9Ks9nLTm+6ou9EOxrsDhYHUw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mZjJpwid7zouNSMsQwSu6jRybJQAN3S8rXn1dbF1HFMlwh89sKqUA/tyWDUEUsq+cU7x71VT8106jpsc7UtEZ4zpWiL+MlhgZr7N+NPSD3QcgqcVeENQUj7ktnPYVmdBmMHf9MGFv07vaxYwQ1EdNvJhyy/Z9TlY/V2pW5ij4lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IPueY4Vq; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlnpLqm6oPy0OY+AByZxwsFgrqczcdSv1L+KOgyviF7nHe69ybSF9DpMsjrhs2hgrzC2ZRNzli0x97YgdSLXmnhIYcATaLa/24L+Z8ZqsEY7sQrz/SldIaFhf3qj9wPQhAWnU/IzWIfb1Cs8ymfkmkMFgTJeR8jB1AevegPXLIe2VDb6vJ1qdVf1j48TC6X0i7sgWM6BuI8eYCdH85HGuC76eWK9r/kJy9uCFfg6txUFJOoxm4qflLD+vwaz4cuRkrbNZFYUr9Ibd8RjbIrk/TWyhJp90yv0yq8nCQm/zbdCKTdimIrjjix56rjXZfJ9HT88VZ01Xsry1LzYOdC0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c92uy1qZathcgq7r705az42Qg6Egw6RsGECZQ78EK7Y=;
 b=psiLj/fPYKDbbH51kCDDDoJibr6kSc1bLaKc4Rq3stNj8/QSoqUWovvo/E7Sr547QVFH8s8AC1ArRbt7eo4tzc2p4q9PAeucaWvWhIhKC3rm2yHXXACsOOp09b6JE6CfJFfrXZhK241vZXow5tANaGali11SyVNQGOxczAwmfVRA+OWzEF8PTFjd3T/4eSnuUhCmB9sKR0jHYx81YCbL6JRCYoSeyyYGSoupEhwM03oCmX1dN6WKFJNl3mSunko+zNw5v09WySehuXMo+ZoeJ+ZCwRAOEXwnmDNluvjiBCRZC0x8uXSOctBk788GXanRBarEY1vVqqGATXvvlegl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c92uy1qZathcgq7r705az42Qg6Egw6RsGECZQ78EK7Y=;
 b=IPueY4VqXlKOcTUo7RT8NFHeJBJ6CHhQ5nPPPvDcHgZ4Jg9h30KE8gDXI1tUT76zYvAeGfcBOV+pJmGdkKKPPRcP/OSMoTuXct1tHdfSqSuKoH/a2krsL+nvTgK1qDgFKknC68Y6lKLm2H5K3fmy60yenTLVcI+4mW0HozYJ7B2Qu7AWDtM/ekAFsmgAhVTxadJJDTiMsjMZckzvo6QC2doO2lq7BpYbwGtXj87yh8LN9XG8gIMEcw+mjJCwNQ4ngIHTSB3YhU+me/I8Y+kQ/jJ/0M2Rm4a53sGE0L1O/H3M7UMJSJ5PLJL1C6PfwQBZtJk33Jhidjtcyxbod4xnfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.52; Wed, 2 Apr 2025 23:31:53 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 23:31:53 +0000
Message-ID: <e6ff45a1-a077-404a-8bea-67c8a81f0fac@nvidia.com>
Date: Wed, 2 Apr 2025 16:31:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] dmaengine: idxd: Add missing idxd cleanup to fix
 memory leak in remove call
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, Markus.Elfring@web.de, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-9-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250309062058.58910-9-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbab161-133d-44eb-90b3-08dd723e8c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk95WFZJbG9UeFVGT1F1QWZYL3VFZmtwZnNkZ3Vja3RGRWFIMmlDL29YSHQ2?=
 =?utf-8?B?d0RMVHp1VWVrUVZDa2NVQkhJclltaHAySlEyd1FGSXFSOGlsdFVOZWF1b1hU?=
 =?utf-8?B?aUVjcXNPUS9yN3kvT3hpQ2duR2IydDIwdlYwR1lKMFZCTzdJTXgrTk9oSWFv?=
 =?utf-8?B?ckZpMXhGQjVZZU1ydGJWdWpJcUppOGs2Z1ZrdFRROGc5NVk4YzFHakV3ZWhk?=
 =?utf-8?B?SnJhSWFmSGt0REd5YnZJSC9JVlptRHVHZ2NUaHRxd0FsSGxLMlVvbDlGMXla?=
 =?utf-8?B?MzNiZExoS3VyellrYmdVN1RyQkdJTVdiL3VBcHU1RURhVHFxN0JCT3lEcVd2?=
 =?utf-8?B?eFVUdXhwU2l3QjUvMmIyVit1TFRMNzBFcno2Y0ovc0Z5QXBadVRkd0Y2d2NU?=
 =?utf-8?B?Z0dsQXBrVnRLY2owWFd4RENJQVZOMWJyUlZxYms1S1NOU3hvUDF4MTVFM3h5?=
 =?utf-8?B?TG1TcmJBalZlM1l1UTRtZ3djWFMwVG1Pb21hV01LeGRJVDBzeE9HejQyeFo2?=
 =?utf-8?B?SUlRRFFUZlFEY2llM1lHTXZHeGV3WXhEcVZaSS9oRTZoRHlVOFMzRkl3cFRi?=
 =?utf-8?B?ZmQ2MlROVDVHcldrcVN2QVlCcXNadzdlR1BXeDV4SHJpRFFYTy9yMElXbXUz?=
 =?utf-8?B?RENzUU5BdG10ek1XWWZwYmdOc0dFSTdyVlM0M04vazRaSHl0RkNqN2NmaUg5?=
 =?utf-8?B?TVJzM0xoTThJL0NmajZ2S1dqQTVPMmt1cVZIbjVGR05nZk9rRlBJc0RtQXZa?=
 =?utf-8?B?ekRHcnp2d3FTRWdDUkQwbzFnQ08vWmtYL0lleFNJaDF0cGxTVDlzWmJ6MUZV?=
 =?utf-8?B?NXZCaUY2QnV2UG0zd0VReW1MUmR5cEQrSS80NnF0a2NVeG45aUM3L0FCSkUy?=
 =?utf-8?B?T1NUbFZOUi9rczlkZWxVUmdiT2gwUGdPK2oxL1lRVlZmaUxxVHF5cUJZVm10?=
 =?utf-8?B?YUViZGxOMmp1SHVaWXBVNW0wK0pYaWRxZ3AwRXBPYk40aEQvaHY0N2w1U01j?=
 =?utf-8?B?TnVqNFBxR1FNUUtsSXV0bFdlcUdZM052K2dhZStmaWx1bWJKdUlGQStSdWJy?=
 =?utf-8?B?aUhHS0RzcHZ5YVRIWkc4WE81VkxvU2lzR3pLckE3bmNPVFI4TkRkdkYvOE85?=
 =?utf-8?B?OW95Z0poNndzRXVrVUUrQTg4ZUZBZ3dLd2dnWi9JMVZmVDF1MkF3bGF4K3dy?=
 =?utf-8?B?cFphYUpjT3JsRFZLQ1hrZTZmS0RJbUZRblVUM3d2eVFteHptUmNuUm9YMGpu?=
 =?utf-8?B?Qng5VGR5a3FoVTkrY1d5VHhJY09KVkg3bzZaZEE1RUhpNlJ3a0xWM3FWV0ZO?=
 =?utf-8?B?amlaR0RDTDQ1V1k2UW1UdHJZSmZ6OCsyZFMzTkdrMmsvbE5MTElwekFnZkQ2?=
 =?utf-8?B?ZlFwMkNrQUpreGVNSU1uc1Q2RTVMTFdnQ21jK0Y0N29UVjZwQXFLY3dXRTlv?=
 =?utf-8?B?ZlQ3WHhvZ1dMQWwyL3BqMXFtWFpFMW1jdEVDeW1GWVBlTko3T3VrNERGQW4z?=
 =?utf-8?B?S0tkM0duOTFGeEZqSi83Q1ExRkt2bkc5MmNOaWVwcXl2ZFArM1VYYUFmMXpz?=
 =?utf-8?B?ZnFNMnlBSlFYUmJrY1NSSlU4ZVpRZ0grKzBZWGpnNEp0K2JFdWhxMGozNlQ4?=
 =?utf-8?B?ZUZ3a3B4VFRMNFlGWjI4K0NpUi82bnBYWjFtbzZuRmIyU2FlMDd3YXFxY3Zo?=
 =?utf-8?B?VEhhWEIxa04zNXkzbHpIVGxrRnVTNDhiZm1zYnhLbHJmcks5YzJUNGxJbEJC?=
 =?utf-8?B?YnBMR09NTzZwbXphTHo3SnVLd0xVaytyRXVrZ1RpTzRJdVBRSWtvTGFpK09U?=
 =?utf-8?B?M2FGejk2SHl4NmJ3d0w1WitNa2QrQ1I2d282NE5yTWFEckxUM2pqWmZDNEFu?=
 =?utf-8?Q?5svWyl5mv2PQy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUF5T011U2YzQ3dLcmcxRGkzZmhtbG1tcjFCZElPWGkwWGlqVTVsME45T3RJ?=
 =?utf-8?B?OURxWC8ydEg4KzlKd3pIYmVRNHNXc25PUUNoSlpBSVExbzVUTmxkMnJUNkJN?=
 =?utf-8?B?ajhrNklZNUZUTzBYZktTbjh5Q0NHdmc4TDR0U2pGbFluWVFiOU15YmRJNDla?=
 =?utf-8?B?d2NDQnQvZGRwREU2SC80OG5qalhsU2w4QUlZQ0ZYSnordGZWMXcwK3UxQ1VM?=
 =?utf-8?B?RFhNbHhScTVHSVRSOE9IUnU0RHJyMFlQSmIvZHhvM0xrSWJ6TiszTmxkWHJD?=
 =?utf-8?B?d0thVWhBN3djZW5GeS9uVUx5clR5VEdsT1cvQWpNazdtUm5aUk9wSFhCamVV?=
 =?utf-8?B?ZHB5U0xWNVlWNUdRSHJuN242U2lsMFdUeWVqN2xpby9aejZiOHhpdmNCZnFr?=
 =?utf-8?B?cFFUaFBzR0ZZa2I1MXlQelhVdDlpQUZRWHUxK0oyRmZLTDA5SEJhQnVlWjNl?=
 =?utf-8?B?aGZqNlN6YU5adVpLWUlxTTNZR2MzbmlUTHlVd1JoZ2FZRjhFVVBXOEoxR3dW?=
 =?utf-8?B?MUE1Y1gvN0NYekhnSWpqaytjYk5GbXlVOU5TaWJCU2N2dG5zNUtpOUgxdzQ2?=
 =?utf-8?B?UVVORVV0N29JUWRFRUdTOHdvN0pKaGczQVhHVThsRmJRL0UyUFBxc0lOb1hC?=
 =?utf-8?B?ZXpLZlMwM0htWjRyWnludWZvUEFEWTgvKzhwbFVTL2ZTZDVuTkNxMDVjd0VW?=
 =?utf-8?B?U21OdHYzU3ZKNTEyTWRkZmxPb1g3Z0hWeHdEdFpwaHRmTWdvNHRiYzdZOG5k?=
 =?utf-8?B?TzQ2TmJxdUxpVDFZdFhKVTVLcTlFejgyTGg3M1dpRmhQRkRWNEpCMExRTkov?=
 =?utf-8?B?THJWMGtsK01ZNlBlRXI1SHdoNE9pTnZLekdhRU5CeW01VUxaQVNXRlRKcHNk?=
 =?utf-8?B?YU93QnBIL09iTHVEVDZza3ljaXJ1clF0ZUt5Nyt5RnRPcnphMmE3S2Qvc2lO?=
 =?utf-8?B?ZW5HeGZPbEM0eVBKQ3pqeHF3d1NiSFJLMGJVRy9NNW00Zmx2dzdrNmNsQnRm?=
 =?utf-8?B?VFNsdEkxdTBqTjRTSUNuOC9JMldWUVBmTldnTGxNckV2SWlUV3lka3g5ckRl?=
 =?utf-8?B?SGw0NGN3eEJmdXkrblRFT3l6RjZWYnpPcy9NcmxlVFJ6SmNGTmp2QWhqRW5R?=
 =?utf-8?B?NEI2NHdqRS9RcTJnRWVNQklnWTYvK1UzTUZEOXR1cndCYlB5c3MrUVNhZG1w?=
 =?utf-8?B?S0tUdmRFam1Nc256b21kUS96MjZraTViZjVTT2Y1dkl3d1h0T0NCemdWRWF3?=
 =?utf-8?B?MmJNNEdISkthNlcyZGhSbTMvSUlYdHd4YlZ4K3B0Q01ON2J5TmNPNWZNcVhm?=
 =?utf-8?B?NmtJTXNISjl0SHVIQkthSmJrUVhlNHlTdFk4TjRmbDh4cU9wOUdIRXhxN3hT?=
 =?utf-8?B?ZlEvWGJUb24zcjBQenJCNUVkQVVZMW1QUlR3T25rMFpmVVBJV1ZudkVrQzRQ?=
 =?utf-8?B?VkN6M1RmTitZcWlweDFBdkJJV280bHNQNFVSN2w0MzQvZFpLdG01dkR5Wkhn?=
 =?utf-8?B?RW1YZzFybWVKcXY0Tjk2UG9sKzQ0VkZVU2lhRmYxQnZOdTNMbHJJNDlZUjZT?=
 =?utf-8?B?d05xeWszM1lMWTVwTXF0NEpPVTRPeFZlS0J3K3V6aURndFRJdy94Nm5Xcjd1?=
 =?utf-8?B?SmpUSytiNFp3YkJ1VXpxYkxXeDZESDMxZmVnbmh4OWVnUUNBbFh3WDI5OVli?=
 =?utf-8?B?WVh6SWJNakdDQlpJSUhkQmlqNGJpR2NMMmloTVN5OEUxVVFzSWNlMDZ5ZHM1?=
 =?utf-8?B?SjY5bWwzYmc2SkVhQmRJb1ZMVERMSUJUMjZQSzN0dUNvRFlCbndqdDByTHZz?=
 =?utf-8?B?dktMQUpyZ0d5bzVRMEFQNVJFY3J2RzVlemloYVVQRnJXaGE1L0lUM2t2aGcr?=
 =?utf-8?B?QlR4MGJzMkJkTkVZcHM1eDRRRVpFbitXanptTW9YNEVod2hUeDZNZVp2Wlhz?=
 =?utf-8?B?WEYxUXFYWi81SEZZdnkvaFdrazdjY00zVGV0alNFSHRqWHNuc3VXMjVSQTkv?=
 =?utf-8?B?UCtQV0M0cmNpaTB4Nm1PaDBUOGQvbkRtNHdTYkVwNUs5OXRoS1lWSW90OEE2?=
 =?utf-8?B?NjAwUjJwVlBEb2JrYlk3WUNRZ1hxNUVJang0ajZSYTMxNG4vNTg3dG1xMlNl?=
 =?utf-8?Q?emOMi68gmByMWSa0+Ha5FqKyg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbab161-133d-44eb-90b3-08dd723e8c91
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 23:31:53.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP52SB53op9oWHIgL04Kzbyhr7hFhEyZG2f+vdTAOOF9yTp6y4SPI/tw8Wvu4yCllLYgWvPYzzb8q0K5VMbNRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272


On 3/8/25 22:20, Shuai Xue wrote:
> The remove call stack is missing idxd cleanup to free bitmap, ida and
> the idxd_device. Call idxd_free() helper routines to make sure we exit
> gracefully.
>
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Cc: stable@vger.kernel.org
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> ---
>   drivers/dma/idxd/init.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 890b2bbd2c5e..ecb8d534fac4 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1337,6 +1337,7 @@ static void idxd_remove(struct pci_dev *pdev)
>   	destroy_workqueue(idxd->wq);
>   	perfmon_pmu_remove(idxd);
>   	put_device(idxd_confdev(idxd));
> +	idxd_free(idxd);
>   }
>   
>   static struct pci_driver idxd_pci_driver = {

