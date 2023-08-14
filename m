Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8846A77BC6A
	for <lists+dmaengine@lfdr.de>; Mon, 14 Aug 2023 17:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjHNPHx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Aug 2023 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjHNPH2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Aug 2023 11:07:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75909E6A;
        Mon, 14 Aug 2023 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692025647; x=1723561647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HY+/+7u9plrd/VtBq2Dl/sILV8KLhzVeConVMCoi3cg=;
  b=J4LpkQiPdt45Ll3ZJ15IQ9lJ9BfgymKk6aWEpr51hsSUnYJdZ5x9wURm
   5tBgP8dJXV1v54MwVFZwuzaGAcDzOpQ8cTrB8MCbhmAnQYZfCBegZ3KHM
   2mXoOR1p/Ns3eV8aVnQLvuzZ+l4+WeDGt1BQQRLjK2GBAL0tWyIcfy3/q
   YZgNwJk9wqoMd3FdM4wkzPfHpiRBkH4MmR+nzB4IeTydZBfO7Way+4d9a
   1zGT8tCoRtmkMf2dIkmrGR/xABxQWBwQgTBz+FSAUdE8OHJuPteqtyPfK
   ky3LcQBfGm5XOhU4sLfXPC++o1muf6Jq/IkN6fAo8k0JY+4K93i+W/X9S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374833632"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="374833632"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="857118476"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="857118476"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2023 08:07:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 08:07:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 08:07:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 08:07:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK7VTGsNpO7L1UYqPHSuY7t87o3rOmakcIlq7LSg/FuyImCge+06t23TKhIdQuEw5lpOygay2ciZ6QYMbKHxFEpIG3rnq9A+bjv7A6smpBmC0b4pHqWWBwN12NbdKzacS1bo7KJzgLf6Cqu1xFwzj2N4t/04fB+CDWN6O0TBla2TUcdAKFPuPvXxJQuAebaW9cvGq33Q8ap3nPAl7oqq6lxl7cO7K/SqZ4Fq4z9rJVCS03lec/z7DUkD3VFHK0xJL/wJcrg2lcJNCuvyjU/j15imKkQ637XOrwTqd6q0+EitZRLtKBwNYkIRGzzioE+7izIIukwFYkMXuG8w+I+uEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwaHx8eNXSW7P9ZVMkbPGteXuLplK/BHef62lspGkCI=;
 b=KvkdIhlYVQxsROHqOQZ81KAgNcqck4X2vxAJN6tfm8N4L8X8a8iKFmLOzMJ46Tm0AAG+vIgirLoREbPzrozJ3Wc5X3Lhr6lc34RD6x7WMl96eiI4Aw1LxjvXk+2L9tBJcVht8bLdMf5zDQgZqvdhC1VDGAwp7R5rxKc9vRuPQaa/oXrdXjZR7k1o+D2IdjWhYILFgKvv4RkxKBqxdVehTJx14dWqDsOe7gwgCCbvX/0LWgjjgo767utw92wkLbMU6xBaQafMv4KVGT9yoc2jjatysmZQfyMGIbEK278r+ylTN8XThYbzKGKVRJ17QQCkcc/jkCbVDJW3HWEMcNEvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:07:02 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:07:02 +0000
