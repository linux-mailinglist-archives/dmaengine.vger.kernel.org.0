Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C736BE816
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 12:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCQLcs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCQLcr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 07:32:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A9C50989
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:32:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so4886491pjz.1
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=de8XOkLa149BQ2L925B1UG2ePVsDMnMyaob4tHRpfnA=;
        b=zRx+qECqCL+KBpmPW6IxWec6kaUi46CFGaPNEijpptYDaUZF4otdAOYGbrRvuaqdF/
         4cZDdbxGKv04z/reTAWqC2R2Fu+y76cS5qGbJ+d/M+K8VqAQ6O01df17Ax7aJM67hlN0
         UOrAr2Kawim3Nh0ZHUwMFXIPI7fu+T8IlYslpE4tl85vC7GvztX2+YTUfqtub1HVzh7d
         z+6RCtqMrWVGlrJ5i0WFLuadU+g97mzDFDQKAHml7oqIemx6KFhTVnEOViX6yimTfgEM
         ifCmaoQ0AV8KMDEP/xOhXGB/Qj7KA8aRsM9RRXoNFKgjrsJSC5fzMZO+0j2wPA2uMuHm
         JtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=de8XOkLa149BQ2L925B1UG2ePVsDMnMyaob4tHRpfnA=;
        b=VyuNZYeLPQAEJ/swaQBiMsRfuPX/Kxlpj8L2UzoztH6WW2hzcSS8LDpIBNuAj4+Itf
         rLDY/HUvR81GXeb+6OeJKpjBaLCuFMmhUxYaIbXw5uoEKgXUN9NVdnbfsLRb2oA0cpXj
         FBw6aJesmrtnxzRozoQo0HCTV7KibGSHeSXmFv48adatg4yxutM5pF65HcINyk8ga3zU
         70gsprmzSndyebWCSazLSayL4ovaEvPG3vQ4cheeg9mLixVHqRC7vx2djJkWb/hE2faw
         6aZiCz3ybU+P2yaPG64RRUCs1/qEnvaDqleln38VY3s57mz+rGzATjFVKDN6hopshJs8
         IqHw==
X-Gm-Message-State: AO0yUKVaX9xMJDbNPdjebPHYJzV4u8m1zjRJIpr94RyEulTPpG9zriyu
        m9PUcilTvF8wJp7STdsMDMHVO8DR1Emha76sLIw=
X-Google-Smtp-Source: AK7set/qmRB3Cq2Ngf5a0+tELWz+JRQGDGER7Sp32pRtVVD93EZ5RnqfAwY57iOTxes/HoyJvmeK2Q==
X-Received: by 2002:a17:90b:3ec5:b0:22c:6d7c:c521 with SMTP id rm5-20020a17090b3ec500b0022c6d7cc521mr7537439pjb.45.1679052765133;
        Fri, 17 Mar 2023 04:32:45 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:32:44 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 00/11] Introduce a test for continuous transfer
Date:   Fri, 17 Mar 2023 20:32:27 +0900
Message-Id: <20230317113238.142970-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset introduces testing through continuous transfer to the PCI
endpoint tests. The purpose is to find bugs that may exist in the endpoint
controller driver. This changes able to find bugs in the DW EDMA driver and
this patchset includes the fix.

This bug does not appear in the current tests because these synchronize to
finish with every data transfer. However, the problem occurs with
continuous DMA issuances. The continuous transfers are required to get high
throughput and low latency. Therefore, the added tests will enable
realistic transfer testing.

This patchset is divided into three parts:
- Remove duplicated definitions and improve some code [1-6/11]
- Add continuous transfer tests [7-9/11]
- Fix for the DW EDMA driver bug [10,11/11]

This patchset has beed tested on RCar Spidar that has dw pci edma chip.

Shunsuke Mie (11):
  misc: pci_endpoint_test: Aggregate irq_type checking
  misc: pci_endpoint_test: Remove an unused variable
  pci: endpoint: function/pci-epf-test: Unify a range of time
    measurement
  PCI: endpoint: functions/pci-epf-test: Move common difinitions to
    header file
  MAINTAINERS: Add a header file for pci-epf-test
  misc: pci_endpoint_test: Use a common header file between endpoint
    driver
  PCI: endpoint: functions/pci-epf-test: Extend the test for continuous
    transfers
  misc: pci_endpoint_test: Support a test of continuous transfer
  tools: PCI: Add 'C' option to support continuous transfer
  dmaengine: dw-edma: Fix to change for continuous transfer
  dmaengine: dw-edma: Fix to enable to issue dma request on DMA
    processing

 MAINTAINERS                                   |   1 +
 drivers/dma/dw-edma/dw-edma-core.c            |  30 ++-
 drivers/misc/pci_endpoint_test.c              | 132 ++++--------
 drivers/pci/endpoint/functions/pci-epf-test.c | 199 ++++++++----------
 include/linux/pci-epf-test.h                  |  67 ++++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  13 +-
 7 files changed, 231 insertions(+), 212 deletions(-)
 create mode 100644 include/linux/pci-epf-test.h

-- 
2.25.1

