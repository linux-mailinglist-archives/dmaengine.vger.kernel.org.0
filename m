Return-Path: <dmaengine+bounces-7067-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7996AC38DAB
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 03:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E52E634AA73
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 02:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BD92472A4;
	Thu,  6 Nov 2025 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/ilDATg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078B23EABA
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395867; cv=none; b=p2sJjjIUVMehIBw/2DjN+59HY6cAaU4VpdsBD1x0FBJNQeCMnCyLnuYF9MLj+ZPupJtWiDBtQkEsaktJMaalX5pCik1evtR0DJHvNj480qfsVeOrRI3Cq83qT88z5QtcTSlaHI3LvxU0I0q23lWyK4P+E7Gpu3SxnZvBGacjNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395867; c=relaxed/simple;
	bh=JWCfGgBmQQxrxuCl1RY9fu47jEEgQx2cBaxVGHaxX+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCI5PA+4wp8yb3jk79L1mK9NEk+8cMgoDENiTmbtPUQdp1TBgxnGZdtRe9OUSRpGj2IxaTNXMSITDT7g16Qowcu7jfNzPbO4PawRbnzjRFgtIjWp0xSbcRHMqirWi5n36F+Q9lBbQw2J8p4sSDb8pTKe+RfHK01s0U/wEYg5OB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/ilDATg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2953b321f99so5481925ad.1
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395864; x=1763000664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GaLlObt46a8EJpPZb4z/i0Sg3qenVChJ2WAkd7GSp8=;
        b=D/ilDATgeUNIqOnse/WKjaaryo85WsygweY1UQTyd+AIceGpf6myXR6AEl351g3zwC
         EL8l4d1ilspF0bw7vYROtQMU3lmwJiSxgXKPpA2gaOPhy53bA/hTnbDasHM/9w9z1yE/
         UzeVc/Pb+RthEh6JPhSupB5LzYVh/X/y4JXWLqUyZmN0lsdej4PHrTRax9XwMmPmBKBx
         K4syC1S/oYBoHHsUQ3ipmTISVC4xZfrm477URV+onzL3ChJSaezV2I7Ad7lt+tS3H+kx
         r80ASHnTlJ0Ce4BcrNtl7k2mlg0cl42zRp7nhBPRnw98jr7Eg3iv7ly2+Uga+FCvnJUS
         4q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395864; x=1763000664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GaLlObt46a8EJpPZb4z/i0Sg3qenVChJ2WAkd7GSp8=;
        b=ZfGdm26vGxn6wypzVKOdmXoyhAyvdOy/vjByd0DjOCFGlRu7QHjVzoyGK2iORrEN2t
         MkPJ2fxryVWIl26t2IyQzMQS/A+Bb0NhwaV2ikg7eoy0U/TFmoHzhq2T6I2gD7D53Z3d
         uS5H17eRaojyCv9FVxrSLhW3WsZcjkJeyJTdYErnAfZ3+qozXNEeZjhXtco0r5pMSGCe
         120Fu+jhGP9sNE7SoLPjdYqOhfFmaZGEeKevPAw17ahV2biU+hfKOl6S1DK2pH9PY+gY
         7Q9GSoYcsxOJWXbYLKq30oWECzpzlXOeMSfI87ry9yodH6PHtwECssJ9LWUrkYOLzwve
         G34w==
X-Gm-Message-State: AOJu0Yzp1Tvc5FGFR03P+0vY+5K6S4o381UKdQ6yiIKSkIhQH+5WyFtO
	S4QJ9SxLFG6dNBlSI+g8cHH0/eMLdEb4tQ9/N4sphhhzKELLstF8VNGjik3prw==
X-Gm-Gg: ASbGncs4uHqJRiQG/4yavH5JRd5HCdl1kKDxnMHXSjFfKSzxkQpEiIjEs1stbc1+KmU
	v2jtDQkWi9+rOJcWYcWkb4J5Vh8tE8R4SbHQYsl5u9hQN9Hga3B5tSBaoco0tm7RNgQ6d+iy+gt
	Pb2LOiP76Yuu3GZu9IJRBMTf/zo5sBAWVnTHBq2b+z2oqonjrMmdQQ25wWpgGR824YX5CtsrKhG
	opT6q3UTEY+2pg+o6qGabpTaC4VvyXI5PRc4vOB0aka1CFmjqq3e7UuQudZOsvEIDm8hDcSAEut
	WSVQcF9/VhmgKTyLd0ecDE0C874DZji2n0+kjHe9pBVRLlXmubARse0BNpfWOL43vnDfZKLnO6l
	uDJIbD2wzokw2hMw7DnIANOgIpYisRtkY5ymPDNytwUq0+2kaPdADQr3Rqg==
X-Google-Smtp-Source: AGHT+IErrz9agjCHsj6Y7R7pkGgYn92tuq2BTiQ/UIRvnUTq70BO/rMnUcWv2UD6iPMrYeceNuar9w==
X-Received: by 2002:a17:903:1ce:b0:292:dca8:c140 with SMTP id d9443c01a7336-2962adb9205mr76924825ad.44.1762395863655;
        Wed, 05 Nov 2025 18:24:23 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm9399935ad.44.2025.11.05.18.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:24:23 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP AT91 DMA DRIVERS)
Subject: [PATCH dmaengine 0/2] dmaengine: at_hdmac: support COMPILE_TEST
Date: Wed,  5 Nov 2025 18:24:03 -0800
Message-ID: <20251106022405.85604-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First commit fixes compilation under 64-bit and second actually enables
it.

Rosen Penev (2):
  dmaengine: at_hdmac: fix formats under 64-bit
  dmaengine: at_hdmac: add COMPILE_TEST support

 drivers/dma/Kconfig    | 2 +-
 drivers/dma/at_hdmac.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--
2.51.2


