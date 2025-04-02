Return-Path: <dmaengine+bounces-4808-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E4A798DC
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 01:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B0F188BEE3
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 23:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955B51F1302;
	Wed,  2 Apr 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qJRY2XOT"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9526AFB;
	Wed,  2 Apr 2025 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636768; cv=fail; b=DRn5ejyg2u/Qr9K3mC6R7LzkxAo0W1iZWOA5M8w6+v7Y1WpI72G9wgieegLht3pPAbu6R2Ufrtip2D5ekUZWpAw5GBAp2QlMOXtf+zF+hqEp6o6Fm5G7/hWHLc7eucTqiLQ4OoDtsufLFXWYSCHcRSPbJ8UBr7FHHjb3Rrhix64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636768; c=relaxed/simple;
	bh=K95yH+zLQbnt2PQnmBqbjhbuTpOqRhJc7C6oMpZB01U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iPiK5iti+UWoOlgfdbQb0TvEKIKtcMC+hu79iLWYWHFstu3Ajtd1T9U1z6dUZetTqYC/PMF9NGEN7MFcyzsPltmZWWLeToW+8ERHazstA10Gr0KiwuireThIb9iuXEZln+OyUH3/Q5ftrX1wwmz1uuI52F76zle+iOaMXYS0OmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qJRY2XOT; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLkmMWyiO5H5PIue8jOGcI8jSJk4B+YrFwfdaVXNnLvn7jo9gq/kXmVoZaLTnJziIjL5PRQ+ROHilEA4ZTw9h5zyAq1XDYoegrf9pYvFw9FGCKZi6ZVnQyEav+Qd+lr6JqQV0gnaKbnrIGAxwfMWwUcfk0YpMmEVN8SuPYjKqMnkA3VlFHOR9uiaZP4xTX4GeLiJoMWazJQOC0b2sCUOptfQAG8H/xbBOpPlGV+AZZWcgoa3BPHPu5qG5fF6G1pjD1ZdX6lED5+D7NNchi9u9M09MPXlr130kLZBsw+hV6yW21xG/anh6tv3b/87cVnKHvOYWwg7g1KhVPU3HiAR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0zwNzxQL0RvO/QZ4aloT+lWhVKSAztprYLRdJplefA=;
 b=j6lfrrNz4F4fGcsHK4nJIdmAvXYoGQW+eAmKyhnEIpO/of6tXUitqQ7gxZxjTmZe0MWpj3CQwiqVW9Yca5MNtd6oSkC5KcXZM1UFiY9T4f2umCT5pKGsqQIpHHiXpcxT8eT8SnYKG6EPm060bqiECvaHLO3Alhm/b5HgsNQkrMYxgS4lT4NU2pVicljJx0MUk8fC2bdkx4ttJuR2cBYu8CK9xdhizKQyC2xp7G7Tgz/Wsdie7K/8BxPNaYBXCYosPK4ZkbhVx9tunITJmhizYAmvtuGwR7FDZUkREULZbWFucr1vXDk9mTUcI9M6w+9s+v7QhPzOJhddlPETm67Crg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0zwNzxQL0RvO/QZ4aloT+lWhVKSAztprYLRdJplefA=;
 b=qJRY2XOTz/xA2FS0hGCEJXME5OvRAwHvZOHEagkINERIiRV2Hi9nEDZ4eXy1TUc/q0gBWlntArTEiRe0O6rg/da158fiJnEbRir1jMIEDgXMKIGTGe9y45dhoeusUslE5yUP81vJq3uWFGSRjLUVq4oMA5LeqYBl6F/Nc+z49wSr/qb4gv4gc1uB2+10cnVEG6unssECcoqjhNE5Ej2zyy/KVurAMNohv1/EYDisdmpREe6c5cqoKueO5QuZZ/uqZAtOqH11yLhM/xn///Kk1dWSFJIdg2MjP8F5wMoZG3GjUhIWwAi9x2KuOz+8bvLPVz5GYxzO9ubkuvlsNa9+mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.52; Wed, 2 Apr 2025 23:32:44 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 23:32:44 +0000
