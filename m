Return-Path: <dmaengine+bounces-6501-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F2B55F8D
	for <lists+dmaengine@lfdr.de>; Sat, 13 Sep 2025 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AFD1C22722
	for <lists+dmaengine@lfdr.de>; Sat, 13 Sep 2025 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37977191484;
	Sat, 13 Sep 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUKtY6Vw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AC54758;
	Sat, 13 Sep 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757753466; cv=fail; b=ddvkr0goJxmRZNERgA0pFpxLz3ddV58A9iAHwZa8A2U+VVOZp50TVz80RDZSOpRnwK9kpIXxthD7v9m0FsksNc/COTZWa43TilmVQJm9uazx6IAbncDYz/j2BYH4RFTlqQo+LpZfcs3Ozqt4/2XPNconimA86g50lSOAvYIIUJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757753466; c=relaxed/simple;
	bh=I5xoPg1MFPTE00pmg63NCaODNiMmGrfrD7Il3S/eeog=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dj6a2qd1pMUuNui/iD+ZUInPItSpHG4Bbyk6Z/AiXx0hanJMVusSLnbHX/1hH3umxCCRDmKJEiN4QGA6Y3kG9Y8EvcyHqzlVpdtx52ez0sd9UVVdVPxgGhg7HtyuSavG1RijBveyd2PuUh6HnzFO9GfZTAeXU3YQG+BVinVaAO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUKtY6Vw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757753461; x=1789289461;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=I5xoPg1MFPTE00pmg63NCaODNiMmGrfrD7Il3S/eeog=;
  b=LUKtY6VwQK+I8Pw2H+oMyOJKGEJqJa/xMRvnAg4ZqKOHiYIDMQ6t+UoD
   DEWIrsLuxeYTLH54tZtyug3SLECyT+orird9061q0G4hD8PFzutukPxgj
   Wym+scQq2f5XvEKaYDAmtONkFNohmVV0kDtxRXWGU3uREloUaz5gitCK1
   2owcGFUIXXM8xXkBKVnRXR7mZT2BAv7lH2eOLCh/x7+3/rctXKOVL0soT
   /y3rPVYdy00AjUFxwJLcCBPReEBKFNPwCU8bAPHTyvu1Fn9UQB638AkUG
   bWkchOdEvI20Lb4rZ1rib0tXAHV9jGF68NCWtAmNMevSjWGO1TN0RErSs
   w==;
X-CSE-ConnectionGUID: 7SPhdBLMQNewViLzzFC8aA==
X-CSE-MsgGUID: ZbX/sD9gS3+4sMNwkytrmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="71455732"
X-IronPort-AV: E=Sophos;i="6.18,261,1751266800"; 
   d="scan'208";a="71455732"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 01:51:01 -0700
X-CSE-ConnectionGUID: 4DwZrd9QSwylk62EIdC+kQ==
X-CSE-MsgGUID: eP4tu9oKQxy1aJlmvOYEAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,261,1751266800"; 
   d="scan'208";a="178545524"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 01:51:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 13 Sep 2025 01:50:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 13 Sep 2025 01:50:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 13 Sep 2025 01:50:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBSAHH2lN7Hzvp7FqHG+rMeTnFzoE7hiR1taBupJfOW41DLdrYke8Eak9UJ+C2S8EGFQ02JafhtuTvKUnCGH7cDf16CCbm1Lnb+k4LMvvDs2gAY54f7k4QWnNZWPeYJuHd8bMyeOBnN+j1D7o2sGc4l008Z2cRHKGmGQpDe7eVuoFp8BzNEjOWn7wNpQL+zxCwPTCKtTuhYQm3qWRXMvI3SefcsyIlcKEJDIY42Q4QoSywScXXwCFNpt6/QtXgbZ4e4j17cIon/7uIvUbqsj+T+pwCHRjmPeTnM+TDrkRPHGAqdeABlBaC65GoSqgnPcQIXDMFbtz9mEbocRATrgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpv66eJgRRJ6PhqXRQn7Ak+NmG1SFXakqsqfAnmMKVw=;
 b=gOZIs+j6vb1Oxmk83JoF+suQ278eOdj/LqZsfX35go4nGCH/Kl9SiBNocL6+f/y1Vb/P87UIsGp6tm4a3eX5nQ10J5kMP6nXiJoqNGYjxsXg+S6alNTobKkM20YXujR9qJsJULQ79TtlFbLWucro1MI4w2x4cJk9xMEys3nRRS8Yt9FtpZwT8y5hrRwaLA7lGUW/T+dQ023QTo2DrJgG4TAnpOHl2T9lofUInMfyAc4KvsidR+/tBQM6pjbjy2dZuVMqdCCbc/MG//0e+dtQ7QvxRthROFrC64tx9D9Qr4mUNDP6fmoPJZm26ft0NuEPhW3RQ4jppiTvJINd96aMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sat, 13 Sep
 2025 08:50:56 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::4f39:844e:6958:f9e8]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::4f39:844e:6958:f9e8%4]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 08:50:56 +0000
