Return-Path: <dmaengine+bounces-4518-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57819A3A89F
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 21:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E06B1890B1E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BE91BC065;
	Tue, 18 Feb 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QpvGp+ML"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A41B423D;
	Tue, 18 Feb 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910079; cv=fail; b=s3NK4MSw0FjArtQ/tcZvrR2Zq7DRUu1Cq8I2+7aiX8zlllcm+lIE2CxOH55CNxifzsVInY65B3OnLfecJFnD8s/kbY0l1HRJWqBez3nAkgRlvJdnq09WjASm7tCCd2k4HTAg6YBBZ/fpyXFHqVHiVWWaMXN7olB2A3k+IvHNGmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910079; c=relaxed/simple;
	bh=uwy7ok+YZDcHG8lcHxkGEgtPK6fZbjdNX7LptduVmno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P5u9ZJ8iinczEG8xjhJUCJCLamtKMDIjYeJSRvyEp09c/43amccGVo/Hzw2EZSjf/+vzK7NqtaDZxZfnJMqo+OyRpFk2xpIUtfTLkXen+5RG+OZZCyKbQ69v8WR2b+LGQecF/HH2eXmM98ngcpcxAI5ESR8r2eRF9VEagOb3GuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QpvGp+ML; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flLwhVY0/QgeaWkr50Z8rMD2xpKLufJU6qxDKqQ/Cy2WDR5LhuGWXP/Oc7nvZTQSI6HEQiyBNOOXAwxK0lWMkSGvbOOhhKtV+/kPL+XgpV6AIh/SFV6ZC6hPGqFfpr1Ssu3hfqPw5pnNVJvAU9BbXoqe//gACEHOc8Ek1iu6AXEg1TTXMRR+OH67WQ5M/xmkfpqCD855lOJT8rh4jBiOHwkbdp3hRxiQYGdGZcebMmYM1AzOj3e56BOBDV6dgQDZZ2JNJymdHUxcY67lvmjwEE+6q9Zmb5rLLGF6FmWMgzb871h5HML6y5wF7Forb+XhNg79++MlhUIvIX8NfkDPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjM1tqGHaR2CfciMWdQpjxciTlL2RzfqXWVI9H+nSEc=;
 b=bLy7GJHC2oJFzvbDycnvuEGwrbuCj+qcaVRCiBSxQgn2PiY17sJyAt08MuEP7h2sqGfW6vqiM2kHQ5nL3xaNucpb1Vh6JXs1MWa9Ef/6lSQ5mUt4SlfS4foqgShtrS1RxkTamg16P6ay2e+PvC0jaxJE8BvTk63lveAQ9pesAjFbI/5iizFTJ0qGiQorpAQHh0mxkSyzjmHZLJl4tjvMEJn9yjUlpYkDIzbswqVqXHoZG+e9DL/ajbmgQbKjcPE2FYCAjFWi+lj3nJnAmhKA+RUBdpb96L5tllnhuQBVmv03v+i9LJ0sz9bowu75aTkupykQz9VvcMuSPxMdVX0URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjM1tqGHaR2CfciMWdQpjxciTlL2RzfqXWVI9H+nSEc=;
 b=QpvGp+MLFkU7efXXPpPlHVAl7euM41eo3p1UXCYmgBdZHfIyHRNF1P/ni2Mvg7CM+bTVWOS9KTqXAcokrLllYitK6Gq8UP4/HkNSMuHHOvDYpwibWwIUeRDk/RFHdJIITtYEC8FN5goF59Z/cWr/J6llG6LF0zPv+oJpy6F5DwwE66nJxhXYUPjeiJOpiAYHnYbCflPqsE2xRitY8ATOurITmzR2wbvsEu9XP4XAj6wZCwO04H0kg/9k7FoEIfM7f1lGaSu/gOI4LLNeDNDANQmj3ZUvrG996bnOqo2niMWMhUqMtUkJgD/OfrKatPpN4j9fzCLH0OUnJFk1hJ366Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Tue, 18 Feb 2025 20:21:13 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 20:21:13 +0000
