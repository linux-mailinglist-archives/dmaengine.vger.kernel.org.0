Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA96D1444
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 02:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCaAoU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Mar 2023 20:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCaAoS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Mar 2023 20:44:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCF11025B;
        Thu, 30 Mar 2023 17:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680223456; x=1711759456;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dcvxqTymGDOVolKQ0Nyw4N06WVrtIYu7wPRInlxezfk=;
  b=I8AU4l88u0atzYhh9N0Wn10x/suTkP85opvZwygFOR0uoMbvQNiBOxvV
   knq4R9RG5NS5UX9vZRbC8PKCumPHaAJG1FLBgpwXZMehnSMTDpdbDiNvw
   rDST+iCgx1E1uJEl6phJAe/K+gexlMLzMnyii17j3B5AwmSLABHgoNnBO
   SoM5vqD0gkGEb6lRoONhyAsuSEF3pkmw2kMOSAivCGhsShjBiaZBn0TXx
   F5x90fa496QNutKGMP0i0flFpWn8xYV08N5U8hpic9ht0vS79E8vcAMaQ
   5V4rKECO+WgxwFsPnwPbMMtjpaEKeoVTUmsjmwXQ8OtjFPf3R8j8O4ill
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="321706745"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="321706745"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 17:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="662231831"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="662231831"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 30 Mar 2023 17:44:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 17:44:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 17:44:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 17:44:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 17:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5+6RWAJSIe/MFo2aDkz9qeJJFKT9AAeGwh5fIrjkcXblMtTel1B+wylpHfHZ5AYyn9uVCg8hnIIMQKwSj78TvqJrYy06EyvICkJF7+1ED1B0iBy0CQEAeZ8LaLXphSwguWORm6vyziplfe3qwn8nuEDnE/OYY3wIgBqmEPnVYzjdxwyKEid2bgExF/Kmy0L8efDnkg5exS/2qjhng5Er4LRK2061U5EtM4PYDyGHHlf83moFd4YW9137fRmSIYm/qbsht82WAseYO5byJwTuLLyDgdxOnancDV/zbejJrvvb0o1xs6tK+Acp4lHJhKg/TEpQYpqCGfDPHWGOCM9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbC2QZmdqR3IdB6GLYSsi4ox4vfxGyUM0tgZyISXWBw=;
 b=Tq1ZjvGTttt3J12drdk/Gh+uDpbii4fZ2uGJN6IpvOMBt/3ysO+NUZY4OnS3gq1Ta30EIQGWiJgVGIQuQmOPTzkODyycZtsKsoPNu21w3NCyhbudz6xxr/2Sbfc+4TuXGljDul4hzl0I/RaOrxYxqlMp8LguB5yEyM9y7JhTIWwjQgLNBBxuYWZAh+h43ucgVUUTnE5fvaUVnW5szz4neoCFtsauOWWoRPfADVJKEpDD8PqrpkMUKkUXphXoqgZO5iqoBGcQsOpymnVwaDDjic67X5pWdV8sGhwmKCLUbjbOpqI5y05UOd+Xlp1BazU9/kvPhKpcAhTaLtcY4R2Rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Fri, 31 Mar
 2023 00:44:07 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%3]) with mapi id 15.20.6222.034; Fri, 31 Mar 2023
 00:44:07 +0000
