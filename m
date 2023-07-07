Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED374AA23
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 06:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGGE5z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 00:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjGGE5v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 00:57:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209AA1986;
        Thu,  6 Jul 2023 21:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBLeCFWUXMnPFHJ8u8FUwQikep06Ti+SZpzx4KLJuA9qp20bvJUY/kisGpMDTWu0z7NbmSCQxfuhicIgeaVJYAqs5bzwlD/UHX4oCbNypcw5o8aTSMRIokFZnXagEGhdxGRqkn3RTgV2RYwAxcFUKm3VdHTouvpvbkEPmMo/jucpDHW16yM35/6YB2MWag+UorMwrUCHsjshD+ugHbp67dTIxjglUYLv/z+R2O9U8AIt0ELaAte8wdPNZFyWz1DwH2xhMTt2nOUJ/L4jlN5cjTMUNaMkmddWUo1T4WlFKm/RNtST5lCkI1jZgpi2cuVMxbbApx8gjL+lIH344/pQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tdk4rQ7ZffYZGQIBV0iwNCpfMPGg8WLOfJADgX9+yZg=;
 b=GQmW0N1fTuwsgKnwkBHFApMNY9IoiX6p650u9KU9/7CcbtC2aNdxNfGSSvZXpF6CCIqHBu8E6M5cm524KB3DfH1/RIKjGWn/SYZAiMcxjgiLAWKF+PQjnXJZSW309yN9TUcjqEIYX0q1HUBF8A41t4j1bCSjKq3AorwRaBO/XEYN68ZpmUaAlYs2EHOWWMY3dWnGm80W/oK0QymXAJm+SIdg/5OQCeEajShKczMy0OgKswIch7syv2FG6Hl863byqAMnkJJwFqS61nw0AQSFoaeEgHMXbNFW3Vu951dQUdzMChD9wMISsTIqRkuvyt+1+pIz4nqKVu9Xcz/+R4RuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tdk4rQ7ZffYZGQIBV0iwNCpfMPGg8WLOfJADgX9+yZg=;
 b=ugSeuYDYYDi4RZoaEbCqje2RFWCf2RtYwGRiZ1Y8V0ks+rieJDdOqRMCstHFpnAz5knTLgFJQi8xnXvluhIT7wNreHjHWAmf/U4N8DEOBQaQ3uD/08nx4dD7JoOLuQC7hMBujxMEzmnTcEuFpcZwQdnRH5fRKj9VoKyITO05h3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH2PR12MB5020.namprd12.prod.outlook.com (2603:10b6:610:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:57:47 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 04:57:46 +0000
Message-ID: <f128bc05-e1c4-12b0-0456-1483683b823d@amd.com>
Date:   Fri, 7 Jul 2023 06:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] dmaengine: xilinx: xdma: Fix Judgment of the return
 value
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, Lizhi Hou <lizhi.hou@amd.com>,
        Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:XILINX XDMA DRIVER" <dmaengine@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230705113912.16247-1-duminjie@vivo.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230705113912.16247-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH2PR12MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 6965040f-a025-4a72-0fcc-08db7ea6b4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E91eGoEXibYAtgABuICbOG0gpYXV0NOdFwndWsHIF8+hsdS2zUq1yLQ8iyifgHfPJu1vIh0HA7KMwcG1iVB+bNkmzwdnqlYzZLYh90jFuTzXaegh8VjlDrBeDvDmFDnmDccWxsECGJXRvAlidoxWwA895Ga7WnuIiG4GWC7NHk1ePQ4VjxsawBeVAEtfLHBtw4gsWziiD43sx/rh5/7sVkaM2sJyurlo5Q8S+wL4CrG4wlfCViKjnPx5IKCgPzFB/+y5UCgkYxyGaOr/oxce21cFnLGPbdgKW3eNcEVSmBbbNRqOjLF2eTs4Kg2vPHyn0vOwmPAjzrpRtM73yWaLANHpjZVC3PTlJ0eQlHwapAllLPxwwQDqCo3pp5Ryq+5h47nwSqyAI0KqrNOo345h2D9ql2A4u6IBCeeatO1taOUPc4dRUZd8FYSf+KGKtEG9Tqa/1xsxusfTUR/oMMyKpZUTITUv5+Ik7l8Ag0FaX3baQaaz/SKaC30VjuDJTORlmkdJgQmrAVPIzGYiz7OINayKIvdnk8URm8mjtd97V29iVEDOFCIA4c80XzgSBG8I3t4/+ty465oE3jPNREOWpKaBpiKiB7j5X6NLcGuQUDz6CQ3pEatXYWyv99UGViYmNJ+/i0+TlmABap+OqSapoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(31686004)(8936002)(8676002)(5660300002)(110136005)(2906002)(41300700001)(83380400001)(38100700002)(478600001)(66476007)(66946007)(66556008)(44832011)(4744005)(316002)(4326008)(6666004)(31696002)(6506007)(26005)(6486002)(86362001)(2616005)(6512007)(186003)(53546011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHl2UmFqVm1xK0UrSGlLNEFrdWExRCtpYzloR1FVZjcvcVJCa2gxalIzL2Y0?=
 =?utf-8?B?QzFtV1Rvb0czN1hxMFliN28rTitCYnhZSlprMGI5djQrWUM3Z2dFcHgwb2RZ?=
 =?utf-8?B?NVhiWEVJTWxEOXJqR3BmOTdGdTZPUXJROWhidUgycWUzQ1VzZGJwVGR3TFZw?=
 =?utf-8?B?YnpIYlFsYTNCNnRCSmNsek1mcWZRRWVmZmpMSyt2dWsvV3hCTmFnVEJ2WkNK?=
 =?utf-8?B?WXdIVFV4dFdyM2Y4eXU0SlhrckxrQjJEeVd3SEMrbWNoN1J2dkVhcERJaEd3?=
 =?utf-8?B?QzdlQlE3SmJzMWs1V0JOd3lOb2NEd2RGeWpsTGhzaGJlWjRxSEJVa1puMlVl?=
 =?utf-8?B?NkNySHZLRmVUd1dDUU84OXYrM3FCTFRWODZQV3Q1TnpWQzVnV1RhYVB5RWU2?=
 =?utf-8?B?T2tPWGU0UkZjMFVPYWRFUHd4enNRZXI3c3ZwK0FSdVU5UjRsYWJKUkVvaG5G?=
 =?utf-8?B?bFB0OG1oa0lYcGNLSG1TYzJ3Tk1hRFhHWHlPc3ZmVk82eEF4NGFDdyt4MWgx?=
 =?utf-8?B?emd5MVNReU1ZZHZCck1vT1FHTmt0TE9HZnBuWEswQkQrRTByVGdvMlpzVVUr?=
 =?utf-8?B?eCs0VUlWZlBEWTErc0MrckRuVnI4alh0WkpxUVBSUlZLRktndktXMmVhTnlI?=
 =?utf-8?B?V2oxQUdYVFFEeDBJaHhoMkhGajlFTHBycmJ0c04wU0p5d0NNWkRZNXA0TGtZ?=
 =?utf-8?B?eU5TdkRkVkJqUU54azE1bnpZWVBNd3RpZU9LdDVReFFYb2V1T1podGZDNEVT?=
 =?utf-8?B?NE9ja0ZxaDdRZUNyMXZFdzUvcXlYZXZsMElLbmZCL1Y3TDZ5end4MWhIOUgv?=
 =?utf-8?B?VCtYZGFCRGFENnFWU0t2NER1ZEQ1UUxEV0JWeGhVaENTbC9zNElWME5Yajdv?=
 =?utf-8?B?SzdDQnZYTWhBSjBCdHc0c0NSZ1VMbS91bEswRU5kUWhaSGhleCtkS1dXRjJR?=
 =?utf-8?B?dkoyeVdwVmVzdXBYN1RQc2tFMzNGd1doYm55c2JOQTBlTHFvQUF1cTNFcUkw?=
 =?utf-8?B?dTMvK2xnTWc0ZXBOV3hsZERhbXN4WHA3OFJHcGhLUVAxdVQwVy9CREhuM2Nw?=
 =?utf-8?B?ZWhvM0lvOCtwUWZneGRxSjc2akE0a3BPMnNYbXZjMzhycUVucDhEWldGM0Q1?=
 =?utf-8?B?ZEJGRkxhNGFoT2xxMU14OHpuM2htMXFwNm5xdWV5cThNaUI2T1RLNTNldmhx?=
 =?utf-8?B?ZU9ZcTgwMHdkNUVJSGZYZzlydnBEN1ZENExTYVFrM0ZYem91ODcvODlML211?=
 =?utf-8?B?STB1NGtzRyt0STQwSG1BZk1MVVlyMFc1RGxGVGF4STFLT1IwNnJueThpT1Ur?=
 =?utf-8?B?c2NBWFhqdmNiSXpVRkpmTGM1VUwzcGpuUUsvY3p2M0EwR0hWY05lTWRqUXpz?=
 =?utf-8?B?NlFiWGlaOFE3L2xnRDMvekl3WnN2TWp6bmhXZldsNjJ4TU8zL2xudjVNdnNa?=
 =?utf-8?B?cXRiS3pwR2orQnBrSlliS05qUG1MM0czamtzTmMvaXFOdm85M1Z5RVd5M1gy?=
 =?utf-8?B?cUE0azBJQkJBenpUaHcyLzVGQTNha0NpSHkzWFQ0dXdnZWJadDNQNURQNFlI?=
 =?utf-8?B?NzNOWCswczhPNkFIZzk1ZjBhUm95dFR3djU4UGlGZXdCR2F4MThOTlJjQ2cv?=
 =?utf-8?B?OVkxRlhZYkw5MjN0dU1UT0t4RllQOWpwaTlCYU8wRTVNWHZnemZaUjh0NXdW?=
 =?utf-8?B?Q2QvLzY4VFBiMUFkaENaNkdqalBSRTAyK0VIS1dBeW41amk0RDFWUjQ4QWYy?=
 =?utf-8?B?OHl6dkdkcE5KcTErK1dJU3BPVy9wVTJqa0VNTmJFMUxybXhhMlU4anJOSnc2?=
 =?utf-8?B?YzlDSmcxd1NaOWFSVjM1WFNOeDUvalhuamZCb09BUjNKRTMyWFJaTTJhbS95?=
 =?utf-8?B?T2JDTWVJK2xHYkJNQXgrQVRoU0ZoQWoyM3NReGhvWnZIak9UT1RRblBtTW5q?=
 =?utf-8?B?WFUwUm5tcnY5ck1iNWNmdEcxMFJZd2dqK25TdElBck5OK1NoVVgyVTQ5VEMv?=
 =?utf-8?B?ZUp6c0ZjNTQ5QXlicmd5cUlXY01YOGY2bjlRNlJTOTVWUHZIZVYwaVJ2OG1D?=
 =?utf-8?B?dkhydWQzNFZOaHlIckdxSGkrVTUrZTY3TDA2OEJXV3ZkT0RKbDVpNEU5SnNS?=
 =?utf-8?Q?y8bt/6zb6QSzyYUPHix45+Cyf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6965040f-a025-4a72-0fcc-08db7ea6b4ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:57:46.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT8a9ttFKOYrP3AP/qQtrQt3wUbOekPBuuJahXFC9tY2Q3lUw73WK/zqHEQLZsFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5020
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/5/23 13:39, Minjie Du wrote:
> Fix: make IS_ERR() judge the devm_ioremap_resource() function return.
> 
> Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   drivers/dma/xilinx/xdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 93ee298d5..ad5ff6335 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -892,7 +892,7 @@ static int xdma_probe(struct platform_device *pdev)
>   	}
>   
>   	reg_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (!reg_base) {
> +	if (IS_ERR(reg_base)) {
>   		xdma_err(xdev, "ioremap failed");
>   		goto failed;
>   	}

Acked-by: Michal Simek <michal.simek@amd.com>

M
