Return-Path: <dmaengine+bounces-5281-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E5AC860D
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 03:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51AB16EFD3
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 01:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C8813E02D;
	Fri, 30 May 2025 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeOREkip"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E779D2;
	Fri, 30 May 2025 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748569361; cv=fail; b=WR1GTMrRHxM0dpQw+Hw6x2/q34rDFPONW+EshRcv3nt61IillIsG4XkBBGc5prku1vMBRM4OqYExD2tAFUvdc53/LuCVxIedKnNGHGvF1Ps7VBKteFS4XwFOhGJVln/H6oMMR/RNynGNcqmqrn61piHTuzC/5WZ0xijpYJiMsfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748569361; c=relaxed/simple;
	bh=ep+u+zl22B22l5S+IK+ZUJlkXrBb2vf4XX+t9pG7nSE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hAq5Mu2DD0bbfd0/GRtvcFnqGrJ7Ytq5eHYvIOK+iRFcA1Mlxk4++glpck52/GwJCf2swiJUTq5Z+w3desqyRItXpICEsnw8T/913Mki39eanHaEguyTioi4RCvC3bbUOLKsvQjmi8b1c0VIwLY1+bGQWdsIecI37B/np9t2vSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeOREkip; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748569360; x=1780105360;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ep+u+zl22B22l5S+IK+ZUJlkXrBb2vf4XX+t9pG7nSE=;
  b=FeOREkip8ki4hidWNdnp1AIILXiQB2K3pjk47lYBnw9sglxT+zLX0M2+
   15GlHB8iytWlEay7D2DxkA9BAyqmV1K2trgPHaWfSKtl5u7pXxOvJ0h0u
   XXQAMAOzmecWJrxEL0gWARFGmCHM1M98rwwEkhq+HbDP0mv5KRsVAHjHM
   VVXSHFCyrW8yNvhLGNsfATBoP0JuxZ0fis3DNWARdMpYzhuas+fz9NntH
   5GufCSliHKznJNHuwWzVFzLotFYDtp0GCgkAn6OpPl8RLE0urH21sGMMK
   HmiQqEPhhK86IKXvYTpuDPeFn3RV/1XzcHu50Mreak2tS8HhNwjXGDBsF
   w==;
X-CSE-ConnectionGUID: i4ghkq6fQ422dC0z3UwDYQ==
X-CSE-MsgGUID: owiALANeQr6fgGPiSbRK0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="54318537"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="54318537"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 18:42:39 -0700
X-CSE-ConnectionGUID: /Kc2EyNPT6CKD+mI6jcl5Q==
X-CSE-MsgGUID: E111vBcOQTOpexmcTes0JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="149009438"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 18:42:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 18:42:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 18:42:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.84)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 18:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3BDjF68sg124/iTMpTpk3E8qfGiZOu9RwkVUta3uRN5FIP0DSIdp/zaAt/1apPY5O8k3PKAklyGYp5xIa8+fNabuOyGGMtJd5guyH4oWEz6N4KMUTcjC55x5BAI3tzUQjGXWXroEocgpEpn6MpVoXmHiNEtZRS30tPl7TA7B99/dk+tzsWCHll1wWSU0+UGc052nA5nV4t0KmkUEYOXZ/dzKpBITjfcE80LE6pCn4wLuupmffvl7TrK7WMvq0bTdfl7BcAcypYiOcjaJ5EbVJkoT0i/WTsu5L6xZ7Svk6wTi0g7w0XsO4Rr/jSv/CiHjn1YPhXDZbM4NBc2UGTwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO9A5PjyNVaH2WvC/ZB50chjhqZjGuEQIH8ls1LLTN8=;
 b=IpVxRumQKSeLlQIgcqgbn/j5gJyFvGnG0Qh/My49qE6Q2RY79E7MSJ4qEXo7hXRUQOBhwFTQeXdyPPj7LcGcVwL4ZYgxkjn7jfjfhV8Vbg459JDqQolp9NnKKaYYvXJnL9GYUFFDuiS/oQZp2Xth706UIdOumFlrpQ7QTO42jwXchOyRl1hh7rzvQEMxi204bwNQBD6W+mD+qPbbJ2qcCIDQ9oiFRynjiepTyZFOaJlBZxWfBKCjeJOypVpOwp60ok/rxFbNM3r5iCIUgBJBCrK7jhVGLEDWIr0tL6evAzDlknAr7qQa0fxN0g00xmPr3U1HvRHlK7NtbPKJnV8trg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 01:42:31 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 01:42:31 +0000
Date: Fri, 30 May 2025 09:42:21 +0800
From: Yi Sun <yi.sun@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
CC: <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xueshuai@linux.alibaba.com>,
	<gordon.jin@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: idxd: Remove improper idxd_free
