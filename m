Return-Path: <dmaengine+bounces-3472-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDC29AE72F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C884FB2381A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D11E104E;
	Thu, 24 Oct 2024 14:04:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65231D5ACC;
	Thu, 24 Oct 2024 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.104.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778676; cv=none; b=YMGLx6zS2BlEzZQilTDeieUWZjqbWn4xRmnoNQUEyUJux69ytu1SZvbMjcfNfk3LIVu8eiB4N2RFg2xBIrAaF1cDotowdwNSg8Wg+fzVMZHJjYriGeSRABXqT4mvt9/MAnR375Dd4XWr8dsJB3w8RHevYaRwqrAuJY0DE3YKTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778676; c=relaxed/simple;
	bh=DuN4mUXGpKtjsfh4IPC3NEefzqbLB4j+vXm91RftpnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzADEtmqSv7xV7M7eXqdWaMZxx34u9xaHzDxF7ghl8GRg4ZuLOIyJxjoV45fqn5ERbywAT0oRUFo/TeSmIKiQ4+cjEePsiOqrNE9106lepFuY2/fsi3tAmgDn+s9/+n4NY+d36nhGRondbAdn0LdxOa1S63cICAAe79MoK3b9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kremlin.ru; spf=fail smtp.mailfrom=kremlin.ru; arc=none smtp.client-ip=148.135.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kremlin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kremlin.ru
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72B125E5D8;
	Thu, 24 Oct 2024 10:04:19 -0400 (EDT)
From: Vladimir Vladimirovich Putin <vladimir_putin_rus@kremlin.ru>
To: torvalds@linux-foundation.org
Cc: aospan@netup.ru,
	conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com,
	netdev@vger.kernel.org,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	patches@lists.linux.dev,
	richard.henderson@linaro.org,
	s.shtylyov@omp.ru,
	serjk@netup.ru,
	shc_work@mail.ru,
	torvic9@mailbox.org,
	tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru,
	wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com,
	xeb@mail.ru,
	LKML <linux-kernel@vger.kernel.org>,
	Vladimir Vladimirovich Putin <vladimir_putin_rus@kremlin.ru>
Subject: [PATCH 1/2] MAINTAINERS: Remove Huawei due to compilance requirements.
Date: Thu, 24 Oct 2024 22:03:52 +0800
Message-ID: <20241024140353.384881-2-vladimir_putin_rus@kremlin.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024140353.384881-1-vladimir_putin_rus@kremlin.ru>
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <20241024140353.384881-1-vladimir_putin_rus@kremlin.ru>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Huawei Corp was added to the US Entity List[1] on 08/20/2020.

The Entity List is a trade restriction list published by the United
States Department of Commerce's Bureau of Industry and Security (BIS),
consisting of certain foreign persons, entities, or governments.
It is published as Supplement 4 of Part 744 of the Code
of Federal Regulations. [2]

[1]: https://www.federalregister.gov/documents/2020/08/20/2020-18213/
addition-of-huawei-non-us-affiliates-to-the-entity-list-the-removal-of
-temporary-general-license-and
[2]: https://en.wikipedia.org/wiki/Entity_List

Signed-off-by: Vladimir Vladimirovich Putin <vladimir_putin_rus@kremlin.ru>
---
 MAINTAINERS | 46 ----------------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb3..725a72e17a4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -322,7 +322,6 @@ F:	tools/power/acpi/
 
 ACPI FOR ARM64 (ACPI/arm64)
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
-M:	Hanjun Guo <guohanjun@huawei.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -3873,7 +3872,6 @@ F:	Documentation/filesystems/befs.rst
 F:	fs/befs/
 
 BFQ I/O SCHEDULER
-M:	Yu Kuai <yukuai3@huawei.com>
 L:	linux-block@vger.kernel.org
 S:	Odd Fixes
 F:	Documentation/block/bfq-iosched.rst
@@ -4038,7 +4036,6 @@ BPF JIT for ARM64
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Puranjay Mohan <puranjay@kernel.org>
-R:	Xu Kuohai <xukuohai@huaweicloud.com>
 L:	bpf@vger.kernel.org
 S:	Supported
 F:	arch/arm64/net/
@@ -4082,7 +4079,6 @@ X:	arch/riscv/net/bpf_jit_comp64.c
 
 BPF JIT for RISC-V (64-bit)
 M:	Björn Töpel <bjorn@kernel.org>
-R:	Pu Lehui <pulehui@huawei.com>
 R:	Puranjay Mohan <puranjay@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Maintained
@@ -5697,7 +5693,6 @@ F:	include/linux/compiler_attributes.h
 
 COMPUTE EXPRESS LINK (CXL)
 M:	Davidlohr Bueso <dave@stgolabs.net>
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 M:	Dave Jiang <dave.jiang@intel.com>
 M:	Alison Schofield <alison.schofield@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
