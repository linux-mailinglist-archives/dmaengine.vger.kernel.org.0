Return-Path: <dmaengine+bounces-9699-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKFqJMxDx2mSUwUAu9opvQ
	(envelope-from <dmaengine+bounces-9699-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 03:58:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C95E34D1D1
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 03:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0A55304F03C
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AA534F47E;
	Sat, 28 Mar 2026 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czpNJrrL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBD35F17B
	for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774666638; cv=none; b=RgYP1t01oJMONKnnVm22B2PQXq25vIOUuRaml+8LGxC0P62wtaWyXJLULRVhxWk6jePpivCkG3sFLAF3Rg5gIC2YwUCFdR2RIc+Me41HQu0jaHBSBTOO3lzpIMfEKuuxOj9LakAQFnOh9es9/l67SuVmPELpsS/48sGKgtYK0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774666638; c=relaxed/simple;
	bh=NvEtr+90tB0qd5+OHRXT3Y17wsy8kcUj03stEOobNUI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZ0xzFftutaVDY8hYopiI38rLkvi/s1ai26DnviI+XWGHHuLIE9RwbyLNi27UARkFgpBE4A8Y09Gths7DmYmT2kj0D3t8yjyIoheSyX78iDBlLb+3vEGl9zsCH9bHvp+rkVs6124ujsmz13LUpnbpytbltMfovj502rWNoREKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czpNJrrL; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso31234a91.2
        for <dmaengine@vger.kernel.org>; Fri, 27 Mar 2026 19:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774666635; x=1775271435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyXGUv9qxBwGD2kiWjCxiVzNXgplzS5mmRBmtQ+eUqY=;
        b=czpNJrrLL6DiKWw74/NkJ7YSroCE05uANVK/F63I5EGgSbfnF7tTx40eBMJS+kplaH
         nG5hebW7rqNk85AL8+J/RinHPrVV614fRO2Xz6bl7/F3m2EEtkSir6T+xJcFBjiqQS/J
         VllA9XnEhsYoMh4u9yBugV9ro1sAU8Rn+ZJFjRj0JJz/Pfgz49ShWlWO9DIqQiDEN8Zq
         D7zdzt5aJgoVEXXuR/+ZkLOfPCjNvpPEdr/qzCFIi4ZrKXU7ZAaLD8rNhU9LRvM8XLEk
         7yqwaFa7okZuvTFx8PPfpkpJdzsbyF18NVihJ6UceJaYUaFLLZmOfUmk9vH2nPpm5OVf
         sHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774666635; x=1775271435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xyXGUv9qxBwGD2kiWjCxiVzNXgplzS5mmRBmtQ+eUqY=;
        b=rfxxatCuGNd5DcsL5iDzQ9FavnYFLRXPmxPqpJvvFhjMbV1UqKL713YZbqDr3zMyYd
         xsx3kb6X8Z9n5RnIJwKWMdMCjjo036OrheB57qsTrSEcjRDwXGHiF32/hcp6I4IsDZGE
         qgKXJDOP0+l12MHtt6j1xAAm98JDjM7oujchLolAtdWRcU0VEI3cMg1Ggbj3Oqe8qFbZ
         ELiTUSuZTsb/tco2TaGLpw7GyWPEb/+dz9zuFGHTsoHnohnEGX+8z75nuBb9NJEjDeQK
         oFl3VZYuvGvUhDf//oweDuCCm5G0VEJug1+iktemEYIglCwi5dwC8Xo7SWytj75qqVta
         qj1A==
X-Forwarded-Encrypted: i=1; AJvYcCU1TPRFvAUyHRHfqMxv0JLoKJcEpRCYVOumgoV1iQgmiEPDD0IolJFWhVC99jqVrfAFV3i1FetRRqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQWKtuggwSNT2C9s7RKqJkujyKDR4mY9qCD73bJf6KxRDZeCZ
	5QvmVJuB5WjnfenWoRhFoP3mJA37qN+agiGnhLSgKIJK7IsYE4zjDYEy
X-Gm-Gg: ATEYQzzLkGfmtGfcOrg/qHDVxVLg2G1iFZ1WVlSMyAYd3c8pGv8PmFRO5TQyHW9KifA
	mei+MDEyyiCOeTZqMgBBTIdbxBUwnIx4moHCh1EXM+JiQHmfIgg0IrsHqZzsZIk3phIkwDFOSh5
	/eJorHjniUZXizYuHJOGurcJk3THxRzHKJ2fyOv4+DTQvdvuZkByXurULrFOWEEQ5Kaquptca50
	656r01gpykhXSX35zNRhtFZC0d2MRkzDbyeYuXQrnZr4mFM2gQbBm8Xoj9sFQxxP5l93Ma2YcFn
	DJvwXizYezHKI4BcnMOriFKQDidNehYJnB6TIJzLkQY86flW+cC8jov7zVQxPnhDqy1z44FQppO
	T5WNS7Q+I4f8pIW/wSTu3XpD1WiSPKq1u6dxoEUtvHakzQEy1aCaqN+LOVQxAV8BXspxkRaJ38/
	LUtHaxOAJ0TdcVSq1yZcLDIi79XpDJtglb3HjemUNoM6lMeTeJZsotji4suw==
X-Received: by 2002:a17:902:f650:b0:2ae:cda1:1d2b with SMTP id d9443c01a7336-2b0cdcbaed6mr54657745ad.29.1774666634962;
        Fri, 27 Mar 2026 19:57:14 -0700 (PDT)
Received: from localhost.localdomain ([60.49.20.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277fb50sm7194835ad.56.2026.03.27.19.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 19:57:14 -0700 (PDT)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH 1/3] dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
Date: Sat, 28 Mar 2026 10:56:55 +0800
Message-ID: <20260328025706.52722-2-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328025706.52722-1-karom.9560@gmail.com>
References: <20260328025706.52722-1-karom.9560@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9699-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[metafoo.de,kernel.org,vger.kernel.org,web.de,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C95E34D1D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

    checkpatch.pl --strict reports a CHECK warning in dw-axi-dmac.c:

      CHECK: Alignment should match open parenthesis

    This warning occurs when multi-line function calls or expressions have
    continuation lines that don't properly align with the opening
    parenthesis position.

    Fixes all instances in dw-axi-dmac.c where continuation lines were
    indented with an inconsistent number of spaces/tabs that neither
    matched the parenthesis column nor followed a standard indent pattern.
    Proper alignment improves code readability and maintainability by
    making parameter lists visually consistent across the kernel codebase.

Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
Fixes: e3923592f80b ("dmaengine: axi-dmac: populate residue info for completed xfers")
Fixes: 3f8fd25936ee ("dmaengine: axi-dmac: Allocate hardware descriptors")
Fixes: 921234e0c5d7 ("dmaengine: axi-dmac: Split too large segments")
Fixes: a5b982af953b ("dmaengine: axi-dmac: add a check for devm_regmap_init_mmio")
Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
 drivers/dma/dma-axi-dmac.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 45c2c8e4bc45..0017f4dc6dcc 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -193,7 +193,7 @@ static struct axi_dmac_desc *to_axi_dmac_desc(struct virt_dma_desc *vdesc)
 }
 
 static void axi_dmac_write(struct axi_dmac *axi_dmac, unsigned int reg,
-	unsigned int val)
+			   unsigned int val)
 {
 	writel(val, axi_dmac->base + reg);
 }
@@ -382,7 +382,7 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 }
 
 static inline unsigned int axi_dmac_total_sg_bytes(struct axi_dmac_chan *chan,
-	struct axi_dmac_sg *sg)
+						   struct axi_dmac_sg *sg)
 {
 	if (chan->hw_2d)
 		return (sg->hw->x_len + 1) * (sg->hw->y_len + 1);
@@ -437,7 +437,7 @@ static void axi_dmac_dequeue_partial_xfers(struct axi_dmac_chan *chan)
 }
 
 static void axi_dmac_compute_residue(struct axi_dmac_chan *chan,
-	struct axi_dmac_desc *active)
+				     struct axi_dmac_desc *active)
 {
 	struct dmaengine_result *rslt = &active->vdesc.tx_result;
 	unsigned int start = active->num_completed - 1;
@@ -517,7 +517,7 @@ static bool axi_dmac_handle_cyclic_eot(struct axi_dmac_chan *chan,
 }
 
 static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
-	unsigned int completed_transfers)
+				   unsigned int completed_transfers)
 {
 	struct axi_dmac_desc *active;
 	struct axi_dmac_sg *sg;
@@ -667,7 +667,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 	desc->chan = chan;
 
 	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
-				&hw_phys, GFP_ATOMIC);
+				 &hw_phys, GFP_ATOMIC);
 	if (!hws) {
 		kfree(desc);
 		return NULL;
@@ -703,9 +703,11 @@ static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
 }
 
 static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
