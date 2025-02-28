Return-Path: <dmaengine+bounces-4606-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC24FA49E07
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 16:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F00189A2D5
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE825DD1E;
	Fri, 28 Feb 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DRoPTadN"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57468270EC9;
	Fri, 28 Feb 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757786; cv=fail; b=ECd+qvbKwGtHJmQuMhLCo9/UEA+YRZWQkWcC23NQpNRKZy7N/VzvcEFzUghfjgp18pk+oIow2JYVs8k9/e99UOHiJVub8t+lRuj7Kh5NWrS2jHLoJpm11lhdJuecK/M+AjHxxUm7v64H096p1LnO/hEeFRg/A8yowdtGjtkjiuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757786; c=relaxed/simple;
	bh=3aRgNNJsezhCje4/XntjB/+k1oDRo4sN3XGlcAdx9uA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7v0+pTcq03oxcpzRWAerYa7JVu3UOmKnoSed4HavZyjIGmExXXWkdb7aEVcCldRVop7fOtwmhyngVbRTQDBqTrdXqMJ11yCznWZSoz8Z96CT8Z/S+sm9mjIRCdYtZ9gPYHzpL8i+Up4vuLQIdgcvN7cwD3p1ZWwGN6MH/I7468=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DRoPTadN; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWR+AOxMBEKf2HfuD/OpS/Fh55z/uk9Jh4P5i7pyQ7WH0BWXqYoLx3NOpRmm96K6pGOha97BmN8ocDLWEL9Hz7yOHoLt8Noj8O5F92S9sVBc3/HgW8Q+b/4HPynHeHFMBgqJVU6EYKDKY3MTY+OG2jMqzMOlkul1JMEat1Q43UbdPCaFWt5xyZVzpRfFJAGkwqVjbgPmihpCzifnbo6UV/VgQUw7LiG7qER+jLRd5TTi6fTZXzbwoiKZmbWnDwoJFNznRdoZnGz4Uamt5d30d+1hh6hzT2588VL5J4xPRwghfRW+29VlHNmYi3WtXwsYKZVN/wN3ZmvM8ygCruX2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6eCanl3AfKrogtlufIGdOlpTQnTFDfpT4F8DamMYhI=;
 b=kFUUJAmvf+dG+CAcjEhFX/M+PB2FdbxLo0QZUGtLCfKqWMhNbTZ0ehWTZ3dmVPoemqXLFDixcqYum0uv+cBpmw3kLOpCRdNDrAx5Y6VEPzfUdulfpJqMQyoehtSTKNarl53IG+6JS9dfMNAnB4xMLlwTsBDeehwhl6KIPQz3J8TOtwZQDI/xOtjep00BGrshxAjbCXS1JmCIX6Kf9VwkgwU8ka0DrYA+Gyv+9SaNSPvHBTaP+0Oa1shiSBKDtq+Qivpvm42fhdL94cX0VbzRQ/z9D1mKbiP562m1dPcn07uz/ee1n5r73gaa5bDZXeL+qsDxH/MQPcIY9HTw9nh/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6eCanl3AfKrogtlufIGdOlpTQnTFDfpT4F8DamMYhI=;
 b=DRoPTadNcg7OEkDfd/jnxrf3XiL8bpg8mMNQ2EuFKkyUXjOZY7+JoVRoYBzO5ZRFTrgVRf4YElrljpAErp6P/k528YM2bvoqfgMPV70W4R81GCjOjB5E/y6L2+XLiDFO+roblb92ykKROmmkn4wTmV8lDHwEtl8//QuHCWZw9Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:49:39 +0000
