Return-Path: <dmaengine+bounces-1009-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F11F853700
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 18:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9AF1C23C79
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51F5FDAB;
	Tue, 13 Feb 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxBTZa2Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F711BA57;
	Tue, 13 Feb 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844578; cv=fail; b=C3QJaEN2UZrqphEljn0oF/Womw091XWAaSgPrQOY4V4IPP7znfcLT/TA3hvKa9SSOHf3390oVpRgl4ZYJ4DolaAYfIYUstdT0e2al+TIf+id5Uyzub4BxZzPLyZwsYsxXwBXaaxLJlpA9bcwaeL6NcCqYz2C2kFskrVaZF39nTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844578; c=relaxed/simple;
	bh=9okxQQqfbgXGRi88WLuPn+4BK9gtMC2sw+LsMveYjmA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FTCiE89yAL8xYiz0Rgm8uVYgl78xTcurDzv7BxwjniXiB/xnOyx7P0q8Ki2UzDxaA0dHl09fIsTgyWUl37KHAa5uuObzqVUcUsOEHyZOIYcE98sFML04b0mqw++MGMwm1UpMGPdqbuJceBFZjWSbpSPK9tIEOoyirsF+MRGBaBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxBTZa2Z; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707844576; x=1739380576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9okxQQqfbgXGRi88WLuPn+4BK9gtMC2sw+LsMveYjmA=;
  b=JxBTZa2ZEAKdYXY0YpN1A4x/a7XPx76jFR1sec3sBx5Li21CXTECxpnN
   PQO1JLoTCH2kjhfAy14K6EMpJi405+9Ws2qG7qox0zdnp9YXQEcVyjMuy
   6x1Px+jr3oMufTht3lbP3xEJFAHWd2DOT2UfkKX2JbrRhXSNphhVTAx6+
   50KAxiAW+O77E/xfkQ7PDsfqb8e0jr0sEiwRHr2Bo2iF8hOj2BkXZary6
   Ev73tBdm6NEJoX5DhRb03qhIwURAoJsJKaJ+39u82tnX17+wCfUrkAVTD
   Mlf5u3IAl5TnWVjNIr57SBzBrzoLvDY5oG6iyDHxy5wI5iRdVWjOO2Y1r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13249896"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="13249896"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 09:16:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="3252793"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 09:16:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 09:16:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 09:16:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 09:16:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 09:16:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcxaF38cWj2DZmZpLkII8Nxv/mrCxHVUHJZIB+HSOnXgXv6vAkDPUu7TOYc8fQzRS52Nyqmg8v7x00hShFVPVDhYXxW3EN0z2/SsBI74vU1vxpD3POesAmuVTE2Bzp+0ef3ji18Y5P5rMHsrzi7IWKWpnNR2Kl19RzwrKgeMsyxLe35Zf3HDtWdqMB5gF373A6S6OPQceZWVzW9NSSfirHsHqNQ9e01bCzRGmMdFOz/XZnZMmZkTLL4NIu0Rn50MbuIyCbFFTP8zqz0cbknw1gkbih1uNdE05b/XwBoedQv+/xY/Lzrc8ehakqzjXjzZzfFDO2553Ten0MJdzEd6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MamOAL4kCvV2BbdcYTGWw8iM57BcifBX9UiCEXOWYps=;
 b=GI2BvgqFQGE25GyMQ3rIlXVrOwitNHROscOiifheVVBlDfxWjxWFfQbNMJshPKf86hMM/phjW1UBhXJ7vxt69oHO8PE3hpvneQFfSZEsNiExqx8t5gERX78+vaiCqJVvVCngzNurm7djTO+FumGH1/xzcRPNAQoQ5D1WVpvjthYQxkfO2dOCUhSqngMiygGgABlGAke3lAV1+yuVfoN1M2scAsYN1Y2rHhJqKjgvH4jt6g9mMozyEuhIkUMi3jYP/cj2aIcTma2tZ12BPnyHggtEW2fYLAxocF6WzwiFX/RvcKrHmZ7RArqc82GGbNo+4coB4gnLRCaMRfS+776G/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BL1PR11MB5253.namprd11.prod.outlook.com (2603:10b6:208:310::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 17:16:09 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915%6]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 17:16:09 +0000
