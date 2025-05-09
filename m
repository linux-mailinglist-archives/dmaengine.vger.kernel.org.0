Return-Path: <dmaengine+bounces-5121-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E24AB0750
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 02:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A6A3AB56C
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 00:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E21F5FD;
	Fri,  9 May 2025 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7eKe41a"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C3417BCE;
	Fri,  9 May 2025 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751815; cv=fail; b=SrBWyKheA7icSayy3gBfo1U+xs0xVtWepjPPny7BnEbjxEYHBb0ihU5jqN5n5dkg9vjmvKDDCzAxNj0GM50+CsbrGRY/nePK7kI0VORmJ+mk3CLBGobmiSe2TDPAONdag0wd3EJW2WyWDCquUYwdFrop6Ca50JaZLOgTXQO0GZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751815; c=relaxed/simple;
	bh=fVBCVytKGFH7GejhOl30mKft1ihvtxlm1dnEomwXubw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s/ToVm/JNNxC2pm6vX5FjTJ5k/YJ1Roccl6Nrl/P3/X31/dQdmMQmLbzcHU7zcnKPZWAoSE8+rhymJ8BacNiwVZkoW43q0nUydQfsATr1WUoIL+OP4XPu8x6uRjTdHFIpiA9KODkaZmd21+JtTd+0Jgq61913lKUbZcm+q1uhx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7eKe41a; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746751813; x=1778287813;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fVBCVytKGFH7GejhOl30mKft1ihvtxlm1dnEomwXubw=;
  b=P7eKe41aNDmorFqqW2QWR1PAqVNiG4fx3IuQO46P6v1k3fKBjM0InwkF
   JFNIyBURA/KG6VRg7k8NdAC1KWfelfiAaICZtB0OW4ALdUfaAYv/SZkg6
   JauPGlWMQ42MSrW3zxkzrfcKGgakEDiI5Ej3NFzoPfiYip2Lm2ns+LcWe
   ydvWoSiULpSeFjF81f0BZYUyHRnyVSF5Zk6zyglttoEVuimrAA1xgPEPh
   uwDbexqaZQnHYyNpS6nhqp9ErqT47PzpVKGY6CAqxM/1yMVlKjDKoMhwJ
   /J3PdN9NUnyRCQd0L79h8NLiDE2k4/EGguhO0VwGBOKVhZK5y1UIxR2Kb
   w==;
