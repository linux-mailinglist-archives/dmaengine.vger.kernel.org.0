Return-Path: <dmaengine+bounces-3556-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21F79AF384
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C1A1F2317C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19397217325;
	Thu, 24 Oct 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="mCOITbe6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D41FF7D9;
	Thu, 24 Oct 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801150; cv=none; b=m+ED3b0YRz7UmMcYV5GmE8Ea9LC2JrxTjoCcgmWCa1eX0DP/BbQJaj24zndQgFRLsa9iYSiZ4H8iqw6SnwYYYDJmjVi8Qc7qw5RVR1MTzhTsC9dyhN933+Otu3iHHhknetu6kyQpRdPSi6s0kCQODeY3TOmkVCPL8hlLNwDWWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801150; c=relaxed/simple;
	bh=Dnh9zA68cmn86JxmjQWm3VeD9mYPGUG2L6WhqKPqrUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lM/nXwQCgXsnQ3gXEskXD4nl0+dTFUJ+1OlosFsbMBgR/njOtsefcHe34B08zXQ91pFMRRdzMndYNWEW1cXIitR7wOgl2l3aReOuEra4UdBBT03+hloB8RTt1fMo7do+0ueu2aFu0HXUjxwE0gtneeg0YTGLOaSQpJWpaSdX8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=mCOITbe6; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729801128; x=1730405928; i=wahrenst@gmx.net;
	bh=09r8SsGNZ34ZiyCPE+YPDY1tjwAlvhjANIoGjogob0I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mCOITbe6kHxdddVppdEAfMpWuaJ7FXS8bFZWtv08QtIXMgFQPg8lO48zlrMFjNBf
	 IjaCVhUBQfVf8Dxzue6u/KszzyySDHkoBTWGyhM27HKPmtqcp1Sqawfvqrf6nxS8m
	 ZpBLZ+tZGo9LNkXeOnqzvuFnni1M1Bdw/kBogY8Kkf1JKv3X1pAKANKMPiHBroGfl
	 n+T8HJF1Yg+KwA/H/+geVhD27n32TGhUwFhm/yvtUka6lLbRGe75cXNqbUy7mVSPp
	 RmWsBz3E2BgB+z32FQXjP70h6L6fY0dJmSg3yRTuNFSoU3Q0fvzKGPbX/GSG9l40m
	 rsT+mjGe6+gqkblBMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1tWoL3372P-00ahnt; Thu, 24
 Oct 2024 22:18:48 +0200
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
	Stefan Wahren <wahrenst@gmx.net>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 8/9] usb: dwc2: Implement recovery after PM domain off
Date: Thu, 24 Oct 2024 22:18:36 +0200
Message-Id: <20241024201837.79927-9-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:zkKVgRdB44ItjXckFDgPAlkuuQ2i0j7P5bnbkUiZdasbdzYhQAt
 P9aB5ib4nf0N+oSia4NHvIKYts72cBONmlSRqGoCcQ7ibpjNWt5EWDtrm97BJk2PPqYLjba
 BjWiG7tbr0EWFKAaJFKw4Aakpi4LERXa+wRyYlxTxjRRLYCNrHfZdEkxZHlsRk68fQJPRqJ
 ST516HzZLglAylSOYKMUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H5kEY+3Mlns=;AcHF9pEJKh8r2X5rTvVoct2vQuF
 hqqbFxf+9UnM0tqC9UkdZWLVXEUytN9iXAZ4o8/2eYOcotjuH0kVNMBW32O5jVmNRW1ez6Cif
 8JyXMMV90D5tHOpQrDNx+61GxBjLw24HyYrl91VY+DJOFiyPhreuFtBLtSSw2yxmuFSylAGBK
 J+Y5eJ/nVeo/ysNnRGqP5PnyfFxkB6FQ56pOmGix2gpUwIAtA96SS3xzBYEiwa8xBLDJbNzPp
 x9T7/cGKlGJLBwNN/RVbM6rFnQ4qPdZHyD94Yzp47NriAj7m/AkW0TSF/HDHvaZ2iMJ5H9iqT
 +A5k+GPuHQdCZbZowerj182DNm8FhJ9giHAoqXRCyH65WPW1VXRvGjg97eCWn8q0qVWtAoUdU
 Ku+ah8YmRJBxuy50l5UvBNwpPF0d0td0eUydQvlBXFkng/eLAdhPMY+yP5/JRyfj7UQQxHFZ9
 OhRpIso4TwuSKVbvlszF2dzILMnTI+SEHyGTmwFaPPj/6DImfs+kOZdPosnEjRVSR8TAnEDFR
 85LAvebiJ/EhDAOnoJ1vRfzBL6C+e0Sjj8NNf+sW1FUWB/JQxxlMpY+6NXrX4GEFBKYaJd6qb
 8SAIXMwjB412l2padBCh9g4B5pBTX5do9jOpdn5b6Y0jDz08EJGE2pX5wo35L6CC/4k0XZbrp
 v/sjgTn9YYe5AYbGOBdNGqlcucQYm4J9ZTsOOJL4hISMuAJM3hUs+Stj81xrBLcvd1uwcKlmh
 tvEauX3ey1pKyeKZHEtMB4HoRjZYlL1Ye5wrtKZrd5k7rlrWtdr0kHxMNXmgUWIFGo8g9/pUE
 syTLd0jFoFyWRmVapgaVKi3Q==

