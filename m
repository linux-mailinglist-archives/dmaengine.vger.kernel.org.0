Return-Path: <dmaengine+bounces-5995-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61730B21AA0
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 04:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1222D1A23A61
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 02:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5772BDC38;
	Tue, 12 Aug 2025 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTXEAdel"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997022D3A71;
	Tue, 12 Aug 2025 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964701; cv=fail; b=H7LGYoIlhNVyH0oz8fzbRWDcXC2wJFOBqRY+mXLNzG7qX9CxldRVPqsbAihTipLzS6p65EuiNnX1ONc0VcnoYOt8N+G0KrbgyNOJMBKLxY4YExvj3lu2UhWMPTEIBwUkx3oS8sW0z+bwIT+oCljnoEZPUOHvU9oG8nyc2/7Fuc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964701; c=relaxed/simple;
	bh=JLhKeVBQNeRYg9cC4zniVyN2DVukIz6Nt3zwilipodg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cj7gR2euCleM0/vdX1G4jwFKSewfQ3ptpvmOlCYxQyqCv9cHbuFJCCcOgYgxxV3Xri+QnBxxilZctr4TUkZemFAConyYctA/+T/BcP/Ndl9xptXJ9UmCjYPVa37Cu/U3drK8v8ipwu7lVEVLNa1Q9i3E1l/ep4GbHc8BbCbVU7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTXEAdel; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754964700; x=1786500700;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JLhKeVBQNeRYg9cC4zniVyN2DVukIz6Nt3zwilipodg=;
  b=mTXEAdelRfs0zfSHg3saxbwnWZs/H2dBkDYN7M6NHYR+zot9bo2Zm/LH
   QaUpkoGIRLhxjZ6Mw6B0oO6glDOnCloQNH7X7ljGYDDzVoijDUGe7z6ka
   4QaIjbrP2HqGQCNcU7Ac1cZ/jsfH2odfLtMLqb1z4J7Hop1Iyk5Z837gD
   c0A2xfdLdxDRKoWdqGTMHhcJ9/i+1acMesQiQNYEoLmliuNVd8zoFYUyu
   5eZ8/vYTQXLyBko/RxdfRVf4RISES7+RHQEL08xhaqvUKFd/+PxpXLd2d
   HntlrSbT3c4mjxtandfzB2fcs6TydFF6WKtyDx28CAgKZ0rvJ+e3XFvDJ
   A==;
