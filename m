Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14777B8254
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbjJDO3i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjJDO3h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:29:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159FCFA;
        Wed,  4 Oct 2023 07:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EARFDWM4JWuoynr7bGDToUsZrdAbiMKLRevxRV8GnqHCcZlZSefb2ZqRCemUNisODIC3xJwnjusxyKdyApAcGDWirXZmbDzWgzbV5qk60pTQShM1TomfDCdn6yLWJiEl1javhbfKl2cm8PvXASZrFASUaRLYasXp0ua8AUQyYwAMCLMd8bzrmgyEeWO+4CW80tD5ODA3tLeLIUmtCcXdEWT4QPpduHCTN3Gsizs7CyW+f4t5C9YbGRKKNQ+mb2qnYqfJywgNbpKreeE3l3u7jUYb1KEgTWuY1TWjONulRLdkrYa4oNSVj1CsNhy8burUMc2W97Pf7eT7/d90bxyJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMqYAIdR4fhfuj5RsMK5j6KU/WV8cHjJlkWscWCgSNU=;
 b=CcSqOR+k5L4IFYRi7mXCFVEhYNvNiPdwCPE9xFsbT3Wzx7vuFl94jZI7Mr0co0SqqZUGN4gjvwrWt8hGr0XrItVMENGJxwvgDmDoAavbVb3aQ3XkALG319XA6SzakmuaZPm2tmcYVrIxB/LENy6WaTkELwgt93Jkh2Uwd7h+ckjW6cwrCHnO4XYc6Enkuv8GIw6stXGllcKySCqXxJ4CJ5Z2IRU5C1IPj5uRR4yfeVBdaZZRnJHFpvDCIvzOtVFHATVd9KEluNrRG2GSxCOODBzmCGqDfedkiKjMzW9MNSezOXS/BTsnbjzE/ZdGwVW+bFh8IY9IbwBW73xngBENNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMqYAIdR4fhfuj5RsMK5j6KU/WV8cHjJlkWscWCgSNU=;
 b=D5aWLR0HjqOT0IHOWmi5f58oWgMdCvG9exzFNhTe4ESjmvAm56ceHp0GLIqhhYls1gALPuOrWIjeXOUHXRhG29RWz1TFb0CioGu56eOYoa78d068fQuPMc4trpVPxG5LIclYO8iEdSaglZSAOquqv7LRIQtRv9ZBAPtAYTGR8z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 14:29:30 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Wed, 4 Oct 2023
 14:29:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     Frank.li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH resent 1/1] dmaengine: fsl-edma: fix all channels requested when call fsl_edma3_xlate()
