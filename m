Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D56321439D
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgGDDpu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgGDDpt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:45:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CEBC061794;
        Fri,  3 Jul 2020 20:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rIE2HiSejbxqQ8BF9s2XxhnmsjYecXnzhkq4IxXMVOY=; b=pyKk1gSSLI0/FWyvONIFuBgUsH
        m+eAPUwqj653x5k8g1mS6agzbN27hETdg3MeXx2pzq5mtFOV1+9R1RYQ6Lu/INZw/8FQPRmT+/Ath
        BfLOIp6Y4DkXXTpHEWzMtfSnIa1p9xwb/0NN8CjviT9URBWx9J1n6l8phiwv/IZn7Yd7KJcAPk3LN
        uq0jPnrM/ICLBiUMxzwOznk+EXA3kICZqhCRY2ifqd6Jfm4zqhyjI9t7Ak0QOS1VlBgPDvidof/U/
        6CzcnzRx6fg21g3HMxwVUg90l/zmtyMOQplMv+f7N412o8WCEzSnRpXRvuFa4Pg1b01cx5cc2k6KC
        Qbild4Lg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ7a-0001Xb-8O; Sat, 04 Jul 2020 03:45:47 +0000
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
Subject: [PATCH 07/17] Documentation/driver-api: iio/buffers: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:52 -0700
Message-Id: <20200704034502.17199-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "struct".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
---
 Documentation/driver-api/iio/buffers.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/iio/buffers.rst
+++ linux-next-20200701/Documentation/driver-api/iio/buffers.rst
@@ -88,7 +88,7 @@ fields in iio_chan_spec definition::
 The driver implementing the accelerometer described above will have the
 following channel definition::
 
-   struct struct iio_chan_spec accel_channels[] = {
+   struct iio_chan_spec accel_channels[] = {
            {
                    .type = IIO_ACCEL,
 		   .modified = 1,
