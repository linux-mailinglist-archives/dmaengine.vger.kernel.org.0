Return-Path: <dmaengine+bounces-2568-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0B91ADE2
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 19:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AFA1C21322
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A419A292;
	Thu, 27 Jun 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJvk8JmG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D301C6A1;
	Thu, 27 Jun 2024 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508964; cv=none; b=P/AgqIvwunxGjJBMyZLt0LG6YUQyMyTbZCx02GFoIg232jBiQDh7idq7nMFlu+JDOxXMogy0VYLrKjbaSNnmap1AaugmhcQrTaEEfaY5rCt/PetRJ/ES/oW+N/iqFZ5qz8IxiYaKdsTMrdncT8eoF4qJehn75KwKLg0QXbyCyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508964; c=relaxed/simple;
	bh=JGOEZ5Tm2D4nLMCdnsx15EawEOq2g50RQqicR1oAUYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f67hQCKMIMa8yoW8XVgh8D+bV2cMbjUKQziox27iXpdmLB0KcYJsvm6K1qhWPdJIgPUs00TCqSwyh1IJN9m0xCe8aGxk6StuMrTtUqdzzTyIBbfZPUR67b7lkI3TFKNMAXFyUBUnlf6TB9V51OjxveOoTwA80YE1IgtdxAEPW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJvk8JmG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so64458211fa.0;
        Thu, 27 Jun 2024 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508961; x=1720113761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SQuN64kMBEMrDTMkthTTQmcMNtDEEjHIDdkT3P8+2M=;
        b=XJvk8JmGK+XQFKOFUhhZJmrHz1pd8SGaQA1YmaqyoIr/c+WIXrmzE7rrRARXV03wmT
         CQGxnHVs64WqEHegMmNCeO0K6+VTJfkk5peCS9iPeBPgakGQvSz2lYwyvJTOVdpYsY9f
         d6PwAd3WZR7BU7DlgP1KCNwdqnxMGyOT342fqFpJu91u5wsU7Kym/IleOfj8RoojZyCk
         q2T1EVcLZkGZo7A0SmnwMihCz+YfMGWOIIa5Py82ziiGYNgSLU40G7w6PJeK19BeZGNr
         0rztTL+JT2F6pTuqxNePFZN0UbnEWOpy5e99nwrCB5/6u0dVKOg4mK3CIfKS8xWsXMst
         /3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508961; x=1720113761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SQuN64kMBEMrDTMkthTTQmcMNtDEEjHIDdkT3P8+2M=;
        b=WiQto2IKdpe0IW/1l3MkQcwx5mYRvSn41eODiJ1DKwgLWGkK6DCEkraMyMDzy0uqNt
         ZjPSbcpeUNqTclt5jYrPx5ac5FGLML1/zHUvfwr1oRxS49ZPTH53L0q3943EV7HQhqNP
         Di6++sXTh9LZWot1KPmcZXQJjqgQRmkeqWhON+P3Oz/RIETncqwMh3FDz4iU+tCobl+q
         v4wGSY9EF94IAk8oY8ZBAWvH7EJda0+BHMmraqvTGEuljnDRnjEtHgc47phkMDHLQ6P8
         5ujyNe+AZfJN/JRFZuBWZH6Q1+8AAeGvKcgRV67vF4VOLeoFONC7XFoYvBFue75XCLDh
         PRJg==
X-Forwarded-Encrypted: i=1; AJvYcCWhZg6wgobu2Y3EBGquOcqrZYnI51Uv+Na1j3mijs3/irq0C0HtUe8i43/9wm5ngkN+Nuuyky++l2nXZpOXWqQQS8EWcwJo+6dr3DWPsJ+ukj6OjJOIm5nFV7x36ecGMsiim6qncI/rxLJ0XWhUjU5x0rHUaeARtwdB7fhcPneJGG+Lm+Qr
X-Gm-Message-State: AOJu0Yx+OhT7AUYQ7MUPxVnVYwTkGt9sx44N2qAsxFaOjY4wj/VH26JJ
	uPnfLweCPtXIcho3VJFP9mKJyWSpFllLSsuHIToQZ/zijwE2xmbsY9GCJg==
X-Google-Smtp-Source: AGHT+IE1agfkKzRssvuaXjbBA3jEy0XkDdoTzKeYm9f4SZ2KOrUvWk1wpTnpe2H+dYbg3ntUhzwx1w==
X-Received: by 2002:a2e:b6ca:0:b0:2ec:4eda:6b55 with SMTP id 38308e7fff4ca-2ec5b2e94a9mr83132311fa.50.1719508961062;
        Thu, 27 Jun 2024 10:22:41 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a4bee93sm3181131fa.112.2024.06.27.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:22:40 -0700 (PDT)
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
Subject: [PATCH RESEND v3 0/6] dmaengine: dw: Fix src/dst addr width misconfig
Date: Thu, 27 Jun 2024 20:22:16 +0300
Message-ID: <20240627172231.24856-1-fancer.lancer@gmail.com>
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

Link: https://lore.kernel.org/dmaengine/20240419175655.25547-1-fancer.lancer@gmail.com/
Changelog v3:
- Rebase onto the kernel 6.10-rc4.
- Just resend.

base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
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


