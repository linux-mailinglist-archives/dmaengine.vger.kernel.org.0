Return-Path: <dmaengine+bounces-4299-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9183BA28DCE
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 15:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355EE3A9229
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B07B1519AA;
	Wed,  5 Feb 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lL98Po9f"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C81F510;
	Wed,  5 Feb 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764226; cv=fail; b=CklCr5g/xWksAKbIWBe5wey15MyyJT6KLDp5PFRKUrlebJ1nibnX/Q7V34JqxpuhPLkYrmicg7tIIPFM7tTUQrPJn4d+/L61uIg7oJDxFMTzhZkIVpfpTBmQt3RbuDwtW+4pJi+85dF6vuJrcyUbMWZ/Jxnw5DNvRmoNGK6URuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764226; c=relaxed/simple;
	bh=3iR+K4q4St2jSNvpYcpTdSx1G6sTCntGeC+hzPVUSAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pi64EuQxXWHCRjg5S0n8ohgjK1XggRjpA+KeXK1m2AklxAxDJozIZHp6ar8dnoz6OgE3TJnpDo8N3vaHJVKUKZ+C8DJs/3SEELc9yWR41rYbZ8gMMADPbaXFUIq3t1JwxH3vMOBr7Rovs8Bu1RdBW8BJhyivIJ9MEvnUapjZaOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lL98Po9f; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cu2cq0UyNPRI0Xi4DrhBqipsTr2nJPHHa7o5y/yVgs1CX0KPSh6Z2vOrAhBYHqOCPHaX5Y1LS7pvslRncIANNvd7yZs0wBUYAEmOlfFqATSjpxJ8hTyYDZDufFnoyHeSr5ux28XWIkq7rk8A0Lu/5fZ8Y5kN1uS2UhMPWNtRTj/qUjGPDF41QcRa83G2psJhMgE1ALWIONKPUFQLCd3LpEw8hu5B/ndDLSzXi+YC2MxkMLsVTsSvq16xPD5XfGH2WfdlIezLoyMLwEfp1bww1OxX+2SKRFdwm0SP49NRrkvpkNLxQ4eVAqAcXx+e/2gEQ1MO60ts6qP19H8oKO1AsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wcWkiJC1Nc/qA198unI17Ml+1G2U5gQXd75EYlYLho=;
 b=debw9ndgtLD6TTqDlPZ9yERJk7mnUvm18haPR8QHjj8SiakhTIjcoZvlFLklKWuK2Y7aJGNloYvRo9vdrJMVwIJCq5aPmlunfRcERIjsTNhq/vagHqLJ3LlDLH+i+PyxCFMV0QQUM6ZRjWW4oOzvgBCiUfcB043N3/dYsfoZ4SA7P1Z/stRdr5/d1uk6Jp4R/F7Ng2l36ihm9k4Se3eRcWW+QfTO/hoLxzd/e5nLuDXILLK22rC5ASqjlUlUGh10szSgVLQ8k3cB7r49bZfxP4ZSwHn4dFXyB06S8akXrh9jnOeTr+qdKvRZfm/wDXApwHtQX7IXzTky+OiPely9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wcWkiJC1Nc/qA198unI17Ml+1G2U5gQXd75EYlYLho=;
 b=lL98Po9fQovPc2VPpwOYxuotxPxoi7eVH/9Q0rkM82HI417ykCFZQnqbDv/r74uEp7i90o4jveISvpQvtBTvnFdO1TcUWFH6s9hbqO6aiu80DJQ6efv005gG8eoUsGjgKbS/I7UhuUmyyddIpjsnzOm84x3XQCZ5+tO9nOUuUl5XsYzM6jJwXe6UjaRQaUqs8pVMVZHENOx5owIzQWxF4OhLHu9GwgXO6bRowh+l96QKO8SFbSHuehm6hrNMg1KAFTFR8zjVtx+JUIO0ZzVucGXPssT16PwKLphMRJvgUstRI3b4R0yualOH7r+pvJOF911LQUs1Y/RjT3tSszW4kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 14:03:42 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 14:03:42 +0000
