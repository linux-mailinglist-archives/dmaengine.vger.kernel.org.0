Return-Path: <dmaengine+bounces-4149-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C5A15A3F
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 01:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4437A18899B6
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 00:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F4F1373;
	Sat, 18 Jan 2025 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmVjhDCh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299B376;
	Sat, 18 Jan 2025 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737159476; cv=fail; b=sJvC5vl2lzweft7ZwRkev/S+ECcZDOrVZcpOiSkMUGWRkjkr2dUB23RzXeOnQd1+xff+hE6e4UGFLA0i0gZRBgmh19GMAjURqlXhct7XdqYxY4uxEIKn2svEhjRm2QiwLwLeBY25IPBW7LoLm+37wVvNrUNZSubvwFYz2WFRmiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737159476; c=relaxed/simple;
	bh=FS6RvFSTxqKqODQzT9/DBSHS87ESlxd3wc3RmWsVt/c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RmBMgp9g06NJazLRctsNkBTwej3hFR8ZOX9y6p0DVuG8aAO4fZX0/+C1tdAds0pxuP3CEjU4NvYN3ttt54dV2KbR9Ff25mg5Z/wHAH5bvUdYiY8wrDdue0uvuLeaeKu7WWmoB4JEn0iVI4zOT1XtGgSyYeGI6XtVBmTUqq9tT84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmVjhDCh; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737159474; x=1768695474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FS6RvFSTxqKqODQzT9/DBSHS87ESlxd3wc3RmWsVt/c=;
  b=SmVjhDChzjQ9DhhwlW/t1YdEJfMrWzmj0u5Zg7N7VQ9jQcnU1fIkkhYi
   1mfhzANNlUQDoXJDV2ISp71ASavLvxUF5uSKXA5FduitYiIBaX3fXNmda
   aI2dcv7AhY6ij/WJKn3gZgENucP3fWiz5u7PISllkcEiJ+D+1Jhisj0kM
   /aneW26LBFvEhkIXb5bDPqX4dLShbC8NuOO+7cXhPn3RnDxAXibq2Hx7k
   7MYu9TyOweIuOC43qd8iG+ckv+1u0Nv3lDnkdBnQDM4aUUeFIa+UsF/jH
   +XFQXHibX2YN3zAEUWKn8DPVxVtO0YohoR5UVYYwma6OFaPXfLcKqsAUv
   g==;
