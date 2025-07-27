Return-Path: <dmaengine+bounces-5868-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B7B12EC7
	for <lists+dmaengine@lfdr.de>; Sun, 27 Jul 2025 11:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0780318967D9
	for <lists+dmaengine@lfdr.de>; Sun, 27 Jul 2025 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5778B6F305;
	Sun, 27 Jul 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bov5qNIx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9331FFBF0;
	Sun, 27 Jul 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753607807; cv=fail; b=bD7IWuSK103MlcuVNKk6vk/jeNGEKrJ1A6cNxD1Fo4EtaJFJSMJp0byNNF2tgi7i7UB71KxrL4exBgQ/Z74Q1VAtvfFkbDpbsGkXIGdRwjU6wYCEIvj4PqXJI4iyM7nmrBj1a1oqSLCbVzrTYBK7tCksVoQJilDWINM23fhDZ3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753607807; c=relaxed/simple;
	bh=PIDGkMwoq/tVS1HpJKekRCngrf4sc1pNVRd9gv6KKkE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ae7zG9dia4+BoAeXCTukkYoR0yBj0zwqG8lMtzVj20Xz04vr9VyYG39TnKwCVnKLqn9V984XHhYol9Q9Ed7jhrbDWL9b/T56bBCjb039xzYPixz3z8wtIwjlikP8mEc5DclpSGovmlrYG5DAlRTMAUJBGLPYaBMGWTO8CsH6mrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bov5qNIx; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753607806; x=1785143806;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PIDGkMwoq/tVS1HpJKekRCngrf4sc1pNVRd9gv6KKkE=;
  b=Bov5qNIx5fw20zTAcPXZ199tjF5WZDKD4l2ie1KUhdwbXkMjIJyrUlzF
   59ACg4qVcYRr6x/atpHQYWxsTn6eV/svtuk+jO461XAg4iNtPocvG0ahf
   o66dK/tb+uE8de4Ad0LY5icmnXY4t4kyawlgvvDNLVzzfESJ1C96RUjTz
   lV6EEleH06I7lFlKDGx+ThFuzg9gMYrLDUD4BpCH10Tr2kU9Hs4Yj2O/W
   DbGWuZG+cRKaiqIfpbWEfliMKLv9u4aHX6aejisAHBByWxey0EM+Z6bP9
   19tE8BB/WRxHswKGjYmjv3yFVxYTYIGO7wCLLUAMbVH9gkt/4BHcAtgAY
   w==;
