Return-Path: <dmaengine+bounces-2999-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BF296352D
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 01:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77AD1C2152E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 23:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0121AC45F;
	Wed, 28 Aug 2024 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FklGtVIF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C289158DCD;
	Wed, 28 Aug 2024 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886430; cv=fail; b=TOjE6vu9YsxPXTqZK4fFTYTD8oGX7L4b1+S7/rn5DCj1ah816qaU25o3k8jxBgRa3X90yAdU1fbc3lqXTYN2uTxLvO39zLkroynmdmvot4aRbkTL/8QY2vj5ovSztnFzfXwi53SebzKd7Hflu92VJCiqAcoJj06mT2iNJfN/vMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886430; c=relaxed/simple;
	bh=9Nv+NPU7jxjtvyUq7CwG4VuoxZl2CtysgOyjE0F4mUk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jaMRKYkXdCO9/7wbTlOt/9OJA0pU9ruCnFOpp4aiSy7K7plvePXRfF/xyKb7sH6R9H4fZVbVyHdSFi2zkODxCgWvxQstoFx4NuKvFp+UvJJEQWrHn/kksA8NlI87TyzURopWRFeyHEUFNR8rBzleA1sZpOcode/7mYLHRfwnb+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FklGtVIF; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724886428; x=1756422428;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Nv+NPU7jxjtvyUq7CwG4VuoxZl2CtysgOyjE0F4mUk=;
  b=FklGtVIFNAnMNYxtNAKM8nFt1If2Gca3hb3Px+15p9Y9DMAVXDx7YUBb
   L+AGl0+CNxY1aq7vXgO9rhTH8ppY6Xg0aatByNttPAuhxWAYXiw8t9zmJ
   cr/B1+omZo+8QTWSObhYhjJouctga7tas3i4nto2J0E2b2Bdz7BVTsJwh
   2FNU2ny5Df9TaM3xzd2UgRezc8xMQYSVAqzjWc8Ma6qYgEDlAYhuC8JjB
   6xK1JeZN1a+D2ZiBU2rd+pLXkz6XNvUNUrHo4Lzv+FkttbJDcTPD/nFCo
   QfsoD1OylG3MojqYrDDYj1Ysi1vOlsMTY2Wxn1p18jpV4zkeOEkwHYAf0
   g==;
X-CSE-ConnectionGUID: qfQ7nw3fRHSbP+xGmcqv0A==
X-CSE-MsgGUID: b61FcpccTim7XJXgIXBKvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="48831670"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="48831670"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:07:07 -0700
X-CSE-ConnectionGUID: racxJBumSdiRe1GNzMl2FQ==
X-CSE-MsgGUID: rFS66iWsRvmS6lUurpqd/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63214421"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 16:07:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 16:07:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 16:07:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 16:07:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 16:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtluNRFZCiusWE5Be55QB0/emFn5CEMhdY8bpashM6qxRp7CxUDslnVaM9mJ9wvwNgHp+6XKXgHu/yKNs7xSoucRSNIdSNCiTC2wQ624L/i2FE3pLQTuQpzt0jBen+VCwuquodfi970TDqw+PcO6UIEDw28tCYgFHqjn3erxBCYVbTrtW3QV1/3x8bGjxQB4XoOzmUXfaSLxKfx9RJh8S/mPoZWPWOq4SZ0Lbj1l3wfwxS8n4lntDuTzB5X1QKFRev+aYRfFtwjYU5zCFGCEOCztIwJukweXYzpEpXwIZjElo5ezpuWlr9IdyKxGRrISmwMCjO6wlUPlzILLpkHACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O7H5kX5TawBUfHBvNdIky2CO1yC06hNQwz8J2DjixY=;
 b=OBvita2k7uLMuVeFL6i2nsa3R0w8N85Ff2i6a82THlieR1BYZ4wmq13T0pCzWyR2cOTx9V5bBHBDqWhWBKFS1OrX0uNvHCHcit+ZU3+SU0a05nYsQNIRWGwrzpCrhg0qqPzm2gPTWomfoHwDkVizyzQx8At8Dc9enmjVshP9TJuW9CQKJPnHCI8bFGFSeIttPGAAkGL+cYS64jM7EHgMXQFEkvBl9tbhiC1AcbE1hF/MABq705NoOLTnYO9+U3gABGL0lEqB6JqZUBPFo0tM3kv+OEpni/WIc6G55gvoxiyYuCDRL6p8BB5ztS2SbRzEvclmTuGWO1PJKXjcpv+ivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 23:07:00 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 23:07:00 +0000
