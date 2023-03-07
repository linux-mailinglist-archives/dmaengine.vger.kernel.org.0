Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE166AE6BA
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCGQgV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 11:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCGQf2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 11:35:28 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E896F11;
        Tue,  7 Mar 2023 08:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678206858; x=1709742858;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gh5Kvp39TSzQ0O+sOxFzwwGo70CPYdBF6EwlUqwMWPk=;
  b=Wy/rHgEp+Fqq+6Ytk2jMucTD1NF/XBlxQVUNCVm1/Me/pNTafx58QRQR
   6OsfLbcoTBPDKFh3CMRQpe34AXcJKR0CBd4Gv+3/9jYGuWVQna0N5Trgz
   k9k3wdkyk2p5osR1qy5YwaDzmKgk1ZYzNQgS6F8bDHY/m+l3f89xYvNPH
   KwzxVto/pOOyOox0TLX85EWneQy9hcg1qaHuZNpWjw3aoivRYcPr7Lc0l
   PO+h1P6FGFesXN3cdvHqYMvcrCKaocPP8obtTLxEugp3O6YWIFfYe0Ixs
   vSgKQgFBkAymmwJeRxl4UI5GSDYjn24wCiTdV6hsu59iFehqS8Y2cMt4x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324204836"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="324204836"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="654032542"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="654032542"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2023 08:33:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 08:33:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 08:33:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 08:33:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 08:33:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8fADJvVOO74dL/Dv/97YfRN8MRSaULrKJ3s2GbuN9oQxVFqqC3qmQmAXTbRIkdB8VuBUnWUr9kjFoe3TGuqTTyTJNo8901rhG5aYDKvnxLUwAdWIv/BSMw6rnAdflCqAjJOy+Ffrqw7gx9sf57R5XKdF3bUnGe8cii6KQz94fPz2J3+s2VmyR371I1PTEzmCkzFGRzHjd0Tub+TZBa7FCtEqiPnHvAdX9SFO3Tw5D3BD5dvVXXTq9EOMRHXSUb6WQFqHVljg5Qih/VZQWrMMTIA2f0fK0oPo7SItKYyFl4nCWeSFPQmwKqBCTuMS+GFzjLaa5Ow2iysHRyul5cbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN6aJoqz1ZPGF/yyQjTf2ip31TPOVfALNQgLzcG6Lcg=;
 b=INBdf0P44weAhlYZRmn5rnVU+/lqaFVQ1xuMTlpzjTDtFsxTf28u0g3Jllnlu5jKaSnEBo429vl0+OLyB7Pobeoa3pmNk0s3Ts8eCn676q/JJvZ+9rKYYNQIQiPPcO+FycXhMpCjQPcZGSYQ08JA+o3e6Ld9ZeTA706awKvyeCnIOwz84wAe65zVnbGp87Oc1C2jQixsF1rLNSJejnABb5SHx0+oE/oFW8rjJ5+d3BfAoboLPwu8cpOqst6Ze1MRYo0/u5LyGJGRxAmYgd2+EeiJocjScDKq/7ZrWyNotvDeezmXxx+A7dS0lIJj0nha9YysFvJly+TDerrpjl6b9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 16:33:12 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%6]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 16:33:11 +0000
