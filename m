Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3947579CEC4
	for <lists+dmaengine@lfdr.de>; Tue, 12 Sep 2023 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjILKsb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Sep 2023 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjILKsA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Sep 2023 06:48:00 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B352C1715;
        Tue, 12 Sep 2023 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uScCM
        nzPObsPh23HDdGqOfZrNm1aaqjHMJwvw1YWvH0=; b=IdqhUZUAomqxoLzepFnex
        +46OUihKyFKisxT5jIh8nwwA5wQhufmQLr/5TpwD2jtwYI9B4CHDJ0DRW5+skR2X
        1IgS8YUENB+9Ic48oBrQ49Q0OXrPQ+e3kwNTyIM5S7IpNYziGLAPspPyi2FnLYXH
        0bC0C8jlYecifcGg4I2Tf4=
Received: from f00160-VMware-Virtual-Platform.. (unknown [117.133.51.178])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wDX9CmcQQBlvAlxBw--.21712S4;
        Tue, 12 Sep 2023 18:47:05 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     vkoul@kernel.org, corbet@lwn.net
Cc:     dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] Documentation: driver-api: fix ls -1 spelling
Date:   Tue, 12 Sep 2023 18:46:50 +0800
Message-Id: <20230912104650.3999-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDX9CmcQQBlvAlxBw--.21712S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF13KFW3KrykCF4DZFWkJFb_yoWfWrc_CF
        4qqFZagr4qyFyIyr48tFn8ZFnIvrWFkFn3u3WDtFs8Cry3X39xuFykK345Cr1xuF17ur9x
        C3yDWrWft3ZrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZyCL3UUUUU==
X-Originating-IP: [117.133.51.178]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/1tbiExHoF2E18j0TTgAAs7
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ls -1 to ls -l in dmatest documentation

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 Documentation/driver-api/dmaengine/dmatest.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
index e2a63cefd783..b1a0e3bc71e7 100644
--- a/Documentation/driver-api/dmaengine/dmatest.rst
+++ b/Documentation/driver-api/dmaengine/dmatest.rst
@@ -77,7 +77,7 @@ Example of multi-channel test usage (new in the 5.0 kernel)::
 .. hint::
   A list of available channels can be found by running the following command::
 
-    % ls -1 /sys/class/dma/
+    % ls -l /sys/class/dma/
 
 Once started a message like " dmatest: Added 1 threads using dma0chan0" is
 emitted. A thread for that specific channel is created and is now pending, the
-- 
2.34.1

