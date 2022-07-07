Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042CB56A028
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiGGKlC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 06:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiGGKlB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 06:41:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2123233A3F;
        Thu,  7 Jul 2022 03:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljhl2AA/LCrEF5IdyWlNtXQ6+TBxX/afeV+dE4FuIFXOaDklfuQWmVOEIHAjhUlfTrDmu5KbWC/3Gyqz+hPD0ife+/0m7iO2aKNNnlaaP3laIgelX1ShWRYecmcbhPVVPZmoPz98RAoWFzw4ofY+Ji0bGIyamC5yFHi6dMKY+bbpCjU2+uqXw5LpVFAnriF0RKySQFyPgcyTc8zvmPdzKJz4Z2zJxiMG29KlA5i8xXK680cvoNEi8xTacO0Ztr6RGG3PnZ6bQlJqjLSh8EyKuyM8B9J47raidpTFIcuzYMmOYQk0EKNcpgQUa48KXpCKUXma6NUHwokwZ1B8ivgvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXKBE6DTzLxB4ZQcmdWAFpQcP77iGwo7KQzaLCXXjUo=;
 b=igC2p/fc+49i8/8f1iH0xuyYP5gxlUMvqRWB4LL8XYw6QEDN4ebFYiqLXzR5D/SB+wX0RxLo06vFX+rvD6hLV86Xa+KcUOphwIaG6ozM1fsZtIM1A30O2FIGPMp4bvyaZ2w01bokBNtFRzUQ4NkhSbjBo95yvo0mKgcwZApNv2xS/hnRRj79rXAmkKSn9SadZM6Cb3vqRIF35E42kjOWyG2J7Tgt/VNl+Uaqj7mIiEj23dHsKAwYnDARqPYyaSNJ0V7zUoxRdRGNlhQihIiPMeF8QN/qaC7K2QUmje+U/Auvy7+G7+0M1Fu0fcUmJBg5XmFMNkssqd+qqSVQCO2P1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXKBE6DTzLxB4ZQcmdWAFpQcP77iGwo7KQzaLCXXjUo=;
 b=Wsln514g4vJmN+/NZYDmMbep3qzDdIG1zfYbFQt8p0X26J2S1scunnDp0MiHdUpUkRTfwO5IMyu6jtE+QIW8NtsOBiV+N5yqnBHhs/6LZjED6C43T1lCT1plDKbYSGMDXpF7nMm6w4I/ZTv/I0m8WS1P+q5zINhjmfU94wLY3y1HENqT/ZAo7ctlgooe9hMxuTpRHYAdyOEbeuRViZ6Ml4UUBf8/rMSBVVHez6DSkA6zGaQeSU3OyclhoB/5pYHoc4XjjasEn3//2yaeIDyBTXILOtcHmJ2vE9HSU5JlOYMNNjkelUR3t3IycOgeIWzpbr0FRxebP0QynFtNcWCggg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MWHPR12MB1438.namprd12.prod.outlook.com (2603:10b6:300:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.19; Thu, 7 Jul 2022 10:40:55 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d%2]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 10:40:55 +0000