Message-ID: <55f7373d-a908-fb1e-bda2-290cc520ebc7@intel.com>
Date:   Mon, 14 Aug 2023 08:06:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] dmaengine: ioat: fixing the wrong chancnt
To:     Yajun Deng <yajun.deng@linux.dev>, <vkoul@kernel.org>,
        <bhelgaas@google.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <a93a087d-cfae-a135-999e-ae1976694165@intel.com>
 <20230811081645.1768047-1-yajun.deng@linux.dev>
 <148ae07079b42d834a19b100e18070f50acbcc78@linux.dev>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <148ae07079b42d834a19b100e18070f50acbcc78@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM6PR11MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 26655f34-15b0-4f25-347a-08db9cd81d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCqSFgApECrIXG7VEGyvXYRizRhB77+lnSmjYOjff7gaHx37xyBKRkVnUdnS873lnc8r7sNmA0TLPk+8Ug3a8usDuhOgYamu+nTDTNoBuORX2vawlDzf2GqSELZl9fgckbT83JyJ3ZE7zALnfHGykOpyUWZupR4cWQqnHhF6Zuh9Ouv41V/6ZoC0lLfpScc4qZVG1mwkrN3qV5jMEHEc2Z+4/GhRTuq2arqEY8DHhUvJkGmVXSnBdIM7Kdfs0TfqhncqF+dLOZtD9PY9lZbvrpytKDQfacZ1PkB97JQxzG1qxb5Kj+gNTgNrrYfHBEqP+ejguYYAhqJKHih95U3l6BUbcJsn+uN5mkFDmRCUfbgaJ9dyDAWCMmW40Esbr6S7HUhNzdsVp4ypDBWerfPIlRe9nF1ppbAGsTZqOom0ec4bUl52VR4lS3rVa+R/47sJRy4elZ/G7PUFH+ac5ij2fqJNn9Q0lDEZGgZpFKlwqDzT7SvY5cEGLybzgFAo87/NWNrwiUWDzRk0ZzPjVVeGsnGzabLIwsU8F4wgjAXhpiS+fC8cGQaCVH+t3GFsBOjr1CjPcu285RvKyMCTvlD6TuwbW71qVrRrGfPgzzjgOaC8ZtZtQ8wRrhKGQeA6+C/WJ5vdVqPt3piCS08ldMaVzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(186006)(1800799006)(38100700002)(6486002)(6666004)(478600001)(82960400001)(5660300002)(2906002)(36756003)(86362001)(31696002)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(83380400001)(2616005)(53546011)(26005)(6506007)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNpQXJyVkVPNXRucWVRZXRJNGNDem1XTmdkU2IxVUtkb0tjaUltOENVNVh5?=
 =?utf-8?B?Uk13UVlxNnh3bVloZ0hrbHZ0MnBidEFkNnJpVENiYjVHc25FOEVuL1dMZGYr?=
 =?utf-8?B?alFScGp6ZTFGSDlJL05Kcm0wZE5kcGtRZE5lT0VjNmhiMVRETUdPMnpKUnpi?=
 =?utf-8?B?ZzZjUStaMWhnOGRzREt0QkJtbzhtdEhxV2h4Nk9CUG12c3UxeWJnTTMxek1J?=
 =?utf-8?B?c01qeHFWZzRORDhMcElyRlN0RjN0QnYwWDR1Qy8rYU55TlNrNW1lRkozVldh?=
 =?utf-8?B?RzkreUprNUN3QkkwQkNNY1pvUTVNb0ZuNlBveFg4ajBWN04vV25UMFh1SUVk?=
 =?utf-8?B?dm1vbDNkZkNra1FWUFg3MS9qRjBIR0xRTDB0TWYxVG12eUNDWlFscWVSQUdL?=
 =?utf-8?B?aWVBRjA2T0NQQWt1eHhRQkp2VkNlMG1ZNzBScHh4NUdFMXl6azBVVzNWeG1t?=
 =?utf-8?B?U3JmWkIwZVE0eWhkTVFhdnZSV2RNVlpSNGxhbXlwSnlMM1RtOVVOTUdSdllU?=
 =?utf-8?B?M1NqdEZDSDh3RjhZQkltMURYVkpuS0ZMb2JRbXRnaSt3bDQ1Z0pYY1NvODht?=
 =?utf-8?B?SXYwWG1ET2Y2YXpBbC9RalExajFySTByZ21vTXZlRlV1bHpxMGtmU2pBVUdt?=
 =?utf-8?B?ODZ3aTdTZHk1WDNyVkFzUEFKYVN6czlHdWlCOGV2Mjh0MENqYWJJVHJac09s?=
 =?utf-8?B?R3g0Z2VTTm1mYkNkRS9TYjBoVzhqSTdrWDdJSERHRVkvd3BZWjFTWExwdTVi?=
 =?utf-8?B?ODBjMllFTnRONXp6S2tiT2c0SnpWb1hDd1BubXgyY2J5dDBIdm5xajRkNk4r?=
 =?utf-8?B?NHlKeDg2di9IVlpYV01QRWlleHdqVFVSdTc2aGFCU3J6Y1FlQStrWHJpQzZ1?=
 =?utf-8?B?ZkxId2RzUjRoamdoTzFqc1d3c1lvdEVxUXlTZmxQUExrTFNqY2NOL2hEVjZk?=
 =?utf-8?B?UEhGMFh2WEFQNmliK21WYVE5TVlkRTh2RGFjT1A5NTRtZWlmZTNWaU8xL0lh?=
 =?utf-8?B?UUZXNk8zSmpTaFZWWmQ4MTVSK2psd0lFblcxWGpqSWNFRURvTytjNXI2TG1Y?=
 =?utf-8?B?RFRhUWVTc0JBbmo5cXRKcmg1bE13Um1pUmJSanhiQ3NwYUprV0J5YXhjb2N3?=
 =?utf-8?B?dTI4dEZZajFBbERTNFdTVUdXMStRcHpoTWFlcWUxR1k5MlJEdk9mQXRnOE5S?=
 =?utf-8?B?dytiaU9zMTJBS2ZTbDNURHBQV2Z4eVN4SGE5TE80ODM4NjJXcmd0NzBFM25J?=
 =?utf-8?B?ZTRDY0FhVE9VQ3RhRFdpZGVMYWx4ZFFMNGcwYngwaEJvZkhySFRnRXZ4UTVO?=
 =?utf-8?B?TVZjdStCNVhOVEw0SVVjR2VwZnVCUDkwTlg3MXZUQSs1MEdmbzE3OEhibGJB?=
 =?utf-8?B?Ni9hZkdXWnkwSlJvNUxPOHE3dEhETUVta2dacS9vTDBZZjFCeEJ1MytsMXVt?=
 =?utf-8?B?LzRSdHJNVmd6bTM0MkNkTE1wdXRDT2h1VXlkRTVGWVFuMmUwTzV6YVp0dmRp?=
 =?utf-8?B?RVBiVVprSWhSNVFxN3E0SFdZTjFMQ1hYU0ZKajIwSVM0eTRNNlBZczhzWGQ2?=
 =?utf-8?B?RW9LTXJDbXRKNDloOUpGTCthRm1iaitXZzdYSVdsSlpjcUIxdDBLMWNYNW1U?=
 =?utf-8?B?VFBHVVNyWXhMQ1RsbVZKaGhrS0JobXFDbDBHbEM1Q0Y4dkNzbDRISFRYbHNP?=
 =?utf-8?B?TXd5NTJhN1l4Y2t5QWltUVVKTlFKeWNUNHdTQk9JR0Jyc3NnOUNxdWF4UnlO?=
 =?utf-8?B?ZldGVDQ3eEp4YS92dE9vS2QxN3dwZFlaTUJZVjVoeDRGR1pvMG02NVIrUnhs?=
 =?utf-8?B?c0kzODU3Vk1Xa2lNZlpYZUYyeVVQREV6NVo2YVlKNU5uWkttOUNlanFQZG5K?=
 =?utf-8?B?YjE2ZEIvbFY2RWxNbG54WUU4U3BYYmQrczBEcFRhTHFXSlhIaS9rVHUzNHBB?=
 =?utf-8?B?L0FUQitmMGxBTmpMUXZ1RFFscWFNcHlVVmdxQXRrMkpiSFYyVXl6QXVnL1gw?=
 =?utf-8?B?SWsxVXVCQnRpNmdtc0p4RG43UlJEZG4zUTF6V2kzWFIyelZDYmQzQWJrQXdi?=
 =?utf-8?B?endabFE0a3hmWGlLRWVBRXF6YzUzSExsMUxKU0xQdS9uUFB1NHZFQ0o3eXNp?=
 =?utf-8?Q?sNg5/GTt4z0zjHaMcjiPHmK05?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26655f34-15b0-4f25-347a-08db9cd81d6f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:07:02.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wXlgjNZHnDsL1v3phG12qskGseBrZEzce/UOQOmrkVtxVpEsanmFGtxRHCIKB81N33eAp5GDJDJqh8DsH+7/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/13/23 01:59, Yajun Deng wrote:
