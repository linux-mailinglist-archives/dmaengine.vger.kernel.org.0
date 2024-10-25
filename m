Return-Path: <dmaengine+bounces-3577-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB29B0037
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D1E1C20CEB
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4AF1E47D8;
	Fri, 25 Oct 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="sTuq01Qs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99681D5ABF;
	Fri, 25 Oct 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852614; cv=none; b=RHKGcJnPatwWnlwFXfBbK8yKrGzDAsH0YpOrOi3LX5CZWkoizC5jAoQBk/bamVvkbK0hqKJkcYn6COnz8hSmkHaYAPDCfHSKtNbRBLCF1TELslmBw3hP+exO2wog363ClvcRJuvdiDM5WJd9hQ9UKJQxTZBy+d/siroFXbHFfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852614; c=relaxed/simple;
	bh=V9/4Nd+sWme/u2mCmc2sE127qiJQZgk7dOc5mUf2E6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+554tdJdlyAvnaROEZklvtenbrPkvIqBLpiUZcPs1Tm0YdJ6S6ZJDl9a7HFzLr6RdrFbMNLNQdVuru9v6lpVL0g8Yn81zkYTQ8ZrgT71jPT/Kmh4lnayNwofKdKFT4vKDXu0ritGXOlIVyO0q6y36fj1n3pqSNyos8JWDS8+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=sTuq01Qs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852592; x=1730457392; i=wahrenst@gmx.net;
	bh=KTdkJ5P6J2KL4Qt0vXA0RPNETkbTyLxenzCZPLKwNyw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sTuq01QskJq2zdiAiIljyIGlG2h1rEWoc/ghG7FS2b1oNWb1biDLhZyfQLPCtDhz
	 4DfqY2404X1N8hd7jUSizN+ACfzYPc8jwUuneL0b2lV3RFoC6roUKh035M4I0h27Q
	 qi589UXd/Xwmn0Xmv+YpbB1mW7H7IZJVNyuQb/YCN7amnUmFbWDEfJHHl6tOzAYxS
	 hdAx4lXb6B8jH33Rklu5QdNGh0ZNB6Mjv53WFEhXVzgU4Tj5m7BoSF8yvKSpO2/zf
	 7gGh35/Lcp9Ej09sJUm/9xHjuHf/Wj9IBU7G4/j8czTXI7uqHWrtb2Du5PeyNDL4R
	 FACT4hUAsvQgW76N7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbBu-1tvhHN3fXy-011DvW; Fri, 25
 Oct 2024 12:36:31 +0200
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
Subject: [PATCH V5 2/9] dmaengine: bcm2835-dma: add suspend/resume pm support
Date: Fri, 25 Oct 2024 12:36:14 +0200
Message-Id: <20241025103621.4780-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:9ySflbT0hiT4UVGNuvyyRzkwct+mz5PnD601aE9k6dVwc3IIdMJ
 9lvj5fWE+a2G9m7siGoDQyifgvrh3Q6BnxgJVGRvEGIKotsSDjiI4VIxSKZkLEiMBJika6y
 q27k5rxf6BbGefsUmf5Pa3EOTRGST2FFI91IynMUbxtgnob6y6X57jSW3SB5zMJGY1HHy/+
 lmOPdRwD4PhntEGUfAN/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:omwtgH910K0=;h9ZuJ0bANMewdfvjfbq8oysc/QH
 kZaXBTyFt7ejXXdTw9ffWKtJQ2L7lbl/boxn7T+kcmsNYd65+yWejg1lT1yC7FJuUqhQY0kSd
 6Ub/Vh2rMAVIQp/ECA87TiM+sZ5j7/pZO5k3+tRgHVv1n7FozbhUft4ZZIVV74tNvLFH8hAf6
 hBpW3FPi+pVmEtS5R2+qo0WqNKhie94/PHHsIKzbZMRNm0Y6C55COM+XWHOOGnBEZle3+YZjv
 jVNoG6F9XrnEIrdJ9ZwPIylXin0Bxyd/Z+dt3er2m7OQLy3qb9LFxwyUjGjAGMvrw3fLQAQJa
 yrkxlkkGaaFjfzGHobMvL23XkbeuXpIu6UG4AS/pUirLc1Y7qX9IXNtogAGVrpDrXAz882xSR
 n75gDVmw+D0+MFnbeN90gg1LdxfWJyvzYUultUZvoHzWmZCc37/usUm4mjzAdwaTq4xds+gWG
 aQf1LJbG5CEfBFkH6KXdlNVDPvnn7ZlQWF+2rspN4iE1LL6bTrlLf3ZYGSblNvKyP1peMBZmc
 2kjm8cUJog8BXgYR1jWNXEaOQHHvgxdlu3FnBpTCWVh0q5/Cfwfqfdm8UwXGFG+awOeYYPCQC
 +mGYjTVrb9asXnkIHUmqKV5RGWYkM8vr0FoMTkXAnon5kv9X6Uo92BSJCeZ/1ObY8+kKew5hD
 FoDvYF4UP8DJZ5H3rgDUCmOG5C2IOryK8XYSVoZk4Qjfj9sz7p6LFDzVHrJMWyJZ3GLJmpDma
 NEr0vMb0YkeAFo1q3vxJRlrysD9oHmlfI6zu8NF/SX24O4wyDj2uYT2VPWZNLuyzDZvJ+BCpS
 jI4PJXdRQv42b8HQAJNc/XZg==

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


