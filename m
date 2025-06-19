Return-Path: <dmaengine+bounces-5538-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C59ADFB6C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jun 2025 04:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894C25A0530
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jun 2025 02:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433EB1E7C2D;
	Thu, 19 Jun 2025 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAIyz8Q6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A341A5B9E;
	Thu, 19 Jun 2025 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301480; cv=fail; b=InZt5XkRHT4MweY0apWMqcPkUFAwJdQDsUwb/AdVtdgoTAjWUZ8Cuu3FAiB1n6hUVdfwAd1VeUveD0azKQusAKk9ey/r1ruyCoHnKp+f2D1piee1Nwqzg2gMafiHYmyFu9I+ucBNim/mL0WOn5ooFPuwwaYObcVBF24M/nAyhyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301480; c=relaxed/simple;
	bh=/1Uj/qRK9j8wdeMXXbX2or2q5Ier/qXwrd/XLh7TlpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcZB/9R6AFcsTwpW+SEUWhHvzkSxm+gQqm1EbQTTxVMKdMxbLNQ37y8rPZKn4saL6FK27RDd831D41aQfIGwSxY2FgDyyAntXZbpUUeN1qqHbgpgz2+2XSCCxMalmaObKLff29YTfUMtPxsYQTj6ytHi/YQfE+jiAf6EtWT1E34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAIyz8Q6; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750301478; x=1781837478;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/1Uj/qRK9j8wdeMXXbX2or2q5Ier/qXwrd/XLh7TlpQ=;
  b=IAIyz8Q6Ml4urig0YYZKbpn95/a13o57LHZr6IbcZOnWW09hCCLqL3MD
   auID29L3ia494TGv733j73jD9Q2JBgOFQqIn4PIIxCfREY7bv7peodUpq
   HNiHCBpLDTfaNTV2IMN5Q1w2ZK/6Z5uKOraEK2Req7B4SBISX7GqJcaWg
   UgZ2JAaa/VRs6xoOPHJBFLKcfQ6a8k4KtkSWBQeYBXGbgLtvS7NAT9Owc
   vrcxxUpbi8aDm4Z1jJrR0zsI6VNQQkkCxeogyz1ykRVFIol8jC2NXBE4J
   KON2nowkHy8YB+lmzpGnImm8RZMG328aKmwnjrS/jFnrB2a+8P24v0J7l
   A==;
