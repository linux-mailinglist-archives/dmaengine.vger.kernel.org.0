Return-Path: <dmaengine+bounces-997-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AA884FF47
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 22:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD655B29FE3
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 21:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF220DED;
	Fri,  9 Feb 2024 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2ogn8E3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CB107AA;
	Fri,  9 Feb 2024 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515620; cv=fail; b=UfxuE5O+uXdRXjDwXvJZKsPXiKLxJammvQtcjoxH5tZrxN+6BH8nxc5GBKD2RfpG9PSvEgLQo+Dmz528BCLHuyt/9AxCxM23a7QsCzcd/H28WKtFgbeCfubgafrAzee/IBYpD4NG36NsFuhhKCnAfSKAnba0W9IhL/I1F66j4mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515620; c=relaxed/simple;
	bh=AJyHNTuv9fUGAJGxhwSnE3Zsnasg6R3k69xFXVeUSNQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8D2R7fNIsJDwHuFz1IjfdB4LI9i8BB/Flyfdvhwi0gswCCwi8p95mcSOohZVEU/J79oI0zOqej+pId2gFgrjAscJf1a3cd9Z5pObNT5AAb9Hvz52LOxl54lVayl9hxVP4qcqpsAie7fFjm1EEx00P8Q//EHbBIKZLkKr5e6c1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2ogn8E3; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707515617; x=1739051617;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AJyHNTuv9fUGAJGxhwSnE3Zsnasg6R3k69xFXVeUSNQ=;
  b=I2ogn8E3n2er44PPXZ9HLtNhsTlcaalZMfoz4pBvU+H+k6LVjD2XTk/Z
   4PtC5+O10jyMmHceetaea2TPgRVoG2vANyEa10LumfAlJwrmJ9q2EgiiR
   YknCE+zudRUhTCKZ0Wv+0YU10Gddkpc1MxIcNnR9/XDJs8/F07izKEBJE
   TFiD9n/WVpczIZjsHHiti2bvXLYXV2sepAM+Ogdt9fkgp2DpYql3Rf9Iz
   uT0jOB6q4TegQdYAIAColykqfRv42u68QO/jxVI34Z7ZH7s8Oy6fbEV7u
   blqlYDgekuvWu3uO9Hr5v7NQKbPfanCxmOkDs/AQfxiD7LlKD3KOL3jDL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1641200"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1641200"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 13:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2032849"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 13:53:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 13:53:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 13:53:36 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 13:53:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZgalDi42LZAveUjGUoYnoIpMoy9Aut2ZJtGrCSXl6HElYRVb/OJlMiuJ3+Bzu51qu5ZSJXYHDK/CIBHOSrGPuPPZXsfyo1KLFhv1+wmhijNWB0tKBxhcxqiP2btbqrm5PwS9cvfs9R9H1vvFuF32FBC7ndJ1Y+wZeEftnmHXTh5ppwOe4Qy9gMYdZ2Kq0ZwD3NDxSaWwj+QgL6JEP3T1AwO8V96YLO8QPnGgLVshW+cX1UMSRtHzrgdxbxMrusJbMdrGUgcDRCtL8ftLIl4t0Da+LnyzdEYjmN2rh+h0QK2XGju0xw534BR3n3XytmRSDMa7K+H089P/6rxk17x4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3Knffrzvyy0sXhp4AyPQac3rmSSFYpp4E2XDbK8Olg=;
 b=Ox9c0AssnYE21zMmsxSpPFQNsZiEDN456tWGTiJbimSomx3zTeqD7+atfOAw/AcBQIMWgnXyir93nFbYwOcOm3bReUaPwFtYZctwDTi1OHhagPLfcegNDoYGWJlaNCnbXPm3dA/htq8PFyGkeODv8DDIQBI/+DD/GlwrTgB5fYDaMiUnnKng50KRoI8sDVdsjkaNODZS/88P2dtzoATrZsI+tH7sitJKcj3q/oIkKLhvex8KRwSp1EdP2vBkz/MRDmAf1t23hAJbReVLgoJ13kxnaJcxDkVTTGe3VKK9n7J4wL1f8FrCGR5NUhf4WeY94BwXnEB7zMALMa7YQBOfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by PH7PR11MB6796.namprd11.prod.outlook.com (2603:10b6:510:1ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 21:53:34 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::be6e:94e9:76f7:5c3a]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::be6e:94e9:76f7:5c3a%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 21:53:34 +0000
