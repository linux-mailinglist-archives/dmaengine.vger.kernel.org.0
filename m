Return-Path: <dmaengine+bounces-9852-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLO4Jzs2zmmAmAYAu9opvQ
	(envelope-from <dmaengine+bounces-9852-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:26:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D4F386E23
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 678B1301AD26
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191438D6B8;
	Thu,  2 Apr 2026 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="so65o7sW"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9678386C37;
	Thu,  2 Apr 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121797; cv=fail; b=YVaW2cddNuRDYlokiPqeKCiuZgW10HpDAkNNhihmMY7WWN3+1AowwNWAiqyiMjSIKbFBLxSKOJuy5zJmyAx70zeOoyBpzSADMVcVhiwEicVetsoJHCvDab30y4zlxNDB6rTiQ/t3W9p+rM5BuP1EjRNrffPlNHVUwGu/sO7GAsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121797; c=relaxed/simple;
	bh=Uk8ErCvwjpNNAs7HdIUVSxiBpZ0gPmatDdL/8KMZjU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LRyOfy4qwkyVAtsKfiUyMgmb6pbds59k8wFP/4E7lQELkEw3WnE2JA8Q13EqnsUol+XDMnrTbzwLtzZCJkE+QkKaKJV1/1h0fkxatiigpRrx9LHe56L6Sd/n6nCIjM6oKyhzHZ4LiFQ+SAtxMXuxsrZc8O2yU0znof1et0U6f8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=so65o7sW; arc=fail smtp.client-ip=52.101.48.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHXHCAToCHScGUdrLFAUOz8CmYxv4VKLGslde3Bm8HlLot7xwUH8gopWJi2NfQdh1E1tkhlI0Ztfp+fsc2SGdW2nTHDSiI/SLU6dXtkLwiPIFjE1il+hn3tEzaQc0DIvGjwmNRp1DtP49mrKwE8pXm7zNd2u3UqF/HxUiaP5o4ug7FMfjkPEDlF+YcSLBEtx9T1E7NEHzjyUylhgzB9TsIRDXNriYoRLyudqG1VAbmoqWaYESIYv9yk2jsBzVojvnWlXv3eHvVGNKlFp4AJk1X60Bdr9I0a0lf7z8o5m+7C7vWC/gP65Zy/L7U+U02bfhlCIBf4SlO/jzToXz/aqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0POys2zK0H33v1oHmtzwEYCkh3BQlc8WGSi0apoU8U=;
 b=j84VNg0TIBqhbMDRtEctUKxUG+kNd/TK54YaqU+8RJ/FWWSo7T9GyfwPGLJxpIFg06I4sTGyXh4Bv/lh15+GnkYCKVmYpqyo0k3cm/oY//xexhdT4if8rVxvhKFrbRw8oGoQh2D5cZFHvvOqlqQcDvh/AXsGBsnSoRMp8y3RYyaJLaxO8AJvyF0G4HViCLA+vTNCZwluveW64xK0q3sqbIsh9Nxi+6SDb8lApRIsDQd6XHzbwODaKWgiAn8V3VYoI8WBhGtPM8GBm1Dh2RqC2KL2PlSw04w5lx3QVUxW6MSLvvIxZoP8a8S6B0/g7H5rt7cEGZJvKBx1Vy4RY7w1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0POys2zK0H33v1oHmtzwEYCkh3BQlc8WGSi0apoU8U=;
 b=so65o7sWm7FP3+AHsHXHSOoOnBKlVOLReY/VYFUe2OsjLEjj5yvHROl7YCmMHHlg7p+Lyp1Gpy57dAr54u9Nt9SXPNP514PBGwxK+QrdPXfZFBVP2r+7+u8ttklfSfU4s5UH0oI9oNkrK1CLajSQg+QT9RdWdtewrzhOdpWyRM+R4a8seKs+t7CfXyDa8A+qIlRqLPzag64cD5ekqnQ4A0Z723Jmorzv589xeUfOuIMvrzTZzJDhgIZy5XhQ8/EGWjJss2lH/yPtdOn63GudcnEkBOEqvG4TNwKzD1P9dG4hvdwvpAwgETElN8qppTJolMSH56FSfeuUeFNLaayOtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 09:23:06 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:23:06 +0000
Message-ID: <6ced83ba-b35e-479e-95e9-67a46a540ac9@nvidia.com>
Date: Thu, 2 Apr 2026 10:23:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmaengine: tegra210-adma: Add error logging on failure
 paths
To: Sheetal <sheetal@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Frank Li <Frank.Li@kernel.org>,
 Mohan Kumar <mkumard@nvidia.com>, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323083858.2777285-1-sheetal@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260323083858.2777285-1-sheetal@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::12) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b73dcc-318e-458f-84ba-08de90997269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fHEkNsCU4LR3WF28pgOghbSNVp4dVZm4JNu6OwEHq74v6EioWfbfWYJ+zRcriiKRaM4uBrTzDvI/Zv88l0bpAVm/C8JKq6FOKTrisTJpZl2hJ3CGAVDjT5kONS38ImOz+e0K5MjInDrynMB6BM/XNmnsvfdIdsX8EGuu4saCtVq1fFRABS3P+r1CLFuk9cBmMGNKCFtf7ZBGahPdLLm/oDZMw2MduKcqgGbbbhYdtpwBsX3VwiOwvOxMpIZpBlOkqjssQYmrYokzrJVQnuHrf9KzTvmxpRQ8NRxRRF9mmQ5YOkYs5NHpQPq+owY9xfmXERBhXTGMkSH6wPnQMmBqIB+ZE7GkTMeemvpihgEc1mKIovCJylKUpzLRgDwntcTiuWUlvq1PAoEeThdBmXmlMeS+DNYXPTTmgcoOv2z6SUTJLLkle2geMl8MSZU+PjNhJEt3aAS4VpcmrDgF4KwlHrfazPKgX0dTOU1AFWunmDfB9rQGlNMl8uYaLzUCe5RS0HxZnpHOLUaF4xUkSilhSXtkk5Jimlqxk1s3j8G/MtsUJViwZM2dQLwkd/pSavV7vlnkS35D2uN7ksj6l55Z3WDBRCXM5HPXVJAL9bILifrjIBKB1MAUrRCaAzxTtKZqPpB5pDbZyg/JCF7XEWeBiBFZcHApyyCGNR/h8i8RgPVodiILURYYbJ0wUdNkNBOo6SAnE2CJhsa1gK6nrx2CyrXW/X2UHglxPDy8WKVoOuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnlpaWtSeE9SQVRpdTVVVmM4ZmhzbkpNNzVaQ1Y4alpPM0tGY0NuVUZYZ1hC?=
 =?utf-8?B?dVk2MkVDVm9BZTFpWnU5WkNvYWdLWnRGRG90QVNhSWFUU3dXQ0RLU2YvY1hD?=
 =?utf-8?B?ZXFNaHV1c2JUTUYzNHh0NXY3U0dGVVlWUW9Ua3ZWRWVJVm80MnFPaHI5bERL?=
 =?utf-8?B?TzZnODZHYmRNbG9UbFFtZVVmZmgrcEdGSjhNRjFXVmkrWS9laXJuQVQ0UWdT?=
 =?utf-8?B?R0U0MWpSVk1Ob1RZbURKc2ZabUx6THdMMmpuZEt5c0RXL3kyaEFYbE9YNzRK?=
 =?utf-8?B?SS9KNjFiWkxvNVdnaml4SEttaXVueEtPeDhWNmhNMlVyL04zMWlTUHhQT29S?=
 =?utf-8?B?T3p0cEVqSkFHd1NNc29JaGZKOGk3WU1sV3d0c3I3SlBDV0ZaUUE3cFVmUkI0?=
 =?utf-8?B?RFZRU3RQVE1wZHlpU2lJZjVMYjRNeDMwb0UwUXkrVkNKeDMvNEN1ZCtFVlAy?=
 =?utf-8?B?WTluekRiMG1qdzRBS2RrUUp0VFFGVGlxVStJNE9TN0JtVlhXNWtsMkt3cW9a?=
 =?utf-8?B?SEpyOTBtMzZZTGVjeTB0U0VxNSsvRTc5Z0FHb0h0RmU2dWZybm1Rb0xRRVlu?=
 =?utf-8?B?MGFuYTY1cXFuaDI4SDRkaDJrd3AzSTJaem01NHp1STVIbjlnN25IcWc0c1FC?=
 =?utf-8?B?M0E0WERUVlVJS3lSVG1vNFp2T20wS0hJL0JLeGVPclpPS1l5UDU3bElpcjBF?=
 =?utf-8?B?Vm1xVUtjaURjaGNoMUNPaDdVZGJUaXY1UGVqRVlZRDcza3ZuZzYyRTdyeDNs?=
 =?utf-8?B?eGlQMjB6WDl4NFFkeUpOTUVibjdSYzZENmttR0NyQVRBVE5aRXZFbGR0cmR6?=
 =?utf-8?B?VThpNkM3M1A1SWR0WitSZDNZN0IvWkJ3TmRST1ZzM1NockIxdUxJOFFUZmZy?=
 =?utf-8?B?VURRSUpyRWhMU0NkY3ZuSG96bGdWaGN6MDB4cXkvNHNKNVZEMXM2YWdVako2?=
 =?utf-8?B?dWZXeWc3cFVFZzJLMGxYZWs5ckRwMm9xU2tjVUZ6Mjlib0RUSGxMWWJZYXNT?=
 =?utf-8?B?WTYwNG9TVy9XZHRTb2k0bEs3WnRiUTUrR3o0L2VHTjJKaEJ3QUFOZHNCQ1dZ?=
 =?utf-8?B?NXRDU1JidlN0ekxDV2RwOE5wdjdEd1VCQlg4N1l4alVQeTFBdTB4aXAyV0N0?=
 =?utf-8?B?STJkVzAyc1VsV3UvcmxCUlNjU3Z5UWRPcUliSlNmYXZwdmxwZExtc0J4VHI1?=
 =?utf-8?B?YjNXMTlVMWJGcDBDYmUzSXNVQjM2eWVKa01SVUt6bG45YlY4Ni9uZnVGQWpL?=
 =?utf-8?B?NEU3djhzN08xMmI5MkVrK0YwRkNNUkFYMHo0MVMyR1NzekgwQXlQa0JrYjN0?=
 =?utf-8?B?d05Fa2UwVEJnRkg5SDU0dGEybjRpNHZRMlFubitwRUl1Qk9mWmh2N0hBVlNk?=
 =?utf-8?B?TksrN1hmcGhmRkhCRWsxYjk2T0dPZkZDSCtMVlk5YnFtNGwzWS9udkRRdzkz?=
 =?utf-8?B?ODZQVm14a2c0bktlam15MFQ5Zkt4NUoyNUxKdUlEVmt2VzZpSy93ZEFTRDJX?=
 =?utf-8?B?blIrOFRCaks4RDl0MmNabXhZMzFHc3EySVJ4T0tTb1QvTzgzRk9IdnMzQlhY?=
 =?utf-8?B?dXJWbUxEQm1DOU9vOXhZRDROY2J0UVRKbVlmOXRjbm9SUlN1QUJZWTVRcWpR?=
 =?utf-8?B?N3IwTllNTXZXWTNnU3kzeDFGaEw4a2tKSlBGRW5XbGRlcW9hcnhMbWY5R0Fi?=
 =?utf-8?B?cEVLb3JMakxLL3h2Y2RlNkhaa2hjc2w5TGlzaEhVcGZvYjJHR0dNWEU4YjYz?=
 =?utf-8?B?SENQcDdhbEJ0ZDczNjRBaDRYN0VXQnY5T1d5NWdwOHdkUGxtN0VhWjAvRVUr?=
 =?utf-8?B?RDJLazhaQWZiZkpLTHpxWUxCVXpYUGsvT0FIeVRqRlU4L3BxLys2NEZkZllQ?=
 =?utf-8?B?TU5HUlZETjNGRnY4MUxyeHhKN1hCNjNQRXdGSk00U29XQTU2ZVhkUjRZVktU?=
 =?utf-8?B?TWN6eWxLM3RnenhZcWl4Rlk2bDladlptaUZBd2hYckFVNDR5QVVOeTVUc1py?=
 =?utf-8?B?ZENvbHg4VDlNaGxVa1RCOFRiZm1pa3R4Ri9KTTZOblFnaytlR3pkTTZzZEdy?=
 =?utf-8?B?WlFZZjBYZjBQSVB1R1V1WHY1RkVYUWFUc1BRcFZMaXZ3MFVNaUtneWZ2VXN3?=
 =?utf-8?B?YVMvcXFqdXNxYmpQYlh5Z2RhajhMSmY2aTNmcFZSYnFtU3dMa2kvM3BndGpX?=
 =?utf-8?B?dTNaNDlEVDhnN0E0Zk8wVFc2eG95d2hiUlo4OXJFemNXeXBhalIzKzY3OVJx?=
 =?utf-8?B?TWw3cnZKWkp0SkFqa0hlTlp4eUJBYlFvRkJXR2IxL2dOTkkzOUpxb2x0ZmY1?=
 =?utf-8?B?ZkR2TEVvRUpYKzZTTDUvc2V4ZGRvd1lBNDg3WEwvQmdoWUtBdVVoRk1CblNj?=
 =?utf-8?Q?0o53f0/2ZkFsURgJKxT7caGzenUJNxrsm9nfexk8Z6/Bu?=
