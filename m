Return-Path: <dmaengine+bounces-5867-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ED7B12EC2
	for <lists+dmaengine@lfdr.de>; Sun, 27 Jul 2025 11:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C263B4C7C
	for <lists+dmaengine@lfdr.de>; Sun, 27 Jul 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6491F03EF;
	Sun, 27 Jul 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnBnFcvT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF51A254E;
	Sun, 27 Jul 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753606938; cv=fail; b=hZbiLh5zv2GjL2ttxjOHA5FyjmDakjwP9XP/SDSmUA3xLiSPa3vXnSWVG83fuLZAL2yMlSqsV9RvarkvSbCF0EKq47PrBkW8ola7Q+DodD/PkGzcDsLNADJMOxApFDv4oQNR5HHrfj/76tE4s+D6DQDGB/53E+XE+dgdLUZ39tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753606938; c=relaxed/simple;
	bh=NaJfgkN8Rb9mEIYXzfLo9tE+llyeF4gKbXL2DKLiwDk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sdskhHRwCk9ePxLs/rN5nQz7yFJuiKHgAcjk+GYy8H1+D0zYAxo9WCF+UoZQQ5fdTCL3plN+3zNWkLddzAI6gEAxfC1ivZqil0fHdEnypqLNyp2zJDajr53umFBU2QXNcRUGo6/c2ZL6DIk45tZsioDi+y5q6WUhF1lNgKfDgg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnBnFcvT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753606936; x=1785142936;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NaJfgkN8Rb9mEIYXzfLo9tE+llyeF4gKbXL2DKLiwDk=;
  b=nnBnFcvTZG+SZjayxdE7JjSL5R5qF54UQtVeD5ru9RY9JR1Jn8/UB05X
   GdNOW9ihEJCqkJpUE+M4LDlVKErAZrSimD0erUZc9qzJ3eGS+TrErM6Qf
   gw6sxGeykWKn0DRBUUDVyMPtd5IThXTQleSt0tNaHChMgcvnaCVuAm6xg
   hC81qiJz/pllfWoZWrblxsNNPwjnxMD5IvvrOvBBsO2QlK7cMbUEWYPtx
   4T8+YUi0cSVDxB6IPbWrqDwpTfzbYaLCE7359ff/peFSL0+k9ch0xZtVZ
   QhyAiIEOBNs+jEOy+T4b9M42cGUqFwyKK+RaHUHiA7xrVUPKyH13RonMU
   g==;
