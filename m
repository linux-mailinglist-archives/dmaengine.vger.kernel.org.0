Return-Path: <dmaengine+bounces-2779-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77427945999
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 10:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C26B225B2
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 08:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D261C3F14;
	Fri,  2 Aug 2024 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdpaKsdS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45971C37BC;
	Fri,  2 Aug 2024 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586085; cv=none; b=KBqX3Gw/R8crYUzSJOPtxQUnzlHiaMyDlCEmwnYffTTUilcynxV7IluF6qGy5+wTiYzUNNKu+DQmjSQORHTWRjtLzlgCVYPf/HEavb9rSIBDi0BsDE2e+r0bxfu7Jlyg8ZtiCITr4DyFc6ZWgSwJZSUV9d8mOVN5nKQmILFLXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586085; c=relaxed/simple;
	bh=1eIISpZQkPPv2bNTH8sY8k7lXTjpMWMXMPBkf/xtonY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ndPpIsPSPmV0DoO4C8yaYq981oTAB90QnxzqZcx/j9uxoA6KikSn/BL9yLH9djt6+/C707dBM1TNTcFxfoAQyFSmwMFXJvbxj5zTWNHBrJz4NgSICKhaVL9YPC+cQlrnsCRMlUSBBS5CLK6Cky7dLiBxbTY4P3cPUj5S1akHF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdpaKsdS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1051360so86983121fa.0;
        Fri, 02 Aug 2024 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722586082; x=1723190882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIsZedcHbhSfV0oPWdGCw2Uv/CXrxcxWydVHUH21W4Q=;
        b=RdpaKsdSpSKf+YSz4+mFpvsmbaILhcmP44bt88HDw2n25nK9xzE9n0u1P3kWVI8xxT
         H+Y2qSi3zgkbX2ouX1Q6CKH+KFHlluwMqcx1yDHcEK4eXsLwHLvpjrkTehhO++O+q/B8
         uaqgR1J+XuG4D7Jhofnzv84ZurBRUirHJDfXVqELHQ5BU6sTAk21yeSxKM6Tp1a7g64p
         NX3BBfZumDjHauu6RPwXlbHnivQQpMrWfkp5T9BFaicMTubIJ4z6NDh04aS5QqbfZeuq
         azFJDoDunooTh1LBVq8/ySoX+pqQVLERDmwDyhDvu/P3e3F3ql1goXCFSvp7iEQTWzpN
         Lfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722586082; x=1723190882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIsZedcHbhSfV0oPWdGCw2Uv/CXrxcxWydVHUH21W4Q=;
        b=fzqKZGWxX2pEQOo3M+ETO7FQK2HqBDzetBmBRQf98bwE6cf6tJ4B+jDYPG0tEJhdz/
         /QbAMwepbeC66iP1nXbK3BuP0Csfc62yQ8MVIij08VCwB15ZJN4LODPWOPC9bTtdg9Fz
         e0gWjf1dCeXs6ZG7Gtq/orl6DJ8FkwniustPbpmXUceCZcDWLVSel1xNIs0CkKytr28W
         LidXM2U/z5Q5yIAWkXYw2vASgiy16KEYy4SgwJvtjcKeOU/1OTbaqg+Ho8vTyNTgp2vm
         qiGHwdxGSiT7030GlAbA+vUcZagsmfm+k0dd+POhfqoKJkJ2SnISH9goyAre/B5o2axY
         YB6A==
X-Forwarded-Encrypted: i=1; AJvYcCVoSXdeLRjLx5hf4eoPYLZbUFmKheP8UsENT6QMUrVJhdyLWJWX3eEAbbiQo1z0zVqi6m5Q+8pftpVZLrDV99oB4wIgY45/hkgm+MP61kp6W6BkRehcPATA6NZsykFQtiu4Bbr4vV7XlG0I/EmxripmGvSa/YYOAa8VDihP22quRAsan43q
X-Gm-Message-State: AOJu0YzS5bbSik+R/sIewZHcpdMq7Ym+mfeqbQ7hvfKVpaEMd/CdXC/d
	TkCtEgAc6pwAHI2hpaorMz0cI+/evWMyzuycZGJh7TpovqPwXRNL
