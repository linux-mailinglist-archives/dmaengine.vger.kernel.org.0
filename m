Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFEE21EF1A
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgGNLUU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGNLSm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:18:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28DEC08E81E
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so20887461wrw.5
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/zoKcrmx2IW2qZYN8v07zqfWyovJdKlsFhRtVJoj8Y=;
        b=b1sAb44WGmZFCdVAFpOnOB6gjm1ZuIfnH5qfH6jEl7r1V5Ot0bj2a/haai/zLlbGwZ
         jyft/gXpKRKwhcAmBF6N1E3tVUv3FpyxaQDJbEMA+kzxFOdi5i/iC+SuVdGwUK3S7lkC
         JCMyVtDbRUfFVhAZkbBSmtUupdpqKKxXkUPJTaoOYPu5dPFvyg6Blg9WrDMzB/cseVM+
         rhmyyRlfWyztEMer+eWo6n3Do/AXv5WhKdZaS+4tgq6H2R8pELz1fQ3yZJcDDG53AKI8
         o6mlh08h6jJhiGMzg1aEP83hrtSL2JwTrrM/lGjoC5Bpn1y65cxU+TAsW9GNOLI5/kNh
         tUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/zoKcrmx2IW2qZYN8v07zqfWyovJdKlsFhRtVJoj8Y=;
        b=C/qmRVplk8FX5cMggCBQU0MrqgUBYo1suMjoCKJwVpASeO6eivHSeAHIjpNUc6chsC
         CxkBF5P7mScdbc5KIEfu2jOO4bN/wKSyNqL+3FTjdiG8XWOZAp10mBOX69USHwiUrwrO
         za+/pod+oNmK2SpdpAmaipg3Qe0IwXi/Ys/E5SPJm4n8eneRwWHUYH1fMKp25TZuHyKr
         KxVg10k+1zJGjQ9XSvjLvEImyY8wn1oOsRDbZwX6LKap0JPEHGIPSkIgMKVEMzRGyrFf
         Sfk9Nto0PzbKUCiEmuD6+L24sD4Cc4pFDXl64sTimSKHsA5SfYz3uK7Y4wrBS16XnOyZ
         qCTg==
X-Gm-Message-State: AOAM5313L2qLWKtuvqU37+RtgCSB0iCCptIyO9r4pigLk2IKHDElCfS+
        c8U9LpH15aBG6VZMSs37svL/8Q==
X-Google-Smtp-Source: ABdhPJyAUbTKcS5Sll5KxkNhZWdfScOwNs01z+UT0g/DeH+FLBo8B9AbZI4twgzB3lN+ZB/l5mfLmQ==
X-Received: by 2002:a5d:698e:: with SMTP id g14mr4923996wru.301.1594725364528;
        Tue, 14 Jul 2020 04:16:04 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 13/17] dma: nbpfaxi: Provide some missing attribute docs and split out slave info
Date:   Tue, 14 Jul 2020 12:15:42 +0100
Message-Id: <20200714111546.1755231-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/nbpfaxi.c:157: warning: Function parameter or member 'chan' not described in 'nbpf_desc'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'tasklet' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_src_addr' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_src_width' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_src_burst' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_dst_addr' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_dst_width' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_dst_burst' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'running' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'paused' not described in 'nbpf_channel'

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/nbpfaxi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 594409a6e9752..74df621402e10 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -144,6 +144,7 @@ struct nbpf_link_desc {
  * @async_tx:	dmaengine object
  * @user_wait:	waiting for a user ack
  * @length:	total transfer length
+ * @chan:	associated DMAC channel
  * @sg:		list of hardware descriptors, represented by struct nbpf_link_desc
  * @node:	member in channel descriptor lists
  */
@@ -174,13 +175,17 @@ struct nbpf_desc_page {
 /**
  * struct nbpf_channel - one DMAC channel
  * @dma_chan:	standard dmaengine channel object
+ * @tasklet:	channel specific tasklet used for callbacks
  * @base:	register address base
  * @nbpf:	DMAC
  * @name:	IRQ name
  * @irq:	IRQ number
- * @slave_addr:	address for slave DMA
- * @slave_width:slave data size in bytes
- * @slave_burst:maximum slave burst size in bytes
+ * @slave_src_addr:	source address for slave DMA
+ * @slave_src_width:	source slave data size in bytes
+ * @slave_src_burst:	maximum source slave burst size in bytes
+ * @slave_dst_addr:	destination address for slave DMA
+ * @slave_dst_width:	destination slave data size in bytes
+ * @slave_dst_burst:	maximum destination slave burst size in bytes
  * @terminal:	DMA terminal, assigned to this channel
  * @dmarq_cfg:	DMA request line configuration - high / low, edge / level for NBPF_CHAN_CFG
  * @flags:	configuration flags from DT
@@ -191,6 +196,8 @@ struct nbpf_desc_page {
  * @active:	list of descriptors, scheduled for processing
  * @done:	list of completed descriptors, waiting post-processing
  * @desc_page:	list of additionally allocated descriptor pages - if any
+ * @running:	linked descriptor of running transaction
+ * @paused:	are translations on this channel paused?
  */
 struct nbpf_channel {
 	struct dma_chan dma_chan;
-- 
2.25.1

