Return-Path: <dmaengine+bounces-1518-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3C88CE3F
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 21:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76D61F81608
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA9913D513;
	Tue, 26 Mar 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqMvEOxI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AC13D2B2
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484642; cv=none; b=soL5c6L7DNtBL6Mu+LGEMNURNs5V/HoKn/V1HmUFAvl/+o7P8q5eqGQsEqplmDyn7J/MhDb7JEbak+zbD9ESyrEfCAacRH/KnBien0/tKwN4RZH8Bgqe+Vlol+R7dKsFR6cg+kOhT7pFAlrjUn41rayfrH67xSYu5g7wSWvXi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484642; c=relaxed/simple;
	bh=vLJVttyU0unj5HjuSsO9gb5EMeZQpEnywYmaCFIJqoc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lm5NpcqYU2QbeDlnWtZgSL9vd5CHuFGKxvZ+LC3SG1JGlBhjIDqt8RSi5yjqihLwQ49ZWGUvLyNKqFBvZcLX33vNrvJPxkumYffQ0UAYtTH2JxlxzUk4I7C+ffAINBDxDnuSGyj/u+uDICHRt8vmn44A0Ebx6/+Fz9Ns0OmShiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dqMvEOxI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso761959066b.1
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484639; x=1712089439; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knEQ4mryQwBiq0ncopBZJftzfm8XTJ3CLErQObi0yU0=;
        b=dqMvEOxIGZMr0g6hOQQzeQzMFpmza3FbjTpmtVSMFPaIrfa5BZnG8EZ5C+tYUQ7+ga
         uOJv6BThAViX0MVLUV8cQXsrCpMu4oGzEBFyb3y9dh8lu4TexeqaWhMLxFDw+oXG1Y6b
         ldtDuK3ueoaAhvUwUIES35Dmbm0K3uW0y43DkMRTIOOVLEnxmvqYnGFboWee3AXoEbGw
         XwZZ7OlFzi+AVvO8XqBjG2D+F00U1uVJXY8s2ct0QCYf8koKVfs5TidYxY6imx+DaiUA
         c9SDClm/2B90g5B3QGxIVc7ZGADRcD6Jjc/Gi1YlPMb2MTQSllANnKVJ4zJvCyAVSsU+
         c9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484639; x=1712089439;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knEQ4mryQwBiq0ncopBZJftzfm8XTJ3CLErQObi0yU0=;
        b=cctsvXD9QxMA4AWsKq2nTTYr9j7xJRcbS3BQBfDHkEEAx2jkoH4Pi/puXNINAgobhp
         J/jRayC/WQg4deZUbsm7Zji3U0Ry6mBRCW4XdoVp1iTCBO7j8h1M/V8dRIkYPwI7wwRh
         U+IVxz/8gEyKtrBQQndt5GtYjY9HrFWS5sXJl9cACUPcgdSf5x8XJ95lOO21Pqa+ITaX
         ykaksom22IZ1bEN1izxEtTdTrQKjQv8oEojvzdhbzSSdXnSFIuUzRPO3pUFa+nBHvS0X
         VLwp12LeX8B9Y0rxkuozBK5bS2gRX6CrGFSea2ovK2OA19/HWi9DrHq7R8KibiCvlHVl
         SjqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsunsHl898ike506aJlebasjVmMuroYjf6SIeBLkNp23DxExoTJOxY1dVWtS8pDuYiAIywSYrpAemfVDCX+qWxJkxGTt5Hldk3
X-Gm-Message-State: AOJu0Yz7DdM8nbjgbOc0xshKKElmKxOCOi9Iz72A1djQzssaXZT8Fyap
	pVwKoWrOnAbnECkSfmB0P/kSFQI83Ww7TvsmUNULbReSz4I4eVcgJ/RAmCdqV74=
X-Google-Smtp-Source: AGHT+IH0dK859sUAUhEQqGBCv46vWClhoFv9qf1bBqBgtaiUINfNf3lrctA8c7WDHIrVwNuBvhWlKA==
X-Received: by 2002:a17:906:b806:b0:a4d:ff6a:1d93 with SMTP id dv6-20020a170906b80600b00a4dff6a1d93mr262242ejb.60.1711484638972;
        Tue, 26 Mar 2024 13:23:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm4584492ejg.40.2024.03.26.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:23:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/19] amba: store owner from modules with
 amba_driver_register()
Date: Tue, 26 Mar 2024 21:23:30 +0100
Message-Id: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMIuA2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMz3dz8lNKcVN388rzUIt3E3KREXePUpCQzUyNTs6RUcyWgvoKi1LT
 MCrCZ0bG1tQCgwIKfYwAAAA==
