Return-Path: <dmaengine+bounces-5470-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6371AD9B4A
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 10:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5128189B424
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1BF1F4295;
	Sat, 14 Jun 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTWVmens"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336A1F428C;
	Sat, 14 Jun 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749890300; cv=fail; b=TyNi6VKRO/T/28sT5EI05PcI2Q2pNn7VQDnfZbToMz/h523aUMib4yVDMJjJxIcgAVpCTC0adwANOBQR1Z036iWUfAlVlMimmktj9WFH8Xv2O12ALZ7raSBNFia5fZG8sTkWWXGiHJVzM5ZjhVdeK+ssbBNRbTtVFUsE4JCwoJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749890300; c=relaxed/simple;
	bh=KrGwTxEbYiEKHiWb4z7j5hdYsOGFP6Ut4E/pC9tZEf4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t7uuboLDRk0Kq6y4AhlWZQF4mOE1S0agWrORkWga0bN2Wfeke1xHVciSAm5Arbxw0b5Wb72nzAjClb+MpcP1YOyfOHsfPIDdPVvDZ6W26u56ZR/5nhz4d09ynkxu3pqEvMImoLnwVDy3zeRydEfrtgSLoUwzi2s76TnCMV3d+84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTWVmens; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749890299; x=1781426299;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KrGwTxEbYiEKHiWb4z7j5hdYsOGFP6Ut4E/pC9tZEf4=;
  b=OTWVmensARk/MuLaBl0/CqhwU8wSJZdAVbCEFObjzn4rgWm2SC7frQuv
   AdRJwoNPrHluWuWuq0aGfa9e05aFDeAeEbjmtxJ4qxOGs1JSUHNe+jF9p
   F+mXZ94y48Xlc03Z2nGvFBlzFDW6OaKeGyB0HrZfGKztnhfKEkWxv9IEK
   4iuqU7bm8czbybldcDPHdyWhsW99RQoiPD1BjGvQPvTWqFnnZI9gZxVlP
   boS5+4r/Pmvd2D6DO82CIV0VmNwg2+MaTtA0CZ+9Y74rfnEU8mAhr8+NW
   J8CCHbivwSG409P4ahPdbVtQywGB3NZ7Rb+X3PjRaaKxHpRfn93MdcEPf
   g==;
X-CSE-ConnectionGUID: M7KNeiAMRICTmwoK6eC5dg==
X-CSE-MsgGUID: cVcxHyzJQTWjz1nesyOXfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52245234"
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="52245234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 01:38:18 -0700
X-CSE-ConnectionGUID: HdTFmOfUR+qL6HyGoeyVlQ==
X-CSE-MsgGUID: jcbe02VqQaa1thNGnwVIAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="148011805"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 01:38:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 14 Jun 2025 01:38:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 14 Jun 2025 01:38:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 14 Jun 2025 01:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4sVS1Kp1paknsgPMcZvN8hi9S/NZ7qwJTqU3NGeaIZ6Bb1POflYqgnxOJSZuXsvcm2iYy4GX6gDD2H+alvS8Qz5B1UOnrFPIKgCWGV0+anDDiePGztTmT2GkcDZocAnU6Fuz97/q4kIXwgYCxj6lbcPCWEqTc1hNHG7OKsi/J8k2QJ10KL54+3uKxBd2LzPWuuOu7In8BMhHMB4YfX5AfD6ODLDbA9xB80yy4DlVnKK+KHSDJHDsWH6Qh++QuyopWqPty3zvlO5HNX0uSk22UC+RwXtnUnw+stNRvVmI7hhpOsv+RCG3K7MhatnmucJwkGfOnUvTmconVOxGh92LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w77eed+xdyEPaWn/0ISBZsunZyDZKy4EqyVVL4RXGNk=;
 b=UQJgadtkCpkN7z3Fag1/RHTGSuYdn7Akj7Zw1Lf0c2XLS+RLd61UGYqvcD/py2i6WPBSR4O99bFoPLTGH/ClrlwOcs7/8sfwiIZ4tqOCSLZ+9ABLaNC3Yh+D3K3eoIE++jYR0X/mp+vfLc9IaH+67UepRm6GbGKewvA9SEOIhPb77NrcE7l2jZc2cWlTASDjanZL9l8ci76w+GlcJbEd2QoG9EL3Jl0TLo7uNbuCVWWaGJaB/2TnnduRz0rd+ftjsW/9ESlQtnuFhcwr+03bu6yG0Kv4BzEuoXj3lto/LNB8hdtOwSw6n+nciAQaO1fzrXQlgnO2eAk30U6C1SWUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 08:37:48 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8835.019; Sat, 14 Jun 2025
 08:37:48 +0000
