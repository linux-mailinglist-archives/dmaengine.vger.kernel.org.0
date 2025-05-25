Return-Path: <dmaengine+bounces-5262-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77620AC3676
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 21:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F021894738
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B7525E454;
	Sun, 25 May 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0gH0rhG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1CB25B697
	for <dmaengine@vger.kernel.org>; Sun, 25 May 2025 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748201175; cv=none; b=DXsHZJwRAM2ihqOEshS5Sie4yYTD4P2u7VwDb66uYSNKQJK7+SY80/x6CEtlscdbgxiUi1dagnOvYRLpigGsQ4PEAKrrPe0DjQHvoNo5k+opmrV2vFz2jdvDYKtvs318uaa4foVCOHvSROPv5nAchILWzx+PWyf8jWMRVWFBVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748201175; c=relaxed/simple;
	bh=jE7IlBQlM0F3rIIfVaJxXemnfRPX/+Oc/0OR0K58/Tw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EG5VyyzzS1Hie+TnyLk7teePgMGXD8NDm0H4RoN0vglmYgRn1odGWrQ3YdC+FZT9LrC7tWQutLzoyw7BG8l/TmUW76zTOKL3mWx6uSFnqOWob220QWB3e1Fwf5matPWIov/i11Dn7PWKzvfN/1xAG3lzMzTTZRkrm6NC3IrWoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0gH0rhG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-602b5b4c125so345730a12.3
        for <dmaengine@vger.kernel.org>; Sun, 25 May 2025 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748201171; x=1748805971; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYX2VxTDW3I8LwPElWAPGFQp/0/pEA9CwguT2DQks9Y=;
        b=r0gH0rhGMr+1FVNQ68Flvrf0W2kPz0akxB3UVMJtJbgWWQK8qP6SxMqKHVrmIwgj7k
         HiOmPnUWK53GR5jy/wW1lp8BcMc1BOowSeWuRfB+7aOm+i0r6d2pfvia9DtYPnOp9Wfm
         ciUiq86UBte0Ro19dtLG4AwNJ+Hwk5GDyDFqK+GB4ss/kOdtQIiqzxLpNP1SNy1FPluc
         YytPbes7tpHvxpIxrh2Wq8NZCafk8RmvPToSWnqminbp+og5aiPJoPXI67D42Qz6HjkN
         3JyJKPUmRrKULsOVp5xRUxSZU6s/jCvOpntd8wrw346lyGlyMvdpiSctkeAiq6zMI0ng
         Cn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748201171; x=1748805971;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYX2VxTDW3I8LwPElWAPGFQp/0/pEA9CwguT2DQks9Y=;
        b=iHFCkadUVCMvRNjUxnr/TirTqy8KZaD7CiKAVKtdkFByNgmxDhLA6KzFWXQ0wOoxul
         SzplerQKxArR0QSvbZcVb7RErr9A7i5QSPQ4KaOx/Fgx7BXNVnq4zW+/LmDAOBezt6DY
         CXB+T2IHuGa9BK9AhIMy2PyjpYJE+erlOpS62UtGPcNYl/ImsxyC4wAOBziX05p9tBW8
         JzFMzvnj2GX4Fe2Bq+mRGzrkCw5Xk/jecLsQcMqXJWMW6D/5tAdvdaVJYwydp5ykAkx0
         LmIjZMt+5r56Hy1I7E2wnhY2326YGCH3RK91ga+TviY+cZyQvPT5lRzpe1ObtmH6G/Bs
         FBfw==
X-Gm-Message-State: AOJu0YzDyRzlMW49NZfjAvisC4fBZO5eaazgZhRwFojdRDokleG/dBlh
	9fR8bFglxieV3aOJozVjUnRbKPTSRiJq3Peo62SK5vXk5mUW5Tbmm9wl1wv8n4lOsCo=
X-Gm-Gg: ASbGncvjkFrrynk4rV3eGc06fL/RqYTnzPOpsZWQWNUKQdK2bQq7dHi2NBpIfYi6iO7
	z5iBXnzxDyPmblomAwW5dja+Zi8MVm7P9JUl3myuTQs2Vr62+ilcZBGX1XusbCQb+XY5PXnuLmK
	6xcK4Hm4o22+Lh4SgTQ1joCl7iI2tH+EpVX1fvsP0jA22YJzk70U4MVORaK7iZWelqmvgbNq2Ti
	K5naxBACn2u6R0ArvKlPlY2e4mjTBxGIG7eI+scnZqQp6ArNVNGTfTyaEQ2vL11DWOyivboMjC+
	aWJ9STwbV+VaJdhjSALLf8nw94/+OSsXr+hlWXXxCYQSjpd7f5EHv4JbzUANsk8hUVvdSq4=
