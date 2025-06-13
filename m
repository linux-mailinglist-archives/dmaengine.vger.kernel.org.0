Return-Path: <dmaengine+bounces-5462-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BFAD97FF
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 00:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AC1BC4967
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 22:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9163528D85C;
	Fri, 13 Jun 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ksxbN+rR"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31023ED5B;
	Fri, 13 Jun 2025 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852240; cv=fail; b=s3wiHDF0oiWsfGAqp9RwW4tcbtXEoXT/7KHzSKJu1YE6I+LiLbYu/4ve7/nkThRr2ANpmXoZG+une6vSuzc0hP0+ntduy2XIhMrTisl9Olp1xX9yuS3oruUKDg2TPe1jupQhDMbMBAYbZ3QB+UEOUavvO1A2RRCzMK9BwlzfDOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852240; c=relaxed/simple;
	bh=NO8EHaFgb6SRMUqAzaFyGOv73404+ozU9aMjO1G3xKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TpNDQhtio/Ho8CkxAbNl08PrkUkJcUYh53kwvK/ciUFzLIhNs6/CG2ZN//Rkp1gavqNWCcTNBYeyzXbf2zD+cz3OtTVev8f+TonPrK/UHUKfQYslOtWa4PYx0F1Ggp10ayJUBHVvFwW/fcr6+XEmPO4emfQjb0g8NpWsaZyUMDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ksxbN+rR; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeUrIsbLcZ6B6tb9/es0de/yotcyVHMHHX+rgwu+0a62/0M1C+EpeVPKF/OBUZKNJ/NH79saHCBpZy2qOWJAO+6onPn6EfIE9n4evh3zBqwXDAZd3Apn1iUIdGltpRf24ZIlQ066FvUZASh/I2OriY4QlOBRmhlY9VlSlyEaxPxqq34GkVI3xghxMkyZ0hDG0+7N2LPCVna8mr12Ces7mpvgTMMbgqgZFHB5UnxhpnjQwDpInh20IV1RKaU/kWWI65wKHwgPOirWt1swjZ7rilLgKXcqwxtZEKV8dCqSqyy2ZRd5uLxXdO/8XJoc8+GXRVMhPIhYIYLgUULkwZkFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyaJJsuEIjhiSkOIOXV4CtRz5HyCMEHlI8AHO3SSzAs=;
 b=e2FmPbnlfsOd/4zDlodM4I887nPLGYACvSzF1Tnv6Gd2Y+8/eTEErJk9kOufRzv/tphVOYSOmtHXqv33oxHb5t+Qd3+Z7PYyu/huQyt85Oj9vcMx+rvn2xYZkuBsMyOSEGG8bQl4qCbbmBVcS+33eWXGK88wm/LXh5L2HlSQFcxuDxMFzPIy30+o2/PldgjXK8oB8h9Zd/eRmaUhDXcvSKmYLbLWmshTS02G678BobVGHtlPeQnF0U96CKgoR4L/nzjOBZaQy1qJ9XilaMIC+wVw2pJEEg8dyOnUKQdH9OUneRi89bK4QXmYT/Bc3uwbGQJ1x106/KMLKgDMyUotqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyaJJsuEIjhiSkOIOXV4CtRz5HyCMEHlI8AHO3SSzAs=;
 b=ksxbN+rRlKqxwOPxwwE49FxKahxIpBsj+j+wB3Ko/lwkM3Igcjarm80c2/xV4K5wOeK/U+UbsuPbyFBc0O7orri2MeWeQdi0yTuNyI0d0JdWrkT6XjIkK9ZP3invoF2dq/xwoKsrH+5uEH8xLLWD/gb7jBPCNEWvwlHWxxpnuP5CfsVZOoPDQqG0Zb2dZbTOaqqC4vumM96v/856YYeHxgdV+4AvNsak97c1L8AiaNCHah/yTQ2qCpApeUGNAhxYCudBniCRcoIW39fv8zAWWWuVUCVHyMig9sgUlGK8BXHsDfejlDuBWZvMccnCN0eEgjahKI48qY8s4eeDfJhYiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 22:03:55 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 22:03:55 +0000
