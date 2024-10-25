Return-Path: <dmaengine+bounces-3580-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683EE9B0042
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E93283726
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B6E1F9ECE;
	Fri, 25 Oct 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="f/UQqyZ4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EA1DAC90;
	Fri, 25 Oct 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852616; cv=none; b=XUTJ3MX6byr8YYHa4STSsPxTyJRJRuE5KMOGwqYng9F/17/6EOwqxL0TUChMIzc2sWUaoqQEkSA91CUt5MVJ15G2NiqHyvNGfr8fXd/MsRbx6J/qQ0i66ItjL4uU7DVQovWNZei67ib173Y4cANtqsP3ECNxObkfDMjWZ8bo0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852616; c=relaxed/simple;
	bh=FtB7n0flVWbqHTdJaCNsHoIjLctGLxMpTmctKJudKjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=vASIilcrvgklwYrtMmsVgkT1aTzD1iN7b4/j0PtV7eC+Q9sejvNiEtlnnZ3HdjUpeTOzhi+eeagj5JwHCCQ3ZIWbjlFYU9xK0hffZSgy2BwtpI4DodgNa2VH9iiWpPxvHDhzXvkjS8p4N328wal9KbCBL4g54jSSSZFvY9e7xXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=f/UQqyZ4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852590; x=1730457390; i=wahrenst@gmx.net;
	bh=amPxo4S/Ct/6DZ6qNnunsTkfju7K6NksorlhbkGz9ag=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f/UQqyZ4mjQbV2oTHIfFNGbpx6DpsGNwE5Se8hUr1xjClFuijI+vjrcPgxgifKM3
	 tL37avOynFlBr/67wsNzxHq8G4o8lnTko8fGZOK6iY1e9CYg9+jDVVel5pdqER1o1
	 yfCxR8Y3VOCAMWw1xIBxbsk5H8jjcmyEG9ugP/tQS56eOseZBmcRyGTAP+h6lkH5j
	 eaokLVaPqfPf/WAYgtRxrnSZyZr5HK4HRU2Lh7CzXMrM4VVhnvofRrJIzpJZzflY5
	 ZlJ4IL9AxAwl/MERS/ZWLsCBlP1vX0ex1jRWN9PcYfQsw4WHt4j7YjslSDlOmxWKo
	 RtQnRwFTHkgmYq9gKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1tKzcL0mdH-00QVjT; Fri, 25
 Oct 2024 12:36:30 +0200
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
Subject: [PATCH V5 0/9] ARM: bcm2835: Implement initial S2Idle for Raspberry Pi
Date: Fri, 25 Oct 2024 12:36:12 +0200
Message-Id: <20241025103621.4780-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zXzoaq0PE3RrmfyCowWNAEhGtFClTAK4tiZAejmiOdXy3277ZNd
 Piu95Otg3VHC+6HYkERem6L66YN8oOa9djCGQPMnF66Be/6Bms3HBLHdl0Ykje/EaLekqDX
 cmGLfZHU2uZLY8x6XODCKyai9avTy/D38u3/fdcQmXsHnjyB/UtoIp554rtr4px7hhDBnOE
 H7QdjCbcBAJW92TWec69w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k6GJJeBJmOY=;pItoyKMWfDCZsYsxiT9g//rs8PL
 QSE3/8vwwx/CfEZPQ+xzai6MvUSx/zMYOOa9jcbblqRPTs5jBophaDCtgz3SRIAIzfT3V+JmW
 lKm42XYsvFdQkYJOPNYz+ARaIsgCo27L/DogxC8k9Ynux7hakEfkiyZbqcAYACO4e2SqwdESm
 HFQF6ZtBUENCBVEzNYn3mDJlahTN97/xdr8DJo4dNWcs/p7nwdRDsjlpbUdXbpcqtN37Us35s
 ZyF7f76hUU3AmTk6aPRuG4OOOXd5kGcAQSo169Z5j1MsggTODNgYUpDDiQS49MeNO/oCmthx9
 +z/gQTlx/SRcwiCd0v0qArkgLAfFUplX8Ub51n/JStGPIWblZa5XMPs5XjJnhEQBAV7AzkXbJ
 icuOjuE8QMmfE+06WVvCcCyW9vigdiS/4ckzFCj386ByKcJvmbW8/OBV+GiT/7sZITJBA5nuU
 5eUWvqPgu/r9ZYMO86c3qqgmOTN14hjAyeBzm5IPCQ0DVOq3RiJtjLpk8Kl7o1oyV3jy0fJHb
 M4erRwfuAegSKafvGL7puyRzh+wwemwxIk+dDIKHtrDdUZFpS2CFvHHOvXdN4ST9JV8rRO6sB
 0mQ4SAjmIbL9C5cWTu9lBKOUkz3Zzz5CItoaJdT/dCN4+f3j5y3anB+KWGr1bnNdMZP0Ipzbj
 8Tg3/bBi7tSfcDC0TA87hrIIo90FXkGEsJn7OyNlPCg7Z2wDztqw2A6LuLL6uiM+/VU2rg5og
 YeXFwKrD11yNS/9w/uvqXHLCOPqKPSLF727cdUfZf64uroQ1PWhx8oPyw1QzZtGk4pPbCfl4l
 8WjkZusJggqEnptFsVrS7ZXniMgTN1oo0Dh49nHw1+4U8=

