Return-Path: <dmaengine+bounces-4293-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87183A28B18
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 13:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB19318845A7
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D258F5E;
	Wed,  5 Feb 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="erp8tyNB"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C99623;
	Wed,  5 Feb 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760326; cv=fail; b=JFW8De9WTmT+1CEA4VVfeDyk9c9K4zrXKtEWD9OU+r/ikCQqpfBDX1lGqTLnACmcbtOZAYjAeBDv5AH95bZFeHoGlpHpbRwqxJ8dSGnH4rGqoaHPJluMOGcSVTJTWWTbaZMq5RC+BNq5kIo9M2g7/GWCO1HgucdqQaVsouQoca0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760326; c=relaxed/simple;
	bh=wQy9zBw8lH0Vjw62z1gW0wGsuj8O0w99+44E1wo7+Vw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SPczmO41Ktw+clwPU+fR5BXTd5mqE05vHS165vbJUsUZZjq3QCXf1qYAAz3wNY6VTCOlFnjXYs5T9Vx3OEvQhhODlcpPk+0xHWeMde7HYxHyq4czQHLphQaeGRV7NLiu6b87VhquEMIYmDNtsaf9t2WALtz2crBLaFlwaF1dl0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=erp8tyNB; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPc4v58Y3Ihgf7xFpNsdJddC3aB81xePxo3TnZxs7u6YSSNAWeYFDlE2snp/i5gLdP8oLbdHYn7ml+tPmLHbeV/i6nArMJgdRI1SFnDrdFrJbXul9ayU9Zj4/yummpRIEulO/DswDfn1imuQSlinlTSgpSg88uW7WPGfEMNXtxfxZDNUtSymkj/5m2WkM7+jVU3jYhZ0aRnZudK8v1m8WhCynmGNW6ym49g9Alu6rsZMaGeg4NskzmzThnwV121aJvF14z2iDSB4bNwHe134/t86t4h5WVIHBBbwkXsZyQz1X9+Ye/pV5NlwPgy9cOxT4344nw3FMzPwQCWG0qDydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIP0x8xZsjgbvcjx3n2kdLj2pTAyKIwqn0sMlGmj4LE=;
 b=bStFRI6Gqcv/QLMq9MlM1wTnkA2ME3xWRRSKg5boodk2mkcSyK3M3/tLHJyE6NeM8ruLVgXNgUxisxe3QROPlIgi7poFCb0NcfETLUDgsj1F/xABV8ySpWi+h8bLfgypPvtsJOCY51zPtpPZmRo6kfxluv/91zJaQDhapnojn7fCwjjZl5+XGcKW1oTtjUKKyOaxpL2GYQk0gBpDZ3QSzZmfGRTlZAPtpcvDrp1OoHM/mO9JV5Vl2fVnaa6SDQedM7YjTitu109Hck9i7xWl8USN8Vod7R2BgXEjHQr7ivVJNdRT3gUh4YOct4iss5+r+0FtmlBvwcBrBpcVaBa3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIP0x8xZsjgbvcjx3n2kdLj2pTAyKIwqn0sMlGmj4LE=;
 b=erp8tyNBM7gb3+bO7YqDji57bVWYFeF7sbL3Pcc4dcka+qg+F76M73JswQtYzjEqSSxfVdKLBXWoI6qSwNZsG/bsoDsef9xPUccfQ746Fdhw1p+iJ8hFnq50XWHeTLNybD7GaRAPfSI8tlNM4UPZ9n6tApn4+hCwU/mLljMiJsyRFOMRRlKih7p3mn7jNtos83FZMVrm3sx1J6e0L+3lAAVgmgDbmoeyuolNw/h5IgnHCGREtwAkJNpVR+DGM5vZU8LnWwz2Li2ud1kjx+tME3prOw/8EnCdrQedkQbnbNW1UwZCj5QMWTQ2UR9/5AMQ/8ejuPjgTAbdpdoO3TX4og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 12:58:41 +0000
