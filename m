Return-Path: <dmaengine+bounces-3254-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A6898C7D3
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 23:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D25B1F23A49
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AFC1CDFD3;
	Tue,  1 Oct 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktU+4mAx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612C1CCEED;
	Tue,  1 Oct 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819950; cv=none; b=k2aI1jiDVM9PDymK5TFzfqJGzfoJT7kAhN0ofFDjC7k0X9eaiOiwwOqSzRTLhTVKUiULyIv/pd4IV+Wh3NC1yipixqLanTqw1l3lCGjMRyaKpQqopg7ztnRebTad545lk6hkmp5BcQattI1do2u+SvqknXWNmYtU5WRBCtA2gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819950; c=relaxed/simple;
	bh=JyzSfOE53Dy7LtlzvjUhCGKUMpitkeVmuYXygqbY8C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cglqJQhlrsudKVTBT9qz6jbcRy9KZYa90F3s6K7bxbUvOy2pXgqzP9gm2cEvj8nAS+oB8JXh+5s8ZTuiheo9QyJhsvWti+QV3q4bXp4q0RAvXGute7/4fp7XtHL3HjZBUmKL4CHM4Q0B/gu8YX44b1rVEim0VrDsOigziZNfc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktU+4mAx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7179069d029so4383305b3a.2;
        Tue, 01 Oct 2024 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727819948; x=1728424748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJHVCeNkygGx2vdxcXn91pROegM9yg/N+fJhSdaogvw=;
        b=ktU+4mAxdgDRKHef4ApoWLZTY/O1dNVAiISgrk1o/ANuThdKf8Ut5/7C+wKcEvg+gg
         pSN7NAx5+b4D8waqYKlwsEUM8u4iAdwtbuBs40nGuKmDoOkLko29l15zxe1yaHtta8ul
         Mw0acVxIfyGZZiVpYu4HBt5HEKd2ojZStJEsKjAN/HxfIUEDL9ZKSDvvmjNXOi2D+/OW
         F5NgS63QBuEpX7uViLHS9cSfBKkgurRQiGJXG3Kf/FT1RUuFpfhzbGAb3rwxVXJimYm/
         b6VVqylFxuTtCF6/yUImFOnzo2MGrCg4qXy13vEB3QE2NKgOynu7UjZESlkyb2nmxcXW
         tOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727819948; x=1728424748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJHVCeNkygGx2vdxcXn91pROegM9yg/N+fJhSdaogvw=;
        b=ZQSNLSg+FvHQQtk4zRpi3OUWdJkMh4EzKsAa3rdL1pYcFbWS96nFD1JFEDnpPG7/lO
         6zLwxHsB6phzhzqzLtZvK6F2BbjDtC2kP3HZDecnCrNxiPG9ieFAaatoGCbHEtdpVei1
         tGtvW+WiTwwmsF/+/g4eIbUuXEJ7UeGAXWuB9FEPFHTpUccrR5a1mU2NtlS0t2l3yNB5
         fTu6x15xm78yHSo079dxJYE0xXo+lH57AJexXE1uPFYuADuv6iy5vBNhpzjFFBFpaf0T
         8EOkgg0yjtE//ku7XsmRz2YBdWO+hs3D5ZONESfG2A6Ukf2AuAxoKjte7J1tKCNg6xNE
         Bq7A==
X-Forwarded-Encrypted: i=1; AJvYcCW26ylHnAmMa5jwPny3A2T0y1qE708oTfsiqt17BjVAelo7OF7tuEkZp2wFnog0OuHzZ0f8DwCUfut0gdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNsQbNu0ocWsmWWg2ZqvR6K451zmvEJvMHJq69scUSPd+m2SP
	OhJvi6XByk3s7yshhhnKeq8/cchRNmnkuCuDQmuCX6I15180m2S9B6gddsuF
X-Google-Smtp-Source: AGHT+IGjsFw2VthOjIRamOaacLbK509L8WZ3nAqzdv5Zw7UMmmKlhn0D7vmOS/ySe6+uLk33+yrGUA==
X-Received: by 2002:a05:6a00:2441:b0:714:43d2:920f with SMTP id d2e1a72fcca58-71dc5d6e9a4mr1603854b3a.25.1727819947912;
        Tue, 01 Oct 2024 14:59:07 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2651630esm8599162b3a.109.2024.10.01.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:59:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] mv_xor: some devm cleanups
Date: Tue,  1 Oct 2024 14:59:02 -0700
Message-ID: <20241001215905.316366-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devm cleanups that are now possible.

It's interesting that this driver lacks a _remove function to free its
resources...

Rosen Penev (3):
  dma: mv_xor: use devm_platform_ioremap_resource
  dma: mv_xor: use devm_clk_get_optional_enabled
  dma: mv_xor: use devm for request_irq

 drivers/dma/mv_xor.c | 53 ++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

-- 
2.46.2


