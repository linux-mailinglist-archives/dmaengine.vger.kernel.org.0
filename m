Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C5D7ACA79
	for <lists+dmaengine@lfdr.de>; Sun, 24 Sep 2023 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjIXPYR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Sep 2023 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXPYR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Sep 2023 11:24:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E98B8;
        Sun, 24 Sep 2023 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1695569018; x=1696173818; i=j.neuschaefer@gmx.net;
 bh=s5gWdQpVH21Xx+9InxWsz6K6mgquCNB9iZycdR6gpYU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Eret2MkaH3SBWABhFMXlk84417zAEaOVNeeYXH7F9Fq4dzf3Zp7BQcmi0SYYWW0bqA9bhw23g8i
 nuhApZhp+yByiQJyoTt1XbR7/LyoeYthVbo6/GbDgsZ8m/uTbNsyFcKpT9Rq5SY0QAUmIxhx9AWtR
 F9sdKrQL5QHhJkrN3J7S+fd7qd7dJ+K3b70VKkXH0x0Nck9uTtgh+3f/yjguDTYF/T2ak7CHfx4h/
 B+mbJah0wqhkuwHsWASnmFi3w3bCmEzDaR0JExPMXBCZJwgEqD56Bnxv2JLZ81dAR0M3PoVlc/1SS
 zjJdx4erucZ6Q29OEEjbFzqNeTLif4D5RMqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.47.152]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1qvBvB1Z6l-00Apx2; Sun, 24
 Sep 2023 17:23:38 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Wei Xu <xuwei5@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: hisi: Simplify preconditions of CONFIG_K3_DMA
Date:   Sun, 24 Sep 2023 17:23:32 +0200
Message-Id: <20230924152332.2254305-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mO+5wHE0RmepwGCER4agAwL5sdZdkEmD7ddZjwOsYIJ3KcobDec
 wb3sIJdspptyosakZW9CkeABC3G/J1vWL9KND2I5KVKZ85sVDAnOGzC2hYA0ZkOtbNEg7DM
 f0D7YP9fOBJ7Gp9DpNYUECXz0eU1uNSR0keus4fg6t75lndIOM/ONygs49N0SehJOx0gdh7
 wg12HGeE6B4xLjtsmhEMw==
UI-OutboundReport: notjunk:1;M01:P0:nvmjNVhzPDU=;4OysFuZ81/aARekur98DArYf/2M
 9eVX+uCJB5GJwtGCLsk078tv6WTI29wZzQVhWQURvgqxJ6AR0+kTR9WWEHBYLDXi7XwaEvgKK
 7Ts1dPYdI8N9fi0B7cOdJvKRS0S2I9QuIBaxk6HbgK4EeiQg6pQk8ejO9V1jJHAYolQ9uuwER
 6HXZnuhH3rFU5YyuAhtc+kFt+KcrMRRQiViOP6d4ZlgrhCtEi4uRas67nJuPWf99oOxk7G6AG
 2u3RH4v6ILKIJlHwGXUyvyvhqaBferMW4klA0bzF5Ke9yf8OkhDss/uBrXUs2P1q2V38J6JPh
 OZrSi+ZW/TSUjKYpJIlI2y1BBrbwvXwyxpXpshZFAYXDCCQN4HhqTKLVd1Wgzj3pBObq2pM6v
 8Ha59CKXBUDqhPHwvuVMOEelumkw4vVwN40CqUz16u0X2ZZ8Ld/pUuPwKhzarxH+p9fH+fiDo
 sJdQ9dgOVsYD8bLZWTh0ADlnUUx+0dbwUdZ1zpbnnXGt/Ry5jafOk3DxLva36iW5Qgw29Ko4l
 Z61KLwMJKiLJNYDNCVMWS4VR6W2OHDNBn6tXPSoQ6YYDlltj4Cu6hhgL7GhqMClLs+ijNAHjn
 rupPQtiYgQtqsfFXhDEjim1NjfxMqlqEsZc0I1JZQoU9cuoYUu+qSiPzhW0d51AKg2opqJzJa
 v7/VRAOHFkjQLrRB412ZF3KT3VMvb0nEDZnkR44Kh52h6UFujgYMaHp0H+bZHj+3VsROHYXbx
 x57W1O3b/In54de+iMygBNGwCBadRapXTrHDO6gMHf4DfHFjJ0qt4vgkNhntdgL1ljvfj6Q9g
 tjXPvJW3uhWe6HjiNotlgJq85mMgMuxpEYuErl0jQt+GIOFOsV5lSq4cdrFpO0p43abzFB+5x
 WDrAC7aw+0/uVdHSLcmrE1Na9wsyvy1O6omriZ/fSp1m6qJrbVEk6Jwx9aOcwYS1R2GZ7Mz3B
 ZSeMGfHveklIC1ITCJ+viDXfO9k=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit e39a2329cfb09 ("Kconfig: Allow k3dma driver to be selected for
more then HISI3xx platforms") expanded the "depends on" line of K3_DMA
from "ARCH_HI3xxx" to "ARCH_HI3xxx || ARCH_HISI || COMPILE_TEST".
However, ARCH_HI3xxx implies ARCH_HISI, so it's unnecessary to list
both.

Instead, just list ARCH_HISI, which covers all HiSilicon platforms.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 4ccae1a3b8842..70ba506dabab5 100644
=2D-- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -362,7 +362,7 @@ config INTEL_IOATDMA

 config K3_DMA
 	tristate "Hisilicon K3 DMA support"
-	depends on ARCH_HI3xxx || ARCH_HISI || COMPILE_TEST
+	depends on ARCH_HISI || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
=2D-
2.40.1

