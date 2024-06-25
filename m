Return-Path: <dmaengine+bounces-2532-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477F9161C6
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2024 10:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BB91C236FA
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2024 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C63F148838;
	Tue, 25 Jun 2024 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oxe2tfBI"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661513A252;
	Tue, 25 Jun 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305887; cv=fail; b=EXQiTtn8JsoEL17xhQ/17nXZ4KKrHUEK8YCwIGjhJqgeFL+arWj0zqOXRxfZ1xYpmR0NXgp/wvFmZzCd24DdArlop1M4HxI8tX+RiY77ogZTPJwsS+ooEdwkrAh3LHj38Q8BL6HZ5I1Brrx1t8jOlD/8D6u42BD66yXEZsvAFsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305887; c=relaxed/simple;
	bh=dbxLWqjccj+ge9p+D7ihm4ctAcbQSF4PFVXXbe4eNXE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PW5Olgw9oVnBAw7iP9ZW4PsbZMPlUZJ2fMtLXhn61TkdWNNEbW+o0jz3vz6kVDnDsLRTsTjZQYAJ1gxz+zQFwb92be42xmFh8lKHOTMjocgv4RQztGeI6bZXejWbFTmqWPpFrtDJJtKVEMaWw3FgqRONnEa/cX+kkh4+q8WqKVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oxe2tfBI; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNrQB3mpDH8gu1+Yo0yFD8nsPGQIWg6a//dixnZozHyzce/ew/ESdS4JDnlZMxcrefuWKvDzk0QJGs2RbJ3aUmYd1JWkvsgCSyxMcJaDIj5At6uWrW3A34aYNMSz9Nu6MvmqG65tzhUK8V8aY1qJKeJCO28D3DjzDiZWObH6opK8caE8pk5qxHf2xAeecyMPiyZ1dgJXzAjbKIM/Q/ko/e7ji4g3cRGdzZNKomPbJlwBpx20ZCRQWtmmCt3YJRJzpLyhvPZeJtK03ORMe0JY8t8/tr7BzE//4JQCFW+bi7Wx2BiRQlArVRuxC68oQCqr5HjbBTW3s5f8Qn5/BwHQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN7f0E5WZZR40G57tO1RbO4nv0Z7+irPp7RT+MeMTGg=;
 b=QHuTqwUfWiF0eU1ExgyKm0821g3IyaW9JdZU82oGgDMrmNRm2qKcGMik0jWNajMYCIZdS8k8qqSiJFGBDLWIJWoqAzsx+ZeseDUFhIRYrCQ0bghi6Ysx1k8dLuQvwWY0N/3tS3fp7U41KXZzvVxlloKNehspnTaUEX6MWFWYjE22Uko0EAzx7JaXHQQsKVGF0wMDnA8GB6BkvgFrK0Y32RFsWpiIQSnZcvGWWcA42YKyS1wj/rBXQZ8v8TfPlhpxkKsJVIOSyhqjD+p6RARBnANANmbym1hPa9sEcsHgoT0L8/416j8Dla3Ipji9T0sGySHuuNUWgVB5EzblWCzggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN7f0E5WZZR40G57tO1RbO4nv0Z7+irPp7RT+MeMTGg=;
 b=Oxe2tfBIZCCLbHZIT1NOsC6Wlue0BwCXfLus25tAGg8Frb8xIVMMyGJKYC79KidiyCDDEhklJS3E3OyRLiDizogmVZijvCYVxsLZBwzlRlsrjF2HLNY3J3VgQUTcETNDeFERLSSt8AVOdxnB5Uwv+YjEu045ILAColMLlOmhkWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 08:58:02 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 08:58:01 +0000
Message-ID: <670a9454-7e9b-48ee-a87b-966c90214bc0@amd.com>
Date: Tue, 25 Jun 2024 14:27:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Enhancements to Page Migration with Batch
 Offloading via DMA
From: "Garg, Shivank" <shivankg@amd.com>
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, bharata@amd.com,
 raghavendra.kodsarathimmappa@amd.com, Michael.Day@amd.com,
 dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20240614221525.19170-1-shivankg@amd.com>
 <Zm0SWZKcRrngCUUW@casper.infradead.org>
 <c024d035-dc94-4e89-a935-795ab2ce24e7@amd.com>
