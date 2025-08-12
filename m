Return-Path: <dmaengine+bounces-5996-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B02B21AA7
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 04:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC0217090B
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 02:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B020C478;
	Tue, 12 Aug 2025 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWVqcqFH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0A3FB1B;
	Tue, 12 Aug 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754965049; cv=fail; b=FcwTYs+mYVNy/o73f8y5DopteEQw/tvb3f1w3ziA5JbZ20h1uPljkQB62RhCnNK9ZJGlQU2pNvYUAKVTWUT1JQzAYAiLDNb/gcRrHiUv77D//EnjWkzeya9OOoI6u4UiXwTE3Qbgr9KnXC1p67qtVnXQ8O51qnAlQSXxF3sUcVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754965049; c=relaxed/simple;
	bh=60AKR14XJUoH/zlKKas1mInATisIYii2KifvfrpWjMw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cW8ncaNCTotEMe2EZzY4qrJAHawwIW6k9DyWp3RkMyE0ABkBYJJVFf5g8oWebyCMIagBW5NocCqQssRP6nWsrnCVWKukfsALHBN0GdpSvxjaJfeSyYOYXmwmr/kLHkPCEd3aW+9doOlW5DEzIDCUbayr7/Qf+43L5wdL+dcTEaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWVqcqFH; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754965048; x=1786501048;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=60AKR14XJUoH/zlKKas1mInATisIYii2KifvfrpWjMw=;
  b=JWVqcqFHfUXJlWld006DDKSLINxR4FMrQKQj43NhbXb/LceDRNHPuFPW
   P+f6zJH5rAgNtzmXMN2kSppfcasY/AaUFYOosDAsOc3Vmf38bsghd0ZFO
   TgJBfSc5Pl36VkNgDOK/mgcp8z6laBYyJm/zQuIhMGSfwZo1WC72VV+8h
   LjTgvgiyzVZwSembfxfcSMJMJ/j9g3lTxvZkWyigGPQuPR/mPhCggniw1
   s/yTRKV/cEssuV6ClojvwZonQgoicoRPV+5dQi8oBWBit/uxmE5yH8iWu
   qK0ABqa7yG9Rzxj+whgSpZPqpNqhixPQH7OP3aazjI6PVScjBxNL7Cmt4
   A==;
