Return-Path: <dmaengine+bounces-5473-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED9AD9C8A
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 13:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF9B18958F7
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6D2C08D2;
	Sat, 14 Jun 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwbLS/iJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46227BF80;
	Sat, 14 Jun 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749901306; cv=fail; b=C0ZSLLejxQEeybrQxBjWUK1T+Ux5XepTLCCLfdJm7XGvjAdyU/JG7NsEZakqKQ5ADMWJusWM5Tj/pAqIU7+m7W1KZHIcjp2CJV+zmzYCBaUPpQhwC94I1WC0HCkg2daVCf0xWCsGa/v2adazFknREuNpXWOIHIGzWDHt79OjNkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749901306; c=relaxed/simple;
	bh=x7MJ60hNWo3nG4ddeSTVH6FhNX/QnJfxyR/Mj00Wn04=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cJiVTnXKhYF3rDNCp2FNrqDH+S01alnfWh4LdP7gCyte+8pCr7pa1oycvBgj1S3639S8k01RdXt6PQlCyucYpraBlEwG6uVAUMEAK5Z0QIbGV3S7s4qp5/znFsMTz1lwEciU1PApRbMG6VMBcPlEWoW+k3uY3nOJswy86oStcHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwbLS/iJ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749901305; x=1781437305;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x7MJ60hNWo3nG4ddeSTVH6FhNX/QnJfxyR/Mj00Wn04=;
  b=cwbLS/iJsZd/TxSJ4zAB7EIavP5ILcalPT92wNIytXSuQqQ2791WcONf
   xqkpRQPD4+AImmHA8KxspEUiTSTeJBqzkiFydUhlLblOHMMUkCENfiGVH
   AZ84XTTV1OUf4ljOWRG2KXSbxAYdu+ZZUSW6VJxYC7+7QgdXxXnmInX9g
   nluq/e2asjkIjDB8ol9dekEYveU2dEF2JuZbymyQaPu7EEwHRE4lmpu1t
   VEkAxHPBbhWWoIYhm0Gt1Uy7FB5hZiLw0egi8SpsDGvvzn75w+M/znNa4
   tiKbHikpglUOU6qqnLNd0kO7Lkeh8BAi4UoKr2miTrhKZ7QaulX90UPxh
   g==;
