Return-Path: <dmaengine+bounces-3576-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816079B0036
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36B01C20AFA
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038F11DD0DD;
	Fri, 25 Oct 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tbVyV4xm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848C1D54C7;
	Fri, 25 Oct 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852613; cv=none; b=M0LD5ShFUKpM5IVvFaSqd774KiBHBNA3vRNf2klaqbMQprSQX8SMjLxBCHgca+VaW2BviSoF8zLB8hz1duAhRhbJYTl04/JnzfA0Szbz5yJQQ4DOt4Fa5+TervVRVIVSppgUrX74RMHitLNEtNn0kO32rBrhx4SQchiqfkEq0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852613; c=relaxed/simple;
	bh=W/Eol3PGqBkVJnzoyfSd/OIVp/8l/BiqcbjtDTzoD5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMQ8Nius3mjtDtM8c7Udn3Bp05de4fnwgbG+HkRMy2eNdB7dyB3NcVYNtphQAAe2IQyFBZvrhX4aQfpdbvDnxW6niJfkD5PyB7lrnGnU4281gPziU8ovMOZ2TSE4ON2z481Wt8+iEe0p3dm+sob2R8A1uILnuqX3xZelExqWkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=tbVyV4xm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852593; x=1730457393; i=wahrenst@gmx.net;
	bh=TppAUiDXkUFwSrv2A2knMxXHQkH96XkM3sjE1E2labc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tbVyV4xmtEPMhA3DvUpg0Jw/N1a4F2X2KKzCpHgsSj0xDUxTLDBFMKCSfoFwlIy2
	 vDtGZgSHpvDtOK2dL6OcZ2ICIUzLZeS+ljjRJxsTp/AqOLKTqNE/FuiPB6mwlSd8X
	 HCGBwNca9R2fvYbyEyZz2OSkz/thjqc9bkz5kZ2FabEcJi3OiQ73vgLOZRIkRvb0j
	 njph056umZyVHkLBcYHnalBxHNPvnKKsOtqhNla1xaT308YMVXCQGJQiYtcyBtyLM
	 NHqJcaC6UqMoWjYsvgNwd9KWRgtpG143MovBAzOMrNOTzAkWv0Q+cBP3NsW4sWrf7
	 hy13a76cRP4mUQ1UOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXyJ-1tOFGY0ryZ-00POCJ; Fri, 25
 Oct 2024 12:36:33 +0200
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
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V5 4/9] mmc: bcm2835: Introduce proper clock handling
Date: Fri, 25 Oct 2024 12:36:16 +0200
Message-Id: <20241025103621.4780-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025103621.4780-1-wahrenst@gmx.net>
References: <20241025103621.4780-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Di2pOcsa3c3E/0JQDbVqLTw7ySipdBClQ9F/jLlbeQzzRxZ232
 yDWxEVys72iA6MJRo1mUc7mW//tb7EZO5x8R8vS4QVuCdF0xUENqvAZX4ThVdfxDA3kMxg9
 FgzpKa9DTwgbt9nE3gAkaOXKsz/MQTt48lCSrId6nhTj+44oURFGsMXI8iN3zDfQMu/LewP
 k6bEWQhIR5AMhkuISMu9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DeStJdH3WkU=;dl+pokVxqHve1DeFpO1IWkIos7B
 NL9bIHQWsfHyBrcFpODuMX0BfcrTLC7ylSEQegr93PrtNRzhiY+MwDnff6soAJEJP5FpBad+L
 pRil+1xmSn80iEi64hXM2iCFi65CBDZItjTqanf5RnArzPLSveAWnecA81mJUmh6fHaIuLojr
 +8SA8vURLGQdQP124dyYLb9QtMkGctEm5YIPtNrHqfWKAqS4EbbIYwZseS2QCb8NFH0rQ7+sH
 M/kJ/ndEZ3qiaXS3TKkvn8jCO/1Sn+4+eBLr7Ajr1BOAaO2xpsLdCIC7gH3wPWwPAYzXwnyPT
 Ov7v/THpazrlFXYtaXkX07A5acBWslOtgsnxjuxtl4hxvhy+s5TESFBj8qEp7cHdlf3EyHSqV
 FATAFz576Yx9HSFppvyiXxeakkKG8VY3D0F4eLUOFq5R3gFMKPLU5DwSbhMubgK+uui+26Wwr
 VQvQ5QIgALtjOeP36fbaA88gXg9Ih1jasBRmTQKDK8oS3bOdN6+yCKW8ohe3Gwy3r3XAft9bm
 F0goiucGyEl2zhm8LRQ1Tn0FFMvPJ/umMvzXd9Mz3c5X5TilrxG0rHvxBU8HUIIbRTmHkVtZr
 2nkh9jLlZfzbRLer9knyKe2VEkJXO67GIXWOlvcD63JusVA2TdWLSsqIqvUstRkdQGAuPdH4x
 AGThr7nrm1d2DmyZmLW77dpB24ODzdUWze3TNtSh8SDEI5IqBdDxqK9HWnL24sYOEV9Ehlmu7
 g9hU9CblYCC15244Tmksr3wK3f2NFBP4MmlFNXwK4zBn2HJu4BSTZngZBaCor9wJYgS6So2jo
 RpN6WurQEWJSd0Ob16hmls8A==

