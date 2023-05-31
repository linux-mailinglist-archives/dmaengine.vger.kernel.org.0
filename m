Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9687B71770D
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjEaGpz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 02:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEaGpz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 02:45:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2A399;
        Tue, 30 May 2023 23:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx+UFz/AxLlSWGq2ACIYZIQ8Kv9yB1XzEUM1vKu6xD/SMhw+qbdV+V5Zo2iNejJLyEMrPkwUCDo/XTjjIFLNYBao5mYHhvob2t6XkJx5tJRyy86Nz3OKum06/neeE0kDm9A5kTzyFFp6qvbbk9sfX7tEGdXrQqT8XT9jCP/NZpSs7CF0Q+CyvQDgF/devpSo1SWxII8am2Y3oJ9z8KyHt3W9Qxy7yrySKjQ1/eu6lNdjiaS5OctcmrjManXsbFK8o+JDwyJSMIQB0vi2EQZn7oMaGUUf4TOT1O0b0Xn1tcDlP9GrO2NLPnIpGvlV9JoE3QMXC2NpjpyERC/RFocBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D36xDfLqINBkSBAW88L9mipRgbg162Bdl7dzWDU3c2o=;
 b=XUUeW4WT1m3EyG1HZUz7KTZ85xkY9ODRGYthorQ47BsuFtBBUxcOjP8kARq4sCiL19B1Qt0T7ZH+j4QF4ti6jPhWSL1bsGT4j/QouVoPrNQXrp7KpPu1LWQFHMUJZ28AnFCzqLNaaQNjzaKIM3OJItoB2a2XJPMF8fEN77e6IGzwfx3vWrO98ypM4hcKbk2JHY9nu5rkENR8k6IBBp4frS+I2yG1zLi8yHMGT5fX9xUB3iS7vr0E+uInDQ8t6rHTp4Uc89lAXjrCBf7wBZUHwEl44Ap3kiwFWIMH1VE+LwveWMONTo/KVFJSl7xPEZyvCV+LDXJeDRImgK6isr35qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D36xDfLqINBkSBAW88L9mipRgbg162Bdl7dzWDU3c2o=;
 b=Ti6p+1xwDG9wlQzoz4278qVKpjxJ/pPLMISxGXmzuGuKRt7OMxThPM3dEAxpulic9vVoDSu9zXcfMpzXcKEn1nzDlcgChRkV1zWHbNE1BrfxQ4bOgdLD5M/ImH28AGd/qWay/25kAzGizQE3ubheydWumd2wiRIqOjqefngJdMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7791.eurprd04.prod.outlook.com (2603:10a6:102:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:45:48 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:45:48 +0000
Message-ID: <39942915-4c8b-135a-3e17-507a1ef3be11@oss.nxp.com>
Date:   Wed, 31 May 2023 14:45:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL
 in fsl-edma-common.c
To:     Frank Li <Frank.Li@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
 <20230529200453.1423796-2-Frank.Li@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230529200453.1423796-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: c2addd27-2fc7-484d-f273-08db61a2aaf9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Cyb5T3LzFQpaBVmFPBUL0Afp/MWtMT4WCKEafuRdeQxhcqM9cZyEd6sbPxp/zF5JNtPwZToQEe5FnaDdh5EFOKCk+01v6LpU9ibU6gtMaVVPlrMRv0BVOw0I6O51eqMyy7JyQovIhJQljgwhLZgWnbu2E1dl5qca+Wnc69tG3HzAhAlPV3i69iv4pHfMYhE5Rc/ofO10CJzQFyhZSPuyYVpUmXpzroLCmdiyGr7Zxxb/R7J06u8FnYhydqNdshTp5GRZyYezqPWjoetlDrzTGaMBdjpc30ua0UuOlISYR3UwVgHW6ak2LY0Nq80N+ZIS0mVth6xkSa4yNRheH6Jj/+s3Tu+wgmeNmXk+nDjc5ZwoYX15ed98V7NqcDil4csXm35mxcf9aumgnI7frr7kT2qVWXIC/HV8iZppNkRJ3B2saOfexfeVc6UNx63Wg4BLZyQntgPZQ0ZqRiACG5FZZtTHZ38+tkCfvshDWm+8uRKuBE/46fcZ+oqp6sD/0eSycQq2t3l4yAN3GWribj1mH1GfUuygU74DO1yfnalxDr9eQD6zHlVB1NMwY9Nl2WRoblAUXaxuaDE0RvOt4/kTn1hP+v3FDr2hhZRChpCsDtjLydH5wBVOPqhKoXJTAczsQWobcDD/JBtWutM/GDLMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(31686004)(316002)(66476007)(66556008)(66946007)(478600001)(4326008)(86362001)(31696002)(186003)(6506007)(6512007)(53546011)(26005)(2616005)(41300700001)(44832011)(8936002)(8676002)(4744005)(2906002)(6666004)(6486002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE52WXA0OXNRLzhWS3VCYTNMYjBiWTEyUHdwblAvWWgrWDFlZWtrNXBaaXl2?=
 =?utf-8?B?NUpsMnY2Ykd1YVljRDFKSVJKT2trR3BTSkxRTDBCSHMveUFBcnpHRXhmMXMw?=
 =?utf-8?B?Rll0cjJ3VHplb2Z0a2FDT1hxalQ1ZmZnTTAxV3R4WnBNdUtIUjdhQkxabTIr?=
 =?utf-8?B?U2hZaVZxMWVyckovNE5NbW5EUm9IYzQzYVdBRVMwUndrTFpxSnJFVjdPMk9o?=
 =?utf-8?B?a0tERUcrRlp3YVVBL2lBU0FxVE5LNFdWZjJwL3FlZU9pL0p4eThhOFNrNHlr?=
 =?utf-8?B?OHlkdFNWRU1MQy9VSXNUZW9yaU1peXQ0Q0ZRS2IxMjZjc0VFSlphNUgxUjNK?=
 =?utf-8?B?Q2NTdXBKem5TWEJKU2pMd1ZVek1hNXUzTTF0b3RaaEdTejFQQ2xtYTBucFVs?=
 =?utf-8?B?ZXNjWGFRUzBzMzA5Nyt1SXA3SFJNeExGZkw2bTRLTFpSTEw2N2QzaVpiSU5T?=
 =?utf-8?B?Yytvb2lESFpzZmlHTmIwL1Mwdm1MNXJ3cWtILzU3L21Uc0h2YmcyVUNsbVhH?=
 =?utf-8?B?bXJhd2NtVlF2Z1dKdjR6eXpYM003cmdTaGZRRW12YWFwNTlOSjBpcDJXYVB1?=
 =?utf-8?B?N29hckg3YlJOUE0raWs2N3ZaTXJrajl2WnM2VVpabXg2ZzhURytwU3pJWEp4?=
 =?utf-8?B?akRvdVFhZ1U5djlaWHRsRTB5RUVJZDEyTllheTFjNDh1QTZLRE8yYThqWmtz?=
 =?utf-8?B?UTN5Yzc0M1JNOVNhR1l0SlpVZGZKaFEva2NyOTVSczkzNWZIYzVPdVFuSjE0?=
 =?utf-8?B?QTE2b0FHdDRNZXM4SHVwUk9hUElLSUcyYmEyRUF4VDJweUErNk9JcXpTcm50?=
 =?utf-8?B?N2o5SEhBVG1wbWVZTDlvZTFmdFl1cWVrZDU1ZE1MS2NQMXhpbmJhakZkUlls?=
 =?utf-8?B?OGEvRURBVnM3UEp0cGJPWVVYa3NBdnZ2eVZVbzJycHFFL2Vtc3ZXTlBKMXpS?=
 =?utf-8?B?NlBHb3VTSjR1aTU4UHFyRThUbmYwOU90WmxXVHo5SWhrSFp0UFBoTnV4b3d4?=
 =?utf-8?B?LzRoSHZzYTMzcUhNRGt3VjlrVTV6VURsdzA3a1pVQUZQcHJzck9ESHVSWmNK?=
 =?utf-8?B?ejUxem45NzRsR3l2R2ZsazhJWThQTGlBckJXQW41Zlo1b3M0MDFmM3pVZm9k?=
 =?utf-8?B?c0g2amh6SUpUV0M2SUZjKzRsOSs5QVF6Qk5JQ0pFNFVwUDdiTlBMaDFVRDRi?=
 =?utf-8?B?bmlrWGQwcmlMaEJNd0xUY2ZGQU9FcE8weDFiRENLTDRwb3J5a1RFajR1SnpG?=
 =?utf-8?B?TFdnbStjV1Znb1AvRUVxUVlzc0xoU3EvaUVaZE9IVjFWTExkSDhHaVRuNEdE?=
 =?utf-8?B?WlgwZWxtSmtIZDFKdmsyTVk5U3V3azdJUk9MdDBhaWtYaXdWT2tTZzdnVWFm?=
 =?utf-8?B?V293TnpkVHZFWjdabjcyNTBlMk5YZHYxNTJNa2R6WFA5dFIvaEttWnA3aGhn?=
 =?utf-8?B?aWVZeFc2U1hCY0dhN3pYcmhWUWtVL0F1eTU0VjJBTTRuSW9yazhOemdIbjJr?=
 =?utf-8?B?TlFRaHNmMGxTa3Q5YW13RWVqcDBGVndjNkUvdFdBakZwYkhtNWFTQld4ZFQ4?=
 =?utf-8?B?aC91aFk4ZFpKbUcyZFpQQjBReHFWVGl3YWFpKzFCcU1Ndm5seUxad1YrZ1Av?=
 =?utf-8?B?L2N0L0VvTUJ0ejZ0UXV2WWxJZnVtMWNUY3hXbGNlV3JxaHdQQWY4UjNPZnVo?=
 =?utf-8?B?Y0luZndiZDdadDNzYmMvK3J2TTM2anN2dlkvRlBuRXU5V2c1YUpOT0tWZGk5?=
 =?utf-8?B?VGdGRFFXNVNoOHNKdDFDeWlVRWFIaU1tWGIrZUMxK0pBZ0ZLNGtUcGNHRU4w?=
 =?utf-8?B?Y3FQbFh5WVhxbGM1blk4SmxGK0hPRTlTL293aTlTWEZZYjhaVXFkNWNsQmI2?=
 =?utf-8?B?QTNIZVRkZWs5NTRpYTVPYmhUNnRIby9ZcXkwUHRYT2kybllMRXJVQndjZHVK?=
 =?utf-8?B?UTdIcGJDdXhyTXBiNkljU1d5cmoxV2pDTFRxTS9GQWljNEJFOEZWRW04Z2tP?=
 =?utf-8?B?R245TlRDS0RQTFFzQWhOWE93djVmWTZ1MWtzdXVoTVpZNjQvNDlFTEpYU1Jp?=
 =?utf-8?B?UkV2VmhnMU4yVDBOWGxxVS9PZHZGNzBxc2xxTVF5VFJZcG12ZjR4akdpd2dP?=
 =?utf-8?Q?dS6ACgoRirDqIKo/vIbD36+iP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2addd27-2fc7-484d-f273-08db61a2aaf9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:45:48.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpfw+GNTWrtPNjcYX9neSkhIfOutBWaZP7LewAsgJqfGWttvAXOtNjwe+1xfnnlSWmhL20OCtPghlkOic9TRuA==
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
> Exported functions in fsl-edma-common.c are only used within
> fsl-edma.c and mcf-edma.c. Global export is unnecessary.
> 
> This commit removes all EXPORT_SYMBOL_GPL in fsl-edma-common.c,
> and renames fsl-edma.c and mcf-edma.c to maintain the same
> final module names as before, thereby simplifying the codebase.
> 
> Signed-off-by: Frank Li<Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
