Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6E44845FB
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jan 2022 17:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiADQdf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jan 2022 11:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiADQde (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jan 2022 11:33:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2587C061761;
        Tue,  4 Jan 2022 08:33:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F66614E8;
        Tue,  4 Jan 2022 16:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2D8C36AEF;
        Tue,  4 Jan 2022 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641314013;
        bh=vabCdgzGBopzaMxZsiqlElK4HXDziw223Sx8f6RNEnU=;
        h=From:To:Cc:Subject:Date:From;
        b=fsPrZa12dtKnpY9P4Ik57sdPyPS98kMT02NEUpalVmhOfV0rdj5w3YP/Hg1VPRdj5
         fogj6NK0ee8vx0fJ9UxIq6lL14HsJdhY3gFocIuR9opvD82haro3JjDY5BaN6q06wW
         nQaZpcksval/Zb1RZRxxPXwffTk7uJ0VVmKIOA54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: ioatdma: use default_groups in kobj_type
Date:   Tue,  4 Jan 2022 17:33:30 +0100
Message-Id: <20220104163330.1338824-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; h=from:subject; bh=vabCdgzGBopzaMxZsiqlElK4HXDziw223Sx8f6RNEnU=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXym75pN9Lby3t23v6Zf29/6uem724oPJlzrn4WXZbL5gu qZte0BHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAT0b7GMFfaMvnxR4XKk9sS8yd9dr FU8D6t95hhwYHjLYF/bebeqJ8t5bf7lpLFJMXGbgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the ioatdma sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/ioat/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index aa44bcd6a356..168adf28c5b1 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -158,8 +158,9 @@ static struct attribute *ioat_attrs[] = {
 	&intr_coalesce_attr.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(ioat);
 
 struct kobj_type ioat_ktype = {
 	.sysfs_ops = &ioat_sysfs_ops,
-	.default_attrs = ioat_attrs,
+	.default_groups = ioat_groups,
 };
-- 
2.34.1

