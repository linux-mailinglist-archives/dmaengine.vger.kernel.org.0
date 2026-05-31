Return-Path: <dmaengine+bounces-11068-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBsBNV6YG2rvEQkAu9opvQ
	(envelope-from <dmaengine+bounces-11068-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:09:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E33861438A
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24F78300E5D5
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 02:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56872FD1A5;
	Sun, 31 May 2026 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bna9Vd+C"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6A348C4C
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780193343; cv=none; b=B7OLQnaj+YjVcHdq8jOabw5l9HvDmeYNPIQTTjm96hywFRR/sL+zZcD0V/eQaaxfD2mXAgatArXz5agohslPABWPSUbnI6YzsDVYr2XCxAQh2MUvq/aXtXvqxlj8opQSZZJC69A5NU6XBmengERf9PzYBcfNeEawxTZy3FYvmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780193343; c=relaxed/simple;
	bh=jhMvQA0BNa0Q/rJR30qGXHPq2z7epoFvLne452oy0bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N2t66mqAk7RxF3W32/voFKNTNnqbT9ie8vsQVE+o9Kl4ZPQTiSxOCJynrkE8bEnCD64HcJUsycvUDZEBIU3WSbdCAsGoqAXAaafA1JRC3vdswTL0uF0+mWgbdo2HISYL4i+pIOtc+3wUmq74Tw2t9T1/sSjZEtnmxWfCsLB1qX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bna9Vd+C; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccf181a52bso11926226d6.3
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780193341; x=1780798141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/I6vtnwODMSXojEn3r4VzFo/02YMNNrJvs59YYPsvk=;
        b=Bna9Vd+CNVnfpnCjl0Kf3P9nxmMEONYVFsSHC/S9jZ4UkjTcOwiTI6PjZF8RjZvKv6
         nWKpsAOLsnZC2gmuUwQ1BjYZlfl0XbR1C8F1kC5bXuejx+3Pd8YXQLo+ea8b7YU3r4wh
         CgtA89v/s9cHO8YEWLtAmhLdJ0e+4YuilGn5wbIjjuL5siLAaqm5HHiwto96DinezjUl
         ombmmGXaaXQV3zApv4SC+CPqBu8Eyrq7o/QPICgXT4/c6fXgB6HIUbdXnwuaQAttVn5I
         yYYebsI/MUCQ3v78bPeeDhyx/3xjyt3/ZDJvPWMeAoWBvzIfQzqndp8PRmyrJTRzXZ6A
         CIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780193341; x=1780798141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/I6vtnwODMSXojEn3r4VzFo/02YMNNrJvs59YYPsvk=;
        b=O67YHyMO6wWiW5nZuzryO916GKLP8iu/z8hUpmk/uU18kr+4Z0ZFTAf/1mBNgwfdL9
         T8f2dHCe6EL501t9l5kyphParWtR6yeRb3py7Lwuzyc/+sWVtwlhTpnnqa6JpUbtHxiL
         Gna9mp74yTieXK6Ak5EdL06/8rVT37sVq3o6HnOwPsLhOdUrO9H9mnDAd2s4FWGHMQP5
         5bPGZIT+UoQbUSf+qn5joP+y3+NsB56ILI7E44jc5RdCQdH3RQhODk2A0esnGaCAVCe9
         Ik8XkD/5lAzYgGdtVq72jePu0n8A6r4T//vKnagCAzBCrczu7UC9hL1qAqkv3TL70x+K
         av6Q==
X-Gm-Message-State: AOJu0YxcOgFIqLHx6oVIWvNqOGlqNvKQFm/K9norz+xdTSwzaqTFGqRT
	vYpeEXUXa7bMZ+wCVSF/ogr+5oLTpNN2cpK0dj6RzyHbUV4RwrCq9CXERHTrIxk1
X-Gm-Gg: Acq92OFTqXUZgwIcbA/yP+p+6ukn5JsDDEM7HtPsxZ5y2enIgqCINPE/8t+cfXhtHmp
	P5OjQStkji+8ShDmAuXwvb526t5ZfkfdsbULGUvFuSNz0tsJ/BHtitlVdMZOd6M9zFJQcyjPR6S
	W++wdGeSGmJQxfwzdQxMo7tlEEe/J56nnqR6ee70trmR1SVExL20lT3loqJaXnSDaLeKIzyaW7l
	B01iXaRH8qCTlVWxe3Pv9byEBM3eMb1TirUcPze6I7902vQOhXXbvofuUKspjxOLsMj77RPq/kt
	mJ2ICvhh8BUSUglYvaI3MZUCGoLmKLCu466XNGcFx6WuGWb6B6g9xno0XEBAV3qom4kWlpHbPmn
	pI/8952qtLLUpy+ayNZ9fBetG88itBQt0kbg9xokWc8arUCuUJrXDaSSXc/7OmRubV7Tv0z5Sr0
	0us9kt/deiEASnvKWk++fYj+RMswoclnSl1J3N9EeoyeHSya/aCpJ5FUp1O3D5pMEWGNC+gcOkt
	ofQl2WeoccOsLTeTFmt8tZrHaXjrJYzu89t9v3skNYyFA==
X-Received: by 2002:a05:6214:2605:b0:8cc:de2:3b5d with SMTP id 6a1803df08f44-8ccefb44f63mr92094936d6.16.1780193341380;
        Sat, 30 May 2026 19:09:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042229sm57814566d6.5.2026.05.30.19.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 19:09:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/NOMADIK/Ux500 ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3] dmaengine: ste_dma40: turn d40_base phy_chans into a flexible array
