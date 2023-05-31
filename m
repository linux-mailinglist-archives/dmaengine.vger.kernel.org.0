Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8753E717727
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 08:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjEaGvO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 02:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEaGvM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 02:51:12 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E199;
        Tue, 30 May 2023 23:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGiQ3rpN53vfpWZcqKwKxJkCFR3TKZg8fndOgtDbBEb6bC0uruhwx69oiPf01DmwuJrvbsHOb4ZL2G7uP0hhspV2jzC7iGibs3RFH1iR/o+YBOjFsU9KrGxHjZW4oa5/H6lqyjWfNMRUH93nzCyex2fQGruscG0njtFs3qObXPBgGr9nSzGL3xEkRA+4UTC3c8kf7O8dnbwp/wvbzmdESGMfLRiZBVSbtnk3DxL8SFuP1gUCcNc1tCqYFtc6zQ9ebKhSVNVl8Llpe+TrbS2QYs3IbCeARuUqZ/5vXlabVEkSA4huAeG4BWaHsfnuvCGKWHdNTyiH/cXh7EM4kcmdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnZpb01eB2SkRAEMXkkGFcPLW5hpjsnFJ2mNkmBHL/M=;
 b=TZvW4+H+YarVao4sKwJ7mTIlXQwsftQk5Uyel5Z/enVOIqwhelrdWfCZyqCxtEuLo8/RFvSFHMMJznHLWVl1mn+6j/t4PxQ1ucccO7tw19RryIJ3Un+hxysMn5CuvIXMLpS+gfQqrT5zwFLtBQgNgK87xmtAEqrQOc2W39NkRSrJNJQojcV+764BUL4BvO6CY+JB36Xku2l4ossdBpUWCiur3i6Nj0cSYeEMSiJ/f8sS1XDxOLbAyhrC4cx2QNSZ8djCLhB6IfNymX2yopDoDDmiOVPMGlvxMA/VLpaJsUgU6BRGWfxtdb4a2BgcCFxZF/ui/g4LDDuTpraZYwiTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnZpb01eB2SkRAEMXkkGFcPLW5hpjsnFJ2mNkmBHL/M=;
 b=B5zsVDkFwLbTGahw1C4bP1QdQ0zP8ySwonyJIhZvZ40qDdEG3I3gcQmRq0Y2tNneDrO+YOH7+Hikau2173BnA8tGhzvKmUUunv/YLsFuv0afYjTmJYEEI3RsQ8x8HAX/JxFUBePCUM5BL5qKY8WOBpgDf8+OxvNW1Ap1ICIX61E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AS8PR04MB8562.eurprd04.prod.outlook.com (2603:10a6:20b:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:51:08 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:51:08 +0000
Message-ID: <79803451-3af0-26b5-2407-ec47172dcecc@oss.nxp.com>
Date:   Wed, 31 May 2023 14:50:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 04/12] dmaengine: fsl-edma: remove v3 from enum
 edma_version
