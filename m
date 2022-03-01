Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916AA4C92FA
	for <lists+dmaengine@lfdr.de>; Tue,  1 Mar 2022 19:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiCAS0j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Mar 2022 13:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiCAS0j (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Mar 2022 13:26:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C96516C
        for <dmaengine@vger.kernel.org>; Tue,  1 Mar 2022 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646159157; x=1677695157;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CpId33HQGvmiZ18S5kyvW0m6b3k6W4TcdDFTR5B6jws=;
  b=Tut3/v+eUWEH9W2OG00/MN3bxXDs3FLH59amFvTFcL/Ee47ulWu2yxtK
   jS0dbl1bMIqN3zrugo8lljzJOueUIvzmUWapl9yT03JT/ei8+O00zJruA
   9h/P1RduNKiJuZbV6XMmRqZ26SIPC78nn4v/B18rfujg97CfTPUBMELjG
   epeoAC9/+GBl2HH7qyMWnAMk+asbMCLHdE4F7zWcEPSz7NICnlft9XvaU
   qENPmGvr1CapZ4pZvrtMPmxaaOdbPQMfLYM41hFF9RwkKjYQPIIGbmxtg
   ie9Gi2YjMhw6CXwj17xPxa7S1c4kTd+g33VzF3nBNJWQYbM33I2OlJBzb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252940707"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252940707"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:25:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630110135"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Mar 2022 10:25:56 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v3 0/4] dmaengine: memset clarifications and fixes
Date:   Tue,  1 Mar 2022 11:25:47 -0700
Message-Id: <20220301182551.883474-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

v3:
 - Using signed byte for pattern everywhere

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

