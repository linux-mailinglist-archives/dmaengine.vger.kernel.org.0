Return-Path: <dmaengine+bounces-2683-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E3E92F281
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 01:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126001C2293F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 23:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999819FA61;
	Thu, 11 Jul 2024 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1KmHxIJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00911DFE3;
	Thu, 11 Jul 2024 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739653; cv=fail; b=aNmLqaozdPnSOq219ccU5yZV/jH78JE/6rtYgeCB/Vnm9jAhSHjPGEtV9kQ87QyTiqXZEtiEO3x6wZPGpELr3jRYqGoeLukHlbuw4cCw0y5AQlvtWXmGUH28L1VP18i89AVRPhujAkyX5EioBP435ln3R5nC1Ompc0ndivctoOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739653; c=relaxed/simple;
	bh=4tm3Sw5jXL2VmwmYKxqi/wtFRdtWd/c3MQ83BHt8u+Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fd6tK9UQwnQs8YyNx3tUSnk9//gqGDk1/xUsqEYI4EDBsWBmvxiA2hmi5hmQK+kgVvDKiuePIwYF07+Erp0GXZN4XDdv9I+MVp09B2OWKE+4JBG28iqojYw2m50VMxUgcBZHzntEgUJscx6/AxZtD7+AUB2RPnnBMwqdULHZgZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1KmHxIJ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720739651; x=1752275651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4tm3Sw5jXL2VmwmYKxqi/wtFRdtWd/c3MQ83BHt8u+Y=;
  b=M1KmHxIJAikky5fASSyZEeGdrq5R0hULPUdNhYgIj5hG1IiBCO9v55VS
   tak0kV65hHdqmY0VDnzgVplR1IYxU6sv+ZPRrDk7yVgk/GGhcGj8u9gV2
   7s0d9ppiDx0zsA+R/efL0I7iJv3EQFGYJYh8zl59JvLrXq/eog0BHpRGk
   n875HW5kE8cFAmiGUaHM482swDk2ToGHIG2YrZOkGqyGHyf8ic6y9gdin
   PF3iYxl7KhSL9tL9ORRdGDd+ijnslOzqIR7VYUMfSiujXuXqOKbkL6b+w
   XMPqbiDNxgiS/YPX7zV7ZV74AZhdPD8PQU5kmyXINz//SQJjtJJSqgNLn
   g==;
X-CSE-ConnectionGUID: wwVlyx+xSQGySu68cwWi4A==
X-CSE-MsgGUID: b9pb3Ga6RGaFRhfQQOytfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18309924"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="18309924"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 16:14:09 -0700
X-CSE-ConnectionGUID: sEEoBmsJRhepXMtqfYl/JA==
X-CSE-MsgGUID: 9q7Gl1qzQpSkClRahnmpOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="86231116"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 16:14:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 16:14:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 16:14:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 16:14:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 16:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbvHTAQU9z46YsyEdZXZcQa7if7dQpToHndMlchBCGM04GoZ/VELk6hon4/gYgt+MyH4n03LbogOkCR8yc8fxMt6l+uAvShVCDFwOwakYKYnIRVP2xK7zJOE/oPe0YSYr5p8qF2xvipnG0MPdyMxj/kpriyFEcLrrjGMbBGFT6rmBQtcxkOdkxdttbt6xx83aHz2d6N5NcQfxwdsnTcrMxWP49/BqeSR/a7WvsfoHeRzFtCxZt/OietnazreRibUWffu7JXzKJdP/r9cmMAR900Kka03QQBSHBhyiWu0bXZLIV/x3MgZQkIy0hVOI07jpcDiILvzCd57mUnwfpc59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3wMPV7tbguHLdtuyF0c6gsWMl9c7p1t/s5imTwRo+I=;
 b=rIO0MZF17WWQjIuNt/9w63dJzrRb9HP5WqN5NzF5JIsOAGKGn4dPknPD1Y5zE1pKbndPWTbh71DFxt+JHKwsJvOwDaKRiEAPjz53JHof0c3hYIPA6aVuFUGjBbPMeMy37PvgSLh7XLmwgPJpuXWWZ+elUteR9CuJDudwINOYrFaasTeZapNraa2T/uEVXC0FlnJr3kxNZ4xraQNoXKmI+sOQGKu6hV7xsnto1OAxxGSctQt/K/Nuqy+OfAOasddy2PjTnP3jeVoJVf6Kwlx3ZO4Jc3q47pAtp1HbKh+vN75uNlE5/n5cIzsjsifDTnv1nt6qtk/Pq/jrMbL4c1MrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 23:14:06 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 23:14:06 +0000
