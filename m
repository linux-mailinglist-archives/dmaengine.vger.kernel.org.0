Return-Path: <dmaengine+bounces-6729-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9BBABA85
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 08:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557281C2A92
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D302927B4E4;
	Tue, 30 Sep 2025 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SR5BFQfM"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B52581;
	Tue, 30 Sep 2025 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213474; cv=fail; b=rqB4mX55N6uWO2NBeRi6epfQUchvLDTstDNkyzv6rAEWLqRstgP3waSxYzSNa8QSsQMGIOy7ApMVn+dFypTw9+b/diGQGeMeyFtS8YY4Tl3nN0G1Mg0egc1i7soTmS3d3yqD6BS2FCRLuxIjANYXNjPuyVuH323UgrTDt2M9wbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213474; c=relaxed/simple;
	bh=0Sh2kdKNN1bd149LpjS0kRDpZVcZUuyy93i8fclRF9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKnrYPfYQbimzMNt+/OKDNRUhhFxtG3U7K5inNf5mFupmQHo4uKafW6sNqwxnY9rrIwNOP0HeAntY16YEghFZsy6GGnJmSwxJoeFAnv12Qx/iNBeFEHzijUzB9Z6Nj+KXGNnRt5VKc2ENHQuke4ZrSN0JhTIXEdXbImB1uA9iFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SR5BFQfM; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo0NnHs1d0c/x1bN+smxJx8GS/S6bQZuR/Mz33my3OV5jhEWzZT30+uSSH8NfRnC1PLTSL4gamqP3aO6GPf50h1Rw3bmyzjuAue6hyspLmkQD6wJpnsdi7KXp3zgJE1vysThNdjnbPU7nOWcTxhfiGEu2LP698juY5z3oUajQ253S7e3URuvTYHmczpGYCMazWcGMYI/UwWmilOK0/0/TU0JxzFiM8AioJ1J+5Gk6vz8wk5OvKFJueuszRrZHAAqA9Aviq9IrQVKgOUgGToPPicCrPkxqgCvBLXpvEOcAQm9aQxJbtL+aeqbSWYcwVGtDxoeOpXHlbyof7aZJ1z/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gKeXjVJisTg8Wr3IC2ByFC3sXTgVDr7leMRUXs6Nsk=;
 b=TGpDDS/tuGd3s4cjcq9yBq8y8VATZ/k0BgxR8j19mHn3UtqF6soZVoYYofYErJOiMmvGEb+b0awxTmguPYKOUsy1v7PF8GTags/OF4QPlSKf3WDJLDo2IP6xkhW245E6FVPV3rQkiiIxwuZx5L1TC4ZpUDDUTUBxFJUHuwWKfyZx+RU2/cDDEMDw4zduwZLSTnYRH9ysIqc9s/S5BGpey+Fx4rUe+mnIOm7ViHaYWmx8PppT43BZHaQs5uKMbQmDK2Go7D8nBqL9Idc4sZe1ff/a6kZ51MXw+5RnwjNRMsQy6tyZGofC1OZwngdL1NeX6ChOdiUxPY259AvGjVAJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gKeXjVJisTg8Wr3IC2ByFC3sXTgVDr7leMRUXs6Nsk=;
 b=SR5BFQfME95oDnZvJZ6OnoCKdLbwIJAjIYWK91EbUu0pFIiO45II7qRDLhU7To5D+gE2tbjVhZegEEfCpSuPlc5RHMnEOvnXR8VcejGn/yax+q+xo6myIqu7K5K9Y6L6+Hoi/MKJYIGAZ8B+92wonI5FpDASN+pRL6x3746kgEi56MtB/sS266xqED+eQ3bX6ogP9eXr2P3nHa2R6OZzuvI4orAij8p2lWxFo8MMoZH8hGqe5DjjddnEbr6KIrr8IZEwiMY4+o6irK+jtNEeoojvL2jxV7zDQ3Mn5JDkaREtbU6HYIFd4y06R1S/1tZvCFCXtWLT5CChKtXRF1+y7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 06:24:28 +0000
Received: from BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81]) by BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81%6]) with mapi id 15.20.9137.012; Tue, 30 Sep 2025
 06:24:28 +0000
Message-ID: <4cc27ab8-4e59-45b9-9383-183f78da47a6@nvidia.com>
Date: Tue, 30 Sep 2025 11:54:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] Add tegra264 audio device tree support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Hunter
 <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
 <175915953199.54406.1457670691076635405.robh@kernel.org>
