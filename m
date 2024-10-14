Return-Path: <dmaengine+bounces-3350-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3399D70F
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 21:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB8F1F23693
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950DB1CB317;
	Mon, 14 Oct 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIOUb9yO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34E20323;
	Mon, 14 Oct 2024 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933169; cv=fail; b=HAP3IEKcdLzhbXCIADL0YHDGDA9CUZ/UV67LG5gZbbT3ziut7BwUnpE5dzXRsHdl3/Ro4l3ajFwK/4ARbTw7SqMeta/b54uPZ1RlF04ELW0HtJfKi8ym6oS/9Xe0NFgzyaKugNrZq5bfLlGF1evhCwNnIrbKcmB32SayIjDYtgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933169; c=relaxed/simple;
	bh=VVWV4BK5MDN9538XCBfm9T4pAevMwGGSICoMYXXt6kI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KiCffJjlV9FnUpIz1k4++5G9VIrVxj+PcB2/JNDZgUcdVXFKRSKoeHL1N+Y1ZfL3/dIOL4WlzsUkFCt2sjiTk7sQHcSQBziADyFt/xd5uSzNPBogYVH8cWlgW53SHQA8bj57WklbhJllpIH86CdOwNxfPzxjunhZF3HyvQccBUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIOUb9yO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728933168; x=1760469168;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VVWV4BK5MDN9538XCBfm9T4pAevMwGGSICoMYXXt6kI=;
  b=BIOUb9yO3Y8Sx+58ZNZ3Mcy6J4x02eTivZLrfmjlK7Cn6Z2Vq52n4LFq
   o/RTe9dGaeQJ6U+FfgsUByD8AkaPhUWeRx+Xz2gEisIah2Rh15FlCuw/f
   SGB7apQ7NfTAhcRMyiUNg3jpiyrK1qrVEQtrYhruMCF0mpMsulA24o3lZ
   V7kSMlgJAA7UAlSlzaBbcoY+o2Mv0seViJ8H9hXq6nGEVWfQBiQcbYFcq
   cQpdiW+h8aN8yRYfyhMB+z8ZrJnKX1LZpS9ZGs+YusaCdAwPHBwmQYb5j
   yTbKHB63kxW/luycKE7OR04IzbSdAiVxC5Dy+Y5sFu4rUOSvzlCfVnV5V
   w==;
X-CSE-ConnectionGUID: TAmfe8aQSlGwD4gagQacdA==
X-CSE-MsgGUID: GU7zobCQSOWYuUEo96RpMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28485892"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="28485892"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 12:12:47 -0700
X-CSE-ConnectionGUID: sMYmse2PRLGuyRJU/dTVvA==
X-CSE-MsgGUID: 7PiO6MFkT52GjoVeHdmFdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="78110389"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 12:12:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 12:12:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 12:12:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 12:12:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 12:12:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 12:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A82bE9JlWzW7BV5arnPTEgwyIwPSzPWg7nm8n9OdZcjlIjl9kN1ANfPfumf5tgjATmZNYDrXwtLWrW5DzNimAQMfESEiK8rvQ3T1cT0wt2fcVgbG3BsPtUtKWUU9D9+NxTP6I270FaIuCyvv6ztPpkfxl0sXz7FJcYgJJKqVwQpSOuX2nbQ2L6JaLAX5eOPe6LdWW+UiOVpQ3fU4gW3/rf3OeqbMlOTguX04bB8lYI0lrgRxHE9cwMMSbrxT7pO0lLLs4LiIIxJey2RiuuJRHf2ii1MqTk8tepJC6GUhulhAP7sO9+6M51WjDCBi7pH9tKeAq7IH3Q+EV8/yifKS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BJB8/ofX/AVENVwBkGb6NomUJC69vCSBypvEO6VDT8=;
 b=osSoJOKfSWr17M18Bdn9oJa4F84M2z0RgSAqtn80fiOF6ngF2gZgEvXb8mUKz1mwR3v0TYybi5BoAAIcnazZFyhECGcTJT7wzUTH2KX81Ztz958U8EosVHG7FLikHAEonG3wUZvoXgm2bZ7Z+N7qH+LcuDChuI7W2eR0uV0spTi6secPgoglxXOhYcQc5V3rcFhRhz1/jNTUQVhC0441RTBPiBoek1W/Z4AsugQVmTC9q2/jEzGMUbN3mzcfLAKDG7Pb1htKUN+5go1Eyr6pQl9ZvpNmYBnh4hFrewHJTtZZCJrLUf6spga/BloRE4twhCen1gC7mVPTeOntoDVrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 19:12:42 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 19:12:42 +0000
