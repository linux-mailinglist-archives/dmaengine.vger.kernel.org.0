Return-Path: <dmaengine+bounces-3585-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871969B0050
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96521C21973
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7FB2003A6;
	Fri, 25 Oct 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="e8IfikFU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8781F80A3;
	Fri, 25 Oct 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852618; cv=none; b=hm+/lhls1r8WHjAGHc77+cPeoy9G/cP1lT05x+KXtueo7f2TdQpBeK0J7GuQf6qHxVe/W75BHtnC5tl+BRKliDPfOrHBy48hIxAWrGdHttOzxhvcbHrV4/non6fikvLHLymdcxaupWfeGwuTDY/cmc8aZbIiC0cXYRxuPaP9Yik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852618; c=relaxed/simple;
	bh=j30l09n0Udlcdy0qRhe+svmzEsdnvvcaYN/b2OU5rG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgxY91dP3gbFkh5dq1i1Xassk3Bh/FKlBdJsu/CHr9CSb6dV2hMLvVux/fJdsZndxB6VrufMjfr3ODsvQc+zfQZZccm6plxI/ySv68ZCkiF25jOAk28sOGDKlwJPISamUU5OY7vLuJx+WyBZ36b1BTYgtVFk64r13oukVn4c2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=e8IfikFU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852595; x=1730457395; i=wahrenst@gmx.net;
	bh=+xEThDmQ7pfAOY3UNaiZU7Wtb02xRWnrFRg9OV2hgNc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e8IfikFUhS00/cG5SnOefGqP+1oHgachGFHXZCEk3fQfAAmhDnsT53FC43XKyxky
	 Dkg/ie9jZvl2/QB4QHAIe9jDet9vmQax2KM0g+ldeMhJd3sSGRNrXViJZCiLE+oeu
	 O8hme0tIYznwg17eN7dd0dfRyl3rSuejAPUi5myLDCK4DsfeMhQPrx9b9b5w6Ztq9
	 kXBdq+5AS2wV+EOhtjobmyiiOqCWkaQSHBklAgPdBJ0wLjNK1IEZ5p0pyNQVfpwrX
	 slWiXOPWbcKBKugf8VsSEx6FjCvHZ9CMYyoNxpZCw3Nd82RN6hTycn8dv2eCAZRce
	 oI5Zoi5vSS7Q831CMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1tr0Ro0kL9-015MnT; Fri, 25
 Oct 2024 12:36:35 +0200
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
Subject: [PATCH V5 7/9] usb: dwc2: Refactor backup/restore of registers
Date: Fri, 25 Oct 2024 12:36:19 +0200
Message-Id: <20241025103621.4780-8-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:Vw1V1WhXww1QaWFXbTeKYFfUI/BMW4zYiGy6qP/5s4eBxfztFXN
 I83BsXlcuY5ZejevaPXKISRwV+FeiXIUdFDyTNuKVibJ/jkaOnL6yP/K+XR3pp4w4l8t0m3
 AInO05RSw0KiyVFVoJ7p2tdMvzdf9bcM5NyELjT9Excme57Cfdei7H1uJKN7mHLhgfgm0S8
 5g4ekT6PHs2242cC7V9XA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/1E7nH8sgTY=;xKIZoNotUSSgMFIK7WHZ/kejPvf
 wOynXlT1BmROyjRH1lp7ky8ZATjKndChoVmaZQ80nCDR/Sj9sBRn7s/lObBADkCaEL9QFd+1I
 yudfXlMKFxGjAHkVqWFlHBKTGvxiwMqC8MDIa9Y4iR7A2zBq9x+qtapndzwBv4NmCLJVV7/Qi
 Ke8/uqNPmnVyIYwePgpyBi3uBOnJKCTeFBSLNeCb/EVfzulaeXLRv8nkWi1qB84hE3sDAv5vL
 8hiruxOCh1DosZy9Cyx21ZrSXKlapljYgPrdM2R3fcHVK1MyMw0duOaoqTc//ksT4QAmuMjVA
 t5mrhOW/kslMKsnTVexzxH6VLeQ+PqbIR5V0FSe5v6mQOuQjU/eSXBkR9tqJmyxD/p1X9wKsl
 1Xs7Ju3jlPLq3yB6x5TdXIIVTWMbcsI+DwI0wQR9nBTobOlJS3SKFjj9Cud0sUUjpG4x3hWer
 LFoDH6EJAEFGjl2E9be8mRUaD4KW2FDpuWdDI8G0cVqF93kJRsW01sqZgDc8AlpLKGiA+cYoc
 uq3Zp4ftDWZ/qmwcTYc+xLnZJ/JxDZk8IY3MgZ2dnV22K287W+WvK83Fmvop0XdT3kwBXejWw
 TFfWWGRG/hJcUFpVVRNulNAocDNJhYSjIU9JEoWsIKoSH0IgiqI5FPNw8nJcUQkuZMWksaO9i
 62SVO9TLxCaSfr35HDTo7+LnaDX7XkLHqHxzeR8cTNTBjVd3akvq80tH3MC2i6X64qbfbPu1u
 JCa3Kt6Qm8TPompCknwOIewo8x0p7OeOHPfHDxVjG8OQd4jtxvEgMZcjV2QN85TFWPx5Y5Zoa
 3EnWXsxWZ27l0/pKsv277gxQ==

