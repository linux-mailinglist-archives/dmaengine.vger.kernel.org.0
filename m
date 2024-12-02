Return-Path: <dmaengine+bounces-3845-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5909E00E1
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 12:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649A41621B6
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 11:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2E1FCFE3;
	Mon,  2 Dec 2024 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="f6PvWHbM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAEF1F9AA3
	for <dmaengine@vger.kernel.org>; Mon,  2 Dec 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140013; cv=none; b=JLokmSN4J2V3DxS9NqbrXH6K6Lt1bGFB3HWveTAyKcdnVjoC/kyAX0fntPZOEZu2vWCrKH+YLIxHcUvHPCOFOWTd/hOMS1IB/lK0gxSgQ+gXIoFhdCpD1/v+aXbN5o6SjSr2ZnQiYbslck6v2N4KLfE7SyM/Nf6yTMIHKuqa5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140013; c=relaxed/simple;
	bh=+9S09iaVF/+k8JI/9RSqmR5wXB4e+hKQAejO7++dJE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WnHY39rehrIK2hFqXTfyjRpUi7/4mMGV3Jb3SWFairM9l3Xfs8ZmuJBeWObUKQuB+kdqde2noaU6Zmm1utCPHKO7h+UAR1fNQO9+WqzYI9Wo4TzIeFPoYs1zE0xW0Oem8BIlEq5Ijr+DmdSKGLARFXxXpRg5MAK/saw6T7al6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=f6PvWHbM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733139998; x=1733744798; i=wahrenst@gmx.net;
	bh=ffLbhXWfV1ZY5e3a0agdK2KLcuejXAOJM22evfKkX5M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f6PvWHbMsR7RbFYK5lEdlCBdi+iiwuaMtcsYIuOW1auGQAs77etl+G15t8rCi0sF
	 2K0NGWwR32J+H0bLj7m0vnrLaVrnEQs0HoVXNLvvSAvusFAaOx1YL1IOIuD0I3q49
	 4AZh799GdG/Ihc0MFS/yFnq7jNCG+rCZZmkVYSz8x+ng5eZj6VFvfMDTIc8wb6F+v
	 3YVk5jqwNMnI5zK4DUIWcf0GsWDBV9BhUNGtH5wagsCTus6T4iq6tgonCLm1aQetU
	 izgxpbkgZbgvYPULenXMPbRXIkoFh32BzIO6NdUZJyEcgFO0i6dCYFGABBDcZrlCy
	 1kEouQQXg9+XLNtoow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1tQM5j3hVG-005frH; Mon, 02
 Dec 2024 12:46:37 +0100
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
Subject: [PATCH V6] dmaengine: bcm2835-dma: add suspend/resume pm support
Date: Mon,  2 Dec 2024 12:46:27 +0100
Message-Id: <20241202114627.33401-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zKJIcHPKE3BE5onouobDEWkv0+AWV8gQeA0wvhVyfHohNlvpgVB
 hVY1zkXWiyTOY8xp7aC57ETtFfpIXUtmDDuS2qS6GOkU/tp/RTtk0L8AlJAXMI8hS83tdve
 nKkMY9W31LvUfVG59OwzhiOPeH4rKIIjJffbYF7a+X8narRNxUIjw4b1knD6fMkc5mjGItn
 JiBF8xTEX4iVErwUNfJEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RRUChCbs2SA=;l964H4rfUnDHRORlfMVonlmYWUw
 4sW5ILzJp4xvfHTrNUuNFXwKmxs41M6rDkikPxHKlpLprkxDfnxMfhla4cRJ5jUKR/0wVK4Hz
 ZvyITRglHgsQ4BAZhiZKASdOJmxOiLElP6ft6j9IaIJqLQKxkIH4lMpR8goDT4Es/XDk8Zl13
 mPs4EIoer0XPbZ9Xj2gDbi3vjFStlQYPojRIFc0VQcUo7nVqOvJBhb6tTlFZ1irKnbBwGHO9m
 caHTgkyFHorLPW+8sxdHmvUktCOrm1rzvpFZLoxnQPRKwsIbq8lCI3B3rwLnFGL6RqIXUCsel
 QibkJgPVWvdqG4L2QRBRwk4gtFK3tAXesqCfsuiFy/u/AYMuNV5Qxvv57hp5OMPU4Oix95gW1
 pHVNSa3X0DoUAcS5jjBe93A2n014YGXKHGGKyCq5tUJHnl9ejThrQsVJHuJY0rT4r5LEV695C
 fzAXss76/OhqDSj6j/sqJ/bc0aCARO15d1KHvUMZLp4GE0H4OOe2Amtl6BkSC6SJEQJFfdgtv
 dMWWSf3JS8/bJhQtNQPnaCv2y+7HQkylWLjrD+Q2CqdIMXNNaYWjYzdgOFMj9m86NQ4foEAkq
 ssJJL5r8RtBoTIlIFmgvKsbHeVvCoBfprS/WNRHXMGbmDxkFtJnKZuWSwyjDBYb1e8ip5Hn+B
 2bdhOkb31hpL411x7hMYxwqu0j5RL9rffq/48pKdxsfoz0J+dSDou/Z4WHTsRS9ByR/g8Roga
 FNoydZ1VWAo+0oWAUBsBJ8tbW658YABeWo5WjkdzTrSOUBfUF/xKUcUCciS72zlDdp3KReLiZ
 wFmPkb6bzxMJTQBlq6lsuoc6S2kowHDcxGZTvH9XUj9ls+WD3vUyA+OEN02J+YBMFytPMZtWJ
 2CTdVXG3gIcP8Fm+T1EyX2sQC1I0DR5Z8UfOph00/uNBXh1h+3n2iuQGw1eitRB+/kgnB0kfp
 yGDdzGBiSRytyXVLPGMIlhHTd5k4xtOJYxq5HT8YxnoE8sEIEO3hsUlbibXlBmSPOtwbi0ptn
 mof/dh8csnsAoQ+JgObmniKfsVkZhYttpG4F5RgaJXPTwmTeZvL8IDBik8c1id4LyQnvKFBUL
 8OniqMi2K6YIxf8r95BD2qknrB1/Xh

bcm2835-dma provides the service to others, so it should
suspend late and resume early.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/dma/bcm2835-dma.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

 Changes in V6:
 - split out of series because there is no dependency

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 7ba52dee40a9..cf8a01a5b884 100644
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