Message-ID: <9fbf6154-23fc-8ac1-229d-73fa9c104451@intel.com>
Date: Mon, 14 Oct 2024 12:13:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Move DSA/IAA device IDs to IDXD driver
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20241004195200.3398664-1-fenghua.yu@intel.com>
 <Zw1gL22McDhFfgnk@vaman>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <Zw1gL22McDhFfgnk@vaman>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0182.namprd05.prod.outlook.com
 (2603:10b6:a03:330::7) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CO1PR11MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e74f13-f729-4248-463e-08dcec842daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzZ4UzVFL1FqUkFkNE8zTGZEaVFWVDRwU3c3b2hqa0s3eU82TGVrM0NXR3BB?=
 =?utf-8?B?ODZQcXQ2d3FHc1NoeWVOTERmY3B4YXRlZXlMNjRiTjZGRDFhRm5KQTlUTlVE?=
 =?utf-8?B?dlNHaUFRRG5SeE1UTXQ5OFZ6SDhweWpkV0o2V3IxVmNRd0ZmRU13Q1haNWp1?=
 =?utf-8?B?bEZDaEkyckJFZFcwU0srWFFSTkN4cldZTXM0VjAvM3pxZVNVVUZBOWZLMXNh?=
 =?utf-8?B?ZS9JVjFvT1lHa0JmNWtXSVRCL0Z3ZTMvZVQ4OGZCY3I5LzdjK1JkdnZTcEdL?=
 =?utf-8?B?RnBrNWxSRURuLzAvVWE4SktjcU9vM2dXYjRzSU9VTHVuVU9BSDlodnEwNUJO?=
 =?utf-8?B?WERGa1J5MWpjWlBjL1QyWXhUSGdlM1hPZ3FBYnRlMGY5d0hJMXNTclFXdjJ4?=
 =?utf-8?B?RTJzMTE4K3dqaTNQeE5CVnREOEZ3a0Naak9BRzZERjhleGQxMUxFTDFFa0FU?=
 =?utf-8?B?Skh1NWh4SWJEM3VzbTJBZHVVallhVFRmb0FuZ2NxeWV2N1ZTZDh4VkRQRVlq?=
 =?utf-8?B?ZS9OYXd1STE0VkJwZUwwR3JtRmo1VDlGMHFmZ0prclZ2VzJjQnNhcCt2c001?=
 =?utf-8?B?SW5IOGFOeEJwN21EMXAwN21GamgxdVlzalcwRkR3cS9MN3Bvc3lOYkNzTlpC?=
 =?utf-8?B?eXB3SDlNWGozenpqZHN6b0NvM1J5VEsyeWx3cy9FblpyQ2V2WHV0M1BzSlRS?=
 =?utf-8?B?ZlBiYktPbzhwRWhNS0NEOXhHWWpJUy9ZZ09NWU9wV2RNcVUrY3dZdDRsWVg4?=
 =?utf-8?B?SGRzMzFndjh5L2xZOTczUmcrL1R2bG9BZ3loZ2I1cFdmN0ZjUndEY3FGRWJa?=
 =?utf-8?B?NmxiOXNSd1lsZ2FYcHY3WlM0L2hhTkxzY2U2UUdWMDBacVdTVTl5NU5WVmtU?=
 =?utf-8?B?b3pRVlFYN2xreWF5eHlBUFRGR1dnQ1A1R0J3d0NHMklrZVQxWk12T3gycGUy?=
 =?utf-8?B?RW1WWUpQOXRTQnNpVy9Na1ZBUWEzMGRvTDlneFFnZlR0cVRIQmhsa2ZwOEZJ?=
 =?utf-8?B?c2FZWWhoRHNCQUM2NTBlcUIyWmtQZlJxTFlWQnJ0TXAzY20rT0E1L2QzTTh4?=
 =?utf-8?B?OEc2SmpNWXJsY2pRbVhENEI3Yi9CV05ZZldHZVBaelMwaXFvdnY5RWt3MHBK?=
 =?utf-8?B?b0lseEhWaCs2ZzNUMDAyZmxWbHMrVTNhT1RJVXBtNUhVOWhWcFpwWVVSUHUr?=
 =?utf-8?B?cHFZalIxV3pvRWU0b3JEVTdSdHE2U2RSRHFoN2pZY0IwUGhnbWcreXVNZnBI?=
 =?utf-8?B?cndrK3RWbXR0aE9XT2lja3lzRk81dFExVDU2SnUvS2xtU2FOOVdYY0tEaEdR?=
 =?utf-8?B?NTJzSVBJWVJWMDJiTGdtODFrSHo5VkxrMWZmWGJveDlLVVlkdVRpK3dwNUVi?=
 =?utf-8?B?c0o4WnNTSnJaZ3hZc1pLYlhtd0J1b3lKOU9BMzZnUVRqMDVQL1NMSHk4ZUNh?=
 =?utf-8?B?OEI2S2RobVkydDFaTjJ2cTZ5dVQ3MXU2Y2N2SmNmNEJEcEdnUnF6bi9BeVVv?=
 =?utf-8?B?RWtYbmF0M2ZPSTQ0SDNYRHR4YWswQnpaMVRtT3phZC9pdVU0QXdpZ3ROUlp3?=
 =?utf-8?B?R3dhb05zYUZkTnc1STJkdTAwWUZKc0pjaWVqN2pkZS9jVlBnVlUvUHhvR2ZU?=
 =?utf-8?B?dUxocjV6RWg5RzJ2S1BHQXR1NHFncXJjRmpBK044TjdoQVlRcDJ2YlNSQkRk?=
 =?utf-8?B?Mk81ZSs1c3RkSXhWeTFBV2FBaU5ZWDUxZUdIQnk1L1hnRUhFUXF2QW53PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3hvU2k1Vmc0ejlUcmg4OGxsNkxqT01XQnZnNi9WbU4vU1NPSmdNN3dpeXhv?=
 =?utf-8?B?aEJIV2QxTTYya3pLN1NoNHZRR2pKa2puT3cyK3BFN0RjNWhDazU0VkhvOWdw?=
 =?utf-8?B?Y3lnSXNRejZIWFNRUEdkZ1NIYk8zR2ZONjNjTjJOL2dlQm5aOGRIU0JSbmVY?=
 =?utf-8?B?VmFCUnFjM0Exbnl6aURBR29wdmEyVm93S205YjJ1a2hiMmVNM0hQMTFVelpS?=
 =?utf-8?B?QlZzdXNMZ2I3d3RDQmplLzU3cGk3L1p6eitScFkvVjVJa0lNanBnb0lOeUI5?=
 =?utf-8?B?T1R5T004TDM2MHduTFJ3eW5pcDZ5NkM0bVp3S1djRTJGYXdQaGloT2V6anRM?=
 =?utf-8?B?ZHA4UDM0ZVY5N3JOK1ZFcGFNRThOREM1QzFWa2ZZZzZTTjMvNHh4YmFEdGYv?=
 =?utf-8?B?MUYrdnJIaFFLMi9OK1JURWcydFBCSnpBZ29seHd4QWVDTEM4amJEeHREWCth?=
 =?utf-8?B?c1M1YUJVeERxQUxxdUtiQ1JMUGtnYTg4bWFDQUsrTmZIbmE5bjcxd1lRZGRl?=
 =?utf-8?B?S3VnNjQxWnBjVnB0T1NGWXBtelNSTUJocTcyc2FlbEsyeDJ5Um1vTG5RWXdu?=
 =?utf-8?B?SEltV0FnMDBpUXZWWDdaUlhuK3dHejRkVUdoWkdZVVM4bVFUbHd0UEpmSWpZ?=
 =?utf-8?B?R1Y1MW5GUm1kczNtdzY3b3lOcVF1cy9ud2QvYXBmcnhZMWZ4MVh3OWdJYmJ6?=
 =?utf-8?B?YU5YQWdnZDBiUkxNRFRoNTVyR2tJbGRZVXdVRjVKT1p0SUd5Z2xZL1ArbmNh?=
 =?utf-8?B?NHpKbWIrUU5HZnZVYkt6L25mRGlIUVU3ZlRjbmhjc3JzUzE4dmZXYXJ6R3Y5?=
 =?utf-8?B?TVd4d1A0bm5QNjFIMVQ2cFpKMm5pcloweHV0Sk9IQStHZVQxcHVDWTFKM2RI?=
 =?utf-8?B?ZkZ0ZWF1YXNsdDg2c0U4Wk9QMjJoM3JVeUN4QWJNVCtwaTVBTHIzdGh6Smk5?=
 =?utf-8?B?NW1BcnBScjNyU3VkRW1ua0FxQXE5RUV2NnI4ek0zb05DWUFnMzdodytVTlFR?=
 =?utf-8?B?cGZPRlJraTdiWmozTkFUMFBwcnZPLzF0eERXcDV2MS8wZjRpaGowRHhybmYr?=
 =?utf-8?B?QmVMV2xuTy8vWjAzS0NkLzRpMDRmdmIzb0pYdzdHS01zZnhUVUlDMENzQ28z?=
 =?utf-8?B?Y3hxaVNJWU95ZG50dWZPR0paZlJPYzhzaHZyaUF1R050NVlQYkh4OUZCTTU1?=
 =?utf-8?B?aENCem9XNXRsWGRuTy9OQTZ2dENaSE9mbjZWTUltK1YwRkNQY2w5ZDdib0c4?=
 =?utf-8?B?eEhsaUVpa253RXZXbHNDcHZ4T1ZQZEFLcFVrNkUvbHVGWFFjTi8xVDJuNWhW?=
 =?utf-8?B?VXVsRDN3ZndtbzJXWGhOOFFOSXI2T0lzd1NqTEI0eDJraGJDWitLZUJXcTEx?=
 =?utf-8?B?Tk93UlZQd0s1clNxMVBTUHNHK001UDRCRExZaFhrbkV2NE55d1o2T0JKMjdy?=
 =?utf-8?B?RFFHSU8wTDZLMitnQmVWLzJxbHNQVzdRMnhJdmdObWhMSlB3dUJYUUIyYUs5?=
 =?utf-8?B?Wng2aTR6Y09PTnlueTlhK1pBREZDMVQ4eWpYbG15Snc3WXFHZWJRRHY2OE9v?=
 =?utf-8?B?eklHa3JtY0RtUVFtWVJkdlBHNGNLbG5nQUVCYVVZRWdMRll2YS9ZTG9SSGFH?=
 =?utf-8?B?ZGdIaXhzTjJ4d3RsWSs1WnlVMUtodTY4QlYwblBSR1FHZmtXbFZQalJnRGRN?=
 =?utf-8?B?LzRKUzBlNEkrLytELzZJR3pBZEZNNXNncE9sL2M3ZGI5Yy9EQ1cvek5zazZG?=
 =?utf-8?B?aGt4RnFFb3FqT0lrV3VZMlVhMjI4OERGdCtBaXVLY3k1Q2UzdXlLa25vMmp2?=
 =?utf-8?B?amRZWU5TeitoZlpCdU9wSFVRcU1tQUxxaDg5MUZiZXVqTW1TUUVFUkpSRzdK?=
 =?utf-8?B?RFVuVnJxaDQxUy9nMFBUQXFhbUlhQUNTTDFJMEpqbUtQaEtxeUV3Q0Rsa0Jh?=
 =?utf-8?B?Y01wbldYN3ZwL3ppbUxITkRyOHdvQzNaaEM4T2hZWStNRHdDRnhnQUtYZGRs?=
 =?utf-8?B?YmFpLzY3Z0dhUmtSZTZmaC9CblVjR1A0bTVyTzVBRjNUY09xV2tRb1VGZURN?=
 =?utf-8?B?U0NTOVllMFRSMFl1MmlWbDhoQTd0d0Nzckg0c3lQbjV2d1NENE55WEd3NmhK?=
 =?utf-8?Q?0nLtVafAdaD5Hj0Ipouqw8tBG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e74f13-f729-4248-463e-08dcec842daa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 19:12:42.7190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXs+Afl/N2oXq1C75uCIa1/1ZAWxDcv8BTUr+xKbGaHYqQnOXVfAd4nm3P8nNai/WgX6S9N3rtIRkUE3cWp2gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5026