X-MS-Exchange-AntiSpam-MessageData-1: hmjsifeW/X0Lfw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b73dcc-318e-458f-84ba-08de90997269
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:23:05.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ld/MLGBTNMjn+3BewcskkBlW5QCwhUbvDfHqbwleEehC3MuPhIDROlzJiUI9rUnLaeDpy5zUcTLCeyLBgBfCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-9852-lists,dmaengine=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Queue-Id: 10D4F386E23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 23/03/2026 08:38, Sheetal wrote:
> Add dev_err/dev_err_probe logging across failure paths to improve
> debuggability of DMA errors during runtime and probe.
> 
> Signed-off-by: Sheetal <sheetal@nvidia.com>
> ---
> Changes in v3:
> - Cast page_no to (unsigned long long) for %llu to fix -Wformat
>    warning on 32-bit builds where resource_size_t is unsigned int
> - Remove redundant dev_err for devm_ioremap_resource failures since
>    the API already logs errors internally.
> 
> Changes in v2:
> - Fix format specifier for size_t: use %zu instead of %u for
>    desc->num_periods to resolve -Wformat warning with W=1
> 
>   drivers/dma/tegra210-adma.c | 37 +++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 14e0c408ed1e..a50cd52fec18 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -335,8 +335,16 @@ static int tegra_adma_request_alloc(struct tegra_adma_chan *tdc,
>   	struct tegra_adma *tdma = tdc->tdma;
>   	unsigned int sreq_index = tdc->sreq_index;
>   
> -	if (tdc->sreq_reserved)
> -		return tdc->sreq_dir == direction ? 0 : -EINVAL;
> +	if (tdc->sreq_reserved) {
> +		if (tdc->sreq_dir != direction) {
> +			dev_err(tdma->dev,
> +				"DMA request direction mismatch: reserved=%s, requested=%s\n",
> +				dmaengine_get_direction_text(tdc->sreq_dir),
> +				dmaengine_get_direction_text(direction));
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
>   
>   	if (sreq_index > tdma->cdata->ch_req_max) {
>   		dev_err(tdma->dev, "invalid DMA request\n");
> @@ -665,8 +673,11 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>   	const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
>   	unsigned int burst_size, adma_dir, fifo_size_shift;
>   
> -	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS)
> +	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS) {
> +		dev_err(tdc2dev(tdc), "invalid DMA periods %zu (max %u)\n",
> +			desc->num_periods, ADMA_CH_CONFIG_MAX_BUFS);
>   		return -EINVAL;
> +	}
>   
>   	switch (direction) {
>   	case DMA_MEM_TO_DEV:
> @@ -1047,38 +1058,45 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   	res_page = platform_get_resource_byname(pdev, IORESOURCE_MEM, "page");
>   	if (res_page) {
>   		tdma->ch_base_addr = devm_ioremap_resource(&pdev->dev, res_page);
>   		if (IS_ERR(tdma->ch_base_addr))
>   			return PTR_ERR(tdma->ch_base_addr);
>   
>   		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>   		if (res_base) {
>   			resource_size_t page_offset, page_no;
>   			unsigned int ch_base_offset;
>   
> -			if (res_page->start < res_base->start)
> +			if (res_page->start < res_base->start) {
> +				dev_err(&pdev->dev, "invalid page/global resource order\n");
>   				return -EINVAL;
> +			}
> +
>   			page_offset = res_page->start - res_base->start;
>   			ch_base_offset = cdata->ch_base_offset;
>   			if (!ch_base_offset)
>   				return -EINVAL;
>   
>   			page_no = div_u64(page_offset, ch_base_offset);
> -			if (!page_no || page_no > INT_MAX)
> +			if (!page_no || page_no > INT_MAX) {
> +				dev_err(&pdev->dev, "invalid page number %llu\n",
> +					(unsigned long long)page_no);
>   				return -EINVAL;
> +			}
>   
>   			tdma->ch_page_no = page_no - 1;
>   			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>   			if (IS_ERR(tdma->base_addr))
>   				return PTR_ERR(tdma->base_addr);
>   		}
>   	} else {
>   		/* If no 'page' property found, then reg DT binding would be legacy */
>   		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   		if (res_base) {
>   			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>   			if (IS_ERR(tdma->base_addr))
>   				return PTR_ERR(tdma->base_addr);
>   		} else {
> +			dev_err(&pdev->dev, "failed to get memory resource\n");
>   			return -ENODEV;
>   		}
>   
> @@ -1130,6 +1147,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   		tdc->irq = of_irq_get(pdev->dev.of_node, i);
>   		if (tdc->irq <= 0) {
>   			ret = tdc->irq ?: -ENXIO;
> +			dev_err_probe(&pdev->dev, ret, "failed to get IRQ for channel %d\n", i);
>   			goto irq_dispose;
>   		}
>   
> @@ -1141,12 +1159,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   	pm_runtime_enable(&pdev->dev);
>   
>   	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err_probe(&pdev->dev, ret, "runtime PM resume failed\n");
>   		goto rpm_disable;
> +	}
>   
>   	ret = tegra_adma_init(tdma);
> -	if (ret)
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize ADMA: %d\n", ret);
>   		goto rpm_put;
> +	}
>   
>   	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>   	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