Message-ID: <4237a933-0f61-417f-bbb6-ce5954b304d4@intel.com>
Date: Sat, 10 Feb 2024 05:53:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Ensure safe user copy of completion
 record
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Tony Zhu <tony.zhu@intel.com>
References: <20240209191412.1050270-1-fenghua.yu@intel.com>
From: Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20240209191412.1050270-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|PH7PR11MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f53155d-057e-4d93-6cf2-08dc29b98fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPppxMrwxpomdbvGnwzt8xEwI+XWhG8BfpiWzBR83aZUvvs256fUlmbQRMpYN7hLFbwBMbECW8WYWFlfFW3wRYKkMJ6BXuNXORpd/D10+Xo+vYbOC1gpyZsmkytl0VyNufZ3q/LIZmt6BUUvYAyWB77h9wMO1AeKC6YJsHMDIj4OPuA9lNZt94CvCRChpLKJp/i+uWatvSH17ToXvWjK25cSWwH8sXGks7NbouW4wOmslW3lTdc/YRYn38Sgi4bGWbuqTRLsw5WWd6wQFZb4UduXpZ0J0Mj9ehzjLS8xKgtibzuqH/q1g0pElF9jYy9E/oWPPE3VSFdRXuIlUbb5Y035lFEeQDVeXFpq4AQFn58/aWQj2BY+3pn6vtnFR3sdxefUx/MoEvqLVygBDfqM9mtUIGL9pz3bklQGr65tzRxRxVdP8yBzrk6NrPZnLnoMcTJ2048rE7ymGo7X1T6kotkltBvGmrUbl3FqJNnQ2t+uMQJ7pPkVN694qxEGD+NwvRuZFEOjOsn7sibhexBrFka8YORzPNZc4/7qDrUQHFuIj/WuJDDwcO2TbS++Inie
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(82960400001)(86362001)(31696002)(2616005)(316002)(107886003)(6486002)(6636002)(53546011)(110136005)(66556008)(66476007)(26005)(6506007)(38100700002)(54906003)(478600001)(6666004)(66946007)(6512007)(36756003)(5660300002)(44832011)(4326008)(8936002)(8676002)(31686004)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3FsUXNvTkU1K1hEamVQOCtZTU9Ec3pSZjAyNmM2RzFvaHgwTzhSK0dqeDla?=
 =?utf-8?B?c0VuU2wwN1dqdjZ5d21Xb3QwQ3BUbFkrbEtmZ0h1RnJ4RDRWZldHNDNuMHBE?=
 =?utf-8?B?QVFqWkFOZWdtWklJZndoejROUVcyajA2RjB6bjRaM3A1UUZFOXlGS0JQM1I4?=
 =?utf-8?B?SUdsK05yM2ZVYWFyUFZ4RGc5YXJmK3NHMXhtNzZGM2J1dm5WWWxNT3hScVg0?=
 =?utf-8?B?alRqaWc2NmVpdzh6YW5sR3lXYldKcWwvZTFrbXNDWHppQm5ZQkZhSEg0Zmcx?=
 =?utf-8?B?UldHTjg3c3YwOXVsVVIxTG1OcWMyRFFFYkZOaDd0L1MrWk1FTEJLbkVsakEx?=
 =?utf-8?B?QkQ3QlBmNEVMWjlkTjBRYW5QekhWZWVrb1EwU0pwSlk5M1Z3UFh2YmErUHdH?=
 =?utf-8?B?VEVaWGlWalAxdmRlVnd3bmM4Uk5yR0kzQkFuZnUzcGo5QUhDSGZLVnpjR0lP?=
 =?utf-8?B?NjBjNUpWODlhZ011Vy95a2ZuMi9pWlBYZkQySVRxZ1hkL29hK0RjWlVuNi9Y?=
 =?utf-8?B?YjRtN2VTTU9LaFJaZXNaaWNZRkNQcHFpRWdNQ2I2VGljMHpCd0I1QzRrR0N0?=
 =?utf-8?B?WVdLK291QlRUMk1iazNnZ1ByT1FvRVY5aWR3MTRMMmVpcDJUWXltaFBWcnI4?=
 =?utf-8?B?L0tTclpBTFpGMnlodDluWjlkOHlqMElzRXlkZ1R1ZFhKMVQvQkVOTEU0eWNI?=
 =?utf-8?B?ZWt4NDRoTEcxKzBHUW1hUm9sZUtpTHB4Sy9YVW13Tm1QcFJ4VFF4bWh3WDV5?=
 =?utf-8?B?RUpCSFBXOGRoQ09IbUM5RWY0WWdCNmZsV2wrdjNpR3dFa0Y5UVZFZG1yMHI1?=
 =?utf-8?B?MVlTL0VpOVdueGF5b1VVTlBLWExpQlR5c3hsWGZKSTViTm9CTlBjdWZ2UEFv?=
 =?utf-8?B?VDZGcFMyTm9GNnBHZTl0VTZHWDJLcUtZLytNcENiMnhQU21OZTVsYzVPOXY1?=
 =?utf-8?B?K1BHQkRSVHJqTXF0U0RZdmJKTWNuR3AvU1U3RDdCR0RGeUJNNVdsa2xzempV?=
 =?utf-8?B?aHFodnhqZVAvQXFzMk5xb1o3WUU3dlovd0ZXUm9QLzFZbjdzbEg2UnFRdTJQ?=
 =?utf-8?B?RTJVbmdic0NLNUpKeWtRUDNTS1BZOXIzc1JlRUIwRmZOaG0xT3pHdmVrVTNv?=
 =?utf-8?B?RXB0YzIyMndvMVpITGZZRUFreWdCU3dsbm5KMU0rTnNSU0NDU1k5MSs1YzM2?=
 =?utf-8?B?MERKa2dkUkJ5RkxaRDhQenAvOXppb0M0L3N3elRLOEEvT2FKVHdDSXJDaEdk?=
 =?utf-8?B?c1dicGZCTXYwSTBEUng3RlJyUHVaUW1uSDJxclRyMjdPeVIwUU4wN2xLdVJm?=
 =?utf-8?B?MW1PQm5xd3ZnWTU2bFRWakl6cEMrVzFIb0V1TjR2ZGJoMFZRUVZUaGpuRU5x?=
 =?utf-8?B?Z21hZlRhZDZrMFBkTVpRU0ZGTEFBTXR5V1kyc0FsSlhhbTI2REc3Zy9LbW9a?=
 =?utf-8?B?Y21oaUI4Y3ZVWXRJQkVHblVVbmpyTHZBTUF5WSszUU00aHhoWVl1cTkydzY5?=
 =?utf-8?B?MjNBYkZzeTNzZC9tQk8yWVJjZHhnc3V0Y25YeHNTdllPbHRzcjR5dUI3bmtX?=
 =?utf-8?B?VDNocVlkNWg0R1JnU1ovMnJtbmNGaHpQemFvYk9VODZ2N2RBZi9KSTEvQndp?=
 =?utf-8?B?SWhUVGtNb3pkVW0wVnZJV0k4QnZTK3RqbHh0ZWc3R1g2WnlPNE9KQThscmNB?=
 =?utf-8?B?UFY4TVo3ZnVWOHl1UWZOS3ByZisvbDVkcXh5TkxiZFhncm0rV29MVmFuREJj?=
 =?utf-8?B?VDFyU3ljbFp5eXI2UVZyTmN0MXBhNThZeE5vMFRyZ3NueHVKZm4yeTF5ZkhK?=
 =?utf-8?B?cEcrL1cxR290RUlmc2hwcm1oNk5yb1RXVFlueDRjNlNIcGlreWpFVTlaVC8y?=
 =?utf-8?B?YVovVFk5NXpvc1l1WWFQb3pjUnlIM2x0bU9ZRFF3SFJTWW84RzBLNFoxRjhW?=
 =?utf-8?B?S21icTFGd3RwVEdsVllnUW5kUHNvSEV6TUEzZTVQL2FjVEM0M0NRSHN5WldM?=
 =?utf-8?B?dzlUSkhDREJJMjNNZ2htWVVhSXZ6amkwZGRyb0JlN3RvaHJld2dIT1NSZ0hE?=
 =?utf-8?B?V0xVWjkxSzROajlMM0tod0xPWnU5RW5kZk1jRlR1cDlyNEFSUkh5L3VONTRh?=
 =?utf-8?Q?xZV2aQqYrrn7KPlXGTJLjLAXD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f53155d-057e-4d93-6cf2-08dc29b98fee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:53:34.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIsu+S53HsYRtPYP0NOmD878PP2r/rViiAUUNVtrU12edu9LM05jGbdR3CbKIV96/Aog46+HOZHqRG4IaBHFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6796
