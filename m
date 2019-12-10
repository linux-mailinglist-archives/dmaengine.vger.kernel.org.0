Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A291118772
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 12:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLJL4k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 06:56:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52439 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfLJL4k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Dec 2019 06:56:40 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iee86-00013F-CK; Tue, 10 Dec 2019 12:56:38 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iee85-00089r-C9; Tue, 10 Dec 2019 12:56:37 +0100
Date:   Tue, 10 Dec 2019 12:56:37 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/5] dmaengine: virt-dma: Add missing locking around list
 operations
Message-ID: <20191210115637.kpoxhnumzqwd6e4f@pengutronix.de>
References: <20191206135344.29330-1-s.hauer@pengutronix.de>
 <20191206135344.29330-2-s.hauer@pengutronix.de>
 <2da64628-20e5-b12d-798e-b47cf025badc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da64628-20e5-b12d-798e-b47cf025badc@ti.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:56:21 up 155 days, 18:06, 143 users,  load average: 0.17, 0.15,
 0.16
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 09, 2019 at 09:38:17AM +0200, Peter Ujfalusi wrote:
> Hi Sascha,
> 
> On 06/12/2019 15.53, Sascha Hauer wrote:
> > All list operations are protected by &vc->lock. As vchan_vdesc_fini()
> > is called unlocked add the missing locking around the list operations.
> 
> At this commit the vhcan_vdesc_fini() _is_ called when the lock is held
> via vchan_terminate_vdesc() which must be called with the lock held...
> 
> Swap patch 1 and 2.

Right, will do.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
