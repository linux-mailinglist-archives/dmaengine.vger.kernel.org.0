Return-Path: <dmaengine+bounces-4267-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F2FA27775
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 17:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED9C18822E0
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A22153FD;
	Tue,  4 Feb 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="piShvIYK"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F9201027;
	Tue,  4 Feb 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687404; cv=fail; b=DGtePgVDI5OiBaVmbXZr8u3j4TzvkVBohkqnkwsflYWU9B/DBHAkcbhM3lu1c95YbbXASlmLV8PcPspWforlIDJsl6Vaq3WSew/QVMqQkE8jk2+im0ZYRL8H1+rsAm2/aFfv2WnZY12DQ+hzZfzfbyMfG1mtYgRhpBrXqjMVAaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687404; c=relaxed/simple;
	bh=r+SvCRBqPa7WxpOXcMZvOI0ZVQw0KW5fhmnZ4oOTxl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jklb0mmOH02AXDn+FY64NjQ2ECa6a21yrkTEJo1uaulUj1MoHUWLA7thcq/TWHAsZwszHarllAfWPGNXZZ/HXMtkdpvSbuvamwMoU2w5nZyN5759aHDKJLDaybOv1a4HP6trcRk/gF9q1nhoomrEWZaDLOvHjzEF5sXXy9eeHeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=piShvIYK; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWoYGqKKO6bFah5ARddQeFfud91vk1kzvPFYvgaY1Ds1ANuZgr1PNj7E5ua2jzu8fPbVEUr5riN8Kwvo4kKDFZv1T34ODQBKJySIDC4ILUkmpIHAG9JK0/zgS/gPG/Hqj0xkT2EBDNVr5nLGeuoSnkmdK5II1PF2Ag5NgE+HQPAtuvjISIzN2a2gMFbx9Fk/2UPDfKfRAHqQySvT4IJmWAZ68jRs8bJ+dlj1OWDrEVG9nRvmVlf01IWAAUGJu+jpCZDIjACgFdGtrJ3xthnwiJzS8glk7RB7JNEhq8iKf5kgAcUf/EF/Zm+k/12TFmBgo8hmjb/b4vLSU28jgo0XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUsn2r+4B5FatH9WOEQ45nZsONiva90fKDxDNQ7sm6g=;
 b=WReie1Jp9pMUM/UlvYXWwN9jiS6cw5W1JXtlgny4Js1gIr5H/mgALTh1hMF3HthZvEkM2i54Wqmu34sm9JGSPqHrDf5XfOXvIojLJCBtEWwJtKRb53ztQWH+t4XZ89WP3gEJX4lVdf6fmFacHx4LAQLzd/MPVW9gH1QcQQ8N6CgeHZmu1m6YazIf2uWFzrtpkF4jesJgVKG4OdfW9xxDm3WTlglQnhWbAi3TxqRZ93v64gxa69LuxqoZY42Y53/YQcKRxKFb0CpBV2jDXsfZcoShU/IppAndVdb4nywKgtTEjcWZOcAZIYyxVbEq93qlchEbKuWG91TRujjVYv1ypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUsn2r+4B5FatH9WOEQ45nZsONiva90fKDxDNQ7sm6g=;
 b=piShvIYKndBkHLG3nBLVRx7nVoGeA1BfjmC9TM+txfHFw14yGAMZwVFO48Z0pJjdOqe9qFlYbcwy1KwKL+PEBoRYzTtzVHxFrbJTavwRfNHhxqXSYzjHEAVw6t6hIVdTNRhdTyJneKTYiHPsHtviqc6GsXYn73Kt53vOY9CmdeegpbvE7W2LTBAPjpc4NajS6qFge3xKj3d43cSnAdpe8nc3EqQ39G6Fcf9295fYWWrEMS+MFQVMnoRY1hGoqUcDQg5z6eO+DRt+nwUshSFKTz3YZPGe7yTR81eZCoZF9iJwQiobqQu4DjvIludfogN9K15b2/wiuzq6hfS5rae6wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 16:43:16 +0000