Message-ID: <363ccf3a-4661-4fa5-8ba3-2453c1f1c423@nvidia.com>
Date: Wed, 2 Apr 2025 16:32:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] dmaengine: idxd: Refactor remove call with
 idxd_cleanup() helper
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, Markus.Elfring@web.de, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-10-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250309062058.58910-10-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b7b10a-fd52-4302-03fc-08dd723eab0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVlsc2wwWklLRzluWVZOYmMwRWZXdHdScjk4OGNKYmtLdVlUd1NFcGNZQnkv?=
 =?utf-8?B?cGNyek5TRGNEWHN1MjFwT2NlOHo2VVhiT2ZhKytRTVl2WXVFaWpSemFpSXhn?=
 =?utf-8?B?cTRpZ1N5bmRsajhNL0lvMzFNVng3M28xYmxZYXZrd3dNbFExd3NJYVNCM0JN?=
 =?utf-8?B?RnVDdUdlZFlpSGJyNC9KcFRrVlhDNUlxd0FxYzhoWnp4K0tPYVp4U2VCeEFk?=
 =?utf-8?B?L1ZDTTErM0M4TUQweEJOWlhSK0Mzb3FqV0lOQ2RIVXpGREZibFdtbWFKcjVs?=
 =?utf-8?B?SEhvMzFKbUk4L0JNUStFZ3pReGxzRHYwalJCT3NqRFE4N2J6bk93SzJZc29m?=
 =?utf-8?B?bGpSeStBN08zRk5FdVM4Q21HRE1IRXVpZ05LdEZ6K3Vsay8ybTNiaGFYYi9z?=
 =?utf-8?B?M3Q4VDhlTUZYUUNXdm0remFRLzZsSGFHeWNZeGtiZGJhenRGQklpdkJaOGxj?=
 =?utf-8?B?NWFpVFZOUEFnZG84TGJsUm5UR2NMOUN1NXdvdkRadVhBb1N4OW4xTkVKNXVN?=
 =?utf-8?B?V0dmTllSUUoxRCt1cUxMU3NoSks4cTR5ZmZJNnBvTTBHNVFQeURTL0hwZStU?=
 =?utf-8?B?MlB0bGZpOWZCLzEwUEFiZWRRNVZpN3NQaTNZeHY4eHNOUWhTTlhnckFJMkRz?=
 =?utf-8?B?TVA3THIybEd5N0dCQkZaUHU3ZkRNL1krOG02OThQQmV2QlYyY25UK3I5YjRH?=
 =?utf-8?B?cUIxdisxNDdvZlVsVzdWUXFremZCd2FWb1YwR2tPMFlGMS9KNWl6Qm93R0FL?=
 =?utf-8?B?NXd0NkNxUktmTnNIWTRUVGFRT3lERXBTYVY1bmNpejhGa2tuY0tybHByZDQ2?=
 =?utf-8?B?Rm8yWFIyMWNnaVhuOUFWZ2s2Z0RIT3NtdEc5TUZESG1HUDBNSndYZDdFa0dq?=
 =?utf-8?B?M1RlbU1nTHZCRFk4eUIyb0laNDVxVTVjQkdtM1hsT3REZnB2SEFGaE5rcTJ4?=
 =?utf-8?B?YXVBNHFmZEY4bk9IS2M4a0JtN3BGdGtkY2lqVWtYc0krT0xWZTR2VjBBc2gw?=
 =?utf-8?B?cU00RzZ0ak1PZjBncTNZc092dVJhMnpZNTBkNHdYL0dtWXVkMi83dHVzK2kr?=
 =?utf-8?B?Q2hnU2RDODJUR05Vb2ZNT1NHN01QczVyMUcwZ1Nyd2R0cmZaV0t5V2ZlYXVK?=
 =?utf-8?B?VktOa3VtVHFKbko2ZzJ5UGpkMVNTYTZ4d2NlQzZDcFlGZEpzRElERmQ5eXp3?=
 =?utf-8?B?eFI4ZVpjNGxNOWdjM0xYa2hFVm4zeFJoRXkxVnNjMEFPL1FGSTNiWU92YjFB?=
 =?utf-8?B?Qi9BdDduRElRbVhCWFBtNUhmOW5aMVF4T284U1ZOblFVeEJqR1dkL3RicTQr?=
 =?utf-8?B?c3pNb2w0Ukc2V0dvT0ZBTVUyQlF4amNJbkRRZEo0VkFUc3MyV1NpeWhVTmxV?=
 =?utf-8?B?UVRmd3R2VmUvL1VNRnMrTWVOTFRCTGptOGR3K1VicHYrbTFQa25HU2VkTUdS?=
 =?utf-8?B?WjJUZXNOQkd3N0RJbGcxcFZPTDN2UjlQV0YyZnR2QWZGL0xsMzBuVUJTcTFM?=
 =?utf-8?B?dFBPK0RkU1l0SHN3MHM4ZEYyaXdCUHNSMUE4aXg1V0IyVU5kc2xNSGIzZTFG?=
 =?utf-8?B?aUVYVk5ENEMrSi9FT243bWVOM2VtekVQai9vV3hWeDh3UllQM3ZtcmNyV3lE?=
 =?utf-8?B?aEk5L2tPaUwyVXg2d1J6ckR3REx6N0Q0ODZXdUozWHJiNnpJLzVScDZnNngr?=
 =?utf-8?B?RDlnYkFreFpENFZFSXlXQXZXNUhzaSt6OUo2ekJSYWNGTUwxT05QRm9FRFJt?=
 =?utf-8?B?QUF4VENKQjNwVG8yTyt1RlNzK3dDZ1lBTkhSaU5wclRmeUN1ak4rNm5VY1FX?=
 =?utf-8?B?S29pOHc1OTdmRFhjWERCc3BKSE5Xa2k1Z2o1aHFNNm4vZGUwS3grdkR1WWxF?=
 =?utf-8?Q?5VKzH5Ks7pdj1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHFWTWxWRWpmUjYxOXhyanFCR01ycG1kSDVNbGNhRm9YZ3ppMzlidEVwNWx2?=
 =?utf-8?B?TUVLZVRaMjJiaXB5VjlaOWxaMndMTkIvanYyMlhYSHkrb0x2M3VxWXVZS21P?=
 =?utf-8?B?OHk1VkVVTFpFRFQ5QzM4dTFIUXlUMHp2RnQ2Z2pNeVpKcHB5S2NUaGIrTkg4?=
 =?utf-8?B?NkJjZGlBdVM0QldrNmtyMkhKbXhiVEZtN3REOVRBR0hkN2puNnlnOXJiN1Bj?=
 =?utf-8?B?MGFmRHhlbTJDcllmR255dDdNLzA4YjhhNWwzYk5BTVFkeUtjQTNQVHIwUm1m?=
 =?utf-8?B?bnJBV1BjZno5cVVobndpamJrVW8vK2lMZTNOdGhLbG41ZW1wbVo3bzVQTjBo?=
 =?utf-8?B?cDlCMnhMWTJYaEV3VE5VU0lHV0NacEdDd2NjSXlkUzRUR0oxMnBqSVlCck9N?=
 =?utf-8?B?NjJoMFNvTFV1ejRkUUtxZ0pudWp5UndrdW1nL2sxSHM2Q01TUWtYbThaMzJB?=
 =?utf-8?B?WlRaVmw3ZlhMaFN1aERpV1Q3TnJJM2svenlvT2ZzU2dTWmYyWUdyM1BtSktp?=
 =?utf-8?B?aWZQRDlCR1JheEZvbHRBbG5Zc3NBUTNCaWZyeHJaMU1lcVMvc29HV0U0V2lN?=
 =?utf-8?B?a0laNzhCdmk1eU1HTEo4NC9Qc0h2VzNuZjBVaEZwVlpjc1pSMDQrQW9ISTJX?=
 =?utf-8?B?bXFxQ0xOV0RQemp4U1FCR3NzV3prTEZ4Mkk1U0NBR21lbks0RDJVKzdKTVdO?=
 =?utf-8?B?ZlVSTUl3aWFqTitwQTVaeWE3NGxhV09rM3BzOThteDlrNG92RDVDUytxNlFZ?=
 =?utf-8?B?cEJFMWJCOURLSFJpcWxZRnE1L2hhM21vZkI2R2xTMHFzSXZjVjZST2VubzRI?=
 =?utf-8?B?VktWdTlPeDRWdURIRnBvYzJRSU53R2gwaGpxdEV6MlFiYmRTTyt3UHZKUW9u?=
 =?utf-8?B?YnIvdForY3YyQ0lMM3ExdzVabDl4R1c3K1lXUklXbU1ySWV0ZnJhOTkzOEpj?=
 =?utf-8?B?VHEyeUpaOUpkWDlsa1VwVDVjYlA3aGREbThLS1pELzlOTUtCZk5FNlNCWjJI?=
 =?utf-8?B?UWx0aEozTU9tQWhrVHNSUkFUbmVpNHNVTy80SVZZemhGZ3VJdWxya003bUNR?=
 =?utf-8?B?Q2txc2xQLzR1bjUwV0E1V3VRcEFKRkZiSmxva2tUaEhTdjBLY2lrWHZLQW0r?=
 =?utf-8?B?TGJieWo5ZXI0bnZnWDdLcGc2dXcxdEN4ZTRQbEozWFRMRUtWWDRqeC9qWXNK?=
 =?utf-8?B?ZlJITjdiaFhobE96WG1lWXpLQ20xc2l6NmNZNW91Y0w0b0UxY1pRQ2cvRVpm?=
 =?utf-8?B?eVU2blhxZ1BvcktsUUZlT3NaeUV1Nm1Zekk4QWRWNmhIdzZ6c2JSYVNSM0Rp?=
 =?utf-8?B?MmxqVVdVN1JTMktBVE9ONzNGalRwbEJvWWJmNUFEdGdoVVRBVXNubEtoK2Fp?=
 =?utf-8?B?eEJyMXFaTUVBOGN5d3JiUWt4NkpLbUljZ28yQXhncGFXa0lNM1c2Mldzelcz?=
 =?utf-8?B?SmNtc3NYZ0RZVUtNZ2FjejUvMXpic05tT0hHaWJLUGtEOW92a3JOVG51T0NI?=
 =?utf-8?B?dFhqQmx2ZlpweUIvNVA2K2drUWJlQk5ZQ3R1UXRaSzYwU3JGdWZTeTFRUTJQ?=
 =?utf-8?B?TnRxLzRkMHc3SjcraXNhVzhOMlA1YTExSEplVG9kY2M4M25DbWZvemtXYUQ3?=
 =?utf-8?B?V1R5eDRMaERXdGZVSjZNSFhKMEo3UFkwMm05YlpWaWJBRnZDanJyWkUwOGh5?=
 =?utf-8?B?OHJlR2xNbVR2Vldpc3Y1T1JGUkxLVXpSL1JWSFlSdlErd2JGaW5vNjVyZ1Iz?=
 =?utf-8?B?Y0VvYjljZTBxVDV5M3RqMmZ4QzFzK0JJSHRRTExneERIRnNWd0dESjlkY01H?=
 =?utf-8?B?NXFwcjBhUXNqUll0Q3FtdkQvemNVdmlHb01RM1MzYTdkQUhJSXhOOUFUUXM0?=
 =?utf-8?B?YmhuY1ZLTHRFZVdjM1BkcGk2WjE0cFh1YUlVNDcwOFp2ZVNtRG8wYTh2dFdw?=
 =?utf-8?B?dEwxU0o5RkdNVEJxcEhxY0RPTmlibk4rekRpUCtYeHBVM2pCNk9ZWHpBdnZK?=
 =?utf-8?B?NzZjSnRrTytmeVNBcGNqNUV3eUpxRWhaakc1Z2loL2F0aHNITGx5cWdhUW80?=
 =?utf-8?B?WnkvM0Zja2kzZWw5QXVhN004cEFvTjJBbzdMYkpYM2wyRThMd0FwTG96Nmxj?=
 =?utf-8?Q?DZ6uPsXNLcRkgmOYwKndZ1Grc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b7b10a-fd52-4302-03fc-08dd723eab0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 23:32:44.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9XV7dFGxe0usmTjgvJDweBbObIh4pyBlh90opY7NAaV5yS+R4Q5WI4A4pXfrwQAgR8T0L8B9HSJYrkISdyaHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272


