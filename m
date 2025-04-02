Return-Path: <dmaengine+bounces-4801-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A209AA798C6
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 01:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4908A3B5668
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4C41F7904;
	Wed,  2 Apr 2025 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CYMlU8Kt"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23421E4A4;
	Wed,  2 Apr 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636168; cv=fail; b=YcFvW36BGZ9mO3qiZAJxe5NoqniksItnM19Uc9Ql96ZP7mfWQDJwk6IMWLh2+/INLqOBh8ctlvw/87O37Zrxgarl7sHblVktP14ftdNTy1FwiRqAsLvLb/2dVSyDEDDN+xSJhA+uMA2jU7435Zgrf6RFtogog55IJgV6q3Sl0bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636168; c=relaxed/simple;
	bh=0Z8mTyacNejKnrREM9Zf2Rzt1908RiIstljvOu7CAFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MUEyKXK5GzEL5/5X5xnVG7STlJe+YyKWV+vcsXkFHt1hqBNOgZ75Re5KhTaOzHMJkPzLw3jnN+j8vI1SRqI9HzQm8vuwvRzqJkGqxpsnJRPShf5cGvhGk7WmEDdYvN3rHiUBwZ1fnHPWaltwK+nXhmCDSm66MvHyQsgj2l2I0w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CYMlU8Kt; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUZ6LQEOxr2s9+VLq+1fVBSFuOre6NPFfjYGtQmmZSIrabh+7/Jq/SoUc2aJY0dMfFGXTGRsekgwEhldwqEYDH5JT0xf0VOD7wztxNPnNiHVCmzN7Nhqo7G/9iEmnKHiX6lqrseT2T7GKapny8tdq8to7a3RxKsmhlG1FdDv/cvuEfrUKALJzMnVaD+xFCK2ktc74tpdfl51nSUOY0Lg6DvcPLFJuhs1WhhBOM7plq77HWbq9lDdL3As3GQWg5fYNEmarxp9LI9EgKIwyXPWokZ4ZgjIrlaOgAY9FE60JIT9Jd+Rj2R15gyaiig95fFFy4eIAq6rbZ239iSmXHT6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzqEutSXrSbAAwWLF+wIsievCTx5fGKuFBmzjgZEtGY=;
 b=MIm6WLGy4v6np/McpXQ3c8MxwfPbx0aXRxGaQoyO8d8D4yVwAIgkNJwmHeG1jBVIT3FrjiYQtE6wUyKC8EgTOlF3QvApxco+pD+qM1wz7jL7tBp1Lb0neTj4/l8FZhKoetvKyDXxGcfu/9DUfeEVoaNS8JdQ55bQ3aPg9aQGXMp241RzRelEn6eQ0qioooig7l8n0qq4I8qw2x9KW+vAfXFMg+I8wzdMz+27U3xlJdUnOqsUM089DWaNndF6kE0GPFoRNul9VAmREJR+Dwf1l1JIkWPVjEwxYS0WeJXz7RtpxMXtxEIfMgzqXtg1C264aGCA7ocHXnAgJj8bVdZUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzqEutSXrSbAAwWLF+wIsievCTx5fGKuFBmzjgZEtGY=;
 b=CYMlU8KtXOIghl3G0rQy2DsaytwANbCXORTHf4qyU3fEQYfKRLA6walk9mugfavguzEdOBiVc+DyiJ2QoW23IR3mqS/iHoVFv+70FFG4WRNM8EPk9tNEhVWabBKJq+VMSaLuq0XBVRc1oLiHggYX2d4mhN/7SYvXeLsRZ1LL+UnV0pIkpAIY81GadWTogEIco67RhsdIytRDiurgvErvhGWoJ1KK5V+czXmnATBF7wcE6efqg9PNOr2kfr2jUP7wdxDEPwHZlGDnQATH5dLAvQDftuQk0cxOfZZHtdV54ph9j60EY41XGMbxkyO+9PCue7N06TSjweNgU0uTKaDmnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 23:22:44 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 23:22:43 +0000