Message-ID: <aDkM_cKcsX9eMzFK@ysun46-mobl.ccr.corp.intel.com>
References: <20250529153431.1160067-1-yi.sun@intel.com>
 <87r0079wyy.fsf@intel.com>
 <aDj60tJeJ-bYPFEX@ysun46-mobl.ccr.corp.intel.com>
 <87frgmaotm.fsf@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <87frgmaotm.fsf@intel.com>
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|BL1PR11MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa88117-b47e-413b-1f0b-08dd9f1b3e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3pOY0d0OWJGVjVKNkhTdU1keGkzaEIzU0tVbThTc01waGJqcDUxdWUxa2lz?=
 =?utf-8?B?OHJzTXg3a3F4Y2MveDM3eWdrZ0pQNmhVVEtJdXk2Rm9xdEs2T1Q1Y3pneHlp?=
 =?utf-8?B?ZEVaMU5rZEswbEtnenNHeWFGZjd2R1o4ZW5QbkhFVlpFbjVPWUtvbDVXV2RQ?=
 =?utf-8?B?cWp6SHZ6RWFSaU5YaEtGeFFkdkk1dk85VlAwWU9SZ1pkdTBhNnV0eithSTRa?=
 =?utf-8?B?S3RNQUprZDk1R1ZqVEFBMzVyeFZDMmNsLzc0RVo2WHM2dnlqaTBNYVpuRGo2?=
 =?utf-8?B?cEJhQW9WY1FZTzQxVkZ2OElYVDFJenJsMnRoemJGN3JTbHR1RmtqRGxSWUxz?=
 =?utf-8?B?RVZYbE4rZHFDZmZCS213a2dHeEo5bDNObUZTcFdUVE40VUtISjF2a3o3bEox?=
 =?utf-8?B?NE9yeWNJRXh1MExrUGNrUjhLUHk0amxLNUsxRTFLU0N3aG4wcW5rbGU4RGVi?=
 =?utf-8?B?NVhjcXpRS2lHcUE2YzJyZW5sSFM4emVMcUdUWUJQa3I4SkhxbkxEbUZ3UEEz?=
 =?utf-8?B?R1dqb0ZVV2hGVDFTc1hYTTVFVmhLN0pZSENLbXhBby8zR29MQjNGRVNTRXEx?=
 =?utf-8?B?L0JVbFhxUy9mTUxDS1ZBTXdEV0ZPYlF5aEJkd0xQQUVjZ0thQXRXUk1qdlE0?=
 =?utf-8?B?SUlDNzVIN25EVnlwSFN4YXJzNjlyOENFbEZzUzNab3JZalFXMEl6Y21PNXN1?=
 =?utf-8?B?YmZ4OHl3NmtkZVZMUnZiR3k1SUVCWjZGQUVhR1FaN0lNU05EUktsYUVOMFVP?=
 =?utf-8?B?MHN1YVgyejVKbjh3UG1tRUd6VlpENG1XYTBaZ0RNZUdHY04rRTU4ZFVrUHZt?=
 =?utf-8?B?SmkwVStLR3N3MFY5eFdVM2ZFaVJ3WWhPWTBKOGVkcFFaV2FQOTgzMjhrMTVX?=
 =?utf-8?B?eGpkQmdnNC9KU3pxaU51WGkycmhSMC9iUDRiV1pPbFNMVXYyemZrcjRnZDFN?=
 =?utf-8?B?MnVPMWQzTDJJSFAwVExFN1cySVFNSkxiMlZZMXdxYzVtSUtvb1FZWG9KZ3Fz?=
 =?utf-8?B?WFdaS3Z2eTNGNGJMSy9pcmU2cjhSTkFGTmtLaThHWlZSY3VSV3VxcUNQN0ZG?=
 =?utf-8?B?b3g4N0xYNGI2eVJ3ei92N1hmZlY4VEpyeVJiOHU5VEovTUh3WXNTbHNyK2V5?=
 =?utf-8?B?U2syMWgzMGRyRlUza3c1cFNMbUhBNmhPQytZaDNJaFg3a2tqOHhOWVQ3MlF3?=
 =?utf-8?B?bEdMU2lsU3FvaERuQ09SZ1JOY3BzUUJEeXhIV1dPQUk5bkZ1SzM5ZGd5TkRm?=
 =?utf-8?B?VVcwYkMwMmFGWVpUcHppM2lJdS9kRllHVmFOOHVRYW5abXFhd01JV2ZCK0xX?=
 =?utf-8?B?aDZwL2FkWHBsS2tGampBRlU2YUxTaVhSUERGdmhqWUM3M1VHUlZpZ3Mvc3pC?=
 =?utf-8?B?VEZ1MWt6OUs3a09YVkxxQUZtNzdoOGNGcXUvL0EvRWJOdmovVHZiTkMxTmVU?=
 =?utf-8?B?TGZIdnJ3K3Q4NklZcDBYY1dYSDJxTTlwbVJWcmpqWGRIUHVpVmNKdkI5S0RN?=
 =?utf-8?B?bkorWVRURUZGWVdYaHFUbzRCUno3T3JGTktzYzdlY1BUVkdXK0h4UUhtazBs?=
 =?utf-8?B?a2JTQldSakd4SStSNUIyOHFGWko3UHZSTDVNR1h1dmNRazhkY3lBUE5seDNu?=
 =?utf-8?B?ZFdiSm1FSmlhN096Q1k0a1ZkT2x3QjhaTC96WXY3MHFWUzhNd0dXdkM2Q1ZD?=
 =?utf-8?B?dWRDUVhTMFdFNnNQbElxd1FJdGhDUmZaMC9McEVCZHErcGZmTEJnanZnZGt5?=
 =?utf-8?B?Nll6QWM2K2RHSkk2ZkpwQ0ErNXNoRUFhbS9XK21pU2o1Z2s0WndRUTNsNngw?=
 =?utf-8?B?c1NZZmEwRFdZQjNhUkhFbXFSQTNveU5RQW5zcWhmRCtoTWZiT1dPbzBOeDBD?=
 =?utf-8?B?L1FHVUdFS1VJRHZkMDFPeFltQ1BRZWhBT3FWS0MvWVhNeGZEQWZ0S0J0RkFH?=
 =?utf-8?Q?frSqhxeQZAA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRxQjB3Sjcyd3p2NGxLN2JSbmI3cE5IUW9pNDdJWE1ZZkNiaHlwYUFTeTJy?=
 =?utf-8?B?b2pkcXdWREFCeWRhOXI2ckRFSDNGK0tXSEFDTHpEY3haSEswai92cFcvenhG?=
 =?utf-8?B?dXdvQm5HMTJxQ0libXYxQkcvUU1KemxWMExsam95b01SVXdpeGF5bTFqMnRJ?=
 =?utf-8?B?R2lSMnZOeXJkY1kxWnc4enIxNkdpTW13L2xHRmpRcS95bkNFMCs4MUQzYW43?=
 =?utf-8?B?cnlmSXRISjJUT3F5clBiZXBSUGhtT1RSWWN4Y01MaFVjVEo2Z3R0VVpPOGhY?=
 =?utf-8?B?UHQ4S3NzUDNZODUrTWorS2dBUndRelVhd3dNeTBGdmdxblVFMDZQS2NMM0Jo?=
 =?utf-8?B?dUtHYXRtd3FoUkpzUUhzb0k5cFh5RWxPYmlyaVg5K3BveXVpWXFHNHliZGlw?=
 =?utf-8?B?WGpOdkdyQ1Vya1AydVdpbTNTVTJHT29pSThMTXE5enVmYW9TQUVESFBRNzkr?=
 =?utf-8?B?Z05RL29tMFdYV05lYXlpWEF0QTEvbnAwbmhJUnFhT01BOGlnRVJ3akJCQlZl?=
 =?utf-8?B?YUJ6aWZYbmErODZVdEg0dG91NlZNWXZaWis5QXMyZzRMZUNoS0J6SXJnaHI4?=
 =?utf-8?B?a1VwRHVXOEJsNmg5U0NSRU9WZktiNzFBNWZQYytMVnorWm9pWnZ6TktLZ203?=
 =?utf-8?B?elhtMnN5dzNVZVJydjVWRGFlWGk4TllPRnlHbk1VejZWWXplR0xWY2pMcXli?=
 =?utf-8?B?bFVxSG1UcStKdjZQaWs1dVZPeWxTWjlJOFpFK2VUbGNPSlJKTjhmcEFZQzBX?=
 =?utf-8?B?eDNNTUYxOTNhM2FBRHNBV1R3VTUrZldiT1drS2ZEZFNwUkxPSU1PMis1cWNa?=
 =?utf-8?B?VjhvNHBZNEk0NFpScm5SZkNja01wMnQ1TXF1akRrSktEeTZsUEpUTUx3bnlN?=
 =?utf-8?B?Qy9kSmRpTnkrajljR1hGQzF2U2xzUE91WFdMM28xdGtyTXhaVVg4SmFOcmFw?=
 =?utf-8?B?emNLU09vdGxzZit3MjFWQ00xMnhjejlUajBlOUxvL0MvbXoxRkNVdDRPRVRQ?=
 =?utf-8?B?T214KytpdzZjY1lXeThnQjRRRHRUZ2ltdDQ2aFJLcTJyS0NqUUxkWHNHYzlO?=
 =?utf-8?B?ZDkvSk1ieFNyRW5ObzBzaFlDM2hSQ044TDdhM09MTFhOUEhzckd6VkJrM3Bl?=
 =?utf-8?B?ZDk0c3EvSkJPZnRLSk05MGtjdHlGeExIVXNBZ2FZeEg4OStYcnpRTCs0Rmp1?=
 =?utf-8?B?M3d5WnhjMmhOWGFGdzFnVFdDSU9tY3d0T1pyZ3FESkhhb2xONmpqOXhzUDMv?=
 =?utf-8?B?MWR0bzk5YWE3dktGc3gyTjR6dGtZMXc4K0dWaEZXWmpVVlFmZmJ5dXFmMDNZ?=
 =?utf-8?B?VjdiUXBrSkYzT3N3eEgrN3hBc2R1YU1WVnhzbEZpSnNpVmMwU3BzT3piQXU0?=
 =?utf-8?B?MWFwTGFpQzRZb3RteUpvZU9oZUNWRXZsZG1LSEJJK2F1dXBVREJiQnV0SG5U?=
 =?utf-8?B?YUlhelVkVndyNmphcURSUklqTnhxNUZRZTFaQUJBUTdqSXZlYjhObk1xY0Vv?=
 =?utf-8?B?WWhYbENoLzIzMmppWW1INitjVWJ2RldUWEEzNjhPZW4zNEw0T3FxRitVUEFL?=
 =?utf-8?B?bGFaU3dYUVQ4MHVKM3FmY2ZRbE9VWnhudHFBeXpHeHh6ZW02MDVabmNpTHdE?=
 =?utf-8?B?Q2x4Tm9IeHFDSTJiUHRlN3FrTkhzMS9UUzUzYjIyNkZQWWJoOE9oNGNDMGZw?=
 =?utf-8?B?TEJROXZzNjdRM1pCdkFhZWpaaVo5ZTNsejFaNkJ5WmtoS0hCZFJrb1Zmbmxl?=
 =?utf-8?B?QTgvdHBSSWtFNC9XeVhuNEZvRTJwYVErb2g0Ym94Ry84QTI1eWVHZHBwOGc5?=
 =?utf-8?B?bHliRXhkdjJQT1ZCTHpqRTl2NEtDeDgrRU1VS01QdGQ5UFJSbExacm5RVFFM?=
 =?utf-8?B?UEQ1SmNMM3BEZ2Q0TVFLQlFJQ3NXL3NZNWhCNURwYnB6eXZwTjVMbk5WS3FC?=
 =?utf-8?B?UDlyY3pNdUt1TDgrMENsRFQrLzhObDc0ZGRkYlpLbXloYmJUYndSOURjUXhM?=
 =?utf-8?B?VkVtbitldEgxUHpXMGtOeTRHZ2R0NDhGem0wV1hwcWwrTWdCUGdldnp2MmpC?=
 =?utf-8?B?VTZRQk9JMjAycmVJWk5Mdit1N0RYTXV3ZC9jMzNmRXAzLzdsNlhnaTcrWStM?=
 =?utf-8?Q?y6IYaZrbyUHI4ayGLV5skEAFl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa88117-b47e-413b-1f0b-08dd9f1b3e3d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 01:42:31.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbTkNzNZJmuLYXgOcjyd8+GLTk3biahY+ft+F035+VmrVHxO1d32Thi/OacVPF72BOgGB0DJmsDEWOHTV1Gyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-OriginatorOrg: intel.com