Message-ID: <156f9e28-e7d2-b443-1aa5-1f5447cb9bbd@intel.com>
Date:   Tue, 7 Mar 2023 08:33:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/16] iommu: define and export
 iommu_access_remote_vm()
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Lorenzo Stoakes" <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, <iommu@lists.linux.dev>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
 <20230306163138.587484-9-fenghua.yu@intel.com>
 <20230307084058.GA1330745@myrica>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230307084058.GA1330745@myrica>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SJ1PR11MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c9d617-f33d-495a-452d-08db1f29a475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ME/2nhl9SmDtPsc+6Yz1WV13N7hMYfGCD6EUogSERs09t7E1z4KHk45dH4g+nLvd4+QtETXViqgoJTQUtsUo1ifAuhzWpwJzg5XkbH2rHLxvzrc6gxBmOgo4LjaR+u1/rZAtAtocRFhvCJ7ahlaQinDrpzFnKOrn4eJDAxak1b2p0qZO82jJH3hmb0G4o4ZWB1YjmhYCrAVL5XbXEOb2vgXUXQX2UwnXuNZENnq7nOsesleKzqyeBqgROMkdRjhNbyV3IJ7cfVoo7ggmDt2/WNDZcA78KLifxFfhmu86zDeyhmxUzYebpQAxVTxHiFRLPuEe4SF8F9vYoCpPdLAxMyyBPzLq5kSRNKTBHazRZAYeuQU9RcBpjkc1pRNEtIDF8nJorUR5vu9mfAyFi6btYqtPCpogxeMs11s5cSeYWNRZy3DfRLt7Sm3JNDL2OEtu/oyi6ynJaEqqK2Bbkgja3UTbxM730Tu0iJsaNGRM5CZPVYilj1iE7Ux8H+bxE7HX3E+t72/jQhLjAQ0nM/XDHwaTaZ9+vDwv0PDw7IVR0vlz6tBBDOYDUqpAkTdHc1hycMru/KNDBREJYGP1fjU0us/tTHlcrmBMEmoqbWA6IQkoKZSFcPRb8RwUHJv7VjUSZfzurpUwxFKjYPymjzkpytgZRISPcAwWiqv3ATUvXSg00jbKv5gcXgW0E767dfr3bLE0AQ4D0cCuEzfSYVRwS2lfhr58NAOBLd0NH0Avk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199018)(31686004)(8936002)(7416002)(5660300002)(44832011)(66556008)(66476007)(2906002)(4326008)(8676002)(110136005)(54906003)(316002)(478600001)(66946007)(6666004)(6506007)(36756003)(53546011)(966005)(6486002)(6512007)(26005)(2616005)(41300700001)(31696002)(82960400001)(86362001)(83380400001)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmVlL2FkR0p4Ky9DK0djak94Z3pIQkVzaXdyM2cyOGVoTHE4dEZNQ1ZINUh3?=
 =?utf-8?B?R1hnV2txQ3dEZ0NuK2tLSVNHWlJNUzV2VWk2VE94MGtYaUI0TDJlekhrT1JU?=
 =?utf-8?B?c2p3SkV2RGtYU0JoVWZPTkFKeXV4SjNwN3RXWkNxUHY1VEhpblg4RVJhcFBr?=
 =?utf-8?B?Q0hnSE8vQ2hXOVRLUnFkRjRTc0hjQlk1eWk0cmZCS3hHekFnMnh2dlZUTVV5?=
 =?utf-8?B?cUJ5MGNuT2I5OWFpM2Jud0YzcEdjdHp2MC9IWDNOQml0MDUxSzZNckpEcGZH?=
 =?utf-8?B?RkFlVWFMT3JDRUI1MjdVMG1yWUI5YmFGM0kvems0RU5rWlhBUGxVMER4Q0pD?=
 =?utf-8?B?dDRlVE5WUGg3VFZGUXhHdlRKODNCS0NsMkM4bm1BaWIydFBOU3hMY2NrY1cx?=
 =?utf-8?B?cXN5aTZsY0Z5YUtIazlWQjFtY3RmUmtqTjJCYmtPYWlEL0I4Q0tFc2tuYzJR?=
 =?utf-8?B?UWZHeHU1bkZnWDBNQ0ppSFl4NFM1eVNjdCtDa3FiWE9mWFl2VVhLMnhmdkJm?=
 =?utf-8?B?c3NzMmp1S1dKUUU0Rng5bGxDMWFQUXdVbkJFeGg3SHFvdWlsbjFHMHdmNkgw?=
 =?utf-8?B?MGEzOUtYbnQ2RXlGMDFoU2JScWtCWmYyQURsOVlkV1FzZG9adHJ4SExvM0Nh?=
 =?utf-8?B?QzJYNTFSbnVpa0pLV0djTUh2K3NaelVIQ0I4OFlxTGlkeGFjdm9IcE5lOVVi?=
 =?utf-8?B?Vkd4Z3ljZnRMS21EbEFFa1J6amxaZEhqa1BFYmtQUVY4YkZYRkh4ai90aVlz?=
 =?utf-8?B?TktaRkZDTkR0TkdpeGNNNjFVLzNkWVhWTFZIY3NBZktXeUVxTktpNlZDRElU?=
 =?utf-8?B?cmpwbm5kUHdZZy9FdFVKRVR6KzdaYUNSVXY0amxSZTJYa01ocnpsdHpQeUJR?=
 =?utf-8?B?MjUzMjlLbGhkbmVRRDAyanhEN2lkaGhRUy9VZUhONXhUZVlRWENMTzFlcWhB?=
 =?utf-8?B?T1ozSjA1a1l0eko4U1NjUXZ3dzNuRXMyMXpkQzU5a2UwUmZDcGhaYTNWSzkw?=
 =?utf-8?B?QjA2OFduMGNqS1hwZFh5SzBpaXpTTmhuRUp1LzVPSm5RQnNNQXNoNXBXZVpO?=
 =?utf-8?B?eFFtYnoyenA0QmZxcnE4QWl2UGNYUzF4VVRhNmRUVFBBdndEZ0ozMWxmYnRt?=
 =?utf-8?B?L1puM0ExYmFRa2N1S1JvYVR3L0ZuNG4xaGZoLzNHdjRONHZhQWE2L1ZKVkxt?=
 =?utf-8?B?VCsvcmxNaHpuckp0MWdGTGM3UTBiOEJpeDBRYXRqN3JVclFOR0RoM3p4Uyts?=
 =?utf-8?B?K0JTaUZTMlRUdzF4L2xtb0k5bnVVYXhtMW55QWJjbVdpVlFFNXZWVDV2QTJ3?=
 =?utf-8?B?eGZoVjJCNFVVVXFPYm1MeHJZdTNHQVFPNm9jQzNxK1lmaUxiMmpYUnl0K3Qv?=
 =?utf-8?B?NkNyN1RrVkJRZm9TMGlTTTM4eDl2b3dJUlpMcENJblVpZk9JRVMxZW1teDFl?=
 =?utf-8?B?a3U5SEhXMmhxdXZaVVFPSTUwMG1ibDcxVVFlNUVTbWUwVURiY3NlQTZWK0tL?=
 =?utf-8?B?NEMxdW5uWjNqT1JJUDU3TDFtakRlMVdxVE9DWWdQRTAwcUtTS2JmMHJWeVY3?=
 =?utf-8?B?YjZPNmwxWXV2ektyWFovL3dUUnBYelhOa05JaFNSOUV4bm9kOVFDU3V6eklt?=
 =?utf-8?B?MUlmVUd3TFZxaElZYmtUdWowMDdWRGZYTHhSSURLT1crSFJhTElZZk5VenZJ?=
 =?utf-8?B?ZEdiQlJPYjF6V0pvaDFCZzdvWVlQeHFVMFFFaXFpdDliL2FlSXEwSUg0T1c0?=
 =?utf-8?B?aWt1QjQvelhVVE5OU3Irb2JOdGhYYWJJNGV4S2V3ZlpGS3p1NS9LWS90b1Bt?=
 =?utf-8?B?WVpobGUvYkhna0ZGNWNYVFNjT0RmclhMNXg0NDRuaDhnQTV0UUEzblNnQWtV?=
 =?utf-8?B?bktXZEYySDJ1NndidmRUaklycFl5bGV0RVhmcXlpNkQrTVlRanZaT2x2TWVp?=
 =?utf-8?B?UWhFLytxZXVFMmpZeGFUYVkzQmREVS9LZGxNTEFMNlRrVUdydjVDdGVEYzRm?=
 =?utf-8?B?Y2tlNllQYUFFKzU1ZWtTQ3lWVFJYMzJSM2h1SzNHTDI0ZHV5T2ZLMGFWKzhC?=
 =?utf-8?B?VVBJRE1IcnRrbmpSQXlnQ1lxRjhPZHRyZWIwcEpVcnZkWHpDYlJYR1pvUE45?=
 =?utf-8?Q?/sIyrIJ6nnKeFk5SUz07HlAcZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c9d617-f33d-495a-452d-08db1f29a475
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 16:33:11.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiUH7zi2/D8iJO8/jb8R+3+yy3p1lw55kWRVyRAssyrjlKMSRIFEtCsmKZFN0SfrC8QMcRUJGdDLFSDdnCRVkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Jean,

