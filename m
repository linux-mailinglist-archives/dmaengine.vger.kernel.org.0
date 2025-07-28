Return-Path: <dmaengine+bounces-5875-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ECEB13A04
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 13:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF0716E127
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 11:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0383125F7A4;
	Mon, 28 Jul 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/iJs947"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04EF25DCE9;
	Mon, 28 Jul 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703007; cv=fail; b=DI7dOB2TDnLIVCkerbhR5F0S8E1mR7wyTKcAtGtVs2rf44FqVGSiHIu9169rFBW6vHolrhkZy7obX0YzwzoEi1rNRlkOPIndjR6xLyLeV8BWUjQAt/pb4rEoS5xk+t2ZiO0gd++7Xi5DOFj4GFTLOJyB0S0uNTUyBua0rdf6dGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703007; c=relaxed/simple;
	bh=Ihg6vT6K9n7pz3T20U+ln2GGpX0AAQKUTPCR869M1Tg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NARHGFpN6yt4cDx/rBw233IVpH5VgBGSYdJGL5ML72shSvFtcMFBmsZtOWwKeYtfz1RAGI/2jFbablIbD0Rezs+mvnw5eRrUFhAlb6qJeWv3FzZjv0LtpLlVcDYmSk9c2ycWSqI5cm7pQUzRUpxgowTsWj1NLd3NK2CHHS1gFt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/iJs947; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753703006; x=1785239006;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ihg6vT6K9n7pz3T20U+ln2GGpX0AAQKUTPCR869M1Tg=;
  b=H/iJs9475sgqZr0MJyiKoh+660VqA7/6eaB3Ca5hMit7jIudfrPmShBQ
   QzeiaMvDjYvLSQhOUjI4hJUlREBRImTW14sMfZIaySg9EZYfeLV45/S3k
   W2U5n9VbKPppfx59bSE3VaFqHZjWNOiXruBhGUA8N4kqCT+9p4mtd1IWI
   9FP4AywMS1eOpgG3yvl5aatRg4xdLmFHQNaQqa2eyAfJ4Rhk+919I3XHd
   XTx73szS6BjQNdcCaTOhp5RM8GKInhRLqHqS+rjFjSlslQwUq9n4gAgCk
   fGbZ7RzRrBYaVnOcSEOxiIIICYm2BM9fnESlNH69K33hV7B1NRn0Y8Pi2
   g==;
X-CSE-ConnectionGUID: ZMuhfpDyQlyTW5NrfPA3bA==
X-CSE-MsgGUID: nT34m9shQNu0xC/AwBiNJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55649341"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55649341"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 04:43:26 -0700
X-CSE-ConnectionGUID: St/EbO1WRH2y0uNsvJFFmA==
X-CSE-MsgGUID: FyUGISLEQRq/98IKhqD5Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="167805885"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 04:43:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 04:43:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 04:43:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.52)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 04:43:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjY7qExcY6XmpJXWgA47Q8bbZhvI5vgum/wSl30+E5t73V7D8P0GPOveVIaonbIHRfRMDx1eNH61cdi4sMnDsf/woPpqihedO1wCy+8W+p0xF8I3beUlCY3a7FmsHFcbNFyWD4TO5HCw+1+Qy9VzwqmyyZbmYxIxiYQqUp/bOnkLblgCeSMbyCPjLh9dShJgQJxOEbI8o1JcFK0l/QK+QnAC7aw51le/MfzIykbbTOIF7RI8iE4tpeUJzFtwPlXX0x5MVlgKlmNSv0sa7BXzAbLkodam26S6xfBGQjkFhH4i1RHSeooJ2pxZN8kBTCqkZfbmZnJGD7sTcs2PoAw9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hfo7yPD/xBTPrPW4SF9f/8+nCEtd+bkv5fVUoMRCb8=;
 b=wXLI60aaF8CxdpAFxNb/dv8fQ0MbqdCLjsyQosRrGm76dz1IQpk9fZcPxBxMn3cccqq0f7fRXF3fSCx/p3vn7cP1Xz0tkyHKlwys7NQZKbnPldr+EkS8z2wBX2DtvsajpkfCF5UyQA3MZtvJ4ascqbfLiqqr+ZHtLh9aUUM3zC3Pz0hlbFLom4IugZziFj/G6ZYK6kCIYTPG29Y7PRwtc5L0qWx93htekd23OZNTN5TkB8FSA3gqpQEYYmvl5lTmjzhFmpTYWy7vkjuirJy2jzwRNZKraJGQuFamZ2keL6fN7DODHSWttEsv+RdxTX4QRpAM9FJSPzjB1J+uN/QTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 11:43:22 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 11:43:22 +0000
