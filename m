Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADA06AED45
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjCGSDF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 13:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCGSCd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 13:02:33 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1C4A1FE2;
        Tue,  7 Mar 2023 09:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678211746; x=1709747746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YGCuMHhEBbt6Gtsp6vQ7qdbHF2qqrGTufHvFX6KeRVI=;
  b=AQVDzn6QUC2N25YqMh/hIBt+7Y1m4FXmf595dgbyk6/W0VykLLLd3gzS
   kG3rgmT49GVxn+p1Qj2Aiv/zLHPdPK8ALJiy7QcSZmEjrV5BSRtiipamh
   dxD5iV8I1lNy7qTBopCluudqR38ihWZqaXJuMOMAU9BKbRgLrTscJYxif
   fbWWbFEQisMsape1hTRewZ95SPSVYWLR2q0c0JuSx7fOMesSWqt6BI2vr
   2SQOC71DYY2P9tO30l+q0Eai5jUOIQWWR+cwJE0yEKksGemdN3wZCpIcn
   YrNRk+xJSoQAkGTOTg65/GOwjmAIazgEgGMyhmn73ZeOeMySEmfDsjpD+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="319749850"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="319749850"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:55:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679037577"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="679037577"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 07 Mar 2023 09:55:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 09:55:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 09:55:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 09:55:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 09:55:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gynQUFDiYTfWTpCPxdollpwGAqKmyDf9uN+fBp7/TZbzKTKQobdiK7BUKdPZkPUDD/TRYPS2kA+QYY5BE7TxaTeu/PadFfUmz1cvTB9IuX3lH0+2R/z8OcO9S9hunKrDjQthNXg19bDEkf+uCCLVjt6/NTJJHzGa8AO2J2yLw4oRanHA/oZNFssEUGJCl0WXk6OS9mDZFNTmhCzrLaPt6rZgw/VObNAZamSazmH8ux/7jdpJHujReCZwWamNw/li+a6y8jNGykYD0p6YHBmbfEKXTm7/u5NJuFBbkjhIPCdYDJ+TTP2MhpAt8wAE7T/Hki9ovWmlMTGzDw8moAMFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM0yrMuhRNPweDcOtmNA6YxEmYfdu1VRwU9rTDDNvgM=;
 b=KtqpE8CZYYDQA5VQmwskkB/jz8iVh6/NZuAw1SqyOo5Igt5HuoYNFdgntnlRijlGRf+CTANRoEt3gLdYh2QmbMA51fbbpkOQVgUZYp0Z7zkRtVX5zVy7E4rO4L+zu9TtTd6YOfeEaWK/lVjVogZwP0PyFYMxz/wU5jH6o4jUgP6ttpXlSOSU+WHFnsm2WtlWnVkLK7riRXhk57+kWPmyxj/Fip1kDSfnzgaScA6zOVfp50v5cBsByEVO6ffn2xUF2MJ8vXF4/skfi+ruEod2SlOX8RmibCHcpdjbzcSN8OxuIMTthIiT2mvjnRq4yGzEkgmNT8mp33yhlW4Peh+W3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 17:55:34 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%6]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 17:55:32 +0000