Message-ID: <a3caf088-3a47-4036-85b6-906141f6b17f@nvidia.com>
Date: Fri, 13 Jun 2025 15:03:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: idxd: Add Max SGL Size Support for DSA3.0
To: Yi Sun <yi.sun@intel.com>, dave.jiang@intel.com,
 vinicius.gomes@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gordon.jin@intel.com, anil.s.keshavamurthy@intel.com,
 philip.lantz@intel.com
References: <20250613161834.2912353-1-yi.sun@intel.com>
 <20250613161834.2912353-3-yi.sun@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250613161834.2912353-3-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25)
 To DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 656cdb82-a27c-4934-b768-08ddaac630c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWN5c0lCNWg4RzRsaExobXQ2NW5SUHhtMXJ1MldFWHlCUmgrUExEMk5SUVlU?=
 =?utf-8?B?WWFHZDJoWjY5SVhZRzFaUDViQUExckVmd2dNTGpDMkkyVGI2VlRjTFNCQXNV?=
 =?utf-8?B?MzM5b1VWMU5LSG1SRWRISm1Va2pVYlVqN3hlbUplSUd1L2JlbmQ0WnVjMWZm?=
 =?utf-8?B?QXZRSUxBbzROTkdqbEdiQkpTeTBYeUR1ZTFsQ3Y2MXF2UEZYbGpiNmtEclVp?=
 =?utf-8?B?N2l5NnlyK0cyejR0Rjd0MHRXUWI3UEs2T1dVc2xzYnJLUjlNSFF1aFFTa1hH?=
 =?utf-8?B?REwvaGhNV0gvWmtsa29oVWFyV0JWQ01hb2liQUlsYXlrNThFaFVIUVJMMUVF?=
 =?utf-8?B?NmFpV3RGYlJnNy9ralpkNklQSUsvMjZYcnlrcGpnUFhlOCtZaVlMUUM5UmNL?=
 =?utf-8?B?czl2bXFHNHJVaW4yS2p3WFVpa3RRTk94WnZjZGI5SVhIS0RIVCtPU08yK2ZH?=
 =?utf-8?B?TTBQYmpRTUdKWm8rN1docms2VXdxQURBZlFpSHNUcVM2YW9EOE5oMWpDMXNL?=
 =?utf-8?B?UEl1ajZxdUFzUjFOSFo1a1luRlNJbHBZd2dQZ0ZRQWVyZE5rZDlkNC80cDdD?=
 =?utf-8?B?RzZTS3N4SGFjRTFoQStLZGViNTNqNi9WYkU4L2xNc1R0L1I5YUxnWU9JMS9P?=
 =?utf-8?B?WEZuWXg2aWVWUG5IVThRNk5YazhCOFBrb2pRSVNOV0ZPcUxDa0hpaHduZHBt?=
 =?utf-8?B?UEdqeHNMV1lEbEJ4ZDF1WktXTFZQb3FYaEx5dFBxNXNCUGJRVmhiMnNGV0R1?=
 =?utf-8?B?b2hkR0MxRzd5YVVSYW93cm00ZmZYSU00UXlya2w0SzFQWFplbHpGSkUvZzV4?=
 =?utf-8?B?UVp1UExEV3hJaHFpUjVkZVYwcVRjeDloUjA5ZTUyODBwWGc4YnhXSHNOdkZG?=
 =?utf-8?B?ZXpoQityV2FjOEpScHBvVHk2OEJ1YlJXaHhINURDZjNxVTd2TURTemdzNlRs?=
 =?utf-8?B?c1BZNUpXSFN0WW45Ym90alVpUUdlZWNuQktWOWtCcnZmMTZOM1h6ZTNybXJ5?=
 =?utf-8?B?MThQY0dyNm5adjhJWm81ckFSdUlBWGh4cnM4aXNOUU12MUwwd0FoZzl0OTRw?=
 =?utf-8?B?d0U4bjM2bnVOVk5ycFdjQ29UbVNCR2JoOWxGeVc0emxHR3hXbTlNR20yc2hv?=
 =?utf-8?B?SU1zamFGT0hOWnoySG9iT0prbDZaS0w1UVFaYk1jUXdoaHNkUkVXZWdBMFZF?=
 =?utf-8?B?ampydUFQa2xMZElEOFZSRkVnMUx0QWZJcVZVd1d3ejdnWXQrOEx1UGs5UWl2?=
 =?utf-8?B?Si9NQkltdlEyTWRxeWRrQkd3VVoyMG4vOHRaNFB0c2xnN3BTd2pxTHZWb2N0?=
 =?utf-8?B?UjMzam1PSnJrK3U5ci95c3lPR0FqRTF3NDdMWThvZ1M4Wm5NS3EybGVKZlgy?=
 =?utf-8?B?S21jeGlMelZKblMrYkV6RDY3aE5pem1TOTdBK2gxbzJCRGN4cy9qc3JZeU9t?=
 =?utf-8?B?ZDNZMmJBUVNURFp2Rzl5RXNVbHJpTUpESHNlbnlZNjRTT2J2Wlg2Tk42SWdp?=
 =?utf-8?B?ZWRvUVhXMHJURDZkSFpLMGhyNU80ejFEdE1CMVo4cVNvY21ZZHJPTFUzdEhE?=
 =?utf-8?B?bkhINit0cnV2OUJHWkcvbDdUeGkrT011SzF0RzZMcHNBSkRtV3RYME5XYzBZ?=
 =?utf-8?B?SmdUZHp5eDNsNUFobVA2NkRsYzVPVHJPcENFSmM3RldBRDVWUDVlKzc2R0s1?=
 =?utf-8?B?Y1pQZWdDalFSUHY0b1UzSGluS0lCcEVrRE9BR0FXRDNWbG84R2NtMStsNkha?=
 =?utf-8?B?U202dzQ4N01rYkJPQ1hmZWtxVFExcmNEUWNMZE1jQWJZMmZYcTRJeVFGd0ti?=
 =?utf-8?B?QlZ6UjVteEMwNlArZkJaTTE0MFhQdVpRaVRXV0tKR0VBOEg1dzQ0SFJIcEto?=
 =?utf-8?B?ZGJDKzdheTIvYk12amdCUklEYjZMWHNUcUI4ZURKR1ErdEg3bUI2eDlBQ2Zo?=
 =?utf-8?Q?6nw2gjXkxvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDRKWmNkL2dqQzFCdDdqUzNqR1Y1eHhmTURrVXozN1BUb0lSblBSY2MwbzFa?=
 =?utf-8?B?dk4wSkRXS0pleHFNeUs3K2ZlSFliL3U3SHFLdTdRZXlrVHZaRnpFOGEvMDVp?=
 =?utf-8?B?aG9mREFMa3dWZmVkQTRvWUtMcWszQWF1MjhUdmZKTGxYelBkdWRFUnV0dDl2?=
 =?utf-8?B?VzZLREVuOG9tbGlkQjVyQXhJUkRscjlqYjlCalB1aUpwVGdPdm14N0NuZG56?=
 =?utf-8?B?WGdTMGFCNEZnSFNCdVNOQXhRT0Q1eDdlK2hwY2FpT01MNzB5SENGNXZzeTBE?=
 =?utf-8?B?UjIwc2tQZTRDbG93c1VjU29uNnFnRGhabWVTSWk1dlloeUNkT1cxcjdDby8w?=
 =?utf-8?B?b3pkZFpVZEdBZi9aTzBNTVpPUW9pazRXN2UxWVltZWJXY09ER281blFyRFFo?=
 =?utf-8?B?NUhUZ3N5VlRQVWJCUk1hNjA5bnp3ZFlSdlNCZ09renkxZGtPS0lyeEhQcTYw?=
 =?utf-8?B?VnRualRCTWlaYXBXenI3ODYxR2dKcnhyU0NPenI1NVR5LzdBTGNFb3hFS0oz?=
 =?utf-8?B?ZlRvUGg4UmE1UC9tenZXL2Q0ODk3aTFXUGJIL0EwcHpPcEpkazcybDZoUkxH?=
 =?utf-8?B?aGNMT3duVEFyNE13NWtpclh5bldDbHBrckM3Y2cvdVU3VTkrWlZnNkEzeGkv?=
 =?utf-8?B?d3h0VDFZYUMxd09meVVuWjQvNnl6L1hlcE9kc1pETXpCcjVRK3orMThtMHF2?=
 =?utf-8?B?U0hmaktYb0pvc3pNR1BkTENZK1FLSWNqaHhDQUhwWnJsL2lDMjJGQlpvdzk4?=
 =?utf-8?B?OHp3Z3RuV3VjaFdXVWI0SGg3R2tTZ0FtOVdKUFJxMDZZZml4d1E1YmxLWUp4?=
 =?utf-8?B?OGhWRFU1M2ErN3lneTZxckR4ZWM2bUVKQjZ6RklZOFJydVJ1dUlrYngzblFk?=
 =?utf-8?B?V0lDZ3JwdG45S0NxeWJMeUJiL2h1ckNpVVdqOTUyUmJFbFZUTHNPS2NpVlJn?=
 =?utf-8?B?NzJsdFNwTlV6MmdXcDFBbUpyUFJ1bXkwa2pUZkZoSmtKR3pxZ3BVeFBPdmh6?=
 =?utf-8?B?SkowdzYvNFF4UnR6ZnZONmZYa3ZDdHI1VHZZZHAwREp1N28rMVArTWFzZ2Iv?=
 =?utf-8?B?WFVRTjJkeURzNTBhUndvOE5vMW5qUUlkYXVpSmR0Y3M3QzBDL1ZsWHFTbVZD?=
 =?utf-8?B?cXAxZWppMUN3YTNqVHRTeG9KcUtCRThLalJOUXczeWNoOWoybmROZEdtMElz?=
 =?utf-8?B?enAyU2lyb1o5bzRsaCtzQ0x4SnV0VUxtNllJakhaUnBiWkdGRG0rV2pqUlpQ?=
 =?utf-8?B?SFVCRE8vUXg1ZFpPMDRXT3Jkb2VtRkxTanUvRTR4YmJaaUh5MFlER09UUm5Y?=
 =?utf-8?B?SzM2OVdTdHM0RXpLdkYxci80czlaT01rTTZUc0x1UjNvNTVGakpISXFTT3lH?=
 =?utf-8?B?dUlsRHliRWJLWHJvV2MxZVhrUC9oRW5rOGNzVk82RFpjaWJIbzQrTUFNdExo?=
 =?utf-8?B?d1pxQTJzV29iTDBtOUU0MzZQOVBhb0FnbHVoWmlPR2xIeis2M1h3RHRHSzh4?=
 =?utf-8?B?VDh5S0RlRHRRa3J4M2Rhblhud2hORWZ2YWR3bXc2bHkrQm9XR0hsaFp1ckd4?=
 =?utf-8?B?eFUvWVRITVMxQ3ptMUF1OFFZVmRVNnV0V01NYzFzdjFjRFViK0YwK3BmVmFN?=
 =?utf-8?B?TTNCaTdqVDNZbHhYWGpJeWRZbmI1Rms2YUpqZFhvaTVhZ2w1d0cwWlVIWFJt?=
 =?utf-8?B?ZTN5eWdXejZhRVN3Q2tIN2ZOYVBCQ0tLbHR4YzFuQWtwakY1R0JoNXQrd1d6?=
 =?utf-8?B?blB1dTlyQWkrTWc3SnBsajFVMFlXTVMzUjJGRThoYjFzLzVCUVNLait1aTdK?=
 =?utf-8?B?d1h0eS9YeThIUHM2djNoUTZ6ajg1WitoL0RuK2RNS254YjVqSGwxMllNVmRt?=
 =?utf-8?B?OEU5b3FrVGk3TXBjcUFnYjFaYnIzRmRpODg4amkwV3kraUhUa1VqdGJKSk50?=
 =?utf-8?B?MC9vQ1l2THp1Ulp5enNQaWlHRVFBUVNIMjNkaWN0QUhWeHFBYnFXaHNjT1Yw?=
 =?utf-8?B?TUZpckRpNDFNTktkanByODBKbXZZWFMvdmw5Z3NtbDJ3c0VZbTJrNXZFaXJ0?=
 =?utf-8?B?VjFPVVAxcTRhOU1YTk1hMWhMenYyRjd6Y2lsaHN5eXBtNGdPMEJ5M1I2R292?=
 =?utf-8?Q?Ld33V1aXqEJxpylJBQaZBtCpV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656cdb82-a27c-4934-b768-08ddaac630c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 22:03:55.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lq0h4y3zGeDIEBaPJRKICvN3J16KcXset9cyRt8H7nDr5vZBrL/xZd+WTBzM404RFWhjCm3YMjCuMP0FaVNFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