Date: Sat, 14 Jun 2025 15:13:07 +0800
From: Yi Sun <yi.sun@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gordon.jin@intel.com>
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
Message-ID: <aE0hAy9peorIdgqU@ysun46-mobl.ccr.corp.intel.com>
References: <20250607130616.514984-1-yi.sun@intel.com>
 <20250607130616.514984-3-yi.sun@intel.com>
 <87h60j8bzj.fsf@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <87h60j8bzj.fsf@intel.com>
X-ClientProxiedBy: ROAP284CA0206.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:10:2d::10) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|SA1PR11MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef3cfd3-3545-4c6b-0335-08ddab1ebde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXJieHlkVFY4bUd0c29FTGFLekdzaG5aTlJhWnNCYlYwZEtMR2VJWDNPc0Ns?=
 =?utf-8?B?MXMzK3BEdllJcnhvVjZIdjhDVjhZeVdXeGJBRVJMbEZ0MWdnc0VYbmo5dWQy?=
 =?utf-8?B?Z2lJd25SanJWdk5laU9YcEVXaWJaSFZ3QTVBdWlEVmhwMTZwZmFKY0Jkc0Vu?=
 =?utf-8?B?YkFUaXduRUh0UGhZUkxlQVdGUEpiWm1jT1p5WEdqcVFyQllXU3N2NnM1cWRo?=
 =?utf-8?B?SHBOMTE5ZmpoZFM0ZS9WajR5Qk4yZmxWaWlaSlpxYUlxLzg0RjAzSWNSa2tk?=
 =?utf-8?B?Q1JzZkNCQmR3MnNMTkZRWlFiWGljVFhsaUw2eldmNzRtWVFFa25tRDh1NmJ1?=
 =?utf-8?B?UHBoTXQ3UWlkUm9ocGhLNkl2dXBDUDBMcEtQWnRSSVg3Z2RQVXBoRSsvNDBt?=
 =?utf-8?B?VndsVHVISnJnUGJ0TnlEZG1oTTBUcm5Ga0ZJUmRpQmpkekZzNTVMazVBeGk4?=
 =?utf-8?B?VDBqSDFocVV6TFpkLzV6RWpDY3VKV0ZKNkVhVk9raVIzM3ZQS1F4TjYxME1F?=
 =?utf-8?B?emtJbFZ2c2pKb3oyNkZocWVLTXRrVVFicmpBbEJDMDYxRkR3Qi9wZVE1L1ZR?=
 =?utf-8?B?QTB0RlZiemx0bnFCQ3RSQmYvSzg2Z0ZXM3BsY3FnMDB1RWpla1ptcmpVVS9n?=
 =?utf-8?B?UnBnV2NLUDhrZHUzbVBFekV2SmJWMHFjdkdJc2JMKzZseWFGVTFSL0VUUkI5?=
 =?utf-8?B?NW9uakxtaEN4T1JTUW5JMWk4cnd3bkNURUJMbkNicGdBd3ozc3pqdXdrbHZU?=
 =?utf-8?B?cDl5MTRGTllwZjRvREFDUXB2RENzVXd2dnlWRE5ETjV4SUFETTh0WnB1UU9M?=
 =?utf-8?B?Si9vNjdubk1uL1lWWVpHUnR3SUpobGhad2F3N0w2cEZZcU1LTjNoaFlZMjRI?=
 =?utf-8?B?VkJobnB1TzZJam1GQ0NIRFJkUmlmOTV0TE93eUJwcVh4RlF0OVhjUmZyUTgz?=
 =?utf-8?B?TWdkYW9xc3piSEpSRnZCUDRZbXkyZHd5blp0dC8zNGlVZzNaYktCTXdZUUtu?=
 =?utf-8?B?RHlGT0JBeVRjdzJNa3p6d2tjTnE2UTUxeEtKUlpRV2lqbmYyTGw3Q2NpUm5s?=
 =?utf-8?B?NE9iVHRvbWpCUk0wYXpXRHRvdGJJdTdMOTNmWE56c0xSMVZwYnQ4UzVhZk9G?=
 =?utf-8?B?TXUrQXE3QlBweSszZm5VT2tGSGlOeW8va1ZHNXVHTlpzQ28xYXp5aGRzczh3?=
 =?utf-8?B?Uk9TR0ZxT0RaRVNpSXZzT3RlY0RubThDN1EzaUFBM3d5ZGlqZXorYmRxOEJX?=
 =?utf-8?B?Ukd0eTdJM216dmFhRW53ZDl3NVRXTXZmaHZ2Q1BGbEJKa3ZjaE1lNzRJZVp4?=
 =?utf-8?B?MEtnY3JnK3BpSHJlTWVuVFVXckYrdHZxbmRUYWRWRG5ZM3RjYXY3aW16TDN5?=
 =?utf-8?B?MGJjbHVLUHBXWjdNVHdjdUFyTGprQkpvMDVIelZSY1N1UzJwZHJCSjBWTVpN?=
 =?utf-8?B?aXZmL1JwTzZUa2FBZkFqZDBBbXZZUmZ6TlNLYkVOd3RaSHZRdkJzQk10cjBr?=
 =?utf-8?B?anRmSy8vU2tPNmtqc3pYUktsbk5xK3dsWjVEcmNXRU13aDMyY2tWcnFxeHRr?=
 =?utf-8?B?Yms2eGk2bFc4dnRmZjZ3VDVGS2VpUDhNdVdZVnRWOGo1U1h2K1R1RVdRa0FZ?=
 =?utf-8?B?REpaN2dnVW9jQzMwMlU4ejZ5THZHdjhVZWR3VHFUWnVnSjBhc3Q0dFgvQlhH?=
 =?utf-8?B?aVl2Ri9Rb2UreVJBUFdoNU95WEgyemoycWlGN01Bc3FhZU14MGgwdUV6STha?=
 =?utf-8?B?Q2JYSHprYy9oMFROTFlFY0cvN2ozZ0V1RHhxK29VN2hmZjBnZUJob2VsNFNs?=
 =?utf-8?B?ZGRHNXhpWWhZeFZxUE9vajBGdmQ0TWVCQ1pGcFlmWUJ0UGF0ZnpuOTF5dEpL?=
 =?utf-8?B?L1ZDWjJKdTlnNnkvY0FVZ3BXNnNWMnlEdkFTaE5Xa2lBT3RkOXhnUG1aYjlU?=
 =?utf-8?Q?PFp4lRHO0XA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkVKcUs1bzVQaXZzSTVFUUZaUlBJZWh6dXlEcVU4dHN3RGs0SkN6Q0tGZUNm?=
 =?utf-8?B?TTFKMld1d3ExSjRnUWRIVXFNNFl5ZEFBdSsyM0E5WWdxUVVMbVZ5NHo3WFR6?=
 =?utf-8?B?a1cwL0ZZeUg3R3ZHbkI0Z0dKcERQN1VmZWNTUG42QnhJb3JFVm16bTlucTBW?=
 =?utf-8?B?Kzc3N09SalR6d3l4Zk5PT0lSNzlqcXZ6cGw4Q3ZkemhIVjVGWHlaRGlxbUhH?=
 =?utf-8?B?WkJJSERzdnYySnRRbDZVYWkyQzgwU3BPTnNndTJERUF3aDFBMW5JRXlKS2wy?=
 =?utf-8?B?Ujd2SWZLbUk4SE5lcmJHNkt0b3lFMWh1d0dsUVlsY1ZYaDkvbExqa0ppZzdB?=
 =?utf-8?B?L3hjRUhrMVowZ0psb2d6R0J3MGg3WUxkUHVXNk5VVkFNS1E5S3ptcC9qM0JC?=
 =?utf-8?B?VjErTUQ1V1pOMWNud0tGZkRXOUF3TDdjL2k0ZUxQQ29aNjhBVEtuVE5NTndP?=
 =?utf-8?B?ZEllb3hKVTZiUWFPOGpGV0x4aGZJYkRZclZPdzMyOTA1MHdHNEY1dUJKR1N1?=
 =?utf-8?B?bkI0MW1BMnl5U3Z0cUxIVHZUZ1BVOUljeURTbitkRlNYY1gxUTh5ZFJlamhJ?=
 =?utf-8?B?Y0NhTUdwKzFOZkFYOTQyaGRzazJvQWpFNk10NVdzYzF5Vjd4RHM2QnMvRHdo?=
 =?utf-8?B?WjVXVDQzbWdrdFN4dFltdklGRG9KcmEzU3UvNUlZenpTdlBVMmZMd1lRSEhp?=
 =?utf-8?B?OTQzdHR5cVJ2R0ZEdVdBbmFJa0ZsbklQNWp5bzhVVW1SdHBVMXZObzY4TkQ2?=
 =?utf-8?B?WituWnJjYXQxa0lidDhBYklhODVnOVpBeElMTGd4dmtGUGgrMDFJUWJ0Yy9M?=
 =?utf-8?B?L25ONjByY3FjNU1HOTFsaTNkTHErb01xVzgwTnE1Wm5vczI1ZzVGQndPRVVC?=
 =?utf-8?B?V05WVlUzMXpyTEtoMWRyYUFwRlFzYTVLc25vNWhwT2I5Y2RGNzhFYS83WXdD?=
 =?utf-8?B?ZjhpNXZuUmJGM2F4UGVnYXYxdjI5OFZvVXJDakNUUlBYZkZ6YVlxMVJXby9t?=
 =?utf-8?B?Q0NQdWVrWWo1VGFXdGFJOUVQd3pPQzFvalk5amdxYnZGWjU0VlFZT0pqMGRa?=
 =?utf-8?B?a3FvYnBvN2YweDdDZDFTLzI2Wlh2d2MvajVxc2ttQXdtaEozbURER1RaZk9F?=
 =?utf-8?B?azFZRXNLcGlUWTVXOUdvaTYxU3V4Q3dOMjR4TzVKalpXU3lscHp2Q2g5N1Bn?=
 =?utf-8?B?dVhpL3E5aEdpTU9QSGQxU2JIOGUxcXVmajFrbUxzanZrenNRSllPSFk5eWlU?=
 =?utf-8?B?RUhmdklzK3pSYS9Bb01pSkV6aTBveUxoZitDTWtoYzk1aER5Uys4bmpVdEdy?=
 =?utf-8?B?VUNic1MzRDJNWWdBeTRmK3gzQUUxVXlNRk9JbXdGWFdHQXpWb0tWWkdIMEpS?=
 =?utf-8?B?bEw5SVl6bjN0UCt5ODNNQ28yRjUwUTh5UXNDZEtJd1V1UjF1ZVFYUTJGQ0pZ?=
 =?utf-8?B?WjVYbEsrUHBKYXZiT0VQMHVtc1NWTjJDcjExRW9iMXpKK2M0cmxqSEtPVjdR?=
 =?utf-8?B?b0hlQmI5REJ3MDNtVUVYMDlFU3VDQkU5b3ptVTNacFFjbXhuTXpWTE9kcVcw?=
 =?utf-8?B?TFFLYlRSR3libFJRSzVucjFWVk1kS3BtL05hOWtIZDV3citEL01QWGU0T2R0?=
 =?utf-8?B?dzdFd0RTa2ZMRDBaUE1TbitUZlhLVExmZ0FuSkhsWEtPb3Axcmd6Y3BTTUhB?=
 =?utf-8?B?K2NlcE1BWTlnN1k5TjB0eUNYbzFwZ2lVVGgzSW5xOUR0WTVZZkFrd3hDSmlL?=
 =?utf-8?B?ZmxhQituN0xHbzhGSVlNWWhJOWNIUUFEQVQvSExDa1FlVUJlcE4vQ01SaGc0?=
 =?utf-8?B?WDVKNVdEZkpzTGVBdXcvTXlxQnFRcFlPVEpLYk1qNDJHckVtOHNzbWsyaWhW?=
 =?utf-8?B?bHphUExwMWtwVnFtRDFmTlg3S3N5YUt5WTdqOVBDazd4ZXZNMjQwQzVRWVhx?=
 =?utf-8?B?Nm9NNHZCVDhJaVdWUEZIb1JmYjgrZkRBaU1oZDRKbVA5TWRVc3ZRaVhnNldu?=
 =?utf-8?B?M3l6Nit0bXI0NkZSbTBRcXFveUFqVzBlWTA0YjdXeGhFSHpNZnlGdEpldmlU?=
 =?utf-8?B?Rk9ucG0vdDRsa1l5Syt4OEM1dHZRNmhubUpvWHgvU3V2ZVNCQ20vaXA3cUV3?=
 =?utf-8?Q?Us5mGPSiK0K9KKPjFXNPXVveY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef3cfd3-3545-4c6b-0335-08ddab1ebde6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 08:37:48.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aR89FcnILXsD3AXO2mBm41jIlv83GEC8qVrvqrJb1jOoLnQR+2PDAbdYO7/I8Ofp9Jq8UqZPbKPK+Yt8qzQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com