Message-ID: <ed88358a-36cd-412f-9a09-baaf68297fcf@nvidia.com>
Date: Wed, 2 Apr 2025 16:22:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, Markus.Elfring@web.de, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-2-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250309062058.58910-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:180::33) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 97914e6d-4d43-4159-9ab3-08dd723d44d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGV0bVhVay9uNFpQa1JaNlhqQ1lUMnBzU1pxa2R1NHRMWGxzYnQyWVBTVHFL?=
 =?utf-8?B?ejVHMU83b0tSNTZzcExSYXZBQTZHWlpUODhqYzJMb3JmVDBvaWg1WjVabEEz?=
 =?utf-8?B?RVZ5T1hoOUxzNGRnUkRSOHM2Tjc2aW5helVMbjM2UWNXRXQySkhzN1ZOSjh0?=
 =?utf-8?B?eVR5MjZFT05vM3pYbXFYYnd0cXZhQTltbFBtc054TUFUTm1LWHRFZzhocEtZ?=
 =?utf-8?B?WUIxbjE3VlJKRUZTY3JuM2JSNEVBR3l3Y2RON1p4RTI4OHlLNFVRQWRqRi9m?=
 =?utf-8?B?NHQyV0FGU003clc2K1ZzSUcvUkpqMWx3SUFKNy9Eclk1R2MzTCt1RjRuQ3Zs?=
 =?utf-8?B?V0JidjBCN1c0VXJiWFNMYS9kZHJlUXlmWXFIY1VnTUgwc0xPVFQ2WFpEMGwx?=
 =?utf-8?B?UFRDQTI0b1VYT2xnTzBhQmw4Wks0K21YY0dvRnZGMXdxVlBTRmtGQzI1eVgv?=
 =?utf-8?B?aStxMms1dFpzSGErREw4WXJpei80Zm42T25NVmVhWE5CZ05YY2Fwa1Vja05y?=
 =?utf-8?B?czFEM2NJNXAvTFFoVUQ3YytsU3g4OFZvcU1JOE9XS3pCeGw2M2NhRXN2TzI1?=
 =?utf-8?B?TGtGeU9jT0ZBbHpUTVExb2syRXhHOHgraGc4T1Zsa2tsMEFHdkZXSjNxMnBy?=
 =?utf-8?B?dkladktPQ3FIQnh2c1NkSUdtN2ZKUDVDMEtIUWhxd0k1OHlqSGFwZmJGU3VG?=
 =?utf-8?B?b2hxNkt5Y3h2QmpLV1Y1VWV2eVdtTVRYYVhXckNXNU9ZTTJsclMrVk9jdWJz?=
 =?utf-8?B?RU9obWpVTHhXNDBYOHNjZUQvUEZCV0YvK0NjTllxRDYrajZnbWczeFNoRzFD?=
 =?utf-8?B?ajNMZGljUlpkMUlsd05BQ1o5bkF3ZTdRT0krRXJWcjh2ZnB1V21oKzBGa3o4?=
 =?utf-8?B?dk42RTFBNHB6djdRVUM1a1JYMnRUUVRkc29URjdYbWRPZ3VmaForNUlsMGY1?=
 =?utf-8?B?V1A4aTZWM0NMWTdiQzNpandaeS9jR3QxOUx1SHZLZWtmcGQ4WnkzNGtDaXM3?=
 =?utf-8?B?MTZlRDNzcXlCN3BzRE1nclJkQzQ5MlVCUFFtS2ludjZ5bGVZeDA3MmQrVExD?=
 =?utf-8?B?bzU1YWxQdDRvSmVURytIcS8zem1OUklFSDVHMDJlUXFPNGNlRE5DaFlCRzhp?=
 =?utf-8?B?c3dkMTdoUERxSGluU1JUdkZ4NlpGTjZ4YUVsb3RuV1ZMVFNsYW1rbEsyWUVO?=
 =?utf-8?B?L2V5ZUNiWldEZzk1OXJxUEZLbE1PVitIeU9QaHhnb1JuUEpGYzFkUHlvZFBF?=
 =?utf-8?B?WURRZ1FSalVuMmJIY1BCS3dzTzB6V1pMSW5CblduenpsakpucndsWXo3dTd5?=
 =?utf-8?B?bDFCd2ZyRlFmMm5KMnJWZTg2Y0dDdzhEVjA0SWlpVmlqQmFGMjRLOWtPc3hI?=
 =?utf-8?B?bXNCalN5bHZ0cW9hcGpDY1ZuV0VWdXh5NGJnMWpra1NMUEcxd3JpdzBDUEZM?=
 =?utf-8?B?WXNVbkJMTnVtWWQvM25RRGpkQUlHTURuTTRWMFJYYnpGeVBGZVZIakNFaHNE?=
 =?utf-8?B?U3daUUgxZ2lFTkN1Z0hhY0JIMER4R1g1TllZRFNNS2pmSkE0WDM0OHc2S3cr?=
 =?utf-8?B?ZkNPSHNHdjdZcnl2N0h1UkdoRzRZRm0wT3hmQ3hrOUxTMTFSWWZUNk5DUlBo?=
 =?utf-8?B?ekdTNzBqTFU1RmJBM1R4NjdZcWdtVW83K0N5a3ZyRWRyWU1BZzdOT1N3WDli?=
 =?utf-8?B?Yjg2L3dBVlFmcVV5RGZ2TWEyZ0lKS2pJUTdZb3E5eWZNc0JSU1k0UXZDYjFk?=
 =?utf-8?B?ZlJxNDVUZVV3TjFWSGZjRmwyYlEyc2ZJSnU4dzlOZmdEUHpZdW9uN09MakU3?=
 =?utf-8?B?Q2taOElHVlUrMElkRUU1dG91ZmNBODRsNkdlRWUyRGZTSzRFK1I2UmoxSHVl?=
 =?utf-8?Q?4pJxtPFaQ8euB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFFoTlA1OVBiQXRNdlo2WDkrQ21xMlpXY0dmT05wQUNWcEpQZnRlL3UxRDJR?=
 =?utf-8?B?RHhvMGhoa1NuQW8weExsRHNpZCtIeWtreUl3MTQwcGlMZGVHMVMrbUJXcXh5?=
 =?utf-8?B?WW10aHdhcmc1S0E3VzV0Qk5TZWFTQU1NWlk2SDhVbHlyNHY1TkdQTEJZZTZ4?=
 =?utf-8?B?eEdXMDVRQUsyMlBuUm4yNFFUNzlZNnJiam8wdzB6TGorc0doaXFDckFhbUcr?=
 =?utf-8?B?dDZBM1RxYk12THdHV0pIWVhSWW4rdVZVcW1SOWtvRHYzYWluZyt6eTRqTG5X?=
 =?utf-8?B?cDlGWGhVamU0U2xXV2Rsa3dwOWxGQnNjZXk2OFByQWRnelMwQjVrUy9Sa05l?=
 =?utf-8?B?ZE9UKzlaUGllc0UrdUhJdjdnQmVIak1GMUpqWS9UOUpmSmZyVVZyTkdvNm9N?=
 =?utf-8?B?dHZGZnIrV2RDNzdPSUl0ei96b3FBRnA0Y25kbnhXMFltelAzUVZBQzN6dU5I?=
 =?utf-8?B?OE1vaXV5UjkxaTVUUVUxdnJoZVZsRXNHdHlJMitadXdJYVBrTHhoSFhrOGxB?=
 =?utf-8?B?UktLd1JPRHE4Z04zejlUamthM05yN3JkV2NTcW9mMDZYRllDdWZkaTh5bnBH?=
 =?utf-8?B?cjlnaFNVdVF4ZEh1RFo3N0Z5MGtMTTl0V0xwQ0g4UnF5NzFFMk41d3pvcmky?=
 =?utf-8?B?WHYvNTNqV0JuT2hmVlhwc3plQk10Skg3WHJrQWYzWlJxZTlpcHVlWWJKMlFO?=
 =?utf-8?B?QjJRQVAvZnJUdWRmRmJBS25wZGRjZUJCL3pITlk5S0gwK0laNkJYMzZUbXVM?=
 =?utf-8?B?eGl5U1p5bDFwWHVyeWRTdjFFL1NMRmtWanhpbFV2Uk8zd3ZGeStqZXVhUGpF?=
 =?utf-8?B?T0hPclpWUVBIUm4vdmpHU3JSTDdBS25iMFNXSUhJVm9iMWNKN2tzc3NrT1FB?=
 =?utf-8?B?bFFuSHZnYWo5N2p6dmg2M0tFWDlaQUY4VUpDWVJvUXRmY1p2R3d5OVV0cjRO?=
 =?utf-8?B?b3N4TjBreVloRnk0ZFZtcUkwZCtFbVl3TVRabGMxZkFTRkl6Qit1NysvREU5?=
 =?utf-8?B?ZjBmVHBrb1E1VGpTSDR3L1Byazdvdnc5T3Z3YUJ4ODFnM1pRNHZzTFAwcUdj?=
 =?utf-8?B?dk9hSEMvODFzR01mVU9KbEM3ZjNVckdKOWRGWDU4ZnR4ckUzWnozaUZqOFJD?=
 =?utf-8?B?VGI3azQwUjVadWx4cWxCcFhoN2Nvb3ZXeHhSTTljajhlQ0lVK2Q5Y1dNT2Nz?=
 =?utf-8?B?RmNkbElKUHowU2dEbzJQanNwTi95L1NNbmpiUG1rSEFhaUIzc0pGU25yNVU3?=
 =?utf-8?B?TllzNE5mVVUyM1JRdTlRcjA1bzRFUzhibm04eFhOK3BxSElRNHRNRmJsUk5i?=
 =?utf-8?B?dHNwdm41ZVJJdkRFNDVpR2NYOTl3RXEzYlFTci9rY21NNWZmNFRVVTNJU0dO?=
 =?utf-8?B?dStTWS9vbmI0NE5RQnpLVWhDY1ZWeEIxS0w0RCtCNE9CeS8rRjViU0ZpVmh2?=
 =?utf-8?B?cVMxc3o4M0xGRUtjZE1UUzhQRzZoNkhPMTJYRzJ6ZUNZM0JQWmVxMzlLc0o4?=
 =?utf-8?B?MkNhRXQ3L2xBNldYSURqM1hUQlU3R0pRcExRekF6ZUJ4bkhiSjllRUduZjI4?=
 =?utf-8?B?QTRneW14VTg1YVhxQlhBalBSWW1PUkhnQ0hXVUMrdWNESjc0ZTFsM3BqY09C?=
 =?utf-8?B?eGhpOEV1Wkw5YlRLYzdCYS84NTZsSWxnQi9rK2pRbTBzQ0Vnc3Nia2VicHhC?=
 =?utf-8?B?V1ZjRTB1a1l1eWphNng4NnlOQWRicmZYWUFydTdxaUM0Rms1UWxwWU1Ndm9P?=
 =?utf-8?B?WEZnaG03b3RnN3dReERpamExNnJQRVFWZHkwYXdtcVBFZ2lvWS9mUndOOWxZ?=
 =?utf-8?B?dkRxUHl5dmZCOWo4TmhNY05wbjRmYk9KQUZ2YzQzMlRoajNaQm80Z3BmLzU0?=
 =?utf-8?B?Z2RFMnVuMUh2RitQNjArS0xNWjVtTzJDVkxPcTdob0Y0ejZjNW1RUXBoc0NS?=
 =?utf-8?B?TWtJNDBpM3MrRTloaWVwQmVpK0Z4RjJnQkx1YWE0M0prQkxLYTU5YnFOQXRI?=
 =?utf-8?B?dVI4N0lmVkxyRUJRVU13UE8zRlNZeU1maThuRGgySFRIeXlRUVQ4eE8xT0RS?=
 =?utf-8?B?OEVGYWFXRGRlbmRzczFyeHg2aWZhb1Bqa0FKOXhsMmp2K2dWeWlHSndEc3Jn?=
 =?utf-8?Q?F0xRZvYlXpYZ6viF6VGFP9l5L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97914e6d-4d43-4159-9ab3-08dd723d44d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 23:22:43.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0kTHcHIuCrLVIDZrfNZri3qKxowhUM5dwwGiFqIA0WI4YjoJzESiazw0uZksgQklBvpb1simCEu6t9YE0QYPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161


