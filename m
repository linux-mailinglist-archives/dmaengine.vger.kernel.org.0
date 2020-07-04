Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9C2143D8
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgGDDqC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgGDDqA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:46:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D5C061794;
        Fri,  3 Jul 2020 20:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=r1aEn+t8j2wA7e0I1OW+BPLKTMMoNGZMWbd9fmMpZqM=; b=Bf7UEtxchI7uzsegrZdvsGmrc9
        o54oS1+GEx9s96zmUe3AL/sWiWdhOKDloa22aQ4S0qWGNBFE7Mej7wXlYw7vRPJIPsytdGY2hcbCo
        0a3Gy/WZ5D8lUTsbdZStrXsqiPWU2PTBQizk7kHRBiDkXdc0Ozj/vm17vf3QLzZu+Jgc2QvWqO/ir
        DxrFku1YVsvED4x7TNCGGospZLqCSMDJbNczoqYUouxdDxaD2+eodhQu8Z3c+lbvweNYKbsR3bT0w
        JASGoMQH95cHVt5eQsEmBjz+tOpCqwL9JMwgvL/B6V3gJyZsqzOQvUTLWa7ocEF0PUZsMrt9rNIPd
        7ntghEEQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ7l-0001Xb-2Y; Sat, 04 Jul 2020 03:45:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH 09/17] Documentation/driver-api: media/dtv-frontend: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:54 -0700
Message-Id: <20200704034502.17199-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "errors".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/driver-api/media/dtv-frontend.rst |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200701.orig/Documentation/driver-api/media/dtv-frontend.rst
+++ linux-next-20200701/Documentation/driver-api/media/dtv-frontend.rst
@@ -244,7 +244,7 @@ Carrier Signal to Noise ratio (:ref:`DTV
     Having it available after inner FEC is more common.
 
 Bit counts post-FEC (:ref:`DTV-STAT-POST-ERROR-BIT-COUNT` and :ref:`DTV-STAT-POST-TOTAL-BIT-COUNT`)
-  - Those counters measure the number of bits and bit errors errors after
+  - Those counters measure the number of bits and bit errors after
     the forward error correction (FEC) on the inner coding block
     (after Viterbi, LDPC or other inner code).
 
@@ -253,7 +253,7 @@ Bit counts post-FEC (:ref:`DTV-STAT-POST
     see :c:type:`fe_status`).
 
 Bit counts pre-FEC (:ref:`DTV-STAT-PRE-ERROR-BIT-COUNT` and :ref:`DTV-STAT-PRE-TOTAL-BIT-COUNT`)
-  - Those counters measure the number of bits and bit errors errors before
+  - Those counters measure the number of bits and bit errors before
     the forward error correction (FEC) on the inner coding block
     (before Viterbi, LDPC or other inner code).
 
@@ -263,7 +263,7 @@ Bit counts pre-FEC (:ref:`DTV-STAT-PRE-E
     after ``FE_HAS_VITERBI``, see :c:type:`fe_status`).
 
 Block counts (:ref:`DTV-STAT-ERROR-BLOCK-COUNT` and :ref:`DTV-STAT-TOTAL-BLOCK-COUNT`)
-  - Those counters measure the number of blocks and block errors errors after
+  - Those counters measure the number of blocks and block errors after
     the forward error correction (FEC) on the inner coding block
     (before Viterbi, LDPC or other inner code).
 