Message-ID: <932aebd3-c655-3266-1acb-e41e8cbfb771@intel.com>
Date:   Tue, 7 Mar 2023 09:55:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/16] iommu: define and export
 iommu_access_remote_vm()
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>, Vinod Koul <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Lorenzo Stoakes" <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, <iommu@lists.linux.dev>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
 <20230306163138.587484-9-fenghua.yu@intel.com>
 <f7b0cbef-3d7d-e5aa-1971-fe230d0c80e1@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <f7b0cbef-3d7d-e5aa-1971-fe230d0c80e1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW3PR11MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: afe10b97-b6d3-4554-d9a5-08db1f35256e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luH9J0FJMEe29Jjh36bXnp/jrDpp5jA1YMbpBJx7BUAnJK0N5UJkGWjsAX43fwPVOYeg9fZ6lI83TI5ZRgwVNxREkVDT5aPGr3lNwj9KPMhbJvcsQ4LLSU8u9xHHjKNSVb6MVio7aAs2+xydx0sFXh1ERWy9QBGiH2I2zWhiMGxBd4pmRlYB27bacTkMLYj5hodv1T+4NHiowq4Krf662W1++v4c33Lhg/ESj2+7XbqaXNUrNPgKhFoiumBXt+nXiW/Os9gxyeOPw1mnGxuUzfXmSu19w+E6RqyjhXhgWZqh0ZWcNSHqdg3yM4WNXUQNnT6WKosVxOIs0+zvN9yQQMKuTQhy9z0YjBKvaT8FxA75IviTXnKyuSyuo+1oAaAD7ChtpyTwmD2Y8Nis6SPbrI4yK2OOIGv1QZ4gE9LSJA1UC90rBNHHAWlCzNhd7Mg5/J0biFBxJNuJYvJEA7LzGLtABZtxOvgws1r6f9gCrU/SuA0ytKd31BRDq5RS6KLP6uRd/DEIqf2BYRj7+nee7ZyzRhplyfvp7UUkEc46kWeS7Epi5bjVmFUiPs9HYkqCxN9s+tk1Wo94kkZwDefIYN9zyGM4kbAvHVVXB13os835meXCql6CV7WV2wEKSbFiPUbaSMJuhhier6rdmVjMWjKoy7u2eVTErjg5z8o7nP+vnNDEceISablRxHFX+7ucZ6tOpRth5PtuTjrJWaQTGFu+GIEvEgXOUU70RDKS11U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199018)(38100700002)(4326008)(54906003)(110136005)(6636002)(31686004)(8676002)(41300700001)(66476007)(66556008)(316002)(82960400001)(66946007)(8936002)(5660300002)(7416002)(478600001)(44832011)(2906002)(6486002)(36756003)(966005)(26005)(6512007)(6666004)(53546011)(6506007)(83380400001)(186003)(2616005)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGxEbjZ0U1Q4UVhzMzFQc1RLSXdUYTBML0txYTBFbkJvai9PL3ljVGNHQWhu?=
 =?utf-8?B?aGVxd0x2MU1yYldkTW5MWUduaERnRnJPZ1ZrNmZpb1BFK1BMaGZzazM1dThx?=
 =?utf-8?B?bU80djl1UU14Tlk3eEVuMkFqTTJLUG1LRmh6cDF4U0ZaK2hIQ0MvSCtwTzZa?=
 =?utf-8?B?enJua3drZzFjUXQvWHlzRlJhdk5SWW8rTlFJa1FmMnBOdlhlYjFnTCtBRGpu?=
 =?utf-8?B?eUpzbXZQZk1aR0VPQk1sWDc4TFR0VFdIWlhwam93ZlBMc0VoYkY4WWxnWGJY?=
 =?utf-8?B?Q3YvZTVUWm9lOFkzY25RQUFhT1llRWxVbjJyclNvUjN2UUdMTHMrT2dObDFC?=
 =?utf-8?B?T2hjMm04a3lZd3FINTkvNkpwVnE5WTFPQkN4bVRFQzJ5MkJWLzFJK3VjTW5W?=
 =?utf-8?B?cS9oMGdMZFFoTFBtaTFWY2c2WkVDYnREcnY2bXR2WlZtbWU5bW1TdEJvUUZM?=
 =?utf-8?B?VlJwTWZLVEZDWW40SE5pZHBvT29oZVpRMGRNa25HNjhuRllpMi9jdWZJTGUz?=
 =?utf-8?B?Nndqdk1FM1FseVJ6em9FOEpGdU9UR2g2WFFTSFZoZDg5dWpLVHM5NWxpZGJz?=
 =?utf-8?B?aHJKY2IyaDNKZWhkQnU2NDU3ZUV3MVVxWmhoeW5kL1pSQ2JWbERXNGJNZTNq?=
 =?utf-8?B?WFBleUhCU1Q0M3c2a3F6d2JjT3V3MmN2bjBuM3d1WHo4VzBmOTFpZmhMa0ZS?=
 =?utf-8?B?ZjFxWVl0K29OL1VEdU9VRmFJcTlpRXJNYndqN3FWclRkRm5uK05hazVCM2tR?=
 =?utf-8?B?ZkR3TmRMcnNLSDFOS0dWbCtrSHpQM0oydEc5a01xcEJqVHlxclpjaWszUkhZ?=
 =?utf-8?B?VlhOcnVpSU82VnZXY293Rk5lRmRtRXZXdXBVOEM5U2VHU29DZitZREc2OEs0?=
 =?utf-8?B?RWxLQnZNSHZBSW9JYXFpbEpNSk5yOFpIYTF2eXRQMTdXSWpSbUpJdUJhVHRo?=
 =?utf-8?B?SEdsc2dPWlpFb2d5QVFYZVBOQ0NEaDhob2ZuaTJmOVpqZ1BPSmIwODlTVTlK?=
 =?utf-8?B?bjhncERHZThzYU1SaDlUdm5HQThpVTQ3WEhTU2czTlFoMWhQenJPd3NJOGFk?=
 =?utf-8?B?eWxzRGlzRzZuODZXMExWNE85ZkdaWWFMa1NPZExvdHg2eWdPMXExNkZjK1VH?=
 =?utf-8?B?cWFuL1gyN1BBblkyOUN6Nm0waGpPREk5MUxxK2NCZnA2dENNRTYyNHYwT0pV?=
 =?utf-8?B?Tk5rVEVGRHR0WmNaM29yUnM2U0hlcHdGSEE0MzZrN241dnJuQWZqbmk0NmI0?=
 =?utf-8?B?YnVlWmtHWTRlZ0Zxc3p6MnMvR09XVU9USVRJL1BWUUxYU2g3dFNOcVVYNWZJ?=
 =?utf-8?B?ZjF3bmpJbXRkZldhRk5Zb0hDNTFib0FxTUdWTWVsU2R6RG0zcERzWUR5SDFR?=
 =?utf-8?B?ekxwUmpqYyt2VmZrWmwxbHplQ3hvcUlSNXZBTWNObHVPcmw4UnV4eUE3aDl1?=
 =?utf-8?B?S3FmWmRtS0w2UWRrTGJmOUdNNWFmSlozY3BMandBQm1BMy9WQnJYTmtnOUlC?=
 =?utf-8?B?NHpFbDA0NTFISFhUVGZXT2t1Y2JodUdmWWtzb1kxVnoxdkVMZFVrSFJkVjA0?=
 =?utf-8?B?dkR5R2I2TGVEZGVmbkdzaXd1QVo4dzZlbXZrWDhrcnZ6bnBZNGo2eGd0TnRq?=
 =?utf-8?B?cGtjL2tRWENjLzM3d2FGMEZubjM5clBVb3g5U0k0a2I5YTFuR05yc2pHemRJ?=
 =?utf-8?B?WkZvRDdXbkYwY2hOdzExT0ZqbGVyRVpiUUFHa0QxbUhmN0VGaUFRbHZ2d2tt?=
 =?utf-8?B?ODBxSWNWaUwyR3FSTFFvTm84RmUwa0I2QmVIVDJPODdGNFFFYW9ycTlOWUND?=
 =?utf-8?B?WnM5YUZlMnZQanBsK0Z1RDJmZXZyeXFLRDhLaUJDaUFQSEFHZWc5TFR5OFB0?=
 =?utf-8?B?dlV4SmloYWFTWE1pQU5vcXJ3NVkwU1VGNnpZK1VXVG1tQk9GU1o5eXNuRDRt?=
 =?utf-8?B?Ykdvem04VHYzbk9HMTBISkZ2bEt5M2RZYmdTdmk3V0pZeHJoTUdhUGJHZ3BD?=
 =?utf-8?B?cXJJWlpOUVU1Sklva3lhWlBBbVJ3K1BMYklDcTRxTitjQmVJWmxjNTk1OS94?=
 =?utf-8?B?STlxZXhadERLWDlWL1VXQ2h3c3FMbDI1Rnp3ME1IdXZVUEE3SzFnaFFzS3Js?=
 =?utf-8?Q?nWDpvi4VXIgeDsnkD2pPj3CY9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afe10b97-b6d3-4554-d9a5-08db1f35256e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 17:55:32.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iSCX3zCDHJ9OsFomwPKNTdZp2lDWji/KxeuT+uZiDyHuIAi122401MI62pdFbhUaCUK6zVbzMB3V0osnyRWWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4538
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Baolu,

On 3/6/23 17:41, Baolu Lu wrote:
> On 3/7/23 12:31 AM, Fenghua Yu wrote:
>> Define and export iommu_access_remote_vm() to allow IOMMU related
>> drivers to access user address space by PASID.
>>
>> The IDXD driver would like to use it to write the user's completion
>> record that the hardware device is not able to write to due to user
>> page fault.
> 
> I don't quite follow here. Isn't I/O page fault already supported?

The following patch 9 in this series explains in details why IDXD device 
cannot use page fault to write to user memory: 
https://lore.kernel.org/dmaengine/20230306163138.587484-10-fenghua.yu@intel.com/

"DSA supports page fault handling through PRS. However, the DMA engine
that's processing the descriptor is blocked until the PRS response is
received. Other workqueues sharing the engine are also blocked.
Page fault handing by the driver with PRS disabled can be used to
mitigate the stalling.

With PRS disabled while ATS remain enabled, DSA handles page faults on
a completion record by reporting an event in the event log. In this
instance, the descriptor is completed and the event log contains the
completion record address and the contents of the completion record."

That's why IDXD driver needs this IOMMU's helper 
iommu_access_remote_vm() to copy the completion record from event log 
buffer to user space.

Thanks.

-Fenghua