Message-ID: <5959e316-19da-4d10-bc7c-75431b87b9e0@nvidia.com>
Date: Tue, 18 Feb 2025 12:21:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_pci_probe
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: nikhil.rao@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
 <20250215054431.55747-6-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250215054431.55747-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 4990a8ac-0378-4b3a-e480-08dd5059ca08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjgwR3JOZXcrTnZHZWEvM2dxbForQXI0S2E2clgrSTRwUVVwMUVUTHl0T0V3?=
 =?utf-8?B?S3ZVdkdsb0JJVlI3Skg3QjR3WjdObU1ramIzK3FVNGFoSjY0Z21xWlZ3U3V4?=
 =?utf-8?B?UkNUMzZjbm1sZk80K01saUZBVlU4WkRhY293ZmJOMUsrMXRMQjdpeTIvRUNL?=
 =?utf-8?B?UUxJamMrNEQyQ1NLZGJBc3lTY1F3SWNGSVJVdkZFZm1aNjNhcHpLVmF4SGlW?=
 =?utf-8?B?Zk5uNnJPTnVoQnRwOHVNazFTeG1FSkcvVGhJUWU1d3UvZ1JnbndhUjgyNzlk?=
 =?utf-8?B?K1JIdXMzQ080NXR5ZVBxMXkrN2dqS21wWFRkZzRXTWF0bzhGVE9rWWZWQkR5?=
 =?utf-8?B?VWVpTG5IMlgweFVtaGtVMVB0dE5UbnVJZWcvbjJKeGwvaHdYRnJIbkhQUVo5?=
 =?utf-8?B?VUxOYzJoTWF0SDA1a3RTSkdDTUU3ZEsvOExWYjFES2RmTGNvVnZScGg5bmkw?=
 =?utf-8?B?aGJQQmxqR2FNMUV2OE9mcGgxZDRDcTRGZlkwVFpMeXB1djRiS1BQOGtoVFdu?=
 =?utf-8?B?KzFvZ0pVb2VOb3p0KzN6QkowUXlCMlVyMUx5ZTZPbWFza0g3ZVBFMjBCblZs?=
 =?utf-8?B?T290cG1ZTXROdmFMdllnQmxZNW45UWwxaUMway9xVVZrTUVhL0Q3clhGdldq?=
 =?utf-8?B?TkJrQXV2ZDBIeS8rUWxZcmQrVDExTExOVE41RnRCMHlWK1NMUHhOdFNxL2ZW?=
 =?utf-8?B?L0JrMlJIZ2FJeVFhNlY4RDU0Q2p2TmlNMlY3VDh3RGxyQ1o4NWlpaGxtam1a?=
 =?utf-8?B?eno2VStpSG9zMTNvdk52Wlc3L1BiU2JJdWlneUpTRGx5RXNIeHliQnVnVG5P?=
 =?utf-8?B?aE9wbTh3NEIrTHRvTWdzU1BLS1QyNlJldFEvUWFuVTF4Mm5qd2RDRU9YUWU4?=
 =?utf-8?B?cGdXYzVCUGxyQ2FMVHc1ZTNjaXI4R2poVUdJTStsYUlqZUR2d0UvUDFpWkl3?=
 =?utf-8?B?RE9EaU4wTndyV3hTNWtZeXFlWWhyTkVKR3Frajk5cGxRbGMvM1prdE9oL3ZZ?=
 =?utf-8?B?Y3FnY0Z3K05WL3c1cVp5L3pQTE80bW4rSkRSUU02MXlNV2hkUnR3Mk1jTHEv?=
 =?utf-8?B?enBwaVE1T2twYUdJZCtyalhZSzVLT1pKc2lRS1ArQnFsSm43aHk2UUNVOGov?=
 =?utf-8?B?dzV2MVM0WHo2VmU2Z0E4OHBQd1ljKzJpc1FUa0lQelFERFN3K2NFWm42WnZi?=
 =?utf-8?B?VXEwSFRVcWtycmNkWlJ2QVZwTUVxc0lnNmVWeU05YU1PbXI1SlVwVXBxeHRH?=
 =?utf-8?B?OUlEKzd6NlR1U2d5ZUhMSFEzYlplOXZyV3o5R2d3dUVmM0Q2YWZkZmR1Tjd3?=
 =?utf-8?B?d0F2TklrZTZZRTk1RElpakwwSSsrbnJvRjR5UFF0bnVmOHcrWmFnV0Q1NlMz?=
 =?utf-8?B?dXdLUEdTbngya3NCRWd1MTZhRmgvUncrbW53RjRMMkFpZHlwendSL0ZCVmhQ?=
 =?utf-8?B?d3VVem92QmFzQmY3Tjg0RW1QOXlJWmFWbW5qNGFwRkdFQ1lOdlI0dUxDUEpX?=
 =?utf-8?B?dlVNS0xvY1JZVkVxMC9yVXFNZU9MYVIvRVhCRTh1bERLQ2RHSmdzYW84QXo5?=
 =?utf-8?B?MGptVm9aYjNybFNSTTVlUGlQc2JZOGpGWFdrdnVka2RQQVJtV1FET2U4UDNU?=
 =?utf-8?B?dElVMC8rQjhucEhLdU5COUNZWnV2QVZPaVhqaDRTOWpmMFZ0UWFNd1EveFhy?=
 =?utf-8?B?dDBiSnV2ZmIySW11Zzd1MzVwNTQzNzlzMURKL0ZvUFlmUWlHNldTWGlNbmNB?=
 =?utf-8?B?MFB1YWNMSVVtWDlQNStaSXYzNEdKVGhSazNaZ1ozMVpFVEZpMTIyTVpTOUhX?=
 =?utf-8?B?eGJZLzFzdDBTamY2OGoxMEd0OW5uWmR4SlBpa0p4WHhNcGFFQTFvVW9rMkdM?=
 =?utf-8?Q?MEPhxC3IKvXSr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWhMTUJBTjM2eGlHRytXUlozcStKOU5VQ01QS2dLTjh3SUdGa3dERlZNZ29X?=
 =?utf-8?B?RDBXQWNQSnEyVmlKRVJhbDM0eWFjWmZieHczTGFwcHVhWS9IREx0ZDN1Vkxl?=
 =?utf-8?B?Ymd5WlJyREdmYzlkTllSb0JrRW9PY0czZ0xtTzdFQ3A2SzhEY1ErTDhDVVZM?=
 =?utf-8?B?YjlpMDdYV2F6UmlwL1V3UXpKcnEyT3ptRTJzMU9GNW9HT1F1cFdDZTdKcGNr?=
 =?utf-8?B?VytUL3JuTnFvbkNxZUJSbC9EREhuS2UxUlk2UEtFSFFQUUdNT3pTNXZnWHhp?=
 =?utf-8?B?alJUT3ErK2pqa2VuODk1NkFyZ3loRVdkNGZEb0M2a3NoU2dDYVMxU3Uwbzho?=
 =?utf-8?B?NktRU3FHUXpQT2tONzh3QzVEdjQwa2lqNWZ3a3lqMnkraG1Xei9xMUJkWkp1?=
 =?utf-8?B?TU84QUdaZE1MaE1ic1BkNnU1eU5VSWtJb0dWUm5xdU9WMWYxcGFpb040RnFH?=
 =?utf-8?B?aHR3dTQ4Q3ZycTg2b2sxV1hpUDBGYUxBYW1SWHZERUpKemRGelJyN2p2ekEw?=
 =?utf-8?B?YnJ3dVUyaW1xN1oyeFF4ZG1MaDRoOVgxVmtjZGF1dHVxTHoyanBLQldlM3FF?=
 =?utf-8?B?citSNWdETGhObmFnOTZTaWdqVWZhSUhLclZ0M3lmUE9SUnVZK3YrQXA1QlhB?=
 =?utf-8?B?bXd1NjIrazBUWHk4RkZkbExhVE9xMGlQZjlMWEFubC9CZER3YWZlV1orNytX?=
 =?utf-8?B?SG5nc2tvalpmSStia0wxRE5TcGJFRG9CTEpVaVByMnhtV2ZFT1c3UmhobGUv?=
 =?utf-8?B?N1hwNGtoRkVibkcxY3ZOSFhQM3BXZkNOc3h5YktqUTVZOVc5dTdrdy9Rb0hW?=
 =?utf-8?B?N29OZlB1SjFXS01nY0RvRlVXaGZrOHdpOFlDZWllQ1pSMUw4TFJUY2o0YWI3?=
 =?utf-8?B?SVJpWHFGUUlRUlVLczVvc2xta2NObUQrZlBWWU1tNlltTlNaak03Sy9lRklm?=
 =?utf-8?B?ajFSSlg2VTdyakVmeWdMWGR5MFZQVXpaYVJ2cXpDRW01RDg4cm5lVW00UUtl?=
 =?utf-8?B?VVNhNlBFZm5iSXM0Z3p4b0NjWE1Qc212b1FTZmNQK09lWEg5NlRFRjhQa0RO?=
 =?utf-8?B?K1FCQnoyZ1I5ZVBGN1V3MVVmTGcwZTVnN3Q4UWl0Z3Z5RHJ4ei9GK2JKNzFK?=
 =?utf-8?B?T0pwNjkyZHp5b2liT1FFZGZ1VzJheitmcjZ6LzFNV1lYWTIrWCtVZm9aZy96?=
 =?utf-8?B?TzUxd1NBSWtWMmJseDROYVRzdGlPc0ZhRFdsZktJeU8xVDd4Tzk3bkVkNDJ3?=
 =?utf-8?B?RG5xYXIrRUN1TnhrQkVja3owZERGWEhrdXNuWnZDUTdiOUxMZXdDMlBZMzRk?=
 =?utf-8?B?U29Ua2svaEo5VllDNXZpcTBaOWtWUEd0R0QzRnBjT0pGTDZqRkJvYnZpTTVH?=
 =?utf-8?B?ZHVJTEFxdGJoaXpGdDk4RVJEdW9xdzgvSXlkMlk5Zy9zYjhrcUF3ZlUrNEgr?=
 =?utf-8?B?MG4wbzJiRUZsdGlEM0s1RU53S3F6ZVR6dlN1cDhFYmRRekI1UjVBOTgwWC9V?=
 =?utf-8?B?N2pnTGpuL0hkYXZlcjVSbnYwelNseWcrTTQ4UHd5VkJiUSttNVFsZjVlZUl5?=
 =?utf-8?B?TWRQdTlQTjVub0ltT1lkNm1HajZmek5veGE5eXp6M2lvejVVOTFaQ1R1UXlB?=
 =?utf-8?B?T2lBdVgxM21ZOFFvVFlTVWoyNUtjazBVeHJsaVljc3NxWkc4ZkpNWkRpVGMw?=
 =?utf-8?B?ZStwVEtTd0VyZ1doOEhjeCtodGxwL0xOdHAzYzY3bm1yRHJtdWJGdXNDS0tR?=
 =?utf-8?B?UmpzV1lPSk1yRlFlLzZGaUk0WDJMdWdjbnRoampuUE5vNWpvVFBuR1JyUWI3?=
 =?utf-8?B?V2FFZml6S2RxZ1hKcXY1NEFPVGdYM0xDZk9jQmdJcWhyd0lsSG56OEtsdkhF?=
 =?utf-8?B?NEhVZGlXQ3VhM0h0UytDYkdKeXp0akpQYStRbUJiaWNTN1I5Rjd1M2toa1Z1?=
 =?utf-8?B?aWxJN21vaDZNamVwUlQrTlV1M2l6WHlHa2lpRDhGdEJxU1cyOE52UUNBMkpN?=
 =?utf-8?B?UjhPZlZpVkpqOENoUTZkdU1PK1pBNzNrRHJrcXlkeTN0RHhsVFB2RmJtKy9q?=
 =?utf-8?B?bWRpSnJMNElqdGcvQ2xtWUNBUDIvNFcxdlZZbmZ0T3R3ZjVXYVV2RXVyN1NU?=
 =?utf-8?Q?Q64uY5nGlLcqHNkd4phR+VB+j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4990a8ac-0378-4b3a-e480-08dd5059ca08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 20:21:13.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccCxnKZOoqG4MEOGKVe8y8IAzc7k6BqgjWBonVKT9W60ZOpu4XJEaywxHL4xHjQ/HNwORJswKmoDDrkUxY5+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

Hi, Shuai,

On 2/14/25 21:44, Shuai Xue wrote:
> Memory allocated for idxd is not freed if an error occurs during
> idxd_pci_probe(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
>
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dma/idxd/init.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index dc34830fe7c3..ac1cdc1d82bf 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -550,6 +550,14 @@ static void idxd_read_caps(struct idxd_device *idxd)
>   		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
>   }
>   
> +static void idxd_free(struct idxd_device *idxd)
> +{
> +	put_device(idxd_confdev(idxd));
> +	bitmap_free(idxd->opcap_bmap);
> +	ida_free(&idxd_ida, idxd->id);
> +	kfree(idxd);

opcap_bmap, idxd_ida, idxd are NOT allocated during FLR re-init idxd 
device. In the FLR case, they should not be freed.

> +}
> +
>   static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -1219,7 +1227,7 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
>    err:
>   	pci_iounmap(pdev, idxd->reg_base);
>    err_iomap:
> -	put_device(idxd_confdev(idxd));
> +	idxd_free(idxd);
>    err_idxd_alloc:
>   	pci_disable_device(pdev);
>   	return rc;


Thanks.


-Fenghua


