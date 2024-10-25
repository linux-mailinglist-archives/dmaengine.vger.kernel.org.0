Return-Path: <dmaengine+bounces-3581-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0679B0043
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE92528340C
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AF41FA259;
	Fri, 25 Oct 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ECiSl6oo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF231DE3A7;
	Fri, 25 Oct 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852616; cv=none; b=QwxNPqOl3LT1vLbectHxqN0FvFzjp3xO5WT2D8/5zFc2wEHSElSO2bcw0hrNW2urosK0s211j6aoGTGW5xHLfIrJEan4AEFdo+qmeKPcebcvjuIZjM4XjF8QV0Zy8CPsDJ6cwY34q+2YSEc2r91jmhvkjhnrLVFaMJkmpvTgWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852616; c=relaxed/simple;
	bh=Dnh9zA68cmn86JxmjQWm3VeD9mYPGUG2L6WhqKPqrUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RpX6vsvxsKYKsmc8ktedO9pRa6K5yY8C8bIQjmStWu5BPcqYqI5WSppLYX3D3hHN/TYC36xZDoSIipzXAMo52fbzzmUOIDtHyJbHGPQm9PQJMnn2EVEnIdKIp5ZJijILvD702NiaH2IJCP8e15oD4wqlmgrnVY2/0ysUlAOKrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ECiSl6oo; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852596; x=1730457396; i=wahrenst@gmx.net;
	bh=09r8SsGNZ34ZiyCPE+YPDY1tjwAlvhjANIoGjogob0I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ECiSl6ooctwk0v6aDqAO5MXTpskQlO6ki24e5NxKwOw/JTL2w/sksOzf2xKxpPoh
	 RbXhI490NANYGxgVzEyJhv7hCT1L0/EN7jaaeeYiQsQq70+tArhT4ojiIcRYItQBW
	 T1aRUWMjSc/0RSMHGPT0A2NeDgGIDzXvoXRfeq2i57byutRb2b9Jj9OGmNYSman8b
	 wcFMA250lwRytgNOAF/y0wPYd3BPSkb5WmfZqOm7MdUfn5WKcS84QdUn6CWtEGVHz
	 bsEfPa05yugrJme3SE5fsvUGz2+aadGfzzmXaWEKoHFRKEdqa6w5+/0pRlb/AMq9A
	 oBA+kXhFAuV2GzjjRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1u0twG3hDn-00tCdT; Fri, 25
 Oct 2024 12:36:36 +0200
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
	Stefan Wahren <wahrenst@gmx.net>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH V5 8/9] usb: dwc2: Implement recovery after PM domain off
Date: Fri, 25 Oct 2024 12:36:20 +0200
Message-Id: <20241025103621.4780-9-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:0DHeVITrWMY0vQ2rx2e0e4B9KfArVPTafQp1rYxE/73DMjVjSV5
 xHBqz3tEPRtHyaXxyscUt/UgcM0ONCSNYzdhfH7pZ8qBt7H9cMM+MsT4qIIfQXrs4m/jAYQ
 x+Q3AUP4LR4FBWHoUvQLiOWCYxhW/qO82B6V3tn/L+UiojQDRq1iDfqqoul4OZJZsxIvupr
 p78tzIJIfCpn6BRTY6chw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zomxAVLVd9U=;XjqOY2BCkTudZjgYhWCHiU5l7cf
 UNVhAVItObGLY7r30VboevP7zZ8XoUQcxHKprH4xN/Teqek1OqWdEHsXFkA6Lu8dam6N2uQ85
 7dV2YGVALPaosxazJDCOl9lNa4xISd4KrEskqvW88sytwOpbsVhrK2DtoRZCcQzuKcQQICbTi
 JO2Nkm5E4QiCJFQbukl95fO+74nywsxWYe7+NeGQcTHzdYA/bai7u2zvysaavqQevMAhV7ir4
 jmaBUQ18hlvOE1T1Uf/8ohPb8tCymeE4AmL+YStrShqZ3Q4JI+cws+i6Ozbj+Y/Aj9K/qEuM/
 HFCAi6GlcTy99cJaW7+lN+lwPdNz+aWynN6dQNWphi5c3qgDJdiOp/C4R9KScLxE+OLOVKJ2G
 0THbnPfXdVs1yDUI3qFM/LKM0m4teS1fxrA9j3T6hIg9wZzmei8+suv3Z2q03YQPXnCBCBOYu
 mAQZV+zs3a2iZ+kCkVqBBja/4rnBAwYKlhqSFJzBo6Kv+rm/oG+bac7r6OW66GHhMQqufG055
 WYW3pnpC6W2tjUPeSPMGQlD4LLBwZB02iqjLjZvZRUAy0zcZXd4l3Zr3LtnZqJTq8VGubD5QQ
 tPDeYzZZt/420uiJJUp7HfCheBdDWh9sqTdaLPJwYbPegg4kX70nczKEolTUvqrpXfUUTFAk6
 lBC6Br1tgOQ+NKHns21AfXfTtcghLGeZKEKO8GnNJLSr/ac1mzW1+gi5oG7OwaCQ0tmeNYKW3
 DAY95KzW5kxYE+7MAR3wlyu+HiYUWHj3UzdA+UwRBt1Uoe1XIHkkCz06/Iq+/IJL1jTx3e74Y
 DU+V3/MXTQ8RoaMRz5PWzBMg==

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