Message-ID: <d644a35e-7dfd-4eb0-a7c3-8dae96e09657@nvidia.com>
Date: Wed, 5 Feb 2025 14:03:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Tegra ADMA fixes
To: Mohan Kumar D <mkumard@nvidia.com>, vkoul@kernel.org,
 thierry.reding@gmail.com
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250205033131.3920801-1-mkumard@nvidia.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20250205033131.3920801-1-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0428.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a219dc-aa4d-44ab-1d6c-08dd45ede5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmtUYllNZXZvdjNMbTE1T2lqT01SeEpKZkVYdERmSE94UEVsd0dWcGExSXlu?=
 =?utf-8?B?UnZjZWt0R3gzazNnUE9PU3BTcHQ0UVFza0RsVU83aE5mcUJpWnpmWWQ0OXAx?=
 =?utf-8?B?TGRaUUpWKzh4cmVvTXk5dWlCbFZlendldlJnT1J3Qk5FaDNwNG9DOThxU3lO?=
 =?utf-8?B?WGx5cUVNeTV2cEoxd3pYMEJCaGpEUnVIWlVxcE5raHpEWXpOd2FWWVVvTmxn?=
 =?utf-8?B?NVVTZmhoS3MrQi9PMXhiaEx2ZlNjWjF0QjY2Y0lwOTFjQ0E3OGlZVGZNVU5L?=
 =?utf-8?B?b0NDVWhVaGVsanNvQi96MXpiMmovSlBueW5QMzdQQ3NJdjdmRlh6bjlhMlU2?=
 =?utf-8?B?ZG5hTDFqNkRNYmhIWVFuMUN1SU5sSTJHcWsyell6ejdDQkYvT2w3SnVnSXcr?=
 =?utf-8?B?c3hmSGU0cTZUQzVTT1UxSWRLbUZzZ3k1bk9GOXB2L0N6S1FrUzUwc2g4cmpk?=
 =?utf-8?B?bzM0TXg0YXRkTHR4c2h0RFR0eEtaMytuelBuUGovK2Q4Mldhb3RaZTI4OVdG?=
 =?utf-8?B?MTdtQXZKbzFCK3pRLy9WcFBqbXhrK1MxZWhUNy91RHJxZ2d5NUlUN3U0R3Fm?=
 =?utf-8?B?a0U2eGhXVTJZdHUxZzBVd3plMi9sTktMSTJMcUVxeHdWM25CeE9FWDdzeVdY?=
 =?utf-8?B?ZlhxTk1ROXQzQjJPVjhrMTZ2RGdVeVp3aFlQRWc5UEJyRlZLcWQrSHhOcUN2?=
 =?utf-8?B?WVBlY3BaMlVYSC9IQmZRajVidy9xbzEvNXRjZTA0cDQ3akNsbEo0aHdWd3F2?=
 =?utf-8?B?dTM2dUIyYU50TnIxRjFmQlhYL2VYT2dlNzhrZTFMSEVKWDF0eFoyREc4M2Uw?=
 =?utf-8?B?amd4WjRSeVZnZlIyQjc2N1FTK05HOWpXdVAvMXZqTU1zWUVZekRtNnRkcUZp?=
 =?utf-8?B?RW1QclQ3VjNNR2ZxMkVFZmdSNUo0Y3AwL1UrclFwN01XVmx5eWpUT2FPdE1C?=
 =?utf-8?B?Y1FncWNMRXVwOHNyWVZIK3pxd0VhaHp5Zk1iNWRna3pYTWNxaFhrZWtFK0RF?=
 =?utf-8?B?anFYdjdGbzlXYTNSZGlDOWJuR09BaTBuNzJMWDR6MEJBenVqZWxiRzdtUHVD?=
 =?utf-8?B?SVFDMHZtb3ZZV0VVVWpJckhueGFQZm1TWm95RVUzMkpmZnZwZktyREtUUnNP?=
 =?utf-8?B?cHR2RXlrbjFEQmYrWUhkY241RnRmMXNsMTVhWm83ZThobzJUWS8xM0tubXFa?=
 =?utf-8?B?UmF2V0hhaHlWemtJMTg0QzNoazBicjVnWWt3YVo5TUhDbXBvVmovZGx5dGQ0?=
 =?utf-8?B?Z3JLU1hSbWQvMTNKdEo0VnVya25NaUJBMFBSMzdwTHEwby81cnpISm4yUnFL?=
 =?utf-8?B?QjBhc043VThoVllPUTNraDBmb2VIZ3lNOFJ4R3pDTFdnbktCNEdSMTJyTXlk?=
 =?utf-8?B?SUQ4bDVzZlJTTGEvcS9hZGpSL1JuTTNiWmt3amxnemN2UWRVRmQ3T3paWWlP?=
 =?utf-8?B?R0tkYmtUYWdEajRFcHBPYkp2U3I1SEg4SFdIVytVYVNyVHl1UFdEK2p6N01C?=
 =?utf-8?B?MzJxMWxIM1FBRjdxbjVOWlV2Yzg2VThUR0pXQ2lHTkdCL3BtcnRKSDBhY0c2?=
 =?utf-8?B?aDVIems2Qm9RZC83TVFXOThBZXlVa09OSlJwWEZ2RWg1bGFyZStqTHhVRmxZ?=
 =?utf-8?B?TG5MaThUNCtDUHN1OGNJbGFLbVJtaGhhcjRobWFrcWt5QlhQQkRVdzk5Nlkw?=
 =?utf-8?B?NU9QRnVjeFZyMHBZbjZ5L05pTENrZkZkcFk1UW1MeldLK2lKSUJuTUFhc3Yx?=
 =?utf-8?B?azRwb1lDYkppWDRUU0dSQ0Y2bjRrNStJQ1lHV3FTU2hJOXVoaDAxRndlUnBn?=
 =?utf-8?B?K3VjT1RRalVJakM3TmlxNmMxRUlCaFNMTkRQV0V1NWZRS0xveXJnOVdzcVZH?=
 =?utf-8?Q?wTnU6w7ei0lGM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG5od0RVQUJQR2NmblBRV0dJN0JOaG1kRmxHVThTRVZyWmZHck1UVkRIYjZB?=
 =?utf-8?B?Z2NLWTBLRDNER3hkc0h1RUMwbCtwRGlpSmZ0OFZyc3o1MmpaV1dRcGZISVpU?=
 =?utf-8?B?U0UzM1JqaWp4aWhDam1NZnUxdjUvS0xMRGtnelVCZFNJVld4Q3BqY3RrbGI3?=
 =?utf-8?B?eWZUZStYZ2FielUzbFp4cHNJSlBIMU1OdjFsUmsyR0l3ZkRLY1VRS1VHZkQy?=
 =?utf-8?B?cTZqZnZiL2FMaExVMWs0Sm9IZkFHTFhmcU9YdnpBMDJNa1UwNkw4UklReCs1?=
 =?utf-8?B?cDZOQXphbFB3bjloUWVxQjRHSDZWalRqVHF6S0Z2cGJ1NFprYzhKOFFyTENM?=
 =?utf-8?B?dmg0c25FR0tvN3RaY2traWlsUHk2WVhkTlFNbkJJZk84cVFRdm5VRXQzSElX?=
 =?utf-8?B?UFBLVmJNVVpsRFc5Mkw4Ti9LM2pNT3VxNXFyK0N3eGZNT0QrdWovOW8vNHBL?=
 =?utf-8?B?OHJDajcrRnBJd1lGUkpEVWNqRFF2T0pER0ZFYllKVFhxVTRQWlJPZXdIcmE3?=
 =?utf-8?B?NmpkTFIyelp0dm1iUlM5YUFtdEtuZmpkTFJ4cW9KRHJqV2c0UVpBNDVpenNj?=
 =?utf-8?B?ZWxjL1M0V213QWFGUFVuMUQ5ajQ4Qk84bS9adW5oVjRGdy9EczFjVHZ6YUZv?=
 =?utf-8?B?N3ZrVktoa1NXa1NGQWNRK2pXYWRBYmQzdU1zMDBhcVhMc0NLRklMRGR1ZDFI?=
 =?utf-8?B?NjRNcFh2MnNwM2tMdTdIdWUvKzRCTUcyUHB5SzNJY0pubGRaWFNPWDVreXJj?=
 =?utf-8?B?Q2l3aTVHckZLNXF0ZGhVUy9IQXNpZ2RxZHoxaG1NSzl4U2pCamh6ZE9NOFBP?=
 =?utf-8?B?TUlmZ0pTWlFqWERaSElFV2dvUXZDZEZScDdJdGNMVlZQc1RYdHRJNDJObjE3?=
 =?utf-8?B?WFpBWW1RTlp6eCtadFM2Z0JVNlpZVDhEQnlQRzMzUUhkbHg3NzQrdm5oMzJs?=
 =?utf-8?B?UjVQMk4xM1hQM0tVSG9ydjk5UmMxTU9uVHUzb1U5OFpsOUhncFFDMnVCQVhW?=
 =?utf-8?B?SzAwT1RSaER6SkUzaWdWVWhJTmFBK25UOTByVVVCaXlHUlNzRU4yU2d6Znc2?=
 =?utf-8?B?bjJvSDBtaHRHYkFJdDYvYzl2SjRwSTk5RmFzWDE3V1FINkEybTREOEdjRE1x?=
 =?utf-8?B?bzVwbGlIZVFVeGxXUjlKRE5yK1Q2cHdnV1QyVnNxdnhGZko2M043NFBjT3NY?=
 =?utf-8?B?RENlR3dtUWdld1BERm1ZcWUyTkx2UWpzem9ieVdoSCtIS3ppdU1veWlSWWdj?=
 =?utf-8?B?aE40eUplbjJsS0FGT2ZaNW95ODIzYlhkSVFSMTcxbENyVlJFS2ZYRWVjbWVQ?=
 =?utf-8?B?WlN2UjNsTXo3ak5YYVBQdU1Va090YWhKUHBrSjEzVHU1NlhLKzI5VnBHZkt1?=
 =?utf-8?B?TGJkTFhRY3NXcnJJNFYrUGh6bFB2SlFEZlBCR1ZuRy9jRzhDeTVLZ3JKbGRV?=
 =?utf-8?B?ZHA0dXkzdFJZalRWek5QclovTUt6QmRicGV1SzBZNnhuQlZEeFJpWXFoMlZP?=
 =?utf-8?B?OWhoYTVqWmtJMU9XTjVaWFAwNXMvUEdNcmpueEI2TnlIelpRc1VjY1FoWTJM?=
 =?utf-8?B?d3c2NDhOV05VL0djL2FRY1VHUmtKVzNCU25Fa0hkMWpHTFNkVTFMMFRxbkov?=
 =?utf-8?B?R2lWcmJCb2JYOVBMWFFJUVBKOVE4aDVLRzlGalVmUHVEOUtpYlJYY1F5Wld4?=
 =?utf-8?B?N3FrR3hSN3Q1bURVR1M4SjJTNnBHM0hXdTNCb0dHc2p3dmhOOWRwV3NaNnk2?=
 =?utf-8?B?VldDSzVGNyt5UHdnRU9jY1VvR3dmZjVVVVNieCs1U2toUUFYUW9FYnBZR3FP?=
 =?utf-8?B?U3dTRklmeGs3MVBmYTkyVjVTRXdPWlhIV2NreTU5SmsxY1dyZ0tNUWgxVCth?=
 =?utf-8?B?K1RiQU9KNWJQMGlxMUFrS2VCK2NDdmppVEZYUjZidktzS3VCcW5xcVlxNDhk?=
 =?utf-8?B?MmpKY2o4V2M3dVkrcEMrY1AvaDQyL1BvdHJsbjN5Nndad2dZVXVSbkMrZ2ww?=
 =?utf-8?B?VHlRRWZwQ1h4VHNQdGZVQURodGtkK1NZWGpqMkdMZVFVZ2l1Z0c4NzN5bER1?=
 =?utf-8?B?WlhqUE9WNm5CSnRsaWcrL0RBY1RNY0k2YTI4eTBzTGRiYUx2QldhNTJ6T01Y?=
 =?utf-8?Q?pKAkGuIgHhhxFhKVpQWePzMjT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a219dc-aa4d-44ab-1d6c-08dd45ede5c0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 14:03:42.3743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMXstApHwCg1MAc3ck9ABstpzLRLdt/T0MN2xKGiHlnF6IHmL12plB5njPEOJlQoUqR/WeMg1Ld9AB+/3TzdoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464


On 05/02/2025 03:31, Mohan Kumar D wrote:
> - Fix build error due to 64-by-32 division
> - Additional check for adma max page
> 
> Mohan Kumar D (2):
>    dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
>    dmaengine: tegra210-adma: check for adma max page
> 
>   drivers/dma/tegra210-adma.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 


Thanks! For the series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic


