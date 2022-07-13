Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052015739F4
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 17:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiGMPVx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiGMPVq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 11:21:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4292945F43;
        Wed, 13 Jul 2022 08:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNdUu0JckvvGul+nhPosKouFVqsdeH8xkPFsqq0veqSDmU4QyrKRwE/jJmeXS0h9/sN8ssyQ2olVm3fKD5NRFyxEHJC6DSfxb6EwMv090TL8YUtqI4PK+28vYGfVaIzTDQzriBjQUhUau8jMO2QJrgZqG0d/DnAM8x6R5ejUlBdkXQhiNxsr6JX7tY5s8Ggkv2JbzFdV6j/40ZSYwh2LfkhzcJ47C/wqO5pLO+PxP8lgXOQ7HrfT38PRpLEbrqwYoQXpkHY7rMtx93sTc6EtW7z+6YBMr1pMOhxnDUxyNAt9GLmbOqE+OWUg6dlKWK8ZVb5LrdjiRgr1WxsnAV8kSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UKKmZYlrtQiHfNrWV5hnmkYbe2hwcY6ber8EvDtFP4=;
 b=cAdTCS/7veAXjSgGwZjz3ShQxMfYPM+q0CVwnQhZbOFvehpUVA9Dp9O/4rUIfQ4z9glFuSLvezpsww0m3Gy3wLekHx2xn0AlA2MSLi06u0flH+3hKaCKasibpHeofF938uVUH2UJlSVDHWbOO0qSnjcRTvgCLavpulPP6TXV7mXsL9GuIkKviCHH0tRmL2PSqc2Uj2i76BUCy/YkS2wZxVuep1TMl2CM+0xhHhPOzQUr4elHocfyx4uNjgWGsbpSywo36JvXiOxANa8bw0RpQL9UXzCWS3kdu7EAQPxbxXXHbRuYnTwzrFrku+InE/xdQARf2OY9Zu6yJqqwhK8esQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UKKmZYlrtQiHfNrWV5hnmkYbe2hwcY6ber8EvDtFP4=;
 b=nUemiwkvH/OeBJViax5sCiKA0UIYSVFxnYvqtfvWIyxfRKJBrRwkq90UCPGGXoX6MS7gCY3RVkCdpV0vd9XwIEZmIDJg+GyRyMA3+5yig4K+EFRzXVo5vL+lBmWHnzmuIWxK9IDXnh/WNwMrHC41GOl6K5Kh7aWDxzP+Y7jb7f8KT4Qao6o6oML+Y+vQdCcz+lp1vUHBMzC76UGC6zo8O1r2TWMXZ+O9ISUtfTqh1ShnstOW/Evi7YSJLe5cMq/aJ1GzMDq6I7U8jo49IykQxeiYRd76GPNscBxxQUgdV0HpR0G+fugEAwUG2OJ2ay9xYN9N8lRJ/4GBFoGP339Gig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.21; Wed, 13 Jul 2022 15:21:43 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d%2]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:21:43 +0000
