Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC47666B08
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jan 2023 06:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjALF61 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Jan 2023 00:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbjALF6Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Jan 2023 00:58:25 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2067.outbound.protection.outlook.com [40.107.255.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCF13CC2;
        Wed, 11 Jan 2023 21:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1k0zhH5Upz2UFv1cuqEI1Y/veThPjSCdgV6YwcauF2ITLveyNCOrzBkywVttDzVPi7YiMeWO4sw0cO8dVokiBFvQvTMcn9mSwSdEC5MPSC2vDKehYNg2o09t4Bo/U/WmD8KxN8AQ0mJGNNcVnJ7h9a9TzsJb3yubl7nprivkP483jIgnG7rBPmhCeleSkSbjgv8u/Hskvxt+Ty/X0VGtQwyJoT9Jc5fgCc7/7efiIYOxegOsPEfMglgeF22MBeRoNliCCHfh038BlAeknUZ79l7t/u1NrIVry1YZNDLV7mYHbtvd7jpe+YySmhQ+Zhivyk+VYgqIWF8bTvFFxVo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpW3tcco+/1HLoLBvJkGiYqL9Hqh/etx/lwVqwV3t3g=;
 b=J0bnTVyecljJzNNCT++sbw6L8kAijcLhf4j7ngdm75/Pb+ObYdnV04CDpKOD0nZu8yJ+/BnIbxV19QTyjXudIJulGUwT3FlCybuj1i6fviTewiCauna/snXMNSKry+gAj2Rh1tM5ue3Nh8esEuklYcHdMsFJ9yUV1wDv7jXtx4Uiv30/C2kwhYV6Mlt5mwNW/oWqVQwKCUwRq8NXJUPHyHZMNMD4tGlD78UNYlAN3o0y5tQPZRXH+w3MarvqRfxcuLELQ+QfbGkLrhS1Aw5B1houzrCMNvIz/rBraMbu8D4t+OUw2GA6DY4tKd5QE0MXZIHI5UIXgx2A4/XoiOpNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpW3tcco+/1HLoLBvJkGiYqL9Hqh/etx/lwVqwV3t3g=;
 b=Nd3yuEDCsezAP4htgoMEyeT9MhFlp8izPpx5z928SKcWkn1r1IYvpNIfYYqiV/xygTP2ACcumOpMQ4c7yaCYjRGlqb2CZ8I97ABg9n3WHgGgE2UFUu9KPLxUiEgDAOGnpUq1eyR5j9oGQ76b7FOakGGNibqAeab72mqaQeHBc/gjJB8MD6asjRGDUaIWmmRoK5MyXZLe1feRpdmpscBekU0xPv0Cxe5lR4/z0m0lJqQAVxRNGzTMwEMURKKIoxCkuQlZldJfDDGt8i19unHMMGSrYx7yaDOZ1HVLrwCA7pclLDPke4c5ppI31S4KozS8yKjxG4XEUblOOjf8rZPLzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by SEZPR06MB5713.apcprd06.prod.outlook.com (2603:1096:101:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 05:58:19 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::4e0f:2819:72c7:962d]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::4e0f:2819:72c7:962d%8]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 05:58:19 +0000
From:   "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xiaowu.ding@jaguarmicro.com,
        "Shawn.Shao" <shawn.shao@jaguarmicro.com>
