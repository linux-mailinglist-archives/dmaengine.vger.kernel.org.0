Return-Path: <dmaengine+bounces-4806-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5BDA798D7
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 01:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85611664E8
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25F81F4282;
	Wed,  2 Apr 2025 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MJk/E+Tl"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6B26AFB;
	Wed,  2 Apr 2025 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636684; cv=fail; b=QBWUnmNrQNiXvPcyFxzK5fvo2wnPS37dQRftCe3s6IAuPcf+G29ZcqnV3gWtf9IV2ezteX/I6dQBe5AWGzCDELQnOq4h3iBxQFnbpX234HLzMG3x9wEUtShnSZ7RoN5xwlRSIfy4vMeJGXcXe6xO+kw7bIwUTJqjqtP7saqWbfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636684; c=relaxed/simple;
	bh=K85KNrmIAunSGZYfAOPB5Baiz91fZVkBLyGtWckBcGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OiFzL0z62WUnEKckl53aM/3tD7FqHNVp9gdZi8IKEEjnSHuLAji41YK6DtjoG4/mA3nnrbxKMB5hQNLVTb97LJSrUioRidxb0rRCzuCCkueccb7bOUOogKAA9okUffLl9R7IrpcFBnUBCUmQK6WB6uDLUKcMJpjarY4Rb756hm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MJk/E+Tl; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKRhhZkhYN5iOXkrOmWuqV395PXxuV2kjEJMC0X0C9Ddn6APoaJ/AvqU/H9tzXLsWJTl1ye90DR4PogwL6a5Z0krTxohNp/fUYTHt3W6IQ+soeZM1IWUVMgpOaUOKyjdW8SR2tfPVfVXQcnh19vtea6r4y8jGuO+fRtpuznd/bV/6Gw2RD0zGW1iHyL7mQIU+oDlhd5q7y2R5P5/2Nplhwqwu4plGI/mTI0psvpnuJ5T4BwcBKuBjVkBEXb/PpL5YSWZ1H/yksrsIeaFc+c2aj+cPCLVFzHEc5H3ssDJWk3i3qyY4eMohFs1leB80zcAZhoO6F/W1LatSUi90npwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VhqLFNlO40mf6CN19GBwzyHSGi0WqeC32FRKQy0Zlc=;
 b=KEFJyAD22xCNKu9rI/kOa2OoA0oCTkvO/xLcXCiDmvAc5yTAy5Wt+WycDoTd8QJfs3MActs6Hlbbs/95KxBhtTCmEHbXzqMrMdng1kkKC2ICQS0FDIkUIbqNRhx4mCrX/7y3aFM3HpRYf+y5RFdRxC6f4xqrrel08O5nrYRHwGwk9ucTyVVyYcPAq6MLxwhn7Wr+bTXXGa3nro9YiTxoYkzCMUSj1H1R+d0nv7+cqNKrrvQlssE/jJgi/A5WeYzJ7CM0oFnbbzdDF0dbv2U1XJ5kU8e0rVjST6AVtxA/GsEYcjcDQ2uD/yJjGCSvGMH1gMHOG+blt+8E19V6lfzNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VhqLFNlO40mf6CN19GBwzyHSGi0WqeC32FRKQy0Zlc=;
 b=MJk/E+TlBraVTdXg11aWQxs3Cr4eCO3mFcjHn8yW5psyiCKynTBJ+qrqrpm+WrwR1o3792LIRy/8zbQlmYcjcQc+q8x/DsLHZDAgfZefwrGQOh/etkKFA3+C/pHkbNK2mNSzgrbbcpcuDTbKtPeJF3PLE10nI9tI3igeQjI32bEbPiSfdYYobXHP85Pw71vRukgdVB3l73Y/5Rk0GONGQ+R24sYtIRtn3YJmiW7Tsqw31cSCOAfQdBb3aKu7us1l1JCfMXGH0KcTgKXNGkjEEFOdiMn69YPtozTJvxVxBrBMJH7fnpPd5mkkvOt+xAgzDVtwyKzy/YUa8XrSnWqZqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 23:31:20 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 23:31:20 +0000
