Return-Path: <dmaengine+bounces-1846-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41A08A7160
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 18:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0479BB234AB
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D57132C09;
	Tue, 16 Apr 2024 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktn8pm/i"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB013281F;
	Tue, 16 Apr 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284957; cv=none; b=j/6qPcVFlame3m7/u1vP/5U+ekdhe1FFh1VVofEskX0e4gUarwCdLtirA9r8LLIco+0N7+zPWX87iJfbEOYaMIaEeHo7jitJNKYXKbeXIqYO1adAULjpyFCFkYnml0KkhjOfKeNCaKfI2RC2PVS0Xitshp7GUu7acTJHMm0Wmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284957; c=relaxed/simple;
	bh=ksIMmot1Zu3RpcmxxuMwT29YF/YfRaoJNZVygL1gpD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f6HxDpPJTq0FyXpNYmMJxcxBqUZNLQuQNnW2DwlwBJu2N5AFFFZJBjbaZN+mCfmmAv0xKI5KSsWX3cX1KvjEU9ku7JbFk/AnzWQUs/Iysn8u3V2WiTZRDVj4z//DNgNfsz4uFqGYhOfpW4mURAfAbEBND7/xZe4difN/EOSgvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktn8pm/i; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-518e5a74702so1700757e87.1;
        Tue, 16 Apr 2024 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284954; x=1713889754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s15Rb4mbYoAFWiPnMFdoi3VC5Ubr4PDTS6LvLNYlcXw=;
        b=ktn8pm/i2O4AkjDHmO65wO1mu3aNwa5jaAtodBuLpBXcK9C7DzLnDvYgX8kBOc3X+X
         wo3gBQuD0i5x6l5hRQUC3Yvc6liDmOaTspb9SVVEwDtQcMe2m6c+B2l0+NCY3rQO648a
         WkLkumaakOEPScmSnnk6ym3Zm2tCu8q5uMPa5hLZq/ZZ4D2nl7F/h/u8XU2YI4uuehNN
         pvGpE5rnw0qPLcuUA0c7bHV6js4Ibs/VI31cGSHUHUYGTnqouQQhm21CP0KanjF5/ywC
         qZODyY8mIOm2HUFTmxs9HyjxAxbhqGSoWQyxLfEwhgIRoIwh6jNBdcs/ycooOd1wR5Jz
         rtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284954; x=1713889754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s15Rb4mbYoAFWiPnMFdoi3VC5Ubr4PDTS6LvLNYlcXw=;
        b=iYrQ+AGu4CMU+zKcK9tMe7mdxW22RsdLunt+8y/dk5TArpv3B39hUWZw2seT0p5QUY
         sgIddpoSas+GZVoecsqWX0DWJYgtOtuWk9peUENCNbUciMSC1ixHW1VShWC+9RBSslYW
         VFN1CkpOqIfaX6fSe0fQlb8fx3OmyGuC74hPtgXAGxhdDy8CrCRqsLTpWyzMu/FNNIMd
         mOQF5++GLEgnQKu7gPtdX+yabXBQPrMNYPvRhu1L0zmGms45q4CMTLWNK9hzHGqhpOc/
         bajvCKxjPxS1NjyegsHCax2tvCEFc/V80Qy/ngwTmZx5xuuGGmJ8bLp1QwiV0YroIosj
         AR3w==
X-Forwarded-Encrypted: i=1; AJvYcCW238vy0erKGs5gHgtvijLJERk7q6ay9ABwHY1DtrRUpPhx/zZMwRBqppBYmHBGjVpJrksSm8Ncsw0k5aaSw2uQjIiKFITEw0Ds0AS9bHcAm+FMARzE4Rmkqe8NyflzrY7Fvm7LsqYFB4SP4s7IUi7zDYUMEnlzyJYwG4zleG287Tm92EHJ
X-Gm-Message-State: AOJu0YyrNUVojxync6oUddlNFJi6LgLe2eN6RH1mbneXUtSNuhZGRqlq
	sQLZqgQk0J2SHHADui4p7zMVfykQXTYS+mx4vtCHePqlQsW1/kSDSWbE4+rZ
X-Google-Smtp-Source: AGHT+IFvIT7a3LyG7ZK2+u/Vq1k1OtnoQS4CB5Ryc2C7XVf5KJW2tjeLVfSEBQxGOfJpz6kkX9uU9g==
X-Received: by 2002:a05:6512:e89:b0:513:dcd2:1267 with SMTP id bi9-20020a0565120e8900b00513dcd21267mr1342082lfb.23.1713284953511;
        Tue, 16 Apr 2024 09:29:13 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id i11-20020ac25b4b000000b00518a37a7c2fsm1080400lfp.51.2024.04.16.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:29:13 -0700 (PDT)
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
Subject: [PATCH 0/4] dmaengine: dw: Fix src/dst addr width misconfig
Date: Tue, 16 Apr 2024 19:28:54 +0300
Message-ID: <20240416162908.24180-1-fancer.lancer@gmail.com>
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

In addition to that two cleanup patch follow the fixes described above in
order to make the DWC-engine configuration procedure more coherent. First
one simplifies the CTL_LO register setup methods. Second one simplifies
the max-burst calculation procedure and unifies it with the rest of the
verification methods. Please see the patches log for more details.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (4):
  dmaengine: dw: Add peripheral bus width verification
  dmaengine: dw: Add memory bus width verification
  dmaengine: dw: Simplify prepare CTL_LO methods
  dmaengine: dw: Simplify max-burst calculation procedure

 drivers/dma/dw/core.c   | 97 ++++++++++++++++++++++++++++++++++++-----
 drivers/dma/dw/dw.c     | 43 +++++++++++-------
 drivers/dma/dw/idma32.c | 25 +++++++----
 drivers/dma/dw/regs.h   |  1 -
 4 files changed, 129 insertions(+), 37 deletions(-)

-- 
2.43.0


