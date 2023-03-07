Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3676AF5E5
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 20:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjCGTko (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 14:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjCGTk0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 14:40:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95FCA1C6;
        Tue,  7 Mar 2023 11:27:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F5A9B81A0A;
        Tue,  7 Mar 2023 19:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97B1C433EF;
        Tue,  7 Mar 2023 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678217220;
        bh=fl//Mz2BMlMUuaYh9iAWgaq9WVSvfCauT8FTq4CmvFo=;
        h=From:To:Cc:Subject:Date:From;
        b=LZCKle3JIhXnCSM6EVoIpBbQlcza7D3FyJW0G/VZeu41o7tRfkC2VNH5k7ZUN3Isd
         eCcDBxFg6M3gzzjO7yLzLRA7xeXCjjfujc31PZ/FWKparv7Gp0PzgYMfpKs3GcoKj2
         i1sjAtmgnyPVjGH4objw6ZS/4P6OY9HJLnf1HJeWiC3AvM7MX9hIZncH7r9Sb0IVTb
         R4Q8iDpnUg4YAtRZ7CjcO6CoziOKpgr6/jbj/S1GdxIxgMHRWgl9Xermb6Tc4/EPjH
         awifkRtuXHOTy6oLiOYhJPAI9tNsBHNMoNYCIoNPbs4Da2TfrbD9DgDUAsL1JSLNr8
         nZku5JrLdfwGQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 0/2] PCI/AER: Remove redundant Device Control Error Reporting Enable
Date:   Tue,  7 Mar 2023 13:26:53 -0600
Message-Id: <20230307192655.874008-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
which appeared in v6.0, the PCI core has enabled PCIe error reporting for
all devices during enumeration.

Remove driver code to do this and remove unnecessary includes of
<linux/aer.h>.

Bjorn Helgaas (2):
  dmaengine: ioat: Drop redundant pci_enable_pcie_error_reporting()
  dmaengine: idxd: Remove unnecessary aer.h include

 drivers/dma/idxd/init.c | 1 -
 drivers/dma/ioat/init.c | 6 ------
 2 files changed, 7 deletions(-)

-- 
2.25.1

