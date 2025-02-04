Return-Path: <dmaengine+bounces-4269-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26922A27827
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 18:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BF93A2957
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CE42163AB;
	Tue,  4 Feb 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OCMUSW0I"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CB216388;
	Tue,  4 Feb 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689539; cv=fail; b=idWREmnsIBaU4hsJ/3FrdS8zhR97eLMRSU3cmmXl9Ac2RzLitzYX4Vz9/yby4NPvht0Xc2kSAFgjBLVhvMpMiqbWaBo3mwntHqZIrD2oFQ14mw/Vviycw3Y8isy9eVqy7hV9qluLjUWuLS2FWCBefA5SGG2MzyfPUdug1AzFXXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689539; c=relaxed/simple;
	bh=BybnetRjXyty4WXBq7pstFLbmvBRvLxhBEBltnzsEHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CSdEspXpInwmS4re1VrNi+Om/y935kRHTSPSr65+KTk56dL+67ZpjiHmQLoEegEUCms2q2LbmRBOVPhIhSIHprvkGQDPMMO0RYT+836SRpp3MxEkuVYKg6qI+Kf4+pPGTg0IuuruSWn1ETOnNOWtUblzLmLDi2Fa0qKWwQjKDS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OCMUSW0I; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xnbc8RZRMGUHf9VShSZTSdQWqJzfl5p5CyEi62Vp1vv8LjDT9XaNkceh+Y64cB/ucgkpPRgQyeOa11uNWwX9MHRyMu4Cw7d7kprWZ5N3FSW5sBTo6IMhtPjyYt1/qmgYObNuSUeKaj+N71DIzSZfogo8MWhQHBuPb8dU+0WyRmE/slvub8nD6UT2wprzoSpTQ9LSfI6ipx5UBJJaO0qAFozi/fFDRifrdBS/y7X5+Bt07ON62JjVlMqR4yVxY8LvtxGT5urtbCL1qxhp6hoE+c0bNW3iPnuSjChecNmdrIvAufJcYGmdYb8PwrtTj1PX13Wr4Jtgt2YhIRv/MudO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlHyEBoltd+TIErq3or4VjduzaX87iqh6xHd1WHkt0w=;
 b=i9pBOMBX7qN4+pYcQRvejkdvwkR/s1kr7K3gIIrg+PH3QZ8Y4b2D9vQF5U4muFHrRY+USi3Q62XWDzo5YcV9Cq++z6e1u0lDEPwbkEojp50KAwuTJEGF6/Z3JBq10/oSf3gfNRwta6X9YUkbeObdxZ2+ch7g35X07O8hxjACVDiSn6CSM/aCVwv9vRB+fAqPO7W4kbtxx+ovnsjlVn8fy+rvmSmRiA/lGzsJ4ecasjyN9iYls+Li1rj+f+6tx+1+oQ9ftHsE8gUKhRRE7XM/NQuSz9YMpJ5XPvWXiYqThNFwFsnJgthT0MB3CyzIAP/qe02/WSD5xJj3CvBN0LBvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlHyEBoltd+TIErq3or4VjduzaX87iqh6xHd1WHkt0w=;
 b=OCMUSW0I3zrlwKPn8XwtGG8du+paUw1dfQo8geCBYjsgqJFMf3vsbWYZ6tdwspTg07kvmtByQrnZ4VUAR+N6D3m8QIHR4UPPcHTEEKyshOSwi/c7UFUJcI1v5V0LWIM8pq0a7as8v585At8OyOHzxYeA3xhKoHy3iyjAJ2tgNp5IKbEijorjv2mwuCo/9VXqu5N+mgRitT1EC6Y/eDR0LDza9Lij7kgTXy56Y4OXd1M2FFwnuMZqEMfOy2tWk+qbCtWbZHPZbDUE2vogEhpCzjEyXS8X7+T1cemL5VkmWk9UgkRMxqbIJ/BkCNb+XUpOcjlMykOVjTQx1zyO1JwyGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 17:18:52 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:18:51 +0000
