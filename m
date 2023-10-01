Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059BC7B4723
	for <lists+dmaengine@lfdr.de>; Sun,  1 Oct 2023 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjJALXm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 1 Oct 2023 07:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjJALXl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 1 Oct 2023 07:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255ECBD
        for <dmaengine@vger.kernel.org>; Sun,  1 Oct 2023 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696159371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PmJLGZGYM/2RvXfCM4a7iZd7KULTy8GDfhMPfgYLY8=;
        b=Zf+LuiFopdqsAlD1maGTU87JorOvyLWjyB90tGkhzVooJVx0OKRxF+xZ14vAJMMliU0Ykn
        EbmEalJE5fnjd/3Mr4bwnn3nS2/VrU1gt41AeyggyQlXXxyD1c5ox2SmiA25GKf2pAhLug
        OoMMqdcrCceqXWZLvEhyNGaJXFZFdQM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-3liq-1YMPcWNLKVRSl48gA-1; Sun, 01 Oct 2023 07:22:38 -0400
X-MC-Unique: 3liq-1YMPcWNLKVRSl48gA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 763E73C02520;
        Sun,  1 Oct 2023 11:22:37 +0000 (UTC)
Received: from localhost (unknown [10.72.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F2FA493113;
        Sun,  1 Oct 2023 11:22:36 +0000 (UTC)
Date:   Sun, 1 Oct 2023 19:22:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: Re: [PATCH 1/1] fs: debugfs: fix build error at powerpc platform
Message-ID: <ZRlWeeq/AOjyTtnV@MiWiFi-R3L-srv>
References: <20230929164920.314849-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929164920.314849-1-Frank.Li@nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09/29/23 at 12:49pm, Frank Li wrote:
>    ld: fs/debugfs/file.o: in function `debugfs_print_regs':
>    file.c:(.text+0x95a): undefined reference to `ioread64be'
> >> ld: file.c:(.text+0x9dd): undefined reference to `ioread64'

From your reproducer, on x86_64, GENERIC_IOMAP is selected. So the
default version of ioread64 and ioread64be in asm-generic/io.h are
bypassed. Except of those arch where ioread64 and ioread64be are
implemented specifically like alpha, arm64, parisc, power, we may need
include include/linux/io-64-nonatomic-hi-lo.h or
include/linux/io-64-nonatomic-lo-hi.h to fix above linking issue?

From my side, below change can fix the issue. However, I am not quite
sure which one is chosen between io-64-nonatomic-hi-lo.h and 
io-64-nonatomic-hi-lo.h.

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87b3753aa4b1..b433be134c67 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/debugfs.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
 #include <linux/device.h>
-- 
2.41.0

