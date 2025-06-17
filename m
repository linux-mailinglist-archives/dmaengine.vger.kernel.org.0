Return-Path: <dmaengine+bounces-5527-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BBAADDE92
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B913176E85
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 22:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ED529347C;
	Tue, 17 Jun 2025 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N+0LPoZS"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86E291C15;
	Tue, 17 Jun 2025 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198408; cv=fail; b=ZNgZVSXbmRUzgrPmiV0qL2KOq7kx/ev7OGnxC3O2hbSiWu3E9oa3plp9lq+j4C8+m748xxvgc4cK3hXddvoj9/vFDT8JyLJerj3S4RFlVwkUCJI/l74CHwl985VlFpfbJfU8064tZDVMMRJap9OzHcDXoqM4hhrZiPAGbOp+5xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198408; c=relaxed/simple;
	bh=eV1gpmamIbg+Y0ytpclkpBjBK3t2K76M0mWZBXAW6U4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C7GM4CRGpqxBfZuev+/hi+YhEsShHdeR0rzZyGBVsw1Plrrn4UKpEa1b61G7kUriS8CY/xDKNh7oMY1klI9yV05Cn9+0pHTJ5+aep7yXzEYwSChIYK3y94mhu/XUtm0LPD+NTrYePMbSBXXlOXu/hvTRJviIHxqlxaFyv4exzug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N+0LPoZS; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5JNyJyqvvSR87K+L/1/sAFXZo0Idc0X2LRIvLil2jgeYCNjaY5cVjkCQJASZX82mgATxj4uRPLmgAxYrmsRqKXLOE4hvJK2i4n4MoiZxg2R1IiUfPurqbQPg1GCxM94Uq5OUUnIMYw+wHS6IXEY2YUpnBTMH45O+qHoLH086YLznuOLhWlpjQa+QR6gmWYCUEdRbuYenm4sCSw8OGkDnfqkpgpB5LW3pKQ53R816+aRdWxyy2LFvgmzlsG82oDYZIaY6M1GncwbuOn12hSsJkiJQNALZBD29rDUFwAn+k9J3cBQUc0nmRxtxI4jFDrrwzSkh7nOOB2W7q03dJA1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/mNw2/GshPZMcIYbVkDr6L5E/GMPCnN3io1EBFAPqE=;
 b=CcQi8FqF9LXmdzcylQh3sIl62G0iZpDpI6p7v//Iqs0NHJnATFqllV9+IDBDDEz5uQMRdmydl9FCdZJzpnHk2XahoAmaLk65PQbiXYa/g3U9hHqDZ1PjaNB9e7QAlrlqjvF1WE1u2gFtZrBMJRAblruitUX2CU5j7yH0FV74vOB77S8JbSmyQ+QrgFlnrQkHPh9TgyA9wM0Izixt4LIfUa4sdcGMVmV7G4N+GRRO+hqSRaMaJn6LI1NTI21J1sAfJU0AUP2uMKmJ+GhYqaz1QzAUt3AWym0p5gYWtNWejbzaly6o8hBeG4gRSvCt5iiiHoJAFgG+D6Qp84ChgJzq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/mNw2/GshPZMcIYbVkDr6L5E/GMPCnN3io1EBFAPqE=;
 b=N+0LPoZSUeCfpK/E9ZNhKuTF51qAvgJckA4pRWUVXqNRDx3YTfTLN3qBlcb7YxV1lRMeoEga1Qa8f+rVniXsWHoJ4yn/mCFgrhBWYB7rgxiLdYRGFKCl4wr/JtFH83fuJdSy3M0xvNdtt0X5Pp6XiPgoqD83mT0rtWYvu6TxkzMvMTnwm5E0Lgo6tjxz2qjTcl18mWd0NTQRiV3DBrN0rvKZ52m0T2GJABlBLe5fLbR99Si2xMruzpq91HRvT5eXkwzMKLpa64/LQNvg5dgi+OYXR5VFFD7HQtwT5sfc38mDpGaqJymWFsYRm0lOta5xEtQAymhP4mqV3gEYPP7mZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Tue, 17 Jun 2025 22:13:24 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 22:13:24 +0000