Message-ID: <fa205923-f56b-4459-8127-6a995ded2b25@nvidia.com>
Date: Wed, 2 Apr 2025 16:31:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] dmaengine: idxd: fix memory leak in error handling
 path of idxd_pci_probe
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, Markus.Elfring@web.de, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-8-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250309062058.58910-8-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:a03:114::39) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adb5da9-3063-4476-7b3f-08dd723e7963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXpCbExtaDJ5d09CMUZaVFI1bndYZ3lBVzVTMUNraWhDalF1RDNwTE9yNDFN?=
 =?utf-8?B?WW1BYkZDT3hUNEdmdWovcE10MHhUaGxncCs1T2RPRXZDZGdhNzh3QnF4Qk1s?=
 =?utf-8?B?dHcvMitJYjdCdmIwUzFNWDdwNFg5RXgyaHg5WkZFVHpuK2ROVUh0LzNTTlkv?=
 =?utf-8?B?T0toWTBMeDd0cnh3clNROVB2QWZCaFpqWUNxYkN4alZiSFJOQXBBdjhaV3Bu?=
 =?utf-8?B?OUwwR1cvMGh2RGpjRE9Oa2lEL3oyWGZZUjN1eUR1WDB4eGlHOWdIZWNlWk1q?=
 =?utf-8?B?a3JvU0Y1aGxkdDgzY0VsampVSHZTYmVtOVpvZGdES3RRM3ZTZzhBMjNwc0Vm?=
 =?utf-8?B?UUQ0L3pKaDBWazJLd0syREFGMHJLWHA1eldqZ2g1SUlsaGpFMWhQNVZHcXhU?=
 =?utf-8?B?bWI1b3huQTFmWGIzdXp3U0RzUHVreGk5RnZWUk1xY0ljeXJtTjJxQ1ByckVP?=
 =?utf-8?B?ek14OHNCU1hydjRRRitzK1Z5TTJMNE5ST0hGNnh1Qk5nQ081VzAwUHBpUkI2?=
 =?utf-8?B?bC80eTBjUlkwcHJqaFJsK2NtdTcxZWRzNkRDR242YS9STXBNN055a0wzZXli?=
 =?utf-8?B?M3JxKzBFVnhEU2NGVzdZSWU3dlJjZHVJQXhVV1ljYjBPUHNQajhOZ2c2aGhx?=
 =?utf-8?B?b0RXSFdkUGp0Z0VmRk1yb1BrMUtJWDJYVmI1cVZYZC83alhoRXI0Y1lEcEFz?=
 =?utf-8?B?cnArM3ppNlF0clNTRW5wWnRvdkNGQUl1alorNEZicXVuaGpXdFhKbnRQQnNs?=
 =?utf-8?B?eUpiK1dlZWpWbXhwV3ZwbG1XUHpQeDNDL0F3RFFyTWl3b2ZtMWc0bU1HdHl3?=
 =?utf-8?B?K3pLbmt0aTY4MGxSWE5BVThzUCtVUlBTdGd0QjBxSXNwQ00vdVFpRCtPbjlk?=
 =?utf-8?B?RUpkZU03RmJoM3pOTjg0Sy9jV2hrenNMeVVud1FZcDJ3VTZEVVpib0JnR0Ez?=
 =?utf-8?B?bGNaTjhlZEpIRTVZcjk2REJoNmEvajRkdGRta3BMTnlBRWdPMkgzMFI1WWpk?=
 =?utf-8?B?Vkd6ZEp6V2cvS0kwN3BlMUg3bmZTcnZCU2N5N0dQMVUySmhqNzZNRTJsdWJz?=
 =?utf-8?B?TFVURmlmRzRUVFRsSWw1WVpBcmlXbXZzd1ZuRkNQUGdpUlFUTzNMNEVBMGJk?=
 =?utf-8?B?NUQ4aUh2WGs0cDNWOUJ0cSt1M1RMbzZKRVpkelUweDg4TVNzV3VXanVmWjY5?=
 =?utf-8?B?dXVybVNMNDd4QVMrZXM1cmYveU9BUXcwcEdWQnhlWVVnK256N3JWQmw2TEc0?=
 =?utf-8?B?b1N3YzZpYnZuU3RpYXhqeFlTVXBmd2QvY3B1UEdiY2VqQnFEaFVsL1lnbVBY?=
 =?utf-8?B?dEJYVDVmQnUxS3RsUys1bFhDR3VoV2ZDWUtWc0RjMDhUSnlkSU8yKy8wMWsx?=
 =?utf-8?B?ZXRhdnkrWVVsanZvMU8yZ0V5T1BSdDhWTmI4d1JOOCs5cFpnZmI2QTYyUWE5?=
 =?utf-8?B?SWl0WWl1U2laN0M5bVlnZnlGemVCd01KUHVCT0t5NW45SEY3b0JpNElHQzBS?=
 =?utf-8?B?TEdFbVYvdVg1Zm5LS2IydTlyUHpBM1lDQmlIWnl3VGtHQnhVK1czMEtMYi9I?=
 =?utf-8?B?YzArTFBqc0hGMWYzRFR6ZFdrTUtZdDN3ckpiNzFpL3g2dVhxRFNtdWh1SXp4?=
 =?utf-8?B?SVZsbE9OZytRa3JVYVV4N1hiZUprVmhDVWhjMGNwU3picU9HUC9qeVVGcHlP?=
 =?utf-8?B?clZyenpyUXBnQyt4UXpXRGhabmU3eXpiWFZpeG1seGR4eGNFd0s1dU1lN0Fi?=
 =?utf-8?B?cVlFQ0FvQWo2OGhpTjQ5Tyt5bVdBUE1rRkZTejk3WkZnbGgwWUFqTXliT3l0?=
 =?utf-8?B?UVNFSUlMK0JZTDgwQjJ6UE1uSW12SlFSVDZjRW9scmt0UXFKZ1g5ZjNKL1NM?=
 =?utf-8?Q?IjeD5t6V5S87s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R085bGhnbUVFZVFqVUFYbnVCTTFIT3RvUVlVWEc4M2w4N1RjdXgxeXpJaG00?=
 =?utf-8?B?dzc1c0p4U3YvLzFTbHZkRGVENDNVRytrZjJFdC9lQXQ2bXBRR0EyVXQyN2NJ?=
 =?utf-8?B?QWRLb2M4K25WUHVJdElwUE5ZaDd2WWF1bmljKzU0bStYZTdCQlYzSHB4eE5z?=
 =?utf-8?B?VzdwQU9pdk4vUitQcUh2MitwTWVUL2M5NFFUWjZ0Z1FhaGdRV25uNlVrWWVE?=
 =?utf-8?B?WndodUx0alhWM2VBT2c5WnVhanM1SzAxSFIvWm05TExaekxSQXRPWVNYMGRt?=
 =?utf-8?B?MXdpdXd3eHp5a1JNZ2xYY0hsSUJLV1V4eC9TTUlTWDBMazJweGNJUWgzSUph?=
 =?utf-8?B?U3ovTkI5SXorck5QeUxHdUJtOXZmaFpqZW8wVzVWbHVyVFRURk1NR2krRmJy?=
 =?utf-8?B?NGtkS2JWbGwreFcxQXQ3M1NnTlY5WGcySWZkOWV2dkNUVkQrNVlDUTBIeEVa?=
 =?utf-8?B?bFhSQjlwcXEwbmJNb2E3Vk5VRkMwSWNzT2hDS3J0NE1NeUhGWjdYOE9yRUQy?=
 =?utf-8?B?YWFSa09xdlJqRUhYZmJyUWQreVgyQjQrSmE0cUU3d00rakR1S2xybmlCRGVk?=
 =?utf-8?B?QjNsQnIvdEhERWlMSC9LcHdjdE1Yb245ZmwwUHpnaXlCakR6YW5uZ0VLVGhO?=
 =?utf-8?B?MVdwM0s1Z3d0QVlwMDg0TzhkN0xlVkNTenNNZGFGT3lLWm43ZG9MeTB3Z3Vh?=
 =?utf-8?B?WlFqSVBGdjEyTjNHY0VpdDM0Wlk5SzdiUmhvakhCVzJaRlFnUUpGSFRtMGVo?=
 =?utf-8?B?R1U3TjZsaDA5Wmp0MWdqdGJQbHljREJ0YTFEY0VCRllCNWV4S043TmEvcmsw?=
 =?utf-8?B?aWNkenJHaFhDMlUrc0xZRmo0Y20vK1lsRkQySlVvSDVQeGt1d0JQUmRra0NK?=
 =?utf-8?B?ak9UVGp2WGdoNXJjR2RVcXdiLzBYeWtBQ2diK1dFTDNNcktGWXZOQmxoYzJk?=
 =?utf-8?B?RDFlanpEaGtPK2cvaGYzb0t1SzZCaHFVdFBkZHRteVY3M1dmcXhGTlBLVkFU?=
 =?utf-8?B?OTUvb3RoY1VVaDdwSWhTdjZwZG1wUmhwZmUwUjdiOS9GSnJvM2IrbGdIMTFZ?=
 =?utf-8?B?eVMwM1k0ellkUlcvdy9DTDYzaXF5SGhjR1FOS3RUaS9sRmFUVnVUTUYzREFh?=
 =?utf-8?B?cW5lV0tldXc5OXU4VHBVT3BPaHpLem1wS2dlWkFRbGd1M0grd3NtZS8xQnds?=
 =?utf-8?B?T2s4ZDZiSmE3WlVrTkVMN1VxZ3M2RjlpeXFlSnVWR2FvcVlHd1hiM2hrK3RS?=
 =?utf-8?B?Y0QyajRVNmw1MTM2ZHVqcTV2RkhQNFBYQURCdXkyTzRmQk1qVkdPMUFZUzVX?=
 =?utf-8?B?Z3ZuWWxReTVrbGduVDBaS0J6WXNzVUQreTNkdUlOUlVtYjNxVTd4cnJ2a1cr?=
 =?utf-8?B?bDVycmJZZTJ4MHZXMm5oYS9vRWd4d2ZBRmw0SVFoQlBwOEhJL1E0UmVHQzdX?=
 =?utf-8?B?WW1ZcjArYU9UQTJ3WXpMeTI1TWxjeXp4bkVicy90VG9ZOHNNcG9jV1BueDVk?=
 =?utf-8?B?SitmZEhFV1Q2YUJBYzJtRVZIQ25YMDArUnNCZ1g5QnpFTVJBckF3NHRFMmdP?=
 =?utf-8?B?YmdyZnlWZlpUSDk1N0pmTUZTYnZTeG1WTk1PSS95R0RQYnNtUXZ6WXB5Q0ZT?=
 =?utf-8?B?WklEMHg2OTdJRTJvMEFnWVRIQ3FxOW1JaWpiQXV5N2V2bWFGbE5iVS8wMDVC?=
 =?utf-8?B?VkdpdVhseE1xd1JNaUFIWVNRV1J1TitKVjdwMEpmckczOFpkVFFoY1hpRWNi?=
 =?utf-8?B?UHdFYUsrb2Zwa1gxVTRvQjFldmVWTEF0S1Awd2hVdDV2VEZXdXo1ejdQVnAy?=
 =?utf-8?B?M2Q4dWs2OUtWdXZ3MXZ4YmM4YjNWMkZiV2JqZ0cyMXo2QVJZc3FYZnF4ait2?=
 =?utf-8?B?bzBNWFNiWlJYN1pMNVR5TEVhRU1YS1JNWk8weGpRdWdIN1Blc2hXZWhRbGdm?=
 =?utf-8?B?MC9BM01ncWhHaGpIeUNLdmpoQlUyeFhyVkM2UWtveXJMY0RxcWhzYU1xbk5o?=
 =?utf-8?B?VEZHamhaVFdreW9VSkJXdllwTVdxKzZHbWpGekpQRVRoNTY0eTk3cW4xQnox?=
 =?utf-8?B?OSs5OVFFTHVlQVZlUTE5dW9SbS9HSnlZeDF3UGlrclRLalhzZmZHS3BOd1R2?=
 =?utf-8?Q?XUVC8A3mgIktcH4BCjABoAeGL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb5da9-3063-4476-7b3f-08dd723e7963
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 23:31:20.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTEZOXRcx7y9B/HdbTTyBRnd04AP6gUBNmfMVK7BqbRB+hPwKaYXJhZRtENbtDju/8sbIIpjKaXwSxxcYSj6SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161


On 3/8/25 22:20, Shuai Xue wrote:
> Memory allocated for idxd is not freed if an error occurs during
> idxd_pci_probe(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
>
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> ---
>   drivers/dma/idxd/init.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 71d92c05c0c6..890b2bbd2c5e 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -588,6 +588,17 @@ static void idxd_read_caps(struct idxd_device *idxd)
>   		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
>   }
>   
> +static void idxd_free(struct idxd_device *idxd)
> +{
> +	if (!idxd)
> +		return;
> +
> +	put_device(idxd_confdev(idxd));
> +	bitmap_free(idxd->opcap_bmap);
> +	ida_free(&idxd_ida, idxd->id);
> +	kfree(idxd);
> +}
> +
>   static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -1257,7 +1268,7 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
>    err:
>   	pci_iounmap(pdev, idxd->reg_base);
>    err_iomap:
> -	put_device(idxd_confdev(idxd));
> +	idxd_free(idxd);
>    err_idxd_alloc:
>   	pci_disable_device(pdev);
>   	return rc;