X-CSE-ConnectionGUID: bHAuzeUcR0qk9/xh17CW0g==
X-CSE-MsgGUID: jixPHS+iTzKi8OASomtiWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="58778103"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="58778103"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 17:50:01 -0700
X-CSE-ConnectionGUID: aJAxdErNRN6CaKbkp+Kt5g==
X-CSE-MsgGUID: VQT4rXxvQxSXqF3lyGPieQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="141231449"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 17:50:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 17:50:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 17:50:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 17:49:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/kJ04pmnqvRA1km0aB/YNeisBtX1l/Ea8hRaeKEFtnXdl//8J7Etevp3jZ0IDuOm00zn6jrgi2ANRtRHcrtJahJqMhc/ruuvXC0JZKBNK/BgyNTZhw7C42h7yI5ROKgTzKb4CUNoKLCOkp0jgMk6uqYVFwRPQRPV3bsdSNedgAXXMJwF9/rFxfoXxjwFCndCJDrj1zJvWrxgnOz3F9uVf3+UafgvrlbiOTvLpRgkV1sPRRULL1dsR2m+G7E5UWq+JuRexlB7yhfuA0uhuAnIFkvjZxB9CXRVhRTlUy6JM13VIkdtIid8S39h3AB6p6U/VnVq+ogZBtuBGtKKwVNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqII2/Do99iln7gvHeytpptkbLH5fLTfiq8Xyx18KxI=;
 b=f8G4e+5hA/4+fHt2D+1nxsZyw7T+qafRjSrXUIU7jJ+tuNMxrH2l6Hmn+OGgydK47QzjWgr693ItYIO5qR1RfEElaMYxNgpYfWC+sz+28eU4692xJz/GyZgN8FkuMSyVA82RfXRnxzyz05rJE5HhH2mIye5IEUkTpw6x6PjPSMmc9Qp/XHmlIa27zK0lIeqR7mJH30B47ssotpEP2KXv2vOYnw1odBSd6r3h7C34sN8jX7sIyMFIFVSQgfvfo27Z9FcGedc7asY+z/beQvCkoAMqJBDKZ4s937EFyF3n0zlHlhY9WSqINDfZc3uxhDpm8ShhzHRP5AJ/b7IyBaxd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19)
 by SA2PR11MB5033.namprd11.prod.outlook.com (2603:10b6:806:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Fri, 9 May
 2025 00:49:08 +0000
Received: from CY8PR11MB6818.namprd11.prod.outlook.com
 ([fe80::48a1:723f:54ed:a6d6]) by CY8PR11MB6818.namprd11.prod.outlook.com
 ([fe80::48a1:723f:54ed:a6d6%6]) with mapi id 15.20.8699.026; Fri, 9 May 2025
 00:49:07 +0000
Message-ID: <0cf422b2-57ef-434a-b5b6-54e69f2d46c0@intel.com>
Date: Thu, 8 May 2025 17:49:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Check availability of workqueue
 allocated by idxd wq driver before using
To: Dave Jiang <dave.jiang@intel.com>, Yi Sun <yi.sun@intel.com>,
	<vinicius.gomes@intel.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <gordon.jin@intel.com>
References: <20250509000304.1402863-1-yi.sun@intel.com>
 <b54baf68-5c4e-4cad-93c8-560195d063e7@intel.com>
Content-Language: en-US
From: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
In-Reply-To: <b54baf68-5c4e-4cad-93c8-560195d063e7@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:303:6b::20) To CY8PR11MB6818.namprd11.prod.outlook.com
 (2603:10b6:930:62::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB6818:EE_|SA2PR11MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbc4955-1211-4760-e238-08dd8e934dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0o3ZmtwSDQ5Smx1Zm96b0xBTHpHTkNvVFlSamsvTGxyUEJ5Z2xyMHpxd2l6?=
 =?utf-8?B?c0ZoelBaSjBESVcxVTlHS1NSZ1RTcDZqWWI5S0RSaE9CWjByNTN5SXBxMTI5?=
 =?utf-8?B?NFNTd0pnTkcxNmNCcUNudzc2UEYzT3I4RzdjQXppb3F1b2pRTW5OMWdLTXAr?=
 =?utf-8?B?dnVkUkhxWmhodFNaWU81NlVnWlg1Ti9TT3Rpdnh4dG4zcW41d1VDVUJsYnRC?=
 =?utf-8?B?dEtKTGxMTXQ5TzRWc01aVWxudkdqMERPdlYxK05XelhBMndNak44akI0VHRG?=
 =?utf-8?B?QmRkSmZTOUlNdmZtZk1YYXRIUlY4NW1YMWxDWVlkaDFjV2ZSRXVlYUZLZmk3?=
 =?utf-8?B?N2h5QXZuUWFqZm9WQXBoaWlseU5iWVhVa3MrU2pmQlZ0dTBHdTU5dWdTZEx6?=
 =?utf-8?B?WTMxVHRIMVhPUXExUXFjZlhCM2VpRS9mOGJQbzdYdmV3RWUxV290aERPaTRH?=
 =?utf-8?B?em1kQnN3aTk3Y0hyaXg1SG9FUkNnemRlMkJ5dzNtbGpMUis3SDI4Q1hacXMr?=
 =?utf-8?B?bHhqcSt2VEZ0Ny94QVpTTzAwWk1JbDU4NStRUTYxajZSQWhnclRIQStUMEpU?=
 =?utf-8?B?QmkxV3ZKTGRKWlNFcWYybUdMbG4zSUx0SmJNK1RQbzY4N2ZpZWFqN2ZMRHZH?=
 =?utf-8?B?QlFReVVIY2EwUS9PQUZhT0tCbEJaRG1XNkNLd2VLZVlyekdSMjRZeWtWZ1lF?=
 =?utf-8?B?ZG5CQ29EaFhQcGZIUE1wZFcybVA5dnJuam4vc2tQbmtCaGYzOE9zVVMxQUZ6?=
 =?utf-8?B?a1BDeWhXOGZ2VEk4YlJNeWFIVkpKMDgyWE5vbnlHZk5OUkF0K2c1TGw4dmFj?=
 =?utf-8?B?cTJKeFoxOG1RMy9BZG1zYzFLOHRDZWplak5IMXJtd3JBampod0dZNDRoZkQ3?=
 =?utf-8?B?OFFvK2t6NGd6YUNNMWdHL0Jtcm4zRWZpck12RjR5cTRzQWhhOXVyOVlCeDJa?=
 =?utf-8?B?Y2grMVlxWnBtMnU5dUJXYlJoWHRaeTJxeERvaGovU2JuRGkxRS9uUUs0YjA2?=
 =?utf-8?B?YkRVRlU1UHJhdXFGQmdmWTVGdS9Kc2wvWmFRT1VXNHkvaFVpRHJ2TEdkcWpG?=
 =?utf-8?B?dkRwMzhzYzRLZ2t3YkRkbFhqMUFGSmhMa2I1TTAybXJFZmhIbHVRcTJEUWR1?=
 =?utf-8?B?YU91MWFkdFUyVlRRcVRSSXNRMmthcnR4VXEvRU05Z0NVU2dTQm5UVkF6d3Ez?=
 =?utf-8?B?aS85UElsNWFqVG9qQ0E3bmwyd04vdS9CQUJpRlI3OUlTRllIUFg1dlpnd1JT?=
 =?utf-8?B?Y0NGS2JQQ0VEeWNRU0duZitDMGdIdGVkZnJWVEVoaldUb2NML0pHRnFzZjZz?=
 =?utf-8?B?S0VpZEZmckJTVkJXc3BVVnA5OHJTTVQ0ZklvM1JUUm1ZY3A3bEYxcS9jWS9t?=
 =?utf-8?B?dTltdG43T0tPVm9ZNktHbnNFUSt5VkNGRVRNM21iZk9acVZSRWg3UDhXOTEv?=
 =?utf-8?B?Yk9jbFhJd1hoMGdJRFJ4eENvSVNGMDN2TFVXYXpiOE9iQUJGQ1RaeGRTamND?=
 =?utf-8?B?VTYreXZGYm5wd2pqVjlVSzFsNmZ6WUpnNmNQZkZNbS9kdCtmNk41cWRjcFZv?=
 =?utf-8?B?Q2Mwdng2YUJlUCsyTkhtVmtuckdIM0dBQjJMSkllb2hrSEpoOEJSUTBFSElM?=
 =?utf-8?B?UFJsYXExVktqYm1EdFJiK0lpS0ZVbGRPWWFsd0NMTnZ6MVNjOWNCbFBVWjgw?=
 =?utf-8?B?WVR0RHBKdXFsaUV4d0V4TFBsSnF4VldwUHBKaVptakpVUG9zVEVoL2pNTEhI?=
 =?utf-8?B?aHFrSmhDbmMwSzQ2WXROUFBic2xkQ0o1OW85SGdIeHBhNUFjTXdtd0J0NThq?=
 =?utf-8?B?YkZ3Z1ovdExFZG4zeW1YWllqYkxDOVNTUXNVeVVseVB3aFZBSGxsVmpwOEgz?=
 =?utf-8?B?ZnlhWVNkUjRjZklOcUZ0T3kyWmIvbEM0SlJjUVZUMEZvT0hpY2J0Z1hUVFRH?=
 =?utf-8?Q?bueb8JhGHnk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB6818.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZtNFByQS9WTmZLaWNHMzRVa2wzUmplYkxHZHpUcEV3dkV6NTZoUEtYTlRR?=
 =?utf-8?B?NzVnY0NVWTl3aHNodEc1cWZZM2wzTGQ3QVQzOGp6OHgyT25JSTlxTEtSdlNH?=
 =?utf-8?B?NDczTEJSTUUxOEloZnpKWDhOQVNsQXpzNXRmczNKMTRVelZPd2RIZ0RaL0JN?=
 =?utf-8?B?SDljMkxyTzZTSlJIMlhPVzlBRnR1RUVQSElMNFBtSTdKWVhhWFdLRHJYSVYx?=
 =?utf-8?B?Q2hXd2diUzlJV2g4RVJqMzB3VnVkVzhPNjlVeDBDRkgrdEQ0L21UWklFMHVX?=
 =?utf-8?B?bi94amdNSXpKTVpIOU9oalBtRmtSaUgwUEZSUnpERWQ0aE1OQmhvMWI1VE1V?=
 =?utf-8?B?VzlTTXpoczBjTFF0RmdXb1BaL3grcS9BSG5ZdVExV3NrOVB1UlNtdUJpZXdQ?=
 =?utf-8?B?N2NXcS9KUFNlMENzZENjVXBrR0cra0UvMWJ4TE9NWTVrOVhkUk9kR3FZL242?=
 =?utf-8?B?c2l5SkxCTFc3OVMxNGNaSTh0YkhmbzJUZEpvaSsvUDBVazZBVlQ1aEJvMzlF?=
 =?utf-8?B?dWV5aXZEOEltR01pSTIrcDdmQ3ZVdE5xVmN1bHBhWTdLcXZ1cmtJVklrL2JZ?=
 =?utf-8?B?YThSaWljRzI4L1dxTWp1ZTRhUkp5dnlyQXhEdnVxZ3lodi9YSURpcXBhS0xJ?=
 =?utf-8?B?b0NEOHVuQXNmU2FVZDZWTVRUQjA1ZzBhbnhkTnlxcVIrYWxia212OVNSQmhq?=
 =?utf-8?B?MWFlV3ZYUDBwekt0MVJSM0M5Y2NBdTFXVVhKS25Wek9XZys2QmwrZWg2cmE0?=
 =?utf-8?B?UVFoUUcrMEV0TWpaN0VlL1ZqVkN3N3p2RXl5L045U1ZQYzhUVE1paGVXNFR3?=
 =?utf-8?B?bjFkYVJlNzdScldMd0RzVmxtQWpyK3M2MUFjdEU3a3J1T1MvQmNlWU5URjZ5?=
 =?utf-8?B?b1FVOXlXUzBLNmp5N2UrWmZKbTJCTTdDZmZvSVNDM2FVSXZKajRoeE52SVgz?=
 =?utf-8?B?ODRmd2h2d1gvdyt4VlcxVm15VFFNUjN2NlNVRG9QTVpwWDYvc0srbTlQRmd0?=
 =?utf-8?B?R2o4aHh3LzdaYnF2U1dyZVZZUXZaYkhWVTFVWmRnRVh2djVNNnEwWHh2V2d0?=
 =?utf-8?B?UStUOTdVVHd0T0hEU2dPM1RJZzVETmlzMGJpazlIVkNSTEJURGxZem1rWE5U?=
 =?utf-8?B?REdoMlU2YjlNUWdmQ0s5czdDd1U4MlBSL0t4cXgwaXg4N0N1ZVNzeU1PQ2V1?=
 =?utf-8?B?aWw3diszanZqQzFSd29ETUE0Qktqd0wwSVJIWDc1Z0ZqZG14eC80QmhGbUhp?=
 =?utf-8?B?aDlUMUtBNWVhWHduZ3haM05sNUpJTkVmdm9BQnNQeUNaM01IOExxVXcwM2dZ?=
 =?utf-8?B?ci9EUzVzb1NxZ0J5UXhRZTFUZG1VSHY1a2NZeFBwOWo1ZW9RaEhGd2F2SXA2?=
 =?utf-8?B?eGJaNnR1Ri9SV3MxUkdveGlRT0Fta015UjBtR3pQUTVOdjFNaFUyYWNCK0h1?=
 =?utf-8?B?b1JTN0UveG1mWEQ2TlI1SEd0OU0rNm9JTVZ3MmlBNTl5TEhkMU9wZ1hyVEdC?=
 =?utf-8?B?WWttVmVHd1luQzNFT3BvazNnWlcyQkFsTVBtQlZTYmRZSlVuaFZUbmdNaU9X?=
 =?utf-8?B?NzlxbWJIazd2QUE4Y3RqdG8zc2xvbDJqWnUvekgwRGdCSWVFZ05Qc0cySzlI?=
 =?utf-8?B?RVpZR1U4STFiNGRUVU12N3c1M243TjNxQUNCeGdBQXc5WTFDSXVIRjM4VWJi?=
 =?utf-8?B?UnpxZVVFTisreE1QWnZoaG40Q0M0cTRPbmN1LzVBNXFmWmNwVjBUTUdkVkth?=
 =?utf-8?B?blY1YSs1blh1S0pSVTdyWG9Cd0wra0NjbUczN21CV2Y0T1c0UnpzL3pHVGNO?=
 =?utf-8?B?dHpNQlEyRUI4cThJQVYzRmNWUUFGNElkdmoyMFVHaHpVcFJFVWtzcEU3TjZY?=
 =?utf-8?B?M2ZlQllza0ZNMS9aYUhLYy9CL2hpQk42bVZTblRMVVNzcVd6SmFoY1E0aE92?=
 =?utf-8?B?Q1gvTFpkZVV6WGdxV2Ivblh3OWMvK0MwOExUc1l4enQvenV5RFFiR0VGaVl6?=
 =?utf-8?B?Y0RFVU5ZemliWWg2cnNqWFhzb2FONjZuSlViTVgvNUhVSlJNYU9GaHJiLzli?=
 =?utf-8?B?QWgzL1ZxblJwOGtuTDcxR1NvQkhLbWJZUXBWVUVoSXpZYXhlODVnbWp5K05R?=
 =?utf-8?B?ZVVabG5hbk03LzIvenZ4OXgxM1E2N2ZOOUd4c1Bza1pGTk9GdEJ5N0ovMlA3?=
 =?utf-8?Q?oPht/qqxLWXjoFd0E67mgdI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbc4955-1211-4760-e238-08dd8e934dfe
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB6818.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 00:49:07.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs7f4LCdjW9qMOD5M7QEzJtG0566lhAIIbUq15Nlq5/uwCbaNz8PEax9MQHIO6ne0hSBnTor29o05wTafW6QYWdxiqRjVcSzqmT47Tfqicw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
X-OriginatorOrg: intel.com


On 5/8/2025 5:07 PM, Dave Jiang wrote:
>
> On 5/8/25 5:03 PM, Yi Sun wrote:
>> Running IDXD workloads in a container with the /dev directory mounted can
>> trigger a call trace or even a kernel panic when the parent process of the
>> container is terminated.
>>
>> This issue occurs because, under certain configurations, Docker does not
>> properly propagate the mount replica back to the original mount point.
>>
>> In this case, when the user driver detaches, the WQ is destroyed but it
> I would be more specific. wq->wq (workqueue) that is allocated by the cdev user driver during ->probe() is destroyed when the driver is unbound.
>
>> still calls destroy_workqueue() attempting to completes all pending work.
>> It's necessary to check wq->wq and skip the drain if it no longer exists.
>>
>> Signed-off-by: Yi Sun <yi.sun@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>
>> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
>> index ff94ee892339..a202fe4937a7 100644
>> --- a/drivers/dma/idxd/cdev.c
>> +++ b/drivers/dma/idxd/cdev.c
>> @@ -349,7 +349,9 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
>>   			set_bit(h, evl->bmap);
>>   		h = (h + 1) % size;
>>   	}
>> -	drain_workqueue(wq->wq);
>> +	if (wq->wq)
>> +		drain_workqueue(wq->wq);
>> +
>>   	mutex_unlock(&evl->lock);
>>   }
>>   