Received: from DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b]) by DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 12:58:41 +0000
Message-ID: <84c4c672-fc17-4f75-b3ce-388b987d32ab@nvidia.com>
Date: Wed, 5 Feb 2025 18:28:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dmaengine: tegra210-adma: check for adma max page
To: Jon Hunter <jonathanh@nvidia.com>, vkoul@kernel.org,
 thierry.reding@gmail.com
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-3-mkumard@nvidia.com>
 <61a3c7e9-f3cb-4bc2-a10b-5e44fa2cdedf@nvidia.com>
Content-Language: en-US
From: Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <61a3c7e9-f3cb-4bc2-a10b-5e44fa2cdedf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To DM4PR12MB5101.namprd12.prod.outlook.com
 (2603:10b6:5:390::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 793368c1-6357-4ebb-3c68-08dd45e4d07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aStVM2dJRnp6TVdRUDVMSkJISXdYRHZWaTVGYVd4QnFIalU4ekVnSW5yMmZj?=
 =?utf-8?B?cjN1WmdyTXJDK1p5NytxN0tXUGlWM05DaGwxc3lkN3hWa3hsNjErUmVGUUtL?=
 =?utf-8?B?TEJTRDlDUUs1b3JFUzltWVl2dVZRWGdnNzFkM3F4dGpycDdZOEtoRlRKUXVM?=
 =?utf-8?B?eC8yZjhFbXRLTWRlWjJYVS95NnprS2tDb1c4ekR2NmRWMXVWc3pLWUpuRmsx?=
 =?utf-8?B?cmh0eGVUYi9DYmE5T1UrSnBWK08wOHVmWHd2MWVqOG13SEhBaEkvZ3dBMG84?=
 =?utf-8?B?VDNyQnovbWVjTlh3WVp2UTg0ZDZmMmdORFpDeTVnSmdoOW5UVlc1Q1VDV3FP?=
 =?utf-8?B?RVM3UFZGdEdPTzI2TTZlbjdQYW5FQUdSQ09XZWJQK3dOM3NBbjJyeVpuUGkr?=
 =?utf-8?B?YzJQaHFvSlI4Q0t4SGNpdk9zSTY2UG9wbUphUDAxNFYzK0hGT1lIQ2NkQS9G?=
 =?utf-8?B?Y2lMZHJObmFMVUx3MCs1b3FPMjJuYlplUUJhdEdrS2hHVzlCOS9zNlh1MXV6?=
 =?utf-8?B?b2RZdGhSdC9mRG03dVoxVGxMRHk2M2VxR1h2amNWWXl1d0tEWCtzUFdxbmlW?=
 =?utf-8?B?N0lTME43TDRxdFNmaWVUTVNvcU1SMUNNZlZBRzBwNVN6WUUrRlV2UDVtdkNY?=
 =?utf-8?B?MGhxUzFFMThyV1p2QmFaK20xN2pScFlUV2FSb2FDNHNmN0xybDQ4RHJ1enFF?=
 =?utf-8?B?UGpBUnNhN0VVUmRoN0tDSmVwaS8zTEVHSHVCWjZEM0V3c2RpbDBwdEN5TDl1?=
 =?utf-8?B?YVVmZnk2K3Frdm1MaHZ1N2EwRUFNWmxKa1NqQWFwY0w2QzB2Nkw1S0xmWXlk?=
 =?utf-8?B?dFJRbVhRZFdPNElGQUdXWHhkdzNBWG42OHBFUHlaMkF0NjdiL3RSK2szM0Jn?=
 =?utf-8?B?WmVjNXZNUDdkSS9FSWdsYTR6d1QzRG42b29BV2VUelN1RUhucUVyYkdjRVhz?=
 =?utf-8?B?d3ByVzBYcUYxT1VzSzJZV1FTNlpMMDBhbFlzK0ZEaFI5alJ2Y3JRR2RXLzY3?=
 =?utf-8?B?Wkc4WFM5djRESjZyQnVqb0ZqMFJ6b1ZsNk1zTzVyenJib1FWUVdPSTJSdDNi?=
 =?utf-8?B?eThLOUZxTnV6eUJqV1V6NHZFK01GckdsQ0FiK215emlWajluOG1hUCtGOEo0?=
 =?utf-8?B?bC9pYlZSSWNvZ25JOE5GRFEwSUVxVjc5Vy85VGZrZnZmRStpMlhmYk1VRXQ4?=
 =?utf-8?B?MmpKWGJmaDNQRW9TSTV2b0w2S0hBWkQwQU5ZUlFycTB5TGhhVzNYYUV4MVd1?=
 =?utf-8?B?VDlXOWphNHlwZlZnZjlVQXFpaUI2UEZiY2k0OXE5N253VGEwdi9tWGRiaEMw?=
 =?utf-8?B?bFpJTDhycEFJRGREZlFVeU9lRGNNZmRRS0l3anhaYkdXNWJsMHJhcTdoamY1?=
 =?utf-8?B?a2F1emxCUy9aQVRXNzVOV24zT3pJZWZlbjJLQkVPaUpEMUJ4SW5UeEJuT29n?=
 =?utf-8?B?bDJXT1pDOVNuV282c3NUVmtsbFQyN1hPT09FcEJaRUgxT3pqWjF4aHRtK090?=
 =?utf-8?B?TzNJUVc2d0hIWmlHUUxTckhFb2h2bjMxbkJQMmdPUHBlaWZXMlNicEM1Ymo4?=
 =?utf-8?B?eWFSU0d6UzJjNXBmVUVBKzRDMzR1QnpEdGhER3pxSW9mK1ZNcUczb3FadW1j?=
 =?utf-8?B?THNmREhhTzhGWGx2T1g3V1Q1bmF3OGNJZm1zK1NNVGlRalVRVjViOW51Wklm?=
 =?utf-8?B?OU9KUkhOUGhvWXp2emhPMTZEQnlwSENTVFZ0M25zQ1hmQzBoa2pRd25rVVBS?=
 =?utf-8?B?UTVIdkRMQUVZcFhqL1lpSjNCRElvZUhtWW1yUzFTRHVOR1IzZHg3ZncwN2ND?=
 =?utf-8?B?M1J1dE91MGEyZE9SVUZhdm1WRFY4bitUT21jbWt4NlBRRWpEWmM2dE02RlpO?=
 =?utf-8?Q?A6wMKHVb6bi/g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2E0QXkxdHNmTEZDZFFpb0g5Nm5ZQlFrR0ROSmxVSFVoWlJhcGpEQnhVcDVF?=
 =?utf-8?B?UTBMcDhsSnRrbmE2ZnpVOTZrZzJCRjJqc0lLTS81RHg0eFpSaE9QZUl6Nm9a?=
 =?utf-8?B?ZTJmckNkVXlzK1dzRW5kSFcrWGJ0WEgwdGdNZDAwTjJsaG1DeGMyTVNuMStu?=
 =?utf-8?B?KzJ2ZTVCdGJJZlJ6NlhjMXd5LzJ5MDN3YSt6YjUxMTNuamcvQmtRVVBicVp6?=
 =?utf-8?B?TlhtMVZ6cmJROVFBZ1dmZ2FROGV6MTVFMWNLYm1UQU50U2hWNVQ5RVVTN0E1?=
 =?utf-8?B?eG9TUTRNMVFFUFk2dnNId0p2S1ZBdnVuTU11VEp5VzNSM21YdHQ2M1MydXFD?=
 =?utf-8?B?bFE2R3JhSFM1aGlNODA4azFlTUZQWXFDSHZGckx0aTJ2UXBIbWJsS250Qmkz?=
 =?utf-8?B?aGFrY243cTV4WEtIVlptblJteFJsN1RGbkpmL2FsQzU2TXFhRmxGZytRaEZU?=
 =?utf-8?B?MDdEaWVHYjF3WjAvcFhtK09FeGtPbkJYOWFONVA1NmMvS01RM0RuUmYvVzlI?=
 =?utf-8?B?SVlTcUF6dzZIZ2RETUNpTWp5R2Noa08zSmdlUExTYkJSRlNVVEdWeit6UVh6?=
 =?utf-8?B?WHFBYmFPV0l6WmpwcmFqaWF0aGUvNEVBd0s4bllkQ2RCTHN2dmhmMmVXNU1D?=
 =?utf-8?B?eXpKdytCZDNySjZGY0s4bU5wUGkyR2duOFV3dUkzNnBmR2Jod3o0cTYzUVB5?=
 =?utf-8?B?bGJxSndyUUNEaGlwU3pSOFI1L25lR25XUm4wdXhTalorQWh2SVJNMmhkdFFv?=
 =?utf-8?B?UDJBdHRESXQyRmVUc1htZUNMeCtNNTI4MEwzOGo3eDdkWXIzQll6bXRoRWhy?=
 =?utf-8?B?Qm9Kbk05anNReWJBUzVEbVZRV3o0TGpzcHRlMjhUbWp4TjBGSFQwd25ta01B?=
 =?utf-8?B?b09HSTlnQVNYWmlQaUlWbm5ZU2h2RlBCbUJneWVMTmtTVFV5ODVnSVRJOEg3?=
 =?utf-8?B?dzNFM28wSEhSR1d6WllwY3NSTHdmTmlMK0d3VXRLc2N0WlkySXpOcm4wSCtP?=
 =?utf-8?B?MytzRDk4N1gzQzZyNklHZ09Cdi9TdVRHU1dpLzZzVFE5K2JOZ0MwVEI0cTl2?=
 =?utf-8?B?WEh5bERkKzhURzNtRkVpUHBKb1pmOU12SGJlKzBXejFwcW15VDU3dmc2MTli?=
 =?utf-8?B?R004K1V3enk2czBCNmFDRVlHd3RtQzZQRlphZzFYRjBXQzR4RWNMWmsrdHNz?=
 =?utf-8?B?eTBzR1BsTE5WZTNaSzVPcmE1UmQ2M2FyV3o5VDdUOFljejdKeXA0RjRDdERZ?=
 =?utf-8?B?VkZ2ZDVia3JzSlNNRjAzZkErRkx3T0NkVVZSNjlac0pNWlpTcTN3YTg2d05V?=
 =?utf-8?B?WlNMcVdlSlgwak5HamJLVWVJMGU4VkpRTnRnWU5BajVndVpEZ0JpQk1VQlNM?=
 =?utf-8?B?VFdmNHdjem5zbEZKT0lsREQ5bTlPdGh5UW1FZjNsU1djTG1Sb0I3TytjbEk2?=
 =?utf-8?B?WGcxN1RSV2tvckwxWlZFZjVvMm81MlhqNGxxYzZLNXVzSHBWQmN3d1pRVFNt?=
 =?utf-8?B?VXNoMlBRemFaRmNITE5VNjdYNUo5WXVBdUJiVEVqdlF3eTNOOTZ3dmRlM2xF?=
 =?utf-8?B?cURucHJlV2xsS1hnUjlQRVZ1UFFqSmh4NzJlUjIybzBhOC9MREZtckJVdFpV?=
 =?utf-8?B?dmxPckk4dUlGQU52YUdKcFFoVnpRZ3cxcG5sdmR0TjhMTGI2c0M1cWFLZSsx?=
 =?utf-8?B?WTlteGkwbDc2cEh0SURkd21TR2Y3cWZ3VUFWQXRpRS9GR09iT1BzNFhjYVhi?=
 =?utf-8?B?YXA1RVJ6NDJwOUIxWFFGaWUxeDNMMGo1L2FkK0s2OHd0S0g4UEVlbXN4MVg4?=
 =?utf-8?B?UkxCSEVlb2VCS2xzbjFtOHdlSEZiaWVpam1kaHVML0pKK2s0MHB1Z3Q3NTF5?=
 =?utf-8?B?SC9oVSs2UE9PQUtsR3BETk9Yem5DY3VxZHRhcUNPcW5FWTJYcEt3UVU0Sldi?=
 =?utf-8?B?NlhXeWtWcEM1aGkrZ09QekFiYVpoRVZKOVl6VHlGQkt6SHRieUowU2g2Yy9j?=
 =?utf-8?B?YnlWcWVlc0tOU3hnM1VkenhoSzdGM3J0SlpmV240U09WaDVJajEyNWplTXBC?=
 =?utf-8?B?a2FQSFJNbHlFcmRLUUU4TE1mQWo5cnMyVmZMMzJwZWEwbmlISFg1by9wamQr?=
 =?utf-8?Q?0W/FbC12MEfNzwk1zyzSEsWAm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793368c1-6357-4ebb-3c68-08dd45e4d07a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 12:58:41.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIDSJ+cKCKFoUQ2n9qvyelA8v6qnopHSn9RU7FgexBtGrEaIfqMXvgyL1zqs4n4sGM+fF/h5qzCwHC8CpjCvaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414


On 05-02-2025 17:10, Jon Hunter wrote:
>
>
> On 05/02/2025 03:31, Mohan Kumar D wrote:
>> Have additional check for max channel page during the probe
>> to cover if any offset overshoot happens due to wrong DT
>> configuration.
>>
>> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
>> ---
>>   drivers/dma/tegra210-adma.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index a0bd4822ed80..801740ad8e0d 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -83,7 +83,9 @@ struct tegra_adma;
>>    * @nr_channels: Number of DMA channels available.
>>    * @ch_fifo_size_mask: Mask for FIFO size field.
>>    * @sreq_index_offset: Slave channel index offset.
>> + * @max_page: Maximum ADMA Channel Page.
>>    * @has_outstanding_reqs: If DMA channel can have outstanding 
>> requests.
>> + * @set_global_pg_config: Global page programming.
>>    */
>>   struct tegra_adma_chip_data {
>>       unsigned int (*adma_get_burst_config)(unsigned int burst_size);
>> @@ -99,6 +101,7 @@ struct tegra_adma_chip_data {
>>       unsigned int nr_channels;
>>       unsigned int ch_fifo_size_mask;
>>       unsigned int sreq_index_offset;
>> +    unsigned int max_page;
>>       bool has_outstanding_reqs;
>>       void (*set_global_pg_config)(struct tegra_adma *tdma);
>>   };
>> @@ -854,6 +857,7 @@ static const struct tegra_adma_chip_data 
>> tegra210_chip_data = {
>>       .nr_channels        = 22,
>>       .ch_fifo_size_mask    = 0xf,
>>       .sreq_index_offset    = 2,
>> +    .max_page        = 0,
>>       .has_outstanding_reqs    = false,
>>       .set_global_pg_config    = NULL,
>>   };
>> @@ -871,6 +875,7 @@ static const struct tegra_adma_chip_data 
>> tegra186_chip_data = {
>>       .nr_channels        = 32,
>>       .ch_fifo_size_mask    = 0x1f,
>>       .sreq_index_offset    = 4,
>> +    .max_page        = 4,
>>       .has_outstanding_reqs    = true,
>>       .set_global_pg_config    = tegra186_adma_global_page_config,
>>   };
>> @@ -921,7 +926,7 @@ static int tegra_adma_probe(struct 
>> platform_device *pdev)
>>               page_offset = res_page->start - res_base->start;
>>               page_no = div_u64(page_offset, cdata->ch_base_offset);
>>   -            if (WARN_ON(page_no == 0))
>> +            if (WARN_ON(page_no == 0 || page_no > cdata->max_page))
>
> So no one should ever specify the 'page' region for Tegra210, correct? 
> If they did then this would always fail. I don't know if it is also 
> worth checking if someone has a 'page' region for a device that has 
> max_page == 0?
Yes, DT binding specifies "page" should not be used for Tegra210 and 
above conditions takes care. I believe above condition should suffice.
>
> Jon