Hi, Yi,

On 6/13/25 09:18, Yi Sun wrote:
> Certain DSA 3.0 opcodes, such as Gather copy and Gather reduce requires max
s/reduce requires/reduce, require/
> SGL configured for workqueues prior to support these opcodes.
s/prior to support/prior to supporting/
>
> Configure the maximum scatter-gather list (SGL) size for workqueues during
> setup on the supported HW. Application can then properly handle the SGL
> size without explicitly setting it.
>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
> Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5cf419fe6b46..1c10b030bea7 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -375,6 +375,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>   	memset(wq->name, 0, WQ_NAME_SIZE);
>   	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
>   	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
> +	idxd_wq_set_init_max_sgl_size(idxd, wq);
>   	if (wq->opcap_bmap)
>   		bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
>   }
> @@ -974,6 +975,8 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
>   	/* bytes 12-15 */
>   	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
>   	idxd_wqcfg_set_max_batch_shift(idxd->data->type, wq->wqcfg, ilog2(wq->max_batch_size));
> +	if (idxd_sgl_supported(idxd))
> +		wq->wqcfg->max_sgl_shift = ilog2(wq->max_sgl_size);
>   
>   	/* bytes 32-63 */
>   	if (idxd->hw.wq_cap.op_config && wq->opcap_bmap) {
> @@ -1152,6 +1155,8 @@ static int idxd_wq_load_config(struct idxd_wq *wq)
>   
>   	wq->max_xfer_bytes = 1ULL << wq->wqcfg->max_xfer_shift;
>   	idxd_wq_set_max_batch_size(idxd->data->type, wq, 1U << wq->wqcfg->max_batch_shift);
> +	if (idxd_sgl_supported(idxd))
> +		wq->max_sgl_size = 1U << wq->wqcfg->max_sgl_shift;
>   
>   	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
>   		wqcfg_offset = WQCFG_OFFSET(idxd, wq->id, i);
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index cc0a3fe1c957..fe5af50b58a4 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -227,6 +227,7 @@ struct idxd_wq {
>   	char name[WQ_NAME_SIZE + 1];
>   	u64 max_xfer_bytes;
>   	u32 max_batch_size;
> +	u32 max_sgl_size;
>   
>   	/* Lock to protect upasid_xa access. */
>   	struct mutex uc_lock;
> @@ -348,6 +349,7 @@ struct idxd_device {
>   
>   	u64 max_xfer_bytes;
>   	u32 max_batch_size;
> +	u32 max_sgl_size;
>   	int max_groups;
>   	int max_engines;
>   	int max_rdbufs;
> @@ -692,6 +694,20 @@ static inline void idxd_wq_set_max_batch_size(int idxd_type, struct idxd_wq *wq,
>   		wq->max_batch_size = max_batch_size;
>   }
>   
> +static bool idxd_sgl_supported(struct idxd_device *idxd)
> +{
> +	return idxd->hw.dsacap0.sgl_formats &&
> +	       idxd->data->type == IDXD_TYPE_DSA &&
> +	       idxd->hw.version >= DEVICE_VERSION_3;
> +}

This is not safe on DSA 1 or 2 because the first check 
idxd->hw.dsacap0.sgl_format is an invalid value on DSA 1 and 2.

You need to change the order to this for safety:

+	return idxd->data->type == IDXD_TYPE_DSA &&
+	       idxd->hw.version >= DEVICE_VERSION_3 &&
+		idxd->hw.dsacap0.sgl_formats;

> +
> +static inline void idxd_wq_set_init_max_sgl_size(struct idxd_device *idxd,
> +						 struct idxd_wq *wq)
> +{
> +	if (idxd_sgl_supported(idxd))
> +		wq->max_sgl_size = 1U << idxd->hw.dsacap0.max_sgl_shift;
> +}
> +
>   static inline void idxd_wqcfg_set_max_batch_shift(int idxd_type, union wqcfg *wqcfg,
>   						  u32 max_batch_shift)
>   {
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index cc8203320d40..f37a7d7b537a 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -217,6 +217,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   		init_completion(&wq->wq_resurrect);
>   		wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
>   		idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
> +		idxd_wq_set_init_max_sgl_size(idxd, wq);
>   		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
>   		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>   		if (!wq->wqcfg) {
> @@ -585,6 +586,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
>   	idxd->hw.dsacap0.bits = ioread64(idxd->reg_base + IDXD_DSACAP0_OFFSET);
>   	idxd->hw.dsacap1.bits = ioread64(idxd->reg_base + IDXD_DSACAP1_OFFSET);
>   	idxd->hw.dsacap2.bits = ioread64(idxd->reg_base + IDXD_DSACAP2_OFFSET);
> +	if (idxd_sgl_supported(idxd)) {
> +		idxd->max_sgl_size = 1U << idxd->hw.dsacap0.max_sgl_shift;
> +		dev_dbg(dev, "max sgl size: %u\n", idxd->max_sgl_size);
> +	}
>   
>   	/* read iaa cap */
>   	if (idxd->data->type == IDXD_TYPE_IAX && idxd->hw.version >= DEVICE_VERSION_2)
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 45485ecd7bb6..0401cfc95f27 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -385,7 +385,8 @@ union wqcfg {
>   		/* bytes 12-15 */
>   		u32 max_xfer_shift:5;
>   		u32 max_batch_shift:4;
> -		u32 rsvd4:23;
> +		u32 max_sgl_shift:4;
> +		u32 rsvd4:19;
>   
>   		/* bytes 16-19 */
>   		u16 occupancy_inth;
> @@ -585,6 +586,15 @@ union evl_status_reg {
>   
>   #define IDXD_DSACAP0_OFFSET		0x180
>   union dsacap0_reg {
> +	struct {
> +		u64 max_sgl_shift:4;
> +		u64 max_gr_block_shift:4;
> +		u64 ops_inter_domain:7;
> +		u64 rsvd1:17;
> +		u64 sgl_formats:16;
> +		u64 max_sg_process:8;
> +		u64 rsvd2:8;
> +	};

Ah. The fields are defined here. I would suggest the fields are defined 
in patch 1 because:

1. Reviewer (like me) may get confused when reviewing patch 1 where 
dsacap0 doesn't have any field but is defined a union.

2. There are fields that not max_sgl_shift. So those fields are 
irrelevant to this patch and had better to be define in patch 1.

>   	u64 bits;
>   };
>   

Thanks.

-Fenghua


