Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1B5E77F0
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 12:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiIWKJF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 06:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiIWKJE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 06:09:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC091D88;
        Fri, 23 Sep 2022 03:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/2nEWe03HeC3kABNkoeujrea9uysMKrgNsUOMu10kLhshcg/jAVC+/kjzO5Ffx+0NVmDYe5rhw5c22TJBF645PGwCz66ZW8SJyXR8Ui+EDdtaiM1qpAYZxtkkt48vjLm3y5j5zgp29qZgjkctS/pct2jsOQW+2gAQwj88qb5pqvokjiNlg3lNwfLQC3c5EgyXkTcLYyVsXgmaPYsBk7Tdh5IxfD4inh3tvWbP2fxvcRXF1j55uCTRedSaxO+l8Rsu6mfE0kvavrH3F7/TU3nxzO4Q6MFUIrLRw4BhrwMezf5rQnci/1V2OW0/JCsfWD2fn/+8SOseeLVQEquW66/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfREQN/5pj0lEAn4jNOYwN0EPZnjuVt1aLDmLvgqCUQ=;
 b=UvJrR19Fknuhqb0k2g7nbXLyRKIp/MjWSa7kM1h3ZTJBoVRk1rzS+kxleqb/uaqB/anCd148ZmECQzU9jIdMqq0wvZVRBAfWtouPyh+xlVaCrJbvl4qBHhpY7VbFNpelNbOovVK5SfqSoykvx3U647iZK1XEewvX95INuifQZRYFrKXfJJxcl8oBZyI+FCfd5H5rXeUcupmCcu8Chg50c9orVfdCz6u6k/7SNZl6GnEPCxf++CRchgLhKru8EuWVmXTuXLunLSxuHk1pBunyBD4I0erZXH1C4V3V9xwO1yrViW0jhBPrsf1JntmmWcCl5zCHD8Z3uatllcGSWOA7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfREQN/5pj0lEAn4jNOYwN0EPZnjuVt1aLDmLvgqCUQ=;
 b=oD2QPVEDVaYJ/Yp/qkLoKty6k5CkyBsvem7Lr7kZKVH1qMA6O+4XKzbqmtblqzQvWq0dGy2XFgcdABk9tTcLFeouD5C8UBiofUsSPSAqzNnVsSD3RkeBJOTH+3QOYvQffUmfd9ojsfTpkmWxaKEmrDJBuCrIsz/01iLAW9wdLo0q13tuJLeWdeVwlydV19QEdbiLlLxw8TT2+gRBcxYD/3DyQRBJAUyvQsi9X/fZNdpHlVvQJxw3jkGZyidITZ6v6zJm3KytrQ3gBzQhhaNt/bmtrLgB71F9pr+PWBWm/0AlI31FHfJKg1mt8kH5OClxD645gkdrUIkIf2yyA4b4pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.20; Fri, 23 Sep 2022 10:09:02 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 10:09:02 +0000
