Return-Path: <dmaengine+bounces-5526-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D6ADDE4E
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 23:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183CE189E841
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 21:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA4290D8E;
	Tue, 17 Jun 2025 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PYz/9Muf"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F92F530F;
	Tue, 17 Jun 2025 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197502; cv=fail; b=OJamxNLGUqH/GeN2+3jBWOyKveKcuHpMGstg2G0ZvKK2HT3yzEhCPJ/g+MRZ5//J0sCjSw0PcJKOyoIiHai2vb95GqgIagqYmy3M1F5EGp3yWWt3CrkegE4Qy7XhLilWSyzIwrbndmlQAMnSfQ1HCC1V1y3kWY7KEt6F+M3/t9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197502; c=relaxed/simple;
	bh=3I8sdxo3E9BmKvU58AcOFZuBQX63xwuSnWwY98BXlvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qqL0W4fx5K8kQq53E6o0zDcYxh3ZAOHmF6eK4O7NeS9Rq4x9MNAr+N/LXPHFoPEdolhivX29noSBfMwcHrL3enJ6rMCewjhx8Q76/TRrq6lj0w697YnGkj1D1Krgd3BT2/unyvjL1lpUpN1Gim2LsIl4jTbBLYX5wpDu97AT6rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PYz/9Muf; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cul401qQcdYl20LciP5Br+nUkEZvleADgAjoMdnbfQaDv3FGaH9zM8GjmF7N2o+TkEsWnfOWqqBOHE1/uPVIcX9DYpJGKYZT0iGOW3+bvmb/7/+5JJH7Ysqx7vLwrw5LQemwv/rnVN6FrKcJPkNZvJg0syZKvUKSMJZjPiTyuzEudpo07cJMa19EBT/EUbwGKJtALi7LJN8Pu86zjI/h6IAV3fjlifyG/+Xkbz29ied5z6l71IKUv4A1jxFekW7sm7pq8GjH4ySiu/9t2GFHvbIFxJ2Qk390eSRIa/h2829fD8LVbItTxqGr2+7Mr+cnXhEzrEWF17ErK6Vscyujmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwjaxW5vuc9bm9t4V7snJ3bAzuksVHKzNO3Xg3Ibyr8=;
 b=AD9ZqKrQyjsnLQA4u7adOsL/cf3AOx4qeEfUVzOSsEyAKdC4/pSbwx71Es4HyY2l7VEua2R7E/7feVeSCYd9+Rmj+I+YZzk/KUsGJEe+5z6h1sAUNqYV22CdG/CHUJs6N+kxm67gq+QsbEdvdsu8SgqoqBiVHaJTsrw/PCSqJJVeDNpHBOsgWzHKN9x3WPeVbhyx7nev8EQUS1UCRSu5inWVA0FR/rTzTV6T+CNXMoytVCIy/znaCwMTfq38AiFZ+GNV2xSZYVU7mH2HbrgWhvazKNn04yrHX0RP3rhQNfI9F4pDb5N01iA7GbtOwa4Ua2fO2fYjmO+U1W9RqUnjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwjaxW5vuc9bm9t4V7snJ3bAzuksVHKzNO3Xg3Ibyr8=;
 b=PYz/9MufRP5JWDCOu5SwTLp+9EP4nXOfh9f03SpyCCtaHvw7/46a0AvbFETK/xJvsdCgHo69Iekmt9WLxv9RQ3KpBGlxZiqiasjn57wpBBh7cQU8KHrCnNI5BrKBrXyYz3cEPxJTGqH92vJgNsXzE5WXnOumzgZRsE+eRpc6yoRtEIOtRGktgd39pDhMWFepxmdVch988wFLbK6WW2Qrw4Sz5SrTKcyI60nO82t2dZV+uuM9g39PzKNelF3tMoZB/QJfWX4XzksWeTbnF6rPt6uWazQVwXnZBCK8u0WhVdwTqZOsF9zsa64n7aMWF1pm0MKEeKp8MVhmbcmrmpf0Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 17 Jun
 2025 21:58:17 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:58:16 +0000
