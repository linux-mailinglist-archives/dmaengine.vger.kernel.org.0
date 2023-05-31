Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED54171771A
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjEaGrW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 02:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjEaGrV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 02:47:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46308183;
        Tue, 30 May 2023 23:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StJClorVXtC5qmlsr9V33o9m7EhRFKT6v2nuf2j/tzWZcM1r2rGKagRBEKxTHtISmx97oCPMBo9y1+nG9xiPg2rin46jTw1T5Jk3N+zBwyshLQoKQMCr6w/lBb6yD+FaTiZdySk50zq8Y45CGedZ37+GNZ1XJW4CY/UqKsK9Z9jDUtEaoQZr6EVD9gWqTAoezQ+Ly9XTZkMJ2G4D1xvZqQ+Rxn7BROo5TarV6YpZj1Pa1PKepL2+I9+c/30lopGgynhnz1mnPFkVaNWseI+/m4ueUcZNcsUlcge+1nvpUVyJLFZXhHbLfpa1YGw3Zmc/CJUXbobt+vNlvT5zqBxX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx16tH3pLZ1LtBQrOd1PVzMIQZ8NlfFCDzj9lF8vyKw=;
 b=RYFNfUvO0Bgjndp87cCx9IwBsw2NClr9SGwzSGuPEvs/j8uZxBl26XQb1xszipJ+t4FKmIU3MpTqSB6MD1eiRlr46G+ZybWwnvub+PS2yLeClTTzh22o1T99X8VUF4m2zZKW51nuGL8FQV2gSxu+HYE/SecSzAuxwi0YLGFVGGODYtwAfRpAbWSlg8x3wL0hPvqQym4nxgVZGamWwvkGjdXQltM2dl27OEttzhnnG/5vOLL8WsUDeBG34WUNtdhtpLQR6XvBNExCN40XttwXNkaaP/uqejM7/MyZPL2emf9d43x3bIR7r8A353iRrh7Xakuyx4PllHFRjuXDkGNIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx16tH3pLZ1LtBQrOd1PVzMIQZ8NlfFCDzj9lF8vyKw=;
 b=YRBIKaxvRMvM9hQuSAqutPAeBaA1No2rz3TlnWE07BQM2QqN2bUbglulffHoTEbZhnmyb73NeC4gnKPVGjaJeUEGC61pTGFMnScmmJE1NeQqaH4cwL4k0SGRqRhZ3GuvBvMxjofEI1ftt6k2KjKHPlTSKcWU92t96ckuW/4PgE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7791.eurprd04.prod.outlook.com (2603:10a6:102:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:47:07 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:47:07 +0000
Message-ID: <e8a30c9f-8b82-a7af-7043-44d55c628d23@oss.nxp.com>
Date:   Wed, 31 May 2023 14:46:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 02/12] dmaengine: fsl-edma: clean up
 fsl_edma_irq_exit()