Received: from DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b]) by DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 16:43:16 +0000
Message-ID: <84382200-e793-4e9a-b25a-8dc43e7a8bd0@nvidia.com>
Date: Tue, 4 Feb 2025 22:13:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
To: Thierry Reding <thierry.reding@gmail.com>
Cc: vkoul@kernel.org, jonathanh@nvidia.com, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
 <20250116162033.3922252-2-mkumard@nvidia.com>
 <dsxaisxdpsxecyna527cifixyurmkgo3cfaiheau5jjdl5qysp@64qquncxdmof>
Content-Language: en-US
From: Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <dsxaisxdpsxecyna527cifixyurmkgo3cfaiheau5jjdl5qysp@64qquncxdmof>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::27) To DM4PR12MB5101.namprd12.prod.outlook.com
 (2603:10b6:5:390::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e7dedb-5c11-4599-2c52-08dd453b05ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzBMR3NZbWQ0N3VkNmovNnU0T2l1R09uTmRRSFNycER2RzdqM2dSUlQxUmQ4?=
 =?utf-8?B?QUdrS0w1OXFtaThONnQ2UTVnZ3Q3aXlzdG0yRk16VkFGNjdxSnFFUk9XNklQ?=
 =?utf-8?B?c1JtWEhpOGFWLzVFQVVERHhua3hleHlGdHhIM2xTZzByaHFZcnIwMjNFZ1R5?=
 =?utf-8?B?TUZKUHRlSWttTWQ5T3RTZ1JYdGZxa2xEK0MzTlFJQWdCdFV1cFcvSHJCWTFw?=
 =?utf-8?B?RXVPV3czTlpTZVp1UjVmdlFCN2RsbjBxNlBLdjhrR3ljbnA0bXBjT2Nsb1pX?=
 =?utf-8?B?ZEUzT1V4TzRWbWNoZ3FXa1dFQ3NPWHVhZFhMRklVWFRicG1ocXlEaC96ZFJI?=
 =?utf-8?B?M1FFWkZrVGUyWElJd2t1YkkzdWo4RnE0M1A2VXRFbFUzbzNhWTRrLzJIdVJh?=
 =?utf-8?B?aFhtQkNjZ3U0YWlxRWpxUkowVWxVZmtkSE1oNW5wR1R5ZFNUN3RSbHN3Tk5z?=
 =?utf-8?B?elBZT2tVdGxISnBTdEkyaFpwM3Y0NU56bUFxSTIyRW85MHhCK0ZZeURUcnAx?=
 =?utf-8?B?MGRRS3RnK3NRNHdFbWhjRjErVVRhTmpIdmQrd1F0MmRxcVZjS2NST3lWdXd1?=
 =?utf-8?B?VFFhbG9wVm4rRnFLc3hFUng2WThDYWozSWNYSHZDUFp2dE9lVGJZQ0d1Mjl5?=
 =?utf-8?B?aWxXVlU5Z2JUN2F0K0hRa1pYS3F4WFBUYUNrTlltaE01Q29aSDVUQWl2c2pk?=
 =?utf-8?B?ZzhXN2lwRXM5dEI5ZllSUG1HcVRTUnZ6c2JHR1p2ZHUrTnRKSGNLYUtjQXZ3?=
 =?utf-8?B?ZTRNOVJmaDRkMS9Xa1BUcHYvTGNKaWovY3F5Qm0yaURNRFdxcWpGQ1B0eG9G?=
 =?utf-8?B?MFFUNnVkeDVaVW5XTDhLVEdIZWNRVEFaRGwyYWQwUGN3WERKSjF1Y2hHM211?=
 =?utf-8?B?NHJXYS9xM1pPY0tkNi9wNTJ0WUdQbHpoQkh6MVZIMy9uYWJEdWdTK1NaNlFo?=
 =?utf-8?B?b3FmZDlpQW4xaUxPUGRhVExVVFNpRjlPSFQ1dCtlb1c1dzNrRXMyRHVQWUI4?=
 =?utf-8?B?UVpualZrNUdIODB1ZEhwUlJVemJlUm9NbnNLQVRGdDNCWmdBOStraGtjNHFy?=
 =?utf-8?B?enY3M01LNkJHaHdKQ3dmRzBOVHc2NDVldU5xd3hvOWN0cStHQ1o4RDIzdkZK?=
 =?utf-8?B?cGluMFVOYnl2QTV4SjlQU0t1YUhxVk9UQW8vK0RVOXdlZ1JWYUFIMXVVT2VX?=
 =?utf-8?B?amxDTStWTGlyMzQ1OFF0UlpsY2NZZVpHZVNRMzRoYWxxS1dzQ0dKbEZrMHQr?=
 =?utf-8?B?SUUzQncyNHNlNk41eStNOHNodXlLU3gxUjN6b3F6NGx3dEpPNmh1ek9UOFpj?=
 =?utf-8?B?Ri9vb1JUUFZWTm8yZ0llUFdIdlZ6ckV1ZENGanhoSldRcm5GSjRoNm1mYWhi?=
 =?utf-8?B?cDIrcWRsRXJHWlYwZGRKR2wrMnV2M3RNb0pvbkY3b3BnYTc5UWF0MUN0aCta?=
 =?utf-8?B?VHhDektEemxyRmJxVWl6WjdSa3grMTl6N3BVanpLTno3RG1OK0ExalV2djZS?=
 =?utf-8?B?QUxSZ2xrWFNLWW1LSlg5TnQzd2xYc0ZjeGVRQ25iTmlOdkt1TVlsVTBzNGxr?=
 =?utf-8?B?MkhZZHUxK0RCV3kwYjhOVVlrTWNmQnY3aXR5eHV5TjJUS0d2SUJtRVZ2aDJH?=
 =?utf-8?B?V3F6RFh2UXovVC9Xc1JGWk1sN2lJUVhhc21BQXltM2FYTjlhais4d2hNUHFF?=
 =?utf-8?B?VzV0Qy9UZmFQSnoveGZpTTJxelRMZ0Q0SFg0RThVNlQ2MW1BaS91WHhmdkMr?=
 =?utf-8?B?V3ZHT3lIL3dwQ29aU290MEtMR3NaTVhzVjYvY3M0QjlvQzZZa1NkdzVzMnRO?=
 =?utf-8?B?OTBEbkF0MjJ1bitjbnZQNkJSVkRCL3Bvc3RCTEI3RFMwQWlmYTBUMmh6VWxK?=
 =?utf-8?Q?/Tezl9ZkJ3IEg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wi96VEtWTENjN0tPTU0zS3pRQWtESGlSVzNOcEhTYVhqc2ozT2owamNnVm9L?=
 =?utf-8?B?S0hjUTc0V0FHWE03L1M0aTIrVlkwZ0RtTVMycEorcEhpelhUa1Yrb3pzV09O?=
 =?utf-8?B?TEcrYzYrVVcyQ0JHTE8wbGVzeUdlcGVJRnNreDlPOVkvTkJPcWw1Zkx4WkhX?=
 =?utf-8?B?VXMxM0IwazIrT1QvcUVGUWVHeURGVFgrRzk0OTZjVWtaK0Z0ejEya1hXK0Rq?=
 =?utf-8?B?ak5RdHRLTzlYbDYzZTRFcnMzQ1VVMDlJSVpzc0p3eG9sZENWRWh4SWw4MUlr?=
 =?utf-8?B?R0lLSlhlVHRXVDkxTmNKRWJEZVBiMnFOSU80K3NZTmlMamVDSDdFZmRPK0J4?=
 =?utf-8?B?Y2JTYkZVREo0TE5UL0ZIaTVTQXBZckE5OW9YSTc5V1YvamdydmFsSzBjbkRL?=
 =?utf-8?B?cjZFNzE4c2NnYlMwUjRFNVQ3WDcyb05nN09FRGsycFo4KzJ1ZTJjMFpIcUpG?=
 =?utf-8?B?K3BuZ3VXZ1NEcVQrSVBHTHN4ZWMzSTQvTFUvR3VEUVR5U0dKcEtDYitVbE1B?=
 =?utf-8?B?Tzd0bG9yTnhxSmZpTk03U3JvZEc3aCt5U2ZSZVRkbXdxbCtNMGZaaEJGZWo2?=
 =?utf-8?B?ajJ4YTl1TEoxb1ZPUGt3aXlMZ3RDRHh4QmZHUFREcVJXUlBsTHI3VFIvMzVB?=
 =?utf-8?B?L1V3TjhjcEV6clZ1ZXE4OFBCUGd4QXZnZmhDMGh1ZXMzeStVS1k3RW9vbmtV?=
 =?utf-8?B?bmVBMUo1aThCL21ZOVJURXdweFZQYWFBdG10ZnI5anNxTm5MUXdYUVkvRkRO?=
 =?utf-8?B?R2pIbElxTFg2L2F5U1h4YklnY0lVRjB4SzlpeW0vdGRDdzYzVGlURHgyOFE3?=
 =?utf-8?B?SElMNndmNHlmYWRKNDFraE90SEpwVGJ3OGxDYUVvMkE5b3B5N0VmNXoxNmVK?=
 =?utf-8?B?S3BPV1NxZ2xONm5VMVRUcGZCcVlsWnBqVitMRUZHdnN0MlpjYlA5ZG5EYXZ6?=
 =?utf-8?B?Mmk1MDN3dWhPWXk0c3p6YTJMVmJTUTFaUm1wYnVweWFMY2Z3NWRmN1ZRTk9E?=
 =?utf-8?B?WEdHclI0NzZSRjdEQ2FlYUJBOFZndlhWa0lxVUJoTS9FZ01DSk1GME9iaFU4?=
 =?utf-8?B?M2hpYTVHNHlYWkNmeXZuRGVSK3lmK2VOVloyME94dDI3TzJiekN0NXBOankw?=
 =?utf-8?B?b2xKclcvNTBhY0pWeG8vVU9hbm5LOFZuY2J6SDMxdldzSmg1OFc3cjJUQmhZ?=
 =?utf-8?B?OGl3M1ZMNFZXUk9WeGFQMU45eTJoZFFxNDZwWElSTlEwSDRWcmxDd3N4Z2lY?=
 =?utf-8?B?Q291OU40SWxFZFZDZjdNNjBkdzFaQmtqM3pBdHhzbGgxcHJ5Zm9qcGh6cytQ?=
 =?utf-8?B?S1puWHQ4aHYvUjltM2JaWXVxUDdBaUN6aC9vczlCM2MzV0VxY0FZcEpmai9a?=
 =?utf-8?B?L0ZEOHR6M2JrVkxVQWlwOXZ3ZjJ6WE9HSTJ5TzhTUVVGWUhmSmVzSGtkektH?=
 =?utf-8?B?L1lJTGkzMlFEVFZCR2Z0NTh1M0NNczBiVFBYWktZZlFvVUVjaTJ3SkdQVDBF?=
 =?utf-8?B?Zmx1b1g5ejFJbzZWL2RzaFBoTTQreWV6aVZuSDZCSW14MGhHbnpQWG85OVJE?=
 =?utf-8?B?enJvbHhBaHA1YSsvZHNlOEZHblFPVHZDNEZ4SnBqVlo0b2VkY3VUcFU1S0Yy?=
 =?utf-8?B?LzZPL2dWcFZOV2NZaFhsU1R0aUtqWmdKb0JJdkRvdmNhY0JFN3dBcGt4Smd2?=
 =?utf-8?B?ZGNFNDVmWWlCL0gycWhyQytrOW5ITzJiNVQ0bnRWaGFKOGNrQk9wcEFaUzYv?=
 =?utf-8?B?SlBUb0hIbURrMXBybFZBK1piTEZqMEVXdDErWGxlSmthaFBtOVgwMUFNanUx?=
 =?utf-8?B?R1ViK2JDN2doamZmTXI5TzgxcGYvT1ZSdklLaWpuak5MaG9JSUt3aStHdjJa?=
 =?utf-8?B?L1ZyRFZzcmlnZjF6RHBLUzBIVVV4N3ZEOFVLYkwyYklJUW1yTy81dFBDenMz?=
 =?utf-8?B?bUNKVCtmdklEbStRMmh3L2l1TVpSQ05mdTJGMEYyZkxXYWFidGJYVlJhL05w?=
 =?utf-8?B?SzRuVEl3Umk2LzNqeEt3TG9DNldDeVZRVUsycmcvc25hWG4wS3VRalVCaWlY?=
 =?utf-8?B?SUlGbVJ0a3U5emdkYUZJd1R4SEdrMy8wQ0ZsSFJsYmhoV3JQUDdWa1dIUlJD?=
 =?utf-8?Q?xCwXCCEA+lH/p7m1VXAGXX1yp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e7dedb-5c11-4599-2c52-08dd453b05ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 16:43:16.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFhDu6XNXvevnqOsCn979PRJaH+IU8K3kQR3DCbSfbyFXVgA2DK7L+2SyjqblPsm5hDWznPbCc+HfJJha5Bi5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235


On 04-02-2025 21:06, Thierry Reding wrote:
> On Thu, Jan 16, 2025 at 09:50:32PM +0530, Mohan Kumar D wrote:
>> Kernel test robot reported the build errors on 32-bit platforms due to
>> plain 64-by-32 division. Following build erros were reported.
>>
>>     "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
>>      ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>>      tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
>>
>> This can be fixed by using lower_32_bits() for the adma address space as
>> the offset is constrained to the lower 32 bits
>>
>> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
>> Cc: stable@vger.kernel.org
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
>> ---
>>   drivers/dma/tegra210-adma.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index 6896da8ac7ef..258220c9cb50 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>   	const struct tegra_adma_chip_data *cdata;
>>   	struct tegra_adma *tdma;
>>   	struct resource *res_page, *res_base;
>> -	int ret, i, page_no;
>> +	unsigned int page_no, page_offset;
>> +	int ret, i;
>>   
>>   	cdata = of_device_get_match_data(&pdev->dev);
>>   	if (!cdata) {
>> @@ -914,9 +915,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>   
>>   		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>>   		if (res_base) {
>> -			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
>> -			if (page_no <= 0)
>> +			if (WARN_ON(lower_32_bits(res_page->start) <=
>> +						lower_32_bits(res_base->start)))
> Don't we technically also want to check that
>
> 	res_page->start <= res_base->start
>
> because otherwise people might put in something that's completely out of
> range? I guess maybe you could argue that the DT is then just broken,
> but since we're checking anyway, might as well check for all corner
> cases.
>
> Thierry
ADMA Address range for all Tegra chip falls within 32bit range. Do you 
think still we need to have this extra check which seems like redundant 
for now.
>
>> +				return -EINVAL;
>> +
>> +			page_offset = lower_32_bits(res_page->start) -
>> +						lower_32_bits(res_base->start);
>> +			page_no = page_offset / cdata->ch_base_offset;
>> +			if (page_no == 0)
>>   				return -EINVAL;
>> +
>>   			tdma->ch_page_no = page_no - 1;
>>   			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>>   			if (IS_ERR(tdma->base_addr))
>> -- 
>> 2.25.1
>>

