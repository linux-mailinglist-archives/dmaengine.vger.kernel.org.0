Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B6E2143B1
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgGDDq1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgGDDq0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:46:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A6C061794;
        Fri,  3 Jul 2020 20:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Yq+NcoPRctb9cTYxOdPjKEln/NFtbJY6YqfumM1Za80=; b=tThxSQHIL15XIhvd8MS8uVRkPj
        HjetEUKJYPnIkSAaDmwaExUqBtiQ+Lh7rstIRX3CHOyHliFeRvJFqWyTyS5pHwPCxEYgCK5VqWF/u
        kszGjpva2NUbFnZUTAwYSZzzx9QuaTmtrufde9s0QTJLx3M+K6SNU0tK1W1ijHQCu6yXMcMl6GQed
        ZPJYq8hTswBp+SbzZcyIRIIAqGUAHbeH4n0UPDjp9+bq4ygSCsYGh/E1/hN/tCQwEt/iCxGb8dB9r
        NS32nrzEjjj+BGeKk5XtFg258/1OgPjZt8anp0CJaHfhB8VMFEn/fSAagJE6raS+ZAQnWt+i4BoGh
        TVlehL8Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ8B-0001Xb-A9; Sat, 04 Jul 2020 03:46:24 +0000
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
Subject: [PATCH 14/17] Documentation/driver-api: uio-howto: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:59 -0700
Message-Id: <20200704034502.17199-15-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "you".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/uio-howto.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/uio-howto.rst
+++ linux-next-20200701/Documentation/driver-api/uio-howto.rst
@@ -274,7 +274,7 @@ fields of ``struct uio_mem``:
    region, it will show up in the corresponding sysfs node.
 
 -  ``int memtype``: Required if the mapping is used. Set this to
-   ``UIO_MEM_PHYS`` if you you have physical memory on your card to be
+   ``UIO_MEM_PHYS`` if you have physical memory on your card to be
    mapped. Use ``UIO_MEM_LOGICAL`` for logical memory (e.g. allocated
    with :c:func:`__get_free_pages()` but not kmalloc()). There's also
    ``UIO_MEM_VIRTUAL`` for virtual memory.
