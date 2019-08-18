Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7409914E2
	for <lists+dmaengine@lfdr.de>; Sun, 18 Aug 2019 07:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfHRFV7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Aug 2019 01:21:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41525 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfHRFV7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Aug 2019 01:21:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so5026991pgg.8;
        Sat, 17 Aug 2019 22:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kr2J2lpJhW5GB7h3BuPUuG9H3cVaQJs2J2tffbrMrcE=;
        b=eLmSLo/WVeSyauyI7k1ktmMUzspX8u5Jurc8VVE2ET3uc893tIHpPdiVCohyuEGvb/
         5tJlFV5Zf/lLAKPlY0ETpjBJ7LgBV0gDyObWLzxQfdfZyyeAp6ARtCALfW0rvc0XAl2g
         +162CCRpQCjDMZBqtuQ2GlqRZJDL6bX613PEAxOF9lzm8U8Is4kPm8xSBP9qwXwy7r31
         /TpowZFTpIbe7hbBKq2ACjxn6BsFljZIZHdLL6cQXrxLm+m/PHt7R6stfCc5oDtcrD9x
         do4GzDzj+LHOdfdDwClsv/I+rKNucYiXHuUYr26b3MgPqgI0oUIXLnSDJDyryKnx8F3t
         /UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kr2J2lpJhW5GB7h3BuPUuG9H3cVaQJs2J2tffbrMrcE=;
        b=s7v1vMgztt8g4qiMXuxfVnknUyZkrh3cgkrtgr/G1Ow+oTOpoKh6G+rnQh3Kwl/vYu
         eScLKVIxWqlkw/HJ9ST8YVBfT/6Y1S1hbMyTDoy9wrOu4GhK7iTxHIUv0VWm8B66jB30
         223bDTrnIt4PipPwrKojBVyUGq6iSO5Yi2J6p5h3Ru3uK0TERe6C2B/dq/H8irKzI09h
         AsAldMvOfpr1NVN2rsx+dp2XKaT4b6T5AWgUdr1t+puK/49iZ/qi0nQTcDbR9EHbR0re
         CIh0WysXKH3DVWZL6LAA8ieW73bcvxcwsZBNcWrZifs2rmiBT8/r326QJ3hsZQrx6pFw
         7VUg==
X-Gm-Message-State: APjAAAWYHRKYgaU6NDiEfgd9U5iK9MMrRY5ByUItq+vGBHPtuMA6AQWJ
        uFuB5/NKy236F7cShjeb4Hb2Ibxi
X-Google-Smtp-Source: APXvYqwoDNqhMx/O851k8fhESy+8HClLLSlWzd97Wq++u9CrtPWZF309ljrvqQropsAi5X6KZOG6lQ==
X-Received: by 2002:a63:593:: with SMTP id 141mr5787049pgf.78.1566105718313;
        Sat, 17 Aug 2019 22:21:58 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id n7sm11286657pff.59.2019.08.17.22.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 22:21:57 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 0/2] Add support for AXI DMA controller on Milbeaut series
Date:   Sun, 18 Aug 2019 00:21:54 -0500
Message-Id: <20190818052154.17789-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The following series adds AXI DMA (XDMAC) controller support on Milbeaut series.
This controller is capable of only Mem<->MEM transfers. Number of channels is
configurable {2,4,8}

Jassi Brar (2):
  dt-bindings: milbeaut-m10v-xdmac: Add Socionext Milbeaut XDMAC
    bindings
  dmaengine: milbeaut-xdmac: Add XDMAC driver for Milbeaut platforms

 .../bindings/dma/milbeaut-m10v-xdmac.txt      |  24 +
 drivers/dma/Kconfig                           |  10 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/milbeaut-xdmac.c                  | 426 ++++++++++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
 create mode 100644 drivers/dma/milbeaut-xdmac.c

-- 
2.17.1

