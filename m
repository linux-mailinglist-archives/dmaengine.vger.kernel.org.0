Return-Path: <dmaengine+bounces-5650-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE2AEAF05
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 08:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130A24A1388
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 06:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D73202C26;
	Fri, 27 Jun 2025 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjuypvbU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFA2F3E;
	Fri, 27 Jun 2025 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005834; cv=fail; b=fYXjHIu7i8PXhcKzUIeZbKq061ajLLdhO/qa2juiNRuZ4Y6DZPEb6YTYUlBefSzBe+g+rJwbxh1hSkrZ7MOuRPkfatBkfbRh7uGF3fki0lVO9lhDJ14GBlHLjXjfL441qEmdEDSGPoolyKbrtidZZuj3ZfsOw1eZ4Ef23Ynh8UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005834; c=relaxed/simple;
	bh=lfmOCQmpWjSR5q/SzivYcB/gzfiIR1bnXSlo9Cq6bbs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fh2x/uruVr0gOPATcI+vwfwgwPK5rnX0Sik8KaQA88TU+O3yCoYPH19KSpHuwlvISohRrzduwi8CiPBHqsyiFd3h65wds2MxcvfOTkFNDkrEiXLxOviAnwZcYm9Jt45KmAq9thzO6DLnSruARV2/2Fno7bpF1SsqEj1NxkJUKuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjuypvbU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751005832; x=1782541832;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lfmOCQmpWjSR5q/SzivYcB/gzfiIR1bnXSlo9Cq6bbs=;
  b=YjuypvbUEhtM5k0ww2LIUFiCrOIZEFIcqbkhdE0OyCoWG6+Tk+lGKCzX
   kUwInLens6OMeGzAM+6KW/AtAD473fGedv4m7WSW8+Am8f+fOKb0/TJHA
   YuXFv9XlbY3vaEDKurPu2zaF8ew3Z0TSR0GpRjG7UR20jxB37ti3i96rM
   TO/isB2H4Pu7+87+hO7iBVs0I1lxvQA+sDeFnT2rDN94XC6R3+YeyJSCL
   riMffDz0bHCFVREJ93po1YJRowqdgXW9VUqDqA0UVo+r5OIsbpLlRxbch
   QRTcZUqCGKlAzeS+g5PCWCS9wy5BF8JFTPdjxTQX55zB6p9t+0tpmrnId
   w==;
X-CSE-ConnectionGUID: 1SfPMrEfT5yPqzw6NXuywg==
X-CSE-MsgGUID: mtTstkQCQdajDUIlGOQ8lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="40930697"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="40930697"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 23:30:29 -0700
X-CSE-ConnectionGUID: ze9kIVLhQ6ClbIZaPisTnA==
X-CSE-MsgGUID: 1o1mKZomRJisLi6A8V4TUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="153435507"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 23:30:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 23:30:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 23:30:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 23:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbFc8RVwy21aNWid/4qmVwE0vi5iJ46KmFO9qqd+yVW6QSxJsiXZre71t2LMEMBCqmYUju/qtMrhvLLoKJvfJTU7MADT18qtp8FKaq2TwPdw+k5Tlp9KlrIQpirulV6PG0aS7W6jO26HW1zPVg9CGg7xr5psF3EYRk0vsNTRcLad9QsCoqawo8+K2iBE5wkQyGDQUyH8mAjSRU1vOphha4IghNvdPaMcHkWCFDv1gwMEtyqcdZCLQUi81qKJulUGLHn8HOteGCV0B0lYbxiPKLnLxkOLhd0qUV9lUxLRaqb1XkNRXXWd1tKa4oQQ9c24RFSnIiv2uQTRbSLJunN26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N94+9fpmfs2abJCnjDxG4S61ys618aCn5pQni7gs7/g=;
 b=HgrcGnaWa1higP00HuZS1ogdAP+M3BOggbz3tp0jSS0wHML0dFBByXq7SPVow2vcWGObk0CHdjCUWPowF0rLNqJ1qJJ2Dg50y5QkAGItXWepitrczJQwzUsev4LNkcghGo0l5AKm7G/p5dEPdTcPTlNWKq0Kj2Ax5rvT6L43KSeBsM86EVsOzusAM9gy9Fdr/qfNrRgbDX23DyfJ3FKZWBlKzdZL8OjAYpNhkffvo+x1UVLTQnBJayTXRAbbULJhktX2RCirjl5kguAhliSEE71w3pGNC/Z1+izrTBZWN9LrajENzh1F53bO/E848wb3jLT2On2ojiQaEPOrnuRClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 06:30:20 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 06:30:20 +0000
