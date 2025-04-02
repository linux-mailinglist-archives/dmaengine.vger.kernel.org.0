Return-Path: <dmaengine+bounces-4805-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D975A798D5
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 01:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE4B3B101D
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54F1F2377;
	Wed,  2 Apr 2025 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KuHW6atR"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAF26AFB;
	Wed,  2 Apr 2025 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636671; cv=fail; b=La9sOGRBr1wuiJucurVT3Lu4AQpu+Bcyh5qfalvpaW5Ue1a5nZFiMf1G+9Y7Opsve/Mje/etlwL9Uh+tI/BV95Y9XI2zv2az6mwlKuNBCVs5r5PRR/cLxJsQ8cY1QPi/iieFwFOxfUcrlT5EZZ0xcyYfn8qSsDtM86EpR6u4c88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636671; c=relaxed/simple;
	bh=iFQoB+dR2KSrRxooqVIUyxD9Qs8rJz3Xmsq6JVqhYM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tLP2ai9WYopALPis2T7Qqt2JfgEeQOD/U1tiuGpErJ3rxA4rsE1CWzdC90kP9Rr8j5Wdx4ZDSmSMxzg3jbo/vm2bgNuEwQsrfSgIqLL0C8z7YDGFjxWK3eV2zT8BXwSFfRMjmzP1kP1mNYL4UX86mruSptntyIosIouE2HrkCO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KuHW6atR; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZiGRnFnRm9Zd19h+FHLDkaBXkeVWy8P6s7uswPhqJbZ7/gKUjGTdrYlk5j9v6Ssu9vZkWSOLUi9PGGdnPnG10mfPkBunxmlKICwFnJLvTk4ZrG9xaM9NTs6mnTjr0j1QaSNMT5gk4S3hEZphhiaEoZIJIMUrigkyRoAKwJVdDK2pZdqURXQ98is5YCd7PjjVvACxKBDt8Q+QYnPIXVzDnkei7qnkRXZsEb+YDpoCAUaB4BDwTPldP9L3+3oPaFEBnJW6RGEEztW4cqiktJJ0ZrtZcyWr5Gkqdw8auJ1hju5sJespl0B4Z4VtXv/ugGvlIdocbh2L+Gbb9je8lUgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKPacIfSKxLPVnzKIJ7rCo5ZbxcGFzYl9L0CGyFe3B0=;
 b=qNYvXPzA9MhcEskzLSWJ3BOiYWwmdV6PrkVWAEtWmXN3SFXcjLvATv7XqFCQYkwLxVCz+gmOcHsZdGdm4fzBoXX7bhBL/IDbw0gLfYLqoLy/6Bd4OOBuvm32YYFDywA5FCd+Kq41GYjqh7pMZB3wjNxPA0ZWSFl8g7hlNuQhut1mt2LT4P7aNf6Dx9//P5sxlTGOGh/NxkN9F2NmLT/e3Sh6erDtmU0koE486GGZ3tVQSmJpu0GHp1zP5hYg4EGO7hIkJKKiyFiMk/6DPKQYY76jcuQl2OsuuYoeIZQuSf0tccHD+a2CQYmSNt5qFdz2S3La1B3qyjU/PeQbF0ld8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKPacIfSKxLPVnzKIJ7rCo5ZbxcGFzYl9L0CGyFe3B0=;
 b=KuHW6atRuB+b8TUXxSeSWR1uwybIM965V4hODta0zESsXcOiQtm+OOC3JZbklLBnJy1wLWXqb2g9JYNx1zcrr5/UDJsw7qJy3jTr1NBk41SkCRWlD83/PBMk7eUJo7V89RrFc7/jOnrZurG4ZJntQ1IEGKudGd8WYn/0XW5t4tqUlamXe1PZZ9o6hLlIx0wS/X3ppDwvUgelSB/EhqYJMpRQ9nyrcyedbp1rZ/luhGM+HohM55gZGpcVDRadTeylE0M9AhgLdnchkpzHNDZ9QSX5DDZ9pEAbFPVv6VjsS6lNqLOygnsX2YWN7SEWD/zh6yFQQOGy5TFHdNHxT5b+gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 23:31:03 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 23:31:03 +0000
