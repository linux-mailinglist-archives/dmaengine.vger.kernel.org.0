Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D61B6F6E7A
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjEDO73 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 10:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjEDO7G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 10:59:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A411D44A9
        for <dmaengine@vger.kernel.org>; Thu,  4 May 2023 07:58:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-556011695d1so7667117b3.1
        for <dmaengine@vger.kernel.org>; Thu, 04 May 2023 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683212309; x=1685804309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyjCHPBh44PN3ytyHlUnOM1ASgpqY1cxsBMty1tbu/M=;
        b=h2Q3dtiMAz5jAvOjfEHVY9ZA7j1QyQ6803OyYx4Pu17ci2sEWteu8ncbtegLvhtM3z
         zyOk45a71QSLyNnKQBRHprHb1Rw2yijPAd2tX+coUVnx6V8L7uorPPpiAeEpgE98A+Ee
         5PwjCttFi/znmNl1oOtlqvba5bv7IZRJ+4WBDirEtT5NCvZSA+kbf6z3fuG+jykVqSKD
         HbxYGUWJN5+PFHCdQoAJFjiw2njnbj/M3wglMj0/2MWH7CqQ2RlYoCKR8k+iWiGmNRvD
         PY9ry6L9MoT87ezIzwLA0UUivnN8NagCOnQOmTyiG5z1xM1Fzh+eaGCTe6laa5VQzCdd
         3X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212309; x=1685804309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyjCHPBh44PN3ytyHlUnOM1ASgpqY1cxsBMty1tbu/M=;
        b=Gj8qw+qYYYsqHYajvqNH6KY6K7RIByMKRtwQme2r6ai+AiKvsGhLGUq5byhGxUXorC
         UIlKhyjMeqoEsAVA4ZVLoek7bPp3dYRfFySpiUDlS3IbOiLgVynB8CfqDzZGci1UxZDC
         KG//p+19buvXLX+8RJGFMHTj6gSuthEq2oK/A3bw49YNALWjH2dyOpAt0QXMaNVQN/zS
         THP/v/IsrtntF3D68QCARdy2Z9m+tjNi51fUzwl+/X6mQ/Y5GxvTGa0c0LniBgniQX21
         8W8YO3FiZSVkHMt5y4NtkKtxCTs6gytBvCOQH4T0z4k8znRON198g0rlpS4KLesRZk4D
         MT1Q==
X-Gm-Message-State: AC+VfDxUuXMp7N2mJThh3mGwGX1BuNUof67KmRCITxdTIp4lAtsrCh2t
        CAIQAov+1DrwcfZBQ7vg7xIu8hqmqQpSOQ==
X-Google-Smtp-Source: ACHHUZ5BMZeZjQNr/gvWsVnq9rcpIvfwCumLLTCq6TEDVAAacoRXILpdcbvGImnMWO7kwHpXUjQHla0C0g3kdA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:ad21:0:b0:54f:a60c:12eb with SMTP id
 l33-20020a81ad21000000b0054fa60c12ebmr1423741ywh.1.1683212309438; Thu, 04 May
 2023 07:58:29 -0700 (PDT)
Date:   Thu,  4 May 2023 14:57:36 +0000
In-Reply-To: <20230504145737.286444-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504145737.286444-7-joychakr@google.com>
Subject: [PATCH 6/7] dmaengine: pl330: Quirk to use DMA singles for peripheral _dregs
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add quirk "arm,pl330-periph-single-dregs" to use DMA singles in a loop
to load/store the remaining bytes left after chucks of bursts are done
which is handled by the _dregs() function.

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
    This quirk will copy the remaining 48bytes using single transactions
    of 4bytes each which would not depend on the burst req signal from
    the peripheral.

Instructions generated for above example with quirk set:
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
 drivers/dma/pl330.c | 74 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index b4933fab8a62..0b4e5390bace 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -36,6 +36,7 @@
 #define PL330_QUIRK_BROKEN_NO_FLUSHP	BIT(0)
 #define PL330_QUIRK_PERIPH_BURST	BIT(1)
 #define PL330_QUIRK_OPTIMIZE_DEV2MEM_AXSIZE	BIT(2)
+#define PL330_QUIRK_PERIPH_SINGLE_DREGS	BIT(3)
 
 enum pl330_cachectrl {
 	CCTRL0,		/* Noncacheable and nonbufferable */
@@ -524,6 +525,10 @@ static struct pl330_of_quirks {
 	{
 		.quirk = "arm,pl330-optimize-dev2mem-axsize",
 		.id = PL330_QUIRK_OPTIMIZE_DEV2MEM_AXSIZE,
+	},
+	{
+		.quirk = "arm,pl330-periph-single-dregs",
+		.id = PL330_QUIRK_PERIPH_SINGLE_DREGS,
 	}
 };
 
@@ -1213,6 +1218,67 @@ static inline int _ldst_peripheral(struct pl330_dmac *pl330,
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
@@ -1278,8 +1344,12 @@ static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
 	case DMA_MEM_TO_DEV:
 	case DMA_DEV_TO_MEM:
 		off += _emit_MOV(dry_run, &buf[off], CCR, dregs_ccr);
-		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs, 1,
-					BURST);
+		if (pl330->quirks & PL330_QUIRK_PERIPH_SINGLE_DREGS)
+			off += _ldst_periph_single_dregs(pl330, dry_run, &buf[off],
+							 pxs, src_length, dst_length);
+		else
+			off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs, 1,
+						BURST);
 		break;
 
 	case DMA_MEM_TO_MEM:
-- 
2.40.1.495.gc816e09b53d-goog

