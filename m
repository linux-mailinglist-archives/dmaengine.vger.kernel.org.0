Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556366B0AA2
	for <lists+dmaengine@lfdr.de>; Wed,  8 Mar 2023 15:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjCHOMH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 09:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjCHOLm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 09:11:42 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2080.outbound.protection.outlook.com [40.107.117.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9524B856B;
        Wed,  8 Mar 2023 06:10:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2j/2lLlFdhAvfQJwE3ysz3cwKvXLQT1QDWVHmmnf5aS4WazePPBh+XH1M8xilnUJ81/F8iPkKgWV9D/e3QMV4UjtJk6WFd8+W4TiPVT4PRIHfeBp28JEp/w3+GDQDOkkNT6jDakIkPJM4trYHdvtfAOloQIcjWyupYhMjZOcDaznX/Tlnc2I3bfN4/WD3WKp2//CNwyJKc1yT7yIxv4rDQAjZckYpbk00RybUVIN9sZp3dxi/G4tCy8jZaq33rfWZk9EkmlLzkCDTMBqmGwVZ4s0dzV2VT9kDWMxrHcSGaBmrz8DyOZgZJaV0TTZkG/FrLy6hrttWbN52CQ3HjCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7AHXHn1ZtDM3JXgv4zc9Ka1PC/GMxjDoxyaxcqTzqw=;
 b=nswEwu/K9tTGI4dc9i2hPvT6kQ2Yh/JGp5C7YhABLOa/JdrquB/MSRlG35umZzNe/QcZ9lC49llk0sk6iQvcTw45m453/EPpMLMDN3QBpM+J4bBsIg4Ildpeuk3P3fym7w5JDWIWP4631dUk9yRI9W8paYy1AdXbeiguh+hUoYuXIyJ+bpx2vQQl/3sDUqcFkaSSUrDoPiTIHw2Un2gsMsE6Un6lF2ojIXrZkoJvwOu1MJLdDAp5plsPmEH2BPNKFAILRofMwmMCQ+Dr+Jwqf0oC71dSrd+SUtcjnUq1GcAQa2Lh7tGySXajsqMB5VtEHdZI4x/gDWPzIZmPMX7s8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7AHXHn1ZtDM3JXgv4zc9Ka1PC/GMxjDoxyaxcqTzqw=;
 b=hath+TfHSj9rIYx8BFZCW/xFhS0nogePXLzkMADYF0HA/O6tD8o2XK6rcw5+WnrkO1FhLnCThyAgEZk021S7OekU5UsGlhaDSzv/KVupy+7ZBHoOrEwGPriKrGtY9lYWp/ZuKHmRDzorKhx3FhRWXgVY9PspaTgjMP2TiUBuBDxWnP1Vdx9nmgwi6jrGVE2PhOxjSw9m5Hwac5ktrLUjpCsAuJcWYaGH4UoCgDt03Qs7LSM4khWwnv8poi2myDr4vMSNKwg2h9NZmeXS9kgps5egLuqBMUqjP1h5Yx1nCyBEkPkBRAjhd6FlbbZU+XMw5cljVO8CbmhOHNw5Ma9VLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYAPR06MB2239.apcprd06.prod.outlook.com (2603:1096:404:21::20)
 by PUZPR06MB5537.apcprd06.prod.outlook.com (2603:1096:301:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 14:10:32 +0000
Received: from TYAPR06MB2239.apcprd06.prod.outlook.com
 ([fe80::43d2:8dd6:854d:3ef0]) by TYAPR06MB2239.apcprd06.prod.outlook.com
 ([fe80::43d2:8dd6:854d:3ef0%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 14:10:32 +0000
From:   Libing Lei <libing.lei@jaguarmicro.com>
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Libing Lei <libing.lei@jaguarmicro.com>
Subject: [PATCH V2] dmaengine: dw-axi-dmac: add spinlock for multi-channel DMA
Date:   Wed,  8 Mar 2023 22:10:19 +0800
Message-Id: <20230308141020.1876-1-libing.lei@jaguarmicro.com>
X-Mailer: git-send-email 2.39.2.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To TYAPR06MB2239.apcprd06.prod.outlook.com
 (2603:1096:404:21::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAPR06MB2239:EE_|PUZPR06MB5537:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c1676b-f98d-47a5-b590-08db1fdee0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnzhqts3q//MfpW7uageseYoX+d7zBuHS1u6gVLAYvWRTCaWdr25OEBN9xcf8uguhBmfkj5OYR3oS7YALnhN3AgkD8m951W79uXEnWSoF9VYJVYvYlg9EZ4f8EO0DL6XrpWSY0uth0RdCzTJVK6PpOqmrQNIqHhca3d/LvCwxSOEmJ22pIp5e9mrUt4UuOsjojVejI5WfQWuCY0RAviGYmPCEs1mz+9dd4qRv2hKmkg/06iAjRKzIWZEUzOZGv61Jhvs3IrHk7qLeg4hjcEcqhcv2RZuUMGE8RatY8JVnSSq8LSqAwCR2ROmPeM+gBMcYLvkFIK7eUNAcso55b0fwYpt2Xu+T8sGSb7UdCJTX+YRU+sx+ryodzfLMqwx7Akr463VoKE3IV4BnfZQVbcQKtJentG7DLdYohE6687bz6wM93n3E+byDTx6hsfFVDmkROtu+TJ6sOoTbdGRXCNrGZc4sCTSTQZfbPy7SYawc1qLUYXcATdRo6iUNfqEES1FCzzof9wB5uwYMYAlYqnbH5YmiUu8R2VRXz0hsejsRfMQFJHbXmFxzfVJCOw72sBytRJiF+J4n+ShYXXKLzau7SuVFd49XyYL3vaN4yAJg/ygmim0F+1bjPCgOZ4zBgT9oejmvxkvLaA4hpioETdGgPxSqjTLyKe5NB3ZcYg1yrSxU9KXI2FNogUx9hC/xy4tBiSphWoOYlgR12vGJseNaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR06MB2239.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(396003)(366004)(346002)(136003)(376002)(451199018)(6486002)(52116002)(36756003)(478600001)(38350700002)(316002)(6506007)(38100700002)(86362001)(1076003)(41300700001)(6512007)(107886003)(6666004)(66946007)(2616005)(186003)(83380400001)(8936002)(26005)(44832011)(5660300002)(66476007)(4326008)(2906002)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?byQGVgDtCA1fl+TvR7GTF5vNzUnE921ARjp2Oqq3o+lM4jjprSdmlJxyjCq/?=
 =?us-ascii?Q?QQalfMEMp+j6jVy1URBYLLeVQ6Lq8MFuugcGBeqFUEwBZqGfIE/0o72wutch?=
 =?us-ascii?Q?gAQWGOweQuVN+9q4XIH+GVc3PY6u5R5nUEz74gUbDgtiUTwvnxf9Fxu3PpUG?=
 =?us-ascii?Q?ra8CTa+8QVbqc3GI6oIilWttNYZehkUtcFDomhVZ7/oJLPYm/VlRCuudhble?=
 =?us-ascii?Q?GvEur9N34Sjrp4VhdD/ffS8bWpYPs/Yyck4rJ5MHGzhUZY0pfoglknxIdjF0?=
 =?us-ascii?Q?ajG143YO3DD6wmbQNXZAgNvdKqD373ZkyHuKNgr1VufXK65L+tSB3SA0qD7L?=
 =?us-ascii?Q?Izz+K/yLZS2YVgpq0o602i8gL3qvE+Es8jz8ftyRVOj6hQKVFW1ivagVNSgL?=
 =?us-ascii?Q?OBliKL4jDNEIfbo31xhyaehnlsN4sK0IUi3WPEdO6ag2KMvMKRzfu5zkCAMc?=
 =?us-ascii?Q?JScYz1MAGSjZqbX/nFXu2AlX1Q9ZL+OxZIXyVYaeuWLP0VOBAw2Whe17Iku7?=
 =?us-ascii?Q?r6dwTtnrwdBIE436Aq+1x895mcg+7haY4PZxlTBY4sSeOWu+MvBGaYBAyjHR?=
 =?us-ascii?Q?7abkU1F2akMGI3Fm10nJVN0xUoI/qZJEiSYN62Hfc+8U/syvBbeoRvtAcNsB?=
 =?us-ascii?Q?VThMXxBRUZTBlab5M5Dav7sovH/wopAzg/uqRNklNEWl7idgTJLXSh1NtyWW?=
 =?us-ascii?Q?hDyw34a4W/DF5MiMS70qmRot6ZnvO/T2HyGn9JRDd6G2t9DlkgxdJFb5dgmp?=
 =?us-ascii?Q?6Zsbyk3244xfEofWRxGGrP9ADspkVgwPhhvwtq1w+SlpUbRnzs23lL8YofaG?=
 =?us-ascii?Q?3LEj08xyvoS0oXKSohbZXEL61kd2PIoiHHCqXtzpoJOI3T4/dtjd9w7VyHIj?=
 =?us-ascii?Q?9MwGEvvPqf+b/iNZosdYbnm623og/NIgiOfV+WaHpsejMUHTyv+CK1tP0n4O?=
 =?us-ascii?Q?dNtvi6XWc4k7AkHCHlH0nfs0WJozWBnhN+1lVXhSuHC4k3PP5gi3NqR6xmc5?=
 =?us-ascii?Q?hHgzdkR8n0aaa4+2/15H9UQOqzowQh3aHcCaV0PqpQJxmXirEaMuUITsbxH5?=
 =?us-ascii?Q?g3tfoA1vSl8O0s1lsYpEMuRQdlasmti2u4U3l8VvP18kIz+Ndw1LCbUKZdYe?=
 =?us-ascii?Q?5W4hV63u8E+U/ZJJHzvZ26tqnghzjjePFlnD6j+ySqqGi3XtLKTh49I+bxs3?=
 =?us-ascii?Q?Gjuzyt1U7B/r0Lwa6S6ZdK/Ha34m1RhqM/fsMRwF0tpM+xsb1xQjvLBFc3FR?=
 =?us-ascii?Q?8bk8/gTBobpa04Vf5a2jACr2BV2JBWBe9Sc1MpBsn5s5IxEOyq8IVrfADBkz?=
 =?us-ascii?Q?ypATCk3BDQ/jjUvD+yQMa2LCyeLi09NXbggmPzRIftshRUPsXGtHAJ0/UlyS?=
 =?us-ascii?Q?/8dHp8xSRONJc3wb5IefbmvwsVCWl1L8c53YDB2INxyMD5b4VEX4OlrpGisJ?=
 =?us-ascii?Q?qo5h5pLh7bZEQeNn2ndI+qKra6jk2N4AXvR2bWtNaCmI/xctaCfeRiKe1ZHk?=
 =?us-ascii?Q?z3B7Cg4VDO9rshVjtMB8MOO9XakrL4tPzN/jT4H6zSUSbGnBU7Xhx1q31SXr?=
 =?us-ascii?Q?Th5rmIVzvkQqSebpQGTbDuW2fCLwTbibUkz3uR2TKptb87HwQWxQ7gImpQ63?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c1676b-f98d-47a5-b590-08db1fdee0e8
X-MS-Exchange-CrossTenant-AuthSource: TYAPR06MB2239.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:10:32.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRyalMeAnV+Zm8j0niT9H0exHVosKt9wwMbqDE8iR2raK6wFuoIkxlA8nyPiK0hXh/p4ncQ2S/zunLO7PIM3lrwzfAXVss4V4ASouZw0qys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

  When multiple channels operate simultaneously, the common register shared by all channels could be set to an unexpected value due to race conditions on SMP machines, resulting in a disaster that DMAC cannot work from then on, therefore, a spinlock is added to avoid this situation.
  Take a typical scenario as an example, the execution sequence is as follows:
1. cpu 1 is executing the ISR function dw_axi_dma_interrupt() and axi_dma_irq_enable() has not yet exectuted completely, so the global interrupt enable bit INT_EN is still 0;
2. Thread A is running in another cpu and has completed the execution of axi_dma_ioread32() in axi_dma_enable() called by axi_chan_block_xfer_start(), and then the DMA_CFG register value (with the bit INT_EN cleared) is stored in the variable val;
3. cpu 1 completes the execution of axi_dma_irq_enable() and sets bit INT_EN of DMA_CFG register to 1;
4. Thread A completes the execution of axi_dma_enable() and configures the DMAC_CFG register with variable val which is stored in step 2 above.
  As a result, the global interrupt enable bit INT_EN in the DMAC_CFG register is eventually cleared and the DMAC will no longer generates interrupts, and the DMAC cannot work anymore unless the power resume process is triggered according to the current dmac driver.

Signed-off-by: Libing Lei <libing.lei@jaguarmicro.com>

---
Changes since v1:
- an example and more description for this patch
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 20 +++++++++++++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index bf85aa097..7aa53293c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -108,37 +108,49 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
 static inline void axi_dma_disable(struct axi_dma_chip *chip)
 {
 	u32 val;
+	unsigned long flags;
 
+	spin_lock_irqsave(&chip->lock, flags);
 	val = axi_dma_ioread32(chip, DMAC_CFG);
 	val &= ~DMAC_EN_MASK;
 	axi_dma_iowrite32(chip, DMAC_CFG, val);
+	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static inline void axi_dma_enable(struct axi_dma_chip *chip)
 {
 	u32 val;
+	unsigned long flags;
 
+	spin_lock_irqsave(&chip->lock, flags);
 	val = axi_dma_ioread32(chip, DMAC_CFG);
 	val |= DMAC_EN_MASK;
 	axi_dma_iowrite32(chip, DMAC_CFG, val);
+	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static inline void axi_dma_irq_disable(struct axi_dma_chip *chip)
 {
 	u32 val;
+	unsigned long flags;
 
+	spin_lock_irqsave(&chip->lock, flags);
 	val = axi_dma_ioread32(chip, DMAC_CFG);
 	val &= ~INT_EN_MASK;
 	axi_dma_iowrite32(chip, DMAC_CFG, val);
+	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static inline void axi_dma_irq_enable(struct axi_dma_chip *chip)
 {
 	u32 val;
+	unsigned long flags;
 
+	spin_lock_irqsave(&chip->lock, flags);
 	val = axi_dma_ioread32(chip, DMAC_CFG);
 	val |= INT_EN_MASK;
 	axi_dma_iowrite32(chip, DMAC_CFG, val);
+	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static inline void axi_chan_irq_disable(struct axi_dma_chan *chan, u32 irq_mask)
@@ -177,7 +189,9 @@ static inline u32 axi_chan_irq_read(struct axi_dma_chan *chan)
 static inline void axi_chan_disable(struct axi_dma_chan *chan)
 {
 	u32 val;
+	unsigned long flags;
 
+	spin_lock_irqsave(&chan->chip->lock, flags);
 	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
 	val &= ~(BIT(chan->id) << DMAC_CHAN_EN_SHIFT);
 	if (chan->chip->dw->hdata->reg_map_8_channels)
@@ -185,12 +199,15 @@ static inline void axi_chan_disable(struct axi_dma_chan *chan)
 	else
 		val |=   BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
 	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+	spin_unlock_irqrestore(&chan->chip->lock, flags);
 }
 
 static inline void axi_chan_enable(struct axi_dma_chan *chan)
 {
 	u32 val;
+	unsigned long flags;
 
+	spin_lock_irqsave(&chan->chip->lock, flags);
 	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
 	if (chan->chip->dw->hdata->reg_map_8_channels)
 		val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
@@ -199,6 +216,7 @@ static inline void axi_chan_enable(struct axi_dma_chan *chan)
 		val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
 			BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
 	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+	spin_unlock_irqrestore(&chan->chip->lock, flags);
 }
 
 static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
@@ -1420,6 +1438,8 @@ static int dw_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	spin_lock_init(&chip->lock);
+
 	dw->chan = devm_kcalloc(chip->dev, hdata->nr_channels,
 				sizeof(*dw->chan), GFP_KERNEL);
 	if (!dw->chan)
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index e9d5eb0fd..4a8db437e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -70,6 +70,7 @@ struct axi_dma_chip {
 	struct clk		*core_clk;
 	struct clk		*cfgr_clk;
 	struct dw_axi_dma	*dw;
+	spinlock_t		lock;
 };
 
 /* LLI == Linked List Item */
-- 
2.17.1

