Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88D421435B
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 05:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGDDpQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 23:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgGDDpP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 23:45:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D12C061794;
        Fri,  3 Jul 2020 20:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cfuMtEE7aLNsTWKrfmSLBZiVov+0MQq3QCFMWag3GnA=; b=poKqFqzyZYsZV/s9ZcbOe5p0/E
        YQRhrHdTpIgWrm9jdD+AcSJi8nWKFsktCg96n2jVBrA5NPjK7nFn+3cPxt9gI89iFbLBqSOjJ9J44
        BnTgPWt2Vxg+A1LTYLRK5dCMwJxvCyb1Nyczq6lScDORAnhB6pLkQpvP+8JXd5j6NWs1kypdPYPuO
        beeIefvHuzMOndhAaROWvf3UVxqPWkvP2U2DOoeRNL7Jhcd8T0wTqlC1+WpRc1osfE0grZpc9ODKY
        kT52GGrivXHQK/CiWI0eIILr9iqcLk2pMwJOtem2DtcAArS+ddJC1p+dsxkMdgWY6guRTnxzkYAvi
        OSAgyBMg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ73-0001Xb-CK; Sat, 04 Jul 2020 03:45:14 +0000
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
Subject: [PATCH 01/17] Documentation/driver-api: dmaengine/provider: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:46 -0700
Message-Id: <20200704034502.17199-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the doubled word "has".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 Documentation/driver-api/dmaengine/provider.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/dmaengine/provider.rst
+++ linux-next-20200701/Documentation/driver-api/dmaengine/provider.rst
@@ -507,7 +507,7 @@ dma_cookie_t
 DMA_CTRL_ACK
 
 - If clear, the descriptor cannot be reused by provider until the
-  client acknowledges receipt, i.e. has has a chance to establish any
+  client acknowledges receipt, i.e. has a chance to establish any
   dependency chains
 
 - This can be acked by invoking async_tx_ack()
