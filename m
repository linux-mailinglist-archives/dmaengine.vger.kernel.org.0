Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FFE6A5A83
	for <lists+dmaengine@lfdr.de>; Tue, 28 Feb 2023 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjB1OFL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Feb 2023 09:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1OFK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Feb 2023 09:05:10 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2073.outbound.protection.outlook.com [40.107.117.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED96222DF3;
        Tue, 28 Feb 2023 06:05:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc1CEwiMzafz5mQ5GC+Bxb2XKvoL7uC/BrA/u93tknfnFUjC1WGRtjT1Qy5jEeKsVQdHvRj0Y52f7l2pPIbe55Pg4G645gqdX9xyUY0bcpWph/a3juS8XvRSgCjs8oYUxdsAO6IqJHdLNg3+eskfGTdToNCfEf3LFK8bkwXGofDR/3GLs2USBtgCm8Ja/xkant0pEZfgRlCekUCF0HiEV65Kv6nuHLYH2I8pxcC7699qptaaRDBuDlmCGRW40dQbJcYiW5fmInFe3I6c8HDEs6D6V/S2C2qejHE8PAF4/cZAy9Ava7cB4e7NgWLk47fFp5lQGKyaHedzni1pv+7K1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G0eOG4OdgyMUu7ORNn67YHtkJrZlr0Ww9/NhkqVeLc=;
 b=Umtld18uPW0Ti88HpmDDeSrryPJCuq6PucwRpyk+ICQOKxwNrNZjRFCKKpMyyveyXmBN3DZ8gakVUJW4si0DfAXO5SqAxo8Cm2c28iRLH6BZQ7Hi+dppnGMZ6OtHcNedL+GJ7/65HGJTSE0+1zR78wdq5RGxXAHpII4cJOxJ1lFIjxdbhlwdovyLw/1ACxnHk36Bl86XB4aiC7qsshSdn4pTHhEEi2IWRCTUM3Owa9TNRLHdowtBVH81lpHeRZMlAnjfprdc6Wf1unZr9sYlO4IFsh4NtmZRO+lZDcIYxiDhdE3ub4+7Ven3a2tPqUy86gup2TVHq1qUr6RKIXO5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G0eOG4OdgyMUu7ORNn67YHtkJrZlr0Ww9/NhkqVeLc=;
 b=afNg+czHTenoVILMGIZp2K2ODkp8+OAacR2THY6RnvN+dETItPx735TPQZzIdOrjk9fDui+2iyO6rWVATmmgMWaRVBPiv9BfPMXgYgk66H9wwACUl+ulGIufqGqGQBxJYCJaznxS/6oWWYcC3gMKXnsL8LhJu3FwQN9dwla/pHJ5qQM4B+GiD9M3oqqhgqMo7BQlJ6CUMJH+5gJoUKmHLn/AhTAS3zxUoh/HtS2PNj63Xl50sI7DOeB9EqnDYNJPR1WXh8DPgAkeB//15nbJR9CLwquISMu/HHcj966d6Yo1+NrPqsBr6zO2vmQHV/+nAX+1B09xy4NGmAhaOHku7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYAPR06MB2239.apcprd06.prod.outlook.com (2603:1096:404:21::20)
 by SI2PR06MB5410.apcprd06.prod.outlook.com (2603:1096:4:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.12; Tue, 28 Feb
 2023 14:05:02 +0000
Received: from TYAPR06MB2239.apcprd06.prod.outlook.com
 ([fe80::43d2:8dd6:854d:3ef0]) by TYAPR06MB2239.apcprd06.prod.outlook.com
 ([fe80::43d2:8dd6:854d:3ef0%4]) with mapi id 15.20.6134.006; Tue, 28 Feb 2023
 14:05:02 +0000
From:   Libing Lei <libing.lei@jaguarmicro.com>
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Libing Lei <libing.lei@jaguarmicro.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: add spinlock for multi-channel DMA
Date:   Tue, 28 Feb 2023 22:04:49 +0800
Message-Id: <20230228140449.942-1-libing.lei@jaguarmicro.com>
X-Mailer: git-send-email 2.39.2.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To TYAPR06MB2239.apcprd06.prod.outlook.com
 (2603:1096:404:21::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAPR06MB2239:EE_|SI2PR06MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e999cd3-0d51-49f2-0a3e-08db1994c8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzpMfCNtJldnwIrNiS/I02RZldavAp4HbkYfuHROGKdWywmlYUCerA9MSP3dm50KqdJpT+EkbB+q5MOYggKgRu8O2F69U6VOS6LsA6bR0TJUCCbzABFwvnDvqIJQILm8JMMUtTZz55ELfoFIgT+SBqa0jOdK6jgI/3v8myezUQffh3kAJa7USnSkfI6m1aUlbXDun7Az9pgNX1R6o36KsDO3T2fZ1/TJfnva9qk29fnjl8VRrfkYqnfHfuTjKuMDjIRKu2q7s1cwthaJ+nPXqK1SyRjN5jHgAPPJPApaYW2leFc+H+47GWW1mpKG27qxkyPBvLg1ordm1jDOtHbZjR1SCBiy7Gse3nDl4HtzFnaF3crl6Inlj0CHTt9HezDAY4rVnROIriLxWsEejgMuN6vEISoxpS10XnNOeUnxPCTsBZo9hBiCE4IrJ1CTiTyOCoWigIreb8qWlsf1Ug6yHq3aTRLEFNfrVWjQPJ4SZJ33btddYPLUVi5gx2bo8qF8JBEKRHMbkzty38FX48b6YFP3YBCVo6bhXejtoaZMMYFiiL9l+/KE/uFYGkKieXpONs0LTkFI2JW16Xx11Fgp5AvDuQQHN4MKz0z+7PIUvFlCSjfqBnA/AVIVFw+PXr4fw8k11QYcfvWHAGp3v1Qko2j+CeJjWrbovVa/7o4FBD3dRSb6UVDhIFkQaiun4OyJhvL5CptOeacDLyN0y9WWsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR06MB2239.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(39830400003)(396003)(366004)(451199018)(86362001)(36756003)(66946007)(66556008)(66476007)(41300700001)(8676002)(5660300002)(8936002)(4326008)(2906002)(44832011)(38100700002)(38350700002)(52116002)(6666004)(107886003)(6486002)(478600001)(316002)(83380400001)(2616005)(186003)(6512007)(6506007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVVnioBRUBVrt7y4LZSiFkSX9AVPzAMBzW+I8XQVKH6HWE1XfcXqaXs2O7R+?=
 =?us-ascii?Q?NOvNd0Nuv3Frvu71blSzP/NFy46lSA8W8+ZDVFabMsjA+RJjefQ9tR1hgAuM?=
 =?us-ascii?Q?vZQda0FpbgO0VdUvLviKLYKpfPp05SvVwjEnD43xy3/aE9wmEp+/pjBNHJ4p?=
 =?us-ascii?Q?jkpwGhUuXAWNJUdMFrvO8mB2FnH480kXSBVV+QG2F6rvYInaTwq0XtI3kEOc?=
 =?us-ascii?Q?8F1aQQFX/3Z90yi+BFi5EEMyUnpO9xUf6RIeENmrTBZwmtRpbJv74aZEe+yr?=
 =?us-ascii?Q?Lav3WfZ6QxppWKksW2yoDjn/GAKx74swpYeiyeb0tgfStpPI+4ys8ZpTgs2Z?=
 =?us-ascii?Q?RqotZ5z/N9UccZAQ6i/3FzZN6u/p6X+sdjU/fDuO2CZyELxGuXbql0CEVz8R?=
 =?us-ascii?Q?HL13Gf4vEIO+EVjk86ji38DVy2srWNBIsjOT7WdscQAXYrxUWho/upG5yUvX?=
 =?us-ascii?Q?NUBYTY40NAvNbPOx+GZseV04YbPsawlvLeXfzj8ZfMAt1gHtpqXaWxmX0Vxl?=
 =?us-ascii?Q?fSaRxUl3sB7hNQmlwP609dvhMpF0+8V8+YQj0JNPI6kLrsp6SE+fee6Mj8uL?=
 =?us-ascii?Q?uYPcHH16+4BILOu7lRozcjb1c2QmjygHX0kfpGwEF2FFvCRMOH+YrOf9XMqX?=
 =?us-ascii?Q?o45YD8xzbC6R73J1iVIcK45/luiIqomByiC7rhPeZH6iAweUC7jhHtmBGjsY?=
 =?us-ascii?Q?arAuxWDz4mJJ0qNWLIc2t1cX3DnpEpYpM6q5uTMaVgJXpBJ/xSyLOQqtfOFU?=
 =?us-ascii?Q?8+nZ2C7EcO4bhTnRA6K32bSac/Znv/4QNGVafsF4EBsb5zt3cZCGHQI6IHz8?=
 =?us-ascii?Q?kxnZxsSTkrH+yNdM2SxvVn/es9UHGfY9Gy0wluRITnB3iL7WHoQRNwhsYl+v?=
 =?us-ascii?Q?ZIap+NoKQ9bFRdMb1r2u+VTyJ1rB2/MsJ70/WkSpkmiibe8/TYRLbU9yRj2k?=
 =?us-ascii?Q?8atfX1PzU7re2VLvJidU20pnqNMqZeissQF+v1Nkc2rHJCnS+TpxKn4CjL7F?=
 =?us-ascii?Q?JJ3jkvSYQIcxt2f2faB121gFWbwCxigrC552Xn1MgiMcyiZsQwFa+Rcp781J?=
 =?us-ascii?Q?kQFE/E8dJ1EPv6IXM1RwblBKobCc5slMehhkr5uTsfOkN4Ysk58KqaXmXu6p?=
 =?us-ascii?Q?jwc6BmHCUbRbMjuzYKW3H041KfNxkHUG24Zpn0+3QOQaBPz+Xnp1e0JBNi8Z?=
 =?us-ascii?Q?eOvOQvF6XxthzWbEuT0vd0FO2T4K7SV4woY02T4vskxtx3R+gH2vN6FE1FCK?=
 =?us-ascii?Q?+sLlXmJGrj6iKrIoh9ePsr4dz6P15Uj+w26d3TG5BomH0P5bMAXZ2SyYZfgf?=
 =?us-ascii?Q?kOYnEZTt+IT8RjwgsLVNfIXR5lFVqUEUu/UwW/tmhL7h0P0BacCytWuZJo18?=
 =?us-ascii?Q?Mw+a4UEKwYOhLZ6pCv2SQPvwLbXt4eBdJsJovh9Fet3FegqZBxbbeM2ru/5W?=
 =?us-ascii?Q?bw+IGIoym+N3RLlv4vddpn5Ck+6t6uzg4eKvZ4H9kdDdINebPnLvJk6dSdIv?=
 =?us-ascii?Q?M6uHdlYCpg9O5aR0n0r7VWnRTmqw2zBMuNYf/0pX/AlqbFBDlOcmTVezsAu1?=
 =?us-ascii?Q?0EXcWt70aZbKxhQNb1jcrAd3PE/PisoLnLsJdEJwgLo5QO8EZiGPa36bOW/O?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e999cd3-0d51-49f2-0a3e-08db1994c8fe
X-MS-Exchange-CrossTenant-AuthSource: TYAPR06MB2239.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 14:05:02.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+O+VNbSFPQ466G5lzh8wKoB2T3Y8TF9AQoG0ee8rZbq2i3D0v28iPaGs4XedUF+eZHgWLIgji1QQAtg8yn7mM2jtkfiOPvcTz0nsgcQkvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5410
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When multiple channels operate simultaneously, the common register
shared by all channels may be modified to an unexpected value, hence
a spinlock is added to avoid this.

Signed-off-by: Libing Lei <libing.lei@jaguarmicro.com>
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

