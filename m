Return-Path: <dmaengine+bounces-3896-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F729E43AA
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 19:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7CCB3639D
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFC20CCC0;
	Wed,  4 Dec 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="aA81DUed"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2120C473
	for <dmaengine@vger.kernel.org>; Wed,  4 Dec 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331374; cv=none; b=t3AjY3WSgcfDcylaMWJcfV7h9/AJQVx+2b8CboO8IqPrSV7SoSGNBRUnyigbfHi8729c14r2lPuPspdCDB3TUGNL9LYgR9ykH+J3KWY0u1Qs8rECL8Gzx9PND2r28NbfiA3o1UspJA/6j1R3q2Il6JgRy/Woa7C9jdMJY3jAj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331374; c=relaxed/simple;
	bh=F1brsTkJJmPOMi4ELOydLo7SlVpugG1dZS27/cf2X6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUpvpD8uhnnG0ATGl/NCvPgfC6luKo4WgbuPL0zrGW+KA8j98nxBYYSczqKS7EA6rRZv6ktLg26Gf4dzmW4MZBgCTZjvjukSpwrSGw4mPvPexJcu+IEHdvszGAgLA8kCoJ+F4+3TY72m+B+SoIkltD+mFGrhq3BtDNFczNCEyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=aA81DUed; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733331352; x=1733936152; i=wahrenst@gmx.net;
	bh=KqH4XcRMfI2Bxx9Jc3KBc08//bchRqV/s0pS86fK7WM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aA81DUedeBBDb8OShGbLV5xaQPknl1oAzAV69nHEnVYaA1LGSc0UQwAgxAmM/xMn
	 8niKmK/7gpd/gsfdAcUdc7H6mKdzCrq9oc6Bmoz3/+mkMbL8wf/bpK/OIXG2p0R+4
	 YnVoCu9afAjW2yLUq4sNdQFz015QzEWykKyxHjVO4ZcW+d06eCw2LGQ4SZ3GUs1oy
	 /mX7XFJFIBWW6oVDjyDEQmMiVs/HABS0sv0IVEbxSKAdlTBZlgMtI58I585QiZbQ9
	 ft4QdG/PfsqVAhYkvS1YSfc6zHB1obkBn8DuqBPMli2A0lVy99H1JGd5PURYEdAT5
	 4KUyKSYEnFrVjoZ98g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysVs-1tWa1i18Rm-00zghB; Wed, 04
 Dec 2024 17:55:52 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V7] dmaengine: bcm2835-dma: Prevent suspend if DMA channel is busy
Date: Wed,  4 Dec 2024 17:55:46 +0100
Message-Id: <20241204165546.77941-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jVWNY/JhiIagB6hjAtbxJIHHEk6O3uQVXeHtp7cWYzSiDsAxT33
 RNPFSkkItR+7vXzulSTBOUz4Wocw+owg5DHNPmAGKZv5obIzHKbXQcytAqeT6ICFqI9GkYZ
 mRKAXiV6ZD4sAksel1ryFlkSC+u0cWR7XCoQWmKugiu1+6XoeZicVPE1m649hyekwtVTyjl
 slCkAHUG6+/gRm058S0gg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xUThG0gzqyo=;wHv46hJ47n/3uQzskiTPT6xF/v3
 kImqhn8R9Jl+lyExokOjxGFOm0wegV6ld/mk11STMq/zuRXNgETEGHZsJ/Z9C8CRrXA+YzoFv
 3+hQvY6vTJOAloKm/pQwPdJTka6AOcIgZt7SNIoiKHrBv4X1wNtWgWskkNO/YlxZtX+P/QjAG
 0PI/l9duF5FTKgo9E9Jk7VIhMVryPIgZKw1xzeNyaG8Z1owUO8DK4Au3cYRr8xWiOJE9xx5SG
 PITgoylLwf4eqyKu/phnG11VsO8lc0XL0vobNJ3lbNdHe+oS2JAkGR7Qu5/oMn3lrVxH6VaX2
 luZC2fsh13Df3uDg3epTieEAuAf+YfGkUIm0svaS/IWT6OoGPSaYwD5PKj1/iY2/dLOU0YOlT
 +zUHYTHw57n8nu6FZuwX7ffCtMLi8xXr5vj/xtkHnNUJh7zkiAVyc7bd/OIuatVtfoLAnsWCd
 MvLkulkY2OCRsPg6Cz1t54sf0+4Kk8Hy5gLtNeNhY3j4ATFDno3ki++wTN3ohQxOurfTjq0Gf
 tBeWV92hId/J4D5KE0Hr9a3zR+e30dDOY2AhcEBpC4ppdvm5rgCdtEaDB8AwX6Ug4a/qLJE8N
 CFuwga9wQarv3qluD6q98GG4BJPXyJnU4F2RpeIWO78PaSaKZ/3fFSg6oGyvtefom5eUN3QsT
 lX9QeVHSDAtNv5cYEfHOMHq8MHQniVN0zFiFIH7hx9BefUvyyVHCzrz6EWi738Fru4wOV/OBG
 83YYQ+6khxDaFf5F8H3AlRTB3y8+VQYVghcEUtB0aoTiF3xUHV7XYijq+le7Kh5jiz/hWjsBP
 l+KT5yWBEJ/7nQjVHR27mGYw7nNawwUUXQ9wGLPijqn5OTwHRcvuHoNpQuODSR58ghAPWPsI6
 w2xgzu1R69O5ef9o3eRwyWMpFHhhSq6C7xZ8bsPJik6SWUHAeGrkfed4iCz7amfEi6GsNUmnF
 D8hPGmiz6YiCESnV/2FMR9rGHYvw8sZQuc86eAaHAhlrVOAwINoiZe/8X0WDvTGoz+cLFmKRG
 mJQ33wd3mAnAwHD5smANi4qyG35duHwZ80LuBjZ1MZOZByv8JfW1qp7JSB2COg6j2CeaDwKb2
 xVi6mgcBZiDQ4XDBHGkClIqiuhqifV

bcm2835-dma provides the service to others, so it should suspend
late and resume early. Suspend should be prevented in case a DMA
channel is still busy.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/dma/bcm2835-dma.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Changes in V7:
- improve patch title and changelog
- add explaining comment and drop warning in suspend
- drop empty resume callback

Changes in V6:
- split out of series because there is no dependency

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 7ba52dee40a9..20b10c15c696 100644
=2D-- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -875,6 +875,27 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_p=
handle_args *spec,
 	return chan;
 }

+static int bcm2835_dma_suspend_late(struct device *dev)
+{
+	struct bcm2835_dmadev *od =3D dev_get_drvdata(dev);
+	struct bcm2835_chan *c, *next;
+
+	list_for_each_entry_safe(c, next, &od->ddev.channels,
+				 vc.chan.device_node) {
+		void __iomem *chan_base =3D c->chan_base;
+
+		/* Check if DMA channel is busy */
+		if (readl(chan_base + BCM2835_DMA_ADDR))
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops bcm2835_dma_pm_ops =3D {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(bcm2835_dma_suspend_late, NULL)
+};
+
 static int bcm2835_dma_probe(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od;
@@ -1033,6 +1054,7 @@ static struct platform_driver bcm2835_dma_driver =3D=
 {
 	.driver =3D {
 		.name =3D "bcm2835-dma",
 		.of_match_table =3D of_match_ptr(bcm2835_dma_of_match),
+		.pm =3D pm_ptr(&bcm2835_dma_pm_ops),
 	},
 };

=2D-
2.34.1