> August 11, 2023 at 11:40 PM, "Dave Jiang" <dave.jiang@intel.com> wrote:
> 
> 
>>
>> On 8/11/23 01:16, Yajun Deng wrote:
>>
>>>
>>> The chancnt would be updated in __dma_async_device_channel_register(),
>>>   but it was assigned in ioat_enumerate_channels(). Therefore chancnt has
>>>   the wrong value.
>>>   Clear chancnt before calling dma_async_device_register().
>>>   Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>>
>>
>> Thank you for the patch Yajun.
>>
>> While this may work, it clobbers the chancnt read from the hardware. I think the preferable fix is to move the value read from the hardware in ioat_enumerate_channels() and its current usages to 'struct ioatdma_device' and leave dma->chancnt unchanged in that function so that zeroing it later is not needed.
>>
> Yes, it's even better. I noticed that chancnt is hardware related in ioat, so I just clear it before calling dma_async_device_register().It would be updated after calling dma_async_device_register(). And it would have
> the same value with read in ioat_enumerate_channels().
> It doesn't seem clobber the chancnt read from the hardware.
>   
>> Also, have you tested this patch or is this just from visual inspection?
>>
> Yes, I tested it.
> 
> ➜  ~ ls /sys/class/dma
> dma0chan0  dma1chan0  dma2chan0  dma3chan0
> 
> before:
> ➜  ~ cat /sys/kernel/debug/dmaengine/summary
> dma0 (0000:00:04.0): number of channels: 2
> dma1 (0000:00:04.1): number of channels: 2
> dma2 (0000:00:04.2): number of channels: 2
> dma3 (0000:00:04.3): number of channels: 2
> 
> after:
> ➜  ~ cat /sys/kernel/debug/dmaengine/summary
> dma0 (0000:00:04.0): number of channels: 1
> dma1 (0000:00:04.1): number of channels: 1
> dma2 (0000:00:04.2): number of channels: 1
> dma3 (0000:00:04.3): number of channels: 1
> 
> 
>> And need a fixes tag.
>>
> I've tried to find the commit introduced, it looks like it was introduced from the source.
> The following commits are related to chancnt：
> 
> 0bbd5f4e97ff ("[I/OAT]: Driver for the Intel(R) I/OAT DMA engine")
> device->common.chancnt = ioatdma_read8(device, IOAT_CHANCNT_OFFSET);
> 
> e38288117c50 ("ioatdma: Remove the wrappers around read(bwl)/write(bwl) in ioatdma")
> device->common.chancnt = readb(device->reg_base + IOAT_CHANCNT_OFFSET);
> 
> 584ec22759c0 ("ioat: move to drivers/dma/ioat/")
> move driver/dma/ioatdma.c to driver/dma/ioat/
> 
> f2427e276ffe ("ioat: split ioat_dma_probe into core/version-specific routines")
> dma->chancnt = readb(device->reg_base + IOAT_CHANCNT_OFFSET);
> 
> 55f878ec47e3 ("dmaengine: ioatdma: fixup ioatdma_device namings")
> dma->chancnt = readb(ioat_dma->reg_base + IOAT_CHANCNT_OFFSET);
> 
> It looks very historic. I'm confused about which one to choose.
> This is a bug, but it only affects /sys/kernel/debug/dmaengine/summary.
> So I didn't add a fixes tag.
> 