The DWC2 runtime PM code reuses similar patterns to backup and
restore the registers. So consolidate them in USB mode specific
variants. This also has the advantage it is reusable for further
PM improvements.

Special care is taken for DCFG register during device mode restore.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/usb/dwc2/core.h   |  15 ++++++
 drivers/usb/dwc2/gadget.c | 108 +++++++++++++++++++-------------------
 drivers/usb/dwc2/hcd.c    |  99 +++++++++++++++++-----------------
 3 files changed, 121 insertions(+), 101 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 48f4b639ca2f..265791fbe87f 100644
=2D-- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1128,6 +1128,7 @@ struct dwc2_hsotg {
 #define DWC2_HS_IOT_ID		0x55320000

 #define DWC2_RESTORE_DCTL BIT(0)
+#define DWC2_RESTORE_DCFG BIT(1)

 #if IS_ENABLED(CONFIG_USB_DWC2_HOST) || IS_ENABLED(CONFIG_USB_DWC2_DUAL_R=
OLE)
 	union dwc2_hcd_internal_flags {
@@ -1437,6 +1438,9 @@ int dwc2_hsotg_tx_fifo_total_depth(struct dwc2_hsotg=
 *hsotg);
 int dwc2_hsotg_tx_fifo_average_depth(struct dwc2_hsotg *hsotg);
 void dwc2_gadget_init_lpm(struct dwc2_hsotg *hsotg);
 void dwc2_gadget_program_ref_clk(struct dwc2_hsotg *hsotg);
+int dwc2_gadget_backup_critical_registers(struct dwc2_hsotg *hsotg);
+int dwc2_gadget_restore_critical_registers(struct dwc2_hsotg *hsotg,
+					   unsigned int flags);
 static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg)
 { hsotg->fifo_map =3D 0; }
 #else
@@ -1484,6 +1488,11 @@ static inline int dwc2_hsotg_tx_fifo_average_depth(=
struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline void dwc2_gadget_init_lpm(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_gadget_program_ref_clk(struct dwc2_hsotg *hsotg) =
{}
+static inline int dwc2_gadget_backup_critical_registers(struct dwc2_hsotg=
 *hsotg)
+{ return 0; }
+static inline int dwc2_gadget_restore_critical_registers(struct dwc2_hsot=
g *hsotg,
+							 unsigned int flags)
+{ return 0; }
 static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg) {}
 #endif

@@ -1507,6 +1516,8 @@ int dwc2_host_exit_partial_power_down(struct dwc2_hs=
otg *hsotg,
 void dwc2_host_enter_clock_gating(struct dwc2_hsotg *hsotg);
 void dwc2_host_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup=
);
 bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2);
+int dwc2_host_backup_critical_registers(struct dwc2_hsotg *hsotg);
+int dwc2_host_restore_critical_registers(struct dwc2_hsotg *hsotg);
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg)
 { schedule_work(&hsotg->phy_reset_work); }
 #else
