Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47412143C6
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgGDDqd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgGDDqb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:46:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F295C061794;
        Fri,  3 Jul 2020 20:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=da/AGHoRkO/K6+XfD+STqPg75KP2M3Vysus0lxWaxjo=; b=b+GvlsX2K4UeFKpQnj+S+D/Nay
        MZkBQRoPw75b975an8rimIFtmK4enh9wwLga47yaRZRffScQHHwUofM9oBGCzlmNKeT16ADlzdhhz
        4qG3SHs/DPvLJmaz5qemOKS0U6rq76LPBM4+iLDdGNbnKl0EZ2Gadmgt2JV/lSaFZ21ioipqZIc+V
        cNNR4unosdctgrsyO/N1/ir+bbKO2jEMlAoZ+/z8zA2wPyogvb1eq4uMpW++yRz+N4ZgtTUBtDcTd
        GLraAVlq4a4Ez/xZj9FdUUGYpcHaOOYwK6xScKCwpIs2XqYO9Xbl/+nKrycct0CGw0X8z9e6yNNEE
        arwj0Ayg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ8G-0001Xb-OG; Sat, 04 Jul 2020 03:46:29 +0000
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
Subject: [PATCH 15/17] Documentation/driver-api: usb/URB: drop doubled word
Date:   Fri,  3 Jul 2020 20:45:00 -0700
Message-Id: <20200704034502.17199-16-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "also".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 Documentation/driver-api/usb/URB.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/usb/URB.rst
+++ linux-next-20200701/Documentation/driver-api/usb/URB.rst
@@ -240,7 +240,7 @@ How to do isochronous (ISO) transfers?
 ======================================
 
 Besides the fields present on a bulk transfer, for ISO, you also
-also have to set ``urb->interval`` to say how often to make transfers; it's
+have to set ``urb->interval`` to say how often to make transfers; it's
 often one per frame (which is once every microframe for highspeed devices).
 The actual interval used will be a power of two that's no bigger than what
 you specify. You can use the :c:func:`usb_fill_int_urb` macro to fill
