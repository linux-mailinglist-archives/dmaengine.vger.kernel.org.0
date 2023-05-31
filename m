Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE55371771D
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjEaGsK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 02:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjEaGsJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 02:48:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C8A124;
        Tue, 30 May 2023 23:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYT0i0twe9tUlwot7jeabEqa5DczqLj+6ILZMdnJ8iXhI2eBu0D+Zo2Kef5LorjEF9OuX+nhWwjfJwiFk7GoyhHysbq8UtLPsjNa+4A1DS+3q5Ae0NUGm5LWgr0QyVqN7lP5nGVwPszyYv6ooyJ5OKJjP+tnZsrQ+033B86yQbftvfdSAMUI1yNV8OC6KOJpftGCfslq9PmYijl+8fM8DufeEg/mFaGfLvMTIIjd3dv2pjnamtyNMDs/guiyCk0TRFNs5jj+zZJlnDokxXVH68ncwX8iWS5W6cAdtDT21TfkX5xE/FcP4Hjrsxqwa224YliCiopsO7s9KBnw7A+i3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzD3TkQOCZzMawWaTzT4sxpEFuHFbYW7Iy9faSlUQgU=;
 b=cFmt2jlm+vkxcv2A06EZqoTZdjjHz97jD+15smSa2C5XwWtb4YwLO5QjQ3AWI0Jn4kPAxwa2hHMryPVxfwnqAzgqGSg34CEAQq2KRaYn2WksD8e/sDY5nntrKKpGYgBgWUo5wc/Zkf2klJn54XhbXxAuy19sMI6t8wPHnYNSRdmPVlnqCxcmlY8MW7uk8zPstf55KgYKXZW3JRg1iOVGc6MHGbMnKrDXz5VGwoTM73uJ2aUc9ybosdsPBYoXTeX4rqt021prQvna97o+4xivyPXm64q++nQB0JlyeO1y47QjCjrlWhKeljXwR8zgML5S+SLJzczgw3GVpgE1TIobJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzD3TkQOCZzMawWaTzT4sxpEFuHFbYW7Iy9faSlUQgU=;
 b=l0woCCMpRQuSGOodMRDGSKLH8r+inYfxxqj1OOebRzCdoglfC5clzRz333wVMDtUfF5kdgAVvTssFhTlawTTFzEWS6sbyyxNyRLIZhWSqQYPDV3CSPTw3vEO+dOxcXEhRodV4yekHS3Kl8CorlZ72QuH2tSXhRv8QCRuek7ivQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7791.eurprd04.prod.outlook.com (2603:10a6:102:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:48:04 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:48:04 +0000
Message-ID: <7c151c01-18f0-22df-58b3-75942b508035@oss.nxp.com>
Date:   Wed, 31 May 2023 14:47:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 03/12] dmaengine: fsl-edma: transition from bool fields
 to bitmask flags in drvdata
