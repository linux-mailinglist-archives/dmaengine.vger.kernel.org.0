Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF0779359
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjHKPkp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Aug 2023 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjHKPkp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Aug 2023 11:40:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD118B;
        Fri, 11 Aug 2023 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691768444; x=1723304444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bBxu4JVX3/X33Z9fvMfDLWLccBBZ90Jywo408ZzIqqs=;
  b=ZJyb9peRd/Xd1aVss1rWGEfqJ0CyIDTLPz+Or1HvV6wXSouoW8v2vtTy
   teyJozJWYwFJbelEUwpUaLFbfMHqkxSm0lpw2KdnZILmmf5sSSQEtjr7y
   Hu72U4nEdipMFcQxNYadO9XzDpTJFYof2NYgCF6Mbsw36vyvCXVTf2oj9
   QQjM8jvRUKObqlQxJ7dtF8Frp6XclSJ2nSdaUqlq1cMNvljiUhWTgOs6T
   NQJ79f1wUA21BFRhFan2mTZii1OJTSzICVL5i/CWaKkZy9JmEmc8tggiW
   kQnGoaCihYrF0d/H8d9Bygh+UaLx0YGtM8udN6n5wa1cDGkky34t05u7D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="374470689"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="374470689"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 08:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="822702444"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="822702444"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2023 08:40:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 08:40:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 08:40:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 08:40:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvTrBNx4Jup0GVHCiwDHah/++lufzw4QmOZoWvJZ7+tuEkVcihxFGkMIo0gJMiUd/oV9MX8PvFEFqVgKlHiK93HB9gXbWQn7CXD7C804pxAH9lJ+3R+fLgLr68AaTNyg5odaqjXgbVHRygBqhc1bDvtYsQjQ2bBWFi5YyUoG6hLdB2wfU+LfWOURDT+CDUNwLxqi3/jihw7W3qpXcl5rPOiBV4FPkvAimGdtVwkpgehAZudpOErbmQX2pedJey8sAttjbmkl4Z8YL5F6d8wXJa+PQnka9Ev2VXs1lQcakT+QwBnTlOTGHoRXP+P6Dd8aD+z8Wj3MbUD6Pyndyw9x8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1xNZA4SPTcq2uxD3zF7KWRmugqgmZR+US3ekVEoaMI=;
 b=R2Q9WtX2uCCccqBECxLqYCYtk/RxAnf22+yYB6yWyc8S7N9lC1aAXoJtgzlfpCUlFYsac8+THqPq1wdkrVX6fs7ocMyqH3WET2g8BFn0/LOVuOOntV8063UASm4J2sh0JC/qX7ksSTpKuPz3fnnLf5oVkpmYuwA6ljUeBLKyvbElLJ3SwvUSD69YXxWzuzYBbkshtRDIFyITQ8yg+ORCCiJ44C2oybUiOhmAnFHmw/6axIZ90g9ynHCwucUGFEL4EdQN2Np55oTuTxTOp+rH/zW01cu8u49d0ilQKAfg77f2WHRAi6ites8UqNSAl1VRF7XOgML9LCGaj0kQgtSmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 15:40:19 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:40:19 +0000