X-CSE-ConnectionGUID: zM5NjXEwSSu5MtihqdoRkw==
X-CSE-MsgGUID: 2965GFkTS9iFoCgvBTK3+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="56033223"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56033223"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 02:16:45 -0700
X-CSE-ConnectionGUID: G0nigunvSxSn58lC/EKiTQ==
X-CSE-MsgGUID: 2GJZCwINQzugdbitRD8RcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166195530"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 02:16:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 02:16:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 27 Jul 2025 02:16:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 02:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJMw68UMiXkC97Cw2LHeHliiU6p2hvl5x+FG5qJVPTIls5Xp+47CSf5305UvATha807KBoUpyBfl8+TlYBMJ36gLgpHglfMNh6kH45Wo0A1c3oMCxp5a0VuKKhyGV9Yjb3dguFy+3VZnGYhDd9D7C4vZiIdioON8m8dlT1ONnlo6Imb/SMUK9DJH9XeeZIt5kgvHyGSZznPZxQlRmFVw8Zv/h7zKnawW4puCXWexbFCbBUx9AExq+r1uDeThBn4dKMa1Vcgl7mz1RF92MFsIv59PY4XmJ4PzA0oBQXGdC2nJLtghUW9og/m0YGRNA2ozX+u5BnNwWP/Z63fZIGGqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlhSE7rzkH36A/h+yPrDxS4gmNrFFQSkLXj+G8pT/Hk=;
 b=ELSiwH4QRAwRUm8FjdJ4NaVi3zpZ2cQwt6aKY5ZnhqUGPF5k5K403HCwFaZpMqV286Yd4W+wmXaQ7yJOgXXN09gml0mRa9pNoPe6wa2lwjDeeLcOqpXRktPX4yKoDsfkhDfRqQMYWLYSFihtAIzAK5y2zFH67WmA5tC+enX7FT/TT8BeOhftB98l6cWz9esCBHOlMOe06KJEhJKOfrKuHjrNMx4+BQLY1qBbbjeAQ2ZT1sWqkP7sh5pBEKwfuVUJVBBw3pzBIncSs0iwORmCpxHt09MtJwrIVD0q9H+ZqJ+RpkmYGdZH+HptImTqSIwmTX9BjtT4OsBThi8WKQhZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by CY5PR11MB6535.namprd11.prod.outlook.com (2603:10b6:930:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Sun, 27 Jul
 2025 09:16:27 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 09:16:27 +0000
Date: Sun, 27 Jul 2025 17:16:17 +0800
From: Yi Sun <yi.sun@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>
CC: <vinicius.gomes@intel.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dave.jiang@intel.com>,
	<gordon.jin@intel.com>
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
Message-ID: <aIXuYVtGSV0OHHps@ysun46-mobl.ccr.corp.intel.com>
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-3-yi.sun@intel.com>
 <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|CY5PR11MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 52823d1b-3513-4497-d991-08ddccee4414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGxFN2hwTEZtc1Y1QjcrRXNWckZkQy92Y0JKREpPc3ZDN3QzTjAwU0M4Sksz?=
 =?utf-8?B?eXFpbnlVakNpRElkQkxrcXhUQzF3c1pNYmd1K3czMVc4ckF6KzhiaVUvUnY0?=
 =?utf-8?B?RjJXU2tTT0JOTEZzT25ZUlQ3VVNnSm1KaEJpUkFRanJVS1czSHRGUnpDUlVr?=
 =?utf-8?B?MzhTVkxGZVBFQUo4RjBXbStydWh2M3JGS2xGeTRWUWxjc0xTT2wrY0VzK1VB?=
 =?utf-8?B?aGxLbXRGMGREM2lnSzJzdXh4aU5YVUFLL0EraGREVDBUMm91MDlOdTZlUzVq?=
 =?utf-8?B?Rkt2RGRtZ0Qzdi9qdkk2VjhaZlZyWkt5NFBQOVFsMGk4TTFVaGd0WWxEam50?=
 =?utf-8?B?RnIwNU4xZlFYdFZZMXQ1dGRmMGxqQTdpQUtkeU0xbWRXalRYUWoveFN4bVFy?=
 =?utf-8?B?SFJkZXNyS1NLQWJuTnIzZHpZTllFMGtzTFlUMkExeW5YRHQ3bUVxU0lmVk5Q?=
 =?utf-8?B?VGlPZjFta0s1YzdmUFgwVUczbHBnVlRoTWc5Nklwa29uVVRUSk9UUDBQNFNF?=
 =?utf-8?B?TGJNQXFncjI0N1htNE5tRXREc1VYalJPb1JBaTdKV05la3lVNVJZK2VMT3V5?=
 =?utf-8?B?TXJNSDFDdVhla3RkTzlJVWxKUnVlS2F3RUgwbnRrcXN3a2lJUmY1VGMwU0lB?=
 =?utf-8?B?TWJKL21MOElLRGRobUVta2dObytlcXk1eG5lVHJLaWpRZFlHVmpPc2gzVnVK?=
 =?utf-8?B?OWRrKzl6SnBkNUJVYng3ZGEzNEJucWt4NHRaYTNwdVU5SnY1aVFMMmJnQi9R?=
 =?utf-8?B?UlRaR213MjJpZHBDZTN4WEEyeUlLOUdpRVZlT21XbFlOS1hLYzN1NHVZUmhG?=
 =?utf-8?B?NlN5ekRBY3RiL1Q3em1XdXlsdVF6RnRCUHJybUoxNFJnbzlwMnZRM3JvamVM?=
 =?utf-8?B?OU9RdUppSVBNWjN6U3FhdUhYbE15YnFrMGhZK3BKUElwWjB1U2VKaDRabktu?=
 =?utf-8?B?SnVWWHlOKzV3TldsNUZVTjQrdGxwWkJHTzFyMVVPMG5ia0JrdENJbTFrbFJK?=
 =?utf-8?B?eURyRzMyWkpYWHRmOGRtV2QwT3pmcDNGaGpORWNiMk5IRmtUSlA2Nm1ESlBD?=
 =?utf-8?B?NWdMdFYwQ2dzeHRYNHJUY1N2RmIvdTFLdU5ua2RHbVlxa1laUDZUcE5NY09x?=
 =?utf-8?B?WjRLdFl2L1VDK3ljY1ViblZ3elJKV2ZYRWdsdU1kOStacitibmxzZFpMK0tk?=
 =?utf-8?B?OTJuQ094M2ZvdDl4dSt2Q3ZiNk5BeDBXeXhpYUh2ZTFvQ1paZDFLczdvZTZx?=
 =?utf-8?B?WDZrazZDaTZqaVhnZm4ybXFwZ3l2MEJ6cmpQdDlxOTlLaTl6eFZvQnJwck1v?=
 =?utf-8?B?RGZTQXl6WnVPYXVBOGw2VDF0K1krOER6MDBEaFlEaXIxTkFiWFNqUmV5U3Br?=
 =?utf-8?B?T3Fhc0RIUGEvb0NnZis2THN3OEdRZjRMWmtSZFhHSnJmUkZnay9rNnFSWkd1?=
 =?utf-8?B?MzM0L3pwcG5PblZVMG5EV0xrZlYrSlIydzlmc0ovMUU1QkNWTXZXNGlXNDNQ?=
 =?utf-8?B?dmx3aURZa3FwMDZaK0w5UDVTZEdZbWZsYUU3UmY2dXAwTUh0Sjl5Z25GRktO?=
 =?utf-8?B?RlZITXd3eGZDbXVXOVNBRjdoczFSa3RQTG5WZWRJMGMyTHdrYzBuVEh2K3dX?=
 =?utf-8?B?ZW1pNmVWdFE4Ymd4NzVXQXFPbFZRRUxVRlVlYVBnemhZYkdpZzJpcFZsdHk3?=
 =?utf-8?B?N004MmZRWGJNUXB0Uk01U0dSU1FWNE54QXNlb281MWNZanRHSkdaalp0THgr?=
 =?utf-8?B?ZVF6eGRlTWYxR3U0ODc1d2VENTFnQ2xUN2tjSVA1Wk81OVF6L2RCdDBNa2pl?=
 =?utf-8?B?VEp3dkJ6WUZSMFA3Skt5NGpmRmJYWmQzMzZVVVpyVVZCRmVJUGsvYkFJOVl1?=
 =?utf-8?B?enhmem1NYVBvcmtlbDdMV2dMa3lFeHlmbWFxYXJOTHU5OTZQTXN3S3dyM3dK?=
 =?utf-8?Q?TSoeXZcnahM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5Vb2d2OGlIeDZidW4wNEJXMU1kdE1zRG1EU29HcFQySFovSGk5U0RXSlNx?=
 =?utf-8?B?WWQ4eVl3R1IrU0tQNDBjV21GL2JZTDVyL0o4UUorYXRlclNJTDJSMHJ3bWxy?=
 =?utf-8?B?VVhBNFhEQk1DVithS0NlRUJjUFlFZzdpRWxnS2hHRk9vZDg5ZzlmRnlWN1NN?=
 =?utf-8?B?ZDBMSVlPRk8zZG5ENWx5UXRNVjBXQ0pMemJMU3NoSDBsRURPNFdoNGdoNXZH?=
 =?utf-8?B?VGVWeWJKTFhGTlhDYW1Jb1NPOFpHTlJQUjVNVmZMOWNEVDh0ZEhWVUo5N1NF?=
 =?utf-8?B?bGdaQ3YveUIyNmxxSG1RcFdEME4rVVpuZDVPelNYYis0c3FNRXRCaXFRUGdZ?=
 =?utf-8?B?TWc1U0N3N0VJUHdTeURRTGJXRUtGYVN5L3BNU2pLRGpQZG10WUJqVVArVjZM?=
 =?utf-8?B?aElpY0ZkUGE5T0JaV1BoT2dFNmJzUE9XRVFzTHNvV2dTWFlCN1lSYnVhNjFi?=
 =?utf-8?B?YjVrZXlyam1NY3lpR2xySUVZc2ttK0dLajhDV2hsZVNLWHlmMDRVWDhXdUw5?=
 =?utf-8?B?NDNSRElTOHpBUVZPUUs3ZnlaaTlNdUxmR2dVVzdCOElYREJNa0NQamtxVkp3?=
 =?utf-8?B?WEwxamJaTUErWXVyb2xkck0zRk1xR25QdUZTa0FVcEVnU2dZSno2akdMTDFG?=
 =?utf-8?B?cFQxUzFmS09zNmtGQzNTRFZocGxNbkphaUt1VmRENUhGM09ITmwxQ3c4M0Z2?=
 =?utf-8?B?dmRzQUhGa2prUWRGRTBOcUNWWEkvYnFqMVNWOUpiTCtNaDkxVHlZYUhHK3VB?=
 =?utf-8?B?YWg3ZU13MkJFYkJVOGI4d3NobmZSdTE4dzJCbXNsRUcvTFlnUEorbHFicnBR?=
 =?utf-8?B?cC9LdXZhQVNjVnY0Mk80WHVrVEVBSmJCMEpvMkVxWHUzOE5xUWlpRWN2UWEr?=
 =?utf-8?B?aTVvc25Ha1BsRm5jN2lnMDFkVHU4UlBpUkNhaXpiaExNL2I5bHkrQkxaTEhW?=
 =?utf-8?B?aG42M2N3ZHUyR0xOTHZqQXhXT1EwMG5JcXhvamQ5TXJ2bWp5Rk9qWi91ZXhU?=
 =?utf-8?B?TzNWeHRyN0JiOW5zQzg1UU1qM0tkZnhIN0lSaWNNY2h4d05ibnU1Sk9oTUUw?=
 =?utf-8?B?L3k3UHlBM010YmZseGJNMjFwbnlEVkRpR1IzVDN2U1pYd2pSd0RNc1N6WU1q?=
 =?utf-8?B?K0FxUDVIWkVuSnhEN013NHJUcXNjRHBVZmdRMEczY2toaU9qQkhMSVBzeU1v?=
 =?utf-8?B?cFYxTXpoRjNSMGR0alNxdStKKzlkZjZsRk9XUTNNT09sUUIyMXBJdWdFRkZV?=
 =?utf-8?B?S2tvWTBEVjVZZ29Ocmx3QWVnUU1LNEhqNE1adjk4WHRVK2Zva0RUaTVUN0F1?=
 =?utf-8?B?VmRxNzJFZUQxVHJyVlh5Rmh5N3NIbldhcW85eFRxajA0Z1pta2hRbVZMOHBW?=
 =?utf-8?B?aHIyQXFSZHVuOXFpWDFjZitUUk1aR2Q0dDNiSmNkaDJmVk9UeTdBUHN2MU1s?=
 =?utf-8?B?OHZDK3RYK3YwdGQwQkdTalVnYzMxcnIrNGJIWFRGbHhOeHEyM3F1V3ROTm5I?=
 =?utf-8?B?QUJReHV5b0ZkUUIxS1ROcDJoUmIvRlZ2Zm9UQzlFUitIdXY1dFhwSVFhV2p1?=
 =?utf-8?B?aUZUMkpmbmtpUGI0SFpRNGcwUG5Ka2JtL1Z5L01LRTB2cU5qckVKcUliOFJF?=
 =?utf-8?B?MktRTnZ0WVBoTUo1UG1MNG05ZW96eGlIS1paT2I5aW5TdU5PMFhSK29wV1hC?=
 =?utf-8?B?S2Jhbk45bGtnT1N1YUJOMlZrWHlqMkhhWUk0Zm9DektnRnB3dk9iSU1CZ3lS?=
 =?utf-8?B?eGxPVDQ2dnk3Nm9MTXloNC9nM1diOVdXR2xhSzh5b3lpZG1hUmNkeGlQUmEr?=
 =?utf-8?B?c1FhSTJVVnF4VE1SelJsVjE4TGVEcjRuRXBPNzJsc2lNTlRNMkRUUlVlL2Nv?=
 =?utf-8?B?cDJrUWtlT0xPYWFXNFB5dXg2QStjRE1yMFhiSjdBckpJeUl3ZzNRNzZNKzNv?=
 =?utf-8?B?Q3lxTjVxcFdjeUJzY3NRK280R3YxUDBqQmtSdkxJcXhoSWI0SE40V1ZrcUxF?=
 =?utf-8?B?RTJaNjdwZnB6YmcxcmhwM1QrWC9sNE5LRm5IbzExQmlrQU9ZemVSczMxUEhM?=
 =?utf-8?B?akNxdmlDV1EvQk1xMzArR0ZXaVN2Z0lnOHVTNlcxb1B6cHVjSU9ueENheGFN?=
 =?utf-8?Q?XIe0flbYxZ7PiSnNJ5Ihpuzdj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52823d1b-3513-4497-d991-08ddccee4414
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 09:16:27.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4yNNM4oWH2SWFeWSbx1hNMN4s6CdRZ8mQHp8IAvmB7+yD2Z0FrdhJWuD0RinzyxuQob8OsMvzIlfLP2eULf0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6535
X-OriginatorOrg: intel.com

On 17.06.2025 14:58, Fenghua Yu wrote:
>Hi, Yi,
>
>On 6/17/25 03:27, Yi Sun wrote:
>>A recent refactor introduced a misplaced put_device() call, leading to a
>>reference count underflow during module unload.
>>
>>There is no need to add additional put_device() calls for idxd groups,
>>engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
>>also fixes the missing put_device() for idxd groups, engines, and wqs."
>>It appears no such omission existed. The required cleanup is already
>>handled by the call chain:
>>
>>
>>Extend idxd_cleanup() to perform the necessary cleanup, and remove
>>idxd_cleanup_internals() which was not originally part of the driver
>>unload path and introduced unintended reference count underflow.
>>
>>Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
>>Signed-off-by: Yi Sun <yi.sun@intel.com>
>>
>>diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>index 40cc9c070081..40f4bf446763 100644
>>--- a/drivers/dma/idxd/init.c
>>+++ b/drivers/dma/idxd/init.c
>>@@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
>>  	device_unregister(idxd_confdev(idxd));
>>  	idxd_shutdown(pdev);
>>  	idxd_device_remove_debugfs(idxd);
>>-	idxd_cleanup(idxd);
>>+	perfmon_pmu_remove(idxd);
>>+	idxd_cleanup_interrupts(idxd);
>>+	if (device_pasid_enabled(idxd))
>>+		idxd_disable_system_pasid(idxd);
>>
>This will hit memory leak issue.
>
>idxd_remove_internals() does not only put_device() but also free 
>allocated memory for wqs, engines, groups. Without calling 
>idxd_remove_internals(), the allocated memory is leaked.
>
>I think a right fix is to remove the put_device() in 
>idxd_cleanup_wqs/engines/groups() because:
>
>1. idxd_setup_wqs/engines/groups() does not call get_device(). Their 
>counterpart idxd_cleanup_wqs/engines/groups() shouldn't call 
>put_device().
>
>2. Fix the issue mentioned in this patch while there is no memory leak 
>issue.
>
>>  	pci_iounmap(pdev, idxd->reg_base);
>>  	put_device(idxd_confdev(idxd));
>>  	pci_disable_device(pdev);
>
>Thanks.
>
>-Fenghua
>

Hi Fenghua,

As with the comments on the previous patch, the function
idxd_conf_device_release already covers part of what is done in
idxd_remove_internals, including:
	kfree(idxd->groups);
	kfree(idxd->wqs);
	kfree(idxd->engines);
	kfree(idxd);

We need to redesign idxd_remove_internals to clearly identify what
truely result in memory leaks and should be handled there.
Then, we'll need another patch to fix the idxd_remove_internals and call
it here.

Let's prioritize addressing the two critical issues we've encountered here,
and then revisit the memory leak discussion afterward.

Thanks
   --Sun, Yi

