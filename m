Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D547D1F1543
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2020 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgFHJTF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Jun 2020 05:19:05 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:59560 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgFHJTF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Jun 2020 05:19:05 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jun 2020 05:19:03 EDT
IronPort-SDR: pt4Yf9i22onVgCSOPow4dHUvGHzBkNVrdZiiLBXDO/NAjl8EX4eM7r8zVp9MdQHVVdg4zhsPsB
 /0XG8U8hH3wJME//zCTHJy/9bvIMoaEZCge0IlMgYDOO7uq5+ExzXxij4Y3gV7UKjHyk1TU0DV
 0ndI3mImEuGS/snk27gGIisFLCeTBZvYMV0526lPeVEMYDU0r3VwOTPgbyhLTmyaRwbSs4SnMY
 Em63hAXkICDQUTnuRvRjqFd7jKJ/ADd08jZWyT/ZrASCTZH/bAKkDXr97mAOudiG/WGZiNrlKY
 Sac=
X-IronPort-AV: E=Sophos;i="5.73,487,1583190000"; 
   d="scan'208";a="12590295"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Jun 2020 11:11:50 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 08 Jun 2020 11:11:50 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 08 Jun 2020 11:11:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591607510; x=1623143510;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VO1nBoZ7bk+RpVUra77pdQ1hNhawpKwhlNaeLjq1Wlc=;
  b=kmYb5HcYnCb+9YaQp7TQ3X3LUwp5MZNFP1I4e9bzlq7oxxrtIKI1Pldx
   5ouiEGi5mTeMQZHiBlCTgca9J7ccKSw9hflMEmAsUkEY7l8yAnRNpX7oQ
   8S1xLttFMKRupN/7naEKWsqbqrxBoO+OAHoG4YLVHEWstKSfcn/GHZIMQ
   DfO9cdFhQ8xyZpTDJo/GxO+/N761OqUMNtwDVvq5JZR78Fm1u6LLzCYyG
   KtaCd1pt0YPTJ7WFUUkPeX1skgk9ubf79DlWqQQIcmNr60NWGup6K3opf
   +vZtSotEG65FokY0AnJKmQEa0xu2M+BJwAHM8VS4D44pw8fcIYhZPs26f
   Q==;
IronPort-SDR: X5HsuEcNtuxhNljrHQjK2/+JUOAce/IvfRUV8SuQElkUf9b3h1paR88R0dMlq223kofmaNcKAE
 kniR/1qtpDx4pVQ/E8mYzZESdFpfDsE9SyVDqQ3RRldYuLo2ga+O5HmA1JLnwNz2xhGvm88h2g
 kx2WwAEBOqWgL96vI1lilIJ5JUO06bRLr8K7+VL/0RF8fEP0sntVOScyx5zPQdjYF9przdKSpO
 9PDmzS3IfRC3HBC2Aj3gPQhcGM/6lIXn1qapKHmY4sNUYnRdk8c05VaqIzxzeDt7gG0XCwBw9X
 T90=
X-IronPort-AV: E=Sophos;i="5.73,487,1583190000"; 
   d="scan'208";a="12590294"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2020 11:11:50 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3D110280065;
        Mon,  8 Jun 2020 11:11:56 +0200 (CEST)
Message-ID: <1b1b16ed993f5418f17e33dc291f13b83fa7b328.camel@ew.tq-group.com>
Subject: Re: (EXT) [PATCH v9 RESEND 00/13] add ecspi ERR009165 for i.mx6/7
 soc family
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, robh+dt@kernel.org, catalin.marinas@arm.com,
        vkoul@kernel.org, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Date:   Mon, 08 Jun 2020 11:11:48 +0200
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 2020-06-07 at 07:21 +0800, Robin Gong wrote:
> There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> transfer to be send twice in DMA mode. Please get more information
> from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is
> adding
> new sdma ram script which works in XCH  mode as PIO inside sdma
> instead
> of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should
> be
> exist on all legacy i.mx6/7 soc family before i.mx6ul.
> NXP fix this design issue from i.mx6ul, so newer chips including
> i.mx6ul/
> 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8
> chips
> still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need
> errata
> or not.
> The first two reverted patches should be the same issue, though, it
> seems 'fixed' by changing to other shp script. Hope Sean or Sascha
> could
> have the chance to test this patch set if could fix their issues.
> Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
> on i.mx8mm because the event id is zero.


Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>


