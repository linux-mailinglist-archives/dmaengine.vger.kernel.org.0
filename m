Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E85C21436F
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGDDpW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgGDDpV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:45:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E9FC061794;
        Fri,  3 Jul 2020 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ch5Vnnhpkqkrccfr8vk7v05NfE6XsFtcOu+GJkyQHBU=; b=FwLC48irGrbOE8mlmtFnAcXSj8
        7pMwqFHQ/lY0IoQG6iPaqcXe2E8BkvEKZEyti4dQgkA1nOIOhUjcHDoy9y+Bv0ve02SRjuVOevxV1
        H2entV7jdnjRlEV2KfWmq5TWpjqSbnf+CbYuwKWHCH6bf1UyJybRDYzcNcc8Z0Bvpok7PkkbJ1ih0
        5ZNAUMRKAIf+Hd7C1xTw29MZRfkX+bbdVy8fOOCSuynh40S5Wop084dLkmJOb/p4veWeXA6+HZXwF
        /RrRAGed3oOl4MOdu4dg6YLum9eD+j7R+dEb5YvAvoBkgfhrKYN47gEdFlC5bDke0G8438OlD0G8G
        EOOP9q4w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ78-0001Xb-6f; Sat, 04 Jul 2020 03:45:19 +0000
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
Subject: [PATCH 02/17] Documentation/driver-api: firmware/built-in-fw: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:47 -0700
Message-Id: <20200704034502.17199-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "for".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/firmware/built-in-fw.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/firmware/built-in-fw.rst
+++ linux-next-20200701/Documentation/driver-api/firmware/built-in-fw.rst
@@ -28,6 +28,6 @@ able to make use of built-in firmware:
 * Some firmware files may be really large in size. The remote-proc subsystem
   is an example subsystem which deals with these sorts of firmware
 * The firmware may need to be scraped out from some device specific location
-  dynamically, an example is calibration data for for some WiFi chipsets. This
+  dynamically, an example is calibration data for some WiFi chipsets. This
   calibration data can be unique per sold device.
 
