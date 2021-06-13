Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10853A5B05
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jun 2021 01:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhFMXel (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Jun 2021 19:34:41 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:33517 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhFMXeh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Jun 2021 19:34:37 -0400
Received: by mail-wm1-f41.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so8563448wme.0;
        Sun, 13 Jun 2021 16:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iK+fdotc8MDTLXOWsCA+bd9ELHLX8yC6MN1FxLYw3Rc=;
        b=ZBhL+xgB8mqWh3eLJJg3Z/iYwp+jlCYPiX8tmO8GhAowJpOg07QRw/MEPdckTj/kp+
         ICniI5hVwGsS2PIQIlWz7735puYXK6TjX8gWwBgKxk0KY9JxzNDK4HNgatOrSXbe0Lc2
         RF0bXch20IlR9KFs1iQsEc71ZlALOhvwrD83oO0VUwuxRnCiT+evKwNP8clkkhJYsdLG
         2v3+5cf4d/Y1NCYCiml07nL8BeVVxec9FZ3KQ80Bn22GIvZNAaaBk93WERvanqg9kWA0
         ZPH0exFbl36gqe7DWFdUYcjT3IueXbJU+jsky+TmkOdUHxBzQ1/+qlZBtvQrxT8vDCzz
         AoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iK+fdotc8MDTLXOWsCA+bd9ELHLX8yC6MN1FxLYw3Rc=;
        b=PO2F8DyGH8PQ0FeKbJ7b04R5e8EKgS74Ti6jXQf/dxYuehAxESXiruvmGy8ih5WzDE
         G9wV/pAePtVR56X+NGceuB+BMlOMA6vD8INiIyd2t+qvBl6wQRNNCSH5kC8UVCgP4WR/
         kUtuo63Y5SVGpvl1Ql/jXzAJcntoHx0m0byB0VYbs5O+Ett7AT4OEmrRlKxW+1I8gCCw
         95iHpLAF4wCzgsUIuVUotn8kxh1Y2hEYc0j+Ta56lG8x1rsNjd/sn4ugtd4GOJjPlA6a
         Dk8mUtfRMejQYsf5supx7niu1VRqimA0ugmypJAw9+yuTURPMvI0nud965z+hiuGe8+S
         EiFQ==
X-Gm-Message-State: AOAM532iB0vBqGJIN5/EP8sbuQaDdHs+45M6IfC8cCJ2JCHZ+2VsEDx5
        I1ej3i2UdyEP+Nc/haaoqAE=
X-Google-Smtp-Source: ABdhPJxxWZyZQBZ1JBZMI/iWKh4B0GGXrb7nldKK0n8tdDlT0f6lu/3UG+BAm2A+FtPRs1yAgbiy6w==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr29800169wmj.68.1623627079836;
        Sun, 13 Jun 2021 16:31:19 -0700 (PDT)
Received: from localhost.localdomain ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id i9sm17882511wrn.54.2021.06.13.16.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 16:31:18 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Prepare EP93xx drivers for Common Clock Framework
Date:   Mon, 14 Jun 2021 01:30:34 +0200
Message-Id: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nikita posted a patch converting EP93xx to use Common Clock Framework. It
turns out some cleanup is necessary in the EP93xx drivers to avoid
"Enabling unprepared" clock warnings.

Patches with stack traces in the commit messages are tested on EP9302.

Link: https://lore.kernel.org/patchwork/patch/1435884/

Alexander Sverdlin (7):
  iio: ep93xx: Prepare clock before using it
  spi: spi-ep93xx: Prepare clock before using it
  Input: ep93xx_keypad: Prepare clock before using it
  video: ep93xx: Prepare clock before using it
  dmaengine: ep93xx: Prepare clock before using it
  ASoC: cirrus: i2s: Prepare clock before using it
  pwm: ep93xx: Prepare clock before using it

 drivers/dma/ep93xx_dma.c               |  6 +++---
 drivers/iio/adc/ep93xx_adc.c           |  6 +++---
 drivers/input/keyboard/ep93xx_keypad.c |  4 ++--
 drivers/pwm/pwm-ep93xx.c               | 12 ++++++------
 drivers/spi/spi-ep93xx.c               |  4 ++--
 drivers/video/fbdev/ep93xx-fb.c        |  4 ++--
 sound/soc/cirrus/ep93xx-i2s.c          | 12 ++++++------
 7 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.32.0

