Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198D6266482
	for <lists+dmaengine@lfdr.de>; Fri, 11 Sep 2020 18:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIKQky (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Sep 2020 12:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgIKQki (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Sep 2020 12:40:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D323FC0613ED
        for <dmaengine@vger.kernel.org>; Fri, 11 Sep 2020 09:40:37 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGm62-0003P7-3X; Fri, 11 Sep 2020 18:40:22 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGm5y-0001wQ-An; Fri, 11 Sep 2020 18:40:18 +0200
Date:   Fri, 11 Sep 2020 18:40:18 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Message-ID: <20200911164018.6treqdmywzjhqe3a@pengutronix.de>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:59:11 up 301 days,  7:17, 296 users,  load average: 0.20, 0.15,
 0.05
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-09-01 00:03, Robin Gong wrote:
> There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> transfer to be send twice in DMA mode. Please get more information from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
> new sdma ram script which works in XCH  mode as PIO inside sdma instead
> of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should be
> exist on all legacy i.mx6/7 soc family before i.mx6ul.
> NXP fix this design issue from i.mx6ul, so newer chips including i.mx6ul/
> 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8 chips
> still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need errata
> or not.
> The first two reverted patches should be the same issue, though, it
> seems 'fixed' by changing to other shp script. Hope Sean or Sascha could
> have the chance to test this patch set if could fix their issues.
> Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
> on i.mx8mm because the event id is zero.
> 
> PS:
>    Please get sdma firmware from below linux-firmware and copy it to your
> local rootfs /lib/firmware/imx/sdma.
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma

Hi Robin,

I took your patches and did a few test on the mainline available
fsl,imx6q-sabrelite. I used a vanilla linux version v5.9-rc1 for all my
tests except the needed SPI-NOR patches [1]. Following are my results:

Testcase 1: "Using ROM-FW"
===
[OK] Playing Audio (SSI)
[OK] TX/RX bytes on a different UART (not the serial used for
     interaction)
[OK] Writing to the SPI-NOR
[OK] Doing all at the same time (once for TX and once for RX on UART)

Notes:
- Your Patches adding a maybe noise message "sdma firmware not ready".
  Maybe we should consider about that if it should be a warning or a info.

- For spi-nor I did run this test:
  dd if=/dev/urandom of=/var/tmp/test1M bs=1M count=1 && \
  flashcp -v /var/tmp/test1M /dev/mtd2

  and checked /proc/interrupts:
  25:    2107169          0          0          0       GPC  31 Level	2008000.spi

Testcase 2: "Using new FW from linux-firmware"
===
[OK] Playing Audio (SSI)
[OK] TX/RX bytes on a different UART (not the serial used for
     interaction)
[OK] Writing to the SPI-NOR
[OK] Doing all at the same time (once for TX and once for RX on UART)

Notes:
- For spi-nor I did run this test:
  dd if=/dev/urandom of=/var/tmp/test1M bs=1M count=1 && \
  flashcp -v /var/tmp/test1M /dev/mtd2

  and checked /proc/interrupts:
  25:    2107993          0          0          0       GPC  31 Level	2008000.spi

  I saw no SDMA interrupts during this testcase instead I saw only spi
  controller interrupts.

- According linux-firmware you did a version bump from 3.5 to 4.5 but my
  dmesg shows:
  imx-sdma 20ec000.sdma: loaded firmware 3.5

SPI Benchmark:
===
flash_erase /dev/mtd2 0 0 && \
	dd if=/dev/urandom of=/dev/mtd2 bs=1M count=1

- without firmware (ROM-FW)
  1048576 bytes (1.0 MB, 1.0 MiB) copied, 51.9713 s, 20.2 kB/s

- with firmware
  1048576 bytes (1.0 MB, 1.0 MiB) copied, 59.4174 s, 17.6 kB/s

Conclusion:
===
It seems that we don't have any performance boost with your patchset
instead we are increasing the complexity and the interrupts...

Pls let me know if I did something wrong during testing or if my test
setup was wrong. Note: the /dev/mtd2 isn't mainlined yet but if you use
barebox you only have to add:
8<---------------------------------------------------------------------
diff --git a/arch/arm/dts/imx6qdl-sabrelite.dtsi b/arch/arm/dts/imx6qdl-sabrelite.dtsi
index ec3d364bde..256dd90a0f 100644
--- a/arch/arm/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/dts/imx6qdl-sabrelite.dtsi
@@ -38,6 +38,11 @@
 		label = "barebox-environment";
 		reg = <0xe0000 0x20000>;
 	};
+
+	parition@100000 {
+		label = "user-partition";
+		reg = <0x100000 0x100000>;
+	};
 };
 
 &ocotp {
8<---------------------------------------------------------------------
to the barebox device tree.

[1] http://lists.infradead.org/pipermail/linux-mtd/2020-September/082099.html 

Regards,
  Marco
