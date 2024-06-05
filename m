Return-Path: <dmaengine+bounces-2264-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B98FC8AA
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 12:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41A9285A0F
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774286CDAB;
	Wed,  5 Jun 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="alkmxNsa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B2190070
	for <dmaengine@vger.kernel.org>; Wed,  5 Jun 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582060; cv=none; b=FESuNBnOB1PP1UoBV1ma6Q4lXW1+sZlfjZPiZVEIEkbsRxJMe8fPyynRoYOViNxzH4A2yMQmYo8vOm6pc3doGmZpGkxDkpO0ADBNiJsHhYqj0cpwDHRDLBOtk73y9emdLKnxmBnDKnkJMrYI78lrcfxTSowS9fhaURcPa3/tx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582060; c=relaxed/simple;
	bh=FoGZHxTp8eP5yGnrvKq7en6xXyZU38qjm48ef3UFK+0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=prl208JwAybYN9woRGxwUAfzKMIzXcMHDJl1Dz95FEbrdWpDJg5hITIGNiQGe97hqvbMR4P8WaPL/mgocsDtPMireYLYw+GOgWUuNqlczRVMwy6wfqR7EtRCqQMzXs6P6aLJkO3zhXpPMlZQxM4hCc9cSzVfez9u4AHuKK0j7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=alkmxNsa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42155dfc484so6335365e9.1
        for <dmaengine@vger.kernel.org>; Wed, 05 Jun 2024 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1717582057; x=1718186857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ULRX1pmmSfWpj2F3DT/mr/MfnQljB+A05Dy9I4dgzmU=;
        b=alkmxNsaZXQH8yVtVYK03tZ0XhCLuwsFse69+cHGNr/N8UXkCudn/jQjW9boaTGp5L
         qgDgKa6CC4zKLfgOY7PP82SF6yXk41WZOO8YAjocncQjWe5nQApJ/zVe5ZLT813m1H1K
         /av13U1UaLmcoq/ZYOma0PHx8rH6woAoPLvGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582057; x=1718186857;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ULRX1pmmSfWpj2F3DT/mr/MfnQljB+A05Dy9I4dgzmU=;
        b=xGY6qzwB7h/AGmumvMFgO3rIQBu15sfSPGEZ8CRQG6hfYD7+Qu3sUgCSqAxbTQ0Sa5
         kNzu4OszIZ8QzyPBHs4Y83Py5/T5fAJuwMx0kMxDw31vPDPog4tt1PUSOzegV7EoAJiF
         1JIZzVeyrPqCvKxXyPqD2DK1eIDGdM+O1h5DK1vVU1SX4lD6OKNe7doVdx1LYnjFOyTW
         3fs4Kc2cqDoYP6GHYyVXisTgIVQ+yCha0AgdjoJq9Po08X68Zq6jDPgVS5BZdJ0QCQYG
         i6Mhgcd9yhTtMR/brTWrCLnWn5QS5Gu6FoIWyUA28oogNPD2RjhbH773LF4D93/TMvUH
         fbTQ==
X-Gm-Message-State: AOJu0Yz5doE6N8qHDja6nWafYUwYkqHUDEhy8+C5TrMyzgo/+jZG5+A9
	q1unM0Mkta1Oo7viNXRtv3l5G1+vjBvI858JxOIWHUR8vgXPJ7X101EzTDsfirLnFosgI9lmgre
	p1hJu9KOIH+wKxODpw4H4XQX7xNq1KHSozz6rbYoLchUNW6xbQXDSCVweUgHSNQPiOVo/Cwcz/0
	an/Vg0RhJznCV6/DYN7TI7VIEATisoVdQ0lmEzeus=
X-Google-Smtp-Source: AGHT+IF4nJ8UNz5gqOzsHB1S/opWMw29hf6ZGgaZxIHU0PArDWSpoaIDy1PXeYI3q/3fux+VxWotor40VhrJALtEFD4=
X-Received: by 2002:a5d:52c1:0:b0:354:f92f:fcfe with SMTP id
 ffacd0b85a97d-35e8ef1898emr1507646f8f.35.1717582056672; Wed, 05 Jun 2024
 03:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Wed, 5 Jun 2024 12:07:11 +0200
Message-ID: <CALYqZ9=zAomD6wfcmNmLzv0c54gXEC4x7fNCyA=RjxBb7uxGZQ@mail.gmail.com>
Subject: [PATCH 2/3] : XDMA's channel Stream mode support
To: dmaengine@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"

From f68193ed7891d3367085f8c2af202c1fc2d8abb2 Mon Sep 17 00:00:00 2001
From: Eric DEBIEF <debief@digigram.com>
Date: Fri, 24 May 2024 17:03:38 +0200
Subject: XDMA stream support: set wb desc addr only if allocated.

WriteBack descriptor is allocated only in STREAM Mode.

Signed-off-by: Eric DEBIEF <debief@digigram.com>
---
 drivers/dma/xilinx/xdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index c2a56f8ff1ac..3c7fcad761e8 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -653,7 +653,7 @@ xdma_prep_device_sg(struct dma_chan *chan, struct
scatterlist *sgl,
         src = &addr;
         dst = &dev_addr;
     } else {
-        dev_addr = xdma_chan->cfg.src_addr ?
+        dev_addr = xdma_chan->c2h_wback == NULL ?
             xdma_chan->cfg.src_addr : xdma_chan->c2h_wback->dma_addr;
         src = &dev_addr;
         dst = &addr;
@@ -731,7 +731,7 @@ xdma_prep_dma_cyclic(struct dma_chan *chan,
dma_addr_t address,
         src = &addr;
         dst = &dev_addr;
     } else {
-        dev_addr = xdma_chan->cfg.src_addr ?
+        dev_addr = xdma_chan->c2h_wback == NULL ?
             xdma_chan->cfg.src_addr : xdma_chan->c2h_wback->dma_addr;
         src = &dev_addr;
         dst = &addr;
--
2.34.1

-- 
 
<https://www.digigram.com/digigram-critical-audio-at-eurosatory-2024-in-paris/>