On 29.05.2025 18:07, Vinicius Costa Gomes wrote:
>Yi Sun <yi.sun@intel.com> writes:
>
>> On 29.05.2025 09:56, Vinicius Costa Gomes wrote:
>>>Hi,
>>>
>>>Yi Sun <yi.sun@intel.com> writes:
>>>
>>>> The put_device() call can be asynchronous cleanup via schedule_delayed_work
>>>> when CONFIG_DEBUG_KOBJECT_RELEASE is set. This results in a use-after-free
>>>> failure during module unloading if invoking idxd_free() immediately
>>>> afterward.
>>>>
>>>
>>>I think that adding the relevant part of the log would be helpful. (I am
>>>looking at either a similar, or this exact problem, so at least to me it
>>>would be helpful)
>>>
>> The issue is easily reproducible: unloading the module with 'modprobe -r idxd'
>> can trigger the call trace so long as a idxd_free() is called immediately
>> after the put_device().
>>
>
>Most probably the same issue I am looking at then.
>
Yes, and actually, the other patch (patch 2/2: "dmaengine: idxd: Fix refcount
underflow on module unload") addresses a similar issue which is triggered in
the same function and resulting in nearly identical call traces.

There are two separate code changes in idxd/init.c that can lead to a
'refcount_t: underflow; use-after-free' issue, both caused by incorrect
use of put_device().

Thanks
    --Sun, Yi

