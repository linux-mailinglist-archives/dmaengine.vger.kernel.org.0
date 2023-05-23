Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177F870E395
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbjEWRUZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbjEWRUH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 13:20:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2099.outbound.protection.outlook.com [40.107.22.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E9E6;
        Tue, 23 May 2023 10:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdGpohLVXxGeNmgh+OX2GWf7ye3CFNX+EtxW1tw4wcR1uKEecJ8a5xdsupXkiL67h+6ZhPb97dfYX2Bb394CykwjC1/XRPZzcAF8sCKMH9uprEdJ+lprOH9kqKFXwg0gvart6iVcm6gfw4vUyCgK52r2O6OcbXjJ5zq3iKnwhmFZphU7aYSbZ+5WypTvzh9QrP/ijfiWvVIQeEO41EBpU3idLaVxLPSd7vLibs6pALj+U1dIvqApHHFbov9UcZYf9NG7TLB9BHHteW+ekmD9aSeuKKMb8grZ8r8MX9HeMef3KXh4PL7LR2vITiAEKQAKUTpM0y5cpFO8bEyF68E3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrDyClST2Z6WcJ2Z4d9cXRz3h8gVFkK2c5hLwxNXXPA=;
 b=BVrOZuAhbiqaPHzYfGPuoXcxfjO201t/yyqfnnX+3vk/oh13rMZlfwd/jPCk+29R5iEj/Q+gmV/zSu3dtW6cZDYcQ3t8l7fDxU0YYqsO3W0Y8uvWSWSzW9U7ShgJ8bB+C0RY9WI6oss6uSUrBiAAvu/HtzgIj2VrRIpHHpn5LyqK5c+XaR1dqZI7abkVSeUO9I5h/Yj8ClJ1W33CXoKHcCnaI0zN2OtpSzpaQ+7Zbv/hLIS+BjdEIOA97AAWnYjlNBEKYLvYoXym1rs+EpCnhmDs29WcP95mmi8UlgFsnIHSnEKW3TTB1Ym/7lioCj+NUO29Oo11EYQmCUFKNJO4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrDyClST2Z6WcJ2Z4d9cXRz3h8gVFkK2c5hLwxNXXPA=;
 b=YXxL3Rt0mbbOl2/tYFoJI9KnlR/AbBewlDuy88B4nwWm+8Mqbfwq1GdEZWUIruW4+MBdg/Mi+Cay1ZoAZvbDdCbhvkreSfP/0AiCbh0SOmqiPVxED7QMCFtm243KpZncBAaRfFS+qE834olLeDTy+i0p4GXEC5FJMniNNpd3feY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAVPR02MB9205.eurprd02.prod.outlook.com (2603:10a6:102:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 17:20:02 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 17:20:01 +0000
Message-ID: <221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se>
Date:   Tue, 23 May 2023 19:19:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 0/2] dmaengine: at_hdmac: Regression fix and cleanup
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAVPR02MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 55af58ac-8f68-4da1-67f3-08db5bb1f127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2+ICWCxGSaiA6aLdRSqybVi8bwWsA8HunGn506Shva76PD0Ijm9q+vobB1sXQbmnwK2aBetD/AmO88iysVsSl90bN2wO5+/ewqFDXkndpBo+zhNmFoFzbb3l3woClrQXjku2uIUTaS1rOcJnAN+74DTjZG2gcJBs54nw7ifCE6pxHItd76P0ATzORMPpG4ThlxDPgLuvlwYdkG2mjLhoH/3qfkMHeasGhhAPCrY5IuW1hO9XuMTzqxoeig4/YsGwP12ASGwcrM9DY18EakpHd8L5/BX4VZS4zr62oJQ3uFDAkPTJkaWr/iqVWwjKdCJmbG3NR4dEdUuYuT4W7wskrFR0uShs4zdFdxIiJqK8F5S3kzVSY3qWcZq4ERfnvaOpqQKYQ36l9Wu9IJbkKjCe5hDjNXpAp64S5XNxPJz//RqWs28QP2i/zQVJUE2TPZ1c6BbaFN5tO+LlBBCrFd4eg4xLMqwW5Vaooa0OfIRWif3J5zN5DzwgBi8qkputmOZagyshthuDd4eXr/1dvD/g6Uff61tnbPQUnPNqVJ2R+/DLj8BmH+dg9WpItx7F3lsBQbvlD6wLFa/Uh0+Q2JrSvBMh7TrPGX6nr2lljF9qFX0+U+8mTusuFI423e15Czd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39840400004)(376002)(396003)(136003)(366004)(451199021)(8936002)(8676002)(5660300002)(186003)(83380400001)(26005)(6506007)(6512007)(86362001)(31696002)(2616005)(38100700002)(41300700001)(6486002)(966005)(66476007)(66556008)(66946007)(6916009)(4326008)(36756003)(478600001)(316002)(54906003)(2906002)(4744005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUVCb3NKV242aklPS1RRSGdkNkRoR1hGNUpYN3d6ejFKRnc4bzZkd0NxM0Ey?=
 =?utf-8?B?dm1tQk93TVlqb3VLRWk4ZGtyRWlzdVh3TDRVV0VNcVpBNVBWdk5tRVU2RERG?=
 =?utf-8?B?UmdXZUw2b2ZIdUlEV0hoTDhiSHk3eGdlbUVBOTdBNjU5eXY1aGp4YWROdmtF?=
 =?utf-8?B?OGxHMEpaNW9uajEvUDdZVTlabDdmbWR4dlQwVUh3WlpLVUFMYzNHSzlXaUZq?=
 =?utf-8?B?bDZMYURIVGhkNTNvdmZTZXZRcnVFZmZTcWYvTWhzWUk1WDd6cXcwd1gwZ09E?=
 =?utf-8?B?TWFoWjFjYjFWMnIzcjg0Q1E2Y2tlMjUrZjJVUGdqbzRDbWxGV0RQd2RnV3Fa?=
 =?utf-8?B?R3cyRi9scHhBUU4xMzgvUUtSWmVBaDFKOFduRVVId1VwaTd5T2U2OGdIU1Z0?=
 =?utf-8?B?ZnhzVEErL3BhdXRxRDg5M1g0R2lJd21kV1JwQUxDekl6dFRuT0x1eG5Ra1l0?=
 =?utf-8?B?OVVJQU1XT3pobEhjc1JiRGJZRmF2bFRqZ1grRzRzVGFEVkt4OGNHTE52c2Ji?=
 =?utf-8?B?Sng0clk2NUxMOHQwaWZ1NFdZYkxab0hlTTd1Y3kyazRvSDBxNjUrMysvQzhW?=
 =?utf-8?B?V1BWdzI5dFpQSDRiczRDRDhoT1BRRStWTzVoc1k2VkN4UHFUZnV4UUFCeE9D?=
 =?utf-8?B?cUFTZWJJQWZaRGVVTXBmZ2MwMHhXYVhzQTFBdndoSnd5OGRnOXZlVVoxN05V?=
 =?utf-8?B?VHY1MW12ZzczNWVyajdGdTBEaVhaVXVBd0lKMmREMjE2TlBqOVoxcUI1YlR5?=
 =?utf-8?B?eEdtcUZpcHI1Z0NsRG93c2s1Y0FhWFphdmlVdjNQVTBtcVcvaGhBZWF1V1dJ?=
 =?utf-8?B?RmVnbGpvcWZvM1ZNY3hMTE5ZVE5VV2hhTnN5dGpqcjhuTy95OXVVZ2plVmVP?=
 =?utf-8?B?M1E4L0I2YUJEbnpSL2Q0QlNSa2lZMHRzSFJ0THU4WXVRLzQrbW8zVnJzOXN1?=
 =?utf-8?B?WVhJNkZOV3BSSGVrUnpkeWZ0WVFjbEtLc21WMHRibmNPUnFjNmlDMVkvTEdH?=
 =?utf-8?B?VnlTL1M0WVZBZnFFa0E0aGdmaDVWNWg1UWNEV0FNMzlWa0lVVDZLN3QybWpx?=
 =?utf-8?B?Z1JiUjVjTGlYYWpsY1RwS0gvVEtHK1NETXUyVTdkR1NVWjVEM1pqZXZYZUJS?=
 =?utf-8?B?ZzlnZEIreS9XaWM2dlhoTzZDTE9mNDc1R3JyaHhvYVlTMDUveTRxQTFpdmN2?=
 =?utf-8?B?WGQ0UXJRMFpzdmFpYWVaRUlyaG4yNXc1S283SHV6MGFQYUhRRFA3UjFOem9M?=
 =?utf-8?B?aWtsczdha0MwaG1rQmxKRXc4TE56bUJocENMMWZRZHVqWEdWWUVpeWFSY1k1?=
 =?utf-8?B?dzdnV2gwV2V3SEp6YVgrZnBBd1hURlduOEszTXhjTTBZL2ZPY1pFeW5zK0tR?=
 =?utf-8?B?ZExWQ002NVcwbkttU0dCTVg5ZytnNlpLMmJ2Rmk5Y0Jud3VyS0Zaa2d3SC9Q?=
 =?utf-8?B?NGdmWGpQaW1TcHd4Nk4zOE5jODd6Q1UrUnY1Uk9ibHArbTFKTUJwZnhYUVFy?=
 =?utf-8?B?TUg0OWRzeHNEK29NaWZ3SzlqclN4eXRKWCtDdVkwSjhTV3pTMG42OFkzWHlC?=
 =?utf-8?B?RVhWckgzZGt2d0VoREk5SEM1UFNrcDJvcngxdHJjckRCOVYwcEhqbEpiZjNO?=
 =?utf-8?B?YStOUXZpM1lGRmszWk05QWdVR0JuZ2JTa3lGYXNHd0dscW45blBoejhkTCt5?=
 =?utf-8?B?bWZpbHo2S1ZGWmJwdHlaWHdpNXczUVhPU01mSEt4MDh2RWhGZElDL0o2M0ow?=
 =?utf-8?B?SENWc21CR0dVdTdqOWk2MmdhaVF1S2N5eHJjUUpMWU5sek5Wb0xtcENwTDFa?=
 =?utf-8?B?d1J6WmRkM0pyZXhRVDFCb1I2TkwwUFZwWGQ4c044N2l0OWN1d2VrL24vdzZh?=
 =?utf-8?B?ZGFKcHp3NGVLdm5hY0t1V0thRXhoZlk2UTAxTmQ4SGd6ODFQWURSTGw5S2oy?=
 =?utf-8?B?ZXJXMFJuZDQ3SnoveHlTNWZWL2ZudFQ5THNyY0tNRXFrM0JZa3FXeUs2Q3Rx?=
 =?utf-8?B?WkxmOUI3QXpzaFY1RkpEUU0xNmNTQ1NFMDlSWHo3RDhSY0Y4azdCeTM0UXlk?=
 =?utf-8?B?dE8xZG8zVjRlS0xxcGpNWkJ6UkM3OWxsUFBrakdVYzI4Uk1EUnVpQldkZFBo?=
 =?utf-8?Q?qVHWdiGDbXMji2PUJftRTlaFg?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af58ac-8f68-4da1-67f3-08db5bb1f127
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:20:01.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzC1Wqg325Tn2Mrlo3FY3b9N4FT41zufJemk7VWioZgPFvbm8/R3TaDlAZV+OEfa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9205
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

Changes since v1 [1], after comments from Tudor Ambarus:

Patch 1/2:
- Don't convert to inline functions.
- Cc stable

Patch 2/2:
- Extend the field instead of killing "too big" field values.
- Add Fixes and R-b tags.
- Cc stable

[1] https://lore.kernel.org/lkml/dc4834cb-fadf-17a5-fbc7-cf500db88f20@axentia.se/


Peter Rosin (2):
  dmaengine: at_hdmac: Repair bitfield macros for peripheral ID handling
  dmaengine: at_hdmac: Extend the Flow Controller bitfield to three bits

 drivers/dma/at_hdmac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.20.1

