Return-Path: <dmaengine+bounces-3555-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4B9AF383
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1CF2844B8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8521731E;
	Thu, 24 Oct 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rlrONhmw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A51AF0B4;
	Thu, 24 Oct 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801149; cv=none; b=SOUwqOWX48JGZRhxPj4mD4f77QnXJGyqss4Uu/CiodK1RH10zcpOc6yjDADUhonbd1EyiYCFM8bANrDIr46FA7SeyHImLnJmTvOhJoBaP2y85Yg3ZLSK6jt3n+zONipuecSzu7/QMtFCC+V27PrP1kQIrOP+VagoSkyL0fmqOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801149; c=relaxed/simple;
	bh=chFReANjoFbR/EOWjbngDVwAhvRT0iFTXIz7TOSRJ9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CAqulrK7/unphW3XCr+1aVOUTPYLA4cqfKnyZL9q6F4Jtdh8d8NsdTP3y4l/CfPJzQwFpZds456NHRf9g4a9vPU2yUPSXOqJo36JTC0rkptKf6tvLXY+qykr67UiEEcNEWnvJZ6J44q/H2ZZt7wl4JMf9KfBdtFfkM1plkhG6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rlrONhmw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729801124; x=1730405924; i=wahrenst@gmx.net;
	bh=PtKUSt76TFKjgPtCZaStNyJsHewdsH1Gq+qwbgfGJx8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rlrONhmwbFBMDJKoPv7/3S8ucoq8BpWiyXHArNOD0qLSPPtmuOdxfF5EgxBpuKW/
	 9J8DJigZKKNrYZEXIRBe3yNMRK7QZ/3IsDgwdCCCzu9qZ/mlk4MyXa2VX6wJMGysh
	 /QzYMnsQWwCIefYg+hkM3LDl1aWPYJUPJBg5daPca9ebtbXurkoK+g7NOCNi9R1gq
	 MrSRcmaGX7uAwM39FYWcpwLG/7T1q9VujvmfSydAaskfkYtE3wW93Z6MsYMUGl8Pp
	 +zJQqun4VaiD5Lswu3XuSLtZmBHbkmfpfAb5nIOcmV5Ota2hk1b76GOGtU56pZ2vo
	 DvQAy9UWLM8c+dRdZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KUd-1txFAw4ArR-011077; Thu, 24
 Oct 2024 22:18:44 +0200
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
Subject: [PATCH V4 0/9] ARM: bcm2835: Implement initial S2Idle for Raspberry Pi
Date: Thu, 24 Oct 2024 22:18:28 +0200
Message-Id: <20241024201837.79927-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rosCn8TgOlNX2wametBtbGfMR3eZDUEXXPwiriDu32upykHIbic
 fmHLinS3U/6xb+TnrijjccDbOy+PuE0qo0vcUD9UtfC9SmhV9YbRTPes6pCbNTV1hbWQboi
 xmultiPaTtGtOyJy61yd0l119nB0C0do3BVrwBk82iyWX3nTK+yiTZfrGVYxqo9ejRvrGab
 6EPxyxEReps4d5ikwEaWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YfEKRit8jiw=;FeQV+C8u75T71joCCUHYJpSuo6j
 dVoyWYKoS64cdQrsUzi0FsUvSdGAk/T1M/7fwBroYoNSLEa8CvbGkhN2+kK91aHnbaEJP1cc3
 +6ExxHSs9l3GqKSR1Iiu2XQ3nR5gqVuYOAhcLUdqeLwlyvCWr5lhUMOF3GdImaACDmHdFXHqm
 8KVM2wa7osHrv0rZ7qIHFwu1SKcDbxL8i/escMhPsDrqWQtqDH1WSiCOgM1GeLsOYtUeW4qHT
 70fW0CPWf/gTkkk7cs2UY2V0DYTqoqqO9g1DLnoI48e2b9kjwa9WADZ1JWpJ7iQwq77ApHpYl
 qV3zzPup9/LVMrMG1CTokPj46b3+jGAwjqMvTtrMRAtYgfnqHLyvWwuT4hO6wp2V5Q6qd8pbd
 b5fK328iuukzfE+JcB5DEc/QyvfdKGoska/uGfCRQzIRry0IXOK+LOj7T9SDyU9SgxxuVhjT7
 og0TKRETaSmIHqkL3TEyEmPqJRevP2Hd3qphEJGPHj92gjF3WrZejLVHD9VjBhF4ReXJ+TLFA
 OrKqYMwBBHk9eeuBMMskVvZfUn4Faj3PyjM7r8X7S7c1YaK2Uwv34TGLQATfujU8laIrFHnrX
 M09gxJ2Q3L+Tt8MpImar/ZFxBalNlRLwygr0N5KMGYoJRNm44qo8N9deqlqEYEuaPFY3yiTIe
 hYz/yvcwu2HRRPi3SRchyJs3n8YcDPRlQl4j3dUGIUprkDkShRDP+AyjEV49CKwE5TZ5vEP35
 t6xQN8THJqHtCSsQNADz33RFMbILsmzCSXtn34T9YzAHWiHb3l+ahvRs265N+Ct8L4gNhU0EF
 oWEiNGofT+7kXgM7XfobRyDA==

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