The custom sdhost controller on BCM2835 is feed by the critical VPU clock.
In preparation for PM suspend/resume support, add a proper clock handling
to the driver like in the other clock consumers (e.g. I2C).

Move the clock handling behind mmc_of_parse(), because it could return
with -EPROBE_DEFER and we want to minimize potential clock operation durin=
g
boot phase.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/mmc/host/bcm2835.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 3d3eda5a337c..107666b7c1c8 100644
=2D-- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -148,6 +148,7 @@ struct bcm2835_host {
 	void __iomem		*ioaddr;
 	u32			phys_addr;

+	struct clk		*clk;
 	struct platform_device	*pdev;

 	unsigned int		clock;		/* Current clock speed */
@@ -1345,7 +1346,6 @@ static int bcm2835_add_host(struct bcm2835_host *hos=
t)
 static int bcm2835_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
-	struct clk *clk;
 	struct bcm2835_host *host;
 	struct mmc_host *mmc;
 	const __be32 *regaddr_p;
@@ -1393,15 +1393,6 @@ static int bcm2835_probe(struct platform_device *pd=
ev)
 		/* Ignore errors to fall back to PIO mode */
 	}

-
-	clk =3D devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		ret =3D dev_err_probe(dev, PTR_ERR(clk), "could not get clk\n");
-		goto err;
-	}
-
-	host->max_clk =3D clk_get_rate(clk);
-
 	host->irq =3D platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret =3D host->irq;
@@ -1412,16 +1403,30 @@ static int bcm2835_probe(struct platform_device *p=
dev)
 	if (ret)
 		goto err;

-	ret =3D bcm2835_add_host(host);
+	host->clk =3D devm_clk_get(dev, NULL);
+	if (IS_ERR(host->clk)) {
+		ret =3D dev_err_probe(dev, PTR_ERR(host->clk), "could not get clk\n");
+		goto err;
+	}
+
+	ret =3D clk_prepare_enable(host->clk);
 	if (ret)
 		goto err;

+	host->max_clk =3D clk_get_rate(host->clk);
+
+	ret =3D bcm2835_add_host(host);
+	if (ret)
+		goto err_clk;
+
 	platform_set_drvdata(pdev, host);

 	dev_dbg(dev, "%s -> OK\n", __func__);

 	return 0;

+err_clk:
+	clk_disable_unprepare(host->clk);
 err:
 	dev_dbg(dev, "%s -> err %d\n", __func__, ret);
 	if (host->dma_chan_rxtx)
@@ -1445,6 +1450,8 @@ static void bcm2835_remove(struct platform_device *p=
dev)
 	cancel_work_sync(&host->dma_work);
 	cancel_delayed_work_sync(&host->timeout_work);

+	clk_disable_unprepare(host->clk);
+
 	if (host->dma_chan_rxtx)
 		dma_release_channel(host->dma_chan_rxtx);

=2D-
2.34.1