X-CSE-ConnectionGUID: dE4UWPaETcGpyCIMp+iibg==
X-CSE-MsgGUID: Wbk7mt/ZTceBvsXdmWB0Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="51982078"
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="51982078"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 04:41:44 -0700
X-CSE-ConnectionGUID: v2hr28xvRQitQpd05nIeHA==
X-CSE-MsgGUID: XvgKH1nkQQuPx27H0Thq9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="148951610"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 04:41:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 14 Jun 2025 04:41:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 14 Jun 2025 04:41:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.88)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 14 Jun 2025 04:41:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHxVkY9HAHVj0fL/YVLqkThyxJnrl5ou4URrsKP0mCIWYG5l2m8gvb60nFoowGC/X6XigeDsb+fHAZTUsZ5Xsx03pNgEHSR7h26sKx/8Z7RHDM1WsLhyXR7iPN0UxUjLe8ea0F8frEyroumfbHFR4gLTI5gfR3OmkO+P4ug206EoXo0aQLunMhjpB78fU+IuBtRzFGVYpPBPqlwL6Y6JPDuGo/eXdJ0d6uuUDw0/5ydXrMSC6lixcmo4dftudO7MWiKQEDcXQYFY24dNb+xGT8ehDt4xRDc1LBy1mdt5afD6CpnKdW7MyVBWB5O9AkvNSPTpG72lL8JRbC2aCWxv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeQ4QiEN2BNY6T/HvgrGs6zRfuz/Ro4v6OAEEsMeDSc=;
 b=CImgfBqYqWw82E5eZ/mijr7mhwmNqCkJtmV9lRfFI0aa1ZLtl6DfXr3UWu7xov+ALh7xwoe4Knf/EB3qzMvtb6i7/BJLbyAc6WaU5oyGL3S/rGmUX9sVXQn3ey6mZcfB6wUx+UtQBWgcjTil3TBXZiZkYT4FogzYFBAhGojHGo1Gb+YV4o3BuEZ738WjORbGMw5/UDNklBSrmdY1ey4MVYWoTNiDc/39yhBWiwmhuY9DBcxqLoyCv+h4NTGo9mEP/SNr1nGa7dASKLxN0fsqNrI6PpfNlh3AujJ4j2UPYGdxgHYT2CH2BTqRNa2HQ4Dt2mjh3MOJeYOkdnj8uzIPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by IA1PR11MB6371.namprd11.prod.outlook.com (2603:10b6:208:3ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 11:41:22 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8835.019; Sat, 14 Jun 2025
 11:41:22 +0000
Date: Sat, 14 Jun 2025 18:01:28 +0800
From: Yi Sun <yi.sun@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <vinicius.gomes@intel.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gordon.jin@intel.com>,
	<fenghuay@nvidia.com>, <anil.s.keshavamurthy@intel.com>,
	<philip.lantz@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through
 sysfs
Message-ID: <aE1IeLwIovqvj4KV@ysun46-mobl.ccr.corp.intel.com>
References: <20250613161834.2912353-1-yi.sun@intel.com>
 <20250613161834.2912353-2-yi.sun@intel.com>
 <50e151ed-af26-49f6-86c8-ebb7b1ad43ca@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <50e151ed-af26-49f6-86c8-ebb7b1ad43ca@intel.com>
X-ClientProxiedBy: KU0P306CA0061.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::14) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|IA1PR11MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 73678bf5-d75e-437a-b455-08ddab3862a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3JBMmNuSGIwZkFraUkwOEFZR1BYa2hXZEJhQ3RTRE1FMy9PdHpWbGdkRWVm?=
 =?utf-8?B?Y21Cb3BFVHJQaHA3YnNLQ0dKYXRZRVJ5RkJza1l1cGVNc0N3U0h3TFBvWUwy?=
 =?utf-8?B?OExxK1g4UjJHdllxVCtBbUFGY2kxTEVBYlBRRWE0M2NCQ2JHYXBTNjRwVUMr?=
 =?utf-8?B?Vkl6V3VzS1pYSThmUWpFellWZ2FxYmticlJ1SVFQblBucjdiUUZJdFRQRm80?=
 =?utf-8?B?c3g4UVVGd1VYR2xGNU16TVpLTndJenZWdkVYb0pSQUxZcjdjSG9QQjNYWlBZ?=
 =?utf-8?B?TkNUaUVGRmNhYy9Cci9HZCsrVU5lQWlrZWs0cWNSZ0tuNTZYMjgxVWRKNkJs?=
 =?utf-8?B?Z210dmlSTUN5cjM4Skltb0VjRXlQalZMZE5tL2Z0MWx5cWd4ZlhtcnE1RVRG?=
 =?utf-8?B?SFNBcjNIZ1VvdHpNY0UzbnVUZXJUM09HaGFiV1ZRL1hJWGlIcWxNU05hV0hM?=
 =?utf-8?B?OTJGcExRWGJjTzVPM2kyWllzRTh4OWNrWjI0eHlhallZT1J4S2Fkekpwa1dt?=
 =?utf-8?B?T0pOWk1ndkNYMXRjRUlJV01IUDFXSm5CUHBTa3gvcGNnNVlMbVYwcnJCSWF4?=
 =?utf-8?B?bzlDRmw0Z25nRlpndDRjQTJSRHdUT20rb1ZnbFdoWS9ncjhlbWN4dVl0cTQw?=
 =?utf-8?B?N1lRck5Pb1pPcndaN3VUNEV6dGdqVWhTK2VjZmU5c0pubWJ5WGZ0RmxpeDIx?=
 =?utf-8?B?Qmx2ano5cU9FZEVRZkFEVTdsN3p4b0V2MkN3MkIwbjhOSXFTZmtNYWVBR1Uy?=
 =?utf-8?B?YU43THVGVlh0a1dzRTZEdkFzQnkzZFY1Uk9qWkllK29uSGVNTzJIYTR2aGRy?=
 =?utf-8?B?a1BLbGtlaEt4UVY5Mlk1dml4M3ZCY1lLVythc2JZREZXYmhxNUdHY1l6amd4?=
 =?utf-8?B?Q2oxRnZ4V041ektaQVRMaFBxTndsRFFGUVN2L00zT3NoNVVKT1dqSURranRK?=
 =?utf-8?B?SENWMGpBYUdjWmI2bTczemRkcnNiSldJOHRQSnhmRmtQbDliVVp6TkVZdnpF?=
 =?utf-8?B?dS9tVEV2K3B6NE83V1pxSVFZOG1nSWpRKzQ3SzZ6UWxQcWRoZ1NPSlA2QkVo?=
 =?utf-8?B?czRKb2JYSldZOHRKUlFoRi9xSS9VaFVtLzVpeDQ5NThnd3NGL0R4SitFZGxI?=
 =?utf-8?B?VGxFTjg1alA4T1Y3UlBNbm0xWi9ya3hGbkFQVHNJeTlNaW5QVmZXYkw0d2d5?=
 =?utf-8?B?OUdxc3gwb1pBdHZmWXJNcVVJUUY2MzB1OEFMUVhGdXJlNGMyVzVKMG5xN3U4?=
 =?utf-8?B?b2dLWXhKazlRemRQZnNFQXFmd2c3d3FZVi9aVzNSbjVYbWZWNlR2STFQZnRk?=
 =?utf-8?B?am1CN1Q1aWQ2akUvazYzZUY4aUdQZDUraVFZaWsxSU14OXBoNVduRm1Ta0ph?=
 =?utf-8?B?QlNuN1hzWS9HTks3TjhtcGtBNFNiOE1IZ2JmZXJrQktsQ3dYUzFvUkdWblpk?=
 =?utf-8?B?SHJYY0JiV1Yzd2lreXVRTTVyaFFsaVYxWC9hTkZ3THdWcGhXSjdiVlZMWWVF?=
 =?utf-8?B?S3ZHdzQ1elF5YmJ0ZFFETnJUUEIxM0JyRkgvVlZVMEpDOWxRV0NtQjJheEln?=
 =?utf-8?B?dldVWlVUMmp4cE9vWDBQK2pRckRnd0NpdnUyeU5vQlBDWEJHd2Q2b25uZzRw?=
 =?utf-8?B?bWtCNkpuZ3hHSzRXSlYvYUdRNTQwaU5zWVpDcW96MWVGUTNWZ0VjaWUyTGc4?=
 =?utf-8?B?OHZkRTc4TklhMGZzZlo5UTU2MVVqOVNGVFhWbUUvUW4xVEpEbEhlNXdoTHFi?=
 =?utf-8?B?NndhdXJiZ0lrMVo1cjN3cUpESFUvOFpFWUgwZjNKcDlHWWdoaWxaZEQ3enIv?=
 =?utf-8?Q?fOvP4wR/FrHqKtL/RdKO+T/QiOP5LKK/HgwxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0JFNXYrejRwS3hrUUZSeEEreXU4SGUzSHpybjR1Q01QanBteE5pRzhxdnlZ?=
 =?utf-8?B?OU9KTGhhUGphTnRxWlB5Q3ZvUWI0bTBTTTNBY0NaZXIwSStuckxrcjNmQ1B0?=
 =?utf-8?B?Zzlvb2pjbTFBZkI4OExjeHZhQ21FY3pHb00wM2JmbmJUZWROUDYvY3MrY24w?=
 =?utf-8?B?NmFPbmZndWxib1d3VWJPRm4xd0VsNlovanhpYnlBZXh1cTJid0ozMDQvNnQ5?=
 =?utf-8?B?SUV2Vk1sOTFQNkFjendwc21WNm96d251SUkyRkw0MzhjYmVSL1EwYlZpRlNY?=
 =?utf-8?B?SENDNXVTMS84NW5mYVZ2VU9UZXRUeXJJWnNUU0o1SndVVjZ0azRhODJoZ0xD?=
 =?utf-8?B?cjVlOUtiRWY2cU1janhabkRQaXVCclNuN0dxWjJqeVBvWEc4WGRLOTlKYm9O?=
 =?utf-8?B?d3JlVHdyLzhyeUtWaDFDcEJWQ1YyeWdZdmdZVDB4QjNYTjd5MG1PSGNQazd4?=
 =?utf-8?B?bGsydEpzUXhWWUJuTnh0SlQzQURwSlZrU2VINSthV1VUaEhxZjMySlA0V2dv?=
 =?utf-8?B?Rk9iZ0tJNW1wbzJ2L2ZNTEJndCtjRVdPYmFzUHg3eE9yRncvTXdxSDRxNlk1?=
 =?utf-8?B?NWRjbHY0N29zMlF0VmtReS9la2VtN0NQUnpLWjBCdFcyY0RmZVZTZWh1Y0JP?=
 =?utf-8?B?MkVEL09Wc04yei9oKysvRURZM0NtelNLNnZ1QTdCUjN4OW9wdm5TY0F5RXA2?=
 =?utf-8?B?TlIwbXpTL01aOExHdjB5ZCtlbnF1TXlXbkJqcmVxcTFuZjRsSEQxUEtNV3o0?=
 =?utf-8?B?RDhQTGl4VVhTWDZlenhzZnhHeExPSWQ5alg5K0NGc3ZKZVNnN0d3bVVueUc1?=
 =?utf-8?B?OVF6dlk3Q2FFeEI5UlN5VUNiWTRKRjJqTTNScnlzTEFxVkNYUzF4U1d6N0l5?=
 =?utf-8?B?dVh3bDFhODQ0MEtBSkc5SEQ5VnErMnJCMFU3WnBXS1ZoTmR3SWhnMlBaUDlq?=
 =?utf-8?B?T3RWa3dZbTNLNkJBYnNEbnltRkd6OUIzZFZ2clhlUjFvSFQ0SzF5bW0yV2Vj?=
 =?utf-8?B?R1BRWnd3L3hHWHBZa3h1T2FFL3Jsa0Q3QUFBUjRJU2hmcXNUbFBiVERCVkcw?=
 =?utf-8?B?L01QeTgyQWs4Z0ZYYnJwLzdqbzRxaGs5SFYyOWJURktCSlVrT1EvN3gyOHF2?=
 =?utf-8?B?Lzcxem5ENkprekh6dlFQS2lSTUp0b3ppZDdZdGZ6bVFYV0d6ZmUzVHBCSjd0?=
 =?utf-8?B?SjZkMTJRekVkVlB5VXBMN1ZiUk9RSHdBNGlEK3g2Z0ttQUE0UnFmOG05cFY2?=
 =?utf-8?B?eEphZ1d1N0puOGY3QXVDZFplNFhXdE1CSElEaVZWUTBnb1IvTUJBc1ZuWkhO?=
 =?utf-8?B?eVNJckg0U3I2cEZXc1BwRDNsRTdGR002UDBhbzc2NDVieFRXaEVBYVdJQmtK?=
 =?utf-8?B?cFBsVFdPblBHV0J2VzJzRGVuYkF6ME80ZlAvM3VvVEo2MW0rNDEyUjdWZUJy?=
 =?utf-8?B?ai9zVEZPMWZ0Yy9QL0JxNUlEby80UUEvWTE3SDQvMmtNeUhrcVVia1Iva3RW?=
 =?utf-8?B?aWx5VzBScEFMNS9CdmJ1N1pFRFBXWUdrclhtOUYvRnZpQVRTR1VOK0pWWHpS?=
 =?utf-8?B?Zkd3SHN6S3hTcitsL3VhbWNTTHZLeUY2QTU5ZDFlUW9HZmUzTGxJOE52WGFG?=
 =?utf-8?B?RFF6bG4xMnVWSExpM1dPZjlpbEFqMTJia3Faa3RxYWhTc0t3bXoxR2t1OWdU?=
 =?utf-8?B?ZFZxRXhld0R2QkdYUTd0NjZzK20vY1piNXpDMzEwVDdzU29UM1VycDNjZjJO?=
 =?utf-8?B?L0VNR0tHaGl1RGxtZXVIS1hvN0NGTUVic1owTjNkYmZPUWpjNEtYK1VIK0VS?=
 =?utf-8?B?a1pObStaNzcyQ1BKQVVtYkU2RzNUSzlrSXdQZ3U1ai9DNWd6dGdWaUQrbnlC?=
 =?utf-8?B?aTZCNTNJVlArWmw2TmhRQnNBR0l0aVZCUnR2WGZPMG54L0g3aEFDa203QzBk?=
 =?utf-8?B?SlpDM1pTaUh1Tnk4OWVsRFVFUUc3RUl1cXNLbXpVcUs0Y3ZrckFKZ1J0UDhq?=
 =?utf-8?B?Lyt2b2Z6RDJlUDBKclRXQW9nSFNuWVJoTWZGOEp1S01DT0dCek9LMFJJVUxm?=
 =?utf-8?B?WUkxZUQyUjdzR3FSMTkxeWp3Nm5WRmo2QmlMdGlKVnJLdGU5RGtkblR0cnJu?=
 =?utf-8?Q?7AqDH7RzLmg/C6YYHqFbDDKg+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73678bf5-d75e-437a-b455-08ddab3862a4
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 11:41:21.9443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sH2Emthw7mBpzFBRaOuoGC7OSyIw0jftMuJxjJjv+5sRpe7EApnCfXqmmhZfU11ZLEA3CcnFNQ8Bz8bCDkMzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6371
X-OriginatorOrg: intel.com

