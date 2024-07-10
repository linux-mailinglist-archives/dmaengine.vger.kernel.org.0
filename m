Return-Path: <dmaengine+bounces-2671-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE7A92DCB0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 01:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548CC1C20D42
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 23:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29575155A56;
	Wed, 10 Jul 2024 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBZzcw2L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021DE848E;
	Wed, 10 Jul 2024 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654754; cv=fail; b=nLgp6kymZjJmdb6tA21Ln7mKxyKJ8hfXbq9iUB/vrWOwueQvAxQVfd5mxo6VyYH0iTzighp5ZG4RKcrCsA8NQget6rJWB+xHleyeYIbawIFsh/yqu4VsZ43PIbI9FDxlzIeZEyCeMLckFTAdITT0jk7Xee0xYd8siEw2ns837+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654754; c=relaxed/simple;
	bh=3xPFuW/aVxPtRkyUWzqnZrJ9pS1wohyqsUurd3wMbTo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BjjapElhIlNRTl1P+IcJ70wB8ACvtHy7ZANfOmR4Zu/9quj1SKclPFqUDEZ//g+jBQVVW/r6+RYrdPQekQs1coMFDTNj9D4+o9IV+uUWKyjS49ITJxVJd3sfAxvSjRfreHOd+nzcELDeTQV7hqIjEwi7LrSCYGmhYfN+4T3S2ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBZzcw2L; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720654752; x=1752190752;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3xPFuW/aVxPtRkyUWzqnZrJ9pS1wohyqsUurd3wMbTo=;
  b=EBZzcw2LEf70GIRpN3R05EgA70xUkc0hUjqP6c2Z+6lZ0p608OTrTQAN
   I0hGtX8pJRwwGI0NEagAjzUqRaL3eYT/540n6RpXR4bcZ+ju1lcWuIx2F
   DaIZpFh61FiUJTGm4YWEw7kOJcEq7cTGTrOPmW/LkIszAf4tl853b6Uq/
   0XxHbhuZJcBawTzoXWTifeB/Eb/hW1VeGFpSFONbbts3iMATp1bAg5nHs
   jCddABDSFIU5/E1Fe45ULzB6y2QR+rQuSvst3Ios7g3jFbnUzkCntmij1
   wQpQTyFb5Tz6rxRwZGd7mP2AQVn0hiLGIQ+N+hx6ZKFy8tPJR5wEvdtpx
   g==;
