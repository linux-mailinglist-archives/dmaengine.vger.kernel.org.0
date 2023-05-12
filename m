Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF27700A1B
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbjELOQA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbjELOPv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 10:15:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4801492C
        for <dmaengine@vger.kernel.org>; Fri, 12 May 2023 07:15:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba6388fb2fbso7310563276.1
        for <dmaengine@vger.kernel.org>; Fri, 12 May 2023 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683900932; x=1686492932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghbGq9THJREEhkrSIStzO+A3rtDBCJPDalH7s9571pA=;
        b=vF0Us9UlMXGLXLj1s1tWk3AyVw8tBCXUEnr9XNTtQ8N7JaOIqkdLiflH0w9EI9IaKU
         6scnMtkiKb8kdFRAbRJ8uxb3wv8c6l6s7HCInpDhGo+HHup+aVHJfh4DVLtoEXs8+qni
         31D/glRmakh4+sRhXNpuME3k1C7c6RRwKOgO3Ge3+dpvH6Q/HAPQnxd2uQd/C0VpSRN8
         uX7KyG2x8Krb+3eoDO31JgPReMPbtHBoNpgSOMel1zh64Cr/kYop3aOITI3teaPF++Vz
         /HbNprO+LkKJ90JAZ3vjXe1sy8vKkJEPoTgkCpGzg2tNwx4lnwcWwdQFQYzSE446QO5S
         QX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900932; x=1686492932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghbGq9THJREEhkrSIStzO+A3rtDBCJPDalH7s9571pA=;
        b=cGq3B1YI1R0trWIyQj3mv2BlshOlr8x9/bB3SZ1sCdnXzLjUi3Jm9HQCnp6RRsngqG
         +C7UIawTJ4W1A1g/iPLEmrxDwfYBPioS5v4f28zQO8otmd+rGOIDFBJNJKjPiQzeFqz6
         RpIy10D4UQTeYFzxidqUTLPxa5IWBfqYQXnpHK1nzVL/s7ycwWQIX3bXmOu2oO0+mXDV
         IXFjVZyhbu8LJ+s+HC6W614qgpZr9jjYGm7RI/G+n3/87O3DdC1yw0v2gvEYVBWXjRDF
         B904Pp7xsnGk39DfWSVjDhrUu79QzHqt4Dj2HmkrOCfz1JIWwCw3Ou+JbjlS6m4IeTvg
         hRkw==
X-Gm-Message-State: AC+VfDzkQPtdBtPPcoTBOlDOUAElUZIvxno8/m1ytCEnKhyhfdNLvREP
        iKRZeaC+oVbcx5Mlp4F97hkuNnzIVBqp5Q==
X-Google-Smtp-Source: ACHHUZ5n4GOwp+yXNZiY6lRiLp1LINyIY9W5VlLM4zkXtJJ0m6OA3RidwExCa/CyBYADnz8F1YZwsAkCUT1AKw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:c7d0:0:b0:ba7:1cea:ee12 with SMTP id
 w199-20020a25c7d0000000b00ba71ceaee12mr954256ybe.12.1683900931853; Fri, 12
 May 2023 07:15:31 -0700 (PDT)
Date:   Fri, 12 May 2023 14:14:45 +0000
In-Reply-To: <20230512141445.2026660-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512141445.2026660-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512141445.2026660-7-joychakr@google.com>
Subject: [PATCH v2 6/6] dmaengine: pl330: Use dma singles for peripheral _dregs
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use DMA singles in a loop to load/store data to the peripheral for
the remaining bytes left after chucks of bursts are done, which is
handled by the _dregs() function.

If the transfer length is not a multiple of (AxLen*AxSize) then the
_dregs function takes care of setting up CCR with residual burst
required to complete the transaction. It does so by changing the
AxLen in CCR and 1 burst of Load and Store.
But some peripherals might not set the burst request signal to the DMA
controller since the number of bytes to transfer is less then the
initial size of burst requested i.e. AxLen*AxSize leading to a forever
wait.

