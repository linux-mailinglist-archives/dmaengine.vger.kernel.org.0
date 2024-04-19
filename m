Return-Path: <dmaengine+bounces-1908-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57D8AB494
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 19:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB831F210B4
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C77513AD1E;
	Fri, 19 Apr 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvh3occt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1CE130E5E;
	Fri, 19 Apr 2024 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549451; cv=none; b=PVjBbuZNi8Er3wDzcf5L9VuHHsIJOPw19th8L5RPlLfRVTchHXAG2K/YdtY2CaxJKyzAAnYzUJzlJDFU3n1b8jKttXRcP+2HCEHt+K12SoP0bN0kBJp0sv7TnOgdX7qYw8kvapdEVs8MS3EbKs81K2cPfHFDdVqB7WUhShO/3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549451; c=relaxed/simple;
	bh=8KqYsbZxPpbmqR7WVXJVcqr2/Dlmjyv5KgkXl0VbG18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oa976OKTTMYvSaPriwX5fR3vMgbOGBYZB19W1wADwjYmjLZ76mdDvjAGJHS7ys9+lQqsewlBhFymje6yZOKgGCHp5J7/BH0L6uN2vmw8fLXqCbURZqho/wAFlWqoVOXTlMU3lPN0AWgTdiHVi1o2bdtfxLMQyJG/gv4wbrKmCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvh3occt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so27535911fa.3;
        Fri, 19 Apr 2024 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713549448; x=1714154248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb7IxX2SneQa14Cc8sJ0b06K9/cpUqtMAYa24U3BHcw=;
        b=Cvh3occt76VX6l93zCc3q6VCi65q1CgWAjeTk5gHD7+A0SoEs3luDgTor7HkJ08wrq
         cd+IVak7MirCmRZoWvR5R0KOHJGCzKuS+23JyeCXddIZfqCoURXUq2sQh56gt2YzStKL
         rzygeSc6xM4aXp1kvUp6hDVogdgvJ7qnF+MlU3qPsa/zhA/qh5KqbPIUBV+ZNpxB0Q4C
         nao6d/lTl3nN8AUyHs72kmv60hrspZglhv5r7UwyceiA62VO7SnGvaaqMs6iDvlQECRR
         7IR8PFg6V+WNVQBVrqfGV5Ua8remSYpR5sLHbF8Xj85nj5SNzCbLEgbEQEUg4OpmscqM
         QQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549448; x=1714154248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xb7IxX2SneQa14Cc8sJ0b06K9/cpUqtMAYa24U3BHcw=;
        b=BMUSAPJ+XPnc+JFsS3JcW9lgHpjYAZLB5Mr9AbipXjfjNO0Ik5hqf/22eBg9K58oIX
         KGg2N6egD4H9tbfncOtg9/kMZlA+Fvks0HZgmsRAb+STtc02Vy8varzO+XUTBK9wrV0G
         ulv+RYhIycp/DWdtAaMk0BHqdiO225dJHAyeDQItCuR3wCud/6D1vu4MSfwMDTEq7NKW
         LUwy+8DoPHDbp/FSHDSvfqz21qTvIODkEJ3uGFzLYjgOCGNKLV23u8lbz8HbdOk3MbSv
         GOXdstro59qM6QLOPeBVVitYXoEc4A5InlPYfYom/hZj21BaLqGaffH8YVYvCXsupicc
         rvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSd2Pfkxm3O3m98NIsbknHoxpbBfSEMI54tsLAkvnU1sr+j9ZtBLUD7tdbNsBiXXEH8QjwXPJCZaq9yE+7QZmmO24Xl5fuj4ZdAioYhqgYv7b8lMlp+PUxYcTwrqLYCnoIYFT+5YJdSVvsFvLov39sSqIqV0DwSdZoQ6VcnFwVkS2RvETz