X-Google-Smtp-Source: AGHT+IEr++3k1GJni0e4Zdm7gvqLjSiKEGIIqFnldvWyCljIE9dxKwglw212lsgP5uXjLlcOFhaiBQ==
X-Received: by 2002:a2e:9805:0:b0:2ef:392e:e45 with SMTP id 38308e7fff4ca-2f15aafdc08mr18299641fa.33.1722586081659;
        Fri, 02 Aug 2024 01:08:01 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e17e802sm1049511fa.14.2024.08.02.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:08:01 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] dmaengine: dw: Prevent tx-status calling desc callback (Fix UART deadlock!)
Date: Fri,  2 Aug 2024 11:07:51 +0300
Message-ID: <20240802080756.7415-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The dmaengine_tx_status() method updating the DMA-descriptors state and
eventually calling the Tx-descriptors callback may potentially cause
problems. In particular the deadlock was discovered in DW UART 8250 device
interacting with DW DMA controller channels. The call-trace causing the
deadlock is:

serial8250_handle_irq()
  uart_port_lock_irqsave(port); ----------------------+
  handle_rx_dma()                                     |
    serial8250_rx_dma_flush()                         |
      __dma_rx_complete()                             |
        dmaengine_tx_status()                         |
          dwc_scan_descriptors()                      |
            dwc_complete_all()                        |
              dwc_descriptor_complete()               |
                dmaengine_desc_callback_invoke()      |
                  cb->callback(cb->callback_param);   |
                  ||                                  |
                  dma_rx_complete();                  |
                    uart_port_lock_irqsave(port); ----+ <- Deadlock!

So in case if the DMA-engine finished working at some point before the
serial8250_rx_dma_flush() invocation and the respective tasklet hasn't
been executed yet, then calling the dmaengine_tx_status() will cause the
DMA-descriptors status update and the Tx-descriptor callback invocation.
Generalizing the case up: if the dmaengine_tx_status() method callee and
the Tx-descriptor callback refer to the related critical section, then
calling dmaengine_tx_status() from the Tx-descriptor callback will
inevitably cause a deadlock around the guarding lock as it happens in the
Serial 8250 DMA implementation above. (Note the deadlock doesn't happen
very often, but can be eventually discovered if the being received data
size is greater than the Rx DMA-buffer size defined in the 8250_dma.c
driver. In my case reducing the Rx DMA-buffer size increased the deadlock
probability.)

The easiest way to fix the deadlock was to just remove the Tx-descriptors
state update from the DW DMA-engine Tx-descriptor status method
implementation, as the most of the DMA-engine drivers imply. After this
fix is applied the Tx-descriptors status will be only updated in the
framework of the dwc_scan_descriptors() method called from the tasklet
handling the deferred DMA-controller IRQ.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com

---

Note I have doubts whether it's the best possible solution of the problem
since the client-driver deadlock is resolved here by fixing the DMA-engine
provider code. But I failed to find any reasonable solution in the 8250
DMA implementation.

Moreover the suggested fix cause a weird outcome - under the high-speed
and heavy serial transfers the next error is printed to the log sometimes:

> dma dma0chan0: BUG: XFER bit set, but channel not idle!

That's why the patch submitted as RFC. Do you have any better idea in mind
to prevent the nested lock?

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Andy Shevchenko <andy@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/dma/dw/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 5f7d690e3dba..4b3402156eae 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -925,12 +925,6 @@ dwc_tx_status(struct dma_chan *chan,
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	enum dma_status		ret;
 
-	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE)
-		return ret;
-
-	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
-
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;
-- 
2.43.0


