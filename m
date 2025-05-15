Return-Path: <dmaengine+bounces-5182-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AF8AB8852
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD76F189B95B
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6F61FCE;
	Thu, 15 May 2025 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKBzi0ws"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782DD143895;
	Thu, 15 May 2025 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316753; cv=fail; b=CRzQIAtVIaGEue5kH3cd8z45h8Eg8bGSVhhr1swe9Ek+4vvphMYpBZsu9+6irwehfZVWH4xmvP/5f/gXwf8qQgTLKybK2qr5eVk4YUNM05E9cdvFxmTl2KNrYyZq106ioY11DUtbOPWUJYAyOmDH3wn2panOehnN5zU3GxOv7bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316753; c=relaxed/simple;
	bh=pGowqYd/CdhQvk9MOV6twreNm1qG7IUhS7yxKXNjmGM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+ig8AFkTFHH7+ymo1tiCa25KpPSTuOCXoJWkjrayWBZu6v21D6CiFgGYIyZSm3iGAa5IKg1t4BHzns+ttuXXf42wSMVWd3bW0fMgCx3pN4C5HXKztmdFcBkpm5YNMJGq2K09vgKgcpWCT1tFu2nmsV6kwUFdlSv9uRIBxlJvtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKBzi0ws; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747316752; x=1778852752;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pGowqYd/CdhQvk9MOV6twreNm1qG7IUhS7yxKXNjmGM=;
  b=BKBzi0wsyw4SSFonuVbW5AlnMQgRMouLVouy1t0gXNtY9KHpMA23+Hmx
   je37OtRA6nBtZay1ncOgnK/A4zxSBpLOUOAqJq46X2HepxLrdJlmGJS++
   n7uyD+QvmPJgEQaxaWwNYl+m3vjHjQC9XzQw9HNpx0crHaC3va8xCpMM9
   6TQewHIuGPDhr+XUJGaw+/E+FN6HhcUpe1/ZNDC9nIttT8eQrPxdogSQK
   T1hqe1LiUmPo19LYL5GF20t+OuBnb5357JhF8s6F+XUHW0mEkacnx1HLy
   umfeUpwWz5pfNz+OcHgSAWU9Bdwc1vN9ldqbFaC0ZVIT6X8sl0b9Z1m/J
   Q==;
X-CSE-ConnectionGUID: UblstcfGSta7eoew40CX0A==
X-CSE-MsgGUID: HrbnTz+KTmWf61SFVYZ90A==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60651873"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="60651873"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:45:51 -0700
X-CSE-ConnectionGUID: ZAGvqQjFS4enDwmrl5JL1A==
X-CSE-MsgGUID: vQ6vCCpaQwOAUo/M+7xdHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="161660128"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:45:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 06:45:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 06:45:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 06:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXoFOdASR/bVHOxMZXxgKv2Z3ELN93s7USlpT2dOktoOAs9vP3TUBpryzjdb8Y6T9NvkJWujw2HeOXaJ51RxSt/oLhgfGQ6FXmomssJmJogQZdfmQecht4/v+nVUmgBYyLsc5KLJ7Sa2libXYfS1QVYZKFjS8e9Q4nRuzJM2TOyjnYnvDH0zzgo4HTIr45Hn1ikQ7Sf4CX21bbSERFI6M/uLo6B3DN3msM28y//wMCqWYCogh28m7FJhg1MP+QHF84bNJhWp64Ff8H8AnW41rsTEsYh2ZzB2KzOAohijD4jd1B+3ggBw6iwgp0bshLIo0IjCfD6sB08t0AQfOzP8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xH7t1O1+Uk5ce5pxoUQuBqemkSIZQRHBcUDkg6B/gE=;
 b=Z7ATwbIpvygvTYiDCi5VYp2ijb2xxlBTLT0karNxVsiMGeih11Z9kkBDPjyryCmHl2dNspaLZjLiwpa/n/bTgbASttT9k6sTiXRzCQtPAMXHRTffYGGKZ8C0L1osZw949u3NrLgaYgqc0+FP9uNBfkQGSsUwma1BR5IcE12o5NAijBGlXokq2nXKNBkjre8Bn0tXeyRfwdP549sl87dud8fTIZ3fDwxZy3YdzSfcn4VuK8Fw5XUooZVGnUsZWLmo5Ztmy/I+hQdFT2HuXMSaiNDP9Nop9dEKL2gWIFVz2VHYVqaNambhNjX8AEeVVuvqUZy42FDZ7aYaSKm3u7QPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 13:45:46 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 13:45:45 +0000