X-OriginatorOrg: intel.com



On 2/10/2024 3:14 AM, Fenghua Yu wrote:
> If CONFIG_HARDENED_USERCOPY is enabled, copying completion record from
> event log cache to user triggers a kernel bug.
> 
> [ 1987.159822] usercopy: Kernel memory exposure attempt detected from SLUB object 'dsa0' (offset 74, size 31)!
> [ 1987.170845] ------------[ cut here ]------------
> [ 1987.176086] kernel BUG at mm/usercopy.c:102!
> [ 1987.180946] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 1987.186866] CPU: 17 PID: 528 Comm: kworker/17:1 Not tainted 6.8.0-rc2+ #5
> [ 1987.194537] Hardware name: Intel Corporation AvenueCity/AvenueCity, BIOS BHSDCRB1.86B.2492.D03.2307181620 07/18/2023
> [ 1987.206405] Workqueue: wq0.0 idxd_evl_fault_work [idxd]
> [ 1987.212338] RIP: 0010:usercopy_abort+0x72/0x90
> [ 1987.217381] Code: 58 65 9c 50 48 c7 c2 17 85 61 9c 57 48 c7 c7 98 fd 6b 9c 48 0f 44 d6 48 c7 c6 b3 08 62 9c 4c 89 d1 49 0f 44 f3 e8 1e 2e d5 ff <0f> 0b 49 c7 c1 9e 42 61 9c 4c 89 cf 4d 89 c8 eb a9 66 66 2e 0f 1f
> [ 1987.238505] RSP: 0018:ff62f5cf20607d60 EFLAGS: 00010246
> [ 1987.244423] RAX: 000000000000005f RBX: 000000000000001f RCX: 0000000000000000
> [ 1987.252480] RDX: 0000000000000000 RSI: ffffffff9c61429e RDI: 00000000ffffffff
> [ 1987.260538] RBP: ff62f5cf20607d78 R08: ff2a6a89ef3fffe8 R09: 00000000fffeffff
> [ 1987.268595] R10: ff2a6a89eed00000 R11: 0000000000000003 R12: ff2a66934849c89a
> [ 1987.276652] R13: 0000000000000001 R14: ff2a66934849c8b9 R15: ff2a66934849c899
> [ 1987.284710] FS:  0000000000000000(0000) GS:ff2a66b22fe40000(0000) knlGS:0000000000000000
> [ 1987.293850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1987.300355] CR2: 00007fe291a37000 CR3: 000000010fbd4005 CR4: 0000000000f71ef0
> [ 1987.308413] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1987.316470] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 1987.324527] PKRU: 55555554
> [ 1987.327622] Call Trace:
> [ 1987.330424]  <TASK>
> [ 1987.332826]  ? show_regs+0x6e/0x80
> [ 1987.336703]  ? die+0x3c/0xa0
> [ 1987.339988]  ? do_trap+0xd4/0xf0
> [ 1987.343662]  ? do_error_trap+0x75/0xa0
> [ 1987.347922]  ? usercopy_abort+0x72/0x90
> [ 1987.352277]  ? exc_invalid_op+0x57/0x80
> [ 1987.356634]  ? usercopy_abort+0x72/0x90
> [ 1987.360988]  ? asm_exc_invalid_op+0x1f/0x30
> [ 1987.365734]  ? usercopy_abort+0x72/0x90
> [ 1987.370088]  __check_heap_object+0xb7/0xd0
> [ 1987.374739]  __check_object_size+0x175/0x2d0
> [ 1987.379588]  idxd_copy_cr+0xa9/0x130 [idxd]
> [ 1987.384341]  idxd_evl_fault_work+0x127/0x390 [idxd]
> [ 1987.389878]  process_one_work+0x13e/0x300
> [ 1987.394435]  ? __pfx_worker_thread+0x10/0x10
> [ 1987.399284]  worker_thread+0x2f7/0x420
> [ 1987.403544]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
> [ 1987.409171]  ? __pfx_worker_thread+0x10/0x10
> [ 1987.414019]  kthread+0x107/0x140
> [ 1987.417693]  ? __pfx_kthread+0x10/0x10
> [ 1987.421954]  ret_from_fork+0x3d/0x60
> [ 1987.426019]  ? __pfx_kthread+0x10/0x10
> [ 1987.430281]  ret_from_fork_asm+0x1b/0x30
> [ 1987.434744]  </TASK>
> 
> The issue arises because event log cache is created using
> kmem_cache_create() which is not suitable for user copy.
> 
> Fix the issue by creating event log cache with
> kmem_cache_create_usercopy(), ensuring safe user copy.
s/, ensuring/ to ensure



