Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BCE2F9133
	for <lists+dmaengine@lfdr.de>; Sun, 17 Jan 2021 08:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbhAQHI4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Jan 2021 02:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbhAQHIy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 17 Jan 2021 02:08:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A975722B49;
        Sun, 17 Jan 2021 07:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610867293;
        bh=cL/2kns32+kCXrQ7d0icqpTTcdH6//3q3Wj+DtX4E1U=;
        h=From:To:Cc:Subject:Date:From;
        b=dvn2n+ty+jgLf+y/aVfZb9n+t0DveErkDiuqS/5Hb1lW+N8aG30do+i3HcYKYNsbx
         FpqscMbe/p6AyzSKOjRVL5KeS2yBIX44LVAp3ONxiZNVCogYxxzxym0PAtP78QvT2N
         hzQSmAiM8SptQ7Zn1O5/ab9sgukVbd0E1OxYXpLCS5/WrHnmKJ2n5WP/wtmrOfCq5n
         v1ysxtC0Eim97tW54qEfuDbYaccZCVzh3pWvXPA2ExcffyQDYx9xXOBRPqwfxBvjCr
         7NLC3k/COTnEfG4XfHBvnnzFP88bHrSo/ONlUYf0LTxVIl9y5VTtfVB/hQ3odfQvG6
         //EtEQTlqleRA==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] MAINTAINERS: dmaengine: add header files directory
Date:   Sun, 17 Jan 2021 12:38:04 +0530
Message-Id: <20210117070804.2539698-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Somehow dmaengine header files are missed in the entry so update it

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49647c6a03fd..882dcc9023c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5279,6 +5279,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
 F:	Documentation/devicetree/bindings/dma/
 F:	Documentation/driver-api/dmaengine/
 F:	drivers/dma/
+F:	include/linux/dma/
 F:	include/linux/dmaengine.h
 F:	include/linux/of_dma.h
 
-- 
2.26.2

