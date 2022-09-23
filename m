Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACCC5E77E5
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIWKG6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIWKG4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 06:06:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628F12FF20;
        Fri, 23 Sep 2022 03:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAzM7Xv9aH9ETD48FrOXvgNYat5IFeqpAc6kB9Vu0aimaQXFCuTKKPHB7xUrifh6K9Quhy4tZM7PH1hoAqGsM6PbdGf3NQi9VqCrZX9IM0P23GOVNb4AbsJ2g/Ymy26lr8vssRxxwaoBtcxAeCMvrhp2goqD+4TipXuKqvFCbyXdoB73Rmmz5RfNJWgwlttbs4MyzX4/0+fG1N6MLoEjlzygQU3DFheUnCUosdfuJucQZ7hUeBcLKAgHPpq6+oBRenWJKTyY9fnDKVsUjEmPvxUMhAdObZu3gbuxPt6Gz0MnK0m53HnA/FDHTjD7Xwtq51sNW/y8ZgWbEdNUKhk0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49oEhZwEtcqsRM1JK2/YWvo8R/EY5HmdoxQ08GU6ppY=;
 b=dICs1BeBDKG7MNjR0/IS5ZEd2UtcQt8coPcHIMN5LwKMLjGpQzjr3VrtU9YD2C3cgM69Zod43iCO+Tub6a4mtNJ1Xdneub0gyB+mTEBFV+oRXZyA39geIOuehAP7hyCAmMzYCJLUlnGQW3QJb7JnHZFmI4ktszeTHlJARBR7BM9AKfmjoKnHw+Z1k66vjYOyTY+nHec0Sjr+gs5wXxmWC6NJQ4uyyLxlMatpWbr12we6x6DYw2lNzb0LrwhjZHQQBeumNwEQSsT1BtGVIjcVngkKC8oghma2jS+4cy+ZzknPCQQfzJ61scbF20b+zqbrPbB9TVWtZz3MmoIncfO6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49oEhZwEtcqsRM1JK2/YWvo8R/EY5HmdoxQ08GU6ppY=;
 b=dX56VlSnvIEAvWTjMWrbGp5fp/hMc101paT21C13aosU/NjB9uST8TxZe5RirVG8FHvlGgm99Xy/PQatpC2m3N247DnBtJCA+iw1A9e1R0Q14a93YAWtvS8uyEFQPjX2pDjJ7aEagpdz6ou6kL9xqBPFPOVDp78ZvadTPH67rKNMGs5GTKWFYaBOC4j7fAgiC4wbYvq0jbs2Tf+NdGKcJmLmTfEUhJIdXvc350UjmLO5A2dKqXAhsfhsQeZwDV1xRsfv6uHi+6oSKLwtOC3DXaikbKji2+lXwLxbdrC0LTD/uyI4Yem3uwV30ZfPUX2ydgs2b+I+c+wusEB1gd28XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 23 Sep
 2022 10:06:49 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 10:06:49 +0000
