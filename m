Return-Path: <dmaengine+bounces-9019-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGmZAFshnWnuMwQAu9opvQ
	(envelope-from <dmaengine+bounces-9019-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 04:56:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5657E1817E7
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 04:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A13F0304C7E1
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 03:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FAD1C5F11;
	Tue, 24 Feb 2026 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jy81/F5N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m1973176.qiye.163.com (mail-m1973176.qiye.163.com [220.197.31.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB619E97F;
	Tue, 24 Feb 2026 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905364; cv=none; b=OCKVPLunGXdApGoqxMBCsyiWW85UfYrQmmRUpFhgAbNMYCKFjEGZqqBF4i8eDMs6s2Ym2kpCCHu/MXIRG88I+pKAmbMmK6akpf1TQRlfpFHWG4sGPXFCVrRWzRS94pDgKewgGJXoGLQ9AmwGlcVVOYPHYw0dOdJxnEAqXEt1lU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905364; c=relaxed/simple;
	bh=KoW38T6cNEmKidxotZXPZubVy4KOQgupYxDAJ1370F0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y5XubMPPbLGeHX8Fh2KZBVr3SxsA4/y5kqFIPvxtjD4X15XdyT4B0OWriZv2zm+E9bCaqByqmDMQY3u6N9M3p3w9TgwvdEOZgdlgPAqu8ka8a9cr3Dx7TDNNkLZvlaJL+THNv3ge+6Fih+5pvABqlZMaTf8aX7L0eqRQgZefC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jy81/F5N; arc=none smtp.client-ip=220.197.31.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b37f769;
	Mon, 23 Feb 2026 23:31:09 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Vinod Koul <vkoul@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Tian Tao <tiantao6@hisilicon.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Raag Jadav <raag.jadav@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	dmaengine@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-cxl@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org,
	mhi@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	linux-i2c@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	linux-spi@vger.kernel.org,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector management by removing devres auto-free
Date: Mon, 23 Feb 2026 23:29:39 +0800
Message-Id: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c8b20307709cckunm6946b3c79862a6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0oaHlZPHx5OTE0YQkJPHxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=jy81/F5Ni9q9/bSyZWlJabD1XxAXELPL9UhibFZyMz9WyzEiB5iEDVH0Ye8gCgDrz+TXTgJ8mWQ6QgQDO5+xpeOsxh+rOYDNTZc0JKdQU/fj9M+S4Jnb31IUAfPQnG6b/8K1G5LiNjlbXGROoXvc1DCKurZLBq/IoT1lOI+FLR8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=BcUR/HoijHqinvoMXUQVA7vidPdOPQAH0voVT1QIHOY=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9019-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,gmail.com,ffwll.ch,linux.intel.com,semihalf.com,zonque.org,linux.dev,rock-chips.com];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[87];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5657E1817E7
X-Rspamd-Action: no action

This patch series addresses a long-standing design issue in the PCI/MSI
subsystem where the implicit, automatic management of IRQ vectors by
the devres framework conflicts with explicit driver cleanup, creating
ambiguity and potential resource management bugs.

==== The Problem: Implicit vs. Explicit Management ====
Historically, `pcim_enable_device()` not only manages standard PCI resources
(BARs) via devres but also implicitly triggers automatic IRQ vector management
by setting a flag that registers `pcim_msi_release()` as a cleanup action.

This creates an ambiguous ownership model. Many drivers follow a pattern of:
1. Calling `pci_alloc_irq_vectors()` to allocate interrupts.
2. Also calling `pci_free_irq_vectors()` in their error paths or remove routines.

When such a driver also uses `pcim_enable_device()`, the devres framework may
attempt to free the IRQ vectors a second time upon device release, leading to
a double-free. Analysis of the tree shows this hazardous pattern exists widely,
while 35 other drivers correctly rely solely on the implicit cleanup.

==== The Solution: Making Management Explicit ====
This series enforces a clear, predictable model:
1.  New Managed API (Patch 1/37): Introduces pcim_alloc_irq_vectors() and
    pcim_alloc_irq_vectors_affinity(). Drivers that desire devres-managed IRQ
    vectors should use these functions, which set the is_msi_managed flag and
    ensure automatic cleanup.
2.  Patches 2 through 36 convert each driver that uses pcim_enable_device() alongside
    pci_alloc_irq_vectors() and relies on devres for IRQ vector cleanup to instead
    make an explicit call to pcim_alloc_irq_vectors().
3.  Core Change (Patch 37/37): With the former cleanup, now modifies pcim_setup_msi_release()
    to check only the is_msi_managed flag. This decouples automatic IRQ cleanup from
    pcim_enable_device(). IRQ vectors allocated via pci_alloc_irq_vectors*()
    are now solely the driver's responsibility to free with pci_free_irq_vectors().

With these changes, we clear ownership model: Explicit resource management eliminates
ambiguity and follows the "principle of least surprise." New drivers choose one model and
be consistent.
- Use `pci_alloc_irq_vectors()` + `pci_free_irq_vectors()` for explicit control.
- Use `pcim_alloc_irq_vectors()` for devres-managed, automatic cleanup.

==== Testing And Review ====
1. This series is only compiled test with allmodconfig.
2. Given the substantial size of this patch series, I have structured the mailing
   to facilitate efficient review. The cover letter, the first patch and the last one will be sent
   to all relevant mailing lists and key maintainers to ensure broad visibility and
   initial feedback on the overall approach. The remaining subsystem-specific patches
   will be sent only to the respective subsystem maintainers and their associated
   mailing lists, reducing noise.

Please help review it, much thanks!



Shawn Lin (37):
  PCI/MSI: Add Devres managed IRQ vectors allocation
  mmc: cavium: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  media: ipu6: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  gpio: merrifield: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  PCI: switchtec: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  PCI: vmd: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  spi: spi-pci1xxxx: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  spi: pxa2xx: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  i2c: amd-mp2: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  i2c: mchp-pci1xxxx: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  i2c: thunderx: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  i2c: designware: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  bus: mhi: host: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  serial: 8250_mid: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  serial: 8250_exar: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  platform/x86/intel: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  crypto: safexcel: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  crypto: octeontx2: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  cxl/pci: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
  drm/hisilicon/hibmc: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  iommu/riscv: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  thunderbolt: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  accel/amdxdna: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  accel/ivpu: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  accel/qaic: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  net: stmmac: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  r8169: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
  net: thunder_bgx: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  net: hibmcge: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  mfd: intel-lpss: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  dmaengine: hsu: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  dmaengine: hisilicon: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  i3c: mipi-i3c-hci-pci: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  HID: intel-ish-ipc: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  HID: Intel-thc-hid: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  misc: microchip: pci1xxxx: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  PCI/MSI: Only check is_msi_managed in pcim_setup_msi_release()

 drivers/accel/amdxdna/aie2_pci.c                   |  2 +-
 drivers/accel/ivpu/ivpu_drv.c                      |  2 +-
 drivers/accel/qaic/qaic_drv.c                      |  4 ++--
 drivers/bus/mhi/host/pci_generic.c                 |  3 ++-
 drivers/crypto/inside-secure/safexcel.c            |  8 +++----
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c |  2 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |  4 ++--
 drivers/cxl/pci.c                                  |  8 ++-----
 drivers/dma/hisi_dma.c                             |  3 +--
 drivers/dma/hsu/pci.c                              |  2 +-
 drivers/gpio/gpio-merrifield.c                     |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  4 ++--
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  2 +-
 .../intel-thc-hid/intel-quicki2c/pci-quicki2c.c    |  2 +-
 drivers/i2c/busses/i2c-amd-mp2-pci.c               |  2 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c         |  2 +-
 drivers/i2c/busses/i2c-mchp-pci1xxxx.c             |  2 +-
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |  2 +-
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c |  2 +-
 drivers/iommu/riscv/iommu-pci.c                    |  4 ++--
 drivers/media/pci/intel/ipu6/ipu6.c                |  2 +-
 drivers/mfd/intel-lpss-pci.c                       |  2 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c      |  2 +-
 drivers/mmc/host/cavium-thunderx.c                 |  2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |  4 ++--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c   |  4 ++--
 drivers/net/ethernet/realtek/r8169_main.c          |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |  6 ++---
 drivers/pci/controller/vmd.c                       |  4 ++--
 drivers/pci/msi/api.c                              | 26 ++++++++++++++++++++++
 drivers/pci/msi/msi.c                              |  4 +---
 drivers/pci/switch/switchtec.c                     |  6 ++---
 drivers/platform/x86/intel/ehl_pse_io.c            |  2 +-
 drivers/spi/spi-pci1xxxx.c                         |  4 ++--
 drivers/spi/spi-pxa2xx-pci.c                       |  2 +-
 drivers/thunderbolt/nhi.c                          |  6 ++---
 drivers/tty/serial/8250/8250_exar.c                |  2 +-
 drivers/tty/serial/8250/8250_mid.c                 |  2 +-
 include/linux/pci.h                                | 22 ++++++++++++++++++
 39 files changed, 104 insertions(+), 62 deletions(-)

-- 
2.7.4


