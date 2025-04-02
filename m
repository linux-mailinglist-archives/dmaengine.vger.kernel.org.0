Return-Path: <dmaengine+bounces-4804-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60FAA798D0
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359FE188CF24
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 23:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8191F2377;
	Wed,  2 Apr 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JLELGdYU"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69701151985;
	Wed,  2 Apr 2025 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636483; cv=fail; b=l/1usd2t/A9+2tZ2uu8ANLST+kgH5z+hZYG1wapj4MqgM7RSTW6k0Enz2OMSND4bbz6lolSW5135cvKcORdFYlgjghxrrr+w1KK3lJrMnBTwLu2kuNYklIjZo+/hzt4jzJ6P7MHayCBOAPle6ap/efaz+7r25NdUeIr31OzJ2Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636483; c=relaxed/simple;
	bh=c2YztKMMoJjpI3Agubc51YKPJLFeB63YcrM/bHCdteU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BZDLSewXFHeOO8bgNuBx0JHQ9WxdgLOg328U7RVzsVo/BDcPvOD+oNrDmBKIbYplLWiOS5Vvo3Twjf64OiAY+N3e6jRH+YB5b3SXcZjAxVzoIUX6uwf1WtNc+rqlKClvGkhtH6NAtA95cJ9jOYFeU8p+qJ7T4cGV3aZzwK0JfRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JLELGdYU; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRPFuKbOUSJqM818CN7t/RIlXpcQ8Jnxj5SspzGE7Pz6JNsy0rXqh7fJTzBtqN6ZXb7GwXznDvJUNv7sTSBuTNdYAC3QznYcObak/tURdzczY9u7Wen9fzdP7lnSxO1cs64626MvwwaIdjMWMmgeAtQJQuRssVw0osbXOEl8hQ8zLR9kMbRWnEpIloWw9/quR1Dg6f/Yxs+akYQjMDlKK9sNNX1Y2/pfHYtPgtefKIjXuA/1SUWCGjbnmvcyAdpzbnW/cuKA7BLy88ozxiRTOqj92/jW9mYhqDLQDf1ARvilt9UibKXDnlQ1xwjIVEi5RiUtJUFZzzRQhBNC1mmFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxTPDSmVacJ/jPN1pwe0xg7OLIa1y0qXbN0AoMcde4Q=;
 b=Nd3GNVxe7WvtBwQA1a39AXljZvpIA4+/9WyyoPg6eNnsbi04uM40n5QCSKzJXTScxUnEYGZVR2C0ZroWdhpu8t0j/es+BZGmoOLrUn9fLAzo4csmOh7JS0KKxklL/JHup5KLCFZXAQvZL6Xs9NU+P9sKG8ERie2ywDEP0aJvi0VOeL2/53V1VsUYuLYQhbAAmcm/jqGUkcfUUnRcRoBRg3nfOuv4Hfr0tFddIxe9xfkmJHNxEfGFaDDO6f35Tov7Qkm5dcUC0dIebWdjFqtwhpVgIOq/uHwJRevb2bmGV/QkhCMBYQPm5fXSVyrcu3A7O73PdGn41Y/t6bk6U7TqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxTPDSmVacJ/jPN1pwe0xg7OLIa1y0qXbN0AoMcde4Q=;
 b=JLELGdYUM1z/go7NTQ20rb9h4rmTHsGhEkMxnlxyTgUrS1SpvEY1MINkS8uPBgME+//4NcoELsGSbUtpTKmwnKbjNjJCNVVLuNqNfM/KyTxWDXLkoiCWxmamgc+RVqe8f5rVV/UDwNwhXXBn9M0m7FFuPvaHy9L/8SPvn3sW6gimUzAUG3S+9e8KpPK9kQNsTTGDXpMSk6NFL5Dwc1wyESpM9W4+mNLuuJNSp6F2FvBcG1XWu9sLUUBfLAzqewwWs/mRBqvhaxjuvtJ4QJsPEUi1yZZbwyNZKTYNi2YYCB3AQ/c35hXvb0qjFk3KeTvvVG/qhiYwZHZUqqYHn3STGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 23:27:57 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 23:27:57 +0000
