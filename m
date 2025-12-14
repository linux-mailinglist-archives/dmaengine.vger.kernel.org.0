Return-Path: <dmaengine+bounces-7611-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 491E4CBC164
	for <lists+dmaengine@lfdr.de>; Sun, 14 Dec 2025 23:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAAD13008193
	for <lists+dmaengine@lfdr.de>; Sun, 14 Dec 2025 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B89233711;
	Sun, 14 Dec 2025 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPtOx1Qh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE418BC3D
	for <dmaengine@vger.kernel.org>; Sun, 14 Dec 2025 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765752426; cv=none; b=IFxBYelCFpwqUGpg0TIa1y/a4Qqghia4f/bLbQ6Rj9IB9b/BroVLp7zGIdtAICHtj0857nnLg/NRizfyps1qkZ671oA43TM/ibp7QeR0FteUzg/WwUeJQyMoiT3irj5UU8oWHdvYsVlKWOiTmKGb/OoFUNoiJ8kULUbRGuMEcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765752426; c=relaxed/simple;
	bh=fmzVuHJPOVl7ql9T6pRIoZrq1X2FcL4mYnQt2L9ZlyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0MoVyJWnzU1cEB97es4UY95VOUCebTzJv1NkQwt7TFKKoOWt2Zo8N8KBM5p3TklTXntTkhxuPxiqrfLfJ024SFKsSINBi39tPMoHbHY0K99h1bNp+sc5iaSsIn4r4V40IrixrM7sp1u7DsKh/MGKbAPe/FL3ziN/6vh76Ll+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPtOx1Qh; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso2754583a12.3
        for <dmaengine@vger.kernel.org>; Sun, 14 Dec 2025 14:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765752425; x=1766357225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQSX2LSFXSd0QzrN4pi98DPbRQ5Gqu2d9o2DvTxsgxI=;
        b=DPtOx1Qh7sgtRLnBxByGkTKeAuQ6xGsTS9/kwTOry9c2HhsKbz7AUqnzWGWmNBuilu
         51VPmzy+GmArcC+nYNDfWMcFJynCzR2Em6xQ+AwUTZKq9Ctv8gaY8q7fTOqV6NzIaZ23
         JH9YqXztNdiXj+4rCNrMZVq6aYag3o/ZcTiZNqEVll0m1kNlA+gA0tQ/SFVKvFnMfM2x
         6DvaIUiDiHkPyeu9Oqxj2E8O9m3ja+uJN2Zs505eHZbkHwm3tv1y9L4BYa0KD7CTNQ/N
         b/DJYX9clHOqQ4VhlMh8TVFs9L5za/YDp4TWd7kc63x8SUqNRUfrIeAQmvZxlPQWl1s7
         n3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765752425; x=1766357225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQSX2LSFXSd0QzrN4pi98DPbRQ5Gqu2d9o2DvTxsgxI=;
        b=CdObGmPHeHiL6sXsyrYRjHAF+usqPRjd+BkeKEhWnJ2xZ3HXYGIKQptq1f2am/mJI+
         DWzdCdI57v051BO/3BnUbcSa3v+BoweGMeHyGHlrHL5TULReFvGOPrY7/EJHhuY5syn2
         st5WOWAA1ppurzIR5Je6oNfZfuzxcl1h3BhaB2lA/fdI8oW722d6mqtp4T5amUM7RqkQ
         +5Aq1eaip0ccFlmXpmUHfxb8oDzH7TR+/2A9yuz/3kiGMGTr8CSZNLF1damFamKtldJN
         rnRvTMJFJ547znkRfn/pbFrde1ceMU3XbOCw9XsIPVELHdLnIq6foPG/LxAuH1KXkdmC
         wfuw==
X-Forwarded-Encrypted: i=1; AJvYcCV3U+R+PrbuwkcdOGoIcE4Yx2Hys/3IJbgEbpzAoJnivnwwgNJwKDaggdlHGG1d1kHyJnjnUVdTwiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZD4eTbnUCc6QWdcNJWgCv2KHD36LlsvHcYedPakeKOrlnalch
	rq5pN2O2CUXOFCwPXrCYMlpPLcFW50MaSYt5oAkaq/y74kr0j2BQCBIp
X-Gm-Gg: AY/fxX5Lf++/ZkFqkOvGBjELTa9+DYHqyUs+1X8iNBno1xYy3ZezU+/LFBDoBXIPp2G
	q+PyLCO8IEJvDktplMfWQmimS99fCm1DO0nrrwPTOTWnenmEW8XBAKdYEfwgaRU1u0oMFHPIvtE
	f353/bHu7vkB7tdmaxC73VvM+yVu+FLnYDdMgXqcHUJECX8WA499sMjoiIVtfZoLGLLKkNrt85f
	+w6xvVRJJclGFC3G4k5E3KrSmWzLuiB1Py6TGUaod/qSTpKufmn6/f0VPoh7k6OSKdPwjKlMukU
	KelXlvzBiwNCwmp1anFwr06OA2PozMRU2vPn0+T6aN7Uk45k6uTatZZGgQzWt3Vo1iJKZl0XVjL
	+xbxLnlu1cWRKfHFVa3bB8VYz/vNu3VWcUyR0JRVascYciijf3/cKT5C7kjzIWLR1FCtdC/eL6l
	dCYsIqDRz7cA==
X-Google-Smtp-Source: AGHT+IHjCMwEMhrIndkSHywWXlymB1MdGXVU8RHAOoQgNJtfIdi9BRjQB3e8/tXrqTx2dBHPGX3TJA==
X-Received: by 2002:a05:7301:f10:b0:2a4:7b65:1a16 with SMTP id 5a478bee46e88-2ac300fd6cbmr6728297eec.25.1765752424562;
        Sun, 14 Dec 2025 14:47:04 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac190d3d14sm25081258eec.2.2025.12.14.14.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 14:47:04 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: "Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 0/3] riscv: sophgo: allow DMA multiplexer set channel number for DMA controller
Date: Mon, 15 Dec 2025 06:45:57 +0800
Message-ID: <20251214224601.598358-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controlls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Change the DMA phandle args parsing logic so it can use handshake
number as channel number if necessary.

Change from v1:
1. rebase to v6.19-rc1
2. patch 1: remove a comment placed in wrong place.
3. patch 2: fix typo in comments.
4. patch 2: initialize chan as NULL in dw_axi_dma_of_xlate.

Inochi Amaoto (3):
  dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
  dmaengine: dw-axi-dmac: Add support for CV1800B DMA
  riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel
    number for DMA controller

 .../bindings/dma/snps,dw-axi-dmac.yaml        |  1 +
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  2 +-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 26 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 4 files changed, 25 insertions(+), 5 deletions(-)

--
2.52.0