Message-ID: <c4ff442d-706d-bb00-84af-c991454a37de@intel.com>
Date:   Thu, 30 Mar 2023 17:44:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/16] iommu: define and export
 iommu_access_remote_vm()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     Baolu Lu <baolu.lu@linux.intel.com>, Vinod Koul <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, <iommu@lists.linux.dev>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
 <20230306163138.587484-9-fenghua.yu@intel.com>
 <f7b0cbef-3d7d-e5aa-1971-fe230d0c80e1@linux.intel.com>
 <932aebd3-c655-3266-1acb-e41e8cbfb771@intel.com>
 <ZBhhEK1V+u2oV2Ll@infradead.org>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <ZBhhEK1V+u2oV2Ll@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::15) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA1PR11MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: cec9f87a-44ef-4542-d2fb-08db31810901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMhAN0t3ZdbHI8BXoDnbsrq8pdD/LPhQNAc3Sma4syxBsA20TSSkauvopEBUigLFh6TfBOlCwEn+FW0D8j7gR2Bl4ZL4Gk4nQfb7ed2XY48s/NVWc0jAVqYaeOU2O0yTO3N6Mi5Y2PlY71dgA5t5COaXS36WH35D2om+Gil3hVoe6LVXjjZmQDlqLxcmcNWBQHqXJHwnv6uNvowrQPY6yLMbXXCKuFfUPhcd2KpxaknmyIVgCrPhXocnMAqYSDxtrnO6GTrBbzW/JASxl+TXo2Qgo8HWGuVQbeXoDyCoGFR+EZqjzFK9+/3lOzyNC3tKo4Saf9MevG1psYprsqHlvWgHg+J1wqUfTGXJgtmoRoGZDbeqPV7PuKBJpdfFuqPty3+KqQ7YOUtTy4TEocNxqIQqpOiNvE/ltbQep65aXKn0jwK6DCdW3PGOgzDso1y55ve88nE4rNlhByyIVmlJvVx2hrx7pBmwbihH0w/U4nUjc0yC1izB8jEJE6IXPm3WGSg/aWgMHESoMe+xS4ogMcGS0n0+boKPa7nugxa3kE832UiwHpRK0B38+QoM3y4h55+a5iM7u9V4rI1dzTI2M9SnC/p9m5KITujPz8bqm6thyjQi+gqUqbbRLi7/JSxqoJBVoKOyWcuo5/z01kmV3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(31696002)(86362001)(36756003)(83380400001)(41300700001)(4326008)(8676002)(316002)(66946007)(66556008)(6486002)(966005)(6916009)(66476007)(54906003)(7416002)(478600001)(2906002)(8936002)(38100700002)(5660300002)(82960400001)(44832011)(26005)(6666004)(53546011)(2616005)(6512007)(6506007)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFCSHY1eElDdGpnUExGdkpQeXRuYm4yL2xVM29xZjQrTTM2cWRmY3l3MFI3?=
 =?utf-8?B?N1ZKaDFVS1M4a0xPSjNKREErK0czYVlidVUyeEZNQlZzMENBdDVzcFc0dWkz?=
 =?utf-8?B?WXVlWFdEd2JDZWxyanU0bU9oRXUyb1l2RHlOblNaRzZHTVQ2VTJlRUNqNzRZ?=
 =?utf-8?B?V2t0Q25HblcyV21PcGdPYm9Za1JUSlJ6WjJJS0R5OTNoRThIUGE4MGpEM1d2?=
 =?utf-8?B?TUxWdm5LREQ3MkRac3ViazFHbm12dFFwME51VjNlN3RjQWd5dlFKZzMzdndh?=
 =?utf-8?B?TFd0VG9aQk92SmJTOWVTT1I5RzFnRnJKb1pCTkZrUTVQMk5rL1BRTVRwY0FD?=
 =?utf-8?B?eU5nR2dWWUFYVWtqNmFDbEtvQUFKMDBpcEVRZ2FZVWlQL2RTR3poMXM1eWxa?=
 =?utf-8?B?SEFrS0ZFeVVLZlVOMjA4SS9rdDBaNEN4c3FCY1htOW8zVEVOSjJZaEUwb0pP?=
 =?utf-8?B?UTJrcTRKY2JZdWZRZTM0SlMzTHZ0S3VZWUZjQStrcFFXcm5yeXVVNnYzR01U?=
 =?utf-8?B?QUhSejlFZGtsS0FWM3VhYmlpdFdabmM1ZnkwdkZrbm9Bbit2YXQybktSZUFL?=
 =?utf-8?B?WXFlRzVWQ1BTSzFHY2VRN1ZHS2JXS3NNdm5GdUtDbjZhaSsrSTBnd1o1aUd2?=
 =?utf-8?B?bHdxTnRCQjkvcGZlQkVYckQrOCtuaEFvcjhpNlNoSzl5ejQzcVp5VEhvcW9a?=
 =?utf-8?B?aXQyNDJKUFdJaUxseUNaMjNPRG1kOWhjUnNPUXhMcGRIYVE2Ujh6N1RVa0tv?=
 =?utf-8?B?STNGSnp1L2ZDS1BxMFgxWUorUXlPTFlIUFpjOWpJREtmOFVDQmdiNU1PSU4x?=
 =?utf-8?B?Yk4rQ0IyU0gwbFQvNFBpOUM1UXhzaklpS2lHeG9KZkxpUmVacGFFNU92K2hu?=
 =?utf-8?B?bHIvRHB4dFNoSXJrUnc1d2hhOVorSVJNSERadkNNZlJOeEl2NlpDcm5oYmdw?=
 =?utf-8?B?RC9XcVhiSU84dEhZcWhmaHV0OFlPRzRmWXRUaWdlRU5oODc3cnhqTHpOeTNV?=
 =?utf-8?B?YVpnYnpLWVo1R3IxdmNzVW0wRUc2d2lTZFJoYWZLZXpHcDNPZkN4Z1VjN3M3?=
 =?utf-8?B?MDdUbnZmZUtXeTVUbERGRTVnL3o1bTE4aHQ1OGdUMTQ1OGExa1REaUVVcGRn?=
 =?utf-8?B?MHcxeUxLdHdOd1hsZ2tobnpydi9nb1RGcGk2OEFTZWtJdUcxb2x3aUxJaWlv?=
 =?utf-8?B?REpJbWQ5RzRJWHNvNGJhRStFeTF4SmEzcm9SdENSR3FyQ09xWHI5dUpMUEdC?=
 =?utf-8?B?dmNGQmR5a3VSUFhFNVNsa1dUT0xSbVFHdzhTMzNweWplWTBRRDdlanhFOExt?=
 =?utf-8?B?OUVYK3RYditoNENZVVZFd2dTdzFqNEtpd3B5b09HYVZ6Vnc4VkJEMzJxS0Nl?=
 =?utf-8?B?bkVQY1dvdFpxTzkrQXZUbTcyWDE2OXdyT2VtcDJJMkJlU2QxWnBiQUR0R3g5?=
 =?utf-8?B?RjlkRUlydkxubW01cTJiQmVyU3hncGtWemhQS1VPK1BSSUYydGtNTE4yRzJw?=
 =?utf-8?B?WlVYY1F0U0ZvdUhrcnhhU21YQmRQYzl5UlRGdFRDQ1VCckVUbFhRc29yZFhI?=
 =?utf-8?B?Q1JpWVRzK1Y4MFRvUFpibU5qTUdra3A5NUNGTDdDejErN0FBM3k1UWlsV2Vr?=
 =?utf-8?B?VXk5aHV4Qys4VnRLVzNteXZHaFhWSVJyVEE2YmxsOHdiZXJxamczQ3NKT1Rw?=
 =?utf-8?B?dVNoS2Y2OUx5enNVSVlNajRPZjNSdzRvZkR4eFZqR2dzRlExdmxJMy9WOHF6?=
 =?utf-8?B?Q1h0SE9HTjZBN0ZuNGpHdjc0U3pBcGpiZnEybDM2V3RwSzJmRy9UWENxd0xF?=
 =?utf-8?B?TW85Nm91VFFzK1djaWJXMUVrcXc5Z2gvRXpLSkt5NHphQ1hwdVYwYStSR1R2?=
 =?utf-8?B?VTl1UVU5REI4RjhYM2gwYzJLeTFXYTgxTUYvWVd3eVFsTlpGMjlES052MHZo?=
 =?utf-8?B?bFYvVGVDR3BUQXBQVS84RWlLcXQvQTFtd2dWSUVJY2dxR2V1YkJSUWNzejJY?=
 =?utf-8?B?OWJIUDdnRnE3YXJ1TE5kUnFZWVBveS9aeEppTzBTZHl3dmhNcTZUT1NKZE41?=
 =?utf-8?B?MFhrWkNEelBCOGVIZm5KclRIODd4SU1rbGhjeEJRYVo0bzM0NkFiM0NmekYz?=
 =?utf-8?Q?hf3iS/S9Gtfo9cpXh7CjX9MUh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cec9f87a-44ef-4542-d2fb-08db31810901
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 00:44:07.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAhp+eW+KQPsymVFZyv2j/e0V3HP7v72qPzG/N9jtbzazGVlhAJExWPdxQm2I2Zql8f5P/3lum0jjGbf829W/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Christoph,

