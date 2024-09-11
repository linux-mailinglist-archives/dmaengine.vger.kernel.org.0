Return-Path: <dmaengine+bounces-3144-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4FA975A80
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 20:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2751287206
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 18:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A91B531E;
	Wed, 11 Sep 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+1Q7FJ/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688C71A304A;
	Wed, 11 Sep 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080444; cv=none; b=VEeSN2VOJdK+vUw/BszGME4KETOP4Ym6V+oh/Eb5lw9Gg+niHwu2Y5iwof6X9yQmCJP4HV2vGnr/EdCDrdwgzDwZP6s+tNIfTj5L6MlMs+qsMUeknAYrJdp2TXDiXAF4lEDlkIawDRNtuITWAvkolJL1459+uD7vCvC/crrGj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080444; c=relaxed/simple;
	bh=XR5bzqdsJrDGK0v+QIt30Cp8anjKu0R3ZiJNTyZu2i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sPlYbelvej1+4vLQ2ILiLT7i+8dQqrXwvYngWWuGD6DOaq9kbxjq5j+ma5A5VGN/GMaok/YN2I2Y6h9uqshR+DAYGtwuH040TfkHWGhfeNCfzTbbocMrPMRXTlZLaW2H67LLUV0Bn6dz4XsbZwA1WHBwTkxq0R3tQslTkW7d1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+1Q7FJ/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f763e9e759so1750791fa.3;
        Wed, 11 Sep 2024 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726080440; x=1726685240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUguyS99D1KssLyBrohTuPk7R4iOV771bg153OXzj+0=;
        b=R+1Q7FJ/tZnVIP3IsK65r5adSVzYVJWHLzhhU4pyxH9su+6biYs4t18PRMK2FCXJY4
         uJSoR2eVzQYBntdoBcwwPYqzd0MpOk9k8eo8GJR0/fYI+wUmvr+45+BtdBz2KwCQOe9U
         UxUmm6BXqIM8UP6PTYYRdCD/mB2a9qNAEAyEe2Q836aATHdaDyBo6yqHNfOnVtASESmu
         HTSqMKfpCVbSqKAtl8efb28AzNjzqHWwA0jP0kJVYrJ6QJ0PJducw5BYKNA083v9g1Zq
         +igNV2haAKC0uk8fjGIP0egX5bMsYFPtit16mGndgbkjYJUI316zbvvdCOQDLBYBW7eV
         b5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080440; x=1726685240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUguyS99D1KssLyBrohTuPk7R4iOV771bg153OXzj+0=;
        b=wDwEG/OYh1GLCF4GohDPcKZOFIh0i01h67DP7IUAo0i1WqGlnnAjhemQTB8uGC6DVX
         VWZ1wZMzGh38wJfmR5pUq3iEkEp+Humbpc58BJ0YEN2Cx8g6FnyenZJwg7Bel7+OoGe7
         D1MKy2UZ8nM430bBkZre769btzRATfhTaN9C1ZOhGpDK3venW+QzcoVwI1CIHxyB+0MA
         h3FCzAylreFPqS9uEpw19eCd9aI+ARbsFxvdGBtuRq+abXvooP6EH3Gy7rTZISDp6BRx
         XtAs1MXl/o9dD2EkPQK6itV6MK8qvljPoozM5HmDbN+Fx6ugBdpIERAid6BzzZnU+/nW
         vmYw==
X-Forwarded-Encrypted: i=1; AJvYcCU4/rJT1uDiGVUUrf7y87T1nrhJTSqhzGBwI0y5MnZ6Qyi4G4MvppuUS9y61cHvUBECyDdIPHx1XEMg+aea@vger.kernel.org, AJvYcCVOGDrnX6W0Rrz8FhqsxgNnpzZasSdNJd3Auj+Q1oxRNhk525GuQShEcvv8yFc2wv1fK60vNb9LbzM=@vger.kernel.org, AJvYcCVjEiaV4T0PrXmjuHxN83PyXy4CV9WrA1Fz27TloFCiQJnRiVPx28aKei/uigD2imvHrDJX/zJZ95teAb1T@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpX46g3JJYMB/SVlQyWT2ExSOb3lX/BMjPDGvtrbCfdjMonyC
	tB8OqpAqQOi+dMAVUUloaKHw5n4eCzGLzQQu1SascqqweAuKyU7QCwCpvQ==
X-Google-Smtp-Source: AGHT+IEN8qOWgpIUkneWFcMdaZkuGXDQ1bjzD47XBVL43ns9lB6yuwQOtgmGbuGBgCf463X68Y3xuA==
X-Received: by 2002:a05:651c:547:b0:2f5:a29:5a42 with SMTP id 38308e7fff4ca-2f787dc3dc3mr1298031fa.14.1726080439438;
        Wed, 11 Sep 2024 11:47:19 -0700 (PDT)
Received: from localhost ([185.195.191.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75bffc9edsm16547671fa.39.2024.09.11.11.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 11:47:18 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] dmaengine: dw: Fix sys freeze and XFER-bit set error for UARTs
Date: Wed, 11 Sep 2024 21:46:08 +0300
Message-ID: <20240911184710.4207-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The main goal of the series is to fix the DW DMAC driver to be working
better with the serial 8250 device driver implementation. In particular it
was discovered that there is a random system freeze (caused by a
deadlock) and an occasional "BUG: XFER bit set, but channel not idle"
error printed to the log when the DW APB UART interface is used in
conjunction with the DW DMA controller. Although I guess the problem can
be found for any 8250 device using DW DMAC for the Tx/Rx-transfers
execution. Anyway this short series contains two patches fixing these
bugs. Please see the respective patches log for details.

Link: https://lore.kernel.org/dmaengine/20240802080756.7415-1-fancer.lancer@gmail.com/
Changelog RFC:
- Add a new patch:
  [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
  fixing the "XFER bit set, but channel not idle" error.
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.

base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (2):
  dmaengine: dw: Prevent tx-status calling DMA-desc callback
  dmaengine: dw: Fix XFER bit set, but channel not idle error

 drivers/dma/dw/core.c | 144 ++++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 69 deletions(-)

-- 
2.43.0


