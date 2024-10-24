Return-Path: <dmaengine+bounces-3551-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E251D9AF373
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6183283109
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2AA1AC458;
	Thu, 24 Oct 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="fkSSPrHf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF5184101;
	Thu, 24 Oct 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801146; cv=none; b=h7pQ3gBVUzp0XeXXuwJo3RVYBcqzNv5figtr2OmT7LZ3ZGwU2d6R1I/F0WU7rjIWAFkFCLBrqVYCBxYl+gBWRfbOwcyshxieTH6xSakVqzrX42kNA6wmA8gWUc0K4YSaqKUwv5uIOQpPMr2/rygOlp1vlGrrzdFgYz4a1Xe7Uww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801146; c=relaxed/simple;
	bh=W/Eol3PGqBkVJnzoyfSd/OIVp/8l/BiqcbjtDTzoD5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zzp8m4FIGpTF/ARCPK4VOZ5VbTBumCd7al1OuqR3e4xt2OvemVrzSopa312X7H3XRVeA9rjqOekVCyjfrUI4A6+N7Q895Vq6RLIRKg+qEqE+RWactQagfQLn+O9PmiKbCjXi0xht6fNV/JaVLLDrXH0hA0S0MMyZeq+LUo19MCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=fkSSPrHf; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729801126; x=1730405926; i=wahrenst@gmx.net;
	bh=TppAUiDXkUFwSrv2A2knMxXHQkH96XkM3sjE1E2labc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fkSSPrHfP8zuCDU0FQvXVesIFe0r59OPVPafqp13z6faJWuN+qe9m8e4Wvn/zVXo
	 kTXnXzVpL406wexjvAHBkZlM8oDg22VDJYQaHIUgCBeOaNFzPkOG4cbtEETBYVOEo
	 kPLkb46PkQL2fA5BoO8y0+FH1fxAAjwOOnJ3smndqfO8Yh6i/ICbpf/WmEcSEBoJL
	 h/73jMD2QqGUZT35cLHcmrJ8W2zWgktTBiiQze2yMoFhFH6gnxfz0EXSxW1A+nyXN
	 F6g87zasR9YzlQb9YfmImwH9soaYjAHlT3vHL0gmUWrO9g/sPCQ4r74ZbLzF+9yyM
	 nC0HwqL5dtKEx+o5Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1tQfdw22Z4-00TIze; Thu, 24
 Oct 2024 22:18:46 +0200
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
Subject: [PATCH 4/9] mmc: bcm2835: Introduce proper clock handling
Date: Thu, 24 Oct 2024 22:18:32 +0200
Message-Id: <20241024201837.79927-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:N3tKX4mSMl82K77Rqp30pHjdPKnfkJo5HTAHo86MD9OPHY0F2/v
 V5Z5RNm/VpCjv/E8YtDmv8A3Cie1520lbzwFOj9pefuP7NUdj1eoNNLqFn5HIUy/u1gjJhw
 ZiDYAGyHuN3F7GGNcGbHR4Oc0cXc3dhBvYTx2o3EnK8a2iV04dlFpjky5ngicZreQTthbBV
 EOT3LnUTA5oinVOI59jZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BM4IuQddS9U=;c2AS344vTTYGtGZcIMh+jqcDywx
 sJEWBxyaT0tqBhihI5NGhQxC8EcLjeYqW6ZwLRZ1580Xo+S6cTVgWtyR+IjXC5HqTUwhCfgjR
 +tNlG6U2nbHFAvIeMHN5Cz8xQIOfapRRqpAECdQ/NvfcXWOTszC9SKUCpzSYsY8qZcgi3P53c
 t1u5K/b+pRnuAtWASpwERgu9qplnGc178WJE92gFFoYvvsID7DLa/OGZECg+QdVXVYWC+ImOA
 Wqv5YHIWrr1fTtugZKw8QNkiYheSXlCSCNv1DKOkCOoGBgBkKtRI2C58K4trSfS8HAD9fnc/I
 I+JHcX1BGp4UVy4HARdhRBmZlzPNiMjfvSvWj+tDw6SqAEBvIryvcc6Y0bjrRj045SQjPIOUw
 Jrjuto4RfZ1uCsYCe7v0oU5oulw7/IVxA11DvLaFUn2PyBTOeGnZOU3Ry+L4MO7WWNL6t5t1/
 GEFeoi91Vx/cK04O5cjhvp63xDRUe54FXR1oe+zUgHfk3SsATOit5GXfiWZe4at8k+0PVrvKl
 n1cU6pAP4ge4IIbdbR9Uxi2SpwwNGaEJfD3DLbwikI870UaNSDbGj7sHywAVnkfOUfv0EECRC
 LBSPTOfBNCr7/v9Zk3V+yr7r/21m+nFcWfm6dEHai+Kjsi0tTxQXAGI7vJFTR1eklcfaeil3d
 7iay6oaBxsHGbWz2xfpOq2LwKUECb0hzkBy0UuSnhOE5EBmQFi3Ae74Yv0h0GqGEAY9H93TTW
 C9ad9W8MV4BupQNF7d+F5o97DMwwKCHd8JXqf4nHPevojPpqvDDVzb0hSdNOGXLwtFEwMTiPc
 s0XDmfh7vMc1ap35fZMpzwMw==

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


