Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DE1ED4F6
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 19:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgFCR1x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 13:27:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:54544 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgFCR1w (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Jun 2020 13:27:52 -0400
IronPort-SDR: xmxRUCwJ2C7UXKYJ/+J2rzS7+/WCNvc5DBlnDriVllDb7XH3fUK8ZjEmkwTNVuCgsNrNVqSHkG
 MCokRzglNBfw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 10:27:50 -0700
IronPort-SDR: 9P5BcSCk9fK3VldluFIDZi/L4kVUMq9tLD1RE+fNFPRq38EZjLHK9rkLLIR5m4AlVGq8jRKAIJ
 9xbLFmNyxIxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="378171640"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jun 2020 10:27:49 -0700
Subject: [PATCH] dmaengine: idxd: fix hw descriptor fields for delta record
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, mona.hossain@intel.com
Date:   Wed, 03 Jun 2020 10:27:48 -0700
Message-ID: <159120526866.65385.536565786678052944.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix the hw descriptor fields for delta record in user exported idxd.h
header. Missing the "expected result mask" field.

Reproted-by: Mona Hossain <mona.hossain@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 0 files changed

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 1f412fbf561b..e103c1434e4b 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -110,9 +110,12 @@ struct dsa_hw_desc {
 	uint16_t	rsvd1;
 	union {
 		uint8_t		expected_res;
+		/* create delta record */
 		struct {
 			uint64_t	delta_addr;
 			uint32_t	max_delta_size;
+			uint32_t 	delt_rsvd;
+			uint8_t 	expected_res_mask;
 		};
 		uint32_t	delta_rec_size;
 		uint64_t	dest2;

