Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5004A003D
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 19:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiA1SkW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 13:40:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:27559 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235580AbiA1SkU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Jan 2022 13:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643395220; x=1674931220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5bjH1aWRwrymwCWKXuUVCPVt2wqY0xgSDk+uCtLfNK0=;
  b=cZxAYnNfoXRrA/A8omyQIH+Y/9YKJT2Z5bapypXeBtXWvvm55gq1bfoB
   /o6L+ds747p6IrPEq08rExa5Vh4x0bUSYCCF6BuCntTBhERlBAI3nG0XR
   lOB5uimkCmAWMnHCExqCFstlVbcrAM/By3P67Vgyso+0V8T9kJYBX7+WU
   y6/16eP5CD8ye3iL+vWgbH6jax5JDQl6olxpx4QrIHNqVpaYj5AooBF2b
   mSS89ITfUnYeerVG92c2G8EjjwmnRt11D7XmNYoUVwJkFYQ0hPVmgLS3o
   s+5fzfbf1i3QHxoGptgOgZQ6z0BnUmvIHiIEBuRBgbUTXTAZ6+Sw98/iF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="244775709"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="244775709"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618801984"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 10:40:19 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RFC PATCH 0/4] dmaengine: memset clarifications and fixes
Date:   Fri, 28 Jan 2022 11:39:44 -0700
Message-Id: <20220128183948.3924558-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The following contains a clarification for the behavior of the 'value'
parameter in the memset operation. It is intended to be a single byte
pattern as laid out here:

https://lore.kernel.org/dmaengine/YejrA5ZWZ3lTRO%2F1@matsya/

Then I'm attempting to fix all places it is currently used. But note
that I do not have access to this hardware and cannot test it. We'll
really need a maintainer to take a look at each of these to verify that
the changes are correct.

Ben Walker (4):
  dmaengine: Document dmaengine_prep_dma_memset
  dmaengine: at_hdmac: In atc_prep_dma_memset, treat value as a single
    byte
  dmaengine: at_xdmac: In at_xdmac_prep_dma_memset, treat value as a
    single byte
  dmaengine: hidma: In hidma_prep_dma_memset treat value as a single
    byte

 drivers/dma/at_hdmac.c    | 10 +++++++++-
 drivers/dma/at_xdmac.c    |  9 ++++++++-
 drivers/dma/qcom/hidma.c  | 13 ++++++++++++-
 include/linux/dmaengine.h |  8 ++++++++
 4 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.33.1