Content-Language: en-US
From: "Sheetal ." <sheetal@nvidia.com>
In-Reply-To: <175915953199.54406.1457670691076635405.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::23) To BL3PR12MB6473.namprd12.prod.outlook.com
 (2603:10b6:208:3b9::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6473:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 735d9ecc-7640-4bc3-65a2-08ddffea024c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjVpaFFWK3VyMUFlZmtnQm1aeTRhaDFJU29JV0pzaE85WkhPQ25mbUdiZ3pS?=
 =?utf-8?B?L2M0dk85RlR6TVpFNlFKMkgrTG5qMHdrUmQxc2djM0hpdlp1cXB0VWNsVjlG?=
 =?utf-8?B?VmtQdVNRTXZJQ1c5VEY3SW9KcnN5UmFuY2MxSkhVaFVNeXRvSSs4NG00R3ZS?=
 =?utf-8?B?ekVKVXFya2E4RkNRTDVpUTRhL2pub2lZSWhyV3FiMW8zV3VJYU9MNTllanEr?=
 =?utf-8?B?SXlHcW5MRGtrQjhQVzhWNk14WWt6VHhpZVppMHlEdmZnZWp4a2NySytGWWlJ?=
 =?utf-8?B?Ym9aWnRMVFJJZi9aVFdpN2dINVYwQnM5L1NGaHRnaVFpbVlaVktybitNcFZF?=
 =?utf-8?B?QWtld3NyZTB6WTczOWNaNWZPR3ZFdno0NEtZTjNuakFQN0huZDJ5SEVxdUp4?=
 =?utf-8?B?N2k5TjQwNVY2NFo1T3Jadmwycno5MnZ3cDBvYWNUQ1Q0Z3VhTzdPUmt1YXhC?=
 =?utf-8?B?ajFsUmd3RlVodmlKZXRKTGZ5MStlVS8rRXAyS2IrRFltNGtjTW9vYWx4TkhH?=
 =?utf-8?B?SmFNMENiLzhUWWljaExacW1JSVB2aXpkWUg5RFpxYm5hSFdFekkxdHdibzEw?=
 =?utf-8?B?UThSbVhrWFZmMkkyNkJVTTVvRWd1RUdoMEgweUY5WkR4MkJ1R01zZ21zRnVL?=
 =?utf-8?B?WUtxcDRsYXNqU0Zpa1NqU29KU0VGdG81QzBSdHRCTUgrdkk0cmxHVEZaclZi?=
 =?utf-8?B?Y3JSanhvdUJmVWVwTTNPZW41alhncnBwMzRsTkQrck01SzVmMWhXa2hwbmdE?=
 =?utf-8?B?RlpVOXgzV3c4ait3a3I3NlpXMnh0WkxjdjMxbmtCMk5NRTRMVjNOUkhhcFFF?=
 =?utf-8?B?S2dxek1rMmxlYklQeGlFY05rd2pyK0JncUVSZWc2Z1NqblhiS2d4MmtrQWxo?=
 =?utf-8?B?VVh3cnljOWxOMnVmQXhaS1NpK0pjalN6MDlSK1A1cHdTSThUL2ZFa0lJS2VL?=
 =?utf-8?B?MmJPdjNGbzdzTHE2NTFkSmI3aGFyUVIzc2xnaU85cERrMExLMHBNRzVkWEdG?=
 =?utf-8?B?aHdJekJiUnBXdEdsN04xcHNMRlNOQmhCYmdsalEwNzFzK3hFdnNkM0NaU2xX?=
 =?utf-8?B?Z1VrUlAxbkpZc0RCWmZVUkpwNHVCM3lJa29obFFsSGF4RGY1UjlXYnE0VEdk?=
 =?utf-8?B?dThtT1lXRlB4dytocVF4K1Y4d0tSK3o1SlVkOGFoeXRjTVBQdU9HZWFvWEdU?=
 =?utf-8?B?c0cvWVJjb1hGZzhnZHUvVERJUStyQ0pJWFdxZ05wakZIc3BwWStaU2RndmRO?=
 =?utf-8?B?UXJZcHFtL2ZTL3pMRXNieHQ5TnkrZmd2RDZDaGtEVEFkcm1hRHRFWmV3WThk?=
 =?utf-8?B?Zk5MWktrVnZDT0Y0ME1odFRSZHM0ZHZXOXlKT1dmTDhlNlorcXVFMFBzenZZ?=
 =?utf-8?B?RjRtZjAvMUVYcGtkTlhJL2NuUXhMMHZ3a3JIMDFMWHRKa0NlSlhTMi9lcENU?=
 =?utf-8?B?THBXYWlSM2FOR3R0TnhJRm9ER215eWJqdEJPV0I0cG9tMU1kMlcyN1ZvcEh5?=
 =?utf-8?B?R3pHbW5rVVBpTENRUFV0OUkzV3Nvd2tBMGh5OTNpay9XY3ltODFkYXRQUXpX?=
 =?utf-8?B?ZW1HL1NvWi9zTjZzTXBhV2loSUZ1NjRUWW8xYkNBand6ZGV6RW5GT1BWdjlo?=
 =?utf-8?B?UTBZbWNNL0NFeU42OXg0UGdHTmdMeFpzSzJDQkZUMWg3K3pvWFBqMzEyUjBk?=
 =?utf-8?B?dTNHK0l2K0I5UUJXYy96eXBPQUc2ZVhRRkh5NlVEVnFxNERDWDhuWnJaUlZ2?=
 =?utf-8?B?Q3IvUHlpaXdCaGxZcjNGRURYcFFEQUkyS3M1NXJEMmMxZThXTDhFcGxVN1NK?=
 =?utf-8?B?aGVuVWlBcU9FbGVocmR3TnNBNk53bHFJRzF1NEk5dFFsK0Y2Tno0NGZKaGVu?=
 =?utf-8?B?MHZMcGtHRndjbDVSY0szbXFXMHRNQlYrbHZNRjBwbDlhdE1zeGY5VGZuWUlj?=
 =?utf-8?Q?MqrIxvt+XMu8RuOs9B35fmbesM0IKnFm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlpIZjdKZ0xKV0xUc3M1Y01IaWVxSkdDdHdCRzl6cGJpZmZLdENlUHI4bG1u?=
 =?utf-8?B?WnYxeUxYY0dVQlBFVWRlSlBjVHl6eXRsNTUvWkMwMjBXRFB0V0VpM2haRlEv?=
 =?utf-8?B?NkxDR1VnQjVUZytWbkpjc3ZzV2l2L0xZYXpYbXZzMjVqMVBPdWY1RjBpVXk2?=
 =?utf-8?B?bERVaXZGbFVRbFF1U2FkSjdJWGZtcVNLemMyMEZsaWtwZHdUQmNja0ovM3J6?=
 =?utf-8?B?TlBkQkxJRENSYW1rY0pOSmNNbjFJcjZQT0NGNEJBL0Q3eVF4SmJybG1VTkVM?=
 =?utf-8?B?ckFRVlpUbzlPeDNKVjBDYkxZMmZSTWxOSnRSRW0rb0R2WHJwNmFtb2E5VUR3?=
 =?utf-8?B?VWZpMGlWMEtLQkMyeENjYmlMdFVLZ3UvWE9TTzFWeUlHZnpCaU1XWk9RV3Ix?=
 =?utf-8?B?S09wTzQxZjVRS2lYQk5TTU5iOWYrZ3pBQVFiQ2JVZW5CVDJHTHpndS8rRVYx?=
 =?utf-8?B?MXM4eVVsVGI4UzAxTEY4UXh6bVBFakw2Tjk1UmUrY3pucTFDbHRqNlZiT2t3?=
 =?utf-8?B?bDBqWnYraDdLOXl4N0Q3MzNidDZyTFlqRGJEcFk5MDVUSUFwZjFKWmtkWHp5?=
 =?utf-8?B?ZUpSMVgwV2xILzgrQStQQ1hncGtjQ1RYTjhaWGhPeDh5WVBiOGNIdjZpMmpE?=
 =?utf-8?B?dUMrcFM4TFM2aGdpZ0xYRHpDSXpIaldwUDNKQnBDVGMwV0VpSVJ1d01uaFhv?=
 =?utf-8?B?emE5NTV2amJ0Q3J6d1lIdGxHUkF5a3dnK3JyODlNNDVpSDF6aFNudk9rMkw1?=
 =?utf-8?B?UmsyL0x4Qy9YQjRvVnFlbUlNNzBtSTFiOW5oRUl5SG1BdTZ4U3NaR2lkWnRF?=
 =?utf-8?B?UmpWbTRGeDdPSEFOanJMZ3k2clA0YTY0QWhqTUdnN2tQUy93U1E5UENwd3JK?=
 =?utf-8?B?WDVld01PVWVsd3NKZkZzaHVyVUlld1k2NERyRWdFeFFmU2pVQ3B5ZXM0eWZO?=
 =?utf-8?B?SkpXVGlEKzhYNjdtMjRXMGtCWm52TG9CcWRHaVdIai9KZWEvanh4RHA3c1Mr?=
 =?utf-8?B?YjBac2tSUnV2M3BMNkZ6WnRSRnBHUjRkcGRJU00xWjBLNEp3OE5EMVVCQUsr?=
 =?utf-8?B?cExWamNNN3lua1A0WjVJUFdQaG1FVkpaKytSTU5OQmU5dG5HaUJjWncwd3JC?=
 =?utf-8?B?YXJTTks0cURBb1k3b2RCaU91Z2F1L2crNlpES2JmdFNwU09QVC84TTd0b0Zk?=
 =?utf-8?B?d3g4RlF0dGlleStJd3ZteS9JTXFyMVpSM0xSeHVBVFZFSFBYRGNaWjdxZ2lq?=
 =?utf-8?B?V3A5WXRxWEIvdWNYamRSUHlwbGpZL3ptWHpvaVdqWi9rQTJsbElxN3Q0WWdk?=
 =?utf-8?B?amI0NW82ek14cTllSmJZQ3o1VWJOODUvZ3FNb3NzSEZSTEY5TUUzTEx4b3Bt?=
 =?utf-8?B?WDhtR3lGMVVBQWpvQVNyRFM0THlITHZWbWhaQjRDQndyWVpnVkxRR2plb3FQ?=
 =?utf-8?B?NHA2RThlaW5GMFRHZElhLzJ2eHNMdTR4NjFvREE2K1VnU0JOdTV0elFZZmFO?=
 =?utf-8?B?R0RGbWFYczkwYkxqYnQyb0NpTmJPKzFtQ0txWTRWem5RbUNNbHhKRTJRVU5r?=
 =?utf-8?B?cHc5MUI3SnFJaGJlNFlYL1VTV0Z1VkhZdzVBbzg4aitmRmJqTllzeGdQZGhU?=
 =?utf-8?B?Q1I5R0psOTVCazFvVlAzc001Z2tKTmtLQW9zMXhzNHBYY2JPOHhacEdzdElt?=
 =?utf-8?B?b1RnUi9tcmlERzZlQWpwNnBUY3JFS3JuOGFKWk1FdStWNjlKdmdocGV4VTNI?=
 =?utf-8?B?eVl3YnhKN29CbTJpa1hWcVNvZ3lZcExzV2NyR2Y0ZVQreTcvcFZValh3ZEVq?=
 =?utf-8?B?aTQza011MklQS3FVbTZKT2lXazBESjBSV25nNVhWL09VcTBpUDZ2Z0h2MXY4?=
 =?utf-8?B?WVB3V0luQzZnUWtkRVVMTndkaSs5NllmZUJTaFIzQnFkeWhHNWxDSHV3N2h6?=
 =?utf-8?B?dGZlQm9LSkk5d2JJcjlHRTVOMHBwakMwSUpIenpYVUdmWlRiYmZmN1RKbjhF?=
 =?utf-8?B?SVliczd4VThhNGdZUjllYy9nYUFJWVFQWlhFN1VOSVcwd0Q0ajlKa3l3RjFT?=
 =?utf-8?B?L3NCbUIvaDUzakFSM1FZekxMR1RPbjV4VkNTSXB1OXpkOGgwUVAva2FjcUt0?=
 =?utf-8?Q?590hkMzYIzwsP1omMJNGzxvrH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735d9ecc-7640-4bc3-65a2-08ddffea024c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 06:24:28.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JU6vJcOZfdfRV2S60yqH6PZgfwyCNwe+5panBcHBjnZD7kL+HOz8AdmsVZyZXSAcwg1ANROzbc4w/lWcpoqeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131



On 29-09-2025 20:58, Rob Herring (Arm) wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, 29 Sep 2025 16:29:26 +0530, Sheetal . wrote:
>> From: sheetal <sheetal@nvidia.com>
>>
>> Add device tree support for tegra264 audio subsystem including:
>> - Binding update for
>>    - 64-channel ADMA controller
>>    - 32 RX/TX ADMAIF channels
>>    - tegra264-agic binding for arm,gic
>> - Add device tree nodes for
>>    - APE subsystem (ACONNECT, AGIC, ADMA, AHUB and children (ADMAIF, I2S,
>>      DMIC, DSPK, MVC, SFC, ASRC, AMX, ADX, OPE and Mixer) nodes
>>    - HDA controller
>>    - sound
>>
>> Note:
>>   The change is dependent on https://patchwork.ozlabs.org/project/linux-tegra/patch/20250818135241.3407180-1-thierry.reding@gmail.com/
>>
>> ...
>> Changes in V2:
>>   - Update the allOf condition in Patch 2/4.
>>
>> sheetal (4):
>>    dt-bindings: dma: Update ADMA bindings for tegra264
>>    dt-bindings: sound: Update ADMAIF bindings for tegra264
>>    dt-bindings: interrupt-controller: arm,gic: Add tegra264-agic
>>    arm64: tegra: Add tegra264 audio support
>>
>>   .../bindings/dma/nvidia,tegra210-adma.yaml    |   15 +-
>>   .../interrupt-controller/arm,gic.yaml         |    1 +
>>   .../sound/nvidia,tegra210-admaif.yaml         |  106 +-
>>   .../arm64/boot/dts/nvidia/tegra264-p3971.dtsi |  106 +
>>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 3190 +++++++++++++++++
>>   5 files changed, 3377 insertions(+), 41 deletions(-)
>>
>> --
>> 2.34.1
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>    pip3 install dtschema --upgrade
> 
> 
> This patch series was applied (using b4) to base:
>   Base: attempting to guess base-commit...
>   Base: tags/v6.17-rc1-57-g635ae6f0a3ad (exact match)
> 
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/nvidia/' for 20250929105930.1767294-1-sheetal@nvidia.com:
> 
> In file included from arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi:3,
>                   from arch/arm64/boot/dts/nvidia/tegra264-p3834-0008.dtsi:3,
>                   from arch/arm64/boot/dts/nvidia/tegra264-p3971-0089+p3834-0008.dts:5:
> arch/arm64/boot/dts/nvidia/tegra264.dtsi:8:10: fatal error: dt-bindings/power/nvidia,tegra264-powergate.h: No such file or directory

This error is expected.
"dt-bindings/power/nvidia,tegra264-powergate.h" file is being added in 
https://patchwork.ozlabs.org/project/linux-tegra/patch/20250818135241.3407180-1-thierry.reding@gmail.com/, 
in the cover letter it is mentioned as dependent of that change in the 
'Note'.


>      8 | #include <dt-bindings/power/nvidia,tegra264-powergate.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.dtbs:132: arch/arm64/boot/dts/nvidia/tegra264-p3971-0089+p3834-0008.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/nvidia] Error 2
> make[2]: Target 'arch/arm64/boot/dts/nvidia/tegra264-p3971-0089+p3834-0008.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1480: nvidia/tegra264-p3971-0089+p3834-0008.dtb] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> make: Target 'nvidia/tegra210-p2371-2180.dtb' not remade because of errors.
> make: Target 'nvidia/tegra210-p3450-0000.dtb' not remade because of errors.
> make: Target 'nvidia/tegra234-p3737-0000+p3701-0008.dtb' not remade because of errors.
> make: Target 'nvidia/tegra234-p3740-0002+p3701-0008.dtb' not remade because of errors.
> make: Target 'nvidia/tegra234-p3737-0000+p3701-0000.dtb' not remade because of errors.
> make: Target 'nvidia/tegra186-p2771-0000.dtb' not remade because of errors.
> make: Target 'nvidia/tegra210-p2371-0000.dtb' not remade because of errors.
> make: Target 'nvidia/tegra194-p3509-0000+p3668-0000.dtb' not remade because of errors.
> make: Target 'nvidia/tegra234-p3768-0000+p3767-0000.dtb' not remade because of errors.
> make: Target 'nvidia/tegra234-sim-vdk.dtb' not remade because of errors.
> make: Target 'nvidia/tegra186-p3509-0000+p3636-0001.dtb' not remade because of errors.
> make: Target 'nvidia/tegra194-p2972-0000.dtb' not remade because of errors.
> make: Target 'nvidia/tegra210-smaug.dtb' not remade because of errors.
> make: Target 'nvidia/tegra194-p3509-0000+p3668-0001.dtb' not remade because of errors.
> make: Target 'nvidia/tegra234-p3768-0000+p3767-0005.dtb' not remade because of errors.
> make: Target 'nvidia/tegra210-p2571.dtb' not remade because of errors.
> make: Target 'nvidia/tegra264-p3971-0089+p3834-0008.dtb' not remade because of errors.
> make: Target 'nvidia/tegra132-norrin.dtb' not remade because of errors.
> make: Target 'nvidia/tegra210-p2894-0050-a08.dtb' not remade because of errors.
> 
> 
> 
> 
> 