Date: Sat, 13 Sep 2025 16:50:47 +0800
From: "Sun, Yi" <yi.sun@intel.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Jin, Gordon" <gordon.jin@intel.com>,
	"fenghuay@nvidia.com" <fenghuay@nvidia.com>, "Lai, Yi1" <yi1.lai@intel.com>
Subject: Re: [PATCH v3 1/2] dmaengine: idxd: Expose DSA3.0 capabilities
 through sysfs
Message-ID: <aMUwZ30sz9IU0gEO@ysun46-mobl.ccr.corp.intel.com>
References: <20250821085111.1430076-1-yi.sun@intel.com>
 <20250821085111.1430076-2-yi.sun@intel.com>
 <aLab55JCvLcbOm0S@vaman>
 <DS0PR11MB637482C854F7C5FF32033D8F9906A@DS0PR11MB6374.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB637482C854F7C5FF32033D8F9906A@DS0PR11MB6374.namprd11.prod.outlook.com>
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 016ffce4-4757-4b42-1b7b-08ddf2a2a6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkFscHBxTE5TU3dvYkVvTVgya3BLd3B0UzIvZUNXQWdZUlVnZkhDYTF1Sklo?=
 =?utf-8?B?VForaVoyRzI3MWJSZVlrekpDbkdiTWo4Wm5oOHVqTVF1Q0NCZHBweTU1MSs3?=
 =?utf-8?B?S2ZrRElSNHJnc3gyRHllb1NBSnh1bFQxUTVuZmNBMlhGdkVaREFZUENjYjVi?=
 =?utf-8?B?UkJxaEpaVmJwMVNxbVdGSUNVQ0dPenIwMDhxWjh0Z3ZvaFJONGk3QkNIbzNN?=
 =?utf-8?B?a0ppbW5hR3RaWGx0UEpSUnBYcTN4bGllMThBaWZJcnV1VklHd0tsaTF3Tk83?=
 =?utf-8?B?TDI0eWhXUWFqN2JtajZVY1JBejdiajFJelFsclppQytqelE0dG03bnN0Vkow?=
 =?utf-8?B?bkFwVEVpaWlpc0x1TVpULzFiWnB1bDJsVnhwRmRaWFVqNTVxaUZENVh5WmlS?=
 =?utf-8?B?N0cyKzNkYXk3azB1aGZ6VWhVOXNNODU1aWticGV3MWhNZHY1a0NvdFVVMU1F?=
 =?utf-8?B?QTFweEZvUTVnQk44N0ZIZlVnK3BhWkEyZlplMjFETEcxa21GeFkxaFFuMW9n?=
 =?utf-8?B?bHhVK05sd3NzbG9OMlI0d29lWExTRFI2dFpWOHQrZUVhSjF1NVU1WVg2WmZl?=
 =?utf-8?B?eDhLeVBEZFF3cGM3RnhGQ3MyeDdkVmFQVTZNMGl0OEttV0pXVEpKc1NLeVlV?=
 =?utf-8?B?RVlpTDllK0lobjNIU3d4UlNqSUo0NDErTmJNSERPSFo4dHVOU3ExVFNVTnRK?=
 =?utf-8?B?VXAvY1NJMnBxVEtKUE83bjJyaUplR3NwWG5oOXN4VzFEVjMwR2g0YkQzeFRm?=
 =?utf-8?B?MVdrLy9TSDl1cEcrV2YvZkNibHFxSmtpK01vd1p6d1UzemFEeDJadzkyMHRB?=
 =?utf-8?B?aGRXdkwxRDVaODZrb0QwTTJISEJ4M3JuUGR2ankzVnQxSlMxdElJRFlFL3dH?=
 =?utf-8?B?K2J0K1U1cEF0RHVzalRySFhIVmJSemJXbHgzN2o2VEI5ZjBDcjFLTGR3RW0r?=
 =?utf-8?B?U1ZzWTR1bHU0UU95VUxyQXFqZmVLb2c3ZkEwUnpaUWc2clZCamRsZ0xGczdR?=
 =?utf-8?B?enk1OGJQRDVOWlkvSjRGNDgzbEJwR2dEYVRvWlczNlJjWU9id1NuWXBPaXFT?=
 =?utf-8?B?V29oVG51UFFEcUprTExKYTVXcGdWRmZWd2o1c0R5a1ZLQ2pQQmprRER6cGY1?=
 =?utf-8?B?d0h1bWtwbVdZaFhEc1VqSkE5MU9TY2Uzanp4MmI4Z29GNUZqQUk1VmJKdzlT?=
 =?utf-8?B?K25xcE5Fd0l4YytDSHJVY1hiTVI4NGMwQ3l5bEg2aXBYWkl2ZWFVVXV5U1lx?=
 =?utf-8?B?N2lGVVd0U00xTGNLQVAxZlpaWkRsMmszMDVjTHp3SFV2SitUMjRDRThWUHlw?=
 =?utf-8?B?aWFqNW93cDFxa1hrSkUxdURTNXIvOElsa0hnUnh4Q2pkcThvdFRWeHYwS2hi?=
 =?utf-8?B?bnlFK244TlUzekNJRG9TWGlnckgzKzNHRHVYQUhueC9SSVZDbmh2c0wyVTVS?=
 =?utf-8?B?MG9SdE5YblBBbitqeHFBTUtoRzNuVEYyMHRuUng5NGU2ZjZWelFhVVplenJW?=
 =?utf-8?B?WDMzYXZsUDdlc1JTVk5sMFRvVWlXNitQTUpSdkRuMjl1bk5SSDhtUERibzg2?=
 =?utf-8?B?YlBVT241RmlwSmZxL1BlRVdlQ0drQXRVNVcxejZ2ZmFnVnAyc1VYalJuWmZF?=
 =?utf-8?B?UStGUnhoZ2x0ejZQN1Jwb3I5NUY4dkpmZExYakZOTzBEdm1wQisrc2Q4Nkx6?=
 =?utf-8?B?NUtoSHRES0Nwa3cwOWlQS1NBaDMxYlF2ZEhrbDNWaGxpRVEzb0J6SndEYmEy?=
 =?utf-8?B?NHB4dTdNQmZEV2QxUy81R01CSDdiOGFzV0JJM1crS1dpOGpYSURGTUhrZHVI?=
 =?utf-8?B?Y1ZCbDlvSnEvZWdmcit0elZRYWVBbUFndDkvZVRZYmt3cUQ5Mms4M0xhbEtP?=
 =?utf-8?B?UFYxUGZ3TkVwb2JTYWF5VHk3WkRVc2ducGtqby9DYloxSjhQWVY2UEFuTlBs?=
 =?utf-8?Q?m7IbwKWNP1w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmNsU3dMcXpiVFFvR3Z4MHFhdzEyOTh5WGQ4cGtZSnRkWnFVUGJqMXBrVWov?=
 =?utf-8?B?SWk5RURkZGIvaTlwUitCL2paSVJTNHNWZkRwK1VKNXNKMCtDQjl6NVY2Ukw5?=
 =?utf-8?B?NnM2NXNiTVZWNkVXLzhacksrdGoyNE9ZV0ZyVDZqU0NjY1NybjNDQytBUE9J?=
 =?utf-8?B?c01RdDJBQXd1ckFtYzJyRVI3QXJjTlZ2aENzRGtJcWJGT2lsditnTVhBdVB0?=
 =?utf-8?B?M1RiQk5JWk5pNzQvSTNVYktnWEd5RkpzZDc4VUlRckxjQUU4M2FyaGNnWTla?=
 =?utf-8?B?RTE4V3c4b0RvSE94MWlHUUViTFlaa1c1TWErck9YcnZUbm5reFlUWHNqMGhW?=
 =?utf-8?B?dDNqVUxwSFV4NS9ZUFRCNXVHRnptMmdDTkdnTUh4NXh1RVlISlQrZkNwQ0lX?=
 =?utf-8?B?bml5bUpOcUwyY1NKVXpwMWZtOVcvZ0V1R1lQY0RzVThJWmxQeEZxUHVRdnBH?=
 =?utf-8?B?Y09EODhUMUxpcElhY1ZmSFJzajdBdTJUSElUQ3dMcGxXa25BVDJ5ajVSaTEx?=
 =?utf-8?B?S2dzejVkV0RDaGt4NXlJemRNbEVIOWNaY3JjWGh4U3QyMVZDSEV3QkZDZkxZ?=
 =?utf-8?B?Q0xXWkw5OWR1U2xyNjN4VGNhQytBNTQ5RzY1dEY2ZEhad3Ftd3NDSXU0YW5t?=
 =?utf-8?B?dnpOTW1wN3dQTFIxM2RYdk05RFZPMDlXZ25OK0Q0Tmo0QnhIcU85cjBTai9t?=
 =?utf-8?B?QTA5NDRseC9UeGtWNmQ5a2ZJYjVIdlRUU09xSVo1dERmUXJ4T0xTNFdORUtU?=
 =?utf-8?B?NjlITnRqTnNvZ2E1MFpsUEZBU2tlek9yQkJEdmxBU0QvVGI2b3czSlNTd3NB?=
 =?utf-8?B?Wlgwa0QyMjliQnIvaFhjbDNrNzd6bXBtUmVHZkFzdGd2a1VUS3I5MmxmRWV0?=
 =?utf-8?B?b0hVaFhXMGZuOUEzQjUySEZCNy80L2NnaGtLMUlkbUJzd2pGMG8ySEhvWlox?=
 =?utf-8?B?a1lLYUZrdDVPSVg5TzlLMDF1RGU3Tm9CYlpZMGY3Z1NHazh2UGdEUnZFZXBO?=
 =?utf-8?B?WVJvYWlQT2JyazBKM04wUU0zT3pHWm13SytHNVpGSDc0S2E3aVZITktzVElM?=
 =?utf-8?B?bXVXYUg5YSs2Q0RYZjVYMUpBcjJlaDgzalV2NXN6UWZzUXdoRkZEdE5ST0Rz?=
 =?utf-8?B?RUxBNER2am0zRFNEbVB6amVRVWs2K1lja1ZUYnI3dmFVL2h2bzNrUmVVNEFa?=
 =?utf-8?B?ZTJwR0Y0bDBFN1VHajQ3WFQ4MDVvVG1LK1BiTXd5RGx3U05DakxCOXBEYzEr?=
 =?utf-8?B?UHEwMVRoc0JjTDd2aWxveXNVaFFpTWE1V0JYKzdRN1pFVENVN2tVR1QwV08w?=
 =?utf-8?B?UXZPT2FGTzNnQitmUnRHT2REZk5NSFIyajVHTUllQ3lFNjlseEtjSzZHYTNZ?=
 =?utf-8?B?cmVndFNqbjRJV3J1U0pMTyt6ZHBLci9QVVBSNHZ6ZFREbk5SWlBJZzhiVC9E?=
 =?utf-8?B?dDNTWExKWEJldXJDcnQ3THJIcTFzT3VJQTcvTzdHOUM5VCthaFpZOWp0LzU1?=
 =?utf-8?B?K0ZFSFlKdjV4dzhiUHlTNWhtWVFjcHp0VmNVQXVIaDZUcXRGVHJhU2hDRkZy?=
 =?utf-8?B?ZisxTWY1OGJFOFhNTDBwZHBnSFRTUnp2bTlGUnQvM0tMeG55cDFoSXp1dTlw?=
 =?utf-8?B?VmxyT0JObWtpbG1venNIYkIxbzFkTE9wa2gxRXhZTDBESDhaK0tFWGdia1U5?=
 =?utf-8?B?blFUdlpkbkMybEVHZmpKM3owTmVDTUthcnllcEs2VGFTb2pnZnkyUTJlSUxD?=
 =?utf-8?B?ay8xc3BEaDE1NGZ6WkpsOHRoVkRYdHpubHNLSXg1R0M0SnVpa0M1eGY2VmJP?=
 =?utf-8?B?UXpaVzdzV0JDNDhjUW42NU4xVGk0Z2VrdThOTkNHL0NmQnVpYnNLYWI5T29w?=
 =?utf-8?B?czQwL0hjV05HclRleUdrOGQ4dWwwY3oxRDAzdzhXbyt6bGxMUFcxZm4rM0JN?=
 =?utf-8?B?YUNLQUNnQXdiMHNLSGRRSFo5Q1RVVjZTSFhzUFBqRkt2ZFRoaHhETXEyM3F5?=
 =?utf-8?B?b3p1cG5objRyN1YvQ1JaY0k5QmpNdTF5UCtGaHlYaWRXcktUT2l0QXA2cENi?=
 =?utf-8?B?L0xZTkl1dGR6bmNrMnY3VzB6bUpmUEZWclAvVEFpdlU4YldFeHVucnF6NG1W?=
 =?utf-8?Q?EF7iV0W/JDhoFztrIWRTN7mcy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 016ffce4-4757-4b42-1b7b-08ddf2a2a6cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6374.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 08:50:56.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDwMZMCgn6OqWnTaCmkqhSHK9G1Gg2cirj/Gn0LxtpO7linh/BKDP0ZtQ1DkUbBwnL0QnVnLlzPcJXxQ+OdDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com