X-Gm-Message-State: AOJu0Yzbn2f7GqSWLiSPNTekLy1lsbCO3KS9j2Gsge6eKxG95ElxC+qq
	xxcx1n+vcHHE1YVA52V6bzRkNU+z+iEcNWonnLTNqr/Wqlq8DHOszLgJuQ==
X-Google-Smtp-Source: AGHT+IGHTEV1ol6nILJHFaiC6F9WEo56gfw8hOxNK0OccNJgMINBYznO11NulRZ78isU46I1Ys73Lg==
X-Received: by 2002:a2e:850b:0:b0:2d9:ecc1:6d56 with SMTP id j11-20020a2e850b000000b002d9ecc16d56mr1695817lji.11.1713549447402;
        Fri, 19 Apr 2024 10:57:27 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e9614000000b002dba279f81asm642625ljh.59.2024.04.19.10.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:57:26 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] dmaengine: dw: Fix src/dst addr width misconfig
Date: Fri, 19 Apr 2024 20:56:42 +0300
Message-ID: <20240419175655.25547-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The main goal of this series is to fix the data disappearance in case of
the DW UART handled by the DW AHB DMA engine. The problem happens on a
portion of the data received when the pre-initialized DEV_TO_MEM
DMA-transfer is paused and then disabled. The data just hangs up in the
DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
suspension (see the second commit log for details). On a way to find the
denoted problem fix it was discovered that the driver doesn't verify the
peripheral device address width specified by a client driver, which in its
turn if unsupported or undefined value passed may cause DMA-transfer being
misconfigured. It's fixed in the first patch of the series.

In addition to that three cleanup patches follow the fixes described above
in order to make the DWC-engine configuration procedure more coherent.
First one simplifies the CTL_LO register setup methods. Second and third
patches simplify the max-burst calculation procedure and unify it with the
rest of the verification methods. Please see the patches log for more
details.

Final patch is another cleanup which unifies the status variables naming
in the driver.

Link: https://lore.kernel.org/dmaengine/20240416162908.24180-1-fancer.lancer@gmail.com/
Changelog v2:
- Add a note to the Patch #1 commit message about having the verification
  method called in the dwc_config() function. (Andy)
- Add hyphen to "1byte" in the in-situ comment. (Andy)
- Convert "err" to "ret" variables and add a new patch which unifies the
  status variables naming. (Andy)
- Add a in-situ comment regarding why the memory-side bus width
  verification was required. (Andy)
- Group sms+dms and smsize+dmsize local variables initializations up. (Andy)
- Move the zero initializations out to the variables init block
  in the prepare_ctllo() callbacks. (Andy)
- Directly refer to dwc_config() in the commit messages. (Andy)
- Convert dwc_verify_maxburst() to returning zero. (Andy)
- Add a comment regarding the values utilized in dwc_verify_p_buswidth()
  being pre-verified before the method is called. (Andy)
- Add new patches:
  [PATCH v2 4/6] dmaengine: dw: Define encode_maxburst() above prepare_ctllo() callbacks
  [PATCH v2 6/6] dmaengine: dw: Unify ret-val local variable naming
  (Andy)

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (6):
  dmaengine: dw: Add peripheral bus width verification
  dmaengine: dw: Add memory bus width verification
  dmaengine: dw: Simplify prepare CTL_LO methods
  dmaengine: dw: Define encode_maxburst() above prepare_ctllo()
    callbacks
  dmaengine: dw: Simplify max-burst calculation procedure
  dmaengine: dw: Unify ret-val local variables naming

 drivers/dma/dw/core.c     | 131 +++++++++++++++++++++++++++++++-------
 drivers/dma/dw/dw.c       |  40 +++++++-----
 drivers/dma/dw/idma32.c   |  19 +++---
 drivers/dma/dw/platform.c |  20 +++---
 drivers/dma/dw/regs.h     |   1 -
 5 files changed, 154 insertions(+), 57 deletions(-)

-- 
2.43.0


