Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD32143E0
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGDDpj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgGDDpi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:45:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C3EC061794;
        Fri,  3 Jul 2020 20:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=azvx83xWOF3kgC3cI2uK3xiDXooMGlcuFMVIJEx/1Lo=; b=Tcd3aFlNwzruQOdCr9D4GGOjOy
        EZcH45N2UM7LMqVLlNGSFqIVhxzPnuiVmKv0rMC2i+u2lhJrHpqjBbed530iF+80r6C57nR2I5gLr
        KIlYsBVb1icYkVQkEPZuCD/+qq3qapwnTiudopeWjl3k0J3mTVtfzpbMYPZzjfr9ES5I5bk6BLzPx
        rkoT+VM19+vYj5fTo9n1ocTlqn8AWkHYDeC1YH2nmyvZsfvEmF3xbYTPuTtXrFP0UxdcJu+9U6PLg
        MKWX0pKCkQz+k6+VFgiRfI9YS6noGKAmiqyCM+ygBUCXIATIGobU4EyGmOrGS/gICWnwrgW1HxKcu
        jTKSiCgQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ7P-0001Xb-73; Sat, 04 Jul 2020 03:45:36 +0000
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
Subject: [PATCH 05/17] Documentation/driver-api: firmware/request_firmware: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:50 -0700
Message-Id: <20200704034502.17199-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "call".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/firmware/request_firmware.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/firmware/request_firmware.rst
+++ linux-next-20200701/Documentation/driver-api/firmware/request_firmware.rst
@@ -76,5 +76,5 @@ firmware. For example if you used reques
 the driver has the firmware image accessible in fw_entry->{data,size}.
 If something went wrong request_firmware() returns non-zero and fw_entry
 is set to NULL. Once your driver is done with processing the firmware it
-can call call release_firmware(fw_entry) to release the firmware image
+can call release_firmware(fw_entry) to release the firmware image
 and any related resource.
