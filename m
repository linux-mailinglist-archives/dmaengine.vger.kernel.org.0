Return-Path: <dmaengine+bounces-5279-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27BAAC85AA
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 02:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87E57A8410
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 00:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FC61E489;
	Fri, 30 May 2025 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8QWdPdD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912E1BF37;
	Fri, 30 May 2025 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748564731; cv=fail; b=Lz/WBdN1czOhy3tmGRKzimUlXQ+MbHeBwdQ6/K5nCXps2qMNT/uoCrUxFXb2CmfKTqtEKLr774mfom5grnJlNJRBbKa7kUFPqR864Iw1fNZDOxzHKGugIjvqpYChjnueI0OCwIJjrvKrJ7lPtb+5GvikbJdLyu1I4NXWdqm12pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748564731; c=relaxed/simple;
	bh=BQJ7jeEf8DA2zvBNis0C5oidOXfnPKTSVUmXoXu29pE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PyGrdO7Zl08KtwSp+GBOcVc8GxLZ1kKyK6kpvqGEQu8phVC9OaVVnH0GC1UiOovHq5HAex0o8Xtj24IqDFacXV4fnZDqPYED1LZqzxqDsF38OWKckq5lB27pYJPp1ivvKE5MnVCeEYGrkGoAmar86Jgh5Ropkhgifw3wQmpSrLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8QWdPdD; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748564731; x=1780100731;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BQJ7jeEf8DA2zvBNis0C5oidOXfnPKTSVUmXoXu29pE=;
  b=E8QWdPdDQIiP1tfn5UQXY9Y4UgMk7jvHfyHrFf3HH814gn0DjeZuVOuD
   G4pOpjS21gFlFvkPBuogrMfue2Jp9nApyvPu5j34ECbDuvQdP/FNLLKKQ
   po2cJ8L7t5TXQZfPvXVkoL7fYUNcOkkHCO5F7Q4QI6B4FxqSxlbSNFwDt
   4uBTo9c1E72bXmd2jkoyX7sPbezCWbAdaz0Xe70qviJYG7x6sNoXYYFLp
   QPOraKkvTtkYpbDCnt59mNknWfGFfJUf8uO4XugW+zr0M7BrILTchG1eg
   88jzUWak03NDOWdOur7SarhYDjLTNIJHbfEaKEdFs/Qy4JAVj7KEeGxt4
   A==;
X-CSE-ConnectionGUID: uJ7Vci/BQESw/auR7nyZfA==
X-CSE-MsgGUID: MQcZO9gBQ+iQePHH22Qy5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="61704508"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="61704508"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 17:25:30 -0700
X-CSE-ConnectionGUID: 3bRUkevARauLzLK9B7cFmQ==
X-CSE-MsgGUID: 7Z1DkaD4TKOUKZzOOjMUqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="166897027"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 17:25:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 17:25:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 17:25:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.81) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 17:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RikrcW1ck02AwQNitKNc+Z/fOUEiOkcPeG1g3/3objOJ945gxdZj/PhAyIBARkWicvRXMPcuVE5vKQOsHD5h59GXfZWnr2/iarE9+S9scXtzleEg7cl9nyvgy1BkRqoueRSYZdtAK+796bP276o5x83DFMYa6LMcTZoWv/LGmCiGU+nwNJzHWzPJ/vtB4amLUbo+tgXQ5W8oH9VtXntggYzl6xUptLbntxNu5XH5KAkPmUQ9w2DNwlGX+PaVfT8DxW/wVs7BYO8FEq+zUHrSE97/5hmi8aZaE/BUnVyEhrfGudzBUognlakuLKbA2UUrKiN5QUjtREy1h13gWoRfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=httBNEikhvnEIUpXrXg5osEnoiZLg4hOz0q+TE/aw48=;
 b=nCh1eOjRpyWD1Il9/3pOvJn5RI4SpqiLPfweJy2k1W+xewjw+x2T/3fP38ow3ekrWZlsRWEQ8hs355d8rLwzy2pvRZDvj27i1nNLdsJFvBDMQeVOuJP/7JQlba05wygIbbgcdNzf8HN0iiBs4KhA4yUkF94s1D+zvv6NlRgR42+nfNj4a9kcfPJ4e8datbzstiNuFYrkeXURq5iGJN/OaVoKsYLNR5TBe4Y7hMWnyQDdI1Xrax8u6fCBCwbMR0O4Bm4r0AhWCa6YCSgAlSUjt8GW20iGtG26V5TD0Poc10psOdoqhO0R+90sw7o3EEZIt0677IYphEBWZXkSDGZ2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 30 May
 2025 00:25:00 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 00:24:59 +0000