Message-ID: <d4b51d33-e46b-448d-b6d3-f0845b1d05f8@nvidia.com>
Date: Tue, 17 Jun 2025 15:13:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dmaengine: idxd: Remove improper idxd_free
To: Yi Sun <yi.sun@intel.com>, vinicius.gomes@intel.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com, gordon.jin@intel.com
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-2-yi.sun@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250617102712.727333-2-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF00004099.namprd05.prod.outlook.com
 (2603:10b6:518:1::45) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e097ec-f6fd-47bb-dacc-08ddadec2d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0xXSktScXczZGxxcVBEcHhUamxCVWtIQXBoSjgrTC8vQ1dFQ3RBVWVrSTlT?=
 =?utf-8?B?YWdqVGErMmJiZ3phSm96bTBGVUFJaUVkTjdFNlNyZEpPZEl2cUh6Uy90RjJL?=
 =?utf-8?B?d0FsVWJYc29PczNISmlVZk9uRGJDcnE1ZTJSV0U4aDZ0MVA2WVRoOWRBVVdK?=
 =?utf-8?B?eFdKWjhzRHY0UmoyUW8vZzFNSWN2QjA0Q2hic3hZbzBZWlVmVGVtdy9HcVZp?=
 =?utf-8?B?TTlTQ3NRcVdvZHhCOGt4V3VMT2xvaVg0S3ZHcng5NkxYZ2FwcUxvbTFJSEtR?=
 =?utf-8?B?ZzRnUEg5eWhYRW5HQU94Q0NhZWJzNHBVb3FYdmtWTTd3SkFMS1VWTU9qTmVR?=
 =?utf-8?B?YzE0ZlZ1cXNWSGFGaVFrMzNQUzJpUWRjWmZVSlVkSWhDYU1lalVYaEJGaGxv?=
 =?utf-8?B?Nld6TEFYalJFbDlwdVZ2V2E0U3NmNlg0Y3RuTWNzMVRDdzhla3VrU2U4Ujd2?=
 =?utf-8?B?M3ZOODB1QjFOdzkxVk5yU3JrQTNiWTFpVGlYSkJmMjBYUkpSc0xoSis0VU8w?=
 =?utf-8?B?dkdncnRFZmZoMHVqcHllaGFSanR1UzFGRmhKYU92czRXd1dOdUF3ZGMzMHdW?=
 =?utf-8?B?OXcrYzhJRXg5cktleWNpakFmMGdTK1dEVnp0cmlRbHFsaG5kVlc0WFFhdEJo?=
 =?utf-8?B?bXVTaXFCM1hXYjM5a0xxdEJSYmJ6VFdoRnZlbFNRTmVvMGhTUHlHOFV3WDNL?=
 =?utf-8?B?WjZ2OGptaXVJM3pjOXJsOW9yRjhES3JpYW1QRnlLYjBnUUYxNDB3TEJoNWxy?=
 =?utf-8?B?T1dSbGdFOVB3MGpnMmh5WjM2S0J2Q1pvYkp2Y1dKV1p6ZlJSVktaUU9MYWhE?=
 =?utf-8?B?UDd6S0xzdk5jak9qaGRubzB0b0h1UzNwaHFTcWFHcHpBekJUckFtdUs4NUE2?=
 =?utf-8?B?dEFtQ0xEM3BPZjllSXNHK3Q5aXlpUWZ6c1I2UjZxSGNRcTl2eitlNlViT2Nr?=
 =?utf-8?B?TUNqQWtqR3FSUkdROVcvZEE1OWY5VGhCRXJTbmhQdmc0U2EvcFdjc1ZWZUkr?=
 =?utf-8?B?UzZMZjhjdFZZN0F6L2psc0l6NmZDSyszUlJ0MDVhRzRlRDl6bFNrTzBhUS9z?=
 =?utf-8?B?ekh5ZkpKY0I0WHo1blNOLzZLenVYVXVWcTdCNVdabXJYSDFKNE4wamNqZmU3?=
 =?utf-8?B?ak5ETnZpWWlXRjhFY0FGU25mTk9nUFdGUE5yT3ZaVTY0QVlvN1Vtc2JUejRV?=
 =?utf-8?B?VzMzMnkySmU3QW4yOXhhOEgyS0VrUnZZYzNiOUExeXlTbnBpVUNHVVlXcmxt?=
 =?utf-8?B?ckp0c1dCeHhXVXZMWG4zZ3hnVE12a0FXSW02Yi9mRWREa2ltL3VjbUFrc1VD?=
 =?utf-8?B?ZjF6YTVFY1E2TkpDUFhoNjdRelJvRSt4Q2FQRDBmUGJ0YkUwWVBVNDlTYWdl?=
 =?utf-8?B?cHkwOTVKM21TSkk0Ums1U3l2cUgydHBBS2RCMnZIT3IrUzRCTy9USW9WYndi?=
 =?utf-8?B?bzV1UkdncDNQTU54K1NBSHNIeExLZGRzODJuTldZZUVrWlZ2S3ZWR2h2Wm14?=
 =?utf-8?B?Q2ZCejVmUWdIK29uU0Yvblh3OWxFUnhWT04rMDV4UkFTNW9yUVBLVnVabStD?=
 =?utf-8?B?dHd1VXF0elBGd2xTSHB4cnZKVzBUY1VnWUswWWhtQUNmRVkyN2Q5Q3F6R3hZ?=
 =?utf-8?B?bis1MS9GMUx6aWVoUjhQcUpZTkNWVVRZbUl0ZzY2Z1JyTWx5SWFDK1c3b0sv?=
 =?utf-8?B?eTBjcW0vZmJpRU5yMnp5algxTmRjU1hKWWhvTS9VTGVhcVp0T2g3V0ZTdVlG?=
 =?utf-8?B?QlVGM2p6bC9FZTFNUDFMWXVTNjJQUkZEdEpTc1JVVEpxQWFMREF3NlNxdkNu?=
 =?utf-8?B?UEF3ZkZSbGlKMVQ2TU9qN2ZFUnZPZ2NMNkJVV1p5QmFmdG5Fcm94NmJGc1lz?=
 =?utf-8?B?d1FZMHl6aktHTFFUdTFNK05xZ3NORlVOLzZRVnAzVk5xNTNvZnFrYkRxYk95?=
 =?utf-8?Q?1iAouka121U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1VMN1QybVNxbFpLdjFJcDg1MENPS2JqVGl1dVhtOVppdnZZSWkxUjA4dW4z?=
 =?utf-8?B?M00yN09aQldoemI4TEpDbllPenlZRWxVR0laMms1UVUweGtTVXZGdDNieE1J?=
 =?utf-8?B?U2k4eFNDUzB1SlB3bEN0ajFEQXg4dEtqdHJScUFRRjlnZ3g1Y2ZsTXQ2RWxr?=
 =?utf-8?B?WklEakl5T0RKNzBLbzYzTHdUaVlyZG5nNHU4NWxiU1hsS0hmQ2RtUnlJVnNN?=
 =?utf-8?B?RWx3VUJjcW8rQUFYbDhad3RoZzJrbGdBdVhpVkl6RStidjdjTWFsUTJSTHBq?=
 =?utf-8?B?azlacllwVDdJZnpRMjRiaFQzTU5IZFVkN1AwUHNuRXJNK3RKV2ZrMFdNLzc0?=
 =?utf-8?B?bEpMU2hCN1JuMmlkMG5JTFJwU2RsVStpUzJVM2xmR2lOaFBBTlJBQWpOUGZs?=
 =?utf-8?B?aGloMzZaY2JyMDRWcGN0UjBjRUFiSjR0TTlkR2tDQWdBZzhJMi9LWkxYZTc2?=
 =?utf-8?B?U3JFdERXVHp3TFQvQkhTWDdsajJoTXhOT1ErQlJ2Qkk5b2poNng1Y081SnZ1?=
 =?utf-8?B?QTZQMDBCWTllQVlpcGZKMS8xdk1UV1pJdjlxeWtRaFNyZ2YvY0dtcHN2S1g5?=
 =?utf-8?B?UFlzNFAxemhXSG85bmRzLytVY2Qwakw4bnFrRmZXeTNZMkdSZ0lrTVpTUThO?=
 =?utf-8?B?TWVtU25nc3I1eW9TdS9UK0NXdncxWjlPTjcwL0ttSVZseXZxQ0NITG5WWlJ1?=
 =?utf-8?B?aVRteWlmU3NwdVozZCtwZ3MyVnNVT0piS0dETEZIWUMzYmNZMVJHdjJUVlY1?=
 =?utf-8?B?L05RbGlQVlJ4QWp0Lzc2SkZyT1VET1k4VUZiNzQvRzdNOGMxVWVDdkF6VlZv?=
 =?utf-8?B?R25hVDRiSEp0UUxlTXhWemlPNjlta2tQbU96NGg2d3p4WCsvYmxXdjh4blZR?=
 =?utf-8?B?WmtWYjhjWmFTVWR3REhZN3dOai9GbWVSdGxsSlBRSGsvYi9uK2ZJSm9tUGtT?=
 =?utf-8?B?Uk1wY2FhY3Y3SEZWWVU4a0JkMU5zMmJTWHc1ZGQ4b3FPUFA1YlRjRzFTV0xN?=
 =?utf-8?B?K01jZUFDemltVGNEMXNCUlJ6NXFtOTM1d0lLZE4wc3JUZVhXdVUyWWJBcHZ2?=
 =?utf-8?B?bW95V01IbGVHL0NucWNjNHpTNStzOUQyMTZ1MVBaZ3hhSHErMjFLRTZlSzh1?=
 =?utf-8?B?MVEvLzVYTU9XTS9PekpZbXk1Y1AyM05GeU5tUFNZaG0yU3crQjFWeHdLb0I2?=
 =?utf-8?B?UVY5Sjh6am1sUkMrbXN0VUFEVWdxb3BGZ1NibHhjdUlsdXd3SGx6VlhJdFNw?=
 =?utf-8?B?WVMyL2JIRENlMlBuSnBvWS9XWmpwQnZpNll2OXdzTDh6ZGY4dlhtTndqbG1P?=
 =?utf-8?B?djdJcENrYU9ZbWhZcVc3dWxTV1Nmb0ZTMG1oUDE5QUUyZUNnTis3ZVB2MGU3?=
 =?utf-8?B?bmZaVjREK2pqNVA2Q08rTEhoeVlYaDlPSXJqeDF4T2pLd3RiMWhUSUJ2SWl1?=
 =?utf-8?B?RmVMSTFJZFR0ZU1kNDJ0dWZDb0FKcUtmejM1RTNxS2hVcDBsMkJ0ZFV1S1Rt?=
 =?utf-8?B?V3pBT2RiVEhIZCtGcmZFRGxvQVBIMUphbm1POXdiRk5IaitwaEN4NzdJaUpu?=
 =?utf-8?B?SHZIREFJbXMwdU11UzNFdXVTMFgxK2d4RUVpRjF6dnJTYXdMYUpLckJEVGZW?=
 =?utf-8?B?NDNPY280QWM2cDdFM3pBc20wekpiMUhTTmdxN0ZNNU5sc1RMYUx2dzZ5dWk4?=
 =?utf-8?B?RDNwN0ZDYkpFTE5tWEFPUVpwSFkvWWZ5cDNhN0FGWTRmdnFmbHc1NXQ0U1hs?=
 =?utf-8?B?SlBVS25iTW9mcUpnS0Y5V3M4RUVMbWRNZFFKZTZsbm5xUS9HQlJCcWRzdUs5?=
 =?utf-8?B?RkdZQnNad3IwMlJwRHlQaU1DUmFzenNqRDRlN3oyRHZrOTU4MU1uYzdZZjJ5?=
 =?utf-8?B?ZytGRFN0WXNtSFZnaExVRDE0QWF6RGpoUDFpMU0xNUp1NWhUN2g1U2FUM0xO?=
 =?utf-8?B?Z2NkZ3VWTWROWFZoVVBqNXBuTm00TDM4eGJZcTA5THpJeHhnS3hqNm5TUDJN?=
 =?utf-8?B?RU4wcmttT2dpK0dVdURjeGRkZ2NMTWFHVXJybFlrRXMvR0pDd2l0UnZ5UVNl?=
 =?utf-8?B?UHJyRnBtRlJlNHJzUTJKVXZCOGEzVFVLSE52a0h1SENKdDlzOVJCdHZVdWN2?=
 =?utf-8?Q?u/3jEdDdHc0NSv5uQj0jdqFat?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e097ec-f6fd-47bb-dacc-08ddadec2d23
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 22:13:23.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Y8NnPAppTAgOKlkb5wiAD7J3HztKgpPCDVcG0lYaOihiW80CLbmq8JaIgLAcmHPUxCG0Ke0mHtwf1LkmAIGxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831