Date: Mon, 28 Jul 2025 19:43:10 +0800
From: Yi Sun <yi.sun@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: Fenghua Yu <fenghuay@nvidia.com>, <vinicius.gomes@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave.jiang@intel.com>, <gordon.jin@intel.com>
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
Message-ID: <aIdiTlIU03stIdqe@ysun46-mobl.ccr.corp.intel.com>
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-3-yi.sun@intel.com>
 <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
 <aIXuYVtGSV0OHHps@ysun46-mobl.ccr.corp.intel.com>
 <316cd6b2-3519-4353-8c53-06997096b216@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <316cd6b2-3519-4353-8c53-06997096b216@linux.alibaba.com>
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: ff263424-188d-4ec5-9c4d-08ddcdcbf3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THpuZ3ZZcGdVMHZ5a3d1TTR6TU0rNW9MWnNrWW9ucHJJRHFnK3RxUm1JdDIw?=
 =?utf-8?B?bVpmTUUvbkE4eG03V1BLQ1R2TG5xOEovMWtkTjhOckpmRGIzUFAvVDI0Tzhq?=
 =?utf-8?B?UlcyaDgyVXY0R1FtU1c1ZDdMR3dJZHZVdEdDSVhoeWIzUEhNQmN0L0tlUlY2?=
 =?utf-8?B?cDZlMzF3OWxYWkhaUW5tLzJjbkNTV3B5Z1ltNXVINFR6eTFWbDRFRVUxNGt5?=
 =?utf-8?B?OGplVVhieWRoS3pjV3dBQzBTckhHY1oyblNRVlF5azZqVFg3UVg1WHcybTZH?=
 =?utf-8?B?TzBMNTVzWkVFdVdJbzBiaTJ3ZTZWNUpuS2xBd3A4WGZRSWdweFp1cWpCVjZB?=
 =?utf-8?B?NURKdDZPNWRGY3UvWWFMN0RsL2RvcGpFRnNqU3NGa3p4WlNZVmR0WTM0bW1C?=
 =?utf-8?B?eitUQnhQcFVTamdNRVV5bTJaaDFCZkdydGoyUmpaaC85cnpsR0dGaUhsS1RF?=
 =?utf-8?B?RXhkNnhpTHBhUkdocVJlRG9ZdmJkZDBOOEo3VjRicnhHSFV5a3ZQU0dLQ050?=
 =?utf-8?B?UTRxZjlZMWUxOFUwczRXRUtHS3FEekRxamh1L2o3UUNQNjlFK2VGREpZMWtr?=
 =?utf-8?B?eENPQXRDVTRYb2ZPOTIzL1JmN0JTQUtJMm0zYi9pNzVNcGdyZndhbG1obWNC?=
 =?utf-8?B?d29DRjlVcCtMcXowZmNVQVFySXlCcjVjV05BeVBjeU85MVp6VCs2bFV4U08r?=
 =?utf-8?B?dEcwZmwwSFpPbFVja1Q4OHUwWkl3b0NNY0ZVNmVUZmNwdFdMa1BHWWplWFdx?=
 =?utf-8?B?V0ZGZ3U5aUFjdXlCV1V3ZnppM0RaZHVHS2lLalRuYW9kOTgxRXkzTU1RNnky?=
 =?utf-8?B?bVgvWWtmL0xmZ09tcjM0dFltczBYVzRITTFQYWtXQlJzMUNkWFVNekVsYWVD?=
 =?utf-8?B?STNrclcrN2dHOURXMVZCMFZPZHIzaDE1VkxvQ1FKSllJbGNxdSt0NjVCZW1w?=
 =?utf-8?B?cCtSVnduKzZqWEtJeEU2c2s4cHdsMWxaNE52d0JBNTBOeDZWdUdPdnZtUVMr?=
 =?utf-8?B?YjdwYnVGVUcxdWFid1lkcW5HK3hGUDVzZ0FCL2pONnp4bnovdHJrclpKcEJv?=
 =?utf-8?B?MkNJVm54bnA3NXFXV29UeEdpMzh6d3NYUlBKWWlVVFBoT0lSRk1rTXpLa2gr?=
 =?utf-8?B?MDhaM2tQZ3NDTE9aME02T3A1bng1QngvK25ROVhSbVljYVFOM3RlVlpYdmIr?=
 =?utf-8?B?VWJ6VzlkT1EwcmdKdm1VN01UVzU5UkYrZWM3QllPbFNMei9RbEVkYUdZdlli?=
 =?utf-8?B?VEo3TG9QUlAyWUJJN3RnNnQ3WWpCN1hsd21CeTZZc0Jnbko0cXc3elhQVTBp?=
 =?utf-8?B?ME1iazM4YlNKZ25xRGFTZ2kvTXYvMDNTUDVsU2FuRFNadVlqMVlPeU85SVZC?=
 =?utf-8?B?V09vM3c0bkN2dTJIRGs1ZDZDSnh4QVlTbUNYZUtCQTZNYUxEQTQ2ZW1KNUVB?=
 =?utf-8?B?cExEOXRaYXp4d3ZKa21iano1aGhVbUZ1WDZPaWF3NTNGejVJSVJRNGdpdVh6?=
 =?utf-8?B?ZkNNd2tKYlNpTFMwby9EdE5BYVBnU1d2RXloRVh4V0FMc0kvQU15REJOUUJN?=
 =?utf-8?B?ZkJVWUE5ajRHVnNCdFIwQUwzTXpFeHVTMEl3TlVycDZjV3dzakV6cmFDVjlt?=
 =?utf-8?B?SWZuVC8yb0dLek5iRThpWGl4ZHkycGgwY0Q0dFRWVWR4Y1BRRHdNWmVBY0p4?=
 =?utf-8?B?Q2M4N2QrQVNjZmxKU2xndkE5K0dXLy9YK0s5Q2NGaG5OK3lTRjNFVU1kdy9J?=
 =?utf-8?B?bEt1Y2t2TFRmaVNnbVVidGVyNVh3Y2VSWEVUZ240SkovR2hLSDVlc0hhRk1B?=
 =?utf-8?B?SWlxSmVjTGlTNm9aQ3V0TmJtTmp5eFk3d3haWmRBVWovL2c5VEh4NE50ZHNo?=
 =?utf-8?B?RzhrdFFVU1ZSTytISjkwanFDcW5SMmlpOUU2MVdrZERBbVU3L1FJV1Z5Zjc0?=
 =?utf-8?Q?7T4D5lNMiCU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmFab0RIYWoyUE1naUw2U0ZWNkd5NnNuWWNDZEV6ZXRBR0xEc3BmanV4a2ln?=
 =?utf-8?B?bzE2Q1BmZGw4eHJtTlJ5ZHpGeUJya1RjcElaSXJub3hVVVphYWc0c2pucEtm?=
 =?utf-8?B?TzlZN0hwaWt4TEtLcUhYekU2cXZ2eStLbzlWd0VMYjc0b1ZyOVBadGQ0TnhM?=
 =?utf-8?B?UkJwdklNV21Yem5MbEVDL0U1S2U2VTRQd1lYUXVpbHljRFZWL01RdzlqeExa?=
 =?utf-8?B?MHAyUU5sSFJaR1RJV0F5RU9rdEFkaFQ0WG1TR3hkMWQ5VnY0d2U0OE9Bbmww?=
 =?utf-8?B?U2hiWHdnTzZyTFh4bEtZb2Z4SGQxQWoxZ0hRSkJXU0tUQ216QjhuZ0R1aWhH?=
 =?utf-8?B?U0k1VWVBWTI5UzFQeDg4b3dSY1gvQ01OZTFBd01haDl6RmJFak14andvMG9h?=
 =?utf-8?B?TEVqMUgzcm1sS3FzYUNOb1ZST2phM25tNjZ4dmZGOGVwZXlZRi9ocWgwckZB?=
 =?utf-8?B?U3ZaeWJGZXgvVGN2UXM1S0RFMTBmVDBiM0RiZkpqUEtaYjhOYU1DTVVLRXVQ?=
 =?utf-8?B?azhITjFuY2piemJxWU9RaGNmY2FjUlpGa28wcWUrMS9lRW5RMjRxTkg4bjJ1?=
 =?utf-8?B?R00yYnNnTGliclQwTTM3MDg4QllDVjM1TldnaytlVXZyZ1k3RmszVUdoV3d4?=
 =?utf-8?B?YVB5NkQ3L3lwQ0o5VVZOclYxbUJxZVRYM2poSXJjcStCREs3SndwK3NPd0pC?=
 =?utf-8?B?VlUrRCtmZXUzU1k1cXBuUWtMUk9uUVdia3RMZG05NHV1VlRndTlnQjZSbVIy?=
 =?utf-8?B?cEt6R3NtdStBWGJ2WERUSXY1UElVWDVUY0pMQ1FjYkptQWJuZm1SK3RoMFND?=
 =?utf-8?B?NFVZSjlOOFpFTk5tbVZvSXFGLzZpZ1cvZkp5QTlOZFZocXUxeWJEaFJqRVJY?=
 =?utf-8?B?RkpYZGZ0OE1vN2VSaFNqZXg2ZDVUYW9pVkcyRWdMTy83N1ZIcTdYbVBUQVBX?=
 =?utf-8?B?M0ppNFNvTGFqM093dTNIazRCelNFK2JJVzRBWmNyVkJkZ0ovTjM4TEs5U0FY?=
 =?utf-8?B?WUkxalpsVVF4WER6TDhERjNIcjFCaTQvaXdkaHN2b3dwL0lWYWwxdmphZ1lq?=
 =?utf-8?B?aDlvTGRSQzRUQlZRcFpBKzB4bTVMaHJzK0h6MEhEWlVONHFaWXZDSk4ydDZr?=
 =?utf-8?B?TENDVWFkbGZaTEZuQzV2T3FkNGh1WU15ZGZ4THVEWkFMb1lzLy9lS01kZnli?=
 =?utf-8?B?WEwyTjJlenZUNGhwUjJuWUU4Y1dVemgxbnZHNzRjWmNic29YZkwwNExqeTdB?=
 =?utf-8?B?N2RobFBQdDVPYjk3TU9lUXpJMFRNYkliYWZVKzc1U1Q5TjlZSUJRdVVKWDhu?=
 =?utf-8?B?V1dPU2lSaW9uOFZOY2NaMmxQRk1tYlNXMUFBZys2UFhLK3hiK0tVZ05tQzJ6?=
 =?utf-8?B?Z0dWS3ZRRDFUTy83YXVGcGFkdkhMWXdvQ0VKQ3pqMDg1YldvQnRqVUNWK3Rt?=
 =?utf-8?B?blJTZDBlMGRvYTdQaWtUVXlrUUVNNWxsV3YvNDRGa2FYcWQ2OW9zZjFlaldF?=
 =?utf-8?B?VENhaWJ6UW5YMWROaUVxRnJ6YWljTHBJZ09oTHpFQVpMSGFaNytPWnN0RWVC?=
 =?utf-8?B?N3A2RUV6N0hDbmJndWZnWHpkTHQ2b21TNkRyOGFGU25LbHc2bkZYbXU4ZDFD?=
 =?utf-8?B?QzJLM0trZGVjU2VJcmdiYnBTQmhhSWVyVGQ2K3JaQW03WUkwSUJNTmNsWTJk?=
 =?utf-8?B?RVNPUHFTOUhvRVdaeHFMSUkyQW5ZTmZMOTd3anBCalVaUkV2cElsVXozMmFl?=
 =?utf-8?B?dUMwOEg3SW1tMnRya0syZExkUGdOQy9HUld2ZURNV2txWEtBUEpLMExrTlpa?=
 =?utf-8?B?SUVOY0lEYWVwbERvcUFnUnFhSll1eXRJVFUybGQrWVVpMkxMY3Jjdm1kSGlR?=
 =?utf-8?B?QXNMVHB6Q3l2QTd3eWVDYUswNm56SHJZSHQzMHU2aDlVSVhHUnRHdTNDUk0w?=
 =?utf-8?B?Vm1qMGtjK1FBWVc5dFpmZ3UvODk0SGdteDJ0WTlJMHk5Smp2emFmZUpkNmhu?=
 =?utf-8?B?ZDFVemc1Um50TDFCcE5Hc0lQc1lWbndRVEMxK0NtNzBNTE5vTWR3OUt6bXFT?=
 =?utf-8?B?T2lJaWx6NUlVSGduVHJiMFNmdmJPYis4Sm9ERVpTMXgxT2srRVJUbmdaWVE3?=
 =?utf-8?Q?V8O0C3bp3HfrU82j1AYzUR1ru?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff263424-188d-4ec5-9c4d-08ddcdcbf3ce
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 11:43:21.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFkynmFWPJDPcRO6CXq1aLDAoxtIAqjyOO4xOtdRgKtnJ81976NyUDlbrJxaabsVa8b7ZShxbLBJiTGkQP56Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-OriginatorOrg: intel.com