Message-ID: <c5e7e8a3-2e8e-4d68-8e06-a7a3f7fc451e@nvidia.com>
Date: Tue, 4 Feb 2025 17:18:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
To: Thierry Reding <thierry.reding@gmail.com>,
 Mohan Kumar D <mkumard@nvidia.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
 <20250116162033.3922252-2-mkumard@nvidia.com>
 <dsxaisxdpsxecyna527cifixyurmkgo3cfaiheau5jjdl5qysp@64qquncxdmof>
 <84382200-e793-4e9a-b25a-8dc43e7a8bd0@nvidia.com>
 <52n364alceto6tgitbnjbfgtrk2lpe5ipztxi4abnuikjwgnvk@i6irrkj6fqbb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <52n364alceto6tgitbnjbfgtrk2lpe5ipztxi4abnuikjwgnvk@i6irrkj6fqbb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 9600cc90-ab3a-4eae-2efd-08dd453ffec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUprTlhkajJrTTY1TUprK2ZiTzE0dWRkNjVLVjd3NFIyTXlPSngxa09DZk9M?=
 =?utf-8?B?UGdodDJTRkYrdXc5c05veUliK0FvbTFsWUhZOGYxTjlLZHFHZngrS0VpNTdL?=
 =?utf-8?B?czB0KzlRekFpWTJaQXZSVTZZclBON3ZxUXBrN3VaV04wT1dpSU9FVmJndFhi?=
 =?utf-8?B?KzFta0VZZU5JRGo3UUJodDNmZHloNGMyMm9VeXJFNDM1Z2o3THNqZmV2Nlpa?=
 =?utf-8?B?dG5kVVArMUFrQWVERUxSSEh5V3FjdFhudUxiS2Rsd0FBMDJxOWJab0EyUzNT?=
 =?utf-8?B?dTZEeXZzS01uSit5VEpMamtHcUtxbUo3ZVB1U2JNZENsa0hTUUlVNjJiRmw5?=
 =?utf-8?B?TVNQc21kUkEzSlFWd2lhY3U2dStRVnp3ZWc4N0FWQ2J5V2pGcUtXUnRrNlRF?=
 =?utf-8?B?ZlVsU3ovOEg1RzNoV3U2bWpQTUNDK0VyZUNOcmllOU9vNldtUG1uZ2U2WFZH?=
 =?utf-8?B?K2RQV2YrTWt1N3BWRnIrajZiM3A5azBoOURpd3hWL3lQcXNOcTN1a1dZNkdh?=
 =?utf-8?B?L0tQS3NKTGVaZkhyZElva1kwMzdRSFhIQzZFSEFCYmltckpneWdJYW5QNHNk?=
 =?utf-8?B?eDJTZkxSTHg2UjBPcndiWVp4MmVMVTZ2OTdTY2ZjbDYxNTB0NFBuVmttYndH?=
 =?utf-8?B?RXVXUk5BTlVSaDV1N3A4dnppNUwvRlVBV3dZUVUzRWFERTlqMDVWVDR6WVlV?=
 =?utf-8?B?STR4V1RpK3RpNDhvMG1RYS8zeXNoaHU1d1dHK09yMXM4OGRYaC9tL2pqdUNH?=
 =?utf-8?B?N2NmOTY5ZHR6TzlCMkhsRm9DQjd2M3gxMERZNFhpYVAvY3Y2TjNlbjVnbk0y?=
 =?utf-8?B?NFJ5ZWNQcWNtcy9EMGNkV3FlT0xvb3VNaDBnUkdSWG9JV3E5bUI2WmhWNjh4?=
 =?utf-8?B?SWJDaWpYUnlkbHd5NjdZTG1XbG1UWUdMeVYxNjR2S3FaOVE5R00vaWRzU2VN?=
 =?utf-8?B?aDIzUFd3VEc2TmN0ajBWY1NCRVNLV3VDNHcwVm1wcmJNbnV3bVh1cFE4Nkxr?=
 =?utf-8?B?OFY1SXl2ejlJN29VR0pRK1ZTZmdmOUI1dENkcm1kL2NJUlNIbjV5R0F3dmlR?=
 =?utf-8?B?UHUvblJ2eXhpTWg3amFaM1doSDVvYWtWYVJ2NFQwbDlDSEtEYnJYSnpKSFF5?=
 =?utf-8?B?dHo5S2lqYkhFdkVxQ3R4cldCMGc1SVpZVVE4MGNyRFdobEdhRTVKQmI1VUVz?=
 =?utf-8?B?dlVwM09mc3Njd2NnU3NqTHRiQVlJUjFTYzlpODh0ck9XRXRhalg2eFlTcDF6?=
 =?utf-8?B?WXRYWDk3K2h0M1J3c0lrWXdHbTNSTkZzeTdhZyt5S2JaNVdsTUVxeWRmdmor?=
 =?utf-8?B?aXB2L1RLNlFsNWMwUEx2WERFb0J4SjJVWnpDOTVJYzJuRDVtSXBhZUZjdkUr?=
 =?utf-8?B?dFdMRlJabzJWS1NXYW9scXdxWVdpcENYOHBDM1ZlWVhXdWVUbGpTR29qSXhl?=
 =?utf-8?B?ZTB6RmFFZjR3TzJQbU8xWFNCaVFMOFQ3cW9lNXFacGZ0TXUvUmJpTmlRMHU4?=
 =?utf-8?B?UUJUblczMUZ6ZEZCODlUVldDM0hVV3NoTXE0SmtPZlZnQlRSY203a1JUQ1Nr?=
 =?utf-8?B?amJMV01VWitCSktHQm1CeWlkQWNTM2dGSzg1b1poelRDSDdmODNpZS8xL1pz?=
 =?utf-8?B?eXd6b05ZRTFoTjVjSjZVYmJseXRxZFdTbGp5UXZvOXJoazdjdndWUmk0cCtK?=
 =?utf-8?B?ZnZFY2ZpTGdBSDhvWEY3ZmxXQmY0amdwZmUrZERDRzJsMElmRU1MNWtZanBM?=
 =?utf-8?B?cjFDSmRuN2E5ZWk0NC9FVDdhdnZGMjF0WmlCcFNROVR4aTZnODhFR2krL2VX?=
 =?utf-8?B?Rzd5MHRXT1hibFlaY00vRnJ4Y2p1YUhwNHhwSlBRMkY5K2twZnMrWjhZYjFZ?=
 =?utf-8?Q?tUdG4zyDcl/pu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rkx4c01tU096RllZWHNvTGlwVHJaU0IxUVhJNlFEc3JtamkyR1NYSGlrT3Vj?=
 =?utf-8?B?VERTcFQ3VWpqNlRlZHZtTVhKOW9sdW44Q00vdWdnSS9mbjg4V1FnVXJxYUQz?=
 =?utf-8?B?dllaeTlRYmpndHNlT01xWHl2c0V1N1pNeUoxeTB4cElvWHZQRjJLZmRQckd4?=
 =?utf-8?B?YWlFU2V5NGtoZEJ0dUlFOXkwTWozU040VnFUbVlQR2dyWVN5M3E0RUg0RGFT?=
 =?utf-8?B?eTRqL0F5dTRwR2RkS0V4SWsrRm5RMGpyYW4rZ2lNMlcwbDBYMjQ4Qjg0UlRR?=
 =?utf-8?B?L25sSkZ3cXdnVE1qZituM1NqZS83WnFhYjQ1QVJyS29ZQ2YwUnJjSUtvTjho?=
 =?utf-8?B?RDhkcEJzdmJ0UmVRckZ4dmV1dEo3MzYvNEFGY1dlV3NXNWUrY0N0TDNTSWRh?=
 =?utf-8?B?cE8yK3dwOGU0dGU3bnRMTFFvNlR2bldETE41OVdrdjlDNy9RYUc1V1AvdVNG?=
 =?utf-8?B?d0Vvc2xBaDVnVzl6cVNHWU1TTGIrTzhBZTIvSTB2b2t6OVJ0dDdFR3dmUkRI?=
 =?utf-8?B?OFpnRjBwdFBHNXRLL0puRWs4UWdEajhmbXRja2NRa3ZPbzFYSFVDWHM1K2xz?=
 =?utf-8?B?UG9xbm9BcU52WlByRUxQZVFjcnBLeTliMmEyVElqWnoyTVpwZnJWN0pKbTNM?=
 =?utf-8?B?MEEyUlM2K1Uza2kxMnBEc3prR0VsaU1wY2I3Y2llR3UyL2hrNHRJQUhZbGEz?=
 =?utf-8?B?ZEVuUllhZklpTE1jTk05YXJkN0JpSTZIRkdXQk1wL0J1UmFWSkpJMk8zMU9E?=
 =?utf-8?B?Y2hyWmRINTBKRDBSTStmMDQyaUVMQ2liVUpuaXc3NXhJSjFIa2NXeDRSc3Bw?=
 =?utf-8?B?M3VjVjJCMEZ4eTVrOWpDQ3JHT1ZweXJXMEpHZDlpUHVQMXp3QkVxMnEraVor?=
 =?utf-8?B?dTMvMUR1ckw0SnF5V2pBQ3dacGU4bnNydUYxUzlUVU5GOFFBSHFUMEhEVjZS?=
 =?utf-8?B?TzU0OFJqcDNJWjllRXZqVXdLS1VwNk16TzlVSjVvM3FwMjYrU2dlaWh6Tkls?=
 =?utf-8?B?UWVycEtOVEJ5bGF6VzZyUVc4QSt4a1NKTUJuMFFxUS9YUXcxNVdwSk0wUHZK?=
 =?utf-8?B?aVZLYkJFcElVZWtrWnk4c3Nwem45ZCtQQWxhclRoaTFCcWgxNDdLRWZ6bFdB?=
 =?utf-8?B?aitCSUkxV0NIQWJRVEdBUk15aHYwQm5JcGgrVTdoSFNqNHNHN0IwVmJ5Z3R3?=
 =?utf-8?B?NTNnZk03Ujl1TjFaOFoxL3dSVDVDNVM1WnlGZHM2dGxESlA5dWNQM0RGVUtB?=
 =?utf-8?B?VHJtR3VTeHNQYUc1N0FLR0NZYSs0MHliS2pMcDlSNlh4QzlxU0hBTFN2RWhs?=
 =?utf-8?B?NE1qeTFvZjRZcHFmVFlaU013ekhzbmM4REF6Sm8wSkJlLzZiT3BLaHJXNGp4?=
 =?utf-8?B?eVI0TFFQVHBVUkFyajZ5L0E3Tmo3amxta2k2YWtocmZIUjlhK3ZndDRObDRL?=
 =?utf-8?B?dWVQMGk1a3JROE9RdzFDczRGeExlamVEYllGYXJjNTVKQUhkaW1yYzVySXRj?=
 =?utf-8?B?azRxaGlSYlhBKzR2UjdkWFZFejkyKzV0VDhGSXgwSi92RUF1SWVtMlQ4MGVs?=
 =?utf-8?B?QXpXaEQ0cS91VTlPNDlRWmtxUnkvdHc1ZzkrWFg0WTQ0d0k0aFRiaWJMa21Z?=
 =?utf-8?B?am1VZzVOamhDUVVHcFA0M1JDNEZXUks3UWlCNWQ3MWdqTGRUaVEydGNtUHY3?=
 =?utf-8?B?bEY2VDNlbzNnY3hRNnkxd0o0dTljZFhmNEc4NjNkanFUTkN4TTUvdVZSUFRX?=
 =?utf-8?B?TWlDSk1TNWpOSmk2bGlQTHc4UEYvay96VWM5M0FJNUhHU2xkZGF1SEhyL05F?=
 =?utf-8?B?TnlLTEN2bkhQQlZmUjZ6Z0dTZEhtczBMV0lvTzJLaEJtc3dMdXd5a3JsTDNN?=
 =?utf-8?B?UXY4cFM4bGphc1diK29TRUlCNmR4MXdRMDRrdjcxWGZxRXhyUnpxaisxcXVi?=
 =?utf-8?B?RFpVZ3gvL0RyaUszb1RjVlQvbXJIQ3BVK29UNlZoaEI0d1N6SEZXTFVsUlBp?=
 =?utf-8?B?amVmQW5tY0hUTDhpSWorN2EvTHN1c2x0MDYrU3RPMXpBRTMwVnVUZFRzYXJI?=
 =?utf-8?B?Z2oyWlFOK2tlY1VsMkxUSFBDKzA0MExwU1BLanhMeFp5dkJ6czhncWYxd2M3?=
 =?utf-8?B?S1lvS1VFTk9CZ2FIcGdNVmtzNHpGUjg3UEd2YjNkSjBNSCtsdHVIbHMveC9w?=
 =?utf-8?B?Tk1sVWZyS0p2NENFNEhKb1Q5VHJLV3RXTklOWEhxaWJYL1lFenR4WWtuRGxh?=
 =?utf-8?B?ZmN0NElBT2orTUFERkdiVWVVLy9RPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9600cc90-ab3a-4eae-2efd-08dd453ffec1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:18:51.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAVh2ADt5uBU+bqExrKMZifrt8iVnOQcZe5WSCLdQ0nY+dT+GUg4+46rQ93m6nq0jvTFudOdhEmQ8Tn3z0pLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920


