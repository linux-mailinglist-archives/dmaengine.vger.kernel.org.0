Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6F345316
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCVXg1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:36:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:27774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhCVXg0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 19:36:26 -0400
IronPort-SDR: 8QspxDtedv+i+rAi84JpIe6qVbA/MqZs+SQYL4QSxm9mc/LvwXcG9SS/1h8cKcM7ODgdQXP6AL
 BjbqLI7RItMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177497527"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="177497527"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:36:26 -0700
IronPort-SDR: 9r81qIaAsXNx1yxQD5RgCHRYneEOwAZVJPKGbAveoDhSlTs4drHj18fE6aYHIio+P/nCfxa8K0
 BjtUqtxUVPFg==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="524619864"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:36:26 -0700
Subject: [PATCH] dmaengine: idxd: fix delta_rec and crc size field for
 completion record
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Date:   Mon, 22 Mar 2021 16:36:25 -0700
Message-ID: <161645618572.2003490.14466173451736323035.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The delta_rec_size and crc_val in the completion record should
be 32bits and not 16bits.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Reported-by: Nikhil Rao <nikhil.rao@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/uapi/linux/idxd.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 236d437947bc..e33997b4d750 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -247,8 +247,8 @@ struct dsa_completion_record {
 			uint32_t	rsvd2:8;
 		};
 
-		uint16_t	delta_rec_size;
-		uint16_t	crc_val;
+		uint32_t	delta_rec_size;
+		uint32_t	crc_val;
 
 		/* DIF check & strip */
 		struct {


