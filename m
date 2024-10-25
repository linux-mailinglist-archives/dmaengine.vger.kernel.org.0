Return-Path: <dmaengine+bounces-3579-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E99B003D
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8001C22909
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE81F80D7;
	Fri, 25 Oct 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="OMfN+BJ3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9811D5CE5;
	Fri, 25 Oct 2024 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852615; cv=none; b=iIZQR7HQ13PkQneRI2xs3eJS8o+EPpM5zJslVCt4bzD49+U/nehOTbjvIJDkeMfjFJ6Fu+/HPH6xWPWFANbOfg/1ihxsusTH3NgXliJJR82hwWxHkhkwupGwv901YEcZdWKrNKoIFmtdFdP/KykM/0Tdm7nPVx3xRyYXgzSlXYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852615; c=relaxed/simple;
	bh=nDW0JkC5oOVw3y6HyHxt9mKYcZxpXMokS2HNemOLjZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dA8nWlWubuYFwyGPJeXgwnYt6dRe1v7m10ma+TvtPMGq6uXY2c5hWXqenfUcmlOVgMaKrvz2jQ5dAenGmFg80I6g+pwdgpEOSWpUFDa+KR4yzulonSlxmN0bHv44jS6DG8B7ziYJMgYHThB56ifg/LE968IsbaSTCVWeSJ57H6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=OMfN+BJ3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852594; x=1730457394; i=wahrenst@gmx.net;
	bh=7SJXJq2uX1cxKxMjslAAHJO+ZqjPnNq4UxpqnQBoZXU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OMfN+BJ3jEVar7Z9mM3x0Iqs1yFDb76xD9fFjkO+EoKsIGoZgHX7RItOBVtWl7ro
	 mLUjivfa4hADRkUN36kIeSWws9iGwsiidjSEi6Oeq5tYTcpJSJlCFbkOCyLxMZbqo
	 +/aqWop9S+NWSd3G0zKJrlPxyb6DhYGGNwFfu4qNydwU4+z9G/GTnoTYNka+13Lbz
	 5z7aahp9T1nkP9EpdWWS62VCRD4tDWvF6wo+UCG9StkZWJvFNup0y4b5HzmbLB7Xm
	 6W8krDDtpxjYBJzqwrOHCcfQ9hMymGPKWfwz3Ygdug4g5EccEdcOIqXkTlF56Zx2k
	 WbzRkd5TMSpo+kTXOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1tzUtF3bd2-00wFqO; Fri, 25
 Oct 2024 12:36:34 +0200
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
Subject: [PATCH V5 5/9] mmc: bcm2835: add suspend/resume pm support
Date: Fri, 25 Oct 2024 12:36:17 +0200
Message-Id: <20241025103621.4780-6-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:r6awQYunqIyfua3c0UOjHK0bzNoQpAtzd9ESDD3nUHWFOjq7NEV
 mK0a9d7j6jmP5GdgWNB6Y6bjTvlxAuNg1US/ywe2ZJ0IqMJz3bLkWAN8ciNrQHNwIJftSED
 WLpLEFG0ZesznqsbjvHuTEfyijajuo0UwU1bQkyjixUIk7dQSLB6Vj4z2Lty/g8L1qiDlqq
 HM9fUjoxFMdog4tU43dzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zvRF6oIdmeA=;EnW4FddaoRaUIEDasz8kgcQp10d
 wYPzFPZyHuuO5FHks02gX3Zr5ckD2sNRvkDtYDNe9pdoiwqkQsVdRAJ3XA5zILrMhl86BsKq5
 J5ODpCTnFPejaB6np1zMyhFZBFMPBFekihvnYlV7S0XDyYzZx06b+hFWVbJaDhYSnUkJ+8K+S
 nRnNNJpAq/OhtuS9S14mPQ5e/Y7Kn/56XUvzNWLe6ZS4YuzcGpPUKE8SSX4BHN9PWQxYW4dlX
 O34UUhooQahnyjt34DI6FlelxrTg5mdOclcOoKzgD/OKhJc8MArhfYx7zctqz1piCJKWqn7WQ
 fEv6d/C3c5IXwEK3ao7ic2lfxg5baGjius11pEBUUxp9vLuJU9zbqLTtMtUAD6jr2X2fW1cWg
 s9NISyjuibxiiBtg+gq7anJirFnxQiRhQ5eeJOVgpZ9dF01c3F/zh46nniyVG/hacWVfBbCxw
 bm4lH/7jb3gnOnaFNsBHJRLnvnAHIuRVa6/rdpnfHTFxQDnkNRfWuBBlSUsHfTjJ35sJyub0f
 0+b3Sgr5Fkghwm+sFKCEhl2Zsdbzr7TEJZdVi16AnqUTtc4Qwq1vy0Q1To72XnfWCfio9EZVj
 oKMo0Z6LOXqEELdoYx8j6YNhIYiHx86uzTVg6Xn3+LjMByb+h3Qcu6EdDypfmhMi1XtzXdPDH
 WTkdgv9NDLfKCMzWYy2hAxmiBb5qVgqUIsSK5dtmXUvSBLaO5dxHRbRDckrNriP2yu3j+6CLe
 Eisi4HIiulLdIlAE+Z/rkQe+osJs/S8Cm5ZhUnRGy/83FIOIx/8ll/uo/blaBHml0JSudYFsf
 5ZhOdB53DQ91gcy2LsfUXOYg==

Add a minimalistic suspend/resume PM support.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/mmc/host/bcm2835.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 107666b7c1c8..17c327b7b5cc 100644
=2D-- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1343,6 +1343,30 @@ static int bcm2835_add_host(struct bcm2835_host *ho=
st)
 	return 0;
 }

+static int bcm2835_suspend(struct device *dev)
+{
+	struct bcm2835_host *host =3D dev_get_drvdata(dev);
+
+	if (!host->data_complete) {
+		dev_warn(dev, "Suspend is prevented\n");
+		return -EBUSY;
+	}
+
+	clk_disable_unprepare(host->clk);
+
+	return 0;
+}
+
+static int bcm2835_resume(struct device *dev)
+{
+	struct bcm2835_host *host =3D dev_get_drvdata(dev);
+
+	return clk_prepare_enable(host->clk);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(bcm2835_pm_ops, bcm2835_suspend,
+				bcm2835_resume);
+
 static int bcm2835_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -1471,6 +1495,7 @@ static struct platform_driver bcm2835_driver =3D {
 		.name		=3D "sdhost-bcm2835",
 		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	=3D bcm2835_match,
+		.pm =3D pm_ptr(&bcm2835_pm_ops),
 	},
 };
 module_platform_driver(bcm2835_driver);
=2D-
2.34.1


