Return-Path: <dmaengine+bounces-912-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C54842E19
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F3DB26089
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 20:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F2762C5;
	Tue, 30 Jan 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDK9fXaQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAE762C0;
	Tue, 30 Jan 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647320; cv=fail; b=g15L14VpsppSsZgtHd7ie2JiYg/3yC+DYaRC0OJkPvg4h2z9IcOE92JMxi+IQYabzv3sHfR55YgR7ExehMBlDaPsBvVL6T0D8XMfcmS1o4qgRmvpqHwTQom138E5wYgwz6gmVedlH0wGxY1UDSN3zNPoTBIcJsTcMW6Heexakko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647320; c=relaxed/simple;
	bh=7WaQgC5fQkSu2usea2JOxx3Dl3j5LDi+GeA6aNULQpk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=teTlsQs4+8m2wwowG7L8xsf6iSz6Mk70SJZ/Ua69fAJJOGuWm+wX+BbrhPoJggHk6wELKdHb0MqeOW7mZwKW59MokM4MG50dKV2FuH3RY7f7jcdHUdafslUMPuSOLBcyv04AttKD4F6b92M42A25dixcnkungnKT8foACxKm5Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDK9fXaQ; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706647318; x=1738183318;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7WaQgC5fQkSu2usea2JOxx3Dl3j5LDi+GeA6aNULQpk=;
  b=TDK9fXaQ4D5AG/zn7FkOQxKS/GGAY5W+q00tkql7JWNroF2mKKkpMuJp
   A840JPMZSB8Vtv9kNgevezyEBPsBP1Fmeq7JoYDoHquu2VSEkeDj9hTHi
   hwccb1XO5x0H4uWPhBm9tvb6rVWFmspPqZWw1Cs85NYtr11TiDx5K9iRS
   e9q5/khPQDhQZBPKQAZI+Bw4qLr045gSYAP+c/2cfpEwnGrRG9HE0BAvo
   adUmx2Xd2k+RDw3C4PIw410b4/7xfeIvokvjCi1TFRobkxW8Z9QXbLlN7
   /pPPg9CpTXSQCMtD+HAHgXdvtOt9b0L7VmMAVaqf896B5shdQmgUgjDAE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="467648653"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="467648653"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 12:41:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="737880667"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="737880667"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 12:41:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 12:41:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 12:41:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 12:41:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd3uPEjjtuH0E60niPuPFJVpdgzFdXLNBHQer+1moMbmiJs4TlxIhdJKSvK09dpuQGEn/3B+FC8LrtdRJl0JUuZPTodshtBJkIn3jUavH5dmvaEB3csoKuTIkFLMxtDECGfYUkKiQmi+Fg4SYB3fmQzCarUFt677dX66cBYq23JX/4FpMB8KjOXuWbvd0CgYlBXxSgKfsAF02aIR9XbNS7MneaglXv86ktyeW2c41VokaS3B5jQNCFIsYHPogdW45X5Tqh2ZOAquYJFvMK0WXo4tVqOGMJwCOgugaxeNxXRib6pTMRV8R0TBfuUNMYRgDbcs3vke6qkpmgUsZgxg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=042rowT/7PEqvcrkqQaiEb5M3a6b7FoP2qr2zVLIygM=;
 b=AtMU0OcN9wMK5J6wUDcJTk8R47SX6afXP30CIj10PfCTH8U7ZmNqukXi/t0EIJ9Qyu2H8K6P7Oxlk39DsZFd9m8W3kegj635z2JIFlXSrj2PyZ+z/RN9xauAQ+BDmrrF9OsnhbI4ztcV/7w+kiHr0er7q5OhUXra6ld/WztrGbQJbkRCc0AQ93mWHKqDVftO1KtKRVhKoLSZrevK4/ipevw8N+goLc7EloZ7NPZgT4ZbWc6OxaUrBK5f244cHwIQ3Bf6/c4mxRlw1EANKVotEMX3FIgdXk3pH3JVuO5RVPrvgsD20EerYo1AArGq5Z4ev5uZv8mmPM8/HS/3dHqK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Tue, 30 Jan
 2024 20:41:54 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 20:41:54 +0000