> 
> Fixes: c2f156bf168f ("dmaengine: idxd: create kmem cache for event log fault items")
> Reported-by: Tony Zhu <tony.zhu@intel.com>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Reviewed-by: Lijun Pan <lijun.pan@intel.com>

> ---
>   drivers/dma/idxd/init.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 14df1f1347a8..4954adc6bb60 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -343,7 +343,9 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
>   static int idxd_init_evl(struct idxd_device *idxd)
>   {
>   	struct device *dev = &idxd->pdev->dev;
> +	unsigned int evl_cache_size;
>   	struct idxd_evl *evl;
> +	const char *idxd_name;
>   
>   	if (idxd->hw.gen_cap.evl_support == 0)
>   		return 0;
> @@ -355,9 +357,16 @@ static int idxd_init_evl(struct idxd_device *idxd)
>   	spin_lock_init(&evl->lock);
>   	evl->size = IDXD_EVL_SIZE_MIN;
>   
> -	idxd->evl_cache = kmem_cache_create(dev_name(idxd_confdev(idxd)),
> -					    sizeof(struct idxd_evl_fault) + evl_ent_size(idxd),
> -					    0, 0, NULL);
> +	idxd_name = dev_name(idxd_confdev(idxd));
> +	evl_cache_size = sizeof(struct idxd_evl_fault) + evl_ent_size(idxd);
> +	/*
> +	 * Since completion record in evl_cache will be copied to user
> +	 * when handling completion record page fault, need to create
> +	 * the cache suitable for user copy.
> +	 */

Maybe briefly compare kmem_cache_create() with 
kmem_cache_create_usercopy() and add up to the above comments. If you 
think it too verbose, then forget about it.

> +	idxd->evl_cache = kmem_cache_create_usercopy(idxd_name, evl_cache_size,
> +						     0, 0, 0, evl_cache_size,
> +						     NULL);
>   	if (!idxd->evl_cache) {
>   		kfree(evl);
>   		return -ENOMEM;