Message-ID: <f3c438bd-7346-62ce-5d5f-86b97f8cdca1@intel.com>
Date: Wed, 28 Aug 2024 16:07:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] dmaengine: idxd: Add new DSA and IAA device IDs on
 Diamond Rapids platform
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20240828224204.151761-1-fenghua.yu@intel.com>
 <20240828224204.151761-3-fenghua.yu@intel.com>
 <d8505c21-dec0-45ce-8757-e1aea7ca7432@intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <d8505c21-dec0-45ce-8757-e1aea7ca7432@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 095ecd58-eead-4052-9391-08dcc7b61f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0l1amNwQkZIYzYzcGdVUTcyajFCL2xvOHc3NkYrRGwxQU01VVYxNHVLQXhI?=
 =?utf-8?B?SUMzZnlIZXphSkw1RFRYbk9XUFd0RDFSY3FVWnc2NnF0WnY4Z3ZYd2g5OWth?=
 =?utf-8?B?MnB5QzJkcjA2YWt4VkVmSXdsaDRYVXQrdVZMeVllbEdVdW9XWWVxWnI0Yyt6?=
 =?utf-8?B?MjFjb3ppWFVOTnhQeFRjaGNrdmZOYkF0RjljZSs5ck5Sd0lYRTJyUUpjb0hT?=
 =?utf-8?B?c3VjZUNZczBtYUpyS2tXUVBIQzlCcXBwU2Yvak8rNGZuMG1KVCtSWXZDa3Fw?=
 =?utf-8?B?QVpFOXl4Z0dwM0RmK3VzT1hSNkttVjYyOGJXRVJRMFVzWElwdEZVRTlrQXR6?=
 =?utf-8?B?NFJEQmtHL3RrLzNTbDFnU1E1M2pLZTZCMWs1dVdqM25WZkZ4T1lsVHJIa0Np?=
 =?utf-8?B?c1FSWDFZVTJPRFdzZDA3c3NFeUVhQW5DdlZaU3hJRWVOaFJWMDh2OUI4UnFD?=
 =?utf-8?B?ZDI3cU5XSUFhNnF0VFFmbjhSWjBOV0JxME1FSjYxYzFWVVhFQlNhU2Rsdnp6?=
 =?utf-8?B?Sk5Od2tpQmY4U0hENHlIQVZ0S0t1SlJMUVAyYVV1bGJqKy9jbHdJcHBnT3pI?=
 =?utf-8?B?TUQrYzl0MWI2a05yRzhVOGFUYUw2OGg5Ry9ieGo5bEJzNEQrblViZUVRMmU4?=
 =?utf-8?B?RWxpWEtwY1pqcHY3VkZqVjFhTFNxWHkyUEIwWkJZTGp5NlRIQlZFOXRONUo3?=
 =?utf-8?B?UC9VOFNZeVlSN1c5YlVmZG5OenE0dFNwWlc1Mks1L2tJYzhyMGNZWG5GU25J?=
 =?utf-8?B?YWVJbEliK091eGpWMTYzUXBPOTI5NVZOMDJVUVBxMkJ0RVN2RzZONXZnZFEv?=
 =?utf-8?B?U0VsY2dpQ2VVTy93UFMzbEhCSTNzZHd2RTlXRTBrQWdhSElDZ21YMGVKR3A3?=
 =?utf-8?B?VW1SNjhjNWNiM1RkcGg1S3U5YkVQU3RFcFp0K3JiVVBBUmRqSzhLNVFQVzNo?=
 =?utf-8?B?ZUpvZU8zMmEyWTJpR3Y3TjdFRWxFYkVYL2FjblJMUkRob3dsL1hHVTNNZURZ?=
 =?utf-8?B?SXlVOWlKZlZhNUlFR2xpNmJPamNqM0xZMms1emtjL3hZZVlyZXJrZDhEK2NZ?=
 =?utf-8?B?dmFRVjloaU5lVHhmalVrWkRlWSt0aGlrR2h6bXptWEJoVXVMcDFoWDV2Z3FZ?=
 =?utf-8?B?NzFGMENsNHRQbTB5Q3dGUjlDeGhzeHRlSXR2YUFGNnZBVFpsMWx3bWszcFVD?=
 =?utf-8?B?dy96SlRTdEMyeVBYdU5mc09lWlA4dXZaR0NMTGJ2Q2tFdW1OcHU4aFR6Z3pt?=
 =?utf-8?B?WXhKbjRpRHh4VmlQcTVtZDAwZVd5NThnMWVTbXZUWUpQMHBPNDRCSFg2S2dX?=
 =?utf-8?B?U0NmcFp5THJjUTkwVlVWS2QySk03VGw4SkNwSEx2SEI2R0kxY0gxSkZRNlI1?=
 =?utf-8?B?cVpLME5Ldm1RSENZcDQ4ZEUxVHY5aVpnc2x1NGozK0hLeEZPZ3FTTW5tcVdj?=
 =?utf-8?B?MDhIdkZ2ZkdxWW9xQTk4akk1ckZ5WTVQVm5oQ3BscU83VG1wb2NMVW9lTi93?=
 =?utf-8?B?OTJyeVdCeXhoTjBqbDRMYng5ZjFyei95cDdhTk9qSm5vZFBFQjM5SkJyZW5G?=
 =?utf-8?B?U09aTGtreTZseVZVcEsycEdndEdVUmppYjlDcFVXK0pKOWdtdjEwRTBEMEwr?=
 =?utf-8?B?dUc3S1RCL1E3ZFpuVjExV29hbE9TMURvemd2UzBjT2w3ZUY2dEhiT0pHNW9x?=
 =?utf-8?B?Nk4zZmU0akswcmtEN21aYTJGWFNkRGVIcCtwTnM5bTJTRm1VVy90WlU5Y3hJ?=
 =?utf-8?B?R2lrYkphMFovWWpHM0NvbzlnKy90elNaa0M0TElvY1R6eU1UYnBMeHQ2Z203?=
 =?utf-8?B?VEJyZHZrMGxKMHQ5THJqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REpaSHlMOEloWTIwT05OYXVwdXU0NTNTVWdkb3k0SSsxbGxrUHZuaDFjYkhC?=
 =?utf-8?B?dVJJTHZ4U2ovYllvMjRXaFlGaWR4M21WRTM0VE04bmtTRVZyS0pCc1Q1UjBS?=
 =?utf-8?B?UlByVjdhRDFhNzlUaHY0MTNoR3ViTmViVUN2ZmRiL3VlUjk5NWdpbDBMVkY3?=
 =?utf-8?B?a0VEc01xam5ieDZ0dktvU1ZTaktVOEd1dFpiQlVPUGVmMjdHZGpvZ2E2bHIx?=
 =?utf-8?B?dkp0UTFrNVNTQWlHa3poTVFuditnTWZWb3ZWaEY4ZXJjVTFiQkhiNWloSDI3?=
 =?utf-8?B?djNGMG9EeFNFWUdubEFCSEkzVlo1Q3R6bWdZZ3psRUExVXRSMCs1UE54ZFJR?=
 =?utf-8?B?WVBWMmlBc1ZLNUpCbGpMNDdxUmdaMXE2N1kzdGZhNi83TjRsbUg5bWdldUtl?=
 =?utf-8?B?aVVIMWtKaWJZLzZod0wxRW1pdFROamkzZ0g5b201OWRERHVKVHlwV21EL0ps?=
 =?utf-8?B?UVBROW1sZGIyTW9jK0xvUE9qTVBEOXFnVVVvbkZRS21EVDZ3VTZiNmVPYkZK?=
 =?utf-8?B?a3RXTDlkNm96U0YxcUQ1dDN0U3hxeXVHWms0QmEwRUxrWDlyRS9xbStEdGRx?=
 =?utf-8?B?QVU1RmwzS1NSSVhkUDFzeWFvSktMTitkM1RGbGJVZzVxR3Z4MDFtMlExcThQ?=
 =?utf-8?B?ZzNJV1FlOU8vbWVZN3VUYzdFLzRpbVc1NllVaExVRFpYUlBuU2dYaWlMT1Ft?=
 =?utf-8?B?NUZNWkZpaldCeEJaaVA2Qzl1cHd5ay96ZmtxM1VGa2taQk40ZmtVOVBkMVFh?=
 =?utf-8?B?b1hiWDhhdU5GSlRWaFlCYjVIS0RtMjhuK3BlMlhONjVuRHZ4SEd3bXd5K0lr?=
 =?utf-8?B?N2F1TFFNU3RsU3BwNEZQRHkrZmlnMUZlcENhWlJIQzc5VUNCVXozaVJLV2s4?=
 =?utf-8?B?NmQ0dTA4K29KU2VNZ1NwRUdpMkY0QzdxeThwSWJBOGw2WlIrYUQyeUlmZGhy?=
 =?utf-8?B?KzdKNDlZUCtyMUtpcGpYVnBEdUFhNUYrTHhyZHpaZjgydUNPTVBvaHIrVjRt?=
 =?utf-8?B?WXhuY2tNTEtDbHF5L29EV2pyaWxWL05pY3hHamF3V0VXNUlVQ2ZGU1pRSGNp?=
 =?utf-8?B?UVY1N0NoZXg1THFWZ3JKYm9UYytubGl3WGphSURYMmI0UzZYbERBQlpJdEJP?=
 =?utf-8?B?THRCTHpNQllNS3FLcHpjeDNZVk1FK0FyYWcxbVdTWVNhNUxBOFlsRmRWMlBh?=
 =?utf-8?B?REdMeHJ3bjFFK1NDenBZZW9uanlrZmd5b1hKNU4vd0hmaWd6L0VPVWsvRjdR?=
 =?utf-8?B?QU9SdkNLSTBRME5OOFhQYUI4TWFVN25SRVpuRURZNitiOC94dG9zalkxczl0?=
 =?utf-8?B?WHRxOXNGU0hZdDZJTzJLVDA1ZUw2QzJQRUc4b2tNT3hmZzFQSTBRb1dkczRH?=
 =?utf-8?B?UEdTSW4yZ3g2eDRlYlVVYi9nZjRZeFBwSm1UalhucWJ0NWZIWnZoZ3YyTCtB?=
 =?utf-8?B?eXVKU3ZCSGMxSnpEREl5TEt6YUNyUWJNWDkrN1l0VndEYmU0QmYwQ2hlQzht?=
 =?utf-8?B?c3pEZGg5Z1ZxTDE3WVlmWmtmc2YzNGtkYnBaZTIyT043djM1YXFjY1lsZUph?=
 =?utf-8?B?ampoQU00TlkxdmExV3F2Q2JNM1orM2dYMDhDQXpaZVA4L1JWd2hXc01TeDVC?=
 =?utf-8?B?bnU2ZVNUdlorWDJybFlSUVorRnF1WlBtV1QxSFlDS2hteUcyM1ZpbTdOUll3?=
 =?utf-8?B?K0FuRmhuOURUMkVTNXp4TWg4YUd4Y1F6cVZ1bGM3V3R2blB5R2wyT3pVcXY4?=
 =?utf-8?B?UTlwTkpZUjh4UHZEMXJ6aUl6RVZpalRPUUd1dXpjNU9SWU5OMklQc2xnbjBP?=
 =?utf-8?B?OGF1b2Z4aVNzNCtjSUZXQ09JVDgrNHNUSDNTYk8raUgvOTIxYXJxSmRHSzAr?=
 =?utf-8?B?VFZkeTVYcGJNcENqUjJLN3RQeCtVbEw0QjFYdk4veUhvbkFOTDJVQ1l4cGRD?=
 =?utf-8?B?T2V5NWw1NU1rdlZpTXJ6N3JpRkJwd3BXNXhLakViUzlib2N4TXFuQ2lQQVlM?=
 =?utf-8?B?UUNTN1FVKzVFVGVadUpTTWpGSUJCMzZnQ3B2bFVtRWtGSG03TzIvaCt5aERI?=
 =?utf-8?B?bVNxQWphQzNMVGlzcHM1b3VXQmQ1VGlaZ1llOTRWSy9KaE1rUUVKRzdZbFZB?=
 =?utf-8?Q?HeLb4pfgu/SmNJbR+sXART2bj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 095ecd58-eead-4052-9391-08dcc7b61f3a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 23:07:00.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQhSDis4lCfo9SJW6CAxeVJxpoKpBnS2I6GnDYJMKndEr325BYZvoP0Yo8EADODjcUdGaZD20q7pAVZ1NOdaNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com