Date:   Wed,  4 Oct 2023 10:29:11 -0400
Message-Id: <20231004142911.838916-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAWPR04MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c54fec-77a3-4b35-9c3d-08dbc4e6524b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0t7T/1XzvrvKYZpl1xpPOlVgaclazNexqx0iUTyti9g63Ud+avickOWDHvU6MZgHBxs/oHh0YIYtGjaJZz8bGmSCmTe0k5XBC6fCeTxeiLNNVYtf9rWGIJgLVJmiwCohriykortU24K+Of+duYHANqUMwjVonJGm45J9DjHjaeT6fV4AICsjvXRBvsNs2a4MbwALDXP0Ux0GN2qZcKtnSWciLQphc6rf3QztQjLbk2xAXS1DRFBWJthFIImkQNlcnczdR+Kku4VgB0j7H6csinCE37QeIU9h+gFlpgQLD7cRPQueZsdFm0kFkEiV3EG0SfJsvyAEnXna76fd1qk3LXkCJrrqEahE9vOz6tqfLqghhEe6SPFIZdlTSCAOewPIvBecD5g7gBS52RZPCFqYzzWmocvFxyfVgvSR7n5hMmX7wJNUFNgOg2m7HIkkNMyEKcr9CTpzQP0I8eKHBICPQ0DOYzUb+HhtiswCcKllqwOebas3XLcInoQChKbPnFMDiB6OnERRbHeFQCVgnNXXI1Rd+xZYGcK7BNvvGppn0gIYxHwjAIu5TgO1J/CU4cPshEh0XNdSbaJsOuimZQsLwiqitopUTZHQa5BJ9hg16rt6v3Bm9c614PkMau6rZ9Hz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38350700002)(8676002)(8936002)(6486002)(38100700002)(478600001)(52116002)(6506007)(5660300002)(4326008)(6666004)(36756003)(41300700001)(316002)(6916009)(66946007)(66556008)(66476007)(86362001)(6512007)(2906002)(83380400001)(1076003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vqPHGVAFUNdM8pg6txP7JR+R8JBGtM/DcnEaum1NFyRf53rzCXqwGS1hy14m?=
 =?us-ascii?Q?nzX+iUxVkzad8BW4FcWmH8qUz1ZaHVJJs8awe/5EFG4YnLAtg3bdU4RaxP7a?=
 =?us-ascii?Q?xpCG+reEQCfymk5LBaf4J+77dWETv/NAMK7ssJQvJERayzn04VxdgCT7r2nD?=
 =?us-ascii?Q?EyE38xGawcyUMkDBXXx0n1QVNBgEpArfHjXM2aMlNjVTvdiA9EoUdWYmcCr0?=
 =?us-ascii?Q?lA9pP1V8UKgdScrXn4K3xbXDUnlwT0OlYmwOK7jeIYcm1Sh6aesxvXIVdJKM?=
 =?us-ascii?Q?OV7P7qU8uMZmEVAcioV4HxmvnW76HQa7wkmFQh7adSyp1/j+UxRaiN836eHx?=
 =?us-ascii?Q?Gos3w1BGj7qP9SdhS4GPUuXnE+LuVZ3JEzwh/UCWeNL1br3LUCuy1+Ty10Ne?=
 =?us-ascii?Q?RLZYqKwxf94JgFHY9KiV/yf9CH7ZzbnTcCidx+fT3D/SkwEzchV+AqW4NvK1?=
 =?us-ascii?Q?IcJYdkBL+oDQvVMaueTMLS2fsxSZYJXRzeMcnzNIWlK7fhmEUSgvPUmlZoTT?=
 =?us-ascii?Q?p9GX0EOgsnfM1J7V8CwQwcq53onPpMZBARMYFqB5R1mCFPyPxpmIQ8N/N7qV?=
 =?us-ascii?Q?Jpz9XrbSDcv6E0vknrMTku9e7tmCoqfik+9urxmHSZP77W0pdsMSRy3AODkQ?=
 =?us-ascii?Q?eYdKFo44TzbC9amdRMCJ9MOJ/hiMjMSDB3JmTPM1w+UM6vuoxjAdYlAmfbpC?=
 =?us-ascii?Q?DHuZjDJyc4/Hk0dx7IY27RjCBqonf4ED6WLbJkMCCKa7FlLqz78zijfiJgim?=
 =?us-ascii?Q?kpycFiJCqEvbc7khKrSN4Nu7X6f04P/Zen55E9AGA8XwcQCxQz+/kwO64T8O?=
 =?us-ascii?Q?NpWg3t+tiGGbqNZpI8cxLnRWk2lreh/SoQ1w+AxZnioi8byGsyTDtDZiSJ5j?=
 =?us-ascii?Q?dtXncxZaIKoMiQRnejRWSeOVJJ0PYFtKU2gfkejIQgUZsTUg/FgdQiv8H9f2?=
 =?us-ascii?Q?jyQ5zaL+FcTxx6hFNKUKxD5jHONWM/YigmlwNyz2AOOp4JlX2uaj1igsjSrC?=
 =?us-ascii?Q?sjWaiH7A7+7YRpsqg/VIi8j+YcxISizwDYoorg4fJyngk+L5OGffFJQwa50T?=
 =?us-ascii?Q?aHEDwfngerFtnvam28VJvqNC4i5uONxFPuvwG01sYrJtxurHsddsIzYWX6Zo?=
 =?us-ascii?Q?CwJgq8ItPGEYcYDYJuu+7UwmZt4lg8bjRXy2rvGiJama7UBoFs16bKuEAQ5w?=
 =?us-ascii?Q?9wUpZJTHvKz6BTyJ7KI3TmCBY0lRdvR3By3ITHuzrVfL5bQ51/LUmNSbziEy?=
 =?us-ascii?Q?BOowWeMG85jbr9IDvg0cFczZBNQy8LpVA0IaTm7Gdfpmssr/9ZEJHLgrg06A?=
 =?us-ascii?Q?Q70LBrFg9Fay/eJKGcGnEhYRNPF3IXi8uANnRxFwPmU5wgM2J8B0dX4BJKZ+?=
 =?us-ascii?Q?BxjeUkG+nvSer8zoEsk8H75NmLm5ZzxUMX+qt5AppaXM5pbP3cs3qupSJasD?=
 =?us-ascii?Q?WPE6mRaEjXY6smsWieEZ5l6q1VMEkMfCL/lFFs6Qiin1XAZtujVv13fvbIjD?=
 =?us-ascii?Q?aUMt0LOefQG504jDTbbqXpQOLJN2Yqqao/1K4zKLc8vBXC+j8dtOBYj+Q88L?=
 =?us-ascii?Q?JGlqn5yMPBrpP4eXPy0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c54fec-77a3-4b35-9c3d-08dbc4e6524b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:29:30.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kms1vFIp5TBPh8z4LnQxRb+oZQ55J8jLkroPiuoXN3UVnVrY0Fumk2WktRM6PP2qEG1E3kaK3ELy+0DZ1szWIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dma_get_slave_channel() increases client_count for all channels. It should
only be called when a matched channel is found in fsl_edma3_xlate().

Move dma_get_slave_channel() after checking for a matched channel.

Cc: <stable@vger.kernel.org>
Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 58ad148a74bb..4f8312b64f14 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -154,18 +154,20 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		fsl_chan = to_fsl_edma_chan(chan);
 		i = fsl_chan - fsl_edma->chans;
 
-		chan = dma_get_slave_channel(chan);
-		chan->device->privatecnt++;
 		fsl_chan->priority = dma_spec->args[1];
 		fsl_chan->is_rxchan = dma_spec->args[2] & ARGS_RX;
 		fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
 		fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
 
 		if (!b_chmux && i == dma_spec->args[0]) {
+			chan = dma_get_slave_channel(chan);
+			chan->device->privatecnt++;
 			mutex_unlock(&fsl_edma->fsl_edma_mutex);
 			return chan;
 		} else if (b_chmux && !fsl_chan->srcid) {
 			/* if controller support channel mux, choose a free channel */
+			chan = dma_get_slave_channel(chan);
+			chan->device->privatecnt++;
 			fsl_chan->srcid = dma_spec->args[0];
 			mutex_unlock(&fsl_edma->fsl_edma_mutex);
 			return chan;
-- 
2.34.1

