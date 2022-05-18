Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9492052B083
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 04:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiERCoR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 22:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiERCoQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 22:44:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAEE2D1E9;
        Tue, 17 May 2022 19:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atZx5HRtv5xgbQiD4dR4bdX/Z6935xbNhydkZ3Xj2cX8AmSy1pDOwTGbQTsoAIQJeV4Po9Ybs3mVKlFTws0wghuDYb2UaKO3bxbIAD3Sfdwk3KJjgV8D0xzy51cBhMWZmjHUva0UK/5iIuQ3dmSMSsaC+7unel/kH1olNuflG2QALSdXD/P8uEYLp1iqSopL0ySOMpEKTt0Pn/YcOfS6YhQqFxv41YadEIgdRhTowP/e+1lL+FuZFRWcLxzyDzhU2E77SvPjImJh0DanD5GGadVJe2yA9KfSt25mjjaspR5YdfVwuGDyC6j6ZYcQd+TJ5pMtyqPJvydWnOIBObZpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0/QkbkU3yUWmuSPxRUx4FyNzsUL0pouWI+2eCIZAzs=;
 b=bxvun1ymwuVZbLtpaZSI5Z+jF2MNUdG32I1dmTBB33X1cGsPDtfggXPlJ/OsdKphm3mAE7DCtJzuWnukPFSUdepkkUhcHtC6k0hJcSVxyxSfeoTIovh7uztlFhA1AV5UiEaasu/dRlsUDye7bd2gUtbcfNCj+irh27bRHStxWQitD5kTp2+gXOr1pba/8kwSGmUapjRut0ZMaVLopEeHMzicF9+MfTMTFE1abelncE70CPi5eFY72oxQ63XCm7/EfzXzTw1gwtn1M/MwF3PGP7eogbn9+iLt8rGL2QxTGI7LGwwjmNsmV+EPgRWnKAT5SCb26pMUTntqzB80ZlXwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0/QkbkU3yUWmuSPxRUx4FyNzsUL0pouWI+2eCIZAzs=;
 b=Dfjggpi/P/VuL0m18VBQEbPlAHc6qy2/5qa+tpA6YFO/1JZ9kLNscGYq7MMWhrNAv51TEvL/lkhws/OSdz652L/3MMQ5mb4CsU+icqtwqu/OaqfX6X6/VGqxOe1dKKK6L5ib9J5WcqKWS5kCWigcaAynsf+gZ6HQjOoy2MHuJn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3127.apcprd06.prod.outlook.com (2603:1096:4:76::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Wed, 18 May 2022 02:44:12 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 02:44:12 +0000
Message-ID: <b0438374-ff82-e74f-0b83-e0f2b4a99e36@vivo.com>
Date:   Wed, 18 May 2022 10:44:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/4] dmaengine: sprd-dma: Remove unneeded ERROR check
 before clk_disable_unprepare
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220516084139.8864-1-wanjiabing@vivo.com>
 <20220516084139.8864-3-wanjiabing@vivo.com>
 <214de163-d576-d9be-76f2-3b70eefd6e68@linaro.org>
