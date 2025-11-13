Return-Path: <dmaengine+bounces-7176-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98417C59D88
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 20:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17AD74E4EBD
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 19:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960AC3168EE;
	Thu, 13 Nov 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDNzTugK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2E313538
	for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063459; cv=none; b=RNgUCB63HwkBUF12omoxcGV7iWns1Q9D+DISB4gNf7tKW7Z+6vq+v+Y0/xdIngkm5WviJid0PtPncMYhrW3/AXto+iaGJqt0FWjK3luALJXEZ7N5imlHuGmi7XQQzx2WczWu8abUYbtlAMxGfn1lyIB9pvzTmoNO2RmXbfzXUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063459; c=relaxed/simple;
	bh=mHTGsOfuS2W0u5p/r09WYfZ8PsBfHhEo7hbNe2CwJZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPsdU5Vuv5f3cdZYMnFDoHqlvMMxQGjvBJ6uP9Dp4YaUAA8DK18I+nd+JI+O6uDKd13McOkl2ltHx0rEaPvptJFLpjwlPvUQ1avSxVByQDSWhCPgoiRPojv493LH3BD/L9pQQCH4WZXw6yj1W1so7jjONSScwIavhIVrtIdUeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDNzTugK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so7289765e9.3
        for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 11:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763063455; x=1763668255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8a4bxJ700KFmukmiZtpRMTY3GPxgHVm/3xQfOBxUFVg=;
        b=gDNzTugKdzbQFMfWN04RH9RtdpxmnUDwvm4+d5ifl49z9FYdP8IOw7GhKXfabGfAik
         QjZHqDO47bsV2jICjsjDxqomykWjOBW7XcltKBLid9dpaZgQgN8zIvxWp6NZ8fkF07ss
         yZ/IOcXzbG0USzG8oDdsV3Fvd9TlmiOe++K0QGd6w8v7ngRN7elSzDGOO8tPWUgKIe41
         i5TcewAK2QKlx+EvhiPxEVBuvJj7tsTBD9ZtfnaQEwwPcM8wLVwyHeTNnuOEF1OU57Fq
         K8EEymjgg3O2GTP8XSJX3dvl5UTJW+XvVFObiQlcQ3Vgt1em4NaLmR09XbY3tB4OI1wm
         fnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763063455; x=1763668255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a4bxJ700KFmukmiZtpRMTY3GPxgHVm/3xQfOBxUFVg=;
        b=V3UPlcYJqwCT+ShUw3myzsqki7CQIm+iSX74N/reNGtBdIW4YKtW4HbhhnQZincj2o
         U6sd3o9kAAqfXUO57UT6l2kUlnk2KRVEtPwouwIxnQ4bMO3pF5mPamYJK+0S4uICrMJR
         zsvQOAAljtOe2EmCAS/0R2T0Y4krf+VrsvTmV0F7+AKHgzKFoMkXjFJtFW6fIn1l3JG1
         uOiia2acVq0o8QQdpQS+xGlheVmp1o4FodBSOSeklEpFDISwoRmy1N83LbF6Geo2jeMA
         HL6D2yUB+r+IhKlgpZtTiIHQbNttzHDvrq+HswxjKAXNpYb1Pw0v5CXpLG/beOk4H1Pm
         AJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGLFMeKkuRQNH2jmjHfFXRpg1YePv17CUG2vteiAP16/OoGDZ5jol3r9PgEQdst3HN+olIjGNQZdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCry7hQ2CSmv644QFzvJSvaP4tsGF5/48NuepVa/Cv9e7MELCV
	lzspUz1uauK3aV1aoB7bu37sg+S7NRXJd/hnbXGyT7OaDEFrEek3YWeQ
X-Gm-Gg: ASbGncuq52lmiTp40jrXAa5cY//Mh9ZaRl+8OLCavujICGBExJmzYQVnWFbPQC+o4YL
	DFElsdqx+h59JKILNAMkaeNjoTcq8eYJSZWdj4uxS3bvog30YuaFdppzcnRqajKFZuqGVt1yez/
	jpt3C1fVRNMFSAjynbl3bd/Use7S0SorjgiU/NOBC/DSVRWCqdxXx+A+6CoDG2IxylYTHRZZaLY
	WfD0svA01aBiXXZZLZPXpAxKrrj8inCnPHvdfiGlzmcPTDPIiIAhMAp8RcOKtqWmMo7MChUQgOd
	5nGcxZLnR+2APml/DfuR78ViLg/hNIHV24i834gh0hA5NPSKObIKeFn8Au0DdSdAEEthPZzTzJS
	7zuXGcMJI/tqmGCth3Y+9LP4JT5Hhbkc25/J5rofwnaY9siX3f9RbdO9AFi2C/RiDnz1tRHhZqa
	/5GLoqVZhW9+9PVGeXIjAqY3ZkNRT6iZdafVIEtf+6WUhvry7nIXOqdnDi8Aiyr7jvBynqQYo=
X-Google-Smtp-Source: AGHT+IFXUMVc2f+6DdqennwxxmSsHqVvHaGBur6Gx3iY2mKkyvBexU+yQ/HvOa7jmy/XDko2hy9xOQ==
X-Received: by 2002:a05:600c:3b14:b0:45d:d505:a1c3 with SMTP id 5b1f17b1804b1-4778feaa621mr6292205e9.37.1763063454670;
        Thu, 13 Nov 2025 11:50:54 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787daab3fsm124424685e9.0.2025.11.13.11.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:50:54 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH v2] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
Date: Thu, 13 Nov 2025 19:50:48 +0000
Message-ID: <20251113195052.564338-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

After audio full duplex testing, playing the recorded file contains a few
playback frames from the previous time. The rz_dmac_terminate_all() does
not reset all the hardware descriptors queued previously, leading to the
wrong descriptor being picked up during the next DMA transfer. Fix the
above issue by resetting all the descriptor headers for a channel in
rz_dmac_terminate_all() as rz_dmac_lmdesc_recycle() points to the proper
descriptor header filled by the rz_dmac_prepare_descs_for_slave_sg().

Cc: stable@kernel.org
Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit message
 * Collected Rb tag from Geert
---
 drivers/dma/sh/rz-dmac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1f687b08d6b8..3087bbd11d59 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -557,11 +557,16 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
 	unsigned long flags;
+	unsigned int i;
 	LIST_HEAD(head);
 
 	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	for (i = 0; i < DMAC_NR_LMDESC; i++)
+		lmdesc[i].header = 0;
+
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 	vchan_get_all_descriptors(&channel->vc, &head);
-- 
2.43.0