@@ -1546,6 +1557,10 @@ static inline void dwc2_host_exit_clock_gating(stru=
ct dwc2_hsotg *hsotg,
 					       int rem_wakeup) {}
 static inline bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2)
 { return false; }
+static inline int dwc2_host_backup_critical_registers(struct dwc2_hsotg *=
hsotg)
+{ return 0; }
+static inline int dwc2_host_restore_critical_registers(struct dwc2_hsotg =
*hsotg)
+{ return 0; }
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg)=
 {}

 #endif
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 96d703f4c509..2e071a0342f8 100644
=2D-- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5223,6 +5223,9 @@ int dwc2_restore_device_registers(struct dwc2_hsotg =
*hsotg, unsigned int flags)
 	}
 	dr->valid =3D false;

+	if (flags & DWC2_RESTORE_DCFG)
+		dwc2_writel(hsotg, dr->dcfg, DCFG);
+
 	if (flags & DWC2_RESTORE_DCTL)
 		dwc2_writel(hsotg, dr->dctl, DCTL);

@@ -5309,6 +5312,49 @@ void dwc2_gadget_program_ref_clk(struct dwc2_hsotg =
*hsotg)
 	dev_dbg(hsotg->dev, "GREFCLK=3D0x%08x\n", dwc2_readl(hsotg, GREFCLK));
 }

+int dwc2_gadget_backup_critical_registers(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	/* Backup all registers */
+	ret =3D dwc2_backup_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
+			__func__);
+		return ret;
+	}
+
+	ret =3D dwc2_backup_device_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+int dwc2_gadget_restore_critical_registers(struct dwc2_hsotg *hsotg,
+					   unsigned int flags)
+{
+	int ret;
+
+	ret =3D dwc2_restore_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to restore registers\n",
+			__func__);
+		return ret;
+	}
+	ret =3D dwc2_restore_device_registers(hsotg, flags);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to restore device registers\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * dwc2_gadget_enter_hibernation() - Put controller in Hibernation.
  *
@@ -5326,18 +5372,9 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg=
 *hsotg)
 	/* Change to L2(suspend) state */
 	hsotg->lx_state =3D DWC2_L2;
 	dev_dbg(hsotg->dev, "Start of hibernation completed\n");
-	ret =3D dwc2_backup_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
-			__func__);
-		return ret;
-	}
-	ret =3D dwc2_backup_device_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
-			__func__);
+	ret =3D dwc2_gadget_backup_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}

 	gpwrdn =3D GPWRDN_PWRDNRSTN;
 	udelay(10);
@@ -5485,20 +5522,9 @@ int dwc2_gadget_exit_hibernation(struct dwc2_hsotg =
*hsotg,
 	dwc2_writel(hsotg, 0xffffffff, GINTSTS);

 	/* Restore global registers */
-	ret =3D dwc2_restore_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to restore registers\n",
-			__func__);
-		return ret;
-	}
-
-	/* Restore device registers */
-	ret =3D dwc2_restore_device_registers(hsotg, flags);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to restore device registers\n",
-			__func__);
+	ret =3D dwc2_gadget_restore_critical_registers(hsotg, flags);
+	if (ret)
 		return ret;