On 13.06.2025 16:20, Vinicius Costa Gomes wrote:
>Yi Sun <yi.sun@intel.com> writes:
>
>> A recent refactor introduced a misplaced put_device() call, leading to a
>> reference count underflow during module unload.
>>
>> There is no need to add additional put_device() calls for idxd groups,
>> engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
>> also fixes the missing put_device() for idxd groups, engines, and wqs."
>> It appears no such omission existed. The required cleanup is already
>> handled by the call chain:
>> idxd_unregister_devices() -> device_unregister() -> put_device()
>>
>> Extend idxd_cleanup() to perform the necessary cleanup, and remove
>> idxd_cleanup_internals() which was not originally part of the driver
>> unload path and introduced unintended reference count underflow.
>>
>> Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
>> Signed-off-by: Yi Sun <yi.sun@intel.com>
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 504aca0fd597..a5eabeb6a8bd 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -1321,7 +1321,12 @@ static void idxd_remove(struct pci_dev *pdev)
>>  	device_unregister(idxd_confdev(idxd));
>>  	idxd_shutdown(pdev);
>>  	idxd_device_remove_debugfs(idxd);
>> -	idxd_cleanup(idxd);
>> +	perfmon_pmu_remove(idxd);
>> +	idxd_cleanup_interrupts(idxd);
>> +	if (device_pasid_enabled(idxd))
>> +		idxd_disable_system_pasid(idxd);
>> +	if (device_user_pasid_enabled(idxd))
>> +		idxd_disable_sva(idxd->pdev);
>
>idxd_disable_sva() got removed in commit 853b01b5efd7 ("dmaengine: idxd:
>Remove unnecessary IOMMU_DEV_FEAT_IOPF")
I get it, thanks Vinicius for the reminder. Will post another version.

Thanks
    --Sun, Yi