According to the dt-bindings there are some platforms, which have a
dedicated USB power domain for DWC2 IP core supply. If the power domain
is switched off during system suspend then all USB register will lose
their settings.

Use GUSBCFG_TOUTCAL as a canary to detect that the power domain has
been powered off during suspend. Since the GOTGCTL_CURMODE_HOST doesn't
match on all platform with the current mode, additionally backup
GINTSTS. This works reliable to decide which registers should be
restored.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
=2D--
 drivers/usb/dwc2/core.c     |  1 +
 drivers/usb/dwc2/core.h     |  2 ++
 drivers/usb/dwc2/platform.c | 38 +++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index 9919ab725d54..c3d24312db0f 100644
=2D-- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -43,6 +43,7 @@ int dwc2_backup_global_registers(struct dwc2_hsotg *hsot=
g)
 	/* Backup global regs */
 	gr =3D &hsotg->gr_backup;

+	gr->gintsts =3D dwc2_readl(hsotg, GINTSTS);
 	gr->gotgctl =3D dwc2_readl(hsotg, GOTGCTL);
 	gr->gintmsk =3D dwc2_readl(hsotg, GINTMSK);
 	gr->gahbcfg =3D dwc2_readl(hsotg, GAHBCFG);
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 265791fbe87f..34127b890b2a 100644
=2D-- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -667,6 +667,7 @@ struct dwc2_hw_params {
 /**
  * struct dwc2_gregs_backup - Holds global registers state before
  * entering partial power down
+ * @gintsts:		Backup of GINTSTS register
  * @gotgctl:		Backup of GOTGCTL register
  * @gintmsk:		Backup of GINTMSK register
  * @gahbcfg:		Backup of GAHBCFG register
@@ -683,6 +684,7 @@ struct dwc2_hw_params {
  * @valid:		True if registers values backuped.
  */
 struct dwc2_gregs_backup {
+	u32 gintsts;
 	u32 gotgctl;
 	u32 gintmsk;
 	u32 gahbcfg;
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index c1b7209b9483..4a3c81cd45d6 100644
=2D-- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -685,6 +685,14 @@ static int __maybe_unused dwc2_suspend(struct device =
*dev)
 		regulator_disable(dwc2->usb33d);
 	}

+	if (is_device_mode)
+		ret =3D dwc2_gadget_backup_critical_registers(dwc2);
+	else
+		ret =3D dwc2_host_backup_critical_registers(dwc2);
+
+	if (ret)
+		return ret;
+
 	if (dwc2->ll_hw_enabled &&
 	    (is_device_mode || dwc2_host_can_poweroff_phy(dwc2))) {
 		ret =3D __dwc2_lowlevel_hw_disable(dwc2);
@@ -694,6 +702,24 @@ static int __maybe_unused dwc2_suspend(struct device =
*dev)
 	return ret;
 }

+static int dwc2_restore_critical_registers(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_gregs_backup *gr;
+
+	gr =3D &hsotg->gr_backup;
+
+	if (!gr->valid) {
+		dev_err(hsotg->dev, "No valid register backup, failed to restore\n");
+		return -EINVAL;
+	}
+
+	if (gr->gintsts & GINTSTS_CURMODE_HOST)
+		return dwc2_host_restore_critical_registers(hsotg);
+
+	return dwc2_gadget_restore_critical_registers(hsotg, DWC2_RESTORE_DCTL |
+						      DWC2_RESTORE_DCFG);
+}
+
 static int __maybe_unused dwc2_resume(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 =3D dev_get_drvdata(dev);
@@ -706,6 +732,18 @@ static int __maybe_unused dwc2_resume(struct device *=
dev)
 	}
 	dwc2->phy_off_for_suspend =3D false;

+	/*
+	 * During suspend it's possible that the power domain for the
+	 * DWC2 controller is disabled and all register values get lost.
+	 * In case the GUSBCFG register is not initialized, it's clear the
+	 * registers must be restored.
+	 */
+	if (!(dwc2_readl(dwc2, GUSBCFG) & GUSBCFG_TOUTCAL_MASK)) {
+		ret =3D dwc2_restore_critical_registers(dwc2);
+		if (ret)
+			return ret;
+	}
+
 	if (dwc2->params.activate_stm_id_vb_detection) {
 		unsigned long flags;
 		u32 ggpio, gotgctl;
=2D-
2.34.1


