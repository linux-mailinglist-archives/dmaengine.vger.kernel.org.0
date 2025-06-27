Return-Path: <dmaengine+bounces-5653-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9DAEAFF1
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 09:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1B63AF51C
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C546B4430;
	Fri, 27 Jun 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQ1FmWdz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA832F1FEA;
	Fri, 27 Jun 2025 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008562; cv=fail; b=m6WQj7PpE3mc1zayKZbOWIXouFn5944PseTdZ7GBjC8MrksmPQlBCHEgbOI4A+treMdfGIOehXNfrn4ZuPkWVi1PIIUnGzflDVb43dE1J8vhGOM575B5PMet4T/vU6iZIqR0PhikswhjikUs055LYggSoKMnbrbb1xJwFDD3RwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008562; c=relaxed/simple;
	bh=0ygtipgbWM0ePPb5USG8R+e+dC1Ek0VcjARgWNjdFxo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iW/Z5+vqb2+AzhVfW1k7IiOFx9dX0rzRt2n1o7wh9REkfetGJD1jeUOdVsUCzf/VSoxgbrJnW+R47E9L71aYZD79/b/mWIHQOK3o/LZONg1VSJeCdOPWuMIyarRLUxT39SGngUjwdq+ZSB5zscBDLtgHhaPwfjBrJhGjcpld33Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQ1FmWdz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751008561; x=1782544561;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0ygtipgbWM0ePPb5USG8R+e+dC1Ek0VcjARgWNjdFxo=;
  b=LQ1FmWdzL1FjCQlEJTeafoU/8NV8dZKy6r0WOAoTK/mE3d+P1BmF4SLt
   zcJdal/ke+2Lc1iXERA9T81KX5YxNUx1xmfApZCySI/pkTowNC9B1kWX6
   tXHnrE9ExwyebdXnB22OoM+l3aQm86rsmAAwW1OH7FIWkWpdKxqS4g0yt
   jvz2TldLon5WVWURCDTeuCU8qM3WeSKgUtMdtvLOOSwjdM9/E2kRdQBIe
   Co45Vrk34uSeao4eqbSipydOl3L3mj/IjzvSGAwtmmc31CG685ttntR4w
   GsaKyKvGlPujckE85UFewnqxCrJYi4ZqMtL+jj25faBPubJrDc19AnrlJ
   A==;