On 04/02/2025 17:03, Thierry Reding wrote:
> On Tue, Feb 04, 2025 at 10:13:09PM +0530, Mohan Kumar D wrote:
>>
>> On 04-02-2025 21:06, Thierry Reding wrote:
>>> On Thu, Jan 16, 2025 at 09:50:32PM +0530, Mohan Kumar D wrote:
>>>> Kernel test robot reported the build errors on 32-bit platforms due to
>>>> plain 64-by-32 division. Following build erros were reported.
>>>>
>>>>      "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
>>>>       ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>>>>       tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
>>>>
>>>> This can be fixed by using lower_32_bits() for the adma address space as
>>>> the offset is constrained to the lower 32 bits
>>>>
>>>> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
>>>> Cc: stable@vger.kernel.org
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
>>>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
>>>> ---
>>>>    drivers/dma/tegra210-adma.c | 14 +++++++++++---
>>>>    1 file changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>>>> index 6896da8ac7ef..258220c9cb50 100644
>>>> --- a/drivers/dma/tegra210-adma.c
>>>> +++ b/drivers/dma/tegra210-adma.c
>>>> @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>>>    	const struct tegra_adma_chip_data *cdata;
>>>>    	struct tegra_adma *tdma;
>>>>    	struct resource *res_page, *res_base;
>>>> -	int ret, i, page_no;
>>>> +	unsigned int page_no, page_offset;
>>>> +	int ret, i;
>>>>    	cdata = of_device_get_match_data(&pdev->dev);
>>>>    	if (!cdata) {
>>>> @@ -914,9 +915,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>>>    		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>>>>    		if (res_base) {
>>>> -			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
>>>> -			if (page_no <= 0)
>>>> +			if (WARN_ON(lower_32_bits(res_page->start) <=
>>>> +						lower_32_bits(res_base->start)))
>>> Don't we technically also want to check that
>>>
>>> 	res_page->start <= res_base->start
>>>
>>> because otherwise people might put in something that's completely out of
>>> range? I guess maybe you could argue that the DT is then just broken,
>>> but since we're checking anyway, might as well check for all corner
>>> cases.
>>>
>>> Thierry
>> ADMA Address range for all Tegra chip falls within 32bit range. Do you think
>> still we need to have this extra check which seems like redundant for now.
> 
> No, you're right. If this is all within the lower 32 bit range, this
> should be plenty enough. It might be worth to make it a bit more
> explicit and store these values in variables and add a comment as to
> why we only need the 32 bits. That would also make the code a bit
> easier to read by making the lines shorter.
> 
> 	// memory regions are guaranteed to be within the lower 4 GiB
> 	u32 base = lower_32_bits(res_base->start);
> 	u32 page = lower_32_bits(res_page->start);
> 
> 	if (WARN_ON(page <= base))
> 		...
> 
> etc.
> 
> Hm... on the other hand. Do we know that it's always going to stay that
> way? What if we ever get a chip that has a very different address map?

You mean a DMA register space that crosses a 4GB address boundary? I 
would hope not but maybe I should not assume that!

> Maybe we can do a combination of Arnd's patch and this. In conjunction
> with your second patch here, this could become something along these
> lines:
> 
> 	u64 offset, page;
> 
> 	if (WARN_ON(res_page->start <= res_base->start))
> 		return -EINVAL;
> 
> 	offset = res_page->start - res_base->start;
> 	page = div_u64(offset, cdata->ch_base_offset);


We were trying to avoid the div_u64 because at some point we want to 
convert the result to 32-bits to avoid any further 64-bit math and we 
really don't need 64-bits for the page number.

Jon

--
nvpublic