Date: Fri, 30 May 2025 08:24:50 +0800
From: Yi Sun <yi.sun@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
CC: <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xueshuai@linux.alibaba.com>,
	<gordon.jin@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: idxd: Remove improper idxd_free
Message-ID: <aDj60tJeJ-bYPFEX@ysun46-mobl.ccr.corp.intel.com>
References: <20250529153431.1160067-1-yi.sun@intel.com>
 <87r0079wyy.fsf@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <87r0079wyy.fsf@intel.com>
X-ClientProxiedBy: SG2PR02CA0092.apcprd02.prod.outlook.com
 (2603:1096:4:90::32) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|SJ1PR11MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c528a96-161e-4494-946a-08dd9f106947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVhZam4wSlhzYWt6SFRwbFhhNmxGaXhlT240MFcrZENkZ2dabHN0TklLYkVE?=
 =?utf-8?B?R3k4V1NhZXhvMGsrOE9pWkdRZDFxWGtrdGh5NTd6WjRseWN3Ny9CRFRoYUJE?=
 =?utf-8?B?a09lS3h4RnVEQmZFdklHTnJFVSt2ZjZMU21JNW9MbDFMTlp5QytiRFdYM2li?=
 =?utf-8?B?UEtWa2hCVnR3QjU5YkhRZ245RzBXTWlHbTd2cndVZWJzRmdvMHo0R0tkSmls?=
 =?utf-8?B?NzAzR0h6dkEvVE80dHBadW1lOXdKenRwUG1VWG5SbjZEQkZZNC9NdjY3WGdD?=
 =?utf-8?B?dVRIb0FKYjFNSzAxQmlvcnp2UWVuam96ZEpqRTJ6VmhvY0tTV3JFOUJQdFdX?=
 =?utf-8?B?NTFCT0hJY0ZJdktJeDV5M2RKYXg2by95SnFvWGQ5bytoQUhyVkN2NFliM2Zu?=
 =?utf-8?B?ZTR5M2pwcEdGQ1RKK1Q4d2p4UjF2Nkl2eWs1M1c5aVJFY0FJaTMyZE9HZ0pB?=
 =?utf-8?B?Vi9RLytqM2JLbW5pTzNDTSt4NHBLcHB1QS9WNzFuOEcvdFdJSi9BVzZmUy9E?=
 =?utf-8?B?d0ZFODJkQldNc0FKcnNlY0wyMExweWRCdnFMd0plZFN3SWMzSTVtZ25rYWp3?=
 =?utf-8?B?SDhSV2tlVnV4ekpuMk44RVBNMEdtdm1pRkt4SXY3ZVgzNVRGc1VvQlFMeXYr?=
 =?utf-8?B?SDBIT2hlV0drK3FBM1huL3ozRXFKNU11L1pGWUxVZGI3NXhlT3lwU0xqeVFU?=
 =?utf-8?B?NEVZRlpuaGVHYXd6K0RUWHRpZEZwcTF1WkJsTXZ3cVJ4cEIveHJkVzkzZWdE?=
 =?utf-8?B?bVNiWC9Kd3N2dHdNWW5sQzY2TFV4Uk1MdWV3eDRJYXpvQ2dzVkRkK2FvYUtG?=
 =?utf-8?B?VlhsNk4wYXloUnhXQjVKQWpnbCtndFZwd2o4NGM1MkxtMjlPYW5CQnhIZE54?=
 =?utf-8?B?WkIwTjZBTlZFQXdhdXE1OHp6VWpybHY0TnFHeTU3dVRKdWpaZFl6TEpHMisr?=
 =?utf-8?B?SS9LU2NoajdwaGhRT3d0MWxCb0E5ZFpQVC95c3BQSmdVU0dDd09zbHRZeElt?=
 =?utf-8?B?eHdmTHZaN3IyMGdFNHZpNkZZYzZHaStkMG9HQ2QxSkZIKytuQi83VmV3a1Rj?=
 =?utf-8?B?SGdWZkc0bzBJZDE3NmZuS3FuUjVLOGRuWXZLTjFCalZnTHN5ZG5yMVFiZ1Fw?=
 =?utf-8?B?blllYlVZc0N6R3NwMGJZSTM1WUZOQ3RSeFRDZWNLT3BZcHEwK3Q0QWFjTXZI?=
 =?utf-8?B?ckV4YkI3MTViMW1OVC9yT2hQbHZNZ0pPS3luZ1hUTmlCYW8vUUh6aGdXbzJs?=
 =?utf-8?B?ekEvRXNYUjREMndPWlZjVUFSL3MyRjA0WC9yV2MwM1BUY080TVNhY0xTc013?=
 =?utf-8?B?dHM2cCszMFJEZVI2Z1NCRVdJRVVoUzBybmowbTh4TVpNekFZVlBKVk15OE42?=
 =?utf-8?B?cnpiRmpWbTRpQmI1UmRsREJ6cFlaZEgrL3hwd2dCSEhQUk1XUDFURFBkS0pR?=
 =?utf-8?B?WHVmUnByMnVlb3hrZDNJNTVEUGJFOEpscTA3ang4K1orNWRXc0swaE1pTjlC?=
 =?utf-8?B?dEhIMXZaaHJRNjE5V3RjTXRZQ2s4UWVLejJCKzBzVGh4VnZWUndXSUxwK0lH?=
 =?utf-8?B?RkorbnNTS1VjRXdBc0RsUkg4enlGa0h4RUNLc2s3RERiTm1oNjZGa3lCWnBh?=
 =?utf-8?B?OW9QWWo4RDJJRWRRR2FGbXhHWUFpTmlpb05NckZPRVhYUXBIeEhwUkVNOWxU?=
 =?utf-8?B?V0ptM2lvK056R0pwdXNieXQ0WDRjTGZ1c0NFaFVxWE9DRFl6ZUx3Vkg1bURl?=
 =?utf-8?B?eHZvWm5BTExQblZYbmVuRDJTM3E2czhqM3RhUDUwVU9IcnFhWTJpVkhLNElS?=
 =?utf-8?B?MHN1TFJ2bzNCcXduUHMyNGpxb1FPSWk0RW9mYytLZG9wTHgvWkhOZHFCV1Y5?=
 =?utf-8?B?MWduazdIUGlvMFh2WU9PcEhWYkphbzZ0aHV0TGhPZXBidlN5eXRKZHdzalpy?=
 =?utf-8?Q?qbwNbQX1KLA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2NBTlR2VkNlejl2Vy81dmZhRFpsZXY5VWhQa2M0LzZCMFgxZXBUNDNQNXdN?=
 =?utf-8?B?U0xOa01Ud2V0MTJ1aUlUTjl1emNKd1JzMW9WTlg1aE5vR0Q4aVBQeHh6ZDhK?=
 =?utf-8?B?YU5PZElxNXdZeW1TQ2VyaXA1K3FFYkZ1bEhXWCtkOHlBTndsK1R6cVJoOWJi?=
 =?utf-8?B?MisrTmhZWDIzM1RhajBqc2JCWnh2em1IRUZJNGNJWXc4MnowTHdXSUwrOWdG?=
 =?utf-8?B?dkVWZ3UyaEUwL29sRTZmdGVIeHdUajUveEUvZU9EQ01zZzJPUG1aazJyNDlN?=
 =?utf-8?B?SWJNQkM1WTNoUWdJOGhYN0Q0akNzRUU1U2h3QjJkamsvb1JnTEw3WXQ1SE9j?=
 =?utf-8?B?dDduendqVWQxSWM5K0VvRE1sWDVIWHJFdnphbURRMkNjdE50OUhtZEVuNFUz?=
 =?utf-8?B?ZDBJeEIrSWN3NE1mekJyaUhtN0FTcnNTSXB5czk0MzdwUDJvV0w4QjFpTjc1?=
 =?utf-8?B?a2hIQWpqeExsR2NvT0g4bFVaRE9aQzFEVUZkM25uRlIrS2FsUzFXWnQrTW1n?=
 =?utf-8?B?VGpaMm8ycENIQURHai9VMnB4RHJ6V0kra3J3MDRxdHVZaDhLVlQ2YzJsdk9O?=
 =?utf-8?B?Y3l2N2dWcXBiVHRRZ3BQVFR3NmJyMGhna2hIZUN4UjFOTGJnc2ZudlVnbkN6?=
 =?utf-8?B?RXVqazVkOHBsS0k3Z09jY01VOE04blhrRWx3azVBcDRIdVJVeS9QL20vMzda?=
 =?utf-8?B?TDZLcGRZbVhoK0lHZ24wR2JDVWlZR3N2cG0wa1dqU0xWU2RZSUR5bjN4dzdu?=
 =?utf-8?B?anBVQmRHdjNJSFNqMGZZcWZwOXEwMXdlTjlIek1xbWQvRzdBR3pDQlpLWkhN?=
 =?utf-8?B?b0FwN1RaTGVxaW5rK1ZJMUE4MTVnb2M4TU4yVEd4TkVLZzhXRFlDUGJKVEk5?=
 =?utf-8?B?Nnljc21wTmg2THlIdm0xbEdKTHpaSkg0WGc2NjNveVdtejlsbS8zakx5eEFu?=
 =?utf-8?B?MWtYTUdNbnAvZ1F5Q3laZGszUWUwK2IyQ0hmcytTVUs1VnJKaTF6UzUxWGFW?=
 =?utf-8?B?dmM1b0tmTVhscE5mTzNkYTZCbTF2ZWh6dlJRc01sbzc4VllvZ0JEOUlCZzdX?=
 =?utf-8?B?MEp3ekQyK1FFSUZxMEF6a1dybkdwZ0VPUjdvRElwN1RwZWE1T0NRSW5yZTFK?=
 =?utf-8?B?RXZTb3FHRFJyUXMzY1RVVzVobDJXNVdrM1dwSVg2NStpRkVKWmpxY0FUWTZv?=
 =?utf-8?B?SG1rd1JmSlVFZURzRVVRd2tabDVZR2hNUUt6NEROMjBQUkF0TWRtYTBkLzVw?=
 =?utf-8?B?RytsbkNQUkthdEl5TzJ4KzR1UlFsb1h3UUNpbWpxWGNsUFdEVWpyaTNSR1lm?=
 =?utf-8?B?MXE3Yzk5OE1JVXhIRndmKzd3L2o4aDFxOTQ1UzVUVDNCM3duMTFkRnNTaHVU?=
 =?utf-8?B?T2RRYnZNUC9yek4rSWUzZS9LL3Bra3BndFF2MEMyd1hpQXhPTCs5eXNVdkhl?=
 =?utf-8?B?WS9XaHlsSTRyVnUyRlBSb1hHbURqb3NHWHJKWHNYSFU2aWdTOXV2UzFSZW9H?=
 =?utf-8?B?d1lpVFQ2YW1MV09Cb2pVTjl1ajkzdnpVaEYvaUxPUFU0bi9aM3BzU3hlZVBk?=
 =?utf-8?B?Tm1DZmhCcEg1ZHFRRnM1OWt3dnJNT0tzeFkvamxnbG53MGFwclRVMHNIQUJ4?=
 =?utf-8?B?NHlaYTc5ZXJIK1BHVFdtbVQvV2dpb1ZUR1U5TitGODVHRnZraWplcHhiNGdu?=
 =?utf-8?B?dkJmdUxWaFQvWWRhbHdIZDl3YnZqRU42THFBS3I2ME16QXpCTjVRamNCV2Jh?=
 =?utf-8?B?cjV4Tmc5YUJOUVhDRXFJSWpmMml5cDNneXh1eEZXc3JNU2RxZ2FWVzZvOFpt?=
 =?utf-8?B?L1F6emFmRzZnWTdKRjFFMzZOZjlzc0liNi9CRG1xTVRucXV0MUZ4OFk1djJt?=
 =?utf-8?B?VXdYS3Y1MmUwZ1RIRGxmL2ZITXN1MTNFOW5FZUIxN3A3d0JlclBwZ3RJT0gz?=
 =?utf-8?B?aUozejJkZlVQcG9UZWk3QVNhcWZ4dm1FeXM2aHluNmRXQzlNNVlWUmI2K0Jx?=
 =?utf-8?B?azNIUklHYWIwaFY1TXkzZnkxZjBlYWd2TUVxdkFVVWRtV2tHNkJuL0lHMno3?=
 =?utf-8?B?Sm1pd2pFVGhkeXFTRFErUFZBK1NZSkQ4S0s2cE5WdEx5V1B6ZGpERlVNRUlp?=
 =?utf-8?Q?TC2ukTCh11Gx3lzcIxbnTQQYM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c528a96-161e-4494-946a-08dd9f106947
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 00:24:59.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcttm8tamGLmP3/fWQi28YwAQ/+7+dBkBXlgketRB8Ljkk0qwAP7Rh2rh18FZaTZA2sfXoIC5mLZVVrLA/mZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com