Content-Language: en-US
In-Reply-To: <c024d035-dc94-4e89-a935-795ab2ce24e7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 0886e997-4f95-4cfd-f59f-08dc94f4eac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2JRL2tyelBvZ21reTE5UjFBTEx1dW9LT3V1cHk1UDJlcEVGakphZmo3UFU0?=
 =?utf-8?B?LzM0VS84T3pqVnlnVUI5NndUS3VRT1g5TSt4Sk5aY1cyTk1CeFk4eVhRVm5v?=
 =?utf-8?B?OGNCS3V6OWU5UjRkbVhvbG9laWYzWEhSUXVXUUxRVHRKeldwS1h0NWlCOTUv?=
 =?utf-8?B?VThHNnZtamtjeHVWZTVJS1I4Qi9GZmxna2VBcEhNS0ZIN0g5MXQvOXRtN1Y4?=
 =?utf-8?B?YzdocGViVFBoK283V21VMmFpaEhqdjJla1hVbUdScDBqSkJ5SkFYK1ZNQlhD?=
 =?utf-8?B?VGFvbXhpVEcvTzB2MlRLcmkrT08vZkpoSE9aeG83WVdDOXhGNUpPMlIyQ0xE?=
 =?utf-8?B?enBFcU5qc0N2b0ZGV1pQbVBHNnRDeUFtZW5wUnlDbkxRdkFnZXhhSEtjOHps?=
 =?utf-8?B?MERoY0tOL0U4VnVneG5RaEJsT1lwV0VpdVBMdVFGUWtPc2NFdHlmN21OMnBJ?=
 =?utf-8?B?aTdKVmJWTHNNNk1mNWtLVUZqa3ZIWFBJS1dkTWRuQlQrdHZzWHZ2STkrTUV4?=
 =?utf-8?B?bWtJRndZUXVvNkxsVjgzUmpHTTRLaGxDN3J3MWlTWGk1TUlvaFNQQnBHQUhl?=
 =?utf-8?B?NkRQU2c0cy8wZW92UXZvMEwyYnQrZEZoMlJPYnJvdHRpajg4dy9maHJldmNL?=
 =?utf-8?B?eVphTmRoc3lTRmJRZ1FyVDhVNVZWUHBWbHZEbzlDRnBmbVRMMFJFU1JpVlB2?=
 =?utf-8?B?bFNXLzExUE5Sc2c1Y09KV1dBTDVWMmFYS21sSGR0RzNZT2lLRXZoTE5WWnI0?=
 =?utf-8?B?MlpMVlIzVmM3WUhkT1B5QmFWU2gxWkI4WStMTHlGQVVwajJEbW00TTgvWHg4?=
 =?utf-8?B?U0ZHcC9tYjZJN2N3WmRQcnhQZHU2VFU3T1BqMmpkbllEbFJxalR0WVJiN0JI?=
 =?utf-8?B?VllmZ3o5OU1mV3JwQXA0WGRkR2ZjWlh6MFFvamtBa29waDhUSW9YUlFrM3lZ?=
 =?utf-8?B?TnNZRnBwc1dCaENYbjdSNitIY3RpMjYrZ2VUQWVzOG9ZMWRoSHVxZEwzdVE1?=
 =?utf-8?B?Ui83R2ZwNUZrbUg3Y2R1VkRiU3Mra2xORUVDUDZKVDQwTW5keHJ1V0NSeTVi?=
 =?utf-8?B?SWRPemdTR1VxdEt4QUJqNFQxZm9DZnNkelcyNVNYeXoyeUEwU05xNjJobmpx?=
 =?utf-8?B?a2tkY3VsL3p0ZXQwZEpCQzJ1Rk5NbEZwV0h6bFlWUDJaZWdlZ2kvOU5XRDVN?=
 =?utf-8?B?YUhoOGt2dWVvcVl2YndwY2xWS2hrTmhSdGJOZml6R2VOZDVlNVY5SFN6cHBi?=
 =?utf-8?B?Q2V4enNrOGt0cURzT1R4VFFhYkw4T052NG5xQ0poV2IxV0pYbGMzT2N0cDBL?=
 =?utf-8?B?NnNFaUt4S090d0NCN2FBclZJbXdDazROcUl1YmpGNEUrM3g2Z1hjVHNtUG5p?=
 =?utf-8?B?aEJOcjZaWGMzaDdvYVlHY1pjY0ZtZTFpeVBXaml6WWdKaGtlQWdybyt6Q2tH?=
 =?utf-8?B?Ykswb0IyTWMyNVB3QWpFOVpyQit6ZzUydTFxL0Q5N3pnN3MrY2RaRWkyNVJr?=
 =?utf-8?B?cGt4QVVlcG9FNjAzSERERVJieWI5MVlvd2NZL1JjeGhISHZ0TFNhWnJlUFpB?=
 =?utf-8?B?MmVJWlRJbkJRY3hNVk1BbU5CYjJ5ZU9XUDNvb1F4VzAvREp1aTJXRzJvR1Bh?=
 =?utf-8?B?VFEvM0F3N2dBVytzdDdiK0srcXFCdmtDTGFTK0MvU2J0YTliU0hlc1VLZUlM?=
 =?utf-8?B?eWhlc1JBTDRxUVRON0RkVjFaRTMrZTNOT1MzWG9IOFdKa3lLTWxmWTltN3kr?=
 =?utf-8?Q?y59EEDqO8/eeXT+Cd+OhK46qvvFiCV5YxEusl39?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWkzQkJxMVpIN05QL25sUUFCcFdENXduYlNmc1lWOEdGdWhvVTM5T0pPNlVi?=
 =?utf-8?B?Sy9rZHB1T3BZbG40NFVjTXJ1Vko4UG9PTU8wM2NMTXpLS0J5bUJ6cjZROGtk?=
 =?utf-8?B?UXhKeGpjaWFEK2FyNmF4cUJxQmNtRmRTRFhrbnNZNHV3elQybW5Jb0hEcTdE?=
 =?utf-8?B?NWNzTmtRS1RNSndMUEg2MVdXdTVneDE3cGJhcGNocWRPd1N5R3dFbTNBQkJ4?=
 =?utf-8?B?cFlKaUs3SEU3OXFZV3IxMGZ1Q3ZlMVZyN0o2ajNoRWd3K3UwV1VDdk9pamhY?=
 =?utf-8?B?MDVlQk96VUhsRVhZZ0F3cmtYOGdEekhOR3p4MGxnTmluMW0vcmR2ZXJnTGkw?=
 =?utf-8?B?bGpFZWp4S2d4bnpVd3YyQ0ZMSm1RVzhUU1J0alpKd3gvaU9oM01mVmRFOHF3?=
 =?utf-8?B?S3AwdVo1WXdjclhIazErN3R0aHZSV3prcllqY1VaYTBtdGVpZnBuajhiSG02?=
 =?utf-8?B?YTFBci9TYXVJaVBIbWRrZEt6VGVVUC9MaDUvNmkxZGxuenJJd1FWWFJSNnYx?=
 =?utf-8?B?NGxnSlVjbzV0MEkxU250c2UxOElzSkpISk9DeS9Tb01mS1I2MjlQUEs5c1Ni?=
 =?utf-8?B?aWVIeHdpaDdDZFF1dUsrYVQ3bk1vTUpjMElXWWxRZ3BaOXoyZzBGa0x1VlhK?=
 =?utf-8?B?SW9iYkFxYXk1Rkcza29GZmdTMUpuWUsvZTJXc3VVclAwbVVmR1RZazdJd2tG?=
 =?utf-8?B?NnQ4SUdaRGY3TCs1NmtIRSs5cm5vMlRuYWdSbXphc01NZEpGQkNTMU01Qi9L?=
 =?utf-8?B?ZldMM0ZNS3lLZTh0TFcwU09yV1gzRGd1QlNCTFdIWHN4Q055ZlVpMnU3ckNO?=
 =?utf-8?B?NkpUTkZjUkpvSnhZNWlFOEQ1VG14cW5lRFhOZFh3aVFrK21ZelB1MlFuVE9x?=
 =?utf-8?B?c0JpUHZSS2lpQmd6M3crc3JWTnpsTFgzdm1SK08rUjAyUEhqWDJVM3RuVGpV?=
 =?utf-8?B?NzVwcURYVWxnMVo4d1R4WnpmdkhBZTFiQXlIcUJCd1haWXdjR0dHcDBJUlMx?=
 =?utf-8?B?OWpsdnI4VjRtUm41c0diWk1YaFV5UDc0VmdQRStiQU54MU5ETERXem52dVl6?=
 =?utf-8?B?L3IyTURRbjZyUncyWmFmVzdjVGJaVDJSa2pHYUFyc0VOSEVGUCtpYXQ4OUNZ?=
 =?utf-8?B?d2FQMktoaWpVdU5IU1BiVUlGcXRaeFMvTHhoZDU0VjFrdkxwL1BoVHdnVkE1?=
 =?utf-8?B?RkJtWmJiS1ZJOHZxUExpTE5XVjNocVlTM3BIeklnK0xZdk81N1JENHBDVmg0?=
 =?utf-8?B?WGlxdFMrY3U3bjhaOFcwY2p2OFNKYVhRVlZ3Z2tNeE1SdWYzRGh3S0oxTFFE?=
 =?utf-8?B?WDJXUTd6aXpwNlJ5TDNmZXNOSHVEZmpYK1QwVlMrYzMxdkxmc1VVR1hFaWMw?=
 =?utf-8?B?Ly9LK2ZZWWVDWTd4dVRRVmgvYkRSUEdoNFFnc3Era1Uza0IvYzlFelNhSGpU?=
 =?utf-8?B?N0FiVzJxb1NrYmF1bFErdWwwSHNjSjRyMlVRa2E3NWtXdmx6NFJycDJvdkU2?=
 =?utf-8?B?YWI5bFlPV1k5MnA5eGFjQzJudWc1R1IzMFZPc1V6eWh2RkZtditDZmpTZFhn?=
 =?utf-8?B?TG9HbHRiRHlPSmRIS1JvWmc4SkMvaFBBR0x6K3lUaDNFM3FhV1BCcHFnblpL?=
 =?utf-8?B?L0h3NC9Zczdma3RKaGlpb3JYZmg4bkJIbmZHRTZubDU0dWtBNnFaZWFrZTNG?=
 =?utf-8?B?NVJUZ21nUlovbVF0Q2dDa2FSZHNGOTNWOExTa1ZiQ1Y2L280WGVoSTc3NW15?=
 =?utf-8?B?cFd1cFpTV1FzQTV5UlhUNlZ6S0YrUThtYWZnQnJtb3JkM3BMWnNScHBCbGhi?=
 =?utf-8?B?enNKLzU2T0ltelQ1Qjd0bGRJUm5Sa0g5MXB2VS94cytQMC9RMjFsOU9aQ0d6?=
 =?utf-8?B?d0NuL1JNNnFyOTJvaE5oeDMvWHNTYU9jOW5Ub3hjbW9NRjZBSXd1ZGFQZWpS?=
 =?utf-8?B?ZGl4eFY3eE1HVHlweDdJY1ZLWE9heVFLTEJhQUJnL0RWWXpwdFE0andyQ1JK?=
 =?utf-8?B?WGZZejBsd2xuZExtL3JScEJkVm9ZckNSZ2Nyb2I1d2tGREVMclBOYktKWFE0?=
 =?utf-8?B?aHFuYTNHODlhMHUxREc2bUhud3FPMnVmVVlJZHBsU0Nna1hrLzBRZzRjTHNQ?=
 =?utf-8?Q?TECP04gOgZixujFSLXm/nAR39?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0886e997-4f95-4cfd-f59f-08dc94f4eac8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 08:58:01.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEH9Yv8GIqG4DOUuuReDKveUSmDXeXH1/JZszEPYofpIBccSU2aUvVuBrPcWvBzMpdlA1y7E7Z3iqvYD0WDMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177