To:     Frank Li <Frank.Li@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
 <20230529200453.1423796-5-Frank.Li@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230529200453.1423796-5-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AS8PR04MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 74622537-b2b8-4324-9664-08db61a369a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+uA+hrI+D+1znDWWX4RSk3eAKfnYiyYBIjvukWet8ega2BjaTsbPy5oPMrHUUL79zRBSUZgZ+3O5cTuuL05rqAXG4h4AVxAzdpQu6IzvLQqbwMIk2c4225r7SerYzTtn3q0iuKXPWXVMhzdf9R+SrECTSMQn78wnHLOSqd+xa82G0fMk/2UUCXYEQTVh8ZyPTVyGhnsjx6DMFsErtzD9otIH4DGyXagZBXvO49hKutiMdgDICHcsdNmcGXmoJ+uoGm/e3J0CeKVQvfiU4RnKYEc2Yvkdp4Sox20a9B2Hi03sEsKs9k+cKjPEQg3Py2QOXCrEOtPVr4qDvzAIbTumcnUMl3YfmOy2hqDiCRu+OJLjAsbKnpnVPSfzL8/ljmwOvq2oZgFZhPSK/bvTOULqLlcrBTrwccCjybdDPLXC69Hw5D0Dbxv+Z8+0rO5XsdicVEpy5APQ3Upig3WLs0xyScLhiloIhbI3eL+Lu6KVUgDCUtODpvBiShwx+sffGq1q7TPTc1y633R/5uRfWUO3aCqTOXGA1tNuuRSxElr5uDaneox9TtZ25wdtSN9uFwqPVyY2o+Az32unt2wx13wxphlERGToOM90jRf+KE5sCEl1wCXltYfjFN47b2x9pEAGQdgCmlf6pOEeSRmRcVTjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(186003)(6512007)(6506007)(53546011)(2906002)(2616005)(316002)(4326008)(66556008)(66476007)(66946007)(41300700001)(6486002)(558084003)(6666004)(31686004)(478600001)(38100700002)(44832011)(31696002)(26005)(8676002)(8936002)(5660300002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUx3cVpCUFFObENXTS9NdjcrKzlBNVJVVFU4bjgrdHBwZmMyQVVMZ0lGU3ZR?=
 =?utf-8?B?ZCtkSXNrNTQ0Y0hFbUJyV3U1S0krSENud1k5Rmk0enNiNjh5ck9NT3p1d0gr?=
 =?utf-8?B?SVgwckZsNUdtK0dmWFVaQjVwNUFZNkRCQSt4ZEVQVGJvaVBvT3FrMnA3bDh5?=
 =?utf-8?B?V0JCVHA2bnlYQkNGK2llV1lnLzRRZlcvQUEraU9nZWRibXhjM1VDZmFNRjNh?=
 =?utf-8?B?Ui82M0FQRDZCUXFST1ZsRjJhQ3VhaGpiT1BTRWRaSmdhcWo2Q2gyVVBxTCsr?=
 =?utf-8?B?ZHluSUlJZ2tTZ1lySjJDQnMyZFJWVms1akJzZVZVSXhabmZQT1I4alRsZnhz?=
 =?utf-8?B?VjJHNHFoMFlFVm9KMlg4SVM1ZGdpb2NHNG5NdXJHVG45TzhSU3U4TFlHWUtE?=
 =?utf-8?B?LzByOHNUWmZqcDRLZTRKcVI0dXNZNTZocVJZbTYrSmo4M2VHTjR3eHlrZjNa?=
 =?utf-8?B?TmN1c3h3TmZ2eFAwYXZ1L1JNVjJpRGVPU0YvV3FvVkgwSWFma3Fyb21BQjNy?=
 =?utf-8?B?QWxVcTZ1SVlGOE1xQkdCUlFJTGxzMG5oSDdsZWVWczVoM1ZwQmVZZnZjWTVU?=
 =?utf-8?B?SUNmakFiRG9IazQyOHRzR2dTR2g2M3A0bXpQR3NGSGlSR3dCUWhYdldDbnhH?=
 =?utf-8?B?cXBHT2g0VGpqVDFCZThkTlQwSy9TRzZ2RlNZMWkwdThnZXhmeDZoVmltMHpn?=
 =?utf-8?B?SU5zTVdZM0xiTGZqdlYrMkxkV09vRC9lN011OGlBNGlwQ1JPY05qQkZ3eTh3?=
 =?utf-8?B?cmRUaXltSDhCWEFRdlNTVUFCQ214bnExcHNadXBEVFN1cFpFTUtJc2VrSEph?=
 =?utf-8?B?VktFcEtPQWo5eG9HbjJ5eUI5TGc1ZUFubEQ0S2lyWU1sZEN1R0RmY2lQbitV?=
 =?utf-8?B?Y0JhT0JvNEFlRTU1dFMzWHRyUnVqSkZFL3lhYitYZkpQMS9rV1hDeE9IR1dZ?=
 =?utf-8?B?ZTZ6OElIUzJ2TmFlak5jOGI1WGNCWGFjY1dSL3dQcWxabGFPcVJKS1EvWGJa?=
 =?utf-8?B?aEYxTm1SS29BTW4ycjllci85UkhIeDJqSEdoelcyVENWTDI4MkJRWFdmSlRl?=
 =?utf-8?B?NlFaNUtFTTRROGJCdjUxSTJmWkVJSE1OanZrMHZNTHIrOWxoUVdEZXlDWEdk?=
 =?utf-8?B?WFRGdWQ5QmRxNW1JL1dQTnBjaWlBRWpnRVBwRkFFdFFac2tsMmtGNUJNZFdJ?=
 =?utf-8?B?NEgzWTJoSzNkSkZFbURENEFOM05WTFNpRTcvdXQwVExQQTk2TExvZTdMSDVl?=
 =?utf-8?B?cEhESGhQSTVSaUxpNUZZOFdCUnRrT0o5ZzFIZTdIUTFLdGZWaWNHWXgyTmo0?=
 =?utf-8?B?TUUyTUNqSjBEQVJNRFNteFJscFJCYXZSRy8vazNDa3FscWpWQjRWZEo0U1Jm?=
 =?utf-8?B?M0x2TENBa1lmZUsvRzNDeDdnZmhFajlnZnZuUWlFZzQ0NXpIemZlWVRvendN?=
 =?utf-8?B?dHcyYlQ4dmN5Rkx2UEpXaGV4TXlRNzZSL0QzQmJXTVdYNlJhdzBJWXRDcUFt?=
 =?utf-8?B?NXVCSWJiUzFlZVVDUEJvM1U2MDE3ZDRULzBseHVwUzJPeGZwMkpKb0s0SzE3?=
 =?utf-8?B?RDVRR3BubktnbTNTdE00Vi9vTHBZWCtNK1VXZ2JMa1JPc3RES1dJUkVCOXYr?=
 =?utf-8?B?a01tNkM2bVJSSU1zdW1Ma1FIN2JWOEZaa2xoRkJSU1VrL2pxZDViY2RuYll1?=
 =?utf-8?B?U2VBK3p0TjNJSGRqblhxb0NQK2RmNWJrS2gwcHlySmRJd1JqZU8vZFR3dEFI?=
 =?utf-8?B?TXZ5c0hsWThOTWs1R3ZJbDFXVnNtY1pGakdnTnM5eEhBTGp5YlpxY3RXY1hj?=
 =?utf-8?B?UUM2d1dZZ2RzejJCUThFWVc3MjhtMittVjYvVWJaYkIzbUJXS2VqQmZobW9h?=
 =?utf-8?B?VFJLL2hEVEU5YWMxdTY1cmphRExmclRyT2l1YWZLeGVqY0dNNytUcWhtaG1Q?=
 =?utf-8?B?K3NTZFczTjN1NjdKNEs5cWI4Y2VLWlZYbVRJYzd2Y0VPOXJTRDJlQVpJeEsr?=
 =?utf-8?B?a3NPbDg1NStSZTZ6TFlENkJ1SU1pZWtVYWFxbFNxekV0Q2krelc5c0FoRTY2?=
 =?utf-8?B?dEljK3NNeXl4UUtWYytXR0F5dktyeWQzTG1JZUFhaUJxMEMwTWtLYnRNTWk0?=
 =?utf-8?Q?/L4u1UNdiJoOM2hXB01/Jum8b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74622537-b2b8-4324-9664-08db61a369a3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:51:08.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yj7BrpBsnu5fP8ewgqua+EUmiXevUCQU0Ev9F3l+RQ3NPdZ2R7YuOwqFIVNcTQ4vo51RFsoGcT15bIpNmG00ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8562
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/30/2023 4:04 AM, Frank Li wrote:
>   static struct fsl_edma_drvdata imx7ulp_data = {
> -       .version = v3,
> +       .version = v1,

This may confuse people.How about for hardware
version >= v3, use new flag as yours?

Regards,
Peng.