X-CSE-ConnectionGUID: xBOb1Cx7Qp2ZVZwzhA1ygw==
X-CSE-MsgGUID: 6kqut+3dT8OXb4liWfS9lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="41372312"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="41372312"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 16:17:54 -0800
X-CSE-ConnectionGUID: CYxio/hOSeeaoveitFzolw==
X-CSE-MsgGUID: XTpHXPkPSx2FROK+xb+moA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="136784507"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 16:17:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 16:17:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 16:17:52 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 16:17:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv74bH/HR+c0oFpslT3inoYjcdb9gG202tu3qjaJY3UvgeCYF8pqsVymWKHLSzWBx7RCgmCO2tsNB7WPny2AlgSKtLgPxhF6EBZmDozU1I2GwMDB/n5KnKpZrjWZIgc03XqlZWg15fn+NnBn3iII2W6Jf6tjhR6WGtYRdsRLEO4air66meaqShKxtwN7lOBY6QoIVQejYzT8X1y2tXeyD70yiC1WjXNAOXt9bFldbmNGLm1ZtzDH/44FwlSKvF/ZxE4AirJ8UV1RRYDhEl235HNXkr4bBl4YrfT72HsJ+pWSaEhsBauAfjGKc8VPLOgsJOge/s23pssIJ+BlbWND9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEvek9B+2UoN3bioMpUhrMica1SmJ+7K2SDjbG4SL/4=;
 b=y808t4w+ZfXaA4jAekN1M+D2eZ/pNaEMiGAqbmXa1w84MxlvpiNYY9qgOBfWfjxBDtbgzUWix1ie35PgeANpJeOduduS0++Apg1DnUshq7HtHSZ8QhB8LPKNdJDCutbtWgQfK1JUYsbd/7tywt8QskybnrBdh6UYFIJ/OVBcRFyGVwnKLv0XHyG94q/9rdrDrQxyPEp2YNuw5dW0gMzpT7HGRiguO76VKUdUHzvwe1A4MpGacG3CPTZ/R9an3zp/sUXQ1o+TaEB6Xi5k6XfrqeSuXO7QE2ZGhRNSlejRFHXnzN1iyOsuKPMigmsAdSJ82Xw40RuwSR5RZi/VTmA0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB8202.namprd11.prod.outlook.com (2603:10b6:8:18b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Sat, 18 Jan
 2025 00:17:16 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 00:17:15 +0000
Message-ID: <bad17290-10bf-f162-c49a-4822335bb9a7@intel.com>
Date: Fri, 17 Jan 2025 16:17:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Delete unnecessary NULL check
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <ec38214e-0bbb-4c5a-94ff-b2b2d4c3f245@stanley.mountain>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <ec38214e-0bbb-4c5a-94ff-b2b2d4c3f245@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::38) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: f92b5a2d-c75f-40f8-1eed-08dd37557673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1k5THJpNE5HSkY2REpIeDRhOTFNR0syTDlYMjlPS21GWVdaYVlkTm1CMTJT?=
 =?utf-8?B?amE5c092K3FDQlQrckNoaTBaTEVJYWFROVZVRzdscHgvVWExWHhUUUJUaitS?=
 =?utf-8?B?Q21rRGVzeVZyQk5MUDdVeTR4ZXNWTW5nSE9pMkRVdmJwaFVpbnN2MlliN1NZ?=
 =?utf-8?B?Q2hIejA0a3V1dThibmV6SmVuVkpjdXliWVJCM3l6VkZiZnRXR2tLV2c1cGZQ?=
 =?utf-8?B?K0RTNGJkZm54N3RWbkkwejU1M2lPRTdQYkhnSEZHRlVTTi9kajBvMnBWTmdz?=
 =?utf-8?B?MkxZcUpzckd1ekV3MnF2UnhZTkUyQzQ3ODNNRWF1R3ViMEhEVGdIQ1pSeXZT?=
 =?utf-8?B?MFVIZUhsRHNabHpXWithejNLY0dMZU9RZzFoektIU1ZqWDRhLzRSeFoyaUQr?=
 =?utf-8?B?S1Zaa0ZMRFZlK0xYNU9yc0xVajQ1ZEpxNnN2cEN5aDNvVTIrNGd2b081Wkc1?=
 =?utf-8?B?c0NWdXdsK2tzb0RITFU3ME9DaEJwUFdDaW82MU44Y2J1M0pPL25qN3BseU81?=
 =?utf-8?B?TkZ6L2JBUTluZkFmZlBNeU9GQlByOTBCejRkck1ZZ2ovb2dFd2thaFVwRkFz?=
 =?utf-8?B?K1BGam91YmxaTlFmZ0E0bTdpVERTWUpQQUR0M1ZaU2taTUtEY1kvNkNNdVhx?=
 =?utf-8?B?MTJNVVhJTWZCZVoyTTNEUUdwejUvY1ZKN1ByakVmV2ZqQzV4NHZvaTY0YTNz?=
 =?utf-8?B?MURSUjZyVkRSSS93Zm5OK2tIKyt5Q0lkby9BM3Q2Q0FLeWJXQnY1Z2I3a3ZK?=
 =?utf-8?B?dzVBR0dXdlorVWFhYlNtQTY2MDE1M05pZW41cWFJbkphdmN6ZTJLZ3lDdE9q?=
 =?utf-8?B?T1NySnVSOVp5MTY1RGJYMmthcjQ3Snd1WHJFQkpuNjBtOGw5emJWWHU5SHRG?=
 =?utf-8?B?UENRVVVFTC9Xb3FaVmFYN0h5YWNFeW1COFExVHAwcUtGaXhkM1JXRTd0Y1dZ?=
 =?utf-8?B?UTV3NUVvbk5jZGM4bDJsZ3dZQ0ZEVVppTVBQRzJJa3NoY0NlUkQ2NGlSR2Rr?=
 =?utf-8?B?Z0FnQjFHVGZkSFZ4Z1BxUkVYVHVXQzNGanN5cHZobEhEMEVKTGlFbDFRNHAy?=
 =?utf-8?B?VzdFYTBCTm0vMzZMOHcyVk9DVmNrK3RrYzhwTzY5QUltTEpIY1p1eDFQTHpO?=
 =?utf-8?B?ZGpFUkNsVXBkaW1QeVdROVNIWVNYWWcwbWI2Undud05JbW9DKzlaYm1CQTZW?=
 =?utf-8?B?Q3cwN0JvTVJRY21JTFQwU0VIZ2FMRk1wb0FlM2lSWUw5Wi8zaC9pdXJSZCtH?=
 =?utf-8?B?NU9Uck1ZT3kxMHhOeVprbEt3R25DclZPNW5GTTBHUkJ5S2piZ2x6bkR5OFdH?=
 =?utf-8?B?enV2UmxmTVVWZVhuN1lrUVFYL1BRZHRxYmFibEMwNUJFUUtjQkJtM0N2M0RR?=
 =?utf-8?B?c216OHh2TXlPTFpKNmloUWRaTzBoZDg3SGxuL0NNSXNHdlR2dEE2dzdZRXQ0?=
 =?utf-8?B?OU5pMXQ1TzRyQnN1Vk5RMGwxQitxWFNiOFp5OFBvRjFlMW9idUsvcnc2MUtt?=
 =?utf-8?B?Z0c4TGJ4Y0JYQ3hWRnJxdjdZTWtUSU84VUFUbTVZbzZDakE5QXpGNVJYdEpu?=
 =?utf-8?B?aGhaR044R0ZjRUl2UTZ4SjJwWUtmMzNBQ3Q3SjA2eEU2eFJrMEhvNk9jMVAz?=
 =?utf-8?B?VGxwUTZtTzRSQzAwU3E0cTMzdzJBSUJKVTY3Sm1OMlIxUXFkSW5hRGhZaVdC?=
 =?utf-8?B?UjNic0EzdTVYbzRWQm9VMGtLUVF6T1YxY3lpci95NFhWeFB0WnE4cTdoWDFF?=
 =?utf-8?B?cUR4Ni9tMVpTY0duSlpmcExNZ0EvTVV3cVE2ak9OYTBDK1F0RHp6ZkpoODMx?=
 =?utf-8?B?cUU2V05MM1llTHdKL2VSbDQ3OVlzYXo3KzB3TElOVzZOLzlOQTh4dWNCNWx3?=
 =?utf-8?Q?xqUpm+CJdSdbB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC8vcW1RRys4ZE5INll3OUxJQWZoL1pQWVE4TjBGNkxRTDRiWHVTL0FDSFVE?=
 =?utf-8?B?R3ZtNXIwTno4UFRkVDNUcmZENGVwMHJpM21LeFlNSWN4Qk5SN0FYQUVQSGFJ?=
 =?utf-8?B?c1REWWZJN3NSbjI5OHNTZzRUajBtNzdDUU5RSEZHeVc4cEdsa2RvWmNWcHBP?=
 =?utf-8?B?MUUrWFBBbG9mdUFXSkxURVRzRG1ncEVpTDlVeEwyWG5jTFM4enJsK01TK3Aw?=
 =?utf-8?B?cmdBVGIwRHJPZTdaajkxNGJhZEJqUEhKUnRjei9PMXNtbzVSSTlWaXNGWG5l?=
 =?utf-8?B?WGoyak91Ri82OWpNdzBFdE9WVFczcUhmbks0b3dFTEhPdzY2QW5pYUFuUTRp?=
 =?utf-8?B?eWVVSmNwWTFSMVJacFVtSWVjRFdRYm5SaDROK2tMT0hzbFVsc2dvalB0U0hD?=
 =?utf-8?B?NVZya081QzJRVmlQY0xVeERiQWtXbGNlT3RtbXV1Vk1ZUkNnMUU5QVhHQ1k0?=
 =?utf-8?B?ZUs4RDRvRFViZUk1Z2RUWGtQcG1DY0VUbHZzbTFxbGFrUlBsUlpiVUVwNld4?=
 =?utf-8?B?NjcrNmJEaStUMVI4N2hYMEoweDdZeE5PWjJUYWZCbTdDK0FBd1Y2N0xJVk9m?=
 =?utf-8?B?NUlJUy9hRDlTcC96N3RBcXNzMEpIeFRIS2NvNU8yVGZJREF6RGlYVXVyT1Ni?=
 =?utf-8?B?aHZNRmtXcmtuOURBM3ZSVDlpN1JONnRaTFV6YzhHd1B0dWpFY2ZmZ1VCOXdw?=
 =?utf-8?B?cGxQdXQvSm11c2tXY1NEVjJucTdQZ2xPVGZCSEZVSS9CbWRMd2xhNExacVJt?=
 =?utf-8?B?UC9udllRRFJaWjNBeklLVXdKNkp5akhGclBDZm5jMTlsa2w2a0R6RlVTMkhZ?=
 =?utf-8?B?d1pCd1ZEa3RaUzZhTXJyMGpCMDJEZjMvdlhmekNPR0J5bkNUOFRXMEdtTUVE?=
 =?utf-8?B?a2V0TDJEL21pelArNmF2aEVUTW5ITEFvWTdhclBJS3VOcVYwVnBiOStpdWRJ?=
 =?utf-8?B?YUJWK0dQTittUXp2QWJjeUFaMDFldFJGWlNYb2dPNGZDVGFieWl5RGdsczhx?=
 =?utf-8?B?QVBGUFVDOFZLMDJJVS9kby9DT0RjWkYvZE1tbzZDa0x1ME9xd2s4RkVxOGR1?=
 =?utf-8?B?RlpFTU5hWktvNW56NkJtK0dsL3pTdWcyODNPZ0NrRlhVNmgxZ0J4OVoxcndD?=
 =?utf-8?B?cGdhR2xpVzJrcklrT1dmd05zQmt0b2YrNG1uZ3RRMzI4Z1YxZHRwa3ptQVZQ?=
 =?utf-8?B?QmlHT0cyTGt1RDJkS244WUNubEZ0bXFpYytaaDFFV25BYVRlTE10UnBIbi9F?=
 =?utf-8?B?enVvQWhvcTFUZTgwcDJkVU9lS2ZPL2RMTlViTmhhbGdiUW44clNwd09BMUgw?=
 =?utf-8?B?N0NGVGdUZHJnaGtWM1VYbm9kQitKdjZLR3F5Q2N2WFJPTm1xdGNxMTFKOWtE?=
 =?utf-8?B?MlBjVm5kMmxNSldjRGd1YlhvZDFyb24vMGE4N01yc3pyc0Nsb09kdjE3bDQ5?=
 =?utf-8?B?cUs4aTVzMFY2Q0c2OXJ1UndGazhVSDZSekRqZmhtUjB6MTZyM0RLQ3NlVmlV?=
 =?utf-8?B?NUlOQk83V25OREJSenZMZUtHRlBhV0pOa0NYTG44L3l0VUZ2RWtTS1B5aVFU?=
 =?utf-8?B?U05aaTJUTjE3SWQ1VVpjMHBTNXJNenU5ZFFDVzB6cis0YkJVMVFrMXphTFRn?=
 =?utf-8?B?ZVN2Qy9zamNLdTQ3RERzVmhxTUFycGlEeXB4dEJ3RWJNMFY0czVxV3lwb0Zu?=
 =?utf-8?B?c3JVZUVIQXp4Tml2LzN2NXMzNjIyV2c1T0pnTVFhek1Ba1hRZ1d4OUNnd1JL?=
 =?utf-8?B?ZlY2Tmp4WDZaTEdnZGlaNmh3S0RiLzRLSHpFalFMNy9VbjJyKzNSZmpCd1Bt?=
 =?utf-8?B?cFg3WHNselhEVnIzNzFwcGplamloWkNlV2F6ZldyTXhONGx0RDE2b1BROG5H?=
 =?utf-8?B?RVhuKzFCTVJEMlRCTzBuYkpjZVhmUzhuYmJ5Y3ZaQ1RrRnpQaDd5aUxMcEVJ?=
 =?utf-8?B?N3h3azB1TTZzSTdPd1pmSzIvb0xlYkdrbTM2ekpMVXBUSDB6Uzh6dU1meUpG?=
 =?utf-8?B?cDA4SGQya1g5Z2J6RjFDMlZpdm4wSm5yRkZZKzVSeVpIdTNHN3NYd0lMcFcz?=
 =?utf-8?B?VnpXUmtFU1NhdXoxNjJpQTRRZUFpSmZBTXVWTnFZZHpCOTdqV1R2M29INENF?=
 =?utf-8?Q?dHUB2OyS0KT4cMJYDYN1OI8+O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f92b5a2d-c75f-40f8-1eed-08dd37557673
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 00:17:15.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp9pff5MenhNFgm7CwO0U+l2NI2U4FDsKho+YvBhRB+s8wDnKKMCT3heN6xuxuEpX/9yPxLtGpxrbZauprCcaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8202
X-OriginatorOrg: intel.com



On 1/8/25 01:13, Dan Carpenter wrote:
> The "saved_evl" pointer is a offset into the middle of a non-NULL struct.
> It can't be NULL and the check is slightly confusing.  Delete the check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

> ---
>   drivers/dma/idxd/init.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index b946f78f85e1..fca1d2924999 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -912,8 +912,7 @@ static void idxd_device_config_restore(struct idxd_device *idxd,
>   
>   	idxd->rdbuf_limit = idxd_saved->saved_idxd.rdbuf_limit;
>   
> -	if (saved_evl)
> -		idxd->evl->size = saved_evl->size;
> +	idxd->evl->size = saved_evl->size;
>   
>   	for (i = 0; i < idxd->max_groups; i++) {
>   		struct idxd_group *saved_group, *group;

Thanks.

-Fenghua