X-CSE-ConnectionGUID: SGZNjLClQGu8DGpehVkS7g==
X-CSE-MsgGUID: nld0Ff5YR4G6AEAmj6PeDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="59840769"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="59840769"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:11:39 -0700
X-CSE-ConnectionGUID: PhXsjVwlTj2r5m5zBqbqrg==
X-CSE-MsgGUID: 3DINcp4uQtqB4ZlZlpkRPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166423294"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:11:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 19:11:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 19:11:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.73)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 19:11:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kY1PWpTizgCJ+TtF3STVDIlhZfJfgqVqIo8oyVUlmkhg4op/gz5LZ2FQXwTjxpBRN+nxn3WIdv1TRVI6N+Yk4kQFjsa444oKJZoO8gW7E/+c2cRQv9+QWSeumEo2m+RJRawWJ0Bk3U7Z68qXbGlhe4+6HDFH6i97TEkSe5q7pzUReHZ9cHI7cAVklLo6+gZqwN//cG1kNrjQmOZT+fAXfS8sn1MO0kFn6bdnJ5kFEjAZx3DLGDrKft/Mu/tm8zctSidbaa9/26NLk4Gry6U0m6iptzZfEi9xx7pG2sNUGAKslbwKzGoni7FHTZS+WxixsGlp0XXqsTCbYCD03ahh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU+hiZdnUz9Qa7cLMrcHRJPxjjK8LR1D69GgSoZYoHI=;
 b=Sx7pKyy2awOKbBXdGpbmTmUuTZZW8CpiQr8ikGfLmOwJwISEUGrZLeVvVjet0jRtMkQiJvTuI5LCq8I9cmnrODSzZ6yTVgb5ZHu8bvQhtZ2AMfT/WJSgZPywZZHCx4aU/oBHdfPmtNcErWqB/Z2YRhZaiygVJgkSyY9KhJ9UaUL9Jg8bXffS5jIe4ZI2w9IVXJSkS5Tzkv32S1FHMevsLRvanyJB+AFcqo2csX/QXpl0YMBZsvQVn+40yrgQd2s2VgEaDLaWYtJWP15vY2I2hVnAcz+WL00HRthNgyGcywK2zmH50UIFb3c4a7h9OVwQzobx/wCmlA0Nx6iAyzMGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by PH0PR11MB4806.namprd11.prod.outlook.com (2603:10b6:510:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 02:11:35 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 02:11:35 +0000
Date: Tue, 12 Aug 2025 10:11:25 +0800
From: Yi Sun <yi.sun@intel.com>
To: <vkoul@kernel.org>
CC: Vinicius Costa Gomes <vinicius.gomes@intel.com>, <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fenghuay@nvidia.com>, <philip.lantz@intel.com>, <gordon.jin@intel.com>,
	<anil.s.keshavamurthy@intel.com>
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: Add Max SGL Size Support for
 DSA3.0
Message-ID: <aJqizVCcYSL-4LOm@ysun46-mobl.ccr.corp.intel.com>
References: <20250620130953.1943703-1-yi.sun@intel.com>
 <20250620130953.1943703-3-yi.sun@intel.com>
 <87o6ue6kf6.fsf@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <87o6ue6kf6.fsf@intel.com>
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|PH0PR11MB4806:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cc01f5-e408-4320-bb97-08ddd9459016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eklxdE1SWk1GNElBbU1ucUF3RENsa1NqSzJEM243dCtIRkF4TmJRZlRiM0dS?=
 =?utf-8?B?dzBsWm1VVXFjVnoxS05xdVJxMVVSdTR3U0dGNHZSbzg2Mlk1Y0o4YTM0TEtC?=
 =?utf-8?B?Nm1NYjNhcWRWazZFVC9XbmR0bHVqRHh5Z2ludUNpSFd0bzVLMGcvdndESzFU?=
 =?utf-8?B?bGhlclBsWEN0ZTdTbXh0eUJ3OW1LblhIbEt5U0ZCbXh4UUlSU1grVFgxMVlS?=
 =?utf-8?B?VTVIeVdsSVJPRzFoOXQzemJlZ0piczhmZzNNTmFDenVTWHNPS295OXNadnEz?=
 =?utf-8?B?d3ozVG9aa3lxYzhyZEl3VGUyREpKcFhtZklIRHhXZEl2bGxmcFdOZ1NmNEo1?=
 =?utf-8?B?QitlaktKVWFtTTJMbzZkN091VVozd0FrdGdZSlk0U1JFUEVTRlh1a25VbHBS?=
 =?utf-8?B?S3RuOExTR1BzaGtoalFBS0YzSmIrVGFuWERsSGJ2STB3UmFnVzNmVzY1MkRo?=
 =?utf-8?B?cXk0VC9EQzNTb2pkLzhNZkJBYnlHUlg3UVprSzdZdXlMaFlNQjRpSGdqWkp4?=
 =?utf-8?B?L0dkdG9weDUvaksyMGpXYnMyRkZ1T0U3d3BGQ2QraC96R01pbUw5TCtaWjFS?=
 =?utf-8?B?OTg0KzhqSGoyYzAycGlrKy9OQ2tIRzREcXRUbU5XdU82aXVDeFRNSlZXcVVM?=
 =?utf-8?B?MjNsc1NJWHZuYzJHeTN6TkthZExnbFptYWdsRkRlTDNhcTVKa2lSYXhldEov?=
 =?utf-8?B?TlhEMGYrTXg0WXNLdEtWeXZjRkFPaUtWTm9LcjlTNzFkSy9vZ2NkMkZrdTV0?=
 =?utf-8?B?MS9PajRJd1R2YWJCYWFZL3Q0NlVvMHdkYjlxTHhTR2hSSVlvSFBNTENQYzAz?=
 =?utf-8?B?UUloY3ZzNUZtb0FSVWxtdGtWTUpvS2RrWGx2dzZ2cy8vajRTMFIwVFdOd0N2?=
 =?utf-8?B?V1d5M1BMUkxxWGxvUnNZYm01cVVuSkU0ejBhUnFXU2V5eWNPZXhTUVJiQmNZ?=
 =?utf-8?B?SGZMczB6dkVJVTlvRkxlNm5PUHZ2bHhxaHh5YS9DT3FkeklwdGMxYTlnYmtG?=
 =?utf-8?B?NTlkZzhyS3hYU242a09sZUo5TjM0SXpiK01KTjRKaUJmV3doaVFDbHp1czdi?=
 =?utf-8?B?aHIwdTlLZWVPWlN1cWFTUlNxcmJPb21xNGxDKzNLT3JyY2FxWlVaZHJtL1Z2?=
 =?utf-8?B?emN3dDUyMkg2SXR5d3lSY25peHoreGxkRm9BTldqQnIyYmlxOUNndGh2NFFU?=
 =?utf-8?B?NFVLQkdWOXJUNFlKZmh3Rm1xUFhzSDVWTFpKZDM5aUZQQWZhZTh6SG45dnE2?=
 =?utf-8?B?WDlGVjhnZlpjQlNvQnVueDVTUm5pQjdTNlZRNG0reUNkNFJDV1hxR1dGK3pO?=
 =?utf-8?B?Sk9TaTdjL1E1RVpNSXhMbVVlbzIzZ3dMS25XZi9BOTF3TEo3TnJ5VjMvbkxt?=
 =?utf-8?B?Qm9zL3BNbHdWOGVSbEFrSnRJTmRJQW85emJhaXplRWlYcnI4bjlwOVJjTGpk?=
 =?utf-8?B?dzFpcGtIeENWeE0zM0ZyVVgwQjVYL3dIN2doYllId0ZxTTk2b2JTb21WZklN?=
 =?utf-8?B?S0d4empOai90OWk3MkRNU1BYd3paMkl1Z2pwN2w2NnJQV2VueGVRWEFqSmR0?=
 =?utf-8?B?blNDUEwvQWlFcFhjOFJwVXA2aE9MdDg3c1dWb2pVaTcxbTMwZVJNUkEyRjZj?=
 =?utf-8?B?T2RWcUdXczNEbjFNWU41ZDhLWUVUZ2I1Vk5JWWErNEYyMHpwaXI0TDc4T3pi?=
 =?utf-8?B?cVVpanhYQmJOeEE4MkR4Z2xVT243K081U0dncTVpWS84UzNVK2J5RWc1MDZJ?=
 =?utf-8?B?Q2lKbmRWaFBTYTN5V01JUEV0RHBpRjZSdzdhK3M3bzdFUjdsRFdscWl4ZkJm?=
 =?utf-8?B?Rnd6OWRMYXMrL2dkN0hKUjYxalJJZG82VEZDQW5wOE1FME5qRHkrZEFZQUZ1?=
 =?utf-8?B?d3RPOFZIZnZTWk5XS01oT1dhNk1iaUQ2QUtnSy8wWTcxeXRTQld2V2hCNUxB?=
 =?utf-8?Q?hVHXu9zFLyo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmlLdjZzTHBLcmU5SFZlM2EvaE5sV05RdStid2NMQUNmSFI3MWQ5alI0UEUz?=
 =?utf-8?B?bEVIWmUyMTFVdEVTbUdPMzdLZ2hvOGpId0Rmb3VwRGdtSnF2OGgyNm5RZkM1?=
 =?utf-8?B?aFdqdllPVHVlVXFraXI0VGhYRFowRFhvTHZnZ2Rnb09paGR1Vk9DQXp3SkJj?=
 =?utf-8?B?SUJ0TFdWT0Mrd3VXeEpJZ2s1T3dNQVJjbG1MT3ZiTWZwejVWWnJHM1V0MjF5?=
 =?utf-8?B?RnBtcVdCdm5neDRNWE1VdFZqOUdudENBQjQ5cklKM21jb1VsTVJxaVhoVDhS?=
 =?utf-8?B?d1k0OEFqVWFPbnVhTnk1NXM2eFIzU2x5cWkxOTRLRGFLMVZNblhLbXpTOVky?=
 =?utf-8?B?c1c2MkpYbDZjMVoxdERsNXFVUkd3U1hHQjhBbFRXOHJ6V3NmclNiQTVCSkR4?=
 =?utf-8?B?S2EzNEVUSDVYMnVudVV2Vkx4eWJaTjRJODdCalI2U1E0UmVkUktxWGFueEdi?=
 =?utf-8?B?R1hnTUNDN2hOY3hEZFZsOWpqWVM0YnBHTmV6bEFBK2UrN1psazBKVTlnQno5?=
 =?utf-8?B?NllISUNyUXRkOVhPSnhWNkt1dytvMklkZVNCbVNWRmlmZ2kwZVFCbWdHTE1N?=
 =?utf-8?B?L1hQd1VyOUV0TCs5VFpGQzlQaFp5RGVYVitON2V1YUJmWVZROU43MUoydWtK?=
 =?utf-8?B?MDhnQi80T3puYkhLbkcxKzVqc2Q1N3JWaUd4dkpRajBXeEVoQndGNlFVQkFx?=
 =?utf-8?B?dlc1a1RhblBQVzRGK1laUzRWbiswbWpMNUUrNWpURjZaYTFCazl5WVJ2RmNZ?=
 =?utf-8?B?YkdzRkt3K0tzN2FwTWlLWjRDMVRPeU55blQ0dVMrVjJQRVdzRVVuZ08xT3BR?=
 =?utf-8?B?cnpZV2MrMW1GTlBQRjJ0ckZGcjhDYXdETlpZY2NZc0FVWk5xOWJpWE5KWCs1?=
 =?utf-8?B?Z25WdkVpbDNDUk9sVmtaQS9NZHlPUFg5VForKzBjL0Nsa3A0eEkxQ2FvdHhK?=
 =?utf-8?B?Y3BLYnpzMzFRUEszZGpRR2xaWHBCYldZeDhXWmZtckZZNG5ySkVjVWNVZUZK?=
 =?utf-8?B?UUx0YkZaZm04azQyT1RLT3BjMkpCWnA3QmdaTmgzZCtXMmRnQlFTS0ZUcGY4?=
 =?utf-8?B?cHFLeHliTnlCTXNjSDBhVHpRMks5WXFHM1dzb0ZUdXVzMzFKejlqcm9sd0My?=
 =?utf-8?B?QlM0QnZlWlY2N1VTTTFuUjF2aGE1cXRkQ2tKclBTRnYvUmpFb09zbGZoeUh3?=
 =?utf-8?B?VkVRTjRPNURBcElGT2NtUEo2VEVDVk9aS3lPaGlDemFraWhRam5BTnlpN2Zt?=
 =?utf-8?B?RmZNT0hKc3FnYlJlY2UrU3BJd00wakE2K28wSytuRC9yNVR3M2YvRVphS3JN?=
 =?utf-8?B?a3lmQnlFT1hTSnNRT3hNaDIrZm1PWkRxWGgyL0YycnQzb1dPSkVaN2dPT2Nj?=
 =?utf-8?B?SytYaXFXakVwMDNPVFJpcElrRGdhTEF1NiszeFZYYW1sSXAvR2tZTHNtbUhn?=
 =?utf-8?B?L0lQR3BNeTJXV2daRytSRDJGV0pZeGRoaHhRYnpwTUM0YnZqZGVCSk0xNXBO?=
 =?utf-8?B?b2ZHQ3dEd1RNbWlZOEJVbjlBMXRia2wwQ1dYaTVvdXZzT0tOVFRuWmFMSXJx?=
 =?utf-8?B?MzUxc3VNNTRDMkc0WmZ0SzlxWUdzbmhXc0hSbVc5TWFVTG0vSWswRy9oZDN3?=
 =?utf-8?B?Z25YQ1hqTjZXaEpvZDN0U0VsQ1c5QUpoaHhQWVFDZXBUVWhlL2JyNG45VXZB?=
 =?utf-8?B?Ui9YNkFicXUvNXBqT051cmExdnV5Lzdid1QyNXByYjF4dkdJa2xYeXJQZTkw?=
 =?utf-8?B?QUowV29nSUh4QzlkUHdacExDcWwvU25hS3JZVjhYeTA2QWQ1NEZ5bTVRcDBG?=
 =?utf-8?B?bEZYbVRmMktiS3A3QXM5UFVnaEg1NHljWlVsYWtRTlFXZ1lJbE5Lb1N2RHhk?=
 =?utf-8?B?Z1dIVmJTTERRcjlldnR2RmllMElTT2k1WEs3eno3dmx6azB0WjVCUjZybkdl?=
 =?utf-8?B?SzlKdUQ2MGpkT3hLUnZsckdBVksrN0FHWDRhaFZjeFJkWnVWR1R4REpZV25U?=
 =?utf-8?B?c3FGV01NV3krMS9wSDJTdEFCWk1HYzBPaEo2NHlYK1FjYzQrL3VYalRqR2U2?=
 =?utf-8?B?dVJLeVJDSk9aTFpQR3VnTzVDVjg0a1pReHR3WTQxSlVGQjlUR0VZYVZRVndm?=
 =?utf-8?Q?9ybHgGeAkJeXO79zsqdjLpGuP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cc01f5-e408-4320-bb97-08ddd9459016
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 02:11:35.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qs2v6SATO2pqI2zksw3Y5YDMp0kyRwoT7luPUjRgfss5qHcRqktodWFUahLqTBGAeeg8ihplq0ozO/YqDXiPIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
X-OriginatorOrg: intel.com

On 23.06.2025 17:41, Vinicius Costa Gomes wrote:
>Yi Sun <yi.sun@intel.com> writes:
>
>> Certain DSA 3.0 opcodes, such as Gather copy and Gather reduce, require max
>> SGL configured for workqueues prior to supporting these opcodes.
>>
>> Configure the maximum scatter-gather list (SGL) size for workqueues during
>> setup on the supported HW. Application can then properly handle the SGL
>> size without explicitly setting it.
>>
>> Signed-off-by: Yi Sun <yi.sun@intel.com>
>> Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>
>Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
>
>Cheers,
>-- 
>Vinicius

Hi Vinod,

Gentle ping on the entire series.

Thanks
    --Sun, Yi