@@ -5712,7 +5707,6 @@ F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
 COMPUTE EXPRESS LINK PMU (CPMU)
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/perf/cxl.rst
@@ -8525,7 +8519,6 @@ F:	include/uapi/linux/ext4.h
 
 Extended Verification Module (EVM)
 M:	Mimi Zohar <zohar@linux.ibm.com>
-M:	Roberto Sassu <roberto.sassu@huawei.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
@@ -10189,21 +10182,17 @@ F:	net/dsa/tag_hellcreek.c
 
 HISILICON DMA DRIVER
 M:	Zhou Wang <wangzhou1@hisilicon.com>
-M:	Jie Hai <haijie1@huawei.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/hisi_dma.c
 
 HISILICON GPIO DRIVER
-M:	Jay Fang <f.fangjian@huawei.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
 F:	drivers/gpio/gpio-hisi.c
 
 HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
-M:	Zhiqi Song <songzhiqi1@huawei.com>
-M:	Longfang Liu <liulongfang@huawei.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/debugfs-hisi-hpre
@@ -10212,7 +10201,6 @@ F:	drivers/crypto/hisilicon/hpre/hpre_crypto.c
 F:	drivers/crypto/hisilicon/hpre/hpre_main.c
 
 HISILICON HNS3 PMU DRIVER
-M:	Jijie Shao <shaojijie@huawei.com>
 S:	Supported
 F:	Documentation/admin-guide/perf/hns3-pmu.rst
 F:	drivers/perf/hisilicon/hns3_pmu.c
@@ -10226,31 +10214,24 @@ F:	Documentation/devicetree/bindings/i2c/hisilicon,ascend910-i2c.yaml
 F:	drivers/i2c/busses/i2c-hisi.c
 
 HISILICON KUNPENG SOC HCCS DRIVER
-M:	Huisong Li <lihuisong@huawei.com>
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
 F:	drivers/soc/hisilicon/kunpeng_hccs.c
 F:	drivers/soc/hisilicon/kunpeng_hccs.h
 
 HISILICON LPC BUS DRIVER
-M:	Jay Fang <f.fangjian@huawei.com>
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
 F:	drivers/bus/hisi_lpc.c
 
 HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
-M:	Jian Shen <shenjian15@huawei.com>
-M:	Salil Mehta <salil.mehta@huawei.com>
-M:	Jijie Shao <shaojijie@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/net/ethernet/hisilicon/hns3/
 
 HISILICON NETWORK SUBSYSTEM DRIVER
