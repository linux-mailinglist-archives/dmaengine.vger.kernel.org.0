Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFC6AD83
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfGPRPq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 13:15:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:58993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfGPRPq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jul 2019 13:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563297326;
        bh=xNnIsDbgppK8wwBxMiTHNVXBTk1p7qOB7xrYiRrkhh8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KNCcMt0aSPEnh4pHQd2d/g8bY1FjoStxyLmGXY4SvcHPr+hNjHJCtcLzXJdiLS8cF
         XOaJZi94FLTj1UemEQpbVMZ+pi4mNg9Gb1AufLZT6wTX2zE6MxqOc5bD55uaBu9NbU
         tQlBkzckz6VfCMfaSa9OqwijFCW0QNHwglsF13JQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.111]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LjeWC-1iKa0M2SHA-00beDU; Tue, 16 Jul 2019 19:15:26 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] dmaengine: bcm2835: Print error in case setting DMA mask fails
Date:   Tue, 16 Jul 2019 19:15:18 +0200
Message-Id: <1563297318-4900-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:fL6HCOJkHLSo99rnhKGJNd1g6cKxvMfFqhtxr/p3c3HgN4FbiMX
 Wd+iGmFRA82C/GbBmGYre5PwcjOUmaKjXDc8ZWNsF/A7W1PH+FnsKoOmKXaRdjvdaMVmKI8
 QI4dygNsLqkUfJpAkNJxp1VGu2xA7D8cbsEUT606ucvC1itqkIXxUB35N4dXKNr769undih
 HhwgLvqsdizhvrzvUIkFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RYe9OtUzWrs=:bzoH7sjXqBy9ZGQ84yGcuZ
 rlvNEi25ozg7Cdp5Pl1LNI8c3BPeSyTRpx3sIbVHlQfHp3FCFoBecxlIW9ERUA0uzTC3AaRjj
 4Dh2A1zxvQEtEK8snBnMZZLdMU5f8fWG+8Iptm4dxUG+P0uClP1dTjEop47R0AZ8ebvBJ7BWw
 l73NGF4qXJ1sgl/1CEzgnzMIxn4l1l3GXTveFRSqJoiHTdSKqAaXfWrKiqYV03505vK2yyBC1
 yb7gFVxCOSY+fT9CCTZ7frKBwwalCZ8a5X/RISJGOmkemObiewAF9aRpbwqbIeRUV/p7maJrh
 7DXdI59dtL793Wlo1JbDcXiZGKgF02rdrc1nInJqaeb0zIWPclYyqMN9Hjnyncl6aDFHltMO1
 XjrULSwyzCd3y0SeqmuSk5rwYzWB3G17ginu0kxkc1oWIJUqwcPX/LR+XIYOSah6j4ZHeObdd
 hOrHG80gIjrPKyfFX2BwI69/rof0fbIuhHaclSG28rTtZ6WXDUfVmE7z5tZh/Pzrn16LfuY+M
 AMoKNg5/xQcYW8UCyUTdHpCWdSq0yoI1grQNCBXfcVF9iMs3TjC7F4LathXC7SKsWaWlpqksn
 fxmsQlu5OEStq0DoZnkyxCCdIS+URsKKlCtNRGGR/bQ3s2bMJFn9vgflHXzQ9RkciAk3Ucpcf
 Tds7TRdTodL6e/xp+EE4WzypnsKK5tqxj4XmWRcRVJsVJAxSnICeWtDEOzFAzVdrEicu51B+B
 /NDwQmlkW10icr7FsI5OlYC4H39QRUCgOcxzcgi8K9xtAAUKLGxGoxi8s9St5e5btECxM5e//
 ErVOwTiU0crHrFbxqqjK63IsXcrOS03nz9KiMs9jqxrYICiIKrqUOPUw0PH5DdjdUVpR+poMd
 LfCvGqNLhmkWUokEJ8PVLU/AKGy5wEL8CJ/FPXKcxZBSpA+rGwa3MtoZX51tU8r6kLbg4FTTJ
 QEmEfbbTFo+QTEBQmJ8dUP2U61QpoL/q7R09/9E0Ps3uvHlCdfWcYRlGb68JDF/ydyCbxepJP
 q+e2QIwBd6AUBhYJW75HTur0GuMR46lt3vApoJXoNlqn4LM4zITzHE53p/EESa/C0z3p9lzE7
 KrfHJusRvBwRWM=
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

During enabling of the RPi 4, we found out that the driver doesn't provide
a helpful error message in case setting DMA mask fails. So add one.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/dma/bcm2835-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 8101ff2f..970f654 100644
=2D-- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -871,8 +871,10 @@ static int bcm2835_dma_probe(struct platform_device *=
pdev)
 		pdev->dev.dma_mask =3D &pdev->dev.coherent_dma_mask;

 	rc =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc)
+	if (rc) {
+		dev_err(&pdev->dev, "Unable to set DMA mask\n");
 		return rc;
+	}

 	od =3D devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
=2D-
2.7.4