On 3/7/23 00:40, Jean-Philippe Brucker wrote:
> Hi Fenghua,
> 
> On Mon, Mar 06, 2023 at 08:31:30AM -0800, Fenghua Yu wrote:
>> Define and export iommu_access_remote_vm() to allow IOMMU related
>> drivers to access user address space by PASID.
>>
>> The IDXD driver would like to use it to write the user's completion
>> record that the hardware device is not able to write to due to user
>> page fault.
>>
>> Without the API, it's complex for IDXD driver to copy completion record
>> to a process' fault address for two reasons:
>> 1. access_remote_vm() is not exported and shouldn't be exported for
>>     drivers because drivers may easily cause mm reference issue.
>> 2. user frees fault address pages to trigger fault by IDXD device.
>>
>> The driver has to call iommu_sva_find(), kthread_use_mm(), re-implement
>> majority of access_remote_vm() etc to access remote vm.
>>
>> This IOMMU specific API hides these details and provides a clean interface
>> for idxd driver and potentially other IOMMU related drivers.
>>
>> Suggested-by: Alistair Popple <apopple@nvidia.com>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: iommu@lists.linux.dev
>> ---
>> v2:
>> - Define and export iommu_access_remote_vm() for IDXD driver to write
>>    completion record to user address space. This change removes
>>    patch 8 and 9 in v1 (Alistair Popple)
>>
>>   drivers/iommu/iommu-sva.c | 35 +++++++++++++++++++++++++++++++++++
>>   include/linux/iommu.h     |  9 +++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>> index 24bf9b2b58aa..1d7a0aee58f7 100644
>> --- a/drivers/iommu/iommu-sva.c
>> +++ b/drivers/iommu/iommu-sva.c
>> @@ -71,6 +71,41 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_sva_find);
>>   
>> +/**
>> + * iommu_access_remote_vm - access another process' address space by PASID
>> + * @pasid:	Process Address Space ID assigned to the mm
>> + * @addr:	start address to access
>> + * @buf:	source or destination buffer
>> + * @len:	number of bytes to transfer
>> + * @gup_flags:	flags modifying lookup behaviour
>> + *
>> + * Another process' address space is found by PASID. A reference on @mm
>> + * is taken and released inside the function.
>> + *
>> + * Return: number of bytes copied from source to destination.
>> + */
>> +int iommu_access_remote_vm(ioasid_t pasid, unsigned long addr, void *buf,
>> +			   int len, unsigned int gup_flags)
>> +{
>> +	struct mm_struct *mm;
>> +	int copied;
>> +
>> +	mm = iommu_sva_find(pasid);
> 
> The ability to find a mm by PASID is being removed, see
> https://lore.kernel.org/linux-iommu/20230301235646.2692846-4-jacob.jun.pan@linux.intel.com/
> 

Thank you very much for pointing out this.

I talked to Jacob just now. He will keep iommu_sva_find() function
in his next version because this patch is still using the function. He 
agrees that I can still call iommu_sva_find() in this patch.

-Fenghua