To:     Frank Li <Frank.Li@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
 <20230529200453.1423796-4-Frank.Li@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230529200453.1423796-4-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f16ddf8-a5b8-4d65-216c-08db61a2fbc8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUo5BOBjVfi5Mkl5QzumQA6/KXWlY4Uu0Ov8dKDgn/OQF2eQLh+sBRLqOcYKL0phBOfTOZbIgVo78oUr30oIfo+vwxxjxufPSh1fiTRZ0WPFtGNNCz3xP2D8/0EMST6X1mDK0IVjj6kIh89Shahli/Lr/1tr/3nMb5GhrXuz3xBQrtT93YbLIBM1hzN9xpg/feM4ppwyqmdgF7rljrfQUsCAeQwpbJAmSilMtRS2sQ0XJ9USLztYC33pQ7aKT1OKzEaHjMZYtK5vOKVT1049kN63ep+I3iEUtV7/AKwBFSnYv6kABTXGW2p4iWyO3M46NADj7zwk73wwD89cnYd+6B28/Ey/W6U0mYsOoeQHXch3u7MM84Lb3hnmFCyBhQf4u74aEKgmXGISS1b2B14GD7ZyNvqi3XacUcUvQ1x90avr0HbXSfNg7qwQoA2w7xExW8d5bcdCU4ccOExGfMrUKTyurxgS5nRKNGJBzrWDuLpV+rv7BT74U80jkGebSoUxNFwD6dcLuvQNhlmFY0cMaFpd/35pxaXi63sQaNHR7znyy08i7JBP/CjOw3doUFNPp8lA2ENUidY0AwOe9u3LExkMbSBcSHZaCjxdeVTxTc53R5CDV0D7UYi35utMfwZK3Ekidx03KplZE09r4TqmbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(31686004)(316002)(66476007)(66556008)(66946007)(478600001)(4326008)(86362001)(31696002)(186003)(6506007)(6512007)(53546011)(26005)(2616005)(41300700001)(44832011)(8936002)(8676002)(4744005)(2906002)(6666004)(6486002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3N3cmtEcHRYVG9MOXh1NTVuWUVPcnNmbkNibUkwdnEwdVlmMlZhaWhHbU85?=
 =?utf-8?B?dyt0Q0l6dGJyQVlIWGgrb3Jsczd4dFk2Q00rblJvb05naFVXakxIQ2VUVDdF?=
 =?utf-8?B?QktkV2Rud2pKVDhtWlFiUk5hMHNFQVM1eDhrdHpDZGorZWZDdU9NeE05U09p?=
 =?utf-8?B?UjFxUWdRMmUyVkoxaC9yTTRodktyWWJoUXZTd05Jb1ZNUDlQTkFVcC80WjNn?=
 =?utf-8?B?UzZhdXlEZTNhYjU1aURIWGIxREkxUGhaZmJxVTMvL0JzVC9yd3VXMkk4V3h5?=
 =?utf-8?B?VE1MNmczZzhEdGZ1TEh0Q1VoVGJwY0dUYjQ4SmhPVkJEOVJ5d2dkWE5MUnBO?=
 =?utf-8?B?d3pzK2l6VUtJOGhIVWl1WnBkd1ZOZjVxY2h4VzJVcUFoRURLMmwzWk1mQnB4?=
 =?utf-8?B?K1RaWk9uZ0FMNlUzRjRGek84Z3FNQWxZSUNoUFhyNmM2c2NBbFpuWk0zZGhs?=
 =?utf-8?B?TmNwRStaOHRsTFRmQmVQUmN5YngxZ2FaSVRZeWRiY1JSbVRjb2k5YkJRdlRF?=
 =?utf-8?B?Y1BmMzJqTm8wdzk5Ym4rczA4dFB3clVTMVJjZ0JDVUc2S3ZmTjlBODRjOTQw?=
 =?utf-8?B?VjNYOEUyV00zamtvdURnV1Y3YzNrVlJGSXBUYks3dlM2cmVkdHRCTEJ2QkR5?=
 =?utf-8?B?a2VmTGpWK21SdFpQTEFJRW5DdVF2R1RLZkczMEhjSTF0d212MERBbGxoQVBV?=
 =?utf-8?B?czYvVXp1QTUvakIrZFBOYkluaEM2Vzc1NHVXczZjT2szd0pHSlVTMmZPdTdn?=
 =?utf-8?B?TDczTWdhRVAyb1doN3N4cjdTVm9nV1kyN2I2RGt0UmtOUU9EQVZ6bEJQdXB5?=
 =?utf-8?B?dzdheitlVERqY2lzQkVjU0RhZ3oxNGRZdkpLbGtmYTJBcVFNaGEwYzVoQWVW?=
 =?utf-8?B?TXZURnhkTDZDM3pXRy9IbWFDMFJGbnNlM2kyZCtLbk5LQ1M5cW0wREdZRmpL?=
 =?utf-8?B?c0xZejlWb3dBYmNaYjJrNC9mOVVXQ1VGMzdYbFZhOVJBOG11bTc4ekhCMjg2?=
 =?utf-8?B?NDRjTkNpRjVwakhXeDM3eTF6MVk4OVo5S2czMUNENURxY0NiLzNOWXA4dFFM?=
 =?utf-8?B?ZkVkQkN0MzVsdG92RWZSd0c1ZGpGSlBxa0NTZy96RXZxTXJuVmNHVVZ4UlAr?=
 =?utf-8?B?cGNadVlqTkpnaVZCS3JKTmQwcTVweEFIdldZTVViWlJBSnd4MnJrWjh3TTNG?=
 =?utf-8?B?M2VrYXdXZUJ4YnJReXU3S1BZbUdNck1RUGRKT2l0RE1kak5CemtaYlpxcTRp?=
 =?utf-8?B?WkdOZ3podEU3T0FvNjNUUkJ4MzVmbG1tNTNCRnB0b0N6cVZySkZ6aVNZL2FM?=
 =?utf-8?B?a0xSdVRSWFgvTlpQeHQ5VEZhV3lTWWwwZHBkWnpTYVUxZXRlSlEyU3licVRy?=
 =?utf-8?B?dnEya29Xa3pZY1ZUSFRJaUE4eWQvZHFINzdTelhPS0JjNlJHMm9ha1NiTlEx?=
 =?utf-8?B?OWtMVFN4VHZNL3YwNlNnMXkzamU4MzU2bVorZlNvWVZqQ2tmaFU4azJ6OXlm?=
 =?utf-8?B?cFRsYm1vNENFZ1puanJ6ZkZwZTRweE0yaTFYbkVtVFc5MGFIK2NaNEhLbVhJ?=
 =?utf-8?B?aVg3Rmcwa2hETndSWjJYak92aVF1eW5rcEMzMVhQY21mMUhkVHpocW8zSUlp?=
 =?utf-8?B?Z1pveU1SUDNtaGZOZHMrKzNuMGV2NnpzbU1wQ0drNkhhOHVIVFl3ZjNGdzE4?=
 =?utf-8?B?azExM1EzdFJsdlpMd1ZhSWJWYzFKRVpmcStNU1V5MDFadm1xQ2pKbkNFcVVU?=
 =?utf-8?B?ZG55cVIwemd3Sm9NSXJXdC9xaEg1R0d4blRSNFBiK3dxOS9GV3RLSDYxL2NY?=
 =?utf-8?B?Zmo1VU1JUWtJUVdnekFWMGpGdk5qSVlPTGhxNkRCMXBISmVza2Rkbm5hdk9z?=
 =?utf-8?B?M1lQZm9OZnBXS1F0dXc5citDOEw3eVh0Qjh1c3JnNEVNYjdaMWNKakQ1b2xW?=
 =?utf-8?B?dmNKV3JGOCtic1FaWnFuaXFKVnBlUWxtd1VKQnAyc1lkT2U0ZlE5YzhSbk1r?=
 =?utf-8?B?czZsZVNxVVRlOSs4d2xwTm1IT3YvblJFSTN0eW9NZ25nNGRDKzJPb0JUV1g2?=
 =?utf-8?B?aTR3WnZUZnJwSUIrZTl5RXE4RnlBaTdzTnY5MmZRZnoxdFBZU1lKL2ViK1dp?=
 =?utf-8?Q?OB6td7nDY0/gaxNC7GaZq7/qA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f16ddf8-a5b8-4d65-216c-08db61a2fbc8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:48:04.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYlhCPHj/Y10AtqWvM0X1T8R0KcZqwN4IU/DBlIk/N7LqA57N5IahipL3AhjesNaAgeOR8Eiua33LpPqVxx2SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7791
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/30/2023 4:04 AM, Frank Li wrote:
> Replace individual bool fields with bitmask flags within drvdata. This
> will facilitate future extensions, making it easier to add more flags to
> accommodate new versions of the edma IP.
> 
> Signed-off-by: Frank Li<Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