X-CSE-ConnectionGUID: 6Q5g0iTsRcm18vReQi7F6Q==
X-CSE-MsgGUID: A0r7ulxeQUWe1/plrQGZ7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17849928"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="17849928"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:39:11 -0700
X-CSE-ConnectionGUID: R2r6kwrXTK2g7kWHs5IS5A==
X-CSE-MsgGUID: sbQRptgSSY2x+rktIt0oRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53194182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 16:39:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 16:39:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 16:39:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 16:39:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqBjFxgjlCNS/pzNHyW9vU4Q0uJtDMpf96QoMpjxkIX/YuF81LbJVnsSotzsi3TqlrI3yJDfVt0zZf0GAYe2aRQM4ARrB7ydLGXezerUCNCYUX/ngSJo3u20DpsqbUOoEJVzAGFZ+Pv9WdaTaAnIPhpPaEwuhno6KO3ZpONlT1h2jFczUYKwnay2sylK1EIBrCHMSj1iQcFDuTBOK5Huq8DwPlsxedKqB/8wRJ4JJA1aYrmj/QLieOb2wAj5HaIXdd74KZjWX4J7f+KsMfS2yvn7+5fYm3iBJLfXvTUXUzL5N8HVpYjLPoAM8yCHP7HYggizodujOFQNimdQq9p7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vl1erWUYm6rF186PuYqgwNf8dUrWFivyo+ozfL2wC8=;
 b=lM7B13EgZ2Q2Lc7nbFjdJtrTDTfOzNApUpgZH7bxs7M1N+s9nxhBI8ivlcviAldDOk+h+/iQHAO8ZOpPQGQh/zvoqzdS31k0tdWKqKh7pkZZRYPP96x6wdpxo2DsgA7GbEdtyBAgdt7CXyu4IwhaZ/RBFmL5sO/8iDSEdOeKUcNxpgpJEG/9+Ypkcns/NNQ5v+n4yWWLUPXuk+2tlIKzIkXinsGHCJ5ietQDMrvf6wJnjnWADFCcXa3b4xZ0t5ZQ4SC2jfk5x5Uhk6NoXfB7Tps3QcP3SZC+bXAIdXh+gwVW9+EFYZsCtRE28pP/exjD5l1XBxPMLb7ENQ71ksUJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS0PR11MB6352.namprd11.prod.outlook.com (2603:10b6:8:cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 23:39:01 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 23:39:00 +0000
Message-ID: <24079077-ada9-0150-e542-0002ae3e9b61@intel.com>
Date: Wed, 10 Jul 2024 16:39:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Convert comma to semicolon
Content-Language: en-US
To: Chen Ni <nichen@iscas.ac.cn>, <dave.jiang@intel.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710030725.1960882-1-nichen@iscas.ac.cn>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20240710030725.1960882-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::31) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS0PR11MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b77bc5b-8bdc-4278-882a-08dca13979a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0pXczNiZ2NvY29yQ2JiUmVNRCt2eFVQR0hVRFAvV2pLRytZYjRBL3ZXbGc4?=
 =?utf-8?B?K01PSmlpZGQvZnpualJRNlU2T0pyWklmN1JHWjJVSGczVnp1QTFjN0ZPcmZj?=
 =?utf-8?B?QkY2aEUvTHk3RmYrQU1vaWJxRDNTdDRIUkpWeWcvT2ZlUGJJUkdZMHU0VE53?=
 =?utf-8?B?eVlYRWJuN0NkRWpWWlR2QTZZclBwb1B2ZURKUnIxb3BjZmN2UGUwNlJqUjdS?=
 =?utf-8?B?L0t2UEtoMHpBTGJEdERoQVdvaHY3Yjk4S1h3Q2pRclVaU2plQjJVaGEzY1F1?=
 =?utf-8?B?YVZUZHZYUWxVMG1aUXJkVkpZZEJzSG1JamRUYUJnNFJLVzcvYjFkYXBHb3Za?=
 =?utf-8?B?ZzRkQVQyRXZnanMxd1BXY2Y2blVGZDRKRG5wZVBiL2ZXb0p4SHRZSm9yTW1S?=
 =?utf-8?B?UTROa0pvWlNJYkJPL25LRXFveVMvRnJ5ek56cm5RQkMzL2lpQnBadE03UHVh?=
 =?utf-8?B?ZEhtaHFsVkF4QXF2c1gydkFBMFdhOXVEeWxmSVZacmhqYWRhOWhYMURzQ1RI?=
 =?utf-8?B?L0xTQzFnd3k2TlM5M1BWVVNRZEFTRVg0T1p3QUU1emh2dlY0M3kvSmpEOThJ?=
 =?utf-8?B?blpOQk9UYUZDZmEwbWs0RzAzZWZjWGtNaEVVWktxQXl2YmduSWl2a08yV0J1?=
 =?utf-8?B?amRrTUZSQjA2VVE3QmVPM0NDNi9zQTBJaXFTNHRxTXR6M215dnRrQ2RNWGNT?=
 =?utf-8?B?Q2pKR1BoNlpFd0tqVWllQmE2UU9yT2lNT1ZXQ1BpUWxLZElQRXV0OG5lMmkr?=
 =?utf-8?B?Z3IxNGFDK1dtRDNiaGpzZWUzYzhHM1A3dVdiMzFzRG5FWWN0OE12VlduZUtk?=
 =?utf-8?B?OUhJSFZrWTdKbEIvVnVJN0dMY1FGOEFOOGxnZEI0UHRaNUliUFI1ZG5ZelFk?=
 =?utf-8?B?YVN4L1lRV21xSUdkMVdTS3hpL0tjMWJEZzlMUDMvcm9KckNSRmZvc1UxWFp0?=
 =?utf-8?B?THFEN1RuVmRxTW5aMm9FRkRlMndZNlVjRVdUZG8wY2NPV2pFK0tPODQ3aFBW?=
 =?utf-8?B?a082cU1pU1hPcEZ4R2d1Z1ZNRFhZamN0VnFtcXQxeVFkSXB2S3l0WmMzNTVG?=
 =?utf-8?B?cWpZc1h4NzdQOHc1VEVXYWtJbmhPMFZ0cDAyZ3A0M3BYeDhxSjVwRTBYbXA5?=
 =?utf-8?B?UUdqOUpZaTV6R2RMZFU4Z2lWZXlsZVUweEFIUE01dDcxVzIrekJ2dTVNYUU3?=
 =?utf-8?B?SlVpUzY1dytCUmt1N1JoUjgra2F5Q3UrVGdVUUZtZ09Rc3lWN3d1Y0FFNjNW?=
 =?utf-8?B?dFJaaTd0RWladWJLVC9SZ1I3MGMyRUFFaC92WUtqM3Q5TXJRYXVXWU9Fd2Ux?=
 =?utf-8?B?ejhnaHE5WTNsVjc5TXp6bmFLYmJwQndMSkQzNTNUQ2Q5WjFmbnR0WUxMR0V0?=
 =?utf-8?B?ZUVXMmlFL2s5bDQ4eEdKOWZFK3kwTThqRlNodTBrV3VibDdpRWtmMS9saXps?=
 =?utf-8?B?dUlrRlFqM3gzdU9pakZvWUd0T2ZYbVhXZ3VyMzVvczJUYWhsNkJYSTZkdHR0?=
 =?utf-8?B?cFJ4Ti9ENTUyWmFUQWYrZ0RueEJrZCsrNGZhUzhtczZtbjFNR3dqTjA1N0k4?=
 =?utf-8?B?eHh0SENmSENESUxrd3pHRTVsdm5ETm9WS01FdVBKOUdJT1JjZHBBT0FkSXNG?=
 =?utf-8?B?aWN4Y25yTGF0bkExZTY4enFpOUs5T1NpN0VScjVUekM2aU9oZzZ6NEE0M3M1?=
 =?utf-8?B?L0Jha3BYOVh4b0F0M205KzY4TU8xNHVwUW9SckpHeVgvZTBTQW1nalp6ZzNQ?=
 =?utf-8?B?ZDExUFdmZ3FhOFY5R0ZhVEZ0SWlwOWpXZm5DQ1pZbDFBZDFic1haQ1RzQ0pO?=
 =?utf-8?B?UEUzK0k0REo2ZjJkY3dLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE0zOG1ObFVtSUpKVndNVXBVV1NVRFRrMTdZU012V0t6WXpMWFhYd2V6WFR0?=
 =?utf-8?B?UHhmbjRJWk90aEdTMXNiaGg3M0dxVXVKVVJuYnMzcmJlMGhlbWRZOEpXbzhR?=
 =?utf-8?B?cjJIcm5HRXduU3prQ2prOHIxeDR2Ukt3dDNuOUoxUDMxOEFkYkxyM25oUGFa?=
 =?utf-8?B?Wk5YTHVueGhaZHVoK3hwWG9kLzdGUUprbVRNc3lTd3BGY2hSUHpQbGdyUlNK?=
 =?utf-8?B?UVd3eEZSdTZ0R1Nxd3UyMC84U1FYbEhialNCQXl1QzI1OWpDMXE3ZjNFdXpB?=
 =?utf-8?B?VWR4QXBJcFdmLzgvb3c1QURVczZXTmJ6QUFyTFpUWEVMS3A0eEV3NmFoditw?=
 =?utf-8?B?ZU02UEF5QUxXV1pyR3piRWkyZnF3OXNZbXV5WXlqTzY1cERkZkNyZldoMHRO?=
 =?utf-8?B?R1FVcnZUTncvZzlnQ0tLWUhPYXB3NUppdjBNL2dxUDFRS1Zvdm45Ti9ORDRW?=
 =?utf-8?B?YU53TlZFTGhTbzd4NTVKVWY1b3Z3NmpjWWgyRkpVZEJYOWZYUVNmRGFZdkh1?=
 =?utf-8?B?ZVBRM0hkSU05aHVnZ0dzdStXQndNdkhMM1RlRzdhRWpyRHA3MXcxV0NwcStw?=
 =?utf-8?B?WVR2Z09sQzE5UW9DTlZtUEVIMm5OSk5kU0E1WkJsNXphWUVHNkcwc2ZpTlhU?=
 =?utf-8?B?UzFXaHFjdG5NRm1kTTJuaEY5UzM4c0w2NVZpamt4c0s0Qm1MU3JqS09tUnQw?=
 =?utf-8?B?UnF1M1dKN2Evekkva3JNR0w3RzNKVmpOeDU3Rm5mMStNU0UzUnhBZUxkZjZt?=
 =?utf-8?B?Mk1UZTFZNXZhNndTNi8zVGQzWEhYZm5BclZxblM4OEJLMkdBaXhwWXFBMXA3?=
 =?utf-8?B?VjVUVWlZTnNtS05lQnlHQi9VbHk3ZkxvL2lxVnhlS3pCR3Jaa1NGYXlsNW9M?=
 =?utf-8?B?bmViaUVXNHpHK21vYjBDQWlNMWlyZXMzWDU4VnBmSld5NGZXSFZjRVY1UUFW?=
 =?utf-8?B?cFZyVmR4ZmoxcG5vWlpvbW03blMwUVBnQ2I1eVBHa091TU5EcTNaZWQ3QkNl?=
 =?utf-8?B?NXdvZEdJdUp1UUdvcURzYXRYSTZOUndHMWNGekhwWnhndkYwdGlwZnlhM283?=
 =?utf-8?B?Wkx5K0wxSTk5bTR4K0x4eVRFOHpKNENuWUsxZXpycUhsdFFuMjF4R2hVSWs3?=
 =?utf-8?B?WGhtcGF2NUJubFZjdForMWgvcmlqZE1FUm9GcEh6dXlLSWx5RXRqbTN2am1J?=
 =?utf-8?B?c3hxRWlSdUJCKzBSSDR2VnpoQlFvNEx4Qms2V2N5NmhvSDhod0JSVms1WWls?=
 =?utf-8?B?cURTQXZ2RCtlMTZpRTBSeVR1UFBMUXFuWFZKV3ZsZTVlVHNVVWdNQ2xtWHBv?=
 =?utf-8?B?WVpidXFyTzIxUjlOcm1td2VDV0x2LzdFY2NURzBkWURyWlZWbzdQWTVwanpW?=
 =?utf-8?B?OUthbThsdUtqRjErUXYrUC9RSTFoTG9qdkIrRVp5bGpOWk5uUWJ2M0Q1VUQw?=
 =?utf-8?B?ZGR3dVJIdzdpYkdUTDFScDR0V0pmSXFTMDZBUGdZQlV3SmJDbGhqcUU2MmhB?=
 =?utf-8?B?ZTF0Zlhlek1uWm91RUZ2QWl0N3FGb0FYbDF0VFFXOG9KYS9nSmcyazR3Znhs?=
 =?utf-8?B?L05KWm4vOHRJRW5ZUHQ1KzdWeHRQZlRqUjYyUGVCRFpYMi9YSytBNUxNY3VO?=
 =?utf-8?B?SnN4elBYVVFZOFRnRFgyR0k5K0NYUUZoSDNZeFVRNWtFZ29MenZtME9IZWZk?=
 =?utf-8?B?OE9GREl3a1JoaFZUM1NpWnlzQkdnSnFHZTdwWERSRnJPemdXZ1M5K0EwTWZ1?=
 =?utf-8?B?RGlPUVhuRnJ6V3ZBRUpMMmhaeUNtUFNZZ1ZuTHZNZ2puMk9VMkFJcXptQVZu?=
 =?utf-8?B?VDNqVWtGcytMWmlKOEE1NFNyVWNtWnZCM3BkVVV3TWc4NElWeitJbHJHcjZx?=
 =?utf-8?B?RGpnVHpuTkp6cCtTVTF5T3F2VjVHQXdmMlhCanhkMElXMVcvUmVpNjVzZGVI?=
 =?utf-8?B?OW9jRW94YzhLSXE1LzlNdjZSTWpoRHhnem1jS1BST0VYWFU3RWNUYitGcEU2?=
 =?utf-8?B?ZGtxWlhxdDFIZlhCcm1KYzFBdG1mS0xrNFpNZDJuYStKZktiWmxka25teUdT?=
 =?utf-8?B?b3NUc3BzQVk2TEFqL05GaS9yRGxSSERSNUVsb3NGV01SeDZPdTYyMzd1TVVG?=
 =?utf-8?Q?N7gNcMjArQFfUKxqNOzqyi1fW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b77bc5b-8bdc-4278-882a-08dca13979a8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:39:00.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxH/2Qpx2Im4Uoso7rgHFvHhDTgSZw8t3bgrtdid4K/AoPD/hkQiavmb8RkOw45ybdC52M71fAoJPs9u+RiW1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6352
