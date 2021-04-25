Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5B536A508
	for <lists+dmaengine@lfdr.de>; Sun, 25 Apr 2021 08:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhDYGPl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 25 Apr 2021 02:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhDYGPk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 25 Apr 2021 02:15:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 742AD6124B;
        Sun, 25 Apr 2021 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619331300;
        bh=auP6JRuummQkkVZR1IcxBPxBUP5jCkGA0V99FK4ibXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSZo7B0ztK/ZJ6b9ewVhX1tiYoKt2aVWLM9tzkidgo8bd4NahwbZgSelW2qjvkeVA
         4Cuf22JgyanY8g/eHylN+oOyZzH/JbOFwp+a8b6jGIdQW2D6lhpPLcxUewADOVt59p
         BfKGkxp270f1RqpnNZxbM7mATC8gj00Vgsj6eMUA=
Date:   Sun, 25 Apr 2021 08:14:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] firmware: replace HOTPLUG with UEVENT in FW_ACTION
 defines
Message-ID: <YIUI3TZf/sZ6Sd3K@kroah.com>
References: <20210425020024.28057-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425020024.28057-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Apr 25, 2021 at 10:00:24AM +0800, Shawn Guo wrote:
> With commit 312c004d36ce ("[PATCH] driver core: replace "hotplug" by
> "uevent"") already in the tree over a decade, update the name of
> FW_ACTION defines to follow semantics, and reflect what the defines are
> really meant for, i.e. whether or not generate user space event.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/dma/imx-sdma.c                      |  2 +-
>  drivers/media/platform/exynos4-is/fimc-is.c |  2 +-
>  drivers/mfd/iqs62x.c                        |  2 +-
>  drivers/misc/lattice-ecp3-config.c          |  2 +-
>  drivers/net/wireless/ti/wlcore/main.c       |  2 +-
>  drivers/platform/x86/dell/dell_rbu.c        |  2 +-
>  drivers/remoteproc/remoteproc_core.c        |  2 +-
>  drivers/scsi/lpfc/lpfc_init.c               |  2 +-
>  drivers/tty/serial/ucc_uart.c               |  2 +-
>  include/linux/firmware.h                    |  4 ++--
>  lib/test_firmware.c                         | 10 +++++-----
>  sound/soc/codecs/wm8958-dsp2.c              |  6 +++---
>  12 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index d5590c08db51..e2b559945c11 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1829,7 +1829,7 @@ static int sdma_get_firmware(struct sdma_engine *sdma,
>  	int ret;
>  
>  	ret = request_firmware_nowait(THIS_MODULE,
> -			FW_ACTION_HOTPLUG, fw_name, sdma->dev,
> +			FW_ACTION_UEVENT, fw_name, sdma->dev,

Naming is hard :)

I can take this after -rc1, but really, is it needed?

What problem does this renaming solve?  Who is the current name
confusing?

thanks,

greg k-h
