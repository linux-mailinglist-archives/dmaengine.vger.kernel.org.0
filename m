Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C8570DCC7
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbjEWMmS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 08:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbjEWMmQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 08:42:16 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2098.outbound.protection.outlook.com [40.107.14.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B6FF;
        Tue, 23 May 2023 05:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU1lQ0x1VrUdo/flxO4BLUcaMtzocqDsZTI3hojJk/TsOF6v7t8yFPMvH45VTCkLNmVU5SE21VKXLLDAwX7q5a2qS0Vi9pdMFVu10NzyfTh6twe/Vj+5Lv4x0hKHQKQ+xKgZsrS0VvgJ2CFAOvaEJiiTe1GBkaSZ2mm0FNkwBRCcF3i/t1V1Sk0CeaG3afYJFtf2vXMaT+uin3yjPKwiUuwMbZ9Bw9tRU+cL7S31UjlNwDrvC/hAyvye/Do5uchJ7m4H1ch2a6Bz4oS0KV1C9tiptquiEaKKkycvNvidI5bksyayIJ+h/0xbB+hAmT2Hu/PhQAoJ7MJRaBfTkl5u9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqeCf/iIf6i/tilrnKpuYORCOLVx6BpLYngvmHACq9A=;
 b=SSlJyOIqYuznauBjr0LCtef4LQ68OwmDFZRc+XeO8aAxQ/wZGZeYmve4XdaTBrBEHc+41pDLz4fib1kzshFW1uESNUpJ4Gywbfb0GlTUiZ5Ex2JuyO+lrkpc0RJwk3i01X+eodS1fMIDFOYAFAPf5FcFqMsuscl+QL51JtgmUjXWGGVnGQAt83AYSzFOzCbQcLD83FoNOVYY2vGBiWWxxYWT/3gpFua98w4JtcZm8c+wj4n0txCFIN1AL9Sm7K9dfo03eFgIopfrh4TinLedcixB8xs2Q4v6BuSRKNvM9OXbNcJBHSQPiI6GE7LlRaNiKiCL5uHjhj36IEHhxogH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqeCf/iIf6i/tilrnKpuYORCOLVx6BpLYngvmHACq9A=;
 b=FlcjXGZznxc5aub8ZC11xG+OHlwWCkUq202m5TznQvbyotxMsxWHmUPd/oXO7o2vjvEF87S+o3n3agYwTMOVioyr5dVo6lv42gOPlViau+BRtCgnfYXUSkm7OLBJcSDM1VN+rBnfOWYGLHbigLVRJTnyURka6uC+DveNbnORnM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by DB4PR02MB8560.eurprd02.prod.outlook.com (2603:10a6:10:388::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 12:42:12 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 12:42:11 +0000
Message-ID: <dc4834cb-fadf-17a5-fbc7-cf500db88f20@axentia.se>
Date:   Tue, 23 May 2023 14:42:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/2] dmaengine: at_hdmac: Regression fix and cleanup
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::32) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB4445:EE_|DB4PR02MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 8925d2df-67b3-4bd0-ae22-08db5b8b2108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruaF24+dxqlk7kArsk5sbb6G6uw4+WFm4vIxK7tKZ9nN0tluW6Zl4Rd3tyXENQ6GdwrBW79KCAyZrGe+Uy1p81SMqaffRxj1DNGE/5Gcvs9S4cF9I6e159zea3ICFZTeV/ibC7fMUq/ksKVHr4VYDkEcdtKizanggYbFvbsvujuAo8uiJdcPyYuvb8fe7WcD/4rYHxvUVxZEFb2flv5D06rNSfYTm2YH9756OBK+S6AlSJiLETZZTu2007vLJ2k4tlwnMjgMTiMUquGbnPs5LnmrFluqqxmhII4+vcn8yk9d0FCOdGwgZkRbdOC0SLw0aAX1/7eRgZvZPM2qazmGFPN7rgb9v2zx0wNq0r2yx6mGNjzD5wiqMEeFm94KctzhHP71jtvr7PaEw2CksEBXNMGTMLbDtnfckJfY1SHQv7hVZWy23fUHdgzF9121OvxqwLusC/QyfKkQbEMyMrCQJrcnm3eZXLiByo27dyJcKZ3HLIVB5Cgh5r00gnPO8idSJXt02u8yqhfw3dkYdwtHUMesJJ1rfXdVwjH3CT+30cefWkqAokZZzYKXm+V2mM2B1Q5L8uwYAYVib25TNJol1H70X+32Jyjmu0jefxAei0phKUh1V9E5ojS5h74uHHi0SPpJ1xsqn79NjHfNfSmwnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39830400003)(346002)(396003)(366004)(136003)(451199021)(186003)(4744005)(26005)(6512007)(6506007)(38100700002)(2906002)(2616005)(36756003)(83380400001)(316002)(6666004)(86362001)(66946007)(66556008)(66476007)(4326008)(6916009)(41300700001)(6486002)(54906003)(31686004)(478600001)(31696002)(8936002)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2JkSGVNV3hjL1M0b2dEbUE1d0U1RnF6d3U0QkZKaGwyc0ZFdk0ycmpEMjhO?=
 =?utf-8?B?dHo1Y1EzZkliQjladmFBd2IrSllMUVdUTndFQVJtVkFPT3NjdG51aVlTVHZR?=
 =?utf-8?B?QkV3clVSTHczenZ1Y1FpdlhBRis0cVc2Nk45VWhFQmZQTmU4YjJzdm4rOHNY?=
 =?utf-8?B?UGNoMVEzY0pLTFY1anZBMGc4LzFlYkQvb081b2NsZUlyeUhtNlg2bGVQR0F0?=
 =?utf-8?B?eHRhaFRseHorS1hCalBWdzlHZGZ0ak1xN3NkTHc5TTRhRzVZOG8wVVZkK2RO?=
 =?utf-8?B?aWs0UHpwRm92c2owYitFeER2bStRNFkvQXNrRlI2VFYrdkY5ZHhDODJsTGFj?=
 =?utf-8?B?U2Fha1RPWHRnNTVoNGdWS2tNdFI0N1ZkSDlneDF2eFcyZ3M2K083dlc0aEgw?=
 =?utf-8?B?VTluUk1oTEIraFA0NTU3VzNNMTVUZFh3bFlZaDFZeWx4QUVTcUttbTZ5Rk00?=
 =?utf-8?B?bDg0dCt5Q3VxSDdMYVdDcFJGZ0RZK0hYTjBjeDFKMUhsbFZXb2NoWEFVcXFj?=
 =?utf-8?B?RTNBSlJVU0ZiU3VheC9BbjBmSXA1VHlKNUMyRjNiY2pQcVltZkRJYlc1S2Mx?=
 =?utf-8?B?UUVQaHFCVVA5OHB6MExETTBUVGxwWEwvK2NIaXVyWEpKMHg1dFhZQVpHNVA5?=
 =?utf-8?B?bXBTUE1qNGFxM1BSRHVUY2d0dTVFOWd0d0xBajBFNkNoMXRkaFFRajJrQWRE?=
 =?utf-8?B?eG1CR05xQ0RsckR0M2NoeEZrSElIMSsrcHVDdnVrTnhTMlJFbXp0Q1EvM3pY?=
 =?utf-8?B?V1dqNENyUkphSzdaaXd6bjhVMUZNTkNpWnFwT1RSSEdBMDNKS0dDNWRWY1BE?=
 =?utf-8?B?Z3JsM1MvU3NoWi8wRXoyWXBpQjB1OWlGM0FGYjNmNk5qNmpESjN5bk52ZTdm?=
 =?utf-8?B?eDNURXU3REgzUUNVaE0yQVVNcXVNMEJGQStXc2Q2cjFXRHFScEN6dzdXdzQv?=
 =?utf-8?B?M0ZzUnl6bGN4Z1BDdGpManpIaW5hYVJDeG51UXBMYU5sN3pYZFc5YTQxUGM4?=
 =?utf-8?B?REtzSnp6dUFXcGh2aUU2WU03eHpxK2tVRG1BdkdleWVoOHA4emJ6ckgwQWJQ?=
 =?utf-8?B?VC9xN05ZeDgrbUJoQlZlVE9jcEtZZDRqdklhQ0wyOUlVR1QzWW5XajkyekFF?=
 =?utf-8?B?SS9raVJlcjVXREV3Znp0bWVFWkpRMnhCbUIrbXo1SUlFTGFhWWtRQ0wzZFl0?=
 =?utf-8?B?QnRlRGhKeXVhOXJ6cFl2N2lVNm1Ndml2bmhDSUZzRjFJOC9XdTZ5VmtZdnha?=
 =?utf-8?B?TlFMVW1ZMHZzVzF5OThLRFNtRTNuSThSdkFtZnU2dzcwOEdNZTZFRG1WbkEr?=
 =?utf-8?B?TUFmeVpnSk9ZbS8zamIwM2IrVXpJSzc1Ly9XTnh5NlQ5NXNqNWU5ZEZaWFYz?=
 =?utf-8?B?RUMySm81WlBWUllyL3hBVkIrUW9SRmpUV2djcjZ2U1ZVQlRQZ1RMR1BIQU5h?=
 =?utf-8?B?V1dyVU54em9vdHBQWlpiK2ozZkZyaG5EVzR3bVgrYXhJQm50Y2xNNjhibGlq?=
 =?utf-8?B?UnBMSW1nK2lHZ0RBcmlQditRTkFBUVFWWlFqYkZXQ1RiMDlaeFJxUFgydE5t?=
 =?utf-8?B?eCtGbnpBS2dHbWNCQjArUTQwN3lVV24xMDJWaEgvbGNCQkxlUGt5TndGTWlT?=
 =?utf-8?B?MGNDbndwaEE5d1NUS0pvaFNKWXoxNkRWUUFlU2VBcThPelUwTkFSbDY5elNp?=
 =?utf-8?B?c2xHL2NCUDFCTC8vMmlxTTBGbTR3aFVrSERMN1dzVC9leTRzL2ZidGhSends?=
 =?utf-8?B?ekgwZWpiMjVSc2pBbnc0VFNTMnVWVG1ibXp4RmRiZmgwQmM3eE1MSUU2VDBV?=
 =?utf-8?B?RytXVkpPcklFc2VEYVdvazhpZ2JnWmJWZjNnaTNZNVFWY2h0UW8vdHRqK2xx?=
 =?utf-8?B?WVh4b1E3WG5XczdOTGhGSHZaTkxWcGw1WW5GTjdFQjRnRDU2Tk53bk1xZHhm?=
 =?utf-8?B?MW9rM216UFVjS1Q0ZlZBbzZzSUZFYTgwdnE2RGo2TEhzZWRNYm5icDVnMWZj?=
 =?utf-8?B?ZHNLVi95SkxCdTNSWnJPNXN4NjY0RWtyajRtSSs0NituMEZrd0U0bUcvc2Nz?=
 =?utf-8?B?TUVoTmgzYjRoeG1yWld0Uy9Na2Z3QXBXNS9RS1UxcWpDYUtyOTBVa3h2NVpY?=
 =?utf-8?Q?vWrB4KuqNVj1XCifIbJIXvu9n?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8925d2df-67b3-4bd0-ae22-08db5b8b2108
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 12:42:11.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDfn1bBEPRH1rtC56FV8fNjdIyx086rNi5lQTbtDWb/2O3Q0/j0tiLQF8oQF1FsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8560
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi!

I found a regression in DMA handling on one of our SAMA5D3 boards.

While combing through the regressing commit, a found two unrelated
strange things. The first is the actually problematic change. The
second is a number of suspect defines, that I fail to see how they
can ever do any good.

Cheers,
Peter

Peter Rosin (2):
  dmaengine: at_hdmac: Repair bitfield macros for peripheral ID handling
  dmaengine: at_hdmac: Remove unused field values that do not fit

 drivers/dma/at_hdmac.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

-- 
2.20.1

