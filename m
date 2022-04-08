Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C564F8CCD
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 05:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiDHBZT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 21:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiDHBZT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 21:25:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29BB1560B4;
        Thu,  7 Apr 2022 18:23:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g20so8396185edw.6;
        Thu, 07 Apr 2022 18:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6GIjfl38828TDx/Er/l1ydNAbsDZX6DyamisKv9xlI=;
        b=O8z6RVsDroCjPfHv/rRZ7ILks4hW8GgdUuvtwRzcLa7aaepbm3bE6m+mpb2Tik4RCh
         b/0ka341wHE+Mpxj72S95ZIxb7gnMPbKDSVercfbkn6nKVJ3QnSzXuiZ45s4C9/AraOA
         YFrDlA0bUoxTRDAVDZ38CkhO7TD8ROjmnFYTVT5y7ur8q+49njhBxooxb29brEqcVjrH
         zM45MKYK+MTJ41h0BznFCDIpl74lZ4qqVaB3iSLoDr6CT18gNXWMTA+f9WzZhRaiVXv2
         0JdvTHfmtLcxifq6sBUpXFdo97AkszWt2pTn/8ITXzulkiogiZLj8Rq+PLZg/6uy+vDG
         ZFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6GIjfl38828TDx/Er/l1ydNAbsDZX6DyamisKv9xlI=;
        b=yjI1JglrfmrXrTl5aeNIxS62oEjLK6ZaZbg4j1Ydyi+iGuqseY8nTJpjGdIG/9OFR7
         BxaLB4iIri4sR+zknApqzSfnlLIIS/gy4OLUxr+4mEP4+mUobsX+KjkDSzJkRB86QSuE
         GZmS0aOzMi3pdXxlUupkvK6zfdaOCWnEzM42MGWnDJQwqVvaeESKws4XQ3jc1iXaKMbp
         QNqBXGkuG95QImCRpVD7UggbkNIlFfLvrjC8BdTKcbdN65HaT2khF2Yabjjmqgp6jKxu
         pwUge+RoM2tJZxF1pz2/zQniGCgWRi1iAW3GrTGM2L2faJuzK4La/qj2tv1rVEIMH098
         eE5A==
X-Gm-Message-State: AOAM533jd9R4mAII6p0yyP+e1jnXgtMcKs+hNYMK0KbFGsD614FqDacf
        aWfVw6Wr6Uol13ZEO9FrY1Y6tqQMrSylwodHOSw=
X-Google-Smtp-Source: ABdhPJxz/9ig7zQdygj91MyAfQi9EI8Vsso7YJ4STSYEAI15UX+5nGgqlSfnECcaXfW9w6++A479MAK1M3k/ugQkZt8=
X-Received: by 2002:a05:6402:190d:b0:41b:a70d:1367 with SMTP id
 e13-20020a056402190d00b0041ba70d1367mr16907289edz.155.1649380996125; Thu, 07
 Apr 2022 18:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
In-Reply-To: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 7 Apr 2022 22:23:03 -0300
Message-ID: <CAOMZO5CbTUTkoFCKwrpT5h7CfHxbLtci1qAtMwkAi_LD_5yeyQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix regression with uart scripts
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On Wed, Apr 6, 2022 at 7:48 PM Kevin Groeneveld
<kgroeneveld@lenbrook.com> wrote:
>
> Commit b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script") broke
> uart rx on imx5 when using sdma firmware from older Freescale 2.6.35
> kernel. In this case reading addr->uartXX_2_mcu_addr was going out of
> bounds of the firmware memory and corrupting the uart script addresses.
>
> Simply adding a bounds check before accessing addr->uartXX_2_mcu_addr
> does not work as the uartXX_2_mcu_addr members are now beyond the size
> of the older firmware and the uart addresses would never be populated
> in that case. There are other ways to fix this but overall the logic
> seems clearer to me to revert the uartXX_2_mcu_ram_addr structure
> entries back to uartXX_2_mcu_addr, change the newer entries to
> uartXX_2_mcu_rom_addr and update the logic accordingly.
>
> Fixes: b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script")
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