Message-ID: <a93a087d-cfae-a135-999e-ae1976694165@intel.com>
Date:   Fri, 11 Aug 2023 08:40:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] dmaengine: ioat: fixing the wrong chancnt
To:     Yajun Deng <yajun.deng@linux.dev>, <vkoul@kernel.org>,
        <bhelgaas@google.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230811081645.1768047-1-yajun.deng@linux.dev>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230811081645.1768047-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe48d19-fa99-44d8-adca-08db9a814470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDkOuqiEAZDWM5rpZsipMkWR0Qnp0GzIeARireDBhPNVFMWT+uZ/ZBGGpKSM4Bu/fEDImopU4PKPRMjG/wJxOZJ6Ev/Uls1SF4O7McBS8NSTjaSLDrcPOZYmhDsR/0ScaTQz60k/O1JDolfWMCwMGULx8fHQAy9/ryBlICxJSlr32OG8aHUXUnUaMkTt+H4uGBbjte5Sgv6GIXGVaH6M1wdQCcR6+OCUu091ln5KIe5nfFLPW/q+bDlEiqFIIcSk9Q4jl/yqLQu0vXMtXx3D7IFXgr3vpdDNqSwq6u6BxrxC2ka2U+YvPI6h4VDDJ1P7G9W/RiX+StJ2MSAPfeHgvbSbc/V/zIJ5YoABPal01JV9C8FhTPnpRWURpO2sF9DXe+1E9Pp+CuRy4ltvXogp9EwM9Wlz3tlHMoQKpn/zjuuhf8a8br17GV6Qw7JGyPw+pn1CmoBbHyK66gmzT6tdzxKGKCl2D9Lls2lfnLwjU4uGge1I3xls4e9RBkSfTDZlPhux+Ea3En6Q1mycrlKH2op4D6z2qSk4EzNG4gr6LKcw7riGUm5DpKlxEdv4sooAms1CVQ9R4XcdkCRGB0JViI1NpWnarRxP4xnOyHD1FSL9WQ6wl/PnifnA86SAeAixfZ8iYQrcPT4OLV7IOo8Vmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(186006)(1800799006)(478600001)(2616005)(83380400001)(6506007)(26005)(31696002)(86362001)(53546011)(82960400001)(38100700002)(2906002)(6666004)(6512007)(6486002)(36756003)(5660300002)(66556008)(4326008)(66946007)(41300700001)(66476007)(316002)(8676002)(8936002)(31686004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJYa1MvK2wyM1dEUkxwYjBFN3kzbW1tc0dKd2ZCMSs2bVVNY0M3Y293Qzc0?=
 =?utf-8?B?cEwzRnZ4SXNsak5qNFJldlgxSWxLQ2NRSks5d3BnNC9rZ0FLMm9pL3hGM3N6?=
 =?utf-8?B?UHJrVkdpcmJUUWdSZ2VKY0ViR294Q1Q3ZGpCMVJpczVDelVzYWFlMG00ak5I?=
 =?utf-8?B?eFdzUFdpZzNEZjVsc3FLNjRlQysrald6K3I5bk9lRnFrNmRzVlFVWnNxNjBk?=
 =?utf-8?B?VTNtMkxSRjBrM1E1TmdrVjFTL3l3K3lCNCt0eGg1b2dYSDBSdzUwNnUvdWVj?=
 =?utf-8?B?d1FFYVRkWFMxd0Q4VlNzOXFBRjBtZndxVzVGbk5XcHFBRGlZUzhqUzltWXMr?=
 =?utf-8?B?OHBsSUxxdWNJSWUyWTZDZ3l4cTlHSjZkNDB1eTBRSCtDNWY2aFdOTDM4YVMw?=
 =?utf-8?B?aUNUMkQreTRJNGhjNW9WN2dkU3BteEYwQ1F0d2pWbU9OVUxLY1paNU9ET3lB?=
 =?utf-8?B?K0xpTWEzY0M0N2xZWlhRazhTMWdJNER3cCtTOUNvNjRYM2s2WjRtaDQ3L2Vn?=
 =?utf-8?B?WVZZRjZMeU40UmZyRElmNUxGVWxaTTlrNmtzZVZiOEdaVE9vNnEyZGhLaHBV?=
 =?utf-8?B?RFU2OTdPZTVqem03SjVIVmduRURoTDhJY2dCUkdYT3A4bnNocFVOYStCdU5q?=
 =?utf-8?B?eDM3cHNQbjR1Njl5K0pHRTZxd3RPbkRvVncwYmN0c01LN21wMWZMNjdsKzRT?=
 =?utf-8?B?dGJua0o5WTY4eThJaVp3cUN0dkQrRkxNRHg2TkVXYUI2cFlzS3NBOWEreDdq?=
 =?utf-8?B?SVF1Y1NaOWVIciszR1dCUDhTeHJvNklEeWxmZUFlRWlFOUJuMHRFZUZvSHVj?=
 =?utf-8?B?NFp2b1NhUGJkRE1sL0REd0NpZnlmaHVXeHBqOGZRRERoT1puSEtoYzNnemVH?=
 =?utf-8?B?cS9kcml5V3Uyck1QaGlaaXZudTk1VWJiTzhReTZVbUJBU1U4dytoMkd3Zll4?=
 =?utf-8?B?K0dPQmZUMDB2Ri9URFc0Kzl1S0l1NE1jMDZubTdQU3U5eEpXcDBQczZUN05P?=
 =?utf-8?B?MS85SHlZcnFNaDZGVlVxNkQ1VFJLQ2N2cC9pNWVsMlJKbzl3aWltc3pvcVRs?=
 =?utf-8?B?QlVCNG1LbGFqZEgrN2RJUUY0RWZKbDZpeFg2Nm9tYnd5TjN2cU0wOTlUSFNO?=
 =?utf-8?B?ZGxTSXd3cGlGK0puSGRva0ZIazdrR2tleGhySmZiUUc2WHMxWkY5WW5VTVU5?=
 =?utf-8?B?enVEWDNQQWN4UC9BNDU2MWVGclZKL0tuWnZjVGV3SmZFNkhTaXNTN2NMMnBN?=
 =?utf-8?B?cmRLd0hvNzlra3lFc2kxK2ZFZjRwVENibWtQaUI5c25QT3pOY25IWnd2WkRu?=
 =?utf-8?B?WGFmOXp5WGo1Z2I2TG1RNmhVc1c3NFdpem9uNTFXcTZKZHYyaUZ3dDBiWnVV?=
 =?utf-8?B?T0czL0thRGRORjBLZW5GWEhHK25KVUtrRks4dlNuUUVYSlVJV3RZeFVGa2V2?=
 =?utf-8?B?Y3I5UlhoUHM1UGlYcVBZWWRmQ2JQeE9wY1dSOVB6VWJqYlNyY1VtMHdOY01Z?=
 =?utf-8?B?ZmhyazBNS1dvTHZ1eHdadG9HVVlTMks0T3djSklkSEw3aEpwSmJtQWNDUWdx?=
 =?utf-8?B?aVVsUG9zRnZRTkJKV01ocmZOTnZqeEtoMWJYWG50L0xQNE5WSjFLZ05idXFy?=
 =?utf-8?B?V0IyN2lFZEQwU2ZlNko0VVdvcjRNV0FnSzNSdFRsTzdQYnlDbFhVMlh6WktE?=
 =?utf-8?B?N1pNVVZYMHdIVVF1d1QrS3VjTHZablRDR25OZlQxcjF4bE9idzdLVTJ4OFQ4?=
 =?utf-8?B?cHJNdWdrcDU0MGNpREZ4R1FnZm1QWHlucWIyTEE1MU5IVXQxeWpvTnh4em9H?=
 =?utf-8?B?cjlROEtHWjgzRXdkT2J4ckJUY0d3QnJhRm1uWWtNZXlnU090NTA4U0JlbHcr?=
 =?utf-8?B?TzdlVXNWamVDN3l2aWdUSlZkV3pXOFJDOTVDSllSb0x3VDQzWHZLcjUvcFRx?=
 =?utf-8?B?SkJzb2RmTFFxNGQ5L1pya0JQRWRnQzVWUURzWi9WcXF2SWVoMFhGM0dDaldL?=
 =?utf-8?B?MWpPTkJzYnBBWFZCV3hNNDFGc0htMWxrZm55ckc0M0dOeHhMb2ZKZjZrYVdu?=
 =?utf-8?B?T0FLZGFZREpicHM5K2dxMzhOc0JYOEZCekJIUTQ2ZUxUeUdYZmhqOXFJK2I1?=
 =?utf-8?Q?fL7OuDpPHWGC61x6HqT0lkPSA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe48d19-fa99-44d8-adca-08db9a814470
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:40:19.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVo103UZgeeQRaI1mF/LCXAWd1u+NJqSMGBFj/x07sgwzZF1iPNB7h9NRlgdzW6x5j/TOKJrhxcCslY21KHDsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/11/23 01:16, Yajun Deng wrote:
> The chancnt would be updated in __dma_async_device_channel_register(),
> but it was assigned in ioat_enumerate_channels(). Therefore chancnt has
> the wrong value.
> 
> Clear chancnt before calling dma_async_device_register().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Thank you for the patch Yajun.

While this may work, it clobbers the chancnt read from the hardware. I 
think the preferable fix is to move the value read from the hardware in 
ioat_enumerate_channels() and its current usages to 'struct 
ioatdma_device' and leave dma->chancnt unchanged in that function so 
that zeroing it later is not needed.

Also, have you tested this patch or is this just from visual inspection?

And need a fixes tag.

> ---
>   drivers/dma/ioat/init.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index c4602bfc9c74..928fc8a83a36 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -536,8 +536,11 @@ static int ioat_probe(struct ioatdma_device *ioat_dma)
>   
>   static int ioat_register(struct ioatdma_device *ioat_dma)
>   {
> -	int err = dma_async_device_register(&ioat_dma->dma_dev);
> +	int err;
> +
> +	ioat_dma->dma_dev.chancnt = 0;
>   
> +	err = dma_async_device_register(&ioat_dma->dma_dev);
>   	if (err) {
>   		ioat_disable_interrupts(ioat_dma);
>   		dma_pool_destroy(ioat_dma->completion_pool);