X-CSE-ConnectionGUID: dh3AL/TbROKsjykRwZi4BQ==
X-CSE-MsgGUID: 2ZfHJnxbTcWW5zMYXIyFyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56228056"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="56228056"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 19:51:17 -0700
X-CSE-ConnectionGUID: nrtDTmzQSiK0ZrpMHIoInw==
X-CSE-MsgGUID: msoDFdcgTOyZYByiZD/mEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="187625057"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 19:51:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 19:51:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 19:51:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.89)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 19:51:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwrTTLPzqx2rxnoPXhRpbmSjqfuhOkx6sGkzUKzreJIrzSlKrzVSO23LnwEqqDNjQkgMlkvBOuGMpoCh/r7s0mzq51VsspfKCREptwPo/hxt2Kr52+mJLlKHB1rSp5KB4frZlL1yEHOv40ufUlCPuY03RRszwCuAoJWTtGO8U+iMiPzS6cgSe1jRx7LtlAkNMazy/wflqo3ApUi5bIMS5GAOZLP9MZJqgooWeZ+HkcuPYap9AUbqzIblF5ZFUmU+ohAh9eoZMY3c5P0NPeEnn+bgJyIVT2cKyDdGI49vZJn+9T+FJeCCNw1GLJ9r54kttXOiKR0xC41SRGwdMD5q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jadXJAWGka9+onunF4RlxROBxoNdLyF289645z9ChsM=;
 b=BGzpDK7gP+h6sa3g+ROkbdfd0KusO+FakVu4lNjL/5eXTtscWZlOPChI07PXw8co+jKB7E0DgRoCXOkD24gL6MYrV+4YW4tCB5qfkWrJS+sV26KQBbzBMjS7Wx2uEuCb+a9N498XbFlEIUKb8DxPrLZO2d7I/aonyqa+5GxbAUmXllCVVMP67qZmSj0FmN7uQZd50HwTBtyo6OK2RCEs5NdcEEcImAo7BURtZC9A6gVXf7G1As5rJlUPWbf2QwCu6eXg+yS+xLtT/vpVlcGShEzSYciK5yTe6gBNh+lAlQyD+5yV66KeoriCJc3f3VRWxZklLBn2GIDlpXAhjRBtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by LV3PR11MB8457.namprd11.prod.outlook.com (2603:10b6:408:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 02:51:15 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8835.030; Thu, 19 Jun 2025
 02:51:15 +0000
Date: Thu, 19 Jun 2025 10:51:06 +0800
From: "Sun, Yi" <yi.sun@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>, "Lantz, Philip" <philip.lantz@intel.com>
CC: "Jin, Gordon" <gordon.jin@intel.com>, "Keshavamurthy, Anil S"
	<anil.s.keshavamurthy@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through
 sysfs
Message-ID: <aFN7Ggt66Tpdqq1l@ysun46-mobl.ccr.corp.intel.com>
References: <20250613161834.2912353-1-yi.sun@intel.com>
 <20250613161834.2912353-2-yi.sun@intel.com>
 <c9dae480-b5bf-4028-a398-bafb9d206f50@nvidia.com>
 <BL1SPRMB00111E4D037AA0922A61CA0C8877A@BL1SPRMB0011.namprd11.prod.outlook.com>
 <bba06b90-5673-42ea-aa97-6c55256af6b2@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <bba06b90-5673-42ea-aa97-6c55256af6b2@nvidia.com>
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|LV3PR11MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ab256b-627a-4cce-acd9-08ddaedc281f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEtubll5aUhHajhnZHA1bXdrTzdoZW1CRlZYd1JVczZqYXVnaEVEaTc1cDFv?=
 =?utf-8?B?QXpVZjJTaVlVM0thTDJXSDdTNzFaYngrZG0vZTN2NW1xbEkySkRYdG50WUZR?=
 =?utf-8?B?TkdTMjcxaFh5enE3SGpqQkJRcmg2QktwZzhHbTFXNGw0V3ZyYll6Rll4UThw?=
 =?utf-8?B?OGVaL01zNFk1eEFlV1NjL200aVJ1RmVlSWQwa3VvTUd3bHFxeDZTdkpmaVRy?=
 =?utf-8?B?ajNubTlaSzI3VTdWallIUk5TUUZlM3NBWiszcHpPd2U0RnVDcHBBWEt3Tzkr?=
 =?utf-8?B?eFUvRDJnN1NNcTIzdUNsd0ZRWnl1bW5nTmt1WERiWG5GZ1BTOXUvRlozNUJI?=
 =?utf-8?B?YmZOYVgxYWw1KzVyUW5PRFAycFVrQmZOb045NFF3K1p1OTRtUGJkY1BrZ1p2?=
 =?utf-8?B?Z1UzdTFBTmFXbzhKWkFSb05CVEtJL1hhbkhIaGRuYlFWMm1OQU95QTZweHBJ?=
 =?utf-8?B?anMrMzVCL3RQS1dNaFdrQ1g1c2pGTE9Zdnd6dExGSll6Nm9ubXBzV2RyNVUx?=
 =?utf-8?B?UTRVL1owenltV2FOZzlNQk9YWEpJQU5BdzZ5alQyY3FHWFNLNEVQVThiY1ZS?=
 =?utf-8?B?L0g0S2RLTG9Ra1hDTnZxczM0WjdwNHkvSGw3cnNEWWx6Q2JEN0Nad1hBMzB6?=
 =?utf-8?B?ajhiUWNKNHpBM0pYWEZzOTFaZ1J1QUFCaWpkTjVUVjUzL2hDdTVER241SEZm?=
 =?utf-8?B?V2JOVTd6WkFLUDlmWWNnZmlWcXp5ZHVmNGZSS29lMUg2d3Z6ZnJlRzFRYWhH?=
 =?utf-8?B?c1dERXpHT3RUcjE1TStmVUFuTFJNUjBPcUZKbWNsSnNyeG5ydDV0RWVaQ1hl?=
 =?utf-8?B?ZUgyZVNGQWEzbnFpWm9HVGVzYjRkekltZks4QXdiZGFhVXVobmZJWlZTb3By?=
 =?utf-8?B?MjNpU25BOXUrT0VGcmZQdjJ0dG1wamxPYi9zcmRoaUNITnlFRkt5b0IxTnlI?=
 =?utf-8?B?allwclNYaVVqUlNJT2Zpb3ZIeTRTQ3FDbGhPYXBoa1FnYnZmMVRDRjRHaWRz?=
 =?utf-8?B?M0pNaWN2N0RNY3Bqd0ZUQnhHN3hLNk9zSy83U2M0L3VIdE1rL2VvWVliNEo0?=
 =?utf-8?B?WkJoeVpxLy81ZG8vbUZnK092Qzgya21hdkNBRElUbUJxQzE4QmR5Y3BMYkMw?=
 =?utf-8?B?M3hvUGlaeVczRGlkV2NEZjl2SDVtbm1PbUNVZnNKVi96QUwreU04R1UrcEdz?=
 =?utf-8?B?WWhWZEltVHd5elBlRmljT3FLOWE2cjFyQUt3cUQweGdmWmtPdEovTjBYcTRu?=
 =?utf-8?B?Y3NGZUk1bnFmQXNqNjdTdVRCYzFIRnlnT0V2TThLZGVJbDRzdzlkTkdmTnR1?=
 =?utf-8?B?bXlQcG00V1FKWDRHZCsrOURyYnlJcGVBdWR5R1NHSU1kRE5MNnQrZGQzMHFr?=
 =?utf-8?B?RWIxWExQazdGcDJkUGJWbE5KTU0wTHg1bFFhbW9tbnA5b2F0TlRoTHZjR3BK?=
 =?utf-8?B?UWdGRkRVMXI2WFJJWXRkSW9WaktzSHdrTCs3ckVUVkFhTlNNeVIyTlc4TVl0?=
 =?utf-8?B?OXRsRUd3RDdsa3Z6RkxlMzZOZUhmRkJNbWhwRENvakIzeGVQaE5Ea0tmYXNz?=
 =?utf-8?B?VkVNcWNyNHNmWm1saEM1Y0pvQXp5OVc0WTFXQ0ZNSE1QdVdZRlN1ZzV2bi9L?=
 =?utf-8?B?YXd3d1VpTnVKbWQwMUt1cStkYjQ2aXBwLy9uL0hFbDE3YXhZL01HZ0VXZTYy?=
 =?utf-8?B?UVRVRUtMR0p6UFlhNFExK0NBeUFQbmUwbjZLV09OaEcrcWMxeFZ3T1FaS0xh?=
 =?utf-8?B?QjM0SGNXNE1PMnRjWUdHSEFjeGZMektDWGZ5Nk9HTFVIYzZONE5DNHQvVGtC?=
 =?utf-8?B?R2RQcXRBc3gzSXF1SE1FVlE0Zk54Y2NmV0JKTHh1M2RmUnNBT2FmU3h4ditU?=
 =?utf-8?B?Qlo4dmd1ZXVVc08zbElUaTJxaVlvTlhVTVJpODB1a2ViSUU5ZnBwbWFod0pP?=
 =?utf-8?Q?OSM7+KpD2KY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk8vYmphWlJOM2dyWDJjazJLaXYxdHI4QkM0NVI5Z0s4R0l5bmovQzJsbkpt?=
 =?utf-8?B?cVk5RzZob3RZY1pHQ2xaK3VtZzhsaG10TXNUenZ3cE53Q2lxWVk5VGU3d3dx?=
 =?utf-8?B?VWFvN2V5b21DZm10TE13eCt6dytkNUtVUldGYmN4NHU2UHRSNDNXc29YQ21U?=
 =?utf-8?B?WUM5VFkxeG8xa2tUKzZ6dGI4ajB5Um9aMUVTOU1zeHpWVjBjTzF0Q0Vma0Ry?=
 =?utf-8?B?dnB2eFdHTE5EMklpVGNENWc3U0pXNk9BUjJwN1pndkZCa29IbEttRThROEJ3?=
 =?utf-8?B?bXZoS1VHTzRQTlJDZWVmVDBLZ0RjbkgvQmxBeDFvOUd1MFhGb1N5clM3Vjdw?=
 =?utf-8?B?UUVNZmR3S0VScEJGWmx3VjFOZjhXQnlHM2d4aTM2Z2laY2ZtdXlwS1FOZVF3?=
 =?utf-8?B?RU4ycmlvZEtraGtEeFFmdGVGb3dhUzNBeWRUUjk4aXh0eThmYmltSC8xRjZU?=
 =?utf-8?B?VXdxR3B1NnhsbkRTcUcwR1pRc1RyQjQxSVZVeDFlTHAwUTRRd2ZTOEVoMmJ4?=
 =?utf-8?B?U2dBVW1IQWpsaTlIdGNaM3Y4U3lOaDJSbTFiYUVjdFVXV0RUVlE4NTlWVHJI?=
 =?utf-8?B?UzFVaDU0Sk1WVWJTVnNuR0p2YzBUODBRT0ZFclg1WWFDbzE3S0UxQWk3Y3lz?=
 =?utf-8?B?WU85VGQ3VUx0TUFUa1hRL2d3ZXFUMVJTbVR2TStUbjErYThsVmdwZkR5b1Z4?=
 =?utf-8?B?NVVndE11MEVZWjU0Y0JnUGUrcm5mMDlSQ0l6b1RvczRkbXAzRmFCTy81R3RO?=
 =?utf-8?B?MmlJOVZLanhKdlZQTDJZdDNyc21TZTYzYlVWU1MwMTRUZ0JwV3IwM3BtNC9o?=
 =?utf-8?B?cnlNU3N4SWtwUndWNTFrSk5iQ2ltQTBqZ1dXbExoTU11OTBsdzErcGdKRkVh?=
 =?utf-8?B?WENweU5pOUI0djJBNzdxRnJXdnN0dUZ4eEp6NEg2aDRtUFZCUjlOVEZzVVh5?=
 =?utf-8?B?Z29hVWxMNXQ3R3hMMDQwRTc4NXBYcG9pa1dJZnNPYW1BR3hmSTJzcVdVazlk?=
 =?utf-8?B?eGY4UnMwSXhWVGVoU2dzb0IzNkRaSmtCNjlUcC9KZEZHUVMxWkxXMkFjaDRi?=
 =?utf-8?B?Qi96VVBMOEM2cXRKdXZYbEtyU1ExT2t4V2NPSW5ONjZlS3J1ZHlJSWdaVWJw?=
 =?utf-8?B?U3FsL1lVb29NMWwxdXRVSEVWellVb1Y5UGNZYkhUclg5bldyaGt0d25xd01Y?=
 =?utf-8?B?c1gyZmhaeGYrS3ZwcktPcWNocDlhczRxUzdaYWxXTlMvb3lFKytUV2U2QjFa?=
 =?utf-8?B?MWlKbExQUC9vazZLTWJSWlFmV2t6QVRUa3BXVlFHVTRvRFI4dVpWWElPR2dx?=
 =?utf-8?B?QlM4MGJsYVFuQnBpQVo2ajVUUlFvUmZvM0tZY0xxWTNxaDExTjBTSjR1N0di?=
 =?utf-8?B?dU9INFJLYVpIMncxOS8rVU9JNTFzZ2FHY0liaWE1VndZTnBRekZLWXMva2pY?=
 =?utf-8?B?WHRiWENqM0pzekpCU0hlaEVqek56K29Oc0lpdC8zNS84RVJBNHJUa1lMdGRp?=
 =?utf-8?B?NitzTDdJOGpsSnBOcStQOUc2SVFOSklaMlVkUFQ1WnZzdktaTjFTSENLVndh?=
 =?utf-8?B?dlkzTjhDZUxYL0hKb2R3cjYzc01yejNLeEg0U1FHSEFOOGYwQldCN1Mvb29F?=
 =?utf-8?B?THJpbGRIQVpDazNTNDR3K0lvMktBQ0IvLzBsUE15ZGRDTERFYXc3eTNSa05B?=
 =?utf-8?B?SkRFbUFNWTFBcDhlVEZ4Y3cyazZuenU5YzNHaGhnamJFTnYwUUI5ZlE1WEg3?=
 =?utf-8?B?dXZNcGtTb0hrSjM2b0hkSnRtckVhRm04RjA2WDNHR2NINzRKeXpidTA1RkVK?=
 =?utf-8?B?M3pDdmFRaEFTYWNxTkFyRDdhZWQ5TEtZcWhyR3NJYkwyT2p5Wm5RSzNwNnVM?=
 =?utf-8?B?L2JaODFwckJkdDQ5THlHcnhsMmdWc09YOE01MmZzTmNJK0VzaDgvaTdWNzhs?=
 =?utf-8?B?V3dBSVRkV1FhTE91NDc3YWlQWTZhR29paTFVbjRKZGtIdS8wQnR0RThMUm5J?=
 =?utf-8?B?YVQrdWVrdzBWS3lsMzFyYnlsc0JsNC9XcnVTS1ZxZjgvaW1LVGNUamxnVExO?=
 =?utf-8?B?T1J5dmNoYnNYajY0Q2d5MGlRSElhTGJGc0ErV3RYM3RnN0hnS211S0pUSkdr?=
 =?utf-8?Q?y+rOgr7CPO7rOhZQUT1ymS1bI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ab256b-627a-4cce-acd9-08ddaedc281f
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 02:51:14.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2DwFu/j6E7iISTCNDCivxG+YACOMtY49h/KRykbvYe1cVtjpILY9hZFkHOW+HtahBNkyIoJ2vz84yzKK7EaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8457
X-OriginatorOrg: intel.com

On 16.06.2025 11:08, Fenghua Yu wrote:
>Hi, Philip,
>
>On 6/13/25 15:26, Lantz, Philip wrote:
>>
>>Fenghua wrote:
>>
>>>Hi, Yi,
>>>
>>>On 6/13/25 09:18, Yi Sun wrote:
>>>>Introduce sysfs interfaces for 3 new Data Streaming Accelerator (DSA)
>>>>capability registers (dsacap0-2) to enable userspace awareness of hardware
>>>>features in DSA version 3 and later devices.
>>>>
>>>>Userspace components (e.g. configure libraries, workload Apps) require this
>>>>information to:
>>>>1. Select optimal data transfer strategies based on SGL capabilities
>>>>2. Enable hardware-specific optimizations for floating-point operations
>>>>3. Configure memory operations with proper numerical handling
>>>>4. Verify compute operation compatibility before submitting jobs
>>>>
>>>>The output consists of values from the three dsacap registers, concatenated
>>>>in order and separated by commas.
>>>>
>>>>Example:
>>>>cat /sys/bus/dsa/devices/dsa0/dsacap
>>>>   0014000e000007aa,00fa01ff01ff03ff,000000000000f18d
>>>>
>>>>Signed-off-by: Yi Sun <yi.sun@intel.com>
>>>>Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>>>>Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>>>>
>>>>diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd
>>>b/Documentation/ABI/stable/sysfs-driver-dma-idxd
>>>>index 4a355e6747ae..f9568ea52b2f 100644
>>>>--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
>>>>+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
>>>>@@ -136,6 +136,21 @@ Description:	The last executed device administrative
>>>command's status/error.
>>>>   		Also last configuration error overloaded.
>>>>   		Writing to it will clear the status.
>>>>
>>>>+What:		/sys/bus/dsa/devices/dsa<m>/dsacap
>>>>+Date:		June 1, 2025
>>>>+KernelVersion:	6.17.0
>>>>+Contact:	dmaengine@vger.kernel.org
>>>>+Description:	The DSA3 specification introduces three new capability
>>>>+		registers: dsacap[0-2]. User components (e.g., configuration
>>>>+		libraries and workload applications) require this information
>>>>+		to properly utilize the DSA3 features.
>>>>+		This includes SGL capability support, Enabling hardware-specific
>>>>+		optimizations, Configuring memory, etc.
>>>>+		The output consists of values from the three dsacap registers,
>>>>+		concatenated in order and separated by commas.
>>>>+		This attribute should only be visible on DSA devices of version
>>>>+		3 or later.
>>>>+
>>>>   What:		/sys/bus/dsa/devices/dsa<m>/iaa_cap
>>>>   Date:		Sept 14, 2022
>>>>   KernelVersion: 6.0.0
>>>>diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
>>>>index 74e6695881e6..cc0a3fe1c957 100644
>>>>--- a/drivers/dma/idxd/idxd.h
>>>>+++ b/drivers/dma/idxd/idxd.h
>>>>@@ -252,6 +252,9 @@ struct idxd_hw {
>>>>   	struct opcap opcap;
>>>>   	u32 cmd_cap;
>>>>   	union iaa_cap_reg iaa_cap;
>>>>+	union dsacap0_reg dsacap0;
>>>>+	union dsacap1_reg dsacap1;
>>>>+	union dsacap2_reg dsacap2;
>>>>   };
>>>>
>>>>   enum idxd_device_state {
>>>>diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>>>index 80355d03004d..cc8203320d40 100644
>>>>--- a/drivers/dma/idxd/init.c
>>>>+++ b/drivers/dma/idxd/init.c
>>>>@@ -582,6 +582,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
>>>>   	}
>>>>   	multi_u64_to_bmap(idxd->opcap_bmap, &idxd->hw.opcap.bits[0], 4);
>>>>
>>>>+	idxd->hw.dsacap0.bits = ioread64(idxd->reg_base +
>>>IDXD_DSACAP0_OFFSET);
>>>>+	idxd->hw.dsacap1.bits = ioread64(idxd->reg_base +
>>>IDXD_DSACAP1_OFFSET);
>>>>+	idxd->hw.dsacap2.bits = ioread64(idxd->reg_base +
>>>IDXD_DSACAP2_OFFSET);
>>>>+
>>>The dsacaps are invalid for DSA 1 and 2. Not safe to read and assign the
>>>bits on DSA 1 and 2.
>>>
>>>Better to assign the dsacap bits only when idxd.hw.version >= DSA_VERSION_3.
>>The registers are architecturally guaranteed to return 0 on prior versions, so it is
>>safe to read them on DSA 1 and 2 and there is no need for an additional check.
>
>Although it's safe to read them here on DSA 1 and 2, reading a 
>reserved value generally is not a good code practice in the kernel. I 
>would still suggest to avoid to read the reserved values on DSA 1 and 
>2.

My previous understanding was that ioread64() would ensure safe behavior
on DSA1.0 and DSA2.0. However, I'm fine with Fenghua's suggestion adding
the condition version >= DSA_VERSION_3. It can provide future-proofing
in case the behavior of ioread64() changes.

Thanks
    --Sun, Yi