On 13.06.2025 13:59, Dave Jiang wrote:
>
>
>On 6/13/25 9:18 AM, Yi Sun wrote:
>> Introduce sysfs interfaces for 3 new Data Streaming Accelerator (DSA)
>> capability registers (dsacap0-2) to enable userspace awareness of hardware
>> features in DSA version 3 and later devices.
>>
>> Userspace components (e.g. configure libraries, workload Apps) require this
>> information to:
>> 1. Select optimal data transfer strategies based on SGL capabilities
>> 2. Enable hardware-specific optimizations for floating-point operations
>> 3. Configure memory operations with proper numerical handling
>> 4. Verify compute operation compatibility before submitting jobs
>>
>> The output consists of values from the three dsacap registers, concatenated
>> in order and separated by commas.
>>
>> Example:
>> cat /sys/bus/dsa/devices/dsa0/dsacap
>>  0014000e000007aa,00fa01ff01ff03ff,000000000000f18d
>>
>> Signed-off-by: Yi Sun <yi.sun@intel.com>
>> Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>
>Would be good to provide a link to the 3.0 spec. Otherwise
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
Sure, will add this link:
https://cdrdv2-public.intel.com/857060/341204-006-intel-data-streaming-accelerator-spec.pdf

Thanks
    --Sun, Yi