Hi, Dave,

On 8/28/24 15:45, Dave Jiang wrote:
> 
> 
> On 8/28/24 3:42 PM, Fenghua Yu wrote:
>> A new DSA device ID, 0x1212, and a new IAA device ID, 0x1216, are
>> introduced on Diamond Rapids platform. Add the device IDs to the IDXD
>> driver.
>>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> ---
>>   drivers/dma/idxd/init.c | 4 ++++
>>   include/linux/pci_ids.h | 2 ++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 415b17b0acd0..21e3cff66f77 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -71,9 +71,13 @@ static struct pci_device_id idxd_pci_tbl[] = {
>>   	{ PCI_DEVICE_DATA(INTEL, DSA_SPR0, &idxd_driver_data[IDXD_TYPE_DSA]) },
>>   	/* DSA on GNR-D platforms */
>>   	{ PCI_DEVICE_DATA(INTEL, DSA_GNRD, &idxd_driver_data[IDXD_TYPE_DSA]) },
>> +	/* DSA on DMR platforms */
>> +	{ PCI_DEVICE_DATA(INTEL, DSA_DMR, &idxd_driver_data[IDXD_TYPE_DSA]) },
>>   
>>   	/* IAX ver 1.0 platforms */
>>   	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
>> +	/* IAX on DMR platforms */
>> +	{ PCI_DEVICE_DATA(INTEL, IAX_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
> 
> IAA_DMR?

Sure. Will fix this.

Also add something in the commit message? "Use IAA in new code instead 
of old name IAX. The IAX name (e.g. IDXD_TYPE_IAX) is still kept in 
legacy code"

> 
>>   	{ 0, }
>>   };
>>   MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index ff99047dac44..e15ebb3942ae 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2707,6 +2707,8 @@
>>   #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
>>   #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
>>   #define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
>> +#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
>> +#define PCI_DEVICE_ID_INTEL_IAX_DMR	0x1216
> 
> s/IAX/IAA/ ?

Ditto.

> 
>>   #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>>   #define PCI_DEVICE_ID_INTEL_82437	0x122d
>>   #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e

Thanks.

-Fenghua

