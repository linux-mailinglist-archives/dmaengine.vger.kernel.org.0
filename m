Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897DC69AE18
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBQOaq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 09:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjBQOap (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 09:30:45 -0500
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Feb 2023 06:30:43 PST
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 944DC5ECAA
        for <dmaengine@vger.kernel.org>; Fri, 17 Feb 2023 06:30:43 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id T1dgpDEZkPPaiT1dhp5Tkn; Fri, 17 Feb 2023 15:23:08 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 17 Feb 2023 15:23:08 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: Reorder fields in 'struct dma_slave_config'
Date:   Fri, 17 Feb 2023 15:23:00 +0100
Message-Id: <7ea34ff257633d9a1eeac77dd00616fb24429c4f.1676643752.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct dma_slave_config'
from 72 to 64 bytes.

This should save a few bytes of memory and a few cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct dma_slave_config {
	enum dma_transfer_direction direction;           /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	phys_addr_t                src_addr;             /*     8     8 */
	phys_addr_t                dst_addr;             /*    16     8 */
	enum dma_slave_buswidth    src_addr_width;       /*    24     4 */
	enum dma_slave_buswidth    dst_addr_width;       /*    28     4 */
	u32                        src_maxburst;         /*    32     4 */
	u32                        dst_maxburst;         /*    36     4 */
	u32                        src_port_window_size; /*    40     4 */
	u32                        dst_port_window_size; /*    44     4 */
	bool                       device_fc;            /*    48     1 */

	/* XXX 7 bytes hole, try to pack */

	void *                     peripheral_config;    /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	size_t                     peripheral_size;      /*    64     8 */

	/* size: 72, cachelines: 2, members: 12 */
	/* sum members: 61, holes: 2, sum holes: 11 */
	/* last cacheline: 8 bytes */
};

After:
=====
struct dma_slave_config {
	enum dma_transfer_direction direction;           /*     0     4 */
	bool                       device_fc;            /*     4     1 */

	/* XXX 3 bytes hole, try to pack */

	phys_addr_t                src_addr;             /*     8     8 */
	phys_addr_t                dst_addr;             /*    16     8 */
	enum dma_slave_buswidth    src_addr_width;       /*    24     4 */
	enum dma_slave_buswidth    dst_addr_width;       /*    28     4 */
	u32                        src_maxburst;         /*    32     4 */
	u32                        dst_maxburst;         /*    36     4 */
	u32                        src_port_window_size; /*    40     4 */
	u32                        dst_port_window_size; /*    44     4 */
	void *                     peripheral_config;    /*    48     8 */
	size_t                     peripheral_size;      /*    56     8 */

	/* size: 64, cachelines: 1, members: 12 */
	/* sum members: 61, holes: 1, sum holes: 3 */
};
---
 include/linux/dmaengine.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c3656e590213..61e1d1da4446 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -390,6 +390,9 @@ enum dma_slave_buswidth {
  * legal values. DEPRECATED, drivers should use the direction argument
  * to the device_prep_slave_sg and device_prep_dma_cyclic functions or
  * the dir field in the dma_interleaved_template structure.
+ * @device_fc: Flow Controller Settings. Only valid for slave channels. Fill
+ * with 'true' if peripheral should be flow controller. Direction will be
+ * selected at Runtime.
  * @src_addr: this is the physical address where DMA slave data
  * should be read (RX), if the source is memory this argument is
  * ignored.
@@ -415,9 +418,6 @@ enum dma_slave_buswidth {
  * loops in this area in order to transfer the data.
  * @dst_port_window_size: same as src_port_window_size but for the destination
  * port.
- * @device_fc: Flow Controller Settings. Only valid for slave channels. Fill
- * with 'true' if peripheral should be flow controller. Direction will be
- * selected at Runtime.
  * @peripheral_config: peripheral configuration for programming peripheral
  * for dmaengine transfer
  * @peripheral_size: peripheral configuration buffer size
@@ -436,6 +436,7 @@ enum dma_slave_buswidth {
  */
 struct dma_slave_config {
 	enum dma_transfer_direction direction;
+	bool device_fc;
 	phys_addr_t src_addr;
 	phys_addr_t dst_addr;
 	enum dma_slave_buswidth src_addr_width;
@@ -444,7 +445,6 @@ struct dma_slave_config {
 	u32 dst_maxburst;
 	u32 src_port_window_size;
 	u32 dst_port_window_size;
-	bool device_fc;
 	void *peripheral_config;
 	size_t peripheral_size;
 };
-- 
2.34.1