Message-ID: <dcddd8b6-cf22-584a-bc7f-ae1b0d6ef043@nvidia.com>
Date:   Thu, 7 Jul 2022 11:40:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] dt-bindings: dmaengine: Add compatible for Tegra234
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, dmaengine@vger.kernel.org,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20220707102725.41383-1-akhilrajeev@nvidia.com>
 <20220707102725.41383-3-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220707102725.41383-3-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 242ade26-9571-4455-42ea-08da60052bb1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4AL/ke9Ay0AoNpFDvm/f9vW1jjxvEAx17p/d0wYaCPNUAPEDG8uZF71T4miO1CkqS7WRsrD5EglPHQQ+xGEofyjTIVCxgWaerVbOekvp/QmN1/pGvlP6JVwzsiQO1XTtanQBEpdR7MP2Q/fbgtkc30t0J9PLyyRvnl4cbFYREXRG75xR4uyu1rn70+XClxyC6K8DlkNjHJX41dhP9z0jhzuOy43PkYpvBja0Lao87yfo5R/Z5yXs2LNByQEdeZDfjfGIYvXxwEpnr6G6qx96onI/p6afBhkAIaBEpkIVeQ7LAar/vezW0Qkd8tiWxAlOt/DYI74SrOcHPqxhOT/xVLM1Gcf8RHX4qMVs+WJOtaOzMlVewtBdFeFKXTnCI31oUTn21JTPU1N9EXUjxu7yoFftjUgPICJCPdQH+BkW7FpZXi9Pb+zIkopC0juybTVCgcgIyjQBCA/GfErLeKxtulPj5ddk3x5yA97BFrE2X4gtAGB5B472ODDfMiSid17ahxysNbi010j5fAPgP58orSxjOCMZsK2mA5X/3N1ECTkC+l1ypt6OHB7DdvRfX6QYK9eDxCLpWBk62xVADZHA4jh5zCiv7tcRBGQruQB+/JuD8AlkwvQ7SwMGGWLUIp3nSiXChjspnaJ8kgFN01ZS7nOkJmJDPBtnPGZF2bLjWvfLqKddWNL99l9D/xiXwlw0qqs8b1NWnnBWGZ9WV9IF+E32z3MzU2nCvFU1p8HfJLJb4OKnuicxvqP7sZ5lkeiTRAI9c0bLoIEw9FivS9Zh1esyeljmG2yXnahD6rZB25z0oGPbAn+8eCkEGA1bFshGZ1O3mUmLPSlOo7T/TAsRnRsHiU71t4lwKMhdv45lEwczFSlR14bAClnRW4hRvqX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(5660300002)(186003)(6666004)(41300700001)(31696002)(2906002)(4744005)(86362001)(6486002)(2616005)(478600001)(55236004)(26005)(6506007)(6512007)(53546011)(8936002)(38100700002)(921005)(36756003)(66476007)(66556008)(66946007)(316002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExFYWpjWElGY3BVeDVVaDBHTmpvQ3piMjNRbis0cFlkaytNN3RLZ3lRN0FE?=
 =?utf-8?B?WjM3N3g2a3NVcDZMSWZDRnhjSStuNG5XQWFIdEVBaWdjQThlWVF3a21WelQ5?=
 =?utf-8?B?RGcxU080dmhVU3hVWHRpQTNPNEpDWXI2N1JORkFnOEo4UDdVNEhZbTBvcWNQ?=
 =?utf-8?B?K3FhTkNTQ2xrMXBxS0lvZVdrTng2eXptL3JzME9XUnNYV1ZmT3NiUWQ5NFFu?=
 =?utf-8?B?M2k4RUdXS3o0cDlyenBSRzA5K2hjdjBlcG5kWUR5bnhpYTZ5WVFPTGFOTVJI?=
 =?utf-8?B?N21QS0JSS0Z3WjVWQUJ5YmJNMy8zb2xJSGdCNkoyeDRrOTlrbGppcXNCejNv?=
 =?utf-8?B?UGxMaTJrZmh4TGlHWldXbjRLamsvZ2ZuekhHbTQ3UGJSYWoxekI2L0szVnpm?=
 =?utf-8?B?WmFRbDNCdlNES1JkblJjT3FFREpaK3ZYOHprUEJ0NnRiK0hlekJQN3NRdnl4?=
 =?utf-8?B?V2xFUnRxQTZ4SFJ4MXd3eW5Fd0xwV1FWbU14RHhjM3NwVHF4M09VV1FOZDV5?=
 =?utf-8?B?Sk9VREw0bEExM3BJL1JlVzNvVkZmZHNDSU5XQTBsQmgzaHIvakt5WEJ2VmVV?=
 =?utf-8?B?OG5uZkJ0cGdaYUMvbjFNeGF4bVorS1ZoTTJ3dHJIQ1RZK25FK1dadE1jMnlY?=
 =?utf-8?B?alNUNW1ENktKL2drRGpackc0MElaMkpnT1NTMmNDMTBWUis3ZkVtaVAwcjBR?=
 =?utf-8?B?RkcxL3cxY3ZnTDdyS29Sb1dCVHBkOFBmTkFUOElVaklQVjFqYno1SmlHQS9n?=
 =?utf-8?B?T1FGWHpYYzFoVzU4bVlTTC9DbzEraG0rVXR3SWVaVXZ3UnV2UzI1RXgyaGg1?=
 =?utf-8?B?OE5ncjN2VFMvSG1VQWIyL2hiMTFyRGxJTzVMTEpsN1QwcHZCZDg5ZUZrOHQ2?=
 =?utf-8?B?aTlmY2NqREJZU1l0U04xNkRHQlovajMyNzNXdUtsbTJoNHRrUWNUMzlOVkRQ?=
 =?utf-8?B?a0xpYU5sR1k3UGMwN2l5MXVwYmNqZWFFTi81WDQzZVRMVlUrNEhnOFZEMlJP?=
 =?utf-8?B?cVJHL1NrVUxPUkVXWXlQRHIveWVESjFRWStaSzdlNHFORjZmTXNyUmIxOFhR?=
 =?utf-8?B?Y0NUMytyMzRqU2tra1NlOHYzTEFMbFQ3bjk2cUhOZlpMK3NPbno3UDR2Q3Y0?=
 =?utf-8?B?NnVRMTV3QWdVdklTNmtEbVNjcTFhcyt6Q2VzM3BybFpURUI4aEIwOVlyQXYv?=
 =?utf-8?B?MkNZZFlVTDMxN2Zzc0hGMHJJM2pXQy9OWGxkeDdHRCt6ZXlTdVdDQ1RMNkpI?=
 =?utf-8?B?UjNoT21rRWY5NlZ5SXRBZzRSQkhnWEp2NWhtS0FXWDB6QmdOVVh1RVVZV2Zr?=
 =?utf-8?B?RGxMWGpYRUJ3QmZZOHUrLy82VzY1ZFhjQzBNTUJNeHFpYVhLNXhsMFJuNmVn?=
 =?utf-8?B?TVlIMVZIcGVrOTJvQURRa1ZMS2NhaHRmQzF2MWU4aDV3UHduN0d2aGRDMTdG?=
 =?utf-8?B?YVo3OUtvNXlxajdQRnAwZnFKUmRGV3ZROFNLY0cxKzkzN1dKK0dVNHc0N0k2?=
 =?utf-8?B?U3F3Snc3THNkUzlRZGhjV1BGYkRQVnB3M0ZHRUZJUlBvcVdONktLbE51ZXNC?=
 =?utf-8?B?YzlNa00xZmV6aGg1WmQ5cjRyTFFGMFhQNyt6MkZRS3k4b0NLV09LMndBQW9l?=
 =?utf-8?B?bnlGdjM3QmtKbUlPaE10TzRDTFIxSEl2VmRyZ0hOVHVId05pWi9SZ3BrQjli?=
 =?utf-8?B?cmNGZXBUdWQ2QmdQY2xHOWwxN3pzR3lnQ083RC9JRGZKSEkvalNxTTdoeFZD?=
 =?utf-8?B?Ty9SZkJDOXJwdUJUdnhsd0dTbkNNZlorSDhCVjE3R2NVNkJaN0h0SXFWNVdt?=
 =?utf-8?B?R1NuZktvQTVYTnRGeGZFT3ZUVFpPbHZ3SnQ4NTBiRHlhZ1BOa0RoS1ZoZE1l?=
 =?utf-8?B?S0Iydmk2UE8zcXBEcTJ4QVFzVkZJK3VJOEYrdjZQVXB3MGZaNTlhWWN6SFBo?=
 =?utf-8?B?Vzl5U0hwdzBLTHNXR2liVDhGSDR2R0k4RVVQdk1YRTV4V3ovNUpEUDF4RjVv?=
 =?utf-8?B?M0Z6NHdKOVY3eVY3dzNZKzFkbHMwMFg4KzRCZXErL0dtNCthcEczbkRvOFZt?=
 =?utf-8?B?M2Y0bDBkWklxU044ODlQUU40RDlRMjhna0xIdWNadU1UYkVQeVNKUjUyZFJn?=
 =?utf-8?B?QUNiK0p5c0I0WStoN0V4a2xQd2tCb25KMkpXYThacU5DZzM3ajMvb3NNNm1Q?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242ade26-9571-4455-42ea-08da60052bb1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 10:40:55.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mqxw1oOtCQNhRNZwQAqvyBP09BvOoD63cEDjGuniDVQghV7+X1WmT5706i9F8I6g+lgFJ/9Qux7NFJkAQdbLQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1438
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 07/07/2022 11:27, Akhil R wrote:
> Document the compatible string used by GPCDMA controller for Tegra234.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml         | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> index 9dd1476d1849..81f3badbc8ec 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -23,6 +23,7 @@ properties:
>       oneOf:
>         - const: nvidia,tegra186-gpcdma
>         - items:
> +          - const: nvidia,tegra234-gpcdma
>             - const: nvidia,tegra194-gpcdma
>             - const: nvidia,tegra186-gpcdma
>   

Typically, we put the binding doc patches first in the series.

Jon

-- 
nvpublic
