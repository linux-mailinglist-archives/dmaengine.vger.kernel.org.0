Return-Path: <dmaengine+bounces-999-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD0850798
	for <lists+dmaengine@lfdr.de>; Sun, 11 Feb 2024 02:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F579282A86
	for <lists+dmaengine@lfdr.de>; Sun, 11 Feb 2024 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A282A15C4;
	Sun, 11 Feb 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xewd1yAn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99215B3;
	Sun, 11 Feb 2024 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707616206; cv=fail; b=QcwCkDq6AiIV93MSsJESPlJyqIN+479ey8BKfn4Tc5w/42JYGQnC0fsjJbSLe2quaNTnRmCiSpP8/RH1UwH4DybmoYBXmniqNf+rEQI7v8tUyx/u7GoNOUSTsytpzJD1NZgND0PLpOYTaJ1lc7sVZ6nCVX1K3yOsFM/poVhEuWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707616206; c=relaxed/simple;
	bh=2YssQIMvWJYKbD4sBsShowsLJO+E/Nd9HIYEcaW86Pc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RDBRx0k2OTvUwtqwcgJFevi72WiMLd/kOAIiJeby2ay7lLfkROG2sS3PQLwgYhgwyS7PCyqJz706DEVgFm7uGeIqCeiLcQjCpR0GeoTdLjqiqY2tGy6P1yVEZ3kZGav/EOTwJijYZgkHvhZJfaCSpmzoWUn0WNDWK3BuQiSx5PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xewd1yAn; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707616205; x=1739152205;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2YssQIMvWJYKbD4sBsShowsLJO+E/Nd9HIYEcaW86Pc=;
  b=Xewd1yAnIMr5kQ3iDHUYzHhbDNKgM/4kWry5gHpeAkAKcReUB6OQaztD
   alYYza3eAVgSUJK5Dk4bYa4gqwCXX4blPc1SPS2EP0JH7JiNYFNUmlN4M
   Xb6VZyXOx7HzL+VgVyXcxaoGp+7ovBlpDpzyBn6okNHougvfc7HbUlSC/
   VzysAI/jjEuzSibLm0lk1gPtSMIvbfgCxfo4Ims428z24lvZ1vH22ZPWt
   wMBW/3+yntBdC7GW8e4Ngtk0d3b4E3BZbHiqzkjk3uL6BBZdCc/fHOjH+
   4y5ecxOqBY5avnjCIq2lmbZEKSD/rgv8MgYpPxEJ406RG+/DV1pfDgHCb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="12241920"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="12241920"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 17:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="2654870"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2024 17:50:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 10 Feb 2024 17:50:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 10 Feb 2024 17:50:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 10 Feb 2024 17:50:02 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 10 Feb 2024 17:50:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICHj0hf1qy4QqwhjThqn1a43t8Nzj58fieZ7dryDbVCak87+J2go7JFwzSBp3V7AdG/K1Vmi++/HVFEQMajHygz8o1uxA1FNasm/pJQGSuq3aJgQA65qKoB+Tk47xsr6hpZZ6sShvq79uv4IXzpqHcbgCSV/R8Cf9SjT2dlbH4+N9qJf1nHZ8X0o9dn4OuwPJk4WEsuBb3lvDPg+Aj/By/sZ3rtjiiMx8VOWfW9/AY+HnECYGBSC4NSh43c/GpHaDbIrFiVBNVb1zENrHgayDD4dsAYVIUL74NqI21AIRVP75zR7dNQE7o+9i4trmRMrGSCxInSvx7KcxQEyFXu/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LB6yhQq4oEcDWKPypP3NzP9/g0lOkhmzGbJLDFFR5Vo=;
 b=mp7pYf9O2gWlwItS1Dj2EpogJp0hXwLy6ncDgWKvNmYQWjoA/Au3RjIjO7olNZtQEojNk/y8NHMs6qR9oJBznt0ft2E19PzGAvOSw2GECFCjK0S7/0ZPY+EHl79AfLgq9XX1aftIGcK33cGwFzwFEhFZcMizTZuRpBbdFoalZpH3W1BCJ+1AQOQ1A4N4XueIWlhZbeHtLogNjkc2K06cZ//pDj74og7HjoO+im9z2KHNgEwxUHBaEH7UIhE39/qr6hfE53UfVX1RxKOQQmNoPccZbZhIfKxTfcj95d4IuWBJ0D3d4BTWrjUHRs/QX5Ydj1/ZuSWeYO0imGXjNUuwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Sun, 11 Feb
 2024 01:50:00 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915%6]) with mapi id 15.20.7270.033; Sun, 11 Feb 2024
 01:50:00 +0000