Date: Thu, 15 May 2025 21:45:33 +0800
From: Yi Sun <yi.sun@intel.com>
To: <vkoul@kernel.org>
CC: <gordon.jin@intel.com>, <yi.sun@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: idxd: Remove __packed from structures
Message-ID: <aCXv_cp1ITJeobQv@ysun46-mobl.ccr.corp.intel.com>
References: <20250404053614.3096769-1-yi.sun@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250404053614.3096769-1-yi.sun@intel.com>
X-ClientProxiedBy: KL1PR0401CA0030.apcprd04.prod.outlook.com
 (2603:1096:820:e::17) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|SA2PR11MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: e498bb29-0418-4110-891a-08dd93b6caf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG9ubEpxR3JzMVB6NXdmWEg2WVFrbkdlMituYTFrbUpjYTUyL2VBZnVPUW9v?=
 =?utf-8?B?M2dSODh4OTcrU0UwSlo2dG9HckJncWF6blc3cEkyaGQ0aUFNT0VjOTZIanlE?=
 =?utf-8?B?OUwzZGN3b05lU1IxSW1Yd0ZHS0RodzdqeE4wOThsdnJJOHN0a2hyMm1jRFo1?=
 =?utf-8?B?VWQ1RVkxaHNWdmFwTkR5RkRsS0FwY1Vzd05lMFcxaHNKVmFGZGRxMUd2OEUz?=
 =?utf-8?B?dGg2ZlVXWTRsM2NCdkRKM2VIVTh6ZFhEdWp1aDljQmtpZUw1UytPT1ByVUhW?=
 =?utf-8?B?OWMrNjBKRkErbms0R21BN3ErWmh2eVFpS2hESnFLZDBYNzBReE9WRGtEREZD?=
 =?utf-8?B?Y3BwQmJjZWE1WUJnNmd1bU9xK0lkZDVYUU1hdmljdytXWk5uUmptMWhyUGg3?=
 =?utf-8?B?QmxWbFhOdGdZZDNQNHZJZnNobGdHMTNMV3dVUEc5U0JUdytYWEx6c00zQjNL?=
 =?utf-8?B?bUJBWjFjSVNIVE9FazVLTjVYeE4yaWFZYlAyU3o1Q0liVDhuZ3FyNFZMRHNK?=
 =?utf-8?B?NTdoZXdoNTlMd2FMZ3JKSklxcWlmS3F5MFlRRmtEU3dnb2VNZmF0WHZXN1JK?=
 =?utf-8?B?OTNqSVNvUlRjZnZvd0d6WWVsQXpvQjdBRzhqZFNmT2tqaERqNXhTRlV2bHlW?=
 =?utf-8?B?MXd4WVpCTldTZEtOVTAwazhxRVJvekhLendaSk1INFQ0S0VLTS9DUys1aTBN?=
 =?utf-8?B?WU0reUpPYnJUY2g4QmUvd3NqSllvKytGbVo2Tjg2M1VZSndQNm9MWWlTellT?=
 =?utf-8?B?TGVGTGhSdExyTWxoS3NBVS8vT2QrdWc3ZDE2SUl4SmtxTWUrYkZ3aUs3Ny9Z?=
 =?utf-8?B?YTRYem5KMVN6QTV0Tm1kWHlVWmNpV3JWQ0FTckcyOGI3Q3ZHZzdiaURLUFRX?=
 =?utf-8?B?SFJmT2cxOTBkUThmQzNzdFF3L2tGcjRFYTdhRTl2VFJFY21GM2xTblFRWVI3?=
 =?utf-8?B?SHpUVWwxWDZleFlOKytKYjhibVJOc0pJVXZtUVoxRG1HSG9sd05mMUgvVzJ4?=
 =?utf-8?B?emtaMVR2M2VkVXAzeHFOYnZwYWo0V2FLZWs3NkIxcURrcWNUdy9XYXZxK3Rz?=
 =?utf-8?B?dGhTT2w5bTNsbStFZGVFdGI4SXVkdnBEclVvekxZeHArT05NOGV4VHVkK0kv?=
 =?utf-8?B?S3JING8vZkx2L3YzbXlhZDRiMlM5dVZMTGZpS2RsMU94aXZ2RW5Td1R5WkVV?=
 =?utf-8?B?UHFQaHlHTHBlaUlNWVhJM2YrVFdsWDFtempSR2VQNllMcWVHUlVZQlZURDZH?=
 =?utf-8?B?T2hhcGdrSU1mZjQvTysrQ1dXT2dsS3N3OC9xazdvNGQ3U00zNyt0OUZWdnVp?=
 =?utf-8?B?ODRDdnJFaTdFMUgwWFhBSHRqaTdjYTN5eWxZcnpDWnNrRzVQVlVHVGpFZStm?=
 =?utf-8?B?SUYrd0VoV1ExLzRKWmUwbnEzQlV3WkNqZnBwbzJZR0dOek8yR1VNcGYyQWtF?=
 =?utf-8?B?RVJLUlpoVkNEV2h0cnlkYmRqNCtzOWhpbkgzTTZXOTZHVHVtQ2JuSjkvbXli?=
 =?utf-8?B?SWxXL0RWWnJ6K2IxdVFVT0hCdkgrRE9MOTBHWFZJeVlxa2psTEFGc0xHcFBz?=
 =?utf-8?B?Q0l5b1puNEQrcWFCbU5XcGZaTzhEZkFXUCtVUTJSWE5MMk5XMEMwR0ZhZm54?=
 =?utf-8?B?bmV5ZjhQSGNCYjQwSzFXVjdsU0Y1dnp6Qkh0YUZ5clE5MmdDVXVZU0tseHhu?=
 =?utf-8?B?eVpqaUd0MUpzWG4wMGkvZm9VTEtsVVNNM1Q1VzVnbDl0aGRwUWJvTGZidlVO?=
 =?utf-8?B?aHJySlVuTUlZLy9zM2ZyWU5QTWw1OFllODhSTzUvMW93UFJ2dXdXQU1QUkxW?=
 =?utf-8?B?YXNkRm9CZldkUUhRK3hCVnNucG9iZ0ZJN3dZYnNKQUlyYTc5Uy83VndYSlpD?=
 =?utf-8?B?amh3aTgzQjBJb1EvdmU3dlA1T1pXWjlXeStFTmg2eFFxMkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3Fsd3hBMTBrcmdJSXN1V3RGNXNUMEtIeWVENnBnM3g3dWZzM0l0ZUM1S3Ew?=
 =?utf-8?B?S3Fua2hXcm1RTVp4R0l4TjUrRFdPQWhvZDlHSmJ5ajVvV2N3R3lpL3daNUhV?=
 =?utf-8?B?SVQzOVY2N0lNVEtMYUR5WTJxd3FDQm41K2t5SHo4UGFQM1U0UE0zZ1FWNURI?=
 =?utf-8?B?SjVuUmIxT24vZWlmVDhORXk1RGJnSitFUGpkVWE3UmF6Ry82R3NiaDVSemxZ?=
 =?utf-8?B?aWRTRTcrNzVxakZWRE1YY2ZpYWFuQUpURWJRS1BZUjlWa1hOU05JL3dSNjY3?=
 =?utf-8?B?bTFCWk1ESlduL1kxYmxodWVPYkFvYTJsTXB4QWhwT2NwSzZ2UTR2bVVMWEly?=
 =?utf-8?B?ZXRnYVFYYm5DdEs0aWE5bHJvTndBbG1LSTNJbmhjL1QveXVib1ZnSHhJejBT?=
 =?utf-8?B?cklUQzdlQ09adDdJU0NpNmZseTQ5SHp4c01lclBRQ2hTb2cyb3NSR2RjcEZo?=
 =?utf-8?B?YWY4TDV5cTJxSVQzd0lrSzZTNmFyZDNsSlI2TlpORDdiYjlyTENHV21SeHZI?=
 =?utf-8?B?MjlJaWZpWWxHUm14YVNEWE0yaUJtaG9RVzdIZ2hEczZDTFZPVFJWWWFmeFJ5?=
 =?utf-8?B?V1pobTd6czJ6WklrWnBMc1Z5bnVWUVUraTJWSzRvd29ZM095cHVzUWhoK2Fq?=
 =?utf-8?B?bkUwVndWNm9iZDJNanNJNFhnQTRQVEl6KzZaNWdndVFBRHlGbHIycDI0MG5J?=
 =?utf-8?B?Z1ZPb2w5eDRFL3FoRzBWY1g5TGQyTFcyeERveVhuVm9YbzBPQmlRVGVMdVBi?=
 =?utf-8?B?eVZaN0l1QTlidGpwMXFrWWZHeWFUM0xHTW9hTE5vdEJUdkJDcm1Mc1pZN0Ex?=
 =?utf-8?B?V2c2WTNoRVR6RG5GbHVoRDlEUFE2TENJRUpURGVFVHRsWjlyRlF0S2VNNmg4?=
 =?utf-8?B?ZG1mOEZFcVBPRU1GakhLTUtVWWNva3VWbUVzSmE5R1pta0FXZzlyaEpFT1Rt?=
 =?utf-8?B?ZXc1ZjVBVFExa2Q1TzJ6SnBBM3NsQnNSWjFvMlRZL1MyL2twNEdDeTJkcUJp?=
 =?utf-8?B?RG91NnNvUzVFM0w0eTRwTWE3QzVGQVpUSlNFeWp1SHZTL2JvbmZheHp1UWtM?=
 =?utf-8?B?YkRXMHorNWFFalM4bjcxSnlvaGw1aE5rODFSNW56S2VhNkgrcDFBWll0Qnh3?=
 =?utf-8?B?b1dtaGdWY1l0L2dlTkttV2pZb3pqbjBwaW82cWhneDFDYjBrazBRbzVVWU9h?=
 =?utf-8?B?MlF6dk5yVW1WRVJxRjBYb3lPeDBXZTlJa0pDTDlnc3NxWkk3SjhGQjk5L3NG?=
 =?utf-8?B?elQ2dXNOU1R6dE51TU1JbkwyektVVStzWFlxRmZNR2RaTEFFM3BUSjZ3Q2ZY?=
 =?utf-8?B?Y241VVlKblplekZmbU81bjdWWkxMVnRxS0FVQ2pERnV4KytSZ3N1YVZZaUtz?=
 =?utf-8?B?WmN2aVhTZWVHQUlWa0taOUIvRlhMVWRxTVZUTWpzRVUzNUk1b1pDSFBPMzM2?=
 =?utf-8?B?ZUxLNFV2cTQreEIrdzZwcDIyY0NFOVg1aG5XQTd2ZXF4VGJ3dzRFdkZPb1NF?=
 =?utf-8?B?REpEKzlWTXo3R3Y2MXlqUnVUZGFQc1hJR2x1aXJMWnR5aWFobVdUYnI3aVBy?=
 =?utf-8?B?SHlQcjBOTXltaW9VMFY2THRUY05rTFQ0cGxuK3g4bXlERmRZMWMrSGFUWktk?=
 =?utf-8?B?Q1NWOUZIeTBrZHNSalNVV0hyYmEzVjFjeW9aSzN5RlZoaHliYmlURmUxUlY4?=
 =?utf-8?B?Z0F3aC9ERm4yWktIWDdpcitCdmtrdC9uU21VUksyT1RtM2RnK25mN293UjdG?=
 =?utf-8?B?MFJ6SFltMnNqYy9OT0owUFFpWDJwRDFBNXlvUjZBb3UxbEo3RHVwS0IzZEor?=
 =?utf-8?B?V1hKNDlneFV6NlRxL05LME42TjVmZVRkZ2xhZjUzMG9DSlNFbmVuZmNTOWl5?=
 =?utf-8?B?T1M4MlkrdFpoZ0RhdXBEcmtjZFlmNUUrMlNxc1hOZ2ZLSnkvdm40eEl5ckhR?=
 =?utf-8?B?ZFZLNXZMV2x5Tm1sWStpbmJ1WFZDMWN3THFBbGl4eFNLSlRYU3pBL1Rta05L?=
 =?utf-8?B?L1U4ZzdoSGg0TEw0N2NIamkwRHFCeWJYSm9HWm5EeGJycVZyNlNlK0JuOHFl?=
 =?utf-8?B?ZjBQTkVzUE05MmxrdlFXbXhwQzZrWUR6SVNjRVY1RUhQZHpEOStlWFNxclQ5?=
 =?utf-8?Q?k/uiIbpOBls9hA96GFnbPhZyH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e498bb29-0418-4110-891a-08dd93b6caf5
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 13:45:45.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YynrcykiEe+KTdX0v3HQlTUhnrg0Jx80E1by/XGrCHz0tRasfVWPNloweBQuJSY1y/ydm9LYVDuEh4IWEqDcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com