This series implement the initial S2Idle support for
the Raspberry Pi, which was a long time on my TODO list [1]. The
changes allow to suspend and resume the Raspberry Pi via debug UART.
The focus is on the BCM2835 SoC, because it's less complex than its
successors and have enough documentation.

Now the VC4 part has been split from the series [4], because of some issue=
s
in that part.

Cherry-picking of patches should be fine.

Test steps:
- configure debug console (pl011 or mini UART) as wakeup source
- send system to idle state

  echo freeze > /sys/power/state

- wakeup system by console traffic

The clock gating must be restored, because otherwise we have a
regression on Raspberry Pi 3 B+ . Luckily the disabling of clock gating
isn't necessary anymore. Thanks to the rest of the DWC2 patches which
based on an idea of Doug Anderson. The USB domain is now powered down
and the USB devices are still usable after resume. There might be room
for improvements, but at least the system won't freeze forever as before.

Here are some figures for the Raspberry Pi 1 (without any
devices connected except of a debug UART):

running but CPU idle =3D 1.67 W
S2Idle               =3D 1.33 W

In comparison with HDMI & USB keyboard connected (but neither active
nor wakeup source):

running but CPU idle =3D 1.82 W
S2Idle               =3D 1.33 W

The series has been successfully tested on the following platforms:
Raspberry Pi 1 B
Raspberry Pi 3 B+

Changes in V5:
- add missing version

Changes in V4:
- added Reviewed-by from Doug
- dropped applied VC4 improvement patches
- fix DWC2 register backup
- add revert because of Raspberry Pi 3B+ regression
- add suspend/resume support for DMA & eMMC to be on the safe side

Changes in V3:
- added Reviewed-by & Acked-by from Florian & Ma=C3=ADra
- dropped applied pmdomain & bcm2835aux patches
- address comments by Ma=C3=ADra (patch 3 & 5)
- replace old USB recovery patch with canary approach [3], which should
  work with other platforms

Changes in V2:
- rebased against todays mainline
- added Reviewed-by from Florian
- added Acked-by from Minas
- dropped "irqchip/bcm2835: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND"
  because it has been applied by Thomas Gleixner
- dropped "pmdomain: raspberrypi-power: Avoid powering down USB"
  because this workaround has been replaced by patch 14
- use drm_err_once instead of DRM_ERROR and return connector_status_unknow=
n
  in patch 6
- add new patch in order to clean-up all DRM_ERROR
- add new patch to improve raspberrypi-power logging
- add new patch to simplify V3D clock retrieval
- add new patch 5 to avoid power down of wakeup devices
- add new patch 12 to avoid confusion about ACPI ID of BCM283x USB
- add new patch 8 & 10 which address the problem that HDMI
  is not functional after s2idle
- add more links and fix typo in patch 13
- add new WIP patch 14 which recover DWC2 register after power down
- take care of UART clock in patch 15 as commented by Florian
- use SYSTEM_SLEEP_PM_OPS in patch 15

[1] - https://github.com/lategoodbye/rpi-zero/issues/9
[2] - https://bugzilla.redhat.com/show_bug.cgi?id=3D2283978
[3] - https://lore.kernel.org/linux-usb/CAD=3DFV=3DW7sdi1+SHfhY6RrjK32r8iA=
Ge4w+O_u5Sp982vgBU6EQ@mail.gmail.com/
[4] - https://lore.kernel.org/dri-devel/20241003124107.39153-1-wahrenst@gm=
x.net/

Stefan Wahren (9):
  Revert "usb: dwc2: Skip clock gating on Broadcom SoCs"
  dmaengine: bcm2835-dma: add suspend/resume pm support
  mmc: bcm2835: Fix type of current clock speed
  mmc: bcm2835: Introduce proper clock handling
  mmc: bcm2835: add suspend/resume pm support
  usb: dwc2: gadget: Introduce register restore flags
  usb: dwc2: Refactor backup/restore of registers
  usb: dwc2: Implement recovery after PM domain off
  ARM: bcm2835_defconfig: Enable SUSPEND

 arch/arm/configs/bcm2835_defconfig |   2 -
 drivers/dma/bcm2835-dma.c          |  30 ++++++++
 drivers/mmc/host/bcm2835.c         |  56 +++++++++++---
 drivers/usb/dwc2/core.c            |   1 +
 drivers/usb/dwc2/core.h            |  23 +++++-
 drivers/usb/dwc2/gadget.c          | 116 +++++++++++++++--------------
 drivers/usb/dwc2/hcd.c             |  99 ++++++++++++------------
 drivers/usb/dwc2/params.c          |   1 -
 drivers/usb/dwc2/platform.c        |  38 ++++++++++
 9 files changed, 245 insertions(+), 121 deletions(-)

=2D-
2.34.1


