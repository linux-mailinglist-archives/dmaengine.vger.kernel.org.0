Return-Path: <dmaengine+bounces-3550-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 268549AF375
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC2BFB214B3
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F018419CC3A;
	Thu, 24 Oct 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="FWZYMB4i"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94233185920;
	Thu, 24 Oct 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801146; cv=none; b=C0nkYmiwR+qwCCGHY4B50IlH0Ji7usFuKfhdC/4z1fzb5eXCGYyuVk/H8xslHPz5T3nRmd6Qo2YKBTSmnyr17i5Lh5gvJGJh5C6nMpmC110SrlSLl85qI48CeF89Tuv2gHGtb0wzSj9ShpC5xaiKJe7tVG5fmmtKpyfDX76wx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801146; c=relaxed/simple;
	bh=V9/4Nd+sWme/u2mCmc2sE127qiJQZgk7dOc5mUf2E6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=To0rLQGV46J+DzNdBvDDyeIiLa7XNT2fdtoq0AU/Z/NIAR3iodev/tH0vq/pduZ51E6LnFkXh541lrJDYTADzzDgHwhSw7O6cotnuPgt7sAXmRTPwwtF2wm5EgNWtSMP+vMn0t9wlJ1okhQPbCAQdSDFrTQMHWnXaUksXQhlKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=FWZYMB4i; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729801125; x=1730405925; i=wahrenst@gmx.net;
	bh=KTdkJ5P6J2KL4Qt0vXA0RPNETkbTyLxenzCZPLKwNyw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FWZYMB4i6pII+5Cu3Z5TKjNhZw3OeczRSY9NS1oKV+6nCpO5qBxWkFSMzQy3ryjy
	 sTBPl6mymi8N8pfcjQTGHeixmz1FlytcthQTMKfUKj6lj84V+VBjLmBq3UgalJkva
	 JEaQFMRjgNbNbdMEaPmK+wAshzpYPXvTCn17cGjSsKzmWYik3rbrkKHlLo1ybXYgw
	 nmpXqDpNELx0KrelSEq2Bs+U+6YillRq8IJ0viD5X7COpWmtluzO7vibsakKMu5Bg
	 Ozx3pTFWgU0KSPGK/Rcz7+ZbUURtla0EhwLwSQm4nJlNpYgFvArJgR7y1qypvMbPj
	 CC9yErUmZ94S0rAR6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1taMqF1UCo-00fMm2; Thu, 24
 Oct 2024 22:18:45 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 2/9] dmaengine: bcm2835-dma: add suspend/resume pm support
Date: Thu, 24 Oct 2024 22:18:30 +0200
Message-Id: <20241024201837.79927-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024201837.79927-1-wahrenst@gmx.net>
References: <20241024201837.79927-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uurm7aNTi5uMv/4ThSbmO9f2OZgP0MZnWhjwfJlbBd5reY0RN+4
 IAVrERajL/SXD91WlaaM5YamNsh/dSKucmU55D5SaAEEQkoqZBY/JHgqNxRpe0I5XTRShXL
 3u/VkDO3dMzYYk6cWKJTvkzd/3tQ0Ng04QCY6SWoGEJClobXZpUdzZj1vDLuxu1P9YxyRx2
 DKKtsV1iGb8R5B/hQ1oVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+I6/p0Kc/ug=;MnMyC57laSsmSHRtvqZJ29mp/Nb
 ePBEqIpKuQ7RKFK7KACh+NKHeayIpTFmIwoSOdWHe1XRErBmYkSoLGDQhOKUpPUTsWVcFue/i
 rUMTicPtvX9cqyD1KQ4eJvQvH+nWcurtOmNmBXo+bi0dofmvddlAj5McAgWtBvMG6GYIFIrN9
 oE16Y/uJh2Hd/R/euG0xJDULNTZbEw6tgfXATdhS3kFFfnSNUfV4EWSyfW73EmSIF6hrN2Hk5
 B6gS5N/IdG7wtL26mujzFnpR0JNUP+xJ/bCsn3e7pHmNOgrGvsZ5FHx/uxVu6hoJ8/LLOsp5j
 X+dXXB6VOjJHgV8mQD2mmBETQaZkP/A3mECb8xigYDHAL85umvvilsWxnTpQs2NnS/8PKYT73
 0S8ZqdPMEymxnWMvafKsHgo4IIj9k9pCTXc7kg0U8jtrowurSIYRfvqmvwEKjXAVFqD04rQbr
 gfwFAg3nzhPJqQEmiypB8qeicZn4Fn1nGB6b3OByUjjwQJahLl+n4qPrB+H0dTnj1lw5pvP0f
 g+HpQXexssH1UuWRKnCBu2LY8DUUjarhkvk34n9DmeqFB3hLOm0VwBw6b0rSLCnkgcbEgh3my
 l8rtV8v9UH6OZMRY3/p2p/6fD4jBiWfNovx09+EJx5dbyFPaDmTlL0e2VnLWbWhJVmLq4yGwo
 abyowlcPDncsKoUBF/ywor+7bT9STzwNIpIAC8BLXDpYwUCNWiSG5k6O1K5XdwOpwMRWObVyi
 j3obmgQUA3H0m1j5dleEczNfwxENYHJo8t1h3CMl/C6Zq2F8/ZEAicuhUFBP8n3BEBQWB/B8P
 qcoHpZmtzh6PglEjii4PGTrQ==

bcm2835-dma provides the service to others, so it should
suspend late and resume early.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/dma/bcm2835-dma.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index e1b92b4d7b05..647dda9f3376 100644
=2D-- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -875,6 +875,35 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_p=
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
+		if (readl(chan_base + BCM2835_DMA_ADDR)) {
+			dev_warn(dev, "Suspend is prevented by chan %d\n",
+				 c->ch);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+static int bcm2835_dma_resume_early(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops bcm2835_dma_pm_ops =3D {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(bcm2835_dma_suspend_late,
+				     bcm2835_dma_resume_early)
+};
+
 static int bcm2835_dma_probe(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od;
@@ -1033,6 +1062,7 @@ static struct platform_driver bcm2835_dma_driver =3D=
 {
 	.driver =3D {
 		.name =3D "bcm2835-dma",
 		.of_match_table =3D of_match_ptr(bcm2835_dma_of_match),
+		.pm =3D pm_ptr(&bcm2835_dma_pm_ops),
 	},
 };

=2D-
2.34.1