Message-ID: <9399299d-332a-837f-358d-5028e50e21e9@intel.com>
Date: Tue, 13 Feb 2024 09:15:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: make dsa_bus_type const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Dave Jiang
	<dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20240213-bus_cleanup-idxd-v1-1-c3e703675387@marliere.net>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20240213-bus_cleanup-idxd-v1-1-c3e703675387@marliere.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BL1PR11MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b2b504-03d9-448d-1160-08dc2cb778aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiGa955MNMnowyoS6iesjd/ixde0zO7AHs5+UZayDSFfdoj/PmK2vTO9b9moSfDXzmjMDhF3LXqxtUmyreke1ek47foo4GDYJOr0v/FGRZq93qmoFGyew8enG/82kta/Yd8anbuOd6FagPOv2P4dKyX9UswAeH61iLaLv+kZhwNr1E8h+EbUgt3mPULnNcICpy3IJtMwjhSjhAhB6WIlIwC2+Y9P/k+HNAT5tRZK2MZC0CxgSsQhuPoREtEclhwjd0v82NNUNhs4NRXVzRG6H0SjCxDl/vgRdWIfk8S+8lo33iv2A1v2gjH2Kc2qcSuiPKRjXTNMgmGHXZ+hdx4/oXsm94ty0iHAwSeqZyHll6mSr2KU+ZrK2E4v+B04HdJXdvPk5wxigQKoLFu7OtC7xIcLGd42n0DsOVS9Bazqi4uoFKUzBSVUkI06i68l4IJI3r3GIoTOcfOB4Y4VR3marWw1US5yeH0qeurPcZoec/pqki/KI1/aZ5lE0/WlJ4qDyn1LgQUUiJRseJt2UeIoS382cvnBzeEVXVDWaFxLSsSRBgkHV6NfU7Pqqrtujcah
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(44832011)(2906002)(478600001)(53546011)(6486002)(6506007)(66556008)(6512007)(8676002)(8936002)(4326008)(5660300002)(26005)(66946007)(66476007)(36756003)(41300700001)(2616005)(83380400001)(31696002)(110136005)(38100700002)(316002)(6666004)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2NhaEFQU1l5R09KQ2pMWXZ5Zk9YaGxRdUkrVnpQV0NnNHBVSjh0U0pGWGxH?=
 =?utf-8?B?WFQrd2F0aC9XcHJmcWhCMUdxK3lqR2N1Y2Q3OHpoZUdRZUdsVzUxeW4zeEtR?=
 =?utf-8?B?aXVxQ1R3M01reG1KUzM5YSt4Y2oyQnRraVZMQk1iRWVnTm52emI2eldPWGtw?=
 =?utf-8?B?Y1E1T2lpOE1PWERWVHROMld3U0VuSFpDM0hzOG5ycXNqQzZBNW8xOWtKbnVV?=
 =?utf-8?B?d2Z6S1VxNGxDenkxRGYwQWlXV0QxUmZteC95cWttWC9NUW1YMVdMa29ZOTd0?=
 =?utf-8?B?Ujl2Y1U2bVA4N09wVzFJRll0YzF3TUFxWitZWDJsKzNZWHlZQXZ0aVBWalFC?=
 =?utf-8?B?VmV3aE1tK1l5Rm5XZ3NPMEtIZlRVMGZXbzhEQVExelBUaVl0dEpxK2R2QjdK?=
 =?utf-8?B?MnpPVXpMU2pUYS84VWVUSTJJRE5lODFFY1Mwc0YvWEMzRUtqcTBpQTU3RHNz?=
 =?utf-8?B?TU1OellsWmJpUjhnd05TdENtY016MFo1VjVtL2F0d1NCT0dxbFpPRW1wZTFV?=
 =?utf-8?B?Y1BKTDJtY1QrRmFWN2NKZitiLzRNcWNscTU4UjBnam5TQ3lJNTBUc3dVRE8v?=
 =?utf-8?B?NUVWa3AvUTlGOVhYUkZ0N2FqZmk2RjhySWZmbFd6bVR6YzhvNldHYWhNZ3pM?=
 =?utf-8?B?MGVXRXpRM01ZR0RYKzNSZUx5MGJ5WXZvamk5WTJCK25RRjNBQklnbjZrN21q?=
 =?utf-8?B?K2NnNGEySFlRUWxndmhKY1RNa1RSN1lxVzVhaFBrWVhsaTZJWGFJRmVUdDF4?=
 =?utf-8?B?ckJwTDRuWS82TnNLZkxtcHIwK1NEd0FjeTJOdmZPYzUvajNuenNqQmcvMmQ4?=
 =?utf-8?B?aGdpWGNjRkwwaVVib1U0Mmg3WVBtd0tIdDdleUhrVXNjMUNoTnFMd1FjR2FG?=
 =?utf-8?B?TTdacVBFR1Z5c0MrdERubTJUdGYxOFNSZGwxWU95TWwrVW9yTzM5a3RvbjZ2?=
 =?utf-8?B?VmlJcWVHZTZQTGxyTjNXOEJZVzQrTWMrNXdaSG1oTllib1JmWjFVenpKZnFI?=
 =?utf-8?B?R2xaaDlsNGNOc1dUSG50K2I4RytJWEp4ajBkZlc0QzV6N1p1TFBHd3ZWSSt5?=
 =?utf-8?B?VTBMRWFWajNrdzNXdzV0RUN1SHM5MU1kbzdSamF4SXR1aloxdkJEWTVybGVz?=
 =?utf-8?B?ZnBlZlVrQ2E2bHBJaHFQcjdrQzQzNU8xUEgzdHFpcmtwZ1d1a1A3TXFISzlm?=
 =?utf-8?B?WmdaNHNZTjJtdEpoT1hBbUVhYW9nb3BCYjVpZ2dpVyt3anNjQU1vNmp2aEl1?=
 =?utf-8?B?Mnh1eklKYUZEQmRiZXFuRXFrTytZdmoxYlRvVkZHR3NFS3hrdWJ5WURBMjNa?=
 =?utf-8?B?cmlFYzIrVW1FTDAwOGFzL3VId2hZM05FdlVhaDNSSWRESmp5a0ovWU5UMlRo?=
 =?utf-8?B?WXlqaDZqMHJSWVBmZDYwSGk4UlhzTWQ3M1FlWVUvV1phK0VTeUtrZVZmYWdt?=
 =?utf-8?B?eGJhT2VFaWhtdmg1UTN2VnJVZURDa3RhejJoSTRhRHF0UmFwY3c2UENkSFQr?=
 =?utf-8?B?cDhFV1VCRENjSmlycitQRFlGa2ZHenlRdlhnYkVzenQ3STRYcFcrNnhBS1Jo?=
 =?utf-8?B?OWNiQnVQdmY0eXRGMVZMVTFOUUZTTHRaelo4VUFzTnFhemY3ZGtWejRmV0hk?=
 =?utf-8?B?T0NUMGlyODhNTGFqRVc4ekt5bUdyajU2MGVaTlFNaFNXMVo3MkZ3LzZnSE41?=
 =?utf-8?B?QUxtZzd1UUtKT2cxNHlkbFpCYW9xYkJIcWZ4QUlLUVNKQzQ5QytUUXRqZmh0?=
 =?utf-8?B?ZENNbG1lRUd0TTd6VXMvbTljWGM2OHIxNVl1TXI3TGt5SEN1SkZJU2dGSnZp?=
 =?utf-8?B?SSs1cDZKcHZydlNCRWVqZDZ2ZWRlZTd0L000alVPZnAzTS9mZkF4VWNwOHFp?=
 =?utf-8?B?QzNCK2dta2c0Skl4WGpIUVU4Z1MyM3h3Um5PNjdabnFjYnZYTHRoYllTSXli?=
 =?utf-8?B?S0UyZDltcVdVUWtqSGpWRjkrRU9nNmtab2k1MkFxbnBpRkRXZ2dHVFprV2hL?=
 =?utf-8?B?MlZ3YkN4d3RIUFhjcTRqdFVJeUZRRzBPbjNwQkJvaEVuZjNIak1NZW1vU1Zy?=
 =?utf-8?B?TmJ6V2lsV3YxS0NKZUw5cDZ2QUdJNDNlbWZIRDNMc3I2MEcvMzljclZxNWxW?=
 =?utf-8?Q?1WPDGd7I7KVwANbLed0EPpMEg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b2b504-03d9-448d-1160-08dc2cb778aa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:16:09.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGkZS85TSE237US6ekIieDyMsJ4khjV/UjVcNgHx2QTLb3zMYPgTvcSTaYAEph8THP/mwrqncHNSOX4MkTiO4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5253