Hi,

On 6/17/2024 5:10 PM, Garg, Shivank wrote:
> Hi Matthew,
> 
> On 6/15/2024 9:32 AM, Matthew Wilcox wrote:
>> On Sat, Jun 15, 2024 at 03:45:20AM +0530, Shivank Garg wrote:
> 
>>
>> You haven't measured the important thing though -- what's the cost
>> _to userspace_?  When the CPU does the copy, the data is now
>> cache-hot in that CPU's cache.  When the DMA engine does the copy,
>> it's not cache-hot in any CPU.
>>
>> Now, this may not be a big problem.  I don't think we do anything to 
>> ensure that the CPU that is going to access the folio in userspace
>> is the one which does the copy.
>>
>> But your methodology is wrong.
> 
> You're right about importance of measuring the cost to userspace.
> I initially focused on analyzing the folio_copy overheads within migrate_pages to identify potential optimizations opportunities using DMA hardware accelerators.
> 
> To address this, I'm planning extend my experiments to measure the cost to userspace specifically related to cache-hotness. This will involve the accessing the migrated pages after the migration process is complete, and measuring the resulting latency to read/write.
> 
> This approach of DMA-offloading could possibly help in scenarios involving bulk data copying with workload size >> cache capacity or incurs a large shootdown overhead.
> 
> The userspace cost analysis will provide a more comprehensive picture of page-migration using CPU v/s DMA-offloading.
> 
> I appreciate your feedback.