X-OriginatorOrg: intel.com



On 7/9/24 20:07, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.

better to add "for more readability."

Otherwise, there is no issue with the commas.

> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

> ---
>   drivers/dma/idxd/perfmon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> index 5e94247e1ea7..e596ea60ed3c 100644
> --- a/drivers/dma/idxd/perfmon.c
> +++ b/drivers/dma/idxd/perfmon.c
> @@ -480,8 +480,8 @@ static void idxd_pmu_init(struct idxd_pmu *idxd_pmu)
>   	idxd_pmu->pmu.attr_groups	= perfmon_attr_groups;
>   	idxd_pmu->pmu.task_ctx_nr	= perf_invalid_context;
>   	idxd_pmu->pmu.event_init	= perfmon_pmu_event_init;
> -	idxd_pmu->pmu.pmu_enable	= perfmon_pmu_enable,
> -	idxd_pmu->pmu.pmu_disable	= perfmon_pmu_disable,
> +	idxd_pmu->pmu.pmu_enable	= perfmon_pmu_enable;
> +	idxd_pmu->pmu.pmu_disable	= perfmon_pmu_disable;
>   	idxd_pmu->pmu.add		= perfmon_pmu_event_add;
>   	idxd_pmu->pmu.del		= perfmon_pmu_event_del;
>   	idxd_pmu->pmu.start		= perfmon_pmu_event_start;

Thanks.

-Fenghua