On 04.04.2025 13:36, Yi Sun wrote:
>The __packed attribute introduces potential unaligned memory accesses
>and endianness portability issues. Instead of relying on compiler-specific
>packing, it's much better to explicitly fill structure gaps using padding
>fields, ensuring natural alignment.
>
>Since all previously __packed structures already enforce proper alignment
>through manual padding, the __packed qualifiers are unnecessary and can be
>safely removed.
>
>Signed-off-by: Yi Sun <yi.sun@intel.com>
>Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
>
Hi Vinod,

Gentle ping.

Thanks
    --Sun, Yi

>---
>Changelog:
>- v2: Change the subject to match idxd driver patch convention (Fenghua)
>
>diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
>index 006ba206ab1b..9c1c546fe443 100644
>--- a/drivers/dma/idxd/registers.h
>+++ b/drivers/dma/idxd/registers.h
>@@ -45,7 +45,7 @@ union gen_cap_reg {
> 		u64 rsvd3:32;
> 	};
> 	u64 bits;
>-} __packed;
>+};
> #define IDXD_GENCAP_OFFSET		0x10
>
> union wq_cap_reg {
>@@ -65,7 +65,7 @@ union wq_cap_reg {
> 		u64 rsvd4:8;
> 	};
> 	u64 bits;
>-} __packed;
>+};
> #define IDXD_WQCAP_OFFSET		0x20
> #define IDXD_WQCFG_MIN			5
>
>@@ -79,7 +79,7 @@ union group_cap_reg {
> 		u64 rsvd:45;
> 	};
> 	u64 bits;
>-} __packed;
>+};
> #define IDXD_GRPCAP_OFFSET		0x30
>
> union engine_cap_reg {
>@@ -88,7 +88,7 @@ union engine_cap_reg {
> 		u64 rsvd:56;
> 	};
> 	u64 bits;
>-} __packed;
>+};
>
> #define IDXD_ENGCAP_OFFSET		0x38
>
>@@ -114,7 +114,7 @@ union offsets_reg {
> 		u64 rsvd:48;
> 	};
> 	u64 bits[2];
>-} __packed;
>+};
>
> #define IDXD_TABLE_MULT			0x100
>
>@@ -128,7 +128,7 @@ union gencfg_reg {
> 		u32 rsvd2:18;
> 	};
> 	u32 bits;
>-} __packed;
>+};
>
> #define IDXD_GENCTRL_OFFSET		0x88
> union genctrl_reg {
>@@ -139,7 +139,7 @@ union genctrl_reg {
> 		u32 rsvd:29;
> 	};
> 	u32 bits;
>-} __packed;
>+};
>
> #define IDXD_GENSTATS_OFFSET		0x90
> union gensts_reg {
>@@ -149,7 +149,7 @@ union gensts_reg {
> 		u32 rsvd:28;
> 	};
> 	u32 bits;
>-} __packed;
>+};
>
> enum idxd_device_status_state {
> 	IDXD_DEVICE_STATE_DISABLED = 0,
>@@ -183,7 +183,7 @@ union idxd_command_reg {
> 		u32 int_req:1;
> 	};
> 	u32 bits;
>-} __packed;
>+};
>
> enum idxd_cmd {
> 	IDXD_CMD_ENABLE_DEVICE = 1,
>@@ -213,7 +213,7 @@ union cmdsts_reg {
> 		u8 active:1;
> 	};
> 	u32 bits;
>-} __packed;
>+};
> #define IDXD_CMDSTS_ACTIVE		0x80000000
> #define IDXD_CMDSTS_ERR_MASK		0xff
> #define IDXD_CMDSTS_RES_SHIFT		8
>@@ -284,7 +284,7 @@ union sw_err_reg {
> 		u64 rsvd5;
> 	};
> 	u64 bits[4];
>-} __packed;
>+};
>
> union iaa_cap_reg {
> 	struct {
>@@ -303,7 +303,7 @@ union iaa_cap_reg {
> 		u64 rsvd:52;
> 	};
> 	u64 bits;
>-} __packed;
>+};
>
> #define IDXD_IAACAP_OFFSET	0x180
>
>@@ -320,7 +320,7 @@ union evlcfg_reg {
> 		u64 rsvd2:28;
> 	};
> 	u64 bits[2];
>-} __packed;
>+};
>
> #define IDXD_EVL_SIZE_MIN	0x0040
> #define IDXD_EVL_SIZE_MAX	0xffff
>@@ -334,7 +334,7 @@ union msix_perm {
> 		u32 pasid:20;
> 	};
> 	u32 bits;
>-} __packed;
>+};
>
> union group_flags {
> 	struct {
>@@ -352,13 +352,13 @@ union group_flags {
> 		u64 rsvd5:26;
> 	};
> 	u64 bits;
>-} __packed;
>+};
>
> struct grpcfg {
> 	u64 wqs[4];
> 	u64 engines;
> 	union group_flags flags;
>-} __packed;
>+};
>
> union wqcfg {
> 	struct {
>@@ -410,7 +410,7 @@ union wqcfg {
> 		u64 op_config[4];
> 	};
> 	u32 bits[16];
>-} __packed;
>+};
>
> #define WQCFG_PASID_IDX                2
> #define WQCFG_PRIVL_IDX		2
>@@ -474,7 +474,7 @@ union idxd_perfcap {
> 		u64 rsvd3:8;
> 	};
> 	u64 bits;
>-} __packed;
>+};
>
> #define IDXD_EVNTCAP_OFFSET		0x80
> union idxd_evntcap {
>@@ -483,7 +483,7 @@ union idxd_evntcap {
> 		u64 rsvd:36;
> 	};
> 	u64 bits;
>-} __packed;
>+};
>
> struct idxd_event {
> 	union {
>@@ -493,7 +493,7 @@ struct idxd_event {
> 		};
> 		u32 val;
> 	};
>-} __packed;
>+};
>
> #define IDXD_CNTRCAP_OFFSET		0x800
> struct idxd_cntrcap {
>@@ -506,7 +506,7 @@ struct idxd_cntrcap {
> 		u32 val;
> 	};
> 	struct idxd_event events[];
>-} __packed;
>+};
>
> #define IDXD_PERFRST_OFFSET		0x10
> union idxd_perfrst {
>@@ -516,7 +516,7 @@ union idxd_perfrst {
> 		u32 rsvd:30;
> 	};
> 	u32 val;
>-} __packed;
>+};
>
> #define IDXD_OVFSTATUS_OFFSET		0x30
> #define IDXD_PERFFRZ_OFFSET		0x20
>@@ -533,7 +533,7 @@ union idxd_cntrcfg {
> 		u64 rsvd3:4;
> 	};
> 	u64 val;
>-} __packed;
>+};
>
> #define IDXD_FLTCFG_OFFSET		0x300
>
>@@ -543,7 +543,7 @@ union idxd_cntrdata {
> 		u64 event_count_value;
> 	};
> 	u64 val;
>-} __packed;
>+};
>
> union event_cfg {
> 	struct {
>@@ -551,7 +551,7 @@ union event_cfg {
> 		u64 event_enc:28;
> 	};
> 	u64 val;
>-} __packed;
>+};
>
> union filter_cfg {
> 	struct {
>@@ -562,7 +562,7 @@ union filter_cfg {
> 		u64 eng:8;
> 	};
> 	u64 val;
>-} __packed;
>+};
>
> #define IDXD_EVLSTATUS_OFFSET		0xf0
>
>@@ -580,7 +580,7 @@ union evl_status_reg {
> 		u32 bits_upper32;
> 	};
> 	u64 bits;
>-} __packed;
>+};
>
> #define IDXD_MAX_BATCH_IDENT	256
>
>@@ -620,17 +620,17 @@ struct __evl_entry {
> 	};
> 	u64 fault_addr;
> 	u64 rsvd5;
>-} __packed;
>+};
>
> struct dsa_evl_entry {
> 	struct __evl_entry e;
> 	struct dsa_completion_record cr;
>-} __packed;
>+};
>
> struct iax_evl_entry {
> 	struct __evl_entry e;
> 	u64 rsvd[4];
> 	struct iax_completion_record cr;
>-} __packed;
>+};
>
> #endif
>-- 
>2.43.0
>