Message-ID: <04afd071-0bcd-048b-118f-843a90a09299@intel.com>
Date: Thu, 11 Jul 2024 16:14:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dmaengine: idxd: Convert comma to semicolon
Content-Language: en-US
To: Chen Ni <nichen@iscas.ac.cn>, <dave.jiang@intel.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240711013436.2655373-1-nichen@iscas.ac.cn>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20240711013436.2655373-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BL1PR11MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ccbf53-a587-4254-6319-08dca1ff293e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1R6ZHRHc3BJSVRiZXdsQVFTNU8xY1JWOUpYb2RIWmdSSzdTbUVlVlBtSzZM?=
 =?utf-8?B?eGlQN00wS0QwcEpWUVdIUkV4K2gzamZlV1doUnArZ0wzZk8wYlhqZWdsZE5q?=
 =?utf-8?B?MnpUYSsybXhiWVJ4VnFiZlkramRzakRveVNUQmJwSzZaQjVoZGk4VUNqQVZs?=
 =?utf-8?B?dEZJTUQ0S1A5WGoxME1NemtpMWQ2bDNWY1RZMVNIbUNjd0pQK3JPUGRSTEhY?=
 =?utf-8?B?bXVNNFhKazdQaFBoVUdNYXdIVTlPdGlPVzdJcDZZaVNrK2JjcWVCc1dkcXd3?=
 =?utf-8?B?aElyTURkZ0ExN21na2h2NXpQaW5sOEErcjhJRzlGVlBvQzdEcWNUbm5yQUlo?=
 =?utf-8?B?dzdvQ3NRNlB1WG1XWE5uUk9qQ1F6M1cvRklUUFVydnN6WWZnMUc2YTIxZ2NJ?=
 =?utf-8?B?TzJuY0tubXQ3VEFGbDJNYWc4R2xVUWVMemJxR1ZzL1RiOFpFQ3ZtL3RPT0dl?=
 =?utf-8?B?R0o4NUNKQzJ3RVFXTjUrbzgzazlMc2VGRFQyd2ZHc0ozdzVRaituamg5VURP?=
 =?utf-8?B?SnpDSDN5U0VNdjNhakpMTnpHMy9zMWVWa2NwQW5LQTNYL1YwU0thNEVYbDha?=
 =?utf-8?B?S2s3aVJyR1RjV0VlNGNDUjJ1aXltZlIvR1VTK01xNG5NKy9wSXdBRUVDRm1j?=
 =?utf-8?B?K1dmT1FlK0gzT2J1VXBkS0lDWEttQzdBeld2bkMwZmszODBNZ0F1S1pNMW5N?=
 =?utf-8?B?OS9MUS9kMVBKUnBwWXA2L0UvS3U2Znd5MDJRTFBFbXFFakdqalBUYTliSzJo?=
 =?utf-8?B?RTlBS2krdXdmSFJFeldFK0JNTkhNQmFJU1FzRGJwUG1ObGxlZ1M4NTVIaXEx?=
 =?utf-8?B?UVhuaFBLTS8wMEhqQ3RhTkpPczk0NG1mOGhJN0liT2ZCZ0JRMWc1TWRIQncr?=
 =?utf-8?B?QlFueU9uc0hhcnljcFNHeXB3TncvSjJ4WVBTTnppTmE4WllCT2RuZUJhMGkr?=
 =?utf-8?B?TDFheGg0Ung4S1NBWWRhOUdzL1ExTXNBeWFXRm9PM3lvdVl0Yzl0ejNGUVlr?=
 =?utf-8?B?UDI4RkpiZDNvZjJNWEUwVkkxdzFVd1BZOGVnNFBUWE1OSmdiOUFBUlc3Y3VJ?=
 =?utf-8?B?U1doNDU1VHlOL3F2ZFJQVWhORjVGZStuTWFjVmlUT2hYM0krS1I5amVoMm5l?=
 =?utf-8?B?dERjSVhFWk1VV0I3Rm9kNDAvM0FaR1k3YTJIMUpHdFZzczcybnhxR1dXRXlw?=
 =?utf-8?B?YjlqdDFjUWpvOUtzQ2RFRW4vSmF5dTN5cTlnbU1XZHMzWkNtKzZZSkRjSS93?=
 =?utf-8?B?UzVGT2JEOE5Iem5iNTNza3FLM3kxeUxoQWo4ZkhDTHBNa3ExbERMektFTkJ2?=
 =?utf-8?B?RC9qVldzS0MzUTdRZ2kwWGtIVVkwTFQwYmtkQmg4Wnp5UWR2NzdZMmpXNEhS?=
 =?utf-8?B?b2R0UDhQUVlJekMzNlU1OFlMVjd3Q0p1STczZWpZeVhiSll5YnFrMS9tenJY?=
 =?utf-8?B?SmM1RUZjWXNLcEU3ZmUwUmhYTE5aZjF1WnM2eTNQRmZIdzhZZWxRU1dPODJt?=
 =?utf-8?B?elVQY3BmMTZYSHlDd2tmUU5EU2RnZmdIQVdJdmZNWDZRTXp0eWdqTDFmaXJU?=
 =?utf-8?B?R3UwbXhKaHloZUZtT2psTVhBRDNISDRZdUZHTmY2SWVSSURYR2J0Z3ZZaExD?=
 =?utf-8?B?K05XQVFnSEVYdEZqcmFFcVBXOVgzM0RpZk10Nzc0S1c4VWlJYW5iWkNBdFlY?=
 =?utf-8?B?TEZ5UEJSYjE1cURmbjBhOE5WTkNYSTk1c0ZBTEdXWkhXdC8wVEl1YUJyRDQ2?=
 =?utf-8?B?aFdVR1RTd1FEbGtocnpMOTBlcHNUV2VFc1JuWkdqWGhWTjdrcWlRL3JvMktU?=
 =?utf-8?B?eTZhVWFhQm1RSGZTY3poQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTJOb0Z6eXUwd0dvd3F4WEQ5Zjl1cmo2NXA5cUZ4cVdBeE5mT1pVZGV1MUFY?=
 =?utf-8?B?OHNONWQ0ZGw3dFRJNDE0RXFOeW5sSnFkZ2V1UVN6Nk9kcU9KNlpjSkNQZm9I?=
 =?utf-8?B?UVZVRTV3VFRNU2xLVjlmdjQycmp6TlFyRWZJOEN5dCt3ME00NmRkRnd4enBp?=
 =?utf-8?B?WjIzN1g3cXNmcHR1V0JGOXU0WFdkMk5XbUtaa2ZIZzN4YTgxb0lYRFRXNG9p?=
 =?utf-8?B?R2g4U3MzS3Z0UzB2bTlMcXFHckZWeVBXN2VxamhnMWtPV3pzWUVjUzV4aUsx?=
 =?utf-8?B?WXB2b1IyZWIzYm8xTnpmZTE5NGZIL3BpOThqaTdOSmUyMjd6VHhrdWFSeHVH?=
 =?utf-8?B?OTR2K0JqQ0ZpYlIyaTdrNkJXREhQOUc2cTRqay91U3Y0SWRRRlkxLzB2K2Q5?=
 =?utf-8?B?QlBQY1VieEpwMCtkL2NtQ1ZMMWl1ZDR0YktMdVozaVdPL2tqbThZTUJKTlFQ?=
 =?utf-8?B?VFAwMHowWEt6eGlDbGx3UWgrVFhDdlNmSnQwU1V4bnNrNXVhUDdKR1gzMFZZ?=
 =?utf-8?B?QkJHQ0tkQlEyRmgrRDYwRjcxblFQVUxwNzlnd0srL00rOTR1OEJrWk1JVmdq?=
 =?utf-8?B?QzBRNjNCdHBJTmxMVFZZYkN1NXJYVi84U0UzektUbXdOR29ySXFiSmFiL095?=
 =?utf-8?B?YjVaSzdudHgzanJVWE5EWTZJVzRWMHhlbWI2MzN5ZEFEbjE4cVJYM1Y2VXgy?=
 =?utf-8?B?SWc4MzF5b2FqdURPNFg4c2djWTJqeUVDaWJZZHhUOHRkZGxWTFZNNWtSamR4?=
 =?utf-8?B?VUxVMVZUZEY4aFdnQXJ6YzdOTkZXR0kyYzJZWGxYU2xCT1lhaXdHMHFSZGZJ?=
 =?utf-8?B?ajJlMnAwZ3JKeEErSGUzTG9Pc0oxWnF6Y0l1NnlpVUpCWHR2eHRWNXdHek5w?=
 =?utf-8?B?djVvaHJpV3RLUG9ZSFFMYXVGSVUvKytpSFRIcWxBTWpGTGIvV2JodmgxVW5D?=
 =?utf-8?B?S1ZCckRzNkptN2Z0czlMMzBWTXFYRGpZK1dwTVlVN0dtYVplZ21Xc3ZmSlYr?=
 =?utf-8?B?RkszNW1LSjA0WVpVcmJkZlR5VWxlVW91d05va1NGZEVBUG1kcEpzNDJuKzRM?=
 =?utf-8?B?QnlBL3hRY2I2c2dkWG5wUXRQUGl5RnVpelA1cmdEN0RRMXJEL3A4aXJOcFd5?=
 =?utf-8?B?bXJiMjU1ZW1ERmJZUzdtL1RZTlJNbWZEcjNMM3NoOHUzeDBaWWNiUW5DMHo3?=
 =?utf-8?B?WGd2V2ZmNVU4NjQ3ZGZrM084OWlQazhEUzFqWTFaakRhT3QrdTE0Q1dKaVVm?=
 =?utf-8?B?UDBkeFFWZ0lJQ3VkWnkvdVZEVVlCRFFKeTRVN3VmYWtJaTlYWi9KaHRwVXdk?=
 =?utf-8?B?QUkvWXFkZHEvOTFPODV1OXZteWRzdkN1TnpMTkdmZ2dRUTllSlU2YnI0cnoz?=
 =?utf-8?B?K2ZsUUh1cDJOUC9YWmJnQ0lNRHhyL2lkQXN2T0FuT3lDb3BicnY2K1VrYldR?=
 =?utf-8?B?QTVEMmpkVnRFKzBaUFNyOEppeWxCbjBjQ3hoSmpyblMyZlNTM0hCTEVON0o5?=
 =?utf-8?B?eUtmRFBEZitrc0hsMnZYYWUzNTlsSU9ldE5aQW5xSjkybGZhWjVNdGc0QktJ?=
 =?utf-8?B?TTduWVI1cHY1QUdMV2pNNm5SUys2R1BMcjhwelhxK2l4UjdlTU5Xa2l1QUoz?=
 =?utf-8?B?eHdFSWJ3ZXh5K1R6ZUwrNWxnOEpvZnRKc0VuQy81Z1dWWmdzSGo0d3ZvZkFK?=
 =?utf-8?B?citvMXg0Ky9LeUhrWTVyUEthU0xpWURvaDNlTFNxUmJOYm0ycTZ2T2xyekFi?=
 =?utf-8?B?STIwT2hPc1JqeHBuVGVXYnNvdnpCcitmZjFjRFRQOUtWZTRJalhDS3hBQUgx?=
 =?utf-8?B?enhrYVB4VzA2TUpXSTZjYVFIeGRSUGhvYVQrZVpLdFg1YldDZVNIcmpHTFU1?=
 =?utf-8?B?QUJKY1N2NHR3akhCWmdKVkhzRU5OZDNrcFhGZFF0d1Q5emt0S3MzOW0rQmFX?=
 =?utf-8?B?dlluY25DT0l6RXZ1cHFHdFBRRlRwWHMzZ0VhdE5WL0hVN21oTjhyS3FTWkVz?=
 =?utf-8?B?cDF6OGUyZEJjSVFLOThHV054MFRxb3Qycm1ycGg0OTlQS0krTDVCTFNocFRN?=
 =?utf-8?B?bEZ1YjliM3hmSGUrZTdRTUhEY2d2VitwS29vKzMzNE9XNFM3bXBqRXhDTEVY?=
 =?utf-8?Q?JHxQQl3HfiZ1MQf3aH0Ug93wG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ccbf53-a587-4254-6319-08dca1ff293e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 23:14:06.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GU9QMdR1rAMbUFSsvPUuxjxJbKLyU55/WEXTqXhmTQpA1uI6kcSsXcGbkVJYFvV6BYN/wUcESGy/4/pjB1yEJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5256
X-OriginatorOrg: intel.com



On 7/10/24 18:34, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon for
> more readability.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