I extended my earlier experiments for page migration from remote node to
a local NUMA node. This involves measuring the cost to userspace for
different workload sizes (4KB, 2MB, 256MB, and 1GB).
My experiments capture two scenarios: First, Smaller workload size (4KB and 2MB)
that fit within the CPU cache. Second, Larger workload size (512MB and 1GB)
that exceeds cache capacity.

move_pages for N pages from src_node=0 to dst_node=1

Measurement: Mean ± SD is reported in cpu cycles per page (normalized
w.r.t. number of pages = N)

move_pages: Cycles taken by move_pages(2) syscall (cost per page)
uncached_access: Cycles taken to access memory (just after clflush) for pages
on src node 1.
cached_access: Cycles taken to access memory (when everything is previously
touched) for pages on src node 1.
post_move_access: Cycles taken to access memory just after move_pages syscall
(when pages are moved to dst node 0)

Generic Kernel:
4KB:: move_pages:193154.40±50519.59  uncached_access:1269.40±163.11  cached_access:383.00±31.92  post_move_access:420.40±77.04
2MB:: move_pages:4930.36±100.74  uncached_access:793.46±82.39  cached_access:208.59±2.07  post_move_access:181.34±11.55
512MB:: move_pages:4498.93±146.95  uncached_access:656.43±23.08  cached_access:801.93±111.80  post_move_access:402.37±15.26
1GB:: move_pages:4419.88±203.91  uncached_access:627.85±13.24  cached_access:776.01±94.27  post_move_access:384.24±7.33

