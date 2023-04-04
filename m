Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334EB6D67A5
	for <lists+dmaengine@lfdr.de>; Tue,  4 Apr 2023 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjDDPkf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjDDPkY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 11:40:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84B640EE;
        Tue,  4 Apr 2023 08:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv2SWNSt9v5pyK7Ajip0+wuweo2Aanw1rjHbgo4wev7uK3D4OWvMxWS4n4g8hIfqphb6cHWFp85gyyh/fTLy+pSvn5wbgJBPjK/+Mr4VDyZxGSMMN4moWygeVIsbw5ehjtYj0gm2uPw+EoSviJWmDOGrHT1U/ffZUkfc9OUx0DRcMU8KnWlT4OkR/HR3qG3LMJ1duHlBUoHwIIuaAVkIsblKHel7V6iNg4rKfiCgl9EwJkqD1XUYjJ44u9ICIlfPX+u0V59WqqxS8fU6PYbpYYJMTpSwHUXNRkQePD+FwPJaylvEWYoWB2Gw3S5fkc6582VT7CVh1l3BR9AH/3ktUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evnzk9VnIIHYDzhuG43pmfQGOH8YTeQZwp5wDn7fxcI=;
 b=TxipSVVp5SX/VS9tZAwdSR8c8bsY4tos50VW8mqDSp8jXRwwkIXdFkMjASZV7FIalG91ZN86dJ2sQ58e9SZhv8CaXoOYcJeyASXKsvFj6c0GTnZR7Qrkd76aC7aKTt3ywSvi7HV5X+TKh2JKdaYyPesdu/N7BnbtmvG+gGpYx3STJT+xo7lZkTtlko+YT2jrD9H23l+QHezaxG61OsuOfkOAW3srVYYaRpem+kXGB4/IDc/PSNohNGAPeoz/bKmdrEXfAKlHhIuSbhJuUxJUCfHwWQGTc9p5TbrP5ij+wwcrlYYiPVizUoNe9piHrIiQ82M2m1AIryuO4YB0OkoCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evnzk9VnIIHYDzhuG43pmfQGOH8YTeQZwp5wDn7fxcI=;
 b=bB5klKfwXSzt8PQcIHmcgQiZsGALWTzupSE/I7+aDm7uIfpizQp/LJPVRVAjDILNXw1OwejnjobzTlt2KvoaOkWNKemSZ9B0nASCgPOQqfFbtgqWuzmZAA3VmJsFO2DpNV6AvYwndxA9e0Rz0Br/Aj/Bcc0k7TTyYm0YEXbzfSvutfFVbMhdkfc7z0hqVp3fTA9+CBX+jACOoqscPxtTcl4qVCsQzarKNppNL4RCbqS8AgwHeoLYV6NjwVAQs9iz/r72NFXSCbeD17XdmM0wIm4TgHEu0A8gwaGCtlTE1Z0kHBKP8LLlegID4ZG2ovbdKAEd6pyaDi7fEPnn5SLDzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SG2PR06MB2235.apcprd06.prod.outlook.com (2603:1096:4:7::18) by
 PSAPR06MB4408.apcprd06.prod.outlook.com (2603:1096:301:8e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.30; Tue, 4 Apr 2023 15:39:58 +0000
Received: from SG2PR06MB2235.apcprd06.prod.outlook.com
 ([fe80::cce3:aeb8:8d5:f7e]) by SG2PR06MB2235.apcprd06.prod.outlook.com
 ([fe80::cce3:aeb8:8d5:f7e%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 15:39:58 +0000
From:   Libing Lei <libing.lei@jaguarmicro.com>
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        yu.c.chen@intel.com, Libing Lei <libing.lei@jaguarmicro.com>
Subject: [PATCH V3] dmaengine: dw-axi-dmac: add spinlock for multi-channel DMA
Date:   Tue,  4 Apr 2023 23:39:45 +0800
Message-Id: <20230404153945.916-1-libing.lei@jaguarmicro.com>
X-Mailer: git-send-email 2.39.2.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To SG2PR06MB2235.apcprd06.prod.outlook.com (2603:1096:4:7::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB2235:EE_|PSAPR06MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8b901d-e02e-40e7-d64b-08db3522d89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWHYkEvd5xA8iW+D8tq4Ki1ffLtjY34pawCd63R6SyK/C0nBk06xBPyYnGFske+6NPfyN+aAa6J8kcY1cU0cWPurPo2B/jCUOKclKbCYiPgGns5BwAZZ0VhcKIUfpwaNG/ySIouoDyHizuFTgva8anqiq7juuiAWYAadAvA6ff0IVASHnvJ3fGp/ERdtBhWnDgupm8ZMiQcLp/6cJTqVmoBgMTIGSRFAMKedxXpTLTpGtKLx8Qt+OLvikdbUzTVwr+57geVJvvFNO3Bda8nX8cjzuFKDU3EYhVHKIxNG9gKx6p6EfAJYfD5lK0PQtYV4zrdi4gYcCsazFArhsN2GCMv9q1npUe0q7W3lMoIvugLfFDAEurAOy6Y7oXq/QVGe3Pl3JPod71rjZB3AtQ/uipostJynOZZy4ONXLG8DTksxOAZPvYnmKQNsUU2paV6F7yXASRF9cJL5jlAEn5sECXGz4P0cjm/Ipl//rhv3wm5K0eCxZ7wTqu8BTN6C5lf7yCw2goJMZ+HrIlRZAOGjgyxRXAP2NSMTV2aDWoz2aBYRUoXFVshN8IqmI9s6oR76ILAPnDunIZV0KUuOF+xKawQq88AqeEqfJRT7xSt9k2dNtWhlfIvTqZ6VIAQrl0V/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2235.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39830400003)(396003)(376002)(136003)(451199021)(478600001)(66946007)(66476007)(66556008)(8676002)(44832011)(316002)(8936002)(38100700002)(41300700001)(5660300002)(38350700002)(4326008)(6486002)(83380400001)(186003)(52116002)(2616005)(107886003)(6666004)(1076003)(26005)(6512007)(6506007)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B8BJlDve1TltIH3nT/1vqSTHQsKBcIRIFvyiRfZSkuM3uU5gfnr8pxiSWGTQ?=
 =?us-ascii?Q?yTOz9fhgtQj8/Vl7RVGZlxoUbWG8qEJ5sR/V2eKW9WjuU48xlMQ4tcIFyp3x?=
 =?us-ascii?Q?MdtEOaQHj/LTuZTv7/zwlVGFz2aGDj0rLd/fgVrPm0e/QxajccE73P4g65pr?=
 =?us-ascii?Q?0oz7IlVVuGuRa3srKBpbeU0kXQcO5Khw0xLaVC6ULlyfojcBv1gzvU/cLJMV?=
 =?us-ascii?Q?HOTu8tf4/f+bodKj93gMJabYCj1vW26gCXjuZ5G9qNSWFW6K6vZkvS9kWEXc?=
 =?us-ascii?Q?ge6Df0dw2SltZacvf+7nSS86yNXs/L0uRGbLH55dj88wlo1UoTmcgDTOhu1l?=
 =?us-ascii?Q?9T4Gc9ESETgp01QmpIhGuOpClh/7mho2QjfvLDYynoj1SSUyoIPsKw+IBny1?=
 =?us-ascii?Q?f78woi84DjjofLTV3RXJUs2F4oTIz60eTImYbtfe5g8r80rj0dOC7SlLFe7R?=
 =?us-ascii?Q?8nBc4N+t5rplM/EMlREus/fBs3V8jV28qqamSpObmKpYrQy6joAuhn7oTBCx?=
 =?us-ascii?Q?DyIxyRcC2P9r1afgSzknvuA6pZajDjotD6lBu67MNL+5Ltl8ynImtkWoUbBu?=
 =?us-ascii?Q?fR1aleW7Lkn8R24af9bMbjEAhgJVgeOHDxE5YwMt+39AUhkfoe4Sz80DnV6I?=
 =?us-ascii?Q?YW0xZOTxHhN9jsCeXO/AhtIhMmn2/D06COww+WNf4haXPsVX6hxiDzVkAAYt?=
 =?us-ascii?Q?DZChod7/Xr6gkYCbGaFPn+aio8O1Ql59TWGuzCE5J61QHFe4PkG5Z0oYC/1p?=
 =?us-ascii?Q?SHoTt5WZAhV+eUIxCPQ8OOogsALrKpliVyb9xcmhue5kJ5aDfAUue9I3pS5l?=
 =?us-ascii?Q?eDUKOhmzzczK26nPU0c04g+TkhePZNg0f8vLaex8TpHhKoWjYeIqcHYQNtxD?=
 =?us-ascii?Q?TT+1BZSx3m9omaTdDW4z3o8aAffnrl1dX/oL0OhPyGLT6OradoGESLD8zSRq?=
 =?us-ascii?Q?1J3BWwMAwq0V6p4aEo/08E6wxTvDnxNLBNM9r8m8DuaGLHTz+ZLO645+dDyY?=
 =?us-ascii?Q?mtKp0AGRHb2WN9jRs6GDRHE1hhJZ+bwAMxGEOnerBoEBaiFy72W3VlEybd7u?=
 =?us-ascii?Q?FJwfJsrwjvKc5VeKEM9lXTQ1/Qpl4kGdECpKyfuY3qeGUxdRXgxlhO5fV0gV?=
 =?us-ascii?Q?REBD7BTwVL7Me+gTyP2JnGbrE3rHPYniPmK2/6RtfDdLDyWnDNBhF4SQIE3X?=
 =?us-ascii?Q?JZnPLQ5qtcEsn8aYeod6JxX1qLibY02Oc97b6Ovd3XEx9hJuLRrGaOHtlnvR?=
 =?us-ascii?Q?Z7j8BGCAfBN3mXFNkQx8QAyqPR77YVTfGdRIDw7Q3so1LU70EM9XOLp1TfTI?=
 =?us-ascii?Q?wFJWjZrG0OAjvd9ajeHRIDdyVC2PTTz+1GHD5+MjgjOEyJc/O9fXdHYMkr/E?=
 =?us-ascii?Q?44f6UVEPXtkzUO6UAJILkR0+ilnjPNJXjvX3SCBKvr3kXNsgpZhxJT3t0G8q?=
 =?us-ascii?Q?gjcsU9iegRn4qnwshOGr6lriXMtRuLSHjhsxZMU6G8acUDHVeOXXRRnT9nb3?=
 =?us-ascii?Q?6XZpKSp3D2r1C3RkMyiFYizbgPK69/v1VTYyST4JiBrV5EGitqoyq7Gn+q6U?=
 =?us-ascii?Q?grV3ZKHTx1E9fslHlFfakn0y4y6V7EHBqxd5ZUsjFGthoyXsStSPnKrsV4/n?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8b901d-e02e-40e7-d64b-08db3522d89e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2235.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 15:39:58.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyUSD+tmrXMZLumeKg3C/oksO4rxnSB4/9yR5D1w7W7k+i/xGoFjra92xtvdjjCdQyhGKmh8UYETa87NkEzdUyRsks5pVRnE/eQsmeSn7w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4408
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When multiple channels operate simultaneously, the common register shared
by all channels could be set to an unexpected value due to race conditions
on SMP machines, resulting in a disaster that DMAC cannot work from then
on:

cpu0                            cpu1
 dw_axi_dma_interrupt()
  axi_dma_irq_disable(chip)
  ...
                                axi_chan_block_xfer_start()
                                 axi_dma_enable()
                                  val = axi_dma_ioread32(chip, DMAC_CFG)
  axi_dma_irq_enable(chip)
                                  axi_dma_iowrite32(chip, DMAC_CFG, val)

As a result, the global interrupt enable bit INT_EN in the DMAC_CFG
register is eventually cleared and the DMAC will no longer generates
interrupts.

The error scenario is as follows:

[ 63.483688] dmatest: dma0chan1-copy: result #18: 'test timed out' with
src_off=0xc2 dst_off=0x27b len=0x3a54 (0)
[ 63.483693] dmatest: dma0chan2-copy: result #18: 'test timed out' with
src_off=0x239 dst_off=0xfc9 len=0x213a (0)
[ 63.483696] dmatest: dma0chan0-copy: result #19: 'test timed out' with
src_off=0x5d1 dst_off=0x231 len=0x395e (0)

a spinlock is added to fix it up.

Signed-off-by: Libing Lei <libing.lei@jaguarmicro.com>

---
Changes since v2:
- fix commit message

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

