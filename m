Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BEF2F4A91
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 12:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAMLr5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 06:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhAMLr4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jan 2021 06:47:56 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C54C061794;
        Wed, 13 Jan 2021 03:47:16 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u21so2224765lja.0;
        Wed, 13 Jan 2021 03:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJO8LfgR583COavnd+h34gmFX08/B9C5bdn5fFZnF60=;
        b=FFbPx4zCK5ZJ9hBgkpZgxd57LRtaOHEPZLUJSwpMqlsKa6PFZjzSpRpD33lLlWiK7X
         QBzT6MEsqKuwebiKBDcIcRzWpNhXja7VqKuNxQAJBE4F0FCqYNkl9mhZP6adYaBDuZie
         2iCw/r5449v2Zfeqb/4lpLQ2tnVI9pMo/K+9Aggp9fK2Bagj7dXB8vVMFPuZt3FIPCIy
         9KZZvad9xK5jumRkobwf3pR/Hkv58xuT/00MLnCF7E8G+sXJQ37EV35sT8aALZO8O9e5
         S0kQ4ULHNX6n9zTQr+9WLsj0iCR98V2CSaZz7umyNBHG3+MEXrcDrs3QmiY/CQtemOqS
         3mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJO8LfgR583COavnd+h34gmFX08/B9C5bdn5fFZnF60=;
        b=AWw7V9kTMAgyQi2grPByX+L9r+EO4RTQ+1hC8mXbS6epbZNO0ogBLtNEC1FbXfpWPV
         WIGh1t1Imw91BFEW/UzXmqicTG2VsD/pLoygRGsRcHKsUsBQhTBCm8g0K01oxMIPgq9b
         dR4+JfECSC6HIadsoeQcaJYZKXf4HkwqTxFxsvYLUCXXcCh/d2KdlteCHuYyiXfq7vdW
         3kxTCwY9ZfAmSocEkHdZDyqvzfQ3QMUFlfUue6peMUXD2+19AGfipQL/aF8YLWa96qEx
         lk1xhe74TnxfeU7vipu7iQTuH7HsggpaOMke707oSkTcH8bPBYQT3OFRt5ZH/CZMaqcg
         hanA==
X-Gm-Message-State: AOAM532SKDq2aZw2EKLtP1tV+aq5k4QATMShgSMNpcrgbnT6OCOe+qUo
        E3nwj69t1jq8ZbXWnox91XY=
X-Google-Smtp-Source: ABdhPJzSN8UzV3pGK4K5STpFTc6q9uCMQ5I5ZZoEgCleeMq6Mbur3rc6Xs37enacbNUsazwDN4Mnaw==
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr814523ljj.448.1610538434496;
        Wed, 13 Jan 2021 03:47:14 -0800 (PST)
Received: from localhost.localdomain (91-157-87-152.elisa-laajakaista.fi. [91.157.87.152])
        by smtp.gmail.com with ESMTPSA id f19sm186489lfc.71.2021.01.13.03.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:47:13 -0800 (PST)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     vkoul@kernel.org
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com, kishon@ti.com
Subject: [PATCH v2 0/3] dmaengine: ti: k3-udma: memcpy throughput improvement
Date:   Wed, 13 Jan 2021 13:49:20 +0200
Message-Id: <20210113114923.9231-1-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Changes since v1:
- Added Kishon's tested-by to the first two patch
- Moved the variable definitions to the start of their respective functions
- Remove braces where they are not needed
- correct indentation of cases
- additional patch to clean up the ret = 0 initializations in tisci channel configuration
  functions, no functional changes.

Newer members of the KS3 family (after AM654) have support for burst_size
configuration for each DMA channel.

The HW default value is 64 bytes but on higher throughput channels it can be
increased to 256 bytes (UCHANs) or 128 byes (HCHANs).

Aligning the buffers and length of the transfer to the burst size also increases
the throughput.

Numbers gathered on j721e (UCHAN pair):
echo 8000000 > /sys/module/dmatest/parameters/test_buf_size
echo 2000 > /sys/module/dmatest/parameters/timeout
echo 50 > /sys/module/dmatest/parameters/iterations
echo 1 > /sys/module/dmatest/parameters/max_channels

Prior to  this patch:   ~1.3 GB/s
After this patch:       ~1.8 GB/s
 with 1 byte alignment: ~1.7 GB/s

Regards,
Peter
---
Peter Ujfalusi (3):
  dmaengine: Extend the dmaengine_alignment for 128 and 256 bytes
  dmaengine: ti: k3-udma: Add support for burst_size configuration for
    mem2mem
  dmaengine: ti: k3-udma: Do not initialize ret in tisci channel config
    functions

 drivers/dma/ti/k3-udma.c  | 130 ++++++++++++++++++++++++++++++++++----
 include/linux/dmaengine.h |   2 +
 2 files changed, 120 insertions(+), 12 deletions(-)

-- 
2.30.0