On 3/8/25 22:20, Shuai Xue wrote:
> Memory allocated for wqs is not freed if an error occurs during
> idxd_setup_wqs(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
>
> Fixes: 7c5dd23e57c1 ("dmaengine: idxd: fix wq conf_dev 'struct device' lifetime")
> Fixes: 700af3a0a26c ("dmaengine: idxd: add 'struct idxd_dev' as wrapper for conf_dev")
> Fixes: de5819b99489 ("dmaengine: idxd: track enabled workqueues in bitmap")
> Fixes: b0325aefd398 ("dmaengine: idxd: add WQ operation cap restriction support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> ---
>   drivers/dma/idxd/init.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index b946f78f85e1..8b775c4a43fc 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -169,8 +169,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   
>   	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
>   	if (!idxd->wq_enable_map) {
> -		kfree(idxd->wqs);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto err_bitmap;
>   	}
>   
>   	for (i = 0; i < idxd->max_wqs; i++) {
> @@ -189,10 +189,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   		conf_dev->bus = &dsa_bus_type;
>   		conf_dev->type = &idxd_wq_device_type;
>   		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
> -		if (rc < 0) {
> -			put_device(conf_dev);
> +		if (rc < 0)
>   			goto err;
> -		}
>   
>   		mutex_init(&wq->wq_lock);
>   		init_waitqueue_head(&wq->err_queue);
> @@ -203,7 +201,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
>   		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>   		if (!wq->wqcfg) {
> -			put_device(conf_dev);
>   			rc = -ENOMEM;
>   			goto err;
>   		}
> @@ -211,9 +208,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   		if (idxd->hw.wq_cap.op_config) {
>   			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
>   			if (!wq->opcap_bmap) {
> -				put_device(conf_dev);
>   				rc = -ENOMEM;
> -				goto err;
> +				goto err_opcap_bmap;
>   			}
>   			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
>   		}
> @@ -224,12 +220,28 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   
>   	return 0;
>   
> - err:
> +err_opcap_bmap:
> +	kfree(wq->wqcfg);
> +
> +err:
> +	put_device(conf_dev);
> +	kfree(wq);
> +
>   	while (--i >= 0) {
>   		wq = idxd->wqs[i];
> +		if (idxd->hw.wq_cap.op_config)
> +			bitmap_free(wq->opcap_bmap);
> +		kfree(wq->wqcfg);
>   		conf_dev = wq_confdev(wq);
>   		put_device(conf_dev);
> +		kfree(wq);
> +
>   	}
> +	bitmap_free(idxd->wq_enable_map);
> +
> +err_bitmap:
> +	kfree(idxd->wqs);
> +
>   	return rc;
>   }
>   