Message-ID: <a0049187-6f4a-4353-a0c8-5ae5e3dd08db@nvidia.com>
Date: Wed, 2 Apr 2025 16:27:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] dmaengine: idxd: Add missing cleanups in cleanup
 internals
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, Markus.Elfring@web.de, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-6-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250309062058.58910-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: b087891e-9724-4bf3-6a67-08dd723e004c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SCt5eFVoMVdvbVlBUVRodHB1T1RuN2FJNHhNbklsTHVkY1JYTmUzRkIxc29K?=
 =?utf-8?B?VmJWQm42WVlna2UrMDNNcFBscDIxazQxRzhhYTMxVitjaWJSMmhhV0N0ZXNj?=
 =?utf-8?B?MjBaVWQ1VTQyLzMycGJjRG1BdzJhQnBESnc5emVIQ2VmbWs0ZVhhZllVRE1W?=
 =?utf-8?B?eFNhbjRjSm5Dcis1UGdQMjNIZHVDM3RpSm96NlE1bkMvWjdTRjRCV1J1TkhS?=
 =?utf-8?B?anozQ0lvNlJhK0p1a0JGeVRsSFlDMW9RdHpuUUF6a1BSOGl4UkMva0xnMUhj?=
 =?utf-8?B?NGJIWXdEVjJCdzJBYVBpTE5KTGJMYUJSenEvT1dzTnZZZTZQZW1XVmtFVjNP?=
 =?utf-8?B?WS94Y25LMHk3UW42ejcwenZ3bFJTcHJvK200WVNFYlB1cFVzWGlOUVdMTWtt?=
 =?utf-8?B?YjhtUGRLQ3IvT2l5YzQxSDBZYVhlcnU1Z1pjL0FnQ2JRWjRqSFNTNjh3S2NJ?=
 =?utf-8?B?Q2gzSFVMU2NjRG5iTEhFazU0Mmx6RUV5TnAxZUMzaFowRk5jc0VmY3RybnY1?=
 =?utf-8?B?a1VSVDlqd2FTWWdnVU1WeWtFRTBKKzdyTVk0bzhzWHdUT1dubG5KckwrR2Ex?=
 =?utf-8?B?Vkd3NEYvSFFJdWhrOGdIbnZRSS9sdnlPMVhBajVEeWlDcTlFaVFoV3FWei82?=
 =?utf-8?B?am5MVU0zc2hLT05xeHpIeDJzcFFWb0pqQXdodjdUOThnTzRGZDFQN1F5eVFn?=
 =?utf-8?B?YzlPWkpnS2lhVXZxT3I4d0hnUjVQeDluYVhuODhGVTV2Wnl4b3RqMWlReVNn?=
 =?utf-8?B?RzZSOUlyK20yUTBkbktnNlNLWm9ldm1LNmUxbHMxUXNuRUF3aHlzbkZJNlcw?=
 =?utf-8?B?NDdIQzlSMk9ZMHF5eElMK3BLaGxsZHltczdTQ1lWeDBKS3p1cjRCVFRGVlBE?=
 =?utf-8?B?VUQ2UWFsZzg0Z2xvVkQ2aW5BWW5SakVPZmxVVWIrWngyNDg5aGFQUS9ZWHo3?=
 =?utf-8?B?S0haWWNLQjNvZGlIc1ZzMkUvazJlTXBLbEdtQXpZM1d6cWZtZGpGUldKWWNm?=
 =?utf-8?B?UWVlQUI4Rjd1SnNuT3dySmw4M0V6RWZ5VCtrRGt1T0hNb05OdFRBTWV4RVRW?=
 =?utf-8?B?T0tpQnZIR2srUkk2UHVXTE1sYnM1d0N2b2E1TXFwNlByVGJVRitDcU5sOWxQ?=
 =?utf-8?B?c1ZKbGk4Rm9lSVIxeldVZEdZNis4MU9uejAvSHBMOXdOQ3MzelBKWkdScDlm?=
 =?utf-8?B?bjRpeDNlK1NpQW9JbUszK3c1T1dRSGZiR0V0d0hCYkVqK2cvYUtEblNNeDZq?=
 =?utf-8?B?SjVjaEhJNm9zQ3BkZVBzOWI2L0VKN3duYnF2QnYyQytybHcrY1pRbjFUV1Mr?=
 =?utf-8?B?OVplVWNOUWkwM0Y5WXVYZ1JXbzRoT3NwZEhUYm84dVgzMzFWdC8xTk80Qk5V?=
 =?utf-8?B?cGtOR0trTEZKVXBhYkdJQWg5K0twY1llanQ4NFZmUXFqaDVJaHl3VTE5UkVD?=
 =?utf-8?B?VHJZT1VkcTVVMHhDblduSUV1eFI5YzVNbXRUN0pibGZTWmFIQitYWU9mZHU5?=
 =?utf-8?B?ajlqSnAvZGhmTGczc0Y1enBwTHpaRTZqVHJJSjFQcCswUklsZ3lSdUFUTXU5?=
 =?utf-8?B?ZlFWK0pTZzk3MUlrTDZRVkx1SkdzRTB3c0ZlanA3K0d3TXY4REZ2Ky90UEpW?=
 =?utf-8?B?Z3BKakEyOEJrMEtvQVhaVUVudWZmYk5UNzJmODFucWJIQ3A2bHZGbWY0b0Qy?=
 =?utf-8?B?MjArdzQ1akNoQmRYMVlJbXlYdFk5SXV4RGFvdjBSNEh3QTRBeEZub3B0MDhx?=
 =?utf-8?B?ZnhSRVU1TEZGQjFSYUcwOXlrQ2k4SDBaTllPN0p1VTNNcWhDa0dTV1RtT0JR?=
 =?utf-8?B?N0Z2akNOM0ZRRlRPbVlvUnNHVndDcFZtTjlMcXF1YWJJSDdwc0Rqc2puSnZW?=
 =?utf-8?Q?vbGXmYSCbemFL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkdSYjdsS1lGKzkvK0JlYjdlaldQdGY2bkZZMnRGTnhvdm1CWHQxT3pQRkE2?=
 =?utf-8?B?UVZMeUpRQnNwVThhaVdvTXdaTWxMMWhwVFE5S29OOGt1WFBlUGY4NEdqVFJQ?=
 =?utf-8?B?OHQwRktVSEE5WUFIWFYrSFR6Y25yaTA3YnkwNW5ML3o5NmNyMXdJVjdoSDVP?=
 =?utf-8?B?YzFLS0lhSFNVdVh6d3RHQ3JtS1huMHBBZUdSdWlHd3pKczNtR1IzbmFqOVNu?=
 =?utf-8?B?K2VKd2NJQ1NGOGd3eHJ3bHc5QXVkWkwyYXY3aXUvZWtqTEVPK0tDNytCeUZt?=
 =?utf-8?B?MmZuN0dWSEtDNjlSemJoakRwVHR2R3dNZG5GMUZpMDYxUkZ2YldBZDQwMWJv?=
 =?utf-8?B?VnZZdnJ4L2RQbzY0cXRCa01uSnNIS3BkYTlmdmNuNnJxWk5ucGQ3NkxYSXBU?=
 =?utf-8?B?NUt5WkFzKzA3YVVnVTA2c3BoVlpyd3N6RzdMdmVLd3VkelZScDRjYk1XazAz?=
 =?utf-8?B?UFBKQ091VHVPVFRGMFBCOEQzdFovU1YrditjT3ZmVi9NbjRzWTlBaEZQV3Vp?=
 =?utf-8?B?aStlL2EyaTlRaWJCVEJNaHFaWG5jbklVZ0xtcUk2SDB3ZzJzQTFxQnVmMkdv?=
 =?utf-8?B?SkRGaEJHZTA2bHVhaVFJdXBoZFZvWkNQRTVxRDlPblZ5T0tISFFQRkorb1ll?=
 =?utf-8?B?WkN5aWl5cjhzNlN1ZC9FdlJFSEEyWThsT1M0eGRGUFNqS21hS3cvLytiRk5i?=
 =?utf-8?B?MHpDN3pkWnUyN3Bsa1BJSVREN3BVbko3ZVkwcFdCdmZzcHhmN3k4bTRyOEJZ?=
 =?utf-8?B?eXJ1bUpCZHpUQ0NTTlZlRm1MZ3JVREZIaHBpZ3RtNUhGd2htbTV4MVlHR0N4?=
 =?utf-8?B?Tnd6NlRucUdZa1JYOHRSbGhLSzdQTm9rWEQ5YXJUL1hSaDViMXNKZWkrTjJr?=
 =?utf-8?B?U3BZSGVlM3VmdkVqNTNvcU5vRTN0bzVNV0xaV1pWcEdRaEVyT1FNbDNIZ1cx?=
 =?utf-8?B?ZWl6a1cyT2gwbExNb3BqZjhYa20zSkUvajNHMEJ3d01nQTlUdThzMzlwWVZw?=
 =?utf-8?B?RXdER2RNWTMrL3lpaE9yS1JCd3BpbXdseEVCcUZ4WUtaL3FwcWt4N240YXpD?=
 =?utf-8?B?am5BSFcxalpqdTZtYWhsbDEvSUdYejJVcS9sWkh6RjJvRkpaeExsN2wydDY3?=
 =?utf-8?B?RXJDWXkrT3BKNVlMaG5iSEFoK2M4S20rUTZ5UEN1OHVSam9IWm9VU0g0d0E1?=
 =?utf-8?B?a0dpN3JtYk5pZWJGeHdaSi92QWxDbVNHRTIwYms3cGw1d0E1ZWJ4a1l2S1BD?=
 =?utf-8?B?OFN1bmlpYjUrSDk3enB2Q3FsaTFWdWEvNkM2bnluTms1cGMxbXd0bFdhUU9j?=
 =?utf-8?B?cURvRFg4SDRaUmZNVzV6eTR3WEptM1hiSDlobzZuVFBwSDRkQzNYZHZMaUd5?=
 =?utf-8?B?bUM0Q2Vnc1FhOUJvMTBVNERqTGJwWUNWc3VxODlOZlo5alQ1U282c1RadVVk?=
 =?utf-8?B?OHh3OXk2WE0zT2ZkR2NVRDV4djd5ZFBYaGRwTW9jMUdONGtHaW9Zd0hNa1Iz?=
 =?utf-8?B?RlN4YUxLN1ZEMkwzV2VHc2tULy9QNkZGZWd2VHBtRmdjMGI3QnBUU2Jidkwy?=
 =?utf-8?B?akw0RVh6RmN2NWdMb2hPbVBkcDd6eHkzR24veXpyQVZDTVJXeWRkQnFrUXM5?=
 =?utf-8?B?M0lqaWpXUGt5VjRkS2s2Tjk2b1FHd00rSW9RWkVUbTZGNnRadzEwVDdlbG45?=
 =?utf-8?B?OVNNSjBwRXR2V0xJTFlrNHFIUkJlZkRNQ0syVVhmbEt6MXJmellHZk50a1pp?=
 =?utf-8?B?VXp1dFp1SkNZSDR2dDhKMVNsNGlmc1RIV09QNzNjcEd4SmoyZmFWNzMrSyto?=
 =?utf-8?B?em1iMnp5MTVtR3RZYi9PTnpvVUhvZHBLcWtocTJKVnhwK2Y0QzE4SEdMVnQy?=
 =?utf-8?B?L2RPc3NkekpLdUVTLzZLb3VwRFlSbWg1Qy9DemV4U2E3TkdKczFNbFlmQ1Uz?=
 =?utf-8?B?WnpqYVRQaUFGR2NhYVJ0Q01iTFl2U1RidGp6MmpYaG5zQS83SHhVWUYxSDZz?=
 =?utf-8?B?Qjh6dDNFQ3A5eXJMY1Izb0RyWlhTR2s5UHVFNUYrZkk2dzFjb2VhOFRpaFli?=
 =?utf-8?B?SXhEdWNxdTZ6UnV3bGhYUzdaU3BnODFxT2kvWUpVYkZ1MGcxeGZqQjlpZUFH?=
 =?utf-8?Q?2oG8nJIPOiK4Ktio8Sg46JHLp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b087891e-9724-4bf3-6a67-08dd723e004c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 23:27:57.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFDzilvFRGkDPDu2OR5Ec+8PxNt5sKB70/9y49n64Be1Zb5Gipco/tu4I+AinjWzkn2emMRpuVyb3QDnTmARMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161


On 3/8/25 22:20, Shuai Xue wrote:
> The idxd_cleanup_internals() function only decreases the reference count
> of groups, engines, and wqs but is missing the step to release memory
> resources.
>
> To fix this, use the cleanup helper to properly release the memory
> resources.
>
> Fixes: ddf742d4f3f1 ("dmaengine: idxd: Add missing cleanup for early error out in probe call")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> ---
>   drivers/dma/idxd/init.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 7334085939dc..cf5dc981be32 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -408,14 +408,9 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   
>   static void idxd_cleanup_internals(struct idxd_device *idxd)
>   {
> -	int i;
> -
> -	for (i = 0; i < idxd->max_groups; i++)
> -		put_device(group_confdev(idxd->groups[i]));
> -	for (i = 0; i < idxd->max_engines; i++)
> -		put_device(engine_confdev(idxd->engines[i]));
> -	for (i = 0; i < idxd->max_wqs; i++)
> -		put_device(wq_confdev(idxd->wqs[i]));
> +	idxd_clean_groups(idxd);
> +	idxd_clean_engines(idxd);
> +	idxd_clean_wqs(idxd);
>   	destroy_workqueue(idxd->wq);
>   }
>   