Message-ID: <12c1cfc3-a3be-4372-aa89-a4bad4ec2bac@nvidia.com>
Date: Wed, 2 Apr 2025 16:31:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] dmaengine: idxd: fix memory leak in error handling
 path of idxd_alloc
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, Markus.Elfring@web.de, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-7-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250309062058.58910-7-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 77079926-fdf5-41a9-8829-08dd723e6f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3RiRUIrcUk4WVcxUWNmblNja1ZFUXdBWTRxM2RmcjJ6V1JZZW93MmNodXRv?=
 =?utf-8?B?bFVZQ0g5S3ZWYnN1cVhJdFJWOGsrL2ZCcklkMnJCaUpkT29qekpWSUxCNHl1?=
 =?utf-8?B?Y1pQcGxSakRVZHhYVTB3QlhKWnQyOTRhUEIvRXJBcEpMUVRTNmV4and4aUpi?=
 =?utf-8?B?YlhFZTA2MGlzQStKSGxmcjBLT0R2S3JLM3ZPdGlScWJyc3FZTDdqTFdvTXZO?=
 =?utf-8?B?K3dWS1BsWWtxOFYzZFQ2R252RXQ1b08xZmdGcFFQMlZ6bE53TFZjdmlTaHRz?=
 =?utf-8?B?RExhRmpJVXFWazFFR0gvU0xmeUdCM09VZTBEbHNQQmRXSnRtQzJKTkN4Ym0v?=
 =?utf-8?B?T3pnTzVBVXUyaVlnZHlaQUNrVG1GYTd3aUlXTmo1bUdDb0dWYlpKM2lMdWw3?=
 =?utf-8?B?b2I0VGJpSi9FOG1EeDVQS0JONUZ3WFhYakl1dWFYc2pCK0RiTnArVFh4WG1t?=
 =?utf-8?B?S2djSVFKMmwwQWJNeDIzZWJYM2ozYUwwSjFXeGtVL1U0SHljdDZUMVN3WnYv?=
 =?utf-8?B?eVFGRm9yYjBFbzBTd29ZQ2lPWW9SVzk4S0hzZGVkOGo2UlFEeFd6TFQrM2p4?=
 =?utf-8?B?UDJNeitZNFR2UjJib011Nmt0YXRQZmt6RS9vMXU1Vi8yRnAvRmlMWkJxTUxS?=
 =?utf-8?B?WUQ1UmtmVEpuS2Y5Z21ZWHdRbjRsVHFKbTYyWFJHbk4rdkNzTU8vL21rM1J6?=
 =?utf-8?B?UllDWmlhZGppa0N2cnM5VDgxYXFEVTJjWi92dTlOdHV1SVVzQ1FIQy9iWith?=
 =?utf-8?B?Z2FXT0FKS3BxK011U1R1SmhGRHA2MVVNVEsybzBFU1NaREN0cWJlak1GVEE1?=
 =?utf-8?B?akhlaVpaRGdTczNYeEpCdEMyL0k3bmpuekVVbzFHWUJtVmxVUVlpc1RHdUZk?=
 =?utf-8?B?NEV0NjBPcmkvVG05djdoR2cwdC9CRmZZRkFmNU9aM25rdzNoMzB4US9NeUJP?=
 =?utf-8?B?VW8vYnc3QWs0aS81WkhpQU1ac1dBaFNLaThiV0p1d2FoQ2xKSHdqdjRybmJo?=
 =?utf-8?B?N09XM0JUcXFTS1B3QjNvS2UxS1psREdSUkpPeGxIeXdWUEtla1RoSHpBRFFM?=
 =?utf-8?B?OWlYa1BVbXBSOVE4NGpEbkpZSUpBQXZ0cjU0VElMSUpWR05nZG1rbU40WnUz?=
 =?utf-8?B?SHRKTk5ydUNJTDQ1VERkazNuREZjUjdkaHoxQ1FtNU9yYzhsTDZRcXFqV3BW?=
 =?utf-8?B?U3B6c2F5WTZZK1BkMEtlZUd4d0xEMW9IRkM3aWNHL3NMOU1MN2Y1TzdQQXox?=
 =?utf-8?B?NTRzSmZFUzNiaTJLc3pVWjQvbU9CeWhnVW9KRVh6bHJJUFBOaDVjWmJsN3oy?=
 =?utf-8?B?RlM2VXZUVjhTVFJSeVlyb0Q5KzFML3FFTDVmOGJadUQ0UFNaV0xzczBNUERl?=
 =?utf-8?B?WStFcFJENEpyMnBtMTg5TVVmbmFWNGlyTU9aemx2T2ZndTdNQ3dKc1pwS2Q0?=
 =?utf-8?B?cXJURzJzNlM0eThQbWcyenlFaDlkU1d3eXRGazRRMUlrL0R2WWpuTEk5YzRn?=
 =?utf-8?B?bjI0dW1yRjdSZE54blQyMmpIam1qRmdCZFhWNlowN0xidnpXVDlSSExJNmsz?=
 =?utf-8?B?OVErUWNEaSt1d29GRFQzQk5PRDkzYk5GdnVyU0JyQlM1SFZNVlZuY1h1c1Vh?=
 =?utf-8?B?dFVyN2I3VW81S1lPTEd4cnFSTHJmZE1sQkhBc3JEZ3M5WVJWcnRRbVNYcXpJ?=
 =?utf-8?B?cm9IMG5wSEtxUGd2Y096aXJOMVUzMDVYdWpWeUN1dXJyRGdzMVExVnJRcTJa?=
 =?utf-8?B?OVArVEhQUER3dUlEQWNDMDRBSHc0M3U0bHphc0pjZTBjS25EWmJCOE9wVmRL?=
 =?utf-8?B?UDlnYWE4b2dZNHJDbG0wYVBvVmNpUnVKQVhyUDBkV0VjYjZibGVZWlMvVnVR?=
 =?utf-8?Q?G0cGbk9aoOwiM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjVHSUtsYlhjc1E2YUJpdVhqR1N3ZGdEUjFmc2wxK1NFQUprelRwNmtTRHNB?=
 =?utf-8?B?Yk50WC9XRVFZM2dGaktIb2dPUWZVTWFpU0pMVEhNZjJXRlNFUjd1V21ZbEZ2?=
 =?utf-8?B?REVpMldCN0xpUHZnWWJ1bGNwRGJmdFI0amQ4QzBUSFViY2RFQjJYaVdyUUto?=
 =?utf-8?B?akkzV1Z4eGdxaXliWnhNZWZqdHlmMFV2K2hXK1dUQWNMdjJkQkJxN3gyZ0tK?=
 =?utf-8?B?aHRsd2FvZ21ZSGZwR3BnN0xRTFNvc0o2Q3Q0TTJlNnJ1cVRKSGh6TU9aS0J1?=
 =?utf-8?B?cjBJem9NZURvTVdTelFPeXRzNS9EZU0rUy9USEgxdlB2bHcvdm1TR2NCL0wy?=
 =?utf-8?B?NE9pRGE1WHBwWVZoSmlZZ1VFSU03VXJJVzJpYVFhdmd2cERsTkhUREVZNjFO?=
 =?utf-8?B?eWUyU05TUlcvMXZpUTNLZzJmQTBONVhsNWZIcXRjMnY2RHppaFhTV3Mva0hR?=
 =?utf-8?B?dWt5NE12THdYbFNNeE8xZ1F5bTVRaUhYazNZN3luaEZQWUhBTVE3NERJVExl?=
 =?utf-8?B?dmJwMlFGdmFpaGpXeDg0WFFYNEZXaW1KZmxLcStXWkFSeVhuVFFHdFB6cUlr?=
 =?utf-8?B?VkVtWlRoSjEzZmxycXozT0twM1NkL3BQUWl6dFJ6QVJoN1ZvK0FPU1c3Mmgr?=
 =?utf-8?B?bC9NenNWTW5wMEJzT3hja2xsbmh3d3FKM2xEV2dLL0NCM1I5QzRkS3ZNNFRM?=
 =?utf-8?B?VjNJY0tEOXBoTFk1ZjBxVkQwV0ppazc5aWQxOWYrVURTYzdHdVJ6dEQweHhD?=
 =?utf-8?B?eTl0UVUyOVAyOXNXRkNkalZhT0JIQlMzbUVNbGpSSGdGU0ZVYzd2SWdWR0NJ?=
 =?utf-8?B?ZTBZT1BIMVZFZmNTQytYOGtNay9ld05pdk15NnZ6UWZ5ODJUUkxuRnFBWkdm?=
 =?utf-8?B?eVlTM0t3VlZ2Q2t1N0pNMDZhcXM3NUxWcURobWJIMXV1cnd2REs4VlhuUlJ4?=
 =?utf-8?B?dEhhMytLOFRWZHFYbEFUVmdXYnBSem9wby96OXN5TlJvRy9nUUQ5QUJSVjB3?=
 =?utf-8?B?UWFtYzRIMnFWVTBpMnB4cGlLM1VFY3JKa280YVRFQ2F3RDE2WFhVU2VoV2Nw?=
 =?utf-8?B?T29PQ3dIclVZZG9rT1kwWUtiWDRwSmxYdzJtZG1BTGpoSk1GMjViRkc1dmcy?=
 =?utf-8?B?MlRVZHllRDh5ZWJCdXkxMjEwNld4YUZCVWlHeVdYZDZ2bWIyU1N6Y0phbHlH?=
 =?utf-8?B?ZlpmZCt0S1JUR0liaFJKNTZrbzdrdVFXeGtXcFRqbmFHTktTdHdkaWhnWEtk?=
 =?utf-8?B?VzF1b1Rrc1VjSFpLRVQ3VmFpZmlGcDlvRjY1Q2ozREhxeGw5Sm9yWDMzSURT?=
 =?utf-8?B?VFZNRndJT1VzOWpHVkY2Q3VHOUkvcEppTC9hMG5oa2FqSFZvcmZEWC9GeTZn?=
 =?utf-8?B?bFBGeXJneHVtSTU3KzRvZm1JQ3Y2NVg3OXZFWVFuL3NETmU5R29yNExIRkUx?=
 =?utf-8?B?UFROMkN6dmtVdXJMV1QzOHloTlJoSnIvRE1lWlU2OXVsdC9lN1Nwd2hJeWtX?=
 =?utf-8?B?Z2RxRW5iemJ0dHUwUDJza29DYXdIQU5MZlg2bWRVV2NRS1N2SHdYbld0RlNk?=
 =?utf-8?B?SUgvdnkvOUNKU1ZQb0NRVlFiZEN4UXJGUzNiL0dMVDd2KzVyTVZ2YnZpaVli?=
 =?utf-8?B?a0lJcUJvK0hmcXR1YjZvRVBPeUNadWMwQ0VvS1MvVUdodFZCTjJQTjYwemhT?=
 =?utf-8?B?U1pYWWRUMGlLRkdEeWE4WmFueSsyUlpVblBTcjlPTzBzblBQckN4Um52Nkdm?=
 =?utf-8?B?NzE3NFEvTEF1SVZEYzczeXNtdlhBbmVicjd3K0dFeXZ2ZzlDd0NGU0xybDhH?=
 =?utf-8?B?UGdrUWlpL2p0cGZYTmNVeGFlUHQ0SmplZHkvcTN4Vm9UaThUQWdlS1hITkZS?=
 =?utf-8?B?TzNtNitKSk5hZ1Zwb0h3ZVAwYnRHN3FvcUo0bVRmL1RjY0Z6Q1krSFJDTWVt?=
 =?utf-8?B?anV2WFd3Q21HY3lpMDhDelA1YlFPeGllQzVHdVVGdDlyQ0FhSnFLdnJ5bUJm?=
 =?utf-8?B?MTFxU1JjV3ArSU02WUxranlhbGw2Nzk3eStHTU1uTjJQMGQ3ZzUzdENLeTR0?=
 =?utf-8?B?Wmx2Y3Z2UzJXSmVkT2E0OVkvTlcxQUZBb1ZiM3o3UHRMSDV0WWNZVHg1V2ly?=
 =?utf-8?Q?TjMOzaoVncomODSMnJRmnW+Gr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77079926-fdf5-41a9-8829-08dd723e6f15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 23:31:03.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWWHFCKVRNMwG0uXcQYBAe8TL+oa99R4avAYqMwQYA46tVj4MdN7IK3Zf1yvxf2j5Qmm2TCtmOXg4kSc7Exolg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161