On 28.07.2025 16:40, Shuai Xue wrote:
>Hi, Yi Sun, Fenghua Yu,
>
>在 2025/7/27 17:16, Yi Sun 写道:
>>On 17.06.2025 14:58, Fenghua Yu wrote:
>>>Hi, Yi,
>>>
>>>On 6/17/25 03:27, Yi Sun wrote:
>>>>A recent refactor introduced a misplaced put_device() call, leading to a
>>>>reference count underflow during module unload.
>>>>
>>>>There is no need to add additional put_device() calls for idxd groups,
>>>>engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
>>>>also fixes the missing put_device() for idxd groups, engines, and wqs."
>>>>It appears no such omission existed. The required cleanup is already
>>>>handled by the call chain:
>>>>
>>>>
>>>>Extend idxd_cleanup() to perform the necessary cleanup, and remove
>>>>idxd_cleanup_internals() which was not originally part of the driver
>>>>unload path and introduced unintended reference count underflow.
>>>>
>>>>Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
>>>>Signed-off-by: Yi Sun <yi.sun@intel.com>
>>>>
>>>>diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>>>index 40cc9c070081..40f4bf446763 100644
>>>>--- a/drivers/dma/idxd/init.c
>>>>+++ b/drivers/dma/idxd/init.c
>>>>@@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
>>>>     device_unregister(idxd_confdev(idxd));
>>>>     idxd_shutdown(pdev);
>>>>     idxd_device_remove_debugfs(idxd);
>>>>-    idxd_cleanup(idxd);
>>>>+    perfmon_pmu_remove(idxd);
>>>>+    idxd_cleanup_interrupts(idxd);
>>>>+    if (device_pasid_enabled(idxd))
>>>>+        idxd_disable_system_pasid(idxd);
>>>>
>>>This will hit memory leak issue.
>>>
>>>idxd_remove_internals() does not only put_device() but also free allocated memory for wqs, engines, groups. Without calling idxd_remove_internals(), the allocated memory is leaked.
>>>
>>>I think a right fix is to remove the put_device() in idxd_cleanup_wqs/engines/groups() because:
>>>
>>>1. idxd_setup_wqs/engines/groups() does not call get_device(). Their counterpart idxd_cleanup_wqs/engines/groups() shouldn't call put_device().
>>>
>>>2. Fix the issue mentioned in this patch while there is no memory leak issue.
>>>
>>>>     pci_iounmap(pdev, idxd->reg_base);
>>>>     put_device(idxd_confdev(idxd));
>>>>     pci_disable_device(pdev);
>>>
>>>Thanks.
>>>
>>>-Fenghua
>>>
>>
>>Hi Fenghua,
>>
>>As with the comments on the previous patch, the function
>>idxd_conf_device_release already covers part of what is done in
>>idxd_remove_internals, including:
>>     kfree(idxd->groups);
>>     kfree(idxd->wqs);
>>     kfree(idxd->engines);
>>     kfree(idxd);
>>
>>We need to redesign idxd_remove_internals to clearly identify what
>>truely result in memory leaks and should be handled there.
>>Then, we'll need another patch to fix the idxd_remove_internals and call
>>it here.
>>
>>Let's prioritize addressing the two critical issues we've encountered here,
>>and then revisit the memory leak discussion afterward.
>>
>>Thanks
>>   --Sun, Yi
>
>The root cause is simliar to Patch 1, the idxd_conf_device_release()
>function already handles part of the cleanup that
>idxd_cleanup_internals() attempts to do, e.g.
>
>    idxd->wqs
>    idxd->einges
>    idxd->groups
>
>As a result, it causes user-after-free issue.
>
>    ------------[ cut here ]------------
>    WARNING: CPU: 190 PID: 13854 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
>    refcount_t: underflow; use-after-free.
>    drm_client_lib(E) i2c_algo_bit(E) drm_shmem_helper(E) drm_kms_helper(E) nvme(E) mlx5_core(E) mlxfw(E) nvme_core(E) pci_hyperv_intf(E) psample(E) drm(E) wmi(E) pinctrl_emmitsburg(E) sd_mod(E) sg(E) ahci(E) libahci(E) libata(E) fuse(E)
>    Modules linked in: binfmt_misc(E) bonding(E) tls(E) intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) i10nm_edac(E) skx_edac_common(E) nfit(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) snd_hda_intel(E) kvm(E) snd_intel_dspcfg(E) snd_hda_codec(E) mlx5_ib(E) irqbypass(E) qat_4xxx(E) snd_hda_core(E) dax_hmem(E) ghash_clmulni_intel(E) intel_qat(E) cxl_acpi(E) snd_hwdep(E) rapl(E) snd_pcm(E) cxl_port(E) iTCO_wdt(E) intel_cstate(E) iTCO_vendor_support(E) snd_timer(E) ib_uverbs(E) pmt_telemetry(E) cxl_core(E) rfkill(E) tun(E) dh_generic(E) pmt_class(E) intel_uncore(E) einj(E) pcspkr(E) isst_if_mbox_pci(E) joydev(E) isst_if_mmio(E) idxd(E-) crc8(E) ib_core(E) isst_if_common(E) authenc(E) intel_vsec(E) idxd_bus(E) snd(E) i2c_i801(E) mei_me(E) soundcore(E) i2c_smbus(E) i2c_ismt(E) mei(E) nf_tables(E) nfnetlink(E) ipmi_ssif(E) acpi_power_meter(E) ipmi_si(E) acpi_ipmi(E) ipmi_devintf(E) ipmi_msghandle
>    CPU: 190 UID: 0 PID: 13854 Comm: rmmod Kdump: loaded Tainted: G S          E       6.16.0-rc6+ #116 PREEMPT(none)
>    Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
>    Hardware name: Inspur AliServer-Xuanwu2.0-02-1UCG42PF/AS2111TG5, BIOS 3.0.ES.AL.P.090.01 02/22/2024
>    RIP: 0010:refcount_warn_saturate+0xbe/0x110
>    RSP: 0018:ff7078d2df957db8 EFLAGS: 00010282
>    RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>    RBP: ff2b10355b055000 R08: 0000000000000000 R09: ff7078d2df957c68
>    RDX: ff2b10b33fdaa3c0 RSI: 0000000000000001 RDI: ff2b10b33fd9c440
>    R10: ff7078d2df957c60 R11: ffffffffbe761d68 R12: ff2b1035a00db400
>    R13: ff2b10355670b148 R14: ff2b103555097c80 R15: ffffffffc0a88938
>    FS:  00007fb5f8f3b740(0000) GS:ff2b10b380bb9000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00005560a898c2d8 CR3: 00000080f9def005 CR4: 0000000000f73ef0
>    PKRU: 55555554
>    Code: 01 01 e8 35 9b 9a ff 0f 0b c3 cc cc cc cc 80 3d 05 4c f5 01 00 75 85 48 c7 c7 30 21 75 bd c6 05 f5 4b f5 01 01 e8 12 9b 9a ff <0f> 0b c3 cc cc cc cc 80 3d e0 4b f5 01 00 0f 85 5e ff ff ff 48 c7
>    Call Trace:
>    idxd_cleanup+0x6b/0x100 [idxd]
>    <TASK>
>    idxd_remove+0x46/0x70 [idxd]
>    pci_device_remove+0x3f/0xb0
>    driver_detach+0x48/0x90
>    device_release_driver_internal+0x197/0x200
>    bus_remove_driver+0x6d/0xf0
>    idxd_exit_module+0x34/0x6c0 [idxd]
>    __do_sys_delete_module.constprop.0+0x174/0x310
>    do_syscall_64+0x5f/0x2d0
>    pci_unregister_driver+0x2e/0xb0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    RIP: 0033:0x7fb5f8a620cb
>    Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>    RSP: 002b:00007ffeed6101c8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>    RAX: ffffffffffffffda RBX: 00005560a8981790 RCX: 00007fb5f8a620cb
>    RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005560a89817f8
>    R13: 00007ffeed612352 R14: 00005560a89812a0 R15: 00005560a8981790
>    R10: 00007fb5f8baaac0 R11: 0000000000000206 R12: 00007ffeed6103f0
>    </TASK>
>    ---[ end trace 0000000000000000 ]---
>
>With this patch applied, the user-after-free issue is fixed.
>
>But, there is still memory leaks in
>
>    idxd->wqs[i]
>    idxd->einges[i]
>    idxd->groups[i]
>
>I agree with Vinicius that we should cleanup in idxd_conf_device_release().
>
>Thanks.
>Shuai

Appreciate Shuai's clarification. Yes, it would be better if fixing the memory
leak issue in idxd_conf_device_release() in a separate patch.

@Shuai, please feel free to proceed if you'd like to cook a patch for it.

Thanks
    --Sun, Yi

