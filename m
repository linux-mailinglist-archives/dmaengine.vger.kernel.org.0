Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87110FCDC
	for <lists+dmaengine@lfdr.de>; Tue,  3 Dec 2019 12:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbfLCLux (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Dec 2019 06:50:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39823 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfLCLux (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Dec 2019 06:50:53 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ic6hf-0008Od-A4; Tue, 03 Dec 2019 12:50:51 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1ic6he-00025p-JM; Tue, 03 Dec 2019 12:50:50 +0100
Date:   Tue, 3 Dec 2019 12:50:50 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>, kernel@pengutronix.de
Subject: vchan helper broken wrt locking
Message-ID: <20191203115050.yvpaehsrck6zydmk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:05:37 up 148 days, 17:15, 148 users,  load average: 0.44, 0.29,
 0.22
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

vc->desc_free() used to be called in non atomic context which makes
sense to me. This changed over time and now vc->desc_free() is sometimes
called in atomic context and sometimes not.

The story starts with 13bb26ae8850 ("dmaengine: virt-dma: don't always
free descriptor upon completion"). This introduced a vc->desc_allocated
list which is mostly handled with the lock held, except in vchan_complete().
vchan_complete() moves the completed descs onto a separate list for the sake
of iterating over that list without the lock held allowing to call
vc->desc_free() without lock. 13bb26ae8850 changes this to:

@@ -83,8 +110,10 @@ static void vchan_complete(unsigned long arg)
                cb_data = vd->tx.callback_param;
 
                list_del(&vd->node);
-
-               vc->desc_free(vd);
+               if (dmaengine_desc_test_reuse(&vd->tx))
+                       list_add(&vd->node, &vc->desc_allocated);
+               else
+                       vc->desc_free(vd);

vc->desc_free() is still called without lock, but the list operation is done
without locking as well which is wrong.

Now with 6af149d2b142 ("dmaengine: virt-dma: Add helper to free/reuse a
descriptor") the hunk above was moved to a separate function
(vchan_vdesc_fini()). With 1c7f072d94e8 ("dmaengine: virt-dma: Support for
race free transfer termination") the helper is started to be called with
lock held resulting in vc->desc_free() being called under the lock as
well. It is still called from vchan_complete() without lock.

I think vc->desc_free() being called under a spin_lock is unfortunate as
the i.MX SDMA driver does a dma_free_coherent() there which is required
to be called with interrupts enabled.

I am not sure where to go from here hence I'm writing this mail. Do we
agree that vc->desc_free() should be called without lock?

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