X-Google-Smtp-Source: AGHT+IGY5IBd1z66/du4TlRG+M4D5MbhMOYD3sYEIBAG5BcmYK4WZDTuR9Zx90TCb9Ox6R+6iJuIjw==
X-Received: by 2002:a17:907:1df1:b0:ad5:2b38:aa6d with SMTP id a640c23a62f3a-ad85b2ba866mr163136166b.13.1748201171003;
        Sun, 25 May 2025 12:26:11 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d047738sm1578899866b.19.2025.05.25.12.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 12:26:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] dmaengine: Minor fixes and cleanups
Date: Sun, 25 May 2025 21:26:00 +0200
Message-Id: <20250525-dma-fixes-v1-0-89d06dac9bcb@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhuM2gC/y2MQQrCMBBFrxJm7UCMDEKvIl2k6URnkVQzUQqld
 3ewLt//j7eBchNWGNwGjT+islSD88lBesR6Z5TZGIIP5CkQziVilpUV/UTXnDhRDh7Mfzb+Hab
 fxoMbv96W7McIU1TGtJQifXCV147/7AXGff8CnALkdIwAAAA=
X-Change-ID: 20250525-dma-fixes-0b57fcec5f20
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=962;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jE7IlBQlM0F3rIIfVaJxXemnfRPX/+Oc/0OR0K58/Tw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoM27MQSnocEls/HhQypawyfu0BaUs0u0+VFH8/
 /LERg9+uXGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDNuzAAKCRDBN2bmhouD
 1zf3EACNIKCh/Z6bW2K+8696jp9c86f5Qs4KVSWacPTu2cHmrNBJIn0WXa5/WYZcbiC2lr6sBaK
 k+VkqgovuPRqo9KI+SX9nkZlYDV9k1qyFvTxznPWnfgkwYi8XK7Dn9+OBE6Arpc8PKM/AtHONXs
 NWHz/Mtti04KKnhOfalOUfCtQDoHvlMhpzQlSczCdyWVLT4EJ8tjPkWkAkhjUI+bpKhafYzDq2X
 IzefUKT8V0k2cALakyGpcCIwbPsMksym6/Iy8yr6Ie3hA/g6hktIK+AUrEOGZjUIPpikxeFSFtY
 hyKyE6s7Bz5HqDqcy1d9NrVSeVZJaIwStYfPuHKy3c4E2o9ZqBPyftfQPwAhR93dkamRFWTLCKf
 /DAVoPB7vI5ao0CtQCW3Sf7dCy5PBhlpK9TiPYtssm3isdrxuGMOzUyAfxYHfsNZT35G8hlUTlW
 /tmKhhniJazrUly4qWvzW9WMUU3Xlu1e5VthTvRqYfxHnUHXpVGIwn8A87nqm3ZIiZS5RyaOjUd
 U2BIg8e/2eiL/rf7oNg9iF3+hqTRpOQ9FSHz274Xf3GTE/Oz9Cq7nKxo3K6hnbuX6ZDgtWsB6of
 W01lh05oTYSiFRn8fVKSnfx19Z2BX0INqDhjcCRr8KTuH7PyXHMqnhtS2fhH+cBeT+QseEBa6Gh
 YNKMsau1w76OABw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just few cleanups and fixes.  Funny thing that the reported cast error
I fix the second time.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      dmaengine: dw-edma: Drop unused dchan2dev() and chan2dev()
      dmaengine: fsl-dpaa2-qdma: Drop unused mc_enc()
      dmaengine: qcom: gpi: Drop unused gpi_write_reg_field()
      dmaengine: fsl-qdma: Add missing fsl_qdma_format kerneldoc
      dmaengine: mmp: Fix again Wvoid-pointer-to-enum-cast warning

 drivers/dma/dw-edma/dw-edma-core.c  | 12 ------------
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c |  5 -----
 drivers/dma/fsl-qdma.c              |  3 +++
 drivers/dma/mmp_tdma.c              |  2 +-
 drivers/dma/qcom/gpi.c              | 11 -----------
 5 files changed, 4 insertions(+), 29 deletions(-)
---
base-commit: 781af674a40df73239e8907d5862fd6fbcf01a9a
change-id: 20250525-dma-fixes-0b57fcec5f20

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