X-CSE-ConnectionGUID: rZXmjzWgRRGnl4aoXK7Gqg==
X-CSE-MsgGUID: Ki5lMZYzRiS1F052F8zHzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55579683"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55579683"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 02:02:15 -0700
X-CSE-ConnectionGUID: +7zAui2UQKiu8GcT4lWcPg==
X-CSE-MsgGUID: 7L6k06IyRJ+mmwQBD0qQXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162831940"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 02:02:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 02:02:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 27 Jul 2025 02:02:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 02:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvE6E6ZCwRsYGDb2vwDhslRdBGiSb3Y0w7wJeOi5I0VYzhuI0EA0MchgtYhpPhXoeI0k2EK0EfJ8zZtK7xjFvr0i3rMB8AxU8z690mF0AjhDY+yFxA/1ceI3X3FhP6hoshOQkoDs63TPsyHuZwsD2zJ35+PTt5fAcLC22HAsYeTUiPXihbRMUwe/Jv6Y1YRhDa6XRiSCK2C8jN3A9lsuVoaRFoUNyng/ObK0obrNnBxihwdm72Msfs/59mFQXlcAFn7LsTrJUJObLQgwQ2uYNOSjEx0Ghk1vN6FQIupaTAYxcpIuQXQckGplVdoddrHjaDKQIgEvyB9Qc7ykGB0Osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nnlen3dOvlT44Ei5QmwIHh3lvXnZvOy2qZa80w+Wd0g=;
 b=JQZEeCJpgE1W4OqZC0rJElLy13Ugyqugzhu2rAHq+NQM8wKGbZdOtrXZWYAYccPtSBTFrzjK4+tITbTwpso++VczM/iFPiTfPkbPpSMPpW8keR/k+yv1vesRPerSljFU+G4H2E6haUIFMSUG9/P59qGyf/4RrnDf8fC4xJkGajKPMSFkmA3Td+XkdK6JXnxhP9cY0rWUBQrfIUrisRZqbf8EuGg791vFyRCeB8h24gu9cm5jBANE1Ff+QZtyxRF18jT/NBNKC/qd0UawJ6xNMk97m3Rq6T3qUS8YfImR4jQ3J3jvFSYUux94ZkF0QPy+9yqgHnv7XFHh59kY316RZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by BL4PR11MB8799.namprd11.prod.outlook.com (2603:10b6:208:5aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Sun, 27 Jul
 2025 09:02:12 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 09:02:11 +0000
Date: Sun, 27 Jul 2025 17:02:00 +0800
From: Yi Sun <yi.sun@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>
CC: <vinicius.gomes@intel.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dave.jiang@intel.com>,
	<gordon.jin@intel.com>
Subject: Re: [PATCH v3 1/2] dmaengine: idxd: Remove improper idxd_free
Message-ID: <aIXrCM10dxz0LxRb@ysun46-mobl.ccr.corp.intel.com>
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-2-yi.sun@intel.com>
 <d4b51d33-e46b-448d-b6d3-f0845b1d05f8@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <d4b51d33-e46b-448d-b6d3-f0845b1d05f8@nvidia.com>
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|BL4PR11MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 96aa353a-36fd-4d35-f31a-08ddccec45b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmliejZXc0NuUHgrRXJLV1pjUk5CbDRocEZIUEx6b1h5VjJyUVBJZnNGM1Bm?=
 =?utf-8?B?dGFZUmNMMmJ3T0MrNEM0akVqc2NvbDh6czZFUU1SNUtRYml4L0hpa3hYK0dR?=
 =?utf-8?B?a3c2eFBNalRvUFdPc2swbVQvUHdBR0gwTGhRa0pRaU1XaWlYdzdQcjFZblNE?=
 =?utf-8?B?TEk4aFkvaHRJTHhVUmd6Q0ViM01VU0RqNXY4M05hK1c3L1dteUZtSXFBcmNi?=
 =?utf-8?B?eXNWS08zc1BkNDJkNXZxVHFpR2pQNytyRFhUM0VTN0NRM2c1eVhaQUxvOTQ5?=
 =?utf-8?B?eElTWjBCNVAwM3FzcHdwU3paY3F4T0JtSjFUUEw5R21pa2dqT21iMGsycGJB?=
 =?utf-8?B?SXpZNjQxa252RGYvT0dLNVVNdmxmSTBBSjVCajJURHBTclVjSDQwSDdxOXJy?=
 =?utf-8?B?UHZCMFVMWjRNY0NyTUFFRzZrL1IxZ3FES1BQRDZRbW1qd0g1ZTAzY0N3UnF3?=
 =?utf-8?B?Q3ArcG84ZXFnR0RqUkR3SkluLzZmbFNOOEFlcnpUTUE1WTR5aUUzc01EWGpP?=
 =?utf-8?B?R0t0NmRSWEVrQVRQb0RRVGczc1QwMlZvSExnak80d3NyTzZCQk1hTVdac0kw?=
 =?utf-8?B?NXFGaE45QWdZcXF0NWF1R2puL3FoZUZOUGd2bFBqVXc0K3dLTEloMlEzMTlV?=
 =?utf-8?B?OEtCQXorNk1WOVRqVjQrMHlDWHdsT3JxUGprbWV6Q2daRENCVjcyT2J6MjNX?=
 =?utf-8?B?Wk12akZZQnQvYlpjMXBwQ2xCendubVNZbDRkb2NjY3labnM1bG1Gd3hNcmpr?=
 =?utf-8?B?STNuSVhvWnhLSGxCSVNOQlVJOW9qQ3lHWEpnMkNGWHpJNWllTExjSlZiNk5m?=
 =?utf-8?B?VUFUeVh0N3dEYTQzY0V0SjY1Z1FlZERBakFZOGQrYXdqMHF4bm40TEdjSmJr?=
 =?utf-8?B?UHVxSWRuYXdqWXVURkp2RTJINGpPcGlzOWlINVVneXdDdzkvdHhia0NkSWlt?=
 =?utf-8?B?R3owUm1tREdITkJ0Wm55OVFOSVBXS2xQSHNIMDlrTnRORldJL3FlT3krN2cx?=
 =?utf-8?B?VWRLdVN6YkR1UUFIZ2hXTGRGWU0rYjJEZzFkWVF0RzZxcmZrdVExR3k3ZXhZ?=
 =?utf-8?B?UWZqcUxCSVdOa0RoczZZZUFTak41T0F6eW5SQkFXLy9OdzJ4Sm41NStueEg2?=
 =?utf-8?B?bHg5b00xMEZ3d2tqMkhHbFFkVytQWVFGTis5bzRDblFLY1ViT3lUdjVCTHhv?=
 =?utf-8?B?QmlqeUMzWXJ6ZU80anBvTExFbUFGT0cvaERnNTFIbkVEZFo3Mkh2aDh5TmQv?=
 =?utf-8?B?UW40MjIrNG1sWnZRS1Y1TkxzZlJYTkg1SXNjbTNya21DVmxUQ2dFdmNGWkRo?=
 =?utf-8?B?TDA1d01aWWg3ZE1rTldvVE5vWms5TU1wUkhiYitSeUFKNjRzdHE3RkkrTit3?=
 =?utf-8?B?ZzR5RmUvdmtkWERhR2MwT0s1MGF2cGJIcWhrZll6VHhwcng5b05QUmFtSkpi?=
 =?utf-8?B?ZVNGS0prZVNyR1Zwbkg0bDdzQ0FoYXRIaDh6UUVoc0VybnIyekIzV2p4ZkhX?=
 =?utf-8?B?cWxxK3pUdU1oNVhEQkloT0lwelQrcXNDTzE5b1djLzhsWW44KzFTL3crS1hr?=
 =?utf-8?B?aVpQNXFWUmRGWHB4ZWZvcEJNbnpCY002d3dHQTdQUEYrTWdvbGUrSzlSS0Rx?=
 =?utf-8?B?bzdQOFhTK05mdUVEdm5wcjA5VG1nWUQxczM0VXhxYlJPZlBnRUVROWc3Tjd6?=
 =?utf-8?B?cWFnSDgwdUxPNkNHdTFZK3dIMmdaY1UzNDc1RXllR0VsOXZ1b0JKa28vNnd5?=
 =?utf-8?B?VTR5MHNnR1B5Y1RIK1JFbXNrWGN2ckVtb0tPeEZoOG9qZ2xpTzFTOEZhcVkx?=
 =?utf-8?B?R21ZbkJXbzdpTjMvcVZ6dkZIdWVma1NaS3VuRWdIdkY4K3B1akgwWlM3R2JE?=
 =?utf-8?B?Zi9zeC9VWWl4NUJsUVRZaTNtRFVicnhwN3pmT2wwcjUwcExlM3RFVURvVHYr?=
 =?utf-8?Q?rjEwHRZFCoA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzgrMHdOYkNQTmtpRGt2T0ErUm1iQVRXSS9IMS9qMGM3TnM2SEFyRURDVDF3?=
 =?utf-8?B?WUJ6UHdLdjY3bFhVRFd6VGFpVFNwRGlTWUdCQlhLZUJ3M1lOclZlWHhXZitQ?=
 =?utf-8?B?TzN3c2FFMGhsQitDZ3piRnk0dlByNWNnL0RWS2lUbzc1dDZGdE9aWWRvOVFl?=
 =?utf-8?B?eHY0ckd0L2hTVW4zNHpUVzNmMlJBR1RTZXVhamlSU3MyVlRBVDJCS2pjZGY2?=
 =?utf-8?B?d3ZjVDlSVFpjNUozNzAyNk9oZjFTRjVVSlEvQ3NrSDc3R0F2b0pubHVYY0k4?=
 =?utf-8?B?b0loM001cmRUbDlGcjlURktxdjBBNU9TeDZBUnpuQmJIMVVyblJKMStOZWRY?=
 =?utf-8?B?cnpOV2grYklvM2VnN0ZJVE5xbC9CdE9RQUxMRExrMytGZ2ZKbXNsaDVEM2VO?=
 =?utf-8?B?WDhtRlgzbW1yeEVhSDVJWlhlWE5xMFBlUHV1Z1JLcENUV21pREY5dU52RW9J?=
 =?utf-8?B?Rnd4OUswc1c0dUoxdUxObTduT3N1M1ZKWGp4Y0dPQlZtSWlHTDRpUUQ2Q1g3?=
 =?utf-8?B?VkFLZm12Wlp4ZmVqWDNoZC8yMTh3bERhZ2t1Z1NCQkI5SzVoeHplVmhZaG1n?=
 =?utf-8?B?MUNwOU9LQ013MnNpTjltMzBNS1B5Z2xhZDhnWFZWTmtSTnZHOGN6MzdubWFJ?=
 =?utf-8?B?aTdHSHhoaXdhZUI0c1Y1b0xTaitSZUZXeWhsOS9KVll3QUJHTTNHWldFY3ZC?=
 =?utf-8?B?cU8rNCtvemNRd2lDS2d2S1NQYU5LS0JVL05PeUhlSmh5VFp3Q3NZZ3RZUTE0?=
 =?utf-8?B?TXc0V1FrNFV0K1JlQ1FleXdJbGVKMDZ5ajB3ODZCQ09FczFvc25qNkl6MWJp?=
 =?utf-8?B?K28vMDA5WndROHdIajVtZDVIbVYyMmg4bkRhajcyS3ZOMENITCs2Ty9RK0ll?=
 =?utf-8?B?TG4zYUxnQUd5OHlTbFZWZlFRRVZvWTY4OGh6YXRzSjFvWkRPNXhYTW1QbWQ1?=
 =?utf-8?B?OHlnRlZrUUw3NjdieEtpUzdDRi9OakVDVm9qbFY1TWd2ekdUaTFJdDVmSGJQ?=
 =?utf-8?B?RWtHZ0pqNmI2R1B6MWNEL1dOdzY3SGdvU0hTM3FoQWorVXlIMlRjdVRySUNh?=
 =?utf-8?B?WnI4OVVuVk5pOFhpQXJESUNqczk3SFlod0M2Vys3dEZuckdMV205TytBREVB?=
 =?utf-8?B?ODQ2RHBHeEpZQ3dmQWxNWFpHdnFHL3BKVVpPOGFhYzB5U3dQMnNjOHMzbFBU?=
 =?utf-8?B?bitaSkF1Qmw2WjRYVG0rK1dkblhNVXpRSnFuTUxISm5vc2VVTlU0ZDBLbTg0?=
 =?utf-8?B?dzlpOUpvTkV4K2VnMW9PQWJOeWtpNStuOW1KUkhrZmlsTUt3ejNSbm5CQVZh?=
 =?utf-8?B?RFY1dmhPL3BGOGkyN0JiWTdjeE5EbHcvbzlYa2tEUEFTalpIRE5hRmNTbkpH?=
 =?utf-8?B?RE00VWtJR0QvM0NwOTJIMjhGSXRxblBCVGh6d1M1NnpzR1BKWVhnWVVYdy9z?=
 =?utf-8?B?Vm4zZzFsN0tzZml3bHVYNTFEMzU1ZnRzQUpNYWxZazMrM3JHblFvZEZiZTgw?=
 =?utf-8?B?VndzTjc4bWxkTUpYd2NObitFSHdoZjZnM1dRcHIzcmpHaEFyVTJKSVFrVHdN?=
 =?utf-8?B?T1lHQUh3WGlqVlZFTy9YSm1PSXljeDJHZjF5REUwQTEvd0dSbFFsTis5RlZQ?=
 =?utf-8?B?RWY2WEVFbE1YZUx2dVhYbkdLSlkzRko3cWt0UGJCdEJjTDJMMFJCc3FNeEZk?=
 =?utf-8?B?aFlQQ3h5NktmQml3S3d2b0dHbFE5NkEyLzd3ZXpCTmpneWQySnpsbTVLd0ox?=
 =?utf-8?B?SGVXY0UyR1FBQktocE4yc29Vb082RDdDWXNDTzdMSUl5UEhuNzFQQzNNbFhJ?=
 =?utf-8?B?M3hDQUp5ZUoybGI1cEVvOU1pcEtUL3BYcXA5c2FscnJkYXVNNGcxeEkyRWtK?=
 =?utf-8?B?SlE0OHUyZEhBUnBrL2xiaFpGcGNJQS8vUEhaN29IR3h4c3o2ejR1VHBycjIy?=
 =?utf-8?B?V2l2VlM2Z0toNm5WWnhRZGRRTmhHd3FycXlURzFNTlMxNlJoNzRWdkxKcWQy?=
 =?utf-8?B?OXBFMkdJVXAyYXRjYmkyRmhJNWZiREYxVVExL1VNZFNxeG9ydXR5ZXFWU0R6?=
 =?utf-8?B?VVNtODVzODl0elRiVEY5WXR4ZHFoZ01nZWF1ZGU2OXFxYWZFZWlhUVdkeUht?=
 =?utf-8?Q?sTnWOON0GecqoxGSiCe/pX3QN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aa353a-36fd-4d35-f31a-08ddccec45b0
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 09:02:11.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpQbk5p27HysKUvhWS4tYewObg1cAJa2FCSMi/DgHa/APeRy8pZhZ+Ou3mPffjk3Bju6DFp0mkk23izwSEjAoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8799
X-OriginatorOrg: intel.com

On 17.06.2025 15:13, Fenghua Yu wrote:
>Hi, Yi,
>
>On 6/17/25 03:27, Yi Sun wrote:
>>The call to idxd_free() introduces a duplicate put_device() leading to a
>>reference count underflow:
>>refcount_t: underflow; use-after-free.
>>WARNING: CPU: 15 PID: 4428 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
>>...
>>Call Trace:
>>  <TASK>
>>   idxd_remove+0xe4/0x120 [idxd]
>>   pci_device_remove+0x3f/0xb0
>>   device_release_driver_internal+0x197/0x200
>>   driver_detach+0x48/0x90
>>   bus_remove_driver+0x74/0xf0
>>   pci_unregister_driver+0x2e/0xb0
>>   idxd_exit_module+0x34/0x7a0 [idxd]
>>   __do_sys_delete_module.constprop.0+0x183/0x280
>>   do_syscall_64+0x54/0xd70
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>The idxd_unregister_devices() which is invoked at the very beginning of
>>idxd_remove(), already takes care of the necessary put_device() through the
>>following call path:
>>idxd_unregister_devices() -> device_unregister() -> put_device()
>>
>>In addition, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled, put_device() may
>>trigger asynchronous cleanup via schedule_delayed_work(). If idxd_free() is
>>called immediately after, it can result in a use-after-free.
>>
>>Remove the improper idxd_free() to avoid both the refcount underflow and
>>potential memory corruption during module unload.
>>
>>Fixes: d5449ff1b04d ("dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call")
>>Signed-off-by: Yi Sun <yi.sun@intel.com>
>>
>>diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>index 80355d03004d..40cc9c070081 100644
>>--- a/drivers/dma/idxd/init.c
>>+++ b/drivers/dma/idxd/init.c
>>@@ -1295,7 +1295,6 @@ static void idxd_remove(struct pci_dev *pdev)
>>  	idxd_cleanup(idxd);
>>  	pci_iounmap(pdev, idxd->reg_base);
>>  	put_device(idxd_confdev(idxd));
>>-	idxd_free(idxd);
>
>Simply removing idxd_free() causes two issues:
>
>1. This hits memory leak issues because allocated idxd, ida, map are 
>not freed.
>
>2. There is still an underflow issue for dev refcnt in 
>idxd_pci_probe_alloc() when idxd_register_devices() fails. Here 
>get_device() is not called but put_device() is called.
>
>A right fix is to remove the put_device() in idxd_free(). This will 
>fix all the above issues.
>
>Thanks.
>
>-Fenghua
>

Hi Fenghua,
 From my understanding, the function idxd_conf_device_release already
covers everything done in idxd_free, including:
     bitmap_free(idxd->opcap_bmap);
     ida_free(&idxd_ida, idxd->id);
     kfree(idxd);

At least the newly added idxd_free in commit 90022b3 doesn't resolve
any memory leaks, but introduces several duplicated cleanup.

reference:
```
static void idxd_free(struct idxd_device *idxd)
{
        if (!idxd)
                return;

        put_device(idxd_confdev(idxd));
        bitmap_free(idxd->opcap_bmap);
        ida_free(&idxd_ida, idxd->id);
        kfree(idxd);
}
```

V.S.
```
static void idxd_conf_device_release(struct device *dev)
{
	struct idxd_device *idxd = confdev_to_idxd(dev);

	kfree(idxd->groups);
	bitmap_free(idxd->wq_enable_map);
	kfree(idxd->wqs);
	kfree(idxd->engines);
	kfree(idxd->evl);
	kmem_cache_destroy(idxd->evl_cache);
	ida_free(&idxd_ida, idxd->id);
	bitmap_free(idxd->opcap_bmap);
	kfree(idxd);
}
```

Thanks
    --Sun, Yi