To: Russell King <linux@armlinux.org.uk>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-input@vger.kernel.org, kvm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vLJVttyU0unj5HjuSsO9gb5EMeZQpEnywYmaCFIJqoc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmAy7IJ8hV8xU+Fvg50aj7Bm1TrFxta5NflDG5C
 Z0GX9z3UjOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgMuyAAKCRDBN2bmhouD
 1zMeD/4j+he5Lc0O5CAxCQTaYhyHw2jsG/5EdmADJJfjbMxmsMOFRSqBgFCmMTYlikBybNpMvGX
 Njz5qu6tleCNVFVzX64LgMF9CHk/qK88sFohHb9gDLy3INj8Cc7dCQay4J1RKYsX9JgvTm//yhG
 1i0kOuGUFGiUgkNVllH7OPSUBI01iGXoYWh3MIdiP4adZO5ydPW87HOHzk0K8fGWClJyOsN1l8o
 pk2Nfo0PeoM8o8H2QIcet14VfBgi9QJyqr77GM5vJnpR45KaRc3l93yej3zFWQ6OZHULyGayEtK
 8IUUp9ruU6fkzqDKIEsERhna3Fa1GacQADv0twz9n616/L1pcFTJaoLhItOUm1R+UfMX4mCtXOV
 Xs+nlz7EefbYDT1rvvHDuJ9q1gwp68PBnzMIHQFPM4BMXk25A2Wvjmk6YvBYIrhIMl3azHYFCRQ
 8x9/ojjzQkmBBvAp3CfFUGFpNadd6tLrlZnPySeeHRVnKbaqHw/AQ8h5RiTcTyrIzTqFSFufol7
 FoHmrA7z7yzQukzlsIcq27iQ0ObssgXHnSS1ZjXve056mJ8eQEJ/AAm2QJJW2Qqc1ay32P52oSj
 EE9gfAssEm8pTYJuc2ctEJu4BHdP9Sr+CAZ098xlIaFOiAEwGyAwmrrUoGgp7jm8R9lk0whhQwY
 ZdsRrJGwUkr5EFQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Merging
=======
All further patches depend on the first amba patch, therefore please ack
and this should go via one tree.

Description
===========
Modules registering driver with amba_driver_register() often forget to
set .owner field.

Solve the problem by moving this task away from the drivers to the core
amba bus code, just like we did for platform_driver in commit
9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Best regards,
Krzysztof

---
Krzysztof Kozlowski (19):
      amba: store owner from modules with amba_driver_register()
      coresight: cti: drop owner assignment
      coresight: catu: drop owner assignment
      coresight: etm3x: drop owner assignment
      coresight: etm4x: drop owner assignment
      coresight: funnel: drop owner assignment
      coresight: replicator: drop owner assignment
      coresight: etb10: drop owner assignment
      coresight: stm: drop owner assignment
      coresight: tmc: drop owner assignment
      coresight: tpda: drop owner assignment
      coresight: tpdm: drop owner assignment
      coresight: tpiu: drop owner assignment
      i2c: nomadik: drop owner assignment
      hwrng: nomadik: drop owner assignment
      dmaengine: pl330: drop owner assignment
      Input: ambakmi - drop owner assignment
      memory: pl353-smc: drop owner assignment
      vfio: amba: drop owner assignment

 drivers/amba/bus.c                                 | 11 +++++++----
 drivers/char/hw_random/nomadik-rng.c               |  1 -
 drivers/dma/pl330.c                                |  1 -
 drivers/hwtracing/coresight/coresight-catu.c       |  1 -
 drivers/hwtracing/coresight/coresight-cti-core.c   |  1 -
 drivers/hwtracing/coresight/coresight-etb10.c      |  1 -
 drivers/hwtracing/coresight/coresight-etm3x-core.c |  1 -
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  1 -
 drivers/hwtracing/coresight/coresight-funnel.c     |  1 -
 drivers/hwtracing/coresight/coresight-replicator.c |  1 -
 drivers/hwtracing/coresight/coresight-stm.c        |  1 -
 drivers/hwtracing/coresight/coresight-tmc-core.c   |  1 -
 drivers/hwtracing/coresight/coresight-tpda.c       |  1 -
 drivers/hwtracing/coresight/coresight-tpdm.c       |  1 -
 drivers/hwtracing/coresight/coresight-tpiu.c       |  1 -
 drivers/i2c/busses/i2c-nomadik.c                   |  1 -
 drivers/input/serio/ambakmi.c                      |  1 -
 drivers/memory/pl353-smc.c                         |  1 -
 drivers/vfio/platform/vfio_amba.c                  |  1 -
 include/linux/amba/bus.h                           | 11 +++++++++--
 20 files changed, 16 insertions(+), 24 deletions(-)
---
base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
change-id: 20240326-module-owner-amba-3ebb65256be7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


