Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20E0225BD2
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jul 2020 11:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGTJh5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 20 Jul 2020 05:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgGTJh4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jul 2020 05:37:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D40C061794
        for <dmaengine@vger.kernel.org>; Mon, 20 Jul 2020 02:37:56 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jxSF6-0005P5-Ui; Mon, 20 Jul 2020 11:37:52 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jxSF5-0005vr-7y; Mon, 20 Jul 2020 11:37:51 +0200
Message-ID: <636380f452ff696ab4505ad09dcea951283be06b.camel@pengutronix.de>
Subject: Re: [Patch v1 2/4] dma: tegra: Adding Tegra GPC DMA controller
 driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rajesh Gumasta <rgumasta@nvidia.com>, ldewangan@nvidia.com,
        jonathanh@nvidia.com, vkoul@kernel.org, dan.j.williams@intel.com,
        thierry.reding@gmail.com, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kyarlagadda@nvidia.com, Pavan Kunapuli <pkunapuli@nvidia.com>
Date:   Mon, 20 Jul 2020 11:37:51 +0200
In-Reply-To: <1595226856-19241-3-git-send-email-rgumasta@nvidia.com>
References: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
         <1595226856-19241-3-git-send-email-rgumasta@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rajesh,

On Mon, 2020-07-20 at 12:04 +0530, Rajesh Gumasta wrote:
> +
> +       tdma->rst = devm_reset_control_get(&pdev->dev, "gpcdma");

Please use devm_reset_control_get_exclusive() directly.

> +       if (IS_ERR(tdma->rst)) {
> +               dev_err(&pdev->dev, "Missing controller reset\n");

You might want to suppress this message if the error is EPROBE_DEFER.

> +               return PTR_ERR(tdma->rst);
> +       }
> +       reset_control_reset(tdma->rst);

regards
Philipp