To:     Frank Li <Frank.Li@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
 <20230529200453.1423796-3-Frank.Li@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230529200453.1423796-3-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: c100dada-b478-484a-e628-08db61a2d9e0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTI2DsE3vGvoAj1FsTxlMpZ4lP6x7adBohiDi5936PquOzSZWu3YsOR70nMfPPXGLKk0+BIW5etMB8/qwTbsvxWep5P2X7YkxgHtw07JkqLBpwrApHiKPNh8f56h53NTMVibH8F+L4WSnSKfvdU+0qjzHqwDMzqZ6NtCX6F3Ptjeu7ifdBQh1Cj+7njTWVadiqB1FfShWu0DeVyEhIL3aJtEgn2hPO2H20fvH/3oKw9Uhuj+/eieC8UNfM7JnLNW6y6qipIJB8mDuG4GnBfS7DFlbEn9pGVDQq3vrB1/xtyRmpCJ+gNzY0MmaTl6LYp7JmbahASxpfXlCyZD+yM2kF89wT/44S/G17o9mcyuooiIZH5lQe6HMyXU5tJPLghrS5ng4njNkR5n3mthsPGwiyqqZEur8kNabSadvS1LFtz4OG/wHXCHBwFwxjI7zM0abdmux9hzjVZCRewgLEYJplG2JSTkIGRJwyId2/KDIogNpIO1hK0d9omb4zNrMwDrZ0VNvWhb2Q+Xy6pRq1s/ETfV7UPCQ5EFUCZNE47oba62T2xKxGgdj1U3jgdoLbuDByALlZgkoQyX8jO9Y4aOIqWVyrBUbiTdC+8aaMkyTks7gCmf5II8sS//EetECdResGF18DpT6K2EVL1HcoPKjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(31686004)(316002)(66476007)(66556008)(66946007)(478600001)(4326008)(86362001)(31696002)(558084003)(186003)(6506007)(6512007)(53546011)(26005)(2616005)(41300700001)(44832011)(8936002)(8676002)(2906002)(83380400001)(6666004)(6486002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUNQV1lhc3EyaWR6c2xDWmZQM1VQNFNjOC8vTjd2cXpITXdoMHczSmprd25M?=
 =?utf-8?B?b0ZMaEJnT0tua2J1cUFRZHlZQkY3Ukp2RDFyazZzWEhNZUVQZUI2OFUrTWNB?=
 =?utf-8?B?MmhDZ2ZXZkx2VVROZWZnRzFsM1ExUTVMZVpwKzRTQzRmVTQyeVg1VFE2Zllu?=
 =?utf-8?B?K1dNa1RNY0hMdmo1WUhXL2pObzQ1RlI2elhOQUF4bzgwbEl0YWxqQXZCUHJ6?=
 =?utf-8?B?dWFWTFlNNmRlTGNkc2g3dk9NVzQ0UHI2MWV6d0Y4b1oxdkgzc0dhQXJHSG5a?=
 =?utf-8?B?d1l0SVd6dHVmOU91VTd1U0JpYjN1K01BSE1xS1FCZERiWTRlMC9zWGFReFM0?=
 =?utf-8?B?L2t5NzVHZjVRSkdxOG9WU2Z0NE1uODdySXFaZVNTNE9WQnlGQmp1dnB0dFo1?=
 =?utf-8?B?cTArRjl5VGpQTnJJU09uM3dSZmdxNXdlM2RIMkFUaGJaTm0xbEY5a3VoanZO?=
 =?utf-8?B?c2tzYzNPM1A5RUpzZ09LK1ZQMkk3L3ZzSVQ5ZGMxTm1hY2dGbkRIYVR4RW9z?=
 =?utf-8?B?aWIrYUk5azBteDIxc2oxSmJya21aRFFhOExQR25SODdDOEsxeXhOOHZJUU9W?=
 =?utf-8?B?SWxEbWhlWXZ5WTcvbmoxZmVqY1hIdWRQYWdWSjdBbDFGSnpoMDdXcGw0MTl3?=
 =?utf-8?B?QkVoYU5WQ1VUMGFVVXBlKzZORnFETExCRlNNQ04rMklpWUYyYWU4VG9zQWxa?=
 =?utf-8?B?ZXRiZndpNmp1NGg2Wkt6U0MwL2N3S3ZFaEpxNHZpWFl3eVpaUU83dTFPS2U2?=
 =?utf-8?B?Y01JSU1YRW1XdUhPcWY2K2YwNnE2Rk1YbDhqaitWdVhUL3MrcmZ0dzE5SHZL?=
 =?utf-8?B?cnBQejJtL3E0SzAvTXJDNnY1ZE15QXU3WUl2SnNrSUI5RHVFVnJ3WnJDc2JK?=
 =?utf-8?B?Zi9ITXlKWmt0STMxeU02cWpLNTVDdm9BQ1BweW8yejVxeXFsNXVQNkhaclFk?=
 =?utf-8?B?Vml3d3lqNWptcXVxN1BtL0FqeGd1blJjZHdRNFFPSldBNkFLQmlreTJwZGl6?=
 =?utf-8?B?WS9xVzRoUHZSYmRBUXVuVnFLVjdrRm1qaGtCL1JvQ0EzaXV2N1BhaEtUOUdq?=
 =?utf-8?B?c3VycUdHRk1MNDlGdmc5OFpTbHJKNmFNZmZMOUpEcmRWQ1E4ejdVb1hMdVRU?=
 =?utf-8?B?OExKV3Y0SjN1SzF1QkZMc0d0WEUzcVR6bFFkMk1ySmhiaktSNzJaaXN0QTIx?=
 =?utf-8?B?b3VrZFlvRWZBbkw1c21BTmZlYytONDhVWXhxVnIvNkdyL0NlWHduRHRyaUFk?=
 =?utf-8?B?SkQ0bHhkTWtmMllaVnd6VVZqY3BqN1FDWDRBV3pER0FYd0dkRGxGSWs0R2g3?=
 =?utf-8?B?UkMrWkZMYTVycHBQWHBuM0lac0l4TC95OHg2d0hRWUI0NWFuTGkramsveHZy?=
 =?utf-8?B?Mk5qNVBLY2FwOFV1ZnBuc2dYMGk0R04rZ3h0MUpXSmRFV0k4UmY5MTdZREFL?=
 =?utf-8?B?Z0Q5ZGNFNmZndzhscmtIZzFHN2pqS2FhdUY5S0NwTCs0b1I1M1JXR3BYeXFS?=
 =?utf-8?B?R2hnUEY2UGNpT0k1OGhBbWdQRDg5aHV1d09XczBUa1RsdmFSQjAybUR4K0Y0?=
 =?utf-8?B?UkV1NWNVNjNHQVBtMnBDczY5V0JzcUxTaE1mZUMwaVlRQUo0TUlxaUVPdEE5?=
 =?utf-8?B?NHo3czZQRXc3TG5aZE1vZmRLSXBUNmVSOGFseXdtWG8rMmg3dUlEQ3p5T1lh?=
 =?utf-8?B?WmZWMW9oaG9vTUVUeHZYcHlkdmZMcHFxTG9BSElnODdzWDh4ZTRCMjVRL0pq?=
 =?utf-8?B?Sk9sT3dvVm1XYjZXOW5CZncraHJwcVo0SXhzWnhuZlB5QTFjWVZDNHNNTlBU?=
 =?utf-8?B?SnZhNFVXdEdtTjFSelVhNXRYSllsd0NSMGh2ak9neXN1VElOallPaVJYM3VF?=
 =?utf-8?B?NUJmeElYWktpdEhRRWZ2MkVsSHZIMmZ0clFqS2ptZzJselowaThYbTdqS3lJ?=
 =?utf-8?B?WDhKYnRQczcxMGV3QjhJSW9xWnlKRVdBWTQrWFR5ckFGblJjN1NxNkJ0OU5B?=
 =?utf-8?B?UFJYQm93K2MxQmNWWGROZnVFVkRwMHhFV1BVQ0NuejRON3liT0ZUdUlSLzhr?=
 =?utf-8?B?RUJnY1AxMDdtUENQTnRUQ1E1OCtzdFd2MTZic1dLRjRPOGFoM0c0V1pqd3hH?=
 =?utf-8?Q?Q7VN3NLqkH/C5hFKlUnKNehdC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c100dada-b478-484a-e628-08db61a2d9e0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:47:07.4548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKDIW0quzGggMLNb4+Jdz5mVISAzbiyn8mW/TIBbMjZbwtU6VvCiGATiLNKQy8L9KU0IoaHcRtOWiPXvlGli7g==
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
> In the probe function, devm_request_irq is now being used to automatically
> manage IRQ. It eliminates the need for manual IRQ freeing during removal.
> 
> Signed-off-by: Frank Li<Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