X-CSE-ConnectionGUID: qEsENyM4S5iQWeLhhAarGw==
X-CSE-MsgGUID: APQl3t+ASa2f9c37EBQTEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53189290"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="53189290"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 00:16:00 -0700
X-CSE-ConnectionGUID: w1txy5CDSyWKl1ceiCgZ1g==
X-CSE-MsgGUID: WnvtsRu8Q/2G2YTO/mPELg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="176412428"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 00:15:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 00:15:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 00:15:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 00:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnyljvkGPPNqDoIo0uBYwKrkaMLOyPv5A1SnOdzMh/y7mF1BUMRf0WDc1gdJ4a85NChVj/TuM87qthK9RL1X2QVdRJY2eWDEENvpJKyZTTRauDhzCB6LhzDKhBjSd5ghHPRw397f/YyO6Xg6JlX9Kl6rV9N492c3xQaOF/iPvnL8Z/Ew0T9ILjBe5srPVZHZjELYJXFoJ6+kbQvBcOHCL8XIufbStjZImBe84fZ6x6waCQ50h3blwtHnPqMOviNpNSIn5I7UbFzEpMEwIsMiJWmSS7LQ4GWi5KV0mQ/kFttq4rBQwkqO33x+FMS6lDm32HyLADhWTYmDnUF0ua4diQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsP3qAzJn5vIB8pl3trIyne48lAE6pGX/a+mC1OM1Ig=;
 b=CGHD/leO8FLLCsE7Z5/flxvO9npKpvJInYaaBtpG1lG5MENqz+jpwdF1SO+To493lfjf1rfZzfXHCtVBs4Q03M4pA+0XgqnK6C6H1IMEeTZO5AzXKq0JZjZq322eg3AgapxnFmr4xDkNT+JDsenlxbN7sJcBlhajsuVmYzUQrUzWG7POVgyu8qc6Ywzv3Y7ZtciT4qvzAxdaKHJWy6DEPl3aJW67J3Mrz4AF3QwXpptR91H/41Jf7vPBPQ6QBSVsuIUVxJ4Yb38wBYAofHnXLkYZtDLOXfiBEn5Vbqg6BeS3jeTWj55kUDo9luH7NJ3pTBkXS/Yic/7Ol9EyG4gFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by PH3PPFF8C186950.namprd11.prod.outlook.com (2603:10b6:518:1::d62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 27 Jun
 2025 07:15:17 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 07:15:17 +0000
Date: Fri, 27 Jun 2025 15:15:07 +0800
From: Yi Sun <yi.sun@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gordon.jin@intel.com>, <yi.sun@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Remove __packed from structures
Message-ID: <aF5E-x9Tj3sT3Nku@ysun46-mobl.ccr.corp.intel.com>
References: <20250404053614.3096769-1-yi.sun@intel.com>
 <175097809157.79884.15067500318866840512.b4-ty@kernel.org>
 <aF4YdFZnAWcZlpbW@surfacebook.localdomain>
 <aF46cRgzYE4N3A25@ysun46-mobl.ccr.corp.intel.com>
 <CAHp75VciZKX8uyZvYsrG6-ffrZbzDEPU4UH06eh9X23qBC0LYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VciZKX8uyZvYsrG6-ffrZbzDEPU4UH06eh9X23qBC0LYg@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|PH3PPFF8C186950:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e06b550-bdd3-4857-fd7a-08ddb54a5e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bC85RUxNMGlxVGtuLytVcUtEaENFcmdpeWlzNnYzTHkrUWFEZ0NhcythTDhy?=
 =?utf-8?B?d0ZaSkEyTVFvUUxmVnRpZThyZUtmb245aWFKc0kyVUN1QkdzekYzbkJQVTZT?=
 =?utf-8?B?TmVYaWJxTDRtWFVmeWhiakJ1ZkZ5em9iUUNWRW0xYWZyek5QK2pGcmpSQnh5?=
 =?utf-8?B?OEQ5cWdJamUzaTVnT3hRK2xKTTgwZm9lak9nUzFIcWE5b0dEUXFpNHllNWFB?=
 =?utf-8?B?aUFrYTdMSS9kdEdkWmF6ckg0dDhaT3lOa2daZTA4WGdxR0hWRFcwL2hyTnJx?=
 =?utf-8?B?UllYeUtTR0dReURYYTNzcjZJbHRDdkVDV0ZUM1VUd3lSSjFlYUF6b3Q0WGh1?=
 =?utf-8?B?UitvaEVOSGRPd3huVmtYRGJhaThiajE1bGp5OS9NV2dKZlNlWlBxSDNzSkNr?=
 =?utf-8?B?UEE5Z3hLaXRkTS9STW1EeWllMitLTVpKSFRCM3JnSVdYa3RvVzF3bWg4K1c0?=
 =?utf-8?B?K21ZMTJCU2NUNDcrUjZKN29YR2xKYVBzWllkdW5rVTlqWGlmTS9uWVJIcnJM?=
 =?utf-8?B?MWdGZDh1WmJnSkE2UXk4MEl5SFdsaTNhTmRXeklGSTFZcENuZE1XTzNsSlJG?=
 =?utf-8?B?eHZXZHZPRUZRODdDRFNaV1JzN1hqZzA1czFjNUx4SVNObUpLZ1pSS1BZa2xz?=
 =?utf-8?B?VkZWbm5lOE52cGtqYXNBeTlhbmtrMlZqa1BFWCs4bXJWR3B6QWZqcWNPMVNU?=
 =?utf-8?B?UmZ0YnU0T2ZmTGVMbjY0aW1tK1Rlcm9PeTVOS1JERUpOSnZZRjV6QzBDNTRW?=
 =?utf-8?B?YUZqMytvUmlid01aSmRET0ZkQkkzRDUrMTV1d0pGekNtNTd6dy9OeFNIS2V3?=
 =?utf-8?B?MXIzd0J2MElVbXZ1dkJhWmc3cFpWRkd3anJzcE16TDRVQnJhYjhrN1B5aGtB?=
 =?utf-8?B?S2hTaExIcnFia0YveERoRndvcHVkWVZNUUZxNDNBb2RDQUdYcEp5UG5sc25J?=
 =?utf-8?B?Y3gxMFd4TStYK0ZGcW52b3J6MDI0MWM5KzA0RjR4SmpDcVZ1NXkwUytUZVkv?=
 =?utf-8?B?d0VxZzBYMS9rWFh6anIyb1BBQ1lSTXJRM05CWndPWGEzSFVaOGIwa2NFZy93?=
 =?utf-8?B?dEYzMzY0dDJGdkZHWFE0S21jVVVxcnY1SWR1SnBZVDlJVjlJUGFvOVZTV1lD?=
 =?utf-8?B?bDBSTzMzOGQrSzVLNmVDb3hwRHJSRmUrdVdnSE9GdmdLUGxFdzZ5TDFhVkow?=
 =?utf-8?B?R1VOTmRuek1sQkgra1JHMVpxUG9VVklCQXF2c3ZILzd6MHZsY2ozNWgzVDU1?=
 =?utf-8?B?VFlhVjd5bHpQczViSHVjcHhvaUJORnNRZU9TV1Q5SkprMUQxeFdCbk5LcHph?=
 =?utf-8?B?dFFqcVFtNnZxZnVqa2xlclJZVnNxMFlXWWxxVGYzSS9NQWxVeE5HWDJpcUMz?=
 =?utf-8?B?ZXAvSDlxNVdVN2IxYkxDcVFtSTBTNXIyUmxkcE00NmJaUFo0eVRmWFEyb3hr?=
 =?utf-8?B?Qlk0MmlVbC95a3NUMk1jOXpZK1N3eml3M2hTQjUyeFRRTlhmdW0yNWNCeXU5?=
 =?utf-8?B?cXM5blFQendkdTBmWjNKWS81bXlaVS92NU9GK1lINERqL1QvSXphNHNGZ205?=
 =?utf-8?B?TE5DVHNWcnBPcGlOR25MMzhHNUdFWko3Um9md1NRdzlSc25iRUtOQnk3TUhG?=
 =?utf-8?B?N0lDWW5wU2liRytuQXBWSURtTHd0NVlZc2FLS214ZEY0b1psaWpJNzFobU5C?=
 =?utf-8?B?OStkTFRkL3ZMbVM5d1ZNb1BUQkZxTXNnMzJZRkkzM0JITEppemR5b29vaGs4?=
 =?utf-8?B?dTZvSFVCdVVYcVVuN2dCdnZwOXN0ZFlTUHJ2cHRlK0h1eVN4bVliUjFJMnk1?=
 =?utf-8?Q?/PhMIMq5SRgCitYHAzUvwtNOqQnceuJ407fFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVuQk5CY1ZGS1dmQWkvSHVkUDlHcHc3UWcrOGZoUzVvT1oxMTNDTEhRZ1Ru?=
 =?utf-8?B?VHV0SlVQeWpScit0T2NXVTFYS0hJZUJsSUdzaWhPd1A3M2VnR1NBSnp6STNy?=
 =?utf-8?B?eElvbkQ0by91OUJWUEppZk9JSllnbGUwRjdHVVJOS2h0WWtJOXRERzJaczZV?=
 =?utf-8?B?RXQ3Zkl5YXlscy9mRS8zb3VGR2ZtVkJ6RjltUHd2ZUdjY3J5Ym04eDhESFor?=
 =?utf-8?B?ZnZNRDNCMkJTRXVhZFMrQnU3RGl5RE44TS9NeHVNZHFCK2taR1ZST1FDYXE3?=
 =?utf-8?B?cmtzUE1yYS91NUE2NWh0RzBISUlWbWx2SDk2b1RWbjdhOG1XUmh5VDdUaUFJ?=
 =?utf-8?B?TlpIa2NwMnR1VVR6bkhMNFk0M1FQZ0J4cWtBRHhWRW5zNVA5bXZ6eFpPdHFT?=
 =?utf-8?B?RVB6b2V1YjBIeHJGQ294L2ZrM1BVNEFUTHNnTTZCTVh4ZzhhSkFuZnhhWFlh?=
 =?utf-8?B?MFdJenhxWUZUdUxTa3YyRC9NQm9PZy92MmtORHpCZnpDUXk3S1QvYkdkSUkv?=
 =?utf-8?B?MWJNZTE3TW1LU2tJMHc3WTRIYTk0ajliQVROKzg0U09BYWc5ajZSd2NOUTM1?=
 =?utf-8?B?YVdVWm1JejdyT3Y0RUxUcVJBZ1NONTVMeUg2SFRsemJxbjl4RmlCZVV0Q1VO?=
 =?utf-8?B?K2JtR0FWenRYYWh3eEJjMUZNbTNRcnZvS3FxSG5LRzYvbzFaSDI0MG5RR1dp?=
 =?utf-8?B?UnFMU1FUVHk2YzZ4WGpLaG1nTFZXUEJwZXVOWWQyaWU0amVkc2ozaWJ0dm50?=
 =?utf-8?B?NmJqTE1MRlJkdExCY0dFTi9ZelByK0xvSklqUDRXVUcxMTR4UFh4b1k5MEov?=
 =?utf-8?B?dDU1VzhXbk1jRUFwQ0NmbkxaU0lVYVBIYTcvY1BQdEhhZmJON0UyOEkvNFpJ?=
 =?utf-8?B?cjdpb2xJNFY0eFVOYjZtcGg4d3dqZ29SbHZGQy9GSFdwNTRCSXY4aC9vaDdH?=
 =?utf-8?B?OFpMRzNtdVNUSlNoWlNSTkVRWmFzYUVJY2hxbXJySzd1ai8xQzVqd2l0NXJX?=
 =?utf-8?B?SlBBSVduMUxKdVpXak9zd09hZEpVcGsxQnZ3RGNnM3crdGlaQ045eGtEeEtG?=
 =?utf-8?B?Zk4weXZJQm5qdTE2VFhlYXBwcVFwK2JGakR4REQ1dmsxWVB5MHQ1TFVndVVh?=
 =?utf-8?B?cDdPYmIxWmxSMU5OSTM3RkJCUHNPc1dUcmcwQ0ZaTmkyNGtrS0xUUVhyTVkv?=
 =?utf-8?B?Y01jdFRnUVZIcjhSRHpmemMvZFVSN3VpTUlJaDNLWmRhZm4xQjBZNWlHMkpP?=
 =?utf-8?B?YVN1RjhlR3pyWUdRKzBzNWF0S1diYlNzUzhqQ0gxV1FCUEJEL1lVSGVRZWxD?=
 =?utf-8?B?TGFIcHNHSUdLb1piWm9IQWRiRyt4TDRjTVR1akJURTQ3cWJ3MG1Db0dzSHYw?=
 =?utf-8?B?UG5xRlJVbm03ZTkwcU5jWDdkaWxsdDgwSjA4cVVCbmVpd3hSZ2xlTUo5d0hz?=
 =?utf-8?B?VjVCL29vRHZGNDc0NDJLc01ieTZLL2VXdTh5aElzMjNzQjgyRHZ0cDBhVGUv?=
 =?utf-8?B?aU1YZlFkS1F0RnBvRGdaU1V4MGdSMFlabFlrOUJoRkdZVWZZSWxLdXI5d3B1?=
 =?utf-8?B?RzdpWXpyUDNZL2NFL2h5eXBsV3M1bjNUSVJuN1VSR1ByaEovNTIxUFZjUXJQ?=
 =?utf-8?B?VGVTN1BjUTZ6NEU2T0s3OTM2dFFuREZJYVE3Ujh4T3N5dXVuMG1zYVpvMWZS?=
 =?utf-8?B?TVF0MlFJVEJrL1JCc0sxbE9BcWttVUhjeGZnNVdPcGh1cFRCenZ5eG5KNG1W?=
 =?utf-8?B?K3NyeXQxakUzUVR6QWNoN2t3eXBoS3lyREs5V0x0cVdveVpDbCs1NmNIaUxO?=
 =?utf-8?B?bEJCZ04zRnBpZGdnS3MwbkZ5bWw3ZkJ0a1J4RzIrajhOdm5acUVWL0IwaHps?=
 =?utf-8?B?clg2UDMyZVRHQXZwck10SlpRaE9qa3JiZ0RRTXMwdENJMWJ3RmRndVZMaDRW?=
 =?utf-8?B?ZS95ZVNyR2FCcFBJamZtK3FoTWh6VE93MzBqdk1May9KSm5JVFFUazdjbUty?=
 =?utf-8?B?dnBrdFRoQTBLQjQ2bElYb2pQMnNkT3pnZmZqUTlINm1YVnpEc2gxUEdsM0FM?=
 =?utf-8?B?TlZuWUg4Uzd6Q0lGL2JJLzkvc2ErWUg4Y3BzUnUwUjZtcnkvL0RxcGFKQkVi?=
 =?utf-8?Q?amGsSL2QKtzvpuv+7ChFI+Env?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e06b550-bdd3-4857-fd7a-08ddb54a5e1c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:15:17.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oF+6zSR2pq22dHsS9FWN8Hxf65B+2ZwLTFsY8AM9Zb4bow+nqXFQzPXd7m2fYJ8u69eYVvpvDB0m+5hGpaFkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF8C186950
X-OriginatorOrg: intel.com

On 27.06.2025 09:57, Andy Shevchenko wrote:
>On Fri, Jun 27, 2025 at 9:30 AM Yi Sun <yi.sun@intel.com> wrote:
>>
>> On 27.06.2025 07:05, Andy Shevchenko wrote:
>> >Thu, Jun 26, 2025 at 03:48:11PM -0700, Vinod Koul kirjoitti:
>> >>
>> >> On Fri, 04 Apr 2025 13:36:14 +0800, Yi Sun wrote:
>> >> > The __packed attribute introduces potential unaligned memory accesses
>> >> > and endianness portability issues. Instead of relying on compiler-specific
>> >> > packing, it's much better to explicitly fill structure gaps using padding
>> >> > fields, ensuring natural alignment.
>> >> >
>> >> > Since all previously __packed structures already enforce proper alignment
>> >> > through manual padding, the __packed qualifiers are unnecessary and can be
>> >> > safely removed.
>> >
>> >[...]
>> >
>> >> Applied, thanks!
>> >
>> >Please, don't or fix it ASAP. This patch is broken in the formal things,
>> >i.e. changelog entry must not disrupt SoB chain. I'm not sure if Stephen's
>> >scripts will catch this up on Linux Next integration, though.
>> >
>> >--
>> >With Best Regards,
>> >Andy Shevchenko
>> >
>> >
>>
>> Hi Andy
>>
>>  From what I understand, changelog comments are ignored by git am and do not
>> interfere with the SoB chain. They appear after the "---" separator and
>> aren't part of the actual commit message. So it should be safe and won't
>> break anything during the integration.
>>
>> Let me know if there's something I might have missed.
>
>Please, look how it looks in the repository:
>https://web.git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?id=671a654aecc710a278bdd30cfd2afef2d4e0828f
>This is wrong.
>
>
>-- 
>With Best Regards,
>Andy Shevchenko

Oops, I see. Something went wrong during the integration.
I didn't notice Vinod's repo.

Thanks
    --Sun, Yi