Subject: [PATCH] Add exception protection processing for vd in axi_chan_handle_err function
Date:   Thu, 12 Jan 2023 13:58:02 +0800
Message-Id: <20230112055802.1764-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|SEZPR06MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c5f8f4-f89c-4a2c-4fd2-08daf46200bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWvcTRcJ+7YQ7SlG+E/gkrqElGAwqtmgYf6xnxX0KUSk4AoLNeuiZlGgdEeu+Z9Xl7TMJQaRMixgF+DVf5VgOHtYNfuy75A5ZspY33aLOUqXknRxFtwW5J3C2HSoE2OgyIB3MJN5PHwH6EgHREXIzE24py2hwuPPsThTvbNUrmS3sA7MZ8hd03NqERRQzxyFPA/qEdpcwx7gHC0cPL4TzuDHfaCfQolY1UJwvHTEFDmbFD7SDCEAG2YMVNAkV8V+LCSNBlHbx+Ym2GKDq5W59VjtMqM9Hx4oNmRF5pihInz3OsMI964LRgMuwaor6NJWNoX4DOrVhHLrwKWthdW6zQuIoM8cP/KE90DEbmoY4UkzXJdrXCcpMC3/0xH9+MyA3zNL9eC2r++OB3GwQUl0+6VhmK9gsp1tVdZ99/Ad5rx+K02qBX/xEEnO8gr3KZmFoFDCGiaZQF+3fm68bOxW7nmJnln32oSfVbDtq+8WWR7F9X46CSODJ3u6eWqwNuacKURaYkCz8DkfnkVAFDs7j8jMHwMa3Z41rSiCnG1ylHC2oEkeWQuX1vC2+hGfV8LPLkGZHhUHxOpJD9ysIQXjRTZKf/z8hMVvdhCLxsTHhcLy7pi/8ap93TThcJCpMGrCxh9OSCDxzcw0fv6CJGdh0AHlsZYmMxKP92I225mINXuv1Y3BUU+m3aJkC0TS/NTE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39840400004)(396003)(451199015)(2906002)(4326008)(5660300002)(6486002)(36756003)(86362001)(8936002)(41300700001)(66476007)(66556008)(66946007)(8676002)(38100700002)(316002)(38350700002)(45080400002)(6506007)(83380400001)(52116002)(2616005)(107886003)(6512007)(6666004)(26005)(478600001)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N2R/SNmaYEm8KdnM0VHF+MjwG1iioA2G2dv9IsWac78NDK0+s7OPV/P/7pPT?=
 =?us-ascii?Q?OSs34XQi9qace+P0ha79xM5f2FOzdhWSSxyIOXXEeFRxurWqUuaJo30HQBp/?=
 =?us-ascii?Q?M27TaITiWPgM1YAWD9uQOHz3HjXIaQ9K9kmR7vlnRMK2X31FI88ZQllNc7z+?=
 =?us-ascii?Q?9b2hpCv2CRiyNpiSpyNc6UTkq1IY6CPHFSXb9lIJAOFZnhzqKlsp1p/fBU1b?=
 =?us-ascii?Q?fGtoJobIltBFqrOkQWO0kXBGhKX5nLZd/FZa6NMmt9saYzBOtVF7k5e61oI+?=
 =?us-ascii?Q?iXh5R2sPyaNMXtlyn6YtGDKxJhckEGgkMgsb1wJVzXQMcKS7uakmhzpL+oVl?=
 =?us-ascii?Q?uSk9wCB4+moCrxWm8/fDG049l9uuCwdXRoCEJWos5aTMME2a6m2jCyDHgOyR?=
 =?us-ascii?Q?o7OXscqZn+J+qe/dMuMgUzTAs54hlJjJpI6rdMOhZie1ymhLg6abphDR3meH?=
 =?us-ascii?Q?GH37i0vnWdbMzlEc/EwF3nr78NUogVzctrruaEatE8TF8B8c/9BAc6x2Wr4g?=
 =?us-ascii?Q?wIsQio0WaXcOppKRio7u/4mMlWdN5pRR0Xdb8JegQ+eCsWDJsmzaJuUm6hvJ?=
 =?us-ascii?Q?qMdou0dMUE0pT4Wr8e3zJ6BhpiNsKUJdkBSzurChwKGLA3A6/H/xMqFyn3Cn?=
 =?us-ascii?Q?64XiFfntNN7jasI1X5sMU+0FhQlQkQ9KCL40FYNtYkF9LdFBuPmPsG3RuAIg?=
 =?us-ascii?Q?/WeKvMPWRwkXt4w/IrmJQ4+zFa7bDCOGj+spVAfxnPOM/wnzq6u9izyVxcu3?=
 =?us-ascii?Q?PL1D20dHsV2nXzIb19FvExExiaISaX/RMnP0cE2BENGEXYcig0jiznk6Rthc?=
 =?us-ascii?Q?fAaAm3OsfGQM8BrF0g7hUeQ7FOidkwLT34KShHKK5onk33/3mp7nAFx9fFrv?=
 =?us-ascii?Q?QLnSD5CYO8cFU84bL+OKOVUR8wz8ZhDZZUS1wkrpUZQNMsjhgF8EqfnKpmkE?=
 =?us-ascii?Q?Pbah97cSXuzRyVCRhnNNbhNkYjFePxOgn26Qt6/3Dh6VxqKRfRkqnFdg3EGu?=
 =?us-ascii?Q?gjAqZg7k43TYFrOLq8+d93+j/MSHdsPdYmLRh9UiFu9Ref4wSOAUWvfCYaCj?=
 =?us-ascii?Q?/Pyc9pbs41NWWiPdXxwD0qGrH2v5Pu4yAWWUvREzTBhxWbIu9K6D0oAsgMSL?=
 =?us-ascii?Q?SVctxJ1m3G80rZkLlcgncfW9x1owynu0t4qHqO6TmhSY65/FuZJ7tmdiVJ4I?=
 =?us-ascii?Q?90rt1myvXDodIlwDviq60WMaTqFOgoJlFCAuGPFbS190Pkz8WftwWQ9W84Sc?=
 =?us-ascii?Q?peOM+qCOigfyWjS+0ReY1Qy+afv4Gq352mPPJ1igNNWbtxdQSg67WyyfbdK/?=
 =?us-ascii?Q?dyDqUp/d7TB8NPfh+C/qdEjB3cgQxyNpUzZqR044aby5psofX1JftVApCHw4?=
 =?us-ascii?Q?xUR7aMMGsTBbDZQARL1rr70nevkmzHRyI3PgLM1RuSo9wwJ1GnviPgqX03as?=
 =?us-ascii?Q?ofxlb1ytMfc9/IQRAGiY3rd3A9C/ub52Q1OoatnzaV09GO1bgKzhSGRF+EIq?=
 =?us-ascii?Q?UoyoIAL+VOBcCjCzBwCRB+xiZVMampERounNbQfgtEebTELwDUjFrS/wsCDy?=
 =?us-ascii?Q?NbVa9bk8JK8t5Lv2NMP/oYl56O4rkp1D6JpInwnTcKAkfPpNmoE5P6/5ivPi?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c5f8f4-f89c-4a2c-4fd2-08daf46200bb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 05:58:18.9326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11BxZbMZwSYprP6Bir8tyioWF187ap3OxniVmn9i4bOWmR1/yok+m/GGy5VmPokzlYq+t7IDbz6WoOgxAqNnfIAV0MQ9C1XtXPRHWpwx+oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since there is no protection for vd, a kernel panic will be
