Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01B2143CF
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGDDqS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgGDDqP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:46:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0CC061794;
        Fri,  3 Jul 2020 20:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6EonKUvskMRhUPMN+Ghhg/8Utfl6KLu/Eki0DelHmZo=; b=NLw/zpYV5if9WIc2kLc0j4W712
        8Jg1xRzVSe4FU9+/MJd+DzxGrj5zuTTH3UACVYBfUTc3LgNKZky1fuNTrWLrYl02NRENH/wMEww9R
        345jy/WUIadRLg+uwmwNQJAk6BRytXY6LUAROs54TzWlgJaLdwFgY566WYCzDVtgID0NtsB1x3u24
        rDuBvadU7LyywbNwvpPHxr3SrEqAFa+x5FyI/MuwmhpK87Oy65ypBopGLVaf9+Z1KIa0+Ux2UQBFt
        YhwONxgqkorRSqFpjoVV/GekOJgIMYbEideBvS4if5O7t2LHJ5yoPM750Ucw56UPYzcQRZLaN3Fjg
        ax+0AsuQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ80-0001Xb-SC; Sat, 04 Jul 2020 03:46:13 +0000
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
Subject: [PATCH 12/17] Documentation/driver-api: ntb: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:57 -0700
Message-Id: <20200704034502.17199-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "with".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com
---
 Documentation/driver-api/ntb.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/ntb.rst
+++ linux-next-20200701/Documentation/driver-api/ntb.rst
@@ -9,7 +9,7 @@ registers and memory translation windows
 scratchpad and message registers. Scratchpad registers are read-and-writable
 registers that are accessible from either side of the device, so that peers can
 exchange a small amount of information at a fixed address. Message registers can
-be utilized for the same purpose. Additionally they are provided with with
+be utilized for the same purpose. Additionally they are provided with
 special status bits to make sure the information isn't rewritten by another
 peer. Doorbell registers provide a way for peers to send interrupt events.
 Memory windows allow translated read and write access to the peer memory.