Hi Vinod,

Gentle ping —— if splitting into three sysfs entries is really required, please let me know so I can adjust in time and avoid missing the v6.17 merge window.

Thanks
    --Sun, Yi

On 02.09.2025 16:34, Sun, Yi wrote:
>Hi Vinod,
>
>The three capability registers are consecutive in BAR0 (0x180, 0x188, 0x190) and represent a single functionality. Exposing them as one sysfs entry makes their relationship clearer and avoids clutter, since there are already many files under dsa<x>.
>
>If more capability registers are added at sequential offsets and for the same function in the future, they can be appended in order(higher offsets placed left-to-right) to maintain consistency.
>
>We considered exposing them as separate files, but agreed that a single file provides better clarity and reduces noise.
>
>Thanks
>   --Sun, Yi
>
>-----Original Message-----
>From: Vinod Koul <vkoul@kernel.org>
>Sent: Tuesday, September 2, 2025 15:25
>To: Sun, Yi <yi.sun@intel.com>
>Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Jiang, Dave <dave.jiang@intel.com>; dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; Jin, Gordon <gordon.jin@intel.com>; fenghuay@nvidia.com; Lai, Yi1 <yi1.lai@intel.com>; Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>Subject: Re: [PATCH v3 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through sysfs
>
>On 21-08-25, 16:51, Yi Sun wrote:
>> Introduce sysfs interfaces for 3 new Data Streaming Accelerator (DSA)
>> capability registers (dsacap0-2) to enable userspace awareness of hardware
>> features in DSA version 3 and later devices.
>>
>> Userspace components (e.g. configure libraries, workload Apps) require this
>> information to:
>> 1. Select optimal data transfer strategies based on SGL capabilities
>> 2. Enable hardware-specific optimizations for floating-point operations
>> 3. Configure memory operations with proper numerical handling
>> 4. Verify compute operation compatibility before submitting jobs
>>
>> The output format is <dsacap2>,<dsacap1>,<dsacap0>, where each DSA
>> capability value is a 64-bit hexadecimal number, separated by commas.
>> The ordering follows the DSA 3.0 specification layout:
>>  Offset:    0x190    0x188    0x180
>>  Reg:       dsacap2  dsacap1  dsacap0
>>
>> Example:
>> cat /sys/bus/dsa/devices/dsa0/dsacaps
>>  000000000000f18d,0014000e000007aa,00fa01ff01ff03ff
>
>sysfs are supposed to be single values only, should we rather do per
>capability? Also in future if you have more than three...? what happens
>then?
>
>-- 
>~Vinod