The issue seems cosmetic and does not impact functionality. Let's just 
leave it alone then. The driver is very old.

>   
>>>
>>> ---
>>>   drivers/dma/ioat/init.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>   diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
>>>   index c4602bfc9c74..928fc8a83a36 100644
>>>   --- a/drivers/dma/ioat/init.c
>>>   +++ b/drivers/dma/ioat/init.c
>>>   @@ -536,8 +536,11 @@ static int ioat_probe(struct ioatdma_device *ioat_dma)
>>>   > static int ioat_register(struct ioatdma_device *ioat_dma)
>>>   {
>>>   - int err = dma_async_device_register(&ioat_dma->dma_dev);
>>>   + int err;
>>>   +
>>>   + ioat_dma->dma_dev.chancnt = 0;
>>>   > + err = dma_async_device_register(&ioat_dma->dma_dev);
>>>   if (err) {
>>>   ioat_disable_interrupts(ioat_dma);
>>>   dma_pool_destroy(ioat_dma->completion_pool);
>>>
>>

I was thinking of something like this to keep the original functionality 
the same but let the dma->chancnt setup as intended:

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index 35e06b382603..a180171087a8 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -74,6 +74,7 @@ struct ioatdma_device {
  	struct dca_provider *dca;
  	enum ioat_irq_mode irq_mode;
  	u32 cap;
+	int chancnt;

  	/* shadow version for CB3.3 chan reset errata workaround */
  	u64 msixtba0;
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index c4602bfc9c74..9c364e92cb82 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -420,7 +420,7 @@ int ioat_dma_setup_interrupts(struct ioatdma_device 
*ioat_dma)

  msix:
  	/* The number of MSI-X vectors should equal the number of channels */
-	msixcnt = ioat_dma->dma_dev.chancnt;
+	msixcnt = ioat_dma->chancnt;
  	for (i = 0; i < msixcnt; i++)
  		ioat_dma->msix_entries[i].entry = i;

@@ -511,7 +511,7 @@ static int ioat_probe(struct ioatdma_device *ioat_dma)
  	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
  	dma->dev = &pdev->dev;

-	if (!dma->chancnt) {
+	if (!ioat_dma->chancnt) {
  		dev_err(dev, "channel enumeration error\n");
  		goto err_setup_interrupts;
  	}
@@ -567,15 +567,16 @@ static void ioat_enumerate_channels(struct 
ioatdma_device *ioat_dma)
  	struct device *dev = &ioat_dma->pdev->dev;
  	struct dma_device *dma = &ioat_dma->dma_dev;
  	u8 xfercap_log;
+	int chancnt;
  	int i;

  	INIT_LIST_HEAD(&dma->channels);
-	dma->chancnt = readb(ioat_dma->reg_base + IOAT_CHANCNT_OFFSET);
-	dma->chancnt &= 0x1f; /* bits [4:0] valid */
-	if (dma->chancnt > ARRAY_SIZE(ioat_dma->idx)) {
+	chancnt = readb(ioat_dma->reg_base + IOAT_CHANCNT_OFFSET);
+	chancnt &= 0x1f; /* bits [4:0] valid */
+	if (chancnt > ARRAY_SIZE(ioat_dma->idx)) {
  		dev_warn(dev, "(%d) exceeds max supported channels (%zu)\n",
-			 dma->chancnt, ARRAY_SIZE(ioat_dma->idx));
-		dma->chancnt = ARRAY_SIZE(ioat_dma->idx);
+			 chancnt, ARRAY_SIZE(ioat_dma->idx));
+		chancnt = ARRAY_SIZE(ioat_dma->idx);
  	}
  	xfercap_log = readb(ioat_dma->reg_base + IOAT_XFERCAP_OFFSET);
  	xfercap_log &= 0x1f; /* bits [4:0] valid */
@@ -583,7 +584,7 @@ static void ioat_enumerate_channels(struct 
ioatdma_device *ioat_dma)
  		return;
  	dev_dbg(dev, "%s: xfercap = %d\n", __func__, 1 << xfercap_log);

-	for (i = 0; i < dma->chancnt; i++) {
+	for (i = 0; i < chancnt; i++) {
  		ioat_chan = kzalloc(sizeof(*ioat_chan), GFP_KERNEL);
  		if (!ioat_chan)
  			break;
@@ -596,7 +597,7 @@ static void ioat_enumerate_channels(struct 
ioatdma_device *ioat_dma)
  			break;
  		}
  	}
-	dma->chancnt = i;
+	ioat_dma->chancnt = i;
  }

  /**

