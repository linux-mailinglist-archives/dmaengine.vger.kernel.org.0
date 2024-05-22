Return-Path: <dmaengine+bounces-2138-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24888CC105
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204291C2301C
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9148613D63A;
	Wed, 22 May 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b="KICeH+Cw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741A13D624
	for <dmaengine@vger.kernel.org>; Wed, 22 May 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379955; cv=none; b=qzrw0yH0lBjXBTuG2Z3MkPPmkrOv9+LyRSKf1oTKFrmHBjiILj9gqZKUdpaIEGlxq/MJNeFInLIDSjj/5lukGiGF5R7plI4+HynJpbYqEdoK1XCfiWGI/M79PAjkhJgz/HSm4XpPt4RyRtC2J9sSS5TLqNf05tGtnNQZ/Nxk4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379955; c=relaxed/simple;
	bh=T7qoSXgQVT0d/pBa7QHepJwk35mytwMiMW6199EZvmU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fREnW5DawV6fQtfEip4tv5ffMruo6ZF1obxSqhGFYfvXMxk8JAylXxLD5E7PL6mMrLxDKt8AAm+O97/JWNvi8wa/gIbNdJtGdxzzlNFB5aNkK63i+WuTbxw7jlK0x0oXoKv+gt0xi3Fcq7KqpxUmDaFrPZEBTCUyi2Wvlq0rDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com; spf=pass smtp.mailfrom=digigram.com; dkim=pass (1024-bit key) header.d=digigram.com header.i=@digigram.com header.b=KICeH+Cw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digigram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digigram.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4200ee47de7so41527745e9.2
        for <dmaengine@vger.kernel.org>; Wed, 22 May 2024 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digigram.com; s=google; t=1716379952; x=1716984752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1r5Pa3Vo7yQTIuSK4P+PIC/FKpd6kEGJ9bj8MHq8hNY=;
        b=KICeH+CwR81KVQpN/QIE1KZRCSgPY7uV8mjsraF1Gj14g/G3yxM4jcyN0kod48VBGN
         HRXMgtMNV4ltYIygS2hhBlkchhIrLsaFFbj+HUDUtV/qv4dJxo8epUhxXO8lT2z0ww6Z
         fHfyJpiai/snxVsCurn2rx5JvSy8afXAvEzNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716379952; x=1716984752;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1r5Pa3Vo7yQTIuSK4P+PIC/FKpd6kEGJ9bj8MHq8hNY=;
        b=jFzBdjvyHDMbP18GftwBG3ilapvp4W+gqwXBiN1c4kbc/SQGKxXYu67agCd7NTXpZy
         P5J3e0o9Uti6KUcVhBctwfMmSITBeLyTEKrJ7Zfcj2Arb8dfnNXT5ykZiQi6Chla2Im2
         +Up4Th7kCxuwW61GSJrp08HoAuZPi0MM22JjfVxEeaRfyyTztieziEttLWleVnu6rFhg
         yRRABZV2anu5vVZJoQDDAKhVo/2uj0gfdZQ7wha2XtcAyc+4bq6u1wQFq8SpBo6+B2RG
         S8k5/gkauzgIj0OJPtVkySIXtssmchKYTYCczD2u4WPYDT+pfwZMrK/SSUvcbbQdOYkD
         mntw==
X-Gm-Message-State: AOJu0YxcUR1LFG5jb791UrZvpKRbF//vZSaNM80Ei0zZBYxlBJ3EGDXA
	flBeaHFjxC3CL7w9+uNcSiqevbKUadOjL54Q7fbX/0nYDo8J3NVVy0x3qMdx/eGxYoCMwAhGg9C
	u2OWMEUK+s4STnMMfJu7FtdJlmR1T1m8Pa0SvqLTYfPUPwoibiDk=
X-Google-Smtp-Source: AGHT+IHWJ0N8HDK1voZQ6blXSERrLd+jccs/sZsDk1pr0ykUOUmooscXVgxLd2tC1GcPYg1mLIrTuLvshXhxyaTnJfk=
X-Received: by 2002:a05:600c:3b0a:b0:41d:7d76:ffd4 with SMTP id
 5b1f17b1804b1-420fd2d7decmr13864585e9.8.1716379951836; Wed, 22 May 2024
 05:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Debief <debief@digigram.com>
Date: Wed, 22 May 2024 14:12:06 +0200
Message-ID: <CALYqZ9=pVRtSY=w4hG0R3HEM_Y=bpLba2_jRcvcZX4eLX5Yw-A@mail.gmail.com>
Subject: [RESEND PATCH 0/2] : dmaengine, xdma.c : NULL pointer check instead
 of IS_ERR() on devm_regmap_init_mmio() call
To: dmaengine@vger.kernel.org
Cc: lizhi.hou@amd.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Reading xdma.c, I've found that the error check of
devm_regmap_init_mmio() is based on NULL pointer, but this function
uses the IS_ERR() mechanism.
I hope this helps.
Eric.

Here is my patch (I hope corrected) :

From 14fbbcb3425a5d0ee5e9ae92aef6f7ae4d1e3c8d Mon Sep 17 00:00:00 2001
From: Eric DEBIEF <debief@digigram.com>
Date: Wed, 22 May 2024 11:54:54 +0200
Subject: FIX: devm_regmap_init_mmio() error is not a NULL pointer.

    This function returns an error code which
    must be checked with the IS_ERR() macro.


Signed-off-by: Eric DEBIEF <debief@digigram.com>
---
 drivers/dma/xilinx/xdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 313b217388fe..74d4a953b50f 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1240,7 +1240,8 @@ static int xdma_probe(struct platform_device *pdev)

     xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
                        &xdma_regmap_config);
-    if (!xdev->rmap) {
+    if (IS_ERR(xdev->rmap)) {
+        ret = PTR_ERR(xdev->rmap);
         xdma_err(xdev, "config regmap failed: %d", ret);
         goto failed;
     }
--
2.34.1

