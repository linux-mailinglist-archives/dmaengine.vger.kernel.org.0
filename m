Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1FD2143D0
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgGDDqM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgGDDqK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:46:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B178C061794;
        Fri,  3 Jul 2020 20:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/CGMiPAz1EqlmAsuqBAdyktP4CyuJQt8tuDtDyXNR6Y=; b=Ba1zfCJUJkqxlIdW9NwaYHEcyF
        MUxE9LcPWFaVt1IkC8D8F+X1OIQXwvnN6awtL4ky5UGvax4zDdWGiHgT841yxr3dqNim6QFPwn8vN
        GMhffP4nmlRfdqHpuugtZuepsX43cLgQrRmyz601mCHSYu7TArLaqoNB+9GWPt/KoJ6o1HlnGFW6+
        ffXycZpHadTyGoB6jodB59F5Uky/eEp/HhIxxp8ecbrze2ib5Xij1IrEw8ppucqYNnTB/F67CDIW5
        1gP2g017fPDIvX4CaiYCMfiPQk2Gzae5rRr4uN2SrC8CVH/dLvYWnF7La5HikU4HIXPq6URlT+LRQ
        f1tiDR5Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ7v-0001Xb-Dv; Sat, 04 Jul 2020 03:46:08 +0000
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
Subject: [PATCH 11/17] Documentation/driver-api: driver-model/platform: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:56 -0700
Message-Id: <20200704034502.17199-12-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "that".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/driver-model/platform.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/driver-model/platform.rst
+++ linux-next-20200701/Documentation/driver-api/driver-model/platform.rst
@@ -108,7 +108,7 @@ field to hold additional information.
 
 Embedded systems frequently need one or more clocks for platform devices,
 which are normally kept off until they're actively needed (to save power).
-System setup also associates those clocks with the device, so that that
+System setup also associates those clocks with the device, so that
 calls to clk_get(&pdev->dev, clock_name) return them as needed.
 
 
