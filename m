Return-Path: <dmaengine+bounces-3584-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1679B004F
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBBAB2422D
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AA21FF7B5;
	Fri, 25 Oct 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="PRWTmLP/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5765F1F818E;
	Fri, 25 Oct 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852617; cv=none; b=MkS8NnWA3ks2Mgoset42u9DIOxe0ntkBJNVBD/mIYPqi2b2s/sLyPfyYNMwv8pemhSP25kCy8dZY+DauabcUvbnsIAr65rwu6jEwZFhTZZvkArjry19vXnSz5HWX6AWaKtN/6Kis+fT3Ov3bQeBfv93jovYfUywkT9smL8JQPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852617; c=relaxed/simple;
	bh=NLJhKND256gSjgqz5+jXNVwCkHAy7Lhhbara7R1G0Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U58qQeZcJbj77YK0SMMFPBD2iush7t+y19jAZBGJNZiNGoRjamiWkx0fWjFcpy+O58dZPri2Gf1eO0fWWDtykoj4tx2NNvhAAW2rjFVEl+ENoSBKsMLKGDstLYglSo1i631u3qiZ+frqTQ0Cg8cVnhuMEh8Lkd70eDF2pqPgkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=PRWTmLP/; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852594; x=1730457394; i=wahrenst@gmx.net;
	bh=JRrp6JLKk7ZewfhLxhmIMUVWuQ9FaYJ7taL+ewhOlow=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PRWTmLP/VQd2nMDt66hlDPjNqXP89Hcf5M/7j9H7cztnwzZ2J9RAouh9MIeiWOgl
	 0I0/usUQynrFmaiS4Np/yqIUCbPS+n2evAAL6LigwHsnG6WBMekVC3KksmHi3ksn0
	 iZ4HEIyM9SGFugULHMfPdTAVBSlWETVtlsMuil9xLB2XEeu2izkQe9eHzqcTBHANb
	 RNjLdaQlvrS8jJSMKWGCKjQupE377g29r/iVvZ5snzY8pfdLfXy6aM1ljNd6t241p
	 I7rGYDNeRl38AihGCTDoZmHAwKQVLvb0cYeGkP15oVhclq89ejDZM5rIT8IpDr1k8
	 esuG4Zbk6qqYKdfyiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1ttVQS2KAY-013Pmc; Fri, 25
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
Subject: [PATCH V5 6/9] usb: dwc2: gadget: Introduce register restore flags
Date: Fri, 25 Oct 2024 12:36:18 +0200
Message-Id: <20241025103621.4780-7-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:3avDBliNzEcs6oIpGJspN+k6fohsov4qbRg5nvIJUrLCIkRywmC
 tEjSG84jBaok3RUL3gQ52nwfQ1M9XkDRdHYWies0VYpsfgFJY+ug0VpCBTgV5zi7pbY2ZsI
 5rQBl4liK/dzR37yNLq4h/sRTBcdK8BNODu9DAAD51YZN2p0DcV+Js26dwUvUdLUe+6l2Xu
 8xlkKrPRy1vzXhURYLtmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UbcCWlK87hM=;HWroYRHXLl0YxR8ty4UfDJedLR7
 3OcFP764Y9yum+aPsS9Mbm1IBAkw1LGCM3n94FSWmPs8CySQKaqCZi+4H34zGTMTFCmrAEZVZ
 hv2bRhSnpzsZBwvk9Z1+I28tntAMQirczyW7WORergEaQkiOuBWr8iH6tUY+yX4aWLK+ER6H4
 Tq5K3NV9mREfUbqX+haC+QvOnmcD8j2ZHqQ6oOpeHoyTfpKkf6Ps58aDw10SkZ5OJY33xym3b
 KHA+8ItCnme0tnXwLxBUJf8+gDJt+RuRqKzaPkQ072a/8+ze4bdcm4U+nkJd6IoP9XydcDwB6
 4GaV/9eRLAvsUTbph3F9h/aRZlyzuqlU7IeLC1seSg3YG0CkDqQ/0IVORCG30GoesnJ19WJsu
 XPInytJSHa0wJt//O1aEkYRBKmOuI9TDI13l8rggQgA6wZYIFWLX/qCsxpmG33SOjaIbRkScM
 r6dsOvcFwYJRFWjxFSHkO/E5opJiMW38M/1P3LJdmusGP7g/QW9+5cAKajjEVws/PvZw9t/xk
 nYfvOXEzNExZWG7vF1471SLW5gL9rGc9lwdZsAqSbWLOf4uLjpSkMdbqPQzhkIXHeQORzpKBm
 pnWKEqCSBbkGeslUWBt8XaCFPBpWs0YtEWN+I5yQPmcbjMo+XT1NkwaanbwwAeB37Ce2ApYIv
 DtzaFimg9Ou0XH3jtV1XxeWwLgF4N4M/esDVkRjdJVIq/HqYV4PSSKn8IvdCA2GD4BM8bJOBZ
 m2mHTrDRZS7B0oW+nJ2RTWQYDCmhObiwkFaECY18pX0q/6rRI9egfz/r7Dk5K2V/88AEzDjZj
 iz0g9+/FZyakyKcIMLAZNKAQ==

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


