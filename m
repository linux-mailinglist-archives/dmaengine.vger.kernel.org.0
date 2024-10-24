Return-Path: <dmaengine+bounces-3557-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F99AF387
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0971EB22B4F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA621733C;
	Thu, 24 Oct 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ph1S/yzx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F2200BB6;
	Thu, 24 Oct 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801150; cv=none; b=ls0tQyb9UdGwPNBrNCrgCtHNf7o7KS6tTniDik0QY+E0YZt6OYHWbeLSFjVr3yYlR8hiE4Q/mpMahQ+q+Tro5/D85uZpGCX7L1+9dZrMuRgtW6eSrFEhSAkHfutBp2S9O66K/k9MTgiqhs5oKsSPN0zJL5VGSiv0g3hz8L3JQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801150; c=relaxed/simple;
	bh=NLJhKND256gSjgqz5+jXNVwCkHAy7Lhhbara7R1G0Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNm+mXYuGXFjLwPYC1zaiqCF7P7mh+7aGeFoss67T1wvATM+4jhTC6MJ1rUAEzVl19Io77KrU+wd5fbVOMPiPTRYyC/qLH+fy1+almNyTT32I0bTFytxp18bY65dD1PnF/ezlHVbUx8GJwzCcn6E9DkvxutG0CgjOfAIzkEEINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ph1S/yzx; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729801127; x=1730405927; i=wahrenst@gmx.net;
	bh=JRrp6JLKk7ZewfhLxhmIMUVWuQ9FaYJ7taL+ewhOlow=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ph1S/yzxaSFMuUMjJULTbbm+fsL+wECSBxU56vEZvnETgFB+vq+2R0WCmBVU8Yi6
	 k6zzyp950Q+YXdcOLDZ5VoszNaOFSBPQgkcUaeaKbQiY6XWlG4B94CMNRbCGv1RAi
	 IUBW3HrVGrtPWUb+UYTnTgNaue6GBkjgfoBIQO0hq66zb9t7TDyfFq6yMWarqHEG6
	 U/gtNnWNQNRIhu/xt0CB03HB1YY4lonltbw2f1lsYTmLjLpL8S08b8FuHo1nRMQg8
	 KaB6oYgyzphWEplATpMD8LM4cJrNKVlCLD1N2ukly5CA1Og9i2nDOnZWSnFf3VIl1
	 bKRykL/6LjR6SvE1vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1tkmxX2UY8-00mTVU; Thu, 24
 Oct 2024 22:18:47 +0200
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
Subject: [PATCH 6/9] usb: dwc2: gadget: Introduce register restore flags
Date: Thu, 24 Oct 2024 22:18:34 +0200
Message-Id: <20241024201837.79927-7-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:CqgYeeZNUwYzTJ4GE0juj9SGPyyOYxIPFyKOUz1FCHoELlxSPBO
 uCLm65+qf767P9c8nkrvo5VhNJ7oPFi4WFKbWl3AseMCGXpBsR/KLyp1MCdLM+nMMpNRV9T
 /pnK0vR8LoRYHBV2HlLfMXf+44c7VWxKOP19k6KPCJG3KnWLT1eF+bRkJMlQYx3ZO3OC3BV
 mioA28LqtZbvj1VyXmTZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hZar9UeG20M=;j9ZFZy0OgPtqao0NNzl58dNPiZt
 EpetYR4ISrhIiTBcgszQxelh4/1CiqikfvXspNioGdzClbIku0Ca1slnzFl7p4gMzTnZzyGXD
 WspSwVPO2xQq13VhQorPUu2G0Ugx3T720iQsHjk96uMR5O1EDfZurG0DpLGPIrSV2A30r8gw5
 KnYXZsm/siTlVMeAapnw3wCinkgXGrFs38airnjTltCGbjOvTXdLNla3j5TR+ASk+biUDEfUB
 y9hsFE/rFoYqVAqZv+dRHaIXzr6wv0nR51lzYvIUkcCl2+zZ7aDSTLHaHKi/hnua5R63omMbR
 wVZsWXvBxvUAKlgnHufIXU13+aRm9Z+oeB140OsochtcJsuY6NpQOMBnJJV04lT7JhIVXCnUE
 saiVnVyWl77MWY5cLDLJduPA3uKZ4A4lF3FcInPJV6H2sc4GPk4+DvJ/TFmiAH0KkHPAourcH
 gl0Sw2LjYjWR2uSuwJeIeIoU2jdNyhiSRa3DtW94Eh4/i0M5gF4RZgCfrOdcyrOtk90rIIrbd
 31oWHzbscthVEFo3TT+RhKrXo8P6lT4Kl8Rle7kHIr8k66brM+Y2+fLHji/B6gh9/1379BRhZ
 CjIkp2jrIIbfBUSmHP7DoMCFWGmrTto/1iUonxGlDoZaqOnh50mVEt079FecoxfDzfxymvJyW
 HA28UYhsdQb9Y8xkyxblKuwSvMjirFIcPfwrFJ0wW81KGjNiedDQ8D1bguartUg84+eHpIFQQ
 6SkHFnL0XQrTcQA9UTnVr/0gYOSrYvQAWzQngQhZ8zsaW7uJsSc5PcGEh3sXakkdNH0G4GDHj
 g3gsx4tQHeVpU1JuMO6gSz/Q==