-M:	Jian Shen <shenjian15@huawei.com>
-M:	Salil Mehta <salil.mehta@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com
@@ -10259,7 +10240,6 @@ F:	drivers/net/ethernet/hisilicon/
 
 HISILICON PMU DRIVER
 M:	Yicong Yang <yangyicong@hisilicon.com>
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 S:	Supported
 W:	http://www.hisilicon.com
 F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -10268,7 +10248,6 @@ F:	drivers/perf/hisilicon
 
 HISILICON PTT DRIVER
 M:	Yicong Yang <yangyicong@hisilicon.com>
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
@@ -10279,7 +10258,6 @@ F:	tools/perf/util/hisi-ptt*
 F:	tools/perf/util/hisi-ptt-decoder/*
 
 HISILICON QM DRIVER
-M:	Weili Qian <qianweili@huawei.com>
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
@@ -10290,7 +10268,6 @@ F:	drivers/crypto/hisilicon/sgl.c
 F:	include/linux/hisi_acc_qm.h
 
 HISILICON ROCE DRIVER
-M:	Chengchang Tang <tangchengchang@huawei.com>
 M:	Junxian Huang <huangjunxian6@hisilicon.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
@@ -10298,14 +10275,12 @@ F:	Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
 F:	drivers/infiniband/hw/hns/
 
 HISILICON SAS Controller
-M:	Yihang Li <liyihang9@huawei.com>
 S:	Supported
 W:	http://www.hisilicon.com
 F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
 F:	drivers/scsi/hisi_sas/
 
 HISILICON SECURITY ENGINE V2 DRIVER (SEC2)
-M:	Longfang Liu <liulongfang@huawei.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/debugfs-hisi-sec
@@ -10315,39 +10290,33 @@ F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
 F:	drivers/crypto/hisilicon/sec2/sec_main.c
 
 HISILICON SPI Controller DRIVER FOR KUNPENG SOCS
-M:	Jay Fang <f.fangjian@huawei.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/spi/spi-hisi-kunpeng.c
 
 HISILICON SPMI CONTROLLER DRIVER FOR HIKEY 970
-M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
 F:	drivers/spmi/hisi-spmi-controller.c
 
 HISILICON SPMI PMIC DRIVER FOR HIKEY 6421v600
-M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 F:	drivers/mfd/hi6421-spmi-pmic.c
 
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
-M:	Weili Qian <qianweili@huawei.com>
 S:	Maintained
 F:	drivers/crypto/hisilicon/trng/trng.c
 
 HISILICON V3XX SPI NOR FLASH Controller Driver
-M:	Jay Fang <f.fangjian@huawei.com>
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/spi/spi-hisi-sfc-v3xx.c
 
 HISILICON ZIP Controller DRIVER
-M:	Yang Shen <shenyang39@huawei.com>
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
@@ -10477,8 +10446,6 @@ HUAWEI ETHERNET DRIVER
 M:	Cai Huoqing <cai.huoqing@linux.dev>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst
-F:	drivers/net/ethernet/huawei/hinic/
 
 HUGETLB SUBSYSTEM
 M:	Muchun Song <muchun.song@linux.dev>
@@ -10504,7 +10471,6 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/platform/st/sti/hva
 
 HWPOISON MEMORY FAILURE HANDLING
-M:	Miaohe Lin <linmiaohe@huawei.com>
 R:	Naoya Horiguchi <nao.horiguchi@gmail.com>
 L:	linux-mm@kvack.org
 S:	Maintained
@@ -11243,7 +11209,6 @@ F:	drivers/crypto/inside-secure/
 
 INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
 M:	Mimi Zohar <zohar@linux.ibm.com>
-M:	Roberto Sassu <roberto.sassu@huawei.com>
 M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
 R:	Eric Snowberg <eric.snowberg@oracle.com>
 L:	linux-integrity@vger.kernel.org
@@ -12447,7 +12412,6 @@ M:	Marc Zyngier <maz@kernel.org>
 M:	Oliver Upton <oliver.upton@linux.dev>
 R:	Joey Gouly <joey.gouly@arm.com>
 R:	Suzuki K Poulose <suzuki.poulose@arm.com>
-R:	Zenghui Yu <yuzenghui@huawei.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	kvmarm@lists.linux.dev
 S:	Maintained
@@ -20497,7 +20461,6 @@ F:	drivers/iio/chemical/ens160.h
 
 SCSI LIBSAS SUBSYSTEM
 R:	John Garry <john.g.garry@oracle.com>
-R:	Jason Yan <yanaijie@huawei.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	Documentation/scsi/libsas.rst
@@ -21303,7 +21266,6 @@ F:	include/linux/property.h
 
 SOFTWARE RAID (Multiple Disks) SUPPORT
 M:	Song Liu <song@kernel.org>
-R:	Yu Kuai <yukuai3@huawei.com>
 L:	linux-raid@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-raid/list/
@@ -23549,7 +23511,6 @@ F:	include/uapi/misc/uacce/
 
 UBI FILE SYSTEM (UBIFS)
 M:	Richard Weinberger <richard@nod.at>
-R:	Zhihao Cheng <chengzhihao1@huawei.com>
 L:	linux-mtd@lists.infradead.org
 S:	Supported
 W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
@@ -23699,7 +23660,6 @@ F:	drivers/ufs/host/ufs-renesas.c
 
 UNSORTED BLOCK IMAGES (UBI)
 M:	Richard Weinberger <richard@nod.at>
-R:	Zhihao Cheng <chengzhihao1@huawei.com>
 L:	linux-mtd@lists.infradead.org
 S:	Supported
 W:	http://www.linux-mtd.infradead.org/
@@ -23803,7 +23763,6 @@ S:	Maintained
 F:	drivers/usb/roles/intel-xhci-usb-role-switch.c
 
 USB IP DRIVER FOR HISILICON KIRIN 960
-M:	Yu Chen <chenyu56@huawei.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
@@ -24183,8 +24142,6 @@ S:	Orphan
 F:	drivers/vfio/fsl-mc/
 
 VFIO HISILICON PCI DRIVER
-M:	Longfang Liu <liulongfang@huawei.com>
-M:	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/pci/hisilicon/
@@ -24213,7 +24170,6 @@ F:	drivers/vfio/pci/nvgrace-gpu/
 VFIO PCI DEVICE SPECIFIC DRIVERS
 R:	Jason Gunthorpe <jgg@nvidia.com>
 R:	Yishai Hadas <yishaih@nvidia.com>
-R:	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
 R:	Kevin Tian <kevin.tian@intel.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
@@ -24395,7 +24351,6 @@ F:	tools/virtio/
 F:	tools/testing/selftests/drivers/net/virtio_net/
 
 VIRTIO CRYPTO DRIVER
-M:	Gonglei <arei.gonglei@huawei.com>
 L:	virtualization@lists.linux.dev
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
@@ -25481,7 +25436,6 @@ F:	drivers/input/misc/yealink.*
 
 Z3FOLD COMPRESSED PAGE ALLOCATOR
 M:	Vitaly Wool <vitaly.wool@konsulko.com>
-R:	Miaohe Lin <linmiaohe@huawei.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/z3fold.c
-- 
2.47.0


