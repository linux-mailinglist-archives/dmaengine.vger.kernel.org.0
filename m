Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558523C80F9
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 11:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbhGNJJA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 05:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbhGNJI6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jul 2021 05:08:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE7C061760
        for <dmaengine@vger.kernel.org>; Wed, 14 Jul 2021 02:06:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m3aq6-0004XS-9m; Wed, 14 Jul 2021 11:05:58 +0200
Message-ID: <8f8a307a2dc99ca3beab2767ac3188b4ba1a394f.camel@pengutronix.de>
Subject: Re: [PATCH v16 00/12] add ecspi ERR009165 for i.mx6/7 soc family
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        broonie@kernel.org, shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Date:   Wed, 14 Jul 2021 11:05:56 +0200
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod, Mark, Shawn,

with this revision I think this series is ready to be picked up, at
least I couldn't spot any blockers anymore.

How would you like to deal with this? While the complete series is
needed to fix the issues and restore proper DMA functionality on
unaffected SoCs, there are no dependencies between the patches
targeting different subsystems.
Do you prefer to pick dma/spi/dt patches from this series in your
respective trees, or do you want the whole series to go through the imx
tree? AFAICS all dma and spi patches are already acked, so taking them
through one tree would be possible, I think.

Regards,
Lucas

Am Mittwoch, dem 14.07.2021 um 18:20 +0800 schrieb Robin Gong:
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
> 
> v2:
>   1.Add commit log for reverted patches.
>   2.Add comment for 'ecspi_fixed' in sdma driver.
>   3.Add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
>     rather than remove.
> v3:
>   1.Confirm with design team make sure ERR009165 fixed on i.mx6ul/i.mx6ull
>     /i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy chips.
>     Correct dts related dts patch in v2.
>   2.Clean eratta information in binding doc and new 'tx_glitch_fixed' flag
>     in spi-imx driver to state ERR009165 fixed or not.
>   3.Enlarge burst size to fifo size for tx since tx_wml set to 0 in the
>     errata workaroud, thus improve performance as possible.
> v4:
>   1.Add Ack tag from Mark and Vinod
>   2.Remove checking 'event_id1' zero as 'event_id0'.
> v5:
>   1.Add the last patch for compatible with the current uart driver which
>     using rom script, so both uart ram script and rom script supported
>     in latest firmware, by default uart rom script used. UART driver
>     will be broken without this patch.
> v6:
>   1.Resend after rebase the latest next branch.
>   2.Remove below No.13~No.15 patches of v5 because they were mergered.
>   	ARM: dts: imx6ul: add dma support on ecspi
>   	ARM: dts: imx6sll: correct sdma compatible
>   	arm64: defconfig: Enable SDMA on i.mx8mq/8mm
>   3.Revert "dmaengine: imx-sdma: fix context cache" since
>     'context_loaded' removed.
> v7:
>   1.Put the last patch 13/13 'Revert "dmaengine: imx-sdma: fix context
>     cache"' to the ahead of 03/13 'Revert "dmaengine: imx-sdma: refine
>     to load context only once" so that no building waring during comes out
>     during bisect.
>   2.Address Sascha's comments, including eliminating any i.mx6sx in this
>     series, adding new 'is_imx6ul_ecspi()' instead imx in imx51 and taking
>     care SMC bit for PIO.
>   3.Add back missing 'Reviewed-by' tag on 08/15(v5):09/13(v7)
>    'spi: imx: add new i.mx6ul compatible name in binding doc'
> v8:
>   1.remove 0003-Revert-dmaengine-imx-sdma-fix-context-cache.patch and merge
>     it into 04/13 of v7
>   2.add 0005-spi-imx-fallback-to-PIO-if-dma-setup-failure.patch for no any
>     ecspi function broken even if sdma firmware not updated.
>   3.merge 'tx.dst_maxburst' changes in the two continous patches into one
>     patch to avoid confusion.
>   4.fix typo 'duplicated'.
> v9:
>   1. add "spi: imx: add dma_sync_sg_for_device after fallback from dma"
>      to fix the potential issue brought by commit bcd8e7761ec9("spi: imx:
>      fallback to PIO if dma setup failure") which is the only one patch
>      of v8 merged. Thanks Matthias for reporting:
>      https://lore.kernel.org/linux-arm-kernel/5d246dd81607bb6e5cb9af86ad4e53f7a7a99c50.camel@ew.tq-group.com/
>   2. remove 05/13 of v8 "spi: imx:fallback to PIO if dma setup failure"
>      since it's been merged.
> v10:
>   1. remove 01/13 "spi: imx: add dma_sync_sg_for_device after fallback from dma"
>      since there is another independent patch merged:
>      -- commit 809b1b04df898 ("spi: introduce fallback to pio")
>   2. add "dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script" which
>      is used to fix the potential dma_alloc_coherent() failure while this
>      patchset applied but sdma firmware may not be ready for long time.
>   3. burst size change back from fifo size to normal wml to align with nxp
>      internal tree which has been test for years. Overnight with loopback
>      test with spidev failed with fifo size, but pass with wml(half of fifo
>      size).Seems the whole fifo size fed may cause rxfifo overflow during
>      tx shift out while rx shift in.
>      "spi: imx: remove ERR009165 workaround on i.mx6ul"
>   4. remove 12/13 'dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm'
>      since below two similar patches merged:
>      -- commit 25962e1a7f1d ("dmaengine: imx-sdma: Fix the event id check to
>      include RX event for UART6")
>      -- commit 2f57b8d57673 ("dmaengine: imx-sdma: Fix: Remove 'always true'
>      comparison")
> v11:
>   1. change dev_err() to dev_warn_once() in case sdma firmware not loaded to
>      eliminate meaningless duplicate log print.
> v12:
>   1. take care uart_2_mcu_addr/uartsh_2_mcu_addr since such rom scripts are
>      now located in the bottom part of sdma_script_start_addrs which are beyond
>      the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1. Reported by Frieder as below:
>      https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2263544.html
> v13:
>   1. rebase with latest linux-next.
>   2. remove 09/12 'spi: imx: add new i.mx6ul compatible name in binding doc'
>      since it's been converted to yaml already.
>   3. add 'Fixes', 'Cc: stable@vger.kernel.org' and 'Test-by' tags for 03,04
>      since they are confirmed fix by Richard Leitner:
>      https://lkml.org/lkml/2020/8/17/39
>      https://www.spinics.net/lists/dmaengine/msg23489.html
>   4. fix potential descriptor free unexpected on the next transfer before
>      the last channel terminated:
>      https://www.spinics.net/lists/dmaengine/msg23400.html
> v14:
>   1. rebase with latest linux-next.
> 
> v15:
>   1. reuse IMX51_ECSPI type instead of new IMX6UL_ECSPI driver.
>   2. use mcu_2_app rom script directly instead of ram script on i.mx6ul.
> 
> v16:
>   1. move 'sdmac->is_ram_script = false' from sdma_config_write() to
>      sdma_get_pc() for addressing Lucas's concern.
> 
> Robin Gong (12):
>   Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
>   Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
>   Revert "dmaengine: imx-sdma: refine to load context only once"
>   dmaengine: imx-sdma: remove duplicated sdma_load_context
>   dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
>   dmaengine: imx-sdma: add mcu_2_ecspi script
>   spi: imx: fix ERR009165
>   spi: imx: remove ERR009165 workaround on i.mx6ul
>   dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
>   dma: imx-sdma: add i.mx6ul compatible name
>   dmaengine: imx-sdma: add uart rom script
>   dmaengine: imx-sdma: add terminated list for freed descriptor in
>     worker
> 
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
>  arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +-
>  drivers/dma/imx-sdma.c                             | 93 ++++++++++++++++------
>  drivers/spi/spi-imx.c                              | 41 ++++++++--
>  5 files changed, 111 insertions(+), 34 deletions(-)
> 