X-OriginatorOrg: intel.com

Hi, Vinod,

On 10/14/24 11:17, Vinod Koul wrote:
> On 04-10-24, 12:52, Fenghua Yu wrote:
>> Since the DSA/IAA device IDs are only used by the IDXD driver, there is
>> no need to define them as public IDs. Move their definitions to the IDXD
>> driver to limit their scope. This change helps reduce unnecessary
>> exposure of the device IDs in the global space, making the codebase
>> cleaner and better encapsulated.
> 
> That is good
> 
>>
>> There is no functional change.
> 
> Ok
> 
>>
>> Fixes: 4fecf944c051 ("dmaengine: idxd: Add new DSA and IAA device IDs for Diamond Rapids platform")
>> Fixes: f91f2a9879cc ("dmaengine: idxd: Add a new DSA device ID for Granite Rapids-D platform")
> 
> How is this a fix?

Do you want me to remove the fixes message?

I can do that in v2 if you agree.

> 
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> ---
>>   drivers/dma/idxd/registers.h | 4 ++++
>>   include/linux/pci_ids.h      | 3 ---
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
>> index e16dbf9ab324..c426511f2104 100644
>> --- a/drivers/dma/idxd/registers.h
>> +++ b/drivers/dma/idxd/registers.h
>> @@ -6,6 +6,10 @@
>>   #include <uapi/linux/idxd.h>
>>   
>>   /* PCI Config */
>> +#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
>> +#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
>> +#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
>> +
>>   #define DEVICE_VERSION_1		0x100
>>   #define DEVICE_VERSION_2		0x200
>>   
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 4cf6aaed5f35..e4bddb927795 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2709,9 +2709,6 @@
>>   #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
>>   #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
>>   #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
>> -#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
>> -#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
>> -#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
>>   #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>>   #define PCI_DEVICE_ID_INTEL_82437	0x122d
>>   #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
>> -- 
>> 2.37.1
> 

Thanks.

-Fenghua