Date: Fri, 27 Jun 2025 14:30:09 +0800
From: Yi Sun <yi.sun@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gordon.jin@intel.com>, <yi.sun@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Remove __packed from structures
Message-ID: <aF46cRgzYE4N3A25@ysun46-mobl.ccr.corp.intel.com>
References: <20250404053614.3096769-1-yi.sun@intel.com>
 <175097809157.79884.15067500318866840512.b4-ty@kernel.org>
 <aF4YdFZnAWcZlpbW@surfacebook.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <aF4YdFZnAWcZlpbW@surfacebook.localdomain>
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|MN2PR11MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e09ab7-aa63-4fbc-6003-08ddb54416bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGw0bjQyZ0YwdUdjbytvakRIV1AreldBSmJlbjRRa0N1ZGdRamFlYzFvaGZ2?=
 =?utf-8?B?Mm5rbS93SktJSDBnN0RodXVwTThuN3RXbmdGZDZCMDQ0WjJNQzRxVDdGRHBt?=
 =?utf-8?B?L0huOWJadnlJTnY0WUxMRThSSElCcnZ0WkdhZU8xZTh5TmZpNTNtcEVFS1Rm?=
 =?utf-8?B?Y0todVpKZlJCVk5wZk1DZThxUFJzVUFuNFZ5a2dvTWEwek1Lb2JtZkxvVVFO?=
 =?utf-8?B?cktFZ1NoSER0U2pEdm9RMWRDWHNUL3JtYm1lRU1iOTA1NVl5Z0VFVldmM3Vl?=
 =?utf-8?B?d3BveDRKTE96amNNK2pWS1h5b0REZ3ltVXNMM3RRTS9hQWtiTW1DblJIUjBi?=
 =?utf-8?B?a2V4V0N4aTRzYjlnQmZ2Q0tldDM3a3VIZzlSMWFxV3BlVkFFK2VjL1hkbHpX?=
 =?utf-8?B?SEJtUTVCamxwUVNSVStCUGRqQmN2L3E5YnRMOW1IMUp2S0VWb3o4aUJTcHBn?=
 =?utf-8?B?aFYrazFGL2JIQitYdGt3VExGWkpHS20ySTNxbUdibDdBRDhNK0RoKzFBS3NW?=
 =?utf-8?B?dVRkdVZGR2hKR2lIdEk0MU44K2ZXZFhCYk10RkJDTGVaTXo3cGh4RG5KdUpq?=
 =?utf-8?B?UUlSYmUzdFh1TW56aHpVRWRmSCtZTUtYbTdyK1h3d2VzbVN0cnd1RU5iWngx?=
 =?utf-8?B?TDdubm1ydFZFWlBVZ3JzbnZnZVhpRytabkRjbjIybjdaU1hrcUJ1dUNFR1BF?=
 =?utf-8?B?R3EveWVweUptTFBraitJTVBjYUlvQUJkajE3SHNhbWZvK1VZWnpScHduaXBs?=
 =?utf-8?B?V0VoWllmREFoNStwYUVKeTdVMTRJQ1k2djlnbVlGUkJYRWJuYXQ4QXg3aTIv?=
 =?utf-8?B?bGNBTGgzTzE4bVNNYVVuZUpHMnIrZmtiY1dEa1pOK3NJUU0rdG9wRGc1WXZu?=
 =?utf-8?B?Z3p6V3FVZGJkOGRGdWRldDdOdjh5NDlnaG84WmZ4dnkxSHFBMGRidHF3b2hO?=
 =?utf-8?B?d0lXWUllSWY0MmYzdWlsSmJzaW4zWWptbmNqWXQ4dmd5VnZib1RQT01XOFYr?=
 =?utf-8?B?bEV1RVpMWmQ2cGYrU2VVNm5IN3lPK0ZZbVg0cS9CWlQzc3IxWkFka1EzZmU2?=
 =?utf-8?B?UXJVNXYxWXFyYlhaejVFWk5vUDFpb2pNbENXcnpHSmpxYk5zYm95V1h3S1FF?=
 =?utf-8?B?N0g3SXBuTDBYQ3lBZVc2Sy9TcEI4RFJWalRKUFgxOHRwWGFVZmthcTNabDBz?=
 =?utf-8?B?a0hkeGJyOTZ2N21mbnlXYXFad0Q1R0puNjNpTnpWdEZPZXpMeXZFMXozdlkv?=
 =?utf-8?B?R2hma1B3OHdHV0pMV2tLenZpdXVPcmRTM1RmWExobDA4eGl6U1MvSTJ6aUEz?=
 =?utf-8?B?dUF0dnJtUytYYUxGejV5bStSOHNzcStvK2l0OE4xdkdIMVJWbkQxdXJUdi9H?=
 =?utf-8?B?Rkk4WCsrYU41OVp1WmRjUXZIb3dzdUpDbktad3dKRVJ1V0xJQUU3Wkh5TnR0?=
 =?utf-8?B?NmI4UDdxZDN1bkZFaVBvMXJKdjFESzNoWUZRSEszaDRyeEp4M1QrYjc0ZC81?=
 =?utf-8?B?ZmpEZXVqWUp2TmloWGoxV0QyRjUyMzN4SEtDUWdGOVpSa3ltbGlyNFlqdFdZ?=
 =?utf-8?B?M1JGUlRmWUZQZHYzQ3RhNVJNWUVLSGQ0RmhuV1hNcjF3elRSMlRlWFJBOVF4?=
 =?utf-8?B?eGRmdFBTV1hKL1FHd0x5cEtUWVZxeXVZOEd6dk1zeDg1VmVvY085c1J1QURK?=
 =?utf-8?B?a1NoLzlLZXJRM25aWnFKenQwUmg2dnRmSG5DVU9LOVAyZUhFNW5JeXZBVGxQ?=
 =?utf-8?B?eXp0NllwNlZieWp6M1BaUlJzVjdOYVB6WEVkTm1nbjNHZVNZVmhoTHFOejVO?=
 =?utf-8?B?ekpnN0xIU2VVNXEwZ2VJZGJJZ3pMSXIwYW1UaHdFeWpuTlh3ZHU1WEVDTThH?=
 =?utf-8?B?Z3ZMeUV6YytuQ1lpbTM4YUVmMDhLeld3RTJyK2lvYkpQQXhMRXlSUkhHS1lp?=
 =?utf-8?Q?Ed+H6KcMpeY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk41YkxycWJvYzc1dTFUdUlYNENpZko3QUhzRitvTklNQTlEenlPNHQxWGJH?=
 =?utf-8?B?QnU3a0dIK1lZTDUzWURrcWVnNExaN2F6NGlINWNDYXJMY3Q2SDQyY0dqTE9i?=
 =?utf-8?B?ZC9FNG9XeTIzL2p1U2hqYVpkMzV4bFo2N2lGNUgwdytrQlk3WHpKekRLZTkv?=
 =?utf-8?B?UHNLM2Zkamx2dUZMMW1nenkvMnc4eXBrMUVWNGdaT25PL0JtM3J1WXBZeEht?=
 =?utf-8?B?K040TXJ0UUxod1BndTVwVTM2d3JRL1VzR2hZNHpJWlN5MjBmUDNHYUY1bzRM?=
 =?utf-8?B?YjZxOXBKUGVNbnlPb0VMYlVDckFWQ3hpZTYzRkRXS28vdU9XTDZwT1A4NHVr?=
 =?utf-8?B?TlF4VnhVajQ4Q2hieVpVeTdFeWJBS25FVFNXNjdHM1dYc0l1UTJ2cXBaaDBZ?=
 =?utf-8?B?R0pHYjR6RUh3SnhtM0lkWnliZFJyQXVPR09sc29MVFB3bmUrazA4alFGMS9p?=
 =?utf-8?B?Mkh3MmZqWi9BbmNZM1dJbWVIY2hXR1FmMmFUMlJQYlZnK2lrdStGcm5US040?=
 =?utf-8?B?ZUs2OEcyVXJzRUxQMS9NamNFeHo1bVVmVVlFNFRXQ1RpajZSWklENlF5MTh0?=
 =?utf-8?B?Vi9hT3B1dHlXSXdndmprS1dXNGZndWlvTDJDdXRRV0RnSCtvK0ZGS2FUYkwz?=
 =?utf-8?B?TzJRSHdHMDhSMDl1d0dyMkFpYlpVUFU0MHJ1VlQxMHhBdlBFczRZejlJb1J3?=
 =?utf-8?B?WmdiR1JRcFk4ZnQ4cTdERnhPaXBWNXZoQzhVSURyWDBJalppTWZZb0VZMmho?=
 =?utf-8?B?d1BOa3RobVVlTWVYd3RFd1dqczA5OFRIbFBwaWpQdyt3ZFU3OElVQk5wazND?=
 =?utf-8?B?OEdNMTZ0WHVNa1hlVE1lQXg5VHJ2Q3R5dnMxUmVmYXNUZnU0WVhrREcxdnZW?=
 =?utf-8?B?NWMwa3AyVmxjY3F6UkNwVHVyUzBpSUpkN3JjS1YxdVdPK2VmMGRJL1M0UXR5?=
 =?utf-8?B?MlZHWU1UZGcrODVCVkQzbXFmMHRGczltdXlWR2F6bC93Q1hHVjlEUDh4dXVP?=
 =?utf-8?B?QVpDNC9iNlN5L0tpVG5QOGVMWXNsd1FHZ0FUcjF5aERobm92U1BFYUVzSzlj?=
 =?utf-8?B?emlibUFvbDhHemNFNm5QNnNZaEd6SWdORWdCNjRRaFRRdFpXVDI5WVExRnhl?=
 =?utf-8?B?UmpBVnl5UUJqUHAvbnhzV1dreGhZNDBiUXBPL3pNSTBGSE8wWkZzODFkaU40?=
 =?utf-8?B?TEoxOWlwZytwaERkVTBMdy9Md215TlZqcUFGekRFczdUVDd1SjJXUXA5ZWQx?=
 =?utf-8?B?a0tlbXAxYmd3ajBDL1NQRTRRZ0M5NUlZRjBjNjFwT2E4UWdTYzc1M0xxREd4?=
 =?utf-8?B?cUtmejlZblU0ak5KdlFpOGpSRTljWVpXWmdvV3ZLT3dXNXFITU43dm1Ybzd1?=
 =?utf-8?B?eDBXeHVacEhGR0VoVVE2S3BEbTZoNHNHYmhINUZEYkVsOHRoZWpqb1FOYUIv?=
 =?utf-8?B?ZnYxeTZFamREVG9zTEs3NWdscGJRVkQ4UENyWmV2UFJHdHFqREg5aGJXSzM2?=
 =?utf-8?B?SzNxSEtFNEc0aGZiSEtwamNXWExiOFJTeEZOSmZRL1ZuUWcyeU5BaFU0a2x0?=
 =?utf-8?B?cXhGUzJkbUdLVk01c0ViWHlJWERSWVUrRkVqWXJRVTBUUmRob24xMlpTSFU5?=
 =?utf-8?B?WVdiSDdMMkRaN3lGTnBHWGczdUFTVitkK3lIUXNiQVV4MGFMQVZTU3hLTzVx?=
 =?utf-8?B?YnkybUt4SkV0L1h6QXNjbXFWRDh6Yzhiei9hZ2lGd2YvaW1wUS9nV1JNNjFR?=
 =?utf-8?B?ZDA2Z1VTMUM0THZkcjJJdXR0akpTeVZva3pZNEEzcHRreVd2Zi9yV3VMaHYy?=
 =?utf-8?B?b3Y4ZWJvQXgwWmFOWFB6V051SEVESFNlNnpHMVg0TTlKa3FMaGFsNjkxVWxx?=
 =?utf-8?B?M3ZEN2tmQkNFMGJYY2xPWDhraUM1TGY3NDBvZStYUVVwNFRYZTROUmVQSWRv?=
 =?utf-8?B?U3NHSk5RQ1N2bkJ5MkZkdGEyZXRqQ1VyZWhwRTFkYlBUWjFkV0ZNMmFTVDlh?=
 =?utf-8?B?aXRVb3Q4Z1BscDhNQ3pZZXZvQVZ0akdjTjdrSU95V2hnN29nOXdXSEZXVGh3?=
 =?utf-8?B?WmN6dWxlTGlubkQ5RlZRbTBSbVFIK0hoZ1p1aUhXOTZnNUFMcDdIL0RINHFq?=
 =?utf-8?Q?WlecFPTftuXkxu87KEuTUi8fL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e09ab7-aa63-4fbc-6003-08ddb54416bb
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 06:30:20.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbMv5dfAZjd5jb3q9V3LwhbJzYkVvpIdD9iTILE2g2bGMboGGMnrSR2GEZI7bwT4cMCG7UtUdhK9ibdbMdO3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com