dwc2_restore_device_registers() use a single boolean
to decide about the register restoring behavior.
So replace this with a flags parameter, which can
be extended later.

No functional change intended.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/usb/dwc2/core.h   |  6 ++++--
 drivers/usb/dwc2/gadget.c | 12 +++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 2bd74f3033ed..48f4b639ca2f 100644
=2D-- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1127,6 +1127,8 @@ struct dwc2_hsotg {
 #define DWC2_FS_IOT_ID		0x55310000
 #define DWC2_HS_IOT_ID		0x55320000

+#define DWC2_RESTORE_DCTL BIT(0)
+
 #if IS_ENABLED(CONFIG_USB_DWC2_HOST) || IS_ENABLED(CONFIG_USB_DWC2_DUAL_R=
OLE)
 	union dwc2_hcd_internal_flags {
 		u32 d32;
@@ -1420,7 +1422,7 @@ int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsot=
g, int testmode);
 #define dwc2_is_device_connected(hsotg) (hsotg->connected)
 #define dwc2_is_device_enabled(hsotg) (hsotg->enabled)
 int dwc2_backup_device_registers(struct dwc2_hsotg *hsotg);
-int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg, int remote_wa=
keup);
+int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg, unsigned int =
flags);
 int dwc2_gadget_enter_hibernation(struct dwc2_hsotg *hsotg);
 int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *hsotg,
 				 int rem_wakeup, int reset);
@@ -1459,7 +1461,7 @@ static inline int dwc2_hsotg_set_test_mode(struct dw=
c2_hsotg *hsotg,
 static inline int dwc2_backup_device_registers(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg,
-						int remote_wakeup)
+						unsigned int flags)
 { return 0; }
 static inline int dwc2_gadget_enter_hibernation(struct dwc2_hsotg *hsotg)
 { return 0; }
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index e7bf9cc635be..96d703f4c509 100644
=2D-- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5203,11 +5203,11 @@ int dwc2_backup_device_registers(struct dwc2_hsotg=
 *hsotg)
  * if controller power were disabled.
  *
  * @hsotg: Programming view of the DWC_otg controller
- * @remote_wakeup: Indicates whether resume is initiated by Device or Hos=
t.
+ * @flags: Defines which registers should be restored.
  *
  * Return: 0 if successful, negative error code otherwise
  */
-int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg, int remote_wa=
keup)
+int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg, unsigned int =
flags)
 {
 	struct dwc2_dregs_backup *dr;
 	int i;
@@ -5223,7 +5223,7 @@ int dwc2_restore_device_registers(struct dwc2_hsotg =
*hsotg, int remote_wakeup)
 	}
 	dr->valid =3D false;

-	if (!remote_wakeup)
+	if (flags & DWC2_RESTORE_DCTL)
 		dwc2_writel(hsotg, dr->dctl, DCTL);

 	dwc2_writel(hsotg, dr->daintmsk, DAINTMSK);
@@ -5414,6 +5414,7 @@ int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *=
hsotg,
 	u32 gpwrdn;
 	u32 dctl;
 	int ret =3D 0;
+	unsigned int flags =3D 0;
 	struct dwc2_gregs_backup *gr;
 	struct dwc2_dregs_backup *dr;

@@ -5476,6 +5477,7 @@ int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *=
hsotg,
 		dctl =3D dwc2_readl(hsotg, DCTL);
 		dctl |=3D DCTL_PWRONPRGDONE;
 		dwc2_writel(hsotg, dctl, DCTL);
+		flags |=3D DWC2_RESTORE_DCTL;
 	}
 	/* Wait for interrupts which must be cleared */
 	mdelay(2);
@@ -5491,7 +5493,7 @@ int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *=
hsotg,
 	}

 	/* Restore device registers */
-	ret =3D dwc2_restore_device_registers(hsotg, rem_wakeup);
+	ret =3D dwc2_restore_device_registers(hsotg, flags);
 	if (ret) {
 		dev_err(hsotg->dev, "%s: failed to restore device registers\n",
 			__func__);
@@ -5619,7 +5621,7 @@ int dwc2_gadget_exit_partial_power_down(struct dwc2_=
hsotg *hsotg,
 		/* Restore DCFG */
 		dwc2_writel(hsotg, dr->dcfg, DCFG);

-		ret =3D dwc2_restore_device_registers(hsotg, 0);
+		ret =3D dwc2_restore_device_registers(hsotg, DWC2_RESTORE_DCTL);
 		if (ret) {
 			dev_err(hsotg->dev, "%s: failed to restore device registers\n",
 				__func__);
=2D-
2.34.1