X-OriginatorOrg: intel.com



On 2/13/24 06:43, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the dsa_bus_type variable to be a constant

nit: s/, move/. Change/

> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

> ---
>   drivers/dma/idxd/bus.c  | 2 +-
>   drivers/dma/idxd/idxd.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/bus.c b/drivers/dma/idxd/bus.c
> index 0c9e689a2e77..b83b27e04f2a 100644
> --- a/drivers/dma/idxd/bus.c
> +++ b/drivers/dma/idxd/bus.c
> @@ -72,7 +72,7 @@ static int idxd_bus_uevent(const struct device *dev, struct kobj_uevent_env *env
>   	return add_uevent_var(env, "MODALIAS=" IDXD_DEVICES_MODALIAS_FMT, 0);
>   }
>   
> -struct bus_type dsa_bus_type = {
> +const struct bus_type dsa_bus_type = {
>   	.name = "dsa",
>   	.match = idxd_config_bus_match,
>   	.probe = idxd_config_bus_probe,
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 47de3f93ff1e..f14a660a2a34 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -516,7 +516,7 @@ static inline void idxd_set_user_intr(struct idxd_device *idxd, bool enable)
>   	iowrite32(reg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
>   }
>   
> -extern struct bus_type dsa_bus_type;
> +extern const struct bus_type dsa_bus_type;
>   
>   extern bool support_enqcmd;
>   extern struct ida idxd_ida;
> 
> ---
> base-commit: de7d9cb3b064fdfb2e0e7706d14ffee20b762ad2
> change-id: 20240213-bus_cleanup-idxd-8feaf2af5461
> 
> Best regards,

Thanks.

-Fenghua

