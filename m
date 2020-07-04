Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6712143E3
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGDDp1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgGDDp0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:45:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAC4C061794;
        Fri,  3 Jul 2020 20:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5uNtA/HJRXzseONyU9tn1hzhV7wWRJZnITuL/3spnnY=; b=B2AMYlF3x1F6n+eSGjVKcIP4H7
        mKPh9F2qqwNJh93JJP2YvgExFJisGruw/hCg+OGkOToGkK2eVdbivGgZEo9Rh0OTDFumyVlqRD0PR
        /SEbNG/7D2/Vf6ZLQ77NYb/wIqYpoOv0Ye4P4uA3tVdee4f+sNGW4LAsFYSOH/Prr3g79OcGXVvwt
        Wr+yGdkg4bcphMEHUR2kQ8e1/zATZtvtkdXokIWCYoZdpVcKDzVfUd91xiWSE9YVxFp1jrJxgnIwL
        OXw5ydettLbL49iBXAqw5PbhtvcLNYTL6HKbx/9nyihxoGk60Z+hdMkdMEsE70H8hIpC2l0vGO0vS
        KaQWTeyQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ7D-0001Xb-VA; Sat, 04 Jul 2020 03:45:25 +0000
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
Subject: [PATCH 03/17] Documentation/driver-api: firmware/firmware_cache: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:48 -0700
Message-Id: <20200704034502.17199-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "if".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/firmware/firmware_cache.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/firmware/firmware_cache.rst
+++ linux-next-20200701/Documentation/driver-api/firmware/firmware_cache.rst
@@ -27,7 +27,7 @@ Some implementation details about the fi
   uses all synchronous call except :c:func:`request_firmware_into_buf`.
 
 * If an asynchronous call is used the firmware cache is only set up for a
-  device if if the second argument (uevent) to request_firmware_nowait() is
+  device if the second argument (uevent) to request_firmware_nowait() is
   true. When uevent is true it requests that a kobject uevent be sent to
   userspace for the firmware request through the sysfs fallback mechanism
   if the firmware file is not found.