Hi, Yi,

On 6/17/25 03:27, Yi Sun wrote:
> The call to idxd_free() introduces a duplicate put_device() leading to a
> reference count underflow:
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 15 PID: 4428 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
> ...
> Call Trace:
>   <TASK>
>    idxd_remove+0xe4/0x120 [idxd]
>    pci_device_remove+0x3f/0xb0
>    device_release_driver_internal+0x197/0x200
>    driver_detach+0x48/0x90
>    bus_remove_driver+0x74/0xf0
>    pci_unregister_driver+0x2e/0xb0
>    idxd_exit_module+0x34/0x7a0 [idxd]
>    __do_sys_delete_module.constprop.0+0x183/0x280
>    do_syscall_64+0x54/0xd70
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> The idxd_unregister_devices() which is invoked at the very beginning of
> idxd_remove(), already takes care of the necessary put_device() through the
> following call path:
> idxd_unregister_devices() -> device_unregister() -> put_device()
>
> In addition, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled, put_device() may
> trigger asynchronous cleanup via schedule_delayed_work(). If idxd_free() is
> called immediately after, it can result in a use-after-free.
>
> Remove the improper idxd_free() to avoid both the refcount underflow and
> potential memory corruption during module unload.
>
> Fixes: d5449ff1b04d ("dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call")
> Signed-off-by: Yi Sun <yi.sun@intel.com>
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 80355d03004d..40cc9c070081 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1295,7 +1295,6 @@ static void idxd_remove(struct pci_dev *pdev)
>   	idxd_cleanup(idxd);
>   	pci_iounmap(pdev, idxd->reg_base);
>   	put_device(idxd_confdev(idxd));
> -	idxd_free(idxd);

Simply removing idxd_free() causes two issues:

1. This hits memory leak issues because allocated idxd, ida, map are not 
freed.

2. There is still an underflow issue for dev refcnt in 
idxd_pci_probe_alloc() when idxd_register_devices() fails. Here 
get_device() is not called but put_device() is called.

A right fix is to remove the put_device() in idxd_free(). This will fix 
all the above issues.

Thanks.

-Fenghua