Message-ID: <8d15c575-a490-e1ed-7e97-5a5cdea0925f@nvidia.com>
Date:   Fri, 23 Sep 2022 11:08:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] dmaengine: tegra: Add support for dma-channel-mask
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, ldewangan@nvidia.com,
        vkoul@kernel.org, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
 <20220919112559.58195-4-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220919112559.58195-4-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH0PR12MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 955e903e-361c-4600-dc47-08da9d4ba37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KiDJ43u5JWgzg1PNuA1QEylSDiGlKmVM4Au20juLjLdUZSJrtf2hbJsHkOn4iJIap6yx9p/lK2qXK6qV8uBMbhTskkeLx3pRsxRChh7tUNcfmTzMNHQ6LL6VeRBGogY7XlhgljLDr3p5dDKI6OPTSdL+sD1oA3Oxzi1MyUWwDxTshuXkdy8x3VhTjr5Pfbb5ffHPYkHo8/Q8HOrI2/5sICbbv8XNVQHgtv0OBCDkM31qxt/Ur4zSJDrE381rbVFh+3bNAI1DUIt2FkluA8mdfVRuuspVa9mefR3L4HM3VP/POk+5O3yjHB9+ENBNcQO033t/cbY92cyWVCFVoVgnqu3dtB3pvDIgALNw8OVE3/3kSKYu2rqRlGVGrbQ/lfFWOaQNGaBorKtGCUWgKUv9PzZ1z/TOdj8ujFzG4ud3FC3mBmbkZJUwASq7GiCWTslTJAFh75aUeO8aWhASlCuF5sYQqQL8mKNIpeXrHf7Cg7HmHkmGFaVCIaBdfPsJIRMDbXdjw7+sewJqdLJdGwZIdtpJqtr+NkAmVZWJBFcovV5sfjUASt7ewTYEWzpol/lWC9DgGYr15OKmWiL9M2dYOuymDiYJI9JezIJVPN2ahJ9U0ijpVoAdIK0MfadxBorJdbbEqKSIANExcHRYgEMdDSd4ou47kHqw2tOD6tCwUT5C04tVw295q78Zo4IgU5TxZdPbdXuDZEpVENdt2ewvuhHnzhKGKR0C+AJV0dL3Qat9MFnRGxq0L+2hpAn73ZYKKkSQnTFeg2ZnLTIZsdtdbt2bqLN9M7Poia/RgK44DSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(66476007)(53546011)(6506007)(66946007)(66556008)(36756003)(86362001)(6666004)(2906002)(83380400001)(8676002)(41300700001)(2616005)(8936002)(316002)(186003)(31696002)(6512007)(5660300002)(38100700002)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Syt0K25wVmFLWkY0WWpFYWM0Rm9PaDhKWng0MzRKemxWTzlJMkJJM051eWdp?=
 =?utf-8?B?dTYrbHZyRjJGelpJNGt2WUk3ZDVudDV0VXhtRVBZcldFOXFFK0FLTlhMTDBU?=
 =?utf-8?B?L3ZQa0tRRERLeXJlM3o5Vy96NndsT1V3ekpBazNLU21zK1pFSHE1eHFGQVhK?=
 =?utf-8?B?ZjkyMnBIcmZ6SFg0NEkweXRZSnEvRzVrb245cVp1K0VHWUNBR1E3L3BkZEUz?=
 =?utf-8?B?dTJPQTZHWXB4andmSTllcU1kZWp4d01hSWFvbk1ETEZUanExZ3NpU284cjN5?=
 =?utf-8?B?M3dvSFJmeDd2djIrQ0l5NDRwRGdPVXUzRFhROFY0SlYzZExVa1ZCWHBoTmF4?=
 =?utf-8?B?M2FBUnV4cThLNXNreEFiZFJBUUk5U2ZUaXM1ZkpaNU0zbUR0QTNBTlRQamgz?=
 =?utf-8?B?eEQ5QWMyRWRtWkRZdlExT0VGT2ZiTm50L0poR3dMWjRKbkpZVDMyTUcweEVa?=
 =?utf-8?B?L290OVBIWVhpK3VQUDV5OXBJLys2dWtYT084akxUeTZNSzI0RXc3U2FQUGxP?=
 =?utf-8?B?M2JPUVZNQUxiRWh6OXFyOGZ2Q3k1bFlMZ2szZE51MVVvQWdPZVpMMnNwaXQ1?=
 =?utf-8?B?cVR6cituU2dUSnRBTE56eDlVUmdvUy96NzN3c1dEbWVKbWFPSHhJWjBtVk4v?=
 =?utf-8?B?TnppVk9ad09NS1NQYy9wY0VxQUkrNkgycVlKZmtnQjhidER1UVM0bVFCSkky?=
 =?utf-8?B?R2tRNHZSYWpZSnhqemp4ckZHVnFKQmhSU3psTlJuaGo2b3dmMG41Z3M3empM?=
 =?utf-8?B?aXliT2p6aU8xTXltQU5ZMG9YZDRTcGNsbS9jUlN6UHY4bVVOOC9wQTY3aldV?=
 =?utf-8?B?Uzc4N3c0aklGMHQxd3ltWTBLSG1LRGFSZFNTSGJVd1BOOG90dWxTd29wUWNX?=
 =?utf-8?B?L0Y1bGlUSWRzdHlnSjRKYnUveUpzTjlHU1pNZytISVdXaE9aeFhCcG1rSmhs?=
 =?utf-8?B?TWJROU5wZEpTMytKcFR3aFZZb2cxc1NpdVQ5L0pPVUZ1bW43S21UWlkvbStl?=
 =?utf-8?B?N0MraS9kWkxTMytjRm0xcUI5U1lrcit0VVZUR0Y3TlBVNStVK2VMS2h0OVFS?=
 =?utf-8?B?bUZxcXN6aFVNSGIrZXdhNTNMVng2SVBoZzB0K2MvdDRqN2hQZGczUUJvUGJN?=
 =?utf-8?B?YWdBc0RqRGVUdnB5TlJYZmdPdUU2cUZYZjhrTGc0MHlDWGIwVFMweE4yZFpp?=
 =?utf-8?B?eU9hTWFBUlFqR0haeTFnUlR4YVZBOVQ4akNac1FrNFc3UkFvc0lSK3p1WUJT?=
 =?utf-8?B?UGgxNVpEQUMyN0NwUGV0aFlGTk1Za0kvTDRGV1ljam1OeGtHaVVTUDY5MCt5?=
 =?utf-8?B?SExpSzVxdGJuQVN6THJ0RmdOMEJucnQvMCtqK2ErOGs4UTg4VjFRWkVWVVJE?=
 =?utf-8?B?aGNkNVRRTXlHOGxQZU9iSVphWmk1VUJUUXBBWThBSkl1S0lqN2hoYTRBcGZJ?=
 =?utf-8?B?RWtxeE03UDNVUjdvUUVOUmxlUGc3bUJGeHdIUEI4dTFaT2xCK2xFSzJ5MTZM?=
 =?utf-8?B?ejdKODlrdVY0cHMxUCtnYXpWOE4rR3pRSjFjUlhoWEtBL25Oa1ZzWVc4YUlx?=
 =?utf-8?B?dVJiZkdJdktLL2UvMCtxSDVyYVdpc1R2ME5XY25nSERBUDNXT1NsWmdzUldT?=
 =?utf-8?B?eU9hZjVXM2ltUEkvSmVSS3h5dU92Z2VqNmh6QkJwSzEvRkRtdkFJQ0lLVHNZ?=
 =?utf-8?B?VUE5aWZVcTRkTXBmKzhuTWIzSW00dkxJUk5zVXdaY0dWa3Y0L2p0TWE5dy9t?=
 =?utf-8?B?SXZEZEFwZ1UxQnVjNFFwUjB0bncyN2o0YkdsdzRLclZvUWh6bXZYeHBLTm9N?=
 =?utf-8?B?citCaHJaUXFhSEFkRHczWGErWWFzdEdtdHB4eUNDOGs0UnNYc1JsdGdRbWxC?=
 =?utf-8?B?dXJQT2xuY2FkY3YvdnAvaU52RFY2NUI5cVdSU21hc25JY1dBdGQ3UDA0eTBT?=
 =?utf-8?B?YWJ5WkhIaE1MU09uSnZUZXl3ejRsUnJJUXRMcjJsLzVaaE5sUVIxQWlHWWVJ?=
 =?utf-8?B?RGR3YWdKRHB6SmhnSFYrdlY5QlJZdHhGQndWOC8vUE1HZlZwTFBFU0FIUGd5?=
 =?utf-8?B?cEFCcE8veUFZNlF3Qm1CSXRMUDFFZHVsc0sxNHVxWUp0ZDF2VmdXZjg4U2Ra?=
 =?utf-8?B?WDkxblphU3B0aW4rRmVaNG1TVmozeWxjTzBUS0FqRUNQdlBDVWYyY2txdDF6?=
 =?utf-8?B?cGdLTFpPWlVSd2FPam0wekdIWHJBTWc2K3VjQ2ZxY2dDeitrc0ZDY0V2Y3Vv?=
 =?utf-8?B?UGtleTZJQ0FCUmdka3VXaXgwQUJBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955e903e-361c-4600-dc47-08da9d4ba37d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:09:01.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPJ0tx7PJpGzP4Y3a8dSmYnb9fk9RCA1fyRxkzlBubr5p2jD5zPnvym+XzeXuvCQWAPkP4GNEqd/rrZTX1uEpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 19/09/2022 12:25, Akhil R wrote:
> Add support for dma-channel-mask so that only the specified channels
> are used. This helps to reserve some channels for the firmware.
> 
> This was initially achieved by limiting the channel number to 31 in
> the driver and adjusting the register address to skip channel0 which
> was reserved for a firmware. Now, with this change, the driver can
> align more to the actual hardware which has 32 channels.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   drivers/dma/tegra186-gpc-dma.c | 37 +++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index fa9bda4a2bc6..1d1180db6d4e 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -161,7 +161,10 @@
>   #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5 msec */
>   
>   /* Channel base address offset from GPCDMA base address */
> -#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
> +#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET	0x10000

Why did this value change? There is no mention in the commit message. If 
this was incorrect before, then this needs to be a separate patch and 
tagged with the appropriate fixes tag so that this can be picked up for 
stable.

Thanks
Jon

-- 
nvpublic
