Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F351B2054EB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2020 16:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbgFWOhn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jun 2020 10:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732835AbgFWOhm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Jun 2020 10:37:42 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555E6206EB;
        Tue, 23 Jun 2020 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592923062;
        bh=LxiQVVinhBQKbOzwTpLWbfRK5z2E0I1fmXbEPivqF7E=;
        h=From:To:Cc:Subject:Date:From;
        b=KWmHHVNewecJReWi3cvU5ePHXSdfNeV4szsOGTLoU1NIvU2Z1oo8BbrzH74R+3tdx
         UukOkmBIFDzlUjQZxiNsSGLoh5OmeZ2wdLMk5kJ0iO3DrEa3H0TCKuqakmx+uCKpN0
         hl18QPkVVXErOlBxxRjOMu1wtxnIk6TOu2CatMhw=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] MAINTAINERS: switch dmaengine tree to kernel.org
Date:   Tue, 23 Jun 2020 20:07:29 +0530
Message-Id: <20200623143729.781403-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I have switched DMAengine tree to kernel.org now, so update in
MAINTAINERS file

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..49d096742d5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5111,7 +5111,7 @@ M:	Vinod Koul <vkoul@kernel.org>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.kernel.org/project/linux-dmaengine/list/
-T:	git git://git.infradead.org/users/vkoul/slave-dma.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
 F:	Documentation/devicetree/bindings/dma/
 F:	Documentation/driver-api/dmaengine/
 F:	drivers/dma/
-- 
2.26.2