Message-ID: <6bc92c59-dfa1-aef7-f41b-befab216f87d@nvidia.com>
Date:   Wed, 13 Jul 2022 16:21:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/3] dt-bindings: dmaengine: Add compatible for
 Tegra234
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, dmaengine@vger.kernel.org,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20220711154536.41736-1-akhilrajeev@nvidia.com>
 <20220711154536.41736-2-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220711154536.41736-2-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::28) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c20a643-aa13-4a7b-7a50-08da64e3647a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2v1ZZ2aqoVYy4pKLNTNdlOecrSG+B8Zl8f/Kv3GEn1f5E8nq9R1i8ryg2Y+1WMkfZYK1qzt7VFrMMT+HW2jQBsN7ZdKOGleOrh4ClqIMGGU94i7Gx4xlqoZRmfajT/Gks+Eq2Mkys7DJtCmF81VApqjUnjSgbADVLnv7klKOxWav36L7xfxHKG/K6x7uEhHEpmMy5+Rw2dOTlJi+QMj1qCEPQB95n3fQI9ImJ0riTF7WXVHtaon2HI0yvbhEPMrmwW9/20ZJWMfpcv2SakY/1mt/a1TdS80Bq0w9RdnF2drEvxkA1sJXd9yk2Ufh3LpjFNEI+oQNUmSk7BUTx+JWzQlQGnS40uMWbktZiTGAwgssIOvRM56ik+suLW7KTTXw2cHJpp+5sKdMEgCsTS/8Cj40A/bCknmk+AzQ60a0h7iFeupVOHZMEv7I/r5cLfXo6qOh1qUvI97xDSWtPkzV1pgnzkTUwR3g+wOP2fw6ZFQKtRkwlmONklmHynvnTvhSetZAmkbNdoBPkea7wXi7Ri5ypdbXSlokZuSEgMYgwgjUcr+gTz+ec1gBN6gQHfGgfpYL/qqiyt2XN7e6joVUjbMUcmj09lQsSdpPaPdlMfKgmjnJa1H3Xi7Rs5sYvV9S0JO6I/ZkPBfkqWYx1diSZzwHCDuvplB/BrT0Af5+UF8TzcZHIwUMAd9VHXNnlB9TaQMUKcbarnXmRaRRmCrof7AnkFp9KoLblhVksMDP8PfIJ4DJwIzAS0bR6+K/nGGvnwcYbFiVEBZlvV2Txh3L0KADy0X6brJXVc8H5lyPU6b5kDt8L01l/7AVCwRKbkvMCkwfi2DF6YXtGLPF+dL8u92bqxXlij0Rj6B/OPBV5XAb9GwBwHyagvPLysqlFj2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(6506007)(6666004)(8936002)(53546011)(26005)(2906002)(31696002)(86362001)(6486002)(6512007)(41300700001)(316002)(478600001)(2616005)(4744005)(55236004)(66946007)(31686004)(38100700002)(186003)(66476007)(36756003)(66556008)(8676002)(5660300002)(921005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjdudWU1d1UrZGg0VHBsMHU1STRIWndsZXpnMGpxZGhmOEhaSlpKSmxEWjk1?=
 =?utf-8?B?SHpIaU5McXJuM0ZhU2ZkbG54OGtvWFlCM3N2K0R6K29DTkVUWU16VWlmRnJN?=
 =?utf-8?B?Yno0TE1nemZaVCtSWXFldlBsSEdWak1NcWtaKzNqWXJnL2UxbHF4K2hqWWp3?=
 =?utf-8?B?NXJFSGhEZXlZM2VNMGZhU1BKZ0Z3d214UzJPVWFPODQ1UVI2UytoTkkxd080?=
 =?utf-8?B?ZzJYc0swaEZHKy8wVjRuQUMxclRtWWpSS0lBMi9NREkySU5CQjBqQWpEbzN3?=
 =?utf-8?B?QXZnYkZzSkRCU3VDbVh5WVNTTmpPRitYdVYzN2J6dUx6bTlDQWVVekYyMWxa?=
 =?utf-8?B?aHpBMFJqTVlxU0t1elU0VmY0d2hGZy9CMS9UcnlyUytQc2RhOFV5REZ6VENq?=
 =?utf-8?B?R1RuNEZnQmxNVHl3eUtvRWZtQkpjYVJ0MWhDNVVhK0hrb0t5aG4zTUZtUmM5?=
 =?utf-8?B?aWVPRmdObXFWUzlYaFN3MSt5NzdQT05pemZBVTB4cG13MWoreE9zSUQ3TnJ2?=
 =?utf-8?B?RjZrdEZ5VHptOXVPcGtjSHJCR1VsOVJYbVE1aWI1UnNaMm03TER6bEo4ZldL?=
 =?utf-8?B?QkRUN2ZHV3lqMldWeXZ5SEhCUHUxYmc2SFVuL0JJcHN5bG5UN0JCNDcyTzdE?=
 =?utf-8?B?YktuK1VyL0h0WmxzeHpPNzM1dFdTa1dlbzVlZS84NGNlSXBqUUVXZEZOdFpN?=
 =?utf-8?B?MGlIZHhEZEJiUWpYRXo5VlFnZGZLZGJaL2g1Y243Ujk5UDVtNE5yU2hab2hZ?=
 =?utf-8?B?QnNCMHh2bHRyU0pQOTFCZ3dwRzBYZ1VGL0tPaTk3SG9pOUJTRDFBNFFxazQ5?=
 =?utf-8?B?bGFsNHhqNGk1OVp0cDVwU3A3UzFYMEtDd3VDQWhpMWprZDFBSHZnbHJLVTdX?=
 =?utf-8?B?bjh4SUEyVmxSQXk4bC9pZ01IMDFJVWlHM3V4cEtjK2JZYVMwTEk2c2t2bE9h?=
 =?utf-8?B?T2ZIcWMwakE3dkpPdWZuc0ZXYlpISXRVdUxwQTk3OU8rK0pkV0hYQm5MRlZH?=
 =?utf-8?B?M3IyaysyWEJZSkxDSW4wb1BySkRLWS9CZ3EvQm44VGcvRlZEOThDMi9md1pZ?=
 =?utf-8?B?Y1A0ajFydGUrNEdmdzBSL2hhVVBTckRDa3E5b2JwRCsvdXBJSUxLU0xQcklw?=
 =?utf-8?B?ZVdLMS8vMDRSN2lsTnZ5TjVUZlhXZHFHTFhndVlHV0VoaXh4ZENPQ0JFeVU3?=
 =?utf-8?B?Ym5ia29QVUV5aDBDOXBvT0EweHdJTzJBZzI5THJNT1Z2MzVHK0Fic0E5cVBv?=
 =?utf-8?B?Yi84bGtSd2h2dXpJNEJvSlRnNTY4Z25HWEhaQ1RJbWJoMEN2cDhjOFYyTTBs?=
 =?utf-8?B?MkpFMHQ5S3hmL3dKVXZ6bzJqK2tvbS95b3FpenJYTHFvTERNU1MrMis4b1g2?=
 =?utf-8?B?SGJFUkpTVlFLY1VEcHZ4eDFmcm83ZHQwWmp2UXJFbzF4eDVZL2hZKytBMnc2?=
 =?utf-8?B?SmpvbkVJNEtaZENudFhlekdYbmk0eTYvVmc4VkNZK3BMVDQ3Q0kwU0hPdVky?=
 =?utf-8?B?TzZjME82dlNDelpWaFhxb0hjRkF3NkNaRTFPc2FRVUtTdGplUjZyME9tNEUx?=
 =?utf-8?B?dUltL0tSRmEwTjJ3TWlDbTcyOGR3MlRIb0ZzSG9YT28vMHBrVlVFV3R2eXZp?=
 =?utf-8?B?bHp6WHRzZkdiOVU2QnRQdzF6RExvbjlWWlJ1N2NiVFZOREhNbWxaK25SNHpH?=
 =?utf-8?B?cFFrektwcm96Ky8raXdWYXJDaDlVcGlUNXZ0TE9aUkZoUnllUHRyUXpMRGw4?=
 =?utf-8?B?VEE1QU1LU0U2TDZtN2NsUmpmd1dVcjA1Q25XVTF2YS9idDdCdGpwbkRRbklu?=
 =?utf-8?B?cnR3aFNyYmVvcnM3Tnd1cUZCT0Q1RGxnVmlIK1h1VDVnNU5hNVZuWVQwbkdn?=
 =?utf-8?B?UlA1dVVqNTAzMVpCMEFwNTB0bUFqL0Q0dFlQNHMyYkQwektNYkpjVmJoWVZV?=
 =?utf-8?B?QWFtcU5iZU1BQVp2Ujk4ZklYT0dKb3UyVHRIYUliQ1VlMTMzbzBKM3pGOG9V?=
 =?utf-8?B?VGRPN3Q1ZlJIM21ZZnNsdkFEQUQvZUh0WGZtbXhaVFlXd3FZaFdyWW9RNWNB?=
 =?utf-8?B?ZFBoN3JvNHFwODBDSjMyR25Nck45Vys4aUNTemZQQmJrYkcxLzUrcU9ta3pR?=
 =?utf-8?B?TEFoS2RZOEZqcUUybUJqZkR6WW1Yc0NMZ1Z2dWtkQXNHOVBlajlXZkhjQmRI?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c20a643-aa13-4a7b-7a50-08da64e3647a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 15:21:43.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcqr407V1zRiZ0XGgL7l1cX4aN8Cr/1luGGkc7oBwjIIqyvPmfkxERUNYRu5dTXyXpzZbc8fAD64Rfle5ejaYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 11/07/2022 16:45, Akhil R wrote:
> Document the compatible string used by GPCDMA controller for Tegra234.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> index 9dd1476d1849..399edcd5cecf 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -26,6 +26,10 @@ properties:
>             - const: nvidia,tegra194-gpcdma
>             - const: nvidia,tegra186-gpcdma
>   
> +      - items:
> +          - const: nvidia,tegra234-gpcdma
> +          - const: nvidia,tegra186-gpcdma
> +
>     "#dma-cells":
>       const: 1
>   


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