Message-ID: <0855bf7f-fd3c-ab6a-cc26-ded8ecb05993@nvidia.com>
Date:   Fri, 23 Sep 2022 11:06:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: dmaengine: Add dma-channel-mask to
 Tegra GPCDMA
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, ldewangan@nvidia.com,
        vkoul@kernel.org, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
 <20220919112559.58195-2-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220919112559.58195-2-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c8cb0c-ca01-4c35-d0b2-08da9d4b546c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyL10e2K7E8b7JiN8O28OHvUx4+HVf2IcMR3KiHSz8tmLwgkTiq6ktoSgf71NvtQRUwH67+yH5tWMHBfWAf/ImMDgX9+aPTp99NrQds4SkYoQX7NrjnTZw4gUK+cCpw3Q2A3opA2/332r3YyuAS+i24q8vNM1UGKpQ+qxvPDj+3NTat8Rt9msSP841f+0BsZDNYDoAQsjOWrOe5g+eq/Cy3+GJvuRoWYWWohlK9uZ/PSWE3KY29IC0QD4OQezlb+YXx+R5ZsdfhjbUyn8hex79DxDXYUiKKa0wK/FUBpPCQv67y2kb7YLvm1nJs41u9XCa0H8AAQ1KWBmJ6sfhXwv12809htpryqvLiNJrwcVsfKdGwoE/2/rD8yv38Gi5JV7+TCLa/EFEiPvqf4ctVFoDTke1HgTwEuxQshw9VmuWUBoc4NY611oISoCdlHtKKsHLw/N0iSGtxABITE2xI6fiWlmltomPwsmMChCng5fMpF+cEYNmx9d6htTNvc+/uEbQn15TGGpVB93ho1h6mxfi2stixEM5GkN8JGT5lcB+ANw9z8VY7mRhUkhp8RUNHH5PD0WOgLGMr2zZl25f8jGgmxOyl8FK4KN3IMBxmY5CY7EH9qlxIAnE/zlV1Mc/6VT3nGkDMsjPMn0Obxdl5aT1m4A1k0Gs8xT159tPXHFv6eV4JOTCQvvTYD4WwbX/VWlPTeF/rVyaesiTBC1ol/Ls7NBqPoSU2UGWUNapctO/lqFgfJ1DWddsfaa6S4V6jD6yvtbWlKVCkDo6yREoNL+tUhYQzmGBC78MQ+9itk+P4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(66556008)(6506007)(36756003)(31686004)(53546011)(66476007)(31696002)(86362001)(2616005)(6512007)(8936002)(6666004)(2906002)(66946007)(41300700001)(38100700002)(5660300002)(6486002)(83380400001)(316002)(8676002)(478600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czVtMDJSbHdiSUxDQ0hCeExnR1pnZEM0V1E5NUY2K0Q2UEJvYTZXSWN6K3RC?=
 =?utf-8?B?NUtLTjhVMndQQWlCMXkvaFgwbkpDM0gzS3Q0ODBSakdLeDJ6RWxTdFBtdkdu?=
 =?utf-8?B?OHlSVHBNckROazAvMXdZeVU5cUM1cjIrcXp2TG43aDlCSmR0T0xDSC9QR1pm?=
 =?utf-8?B?U09NbkxZaFpiUEkyeXpwNTJPR0pudlFvVmpHRFk4MUhFUGxFVkZxTDFvNERO?=
 =?utf-8?B?K1FseHlqZjZjY2VRUjhFbFo4UDRScHMxcko0aW1jcllnNmZoTi9YaFoyckpr?=
 =?utf-8?B?UzRVZ01DRlNrcUQ0Mnd0ODdWZEljYnBTQmV1QVNrWVhIbGUzZHNnQVFmNVBW?=
 =?utf-8?B?aVVNSlhhLzFERzl1aS9pVWZEdE5JMDJzeSt6SE9zd0J3M2s3VDNSY2haTzlO?=
 =?utf-8?B?ZGtXMDU3NGZObmJHWitBVUI5cEdSYitObUw0d3MwdUR5enM1dXJXUVZ3UTVF?=
 =?utf-8?B?N0RkekhSdGpiN3RoMmYzYUpxOHRlVWhFdis0K1RCM0J0QTcxVmxPTVAybUJ1?=
 =?utf-8?B?MXVKZUFtOWpLQlJrM2VFOEdOOVZqQzZod2wrS0s3L2xTNUZJNmJBYWVRenlX?=
 =?utf-8?B?UC9Mdm5Pd2VLRExXTktYZGVYYzZGaDFUbXJwVFlIaUNDalpMcTR1ZW5vaVNV?=
 =?utf-8?B?dWFibjJwYXBISmwzalRZNWpSNnhlL1pHaDI1eW5JdGpGQjlseWhIV1lVZ21H?=
 =?utf-8?B?OWlLTmJCOCs3Sk9uZ2FtZGFNZ1grcWphclAvUFpwSllOMlJScHBUeFNKK0dy?=
 =?utf-8?B?Rk0xNlJuVEJLQkdxQWVTeG10cXRhZEs5MWtiNHRxSUorWFVNSnpRaWd0S1NE?=
 =?utf-8?B?MWNBZ3FvL1BiYXdNVG9yVm5PZ1FBMHVwcUcydTFIRy9ENk50TzJBYTd3cEtx?=
 =?utf-8?B?aHBzL0hTVFRlTkZsdE1GMytDUmJGTis2TFpBdk12eG1scys0SHF1WG1vbXBQ?=
 =?utf-8?B?RDd4MzAvRytJditvTTFDeFdBZ1BKSXpIajBTSWdUUGJDZjJodTNTQ3BNekZn?=
 =?utf-8?B?Sk5CTjU4UjE5Nm1xdFNJVDJJN0NQbHc0eVEreWdxY0x1V1p3Q1J6TW9NRStT?=
 =?utf-8?B?RjY3ZUlpRjlpVWVla0RCQ09EQjJRbGEyS0lOYzY4NXlVc1Irc1NTYW9YMUtG?=
 =?utf-8?B?cHVQbmtHeXJJZ1JxQjN1T21yd053YkR4R2QxWmljbGlDbUNXYjZwd1NVbFlO?=
 =?utf-8?B?RkJhM2pWZXNKVGV0NHlHc1UzNUdCN1pFMlZ6UHg4a05xcE1uTk01R3oxN0ln?=
 =?utf-8?B?cG1hOW5TamN3cWRDdXNjYjVZbG0yZC9saGVDMDJPdStDRDNVVlpkWVhUUEF1?=
 =?utf-8?B?UjNqekFTSDNDRlpiOTlFQ2NGalJxVnhoUDVoU0JlN2pRc0hwQ0pnT3dsSjhh?=
 =?utf-8?B?KzFRRzd0TU5EZ1RNREtNZlZXbnFZc0tCbVVtbmZXY05aZnhhUXA5WENPL3BQ?=
 =?utf-8?B?SXkvOGNOYXhud0VtclNpZzUxZW9vUWdxaTdkUWdHb1lYdzBZcmI1TW1VbEs1?=
 =?utf-8?B?bnFRRURtTHViYnBmbnpCOUtza2VWNjJCRFArRjRGYlBRczM1Tmc0SjFhbUF4?=
 =?utf-8?B?NklIWlJHdk0xYlFWWldEbEtVQWlSQjNxM21JbUNiQlFUT0RxZVlsWHJCOTd4?=
 =?utf-8?B?d0ZpeUZYR3k2MGRIdnFIbU5rTVQ3TWJYcHBGbVJHV1ZRVUJSclo2blQzUFF5?=
 =?utf-8?B?ZGVUODFOTTNZVzZnclpINDVLbEliZStESkRxK3hodGNBbXpDZFRpMnBPNjJN?=
 =?utf-8?B?WG1IWFNkN1c0MHR0T1JTamVlMmhPMkFYOEY0cUM0bWw0TnZ4eEVmNW96MDNh?=
 =?utf-8?B?Q3VCdFM2V3JKVURZSUQrMG5NVFFYeGpFaVE3WUdWNTBpai95ZDhBVjNGM2lh?=
 =?utf-8?B?RXZ6Q1k2bDlITFVXTlhWL0gzNDM1RDg3djFxdXdkUmRXcEs3ckQxZHVUckNm?=
 =?utf-8?B?dFZIYjlVd1JseU8vaGFmaTUwMHVTODdpS2JyWEowMXhLUHY4Y0JvMm9TYXRq?=
 =?utf-8?B?c1k5Y29CWHhyVUNtWnJuQU5LVlBkVnJDSGhYajUxZ0JaRk5GU1VEUnoxVEJt?=
 =?utf-8?B?QjdPV0ZzWmRsNHFTMS9ZNzY3dURrZERJMVk1M09lQzFyM0tnZ3VjMjF6NFZn?=
 =?utf-8?B?YWo3KzJLOTdmK0dzUng5SlVLajVxb3BqY1RnOW10RkQ3UGJiWHJsem84Yy9O?=
 =?utf-8?B?anV2OVZtbnhpMit6YlpIMUlDcGdRYmg3c2hTMHBqZjNEb1RnZTlXajFHWjI2?=
 =?utf-8?B?YkdNalpuWXFmMXFjblJiV3IvajVBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c8cb0c-ca01-4c35-d0b2-08da9d4b546c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:06:49.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCxXLjWPQrehqudAh/waIcD8WS87Sm9XQ+hvql9dmMQrOgOfRKzfhcJxOht4redNJVyNxw3fgcxaEJeXMfdlRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635
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
> Add dma-channel-mask property in Tegra GPCDMA document.
> 
> The property would help to specify the channels to be used in
> kernel and reserve few for the firmware. This was previously
> achieved by limiting the channel number to 31 in the driver.
> Now since we can list all 32 channels, update the interrupts
> property as well to list all 32 interrupts.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml   | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> index 7e575296df0c..31724cda074e 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -39,7 +39,7 @@ properties:
>         Should contain all of the per-channel DMA interrupts in
>         ascending order with respect to the DMA channel index.
>       minItems: 1
> -    maxItems: 31
> +    maxItems: 32
>   
>     resets:
>       maxItems: 1
> @@ -52,6 +52,9 @@ properties:
>   
>     dma-coherent: true
>   
> +  dma-channel-mask:
> +    maxItems: 1
> +
>   required:
>     - compatible
>     - reg
> @@ -60,6 +63,7 @@ required:
>     - reset-names
>     - "#dma-cells"
>     - iommus
> +  - dma-channel-mask
>   
>   additionalProperties: false
>   
> @@ -108,5 +112,6 @@ examples:
>           #dma-cells = <1>;
>           iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
>           dma-coherent;
> +        dma-channel-mask = <0xfffffffe>;
>       };
>   ...


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