> 
> PS:
>    Please get sdma firmware from below linux-firmware and copy it to
> your
> local rootfs /lib/firmware/imx/sdma.
> 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma
> 
> v2:
>   1.Add commit log for reverted patches.
>   2.Add comment for 'ecspi_fixed' in sdma driver.
>   3.Add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
>     rather than remove.
> v3:
>   1.Confirm with design team make sure ERR009165 fixed on
> i.mx6ul/i.mx6ull
>     /i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy
> chips.
>     Correct dts related dts patch in v2.
>   2.Clean eratta information in binding doc and new 'tx_glitch_fixed'
> flag
>     in spi-imx driver to state ERR009165 fixed or not.
>   3.Enlarge burst size to fifo size for tx since tx_wml set to 0 in
> the
>     errata workaroud, thus improve performance as possible.
> v4:
>   1.Add Ack tag from Mark and Vinod
>   2.Remove checking 'event_id1' zero as 'event_id0'.
> v5:
>   1.Add the last patch for compatible with the current uart driver
> which
>     using rom script, so both uart ram script and rom script
> supported
>     in latest firmware, by default uart rom script used. UART driver
>     will be broken without this patch.
> v6:
>   1.Resend after rebase the latest next branch.
>   2.Remove below No.13~No.15 patches of v5 because they were
> mergered.
>   	ARM: dts: imx6ul: add dma support on ecspi
>   	ARM: dts: imx6sll: correct sdma compatible
>   	arm64: defconfig: Enable SDMA on i.mx8mq/8mm
>   3.Revert "dmaengine: imx-sdma: fix context cache" since
>     'context_loaded' removed.
> v7:
>   1.Put the last patch 13/13 'Revert "dmaengine: imx-sdma: fix
> context
>     cache"' to the ahead of 03/13 'Revert "dmaengine: imx-sdma:
> refine
>     to load context only once" so that no building waring during
> comes out
>     during bisect.
>   2.Address Sascha's comments, including eliminating any i.mx6sx in
> this
>     series, adding new 'is_imx6ul_ecspi()' instead imx in imx51 and
> taking
>     care SMC bit for PIO.
>   3.Add back missing 'Reviewed-by' tag on 08/15(v5):09/13(v7)
>    'spi: imx: add new i.mx6ul compatible name in binding doc'
> v8:
>   1.remove 0003-Revert-dmaengine-imx-sdma-fix-context-cache.patch and
> merge
>     it into 04/13 of v7
>   2.add 0005-spi-imx-fallback-to-PIO-if-dma-setup-failure.patch for
> no any
>     ecspi function broken even if sdma firmware not updated.
>   3.merge 'tx.dst_maxburst' changes in the two continous patches into
> one
>     patch to avoid confusion.
>   4.fix typo 'duplicated'.
> v9:
>   1. add "spi: imx: add dma_sync_sg_for_device after fallback from
> dma"
>      to fix the potential issue brought by commit bcd8e7761ec9("spi:
> imx:
>      fallback to PIO if dma setup failure") which is the only one
> patch
>      of v8 merged. Thanks Matthias for reporting:
>      
> https://lore.kernel.org/linux-arm-kernel/5d246dd81607bb6e5cb9af86ad4e53f7a7a99c50.camel@ew.tq-group.com/
>   2. remove 05/13 of v8 "spi: imx:fallback to PIO if dma setup
> failure"
>      since it's been merged.
> 
> Robin Gong (13):
>   spi: imx: add dma_sync_sg_for_device after fallback from dma
>   Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
>   Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
>   Revert "dmaengine: imx-sdma: refine to load context only once"
>   dmaengine: imx-sdma: remove duplicated sdma_load_context
>   dmaengine: imx-sdma: add mcu_2_ecspi script
>   spi: imx: fix ERR009165
>   spi: imx: remove ERR009165 workaround on i.mx6ul
>   spi: imx: add new i.mx6ul compatible name in binding doc
>   dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
>   dma: imx-sdma: add i.mx6ul compatible name
>   dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
>   dmaengine: imx-sdma: add uart rom script
> 
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
>  arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +--
>  drivers/dma/imx-sdma.c                             | 67
> ++++++++++++--------
>  drivers/spi/spi-imx.c                              | 73
> +++++++++++++++++++---
>  include/linux/platform_data/dma-imx-sdma.h         |  8 ++-
>  7 files changed, 120 insertions(+), 40 deletions(-)
> 