On 3/20/23 06:35, Christoph Hellwig wrote:
> On Tue, Mar 07, 2023 at 09:55:28AM -0800, Fenghua Yu wrote:
>>>
>>> I don't quite follow here. Isn't I/O page fault already supported?
>>
>> The following patch 9 in this series explains in details why IDXD device
>> cannot use page fault to write to user memory: https://lore.kernel.org/dmaengine/20230306163138.587484-10-fenghua.yu@intel.com/
>>
>> "DSA supports page fault handling through PRS. However, the DMA engine
>> that's processing the descriptor is blocked until the PRS response is
>> received. Other workqueues sharing the engine are also blocked.
>> Page fault handing by the driver with PRS disabled can be used to
>> mitigate the stalling.
>>
>> With PRS disabled while ATS remain enabled, DSA handles page faults on
>> a completion record by reporting an event in the event log. In this
>> instance, the descriptor is completed and the event log contains the
>> completion record address and the contents of the completion record."
> 
> This seems like a completely broken I/O model, and I don't think Linux
> should support this model when it requires operations like
> access_remote_vm.

This patch set have two parts:
1. Basic event log support and PRS disabling knob.
2. Completion record page fault fixup part. The current patch is the 
major patch in this part. It tries to fix up completion record page 
fault from user space.

Since the fix up in part 2 is debatable and part 1 can be sent out 
independently, how about we send out the parts separately?

In the new part 1, simply warn on completion record page fault and don't 
try to fix it up. Usually a process executes ENQCMD instruction and then 
keeps polling completion record periodically. So the completion record 
will be likely backed by page and won't generate page fault. If page 
fault is really an issue, sysadmin can enable PRS (which is enabled by 
default anyway) and let PRS to handle page fault.

Then in the next step, we will send out a new part 2 to eliminate 
completion record page fault. One proposal is to mmap() kernel allocated 
completion record area. So there won't be completion record page fault 
and fix up(no access_remote_vm() of course).

Is this OK for you?

Thank you very much for your comment!

-Fenghua