triggered here in exceptional cases.

You can refer to the processing of axi_chan_block_xfer_complete function

The triggered kernel panic is as follows:

[   67.848444] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000060
[   67.848447] Mem abort info:
[   67.848449]   ESR = 0x96000004
[   67.848451]   EC = 0x25: DABT (current EL), IL = 32 bits
[   67.848454]   SET = 0, FnV = 0
[   67.848456]   EA = 0, S1PTW = 0
[   67.848458] Data abort info:
[   67.848460]   ISV = 0, ISS = 0x00000004
[   67.848462]   CM = 0, WnR = 0
[   67.848465] user pgtable: 4k pages, 48-bit VAs, pgdp=00000800c4c0b000
[   67.848468] [0000000000000060] pgd=0000000000000000, p4d=0000000000000000
[   67.848472] Internal error: Oops: 96000004 [#1] SMP
[   67.848475] Modules linked in: dmatest
[   67.848479] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.100-emu_x2rc+ #11
[   67.848483] pstate: 62000085 (nZCv daIf -PAN -UAO +TCO BTYPE=--)
[   67.848487] pc : axi_chan_handle_err+0xc4/0x230
[   67.848491] lr : axi_chan_handle_err+0x30/0x230
[   67.848493] sp : ffff0803fe55ae50
[   67.848495] x29: ffff0803fe55ae50 x28: ffff800011212200
[   67.848500] x27: ffff0800c42c0080 x26: ffff0800c097c080
[   67.848504] x25: ffff800010d33880 x24: ffff80001139d850
[   67.848508] x23: ffff0800c097c168 x22: 0000000000000000
[   67.848512] x21: 0000000000000080 x20: 0000000000002000
[   67.848517] x19: ffff0800c097c080 x18: 0000000000000000
[   67.848521] x17: 0000000000000000 x16: 0000000000000000
[   67.848525] x15: 0000000000000000 x14: 0000000000000000
[   67.848529] x13: 0000000000000000 x12: 0000000000000040
[   67.848533] x11: ffff0800c0400248 x10: ffff0800c040024a
[   67.848538] x9 : ffff800010576cd4 x8 : ffff0800c0400270
[   67.848542] x7 : 0000000000000000 x6 : ffff0800c04003e0
[   67.848546] x5 : ffff0800c0400248 x4 : ffff0800c4294480
[   67.848550] x3 : dead000000000100 x2 : dead000000000122
[   67.848555] x1 : 0000000000000100 x0 : ffff0800c097c168
[   67.848559] Call trace:
[   67.848562]  axi_chan_handle_err+0xc4/0x230
[   67.848566]  dw_axi_dma_interrupt+0xf4/0x590
[   67.848569]  __handle_irq_event_percpu+0x60/0x220
[   67.848573]  handle_irq_event+0x64/0x120
[   67.848576]  handle_fasteoi_irq+0xc4/0x220
[   67.848580]  __handle_domain_irq+0x80/0xe0
[   67.848583]  gic_handle_irq+0xc0/0x138
[   67.848585]  el1_irq+0xc8/0x180
[   67.848588]  arch_cpu_idle+0x14/0x2c
[   67.848591]  default_idle_call+0x40/0x16c
[   67.848594]  do_idle+0x1f0/0x250
[   67.848597]  cpu_startup_entry+0x2c/0x60
[   67.848600]  rest_init+0xc0/0xcc
[   67.848603]  arch_call_rest_init+0x14/0x1c
[   67.848606]  start_kernel+0x4cc/0x500
[   67.848610] Code: eb0002ff 9a9f12d6 f2fbd5a2 f2fbd5a3 (a94602c1)
[   67.848613] ---[ end trace 585a97036f88203a ]---

Signed-off-by: Shawn.Shao <shawn.shao@jaguarmicro.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a183d93bd..bf85aa097 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1018,6 +1018,11 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 
 	/* The bad descriptor currently is in the head of vc list */
 	vd = vchan_next_desc(&chan->vc);
+	if (!vd) {
+		dev_err(chan2dev(chan), "BUG: %s, IRQ with no descriptors\n",
+			axi_chan_name(chan));
+		goto out;
+	}
 	/* Remove the completed descriptor from issued list */
 	list_del(&vd->node);
 
@@ -1032,6 +1037,7 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	/* Try to restart the controller */
 	axi_chan_start_first_queued(chan);
 
+out:
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
-- 
2.25.1

