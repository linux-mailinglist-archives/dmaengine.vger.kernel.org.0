Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75128214379
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgGDDpd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgGDDpc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:45:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83650C061794;
        Fri,  3 Jul 2020 20:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=COadqeh7uXIXiMC1HdlQrl27S5WUVALD05j/f0udySQ=; b=bB8P99UQmrezoDX7Ee0OFb1rT1
        FG9sRhAK7gHJ4vamI15Z2HRIMEkq8s9QS22C/SgRqTBMxM2XDLF4WpE9IR/HiMsacowfAD87d9YlE
        CJuuIFx5ew0DVJsg7V/yMOd5BWvMD3IwCOkAF1oCx3bDLB3w8wNkLUhKFMV6ppvqkPg+msWi/hpyx
        y0TkbLU6681V/o9zHAqBQzy+Q6MpN8uoKCKlqCsBnG6D7QiXtkVCPWE6kAr1W2XMNtDA5Dw4B/fQS
        7ROTBBoGRQu1ZO6eD2MSW72gEeVYaGL7IJDz08QC2jZcEssXzOnQKxjL6WHSIDhQUkOZ84pzA9o6u
        mEtmeovw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ7J-0001Xb-9C; Sat, 04 Jul 2020 03:45:30 +0000
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
Subject: [PATCH 04/17] Documentation/driver-api: firmware/direct-fs-lookup: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:49 -0700
Message-Id: <20200704034502.17199-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "firmware".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/firmware/direct-fs-lookup.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/firmware/direct-fs-lookup.rst
+++ linux-next-20200701/Documentation/driver-api/firmware/direct-fs-lookup.rst
@@ -24,7 +24,7 @@ available. Stuffing the firmware into in
 however note that using initrd does not suffice to address the same race.
 
 There are circumstances that justify not wanting to include firmware into
-initramfs, such as dealing with large firmware firmware files for the
+initramfs, such as dealing with large firmware files for the
 remote-proc subsystem. For such cases using a userspace fallback mechanism
 is currently the only viable solution as only userspace can know for sure
 when the real rootfs is ready and mounted.