On 27.06.2025 07:05, Andy Shevchenko wrote:
>Thu, Jun 26, 2025 at 03:48:11PM -0700, Vinod Koul kirjoitti:
>>
>> On Fri, 04 Apr 2025 13:36:14 +0800, Yi Sun wrote:
>> > The __packed attribute introduces potential unaligned memory accesses
>> > and endianness portability issues. Instead of relying on compiler-specific
>> > packing, it's much better to explicitly fill structure gaps using padding
>> > fields, ensuring natural alignment.
>> >
>> > Since all previously __packed structures already enforce proper alignment
>> > through manual padding, the __packed qualifiers are unnecessary and can be
>> > safely removed.
>
>[...]
>
>> Applied, thanks!
>
>Please, don't or fix it ASAP. This patch is broken in the formal things,
>i.e. changelog entry must not disrupt SoB chain. I'm not sure if Stephen's
>scripts will catch this up on Linux Next integration, though.
>
>-- 
>With Best Regards,
>Andy Shevchenko
>
>

Hi Andy

 From what I understand, changelog comments are ignored by git am and do not
interfere with the SoB chain. They appear after the "---" separator and
aren't part of the actual commit message. So it should be safe and won't
break anything during the integration.

Let me know if there's something I might have missed.

Thanks
    --Sun, Yi

