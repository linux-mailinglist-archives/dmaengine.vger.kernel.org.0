Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4070F4BC172
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 21:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiBRU4V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 15:56:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiBRU4V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 15:56:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F034184631
        for <dmaengine@vger.kernel.org>; Fri, 18 Feb 2022 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645217764; x=1676753764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5bjH1aWRwrymwCWKXuUVCPVt2wqY0xgSDk+uCtLfNK0=;
  b=ll0NyATA7mdxspkQSu02/sU/wOUMUTWdcGkiuiwodi2JyEXXFt45E2lY
   IgXXY35XFJot+GN9+dbdDTyBKw5LKgY/3XZPf8OgWQiVh2LEkwZOmnfnl
   DBOuPVKIPxsJtGR2xouM/oyN4MxuC97IBZWazy+Mq+HlZ7mvf+FxwQXgs
   w23T/F+B1FbQomLF1gtBI5fVqHyPSW+e1BAMjOzHNkTEnra1Chqvtl4hn
   06tIiMP/Y7sMkt9t+MDeOnUTmTM8a2eNC95O9+45u92TCE87azecHCdsX
   72B93rstOvFk2zsIuFTzO4HDtu6GLFdlMZtcmguYXcHT8hzf7ht0u43Mt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231840021"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231840021"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="626735615"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2022 12:56:01 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 0/4] dmaengine: memset clarifications and fixes
Date:   Fri, 18 Feb 2022 13:55:53 -0700
Message-Id: <20220218205557.486208-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