X-CSE-ConnectionGUID: Wuep9IluREyOMiiWAFaKfw==
X-CSE-MsgGUID: ROTrVw4PRHWZS2w0de+I0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67495935"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67495935"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:17:28 -0700
X-CSE-ConnectionGUID: VKHc6X4sQHedv2Fn80CYKg==
X-CSE-MsgGUID: 4Qgepw/7TIWpOTRWcMwYtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170283523"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:17:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 19:17:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 19:17:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.69)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 19:17:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItotwUUaTEiSEnOP7awz2+jiVH7dNgHg3NhXYv9XcjZMlHIFbjKdgRbEZtuzkobUq/YyyFHeP+mAhj+X0wzYrl3sKLKGCD4HUlWgF0vNkfV8GTUMyp66OMpKPIPhEcS1pOo+Ctst3QLrIyWiurcORY7SRsnNDmviPu96x2xhk0UGNdIkdxnjfy50Ks62q4lHb/dqojlZFbSQh16GEDbqQ9Wm57x7wI1Q/X747qjK/O7ybpg8++6uVruCcihODVVc/sGiMzPN4zlDdIH+QQI+xUeGByR9nIXntNgOGQ4G06g5MvfatYbc8Ij4/eEEkrtlnUkuBF7SUXIzVcWmE1DIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YGnsDDhlXdIme1c3CODjIN3THqGGu6Q+LPMwgNPTg8=;
 b=g3jCeWtVHxojYRp45tBlvBCrV7I/HnrjvcRGqeEouEcQw842UWAe5DZ9dBnn+kBgHpF+Y3HAIy8luguIwnPKtoHIf2Jgpu0E8WojAeCgjy4T/MXmdHwJyZWCgZ0wUXeDHkyOJkWs8z/LuFEUHoVTxdIgXhwSjDQhb3p8mUQfQjUWL5DFcw7F0axDJSwUv8LGE5c2vzxCmhN2tXULVoN88Pb7DVMAXhqRbwt0/RwAdwAnHLPoXor63kQhigOk8JwBj7lnTzhKDPCmkZ7B7kLoybPJdh3aMeUsUvqN/HDDUOrTmrNmVl6ucMDvSd/K8xaBR97e9PSjhk2++w7IKw/64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by PH0PR11MB4806.namprd11.prod.outlook.com (2603:10b6:510:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 02:17:24 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 02:17:23 +0000
Date: Tue, 12 Aug 2025 10:17:13 +0800
From: Yi Sun <yi.sun@intel.com>
To: <vkoul@kernel.org>
CC: Vinicius Costa Gomes <vinicius.gomes@intel.com>, <vkoul@kernel.org>,
	<dave.jiang@intel.com>, <fenghuay@nvidia.com>, <xueshuai@linux.alibaba.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gordon.jin@intel.com>
Subject: Re: [PATCH RESEND v3 0/2] dmaengine: idxd: Fix refcount and cleanup
 issues on module unload
Message-ID: <aJqkKVdoqrXcC4rV@ysun46-mobl.ccr.corp.intel.com>
References: <20250729150313.1934101-1-yi.sun@intel.com>
 <87tt2tkvy2.fsf@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <87tt2tkvy2.fsf@intel.com>
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|PH0PR11MB4806:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f63e226-b251-4f0c-5581-08ddd9465fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXZZbHd3bm9FcFByZnRvM3I0MWtrdDBHbWM5YkdvZU1YdUI5aHpoSEhqbnhI?=
 =?utf-8?B?ci9EM3dNT1Y1em93R1IyNUtwZkpPR01mQjhGRlVObVlkUjdHZ1ZmNFFJWHE0?=
 =?utf-8?B?dysxcHRIbHZ0VlYrVjBSNjRrTzdpWVAvVjdWWWl2RFlhMUNSUEVBQStyUWxk?=
 =?utf-8?B?ZTBta1NNOE5DSHhaZlFkT2drWDRyMmFlUk9hNytFYzl1SjZXS1RFVVFKMUhl?=
 =?utf-8?B?L1dvOTVCZmJ1UkRTN2VBM3A5aUdETzZoLzlqeWRSVjIzclprTDByckgveVNW?=
 =?utf-8?B?cWJmN043anQvdUxoQVpEeVFtS0luZXJIUk1ncnE5VGNkZHVxZkFlRkNVK1lx?=
 =?utf-8?B?UWdrNU9XN0M5RVhUcXVnUU5uZ1lMeWdKRzdLbDA2Wjh3MzJRNGoyb1VHWDZm?=
 =?utf-8?B?KzQ0WHI2KzhKd2svS0tWYnpweGg2aUtCb0xBdEZDejdhVTA3cE5ubEFubXpQ?=
 =?utf-8?B?cVZaLzhBN0FLYStWSlZSZkxlT0hmbmVSZFdQOFI4UExHcHFlem96ZWJWY1NI?=
 =?utf-8?B?M0xQQVZnZWZtUHQ0dVV2eGVvbDdaMUg4TStDRitzRHF5eUpwY0dFU05aOU1G?=
 =?utf-8?B?YVNXeE1Lb25BR3F3dXErK1RVaGRZM1JpbmY1QjFWRFppSXRVVFV5NXlSbzV4?=
 =?utf-8?B?bFBGaWlaY0QvNm41MTBseERJVFJEWTlBMHR4QkVPL0dyQ1B1Y0cyUDhQa3VF?=
 =?utf-8?B?N3lkcWViSVpKemRTNTVzeFF2bXFEeDdObFNvNXJ0dDJ4eW01OGZEb0RtMUFR?=
 =?utf-8?B?dnZlak5GeHNyRUVuMHVJTVJ1aTBUbFNKekZpeTg2STl0SUJJcjRDUkNYN0V0?=
 =?utf-8?B?VjF3TDUvbDREakVHSm9UazhQaG1mZW4vNG1KRkxqNVZCWHJNSUgxb0xSVmsy?=
 =?utf-8?B?THhaZ0Rnby9TUEVwNTY1bjFHZVl1TC9US3BoZHZxbnpPaW5TUzBlaktZbStB?=
 =?utf-8?B?b0wvUWR6dklFK25JZGlwSjRmZlFHTHEyREtOczZkZ2tST3RGb1hMaHE0aDZx?=
 =?utf-8?B?NjBHVEMrbkRUNFUvZUlnendUSHFET3NZYlpGSStZcElLa092TWNDWndNTjZm?=
 =?utf-8?B?ZTBsQXhZZStsUWEzVXpnSldxMmFJNTA4WEU1MUV5V1ZGUHJrMmF1ODBqS1Iv?=
 =?utf-8?B?aEpISG0xRk4wWUNQY3FFaVZBZ2JWNXE0ZWp5aFhrM2Q2SlN5NXdpSFNWeW9L?=
 =?utf-8?B?cEIxajBwZlBtRmpicnBYZmZlcVBBSURGajNDV0NwQWFRaEhwZ0N5bjVuK0s0?=
 =?utf-8?B?VmxGNWpqeXVnTTdKR0l0V3V2WURyN2pTbHRwMTFXd2FtU21tNVYybjlzNGFL?=
 =?utf-8?B?eXNsbHR2WitwQmFwTkZEcUtUY3Z3OFRBclIwMnhaNldka0xxWVlCTWlmYjU3?=
 =?utf-8?B?UGpzOVVTNTloWW95bmQ3UTRkcFNUalUrWUtaUlJVdktvUHU3TGhLQkpEVFhw?=
 =?utf-8?B?TnA1bTE4TENZRmUxUXoxUzBMa3dtZStGNnFQTlI3RE1LL1JoR1BuK3Q4eDVu?=
 =?utf-8?B?OEY5WFdNa2N1emc0QzlXd0Z0dDdmcWJhODRMTUpFa1UwWkFWS0oxbGpJVVZD?=
 =?utf-8?B?NWU3V3JBQW1xUU1vYWdMbndBdlpwc1E2Z0d5UTNvV1lQQStVVkV5ZTFIdEZO?=
 =?utf-8?B?dzJKV2MrZUVUMTlBVUxXaTJ5YUtPd0dIZitwU1ZMRkhEQkNsdlJYTkRiSlV3?=
 =?utf-8?B?M29YNUo1ZEk2Y3NOa2VYRU9LUmVidk1UdFZ6b1RSVTZHTTVSa3B6NFBnL215?=
 =?utf-8?B?S2cvajQ4N0Rzc0xTSVdlN0JYK2FRYmoxSEpDQUFrWnBkOE9aWWJZUkpvZnpt?=
 =?utf-8?B?MGdVSzcxNXl3VXlBUnNjTHVva25mbVQ1Z3l2V2lrZ21scitSbTZVNVhzTVRE?=
 =?utf-8?B?VWtFRGpwU1F6UjI0VWhEY0RQZW1lMy9Jd2taajlrUndtelZ6NCtvVCtZZHpZ?=
 =?utf-8?Q?pxVv8db4oWw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjR3UmpmbDVkNDQrZkFmTWJ1dTk5TWk1WVNuMWREVGFiQTYzMXY4NmFrTlpS?=
 =?utf-8?B?aFJMTHdmSDFOSGtUSmxjTmVqNVFUYVp1U1NUbm1Ya2I1cUhDL1dyeXBmazVT?=
 =?utf-8?B?UlFMTUJCVVlzclVJRU5qWnFXTXhpYjBPeDVVa1B2Ynl4ZkV5MmlSbzRZRnIy?=
 =?utf-8?B?TFRJM2d3NmhWYXRyYjBib0hGaDN1RmF0UzlKVzArdXl1blpiWWRGTjJrckdi?=
 =?utf-8?B?UkNwZCthbjBESVpnZU9pZmVWVlBPbnREZEdNMGVMc2ZKVG9FMVlnZ0ZBTUlE?=
 =?utf-8?B?VTdMUmVoeWMzQUovSW1ZQlY5M3pKcWRLZlBzeXF0UzFBOWFGYzdSWDFlNzIz?=
 =?utf-8?B?RE8zSW0yVXpTYk9EN1ZCNk5SM3E0SXRoYk0xNmtWd2R3ckJZeGFzZStwcmJB?=
 =?utf-8?B?Q0RQeEJyR2U0WmR4YXIvYkNrOTFJc1lmdmtTTDlTL1ptTUdBbHpOaDhvS0J4?=
 =?utf-8?B?Q01GU25oa2FmUHdpd3JrQmgrZU5rM0YyZ25HenlPMmdwUTFCeVhkY2dJamdR?=
 =?utf-8?B?NmVhZWJuekJOQXd2cnRyVVZzc0lKemlvYVNjVHNHOXV2cUM5R3JYais5U0NJ?=
 =?utf-8?B?RnM2N1BYQmVnMnpoMVN0YXphUmNnMUtRQkt0MVhXaHJGd1h1WDVPWU0rZFpy?=
 =?utf-8?B?a1FIa0hYYktHVDNzV2F3UEFWdVBiMThCT1pQd0hlNVFhcmtvNHZCK05hSytW?=
 =?utf-8?B?TU9VN3NiLzkrZXliNG5BRXBFZFFpczhTYkh0V1FDKzlRWlgzOEpieW0zZzNi?=
 =?utf-8?B?OVdjdjVxaElFWjVjbzkvUjRYWVIzSlNwQkpYaEpJWm5IVTRZQnFMVXBVWnNk?=
 =?utf-8?B?TW1pY1l2dTBtODZDY3J6L2J6WnFIM2JhaGtOR1R3Tnh3dlpwaEd0SXV6Q1Zw?=
 =?utf-8?B?Q3ovM0pNTVdBT3pmc3FMMU9nYmoxTTNITzRVRzJ5aEhCbVJ2dUtONmhuWG1z?=
 =?utf-8?B?ZTRnbFJ0ZjBFRVl0T3dVQWRrYmkzU2k4bnVFdklqbndDYWFQQ0VIVitoRVRE?=
 =?utf-8?B?VDJRYjZGczkzaUFnc2wveld1YnN2d2xIdVJMV0ZDRmZZMEt2VS9xRWtYWFpP?=
 =?utf-8?B?RUZua1VyR0JxeG1OVElZOFFWd2NmZ3E1dlFzT0ZNeEVuMzBFeFlUYXJIWFVS?=
 =?utf-8?B?TnpaY3d3VHVrOHMvY25NZGF4K3RaWWljK1o2MDhkN0lKT2RQR2RNaUtSVGJx?=
 =?utf-8?B?QmNuMHZaK045d3BVUVpaMjdWMGtQSDI1MkMxUm1pTUdpMm9jUDBReU5TK2RS?=
 =?utf-8?B?RmgyMVQxNHNVRDdnbnpmaWh0MHhUWUoxNEwzTmxWOEUvYkZaWnJZYkpPcEJk?=
 =?utf-8?B?R2FkU2hlbENFdWRXaGFDOXhkdjAwd3hKR0gyU1dFZWc2WEtEcTlFekZ5Q2c1?=
 =?utf-8?B?WGtDeVFkR3piVy9weGxjcU5lZHlDall1OG1CQm5LUEVCV2VJUGhJR2xNMElR?=
 =?utf-8?B?eCtsRkpPcDVXN05kNnhybUx4SlYzSG9NV0FrVHNEYWRuVDNMRENxaU9lalU0?=
 =?utf-8?B?R2xMc3dVWjR4Nmx5emdHejRrMnByMjJqK0RUK3NnSmhZSDF4NjgzY0xBUHIr?=
 =?utf-8?B?N1FOeS8zWHY3dHNqc3czZU1DU05zVUVtZDBrUnltSUtBb084STYvaVYvV3Ru?=
 =?utf-8?B?WDNZZ1RxenV4SFFHdzJVVkF0WHZSaGNMS0NPeVRuOEtTd3o5NFZ1RStGRU9v?=
 =?utf-8?B?NG1acmhTcXFHdVd3emVBd0RwKytNc2oyU1pOTzYwOXM1eWFjbVFyZDZ2U0la?=
 =?utf-8?B?TmtGN1ViL25KdkNkMThyT0xlQ2pMaTd5RGowbVNRaEJYOXQyT0x4VHRTZHVV?=
 =?utf-8?B?eHAwWEp4TStJUVR4ajA3NFk4SndqZmN0eUxFU3R0aGtoK3R6MEhtYmlSamRH?=
 =?utf-8?B?SVNjekNxd0tuRjQyTFBLVHNuamdFRm8yZ0UyZXFCUmQyYjFkOWZFeVhhL0hR?=
 =?utf-8?B?Y2tqY1Rzb3d4K1MyZEVRcDAzaDVMdWIvUG5sWHp6eS9UZFBIYTFpYlMvRHRT?=
 =?utf-8?B?aEVHUDZ1eC9KV2hWcDFpTGtVZnJINHBic0FBS29RS2ZaNW5qTHdEU2N6LzZ0?=
 =?utf-8?B?a3VzUUo5WENrUEhNU1p6TFdzY0NiVEc1ZkxzSG5HdWkrQ2tpQzFJeW9meDJv?=
 =?utf-8?Q?Or94R6Fi18Jkzcb5MV36IOzJD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f63e226-b251-4f0c-5581-08ddd9465fd6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 02:17:23.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY6RTXdB+V1xukw5+421vm8DSamoUnYFBDypCGICv1Kof+9a6SbiB2hRRWABQv1kTeC9Tnj3KOHoOh4k6gSARQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
X-OriginatorOrg: intel.com

On 30.07.2025 18:09, Vinicius Costa Gomes wrote:
>Yi Sun <yi.sun@intel.com> writes:
>
>> This patch series addresses two issues related to the device reference
>> counting and cleanup path in the idxd driver.
>>
>> Recent changes introduced improper put_device() calls and duplicated
>> cleanup logic, leading to refcount underflow and potential use-after-free
>> during module unload.
>>
>> Patch 1 removes an unnecessary call to idxd_free(), which could result in a
>> use-after-free, because the function idxd_conf_device_release already
>> covers everything done in idxd_free. The newly added idxd_free in commit
>> 90022b3 doesn't resolve any memory leaks, but introduces several duplicated
>> cleanup.
>>
>> Patch 2 refactors the cleanup to avoid redundant put_device() calls
>> introduced in commit a409e919ca3. The existing idxd_unregister_devices()
>> already handles proper device reference release.
>>
>> Both patches have been verified on hardware platform.
>>
>> Both patches have been run through `checkpatch.pl`. Patch 2 gets 1 error
>> and 1 warning. But these appear to be limitations in the checkpatch script
>> itself, not reflect issues with the patches.
>>
>> ---
>
>For the series:
>
>Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
>
>Cheers,
>-- 
>Vinicius

Hi Vinod,

Gentle ping.
This is another series of bug fixes.

Thanks
    --Sun, Yi