On 29.05.2025 09:56, Vinicius Costa Gomes wrote:
>Hi,
>
>Yi Sun <yi.sun@intel.com> writes:
>
>> The put_device() call can be asynchronous cleanup via schedule_delayed_work
>> when CONFIG_DEBUG_KOBJECT_RELEASE is set. This results in a use-after-free
>> failure during module unloading if invoking idxd_free() immediately
>> afterward.
>>
>
>I think that adding the relevant part of the log would be helpful. (I am
>looking at either a similar, or this exact problem, so at least to me it
>would be helpful)
>
The issue is easily reproducible: unloading the module with 'modprobe -r idxd'
can trigger the call trace so long as a idxd_free() is called immediately
after the put_device().

I can include the call trace in the next version commit log if it's helpful.

[ 1957.463315] refcount_t: underflow; use-after-free.
[ 1957.463337] WARNING: CPU: 15 PID: 4428 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
... ...
[ 1957.463424] RIP: 0010:refcount_warn_saturate+0xbe/0x110
... ...
[ 1957.463445] Call Trace:
[ 1957.463450]  <TASK>
[ 1957.463458]  idxd_remove+0xe4/0x120 [idxd]
[ 1957.463497]  pci_device_remove+0x3f/0xb0
[ 1957.463505]  device_release_driver_internal+0x197/0x200
[ 1957.463513]  driver_detach+0x48/0x90
[ 1957.463515]  bus_remove_driver+0x74/0xf0
[ 1957.463521]  pci_unregister_driver+0x2e/0xb0
[ 1957.463524]  idxd_exit_module+0x34/0x7a0 [idxd]
[ 1957.463529]  __do_sys_delete_module.constprop.0+0x183/0x280
[ 1957.463536]  ? syscall_trace_enter+0x163/0x1c0
[ 1957.463540]  do_syscall_64+0x54/0xd70
[ 1957.463549]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1957.463555] RIP: 0033:0x7fb52b10ee2b

>> Removes the improper call idxd_free() to prevent potential memory
>> corruption.
>
>Thinking if it would be worth a Fixes: tag.
>
Yes, sure. Will add Fixes: tag next version.

Thanks
    --Sun, Yi