Message-ID: <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
Date: Tue, 17 Jun 2025 14:58:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
To: Yi Sun <yi.sun@intel.com>, vinicius.gomes@intel.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com, gordon.jin@intel.com
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-3-yi.sun@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250617102712.727333-3-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ecad25-eb4e-4c24-2c73-08ddadea1057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDdKWlFUaUhDMk53bW5wSy92eHpwWXdlT1FJdzhZeVdvdys1K3dtUWduMU4z?=
 =?utf-8?B?akt5aHp5YmdJYzdjaSttTnRNMUU0ZnhLbWpjQVZFcVovQXdIVGk4N0FlVDho?=
 =?utf-8?B?TFFjVUdTeW5SblhteXhaY3VZbHBmeVp6a3FxWjZMSllqb2VTd3NCWGJuRDhS?=
 =?utf-8?B?NmhVcG41ZFp5NTl2MllsODhoWFIvUlpJUi94bDFQb2JSaDhaV0MwKzd0bHNH?=
 =?utf-8?B?MURqbXVGcEVwUTlvQUNxUDFrNFVKeTFDVXJ6Z1pZQ09MMXhZQXFsZmw1YnVo?=
 =?utf-8?B?UEg0bXVaTXN1ZWZRK2YrVC91elNWNjFTTXQ4VE9XMXRLNEpWcjluVThWTXBS?=
 =?utf-8?B?WDFaZWdPVmcwM1NsaWpCOEEzWTIrTWdmRlJrRnhkcWRuWk9CVG5aSnJTLzBC?=
 =?utf-8?B?bWc4ZmRPcWhtNU5NSGJ4YTR6Zyt6Z1JHeDIycEFXVzdDb3NzanlEWWtzRDdX?=
 =?utf-8?B?WHBwNCs4Sm5JZFBGa1lTY24zenlLaWhyTDZWMDlQZWJtOGdXeG1rSWFQdXUy?=
 =?utf-8?B?ZHRka1VyUzMrY3FVN3dESSsxM3VySFNNeldBM0J5dEdSSU5oN2x2eHlzY3pj?=
 =?utf-8?B?N3htSEYwZ0ZvSzF2SHpXcG93RHVGSTM4VGlKeld5RXdWSW40RnVGK2g3UDFS?=
 =?utf-8?B?ZFp2dTZXeTlDdkVhZTlSM3hjRm9GVi9TVGNaT0NMSlUzT2RzVkRYN3NTRG53?=
 =?utf-8?B?Zm9DdGNCckpZQUtaMndwMmRQNnJadWNRVDhBZzRlT213TmRLZFVlKzNMa1Ju?=
 =?utf-8?B?MmdTS2hYMzJnUy9Lck5YbEFXbHphN2JGK21TWG5yV2VodjViNG15emdkM0Fk?=
 =?utf-8?B?VDdEN2E1TFVPbjlGMi8xb280NGtDSnlBMnIwSE12eUIybWd5aVJ4cWlSZTZx?=
 =?utf-8?B?S3h6MkhZKzlVUWwzUG5RR2tXZFlRMDBsR3Y5aUJSMndxRDdHdnNFSnZEQmUz?=
 =?utf-8?B?citNYm54Q3dKaEdIZGREOGMrVkdQdE9EeHBldjlpakNDV1JIQ1J0bmo1UFBr?=
 =?utf-8?B?Q1dMeTZienFIZUt6NE9adW55dFdnc3FwaXkzZGxSSytDUGJJWHFLSko5N1Iz?=
 =?utf-8?B?L1FMTjdnOTNuRENDYXBKUVBvRjZOeWNlUitLb3ZHeFp5K1ZQUGVtQVc4SDkv?=
 =?utf-8?B?OEtPMTUwUVpjdjRjRnhHaGxsYzZaemxhTUVCUmt2V29jYXAyU0lBU01GbmhW?=
 =?utf-8?B?MlUxRW9EYXZ5cXlsUVZoZGdrOVVSQ25Ia2VBdjlGS29ScTVrY0ZxRGhvM1ls?=
 =?utf-8?B?eTZpZnhNa0RRV25SSXMxTDJKT3VIMHUzZXd4ZFdFNkRsYjUyd1JFU0liUmcv?=
 =?utf-8?B?MTZUUlM5b2NMYUZvOC9wSjNpS04vYS9GNkYweDlsa01IQmFEVTNDNGs1Nmdj?=
 =?utf-8?B?cHpsMHVBM2tMT0F5bmdsb29WTy9aSTdTRW5xK2NMS3Q5aU01ZE91VWNBYm1a?=
 =?utf-8?B?MnkyZFRYd0JxVlpCYmRZeDBFZnNXejh4d3BxUlg2UjB3REdQbHQ3aVBkME9W?=
 =?utf-8?B?Nlg5aWs2bzdvRWhHaE1xbjNrcnJRK2xOSEZVMlA0M1RpNlhRak5FVGJXMHJB?=
 =?utf-8?B?MldwQllDbE1XQzdodVZtQ2p4YUs1clVDbjRVL2dBM052dHV2TDFMSjFZcGpE?=
 =?utf-8?B?WDUrTVUvcG03dGpLVGxPdmZnWm9qZkVzdE10ZDdJODJnQ055NENEZmR4VmUr?=
 =?utf-8?B?cVByVDdnOTd6ZlkvMGF6akVPdjlYcDNkOW51UzdMd05FSVRIcjNtNmJVUHhC?=
 =?utf-8?B?Umc2dkNkczg5RmV4Y3RHTUlibFdINUtUeEYyRU9ZaHJXN3pJaTFjTm5ObXd2?=
 =?utf-8?B?ODAzQmRyUmRFSnRKZzBZSVVQeU55YVZRNUdXOUszWFFwN3k0blR0MGRYVjJy?=
 =?utf-8?B?Q2YyZ1NLdXZkbEQyU05XSzBhK1c2RHhoUkgyVWxSQjNIcmovTkFEbkVjMUFn?=
 =?utf-8?Q?Te23x9R8w3o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzlTWXpseXhERUJSVHVSNVhXUGtMaHRPMzF3Ujh1YUN2YUlLcHIvdE9MMmNG?=
 =?utf-8?B?YjdRaUZKaUZMK29TWWgzSFM0WlAvT1dHTUcvZFp3M1IreGlDeE9saGJDUG9R?=
 =?utf-8?B?RTQ1OGJUSzVhR1pBd0MwZk91ZnJ0Q0p6L2JGUnRRZU05Mm5rK3JnZ3UxL2Nn?=
 =?utf-8?B?anJPUUFwMHoyVmNnNWJzeE1DdjBMWFQ3RCtKZVBOVzlLcUYyTUZxWHh2ZWJx?=
 =?utf-8?B?cFQwbTR4S3lxRTVMOHFHMlRxWmlGaTFiSmZMSXVid245cnpTVlZhRy9OZ1FV?=
 =?utf-8?B?c0tkSHh4WU56bkFJaGFCLzJIdUxDdHdsaU13WFZtYm5jdlRIN29hMzNYVkRC?=
 =?utf-8?B?ZFlreEltNVdKRUYybitFdlZxR3UzUHpwREJwNmEzd09NTU9uNWlzRUl4alhZ?=
 =?utf-8?B?b2s2WnM0T2M0YVZEcnAxK2FrWTU0VU9iRUZxV3lUaTh6NGowajJiVXYxSGpa?=
 =?utf-8?B?b3ZvcmoyK3BTRy9oU1dheExXUkN2RzdLZG5Pa1MyWlZUbi9HajI4Vk8zbjFE?=
 =?utf-8?B?bWR2UzlzMDhvRnA0NDRRVTBZRFdFTm1Ha1Q0L1JtWVlIdkd6S2dHWFd6bFVk?=
 =?utf-8?B?VjY0VU9TbTB1WVFST3JjdFNPdC9lZk4yd0FhOG1peHVnSFNPRFBkQlJyWmNQ?=
 =?utf-8?B?SURCUllxOTEyejZBVUNnZTVMdnRlZGRDK21JcUo3ZDdBWTAxM1FtOUZsNlhs?=
 =?utf-8?B?b2FzeTYvN01pUXp0RVhLdWdkRFZYSnVzUmFVdUtldlM5aWlLR01tTVpja2ti?=
 =?utf-8?B?SElmYUVBMWRnR3VTdGpJOWJ3R3Rjei9NKzFLRklvbStlQ0hZOUdmd1pJM3JJ?=
 =?utf-8?B?SXBPMmh0a0czUElMWUlDNmUxdnM2WkREUGtWeDdNWFMweDBlcm52VGtqMGZP?=
 =?utf-8?B?M2gxWmd0a3NmK2hUU2xkWVhsUzkxLzFNRkExNHJud256VU1WOGZqTXY1QWFD?=
 =?utf-8?B?dFllSmdGOEJSTGZxdDZCVzRHU0FDd2dabFFnMG5BT04vMW1NbWFGMnlZZ0pB?=
 =?utf-8?B?aVowVzJBSE9LT0d1T1NMZGZJMEZmNEpQOENXdElLd3d2SXVpWkE0ZUJGZEZD?=
 =?utf-8?B?YmZzcDJFblM0QzAyeDhMZzVuTEU0NS9tSkFBTkZCdVRXWmE2YWhRNk0vWVZV?=
 =?utf-8?B?cndiMDExbElTaVFBZnlRNnEwWXBhNW82a2U1SlRNN1hMRlphaEtxYTFtbXND?=
 =?utf-8?B?YnpsWTZucURvR0FDMXRDWDZuakpGSGhFemN3WnJzd3UwcklUbjBzQWJZaE5r?=
 =?utf-8?B?MzFaaFhYTG5wbnNSMnJRaThPZGpBTkVHSmI0aWlVTkdlYTc3cldZMWRJeTJh?=
 =?utf-8?B?eXJPZEphSzAyS1RmVmVKYjhERTVOMWdoeEs4djVHa1lwdXNrSjJPcmJDbXR1?=
 =?utf-8?B?d0JzNFltQnFmczlSWXIyUHgrSFNzeTRhZGJCRTk5QlQzdGJPQmU4YjhLZ2Jw?=
 =?utf-8?B?MW9TZWNSZHhrR2dObWNmVkF1YlkwY2JJbmZWd3gzaXc5MXlZZlp2YjY4MWYv?=
 =?utf-8?B?bGVGbnpmWFpKWE9PUVlPdzdvaXpMKzB2RnExVEFhcVZlWDdia3I2eGNEMFFH?=
 =?utf-8?B?Y2ZGVHNpRjlleHowQktBcXBudjI0dTZ0dERJVU9YSHVzeXdTT2lRd3NnMWVh?=
 =?utf-8?B?TUNqN2JMdHl3aC9yOXdsN2tRLzZRdkNhN08remVJM0Q4ZVZQMTA3YzExdk8z?=
 =?utf-8?B?cDNVL01SUnRVbHJ1ZGxqYk9qN1E4TDdsVGNGTGp4SDI2VG81NjYvRjlicHZk?=
 =?utf-8?B?SWR3dXBveDRPRkVOSkl4TEdRRkhNWXVWam80emk5c1ZlQyt3dU12S1Q1QXhi?=
 =?utf-8?B?c3NVdFVDa3lzQUJlLzVOamdKTyswb3E2cjdnSzJucGVxZ3QxZ3ZzQmk1Yy9z?=
 =?utf-8?B?VUpjcGp3MENxV0dXWi9UTnFjYWxhVTJWZmpyMHFadWE2NEdIMlhhZlRrSTVL?=
 =?utf-8?B?aFNrNHg5QjBVeFc5dS9KTFdUUFpoclJjcHdqVTgwZEI0MXRJSTUzUGdhYzhO?=
 =?utf-8?B?VElXdlRpNXlMUzVRakhrdzBxUE5LbFV6RTNLNFAybG9yNTQrcnJVVUx0VE5R?=
 =?utf-8?B?V29CWUpXSldxckxQekNSU0hNbGNNOWtrZE1oWXlLdWMyc0Q4ZitzL3h1UGp4?=
 =?utf-8?Q?okhCZgJVcatc8+aXj3l2Qnb4l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ecad25-eb4e-4c24-2c73-08ddadea1057
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 21:58:16.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdGjcWpLmJLRhhZ2yM0rpc2mAEI19K5snjbW06FGMyxn42DyVxoHZ4K/85n8+xVAEScGqB0p/gGD0cGpOx2mKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4