-	}

 	if (rem_wakeup) {
 		mdelay(10);
@@ -5532,19 +5558,9 @@ int dwc2_gadget_enter_partial_power_down(struct dwc=
2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "Entering device partial power down started.\n");

 	/* Backup all registers */
-	ret =3D dwc2_backup_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
-			__func__);
-		return ret;
-	}
-
-	ret =3D dwc2_backup_device_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
-			__func__);
+	ret =3D dwc2_gadget_backup_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}

 	/*
 	 * Clear any pending interrupts since dwc2 will not be able to
@@ -5591,11 +5607,8 @@ int dwc2_gadget_exit_partial_power_down(struct dwc2=
_hsotg *hsotg,
 {
 	u32 pcgcctl;
 	u32 dctl;
-	struct dwc2_dregs_backup *dr;
 	int ret =3D 0;

-	dr =3D &hsotg->dr_backup;
-
 	dev_dbg(hsotg->dev, "Exiting device partial Power Down started.\n");

 	pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
@@ -5612,21 +5625,10 @@ int dwc2_gadget_exit_partial_power_down(struct dwc=
2_hsotg *hsotg,

 	udelay(100);
 	if (restore) {
-		ret =3D dwc2_restore_global_registers(hsotg);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to restore registers\n",
-				__func__);
-			return ret;
-		}
-		/* Restore DCFG */
-		dwc2_writel(hsotg, dr->dcfg, DCFG);
-
-		ret =3D dwc2_restore_device_registers(hsotg, DWC2_RESTORE_DCTL);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to restore device registers\n",
-				__func__);
+		ret =3D dwc2_gadget_restore_critical_registers(hsotg, DWC2_RESTORE_DCTL=
 |
+							     DWC2_RESTORE_DCFG);
+		if (ret)
 			return ret;
-		}
 	}

 	/* Set the Power-On Programming done bit */
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cb54390e7de4..32fa606e5d59 100644
=2D-- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5477,6 +5477,49 @@ int dwc2_restore_host_registers(struct dwc2_hsotg *=
hsotg)
 	return 0;
 }

+int dwc2_host_backup_critical_registers(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	/* Backup all registers */
+	ret =3D dwc2_backup_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
+			__func__);
+		return ret;
+	}
+
+	ret =3D dwc2_backup_host_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup host registers\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+int dwc2_host_restore_critical_registers(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	ret =3D dwc2_restore_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to restore registers\n",
+			__func__);
+		return ret;
+	}
+
+	ret =3D dwc2_restore_host_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to restore host registers\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * dwc2_host_enter_hibernation() - Put controller in Hibernation.
  *
@@ -5492,18 +5535,9 @@ int dwc2_host_enter_hibernation(struct dwc2_hsotg *=
hsotg)
 	u32 gpwrdn;

 	dev_dbg(hsotg->dev, "Preparing host for hibernation\n");
-	ret =3D dwc2_backup_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
-			__func__);
-		return ret;
-	}
-	ret =3D dwc2_backup_host_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup host registers\n",
-			__func__);
+	ret =3D dwc2_host_backup_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}

 	/* Enter USB Suspend Mode */
 	hprt0 =3D dwc2_readl(hsotg, HPRT0);
@@ -5697,20 +5731,9 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *h=
sotg, int rem_wakeup,
 	dwc2_writel(hsotg, 0xffffffff, GINTSTS);

 	/* Restore global registers */
-	ret =3D dwc2_restore_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to restore registers\n",
-			__func__);
+	ret =3D dwc2_host_restore_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}
-
-	/* Restore host registers */
-	ret =3D dwc2_restore_host_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to restore host registers\n",
-			__func__);
-		return ret;
-	}

 	if (rem_wakeup) {
 		dwc2_hcd_rem_wakeup(hsotg);
@@ -5777,19 +5800,9 @@ int dwc2_host_enter_partial_power_down(struct dwc2_=
hsotg *hsotg)
 		dev_warn(hsotg->dev, "Suspend wasn't generated\n");

 	/* Backup all registers */
-	ret =3D dwc2_backup_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
-			__func__);
-		return ret;
-	}
-
-	ret =3D dwc2_backup_host_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup host registers\n",
-			__func__);
+	ret =3D dwc2_host_backup_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}

 	/*
 	 * Clear any pending interrupts since dwc2 will not be able to
@@ -5858,19 +5871,9 @@ int dwc2_host_exit_partial_power_down(struct dwc2_h=
sotg *hsotg,

 	udelay(100);
 	if (restore) {
-		ret =3D dwc2_restore_global_registers(hsotg);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to restore registers\n",
-				__func__);
-			return ret;
-		}
-
-		ret =3D dwc2_restore_host_registers(hsotg);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to restore host registers\n",
-				__func__);
+		ret =3D dwc2_host_restore_critical_registers(hsotg);
+		if (ret)
 			return ret;
-		}
 	}

 	/* Drive resume signaling and exit suspend mode on the port. */
=2D-
2.34.1