Date: Sat, 30 May 2026 19:08:43 -0700
Message-ID: <20260531020843.594892-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11068-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 8E33861438A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the separately-offset phy_chans pointer to a C99 flexible array
member at the end of struct d40_base, and switch the allocation to
struct_size(). The log_chans and memcpy_chans slots continue to live
in the same allocation immediately after phy_chans, indexed via
base->log_chans. This removes the hand-rolled pointer fixup that
recomputed phy_chans from base + ALIGN(sizeof(struct d40_base), 4).

The ALIGN(sizeof(struct d40_base), 4) requirement is met implicitly by the
C compiler when using a flexible array member. With struct d40_chan
phy_chans[] as the last member, the C standard guarantees
sizeof(struct d40_base) includes trailing padding to satisfy the alignment
of the flexible array element type (struct d40_chan). Since struct d40_chan
contains members like spinlock_t, pointers, and struct dma_chan — all with
alignment ≥ 4 — the compiler ensures sizeof(struct d40_base) is already a
multiple of _Alignof(struct d40_chan) >= 4. The struct_size() macro then
computes sizeof(struct d40_base) + sizeof(struct d40_chan) * num_phy_chans,
so phy_chans[0] lands at a properly aligned offset without needing the manual
ALIGN.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: add min() calls
 v2: added ALIGN description
 drivers/dma/ste_dma40.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 9b803c0aec25..0d9ffa3e2663 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -602,7 +602,6 @@ struct d40_base {
 	struct dma_device		  dma_both;
 	struct dma_device		  dma_slave;
 	struct dma_device		  dma_memcpy;
-	struct d40_chan			 *phy_chans;
 	struct d40_chan			 *log_chans;
 	struct d40_chan			**lookup_log_chans;
 	struct d40_chan			**lookup_phy_chans;
@@ -621,6 +620,7 @@ struct d40_base {
 	u32				 *regs_interrupt;
 	u16				  gcc_pwr_off_mask;
 	struct d40_gen_dmac		  gen_dmac;
+	struct d40_chan			 phy_chans[];
 };

 static struct device *chan2dev(struct d40_chan *d40c)
@@ -3128,6 +3128,7 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	struct clk *clk;
 	void __iomem *virtbase;
 	struct d40_base *base;
+	size_t alloc_size;
 	int num_log_chans;
 	int num_phy_chans;
 	int num_memcpy_chans;
@@ -3185,22 +3186,24 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	else
 		num_phy_chans = 4 * (readl(virtbase + D40_DREG_ICFG) & 0x7) + 4;

+	num_phy_chans = min(num_phy_chans, STEDMA40_MAX_PHYS);
+
 	/* The number of channels used for memcpy */
 	if (plat_data->num_of_memcpy_chans)
 		num_memcpy_chans = plat_data->num_of_memcpy_chans;
 	else
 		num_memcpy_chans = ARRAY_SIZE(dma40_memcpy_channels);

+	num_memcpy_chans = min(num_memcpy_chans, D40_MEMCPY_MAX_CHANS);
 	num_log_chans = num_phy_chans * D40_MAX_LOG_CHAN_PER_PHY;

 	dev_info(dev,
 		 "hardware rev: %d with %d physical and %d logical channels\n",
 		 rev, num_phy_chans, num_log_chans);

-	base = devm_kzalloc(dev,
-		ALIGN(sizeof(struct d40_base), 4) +
-		(num_phy_chans + num_log_chans + num_memcpy_chans) *
-		sizeof(struct d40_chan), GFP_KERNEL);
+	alloc_size = struct_size(base, phy_chans, num_phy_chans);
+	alloc_size += sizeof(*base->log_chans) * (num_log_chans + num_memcpy_chans);
+	base = devm_kzalloc(dev, alloc_size, GFP_KERNEL);

 	if (!base)
 		return -ENOMEM;
@@ -3213,7 +3216,6 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	base->virtbase = virtbase;
 	base->plat_data = plat_data;
 	base->dev = dev;
-	base->phy_chans = ((void *)base) + ALIGN(sizeof(struct d40_base), 4);
 	base->log_chans = &base->phy_chans[num_phy_chans];

 	if (base->plat_data->num_of_phy_chans == 14) {
--
2.54.0