Received: from BN9PR12MB5033.namprd12.prod.outlook.com
 ([fe80::deef:fa00:d7d4:5069]) by BN9PR12MB5033.namprd12.prod.outlook.com
 ([fe80::deef:fa00:d7d4:5069%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:49:39 +0000
Message-ID: <38868fe1-9194-4346-b7fd-b8d56e410f1b@amd.com>
Date: Fri, 28 Feb 2025 21:19:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel module ae4dma caused my system to not boot
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
References: <45ddbb23-bf92-4d46-84b6-6c80886d4278@kernel.org>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <45ddbb23-bf92-4d46-84b6-6c80886d4278@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To BN9PR12MB5033.namprd12.prod.outlook.com
 (2603:10b6:408:132::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5033:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f495ec-a7e9-4098-5a88-08dd580f825b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWJiNnN0NkRtU1J4dU9tNXcrT1lGSE1jeXhaSklQWlBiSUlVdXpyaTRBZy9J?=
 =?utf-8?B?WEMvdDVCdlJ6Z1FsaE40cjN2Yk10M3ZzdWw5blZjU3lkb1Fma3E2N3ZXNWFE?=
 =?utf-8?B?RFViMkhnL3p1SmRlK3IyVEZtZjliU3VrdnYyU2ZmZndMUzJFZUZMdWVpbmxh?=
 =?utf-8?B?bSszcE9CVkdJaXM2MVNOZGNYOXRXcWM2aFZkMU81TFYrZkVhdVM3YVB2N1la?=
 =?utf-8?B?R0hUUWtXZEMvQmt0bWtsMkFUUzUvVnV6S3Q4bmgvcEQrN0hkK1F4cUZmMzNz?=
 =?utf-8?B?dnhzSzNBbmx5Y3FRK1JQeWlTSjV5UTB0VCtkNzdnd01uOUdHTXBkbStpZ2ZM?=
 =?utf-8?B?NWdwcnJyUjEweWNzaHFTTXdQN1NTWExGKzRFa3J3Ulp1WXZJWnZUSHhqSExW?=
 =?utf-8?B?UUUyWTFVTU04VEllMEhOYUM0OVNBemRHUHloMzN1WXYvOEQxbHNxd2ZvWFlU?=
 =?utf-8?B?ZG9BSHZCdHpVZXBXWVJEQXVaNGN2M3lwZ3BIZ210b3cxbVZBZmpMNHBaMDZt?=
 =?utf-8?B?QzVwTWtQdXBKbVlyM3VtQytIUGpOSHhtN3djK1ZRVld3dXErOXd4a2hCSG9B?=
 =?utf-8?B?L3FnQWZZL0diNjZYSHpuRU05Ny8zaSs4Qm5lTTVBVlRodDUyendTS0xSWm9u?=
 =?utf-8?B?Q01EZWxwMTB1MmN4bUVSOWxTbUxKNDQvRTZDNFY1RXUrTjczSmMxWEJJc0NL?=
 =?utf-8?B?VWI3b0EvVnNRK2FrSWc5UVhna3YySTh5Zi9aRllrSzF1Y3pJMDA3OSsvU3Vw?=
 =?utf-8?B?ZWQ1ZzA2aGk3OHdBeTJWc3l6d2p1YzRGdnlocTEzYzlENFRHdVdKWmNweUJR?=
 =?utf-8?B?b2J2K2gzTDVhVnJwRXFjTTVCWUczZFI3dWc3RVplMG9RSzMzQ0ora0ZEemRn?=
 =?utf-8?B?VmRzc0dTK09VbU4vWE5aWGliS2tsUFhmRm84MTR0TFRESXhKOURSUE1NQW9y?=
 =?utf-8?B?WE9UNWNnT1Z2THR1aUc5UzNUTjVNc29YZXRnSmtYNXlYd0loaXZxL0h4bjZv?=
 =?utf-8?B?Rm5jQm56clpLVGFGTDA5eWJpVE5HV1NvZ3JaL1lJbTdaNG1EbVRwVlNzTXBy?=
 =?utf-8?B?WlEzYkJpQ2xScGg0aElzL284YkVpSjM1TGtpZkdWMTFmTHhpTERpamh3a3Nv?=
 =?utf-8?B?dDNKKzZJbU1aZ0hab3Z2UjMyckMyT2xtMGZIWk9xT0FBY0Z1aHB2bFJ6bEtx?=
 =?utf-8?B?SzNSaFlVYXk0OGhVbUwrUjg2WHNvbjZ1RVU5K0NZc2tWeXlGVkI2cWwzL2N1?=
 =?utf-8?B?MEF0bU1Pc2dsb2w0TXhFRFhlRE1xTGt2SEh6Ulk0YU1paEVRbXI1TCszWlpN?=
 =?utf-8?B?bHhUZTNIYThZdW5TcnBXRVdMcHZjQnd0bDF3dUdFSTNTQXpKTlEzZlhKRmdT?=
 =?utf-8?B?WGMrVHEreU5VYVBKbTBkamUvNlZxMnpKZ2VKYzhJOUZGWXZVSXJrc2NlNFhI?=
 =?utf-8?B?REhycXpCVlJrSGl0amdTWWJuZUZTYlBFblN5MVNLcE8rWTFnUzE0N01PTjQy?=
 =?utf-8?B?Um0vYXdtbEl2VnVOdktlSUlyOXZycmEwVURLd1Q2WXJ4LytnOEQ2MitUeGI2?=
 =?utf-8?B?cURLWnQ4ZGt4cCtRU1BFOFNNeDlBYlN3SFliTkdFN3NXZXlIWUN3U1VuM1Z3?=
 =?utf-8?B?TldZdnhnZlAycllXL3U2bE9md3FnUmd4bUp3dGtCWWptV1Q3K29hMUNZY1h1?=
 =?utf-8?B?WGxvbWZLMDNRQkFRVjBENUlFZEtTV3pvUm82RXRYb0gzRkdQMEVWdTRiakJ0?=
 =?utf-8?B?L0RPMkVwci9QaTc2ajJLMXVWZTZxTG55eGJMdkdXSEcrdVFVS0pKOW4xWWx1?=
 =?utf-8?B?c2t4M2RCTlBvMEY1UmV4Y0wwcXd1VzJJa0JiMkJPRVcxVmxNRHdRZ1hqalMy?=
 =?utf-8?Q?TBJ25y2aHdwfs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVVuRVppODlFb1VZaTIvNFNUTms5VmFISkdNcExuMDFLck9KLys5ZVExNnB3?=
 =?utf-8?B?b09MMkErS2pwQytnVmxRNkhIbGNzYVdncVNLQ3paK3lMcHRBMHUwUXc5MG94?=
 =?utf-8?B?UjkrdFhLUDE3OUljSVNJN3V6Q0dJcFd0ZHorNHVlV2NSREpLak0wRktrOWxi?=
 =?utf-8?B?RjhOblZzUkQzSVE0dFFmTzlsSjdPZ0tsU25qMUdmZ0ZaR0hsbTF0UGFZSDdH?=
 =?utf-8?B?SVVod3lZcFFadWhmZERtQjFtVW9yMm9PNEtheVpnamhBOTlZT2xPaHRxNko4?=
 =?utf-8?B?Ti9sWC9hTVE5OFdncWhQT3RzNmE2N1dFS0NreFJmQVp3aUhhcWJmYWExMW5P?=
 =?utf-8?B?VzlxK3kxclhHOTRjR1EyK3Y1MmFBclNxUmlOVVhhTG5WZmNxL1dzMWE1djdm?=
 =?utf-8?B?c0tZdUt1OWZZRUpaeitTODVkamZ6K1VsczZpWmFGUGRjdkpGaSt1OWJaQ1hZ?=
 =?utf-8?B?b0xvSnloMDFxWnpGUlpnR0RKanpzci9HejE4MWRqRGc4ZStYZXcrZjJySEZu?=
 =?utf-8?B?NC9iY0hPcStiUzFCT1pDbEZHUDRpYXZnMitpUmJ1OW51a1RaMWl4dHppdldT?=
 =?utf-8?B?Q1VtSmwrTXpvTmEzM3M2cUpzcllacVU5alptdWxZbEk0SUt0V0NSeGRRdU4x?=
 =?utf-8?B?aFNwQUk4V1VKMlE4SHFpQStNcDRqbFV6dG9KRTBreEhvSkJXYitjdU5VTkx1?=
 =?utf-8?B?ajBSdEdMOXdlZFMrTFZDSExYVzZRZG1zUEtkTTU0Y0VlZm1MS0JXTXZBeHQv?=
 =?utf-8?B?ODl6OStzZW1MZW0rcEp2QWpLU1JDWEhDWTdYUzJWQjNOUldKZFdwbldBS1ly?=
 =?utf-8?B?SjNtS1pCbGJzdVNHdS9YbkVZZHNsY0lUc3NtSzZrN1hQcnh5aThjNTIwbTJI?=
 =?utf-8?B?WkhhdU5NMSsvSXk5Qjl3VWhxNUMzQTNSeEhOcTIwN292NGNzMzNNUWRFM3d5?=
 =?utf-8?B?NnRkaWUyWGFRREdjRWZsbDdORVg3V0JnOEh4aDZmZXN5YXBxdGkweFBwOUg2?=
 =?utf-8?B?SmZ1ZlVmTGRXRHpVQWZZUXhqT01aQkdwNlV6UmtEL0ZpNE9NZXZvbEx5L2NQ?=
 =?utf-8?B?d2ZvOEpMWXVNK01yNHNXZm1ueEVYZ0YxV0VVQnZrZnc0ajZLeUtBdlZqSTZs?=
 =?utf-8?B?U1JJd1dkKy9BN29LYWlURFFCNHJleWRDbTNxUGdwUG1pcGR3YmJBUytJeG1L?=
 =?utf-8?B?SXVBTGp5UDNJVWpDbmNaaVE0cXpyRk9UOG1wY2lBSmhyWlBlajBZSU1JeDNS?=
 =?utf-8?B?ZWNoMUdYWkJITGtXSVV6L3RKcDB4cmJRV1ZFWWlEbW9PTGx4N2M5anM4NHZH?=
 =?utf-8?B?Tkg5cG5QTERZT3NOZi9yM1ZNTHlPZ3pkZnE0bUcvdXh5ZDl2bzQzRHkyNHV1?=
 =?utf-8?B?MTl2MmRETVc4RjBmMS9Uc3h4dTVxMDVzSTVmSFVJR01rOW9TWEN4U255b0c1?=
 =?utf-8?B?VFRSblVNTmNRVGRHOFpYSzVidjE3TndFUTYzZTBCLzBZaGlmcVNGWFFzYktJ?=
 =?utf-8?B?MXpVS1JNMWNxcXB5bjlLYWV6QkN1U01Id2o5aytEdU13S3BTdTVnWmlOR2ZV?=
 =?utf-8?B?NXhiYzRWVnNNc2tJZVl3SUUyMmI2TDdYblA2Z216SThveFc3OXlaUXRFSGJ4?=
 =?utf-8?B?TXloaGJUQ2dFUUtWanJicTdkbUdDdnEyRE5mR0ptLzdMTkd0bFB2RHUvNmVr?=
 =?utf-8?B?c2ZXaEx4SU9YVnEvSlZjeW5IQVEzeWJlNkhvYlhKSXUwSTRjdW52Nkh6YkJC?=
 =?utf-8?B?QjNJQk53NDY5aVl4QjVvZWxheFN4RXVzRWI2K3FqZDR3R0xSRTY0ckZpeU9U?=
 =?utf-8?B?NjczdUp5SExNT1p5SVZidjMrdmJnZjZHWUdyVnlEMlkrODh1M2JUZ1lRNVFG?=
 =?utf-8?B?UC8zWmZodUZVbGlGUE9nSmJtVTAreG1FMGdobmRDUzM3cmpvUzU2UFpZV1cz?=
 =?utf-8?B?d0FISnFYb3hRRzIrdW5iY2ZYMzNKL1ZaSlhxRkh3Ky85emQ3NWptcmxKeWJ2?=
 =?utf-8?B?NGcwcGtMNTRsdUhCdkNZWmYyeU9pdUNYOHVKOGZxd2pEb2l4ZGc3bHVLZmt2?=
 =?utf-8?B?WWRWWUVSVHdOVUZwazZ1OVNUMGVoTEhqK0g1bFFmeWVocXpqYyt4ZXNpYnFl?=
 =?utf-8?Q?fGutN/4RVVbq0r36dowIGFdJf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f495ec-a7e9-4098-5a88-08dd580f825b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5033.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:49:39.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIdWp8X9VWgCjXTmdG9XEi+44kEfVN70rtSmNJzeUAOXtUNZ5AFC6bWQB3VhLs9f9MOWfeVH+olFc0sNKHb23g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

Hi Jesper,

Could you please use below patch series which fixes below issue.

https://lore.kernel.org/all/20250203162511.911946-1-Basavaraj.Natikar@amd.com/


Thanks,
--
Basavaraj


On 2/28/2025 8:05 PM, Jesper Dangaard Brouer wrote:
> Hi Basavaraj,
>
> When rebasing my devel kernel to v6.14 (6.14.0-rc3-traits-009-bench+),
> my AMD testlab system didn't boot due to the kernel module: ae4dma.
> I disabled the kernel module via CONFIG_AMD_AE4DMA so I can boot my
> system again.
>
> CPU: AMD EPYC 9684X 96-Core Processor
>
> As a help for you to debug here are the kernel console messages that
> seems relevant:
>
> [   13.853689] ae4dma 0000:85:00.1: enabling device (0000 -> 0002)
> [   13.861287] genirq: Flags mismatch irq 0. 00000000 (0000:85:00.1) 
> vs. 00215a00 (timer)
> [   13.870123] CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 
> 6.14.0-rc3-traits-009-bench+ #32
> [   13.870125] Hardware name: Lenovo HR355M-V3-G12/HR355M_V3_HPM, BIOS 
> HR355M_V3.G.026 10/13/2023
> [   13.870126] Workqueue: events work_for_cpu_fn
> [   13.870132] Call Trace:
> [   13.870134]  <TASK>
> [   13.870136]  dump_stack_lvl+0x64/0x80
> [   13.870141]  __setup_irq+0x522/0x6d0
> [   13.870145]  request_threaded_irq+0x10d/0x180
> [   13.870146]  devm_request_threaded_irq+0x71/0xd0
> [   13.870149]  ? __pfx_ae4_core_irq_handler+0x10/0x10 [ae4dma]
> [   13.870153]  ae4_core_init+0x8f/0x2f0 [ae4dma]
> [   13.870155]  ae4_pci_probe+0x1f3/0x270 [ae4dma]
> [   13.870156]  local_pci_probe+0x42/0xa0
> [   13.870161]  work_for_cpu_fn+0x17/0x30
> [   13.870162]  process_one_work+0x181/0x3a0
> [   13.870165]  worker_thread+0x251/0x360
> [   13.870166]  ? __pfx_worker_thread+0x10/0x10
> [   13.870168]  kthread+0xee/0x240
> [   13.870170]  ? finish_task_switch.isra.0+0x88/0x2d0
> [   13.870173]  ? __pfx_kthread+0x10/0x10
> [   13.870174]  ret_from_fork+0x31/0x50
> [   13.870177]  ? __pfx_kthread+0x10/0x10
> [   13.870178]  ret_from_fork_asm+0x1a/0x30
> [   13.870182]  </TASK>
> [   14.010326] ccp 0000:03:00.5: SEV firmware updated from 1.55.32 to 
> 1.55.37
> [   16.565527] ae4dma 0000:85:00.1: probe with driver ae4dma failed 
> with error -16
> [   16.574958] ae4dma 0000:c1:00.1: enabling device (0000 -> 0002)
>
> Let me know if you need other data,
> --Jesper
>