Message-ID: <18761e12-822a-16b4-fdc5-0ac889b1693c@intel.com>
Date: Sat, 10 Feb 2024 17:49:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Clear Event Log head in idxd upon
 completion of the Enable Device command
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Lingyan Guo <lingyan.guo@intel.com>
References: <20240209191851.1050501-1-fenghua.yu@intel.com>
 <36895817-8f71-461a-93e0-5db1a39cd3c4@intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <36895817-8f71-461a-93e0-5db1a39cd3c4@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CY8PR11MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: e91aebd2-baf9-45c9-f60d-08dc2aa3c180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ielOKkZIq05WS5kKtdTwOEPxCJMHXoeyRkqu54YIVA+kEpSBzkrQn9t2kZCd6h85Hqde96fECAZrgawLqq8gKl3HeEl1UIalkMfHL9TPTaE071X2umwcU4mSESp2iDTmmTb9yHV9vAMbsdb5cskxgzGWdg8AlLxRyQW1k+WNsyWxu+1NdE517/aR10I7obgYxXW9s/OrZ1wnMOhhiKVjZa1DB8maOXiTFXdUZbcNH7OtEMjhT8ItGTODwO+DkYrfNNS1HBx8/QUCEYBJbyXPcdlCRbcrOk5/4/PB+GJBrwANZxIohZXtlYG502MxGqugZQ0/mL4RoZtapFPYJU80xwht3FGwy+Qk8fA9a2yDoVyB/pM6Fc60qh5Wi5/QaqXYStP6dFU7qi6pSaozmJ1I6aZVnrnxgfzmMGmEWL1vaZFlm0V82B4yRhyufYV85ldU2Gyo7hepnMXN1vHv5eWNH3W5b4hSovTOx8zuik7HDVCLcCbtRcG3X8uTmsQQwnXhawsMURpoovcnNQhsI1K+v/f1i1p2ROktUpg+qeMkVcKdTml+QZG45xrUmWvLLGVp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(6512007)(6486002)(478600001)(41300700001)(8676002)(8936002)(4326008)(5660300002)(44832011)(2906002)(110136005)(6506007)(53546011)(6666004)(66946007)(316002)(54906003)(66476007)(66556008)(83380400001)(2616005)(31696002)(82960400001)(86362001)(26005)(107886003)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aitwN0NBUVUwakZ0aVQ4NFV0cVNmdkFSOE1MSVRoV3gycnBSc3pHOUtUME9U?=
 =?utf-8?B?WERJU0UrWVUxTXRzdGRHTXhsSk4rSlFaWVhoakZoRUkvWEgxWnVNRHpCTm9G?=
 =?utf-8?B?R2hiTlZLMXF2ZHQ2SWpCd0Ewc2lOQ3FxRUl3SFdjVkxycENzcjVCY0hoN0tW?=
 =?utf-8?B?ZWZ0WXRsNFlscWh5cUVjWHlnU01mUHQrMFFlQlppVUU4NUtsRWhlVUIrWVJ3?=
 =?utf-8?B?T25NbzM1SnNhUHExTzBrR2RWamVxcGQ5NVFFMFVnZzhYdHhPQlhCbjNZRGlN?=
 =?utf-8?B?cGR3WlpaOTIvZDdYTUJIK3pvUHE5WWl4WlRybUxYSjBlTzc5TzVLZElOd0RP?=
 =?utf-8?B?SXpiNHhVUEdDT2M4OVVJQjIvQjNadlp2aFlmNDV0RkxvV2t2TWt0S09Pbk1i?=
 =?utf-8?B?cXF2d0xYWURBNE5jaDcvbjBaSDBwSHJ3alZTYnp0L1FlckYrQ2ptTGlXVUhh?=
 =?utf-8?B?dUlPODN3YTl0eitSWjNIU2lQamJnc0hCcXVrREo1ME1lWUJNQWJmdENLN2p0?=
 =?utf-8?B?Tnl2cE54cXZGcjVXSktiR21RQWxWc1FUQ0J4OFF0MFBoUUpieTVnam1iSVl1?=
 =?utf-8?B?WVJlVVRQYVRzT1p4MmVVVnhvNFlweDVPL1JkV2JiZEZ2TVc1UDkyRitkVTVF?=
 =?utf-8?B?YXZvVnBCcVFKNWcycmtpZUQyL3YrbUFPWnJ2ZU45bDVXSEtjbVhjZ25OQnN5?=
 =?utf-8?B?OUFtcGRXNlFFVzB1OTdWci96dGxldHZSc0NqOTBSaUYvVEFVeldZR2N1ZFJC?=
 =?utf-8?B?N0JiWkRlcWs0KzlLTndGYTBDeVBUM1VIWEwvQ1RBdng2cGlaZXB4NmhnSDg5?=
 =?utf-8?B?cDJjaFpVQUNDa0pQdE9TaGk1TFVDdWk3RGNmWHp5WU55a1F0aVkvbTJsUDhZ?=
 =?utf-8?B?dTBSSXRFaWg1eGVvaU9DdU1sSXloNDFtUzJxOTYxQnY5bUtuZ1BoVTBMZU5T?=
 =?utf-8?B?NVpUUGdBUGJMOFZVb3BDTXoyMEtKMURyMGdkL0JFcnZsajg5L09zSURLc0hv?=
 =?utf-8?B?MXBuVUQzdVJ6dDlmUFMvekluNE9TeDdENU1OTTZhNVRLdmxjK0xjY1lZWTND?=
 =?utf-8?B?L3FaYm5WN0hFTytTeTllVU0xWS9pMEFNODdxU21Udm10ZjU3VG1NS3JnMmxB?=
 =?utf-8?B?NEwrcis4amt1Szg1SGtiZk10QVRzNHBvQVdhaHVhTWx0VW4wVlJLazVyN3pY?=
 =?utf-8?B?OCtieG1MR1h4TWZYKzZWdC8vcWZHNnhGL2d5aFZNeFdhVVFEOHc5VzNWRXpo?=
 =?utf-8?B?eUZDczB2enY2aEtxYmo4YS9jMk10OGtkcVltMFRSSFJHRHVHcllnWHd4UGlK?=
 =?utf-8?B?TTlSaG1yN0U4VDNvUzd6N3VKVzF2R2V5Y0lFaGczSEhGUllsOS94VFV5aU9F?=
 =?utf-8?B?L2doQzRoYlRGa3E1QTJXRjVxZXdmekQyVWFzclpEV3Zhd1lsZy8zTGJTSi9x?=
 =?utf-8?B?MjJ6Vzd5Mklyc3EzUU1GcGpBNlFTSUJYdHZJMU5XVHBtNHQ1eTIvdlJ3enJD?=
 =?utf-8?B?ZVE0Mkx2ZS9uRk0zb3gvS0JmNDJOVFdPbU9XcXpid1pHbGR6MEhwZU5yVDBs?=
 =?utf-8?B?QUxVOUdXNENjb0dUNnFRcldpQWJlRTBtNDE3RmF5VzhkN2dzYzVZV20yUW1m?=
 =?utf-8?B?K0MzYXBqQ3RERWF4aENHR3gxMEloZ2k0ZVh0MWxvUUdpa0FuRjB6VmsvRjNS?=
 =?utf-8?B?Y0M3cC9wNmpOZmVOYUN2V0VHaU5LN3pkR1VaUG5ML0VWREgrQVI2VUFrQ3lW?=
 =?utf-8?B?R2h3UFdHMGdXOTNYOFNOdGRNVUhlSlQrMUVDUksrQ2ZSYVJHcUZkOXlNL3N6?=
 =?utf-8?B?b05CSHRQTHllZFpQUlEwWG1vY3ZscFpndDJ4OTc5ZDUzbndOd0dIQjRkU0R5?=
 =?utf-8?B?L0hpWnkrMHEwTHF6ZW9WZ3NuQW9ZaDNLZXI1YVIvcjB1NWNKYUNRN05jU25K?=
 =?utf-8?B?WU5yc1pvL01RMzNvYTMzcTJpdE1nRTVxTDVLTnFIU3RKM0RpTjdCeDZrKzJm?=
 =?utf-8?B?L2hKanBqNjFUT2pWRzgzbFczZFczUDRyVEFjdGtjN0FqWEVwUGFKQ2tKMTlq?=
 =?utf-8?B?c0VFOXV5MDFtcVQ0cWRIUTZBcXJ2TlJQWWpqNHhjZkxKa0xsbG1VOHJReFJF?=
 =?utf-8?Q?emf2fWCvgDixpsOWYxRkvh/an?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e91aebd2-baf9-45c9-f60d-08dc2aa3c180
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 01:50:00.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQqHU6yIbobdtcjRX0Ca2c0f8oPSDzAh3OdUyfSa/3GHngA44C1UHsLtD8mt1UcKMnT2Gxkj2cYT4vJPRrSEeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
X-OriginatorOrg: intel.com