Example of such a case :
    Considering a peripheral having an RX FIFO of n bytes and a sw
    configurable threshold level logic which drives the RX burst req
    signal to PL330 i.e. when data in the RX fifo crosses the threshold
    value the peripheral asserts the RX burst request to PL330 to copy
    data from the fifo in bursts.
    Taking an example say the Rx Fifo is 256 bytes in depth, the max
    AxLen is 16, max AxSize is 4bytes and 304 bytes had to copied from
    peripheral to memory.
    In this case the peripheral SW driver would configure the threshold
    to the maximum possible burst size (AxLen*AxSize) i.e. 64 bytes and
    pass the same to pl330 driver using src/dst_maxburst variable.
    PL330 would copy the first 256 bytes with 4 burst transactions and
    the 48 remaining bytes would be handled by _dregs().
    Currently _dregs() would setup a burst for AxLen=3 and AxSize=16 to
    copy the 48bytes but since 48bytes is below the threshold configured
    at the peripheral the Rx burst request signal would not get set
    leading to a forever wait and timeout.
    This logic will copy the remaining 48bytes using single transactions
    of 4bytes each which would not depend on the burst req signal from
    the peripheral.

Instructions generated for above example with logic change:
    DMAMOV CCR 0xbd0239
    DMAMOV SAR 0xffffe000
    DMAMOV DAR 0xffffc860
    DMALP_1 3
    DMAFLUSHP 0
    DMAWFPB 0
    DMALDB
    DMASTPB 0
    DMALPENDA_1 bjmpto_7
    DMAMOV CCR 0xad0229
    DMALDA
    DMALP_0 11
    DMAFLUSHP 0
    DMAWFPS 0
    DMASTPS 0
    DMALPENDA_0 bjmpto_6
    DMASEV 3
    DMAEND

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/dma/pl330.c | 65 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 46e254fd4007..2145f601939e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1208,6 +1208,67 @@ static inline int _ldst_peripheral(struct pl330_dmac *pl330,
 	return off;
 }
 
+/*
+ * Sets up transfers to peripheral using DMA Singles instead of Bursts.
+ * Data is moved between fifo and memory in bursts following which it is
+ * loaded/stored to peripheral using Loops of DMA singles based on
+ * transfer direction.
+ */
+static inline int _ldst_periph_single_dregs(struct pl330_dmac *pl330,
+					    unsigned int dry_run, u8 buf[],
+					    const struct _xfer_spec *pxs,
+					    int src_length, int dst_length)
+{
+	int off = 0;
+	unsigned int ljmp, lpcnt;
+	struct _arg_LPEND lpend;
+	enum dma_transfer_direction direction = pxs->desc->rqtype;
+
+	if (direction == DMA_MEM_TO_DEV) {
+		off += _emit_load(dry_run, &buf[off], ALWAYS, direction,
+				  pxs->desc->peri);
+		lpcnt = dst_length;
+	} else {
+		lpcnt = src_length;
+	}
+
+	/*
+	 * Use Loop Cnt 0 to load/store from/to peripheral in single transactions
+	 * since Burst Req might not be set as pending transfer length maybe less
+	 * size of bytes to burst (AxSize * AxLen).
+	 */
+	off += _emit_LP(dry_run, &buf[off], 0, lpcnt);
+	ljmp = off;
+
+	/*
+	 * do FLUSHP at beginning to clear any stale dma requests before the
+	 * first WFP.
+	 */
+	if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
+		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
+
+	off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
+
+	if (direction == DMA_MEM_TO_DEV)
+		off += _emit_store(dry_run, &buf[off], SINGLE, direction,
+				   pxs->desc->peri);
+	else
+		off += _emit_load(dry_run, &buf[off], SINGLE, direction,
+				  pxs->desc->peri);
+
+	lpend.cond = ALWAYS;
+	lpend.forever = false;
+	lpend.loop = 0;
+	lpend.bjump = off - ljmp;
+	off += _emit_LPEND(dry_run, &buf[off], &lpend);
+
+	if (direction == DMA_DEV_TO_MEM)
+		off += _emit_store(dry_run, &buf[off], ALWAYS, direction,
+				   pxs->desc->peri);
+
+	return off;
+}
+
 static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
@@ -1273,8 +1334,8 @@ static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
 	case DMA_MEM_TO_DEV:
 	case DMA_DEV_TO_MEM:
 		off += _emit_MOV(dry_run, &buf[off], CCR, dregs_ccr);
-		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs, 1,
-					BURST);
+		off += _ldst_periph_single_dregs(pl330, dry_run, &buf[off],
+							 pxs, src_length, dst_length);
 		break;
 
 	case DMA_MEM_TO_MEM:
-- 
2.40.1.606.ga4b1b128d6-goog