On 3/8/25 22:20, Shuai Xue wrote:
> The idxd_cleanup() helper cleans up perfmon, interrupts, internals and
> so on. Refactor remove call with the idxd_cleanup() helper to avoid code
> duplication. Note, this also fixes the missing put_device() for idxd
> groups, enginces and wqs.
>
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Cc: stable@vger.kernel.org
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> ---
>   drivers/dma/idxd/init.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index ecb8d534fac4..22b411b470be 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1310,7 +1310,6 @@ static void idxd_shutdown(struct pci_dev *pdev)
>   static void idxd_remove(struct pci_dev *pdev)
>   {
>   	struct idxd_device *idxd = pci_get_drvdata(pdev);
> -	struct idxd_irq_entry *irq_entry;
>   
>   	idxd_unregister_devices(idxd);
>   	/*
> @@ -1323,21 +1322,12 @@ static void idxd_remove(struct pci_dev *pdev)
>   	get_device(idxd_confdev(idxd));
>   	device_unregister(idxd_confdev(idxd));
>   	idxd_shutdown(pdev);
> -	if (device_pasid_enabled(idxd))
> -		idxd_disable_system_pasid(idxd);
>   	idxd_device_remove_debugfs(idxd);
> -
> -	irq_entry = idxd_get_ie(idxd, 0);
> -	free_irq(irq_entry->vector, irq_entry);
> -	pci_free_irq_vectors(pdev);
> +	idxd_cleanup(idxd);
>   	pci_iounmap(pdev, idxd->reg_base);
> -	if (device_user_pasid_enabled(idxd))
> -		idxd_disable_sva(pdev);
> -	pci_disable_device(pdev);
> -	destroy_workqueue(idxd->wq);
> -	perfmon_pmu_remove(idxd);
>   	put_device(idxd_confdev(idxd));
>   	idxd_free(idxd);
> +	pci_disable_device(pdev);
>   }
>   
>   static struct pci_driver idxd_pci_driver = {