Hi, Yi,

On 6/17/25 03:27, Yi Sun wrote:
> A recent refactor introduced a misplaced put_device() call, leading to a
> reference count underflow during module unload.
>
> There is no need to add additional put_device() calls for idxd groups,
> engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
> also fixes the missing put_device() for idxd groups, engines, and wqs."
> It appears no such omission existed. The required cleanup is already
> handled by the call chain:
>
>
> Extend idxd_cleanup() to perform the necessary cleanup, and remove
> idxd_cleanup_internals() which was not originally part of the driver
> unload path and introduced unintended reference count underflow.
>
> Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
> Signed-off-by: Yi Sun <yi.sun@intel.com>
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 40cc9c070081..40f4bf446763 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
>   	device_unregister(idxd_confdev(idxd));
>   	idxd_shutdown(pdev);
>   	idxd_device_remove_debugfs(idxd);
> -	idxd_cleanup(idxd);
> +	perfmon_pmu_remove(idxd);
> +	idxd_cleanup_interrupts(idxd);
> +	if (device_pasid_enabled(idxd))
> +		idxd_disable_system_pasid(idxd);
>
This will hit memory leak issue.

idxd_remove_internals() does not only put_device() but also free 
allocated memory for wqs, engines, groups. Without calling 
idxd_remove_internals(), the allocated memory is leaked.

I think a right fix is to remove the put_device() in 
idxd_cleanup_wqs/engines/groups() because:

1. idxd_setup_wqs/engines/groups() does not call get_device(). Their 
counterpart idxd_cleanup_wqs/engines/groups() shouldn't call put_device().

2. Fix the issue mentioned in this patch while there is no memory leak 
issue.

>   	pci_iounmap(pdev, idxd->reg_base);
>   	put_device(idxd_confdev(idxd));
>   	pci_disable_device(pdev);

Thanks.

-Fenghua