-	enum dma_transfer_direction direction, dma_addr_t addr,
-	unsigned int num_periods, unsigned int period_len,
-	struct axi_dmac_sg *sg)
+						   enum dma_transfer_direction direction,
+						   dma_addr_t addr,
+						   unsigned int num_periods,
+						   unsigned int period_len,
+						   struct axi_dmac_sg *sg)
 {
 	unsigned int num_segments, i;
 	unsigned int segment_size;
@@ -817,7 +819,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 		}
 
 		dsg = axi_dmac_fill_linear_sg(chan, direction, sg_dma_address(sg), 1,
-			sg_dma_len(sg), dsg);
+					      sg_dma_len(sg), dsg);
 	}
 
 	desc->cyclic = false;
@@ -857,7 +859,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
 	desc->sg[num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_LAST;
 
 	axi_dmac_fill_linear_sg(chan, direction, buf_addr, num_periods,
-		period_len, desc->sg);
+				period_len, desc->sg);
 
 	desc->cyclic = true;
 
@@ -1006,7 +1008,7 @@ static void axi_dmac_adjust_chan_params(struct axi_dmac_chan *chan)
  * features are implemented and how it should behave.
  */
 static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
-	struct axi_dmac_chan *chan)
+				  struct axi_dmac_chan *chan)
 {
 	u32 val;
 	int ret;
@@ -1295,7 +1297,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
-		of_dma_xlate_by_chan_id, dma_dev);
+					 of_dma_xlate_by_chan_id, dma_dev);
 	if (ret)
 		return ret;
 
@@ -1310,7 +1312,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 		return ret;
 
 	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
-		 &axi_dmac_regmap_config);
+				       &axi_dmac_regmap_config);
 
 	return PTR_ERR_OR_ZERO(regmap);
 }
-- 
2.43.0