Hi, Dave,

On 2/9/24 12:17, Dave Jiang wrote:
> 
> 
> On 2/9/24 12:18 PM, Fenghua Yu wrote:
>> If Event Log is supported, upon completion of the Enable Device command,
>> the Event Log head in the variable idxd->evl->head should be cleared to
>> match the state of the EVLSTATUS register. But the variable is not reset
>> currently, leading mismatch of the variable and the register state.
>> The mismatch causes incorrect processing of Event Log entries.
>>
>> Fix the issue by clearing the variable after completion of the command.
> 
> Should this be done in idxd_device_clear_state() instead?

If clear evl->head in idxd_device_clear_state(), evl->head still 
mismatches head in EVLSTATUS in some cases.

For exmample, when a few event log entries are logged and then device is 
disabled, head in EVLSTATUS is still a valid non-zero value. Clearing 
evl->head in idxd_device_clear_state() when disabling device makes 
evl->head and head in EVLSTATUS mismatched.

I haven't thought a failure test case when they mismatch in these cases 
though.

But while thinking evl->head more, I wonder why is it even needed?

head of event log can always be read from EVLSTATUS instead of from its 
shadow evl->head. And reading head from EVLSTATUS won't degrade 
performance because tail is always read from EVLSTATUS whenever head is 
read (no matter from evl->head or from EVLSATUS).

To avoid any mismatch issue/trouble, I think the right fix is to remove 
head definition in struct idxd_evl and always read head from EVLSTATUS.

Do you think this is the right fix?

Thanks.

-Fenghua