From:   Jiabing Wan <wanjiabing@vivo.com>
Organization: vivo
In-Reply-To: <214de163-d576-d9be-76f2-3b70eefd6e68@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYBP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::20) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9d24693-1778-48c7-3241-08da387849a3
X-MS-TrafficTypeDiagnostic: SG2PR06MB3127:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB312731B3C421D60EA08BAEC7ABD19@SG2PR06MB3127.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: llH7pu97yjWCFtDSkrlgEARrVRXAqfg4zH1nwOj9y14AC50RpZKL42wBoMzPEv0N95phQ9VFL1pDZzd5TOwCKmgQjBbuCduC6zyqR0xtRLNkIoAtSnEIF4zCJGx5noNZSgmdbDkM6ItrgJiIIDcRbyUXmwoZGckeXZfVVFOo3cbN7quAvw/EzceEyiQKzSWoD9Ahbs3qXmuF41+wM/QmND7Pc9mLTX3V9K7Q6VOd0LIDiSkfoIcX5/Sa3fmC/h/NYnbb2iGyGCeCsg9GxOCETBpekOVe1MfRsGqPTNzw+L8N2bCiKR8UvqmTJ8y3XET7FsqEXvM0jejYmSphjsoBhEvDMOq6VsLsPuDjLDsBvYb75erWPYK45Fs1cZehmN51EkZDrVEFuVL6BXuSt5gw4XWqzstSxkI4Omrm1b7C7XGxFaaj8v7ImDksb5106NSIgqXHZeASXG2mL8qeiM2dN9bBdsxVte9Tr/pcCupL5+RHRhQNsIuQe1VEmHy31iFElugX8zVAI+O0VvMWzpq7qLcmcJqXHmeyPFvLC3vraV2ZFiYngoPcvAhqg+PtclXjfagElnFmbLsI8aVJHzhU1xE1clARMvK0RWP3xdfMp1tSybK9VFb5Tsj2vTMgR9zKlr23T+lmkWOWZLGwNhfi9vBf23GM5ODWqst6SZoWpWcEn1OBEw4cb2KedP3h8pwQWtlwl0DcaJR6ExAp0M+kNI7U9RZ5avkPmmKRBzxSIGgqcb6Sk0PkzCjX/pLnnG9nGo/Qj3Q3MeR6Zl8yPa36L/f3Jz6W30oy0CN5qV8f2+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(6506007)(31696002)(6512007)(26005)(5660300002)(66556008)(66946007)(53546011)(52116002)(36916002)(2906002)(8936002)(186003)(49246003)(6486002)(31686004)(8676002)(66476007)(6666004)(316002)(2616005)(508600001)(36756003)(38100700002)(38350700002)(86362001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpxYzVpeHlWeGdFcVZwWDJHOC9mSnhkZnRUZUZkKzE1NDQ1Q3VpVjRVT1Mv?=
 =?utf-8?B?K2lRTUkxUkpja3dCK0M2dXFUWnNFU2ZvMUx3STdZRzVrcWQxS0ZRSjc2aElP?=
 =?utf-8?B?VnRjdHh0NGVia2ZRTDU0KzFEUmVrUThmQXJtSXJlUFB4R3hxc2ZlQkRhZ0Iz?=
 =?utf-8?B?Zm9CZ1grd0ZQN1YrblNvanlJZldmQnJqdDVUU1BhVmVaRWxlVXZUUU04MlI3?=
 =?utf-8?B?QW1FekhKK2ZQOHJtbUtNMW1nVWY3dmI0TkRodVdzMmhkNmNOV0xIVngzcmdW?=
 =?utf-8?B?QnBtZ21GYlNwaXo0aEptQVN6ZW9uQXNSMEhhSGxmQXBMMW5ncTBKR3habUdO?=
 =?utf-8?B?NVkya1h0SHZyWW9adi9KbHNwVTRhbmhsRGhWSk80S1NwWnZjVWNHWkZNRG9q?=
 =?utf-8?B?YUprcU12eXdPZHhVb2RHaHNqbFZhVWVqeHBmYzFWNGN0aE9acHR6dG1wZWk1?=
 =?utf-8?B?RmMyTjRaTEM1R2NtNHNYUVNxQXVQdGxKUitVT0dnY3paM212L0g1M09vVTUr?=
 =?utf-8?B?S05hcUQ2OXdTMFV3SVZhLzFndzUrSkpVT01wN08xenJsLzJ1ekRKMEVTSk5E?=
 =?utf-8?B?V1VQMUl3Tkt1N3JXR24vUE1UWnFFeGlpVEJVTVlEa1pwT1BMbCtIeTlGSCtW?=
 =?utf-8?B?bzVBajRmY0M5b081ZXQ2OEUxTDVFd2t1ZFgwUktObkZRQnJEOFFwOG9jWllz?=
 =?utf-8?B?aTFoemRoMGIzUG02S2Q2V3N2cGcyMFFXL05SLzI4S2R5b1JldllYaFk3ekJI?=
 =?utf-8?B?cnZrSFdoUTVTRFhQb0toZ2VwRnVac29OSzN2eEpZUEluWEJUUWUyeEhlQndk?=
 =?utf-8?B?Vld3bXdxMEFRYXJ3VktOMFdEOUxqMmpLL2NUOXVBV01hVFBHUkJaZVR0bGEx?=
 =?utf-8?B?eElNSkhjV3VQM2hCaUZvaUVNU2ZHS0VIL2xRUDZjYThqT2JxQnQyWWdmZ0Fw?=
 =?utf-8?B?TW9ZMnduQ1M1OFhwbWJGTFhkdTVDSGViMVp2TnM4Szlkbk5xaUhzbS9jQytn?=
 =?utf-8?B?RVI5bnFhRmlNa2xNZnkzUnBzNWh3dEtIMmhlOGVwTjdiTitQYWp5aUk5Y2p2?=
 =?utf-8?B?czJUanQveWo0Nm95dm1Gb3dvMWo3R3FoK3JwU1hmWGlCSE4yVmoyZkQ5aHpR?=
 =?utf-8?B?MEtqSE90NnZmeVNlVGQxVlI2MXhvWERYUytnUHpoUlV0RW5jRXVvWTMxTWZz?=
 =?utf-8?B?U09ZeXdCSERlZE0zWEV3N0h2cS95VEdQS1Z5NzlXY3BwdmJkVmx2ZEc3YjQv?=
 =?utf-8?B?cVo0NFFyY2RseWlPVzU5ZElIN1J4eFB5eU1pNzUwT21YUWFqY0Q3a3ArMWxi?=
 =?utf-8?B?elRpYXBWQ2gzcFlnczBCenlNeklNTCttbTZMVXBVdG1qZ1FuWE5oMUZJYVUy?=
 =?utf-8?B?Qk5zNWpOclMrclo1b3dUY3l2Y0tuVExnUlFKcmIxeHRsZkFjRTJpOFZYbmNI?=
 =?utf-8?B?d0RmbGl1K3FBNmQ3c0lkeElBZXRjWExacnJDUjNxK2d2ck1sTnJvUllxWUkv?=
 =?utf-8?B?WWpzUTg0dUcxOW5LWEVaN2FzSGY2VU5xMUZtaXhtMGJrYXY0L2JWM3FkMllq?=
 =?utf-8?B?ZzlQYm5va1Q4VXU2T0J2Rk9FbTFtYnNYNWswSWkwOWpoa1RDdnZxbkJLREpZ?=
 =?utf-8?B?Q1k0TTlidzJ4RE84bkJUaGVZd0E1VEdTOS9QYU9WdVV1VDlTeEVpOHJkOW5n?=
 =?utf-8?B?Rm83ekozcFY0THJMbVVKSkptbEVIRnBaMW9aNXNFb2dNc1dGY05CQ09ZTSts?=
 =?utf-8?B?Y3NkZW5HMElnMDlrUnkxODFjaTVLakNJdTZnRXNGaEhwcVQyUEZxd3dCdjVy?=
 =?utf-8?B?QnNlelRHNW5LTWJZSlRhVmJxckNCR3B2eWdGZm9ZTnZYWUdXYzlPUmYyUTdZ?=
 =?utf-8?B?T1I3dmpCWWJVc2JiWlR2RkVicjhSZkk0L2I2MkF6bDJjTXJtNUUrcjA3Z2tu?=
 =?utf-8?B?UzBZWWxwK1FjTFhRT3k5YVliZXEzWlFtMDB5cEQzVE5CY0xocEdWSjlzdzRt?=
 =?utf-8?B?NklCclJwV1ltUUw1RlVxWHdpOGVzSkNmalQrWlFWN2xZdXNBNytuemhMTjZB?=
 =?utf-8?B?aE9VNUNHdlN5NllEREpVRjIrS2d5RU03Tmd6NkpwOGppaFovV0ExSUd6eG9j?=
 =?utf-8?B?ZTQrN041K3JZR016Q25pYXRqVDY5akY3NFFhQjJIRWtVYzU4SFdGZlBQaXh5?=
 =?utf-8?B?SEw4eTZXdVljVjMzRTZvZkhyd2ZRR1RMcUJ0SUZEY255Si9jTWpUWXlCRTBm?=
 =?utf-8?B?enhMNlhJRzFGVXdteDg3Q0N5d0QrL0hYMlU0UUZQRU9tN2RUZDU1US9vbGRR?=
 =?utf-8?B?alMvOU9ocEIybk5wamJrcHI0TVVqWGZaaUFoU0dwaGxLNC8zUkFnUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d24693-1778-48c7-3241-08da387849a3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 02:44:12.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11YV+ERikADauojpIsh4CpQQ5YRmraFH/qFjzE9JHTVNGeXbT4VCfVYPdfBeW6jtYzCri77x8yZ1ThYrGpDQpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3127
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 2022/5/17 23:13, Krzysztof Kozlowski wrote:
> On 16/05/2022 10:41, Wan Jiabing wrote:
>> clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.
> Hmm, maybe I am looking at different sources, but which commit
> introduced IS_ERR_OR_NULL() check? Where is it in the sources?
>
In commit 4dff95dc9477a, IS_ERR_OR_NULL check is added in clk_disable() 
and clk_unprepare().
And clk_disable_unprepare() just calls clk_disable() and clk_unprepare():

static inline void clk_disable_unprepare(struct clk *clk)
{
      clk_disable(clk);
      clk_unprepare(clk);
}
>
> Best regards,
> Krzysztof

Thanks,
Wan Jiabing

