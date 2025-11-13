Return-Path: <dmaengine+bounces-7142-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36241C55F94
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 07:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D64C4348FFA
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CEE2BEC2B;
	Thu, 13 Nov 2025 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvbFTyxF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD982BCF6C
	for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016590; cv=none; b=oy7trAaCZMhNX5UGsjB+9lH1Kmf+EpcY8xXt8oUZCZi2tz17K23GO58ykicBbJPfaHCHX9eefPT0bDjpT7E2niCPO/Y7fyUDSt6IyUKl03t75+HIB5kSbQA7te+O4Jqd+REo1jcpgvROdp2MSuDT9rKyqMrfDoIgt66s9urqBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016590; c=relaxed/simple;
	bh=29nAki8ESaO1fL9aGhOKACF0bJg24F8USzUzT2R+14k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URxI8/nn8l8jx6CqbjqN40z++pvlb0NTgN6FZax9O3jf5cFzTshKdl4YW94pO1ypw2IdHKe5OLwNgBPlu718EUhi9ZtzMnSCl/hsO+rWO5pFgOD9X+04TaqYkSfCwmMGXPWDwL+tlvu4LlL0SF6WsezVeHDDBDGLh15iy3ZNPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvbFTyxF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34374febdefso463006a91.0
        for <dmaengine@vger.kernel.org>; Wed, 12 Nov 2025 22:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763016586; x=1763621386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T84pQ1+9aq8AWuzbsa/zDb8vuVA7/GAGMhFUb/seRIk=;
        b=XvbFTyxFH48sRBlCsuND1ti+4HkLaua4NcMYB3AsL/8Mxqm8SpmHlKiW9F5EX7PxQs
         x8Kxsa6+RDM4CkXHHtCWHxXmYsJabD5wfjvs+BLf2k4oxhwX/YtXCAep8TjpymS9/E1H
         Uke8t54lZX5gEVSC2gm2xcM+rwasguzDZJxSYeeaAqWznRBQy5AzCbfkpTffPYHkgMNP
         i1rSSQ2ZhSMpk2kUgYqjhofIWRioc4rGeaTQ6MsqGG+rVtqKXEjR6EiOLdPIQ066k79I
         Z/XwMNDWspfslUrWwnPWISv3Su7HiT/FhchV3yceNXw8ceR4WfI8d2ly/vZSwFeO1/xD
         hw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763016586; x=1763621386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T84pQ1+9aq8AWuzbsa/zDb8vuVA7/GAGMhFUb/seRIk=;
        b=vLNrBil7tfyPMlMxaYSObyh6v2EpRn7h9uQhuAtuJqFwKtaC5D1729g3Rku3U6Ir8z
         MHQnkOBQkelCATRim2djSwHbLTVamIZ3y059iJ4JjP8oet/DHBZCa1a01ioy1xEkyqD8
         r1CTVRC5nDrho+i5rqLEuvY1rdECfWcwRrAJUbuuum/7OKPlkHpmCTyJFXvu3UTuxgSE
         xKoC/E4Q/oEis3GwArE66VKaOW4U8brUnm9S9Dz0nDhBwYJjCEhzwnJAy3rp22u5BSSY
         AVKDv+AkffeKIKOyWlz0Ttm58NU6nECDt66xnJiRX9TWb3z0V/WRhMa1lSKCsy9uvRC8
         tyOA==
X-Gm-Message-State: AOJu0YzLUdKTgwtgtYHgnWLCjPO29MFZgEYS3X61voi4luZ3cykSeQGl
	KWZQ8V5vM+hyI0p/tuGuUE6egg+ct8bUYNmBg2lO8LDtcB1SXfXAv0IqkwDlnGVo
X-Gm-Gg: ASbGnctbAt4wBV94+ouTV2FfkHGaM19w5yvl8c5j62FvfZ6K1jZFwPnoZEaqD6P2XSW
	ueFlvIK0J4Zz1ML7pH2lnio9NN3LjKObJn8sEnT179Xd+DqNMq3NtibGc7yEvUR4ubayGMTeaxl
	DTxtl8X45siCwmFthfnQHrV3OxQAlYHEsMoJOuKB7yeDBedxelM+SaP6XEcfnwINCUTRQmwGIDt
	4553arsM1boYf/EGuEQ+BZ3xv4cP8ls4OXXN5tT56BA0ocduGAuEhoI9T6Nmi3bXzeEWGhRWj6G
	SfilDbPzuIytwP1moT8dCIUa6n3H5t1MjeypuvP4EYSnkCgjrNSyXtoDfoCQWS4ha5bqRzcA6js
	eqEj052a/weogrUJEq1VfjBT5WrESq997Vp1WR5bFVWiTbdrydNEaiC2DFcVA7fwkmpWclyCqg5
	cXhNQa4mYbhqMXUpTbFYl+1uEH
X-Google-Smtp-Source: AGHT+IFcm/7eA7OM1o0lYGSXbMuGwXv23lCAu3vI178c0WrBUNLFpdQ0EvMHjhKjzvOvGwj6jeFaVQ==
X-Received: by 2002:a17:90b:5487:b0:343:c839:21d2 with SMTP id 98e67ed59e1d1-343ddef34c5mr6162819a91.28.1763016586418;
        Wed, 12 Nov 2025 22:49:46 -0800 (PST)
Received: from ti-am64x-sdk.. ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07156absm4838126a91.5.2025.11.12.22.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:49:46 -0800 (PST)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com
Subject: [PATCH] docs: dmaengine: add explanation for phys field in dma_async_tx_descriptor structure
Date: Thu, 13 Nov 2025 12:19:37 +0530
Message-Id: <20251113064937.8735-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the need to initialize the phys field in the dma_async_tx_descriptor
structure during its initialization.

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Documentation/driver-api/dmaengine/provider.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 1594598b3..f4ed98f70 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -411,7 +411,7 @@ supported.
   - This structure can be initialized using the function
     ``dma_async_tx_descriptor_init``.
 
-  - You'll also need to set two fields in this structure:
+  - You'll also need to set following fields in this structure:
 
     - flags:
       TODO: Can it be modified by the driver itself, or
@@ -421,6 +421,9 @@ supported.
       that is supposed to push the current transaction descriptor to a
       pending queue, waiting for issue_pending to be called.
 
+    - phys: Physical address of the descriptor which is used later by
+      the dma engine to read the descriptor and initiate transfer.
+
   - In this structure the function pointer callback_result can be
     initialized in order for the submitter to be notified that a
     transaction has completed. In the earlier code the function pointer
-- 
2.34.1