Message-ID: <c6c45aca-e8b9-f10e-181a-f0ca8a79a64c@intel.com>
Date: Tue, 30 Jan 2024 12:41:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Change wmb() to smp_wmb() when copying
 completion record to user space
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
CC: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Nikhil Rao <nikhil.rao@intel.com>, Tony Zhu <tony.zhu@intel.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
References: <20240130025806.2027284-1-fenghua.yu@intel.com>
 <Zbk4wGNcB-g91Vr0@FVFF77S0Q05N> <ZblTystHpVkvjbkv@boqun-archlinux>
 <388be136-f91c-403a-99e1-7a10c5bf9691@intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <388be136-f91c-403a-99e1-7a10c5bf9691@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::19) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH0PR11MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 276390ba-c91c-4fbb-39e0-08dc21d3e4ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dS7WtLVcV6ZroZ77HrftQfbWuoySUl8LYDgRKOLkcnGiSVwkmbM3YIYucfexpmM4MltbrFy0Zg9qlxybiPerLSXYc0n2/WKPiiM0tgCv8R/7QtqM8/N91l6HHnVQ4BsvFsWoU/DtBG0lLvfV7t1pnRvO0efOiZhLzowCoSq3qn/+vkwWjKDLRoRN/MfySwo79SN7pcq9X9AQJAmEyfLz/hf971LBcxTZJsi7JooAuNlYpMWcyzSK8FqiFHqNcp9NRRM76/mp5zr2l0vXf+aA7eQGeaIJ41OQ3JUWPhaUlZ0d5ry80Gxk7usrHAFFnT5g0bDOPNi8A3Eufnf/W2bg/GVfeiPXmCdyEfZ1sd3/sYoOo+A5FnqDJf8n+Z66jLe4inxf3JyN4K142nNsWE9TFTP6x3nwDUZZRHNLIJ1wdF1cwZzc0HKWg4ELCuG4r3nvhsPqqUdOU0PQTezaZkMuEt1EIPAHWpx9XvTFAVrmYqNMn5dfh5Bd/Z6/cyj2FqnOxDiPfzRyJd5gp4snfKL8ZR9bdBAhg79LKVaypUWsVYhUda/zpMqJpUnfgeZMEpYESXUmZM514sPCzvbQs2QIAIoDwKlK+2aIBUGANW0fPqmHf0OBPNBS+/nk8rgu9wY6dL7eBM/It9K3sbVYjy75Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(8676002)(8936002)(478600001)(4326008)(31696002)(66476007)(66556008)(54906003)(6486002)(110136005)(66946007)(316002)(86362001)(2906002)(36756003)(44832011)(41300700001)(5660300002)(7416002)(83380400001)(6512007)(26005)(2616005)(38100700002)(31686004)(82960400001)(6666004)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckFiYjZkSExjNmYrRGRuM2F5cndiQXVoWnVlOVFlZkxnQWNYbjNvZ1pxblh6?=
 =?utf-8?B?ZWQzekVTRWIyaTljTXZlRTZPd2wxTXNaOGh4a3U1VVRmQXRHc05icmRVV0lT?=
 =?utf-8?B?ZEcwVFFCY3BFU2ZpWnFyL2hDTE9WNURKWndJOWsrTEF0MjE2NjZVQWxOQ0FQ?=
 =?utf-8?B?bjk3WnMvRitTZEljQ1RqNU8zdExUVU4xMEsrYzNLd2xwcVU5cmhZcnp6T0o1?=
 =?utf-8?B?Tm9SV0pwZUEvWnQ3QmZjcmVpRmhmQ1l6dXA1V3FpS1VlamtKMzRxQk01VDh4?=
 =?utf-8?B?dk91M3lXR1Z3dTh1ZkdqNEp6OU95QlVHQzQ2MmJWU2tjQTd3ODAvVmYvdE1Y?=
 =?utf-8?B?eHExZTl0WVY2KysxZm5mUENIakxNaFc0ajB6clZZUmRESGhiWTRoTWVMMk9U?=
 =?utf-8?B?YWlTTnJwdjFzS1ZmUWVJdmZGeUY2QVRyeWhBMG9uaXJKaGJRWjFRS2ZCYnBv?=
 =?utf-8?B?QTY5R0p4dGx3SUo0dFB3TTdiektFTmRJTnRmZVorK1J0OFB2Ry9QZHJMSkky?=
 =?utf-8?B?UUxPNCtCRUFTaldkdXphZjByNUtYSzliYjI1RlNiazVoQUlIOTV5VjcwT21y?=
 =?utf-8?B?T0JXL0lxSlU4bVZURldRT29mS3kwcWVrSjlrZHNjTEx2S0JwcTZUalVoUE1H?=
 =?utf-8?B?UEF1R1VUUitjS0V6VXdCazF3YldmUlVvRVg1bHR1blRmbGYwK3VIdCtuZE1B?=
 =?utf-8?B?Smd4RWIwZEVKYzBVRWtzcG5yUmt1VFhGZHYyZzU0SmZyQktYT2VPK05NYWxD?=
 =?utf-8?B?eFhrQXQzNmtSWnZGNnFlaXFRWTZGZFk3Y2Rvb3dpaGRHNzJVbGxOTy9DaDFR?=
 =?utf-8?B?UVhwM1Q4cnVRSklDZG91Wmx3YXl4cHNWSlFSbzdDTjB0Szg0b0tvd2lyWFVu?=
 =?utf-8?B?SUFvWEYxRXhsOU9mbDg4OE13MFpPUlVSNUlxSmFwVVZVVFRteUREemx2RlZt?=
 =?utf-8?B?cmN6K2tTb2FFYjU1aENMVTFTSXJLL05BdmJCaW1OUUg4YnlTM1JOZHdlMnNo?=
 =?utf-8?B?R3J1b1hZWVBURTRlQUpSa0lydWdGb29kZE9Md3RpY2Q1QTMveU92b0o0ckxN?=
 =?utf-8?B?REZKNGdwRGFBRk9PNXV3MUtsa0FVMUQxVlQvQi93NnFad0F4blp3cSs0b3M0?=
 =?utf-8?B?MVdlMitLV3AwYjUrV3o1YklyYnBnaFgycGZLWUJWeExUNVFPOFpLZUdPbFY1?=
 =?utf-8?B?UHgwSlBVSDVTU0NPWENCZ1dhNHlaRktnbHpUS2d4VWhvN3paQVhVTjFhVlBG?=
 =?utf-8?B?Q3FWRjBGSTI3V3RjOFJvSkU4K003ZlVKRDI2QkF3UTl4c3NLVzZIOVlZeGNt?=
 =?utf-8?B?U2Rnb21lSWJPYi93a0UrMjNjdEJwUWQ3VVd0eUlVblEzbCtIcXl1OHgxdmky?=
 =?utf-8?B?TXVWMFBKQ25CL080L2JzbC9jLysveEM4ZU0rZVJLTUY5b2UwblNHK3NWR0tV?=
 =?utf-8?B?TWNFbUVZTEdVbVlPdVQ0T3VDSUhRdzhrcFl5UDYxVGYrZWh2OGZ2OTY1SVh6?=
 =?utf-8?B?MXhtSklXa014SURwYWVOZGV0dWt5emxqSjZ3WU5sb1p0NHBFLys4RjY4TVhu?=
 =?utf-8?B?ZUE1d0RJWTZBbTNMRDFDUi9FM3VtYUpidm11NnEvRzBHQ0MwTXRYQW9ISWk0?=
 =?utf-8?B?U09BVUQyQW55bUIzdnRuLzJlUlg0QVFyRFMvQmtRVUh1SE4rZTVGRFpRb3RE?=
 =?utf-8?B?bFg4QnRybjl6VkxLejFNS1UwRlYvU3Y0cFpZU3NDOVVXcFFEOGI3M3R2L3hj?=
 =?utf-8?B?UThCazhjdCt2TkdxckJYL3h1dktRb1BsQ1N2MkpMRlFhcHE2cWpscnBZM0NM?=
 =?utf-8?B?RURSc2JySHBvb0pUVFphTXcrSEFtenNUM0J6a2tqalR6MTZaR3ludlRPZGxF?=
 =?utf-8?B?bVk1RmNsSloxMHJvem9Vb1VybEFGMzdmdC9meW93NTA1NTZWeCtnUEZuODZ3?=
 =?utf-8?B?djI5clRvWWhJZXFha0hldFd0SmQ0dERCa2RjbEZZenNRNkFzVVI1aDVDUzQz?=
 =?utf-8?B?d3VEUDRxdHBVVnFncmNtTWZ5V0xPTHQwQnVtaC9mOXhERE5zc2JTYTVPWnFw?=
 =?utf-8?B?Unpna2R1VWZyT1paWW50ZUlidjNBVVZRc3I3eVVjendBSHVScytLVS9pODBT?=
 =?utf-8?Q?TvkIP2N6rhHCdj0Piblm4xOz6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 276390ba-c91c-4fbb-39e0-08dc21d3e4ca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 20:41:54.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNwUdyWwgew2EHqzLErhYoiJOXyxHQpmB7LuRy0M7x513/ll/L/xkAyr3hZyEi/5wcyGRYrMjxm2VQMHXopEbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com

Hi, Dave, Boqun, and Mark,

On 1/30/24 12:30, Dave Hansen wrote:
> On 1/30/24 11:53, Boqun Feng wrote:
>>>> Fixes: b022f59725f0 ("dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling")
>>>> Suggested-by: Nikhil Rao <nikhil.rao@intel.com>
>>>> Tested-by: Tony Zhu <tony.zhu@intel.com>
>> Since it has a "Fixes" tag and a "Tested-by" tag, I'd assume there has
>> been a test w/ and w/o this patch showing it can resolve a real issue
>> *constantly*? If so, I think x86 might be broken somewhere.
>>
>> [Cc x86 maintainers]
> 
> Fenghua, could you perhaps explain how this problem affects end users?
> What symptom was observed that made it obvious something was broken and
> what changes with this patch?

There is no issue found by any test. This wmb() code was reviewed and 
was "thought" that it may have a potential issue. The patch was tested 
without breaking any existing tests.

 From the discussions with Boqun and Mark, this patch might just be an 
optimization rather than a fix. Let me think about it further and may 
update commit message in v2 or withdraw this patch since it won't really 
fix an issue.

Thank you very much for review!

-Fenghua