On 3/8/25 22:20, Shuai Xue wrote:
> Memory allocated for idxd is not freed if an error occurs during
> idxd_alloc(). To fix it, free the allocated memory in the reverse order
> of allocation before exiting the function in case of an error.
>
> Fixes: a8563a33a5e2 ("dmanegine: idxd: reformat opcap output to match bitmap_parse() input")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> ---
>   drivers/dma/idxd/init.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index cf5dc981be32..71d92c05c0c6 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -605,28 +605,34 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>   	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
>   	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
>   	if (idxd->id < 0)
> -		return NULL;
> +		goto err_ida;
>   
>   	idxd->opcap_bmap = bitmap_zalloc_node(IDXD_MAX_OPCAP_BITS, GFP_KERNEL, dev_to_node(dev));
> -	if (!idxd->opcap_bmap) {
> -		ida_free(&idxd_ida, idxd->id);
> -		return NULL;
> -	}
> +	if (!idxd->opcap_bmap)
> +		goto err_opcap;
>   
>   	device_initialize(conf_dev);
>   	conf_dev->parent = dev;
>   	conf_dev->bus = &dsa_bus_type;
>   	conf_dev->type = idxd->data->dev_type;
>   	rc = dev_set_name(conf_dev, "%s%d", idxd->data->name_prefix, idxd->id);
> -	if (rc < 0) {
> -		put_device(conf_dev);
> -		return NULL;
> -	}
> +	if (rc < 0)
> +		goto err_name;
>   
>   	spin_lock_init(&idxd->dev_lock);
>   	spin_lock_init(&idxd->cmd_lock);
>   
>   	return idxd;
> +
> +err_name:
> +	put_device(conf_dev);
> +	bitmap_free(idxd->opcap_bmap);
> +err_opcap:
> +	ida_free(&idxd_ida, idxd->id);
> +err_ida:
> +	kfree(idxd);
> +
> +	return NULL;
>   }
>   
>   static int idxd_enable_system_pasid(struct idxd_device *idxd)