Results with Patched Kernel:
1. Offload disabled - Folios batch-move using CPU
4KB:: move_pages:206370.20±28303.18  uncached_access:1265.20±141.38  cached_access:385.40±54.32  post_move_access:407.80±52.60
2MB:: move_pages:5110.16±188.60  uncached_access:794.05±72.25  cached_access:208.65±1.75  post_move_access:177.48±9.93
512MB:: move_pages:4548.00±188.91  uncached_access:658.23±23.63  cached_access:777.34±113.15  post_move_access:403.48±17.27
1GB:: move_pages:4521.19±195.13  uncached_access:628.85±14.72  cached_access:750.85±98.22  post_move_access:387.79±9.49

2. Offload enabled - Folios batch-move using DMAengine
4KB:: move_pages:222818.00±22710.80  uncached_access:1277.80±145.74  cached_access:405.20±101.85  post_move_access:427.60±130.13
2MB:: move_pages:15590.80±288.89  uncached_access:799.36±76.60  cached_access:208.79±2.11  post_move_access:183.21±11.67
512MB:: move_pages:14154.06±197.59  uncached_access:649.93±20.35  cached_access:814.10±109.81  post_move_access:403.43±13.79
1GB:: move_pages:14415.04±303.83  uncached_access:629.03±14.83  cached_access:731.16±97.67  post_move_access:385.08±7.62

Code snippet to access memory:
before = rdtsc();
for (int i = 0; i < num_pages; i++) {
	for (int j = 0; j < page_size; j += 64) {
		junk += *(long *)(pages[i] + j);
	}
}
after = rdtsc();

Discussion:
1. My analysis revealed no significant difference in post-move access times
between CPU and DMA migration.
2. For smaller workloads, cached accesses are significantly faster than
uncached accesses. However, for larger workloads, caches become less effective.
3. As expected, post-migration access times are significantly lower due to
NUMA locality.
4. Just to make sure prefetchers weren't messing with things, I ran another
test with them turned off. The post-migration access cycles for DMA and CPU
with prefetcher-disabled are still similar.

Thanks,
Shivank 

